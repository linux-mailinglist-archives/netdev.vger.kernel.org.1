Return-Path: <netdev+bounces-120344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D690C95900B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 23:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A071C21F0A
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 21:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4571F1C7B91;
	Tue, 20 Aug 2024 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRvtc80K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E421C7B6E
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724190993; cv=none; b=nGUKg5auH3GNAYPXW7SFrwTCX0bVSHUQB+zb7xS0zYUjda3Q7uTGjZ8beokpoElv38retsLQq6s5f+n2KuBGyEDgbj6f7G06d0apNmnmpszDFqNqEandwics3skq1T/9XqHlK9NzcQa8Hu0ikLiwDsFFvtFLD1RN5N/pFu9fb64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724190993; c=relaxed/simple;
	bh=+2RQnSPwcfiNm6wDwozdIESBZgkBc3OG6qciaOVbNQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdnssDs4/Bbdr0+z5u5p6/8NM/IXNIcemxetojOh/VxR2CJLGOshNE1aYw3pYk2irE6pj9myE1eLCVsj6FNiwm41Xiq4PlO3nTZok6X74taLE9iuXHECWLneBZa2S0jutgxspfVsACSVyPhe0rNxppsKds36z8oxWJgHf5yfABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRvtc80K; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724190992; x=1755726992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+2RQnSPwcfiNm6wDwozdIESBZgkBc3OG6qciaOVbNQA=;
  b=QRvtc80KrQzeXopUUSLADrflPOVoCSkh+NE2qBFZYDQEY/nQLoaYk71w
   IT4UML48b8nrZZWenGOWTUZ1VHSLYigyBjM1f/iYwZ0NAqK/Mdr0GLN5R
   7iozoUNTqSSZAee/R97qu5DXCm8hltyVTfNsoUIGVJpgXGMnlKBvKmEah
   +L94FRJkK0gfJorbCrrCRJ4FzffLVqJqNeVsWcDCuI3dFhRtjSyTMUYSo
   uE2oExVqQmqrefBlnrurgzgW2YCg1dM0NThBtbQDwAPiJ60bQkmrOSs2q
   AtbO547p+UB/sk1p51rjyy6xMZhcTK1u4lQ0OR0FfIXcSC4NMr8cduHi7
   g==;
X-CSE-ConnectionGUID: bskJ2bMzR7+SncqiRaCasw==
X-CSE-MsgGUID: PpPiJWJSSkCOcQtbXk5OeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="39979360"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="39979360"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 14:56:27 -0700
X-CSE-ConnectionGUID: vQjNn8odTE29jrqVrw+6RA==
X-CSE-MsgGUID: LKwWbPf8R4uekdoyIUQGKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="65833202"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 20 Aug 2024 14:56:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	ksundara@redhat.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net 4/4] ice: use internal pf id instead of function number
Date: Tue, 20 Aug 2024 14:56:18 -0700
Message-ID: <20240820215620.1245310-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240820215620.1245310-1-anthony.l.nguyen@intel.com>
References: <20240820215620.1245310-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Use always the same pf id in devlink port number. When doing
pass-through the PF to VM bus info func number can be any value.

Fixes: 2ae0aa4758b0 ("ice: Move devlink port to PF/VF struct")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Suggested-by: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/devlink_port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
index 00fed5a61d62..62ef8e2fb5f1 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
@@ -337,7 +337,7 @@ int ice_devlink_create_pf_port(struct ice_pf *pf)
 		return -EIO;
 
 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
-	attrs.phys.port_number = pf->hw.bus.func;
+	attrs.phys.port_number = pf->hw.pf_id;
 
 	/* As FW supports only port split options for whole device,
 	 * set port split options only for first PF.
@@ -455,7 +455,7 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
 		return -EINVAL;
 
 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_VF;
-	attrs.pci_vf.pf = pf->hw.bus.func;
+	attrs.pci_vf.pf = pf->hw.pf_id;
 	attrs.pci_vf.vf = vf->vf_id;
 
 	ice_devlink_set_switch_id(pf, &attrs.switch_id);
-- 
2.42.0


