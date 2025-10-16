Return-Path: <netdev+bounces-230217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28C6BE56B7
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430CF19A430D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 20:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CACB2E1C6B;
	Thu, 16 Oct 2025 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3XRKXAZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE8E2DFA4A
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647507; cv=none; b=n3NOT2z1MGd676xwrJU7MfFez3AY4x+jgb4i4TkrT4jMcwSvKmqHhTd52sDciVqcNBCRmN6wbSeLIdURBRn+0KDY8zWAklmT6S/BkXNZRWvKabaTjEan9i4Ikgdf2kqUNJbop0FxUfqOD/jf2dmvyEl2Z8YmimOG9heBD5pWZ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647507; c=relaxed/simple;
	bh=n0G0Z+92IypGH3eawej6SXwPonZZG9VIFFNWrEFNd3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUg4jxIqL4HM4Vc+gA3BznwMDjsVhQiEWbplJ06b1gFZ2/Ki2JNIyoHrY87LxrvaZXBKJepZa9icQnt499RKWklZC5jk7xJDWwa50GcFyS46pAvI5cFBPH05ZxZcCWcmfZm8cAmNmSIeDr7n2vrbcbij+XkJNwdTc6/NOkz1QB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3XRKXAZ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b62fcddfa21so768301a12.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 13:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760647505; x=1761252305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSNp2i4w9S/UuwRxxUx4tJy96Wj8Kx1e17mXUe1U+I4=;
        b=A3XRKXAZeKgPZpAueUJbCAXwT2S6XppdypJq3YhCVvc7Ul2lThdRG1cLOO0N+0WHwi
         Zr4Q7i44OqNCd/JhnmFGVXY6a7OV6eGt4r4ChudnT+u+fCGFrJ6LkluadOmP5eCUdWR/
         CmFWKL6x+X3uBaNoIxyO3iWYMuTeraDigUuDdh4sWn+TwTXU0SPkp9Qa3IeO7NJD12XG
         LVRfgDdN0r8KJg42NNjEIS3tQl8TjNp3jJe1ov/MA3uqI9UxVsYRuP+hgTQR/U775nAf
         X2o/8qQcTlxZoNna4yWHcaWr8Xn4d4luHirtNsV2hQZyxDbTZ/V9d5hhThsDVgYBq4Nz
         9Kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647505; x=1761252305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSNp2i4w9S/UuwRxxUx4tJy96Wj8Kx1e17mXUe1U+I4=;
        b=SiBS9bYhO/4t0thUOJNjZD7HZyBsdo6fQm2P/m2TLQHIPoZBlWYVbj9NBophOzslMn
         LW7pFnzEJ+JWVMrISDUlSu6ZcOeOBfEps6931tnk4ZAYhkyXCnPcAZrE9ioh5BXCqq4J
         DTf4EL8K/L+Ao3y72H+WZP87c9AS+LI/yKDUXDyn4W8UYtGviOagZm357QA3CLxjlTKj
         ZWjHLejNYAHC2OdOIJxTTSO08QcFzpFVN6BfGCzXsb9HWhlF3xYuECva4heNxUGovPQD
         XtvVDNdU9D9z/KDDkHa4gQJ6q6sVZ+bAZbfeRs34B9E+rQbOZE+F9vRYGRH9sNm/NKkQ
         RSow==
X-Gm-Message-State: AOJu0YyWcBGh5636vVOMIv8T/RKBcMf+hptH9hosfNRt/Qy1kn2iiiaK
	6a7NnUFKzl/vF9tVZRcEKgeEm4wXlb/n0jam65pMdK2iSJxIhlMyJpfj
X-Gm-Gg: ASbGncvbKZ4FBM6AfcQC6MCPua0ou2HdPDUSY1z/dTwSNPthFVGpM1HOtYZcyDaEmm0
	erBdmAQr+/2M5Tx8xkYrFzXuLme3sF0eZ0qm4i3CnsD4gkMlYHYA6JsaZPaUpkIuqS81fhJ/IEM
	1/C/ZBiPpwJ0AduQv3dydfOPaToVtKUig1HINjH8LJ28meaSh626expon5zEmEVI2awyGj0sGLM
	zZKRX7JeEZ2fvLRvq1ELWBMq6W1VJkUSB8yzbJAy5CdFQEZ9SEXM4Poclm0kHS48RYDDBId7awR
	eHxdrH4FEyGzpmNXiWy+UIWRLIt/kB/2jmDadWzLsYTeiLvLs4Eod7vQhsALHzrewtURy+yxDdA
	aGSGqi1B2n4Y/hdkWNQUupHleXtAXwjosQHlGZxj7FQViVezjI4jp6gobh2q+yQMoksD1HfzVCZ
	HK
X-Google-Smtp-Source: AGHT+IE/AxwkJr7Yw4JDO+nAZLryGRcQcpE097UQDZ4SiG2Ufm1bdxcpiwVj3JcSQVDlqWo4IL2PUQ==
X-Received: by 2002:a17:902:ce12:b0:24c:7b94:2f53 with SMTP id d9443c01a7336-290c9c8a765mr13586675ad.6.1760647504838;
        Thu, 16 Oct 2025 13:45:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ab4788sm39887745ad.92.2025.10.16.13.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:45:04 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 1/4] bpf: Allow verifier to fixup kernel module kfuncs
Date: Thu, 16 Oct 2025 13:45:00 -0700
Message-ID: <20251016204503.3203690-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016204503.3203690-1-ameryhung@gmail.com>
References: <20251016204503.3203690-1-ameryhung@gmail.com>
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
index e892df386eed..d5f1046d08b7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21889,8 +21889,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
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


