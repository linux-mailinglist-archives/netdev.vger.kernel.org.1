Return-Path: <netdev+bounces-183397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFA8A90940
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036795A3EEA
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F272192FE;
	Wed, 16 Apr 2025 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+grd4nu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8062192EC;
	Wed, 16 Apr 2025 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744821904; cv=none; b=BLl/jiXFi9cuTMluIbfCWc7hOaxZAh5ZnNkZsZUpGMy3Om3F+Hu2San89t4HTbKIcSq/fy/BucqSPcqSvwFeVRPx32IAmWpQUoRum2LnYnNxKrltzkZ1Fs16Iusaq0ZSbmCjQO9Bp3oZjYfq8dSytNv3GpGEI3ArWqevHl/0pvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744821904; c=relaxed/simple;
	bh=aMbylj4k052FRMtMNFmpucn2eCtk3oK7X9pyLg34jlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0gbUnmGjyr/wxGrlhQ2uEqRe9MoLcZa8s6otSc4ZdGtMPzbxuvmlOuQCZMkVlh0kQcjIxocuD/4yWG57jedXiIvBQdPWEaHen004fxCurWzonQinMN10ki3hUfSM/GxpJr7i0CxkAIbGdi5bLvbiv+AhSyflB48QERTm4jwmJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+grd4nu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC703C4AF0B;
	Wed, 16 Apr 2025 16:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744821904;
	bh=aMbylj4k052FRMtMNFmpucn2eCtk3oK7X9pyLg34jlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L+grd4nuGvqBhfRZWu3jTChWYz9QoRaywQ6SjKI6z36om6n4Ju5SOYJ98px4bAxtd
	 rkh5ii5gBtGN9cXF06RnXcHfQvTcBaJGNnoyF+cvULp9Qo1+EauBXC+CUdSUSd7wrS
	 c24tnxy3EMD7HzDchoUJukafq2MVmL4KqvKd/q9PfocuwZL2dH0p1WPN8tVp0DTqq2
	 L3RhfvFNIOMwp3BbON1Lpg5YRWkkAEDs3HMh4Bo4Tc1ezg00jrtRaqoFLujverkCU/
	 mtDWVYCEpKmOLfpS7MzdtIb/MCnfy5tr3b38Nyg5nOmTV0b3LIAzLO/rkeuhjTjiHK
	 KR3yPoz+wy/CQ==
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
Subject: [PATCH 6/8] net: mdio: thunder: Use pure PCI devres API
Date: Wed, 16 Apr 2025 18:44:06 +0200
Message-ID: <20250416164407.127261-8-phasta@kernel.org>
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
 drivers/net/mdio/mdio-thunder.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/mdio/mdio-thunder.c b/drivers/net/mdio/mdio-thunder.c
index 1e1aa72b1eff..a3047f7258a7 100644
--- a/drivers/net/mdio/mdio-thunder.c
+++ b/drivers/net/mdio/mdio-thunder.c
@@ -40,16 +40,16 @@ static int thunder_mdiobus_pci_probe(struct pci_dev *pdev,
 		return err;
 	}
 
-	err = pci_request_regions(pdev, KBUILD_MODNAME);
+	err = pcim_request_all_regions(pdev, KBUILD_MODNAME);
 	if (err) {
-		dev_err(&pdev->dev, "pci_request_regions failed\n");
+		dev_err(&pdev->dev, "pcim_request_all_regions failed\n");
 		goto err_disable_device;
 	}
 
 	nexus->bar0 = pcim_iomap(pdev, 0, pci_resource_len(pdev, 0));
 	if (!nexus->bar0) {
 		err = -ENOMEM;
-		goto err_release_regions;
+		goto err_disable_device;
 	}
 
 	i = 0;
@@ -107,9 +107,6 @@ static int thunder_mdiobus_pci_probe(struct pci_dev *pdev,
 	}
 	return 0;
 
-err_release_regions:
-	pci_release_regions(pdev);
-
 err_disable_device:
 	pci_set_drvdata(pdev, NULL);
 	return err;
@@ -129,7 +126,6 @@ static void thunder_mdiobus_pci_remove(struct pci_dev *pdev)
 		mdiobus_unregister(bus->mii_bus);
 		oct_mdio_writeq(0, bus->register_base + SMI_EN);
 	}
-	pci_release_regions(pdev);
 	pci_set_drvdata(pdev, NULL);
 }
 
-- 
2.48.1


