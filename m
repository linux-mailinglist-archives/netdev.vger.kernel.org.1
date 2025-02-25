Return-Path: <netdev+bounces-169313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CE2A43671
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 08:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505831669EA
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 07:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E9325A2CF;
	Tue, 25 Feb 2025 07:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D0Za6qyx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HmATznfr"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D111B2A1D8
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469845; cv=none; b=D8i8CsmnlTaF8Cn+ArIfWy6ZvfSdA+lZKdxojo8o9qwawHp/RjiRHSdM4/IPxSodq7D4OjIKzLHJbZxLTcGaGPdYp0eVLJRibk+fbo/NcvyYJJ0B2aYtwIfvwNtVnM1QVUhBx5yzPPGby2bZs0CXPtAN9BvJbPttoLR9EuuUpKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469845; c=relaxed/simple;
	bh=/AlSEgSDOXBnaGrfxeUnY9+FCGxh6v470RpBdGOMQ/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t9dQoAosA88XlqvmApmcdntrgig8Is/dxeWd1konQWnKdheVCaZsPtrN5CpHnhcbXYg+QPJvJfVtTWnm4u+BV2Q94dmvC05+nd8y33GpPzEu5n8g0PbIjiCvZyi10O1SYoh1i0NSOt6PbM7D2XEgevb7e9tCF7u33rSovOdg0PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D0Za6qyx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HmATznfr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740469841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/AlSEgSDOXBnaGrfxeUnY9+FCGxh6v470RpBdGOMQ/c=;
	b=D0Za6qyxwz9wHMA3UYklfzOmtt5BnJrd485nl5pOFJNMLlENZvAcMptjI08MDo5y/OQHJC
	oFimYx/g3gUqbsxbK/5cZb0qiYnTTMWx90cZgFogxWrVijfBX9nV4gvypAPvtYurH9JWMX
	5177gAffUDftApjh4FkC7I+IHb58kr/dySeAacoI7As1jismniEPDtB4+OptG0/v+JTir/
	mcJHWvDOn9wrIxPMA2p+aFKigYWZwL5IseA0b9/ijx/f8MBz8nK2MxAvE+kJosfsHsQNP6
	JFd1X92KecxxuvvcB/rUxxWZ3Ig+2mIjC54aOjcScWbbZrkHtdqADF2194P8GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740469841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/AlSEgSDOXBnaGrfxeUnY9+FCGxh6v470RpBdGOMQ/c=;
	b=HmATznfrgc51qXcH7B7/huWm3tJKPqcBLs2v7EpaOJrWqiFbm9qHIz/M9vu/nGBbvkL+uP
	Sx+/LIj+40ZQVpDA==
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Faizal Rahim
 <faizal.abdul.rahim@linux.intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] igc: Change Tx mode for
 MQPRIO offloading
In-Reply-To: <1e8e6855-0c87-4007-aadd-bdcad51f97cf@molgen.mpg.de>
References: <20250224-igc_mqprio_tx_mode-v2-1-9666da13c8d8@linutronix.de>
 <1e8e6855-0c87-4007-aadd-bdcad51f97cf@molgen.mpg.de>
Date: Tue, 25 Feb 2025 08:50:38 +0100
Message-ID: <87y0xuzcmp.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Feb 24 2025, Paul Menzel wrote:
> Dear Kurt,
>
>
> Thank you for the patch.
>
>
> Am 24.02.25 um 11:05 schrieb Kurt Kanzenbach:
>> The current MQPRIO offload implementation uses the legacy TSN Tx mode. In
>> this mode the hardware uses four packet buffers and considers queue
>> priorities.
>
> If I didn=E2=80=99t miss anything, later on you do not specify how many b=
uffers=20
> are used after changing the Tx mode.

After changing the Tx mode, the NIC uses four packet buffers as
well. I'll add it to the commit message. Thanks.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAme9dk8THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgiTREACfGb+/KsvZWrxd3BzCT4zu2YeTN4tQ
WF/yaCIT3YINg+ykGfI6/ounDceGigKVZBwcGgfLSDiZpIej2jpmvJP7zLkPDvHH
refHCbRmNbTWBRGshi0oHIaKMFJE4krnuD/8DqruJh1yw09ywSsi+lIuwJ3pOLhx
6gBa5wayAiKA/GWnDkosDvepFgH2SReYaE2o5MzHLJF+nrTtZFKLIxBCRl9Psj1Z
e4MvGzGagCoiu9Vbhip9YycduRliUWYhel6hTP9hs9vrfqljOq0N/8MnLbYwslRk
f/9I4YyMfJwsXd1fQARDJ2wbLJP/6I+/BcZ5CVGL30LD3fDDnC6vmqb42HS/b8PY
l4lXicsjPKG8fFlABDaPcsNPp/H04h/bqF5Z2nydcqtk8LoNLz2vU2oTiHuo0zXx
wZiihtGCVN4ruaemJwBdOURACtQW6trghflCAh6kOViPkA1aqJM16EbXARQ3oMix
NuRaXVuDAiEX+qZ46EDuv23Qo4P9fQo1jSpRVExARJnXA3NKUJLRaoS522i7+jHS
/9Zd+WtlmgjJXKXkknN8iOEQt4Mhy4JPH94dRgDFh+PN1x7uFm4LcBnyPXdoBc44
ApwN3bCqqdjiQo3Axf2XVH+abqGPI2N48NckyED97Uw3tjvuB/sWAJ/XOvHE6JYy
tk1z3DtyZB0cEA==
=nusx
-----END PGP SIGNATURE-----
--=-=-=--

