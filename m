Return-Path: <netdev+bounces-255655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANmiGrOSf2lotwIAu9opvQ
	(envelope-from <netdev+bounces-255655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:51:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE9CC6CBC
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E48423013A5D
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 17:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB04280318;
	Sun,  1 Feb 2026 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFGB8oWp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5391127FD68
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968264; cv=none; b=poZiq2+sLsS5iRstDp/dFw2wJZ4jOFFQP/z8CIKV8tW9GED0mKstG2EHlYwlPzGcea4SwdXE/TBQwmpmmx3NvPpzYa+eKgAi9mCjmmVHfeSLvRVGfpe6lxff/VVqpu/krtCGfxI6CkZWRj6lR7YnH0Drt1hWyG+Tid2PDlizh/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968264; c=relaxed/simple;
	bh=tqyw3tdxTDjap3zYB15sILBy3tvrSukfm+ZbTrKJ/Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhmzxQ822lJSNrKdWWushhYrx2NeXV62QU/XGf5zuLjTW/CjudD+7HXZfjC4HQBrPoC4jVER/mliaSjsC8ZW1/LZrUMmO45kXsXC5Y3YXlbhtjjPTJdHSVCTho1F3Bru3oznKc1V8kjjQUiFMKe6qA8qp9T9lGVXpRkv+KlB1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFGB8oWp; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81e8b1bdf0cso2216100b3a.3
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 09:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968263; x=1770573063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDJEAOra13fhqSAyHSRmRMMglqt1FGPMQOen9Yczug8=;
        b=LFGB8oWpEGsY++qiBaVOmLDTLd8a8loaqveJKNgOxyftw83xV7pv6tmq6F74/bhwqu
         TaPKRrfrps5DBxS2BHX4pcrvraNk6SNbp+Ew3LpAtlCZnLNPeQCSfSvi2JTq4V747kCs
         1Lev3Kd05obNagGN6fyWWLGOhXObaSQl/bplwJC8mzC2UguBltCXe5niTFf6HA3QPPq5
         /r62R0E0KNuB1IRiZuR09BuIJWDihTai3NSSR5YSeXZ67NOvxdZjCjL25PFIZSYvDlVp
         8ubr4Bb2yMD265vBuIMwI8eOLQ+zgwnord37wfcuW7lPWFeYa9VslT7+l2P3XYZwEHuy
         H+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968263; x=1770573063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DDJEAOra13fhqSAyHSRmRMMglqt1FGPMQOen9Yczug8=;
        b=FRCqYXr2qyeexr8ATM85VDtBhrKhlO6Ux4u32A7EU7PPZufYnHbUB3lFIdf09lJiVS
         VCKglM0XG2amkJDEzcm6NPVEtygj0uxzE1CqnZAQNmw9Q14X18HRLIN9prOvNUkl8jIv
         cBDqhwCWjtJbejbiikcmP/QgCxl9O/gXDRXwoxcJtdIfDXerV6cGQ/596PPTX238+fkR
         2ln05Df6LmRm3LdocI1YAZxxRZrH78ErPABDS3ZY2V5g7lxYuynfq78+8UI1+68KbvC4
         rR8zQrenifbIU/Rhn/veqc7wyaKPxh4CrJzB4W/hVO+AALEGx1etB9uUMf0n6t9gUiIE
         dqrw==
X-Gm-Message-State: AOJu0YzbGmbJeRphuyLZiUTnx5rGpEesrjaIix9URtKqy4E7fd6S4mN9
	MNdVw5vN8Bg8QajKdUZEO4bbncnaMz32fRYvWXBHHb11KgtZ0OdMCqjc
X-Gm-Gg: AZuq6aJ9BEnfjoq4zqdCHt3Dz/htydxp/Gm7CioEhdoZAiu4KmAyFy7mFzGptIEE+R0
	N39nvQSIs9Qt/jYl+wJV9SkVY6GnfC6MS3E2LPkz6svAKi5cHbrYEOnvIdrm6cpzUo+qlHY1VZK
	Jo4XVCvcFps1VespHx5BnMfxiV2j3erNNDrtYbwv1vvjmOshHdHqmtzdwo+fLRGMbRW1jlIKb6Y
	2x9Miz9yAgYIFyO8Ym71ewbU1QjMmWxy/EqJO3bFevCX4KhP0irLx23WUuoz1MiMOIyQHWIz8yQ
	5xyCRkV5z9nIqJG998hhOFLHvT6a2NLk5+tyPNo5z/GBF+yTLtKjumU3eq4KBm+1ybD7dS8LNbj
	k5lXImO3vQCUPLM3AfvsPavj15qXV2DTY3V4i7i29w0kFp8j0iosIkfd10NpqCZpSyNF6mb+aPn
	hS2i1teBuma6d4
X-Received: by 2002:a17:903:2796:b0:2a7:3daa:583f with SMTP id d9443c01a7336-2a8d9593415mr60544755ad.2.1769968262709;
        Sun, 01 Feb 2026 09:51:02 -0800 (PST)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d99eesm122897775ad.78.2026.02.01.09.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:51:02 -0800 (PST)
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
Subject: [PATCH bpf-next v5 09/16] bpf: Prepare for bpf_selem_unlink_nofail()
Date: Sun,  1 Feb 2026 09:50:42 -0800
Message-ID: <20260201175050.468601-10-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255655-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2BE9CC6CBC
X-Rspamd-Action: no action

The next patch will introduce bpf_selem_unlink_nofail() to handle
rqspinlock errors. bpf_selem_unlink_nofail() will allow an selem to be
partially unlinked from map or local storage. Save memory allocation
method in selem so that later an selem can be correctly freed even when
SDATA(selem)->smap is init to NULL.

In addition, keep track of memory charge to the owner in local storage
so that later bpf_selem_unlink_nofail() can return the correct memory
charge to the owner. Updating selems_size is protected by
local_storage->lock.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  4 +++-
 kernel/bpf/bpf_local_storage.c    | 10 +++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index fba3354988d3..6fb02ffdb8aa 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -80,7 +80,8 @@ struct bpf_local_storage_elem {
 						 * after raw_spin_unlock
 						 */
 	};
-	/* 8 bytes hole */
+	bool use_kmalloc_nolock;
+	/* 7 bytes hole */
 	/* The data is stored in another cacheline to minimize
 	 * the number of cachelines access during a cache hit.
 	 */
@@ -96,6 +97,7 @@ struct bpf_local_storage {
 				 */
 	struct rcu_head rcu;
 	rqspinlock_t lock;	/* Protect adding/removing from the "list" */
+	u64 selems_size;	/* Total selem size. Protected by "lock" */
 	bool use_kmalloc_nolock;
 };
 
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 3735f79a7b55..0b8d7eaa2f92 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -85,6 +85,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 
 	if (selem) {
 		RCU_INIT_POINTER(SDATA(selem)->smap, smap);
+		selem->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 		if (value) {
 			/* No need to call check_and_init_map_value as memory is zero init */
@@ -214,7 +215,7 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 
-	if (!smap->use_kmalloc_nolock) {
+	if (!selem->use_kmalloc_nolock) {
 		/*
 		 * No uptr will be unpin even when reuse_now == false since uptr
 		 * is only supported in task local storage, where
@@ -305,12 +306,19 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	if (rcu_access_pointer(local_storage->smap) == smap)
 		RCU_INIT_POINTER(local_storage->smap, NULL);
 
+	local_storage->selems_size -= smap->elem_size;
+
 	return free_local_storage;
 }
 
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem)
 {
+	struct bpf_local_storage_map *smap;
+
+	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
+	local_storage->selems_size += smap->elem_size;
+
 	RCU_INIT_POINTER(selem->local_storage, local_storage);
 	hlist_add_head_rcu(&selem->snode, &local_storage->list);
 }
-- 
2.47.3


