Return-Path: <netdev+bounces-225427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C13B9397D
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC501881A56
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D10B313525;
	Mon, 22 Sep 2025 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZTuck9J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA84302CD9
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 23:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584045; cv=none; b=mT9K6euvDvWbr9XX9U45gZqSe/G4LXQRZ8BnAjiQPG4RC+IfSRvXTvQPl2yc+XNo2pxVsX3LJDZEVUDzyH6z+elaPAjokqgx/BktUpCRUNL2ioRiiYyXjGjBdegAlAP9Hm5kLO2/5KuHUfXjGcWs2sgMwvSq9nguet8AnsmVFX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584045; c=relaxed/simple;
	bh=pcXardvoZJ5x13AoTWxdTEydJ2BB1/tUU6LaU849Aws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lE0VlzFfrcR+XR901lz52KZWFqyEEdDboQG37vxC4mrqKCi5n4rVtqTkBah9X1oyuW5JcO0Psm6SgN1g9onjVrvWBe+9899kWaJEPrea5i5Wd/5QzPq0nmxYOYOLgxDOFrFKO2tyrufhjKAygl9Rx+cbybpkXnTEKOb50DKKN1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZTuck9J; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b554bb615dcso1088094a12.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 16:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758584041; x=1759188841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/eWmQdzp2gJMKzDrupQRH1sPNWHwWwHav7oa7B7Mo0=;
        b=fZTuck9JYxfnDpvsdRrfFnRV/l+dS9wWhiwQM77gIk6PNwvORpQbMIttZZHZiAMJ/V
         HbFuw+rQheYrC1rSGr1aJfq7UT6q88MhIqsHbvpnrMIfTBYOttUnZiJ2ZZjJc0ndNHSr
         xi6mIoPIINgnCYtfqlW4Qy/j/O8HcQOmIfED/iJm6yPolvdmjI0Iq3szYJU/juT14Te/
         BWDI6Wjlndgn7Fi0SmWvAzJfnygBe66POGXmKG5iTRNzul41nsp2hF7NEkfJ1u7wRSQS
         ROSKk5ZAiGrqF5e+OXOgEShXdbcwqFobVMUvkAwybO4CukspR1z2ndRs7jKi6tFhhPhJ
         r1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758584041; x=1759188841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/eWmQdzp2gJMKzDrupQRH1sPNWHwWwHav7oa7B7Mo0=;
        b=KFJ1/0KMsrHfbnqeUOb5cVC2tKM++ya5ezwyKg/xQalRBkEATCncIQgRI898HeTzKG
         3rFLJ7M9PloUDso9S9n6KNf8oQxHsB03s7suOmnRxUkomFeFLjRcdxqQ+Z9to9I/yCyU
         kcvOnvHMkqEeeZmhNOjV57xvsmgGMhvNi96NfSqXHiE1/X68AcGKGZ/jvuEa0Pm4qRE9
         2Zv8OoaEjhxbTcmp7JyN2laxJPvMLUPxuVSQptdKEebM5rQ9FKKultq7n5IVbKuacr2o
         m1eY+ZZ+klVCCdbWu7AB6M0Uwc9c9xYTUWjAeLlQMl2M9eUsZh4LL3BzZQiztWdloIwA
         TqSA==
X-Gm-Message-State: AOJu0YwjgfWRR+WgIKg23qdhQbzzSFsrcFbwxY/wLYTQIsEWE+y2G95N
	DIwqsINDUyPlE7wztI4GAl6s5Jy83LzDxVwjarb05t9gvmtH4EOEa/zX
X-Gm-Gg: ASbGncsP3/5622G+g0FP/tlo7Vux9Mep/Klljst3W3gYKPsEot8ZudkNyEQnbRPiDhM
	z5MiEQhlVB1vVobogi1zvFj2nnBGd+YjsBCNfVuDlRA5KKpCz1I30qRL1YuVQKCEMwcfRjOYmy6
	B2HJ7g5pMW9AdGyLZWAFeTNkGFvAYv5vOEhdLAXsOdrQr5iL8YRfdLBySA99axD9Zr0Yak6JyJ5
	i4+IcJvK2Vi5D1lZDqLyudR2GpTurBfeIM+dZaRrR/gek47bDuNe6++LOGAsT2/h/0UPpWChrG1
	YRYSG3N27IGZbLMZEUksBO6MrhrPtdeR+aXK5hTCcaPCflLnZuh3QBwuflfaeh64YkkI14jlruA
	THEzBC/Pzdurh7A==
X-Google-Smtp-Source: AGHT+IGMgWxTyAXVvYscvf1YREnlymrgicsb3AN4eO0mPe40J4mqN2kUnJI2B5QDkfVA7FTgjf6Hww==
X-Received: by 2002:a17:903:244b:b0:25c:46cd:1dc1 with SMTP id d9443c01a7336-27cc54310b8mr7103295ad.33.1758584041612;
        Mon, 22 Sep 2025 16:34:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033ff66sm141045415ad.133.2025.09.22.16.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:34:01 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 4/8] bpf: Clear packet pointers after changing packet data in kfuncs
Date: Mon, 22 Sep 2025 16:33:52 -0700
Message-ID: <20250922233356.3356453-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922233356.3356453-1-ameryhung@gmail.com>
References: <20250922233356.3356453-1-ameryhung@gmail.com>
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


