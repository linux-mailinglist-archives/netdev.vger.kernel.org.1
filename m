Return-Path: <netdev+bounces-232941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 00850C09FED
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 22:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F76734C5DD
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A43E3090CB;
	Sat, 25 Oct 2025 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyBS+m3+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA4E1E633C;
	Sat, 25 Oct 2025 20:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761425621; cv=none; b=XXGZ/Hv7irlRke9FE3LSidg+mBraoU8t8ft55w6EKIKu5HzvyOBN8De/dOJYLLhd6Bq90W8FEaIsL2URtvc6UjN/V7ih98iPW40T/eFCaG932xSmaDV1jPfP62soXi9LmuCxWb/Hw1GgKFj5KvfKoEK/k/XapfhRF3c44rZSUuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761425621; c=relaxed/simple;
	bh=k3f56oOKXrHPQQfnFbh//sCNF5j+f6kxvvopfboCJxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YZakyUPdcMfnGIqwFLmXzuMdejw2CV7DItWOjdY7psEy1Fx+7uH5ko9qxgb2IeYj02r9aAMKcE8wFZVHR/DqK9Spr5Lz6CEtM5dLG2PkLEde/Xt3JBj5Mp0hk1akFs/bxdQ+kXz3qjB5QmSYpjpqzN5BgkTkS20EwqMgpfceCC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyBS+m3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677E7C113D0;
	Sat, 25 Oct 2025 20:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761425621;
	bh=k3f56oOKXrHPQQfnFbh//sCNF5j+f6kxvvopfboCJxQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gyBS+m3+QuJhhVlVHOUu0JiISZ/k5A2IXJFsl4NJpggJCKVvIjEa5DDaYcuanepEl
	 ZX8qFwgLj5h05w3VNQIwz095yPKdIr0J5hR9EYXxYcccTZgWrEYO5mBRVxL5xjP1SO
	 e1vM74f58O9uKTNpKGok29peiZRWauNITxgfFEv4bGO5LjmYkZjTGFSsRpyvTVywkm
	 o8XZXwwutNJLzUUdXK8JQMrWlxwFwbJAgv7rVCE7Bd97fyfmilTCi84cM/+WbrgSaD
	 NJiBenCNc79SH8VjATqKJUrXw9UEcHG5CxPFvfdcSjyz6Mpkkqd3DNIoEe58TCEw0a
	 IWJ/jpi1hdY8Q==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 25 Oct 2025 21:53:18 +0100
Subject: [PATCH 1/3] compiler_types: Introduce __nocfi_generic
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251025-idpf-fix-arm-kcfi-build-error-v1-1-ec57221153ae@kernel.org>
References: <20251025-idpf-fix-arm-kcfi-build-error-v1-0-ec57221153ae@kernel.org>
In-Reply-To: <20251025-idpf-fix-arm-kcfi-build-error-v1-0-ec57221153ae@kernel.org>
To: Kees Cook <kees@kernel.org>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2120; i=nathan@kernel.org;
 h=from:subject:message-id; bh=k3f56oOKXrHPQQfnFbh//sCNF5j+f6kxvvopfboCJxQ=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBl/Lc5InyyKcb3JcHTHf8mWDxptnkqzlkza4fp4wuf3C
 y70+sbs7ShlYRDjYpAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQATEYxgZLhgKXhcWan09CFZ
 rfM/z319Pnl1bPAMkYg83hl63neLNTIZ/lmsZ9aZkmEVs8JC9pVNn9NCf3O+vncMWzprc9f/3ea
 0iwsA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

There are two different ways that LLVM can expand kCFI operand bundles
in LLVM IR: generically in the middle end or using an architecture
specific sequence when lowering LLVM IR to machine code in the backend.
The generic pass allows any architecture to take advantage of kCFI but
the expansion of these bundles in the middle end can mess with
optimizations that may turn indirect calls into direct calls when the
call target is known at compile time, such as after inlining.

Add __nocfi_generic, dependent on an architecture selecting
CONFIG_ARCH_USES_CFI_GENERIC_LLVM_PASS, to disable kCFI bundle
generation in functions where only the generic kCFI pass may cause
problems.

Link: https://github.com/ClangBuiltLinux/linux/issues/2124
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/Kconfig                   | 7 +++++++
 include/linux/compiler_types.h | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 74ff01133532..61130b88964b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -917,6 +917,13 @@ config ARCH_USES_CFI_TRAPS
 	  An architecture should select this option if it requires the
 	  .kcfi_traps section for KCFI trap handling.
 
+config ARCH_USES_CFI_GENERIC_LLVM_PASS
+	bool
+	help
+	  An architecture should select this option if it uses the generic
+	  KCFIPass in LLVM to expand kCFI bundles instead of architecture-specific
+	  lowering.
+
 config CFI
 	bool "Use Kernel Control Flow Integrity (kCFI)"
 	default CFI_CLANG
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 59288a2c1ad2..1414be493738 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -461,6 +461,12 @@ struct ftrace_likely_data {
 # define __nocfi
 #endif
 
+#if defined(CONFIG_ARCH_USES_CFI_GENERIC_LLVM_PASS)
+# define __nocfi_generic	__nocfi
+#else
+# define __nocfi_generic
+#endif
+
 /*
  * Any place that could be marked with the "alloc_size" attribute is also
  * a place to be marked with the "malloc" attribute, except those that may

-- 
2.51.1


