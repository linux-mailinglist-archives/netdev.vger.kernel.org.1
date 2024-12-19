Return-Path: <netdev+bounces-153501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AAD9F8547
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 21:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300691642F2
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 20:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDA61FECC6;
	Thu, 19 Dec 2024 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="smn1Svre"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14461DC9B3
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734638351; cv=none; b=lUD67cqkaaGg2uklS0AI9j2bSDZJ5lJeBwTb3q7wIxckmw1ewVClXU2ITI3amXIyOVrICtvXKVCiCGE0o+kKqi45LkkmtvG2uXCNjb7eFjXBkI/vwTSnzuQRow5Spo1gklDqEMnDM6Yuh4m7C5oVSsU60cdNO3T2kAkpHwV89jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734638351; c=relaxed/simple;
	bh=s9w+e101TyQrbO6pYnUr4GEGJbwIl5NBy74FHjUoVy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aWqRhw389ONZgsW3jTBkZyG5kxk90m0M+rtQMLRhLlWugN4V5s4cMrP/sHvrOjiMBBfku820IXN+WF+dvenIHfBp4PjpA0JOGQW+G7/u5Fz2TZR/xQkUpof9HQCeoxfdlwAFXpW4pWGU7Buk8DSYNkz2N+N0UkT3xPsLmqdn0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=smn1Svre; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa543c4db92so232799966b.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 11:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734638346; x=1735243146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjY9DIvP/j+a2vEDWbQw6B5IBSbTgKjYEYRIEWyupmM=;
        b=smn1SvreS33AL5NQr4MDze190jD5LgtEj3fNxX4G6NepdaB5iwE5dguydi+rLwZOSM
         eDCVpFKSLk+de8KBBNE+9bnzeRV5Y4oPk3Va6YjQcXXJ7ccWEUzxRh2SBznSMPPne3wj
         1PO8Br8ygfYgnoxE5w1tmziybjeq3ZgNaLLnoN4U2QTWwUryTN+dRWyxKvb1OkkyOtTZ
         Ddb/uEAUszfVmKloaGGHIsmO/2Fl35ZIq2C1IY3Skug9REeDxCJEzyMk5i1BzAk1ysWu
         RBBuhH5ef0oJlW0B+zHTtWYHtPNw1rSBbi87Z0mqgm0lARd6X6ubMNeGz+sgsMIjFOs0
         1uqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734638346; x=1735243146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjY9DIvP/j+a2vEDWbQw6B5IBSbTgKjYEYRIEWyupmM=;
        b=mVPp6+IUgR3n+GBlM9Fpy6bpPvh0JQs/0QaY7M+kFJ+zJ3+CACqO6dBizBdraXQIhL
         XdTgCkOTzHlYYWMpDWpB+VQjN8smlpbOWW4baLOmn6zGxyXPH/im/fAxT8fidQS1mHP1
         U++qQ5ZjzWETtit33dNSXZoOlLD/kpHYQml9YRxgchYNm82L8gD62NHsmQahAeiYD+5v
         tAsibT36xsQSRHCEqci6rtrn1XHeJsC1OFmXzIcnZsmCocPCoFZy8mQ+7Bhl7aPiaPet
         YiQJmIzKdtXhUK7I+wZhRtYA3A23kQuC/RkCwHLI+QssOvDrGn41mDB0ctSepHyFxvrV
         XInQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB+3QCIBuB1LDr12DyrW2NywvdLhKru2bbLI7AN1YpWjMWWS8AUz2n0uYzI8zVEa9QePUm+p0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEgnGDxzx2vT7DaaEOZY06MJZYH2m64kBPsFGi7Hz6xu7zTkt2
	knOTRYvN6VqekvwpgpW9lBe3Nfy6tCerfAAj7mFSNrTPEznCKZ+ZyqidRhl5wog=
X-Gm-Gg: ASbGncsThQfV9QGyUQl6pxasJ9scRzrdoEzmHyKbnNV46tYX2A68b4KOZ2hSvsCdX2y
	F2B7CGKFrIw0G+uDAEANUAX6DU7yr1NvKshHXqOR+F1IXC6tW1Zq62qf0Xk1El5qP2qQhv9/LbH
	M+YBDRlleZxG7bebwIPB1DRbhw6TFOK+zQy8foLZZB1UKq+vgW+Hq7sDA4oC94lKsP89ZWjqxqT
	GciriuFpo982ZT0Pt+QyOfU3+FRwcg1sF5eC0t3I48a3VenoA==
X-Google-Smtp-Source: AGHT+IGasreMAbBLOSYmozk5zkbcfUr/mtndjRwbhEURyo571uEoHnYhBSDfIDFuCEtn8LDH45uGSg==
X-Received: by 2002:a17:907:1c14:b0:aa6:a228:afaf with SMTP id a640c23a62f3a-aac3378d0b4mr3761866b.52.1734638346219;
        Thu, 19 Dec 2024 11:59:06 -0800 (PST)
Received: from localhost ([2001:4090:a244:82f5:6854:cb:184:5d19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f015ab9sm97118666b.155.2024.12.19.11.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 11:59:05 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 19 Dec 2024 20:57:54 +0100
Subject: [PATCH v6 3/7] can: m_can: Return ERR_PTR on error in allocation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-topic-mcan-wakeup-source-v6-12-v6-3-1356c7f7cfda@baylibre.com>
References: <20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com>
In-Reply-To: <20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Simon Horman <horms@kernel.org>, 
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3520; i=msp@baylibre.com;
 h=from:subject:message-id; bh=s9w+e101TyQrbO6pYnUr4GEGJbwIl5NBy74FHjUoVy0=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJTqt5OXTaz78I15uRqe17jCXdW+7HzfjqqdSRmzZKm4
 GmT7ZWiO0pZGMQ4GGTFFFnuflj4rk7u+oKIdY8cYeawMoEMYeDiFICJ5Nxh+J/xa9EuV//kk0sb
 OFZXsahc7BOJ/zUp4GLGxRUOh5eprl3O8M/+568+9hP29lvy/oX3nFtvnHbRpb+iKrnu54Q57a1
 bTjABAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

We have more detailed error values available, return them in the core
driver and the calling drivers to return proper errors to callers.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c          | 6 +++---
 drivers/net/can/m_can/m_can_pci.c      | 4 ++--
 drivers/net/can/m_can/m_can_platform.c | 4 ++--
 drivers/net/can/m_can/tcan4x5x-core.c  | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 0dcdcde3449c7647e4bc9a92f918160a336f94c0..e69e9799710b3e4cb267324e8e9db40ca02328e2 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2356,7 +2356,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 					     sizeof(mram_config_vals) / 4);
 	if (ret) {
 		dev_err(dev, "Could not get Message RAM configuration.");
-		goto out;
+		return ERR_PTR(ret);
 	}
 
 	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
@@ -2371,7 +2371,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	net_dev = alloc_candev(sizeof_priv, tx_fifo_size);
 	if (!net_dev) {
 		dev_err(dev, "Failed to allocate CAN device");
-		goto out;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	class_dev = netdev_priv(net_dev);
@@ -2380,7 +2380,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	SET_NETDEV_DEV(net_dev, dev);
 
 	m_can_of_parse_mram(class_dev, mram_config_vals);
-out:
+
 	return class_dev;
 }
 EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index d72fe771dfc7aa768c728f817e67a87b49fd9974..05a01dfdbfbf18b74f796d2efc75e2be5cbb75ed 100644
--- a/drivers/net/can/m_can/m_can_pci.c
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -111,8 +111,8 @@ static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	mcan_class = m_can_class_allocate_dev(&pci->dev,
 					      sizeof(struct m_can_pci_priv));
-	if (!mcan_class)
-		return -ENOMEM;
+	if (IS_ERR(mcan_class))
+		return PTR_ERR(mcan_class);
 
 	priv = cdev_to_priv(mcan_class);
 
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index b832566efda042929486578fad1879c7ad4a0cff..40bd10f71f0e2fab847c40c5bd5f7d85d3d46712 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -87,8 +87,8 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	mcan_class = m_can_class_allocate_dev(&pdev->dev,
 					      sizeof(struct m_can_plat_priv));
-	if (!mcan_class)
-		return -ENOMEM;
+	if (IS_ERR(mcan_class))
+		return PTR_ERR(mcan_class);
 
 	priv = cdev_to_priv(mcan_class);
 
diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 2f73bf3abad889c222f15c39a3d43de1a1cf5fbb..4c40b444727585b30df33a897c398e35e7592fb2 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -375,8 +375,8 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 
 	mcan_class = m_can_class_allocate_dev(&spi->dev,
 					      sizeof(struct tcan4x5x_priv));
-	if (!mcan_class)
-		return -ENOMEM;
+	if (IS_ERR(mcan_class))
+		return PTR_ERR(mcan_class);
 
 	ret = m_can_check_mram_cfg(mcan_class, TCAN4X5X_MRAM_SIZE);
 	if (ret)

-- 
2.45.2


