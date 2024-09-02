Return-Path: <netdev+bounces-124210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A0596887F
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 15:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242431F236BF
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 13:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E62F200139;
	Mon,  2 Sep 2024 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="CyLKt9hd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2917613212A
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282608; cv=none; b=LauEl02eFEZQ0uHw2M/U7pzT/676/CZQn4+EBTTwa64uIRRN/11osBHyl/MJKkVpQQipcLZITEWA11xq5JEkG+xB8vVGVRqBErzUurx5LbOJ8QqcfA7jmXjjkpNbt29bhyyNfIRjst1VlyDCtl/kM2fE+GyL4PVJwAs1almjNw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282608; c=relaxed/simple;
	bh=CBvlVTnC1VXXpEbgwWDdQQ6PC68lXpvaa9OwYXuuR1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TlCStPazsvuo2UNdQhUZRnVyFx5NbvLZEGQedECLYWM/ziTguwTXuaRw/lD2SR6OUNhIlx5gGcwye3M+LWCjECH1Z2VUPzIF7uaGDJnKxJbsAIY+JTYszS8rzOftcAjHjnWg2FMTp9pi32AG3FApWW1rOybYxjxaJCCb4IEjJUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=CyLKt9hd; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482AkTKL004908;
	Mon, 2 Sep 2024 06:09:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=Jnz
	dZ13Xtuw+SKFPPOcX/9ZsLYqy64GGqQfYhSGPQOs=; b=CyLKt9hdvcMnPbY4Qot
	C6+oubE7nc3ez1AkGjMtjUbxVuXXN4dpVv6hPzZzQSc1YHJvgxwB5v5qcUSsfI5/
	yV/YED/P+UQtYWyqq53xHdtxSt4Id41rWfFMcmCNKWvo94qmSjzVwVICva51fnXc
	lipW7vFhz5rV96RrN5DR4Zqvwsv5vr+O4zU4yGk0HH4I0wfvVP96/wXjEjkissQf
	Ny28G3HuK7MHWnd7BwAblMOjhRHMReUxSwCyAILud5besTCp2pUvp++k5/kjA2K5
	YmobJ+rYYevQ+FFwJX8IbntjpUO4721nRPreaGypBVPcPOp9m5sZOXBoTMZtY7QR
	D4g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41c10sgej2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 02 Sep 2024 06:09:47 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Mon, 2 Sep 2024 13:09:45 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Willem de Bruijn
	<willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Jason Xing
	<kerneljasonxing@gmail.com>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v2 1/2] net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message
Date: Mon, 2 Sep 2024 06:09:35 -0700
Message-ID: <20240902130937.457115-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: oguBzW5rbDH0HxqZn7AeIBBTndv75JSo
X-Proofpoint-GUID: oguBzW5rbDH0HxqZn7AeIBBTndv75JSo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_03,2024-09-02_01,2024-09-02_01

SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
timestamps and packets sent via socket. Unfortunately, there is no way
to reliably predict socket timestamp ID value in case of error returned
by sendmsg. For UDP sockets it's impossible because of lockless
nature of UDP transmit, several threads may send packets in parallel. In
case of RAW sockets MSG_MORE option makes things complicated. More
details are in the conversation [1].
This patch adds new control message type to give user-space
software an opportunity to control the mapping between packets and
values by providing ID with each sendmsg. This works fine for UDP
sockets only, and explicit check is added to control message parser.

[1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 Documentation/networking/timestamping.rst | 14 ++++++++++++++
 arch/alpha/include/uapi/asm/socket.h      |  4 +++-
 arch/mips/include/uapi/asm/socket.h       |  2 ++
 arch/parisc/include/uapi/asm/socket.h     |  2 ++
 arch/sparc/include/uapi/asm/socket.h      |  2 ++
 include/net/inet_sock.h                   |  4 +++-
 include/net/sock.h                        |  1 +
 include/uapi/asm-generic/socket.h         |  2 ++
 include/uapi/linux/net_tstamp.h           |  3 ++-
 net/core/sock.c                           | 12 ++++++++++++
 net/ethtool/common.c                      |  1 +
 net/ipv4/ip_output.c                      | 16 ++++++++++++----
 net/ipv6/ip6_output.c                     | 16 ++++++++++++----
 13 files changed, 68 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index 5e93cd71f99f..93b0901e4e8e 100644
--- a/Documentation/networking/timestamping.rst
+++ b/Documentation/networking/timestamping.rst
@@ -193,6 +193,20 @@ SOF_TIMESTAMPING_OPT_ID:
   among all possibly concurrently outstanding timestamp requests for
   that socket.
 
+  With this option enabled user-space application can provide custom
+  ID for each message sent via UDP socket with control message with
+  type set to SCM_TS_OPT_ID::
+
+    struct msghdr *msg;
+    ...
+    cmsg			 = CMSG_FIRSTHDR(msg);
+    cmsg->cmsg_level		 = SOL_SOCKET;
+    cmsg->cmsg_type		 = SO_TIMESTAMPING;
+    cmsg->cmsg_len		 = CMSG_LEN(sizeof(__u32));
+    *((__u32 *) CMSG_DATA(cmsg)) = opt_id;
+    err = sendmsg(fd, msg, 0);
+
+
 SOF_TIMESTAMPING_OPT_ID_TCP:
   Pass this modifier along with SOF_TIMESTAMPING_OPT_ID for new TCP
   timestamping applications. SOF_TIMESTAMPING_OPT_ID defines how the
diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index e94f621903fe..0698e6662cdf 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -10,7 +10,7 @@
  * Note: we only bother about making the SOL_SOCKET options
  * same as OSF/1, as that's all that "normal" programs are
  * likely to set.  We don't necessarily want to be binary
- * compatible with _everything_. 
+ * compatible with _everything_.
  */
 #define SOL_SOCKET	0xffff
 
@@ -140,6 +140,8 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SCM_TS_OPT_ID		78
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 60ebaed28a4c..bb3dc8feb205 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -151,6 +151,8 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SCM_TS_OPT_ID		78
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index be264c2b1a11..c3ab3b3289eb 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -132,6 +132,8 @@
 #define SO_PASSPIDFD		0x404A
 #define SO_PEERPIDFD		0x404B
 
+#define SCM_TS_OPT_ID		0x404C
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 682da3714686..9b40f0a57fbc 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -133,6 +133,8 @@
 #define SO_PASSPIDFD             0x0055
 #define SO_PEERPIDFD             0x0056
 
+#define SCM_TS_OPT_ID            0x0057
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 394c3b66065e..2161d50cf0fd 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -174,6 +174,7 @@ struct inet_cork {
 	__s16			tos;
 	char			priority;
 	__u16			gso_size;
+	u32			ts_opt_id;
 	u64			transmit_time;
 	u32			mark;
 };
@@ -241,7 +242,8 @@ struct inet_sock {
 	struct inet_cork_full	cork;
 };
 
-#define IPCORK_OPT	1	/* ip-options has been held in ipcork.opt */
+#define IPCORK_OPT		1	/* ip-options has been held in ipcork.opt */
+#define IPCORK_TS_OPT_ID	2	/* timestmap opt id has been provided in cmsg */
 
 enum {
 	INET_FLAGS_PKTINFO	= 0,
diff --git a/include/net/sock.h b/include/net/sock.h
index f51d61fab059..73e21dad5660 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1794,6 +1794,7 @@ struct sockcm_cookie {
 	u64 transmit_time;
 	u32 mark;
 	u32 tsflags;
+	u32 ts_opt_id;
 };
 
 static inline void sockcm_init(struct sockcm_cookie *sockc,
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 8ce8a39a1e5f..db3df3e74b01 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -135,6 +135,8 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SCM_TS_OPT_ID		78
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
index a2c66b3d7f0f..e2f145e3f3a1 100644
--- a/include/uapi/linux/net_tstamp.h
+++ b/include/uapi/linux/net_tstamp.h
@@ -32,8 +32,9 @@ enum {
 	SOF_TIMESTAMPING_OPT_TX_SWHW = (1<<14),
 	SOF_TIMESTAMPING_BIND_PHC = (1 << 15),
 	SOF_TIMESTAMPING_OPT_ID_TCP = (1 << 16),
+	SOF_TIMESTAMPING_OPT_ID_CMSG = (1 << 17),
 
-	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_OPT_ID_TCP,
+	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_OPT_ID_CMSG,
 	SOF_TIMESTAMPING_MASK = (SOF_TIMESTAMPING_LAST - 1) |
 				 SOF_TIMESTAMPING_LAST
 };
diff --git a/net/core/sock.c b/net/core/sock.c
index 468b1239606c..560b075765fa 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2859,6 +2859,18 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 			return -EINVAL;
 		sockc->transmit_time = get_unaligned((u64 *)CMSG_DATA(cmsg));
 		break;
+	case SCM_TS_OPT_ID:
+		/* allow this option for UDP sockets only */
+		if (!sk_is_udp(sk))
+			return -EINVAL;
+		tsflags = READ_ONCE(sk->sk_tsflags);
+		if (!(tsflags & SOF_TIMESTAMPING_OPT_ID))
+			return -EINVAL;
+		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
+			return -EINVAL;
+		sockc->ts_opt_id = *(u32 *)CMSG_DATA(cmsg);
+		sockc->tsflags |= SOF_TIMESTAMPING_OPT_ID_CMSG;
+		break;
 	/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
 	case SCM_RIGHTS:
 	case SCM_CREDENTIALS:
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 7257ae272296..147b87c883a9 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -430,6 +430,7 @@ const char sof_timestamping_names[][ETH_GSTRING_LEN] = {
 	[const_ilog2(SOF_TIMESTAMPING_OPT_TX_SWHW)]  = "option-tx-swhw",
 	[const_ilog2(SOF_TIMESTAMPING_BIND_PHC)]     = "bind-phc",
 	[const_ilog2(SOF_TIMESTAMPING_OPT_ID_TCP)]   = "option-id-tcp",
+	[const_ilog2(SOF_TIMESTAMPING_OPT_ID_CMSG)]  = "option-id-cmsg",
 };
 static_assert(ARRAY_SIZE(sof_timestamping_names) == __SOF_TIMESTAMPING_CNT);
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index b90d0f78ac80..1a0fe7e99843 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1048,10 +1048,15 @@ static int __ip_append_data(struct sock *sk,
 
 	cork->length += length;
 
-	hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
-		     READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
-	if (hold_tskey)
-		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
+	    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
+		if (cork->flags & IPCORK_TS_OPT_ID) {
+			tskey = cork->ts_opt_id;
+		} else {
+			tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+			hold_tskey = true;
+		}
+	}
 
 	/* So, what's going on in the loop below?
 	 *
@@ -1324,8 +1329,11 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 	cork->mark = ipc->sockc.mark;
 	cork->priority = ipc->priority;
 	cork->transmit_time = ipc->sockc.transmit_time;
+	cork->ts_opt_id = ipc->sockc.ts_opt_id;
 	cork->tx_flags = 0;
 	sock_tx_timestamp(sk, ipc->sockc.tsflags, &cork->tx_flags);
+	if (ipc->sockc.tsflags & SOF_TIMESTAMPING_OPT_ID_CMSG)
+		cork->flags |= IPCORK_TS_OPT_ID;
 
 	return 0;
 }
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f26841f1490f..d7113f8622bf 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1401,7 +1401,10 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	cork->base.gso_size = ipc6->gso_size;
 	cork->base.tx_flags = 0;
 	cork->base.mark = ipc6->sockc.mark;
+	cork->base.ts_opt_id = ipc6->sockc.ts_opt_id;
 	sock_tx_timestamp(sk, ipc6->sockc.tsflags, &cork->base.tx_flags);
+	if (ipc6->sockc.tsflags & SOF_TIMESTAMPING_OPT_ID_CMSG)
+		cork->base.flags |= IPCORK_TS_OPT_ID;
 
 	cork->base.length = 0;
 	cork->base.transmit_time = ipc6->sockc.transmit_time;
@@ -1543,10 +1546,15 @@ static int __ip6_append_data(struct sock *sk,
 			flags &= ~MSG_SPLICE_PAGES;
 	}
 
-	hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
-		     READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
-	if (hold_tskey)
-		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
+	    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
+		if (cork->flags & IPCORK_TS_OPT_ID) {
+			tskey = cork->ts_opt_id;
+		} else {
+			tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+			hold_tskey = true;
+		}
+	}
 
 	/*
 	 * Let's try using as much space as possible.
-- 
2.43.5


