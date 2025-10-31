Return-Path: <netdev+bounces-234722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BDFC266B3
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 18:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2B118880A5
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30C72690EC;
	Fri, 31 Oct 2025 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iGAYTjAS"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9CC283C9D
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932521; cv=none; b=k9AuQ/9vM83ULwlmIh1oGsu9i37Lxcs388uwsN3Kadr0HlzH1vlAIPwCHZjESFViIF98rKHEWVQogt2eQ/jfPULIndRKn/7HihoIllotiwBlXR13VNGdwt9MmkF2zlNlcfYiesfv/CTXzTQT8j0+BNNv90/XaiBkKPoHjd/oOIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932521; c=relaxed/simple;
	bh=tT4v4FkMCSqc8eIjKGkwR/LzsSL+UJ+pvOmTnRK1rzo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2PrHRd/ksiU7OHD2WJh9VSx/leUhW2wXgPvHzX2sN01L8UjXWQFpQlY6JyGh6jVIlPrAwUOy/NB6zrgDkMdZujvK1vji5FA7cMUQdsJYm0C0RY9dbPdQmAWUIpLfgGA0duRFnjptXfUtxxpl1RLE4ECxO31IJCusROf890wQBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iGAYTjAS; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 97EAB4E41442;
	Fri, 31 Oct 2025 17:41:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 450B260704;
	Fri, 31 Oct 2025 17:41:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B0F1811818007;
	Fri, 31 Oct 2025 18:41:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761932515; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tT4v4FkMCSqc8eIjKGkwR/LzsSL+UJ+pvOmTnRK1rzo=;
	b=iGAYTjASZ6Bzyqi89mDzhDwqlw52gD0eSh7eI1MPz0n+KP8IOzsuftv1EPHRorb4yUQo8/
	NdXDk9TJ0KBKvau0AEbTz7gTd4swB6JXJtm4r3qHcA2UAMJYj37msJuOiFkCmDvitKPIck
	vrID7tm0SLwMo/+Z71rRdVWNugYamW/D4EYlC93JwBw23+84M96R0PMGzohN4tZsQrNJso
	EkC4quSXFd3Ns9BhgGAMjg0Y1zm/3G31kQDQEAOIxR9/r42vzdfo9WGJifjqO6bhQ338mn
	iAv/kMlFPrnvczaO3VFeEuGrqFp2MoZrgdRh1NQ59jMCR+T1LDwUh3ZZQXlzNQ==
Date: Fri, 31 Oct 2025 18:41:48 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, Marco Crivellari <marco.crivellari@suse.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Sunil Goutham <sgoutham@marvell.com>, Richard
 Cochran <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] convert drivers to use ndo_hwtstamp
 callbacks part 3
Message-ID: <20251031184148.1417ac8a@kmaincent-XPS-13-7390>
In-Reply-To: <20251031181027.1313b51d@kmaincent-XPS-13-7390>
References: <20251031004607.1983544-1-vadim.fedorenko@linux.dev>
	<20251031181027.1313b51d@kmaincent-XPS-13-7390>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 31 Oct 2025 18:10:27 +0100
Kory Maincent <kory.maincent@bootlin.com> wrote:

> On Fri, 31 Oct 2025 00:46:00 +0000
> Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:
>=20
> > This patchset converts the rest of ethernet drivers to use ndo callbacks
> > instead ioctl to configure and report time stamping. The drivers in part
> > 3 originally implemented only SIOCSHWTSTAMP command, but converted to
> > also provide configuration back to users. =20
>=20
> For these 3 patches, maybe it is better to split them in two to separate =
the
> NDO conversion from the hwtstamp_get support. I will let Jakub with the f=
inal
> word on this.

After a review, I found out that the patches are quite straightforward, so =
it
is ok to not split them.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

