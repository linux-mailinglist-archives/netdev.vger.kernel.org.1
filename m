Return-Path: <netdev+bounces-170802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C829A49F45
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA501890F06
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 16:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B4B257430;
	Fri, 28 Feb 2025 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYitOn+a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582FF18E743
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761358; cv=none; b=azZGsU8CYsydYWHo3iYTiHOFYLZZcV3/lQDxqsptEoCCkBkSMX9c5hAwSQo8gjD504A7mzRe4s7XCTQBQT7VGUhJOT9yyg8JLCNOOjBI0BDpndPiwO0OTw7dCCoUJag6TnJBBaN04KwApbLHqTTjqG4uo4dpir49rlZNfXRIqR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761358; c=relaxed/simple;
	bh=EXBcpIHqMuxBio1D3ZvZIySagLnm/xWnJwPbyuqU2m0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bPZaEePXP7Tt9yX2pMI7VVDyKbBPjv4ewX9y8qqOuxrlBlh4dsfVz2CGzfATMSI7qsRcx7BfGIN6n4UW/CuOK8zNSuRxJaw2mdirsaKGAOU48CN7kXX9xgU4oEwLebQG1lpbf1KGFPXkZiknJ+ROVZ/zr/URPm0K2JVvY5/CuiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYitOn+a; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223378e2b0dso36756955ad.0
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 08:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740761355; x=1741366155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDiJVUxakL2CijKwcP06M1V6bbGdjtRGCWRm5Cif+2o=;
        b=nYitOn+aiodB0rFT5YTsOzbeQ+ydmPLKq1oBWTEKh8b+gb1uSNY4VeZEPRJhZdwuNG
         oVMFCvhqadKI53jbbT76BAhK2sKaQJRSVLnJmK5izf2ux0jccSNHZBND9AgG1/nYE16Z
         EKbDePzUroONrBOKtTqqbojdsmUTmUL20zzFTRpQuDOJv4T6TU59nmDvLN58QQGzqVsD
         v24JwlTWriuam9phiRwgHHQMg2D4Oezz+XfpzDJYqT0/dbarbRithlnxoCDjdRE/I/O/
         kkN6oHnKSmsOlWljjB3dJ0wdBuu8U9pKYc3+4dxTqGmQMrr+a4iX7IuQoe4lTttRJwYj
         yiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761355; x=1741366155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDiJVUxakL2CijKwcP06M1V6bbGdjtRGCWRm5Cif+2o=;
        b=quHH+TtEwIkQd65JUIkeqj/Z/aRaK2E2bezO4s7be+pIuaFSZ406izqFyj1upagni7
         I70tCZ7LRSLmm6VzaBd0Sq+bC4uC8Mp+mYHhwqbvOqijpUYnWKXGqFg5pQWrqJUYwTzB
         /gg1YfVcqbWjf9C/KTdhiQMsmKCNlFc3Pq1GiZdlUUHKoFYaH6h1sByscKz2bP+PeZV6
         lwo2/Bo6PbpqB939p318xo2wRmGWaJDMdpFbasiAbOpBwhNsUSgbaSrimc7iOf1KoX/Y
         LxnBOc/cE3VNdOx75/Ob3PcwtITpMM3r/4AZf24qcdR0tlhNyb7YJujqkfxSyvQYkTBy
         DVYQ==
X-Gm-Message-State: AOJu0YyZV1B0qNm60A3t0NUWF64Ien0TpK4mHx3YPfOkmmQpvgBup9je
	0749jLqU8sE9TBaW+cZ56Mwh9kusAAZuS4J73pV5pSOvCwKCshtm
X-Gm-Gg: ASbGncvhdwSjPRVwNJmjh1e2rxgc1NanwBMzF3AmejGzUQA1A9mNHvimmsGr8VGD22c
	eR3ym9tutd8mVS61UeyFoH1M25YGCmODudQqDbeX3pdmOjeVSIA39wUV1QkN2+5PG+OSiTSUAOB
	b6R3Q+GMH2YYED/ohZ2gf9cOX4KyEkw+g8p9vM+qXgrLckHWWTIhzcZTrirOTvEPLd7F0IDqyvb
	2hUH6CdUucY9534x8tMOVt1pa1T0sMLlYKldLQGVxddt4GDNncExcjJ+Q5LZ+PUgd/B9l/5Jp/I
	2KFhi4J9lQEnxozkuT2ROOjCYCCS9nympHNHLb2rnNDETmSUZ3SnWsmyI9/THGng
X-Google-Smtp-Source: AGHT+IEzGuscDc5vG+hv3Ge9hh6QS8maG7bebf67/WICV6Qh1+rip9AstJ28UMJ6kaGrQbJwyTyBow==
X-Received: by 2002:a05:6a00:b48:b0:732:6221:edea with SMTP id d2e1a72fcca58-734ac338552mr7765393b3a.3.1740761354061;
        Fri, 28 Feb 2025 08:49:14 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734ad3f3c2fsm2078921b3a.54.2025.02.28.08.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:49:13 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ncardwell@google.com,
	kuniyu@amazon.com,
	dsahern@kernel.org,
	willemb@google.com,
	willemdebruijn.kernel@gmail.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next] net-timestamp: support TCP GSO case for a few missing flags
Date: Sat,  1 Mar 2025 00:49:04 +0800
Message-Id: <20250228164904.47511-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When I read through the TSO codes, I found out that we probably
miss initializing the tx_flags of last seg when TSO is turned
off, which means at the following points no more timestamp
(for this last one) will be generated. There are three flags
to be handled in this patch:
1. SKBTX_HW_TSTAMP
2. SKBTX_HW_TSTAMP_USE_CYCLES
3. SKBTX_BPF

This patch initializes the tx_flags to SKBTX_ANY_TSTAMP like what
the UDP GSO does. But flag like SKBTX_SCHED_TSTAMP is not useful
and will not be used in the remaining path since the skb has already
passed the QDisc layer.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/ipv4/tcp_offload.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 2308665b51c5..886582002425 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -13,12 +13,15 @@
 #include <net/tcp.h>
 #include <net/protocol.h>
 
-static void tcp_gso_tstamp(struct sk_buff *skb, unsigned int ts_seq,
+static void tcp_gso_tstamp(struct sk_buff *skb, struct sk_buff *gso_skb,
 			   unsigned int seq, unsigned int mss)
 {
+	u32 flags = skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP;
+	u32 ts_seq = skb_shinfo(gso_skb)->tskey;
+
 	while (skb) {
 		if (before(ts_seq, seq + mss)) {
-			skb_shinfo(skb)->tx_flags |= SKBTX_SW_TSTAMP;
+			skb_shinfo(skb)->tx_flags |= flags;
 			skb_shinfo(skb)->tskey = ts_seq;
 			return;
 		}
@@ -193,8 +196,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	th = tcp_hdr(skb);
 	seq = ntohl(th->seq);
 
-	if (unlikely(skb_shinfo(gso_skb)->tx_flags & SKBTX_SW_TSTAMP))
-		tcp_gso_tstamp(segs, skb_shinfo(gso_skb)->tskey, seq, mss);
+	if (unlikely(skb_shinfo(gso_skb)->tx_flags & (SKBTX_ANY_TSTAMP)))
+		tcp_gso_tstamp(segs, gso_skb, seq, mss);
 
 	newcheck = ~csum_fold(csum_add(csum_unfold(th->check), delta));
 
-- 
2.43.5


