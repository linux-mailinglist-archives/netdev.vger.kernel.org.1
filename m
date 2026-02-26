Return-Path: <netdev+bounces-261593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFk2L1y4oGnClwQAu9opvQ
	(envelope-from <netdev+bounces-261593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:17:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 260311AF999
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0A1D305F4D0
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB84436344;
	Thu, 26 Feb 2026 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="No4ssIvH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF9E4657E6
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140392; cv=none; b=ozUA6loCwoXklHl68UUXxDpwZAjY0bLlIM8+tvktVhEaCWrwGiDaa7YHyX7UpwtZQGMkrZlwbX8AWTU48WXceKsFMtQ0zTGbvdIUL9D7tkhEHROVxAWP54yEzDOMyjzIEYDOa1fwpxDSg8F3KpSjUuiRyuBZvBWmWtrkoZnlGhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140392; c=relaxed/simple;
	bh=FTEKhWF4PEGibE+Godw6WotVfkDzNJh+K3eNMLiAeUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=snhMv/an/SPm+IITAnJrM4fLz2hrMnpNoDl8wPsTKmD1DBEvJpYHFjctcayREAKdMXzT4dfJbwXK/xKyf0MvE3Dg/E4yahrMXoL5Ykls6ToDwwWn2167VCFkztgLOwGMG0A6/aOHMnW33fQ2rZzSy/AYOHB0a+NtHMrqy/wvvKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=No4ssIvH; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a0fc5e2c59so1738916e87.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 13:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772140387; x=1772745187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5Y97ofZPPMGkm4COkJmgiVmBo8g/xYAQ0YGVbCjwoU=;
        b=No4ssIvHEgrZ8DQlkFHrQbNbVVb2rPOxlpyV0u9vYTN+6psUNsZJ1DiQBML5tQf79C
         qwtYLXhL+/pPGK7PfH2+JtiMKywzFuxebuUhOGT8GX/KpmSPbrCCRqVjF3pmSy4yIBTf
         7UIM5aXHRT3gCCbpTPoi610paBFrdJUvGw03pzFklhwz0ZO03qViO4yYzYR6Mb+N+BPM
         qaXBZkwkwYBTi/XIFnsCOOMVPYX3cOpSwlqGxUK8ogEtdXLiSDJOX+dl8Wll7X9N+sUL
         jwxrboFg8bRYG5YQNZhDkoMfLLakk6YkVgs9TaW8/ZrKP7JHXG2qGd7j5wQ2iUglyB0F
         Llxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140387; x=1772745187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+5Y97ofZPPMGkm4COkJmgiVmBo8g/xYAQ0YGVbCjwoU=;
        b=gGXmpJP65f6WpgeRoxHqlBl9Q+cf8fWwVbQVoNjX7nfmPST5FfnyIxETH9yXW55T6I
         fynMK0Zs0DT/7q5e4SZHyWqxdZt/tYn/o0BSU1QDHoYFViu1lmLszxiNgcjsXXGJEhGO
         uaOcC0yziB+AbtDOfmWaDDLdyhlUi/UodGJa63DRyg477o6tjeTiMFsS2hf5dKeJyFJ0
         pYS+oKKg+tgcArMy407VdTIfErtIcV4HF0DLmxbLnplRjZ5c8IFQ5U66rP+OyFmddNic
         p76alBHNoP2r4Qp2MusPeLveKMwmwZ9iy+uCfAgSK0iCLt/AzwLF/XbVgngqjvvPG3Pf
         Iy9w==
X-Forwarded-Encrypted: i=1; AJvYcCX2EeoHMbtruVMQVX6g2V+5n2wSOy8jmZDR5BcZMoViZAEogLvfYuyam5onv1acvq1SLs6y0AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVueMwHY8QygV85VEcC15vJShDUfmuUh9nxrhfRGMs+OG+FPeb
	I7guSHTFrGsFjXOStyrGeb8igG6oKdYEp0UdOrzCwX9jazAqTILfu/CMQmhDm2Q38tQ=
X-Gm-Gg: ATEYQzw3SXIkOM1pV0mhBTAZb8EyyDF6tLUtC+zPKE48AgrkElS8Cf17HlyfyLRhoSm
	iaM1JVZ0JJQPpO4s/miFEA7FRnQZ7CqwBohtpEQ4n82d4rZhmY7zzxT/7dV5g8BxACWYTIBF9wE
	V0nkc/zquimhMwjZ/UF3VBOSPW2AWLYSwtbMPKeZFQ8AciLIoSC2g0SkEGPsiz2EsRLeuC13Mxl
	ieikOLxOdw+uduvQsKBjS4Iji85sqRCHKfZStOyZOpMZVUu/A+o1d9GgXQXzFMg9jZtE1/4QA95
	TcbdiruI80KG7f+N1TpZOcfablxG9I/aVM1ddFnSZuV8WS+YCVh0UUsiUOG56a7UXFlLI84RZT+
	SIWBJ8eLGAxit39i8V3voR2qKCIh8pLo3SPXfm/VB3zi5g50zf81p+yQfyUVNeb2FpVF2/brlPf
	BpEyAbjwsIftsac6vtMR780KO8x5GX/g6SudQMLRUwAbfIkuJcqENmXU0S1RaJdooh8Cmo
X-Received: by 2002:a05:6512:3503:b0:5a1:73:219 with SMTP id 2adb3069b0e04-5a10ff8450cmr168002e87.13.1772140386651;
        Thu, 26 Feb 2026 13:13:06 -0800 (PST)
Received: from cloudflare.com (79.184.124.63.ipv4.supernova.orange.pl. [79.184.124.63])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389f2f626a8sm9579071fa.13.2026.02.26.13.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:13:06 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 26 Feb 2026 22:12:52 +0100
Subject: [PATCH RFC bpf-next 1/5] bpf: Introduce local storage for sk_buff
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260226-skb-local-storage-v1-1-4ca44f0dd9d1@cloudflare.com>
References: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
In-Reply-To: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261593-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:mid,cloudflare.com:dkim,cloudflare.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 260311AF999
X-Rspamd-Action: no action

BPF local storage exists for sk, task, cgroup, and inode objects, but not
for sk_buff. Add per-packet local storage so BPF programs can associate
key-value data with individual packets as they traverse the network stack.

Back the storage with a new skb extension (SKB_EXT_BPF_STORAGE) that holds
a bpf_local_storage pointer. The storage is automatically freed when the
sk_buff is released.

Expose the storage through a new map type BPF_MAP_TYPE_SKB_STORAGE (gated
by CONFIG_BPF_SKB_STORAGE) and two kfuncs modeled after existing local
storage helpers:

  - bpf_skb_storage_get() - look up or create local storage for an skb
  - bpf_skb_storage_delete() - delete local storage for an skb

Register the kfuncs for all prog types with access to a trusted pointer to
sk_buff. For LSM progs, reject sleepable programs for now; this requires
further changes to the verifier to pass gfp_flags to kfuncs. Skip
sk_reuseport and flow_dissector, which lack an associated kfunc hook.

Impose the following limitations with intention to lift them later:

1. skb clones can't access storage created by the original skb

Refuse storage access for cloned skbs when the skb extension is shared
between the original and its clones. This avoids corrupting state visible
to other skb owners. In the future, local storage can be copied on clone
when the user requests it with a BPF_F_CLONE map flag.

2. BPF local storage is not copied on skb_ext copy-on-write

On skb_ext COW — triggered when a new extension is activated while skb_ext
has multiple owners — reset the local storage pointer to NULL to avoid
sharing state between the original and the copy for now. In the future, a
copy of BPF local storage can be made as part of the skb_ext COW process.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf_types.h     |   3 +
 include/linux/skbuff.h        |   3 +
 include/net/bpf_skb_storage.h |  21 ++++
 include/uapi/linux/bpf.h      |   1 +
 kernel/bpf/syscall.c          |   1 +
 kernel/bpf/verifier.c         |  38 ++++++
 net/Kconfig                   |  10 ++
 net/core/Makefile             |   1 +
 net/core/bpf_skb_storage.c    | 264 ++++++++++++++++++++++++++++++++++++++++++
 net/core/skbuff.c             |  15 +++
 10 files changed, 357 insertions(+)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index b13de31e163f..8c3038a93b35 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -134,6 +134,9 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_USER_RINGBUF, user_ringbuf_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARENA, arena_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_INSN_ARRAY, insn_array_map_ops)
+#ifdef CONFIG_BPF_SKB_STORAGE
+BPF_MAP_TYPE(BPF_MAP_TYPE_SKB_STORAGE, skb_storage_map_ops)
+#endif
 
 BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
 BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index daa4e4944ce3..5f6d721bc075 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5004,6 +5004,9 @@ enum skb_ext_id {
 #endif
 #if IS_ENABLED(CONFIG_CAN)
 	SKB_EXT_CAN,
+#endif
+#if IS_ENABLED(CONFIG_BPF_SKB_STORAGE)
+	SKB_EXT_BPF_STORAGE,
 #endif
 	SKB_EXT_NUM, /* must be last */
 };
diff --git a/include/net/bpf_skb_storage.h b/include/net/bpf_skb_storage.h
new file mode 100644
index 000000000000..982467f61e7e
--- /dev/null
+++ b/include/net/bpf_skb_storage.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Cloudflare, Inc. */
+
+#ifndef _BPF_SKB_STORAGE_H
+#define _BPF_SKB_STORAGE_H
+
+#ifdef CONFIG_BPF_SKB_STORAGE
+
+#include <linux/compiler_types.h>
+
+struct bpf_local_storage;
+
+struct bpf_skb_storage_ext {
+	struct bpf_local_storage __rcu *storage;
+};
+
+void bpf_skb_storage_free(struct bpf_skb_storage_ext *ext);
+
+#endif /* CONFIG_BPF_SKB_STORAGE */
+
+#endif /* _BPF_SKB_STORAGE_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c8d400b7680a..2b2c22c7992c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1046,6 +1046,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_CGRP_STORAGE,
 	BPF_MAP_TYPE_ARENA,
 	BPF_MAP_TYPE_INSN_ARRAY,
+	BPF_MAP_TYPE_SKB_STORAGE,
 	__MAX_BPF_MAP_TYPE
 };
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index dd89bf809772..e26e24481e19 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1488,6 +1488,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 	case BPF_MAP_TYPE_CPUMAP:
 	case BPF_MAP_TYPE_ARENA:
 	case BPF_MAP_TYPE_INSN_ARRAY:
+	case BPF_MAP_TYPE_SKB_STORAGE:
 		if (!bpf_token_capable(token, CAP_BPF))
 			goto put_token;
 		break;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0162f946032f..113e2eaec4db 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10207,6 +10207,10 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_map_push_elem)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_SKB_STORAGE:
+		if (func_id != BPF_FUNC_kptr_xchg)
+			goto error;
+		break;
 	case BPF_MAP_TYPE_INSN_ARRAY:
 		goto error;
 	default:
@@ -12461,6 +12465,8 @@ enum special_kfunc_type {
 	KF_bpf_session_is_return,
 	KF_bpf_stream_vprintk,
 	KF_bpf_stream_print_stack,
+	KF_bpf_skb_storage_get,
+	KF_bpf_skb_storage_delete,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12541,6 +12547,13 @@ BTF_ID(func, bpf_arena_reserve_pages)
 BTF_ID(func, bpf_session_is_return)
 BTF_ID(func, bpf_stream_vprintk)
 BTF_ID(func, bpf_stream_print_stack)
+#ifdef CONFIG_BPF_SKB_STORAGE
+BTF_ID(func, bpf_skb_storage_get)
+BTF_ID(func, bpf_skb_storage_delete)
+#else
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+#endif
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -13259,6 +13272,22 @@ static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
 	}
 }
 
+static int check_kfunc_map_compatibility(struct bpf_verifier_env *env,
+					 struct bpf_kfunc_call_arg_meta *meta,
+					 struct bpf_map *map)
+{
+	if ((meta->func_id == special_kfunc_list[KF_bpf_skb_storage_get] ||
+	     meta->func_id == special_kfunc_list[KF_bpf_skb_storage_delete]) &&
+	    map->map_type != BPF_MAP_TYPE_SKB_STORAGE)
+		goto error;
+
+	return 0;
+error:
+	verbose(env, "cannot pass map_type %d into func %s#%d\n",
+		map->map_type, meta->func_name, meta->func_id);
+	return -EINVAL;
+}
+
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta,
 			    int insn_idx)
 {
@@ -13418,6 +13447,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			}
 			meta->map.ptr = reg->map_ptr;
 			meta->map.uid = reg->map_uid;
+			ret = check_kfunc_map_compatibility(env, meta, meta->map.ptr);
+			if (ret < 0)
+				return ret;
 			fallthrough;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
@@ -14005,6 +14037,12 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 		 * because packet slices are not refcounted (see
 		 * dynptr_type_refcounted)
 		 */
+	} else if (meta->func_id == special_kfunc_list[KF_bpf_skb_storage_get]) {
+		mark_reg_known_zero(env, regs, BPF_REG_0);
+		regs[BPF_REG_0].type = PTR_TO_MAP_VALUE;
+		regs[BPF_REG_0].map_ptr = meta->map.ptr;
+		regs[BPF_REG_0].map_uid = meta->map.uid;
+		/* PTR_MAYBE_NULL will be added when is_kfunc_ret_null is checked */
 	} else {
 		return 0;
 	}
diff --git a/net/Kconfig b/net/Kconfig
index 62266eaf0e95..68ad0592c134 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -543,4 +543,14 @@ config NET_TEST
 
 	  If unsure, say N.
 
+config BPF_SKB_STORAGE
+	bool "BPF local storage for sk_buff"
+	depends on BPF_SYSCALL
+	select SKB_EXTENSIONS
+	help
+	  Enable an sk_buff extension for BPF local storage. This allows BPF
+	  programs to associate arbitrary data with individual packets as they
+	  traverse the network stack. The storage is automatically freed when
+	  the sk_buff is freed.
+
 endif   # if NET
diff --git a/net/core/Makefile b/net/core/Makefile
index dc17c5a61e9a..32f7335236d0 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -49,3 +49,4 @@ obj-$(CONFIG_NET_TEST) += net_test.o
 obj-$(CONFIG_NET_DEVMEM) += devmem.o
 obj-$(CONFIG_DEBUG_NET) += lock_debug.o
 obj-$(CONFIG_FAIL_SKB_REALLOC) += skb_fault_injection.o
+obj-$(CONFIG_BPF_SKB_STORAGE) += bpf_skb_storage.o
diff --git a/net/core/bpf_skb_storage.c b/net/core/bpf_skb_storage.c
new file mode 100644
index 000000000000..977d5c92c0ff
--- /dev/null
+++ b/net/core/bpf_skb_storage.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Cloudflare, Inc. */
+
+#include <linux/bpf.h>
+#include <linux/bpf_local_storage.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+
+#include <net/bpf_skb_storage.h>
+
+DEFINE_BPF_STORAGE_CACHE(skb_cache);
+
+static int skb_storage_map_alloc_check(union bpf_attr *attr)
+{
+	/* Don't allow BPF_F_CLONE yet. Requires skb_ext copy on clone. */
+	if (attr->map_flags & ~BPF_F_NO_PREALLOC)
+		return -EINVAL;
+
+	return bpf_local_storage_map_alloc_check(attr);
+}
+
+static struct bpf_map *skb_storage_map_alloc(union bpf_attr *attr)
+{
+	return bpf_local_storage_map_alloc(attr, &skb_cache, false);
+}
+
+static void skb_storage_map_free(struct bpf_map *map)
+{
+	bpf_local_storage_map_free(map, &skb_cache);
+}
+
+static struct bpf_local_storage __rcu **skb_storage_ptr(void *owner)
+{
+	struct bpf_skb_storage_ext *ext = owner;
+
+	return &ext->storage;
+}
+
+static int notsupp_get_next_key(struct bpf_map *map, void *key,
+				void *next_key)
+{
+	return -EOPNOTSUPP;
+}
+
+static void *notsupp_lookup_elem(struct bpf_map *map, void *key)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static long notsupp_update_elem(struct bpf_map *map, void *key,
+				void *value, u64 flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static long notsupp_delete_elem(struct bpf_map *map, void *key)
+{
+	return -EOPNOTSUPP;
+}
+
+const struct bpf_map_ops skb_storage_map_ops = {
+	.map_meta_equal = bpf_map_meta_equal,
+	.map_alloc_check = skb_storage_map_alloc_check,
+	.map_alloc = skb_storage_map_alloc,
+	.map_free = skb_storage_map_free,
+	.map_get_next_key = notsupp_get_next_key,
+	.map_lookup_elem = notsupp_lookup_elem,
+	.map_update_elem = notsupp_update_elem,
+	.map_delete_elem = notsupp_delete_elem,
+	.map_check_btf = bpf_local_storage_map_check_btf,
+	.map_mem_usage = bpf_local_storage_map_mem_usage,
+	.map_owner_storage_ptr = skb_storage_ptr,
+	.map_btf_id = &bpf_local_storage_map_btf_id[0],
+};
+
+static struct bpf_local_storage_data *
+skb_storage_lookup(struct sk_buff *skb, struct bpf_map *map, bool cacheit_lockit)
+{
+	struct bpf_local_storage_map *smap = (typeof(smap))map;
+	struct bpf_local_storage *storage;
+	struct bpf_skb_storage_ext *ext;
+
+	ext = skb_ext_find(skb, SKB_EXT_BPF_STORAGE);
+	if (!ext)
+		return NULL;
+
+	storage = rcu_dereference_check(ext->storage, bpf_rcu_lock_held());
+	if (!storage)
+		return NULL;
+
+	return bpf_local_storage_lookup(storage, smap, cacheit_lockit);
+}
+
+void bpf_skb_storage_free(struct bpf_skb_storage_ext *ext)
+{
+	struct bpf_local_storage *storage;
+
+	rcu_read_lock_dont_migrate();
+	storage = rcu_dereference(ext->storage);
+	if (storage)
+		bpf_local_storage_destroy(storage);
+	rcu_read_unlock_migrate();
+}
+
+static bool is_skb_storage_shared(const struct sk_buff *skb)
+{
+	return skb_ext_exist(skb, SKB_EXT_BPF_STORAGE) &&
+	       refcount_read(&skb->extensions->refcnt) != 1;
+}
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_skb_storage_get() - Get or create local storage for an skb
+ * @map: BPF map of type BPF_MAP_TYPE_SKB_STORAGE
+ * @skb: Socket buffer to get storage for
+ * @value: Initial value to set if creating new storage (can be NULL)
+ * @flags: BPF_LOCAL_STORAGE_GET_F_CREATE to create if not exists
+ *
+ * Get the local storage associated with @skb for @map. If @flags contains
+ * BPF_LOCAL_STORAGE_GET_F_CREATE and no storage exists, create new storage
+ * initialized with @value (or zeroed if @value is NULL).
+ *
+ * Return: Pointer to storage value on success, NULL on error
+ */
+__bpf_kfunc void *bpf_skb_storage_get(struct bpf_map *map__map,
+				      struct sk_buff *skb,
+				      void *value__nullable, u32 value__szk,
+				      u64 flags)
+{
+	struct bpf_local_storage_map *map = (typeof(map))map__map;
+	struct bpf_local_storage_data *sdata;
+	struct bpf_skb_storage_ext *ext;
+
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
+
+	if (!skb || flags & ~BPF_LOCAL_STORAGE_GET_F_CREATE)
+		goto fail; /* EINVAL */
+	if (in_hardirq() || in_nmi())
+		goto fail; /* EPERM - requires kmalloc_nolock */
+	if (skb->cloned && is_skb_storage_shared(skb))
+		goto fail; /* EOPNOTSUPP */
+
+	sdata = skb_storage_lookup(skb, map__map, true);
+	if (sdata)
+		return sdata->data;
+	if (!(flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
+		goto fail; /* ENOENT */
+
+	ext = skb_ext_find(skb, SKB_EXT_BPF_STORAGE);
+	if (!ext) {
+		ext = skb_ext_add(skb, SKB_EXT_BPF_STORAGE);
+		if (!ext)
+			goto fail; /* ENOMEM */
+		RCU_INIT_POINTER(ext->storage, NULL);
+	}
+
+	sdata = bpf_local_storage_update(ext, map, value__nullable, BPF_NOEXIST,
+					 false, GFP_ATOMIC);
+	if (IS_ERR(sdata))
+		goto fail;
+
+	return sdata->data;
+fail:
+	return NULL;
+}
+
+/**
+ * bpf_skb_storage_delete() - Delete local storage for an skb
+ * @map: BPF map of type BPF_MAP_TYPE_SKB_STORAGE
+ * @skb: Socket buffer to delete storage from
+ *
+ * Delete the local storage associated with @skb for @map.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+__bpf_kfunc int bpf_skb_storage_delete(struct bpf_map *map__map,
+				       struct sk_buff *skb)
+{
+	struct bpf_local_storage_data *sdata;
+
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
+	if (!skb)
+		return -EINVAL;
+	if (in_hardirq() || in_nmi())
+		return -EPERM;
+	if (skb->cloned && is_skb_storage_shared(skb))
+		return -EOPNOTSUPP;
+
+	sdata = skb_storage_lookup(skb, map__map, false);
+	if (!sdata)
+		return -ENOENT;
+
+	return bpf_selem_unlink(SELEM(sdata));
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(skb_storage_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_skb_storage_get, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_skb_storage_delete)
+BTF_KFUNCS_END(skb_storage_kfunc_ids)
+
+static int skb_storage_tracing_kfunc_filter(const struct bpf_prog *prog,
+					    u32 kfunc_id)
+{
+	/* Disabled until verifier can pass gfp_flags to kfuncs */
+	if (prog->sleepable)
+		return -EACCES;
+	/* Allow only progs with trusted pointers */
+	if (prog->type != BPF_PROG_TYPE_LSM &&
+	    prog->type != BPF_PROG_TYPE_TRACING)
+		return -EACCES;
+	return 0;
+}
+
+static const struct btf_kfunc_id_set skb_storage_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &skb_storage_kfunc_ids,
+};
+
+static const struct btf_kfunc_id_set skb_storage_tracing_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &skb_storage_kfunc_ids,
+	.filter = skb_storage_tracing_kfunc_filter,
+};
+
+static int __init bpf_skb_storage_kfunc_init(void)
+{
+	int ret = 0;
+
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCKET_FILTER,
+					       &skb_storage_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,
+					       &skb_storage_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT,
+					       &skb_storage_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB,
+					       &skb_storage_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS,
+					       &skb_storage_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SK_SKB,
+					       &skb_storage_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_OUT,
+					       &skb_storage_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_IN,
+					       &skb_storage_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_XMIT,
+					       &skb_storage_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL,
+					       &skb_storage_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER,
+					       &skb_storage_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					       &skb_storage_kfunc_set);
+
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
+					       &skb_storage_tracing_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					       &skb_storage_tracing_kfunc_set);
+
+	return ret;
+}
+late_initcall(bpf_skb_storage_kfunc_init);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 699c401a5eae..9d3d680441ad 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -83,6 +83,7 @@
 #include <net/psp/types.h>
 #include <net/dropreason.h>
 #include <net/xdp_sock.h>
+#include <net/bpf_skb_storage.h>
 
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -5143,6 +5144,9 @@ static const u8 skb_ext_type_len[] = {
 #if IS_ENABLED(CONFIG_CAN)
 	[SKB_EXT_CAN] = SKB_EXT_CHUNKSIZEOF(struct can_skb_ext),
 #endif
+#if IS_ENABLED(CONFIG_BPF_SKB_STORAGE)
+	[SKB_EXT_BPF_STORAGE] = SKB_EXT_CHUNKSIZEOF(struct bpf_skb_storage_ext),
+#endif
 };
 
 static __always_inline unsigned int skb_ext_total_length(void)
@@ -7099,6 +7103,13 @@ static struct skb_ext *skb_ext_maybe_cow(struct skb_ext *old,
 		if (flow->key)
 			refcount_inc(&flow->key->refs);
 	}
+#endif
+#ifdef CONFIG_BPF_SKB_STORAGE
+	if (old_active & (1 << SKB_EXT_BPF_STORAGE)) {
+		struct bpf_skb_storage_ext *ext = skb_ext_get_ptr(new, SKB_EXT_BPF_STORAGE);
+
+		RCU_INIT_POINTER(ext->storage, NULL);
+	}
 #endif
 	__skb_ext_put(old);
 	return new;
@@ -7235,6 +7246,10 @@ void __skb_ext_put(struct skb_ext *ext)
 	if (__skb_ext_exist(ext, SKB_EXT_MCTP))
 		skb_ext_put_mctp(skb_ext_get_ptr(ext, SKB_EXT_MCTP));
 #endif
+#ifdef CONFIG_BPF_SKB_STORAGE
+	if (__skb_ext_exist(ext, SKB_EXT_BPF_STORAGE))
+		bpf_skb_storage_free(skb_ext_get_ptr(ext, SKB_EXT_BPF_STORAGE));
+#endif
 
 	kmem_cache_free(skbuff_ext_cache, ext);
 }

-- 
2.43.0


