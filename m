Return-Path: <netdev+bounces-87689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDB38A417B
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 11:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89E42815B9
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 09:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877D221A0B;
	Sun, 14 Apr 2024 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oe9sEK6R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5IYxmnEF"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB081C69D
	for <netdev@vger.kernel.org>; Sun, 14 Apr 2024 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713086132; cv=none; b=kEzDz8DqwuzxK2ze2UTSE/6MTVKG6Y0OOrQjA82uxF8qPZGHvgOvtJkV1+Uy5ws2xa8UfYzPEqFYRFjoFFLa+83lzEoebDeqlUQVvxDfPFZw/jwgvR4DgJR7hn22TE8E9RAT06z+CqQDqTve4u6ncBj5m9CHeIdtOnPRfy8DKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713086132; c=relaxed/simple;
	bh=vEin7Rc4tJrk64YbnlYlr2P9o0hfmQ/2JvKGBu1wJPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EDvlU6eGxlEXQV6lYhcSvL7R0v4D543eMhsyewvMTgtHk8hEbUE/wM6nbgUsRwFjU2plercVL4zg/Q2OoagvWiCHovhQ3t3zzzuNKTi3sELS2vpiPqotrL2ZthcDvcC/l1t928hNM+D3nrjb6d+h67Jjcxp6RdnhPAjeZKtFDyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oe9sEK6R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5IYxmnEF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713086128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=22LCWs6JU/zxgBjYTEA2rm5irDIXx8aJeQExD/3BR+A=;
	b=Oe9sEK6Rd10dd0rlosxkYryx2N/7YAQTA8PO+pdHoU6IEnc3sqyPAVtq/hKpCrsVU/QrN1
	Qrm6rWUA0YOs/u0UlKzoQ5a65SLekr4SDXws4ZFEz+YZU7T5bUJYSIsFsjX0eggr8LB8wy
	86rohHnA/d/5iJgco4rVgVld1w6XenUftmEfmpd/IUAQDAE8mAMgJc7PHVz9nGFEilLZ3L
	OcsoZnQRej3+wa9meGW11bHMNWfBJGtFS7KNeX2yZwJUzTvCqtWsWXdlLSB+WIa21BSUdd
	XhQhcpjnPqJbBLMDqMxVCsfdqoNUCPsIttD6kRv2BaXZLW8zHjI14vByrKd/Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713086128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=22LCWs6JU/zxgBjYTEA2rm5irDIXx8aJeQExD/3BR+A=;
	b=5IYxmnEFWUysnFHuwgw1UfVvvIrXJX317xHObbSrLE22Sf8nO/G+sSRjTCxbLkksRWUdW2
	PN3L52ehQUgQohDA==
To: Lukas Wunner <lukas@wunner.de>, Roman Lozko <lozko.roma@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Sasha
 Neftin <sasha.neftin@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net] igc: Fix deadlock on module removal
In-Reply-To: <Zhubjkscu9HPgUcA@wunner.de>
References: <20240411-igc_led_deadlock-v1-1-0da98a3c68c5@linutronix.de>
 <Zhubjkscu9HPgUcA@wunner.de>
Date: Sun, 14 Apr 2024 11:15:26 +0200
Message-ID: <877ch0b901.fsf@kurt.kurt.home>
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

Hi Lukas,

On Sun Apr 14 2024, Lukas Wunner wrote:
> [cc +=3D Roman Lozko who originally reported the issue]
>
> On Sun, Apr 14, 2024 at 09:44:10AM +0200, Kurt Kanzenbach wrote:
>> unregister_netdev() acquires the RNTL lock and releases the LEDs bound
>> to that netdevice. However, netdev_trig_deactivate() and later
>> unregister_netdevice_notifier() try to acquire the RTNL lock again.
>>=20
>> Avoid this situation by not using the device-managed LED class
>> functions.
>>=20
>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>> Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>
> This patch is almost a 1:1 copy of the patch I submitted on April 5:
>
> https://lore.kernel.org/all/ZhBN9p1yOyciXkzw@wunner.de/
>
> I think it is mandatory that you include a Signed-off-by with my name
> in that case.  Arguably the commit author ("From:") should also be me.

I was a bit unsure how to proceed with that. See below.

>
> Moreover this is missing a Reported-by tag with Roman Lozko's name.
>
> AFAICS the only changes that you made are:
> - rename igc_led_teardown() to igc_led_free()
> - rename ret to err
> - replace devm_kcalloc() with kcalloc()
>   (and you introduced a memory leak while doing so, see below)
>
> Honestly I don't see how those small changes justify omitting a
> Signed-off-by or assuming authorship.
>
> I would have been happy to submit a patch myself, I was waiting
> for a Tested-by from Roman or you.

Perfect. I was wondering why you are not submitting the patch
yourself. Then, please go ahead and submit the patch. Feel free to add
my Tested-by.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmYbnq8THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgpWsEACe07fEP5jsHlnLQYv+N0UEBa0gqAlt
Y17BtyVPOongY6Ge9rwriuFpRkVKe9hDU3DMtEDtElaERsGY5/q62QEHdSFz2Xph
8swJ6gm3APXfuDHo/ojcRhiYZq72LtQC1BzpK1GmoubBxuCEClgD8CbLk796aSdC
KGJ7ZHOlcncGQRBtXb3BGeO8OJ/3W4HxFxWxiuAaMyA0C/IJYEQHkf2tkEuRPlt4
wRDSWwe1kiOCk/XNcfQyoGGgQLTRwxmNhMbsisXT2OWUOP79yqhEI5uEiBZvTDdN
NeEkYLEn2RyFzVBgF4x4qdjkXWhEyXoK3xZ7widWaYv8OK9ApXyqrAe2ETpfm7Cl
ZyysXawhtREtOEHi9Ngx+CFYqMPAZogsBCF+DJFCdJbGH36ltFiM04JCWRuxSnfA
izD3Qe/jDutHQXUCVk7DOpDBLLzDq+aAusHMPCG+aGf3SPGMSiFPtSLCFD/A3O1O
8t5/X49C2zgdKmVkunN4iLdwA9UrXb6ZikuMNT0D/1r2KRaYyY1OPSvCR5lU3HQ0
E7ASKm7MmUoFmpVvNcrmfEXUyUyPHCa1I6E4GTJ4auivuPOv/JUeFxxvoM94mMWD
O9/PljgDLwjg8O3kxkKKBlH6aiKiQ0UsocWh4oX9ZWHlGqKzkPNBLES/KmmhtxwS
Dr0nzYMcgyF79g==
=viC8
-----END PGP SIGNATURE-----
--=-=-=--

