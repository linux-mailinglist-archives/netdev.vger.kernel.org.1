Return-Path: <netdev+bounces-174949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3A6A618E7
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 19:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A23B1B641DD
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 18:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E30F20371A;
	Fri, 14 Mar 2025 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cNRVlHh7"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC47214375C;
	Fri, 14 Mar 2025 18:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975268; cv=none; b=JmXCFhIDf4UMeG5wrFaEHOA+EGosZszbmuQV0HxEma7hQKbIqMwZ8hRQU8DljdXcETb1PxAiX4tceJiQIeYp5Enu8GPJKwTw4TfXtDYneC8HtVXyZm1NmRGVcUoElC4FxLhrW4OHpQGtps1Yrs9TuG1vNCcYQWk7YZKuKHx4N6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975268; c=relaxed/simple;
	bh=yUhwWZz6MweKJmEseaeBVYn0fSUBWQP1mSHj+8asVSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9y3mbJ2tz9isYI/0ngHH9Zkxi5k1ATEgUuBbW6/9yZU/gyqoqyTlLWWwphlS02minBnf0G/7lCdAO/kyZnEjXxfUzzLTDwr30oMNMoBZgqafSGaikPpEv/6Nt1UysLte+0UN2gYTHgSy2lxdDnQwGWjl4a7AS/2ngYIItt02bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cNRVlHh7; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D51A432FB;
	Fri, 14 Mar 2025 18:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741975258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMFlSCHDb0j/OxbmG9FdYf4jzMVqwOiBPWCVBhtDuSM=;
	b=cNRVlHh7Bm1+GWYYC8JaAJYUn+9RWi9AMU/ib93vpTjziAcShYvfvqwrfB6GDXVCU+iDQc
	BTfLisKLOKhLzzmw/2s1SIOHD5YsNI2KaSKKUdtysOARkdQj6acDiGV3+CiLB/xjKE3DYb
	inMSsOFc+N15hncfmFFgCdpF0y1CvMKbg68pXfdq/bzu0Hu6sW2rSxXPjGWPXna1OcDZyj
	d2Js4tjGg3+6mvyyaHyI11k2MoRuVLIAF6eHJKQXUii9fNO/QXRyPI3hL/fj91PlJCLcnv
	z6vcROHpHohxRfKDnA/5kKTYJgw6wJAK65bkpWcBTZQf+DsM1Wj+w/0oYsNcCQ==
Date: Fri, 14 Mar 2025 19:00:56 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Michael Klein <michael@fossekall.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [net-next,v2,1/2] net: phy: realtek: Clean up RTL8211E ExtPage
 access
Message-ID: <20250314190056.739f4d81@fedora-2.home>
In-Reply-To: <20250314111545.84350-2-michael@fossekall.de>
References: <20250314111545.84350-1-michael@fossekall.de>
	<20250314111545.84350-2-michael@fossekall.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeduhedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdqvddrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepmhhitghhrggvlhesfhhoshhsvghkrghllhdruggvpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrt
 ghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Michael,

On Fri, 14 Mar 2025 12:15:44 +0100
Michael Klein <michael@fossekall.de> wrote:

> - Factor out RTL8211E extension page access code to
>   rtl8211e_modify_ext_page()/rtl8211e_read_ext_page() and add some
>   related #define:s
> - Group RTL8211E_* and RTL8211F_* #define:s
> - Clean up rtl8211e_config_init()
> 
> Signed-off-by: Michael Klein <michael@fossekall.de>
> ---
[...]
> +static int rtl8211e_read_ext_page(struct phy_device *phydev, u16 ext_page,
> +				  u32 regnum)
> +{
> +	int oldpage, ret = 0;
> +
> +	oldpage = phy_select_page(phydev, RTL8211E_SET_EXT_PAGE);
> +	if (oldpage >= 0) {
> +		ret = __phy_write(phydev, RTL8211E_EXT_PAGE_SELECT, ext_page);
> +		if (!ret)
> +			ret = __phy_read(phydev, regnum);
> +	}
> +
> +	return phy_restore_page(phydev, oldpage, ret);
> +}

You're not using that function at all in this patch, so this patch
compiles with a warning for an unused function.

I suggest you move that to patch 2, which is the first user for 
rtl8211e_read_ext_page()

Thanks,

Maxime

