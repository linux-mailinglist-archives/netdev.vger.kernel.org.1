Return-Path: <netdev+bounces-185138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AB4A98A75
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 15:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7931888C97
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCBA84D34;
	Wed, 23 Apr 2025 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XpdZbQPe"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3D313D2B2;
	Wed, 23 Apr 2025 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745413590; cv=none; b=sdg7bt7EEqv3M/Mx3aq/eRcK3S8wvg5LVX5+6c7QB+HE0RZkHErKF+u8LVjP1EoJDEzSRn2EQSFhesSwvhK+bQsMixCkODGwW+OYrrahRe718aq3RzgC2wAcdawHWMqBlKbV8PthHU1KZ9ZlH95K47IuX/BxPnNMSIjtDpt8nn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745413590; c=relaxed/simple;
	bh=BrhyAB4ReiVrpejcu0KXpfQsiCt5Tj56hdvoK6ZO0X4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jREfc38MR+/8zonw2Jgeg3RxONJV0VUkATujT2Y4hWuKDub20UEyw8E8L3VfDzRj3sWOdFa7WYe+7mK9F56yd/LdsoTzdvmVqonmYYs3eAScEPRCepyiaR1W2pmh1fe9nHU9AJ+bgK3BiSVVOPXUzQdjmL+u+elmGus0SoRFq6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XpdZbQPe; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B96542D43;
	Wed, 23 Apr 2025 13:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745413581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdx4+KCNsL/RbOnsh0AKTMlxt7jQBwIor7Q9H0NjOdQ=;
	b=XpdZbQPeHsBqctCfHtAfTBSipxel27X6oyylrtMCUFgKEADfLXejKcQOzOyemJW6wNoS17
	qzsKc2V66Cd7k7UIp0Gk0sfVz9qftUV4zifQCFoYJ2rLe4bTlRR6t5L2wjc4nTyDA6yoUv
	fvhCEVhWla8k3WZHpp04l6B30K9aHOioCuND94Zkamrs8Q/igACHfSF6md96Ru9dHkuafS
	5s51XWiWUdd8tVLp7bAD6qlK8/G2XGXRrsjVb5FesFGSWCy/vFJtRFY4f59mWh2MYRiMKi
	xOnDgL73ln/C5hmLCEx8lY5ZEhfKm3VrOb6Cirew6QRzXps5/Dr16t9putZG6A==
Date: Wed, 23 Apr 2025 15:06:18 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Russell King
 <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Simon Horman <horms@kernel.org>, Alexis
 =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>
Subject: Re: [PATCH net v2 0/3] net: stmmac: socfpga: 1000BaseX support and
 cleanups
Message-ID: <20250423150618.75ca8a4f@device-40.home>
In-Reply-To: <20250423104646.189648-1-maxime.chevallier@bootlin.com>
References: <20250423104646.189648-1-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeiieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopeguvghvihgtvgdqgedtrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdpr
 hgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

On Wed, 23 Apr 2025 12:46:42 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

Hi,

> Hello everyone,
> 
> This small series sorts-out 1000BaseX support and does a bit of cleanup
> for the Lynx conversion.
> 
> Patch 1 makes sure that we set the right phy_mode when working in
> 1000BaseX mode, so that the internal GMII is configured correctly.
> 
> Patch 2 removes a check for phy_device upon calling fix_mac_speed(). As
> the SGMII adapter may be chained to a Lynx PCS, checking for a
> phy_device to be attached to the netdev before enabling the SGMII
> adapter doesn't make sense, as we won't have a downstream PHY when using
> 1000BaseX.
> 
> Patch 3 cleans an unused field from the PCS conversion.

I mixed-up my command while generating this series, it targets net-next
and not net...

I'll respin tomorrow with the proper destination tree, sorry about that.

Maxime

