Return-Path: <netdev+bounces-126244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 681149703A1
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 20:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257012835EF
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 18:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1051662FD;
	Sat,  7 Sep 2024 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKIM2kd1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BDC487BE;
	Sat,  7 Sep 2024 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725734734; cv=none; b=IN2XUSThryofGzZF40ENMHhk6hcmnvGBKZCfs0Q2JRtVna49YIcejhgGoNWU0yx4TbJOrX6mC+3yoz9nuOBLBkW29JCXiYPBpifnUSkuPd770vvYUze95fM717Ns26ecrTNetddOYsfCPk0sc9YcfhG+JHMa3Hqs0rnFJp9HPdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725734734; c=relaxed/simple;
	bh=NpicaXjwQ3bJcupzJPtWR9SgNZKmAM3O5dl2leD4RIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaftehLHpjcUj8gcAByCI+V+khmOhbgspVinWwpDX/wg2mTx70eCidX8NDr0khLhC9lVBa/NRHP8V1YxygD6PqAtHiRiDZtUTHxmCu9udWturs5IAdfBLI1lJMKmh5ff2o/aSyXPGRi/vY6wMEpCcC7q3xxZeVCeSFBB/Z93dQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKIM2kd1; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso2442240a12.1;
        Sat, 07 Sep 2024 11:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725734732; x=1726339532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAnImw9Lf58T/UbRYblLAUkOSX/RhrkDeQTKjn5t55s=;
        b=VKIM2kd1DvMRng8/bDm7WBrq2pBYTcfjVYgr5drLGXPDhvVN+3ojVf0/0d4jBG/O3Z
         ZRNK3JH9c7msze66yI8zmDkFdF0IrPggF58SoHgmrNJvAd3TOr+k81bAqgGsC/4Mqp61
         jSv0DaX0TwlqxicXohdeR3lJRWxTKVIPcVR1rUWenlgrk3ayvOjH8AduqBLEdmCYXv4j
         eVHb9IRUurpAbP040CSJV2MrVR14nb0p21f40AgYftp2JfdzoudyAyYxCDfoqK4QJdc8
         ghvteyl5o4weEF4Fjn0KiGWwRDNJw8isTMbAHx+VS+2YOrAGrdOBmcV4pRb6rSB0t1SJ
         flDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725734732; x=1726339532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAnImw9Lf58T/UbRYblLAUkOSX/RhrkDeQTKjn5t55s=;
        b=DUgSY6Y/LVgNbR470ZbSVoMbH0DrYpP9OOJzNNEXJXT0V/dQdVcuyqEbLgbDPh5D3J
         VufNPKhBzscmDWg2nXgDGFD2zXBJlEvCxDgtvzfQT4ouM8NUj6BBUUyFoUSfC9s10nEL
         zSE2U2PuHbsKRE/nTchJDqGsyUZm6+V6iVLcDXcA6DOrQo8hxdm4e3ltQs+BsSFbYrCn
         BtmWWbb3F77FszaB+wIq17pCe23l4lcw5Jk2/yiWpQhGNiOPP95bn9IUaXGzU3NgBxWF
         MG0rEe11LgWRdP5oNN7ZThYKFzK4/kH3yBD/ePrKfNSpA0cP9v56BtwtwqsrbMMTLmcr
         Cw2A==
X-Forwarded-Encrypted: i=1; AJvYcCXKdoc7qdiV2L98JYCwCHQbwXncI6XBBqLi0t4Ze/ZxnslVjmCXZAPHKNGEJ1MI66ryViAjGf+3EQC2Z+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye6QbuGxRPiWjKWxAB9wNo5ir+445EeU/wozvHrN6OP4K9K35p
	ZaySVh8KzbdDuO8jf53QEykx0CV0pLn3WIpIQW2mv9H37GHlNE3/1OskzuI8
X-Google-Smtp-Source: AGHT+IHEDA6/zM9y8LcDw/UiUY1hpW8c4bmYXM1K/nUhVhakoGzwR+yQWMhuXBpye5bjbRlvSHmFmQ==
X-Received: by 2002:a05:6a21:3a4a:b0:1cf:288f:96de with SMTP id adf61e73a8af0-1cf288f97admr6878541637.14.1725734732546;
        Sat, 07 Sep 2024 11:45:32 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d825ab18bfsm1111239a12.88.2024.09.07.11.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 11:45:32 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv4 net-next 1/8] net: ibm: emac: manage emac_irq with devm
Date: Sat,  7 Sep 2024 11:45:21 -0700
Message-ID: <20240907184528.8399-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240907184528.8399-1-rosenp@gmail.com>
References: <20240907184528.8399-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's the last to go in remove. Safe to let devm handle it.

Also move request_irq to probe for clarity. It's removed in _remove not
close.

Use dev_err_probe instead of printk. Handles EPROBE_DEFER automatically.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/ibm/emac/core.c | 29 +++++++++++-----------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 348702f462bd..895949eee0b0 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -1228,18 +1228,10 @@ static void emac_print_link_status(struct emac_instance *dev)
 static int emac_open(struct net_device *ndev)
 {
 	struct emac_instance *dev = netdev_priv(ndev);
-	int err, i;
+	int i;
 
 	DBG(dev, "open" NL);
 
-	/* Setup error IRQ handler */
-	err = request_irq(dev->emac_irq, emac_irq, 0, "EMAC", dev);
-	if (err) {
-		printk(KERN_ERR "%s: failed to request IRQ %d\n",
-		       ndev->name, dev->emac_irq);
-		return err;
-	}
-
 	/* Allocate RX ring */
 	for (i = 0; i < NUM_RX_BUFF; ++i)
 		if (emac_alloc_rx_skb(dev, i)) {
@@ -1293,8 +1285,6 @@ static int emac_open(struct net_device *ndev)
 	return 0;
  oom:
 	emac_clean_rx_ring(dev);
-	free_irq(dev->emac_irq, dev);
-
 	return -ENOMEM;
 }
 
@@ -1408,8 +1398,6 @@ static int emac_close(struct net_device *ndev)
 	emac_clean_tx_ring(dev);
 	emac_clean_rx_ring(dev);
 
-	free_irq(dev->emac_irq, dev);
-
 	netif_carrier_off(ndev);
 
 	return 0;
@@ -3082,6 +3070,16 @@ static int emac_probe(struct platform_device *ofdev)
 		err = -ENODEV;
 		goto err_gone;
 	}
+
+	/* Setup error IRQ handler */
+	err = devm_request_irq(&ofdev->dev, dev->emac_irq, emac_irq, 0, "EMAC",
+			       dev);
+	if (err) {
+		dev_err_probe(&ofdev->dev, err, "failed to request IRQ %d",
+			      dev->emac_irq);
+		goto err_gone;
+	}
+
 	ndev->irq = dev->emac_irq;
 
 	/* Map EMAC regs */
@@ -3237,8 +3235,6 @@ static int emac_probe(struct platform_device *ofdev)
  err_irq_unmap:
 	if (dev->wol_irq)
 		irq_dispose_mapping(dev->wol_irq);
-	if (dev->emac_irq)
-		irq_dispose_mapping(dev->emac_irq);
  err_gone:
 	/* if we were on the bootlist, remove us as we won't show up and
 	 * wake up all waiters to notify them in case they were waiting
@@ -3284,9 +3280,6 @@ static void emac_remove(struct platform_device *ofdev)
 
 	if (dev->wol_irq)
 		irq_dispose_mapping(dev->wol_irq);
-	if (dev->emac_irq)
-		irq_dispose_mapping(dev->emac_irq);
-
 }
 
 /* XXX Features in here should be replaced by properties... */
-- 
2.46.0


