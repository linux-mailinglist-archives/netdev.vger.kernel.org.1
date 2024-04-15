Return-Path: <netdev+bounces-87868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8CA8A4D33
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF771C21FF6
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F075CDF0;
	Mon, 15 Apr 2024 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YeAUzIja";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JTYhWBoS"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C065FDDB
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 11:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178939; cv=none; b=JR6Qep0gz3K57WhE8HtS1SCNJDzch8Nt41hVP0Zvlm8cDaV0il/LJ4pEVyD1j+rknQSdx7brozcdT3xqCFR1oUdSGbqNYiT13ykGmd+i6s2zIgIy18hB/4M4Wi/6TPn8wFx0YQrS4mVE6MP/vuTZ9TtAG7IqBM/TV6g0hlsczNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178939; c=relaxed/simple;
	bh=Iup/E2Z1WjEWPfxFDQcDvpZjGXHr6zId0gCi5u7ymqw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iuCgrwSa+saixwmP4hbKJDvRjjePSgiLEQGAj0S1sSi0GrT1OjNHNJBJjKGxiIghiW89bPezgYWI5zyW/xlF6fn+RHocbW5jCeMwV/sLdrcBW8S9Sb08jPI4mtoTwgXbZALpHjswwMx+nzx4CBEmOJwq5pCt2Z30iFLWAXpF7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YeAUzIja; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JTYhWBoS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713178935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iup/E2Z1WjEWPfxFDQcDvpZjGXHr6zId0gCi5u7ymqw=;
	b=YeAUzIjafFVlWbU1pQ9y8y+2P+9UB8Is9zbnnVTOS+U7e9uww22L5/mDdCGNZBYZC/LZqg
	eb9zKRiAcJuSXfs7akEJRudSoFsUKbEQyn2T73zRTQJvQgON5B8m6Cs+foX+cIg9P13muZ
	aXyuH8Tg7VqumsZcj4sNJvtv7YMbIkx4pxxAyflu6BolIHAoXMcfx/cwoo4Yo3QzDK2qkW
	PfKN2Nx0KWkWO8W2FdTj69lq+gkRWOS3ysQC7GKUgIcyim5CnYVPcgJEY9uk+tL4agYeko
	631VPRBf+6x8nBafPwK4sxnh4v5hhcyiSK4qDiZhhh23GbaWvEphnMThDHKmmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713178935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iup/E2Z1WjEWPfxFDQcDvpZjGXHr6zId0gCi5u7ymqw=;
	b=JTYhWBoSpOWfwwzFaW5Sl9JOi1z+jl3L4JWydwgAzR4GuFjZAzfxsWXaIQt4Bpiq5puYAF
	7BGSjlR1WORM5ADA==
To: Lukas Wunner <lukas@wunner.de>, Roman Lozko <lozko.roma@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Sasha
 Neftin <sasha.neftin@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net] igc: Fix deadlock on module removal
In-Reply-To: <877ch0b901.fsf@kurt.kurt.home>
References: <20240411-igc_led_deadlock-v1-1-0da98a3c68c5@linutronix.de>
 <Zhubjkscu9HPgUcA@wunner.de> <877ch0b901.fsf@kurt.kurt.home>
Date: Mon, 15 Apr 2024 13:02:14 +0200
Message-ID: <87zftukhxl.fsf@kurt.kurt.home>
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

Lukas,

>> I would have been happy to submit a patch myself, I was waiting
>> for a Tested-by from Roman or you.
>
> Perfect. I was wondering why you are not submitting the patch
> yourself. Then, please go ahead and submit the patch. Feel free to add
> my Tested-by.

Scratch that. I've sent v2 with your SoB. PTAL, because your original
code snippet didn't have a SoB.

https://lore.kernel.org/netdev/20240411-igc_led_deadlock-v2-1-b758c0c88b2b@linutronix.de/

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmYdCTYTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgsf3EACno5JgtsdefQPawYHdXfivHhXfpDK6
s7wTlGnEk1GOdVN5Z7RfiOu+82Fyyhw+fLoxCa9AsezeSHFWduGwJPR5BFG7FMP1
+mP4i5T/X1naOgi0RU/IO/Md2u9UO7CgeELbOTMwv3B9ETD6dyd7ZIDl/lSUzgr2
dzRud16ri0O7pQvmwOEdO8C6utcVbKYZ+umDcCvRBKSeVJ/HnuPXmexFFtBy7wlI
gseiIM38HJfUVZ1O1glf9FG9kt8Z8YJ4ETmTyGiu2nmC/zp3Jcd7Lc1LkZ1oQhMp
cfAKgBAZQQ7bUVAtaiAR+xe6dm1tgOVYgwtB3lZmJ9j0XTtPBkAIvqmR4bOKx5PL
OrqgzWgdtkbLJWb89MOinnN/EOQL00BAVn/nhhqUTsaaETTzXrLmyqsxjpU8uvzA
CoJzUsf5Yt4nZwHsVDFqTUNPF5mwkSF2+Vr3fLwdPzmb5ZxgpyEIPo6lAKcinyKR
8cxGW8Qy1ArGRuQR7y8MUOIYHFupXQDtJvhqFT28vEwm4fk8BfexWefgEdabO0FE
PJyI2m2Y1gHzNn+fkmTCKxtBcZsixMgjRAomkcYtnYDUqJfO/boaVwAI0IiHTGK4
WbJ+T5slDNT5CZgT/jfuqrSWCB6+4id8qkUP/ObLDRcyx1vuTJH77Gumljd6tdxy
ILHI2R31Mdz10g==
=394O
-----END PGP SIGNATURE-----
--=-=-=--

