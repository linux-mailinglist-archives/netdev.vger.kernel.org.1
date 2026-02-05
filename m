Return-Path: <netdev+bounces-257335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHl8LGYahWne8QMAu9opvQ
	(envelope-from <netdev+bounces-257335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:32:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03865F81AD
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D579A30515C7
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72359337BB2;
	Thu,  5 Feb 2026 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMNpBcBR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F8C3385A9
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330566; cv=none; b=khlfnTGYmzXJ/jPTzBkMlARDe99BOKR7ND1EuLuZxWyf9MjKF/0MEz67Ku+DpCTgSRko3qKezSQd9UD80O+iRevmtt0R2d8CC9u82aCdR6HOkjRytVXNfI0pdO3P0nHuFKpD1AgqHP2xwCFrkQPnQv8VngYBiYjE3kD9Glc5ykA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330566; c=relaxed/simple;
	bh=+VqL2Tt3DZfEzJCZumYRh3TB8bCtCTtoeuVGc7k8YZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVs/VDm60clovv43ONyRTsExS0dv10CScJBqSx3TDDY5Q5X4wBSLNSzKk/XgHhDPIBN6ZFkrOuIgNo22i+6LcLNKRZYKeV2CkQ0X04SdiYK+d0twBN2sVz3/Hz8UeG53GhHvZC/hC04v7eA3nSGgUGAWKKpTyu936CPm5Z1p7pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMNpBcBR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-81e9d0cd082so109365b3a.0
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 14:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330566; x=1770935366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBj1V+4xCUwk81a2kOPMU8wayL/IDg35NleXiXlQBlk=;
        b=GMNpBcBRKtQilAegmk85PEsxVSva8MJmFWJL1pN/xA2ad2vdwNtaW8z6y41qrrADYY
         rRCljzD08rfGf0YFUcjUGZ+aWAX7VlcKSMV3uhebghVTpJlQRWrND1pBMzJtTFr0Uqlv
         6Z6MCgjtPDfe+1evurnAIajPwU66M9i1Ik1yWE1PYiKfJqdF74HuLeFuo55d6FGmVVbm
         N+1F6WkPGuuPoB08yat1h2Yf+SLXCn1BxZHJ7CkHES3Z88NJvBXxQMvvZoz5qBYUljTa
         a1bW0mkTtTYs4jH2DbQro3WQKmeBIxGb27CiBA5tVg3cp7BzijsZxSNTxPqVob76hFf1
         JwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330566; x=1770935366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vBj1V+4xCUwk81a2kOPMU8wayL/IDg35NleXiXlQBlk=;
        b=pj4eZmzU+0fiIHoEti+HM/8mpkvGG5lRyZwr9/wmW3us+kDVT/Srm+IttA5JyjM9EO
         4VEKfUIlM9BYIRx4lR4N+6zxxF6CG5zRi1t5qJz2G9MFbNWFKIBDcvIWhPcxi2khVmyv
         Sl6Z1gh5c1uBoEDuCVsFNWIWcRpFDFiupKFtYL6CPriw1NiSNfVwAZ6jo4xbUJyMIJFj
         3PzszmcNi0bbbwrlvXSHDIsnNKQqD2pnL8WkmH8QUHe/LmKFJ0QLU3LIx0FoZ6HmQYEC
         rSa5KmcewwxiHObn1m2EANdJley9ovaegYIdHvn2RBEOULj+AY6ZxfpvgGJp2QoTeYYN
         r/1Q==
X-Gm-Message-State: AOJu0Yy/izko1tya7pGQmNps7BLK9BXT0sBYnReG7hvL8DwsXznfOzdB
	+cJAipapBUTaZL2a4m8FtHwXvCjSpextSRrFSU2yDvvc1H0BpgMW//Fk
X-Gm-Gg: AZuq6aKs9XRxZ/D44tQUL5dlH/QQPU27IPW2zn+fhP1E3C9piIcQufNkL/cHUQm4I+m
	TalkDge5vf8l7Gnf+x2Y1upP5kKcojfM/0RMLdBAlddw9foeLpCkhCPHba83sK7Bfkt5v19o8hE
	+cIVJoMj1h2JKArlp/XnUyb+SG4ttFzAgMNFSQHUjbrond37UGTFaRxxEfD++nB4bqZlSwGd5AJ
	7+cZ23Ik1HQoDv5SBoho3NY03cCbfkAMKcFfE34LkxH5Q3k+tfhC+b9NoGSLSKc+JRaZBOsgO7V
	RoZhwj+QDElxaQa71bd81KwNovlwFT+S+48mteoc2tIMt7x/NOKmn+MX5C5IzrqX6Utw9t8mdnz
	jHRb8o/I9vPXYlfql/eS/8Bvek4RQxSPBy11WeLfCiwJ2GfvGgdFD30xdGiKeNkAbGorBIU4ukF
	EZAQ==
X-Received: by 2002:a05:6a00:13a3:b0:81f:852b:a921 with SMTP id d2e1a72fcca58-824417b77e4mr477857b3a.68.1770330565653;
        Thu, 05 Feb 2026 14:29:25 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418b7cc3sm261532b3a.51.2026.02.05.14.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:25 -0800 (PST)
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
Subject: [PATCH bpf-next v7 07/17] bpf: Remove cgroup local storage percpu counter
Date: Thu,  5 Feb 2026 14:29:05 -0800
Message-ID: <20260205222916.1788211-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205222916.1788211-1-ameryhung@gmail.com>
References: <20260205222916.1788211-1-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257335-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 03865F81AD
X-Rspamd-Action: no action

The percpu counter in cgroup local storage is no longer needed as the
underlying bpf_local_storage can now handle deadlock with the help of
rqspinlock. Remove the percpu counter and related migrate_{disable,
enable}.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_cgrp_storage.c | 59 +++++------------------------------
 1 file changed, 8 insertions(+), 51 deletions(-)

diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 8fef24fcac68..4d84611d8222 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -11,29 +11,6 @@
 
 DEFINE_BPF_STORAGE_CACHE(cgroup_cache);
 
-static DEFINE_PER_CPU(int, bpf_cgrp_storage_busy);
-
-static void bpf_cgrp_storage_lock(void)
-{
-	cant_migrate();
-	this_cpu_inc(bpf_cgrp_storage_busy);
-}
-
-static void bpf_cgrp_storage_unlock(void)
-{
-	this_cpu_dec(bpf_cgrp_storage_busy);
-}
-
-static bool bpf_cgrp_storage_trylock(void)
-{
-	cant_migrate();
-	if (unlikely(this_cpu_inc_return(bpf_cgrp_storage_busy) != 1)) {
-		this_cpu_dec(bpf_cgrp_storage_busy);
-		return false;
-	}
-	return true;
-}
-
 static struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
 {
 	struct cgroup *cg = owner;
@@ -45,16 +22,14 @@ void bpf_cgrp_storage_free(struct cgroup *cgroup)
 {
 	struct bpf_local_storage *local_storage;
 
-	rcu_read_lock_dont_migrate();
+	rcu_read_lock();
 	local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
 	if (!local_storage)
 		goto out;
 
-	bpf_cgrp_storage_lock();
 	bpf_local_storage_destroy(local_storage);
-	bpf_cgrp_storage_unlock();
 out:
-	rcu_read_unlock_migrate();
+	rcu_read_unlock();
 }
 
 static struct bpf_local_storage_data *
@@ -83,9 +58,7 @@ static void *bpf_cgrp_storage_lookup_elem(struct bpf_map *map, void *key)
 	if (IS_ERR(cgroup))
 		return ERR_CAST(cgroup);
 
-	bpf_cgrp_storage_lock();
 	sdata = cgroup_storage_lookup(cgroup, map, true);
-	bpf_cgrp_storage_unlock();
 	cgroup_put(cgroup);
 	return sdata ? sdata->data : NULL;
 }
@@ -102,10 +75,8 @@ static long bpf_cgrp_storage_update_elem(struct bpf_map *map, void *key,
 	if (IS_ERR(cgroup))
 		return PTR_ERR(cgroup);
 
-	bpf_cgrp_storage_lock();
 	sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
 					 value, map_flags, false, GFP_ATOMIC);
-	bpf_cgrp_storage_unlock();
 	cgroup_put(cgroup);
 	return PTR_ERR_OR_ZERO(sdata);
 }
@@ -131,9 +102,7 @@ static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
 	if (IS_ERR(cgroup))
 		return PTR_ERR(cgroup);
 
-	bpf_cgrp_storage_lock();
 	err = cgroup_storage_delete(cgroup, map);
-	bpf_cgrp_storage_unlock();
 	cgroup_put(cgroup);
 	return err;
 }
@@ -150,7 +119,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 
 static void cgroup_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &cgroup_cache, &bpf_cgrp_storage_busy);
+	bpf_local_storage_map_free(map, &cgroup_cache, NULL);
 }
 
 /* *gfp_flags* is a hidden argument provided by the verifier */
@@ -158,7 +127,6 @@ BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
 	   void *, value, u64, flags, gfp_t, gfp_flags)
 {
 	struct bpf_local_storage_data *sdata;
-	bool nobusy;
 
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
@@ -167,38 +135,27 @@ BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
 	if (!cgroup)
 		return (unsigned long)NULL;
 
-	nobusy = bpf_cgrp_storage_trylock();
-
-	sdata = cgroup_storage_lookup(cgroup, map, nobusy);
+	sdata = cgroup_storage_lookup(cgroup, map, true);
 	if (sdata)
-		goto unlock;
+		goto out;
 
 	/* only allocate new storage, when the cgroup is refcounted */
 	if (!percpu_ref_is_dying(&cgroup->self.refcnt) &&
-	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) && nobusy)
+	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
 		sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
 						 value, BPF_NOEXIST, false, gfp_flags);
 
-unlock:
-	if (nobusy)
-		bpf_cgrp_storage_unlock();
+out:
 	return IS_ERR_OR_NULL(sdata) ? (unsigned long)NULL : (unsigned long)sdata->data;
 }
 
 BPF_CALL_2(bpf_cgrp_storage_delete, struct bpf_map *, map, struct cgroup *, cgroup)
 {
-	int ret;
-
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (!cgroup)
 		return -EINVAL;
 
-	if (!bpf_cgrp_storage_trylock())
-		return -EBUSY;
-
-	ret = cgroup_storage_delete(cgroup, map);
-	bpf_cgrp_storage_unlock();
-	return ret;
+	return cgroup_storage_delete(cgroup, map);
 }
 
 const struct bpf_map_ops cgrp_storage_map_ops = {
-- 
2.47.3


