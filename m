Return-Path: <netdev+bounces-133737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 307F0996D25
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624BF1C223FA
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F181A0BCF;
	Wed,  9 Oct 2024 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOICCCEl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB255199EBB
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482557; cv=none; b=Zjt8UM6s+93i8dNhjFb1zO/Qhx5LGycGMzC9F/iJHRfPDxVtvADnp4zYHNcVCpg1+PRPEzaI3Ib8EuBBSH7IPY8OMAxPcqu5oedJxmLeT+5tJL235AcEeGlMcR/zYnLwK0y0SO3t1Uw+lHlPC5gsARdg/12Sj5Hz6ydXv26ilNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482557; c=relaxed/simple;
	bh=jiPvPXxBq3tdFiDO1nLpvgYWsPIczFNWPyj+6nTmfuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cODygSWZW7n5vJUyl2bjl8iqB4G7ByP9kghY7Un1+0VwWmHkKAs8g7NtbVXVmppFHWS5j0O2F5/UW/upXEyhNepip0L45hyNlIgUWmSy+8rqESyaj+xdPNGgzh36MQaEdcJpraNb+fm3qjWIKVv3tu1BXC6cRxV2u3JGAMbVPYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOICCCEl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728482556; x=1760018556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jiPvPXxBq3tdFiDO1nLpvgYWsPIczFNWPyj+6nTmfuo=;
  b=lOICCCElWYHvii6fCCR3oF7xVs47drdQFZPqqawpohkWjzrnTrkySeNV
   ouTRQ6k0y+zusZGcGA2qtN4mWRSINwS3o4jrwrGqDljg63IIE03R7db97
   5uXQDLLmg+fVm2pKxx/Mhm4h7w49n4ghIjt4mAB9OXxDF+dO/Df5PTdiz
   Tt9zkrRzwN+dqcqZvtru02v33VTpojGaHvj7S5e/ID2bNXOE9ot/9HtSY
   V5wN6z+wem7sdW1MXQgPXYh3HA2+vBcF8986BhNU3VYA6okCux3KzF0Nx
   zDz6NUjiq30gQtbiCuY3Uotipt71auZ0wLdy7vafFLUWek8SENzK1I9av
   g==;
X-CSE-ConnectionGUID: GhSP+tk/SFGUCRt27Kot7Q==
X-CSE-MsgGUID: l/FXi6isRJe8Z0SIc9+vdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31483949"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="31483949"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 07:02:35 -0700
X-CSE-ConnectionGUID: 1Nq8/WdYQUWvi/5SvPgaLw==
X-CSE-MsgGUID: lAWabKODSq+xmL/WQXLPoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76210785"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.108])
  by orviesa009.jf.intel.com with ESMTP; 09 Oct 2024 07:02:34 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH v2 iwl-next 3/4] ice: Fix ETH56G FC-FEC Rx offset value
Date: Wed,  9 Oct 2024 15:59:28 +0200
Message-ID: <20241009140223.1918687-4-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009140223.1918687-1-karol.kolacinski@intel.com>
References: <20241009140223.1918687-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix ETH56G FC-FEC incorrect Rx offset value by changing it from -255.96
to -469.26 ns.

Those values are derived from HW spec and reflect internal delays.
Hex value is a fixed point representation in Q23.9 format.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
index e63f2a36eabf..339b9f59ddde 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
@@ -86,7 +86,7 @@ struct ice_eth56g_mac_reg_cfg eth56g_mac_cfg[NUM_ICE_ETH56G_LNK_SPD] = {
 		.rx_offset = {
 			.serdes = 0xffffeb27, /* -10.42424 */
 			.no_fec = 0xffffcccd, /* -25.6 */
-			.fc = 0xfffe0014, /* -255.96 */
+			.fc = 0xfffc557b, /* -469.26 */
 			.sfd = 0x4a4, /* 2.32 */
 			.bs_ds = 0x32 /* 0.0969697 */
 		}
-- 
2.46.2


