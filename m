Return-Path: <netdev+bounces-230355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7766CBE6F29
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EC854F9A13
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 07:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22001FE45D;
	Fri, 17 Oct 2025 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="JS5dCLve"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF5333469A;
	Fri, 17 Oct 2025 07:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686455; cv=none; b=jfysD/SNN+Cg2TwR9gnZgvcW9b3RhHd61h4j6PxU5yMhLrsp3xUDWUY3JD1+4bheuqFHSiRFtACBL2AmCrBDn2cuiXisRUySYWzvWf4iZMxutN9UrW/li4JTsAv1jClJYGKjEswSMYDze9cZRkLKRIzHh9NjOByqwqtzsVSJO4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686455; c=relaxed/simple;
	bh=VhvxgVrumFljJemoHV9Ncc/YSxZDjwvkWBnkmWbWLAc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sokPR/mxIkf1py5MQ7FKNz0WBz0byqDcGfzGDc4kxfToUxulINk8iWvJdRatHQx2kXg5RvL5kYcQD00qLU3tLoN4CSAhNtJF/Van6PoeEVq1V0XL1suMHVA6QebpYaOO6XbrGrs5uifPFALW28quLMPAXJaYF8n8QzPy7n1AclM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=JS5dCLve; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id B6002A0AC4;
	Fri, 17 Oct 2025 09:33:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=mail;
	 bh=B+2J7TtA2OH0oL/nV6lvMZERVrVLqe09ngk2BbnJBRw=; b=JS5dCLve0nzk
	LOS6drqS2NZW+BzhcnDONe7oRMQFXJcR6dZgxD21pPjL+T1mpgmLpF6ydtH3E9UW
	gydNtrouxzUJAV6F53jNs/4WtTUibqOYHAdagxrN5LK9IEXR28TJja60dq3GEg7Z
	+opJYbAwlDX29NQhDXsBgvsJG5hppymNt0K37hVKC6QPV+z+EbiJdSWSdHV3gtfq
	xKwqPS2bpfR1wh9dpq1y267QKePkvWRoBlbrVmLqcf3SclsRw0T8af1lJKkPohFA
	Fv8jDM6Bojpbwon+Z4GLgXLEg5st3EyLsvsCsYIRqVnFzOkSxTqivH1ZJcWvjeBy
	XNoZ/nffoE/CRHePYRDUcVdI8lyVbVYhgjmE53V5btfTMg2KC2zLTIy1cvP1RL+3
	02bNx6lIBPKHd4IvNcYTkCtdJA2xZDNs42Yk9/LlhQhgsVv/vIvYxOlQu/vk3i2v
	IZjq2RU8lwumql+XjcUDLPf32O/TaJ13yDmWxkBAGdMHZe4R2yNf41OG0+rdAxpa
	b/SMqaKkAWfLQzMjRwpR5AKSNKcFspSHqCgtficCnwvVQtwhwX7iXal2BwsEhTwx
	Axye0mk55K4rRRfu4xEl3+0vtF+rP2sAKWDfmx89884/Uk9dV2dgJC4yE2vHEpPK
	zfAaUHUP/1T6dU/mQeRZXZRG540EnYw=
Date: Fri, 17 Oct 2025 09:33:58 +0200
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] net: mdio: reset PHY before attempting to access
 registers in fwnode_mdiobus_register_phy
Message-ID: <aPHxZrLrCyjVO9cR@debianbuilder>
References: <20251015134503.107925-1-buday.csaba@prolan.hu>
 <20251015134503.107925-4-buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251015134503.107925-4-buday.csaba@prolan.hu>
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1760686438;VERSION=8000;MC=2892134122;ID=598320;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F64776A

Dear Maintainers,

I am about the submit the v3 version of these patches, hopefully the last
iteration. I think I managed to elimante all failures and almost all of
the warnings, except one: patchwork complies, that not all the maintainers
are CC'ed.

I have used get_maintainers.pl to get the address list. I am on the
net-next tree. Is there a problem with get_maintainers.pl or with
patchwork? Can I ignore that warning?

Reference:
https://patchwork.kernel.org/project/netdevbpf/patch/20251015134503.107925-1-buday.csaba@prolan.hu/

Thank you,
Csaba

On Wed, Oct 15, 2025 at 03:45:03PM +0200, Buday Csaba wrote:
> Implement support for the `phy-id-read-needs-reset` device tree
> property.
> 
> When the ID of an ethernet PHY is not provided by the 'compatible'
> string in the device tree, its actual ID is read via the MDIO bus.
> For some PHYs this could be unsafe, since a hard reset may be
> necessary to safely access the MDIO registers.
> 
> This patch performs the hard-reset before attempting to read the ID,
> when the mentioned device tree property is present.
> 
> There were previous attempts to implement such functionality, I
> tried to collect a few of these (see links).
> 
> Link: https://lore.kernel.org/lkml/1499346330-12166-2-git-send-email-richard.leitner@skidata.com/
> Link: https://lore.kernel.org/all/20230405-net-next-topic-net-phy-reset-v1-0-7e5329f08002@pengutronix.de/
> Link: https://lore.kernel.org/netdev/20250709133222.48802-4-buday.csaba@prolan.hu/
> 
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> ---
> V1 -> V2:
>  - renamed DT property `reset-phy-before-probe` to
>   `phy-id-read-needs-reset`
>  - renamed fwnode_reset_phy_before_probe() to
>    fwnode_reset_phy()
>  - added kernel-doc for fwnode_reset_phy()
>  - improved error handling in fwnode_reset_phy()
> ---
>  drivers/net/mdio/fwnode_mdio.c | 37 +++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
> index ba7091518..6987b1a51 100644
> --- a/drivers/net/mdio/fwnode_mdio.c
> +++ b/drivers/net/mdio/fwnode_mdio.c
> @@ -114,6 +114,38 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
>  }
>  EXPORT_SYMBOL(fwnode_mdiobus_phy_device_register);
>  
> +/**
> + * fwnode_reset_phy() - Hard-reset a PHY before registration
> + */
> +static int fwnode_reset_phy(struct mii_bus *bus, u32 addr,
> +			    struct fwnode_handle *phy_node)
> +{
> +	struct mdio_device *tmpdev;
> +	int err;
> +
> +	tmpdev = mdio_device_create(bus, addr);
> +	if (IS_ERR(tmpdev))
> +		return PTR_ERR(tmpdev);
> +
> +	fwnode_handle_get(phy_node);
> +	device_set_node(&tmpdev->dev, phy_node);
> +	err = mdio_device_register_reset(tmpdev);
> +	if (err) {
> +		mdio_device_free(tmpdev);
> +		return err;
> +	}
> +
> +	mdio_device_reset(tmpdev, 1);
> +	mdio_device_reset(tmpdev, 0);
> +
> +	mdio_device_unregister_reset(tmpdev);
> +
> +	mdio_device_free(tmpdev);
> +	fwnode_handle_put(phy_node);
> +
> +	return 0;
> +}
> +
>  int fwnode_mdiobus_register_phy(struct mii_bus *bus,
>  				struct fwnode_handle *child, u32 addr)
>  {
> @@ -129,8 +161,11 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
>  		return PTR_ERR(mii_ts);
>  
>  	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
> -	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
> +	if (is_c45 || fwnode_get_phy_id(child, &phy_id)) {
> +		if (fwnode_property_present(child, "reset-phy-before-probe"))
> +			fwnode_reset_phy(bus, addr, child);
>  		phy = get_phy_device(bus, addr, is_c45);
> +	}
>  	else
>  		phy = phy_device_create(bus, addr, phy_id, 0, NULL);
>  	if (IS_ERR(phy)) {
> -- 
> 2.39.5
> 


