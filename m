Return-Path: <netdev+bounces-183617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 937DEA914BB
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5AE13BD6D5
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 07:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FD82147FB;
	Thu, 17 Apr 2025 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I0wonYQ7"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2B41E4929
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744873629; cv=none; b=gkMBWhd0iu5RRJgH01SbyPJubX8gbHBEIpcZIae4gZ9ir1gQh1k/2UveMB+UqerS0oTvY8+u1if3rUh5Z1RVGziJmBDFpgeM+MIIPSWLggeSKyZ3+WVgnUBWdkyjaw9KTT/8aoa/1q7Hexk43mg9sFKlX4zRT67p0BGYFrhk0IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744873629; c=relaxed/simple;
	bh=FxfwIu5DSi3yzL/mpYSir0Fpi1TRCtvBUHh41QPZG3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTDnhX83CU3fOctGjeujRcLVyxY4qV7u6viXXPA60AFi7fBf8zitbSnyz167AxXd/Vhcw8BYhtflocsH8HMKYNPP5ZqJE3NS0ZNPRsBKwvjasTN8Cx/OfR0X6HaFoLZDWI1O+ofb0gWoq4YxPiRPseukqEK5G8dBnHPaZiLX0Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I0wonYQ7; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C5D4F433E8;
	Thu, 17 Apr 2025 07:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744873624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9op7YirHLkYKuvWHCsUiXLkJqZVL7NYOxYqcuFlBE14=;
	b=I0wonYQ7hOtf9TJg2KPSRWzmlFbZQFWUfG5Za382IKrackYqZK0mQjkP4U6HPh9r1+nCai
	5B4rocPUZocmYx+XblEjMX1DQwtSoLWbYDDcgsQDCowT2XZ7IZzATSacaBW7WEHGyI/Gdl
	07J00IStEEStDrh7B08631X8UoMKgfe3VzJEUE7tdOE4UJ5Tt7087EPFWZmD/vRXEGB9J5
	GxUj2vwGv3r6i4ctxZlAwVfP5ec2+OJCfkEJRy4DZvyioO6IsvPDgfUfI6kJMrI+PPgJBi
	0gtXZC7RGJx/rLTfAe2HcbxgIXAqPhNmHlmKKEZl6iRjKOVG5/PmRQty/49Dxw==
Date: Thu, 17 Apr 2025 09:07:02 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: phylink: mac_link_(up|down)() clarifications
Message-ID: <20250417090702.16d78e0f@fedora.home>
In-Reply-To: <E1u5Ah5-001GO1-7E@rmk-PC.armlinux.org.uk>
References: <E1u5Ah5-001GO1-7E@rmk-PC.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdekiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopehrmhhkodhkvghrnhgvlhesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghom
 hdprhgtphhtthhopegrlhgvgigrnhguvghrrdguuhihtghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Russell,

On Wed, 16 Apr 2025 22:53:19 +0100
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> As a result of an email from the fbnic author, I reviewed the phylink
> documentation, and I have decided to clarify the wording in the
> mac_link_(up|down)() kernel documentation as this was written from the
> point of view of mvneta/mvpp2 and is misleading.
> 
> The documentation talks about forcing the link - indeed, this is what
> is done in the mvneta and mvpp2 drivers but not at the physical layer
> but the MACs idea, which has the effect of only allowing or stopping
> packet flow at the MAC. This "link" needs to be controlled when using
> a PHY or fixed link to start or stop packet flow at the MAC. However,
> as the MAC and PCS are tightly integrated, if the MACs idea of the
> link is forced down, it has the side effect that there is no way to
> determine that the media link has come up - in this mode, the MAC must
> be allowed to follow its built-in PCS so we can read the link state.
> 
> Frame the documentation in more generic terms, to avoid the thought
> that the physical media link to the partner needs in some way to be
> forced up or down with these calls; it does not. If that were to be
> done, it would be a self-fulfilling prophecy - e.g. if the media link
> goes down, then mac_link_down() will be called, and if the media link
> is then placed into a forced down state, there is no possibility
> that the media link will ever come up again - clearly this is a wrong
> interpretation.
> 
> These methods are notifications to the MAC about what has happened to
> the media link state - either from the PHY, or a PCS, or whatever
> mechanism fixed-link is using. Thus, reword them to get away from
> talking about changing link state to avoid confusion with media link
> state.
> 
> This is not a change of any requirements of these methods.
> 
> Also, remove the obsolete references to EEE for these methods, we now
> have the LPI functions for configuring the EEE parameters which
> renders this redundant, and also makes the passing of "phy" to the
> mac_link_up() function obsolete.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks for that,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

