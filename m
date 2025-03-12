Return-Path: <netdev+bounces-174171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E47DCA5DBA9
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 12:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C89179C0E
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 11:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3721A256B;
	Wed, 12 Mar 2025 11:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pWtyuroE"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884FD23F36D
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779332; cv=none; b=oyIlOJ7s08lafaWN01Zz53mFewj5Hl6vymQU+CCAMhxzwizpZmnpRGErsVPBHCQPrqol8M0mo4j0qpW48tWoU7XSCNrGqwOWfBW5JlXkubjI4WJiLfp+rDwhkxArzGCRFyvzGkYWIfdC6Zi2O1x5vW+MgBeIFmFNtx6gMJ2vMLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779332; c=relaxed/simple;
	bh=C/UKJwH2xjpVP4nZw9XWA9K9w17ktn0MSk2x//vmvrs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHyHDviuCXEHhBepqBfTYX2xWbBfmSYcCIxbbXQF45sBhLQg3t0bXs5Yti/D3ovMjzIV+aj9sRX+JfYau1KKAwE+eGP7VEJd+fq+N+8LloiKn2JD/SGedM/uxCrjH4g9/pJSB1tFCjy0Jefpzx6jrRU/xHybjLbgrdVeH+QjTQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pWtyuroE; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CBBBB432BF;
	Wed, 12 Mar 2025 11:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741779328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fNLn1zJ2mVMbsNnrsGHIejUAbzXyz3VrIhclvIhAKkE=;
	b=pWtyuroEAmHQAEo3ZmdcJcdFiOoxosYWlpst2HmI7YGmuibPzJGw4esfNqUTUu1R5MuFh/
	x5zeqtd0XQvs2RfZoEz6wp1tSpRnw7iaO1I6zlwgouYl9sa8LGzaiyH8eSYBtvbL3gqhls
	JDJbA5xXnHLUF9QOmJN/4PYKEGFAAJp9qf8JCactr3VGuyGoSScUA93YOXK37g3k1Vs1L6
	/tkbUx6pj0QmjmpkWY4aOR4GCLAqJjwaBdcIIcrLpXy5OkDVz1LEXr55bfvcrTPBEAKVj7
	6HFYiF4OR/j0D9wmM2vy8Ob53vYOsJlvQkDMbqXoEeMswqyhgYr0+I2m+dZ/sg==
Date: Wed, 12 Mar 2025 12:35:25 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 pierre@stackhpc.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 christophe.leroy@csgroup.eu, arkadiusz.kubalewski@intel.com,
 vadim.fedorenko@linux.dev
Subject: Re: [PATCH net v2 3/3] phy: fix xa_alloc_cyclic() error handling
Message-ID: <20250312123525.0164272e@fedora.home>
In-Reply-To: <20250312095251.2554708-4-michal.swiatkowski@linux.intel.com>
References: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
	<20250312095251.2554708-4-michal.swiatkowski@linux.intel.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdegleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepmhhitghhrghlrdhsfihirghtkhhofihskhhisehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhir
 hhisehrvghsnhhulhhlihdruhhspdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

On Wed, 12 Mar 2025 10:52:51 +0100
Michal Swiatkowski <michal.swiatkowski@linux.intel.com> wrote:

> xa_alloc_cyclic() can return 1, which isn't an error. To prevent
> situation when the caller of this function will treat it as no error do
> a check only for negative here.
> 
> Fixes: 384968786909 ("net: phy: Introduce ethernet link topology representation")
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/phy/phy_link_topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> index 4a5d73002a1a..0e9e987f37dd 100644
> --- a/drivers/net/phy/phy_link_topology.c
> +++ b/drivers/net/phy/phy_link_topology.c
> @@ -73,7 +73,7 @@ int phy_link_topo_add_phy(struct net_device *dev,
>  				      xa_limit_32b, &topo->next_phy_index,
>  				      GFP_KERNEL);
>  
> -	if (ret)
> +	if (ret < 0)
>  		goto err;
>  
>  	return 0;

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thank you,

Maxime

