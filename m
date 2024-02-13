Return-Path: <netdev+bounces-71281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64CF852EBB
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D8D1F238E9
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3592BB16;
	Tue, 13 Feb 2024 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ErQHSTAR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD212C683
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822288; cv=none; b=n99mshTJCoKfx8YMlbHY/68IBNmKKKX0BZFE3o4CqWLa6BcpEhdTMTgKKgBOfJELg8Awz6Kpqp54VY2ss6wkrj0siGvSSY+CufOeOtVPVep+oe+dzfk1uUxZxq8LLSHFUk6mI8vcgTS2J/ZNpOZ1Dla79RcvrcXIGiM4Te7Ta9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822288; c=relaxed/simple;
	bh=zc1kiQzbg6KPqLhcrThwFQtQTPCn59uDMOI+6IQ7hAM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UE3yE0jRovcpyVDP+JAlgwAED4TeQQy20USta0RaCrCx7yNlXTVpuVtLahrNPDRcqjQFzoVuDF7tSocNFreRoYkM2uj85WaffhovjF3cj9gEPYSjn1nZmkHlczcd7abakUE4Ih9cGbe4aoUVTIW/IOQafElrhnpsIdN2+Oe1XfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ErQHSTAR; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D0Du9D003790;
	Tue, 13 Feb 2024 03:04:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=OW8bheTNJqF/dH+nSTnWpr33anI2DXOgufkyOUtOUso=;
 b=ErQHSTARhyRzNGwCTscqYhbVbTtx16PH/LNazw3OWwQW36Q0+xKjz8wL698EPTFQp2Ar
 hB3UfaVHnsSEdn9avy7ymXb0dJrLd/SsZoY/dnK9yVEimlLaOa10390KvV3Z1VB+N88o
 aTzXzGNZyR5/Hm+unu8+W3TDs/rsRidxJ2oh95gFdAgjNPbK4XR+1Qx0mO5j6x+8ClLm
 Nq7PVZqYe0qXOrsz73b612S4OGvhVLqNL44f2Wtfbojh/yBvF4dn7FOSxZrXmf3bdrdk
 IsOmg1eyQqlMMgZvMZXb3de2jj9fnM33+H1au4qfFKgErUTlCDQQ6SsKdVGoWlx8Upbf oA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3w7wpxa8yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 13 Feb 2024 03:04:36 -0800
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server id
 15.1.2507.35; Tue, 13 Feb 2024 03:04:34 -0800
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>
CC: Vadim Fedorenko <vadfed@meta.com>, Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Willem de Bruijn
	<willemb@google.com>, <netdev@vger.kernel.org>
Subject: [PATCH net v3] net-timestamp: make sk_tskey more predictable in error path
Date: Tue, 13 Feb 2024 03:04:28 -0800
Message-ID: <20240213110428.1681540-1-vadfed@meta.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: qilWR633W7jYMJMvufprlCyh3v7dhjRf
X-Proofpoint-ORIG-GUID: qilWR633W7jYMJMvufprlCyh3v7dhjRf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_05,2024-02-12_03,2023-05-22_02

When SOF_TIMESTAMPING_OPT_ID is used to ambiguate timestamped datagrams,
the sk_tskey can become unpredictable in case of any error happened
during sendmsg(). Move increment later in the code and make decrement of
sk_tskey in error path. This solution is still racy in case of multiple
threads doing snedmsg() over the very same socket in parallel, but still
makes error path much more predictable.

Fixes: 09c2d251b707 ("net-timestamp: add key to disambiguate concurrent datagrams")
Reported-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v1 -> v2: wrong submission
v1 -> v3: 
 - use local boolean variable instead of checking the same conditions
   (suggested by Willem)

 net/ipv4/ip_output.c  | 13 ++++++++-----
 net/ipv6/ip6_output.c | 13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 41537d18eecf..67d846622365 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -972,8 +972,8 @@ static int __ip_append_data(struct sock *sk,
 	unsigned int maxfraglen, fragheaderlen, maxnonfragsize;
 	int csummode = CHECKSUM_NONE;
 	struct rtable *rt = (struct rtable *)cork->dst;
+	bool paged, hold_tskey, extra_uref = false;
 	unsigned int wmem_alloc_delta = 0;
-	bool paged, extra_uref = false;
 	u32 tskey = 0;
 
 	skb = skb_peek_tail(queue);
@@ -982,10 +982,6 @@ static int __ip_append_data(struct sock *sk,
 	mtu = cork->gso_size ? IP_MAX_MTU : cork->fragsize;
 	paged = !!cork->gso_size;
 
-	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
-	    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID)
-		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
-
 	hh_len = LL_RESERVED_SPACE(rt->dst.dev);
 
 	fragheaderlen = sizeof(struct iphdr) + (opt ? opt->optlen : 0);
@@ -1052,6 +1048,11 @@ static int __ip_append_data(struct sock *sk,
 
 	cork->length += length;
 
+	hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
+		     READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
+	if (hold_tskey)
+		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+
 	/* So, what's going on in the loop below?
 	 *
 	 * We use calculated fragment length to generate chained skb,
@@ -1274,6 +1275,8 @@ static int __ip_append_data(struct sock *sk,
 	cork->length -= length;
 	IP_INC_STATS(sock_net(sk), IPSTATS_MIB_OUTDISCARDS);
 	refcount_add(wmem_alloc_delta, &sk->sk_wmem_alloc);
+	if (hold_tskey)
+		atomic_dec(&sk->sk_tskey);
 	return err;
 }
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index a722a43dd668..31b86fe661aa 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1424,11 +1424,11 @@ static int __ip6_append_data(struct sock *sk,
 	bool zc = false;
 	u32 tskey = 0;
 	struct rt6_info *rt = (struct rt6_info *)cork->dst;
+	bool paged, hold_tskey, extra_uref = false;
 	struct ipv6_txoptions *opt = v6_cork->opt;
 	int csummode = CHECKSUM_NONE;
 	unsigned int maxnonfragsize, headersize;
 	unsigned int wmem_alloc_delta = 0;
-	bool paged, extra_uref = false;
 
 	skb = skb_peek_tail(queue);
 	if (!skb) {
@@ -1440,10 +1440,6 @@ static int __ip6_append_data(struct sock *sk,
 	mtu = cork->gso_size ? IP6_MAX_MTU : cork->fragsize;
 	orig_mtu = mtu;
 
-	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
-	    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID)
-		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
-
 	hh_len = LL_RESERVED_SPACE(rt->dst.dev);
 
 	fragheaderlen = sizeof(struct ipv6hdr) + rt->rt6i_nfheader_len +
@@ -1538,6 +1534,11 @@ static int __ip6_append_data(struct sock *sk,
 			flags &= ~MSG_SPLICE_PAGES;
 	}
 
+	hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
+		     READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
+	if (hold_tskey)
+		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+
 	/*
 	 * Let's try using as much space as possible.
 	 * Use MTU if total length of the message fits into the MTU.
@@ -1794,6 +1795,8 @@ static int __ip6_append_data(struct sock *sk,
 	cork->length -= length;
 	IP6_INC_STATS(sock_net(sk), rt->rt6i_idev, IPSTATS_MIB_OUTDISCARDS);
 	refcount_add(wmem_alloc_delta, &sk->sk_wmem_alloc);
+	if (hold_tskey)
+		atomic_dec(&sk->sk_tskey);
 	return err;
 }
 
-- 
2.39.3


