Return-Path: <netdev+bounces-77202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A193870910
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 19:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D82B262E0
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 18:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41A561689;
	Mon,  4 Mar 2024 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvihbCpr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BD61685;
	Mon,  4 Mar 2024 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575529; cv=none; b=SEsUWvXdngKiu60ndqWU0ot9VgtYx3Bw/wIH3om2FffijEk3vPzGbZuCTvD62vo7hZ6iK+KRyIPR+cQ/4TBPZ3h0IlJBnESA2uZincmbRSUrY1qetDArPCQxY5iyk9J5Rb37kMnCKYon0kX2g2+LRrxZb+DeFh7dqogUGvqcxds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575529; c=relaxed/simple;
	bh=FNCz1MqekcDwvpoaG3B+MmZNYy7vagVyj7/rnoJA9zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAwcIDRg73vqumEqCIqi7AH4Nud/GNNB5GIF0cQKl1acb2EZ6udedQ7kKd2DZe1ouWRz1j4pvFNrzszZtNTmkHFbsAwJqjrwCYgGwxGVnQDBCt6DoBi3F61Y7OuiPA+CZSflSPsQwpgvf178Tc4DzeRXlX4TOdlCmqORxqKl5S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvihbCpr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925E0C433C7;
	Mon,  4 Mar 2024 18:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709575529;
	bh=FNCz1MqekcDwvpoaG3B+MmZNYy7vagVyj7/rnoJA9zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cvihbCprmX7dn4CoqYA+0oELs2AmDFX241c5bEuyc/OH3jauukJNrDFNp5k7iEcUi
	 35E9nlOoEv6XuUunNY/HjV/f+bznFqRtwAKir03aTEFAtN3U1Z6IIwlSJpf+OJOJho
	 sPBLBtp9KufIyG8sfVjaXaFOE5ykQ7h/tNmwZgjBMuUbiz8lfGs4KL6okrvWr6pl/W
	 GZ7qbTa3/SZpYtZ/KFxfduLd3+9LcxGH0FuTIJzoP+3Uxkb7qkeYRWBZjWtX52VeZ4
	 ukvu4ySVsFur3eVi53O9jGnvhrnH4hLKgDkepMPJWFDBcRKcStVEo6HAgNMdEIoBv6
	 /IaTjhppVGAWQ==
Date: Mon, 4 Mar 2024 18:05:23 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
Message-ID: <20240304180523.GR403078@kernel.org>
References: <20240302183835.136036-1-ericwouds@gmail.com>
 <20240302183835.136036-3-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240302183835.136036-3-ericwouds@gmail.com>

On Sat, Mar 02, 2024 at 07:38:35PM +0100, Eric Woudstra wrote:

...

> +static int air_led_init(struct phy_device *phydev, u8 index, u8 state, u8 pol)
> +{
> +	int val;
> +	int err;
> +
> +	if (index >= EN8811H_LED_COUNT)
> +		return -EINVAL;

Hi Eric,

I think val needs to be initialised before it is used below.

Flagged by clang-17 W=1 build.

> +
> +	if (state == AIR_LED_ENABLE)
> +		val |= AIR_PHY_LED_ON_ENABLE;
> +	else
> +		val &= ~AIR_PHY_LED_ON_ENABLE;
> +
> +	if (pol == AIR_ACTIVE_HIGH)
> +		val |= AIR_PHY_LED_ON_POLARITY;
> +	else
> +		val &= ~AIR_PHY_LED_ON_POLARITY;
> +
> +	err = phy_modify_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_ON(index),
> +			     AIR_PHY_LED_ON_ENABLE |
> +			     AIR_PHY_LED_ON_POLARITY, val);
> +
> +	if (err < 0)
> +		return err;
> +
> +	return 0;
> +}

...

