Return-Path: <netdev+bounces-165763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233AEA334D5
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AAB83A6E84
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C4F12D758;
	Thu, 13 Feb 2025 01:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Fx7eib3X"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8EB80034;
	Thu, 13 Feb 2025 01:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739410788; cv=none; b=Z+fAmymjFKwH/bWzprqKNhqVjqhCea+zTj+ZgYehnetruMWAOLYILVxCiACTMuQXb3cPd6B9HYmHgSwZ4toXKGn0/pPWmR4CHMldeW7fPSIKyKZyCizMRggU7f1jBKnqha5ff6QP2NhC9j+ZaIrKVwEGahV+Mp6w899B6vA0msw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739410788; c=relaxed/simple;
	bh=7ynEPinVYg58vFFqJ9Y3/dS+93WPxCWeOZ+W7+imhK8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h/Q0zsvf6/xWop8ggNuZYDDIOLJvLT3DdG3HSIPArzg4NI4h+IwSS05fX1ZPzHWnNAqDZtn+jQde7surH1I90Ven+sGt2pxgzNAtCgdgPJCHOGhdlWYm8GG0U2yN04mCN6DP1agbIRrC8TuqFuWUQrrPNEd7xzZXLpqEdgA4jqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Fx7eib3X; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739410784;
	bh=7ynEPinVYg58vFFqJ9Y3/dS+93WPxCWeOZ+W7+imhK8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Fx7eib3XacDk4lxD4dnjY4m+ta1n7/2Jkt7TtBw5BZw5rUPmpssTEoG+roFoYDPvg
	 YGNwK+sEiNMwEAYVitnFnOjB9YGrbTA+FjTqjwgvZQHBDYWSIlOMnXzcERdzCJqPrm
	 U6H/QITP/jNkLuUV2C+PvrByCdd3hn86fqitcVUfr5K7FWaFe1GYp9YALBK9YStdux
	 iawfA8zq0tMjdDnjZBXoRyE0Ok0eacV8W+C7gLl4A6Bl6Mmsu8gARPYK61XeUBp+0H
	 3x0KZydeJ1OZQKFjDlLj6HWrKuRiAgp25OHG19g1vaHpGRY8a+7QQ82Lw5SDTWHRuU
	 QH0Cu94VW1lYg==
Received: from [192.168.68.112] (203-173-7-184.dyn.iinet.net.au [203.173.7.184])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 662197576E;
	Thu, 13 Feb 2025 09:39:43 +0800 (AWST)
Message-ID: <8e6c7913fda39baa50309886f9f945864301660f.camel@codeconstruct.com.au>
Subject: Re: [PATCH] soc: aspeed: Add NULL pointer check in
 aspeed_lpc_enable_snoop()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: joel@jms.id.au, richardcochran@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 13 Feb 2025 12:09:42 +1030
In-Reply-To: <CALGdzuoeYesmdRBG_QPW_rkFcX7v=0hsDr0iX3u5extEL5qYag@mail.gmail.com>
References: <20250212212556.2667-1-chenyuan0y@gmail.com>
	 <f649fc0f8491ab666b3c10f74e3dc18da6c20f0a.camel@codeconstruct.com.au>
	 <CALGdzuoeYesmdRBG_QPW_rkFcX7v=0hsDr0iX3u5extEL5qYag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-12 at 19:37 -0600, Chenyuan Yang wrote:
> Hi Andrew,
>=20
> Thanks for your prompt reply!
>=20
> On Wed, Feb 12, 2025 at 6:21=E2=80=AFPM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >=20
> > Hi Chenyuan,
> >=20
> > On Wed, 2025-02-12 at 15:25 -0600, Chenyuan Yang wrote:
> > > lpc_snoop->chan[channel].miscdev.name could be NULL, thus,
> > > a pointer check is added to prevent potential NULL pointer
> > > dereference.
> > > This is similar to the fix in commit 3027e7b15b02
> > > ("ice: FiI am cx some null pointer dereference issues in ice_ptp.c").
> > >=20
> > > This issue is found by our static analysis tool.
> > >=20
> > > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> > > ---
> > > =C2=A0drivers/soc/aspeed/aspeed-lpc-snoop.c | 2 ++
> > > =C2=A01 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > > b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > > index 9ab5ba9cf1d6..376b3a910797 100644
> > > --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > > +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > > @@ -200,6 +200,8 @@ static int aspeed_lpc_enable_snoop(struct
> > > aspeed_lpc_snoop *lpc_snoop,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lpc_snoop->chan[channel].m=
iscdev.minor =3D MISC_DYNAMIC_MINOR;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lpc_snoop->chan[channel].m=
iscdev.name =3D
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME,
> > > channel);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!lpc_snoop->chan[channel].m=
iscdev.name)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -ENOMEM;
> >=20
> > This introduces yet another place where the driver leaks resources in
> > an error path (in this case, the channel kfifo). The misc device also
> > gets leaked later on. It would be nice to address those first so that
> > handling this error can take the appropriate cleanup path.
> >=20
> > Andrew
>=20
> It seems that the `aspeed_lpc_enable_snoop()` function originally does
> not have a cleanup path. For example, if `misc_register` fails, the
> function directly returns rc without performing any cleanup.
> Similarly, when the `channel` has its default value, the function
> simply returns -EINVAL.
>=20
> Given this, I am wondering whether it would be a good idea to
> introduce a cleanup path. If so, should we ensure cleanup for all
> possible exit points?

Yes please!

Thanks,

Andrew


