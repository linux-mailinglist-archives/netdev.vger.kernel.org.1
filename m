Return-Path: <netdev+bounces-117828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4AF94F7DC
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 22:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273951F22CF5
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 20:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5269194A49;
	Mon, 12 Aug 2024 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wuJ+bUQq"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0DD19306C
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493098; cv=none; b=F5ao0mFkXgw2qztK8KQ9AszngyNzohbhibxZRebwRFLgR26Fl3+OG23Px1Jvz5zMeaTD0p7lQj+QMsePrzMTVTlBqK7BmYIgGJyoOeb+pXbXwqQoDDwt53cp9DmKtiI6krk1qsDvGBkbDKz8zVYYLZUO24zmnOWKQOZ77vbUDzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493098; c=relaxed/simple;
	bh=8qqJ2M6QmRHIYqEZTpFUWVHybdpD1qKfOP5hlQ4StiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JKrleDZU7YDoUOuw4Y+fJihemZGnJ66T4m0dEhIt19h6UolvSb08HJtKex9d8JbFmXdkBmrFRHOvKO7f3i72ySgLi4bgSbbYO15gExgHqWZE/6qqdF2b1xtgQGWjV4mPiZqYDzk3E4XAGUWk05Yn14yBhykBZw4/yrmuJYUXm90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wuJ+bUQq; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723493095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2aEOu7t9R2rrRYQa/tCBbrIef976QFuVjDof5KuWorE=;
	b=wuJ+bUQqmA1t8WZh2560Iy9mVSd4EB1b3t+TOK8Oap1ftO+/ZV+gTC9AzYJ4/FANBqyZkb
	+x92iV8nQkS63VrUuB47v1x3sBDsgi4bSElOHokJveG3ydfD7orarYxsP7+vGp2ftm2NM1
	3RxgnjOUY2xkZu1vRqtC0zQ7dsPjKho=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Michal Simek <michal.simek@amd.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Ariane Keller <ariane.keller@tik.ee.ethz.ch>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next 1/4] net: xilinx: axienet: Always disable promiscuous mode
Date: Mon, 12 Aug 2024 16:04:34 -0400
Message-Id: <20240812200437.3581990-2-sean.anderson@linux.dev>
In-Reply-To: <20240812200437.3581990-1-sean.anderson@linux.dev>
References: <20240812200437.3581990-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If prmiscuous mode is disabled when there are fewer than four multicast
addresses, then it will to be reflected in the hardware. Fix this by
always clearing the promiscuous mode flag even when we program multicast
addresses.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index ca04c298daa2..e664611c29cf 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -451,6 +451,10 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 	} else if (!netdev_mc_empty(ndev)) {
 		struct netdev_hw_addr *ha;
 
+		reg = axienet_ior(lp, XAE_FMI_OFFSET);
+		reg &= ~XAE_FMI_PM_MASK;
+		axienet_iow(lp, XAE_FMI_OFFSET, reg);
+
 		i = 0;
 		netdev_for_each_mc_addr(ha, ndev) {
 			if (i >= XAE_MULTICAST_CAM_TABLE_NUM)
-- 
2.35.1.1320.gc452695387.dirty


