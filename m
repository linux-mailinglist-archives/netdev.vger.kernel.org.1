Return-Path: <netdev+bounces-54438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9772807113
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 14:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8809AB20DDB
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 13:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AA83A278;
	Wed,  6 Dec 2023 13:44:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F1CC3
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 05:44:36 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-107-VjYTwxkCMn6SwTuODnoAhQ-1; Wed, 06 Dec 2023 13:44:34 +0000
X-MC-Unique: VjYTwxkCMn6SwTuODnoAhQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 6 Dec
 2023 13:44:21 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 6 Dec 2023 13:44:21 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David
 S. Miller" <davem@davemloft.net>, Stephen Hemminger
	<stephen@networkplumber.org>, David Ahern <dsahern@kernel.org>,
	"jakub@cloudflare.com" <jakub@cloudflare.com>, Eric Dumazet
	<edumazet@google.com>, 'Mat Martineau' <martineau@kernel.org>
Subject: [PATCH net-next v2] Use READ/WRITE_ONCE() for IP local_port_range.
Thread-Topic: [PATCH net-next v2] Use READ/WRITE_ONCE() for IP
 local_port_range.
Thread-Index: AdooSO1rKbigixn8TQmlwlGOFRd92g==
Date: Wed, 6 Dec 2023 13:44:20 +0000
Message-ID: <4e505d4198e946a8be03fb1b4c3072b0@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Commit 227b60f5102cd added a seqlock to ensure that the low and high
port numbers were always updated together.
This is overkill because the two 16bit port numbers can be held in
a u32 and read/written in a single instruction.

More recently 91d0b78c5177f added support for finer per-socket limits.
The user-supplied value is 'high << 16 | low' but they are held
separately and the socket options protected by the socket lock.

Use a u32 containing 'high << 16 | low' for both the 'net' and 'sk'
fields and use READ_ONCE()/WRITE_ONCE() to ensure both values are
always updated together.

Change (the now trival) inet_get_local_port_range() to a static inline
to optimise the calling code.
(In particular avoiding returning integers by reference.)

Signed-off-by: David Laight <david.laight@aculab.com>
---
Changes for v2:
- minor layout changes.
- remove unlikely() from comparisons when per-socket range set.
- avoid shifts of signed values that generate unsigned 32bit results.
I fiddled with the code that validates the argument to IP_LOCAL_PORT_RANGE
then decided to leave it (mostly) unchanged because it is also moved.
(There is a 'u16 x =3D int_val >> 16' which is required to move bit 31 to
bit 15 and is probably undefined behaviour - but will be ok on all sane cpu=
.)

 include/net/inet_sock.h         |  5 +----
 include/net/ip.h                |  8 +++++++-
 include/net/netns/ipv4.h        |  3 +--
 net/ipv4/af_inet.c              |  4 +---
 net/ipv4/inet_connection_sock.c | 29 ++++++++++-------------------
 net/ipv4/ip_sockglue.c          | 33 ++++++++++++++++-----------------
 net/ipv4/sysctl_net_ipv4.c      | 18 +++++++-----------
 7 files changed, 43 insertions(+), 57 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 74db6d97cae1..aa86453f6b9b 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -234,10 +234,7 @@ struct inet_sock {
 =09int=09=09=09uc_index;
 =09int=09=09=09mc_index;
 =09__be32=09=09=09mc_addr;
-=09struct {
-=09=09__u16 lo;
-=09=09__u16 hi;
-=09}=09=09=09local_port_range;
+=09u32=09=09=09local_port_range;=09/* high << 16 | low */
=20
 =09struct ip_mc_socklist __rcu=09*mc_list;
 =09struct inet_cork_full=09cork;
diff --git a/include/net/ip.h b/include/net/ip.h
index 1fc4c8d69e33..b31be912489a 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -349,7 +349,13 @@ static inline u64 snmp_fold_field64(void __percpu *mib=
, int offt, size_t syncp_o
 =09} \
 }
=20
-void inet_get_local_port_range(const struct net *net, int *low, int *high)=
;
+static inline void inet_get_local_port_range(const struct net *net, int *l=
ow, int *high)
+{
+=09u32 range =3D READ_ONCE(net->ipv4.ip_local_ports.range);
+
+=09*low =3D range & 0xffff;
+=09*high =3D range >> 16;
+}
 void inet_sk_get_local_port_range(const struct sock *sk, int *low, int *hi=
gh);
=20
 #ifdef CONFIG_SYSCTL
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 73f43f699199..30ba5359da84 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -19,8 +19,7 @@ struct hlist_head;
 struct fib_table;
 struct sock;
 struct local_ports {
-=09seqlock_t=09lock;
-=09int=09=09range[2];
+=09u32=09=09range;=09/* high << 16 | low */
 =09bool=09=09warned;
 };
=20
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index fb81de10d332..fbeacf04dbf3 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1847,9 +1847,7 @@ static __net_init int inet_init_net(struct net *net)
 =09/*
 =09 * Set defaults for local port range
 =09 */
-=09seqlock_init(&net->ipv4.ip_local_ports.lock);
-=09net->ipv4.ip_local_ports.range[0] =3D  32768;
-=09net->ipv4.ip_local_ports.range[1] =3D  60999;
+=09net->ipv4.ip_local_ports.range =3D 60999u << 16 | 32768u;
=20
 =09seqlock_init(&net->ipv4.ping_group_range.lock);
 =09/*
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_soc=
k.c
index 394a498c2823..70be0f6fe879 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -117,34 +117,25 @@ bool inet_rcv_saddr_any(const struct sock *sk)
 =09return !sk->sk_rcv_saddr;
 }
=20
-void inet_get_local_port_range(const struct net *net, int *low, int *high)
-{
-=09unsigned int seq;
-
-=09do {
-=09=09seq =3D read_seqbegin(&net->ipv4.ip_local_ports.lock);
-
-=09=09*low =3D net->ipv4.ip_local_ports.range[0];
-=09=09*high =3D net->ipv4.ip_local_ports.range[1];
-=09} while (read_seqretry(&net->ipv4.ip_local_ports.lock, seq));
-}
-EXPORT_SYMBOL(inet_get_local_port_range);
-
 void inet_sk_get_local_port_range(const struct sock *sk, int *low, int *hi=
gh)
 {
 =09const struct inet_sock *inet =3D inet_sk(sk);
 =09const struct net *net =3D sock_net(sk);
 =09int lo, hi, sk_lo, sk_hi;
+=09u32 sk_range;
=20
 =09inet_get_local_port_range(net, &lo, &hi);
=20
-=09sk_lo =3D inet->local_port_range.lo;
-=09sk_hi =3D inet->local_port_range.hi;
+=09sk_range =3D READ_ONCE(inet->local_port_range);
+=09if (unlikely(sk_range)) {
+=09=09sk_lo =3D sk_range & 0xffff;
+=09=09sk_hi =3D sk_range >> 16;
=20
-=09if (unlikely(lo <=3D sk_lo && sk_lo <=3D hi))
-=09=09lo =3D sk_lo;
-=09if (unlikely(lo <=3D sk_hi && sk_hi <=3D hi))
-=09=09hi =3D sk_hi;
+=09=09if (lo <=3D sk_lo && sk_lo <=3D hi)
+=09=09=09lo =3D sk_lo;
+=09=09if (lo <=3D sk_hi && sk_hi <=3D hi)
+=09=09=09hi =3D sk_hi;
+=09}
=20
 =09*low =3D lo;
 =09*high =3D hi;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 2efc53526a38..d7d13940774e 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1055,6 +1055,19 @@ int do_ip_setsockopt(struct sock *sk, int level, int=
 optname,
 =09case IP_TOS:=09/* This sets both TOS and Precedence */
 =09=09ip_sock_set_tos(sk, val);
 =09=09return 0;
+=09case IP_LOCAL_PORT_RANGE:
+=09{
+=09=09u16 lo =3D val;
+=09=09u16 hi =3D val >> 16;
+
+=09=09if (optlen !=3D sizeof(u32))
+=09=09=09return -EINVAL;
+=09=09if (lo !=3D 0 && hi !=3D 0 && lo > hi)
+=09=09=09return -EINVAL;
+
+=09=09WRITE_ONCE(inet->local_port_range, val);
+=09=09return 0;
+=09}
 =09}
=20
 =09err =3D 0;
@@ -1332,20 +1345,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int=
 optname,
 =09=09err =3D xfrm_user_policy(sk, optname, optval, optlen);
 =09=09break;
=20
-=09case IP_LOCAL_PORT_RANGE:
-=09{
-=09=09const __u16 lo =3D val;
-=09=09const __u16 hi =3D val >> 16;
-
-=09=09if (optlen !=3D sizeof(__u32))
-=09=09=09goto e_inval;
-=09=09if (lo !=3D 0 && hi !=3D 0 && lo > hi)
-=09=09=09goto e_inval;
-
-=09=09inet->local_port_range.lo =3D lo;
-=09=09inet->local_port_range.hi =3D hi;
-=09=09break;
-=09}
 =09default:
 =09=09err =3D -ENOPROTOOPT;
 =09=09break;
@@ -1692,6 +1691,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int =
optname,
 =09=09=09return -EFAULT;
 =09=09return 0;
 =09}
+=09case IP_LOCAL_PORT_RANGE:
+=09=09val =3D READ_ONCE(inet->local_port_range);
+=09=09goto copyval;
 =09}
=20
 =09if (needs_rtnl)
@@ -1721,9 +1723,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int =
optname,
 =09=09else
 =09=09=09err =3D ip_get_mcast_msfilter(sk, optval, optlen, len);
 =09=09goto out;
-=09case IP_LOCAL_PORT_RANGE:
-=09=09val =3D inet->local_port_range.hi << 16 | inet->local_port_range.lo;
-=09=09break;
 =09case IP_PROTOCOL:
 =09=09val =3D inet_sk(sk)->inet_num;
 =09=09break;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index f63a545a7374..7e4f16a7dcc1 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -50,26 +50,22 @@ static int tcp_plb_max_cong_thresh =3D 256;
 static int sysctl_tcp_low_latency __read_mostly;
=20
 /* Update system visible IP port range */
-static void set_local_port_range(struct net *net, int range[2])
+static void set_local_port_range(struct net *net, unsigned int low, unsign=
ed int high)
 {
-=09bool same_parity =3D !((range[0] ^ range[1]) & 1);
+=09bool same_parity =3D !((low ^ high) & 1);
=20
-=09write_seqlock_bh(&net->ipv4.ip_local_ports.lock);
 =09if (same_parity && !net->ipv4.ip_local_ports.warned) {
 =09=09net->ipv4.ip_local_ports.warned =3D true;
 =09=09pr_err_ratelimited("ip_local_port_range: prefer different parity for=
 start/end values.\n");
 =09}
-=09net->ipv4.ip_local_ports.range[0] =3D range[0];
-=09net->ipv4.ip_local_ports.range[1] =3D range[1];
-=09write_sequnlock_bh(&net->ipv4.ip_local_ports.lock);
+=09WRITE_ONCE(net->ipv4.ip_local_ports.range, high << 16 | low);
 }
=20
 /* Validate changes from /proc interface. */
 static int ipv4_local_port_range(struct ctl_table *table, int write,
 =09=09=09=09 void *buffer, size_t *lenp, loff_t *ppos)
 {
-=09struct net *net =3D
-=09=09container_of(table->data, struct net, ipv4.ip_local_ports.range);
+=09struct net *net =3D table->data;
 =09int ret;
 =09int range[2];
 =09struct ctl_table tmp =3D {
@@ -93,7 +89,7 @@ static int ipv4_local_port_range(struct ctl_table *table,=
 int write,
 =09=09    (range[0] < READ_ONCE(net->ipv4.sysctl_ip_prot_sock)))
 =09=09=09ret =3D -EINVAL;
 =09=09else
-=09=09=09set_local_port_range(net, range);
+=09=09=09set_local_port_range(net, range[0], range[1]);
 =09}
=20
 =09return ret;
@@ -733,8 +729,8 @@ static struct ctl_table ipv4_net_table[] =3D {
 =09},
 =09{
 =09=09.procname=09=3D "ip_local_port_range",
-=09=09.maxlen=09=09=3D sizeof(init_net.ipv4.ip_local_ports.range),
-=09=09.data=09=09=3D &init_net.ipv4.ip_local_ports.range,
+=09=09.maxlen=09=09=3D 0,
+=09=09.data=09=09=3D &init_net,
 =09=09.mode=09=09=3D 0644,
 =09=09.proc_handler=09=3D ipv4_local_port_range,
 =09},
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


