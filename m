Return-Path: <netdev+bounces-196668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D0FAD5CE9
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 19:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A825B1BC2710
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C571DF994;
	Wed, 11 Jun 2025 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="NSeA5sYT"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDE9153598;
	Wed, 11 Jun 2025 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749662209; cv=none; b=ZrFd5nlQz0RDaTZjp2igSjYX3zcLhksbuEPrneOY3gfeDhKv55+IfArRG0AZpBiFDe2Sge+U2b/aQkk4/KPWbf7DpkevUO4IdnvEofs7BgBQ+f1eM0iItg5tcNxo3nNOHBMsdhaQ8LXzXg9uYdnUCEW5EqND/MZZonE8ZzDpZwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749662209; c=relaxed/simple;
	bh=wfGTFbVzrnm/eFJldsr80LKPWcoUnp2SqjZ2kKDQPrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMRa/XIii4YyQ88JjCLfyeuSxkAVKIqa6u4C0cKkWWA0lutacX3IICM5uw7dneRClEpK2ClyTkbRiRQ8zVLnYbBK3kjLXsbcwaYT33cThr0M7Lw8e7vmtxCnsul128LilxWYggeWbDgHRtx5Q5qwDDWYXKCg5yEm+E7KHRrdNM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=NSeA5sYT; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1749662187; x=1750266987; i=christian@heusel.eu;
	bh=OEGHZmIjk+ceUvrd8ghMlpfcoXbIaBBA/lq77JDDIEY=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NSeA5sYTpdeUAXOW0nAdhxtbkzlC3k4Fzw/TwSOLKEvY0KseEvpHMXTcjyaEbmOI
	 BZOxYLUoZcXVN/vETY7A3oXGXw1TztDsY3i33UHyPtUh2iE5Wg3gvffiU+Mjh+HOO
	 3tjyB8FZMIdn7uKPoZ522RKbriaYWhB3djTTSpCpNU8n2be23R2STafDRRhaw09vR
	 U++C9WsGgkJLgR5m8AVNjS4zlr5w4DpFf/ddHmZ4BqYNJxKDnjyf5g3w5ouMDkAR1
	 g+SWEPDuxMDuIYF8q7ZvPlNds8B3J52wCEs3NmVSDbE4Hw5FtP4Q5F+kG0mtg3o9o
	 odOKXaZBV4CNrM1spw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([89.244.90.56]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M890H-1uU3w91Y2N-00C4J0; Wed, 11 Jun 2025 19:10:26 +0200
Date: Wed, 11 Jun 2025 19:10:24 +0200
From: Christian Heusel <christian@heusel.eu>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: davem@davemloft.net, difrost.kernel@gmail.com, dnaim@cachyos.org, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, mario.limonciello@amd.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, regressions@lists.linux.dev
Subject: Re: [REGRESSION] af_unix: Introduce SO_PASSRIGHTS - break OpenGL
Message-ID: <b5628073-3d14-42a9-9b91-3ec31db8f7f9@heusel.eu>
References: <58be003a-c956-494b-be04-09a5d2c411b9@heusel.eu>
 <20250611164339.2828069-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pvxh2zg2om6kjmmk"
Content-Disposition: inline
In-Reply-To: <20250611164339.2828069-1-kuni1840@gmail.com>
X-Provags-ID: V03:K1:aPP1kRugb8Gbyx5XYk0iGW9/YSGeRy4gHEeQocsJrZRUzb8N94G
 oyX59AnGy5Wq2qsKTEwEVjAlDWR91DGT0xIzcvbhOri8Fo9K6orhXeK6LBtGZdp+gBjaqww
 sJWFmqs2zRk0j25GnRA+RNVxNrUGtk2xjeEJKBEScUNUkgQa3SYgk02+F2yE26rZzjoXTfx
 tVT122yEqPzOywbLyBrIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Vd/q57WHzcA=;3xgV+VQEIl1UmQAff2UJdyKnQZg
 598rDFSzh0WCIeTMJQyI0Y1xPD3uoWW4Pe9t221k1UQyShH3qFUwSrE6myYNkSglqDv/B1ND+
 WlY+db1egCqkXIYHZrBNwNRN/FZ03H9YBVCB54Iuhy5Gh4D8n8VyEZYwnyMRUVWjDjoo8cgNK
 IbyBApAOQTIMRRL18b9If4id49UHqzPDetTGvILxV9jKjPm9G8G74+FE0VUn2rTB6E4aBTIR8
 T1aUmCNWspTrWO/GInkYWQIel2uxdk9iLQqPQWTj7oeAEJNwmN5n7D+1HLRF0mXp9UhGuiEpf
 LehYUpuWvXxfh+q3ktINSXZPldrP8Ktm9s8pcYsyQ+iGzW8XTpGb/vB/fZ+LXYut3yvCuf4HH
 hsdp6em8RtSjIrjYgT8Sbuy7SdtsA+NFxz9wd0keY94kKend0qljVD5VOd3riOy9w+hx8hf6E
 8hS8OxkYlmHkFniNHsu5T8g/GqVAz3oulktRg7WWkxD/HKSi1mM2WHs9buUwnakYbgiLcDwb6
 +MjDG6MhczOzw2jsmZkoeR4o8qxNMvO6wBNyrts32d4gCnMm4VlskTenP8gYHp2R0VG1pQRcX
 wAUsIbpk6EaJtNPdJMY6j1MP4GZ1ebTA0bR7TbzzrKq4M48HteK+kZlXX7XvXwJaolNvSnsig
 lJlO5kxxpdsFr43QZgsfUbsyiQZ+9BjlcPRb/GxA09623Uqbbe5xYYlEdBW5QsLgDPD+ywPpr
 vSZwKNmvTnN0qrUjWL3g/zRQ5V8WO23f6dDZ429dXclLpHZJjsTKBu2aWK5EiHYoHvnZ/WsDS
 zMiUImZToJyOb8SVUIhoCya4OVoLsXtHbVyxq1EPqQDLjJINANIWbX10hkhVM1jkuXlfOxpQ9
 iauDiLfeNVEJqfEOTpw/bNvke3h0vQEakcIwul/VUj5Y5IH0FVrI0GR7i7aztuupt808HVak8
 pGROY4yV16/SjQfSUKp/7TtBMqq8V0K3355EzTCSlnTCmJF+WiWokD8rQQvk7SrjlnQHpFlb3
 /poHxUOpnuBeKgfghk8dwMoYLg/w+7R96i9pfguJuBpaXcAblIiYwm45yLKsONWa5kMeroDjs
 xHVpBE/Yf/LuiEkMvfDjkFFOzxnul/aS4eiacCfcZAwmW5D0DiwemcQDk2Yf1aoj5mrNQ7iO/
 cVOYaMOCOxPcvw9RYC6A/aTEr6Bdi3Fy4PRUWDrYBrA5eGLdOSbmorl0T9lMjuduYvQ4cJis4
 VDRnS+fe8ulOp8jpU22m8ngxJA1LcoCTZxHdrNo5EBTYxpHiXYVJtsJGpMDcxFvmFKmbmfZVB
 gt80m/CulhnRtem9roti9a57El+wg/DmDkxSqeKZtrWqXOgPQikGZc1eJ5JUWSSIcBPFfzzr6
 6gqhF+sEUVlft+XGqUdjlvmcxlUt3hb2O8u9SSbt6m9OGxYnpf2GDKPOp0


--pvxh2zg2om6kjmmk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [REGRESSION] af_unix: Introduce SO_PASSRIGHTS - break OpenGL
MIME-Version: 1.0

On 25/06/11 09:42AM, Kuniyuki Iwashima wrote:
> From: Christian Heusel <christian@heusel.eu>
> Date: Wed, 11 Jun 2025 13:46:01 +0200
> > On 25/06/10 09:22PM, Jacek =C5=81uczak wrote:
> > > Hi,
> >=20
> > Hey,
> >=20
> > > Bisection points to:
> > > [3f84d577b79d2fce8221244f2509734940609ca6] af_unix: Inherit sk_flags
> > > at connect().
> >=20
> > I'm also suffering from an issue that I have bisected to the same commi=
t,
> > although in a totally different environment and with other reproduction
> > steps: For me the Xorg server crashes as soon as I re-plug my laptops
> > power chord and afterwards I can only switch to a TTY to debug. No
> > errors are logged in the dmesg.
> >=20
> > I can also confirm that reverting the patch on top of 6.16-rc1 fixes the
> > issue for me (thanks for coming up with the revert to Naim from the
> > CachyOS team!).
> >=20
> > My xorg version is 21.1.16-1 on Arch Linux and I have attached the
> > revert, my xorg log from the crash and bisection log to this mail!
> >=20
> > I'll also CC a few of the netdev people that might have further insights
> > for this issue!
> >=20
> > > Reverting entire SO_PASSRIGHTS fixes the issue.
>=20
> Thanks for the report.
>=20
> Could you test the diff below ?

It seems like the patch you posted has fixed the issue for me, thanks
for the lightning-fast answer!

> look like some programs start listen()ing before setting
> SO_PASSCRED or SO_PASSPIDFD and there's a small race window.
>=20
> ---8<---
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index fd6b5e17f6c4..87439d7f965d 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1971,7 +1971,8 @@ static void unix_maybe_add_creds(struct sk_buff *sk=
b, const struct sock *sk,
>  	if (UNIXCB(skb).pid)
>  		return;
> =20
> -	if (unix_may_passcred(sk) || unix_may_passcred(other)) {
> +	if (unix_may_passcred(sk) || unix_may_passcred(other) ||
> +	    !other->sk_socket) {
>  		UNIXCB(skb).pid =3D get_pid(task_tgid(current));
>  		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
>  	}
> ---8<---

Have a great week everyone!
Chris

--pvxh2zg2om6kjmmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmhJuIAACgkQwEfU8yi1
JYV8IQ/4q05ypgWVUCyUkdHVeTY4QNiayhgnfex9hX2ya3Qx2J4LoKoFGM2JYwF9
v3xvC4HTqWC/fMIgwncD8wph10wpE1Mme1aHLP2iUK2J0eukv2nn5tNSgHFUtjiE
V+b1yFbV1GNgp9AtNVfQun0oW0TVqu+GE2IE0PaaKJryIOhl0HEWrck5HpyYOnaO
Oqs7B2fD8tQ43qngXLwQZEqGY1RKplndGJ9FvJtGrgwCYFlha638uj4tQm2yh7im
4mHvWy0HQBe5VOvWoPwk37giAHZfx0NMpFqNzXAtsI4v6SLr38MRTjp9wctgfFvM
OqFjuZkCVEjV7Qr3ZDMzJWgo4lMMgYmJ9SWvW0BfXWGN4Ym5Bw4KWoYyNCfW3s+r
ZHZnoH2cDP8we2FHZhHa8w8dTy+VAerVE1QCoiwBOZrTAVcY5g3SIf+XAAYCbGRb
BflcnGE9B5fZTYh7SgrjVInL6uOOn/5ouj23ZvukJlepaCKv5EvvZYeQ5NRgY9lp
4YDEmuglyaRXUZGzYd+JUbRdcoxLV8xwPYYWYX//YRP8YCisYGADxMu/FtGaM0TS
GpnW4SW1J++j9nAiAgLJW+R4XrLZkTxh1vfbSvLAb4OQDLynF/wzp8kR20GXc4V0
uUusdclFornCeHctDA0p8NIA5qlItdJfiC30NPxyhlIyLOai8w==
=RB66
-----END PGP SIGNATURE-----

--pvxh2zg2om6kjmmk--

