Return-Path: <netdev+bounces-224836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E6BB8ADE4
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22ECF163237
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 18:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57D8265292;
	Fri, 19 Sep 2025 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHwbsVlW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F85225C6FF
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305372; cv=none; b=PvTTdBgxhr/rmp6Dfuo/DvkU9ng0XRmU7pXd3EhJMPIJ90wcVS8tsu19r9s3dG7sgn5G6+LgJ2PoHu29/3AYY6pid1jIjUyKcAqXvepT5lg9jUTakTwtni+6gGSCGCPPBcOqPMyYb0US7RhPrg6Q/H1CoNLkkFvro8AG+E6pm3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305372; c=relaxed/simple;
	bh=pcXardvoZJ5x13AoTWxdTEydJ2BB1/tUU6LaU849Aws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOZLTcfiLLPx97VmcyruiMxaKJSPjwLtlKV8dVls/B3BjAc7QK1dq2EqQMo1p6oA5C2sO3Wm4lUHbvNSSmOR5//zfsLeKZIdX4kcp1MMQ/Iecp7ai8W/qEhnMjcudEVzJvIlGXhYi/DVkKMXysqqfS17ohxgbiuLz8JGXw3p3aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHwbsVlW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2570bf605b1so32513815ad.2
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 11:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758305370; x=1758910170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/eWmQdzp2gJMKzDrupQRH1sPNWHwWwHav7oa7B7Mo0=;
        b=nHwbsVlWerJpSvm2HIObQdxAPnglA1nv+bHEtfmM3GZcT2xM2RebGHGpc9SDyy9AhR
         ySaxrv+8pQxf/XmmkhLBEkjb906aPRLmaahGBP24MwLilA2exLzp1+5rQN5yvgVWXpmk
         GEWNMqDB7yMzSlvmexPwlOgPAhY86qGIoX9qyHYpp4KfAuG277ocB7qQKDfjfaM6N7Wa
         e2ZO8vydlyvucgXat2x0qmygPPB+O8P4KHS7QkqT+tc33VpS/Qp8fkQeG16uVdIcQorT
         OY/yRjaR4luYJkw/hKPWEETZ6hPv7Wx9oFYlaZ2ruSFQ1o4kgMKrDXR3X2Wdby71urSF
         qd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305370; x=1758910170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/eWmQdzp2gJMKzDrupQRH1sPNWHwWwHav7oa7B7Mo0=;
        b=cA4A4z4TalHHZYCLJSjLx9LsT+uCpx/C+3alCmDPtE0uv1Pt0XIjx5NI7YwWIuHG77
         ON0+8YrzeTn3NY2DSkTp9LDx2pzNfp2eyPl0V/3bQU49NCdDAYYnEpSeNbpbcHNEE5Mk
         NKWjQFITauyNWSodePi8qHvDskJrmmKC5BnCt6QNKiX+TJ4VEmEC9G2/k1UczMpeJ0AZ
         WdzN68uvX+R/DVeFNXQgH0YwKBgnnaRyEpib7Hcugt+FvItqlWxnJg08bjGrvyNkxmzo
         x0sYzNv1850z3ZVmrok27P6slygStpWtHFWh9LIVv/DHmFagmgq3epTDshQgQelly30D
         4xLw==
X-Gm-Message-State: AOJu0YwNzkfCFqQsemTqmEoF8FgATVBQF2QXwR0z7wlSeyblemMPzw6j
	xUN66Udea8j0iR2a/fTFN+/lC/kSOs9tYKLK/ZcBgL9OJKb8TZg0qbBp
X-Gm-Gg: ASbGncsJByZdTGUA71IRmzAre4rDkX96qEVbZH90RzW4miRs7P7DBv4Wzn3/42gjvBI
	xpqgl66q7I7IlqQqkmnwJ+bUYbfqyG3t5/g/XYSrBV86VeCER3kDvVP3gRaosME5iToMC1bpLQn
	H+jrLsPMDZXIY7l44OHRa//HKJHMRJQMPH2Qqk6q/3ABOqpRyEncMNppbCnGmlEgxt+r7OXaq70
	Q5SNackhSvWjzxwIt8SDUuzA9TjI4Vu0DZO1TKvyUWNM6iG/NQeHX/oGWWGse75/gMsChW9oeEj
	rdKjpi9qX8v/AdD7wfO1aeJfb1bmeKpOmqXBFEFbHlCjrDMzU17913JqfnrLR18c9N9y63TsNE7
	FjVmZcmn7Zp6L
X-Google-Smtp-Source: AGHT+IFA7/GHo0B3XgdZ40R3eCi1RIrkIlkQAPq1FBhgfmXRTNGxydxZ02dZcF0j8+tadtcg24tGaw==
X-Received: by 2002:a17:903:144e:b0:260:b4c7:986d with SMTP id d9443c01a7336-269ba513a36mr57420105ad.36.1758305370641;
        Fri, 19 Sep 2025 11:09:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033a3e5sm61410115ad.126.2025.09.19.11.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:09:30 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	paul.chaignon@gmail.com,
	kuba@kernel.org,
	stfomichev@gmail.com,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 3/6] bpf: Clear packet pointers after changing packet data in kfuncs
Date: Fri, 19 Sep 2025 11:09:23 -0700
Message-ID: <20250919180926.1760403-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919180926.1760403-1-ameryhung@gmail.com>
References: <20250919180926.1760403-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_xdp_pull_data() may change packet data and therefore packet pointers
need to be invalidated. Add bpf_xdp_pull_data() to the special kfunc
list instead of introducing a new KF_ flag until there are more kfuncs
changing packet data.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1029380f84db..ed493d1dd2e3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12239,6 +12239,7 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_from_skb,
 	KF_bpf_dynptr_from_xdp,
 	KF_bpf_dynptr_from_skb_meta,
+	KF_bpf_xdp_pull_data,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
 	KF_bpf_dynptr_clone,
@@ -12289,10 +12290,12 @@ BTF_ID(func, bpf_rbtree_right)
 BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_from_skb_meta)
+BTF_ID(func, bpf_xdp_pull_data)
 #else
 BTF_ID_UNUSED
 BTF_ID_UNUSED
 BTF_ID_UNUSED
+BTF_ID_UNUSED
 #endif
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
@@ -12362,6 +12365,11 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->func_id == special_kfunc_list[KF_bpf_preempt_enable];
 }
 
+static bool is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data];
+}
+
 static enum kfunc_ptr_arg_type
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		       struct bpf_kfunc_call_arg_meta *meta,
@@ -14081,6 +14089,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (is_kfunc_pkt_changing(&meta))
+		clear_all_pkt_pointers(env);
+
 	nargs = btf_type_vlen(meta.func_proto);
 	args = (const struct btf_param *)(meta.func_proto + 1);
 	for (i = 0; i < nargs; i++) {
@@ -17802,6 +17813,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && is_kfunc_sleepable(&meta))
 				mark_subprog_might_sleep(env, t);
+			if (ret == 0 && is_kfunc_pkt_changing(&meta))
+				mark_subprog_changes_pkt_data(env, t);
 		}
 		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
 
-- 
2.47.3


