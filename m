Return-Path: <netdev+bounces-193644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3856AC4EF9
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 14:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5AB07A7F26
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 12:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EBA269B07;
	Tue, 27 May 2025 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ULy72exI"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2746C2ED;
	Tue, 27 May 2025 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748350632; cv=none; b=pe4mVzNtWxLAZ/pnI8L1nIlw50Xi0pwcv1GH+xbv8Bm1iz20fgJHoV5vT6ZC70jvVmBBEGoF5lXlDkW9254gmfc6l5Upu44I0QGgIGOtiIuSYPOUMyIZCzJWCG374dWQpzqeHbdGI/Tg8mFe5L2nOyAQKDJEfVD91svBfKe2yX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748350632; c=relaxed/simple;
	bh=KII48wrXl0ZMdmvqtDTuh7V74BabxwisoGBzB4sRG48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gt3pdGQlOrqdIlrXpDQYu+32P0phOMe6qLVr1dt+zgISy6btW+YvajDX+D1tKei6yCSWbte4RxLpCI2vI29iAs6DAdtIA6X2ATlVfBA0tpulYumXT3HakaxeGHk1F/X6EGdD11wXJ/bH/QdB6HdpAedQ11DleIDaXs4vousWbZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ULy72exI; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6397F43A20;
	Tue, 27 May 2025 12:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748350622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvZ9huD4LI30UeuMWHiYyzRnbuqvMT4vG4k0kQwsXFI=;
	b=ULy72exI63Ba8S3IBJFigMySEMXjDhoJa+JGvaoBwixoogOybnutxBk7+8Ir8p1I6jCmAx
	FxsRP/8Uqr/Z/hjjZVQhPOQql9Jm8nmAmpE+thknL9UO7AFiQRMr27rElXR/3RLkEoGsEN
	EOkz/6+XDsaCtBBqTLJtL1pcuVr3de3J1guRgB1H9njfx2JMi4NYzN3MYmdvGpuRydKpsk
	l/lMXKaFUeXKIj3808pLVWRm/VB2RtIfVsWrMZpWvLZkHdXhVYS6zWqGz4nmpE665y5Ruz
	Q5o2VhIHbOeM0TEfJsi9lKL1zGropxcmMXaWO9XL+beEI0e/EErh3sYX+TdO3g==
Date: Tue, 27 May 2025 14:56:59 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Quentin Schulz <foss+kernel@0leil.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jakob Unterwurzacher
 <jakob.unterwurzacher@cherry.de>, Heiko Stuebner <heiko@sntech.de>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Quentin
 Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH net v2] net: stmmac: platform: guarantee uniqueness of
 bus_id
Message-ID: <20250527145659.00bd10ae@device-24.home>
In-Reply-To: <20250527-stmmac-mdio-bus_id-v2-1-a5ca78454e3c@cherry.de>
References: <20250527-stmmac-mdio-bus_id-v2-1-a5ca78454e3c@cherry.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdeggeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemhedvrgefmeejsgeludemudehtgelmegtledtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeehvdgrfeemjegsledumeduhegtleemtgeltdeipdhhvghlohepuggvvhhitggvqddvgedrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohepfhhoshhsodhkvghrnhgvlhestdhlvghilhdrnhgvthdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrv
 hgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgtohhquhgvlhhinhdrshhtmhefvdesghhmrghilhdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdhtohhrghhuvgesfhhoshhsrdhsthdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Quentin,

On Tue, 27 May 2025 13:56:23 +0200
Quentin Schulz <foss+kernel@0leil.net> wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> bus_id is currently derived from the ethernetX alias. If one is missing
> for the device, 0 is used. If ethernet0 points to another stmmac device
> or if there are 2+ stmmac devices without an ethernet alias, then bus_id
> will be 0 for all of those.
> 
> This is an issue because the bus_id is used to generate the mdio bus id
> (new_bus->id in drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> stmmac_mdio_register) and this needs to be unique.
> 
> This allows to avoid needing to define ethernet aliases for devices with
> multiple stmmac controllers (such as the Rockchip RK3588) for multiple
> stmmac devices to probe properly.
> 
> Obviously, the bus_id isn't guaranteed to be stable across reboots if no
> alias is set for the device but that is easily fixed by simply adding an
> alias if this is desired.
> 
> Fixes: 25c83b5c2e82 ("dt:net:stmmac: Add support to dwmac version 3.610 and 3.710")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

This looks correct, thanks !

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

