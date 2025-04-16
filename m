Return-Path: <netdev+bounces-183400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6641A90954
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC301882162
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D29215F5C;
	Wed, 16 Apr 2025 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBOpy31D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D432163B6;
	Wed, 16 Apr 2025 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744821920; cv=none; b=o9qIEyYArYg4YjUVOP+U2xDpYsVw7rfxK186tNplr234C2dh0LF3punAfscSumlC34Xlzu5nNuqfJAD6WoXf9+RZAMYzjK6W82XTnplQxlqg5wvThgar5XBLqzvSUejuSktJSmicdF0YesPNXDtdQLi9CR648UG+H4nZsuAN18A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744821920; c=relaxed/simple;
	bh=NZjOGkOVi+7Jb5XsEcxcNcG9G1OBjaxyKDLMX1iDNwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APLzcuPDiY7eaxJXUGbJdpk0khqKFYsA1KXUiMpRUoeiTjyrDq8ANguXeWKyNaUFktUkGLu4zSKWYkaGXeH2jdO3dchSSU/Rbe0P/q9bumalcRDWvtANZJQ2sxOMi4Y03Pwi9jiRXJg0zZj50k+nbUSdM/iWzDrcE8DK3ccuHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBOpy31D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB1FC4CEE4;
	Wed, 16 Apr 2025 16:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744821917;
	bh=NZjOGkOVi+7Jb5XsEcxcNcG9G1OBjaxyKDLMX1iDNwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bBOpy31DTEtqpmXaAlAh8RgRHpANHVxKHFZIWjkeLoHLMZLHaxr0nPEGAx2hJcYr9
	 v/W7PP4/MzIWHEnPuCuHMzuWSZupktvfTqlaqzyVID/C3+3pnvMovCKIn1QCffwxeI
	 QgKIc+GQCGnm5qymBDf57Wk4CWoK/S3R2o6FyMZ61pn+E4bIDKA5D70KG+OmCsgn4P
	 9RKfzb1ykAQUuTOS6JZXjU+D7QMcDTmGUv/RRa7ns3pURy3uvSZ2y4gIcghq9kViLn
	 eyqHdOkNNrtRlIDK1uwSvNaIpiRTYJVVfz/w9m+7u3N8l58xzP6TW8PnZ9RrROG4Qv
	 d9ORT1a60H/wQ==
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
	Thomas Gleixner <tglx@linutronix.de>,
	Philipp Stanner <phasta@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Ingo Molnar <mingo@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org
Subject: [PATCH 8/8] net: thunder_bgx: Don't disable PCI device manually
Date: Wed, 16 Apr 2025 18:44:08 +0200
Message-ID: <20250416164407.127261-10-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250416164407.127261-2-phasta@kernel.org>
References: <20250416164407.127261-2-phasta@kernel.org>
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


