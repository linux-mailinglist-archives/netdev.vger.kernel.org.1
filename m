Return-Path: <netdev+bounces-241109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55643C7F5D1
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 09:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D1F8C3423AE
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 08:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3A02EC559;
	Mon, 24 Nov 2025 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDTedkom"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F76E2EBBB4
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763971767; cv=none; b=A0/DGrA8J3doYZEJEvjwFGKp40XVzv800Rf9QFw+3b5IDH+I0snIUhVmEk56jRqUbMJWPKytXmcxzYG3lR4KlTL0QI66KFqNADYgL4FkUnj3AcVNyLG7kWgvQrXAdouYa1gtvuF40AtsGX5OEhL98plsXzhOK9/Zx7tRoILKfEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763971767; c=relaxed/simple;
	bh=7QccW803eL7f/iyJXIZNWKuDIOUar+MdvsM5WTQbMTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i+IBHv8iDmWDCo/Rg72RiU4Xa+cBRHmY+9Sm0KCFsNwomaYgpGOmWOw+eSveG1Fp40jvzEX579AHQ2C7aIC2yRE+Dbfq9qOSFOCMTvMXIBT0h7JqWbydWBhSmJv+Qrs8l8nmDG2pqmAS7v2JKBu88djMgpdYyNJtNn1KjbP84Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDTedkom; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b9387df58cso6435532b3a.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 00:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763971765; x=1764576565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sai63keII1uujc2HiRryylYk6S+BDob0/yjLuIN+/Ws=;
        b=RDTedkomj5At36PC3F+BXYKpkbO9mdFgx/eJ8E3DRBxONvqkNzqjS6qlmDHr/1W+N+
         ca35/4g4sMwBRVC0/z42WK1RjAtjVs6M9tSYVBzBn8qJ75HzdaxcIyS0TbIs0jPZRp4V
         uqEUD8tHeYUeQGtPKBtaaK4iz7GcGDeABXJ8cS0SsK1thkV64x4m4h5IxCW52wq22qoM
         2/X9pfOh38p4f7QUMZcThlrDq0Fpplpvc/YnDLI+5+lNtn++aysX7rI9qllrJQWZeIkU
         j9Vn4v/ARASDVcdOFwU27rnKSWz5wTJZsOgzWBgtpVcD1OsK0AthYoNbG4sCxaZe6svT
         HpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763971765; x=1764576565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sai63keII1uujc2HiRryylYk6S+BDob0/yjLuIN+/Ws=;
        b=TBG0BWd4Cg6HXbA4VjTPH9F/6IKgc44K6547fi6J34lVPwJ42p+7hcSeWn9XQ0TfUu
         emIpYmUzdBXtJuAmtvVnmZaTg+90OSKOigUiia7v9w0HbJmCOl8ynZ+c28fwjMMGIxhG
         5emjf4XWDGJomCBDmFdMoWzk1OF9wcriRPL1NhHtXOn8xpwT2LFL+erlpV+nXDN/LrFm
         NT8Z4v8L6dys4yFIYIRS36jBUZZ+r/mS21wf0A/LlMUNVmY6j16mtjDxD5AfYbP4OGvM
         F2Twh3V+Jhg+g3JVcvykt8q0XnGXqJsz8JLLSoGiXNpY0TZMck8/Q53HBBEdXGg0JI+2
         1Caw==
X-Forwarded-Encrypted: i=1; AJvYcCXalguqe+HdFh218nrdLfwdLQW3Erca1r3QJvvkOOFi5pwrCakapq3jN9CyZ9qEIyOvDrqcgak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+cCqRUqXjgHLHaz4HvOEdSm7t7pkX9yrbHbEG6IOOi3PInDTw
	yslM9Iu5dMncpFF7Vu+n65hhEDoqWwVe4cHtFjBs4ozicnpQaEdjNlkh
X-Gm-Gg: ASbGnctbzMl9XedDNwLnmz77bynJKeqHmQGZ2M90ZYYzCpdctmLaKALVJZXh87nh3Oo
	CmKC+7RaulCNij3Law09RM4k6NMhPVRswJQBG6UBCB7YWYuVbyQ9lojVxIVc05WGvHRiSMOTt98
	65urave2LxYzW6JcQw74T5EQNJEPkwFEgYgJjMpkOwcn9KLBwoCp0QEqDz+hV+iZDEGXX69mE6q
	P/RsdKRWf1KaLtBdXl9LSTuJFx09VerTYaNLO6oZAPYSo8SZk3TrxU5apgjKdSnKaObA+FMRph3
	8l4+1Mk0xgEe/7gwB0GiVBObdBCyuqB1yCkXnK4rzdYojWrsmJv4TiVxDCrx7MNQ/w2QbwiYgvF
	sxDvOL/1yFJssADmloIlvr6pdqzkS+plANYvPGXtplyYpQo8n0yBOmC64Kn8OudL0Z9nABHn8O5
	4Zpqh7PJ6sxarfuvXGeLyPJ3bZ6X8PjHhDqQyCua18nefP2b5ZFZla5a4vav6xf9EfDOmLO9UE
X-Google-Smtp-Source: AGHT+IGEe6v25Drb1fpnPFTvO5rkcFw3F3TYJ5gGtIRf4auhQqn70IkpH+Mqko7T567f1Rqxqnd7mw==
X-Received: by 2002:a05:6a20:7483:b0:361:3bda:e197 with SMTP id adf61e73a8af0-3614eb3a735mr12462300637.4.1763971764597;
        Mon, 24 Nov 2025 00:09:24 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75b61c29dsm12343837a12.0.2025.11.24.00.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 00:09:24 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 3/3] xsk: convert cq from spin lock protection into atomic operations
Date: Mon, 24 Nov 2025 16:08:58 +0800
Message-Id: <20251124080858.89593-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251124080858.89593-1-kerneljasonxing@gmail.com>
References: <20251124080858.89593-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Now it's time to convert cq in generic path into atomic operations
to achieve a higher performance number. I managed to see it improve
around 5% over different platforms.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xsk_buff_pool.h |  5 -----
 net/xdp/xsk.c               | 12 ++----------
 net/xdp/xsk_buff_pool.c     |  1 -
 3 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 92a2358c6ce3..0b1abdb99c9e 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -90,11 +90,6 @@ struct xsk_buff_pool {
 	 * destructor callback.
 	 */
 	spinlock_t cq_prod_lock;
-	/* Mutual exclusion of the completion ring in the SKB mode.
-	 * Protect: when sockets share a single cq when the same netdev
-	 * and queue id is shared.
-	 */
-	spinlock_t cq_cached_prod_lock;
 	struct xdp_buff_xsk *free_heads[];
 };
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 4e95b894f218..6b99a7eeb952 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -548,13 +548,7 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 
 static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 {
-	int ret;
-
-	spin_lock(&pool->cq_cached_prod_lock);
-	ret = xskq_prod_reserve(pool->cq, false);
-	spin_unlock(&pool->cq_cached_prod_lock);
-
-	return ret;
+	return xskq_prod_reserve(pool->cq, true);
 }
 
 static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
@@ -587,9 +581,7 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 {
-	spin_lock(&pool->cq_cached_prod_lock);
-	xskq_prod_cancel_n(pool->cq, n, false);
-	spin_unlock(&pool->cq_cached_prod_lock);
+	xskq_prod_cancel_n(pool->cq, n, true);
 }
 
 static void xsk_inc_num_desc(struct sk_buff *skb)
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 51526034c42a..9539f121b290 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -91,7 +91,6 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 	INIT_LIST_HEAD(&pool->xsk_tx_list);
 	spin_lock_init(&pool->xsk_tx_list_lock);
 	spin_lock_init(&pool->cq_prod_lock);
-	spin_lock_init(&pool->cq_cached_prod_lock);
 	refcount_set(&pool->users, 1);
 
 	pool->fq = xs->fq_tmp;
-- 
2.41.3


