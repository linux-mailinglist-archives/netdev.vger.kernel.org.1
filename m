Return-Path: <netdev+bounces-223643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABEFB59CC1
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2B7169376
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B904E246799;
	Tue, 16 Sep 2025 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kRhE+7TW"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CB223D7EB
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038469; cv=none; b=FXljMZcG5bBVvExVs1yCgBfpDZaJUeNu1nTh+oLX+ATdXIPHxDXKFEs3HKgRYLelZDDGaMDgC168mhS3k2WumY3b7QYSxQRkpOdEpiArJoOjMobYQtcTn8tYwm49Y3XOwEf2WczXl4t+1FpDBE4pm5FhtQraLyeUmpHOQIkGVfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038469; c=relaxed/simple;
	bh=12Z7EtfXW6hIAvNp9SiZ4ATe8iahj+C8iJj5KT8uBqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H74Wshv/MW+hCY/t9AyNurGPDb1ZALIvyuR5m9s+mxMJ9PzX5smCjqrda0NgavX9rAjPNpzlYOTQyQikhDtqQZ2ZNWJpn7x2YH7lvaxZUk+oZiIa6BMNzRdxi/LbpjqZRK9nfEELsY+qTanNzqillTZs8LC1zuDxvMDzCZfpKrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kRhE+7TW; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BEDAC4E40C5F;
	Tue, 16 Sep 2025 16:01:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 950806061E;
	Tue, 16 Sep 2025 16:01:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B72D102F17AD;
	Tue, 16 Sep 2025 18:01:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758038463; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WgcOUvkVjC5v3gYt5rLKd1Oj5hroahmD2dPspWpeQzE=;
	b=kRhE+7TWnW0PVkqi/ZU0iSXOgvZSfN3p5A0ZX2FDOowVxflZl7YiASbfLZoHrxQgzkMt8e
	GcE5FTN513ABpBeE1yXBiZFTzu1kRCC9AuzTf8+D+Uhzgyl7LMYzsE/PSwobupgjFslgYD
	wQmKJIL+yos6/2cO6DWfZSVh24j3MAqPAvx++plo7J4ekpu60tpnUU47DgSadIJxw/IVw1
	bBVY/lMWZuNZQYzmkUS8ehZrYQ0F38s6T75ehkld9DW4fwHvstjW4GHDLMWD7aCVAs1qQu
	Z+QT9Pgv51+Vt6z7cI3BNckzLi+qrS72sGF4WpCH8P5rfdE2WykELcFa9gr2EQ==
Date: Tue, 16 Sep 2025 18:01:00 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH iproute2-next 1/2] scripts: Add uapi header import
 script
Message-ID: <20250916180100.5f9db66d@kmaincent-XPS-13-7390>
In-Reply-To: <20250916074155.48794eae@hermes.local>
References: <20250909-feature_uapi_import-v1-0-50269539ff8a@bootlin.com>
	<20250909-feature_uapi_import-v1-1-50269539ff8a@bootlin.com>
	<20250916074155.48794eae@hermes.local>
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

On Tue, 16 Sep 2025 07:41:55 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> On Tue, 09 Sep 2025 15:21:42 +0200
> Kory Maincent <kory.maincent@bootlin.com> wrote:
>=20
> > Add a script to automate importing Linux UAPI headers from kernel sourc=
e.
> > The script handles dependency resolution and creates a commit with prop=
er
> > attribution, similar to the ethtool project approach.
> >=20
> > Usage:
> >     $ LINUX_GIT=3D"$LINUX_PATH" iproute2-import-uapi [commit]
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > --- =20
>=20
> Script I use is much simpler.

The aim of my patch was to add a standard way of updating the uAPI header.
Indeed I supposed you maintainers, already have a script for that but for
developers that add support for new features they don't have such scripts.
People even may do it manually, even if I hope that's not the case.
We can see that the git commit messages on include/uapi/ are not
really consistent.=20

IMHO using the same script as ethtool was natural.
The final decision is your call but I think we should have a standard script
whatever it is.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

