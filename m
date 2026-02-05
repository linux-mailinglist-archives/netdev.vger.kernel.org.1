Return-Path: <netdev+bounces-256992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL32KKRAhGng1wMAu9opvQ
	(envelope-from <netdev+bounces-256992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:03:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC960EF394
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 067EF300A59E
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8944D35B632;
	Thu,  5 Feb 2026 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5+onEYX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C16C35B62B
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274934; cv=none; b=RmP3gA3EvGXKlTvuAbZjJQD13OZ5Q6y5+QQjIS2+BwfX3+upnrJfJDUao3untQGEzf/MlKYhMdsNDyVM7GKG89oki8q0N9te2OyYQRUl+u4aQ6kWGHmzkdzEGg+L+yTRe5mu3ajv7zWvz5qSFCcHBL5iAPz77DIE2Mr369anF6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274934; c=relaxed/simple;
	bh=gdcsyDwNsQ2ytUCW/HWb7WipDs2hLnfg7IQSIR9TeL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbThreG8hxJ2Q8kpRzpF1kbL5hquxdLVrS5+DdHNeCSOoD+K86rF0POXv7VTBswoWnRZNlqhWU64r4VLbfcVbSAvIm902AefcsBNYCUdqEHZHBrGbfaf5UHXq3lOr60Iscwa/4FvVzxqFv6bJQRYGv3xV+hygrOXLgkxrtEFczk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5+onEYX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-350fe1f8ea3so260339a91.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274934; x=1770879734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3g3juUlDLxi5nurQC1ri4utc2R15A7zEeplfXXAvTo=;
        b=i5+onEYXzXIFkCNxEHM8VNhPbGNfhAsYbCDPT9O3+CBIG+pYsP+ZkwwPKnrDu47OAy
         VWAbrc+au0c82AoTr3VeEbXqibLBepgStN+kuja1bqeSkbHhi2mNXMZsxFGSEYnGU0xf
         zDV3QB5R7HWMw9VkN3WPgbFGuMDQx/lHiUXDJzR1DXOd2wxN9+YaMlB5R/ff69YLGrqL
         Qwm/Pm+lAhprlUpUymD5vqA4uL9iMVG+oqenwSaB7s8AQn60L+RL7jXCV0emFGSVrNCH
         6Q8vLUuathSOckQbYCDA9XWa3hNAnfcdtnFFEpNuyzbZW1hLnkB/gzaSuoMvoRXoGtoZ
         HkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274934; x=1770879734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x3g3juUlDLxi5nurQC1ri4utc2R15A7zEeplfXXAvTo=;
        b=W1xxNyj9HuDQ8HuR6nzwMbDTScurwsTlMvWrxM7AgaY2LkrxvAE1ftuppc6tFUbtjf
         8urolXKDTiaciRBOrDYt4WY/DSaItsw2VJdkniXocfjVn4N2jEBIUaU2nwT0Wk61D+nc
         VRl1kkhJFmbUcaKmPJwyUjJGNPmWwBDYqY+CEHitRoMCWRK9CVpFDipZkAyPlnvLAyM0
         z8hmw5Ms/gDb2v2kJYs7da5zldKBRNh+hA9epKwJEe8Irmhyu0Crrl1x97RaVbbdLoxK
         vMHLpxjLRdVjnQcrvVjS33h65iY5XR6+mmUDOiSLGE6xqFmgyh9FuLa3phN8Mb77ylO4
         E9/Q==
X-Gm-Message-State: AOJu0YyBKP/BLUI3+cNnsHlyDxODLi0rd5JHP+0847wDa9vhcd21NiSi
	/ZlLeD6ElJEbTThXaw+9hHUhpt1QiDYLtiRoMDhU3N7fXnIPb59mUX5N
X-Gm-Gg: AZuq6aJAnZqFpmkY6s8iysN4I357PcItR27rW+rcSedpIohnJZuCJOSruXbXwkV0rEM
	0nhQPTEEoMQcj4Qmy4WW1XtqSOTmcstX8h5Fl5bqL40uBuhabDy0cKGigt6gXsyUXBn6PT6ix0O
	PymX0iinDL6UluNpYS2+5L/OEpaRI45c0NkGPB1cFGvCE/Galg6qocvobLyK50cxA4HluylWxob
	k+XAL6PpuEdSIl9wKbtHSXspRx7l0DF/ulA+VFzN0sVXzUvlULrpRldjrYy/q5N8e/jYUZlsRYl
	QyogrEsOVikpQvIYzMyOFqQIRXSVfm478IbDrkgbDOcJM4qx1p9fftiVwlXQb1IkHCWl/biFoGN
	6F5gEelxPMYYcLLG+Z3rNW2+oc2w4/5seUnrMctYSNIX03yGpFywJ8/IQr+TsHMDKiHgKnojx4L
	mbAH+X7/2lM2Ce
X-Received: by 2002:a17:90b:1a89:b0:343:eb40:8dca with SMTP id 98e67ed59e1d1-35487190e1emr5094064a91.19.1770274933364;
        Wed, 04 Feb 2026 23:02:13 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c0bce5esm2089559a91.5.2026.02.04.23.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:13 -0800 (PST)
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
Subject: [PATCH bpf-next v6 03/17] bpf: Convert bpf_selem_link_map to failable
Date: Wed,  4 Feb 2026 23:01:52 -0800
Message-ID: <20260205070208.186382-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205070208.186382-1-ameryhung@gmail.com>
References: <20260205070208.186382-1-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-256992-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
X-Rspamd-Queue-Id: CC960EF394
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


