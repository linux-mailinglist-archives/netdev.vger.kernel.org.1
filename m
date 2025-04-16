Return-Path: <netdev+bounces-183393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B50DDA90932
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A825A0F3E
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED642139AF;
	Wed, 16 Apr 2025 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aci34767"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EAA2135C7;
	Wed, 16 Apr 2025 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744821880; cv=none; b=UnFg7AxoE1bBx0cOPJKjuMILZpf8l/I7i/k4/tIRqSWC3j+8CS1jUbMXUVovl9Ma+qy+n6Aee5S7PBGXS/hgS7WP0xtMeqk8fsiUPbSCmWgYcrnB/PoBdYtMpSSHi5VYlOabl3ubmiqQUNXmwz9FYKd4KjjrDWduws8qPu7UNoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744821880; c=relaxed/simple;
	bh=MlToCWePVf2EnjbdIIgvSQQgrmnwAUG5WRD/p2xO3ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsLS5zFThVwcw02Px3ihC1mUTyJvH0WrT9eQh+KqBzn68f1T7Kmkq+9JAqZepBUI7ucGS8WOkdZT4eMGQzVy97FAOYv5SXTDVrLQEs0qszyU8XhOmRSF8YhwF6RxdjTvWnE6FFkwD9yyFxZ/jJVmOinR/oVDN6ThJy+ELuXM31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aci34767; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36939C4CEE2;
	Wed, 16 Apr 2025 16:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744821879;
	bh=MlToCWePVf2EnjbdIIgvSQQgrmnwAUG5WRD/p2xO3ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aci34767h+fcH4jNUxXGMWIf+Z/P2AsHgvmV+JqNiADqPGt0jgHrlylGMymeApR73
	 y59g/0JnSBqaJslBmOGd2zi0wkMglRg5uLkw57ogkpUIxLOBq7q7b9Yk4pHIWS0NUs
	 ZnsWs/bNwkukJ876UXE7HwHS9XUBGlKBJRw2S46Mjb2pT1YiVPAmPGrKR00vty9yui
	 XLdAYjCuGsF8ZGye+sh84TqMGFq/SepChsFfaaGLFZQ9SiTpQZK+ViN/fHCkavEeHd
	 A137Q6UYPaVgWwyCKCQKyPWrJOaLhVKLfO698apVIyFdaaWEeeDL7eYfVqm5futCin
	 GH1iw1NfJJqyg==
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
Subject: [PATCH 2/8] net: octeontx2: Use pure PCI devres API
Date: Wed, 16 Apr 2025 18:44:02 +0200
Message-ID: <20250416164407.127261-4-phasta@kernel.org>
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
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   | 14 ++++----------
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   | 14 ++++----------
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c   |  4 +---
 3 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index cfed9ec5b157..0aee8e3861f3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3048,7 +3048,7 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return err;
 	}
 
-	err = pci_request_regions(pdev, DRV_NAME);
+	err = pcim_request_all_regions(pdev, DRV_NAME);
 	if (err) {
 		dev_err(dev, "PCI request regions failed 0x%x\n", err);
 		return err;
@@ -3057,7 +3057,7 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
 	if (err) {
 		dev_err(dev, "DMA mask config failed, abort\n");
-		goto err_release_regions;
+		return err;
 	}
 
 	pci_set_master(pdev);
@@ -3067,10 +3067,8 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	qos_txqs = min_t(int, qcount, OTX2_QOS_MAX_LEAF_NODES);
 
 	netdev = alloc_etherdev_mqs(sizeof(*pf), qcount + qos_txqs, qcount);
-	if (!netdev) {
-		err = -ENOMEM;
-		goto err_release_regions;
-	}
+	if (!netdev)
+		return -ENOMEM;
 
 	pci_set_drvdata(pdev, netdev);
 	SET_NETDEV_DEV(netdev, &pdev->dev);
@@ -3246,8 +3244,6 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 err_free_netdev:
 	pci_set_drvdata(pdev, NULL);
 	free_netdev(netdev);
-err_release_regions:
-	pci_release_regions(pdev);
 	return err;
 }
 
@@ -3447,8 +3443,6 @@ static void otx2_remove(struct pci_dev *pdev)
 	pci_free_irq_vectors(pf->pdev);
 	pci_set_drvdata(pdev, NULL);
 	free_netdev(netdev);
-
-	pci_release_regions(pdev);
 }
 
 static struct pci_driver otx2_pf_driver = {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 7ef3ba477d49..fb4da816d218 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -548,7 +548,7 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return err;
 	}
 
-	err = pci_request_regions(pdev, DRV_NAME);
+	err = pcim_request_all_regions(pdev, DRV_NAME);
 	if (err) {
 		dev_err(dev, "PCI request regions failed 0x%x\n", err);
 		return err;
@@ -557,7 +557,7 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
 	if (err) {
 		dev_err(dev, "DMA mask config failed, abort\n");
-		goto err_release_regions;
+		return err;
 	}
 
 	pci_set_master(pdev);
@@ -565,10 +565,8 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	qcount = num_online_cpus();
 	qos_txqs = min_t(int, qcount, OTX2_QOS_MAX_LEAF_NODES);
 	netdev = alloc_etherdev_mqs(sizeof(*vf), qcount + qos_txqs, qcount);
-	if (!netdev) {
-		err = -ENOMEM;
-		goto err_release_regions;
-	}
+	if (!netdev)
+		return -ENOMEM;
 
 	pci_set_drvdata(pdev, netdev);
 	SET_NETDEV_DEV(netdev, &pdev->dev);
@@ -765,8 +763,6 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 err_free_netdev:
 	pci_set_drvdata(pdev, NULL);
 	free_netdev(netdev);
-err_release_regions:
-	pci_release_regions(pdev);
 	return err;
 }
 
@@ -815,8 +811,6 @@ static void otx2vf_remove(struct pci_dev *pdev)
 	pci_free_irq_vectors(vf->pdev);
 	pci_set_drvdata(pdev, NULL);
 	free_netdev(netdev);
-
-	pci_release_regions(pdev);
 }
 
 static struct pci_driver otx2vf_driver = {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 04e08e06f30f..516471f172d1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -763,7 +763,7 @@ static int rvu_rep_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return err;
 	}
 
-	err = pci_request_regions(pdev, DRV_NAME);
+	err = pcim_request_all_regions(pdev, DRV_NAME);
 	if (err) {
 		dev_err(dev, "PCI request regions failed 0x%x\n", err);
 		return err;
@@ -822,7 +822,6 @@ static int rvu_rep_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_free_irq_vectors(pdev);
 err_release_regions:
 	pci_set_drvdata(pdev, NULL);
-	pci_release_regions(pdev);
 	return err;
 }
 
@@ -842,7 +841,6 @@ static void rvu_rep_remove(struct pci_dev *pdev)
 	otx2_pfaf_mbox_destroy(priv);
 	pci_free_irq_vectors(priv->pdev);
 	pci_set_drvdata(pdev, NULL);
-	pci_release_regions(pdev);
 }
 
 static struct pci_driver rvu_rep_driver = {
-- 
2.48.1


