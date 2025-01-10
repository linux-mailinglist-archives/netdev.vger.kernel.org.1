Return-Path: <netdev+bounces-157249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 104E3A09B92
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 20:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3841883E83
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 19:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B7924B241;
	Fri, 10 Jan 2025 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XC9M9cSJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C2D24B22D
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736536061; cv=none; b=AywH0kD6PEbQEIJD3MLIbWd51Ei7x/QrZoHtvOE8TTdEXwG1I3ER2E0oV02J3biqextUhNKM/PWbPyV3hJcR7tYGJV6CYDGCQS9N463GjiSlhcXGDQqL5P+G7Z5kVqxExB20FZP/RRoyVznapJQ2vOO//7ke1BESgqe89yFKMPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736536061; c=relaxed/simple;
	bh=KCL+F3ZBiVp7S6w6btnWil5iVTUJLoPCUmlAxkVrrl8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cAxrYCC9hbOWQgSF2CHAwTQGroxzqUuOUaK+/mMd/K1tm9EJJQvlluWu96KlRLD9yGcHHJy1/aofHPl5vI8lZ7oRg+4kqaqlVCv2SePncdvu7NptlZxubWoPD4xumll1FTmHtB1GzFYjesHXzZuJKjn9zd8nQEGekRuFSMX2iXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XC9M9cSJ; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736536052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+kM2FTpXy8ZmYhwW5UZBRCdatTgzuJbmml/gqdxsGN4=;
	b=XC9M9cSJuMKjTnzZAlen+eid4xpKY64wWT+ORSRFEVGJNvdJA/YnfKVdfDFOrs9OKKVs+s
	xqT0fmfH+8I8DB7vjS8U7V8PHSr9fGRdmZQR5O97eEkfAuvr32bbxAEBwEfI+rpAjdcS9s
	xCjdPOZvPOot3NIoSsu2e9jyijXBliQ=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Simon Horman <horms@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net v4] net: xilinx: axienet: Fix IRQ coalescing packet count overflow
Date: Fri, 10 Jan 2025 14:07:26 -0500
Message-Id: <20250110190726.2057790-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If coalece_count is greater than 255 it will not fit in the register and
will overflow. This can be reproduced by running

    # ethtool -C ethX rx-frames 256

which will result in a timeout of 0us instead. Fix this by checking for
invalid values and reporting an error.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
---

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


