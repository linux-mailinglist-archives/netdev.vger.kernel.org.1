Return-Path: <netdev+bounces-73450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24F285CA3D
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 22:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00EC9B21A3E
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 21:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3EB152E04;
	Tue, 20 Feb 2024 21:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZz08OF0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130EA151CDC
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 21:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465594; cv=none; b=eWFsXED5HR9YS9BYw1gizKZ9QWu/hS3DbTkN1XP/3jliRklacXzx56yJevyTKrmG39r2jtnjSggecosZVdS0Vjcp5UYEtA60mHShfly7mu5l0VPS5abndrnAOWtkO+opyTs/US+ORdNWyVyTpx2Vj5J0m86QcgQopBcDbDPFOKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465594; c=relaxed/simple;
	bh=jFUP/0VDq+41yXI5gQU74pPhbR/gHbWouGqxLCCp7d0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZfZm8AI32XsRZqnT1BathbYnTwfgBLv/fr3Lp8r2JudUWW+23OXxGf9l/lM2plzAO0Ne7Wo+NVx6ue/KBjlGJ0tHuaaqQjkLVR0Fw6J1g3ME5PVJIvi3wGt+nZJZFn4+vhphal5hyAp36GnIHNpLZDOvE+yTroQ4lgUsQk5WLKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZz08OF0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708465594; x=1740001594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jFUP/0VDq+41yXI5gQU74pPhbR/gHbWouGqxLCCp7d0=;
  b=dZz08OF01F1cZZDrHkkIlBNCY6qh+F5E3UdHpFqFe6OH2MbmluSeb6yw
   OEyALH929uweAICtdqWzkMYxQaQNnhIa0/f9h9seYe4WyU4sLIh7HaCJX
   9h1MfjEtahnnDz6ENXm3GIXRkoP47eX4bBzYiRMgMyQ6mtH5jcpsWTvv2
   3DuRlBeq4ZamgnLk9y68Zzrl9N329E1IKnl5YwJ8YN7rOhiD/M9CiYDEL
   6bw17KgHUKQ7K0CtFQxTNVDHMbWOS9A9KLVOeHZAmz9SKCNLpZfR7u6Rp
   c+XSEaKnHQDDSpCtfthTw0Fo97ZYc+PTbKyPxk/92xlypE3MGLvoHVoa5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2462667"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2462667"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 13:46:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="35681896"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa002.jf.intel.com with ESMTP; 20 Feb 2024 13:46:32 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-net 2/3] i40e: disable NAPI right after disabling irqs when handling xsk_pool
Date: Tue, 20 Feb 2024 22:45:52 +0100
Message-Id: <20240220214553.714243-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220214553.714243-1-maciej.fijalkowski@intel.com>
References: <20240220214553.714243-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable NAPI before shutting down queues that this particular NAPI
contains so that the order of actions in i40e_queue_pair_disable()
mirrors what we do in i40e_queue_pair_enable().

Fixes: 123cecd427b6 ("i40e: added queue pair disable/enable functions")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6e7fd473abfd..eab2d4c3a5fc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13564,9 +13564,9 @@ int i40e_queue_pair_disable(struct i40e_vsi *vsi, int queue_pair)
 		return err;
 
 	i40e_queue_pair_disable_irq(vsi, queue_pair);
+	i40e_queue_pair_toggle_napi(vsi, queue_pair, false /* off */);
 	err = i40e_queue_pair_toggle_rings(vsi, queue_pair, false /* off */);
 	i40e_clean_rx_ring(vsi->rx_rings[queue_pair]);
-	i40e_queue_pair_toggle_napi(vsi, queue_pair, false /* off */);
 	i40e_queue_pair_clean_rings(vsi, queue_pair);
 	i40e_queue_pair_reset_stats(vsi, queue_pair);
 
-- 
2.34.1


