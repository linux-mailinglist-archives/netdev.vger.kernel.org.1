Return-Path: <netdev+bounces-68493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77521847068
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A731F229EB
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C21811;
	Fri,  2 Feb 2024 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qa1X2RwU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138683C2B
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877223; cv=none; b=ojHTiSlIWpebzZmdDOQQBin2LsXKwS5uHjSW5QQnGeC56axLlZmfbYh644o97YsKqxs34Am9KJIlWJYt5hs9pi6XRydLr/WmcYmjHXadFWDV8f0fpHO8c5eQOnv6+fz0mEnW/q+FgKrq2piYGDFPga5mNNoRtbFvtwBVS4nX7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877223; c=relaxed/simple;
	bh=HWnRh020PL8L+lZHDRye+3GIto7WNrPV53FDQo+xb8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxYnjSKGdoRnGY8ZNls+X0gFF7yWluQWWszMtWSZr1bacHMhwIMmCYBTSRUvhOSltVeymVY5lLBSVSecwVCDWaJVtnjQPC8MaQjD3wCuBS/lhaU70JbdiVENrlHgwMVVU1/02lcme3HjrOfbvfIulKzU7k2B9p/GIYbQCMposrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qa1X2RwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958D5C43394;
	Fri,  2 Feb 2024 12:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706877222;
	bh=HWnRh020PL8L+lZHDRye+3GIto7WNrPV53FDQo+xb8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qa1X2RwUMv+4jj+LG8WHxOk046Fkju9dUn7dFvPG0OdunmAk98ZBhV0sUVItodzVE
	 U9iXhxpSbo+ypR5axIvd3l242pRd0hPjIPkRK1CBs+MLy8+0GKRYAlA/0PWXmp0w9v
	 vltppQF0EHYrRja9dffPg4KpkpRWWTTA+gyr7mQ1epBwnxAgmUBhT8SQLP6ZlloWcu
	 mw/bYiuCX48X1evvYoIS/TswdP8T77DtVOWiVzcOvum3Nc5aa+jirlLGCxcZLR1XuI
	 tg/hTtxqkYbCWJevJgfK2X6IZyXe3/ds63GljMstk9jp5VUIuJZYcv8Rxy0xCukz2H
	 cyx4e+3R+chOw==
Date: Fri, 2 Feb 2024 13:33:36 +0100
From: Simon Horman <horms@kernel.org>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 02/11] net: stmmac: dwmac-loongson: Refactor
 code for loongson_dwmac_probe()
Message-ID: <20240202123336.GP530335@kernel.org>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <6a66fdf816665c9d91c4611f47ffe3108b9bd39a.1706601050.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a66fdf816665c9d91c4611f47ffe3108b9bd39a.1706601050.git.siyanteng@loongson.cn>

On Tue, Jan 30, 2024 at 04:43:22PM +0800, Yanteng Si wrote:
> The driver function is not changed, but the code location is
> adjusted to prepare for adding more loongson drivers.
> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>

...

> -static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +static struct stmmac_pci_info loongson_gmac_pci_info = {
> +	.setup = loongson_gmac_data,
> +};
> +
> +static int loongson_dwmac_probe(struct pci_dev *pdev,
> +				const struct pci_device_id *id)
>  {
> +	int ret, i, bus_id, phy_mode;
>  	struct plat_stmmacenet_data *plat;
> +	struct stmmac_pci_info *info;
>  	struct stmmac_resources res;
>  	struct device_node *np;
> -	int ret, i, phy_mode;

nit: Please consider preserving reverse xmas tree order - longest line
     to shortest - for local variable declarations in Networking code.

This tool can be helpful here:
https://github.com/ecree-solarflare/xmastree

...

