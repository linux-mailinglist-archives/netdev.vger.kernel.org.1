Return-Path: <netdev+bounces-151913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB0B9F19F3
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 00:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE7C188D981
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 23:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FCB1F03E9;
	Fri, 13 Dec 2024 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DTxE4J5r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E1D1DA60F
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132605; cv=none; b=W2saDJbjas4R6xhmWtLImCvQsimWwFLLbT+20s0WTgmuw1hlsbSI50JXD4KpOl/B2lM/ysQ8twzjhjuOHvaAsrfnIWZeIZW0dcFDOXHm6ERu+WDNZxDHMB8gBJ9arF8w+8wG2iJoeIT60rxn0HYifUGf/5hv3hJaxpBTUbttcmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132605; c=relaxed/simple;
	bh=Eyr46HBdMzcezTSaJc8Q8hesaHfa7v2OqrjhG9rizno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FY20uIQiq+NCb82S5x5M+hFFhY+EE0Z++LIIS460ME8sq1siKomIZMQjCt+hqfHafsCLEspuAfzSy3085nPQ7dDpFFNt/MJWcc907KuctbRkcAj6u5f5TYX+2LTYCgw/DptJ9cYf3UrLnuJTMQn76dZtQ2MBFsDFCvhm3JepB14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DTxE4J5r; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b7041273ddso36135285a.3
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 15:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734132601; x=1734737401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dz258LP6R5huynohPazHs2P5gkDWlbu66HknCOxo5I0=;
        b=DTxE4J5rBlipiMkr5sXeppmgBRUrWvF1Qmrp77V4NSOImviXsKydQaGm4EnigZm5Iy
         PxMBnrXzNkPikeYJqQ2bt3z8oQI2ex5xQmnRyxg3O2nofvAmcunFLfABg/g0gyNdN3Oz
         5SvKs5xfpeQ4LdgwIGh5r02SXroS9SWTpTUhSludv8PoH9+5wPnou1BY4oE4fKq4RlfZ
         F/4IciUheTMNyOiwQ+73QsUOHnFOzX4ILCqI4agCLpaprNSNMRRtrdvLVR+U5F3AkBS+
         c+m/sC+yY7NhyqqZxw5F5xb0nHyNYEMjrbK3Qkkc/0eT8AdUpzIUUDVuSh3tQ2jWhgiI
         r3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132601; x=1734737401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dz258LP6R5huynohPazHs2P5gkDWlbu66HknCOxo5I0=;
        b=JlPrGAJjcM6JHn6SddfyqpyK5EZaCXAI6itQ6TISi5PxQby9xDFsi5zXx5xF3pLYLm
         j3uJagVXNQOjMSsBci/JEosL9Z5scrN/BZZJxkAI7vwmy8OrZt6iMtM5P1ZDJq0fGqEK
         l2NazmjIRyk4+F66JrvKsLHGcKIsIrfnBQEUa5IuZPAT12YjXDRzuw81ovHztB+/gFQZ
         /ehZPecGrcOWtGyVvrSGIplqyPm9GU4B0NlJBDdnLf455Ka0CAHnMPWQWjLACuvNWQG1
         xxyOwbmoKDYjtR5UmMiSTrZVPm9nmcg6AXv8K/cVDC979/hAmAwpzdL1D8xoyXy/tHRw
         HEJA==
X-Gm-Message-State: AOJu0YyfblEgd8yl46lqI+gk3O5XAILmZmhj6dDi5bViUWBfwvmspH51
	mnJ/OnIb8X2oCfTqnScCeRSAD+uUd5XrCDpn5pGSV7liVkW6gAMSXHcRK1/sJJXKUNC7ze5Roq5
	wGP8ePg==
X-Gm-Gg: ASbGncvecAqwGu+0MK5Lrs0Jw7TCcJ58e2fpq923fmc0k5TB1sumpsA/jjnveiEF/8w
	WFBDLLIPAt9BKNIPk1UOf7Oekrjj89A2IUQiObQYfOgn8nZ6QeTIE80XFio4gCsJvlMA1zn7aBp
	KyT2JvV4eQ+NnPOl9GhT8f9KKyL19LVmi0DDfG3un9x6umNAdKighRI/Lu7WMPMQgUjFUeDCLWS
	JWEPK1jllkNUSxoxFDNTmy7Ub31shZzrxCx/mvRPbkRdHun5eni+lDsHdTSnlKuQim4dQT3hYNx
X-Google-Smtp-Source: AGHT+IGHSOZJiCUGotd3t52TlgCH8yY/uNGAugWIBn/Ii2l2ji3HsybQt/7gX1aV1KemSoPeANAr5w==
X-Received: by 2002:a05:620a:199a:b0:7b6:d089:2757 with SMTP id af79cd13be357-7b6fbf2207bmr632473285a.35.1734132601070;
        Fri, 13 Dec 2024 15:30:01 -0800 (PST)
Received: from n36-183-057.byted.org ([130.44.215.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047d4a20sm25805085a.39.2024.12.13.15.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:30:00 -0800 (PST)
From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [PATCH bpf-next v1 01/13] bpf: Support getting referenced kptr from struct_ops argument
Date: Fri, 13 Dec 2024 23:29:46 +0000
Message-Id: <20241213232958.2388301-2-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241213232958.2388301-1-amery.hung@bytedance.com>
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows struct_ops programs to acqurie referenced kptrs from arguments
by directly reading the argument.

The verifier will acquire a reference for struct_ops a argument tagged
with "__ref" in the stub function in the beginning of the main program.
The user will be able to access the referenced kptr directly by reading
the context as long as it has not been released by the program.

This new mechanism to acquire referenced kptr (compared to the existing
"kfunc with KF_ACQUIRE") is introduced for ergonomic and semantic reasons.
In the first use case, Qdisc_ops, an skb is passed to .enqueue in the
first argument. This mechanism provides a natural way for users to get a
referenced kptr in the .enqueue struct_ops programs and makes sure that a
qdisc will always enqueue or drop the skb.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/linux/bpf.h         |  3 +++
 kernel/bpf/bpf_struct_ops.c | 26 ++++++++++++++++++++------
 kernel/bpf/btf.c            |  1 +
 kernel/bpf/verifier.c       | 35 ++++++++++++++++++++++++++++++++---
 4 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1b84613b10ac..72bf941d1daf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -968,6 +968,7 @@ struct bpf_insn_access_aux {
 		struct {
 			struct btf *btf;
 			u32 btf_id;
+			u32 ref_obj_id;
 		};
 	};
 	struct bpf_verifier_log *log; /* for verbose logs */
@@ -1480,6 +1481,8 @@ struct bpf_ctx_arg_aux {
 	enum bpf_reg_type reg_type;
 	struct btf *btf;
 	u32 btf_id;
+	u32 ref_obj_id;
+	bool refcounted;
 };
 
 struct btf_mod_pair {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index fda3dd2ee984..6e7795744f6a 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -145,6 +145,7 @@ void bpf_struct_ops_image_free(void *image)
 }
 
 #define MAYBE_NULL_SUFFIX "__nullable"
+#define REFCOUNTED_SUFFIX "__ref"
 #define MAX_STUB_NAME 128
 
 /* Return the type info of a stub function, if it exists.
@@ -206,9 +207,11 @@ static int prepare_arg_info(struct btf *btf,
 			    struct bpf_struct_ops_arg_info *arg_info)
 {
 	const struct btf_type *stub_func_proto, *pointed_type;
+	bool is_nullable = false, is_refcounted = false;
 	const struct btf_param *stub_args, *args;
 	struct bpf_ctx_arg_aux *info, *info_buf;
 	u32 nargs, arg_no, info_cnt = 0;
+	const char *suffix;
 	u32 arg_btf_id;
 	int offset;
 
@@ -240,12 +243,19 @@ static int prepare_arg_info(struct btf *btf,
 	info = info_buf;
 	for (arg_no = 0; arg_no < nargs; arg_no++) {
 		/* Skip arguments that is not suffixed with
-		 * "__nullable".
+		 * "__nullable or __ref".
 		 */
-		if (!btf_param_match_suffix(btf, &stub_args[arg_no],
-					    MAYBE_NULL_SUFFIX))
+		is_nullable = btf_param_match_suffix(btf, &stub_args[arg_no],
+						     MAYBE_NULL_SUFFIX);
+		is_refcounted = btf_param_match_suffix(btf, &stub_args[arg_no],
+						       REFCOUNTED_SUFFIX);
+		if (!is_nullable && !is_refcounted)
 			continue;
 
+		if (is_nullable)
+			suffix = MAYBE_NULL_SUFFIX;
+		else if (is_refcounted)
+			suffix = REFCOUNTED_SUFFIX;
 		/* Should be a pointer to struct */
 		pointed_type = btf_type_resolve_ptr(btf,
 						    args[arg_no].type,
@@ -253,7 +263,7 @@ static int prepare_arg_info(struct btf *btf,
 		if (!pointed_type ||
 		    !btf_type_is_struct(pointed_type)) {
 			pr_warn("stub function %s__%s has %s tagging to an unsupported type\n",
-				st_ops_name, member_name, MAYBE_NULL_SUFFIX);
+				st_ops_name, member_name, suffix);
 			goto err_out;
 		}
 
@@ -271,11 +281,15 @@ static int prepare_arg_info(struct btf *btf,
 		}
 
 		/* Fill the information of the new argument */
-		info->reg_type =
-			PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
 		info->btf_id = arg_btf_id;
 		info->btf = btf;
 		info->offset = offset;
+		if (is_nullable) {
+			info->reg_type = PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
+		} else if (is_refcounted) {
+			info->reg_type = PTR_TRUSTED | PTR_TO_BTF_ID;
+			info->refcounted = true;
+		}
 
 		info++;
 		info_cnt++;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e7a59e6462a9..a05ccf9ee032 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6580,6 +6580,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			info->reg_type = ctx_arg_info->reg_type;
 			info->btf = ctx_arg_info->btf ? : btf_vmlinux;
 			info->btf_id = ctx_arg_info->btf_id;
+			info->ref_obj_id = ctx_arg_info->ref_obj_id;
 			return true;
 		}
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9f5de8d4fbd0..69753096075f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1402,6 +1402,17 @@ static int release_reference_state(struct bpf_func_state *state, int ptr_id)
 	return -EINVAL;
 }
 
+static bool find_reference_state(struct bpf_func_state *state, int ptr_id)
+{
+	int i;
+
+	for (i = 0; i < state->acquired_refs; i++)
+		if (state->refs[i].id == ptr_id)
+			return true;
+
+	return false;
+}
+
 static int release_lock_state(struct bpf_func_state *state, int type, int id, void *ptr)
 {
 	int i, last_idx;
@@ -5798,7 +5809,8 @@ static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
 /* check access to 'struct bpf_context' fields.  Supports fixed offsets only */
 static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off, int size,
 			    enum bpf_access_type t, enum bpf_reg_type *reg_type,
-			    struct btf **btf, u32 *btf_id, bool *is_retval, bool is_ldsx)
+			    struct btf **btf, u32 *btf_id, bool *is_retval, bool is_ldsx,
+			    u32 *ref_obj_id)
 {
 	struct bpf_insn_access_aux info = {
 		.reg_type = *reg_type,
@@ -5820,8 +5832,16 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
 		*is_retval = info.is_retval;
 
 		if (base_type(*reg_type) == PTR_TO_BTF_ID) {
+			if (info.ref_obj_id &&
+			    !find_reference_state(cur_func(env), info.ref_obj_id)) {
+				verbose(env, "invalid bpf_context access off=%d. Reference may already be released\n",
+					off);
+				return -EACCES;
+			}
+
 			*btf = info.btf;
 			*btf_id = info.btf_id;
+			*ref_obj_id = info.ref_obj_id;
 		} else {
 			env->insn_aux_data[insn_idx].ctx_field_size = info.ctx_field_size;
 		}
@@ -7135,7 +7155,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		struct bpf_retval_range range;
 		enum bpf_reg_type reg_type = SCALAR_VALUE;
 		struct btf *btf = NULL;
-		u32 btf_id = 0;
+		u32 btf_id = 0, ref_obj_id = 0;
 
 		if (t == BPF_WRITE && value_regno >= 0 &&
 		    is_pointer_value(env, value_regno)) {
@@ -7148,7 +7168,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return err;
 
 		err = check_ctx_access(env, insn_idx, off, size, t, &reg_type, &btf,
-				       &btf_id, &is_retval, is_ldsx);
+				       &btf_id, &is_retval, is_ldsx, &ref_obj_id);
 		if (err)
 			verbose_linfo(env, insn_idx, "; ");
 		if (!err && t == BPF_READ && value_regno >= 0) {
@@ -7179,6 +7199,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 				if (base_type(reg_type) == PTR_TO_BTF_ID) {
 					regs[value_regno].btf = btf;
 					regs[value_regno].btf_id = btf_id;
+					regs[value_regno].ref_obj_id = ref_obj_id;
 				}
 			}
 			regs[value_regno].type = reg_type;
@@ -21662,6 +21683,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
+	struct bpf_ctx_arg_aux *ctx_arg_info;
 	struct bpf_verifier_state *state;
 	struct bpf_reg_state *regs;
 	int ret, i;
@@ -21769,6 +21791,13 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 		mark_reg_known_zero(env, regs, BPF_REG_1);
 	}
 
+	if (!subprog && env->prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
+		ctx_arg_info = (struct bpf_ctx_arg_aux *)env->prog->aux->ctx_arg_info;
+		for (i = 0; i < env->prog->aux->ctx_arg_info_size; i++)
+			if (ctx_arg_info[i].refcounted)
+				ctx_arg_info[i].ref_obj_id = acquire_reference_state(env, 0);
+	}
+
 	ret = do_check(env);
 out:
 	/* check for NULL is necessary, since cur_state can be freed inside
-- 
2.20.1


