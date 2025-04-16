Return-Path: <netdev+bounces-183398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D18A9093D
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B401F7AB032
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BF8215F52;
	Wed, 16 Apr 2025 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsCchKDQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A2E6F53E;
	Wed, 16 Apr 2025 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744821912; cv=none; b=dh15fHxbKyXCwNl9+2o0uTBhDx/cbqGRBRD2EqE1tjRjJdLWcJRJ9fzNTM41l3ndHXtn7gAG1kLBrNt2CWaOvQXxNZJQqtmHL447ZwiXO6JbFeu83Twh3CpZy9vm6oMiC//moWAZg0vTwCxvY1ojBZOwRZ57vRzpUSKBaijOx0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744821912; c=relaxed/simple;
	bh=5GFi/S9V+RPxeDj71v6She90EyPqsjI1DvAkv9zvuRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftCjzPBYUJShApsQbZ7Q9dlIorj/v53/NPCuc7PfLEoXHlDLrA4ck3otZR8RupXBp14OW8TVpgICqn0MPOmc1kymEiaI9EF7uqTrWUp+KuUIDXFw+kGLZ+6wXux+LI/XSlSHkWISqaq+opaTbRuRD+XSrQYSbqhZRFbc5Nr5f80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsCchKDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2168FC4CEE2;
	Wed, 16 Apr 2025 16:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744821910;
	bh=5GFi/S9V+RPxeDj71v6She90EyPqsjI1DvAkv9zvuRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gsCchKDQYSDDnMi/pwI8gZLEMbdalcKBBlw85eYmiIa5uEDm390FEvsSgm9R0RWwN
	 jbv0T891L/P7C6oHPRXziwRI2FeMrGtX+oWrlM+Yw2sErb6Vi9vKi2y2sSFK8230QV
	 LnENN1RJP42K/WWApFQ9wN+SQ+K107HvSPQqUg3hIGIXEZU4odDdsoBz9Zrm2sRliz
	 61WMC5dZAi+PDlzhQ6YGVne5VpHngSgOawt5B3RbtP1SmbiUvqy5VnbOb6MOJKy6Gh
	 cWhFTZO8dw0BXnQ+5ch2ZuQCeB9CFm/+NrG01/ATAzd1bgvOGy/eSFEGlTssTt9RSr
	 cQGbJHNbhrWtg==
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
Subject: [PATCH 7/8] net: thunder_bgx: Use pure PCI devres API
Date: Wed, 16 Apr 2025 18:44:07 +0200
Message-ID: <20250416164407.127261-9-phasta@kernel.org>
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


