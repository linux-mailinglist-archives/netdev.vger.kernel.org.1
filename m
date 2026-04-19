Return-Path: <netdev+bounces-279565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMH8GVdT5Gl/UAEAu9opvQ
	(envelope-from <netdev+bounces-279565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 06:00:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8509423081
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 06:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F00573014C28
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 04:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA95311957;
	Sun, 19 Apr 2026 04:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpXft9+f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9485212B143
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 03:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776571202; cv=none; b=kSwSIXJz+kHg3GvIDK++mWWpO0148sh7FuJivY4M55DVFT8K3TG+4MmfE6SL+FljKkJuxuBjqh6vaQD+oyQnvkuw6rz+nyv4AFOQYtkc6Mc2simJ3WfF8aKeIex6LPHyvyl+rlb6bzVCGHh0x96cwsevI7OVU7H/jyH6vfn0CmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776571202; c=relaxed/simple;
	bh=u9M8XJ+TuJc+FvvsgLZJVLKmaQWgnQjZ4K3dES/btwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LKzhCejMPe9vYTOre8uwTYnG6fnB+0unaWGR4jkW5J71B1vENuKRVH8E1UpijY1oaBOBGQX/Rb+ekdR81k43EwJ89REVWRUOqIgRTjdkg+/X3gea9RaWrQhusbWBhxxJqa3+NhIP/P1yWGvyHXyN3jfv0qM45IKLeC9OmA3Mtng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpXft9+f; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d90833cacso1171775a91.2
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 20:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776571199; x=1777175999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/atA6Y4AEYftjpIDt7SezrAfNPMwZ6QVT88PjQLPRM=;
        b=ZpXft9+fBUb5xYYB15m6ZE3u9KwSjFRM/3ad728RMgesNN+kSFUB6AHCRey+VQ+bTN
         5ErA4yeW5ecUFU9dwiU3ic6hj2xaV5n6s44HHpkfEO3reB0H4AshhhS4zs1imDTm5a0q
         sFLvw9hX1XYHM8/qpdP3/79gQFiKOyDmsNywtXt8dI/kxo5ANHs6q3gN0e0euoCIAx4I
         X3Q5GhrwhM++NUbaQb80I/rRt+g8DOm/HIuIzyiEMv0M1HmY8Cs2P5HqT0u+1Zdsut6g
         cm4+eDUTUfyGCt6WvvPvQJOkmMC0KfNCJqGp/kjUKgyuZztMG5iIiAjhkz3wuWhSDbNS
         iVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776571199; x=1777175999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/atA6Y4AEYftjpIDt7SezrAfNPMwZ6QVT88PjQLPRM=;
        b=JVrOSFpbLti/670XTwYahL0dVhO0oAtqjLdETVaHglVj0b8CNoP9YE7JyeA8B58q8m
         FjH+YtJkDjHqE6WFPOkeBGbP3x8joRT3d9DG0wqpWAYfTxJry1tupldVvQSNyynnsNGE
         5FNQCyuM1sjQfeTJSGlFQVcrI6GUqD+7RfdPCOB5Q7OngQwbrxrVn/pIeRlPxuqVc0OZ
         sDU1Ft8ZdMMZiFGKcOLl5i2BgqgER30qdJVfxp/X7yq762iojTloHzhbyk10WVIyERLm
         TqCq7UDJfYVQGB3V61UoPtZ/Z+huw442bp7njMTSPsw+gJYBqGS8M92Bf1mvXQTu9o22
         9tRA==
X-Forwarded-Encrypted: i=1; AFNElJ+Pdpmhjl5SJ21GEMQaGgOLu9KC6iJSHjpIHpCPecIawHFD4Ixo6c9+B+A9Md0QWig6rXenPiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGRDThtM8THtC54J69y4RpqefQ2GJMCRo+J5nYQkaMmeENr465
	5mI+Hzg/J53Uo3SLKDKAmgm+TY6RrJ5KlK/MUmcSfAE8cSGGKWEOjFcvF6O2wg==
X-Gm-Gg: AeBDieuAkITpikbhg0Dq7yrcM/N1ifOjjPi/W+dPq6EhXsoQjlRxEHdM/sZntz/Mk4W
	X0QywM/7FeHvzcO9aaszZRIYNq3OeWZtxz8k1OunFV0bHA+jvd8L8OQV3D68ZWO9Bs3gaYP/vam
	EuA8TyLXo9iDfMh2bZIVL9xLlaW85Fb8SZR1LNeozA9VsGILVlrkHp/1hLsQbUMDoYTbTCT46x6
	ZFPB+vHvc6Vclqi0x+Da9rx6f0rjNY4ypSeS4VeL8VtIrP7mUXxfeui8XQMHtPypu6WN6eWHqVN
	lusXyCCh+ifIWbTm/kbMoMBiMuWRoZxHSfHzg19h7ZMXJ7xU1QK8hAo8XP5syXAMXNgkhjK3NiV
	Yqaa7ou40cHfiqgsyAOylD/POIByunq5KV6TxrjPaJQg/nhYisNMYTSI2O60vdfkY9iSX4JWNTg
	a/C2TP6QpE6UG/iN+jsnpRaEwnmaNKZwQmToE=
X-Received: by 2002:a17:90b:3e88:b0:359:f77f:8cff with SMTP id 98e67ed59e1d1-3614048e396mr9233870a91.19.1776571198830;
        Sat, 18 Apr 2026 20:59:58 -0700 (PDT)
Received: from fedora ([2401:4900:8838:1107:4b02:340c:af49:3bdc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613f5766c4sm3355358a91.0.2026.04.18.20.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 20:59:58 -0700 (PDT)
From: Avinash Pal <avinashpal441@gmail.com>
To: avinashpal441@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] bpf: verifier: fix NULL deref in map_kptr_match_type() for scalar regs
Date: Sun, 19 Apr 2026 09:29:48 +0530
Message-ID: <20260419035948.9498-1-avinashpal441@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279565-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinashpal441@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8509423081
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A NULL pointer dereference occurs in map_kptr_match_type() when a BPF
program attempts to store a scalar value (non-pointer register) into a
map slot annotated as a kptr (kernel pointer).

Call chain:
  check_store_reg()
    -> check_mem_access()
       -> check_map_kptr_access()
          -> map_kptr_match_type()
             -> btf_is_kernel(reg->btf)   <-- NULL deref

For scalar registers reg->btf is NULL. map_kptr_match_type() passes
this directly to btf_is_kernel(), which performs a container_of()-based
offset access and triggers a general protection fault:

  KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000000000000ef]
  RIP: 0010:btf_is_kernel+0x2a/0x50

Fix: add an early NULL guard on reg->btf at the top of
map_kptr_match_type(). If reg->btf is NULL, emit a verifier log message
and return -EACCES so the program is rejected cleanly instead of
crashing the kernel.

Reproducer: store a scalar into a kptr-annotated BPF_MAP_TYPE_LRU_HASH
slot via a kprobe program — verifier crashes during bpf_prog_load().

Reported-by: Le Chen <le.chen@bugzilla.kernel.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221372
Signed-off-by: Avinash Pal <avinashpal441@gmail.com>
---
 kernel/bpf/verifier.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 69d75515ed..15b8f71074 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4545,6 +4545,18 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 			       struct btf_field *kptr_field,
 			       struct bpf_reg_state *reg, u32 regno)
 {
+	/*
+	 * If the source register has no BTF type (e.g. it is a scalar),
+	 * it cannot possibly match a kptr slot. Reject early to avoid
+	 * passing a NULL reg->btf to btf_is_kernel(), which would cause
+	 * a NULL pointer dereference inside that function.
+	 */
+	if (!reg->btf) {
+		verbose(env, "R%d is not a pointer, cannot store into kptr slot\n",
+			regno);
+		return -EACCES;
+	}
+
 	const char *targ_name = btf_type_name(kptr_field->kptr.btf, kptr_field->kptr.btf_id);
 	int perm_flags;
 	const char *reg_name = "";
-- 
2.53.0


