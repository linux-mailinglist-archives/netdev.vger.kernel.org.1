Return-Path: <netdev+bounces-148475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBEE9E1CCD
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF9316111E
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39771EBFE6;
	Tue,  3 Dec 2024 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DAV0if58"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3771EBA04
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230392; cv=none; b=FApOymzJoBLByC3iQ/H/HHj513F9/NqZdpzr5h+n5Uh9e38Yc5j6VIiRr++SYOyC6qSMDw2qh/gn86iYV2G3Spb+36O8RcGtVXrn3yJdr9I+uJJ4+BA9EKyJO0VkfrWzyOeqI2LXIWOWrxn7zzlam6pf5To0OMydRxbarraagt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230392; c=relaxed/simple;
	bh=wgLQ8u7KRuTAl2laukrQT/h3e2tgwbSrvwrFG+FY6iU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GLEg/XZX2JcUHJTkfYa/5Z/tk+N1YrYwYOXnepFUymUZkU49/CTCNEJB1KaxeoSCIEX9eSQx8y4Vga5agimTUYk/ui4SKLGKu3pu/skVtZAy4cxDLfkQ5cozZ4aH+chCBXOCssmPT0jIszrcvh5dQpvh+L3xhvuV0lIwdfGmTzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DAV0if58; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733230391; x=1764766391;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wgLQ8u7KRuTAl2laukrQT/h3e2tgwbSrvwrFG+FY6iU=;
  b=DAV0if58GuMvezA9GT1Ghtqqv7R398pqmPfT0N/s7p7Pa1Sa8Ij2TJy+
   /aZDQvqP1eBlasRh9A5Z5jiflEUslFOyPJyKz+56y1bcM+tUbCHQ5gYxe
   ttNgH/gA8i5unSgcbHH+9FNNtWRL9c1usIIsNMT1yUOFLX9yP2ya3Wy09
   0Wcav2DljWjZtYYkw3cJcF7M1ucugSjOw919dbnVJnt44yu4gxaLdG8SU
   ZKl13BX7l6ga4Mq4EwFBbCxfgxqM0+elAcM7/BsWALJ2L/V8bBJAmxRPb
   7JhAWgGuQf37PHyVMM55v76y/R2eR16OleU030j6q+ewLBHuA0ufQntXz
   Q==;
X-CSE-ConnectionGUID: wWBIJX9PQsSgUc50VB9L4w==
X-CSE-MsgGUID: JyzslMAvQ02h4g+k/tKdCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44050229"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="44050229"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 04:53:11 -0800
X-CSE-ConnectionGUID: VRscLp6ZRf6blZMEZARRuw==
X-CSE-MsgGUID: loQUAiFPRYysEB1/DNNWog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="93889624"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 03 Dec 2024 04:53:09 -0800
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 7BFDC2FC55;
	Tue,  3 Dec 2024 12:53:08 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v1] ice: Extend ethtool reset support
Date: Tue,  3 Dec 2024 13:52:55 +0100
Message-Id: <20241203125255.115651-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the job done in:
commit b699c81af068 ("ice: Implement ethtool reset support")
by adding ethtool reset function for safe mode ops structure.

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index b552439fc1f9..d338a5ee8ab2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4841,6 +4841,7 @@ static const struct ethtool_ops ice_ethtool_safe_mode_ops = {
 	.set_ringparam		= ice_set_ringparam,
 	.nway_reset		= ice_nway_reset,
 	.get_channels		= ice_get_channels,
+	.reset			= ice_ethtool_reset,
 };
 
 /**
-- 
2.38.1


