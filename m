Return-Path: <netdev+bounces-70847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8CD850C74
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 01:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2EA1F21EF9
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 00:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F02A193;
	Mon, 12 Feb 2024 00:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Vid30Fsn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54431FA2
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 00:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707696860; cv=none; b=Voe8CDntf+ks3S9jO8w+uWVa1MFIpux676bMnKB+XGiauCcOz+cnSyudJKdSU3TrvDarDbnzYAFMdweq32RdOw18gXHZKi0zZDKqv9NdTCiiXySrtElvlA0E9vvhNFihxEGRQQw9TW8d8cv04fJD6iiyOqlJMLqmJbvQDeZ9HcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707696860; c=relaxed/simple;
	bh=eLIsbCedowxgdSXIKSQfV7nbIVK1gCViK7g55DvvGuU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QIZgnU7dNYRR6AfCeyg1yHwaoxth4Ou407pz0c3p8+qTE9ibExhEBwTveDuDWQJbB9Brs1qI/vIV7BlSpCE1gzNzuIqEn1Mpk8pX3YZX2aT4VgRwfhZw2YaXseVK5I7QbAZuJ6uzao8gT0771ICbm8wItlLpRmeUSm7QUrEvgGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Vid30Fsn; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 41BAXvGY024674;
	Sun, 11 Feb 2024 16:13:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=v3XUaLn04Rzdj34drqI45QHI0Vj31Iv2ZKt+SSxDH4o=;
 b=Vid30Fsn7qQ1brAVF2uwgM960xdTcYgjBoY+lP2jzKkGzHXNw0yGGxMowd2oclpRWyu0
 3TzkXHYux527noZOrDe6jecJ/Ri/XQG2xfuySsMmWeMOk7Yx4fE+EHVgyJC61uop3/2r
 nD5/03z5XaDg4W8sdWND3Ugs8IEUFDvYbEG+fSbVKUEFHJBeXz1AE9F4BN95aIL4ckA8
 FP4rNQa6bl7ix9uw7YYEo8W8ebsloOpkXY93O1bDyN9i98s4pLIhqB0VHhPn2kAdmA6f
 KByKqcMUxSb1THvpUL3AA6RD4NIc4jyM69pth/PB388+8ZG39ixy0bBGk/gJnSZy0HbI pA== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3w65hfw9jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 11 Feb 2024 16:13:53 -0800
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server id
 15.1.2507.35; Sun, 11 Feb 2024 16:13:50 -0800
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>
CC: Vadim Fedorenko <vadfed@meta.com>, Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Willem de Bruijn
	<willemb@google.com>, <netdev@vger.kernel.org>
Subject: [PATCH net v2] net-timestamp: make sk_tskey more predictable in error path
Date: Sun, 11 Feb 2024 16:13:40 -0800
Message-ID: <20240212001340.1719944-1-vadfed@meta.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 22guu4yYPwqaFWnoI3Q-RMR_1ZeSOImB
X-Proofpoint-ORIG-GUID: 22guu4yYPwqaFWnoI3Q-RMR_1ZeSOImB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-11_22,2024-02-08_01,2023-05-22_02

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
 net/ipv4/ip_output.c  | 14 +++++++++-----
 net/ipv6/ip6_output.c | 14 +++++++++-----
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 41537d18eecf..ac4995ed17c7 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -974,7 +974,7 @@ static int __ip_append_data(struct sock *sk,
 	struct rtable *rt = (struct rtable *)cork->dst;
 	unsigned int wmem_alloc_delta = 0;
 	bool paged, extra_uref = false;
-	u32 tskey = 0;
+	u32 tsflags, tskey = 0;
 
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
 
+	tsflags = READ_ONCE(sk->sk_tsflags);
+	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
+	    tsflags & SOF_TIMESTAMPING_OPT_ID)
+		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+
 	/* So, what's going on in the loop below?
 	 *
 	 * We use calculated fragment length to generate chained skb,
@@ -1274,6 +1275,9 @@ static int __ip_append_data(struct sock *sk,
 	cork->length -= length;
 	IP_INC_STATS(sock_net(sk), IPSTATS_MIB_OUTDISCARDS);
 	refcount_add(wmem_alloc_delta, &sk->sk_wmem_alloc);
+	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
+	    tsflags & SOF_TIMESTAMPING_OPT_ID)
+		atomic_dec(&sk->sk_tskey);
 	return err;
 }
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index a722a43dd668..42e423012c18 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1422,7 +1422,7 @@ static int __ip6_append_data(struct sock *sk,
 	int err;
 	int offset = 0;
 	bool zc = false;
-	u32 tskey = 0;
+	u32 tsflags, tskey = 0;
 	struct rt6_info *rt = (struct rt6_info *)cork->dst;
 	struct ipv6_txoptions *opt = v6_cork->opt;
 	int csummode = CHECKSUM_NONE;
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
 
+	tsflags = READ_ONCE(sk->sk_tsflags);
+	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
+	    tsflags & SOF_TIMESTAMPING_OPT_ID)
+		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
+
 	/*
 	 * Let's try using as much space as possible.
 	 * Use MTU if total length of the message fits into the MTU.
@@ -1794,6 +1795,9 @@ static int __ip6_append_data(struct sock *sk,
 	cork->length -= length;
 	IP6_INC_STATS(sock_net(sk), rt->rt6i_idev, IPSTATS_MIB_OUTDISCARDS);
 	refcount_add(wmem_alloc_delta, &sk->sk_wmem_alloc);
+	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
+	    tsflags & SOF_TIMESTAMPING_OPT_ID)
+		atomic_dec(&sk->sk_tskey);
 	return err;
 }
 
-- 
2.39.3


