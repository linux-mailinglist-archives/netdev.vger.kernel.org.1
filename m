Return-Path: <netdev+bounces-144554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 067DF9C7BB6
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD10281663
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EF62076BD;
	Wed, 13 Nov 2024 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TIISaALm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4CB206E9E
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524090; cv=none; b=ApMIJASOmNGivrv/7RoX+LR2flo1kcR2wiW6vnvg57RWuMArQTvql8mgjIo0J7TmgR5401wk7779qxYZw5zBT277z6sYg4WalLUZwi+WZzUt7dlP+U7y+Yer382Bt6grhOHFEmOFGxkw3xPIGKqZrUr0cWnwG3BKWM1GPCOUa0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524090; c=relaxed/simple;
	bh=2122BFx7wZd5PY+V5o0vzfvpOOTUFdW+arY4RIKKIrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EC42kXFeZf4Nvqb8jA3WtzfDYnfv6k+4Xz2yHgPjfDVbfYfqb9/lhSTBy8VG44MEXG2l50HvH0ZNY2jc4BkwU/CxOgICpfXGfyqP90ELPepC4RffJHjT/kfzwl9A4Pvv95WEmy7jAnzWFHiGW4+oqHLA7vctqXj6vpN9/roKOJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TIISaALm; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731524087; x=1763060087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2122BFx7wZd5PY+V5o0vzfvpOOTUFdW+arY4RIKKIrM=;
  b=TIISaALmvdBQu8ofMoDK8lPyAs658yQ8XJXLL6ElNqkX1JefDrTO5bK5
   P2E+xL1pPEIzjRosHVNYt4IUU5QixXKAacRv4zgVcNHkXEufu9CAsJFXl
   5NEtkV7025LPTOg9M7x+3EfUZUm97A+qz2gOL1zVArQ3WaEHD30DzQ1j3
   JByuxluouOQfhArmuequZM6jAUFAqKUPku9SytCZf2h7C/HAW4rfaHJDa
   7YAgtg++22lDj3eAh6qzD+ZcfSKQEykOmr0+qStrS8le04TuSZPGjcAnT
   Qyk2O8VwkC0xR0i+8ROgIWv3B9ZiCYRG4dW9MFgW31LM2YDNALJqu2FIK
   g==;
X-CSE-ConnectionGUID: UM5AAZZyS9WWoewcyfEppQ==
X-CSE-MsgGUID: 8bznlsXHRCWWZVRQ3mKoUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31589542"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31589542"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 10:54:43 -0800
X-CSE-ConnectionGUID: etPiKejyRZKRvnDlHtXaLg==
X-CSE-MsgGUID: 2VXtXFlMQzuhhvWrWzDi2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="87520766"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Nov 2024 10:54:42 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Johnny Park <pjohnny0508@gmail.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 12/14] igb: Fix 2 typos in comments in igb_main.c
Date: Wed, 13 Nov 2024 10:54:27 -0800
Message-ID: <20241113185431.1289708-13-anthony.l.nguyen@intel.com>
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

From: Johnny Park <pjohnny0508@gmail.com>

Fix 2 spelling mistakes in comments in `igb_main.c`.

Signed-off-by: Johnny Park <pjohnny0508@gmail.com>
Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index b83df5f94b1f..37b674f8cbcd 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1204,7 +1204,7 @@ static int igb_alloc_q_vector(struct igb_adapter *adapter,
 	/* initialize pointer to rings */
 	ring = q_vector->ring;
 
-	/* intialize ITR */
+	/* initialize ITR */
 	if (rxr_count) {
 		/* rx or rx/tx vector */
 		if (!adapter->rx_itr_setting || adapter->rx_itr_setting > 3)
@@ -3906,7 +3906,7 @@ static void igb_remove(struct pci_dev *pdev)
  *
  *  This function initializes the vf specific data storage and then attempts to
  *  allocate the VFs.  The reason for ordering it this way is because it is much
- *  mor expensive time wise to disable SR-IOV than it is to allocate and free
+ *  more expensive time wise to disable SR-IOV than it is to allocate and free
  *  the memory for the VFs.
  **/
 static void igb_probe_vfs(struct igb_adapter *adapter)
-- 
2.42.0


