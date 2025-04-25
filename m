Return-Path: <netdev+bounces-185936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD4EA9C2A4
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 11:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF6A1BA25AD
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398F9242D9B;
	Fri, 25 Apr 2025 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxBcml0/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDA2242D94;
	Fri, 25 Apr 2025 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571527; cv=none; b=f60UXqaYpm/simcFoZji2euKN0K2eAuQKXeqDEx9PqFcTAjUDDYgfirb1msovs7F0C/PAf7LtG9UefaPoAESaeTFqoEle5G2C2KT/uvxcjjNBf93/5e8OdXNMz9bUGt/tMZ4xT2HKKVJAlecB9Ra0dXQpXDx2Qz8bWwyMosVs1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571527; c=relaxed/simple;
	bh=189wyjGuYuaHlkManBiYipumPeAhOLGmKz8J7H5MS8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVq/wuUeJ5zN3wamr5tWjbU5ZjywadNletzY0mvP3aWCVZQysMD1nAwzfFOuU9Swx9umEc1zfokuFt2thq+F4pUPRxeAsFPILmN+yW3z9iEmarSvb2bdmu4P1pAcb2Gj1Q10pg0VL+8MK+96nyaLBX6u4tMO551tE7grRaiaeNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxBcml0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669C7C4CEE4;
	Fri, 25 Apr 2025 08:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745571526;
	bh=189wyjGuYuaHlkManBiYipumPeAhOLGmKz8J7H5MS8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VxBcml0/2zzf7TV0kg2cY1Y1PQOb5g1wqcAAoFO/PPePO/MHbGgE6egAB98PCUNLF
	 HdJvDZh37bJ2MZofOYdkxT5XBcUD7fiBd5XkPcVitRKjPvqoWWxN2O3m/v1ICvl+/2
	 KVWXSXmR1nrWONKydXVyGy+er1VzAxcfUBc82Bu+J6+HceLRcHGQaA/XUEwXma08UQ
	 vKHQqw31i2egxr9bPprVVeQhqmAqsk/n0lFHZUg0aTiAsyXq6NiCNHnrPbV+jLEIDv
	 d9Ln2ZFWNkljVMIZZ1xQRu8ZY3BSYZS09zND5o9DkQerc4Jws/Prtzk9Iql5E+BLi2
	 rWPJ/aU7vJdRA==
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
Subject: [PATCH v2 8/8] net: thunder_bgx: Don't disable PCI device manually
Date: Fri, 25 Apr 2025 10:57:41 +0200
Message-ID: <20250425085740.65304-10-phasta@kernel.org>
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

thunder_bgx's PCI device is enabled with pcim_enable_device(), a managed
devres function which ensures that the device gets enabled on driver
detach automatically.

Remove the calls to pci_disable_device().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index c9369bdd04e0..3b7ad744b2dd 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1608,7 +1608,7 @@ static int bgx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = pcim_request_all_regions(pdev, DRV_NAME);
 	if (err) {
 		dev_err(dev, "PCI request regions failed 0x%x\n", err);
-		goto err_disable_device;
+		goto err_zero_drv_data;
 	}
 
 	/* MAP configuration registers */
@@ -1616,7 +1616,7 @@ static int bgx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!bgx->reg_base) {
 		dev_err(dev, "BGX: Cannot map CSR memory space, aborting\n");
 		err = -ENOMEM;
-		goto err_disable_device;
+		goto err_zero_drv_data;
 	}
 
 	set_max_bgx_per_node(pdev);
@@ -1688,8 +1688,7 @@ static int bgx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_enable:
 	bgx_vnic[bgx->bgx_id] = NULL;
 	pci_free_irq(pdev, GMPX_GMI_TX_INT, bgx);
-err_disable_device:
-	pci_disable_device(pdev);
+err_zero_drv_data:
 	pci_set_drvdata(pdev, NULL);
 	return err;
 }
@@ -1708,7 +1707,6 @@ static void bgx_remove(struct pci_dev *pdev)
 	pci_free_irq(pdev, GMPX_GMI_TX_INT, bgx);
 
 	bgx_vnic[bgx->bgx_id] = NULL;
-	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
 }
 
-- 
2.48.1


