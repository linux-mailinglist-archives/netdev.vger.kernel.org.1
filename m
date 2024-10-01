Return-Path: <netdev+bounces-131029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4090B98C69C
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27F11F21C54
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4125D1CEAB5;
	Tue,  1 Oct 2024 20:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZf7fuVh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3331CCB5E
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 20:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813837; cv=none; b=o5N4o3nWYBcdp8lddcA4CO/ZAWL81MlaVvtmcMIT7EO9CZLEj3jaksx1KrV47XCPj1V1qYXdyYwfPR1XtrIYtrsI8src+lWND6HU5Ah+l1PjCCI0ZZhW2RKWQldccy0W6FkDBZq5VqWexhbe/5eRluxnpZXa7r0gHW/lC66YW4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813837; c=relaxed/simple;
	bh=l6rNRRulIw24n5tcRd/d+5ojsgTOYyFSVzfbAW267LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuSRYWNVMIJck48j1gc4mbOJ6nuC6iVwqWQG/ShEbs1Vz5Dp+KZ2ANJzNhHeCTJgBChuhUhPgk+keGU57Yj+4x88RhZKCCKiSPRbValYT9EmruurxkdP5xivWPAjTX3N0W3Z02slCQXKXa5cWg+3+xuU7r61a6VOWoBFky6v2KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZf7fuVh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727813835; x=1759349835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l6rNRRulIw24n5tcRd/d+5ojsgTOYyFSVzfbAW267LA=;
  b=hZf7fuVhxJKwX4CXS63rIH4ineW79olq+5RMsQ6OxYe+l0DfDo5K3zjh
   ZwVxm3CzQ1lsvflwKd7kHwRVKTHyrdBiYihwzfyMLGLNFkWACAbkubugh
   y8Q7+mgr9gwatnh+rZd+Es/oOPYF6OXdsYcXnRtGpHcqI3J5CkjQ852QP
   1OTulWox2YHIDCCVwRiUd+WJO6oZVabI0kMDTGx/3rm4ctN3Ma7Uix61d
   taJKpGBG1YUOLpLaT1TiqKwYCJ9ulBrBEG8zolbYWq2XNU7mz68Lq7qwQ
   Cd7zoozAQYj3vg023Iukaq6oOe81fqJ+AVZ6mXReZvG4+p7LXuvixaLuf
   g==;
X-CSE-ConnectionGUID: n9OGm/80QG+gAbkvT+9Mhw==
X-CSE-MsgGUID: ALB+CDudQ4qJgxqaLSGAZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27063059"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="27063059"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 13:17:13 -0700
X-CSE-ConnectionGUID: g7V3PPdLQ/y/CbmGfRwPew==
X-CSE-MsgGUID: zlCggxVHTqGZHqx4hRCcqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="73761844"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 01 Oct 2024 13:17:13 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 02/12] ice: Add SDPs support for E825C
Date: Tue,  1 Oct 2024 13:16:49 -0700
Message-ID: <20241001201702.3252954-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241001201702.3252954-1-anthony.l.nguyen@intel.com>
References: <20241001201702.3252954-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Add support of PTP SDPs (Software Definable Pins) for E825C products.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 34ce1a160f73..9879a6f2150d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -20,6 +20,16 @@ static const struct ice_ptp_pin_desc ice_pin_desc_e82x[] = {
 	{  ONE_PPS,   { -1,  5 }},
 };
 
+static const struct ice_ptp_pin_desc ice_pin_desc_e825c[] = {
+	/* name,        gpio */
+	{  SDP0,      {  0,  0 }},
+	{  SDP1,      {  1,  1 }},
+	{  SDP2,      {  2,  2 }},
+	{  SDP3,      {  3,  3 }},
+	{  TIME_SYNC, {  4, -1 }},
+	{  ONE_PPS,   { -1,  5 }},
+};
+
 static const struct ice_ptp_pin_desc ice_pin_desc_e810[] = {
 	/* name,      gpio */
 	{  SDP0,    {  0, 0 }},
@@ -2605,8 +2615,14 @@ static void ice_ptp_set_funcs_e82x(struct ice_pf *pf)
 #endif /* CONFIG_ICE_HWTS */
 	pf->ptp.info.enable = ice_ptp_gpio_enable;
 	pf->ptp.info.verify = ice_verify_pin;
-	pf->ptp.ice_pin_desc = ice_pin_desc_e82x;
-	pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e82x);
+
+	if (ice_is_e825c(&pf->hw)) {
+		pf->ptp.ice_pin_desc = ice_pin_desc_e825c;
+		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e825c);
+	} else {
+		pf->ptp.ice_pin_desc = ice_pin_desc_e82x;
+		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e82x);
+	}
 	ice_ptp_setup_pin_cfg(pf);
 }
 
-- 
2.42.0


