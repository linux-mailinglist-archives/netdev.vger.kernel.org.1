Return-Path: <netdev+bounces-129885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC86D986CB2
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 08:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9D6282FD8
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 06:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7628188CA5;
	Thu, 26 Sep 2024 06:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Hinq26xx"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CABC188A0A;
	Thu, 26 Sep 2024 06:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727332965; cv=none; b=dqkDCMSxoPkS50yppc7U5ZxfQ96zriBm4ZzALj2SqtS0NLvYW0xPlWtyLc7iKXQE5PxVfgjf2Al741fG0RLG8zeyT48GdIMLYhA56Rz1DojEkNKB2Ko3Z2FsTh0xrNBAPEsQD2cLhY08Wf418QkqgzDVpAud+XAlg/w0ykpGglM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727332965; c=relaxed/simple;
	bh=qgINXFFH8CgkNeufo3VqgmvlEs65suKlSSutu/MIEfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R89Hw1Yo+k+6wn4gktUvhN5EQiEQ0xuGAzJdLQeY8/cvkFd+lY+V3DuoNqJ1E9qgdaWx2p+UiXOeIwz0jiXN3y+usKqcZldlA/OMRntE2ODNx+AZfdtII98dE2uAlAeaySc74dVpysOua7w7m8zz4quke7l22HW48hlCf4FKkto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Hinq26xx; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 2262BC017B;
	Thu, 26 Sep 2024 06:42:33 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 35AF8C0009;
	Thu, 26 Sep 2024 06:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727332945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSl+x4yB2HAc1rNghZGKMNPTySVIpuiqh6T8oSAPYPM=;
	b=Hinq26xxYj8wFLdNhFvYb7mND6z9NRu5ePojvtxKw5p6PGBQKMErxOncw8GrnuDS6vfLG/
	VAEdf79NI32N5BGQG6sjFu2WMcmLIOg2IweEcRe2Plgt3g590pWVPZO1plw6kJc9cmW3QW
	xmQjydz4bq7He1qQR6H3xlII98nHf8/fQ8T4SHNjvk1rkUgGjY+NUJV8C6aH+BZcRK4AP5
	XCnoTQfySRrSp4E5zRtDTyhB+AQ+fNTtNIpJT7zhSjbnRJ4PZV54rlbBLhYsjrLHfLG5no
	15Zy3Z6qXKVmJSf4rVC2r2SLJbkFmXYsW98rd7OKnyk79XVBjWvOkU+QBS5rLw==
Date: Thu, 26 Sep 2024 08:42:22 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Halaney <ahalaney@redhat.com>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, "linux-tegra@vger.kernel.org"
 <linux-tegra@vger.kernel.org>, Brad Griffis <bgriffis@nvidia.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Jon Hunter <jonathanh@nvidia.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, kernel@quicinc.com
Subject: Re: [PATCH net v3 1/2] net: phy: aquantia: AQR115c fix up PMA
 capabilities
Message-ID: <20240926084222.48042652@fedora.home>
In-Reply-To: <20240925230129.2064336-2-quic_abchauha@quicinc.com>
References: <20240925230129.2064336-1-quic_abchauha@quicinc.com>
	<20240925230129.2064336-2-quic_abchauha@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello,

On Wed, 25 Sep 2024 16:01:28 -0700
Abhishek Chauhan <quic_abchauha@quicinc.com> wrote:

> AQR115c reports incorrect PMA capabilities which includes
> 10G/5G and also incorrectly disables capabilities like autoneg
> and 10Mbps support.
> 
> AQR115c as per the Marvell databook supports speeds up to 2.5Gbps
> with autonegotiation.
> 
> Fixes: 0ebc581f8a4b ("net: phy: aquantia: add support for aqr115c")
> Link: https://lore.kernel.org/all/20240913011635.1286027-1-quic_abchauha@quicinc.com/T/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---

[...]

>  
> +static int aqr115c_get_features(struct phy_device *phydev)
> +{
> +	int ret;
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
> +
> +	/* Normal feature discovery */
> +	ret = genphy_c45_pma_read_abilities(phydev);
> +	if (ret)
> +		return ret;
> +
> +	/* PHY FIXUP */
> +	/* Although the PHY sets bit 12.18.19.48, it does not support 5G/10G modes */
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, phydev->supported);
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT, phydev->supported);
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT, phydev->supported);
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, phydev->supported);
> +
> +	/* Phy supports Speeds up to 2.5G with Autoneg though the phy PMA says otherwise */
> +	linkmode_copy(supported, phy_gbit_features);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);

I still think you shouldn't report 2500BaseX, as you mentionned
it's a BaseT PHY. This is independent of the modes that the PHY uses to
connect to the MAC. Although the PHY can talk to the MAC using
2500BaseX on its MII interface, it looks like it can't use
2500BaseX on its MDI (the LP side of the PHY). There's the same issue in
patch 2.

Thanks,

Maxime

