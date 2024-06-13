Return-Path: <netdev+bounces-103372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7354907C43
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 21:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2644E287145
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 19:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219551553B5;
	Thu, 13 Jun 2024 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GU+vJ6FY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FD015351B
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306243; cv=none; b=pb8qKxTdiDmZF0nvsX8+Grg2Rk3PWmaPF0vssLbt20ovfS7tgdUUz6CkgYIbDctRl1zjGIet/iTdGeNr5feKDg7I++eR67kaDogEro9szbL67UuDMrKRSyMOpyhEqxbljy7vol8/xpFcKeWQjHvUni1RGccShExlUccgIdvZahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306243; c=relaxed/simple;
	bh=OG42qfwazXtBgUNMq966TfvZjei0oGY3S3mxCfCH66M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c/Kl3SN1eIQl492erc5rfpZR9AkRktc45ErIb7jmZEMPuQFZ33V8tWrvkHm2zaoT2kjNEMzvDaZx8Y8kIoK6MKMUgAvNyg8HDHzDRDE1vmZQSSOihUgg0dfb+kQMApjH3TqH/BrmDtyXW6vcyQaW5hxqIep/JC2DZVamOTLYVzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GU+vJ6FY; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b06446f667so7669846d6.2
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718306240; x=1718911040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ax+3nG0Kdev/eny6WkBwEporcnkaWtjPbwWuGAk8XSQ=;
        b=GU+vJ6FY+rv1C6QQ9nN98WhV16tfhCHI/UfK7tcSifrgrC7LMySlsjC2daV+cdmWjv
         XzpIqa5QZiFt7VswK5lVtaDkbdVAd6wqJw4Q+7DX4YeOH3b3tii8XqjosVzvtJZNWLJM
         0NzSoVlXODT64Nw5jbHahuSIKg1SgaGKbXdAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718306240; x=1718911040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ax+3nG0Kdev/eny6WkBwEporcnkaWtjPbwWuGAk8XSQ=;
        b=KVlub4HYLLpvQE4nTy8zDGOxhrOm2JOqndf2kuIL9gWhd0K0PCS/AtBUJ4I/6c5zre
         LWqnK8gIo5uX0PGONsH1Wv8VaDvHw+PPbeb66TArnObcCUs8CvV672seMXodjZdmImY3
         hgem/UjrYbzTevfm1XguyD5OQN6gbphMOMrAqbPk9cTqQ/dmJgIi/4SxQYZlZ+Qfrif6
         zRujXDV2A0zFwGbGs5Wf32zxBPnkUKlyZ9FSbMmt1Uzyl8BLWzo46g+fBZ7Jg8q04z9J
         j5QV66BO5+rKaNLJH2D318qbQl3YkL0DEPHCsTQbcxg9NO8TVDpDPC8mvCmRjeScyexi
         gHaA==
X-Forwarded-Encrypted: i=1; AJvYcCU49fd+vHN3LSrlIAKTC8dIxMRfML7lW4pIFU9+w3vADRhA2F1qS3DvUBsFWPSDnvmVcfb6Vyxi+9MoPkCJmzl69vCIuRVr
X-Gm-Message-State: AOJu0Yw5j5AMvg4U+g4NbBEPSVTIgXgS+0DHLn+ndFw2K5+f/Lp/us0z
	2URFv1dUT2p36jSDGyZH3fHAdARc4Ghltj+Zq/4+GhE9Vv2Jc75wusxex0Rkj0GWYwzdfnAziOE
	=
X-Google-Smtp-Source: AGHT+IEeXpn3Ttz0XbsYPXByW9dR39UVsdwJC6JosUg+iPFfKoIf29zQxFw7l7oJP0aQ82f3abYR7Q==
X-Received: by 2002:ad4:5a03:0:b0:6b2:b054:c64a with SMTP id 6a1803df08f44-6b2b054c6c8mr4382156d6.1.1718306240532;
        Thu, 13 Jun 2024 12:17:20 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb47f6sm9714106d6.82.2024.06.13.12.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:17:20 -0700 (PDT)
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
Subject: [PATCH v11 2/8] ptp/vmware: Use VMware hypercall API
Date: Thu, 13 Jun 2024 12:16:44 -0700
Message-Id: <20240613191650.9913-3-alexey.makhalov@broadcom.com>
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

Switch from VMWARE_HYPERCALL macro to vmware_hypercall API.
Eliminate arch specific code. No functional changes intended.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 drivers/ptp/ptp_vmw.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
index 7ec90359428a..20ab05c4daa8 100644
--- a/drivers/ptp/ptp_vmw.c
+++ b/drivers/ptp/ptp_vmw.c
@@ -14,7 +14,6 @@
 #include <asm/hypervisor.h>
 #include <asm/vmware.h>
 
-#define VMWARE_MAGIC 0x564D5868
 #define VMWARE_CMD_PCLK(nr) ((nr << 16) | 97)
 #define VMWARE_CMD_PCLK_GETTIME VMWARE_CMD_PCLK(0)
 
@@ -24,15 +23,10 @@ static struct ptp_clock *ptp_vmw_clock;
 
 static int ptp_vmw_pclk_read(u64 *ns)
 {
-	u32 ret, nsec_hi, nsec_lo, unused1, unused2, unused3;
-
-	asm volatile (VMWARE_HYPERCALL :
-		"=a"(ret), "=b"(nsec_hi), "=c"(nsec_lo), "=d"(unused1),
-		"=S"(unused2), "=D"(unused3) :
-		"a"(VMWARE_MAGIC), "b"(0),
-		"c"(VMWARE_CMD_PCLK_GETTIME), "d"(0) :
-		"memory");
+	u32 ret, nsec_hi, nsec_lo;
 
+	ret = vmware_hypercall3(VMWARE_CMD_PCLK_GETTIME, 0,
+				&nsec_hi, &nsec_lo);
 	if (ret == 0)
 		*ns = ((u64)nsec_hi << 32) | nsec_lo;
 	return ret;
-- 
2.39.4


