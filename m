Return-Path: <netdev+bounces-240902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A227DC7BEDB
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 00:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8276A4E466D
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 23:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700E830C36F;
	Fri, 21 Nov 2025 23:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mks9SMAQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8419992C
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763766837; cv=none; b=tDVDqHm5F2LZxLammGB/yKeHsG3rPRKGK6Ea3vPoVAv06R8xOSczmNAqSkMToZMqSHO10PxQXrUu6eDLLzznrbZ4bJiz2w2u8YGYP2SDU/CkLiDr10nR4EfpriZSM1vfL5IFPNqlegqtP95UeTD85TyXRrgxtD6cs1dJ+Kmkke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763766837; c=relaxed/simple;
	bh=3K9lZnGtBbwYbmS44CtDcA/7fs0LZXm+KLqcdeuXBCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rds3j3Wqr2TfXdJiC4K6o15yc3AH541XHssQV3/1RaJnfqsb3vdvpi+i9Vb3aCbZ0fdEJu4dUHTLaXzckaOvSvyOEMsyP2FWunN5BebAANe+zcPG32NYez4JkJQS1esTB/jJ1cCaycBqzaua8o3NslEC+m+uSH/Pn09cMITRyaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mks9SMAQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2955623e6faso30666155ad.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 15:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763766835; x=1764371635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bN4Qf7h07dcgNnjHgXwbtwldBcXrzrsN7+YsR7Gnqco=;
        b=Mks9SMAQhOtTmP+PfZmNV6rjICePX4rjUFsMyzE/BMV6m8efwOwdZgzoxhgb6AU7On
         /bOMJlTtPY0dXlvLqRNv+1JG/SvJCjmU8QdeWPOq6BqsP/yyax+MgFkT+7pU1QbsDIzD
         Epjzs2oHiIBcYH0gpbJu3FvMEnceZTvMAncQXTHvUZ3WBtOVEtenavNrbUNVX4NAAh7c
         cuAkBHWrc0GcYp83ozq0uL8rmL1eZDS7nAmzTSklvCK3YaVj9mVciSSBy7yOV0q6Rq8T
         wQwy5ysXhz0dKndHRLRAUQ6wEzd2uhZQaA7mz0ffoUdRMkdEyvF52uqe0AeX9pdkeebv
         q/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763766835; x=1764371635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bN4Qf7h07dcgNnjHgXwbtwldBcXrzrsN7+YsR7Gnqco=;
        b=i1r1ng+hCsGaS79V+BwpUGwzukfyblznU8BSgNJNqwhoveW9zFb1Yfad4hKbwDdQjm
         lZYexutTIb7WSbQAtfD3Y8O0yMBq4PQu6quT86ncRznGlKWQwOUolEafrvwxKPPb6ZzY
         Fyg7iS3ca3tbiiplBnPobOUErNRrCbwl+y6gFG7g527RKyYekOhOVhKrf6DmcLdcXcQw
         vvIU7BBWdKdcXCqJ8SvhFC2fMwNJnLU9tpopfb2z6IWngjS34QfF/vqt41D7DDkCt7Ot
         mckTRuMqEWBmpZNAhPshhuuMl+86ZHcQ/KNFFUd3j8abPo+bw+anlMv3SL52wyaO/+/S
         7hGw==
X-Gm-Message-State: AOJu0Yw28kpcF8dTxE9cYv/m8bRruj0YEDDP3yUV9TeWOu/6scRw6XsP
	Y+l/k/U9LpYvopnKKlLza1Nkk/DxyViIDg4t8mg98wxxOyGL7nibRiL1
X-Gm-Gg: ASbGncv7W3LAGeCJ8mbP0dPFIoJavqZKDkIRZf+x7KKfkTPoJM21BEGp1/lLEVaPDhj
	RlH3sPEVBBUwkt/zC6ZTbqb1a8I+K2YVpCs07pt0Dwz1l2IPW1VLB84iJFR7EhyT7oWbVCUtNaX
	PZWv1DHGLneq+VvlpnXrp+1sT/ORUL0OZbnMA8M9fn1weGP9PqmUq/hXY4pqOiNxulHopxR1/7M
	52YhvDkGj9Nm+SzmIbWBCvDhtdxMm4OEUN5S2pQ8JJtPDf1XqiQvhxhX8iGxcbimSVf36QTIVBt
	+0nbv+xJW7X4jODOW8cQDXahusL2i848iGqR2gn8Gk2iV25/udYjmBR+CreNidSEDsqzS9We4zP
	LEBv5nWPY72XxD6yPGWEUDn7qnbrA91fcL5EY/KJ0vdoXkgz1IBYBLRq+r8PgPK2BLhVHdUMTiF
	xfLHJQZZT5M54zMA==
X-Google-Smtp-Source: AGHT+IHj1USi+MCp8ZTjdHNGsbyMsMiMctV4Pwx+mdkpjC0tdeHrrjUjbTvrYC6el6QCnM8KvHCmEA==
X-Received: by 2002:a17:903:187:b0:295:557e:746d with SMTP id d9443c01a7336-29b6bf9b406mr57756165ad.57.1763766835002;
        Fri, 21 Nov 2025 15:13:55 -0800 (PST)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2bb7c1sm66833475ad.99.2025.11.21.15.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 15:13:54 -0800 (PST)
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
Subject: [PATCH bpf-next v7 1/6] bpf: Allow verifier to fixup kernel module kfuncs
Date: Fri, 21 Nov 2025 15:13:47 -0800
Message-ID: <20251121231352.4032020-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121231352.4032020-1-ameryhung@gmail.com>
References: <20251121231352.4032020-1-ameryhung@gmail.com>
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
index 098dd7f21c89..182d63b075af 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22432,8 +22432,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
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


