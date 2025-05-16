Return-Path: <netdev+bounces-191040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69C8AB9CFB
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 15:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4130617D5E2
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 13:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D7F241CBA;
	Fri, 16 May 2025 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRClxAp2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B977223C505
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747401050; cv=none; b=b5Ph1yc+PkjSrlDJrlkFQ77bzcJ6BajvD55xVZyZbhOlp8ojBIKDP7phjF6tTmdv7qn4353X0UV183Vymek7HSYbLb6iPm0ks8AV14Q9FSKNneNf7dHTeRAhNOXcATIiClOjrsWDWQFNelYv5Pyz1Z2j+GA1gEgG4REmtowg55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747401050; c=relaxed/simple;
	bh=K9h2+0CIeLWJk6m9Bp2dv674EF0JQkEXZ3KQr4daZpo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hEFrmU0AzY8oSRV3Z+NiPyQgVwQsOUVx/FS5Go8LRn6X4QZgUEmDTNtJ3Opa7uPCetyK9ScZat+ZEaJytEa9agex2kBMSgf9lJ6VVGb5mpEzvXIfaO33xpa6Nlu+S7J2e0obNcQWeu9nWIQLZd/naINb8J8kR468BKzJLI5izwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRClxAp2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747401049; x=1778937049;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K9h2+0CIeLWJk6m9Bp2dv674EF0JQkEXZ3KQr4daZpo=;
  b=nRClxAp2iPnW4e63huM7eE3WfAw9FMwd39SBH+801dguGtzHXj8/tohQ
   l4GLA+5Fa/Is21USOtjBHh9nuGy04w/bBw6ayHnnkbImyXVqabzhX4NJx
   LbztT4F5wKBWbhjrCBpN2vgVZDm3qniplzQ7RtM2NMGAE8BF8voSSzqj5
   BDJGUb8bn6iORM5XL9fdTYcGdnCAtz+hWUAWz1EA1+9VNRxPTXsluqdYx
   ZO7HD25Cy1gp6Jb1zxUkCzJH0eFkpQXsPOakp5pAaNqyAvwQFA3wft0YA
   CsV02oa5Jcu/4yJ2dnqZXqV7RtJZiMV728qZAH5KrKRnzmefblpKdVnsk
   w==;
X-CSE-ConnectionGUID: VV0oWVncSFigyW/zzOMoeQ==
X-CSE-MsgGUID: T6OpHTMvR/uWPq4hfUCWNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="66924684"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="66924684"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 06:10:48 -0700
X-CSE-ConnectionGUID: CitHtpdfS0yJpTUsuJWDSQ==
X-CSE-MsgGUID: 5kIM4BIiSmyKzK+j2tETaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="169735672"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by fmviesa001.fm.intel.com with ESMTP; 16 May 2025 06:10:47 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v2] ice: fix eswitch code memory leak in reset scenario
Date: Fri, 16 May 2025 15:09:07 +0200
Message-Id: <20250516130907.3503623-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add simple eswitch mode checker in attaching VF procedure and allocate
required port representor memory structures only in switchdev mode.
The reset flows triggers VF (if present) detach/attach procedure.
It might involve VF port representor(s) re-creation if the device is
configured is switchdev mode (not legacy one).
The memory was blindly allocated in current implementation,
regardless of the mode and not freed if in legacy mode.

Kmemeleak trace:
unreferenced object (percpu) 0x7e3bce5b888458 (size 40):
  comm "bash", pid 1784, jiffies 4295743894
  hex dump (first 32 bytes on cpu 45):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    pcpu_alloc_noprof+0x4c4/0x7c0
    ice_repr_create+0x66/0x130 [ice]
    ice_repr_create_vf+0x22/0x70 [ice]
    ice_eswitch_attach_vf+0x1b/0xa0 [ice]
    ice_reset_all_vfs+0x1dd/0x2f0 [ice]
    ice_pci_err_resume+0x3b/0xb0 [ice]
    pci_reset_function+0x8f/0x120
    reset_store+0x56/0xa0
    kernfs_fop_write_iter+0x120/0x1b0
    vfs_write+0x31c/0x430
    ksys_write+0x61/0xd0
    do_syscall_64+0x5b/0x180
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

Testing hints (ethX is PF netdev):
- create at least one VF
    echo 1 > /sys/class/net/ethX/device/sriov_numvfs
- trigger the reset
    echo 1 > /sys/class/net/ethX/device/reset

Fixes: 415db8399d06 ("ice: make representor code generic")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---

v1->v2: rebase, adding netdev mailing list

---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index ed21d7f55ac1..5b9a7ee278f1 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -502,10 +502,14 @@ ice_eswitch_attach(struct ice_pf *pf, struct ice_repr *repr, unsigned long *id)
  */
 int ice_eswitch_attach_vf(struct ice_pf *pf, struct ice_vf *vf)
 {
-	struct ice_repr *repr = ice_repr_create_vf(vf);
 	struct devlink *devlink = priv_to_devlink(pf);
+	struct ice_repr *repr;
 	int err;
 
+	if (!ice_is_eswitch_mode_switchdev(pf))
+		return 0;
+
+	repr = ice_repr_create_vf(vf);
 	if (IS_ERR(repr))
 		return PTR_ERR(repr);
 

base-commit: 2ac71b085957eb2c674e1c57107a7f0f22d2311e
-- 
2.39.3


