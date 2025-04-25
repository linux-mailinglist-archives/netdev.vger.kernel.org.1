Return-Path: <netdev+bounces-185931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F947A9C298
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 11:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6393A660D
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 08:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B277923A984;
	Fri, 25 Apr 2025 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZrO9gEe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A241EB1B9;
	Fri, 25 Apr 2025 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571493; cv=none; b=oRrsqEbhpU908F6+U0ygZKBLCbO1FOQTYwsUJAqqjU1sT29E2muUw9XP9MYPeZ5H0t+TRmNE9LnrlNDd25EEpY5xbHnAO781Fp0mmuMvXAGWaiioNLr898uvZegJPhzlub07bLGn6yaWwqdZEavfQgqeqyt1rddS+o4SctdAS4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571493; c=relaxed/simple;
	bh=m+Vi1J2g9X6f8XLQfZWFFa2VyVsNzxMlpbDST6gpme8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFUxaoG68cCifT1Do5vySKwUzxDTvb2X6MjMg0wom0P5s0+gYJqzWm/Vhu9Jlc5JlIwQqErcc+CsFWO6fc24UCZ/CVPqK78Ld0LVSZe8tfCQI+3QhyU0yFGRjbKJ6uxPRIgjfsYmEMfZwkpCAuPECMJJ6fFl5t2w5Mp8yjS05ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZrO9gEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E40C4CEEB;
	Fri, 25 Apr 2025 08:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745571493;
	bh=m+Vi1J2g9X6f8XLQfZWFFa2VyVsNzxMlpbDST6gpme8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rZrO9gEeE+tVfuQHltwGYKi6PyXbaHgIHTGo3zYBdKuknJVc4pYQyrvxYaW/quK/p
	 XVpoCi7xYLfak/z98WjxUqsqr4J7KcOeflv5dPAgiGnQ3q5vGz5iG1xqrrNPUVBnHk
	 NiHbBIPqNflJ6S4v0F/1dM4yDmZaXV/zjdzd9JX0MK1n8a1+DpaPUZOLZUgSxPfj/x
	 iKxaqgfLLdwq+Kw4I2uAhMUG3FhEupoGxt05KXz+ZP5nRa8K/CITUBEA4fvnUchgp5
	 0sj7IxsrtduNvon79eUafdIC7hSX4L8AlzXeR7SX7cIILhBRj3bF2T37RRc3FRuLS+
	 QExag8BAQtuZw==
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
Subject: [PATCH v2 3/8] net: tulip: Use pure PCI devres API
Date: Fri, 25 Apr 2025 10:57:36 +0200
Message-ID: <20250425085740.65304-5-phasta@kernel.org>
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

Replace pci_request_regions() with pcim_request_all_regions().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
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


