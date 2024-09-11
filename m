Return-Path: <netdev+bounces-127498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAAA97595A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A110D1C22EA7
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3A51B1417;
	Wed, 11 Sep 2024 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Rl5HHneR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5073A1B29C1;
	Wed, 11 Sep 2024 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075598; cv=none; b=qS6Ey6mZREPqJgmNa+Hqr291SWiiy4yP3jHGM1J0UDtY/J3nlMfcQ9ZpIYWG7W1k47PhSTmoCzLtP4X9hyCnI3nhcOLKxN4VtEmnZb8quyepKRI3e/OFtuSdSpv2GUlHEQqF3IK65+rLmNRjxup/8kGz/v3tEMmYtPlAETpz8D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075598; c=relaxed/simple;
	bh=V/0J+gwv/n3AtLA+rJXg3PKb+fScaPY1w1sU6qEwptg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltGanLv0McXL/4RHUow0Chysr/OoqSInragxED8LwtcJGWFaNQLZV8GFfPurD21XLN1U8c/08hTrGvt9Nc8hVfGt6QepaNUpn0f/wjwbX1BqqGOdZWurdP01QGi13HNynoCqZOSDtzyQC2riDuzxGZPn5eQmzapLi7vL17qPwvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Rl5HHneR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JnKWS+Fj8X3K2J34ug0Ii1c0TCxXIH/EG4XIfAwIB2E=; b=Rl5HHneRL2ql7I9bnSjF5Il1aV
	yKkRuMHXQPLwE61I9My+acCCMpPwxrquNO4a/KXcDTM/z+WeOTvo2Yw7kbQGdnKixCDOjWF+Ij412
	SXP/J2HOU4gwgA0JtU2K7gs7DPOEM+jisycvjOd6aqNRgs6ufFOo/u1UcUf30D/opz1I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1soR6l-007Emn-6K; Wed, 11 Sep 2024 19:26:23 +0200
Date: Wed, 11 Sep 2024 19:26:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com, rdunlap@infradead.org,
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
Message-ID: <c6e36569-e3a8-4962-ac85-2fd7d35ab5d1@lunn.ch>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-5-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911161054.4494-5-Raju.Lakkaraju@microchip.com>

> +static int pci11x1x_pcs_read(struct mii_bus *bus, int addr, int devnum,
> +			     int regnum)
> +{
> +	struct lan743x_adapter *adapter = bus->priv;
> +
> +	if (addr)
> +		return -EOPNOTSUPP;
> +
> +	return lan743x_sgmii_read(adapter, devnum, regnum);
> +}

>  static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
>  {
> +	struct dw_xpcs *xpcs;
>  	u32 sgmii_ctl;
>  	int ret;
>  
> @@ -3783,8 +3823,17 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
>  				  "SGMII operation\n");
>  			adapter->mdiobus->read = lan743x_mdiobus_read_c22;
>  			adapter->mdiobus->write = lan743x_mdiobus_write_c22;
> -			adapter->mdiobus->read_c45 = lan743x_mdiobus_read_c45;
> -			adapter->mdiobus->write_c45 = lan743x_mdiobus_write_c45;
> +			if (adapter->is_sfp_support_en) {
> +				adapter->mdiobus->read_c45 =
> +					pci11x1x_pcs_read;
> +				adapter->mdiobus->write_c45 =
> +					pci11x1x_pcs_write;

As you can see, the naming convention is to put the bus transaction
type on the end. So please name these pci11x1x_pcs_read_c45...

Also, am i reading this correct. C22 transfers will go out a
completely different bus to C45 transfers when there is an SFP?

If there are two physical MDIO busses, please instantiate two Linux
MDIO busses.

    Andrew

---
pw-bot: cr

