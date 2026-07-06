Return-Path: <netdev+bounces-305161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +SusOrr6S2r9dwEAu9opvQ
	(envelope-from <netdev+bounces-305161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:58:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EFD714BB8
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:58:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Sn54Qv5k;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305161-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305161-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CBE232CB0B4
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 17:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36D63B6359;
	Mon,  6 Jul 2026 17:19:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B884D2F5313
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 17:19:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358371; cv=none; b=A/rP+DLP3dd8ccmmyuTIOz6fEPSSCAn85C1S4vfVgIjtaq8TmKHYl18w8k+MI5nqjLVbuuRXK3EmebT6z5zjR/OnsE1BKDQlh8ewhgY8SGcv/tY4poaIdFRfjAMBR+QheHq5WAQcCgCETuUwnDu7gaTRfksgOGxm2euxOPbbnWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358371; c=relaxed/simple;
	bh=FMAxq7ofay6cEJidT7K3NIrWCEl/ch/yLiQP3c0HJek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlu9pLMrddkzyYwd4cmq2L5H2aIwxIBUcVQWTcPTnjGsNnwWN1FOSqP9qh5mtwNd+tLIQ7+szKzVTqhTIA6vnJE4K9xjAEknhJRkxUnjGmFqdu9SN6svJAOk5ztHKb0fmq6wYkvuU71q3q0DWyNpIzy9m5cd1s5Q/a+DVBiVQOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sn54Qv5k; arc=none smtp.client-ip=209.85.210.44
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7eb545db3afso1853561a34.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 10:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358369; x=1783963169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KUHL7XPZqgp5/anUPRj+nd5nWm4qXmUT0QocaLjcs1A=;
        b=Sn54Qv5kpHadtJV7bMqI5/vDI//2oJFTOUiyI+vnUT2GZvPclHLvGBM69VDGn9dqSX
         +iGlLxwICyx6DkZfrVFOiIDad0MLfE+2O5AJB7xswp9h6Y3V3fQmviKZMXiBREYH0Cpu
         Xj4e4fO1cEEC4DMiZCZCb0PhlZS4AIGlVB+SCuFZPiy6iqvuEK2//TYz5sdqYpP8ZFwD
         5AJJU4NK0+vE/i2g6VJb4MHJLshKlfkghRxZAxYzypetE/0gbuM6iYyOOHfH5MKRm/jt
         1LVMKkVFmzDtH2QsBiKvIPm+J5H/vkcoYpThWBsEDLujQIKkJHQlH/15z5temezZTw4E
         Dctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358369; x=1783963169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KUHL7XPZqgp5/anUPRj+nd5nWm4qXmUT0QocaLjcs1A=;
        b=pHJTYBdXwyyvn7uoo0lMk5fi6+IPbbMkWE+6u2YIOLyWXl03zIQoKa1rEkYl8sxmGj
         PziNwudUOXHVVbgi5TLdUc670AbEVukBDE2kLB4Bq1IoYyW8N25ps0/YJhg4JMO6YuN6
         7nWooJqQTJfH8eEGwBfxeCQfcpAz9pO75sqp/5da2mY2RMKdihM77d+nWvV68oxx+jtv
         gL3QdCy2UfEKDH1g0dC01IasYoXkpZ1/FIFF5xAYgQngH/LkDc8WrTTtMT1CdIjLKxER
         VKwc9yv6OlPuq4Br6mVzzIHllrNptlvro4G5Urw8EOZ1HhtQVcbBS17+ufu5clsNwws5
         kV5Q==
X-Gm-Message-State: AOJu0Yx+8yIVz+YjBFnOeKmoWN7I+j02Ytove5ufNDbwiwoiGhC8KX9R
	zZ4PdKhhLJZ0dDM4wclCDfDr+yif5Mkz7mQ3cvGFg2i3Nd9KDu9GhmaK
X-Gm-Gg: AfdE7cnw2FEQ//B8wEFPYHLIhSDFbDN0Ypgn8t8haFChhZgsOIKGmPjFG5rPltXv7qw
	pFwoYlTwPbrmbk9cUVYvbLCLcRzE5JeUF5NktmnFDGRPYd5BiDeSpuw6dQ9C6iEUL2HAVLx5rDy
	QTlcVIuOK0rrsxWo4Bho1FhH1NJIdqxk2GrULiu1/ppJRrOzPEWGKrqvBfDphrs3P8fx4RLmykX
	XZTRw3upxnVxUy8FpKHbxJGisOcxCxcUMsXRX0yTShTarYuiWruwvGJ+hrnhL41/G9agWl6jAF5
	W2ffK1FK7TjHaNNA9ifz7uHO735kH8sE0uqZp+JrJr93AO/3OWfHA+WPzQcsya1nL+YOv8TderH
	hgPS8SRT/FJb8v1BM8xnYEUY+rlvK4+LmKKNrC9GHo70vZUATAkKWcSu++ZF9/abUCaAj9iL73Z
	ulP/I=
X-Received: by 2002:a05:6830:6414:b0:7df:5fc:3fd5 with SMTP id 46e09a7af769-7ebb2176e5cmr889606a34.1.1783358368696;
        Mon, 06 Jul 2026 10:19:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb542936e6sm11859799a34.5.2026.07.06.10.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:28 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 03/15] bpf: Add bpf_struct_ops accessor helpers
Date: Mon,  6 Jul 2026 10:19:05 -0700
Message-ID: <20260706171918.317102-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706171918.317102-1-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	TAGGED_FROM(0.00)[bounces-305161-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50EFD714BB8

From: Martin KaFai Lau <martin.lau@kernel.org>

Add the helper functions bpf_struct_ops_map_kdata() and
bpf_struct_ops_map_cfi_stubs() in bpf_struct_ops.c. They will be called
from cgroup.c in the upcoming patch to create a struct_ops to cgroup
attachment link.

bpf_struct_ops_valid_to_reg() is also exposed for the upcoming caller
in cgroup.c.

The link update validation is also refactored into a new function
bpf_struct_ops_link_update_check() such that it can be reused by the
caller in cgroup.c in the upcoming patch.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h         | 28 ++++++++++++++++++++
 kernel/bpf/bpf_struct_ops.c | 53 +++++++++++++++++++++++++++----------
 2 files changed, 67 insertions(+), 14 deletions(-)

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
index c422ce41873e..3d650a7e9f68 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1236,7 +1236,23 @@ int bpf_struct_ops_for_each_prog(const void *kdata,
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
 
@@ -1289,6 +1305,26 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
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
@@ -1307,23 +1343,12 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
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
2.52.0


