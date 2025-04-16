Return-Path: <netdev+bounces-183168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C43C7A8B3EC
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386D93A6740
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 08:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE669205E00;
	Wed, 16 Apr 2025 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UWDn9fuG"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F027A18FDD5
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744792382; cv=none; b=mxI1ogJRWJTPqgnWLVrMdV4Om4be7qJXNAwXMh8/Yp90pl6lQvT2YWli+R7mxQeVNoty+Lamg7CpccXQa/yqDtRpUTMiDs+7ux8r/kzQgtYHuzdzuKFVo5bP7Ti6qEwxtph8AOvsITVB7wyvWiBHR2P3u8mpkCxgyLvZHvFTBHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744792382; c=relaxed/simple;
	bh=2WVJBRqhDFU85DmzsRJ7X3VnauLaC/rGvRhHi4S7aAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2pLgzEekXH+074WOa60K2pORfJ4Lc1LuuqyMsjdKUHpIrSftWv5hb3L7nT6WrDgpKGke3dEO9jRyCM7577gHSRNbdFB0Pq6WUiuqSZsSTBhqLx7CsvwdKLvaOTHFE9vfFPiyDySLhJK1zEGskUHoX08YNkXn+ZulnsUfXxxx5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UWDn9fuG; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 05D39433EC;
	Wed, 16 Apr 2025 08:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744792378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQGQgS3fn9DpLHF39v5wKc9omOFCoaDRzybsm2gWEIE=;
	b=UWDn9fuGUR59UV7s0DWAYDL0GZA6lja8F9iLNR0CJm41eX4TBQgHujtyQR0dQ9lamNwbKK
	ynw+rFpw8QvOgLP1M3LsmaAyOW+wqFCNfkKm+jiiwo8yaIvcsXSQH1gEzk5+T5cMLBPCqB
	/egJWGENgZXhvhu721EkXQG3NWlIw3g5Z4nzBLcj35NcuJF/RQcuko7k6+AjY14H0w7Juj
	M9r59IYpzvkiQsahyB2sxO0hsXuO4821Y4D3oXYm4KUWzjbFxRw0LKsU0MCo7EgWbM+bbr
	uE5v0PHcjcYVzMvUPaN3fPUf2HBJbOJJ1Onc+KB/DPZiNxgYzwGymLzNd5zKkA==
Date: Wed, 16 Apr 2025 10:32:53 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/5] net: stmmac: socfpga: fix init ordering
 and cleanups
Message-ID: <20250416103253.629db3de@fedora.home>
In-Reply-To: <Z_9oVrAOnInrhb6z@shell.armlinux.org.uk>
References: <Z_6JaPBiGu_RB4xN@shell.armlinux.org.uk>
	<20250416095343.1820272f@fedora.home>
	<Z_9oVrAOnInrhb6z@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdehledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtp
 hhtthhopegrlhgvgigrnhgurhgvrdhtohhrghhuvgesfhhoshhsrdhsthdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Wed, 16 Apr 2025 09:20:38 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Apr 16, 2025 at 09:53:43AM +0200, Maxime Chevallier wrote:
> > I've given this a try and unfortunately :  
> 
> Great, someone with hardware, and who responds to patches! :)
> 
> > This is only to get the phymode, maybe we should do like dwmac_imx
> > and store a pointer to plat_dat into struct dwmac_socfpga, so that we
> > can get it back in dwmac_init ? I've tried with the patch below and it
> > does solve the issue, but maybe you have a better approach.  
> 
> Yes, but I don't think we need such a big patch:
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> index 8e6d780669b9..59f90b123c5b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> @@ -50,6 +50,7 @@ struct socfpga_dwmac {
>  	u32	reg_offset;
>  	u32	reg_shift;
>  	struct	device *dev;
> +	struct plat_stmmacenet_data *plat_dat;
>  	struct regmap *sys_mgr_base_addr;
>  	struct reset_control *stmmac_rst;
>  	struct reset_control *stmmac_ocp_rst;
> @@ -233,10 +234,7 @@ static int socfpga_dwmac_parse_data(struct socfpga_dwmac *dwmac, struct device *
>  
>  static int socfpga_get_plat_phymode(struct socfpga_dwmac *dwmac)
>  {
> -	struct net_device *ndev = dev_get_drvdata(dwmac->dev);
> -	struct stmmac_priv *priv = netdev_priv(ndev);
> -
> -	return priv->plat->mac_interface;
> +	return dwmac->plat_dat->mac_interface;
>  }
>  
>  static void socfpga_sgmii_config(struct socfpga_dwmac *dwmac, bool enable)
> @@ -490,6 +488,7 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
>  	 */
>  	dwmac->stmmac_rst = plat_dat->stmmac_rst;
>  	dwmac->ops = ops;
> +	dwmac->plat_dat = plat_dat;
>  
>  	plat_dat->bsp_priv = dwmac;
>  	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;
> 

Even better indeed ! I've tested it and it works.

I'll be happy to test any followup :)

Maxime

