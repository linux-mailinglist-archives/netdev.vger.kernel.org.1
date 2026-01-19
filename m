Return-Path: <netdev+bounces-250962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 153F5D39D59
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 05:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4735E3026AFC
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 04:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3389C32F751;
	Mon, 19 Jan 2026 04:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Po6hv+6Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A8E25782D
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 04:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768795505; cv=none; b=plUqT3vzRZ8AArqo4t5wjE033tzXEnaJha37yCy/XjEHRt24FZkJ+BvXhHI5BsdeeLOwqG0scIPni23mmT8fliUjvbcIGfih31S155RyqZ47cHZLpcrfeXmyhFXJWPEmxDfBgt2ta1lyFODYaWhYLD3F99PXnvoC5gi7PZgBPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768795505; c=relaxed/simple;
	bh=omMMPGLjuB3hgtLBWeCI0UZ/vyg/Gcf6AiHP8eo/Mw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dm3UZ/2rE2r8g1BX3OYWoqbv2cpNhzopR9tDc27ViVgsRh8L1VCKdZ3xg23reR3IxgLlg+SvLeZD5W8AKMdQk+XSAu2hXdO+E0Z0RVpZsvcBRkXdvm3xqtIBX57YctjAdPmv0bVCaKhMvhjK9Rqs9alTgqSvqy6HK4QF3wTsfsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Po6hv+6Y; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b4520f6b32so5128775eec.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 20:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768795503; x=1769400303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FW6sIGklWV66uTVJF/toqGaRQQswtCudkXmUdFld8dk=;
        b=Po6hv+6Y26Oin6eXmznY9osMeNxNSjWAMJiTQqWZSJ+As4MXAH0ILvq6bChslP1ZeK
         0AftyyR8Mkq1dpPo2DKUYLmAk0JiibriS1enZ9OY67AXXUsX72N4vf/GKBRjTWIAz0oK
         LDZAZoCp+j+0gw3+hfLxsoTqJNTWBY55yriEFtNEZ6YZ2AmVxJLDm+vliXxSME9I8SDA
         tahMCxADsQiMKvI8W0EiZRdb4h0YqX3aRay9RQ+ql5PavXoqCcrsoVTPhXD6vsdXLCFv
         dLFWBGii6Dug1hw6pGwlAcJp/Nkd6NW7fBjJw102O089En/nI7zMAoneQ5pmFI5vf7+m
         7ngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768795503; x=1769400303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FW6sIGklWV66uTVJF/toqGaRQQswtCudkXmUdFld8dk=;
        b=qf/LVQS9jBEkGLjUC6LCZfwcgi2+rb8HrdKsU50Ge8cz8bBkWCQYjtCkLm4CBpATFG
         oikdgmonFMQcgmYUSt4aQmZIy0vxuZKQt7NBPQtXLldw7O5U5ivn16F2CG+j9ROrmAV/
         PdVVJFLKi/8iiBT7hiEhOPdTWJLS9psOllc164y5WlrJTCMqHFQlnUpbH95YjN85sPTI
         mlsHVEnCVhM34lj9uJ9lKTdb4mOKIdbd5Km7CT8lRPQcAM51h9d/rSHmhmy/ynkaW+Om
         vAsmepHl8DGLCJ/rO4KUHhiidXgQpJWQ8Z7WC3hTU7lLU7QeJ7onafIGjWcfDusqrrEW
         UeOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX51/qoILNBTvN7nOO0gfGh6tVcYhu3SfrGFhZWcPNyfl7aSqELP9ermhu/IWqIJqqwjgHLTBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNDm+9+c3u5dH+q3loKbhVkrYqu27XEp3q7bWEwfvb46vOm35R
	EsFxWkpDrq5Hx+sk+P6YNyxezytU8XH0Mbl+wsPR68nBazvWjnzQs+Rh
X-Gm-Gg: AY/fxX4Rq2o9KQQ4A96wpgah6qX/tzuM5xSrdt2dW7/8t13uJ0QXUe5ylsger7jWEtp
	lv16hym3MrGjxysN6YY4V7c9V9eKwDutiU5kBdkK+JltFcXjLFCKAY0ex+Hj8uLiRQGnT9kwOb1
	QYc/hhbeyUzo8sv3834IYffBuNrlDmp5L0dwhTvKoXn9740xv7ESvA0X8mHAkSHYQ9F8Tdn54rR
	KdjPmjLHqJcy8GQMnDW7WnAerWRAwJCf+E63un0FWzXFwml55u0Z+A0Q3GO5j+PUjgk8ppIKcR6
	fl5MvpPQ/nJ6QcK+4ZSzJH3so30PKf1xSTOhja2qhSou4QPo43MxthvtJ4Nglt0AgoMKIUPqxU0
	2uudOsDp8XC0ONDdKnUVceD6QaHnfiOuPgS9DPePjy5xFft4O0h0MAxtbPN7LefYAtmRGtNkzLx
	lu/KazEhSJUA==
X-Received: by 2002:a05:7300:578f:b0:2a4:3593:4668 with SMTP id 5a478bee46e88-2b6b3ecb93fmr6102555eec.4.1768795502831;
        Sun, 18 Jan 2026 20:05:02 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b36564ffsm11452811eec.28.2026.01.18.20.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 20:05:02 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v2 2/2] net: ethernet: litex: use device pointer to simplify code.
Date: Mon, 19 Jan 2026 12:04:45 +0800
Message-ID: <20260119040446.741970-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119040446.741970-1-inochiama@gmail.com>
References: <20260119040446.741970-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As there is already a device pointer in the probe function, replace
all "&pdev->dev" pattern with this predefined device pointer.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/net/ethernet/litex/litex_liteeth.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/litex/litex_liteeth.c b/drivers/net/ethernet/litex/litex_liteeth.c
index 67ad1058c2ab..670f2a406d7d 100644
--- a/drivers/net/ethernet/litex/litex_liteeth.c
+++ b/drivers/net/ethernet/litex/litex_liteeth.c
@@ -238,7 +238,7 @@ static int liteeth_probe(struct platform_device *pdev)
 	struct liteeth *priv;
 	int irq, err;
 
-	netdev = devm_alloc_etherdev(&pdev->dev, sizeof(*priv));
+	netdev = devm_alloc_etherdev(dev, sizeof(*priv));
 	if (!netdev)
 		return -ENOMEM;
 
@@ -247,10 +247,9 @@ static int liteeth_probe(struct platform_device *pdev)
 
 	priv = netdev_priv(netdev);
 	priv->netdev = netdev;
-	priv->dev = &pdev->dev;
+	priv->dev = dev;
 
-	netdev->tstats = devm_netdev_alloc_pcpu_stats(&pdev->dev,
-						      struct pcpu_sw_netstats);
+	netdev->tstats = devm_netdev_alloc_pcpu_stats(dev, struct pcpu_sw_netstats);
 	if (!netdev->tstats)
 		return -ENOMEM;
 
@@ -277,7 +276,7 @@ static int liteeth_probe(struct platform_device *pdev)
 	priv->tx_base = buf_base + priv->num_rx_slots * priv->slot_size;
 	priv->tx_slot = 0;
 
-	err = of_get_ethdev_address(pdev->dev.of_node, netdev);
+	err = of_get_ethdev_address(dev->of_node, netdev);
 	if (err)
 		eth_hw_addr_random(netdev);
 
@@ -285,7 +284,7 @@ static int liteeth_probe(struct platform_device *pdev)
 
 	err = devm_register_netdev(dev, netdev);
 	if (err) {
-		dev_err(&pdev->dev, "Failed to register netdev %d\n", err);
+		dev_err(dev, "Failed to register netdev %d\n", err);
 		return err;
 	}
 
-- 
2.52.0


