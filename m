Return-Path: <netdev+bounces-99418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7328D4CE2
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5111F22FF4
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 13:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E20B17C232;
	Thu, 30 May 2024 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="HnIDdblh";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="lGZ47/Hk"
X-Original-To: netdev@vger.kernel.org
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72C17C203;
	Thu, 30 May 2024 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=72.84.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076213; cv=fail; b=sTKVtszzGW90Eg1rEEG/IVqwWR0I/nOJajtyMxIspinvB5xSxWtM+Zycsv/PN1XN6PJlubfWlEzkC3FgMEfm1YeMczZaEUNT7wO7mM5GGofObnvrsXDrp6A/M3HCtqrkgG5d318u2m1Rb2JFDrRo4amV20hbA97bnNKeveCp9m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076213; c=relaxed/simple;
	bh=mGCv4VKK5XsF9Y+N0F91VPdDKV2jLIuC8ZGdirIZ3is=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E0fc6RsHamvfO7IWTG7OvaY8kDe7Snxx9VjI8jBnbKtcgUVHvGZdw5OpjKggn4GFKruDe7ID3VfNVD0l1fa1CM9C0vPbzzPIdHAMMlAWHh0OcVNI/tgJGPILb+u1SAazCrLKwyKiCQ+ZbeZH47aXEHrgPjEWbE9B2x3yosKght8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com; spf=pass smtp.mailfrom=sapience.com; dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b=HnIDdblh; dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b=lGZ47/Hk; arc=fail smtp.client-ip=72.84.236.66
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
	by s1.sapience.com (Postfix) with ESMTPS id A9708480A23;
	Thu, 30 May 2024 09:36:45 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1717076205;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=uJLBVLrBdtWY6uAKA9XSmGJdkkXv2yCkXTg9bREeGNs=;
 b=HnIDdblh48CD0Bui5cln41o4zkH5nNNu8O1A5Fk8q7Rwrezphj4GHDvN5eUPlj717LFt+
 f7NRLM7GVCLGzl3Cg==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1717076205;
	cv=none; b=T4Ap8aFN8656IBqpIvsOpK5rsECHtWqkRvo0+Tjrac+vG4y3CM2TFQPDLpvnzrojs8RIkmTPxUGQP/Ls7gb+M6CmLc70Nqqyt/LO77ENH4owUv1WvefCXnTKqSJkWXYPMnbyL5IxtnPnaE/DPUE8D1JyBQVEgaWSsJmH3oO5e2oMwsGJUEq70WK8r9qemg1d7ZkFlHRNTV78tFjt8Tf7FiJpJpcbF5wGL01XEXSm3HOPWHkgT6Ygfly6ycR2vnjUW+Zh3+gJXW7ukiZ8md0hIDEoRiuok40Ya9gw66oCXAFOrnPdjrjp0fV3JjTydvdxzYDfzL1qwuGfdR0jPaNZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1717076205; c=relaxed/simple;
	bh=mGCv4VKK5XsF9Y+N0F91VPdDKV2jLIuC8ZGdirIZ3is=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:
	 MIME-Version; b=kdgz11ZHw1by/iCPpJ5SQIs0YStcl9VhZ0Nsn681u12aReBZmw5ViyzDqDOLoMPpEBVH90cJ6byPbenWiCt8yPAy3IcbQoUV4kS4tSjk1GUlau1GSXQ6zAN5D0uxrUSG3P0znwYJSOukM2lfnlJlI8Py/Lwl+fvMoRYgkvOMM4fDEpfanv9IE6Ztr7ULfO/uHiYY4cev9jflOYcXv+wLC/bfrxh3sO+54HJFg44NFarnIG4ucnrnNDAGWfVVdDjfipTeKLGlBAsC+fxiqFybBEIZcx7BivQfm53THnKPFD6eyS2pNv6qr4uFjUkCYeG/bCZMp3uL1l3DRBDV3Asf6w==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1717076205;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=uJLBVLrBdtWY6uAKA9XSmGJdkkXv2yCkXTg9bREeGNs=;
 b=lGZ47/HkodmWJDyJPLzkPRb1Nwx8AyJKHvvyBKlZnfc/kU/79yUc/Kw922f5aVtybGXau
 grS825fKMewhfOt3WFL3471ZPd+I0o4CUmrSqPfIcbP6NrnqMby6YSmk74Nb7r+pXAFCVut
 TILYAgUcRkXnaSIohExD6HsIVYuyre4IPwF8MeAKxCuh592jfdcbL9lZuVW0napGQq7HgVG
 drLbKgJJHp5LL42WkJYY9jeqEr+25RJ5/b6r2wm9Ma6rK9yfRwETWQF9ObKFCfMo+FF5Sbn
 5X9VNpILWv//m8mrK18pWC8itXq+u3u2IGSrQG/Z+HXvr0ye35w5bNW+IQ0w==
Received: from lap7.sapience.com (lap7w.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by srv8.sapience.com (Postfix) with ESMTPS id 7AEDC280576;
	Thu, 30 May 2024 09:36:45 -0400 (EDT)
Message-ID: <15a0bbd24cd01bd0b60b7047958a2e3ab556ea6f.camel@sapience.com>
Subject: Re: 6.9.3 Hung tasks
From: Genes Lists <lists@sapience.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  pabeni@redhat.com, johanneswueller@gmail.com
Date: Thu, 30 May 2024 09:36:45 -0400
In-Reply-To: <9d189ec329cfe68ed68699f314e191a10d4b5eda.camel@sapience.com>
References: <9d189ec329cfe68ed68699f314e191a10d4b5eda.camel@sapience.com>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-qbG4pyrmHWxUgOTNQHox"
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-qbG4pyrmHWxUgOTNQHox
Content-Type: multipart/alternative; boundary="=-g1Wi9ash6TmDBQLLwDML"

--=-g1Wi9ash6TmDBQLLwDML
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2024-05-30 at 08:53 -0400, Genes Lists wrote:
>=20
>=20
This report for 6.9.1 could well be the same issue:

https://lore.kernel.org/lkml/e441605c-eaf2-4c2d-872b-d8e541f4cf60@gmail.com=
/


--=20
Gene


--=-g1Wi9ash6TmDBQLLwDML
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
</style></head><body><div>On Thu, 2024-05-30 at 08:53 -0400, Genes Lists wr=
ote:</div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left=
:2px #729fcf solid;padding-left:1ex"><div><br></div><div><br></div></blockq=
uote><div>This report for 6.9.1 could well be the same issue:</div><div><br=
></div><div><a href=3D"https://lore.kernel.org/lkml/e441605c-eaf2-4c2d-872b=
-d8e541f4cf60@gmail.com/">https://lore.kernel.org/lkml/e441605c-eaf2-4c2d-8=
72b-d8e541f4cf60@gmail.com/</a></div><div><br></div><div><br></div><div><sp=
an><pre>-- <br></pre><div><span style=3D"background-color: inherit;">Gene</=
span></div><div><br></div></span></div></body></html>

--=-g1Wi9ash6TmDBQLLwDML--

--=-qbG4pyrmHWxUgOTNQHox
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCZliA7QAKCRA5BdB0L6Ze
24u+AP9YDJu73eqxoS8KTNr6R4IAxyGJmI+dCtD4HZLf8grcNwD/faRWsT2CWPN+
lLGX3KaqEt8bkCfLRD6d8JukWlMF2AA=
=0xJF
-----END PGP SIGNATURE-----

--=-qbG4pyrmHWxUgOTNQHox--

