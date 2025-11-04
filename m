Return-Path: <netdev+bounces-235549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D45CC32541
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57853A6406
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242513385A7;
	Tue,  4 Nov 2025 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVnleedB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916E515530C
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277219; cv=none; b=eufMQGM5tjfYdSv7O2HEVBULU8i1ewS1FuM6DvTMpyoNGikK5S0Rj0QeBW52EZtuqqcAH7ffkAZDj9/JVPCE+TAjcEWyRXwUydoXTrB9kfHnpLJe2jjgoJ44KZKjRA93rIb4cGGY5vcVkR3721iJLsqtj3UvEoKkhYsuxv03ThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277219; c=relaxed/simple;
	bh=JyjnDFMmsnIqhPDJLu5tPseer9rVq9AUhJ3TigZsnuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unVWtpakxlCmub53bsUNtJcmMhk4989T9zlKYZnRVsJNp8fDLqR3bFPDUqFZz32tI3MRCaRmBe7mJRNw1zMNe1cT9ertN59vJMji6j3WK6YLxteWMlx3DD5CUrMyylidnCW7ZLbMbvw42bcCPDleobEtlwihYDPF6VvJZkG9EUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVnleedB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78125ed4052so7543908b3a.0
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 09:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762277217; x=1762882017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LOiAlHINrk8JJxNb7Yln0VGSOKqRrQSGzZ9VD8Yzow=;
        b=RVnleedB5SV7144M7mO9K7Ze78UsapBzFWmyvp0WK0obbS2VUI0vu3TD8guNhWqLB7
         xd3Gt7NhnChyXy2T3GjMlXSzNdUR0Gafltisb6P6kBzAb2o244vRj3dOQkVDLPX2mnHz
         bNKJHQNjXI/dKbQgHods2A5EnNCGNy7bA07eGky+hb1F3OgSvwpncXjAGxTxHiAlFDvX
         LIsOlLbvCE30HVtsOInA1KZ0v0kaJGCD5JRXBZq1/oLzdDWvk+ThNphwTNnB7y6Bky0d
         NQPiaOw2MHGg0orXpha6R4nqRRzud/3zBRia/y2JW0AdmSkCu19xtCfOZbv2J+aW53Ty
         rLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762277217; x=1762882017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LOiAlHINrk8JJxNb7Yln0VGSOKqRrQSGzZ9VD8Yzow=;
        b=LPBBVor4EiNx4vmXnrJEzAEiYbNJ+jU/t48ra+4z+pykYLChp0eFSXytEkesu92kOT
         ma1UW1ZucIfm9yBgpG93RW779SK335A2XOK8188kcE2F78YVr1RN91NZpEqg3sgRXDBn
         2Cr193b4N0AfFbBT+VZNQu/zK8yy8PFklx6QKLlClzZb2JGYsEY/UNscLycIWn4SviFn
         IPN+eQ7GBlrCVOcjL4/FpvcMVBNdP8K8jh4/Y2M7cSHH50zmOxW2CQJ+oVqJ26FPeEBj
         rnSfhFH7jskQgmUjqchxQ8jSqK6ldbTChS27GqSwlToTULpx3uztSug5bDWwQ9aWr22J
         TsXw==
X-Gm-Message-State: AOJu0YwQPsLn/SPvMFhC0sI2chmZ+JfaEcymeY/pksh3UTBz3KkB1tXD
	1BcH6rlgAU/VhwFTxoQhU38hHaUadr0wu9LKZvaAB/PHKFcPe1LesvUU
X-Gm-Gg: ASbGnct8lmsYMozx9zy7l6bIVnzbGSkTLYquhVv8Wjpph56bNEzsqwMKeasJIzS7OSu
	nj4+qrfwH/Yaj1wt+x0CzMVvzkRfkteunbK04zy6LBX95uZ8nCHUS3UxtaO43N8amB/yhZPCgTM
	9odnj/19h5M3K899hqZPjvMHK7tanly6DrKP/oXEGCFrJslRvn+N0/9UrXkaBbMgi2/Xu76NEt6
	bzouQj9tyZimhyzEXW+hbfyvuNG3mmEzQMk3IeWoTYPfR7F1/9S5ohiIIXeX8cQOOeBbHs1IUdF
	1BfhvdqF2i1QfCKnki05DXRgx5XtI58BgIjKsKNIM2pom47a7nU2BX51fLOuB9wOas9JXjXKLNQ
	M0QC6hDiNAGc8h5i2tF0gsxMEqt4kaYxeug1ug61cWGJjloWqNUMEmQXMHV7Y6tm2yWE=
X-Google-Smtp-Source: AGHT+IFL+hq4i/iNP5+rHpigkDApecoiJMbAcz1Yl4KByj7ek+H0NGAvo6RugGFz/Api0zLB5KdNRg==
X-Received: by 2002:a05:6a20:a126:b0:342:20f9:98b1 with SMTP id adf61e73a8af0-34f84113f07mr118747637.21.1762277216641;
        Tue, 04 Nov 2025 09:26:56 -0800 (PST)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd5774c21sm3579055b3a.43.2025.11.04.09.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:26:56 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 1/7] bpf: Allow verifier to fixup kernel module kfuncs
Date: Tue,  4 Nov 2025 09:26:46 -0800
Message-ID: <20251104172652.1746988-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104172652.1746988-1-ameryhung@gmail.com>
References: <20251104172652.1746988-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow verifier to fixup kfuncs in kernel module to support kfuncs with
__prog arguments. Currently, special kfuncs and kfuncs with __prog
arguments are kernel kfuncs. Allowing kernel module kfuncs should not
affect existing kfunc fixup as kernel module kfuncs have BTF IDs greater
than kernel kfuncs' BTF IDs.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 542e23fb19c7..8f4410eee3b6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21973,8 +21973,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (!bpf_jit_supports_far_kfunc_call())
 		insn->imm = BPF_CALL_IMM(desc->addr);
-	if (insn->off)
-		return 0;
+
 	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
 	    desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
 		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
-- 
2.47.3


