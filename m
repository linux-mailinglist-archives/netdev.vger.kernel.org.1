Return-Path: <netdev+bounces-181785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB42BA86783
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E034F1B82E6A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5AD29DB70;
	Fri, 11 Apr 2025 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUYjzYNP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C5728D836
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404258; cv=none; b=h+27bJhdUHxHMr/jvTv6aqL6uq3dRWHhJcQiXakVtxs/2SiRn1KKtFfWJOZGdExgUBE99ZU2+/Itmaf8hWfX40pZkgADKBZ46ls9nl5goYyD7qDh1CLOLBAkuYd+UFOIlheRFR7A2SHDueW5gUlm8Pewkl+/6AH9Y6BcriiE//w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404258; c=relaxed/simple;
	bh=dpME6jSbGHXk8oNVvBbQclOGdmcrzANlyS0Lt089tAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dn/BVLJBnTpuNoqlAVQIom23OmcWlrSy1ezd55bivl5t6DXjb3xNWHzhLGWjtEzHlndaZwPHZ8oXu18MqA+iEN73ZS8PDtiuETkDO/cYZIkC47hX6Yr46Kpm8Af3DgjxJzL3Se3gVZzHw7qZIwioSupVwbmhD/phzxd+YVFtWgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUYjzYNP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744404257; x=1775940257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dpME6jSbGHXk8oNVvBbQclOGdmcrzANlyS0Lt089tAM=;
  b=NUYjzYNPIJcJG5cFGcR9tGrOHvzzsaqS8fwYoMRj3pykHM8ZUUrXQC2N
   nK4TKi3gSAhkSPUsAUvbCt42ObsEOzdIjt3zdLweW9Sv6NI49cGmrblR2
   VtUb6fOrSg5+Ictom0k9//NfDhYHYlsTcWUe/2pYStsEzq9fZ0EqGBewU
   YhZrhlp22/2/OMc9CwOa/FJHVFX/+Gbp/Qz1T3npbgLuNYsUtmqiX1cvm
   hc+z4LKtkZ6JhuL7OPsyHgjL2zrn1sXTPULftrDkED29qomHEdhZdFjpp
   Bjh+/OBpNLiu0JVyEZumI8W3fotEa2dNtYm5z9npPbWyCuQ3oX/wkretm
   A==;
X-CSE-ConnectionGUID: izVUp5C9Q3Syh0eYmZ8QAg==
X-CSE-MsgGUID: 66Hw7km6QzCxRe0i03Io7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45103929"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="45103929"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 13:44:08 -0700
X-CSE-ConnectionGUID: a5IqYFwNR+u169Bn7w+l2w==
X-CSE-MsgGUID: +nYEj/UwSgSPRXTguBbBtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="129241835"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 11 Apr 2025 13:44:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Rui Salvaterra <rsalvaterra@gmail.com>,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	Simon Horman <horms@kernel.org>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net-next 14/15] igc: enable HW vlan tag insertion/stripping by default
Date: Fri, 11 Apr 2025 13:43:55 -0700
Message-ID: <20250411204401.3271306-15-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
References: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rui Salvaterra <rsalvaterra@gmail.com>

This is enabled by default in other Intel drivers I've checked (e1000, e1000e,
iavf, igb and ice). Fixes an out-of-the-box performance issue when running
OpenWrt on typical mini-PCs with igc-supported Ethernet controllers and 802.1Q
VLAN configurations, as ethtool isn't part of the default packages and sane
defaults are expected.

In my specific case, with an Intel N100-based machine with four I226-V Ethernet
controllers, my upload performance increased from under 30 Mb/s to the expected
~1 Gb/s.

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index f1330379e6bb..30c72c343262 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7125,6 +7125,9 @@ static int igc_probe(struct pci_dev *pdev,
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
+	/* enable HW vlan tag insertion/stripping by default */
+	netdev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
+
 	/* MTU range: 68 - 9216 */
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = MAX_STD_JUMBO_FRAME_SIZE;
-- 
2.47.1


