Return-Path: <netdev+bounces-73963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4E385F6EE
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8233281FC8
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6FE45943;
	Thu, 22 Feb 2024 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iecIJiW5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A89322099
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601440; cv=none; b=KE78JMOYC7A/w2tRZmEt3fAMZZwkgKqPJJeGsx9jKM65J819s0M8cxOeOpF6lIVaAIVHY5C5ajOV1bz16YDTmei0d5BJWUKd5u+gLu3Rf3i/GxZVvPfa9kyY1LaxxlK7rRve5sBj12mpuihLFe/928+qb2pGAsh1Sjbv6jTHkCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601440; c=relaxed/simple;
	bh=9vObEw0daP1MZax2J/paAekIR2+zAOqCm/mP681mELs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j7Z5Bhi67RtqdWBD6VYnwY1YdiqS9Nohwcr51rrU8eCFUT9jFoQ2dFGPKXje1SvKtseZMdmTFbdi5a/5mtbveSRtydtqj5jFoArBkKJSK264kUIIsT4j+g/e5CalzSDXRJ/fD2mQeQ09WvQMF/YvU+O5lXjktCpt3xqXx4rNGN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iecIJiW5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d95d67ff45so14373435ad.2
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 03:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708601439; x=1709206239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xxx9oewCjmLxxoGy8R0ZdgnazTwiaiUyyMRu/7UH48Y=;
        b=iecIJiW5keWUDSxzwaQzp94KgU65tn60K6FTJXb+3M/wn/vPGyzA4q9743edTTP2dL
         4N74CfzvScQrbcy1/6JBZD6ypD0PDX4HPKhuS0aCOfpES29E4IiJsdHhiRLmuOU2lWQ9
         D+p4v5/72OVh0Iwe3NyVnxO9SdTbStEvV1N94tQgA+DWN6k9k2eQK83gBYQpLegHuD2a
         WYV8baTdWn7cJmOEOPJiRNrjj5HtXX0pNzaOP2hGwiswyPduoFkup9kWold/jB/g0AnU
         dTtph1CYWVQW3JjKSD12twYRZdmfik+r03T5yOCw2SxG0knsoFXhKFE74fzrA3kTCdgB
         QO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601439; x=1709206239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xxx9oewCjmLxxoGy8R0ZdgnazTwiaiUyyMRu/7UH48Y=;
        b=PvkcQVJeHuDWXSdEKqUwIQMEqRETiS+fR0dGlh/De71Zj/91n4oL3XJGqtGC6apy++
         4O30kvqYYAoOKpamVcaWzbvBjdadzjKo1JUtUOj2P9SjXsFIxA3ytmrT5Rk+5iWoK58h
         dLMheznEsUmVozDQ2nEm/8PjDvXVyVdmuXHi7eHJoxzAFq5qMi74YjGlefrCJfz34kS8
         KtU1koCA6QXxP1tTH6/lBP/UTjvxnhZA53A/dW0bckMcjNbkcR7MnzK60KzX7qv3Fv6m
         J0WW2Yyt0kmIyh8KBxvy1WItoXkvV/CDFVHSRBJ7T/olqVvJxRZRMq+EUHgat/WbC0oY
         uC9Q==
X-Gm-Message-State: AOJu0Yye+TT+KSC+aOvmXbNfdCz/CJDbZpKeqfz1mtLjcDn0ygirjgUd
	qp5c/rSYfkPcX86wCuFtAJ6Jzs4B63DCkNbl4BLseqmJRQoQfqIi
X-Google-Smtp-Source: AGHT+IETQweYGizYjvQ3hehiPBxEkcXkKg6m7KgX0bl478jDrV7Rks70fU6lC/OLL9NWEEYdSBCWjg==
X-Received: by 2002:a17:902:e804:b0:1dc:334:a85e with SMTP id u4-20020a170902e80400b001dc0334a85emr12377169plg.17.1708601438748;
        Thu, 22 Feb 2024 03:30:38 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902a9c300b001dc0955c635sm5978637plr.244.2024.02.22.03.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:30:38 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v8 10/10] tcp: make dropreason in tcp_child_process() work
Date: Thu, 22 Feb 2024 19:30:03 +0800
Message-Id: <20240222113003.67558-11-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240222113003.67558-1-kerneljasonxing@gmail.com>
References: <20240222113003.67558-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

It's time to let it work right now. We've already prepared for this:)

Signed-off-by: Jason Xing <kernelxing@tencent.com>
--
v8
Link: https://lore.kernel.org/netdev/CANn89i+huvL_Zidru_sNHbjwgM7==-q49+mgJq7vZPRgH6DgKg@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CANn89iKmaZZSnk5+CCtSH43jeUgRWNQPV4cjc0vpWNT7nHnQQg@mail.gmail.com/
1. squash v7 patch [11/11] into the current patch.
2. refine the rcv codes. (Eric)

v7
Link: https://lore.kernel.org/all/20240219043815.98410-1-kuniyu@amazon.com/
1. adjust the related part of code only since patch [04/11] is changed.
---
 net/ipv4/tcp_ipv4.c | 12 +++++++-----
 net/ipv6/tcp_ipv6.c | 16 ++++++++++------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c79e25549972..a22ee5838751 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1907,7 +1907,6 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		return 0;
 	}
 
-	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (tcp_checksum_complete(skb))
 		goto csum_err;
 
@@ -1917,7 +1916,8 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		if (!nsk)
 			return 0;
 		if (nsk != sk) {
-			if (tcp_child_process(sk, nsk, skb)) {
+			reason = tcp_child_process(sk, nsk, skb);
+			if (reason) {
 				rsk = nsk;
 				goto reset;
 			}
@@ -2276,10 +2276,12 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v4_restore_cb(skb);
-		} else if (tcp_child_process(sk, nsk, skb)) {
-			tcp_v4_send_reset(nsk, skb);
-			goto discard_and_relse;
 		} else {
+			drop_reason = tcp_child_process(sk, nsk, skb);
+			if (drop_reason) {
+				tcp_v4_send_reset(nsk, skb);
+				goto discard_and_relse;
+			}
 			sock_put(sk);
 			return 0;
 		}
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 4f8464e04b7f..f677f0fa5196 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1623,7 +1623,6 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (np->rxopt.all)
 		opt_skb = skb_clone_and_charge_r(skb, sk);
 
-	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
 		struct dst_entry *dst;
 
@@ -1654,8 +1653,11 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 		struct sock *nsk = tcp_v6_cookie_check(sk, skb);
 
 		if (nsk != sk) {
-			if (nsk && tcp_child_process(sk, nsk, skb))
-				goto reset;
+			if (nsk) {
+				reason = tcp_child_process(sk, nsk, skb);
+				if (reason)
+					goto reset;
+			}
 			if (opt_skb)
 				__kfree_skb(opt_skb);
 			return 0;
@@ -1854,10 +1856,12 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v6_restore_cb(skb);
-		} else if (tcp_child_process(sk, nsk, skb)) {
-			tcp_v6_send_reset(nsk, skb);
-			goto discard_and_relse;
 		} else {
+			drop_reason = tcp_child_process(sk, nsk, skb);
+			if (drop_reason) {
+				tcp_v6_send_reset(nsk, skb);
+				goto discard_and_relse;
+			}
 			sock_put(sk);
 			return 0;
 		}
-- 
2.37.3


