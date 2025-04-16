Return-Path: <netdev+bounces-183253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA59A8B787
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 13:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793AB3BFF86
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7287823BFA3;
	Wed, 16 Apr 2025 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dZbTltA5"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF241238C09
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744802370; cv=none; b=XY58YkpHFl6p8UCFKBRQ0zC4nF/1+J867ZlUcysVVUMHtsKDuR5VQ564d4cXC3gVqi1Q1FodoJsy02zl7Gf0h/sGCPwHO6txvPtFOUAcKA7BOsw1HBQkZDwTSi75NVkMp2uD2TjhKSD+ekBZNbZnOvbtjdqH+5ci1A9K+dnb9Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744802370; c=relaxed/simple;
	bh=ctw4SB0mIdgz5R5qN7IcZ/Mx6l5Nx8rh0aSIWJi0NRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcK5jFkZPIW49EADTYnN6LgOofn2Q5HRv/dd6vqai9d5dRHugCaMe141o3ryb89GZF9WRPVMCluKCUIYwUCTaRM5VT5vKHwx2O3yGzzfWwjBAxlFVqpoK3oIdHLA6D5JsQtLv8Aa63XOwgby30Vu1GAKs5CmBghOqBj2w2dxY1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dZbTltA5; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 764F01FCEA;
	Wed, 16 Apr 2025 11:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744802365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BgL4bb6DJsY0X2uch3UIRkw8nqLjqKutjCA1hYMMONc=;
	b=dZbTltA57yBAmrO6sMjbBeHFlyFYNPYxN4/TRtuIGmVHZK+u1R2U9qyfuF6xlEkztr6PqD
	zOe6cLPsQnmbbLR5g83MKJX1jVpoL4t3OVdqmCOsesD2OAShDo7XMmwqR2NY/AC871hOma
	v6I5OLrtiY7/csxLx/DOHJKXoVQYPSllkDW2Zb55ZUSrmqc868mga0sLQw9taA2XlwMF7J
	HdAqAYYfEH5ASaJmxMNOfa0Vw7eN3k2NveqGMVV7474U3q+31z4duXqvp9gzsDWR72a6sL
	qrM9XI2KMvTJNV1WQqtkLoz7TQjGhq5W7sKDIIdXa2498K+a1T2f02NDHNYLdw==
Date: Wed, 16 Apr 2025 13:19:23 +0200
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
Subject: Re: [PATCH net-next v2 0/5] net: stmmac: socfpga: fix init ordering
 and cleanups
Message-ID: <20250416131923.40cf0a06@fedora.home>
In-Reply-To: <Z_95AM64tt_4ri1j@shell.armlinux.org.uk>
References: <Z_95AM64tt_4ri1j@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeivdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtp
 hhtthhopegrlhgvgigrnhgurhgvrdhtohhrghhuvgesfhhoshhsrdhsthdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Russell,

On Wed, 16 Apr 2025 10:31:44 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> Hi,
> 
> This series fixes the init ordering of the socfpga probe function.
> The standard rule is to do all setup before publishing any device,
> and socfpga violates that. I can see no reason for this, but these
> patches have not been tested on hardware.
> 
> Address this by moving the initialisation of dwmac->stmmac_rst
> along with all the other dwmac initialisers - there's no reason
> for this to be late as plat_dat->stmmac_rst has already been
> populated.
> 
> Next, replace the call to ops->set_phy_mode() with an init function
> socfpga_dwmac_init() which will then be linked in to plat_dat->init.
> 
> Then, add this to plat_dat->init, and switch to stmmac_pltfr_pm_ops
> from the private ops. The runtime suspend/resume socfpga implementations
> are identical to the platform ones, but misses the noirq versions
> which this will add.
> 
> Before we swap the order of socfpga_dwmac_init() and
> stmmac_dvr_probe(), we need to change the way the interface is
> obtained, as that uses driver data and the struct net_device which
> haven't been initialised. Save a pointer to plat_dat in the socfpga
> private data, and use that to get the interface mode. We can then swap
> the order of the init and probe functions.
> 
> Finally, convert to devm_stmmac_pltfr_probe() by moving the call
> to ops->set_phy_mode() into an init function appropriately populating
> plat_dat->init.
> 
> v2: fix oops when calling set_phy_mode() early.
> 
>  .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    | 79 +++++-----------------
>  1 file changed, 16 insertions(+), 63 deletions(-)

Feel free to CC: me for dwmac-socfpga stuff, I have some HW to test this
on :)

Thanks for this work, it's working fine :)

For the series,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

