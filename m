Return-Path: <netdev+bounces-238792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39439C5F7E9
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 23:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D232C4E33D4
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 22:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D857330DD3F;
	Fri, 14 Nov 2025 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGM4ZS8z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F053002C2
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 22:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763158665; cv=none; b=DxEtwgtyQwynON7/Ca6V/vaYDf7LAi3eAfNNviHmcczm4u/Wsfy5u/KxzMAzM2seOQdUnahCUN+S9tOXAVIquDRr3KeQvrkt2mhV0+He995PAVJITUba5ED7Qc+aSBKh5YZE3eDvb1U0ROjxQ/OHQ7fwshcl9xqHw3havTCbmg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763158665; c=relaxed/simple;
	bh=JyjnDFMmsnIqhPDJLu5tPseer9rVq9AUhJ3TigZsnuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELyXllj2zaXsLHXJrYvD8mKa25vW+1pPLyFQ9Sv+YDEEm2Wy1b9w0jas1fl03wb7+rmj+IBh2kMXRfWlDZbT60YEKhA/bRM4xgefB6CuOBkZL5QBZtYvklzhliDEBh5sE/kPXHW9aosdu/cJYhpMmR74XkaopaHusP3F4ruoEkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGM4ZS8z; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3414de5b27eso2069749a91.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 14:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763158664; x=1763763464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LOiAlHINrk8JJxNb7Yln0VGSOKqRrQSGzZ9VD8Yzow=;
        b=IGM4ZS8zDn3h7HYSZL/X4GbTL4vpvjo6KgYFKCrqNwSqmsEJMXL1NjcuAWek8CNOLw
         qvHgsWNmg5XUBcuRRD+8BGN+U5D9vMICfBHhwUkc51I9K+JLFE4WtreUy+8jVd0HuW0U
         08N68ZIF3HMpKghECxD9bXnwG4inozBrqR9aroTB0YMsJR0uyzsWZs/pI7IUGr2PHhAX
         dnwjRV7i2wF7QeMyNK8mC/QrlsBYmn6/oxQXIVU2mBwfP2u5cUmIu/1CrkGUF3jHxFTy
         yKTB2F7ZNOKD0GVXHknLhJLghcXw3VtEeqMdvyvvC2pvnwQn6QrAA/e2MPszQbJM1jpI
         ElyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763158664; x=1763763464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8LOiAlHINrk8JJxNb7Yln0VGSOKqRrQSGzZ9VD8Yzow=;
        b=ng28PMCgGsOlDTZw99BMyn7Pvg4jEJDmEz9Bj1ZsZgiERD/SG+RLzauasQxxAr9Y4W
         ugJkrYZgGNNekdM5vqm4qxJrgYsk0dGWLPbrA5u4k3xXnDjD+CppJhzgq5LTmFK1yCAr
         s922OmeEl3wO8xiah3ZN5bwYoijSXVvoYhWF87wmHdlqQiy4SkeCBYtn4U4bq2pBq/rm
         ANdQGhhg80Bu2mBPmVw8BAzYn5Hy2h5Jv5/m1kDyMtL9N+cwe++VrusKmS+tzL4nMJ9p
         pJqdZx3kXh2u6VRY+HdPBDRltLoQXCFcR1flPzWtvoRfmOVzvYRcsyymuU0wbJA7bz02
         tdjA==
X-Gm-Message-State: AOJu0YxILAjq30CULpJBpZ4DFPG09FhA/jCuNQP8Qx71i6jovCY5Ah+V
	+8LF/xLse91Al+jLtGA1LKZN7e+nabdlRXmQKBG541ZestcL9JRBgI9r
X-Gm-Gg: ASbGncsdt7OjSdHktprbQUZtFeDwrjkHipWSlIM5AXHcmL+u2kL4WBOElNf3fPadMur
	qMokfoiUOqKCqRVJ1PF+viCd5YYIUZCliZLUhHdKmXdMjIe+EUY+33RnQ6DyoLqpcRvsguchAzl
	SkTnas33Wv20y0W74/IkPJ5O8koQWR/PpynStQWwUoJXix+xP65KyOHHXdnkqVg4QwC2t135gaP
	y13DXB1rsslTh6RMbJDl9rGA4irx+vDOiyQyfw1vOzwJMxSitVfCtIMqPr8lkny1nWVMZt/A46D
	WHfM9xWMkYDR4umHN1Na/UwJGGwtDblPqM37Xfqnrtw/cL9M05Q1d5864k4lDUGUyUs496UOT1U
	OApq/FyJxLkFT7TQoBcWrAIVwEiW6onmfR03HH1FIYLN94buSkbveX6VuSBy36xp6uGLr1gdzWP
	AqCss=
X-Google-Smtp-Source: AGHT+IFCg5HAtwGyVHU7YtInKyFTo7QoleFMRcjCvaQ2JmwihLAuqnhB8QsC9upj7rDGVJLnNrGIog==
X-Received: by 2002:a17:90b:2ccc:b0:340:ba29:d3b6 with SMTP id 98e67ed59e1d1-343f9e92724mr5152992a91.6.1763158663584;
        Fri, 14 Nov 2025 14:17:43 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343eacc2669sm2782166a91.12.2025.11.14.14.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 14:17:43 -0800 (PST)
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
Subject: [PATCH bpf-next v6 1/6] bpf: Allow verifier to fixup kernel module kfuncs
Date: Fri, 14 Nov 2025 14:17:36 -0800
Message-ID: <20251114221741.317631-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114221741.317631-1-ameryhung@gmail.com>
References: <20251114221741.317631-1-ameryhung@gmail.com>
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


