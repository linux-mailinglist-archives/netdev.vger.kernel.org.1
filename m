Return-Path: <netdev+bounces-126588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725FF971ECF
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038CC285A31
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CB6149C70;
	Mon,  9 Sep 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VDXSUXZa"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D6213B791
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898229; cv=none; b=u9qGfoLSG3VPOx3mirVjdNpulT4EOmtlBI6GeoLIc4rvwZC855Ndgxz3W0CKMTbQY6RC7VlbbLUzvaOpGs3Perjbs/t4jtke/x7LptbCdpItafvnRgHTyJzERFAamM1mX2v7NurkrWhUZlq8HHg0cXC7xBMVnAlFbTgmKuLHvn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898229; c=relaxed/simple;
	bh=CQsiWsQcmwleceLG+n+fiW0zTH07SvRAhpUPi6TMEbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Impmcnh5/9VOEci/LX5gwro0vqyRTpuz0fDZJjAeF38YN2WHU3sMj9x5KtlYtrgBSGHnf//uCPgekv/dpVaKbSBdTuQ4ZUEwJQ4FD4mB0I+z6PDqQDbvjG6haW/fQgKsqWGRxRKbo8H5XL9T46D/Gp+MqZXmIZ9xn1QT3j379Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VDXSUXZa; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725898225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMGpZzRVl3cnTirggChhJzILzss8nbtBZB80hg8Yk5I=;
	b=VDXSUXZaJtjoEYkXI6+e0AyWJ1BxqXymHllkD0Q8foYU3h9SHSCt20qSkug7p5t6JSmk/K
	zFtyfRtpmc6Ul28NRKYqFeq3CdJjA8DL5I0afYX4pDwmdU7LSW0KopS2d3bqv/9uAZHrVA
	xkvBYrgDoagwqWCgCjkiZXl97P4TiHc=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 2/4] net: xilinx: axienet: Enable NETIF_F_HW_CSUM for partial tx checksumming
Date: Mon,  9 Sep 2024 12:10:14 -0400
Message-Id: <20240909161016.1149119-3-sean.anderson@linux.dev>
In-Reply-To: <20240909161016.1149119-1-sean.anderson@linux.dev>
References: <20240909161016.1149119-1-sean.anderson@linux.dev>
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
Reviewed-by: Simon Horman <horms@kernel.org>
---

(no changes since v1)

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


