Return-Path: <netdev+bounces-185929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8C3A9C28D
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 10:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5E6176C36
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 08:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98290237186;
	Fri, 25 Apr 2025 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzFrajcy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648512367D5;
	Fri, 25 Apr 2025 08:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571480; cv=none; b=L3ykPpQOoWEI1zaU6+7K5lDoqBFtsrpATM167Xf0vgl69tN/iugXdKbqUpXsxgCFjfENACbyfJ8Vr3TvW9Z3EHTkYz/Qv1Rf7Q2xVpbSTg9yOMWcIx9/xNLgezz6xFW1zfW3whgu+rBaNFRM31+RYPmGT2f+MxK0j89ErrKQEVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571480; c=relaxed/simple;
	bh=SJjOmLS6N4kbYOZUh7McqDYQHoY2qAv/ch95M7/xp/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIVpKscYXdEupfZXewOt/fNjmDW9XVp6+ccL15JPK4S1M0gfeMcCXhyqnrv/NHtPhMZYmsqBz03xpH/XAlhG/kV2y7TRI7vjjRuE2UqYjUp4HWX5ENCgN2IYmQ5m1Fl4raKAhm6NGG+n5X0R4BWFCKWn86zP9vQPqkkS7SPwpbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzFrajcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B81C4CEEA;
	Fri, 25 Apr 2025 08:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745571479;
	bh=SJjOmLS6N4kbYOZUh7McqDYQHoY2qAv/ch95M7/xp/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UzFrajcyCWUQp4NoCuoJGoQpoo4y3MriQf/v7TbQeYVD2C8nnK9mKVhAUV/n5/cHB
	 uozUBKgiEJTaxhvBZ5VOThFQNmQOQCDPxRvHwiuGNn31XeDS+Aj94qqD2bmgksgUHW
	 AmADXjU6lKbDZN+knO59/Xz6PERMNByLLi15I+/HVid6fh3+lGviletKQZhDh7X17i
	 P1FKsUib9mIrYjBdLASOYFXls1sakHURx85B++fDmM4rVXRXA02dBKNMVOSTUUM71m
	 TEGDQ6fxrCbj2XXoVuIQD/WnHSjXdIEB9vG2M/gUhiTL75atMpYzJf5YeKtqn8GEQy
	 /ejOJNzaFI8zQ==
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
	linux-parisc@vger.kernel.org,
	Elad Nachman <enachman@marvell.com>
Subject: [PATCH v2 1/8] net: prestera: Use pure PCI devres API
Date: Fri, 25 Apr 2025 10:57:34 +0200
Message-ID: <20250425085740.65304-3-phasta@kernel.org>
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
Acked-by: Elad Nachman <enachman@marvell.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
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


