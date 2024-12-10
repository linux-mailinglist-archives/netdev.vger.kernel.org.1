Return-Path: <netdev+bounces-150451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC949EA46D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8BE28417C
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 01:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E712C433C0;
	Tue, 10 Dec 2024 01:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zlxM1gJb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46BA4A04;
	Tue, 10 Dec 2024 01:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733794607; cv=none; b=Bb58Q1qdf/YRmIgL3GWwiATQcmMSvAJOQmoB3TJAseNkAzzf17LxeTncB9yDST0N19/jbAq9mTHjUqFt1ECSE7TLrwLJ/eWFxN+7dReqdSTfc0gxwbCLIQFdh21PLKUnMuo4l672RN+vnVKhAG02hyuuehW1IJzNwwOECvMexgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733794607; c=relaxed/simple;
	bh=IBXxBCGq5VRVnZFSaHJfkZkdGijYMzRvolmtnY5fLKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRDQfIcaKLPTOvDbinDo1Z8WXRQ3Vf/nF2cCTXWlGrLru3njHqs52v/YiY/1fP6z10oqqmpoDwPUrMFly2vHDTXrh+YT6Oof/soiLzvA7Weay518Up/bN+ezw4S7G/uEEYsLDs9sKGcP2ZCVqWphrm1CaaJY4ksyQQSxzlR+jK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zlxM1gJb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eo4Cvix0Q6Ny9IVkv622V5LskCRdrNKizWnESnyiqRc=; b=zlxM1gJbeJPhQfj3PB35xuI8ka
	vkwcwGEOvFv3yoPz55tUJfg/DXCtYKZTlq9jj8viWj3uR/WYXPWDA6puNYS+cDwEyQWxoraWd54M/
	4LMvidGOhs7EPkylBIkBEcr7FTmVOI5TeH5gBWhxMDVMWJ5Ru37S+YjElYMFjqhx5C+A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKpAr-00Fjr0-8U; Tue, 10 Dec 2024 02:36:29 +0100
Date: Tue, 10 Dec 2024 02:36:29 +0100
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
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v11 9/9] net: phy: Add Airoha AN8855 Internal
 Switch Gigabit PHY
Message-ID: <b3b79c80-ac7c-456b-a3b5-eee61f671694@lunn.ch>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-10-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209134459.27110-10-ansuelsmth@gmail.com>

> +config AIR_AN8855_PHY
> +	tristate "Airoha AN8855 Internal Gigabit PHY"
> +	help
> +	  Currently supports the internal Airoha AN8855 Switch PHY.
> +
>  config AIR_EN8811H_PHY
>  	tristate "Airoha EN8811H 2.5 Gigabit PHY"
>  	help

Do you have any idea why the new one is AN, and previous one is EN?  I
just like consistent naming, or an explanation why it is not
consistent.

> +#define AN8855_PHY_ID				0xc0ff0410
> +static struct phy_driver an8855_driver[] = {
> +{
> +	PHY_ID_MATCH_EXACT(AN8855_PHY_ID),

Is there any documentation about the ID, and the lower nibble. Given
it is 0, i'm wondering if PHY_ID_MATCH_EXACT() is correct.

	Andrew

