Return-Path: <netdev+bounces-122727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB2F962530
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27261C210FA
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A412A16C687;
	Wed, 28 Aug 2024 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i3mOEnRk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ehesvafn"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F6D16BE1D;
	Wed, 28 Aug 2024 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841945; cv=none; b=EZs3pQpTyZHbvL9h7pv05yEg5gz6DWcPbFDlyBz1eOcIEpyt0cWg3QAdYilXUQa+0p9dYuEnhg+Zh9N/HCEoI6hnCo7QVjewtQwVdaxgNcncmTJv4S1q7So4G5ePus0q6L+JlzviwoJ0JYCOrjXZpGQL54ku9scEzaC6oYPBqR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841945; c=relaxed/simple;
	bh=HHeyk1qYklHDiIfT+97cQ8ROYMtnRJ/q3JESjm0PZwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ugHekYG6FimoWepN8QrRx1QY0NxPqmm06JVL2KZWzlR8nWu89R3u3BsmyPJyIlcjd5CergJjFUl5i4B2TjCqckqdzgArIXYUHB3ROvOlMbhoAMhkhHXV+3/M50Lk7G5kzp0RMIm6xlcuFEPka6BRiznGeZPMZGY8LkUBdSlCEBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i3mOEnRk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ehesvafn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724841941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHeyk1qYklHDiIfT+97cQ8ROYMtnRJ/q3JESjm0PZwI=;
	b=i3mOEnRkoxDmULWh76Dm/EKY8IdH6O9XbYqVG1nq0IeqDyzJZy02iwWjrxE7cgeDZGkK+b
	OnyXAhz6kbXCUJARwz10vKx7WeR6Q17kplWQKbFojxmjfP0T7MsLWkf1HgXIFmTwbQNb1C
	EBMw3d7C8gQZEPJA5I40wzEfbrNogKG1DRKXHPj0tQBCiRs1+JA6LHLhXE0c7UlEntbVPj
	VyRB9xpKrwKEktZlC8Kiibw4FD4bwpvX6lg+jfAs1LNY0/MyD09TZlY7+LSiSEN9x3XC3M
	M0lN2o0WqXgjKwyvorX2gdWJZwvYEzcvMK4uvFkvalcugrH56vVdawTpzguVCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724841941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHeyk1qYklHDiIfT+97cQ8ROYMtnRJ/q3JESjm0PZwI=;
	b=EhesvafnaHYRbWYOd5EInnWBJOjAmWsOwIWYjfp6CAkAEFR7FlzViR5hAyvk6gEF/7cgnV
	ObfbSXClGUAfZoDQ==
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Georg Kunz <georg.kunz@ericsson.com>, Sriram
 Yagnaraman <sriram.yagnaraman@ericsson.com>
Subject: Re: [PATCH net v2] mailmap: update entry for Sriram Yagnaraman
In-Reply-To: <20240828072417.4111996-1-sriram.yagnaraman@ericsson.com>
References: <20240828072417.4111996-1-sriram.yagnaraman@ericsson.com>
Date: Wed, 28 Aug 2024 12:45:38 +0200
Message-ID: <871q29x6wd.fsf@kurt.kurt.home>
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

On Wed Aug 28 2024, Sriram Yagnaraman wrote:
> Link my old est.tech address to my active mail address
>
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>

Thanks!

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmbO/9ITHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzguK0EACLHEGv9+cHcbA41CxSae6J4CtuTdwo
BjR7ZuYUshiuWXMO9LtGmkblDQ/HN509Pq9f29xkgDaxvxupDZ4rv1c+SEYEPyDU
7BOGL+3jf9Z2TuyN59yXPtWzBaCYzd3e39RedDkr70EOxJlKlkQ2oDuW/vP4ZFLP
6L5iSe6iKRWHtXdjw09EbRgBuxFlGi2jatVpbr7NJwq3d4hEe07w0Qz+XTtPpTRn
rS40h5zIiridB0iUBQXVkBfbGFGJlvsmOlGpZbL2T4H4ccU2PFUHZ7ato2/ElELs
YLd76cU6l7uVoOV0MMcuRzCqf0rhWhsX9tgDNMhwXIHG+qOHN2synYFNfagDW/ol
3T3KH4Vq4ok7BQR3W7HVYFggXpWKft5cEpj60/7WO6vkkGPYdxOCPjDDRy+Cb7Oo
rqJKRH3jLN/GumKFEeaI5BBIFlds6PyFTQGKPbb8ju9yIlsI3RlEYv3ubZdmCUOM
L5QqD49JN2OMsPUYPwG8pL2yE0bQiFQtSXuNpFk3pEA0Tr1aKuuVM4aoBHmMBemg
i6ECOZveYRLb1j90jpIL3a+HjOdqfu1Na/v7BSzax59+gd+0XhjAl1sEgf/3oSNK
zh6ObLedufCB8rz5hMTQYsJFSeO+fBpeTPrSBwGPvu++WbnzkI8CDj5CA38otcQP
+k8BG3CGfe5hig==
=eo2G
-----END PGP SIGNATURE-----
--=-=-=--

