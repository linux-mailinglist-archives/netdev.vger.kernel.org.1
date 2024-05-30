Return-Path: <netdev+bounces-99463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B38258D4FC3
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE381C220B3
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90521CF94;
	Thu, 30 May 2024 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="/DkbkW7T";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="Vti+mgL7"
X-Original-To: netdev@vger.kernel.org
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F64022EE4;
	Thu, 30 May 2024 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=72.84.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086232; cv=fail; b=nQOM/sB38lSKiaEM9bC3zF8Emd7mxpS4cf4GVPlxsSbcQRUPT/9Tyk/jZiAdkb8Wr1CMlIVEc6zq7HZaRUAVow6+9RcIsCxSBXb8K5aYQQUU+N0KrGxJHeEWJ3XAiR3uOvDBy4sbvk2pRmqbuQkTYY69Kbpcc4cp8inCLABFZ8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086232; c=relaxed/simple;
	bh=pgv/sBueGj0uNKfB+M0Djeywb+8H0C+WrvypBsXAPEM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KXqH7tUxVkwuVzSB1l+bpw1+6nObsCC5x8X81HLD5Ph06vItDoYZ47tEaol7L0SYpwPB0MFQKlzROYTHCMkM+oK91kIZ4PztBwHrHAK9GazTnii9NGGKbMq61+atlI3y1I3IO9A/anWnvUlzUpEuxiD4bQf3xpu9+78+HkJD/8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com; spf=pass smtp.mailfrom=sapience.com; dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b=/DkbkW7T; dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b=Vti+mgL7; arc=fail smtp.client-ip=72.84.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sapience.com
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.sapience.com (srv8.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id B10AE480A32;
	Thu, 30 May 2024 12:23:49 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1717086229;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=dYO5M/SWP6VTWCO+9ICoA/oxJGt9BK5VSGvf7uIy8bc=;
 b=/DkbkW7TFBSmFsKekzbJJja6XCq5dkQNCaLQDvp1dWYwANzxAC0716JGFC2K2l8IejIwz
 d51zu9L9Amb4+cTAw==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1717086229;
	cv=none; b=iB1cd9emc9n5onI2zUhwk8DjlZMTziCi1/Dg9luEFk0NgnW/PrqpdX93atHlebk+woIX9zsrFGgqLwxyTAwdKA58Vb4n6tKN+Wim0e9HQS79XSDjgr6+qc9r+ShjzMhxHBm2pjmWpETTmUT/9PxFoah3RXEqaCmj8yjK7lzbDCFVigviSteDa7nUPwzXFondOGeeDYvIgHhMGq9GacTGb72JFzWqLSebfQldV8IIy3CmJKGtC4c34/MPijKOvR343B/bNbgMjRhgC22E6zfAKpvnW1+EMHrQaJ+3lWjczkwN7wNt8D6eZ40F9K6pVndjiCni9u2K/v9WCBNoJlQP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1717086229; c=relaxed/simple;
	bh=pgv/sBueGj0uNKfB+M0Djeywb+8H0C+WrvypBsXAPEM=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:
	 MIME-Version; b=IYCYOgQLJx9CCBURcnxT8AQIE3O/hWUgQqL+J3L/4/Ctcy8i5u8pOMHCWthQT51bU4RqcZxwSDmSecv5QcHnd3bJp4ELuayzX48uFXIgCV1v6xbxSJwtuk++DHxH3FAgVLUu+IpeKkQi9KnMatlnT3FMU3vZhrPPIBhzr7Ejk4jcO2pqApcfsjwnvfKqw3bPEAEEIRwvtx6b1C6mCxfAyPMIYHd+oJJCVQv7JgChrT3SHVNxqXhNlrE3mEapG5JHYmiBc4oIK/7y9df3JkXfKjOMxt43qlh8zCwzNmU1H7pLeusiWIoYUWzR+vBiytO6KFa2nK90s+RSSwv3u1ZPJA==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1717086229;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=dYO5M/SWP6VTWCO+9ICoA/oxJGt9BK5VSGvf7uIy8bc=;
 b=Vti+mgL7eSBgug5ZK5bUA6iNFjXba5Yv3b/txFC9eYAN91R3i3ZO91/tHG/2Cx4DO5NCr
 Qw1v8ShCt15IzglKOrX3p2rVfmykD85j5Xu5P9s9ui/PSExgFhKwR8J0j8hRylwdUenuqgf
 MM6/AEe1/DFp0c5jvomDmV6dqWGXK2jIBrfYMSDg0i+r9rLegGZDZLuKf5vznP7AwQNJVwY
 Iv2gxhVGJ40F2O+iQETVMrwvMqfeK1ih3Ye4Un1m6GgTq/XAPnxFApjsKmAnq/an8W+tlgp
 eoONbi1eSQ1yoX5MTBYI5j+uF4nyo8Q0xRQXNoa/4OssHTPDJnys+Gv8Mekg==
Received: from lap7.sapience.com (lap7w.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by srv8.sapience.com (Postfix) with ESMTPS id 7C04228004B;
	Thu, 30 May 2024 12:23:49 -0400 (EDT)
Message-ID: <73d37ff63ee7cd88772fc0767f4474317b56a0a8.camel@sapience.com>
Subject: Re: 6.9.3 Hung tasks
From: Genes Lists <lists@sapience.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch, 
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  pabeni@redhat.com, johanneswueller@gmail.com, Thorsten
 Leemhuis <linux@leemhuis.info>
Date: Thu, 30 May 2024 12:23:48 -0400
In-Reply-To: <ZliHhebSGQYZ/0S0@shell.armlinux.org.uk>
References: <9d189ec329cfe68ed68699f314e191a10d4b5eda.camel@sapience.com>
	 <15a0bbd24cd01bd0b60b7047958a2e3ab556ea6f.camel@sapience.com>
	 <ZliHhebSGQYZ/0S0@shell.armlinux.org.uk>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-+QEfLFhrShG4Mf1bhoXy"
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-+QEfLFhrShG4Mf1bhoXy
Content-Type: multipart/alternative; boundary="=-2wjINsonf24vl+/OcDje"

--=-2wjINsonf24vl+/OcDje
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2024-05-30 at 15:04 +0100, Russell King (Oracle) wrote:
> ...
> And then we get to pid 858. This is in set_device_name(), which
> was called from led_trigger_set() and led_trigger_register().
> We know from pid 663 that led_trigger_register() can take a read
> on leds_list_lock, and indeed it does and then calls
> led_match_default_trigger(), which then goes on to call
> led_trigger_set(). Bingo, this is why pid 666 is blocked, which
> then blocks pid 663. pid 663 takes the rtnl lock, which blocks
> everything else _and_ also blocks pid 858 in set_device_name().
>=20
> Lockdep would've found this... this is a classic AB-BA deadlock
> between the leds_list_lock rwsem and the rtnl mutex.
>=20
> I haven't checked to see how that deadlock got introduced, that's
> for someone else to do.
>=20


Thank you for the analysis - hopefully someone can track down the
culprit.

cc: =C2=A0thorsten

--=20
Gene


--=-2wjINsonf24vl+/OcDje
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><style>pre,code,address {
  margin: 0px;
}
h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}
ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}
blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}
</style></head><body><div>On Thu, 2024-05-30 at 15:04 +0100, Russell King (=
Oracle) wrote:</div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; b=
order-left:2px #729fcf solid;padding-left:1ex"><div>...</div><div>And then =
we get to pid 858. This is in set_device_name(), which<br></div><div>was ca=
lled from led_trigger_set() and led_trigger_register().<br></div><div>We kn=
ow from pid 663 that led_trigger_register() can take a read<br></div><div>o=
n leds_list_lock, and indeed it does and then calls<br></div><div>led_match=
_default_trigger(), which then goes on to call<br></div><div>led_trigger_se=
t(). Bingo, this is why pid 666 is blocked, which<br></div><div>then blocks=
 pid 663. pid 663 takes the rtnl lock, which blocks<br></div><div>everythin=
g else _and_ also blocks pid 858 in set_device_name().<br></div><div><br></=
div><div>Lockdep would've found this... this is a classic AB-BA deadlock<br=
></div><div>between the leds_list_lock rwsem and the rtnl mutex.<br></div><=
div><br></div><div>I haven't checked to see how that deadlock got introduce=
d, that's<br></div><div>for someone else to do.<br></div><div><br></div></b=
lockquote><div><br></div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8=
ex; border-left:2px #729fcf solid;padding-left:1ex"></blockquote><div>Thank=
 you for the analysis - hopefully someone can track down the culprit.</div>=
<div><br></div><div>cc: &nbsp;thorsten</div><div><br></div><div><span><pre>=
-- <br></pre><div><span style=3D"background-color: inherit;">Gene</span></d=
iv><div><br></div></span></div></body></html>

--=-2wjINsonf24vl+/OcDje--

--=-+QEfLFhrShG4Mf1bhoXy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCZlioFAAKCRA5BdB0L6Ze
2ztUAP9jIfYUH867epX9kme9kL3SIae0lnrtM3DSeYE1axiCawD7BDiTCWFUP3i/
i0ulDQ52DV3I490ratrq6pxYUlXj1w0=
=Jxt6
-----END PGP SIGNATURE-----

--=-+QEfLFhrShG4Mf1bhoXy--

