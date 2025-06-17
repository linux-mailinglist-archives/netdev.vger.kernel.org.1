Return-Path: <netdev+bounces-198755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ED5ADDAA2
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 19:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506AC167514
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 17:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53508285067;
	Tue, 17 Jun 2025 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dy30LHsC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F8D23B600
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750181092; cv=none; b=SNlW+B2w6GnSfMbZyD4xy9OfnlXF1FPC7Gl+YYA9UwspKNFq6QjfFStQh6P1jeIgpd8wTDahiROnnjB/+mM/iCHImANi1lNddpnXdynjhrbvtzCDXgNQBGAetm63fDxXV9+ssZAfSSx9ca+GPY1wtUrzH4UskjFaq6eaFzuwsPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750181092; c=relaxed/simple;
	bh=j0QCNAuOJ5qCpjEv6bfW/2PceErQ7vqzE22Didog0yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJ6xbGd7S0jo7qcKOPly3ZF0tz0RBDo6u6itf4tvTob+RlVfjKgsMuh0rJq2e93QqQHCbDdeH9cgtDwHxN0494HLXqUgLHmQNAMmALMs9b8cgrinUphm5AVPs3reZD9JsDFG7kchse0Ri9X8B/aAzwGC6HRcibwFdNF68r1yV6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dy30LHsC; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750181091; x=1781717091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j0QCNAuOJ5qCpjEv6bfW/2PceErQ7vqzE22Didog0yg=;
  b=Dy30LHsCdsHPzXUjdgTgAlp2xW+v1kNoNaG06Ieyl8GQzLfMULKQ1EP1
   CMkv2HWlxckJcYg1Cn0j10DBg/Z9jbiZUtrmx4AouxUpTdrt5h0DOKsuw
   FCZbT11xXlaWCRaVgr6TwkxjsUnz71kWepuEJJLEPobG49QxPVs0Oi1Zq
   TPQp4zWC5bv7cVNQp7OUzjEXY23UQSY9vevo+czgWLmCcRcJYug9aWfbx
   1GsRDLBadTqM8RTHzJet6uKEN7REkIBW5z2G77U1RpNqv/rStramuZRvs
   r00sxB8vu6C7LyOZdEvRcUix2D3fwekzvMTMN5rl5FqcCDGS7Ih1TVmAz
   w==;
X-CSE-ConnectionGUID: 9vbauscDTZ6KT1/Zhq3jOg==
X-CSE-MsgGUID: rwLAfGGIR8ORXHd1DSXdEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="69820125"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="69820125"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 10:24:49 -0700
X-CSE-ConnectionGUID: Q2UREqV1Q/C8lRzFV1168A==
X-CSE-MsgGUID: cYGv7YoTQSqt9lX03Go3+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="152741172"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 17 Jun 2025 10:24:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 2/3] ice: fix eswitch code memory leak in reset scenario
Date: Tue, 17 Jun 2025 10:24:42 -0700
Message-ID: <20250617172444.1419560-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250617172444.1419560-1-anthony.l.nguyen@intel.com>
References: <20250617172444.1419560-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 6aae03771746..2e4f0969035f 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -508,10 +508,14 @@ ice_eswitch_attach(struct ice_pf *pf, struct ice_repr *repr, unsigned long *id)
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
 
-- 
2.47.1


