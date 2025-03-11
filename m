Return-Path: <netdev+bounces-173973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE78A5CB85
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 18:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2871E16A990
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 17:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921C925F987;
	Tue, 11 Mar 2025 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A9uNa4z2"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B731D1C1F22;
	Tue, 11 Mar 2025 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712670; cv=none; b=dnqE7dAKti87W/fXU6gZQDCGjwVcasqcWZNeGQfXHewDNWAt4+qlZ8dax/E6QgI+9/ZNl3oOWVGBNc+uEb/PsBHIQEDAKIC3eRji2iWECbtGI4ilGAmW1YmF2gsi3rZ3CbQ42Rr0I31dcGCt3WBnie9nkdCfE2hqkNlSOJsC9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712670; c=relaxed/simple;
	bh=bB2I3mJnd9I+qCd6WsvHTfD1BEbi95Tjt4/PZYZdp7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVzu5CuZG4bUoHifaLUcoveAy/zNQSuk+Fets8tp+yNC0F+V3yjk38/Jcu8/18WTHGQpjbAoYVGqD7o86r7uIvzWBfeirbUdW4OchxAnqkMRypeSWpBiCnD/ctf/ejlnnHIylGufp3a9teHF1gMHo24W3aZHwvbmPoJ1SJnMJf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A9uNa4z2; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF583442A3;
	Tue, 11 Mar 2025 17:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741712665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNPRZz6gCCKyyFXFdw9IZIUbcNdOvYF0RyfJNnSYlVs=;
	b=A9uNa4z2UZxS3imKwWuSsDdXmWEQekV4Ngo1wVUip7lm2VyiAXH/i0+CcOawsGlwkN8Pbd
	wBXzxZokMO3Z3dqsbNIZkFSzbcKTmh6DO3lpPggG10IzshXdGJH2z6hEO/I4a8uZZXyoaF
	6XQ5h5HQyqsyX6WCQw+QluCKwbk4YX6WpTab3Jv+9tffi1vBPbxffdAuW5Hm5pcvZOX1q1
	ymzlaA8iEWAZuD400jq9YrkQNv2M+Ip4eQpMvbSVm43O5pWyXsCSUxDZld/JaEUBhKtYqe
	jWQLUyWA3QApg/FRHL+KZANiP76y0E62H7uAmiun5QlB9j9YFEcaLa7Lq/8qHg==
Date: Tue, 11 Mar 2025 18:04:23 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Russell King <rmk+kernel@armlinux.org.uk>,
 Thangaraj Samynathan <Thangaraj.S@microchip.com>, Rengarajan Sundararajan
 <Rengarajan.S@microchip.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v3 4/7] net: usb: lan78xx: Use
 ethtool_op_get_link to reflect current link status
Message-ID: <20250311180423.24232a0c@fedora.home>
In-Reply-To: <20250310115737.784047-5-o.rempel@pengutronix.de>
References: <20250310115737.784047-1-o.rempel@pengutronix.de>
	<20250310115737.784047-5-o.rempel@pengutronix.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrt
 ghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeifohhojhhunhhgrdhhuhhhsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehrmhhkodhkvghrnhgvlhesrghrmhhlihhnuhigrdhorhhgrdhukh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Oleksij,

On Mon, 10 Mar 2025 12:57:34 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Replace the custom lan78xx_get_link implementation with the standard
> ethtool_op_get_link helper, which uses netif_carrier_ok to reflect
> the current link status accurately.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>


Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

