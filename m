Return-Path: <netdev+bounces-242576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 501EAC922C3
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 14:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97B2C351454
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 13:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2C722FDEA;
	Fri, 28 Nov 2025 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBvqWl1u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D341C701F
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764337581; cv=none; b=cBvi1YChcxHSQCtxuVLFm9xXGP+20MDV63TRFHiKhQXQuJHc+udbTUYaJOUcyJiXMxu0HYksrK/i46RxJZkI8GM7HmJuh0E+NiERdGiBitW1wfSYw56Yef6jIjG0CFe2UFO3EALOwlGqdXT+HRsUywKdJf96xovuHHtjKwXvbgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764337581; c=relaxed/simple;
	bh=8Pca9WZtiP7HBlUrjHiwKmprAWD+pRMPdOh4BKMS3/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ApTsEFDdHkd0t4XkDpogIn9OeISoCGL7plq4i830XKCTVbVyKR22I6WObM0Di1hywYESrURacX+I7J1SB+gBToSV7uOhyUapUQ9KV/CexUHvY/4naidLZNzyJpsweEKG63AWn9tsB6V+lijuNOCcsst0s+J08BcHtiw90Qnq4t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBvqWl1u; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b80fed1505so2281739b3a.3
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 05:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764337579; x=1764942379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQDNEhv41SZxn4CZSqiXIPfZRRdklxmN+y0WIhNggug=;
        b=aBvqWl1uhni+rLrHc1PwpM2TYfnKFAmNihTjSRZDc1XojD5lGIUjpavzJah+2UfJPg
         YoYfyjXzFMpw3BenBK/bJmumajhGLg47W/lJlquTJ6ZhJVC5H+ToHYZLbbBOj4xDjHyl
         Q006DQBZh+G4siBRME3OV/ZsbKKjCNWxITSS3aWXENpEvZiFWkWUB5eUlxkNMBhr8XIX
         nGxx9dPZuC3UVE1ehoPoHzc0bqzSIolUsJF1xQdtly74h20qHl+wMVTw+KHmJPFDH9f3
         Nq6KbPwcqdRwtNhmIYGeXGzgzmR1P+G2dXXyQkXRkb47q14mrarZzizBH9GH8PrjMbKx
         lIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764337579; x=1764942379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DQDNEhv41SZxn4CZSqiXIPfZRRdklxmN+y0WIhNggug=;
        b=rmcAeMa3QE+Azro7PVvLvDm7ouW25J+5gnjLcCmWbf4Eg13yYOG6obk2GcMn8UlIt5
         e5l4groAIGD5brwkc6thXUdcquLRE0OdodrX++V/5FDr7b7LPYwFHtFPbqkXXWJjvBGQ
         JpwyswzftUjuNEKv+XblaguYuupIwezi1fUrbAkHfmoCS4vikzMVZImbeMZ/ZQkJId7s
         Mh968XrK/Eag8t2674u+iujcySL0APxyBxPWan7iK1ZhwNrrS5EeKPNQT9+x/7W4habf
         NiDKXS/RMVaEGUVezGKSdx70liBD49+x1bJ6yyE368qM2f6puKap4olXfGgJjzaMrmzs
         Vg1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQQ/JE65qQAjERAzgWcgByLwH89zzWPxq4al4PMRzp610UBREWSr5h9NBW8HYTirrJdqINbYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJgP3UyukY77eoK09EDVmI+P82sDvXfjYBcNDDVdxy2wGOl5xq
	e8Jrk4rc8oXB39VmCIeh+Ht5P8jsV+fGgZdcOj0Csawwvl1Fq+0gW5Rg
X-Gm-Gg: ASbGncvNSUsUNnoVX56WOhhQmom7kX8ELhqIMml57IY8fRAktezwacc8dKPge4oOTx7
	MsyDMKMqLVFyIvEiZ/kGdMDUN8GD/W2s2O8yc8fxL+o7Pd2SmaHkqr7SpWYSiJajITSgiUkweuw
	egzQeMfSBEKB65uFCMnUzk+QM/kpLfwlba8wdfzBs5gnYkSOuUc0b0PoR8BzBiq7G0wvytWiCt1
	zFJJir0oyzVRYGTzLsNtkMxWfz0qsaLjcxun/qhlPKPMNdxpKMUAL6pxam6etA0Y0mIDUxQCUaf
	c0/sgWU2NoIaBaCJvxYa2Zgf/6MGKUq90tdM7rlyw7jCGz/lSiRfvgo3PVvHnSV8TTceM/E1feG
	5F5sWHPbjWopvimXyntyklAw3BLX/DMhHsvZ8dyohnaFP/CkUyMlQhOLcI2axbWq94qT96gEd2w
	PofsJ3g1it+xua8exAE1swlCJsw8qSd+VR3WNYYmBbVgx+z1qC
X-Google-Smtp-Source: AGHT+IGPpk69AHln8lXw/rw3UXGAEU8DPLMGKvQIO/OtV98mEWYurcZQVG99Fqvskfqef8UN8NfbFw==
X-Received: by 2002:a05:6a21:339a:b0:35d:3bcf:e518 with SMTP id adf61e73a8af0-3614e96095bmr30935286637.0.1764337579276;
        Fri, 28 Nov 2025 05:46:19 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([114.253.35.215])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fbde37d7sm4792674a12.13.2025.11.28.05.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 05:46:18 -0800 (PST)
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
Subject: [PATCH net-next v3 2/3] xsk: use atomic operations around cached_prod for copy mode
Date: Fri, 28 Nov 2025 21:46:00 +0800
Message-Id: <20251128134601.54678-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251128134601.54678-1-kerneljasonxing@gmail.com>
References: <20251128134601.54678-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Use atomic_try_cmpxchg operations to replace spin lock. Technically
CAS (Compare And Swap) is better than a coarse way like spin-lock
especially when we only need to perform a few simple operations.
Similar idea can also be found in the recent commit 100dfa74cad9
("net: dev_queue_xmit() llist adoption") that implements the lockless
logic with the help of try_cmpxchg.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
Paolo, sorry that I didn't try to move the lock to struct xsk_queue
because after investigation I reckon try_cmpxchg can add less overhead
when multiple xsks contend at this point. So I hope this approach
can be adopted.
---
 net/xdp/xsk.c       |  4 ++--
 net/xdp/xsk_queue.h | 17 ++++++++++++-----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index bcfd400e9cf8..b63409b1422e 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -551,7 +551,7 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 	int ret;
 
 	spin_lock(&pool->cq_cached_prod_lock);
-	ret = xskq_prod_reserve(pool->cq);
+	ret = xsk_cq_cached_prod_reserve(pool->cq);
 	spin_unlock(&pool->cq_cached_prod_lock);
 
 	return ret;
@@ -588,7 +588,7 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 {
 	spin_lock(&pool->cq_cached_prod_lock);
-	xskq_prod_cancel_n(pool->cq, n);
+	atomic_sub(n, &pool->cq->cached_prod_atomic);
 	spin_unlock(&pool->cq_cached_prod_lock);
 }
 
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 44cc01555c0b..7fdc80e624d6 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -402,13 +402,20 @@ static inline void xskq_prod_cancel_n(struct xsk_queue *q, u32 cnt)
 	q->cached_prod -= cnt;
 }
 
-static inline int xskq_prod_reserve(struct xsk_queue *q)
+static inline int xsk_cq_cached_prod_reserve(struct xsk_queue *q)
 {
-	if (xskq_prod_is_full(q))
-		return -ENOSPC;
+	int free_entries;
+	u32 cached_prod;
+
+	do {
+		q->cached_cons = READ_ONCE(q->ring->consumer);
+		cached_prod = atomic_read(&q->cached_prod_atomic);
+		free_entries = q->nentries - (cached_prod - q->cached_cons);
+		if (free_entries <= 0)
+			return -ENOSPC;
+	} while (!atomic_try_cmpxchg(&q->cached_prod_atomic, &cached_prod,
+				     cached_prod + 1));
 
-	/* A, matches D */
-	q->cached_prod++;
 	return 0;
 }
 
-- 
2.41.3


