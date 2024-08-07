Return-Path: <netdev+bounces-116621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 529BE94B337
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 00:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45B2283961
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 22:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2195C155A4E;
	Wed,  7 Aug 2024 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qo/Cf/SQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DD8155731
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723070731; cv=none; b=hqThBbxM0kKKc5CejVmgFYoDv87UC5gnsu1mKOopKK3fJZjAvul7JNpDdMLHbLZ2oYRSW1r+dno0W42MSYIvs4F9j5iX0sdmmwPyWZugdnqoMhBVQXdiyQFdspyZe6pJ0s7iZiwkF/3wEArS/ZBl9d7GxFu1YHPSlljMHD+V3Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723070731; c=relaxed/simple;
	bh=hlwZhIMz6OecyfysiaO+zZ3EBLz/1il4ZoMK5zb8UkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQVEwpvHisg7MASeS7ekaGEWBBxj5/y9cayI4n7slk3GSXY80APGwO83Sqyh96JMws4PZE77g0jJbZHDn6hadF40yKC39uz496K9W0Tksv4z4Z7Kwd/00K9b/lbMdhCCGqbHhKb5IFEOE3VvaTkBbQbackLh4iAryWPI1xfUkFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qo/Cf/SQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723070730; x=1754606730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hlwZhIMz6OecyfysiaO+zZ3EBLz/1il4ZoMK5zb8UkI=;
  b=Qo/Cf/SQFNtNmBgbvSZVArp09ODpnugUKpsjVCI6plkKhHK9jVVil6lm
   GKM2RS9qjJbY9ZVb8IrEFWvf48gBWFQQVjivdBRPHJzrklFWrKU6VRfq/
   zQuujWw2v66YPQSDGxCBVJwm2+LmEHY1Uf9uKu0u3X3UOEyv/rwqy7dv8
   7LDUOEmg8D5OmFmp2AEKlG3/GiYKXencQIIoIOz6IAiQo4DeyB4m9Pzm0
   fznwU+8tAOLUhbqYwkraC2CvdCwwhfX2Ea82VN04umOI2A3jmlkkjo21s
   gKiZPNf2HAvzZX3iGCjqB/Mrm2y7N9xqIPPYWoMl4UVXopxYYu2fg7w6m
   Q==;
X-CSE-ConnectionGUID: qDx6IHQjRtO9O6InyelhzA==
X-CSE-MsgGUID: XvC04ZlrQE+aDZBMN3HNGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32573963"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="32573963"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 15:45:28 -0700
X-CSE-ConnectionGUID: lTwIQudYS++l0ScBs1We5g==
X-CSE-MsgGUID: B5PWR/BzSYejrxCbqkb/9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="57088292"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 07 Aug 2024 15:45:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 2/3] ice: Skip PTP HW writes during PTP reset procedure
Date: Wed,  7 Aug 2024 15:45:19 -0700
Message-ID: <20240807224521.3819189-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240807224521.3819189-1-anthony.l.nguyen@intel.com>
References: <20240807224521.3819189-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

Block HW write access for the driver while the device is in reset to
avoid potential race condition and access to the PTP HW in
non-nominal state which could lead to undesired effects

Fixes: 4aad5335969f ("ice: add individual interrupt allocation")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index e2786cc13286..ef2e858f49bb 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1477,6 +1477,10 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
 	/* Update cached link status for this port immediately */
 	ptp_port->link_up = linkup;
 
+	/* Skip HW writes if reset is in progress */
+	if (pf->hw.reset_ongoing)
+		return;
+
 	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E810:
 		/* Do not reconfigure E810 PHY */
-- 
2.42.0


