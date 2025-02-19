Return-Path: <netdev+bounces-167745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E50A3C01A
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 14:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1445C3A5A4E
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 13:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D581E0DFE;
	Wed, 19 Feb 2025 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+C92HNw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AB920B22
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972178; cv=none; b=k5QOEVkUti/zQrBzfr3Mu2du0vBP+E9alDr8JjnOwYg2+CJ56Vaws43sLfFiK/QoXepGyOg6twAOk7aCjLeduJTDyzSt3b8ofoLGkJ8N1dhulVfFm9AszJ0G3uGZJ+Fc7+pjFbzL8nhWhfQpw61rffZLVKR700NIxGiR8oALAmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972178; c=relaxed/simple;
	bh=LOKX4E6ujPutAZTVYfYNM95m76n5U1LtRGnhA3Kt6Io=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L3tIX2cCY8TOZUkzJ0Di0q/Uqoz29n+A90LAa0pj7JTMcPz0ALAfPTFC2uqj/sDJNBMorZOqUuMPQxN1weTE+20Q5oA12e7SGXOQs1m2GaaihHr1XBm6IfWMxvQrWXUX41CD3rPTbZNaPr692JAWBr5hCJbIEATCMv1rJ8jzbiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+C92HNw; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739972177; x=1771508177;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LOKX4E6ujPutAZTVYfYNM95m76n5U1LtRGnhA3Kt6Io=;
  b=a+C92HNwdO+V61rjBQNMbahvd+LD+DQCejRiNsuLIphv9OWoYib2jrjp
   kcCaxGLxMRcfOavP+6zjpy9xn8pKY5kmgV/0CFeRJcJy9prETyNaQo0ZF
   2qlmqIVdNL5zpAn5pmbPBmJEnM/Uz8tZt1PlIWy+3NK+FS1QguZwxn/bg
   Q0ix+PQ11toIug1k3+noHB0uErAeYWrdOspb6P3Pt69xkQScUriojJDZY
   xzqmXQEgeH8bAGvSr2a0Vge+7riK2EkkNcqy0goPeDKn0KQwu4mzZSQkR
   p4HKoa7ztwFz0AoGSyUGk59+Lb1ahoyDOKAYKB7la/aNs/VrKJ1YmCn/m
   g==;
X-CSE-ConnectionGUID: glXiEUvTTGq4HlI/hRZXLA==
X-CSE-MsgGUID: 7NUtPallR5aBVJKYlUDLxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44473946"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="44473946"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 05:36:15 -0800
X-CSE-ConnectionGUID: t0j7cc7wRBOnif+xEzOf/g==
X-CSE-MsgGUID: RUvCVmUdQ9GbQ/1js0djuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115236101"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2025 05:36:12 -0800
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 340B333EB6;
	Wed, 19 Feb 2025 13:36:11 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Konrad Knitter <konrad.knitter@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v1] ice: register devlink prior to creating health reporters
Date: Wed, 19 Feb 2025 14:30:39 +0100
Message-Id: <20250219133039.38895-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice_health_init() was introduced in the commit 2a82874a3b7b ("ice: add
Tx hang devlink health reporter"). The call to it should have been put
after ice_devlink_register(). It went unnoticed until next reporter by
Konrad, which recieves events from FW. FW is reporting all events, also
from prior driver load, and thus it is not unlikely to have something
at the very begining. And that results in a splat:
[   24.455950]  ? devlink_recover_notify.constprop.0+0x198/0x1b0
[   24.455973]  devlink_health_report+0x5d/0x2a0
[   24.455976]  ? __pfx_ice_health_status_lookup_compare+0x10/0x10 [ice]
[   24.456044]  ice_process_health_status_event+0x1b7/0x200 [ice]

Do the analogous thing for deinit patch.

Fixes: 85d6164ec56d ("ice: add fw and port health reporters")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Konrad Knitter <konrad.knitter@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
Konrad wonders if regions registration should too be moved prior
to devlink_register(). From net/devlink code it looks safe both ways,
and there is no documentation on what should be the registration order.
(But in the past some things were necessary to be prior to register).

CC: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
CC: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c3a0fb97c5ee..e13bd5a6cb6c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5065,16 +5065,16 @@ static int ice_init_devlink(struct ice_pf *pf)
 		return err;
 
 	ice_devlink_init_regions(pf);
-	ice_health_init(pf);
 	ice_devlink_register(pf);
+	ice_health_init(pf);
 
 	return 0;
 }
 
 static void ice_deinit_devlink(struct ice_pf *pf)
 {
-	ice_devlink_unregister(pf);
 	ice_health_deinit(pf);
+	ice_devlink_unregister(pf);
 	ice_devlink_destroy_regions(pf);
 	ice_devlink_unregister_params(pf);
 }
-- 
2.39.3


