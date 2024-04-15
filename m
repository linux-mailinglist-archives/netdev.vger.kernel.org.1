Return-Path: <netdev+bounces-87996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41EB8A5288
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 16:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE25D282C05
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 14:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA2E7351A;
	Mon, 15 Apr 2024 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JMXT1O6o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bG0RKwoM"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F54D73186
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189657; cv=none; b=Fq/7bghve/o+wBHvf4gAzqddLV8vy47orzFMn/j/poHyhvy0R/lEdziN80tmCz9EcnKYiiW6/mh22fLUA+hPyYJDBnWlHIY/lMK7ZTl1MBTs+5IT1PPzsxaecm7x2qDmzJeJbYVgXOrQ8fe3Sd3W4TYUX65vMwVVMfIg7BJ3kpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189657; c=relaxed/simple;
	bh=px2vG55pE3JPcVlPraM2XP+jrtWQUE3roNemiyTuZms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WtlEFZWo0b8zBPovX75EAZSQ5sR2UWe4E9DfA/wP0RKvHSQk0r8aQQk5nseSDRc1pFL5Mvco4sG7lQEaHPDiH1r81pLIt2hVIP7GrHqK2/Da84gRHVTNpKs0gt/Z9VMmelx8jIQdSFJjFPCOHoSgLZn9WaLOloPucBIdQLmySJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JMXT1O6o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bG0RKwoM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713189651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8CkXYS21B8SH8DBLj2VWRkV6viWLhTMjW+3OPz7/pzQ=;
	b=JMXT1O6oZ6nTdi4AMFLgwnZgPGJ118+Fqm24qdKBp74cis8rybF0EST1nxdwNwMufuyRlH
	4fBc+6apyqVN+f8yXOw2FcNaO8CKBtDTH9wD+JHl9mvwlQnrFjSANvkvwiQunM7yIVzETU
	5XD5PFnryJIX13v/Ut1Cr3y80mVhx62YAaHkTzsGcJOfh2k9VB003waU45iJBGL0z33kHW
	ARsV72CZVGnSk0Yr7v/Ai7TFBcTO7fiCscxx/f39BLF4Wyo+EMW4H2SicO1y8qI0bt40Fj
	K51B5TeF2T3THDJezdNHF4dbijIDzJ14pwDjZFpuOsnbnTsy4/4rnyvFxFS+8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713189651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8CkXYS21B8SH8DBLj2VWRkV6viWLhTMjW+3OPz7/pzQ=;
	b=bG0RKwoMXR2QZzzmRtLvhLpK4rtObVSmR+dHWmkXp4lJFK5NEqoeGLa/MBTqb0HHWWWqAa
	KE+az3Qc5Se7wnDw==
To: Lukas Wunner <lukas@wunner.de>
Cc: Roman Lozko <lozko.roma@gmail.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Sasha Neftin
 <sasha.neftin@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net] igc: Fix deadlock on module removal
In-Reply-To: <Zh0xguaCQB-V8ckO@wunner.de>
References: <20240411-igc_led_deadlock-v1-1-0da98a3c68c5@linutronix.de>
 <Zhubjkscu9HPgUcA@wunner.de> <877ch0b901.fsf@kurt.kurt.home>
 <87zftukhxl.fsf@kurt.kurt.home> <Zh0xguaCQB-V8ckO@wunner.de>
Date: Mon, 15 Apr 2024 16:00:50 +0200
Message-ID: <87ttk2k9nx.fsf@kurt.kurt.home>
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

On Mon Apr 15 2024, Lukas Wunner wrote:
> On Mon, Apr 15, 2024 at 01:02:14PM +0200, Kurt Kanzenbach wrote:
>> > > I would have been happy to submit a patch myself, I was waiting
>> > > for a Tested-by from Roman or you.
>> >
>> > Perfect. I was wondering why you are not submitting the patch
>> > yourself. Then, please go ahead and submit the patch. Feel free to add
>> > my Tested-by.
>>=20
>> Scratch that. I've sent v2 with your SoB. PTAL, because your original
>> code snippet didn't have a SoB.
>>=20
>> https://lore.kernel.org/netdev/20240411-igc_led_deadlock-v2-1-b758c0c88b=
2b@linutronix.de/
>
> I created a patch yesterday, as you've requested, then waited for 0-day
> to crunch through it and report success.  Which it just did, so here's
> my proposal and I guess maintainers now have more than enough options
> to choose from:
>
> https://lore.kernel.org/netdev/2f1be6b1cf2b3346929b0049f2ac7d7d79acb5c9.1=
713188539.git.lukas@wunner.de/

Yes. And sorry for being a bit unresponsive, but i was out-of-office for
the last couple of weeks. Anyway, thank you for your help in debugging
this!

Regarding testing, it worked on my test machines and the Intel
maintainers will validate it as well.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmYdMxITHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgm8dD/9wq0wT4s0WUmzJKekTZ5wLDvDGWoiM
BvfXf2TuVuADSCwL7rOrPQjcenNkznF7lr834KXR5Emi1W6brNtb+5TbZUvXKb3e
sfrYJL6BDrLCb9Ii3/Ib9V9gGPwXcxa2WLbn8bgRO02PYUH07SHiuauSsi2MqT+F
zSZyIDugP1S7fpH11zb1IW4Cvd67iPr+ol+eUdYVx+ZKJDkBNkdm33vHXHMFq2ud
s9oKZhTZshDXbgPR+5MnVdaCyJIw3HOdrFijHOcMIHUQOotaJhmOuk4IxQ6xWMRb
BxrUypJcBY3aaej1byqu1zha6vhnKeVgxPk+E8VxFYhrHFvBkmaInTaxRrol6s1H
aiDFcOAnWYt6uH/3N5QPRq3qqNIPoSfmvMpm3RfKhcTTGWgwVkOT4tx+iMLGA0Vq
6dO/P2C/LgVAOAf58QnMrX6oWxTBNz4qRLx0F5B7N/npUNTr+wWlojXEzS4AAjaC
7W29HEGX/qmVgJTAcK7X3ZoIU3ia/vhrdQashGytswJ53CuQeb0gkfY4Y9gTKLwx
zSDqEChuw2vCYJK5mflWX4YXWD0Hwe8mFXSxPcM8b2/0G4teMCSv0ESNrlkN1baS
QKZU3ev5BX5yHZHVs2HaxVwdLlSjm+F9KC6gV6wlm8POpfm2S4AKMl2Vjy5wKOe3
Bm/7y5c0wlRtZw==
=kppl
-----END PGP SIGNATURE-----
--=-=-=--

