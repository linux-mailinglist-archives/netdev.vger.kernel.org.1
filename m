Return-Path: <netdev+bounces-71899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3682D8558A9
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 02:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F8B287084
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 01:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AEB1109;
	Thu, 15 Feb 2024 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxRmNy38"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C1B10F2
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707960051; cv=none; b=rDclnfkAZ228vx/+RJsfaiTZC1sQ09ca+RPcBcCH0V/q747DXOpbv4XWYXXgDmOcL8HttYImyPxf0GVPyDti12gw/xBb6QvoWfTaYuiuF4Hv052qsGs7ixeORa4beJwENoUEQjzpnggcVkXYqsNbApYDxTgFnRFijbfgqoxizMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707960051; c=relaxed/simple;
	bh=beTa8kvuVAR1xuuwoOtkmKnK0Wn7xIsrcdGr8CPSjQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t1Ge55hXcceLs1KE3YO+GDNVorV4v3Wymfxt6+JXiYpXgdv6jhv7iDmIrZzAigAnVDh6iAvHlF87r5l5y8FtD+DmkuTiKKU6woKgoWnGwzirMxoSdba1mS7bs7ByP8TAI4ei2miw/TESHSq5/8da8Z5BKhUrpJ2NFegc6kV5Tyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxRmNy38; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dc4a487b1eso299988a12.1
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707960049; x=1708564849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiHRSiDQCWhkRJWyWtx70sVdTRuKjyaav9BVyuxi7cY=;
        b=JxRmNy388irNwI4irZxg+6xaT+3dDeW0JaoSSsv/cSqwm6Du4bzSQ3hKR95tat3jKo
         0qr+2w6KwReNZpaq65LsQz98ldFKr9bnvKT9bmzpQcm873shgyu4FNZg906zkHvBZ/AM
         c46wOERNf6ZLM6LU4LF6V7+ZR9E+AZhey1tqgYUphBzFJ3wKiWP2eDSLRdqg50jYi7Z3
         KbWCu5s+7ZjHRRhujXoXtKV1BYXqZrAAgnCJ4uWEchADvwaYvFgb5TrfbcWtG6FD1jdN
         9xd77WtqwUziS+bPkHhQgnTWvA6URyoloHgrdbpvQPv9m+CgiEfnaC1D/GF+A28D2V4h
         7MAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707960049; x=1708564849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiHRSiDQCWhkRJWyWtx70sVdTRuKjyaav9BVyuxi7cY=;
        b=JyIcOZCJ1SC3q9+8C/10oXFPb35z71wkwMiy8h1qhD9sB2TaWHY+q3EvuIswCimVsN
         9lEUajU8Bm59K6HKsgGRAvfUPONWPoVjhJgMsUJ2jEamGK/75hK0xBQ9+FwuinyZMenT
         VLuZhxXJF5hp1xCUuWj89/RKt0BzMM0Rq0EileQhZ0vZLrJRyeOldwGqPt6UofQX6BFn
         KP4VCLoY8j8ANbDuzbnB516/Qmh0Dw88yucTeFZL+B7dlUpGY7JM/OsCQYx5zQ7Be5HR
         IJYKtrF98xo8T67ElSb0ne8r9dyaEVYhVB1xYD1yI0U9AUwTo8izRqCkc0wQSiU4JvbY
         vRVQ==
X-Gm-Message-State: AOJu0YyrysV8QDeWkAnGjtGV0e/0DtkEXUA5AjzY0kEFy7XsRrFFT00g
	FvlL/WTlY1RD0iOYF17xiUGwzgivnmM/Sd7Gt8z3q1yFFaIi5yI6lkm/G3FcQP7A4g==
X-Google-Smtp-Source: AGHT+IGJCB55CJHp4KHiooRvLHqwkE/Exc59N5YISxxjl0/EPAtRMjKH316vilybiCzQ/ucd1IdyEw==
X-Received: by 2002:a05:6a21:3513:b0:19c:aba2:69e5 with SMTP id zc19-20020a056a21351300b0019caba269e5mr680074pzb.45.1707960049506;
        Wed, 14 Feb 2024 17:20:49 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.234])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090a6c0200b00298ae12699csm163417pjj.12.2024.02.14.17.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 17:20:49 -0800 (PST)
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
Subject: [PATCH net-next v5 02/11] tcp: directly drop skb in cookie check for ipv4
Date: Thu, 15 Feb 2024 09:20:18 +0800
Message-Id: <20240215012027.11467-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240215012027.11467-1-kerneljasonxing@gmail.com>
References: <20240215012027.11467-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Only move the skb drop from tcp_v4_do_rcv() to cookie_v4_check() itself,
no other changes made. It can help us refine the specific drop reasons
later.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/syncookies.c | 4 ++++
 net/ipv4/tcp_ipv4.c   | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index be88bf586ff9..38f331da6677 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -408,6 +408,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	struct rtable *rt;
 	__u8 rcv_wscale;
 	int full_space;
+	SKB_DR(reason);
 
 	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
 	    !th->ack || th->rst)
@@ -477,10 +478,13 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (ret)
 		inet_sk(ret)->cork.fl.u.ip4 = fl4;
+	else
+		goto out_drop;
 out:
 	return ret;
 out_free:
 	reqsk_free(req);
 out_drop:
+	kfree_skb_reason(skb, reason);
 	return NULL;
 }
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0c50c5a32b84..0a944e109088 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1915,7 +1915,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 		struct sock *nsk = tcp_v4_cookie_check(sk, skb);
 
 		if (!nsk)
-			goto discard;
+			return 0;
 		if (nsk != sk) {
 			if (tcp_child_process(sk, nsk, skb)) {
 				rsk = nsk;
-- 
2.37.3


