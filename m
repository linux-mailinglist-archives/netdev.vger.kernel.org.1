Return-Path: <netdev+bounces-119572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9FF95643A
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542FE2831BA
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4747155C83;
	Mon, 19 Aug 2024 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezFZtJNU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CB513BC1E
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051866; cv=none; b=KEA5Uf4Pp0cwWcvusg8HbMfTm2aWy6nzYDZVY02gJ4UtpzOZUJtfyxVzbdX34YUg4xL1EP9RfmlV2u2jYjHasrGRZaBDaylShM9cQhfOOryGy9EciWFZF+PWLdeL1lzIvQKU/QsWke0Oc504W7H3xzz7wjNL2ocV8On9Oq2ruxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051866; c=relaxed/simple;
	bh=GnBbpLrpo3GHH9Xx3F9zW+M9BMKqkCS1K4pDl7x37HU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Br9Duo7F5PKBG6EBVxHpHq4Pe+T+ZVrOVNN1DCSOYxXDk8Gamsa1O0ZozswcTwCIRU+3/0ij3qJsW4F/YRf44C5LJTzl71TWaaFJDEPGoQ57xn20HSAuwq6liMwGEWbJSBMBT4CmP1HDpX3kcicN4h1aPVjtYtZf9jX1fJB5H3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezFZtJNU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724051865; x=1755587865;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GnBbpLrpo3GHH9Xx3F9zW+M9BMKqkCS1K4pDl7x37HU=;
  b=ezFZtJNUdZxQsjR7l8ZNnckfWNXS1uzBNBuLBZ/eP1XsA6CgQJezvP2T
   jScAMbqZ9/UgpHQzJ/2QBwT76VgbgOX15zYuWUcSNpSZ6pQrlyKP9A3W9
   pPBZuNFtOcf+1nc2heV0orCFg0pBZbaqk1e6SKD3uXtcPMnXsgjTBx839
   IDvejYiqTXB39nCaGX5Vd78tMHz/w1Br61vBl9XV8h78cmVUS4Z3Yt2/H
   qgOOBlg1cxKPqJSJ8W16lc/e9zF+A1t53WsFQ6wNqvvFI2LYSx6gAw2Wx
   lnNUlPxLdtZH1AXzcXmzfIiLqFSZ/v/ileypd+kOcEr+oQQWkvAWvas/Y
   Q==;
X-CSE-ConnectionGUID: +gQProc1Suadu7UpKkgepQ==
X-CSE-MsgGUID: 1Zj3BSljRBGRwwrkNyaDXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="33697998"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="33697998"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:17:44 -0700
X-CSE-ConnectionGUID: LJ4Z222jTBCVnn2JHezH6A==
X-CSE-MsgGUID: OaqkMeMZRKu1stquCxXevA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60275575"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa009.jf.intel.com with ESMTP; 19 Aug 2024 00:17:44 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	wojciech.drewek@intel.com,
	jiri@resnulli.us
Subject: [iwl-net v2] ice: use internal pf id instead of function number
Date: Mon, 19 Aug 2024 09:17:42 +0200
Message-ID: <20240819071742.65603-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use always the same pf id in devlink port number. When doing
pass-through the PF to VM bus info func number can be any value.

Fixes: 2ae0aa4758b0 ("ice: Move devlink port to PF/VF struct")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Suggested-by: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
v1 --> v2: https://lore.kernel.org/netdev/20240813071610.52295-1-michal.swiatkowski@linux.intel.com/
 * change subject to net and add fixes tag
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


