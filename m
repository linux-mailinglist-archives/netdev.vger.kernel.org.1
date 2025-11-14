Return-Path: <netdev+bounces-238768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A88C5F325
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 21:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EFD1335E1F8
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 20:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEDF34B190;
	Fri, 14 Nov 2025 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKhy3BAm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD88346FB2
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151214; cv=none; b=KNwskxjvVX3q9leRtuMndXQnK/EDYrNQ56rNg0z7r11RO8coYXNNBJAh+j1ERp8RmW5PWgMNKqY0Cby77wu8Auu3sigXTC7E9vqSzbaqSGV1szVDMsg5HvwHgNQcWogZpIGbcrEBOvft6tdGIecQztuTas9f0JtjH3YjeVdgfa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151214; c=relaxed/simple;
	bh=93105ecoRT5r5on2KqS0VsbTh5hx3bo1CP91kuviTXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhCbgklAgiAoY0sXEpZaYeY/9L7iu86XIVwWzkL1zxWJrNp74cpQ+0f4wDjOsq0QEDGgig5USZqhHEccnh8sqLWwB9mHGLXm8jtXt8IfbJY2SsGeCJjapA5rGR2ZZ2E+6wRZ1jm584fwMSSPt/uNuzVHFNQx+xojit3b2tn6SRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKhy3BAm; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so1654587b3a.2
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 12:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763151212; x=1763756012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7Bt9m/p2AJWfBv3iIQBjeNxzWFIsQsFGSYYCtm67mA=;
        b=MKhy3BAmJcrngjE4AyS5bdcBfBoV/ZT4SpF6VUrLDlyXkVLTvPmLXqVEW5Ef0N0810
         D20OxN+aMCgG5yvoGnooG37Cezex1fgKb+t3sUVN79/gsHKy0ZM7wrGSsbc9Lde6SKRG
         ysDR230jBeJk5nhszCNk5oPnCMEhZ/cs26501ZmbKR0CrHNqlh7/Jh/GTcqrg5GF7/Gr
         J/ZQfhwZy5X1bfW1fx9uhpXKdcAzNJ/a/oZ/y105N9LtjNYClZP73RmXhPXIH8Eghhjd
         rn20ZOhCE3Mko16FwTFwAr67NGXHHdecWsJkSAzN+H5egX6MLE0aEhaKoAWuJqENcJ0Y
         h78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763151212; x=1763756012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s7Bt9m/p2AJWfBv3iIQBjeNxzWFIsQsFGSYYCtm67mA=;
        b=cPTzxRPPq5aWUUvxNZ2owdHaZPIs7vujzBKX5Pxlq5P2nYtnPcn4GzBMguaTjd/WPp
         eyDJdwl+Nyq0gp7mWVmH5rW+fH6NZR3iAiwbX8wf6EqFwae6SBwPuC2/MJy+Gqo96+mv
         mPBo3T6BcLtgHNGVfhc5mbD58/GSsieqL9ckNfcAiXjmjoXplG0E7XpL2ZaxtzZCK+nQ
         uIUTm/YSDNvkSvkoofJLO5kHtweDFRH6bReqQJq2M01fR1iqjSE8dC861/5tW9hKLhg7
         GnorvZqtr4AlgaiN9LRwj4Zk+XLVvC62Bf0KT0a0t8H62SsP3dwQbUQNbdP78Z82ravt
         E1OQ==
X-Gm-Message-State: AOJu0YyGeJPuzjcLIhMSnGaXfOAJ0qZJjl1UFYcurZxXn7ozCF8X0WYD
	cGcWeJweX6I7Ia9l5nanz1P7Wvj34FR//SO8l5j5jeowvzeZGNWd3G2b
X-Gm-Gg: ASbGncuUtAkoSAZp7gdK/cSW2gaKq4258pPJv9I0Vx5+iiazEpvEjJs6270AM66SdsJ
	gDOt9V1rBB1J1/LxkuB64jDIcfInEGkHp6OzG6XvzqfUTn6fJUY+a7v59doksGBG7OMaEQaJuV8
	y1ofISkvleT7R3AuD2VqR5pJTQBBWUn3XfnydkM3C6ct5FxcxGpTgrk+yXoRcUp0vfPu9BvLJpx
	IFvJKqauDECPBkjvxdYfchtjHCtDsFH1JUB0QrVJ9oapLK26YeqERsLVY+4bw/M3Q7FuRx5hKVH
	hF4sR7FuKP9fvAIg/3362vBl5OTd8ODxPzGmNaRp9iV9PT2GyS2NI4oRZ4u4mLMtb8pKXFkmSWX
	zIdVoNEW95qh6wLn4275pSGtSEbCNoHD8lRQBoQX2famOfJzqFrlOJYBzggqEDSq4DTM/BaUKlv
	BtISFNFbERjWUj
X-Google-Smtp-Source: AGHT+IGfHgXm61hYdHTkloJP9EDQCcxFDGflpotWcq7LwMcu6jjpvDlesAn1RbhH90CuGtl/BpGsCw==
X-Received: by 2002:a05:6a20:2588:b0:34e:cc0a:40b2 with SMTP id adf61e73a8af0-35ba1c8a64dmr6034617637.30.1763151212243;
        Fri, 14 Nov 2025 12:13:32 -0800 (PST)
Received: from localhost ([2a03:2880:ff:f::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37507fc7bsm5560241a12.23.2025.11.14.12.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 12:13:32 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	memxor@gmail.com,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 2/4] bpf: Remove smap argument from bpf_selem_free()
Date: Fri, 14 Nov 2025 12:13:24 -0800
Message-ID: <20251114201329.3275875-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114201329.3275875-1-ameryhung@gmail.com>
References: <20251114201329.3275875-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since selem already saves a pointer to smap, use it instead of an
additional argument in bpf_selem_free(). This requires moving the
SDATA(selem)->smap assignment from bpf_selem_link_map() to
bpf_selem_alloc() since bpf_selem_free() may be called without the
selem being linked to smap in bpf_local_storage_update().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  1 -
 kernel/bpf/bpf_local_storage.c    | 19 ++++++++++---------
 net/core/bpf_sk_storage.c         |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 3663eabcc3ff..4ab137e75f33 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -187,7 +187,6 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
 		bool swap_uptrs, gfp_t gfp_flags);
 
 void bpf_selem_free(struct bpf_local_storage_elem *selem,
-		    struct bpf_local_storage_map *smap,
 		    bool reuse_now);
 
 int
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 400bdf8a3eb2..95a5ea618cc5 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -97,6 +97,8 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	}
 
 	if (selem) {
+		RCU_INIT_POINTER(SDATA(selem)->smap, smap);
+
 		if (value) {
 			/* No need to call check_and_init_map_value as memory is zero init */
 			copy_map_value(&smap->map, SDATA(selem)->data, value);
@@ -227,9 +229,12 @@ static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
 }
 
 void bpf_selem_free(struct bpf_local_storage_elem *selem,
-		    struct bpf_local_storage_map *smap,
 		    bool reuse_now)
 {
+	struct bpf_local_storage_map *smap;
+
+	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
+
 	if (!smap->bpf_ma) {
 		/* Only task storage has uptrs and task storage
 		 * has moved to bpf_mem_alloc. Meaning smap->bpf_ma == true
@@ -263,7 +268,6 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 static void bpf_selem_free_list(struct hlist_head *list, bool reuse_now)
 {
 	struct bpf_local_storage_elem *selem;
-	struct bpf_local_storage_map *smap;
 	struct hlist_node *n;
 
 	/* The "_safe" iteration is needed.
@@ -271,10 +275,8 @@ static void bpf_selem_free_list(struct hlist_head *list, bool reuse_now)
 	 * but bpf_selem_free will use the selem->rcu_head
 	 * which is union-ized with the selem->free_node.
 	 */
-	hlist_for_each_entry_safe(selem, n, list, free_node) {
-		smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
-		bpf_selem_free(selem, smap, reuse_now);
-	}
+	hlist_for_each_entry_safe(selem, n, list, free_node)
+		bpf_selem_free(selem, reuse_now);
 }
 
 /* local_storage->lock must be held and selem->local_storage == local_storage.
@@ -432,7 +434,6 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&b->lock, flags);
-	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 	raw_spin_unlock_irqrestore(&b->lock, flags);
 }
@@ -586,7 +587,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 		err = bpf_local_storage_alloc(owner, smap, selem, gfp_flags);
 		if (err) {
-			bpf_selem_free(selem, smap, true);
+			bpf_selem_free(selem, true);
 			mem_uncharge(smap, owner, smap->elem_size);
 			return ERR_PTR(err);
 		}
@@ -662,7 +663,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	bpf_selem_free_list(&old_selem_free_list, false);
 	if (alloc_selem) {
 		mem_uncharge(smap, owner, smap->elem_size);
-		bpf_selem_free(alloc_selem, smap, true);
+		bpf_selem_free(alloc_selem, true);
 	}
 	return err ? ERR_PTR(err) : SDATA(selem);
 }
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index bd3c686edc0b..850dd736ccd1 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -196,7 +196,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		} else {
 			ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
 			if (ret) {
-				bpf_selem_free(copy_selem, smap, true);
+				bpf_selem_free(copy_selem, true);
 				atomic_sub(smap->elem_size,
 					   &newsk->sk_omem_alloc);
 				bpf_map_put(map);
-- 
2.47.3


