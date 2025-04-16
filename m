Return-Path: <netdev+bounces-183331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E20A9061E
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67089168891
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05BF1F9A89;
	Wed, 16 Apr 2025 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="JLKUSSSr"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988811F8724;
	Wed, 16 Apr 2025 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812983; cv=none; b=SkzMMyLWr2Dl1pwfwoOxJUA5EGLAbFQpogQQQUdkxAA/ZFNxDke6T+TPJRuqmaS1r1oUN18yeSr2TlOo1u0o5Eb6P37mRoyhgGkKphs3CV0pkk39AXnxnJxNLZgQrkdiveGw2u5ZoxV2/rLjZBFQbwmrnEI8qkuC+ASEKiH1d20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812983; c=relaxed/simple;
	bh=7Axh52coiOI0JKbFKrbXVFHvbqfMz5ZjGnycArF5irU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X6DfWKppLklFgiI3YRQ4TTIuj7zHGaFAzzwO6LhVng5Dq0DLtL6sWP4DNw7Q2/RfJV+l/Dh9ANe0d/ATFqupf4NAOpEwUGbXKZ+kadC7wessO2K+hdrt6ffuyqXODfpFBoC82sKVYCfgtSuWZZTzxGU3vgfRyuFxVilEUza4a20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=JLKUSSSr; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1744812946; x=1745417746; i=christian@heusel.eu;
	bh=tKvDn5Ua0J+JdrBJCtSOPWhyIypPlWKpqTtOxhNcG2E=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JLKUSSSrz57grczY/IZYd7uOZ/KZDhu2LfCe/yBsTCeypwCvcYqZO4gThZLLCi2N
	 AkLRXfdUHzystbaQPbnHZPo4SHmeyX6MfsnYTaaMzKSsrcpyuI+x20RR0q7BH+da5
	 CK7KoJw0NcHNkWIgr3ZzJ26yjZOkSpIZzAGEiffdxX5OFyHHAD+kSCRetvlesgq6N
	 9LmNCOJuKTKJQUJuWnDk8BHdyOPO4gJzGvq/h6CHhBRt+mbyTDJYc1iD5L4LYgsgI
	 b6e59USXtHtmwtz1jQmoiwlGKQSAyuPpzSTdFuVoyJFadq+cRwG4QVk5Nrr6mXBM7
	 oXMJD18jw2Xo3NzrqQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([80.187.65.171]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M5wTr-1txbQn1gQl-00Ahgn; Wed, 16 Apr 2025 16:15:46 +0200
Date: Wed, 16 Apr 2025 16:15:40 +0200
From: Christian Heusel <christian@heusel.eu>
To: ubomir Rintel <lkundrak@v3.sk>, Jakub Kicinski <kuba@kernel.org>
Cc: michal.pecio@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: [REGRESSION][BISECTED] USB tethering broken after 67d1a8956d2d
Message-ID: <e0df2d85-1296-4317-b717-bd757e3ab928@heusel.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dpdgofzlybgncae3"
Content-Disposition: inline
X-Provags-ID: V03:K1:M1cGX4HvEWB6CveN0yndWMzqbLMNgEtlLw4dlX+1LMpDNhPo/3U
 h97aHpaX2K068ENHwSRaQ+VmNPOjAVTnOXbKzbcbGhZEwIw4hnVzz1VvEk1yBA9yRu4jxdP
 MRwHAKr+nEv0ynx2HoldplTwkSiMWf8wBxk7A40kVDADeLnWJt9mAORhS+xWG/caHmAHxE9
 mrlkIWU4Dfe34gk3liLaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g7VIWmAnTB4=;aOXjj6VplxltSQP2SQCN/TnO6Bh
 Oc5YXd5y1iSsI8mPE+b7A3rKVerMgoqMnvuekqA1DRy0+suUtQrtt/Ki3piTFON8Xk+q+NtuI
 Bkbmz88oqMZeEA0ioXSLHPNd0kuxjoDTD+Is4UCrtEUl8MYbTYEjvGWViNMm/ND+SA/LdWvXa
 04/JCnFSCe0TaVIP1pAda9aJ+FV5Lbja6akDMJC6DDY/CYaCi8991dweYrSgqE9VDkLiqdaMb
 RAz3yJZ3DuBkIEZ8BHGPL7Lu39R/UYXS0ZqMo/EASaKoT/mksUdQZE6xKRpXbyxCkMCo0MChQ
 J2MAME2BUsOVvUlYZgdnJ3A2UVz5B1iH0Z5DblVl/ZLPlNsZNi8YKkp1bYFhYDm6TVogOZCxG
 00Rzu4Fhfgll474I/25+gkdgAFj9cB1nD0fEBRvZjfr93CNiih09Zs5GEL7162pMHZjBKMo5e
 VFbxzmPoOgLonzLUOPpX3TS2y8+PF/3TszSA6C7Sjxbg2XqJAw814osmaQbbtlhEg5ws4Pvqz
 b/umLLy18GSj70y8Bp/FCLl7FNeC9YiMfLFuUdquDu5NN3trvnZLclPE4gDK+zutwqad3WEST
 /JZbPierTG+8+15ItM9e1ldHzC7UzAwSrZc5PknVsTC2rSBRLZ7MISwXgO+o6Gw0rGGgkBpbm
 yi2b6I8S+aRvZ8pXHS1MCOrEqTpwh5LdXzBiEKYXvT2zfk0CCJayLFBifY25q2SznbJV9RY8P
 95fZ5Mu1LRhuPwW7AUQLQGoESWX5DcpGaY2c866BTT5gqtDbuhDFXDi/mVN/HcMQaDbHcVty1
 3owisgkbZA3WzDeEdZQKtMLMwkyxro9RE/A295OJlnNKBt9dsx2qZc7iAfRgascGgZbZhqxBl
 mVynxIMEQgpEbfeKrL+dglRq2Pd4U1eWmRHH3DJw4evdLSpAK13NullIVZFYD1ty/ZDBoVDLP
 GCeR9zGjWk5XWRA4NQNPMYtbRxiY5CJmna/tyopbLYhRX7o1is5EQ8SbR8RHFRu3v+vhvepJI
 nn9ffoYjwVui/EdaTkbOqsbnxmVKDXMs4KAOHbAJz92n5r8DSXJw1CXE1TEAfJwdOht10qSCH
 qwIFdTThPh0jsdNjtnDBxLn9WkEPF7NkqlbFY6fqeV00+98tUau0K2CeI9rzfEg9Lh4+gcTAD
 opb8iOp/TQw81G9BzgcNcwxFjyRu5b5K+wew3zETfH/9bQPmeSIo0mkd2k8goS7o8Mng9CSmI
 vaN9EeZMfjb/6OA2ReTwx/PgKh060ZCRX4NKMwmBGGEKR4bJKzD99k8GrfLTs95lAbspXHOS7
 N2KC9soLh/JQRU+jny4Z5o6oO8MmfBkg8dCPQH3O4wN2bsKwaJUEY99TQkEajfvhXuVv2yknf
 XTu9lfaZ4xUiN6Buc/lR+CcG5G7g8YHx7xrE8=


--dpdgofzlybgncae3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [REGRESSION][BISECTED] USB tethering broken after 67d1a8956d2d
MIME-Version: 1.0

Hello everyone,

I have recently noticed multiple issues popping up in the Arch Linux
Support fora and in the Gentoo bugtracker (see links below) where people
could not use USB tethering anymore after upgrading to 6.14.2.

Micha=C5=82 Pecio on the Kernel Bugzilla eyeballed the issue within the
mainline kernel tree to the following commit (that was backported to
stable):

    67d1a8956d2d ("rndis_host: Flag RNDIS modems as WWAN devices")

The error is still present in the latest mainline release 6.15-rc2 and
reverting the culprit on top of mainline fixes the issue.

Also the issue (as stated above) is already reported on the Kernel
Bugzilla but it seems like none of the actual developers has spotted it
yet, hence I'm amplifying it to the mailing lists.

I have attached a dmesg output from a good boot (6.15-rc2 with the patch
reverted) and one from where the failure occurs (regular 6.15-rc2). I'm
happy to test any debug patches or provide more information if needed.

Greeting,
Chris

---

#regzbot introduced: 67d1a8956d2d
#regzbot title: rndis_host: USB tethering broken
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=3D220002
#regzbot link: https://bugs.gentoo.org/953555
#regzbot link: https://bbs.archlinux.org/viewtopic.php?id=3D304892

--dpdgofzlybgncae3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmf/u4wACgkQwEfU8yi1
JYUweA//fIBxW7+VlDgryoJTXkcwMN+yqBtXA5y6rbEGziJlPoTkPscIY1WxKCge
DmGmuExalZTmOKJrECUgpg1bvDOt+ykXcZuih058lgSUwXGcijDww7m1+rEcRjQ7
WMenwzpEtK7EQ1hgVkm8dxrHW2XjDDT4rrm18W/Ne0KDoUzfvAUP1xqnF6VJ7H7u
tB2F5lEhN2qHq7Ax9+Fh3Rb3BcNEn/niz0tysMn2FJTSXFujDaTcuUUqh9Kfrq3a
i2OM4cPE9kI2IO8yka2s5W5Z16Srl0Y+ljXo3shjiNoUV1CPRlJen+3PYuT2xfq7
iKLqEBkrbTep7SfNpDSKiDvt2LsNy3uJePXtMyzLkt9wV7vnhs2J5Dq5Wt7EpZV0
NjfTCWx8Syl/YbL1NqvwIoZn5D3eVWprdVz24b6rZf4dRK3itBnFG9uRt4LBN4aZ
bfyWxIpCkIyEBLiqCfgrl/ya57rto0rvrY4PUuFDIyuVfdQhkrk9SASQ2gxt2TPE
K4CJkMbBteYzRlkBSWokJPL/EvU1C9cCIo90K8QH35wGUYcTeV8d84tcEfNKgxES
SO4yTWlG7Sh4w8pimjQsNGvLN+IXoVo1ZZRJik7Y6bpBLjHZqdOhblHoQwiYGxrp
edj/rbJnGDH/bfLPyXvwS4rR/bEUAwiyTIUlGgT4V3y9Fkfg6aA=
=JY64
-----END PGP SIGNATURE-----

--dpdgofzlybgncae3--

