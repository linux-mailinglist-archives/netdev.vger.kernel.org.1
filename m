Return-Path: <netdev+bounces-255656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLQQFDCTf2lotwIAu9opvQ
	(envelope-from <netdev+bounces-255656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:53:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF519C6D25
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26D753034672
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 17:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E9D280336;
	Sun,  1 Feb 2026 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePIEZY2+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF041283C9E
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968267; cv=none; b=EnikQLIspuF9FgHe5RkzHEl725Q0NkzyrlQnV4kTTEesVIDf4p/vElKFnOnEPn3BTbis0Sabd8V0vmiXAYSfPF1YA3SddaBWK5s+uutr/3LC8V0uZemY1mR646nC0H/NgSOkey+E932Iu3Bq0zC+0ujK/y+pHyAn9MuZMwN1JK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968267; c=relaxed/simple;
	bh=CBqTvdITmV4N+zgSeN68ivxwV9Bq9KzptzQRZ9/vtco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCaZc/OQTgWy1W906xMzKu45XQUfEOIOWcsRhvHZ4h1zQPfu4Bd1a/ybtu+p3wtrAg6KQqRxfgMA70Kehlwl9vT82auRKD4MXMcgnNxvPVZi+gige1ZLvvb5cV++uZSibOazhm3bTG2/dn7B7ePl/48I4jRah6KhAB4TivtR7Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePIEZY2+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-823210d1d8eso1839690b3a.1
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 09:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968261; x=1770573061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PjMDge0fA0s+oiOs2HnEWzWgjzoILNnSL9xL9THcxk=;
        b=ePIEZY2+o7+nqQ6BB/hNSSjoRJmDbnDpFW9rkF2TdM0piQ2wWfPiq9oYrsV8Rk2zKh
         atSMC+mQ97/uS3SoEikYtXhGi1eP3e5B0vQUaH7RFmES/X+ObvJ6vSVL4PGR5IcHGba8
         4O2UUYxfxzlzwr1JOzQVWNzROax9Thr8pqWYjGVIOyAPH4BpPL2/iIBikndqkZqy4Ofx
         NeaCTxyckvbmpNjb47cpoqRK6H+IWffPTPGw+KE6GbHEkCjg/O0tSPqi1utV7Sdj4Mjm
         0uKM6Nyq0hqfCGcbSSP0LuyVUXc9tNxHtqlr7aveCF5pWOXM9diHSHrIzf9gpPuobzX3
         CXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968261; x=1770573061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9PjMDge0fA0s+oiOs2HnEWzWgjzoILNnSL9xL9THcxk=;
        b=D3dM4ZtTpqyP1MwtCZOtra4JwJZ5U3Pd212KL7qy3d7qI5ZFKI5EUtl5T3Ak9z17BH
         lWMHhngw+9kd0qiqlMkmVcyXXP+oiFQUQO9THbdEDL/PnUZwjOb4QZtV0kdbCXETGj0f
         asRtyRUkAtIME/pupaSLZ03qk55UceY/wkBXJERnJJMC3DjmyxFQJ3Upc7nRjKz/kdGp
         7oJgnsYVe9rjWHlZsMGRovaKYTa9Ja7aPdHDztxV2bUpa+xBxLpcwoUXHnnrutuDpi18
         FuNfpF+DcP+grlz9WIsxyppnLfchR8tshs4UkJs4wNqqke5RmSmTdY1UKqqSFweR6zju
         5REA==
X-Gm-Message-State: AOJu0YyLrydSNLdMzysaz5HxdLpo/c8jxHRKWIfrSNSs1rCRyzv/mslb
	pj5VWL1sku6IgOdauRuvqr2WYiaEEjofacJ1Q8zwFGpBsLhNs5Kad2Y6j9cEtQ==
X-Gm-Gg: AZuq6aIMhyLo+DIEcdJygkp3Hw1Hrksasj4Cprg5+pd6DZuOHhi77JW9GKET55j54Tr
	L/cy8US7LZqS0QcGDyKYkVEJB5es5XYM9AVJs2HCV1zL7Er2QJ1RpLBxnPmbPKpKjLGdpKqSZJc
	qCMU5HimRg+hR1sP4DZm4HAi4OEEcKl9gBb4UxcHYId74aezj0O4ji6YE8EHpBKZnjbjkmlpCE6
	QNbNsk6gy37X/Ri3U5CdgZ2g4beCXplj08wMTZVU+ZSzdYuINLJfeurApuYdKY3S+MBX+ADaQbO
	umwKyFBjGjk0lpFeDzIf/AhRkAqGtr24MhbQHkmsDzDOnpGmpj5hYtXYwPFppSeTN8hxlrMTklN
	MqEJrV+lHkRVcJUJp00joJgmFCqvidJj+bA5jNO2JJTTZIRd/e0AeCUE9MLs8qT2t+Na//ckmO2
	yJW2hbKrbi/yA=
X-Received: by 2002:a05:6a00:4b46:b0:821:70e7:b10a with SMTP id d2e1a72fcca58-823aa40d7e9mr10568626b3a.8.1769968261343;
        Sun, 01 Feb 2026 09:51:01 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c1fc6esm13366401b3a.47.2026.02.01.09.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:51:00 -0800 (PST)
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
Subject: [PATCH bpf-next v5 08/16] bpf: Remove unused percpu counter from bpf_local_storage_map_free
Date: Sun,  1 Feb 2026 09:50:41 -0800
Message-ID: <20260201175050.468601-9-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260201175050.468601-1-ameryhung@gmail.com>
References: <20260201175050.468601-1-ameryhung@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255656-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CF519C6D25
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
index fa50b7afee18..fba3354988d3 100644
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
index b33ef5fb5b49..3735f79a7b55 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -808,8 +808,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 }
 
 void bpf_local_storage_map_free(struct bpf_map *map,
-				struct bpf_local_storage_cache *cache,
-				int __percpu *busy_counter)
+				struct bpf_local_storage_cache *cache)
 {
 	struct bpf_local_storage_map_bucket *b;
 	struct bpf_local_storage_elem *selem;
@@ -842,11 +841,7 @@ void bpf_local_storage_map_free(struct bpf_map *map,
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
index d7b5c4551997..d2164165a994 100644
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


