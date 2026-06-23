Return-Path: <netdev+bounces-301438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TDsnOfTHOmoTGwgAu9opvQ
	(envelope-from <netdev+bounces-301438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:52:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E4C6B9428
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:52:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=f23z+ISI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301438-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301438-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C17FB30B4975
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1226C39021B;
	Tue, 23 Jun 2026 17:50:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE3C38E5C5
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:50:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237015; cv=none; b=K2Yho4+90rkg5WUCCNNiY/HvMXVxTF0BGqIDqIopp4auv6X6aDoAQa5H9n+zOrGTALSNQC3OajBLxHKDtXLbWrIN9j6Ph8UB02xmK2SFkzmRbP5Cun8otpu/aw/S8qabVE8kflKrOpZLZwiQNvBlb3kXrNN6X6HK3k3lMLnHWg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237015; c=relaxed/simple;
	bh=gmLEo8Qxva12wQh7T7WKvyYkCRo+UtZhxyO4uYoxDck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSxPTAydbW8XRZyfUCac2LkOrwL+hbs9Ok8/nMGG9sjYGGshwC0GtnwRtWEztEEq+CaAxFgY4m7b/2aZfUHASyNamI0gPsT77zQcf4xDy1D3U1FXtGx1j/28usnHTlQD4KswGkAqjVaXzhAMnm21l4q4tdtrkFI4joJnlDYzHI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f23z+ISI; arc=none smtp.client-ip=209.85.161.41
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6a11f19fcf6so88447eaf.3
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237012; x=1782841812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDpmIhKnKapld7EYbwQsM9K3Ane5eLzTjrBFUjiMOE8=;
        b=f23z+ISIBPgzqr7YlgKvwRRKA1HhvxzYQ04M4zFA95nNSB+PiTobo22qeCujsYaZq2
         EFpx82BWwjvvtQUD/DnqpoK2/dvmzvJhVUEantSsLHW+Tcgw3zWmlzhgzg0Bio6cI8BQ
         lnF7FHtCtqkcbUiXAnIbwP7GuY4o2Q1PXVwanxZFalKgWr/cTrfzOd7/oYLqc04jAhLw
         DRQoyszSNEGVyhmlF4hgcc16xNDzC13r+wbwmbTW1YbDTSNevNs7Q08V9F3csSeUjiJD
         VOlvNAl50jGw0ALqubK2y1Is7a3rc5ZM0K6TvojU3XfgoCxKGQOedFtoCfMkr5UM4X4j
         mJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237012; x=1782841812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TDpmIhKnKapld7EYbwQsM9K3Ane5eLzTjrBFUjiMOE8=;
        b=pXGmltbePFlE1XOmkyfPO8Qb1OLyyvT8++2RC1GodAZ423zsp2HQWvWrHL55JmxqLm
         VxdBOoZoGXMeY0wPXfMuUSvM4WRAQevApHj8OkwKFAhV63Q7ivQYf3t+9L/ANZikokZE
         i5AgxJ341OvDt78iXrUZ9gcDlzH4p9HRiBhoUefObCQ799bQ4AH+ZD9Y0Z9x1Z8JqsTo
         088CqmmEocvaIUwDdwYwKKXEahAVWfFQrcN4bb2t4UV2cdheMhmfMCR/XWS+tHOkOkZo
         48RJzu51iKIbqiwIt0RW62YjCuSr/4HnF/1EEy4POoN7I21IiT/R8UqC3NhO6BnOcjAS
         GC2A==
X-Gm-Message-State: AOJu0YwY6fDDgK3kgdVVsz3Fh8TsMxibLvaI6wVWKX9hVQmkcDirE7eN
	F4rAfHdZuCpkH5Hl6O3/oiCPDu3gBktXh0dzXKtPhlASUSCrzqiYazo1
X-Gm-Gg: AfdE7cm5753M2KGAfHHYAGRgisdklFV9NYHb6ajqjM4XFKlolwNa6bZidqvJ2zwNcsB
	c0+EdJ+L0hHYKXumPoexl9lZ/z2kFymcVtc6uf8+5sq2B/3o6+JykeW1wamG0XOxMrdFRmcgB99
	l5W4WEq95GZWZw7V7M7ie2m++RgpjPODdqj4O0m0aQ7mX8BChY8NkXL2rU0N9B0WS5SVzzLj2vr
	WsFU0iLVBkX+HXuJIxUHrDw3nnqhM5QB9zKEAAQEuWCsrDl7TsXglRXw1IA/piAByDmUXk8p7lm
	uhYqbtMK/zJYOt7mmtSwn5dN2NeWRvC40WHz8iaZJCtUndpIVrbAmmclPKwS3xVMJuqpT8fQ7Dx
	e8K5WcqdMq2Iefqg9IJ9KsJoGO5cKwGa55M4lwStfRQKksiKG+urRt7T7AiJftN247b2TBCdkO6
	ygIok=
X-Received: by 2002:a05:6820:c453:10b0:6a1:19ad:7a0e with SMTP id 006d021491bc7-6a119ad7b61mr1256261eaf.17.1782237012515;
        Tue, 23 Jun 2026 10:50:12 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0e9f2a4e9sm7350572eaf.2.2026.06.23.10.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:12 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 03/15] bpf: Add bpf_struct_ops accessor helpers
Date: Tue, 23 Jun 2026 10:49:51 -0700
Message-ID: <20260623175006.3136053-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623175006.3136053-1-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-301438-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48E4C6B9428

From: Martin KaFai Lau <martin.lau@kernel.org>

Add the helper functions bpf_struct_ops_map_kdata(),
bpf_struct_ops_kdata_map_id(), and bpf_struct_ops_map_cfi_stubs()
in bpf_struct_ops.c. They will be called from cgroup.c in the upcoming
patch to create a struct_ops to cgroup attachment link.

bpf_struct_ops_valid_to_reg() is also exposed for the upcoming caller
in cgroup.c.

The link update validation is also refactored into a new function
bpf_struct_ops_link_update_check() such that it can be reused by the caller
in cgroup.c in the upcoming patch.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h         | 28 +++++++++++++++++
 kernel/bpf/bpf_struct_ops.c | 63 ++++++++++++++++++++++++++++---------
 2 files changed, 77 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7ac8873839f4..047ffc029666 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2252,6 +2252,12 @@ u32 bpf_struct_ops_id(const void *kdata);
 int bpf_struct_ops_for_each_prog(const void *kdata,
 				 int (*cb)(struct bpf_prog *prog, void *data),
 				 void *data);
+void *bpf_struct_ops_map_kdata(struct bpf_map *map);
+u32 bpf_struct_ops_kdata_map_id(void *kdata);
+void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map);
+bool bpf_struct_ops_valid_to_reg(struct bpf_map *map);
+int bpf_struct_ops_link_update_check(struct bpf_map *new_map, struct bpf_map *old_map,
+				     struct bpf_map *expected_old_map);
 
 #ifdef CONFIG_NET
 /* Define it here to avoid the use of forward declaration */
@@ -2316,6 +2322,28 @@ static inline void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struc
 static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc)
 {
 }
+static inline void *bpf_struct_ops_map_kdata(struct bpf_map *map)
+{
+	return NULL;
+}
+static inline u32 bpf_struct_ops_kdata_map_id(void *kdata)
+{
+	return 0;
+}
+static inline void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
+{
+	return NULL;
+}
+static inline bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
+{
+	return false;
+}
+static inline int bpf_struct_ops_link_update_check(struct bpf_map *new_map,
+						   struct bpf_map *old_map,
+						   struct bpf_map *expected_old_map)
+{
+	return -EOPNOTSUPP;
+}
 
 #endif
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index c422ce41873e..1ca44584ed17 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1236,7 +1236,33 @@ int bpf_struct_ops_for_each_prog(const void *kdata,
 }
 EXPORT_SYMBOL_GPL(bpf_struct_ops_for_each_prog);
 
-static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
+void *bpf_struct_ops_map_kdata(struct bpf_map *map)
+{
+	struct bpf_struct_ops_map *st_map;
+
+	st_map = container_of(map, struct bpf_struct_ops_map, map);
+	return st_map->kvalue.data;
+}
+
+u32 bpf_struct_ops_kdata_map_id(void *kdata)
+{
+	struct bpf_struct_ops_value *kvalue =
+		container_of(kdata, struct bpf_struct_ops_value, data);
+	struct bpf_struct_ops_map *st_map =
+		container_of(kvalue, struct bpf_struct_ops_map, kvalue);
+
+	return st_map->map.id;
+}
+
+void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
+{
+	struct bpf_struct_ops_map *st_map;
+
+	st_map = container_of(map, struct bpf_struct_ops_map, map);
+	return st_map->st_ops_desc->st_ops->cfi_stubs;
+}
+
+bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
 
@@ -1289,6 +1315,26 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
 	return 0;
 }
 
+int bpf_struct_ops_link_update_check(struct bpf_map *new_map,
+				     struct bpf_map *old_map,
+				     struct bpf_map *expected_old_map)
+{
+	struct bpf_struct_ops_map *st_map, *old_st_map;
+
+	if (!old_map)
+		return -ENOLINK;
+	if (expected_old_map && old_map != expected_old_map)
+		return -EPERM;
+
+	st_map = container_of(new_map, struct bpf_struct_ops_map, map);
+	old_st_map = container_of(old_map, struct bpf_struct_ops_map, map);
+	/* The new and old struct_ops must be the same type. */
+	if (st_map->st_ops_desc != old_st_map->st_ops_desc)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map *new_map,
 					  struct bpf_map *expected_old_map)
 {
@@ -1307,23 +1353,12 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 		return -EOPNOTSUPP;
 
 	mutex_lock(&update_mutex);
-
 	old_map = st_link->map;
-	if (!old_map) {
-		err = -ENOLINK;
-		goto err_out;
-	}
-	if (expected_old_map && old_map != expected_old_map) {
-		err = -EPERM;
+	err = bpf_struct_ops_link_update_check(new_map, old_map, expected_old_map);
+	if (err)
 		goto err_out;
-	}
 
 	old_st_map = container_of(old_map, struct bpf_struct_ops_map, map);
-	/* The new and old struct_ops must be the same type. */
-	if (st_map->st_ops_desc != old_st_map->st_ops_desc) {
-		err = -EINVAL;
-		goto err_out;
-	}
 
 	err = st_map->st_ops_desc->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.data, link);
 	if (err)
-- 
2.53.0-Meta


