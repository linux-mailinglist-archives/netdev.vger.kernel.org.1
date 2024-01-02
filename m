Return-Path: <netdev+bounces-61039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D148224AF
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 23:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624A9280EB0
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 22:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0984171C8;
	Tue,  2 Jan 2024 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Psvw6TWk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320A9171C5
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704234280; x=1735770280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6x7x1XTz1qAP2tArSAdkAYJ4FpZSyReIQpWDXT02nQI=;
  b=Psvw6TWkQYEefzgx/VSqeTmc32W1bkNhV3cweoj+X1V3fSbMmH6ZL7sh
   To/WefeDW9UzvdOzzpxTWk1X1rj2x0QZozwMzADj4AKIO2QLAdjMQIZSD
   JxJ/T22HpogxkBm1pb8HdBPBLeFmei3qS0j7+P0rfTgBm8BSojrLTERpU
   e4q1CpbT711rlawFi5ghIBdw5GB+MxBcKeIoPzfBQwNb84DdOX/8eNkQI
   odx8i3buqPzCZQ63mOOXN++gyokGgqHXu+fYuqvExrsvRR/r4A1pMv1e7
   t8S/jkAkRs+P4cidyVIJYIxTh7536rT1N+78J0bOXzSo4+Eb6viNpbbAf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="3700404"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="3700404"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 14:24:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="772965452"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="772965452"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga007.jf.intel.com with ESMTP; 02 Jan 2024 14:24:37 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ovidiu Panait <ovidiu.panait@windriver.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 1/5] ixgbe: report link state for VF devices
Date: Tue,  2 Jan 2024 14:24:19 -0800
Message-ID: <20240102222429.699129-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240102222429.699129-1-anthony.l.nguyen@intel.com>
References: <20240102222429.699129-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ovidiu Panait <ovidiu.panait@windriver.com>

The link state of VF devices can be controlled via "ip link set", but the
current state (auto/disabled) is not reported by "ip link show".

Update ixgbe_ndo_get_vf_config() to make this info available to userspace.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index f8c6ca9fea82..114c85336187 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -1847,5 +1847,6 @@ int ixgbe_ndo_get_vf_config(struct net_device *netdev,
 	ivi->spoofchk = adapter->vfinfo[vf].spoofchk_enabled;
 	ivi->rss_query_en = adapter->vfinfo[vf].rss_query_enabled;
 	ivi->trusted = adapter->vfinfo[vf].trusted;
+	ivi->linkstate = adapter->vfinfo[vf].link_state;
 	return 0;
 }
-- 
2.41.0


