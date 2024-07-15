Return-Path: <netdev+bounces-111463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6F693129C
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 12:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656A81F230F9
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 10:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2684F188CB8;
	Mon, 15 Jul 2024 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lMOgYdwi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7828C18411C
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 10:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721040652; cv=none; b=WH0UqWskF8bzOdLeVLcxbAT1mD1rGr9e5NTHzmD5M4lBK9rw/daRDQgCBffY8Fh0QPzFuNkMMwugNwQKdzZHHKHCpOS4MSGxrzYbpyN9yKB0XM19DqG2XwWXUuSl/W6f7RZP0p7MQnkqBW4H+Wp5xO5+SAjwnFCsApJA0smsunI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721040652; c=relaxed/simple;
	bh=X+n2EA+PpcwiVRODe8SXcZ/ebefjWKERhrirkSfG7uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZ2bUw//wtCNX0LayXQaoQU7oFEFZWwHniCjGXgoJ6RG0INidVGJnG00AdT/ppAvkiTyouWP6KMY9XlBUDK4tXpbTLTzZZhDX4Ol3fdTY9BBVJnuqmzyfDaYowZedRaQJh+/1YLNt7FnOVeOJOblrx3GfhsKGQKSz8t/wZgDCPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lMOgYdwi; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721040651; x=1752576651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X+n2EA+PpcwiVRODe8SXcZ/ebefjWKERhrirkSfG7uk=;
  b=lMOgYdwiviHYq0ekw9xzbufGM0bb99oPf96w4scUjX0ubl3rTkTF1Z6n
   uCXCYlbt0YhZzSUNS3El6RAhJNLzUKF/rxmAZmVhFCnbkVXRBVC8FpLF7
   DO6E4T15ZhIQdiPDfLom0HRoVNHXD1Dp9vSeFdq8mtWZff2wRwKzpP4+N
   iZkfS3Z0lB1HlDuhL3gesnSD+Ol33Jp70fMxOVctcZon0ieVcKkDke5wJ
   Ocgpj2nRns1UrM/jHhSI4MawlcnZLsIldtyjqzpNr3BhxXAV69gtlBJvD
   BIBVATreWkDEzpyOaQKtY2NU3b+49kTNR/ucX7iOmCV7AtP0l53zhSizP
   w==;
X-CSE-ConnectionGUID: mrPApUOTRFmh2wNwwT56WA==
X-CSE-MsgGUID: 03EIUMcGQRi0JpAdS9l5/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="18609046"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="18609046"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 03:50:23 -0700
X-CSE-ConnectionGUID: 64AKA/R5RvWUq4G7tf1YtQ==
X-CSE-MsgGUID: Cf9nDKKQS6mp6IT4vZkPcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="49545174"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by fmviesa009.fm.intel.com with ESMTP; 15 Jul 2024 03:50:21 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v1 2/2] ice: Skip PTP HW writes during PTP reset procedure
Date: Mon, 15 Jul 2024 12:48:45 +0200
Message-ID: <20240715104845.51419-3-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240715104845.51419-1-sergey.temerkhanov@intel.com>
References: <20240715104845.51419-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

Block HW write access for the driver while the device is in reset to
avoid potential race condition and access to the PTP HW in
non-nominal state which could lead to undesired effects

Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Fixes: 4aad5335969f ("ice: add individual interrupt allocation")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 85b19e94e2ed..1f365bd6f525 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1420,6 +1420,10 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
 	/* Update cached link status for this port immediately */
 	ptp_port->link_up = linkup;
 
+	/* Skip HW writes if reset is in progress */
+	if (pf->hw.reset_ongoing)
+		return;
+
 	switch (ice_get_phy_model(hw)) {
 	case ICE_PHY_E810:
 		/* Do not reconfigure E810 PHY */
-- 
2.43.0


