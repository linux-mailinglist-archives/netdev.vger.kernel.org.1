Return-Path: <netdev+bounces-194526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A92AC9EB0
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 15:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9338A18936FD
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 13:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE731C1F13;
	Sun,  1 Jun 2025 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="rLoCL4a+"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31B61A3165;
	Sun,  1 Jun 2025 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748785012; cv=none; b=kh6ievWR2y/t0NXRM7EXoRFt5ri2ctZ+8Iq1QDonynuTH7LlRH6tDehpNR0OhhoA4gzKOgwmNRBPGkle+OgGIGSpxoZDOR4yNKeo7LoBcX1Hvx9/Mc1KTMpIpxPEhl4jGA3k49y+V0c1llb1VNjmciq/H+w0TsCnG5YNg9swCDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748785012; c=relaxed/simple;
	bh=Jk5TbG+9N2LPBYT3NISet3CftSkW8GLO4G4VeN2btd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/HwEW9b6ilOPbg+iucu/+8WTSZ85evth8uF52NV3eAg/3uygpRebM8HOtVBDtu0XFVDEDJDKtzJ6to3mSlTxcoS50QHvRHszVGl24XMY39AzTIb8Zp04y0FpiwhZXfS1fmF3nasQdwzmz389qMWqxFZ7/38awe158+fYJYSzmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=rLoCL4a+; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1748785008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6zILuC+fJQ0XHCp2HcwA6LIeh6l7/8sDjGhWTTsieFE=;
	b=rLoCL4a+u7rcjzVNw7BOCDOPvSFqyKolol1d+Mr+uoLOS29EN8Toga/dII26130TqLW4my
	ZifdsG6Yn4ghya8OZFqIegcRPSCTqDslap5P/cNs/Pl//ZCOv/C+0+CKjtb7C0xeBE4Sxa
	9VQRx75GMoUqLn4XbMSfBk1Jo0Wa2gI=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Matthias Schiffer <mschiffer@universe-factory.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH batadv 4/5] batman-adv: remove global hardif list
Date: Sun, 01 Jun 2025 15:36:44 +0200
Message-ID: <2767731.Lt9SDvczpP@sven-l14>
In-Reply-To: <3742218.iIbC2pHGDl@sven-l14>
References:
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
 <bb85858d-b123-45ce-8fae-9658e13b822c@universe-factory.net>
 <3742218.iIbC2pHGDl@sven-l14>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4541340.ejJDZkT8p0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart4541340.ejJDZkT8p0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH batadv 4/5] batman-adv: remove global hardif list
Date: Sun, 01 Jun 2025 15:36:44 +0200
Message-ID: <2767731.Lt9SDvczpP@sven-l14>
In-Reply-To: <3742218.iIbC2pHGDl@sven-l14>
MIME-Version: 1.0

On Sunday, 1 June 2025 15:10:50 CEST Sven Eckelmann wrote:
> So, even getting the parent (see `ASSERT_RTNL` in 
> `netdev_master_upper_dev_get`) of the lower interface is a no-go at that 
> point.

I didn't want to say here that this specific operation is necessary here. Just 
wanted to point out that operating on these data structures might not always 
be possible at that point. This is why I tried to point out that it might be 
better to have something "good enough" using RCU which is managed outside this 
context (write-only protected using rtnl_lock).

The idea of having something specific to meshif that still manages to detect 
(beforehand) if there's a path to `batadv_interface_tx` - while `skb_iif` 
remains set to a specific interface along the way - sounds like an 
implementation nightmare to me.

Kind regards,
	Sven
--nextPart4541340.ejJDZkT8p0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaDxXbAAKCRBND3cr0xT1
y2B/AQCJ/7bJD+rjoCQmz2lOKcFzS3+eddnIoXgnTHyC5k6TaQD/c6W7fxCqe45U
ceQ+DuoPPWrCN6EyZMeEMSJ88E1M0AE=
=njVk
-----END PGP SIGNATURE-----

--nextPart4541340.ejJDZkT8p0--




