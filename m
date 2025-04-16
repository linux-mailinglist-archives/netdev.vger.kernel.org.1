Return-Path: <netdev+bounces-183394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F5BA90935
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D945A0D41
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927292144D4;
	Wed, 16 Apr 2025 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVnUHRbb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962221324F;
	Wed, 16 Apr 2025 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744821887; cv=none; b=cmaAxR6IQFAX0l61c/Sh0G4583Ca/vP0ZfHvIueTV99BcLY8uoqvTY183AIPPjrGE213hsdVNzf6pJMgTa2hQwVtqVqA/tBcuaf8vQ5UEJGtlNrG09ZNAWIxOY/E5ftQg3ViT74yVaLCUfZadrBeqNAh/J2pbd7GWzbEcnl4XX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744821887; c=relaxed/simple;
	bh=jHtCD2QxkF5BIe7+BmmcWSeYcXdRHKumusbGoJamdHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EylsAtp+W3IOlory8Orntbw43Fj/AgnN47H2WokvKDEq4DqvQ8f8ebzF70SKLxQmqZCvGwt6vFpcraX5vvQ5NMMLZ1Rf5KwqfQQX45iiiQEGNOPx+YXJ69ktTks100WnYsueKkdQmnavLVEwRlukNiiv67trGArBQpeEsGojs3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVnUHRbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58305C4CEE2;
	Wed, 16 Apr 2025 16:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744821885;
	bh=jHtCD2QxkF5BIe7+BmmcWSeYcXdRHKumusbGoJamdHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVnUHRbb7tjjxube3cXSPU4s1AEzrYBJ6GB5oOUpTS6ku8ZkRCNLgGmvlMmd75dsx
	 1F5BNSVcILNkvY9wh6DVBe2oMeO0g947R4VMUcMD29p+5Wlns1BqN88Y66mUPmE78B
	 oHjiBu7PZyV7fmVsKxdhS2Ubm10xZzFsA6AgqHM6SLRDkFAg8XBri6DFtoKaHNt6jG
	 ZZfB8YM+KlKbnE5RL8V/jsZluMjUKqVcXC0WCWR/uWMUnxRkpSYAroKE4btW3wGN5z
	 Gvxu6wF30yyrdK2Mdxfp35QIw4QXPSjT9A7sPSH2D7vKdVTxGc3o5//0wF02r+l1dG
	 /BSqBMyaDL/HA==
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
Subject: [PATCH 3/8] net: tulip: Use pure PCI devres API
Date: Wed, 16 Apr 2025 18:44:03 +0200
Message-ID: <20250416164407.127261-5-phasta@kernel.org>
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

Replace pci_request_regions() with pcim_request_all_regions().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/net/ethernet/dec/tulip/tulip_core.c  | 2 +-
 drivers/net/ethernet/dec/tulip/winbond-840.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/dec/tulip/tulip_core.c b/drivers/net/ethernet/dec/tulip/tulip_core.c
index c8c53121557f..bec76e7bf5dd 100644
--- a/drivers/net/ethernet/dec/tulip/tulip_core.c
+++ b/drivers/net/ethernet/dec/tulip/tulip_core.c
@@ -1411,7 +1411,7 @@ static int tulip_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* grab all resources from both PIO and MMIO regions, as we
 	 * don't want anyone else messing around with our hardware */
-	if (pci_request_regions(pdev, DRV_NAME))
+	if (pcim_request_all_regions(pdev, DRV_NAME))
 		return -ENODEV;
 
 	ioaddr = pcim_iomap(pdev, TULIP_BAR, tulip_tbl[chip_idx].io_size);
diff --git a/drivers/net/ethernet/dec/tulip/winbond-840.c b/drivers/net/ethernet/dec/tulip/winbond-840.c
index 5930cdec6f2f..e593273b2867 100644
--- a/drivers/net/ethernet/dec/tulip/winbond-840.c
+++ b/drivers/net/ethernet/dec/tulip/winbond-840.c
@@ -375,7 +375,7 @@ static int w840_probe1(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -ENOMEM;
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
-	if (pci_request_regions(pdev, DRV_NAME))
+	if (pcim_request_all_regions(pdev, DRV_NAME))
 		goto err_out_netdev;
 
 	ioaddr = pci_iomap(pdev, TULIP_BAR, netdev_res_size);
-- 
2.48.1


