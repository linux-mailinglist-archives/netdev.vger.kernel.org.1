Return-Path: <netdev+bounces-208349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD089B0B1B3
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 22:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F073189CFE6
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 20:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F26222599;
	Sat, 19 Jul 2025 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2TcXCo4k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="499HiW9Z"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2711DB125;
	Sat, 19 Jul 2025 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752955248; cv=none; b=BzNok5pMleRoDgsFIZFP+xxEhrECGlCAE/BYwIKenGux8V23/KrOmr8pHtDTz2we3COGTjgubIdLeeGdGTat0Nenxi/Q8cbKFZhdy1dS/KJzPG3ZmXBiXbgZGUQG5qLLW8L7INyrAnTj4h9W7yP0ok/NPBe7PXJZOS7myXNTBSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752955248; c=relaxed/simple;
	bh=jTMC6D7kThqRw5KdyTgZQgsbKpneZXJ43ueH6X2ZHuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MCFPh/vXUXWT2HKSK2tVfGyMx6katHWwGTxlsRjt2tSruIK0ZaRJ+oxrCJOwKYn/CqK+FReU0oTGnXAd3HRkWC4hIAukN2qYSjDkxlOIhNo7QRdop5uVjhkjBTKf/gtEza+2v4TzweUosoSkIhiMY4ie0jT/Bt4VYOdEHRaTRtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2TcXCo4k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=499HiW9Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752955243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65wYKNNiN0OWhVJHpyXS9dHS9Q9ryxSmjNGIVHYwGAE=;
	b=2TcXCo4kTAYDprE+PALaELz8GYMYcdWTfms5ddUBjZyRax99Gv3HNw4OEkvZe47ezBzBVV
	IZx6/60JHyeJ6cDI67E8aK9rXzCTcQUQ36605TvN23klGNqJ0EvjB5fGWcLjlkv7zn7KTm
	bwjc8JP41IcktvgB8KqLEwOKYsPrpNXenM8LK91zPyOIbfRn12rKRtGq85Frx3h/ExJhsZ
	GhB2Cq+aLq89R/Qw3RYpF7QWNY4JgNmLwtrmB63tC8CKqs7We47OCpvNIIK0wNX7cpXTHP
	BnqcJbLXlh4KlI6rCpXYZ8/HVzn4Aybk3KU/QE3HKQOXG7qJq3tS7XgAVnIxNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752955243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65wYKNNiN0OWhVJHpyXS9dHS9Q9ryxSmjNGIVHYwGAE=;
	b=499HiW9ZxcprVMIWlEO6AZRhZ5gXR1gUuVmPG+11dRqb4fw1C2HOknupPgqkTWc8c4GSQa
	9oXsN0T5bzoqPKBA==
To: Markus =?utf-8?Q?Bl=C3=B6chl?= <markus@blochl.de>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Richard Cochran <richardcochran@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 markus.bloechl@ipetronik.com, John Stultz <jstultz@google.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000e: Populate entire system_counterval_t in
 get_time_fn() callback
In-Reply-To: <20250709-e1000e_crossts-v1-1-f8a80c792e4f@blochl.de>
References: <20250709-e1000e_crossts-v1-1-f8a80c792e4f@blochl.de>
Date: Sat, 19 Jul 2025 22:00:42 +0200
Message-ID: <87ldokuf11.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09 2025 at 16:34, Markus Bl=C3=B6chl wrote:

> get_time_fn() callback implementations are expected to fill out the
> entire system_counterval_t struct as it may be initially uninitialized.
>
> This broke with the removal of convert_art_to_tsc() helper functions
> which left use_nsecs uninitialized.
>
> Assign the entire struct again.
>
> Fixes: bd48b50be50a ("e1000e: Replace convert_art_to_tsc()")
> Cc: stable@vger.kernel.org
> ---
> Notes:
>
> Related-To: <https://lore.kernel.org/lkml/txyrr26hxe3xpq3ebqb5ewkgvhvp7xa=
lotaouwludjtjifnah2@7tmgczln4aoo/>
> ---
>  drivers/net/ethernet/intel/e1000e/ptp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethern=
et/intel/e1000e/ptp.c
> index ea3c3eb2ef2020d513d49c1368679f27d17edb04..f01506504ee3a11822930115e=
9ed07661d81532c 100644
> --- a/drivers/net/ethernet/intel/e1000e/ptp.c
> +++ b/drivers/net/ethernet/intel/e1000e/ptp.c
> @@ -124,8 +124,11 @@ static int e1000e_phc_get_syncdevicetime(ktime_t *de=
vice,
>  	sys_cycles =3D er32(PLTSTMPH);
>  	sys_cycles <<=3D 32;
>  	sys_cycles |=3D er32(PLTSTMPL);
> -	system->cycles =3D sys_cycles;
> -	system->cs_id =3D CSID_X86_ART;
> +	*system =3D (struct system_counterval_t) {
> +		.cycles =3D sys_cycles,
> +		.cs_id =3D CSID_X86_ART,
> +		.use_nsecs =3D false,

This is again the wrong place to fix this.

> +	};
>=20=20
>  	return 0;
>  }
>
> ---
> base-commit: 733923397fd95405a48f165c9b1fbc8c4b0a4681
> change-id: 20250709-e1000e_crossts-7745674f682a
>
> Best regards,

