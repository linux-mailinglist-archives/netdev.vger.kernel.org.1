Return-Path: <netdev+bounces-181366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239E8A84AC1
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA361B83CCA
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79C01EFFBF;
	Thu, 10 Apr 2025 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Hk9ICbrI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209E51EFF8B;
	Thu, 10 Apr 2025 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744305232; cv=none; b=KLAozOl5G2nix+snVSAcPmxgE9Zes+jlD7JyBOpWSzlkTREmMCsXz1hZNxAE4bmUDH2bjyLgT6DDfU30olYdneQWVf5dXrirnofBIginF4KAlESoMUXx9pz9fWwe5Ml/UnbR2bQdJA9gcUa5FVpSNujcuxoSUaOaFkENaEvBqnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744305232; c=relaxed/simple;
	bh=4Oj1yvMh0QB813Yn0QiRAoNK8Kh/5ucCp5QFvDHVrsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lv6Of4rQfBoA9MCA0FCkSvhqLx0Rg+sN35ZV1eZl4cZW+lUxzHmByfFjggdtsvV2QBoJpfztxEZO3FtYETvhZ6OQ0RB85pxpTlJztu+225PI6aeiw/1D85fMDzuePIDc8Gdfk4rGFSoEKHuTJlQT7gYuarrav+3dq7tbE8Wz6ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Hk9ICbrI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tBs+L7GljmdttspKTR74d3vYIsbQVwMVt7YqQ/pqWX0=; b=Hk9ICbrI9SgVJyivcCnzdyHVHc
	Q0q2UyStUpC83uG9rxplPupBCIcfaP2HLLKSSgmlQNtmeiS6QWiSS67FEP319t+eCYrlonVtCbnt9
	esQe/z183xp8bTVROvdWZdKzIHZRXfZGkdRlcwriydvm/UJv9KzrfsKAgaNmAwDsAdyI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2vT4-008i5m-63; Thu, 10 Apr 2025 19:13:34 +0200
Date: Thu, 10 Apr 2025 19:13:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v14 06/16] net: mdio: regmap: prepare support
 for multiple valid addr
Message-ID: <fc1ee916-c34f-4a73-bdf6-6344846d561b@lunn.ch>
References: <20250408095139.51659-1-ansuelsmth@gmail.com>
 <20250408095139.51659-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408095139.51659-7-ansuelsmth@gmail.com>

On Tue, Apr 08, 2025 at 11:51:13AM +0200, Christian Marangi wrote:
> Rework the valid_addr and convert it to a mask in preparation for mdio
> regmap to support multiple valid addr in the case the regmap can support
> it.
>  	mr = mii->priv;
>  	mr->regmap = config->regmap;
> -	mr->valid_addr = config->valid_addr;
> +	mr->valid_addr_mask = BIT(config->valid_addr);

I don't see how this allows you to support multiple addresses. You
still only have one bit set in mr->valid_addr_mask.

      Andrew

