Return-Path: <netdev+bounces-118961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E40953AF1
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0872854E5
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 19:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A786A14E2F5;
	Thu, 15 Aug 2024 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KrhOF7ys"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED14114B97E
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750596; cv=none; b=hCQatpt5zMwSL4HirYF14W+ipZ1JIzuiHlJSh4dkpqmWCCpqBOsBjWDrdmcgap3LZRgbw9omZlH9iAAvWXJYVLBIzkCByOHGk6YmTVLNXH7i3xDliUFPCgm1B8TpLDkAZwzN9bEiEBisT9/jeyOxkDp+2Q9ZdG3B7TZMCOh2jJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750596; c=relaxed/simple;
	bh=ohkkFUnqbh4Vd2LZ82fswrcHzKTNgmRmp+nkzLCog44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vm6FUENgaK+748HSsqkR/wLzXM4rPRNPQaXJmYBR+XY4pWRFk+ZHyjPw+e1cmqPYgO0624e8NHApmjndS64u049fe0LhlHrOGND9jcb/+wOhcr3OwcyHvbENFeq0PjkRr9GxSf1TtgCiGPVsViSAUkMCBHMZHPsEXeiX0cjmQbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KrhOF7ys; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723750593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOE+kJnrM8Z+EXIGAGr3PIq2L8K9D/ZSsUhQaL+mhn8=;
	b=KrhOF7ysLNWCz24ekEIv4aNhHCNrSGD16ra/3Rw9ygb13p6se8RBZgQpZmoZAaJPSkOLuY
	7iXPp4uR7Gj84hvlSAqgF0fsOWr9Yx893woeXqFJquZmjQ1x6ggP/iekfbToGA4Gln7brb
	oObjb81uOda6z2t0gusYdINxe5FFVNA=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v2 4/5] net: xilinx: axienet: Don't set IFF_PROMISC in ndev->flags
Date: Thu, 15 Aug 2024 15:36:13 -0400
Message-Id: <20240815193614.4120810-5-sean.anderson@linux.dev>
In-Reply-To: <20240815193614.4120810-1-sean.anderson@linux.dev>
References: <20240815193614.4120810-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Contrary to the comment, we don't have to inform the net subsystem.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Split off from printing changes

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 9382ce50aeb2..9bcad515f156 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -439,11 +439,6 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 
 	if (ndev->flags & (IFF_ALLMULTI | IFF_PROMISC) ||
 	    netdev_mc_count(ndev) > XAE_MULTICAST_CAM_TABLE_NUM) {
-		/* We must make the kernel realize we had to move into
-		 * promiscuous mode. If it was a promiscuous mode request
-		 * the flag is already set. If not we set it.
-		 */
-		ndev->flags |= IFF_PROMISC;
 		reg = axienet_ior(lp, XAE_FMI_OFFSET);
 		reg |= XAE_FMI_PM_MASK;
 		axienet_iow(lp, XAE_FMI_OFFSET, reg);
-- 
2.35.1.1320.gc452695387.dirty


