Return-Path: <netdev+bounces-215640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 403D8B2FC0C
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC00F3A94FC
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA316239085;
	Thu, 21 Aug 2025 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rOJN1s2I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gYn6KMMR"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0C222069A
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785287; cv=none; b=SXhXDqTy6d+oy8qUESX73HMf5B/qr7zKdajLQ/jdF9TMGFfuLD6YUY/Kgx7EP2XcM1Go/lkwX5lc0xZwtVNPlZnXi6tE5celXFS07QuWyoN+QYiogkNlHKXoy6igdtBwLDMx82b3y7ECTusnd8nvzii97vRWDkd2FvE5ViGpKSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785287; c=relaxed/simple;
	bh=97Zu0Bv0fNeJWeob/9eos0/7B+DKVK6081D9saWOivM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ccE+8sdNvsrWdg+O7BSLQlZ/occJd7KSDfPZU1muOOC2e0IeusXoLaAHwVophfIeguUlSuDbesuceuRm0aNGjtKKNBo0ZJoWvdW31rkooVdr+QDuST2sO31uFhu3TOXliOTgD8uVo4GwBQsykKH1vZq1+9QnTo8EUdYJFtYoaPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rOJN1s2I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gYn6KMMR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755785284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+a0n6yg5YpwXfaAe6ujzgjNE4xpyhtOIVlYowEYwLrg=;
	b=rOJN1s2I/sErJtAxlWiWnB/Zke8rfX5pHhgKnuJQhY0gujy7bJOZAFxINvVwtQCdRiDomg
	q/59rcaMI2QUKsjAi08IHmxr2L27Brps4a5BOIsPlBfgFRFIgRrs5lQ7sTZkA49HAVO1fi
	Z3CVQyXuUysK5nrl7JccVn87I5ey8sXv67nmtM2/GZ9nOLxkF/bBcImoOjmNOHQ8o5T47M
	esx3djGv8IrRoaM3NqgUlrjCDxseIyO5MGTbC3dMeK5Qj+1rgD/rh06qfc5DgjECLiKePn
	ZMnpeaG1XtDLOW7EOCEgh9GQiJ2YqBAwgDeIfs+ZnMwKwE0GEZ+zlMVOqS+2bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755785284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+a0n6yg5YpwXfaAe6ujzgjNE4xpyhtOIVlYowEYwLrg=;
	b=gYn6KMMRYMBjxIKsLf+ZQx0i51JXsE4/aG/YsHP5zjYn06GV/GyJXXWrBzkgSIwjNZDwS8
	LoM2A7jzTKu6GKAg==
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Vinicius
 Costa Gomes <vinicius.gomes@intel.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igb: Retrieve Tx timestamp
 directly from interrupt
In-Reply-To: <aKcYFbzbbfPXlrlN@localhost>
References: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
 <aKMbekefL4mJ23kW@localhost>
 <c3250413-873f-4517-a55d-80c36d3602ee@intel.com>
 <aKV_rEjYD_BDgG1A@localhost>
 <81c1a391-3193-41c6-8ab7-c50c58684a22@intel.com>
 <87ldncoqez.fsf@jax.kurt.home> <aKcYFbzbbfPXlrlN@localhost>
Date: Thu, 21 Aug 2025 16:08:02 +0200
Message-ID: <87cy8ooji5.fsf@jax.kurt.home>
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

On Thu Aug 21 2025, Miroslav Lichvar wrote:
> On Thu, Aug 21, 2025 at 01:38:44PM +0200, Kurt Kanzenbach wrote:
>> On Wed Aug 20 2025, Jacob Keller wrote:
>> > On 8/20/2025 12:56 AM, Miroslav Lichvar wrote:
>> >> But when I increase the rate to 200000, I get this:
>> >>=20
>> >> Without the patch:
>> >> NTP daemon TX timestamps   : 35835
>> >> NTP kernel TX timestamps   : 1410956
>> >> NTP hardware TX timestamps : 581575=20=20=20=20=20=20=20=20=20=20=20=
=20
>> >>=20
>> >> With the patch:
>> >> NTP daemon TX timestamps   : 476908
>> >> NTP kernel TX timestamps   : 646146
>> >> NTP hardware TX timestamps : 412095
>
>> Miroslav, can you test the following patch? Does this help?
>
> It seems better than with the original patch, but not as good as
> before, at least in the tests I'm doing. The maximum packet rate the
> server can handle is now only about 5% worse (instead of 40%), but the
> the number of missing timestamps on the server still seems high.
>
> With the new patch at 200000 requests per second:
> NTP daemon TX timestamps   : 192404
> NTP kernel TX timestamps   : 1318971
> NTP hardware TX timestamps : 418805
>
> I didn't try to adjust the aux worker priority.

Here's what I can see in the traces: In the current implementation, the
kworker runs directly after the IRQ on the *same* CPU. With the AUX
worker approach the kthread can be freely distributed to any other
CPU. This in turn involves remote wakeups etc.

You could try to pin the PTP AUX worker (e.g. called ptp0) with taskset
to the same CPU where the TS IRQs are processed. That might help to get
the old behavior back. Adjusting the priority is not necessary, both the
kworker and AUX thread run with 120 (SCHED_OTHER, nice value 0) by
default.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAminKEITHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgmnuEACsD6c/HGINjfd4LUKYXkIyGMzWu+/q
YiRzYk51/ZKeYPDASuO4pgA7Zlv5kfoPz7lfs7J+b9Pqkn7xR+aUk63Yjw5c9qI+
dYZ8hOXG1UR8SX9dtGITHhDc4J8cBQZdIQlyHLXBgMQ8Q1n1gdDud9lakTXTU5ld
CYk2MmWpxqA7I0/uwx7FyUfIoeLVWt3QMThsVsUHXVuchCp6XN5ubptdKbdQJqrD
na1/S+BnccF5GUc9KX5LCG14jzNVgVvV/O4C99RjeCAv7krMkJpl4Lee0oxrVZpV
ofg2qY9uKoUZGh6SelPtk74sI7G/CbZvN8AQLpg47BpvNtUZtwmj4HK00DPiiPTu
mzwrmhoTI/s5fcdwKsYNFlIaA73RN6xGE7RCOovGnMb6guyMYyPb6Uco3sQ/qtfY
JePd8Jrvac4MV7OR1FH3mat7L5R70v/NWKqVanQlLn5ofI2zEaWAU/poeWYmob7g
wwpBv3yDRrDOXvl04JCY3eFh6G5Kb8Yc+vHpgZ+VAQfOJjyME7UkySTS42PZwFPT
tgWaXqJVSLClObVp/gptJueaRpzE6FUalJxkKrc6ICxgqsJBCrLuKBqe0NxR8zef
9TCmer4t3Jwo9JwiHEVI2LRIrS5R6RzSInoc4tvODRNb15tEps003vuHHbkGBIgJ
xFPd492TdGdDtg==
=qiXK
-----END PGP SIGNATURE-----
--=-=-=--

