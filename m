Return-Path: <netdev+bounces-89426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA318AA402
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 22:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF561C20C06
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B7616D314;
	Thu, 18 Apr 2024 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=a16n.net header.i=@a16n.net header.b="e2RHoD3G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out.a16n.net (smtp-out.a16n.net [87.98.181.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C2A4503A
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.181.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472021; cv=none; b=LgQW8h0AxXMOnNQlTD2ovuQIqw+wsUm3x+6xgXUjpSw/WEeRW5Lw8m6haUSwIuM2x2Y/TWpMPwfChM/6XftX42Fxea2cD17lfSi66bIg8AOsG87vvMY/FbxhBBCiBAozrDjrWImclAq1R03QLAqQb1qDRPPp5mMt1/MzTdbARBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472021; c=relaxed/simple;
	bh=zSQOTJ8tz/NF4BDPwrs6odb9Gsa9y+UoyTAI4gqbQeQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bf7WH1eLeF1240ryevKkKUOQfIkOJFOorrTooaufqpLjPQ/+Z/et/nM+XAV4w6MqRR2iI+dMlqXB7/XuIpLlDE+przStmIU4lpeGCQZwT2pLlYXVRFGl2lAak5du2IY2O+TebcdrlS+CxSySWBwx2HA4HQ5LB56hQG0GiecJqo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=a16n.net; spf=pass smtp.mailfrom=a16n.net; dkim=pass (2048-bit key) header.d=a16n.net header.i=@a16n.net header.b=e2RHoD3G; arc=none smtp.client-ip=87.98.181.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=a16n.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a16n.net
Received: from server.a16n.net (server.a16n.net [82.65.98.121])
	by smtp-out.a16n.net (Postfix) with ESMTP id 9F98646049A;
	Thu, 18 Apr 2024 22:26:53 +0200 (CEST)
Received: from ws.localdomain (unknown [192.168.13.254])
	by server.a16n.net (Postfix) with ESMTPSA id B23D280105E;
	Thu, 18 Apr 2024 22:26:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=a16n.net; s=a16n;
	t=1713472013; bh=LfZWQsrQtgzKC/YWLBnJHi5tFb7Y5iiPMA7i9wXMaiU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=e2RHoD3GGDPOe7Evv3KkYLx2cPge58C5aZOGcb1s3QcorZJEG2NbzYZm9EpNlgxdg
	 Fn08WKoqnrepW7WAyh8MIKTS14ZH3M1Mecw5Bx63pMVXB1ppkRimh9lCTtGak2dnXv
	 fJTaXXVNZ1O+GQ3JuieXhFCD0BvfkCgY45MYlr4wdcqEJI5HAiK1raLTtQ3yKoApSp
	 oQFhRmYu+DlrHSRh8VAbpiZFXAJNrgjDePCH4nCZ3Iutv8HdSiydKPFGyHgJUm1jsv
	 Bjqqf2UmFzs/Z3gGkDpP8ggOLlpUvK2VFObSaVUKIR2vNmVv+7iKZDzA3V2WlimkV+
	 31SiRXqEH8dlg==
Received: by ws.localdomain (Postfix, from userid 1000)
	id 832E220708; Thu, 18 Apr 2024 22:26:53 +0200 (CEST)
From: =?utf-8?Q?Peter_M=C3=BCnster?= <pm@a16n.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,  Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net] net: b44: set pause params only when interface is up
In-Reply-To: <e5d3c578-6142-4a30-9dd8-d5fca49566e0@lunn.ch> (Andrew Lunn's
	message of "Thu, 18 Apr 2024 20:55:57 +0200")
References: <871q72ahf1.fsf@a16n.net>
	<e5d3c578-6142-4a30-9dd8-d5fca49566e0@lunn.ch>
Date: Thu, 18 Apr 2024 22:26:53 +0200
Message-ID: <87wmou5sdu.fsf@a16n.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18 2024, Andrew Lunn wrote:

> Please include a Fixed: tag indicating when the problem was added.

Hi Andrew,

I=E2=80=99m sorry, I don=E2=80=99t know, when the problem was added. I only=
 know, that
there was no problem with OpenWrt < 23.X. But I don=E2=80=99t know why. Per=
haps
the behaviour of netifd has changed from 22.X to 23.X.

So I guess, that the problem is there since the creation of
b44_set_pauseparam(), but it has never been triggered before.

So what should I do please with the Fixed: tag?

TIA for any hints,
=2D-=20
           Peter

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iGoEARECACoWIQS/5hHRBUjla4uZVXU6jitvQ7HLaAUCZiGCDQwccG1AYTE2bi5u
ZXQACgkQOo4rb0Oxy2iu4QCeOa26va6PmJ4lG+hb6DHQkc06qfcAn0n4UghDJOZb
888T/rmyO9I0Rjm6
=n/4w
-----END PGP SIGNATURE-----
--=-=-=--

