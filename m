Return-Path: <netdev+bounces-121094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4631395BABB
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 17:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73DC11C23158
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610101CDFC3;
	Thu, 22 Aug 2024 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r2dEk7DT"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2731CDA23
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341291; cv=none; b=DVTX38dopjioVTcMBhBKq/kEnzXP93OHIFlSgg2Dz4k7m48CURUSHkgCnAKO6o98eWdsVJt6hzDmO7AwLgf4hv9Grhkz7SWKx1Ecf0ZlkoI05KpSo5W/LHm+JpxKb6rnH8Y/023eHn6TsKP8mH90tUAz0UUype5HdR9TtjD3CCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341291; c=relaxed/simple;
	bh=t7Xgw5NCVuK76Fz/E17ZKV8gj8CWvvXKXFCDS1nYvac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E8usjzNyIb+Q0bPTh3YSVW3UIo4H2GGY4r3ka//OmW/YkDudc6pRHDE8Ui+1cI1HCuxrK3yP7o1MivjWP77HOLItDKBxDyiin+tAVhwH4WCAUl1hJDx1T1Qx/FGf1B2abGVXaqiW1PZ73Y1Ynmog4REt/UVHWXyeRUqOZ0ulTV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r2dEk7DT; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724341288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4y1OuMckJ3uTXKaUmgng1b/Utw2qqR8UebmEH8zDxio=;
	b=r2dEk7DTgH7boJ7IQiCxQoBkZAH+lrVePjlZ84P9uN3Ysm+E/uTV3k3oxbBgEuowf0kfjj
	XhQbKSi8twLwFkTKlwJNzyQxIH+4EKOkgGqmuYeUTFZkGkq44j85L4BSjgnLzrSzF9lg5z
	aHvICp3mzETUCdpzutJGWQsR1zvlKV8=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Eric Dumazet <edumazet@google.com>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v3 4/5] net: xilinx: axienet: Don't set IFF_PROMISC in ndev->flags
Date: Thu, 22 Aug 2024 11:40:58 -0400
Message-Id: <20240822154059.1066595-5-sean.anderson@linux.dev>
In-Reply-To: <20240822154059.1066595-1-sean.anderson@linux.dev>
References: <20240822154059.1066595-1-sean.anderson@linux.dev>
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
Reviewed-by: Simon Horman <horms@kernel.org>
---

(no changes since v2)

Changes in v2:
- Split off from printing changes

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index f612adb07a25..5c4a5949a021 100644
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


