Return-Path: <netdev+bounces-97882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B388CDA9E
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 21:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC64B283A6B
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 19:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1B484A5B;
	Thu, 23 May 2024 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bd50bKIk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDA084A49
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491719; cv=none; b=tvZONsudmFYi1qsCIy3MC9qakEwGYrp64tc7TctYs7ZqsYC2gv7ccB+vV7x5IIGtEaF2Ve3ORu6GsW9rEEAR21oDqtOwQG4gn6b3SullHIJGQ4eQaZsIBvarEpeEjVA3VRZb0Yhe05PUxYEBO44Bv3qeXrE4cpW0nh/OeW8IaXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491719; c=relaxed/simple;
	bh=ZNBT2utWr+CWbtzicSB/YTCRG247E6qB9Nr+UR8KY4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a7HGKrmb8DuRDDA/cJk2WWXkLovKfmfMHoi3ruBzu+xvGdicMbteGWR/yO1pgTAjd9H/UlmmXkUtOx4XSpM+mpt7/oH+NISuTIgMz/dGZJOP27MtQ4VMaDXjmtZFKR4I7zMDPCcLVg28vNNl8WvGVp2gcyjKVFy+IETcPRbe2tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bd50bKIk; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43f84f53f56so14782381cf.0
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 12:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1716491716; x=1717096516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHMYUJYhS9fLzUcof3ntSmUnLahUe/mGFjgJPys0Prk=;
        b=bd50bKIkRwXLQxULEQWGR+nR3UqUK0g5w2iYso3P9yndASTik4vNTo5/exgOhKNIon
         +s+0RDuDOro9h/xqzhPCMwQ5nZIdKPhAOsEhL6A4r/KTky6RHka41eMmt0DTQKrkr6Qx
         iO9Ewzsb/+xxlEyhZjgjwReSqUDZnhFPjqmsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716491716; x=1717096516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHMYUJYhS9fLzUcof3ntSmUnLahUe/mGFjgJPys0Prk=;
        b=dWgh4nte6NBZZ5Azv3jI4KCrnZHC15Rjz8WjVcEPAABi6mxw2I7s92DiDWAUxdiPGY
         d26nBnS4cspN/XwEIXZu6v44cnj1tH1jMSmL28Vum1rqvlmSPCzs0pXVElPsQoyaLxr1
         1/gHkih64z87KY9HtSY4RB1pcTxmYXWZMYGUu8YsolLOweDYrhp32cjw18LZePQef3Jb
         lQ31BHieNbfNwoVS+2z8uq6PKEGutvPPRIV8Gq/6GqQ/2uR8AnI0glPl2QM7A/i35kWw
         mY8amH5piKa3di1RrZ3BqDTPJyvYbRGmB3Q8n0lhX7p1Jgy8HIWK98HsrVKKNldnSwUl
         lHcg==
X-Forwarded-Encrypted: i=1; AJvYcCWvCbeLJRAo/ut7rgLscIiDYx0YlGMNLyeKzok1bnkSo+kmT4+ln3AsMmYdox7uY0ymr0tZIRpLFJzOYYpAAzU0Fa8s/yu8
X-Gm-Message-State: AOJu0Yz9KKnNOGB7IxW2v0hf2i3tstD7jKZj39NSTJsfp4Fx1asf1IqO
	N6gdA+p8229v5alHM+p7p9tjj1fRmO80NqCwUXdi5R8b3go/XtLQqsK5DaXDoA==
X-Google-Smtp-Source: AGHT+IFaSpHOaQG+6UeUCtVGRI/ILrUKTLrw9mZL+0TgADU5BA3XN+dK8zNwM9U3mMN6EkgRA6eSzw==
X-Received: by 2002:a05:622a:1650:b0:43a:f441:75ab with SMTP id d75a77b69052e-43fb0e64ca6mr342501cf.22.1716491715608;
        Thu, 23 May 2024 12:15:15 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e4a89b61dsm21219821cf.45.2024.05.23.12.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 12:15:15 -0700 (PDT)
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
Subject: [PATCH v10 2/8] ptp/vmware: Use VMware hypercall API
Date: Thu, 23 May 2024 12:14:40 -0700
Message-Id: <20240523191446.54695-3-alexey.makhalov@broadcom.com>
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
2.39.0


