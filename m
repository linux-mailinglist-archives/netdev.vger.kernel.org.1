Return-Path: <netdev+bounces-255352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA99HDKPfWmGSgIAu9opvQ
	(envelope-from <netdev+bounces-255352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:12:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8B5C0B3E
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D505D304EAB3
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55275318EE0;
	Sat, 31 Jan 2026 05:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yfp50GZO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D7D322C60
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 05:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836173; cv=none; b=sXON9rzANVzGInQn+YWM+lkpPMqzlkrEWuIBtdvOTWEHHDCm8ZM9JIfiyqhQksJuvBJcnefTbH+xz1dwXuqahkVNOADA4R1JkwDZ8XsEU7+EyhqDlqPoU3rYd33fcUREFuctxthyVSmuvfHUHrT67n7vWNj1dmcDYdTaz78RUm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836173; c=relaxed/simple;
	bh=z1l6O2fj41AeAdTHfoNQOt2bbLvIyZnVxJVetECkZuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7zpBVsIutO4CZB7mlECEJ8UH+upKBVdSKgT3GkRDnY/il5mPZJHe8WUoe5iJ1ZvP3+Lg/eXpHHXmyXo1b3Gm577Zvn6VDmA+XhT8I2G6rydO/gEOihAUc2qB9YFpHNHFw1/uGPa/8+60ZZrhfX8Vddwmbnk/r8i+cqgYYlxswk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yfp50GZO; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c46d68f2b4eso1639641a12.2
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836171; x=1770440971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZj4Qq6gWipb61NsG4bbowbgKrqyJjAoChPF9p+stok=;
        b=Yfp50GZObJmcohr2QLEjQvPzbYcVgXoepziFqalADdFeNnTDDaxIN82by/758bHreh
         DRjiS2i4zgyoDRlhl4mUazBIKfk/idiX/Jub94DFS2SdYkN8GWYcPjAwHigPDBSVqrsw
         ovh3sN8UtHZq8yV/UeHdRnDk6OEPzH04zIfRBlXRQMfZTQoaxw1ymqfHzTm7YgP/zePq
         uv/PGxGazNc+HIQ6zWU+A2ZkzKLObi41Uwxp5zVjpPB/xcs4hGaTVxd4DLQ46GWWwylO
         UlLkqTWBG9b8Pqups1yx4oT8qv5+l77cDh8ICFWRlAGhr/zWxq4WErgvFzLahqi274ve
         dBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836171; x=1770440971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qZj4Qq6gWipb61NsG4bbowbgKrqyJjAoChPF9p+stok=;
        b=lmDLFRSVcVFoKp5ZGRoTRbQJKuH+hHE74os+iEmTKH3JDXlYBbhuPA9B4DapEinFeh
         i09qRDxDTxNa4ZJP+ypcgdiJUb24vOct/S3I5NJEnqplzxbta2Zt2Zwgl840rxJ8Cq2Z
         V0YG/CL3PS5wlal/X6o/syenwxem94WQ2Ro5IJmVfkLmDFLfSESI5n0yXGG/ogzxrKTT
         rJYWSGZPwiwFjIQtNf5U7sreQBb4e8lO/2UhQ60ul6g5mYEfQi3q625LIuz2lTfDvF4J
         bw+dOqyAagYPWNGiOrvdnhrKF7LfjNlkrRc/CAzRi97eXSZWXZ+cGtObepa0ejpEVrDx
         p88w==
X-Gm-Message-State: AOJu0Yw7iXp2rVJnxNwFp/Sg+73913RHgtw7t4UcoiL+iJfTDjRdDsgi
	8hHBF+nlbchnmrXa0XtD2fSJUy7IAhB2pDGM/CuT4vJPU3T6y4ei+nUf
X-Gm-Gg: AZuq6aKQ3pp+hy/edaUai1rOt4c7+c2CfjeElrThBBRkvQ0OxjO1m2SHIGIu0e7hO+8
	BDihNK4MgJmAPXEedFSUW4yMwHgJyK5Q8uxgIBsi1ESS2a9ghqlm3p4vREFey0PVliCIk7nFq7t
	XbXs2tYaOGdR8Fa4HC6eFj74ADl99LfyFK/g9PxpuKBm/MIdJXhi/d3kZY2D4caLY2B1DUeiZp7
	OZ4CqkNbWVWYgfAg0fL/XPaAbtZ5Q8eNK5Z9ZlP052iaKcHzDm4Rr4mTkBQjB0Raj16VP6LUY6n
	lAOKdZnpmMCOVsHeeZL8JeU/BCGOAFPGwLKUSvkX/N9PKYCPXeq1kt3nQdWlN9YajdFCPTwLQdL
	9ZhbtJdXmxfplW+JP8FZ31JI3XYWa5rz/vQ+z3UNj5nNEQ6n2zlYXpcB76UJWsdbJxYlsEJECrc
	BKWVzj2jVt/LKL
X-Received: by 2002:a05:6a21:3991:b0:366:5d1a:c737 with SMTP id adf61e73a8af0-392dfff921cmr4624583637.16.1769836171300;
        Fri, 30 Jan 2026 21:09:31 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8bd7654dasm62484665ad.81.2026.01.30.21.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:30 -0800 (PST)
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
Subject: [PATCH bpf-next v4 08/16] bpf: Remove unused percpu counter from bpf_local_storage_map_free
Date: Fri, 30 Jan 2026 21:09:11 -0800
Message-ID: <20260131050920.2574084-9-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260131050920.2574084-1-ameryhung@gmail.com>
References: <20260131050920.2574084-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255352-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C8B5C0B3E
X-Rspamd-Action: no action

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
index 7661319ad2e3..fbf41e00be8a 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -809,8 +809,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 }
 
 void bpf_local_storage_map_free(struct bpf_map *map,
-				struct bpf_local_storage_cache *cache,
-				int __percpu *busy_counter)
+				struct bpf_local_storage_cache *cache)
 {
 	struct bpf_local_storage_map_bucket *b;
 	struct bpf_local_storage_elem *selem;
@@ -843,11 +842,7 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 		while ((selem = hlist_entry_safe(
 				rcu_dereference_raw(hlist_first_rcu(&b->list)),
 				struct bpf_local_storage_elem, map_node))) {
-			if (busy_counter)
-				this_cpu_inc(*busy_counter);
 			bpf_selem_unlink(selem, true);
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
index 78e936288879..7ec8a74e7ce5 100644
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


