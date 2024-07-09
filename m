Return-Path: <netdev+bounces-110152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D32D92B1F0
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2E11C219B5
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775D913B2A2;
	Tue,  9 Jul 2024 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y48QhxU8"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67431487C5;
	Tue,  9 Jul 2024 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513109; cv=none; b=m70DF70JpOSHi8kSLslfHK9jMOrKcPjs6418cHOiwnoXItnCD9gAva2gjlusGg7507CSh+sIe5R6aRaSIJUJovPgfusyGuaLAZzmJTesF0Gant9+fY702PS1XC/FPCi1+njuq/TgUxUxlQ5Mib/dgBfJx9MgNugV/6tTAGaAxiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513109; c=relaxed/simple;
	bh=g6wffX0jQVpxanjymkqV2YgRffLk23pn0cJcQ4v9Qsk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnqTJ/z8QXCSQjlv4EXNYkZJGq1fg2goh1w2Mo1nCX0r/B5FkimhkQrzwi+ya3D7IkcJoQJr8tndTQEJ0FOAoYRRORuHPbdxy0tVMBUI+56rq5uy2/w/iWo65uCkmRnLryHFP8WxcocpfnfDCgOiqc2rAHubkdkGYGGk4YuQ1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y48QhxU8; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D8844E0006;
	Tue,  9 Jul 2024 08:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720513099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=guBIG0yXjLQF/KGNGw9TE40/iUTMcO24dv9vfa9naio=;
	b=Y48QhxU8LcqREPrmzfduRlZKoQ4PjfsJza17r49pwbtt5814DF043QS6TUdqB9k9LeV8L4
	sBPhseCqHXXQqVH+4SSN9Bal8Omu6muNG2m6JlpkUZ7QVC469QQdeGsuqPA8n0NWouwimp
	0UL+UxcyBY7DjxrLKtBPJm9xHqn+Q69x0eyBN+c8AQfU6zflixPTxv0nbIZuzq5pgBpJjY
	4NEtXlXkmnRp+ywdqHPVJH0lvUqVsFvbY78Y2WThiH4TZ2+iEm3cSfC6gOoIIGeZyuezCV
	4xiM+tb69TJOK8LKVAwDYT25lQ2QIG1cpEh78QfLx4urBVdVBp3nfwq0PXIxnw==
Date: Tue, 9 Jul 2024 10:18:15 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v16 13/14] net: ethtool: Add support for
 tsconfig command to get/set hwtstamp config
Message-ID: <20240709101815.474eec3b@kmaincent-XPS-13-7390>
In-Reply-To: <20240708134409.0418e44a@kernel.org>
References: <20240705-feature_ptp_netnext-v16-0-5d7153914052@bootlin.com>
	<20240705-feature_ptp_netnext-v16-13-5d7153914052@bootlin.com>
	<20240707082408.GF1481495@kernel.org>
	<20240707145523.37fdfeec@kmaincent-XPS-13-7390>
	<20240708134409.0418e44a@kernel.org>
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

On Mon, 8 Jul 2024 13:44:09 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Sun, 7 Jul 2024 14:55:23 +0200 Kory Maincent wrote:
>  [...] =20
>  [...] =20
>=20
> Looks like there's also a new driver to fix :(

Oh indeed sorry.
I have to check if new MAC drivers appear between each version.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

