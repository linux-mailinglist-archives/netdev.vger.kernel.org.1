Return-Path: <netdev+bounces-227685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52305BB58F8
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 00:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C736319C5FDD
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 22:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8435C27EC99;
	Thu,  2 Oct 2025 22:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOAXhUcr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DFA1DC994
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 22:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445640; cv=none; b=i9hkVfdiE2IwDhT2+6VjT8/VXz6ZYVuLc7nYJfuTjeca4xQuU2fAPYiMKqTsQvD8iSPTg66B6x8zxM6UZaT3+dQUyL0iG22zMtYRojbak9vkPRTxMorPAXAJWWiv1aW4NCvuCj0oxw0nGfHcFy312nPvvMuJCskpstEIZgN4CrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445640; c=relaxed/simple;
	bh=464gRjDhWysRp1UFMOn+hjqejnfygGrojzNiCB9m4Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+MOb0GdKEC2nyyjCPy/fioUAuZICpzq0p4BLoPEjZNiP+SgWDyNOdXvN/WtoyKJeG7lILMw43S7E9h+2ktvwKQ7Lg4TC9B6JRf/w39t2XsqWNHGg4KtBWRrugoFxZrCfsZZPqSaNsvV9q2nfSctpe4Jg7Ly0fK5wVtrfHMZUZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOAXhUcr; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b57bffc0248so1120847a12.0
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 15:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759445638; x=1760050438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZA0XDUEcnTqdW6bM7UZOViMWAw8gatLSctO/A3qvR8g=;
        b=lOAXhUcr8mvtRPVk2Eu+1EG1XOfq/QAVSM1Yo5Q8J86Fjd5/YrGR6NP8jLuj2rERxv
         QIr0V7jIOvV2nxit7dKQLoJQfampGVz7daUa63CEn/LJMZJVDn8AVzneMIsV2Ehkfum0
         Rsf6U4Qib0ws39DlafZzVYT6DV73Z/iQGT+Ao90UtbjqAYw9/n8AFlV82nwkxt8iAqUT
         kk8v3V3+jUVUAtopp4Y8UfsJrjewBYTbHfTdp5psOGLJZPi/wP6i+DZD6nl1hFpzjlV0
         FR8AtFUwVKSqPxYTJUlC+2vgMOc2YNTDROkTORF/CZWrsH204qZ9Mj4HQNxDmhd9l6wY
         J1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445638; x=1760050438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZA0XDUEcnTqdW6bM7UZOViMWAw8gatLSctO/A3qvR8g=;
        b=V6hcpmZ/ZWTcXSEvJLHfiGd/iLE5ZU6RrFxkoDeFIQybjk5oBy5ZFBWubXhhoazE1j
         KTbNAdTVGNPxP1v2dWD9h6A5NMXUopUA3COvTl18wlxFqH2XBhPggyfbXD61OUDOMyF+
         q7TVhOB9D5P1neTJjj1Apr6uzumfX6jd+/TmieSzkOAcPcFtvpwTIA7AHk3pyUQnSHus
         uQqzEKXcmJ53dSne1EYEgNjwUyOShLIF2I0yVQtUSrBDhz4SEoNK44zPwb5yrdONkWpE
         slITYp5z0gAqisI96ZFtfuy6GfmRACNRmO8VJnNstyToQKz1rB6p679AkKk3ZKpyZRkx
         F0UQ==
X-Gm-Message-State: AOJu0YxLENhGPQaV2HZvkTzM+4H3+1KSM9rGHrTTRW7+PQI7izsyNFIB
	HTvSZBdHzfUW4/ltZxS6Eyp0sgX51CnUcITif4X5Vj0fqv03DPyGoBVs
X-Gm-Gg: ASbGncungpBngZshDgmzjeZxInohNNCfhqikCe80KnqHtx2domBggT60RcD1TJwnJpg
	G8jkG4JcttqOc1zrGiGPS4aFhbWAJFS0u2zDo2eULWvlytjuGuIzyS+5ApsMS2zGgWPLeWsoJXf
	HJ6sWSwuSKNUZiviwZ2xbClRkzqLKR6o0Z/fFUmlvpkTk4PD4nPDwFWCTzjRl30ja1Ir+xLN2aT
	58Kw0tuVNdZuWEmPK7/Zcxx0T3MTI+UBb0XnTKqT/66VgEG6YKZNKtlnZ1eBq1KiNL9y4DQ0I8F
	d5QIKAzBpVjeCcrkfIi+Be6DH2EKBfl0jDOLS0FEsiE9yj0kCyvOVsD23LMFYwZhKcZrYRKIQgE
	ewuuwmxejp8pofg1UhpBy0fAEBRxbrt9aHojkSA8vY8U0HNaA
X-Google-Smtp-Source: AGHT+IHvonwGdb0zL8TGolTrspweB1R7cYKu8fA+DRvk1dbnYVDns4Uo4sPJkOKhkFT+BegO+wVEEw==
X-Received: by 2002:a17:903:1b47:b0:267:8b4f:df36 with SMTP id d9443c01a7336-28e8d0e99bfmr60741565ad.29.1759445638164;
        Thu, 02 Oct 2025 15:53:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110d61sm31345815ad.9.2025.10.02.15.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:53:57 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v2 01/12] bpf: Select bpf_local_storage_map_bucket based on bpf_local_storage
Date: Thu,  2 Oct 2025 15:53:40 -0700
Message-ID: <20251002225356.1505480-2-ameryhung@gmail.com>
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

A later bpf_local_storage refactor will acquire all locks before
performing any update. To simplified the number of locks needed to take
in bpf_local_storage_map_update(), determine the bucket based on the
local_storage an selem belongs to instead of the selem pointer.

Currently, when a new selem needs to be created to replace the old selem
in bpf_local_storage_map_update(), locks of both buckets need to be
acquired to prevent racing. This can be simplified if the two selem
belongs to the same bucket so that only one bucket needs to be locked.
Therefore, instead of hashing selem, hashing the local_storage pointer
the selem belongs.

This is safe since a selem is always linked to local_storage before
linked to map and unlinked from local_storage after unlinked from map.
Performance wise, this is slightly better as update now requires locking
one bucket. It should not change the level of contention on one bucket
as the pointers to local storages of selems in a map are just as unique
as pointers to selems.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b931fbceb54d..e4a7cd33b455 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -19,9 +19,9 @@
 
 static struct bpf_local_storage_map_bucket *
 select_bucket(struct bpf_local_storage_map *smap,
-	      struct bpf_local_storage_elem *selem)
+	      struct bpf_local_storage *local_storage)
 {
-	return &smap->buckets[hash_ptr(selem, smap->bucket_log)];
+	return &smap->buckets[hash_ptr(local_storage, smap->bucket_log)];
 }
 
 static int mem_charge(struct bpf_local_storage_map *smap, void *owner, u32 size)
@@ -411,6 +411,7 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 
 static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 {
+	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
@@ -419,8 +420,10 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 		/* selem has already be unlinked from smap */
 		return;
 
+	local_storage = rcu_dereference_check(selem->local_storage,
+					      bpf_rcu_lock_held());
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
-	b = select_bucket(smap, selem);
+	b = select_bucket(smap, local_storage);
 	raw_spin_lock_irqsave(&b->lock, flags);
 	if (likely(selem_linked_to_map(selem)))
 		hlist_del_init_rcu(&selem->map_node);
@@ -430,9 +433,13 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 			struct bpf_local_storage_elem *selem)
 {
-	struct bpf_local_storage_map_bucket *b = select_bucket(smap, selem);
+	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
 
+	local_storage = rcu_dereference_check(selem->local_storage,
+					      bpf_rcu_lock_held());
+	b = select_bucket(smap, local_storage);
 	raw_spin_lock_irqsave(&b->lock, flags);
 	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
-- 
2.47.3


