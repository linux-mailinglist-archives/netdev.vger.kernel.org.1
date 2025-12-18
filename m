Return-Path: <netdev+bounces-245420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F36CCCCD136
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 19:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A75630BB0FE
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E24530BF78;
	Thu, 18 Dec 2025 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUE0u7U/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98783081D2
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080603; cv=none; b=G8E/2iESpVEEVv2FD8qc3LJS6GwbBT4/4ZjI/9yM1cg4U+kgJKJ8wZSjdEu584+opoSaCThkOLwE9Vu4+O+mFSk1RlJX+nEn2FyzFj4JBno1aZ8xwV+CbBxv0+yMeRWKI7CIfFa8ohlShXwBXZTaYAUnP6LGY7AAO8Qa8ksB4aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080603; c=relaxed/simple;
	bh=ev5Rowld4nf+8P+wvfeclCpxpW81OlAN33yKhraiJ18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbKrhBYC5l2TFY79MP0uRkbbUalFbAYhoM7Lvlstyi1vDoEHF4dSsWSobULS4w6CNZl2wQNn8w4mNMqa4WAndWgBhzZwUBItP26TRksc24WCGIYa3tyQTomBlrUHdQCT2K9wn3Ij7nSN31dN1eEH9EhsDmpbMWXllvToTYNq/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUE0u7U/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0b4320665so13653345ad.1
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 09:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080601; x=1766685401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WzB2RB2PqUN9cAvQZVNqshG2xtHkoX2hsCq9SbIsgg=;
        b=CUE0u7U/yoijESxtTPlHQkyvtSEoXVG4u+obg+qN8Wm317rSqDUnbeWoLFt8UcngAY
         BYne6kiV3Wl1bFz/0sNWwEh2VaT/fpDjqVngnPv1ad19MVeaQvRouwbFQcYnM8eRZ9b7
         Cz++6Ef8rYnm7DglL/I6J5S89soJqJGSO+1mWMzxWPB34WMtVf1V0Q6iPVLVOsPV9Vh0
         BzEpbN1E6pketQC8N+4aBTkzXXZzR5UASB+Tt8SyU8yh9Nz0Q4WruEOy7kwuq07ENxIh
         hDNziHQLXjENv3CUUXhXl4r+PypK6vhB8WEsUOZEPK7DzT3HmoyoFsvU54suEL88WT6T
         CKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080601; x=1766685401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1WzB2RB2PqUN9cAvQZVNqshG2xtHkoX2hsCq9SbIsgg=;
        b=tDY11ZCoLP5mxS6yqK6xCbcq5O5IQ/yXDMAUWFKbxwFnct7918CYD3Im0V/VZ/jgdK
         E58Uo497Z1O08HLW6BsuMBZifvBL2L3l5gB4HPv+HfiGcCtasaA+QV8A2y6voTBFimWk
         OVuxbQtkxyUf8NHG2UHWS7K+iGDF79lre/qOUiFDR7RO9FYgDthQoEOphgW3qsX90cz+
         J+eg449zXl6eRuhauof7H/A11w/iA+66h/OhvqVvWopddR3cs1PO84UpBAqxz86WhHCF
         OnwJw5Jn+/er7JQKqOg+EK+PjT/e+HfjUbhHVgWA1I9QjLsodfjurPHU3fal3gPZ1w0p
         9k2A==
X-Gm-Message-State: AOJu0Yx/h7p9RMH5KT/znl7mswRXpry0QWf5OjYRcYLkYTpYGuD4/akd
	lnXKs0D6TBNJ9JolSVmycBQdASsJpuzO5sAdAjUUEW2gVlfiFOITpiy/
X-Gm-Gg: AY/fxX4F2/uO1SZTEM4os3QKfZreyKAMYPCSAQ0fVrF2ZYb+9RbbB3tPmaujseefgFp
	TJOLczQywvoB049qGoEuaCpX12mMKdc2R/HaeCmPUD7/uz2wdGjsMX4iWNaSZM/HJwR56JkIatL
	/BaeS7wWrE75vlHCRWPlX763Jo+k8mwt6Bz2Q6tBDjVOgGiWzWjxkOrzYw9dVyNX4j6YHXwwBJN
	AYfYyjc7h/aYDERGBdLxjC7bqZKw3WSzIQCKjV0iB/L3s3543CD1A1c9/sq1mVuvuYs5ydY91gV
	j6Vbiv7v63okUB6FZf574S3frFYQEu0RRQdxyBM2LAu98nsSAhrDi4HhqjY3aDX8s70GpObqrdp
	xZmuAL6bVxgDriBwJWnLjoAHyqhZPcorJZMB0pf9imWJvdbx+r6jANYCEKopXu5pgclQHOylfd9
	E1bbaNqgWlKJqCZw==
X-Google-Smtp-Source: AGHT+IGTpZ5H3UXwa+WgP7FATBplPDjYUpshQ0sE3Se32BwYuiN0mDbv3ecn4Ora2ibsZY4dVWsL0A==
X-Received: by 2002:a17:903:3b86:b0:2a0:8966:7c9a with SMTP id d9443c01a7336-2a2f2c5e17cmr621435ad.58.1766080601181;
        Thu, 18 Dec 2025 09:56:41 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fed79afac3sm1721455b3a.14.2025.12.18.09.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:40 -0800 (PST)
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
Subject: [PATCH bpf-next v3 09/16] bpf: Save memory allocation method and size in bpf_local_storage_elem
Date: Thu, 18 Dec 2025 09:56:19 -0800
Message-ID: <20251218175628.1460321-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218175628.1460321-1-ameryhung@gmail.com>
References: <20251218175628.1460321-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A later patch will introduce bpf_selem_unlink_lockless() to handle
rqspinlock errors. bpf_selem_unlink_lockless() will allow an selem
to be partially unlinked from map or local storage. Therefore,
bpf_selem_free() needs to be decoupled from map and local storage
as SDATA(selem)->smap or selem->local_storage may be NULL.
Decoupling from local storage is already done when local storage
migrated from BPF memory allocator to kmalloc_nolock(). This patch
prepares to decouple from map.

Currently, map is still needed in bpf_selem_free() to:

  1. Uncharge memory
    a. map->ops->map_local_storage_uncharge
    b. map->elem_size
  2. Infer how memory should be freed
    a. map->use_kmalloc_nolock
  3. Free special fields
    a. map->record

The dependency of 1.a will be addressed by a later patch by returning
the amount of memory to uncharge directly to the owner who calls
bpf_local_storage_destroy().

The dependency of 3.a will be addressed by a later patch by freeing
special fields under b->lock, when the map is still alive.

This patch handles 1.b and 2.a by simply saving the informnation in
bpf_local_storage_elem.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h | 4 +++-
 kernel/bpf/bpf_local_storage.c    | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 70b35dfc01c9..20918c31b7e5 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -80,7 +80,9 @@ struct bpf_local_storage_elem {
 						 * after raw_spin_unlock
 						 */
 	};
-	/* 8 bytes hole */
+	u16 size;
+	bool use_kmalloc_nolock;
+	/* 4 bytes hole */
 	/* The data is stored in another cacheline to minimize
 	 * the number of cachelines access during a cache hit.
 	 */
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 667b468652d1..62201552dca6 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -97,6 +97,8 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 			if (swap_uptrs)
 				bpf_obj_swap_uptrs(smap->map.record, SDATA(selem)->data, value);
 		}
+		selem->size = smap->elem_size;
+		selem->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 		return selem;
 	}
 
@@ -219,7 +221,7 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 
-	if (!smap->use_kmalloc_nolock) {
+	if (!selem->use_kmalloc_nolock) {
 		/*
 		 * No uptr will be unpin even when reuse_now == false since uptr
 		 * is only supported in task local storage, where
-- 
2.47.3


