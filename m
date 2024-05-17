Return-Path: <netdev+bounces-96951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3879B8C8667
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 14:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10491F231C2
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 12:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E7E4E1C9;
	Fri, 17 May 2024 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dHrd91Co"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4B44C3CD;
	Fri, 17 May 2024 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715949785; cv=none; b=o3EKdyCLjEFUxbFo8YvrzO6ClKqxi0zk6rW9Exd++RdzOmao9zQjEL5USCBNfIqZTTFIJPbZRVZj2aWG0Lfm5idMIGtucFyHZe73d8tPgThGiQEBbOd8fzTvOqoFQKGkdrWaje0Y40/9WGqkSnc+wq/5z4V12PM7vw/2jZhwmtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715949785; c=relaxed/simple;
	bh=jWKS8SQRbxP0tmQVIN/JQX/lXypAS4uBKg5yMHEVHe4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWCeveopuWHuuSmdl/741PFbcJFAIXQfcf90WzHSLnp3p0DpddgtXiTjv9TgQpw5XJ+pMHrW0GwZ5qKobBXqsm0KhlpapJ0Zw55E6UQ8sZ7+IQmO62dWm3OKxXg/ufWA6N0JAHoHsDvmIvCCJMM9sImPQunB90vsHSWsvWJ0jkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dHrd91Co; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A8D040002;
	Fri, 17 May 2024 12:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715949775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RmW1cK6oM09eKbpoTnioOWGwx029l+Mpd2nYIacz5po=;
	b=dHrd91Cogk3W7X4CCdWnm6hSLM4jmHr6O7XOahUGRdzmmrtrwMMAt1x642UVE+ZZc3drF3
	vsCJnFeOoEvZP7jxuk5nAWcCXONLXVlKeLqElRKQ8DQpmJLaQ99wgPyYDUg8E1rVshoDLK
	C9WFm9L5X3M08RLgYRHbb5Rl+GlI1JK3bGXegqa/5y+AiuA2PlSdziA26vIjF4QEOX7XhQ
	4UqEeJ4D2qBng4BE1QnLQ+TMRl5R2x2ulK+KIi1UjV3+VLJYc9pyJdlPYRF35/ABjXdU0+
	o6JNn07uZTgLx4IOYLbTJy4mliU4HLUfDSA/R+0gpk2sGDVhh6XFwt5uvuC2Kg==
Date: Fri, 17 May 2024 14:42:54 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>
Subject: Re: [PATCH ethtool-next 0/2] Add support for Power over Ethernet
Message-ID: <20240517144254.2aaf949e@kmaincent-XPS-13-7390>
In-Reply-To: <4asgo5rtu4daknofzmyyk7x47adcyfpdej2pbbv2vdaxnjf6yn@thkh274ismmb>
References: <20240423-feature_poe-v1-0-9e12136a8674@bootlin.com>
	<20240517142803.6c28b699@kmaincent-XPS-13-7390>
	<4asgo5rtu4daknofzmyyk7x47adcyfpdej2pbbv2vdaxnjf6yn@thkh274ismmb>
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

On Fri, 17 May 2024 14:38:54 +0200
Michal Kubecek <mkubecek@suse.cz> wrote:

> On Fri, May 17, 2024 at 02:28:03PM +0200, Kory Maincent wrote:
> > On Tue, 23 Apr 2024 11:05:40 +0200
> > Kory Maincent <kory.maincent@bootlin.com> wrote:
> >  =20
> > > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> > >=20
> > > Expand the PSE support with Power over Ethernet (clause 33) alongside
> > > the already existing PoDL support. =20
> >=20
> > Hello,
> >=20
> > Any news on this patch series?
> > Would someone have the time to take a look at it? =20
>=20
> I should be able to get to it this weekend.

Ok great, thanks!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

