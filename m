Return-Path: <netdev+bounces-185137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E24A98A46
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 15:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0F5444059
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8AE57C9F;
	Wed, 23 Apr 2025 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cdEUE4gx"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A692FBA50;
	Wed, 23 Apr 2025 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745413365; cv=none; b=KoLmlo49X39e3BJTRaYZVqZz3b9LmduNOKzDG6PTAGmeqUHC0xP0wdLzWUzDxMUs9eeSf7ou1ICkqNNjbUc2bcl3DEj+h9+L3KrQ6fonvjcjiKUMJa2MGxPPV9256/uLnByfeI4yZbGOggM2dF2ZMch1Jgoj9/afApWJSTfRF7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745413365; c=relaxed/simple;
	bh=B8bMV3NwRcE1hzN4J3o3cRGIKHoOIzyacT+46rTZMrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWqiPNrCqeKIEkI2TFfnC+fOw9qDuxiHbPNxhExi8QIBBogAeNHwXn3+B9UqFuPIyJqiOghFKfC0jdXRUJ5LX+Gl1xWzDD4mrmCPPX/IwV7z1UW7xU12H97wY4g2eUanbNE7HNzgVfFMlWyussF2osAGJ4mTeu28eH6a/m3Dm50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cdEUE4gx; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 056361FCE9;
	Wed, 23 Apr 2025 13:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745413355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8bMV3NwRcE1hzN4J3o3cRGIKHoOIzyacT+46rTZMrQ=;
	b=cdEUE4gxp1nKhx3LhaZV5bNGMQw2LTagDxZwhXwlyigGUjuYZ+CzjtrJjdGn3hfT0V0ekp
	L8pkeZKfiq1FS6//Jkt1UHLiFNZgmgDt/rJlKerX8KSTuXE7qLXq18Xo0pqM45dbcJMYYV
	Xwo2xKsZ6a64WDQKgKtDQD++Ae/NvoehAJ0IGzbz0No1wMzV50MEOTerP1hfZKf6iCKOVH
	EmJA3gHWC2LIZNKBG8l9yD2xTfTv8IOlvo0AzRdvEy1hoHd6uD/NVORXp3VbvzEZPQqGLr
	DgRDWQIW6KN8j5wbv1vtIBA5ZAk9UaMPQbPKkJV8taEUFn5zp0KT/6LjgroO5g==
Date: Wed, 23 Apr 2025 15:02:33 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexis =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Richard Cochran <richardcochran@gmail.com>,
 Daniel Machon <daniel.machon@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH net v2 2/2] net: stmmac: fix multiplication overflow
 when reading timestamp
Message-ID: <20250423150233.38fb5437@device-40.home>
In-Reply-To: <20250423-stmmac_ts-v2-2-e2cf2bbd61b1@bootlin.com>
References: <20250423-stmmac_ts-v2-0-e2cf2bbd61b1@bootlin.com>
	<20250423-stmmac_ts-v2-2-e2cf2bbd61b1@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeiieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepuefhfefggfdthffghfdvhffhhfetuedtkeetgffhteevheehjeejgfduieduhedunecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopeguvghvihgtvgdqgedtrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrv
 hgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgtohhquhgvlhhinhdrshhtmhefvdesghhmrghilhdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdhtohhrghhuvgesfhhoshhsrdhsthdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Wed, 23 Apr 2025 09:12:10 +0200
Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> wrote:

> The current way of reading a timestamp snapshot in stmmac can lead to
> integer overflow, as the computation is done on 32 bits. The issue has
> been observed on a dwmac-socfpga platform returning chaotic timestamp
> values due to this overflow. The corresponding multiplication is done
> with a MUL instruction, which returns 32 bit values. Explicitly casting
> the value to 64 bits replaced the MUL with a UMLAL, which computes and
> returns the result on 64 bits, and so returns correctly the timestamps.
>=20
> Prevent this overflow by explicitly casting the intermediate value to
> u64 to make sure that the whole computation is made on u64. While at it,
> apply the same cast on the other dwmac variant (GMAC4) method for
> snapshot retrieval.
>=20
> Fixes: 477c3e1f6363 ("net: stmmac: Introduce dwmac1000 timestamping opera=
tions")
> Signed-off-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

