Return-Path: <netdev+bounces-194492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1256AC9A65
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 11:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F464A1820
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 09:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B4F238C3F;
	Sat, 31 May 2025 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="s4JsNElf"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EEE238C39;
	Sat, 31 May 2025 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748685561; cv=none; b=UtNfnA3gyLrmZal63m7s0B4Z7Md3AjiIPpimxBlRRolBVR7HwiDdgLMa33+LsuV4lBM4nQTfEfqaBQGofm2NwrkNVSh35aGqlJL/6nomYICRT6D+Sn7Gb+CbAN8bs9wO9xMO4webMWvnMvSQS3HgOAGs5GuSovSCvhZMJ08A8ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748685561; c=relaxed/simple;
	bh=jHNdXiEkBPD/4hRFb5+gNLCWyeacWlbbq8GE5s0EJU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8+YxsjEtu68uPHeQj/ZrOZZ2adoYj7By6NRTIqbv0Ncge0PcCkFlcpl+1JMWm+Q/xMy6b8NESLczH2qVQRkNub/tyfXtgI4c7UvzWdj4itRHDwvbR3TL39l3iISmqbluJZlQ1Dwe+JjR8oogdHNh+fu8ZvWguYcTeRlq7ZCIF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=s4JsNElf; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1748685555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F28uW/kKPBc+Y8EedF7wmeIStqF2kUtY2XQ+UTLAn34=;
	b=s4JsNElftbgemCahvFHM5i7zibfPVAa5C95dnFlArOQD1Ow2PQokjqH5SBAe2F/rh5pjeT
	9j9QS8md8jV5P3yncFR4uWkilj0xYGUNNEfnBhCVfHoZwdnjk/P0MnK0PhDMV63TYuAKgO
	c72/3fSlpryMdWVFR03RgP4eMzXPEvk=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Matthias Schiffer <mschiffer@universe-factory.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Matthias Schiffer <mschiffer@universe-factory.net>
Subject:
 Re: [PATCH batadv 5/5] batman-adv: move hardif generation counter into
 batadv_priv
Date: Sat, 31 May 2025 11:59:12 +0200
Message-ID: <15478494.dW097sEU6C@sven-desktop>
In-Reply-To:
 <fd475dcf9ceaa7d14e4f0b4dca668f93e704f370.1747687504.git.mschiffer@universe-factory.net>
References:
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
 <fd475dcf9ceaa7d14e4f0b4dca668f93e704f370.1747687504.git.mschiffer@universe-factory.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart26338690.ouqheUzb2q";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart26338690.ouqheUzb2q
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 May 2025 11:59:12 +0200
Message-ID: <15478494.dW097sEU6C@sven-desktop>
MIME-Version: 1.0

On Monday, 19 May 2025 22:46:32 CEST Matthias Schiffer wrote:
> The counter doesn't need to be global.

Yes, with the changes from 
[PATCH batadv 1/5] batman-adv: store hard_iface as iflink private data


Acked-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven

--nextPart26338690.ouqheUzb2q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaDrS8AAKCRBND3cr0xT1
y6P6AP9KRnJJUPOIrj7VPA28oI+6BCBzSpYDpPYREKPl1twT1gD/R6ggdPQFEeRJ
rWPV5+4jwZmGS4UipJNC3BrNZrs8UA8=
=f/dy
-----END PGP SIGNATURE-----

--nextPart26338690.ouqheUzb2q--




