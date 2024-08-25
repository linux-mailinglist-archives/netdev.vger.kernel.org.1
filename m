Return-Path: <netdev+bounces-121732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2543595E45D
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 18:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF406281793
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 16:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AA3153BD9;
	Sun, 25 Aug 2024 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="U5tvvkGl"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29E92E636;
	Sun, 25 Aug 2024 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724603484; cv=none; b=MCuMBbOHgP+61AOtNmZeuNje0cjK4QJWcQJyEsrGgc+uxpfVviuWQQ8stQC2SpN1MXllZCkc263lXmflRvFXkiQ0Yd5Ohbc2xxJHr9brU7m3BBiJaFNrrnIBudKccS+0svk5d6C8W8H2bGlA/RmNjuR6AOmRTuD07XkO+hnLYoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724603484; c=relaxed/simple;
	bh=92Dz1fkXnRnMEXcn58jZfdW2YkKTdEzFSQY128vy7KE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipkPDUIvgga4S6QZCSF0teJ7zblrtKmniERIyoQ1D03CfPlZhve9GTGsdq8z4eLABuudvYnK4+hPjFKIT/5H1dVVd/J4GwK6yWCJ85YSaK+0VAHH5Vl65S8yw22Zuwtixpv7gEGgTWDULH8cc8RNAToBqTePtQwhZnPtgUGkbmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=U5tvvkGl; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1724603042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/0CVHEKDJQyYWXwIbOQUlthvfXsND9N1ahK4smTqQ0=;
	b=U5tvvkGlfI6OBAY8Wz4LUP+Z8uR5hNZyzLXiS7vFNvvx31EUjMDofXUubr8axmBJBtZFPT
	wl1Ehve6XMHlC7A48DB2zyufLuREtd2O5e5zM5uV/yFCDtkciQhXXyKyMAjJZujAFSFl0m
	YZv/gixXtw5t8M5TCyFGIOudVjwA33A=
From: Sven Eckelmann <sven@narfation.org>
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, Xingyu Li <xli399@ucr.edu>
Subject: Re: BUG: general protection fault in batadv_bla_del_backbone_claims
Date: Sun, 25 Aug 2024 18:23:54 +0200
Message-ID: <13617673.uLZWGnKmhe@bentobox>
In-Reply-To:
 <CALAgD-7C3t=vRTvpnVvsZ_1YhgiiynDaX_ud0O6pxSBn3suADQ@mail.gmail.com>
References:
 <CALAgD-7C3t=vRTvpnVvsZ_1YhgiiynDaX_ud0O6pxSBn3suADQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2986161.e9J7NaK4W3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2986161.e9J7NaK4W3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 25 Aug 2024 18:23:54 +0200
Message-ID: <13617673.uLZWGnKmhe@bentobox>
MIME-Version: 1.0

On Sunday, 25 August 2024 06:14:48 CEST Xingyu Li wrote:
> In line 307 of net/batman-adv/bridge_loop_avoidance, when executing
> "hash = backbone_gw->bat_priv->bla.claim_hash;", it does not check if
> "backbone_gw->bat_priv==NULL".

Because it cannot be NULL unless something really, really, really bad 
happened. bat_priv will only be set when the gateway gets created using 
batadv_bla_get_backbone_gw(). It never gets unset during the lifetime on the 
backbone gateway.

Maybe Simon has more to say about that.

On Sunday, 25 August 2024 06:14:48 CEST Xingyu Li wrote:
> RIP: 0010:batadv_bla_del_backbone_claims+0x4e/0x360

Which line would that be in your build?

On Sunday, 25 August 2024 06:14:48 CEST Xingyu Li wrote:
> Syzkaller reproducer:

At the moment, I am unable to reproduce this crash with the provided 
reproducer.

Can you reproduce it with it? If you can, did you try to perform a bisect 
using the reproducer?

Kind regards,
	Sven
--nextPart2986161.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZstamgAKCRBND3cr0xT1
y9x3AQCI8h/Dcc3iVqqa0XiVgpP7ecJxHatYGydBR1RH46HCcwEA997cKeW4kX8v
myVNLA90kDo9mmb3MHmOmn0BjgJhrQM=
=Z8g1
-----END PGP SIGNATURE-----

--nextPart2986161.e9J7NaK4W3--




