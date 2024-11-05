Return-Path: <netdev+bounces-142116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555E59BD87B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 23:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878C01C22174
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B7A216DF1;
	Tue,  5 Nov 2024 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I97rHVTi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE14216A2D
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845447; cv=none; b=kSzu+Cwu8ZunTabgM4VcfVd0lFEqdfPi2ERG3A+ZsmEsLgh0L2tbbPpLODC3VAB3K3XKiKzZkegzGzIRaWnjMuKp+V+MqQ27uMlGLDXVk85312a5Yxd4DJRdiLtpL7i6EJ4PYiqEyl9xxh4OF1pUfYfsJ9GtKpcIdaFlT4zIkRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845447; c=relaxed/simple;
	bh=l3wyZGN8w190j59De4pzjx7iuqm3VdnmhJgTb9hg9vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6kApY0HqPurnJAIAM5Hobfgaw73V4W4wBlyIbX6npLvwgtsu/eQpgWQSr59aaTv5rSOyn2zoAZlsBmgBawL0bOKJ7cbqWCJTBAnb+ql+ZJbzjKNqSMisoOFfM+ytUfiq6vbrwvvaVF8DiSK1CT6K8O06eB6Gm+46Ng3mmSEcog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I97rHVTi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730845446; x=1762381446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l3wyZGN8w190j59De4pzjx7iuqm3VdnmhJgTb9hg9vM=;
  b=I97rHVTikygj30WfPbNgRJFsObS8XaqLSRYo3nZnPJm3qf5aOl5b/cvw
   bofLQ6AbWE6iwO0e3J4ds0GDHZRBmywrJslxlkxbFzzMi67Y7VCFhjoh/
   +TVhM1h6qD7mqNiAGu24CiFySwmC+J3IjQfA4MKo+90uZlrHiYH6GiY5r
   clKrnEQBMGvYEGyZLnA2a+Fe0H70NzbSTKlwo7FbQKkwhYRT83peF8KAC
   l/oQwgHdkYLAcC+WvVV8cEdhWvS2N/+zpGP2X5MTF8mlkdHsVyMV6geW8
   NZo02i6NZOXboHCTW4GMi8YxDsfN1psUiNt0UdfnheMntiaAaL9S2niup
   A==;
X-CSE-ConnectionGUID: 50tPS16ET1SHsLU4Fzij4w==
X-CSE-MsgGUID: 7VFakvweTtyUKyXXYNqXwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34314308"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34314308"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 14:24:01 -0800
X-CSE-ConnectionGUID: I9/VhCT+Tpawv9DOBw1arA==
X-CSE-MsgGUID: CHA+Z2pdQR2WNLBMRdk/xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="84322463"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 05 Nov 2024 14:24:01 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	larysa.zaremba@intel.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 10/15] ice: Unbind the workqueue
Date: Tue,  5 Nov 2024 14:23:44 -0800
Message-ID: <20241105222351.3320587-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
References: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

The ice workqueue doesn't seem to rely on any CPU locality and should
therefore be able to run on any CPU. In practice this is already
happening through the unbound ice_service_timer that may fire anywhere
and queue the workqueue accordingly to any CPU.

Make this official so that the ice workqueue is only ever queued to
housekeeping CPUs on nohz_full.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index db463793d870..e3c3ab5ae4b9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5937,7 +5937,7 @@ static int __init ice_module_init(void)
 
 	ice_adv_lnk_speed_maps_init();
 
-	ice_wq = alloc_workqueue("%s", 0, 0, KBUILD_MODNAME);
+	ice_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, KBUILD_MODNAME);
 	if (!ice_wq) {
 		pr_err("Failed to create workqueue\n");
 		return status;
-- 
2.42.0


