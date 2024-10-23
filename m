Return-Path: <netdev+bounces-138369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B2F9AD200
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 19:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BC11C25F97
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A9C1CEE8D;
	Wed, 23 Oct 2024 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d+un5T1M"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD201CEE97;
	Wed, 23 Oct 2024 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702417; cv=none; b=Qinx7CJVxuwt7oaVSpxVvu8Td6XZis9CcqnkrOtPqX2HrEv7caEmKFWCtyLxOZAgPrp2Tjavc7e9zHgFi5asBJ7gqSYxgDb2TdA7irOoxfzEn9699HqcTF2/aZ3XrRJsLKZEkMrfeEmzfCpWxthAmvX6DkPK90Qh+mHV12GLqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702417; c=relaxed/simple;
	bh=1qcv0aErvLx2qKUOxUQo8pZ6y6kXqoM8WD0SFo5sEHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE++oEPnNN+BHtJZOtCP1wRvLryOhpLTiRH8lQMvt7Q7dbW0HXtao/enj6kto4SUlbPh2LEZZEYJ2FXLakBMfF1Ow9vCWDVmZ0A9kp6Z4ZdBHqEdWtWLgHyFo4kwNES2YaZEtRKoslBEDg342H1rSlzNcpZIgNhpD4i0x5NJSog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=d+un5T1M; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iAxKTtO4kugd7yM0ZwL4yTamECyLObrP7YDrcb1pBYU=; b=d+un5T1MRvoFgGi2vvDYjQNQGu
	cG9TbCVi3QEkrBQ20xMjkz3Dr9do61nv/DV6xicVCFGjY/1BlYjm2UZW5kGBNqY9SbKKX/f8cxkQz
	JQVXS2Vk5bE5vAkVFiyG/PACeHqWSXjYdkhMQnqtiOc6AlAIl+k8bsClGn3T2DjMp4jU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3ebi-00Azfr-AO; Wed, 23 Oct 2024 18:53:14 +0200
Date: Wed, 23 Oct 2024 18:53:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v2 3/3] net: phy: Add Airoha AN8855 Internal
 Switch Gigabit PHY
Message-ID: <87aad5ff-4876-4611-8cf8-5c20df3559b3@lunn.ch>
References: <20241023161958.12056-1-ansuelsmth@gmail.com>
 <20241023161958.12056-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023161958.12056-4-ansuelsmth@gmail.com>

> +	/* Enable Asymmetric Pause Capability */
> +	ret = phy_set_bits(phydev, MII_ADVERTISE, ADVERTISE_PAUSE_ASYM);
> +	if (ret)
> +		return ret;

The PHY driver alone does not decide this. The MAC driver needs to
indicate it supports asym pause by calling phy_supports_asym_pause().

> +
> +	/* Disable EEE */
> +	ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);
> +	if (ret)
> +		return ret;

Again, the core code should handle this, unless EEE is broken and you
need to force it off.

	Andrew

