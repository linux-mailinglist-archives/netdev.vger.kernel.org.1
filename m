Return-Path: <netdev+bounces-224846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FBDB8AE59
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF2B1673E4
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 18:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE90274B5C;
	Fri, 19 Sep 2025 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9s2aAoZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1260F26FDA8
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306067; cv=none; b=LsXVcRSxYVfMyMbD6tuETllTdszA+BQex2MzFbvYW4Rv5m0cKXRzMNvYYT9zffPsEoghysKyldp+o5LQepIMWRNr6pWSnWtRU375YVZP/oK7fiLVvSNsloz+HLxNk3+qygiOKUBJQZ/jBpdCgms2M+mMjbHT3s9waouwFfK3OYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306067; c=relaxed/simple;
	bh=pcXardvoZJ5x13AoTWxdTEydJ2BB1/tUU6LaU849Aws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIrQxeS3xHnQvcUHtX9hhAMWbTT+/r9mxbUX0RmgtFfE5ubPEc3B89X5RCC7hADBvCdeYhPNFHwPm/WNKPEA7uNVXrjuENB1j/P54zaXEfB6E39oKfU+dcnpOUHK1gu7QpmGNwAhUPU5tDF1Jj6E8UWR7MScAV+clLZsLur6+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9s2aAoZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2445826fd9dso29212865ad.3
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 11:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758306065; x=1758910865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/eWmQdzp2gJMKzDrupQRH1sPNWHwWwHav7oa7B7Mo0=;
        b=R9s2aAoZz6B+BOExwbGJMmFELjT6kD2PNlcnCl0Wg/Smvhpxr/P4j+Id3PnuZoxVmS
         qNqldnz8tPb+4iNo4OcSEjGIpcnPWLKrKDHz3duKpulSjgeI4/hUZuvLw71tp14rngKR
         dD2dxDWl3fbw7QqomFHqd+OdyoPckIpnStKHMrxeEJ2WdG5onFHrihTnFEotG/r17Tlb
         PMCzWv7/XOSXkbeNZjDiMh4D76ka0FMa3iKM07XE0iOXH5QjQ+5xWJkymK8RUx3fZ6K7
         d3+HtMqm/MQTZBGlNkVd+BzSrtItwLKnR01JKw05qVjBjotKJuYzjXX7Gy/XEvisDEoq
         Q59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306065; x=1758910865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/eWmQdzp2gJMKzDrupQRH1sPNWHwWwHav7oa7B7Mo0=;
        b=GuT+myWFtQ4uN31SzkE8i7TYPVr4P0RusgTxh0hzO6o0i2y8mQA0URu3MYAR9vu1DX
         X0omPvPnPeQMfOb1NKFEDagggcni95x4sIXIIRzHjUPxCFJPidbYaQA1MaMTOL14tWkM
         boy3scKR3D9F95J88NCPVaYLQBBJTIyAjoKU0/Vn68/VegyzDbJiUrTnZ7PaEKj7hsxc
         hXzTo4poOlWDqrnE+sgtpyqZU4RZzDNojlXWPlqy79v3wIBD16OsJs5Eh65KJIrGImRC
         XFWu53Lwejk5NtvH1dmbmsUsbmetnWfsCQsnUf+v6CUCKPCbOwPyBTgEM8x3OHBlFwyS
         wCmg==
X-Gm-Message-State: AOJu0YzgjVMzANG9YGqvXrPkSnEpAA9mgGGv+Ik3DCaIpx2fA+b6EwbA
	JcQFt4+4CeBTFPDYIAL3xUbTYTpuTwGcSHByvtLenxKnnP6pUSBbZ9I5
X-Gm-Gg: ASbGncuw2yFEn2eDVpMZ/9j1iZg1N48umcaPK+/TGVqXi/Ti/CXeT1C2NoCe5tuz/RN
	jvFZ5M2byaudLRi5hey6QYs3l2nvdYbcsFQu+qqFHZHOUCInu8EUDlFrE+PCjsSuqIldqf+3XHL
	jCVZX72L9MTGsuJqbxa1fg9qsfcuCsYOhwOaNfZJF/8taDYtKUy6R0F/jq0CbvgM7TfTBJVauuq
	XZG/WLFw04CSdsrmh3X1yAc0pZK1kd/YvTHgviKGJAAAUU6EKNLSew/W/4UudM1CASYHUe3omfX
	aLa7a1EKAbOFFubdO0SxuOZfY20D2NjpPV8Xt9ICC2pSTH4eXTc1j+dEzdOylXhw9+24MKsJBKD
	O2bEJ5ItNoqK/B1SXsWje1wPM
X-Google-Smtp-Source: AGHT+IGDEzHNxeaNCMMOqaV/NOXp99+BMlsQ+gQrtm2EDuoL9mYQ/K3r8LxHsw1L6fb258WNS8+OFA==
X-Received: by 2002:a17:902:fc46:b0:24c:92b5:2175 with SMTP id d9443c01a7336-269ba480055mr61965685ad.24.1758306065464;
        Fri, 19 Sep 2025 11:21:05 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:53::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698034168csm59864235ad.135.2025.09.19.11.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:21:05 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 4/7] bpf: Clear packet pointers after changing packet data in kfuncs
Date: Fri, 19 Sep 2025 11:20:57 -0700
Message-ID: <20250919182100.1925352-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919182100.1925352-1-ameryhung@gmail.com>
References: <20250919182100.1925352-1-ameryhung@gmail.com>
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


