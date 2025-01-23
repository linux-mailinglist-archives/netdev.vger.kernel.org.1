Return-Path: <netdev+bounces-160573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101D0A1A569
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 15:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D0B188A08A
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 14:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10FA20F062;
	Thu, 23 Jan 2025 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DFL7F7/9"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2828C07;
	Thu, 23 Jan 2025 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737641152; cv=none; b=hYcb4mcYVo2Rv/dkBtDm+QE/4zsOFmZvmIuTKNrsNkvwoczcYcMojPNuxJHhXf/APpmiQws7f4WTZ6R12Pe+i1EtKcckeakPtWRw/qXe+d902uigTGwfI66ToxDwAe6Zo6AKuspqhJW6HEwOHrRHyH0sv432JFdxgO9XLKO2KB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737641152; c=relaxed/simple;
	bh=60hukXhQPinTRn0DpPyfDNfHKxCUrLEWoJLDVwIwAaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0aCzYK4gSrmTfBa6TncZHB3Tqy0hYZ7kr2Ur0RCfYxjftxY/F73dhuKJH73MhR7mMu67fcVRaGKDk8xXl+TjFuqZ1NyzFxIXEd7X962gJAbCeUMCg8G7i3nZZJLjl5T7Jlpio29BVVxxLXmFgchKyXh5CQa2jShv75rrIYnUDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DFL7F7/9; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED25F1BF205;
	Thu, 23 Jan 2025 14:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737641141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60hukXhQPinTRn0DpPyfDNfHKxCUrLEWoJLDVwIwAaA=;
	b=DFL7F7/9nz48TWUV0Ira9WtcMhAIRlLM493wPx1K6QX0jqDdMSrz5q5E4dtp/qOLNO6ycN
	epdkaWF3wTHYPulqCHiHkavMwxW6YgiK+FncOf+rs7PAi3aatmY0pPGccOiC7L3NE2RERG
	JaqbOy9VaFf/7jZEqfEfcEaqnt06u640IpUvB1HV74UMQXGpwjqp7hS/BU13bhg1wcfiI9
	/+eyt9j6VaCLTstINL7YMIEAbovQw9k3s3A2zyHo9NTCeeGiNTEAmsWmW+8utH/23t5GPv
	sNScmdiTLXS0+rMgU3D5dGlSDIzWOiOhRVW2KSAx6ouwuPDqR2jvrx+kJM+3tQ==
Date: Thu, 23 Jan 2025 15:05:37 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, thomas.petazzoni@bootlin.com, Andrew
 Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?=
 <niklas.soderlund@ragnatech.se>, Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH net-next v3] net: phy: Fix suspicious rcu_dereference
 usage
Message-ID: <20250123150537.5288d894@kmaincent-XPS-13-7390>
In-Reply-To: <49d39ae2-fbe1-4054-bb78-7e0c54626a23@tuxon.dev>
References: <20250120141926.1290763-1-kory.maincent@bootlin.com>
	<20250120111228.6bd61673@kernel.org>
	<20250121103845.6e135477@kmaincent-XPS-13-7390>
	<134f69de-64f9-4d36-94ff-22b93cb32f2e@bp.renesas.com>
	<20250121140124.259e36e0@kmaincent-XPS-13-7390>
	<d512e107-68ac-4594-a7cb-8c26be4b3280@bp.renesas.com>
	<20250121171156.790df4ba@kmaincent-XPS-13-7390>
	<49d39ae2-fbe1-4054-bb78-7e0c54626a23@tuxon.dev>
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

On Thu, 23 Jan 2025 13:25:57 +0200
Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:

> >> ravb_ptp_stop() modifies a couple of device registers and calls
> >> ptp_clock_unregister(). I don't see anything to suggest that this
> >> requires the rtnl lock to be held, unless I am missing something. =20
> >=20
> > What happens if two ptp_clock_unregister() with the same ptp_clock poin=
ter
> > are called simultaneously? From ravb_suspend and ravb_set_ringparam for
> > example. It may cause some errors. =20
>=20
> Can this happen? I see ethtool_ops::set_ringparam() references only in
> ethtool or ioctl files:
>=20
> net/ethtool/ioctl.c:2066
> net/ethtool/ioctl.c:2081
> net/ethtool/rings.c:212
> net/ethtool/rings.c:304
>=20
> At the time the suspend/resume APIs are called the user space threads are
> frozen.

Maybe, I don't know the suspend path, and what the state of user space thre=
ads
at that time. This was an example but Wake on Lan setup could also have some
issue. IMHO I think it is more precautions to have it under rtnl lock.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

