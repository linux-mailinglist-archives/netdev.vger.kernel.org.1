Return-Path: <netdev+bounces-157812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A67CA0BD97
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD9B7A489E
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B912D22BAB5;
	Mon, 13 Jan 2025 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="goFtUNsy"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B23D22BACE
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785830; cv=none; b=odVd8JURacMcEFM2LlcA34V2vfSuVvPq0ML276ecRbNE0bviOfP3/dtyZr581PHTjQQAl2Erq63AcvGeEqRAo91pxpA97GLMbpRsNate3wxu/L0cE/8aDfHcenjyn2CVcG7FIkemL/wugAjbAxe2vgVSKD911PmKFbdujBTcjDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785830; c=relaxed/simple;
	bh=vn17tQTRifoU70IvEay/XlrsOY6DOtxSrwCeMLSZhpY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YWh5+Hh043nZTk17JsryRxkM7QkWRHUUVOn6iNx3L3zDWXAy3ilogEJaJ2ReYzO7e34pM+6Nnrhzx9jX7cuoj9avPN+Umuv5xpjRWG2Zhbsfkig8D091SfwRpcvtnULao544zO+cc3w6GglNr8nAvq5vJTBKlEk8bHZUo9PgW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=goFtUNsy; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736785815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pl+wZ2x+ZdqTG0lEglmVegKw0Hhj58CtH64CcDGmvHU=;
	b=goFtUNsyFKOML04zHS6B/aG6lQPGVAgvkHREkRd2ONO2kArsAR7tInmmevzqhWY7ZgLB0p
	qj2BwfUGVQtBR2KQBzOMycMYLcIVBaKzWuFp0SRU4pNkNUo3I2Fuefx9NpdXGEL+H6AWu3
	TK6FoJ+cChKKcMoOIWi3B7rC1oB5+S4=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Simon Horman <horms@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net v5] net: xilinx: axienet: Fix IRQ coalescing packet count overflow
Date: Mon, 13 Jan 2025 11:30:00 -0500
Message-Id: <20250113163001.2335235-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If coalesce_count is greater than 255 it will not fit in the register and
will overflow. This can be reproduced by running

    # ethtool -C ethX rx-frames 256

which will result in a timeout of 0us instead. Fix this by checking for
invalid values and reporting an error.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---

Changes in v5:
- Fix typo in commit message

Changes in v4:
- Fix checking rx twice instead of rx and tx

Changes in v3:
- Validate and reject instead of silently clamping

Changes in v2:
- Use FIELD_MAX to extract the max value from the mask
- Expand the commit message with an example on how to reproduce this
  issue

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 0f4b02fe6f85..ae743991117c 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2056,6 +2056,12 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 		return -EBUSY;
 	}
 
+	if (ecoalesce->rx_max_coalesced_frames > 255 ||
+	    ecoalesce->tx_max_coalesced_frames > 255) {
+		NL_SET_ERR_MSG(extack, "frames must be less than 256");
+		return -EINVAL;
+	}
+
 	if (ecoalesce->rx_max_coalesced_frames)
 		lp->coalesce_count_rx = ecoalesce->rx_max_coalesced_frames;
 	if (ecoalesce->rx_coalesce_usecs)
-- 
2.35.1.1320.gc452695387.dirty


