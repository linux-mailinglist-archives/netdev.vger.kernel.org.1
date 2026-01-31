Return-Path: <netdev+bounces-255348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNEJMZiOfWmGSgIAu9opvQ
	(envelope-from <netdev+bounces-255348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:09:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8FEC0AD8
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29347300600F
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C18A328603;
	Sat, 31 Jan 2026 05:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcWtx09X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F0A330328
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 05:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836168; cv=none; b=XcVgViLU7/g3Kt38FKUXYgsU8n/Ji+ixrO3pklQ3S1dlsOq2FE3/bBQuJ0Qlk4ZFp7Mb2/oArrDCvbEsOhNuqC2fpSbgqDktHADkjdxJKRGeFvuIDEoguXue32codu7PqlVXVkwRntNiS80DYVcu7OC6Ni3QYa9uxKi5rU5sfo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836168; c=relaxed/simple;
	bh=ZZ83GhZsOop6I5Cstj6vurMVVgLh1GU7oDlqaegHFp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaVSe+tcLFUT6HYXTHrVGxK7MYwgLIDY2nkhKdiJK26cS4LCbFX0VsaQtoTh+3vS9+DzdPHunXaQYF1ocryQVPMBJHaXHydW063ENSbrgA3veb6fbEmmxFXK7Aod6ovJlyechZdz7whwadL0vekEoQCBeKpBgMibLH9IAqekBIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcWtx09X; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0834769f0so18598675ad.2
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836166; x=1770440966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFEgS9FcO38B+wcnpk2Av0d1YmvDJw80lbOmqJ4hYjA=;
        b=AcWtx09XY5g6CCHS9NFruDaWX6Va7BFy52dAISAH+o1fqLRffMqBnS86w42oGlRtRT
         SpT4u68hwqcISpObPX5aM/0b7m7KowkS9MhhKacIwygA6a+UBpJ74uFU3qmRgwWBsSCO
         xDrl4TbtSGlaIl31FSLPYRFQEkrfCs6lQjSxANRQ0vEkPA72o0cPtnQcWTqL96psi00/
         G/ZXTaO8FzsnWjjzyrRpckBJrNOtNaD9vIiETvbdgossmZom4u3a7ae6fu8AtaHBVel6
         6q4pruQNU6DzBb9uhQ/kKkXa+dEJHCaIirEBh3EzjJqnXszcLw4/naWrLlqjmPnZmOSx
         v3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836166; x=1770440966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YFEgS9FcO38B+wcnpk2Av0d1YmvDJw80lbOmqJ4hYjA=;
        b=xOoM86t3IykpN3laN4s0CeKN8eXbCo+ghRC1NTLv/jz5U72kSJ3i4WMZwWFwjIBKEN
         8glGYSAltAstfjHhoPFMOf0ske2IscEVOzbjrAhkVddmLbTdQQgwV1XzThLE+BOFg521
         HbrgNm0VhwyWedBvygt4rIS8UPs9mb+Ut6YZ72NX0DAy4BFmFJEkNsynArCA0qapCGUr
         6xHl5nMXgK/8rwyQ6f48Qoq4xQnnuKYmxz2rJudMpkA0dsw/ZNDGV3493L7QnD54TYZB
         usYL1V2nHMFxHUFayxp44t9bueNz9LOzRpic0lCUGgI9WmtjdBWXoneKfxu90a8qjxck
         75mQ==
X-Gm-Message-State: AOJu0YxJmqBRa36RihgRKNjgjhrNPIW347Y8twDhgGuuK4ftWjsjem1U
	3BdxMl41j9I8EkbVfB8ROXT5y35ZPRAovWD3TxTJCJuabJKoKRj2f5XM
X-Gm-Gg: AZuq6aKneaNhuXzZdbbhJaDse+L+DlZT9B5IsKjxTxvBrm+ABpVVIF6AQxjNm0X+gJz
	QCIDzGt7NtyHdqjfPEoLbrb1OuysqRgmRmjM6lPbpLdVAB575De//k+1A81hTM5GsiJiE3Q4XeC
	WY5sgxch8lFNgcfIER2/kiFnW3oIJzbUtmmgO5pUb03K/JeKewpPfXFmF6vM371K5q0LQB6OOpb
	WKoeafyZOOZ2PQr7yTpO1/e3iHMtw3RTbJzcLGfc2YOuPzSyoqL4nl30yjFNCMWyG4kIJalYI+T
	ji6OClLzQXJyd++w1TiAZuSTJmPgmEMCgfPGPPcGbl3XLa23niocZHLsT180cm7hjQx9XS7CzfJ
	KWlv30z0nD+Cpt1j1ct7wChpFmj1pt2Kt+5cVuEbfGRhSdVvDSZJeSMDIgN52Tf6dmjHUr1imYj
	P+4Q==
X-Received: by 2002:a17:903:1211:b0:2a8:7814:47ce with SMTP id d9443c01a7336-2a8d96a7ffemr56151555ad.23.1769836166242;
        Fri, 30 Jan 2026 21:09:26 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4153e4sm92234715ad.39.2026.01.30.21.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:25 -0800 (PST)
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
Subject: [PATCH bpf-next v4 04/16] bpf: Convert bpf_selem_unlink to failable
Date: Fri, 30 Jan 2026 21:09:07 -0800
Message-ID: <20260131050920.2574084-5-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255348-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB8FEC0AD8
X-Rspamd-Action: no action

To prepare changing both bpf_local_storage_map_bucket::lock and
bpf_local_storage::lock to rqspinlock, convert bpf_selem_unlink() to
failable. It still always succeeds and returns 0 until the change
happens. No functional change.

Open code bpf_selem_unlink_storage() in the only caller,
bpf_selem_unlink(), since unlink_map and unlink_storage must be done
together after all the necessary locks are acquired.

For bpf_local_storage_map_free(), ignore the return from
bpf_selem_unlink() for now. A later patch will allow it to unlink selems
even when failing to acquire locks.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  2 +-
 kernel/bpf/bpf_cgrp_storage.c     |  3 +-
 kernel/bpf/bpf_inode_storage.c    |  4 +-
 kernel/bpf/bpf_local_storage.c    | 71 +++++++++++++++----------------
 kernel/bpf/bpf_task_storage.c     |  4 +-
 net/core/bpf_sk_storage.c         |  4 +-
 6 files changed, 39 insertions(+), 49 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 6cabf5154cf6..a94e12ddd83d 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -176,7 +176,7 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem);
 
-void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
+int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
 
 int bpf_selem_link_map(struct bpf_local_storage_map *smap,
 		       struct bpf_local_storage_elem *selem);
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 0687a760974a..8fef24fcac68 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -118,8 +118,7 @@ static int cgroup_storage_delete(struct cgroup *cgroup, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index e54cce2b9175..cedc99184dad 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -110,9 +110,7 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 939102a5f4f7..824d053255cb 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -308,33 +308,6 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	return free_local_storage;
 }
 
-static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
-				     bool reuse_now)
-{
-	struct bpf_local_storage *local_storage;
-	bool free_local_storage = false;
-	HLIST_HEAD(selem_free_list);
-	unsigned long flags;
-
-	if (unlikely(!selem_linked_to_storage_lockless(selem)))
-		/* selem has already been unlinked from sk */
-		return;
-
-	local_storage = rcu_dereference_check(selem->local_storage,
-					      bpf_rcu_lock_held());
-
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
-	if (likely(selem_linked_to_storage(selem)))
-		free_local_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, &selem_free_list);
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
-
-	bpf_selem_free_list(&selem_free_list, reuse_now);
-
-	if (free_local_storage)
-		bpf_local_storage_free(local_storage, reuse_now);
-}
-
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem)
 {
@@ -389,19 +362,43 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map_bucket *b,
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 }
 
-void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
+int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 {
-	int err;
+	struct bpf_local_storage *local_storage;
+	bool free_local_storage = false;
+	HLIST_HEAD(selem_free_list);
+	unsigned long flags;
+	int err = 0;
 
-	/* Always unlink from map before unlinking from local_storage
-	 * because selem will be freed after successfully unlinked from
-	 * the local_storage.
-	 */
-	err = bpf_selem_unlink_map(selem);
-	if (err)
-		return;
+	if (unlikely(!selem_linked_to_storage_lockless(selem)))
+		/* selem has already been unlinked from sk */
+		return 0;
+
+	local_storage = rcu_dereference_check(selem->local_storage,
+					      bpf_rcu_lock_held());
+
+	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	if (likely(selem_linked_to_storage(selem))) {
+		/* Always unlink from map before unlinking from local_storage
+		 * because selem will be freed after successfully unlinked from
+		 * the local_storage.
+		 */
+		err = bpf_selem_unlink_map(selem);
+		if (err)
+			goto out;
+
+		free_local_storage = bpf_selem_unlink_storage_nolock(
+			local_storage, selem, &selem_free_list);
+	}
+out:
+	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
-	bpf_selem_unlink_storage(selem, reuse_now);
+	bpf_selem_free_list(&selem_free_list, reuse_now);
+
+	if (free_local_storage)
+		bpf_local_storage_free(local_storage, reuse_now);
+
+	return err;
 }
 
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index a1dc1bf0848a..ab902364ac23 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -167,9 +167,7 @@ static int task_storage_delete(struct task_struct *task, struct bpf_map *map,
 	if (!nobusy)
 		return -EBUSY;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 static long bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 9da11a53109b..78e936288879 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -40,9 +40,7 @@ static int bpf_sk_storage_del(struct sock *sk, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 /* Called by __sk_destruct() & bpf_sk_storage_clone() */
-- 
2.47.3


