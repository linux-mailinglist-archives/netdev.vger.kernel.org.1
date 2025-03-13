Return-Path: <netdev+bounces-174476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0F7A5EEAC
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD9819C0721
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 08:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5C5262D2B;
	Thu, 13 Mar 2025 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ExVKALwd"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE701BDCF
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856269; cv=none; b=HxZxnI2nowfWWwR1KYTWW+YVRK49nC8eWIKpxxC3zw01xW7a+lN/GWRIFPdfiMhguGSlcdD6mrxAFVeCBh4J52D/4/wuMddf9N8kHmLB37Tawfj3gyX0/yS+YZmKc1bBj/qCAtLAbmiwyucx+gQGRRS2lFl2yUkY7Sjq1GW3prw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856269; c=relaxed/simple;
	bh=G7vJIblST1/gdjRH8war/tUZAXNDkP9tGaXJ+2SDLNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPWPBMymJIBdjRRDRamuj486xzQZIJFScepGp7s8JAW0TtpDIrhr7Rktd72aSA2n/+Eop3GhTyMi+SGgNneM9mpqROAQHeS48flNrfGyn+7AGZceMD1xNkdFsPGoidExYjt/V5lr1/FFXkZMLXZHMcFjwX3Mbju5odSbEbnWEtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ExVKALwd; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C5B082047B;
	Thu, 13 Mar 2025 08:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741856257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjaGpoAf7g+pBW4np92pFUbbxN5DdMX0vMP4nyIGpZI=;
	b=ExVKALwdVeNUZlbDnSBgykQfla9QrWGdRXx9hUiL8uRTQebXj4L/xYG6DgLyjzU+/UwBox
	ZXKEgom/Ue6cH2eD5mPfol1QVZ7GkQ95R3yfV4jPuiGQYpoPrNXMi5O1cheCwWTSS473nJ
	NFdXKiiWXUr45DToMCJZfa04nGiri8nkwic/GrpyLA2pFY5VBn2AW41BskXNdgjoq0HQKN
	NToL7BZJkbEOoHQsREfHVCIFGBuXLcCiMj+xJg0dQ8Uh8iDtJ9fZVWq/Ktwl9gTLe+o6Zo
	5r9YcQNN9Jbbxj6D0tYRJJjDmp1TmqWT+Es5xJBKDbnOPdx3rYUGly4MQGqs4g==
Date: Thu, 13 Mar 2025 09:57:29 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v10 3/5] net: phy: micrel: Add loopback support
Message-ID: <20250313095729.53a621e0@fedora-2.home>
In-Reply-To: <20250312203010.47429-4-gerhard@engleder-embedded.com>
References: <20250312203010.47429-1-gerhard@engleder-embedded.com>
	<20250312203010.47429-4-gerhard@engleder-embedded.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdejheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdqvddrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopehgvghrhhgrrhgusegvnhhglhgvuggvrhdqvghmsggvugguvggurdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgri
 hhlrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Gerhard,

On Wed, 12 Mar 2025 21:30:08 +0100
Gerhard Engleder <gerhard@engleder-embedded.com> wrote:

> The KSZ9031 PHYs requires full duplex for loopback mode. Add PHY
> specific set_loopback() to ensure this.
> 
> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> ---
>  drivers/net/phy/micrel.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 289e1d56aa65..24882d30f685 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -1032,6 +1032,29 @@ static int ksz9021_config_init(struct phy_device *phydev)
>  #define MII_KSZ9031RN_EDPD		0x23
>  #define MII_KSZ9031RN_EDPD_ENABLE	BIT(0)
>  
> +static int ksz9031_set_loopback(struct phy_device *phydev, bool enable,
> +				int speed)
> +{
> +	u16 ctl = BMCR_LOOPBACK;
> +	int val;
> +
> +	if (!enable)
> +		return genphy_loopback(phydev, enable, 0);
> +
> +	if (speed == SPEED_10 || speed == SPEED_100 || speed == SPEED_1000)
> +		phydev->speed = speed;
> +	else if (speed)
> +		return -EINVAL;
> +	phydev->duplex = DUPLEX_FULL;
> +
> +	ctl |= mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
> +
> +	phy_write(phydev, MII_BMCR, ctl);
> +
> +	return phy_read_poll_timeout(phydev, MII_BMSR, val, val & BMSR_LSTATUS,
> +				     5000, 500000, true);

Maybe I don't fully get it, but it looks to me that you poll, waiting
for the link to become up. As you are in local loopback mode, how does
that work ? Do you need connection to an active LP for loopback to
work, or does the BMSR_LSTATUS bit behave differently under local
loopback ?

Maxime

