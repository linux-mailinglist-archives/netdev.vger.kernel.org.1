Return-Path: <netdev+bounces-137042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C559A4146
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C2F1F241F4
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FFC16B391;
	Fri, 18 Oct 2024 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FVYtLXQB"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C103C17
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262182; cv=none; b=pzcLlWWTDkN2Pob7w0tYVJTpRHR6HV/M1EgTP9P1NpedIebrfi+HT9MoxZtw/X4kmGmlCwQQyWYx5yckdw8xxVuMnItHnrg4uAvz7xlZPqF5aD2/MCjGJJCw3khUBiqI0IRWc6URVSRHGqxjyChMGdFSH3IvO7u9CoeNsQU3k14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262182; c=relaxed/simple;
	bh=wPuR21ClbW8Xi//YoTjn/Kd+BNGyFAgQlcDIkSuCMYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dM/DMk3W440BT2mXxw3X9wiYb5HG2CZMA0Tz5Wo+SLC7vPgymnGzfNWw4LvfnPk4A/rxjeoTiiSjvHnsHbPtfG8RMk1TdvtV9bMHvN9KwKDltzzSCeNHs2ebJrIxOM5lczuu79RoDZGqj855Hb0BFtr8LqpOEgF47lR++dFTuOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FVYtLXQB; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 10BE2C0003;
	Fri, 18 Oct 2024 14:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729262171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/fFWn83Pg6BvGewuIo3d4T/1Ho7wC4ifedJDVSkBFS0=;
	b=FVYtLXQBSm6nRHK88oUHZJHxSmGZsRvIkGI+z570aXbjxKVyvz+Lgn4XwoDiAtVAYRLjym
	Ru2x7AwzhzjTZjvL6WJ/UaTxmXWY6PoIrre0jr3RRN1fE/oiQXfJKDsmvNh1M7KbwI/gHM
	Us0VMqd6K0rUyoeZo6caEg/HD8caoiE1UFfmhL1dMFpVSz1diFClgv+aKKV0PQk44YGnPZ
	qePst4SUdBckPj9dIv7b0BiELsQxtVqpwWYwITv4hXvZX76JBrTlINM4YmReeQfoZFOjqk
	/e2oFrdKMHAlepGZ62wYZ5/Ent5V6OYz7cec1fNvLL80Hz3RufY12Wt71QUMtA==
Date: Fri, 18 Oct 2024 16:36:10 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1] tools/net/ynl: improve async notification
 handling
Message-ID: <20241018163610.4b4152ec@kmaincent-XPS-13-7390>
In-Reply-To: <20241018093228.25477-1-donald.hunter@gmail.com>
References: <20241018093228.25477-1-donald.hunter@gmail.com>
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

On Fri, 18 Oct 2024 10:32:28 +0100
Donald Hunter <donald.hunter@gmail.com> wrote:

> The notification handling in ynl is currently very simple, using sleep()
> to wait a period of time and then handling all the buffered messages in
> a single batch.
>=20
> This patch changes the notification handling so that messages are
> processed as they are received. This makes it possible to use ynl as a
> library that supplies notifications in a timely manner.
>=20
> - Change check_ntf() to be a generator that yields 1 notification at a
>   time and blocks until a notification is available.
> - Use the --sleep parameter to set an alarm and exit when it fires.
>=20
> This means that the CLI has the same interface, but notifications get
> printed as they are received:
>=20
> ./tools/net/ynl/cli.py --spec <SPEC> --subscribe <TOPIC> [ --sleep <SECS>=
 ]
>=20
> Here is an example python snippet that shows how to use ynl as a library
> for receiving notifications:
>=20
>     ynl =3D YnlFamily(f"{dir}/rt_route.yaml")
>     ynl.ntf_subscribe('rtnlgrp-ipv4-route')
>=20
>     for event in ynl.check_ntf():
>         handle(event)

Tested-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

