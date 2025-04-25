Return-Path: <netdev+bounces-185932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6B9A9C2A0
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 11:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FD477AAADE
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 08:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3E123A9AD;
	Fri, 25 Apr 2025 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXIUSdEa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E3E208997;
	Fri, 25 Apr 2025 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571500; cv=none; b=k7IGZMK6IGs1PvvOopa2Etw3AvigcG2EMtVIF3nMVZ+ljTgph3T9sjoh2U04sTrNzEINlOGxfP/kwOD4RqlqK/9bfl6hwdMQ2QiUBNxxW5iQW6iP+rrID+ttoTilzzX5iROZXorO52iXku828Hwhrel00IPu7LUWQqPulHyNoC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571500; c=relaxed/simple;
	bh=SNLiMhOsszlezKYixhj6I8LuSgz6s/EcE4gCa2JfaPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8oz2yvCebAnEMh5Jbc7V8xS/XL+td+bUIPL7fsfsdK0oHLKU8qFfJe1mNjeHwBuY8R7lYl15TCKr4Hl/t+m8ra62pl0b5HyOuJmBmPpvdqopCCyAkvC6gPeHIPV7ym2+uSSaPPOOFW46f7dtPPQX7PHmbTMU5UbeTf/8/GETss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXIUSdEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91555C4CEE4;
	Fri, 25 Apr 2025 08:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745571499;
	bh=SNLiMhOsszlezKYixhj6I8LuSgz6s/EcE4gCa2JfaPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AXIUSdEaBTP+wb5An5Kz724b5QqR+D1UiEHOKdeoLvVgJ5WB7Ukiadkby+TIGRQoj
	 YIgfc8OWqfSB6+eo3/1SYXbZENETrVmHPFIowyIW+yZjXC+eN1acFx/Npw8LPfFA1n
	 J0bzN/Se98urxB7Fv8EoLYTbpFMu9+/K5myOkjjBQtZwjJ2fYp/azg3I2LTc9pcv5o
	 rPwDpPCuRbnLio5id4DD4I2NNE5m5jcVlh9P6AQEqgE3fJLON9Xoga8JLJ1npP9m1S
	 BLaLhhmnztpzdyL1djs2LAIxk4DDuvGn+bfaVWM5dLh4nPCDMIc8CR1Qe5SxGcItaN
	 Wjw28w7OZXEkg==
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
Subject: [PATCH v2 4/8] net: ethernet: natsemi: Use pure PCI devres API
Date: Fri, 25 Apr 2025 10:57:37 +0200
Message-ID: <20250425085740.65304-6-phasta@kernel.org>
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
 drivers/net/ethernet/natsemi/natsemi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/natsemi/natsemi.c b/drivers/net/ethernet/natsemi/natsemi.c
index 05606692e631..dd279788cf9e 100644
--- a/drivers/net/ethernet/natsemi/natsemi.c
+++ b/drivers/net/ethernet/natsemi/natsemi.c
@@ -846,7 +846,7 @@ static int natsemi_probe1(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -ENOMEM;
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
-	i = pci_request_regions(pdev, DRV_NAME);
+	i = pcim_request_all_regions(pdev, DRV_NAME);
 	if (i)
 		goto err_pci_request_regions;
 
-- 
2.48.1


