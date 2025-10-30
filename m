Return-Path: <netdev+bounces-234450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D782C20AEB
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C86D64EDD68
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 14:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559EB28505A;
	Thu, 30 Oct 2025 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Swg5IeDZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2412F280339
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835051; cv=none; b=PEBEK21HkmrZaqMqx/IGTa43lJVuHJTHCmon3J2Sup8Q6gyJzpWDgbZG0s2W3W4ZDX4hYWcjKoehSFryb7doLIlLZg6mAKyw3hVlC23Iz2Yod7sntpKGMrtS6pIo40JM9JL6aN30ZDXLr2tH/cWhpdbp3N9iZeX9//zYy84XcGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835051; c=relaxed/simple;
	bh=W2tFHrxjF9R7yZerC3QuwC212i8dXNXnozP40jU6o+E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQ878Xkt5ijUFBPuE9VxnxfQwF+5jBYbWogS81z/J//ltTwcRxZgWAxSCkmby5NpKXnHm/LgG6ULFMqW2b+fmk/OHMhPUTkC76+fw6YpPOSS9QwLtFWD4Z9QKv9/Zu4kW6WSv5rovK2fcCbjzWju07IyX1fKg1ijJYKGkkQ7gpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Swg5IeDZ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6AAE44E413F8;
	Thu, 30 Oct 2025 14:37:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3B34E6068C;
	Thu, 30 Oct 2025 14:37:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 971CE11808B5A;
	Thu, 30 Oct 2025 15:37:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761835045; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Lxv30X39Q3dKaH+UEOCf/KzUIJvJDh4mKiMtqUhsnNs=;
	b=Swg5IeDZuBQFrtNEoH/8KwAFGuByiMSkSf3SjAetQRUeGE5QyMeUAQuPAEfZcL70fREMaV
	/8vCCig3iTD4jjNZ8TOPtIJylTsbeJ7v1mr6zBGd6mM09SVuQPQUeQUtp7rniYjNjtpjtQ
	m483hq15IGr4QG/Y0ff8K8wW1kFDpuOAPpWP5Vr+6hWn17CYwiyGpxYH4pG/dvlZm9tsnR
	cQ1UZBqq3hjjnZySRROHRH7ZF1Y0pPhTDI0+ncEeycW2mFaJloqFAPUrBk3/TX2EUcJgw0
	15BFt9bHg+aHyjxCDy7uwYfoiwYpLqthSQavMsu0VheccL4E13JQfIFQkPUs/w==
Date: Thu, 30 Oct 2025 15:37:23 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Michal Kubecek
 <mkubecek@suse.cz>, netdev@vger.kernel.org
Subject: Re: [PATCH ethtool-next] netlink: tsconfig: add HW time stamping
 configuration
Message-ID: <20251030153723.7448a18e@kmaincent-XPS-13-7390>
In-Reply-To: <20251029153812.10bd6397@kernel.org>
References: <20251004202715.9238-1-vadim.fedorenko@linux.dev>
	<5w25bm7gnbrq4cwtefmunmcylqav524roamuvoz2zv5piadpek@4vpzw533uuyd>
	<ef2ea988-bbfb-469e-b833-dbe8f5ddc5b7@linux.dev>
	<zsoujuddzajo3qbrvde6rnzeq6ic5x7jofz3voab7dmtzh3zpw@h3bxd54btzic>
	<8693b213-2d22-4e47-99bb-5d8ca4f48dd5@linux.dev>
	<20251029153812.10bd6397@kernel.org>
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

On Wed, 29 Oct 2025 15:38:12 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 29 Oct 2025 18:53:20 +0000 Vadim Fedorenko wrote:
> > >> Well, yes, it's only 1 bit is supposed to be set. Unfortunately, net=
link
> > >> interface was added this way almost a year ago, we cannot change it
> > >> anymore without breaking user-space API.   =20
> > >=20
> > > The netlink interface only mirrors what we already had in struct
> > > ethtool_ts_info (i.e. the ioctl interface). Therefore my question was
> > > not really about this part of kernel API (which is fixed already) but
> > > rather about the ethtool command line syntax.
> > >=20
> > > In other words, what I really want to ask is: Can we be absolutely su=
re
> > > that it can never possibly happen in the future that we might need to
> > > set more than one bit in a set message?
> > >=20
> > > If the answer is positive, I'm OK with the patch but perhaps we should
> > > document it explicitly in the TSCONFIG_SET description in kernel file
> > > Documentation/networking/ethtool-netlink.rst   =20
> >=20
> > Well, I cannot say about long-long future, but for the last decade we
> > haven't had a need for multiple bits to be set up. I would assume that
> > the reality will be around the same.
> >=20
> > Jakub/Kory do you have thoughts? =20
>=20
> hard to prove a negative, is the question leading to a different
> argument format which will let us set multiple bits? Looks like
> we could potentially allow specifying tx / rx-filter multiple
> times? Or invent new keywords for the extra bits which presumably=20
> would be somehow orthogonal to filtering?
>=20
> tl;dr I'm unclear on the exact concern..

Yes I don't know either. There is already such "orthogonal" flags:
https://elixir.bootlin.com/linux/v6.17.1/source/include/uapi/linux/net_tsta=
mp.h#L180

We could change the bitmap to a value here, even if we don't know what the
future is.
Jakub, as it is already in uAPI but not used at all, would it be possible to
change it or is it already too late?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

