Return-Path: <netdev+bounces-149515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EE79E5FC4
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 21:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558E3289144
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 20:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0165C1BBBF7;
	Thu,  5 Dec 2024 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VY3kmadu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19191B4123
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 20:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733432115; cv=none; b=rBTOhHMy4DnV671oBu/wZHL8bkHr0QPacRzyFFdQn+xoDpe9aCmcbA2VOUowVYeqe5EGLp3AcUgc9i3gkC39oLBolK4WdYA92osuyJggOvYETYFdzXDdUJwX2PI5FAiZNclce4i9+rT8IdkPMR3hr0j0UL4euCuHS7Sddui7+HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733432115; c=relaxed/simple;
	bh=vB2XXRVDd03SxQrtI/Qp2d1rhCy0PCGY4a4u8eCFr9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0oE0p/YUfILpWhO4taGXBPCn6zItAtcRwLR2UZVChDQh+4XIOiZCvBIAgCTS3B13WdQe2C+wHdUF1t83IcMA2fwLNvQuYCMmcl1iGrbpE9V/boDrdMGOvm9cjCcX1Yb3mHrBy++/IvxJa0UREyibgqSX7vdb4ihtNaQ3LyRnS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VY3kmadu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87942C4CED1;
	Thu,  5 Dec 2024 20:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733432115;
	bh=vB2XXRVDd03SxQrtI/Qp2d1rhCy0PCGY4a4u8eCFr9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VY3kmaduvjvLlI02TbwRR92wIistPihvPLaSWn6J/3JYBFoaGiAtd4seUy21r7JUa
	 WFl2s9CY1titju+e6QmGDz1IkDLc4+z6yqlPCuKxrgbk11ysD4TSxTnHbxJGOipCmO
	 s29MhBkFRr/lgNdYLyA0HO5Zh6f0AB2uXtCdE6mVhalCy957BCf3CCnd1KXVeCM6/r
	 N2Uqu88gcAo8IJ4YyDZe59oV/qvSk+UGaiaSHEoLgo1M+0Cmzqv01HK+S1u2VaAMmP
	 zLOEG1cT7tATLN29z7CkwoU4pVALIOvbraf+SitzlCsMlg4gMP16g8r3GSU720Tpz6
	 dBuOotuXhlSpg==
Date: Thu, 5 Dec 2024 20:55:11 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net] net: hibmcge: Release irq resources on error and
 device tear-down
Message-ID: <20241205205511.GF2581@kernel.org>
References: <20241205-hibmcge-free-irq-v1-1-f5103d8d9858@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-hibmcge-free-irq-v1-1-f5103d8d9858@kernel.org>

On Thu, Dec 05, 2024 at 05:05:23PM +0000, Simon Horman wrote:
> This patch addresses two problems related to leaked resources allocated
> by hbg_irq_init().
> 
> 1. On error release allocated resources
> 2. Otherwise, release the allocated irq vector on device tear-down
>    by setting-up a devres to do so.
> 
> Found by inspection.
> Compile tested only.
> 
> Fixes: 4d089035fa19 ("net: hibmcge: Add interrupt supported in this module")
> Signed-off-by: Simon Horman <horms@kernel.org>

Sorry for the noise, but on reflection I realise that the devm_free_irq()
portion of my patch, which is most of it, is not necessary as the
allocations are made using devm_request_irq().  And the driver seems to
rely on failure during init resulting in device tear-down, at which point
devres will take care of freeing the IRQs.

But I don't see where the IRQ vectors are freed, either on error in
hbg_irq_init or device tear-down. I think the following, somewhat smaller
patch, would be sufficient to address that.

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
index 25dd25f096fe..44294453d0e4 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
@@ -83,6 +83,11 @@ static irqreturn_t hbg_irq_handle(int irq_num, void *p)
 static const char *irq_names_map[HBG_VECTOR_NUM] = { "tx", "rx",
 						     "err", "mdio" };
 
+static void hbg_free_irq_vectors(void *data)
+{
+	pci_free_irq_vectors(data);
+}
+
 int hbg_irq_init(struct hbg_priv *priv)
 {
 	struct hbg_vector *vectors = &priv->vectors;
@@ -96,6 +101,13 @@ int hbg_irq_init(struct hbg_priv *priv)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to allocate vectors\n");
 
+	ret = devm_add_action_or_reset(dev, hbg_free_irq_vectors, priv->pdev);
+	if (ret) {
+		pci_free_irq_vectors(priv->pdev);
+		return dev_err_probe(dev, ret,
+				     "failed to add devres to free vectors\n");
+	}
+
 	if (ret != HBG_VECTOR_NUM)
 		return dev_err_probe(dev, -EINVAL,
 				     "requested %u MSI, but allocated %d MSI\n",
-- 
2.45.2

