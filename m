Return-Path: <netdev+bounces-78531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBA587593F
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 22:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A201F2458A
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 21:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052DB13B79F;
	Thu,  7 Mar 2024 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cnKPdaBG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5AE13B78F
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709846999; cv=none; b=bTDt/5xQdcVspwku6eGpE9zVzo2UhsfwlLem0Dj5B1Y5553qq5W45vrnv94zQEbOiNXt0uk6xLkuodDdGCJr/CyhVNwIMNRCgwJcCBaYdcKwwdLEgKReVO4SUOwXqRL3I6tNYxOApPfJ/J9CjwPE9ExwM8tnIRFpwDYYc9jCPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709846999; c=relaxed/simple;
	bh=sUZxtGNHFx4zLodxUdWUhxGzSh51kPJIzM5f+5HerXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lQGapol8WQ9R8eifXpb+49c49ucTx6wgQsjB9743ZmbGXTWOF2FqC2dRpEN4WvVW/uRirsTv21tA39KhVux7EgfQcKJie/tgisNDP4tbWpOc/TOiFCB1uBsieNg587anDgpSdtv8aTNpIMOcgkEHNI0jJNhpTz8wMUUchxNAzLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cnKPdaBG; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29b7164eef6so159209a91.2
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 13:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709846997; x=1710451797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+YZLpG094wphSKZXLLG7LA5wMsC4o/YJbeoOf2hZChI=;
        b=cnKPdaBGegPp5BJwBrCzKS/yjHJL+AyfEgciWTVR+NexL5lmQabES6W9rHdHJDY2+F
         nc4aOWgUnhAkrD9ZPitvsN/zQJ06h4XEbt/jGZc+grTlFLcjmyzhT/zBe/JfF1heAlXg
         emPr6JKJu/UxgU1LFFt7dbtRQJR/YdzV7R9Zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709846997; x=1710451797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YZLpG094wphSKZXLLG7LA5wMsC4o/YJbeoOf2hZChI=;
        b=hZIFJ30J/jal7jfgQ1AAhRyo9HS3AzXkFdeZ7HLGK3dYQX+Qv+RYBxpi57LzRFKmhk
         JNZRb3fZmdeXnmgdmdy5oGraegaFjKNu5mCOHtqYIqUzOSMLvAZkOwPZEwzCv3MJ0orl
         bNILV+CpWLmm6+MUU6BK+h77Ai/1w4kecQQSwx/6s8ucvWh+lvFLvdxKD1x9l8oz16xV
         FKEgmqFUyAC0tm0mP2Qju2vPcmkLXNCmrpCyuQH1238YVHT6f6d1rbjkkpfbiwYBvQ4c
         klokJsfXQqjbY058tDQLacU/24FrPng0vHJVKyQAkGc880IgM0kum9CKra7dtj+9Q2EO
         lA6A==
X-Forwarded-Encrypted: i=1; AJvYcCUnnjolaVu5OF74/0uVQtYEdApfM4RKI0PTj417/Dls3AxuQHLQ8oIhCEZUbrTUuoRwZl/Db+697Jdm7tetbecsuy5ayKSt
X-Gm-Message-State: AOJu0YxVU4XTSjl3/t0i35ZCcAijkRDAMZpKd2eMGannP8NoJ8Qnq6L8
	5dDIsKT6C4vzWON3E+PTUdELkZ/zMansQuJSsESjGMsPxRcCKtYIi5BDSNa5/g==
X-Google-Smtp-Source: AGHT+IEzz+bckUTxMNcu0RwZK0XnBSiwtoTYqhjpphfi8E+fSD4mV1nsz9A9Yr4VpADTNeEUBC8JoQ==
X-Received: by 2002:a17:90a:a606:b0:29a:a3a6:dde7 with SMTP id c6-20020a17090aa60600b0029aa3a6dde7mr17873626pjq.18.1709846997354;
        Thu, 07 Mar 2024 13:29:57 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([64.186.27.43])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090abd0c00b00299db19a81asm1991021pjr.56.2024.03.07.13.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 13:29:57 -0800 (PST)
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
Subject: [PATCH v7 0/7] VMware hypercalls enhancements
Date: Thu,  7 Mar 2024 13:29:42 -0800
Message-Id: <20240307212949.4166120-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
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

Second patch introduces the vmware_hypercall low and high bandwidth
families of functions, with little enhancements there.
Sixth patch adds tdx hypercall support

arm64 implementation of vmware_hypercalls is in drivers/gpu/drm/
vmwgfx/vmwgfx_msg_arm64.h and going to be moved to arch/arm64 with
a separate patchset with the introduction of VMware Linux guest
support for arm64.

No functional changes in drivers/input/mouse/vmmouse.c and
drivers/ptp/ptp_vmw.c

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

Alexey Makhalov (7):
  x86/vmware: Move common macros to vmware.h
  x86/vmware: Introduce VMware hypercall API
  ptp/vmware: Use VMware hypercall API
  input/vmmouse: Use VMware hypercall API
  drm/vmwgfx: Use VMware hypercall API
  x86/vmware: Undefine VMWARE_HYPERCALL
  x86/vmware: Add TDX hypercall support

 arch/x86/include/asm/vmware.h             | 331 +++++++++++++++++++---
 arch/x86/kernel/cpu/vmware.c              | 144 +++++-----
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c       | 173 ++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h | 197 +++++++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h   | 185 ------------
 drivers/input/mouse/vmmouse.c             |  76 ++---
 drivers/ptp/ptp_vmw.c                     |  12 +-
 7 files changed, 593 insertions(+), 525 deletions(-)

-- 
2.39.0


