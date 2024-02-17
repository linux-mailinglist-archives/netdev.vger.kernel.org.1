Return-Path: <netdev+bounces-72590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323CC858BC3
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 01:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51491F2136E
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 00:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC4F17722;
	Sat, 17 Feb 2024 00:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="A3zfP+Dd"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6902149DEF
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708128717; cv=none; b=X7AmcnS69TmtuU6Hf9wKZxhoreRycwR399MZLDQQ1zoR3V/A7JzK1uAEoTjXjAHWZ8UUGUamrIsAsvFIiOrR+RL46RSwUHbYFZVX8Qjqyr9fvuUkyK5fxhvwUyjWaP4S8KTP5rEgu71fqINKMDx1garGhUEZbdXZ+EkGAce1GPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708128717; c=relaxed/simple;
	bh=INVAINQPPzGPh0As1CgntyCxtp3AWHiwOlqVdovjx1g=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K9TPuy+keUmq1du5d9iWnQJnac0Lu214hE0YG6n+o1AxDE/hDL0A1IZWUfapYzvW5y6YSqi/y+bgp/G4vtl2ISCAdO8jnQPE1cy5bWN6dM+EjSil2khA3Z7N2tYNFgoUltJaSyCPgNzFooeXSXg8ZvHfkM5EgYxtCzTn3pIKNRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=A3zfP+Dd; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7573C20075;
	Sat, 17 Feb 2024 08:11:52 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708128712;
	bh=INVAINQPPzGPh0As1CgntyCxtp3AWHiwOlqVdovjx1g=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=A3zfP+DdoAZ5LsW75DaCLB6Vy8xuU8IxfpkhzrbhQS+e7oM85h9eXHkygSPQ1XKo2
	 2KjAfGyLdnTjJlNB2as2B6WfTn8Gr8SZBRNeKFWgiUw+vUdQ3trqtKkmUWxyyiZgoa
	 QeGGeYIh9cihMx9XXenA/p52Pt/teJoZ3JM2nkSDT1bX0ZqO3wynNKnkXvMSPjiLxj
	 kAcnKg6aGh3vfyMYAMQ3mPcdj7XOz4rMRgaPtrU9EU8wMSVUuU8/1x3vdO5OI5vqTi
	 qOOJcBO9oq9sq938K3HH9hbNoZb/e/YjUfxrz+tvpvW1U08p/uT47q+fVWH+O3S+Yi
	 qYvDUlBvIdwsQ==
Message-ID: <86a4f9a9f1cd6e47b2e85731d5d864644ec25bc4.camel@codeconstruct.com.au>
Subject: Re: MCTP - Bus lock between send and receive
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: "Ramaiah, DharmaBhushan" <Dharma.Ramaiah@dell.com>, 
	"netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>, "matt@codeconstruct.com.au"
	 <matt@codeconstruct.com.au>
Date: Sat, 17 Feb 2024 08:11:52 +0800
In-Reply-To: <SJ0PR19MB44153C87D151BA76C93DD289874C2@SJ0PR19MB4415.namprd19.prod.outlook.com>
References: 
	<SJ0PR19MB44153C87D151BA76C93DD289874C2@SJ0PR19MB4415.namprd19.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dharma,

> Linux implementation of the MCTP is via sockets and is realized using
> the =E2=80=9Csendto=E2=80=9D and =E2=80=9Crecvfrom=E2=80=9D. Requestor in=
tending to send a request
> uses =E2=80=9Csendto=E2=80=9D and the response is obtained using =E2=80=
=9Crecvfrom=E2=80=9D. From the
> basic code walkthrough, it appears that the i2c bus is not locked
> between the =E2=80=9Csendto=E2=80=9D and =E2=80=9Crecvfrom=E2=80=9D i.e.,=
 bus is not locked till the
> response is received.

We do take the i2c bus lock over the duration of the MCTP
request/response (or timeout if there is no response). Most of the logic
is here:

 =C2=A0https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/drivers/net/mctp/mctp-i2c.c#n483

> =C2=A0This presents following problems.
> =C2=A0
> =C2=A0=C2=A0=C2=A01. If multiple applications are communicating to the sa=
me device,
> device may end up receiving back-to-back requests before sending the
> response for the first request. Few of the devices may not support
> multiple outstanding commands and few of the cases depending on the
> protocol it might throw device into unknown state.

The bus lock does not exclude this. MCTP, as well as some upper-layer
protocols, have specific provisions for multiple messages in flight, and
we assume that the devices will generally behave correctly here. If not,
we can generally quirk this in an upper layer application.

If there are misbehaving devices that require special handling across
protocols, we could look at implementing specific behaviours for those,
but would need details first...

> =C2=A0=C2=A0=C2=A01. Consider a case of mux on the I2C bus and there are =
multiple
> MCTP devices connected on each mux segment. Applications intending to
> communicate to a device on a different mux segment at the same time
> might mux out each other causing the response to be dropped.

Yes, this is the primary use-case for the bus locking.

> Is my understanding correct and is this a known limitation of MCTP on
> Linux?

No, this is not correct - we do have bus locking implemented.

Cheers,


Jeremy

