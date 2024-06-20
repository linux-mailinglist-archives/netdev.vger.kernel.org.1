Return-Path: <netdev+bounces-105449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 825CF91136B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 22:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DBE0B23AB0
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 20:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8447956B79;
	Thu, 20 Jun 2024 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ivHyultX"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2083955C36
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 20:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916002; cv=none; b=FbOyzswtwo9J3valjM8eE+vw+UOI7RwcJvjGzxiO7/qHnH1z8mN8TIUrjCdWovvta2qtyug/epmb7DkGVl16Gz78EL78Cmt+YyvpQJuspf0dMCU6qKFjVYsyJT5QeaOArOa+/vSkKPyTMUrrmJuFtgTSiFldw81hEcyk9wRgnlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916002; c=relaxed/simple;
	bh=s7BTJbemocdw+s0zmwLk939JffdFSKdopEy9j4Umws8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EMuW5gnFhtp5I3NH7uSJ+Vhe6eCaqnOPHNkA0+04By0lZBwNXZ6buTCVoUpx/ppC4umGXTD47hrfzwmnE6w8VG0SAA7AM5Azb9JQAJKd02lW8lW9wyeeSau9l/1wLkzJm8yDMz/W7ZuMHChRfxFoqFotJxvIIdOgeOwrL2nMxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ivHyultX; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: radhey.shyam.pandey@amd.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718915998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9hEvZj7KTUp+SFyAwL4LjSQillxUYTfUVh1c3m1V7zE=;
	b=ivHyultXWwMixKZJYE18IKdqfZ2Vb4NOSs1o46nGUiHivVJX6f+3nGGE2Kox6DA1Sc2Nya
	ytjxuGAcideHzhgSpHZK6673EboHeKWfJG4kigeNz0q0rwwUOdilu/aWPsl5UYY5XcaIaP
	GK9yTbNnrYODVZgufWVB8ZtGR3I8Wqg=
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: davem@davemloft.net
X-Envelope-To: edumazet@google.com
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next] net: xilinx: axienet: Enable multicast by default
Date: Thu, 20 Jun 2024 16:39:43 -0400
Message-Id: <20240620203943.813864-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We support multicast addresses, so enable it by default.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index c29809cd9201..af68a59797e7 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2254,7 +2254,6 @@ static int axienet_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ndev);
 
 	SET_NETDEV_DEV(ndev, &pdev->dev);
-	ndev->flags &= ~IFF_MULTICAST;  /* clear multicast */
 	ndev->features = NETIF_F_SG;
 	ndev->ethtool_ops = &axienet_ethtool_ops;
 
-- 
2.35.1.1320.gc452695387.dirty


