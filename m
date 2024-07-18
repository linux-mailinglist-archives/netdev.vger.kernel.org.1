Return-Path: <netdev+bounces-111988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFCA934660
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 04:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4AF1C21AC5
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 02:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB27A358A7;
	Thu, 18 Jul 2024 02:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6cSfuiec"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FF315C9;
	Thu, 18 Jul 2024 02:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721269480; cv=none; b=M9RYdm0outSI/6gUqUmMcu9w/f4Arqw19kUQQJyzzaH8BRSKjXn4FCuCwJTpMRgR+Bp8BEgjV5ELX/KcKyejdEp5SmOf/kTcMs2rkeF63pYSmNY4xaiZCLmyOM1Ak6onzY7PlwhTJwHGEPidkl7VaeCjsvuI68cdM7Zxq0demNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721269480; c=relaxed/simple;
	bh=acUxYiwvNbR5WEmoBtEcy5LUMGpl1V6pDAJlxr5ua6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jwa3/UB3W51ksgBNaZf6znAiDGIEtFhsCFIWVb/ur9hL33iUa6o4AvNmGr4w+leVmJoDm8N4bqMZlQtoT2CyH9kyRy/Npffg1aiTrD3u3dxN6iXT/+2MunPRlZoeG/DNpqhmfAQvaLJh5ZIOTqlHnDcHd3FE9MR8KMOOrFmC/EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6cSfuiec; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0vk8fef/oz3YdgiNmk3ULxUwdiIR7F4J+UJ0/Uf9pnE=; b=6cSfuiecrWilzJ7nH+o56SBaUG
	EjBLFPLBBgOrA0R3/xATbgXZ4YzIabz5PHDHgfhGZ7nxC8FtRgi8lv+KC2uqrhpK0NjssR/S9sbp2
	fuOvfGGFvTMpotywVvGjtU6oyDSq3OFOy2NGoQ5MBuJgde2MjeWcPxab9uDHTQ28zlPw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sUGos-002kdR-G6; Thu, 18 Jul 2024 04:24:34 +0200
Date: Thu, 18 Jul 2024 04:24:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: vtpieter@gmail.com
Cc: devicetree@vger.kernel.org, woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: Re: [PATCH 3/4] net: dsa: microchip: check erratum workaround
 through indirect register read
Message-ID: <e6285fd7-91fd-411c-bea9-ddcb62b90550@lunn.ch>
References: <20240717193725.469192-1-vtpieter@gmail.com>
 <20240717193725.469192-2-vtpieter@gmail.com>
 <20240717193725.469192-3-vtpieter@gmail.com>
 <20240717193725.469192-4-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717193725.469192-4-vtpieter@gmail.com>

On Wed, Jul 17, 2024 at 09:37:24PM +0200, vtpieter@gmail.com wrote:
> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> Check the erratum workaround application which ensures in addition
> that indirect register write and read work as expected.
> 
> Commit b7fb7729c94f ("net: dsa: microchip: fix register write order in
> ksz8_ind_write8()") would have been found faster like this.
> 
> Also fix the register naming as in the datasheet.

We are in the merge window at the moment, so net-next is closed at the
moment. Please repost in two weeks.

> 
> @@ -1974,6 +1974,7 @@ static int ksz8_handle_global_errata(struct dsa_switch *ds)
>  {
>  	struct ksz_device *dev = ds->priv;
>  	int ret = 0;
> +	u8 data = 0xff;

Reverse Christmas tree please.

>  
>  	/* KSZ87xx Errata DS80000687C.
>  	 * Module 2: Link drops with some EEE link partners.
> @@ -1981,8 +1982,13 @@ static int ksz8_handle_global_errata(struct dsa_switch *ds)
>  	 *   KSZ879x/KSZ877x/KSZ876x and some EEE link partners may result in
>  	 *   the link dropping.
>  	 */
> -	if (dev->info->ksz87xx_eee_link_erratum)
> -		ret = ksz8_ind_write8(dev, TABLE_EEE, REG_IND_EEE_GLOB2_HI, 0);
> +	if (dev->info->ksz87xx_eee_link_erratum) {
> +		ret = ksz8_ind_write8(dev, TABLE_EEE, REG_IND_EEE_GLOB2_LO, 0);
> +		if (!ret)
> +			ret = ksz8_ind_read8(dev, TABLE_EEE, REG_IND_EEE_GLOB2_LO, &data);
> +		if (!ret && data)
> +			dev_err(dev->dev, "failed to disable EEE next page exchange (erratum)\n");

If data is not 0, should it be considered fatal? Maybe return -EIO ?

	Andrew

