Return-Path: <netdev+bounces-127570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C40975C15
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297D8281BD3
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B131F14A096;
	Wed, 11 Sep 2024 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="icmHwbnI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A8E3D3B8
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726088288; cv=none; b=XB7fjS1YBoiXJZG/HDHWISenY5PRfDFFFkIvS/DP7DrKAn/BXa3RZVgNqieyxponD84fiX4NLE1ZC19FWIwcR+mc3cAae2GdjC544qw8FCXRt2W9QvzqBTJY09YL6ISXOZUBZKQA+q/m4G+eEh/ex0kx8YlC2KJtZoRr6xt2ji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726088288; c=relaxed/simple;
	bh=WdHYhlDr0nrY/shpZl1gEvLt7eS4xQRdlHVaebsM+ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0saZVXlu4jcFwUbx9qGhOdJ/wSC07uy6Ii6szKtaTjUJ2ItgQQUE2PG2zsI0I8jrYabdbT34fNdaMvGgkfSOZInPPZ1ChwZ7Io5JhiaTC3wQPSzGnqDchNT+U9ocv7SvPlJ5NAwK5EpasPKOH4cLxkm6whC08BSRbZVdcMpjCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=icmHwbnI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=smgOifiQdNUjpHBcg4tZ8DkBdEcwy5jVm7G1psfO4EI=; b=icmHwbnIfhqE7XBiPLngPjo7aG
	ptZIu5rq1R9JLjAbFpLhc85XFV0pK4QAVK7nSa3njwxU9jRRR1De8f2q1Z8md7poCSQ3hjgGTExCC
	Dh99mzCcoBoTDCQn0r8zxY0icvyc9sLPmJsMTDshk2KYyi35vmWpqKzhl53PPFS04/yk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1soUPa-007FhY-7e; Wed, 11 Sep 2024 22:58:02 +0200
Date: Wed, 11 Sep 2024 22:58:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hans-Frieder Vogt <hfdevel@gmx.net>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/5] net: phy: aquantia: search for
 firmware-name in fwnode
Message-ID: <0f811481-0976-4aec-a000-417d8b0a2a98@lunn.ch>
References: <trinity-da86cb70-f227-403a-be94-6e6a3fd0a0ca-1726082854312@3c-app-gmx-bs04>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-da86cb70-f227-403a-be94-6e6a3fd0a0ca-1726082854312@3c-app-gmx-bs04>

On Wed, Sep 11, 2024 at 09:27:34PM +0200, Hans-Frieder Vogt wrote:
> For loading of a firmware file over the filesystem, and
> if the system is non-device-tree, try finding firmware-name from the software
> node (or: fwnode) of the mdio device. This software node may have been
> provided by the MAC or MDIO driver.
> 
> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
> ---
>  drivers/net/phy/aquantia/aquantia_firmware.c | 25 +++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
> index 090fcc9a3413..f6154f815d72 100644
> --- a/drivers/net/phy/aquantia/aquantia_firmware.c
> +++ b/drivers/net/phy/aquantia/aquantia_firmware.c
> @@ -324,14 +324,37 @@ static int aqr_firmware_load_nvmem(struct phy_device *phydev)
>  static int aqr_firmware_load_fs(struct phy_device *phydev)
>  {
>  	struct device *dev = &phydev->mdio.dev;
> +	struct fwnode_handle *fw_node;
>  	const struct firmware *fw;
>  	const char *fw_name;
> +	u32 phy_id;
>  	int ret;
> 
>  	ret = of_property_read_string(dev->of_node, "firmware-name",
>  				      &fw_name);

Did you try just replacing this with:

    	ret = device_property_read_string(dev, "firmware-name", &fw_name);

As far as i understand, the device_property_ functions will look
around in OF, ACPI and swnode to find the given property. As long as
the MAC driver puts the property in the right place, i _think_ this
will just work.

	Andrew

