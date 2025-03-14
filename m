Return-Path: <netdev+bounces-174938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3163CA61779
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 18:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B26189780F
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 17:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AF920409D;
	Fri, 14 Mar 2025 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IehLKEgP"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139C1202C55;
	Fri, 14 Mar 2025 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973035; cv=none; b=OJfY8Bye/IjPXWnmEx1/YgDHrbN5G4tL70DIkOPrwTD7o4i9qTpaaRJs4uR2aonpbQpSEk9taGS0C2RkLGJE9J4FT6hw0b4Sy4NFmD0ng6lCV9VssQLhcfAPsp7I5VUOiADdT7frBETol6oVkVYFswhV9RxW00VFJ0L8peBYQ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973035; c=relaxed/simple;
	bh=c0RX0AaARKJLEtEO4yes04DrfYApXHGs9mq3oWu46O8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/Uq6xALTthluUZqukLX5yyO4l9kM8DpfC3Yx/McvnAcODA3Joe8Rv8IEmyzcoJo4+39Yb6zTa8E6cUW4vM24aQNvzFf6SHFcDR2XNHPZvpsgBvVeAbgWGaPdzoD2V30gj6CR4GaBHbxrB/2uIIIltzoIkZahQn+Qj1mbHyKy90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IehLKEgP; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21ECF2047D;
	Fri, 14 Mar 2025 17:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741973031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BamU1n5OM23qSRXD+9aLXMCCgUdpw3Az64GLE9soEkA=;
	b=IehLKEgPhGSJ16XfZtEE+102UTYiBW7EDn6ybxNmUi40s2+n7O2SmGMp8Mtlb7WAsoAkqr
	WbcwYfc8VnwTQcJR/aP0yB9YzylW/bKfSZBcapxueDH/aNaLb5y6PZkS648rZ+5binHowo
	ZibggDs2iOA6OdvGDl3pYd7Pt0SqL2KrQ+qEldy38UBhaPwMgk/tAa/YZckVEQpR0YCsm0
	MWMiVNMw6P7EEVXuGh7fxgdpyGqL97BjQyDUHCEZmq6gfae321ob6vPqA46lk/C+JD4Rlt
	S1cWZwTieVPjmmsVPMRASYMtAAcqII1cE1hXd4puC2wqbjD9nvN8lY3uj346Gw==
Date: Fri, 14 Mar 2025 18:23:48 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux
 <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, David Miller
 <davem@davemloft.net>, Xu Liang <lxu@maxlinear.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH net-next 0/4] net: phy: remove calls to
 devm_hwmon_sanitize_name
Message-ID: <20250314182348.21ac024e@fedora-2.home>
In-Reply-To: <198f3cd0-6c39-4783-afe7-95576a4b8539@gmail.com>
References: <198f3cd0-6c39-4783-afe7-95576a4b8539@gmail.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedugedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmegrjeekieemfhgvfhemkegtleelmehfgedvvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmegrjeekieemfhgvfhemkegtleelmehfgedvvgdphhgvlhhopehfvgguohhrrgdqvddrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtp
 hhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehlgihusehmrgiglhhinhgvrghrrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Heiner,

On Thu, 13 Mar 2025 20:43:44 +0100
Heiner Kallweit <hkallweit1@gmail.com> wrote:

> Since c909e68f8127 ("hwmon: (core) Use device name as a fallback in
> devm_hwmon_device_register_with_info") we can simply provide NULL
> as name argument.
> 
> Heiner Kallweit (4):
>   net: phy: realtek: remove call to devm_hwmon_sanitize_name
>   net: phy: tja11xx: remove call to devm_hwmon_sanitize_name
>   net: phy: mxl-gpy: remove call to devm_hwmon_sanitize_name
>   net: phy: marvell-88q2xxx: remove call to devm_hwmon_sanitize_name
> 
>  drivers/net/phy/marvell-88q2xxx.c       |  8 +-------
>  drivers/net/phy/mxl-gpy.c               |  8 +-------
>  drivers/net/phy/nxp-tja11xx.c           | 19 +++++--------------
>  drivers/net/phy/realtek/realtek_hwmon.c |  7 +------
>  4 files changed, 8 insertions(+), 34 deletions(-)
> 

With more coffee in my system, I took a better look and it indeed looks
good to me.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Sorry about the noisy comments,

Maxime

