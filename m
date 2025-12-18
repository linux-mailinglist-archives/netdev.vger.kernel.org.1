Return-Path: <netdev+bounces-245418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C3BCCD130
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 19:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9AE830B34EA
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA10309EE6;
	Thu, 18 Dec 2025 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJH1Oxod"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7003074A1
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080603; cv=none; b=SjEZmc4uE0wRBHHrC3nSq3UBlwvdJ/fzLS9Ca4gqcVfzC+vxig7rlyBc2SCsK0DRc9v3wjOsUr62Ll2AN70nsOdfy36EypI6QJdj49akrHdnfsYi5fdL/acOJ2FIuBWaytb4rnL8ipMCrLIiPs7g4fwgZLROg8Z4YtL2HLGdswI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080603; c=relaxed/simple;
	bh=IRLkSHPx/ZVLhxPQIXqmSYDZhArMOD7HSo1URz4HlR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5B4ktELmEEWYc4SM30BVfUQzMp1bSJjyL2yHZ9pQx/OLCCvFqb/m7sBb+wzmkPZsUxTPisDsFOYhFZRodcMIUv9FClKOWO+FgzBtGSVflIfpozlA4kRbaX2Wco9icmMNI6UbTQri3H9L8dvnS0krdeX3A/u6NaNmIdV63sgS9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJH1Oxod; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c2f52585fso774255a91.1
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 09:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080600; x=1766685400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0B43kzJDbhnDgRREv8aqfEZEGbm7QkUNHj2hERWWZhQ=;
        b=SJH1OxodkiQYDRfZF6xikUXC9EMCG8V2eOLBzFmJAuPJUZEdkzxiY7M9wuDOmW4def
         E2BFkyW3EbsLuIoq3Yvug6caUI0vk2Dkuix9LC4igz7AuSVAKKvQuX6zamMf3Fe1zgLD
         DYCdqvlhmoWrjNPTlvsMsCcdqezzlGDVnZ4a/mO1juNMomfs9xEQ8/dqMP810hSceZOT
         nL9uHSagz/B6wtxzvTuYb26YgHezwFHgWsmE8B3s+ft37a25sFlZMIEYszVEhLwkzRlq
         2uFEPbHyPC1uf47g3E/wa5fi7P+xFxvHj4yc+GmNMztRZk1IRSNfbX/Vpiiy4z1NN+3/
         +qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080600; x=1766685400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0B43kzJDbhnDgRREv8aqfEZEGbm7QkUNHj2hERWWZhQ=;
        b=M22+zcFKXqARJrV/bqQGZTO7lhHvE+2OyyMtxnjiatg+2fMYJsnbozNQGWpcQdM07F
         uxwdzAp8bDAvQefumxQYTl21c1JONf1DrRAn/QRc5zo4UCgatbaXZigfifLs6NR07JDI
         eBk2htwaiREZpbDGETPvnVlMXV2+05BYId98yUvjPYVcKiB9tVMEBbsXUXV8MPiKXRKB
         3DU1q3R6dBWX/TvDKNhM0btDO23edMbUw6ltYin138hbnzLPzvoLEfw4xQQ2FlwyHxWX
         SXq+bQp3L+u4fm/KXEoZJTPF0OWGjg/XtHqNrp5iwSltEwl2u8m1M6E5HrAB78TonfgP
         U2pw==
X-Gm-Message-State: AOJu0Yzs/IKAbiVANZztt5nCi0VdVZk0pvp5gWTukjVLxoGYrn3sH+du
	LZyLRRNNy6xS098KUNl8pnCqWiAKX9AzYAG0SyZmMHt62DpLhsf0bufy
X-Gm-Gg: AY/fxX4Bss6kUupIMm/AFIsBazICLVoKVyUJx3LARD7iThYIjMAcmidXbaDYlZ1Ok0v
	I9Eh2CcGRfL6MMel7c9/F/tdnpGfvAocXj8NfIDlXKyYNzOszTv4vt5ba0CkcRVlj+Aco3aoZ1f
	Mw/tufc0xWi1Q4h6G84Qh9AfoCUjq1Vv050S/wOU0nzuMn5sepaMIndRRpzhSw7kj0rKwK3NNdC
	K4JVMV3/++ueKDN+1NpFMQ73dvbtDHKm4UHDoHroCt57keFAU4KPNFONHof8Q5w5+xlEGTr6beo
	5HVha9q2cv6pFkbRxl3WoK+GoNYsu7yh8x4ZNfkuc1Ii9aRE0mvP/YgsPEzgXkuI27te8kd9D8o
	TrxI76UIiYbS84NhIKRpIMbRyM3zs4TyGu3wLRilR+7im96RDdmAT2QJ9pNAA2O2AxMQTgUQ7iy
	TBjcyzwzyuelwM5Q==
X-Google-Smtp-Source: AGHT+IFRrGJg75XYHlG6wI0zUheMqBbBJbPlwWRy6DGqXEb/3S1wOzkmbL2R3raKDPk0lvRrc1W9OQ==
X-Received: by 2002:a17:90b:5107:b0:34d:1d54:8bcf with SMTP id 98e67ed59e1d1-34e92142ab1mr164616a91.9.1766080600179;
        Thu, 18 Dec 2025 09:56:40 -0800 (PST)
Received: from localhost ([2a03:2880:ff:56::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e772ac1acsm965587a91.9.2025.12.18.09.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:39 -0800 (PST)
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
Subject: [PATCH bpf-next v3 08/16] bpf: Remove unused percpu counter from bpf_local_storage_map_free
Date: Thu, 18 Dec 2025 09:56:18 -0800
Message-ID: <20251218175628.1460321-9-ameryhung@gmail.com>
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

Percpu locks have been removed from cgroup and task local storage. Now
that all local storage no longer use percpu variables as locks preventing
recursion, there is no need to pass them to bpf_local_storage_map_free().
Remove the argument from the function.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h | 3 +--
 kernel/bpf/bpf_cgrp_storage.c     | 2 +-
 kernel/bpf/bpf_inode_storage.c    | 2 +-
 kernel/bpf/bpf_local_storage.c    | 7 +------
 kernel/bpf/bpf_task_storage.c     | 2 +-
 net/core/bpf_sk_storage.c         | 2 +-
 6 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 903559e2ca91..70b35dfc01c9 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -166,8 +166,7 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 void bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
 
 void bpf_local_storage_map_free(struct bpf_map *map,
-				struct bpf_local_storage_cache *cache,
-				int __percpu *busy_counter);
+				struct bpf_local_storage_cache *cache);
 
 int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 				    const struct btf *btf,
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 4d84611d8222..853183eead2c 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -119,7 +119,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 
 static void cgroup_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &cgroup_cache, NULL);
+	bpf_local_storage_map_free(map, &cgroup_cache);
 }
 
 /* *gfp_flags* is a hidden argument provided by the verifier */
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index cedc99184dad..470f4b02c79e 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -184,7 +184,7 @@ static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 
 static void inode_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &inode_cache, NULL);
+	bpf_local_storage_map_free(map, &inode_cache);
 }
 
 const struct bpf_map_ops inode_storage_map_ops = {
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 1d21ec11c80e..667b468652d1 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -827,8 +827,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 }
 
 void bpf_local_storage_map_free(struct bpf_map *map,
-				struct bpf_local_storage_cache *cache,
-				int __percpu *busy_counter)
+				struct bpf_local_storage_cache *cache)
 {
 	struct bpf_local_storage_map_bucket *b;
 	struct bpf_local_storage_elem *selem;
@@ -861,11 +860,7 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 		while ((selem = hlist_entry_safe(
 				rcu_dereference_raw(hlist_first_rcu(&b->list)),
 				struct bpf_local_storage_elem, map_node))) {
-			if (busy_counter)
-				this_cpu_inc(*busy_counter);
 			WARN_ON(bpf_selem_unlink(selem, true));
-			if (busy_counter)
-				this_cpu_dec(*busy_counter);
 			cond_resched_rcu();
 		}
 		rcu_read_unlock();
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index dd858226ada2..4d53aebe6784 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -217,7 +217,7 @@ static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 
 static void task_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &task_cache, NULL);
+	bpf_local_storage_map_free(map, &task_cache);
 }
 
 BTF_ID_LIST_GLOBAL_SINGLE(bpf_local_storage_map_btf_id, struct, bpf_local_storage_map)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index fb1f041352a5..38acbecb8ef7 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -60,7 +60,7 @@ void bpf_sk_storage_free(struct sock *sk)
 
 static void bpf_sk_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &sk_cache, NULL);
+	bpf_local_storage_map_free(map, &sk_cache);
 }
 
 static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
-- 
2.47.3


