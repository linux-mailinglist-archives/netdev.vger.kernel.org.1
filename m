Return-Path: <netdev+bounces-255345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOoHCouOfWmGSgIAu9opvQ
	(envelope-from <netdev+bounces-255345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:09:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF0DC0AC0
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33E86300442E
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E010326944;
	Sat, 31 Jan 2026 05:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU94hfZg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41D02D97BA
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 05:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836165; cv=none; b=hsXvEIKnRuv/KBWNFRo3ZPgfX2BdbnmEI43iWG4n9nA2LxnkApk8blvXc1XDVchiWI16k4d5NRnNQm82XOCNRRdYSm8bBsLl0GafPvvzG9K1zKHSEEGQHHXo76Uc54LWTrnxOjZOJLP6YLvlkReH9LAue5QWxLLhGEdK5QC0pJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836165; c=relaxed/simple;
	bh=0cYFFL4ID+Ke5t+JDsj3nW6hrFD01KscY+HnJgGkoRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6JHR3Z/8AcsZC/PmbbYPmefCWehfTAKeEl3M4ge0HYRa8pROYkhpBZEn5DJ3ylKBoWVP1v38kyM6nCm+gRiLx8CS2lyMk9Ch154thOhgOjUAVSq8aO/rkhystnVsMcQ1r723TVNKkPXm+nqgob2K8bdI/ubngF8tCO6M+pqfyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RU94hfZg; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81f4e36512aso2669068b3a.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836163; x=1770440963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6o3cyyoBy24EAM1iNpTtyNRMAxUSkdC0pE7Ue9M7MyE=;
        b=RU94hfZgf+ypXCDWveYTdKoAlcz1aSQlIe3GziAq1gcANaHuHkvsQcQgBbf0iTc97a
         Mcbek7h7x1XodaaXw6t35LhhmPQsNsi0RT9TrxjeDLbsiOHmAmj55keVqZA3GmxxH/+y
         DJi3y0Sahsozk38P1Fs11KXbLaJgIo6w0zw7MHatj0Uqzs0SlSV7y1qersZ0s4u9QgNm
         Aj5nTZIS7zrprW9j8L631zfJyZDopISx6gHp/NepZItKm/I85LlYi+j4vTDNuOwel+Oi
         lk74bsuxYD1JXdwkmDVM4botDt9+7UqD6IgQZE4/yuw0pef5UkS+EKfkO/PyWj3RCGET
         Mtng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836163; x=1770440963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6o3cyyoBy24EAM1iNpTtyNRMAxUSkdC0pE7Ue9M7MyE=;
        b=rx1xNv39+4wZ/H0rADE/sXSOfE2fktSKrMS9WxQO+HqZkE6T20Lr3JZcHFqWO8rN5/
         yHSRpdWIZQoXzLwLcfZ/pNZcs5bVMIeOaNjlHEJzAg07TAIgbL5QNFVmovty6QZFHgOb
         GZNLD86Ya0Iyzggo2SGbW9NT5LhVLGWI2nAoDSZUmZnaHJJpNzppctvHITKL6vF7h6Rt
         R+VVqIFolocgY1kGmRDPjmNQNvDTHzF3jYwhZ1JvhvX1oPV354OnEQdJLXoT8Q7DnQ7W
         JG9w8w8akzzbXiHPUMsxWo2EWaAYs924J9IGhRy3qYLVkQWhoa+VpgO0aYkrIYma0r9G
         mDag==
X-Gm-Message-State: AOJu0YzLWi64Ruk/bkiNDcVF7WsQoW7EgJ0cEjG/Bv5d7bX/TZUOeYgJ
	2VesK7OnneD86HAfsqobqoMsV//eCe8EnEbZNK1iVsMVGZHCE4utEt1Q
X-Gm-Gg: AZuq6aLa20IHSWV+6Zd0C8ol9yK1EjAuLCg6UYbGgiCsGjmj834Ln8Mu3RhxryzZRLI
	UX3TRE8R6tsmkENfiG5Z1tsOu7MN4WBd5OFTMgqKNeMT2E8rh6oG45uAr4borm7Jtay4kNklMfL
	MUghUKaYCtPTfMCWA0XlHNO/u3gLqh2ZC7/JYGLCB6LKmClsI4B22hLjCkeh9OvC2WY9DRi+XCD
	bqeITYQoZ+n8zT7Uxpm4CUiAa+m+p1szx6nBiaf8Zfdh08WvyV61mJZDNrDIuKYVwQrxWl7SqUf
	B7+qaKO5cIATJp1NVfPqM6jsarmdx0uvj6TVMjjb2KdaWR8C5fSkF3eJfzt89/cIKGiDwJCPuez
	/anEl+EAg0m4on/MkXtdV34gfoL2d9mW60srzDKIsHNYMgA1RG7wFsQHJ0VbEafduxU2Gk9b8GI
	5fVw==
X-Received: by 2002:a05:6a00:94f3:b0:823:a0d:b745 with SMTP id d2e1a72fcca58-823ab74b9cbmr4954567b3a.56.1769836163006;
        Fri, 30 Jan 2026 21:09:23 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c1fc6esm9525808b3a.47.2026.01.30.21.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:22 -0800 (PST)
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
Subject: [PATCH bpf-next v4 01/16] bpf: Select bpf_local_storage_map_bucket based on bpf_local_storage
Date: Fri, 30 Jan 2026 21:09:04 -0800
Message-ID: <20260131050920.2574084-2-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255345-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FF0DC0AC0
X-Rspamd-Action: no action

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
index e2fe6c32822b..6615091dd0e5 100644
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
@@ -349,6 +349,7 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 
 static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 {
+	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
@@ -357,8 +358,10 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
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
@@ -368,9 +371,13 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
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
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 	raw_spin_unlock_irqrestore(&b->lock, flags);
-- 
2.47.3


