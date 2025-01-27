Return-Path: <netdev+bounces-161095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A1DA1D4A7
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 11:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC32160A77
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 10:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6097A1FC7DA;
	Mon, 27 Jan 2025 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJpAcIEh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934F27603F
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737974327; cv=none; b=lypmDRNto5thIfRF/oPZgXzg1UXOR8vcE03Nm17s72xrUbFkSYcpIpd1f16RILh+fgPrY68r1VSauTPi1VjT1B2cqgtcpF0IN/mpLY8paSoi3IJFXi4jYw+lmKWGQjuFMffZaiK3KOCkwZPk1i2d5Y44FnHaRuu057toJzyYJes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737974327; c=relaxed/simple;
	bh=vP2LTKP+qu0xqj75CnvY4A/++gLHdUEBTltNI3EcilQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLUEjQMy1l5vS47Cb/UuNwCkgdOqDbDnerVm1nIcK2GYpGv+iheGqxuLW//xckIkqXVPSeFS7CyDJ0AzBI/89PBt8ZVV/A44qQAiabXsCFYGlx/a6josCdM320uCc9GEf8N6OnjdF8syQHfXmjRC2u6JY3yLdr8dN9kg8K2Ii6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJpAcIEh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737974326; x=1769510326;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vP2LTKP+qu0xqj75CnvY4A/++gLHdUEBTltNI3EcilQ=;
  b=WJpAcIEhap6RZb6thziKT4KBaykLYf8pVpyuvswtIR3RuFy560Ej0GVS
   GukErptziRKdZVobx4uux3qc6jo2VwccwbjnxkH2s1F6KEcKDPzDQn9wp
   ALCFAOSSVagzlzjxT4BQKAaMnVi5pLnZJAgSbVWjPqpuXo28eB0eBPeQn
   gfGGjahmoWux9CqVn3NT8k1DtBFHPv5Mv0JYSdp0UauuXl+NGCrH7MHo+
   kyndyIhLcGz4GEgNap0eowH+k66oWohILN+SAuGaUTFylKQtJbYAn9pnn
   KAeb6LdDx8LL+uPABaMkgH2jWk8SKtMw1WfpoSKuIED7pQGxyFi2g00Uw
   Q==;
X-CSE-ConnectionGUID: at2pLU3DRjyK+ui7AzoKsw==
X-CSE-MsgGUID: i3XWwnkZQ+KM9jqbDTEnMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11327"; a="48932147"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="48932147"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 02:38:45 -0800
X-CSE-ConnectionGUID: 9G6J6tHrTGeK+AY0/qiByg==
X-CSE-MsgGUID: z6KFdYhbSxaMvI580DNKgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="145617408"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.245.87.141])
  by orviesa001.jf.intel.com with ESMTP; 27 Jan 2025 02:38:43 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	dan.carpenter@linaro.org,
	yuehaibing@huawei.com,
	maciej.fijalkowski@intel.com,
	przemyslaw.kitszel@intel.com,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v3] ixgbe: Fix possible skb NULL pointer dereference
Date: Mon, 27 Jan 2025 11:38:36 +0100
Message-ID: <20250127103836.4742-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in
ixgbe_run_xdp()") stopped utilizing the ERR-like macros for xdp status
encoding. Propagate this logic to the ixgbe_put_rx_buffer().

The commit also relaxed the skb NULL pointer check - caught by Smatch.
Restore this check.

Fixes: c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7236f20..467f812 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2105,7 +2105,7 @@ static void ixgbe_put_rx_buffer(struct ixgbe_ring *rx_ring,
 		/* hand second half of page back to the ring */
 		ixgbe_reuse_rx_page(rx_ring, rx_buffer);
 	} else {
-		if (!IS_ERR(skb) && IXGBE_CB(skb)->dma == rx_buffer->dma) {
+		if (skb && IXGBE_CB(skb)->dma == rx_buffer->dma) {
 			/* the page has been released from the ring */
 			IXGBE_CB(skb)->page_released = true;
 		} else {
-- 
v1 -> v2
  Provide extra details in commit message for motivation of this patch.
v2 -> v3
  Simplify the check condition

2.43.0


