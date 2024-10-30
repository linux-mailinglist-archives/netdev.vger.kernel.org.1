Return-Path: <netdev+bounces-140237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DD79B598D
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 02:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3865EB22241
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 01:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39627190665;
	Wed, 30 Oct 2024 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSKPNlsA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091A383CA0;
	Wed, 30 Oct 2024 01:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252855; cv=none; b=SvqeyRXPCI7swecyF103b0Pzvz2EPnpx+SNfY1MKe6SJf0zk6bHqYbHwCSlR4afb2YWgJZiH0Q4yk7IvpOINV4F/clxy482++L28xUz3Ag+4MVPrjHBTNS10A1tsEnVUPljwh9phc1ssdvDvBJ6m7/y3Ym4Om1yO07sz3C2zJmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252855; c=relaxed/simple;
	bh=yY/c+Ers7lzRZ2/3Cil0sCo9++1VJGqVZ3Deuce2yLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlA2F7Xx8O9CEY98Ba8Rr+l+zy+J0uW6ACO7PLkfdrlkiD2A7jAVfC0Y+QV3pJoZGhIIcE6tlh9zknhGdf1C8PZfGh8H8vVC6iPQ3H4ZqKCI0N+oz8tbaYqrPBoWKzcp3hlQ/ED9HpJA42Wgv6D5KxMLUvXdsSjHAEJq0T8gqYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSKPNlsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4A2C4CECD;
	Wed, 30 Oct 2024 01:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730252854;
	bh=yY/c+Ers7lzRZ2/3Cil0sCo9++1VJGqVZ3Deuce2yLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VSKPNlsAp8xtYZqJ+lL3YeYwf9h/KFmuUS0SrU0Kd242zkRGAHj2tZolSWx5TqYYy
	 4nMY2czlPWVQ7utq52nGSF20rvImvjjAqmR+9w2LTQC0Jd/gfxj3NZ9GkeXjHBfZFb
	 493wcFo0ZPkd83UmmFKOxxYlg8TrGNdnH1pelNWwl/0f/1aPmchj9yj4oJh5/10lRP
	 oV7fTfv0EkNj5fjXslkR1HT9ZdVhkfAtoO+CBBc9i2tnpqDenWV0yzF5Ev0csWkAzl
	 2DhqaGvlKXAJGKFu1dSBT59LPjrL7SLpRWY+1G37QnNyRq8Ix79lrwXLYqfkDisGmN
	 WjR19ra5keh9A==
Date: Tue, 29 Oct 2024 18:47:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro
 <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Jisheng Zhang <jszhang@kernel.org>,
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Andrew Lunn <andrew+netdev@lunn.ch>, Drew Fustini
 <drew@pdp7.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v5 2/2] net: stmmac: Add glue layer for T-HEAD
 TH1520 SoC
Message-ID: <20241029184732.2e3ef7b7@kernel.org>
In-Reply-To: <20241025-th1520-gmac-v5-2-38d0a48406ff@tenstorrent.com>
References: <20241025-th1520-gmac-v5-0-38d0a48406ff@tenstorrent.com>
	<20241025-th1520-gmac-v5-2-38d0a48406ff@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 10:39:09 -0700 Drew Fustini wrote:
> +static int thead_dwmac_set_phy_if(struct plat_stmmacenet_data *plat)
> +{
> +	struct thead_dwmac *dwmac = plat->bsp_priv;
> +	u32 phyif;
> +
> +	switch (plat->mac_interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		phyif = PHY_INTF_MII_GMII;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		phyif = PHY_INTF_RGMII;
> +		break;
> +	default:
> +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> +			plat->mac_interface);
> +		return -EINVAL;
> +	};

unnecessary semicolon

> +
> +	writel(phyif, dwmac->apb_base + GMAC_INTF_CTRL);
> +	return 0;
> +}
> +
> +static int thead_dwmac_set_txclk_dir(struct plat_stmmacenet_data *plat)
> +{
> +	struct thead_dwmac *dwmac = plat->bsp_priv;
> +	u32 txclk_dir;
> +
> +	switch (plat->mac_interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		txclk_dir = TXCLK_DIR_INPUT;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		txclk_dir = TXCLK_DIR_OUTPUT;
> +		break;
> +	default:
> +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> +			plat->mac_interface);
> +		return -EINVAL;
> +	};

unnecessary semicolon
-- 
pw-bot: cr

