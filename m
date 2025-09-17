Return-Path: <netdev+bounces-224204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C55B82361
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 00:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E733B2901
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 22:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D309E311C3F;
	Wed, 17 Sep 2025 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DItdIes6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3733C31159A
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 22:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149719; cv=none; b=alfB6B/3AHZoT0r0AvbpQEPUBymCzaZmr0O9qkQ+Jz7DJE+qKmuwovjn2fdSELiI1TNHlGMvTz5h0SrajGoEhuii/ZJSv+ESWTb9Orco8PWDsY7/mMcJgT13qBE44Q+IgZxhV2fI9Z81+08R6FdShmgKaS+MiTReapbvgtPXzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149719; c=relaxed/simple;
	bh=pcXardvoZJ5x13AoTWxdTEydJ2BB1/tUU6LaU849Aws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esznkd3NdPXSaY9jwYp/EX7nwg505m0eydBLIi3uiub8NEozj0ZB9JbotYQcfUWL6leggNkO2PnFQ6fnlalh1AgbBC87vW9w7E4LeK43NzkQPtvUznoWyihKE9GlE21XjxoQbMVvdESu7Tfxl256donpODtpw4Zi7Z4PeBaheO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DItdIes6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7761b392d50so486755b3a.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758149717; x=1758754517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/eWmQdzp2gJMKzDrupQRH1sPNWHwWwHav7oa7B7Mo0=;
        b=DItdIes6yb2LEXKS4T6o14J47XkhH7sHd2L/cf9P+mL72f1mcpqVNlLUfA6VK4uG5q
         Z1b2bLQF+BSA3GwazBUyDup3Oj93Z3mFWaUESsJeTQQR7JyqghCtCL1mVZ0ROz75xzF9
         frdOLemMLb5FqCHACWEzxQZpn4BIBBCd9IJIo6KzMvwJrNSH8WlXHZ9xp3M+1gDBa1yd
         l2YVH9KDXOEgIHO/R3VIQpPXGa6rHZRey67ARc9ade8WfoI9dNBIIhPdhxHe2I8Y6Yf6
         fdbYC6Ns4Byih+kKcZI4d0e2/KHGX3S05xUb+/LZ6gi6SEU5j1jXTGQyc+M5kDszEfc9
         RVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758149717; x=1758754517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/eWmQdzp2gJMKzDrupQRH1sPNWHwWwHav7oa7B7Mo0=;
        b=O2ikF851chnkjV9t3GQeMsHHDOuqDR9ek1PbgYlzH/TzIt2lSLyX94Id3Z76MtuVms
         1vf18Lco8gCRtwrOx787ZZ6bZECFF4uQLtVQhJXmX0S2aCqEeoFZzkII65xUqzCyMUe0
         Wf5awOvY5DvCWYRC1ByiJ5/otMI9K0Xqd3exN342Z1dQDXGWxTedfLILDtoURb4TQctm
         0cGT6Y6VByflsSbYoqsuXTNlIL0OCUUG9HeR0IYikL2a5AoJjPq50MCKPqFAelNjCwqO
         WCZIwxmceg0Se5EJwAHyYaqxQ51E3clxKe04Lpbe6iXicI/eqxQE6pMZurHhatu42HQU
         HNMg==
X-Gm-Message-State: AOJu0Yz1Gsbye2pvDhzTyQlaBStM/+RBjU+atH/OEfZIlUPwlYik9XZt
	EqFTcp+rTWisOI7vRfbayJHNHF4x08s/C9Crn6OnQKmppisWRZ4abFUge4k1LA==
X-Gm-Gg: ASbGnctDZECgWNa4zQgxOYkunBKwokPUuvBAL79uFX9S6dTvYpCXrRPX0LOdWmy6Ir5
	DzwWlMyxNBjcEG3Ly93TH7ZqcgCE6N01i43IeDrDyUoN4y88p6/Q/RXXFNbuGdLsk5g/3Lj8lEW
	+RYLBl0VtvSo9BFYS2rrUanIdWf6WGbbCpISAJ0Hj4PLTusNr3PeRqGxigNkOPIn4dUpnsDbpwe
	cUjv6sg0nTXHbYJRpWGnipi6lEDXkR0gum8iGN6QwRp8VlHPAgEDVtAEd6ZGvFfRp0H2mP+GPW7
	nVQlV/99WoJu1WOCnDmyi74kY2wf/JxzkJUQisdZW+krsFtKuHyOANLJERy/dMOJo2vfhQlnYCr
	rQUU9E5j9aXHKihwBBzycxXwgcQ02spc+ML2tRzbtpHY=
X-Google-Smtp-Source: AGHT+IGf4dMR+5wRnSzr9VNnkG+v2fzxz7wCOoftR/K3LFxTrmZBg/cv+EnRZcOkZ8GZjcX+SnyzVw==
X-Received: by 2002:a05:6a20:3d05:b0:251:1b8c:565c with SMTP id adf61e73a8af0-27aaf1ce7admr5424585637.31.1758149717492;
        Wed, 17 Sep 2025 15:55:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:59::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cff22bdb5sm443892b3a.94.2025.09.17.15.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:55:16 -0700 (PDT)
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
Date: Wed, 17 Sep 2025 15:55:10 -0700
Message-ID: <20250917225513.3388199-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250917225513.3388199-1-ameryhung@gmail.com>
References: <20250917225513.3388199-1-ameryhung@gmail.com>
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


