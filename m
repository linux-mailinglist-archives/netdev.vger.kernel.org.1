Return-Path: <netdev+bounces-124674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC7696A6C4
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 20:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD3328978F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DA619307F;
	Tue,  3 Sep 2024 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NShfBAY3"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607081925B1
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389027; cv=none; b=H7TWcCx8AiAUIgLvvNrmSFJc48XG//q/Sz8ErY/YgGIB+GZqrFOUzx1+U40VB065uTLF4rx1Vhz4ccVQG4DLJ5/iNp7nbYg8QOKMTYZQns4TInrbRRaD8H5YHu+vOMCjh6SeXkxaSBx2OalJ+WBYfbWaaxHhw1ekJL2qoBPKeeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389027; c=relaxed/simple;
	bh=KeK2MGRF1ZYh5LMH0RB6iuHxz/h3nIj2WOQi1Ys8Y/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=On74dBhtRBF9+0arcUSls1T5PBclReAd0336Zhy0kUut6RTEooAevi6kLVqTtalKQEyI6i/of/QPEoDd3ni8cwg7G5+E05sYma03/BoBIKEy5EXiD/ZJzcNbT2DoXkxi2pAhLwVYZzUSuB+c+1hj4pSmUQeVCWf5RaJWQI5KJNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NShfBAY3; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725389023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NXxxYldboyxzE9Wae39eG+jfv6vdAxMeW5NxEwKdx/M=;
	b=NShfBAY37foLKXLE9aUjjeK3vDl801KxB506r4Er5d3tmzGPfCbIpWBGTou+3GFI8NfF5i
	90tu1l92vHrC3vdGDDMvRjlM5E4YEYHV/gvyDX1cOz3JDy5JD3dIwWl/pqlkoTeX1NpEZ3
	DvYLzfI1nBmFv4c9acb/gOFBufMnt7s=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 2/3] net: xilinx: axienet: Enable NETIF_F_HW_CSUM for partial tx checksumming
Date: Tue,  3 Sep 2024 14:43:33 -0400
Message-Id: <20240903184334.4150843-3-sean.anderson@linux.dev>
In-Reply-To: <20240903184334.4150843-1-sean.anderson@linux.dev>
References: <20240903184334.4150843-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Partial tx chechsumming is completely generic and does not depend on the
L3/L4 protocol. Signal this to the net subsystem by enabling the
more-generic offload feature (instead of restricting ourselves to
TCP/UDP over IPv4 checksumming only like is necessary with full
checksumming).

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 60ec430f3eb0..74fade5a95c2 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2632,8 +2632,8 @@ static int axienet_probe(struct platform_device *pdev)
 		switch (value) {
 		case 1:
 			lp->features |= XAE_FEATURE_PARTIAL_TX_CSUM;
-			/* Can checksum TCP/UDP over IPv4. */
-			ndev->features |= NETIF_F_IP_CSUM;
+			/* Can checksum any contiguous range */
+			ndev->features |= NETIF_F_HW_CSUM;
 			break;
 		case 2:
 			lp->features |= XAE_FEATURE_FULL_TX_CSUM;
-- 
2.35.1.1320.gc452695387.dirty


