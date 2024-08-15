Return-Path: <netdev+bounces-118958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB975953AEB
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020031C225E9
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 19:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B33E14386C;
	Thu, 15 Aug 2024 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hxhnZvhQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CF013AD11
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750590; cv=none; b=i3v/Zt5rLArObn2j4nNS1DGKgl8Ecwbpyvc+gkgIfyqg/uHn2ycWrpSqnig4BWiC+GGjAgZYAChjDp7z/az4zpkyOOO9Weo3FEkdycSrIe348mQ8bScIWVziEyh3HQx2sO+cBBatVBTzH2x8hNQaW55mtlhPmEtSLplIfwsGW3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750590; c=relaxed/simple;
	bh=Skx/W98s0OlT3RwKTPnsB4maHdk8wwKmbbaMdIKJlQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HOqNwGWs0a4U2BNK5M6gYacGJOg+icLSaXajO1948IIPqk3yYb073tvo6SU/vuUu+yn/rPg5Y5Uzk7/QpOA4bL8YWV771sD4vxyRyvLmU1LS8O+jYsxRrOYObtgiO5budICrMOHOlCCr+fZ3gCe3VDKwhQR92N2YGAgMN+NQZ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hxhnZvhQ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723750586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mS/XIHwO7Vk4ocj6oR1f4FPm+sxNBxQSiDNNRlZ+GRw=;
	b=hxhnZvhQUOPTc6d8r1wrCKAE7xhQHxRrW0CiCGtj7PcJ1MXdf59voT/FRZxv2qw7GnBnpB
	VXSapOfCL5BPff04QtlRnXfjWOxmj/JeBmaV8pvKwMQvkV+3pkXlMDKcfXIPiswVcyRUEe
	PYCHzE2jo5pApx81G9SaOdVxK61u5+Y=
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
	Sean Anderson <sean.anderson@linux.dev>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 1/5] net: xilinx: axienet: Always disable promiscuous mode
Date: Thu, 15 Aug 2024 15:36:10 -0400
Message-Id: <20240815193614.4120810-2-sean.anderson@linux.dev>
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

If promiscuous mode is disabled when there are fewer than four multicast
addresses, then it will to be reflected in the hardware. Fix this by
always clearing the promiscuous mode flag even when we program multicast
addresses.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
---

(no changes since v1)

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


