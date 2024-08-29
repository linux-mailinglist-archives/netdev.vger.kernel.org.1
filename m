Return-Path: <netdev+bounces-123492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B6696514A
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5A61C24059
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB31818C00F;
	Thu, 29 Aug 2024 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="R+tkzF3S"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D004D18A92B
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 20:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724964593; cv=none; b=OJr80yL35bLpRR0ozdiqloPTFBu42dV1HQF0YWrWsuffdTZ50wFjnF/nNSSrxKkxIlR9yyCUtDF2RTdWWuXQWskMNNe2DaTfaiiXCwg+PdSa2jbVlGTx37D6yTJYYGNzbHf32kOup/lt+awz8Jmok0bTizIJbKP1VECQ5DzYgTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724964593; c=relaxed/simple;
	bh=hZiHVBZAvJ6hQ8SnLvVLuHDL5d7zTZBnHewZwO/j1YI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LOC31De9KQ0g2f891O2aQgfe38abv+ZBJ+haZ0Asl2djDx6cd+f6IZ4qE71bACtFWuLA87XUFFrfSMqPuk3+SrlzQ4BJLM2jIOCNwrIwnRDzyo/jC8mmX5q5vbnuPE0awPQyiO2ZkZrouVfXP2g15trg09pbGPdk2VrIcEWvBUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=R+tkzF3S; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 47TJOnFx006749;
	Thu, 29 Aug 2024 13:49:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=sWx
	e0QKPgmTidKfZVRkIqIixathRdf8FI4o2xaeLm0Q=; b=R+tkzF3Sl0VCyP4SoGp
	Ilrw7G+U84wndIqCXkJwTdB5wZ2Q/uxAu7DvBgRsSMDA0a30VEqZoonqqz1BBbhe
	4KnkpXjWPY9Ce0UBCbv+1RR/7p6KU1wI84MtIKPaqI7l/NDpbzxdG+j4N1ylIKL1
	9VBIABye2ix6oR8A0E1pE4RTkdy3ndiS2Z+H/tV0eGkKLlm+nJtSFeuH0oR/WRir
	9pQcQPr/hUBn0zAs1UlE0AnQkCtZNYMaOShtobS2MnAqUH6IqBGSeDpo+OGP9Ded
	xMG8j917QHY5O/ZuDnxrAKc2cB1erjfQf0zUEhczaVrt8XEh7cY5R4ybDSEmEmjY
	YsA==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 41axcg0xde-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 29 Aug 2024 13:49:35 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 29 Aug 2024 20:49:34 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Willem de Bruijn
	<willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 1/2] net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message
Date: Thu, 29 Aug 2024 13:49:21 -0700
Message-ID: <20240829204922.1674865-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: iR0nbqVsVZ2rElZpAT--7XR1BNlfbVbU
X-Proofpoint-ORIG-GUID: iR0nbqVsVZ2rElZpAT--7XR1BNlfbVbU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01

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
 include/net/inet_sock.h           |  4 +++-
 include/net/sock.h                |  1 +
 include/uapi/asm-generic/socket.h |  2 ++
 include/uapi/linux/net_tstamp.h   |  1 +
 net/core/sock.c                   | 12 ++++++++++++
 net/ipv4/ip_output.c              | 13 +++++++++++--
 net/ipv6/ip6_output.c             | 13 +++++++++++--
 7 files changed, 41 insertions(+), 5 deletions(-)

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
index a2c66b3d7f0f..081b40a55a2e 100644
--- a/include/uapi/linux/net_tstamp.h
+++ b/include/uapi/linux/net_tstamp.h
@@ -32,6 +32,7 @@ enum {
 	SOF_TIMESTAMPING_OPT_TX_SWHW = (1<<14),
 	SOF_TIMESTAMPING_BIND_PHC = (1 << 15),
 	SOF_TIMESTAMPING_OPT_ID_TCP = (1 << 16),
+	SOF_TIMESTAMPING_OPT_ID_CMSG = (1 << 17),
 
 	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_OPT_ID_TCP,
 	SOF_TIMESTAMPING_MASK = (SOF_TIMESTAMPING_LAST - 1) |
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
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index b90d0f78ac80..65b5d9f53102 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1050,8 +1050,14 @@ static int __ip_append_data(struct sock *sk,
 
 	hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
 		     READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
-	if (hold_tskey)
-		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+	if (hold_tskey) {
+		if (cork->flags & IPCORK_TS_OPT_ID) {
+			hold_tskey = false;
+			tskey = cork->ts_opt_id;
+		} else {
+			tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+		}
+	}
 
 	/* So, what's going on in the loop below?
 	 *
@@ -1324,8 +1330,11 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
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
index f26841f1490f..91eafef85c85 100644
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
@@ -1545,8 +1548,14 @@ static int __ip6_append_data(struct sock *sk,
 
 	hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
 		     READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
-	if (hold_tskey)
-		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+	if (hold_tskey) {
+		if (cork->flags & IPCORK_TS_OPT_ID) {
+			hold_tskey = false;
+			tskey = cork->ts_opt_id;
+		} else {
+			tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+		}
+	}
 
 	/*
 	 * Let's try using as much space as possible.
-- 
2.43.5


