Return-Path: <netdev+bounces-128447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3879798BA
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 22:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6551281F88
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 20:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE9C17C69;
	Sun, 15 Sep 2024 20:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="43pKdVtf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A6A481CD
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 20:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726432363; cv=none; b=A1TqsjW+/+FAJZdwImRZenMmzZvYDREDD2LAvflZJ3Ve5ONDPoye+ZJU18NBzTgAQOAlafe8tVH9xlkn5cTmsHvCXuVcgLFfqWJBQeJnHbYwIt9nJk7GpT9M3ToIeBqXZHTYFZf7vjkWlxIKOoWD4NVnvXLAyGnp5ZWhCErLj5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726432363; c=relaxed/simple;
	bh=DAYBvNjYEtmNQH1RxYn+k+TTG8DPNJkPoyT44lpqsQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/DUoD41ZWCRz4R3ZjW2waE/xRXZ9L+lZfD4ovE6HuAYtBk+h5Sgp40mZMx5Kq7LDalepVCfigy87PpZYsbgOJJtPliC3yIRfTB1twbNsGqB/nB7X5MmzjUrsDxn5tnqNla6M24baAaq5VFxeV1Qw85LiHyu+ie8Fuz1DxNtm5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=43pKdVtf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=I2fdX764hQ2CuGn3Q9WjpcUuoguZt2SvrAC6i3g20Gc=; b=43pKdVtfhtojSwdCKyPbfH4Z9C
	Wusxso0VEPUu+EpmJ6VUTaiODu+rEtcTNsHKfS+Mc2CNgJny1cRP2gvqP4MnPmzqKSAP1BavssC9U
	ZHv588ojLlzuKcRriasbHZA0E/u50atrZpgZoWhUDK2YI1Fp90jR+8P/LiwEmCVbQORI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1spvvD-007WHu-BU; Sun, 15 Sep 2024 22:32:39 +0200
Date: Sun, 15 Sep 2024 22:32:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hans-Frieder Vogt <hfdevel@gmx.net>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 2/7] net: phy: aquantia: search for
 firmware-name in fwnode
Message-ID: <3a14f1b4-44c1-47d5-b641-7c8a682e4d67@lunn.ch>
References: <trinity-ad10e630-a77b-4887-b006-2f8885745738-1726430104089@3c-app-gmx-bap07>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-ad10e630-a77b-4887-b006-2f8885745738-1726430104089@3c-app-gmx-bap07>

On Sun, Sep 15, 2024 at 09:55:04PM +0200, Hans-Frieder Vogt wrote:
> Allow the firmware name of an Aquantia PHY alternatively be provided by the property
> "firmware-name" of a swnode. This software node may be provided by the MAC or MDIO driver.
> 
> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
> ---
>  drivers/net/phy/aquantia/aquantia_firmware.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
> index 524627a36c6f..f0e0f04aa2f0 100644
> --- a/drivers/net/phy/aquantia/aquantia_firmware.c
> +++ b/drivers/net/phy/aquantia/aquantia_firmware.c
> @@ -330,8 +330,14 @@ static int aqr_firmware_load_fs(struct phy_device *phydev)
> 
>  	ret = of_property_read_string(dev->of_node, "firmware-name",
>  				      &fw_name);
> +	/* try next, whether firmware-name has been provided in a swnode */
>  	if (ret)
> +		ret = device_property_read_string(dev, "firmware-name",
> +						  &fw_name);

I could be getting this wrong, but my understanding is that
device_property_read_string() will look at dev and see if there is an
OF node available. If so, it will get the property from OF. If there
is not, it looks to see if there is a swnode, and if there is, it uses
that. And if there is an ACPI node, it tries there. So i _think_ you
can replace the of_property_read_string() with
device_property_read_string().

	Andrew

