Return-Path: <netdev+bounces-232780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1050C08C72
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 08:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 947754E68DA
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 06:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176512D9EDC;
	Sat, 25 Oct 2025 06:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRWMEWZB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7926A2D94AC
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 06:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375213; cv=none; b=IRJuZTC7svvlI3dGceexmPmRLvUauZrGyiriDpfIi2+ZcwwJ3PsIKdrATw9GhlMXwLE9+ydcEzaLtbTj7Uvgbi554E+444sJMmJtc4lHQhEGOr010pH+JW1ekgHOkNGi2XCDKVrsyD+mslRi5YD++upjNpVfkKc/earazjN/5Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375213; c=relaxed/simple;
	bh=yHJYa/oZkkM7yeGsNEwd046BjncIvs81WsKweJrwmD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YNyInCEB+a6Fwzyac4aTY1ljZn5Q7kp8g7aqYC7W40bP/8MEsfI5Z+GuojHY6Lr7Pcyw1J5m39m3yYwmt1xcspRydsVO1Hh/OdIzF9TsRRYQEnmPoKT1q3MxNSbQW82gK9/ZTPSV1QDP6rlx9KgXBjRb2w/WttOrfziltmfGfVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRWMEWZB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so2243639b3a.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 23:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761375211; x=1761980011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Wd7ZIr1XdhvuS6zESZUWRW9MBlaYzkG5tNVq4WgCIo=;
        b=MRWMEWZBs3vRSjsCFWvYnXZWPylnfheX60eI9NkYxL8HRfieKzKevfZlFU61Hr0Fxp
         mb7Zwek6DhhvZr780IT3ELE4kHW6ClYFZPH63ML90DASWgvOPVysLprBZcTPwctUoNsJ
         q5KWnFd63hsmk2do2i4yEtmBZgb5q3iZ7JtdkTT4F9DRbVsU/Rb7C61Y3jc4/MHnt1wr
         dSporMtPnWx00UWArLWL0A02K0f0Z91a0IThMPka8urxxDmWlfbT5iJFW+oZ4njRpgcW
         TIdQyYJJoDIwzdWjKdVw2occqXpOl3li7k+Dk6srq4jap2ojxlghquWLpwrq8NRI6JQa
         4H3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761375211; x=1761980011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Wd7ZIr1XdhvuS6zESZUWRW9MBlaYzkG5tNVq4WgCIo=;
        b=psMfa6hUo67lwu1ZFtS0/AkMRjFxdz8bfAzJfLmbgnqsZDpA+loUzP2P2sV8YEdyMM
         DwqCk8HYxKiZwbyoVswY8bB6dFeudlU3n9PfVjDZQ6lkFYSFztq94ONhAD/DUc6T2n0N
         SJPsocQVnGubZKBrLCaMEKvFBKzDb5AC58UdE1PzlaUxUTPWMbdlkyFPawijKDC2xYx1
         06Msea2mDVntpin5Zwyi85EnxGTgXs/kAXizk1fN0jEc0KFLMxEk+czbZ7TNvr8ur7zo
         OpMiSBSFyN0IHZ3j7FpAyHoPkTI/cPSOXEwcG3xn10MD0q902EUHuZWRoGbvmuaoI+JM
         KoQw==
X-Forwarded-Encrypted: i=1; AJvYcCXBXUNlqrG9q/nCSdDIekwj120lryIw+fs+V8lZchsB3E6Xp/ZPcdHzRMCIHV38XSMcLUxPD+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcMJERxmlmPVPMId/GuR4+MfeXFdBkDpFQYRkWtaXwrituUWuZ
	qgQ7IIC9LlTheY7FvZR7LeggeKDgGlHnT6DCRAkhTmTnY98mALm/tBza
X-Gm-Gg: ASbGncvmLmWGjbZCboss2LlfguPF/ZCMRmGVUpsQxah/8Tg8XhMLHFelaM43nEQYXux
	+KYMspWEUmEokMl6Vk0H6Nu3Zrd44Bmjpx3chaPEYWIE3jfFlwePRMHRk79++NbW9LlcZy1a/Co
	JfwQkqhdIzKaioyhUQz20XloCg6EM7yKPlycOkdq8pxPYuL86QuujjH3d4OrmW8fjp0w2mIVXz6
	ZRzTKb7FXkInFmnB5bZPOJMq2FiDi2EJXfTgdOrCAzPwKUepVUXPCnOFEkAGDWyYKHuPCX73Iav
	nZyhK+A4Vv7l1p/H2TOlNv9cD5ZwbIU3IcWdZKGKimrsgjyCVrSKzo95T4UATnl1nctLlAKb3lC
	PLQCjU0+k6hekG/xrL7gaNKAQJB7ViDQk2rKECoL4cOPVuL71FAuysNa5FcBkHBqevdCUgEjFqA
	oklcKr1thy0ns3esk5D9e/6JSUVeyMMaHI4wPRpR96VA==
X-Google-Smtp-Source: AGHT+IH1g6mLP57bXNwJV85r0pbZpYpDIDcFse8NWx56uJw5DKkNE1S+ZziJQrVxgpgzAI9XDGxKcg==
X-Received: by 2002:a05:6a20:258a:b0:340:cc06:94ee with SMTP id adf61e73a8af0-340cc069737mr3007713637.60.1761375210660;
        Fri, 24 Oct 2025 23:53:30 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140699basm1262820b3a.50.2025.10.24.23.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 23:53:30 -0700 (PDT)
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
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 2/2] xsk: use a smaller new lock for shared pool case
Date: Sat, 25 Oct 2025 14:53:10 +0800
Message-Id: <20251025065310.5676-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251025065310.5676-1-kerneljasonxing@gmail.com>
References: <20251025065310.5676-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

- Split cq_lock into two smaller locks: cq_prod_lock and
  cq_cached_prod_lock
- Avoid disabling/enabling interrupts in the hot xmit path

In either xsk_cq_cancel_locked() or xsk_cq_reserve_locked() function,
the race condition is only between multiple xsks sharing the same
pool. They are all in the process context rather than interrupt context,
so now the small lock named cq_cached_prod_lock can be used without
handling interrupts.

While cq_cached_prod_lock ensures the exclusive modification of
@cached_prod, cq_prod_lock in xsk_cq_submit_addr_locked() only cares
about @producer and corresponding @desc. Both of them don't necessarily
be consistent with @cached_prod protected by cq_cached_prod_lock.
That's the reason why the previous big lock can be split into two
smaller ones.

Frequently disabling and enabling interrupt are very time consuming
in some cases, especially in a per-descriptor granularity, which now
can be avoided after this optimization, even when the pool is shared by
multiple xsks.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xsk_buff_pool.h | 13 +++++++++----
 net/xdp/xsk.c               | 14 ++++++--------
 net/xdp/xsk_buff_pool.c     |  3 ++-
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index cac56e6b0869..92a2358c6ce3 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -85,11 +85,16 @@ struct xsk_buff_pool {
 	bool unaligned;
 	bool tx_sw_csum;
 	void *addrs;
-	/* Mutual exclusion of the completion ring in the SKB mode. Two cases to protect:
-	 * NAPI TX thread and sendmsg error paths in the SKB destructor callback and when
-	 * sockets share a single cq when the same netdev and queue id is shared.
+	/* Mutual exclusion of the completion ring in the SKB mode.
+	 * Protect: NAPI TX thread and sendmsg error paths in the SKB
+	 * destructor callback.
 	 */
-	spinlock_t cq_lock;
+	spinlock_t cq_prod_lock;
+	/* Mutual exclusion of the completion ring in the SKB mode.
+	 * Protect: when sockets share a single cq when the same netdev
+	 * and queue id is shared.
+	 */
+	spinlock_t cq_cached_prod_lock;
 	struct xdp_buff_xsk *free_heads[];
 };
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 76f797fcc49c..d254817b8a53 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -549,14 +549,13 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 {
 	bool lock = !list_is_singular(&pool->xsk_tx_list);
-	unsigned long flags;
 	int ret;
 
 	if (lock)
-		spin_lock_irqsave(&pool->cq_lock, flags);
+		spin_lock(&pool->cq_cached_prod_lock);
 	ret = xskq_prod_reserve(pool->cq);
 	if (lock)
-		spin_unlock_irqrestore(&pool->cq_lock, flags);
+		spin_unlock(&pool->cq_cached_prod_lock);
 
 	return ret;
 }
@@ -569,7 +568,7 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 	unsigned long flags;
 	u32 idx;
 
-	spin_lock_irqsave(&pool->cq_lock, flags);
+	spin_lock_irqsave(&pool->cq_prod_lock, flags);
 	idx = xskq_get_prod(pool->cq);
 
 	xskq_prod_write_addr(pool->cq, idx,
@@ -586,19 +585,18 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 		}
 	}
 	xskq_prod_submit_n(pool->cq, descs_processed);
-	spin_unlock_irqrestore(&pool->cq_lock, flags);
+	spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
 }
 
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 {
 	bool lock = !list_is_singular(&pool->xsk_tx_list);
-	unsigned long flags;
 
 	if (lock)
-		spin_lock_irqsave(&pool->cq_lock, flags);
+		spin_lock(&pool->cq_cached_prod_lock);
 	xskq_prod_cancel_n(pool->cq, n);
 	if (lock)
-		spin_unlock_irqrestore(&pool->cq_lock, flags);
+		spin_unlock(&pool->cq_cached_prod_lock);
 }
 
 static void xsk_inc_num_desc(struct sk_buff *skb)
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index aa9788f20d0d..add44bd09cae 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -94,7 +94,8 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 	INIT_LIST_HEAD(&pool->xskb_list);
 	INIT_LIST_HEAD(&pool->xsk_tx_list);
 	spin_lock_init(&pool->xsk_tx_list_lock);
-	spin_lock_init(&pool->cq_lock);
+	spin_lock_init(&pool->cq_prod_lock);
+	spin_lock_init(&pool->cq_cached_prod_lock);
 	refcount_set(&pool->users, 1);
 
 	pool->fq = xs->fq_tmp;
-- 
2.41.3


