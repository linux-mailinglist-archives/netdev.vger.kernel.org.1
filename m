Return-Path: <netdev+bounces-66126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A62A783D5E6
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 10:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460C51F2821D
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 09:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3323A1CF8C;
	Fri, 26 Jan 2024 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y1XN9KY+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b14yElSz"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950001A71F
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258247; cv=none; b=EhaSdYDpWHunlJGc8YTPgQpSinlxOMRjbkTHmXmQDit5EgQMh9/rbz7rpDLxxNDjPxhd5plawm/m0uvt0MUdS3CJ+zgOPa/oYhV2I9WZgBNBMTqxI7KGdtuZo7TU4ZhKfM11nwwcRwC19BKrUKij2YJfXLy6A0ECcRnaBy7uSss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258247; c=relaxed/simple;
	bh=X0SiHFkiWKAhDPmg71AH4QepY4u+nFwTSDqxTdOMzWk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SQKMK12L8UOihSROixABr8eLQW4RsUlHGsBb3PzaOjaia9sIkekWlLmmWuN4TcviUSebPnV1moFhTQd1mwHcSJ6D9FyzmcfApn38FnkV5IO0KML5DPn39xad6xUQxE5+VPf0JpCPtTOWU3b23E68zov1bhpGa1KMguMRAnf0ahg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y1XN9KY+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b14yElSz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706258243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X0SiHFkiWKAhDPmg71AH4QepY4u+nFwTSDqxTdOMzWk=;
	b=Y1XN9KY+Zez1/kABUGhTpJkU34KqkcIla1oU/I3WlGX5pktP1jFkmDOMCYZLDjHZ0/RFeR
	9BTV0VylKIpim6M3icMN1FzNERTjmp5jFe+KI7OFHn9H6gyPWGk74+/3qPGOPJP7XDyWmN
	LKg8R1WwblRon9FFG7rWphdzCDpACL9PgafFfXVJiSRdkN/hsopGdigr8NdC/ivai1Y+ow
	1KLH9QSvrdqG58yIyP4AYLpz0U4ZWxyP94cDtPYE/XFB7WuSrcqOAIOKaXK7+aHynJ+tYr
	mXwOKgey68/NSH6Uk6TkWPEkHJQtGkxh6qqu3Ut0LYSHEWBDjuwxPrSrgKpI9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706258243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X0SiHFkiWKAhDPmg71AH4QepY4u+nFwTSDqxTdOMzWk=;
	b=b14yElSzKVIyJw270bzJi4GidrzEs6/pg81dP08mL75cAW2NiAjVKl8ggd65nAPJCjicaV
	OBcilCkleEajx0CA==
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v1 iwl-next] igc: Add support for LEDs on i225/i226
In-Reply-To: <2caec578-a268-4e82-95df-9573a52d6b7b@lunn.ch>
References: <20240124082408.49138-1-kurt@linutronix.de>
 <de659af0-807f-4176-a7c2-d8013d445f9e@lunn.ch>
 <87ede5eumt.fsf@kurt.kurt.home>
 <2caec578-a268-4e82-95df-9573a52d6b7b@lunn.ch>
Date: Fri, 26 Jan 2024 09:37:22 +0100
Message-ID: <87y1cch4n1.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu Jan 25 2024, Andrew Lunn wrote:
> On Thu, Jan 25, 2024 at 08:31:54AM +0100, Kurt Kanzenbach wrote:
>> On Wed Jan 24 2024, Andrew Lunn wrote:
>> > On Wed, Jan 24, 2024 at 09:24:08AM +0100, Kurt Kanzenbach wrote:
>> >> Add support for LEDs on i225/i226. The LEDs can be controlled via sys=
fs
>> >> from user space using the netdev trigger. The LEDs are named as
>> >> igc-<bus><device>-<led> to be easily identified.
>> >>=20
>> >> Offloading activity and link speed is supported. Tested on Intel i225.
>> >
>> > Nice to see something not driver by phylib/DSA making use of LEDs.
>> >
>> > Is there no plain on/off support? Ideally we want that for software
>> > blinking for when a mode is not supported.
>>=20
>> Plain on and off is supported is supported, too. Should be possible to
>> implement brightness_set().
>
> Great.
>
> Its actually better to first implement brightness_set(). That gives
> you full support for everything the netdev trigger has. Then add
> offload, which is optional, and will fall back to software for modes
> which cannot be offloaded.

Understood. I'll do that.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmWzb0ITHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgh8tEACuu9QsIaTI4/ZbjIT+yLekZ5GSd91w
xHK647qj4dpL1hObVIimTobuL8qKH5ZOoRRT+kIp8crjnZh7xFFAtfY4frCSa/7g
SizPhBVmSGg/sKV6TnYUsKvuVVgp54jAz+KWx/OLE5cnQQSFcpqyk+c0PuV/xQZr
lS2+yIQz0ucK4GuqM6hJ1xjR+p0VtaSFoUASKAu7wZbWaAe42KDW8zsWibvnBLCw
zx8fBDtxHI/Rf+E6YLpfKkd9+3AVO39Zvp2m9kRipdULXvyul8mBjfiU7K0/pYbP
rMbYxlicLgzFDyYE2Q87cEiUnhWLmHmuQiI9dRMKGcPmC2nfkIN/eZ4Qky5nt7pD
RrGz8AWT81a/NAorTXh59WikubTUpA61S5krIOb6eMKbyd4bJ0g4Rz2Yj45u1Z5T
ypOBLdt7NJnqdKe4Yn9vHZyP89HdIp0JgSrPoXGzsw0l4YLY8lEUuK44YFzenC9U
ZINUmQKRHVSfHtSvwLOPMMMO5tnwC7+gxJLaHFCyy0rhsDmoyZqhBDnnfPRCpa+M
OVxzNqgfebn7m5eh8/77FdPabZZS6YipbU7I2dz/tSKfhK6WHoPYQmYPlyJJZMqU
ivBR5sQ8NuJGVrrk+sb/rPPYmnGEydedu7Qkiq61KxYyW+n5sPpsiMptgBLW+FuF
YO+3hg52d+Ji6Q==
=ref4
-----END PGP SIGNATURE-----
--=-=-=--

