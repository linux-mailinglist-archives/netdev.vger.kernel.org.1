Return-Path: <netdev+bounces-104551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D28390D387
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190D01C24A27
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028B6158D63;
	Tue, 18 Jun 2024 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JlBlshUH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91F712B95;
	Tue, 18 Jun 2024 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718422; cv=none; b=kv9nj99FtZkiouc9EqbKyqSRnknP9drqW+KIHxpUI5DK+9nybBvbTqJK9wlFkxGEU8/58d0/QpY5G19VV3xZg9I4NghAsKbObIfRzCNXatqZ+8aPF1HoELP1Nh3NAMZ4oSxrjhgtYF1sm7nvYsdd5e0rpSIapFVvuKbrqTp0XRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718422; c=relaxed/simple;
	bh=Viw9Eun78C1RUCSEjiFT0KsiFOKKEeh6vR7q0MAvXxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDkimWI9omJRHfoDPxtrkZKNK7L+NvDYut7gmLCXccFhhYiKQziu8zgjLJaFN25UKYRxkqK/GRjySaRzWJWCQxK3G/53wQeI0BHJ9rvI795jH6LCQVw6KXhI/BJrHo5R823fgTEgoAvz7Z17MZrgBZQ+X953JQoIgcSDRTb4/hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JlBlshUH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hUyYkufXGXeMDxKKMutt0ej+hmCI0R2+ko1WofHWG5A=; b=JlBlshUHk+MaUPX9GuWHD7bxeU
	fDs/yWhuOyNUyEYWbehY+4aua38cp4s909xfLJ6g4XpgISA+wrDd7fUaEcLwkrJNMZzkGqNFxuXlP
	w8Qx3dnyeXqVsoERqmX8oLQdL6qHIC6zDVDKeHYkk815sJ/V9CdJeFHr4kj0o1RVr8/I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sJZAW-000NhC-1k; Tue, 18 Jun 2024 15:46:40 +0200
Date: Tue, 18 Jun 2024 15:46:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, linux-clk@vger.kernel.org,
	rkannoth@marvell.com, sgoutham@marvell.com
Subject: Re: [PATCH v2 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <64b3c847-8674-4fdd-bbe6-8ea22410aa19@lunn.ch>
References: <cover.1718696209.git.lorenzo@kernel.org>
 <f146a6f58492394a77f7d159f3c650a268fbe489.1718696209.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f146a6f58492394a77f7d159f3c650a268fbe489.1718696209.git.lorenzo@kernel.org>

> +static void airoha_fe_maccr_init(struct airoha_eth *eth)
> +{

...

> +	airoha_fe_wr(eth, REG_FE_VIP_PATN(11), 0xc057); /* PPP->IPv6CP (0xc057) */

include/uapi/linux/ppp_defs.h
#define PPP_IPV6CP      0x8057  /* IPv6 Control Protocol */

Are these the same thing? Why is there one bit difference?


> +	airoha_fe_wr(eth, REG_FE_VIP_PATN(17), 0x1ae0);
> +	airoha_fe_wr(eth, REG_FE_VIP_EN(17),
> +		     PATN_FCPU_EN_MASK | PATN_SP_EN_MASK |
> +		     FIELD_PREP(PATN_TYPE_MASK, 3) | PATN_EN_MASK);
> +
> +	airoha_fe_wr(eth, REG_FE_VIP_PATN(18), 0x1ae00000);
> +	airoha_fe_wr(eth, REG_FE_VIP_EN(18),
> +		     PATN_FCPU_EN_MASK | PATN_DP_EN_MASK |
> +		     FIELD_PREP(PATN_TYPE_MASK, 3) | PATN_EN_MASK);

> +	airoha_fe_wr(eth, REG_FE_VIP_PATN(22), 0xaaaa);

Please add a comment what these match.

> +static int airoha_dev_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	dev->mtu = new_mtu;
> +
> +	return 0;
> +}
> +

I don't think this is needed. Look at __dev_set_mtu().

    Andrew

---
pw-bot: cr

