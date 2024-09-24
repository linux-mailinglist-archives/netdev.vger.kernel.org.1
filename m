Return-Path: <netdev+bounces-129451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E4B983FA9
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 09:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DD81F24089
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 07:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4CA4EB38;
	Tue, 24 Sep 2024 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FxMbFv6/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE6126C15
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727164140; cv=none; b=esxpCqzm2nPAC3OQOqwz6ertySds9ASWGP/srT0qwbRHYnpyYGlE70RwN0lt2mtvdnIvsx4U5wYeMOpda7aJGtLV9yeVWcVMexWi8JiN5+XYYjTRUGCdGShfCxxpyVZRCh7g7/SMfUjxilC8Pp0riy+uvGdffZZrNhf3MG85jv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727164140; c=relaxed/simple;
	bh=SJ9LrZFumI2fBt5xrrFDFhzDupHIUTJ4xI5MEoBoP68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIn/yhmRRuhZDw+nqE+N0ITz4oSsciSglP6cWDhB3s3FkXcEMM6LeuN6S4Xv4e22wt68kXt015s+113Le+dmuB3IPxelAV8WVRyq0rTry736aXYPOQDxjrLI98c3WM5tt8TPp4txsaGYMd8euY6EV4cDYV6HR7UWouXT3hAHHeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FxMbFv6/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-378c16a4d3eso5606724f8f.1
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 00:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727164136; x=1727768936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fYxBfIEgRGwnch1amoY5GN+OdaV2ORH8f4YP2+lCu90=;
        b=FxMbFv6/0nSMoB+Na0b4FVAGZiv+zU9Fw6Ex0LgnQoifH1FiNOmGpPkwepqDTyKd6b
         gScej1/yBnhVfkvhF9Nqy/GkRk4TLjeZE7rXnL2akFDC/Ka8WwwuTrBt9y/Nks91bIlT
         5mKzULY8UcThJea+WRdadbPUu31bDcnohpBjw8zZVCERabdr+jN3dZKcUpMtLj2wgzf1
         2TLRnHNjV/3GZjVKKaFGLUar5t1Z+/UvfQm/ko5Ntyzoperm6IAcfzOQRDrIekBMXBrh
         GDbZlhOIEohWHOkIHF4bV7Fccss8EFEHkgiYvR+ljwjCUnfQqZS3X8MwrhsPLyrona6L
         qC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727164136; x=1727768936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYxBfIEgRGwnch1amoY5GN+OdaV2ORH8f4YP2+lCu90=;
        b=Ug9ZB/DGYQOAw5ygOdaIQwRV0sOetPgS2uM9XBeCpu6X/mWAMJSiKwPfQdZ6n2Wbw9
         Rxl3+AEG/GMu1nroqLH7HNZF4fMqP/5bCHTrgUeVVyBkj1hhoGm+prO2kO9dceIcecmI
         v0ItPViTvHEjiRx6xjhTgmp19ak0dFziCSIffMNbd/wFZy+btuMkiWJp6mv9AM9ZT1Wk
         vjOTJ+N4d/RQOEP3/COl/Vb+vndKBDUkgsbEvyvgbVcP4TZYo2+y4SeF93G1R633MEnO
         PIuE6ouCsobAWlWAEzo4uwAKz8wOZi8045qUmUcefdsQH4SFthFHheSPRvE+aAp4MTRr
         8lxg==
X-Forwarded-Encrypted: i=1; AJvYcCUD8G+0g7xGaJXOlF2y24P50DEtIj3XpDMeUXEciM8xenjqvyS3t6ca2g6IqWVNU/j4mYyQywo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy17GvKZrl8U8cgGY7FXhZxPiv3EP8pYcJ+486d03UJLE7FnIlf
	/qzBf0aa2uvM0Hj28ohcUW9e5G25c3lUCql5aAROaRQiz5mjXgAWNCjvsrjmac8=
X-Google-Smtp-Source: AGHT+IEcRr0QRVwfQeflZi22f0TJYAEF895jKRug0RP5vK6DkeBxkOm9Gtf+nyeMAsGAp066sqEikw==
X-Received: by 2002:a5d:47cb:0:b0:374:c44e:ef27 with SMTP id ffacd0b85a97d-37a42253416mr13741187f8f.8.1727164135819;
        Tue, 24 Sep 2024 00:48:55 -0700 (PDT)
Received: from localhost (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2f96d7sm845309f8f.78.2024.09.24.00.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 00:48:55 -0700 (PDT)
Date: Tue, 24 Sep 2024 09:48:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: Switch back to struct
 platform_driver::remove()
Message-ID: <3y5dni2ey2hnzie4evmklqcu4uhr72fr64m47uwzo7nnhbqzsz@7igypikspxpm>
References: <20240923162202.34386-2-u.kleine-koenig@baylibre.com>
 <20240924072937.GE4029621@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ht5hxnducdxn75gu"
Content-Disposition: inline
In-Reply-To: <20240924072937.GE4029621@kernel.org>


--ht5hxnducdxn75gu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Simon,

On Tue, Sep 24, 2024 at 08:29:37AM +0100, Simon Horman wrote:
> On Mon, Sep 23, 2024 at 06:22:01PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > I converted all drivers below drivers/net/ethernet in a single patch. If
> > you want it split, just tell me (per vendor? per driver?). Also note I
> > didn't add all the maintainers of the individual drivers to Cc: to not
> > trigger sending restrictions and spam filters.
>=20
> I think that given that the changes to each file are very simple,
> and the number of files changed, a single, or small number of patches
> make sense. Because the overhead of managing per-driver patches,
> which I would ordinarily prefer, seems too large.

full ack.

> However, touching so many files does lead to a substantial risk of
> conflicts. And indeed, the patch does not currently apply cleanly
> to net-next (although it can trivially be made to do so). Perhaps
> the maintainers can handle that, but I would suggest reposting in
> a form that does apply cleanly so that automations can run.

I based it on plain next in the expectation that this matches the
network tree well enough. I agree that the conflicts are not hard to
resolve, but it's totally ok for me if only the parts of the patch are
taken that apply without problems. I expect that I'll have to go through
more than one subsystem a second time anyhow because new drivers pop up
using the old idioms.

Also note that git can handle the changes just fine if you use
3-way merging:

	uwe@taurus:~/gsrc/linux$ git checkout net-next/main=20
	HEAD is now at 151ac45348af net: sparx5: Fix invalid timestamps

	uwe@taurus:~/gsrc/linux$ b4 am -3 https://lore.kernel.org/all/202409231622=
02.34386-2-u.kleine-koenig@baylibre.com/
	Grabbing thread from lore.kernel.org/all/20240923162202.34386-2-u.kleine-k=
oenig@baylibre.com/t.mbox.gz
	Analyzing 3 messages in the thread
	Analyzing 0 code-review messages
	Checking attestation on all messages, may take a moment...
	---
	  =E2=9C=93 [PATCH] net: ethernet: Switch back to struct platform_driver::=
remove()
	    + Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com> (=E2=
=9C=93 DKIM/gmail.com)
	  ---
	  =E2=9C=93 Signed: openpgp/u.kleine-koenig@baylibre.com
	  =E2=9C=93 Signed: DKIM/baylibre-com.20230601.gappssmtp.com (From: u.klei=
ne-koenig@baylibre.com)
	---
	Total patches: 1
	Preared a fake commit range for 3-way merge (77e0c079ace8..198dd8fb7661)
	---
	 Link: https://lore.kernel.org/r/20240923162202.34386-2-u.kleine-koenig@ba=
ylibre.com
	 Base: using specified base-commit ef545bc03a65438cabe87beb1b9a15b0ffcb6ace
	       git checkout -b 20240923_u_kleine_koenig_baylibre_com ef545bc03a654=
38cabe87beb1b9a15b0ffcb6ace
	       git am -3 ./20240923_u_kleine_koenig_net_ethernet_switch_back_to_st=
ruct_platform_driver_remove.mbx

	uwe@taurus:~/gsrc/linux$ git am -3 ./20240923_u_kleine_koenig_net_ethernet=
_switch_back_to_struct_platform_driver_remove.mbx
	Applying: net: ethernet: Switch back to struct platform_driver::remove()
	Using index info to reconstruct a base tree...
	M	drivers/net/ethernet/cirrus/ep93xx_eth.c
	M	drivers/net/ethernet/marvell/mvmdio.c
	M	drivers/net/ethernet/xilinx/xilinx_axienet_main.c
	Falling back to patching base and 3-way merge...
	Auto-merging drivers/net/ethernet/xilinx/xilinx_axienet_main.c
	Auto-merging drivers/net/ethernet/marvell/mvmdio.c
	Auto-merging drivers/net/ethernet/cirrus/ep93xx_eth.c

> Which brings me to to a separate, process issue: net-next is currently
> closed for the v6.12 merge window. It should reopen once v6.12-rc1 has
> been released. And patches for net-next should be posted after it
> has reopened, with the caveat that RFC patches may be posted any time.

This was a concious choice. Because of the big amount of drivers touched
I thought to post early to have a chance to get the patch applied before
the gates are opened for other patches was a reasonable (but I admit
selfish) idea.

Anyhow, I can repost once the merge window closes.

Best regards
Uwe

--ht5hxnducdxn75gu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbybuMACgkQj4D7WH0S
/k7gcQf/d8Dgf08dU7y7sAWtpikRXYYQUXKt7xrHVWk1Zu82GOHqqEGAP0tMCmO3
OUi8G9WzYV/K7w5v4CqXliY9mbmpo+oDaHYyY7lgk2nv2zWlyC+rxf4TmOZI6UwL
xBaXuyla1dlC6gcNFBDO+mHPlFWJuwxz/ubR9+0bKsOumJjpVVvWAypzGe0SB27W
wimiEeUMOV0I3PfnRkq7F/dWtfQgYfQ2wdsBQ5X+zeZNMlxigsLusGObQNPqcPLb
8rH2gHVgdKi6tMSGrCWp8Pe9/cRs1XLRgEy8HlnE9DhI95yR//8wmlp6B54IVd0V
qrtQMybc+NUXdKVSY5N7yNv2mHUfhw==
=1iWY
-----END PGP SIGNATURE-----

--ht5hxnducdxn75gu--

