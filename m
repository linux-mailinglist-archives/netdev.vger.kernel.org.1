Return-Path: <netdev+bounces-126598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 928EE971F8D
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B6928464C
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 16:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9731E1531E6;
	Mon,  9 Sep 2024 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kaTpZJtc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7A545014
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900686; cv=none; b=JfqR5oFNGaOgff7xzpLoHl1WzE6ItCHccwA+FXmT88ibFGvjghcN2TrlXigK2XccedhAt4AInvlskJxeYfXCbPRIT7J31cwmbeKat877KQeNMilC1NJXRFszt47ZJDM8t0fLlFcmPp0ReFyQwdFoKJL1mjyHqQ2littRh8j7PQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900686; c=relaxed/simple;
	bh=G0kivHagh9LhmMXM7TiQKYqolRp4kZ0aWvH+6NUt8a0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxEw0+yQMf7U0o/JNP0UJMNfcB4nfpIHr9spW61SOhhW9xpbbc8y4y58wxtkLWRq6zMc2mwcoJIwHpPo+WoJYfDn+KP1WcNPnq6+BXatxzB5AN0vUvTW9K7e/MDCy2Qm6Igx7yTQTBAXcrxEVMIjPXxBP/5Z+lbuKLi41vTBkYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kaTpZJtc; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 489Cq5pm001415;
	Mon, 9 Sep 2024 09:51:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=VcZK6dunl+YSg+XNPBK95kTKMj8Z1+bpqWMP0OcFOqc=; b=
	kaTpZJtcGeplj0TAQC6YLphuWDbNG2KC+OZ32xy31IowfW3/bWTxATSiHc0kS3rQ
	uUtEMDc6LbiSFqxFdvbDZbzKJlelfQNw0k8njLZHJ+2jxQf+mTxfH+X+IvG+RJnf
	8XiMrSYpSbAfZD7dFQkAY7CXWgHfAyclXmUiGJgcNcdUANvRDW+CDyEXgeKsUnHy
	V6Fpp5xcnJequaw4ZvZrrft6dHn4DiTcErjfgGqfaRxmyECyh+YIUkcbngYWkQfz
	9aVOVTRTDcNJx3dVUqfldScbL5glmfGjOUaXlcV1a9mjQUGcz9wzjvoE8NVm2WSJ
	s6L7tx6gDVv90VenPA+sBw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 41hssfkktf-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 09 Sep 2024 09:51:09 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.11; Mon, 9 Sep 2024 16:51:06 +0000
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
Subject: [PATCH net-next v4 2/3] net_tstamp: add SCM_TS_OPT_ID for RAW sockets
Date: Mon, 9 Sep 2024 09:50:45 -0700
Message-ID: <20240909165046.644417-3-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240909165046.644417-1-vadfed@meta.com>
References: <20240909165046.644417-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Ok3YUj4ZbxN9sNjYjl_2klyXloen7Oou
X-Proofpoint-ORIG-GUID: Ok3YUj4ZbxN9sNjYjl_2klyXloen7Oou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_08,2024-09-09_01,2024-09-02_01

The last type of sockets which supports SOF_TIMESTAMPING_OPT_ID is RAW
sockets. To add new option this patch converts all callers (direct and
indirect) of _sock_tx_timestamp to provide sockcm_cookie instead of
tsflags. And while here fix __sock_tx_timestamp to receive tsflags as
__u32 instead of __u16.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 include/net/sock.h     | 27 ++++++++++++++++++---------
 net/can/raw.c          |  2 +-
 net/ipv4/ip_output.c   |  2 +-
 net/ipv4/raw.c         |  2 +-
 net/ipv4/tcp.c         |  2 +-
 net/ipv6/ip6_output.c  |  2 +-
 net/ipv6/raw.c         |  2 +-
 net/packet/af_packet.c |  6 +++---
 net/socket.c           |  2 +-
 9 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 2e641917fe0c..4cbf79dc8d46 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2658,39 +2658,48 @@ static inline void sock_recv_cmsgs(struct msghdr *msg, struct sock *sk,
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
index 8a5680b4e786..e48136bbb8c7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -482,7 +482,7 @@ static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
 
-		sock_tx_timestamp(sk, tsflags, &shinfo->tx_flags);
+		sock_tx_timestamp(sk, sockc, &shinfo->tx_flags);
 		if (tsflags & SOF_TIMESTAMPING_TX_ACK)
 			tcb->txstamp_ack = 1;
 		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
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
index 4a364cdd445e..83ef86c0dd88 100644
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
index 0a2bd22ec105..d7b9a4f7d3fc 100644
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


