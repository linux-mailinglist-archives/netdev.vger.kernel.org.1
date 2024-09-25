Return-Path: <netdev+bounces-129678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFD09857A1
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 13:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3CD5B2381C
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 11:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091CB146A6C;
	Wed, 25 Sep 2024 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mlj1hwrP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444AD482D8
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262452; cv=none; b=H0JQu7FrHGWVnQP0R4ioUESCoOiDpn1ZzY/1PuRgn7lZs95fPq82UaLQMP4J6UcabI0qWe9CK3czw7BL2Av0IutYuYJ6msANABV950dBLgGyl7Z9mXWr2iVkzh8SUanCG9XGLXBfHxIhQnIfjqJuuH+HHTcSh5DSRwyKQA2hEjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262452; c=relaxed/simple;
	bh=doJJL62Fku78LVlMUqKSPeTq8cbJi/J4DtQLAQZPf+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cH2RVKWNOhnVvioCBuPKdR6uIkrnWYwl7QqYr6MpGEMJe3nAbjKIuHjBO9K3m1/Wl8yPaGiYsJurjwBEF2iqjoRP71ctyKkZdgoLSZWptqobipsFtb/KuIeZjb0mULj8T0R6rzIPTc35Ec+yL5zvOsheLIshdlNnyeevi71B/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mlj1hwrP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so63080405e9.0
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 04:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727262448; x=1727867248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E8B+PeSxDq5nzcAcOKFUlOoqS2BhF06trzZQ3kNoJ8A=;
        b=mlj1hwrPqAzeHCV3/OxH+AFJeRyyU6m+k6gSpS0xhzSybVoin7c5FZnmdeaJyQxGex
         OBMZQQ0v3yI4HOm2n0fmv26s86DznCJ33dv6g26fFZspUJR0KdPmB1+rLwUD5dAIwaMN
         DS5t7PmifrJIAMp9IOq4DDQNzhaSndnIzsUiMYVkYV2qLQIjlg1BIja0CJd7myBe1GuC
         X+iXnv9xNF/qzeL/fDINj7nW6z8z6otkpqdExiDIHdz+wCeBWk9aSOdbVuavFSM5OGJC
         fU6mhx+68knbmVEVSthoSQgic58sLMFkMXKqqwolddR2RwHBu/aLCr7t80vw8Rd1apfb
         Fzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727262448; x=1727867248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8B+PeSxDq5nzcAcOKFUlOoqS2BhF06trzZQ3kNoJ8A=;
        b=mne/Nmob7TQhvV2ySNox7Jjj8/2R3aTJ6f/RO00aaOvb7gAVJCJd3jeGSa2GVLut5B
         dGhLqtta4hWLNSF22u2HHTVgw4tplsCxXzgCQsuRkF6nagkm6AJs/ZtnEYhpMfU6zsus
         VlWLIlVQmRT08n+NQ76kI5raqOd4H6h3Na1bavzuuekDS0m1ix8nOg5dwfBjd6VfBdjF
         rIJ1KkV0yKuo4yVMV3w/4QHFQ4ailZTxwDmAXzJvvMHiEwGGzQH3WomO9ZoQD3xamsiR
         HdU9NFksXgypzmfY7WIau758cQ9xaE8RXPt2Q5TW0NY8cgisSgOesNzRuRyfvZo8Ft/r
         RTvA==
X-Forwarded-Encrypted: i=1; AJvYcCVJqCM4s4RP4TY2JhCiTYR+HYGUkKq09xUFqdzbJJn1j2VYnqL2XMOg8FElTIp00qGxzmLzqBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd9K4On/+D6T5ydBsfuJFtvr5r4FpssSi/Kqb7zyHyNy3wO9/M
	GPLp7qJ8/4KGlcnl777+d0IM7Oa/oXKhRnVcSpd/OA0aWLPqHsxBkbbSi/dMn2M=
X-Google-Smtp-Source: AGHT+IF1YYrzob5VeQv9jIkehYP1A+cs/tAUuIBnP9/5NQeHmGJe253SeqXnruyN/Yrchk3iHZWtjQ==
X-Received: by 2002:adf:f243:0:b0:368:68d3:32b3 with SMTP id ffacd0b85a97d-37cc248c283mr1481003f8f.26.1727262448127;
        Wed, 25 Sep 2024 04:07:28 -0700 (PDT)
Received: from localhost (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2c1eb8sm3661523f8f.42.2024.09.25.04.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 04:07:27 -0700 (PDT)
Date: Wed, 25 Sep 2024 13:07:25 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: Switch back to struct
 platform_driver::remove()
Message-ID: <2og4furukr5fndyx3receaxr2rgao27lcuzofcvanyrt543p5p@5ckfz4373vhm>
References: <20240923162202.34386-2-u.kleine-koenig@baylibre.com>
 <20240924072937.GE4029621@kernel.org>
 <3y5dni2ey2hnzie4evmklqcu4uhr72fr64m47uwzo7nnhbqzsz@7igypikspxpm>
 <20240924125347.GI4029621@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="njzzzopceuilp5m6"
Content-Disposition: inline
In-Reply-To: <20240924125347.GI4029621@kernel.org>


--njzzzopceuilp5m6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Sep 24, 2024 at 01:53:47PM +0100, Simon Horman wrote:
> On Tue, Sep 24, 2024 at 09:48:53AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > On Tue, Sep 24, 2024 at 08:29:37AM +0100, Simon Horman wrote:
> > > However, touching so many files does lead to a substantial risk of
> > > conflicts. And indeed, the patch does not currently apply cleanly
> > > to net-next (although it can trivially be made to do so). Perhaps
> > > the maintainers can handle that, but I would suggest reposting in
> > > a form that does apply cleanly so that automations can run.
> >=20
> > I based it on plain next in the expectation that this matches the
> > network tree well enough. I agree that the conflicts are not hard to
> > resolve, but it's totally ok for me if only the parts of the patch are
> > taken that apply without problems. I expect that I'll have to go through
> > more than one subsystem a second time anyhow because new drivers pop up
> > using the old idioms.
> >=20
> > Also note that git can handle the changes just fine if you use
> > 3-way merging:
> >=20
> > 	uwe@taurus:~/gsrc/linux$ git checkout net-next/main=20
> > 	HEAD is now at 151ac45348af net: sparx5: Fix invalid timestamps
> >=20
> > 	uwe@taurus:~/gsrc/linux$ b4 am -3 https://lore.kernel.org/all/20240923=
162202.34386-2-u.kleine-koenig@baylibre.com/
> > 	Grabbing thread from lore.kernel.org/all/20240923162202.34386-2-u.klei=
ne-koenig@baylibre.com/t.mbox.gz
> > 	Analyzing 3 messages in the thread
> > 	Analyzing 0 code-review messages
> > 	Checking attestation on all messages, may take a moment...
> > 	---
> > 	  =E2=9C=93 [PATCH] net: ethernet: Switch back to struct platform_driv=
er::remove()
> > 	    + Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com> (=
=E2=9C=93 DKIM/gmail.com)
> > 	  ---
> > 	  =E2=9C=93 Signed: openpgp/u.kleine-koenig@baylibre.com
> > 	  =E2=9C=93 Signed: DKIM/baylibre-com.20230601.gappssmtp.com (From: u.=
kleine-koenig@baylibre.com)
> > 	---
> > 	Total patches: 1
> > 	Preared a fake commit range for 3-way merge (77e0c079ace8..198dd8fb766=
1)
> > 	---
> > 	 Link: https://lore.kernel.org/r/20240923162202.34386-2-u.kleine-koeni=
g@baylibre.com
> > 	 Base: using specified base-commit ef545bc03a65438cabe87beb1b9a15b0ffc=
b6ace
> > 	       git checkout -b 20240923_u_kleine_koenig_baylibre_com ef545bc03=
a65438cabe87beb1b9a15b0ffcb6ace
> > 	       git am -3 ./20240923_u_kleine_koenig_net_ethernet_switch_back_t=
o_struct_platform_driver_remove.mbx
> >=20
> > 	uwe@taurus:~/gsrc/linux$ git am -3 ./20240923_u_kleine_koenig_net_ethe=
rnet_switch_back_to_struct_platform_driver_remove.mbx
> > 	Applying: net: ethernet: Switch back to struct platform_driver::remove=
()
> > 	Using index info to reconstruct a base tree...
> > 	M	drivers/net/ethernet/cirrus/ep93xx_eth.c
> > 	M	drivers/net/ethernet/marvell/mvmdio.c
> > 	M	drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > 	Falling back to patching base and 3-way merge...
> > 	Auto-merging drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > 	Auto-merging drivers/net/ethernet/marvell/mvmdio.c
> > 	Auto-merging drivers/net/ethernet/cirrus/ep93xx_eth.c
>=20
> Understood, I agree the conflicts can trivially be resolved.
> But as things stand the CI stopped when it couldn't apply
> the patchset. And, IMHO, that is not the best.

So there is some room for improvement of said CI. It could use -3, or
alternatively honor the "base-commit:" line in the footer of the mail.

(And yes, using net-next directly and getting the patch applied quickly
works, too. And I understand that is most comfortable for your side. For
my side however plain next is better as this is usually a good middle
ground for all trees. And given that I have to track not only the 130+
network drivers from this patch but also the 2000+ other drivers in the
rest of the tree using net-next doesn't work so well.)

Best regards
Uwe

--njzzzopceuilp5m6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbz7tkACgkQj4D7WH0S
/k6L9ggAuspmx15wp+V9Fyqt6oQNieL0oCV/R7nemqTSN30ktFDQRAnSSHaHQJHT
BC7ebABQ3NdgHO9O4dSrs0kRy1dR4rqeJ9x4aTsxC9jXOV3FOYC/DZLlfe+llyQe
VptQLZHxOVXbAHXeB3tnhLmt3LaqX2G040J0Y0rgCyl4AuSSP/5MBHpmOK7c1tDG
oYACgfxHdIfZR5vTLGn5X7lyMmM5kbp/IC/G/kY2WpZ7e5ki3tNTw7Z4aLjVzmf0
Deg537lXB5QuRtg1ZT7gI7AzPcqAziZM0KpCx+9QsK11uqYF9gXgF02GU6YNx/e3
KPTq8eIwXjq6p6XyROMTd6cCMcGRtA==
=ocYS
-----END PGP SIGNATURE-----

--njzzzopceuilp5m6--

