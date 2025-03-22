Return-Path: <netdev+bounces-176872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE99BA6CA93
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AFC2482427
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD4C194A45;
	Sat, 22 Mar 2025 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DeNqLznq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cbNd7T/i"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A6948CFC
	for <netdev@vger.kernel.org>; Sat, 22 Mar 2025 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654004; cv=none; b=NmuIKuwCs6FK421ECwXOIkf7cMlkyp4dMXjlZ2Prk0hmeko9cEuxBF67PW632pLihD+GKVnQvW6pSGXnKut9f/qLq4RHq8UbzHQptXg2AhDxbF7zHjkLLhhPhmYYhJiJ9EHqYIGG8tXr+nmwFZOfX9uZAyOVM1M2EU3/T6XGQbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654004; c=relaxed/simple;
	bh=kcRn4HBho9m3db+BB6ivPcR/JdXbyiyvmR8Twf3qCcM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y3vjH7qMvDFGYxuO3YCmu8C4c2eczq8nkuQUp7BfIkQiFo9b4Kn+JUIFngyq4JqttO+41pK8r3kutSY8JMK+6NZn6T2414/VPtKIKAumoqDg7La6Hspdgd8HPFcAXD7mv+5sk7Xu83VKhrb4/2aIuMGPNf2S+Y3DF9E5Dy+ZrCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DeNqLznq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cbNd7T/i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Benedikt Spranger <b.spranger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742654000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EpMSSbYPI50BVfH8jegXiRdz+FPp6c4SSn4KX3lpIws=;
	b=DeNqLznqyMIPefcBtp6+0ip4ai2VLzeOlZdh1Z6q4jc9jO8jiiSYzEm/twSnbKDT0GVEzo
	STzV3vtlnQFtwFciumKZhtW/woJt6QoLJC1Ne4LojSan4MHo2Qbfaw+GC73THMSNiOyoFb
	T/2GBGhU5HLcb8gYVhfDS+Y0MIzZR01LR+urr0i2+IoivczUndrMEcMwBKEhZaBbqReEZ9
	nT32hQHP81PrNqTZWvqCWKiNWSNRx0uDB3Q34+Do0qu+d1Udum8gcQkfyCo9YeEp69lim+
	zCwcnM3xRH3ul5/qCKgdAd+sOLeW7KGzFaOqe04rX7WQDxb9Tj4bNd1+7Q7wGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742654000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EpMSSbYPI50BVfH8jegXiRdz+FPp6c4SSn4KX3lpIws=;
	b=cbNd7T/igeGrAeQ09oQ5hAv1WDX6eD/WRCEXE6B296Bgr+D2tnC5E4GqRIQMrhi69PwZYL
	VOiNKZMJckDJHeCw==
To: netdev@vger.kernel.org
Cc: Roger Quadros <rogerq@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH] net: ti: icssg-prueth: Check return value to avoid a kernel oops
Date: Sat, 22 Mar 2025 15:33:14 +0100
Message-Id: <20250322143314.1806893-1-b.spranger@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_get_ethdev_address() may fail, do not set a MAC address and return
an error. The icssg-prueth driver ignores that failure and try to validate
the MAC address. This let to a NULL pointer dereference in this case.

Check the return value of of_get_ethdev_address() before validating the
MAC address.

Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c     | 2 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 9a75733e3f8f..273615c8923c 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1152,7 +1152,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 
 	/* get mac address from DT and set private and netdev addr */
 	ret = of_get_ethdev_address(eth_node, ndev);
-	if (!is_valid_ether_addr(ndev->dev_addr)) {
+	if (ret || !is_valid_ether_addr(ndev->dev_addr)) {
 		eth_hw_addr_random(ndev);
 		dev_warn(prueth->dev, "port %d: using random MAC addr: %pM\n",
 			 port, ndev->dev_addr);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
index 64a19ff39562..61c5e10e7077 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -862,7 +862,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 
 	/* get mac address from DT and set private and netdev addr */
 	ret = of_get_ethdev_address(eth_node, ndev);
-	if (!is_valid_ether_addr(ndev->dev_addr)) {
+	if (ret || !is_valid_ether_addr(ndev->dev_addr)) {
 		eth_hw_addr_random(ndev);
 		dev_warn(prueth->dev, "port %d: using random MAC addr: %pM\n",
 			 port, ndev->dev_addr);
-- 
2.39.5


