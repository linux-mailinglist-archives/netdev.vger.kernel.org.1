Return-Path: <netdev+bounces-194481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAD1AC9A3F
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 11:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF3B17A8FE6
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FA6238C1B;
	Sat, 31 May 2025 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="xE1048Mn"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C4D2CCC9;
	Sat, 31 May 2025 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748683326; cv=none; b=RPPUJ3UfzmSpto3KMrIwIFpqlVko95D3kq09ChDhXsCioqbnO1lpFyerJ/hkUD6sGMOp477Z1bL1bI/5IccR8Vty70o0tOGoiJp0KOkbNT7tYfEa9hnMRdmWNagN9ZoP+0Ud5/Zcn2QqTJv4Bz0wBfskR+B+YwCtotOXmFajMFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748683326; c=relaxed/simple;
	bh=AdscRCctEiDVk+KrsLD7YZHALhZ8CgY98mZKJ9zDPeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sp4n7TsilUJInEmeZPSriIMahPBzOxZbsTj+l2rboaKk7hlrVY3txX+KHyvd7+4kgta7RCzmOJ+8dZHmZzl3SGwkdt30wI+8BoHL7q9Gs5UbeyWyS7VdKCAIaNMWptP5mzYMjnEzo2xotyke6NWZ8h8Bsgi95iEikiIVsANLhFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=xE1048Mn; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1748683322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j8v7hhYADUSDBALNMgGQ0eVg8nF9mMtO+msRRg6pCVQ=;
	b=xE1048MnNYlE8NWyUEINeLcBKvFzOU3ZrUeJI91t1dMT8EufgIXw40OqgkALKjiomh5ZnQ
	V7r0M8ACaKnWgOEQEw4JeoLD7fwgvB+hgLuiqmTwSO2IWrwdhKgupbbCeuuyNZtz8sTNUH
	Z9k1AiJROhhvyqVaYuT9+L8Pkuc5JLc=
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
Subject:
 Re: [PATCH batadv 2/5] batman-adv: only create hardif while a netdev is part
 of a mesh
Date: Sat, 31 May 2025 11:21:59 +0200
Message-ID: <25663883.6Emhk5qWAg@sven-desktop>
In-Reply-To: <7760123.MhkbZ0Pkbq@sven-desktop>
References:
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
 <e311c7d643fa1a7d13f2b518f6ee525eb6711f6c.1747687504.git.mschiffer@universe-factory.net>
 <7760123.MhkbZ0Pkbq@sven-desktop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4362857.Lt9SDvczpP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart4362857.Lt9SDvczpP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 May 2025 11:21:59 +0200
Message-ID: <25663883.6Emhk5qWAg@sven-desktop>
In-Reply-To: <7760123.MhkbZ0Pkbq@sven-desktop>
MIME-Version: 1.0

On Saturday, 31 May 2025 11:16:30 CEST Sven Eckelmann wrote:
> And yes, this means that this needs to be removed in PATCH 3 again - together 
> with the `kref_get` from this chunk (from PATCH 3):


Sorry, I meant [PATCH batadv 4/5] batman-adv: remove global hardif list

Kind regards,
	Sven
--nextPart4362857.Lt9SDvczpP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaDrKNwAKCRBND3cr0xT1
y/M0AP9g+BqAjjlxOI9kCnFV3nh+CKN2Ove7pEJWMkP87I5VgwEA5PqgyCOIwLh1
ubidCl1lIiLg5iFmDYyAEkgqy89H7AM=
=+h/T
-----END PGP SIGNATURE-----

--nextPart4362857.Lt9SDvczpP--




