Return-Path: <netdev+bounces-102631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94636904041
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 17:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6EFF28285E
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC243376E9;
	Tue, 11 Jun 2024 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dGNevke6"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE2D1BF53
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718120504; cv=none; b=NDPriWPYx+62pH+yYHUx/6w7rSp/XbmCv627d/5ir8lgqbeEFgfk5aU7roZ9fOj8nmjNaWS58zz0fv1YEkgn8g9T8uz6O+mrnBd7Qx4ZwAlLqHqtP3iVj3sLqE9sMpZ9U1JluXNqSsUUa5ejPWeq9h8z1FygORJgSXmOvv1HSY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718120504; c=relaxed/simple;
	bh=E7PkwxBj5hvjoSwhWq7vLXyWlMSKGIv0zHOZ74URHic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q4i4VvPUNGeadjMyFVZW0juKU/SUYqescmycZxB3MHVVaeATfD2jvhwYT2l8LwyaL2HZ2VZKFmmNm96wRcCG07rKpaOH3/247uBBBzDbPvxb0xIJt+vgvfzOD7oLu7e3C61gKILe35RfW0eVkvwEgSAS2MBbUvdvaWbwrxx+XpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dGNevke6; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: radhey.shyam.pandey@amd.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718120500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z0Vgu6hdIvIVHzLZcergBK6nr3ePcLKNG4v8w8fbW/8=;
	b=dGNevke6WTxqQAkrfIqw7QRNI0mRnNauqDnz1hh7etTXzDWMMq6lWSatpTUZyMvsPlZb66
	afA3090PWTNdLC/gZ6UqGAhlIC80BR7ABNilvA01aa6kYf30ZbkfQlJW8gp5YgK/4fTsYg
	AIGtZK7Y8MTD4Qlfd59KKs5B6duTrGo=
X-Envelope-To: andrew@lunn.ch
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: kuba@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux@armlinux.org.uk
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: edumazet@google.com
X-Envelope-To: davem@davemloft.net
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Michal Simek <michal.simek@amd.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v2] net: xilinx: axienet: Use NL_SET_ERR_MSG instead of netdev_err
Date: Tue, 11 Jun 2024 11:41:16 -0400
Message-Id: <20240611154116.2643662-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This error message can be triggered by userspace. Use NL_SET_ERR_MSG so
the message is returned to the user and to avoid polluting the kernel
logs. Additionally, change the return value from EFAULT to EBUSY to
better reflect the error (which has nothing to do with addressing).

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Split off from stats series
- Document return value change

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index c29809cd9201..5f98daa5b341 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1945,9 +1945,9 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 	struct axienet_local *lp = netdev_priv(ndev);
 
 	if (netif_running(ndev)) {
-		netdev_err(ndev,
-			   "Please stop netif before applying configuration\n");
-		return -EFAULT;
+		NL_SET_ERR_MSG(extack,
+			       "Please stop netif before applying configuration");
+		return -EBUSY;
 	}
 
 	if (ecoalesce->rx_max_coalesced_frames)
-- 
2.35.1.1320.gc452695387.dirty


