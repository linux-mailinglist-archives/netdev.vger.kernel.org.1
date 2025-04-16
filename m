Return-Path: <netdev+bounces-183392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2602A9092F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045DE5A0E79
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0A4213257;
	Wed, 16 Apr 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jX1w3J8f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82BB1FBEA9;
	Wed, 16 Apr 2025 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744821873; cv=none; b=sTvIFUqx9DXcoVO7ZS88mEWYMZO9sjZXZ3OkgJjqETZVaYr/j1tB80oD5aXwjA8aXmKCfLDPuVUFB1p21RjjFajYmtc8emuyF689ASBIcd2PggYOTqXB6KFob64cGGVlCoFx+8U9PbzkAJyN+CQPqaMKJd++FwtO7Sf5pd7hEcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744821873; c=relaxed/simple;
	bh=OiO8b4cG5ozPDFrVf3pL6KsR9fmEuNLafgMjJ8kSJ00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQKtEzrw86lLN+1YMQbrVacPnPJWnQMdCZ8j4km8Ni7MxP2PP90DnbNUHXn6IppZjWeu19WNJKYDWinXj7wZrWmZ+Y/0uO8YvJaSBLScYsXd5dYmVacR+RtZ3ugjPwUGNY6F6f5ZUHBoSeg0u29IWBYzrwmZ4RNNqofckN/NtOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jX1w3J8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B527C4CEE2;
	Wed, 16 Apr 2025 16:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744821873;
	bh=OiO8b4cG5ozPDFrVf3pL6KsR9fmEuNLafgMjJ8kSJ00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jX1w3J8fsjgGQxKtAIXxfFoh7p3oc59Kx6jg3eqY1wD1puiolXPZC/V58GvXwDlTM
	 1Q8sIUSjNgE9I34R7OLFG3OuCilHdZs0mETkAo0eqvYPaCzpWzZXk2+Mlfszxfdf6g
	 JTgCvg3ePuskRI8UHBL+sKpo4TMmsn/F9kKSvxLL2OeDPEpvKFlnqNPAN1lRnZxnaK
	 Htm9gutwc+mb16oBYt4rznTGburiaZxsn7RlU1BV3c55MpSGrpU0yKlCY3mZzCr3rJ
	 i07L6AoY1xYhHXybLTputWlooNE7/Hn2b5Rv/x9YKPUCaD7NuKobCOEXby0WAmOv/O
	 rO+E8JwE+frzw==
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
Subject: [PATCH 1/8] net: prestera: Use pure PCI devres API
Date: Wed, 16 Apr 2025 18:44:01 +0200
Message-ID: <20250416164407.127261-3-phasta@kernel.org>
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
 drivers/net/ethernet/marvell/prestera/prestera_pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_pci.c b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
index 35857dc19542..c45d108b2f6d 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_pci.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
@@ -845,9 +845,9 @@ static int prestera_pci_probe(struct pci_dev *pdev,
 		goto err_pci_enable_device;
 	}
 
-	err = pci_request_regions(pdev, driver_name);
+	err = pcim_request_all_regions(pdev, driver_name);
 	if (err) {
-		dev_err(&pdev->dev, "pci_request_regions failed\n");
+		dev_err(&pdev->dev, "pcim_request_all_regions failed\n");
 		goto err_pci_request_regions;
 	}
 
@@ -938,7 +938,6 @@ static int prestera_pci_probe(struct pci_dev *pdev,
 err_pp_ioremap:
 err_mem_ioremap:
 err_dma_mask:
-	pci_release_regions(pdev);
 err_pci_request_regions:
 err_pci_enable_device:
 	return err;
@@ -953,7 +952,6 @@ static void prestera_pci_remove(struct pci_dev *pdev)
 	pci_free_irq_vectors(pdev);
 	destroy_workqueue(fw->wq);
 	prestera_fw_uninit(fw);
-	pci_release_regions(pdev);
 }
 
 static const struct pci_device_id prestera_pci_devices[] = {
-- 
2.48.1


