Return-Path: <netdev+bounces-190304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C23CEAB6199
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 06:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43C21B4516C
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 04:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9731F7092;
	Wed, 14 May 2025 04:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KxXeNpXP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C301FE45D;
	Wed, 14 May 2025 04:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747197124; cv=none; b=WWYIpLXqIEZsNA7A0kfRjoJEb4V4ETqCZTAtiWowELXDR1dMKSH7tkzyStjmWLrxfiiRx+u32fAN7U0gvPASgtw9FwglWqUr02NTAQOVhcwTqNnGQixltAsMOrxuu+R4b5dJmBJ4PIq2OQ/z1FBw+rT3UUfkz1xwRCKNeVDmmt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747197124; c=relaxed/simple;
	bh=0fgO+QvVf9+rVnYvZZT700A8z0ZC/9q1mzSMkC20Zdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Df+lG4r8trNlWZQrbZVZdsyQT+hloh0PojkMnIgdlnVFBeP4JLmVrlSvsQ+Xmc2YtdhgoEBL37g2Z0tRqwoDHm5sbiGZdcA7NJ0QGCt+wldZEI/2N5H/RlO2KEHUBDQEZ1vJ56oebAoUXHDSvrTKb7TFL1qZGnbiqpH48hn5qxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KxXeNpXP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747197123; x=1778733123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0fgO+QvVf9+rVnYvZZT700A8z0ZC/9q1mzSMkC20Zdw=;
  b=KxXeNpXPw9KsbAhTaZB3dHf8ZOPLcabqGcenFpx17vpnyKlb6ENdL8NB
   Kz8lvHZ4QBpWZt9EhTA5pQy2ZfsAZcaXvtfXqDovJtD7HZBHCt7P62XD0
   uTyS9GoeDZqd1fWPqm6D1hfEebwT8Es6efx73ODrHIqwOB9IaayHgkMhy
   TmnleyliH6KgUS+FEJc2jfrVRDL5tFlqtgEp+8Nj9AkNVsi45MfK9v+Z9
   s/PP1AwEgdqLT3LAT/p7lOCZEaqGYjqrJ34mG+KlMVWdMrqoCMrr0LFGS
   m6xHBibrAjQcifsJPSGrnCpZMloipejl0f+HZxGUpgrDroGG1huTwyxfn
   A==;
X-CSE-ConnectionGUID: OMc6FrEkSDWGIwmLeK7vsg==
X-CSE-MsgGUID: HsNluePsTwOn5HTfXS4Idg==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="36699593"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="36699593"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 21:31:41 -0700
X-CSE-ConnectionGUID: E7KPBRBrQEeKE/TbktqJvA==
X-CSE-MsgGUID: s7PFcjVURUm1j9RdIQp0cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="142861962"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa004.jf.intel.com with ESMTP; 13 May 2025 21:31:31 -0700
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>
Subject: [PATCH iwl-next v2 8/8] igc: SW pad preemptible frames for correct mCRC calculation
Date: Wed, 14 May 2025 00:29:45 -0400
Message-Id: <20250514042945.2685273-9-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514042945.2685273-1-faizal.abdul.rahim@linux.intel.com>
References: <20250514042945.2685273-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chwee-Lin Choong <chwee.lin.choong@intel.com>

A hardware-padded frame transmitted from the preemptible queue
results in an incorrect mCRC computation by hardware, as the
padding bytes are not included in the mCRC calculation.

To address this, manually pad frames in preemptible queues to a
minimum length of 60 bytes using skb_padto() before transmission.
This ensures that the hardware includes the padding bytes in the
mCRC computation, producing a correct mCRC value.

Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 4d748eca0c6c..509f95651f25 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1685,6 +1685,15 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 	first->tx_flags = tx_flags;
 	first->protocol = protocol;
 
+	/* For preemptible queue, manually pad the skb so that HW includes
+	 * padding bytes in mCRC calculation
+	 */
+	if (tx_ring->preemptible && skb->len < ETH_ZLEN) {
+		if (skb_padto(skb, ETH_ZLEN))
+			goto out_drop;
+		skb_put(skb, ETH_ZLEN - skb->len);
+	}
+
 	tso = igc_tso(tx_ring, first, launch_time, first_flag, &hdr_len);
 	if (tso < 0)
 		goto out_drop;
-- 
2.34.1


