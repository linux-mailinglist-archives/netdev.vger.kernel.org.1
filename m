Return-Path: <netdev+bounces-255650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FDwKLiSf2lotwIAu9opvQ
	(envelope-from <netdev+bounces-255650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:51:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B73C6CCA
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ED303013ABA
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 17:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1D3280A51;
	Sun,  1 Feb 2026 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT7Bkw13"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A9D24E4C4
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968257; cv=none; b=Hw7p+C8t/ErW5NGP9OhlH2CwospUGzvtL8guHYREYy0Q2FSh8Wvovl5YVkRdeSXh6DgmNQxj0OWz+LKjSk0N8wIOyVGRl7BTbj6zqe4DkRUARM12CFv6RAADtEj2hCLiX0zVs8A7b2VqwK9vV+XrhRIB1a4PMg3Vvn3DaCbV9OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968257; c=relaxed/simple;
	bh=gdcsyDwNsQ2ytUCW/HWb7WipDs2hLnfg7IQSIR9TeL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DT0OOCbPmXD8ea09iwGOV4tgGESWc/sfoihrSUxgm5YJ5zXAvy7DIHk9Y35CILU95K16u28TJU9zmyAjowrm2axEXRYqdazqZo03vVF2M1xixvIVcm0OhkCM+ZROoWx9BrGm6NUxVEFPNA2y+ORbEHTOYNeUElmkfFhaC0YD/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FT7Bkw13; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82361bcbd8fso2137845b3a.0
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 09:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968256; x=1770573056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3g3juUlDLxi5nurQC1ri4utc2R15A7zEeplfXXAvTo=;
        b=FT7Bkw13ZyTDgzjPr+GFANGXMpuhoAsGuBv/Rpy3selgiPaZT3otsQPwVvL+ufSL2D
         /7T608SxVvV8jPe3bFTqI2FeydS5rvof58zLzaB9A1bCOuDIxIgaOjIf4+zyt8g9+69d
         GZWHweLCx6sW1VNYppkR8GeAhy39b3ZCEpz7OM9tWxX9gGrKOHNzlnXRP27Ek2X0nMud
         kpQAQwH0+5mpjdgqD0AZgv4GnvWfNiNwnyPioGucI/zPmWNpUeIM2k6twKCjkyjmD2Bx
         KpQNJpweYuiccsckFu3RpXEUXtkfW7LP7d0n3rlSyDJZUrp4XpmAV7OdzKQYAtnv6wKl
         hS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968256; x=1770573056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x3g3juUlDLxi5nurQC1ri4utc2R15A7zEeplfXXAvTo=;
        b=e2X/BYfqM7wN2jVHw2rTsGBYXWRH0hBtmGS3BLMx0JeCwZhVlydkCf23nhwyPnMwGJ
         6pZD8leK+uPSlDnhIbuh17Vyfj4Z+2JVKvZo+hmiYDxBzKcwMoDTkrIVbS4HJS4UV/l+
         BOqk0JmNlmRgFiCAR4tDuaZ/D3xaTniK8lcbzzo5PkVbohl7gVRtHlGlw4OAkQHFHA1G
         cUartI/PR2g3SVw5Njs/KMNbXETG7gB2zDmD53joEyL/3TI/SQ+rck90+GSmgBJKaT5F
         ruuNJ6vgSXFJpB6Xh1PRhib6qzrP5rdiFiAM58IwDVbz32Sk7H382iJQZVfcbsdRs7B5
         yK/Q==
X-Gm-Message-State: AOJu0YyX8UJsrSaQn/4W100rB01QcNB9nC1yJcf2yGEmRswwfPb2U25H
	JUkqeYEvb6EQcdjpclMEXCxegEi4k2FGnLdoUL/pgyFZ7aNkgHtxl4du
X-Gm-Gg: AZuq6aJ3qo/SyoqgyNGqTBh2jTN9+0snn+gVx6wkkVWYzb25MkaevpjhE2yFCHbCOEv
	/A89lJJf8w3roJItGKhKGRD/PmJkGs62367a3b1U9gCo57xwuiZovkD1aJj9Azl2iI0DF+nEZwc
	kxcJVmkKhmP8JwgDSj4Y//2+Ii1vHxaY5pGI+EG6FBUbvC+26AdJfwNl09SLGzp8cI0FoLbyKQ0
	SNe/ELOMmLtJ/4xeuUA4LiLQEBahQCpX9AiAgacnC7wJVmha/PIWdCUwvsJj0QsemPYBPH6k/7z
	eeKqhW5sS1L2yBaI5k+t78dYn5WF0+UfmhfsDCEcP8CZLo9uW07kZ3gB95Rt10uShfNUOm0pMVs
	iwHyhXDZjY6ddht8thzEXteqM55Fimo0cKhfgBaPm1rcYptt7VAvuRjS/Vlff1tOicDY0IvE2iR
	JPWQ==
X-Received: by 2002:a05:6300:404c:b0:38d:e87c:48c2 with SMTP id adf61e73a8af0-392e015baabmr8968666637.58.1769968255664;
        Sun, 01 Feb 2026 09:50:55 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c64283710e1sm12264732a12.14.2026.02.01.09.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:50:55 -0800 (PST)
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
Subject: [PATCH bpf-next v5 03/16] bpf: Convert bpf_selem_link_map to failable
Date: Sun,  1 Feb 2026 09:50:36 -0800
Message-ID: <20260201175050.468601-4-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255650-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 18B73C6CCA
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
index 5f7869078c4f..bcf7e7f42d18 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -366,9 +366,9 @@ static void bpf_selem_unlink_map_nolock(struct bpf_local_storage_elem *selem)
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
@@ -377,6 +377,8 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
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


