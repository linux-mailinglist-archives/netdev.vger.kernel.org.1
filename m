Return-Path: <netdev+bounces-103376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E92907C5D
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 21:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66DDBB25882
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 19:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D16715820F;
	Thu, 13 Jun 2024 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bZjq4wUk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B7157E99
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306265; cv=none; b=uzjaiy8566DilHRCcl4rUeQp+7tHxunmY/h5nbSlePO5Dl/ZZ0KHgbHWcBK2Cw8qFdRulYhkdLPZk6sWz+UFDC1tdXL4/MttnUQ4ydTBKfmoVM37qe5ftntH0hfsVOnwtiDIhWHV2VKbb+ghsSq8xFfonNhVMDVwCr+j6QFCwTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306265; c=relaxed/simple;
	bh=gJtizgfTtQbGQhXe0Ffz4OqK1Rt5xK/EhfhSkvCPdfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GaWezgs1+XJp8jl2s2xPQQ2r7nbAta7TZbc0T6aVYJNnjowg9Gon/ItP9L4cDUHC2YWXfS1aonB7PgcLksrm4MahMp/pIe4rLBOVbibhU5WfX3eABsLoxx03qDxq0Fl31ECY2JaDeWyk9NXlROT4MmKsEZCALoSRvegosvwsn4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bZjq4wUk; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6316253dc2aso9798097b3.0
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 12:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718306261; x=1718911061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pPcaHiPPoaU0LCl+3obAd9PjZsEURqyWYfZZD0IxMg=;
        b=bZjq4wUk2b9/H8Y8aVTgyhiy63jjdcHMe2PU0LFG8I41Oaq+fu6hu3U1V5opTs+ImI
         XhjpKWrggJ4F1dSpfK1OSRflFV3ZlNJqEu8DTbTwn+r0uaSvOZihMmx3vi5IeXJtEUC3
         OxbG8LfEHaOQB9lc7qelfGc5WcDkNb7+qBGpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718306261; x=1718911061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pPcaHiPPoaU0LCl+3obAd9PjZsEURqyWYfZZD0IxMg=;
        b=rQZuJ3TMR2ex10lLwCTH7qm7a9uDY9KNPSTyI0he3gXVsMoguj+mxnbHPgenplgJv7
         D6iGJrDtKdURgNed5Xne4JrFRYPN9+TgDCwdzwmk77mLADOL0sC96H0mGfNml/qYeYw9
         FsKN8Eon5afJqaWv68ntbVFmw4YlEwTZwXhejmaL5/fdW9WVtqA1f8gYKgXuuVoea+mJ
         NZylUwG28kZuIsnsHC/4B7Sv3WTTwQ155qy66DmW2ydmzXEni073zdu8zUFc4qnztqi7
         5PTonkC+cTL5FAt10M7ej6UlqJPojvRCO6usZ+NMJCOkiopv4anB5e7RD+w1ErEpP+RI
         6PQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK6T2psbzbTPmhJpmjBzJdGsleRAOLTplueQEBNgluykjBZBLMqk1G7DyxFuvQYm1at7LxN90XF0dK1kPaSGclARjN3/JP
X-Gm-Message-State: AOJu0YwCxinQ3TPuTuh8aIiAlbHtJ62/z0DpxpnuOrPcVtUKGtXNwgvS
	YRCT1e5QTQ4FbEcJTTfIz998gEHVc+fTKNfMqnG8vbFN+1kf7llQVRcHlYJpIw==
X-Google-Smtp-Source: AGHT+IEWURrmB3A2rOUKWL00yxGmIpKcgzJOWJY4x+5FfERXRFuKFdGultRWCA+8ZJ4Et9888+QB5w==
X-Received: by 2002:a81:e90b:0:b0:618:83a4:588e with SMTP id 00721157ae682-63223d3b72emr4007287b3.37.1718306261554;
        Thu, 13 Jun 2024 12:17:41 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb47f6sm9714106d6.82.2024.06.13.12.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:17:41 -0700 (PDT)
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
Subject: [PATCH v11 6/8] x86/vmware: Correct macro names
Date: Thu, 13 Jun 2024 12:16:48 -0700
Message-Id: <20240613191650.9913-7-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20240613191650.9913-1-alexey.makhalov@broadcom.com>
References: <20240613191650.9913-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VCPU_RESERVED and LEGACY_X2APIC are not VMware hypercall commands.
These are bits in return value of VMWARE_CMD_GETVCPU_INFO command.
Change VMWARE_CMD_ prefix to GETVCPU_INFO_ one. And move bit-shift
operation to the macro body.

Fixes: 4cca6ea04d31c ("x86/apic: Allow x2apic without IR on VMware platform")
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/kernel/cpu/vmware.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index c0a3ffa9e023..d24ba03b30b8 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -42,8 +42,8 @@
 #define CPUID_VMWARE_INFO_LEAF               0x40000000
 #define CPUID_VMWARE_FEATURES_LEAF           0x40000010
 
-#define VMWARE_CMD_LEGACY_X2APIC  3
-#define VMWARE_CMD_VCPU_RESERVED 31
+#define GETVCPU_INFO_LEGACY_X2APIC           BIT(3)
+#define GETVCPU_INFO_VCPU_RESERVED           BIT(31)
 
 #define STEALCLOCK_NOT_AVAILABLE (-1)
 #define STEALCLOCK_DISABLED        0
@@ -473,8 +473,8 @@ static bool __init vmware_legacy_x2apic_available(void)
 	u32 eax;
 
 	eax = vmware_hypercall1(VMWARE_CMD_GETVCPU_INFO, 0);
-	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
-		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
+	return !(eax & GETVCPU_INFO_VCPU_RESERVED) &&
+		(eax & GETVCPU_INFO_LEGACY_X2APIC);
 }
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-- 
2.39.4


