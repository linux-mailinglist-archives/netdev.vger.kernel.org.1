Return-Path: <netdev+bounces-118960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06A3953AEF
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96CD9284D38
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 19:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D7F14B092;
	Thu, 15 Aug 2024 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QFnW878S"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C4149E0B;
	Thu, 15 Aug 2024 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750594; cv=none; b=F2fEbxlTfysyl0mraVdi36Lrfr7euzA7vCbK+PIbMJi4uYTYTRk3vhayqS/4a6dtPBnP3+q6wuwReXrEszAMACB3nbdeuw5MCEIqwg1NgSUkIB26hHXk4q6gtyFNj1OY1tL7MDe0phV+opQaDzOkDu0ha76PBBfjSAGjcipSdnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750594; c=relaxed/simple;
	bh=XPaWYO6owNRbtDyquLZp/UZeQgBynT+pRI3oW7gXEcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q44389exxJzpXeUCgO5EifIa2CX+ASoW+pJ1EnU9IbdBATcLecOanpPJdoJNvihXR46oNPTdq47pM3Pzjzw1Ku06Aev5JPJzJKy7J3SFekcW6TOm97PEMZES06kkavDtOzDeX8zE9dVE7ouekhE91UIdnPVqypxl9LLRKAlYvho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QFnW878S; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723750591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6Pbw/gYocam4sHjqG9NKdaOppoUOzZ4RTkpagayTFk=;
	b=QFnW878SNScRGr/LBVWBwF7PYlcMlJEOQpa3vCVSVbT53mLoUhOjz7tLU0yTOl3qWHJXWZ
	kLsNxvOEVDwD36UxRr27lmGxFj6dROh3R81AL22hQTP9m1w3QgZ6ok+oz66sHroYDmOVN+
	8ygHBHdMJIuxOm1ucNrhEnSPmGsZCc4=
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
Subject: [PATCH net-next v2 3/5] net: xilinx: axienet: Don't print if we go into promiscuous mode
Date: Thu, 15 Aug 2024 15:36:12 -0400
Message-Id: <20240815193614.4120810-4-sean.anderson@linux.dev>
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

A message about being in promiscuous mode is printed every time each
additional multicast address beyond four is added. Suppress this message
like is done in other drivers.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Split off IFF_PROMISC change

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 1bcabb016ca9..9382ce50aeb2 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -447,7 +447,6 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 		reg = axienet_ior(lp, XAE_FMI_OFFSET);
 		reg |= XAE_FMI_PM_MASK;
 		axienet_iow(lp, XAE_FMI_OFFSET, reg);
-		dev_info(&ndev->dev, "Promiscuous mode enabled.\n");
 	} else if (!netdev_mc_empty(ndev)) {
 		struct netdev_hw_addr *ha;
 
@@ -481,7 +480,6 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 		reg &= ~XAE_FMI_PM_MASK;
 
 		axienet_iow(lp, XAE_FMI_OFFSET, reg);
-		dev_info(&ndev->dev, "Promiscuous mode disabled.\n");
 	}
 
 	for (; i < XAE_MULTICAST_CAM_TABLE_NUM; i++) {
-- 
2.35.1.1320.gc452695387.dirty


