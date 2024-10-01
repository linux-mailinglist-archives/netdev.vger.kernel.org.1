Return-Path: <netdev+bounces-130872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEA598BCEB
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA63AB21657
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6AE1C3305;
	Tue,  1 Oct 2024 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nbZNkcSt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11A21C32FA
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787462; cv=none; b=MM38eFTopI11voMv7mA2QVMkhDR/KDBn1fzvev6t6JE30/IxPbtqNPk0RzneI66+dBfPK8Vh26KYc9WIgDKygA6xa2G9O4w6X5BdwlPA5pG1DnnNraxnjqv1tp1Cq54kvhelBMmT5yooyRFbteggnYppvmwKCJ39eb4+GOAHJ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787462; c=relaxed/simple;
	bh=LxJ+4mRU8hqqUVvuYZlnHlx5agVyfz+bwgHs7fLgjN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwWiqzHMr50kCIfVc0vdYY3tB65Dc/LjQPPcHyhdL75jtRlIVaP8vwGcTzYoYAUVtHSOe53QDx2wjuGUqz56Pva6UisrT5Cgr8KZWFPuD+Nw764MtFUmIUUboWVeNySF5pK31h3CG27752PUVl1yy2/8+AKSsRKV2HfUuVWaJng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nbZNkcSt; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491BoTHj011929;
	Tue, 1 Oct 2024 05:57:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=/Uj8rkqzqP8mKeMKqtZ8D0GmQkbSrwcW0y6G+5ZOZ1s=; b=
	nbZNkcSticZJozUdHSbm8PzeRpgFlM2lI+06DKnY+Z2kuH6IArn9QYaqiWFnGvVF
	terj4PjXVeVu5i8Ermy1G69LRBRmbir+OMTzjWja/LCEd9wAAnnqpFaNDdcYkpB5
	9uBFptOvX44ZJYbOSYm1tzWXcCLn5b+qVFxVL5ih4y73MXGdVIaLbe1N2WrGFU+Z
	EzKXLB4v2N4pCl2V6bfMLUYk83yt+9qtrTm/BqpB2MlT9Eb0EUphjNzuqCSoPQEo
	vN8MjzNf97efJXe54MVX092dgGRlomlgYCUAGgRUQBDETLVYJFs1fuH77zDrCmed
	8YkgJQKiEX3CwTC4soGC7Q==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41yrw5rqj9-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 01 Oct 2024 05:57:27 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server id
 15.2.1544.11; Tue, 1 Oct 2024 12:57:25 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Willem de Bruijn
	<willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Jason Xing
	<kerneljasonxing@gmail.com>,
        Simon Horman <horms@kernel.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v6 2/3] net_tstamp: add SCM_TS_OPT_ID for RAW sockets
Date: Tue, 1 Oct 2024 05:57:15 -0700
Message-ID: <20241001125716.2832769-3-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241001125716.2832769-1-vadfed@meta.com>
References: <20241001125716.2832769-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eiPXxGayXRaef6IBXzf8gKjifuV8vuZJ
X-Proofpoint-GUID: eiPXxGayXRaef6IBXzf8gKjifuV8vuZJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_09,2024-09-30_01,2024-09-30_01

The last type of sockets which supports SOF_TIMESTAMPING_OPT_ID is RAW
sockets. To add new option this patch converts all callers (direct and
indirect) of _sock_tx_timestamp to provide sockcm_cookie instead of
tsflags. And while here fix __sock_tx_timestamp to receive tsflags as
__u32 instead of __u16.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 include/net/sock.h     | 27 ++++++++++++++++++---------
 net/can/raw.c          |  2 +-
 net/ipv4/ip_output.c   |  2 +-
 net/ipv4/raw.c         |  2 +-
 net/ipv4/tcp.c         |  7 ++++---
 net/ipv6/ip6_output.c  |  2 +-
 net/ipv6/raw.c         |  2 +-
 net/packet/af_packet.c |  6 +++---
 net/socket.c           |  2 +-
 9 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index ccf28c2b70b1..e282127092ab 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2660,39 +2660,48 @@ static inline void sock_recv_cmsgs(struct msghdr *msg, struct sock *sk,
 		sock_write_timestamp(sk, 0);
 }
 
-void __sock_tx_timestamp(__u16 tsflags, __u8 *tx_flags);
+void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flags);
 
 /**
  * _sock_tx_timestamp - checks whether the outgoing packet is to be time stamped
  * @sk:		socket sending this packet
- * @tsflags:	timestamping flags to use
+ * @sockc:	pointer to socket cmsg cookie to get timestamping info
  * @tx_flags:	completed with instructions for time stamping
  * @tskey:      filled in with next sk_tskey (not for TCP, which uses seqno)
  *
  * Note: callers should take care of initial ``*tx_flags`` value (usually 0)
  */
-static inline void _sock_tx_timestamp(struct sock *sk, __u16 tsflags,
+static inline void _sock_tx_timestamp(struct sock *sk,
+				      const struct sockcm_cookie *sockc,
 				      __u8 *tx_flags, __u32 *tskey)
 {
+	__u32 tsflags = sockc->tsflags;
+
 	if (unlikely(tsflags)) {
 		__sock_tx_timestamp(tsflags, tx_flags);
 		if (tsflags & SOF_TIMESTAMPING_OPT_ID && tskey &&
-		    tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
-			*tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+		    tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK) {
+			if (tsflags & SOCKCM_FLAG_TS_OPT_ID)
+				*tskey = sockc->ts_opt_id;
+			else
+				*tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+		}
 	}
 	if (unlikely(sock_flag(sk, SOCK_WIFI_STATUS)))
 		*tx_flags |= SKBTX_WIFI_STATUS;
 }
 
-static inline void sock_tx_timestamp(struct sock *sk, __u16 tsflags,
+static inline void sock_tx_timestamp(struct sock *sk,
+				     const struct sockcm_cookie *sockc,
 				     __u8 *tx_flags)
 {
-	_sock_tx_timestamp(sk, tsflags, tx_flags, NULL);
+	_sock_tx_timestamp(sk, sockc, tx_flags, NULL);
 }
 
-static inline void skb_setup_tx_timestamp(struct sk_buff *skb, __u16 tsflags)
+static inline void skb_setup_tx_timestamp(struct sk_buff *skb,
+					  const struct sockcm_cookie *sockc)
 {
-	_sock_tx_timestamp(skb->sk, tsflags, &skb_shinfo(skb)->tx_flags,
+	_sock_tx_timestamp(skb->sk, sockc, &skb_shinfo(skb)->tx_flags,
 			   &skb_shinfo(skb)->tskey);
 }
 
diff --git a/net/can/raw.c b/net/can/raw.c
index 00533f64d69d..255c0a8f39d6 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -966,7 +966,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	skb->mark = READ_ONCE(sk->sk_mark);
 	skb->tstamp = sockc.transmit_time;
 
-	skb_setup_tx_timestamp(skb, sockc.tsflags);
+	skb_setup_tx_timestamp(skb, &sockc);
 
 	err = can_send(skb, ro->loopback);
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 0c7049f50369..e5c55a95063d 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1331,7 +1331,7 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 	cork->priority = ipc->priority;
 	cork->transmit_time = ipc->sockc.transmit_time;
 	cork->tx_flags = 0;
-	sock_tx_timestamp(sk, ipc->sockc.tsflags, &cork->tx_flags);
+	sock_tx_timestamp(sk, &ipc->sockc, &cork->tx_flags);
 	if (ipc->sockc.tsflags & SOCKCM_FLAG_TS_OPT_ID) {
 		cork->flags |= IPCORK_TS_OPT_ID;
 		cork->ts_opt_id = ipc->sockc.ts_opt_id;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 474dfd263c8b..0e9e01967ec9 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -370,7 +370,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 
 	skb->ip_summed = CHECKSUM_NONE;
 
-	skb_setup_tx_timestamp(skb, sockc->tsflags);
+	skb_setup_tx_timestamp(skb, sockc);
 
 	if (flags & MSG_CONFIRM)
 		skb_set_dst_pending_confirm(skb, 1);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4f77bd862e95..82cc4a5633ce 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -477,15 +477,16 @@ void tcp_init_sock(struct sock *sk)
 }
 EXPORT_SYMBOL(tcp_init_sock);
 
-static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
+static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 {
 	struct sk_buff *skb = tcp_write_queue_tail(sk);
+	u32 tsflags = sockc->tsflags;
 
 	if (tsflags && skb) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
 
-		sock_tx_timestamp(sk, tsflags, &shinfo->tx_flags);
+		sock_tx_timestamp(sk, sockc, &shinfo->tx_flags);
 		if (tsflags & SOF_TIMESTAMPING_TX_ACK)
 			tcb->txstamp_ack = 1;
 		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
@@ -1321,7 +1322,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 out:
 	if (copied) {
-		tcp_tx_timestamp(sk, sockc.tsflags);
+		tcp_tx_timestamp(sk, &sockc);
 		tcp_push(sk, flags, mss_now, tp->nonagle, size_goal);
 	}
 out_nopush:
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index ff6bd8d85e9a..205673179b3c 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1401,7 +1401,7 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	cork->base.gso_size = ipc6->gso_size;
 	cork->base.tx_flags = 0;
 	cork->base.mark = ipc6->sockc.mark;
-	sock_tx_timestamp(sk, ipc6->sockc.tsflags, &cork->base.tx_flags);
+	sock_tx_timestamp(sk, &ipc6->sockc, &cork->base.tx_flags);
 	if (ipc6->sockc.tsflags & SOCKCM_FLAG_TS_OPT_ID) {
 		cork->base.flags |= IPCORK_TS_OPT_ID;
 		cork->base.ts_opt_id = ipc6->sockc.ts_opt_id;
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 608fa9d05b55..8476a3944a88 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -629,7 +629,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 
 	skb->ip_summed = CHECKSUM_NONE;
 
-	skb_setup_tx_timestamp(skb, sockc->tsflags);
+	skb_setup_tx_timestamp(skb, sockc);
 
 	if (flags & MSG_CONFIRM)
 		skb_set_dst_pending_confirm(skb, 1);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a705ec214254..f8942062f776 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2118,7 +2118,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = READ_ONCE(sk->sk_mark);
 	skb_set_delivery_type_by_clockid(skb, sockc.transmit_time, sk->sk_clockid);
-	skb_setup_tx_timestamp(skb, sockc.tsflags);
+	skb_setup_tx_timestamp(skb, &sockc);
 
 	if (unlikely(extra_len == 4))
 		skb->no_fcs = 1;
@@ -2650,7 +2650,7 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	skb->priority = READ_ONCE(po->sk.sk_priority);
 	skb->mark = READ_ONCE(po->sk.sk_mark);
 	skb_set_delivery_type_by_clockid(skb, sockc->transmit_time, po->sk.sk_clockid);
-	skb_setup_tx_timestamp(skb, sockc->tsflags);
+	skb_setup_tx_timestamp(skb, sockc);
 	skb_zcopy_set_nouarg(skb, ph.raw);
 
 	skb_reserve(skb, hlen);
@@ -3115,7 +3115,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out_free;
 	}
 
-	skb_setup_tx_timestamp(skb, sockc.tsflags);
+	skb_setup_tx_timestamp(skb, &sockc);
 
 	if (!vnet_hdr.gso_type && (len > dev->mtu + reserve + extra_len) &&
 	    !packet_extra_vlan_len_allowed(dev, skb)) {
diff --git a/net/socket.c b/net/socket.c
index 7b046dd3e9a7..49ce34298f33 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -688,7 +688,7 @@ void sock_release(struct socket *sock)
 }
 EXPORT_SYMBOL(sock_release);
 
-void __sock_tx_timestamp(__u16 tsflags, __u8 *tx_flags)
+void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flags)
 {
 	u8 flags = *tx_flags;
 
-- 
2.43.5


