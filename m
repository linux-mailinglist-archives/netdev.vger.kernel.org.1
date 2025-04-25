Return-Path: <netdev+bounces-185935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFFAA9C29E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 11:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0911E1B87448
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA43623BF80;
	Fri, 25 Apr 2025 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4vcUWZM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8026723BD1B;
	Fri, 25 Apr 2025 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571520; cv=none; b=h0oxscGBEjLQHgFqdxdQyuUiX9u/DXLaDzv/BEhM6C6epyHv6xEQi5jVTu4Y7RZbq53QXhD0rhITXeFmk3r4DL0brbEyPnX1HV+je4UB5dH0KejmMmUZm5HdB3zhsL97O6JJWjmZ38haCAQw7BD2esr4Ie5AzOtKA1/C05CrpFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571520; c=relaxed/simple;
	bh=/riavgLrn/g2Hnn+PvsGhLQKcPhklIh8LsugSyRIhnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e10Zw95R6WYLPg32uQCDFrzBYkzLih1EmnOINvXKA1zRONnBfUZkWQ5164BBkpMFe6hrsMIboTfSp69xZcYusXV9gJgu8JkicO7c5q9dxRbeb0WG+64iuFF6NevYkpW7NE1GK53bGVBiZhW6GSNRq9Z2Yxb0TJ/xjIj3j+p2OXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4vcUWZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFD9C4CEEF;
	Fri, 25 Apr 2025 08:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745571520;
	bh=/riavgLrn/g2Hnn+PvsGhLQKcPhklIh8LsugSyRIhnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q4vcUWZMRmElkhA8v6VQgdgQvXSMS9Xu2h+CVmbQbZY5E1Wo8QmqF/GEDh8Es9vZy
	 dERS/Wq6Cd2a6eI+wRYazECrl8TBsvymEX+AQ+E3HB1FS6rEjNh5T7FK376sQXmQSY
	 tqku3xiNxvmHwM2UsQknFrZOB/4gc+p6dOpZ1gkJaSV8oBZv1FpFLRUQ8sq78AIdBJ
	 V1Uqs3qPr9+wQhuTZ7pY/lJ6+CKJaH0ZYEUwii+lCcfi/wowTTIUkuIRpUh9amA0iC
	 pzmbg/mfqa3KgtLTo+zo5HeWLXr9patZTNIdqV2HS0OOkE8Bws7cXC5Mh0rZ8vOF3C
	 uCb8UTQl+E+9w==
From: Philipp Stanner <phasta@kernel.org>
To: Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	Daniele Venzano <venza@brownhat.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Stanner <phasta@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org
Subject: [PATCH v2 7/8] net: thunder_bgx: Use pure PCI devres API
Date: Fri, 25 Apr 2025 10:57:40 +0200
Message-ID: <20250425085740.65304-9-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250425085740.65304-2-phasta@kernel.org>
References: <20250425085740.65304-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The currently used function pci_request_regions() is one of the
problematic "hybrid devres" PCI functions, which are sometimes managed
through devres, and sometimes not (depending on whether
pci_enable_device() or pcim_enable_device() has been called before).

The PCI subsystem wants to remove this behavior and, therefore, needs to
port all users to functions that don't have this problem.

Furthermore, the PCI function being managed implies that it's not
necessary to call pci_release_regions() manually.

Remove the calls to pci_release_regions().

Replace pci_request_regions() with pcim_request_all_regions().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 608cc6af5af1..c9369bdd04e0 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1605,7 +1605,7 @@ static int bgx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return dev_err_probe(dev, err, "Failed to enable PCI device\n");
 	}
 
-	err = pci_request_regions(pdev, DRV_NAME);
+	err = pcim_request_all_regions(pdev, DRV_NAME);
 	if (err) {
 		dev_err(dev, "PCI request regions failed 0x%x\n", err);
 		goto err_disable_device;
@@ -1616,7 +1616,7 @@ static int bgx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!bgx->reg_base) {
 		dev_err(dev, "BGX: Cannot map CSR memory space, aborting\n");
 		err = -ENOMEM;
-		goto err_release_regions;
+		goto err_disable_device;
 	}
 
 	set_max_bgx_per_node(pdev);
@@ -1688,8 +1688,6 @@ static int bgx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_enable:
 	bgx_vnic[bgx->bgx_id] = NULL;
 	pci_free_irq(pdev, GMPX_GMI_TX_INT, bgx);
-err_release_regions:
-	pci_release_regions(pdev);
 err_disable_device:
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
@@ -1710,7 +1708,6 @@ static void bgx_remove(struct pci_dev *pdev)
 	pci_free_irq(pdev, GMPX_GMI_TX_INT, bgx);
 
 	bgx_vnic[bgx->bgx_id] = NULL;
-	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
 }
-- 
2.48.1


