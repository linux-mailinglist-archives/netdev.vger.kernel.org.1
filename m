Return-Path: <netdev+bounces-97881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EF68CDA92
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 21:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7D3283561
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 19:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB59A83CB7;
	Thu, 23 May 2024 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H+DzWDjW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC783A12
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491712; cv=none; b=IOmsV/A69xxWArYCQT15LwiGSGZmWvf5EIno3L++OMiYFA0cgP7+089h6/ZoxG8ebcY0vpg6Wi86IAjmRQFkgd/B8ptSzDgIgTMxhPLlVU+UllEQHtawY7X9anI9yI3b2vGyAQARLdGIhJPnIUP/+4wW+A+Kxv0++bBk6f5FPH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491712; c=relaxed/simple;
	bh=UAwqrvXyEz3letFw34Y/kcPsnW2AVxoFSqkFw+bnVBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eVnR2J7RCrm6PPKRAMbDffDJG2re58zIP89taobkYmM3NOGTIWpxsu6fUo1AJxj+A3vZiF/BShvuigetbCAM0aOMePDeUuv58RyoDTEg82A9K0ASxU7HW44PQFhKei6UjGU2nmavuylRNHhXaeVOUNFbk686ybsKDUXrriCdorI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H+DzWDjW; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43dff9da88fso16079811cf.2
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 12:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1716491710; x=1717096510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr3CsVp5rhj3nm1vcR9h+KV2oHZk2sARnHQrY3a9dwg=;
        b=H+DzWDjW+5zY2cQ4nPmLPRuFu3Mwy1XS7yW3gYiaFbGcwBktk7qlhZF97L5VYv5YsD
         VY53LLbEbsr6+6NxYPvwoJj2p6wqL3TK6/D06X/Ne0IZIWoxfZcgHknPQUylfnmBg5hN
         FCr0Stul1QkCqasRRk6IloGRyCvc9uHLn6Ujg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716491710; x=1717096510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hr3CsVp5rhj3nm1vcR9h+KV2oHZk2sARnHQrY3a9dwg=;
        b=MlqUmU+HuF5AsWPURNiyM38fIR+JDLi1bjSB2x5r40JCAUX2rtqVdwlIWuKlznXcha
         FRdA5U1eYPc+wjrBytnz9CEwYjbPMiV1kP9IofFwkD1XpviaDC4fEsrO3m0zFqwaHWtf
         tOrfRwDGP2AZMljrqsP2buLzvwkLA+tgnkbI/JKX29B2cdDaZbxJf4ZcYvqvzMRM2Dnw
         boPLYr3/KyBLa/LZIw9aVst/e323oJqlQ3r/tlYXRZiPlr7DMeeK34y8I3J+tQfVBNNJ
         SqA1bVnO/3uUXDahmpiHzNn3GEkeLHWXeQbj/a7445F/VqWm9CRBYhz+ci98ymQe2s0x
         fefw==
X-Forwarded-Encrypted: i=1; AJvYcCXmiuadYnucFo1llL5cIdKIiwiZmsahpG6OU5sBJiXrBHsjwlRlLHoV4PafBTOlCZyXTFMRXf0cZrb3XEUNYK0/bnmDN6km
X-Gm-Message-State: AOJu0YzDZib5CBFVr7lApF2HMmxsClyhsfiuCaJgr5Vl31J7FzlHQi61
	QtMGy2XsbzLBx4FPoFY6SsZ8srUnPghBWMWaU7ZPre1PMh5gjlqDoFLwYxid7g==
X-Google-Smtp-Source: AGHT+IEbgewiJpl673lkpCKuRzP4LPQh3l1+ZBrR7wRDi3emMUilccaX/qLEJo7uTfP4sOTw9zYitQ==
X-Received: by 2002:a05:622a:2c9:b0:43d:f942:ca3e with SMTP id d75a77b69052e-43fb0edd548mr131611cf.47.1716491709653;
        Thu, 23 May 2024 12:15:09 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e4a89b61dsm21219821cf.45.2024.05.23.12.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 12:15:09 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
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
	timothym@vmware.com,
	akaher@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH v10 1/8] x86/vmware: Introduce VMware hypercall API
Date: Thu, 23 May 2024 12:14:39 -0700
Message-Id: <20240523191446.54695-2-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240523191446.54695-1-alexey.makhalov@broadcom.com>
References: <20240523191446.54695-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce vmware_hypercall family of functions. It is a common
implementation to be used by the VMware guest code and virtual
device drivers in architecture independent manner.

The API consists of vmware_hypercallX and vmware_hypercall_hb_{out,in}
set of functions by analogy with KVM hypercall API. Architecture
specific implementation is hidden inside.

It will simplify future enhancements in VMware hypercalls such
as SEV-ES and TDX related changes without needs to modify a
caller in device drivers code.

Current implementation extends an idea from commit bac7b4e84323
("x86/vmware: Update platform detection code for VMCALL/VMMCALL
hypercalls") to have a slow, but safe path in VMWARE_HYPERCALL
earlier during the boot when alternatives are not yet applied.
The code inherits VMWARE_CMD logic from the commit mentioned above.

Move common macros from vmware.c to vmware.h.

Make vmware_hypercall_mode a global variable.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/include/asm/vmware.h | 274 ++++++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/vmware.c  |  11 +-
 2 files changed, 262 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index ac9fc51e2b18..5114f4c75c54 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -7,26 +7,272 @@
 #include <linux/stringify.h>
 
 /*
- * The hypercall definitions differ in the low word of the %edx argument
- * in the following way: the old port base interface uses the port
- * number to distinguish between high- and low bandwidth versions.
+ * VMware hypercall ABI.
+ *
+ * - Low bandwidth (LB) hypercalls (I/O port based, vmcall and vmmcall)
+ * have up to 6 input and 6 output arguments passed and returned using
+ * registers: %eax (arg0), %ebx (arg1), %ecx (arg2), %edx (arg3),
+ * %esi (arg4), %edi (arg5).
+ * The following input arguments must be initialized by the caller:
+ * arg0 - VMWARE_HYPERVISOR_MAGIC
+ * arg2 - Hypercall command
+ * arg3 bits [15:0] - Port number, LB and direction flags
+ *
+ * - High bandwidth (HB) hypercalls are I/O port based only. They have
+ * up to 7 input and 7 output arguments passed and returned using
+ * registers: %eax (arg0), %ebx (arg1), %ecx (arg2), %edx (arg3),
+ * %esi (arg4), %edi (arg5), %ebp (arg6).
+ * The following input arguments must be initialized by the caller:
+ * arg0 - VMWARE_HYPERVISOR_MAGIC
+ * arg1 - Hypercall command
+ * arg3 bits [15:0] - Port number, HB and direction flags
+ *
+ * For compatibility purposes, x86_64 systems use only lower 32 bits
+ * for input and output arguments.
+ *
+ * The hypercall definitions differ in the low word of the %edx (arg3)
+ * in the following way: the old I/O port based interface uses the port
+ * number to distinguish between high- and low bandwidth versions, and
+ * uses IN/OUT instructions to define transfer direction.
  *
  * The new vmcall interface instead uses a set of flags to select
  * bandwidth mode and transfer direction. The flags should be loaded
- * into %dx by any user and are automatically replaced by the port
- * number if the VMWARE_HYPERVISOR_PORT method is used.
- *
- * In short, new driver code should strictly use the new definition of
- * %dx content.
+ * into arg3 by any user and are automatically replaced by the port
+ * number if the I/O port method is used.
+ */
+
+#define VMWARE_HYPERVISOR_HB		BIT(0)
+#define VMWARE_HYPERVISOR_OUT		BIT(1)
+
+#define VMWARE_HYPERVISOR_PORT		0x5658
+#define VMWARE_HYPERVISOR_PORT_HB	(VMWARE_HYPERVISOR_PORT | \
+					 VMWARE_HYPERVISOR_HB)
+
+#define VMWARE_HYPERVISOR_MAGIC		0x564d5868U
+
+#define VMWARE_CMD_GETVERSION		10
+#define VMWARE_CMD_GETHZ		45
+#define VMWARE_CMD_GETVCPU_INFO		68
+#define VMWARE_CMD_STEALCLOCK		91
+
+#define CPUID_VMWARE_FEATURES_ECX_VMMCALL	BIT(0)
+#define CPUID_VMWARE_FEATURES_ECX_VMCALL	BIT(1)
+
+extern u8 vmware_hypercall_mode;
+
+/*
+ * The low bandwidth call. The low word of %edx is presumed to have OUT bit
+ * set. The high word of %edx may contain input data from the caller.
+ */
+#define VMWARE_HYPERCALL						\
+	ALTERNATIVE_3("",						\
+		      "jmp .Lport_call%=", X86_FEATURE_HYPERVISOR,	\
+		      "jmp .Lvmcall%=", X86_FEATURE_VMCALL,		\
+		      "vmmcall\n\t"					\
+		      "jmp .Lend%=", X86_FEATURE_VMW_VMMCALL)		\
+		      "cmpb $"						\
+			__stringify(CPUID_VMWARE_FEATURES_ECX_VMMCALL)	\
+			", %[mode]\n\t"					\
+		      "jg .Lvmcall%=\n\t"				\
+		      "je .Lvmmcall%=\n\t"				\
+		      ".Lport_call%=: movw %[port], %%dx\n\t"		\
+		      "inl (%%dx), %%eax\n\t"				\
+		      "jmp .Lend%=\n\t"					\
+		      ".Lvmmcall%=: vmmcall\n\t"			\
+		      "jmp .Lend%=\n\t"					\
+		      ".Lvmcall%=: vmcall\n\t"				\
+		      ".Lend%=:"
+
+static inline
+unsigned long vmware_hypercall1(unsigned long cmd, unsigned long in1)
+{
+	unsigned long out0;
+
+	asm_inline volatile (VMWARE_HYPERCALL
+		: "=a" (out0)
+		: [port] "i" (VMWARE_HYPERVISOR_PORT),
+		  [mode] "m" (vmware_hypercall_mode),
+		  "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (0)
+		: "cc", "memory");
+	return out0;
+}
+
+static inline
+unsigned long vmware_hypercall3(unsigned long cmd, unsigned long in1,
+				u32 *out1, u32 *out2)
+{
+	unsigned long out0;
+
+	asm_inline volatile (VMWARE_HYPERCALL
+		: "=a" (out0), "=b" (*out1), "=c" (*out2)
+		: [port] "i" (VMWARE_HYPERVISOR_PORT),
+		  [mode] "m" (vmware_hypercall_mode),
+		  "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (0)
+		: "cc", "memory");
+	return out0;
+}
+
+static inline
+unsigned long vmware_hypercall4(unsigned long cmd, unsigned long in1,
+				u32 *out1, u32 *out2, u32 *out3)
+{
+	unsigned long out0;
+
+	asm_inline volatile (VMWARE_HYPERCALL
+		: "=a" (out0), "=b" (*out1), "=c" (*out2), "=d" (*out3)
+		: [port] "i" (VMWARE_HYPERVISOR_PORT),
+		  [mode] "m" (vmware_hypercall_mode),
+		  "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (0)
+		: "cc", "memory");
+	return out0;
+}
+
+static inline
+unsigned long vmware_hypercall5(unsigned long cmd, unsigned long in1,
+				unsigned long in3, unsigned long in4,
+				unsigned long in5, u32 *out2)
+{
+	unsigned long out0;
+
+	asm_inline volatile (VMWARE_HYPERCALL
+		: "=a" (out0), "=c" (*out2)
+		: [port] "i" (VMWARE_HYPERVISOR_PORT),
+		  [mode] "m" (vmware_hypercall_mode),
+		  "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (in3),
+		  "S" (in4),
+		  "D" (in5)
+		: "cc", "memory");
+	return out0;
+}
+
+static inline
+unsigned long vmware_hypercall6(unsigned long cmd, unsigned long in1,
+				unsigned long in3, u32 *out2,
+				u32 *out3, u32 *out4, u32 *out5)
+{
+	unsigned long out0;
+
+	asm_inline volatile (VMWARE_HYPERCALL
+		: "=a" (out0), "=c" (*out2), "=d" (*out3), "=S" (*out4),
+		  "=D" (*out5)
+		: [port] "i" (VMWARE_HYPERVISOR_PORT),
+		  [mode] "m" (vmware_hypercall_mode),
+		  "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (in3)
+		: "cc", "memory");
+	return out0;
+}
+
+static inline
+unsigned long vmware_hypercall7(unsigned long cmd, unsigned long in1,
+				unsigned long in3, unsigned long in4,
+				unsigned long in5, u32 *out1,
+				u32 *out2, u32 *out3)
+{
+	unsigned long out0;
+
+	asm_inline volatile (VMWARE_HYPERCALL
+		: "=a" (out0), "=b" (*out1), "=c" (*out2), "=d" (*out3)
+		: [port] "i" (VMWARE_HYPERVISOR_PORT),
+		  [mode] "m" (vmware_hypercall_mode),
+		  "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (in3),
+		  "S" (in4),
+		  "D" (in5)
+		: "cc", "memory");
+	return out0;
+}
+
+
+#ifdef CONFIG_X86_64
+#define VMW_BP_REG "%%rbp"
+#define VMW_BP_CONSTRAINT "r"
+#else
+#define VMW_BP_REG "%%ebp"
+#define VMW_BP_CONSTRAINT "m"
+#endif
+
+/*
+ * High bandwidth calls are not supported on encrypted memory guests.
+ * The caller should check cc_platform_has(CC_ATTR_MEM_ENCRYPT) and use
+ * low bandwidth hypercall if memory encryption is set.
+ * This assumption simplifies HB hypercall implementation to just I/O port
+ * based approach without alternative patching.
  */
+static inline
+unsigned long vmware_hypercall_hb_out(unsigned long cmd, unsigned long in2,
+				      unsigned long in3, unsigned long in4,
+				      unsigned long in5, unsigned long in6,
+				      u32 *out1)
+{
+	unsigned long out0;
+
+	asm_inline volatile (
+		UNWIND_HINT_SAVE
+		"push " VMW_BP_REG "\n\t"
+		UNWIND_HINT_UNDEFINED
+		"mov %[in6], " VMW_BP_REG "\n\t"
+		"rep outsb\n\t"
+		"pop " VMW_BP_REG "\n\t"
+		UNWIND_HINT_RESTORE
+		: "=a" (out0), "=b" (*out1)
+		: "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (cmd),
+		  "c" (in2),
+		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
+		  "S" (in4),
+		  "D" (in5),
+		  [in6] VMW_BP_CONSTRAINT (in6)
+		: "cc", "memory");
+	return out0;
+}
 
-/* Old port-based version */
-#define VMWARE_HYPERVISOR_PORT    0x5658
-#define VMWARE_HYPERVISOR_PORT_HB 0x5659
+static inline
+unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
+				     unsigned long in3, unsigned long in4,
+				     unsigned long in5, unsigned long in6,
+				     u32 *out1)
+{
+	unsigned long out0;
 
-/* Current vmcall / vmmcall version */
-#define VMWARE_HYPERVISOR_HB   BIT(0)
-#define VMWARE_HYPERVISOR_OUT  BIT(1)
+	asm_inline volatile (
+		UNWIND_HINT_SAVE
+		"push " VMW_BP_REG "\n\t"
+		UNWIND_HINT_UNDEFINED
+		"mov %[in6], " VMW_BP_REG "\n\t"
+		"rep insb\n\t"
+		"pop " VMW_BP_REG "\n\t"
+		UNWIND_HINT_RESTORE
+		: "=a" (out0), "=b" (*out1)
+		: "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (cmd),
+		  "c" (in2),
+		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
+		  "S" (in4),
+		  "D" (in5),
+		  [in6] VMW_BP_CONSTRAINT (in6)
+		: "cc", "memory");
+	return out0;
+}
+#undef VMW_BP_REG
+#undef VMW_BP_CONSTRAINT
+#undef VMWARE_HYPERCALL
 
 /* The low bandwidth call. The low word of edx is presumed clear. */
 #define VMWARE_HYPERCALL						\
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 11f83d07925e..07b7b5b773a0 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -41,17 +41,9 @@
 
 #define CPUID_VMWARE_INFO_LEAF               0x40000000
 #define CPUID_VMWARE_FEATURES_LEAF           0x40000010
-#define CPUID_VMWARE_FEATURES_ECX_VMMCALL    BIT(0)
-#define CPUID_VMWARE_FEATURES_ECX_VMCALL     BIT(1)
 
-#define VMWARE_HYPERVISOR_MAGIC	0x564D5868
-
-#define VMWARE_CMD_GETVERSION    10
-#define VMWARE_CMD_GETHZ         45
-#define VMWARE_CMD_GETVCPU_INFO  68
 #define VMWARE_CMD_LEGACY_X2APIC  3
 #define VMWARE_CMD_VCPU_RESERVED 31
-#define VMWARE_CMD_STEALCLOCK    91
 
 #define STEALCLOCK_NOT_AVAILABLE (-1)
 #define STEALCLOCK_DISABLED        0
@@ -108,7 +100,8 @@ struct vmware_steal_time {
 };
 
 static unsigned long vmware_tsc_khz __ro_after_init;
-static u8 vmware_hypercall_mode     __ro_after_init;
+u8 vmware_hypercall_mode __ro_after_init;
+EXPORT_SYMBOL_GPL(vmware_hypercall_mode);
 
 static inline int __vmware_platform(void)
 {
-- 
2.39.0


