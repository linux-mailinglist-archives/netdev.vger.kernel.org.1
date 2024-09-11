Return-Path: <netdev+bounces-127289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2415974E3E
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 044F1B27DFE
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8774C179965;
	Wed, 11 Sep 2024 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="IAF1HD/8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9926C15E5B8
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046037; cv=none; b=SvQS803762tIyXDhSHaX2VcY6tR1E2a8yG722iNv1RrewKrlkZXRRjYDjQ73qHfvFjoVM3dnoPKIxl5J4wPf3uHXl2FnlL8wFQGTHXZh3Z2WragMn4xq8Ci1i2+rBHh3SPKG5ZULCAWiFt9WWTZWPPjkniZxainr279A/YTRHck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046037; c=relaxed/simple;
	bh=2hDVqxGSpkaiNbsHBMvpVeEm10K72qeXSNf8uIzlwjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ASyWhyszYHSRVqT3IWJMHnQJhRg++EKnTdPm3hgJi9qSMPMBsynb7jk00IXhmXqrzzwTKL8sgexDA7bLABIbF+Fgo/JUz08S4indw5+CM2321loqxjn1xoajCpiUNYx8Rt94X/DLeZvQopUk8AyDIh3PdwboRZBzraF8nyURBIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=IAF1HD/8; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B80Sxg028418;
	Wed, 11 Sep 2024 02:13:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=Khqn/SdahkRLrsHcqlfLthF6kKTBTC+HSb/crJy+Bts=; b=
	IAF1HD/8gBu6fnSqCrDGaMtcsnM2599ZYzIbNRFJocs0CdYob0pROTteVYZ4bTzH
	j2DTvczWJcrclm0R0eE3qsBCC+Z7m/7bjw4ICvqVsrRA2vf4YoM0WchSKeIEGuU8
	7TrRVjOuy5hsB9b3qmmCUlXmkIqLAPeLkXx+6fTjV9gontCvlg1yqVe71nCo3EPe
	47OO/3mwkD14kSAQQaZ9AyvbA5uqbw3ZDUR0o623mam3qR6n5doAkrLuKPfAIaBy
	QrZInKRzLVVd6uI4kOJuHCIiGRIcGUeWHS9m3zym4eX0P0Kvp59clNusUiMAWzS9
	jAQd3CPgpH60R8H27mVGdA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41k7adra08-20
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 11 Sep 2024 02:13:47 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Wed, 11 Sep 2024 09:13:43 +0000
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
Subject: [PATCH net-next v5 1/3] net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message
Date: Wed, 11 Sep 2024 02:13:31 -0700
Message-ID: <20240911091333.1870071-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240911091333.1870071-1-vadfed@meta.com>
References: <20240911091333.1870071-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ZSReyt0B9p8EY_QEvK_00gJLbwV-NaQM
X-Proofpoint-ORIG-GUID: ZSReyt0B9p8EY_QEvK_00gJLbwV-NaQM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01

SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
timestamps and packets sent via socket. Unfortunately, there is no way
to reliably predict socket timestamp ID value in case of error returned
by sendmsg. For UDP sockets it's impossible because of lockless
nature of UDP transmit, several threads may send packets in parallel. In
case of RAW sockets MSG_MORE option makes things complicated. More
details are in the conversation [1].
This patch adds new control message type to give user-space
software an opportunity to control the mapping between packets and
values by providing ID with each sendmsg for UDP sockets.
The documentation is also added in this patch.

[1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 Documentation/networking/timestamping.rst | 14 ++++++++++++++
 arch/alpha/include/uapi/asm/socket.h      |  2 ++
 arch/mips/include/uapi/asm/socket.h       |  2 ++
 arch/parisc/include/uapi/asm/socket.h     |  2 ++
 arch/sparc/include/uapi/asm/socket.h      |  2 ++
 include/net/inet_sock.h                   |  4 +++-
 include/net/sock.h                        |  7 +++++++
 include/uapi/asm-generic/socket.h         |  2 ++
 net/core/sock.c                           | 13 +++++++++++++
 net/ipv4/ip_output.c                      | 19 ++++++++++++++-----
 net/ipv6/ip6_output.c                     | 20 ++++++++++++++------
 11 files changed, 75 insertions(+), 12 deletions(-)

diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index 8199e6917671..b37bfbfc7d79 100644
--- a/Documentation/networking/timestamping.rst
+++ b/Documentation/networking/timestamping.rst
@@ -194,6 +194,20 @@ SOF_TIMESTAMPING_OPT_ID:
   among all possibly concurrently outstanding timestamp requests for
   that socket.
 
+  The process can optionally override the default generated ID, by
+  passing a specific ID with control message SCM_TS_OPT_ID (not
+  supported for TCP sockets)::
+
+    struct msghdr *msg;
+    ...
+    cmsg			 = CMSG_FIRSTHDR(msg);
+    cmsg->cmsg_level		 = SOL_SOCKET;
+    cmsg->cmsg_type		 = SCM_TS_OPT_ID;
+    cmsg->cmsg_len		 = CMSG_LEN(sizeof(__u32));
+    *((__u32 *) CMSG_DATA(cmsg)) = opt_id;
+    err = sendmsg(fd, msg, 0);
+
+
 SOF_TIMESTAMPING_OPT_ID_TCP:
   Pass this modifier along with SOF_TIMESTAMPING_OPT_ID for new TCP
   timestamping applications. SOF_TIMESTAMPING_OPT_ID defines how the
diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index e94f621903fe..99dec81e7c84 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
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
index 394c3b66065e..f01dd273bea6 100644
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
+#define IPCORK_TS_OPT_ID	2	/* ts_opt_id field is valid, overriding sk_tskey */
 
 enum {
 	INET_FLAGS_PKTINFO	= 0,
diff --git a/include/net/sock.h b/include/net/sock.h
index f51d61fab059..a2738cfd4804 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -952,6 +952,12 @@ enum sock_flags {
 };
 
 #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
+/*
+ * The highest bit of sk_tsflags is reserved for kernel-internal
+ * SOCKCM_FLAG_TS_OPT_ID. There is a check in core/sock.c to control that
+ * SOF_TIMESTAMPING* values do not reach this reserved area
+ */
+#define SOCKCM_FLAG_TS_OPT_ID	BIT(31)
 
 static inline void sock_copy_flags(struct sock *nsk, const struct sock *osk)
 {
@@ -1794,6 +1800,7 @@ struct sockcm_cookie {
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
diff --git a/net/core/sock.c b/net/core/sock.c
index 468b1239606c..4b694a5a3d5d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2831,6 +2831,8 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 {
 	u32 tsflags;
 
+	BUILD_BUG_ON(SOF_TIMESTAMPING_LAST == (1 << 31));
+
 	switch (cmsg->cmsg_type) {
 	case SO_MARK:
 		if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
@@ -2859,6 +2861,17 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 			return -EINVAL;
 		sockc->transmit_time = get_unaligned((u64 *)CMSG_DATA(cmsg));
 		break;
+	case SCM_TS_OPT_ID:
+		if (sk_is_tcp(sk))
+			return -EINVAL;
+		tsflags = READ_ONCE(sk->sk_tsflags);
+		if (!(tsflags & SOF_TIMESTAMPING_OPT_ID))
+			return -EINVAL;
+		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
+			return -EINVAL;
+		sockc->ts_opt_id = *(u32 *)CMSG_DATA(cmsg);
+		sockc->tsflags |= SOCKCM_FLAG_TS_OPT_ID;
+		break;
 	/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
 	case SCM_RIGHTS:
 	case SCM_CREDENTIALS:
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 49811c9281d4..0c7049f50369 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -973,7 +973,7 @@ static int __ip_append_data(struct sock *sk,
 	unsigned int maxfraglen, fragheaderlen, maxnonfragsize;
 	int csummode = CHECKSUM_NONE;
 	struct rtable *rt = dst_rtable(cork->dst);
-	bool paged, hold_tskey, extra_uref = false;
+	bool paged, hold_tskey = false, extra_uref = false;
 	unsigned int wmem_alloc_delta = 0;
 	u32 tskey = 0;
 
@@ -1049,10 +1049,15 @@ static int __ip_append_data(struct sock *sk,
 
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
@@ -1327,6 +1332,10 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 	cork->transmit_time = ipc->sockc.transmit_time;
 	cork->tx_flags = 0;
 	sock_tx_timestamp(sk, ipc->sockc.tsflags, &cork->tx_flags);
+	if (ipc->sockc.tsflags & SOCKCM_FLAG_TS_OPT_ID) {
+		cork->flags |= IPCORK_TS_OPT_ID;
+		cork->ts_opt_id = ipc->sockc.ts_opt_id;
+	}
 
 	return 0;
 }
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f26841f1490f..ff6bd8d85e9a 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1402,7 +1402,10 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	cork->base.tx_flags = 0;
 	cork->base.mark = ipc6->sockc.mark;
 	sock_tx_timestamp(sk, ipc6->sockc.tsflags, &cork->base.tx_flags);
-
+	if (ipc6->sockc.tsflags & SOCKCM_FLAG_TS_OPT_ID) {
+		cork->base.flags |= IPCORK_TS_OPT_ID;
+		cork->base.ts_opt_id = ipc6->sockc.ts_opt_id;
+	}
 	cork->base.length = 0;
 	cork->base.transmit_time = ipc6->sockc.transmit_time;
 
@@ -1433,7 +1436,7 @@ static int __ip6_append_data(struct sock *sk,
 	bool zc = false;
 	u32 tskey = 0;
 	struct rt6_info *rt = dst_rt6_info(cork->dst);
-	bool paged, hold_tskey, extra_uref = false;
+	bool paged, hold_tskey = false, extra_uref = false;
 	struct ipv6_txoptions *opt = v6_cork->opt;
 	int csummode = CHECKSUM_NONE;
 	unsigned int maxnonfragsize, headersize;
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


