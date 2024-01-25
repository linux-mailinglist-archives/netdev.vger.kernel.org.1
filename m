Return-Path: <netdev+bounces-65774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C3883BAA4
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 08:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79BAE282FE9
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 07:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B6C11C83;
	Thu, 25 Jan 2024 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xY+5DeU1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GCdJrb8F"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEAA11731
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706167919; cv=none; b=HtkJhBFvIUSOGJ/HCrdPctEfPO0BRx21JybH/5T2Wp3Ux+HUvlLfjSIc3qaoIRzNmx8HCCZ7mnfTsm5JXNSmXkbxo4591DWzShqkVI1JbOf8EPpJkZhlCBWjduYK6hx6qjaBFlBMZQiaxe7VpSNKY3KbJnin1e3ZXVZOrKTvicw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706167919; c=relaxed/simple;
	bh=u0662KfdQOEoLQZUhjZ3QWxde3WlZWZoj3EEvJD5LzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GcdiwTNMcDOJw6MR5lFF5woa4EN/ErbBY8rBZkkJP8h7LveQiYRcQfAJolrlQXcKAFy5I7plDOqIAk9jjiSS0NTjKrA7HKIR49fN4lfSHZDWLOI2HG+8VlqFF6qBHPXIJN9puxltL8KcAz2YT3rHBS+DHiDPC1FP23BMXFsC0ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xY+5DeU1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GCdJrb8F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706167916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u0662KfdQOEoLQZUhjZ3QWxde3WlZWZoj3EEvJD5LzA=;
	b=xY+5DeU1rnSWh/i0TMXaAQWpBgKAtL8mzj13Do4RKlgCcs41CjcDNy19LaPjmzjgmJ2u60
	TSHnU9DDoE1y7dGS7J/FdSOTyvRFvvmF+libzkt3BxzPwhcOupmUyx5Ag4pf0nmOWwwfXJ
	hbERCCP2xtYVfkdkgSCzVias+PwY9BY318cYqwaNgceSzAIG4EFw6r4k/nsQIYzAT5rIsu
	xnKKyHvXs+cYLf/wLU4R6X5qItZuXvJtnJngaHkyykN/V0hkrGBOvCIXd9qZofz9hL33Bd
	PsY/Nl5yTsiDuCHtS9c86aJOf8K1Wgz2qaZCpHXAZnA02fBkPt2JdRYNtiQ2LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706167916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u0662KfdQOEoLQZUhjZ3QWxde3WlZWZoj3EEvJD5LzA=;
	b=GCdJrb8FI6n+NzGDUr9ekXOVzS39IbpEOkVEYfUjSNFaHlHxXPLJ2Cr81ua8LpnsnjPpEE
	MWuEW2TnymuqHeAw==
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v1 iwl-next] igc: Add support for LEDs on i225/i226
In-Reply-To: <de659af0-807f-4176-a7c2-d8013d445f9e@lunn.ch>
References: <20240124082408.49138-1-kurt@linutronix.de>
 <de659af0-807f-4176-a7c2-d8013d445f9e@lunn.ch>
Date: Thu, 25 Jan 2024 08:31:54 +0100
Message-ID: <87ede5eumt.fsf@kurt.kurt.home>
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

On Wed Jan 24 2024, Andrew Lunn wrote:
> On Wed, Jan 24, 2024 at 09:24:08AM +0100, Kurt Kanzenbach wrote:
>> Add support for LEDs on i225/i226. The LEDs can be controlled via sysfs
>> from user space using the netdev trigger. The LEDs are named as
>> igc-<bus><device>-<led> to be easily identified.
>>=20
>> Offloading activity and link speed is supported. Tested on Intel i225.
>
> Nice to see something not driver by phylib/DSA making use of LEDs.
>
> Is there no plain on/off support? Ideally we want that for software
> blinking for when a mode is not supported.

Plain on and off is supported is supported, too. Should be possible to
implement brightness_set().

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmWyDmsTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzguiyD/9wI7NnFwQFyI+EIwhnBpOuhJ3ozKQR
VIkRlgu5lJqpib5CgVW81zHqotEVY8xkViEoOKnvMffxRepA1+sZE1zqOoQiNNi9
6BtyqbmaAqka+bUWs731orXX25xvP09PZ4UoYFqpNnXeFHFYgLGuNs6pIEf5Xaea
MUF4oi5XK2ob2oUfZu/umw210oA8TYoF84hEwntQLf+Un8reypS7CCemeim6YQzB
h2oYEe2Y+d3d3hZIoTceKfLVa5l9eyu5WmXc6tXzvTPAMlIteJzRELNe3ngJwm/d
QN4uBm7A5UJ7nN4LOfZ0nGoOvHmsGJFQCFa4Uv0lrU7AmuM6G2gvPySAkKNUsFQG
5sKREal5NgW/FZTj9pkEGekgtWMT+k+iIs8IBjN1lixMVTKu0Pu06TaKMaFkeiDR
vsMtLwc4mHO9cj8C38eCGRpoOkEfqJeUD7CwdUNEfWRV0pb7SwbXuKCbU/FDLmgF
IzCV2daYskm6BF71WQunGL/d8x3lT+2S+6ZzYmhvxF9AerU3sxcsF2F2p7L91Say
NH9v2BnwUruN2acDZRGiMx03rNOjDxWLx+hP7CpupKzjaYs39nHrqi8bWQTQOrpD
lb9xvEAN9fSRC9/XzK6GngSShTN5BFecDMa/navG4yBa1Ju00Uh5oj+P60gjWF6Z
5UkFjRoE+ieGsQ==
=Ncxy
-----END PGP SIGNATURE-----
--=-=-=--

