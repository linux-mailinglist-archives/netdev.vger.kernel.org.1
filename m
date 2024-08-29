Return-Path: <netdev+bounces-122994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E625F963694
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 02:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF4C286093
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1388367;
	Thu, 29 Aug 2024 00:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="QYVkx6qR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B804123BF
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 00:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724889855; cv=none; b=tmGERrFMC3qgtOOrG6WHQckqfJ5R1tIA/Wa/GxefT7QIZvn9SgC1/iw3EVXVsLMR7X7lwIzQ6WGOoPbamAdXZ4Y1MpfhyM6xijWzjJBYkBOVy+XlZD9XcZAZzXneVK0jD8Q4OpydU1IFUCA6Y9VDjULftHbdNX1rrNZSrnBWJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724889855; c=relaxed/simple;
	bh=gelBIWZP5wf4UunLVLr2SWpOEoBzyP8CBE6GWK24A7w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RQI0vTOwY/YsggM79dYSNz7QfSVS2FxGQ1N13MrP3KEi/tNK0llQDjjxcGC3m7tZI2GAxNgHlV8DUJDMktIgve0ng9jJF4eUHt52/Ie4Gx5xmHGCf42mYN0YAse8rxQgAL3HrW/BpVBwQyNBnHBKzYZojG/XYxEIeop5IpaWlRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=QYVkx6qR; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SLhADp027826;
	Wed, 28 Aug 2024 17:04:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=KWd
	D1yaQF+r2sAHpn5vQtE4B12t4qNDNI+XvzjCw22A=; b=QYVkx6qRftsYwO0bzEo
	nIfUETii6qL6O0EAI5psbngn7Y7jMSz1P45FfPzoH7NjRRMQidcTY0l0zoXx3NQI
	Ws3EXqh6GAO/fEI7G4cP/sWJF/ZCRF/0STlG0UmaeYaGo8zyhygwIT+k4hh5MRo1
	V+0Kyf3kdSE6Eud9ntTZFRCOckkZkqBVoMO95VDF4spzXmM2IyLeTwAaeIgsdTG6
	8o7XVC5VvlNFPm7GxcX7lpit0xcPYX5x+5IjoCQpTNm3CWddE0DnpA5WlSLro/Cj
	zlDyGLpXnP2h9sAwFVO2SBT/W/XjY318E/mzkTjyal9wzPjO+c0D+GaE+2sgqryB
	Tkw==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41ac23gpgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 28 Aug 2024 17:04:04 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 29 Aug 2024 00:04:02 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>
Subject: [RFC PATCH] net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message
Date: Wed, 28 Aug 2024 17:03:55 -0700
Message-ID: <20240829000355.1172094-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: pOaGUM5uSzRz40gnnBi-Ev7U2CcFHyhL
X-Proofpoint-GUID: pOaGUM5uSzRz40gnnBi-Ev7U2CcFHyhL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_09,2024-08-28_01,2024-05-17_01

SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
timestamps and packets sent via socket. Unfortunately, there is no way
to reliably predict socket timestamp ID value in case of error returned
by sendmsg [1]. This patch adds new control message type to give user-space
software an opportunity to control the mapping between packets and
values by providing ID with each sendmsg. This works fine for UDP
sockets only, and explicit check is added to control message parser.
Also, there is no easy way to use 0 as provided ID, so this is value
treated as invalid.

[1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 include/net/inet_sock.h           |  1 +
 include/net/sock.h                |  1 +
 include/uapi/asm-generic/socket.h |  2 ++
 net/core/sock.c                   | 14 ++++++++++++++
 net/ipv4/ip_output.c              | 11 +++++++++--
 net/ipv6/ip6_output.c             | 11 +++++++++--
 6 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 394c3b66065e..7e8545311557 100644
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
diff --git a/net/core/sock.c b/net/core/sock.c
index 468b1239606c..918cb6a0dcba 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2859,6 +2859,20 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
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
+		sockc->ts_opt_id = get_unaligned((u32 *)CMSG_DATA(cmsg));
+		/* do not allow 0 as packet id for timestamp */
+		if (!sockc->ts_opt_id)
+			return -EINVAL;
+		break;
 	/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
 	case SCM_RIGHTS:
 	case SCM_CREDENTIALS:
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index b90d0f78ac80..f1e6695cafd2 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1050,8 +1050,14 @@ static int __ip_append_data(struct sock *sk,
 
 	hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
 		     READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
-	if (hold_tskey)
-		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+	if (hold_tskey) {
+                if (cork->ts_opt_id) {
+                        hold_tskey = false;
+                        tskey = cork->ts_opt_id;
+                } else {
+                        tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+                }
+	}
 
 	/* So, what's going on in the loop below?
 	 *
@@ -1324,6 +1330,7 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 	cork->mark = ipc->sockc.mark;
 	cork->priority = ipc->priority;
 	cork->transmit_time = ipc->sockc.transmit_time;
+	cork->ts_opt_id = ipc->sockc.ts_opt_id;
 	cork->tx_flags = 0;
 	sock_tx_timestamp(sk, ipc->sockc.tsflags, &cork->tx_flags);
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f26841f1490f..602064250546 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1401,6 +1401,7 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	cork->base.gso_size = ipc6->gso_size;
 	cork->base.tx_flags = 0;
 	cork->base.mark = ipc6->sockc.mark;
+	cork->base.ts_opt_id = ipc6->sockc.ts_opt_id;
 	sock_tx_timestamp(sk, ipc6->sockc.tsflags, &cork->base.tx_flags);
 
 	cork->base.length = 0;
@@ -1545,8 +1546,14 @@ static int __ip6_append_data(struct sock *sk,
 
 	hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
 		     READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
-	if (hold_tskey)
-		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+	if (hold_tskey) {
+		if (cork->ts_opt_id) {
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


