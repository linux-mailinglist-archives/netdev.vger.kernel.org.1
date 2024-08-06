Return-Path: <netdev+bounces-116145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FE9949455
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 17:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D941C216E7
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A2212E75;
	Tue,  6 Aug 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDiBGnsA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DC1BA20
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957437; cv=none; b=mkqQDlDqkOumscMz4C/Hc6fMWs2GlgmA8flgK81/Yvh9GbNVXBVfnLYppsHRvcDTJ+/CsoTa/TxV0K5aidd8GOIwuZ+qyrCI/x74Kw4kyWqWBGCi0db2VdeggtLp6l/m1dBGfzeJu9rGIfVeVshmKk73sGonk7r951702mDdn94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957437; c=relaxed/simple;
	bh=SrkK/23FSjHQQLgg02e4jCgF33wvzPp04W3qrRRc+UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zim1Gb6oQ7/wcyov8MfT+TInGVleoyrTfSiXqjRUKWug+RjznFmGLImfeIKhruMA7nyTO30BFQxYt57U6VWge/DjdGAGQzoTGcGcn1NekZ6VmKycgKEHcaR3K388iZCfv7Uw3bETl/yCz8qB5NVadHP0b3w1RG/PiPlfps+pYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDiBGnsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0B2C32786;
	Tue,  6 Aug 2024 15:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722957437;
	bh=SrkK/23FSjHQQLgg02e4jCgF33wvzPp04W3qrRRc+UM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CDiBGnsAZNXympM4HsWsxACbyOGbm/97JEpJM1xnMhAvwZ8bnlAy9ql5UwPfW54Aq
	 WARr1uiK0iBkheIh7yu/CGnyJd/Cl/eB3I6itqEnw2oDkDaivPBadsEkigD8j/nx0z
	 1fOXtemN7Vem9uIYD4y2t4s8BL+MYi6mrf4aq1K6x/q96WvGr+GevqGCczsyEy1nuG
	 PsC4COJomhQzzoTOg662ioCKMbiCiY15w2OIHs+mSHTutjJFk2VL/e/XuSvEKkdmbS
	 IIf0re4eUSqfAPSrFCskRzFkF0xpsGrD3hhV9Gy+b+NreuuKt+Hn9xProJfwBS5J48
	 v8TBgc/2Mb78A==
Date: Tue, 6 Aug 2024 16:17:12 +0100
From: Simon Horman <horms@kernel.org>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, diasyzhang@tencent.com,
	Jose.Abreu@synopsys.com, chenhuacai@kernel.org,
	linux@armlinux.org.uk, guyinggang@loongson.cn,
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com,
	si.yanteng@linux.dev, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH net-next v16 12/14] net: stmmac: dwmac-loongson: Add
 Loongson Multi-channels GMAC support
Message-ID: <20240806151712.GX2636630@kernel.org>
References: <cover.1722924540.git.siyanteng@loongson.cn>
 <bd73bc86c1387f9786c610ab55b3c4dd47b907c2.1722924540.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd73bc86c1387f9786c610ab55b3c4dd47b907c2.1722924540.git.siyanteng@loongson.cn>

On Tue, Aug 06, 2024 at 07:00:22PM +0800, Yanteng Si wrote:

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c

...

> @@ -214,12 +532,15 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
>  {
>  	struct net_device *ndev = dev_get_drvdata(&pdev->dev);
>  	struct stmmac_priv *priv = netdev_priv(ndev);
> +	struct loongson_data *ld;

minor nit: ld is not used in this patch or patchset; it can be removed

...

