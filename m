Return-Path: <netdev+bounces-62572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132B3827E3C
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 06:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D241C2363A
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 05:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6BB6132;
	Tue,  9 Jan 2024 05:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mw7A7GJk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60172D61C
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 05:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-595aa5b1fe0so1736478eaf.2
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 21:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704777045; x=1705381845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGRfQUiM/fdf5MTqUfvRqPOsMdxX5ZwLkxAWRV+5GSE=;
        b=Mw7A7GJknlBqwJEgztFBFg/D89cdyOAlTvk0x5QbqnciweOoEbIqQFg7V20tksR+Kg
         HcHIS66tzdU3tDP4riDGr/U0UnveDqHWFQrOS3J+RmcP5a4Wm3ZO6ZxWLL5HTKT7OqtE
         9QOAiUvjiEFIA7vTs2uHGyf1MDHJvHDnWbxgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704777045; x=1705381845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGRfQUiM/fdf5MTqUfvRqPOsMdxX5ZwLkxAWRV+5GSE=;
        b=gkQi9jcG5DJw5g51lsL7u3DfqKYzFCeaKW9vZlCoiQkE/hbMyQw8XHGkZLRfvSJuXp
         0s4l50/pIZcIMZefewHGDWvCDI919zrn4Ry7saK06gtK9hfIcU/6F8kUv4QstvRz3tte
         Yctwgaog5Nxz1rpplonNmjogmMFd+N0czQN3u9CCI3UvPvbhGF3QeLyxqP4AG4WhpmmY
         l+eITxKp5E9kjrH6ETQfierevN1ZAp3f/n8/h1bRW6nGd91yNLAwHb566BqkG7+Hu1XG
         EKyA/WKUaEiuWYzTxogx+qGtCTEZYnb/9il5U0omtMOr7NBc07CI2yuyo05kA++l7FCv
         MvwA==
X-Gm-Message-State: AOJu0YzCFLyoa03TMPX98NQrIJ+FY908w1796+WHsrSFSvK6j/pB1c7h
	KhVkBqgyBBphuIDwL690mqgIaTrQyHcm
X-Google-Smtp-Source: AGHT+IGJP05Xi+0QqvovPu2XVmdCYQG37hRBcV8sePn3U2VZlQTiEyJSAwNa82EL1lw2e/hyb+52sg==
X-Received: by 2002:a05:6358:2910:b0:175:4d29:ac23 with SMTP id y16-20020a056358291000b001754d29ac23mr5422653rwb.26.1704777044782;
        Mon, 08 Jan 2024 21:10:44 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090ac88c00b0028aecd6b29fsm7344115pjt.3.2024.01.08.21.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 21:10:44 -0800 (PST)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
X-Google-Original-From: Alexey Makhalov <amakhalov@vmware.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com,
	namit@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	jsipek@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com
Subject: [PATCH v5 7/7] x86/vmware: Add TDX hypercall support
Date: Mon,  8 Jan 2024 21:10:17 -0800
Message-Id: <20240109051017.58167-8-amakhalov@vmware.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240109051017.58167-1-amakhalov@vmware.com>
References: <20240109051017.58167-1-amakhalov@vmware.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMware hypercalls use I/O port, VMCALL or VMMCALL instructions.
Add __tdx_hypercall path to support TDX guests.

No change in high bandwidth hypercalls, as only low bandwidth
ones are supported for TDX guests.

Co-developed-by: Tim Merrifield <timothym@vmware.com>
Signed-off-by: Tim Merrifield <timothym@vmware.com>
Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/vmware.h | 79 +++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/vmware.c  | 25 +++++++++++
 2 files changed, 104 insertions(+)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 84a31f579a30..3bd593c6591d 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -18,6 +18,12 @@
  * arg2 - Hypercall command
  * arg3 bits [15:0] - Port number, LB and direction flags
  *
+ * - Low bandwidth TDX hypercalls (x86_64 only) are similar to LB
+ * hypercalls. They also have up to 6 input and 6 output on registers
+ * arguments, with different argument to register mapping:
+ * %r12 (arg0), %rbx (arg1), %r13 (arg2), %rdx (arg3),
+ * %rsi (arg4), %rdi (arg5).
+ *
  * - High bandwidth (HB) hypercalls are I/O port based only. They have
  * up to 7 input and 7 output arguments passed and returned using
  * registers: %eax (arg0), %ebx (arg1), %ecx (arg2), %edx (arg3),
@@ -54,12 +60,61 @@
 #define VMWARE_CMD_GETHZ		45
 #define VMWARE_CMD_GETVCPU_INFO		68
 #define VMWARE_CMD_STEALCLOCK		91
+/*
+ * Hypercall command mask:
+ *   bits [6:0] command, range [0, 127]
+ *   bits [19:16] sub-command, range [0, 15]
+ */
+#define VMWARE_CMD_MASK			0xf007fU
 
 #define CPUID_VMWARE_FEATURES_ECX_VMMCALL	BIT(0)
 #define CPUID_VMWARE_FEATURES_ECX_VMCALL	BIT(1)
 
 extern u8 vmware_hypercall_mode;
 
+#define VMWARE_TDX_VENDOR_LEAF 0x1af7e4909ULL
+#define VMWARE_TDX_HCALL_FUNC  1
+
+extern unsigned long vmware_tdx_hypercall(unsigned long cmd,
+					  struct tdx_module_args *args);
+
+/*
+ * TDCALL[TDG.VP.VMCALL] uses %rax (arg0) and %rcx (arg2). Therefore,
+ * we remap those registers to %r12 and %r13, respectively.
+ */
+static inline
+unsigned long vmware_tdx_hypercall_args(unsigned long cmd, unsigned long in1,
+					unsigned long in3, unsigned long in4,
+					unsigned long in5,
+					uint32_t *out1, uint32_t *out2,
+					uint32_t *out3, uint32_t *out4,
+					uint32_t *out5)
+{
+	unsigned long ret;
+
+	struct tdx_module_args args = {
+		.rbx = in1,
+		.rdx = in3,
+		.rsi = in4,
+		.rdi = in5,
+	};
+
+	ret = vmware_tdx_hypercall(cmd, &args);
+
+	if (out1)
+		*out1 = args.rbx;
+	if (out2)
+		*out2 = args.r13;
+	if (out3)
+		*out3 = args.rdx;
+	if (out4)
+		*out4 = args.rsi;
+	if (out5)
+		*out5 = args.rdi;
+
+	return ret;
+}
+
 /*
  * The low bandwidth call. The low word of %edx is presumed to have OUT bit
  * set. The high word of %edx may contain input data from the caller.
@@ -87,6 +142,10 @@ unsigned long vmware_hypercall1(unsigned long cmd, unsigned long in1)
 {
 	unsigned long out0;
 
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return vmware_tdx_hypercall_args(cmd, in1, 0, 0, 0,
+						 NULL, NULL, NULL, NULL, NULL);
+
 	asm_inline volatile (VMWARE_HYPERCALL
 		: "=a" (out0)
 		: [port] "i" (VMWARE_HYPERVISOR_PORT),
@@ -105,6 +164,10 @@ unsigned long vmware_hypercall3(unsigned long cmd, unsigned long in1,
 {
 	unsigned long out0;
 
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return vmware_tdx_hypercall_args(cmd, in1, 0, 0, 0,
+						 out1, out2, NULL, NULL, NULL);
+
 	asm_inline volatile (VMWARE_HYPERCALL
 		: "=a" (out0), "=b" (*out1), "=c" (*out2)
 		: [port] "i" (VMWARE_HYPERVISOR_PORT),
@@ -124,6 +187,10 @@ unsigned long vmware_hypercall4(unsigned long cmd, unsigned long in1,
 {
 	unsigned long out0;
 
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return vmware_tdx_hypercall_args(cmd, in1, 0, 0, 0,
+						 out1, out2, out3, NULL, NULL);
+
 	asm_inline volatile (VMWARE_HYPERCALL
 		: "=a" (out0), "=b" (*out1), "=c" (*out2), "=d" (*out3)
 		: [port] "i" (VMWARE_HYPERVISOR_PORT),
@@ -143,6 +210,10 @@ unsigned long vmware_hypercall5(unsigned long cmd, unsigned long in1,
 {
 	unsigned long out0;
 
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return vmware_tdx_hypercall_args(cmd, in1, in3, in4, in5,
+						 NULL, out2, NULL, NULL, NULL);
+
 	asm_inline volatile (VMWARE_HYPERCALL
 		: "=a" (out0), "=c" (*out2)
 		: [port] "i" (VMWARE_HYPERVISOR_PORT),
@@ -165,6 +236,10 @@ unsigned long vmware_hypercall6(unsigned long cmd, unsigned long in1,
 {
 	unsigned long out0;
 
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return vmware_tdx_hypercall_args(cmd, in1, in3, 0, 0,
+						 NULL, out2, out3, out4, out5);
+
 	asm_inline volatile (VMWARE_HYPERCALL
 		: "=a" (out0), "=c" (*out2), "=d" (*out3), "=S" (*out4),
 		  "=D" (*out5)
@@ -186,6 +261,10 @@ unsigned long vmware_hypercall7(unsigned long cmd, unsigned long in1,
 {
 	unsigned long out0;
 
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return vmware_tdx_hypercall_args(cmd, in1, in3, in4, in5,
+						 out1, out2, out3, NULL, NULL);
+
 	asm_inline volatile (VMWARE_HYPERCALL
 		: "=a" (out0), "=b" (*out1), "=c" (*out2), "=d" (*out3)
 		: [port] "i" (VMWARE_HYPERVISOR_PORT),
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 3aa1adaed18f..84caa67d4820 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -428,6 +428,31 @@ static bool __init vmware_legacy_x2apic_available(void)
 		(eax & BIT(VCPU_LEGACY_X2APIC));
 }
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+unsigned long vmware_tdx_hypercall(unsigned long cmd,
+				   struct tdx_module_args *args)
+{
+	if (!hypervisor_is_type(X86_HYPER_VMWARE))
+		return ULONG_MAX;
+
+	if (cmd & ~VMWARE_CMD_MASK) {
+		pr_warn_once("Out of range command %lx\n", cmd);
+		return ULONG_MAX;
+	}
+
+	args->r10 = VMWARE_TDX_VENDOR_LEAF;
+	args->r11 = VMWARE_TDX_HCALL_FUNC;
+	args->r12 = VMWARE_HYPERVISOR_MAGIC;
+	args->r13 = cmd;
+	args->r15 = 0; /* CPL */
+
+	__tdx_hypercall(args);
+
+	return args->r12;
+}
+EXPORT_SYMBOL_GPL(vmware_tdx_hypercall);
+#endif
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 static void vmware_sev_es_hcall_prepare(struct ghcb *ghcb,
 					struct pt_regs *regs)
-- 
2.39.0


