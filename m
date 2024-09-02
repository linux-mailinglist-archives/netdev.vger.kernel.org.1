Return-Path: <netdev+bounces-124289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EFE968D2A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 20:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DBD21C2230B
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2BC2101A9;
	Mon,  2 Sep 2024 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJziwNrE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC311D45EC;
	Mon,  2 Sep 2024 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725300938; cv=none; b=MwInX4Qd0nszgjjDfUgSBAjH9SMt9u+Vt7KVsG/+SO+NituOs3htkUjWJ2YmyHmCqq4RtyoKBHw5MJEjZ//7ZHaeTWGQQUwy5o9fvQ/YKdcbERSIGiW/FyqXzMmCL+TH5pgq8KmWjZXEBX8zPr8cUaJv0ZYiRDcf+BAYhVHX3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725300938; c=relaxed/simple;
	bh=iEdAo+LnjsKQrn7okcoj0se14qGPlNhh5N0i54I2l6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5aqOiXayr3iNtF0giiLYtPP81+UeBdVX07RrwpIFMf8uKoj4XY11QAO75e+kYn2tfXQGseorGZwpuGgMwUhhrdIj6cSgWVEuONdTdZKZVdLzxnvPJ0e9Y8cFfSr1Ee3pn7MIkkEAcwcMwtYsc+Qi4CFT6RhQZRZaWxvzfvB4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJziwNrE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7141285db14so3816791b3a.1;
        Mon, 02 Sep 2024 11:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725300935; x=1725905735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDinSLZMzS23FvuwGD0vhfWMGAsaBTQCMgwSSoKV0Uc=;
        b=lJziwNrELarcE59/39svs7mhpcGs5EWAMKZKt8U76g/K2mdOYou6SQBWhSK8r4f+Gv
         heZTnGKcp9rALkBJ7LQhTzWfUTIphcfUadoa8jyaTBAnpX7W8bVa5Dp9H9iblQhrA940
         doBHiaQudI8YII1IfowRucn6pkDxBWgX7lHrvTU/oAxqfVlQDWQ4Yy0NmGFA8LSsKGa6
         R+v+rFbIgujKjqT0uUcvrKWJqDJVj4eZpv9g2AYbKOoUWxuCaeFqEWqYMijvttYhQL70
         1wJMeFfN8l3566Ivq2kp8z/MpW7cqwRrNSTPDA5JKLDrX+g2961QxbWipviopom4vyjs
         c5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725300935; x=1725905735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDinSLZMzS23FvuwGD0vhfWMGAsaBTQCMgwSSoKV0Uc=;
        b=rzgS+2cklFJ3JcgGZ4BYr49+qfqCh5VKZVcjNBr+XknR9Sp9ywTxqpMDJABV4vZSmK
         EZghgITT/Fg42D31bMCm35C2KdUtKpHhtn5FcG18dDh5e8MP3KQYxudpS0xs8hXi7kcR
         i68FDxe7sQgoDVyWKyS/u9Bc7r0T2DRtYrhMS1dO1cnfcvqfRRpwQza+d+aGdqDW4mG1
         NFkzQrTViNEikU50eU/50/ulaUx661j19DIS7e4913fYDcTy/U97uUXtPdv8dsF66dt5
         b/4w/Zzmgg9m+lraBsK2Z8z2qtqegbda9pa2jAlmVRuqy9o69ssjM9FXysObMJlifrM+
         LdpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPRN/NPQ+OhmifOdEvQOWmHEFRKoNYsPecjxJeV9YpIDrrKZ2GZXLfHjvjHHUepV+4KQbE7fTh4onX4Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2YggZGlGxbf7PO9HKhToIVYxm3Ok53Ot4sAd5XpdErXaT/urK
	eVkvP1BeT+BfrgM3C+Fm5nLbz9rhR8vzxwMxlCmHaW3borqbYJwI7N4oPOlN
X-Google-Smtp-Source: AGHT+IEKb0XvpzGiLq6i8MA7YjLH9eKuvu57oVka0eMv0/0pNtbzTn8ceJ7hyDYzmpUHLHkD2HjB4w==
X-Received: by 2002:a05:6a21:118a:b0:1cc:e43f:1fc9 with SMTP id adf61e73a8af0-1cecdf31e5amr10221667637.30.1725300935377;
        Mon, 02 Sep 2024 11:15:35 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d7804sm7109167b3a.154.2024.09.02.11.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:15:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH 2/6] net: ibm: emac: manage emac_irq with devm
Date: Mon,  2 Sep 2024 11:15:11 -0700
Message-ID: <20240902181530.6852-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902181530.6852-1-rosenp@gmail.com>
References: <20240902181530.6852-1-rosenp@gmail.com>
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

Use dev_err instead of printk. Handles names automatically.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 348702f462bd..98d1b711969b 100644
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
@@ -3082,6 +3070,14 @@ static int emac_probe(struct platform_device *ofdev)
 		err = -ENODEV;
 		goto err_gone;
 	}
+
+	/* Setup error IRQ handler */
+	err = devm_request_irq(&ofdev->dev, dev->emac_irq, emac_irq, 0, "EMAC", dev);
+	if (err) {
+		dev_err(&ofdev->dev, "failed to request IRQ %d", dev->emac_irq);
+		goto err_gone;
+	}
+
 	ndev->irq = dev->emac_irq;
 
 	/* Map EMAC regs */
@@ -3237,8 +3233,6 @@ static int emac_probe(struct platform_device *ofdev)
  err_irq_unmap:
 	if (dev->wol_irq)
 		irq_dispose_mapping(dev->wol_irq);
-	if (dev->emac_irq)
-		irq_dispose_mapping(dev->emac_irq);
  err_gone:
 	/* if we were on the bootlist, remove us as we won't show up and
 	 * wake up all waiters to notify them in case they were waiting
@@ -3284,9 +3278,6 @@ static void emac_remove(struct platform_device *ofdev)
 
 	if (dev->wol_irq)
 		irq_dispose_mapping(dev->wol_irq);
-	if (dev->emac_irq)
-		irq_dispose_mapping(dev->emac_irq);
-
 }
 
 /* XXX Features in here should be replaced by properties... */
-- 
2.46.0


