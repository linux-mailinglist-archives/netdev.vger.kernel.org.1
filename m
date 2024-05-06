Return-Path: <netdev+bounces-93871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C5E8BD70E
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 23:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738E61C221E8
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 21:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033C815D5DE;
	Mon,  6 May 2024 21:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YkAMYiCO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6297315D5A3
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032419; cv=none; b=fSIRkE7tZOkAJ21Aadot+IiTMrBRclhHhJ5uoJv+wyeIkWUSp35GBhjLuy0xiTF5bgTe9YznpMUnR+c+CbjgZwlpdvjyu5XvJnIFud+YlhQexJOeaXba6WaHJkhZfLahbOqG2rjcmfvcUB8h3YHlhbKXpS804rFEknYurCN7JPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032419; c=relaxed/simple;
	bh=+b5WVE8Zl/oL6yUg8wqjTrG63YhiMX5zZ8A4o/ecnHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hVDd5OHawqKc9e4YHoLPfaciJ3CPN+lsSHbvZOlaIU3gsLSzQoz9pGeXesnE8FyEqRNOisPYqfmUAnV4cDUdmAE/2no8xhbA7AAfLlpiSrr3IOREg+m0jfOtMy4hD7AZHVq44Wzbo0CPnIX/urY1YlRGjYS6OQkJEG2cfGt980g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YkAMYiCO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f467fb2e66so1823584b3a.1
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 14:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715032417; x=1715637217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unRpkwwh5dJFFHedeUaWdr6DvAi5Mpoz54YPBsP5M3Q=;
        b=YkAMYiCO55SpCNT3mbXFF3KyxYg0zarkzA6VGe/7vWmiXOvJxqOcBjJEU51AsH4Cf7
         +JhBv68xgPw2JUbYRGzOP5SOmKyxAR9ArD7agsn05d//ht7VCOLxRLysmkkBllSGQ22S
         lFf83CKrpp4bHNxwkFwvJSN6GNA9ZeMZIX/B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715032417; x=1715637217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unRpkwwh5dJFFHedeUaWdr6DvAi5Mpoz54YPBsP5M3Q=;
        b=JjCW9UPiRAI0etlErdwQti3/8mAEYYTuW3J00u+6zbwzTJ9LhWZFcKhlPmr/qCyBMq
         4KgqSBZPClWFvxVhc1gNNJQ3j+yl8MxTU1Hz2/noB5b0WCvAKnDmem9zEAxkwVwysi8V
         bAuQ1SZhT4YmmlRbMg9TrfM4Mv/PskDjiEoQIB4VdgWbxRAVTGRjlM1jtNWdMdA998eR
         Edd1LgNKe1n+jCutQEeFn19wJeUdrfABwBPVvRaQzk3g4N4aziH8OGzcZMWbivMbhtDv
         IWlpFbqqAkdB2/1WAi3MM2XxSzW9Aa60jLZNCj9YMNu+ZmxPT/yrb7BWkLtARguKSgtO
         3iOw==
X-Forwarded-Encrypted: i=1; AJvYcCXE3RO1OfqaNQPwZ+aZlJSTZIYWiFQ4CEIsQlT/t/TufnzuMtKb4vm+1I8z3/605alfxsw6eorKPnN/V63vg65bAALRtInT
X-Gm-Message-State: AOJu0Yw9QHZ5NuGf5M6kqRSNeCij7t/YVZs++herTGxlMpipE4yQhvoN
	dV9M+yy2wuufyugfjqdnUYbNvibU+dR1vnqpVuCBK+usDLuGHD48eAAqqddwgw==
X-Google-Smtp-Source: AGHT+IFytwDU3QJ4vsK+POJxwu7g3JrCnYNdqTb3FG3oTGvi5HMPEUCb2k8ZGmPzihZ3UGGsQkiLoQ==
X-Received: by 2002:a05:6a20:7347:b0:1ad:7e66:659a with SMTP id v7-20020a056a20734700b001ad7e66659amr15303766pzc.15.1715032417415;
        Mon, 06 May 2024 14:53:37 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902f54800b001ed6868e257sm5664008plf.123.2024.05.06.14.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:53:36 -0700 (PDT)
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
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v9 1/8] x86/vmware: Move common macros to vmware.h
Date: Mon,  6 May 2024 14:52:58 -0700
Message-Id: <20240506215305.30756-2-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240506215305.30756-1-alexey.makhalov@broadcom.com>
References: <20240505182829.GBZjfPzeEijTsBUth5@fat_crate.local>
 <20240506215305.30756-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move VMware hypercall macros to vmware.h. This is a prerequisite for
the introduction of vmware_hypercall API. No functional changes besides
exporting vmware_hypercall_mode symbol.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Reviewed-by: Nadav Amit <nadav.amit@gmail.com>
---
 arch/x86/include/asm/vmware.h | 72 +++++++++++++++++++++++++++++------
 arch/x86/kernel/cpu/vmware.c  | 49 +-----------------------
 2 files changed, 62 insertions(+), 59 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index ac9fc51e2b18..de2533337611 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -8,25 +8,34 @@
 
 /*
  * The hypercall definitions differ in the low word of the %edx argument
- * in the following way: the old port base interface uses the port
- * number to distinguish between high- and low bandwidth versions.
+ * in the following way: the old I/O port based interface uses the port
+ * number to distinguish between high- and low bandwidth versions, and
+ * uses IN/OUT instructions to define transfer direction.
  *
  * The new vmcall interface instead uses a set of flags to select
  * bandwidth mode and transfer direction. The flags should be loaded
  * into %dx by any user and are automatically replaced by the port
- * number if the VMWARE_HYPERVISOR_PORT method is used.
- *
- * In short, new driver code should strictly use the new definition of
- * %dx content.
+ * number if the I/O port method is used.
  */
 
-/* Old port-based version */
-#define VMWARE_HYPERVISOR_PORT    0x5658
-#define VMWARE_HYPERVISOR_PORT_HB 0x5659
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
 
-/* Current vmcall / vmmcall version */
-#define VMWARE_HYPERVISOR_HB   BIT(0)
-#define VMWARE_HYPERVISOR_OUT  BIT(1)
+extern u8 vmware_hypercall_mode;
 
 /* The low bandwidth call. The low word of edx is presumed clear. */
 #define VMWARE_HYPERCALL						\
@@ -54,4 +63,43 @@
 		      "rep insb",					\
 		      "vmcall", X86_FEATURE_VMCALL,			\
 		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
+
+#define VMWARE_PORT(cmd, eax, ebx, ecx, edx)				\
+	__asm__("inl (%%dx), %%eax" :					\
+		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
+		"a"(VMWARE_HYPERVISOR_MAGIC),				\
+		"c"(VMWARE_CMD_##cmd),					\
+		"d"(VMWARE_HYPERVISOR_PORT), "b"(UINT_MAX) :		\
+		"memory")
+
+#define VMWARE_VMCALL(cmd, eax, ebx, ecx, edx)				\
+	__asm__("vmcall" :						\
+		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
+		"a"(VMWARE_HYPERVISOR_MAGIC),				\
+		"c"(VMWARE_CMD_##cmd),					\
+		"d"(0), "b"(UINT_MAX) :					\
+		"memory")
+
+#define VMWARE_VMMCALL(cmd, eax, ebx, ecx, edx)				\
+	__asm__("vmmcall" :						\
+		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
+		"a"(VMWARE_HYPERVISOR_MAGIC),				\
+		"c"(VMWARE_CMD_##cmd),					\
+		"d"(0), "b"(UINT_MAX) :					\
+		"memory")
+
+#define VMWARE_CMD(cmd, eax, ebx, ecx, edx) do {		\
+	switch (vmware_hypercall_mode) {			\
+	case CPUID_VMWARE_FEATURES_ECX_VMCALL:			\
+		VMWARE_VMCALL(cmd, eax, ebx, ecx, edx);		\
+		break;						\
+	case CPUID_VMWARE_FEATURES_ECX_VMMCALL:			\
+		VMWARE_VMMCALL(cmd, eax, ebx, ecx, edx);	\
+		break;						\
+	default:						\
+		VMWARE_PORT(cmd, eax, ebx, ecx, edx);		\
+		break;						\
+	}							\
+	} while (0)
+
 #endif
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 11f83d07925e..68d812e12e52 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -41,60 +41,14 @@
 
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
 #define STEALCLOCK_ENABLED         1
 
-#define VMWARE_PORT(cmd, eax, ebx, ecx, edx)				\
-	__asm__("inl (%%dx), %%eax" :					\
-		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
-		"a"(VMWARE_HYPERVISOR_MAGIC),				\
-		"c"(VMWARE_CMD_##cmd),					\
-		"d"(VMWARE_HYPERVISOR_PORT), "b"(UINT_MAX) :		\
-		"memory")
-
-#define VMWARE_VMCALL(cmd, eax, ebx, ecx, edx)				\
-	__asm__("vmcall" :						\
-		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
-		"a"(VMWARE_HYPERVISOR_MAGIC),				\
-		"c"(VMWARE_CMD_##cmd),					\
-		"d"(0), "b"(UINT_MAX) :					\
-		"memory")
-
-#define VMWARE_VMMCALL(cmd, eax, ebx, ecx, edx)                         \
-	__asm__("vmmcall" :						\
-		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
-		"a"(VMWARE_HYPERVISOR_MAGIC),				\
-		"c"(VMWARE_CMD_##cmd),					\
-		"d"(0), "b"(UINT_MAX) :					\
-		"memory")
-
-#define VMWARE_CMD(cmd, eax, ebx, ecx, edx) do {		\
-	switch (vmware_hypercall_mode) {			\
-	case CPUID_VMWARE_FEATURES_ECX_VMCALL:			\
-		VMWARE_VMCALL(cmd, eax, ebx, ecx, edx);		\
-		break;						\
-	case CPUID_VMWARE_FEATURES_ECX_VMMCALL:			\
-		VMWARE_VMMCALL(cmd, eax, ebx, ecx, edx);	\
-		break;						\
-	default:						\
-		VMWARE_PORT(cmd, eax, ebx, ecx, edx);		\
-		break;						\
-	}							\
-	} while (0)
-
 struct vmware_steal_time {
 	union {
 		uint64_t clock;	/* stolen time counter in units of vtsc */
@@ -108,7 +62,8 @@ struct vmware_steal_time {
 };
 
 static unsigned long vmware_tsc_khz __ro_after_init;
-static u8 vmware_hypercall_mode     __ro_after_init;
+u8 vmware_hypercall_mode __ro_after_init;
+EXPORT_SYMBOL_GPL(vmware_hypercall_mode);
 
 static inline int __vmware_platform(void)
 {
-- 
2.39.0


