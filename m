Return-Path: <netdev+bounces-103370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11641907C2C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 21:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62B6DB23BC2
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 19:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3DD14D6E6;
	Thu, 13 Jun 2024 19:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XtGa5DO3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCF514D29A
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306232; cv=none; b=PB/jjDDet13FuOOVutXxy2ylEeJgqqxG/NQD2tci9o6myPrMai12YYVNa3W3kL4a2vhkB6bkNsSw8/q4vaAP2go63OSmz3Bp2g602w0oQ/00Az/vRDBOY7Wqz0w1gapZCcAUXbt8oCE13e5kRZP2JSNK6KfLeL3ZHuUio1IHRQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306232; c=relaxed/simple;
	bh=CrA2LbZw2fj1oZQlxW6cbBwREuI1pwVFNKXdbbVw6aE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hiW+yzXqJvxzevGpuJZ3e0ufSEXwzal4DKeTSKyqq9QIUczPfuHFZWcNxH8n1vwwNkqpBY2rgfARG+s44JsDD4vXV5AI4rwD80lDmGlttqtDo3ThOC/MQ2V5DoORdGlctS5ZNgXjaCfczbhJdH/MFTS3e2mnwRrpcRdrxNsQJh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XtGa5DO3; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b06b78e716so9257696d6.3
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 12:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718306230; x=1718911030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SqRZVCpbYo2jtcU4VLLPgUkKEV8z0zarA1K4gBzGSZs=;
        b=XtGa5DO39owFRgz7eiFLh0BKcx+ZaoAoM0nazFe9979KkIrj2TS33fQOBeBFWkt3Us
         Q4yHnPiKUmHx4iVAolspZgZwAlJ3KyZcy2HN6ng8IRO9ORy3IKXllSZST8ROGxwtywBk
         dIgcjokRQ0mzaajlLTvC/0kBhAhv8r4+zwp1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718306230; x=1718911030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SqRZVCpbYo2jtcU4VLLPgUkKEV8z0zarA1K4gBzGSZs=;
        b=ozVVMi4NP9cZc5mkYXHtE1nrE4OxakyfNBLJCANlaQFjMVWVWVHALqNfvpJVoiR6fD
         NtQMZdFmXsUmgJ8FT6l/yAjifoJL6I2y8VRdUc4vhjmaS8iOa5C0EVqdB6H1lxcmo3Rs
         8BIzH2gJoFKvLaQr60nfNU6IyoBPHUO75lay4/z4lfwN1wfBkbmN38jD1LlMAECCBpIq
         nsL4X0PoeP8GaWDwsN3b/vlM16ZR6+Rx4LQLv17vr/BWHh2fxypzDd6SVXKMoIV2CEjb
         F4YrwNG6BfTm4sr9EBms6eXrjEVUsQhUwCiwktQ/m3njE5CoeqCTul9fcVuNPcuN1mf4
         COwA==
X-Forwarded-Encrypted: i=1; AJvYcCWS0QRsVpBh5ZykRhCDVqecayKva1mmIWSQ6uApbMK5k0WOeXbojuS3rcKeNkcPUoW/PHgQp9m+/UAP+2A/kaTHJQ5E4vuN
X-Gm-Message-State: AOJu0YwlhhlArqrPVNbC2VLXzNqAIxbuey4pQmpwH+0D6os4pCPV8FMM
	al8Ik0F50mY8KG7ay+gC7NHfO0T+4KLs2PpcATUwEvYMavMwn0JEfkYr8C4lYA==
X-Google-Smtp-Source: AGHT+IFjEHPK4k0l7eyVsilK8yUQTNHgIqYDnv7SJ1An/1VqFCPEcRK7LH9vCsjmYZUTW3mQYOd55w==
X-Received: by 2002:a0c:f882:0:b0:6b0:839e:ba6b with SMTP id 6a1803df08f44-6b2afd5f040mr5356876d6.43.1718306229909;
        Thu, 13 Jun 2024 12:17:09 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb47f6sm9714106d6.82.2024.06.13.12.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:17:09 -0700 (PDT)
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
Subject: [PATCH v11 0/8] VMware hypercalls enhancements
Date: Thu, 13 Jun 2024 12:16:42 -0700
Message-Id: <20240613191650.9913-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMware hypercalls invocations were all spread out across the kernel
implementing same ABI as in-place asm-inline. With encrypted memory
and confidential computing it became harder to maintain every changes
in these hypercall implementations.

Intention of this patchset is to introduce arch independent VMware
hypercall API layer other subsystems such as device drivers can call
to, while hiding architecture specific implementation behind.

First patch introduces the vmware_hypercall low and high bandwidth
families of functions, with little enhancements there. And the last
patch adds tdx hypercall support

arm64 implementation of vmware_hypercalls is in drivers/gpu/drm/
vmwgfx/vmwgfx_msg_arm64.h and going to be moved to arch/arm64 with
a separate patchset with the introduction of VMware Linux guest
support for arm64.

No functional changes in drivers/input/mouse/vmmouse.c and
drivers/ptp/ptp_vmw.c

v10->v11 changes:
- Redesign VMware hypercall asm inline. Move slow path to a separate function
  keeping asm inline alternative small a simple. Suggested by Borislav Petkov.
- Use existing _ASM_BP instead of introduction of VMW_BP_REG as was suggested
  by Uros Bizjak.
- Patch 6: add "Fixes" tag as was suggested by Markus Elfring. 

v9->v10 changes:
- Restructure the patchset as was suggested by Borislav Petkov to
  introduce vmware_hypercalls API first, then move callers to use this
  API, and then remove the old mechanism.  
- Reduce alternative portion of VMWARE_HYPERCALL by moving common code
  outside of alternative block. Suggested by Borislav Petkov.
- Use u32 instead of uint32_t in vmware_hypercall API and across vmware.c
  as was suggested by Simon Horman.
- Remove previous Reviewed-by and Acked-by.
- Fix typos in comments and commit descriptions.
- No major changes in patches 2,3,4,8 compare to v9.

v8->v9 change:
First patch "x86/vmware: Move common macros to vmware.h" was split on 2 pieces:
  "x86/vmware: Move common macros to vmware.h" - just code movement, and
  "x86/vmware: Correct macro names" - macro renaming.

v7->v8 no functional changes. Updated authors and reviewers emails to
@broadcom.com

v6->v7 changes (only in patch 7):
- Addressed comments from H. Peter Anvin:
  1. Removed vmware_tdx_hypercall_args(), moved args handling inside
     vmware_tdx_hypercall().
  2. Added pr_warn_once() for !hypervisor_is_type(X86_HYPER_VMWARE) case.
- Added ack by Dave Hansen.

v5->v6 change:
- Added ack by Kirill A. Shutemov in patch 7. 

v4->v5 changes:
  [patch 2]:
- Fixed the problem reported by Simon Horman where build fails after
  patch 2 application. Do not undefine VMWARE_HYPERCALL for now, and
  update vmwgfx, vmmouse and ptp_vmw code for new VMWARE_HYPERCALL macro.
- Introduce new patch 6 to undefine VMWARE_HYPERCALL, which is safe to do
  after patches 3 to 5.
- [patch 7 (former patch 6)]: Add missing r15 (CPL) initialization.

v3->v4 changes: (no functional changes in patches 1-5)
  [patch 2]:
- Added the comment with VMware hypercall ABI description.
  [patch 6]:
- vmware_tdx_hypercall_args remove in6/out6 arguments as excessive.
- vmware_tdx_hypercall return ULONG_MAX on error to mimic bad hypercall
  command error from the hypervisor.
- Replaced pr_warn by pr_warn_once as pointed by Kirill Shutemov.
- Fixed the warning reported by Intel's kernel test robot.
- Added the comment describing VMware TDX hypercall ABI.

v2->v3 changes: (no functional changes in patches 1-5)
- Improved commit message in patches 1, 2 and 5 as was suggested by
  Borislav Petkov.
- To address Dave Hansen's concern, patch 6 was reorganized to avoid
  exporting bare __tdx_hypercall and to make exported vmware_tdx_hypercall
  VMWare guest specific.

v1->v2 changes (no functional changes):
- Improved commit message in patches 2 and 5.
- Added Reviewed-by for all patches.
- Added Ack from Dmitry Torokhov in patch 4. No fixes regarding reported
  by Simon Horman gcc error in this patch.

Alexey Makhalov (8):
  x86/vmware: Introduce VMware hypercall API
  ptp/vmware: Use VMware hypercall API
  input/vmmouse: Use VMware hypercall API
  drm/vmwgfx: Use VMware hypercall API
  x86/vmware: Use VMware hypercall API
  x86/vmware: Correct macro names
  x86/vmware: Remove legacy VMWARE_HYPERCALL* macros
  x86/vmware: Add TDX hypercall support

 arch/x86/include/asm/vmware.h             | 336 +++++++++++++++++++---
 arch/x86/kernel/cpu/vmware.c              | 212 ++++++++------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c       | 173 ++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h | 196 +++++++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h   | 185 ------------
 drivers/input/mouse/vmmouse.c             |  76 ++---
 drivers/ptp/ptp_vmw.c                     |  12 +-
 7 files changed, 654 insertions(+), 536 deletions(-)

-- 
2.39.4


