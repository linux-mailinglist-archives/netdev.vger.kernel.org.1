Return-Path: <netdev+bounces-142425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E79C19BF0D7
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 15:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E7A7B2254C
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 14:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35197202F69;
	Wed,  6 Nov 2024 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TWdQIdLm"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9587A202649;
	Wed,  6 Nov 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904906; cv=none; b=TqvK0XaARpLmbpnhfhP1Pc8dKd0WsbUT3bcgm41PAn2uJRquVet5kGwAp3aSotWEkJRyfz4TDaFD4WqgPa1EPkEgf0BZt3Na0Oxd1WQJ3wXj0hPXBjf0hWy4BX5RlsFUZ7inF/UZ5sSyAS01iWEghWAFF4z17VD4ZJpa++dPDtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904906; c=relaxed/simple;
	bh=OJHVbqhWpfJnKXIzjbx+KUzyyU2R6F82dSEUmF3bwiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9pBCWc6zW7JBhmn5JRdl4fO9itNvrA5/fPauFPwC3XPB87vHyid1ecAxwDxLXwpg8KKFz2gc5IKLZ3m2vBwMkVHjrY3A2+UEwhtvUej2ol+yHK98Rf/hMxa20OYS+1wZ+NlJXY0hXdGEsIaI/LdHpu7PbMoRtaAwFkQgr6AdWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TWdQIdLm; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 90631FF80A;
	Wed,  6 Nov 2024 14:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730904901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bd5qlV0ry9Timmvb34UfzsATtR5/fb6bpyJVQ5gjwbM=;
	b=TWdQIdLm7OWOZLR8j3B17CgfGIw2sp0Lxy3/CVYNHtmX8mzp5Zruai9XL4T6mFBDk8E2UT
	040oy2WNAJnzcJe60B4bCsIm+Cl0tmwnVoHdlzVm8E59f2Xu2/7zP4rYtr66+kNPfMZm5u
	M1+7Uwu7zO2FuC7xMkWRSU7lpD6ZboMMYsqC1wvzBwLwNNHbf2b/UF9SLJA1J+ZflYMxvE
	s7ByrDs5c7VfA4cpgptfI4y0FnWSpcHzWVTStnkQ1cs65EuQeAvyrJpQzQlrbNpPVAtbci
	BxQiKxnyJf9MhQXFeCP/nOXSsM6dMU91sHM/+YNmI8o0uyggUabAtNzFzzGOBg==
Date: Wed, 6 Nov 2024 15:54:58 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@airoha.com
Subject: Re: [net-next PATCH v3 3/3] net: phy: Add Airoha AN8855 Internal
 Switch Gigabit PHY
Message-ID: <20241106155458.3552cdda@fedora.home>
In-Reply-To: <20241106122254.13228-4-ansuelsmth@gmail.com>
References: <20241106122254.13228-1-ansuelsmth@gmail.com>
	<20241106122254.13228-4-ansuelsmth@gmail.com>
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

Hello Christian,

On Wed,  6 Nov 2024 13:22:38 +0100
Christian Marangi <ansuelsmth@gmail.com> wrote:

> Add support for Airoha AN8855 Internal Switch Gigabit PHY.
> 
> This is a simple PHY driver to configure and calibrate the PHY for the
> AN8855 Switch with the use of NVMEM cells.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

[...]

> +static int an8855_get_downshift(struct phy_device *phydev, u8 *data)
> +{
> +	int saved_page;
> +	int val;
> +	int ret;
> +
> +	saved_page = phy_select_page(phydev, AN8855_PHY_PAGE_EXTENDED_1);
> +	if (saved_page >= 0)
> +		val = __phy_read(phydev, AN8855_PHY_EXT_REG_14);
> +	ret = phy_restore_page(phydev, saved_page, val);

I think this can be replaced with phy_read_paged()

[...]

> +static int an8855_set_downshift(struct phy_device *phydev, u8 cnt)
> +{
> +	int saved_page;
> +	int ret;
> +
> +	saved_page = phy_select_page(phydev, AN8855_PHY_PAGE_EXTENDED_1);
> +	if (saved_page >= 0) {
> +		if (cnt != DOWNSHIFT_DEV_DISABLE)
> +			ret = __phy_set_bits(phydev, AN8855_PHY_EXT_REG_14,
> +					     AN8855_PHY_EN_DOWN_SHFIT);
> +		else
> +			ret = __phy_clear_bits(phydev, AN8855_PHY_EXT_REG_14,
> +					       AN8855_PHY_EN_DOWN_SHFIT);
> +	}
> +
> +	return phy_restore_page(phydev, saved_page, ret);

And this by phy_modify_paged() :)

Thanks,

Maxime

