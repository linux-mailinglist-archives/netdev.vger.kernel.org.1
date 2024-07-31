Return-Path: <netdev+bounces-114705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9439438A5
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 00:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366CD283E7B
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 22:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A68316DC32;
	Wed, 31 Jul 2024 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rmz9x3sm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C106616DC1C
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463854; cv=none; b=kllrRpPY9s9E24wViCsyANTUeyGe+nqZ7xgYkEXJY8OIViZSRt53dkcbStaPauc4S3xQgCzCz7bKA0/YvB8+M1RMv5SUpxTSdSFgp5YjL220d6HyVmRf5TyrqPNEdRfETgIl/DM6S4a1vwEeWTl/GZTK9EMYzR0ZMgQm1aR8IwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463854; c=relaxed/simple;
	bh=BH4L0+tMMWCgvCrdfLAm4J6UMqouKKpq+c9ei35AcDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKA4Hg5rvZ+LdjvaPPYOy+TacAs/H2ClhwKjdnqj6f1HbB/zhfcwFcxFd7AWEqd7H1aA85kDq9YItx/4TUoqTP1mfufxYgdY4FwGY/zEcE0IwA6CWkbdaJZc92XpGkzj/QmN/bg9lvFERZT7ibBfSJOZ/V9hwXuCdhCdAi6OFLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rmz9x3sm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722463853; x=1753999853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BH4L0+tMMWCgvCrdfLAm4J6UMqouKKpq+c9ei35AcDA=;
  b=Rmz9x3sm7jTygE/Jtuc1OC6nfQNzRtQmX4kkZJlVnWHXQgw5PT/jWiDS
   AESWEHX/4SKmlEZvMq9WjiNNHIlMj1Z5xeq5Smx8L/2fXwv9JYznLbV+j
   IH+g2kayRU3XVjcpb0i4YLShgSS+DyCZ7TynhTw+9peq04hQNkqlYmpMW
   e1Y6N8XQYvdh+RC4ZKBXAyRggCjmAg/vUnvHFw6lQnIGand1Bp4C/VOeH
   PnKAN8AETZWS3dJuUjjHt6OLPm4+GQkJDQVEgrrJh284cBzPCUJ0f6Ozq
   qLmeW8SrnQmStNPjQjXriJOCb97/C2dUqMIpkL9pHXpAYwmI3Tw20uhyi
   Q==;
X-CSE-ConnectionGUID: O9LcFKOoTtGyAGgVzUGVHA==
X-CSE-MsgGUID: 5m3i4mbBSDqoLjHq1LiujQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="31765549"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="31765549"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 15:10:47 -0700
X-CSE-ConnectionGUID: g/KgrzkbT8O+ybv4HgCA5A==
X-CSE-MsgGUID: nHXE+MhiQ/SJlC3P6lbu3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54734162"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 31 Jul 2024 15:10:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	jiri@nvidia.com,
	shayd@nvidia.com,
	wojciech.drewek@intel.com,
	horms@kernel.org,
	sridhar.samudrala@intel.com,
	mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com,
	michal.kubiak@intel.com,
	pio.raczynski@gmail.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next v2 10/15] ice: don't set target VSI for subfunction
Date: Wed, 31 Jul 2024 15:10:21 -0700
Message-ID: <20240731221028.965449-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
References: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Add check for subfunction before setting target VSI. It is needed for PF
in switchdev mode but not for subfunction (even in switchdev mode).

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 8bb743f78fcb..fe96af89509b 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2405,7 +2405,7 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 					ICE_TXD_CTX_QW1_CMD_S);
 
 	ice_tstamp(tx_ring, skb, first, &offload);
-	if (ice_is_switchdev_running(vsi->back))
+	if (ice_is_switchdev_running(vsi->back) && vsi->type != ICE_VSI_SF)
 		ice_eswitch_set_target_vsi(skb, &offload);
 
 	if (offload.cd_qw1 & ICE_TX_DESC_DTYPE_CTX) {
-- 
2.42.0


