Return-Path: <netdev+bounces-227689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D21BB5916
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 00:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F41F486195
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 22:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213F82BE620;
	Thu,  2 Oct 2025 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEY+hhPK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782C9296BBC
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445644; cv=none; b=CtnlDkMkmnqg3qRJb8gCi3H4XveE2TgFHl42Pw1B2G+Zn3B1AcZSMvvV+0F6VltY2qzfXReDPh5S7uc0qjl102tkhshT2Z2WdagsapHXVeUwjXxXBLaCVWzEObhyBimhfcpAZc3IMjrL8Q7knuH7cxNLKRxdnLvnXYWZ9q+nup4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445644; c=relaxed/simple;
	bh=rMGQ++fqJXrN6F6DS1T6vb3M4SFLCrCiAGAbwNGBLKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ho1tKtUiP+GhquGiCcf3u8SIrxW0l5EyOuvt9xojepKTsgLiKKHNJ1O2sZJfXoV4hTx7fMCQqM9a/hbn0S8YU8X03JJFfnhnURXffDkk5El1IAEgXk3hQ1Coe3in+ukZ+A3Gf+0vmZRAnp5+lDNo1Ev9oJ1BCXgNC+WmSeTiUsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEY+hhPK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-279e2554c8fso15031875ad.2
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 15:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759445642; x=1760050442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGP7XQKpjbVBHUUnliMlOJ3FrYuoHPcehkOp1EL/9cI=;
        b=DEY+hhPKxzIYdHzzbNtpwYzhXUFiGf69JU4TJeNTSLldEIwAk32mYg3iBEQCdhi5Tr
         /9Hj8YzrLuaupeWy19UYcAGEG+Vm3Qu/CwUp+OZIqJm4yi7vdzsihEUUNHvxcqlK4emA
         mYdrOa4Dm/BVOnycFG984gKQfENpDf299Z5s4L+aM656YuFoGoRHyIB7NKPtTz3adi0h
         wxnsecHEiO6d4BHqv7/wZ1l/Lpux6lKGw5Df59XZVcZeouFQvQ9+uL2qNiaf3nSE4EDB
         44O6fCDFIyH8rNudQX0wiVX6ihbIKe10jjRQguH6cF/U677+w+BmBwNt48LaT4HWe1a0
         j0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445642; x=1760050442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGP7XQKpjbVBHUUnliMlOJ3FrYuoHPcehkOp1EL/9cI=;
        b=I3vaHMwUTZt2/AoTx2N6A/DVvHTvHkE/vdY28g2cHnrAef4zLyGen+midWjh1jCdu3
         wqODufnZdOGnxihvT0bHO0Ym8fo6Cv/crbL2xduKMX59m1ifRjQ1a7iffuWDacrvEQf7
         fWTil7GPC2Jdv1erv8phddVMILh1hJSsRwRaFS+5Pb4d6k4LKl9l8hpVpyxSBABpXojA
         cgjpgVyEb7bhlGV4zz8Gyt0MZPIGx39M38N2lls12EDUspvCR6hKi5UrpF+OfvxLdxkA
         2+th9smptC30ZOSk98wdiR89/C78YgD5+iRej3KzwkR1IWOLltxRGBgdl6o2I7vBcgjY
         ljxw==
X-Gm-Message-State: AOJu0YzLFfVnShf13Ya6M2oT9LWTFV3C/IZXGyOYHhjeti+YRQZCDtRr
	mxc/9iGJjeKzMdt1RFlSjHH3RFMmVoU5gzgtXwCBy/X5x2LlCItSNN3A
X-Gm-Gg: ASbGncsuU+vWsfweRXnjyQLV71XlxY5qgN8RRP+MhZmZURrvGGmY7W/CBRJyictuiJE
	eqSggkL2iyLPhC8EryG3VadxYm0bNxs5N3MNgxZP0y+bKzzgJHM3j+r4JjWCUefksC3oAU3Vi4W
	qFDoTu756/NrrIJun8FmkNWUdx0IyPYiKLYTYZHoK+9WQvdvugEJONuXNizP8+sZyrbr8ayk2Ml
	C0L5ppxh9wAJhHyoz9YX9miOamhtxN2tt7zhuygw6h1GYedU0QMyJuI3xggcFXQjSkkrczeqcjr
	QuioaZDTq+HBKlw3waejjYShczv3vDzSnOdK6R0Mfs3QB8YYQNnHrsoT/Vu6Lr/mAH+c+J+OqSH
	dN7Sc/9WzqMA7ICVHYsnfUC4I/b76loAsJggZ
X-Google-Smtp-Source: AGHT+IEVV/drYL7Gp88PHqD++18OMU6Z6umBxFyXQa/CQ28s2zofDauhblZTf79D86avnwbPCOcwCg==
X-Received: by 2002:a17:902:ccc8:b0:28e:80bc:46b4 with SMTP id d9443c01a7336-28e9a664f0dmr9480685ad.55.1759445641833;
        Thu, 02 Oct 2025 15:54:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b844fsm30695335ad.69.2025.10.02.15.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:54:01 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v2 05/12] bpf: Convert bpf_selem_unlink to failable
Date: Thu,  2 Oct 2025 15:53:44 -0700
Message-ID: <20251002225356.1505480-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251002225356.1505480-1-ameryhung@gmail.com>
References: <20251002225356.1505480-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare changing both bpf_local_storage_map_bucket::lock and
bpf_local_storage::lock to rqspinlock, convert bpf_selem_unlink() to
failable. It still always succeeds and returns 0 until the change
happens. No functional change.

For bpf_local_storage_map_free(), since it cannot deadlock with itself
or bpf_local_storage_destroy who the function might be racing with,
retry if bpf_selem_unlink() fails due to rqspinlock returning errors.

__must_check is added to the function declaration locally to make sure
all callers are accounted for during the conversion.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h | 2 +-
 kernel/bpf/bpf_cgrp_storage.c     | 3 +--
 kernel/bpf/bpf_inode_storage.c    | 4 +---
 kernel/bpf/bpf_local_storage.c    | 6 ++++--
 kernel/bpf/bpf_task_storage.c     | 4 +---
 net/core/bpf_sk_storage.c         | 4 +---
 6 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index dc56fa459ac9..26b7f53dad33 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -180,7 +180,7 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem);
 
-void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
+int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
 
 int bpf_selem_link_map(struct bpf_local_storage_map *smap,
 		       struct bpf_local_storage_elem *selem);
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 0687a760974a..8fef24fcac68 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -118,8 +118,7 @@ static int cgroup_storage_delete(struct cgroup *cgroup, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index e54cce2b9175..cedc99184dad 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -110,9 +110,7 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 9c2b041ae9ca..e0e405060e3c 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -433,7 +433,7 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map *smap,
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 }
 
-void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
+int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 {
 	struct bpf_local_storage_map *storage_smap;
 	struct bpf_local_storage *local_storage;
@@ -472,6 +472,8 @@ void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 
 	if (free_local_storage)
 		bpf_local_storage_free(local_storage, storage_smap, bpf_ma, reuse_now);
+
+	return 0;
 }
 
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
@@ -930,7 +932,7 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 				struct bpf_local_storage_elem, map_node))) {
 			if (busy_counter)
 				this_cpu_inc(*busy_counter);
-			bpf_selem_unlink(selem, true);
+			while (bpf_selem_unlink(selem, true));
 			if (busy_counter)
 				this_cpu_dec(*busy_counter);
 			cond_resched_rcu();
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index a1dc1bf0848a..ab902364ac23 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -167,9 +167,7 @@ static int task_storage_delete(struct task_struct *task, struct bpf_map *map,
 	if (!nobusy)
 		return -EBUSY;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 static long bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index fac5cf385785..7b3d44667cee 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -40,9 +40,7 @@ static int bpf_sk_storage_del(struct sock *sk, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 /* Called by __sk_destruct() & bpf_sk_storage_clone() */
-- 
2.47.3


