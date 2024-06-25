Return-Path: <netdev+bounces-106428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 761DB9163D8
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 11:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328E828C3B1
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174D6149E0A;
	Tue, 25 Jun 2024 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OUpMHRfN"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7283F1494DE
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309064; cv=none; b=PhlY773xakNU3ubzPn7/OWk5gORwuN0w8VR6FdEaVqy4/4TQ/cSEwHMGd4Zk2hx22geUnXuEsBzIpKEspIhkjm6JG2QwZ2zhHfsaTXgg+302dQnrcIvGRT+RKHARU8YdPbn9fnQnr3Fur/9nbxL01VdNcLRlZMu+kwl/InuDisg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309064; c=relaxed/simple;
	bh=v26cHPRxU3qBhPDOpIAhaujLP4FvP96BZu1GEQS4JXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ly78YamOBKVHBrfVTkXFtOBF2ym+c2kjgeHpYU9Yi3Yl3BEytlMcW8u5z3oYYuoF7gt0OF1IjLbPCOCFdxXWemxuAAsdMZXlmiaMM85+xn58Wd/rscZ85m+/E2yrL27Kla3z/yDc6P8Cs0GVEOedQY9PKPJZby+u0YieqQ2R64U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OUpMHRfN; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 95F8B40011;
	Tue, 25 Jun 2024 09:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719309059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v26cHPRxU3qBhPDOpIAhaujLP4FvP96BZu1GEQS4JXU=;
	b=OUpMHRfNQ1fI9K8Gk/ZqEvi57rbgsyjk7M3Ed0wkm7Li++kz8ChDAYRvhu5PNodMUYkC0K
	pRtShVhcApkhh5WDfrmEvV/GNBprprxKMGsQA3mXrPu5lMcz4ZAURUM0RHC9fiTc+rFTYl
	sHJs2tpWxZRnMtWTY9Rc4avvfODbxyC1yhMu+afejzapOG2EMsb7eDTSQH1fn986/+iGr2
	OKD3wC0h4KDwk9WboYw2wOxfCJuNmj7QmSt+E2k+qIoIXfyAq3v3NspbmC0ikCDz8+gIY2
	MhAVB4mfbsEf7H7jqVNWmkmMjqB4929SPxXiaeWVRyJOA/TaeTKm4ftmeUaP5g==
Date: Tue, 25 Jun 2024 11:50:56 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, Woojung Huh
 <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, George
 McCollister <george.mccollister@gmail.com>, Ido Schimmel
 <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Jeremy Kerr
 <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>,
 Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
Message-ID: <20240625115056.2df47afe@kmaincent-XPS-13-7390>
In-Reply-To: <20240625083853.2205977-2-u.kleine-koenig@baylibre.com>
References: <20240625083853.2205977-2-u.kleine-koenig@baylibre.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 25 Jun 2024 10:38:53 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
>=20
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
>=20
> While add it, also remove commas after the sentinel entries.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

For PSE drivers:
Reviewed-by: Kory Maincent <Kory.maincent@bootlin.com>

---
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

