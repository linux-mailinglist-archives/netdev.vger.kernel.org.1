Return-Path: <netdev+bounces-279566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MlRTBFxU5GmYUAEAu9opvQ
	(envelope-from <netdev+bounces-279566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 06:04:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9934B42308F
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 06:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D78523006830
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 04:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B317263C9F;
	Sun, 19 Apr 2026 04:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4gWllS/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60065733E
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 04:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776571480; cv=none; b=cKNPZmWDS3OV0/rIjvrHTyUQNvtrpbd/q9K3af+8Bn75CCASiyKqmPlPaJV2PU76Vl4rgjPcDrN6J8WXpM9ePAh1f8OP8GRQWKT2abbwPGpflRe3PZJTwB7IwNm3UMSGFPs+shSygOn6AXS6o/IIV7ClWTiE7/O9kRUhjLQhJRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776571480; c=relaxed/simple;
	bh=u9M8XJ+TuJc+FvvsgLZJVLKmaQWgnQjZ4K3dES/btwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ya+dR3AUMSqnuumvfccJvF9YmF64n01KVxVfSUaGHF0MoB5nBSHRoI10Apl5uWUFS9P13qIgPU0s7bOACu5gZI315U5fsLtakbN1S6iV+fF7OZWHRrAiju1Fn5t6fJSI19YYz8fSKoNzNZqXqk0QO/3OYzxv9b106MIpOha/Yx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4gWllS/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso1885347a91.3
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 21:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776571478; x=1777176278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/atA6Y4AEYftjpIDt7SezrAfNPMwZ6QVT88PjQLPRM=;
        b=c4gWllS/SBMP/+lKRScE+ysI/lfM5vcMeEPs0cJUGQ+8hiGhTbdVOziv06EHuORdaS
         QQKA+y/m3CkPYp/OIqqXWv03sVkHGU6Mp+k8LftF8MVe77k9F7cULdvplrnEDG3u7gvw
         QiGAUVRLOj6o7AHJEOWu/VAU4p0EPr9Vii+yF/77tx1KZlUo58wGoKk2Ij3gxtIE5FJr
         thwwyoXPFph1jEzWj1d559s/ZZY4iFfs4cXMp4kczU+R4vhGyQESU1lxsoNHmE/jBlUn
         cWgURNUbnlXRDb4SKmHwGhik+wozZDhoXTdkw7LWQ7KsxCAfanzhxcgKSxxHNKClilmi
         kzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776571478; x=1777176278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/atA6Y4AEYftjpIDt7SezrAfNPMwZ6QVT88PjQLPRM=;
        b=Plsh2vj+3KFR1NNfDmhFjZCtupi/pDBJaYExCwX/JjSlCJTPmE7YEt6zXbt/5xKXOL
         9YqkPRCzJsngZVMX+KViV+QyNH7awCWomi/VPCH/D7X2DIdqpkl1wFg+Pb6LrivWK1Yd
         HWa6S0ykCIqZ5xZ2tdLkzqwNM62UiFKeF/ZsOuXAHh8PLcNrpE93hCREruwtR9psQHQW
         pfrjkIJgDI4Ay6e3bGi2U/6yE+HgFDt6+RVj2tObuXHHC2dO6IzjoZvN+61jyWBFNVyz
         MV9MDVEjgE8a5fL9ixyF6Z7oveS4tdqgKOEY4WR70tziMHADTp2OAtTjSBxbkQoBR9EC
         8TCw==
X-Forwarded-Encrypted: i=1; AFNElJ9qFqbGQXgLdGod7j0jqM7pfvsTEZ2NLEL3vRrbjK6CGPl8+AZEMEOhiunqiToIoWGBTIVGyJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGs+lrJPFY5bciMoBTVIX90q86VEkduA9exnuLqpglzi187QM1
	7wsYBTMxpYN6Lr5w1Op82Jlm1IH+zZzwWA36CAC7kWTpPqMwh/Ty6cWh
X-Gm-Gg: AeBDievP+ep6uuQfkfoal6ve4riTfotFW3AX81bX+mD+yj62JdzTXR5u0JPX7u/Zw2q
	Y+F4VadK82H2qKGD1gPHnCpWrRH6KVMj4ltca/vJjeqc+aepa6P/k2auy8oLIoD8lcUMsGJ2U2+
	cXv2IZvGATDb12Esri+J1msuG++yQK8r8tFX746J0Oyjqvkus+L6Bj+aqSQYtX278YUT1sfr9T7
	1tNBQ7zT7x8+PmStl2Gklf+KJsR4ittJ60cgQRXeIPkKhvE4HyzRrzljAjzPzWscOC/2mbTox66
	1vNshgOQixxHhGNZp0tGIEauQYEox1h7+//wnNSq16JpEuXLPtT6slPkS9Xs7+UydQli5WoPx0J
	dPhhjukS11kB4y1pzrBQOZuS/WDHW+cITnhDtZ+IXKA/l3u7EWkLcgf/7kQ9xva4hLtvRiV9Lnr
	nhyoRG8zFKtUOdPaayDcLLzzn5OrUDitx67/4=
X-Received: by 2002:a17:902:cec8:b0:2b0:5b4e:370c with SMTP id d9443c01a7336-2b5f9f8b3ccmr96681785ad.32.1776571478177;
        Sat, 18 Apr 2026 21:04:38 -0700 (PDT)
Received: from fedora ([2401:4900:8838:1107:4b02:340c:af49:3bdc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa30134sm64212825ad.30.2026.04.18.21.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 21:04:37 -0700 (PDT)
From: Avinash Pal <avinashpal441@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] bpf: verifier: fix NULL deref in map_kptr_match_type() for scalar regs
Date: Sun, 19 Apr 2026 09:34:26 +0530
Message-ID: <20260419040426.9672-1-avinashpal441@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279566-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinashpal441@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9934B42308F
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


