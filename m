Return-Path: <netdev+bounces-257331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGmTLw4ahWmx8QMAu9opvQ
	(envelope-from <netdev+bounces-257331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:30:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2808FF815E
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 638C2303BB0D
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334E63376A2;
	Thu,  5 Feb 2026 22:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ur1pz1uM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CE5337BA5
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330562; cv=none; b=IrAKf0Elz95t9QWDazYjxA0Q18YxQ10NUWYsId8m3MmT53rlS8ms/7tb08YyI+rw5BPoj27etgdOq7aJDmUxSciPCAzN7WxYpOV6tSbu7xcfqSQdWjPkcBvxXiN/2DNGVy5wPVH0N5Pj4Kc0RC7/cXOxlmUJPI79PWPZTTCfG2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330562; c=relaxed/simple;
	bh=9nZ6jpC7RDqDEJq2NNVLElMp/GWAaSXmG7B6xW+5CS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gE6giwPriid7cjOwAHJs55bbrvrqNw+4dujghLkEsmeMZaVmdmv01nS2pZC6fdxVMuAinlQd2zRTb8DjU6BLjNl9/34H0UGFAfbCeMjPeswgFtIKn2lIf/WMX1Fn/AX2BKUx4PF2+qSxTtPE4SXEhhaSoE1HSA+myr61Zy+SkC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ur1pz1uM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a9296b3926so11807785ad.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 14:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330561; x=1770935361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFAdrsbHgzRyyWJg1DcmckeIQG/iHVdwXXcQIChXPXA=;
        b=Ur1pz1uM9ECo+AqkibUJOjdiseK23MBsE7p/sJxK78RDcucAwwbcKKT3o5SA9M5eYs
         ZcyGgKMImRqNgovVZVliKAHtvb97ISKtyOnyjmw/nKuiTnGw7IPRr+HoCB9PRScpvcxs
         g9+t20PKYrs2bjznKn3BGn4nNfjwF7ss/QGOu/0gNXMFx4OsIJ/NPQXakvwzcZa1vp5r
         yD+SReT9uUQL28BpN3Nh/XiK5hkgMQ4ZuTLiYqRkk/ugsCppzCrZr3HDGwxpMcqQaXSH
         f0Sj0pLplYLUPr3mmnr4rCjhhBY/Jz5LisE8nUKTtSkh60Ks6kTsHbyNRAO0INSx0FMG
         DURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330561; x=1770935361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FFAdrsbHgzRyyWJg1DcmckeIQG/iHVdwXXcQIChXPXA=;
        b=QyjxFYRJO6MSX9TGWF+iO9Vjcv11nCi7M3c+z/+aUuGJ+yXwMLlz9B+9qnn8a3okZe
         OZh90RZGeu2x31P9IiZsM6o+ON9BOMolSGyP/zI97Kr5gedpxnu1xjL1lTRhja9ucZo0
         81A+xvah9lcTsCt9wUQTVdVu0lZz/BOI8H9FNS9M7SY9YzF+HgfEL5TGyNTrTFTrWQAO
         15UH6bzCUmeWoTWe4hkA3rbOqTuEXfP01KFUsFnPiWzi9++RAcPf+vpzhUKI/cv/OO9Z
         5Z24JnGHpqIjx5qJ/U/Zkd8W7I7yEdLbRWC5IOH3Iz7mtiYcJKG7Mg4oi+B5fRnpUB+d
         VulQ==
X-Gm-Message-State: AOJu0YwscqZsNgX+ovsXhusYDI9veWvp2N9p5V7/DGnOeKDyR7Df/vXf
	weaXdQmmzA4jGWvjzFYrUwa+T1WXH45Xx6SWdQfFnSU+zSIAa1NbBIxX
X-Gm-Gg: AZuq6aJPATTo6kollALLEEcVxK8Bl2NCy+5PRrDT0d+0JOMwG4kZGb1eTayfyp6O3d0
	rf9ie+d1cJuMGN2caFcpfIFrWFDgTSoaxC8Do1qLCv1Wked+1aAbW49wBgZyqDxkA/aCBJh9ubo
	x5QvKqVF4k1qnOmSHzFtHvrNpvjnb+c6qfILwsE1TzmB46+eW62eMbWTf3NSxmRLv2FgT64nUF3
	TjJopAAi8DJgTa5byKc2Vo0hxsGgD4VwSm6RwYEw+CFoegWU99l4wiVQl6l/k2mTGi+HbsH6EqB
	k6xgIi1JTf+0xf/dZqvFfYwZ7UJZ5sqDblCLcBsvLlYR0XKbKha5zL7vOitfFiUU10ejAE4B2wC
	y9VGMEuEU4C50b0wgogJBuizpSUCF4hhZxms7wyw1QOMBlsUT12bX9QUiSFd3H5SSq7VwUBB1A6
	w5wQ==
X-Received: by 2002:a17:903:298d:b0:2a9:4e8:ae45 with SMTP id d9443c01a7336-2a95167e079mr6135145ad.27.1770330561270;
        Thu, 05 Feb 2026 14:29:21 -0800 (PST)
Received: from localhost ([2a03:2880:ff:58::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b305f6efsm246562a91.2.2026.02.05.14.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:20 -0800 (PST)
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
Subject: [PATCH bpf-next v7 03/17] bpf: Convert bpf_selem_link_map to failable
Date: Thu,  5 Feb 2026 14:29:01 -0800
Message-ID: <20260205222916.1788211-4-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-257331-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 2808FF815E
X-Rspamd-Action: no action

To prepare for changing bpf_local_storage_map_bucket::lock to rqspinlock,
convert bpf_selem_link_map() to failable. It still always succeeds and
returns 0 until the change happens. No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h | 6 +++---
 kernel/bpf/bpf_local_storage.c    | 8 +++++---
 net/core/bpf_sk_storage.c         | 9 ++++++++-
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 2638487425b8..709506e982a6 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -178,9 +178,9 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 
 void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
 
-void bpf_selem_link_map(struct bpf_local_storage_map *smap,
-			struct bpf_local_storage *local_storage,
-			struct bpf_local_storage_elem *selem);
+int bpf_selem_link_map(struct bpf_local_storage_map *smap,
+		       struct bpf_local_storage *local_storage,
+		       struct bpf_local_storage_elem *selem);
 
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 6fa71502c7d7..2f94ca4a4475 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -365,9 +365,9 @@ static void bpf_selem_unlink_map_nolock(struct bpf_local_storage_elem *selem)
 	hlist_del_init_rcu(&selem->map_node);
 }
 
-void bpf_selem_link_map(struct bpf_local_storage_map *smap,
-			struct bpf_local_storage *local_storage,
-			struct bpf_local_storage_elem *selem)
+int bpf_selem_link_map(struct bpf_local_storage_map *smap,
+		       struct bpf_local_storage *local_storage,
+		       struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
@@ -376,6 +376,8 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	raw_spin_lock_irqsave(&b->lock, flags);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 	raw_spin_unlock_irqrestore(&b->lock, flags);
+
+	return 0;
 }
 
 static void bpf_selem_link_map_nolock(struct bpf_local_storage_map_bucket *b,
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index e36273e4fcbd..0b85d8f2c17e 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -191,7 +191,14 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		}
 
 		if (new_sk_storage) {
-			bpf_selem_link_map(smap, new_sk_storage, copy_selem);
+			ret = bpf_selem_link_map(smap, new_sk_storage, copy_selem);
+			if (ret) {
+				bpf_selem_free(copy_selem, true);
+				atomic_sub(smap->elem_size,
+					   &newsk->sk_omem_alloc);
+				bpf_map_put(map);
+				goto out;
+			}
 			bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
 		} else {
 			ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
-- 
2.47.3


