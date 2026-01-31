Return-Path: <netdev+bounces-255353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM2jAEOPfWmGSgIAu9opvQ
	(envelope-from <netdev+bounces-255353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:12:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64759C0B46
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E39F3053DEE
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D12833343F;
	Sat, 31 Jan 2026 05:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbFlR0Qn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A8B3375CB
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 05:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836174; cv=none; b=gZs4HLV/rGuXW0uichVUPGqh3I+O+5akp+6UeFwAF0QPi3CS7wptklZEimUfNA/gPYjAeMpGCrsQ4Yc0I3o5VC1GurL9W8KoM34PS/9/EZnu2D2L1SjneyQ2D7vTnbvvyh7zeQBtqN2ZIM/APWsZVIVtcBRfMGuNomXlc2C/K5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836174; c=relaxed/simple;
	bh=7G76bSoQmX1Hi/VvKi6UReL/Zsyk3cYD6d7hNbP7K5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqZhxQW3RUrMJfv/hkthCH/Mn614FKgHk+vdshH5kIimlEOlWnuecZYf20NDGg0MonBOYe9sMohqtqQCfw55HIdeh7OGfxKs6Qhk06b6tj8y116grFHpF3WvfiX9DOygocPyusKd2tu0DCkDm0q4cvlWSnGcxG0e4PoX2TAMVSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbFlR0Qn; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1034508a12.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836172; x=1770440972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTC2NAeUBpSoxfV1jyI9ihzRy5Gdcws7bJcw730/KGs=;
        b=CbFlR0Qn/F0C2Ki3C5DmIqbJtmPXOt3p2pyOnwPq2EtaRuHXgZ3bOfan8IA1cJp/4F
         K1AcYsXCYqJ9W+X0785ejO9RTDDH66dkF0t5nUSka5HC1zudxPgyF8suZoUWsv4SlZzq
         HS8B8wgV70MTnwAeRqS8hvPzKVRRudQItXc6fpASpHGMo1CAl+KhoDpdBSWsBWMZOtmf
         wqqb1KgfR+kx7ijDc8S0xtlP43OtX2TTm5BtnSe6r7ug7sn4GKSfSdLVWCz8Oe0QWZpF
         RhxpA7o7SZRWJo+14xWR4np32c0BD0TNF/6HYiw2WLtJSrV0dnwmT9pxOSezZMXS0a/B
         ckiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836172; x=1770440972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bTC2NAeUBpSoxfV1jyI9ihzRy5Gdcws7bJcw730/KGs=;
        b=E0l/iPgtJhkJ9Fy0yJWPd0d2YhNk9t3g8Nj4bqwFBbACaLGUPqIsDcgIn4dTvJRTBi
         NslP/ZwKU1LjUdF4VM/3lAJUdpmzRI5Zc5n7yShn+hWMM4XEON3EPr05NDz+ccyOwFfr
         VziB32Q4ipOE3WhrQongGYZmlptleYnU/MJJO0F+2RrXm4rQkaQ0vR2xENLak2GDyXkx
         imMrFG14iO6BeXiKAWC9CQguLGdrTkvGSgni0zLWTqu1EMIBm1HU+SziCGc+dxjYj2+Q
         NCAaZD9G55d6Gz2UN55V3vea4EUbr4K+l59CFZYBr6N1kiNU+HkRu//UA7PL6UvJd46x
         vR2w==
X-Gm-Message-State: AOJu0YzpXAi+Iv7BUrKFKgCduujFISDRdrCXMjTL7hV4HGSxjlvL5Sm/
	hcq2/hxQgJ41SU1sEtE8Vy/RsRTOxcQ79cSoP2I1zigVzpBQ27tFcOsu
X-Gm-Gg: AZuq6aKXJU8TdJJSflIByTquSHSCDD52lAS6AOkVX85MjNzBQRzzQkFTRHv27R88pLV
	1D5T5NPp1B8EhZkKAeuTI0vIvmN1hEN7Z1vYtkIqaGuhgW0ubjfKKs3bHvCU+juvCotsBsXowZo
	/PTkfOAxIyLzBgpcIdK+pQAOAlL7mphsm8fslfQ6PCJ+U2GLwhKmviAjG/yxT2KF4P5zFcMtUd/
	1rr7Ae7T/iq5fUn1AGlSfooDIyEwnPkuThF3YaJ67vc3O6lNzrG4eg8QmzDSayWfd/vyqhra2id
	WMHvse0mflWLkAO8q38QJVM553mRQ76ilrg6OpCSpPa9GklVEIxD7/WIAis3ZUVwu0+4z+XEuGY
	a9pJOp+dmylH4H2eL+sJLL4jblm+Hmst2fe2XN6UXuim2vqRT+EhuStCG4EbMW/bk6sDWyFwv+D
	cXMGWTF+IurRgl
X-Received: by 2002:a17:90b:1343:b0:352:c9c9:75b8 with SMTP id 98e67ed59e1d1-3543b41d89bmr5015894a91.36.1769836172256;
        Fri, 30 Jan 2026 21:09:32 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3543d72cccbsm1552887a91.13.2026.01.30.21.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:31 -0800 (PST)
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
Subject: [PATCH bpf-next v4 09/16] bpf: Prepare for bpf_selem_unlink_nofail()
Date: Fri, 30 Jan 2026 21:09:12 -0800
Message-ID: <20260131050920.2574084-10-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-255353-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 64759C0B46
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
index 70b35dfc01c9..ece32f756d86 100644
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
index fbf41e00be8a..b8f146d41ffe 100644
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


