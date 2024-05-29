Return-Path: <netdev+bounces-99007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C67308D3581
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B890286569
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D75C180A61;
	Wed, 29 May 2024 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtDEhBj+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B13180A67
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981838; cv=none; b=tMaBQbEmHwKFZFVtMM4/THnSKk0xC0WmSmpeQVeySfmjlGMfZ2W3cL0psofjk7azyns1ijJWpsqpoXhHkzHAZlmPa7gZ3dA41jxlMFg27TerwLFbd1vks8udLqZq21tTbtX/WAT1t+d7KhIozsr2SrVTcZ6OUAn4iQI4v7oIxe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981838; c=relaxed/simple;
	bh=4Tu1vWmHZq1dZhCwiajusm9P0b3jYlUYGR9h4gmDQJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oxNru+K6ybJAVnTB/C5hmYZp5MoJv+wSFjjWb8hOUniZKOusgzUp/hF1C6L+RXF2NtT8mTJT7/RD37EWs+IqoWw0R8d9QNb/9vyLaIgcfpPE/8/Ebf/SoCR9LVlaaXRIxUKa9tq2/RGutI8sjq2LnUg1rA6A1AObVD6zjmDQ82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtDEhBj+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716981836; x=1748517836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Tu1vWmHZq1dZhCwiajusm9P0b3jYlUYGR9h4gmDQJg=;
  b=dtDEhBj+EjK3FRcY1TM/418/UEgaYupxm4MOHluGXUqwQ2qAwrel6wS8
   KQD+2F5pcGjzTxo1fce9IYbVcP51r2bVLkjjetoy0j9jbGbkTXOyPRmeM
   SBtSsuIp9wqOVwS1zeFeFTLpTxE4mwvcg0I+1lMyrjORHnrw7S0O3Jr3+
   RGoOIbyTFKkJXEZVjWR8vDZjB2azsrJRi3DKySSXGHXl+OHQVNhntLBKE
   InEcDTjL4GbMFul6Ssvqo+Ad+BQ5qCDQpaxLjBXAlm7ZiHjL7HteK8SJm
   UoGMKILS/BP4mMHc6vtPmb1DY6VHs138wpAytXlYx/B1GTYos59boxFXS
   A==;
X-CSE-ConnectionGUID: LLWDE3pDSQa7Z0/NnXJFTQ==
X-CSE-MsgGUID: wdfOZB2NR+yrvir5vH81fQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17169271"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="17169271"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 04:23:56 -0700
X-CSE-ConnectionGUID: 392CfLlZQI2S/ZthPXCXPQ==
X-CSE-MsgGUID: sPVQQvXzSZqGne5ysk4cTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="66277192"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa002.jf.intel.com with ESMTP; 29 May 2024 04:23:54 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 iwl-net 7/8] ice: add missing WRITE_ONCE when clearing ice_rx_ring::xdp_prog
Date: Wed, 29 May 2024 13:23:36 +0200
Message-Id: <20240529112337.3639084-8-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240529112337.3639084-1-maciej.fijalkowski@intel.com>
References: <20240529112337.3639084-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is read by data path and modified from process context on remote cpu
so it is needed to use WRITE_ONCE to clear the pointer.

Fixes: efc2214b6047 ("ice: Add support for XDP")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index f4b2b1bca234..4c115531beba 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -456,7 +456,7 @@ void ice_free_rx_ring(struct ice_rx_ring *rx_ring)
 	if (rx_ring->vsi->type == ICE_VSI_PF)
 		if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
 			xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
-	rx_ring->xdp_prog = NULL;
+	WRITE_ONCE(rx_ring->xdp_prog, NULL);
 	if (rx_ring->xsk_pool) {
 		kfree(rx_ring->xdp_buf);
 		rx_ring->xdp_buf = NULL;
-- 
2.34.1


