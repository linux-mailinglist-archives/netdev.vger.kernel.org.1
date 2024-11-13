Return-Path: <netdev+bounces-144546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 531FF9C7BAF
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91CD1F20F5D
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB1A20694A;
	Wed, 13 Nov 2024 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abMaAXU9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A787204F69
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524085; cv=none; b=ToQl/zXmUYbUmo9dxRxY9MMmGAbhb+m1QnVX+JdwSY2HlBwKTluqjawsIo5e62dRRegvQznDQVgMAMS6kdtBetYoPXLuUhZ8PK8M9/bi74TUW9nQ6TF45vy2x2s/CWL8z1yBM2RtqaxOxl3rPaNBvg9YfRUd4/JINSKkBnNzePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524085; c=relaxed/simple;
	bh=ppk2G7Bqdir/e0yTTe0JiMOlgYrNrLj3k4CMbMwuW18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4v9Pw/Q9Vtg3/JuoVanOSI9W7MHLdBk1RNTtbioKTytc45ESG+iVn+NCXNcTaDaFIc5gH0A/OSqkDbosrTrNAU4I5x2LeRcEkT/kG3jWPGziGONsysAYEK0OEh3AnR7tvacM99SFLUUukGdI43r5+MvcQ0zlCltSqRwEShnVOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abMaAXU9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731524082; x=1763060082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ppk2G7Bqdir/e0yTTe0JiMOlgYrNrLj3k4CMbMwuW18=;
  b=abMaAXU9WEpoXPFLJtTvNMTRycw0sxlBLwPRaRk3VyJAqbwO8Brq3iLw
   sb9NGb2i4dZaAUYrD/rxpz6/0IhqiorZFnx5FFjFNRgBIF5d92e0xyAzP
   +hFJgu5OSpTeXsl+3549PUltU2mLiJX5Ku5mY4gGRqKMB0xa2MUmjw4zO
   IPlkgICPEkpbACdJnaRqkSsFmJ2fQyLO35A7nHupJJIpsEJQ0iQzdZjuG
   tsw2Z065dZ7ZS3GXXV4cJmcqYnHxGUbximzpBxnOnc9wLRozZAn+NxPeT
   MNaUpJuJPrFz/uTnwM+p1R/sygkqgWC9mOKI1WpKp7qMyyM3ZmiVMao6s
   A==;
X-CSE-ConnectionGUID: Rqp2C/yAT8+LPyMekYEc5g==
X-CSE-MsgGUID: WN36cRZiSVaZ1mn44gtXGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31589495"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31589495"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 10:54:40 -0800
X-CSE-ConnectionGUID: ZmnrkKs2SjOndQrsqCxsow==
X-CSE-MsgGUID: joIIn/DXSOSW5Z+uXEUA9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="87520736"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Nov 2024 10:54:39 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next v2 05/14] ice: Add support for persistent NAPI config
Date: Wed, 13 Nov 2024 10:54:20 -0800
Message-ID: <20241113185431.1289708-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241113185431.1289708-1-anthony.l.nguyen@intel.com>
References: <20241113185431.1289708-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joe Damato <jdamato@fastly.com>

Use netif_napi_add_config to assign persistent per-NAPI config when
initializing NAPIs. This preserves NAPI config settings when queue
counts are adjusted.

Tested with an E810-2CQDA2 NIC.

Begin by setting the queue count to 4:

$ sudo ethtool -L eth4 combined 4

Check the queue settings:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 4}'
[{'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8452,
  'ifindex': 4,
  'irq': 2782},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8451,
  'ifindex': 4,
  'irq': 2781},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8450,
  'ifindex': 4,
  'irq': 2780},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8449,
  'ifindex': 4,
  'irq': 2779}]

Now, set the queue with NAPI ID 8451 to have a gro-flush-timeout of
1111:

$ sudo ./tools/net/ynl/cli.py \
            --spec Documentation/netlink/specs/netdev.yaml \
            --do napi-set --json='{"id": 8451, "gro-flush-timeout": 1111}'
None

Check that worked:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 4}'
[{'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8452,
  'ifindex': 4,
  'irq': 2782},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 1111,
  'id': 8451,
  'ifindex': 4,
  'irq': 2781},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8450,
  'ifindex': 4,
  'irq': 2780},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8449,
  'ifindex': 4,
  'irq': 2779}]

Now reduce the queue count to 2, which would destroy the queue with NAPI
ID 8451:

$ sudo ethtool -L eth4 combined 2

Check the queue settings, noting that NAPI ID 8451 is gone:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 4}'
[{'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8450,
  'ifindex': 4,
  'irq': 2780},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8449,
  'ifindex': 4,
  'irq': 2779}]

Now, increase the number of queues back to 4:

$ sudo ethtool -L eth4 combined 4

Dump the settings, expecting to see the same NAPI IDs as above and for
NAPI ID 8451 to have its gro-flush-timeout set to 1111:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 4}'
[{'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8452,
  'ifindex': 4,
  'irq': 2782},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 1111,
  'id': 8451,
  'ifindex': 4,
  'irq': 2781},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8450,
  'ifindex': 4,
  'irq': 2780},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8449,
  'ifindex': 4,
  'irq': 2779}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 3 ++-
 drivers/net/ethernet/intel/ice/ice_lib.c  | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 3a8e156d7d86..82a9cd4ec7ae 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -156,7 +156,8 @@ static int ice_vsi_alloc_q_vector(struct ice_vsi *vsi, u16 v_idx)
 	 * handler here (i.e. resume, reset/rebuild, etc.)
 	 */
 	if (vsi->netdev)
-		netif_napi_add(vsi->netdev, &q_vector->napi, ice_napi_poll);
+		netif_napi_add_config(vsi->netdev, &q_vector->napi,
+				      ice_napi_poll, v_idx);
 
 out:
 	/* tie q_vector and VSI together */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d4e74f96a8ad..a7d45a8ce7ac 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2777,8 +2777,10 @@ void ice_napi_add(struct ice_vsi *vsi)
 		return;
 
 	ice_for_each_q_vector(vsi, v_idx)
-		netif_napi_add(vsi->netdev, &vsi->q_vectors[v_idx]->napi,
-			       ice_napi_poll);
+		netif_napi_add_config(vsi->netdev,
+				      &vsi->q_vectors[v_idx]->napi,
+				      ice_napi_poll,
+				      v_idx);
 }
 
 /**
-- 
2.42.0


