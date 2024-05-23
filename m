Return-Path: <netdev+bounces-97887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CA58CDAB7
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 21:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1D81C20894
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 19:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F9D8529B;
	Thu, 23 May 2024 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dW+csAyu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3286B84FDD
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491746; cv=none; b=hMrl9bMqHw5oE/9Yt1paR1vZ+/1vDV/d6Kx3Iwv4g9L5CkOt7oYg5ePX9EZ9VXGVCmZEaKQYHT0J6MUBq5Cjk0bCIGJxmgxbGiUgzIj7r3Qxjzloc4I/rNXo6iGj77n+3TDA6wVvh3CUMTNZf0LzMnYkq8hxhU+oe86BfbLpy0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491746; c=relaxed/simple;
	bh=M704MWHwyyg4r3sYtIOpDT3E8SyShb3NiouS2fvBgek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AwpccCQlGzG/wb9dfSodTi514GF+GI5cdQberQqsNPABLyDzn2tQ2u6cK4q9l7mNfWag41O0HPy7wuPH2W8PN6+taQ1vtihc3td+pS0isgpi/v/hsEbZeOiHYFWM4OLkrsfOwok0Q+n01xVH9sh8iHNxwi/jE4RHa2gkIg+Gyiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dW+csAyu; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6ab83788bf5so11763786d6.0
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 12:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1716491743; x=1717096543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QGCJNvGWko8B9wup6iwCm4c9keuD69o33VzvSan8uM=;
        b=dW+csAyuVBuhyW7k5fcHs+pPxtx67Lc4kx9/RlvFwMyXlqUGdc6htkvOn+5mMeSDOQ
         2CKtUjtK8r+oskuP5Ss+VLsT1/CX4aYRE2XE/ThHASzEtkkFYgN3NIl1MrSrwMn2EVn6
         /Mu2FHNJoDhWmTPf5c8AdOyyI1pAuc98FSu4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716491743; x=1717096543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QGCJNvGWko8B9wup6iwCm4c9keuD69o33VzvSan8uM=;
        b=ojd4djztPfd5pIdPHsHGl/WUkZI0y6+LhzFsmtvzdSRQK0IVmoB4dDVuyUxo2jBX90
         jsc1jPpPB5vFk8y9DScV5/xKWzjLnyjJTc5C1Pc9C37SlRGAVRfLlgl7uwYrUMLMthzx
         wdijeCd5mEwy8+jgfS+PcH0cuxi3FXpKvIrBTpu4EDXyvkIvRBSYU5yw7b7OwuiUfJW4
         8RXLXXbqj207+gjlfQTY9byocrFSdLnvLThZmC2JeBzJPgXD02XwJIzRuH86V96o05Ql
         vqgR+8rwtJu/VGmzNwM+g8aWJSl9oMlRFPxIkohZ0/wfB0e0Q2CAEH07R7sqnl9x7HXx
         220A==
X-Forwarded-Encrypted: i=1; AJvYcCWP2v9U+o34iki2Jbn36LPKHfV0rHID60W9gDK0zd1n/TeQzYAuqHDYhy5bDnrax0wjNRfqgPnvsMLLmSkMU+eJfbn6J+8E
X-Gm-Message-State: AOJu0YwVZ/ASIbk6wGd5VNAV+PBe+aPGRh0KyVC0kSfGbht877Qa7rbC
	LBwkzUKifE8zA6fislORd68I7cAhLbKDNsgRqIfe5jDPDlEMRk2OG/aOxy/Mbw==
X-Google-Smtp-Source: AGHT+IGCAtfhhWo6Rlq59zoTSeJjZRf1YXbHOspqfLPOVEnivKrPPVuS9RVtKABc8sYtmtvtPHf0hQ==
X-Received: by 2002:a05:6214:4888:b0:6a0:cbeb:c5c0 with SMTP id 6a1803df08f44-6abcd0d7813mr50266d6.55.1716491743143;
        Thu, 23 May 2024 12:15:43 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e4a89b61dsm21219821cf.45.2024.05.23.12.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 12:15:42 -0700 (PDT)
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
Subject: [PATCH v10 7/8] x86/vmware: Remove legacy VMWARE_HYPERCALL* macros
Date: Thu, 23 May 2024 12:14:45 -0700
Message-Id: <20240523191446.54695-8-alexey.makhalov@broadcom.com>
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

No more direct use of these macros should be allowed.
vmware_hypercallX api still use new implementation of VMWARE_HYPERCALL
macro internally, but it is not exposed outside of the vmware.h.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/include/asm/vmware.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 5114f4c75c54..78567920b23f 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -274,30 +274,4 @@ unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
 #undef VMW_BP_CONSTRAINT
 #undef VMWARE_HYPERCALL
 
-/* The low bandwidth call. The low word of edx is presumed clear. */
-#define VMWARE_HYPERCALL						\
-	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT) ", %%dx; " \
-		      "inl (%%dx), %%eax",				\
-		      "vmcall", X86_FEATURE_VMCALL,			\
-		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
-
-/*
- * The high bandwidth out call. The low word of edx is presumed to have the
- * HB and OUT bits set.
- */
-#define VMWARE_HYPERCALL_HB_OUT						\
-	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB) ", %%dx; " \
-		      "rep outsb",					\
-		      "vmcall", X86_FEATURE_VMCALL,			\
-		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
-
-/*
- * The high bandwidth in call. The low word of edx is presumed to have the
- * HB bit set.
- */
-#define VMWARE_HYPERCALL_HB_IN						\
-	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB) ", %%dx; " \
-		      "rep insb",					\
-		      "vmcall", X86_FEATURE_VMCALL,			\
-		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
 #endif
-- 
2.39.0


