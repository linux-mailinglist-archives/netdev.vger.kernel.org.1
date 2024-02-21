Return-Path: <netdev+bounces-73539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D9F85CE6B
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0077A1C21BFD
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B240128382;
	Wed, 21 Feb 2024 02:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzLgNU2g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2C238FAF
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484300; cv=none; b=IedkoH/fq6hilbxLChFiCAi9bqj76u+Gd5Ps8iJJpD6FMBg6Q5BEZ8ELT6xFnnyBipOWL/SNt7e2QPVaYQBjNHLkIN+SLGj/xhH1ZFIXdig4Yz8gHr/3cOD0dDSCCCS4v4BemvdTEsvDCg36nZiHNO2pvdu5N/46aVtFi63+7BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484300; c=relaxed/simple;
	bh=+oB9bCqM/YOunIyLC8qL1zcuXiE83vh81zuKY7xt54E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O2LgKGTiGCGV7Qn4NHH39nzHHkf/xmPztE1AXL++dXsLDIh/k492CkLLWobtHxFcZKAJQOCSRKiwk98OGsFQAdCDXxq8pXp4dbH4Tzfe0c6n0QXrvOLXKsDRFWl7db7smxAzGj8dGN1qpF/29KThAXJOHnO82i0GaerZlzMOARw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzLgNU2g; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2997a92e23bso76854a91.3
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 18:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708484298; x=1709089098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+pMxQ+qM7QenehqlykV5c27xeYnL/w2kLKJPI3UU+M=;
        b=BzLgNU2g1ul7YGHN59jiWetJ8S+xCg9svkoSedmW7BIW03R7+HCn741TDTOJypZp0N
         PHh38dHzmhXl5UrLoM6WFXX16pHSj7Ys5X9AIlN8beYoM8WxHQeD7R20W1VnNPMMfPS+
         a4b4KIXSMNKKNb6IFK3QEpwaGR3ccS7wvNkSaw7PrQqcOrD0nksWNI1nOMXVfrmROZdV
         5t2Bjn43oPIdXgsZFh9oukd64/gtbtX9mtoTdlzRiWMWsu9Rc3FIA132jp1Otp8r1yJf
         rmQ91E49Cjrf0xsCJgma4JZVzvmgPy0QQBJ4Nlj9PFN7qCqOXAjRnhxbTCgwTpelh5LA
         ABJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484298; x=1709089098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+pMxQ+qM7QenehqlykV5c27xeYnL/w2kLKJPI3UU+M=;
        b=MzZ+LHy4N2fhRi94hAF7K06QF36X1OTnnIlwIk6dZgg7j4Z6P/be782LEMyb/cBUK7
         20kUBRH9XaJEXgynWU9Btlgle/rDuTMtb+B6FivPP/83V+iGNtDi3H/smbaXCO3KuTjQ
         /I7Xbjr4zNai3JZdggpEpRsr7N4uUnBb5YRkIisQlNjyhVdNo4Uy1aUi+nD8ioRQc/j6
         OCCnXtkscuKz9YyTMashULLpUrHo0HYc3F2ntfaeMOzhBTi/oxbS6H274etmwXE1Sojd
         m7C5EYgnqZP9L81CbHm7ZxPvr6LOPn0+u5visc9GxiAq/l5U8x6n804Y1aOi4hHywMZh
         k0Aw==
X-Gm-Message-State: AOJu0Yx8VbUNmk09ugpD9eNgJQy4XuLMal8u9T29KBXmg9Oj9Zt8Qu71
	84ZM85Vt25CjCpd88mSwvXciPhXqcXtpxFBeOMkCY4P+ruoWt4YX
X-Google-Smtp-Source: AGHT+IG4MIsP5ppGx7BKiyFqRyrPC/yeV2Ap/ov/hdNSCZpLPHfTjSA5qV4yTPxIqcIjDFlrYlCwxg==
X-Received: by 2002:a17:90b:3942:b0:299:f6e1:67d1 with SMTP id oe2-20020a17090b394200b00299f6e167d1mr2755169pjb.13.1708484298593;
        Tue, 20 Feb 2024 18:58:18 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id pv14-20020a17090b3c8e00b0029454cca5c3sm426467pjb.39.2024.02.20.18.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 18:58:18 -0800 (PST)
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
Subject: [PATCH net-next v7 10/11] tcp: make dropreason in tcp_child_process() work
Date: Wed, 21 Feb 2024 10:57:30 +0800
Message-Id: <20240221025732.68157-11-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240221025732.68157-1-kerneljasonxing@gmail.com>
References: <20240221025732.68157-1-kerneljasonxing@gmail.com>
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
v7
Link: https://lore.kernel.org/all/20240219043815.98410-1-kuniyu@amazon.com/
1. adjust the related part of code only since patch [04/11] is changed.
---
 net/ipv4/tcp_ipv4.c | 16 ++++++++++------
 net/ipv6/tcp_ipv6.c | 20 +++++++++++++-------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c79e25549972..c886c671fae9 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1917,7 +1917,8 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		if (!nsk)
 			return 0;
 		if (nsk != sk) {
-			if (tcp_child_process(sk, nsk, skb)) {
+			reason = tcp_child_process(sk, nsk, skb);
+			if (reason) {
 				rsk = nsk;
 				goto reset;
 			}
@@ -2276,12 +2277,15 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v4_restore_cb(skb);
-		} else if (tcp_child_process(sk, nsk, skb)) {
-			tcp_v4_send_reset(nsk, skb);
-			goto discard_and_relse;
 		} else {
-			sock_put(sk);
-			return 0;
+			drop_reason = tcp_child_process(sk, nsk, skb);
+			if (drop_reason) {
+				tcp_v4_send_reset(nsk, skb);
+				goto discard_and_relse;
+			} else {
+				sock_put(sk);
+				return 0;
+			}
 		}
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 4f8464e04b7f..f260c28e5b18 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1654,8 +1654,11 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
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
@@ -1854,12 +1857,15 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		if (nsk == sk) {
 			reqsk_put(req);
 			tcp_v6_restore_cb(skb);
-		} else if (tcp_child_process(sk, nsk, skb)) {
-			tcp_v6_send_reset(nsk, skb);
-			goto discard_and_relse;
 		} else {
-			sock_put(sk);
-			return 0;
+			drop_reason = tcp_child_process(sk, nsk, skb);
+			if (drop_reason) {
+				tcp_v6_send_reset(nsk, skb);
+				goto discard_and_relse;
+			} else {
+				sock_put(sk);
+				return 0;
+			}
 		}
 	}
 
-- 
2.37.3


