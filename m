Return-Path: <netdev+bounces-100144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994948D7F53
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14A4CB21571
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4DE8289E;
	Mon,  3 Jun 2024 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gigSTkGa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15C082487
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407943; cv=none; b=rU0EfaTyGan58y9hgFObj7hn9kCHc0Snp4mOiB8lUz79fz/oIg4ZZ/3YBDPLm/vrHg2+OTCWokRhy8Ax+VKvmQAOnMBk5vOhrggUgQVwxrTARUWDGlKIrsAXwiGnelrt7XPT5N/mVMB9V2uJbr1j0zW3+9AjR+HmhwrFDqpwlDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407943; c=relaxed/simple;
	bh=qvRqx+zi0Xuh6V6M80937A5imi+4yWqkJOdVo+HcxSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HweTP2JERrqWCRMk3g/z7oa/LOrI6zbaTA7M3d8PCLZfCv4p2Yw1IO3F9oah/vv3nOspj9QjzKg1UtUMtSB98chlFQ3z8juIDM9tZP1yFoJRIHsMrtK2FumdMHN45D9JkGPTisjfUHxmSa2pPzJTD3D9jVki84NYuZfzjzbKIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gigSTkGa; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717407942; x=1748943942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qvRqx+zi0Xuh6V6M80937A5imi+4yWqkJOdVo+HcxSM=;
  b=gigSTkGaX7dDL8J/bLxlD/yB4kASnftEh0Fn3/h24xRILbO/0f1Q04UF
   RT3yq6EpNEkyJuGIl8QP2pADRAvjYVGLXxfmXN/Sb9kEGcWGrLyLJVlPt
   8Qrv3pdznbZJWrC4PkLIC0oFbX7DEePRTyFS4F34FOuL3DFEagGWc1DB2
   tiYXjgzsW3OrbexnXB2DnHLD0TcgiCrZ/0Yw18JKw+z82hqU2qtbG3YIC
   /u+A51/p3aT9CMkchC+pl8LZbgzD5HQyPWQrwEaCZ72CTcA0FbqiS1IIC
   LxbyXhFlSyPWvg0Gqa7LnH6g6mfusxXFgaAbwlazwZ53Dv9jN1HYwAcpe
   Q==;
X-CSE-ConnectionGUID: HcVHXiNLQyqXTmNyccyF7A==
X-CSE-MsgGUID: ESzN8yFNRvazMQyn94oeMA==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="17732676"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="17732676"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 02:45:42 -0700
X-CSE-ConnectionGUID: Jn9lna01Rja3vRUF6FfWFg==
X-CSE-MsgGUID: U2Ik2Y/XS4mDEhJfLw6Dog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="37448194"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa007.jf.intel.com with ESMTP; 03 Jun 2024 02:45:38 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	jiri@nvidia.com,
	mateusz.polchlopek@intel.com,
	shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com,
	horms@kernel.org
Subject: [iwl-next v4 04/15] ice: treat subfunction VSI the same as PF VSI
Date: Mon,  3 Jun 2024 11:50:14 +0200
Message-ID: <20240603095025.1395347-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240603095025.1395347-1-michal.swiatkowski@linux.intel.com>
References: <20240603095025.1395347-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When subfunction VSI is open the same code as for PF VSI should be
executed. Also when up is complete. Reflect that in code by adding
subfunction VSI to consideration.

In case of stopping, PF doesn't have additional tasks, so the same
is with subfunction VSI.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d1d9b63822f5..e32f4307994f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6704,7 +6704,8 @@ static int ice_up_complete(struct ice_vsi *vsi)
 
 	if (vsi->port_info &&
 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
-	    vsi->netdev && vsi->type == ICE_VSI_PF) {
+	    ((vsi->netdev && vsi->type == ICE_VSI_PF) ||
+	     (vsi->netdev && vsi->type == ICE_VSI_SF))) {
 		ice_print_link_msg(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
@@ -7402,7 +7403,7 @@ int ice_vsi_open(struct ice_vsi *vsi)
 
 	ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
 
-	if (vsi->type == ICE_VSI_PF) {
+	if (vsi->type == ICE_VSI_PF || vsi->type == ICE_VSI_SF) {
 		/* Notify the stack of the actual queue counts. */
 		err = netif_set_real_num_tx_queues(vsi->netdev, vsi->num_txq);
 		if (err)
-- 
2.42.0


