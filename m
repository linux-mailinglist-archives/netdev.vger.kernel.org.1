Return-Path: <netdev+bounces-125033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A0F96BAC8
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3636F1F24AF7
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACED01CF7CB;
	Wed,  4 Sep 2024 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="niIMpA6X"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA73E1D097A
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449558; cv=none; b=nhh+HrpGOiecLQlKiTSlHtEpn/TqOKj0UGF7rSPEjvjVJqC+1hqMdsWWOzHHeHA//Dpt42Vq9OUxf+xP+egW9pOH20GYl6WFzbCMItVg1Nct7fLLF18OOa6ML2R7OWJ5QvCGc4RKwOPxKLKAgJyyktA6fhTTHM01isOZr5GxTxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449558; c=relaxed/simple;
	bh=sBy2TocILV8gL+EMMR9Ja26bsF2LqSA3A8DEaDPkMyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kxkwhpo/WGeSsVizv5b5MseO/nKqEMYi57RT3r+sYLIQ8zmKz0gmhLlPmE9cRLyrJBOPM2c+h6C79r14T3u/KtzWw9Y0A1xTUzBVeW7kZsMjmuMX5bADPzjsSFhY0c3tUQyI5iqN7umTJCWnBzVa+/QeJQ/I9E8sBZJwzlF+QSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=niIMpA6X; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483NmIQ7001461;
	Wed, 4 Sep 2024 04:32:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=WKgq1uL/R61cjoOyC64IWcTeEI10OqyRB7nKwjP4lA4=; b=
	niIMpA6XaFMNpKMrjnvamMwVyijYi1QcqJv2n5JnO+++yuHzESIFCbwssqZSS8w6
	KTv0IlCLezzIsZR/4UqpUj86jOWLqnQdiNmt/yGQUbX5JLrVC+f1FhWxSI6SyfAg
	d8GFdQDy6xsKZu/j386bPTtDkPjH+YWZ12wgndCJ8qVJ0L0LAJZhYPcL4YNtKosZ
	8gdqOwW+JdpoJ/Kh9LElX7DktFl0goZBRZafPVrVg9KUzhu9mBzbmFWu0BLwp5IF
	HK4lnBgMgx5yuh3ZMRirWq/bfiEqUAPDvYL9xLh3I3y3rINuasxd/VZvVLrvjNS1
	y6TCaA+fa0Q8GVt82ZJKEQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41dgyf2uqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 04 Sep 2024 04:32:21 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.11; Wed, 4 Sep 2024 11:32:18 +0000
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
Subject: [PATCH net-next v3 1/4] net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message
Date: Wed, 4 Sep 2024 04:31:48 -0700
Message-ID: <20240904113153.2196238-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904113153.2196238-1-vadfed@meta.com>
References: <20240904113153.2196238-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: cSEfVQLGEv5R_g9_yZIMkoqjU28WDYZi
X-Proofpoint-ORIG-GUID: cSEfVQLGEv5R_g9_yZIMkoqjU28WDYZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_09,2024-09-04_01,2024-09-02_01

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

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 Documentation/networking/timestamping.rst | 13 +++++++++++++
 arch/alpha/include/uapi/asm/socket.h      |  2 ++
 arch/mips/include/uapi/asm/socket.h       |  2 ++
 arch/parisc/include/uapi/asm/socket.h     |  2 ++
 arch/sparc/include/uapi/asm/socket.h      |  2 ++
 include/net/inet_sock.h                   |  4 +++-
 include/net/sock.h                        |  2 ++
 include/uapi/asm-generic/socket.h         |  2 ++
 include/uapi/linux/net_tstamp.h           |  7 +++++++
 net/core/sock.c                           |  9 +++++++++
 net/ipv4/ip_output.c                      | 18 +++++++++++++-----
 net/ipv6/ip6_output.c                     | 18 +++++++++++++-----
 12 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index 5e93cd71f99f..e365526d6bf9 100644
--- a/Documentation/networking/timestamping.rst
+++ b/Documentation/networking/timestamping.rst
@@ -193,6 +193,19 @@ SOF_TIMESTAMPING_OPT_ID:
   among all possibly concurrently outstanding timestamp requests for
   that socket.
 
+  The process can optionally override the default generated ID, by
+  passing a specific ID with control message SCM_TS_OPT_ID::
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
index f51d61fab059..c6554ad82961 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -952,6 +952,7 @@ enum sock_flags {
 };
 
 #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
+#define SOCKCM_FLAG_TS_OPT_ID	BIT(31)
 
 static inline void sock_copy_flags(struct sock *nsk, const struct sock *osk)
 {
@@ -1794,6 +1795,7 @@ struct sockcm_cookie {
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
index a2c66b3d7f0f..1c38536350e7 100644
--- a/include/uapi/linux/net_tstamp.h
+++ b/include/uapi/linux/net_tstamp.h
@@ -38,6 +38,13 @@ enum {
 				 SOF_TIMESTAMPING_LAST
 };
 
+/*
+ * The highest bit of sk_tsflags is reserved for kernel-internal
+ * SOCKCM_FLAG_TS_OPT_ID. This check is to control that SOF_TIMESTAMPING*
+ * values do not reach this reserved area
+ */
+static_assert(SOF_TIMESTAMPING_LAST != (1 << 31));
+
 /*
  * SO_TIMESTAMPING flags are either for recording a packet timestamp or for
  * reporting the timestamp to user space.
diff --git a/net/core/sock.c b/net/core/sock.c
index 468b1239606c..ac70c759a371 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2859,6 +2859,15 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 			return -EINVAL;
 		sockc->transmit_time = get_unaligned((u64 *)CMSG_DATA(cmsg));
 		break;
+	case SCM_TS_OPT_ID:
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
index eea443b7f65e..bd2f6a699470 100644
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
+	    READ_ONCE(sk->sk_tsflags) & SOCKCM_FLAG_TS_OPT_ID) {
+		if (cork->flags & IPCORK_TS_OPT_ID) {
+			tskey = cork->ts_opt_id;
+		} else {
+			tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+			hold_tskey = true;
+		}
+	}
 
 	/* So, what's going on in the loop below?
 	 *
@@ -1325,8 +1330,11 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 	cork->mark = ipc->sockc.mark;
 	cork->priority = ipc->priority;
 	cork->transmit_time = ipc->sockc.transmit_time;
+	cork->ts_opt_id = ipc->sockc.ts_opt_id;
 	cork->tx_flags = 0;
 	sock_tx_timestamp(sk, ipc->sockc.tsflags, &cork->tx_flags);
+	if (ipc->sockc.tsflags & SOCKCM_FLAG_TS_OPT_ID)
+		cork->flags |= IPCORK_TS_OPT_ID;
 
 	return 0;
 }
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f26841f1490f..9b87d23314e8 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1401,7 +1401,10 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	cork->base.gso_size = ipc6->gso_size;
 	cork->base.tx_flags = 0;
 	cork->base.mark = ipc6->sockc.mark;
+	cork->base.ts_opt_id = ipc6->sockc.ts_opt_id;
 	sock_tx_timestamp(sk, ipc6->sockc.tsflags, &cork->base.tx_flags);
+	if (ipc6->sockc.tsflags & SOCKCM_FLAG_TS_OPT_ID)
+		cork->base.flags |= IPCORK_TS_OPT_ID;
 
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
+	    READ_ONCE(sk->sk_tsflags) & SOCKCM_FLAG_TS_OPT_ID) {
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


