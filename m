Return-Path: <netdev+bounces-255347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMzdAcOOfWmGSgIAu9opvQ
	(envelope-from <netdev+bounces-255347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:10:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F4FC0AF4
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C951830293E0
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27A5330337;
	Sat, 31 Jan 2026 05:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4ZRygRf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3D3329C70
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 05:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836166; cv=none; b=leW0R0VnL/z9AnhoMaRX8HjHH/xEsdi8a85tGCyhEvX9AGFSpycDmMs70gyTphKJSxPP1YgJwPQbYmdkyAPS+R5nrtzbf7q8YE7GUxWBxdRT14tyb2kM9Ad+r6TZEfyJXcgLZSjRfBSVVs8T8Cc3+qVW/DBPlHZ29WJSUavd87Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836166; c=relaxed/simple;
	bh=dVNhRFCoPz5fB8oJTj1ik4DZXJTyctpy0fizmsGyqXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFwREziZ04PQg+FG8xqkCtMO2tekYezjI2dkjY5BxkVscahAKSBw00JZnSao0i0aUJ0DfFwBqCwppDpggkjiVrMcVdOS34vqQjxiVLM3lXm3NMy0hdfjWyAcWneI8i/l+ALsMQ2pb0tAIYBsm4H2l0f+RqMJ5equUXMzgF0zU4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4ZRygRf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81ecbdfdcebso1565611b3a.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836165; x=1770440965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeEFnOPDg+WkhPNJeXKtuF2o+yucGCuayjkKqgFaEc0=;
        b=V4ZRygRffZPkZ32LQA99Xt/9vyH5x7sYQOqmgHSCZ56J9z7HYVgCp7ZEQ4XUiXS4jw
         /jvJR5k1/4KiZbSQjws4no66xIogLKWKwxBElerTDy2ZuyXfo3CyUSfcdHtREopGN/z+
         Y14EHb1UAkp4NUI4vXRkZ42X9VxMXguqSig66GYwGNytzG0ZQtsk/b3qXIpguOCt/xZQ
         3R8949KqhY/sq4yfehA2pOw6SfKCxpMkI1e+tYdl+wA4x3LL4/jKywLSEtjHwAUiS12/
         dS9WddBG532M7X5q4meDS3kL8ghUnE3kaWfNOHH3tSt9FOZqj9ak6I9+o2zWnBjGCGp3
         WJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836165; x=1770440965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XeEFnOPDg+WkhPNJeXKtuF2o+yucGCuayjkKqgFaEc0=;
        b=g5yhsm2GugKKhS3qqaTPNKQkl8f3ZHd8+NGwgxbu7AmGvpvYiE70rFTR14kC7WElua
         Is0bQ+8OeO0mVftoIcks30f86xs0QLe8wk3GEdQMxQX2qjefRskeuzbOcCXIKTApkGW2
         Yb/hjuqiYF8L9qpRs5ymVC7n6KMrdVoTFVix4l5CW+yV/E/f5WB18PXdo+1MPDfVm5F3
         +FcQ5WQRabNK9ZnXMkwWBrL6mxcjydeVrn38u6+ruqawUvk3g+RjhQ8M+St+pXBzLMA+
         /XNlnIvpCkBCPZht+mXq6Rrri8vCC48IPMfJdUH54Fcv8dTg7Fhb+1JbDkDFtTTkQ0ul
         B7dQ==
X-Gm-Message-State: AOJu0YxBWISLHVK3vopD9RzU/dFDTCyHgIXCZK2fEegqM28W7MdqsYaB
	xkOA0/+2IpLHq8oJa7RhIKYkOoCYIXXmdt9Mx5eRHRcbHWkGtjWWHmEV
X-Gm-Gg: AZuq6aJRUDnzBSSAN0blvxZr9y6usdsZG+8uiW/sMcBPGFx+kKQ1iMIOwO0dR9gUw3s
	3poEeBhdDT2xHf0s3JrIDaYoCxTDatvGbzMjfjNsohu8cl/jNPko22AMYMu1aPM7/k5IPCWwrDg
	D5U/XlCQ+pmR++nZbhm+gzFiUQQIIrveqrbWTexxi+cwWO5BpJNp9QYJ5rEzSblIUDcbEGrZhc+
	bS4ZgiTvehRYfe7EhZn3ywnH6sX0wkA3TMEf2lGkdGz9FgFNkxpT3HgtVIkDbyv4FEdKScwOJ8W
	1Xs2P2hkibTE7eXn+iZBUjEWcWcG/IR69KZVMzoPV6QFuE/hJ00blFzn3YEvH3k8O6yjawzKenp
	8wvrvwhnapO0RUYpTOsYKjrw38bDJ9vUux7K1QheHPuF9TqsYzyTvXHmj64Hq5c4b1kvX9bAkbq
	tXEw==
X-Received: by 2002:a05:6a00:94db:b0:81f:99a4:190 with SMTP id d2e1a72fcca58-823ab643c11mr5135635b3a.7.1769836165134;
        Fri, 30 Jan 2026 21:09:25 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c21112sm9418473b3a.54.2026.01.30.21.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:24 -0800 (PST)
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
Subject: [PATCH bpf-next v4 03/16] bpf: Convert bpf_selem_link_map to failable
Date: Fri, 30 Jan 2026 21:09:06 -0800
Message-ID: <20260131050920.2574084-4-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-255347-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 59F4FC0AF4
X-Rspamd-Action: no action

To prepare for changing bpf_local_storage_map_bucket::lock to rqspinlock,
convert bpf_selem_link_map() to failable. It still always succeeds and
returns 0 until the change happens. No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h | 4 ++--
 kernel/bpf/bpf_local_storage.c    | 6 ++++--
 net/core/bpf_sk_storage.c         | 4 +++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 66432248cd81..6cabf5154cf6 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -178,8 +178,8 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 
 void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
 
-void bpf_selem_link_map(struct bpf_local_storage_map *smap,
-			struct bpf_local_storage_elem *selem);
+int bpf_selem_link_map(struct bpf_local_storage_map *smap,
+		       struct bpf_local_storage_elem *selem);
 
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 1916ea2aee4b..939102a5f4f7 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -366,8 +366,8 @@ static void bpf_selem_unlink_map_nolock(struct bpf_local_storage_elem *selem)
 	hlist_del_init_rcu(&selem->map_node);
 }
 
-void bpf_selem_link_map(struct bpf_local_storage_map *smap,
-			struct bpf_local_storage_elem *selem)
+int bpf_selem_link_map(struct bpf_local_storage_map *smap,
+		       struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map_bucket *b;
@@ -379,6 +379,8 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	raw_spin_lock_irqsave(&b->lock, flags);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 	raw_spin_unlock_irqrestore(&b->lock, flags);
+
+	return 0;
 }
 
 static void bpf_selem_link_map_nolock(struct bpf_local_storage_map_bucket *b,
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index de111818f3a0..9da11a53109b 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -191,7 +191,9 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		}
 
 		if (new_sk_storage) {
-			bpf_selem_link_map(smap, copy_selem);
+			ret = bpf_selem_link_map(smap, copy_selem);
+			if (ret)
+				goto out;
 			bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
 		} else {
 			ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
-- 
2.47.3


