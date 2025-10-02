Return-Path: <netdev+bounces-227693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C64BB5919
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 00:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B0CC4E3680
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 22:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E032F2C08C4;
	Thu,  2 Oct 2025 22:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdCW0YzM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D64D2BDC0C
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 22:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445647; cv=none; b=oCPswk6EOT2K+8NPqAUgXgmeFPvzhIdDry2s9rLxnqLMZD3jQ3TRJsw6rpoomQsdHOTi8A87S5eHyktlXr2bpMJhTBkw5Bae7PRBl7UFOOSzbkAwLeytDXybpTfAfJErjjzSqeaS/U1DwGz6HSLRnB1LhoTF2aJmSXkpe630GOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445647; c=relaxed/simple;
	bh=zAQ5ubKPKove2VdF9p5kOqbb5Ij41CZ9vyaqNg8m5vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOqt8cSOM+yv/DhqhbCZsC8UFJB+Lq/wq1UwPfv2h+AWb3US7fD7FZ4ffI3il5iUXNMiNjfkT4rqOMObzorOEPsroAhOukFRZw1SX5zXMx6pOgBM5hDdc34ck43e5DAwogJxl02NQDCj3dbhyo0oOBUuo1ZmE2Ai6bstrYPBbJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdCW0YzM; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3306d3ab2e4so1972971a91.3
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 15:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759445646; x=1760050446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rU8XxuS09On1+d2XIUmC4XcClm0Yd0oYj9m+pQryRI=;
        b=RdCW0YzMcTAVZSiqrWq4k0TZgyw3wrxKyPlUoJ6NTPtV6H9XjNG5orDWW9lxPEANT2
         Nxy/hXZvtiVjZwv1hBSp/YrLntB4BXXhBtb6n+drjUeH8MMmbUcYv4qaM27IWK0EDzOM
         p+8EcESxVQQnm8SOxCfI89tyCwSnoIYY1JzdrYKld4WEY7IYNcrM77JYb6ugnecqN8ju
         +GLO4W8euUJjKQ4wHRSY6Ru5NsawPfLyEuBq8N0XPxFdLWr9VLxRU5Zs5QdKiVsoWNtG
         e7trB6U2zsb7IZ+1Uop0Q+2zgL4YSsvA4l7hNrJOGkhFq191bW4IZkzPIzDwWcs0TSKo
         FXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445646; x=1760050446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rU8XxuS09On1+d2XIUmC4XcClm0Yd0oYj9m+pQryRI=;
        b=p7dTEb9nj2QLtch2BmMJffOQ+l5dJrTpfpepl4Ix0YCf0qXNErT8Dqx/zmr73ueS5f
         27OxOI+SB6amevdfN859A23yaH3giwj1LnJ2YjJraNQ/oafxyMKCKrFVwPOzLAMW2szj
         JCyzL9uRt0G50prOkdblhyb0TintBPttv0s1h0tdXEKXX9xeGokMCLUa/M6U5Bf0m/qF
         Ruh6PtdPK+y9Ua/NU05SSdLWB2GISq1W4XPvz3aZpXOyr7USg2gEA8JC3Lb+PIZBrqDY
         RIMsl0F8y0YftiACZ6Dvg5M+AQPK4SGTpIE/4SLJomErZtyRdRgG/5MCWvB5MCCqdbQM
         mBBw==
X-Gm-Message-State: AOJu0Yw4VlwivOAlWLQPPo/C9B1q29p5uErg8RKwUxoMJE/QuBCYNahy
	zlLpYzDKS7Ch5ljJHb4pxUg4pyBOMJx9uWwD6S/WzUP+uSVmPvDPJWyt
X-Gm-Gg: ASbGncuUJ8AKlAfwETNhna9o8CPUiy6b2oA3iRTaCU7vpRvDtRtGe0ogZ4aygPH/K1P
	LZvYUi9KV3IfCFFx19QjxR2LGFWQzhgXqCQAAVJ6imP8hgKgsrFJJ2doLtvDoIyuKWQRVNRuE2f
	YhZA/5cnH9xe8joWfbfC9xpIqsY9D4oa3ng53LT20ZRmSMZRh4+k1AOMfUWG29wfc0jifdSoSLT
	K4rrgCP4OkyJW/62hXgH9Bztqpt2O8bOsBUKBE/PwG2SIaaCq0hmHNCduhe2t8dAgHzMLkNynfS
	ZsJyDjx9FfI1cWw/4cRB5Tb4aG85hVqdME2MbhayI56IV8RBuBmPI/iy1AFo0W/+vj32ZEmR67n
	DwKuFCao3mZWAC2eWrF9Sfh1w4U+1Vvt/umSxMw==
X-Google-Smtp-Source: AGHT+IHqR6H6hGlhBIo+llhw/Xp62JQQganbeUcGmSTUmxj07G0xPfMfOfCq/hwVCYGyRadAYliVeA==
X-Received: by 2002:a17:90b:1e10:b0:32e:6019:5d19 with SMTP id 98e67ed59e1d1-339c27bf6c3mr944772a91.34.1759445645587;
        Thu, 02 Oct 2025 15:54:05 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ebe5f2sm5955236a91.11.2025.10.02.15.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:54:05 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v2 09/12] bpf: Remove unused percpu counter from bpf_local_storage_map_free
Date: Thu,  2 Oct 2025 15:53:48 -0700
Message-ID: <20251002225356.1505480-10-ameryhung@gmail.com>
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
index 2a0aae5168fa..5888e012dfe3 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -170,8 +170,7 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 void bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
 
 void bpf_local_storage_map_free(struct bpf_map *map,
-				struct bpf_local_storage_cache *cache,
-				int __percpu *busy_counter);
+				struct bpf_local_storage_cache *cache);
 
 int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 				    const struct btf *btf,
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 4f9cfa032870..a57abb2956d5 100644
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
index 572956e2a72d..3ce4dd7e7fc6 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -917,8 +917,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 }
 
 void bpf_local_storage_map_free(struct bpf_map *map,
-				struct bpf_local_storage_cache *cache,
-				int __percpu *busy_counter)
+				struct bpf_local_storage_cache *cache)
 {
 	struct bpf_local_storage_map_bucket *b;
 	struct bpf_local_storage_elem *selem;
@@ -951,11 +950,7 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 		while ((selem = hlist_entry_safe(
 				rcu_dereference_raw(hlist_first_rcu(&b->list)),
 				struct bpf_local_storage_elem, map_node))) {
-			if (busy_counter)
-				this_cpu_inc(*busy_counter);
 			while (bpf_selem_unlink(selem, true));
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
index 7b3d44667cee..7037b841cf11 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -62,7 +62,7 @@ void bpf_sk_storage_free(struct sock *sk)
 
 static void bpf_sk_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &sk_cache, NULL);
+	bpf_local_storage_map_free(map, &sk_cache);
 }
 
 static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
-- 
2.47.3


