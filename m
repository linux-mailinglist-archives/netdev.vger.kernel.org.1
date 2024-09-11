Return-Path: <netdev+bounces-127266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A17974CB4
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD2E28251B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C255F14AD2C;
	Wed, 11 Sep 2024 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iBv2c+VQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384B613AA3F;
	Wed, 11 Sep 2024 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043611; cv=none; b=L/jnIpMsXY+dJaGLdCR0ceIh210aQh4c+ZuqpwGdA7oHxB7GXs896aux0+t6o3outP9ei+VNX37oRFSIT9TBa1IzIgx+4vg+nDCnXmmcRAvQYOILWeKHJ5KQAuVlWvbOLxJoarL7XkBU/FcolA0bEQsLdWWovdMT4Dw5+Frk+lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043611; c=relaxed/simple;
	bh=HAvtRwNSym7YcqtN7COsBx/k8Y/hmcmUW0t8Ap+rW4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdLgIMzyqorN/hmHKRYYw0VsKxE4nlo2kbLO/FWWCTqBIlwa3Cwe7ol+VOSOe66tzZ+BVBl3LYUbkJI6rKTLfIfv3tQeqYmn6FqG+n1ehPjGRTJdB7NmV/mCL7SRCXgNE0ZULj35sXvNxyWoRxY3ycvqrOnQydSLMvZBriso9To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iBv2c+VQ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B8E58240003;
	Wed, 11 Sep 2024 08:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726043606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HAvtRwNSym7YcqtN7COsBx/k8Y/hmcmUW0t8Ap+rW4A=;
	b=iBv2c+VQeYPe/RKKmQvC8lrPJt351ifes7zPKwbQpMI2A1RKbCyLWF8zs9IJmrMVMojoG1
	tXmi06amZ91yHevyGoWtjK0rj/ZFBtcTtS4t6fbZ8zb8agghIxtFKhyvC8iDEluxdRaHoM
	w80PHPLilDRPWrDlzebTqMklc/YulXkVXpWnYzZXVykmkM71totldfribq5v0fbjrxoZ93
	ib4gFyY336XgEddQKg6e8HupM4L1iMsa9lrX820YnIQJZ+umSs9kF9hQaXqqmNbisC52mh
	jntPmUYoPdPBhP5tFxm0CkGeToS7//Z37DIPox4LClwzhaMMaKSNlhKHfJyr1g==
Date: Wed, 11 Sep 2024 10:33:22 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
 <atenart@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Dan Carpenter
 <dan.carpenter@linaro.org>, Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next] net: ethtool: phy: Check the req_info.pdn
 field for GET commands
Message-ID: <20240911103322.20b7ff57@fedora.home>
In-Reply-To: <CANn89iKxDzbpMD6qV6YpuNM4Eq9EuUUmrms+7DKpuSUPv8ti-Q@mail.gmail.com>
References: <20240910174636.857352-1-maxime.chevallier@bootlin.com>
	<CANn89iKxDzbpMD6qV6YpuNM4Eq9EuUUmrms+7DKpuSUPv8ti-Q@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Eric,

On Wed, 11 Sep 2024 09:26:23 +0200
Eric Dumazet <edumazet@google.com> wrote:

> On Tue, Sep 10, 2024 at 7:46=E2=80=AFPM Maxime Chevallier
> <maxime.chevallier@bootlin.com> wrote:
> >
> > When processing the netlink GET requests to get PHY info, the req_info.=
pdn
> > pointer is NULL when no PHY matches the requested parameters, such as w=
hen
> > the phy_index is invalid, or there's simply no PHY attached to the
> > interface.
> >
> > Therefore, check the req_info.pdn pointer for NULL instead of
> > dereferencing it.
> >
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Reported-by: Eric Dumazet <edumazet@google.com>
> > Closes: https://lore.kernel.org/netdev/CANn89iKRW0WpGAh1tKqY345D8WkYCPm=
3Y9ym--Si42JZrQAu1g@mail.gmail.com/T/#mfced87d607d18ea32b3b4934dfa18d7b3666=
9285
> > Fixes: 17194be4c8e1 ("net: ethtool: Introduce a command to list PHYs on=
 an interface")
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > --- =20
>=20
> Thanks, there is another issue found by syzbot BTW (one imbalanced netdev=
_put())

Sorry for asking that, but I missed the report from this current patch,
as well as the one you're referring to. I've looked-up the netdev
archive and the syzbot web interface [1] and found no reports for both
issues. I am clearly not looking at the right place, and/or I probably
need to open my eyes a bit more.

Can you point me to the report in question ?

[1] : https://syzkaller.appspot.com/upstream/s/net

>=20
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks for the review,

Maxime


