Return-Path: <netdev+bounces-180636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE62A81F6F
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1DD188D7E4
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2862B25B680;
	Wed,  9 Apr 2025 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="f6+8cpJ9"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7A82AEE1;
	Wed,  9 Apr 2025 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744186249; cv=none; b=uyQENBRsIPbpQs4nv5MVrqF2q8b67SLAN0o6aUV/zq29LMvAfdh9d+GCZTqHzZjgSDyrIfa4BGlqHeTF+ifihfdtATvEO/S5OXhbjuLW7lh6A45TMFjQlZhpspSOC6Gdm++8pH7udfLfbNwRR8nG/BPDehWzaB8alLtbKCRCWMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744186249; c=relaxed/simple;
	bh=1xxkUhMgV8TI7tAoKd55ZN5KNUdwCInEkdqC613bWjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPXRoD8A+udxODdzbft/83pXDIJBlJxrJkAqNeLBS9d17C8tJbfuzd8WuR9l2alPwQJEVxdcLyhCBLrGfmAGELv/+SOjwn2ZciVgbhWj6E4ue1O9n4gzVdq+XPYrhxcXyyOZB9ko0T+OKUbz08lG3PuAm/6CqZ8QL6JcXt90tMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=f6+8cpJ9; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1744186244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PflrDb8OhffdMQCbjwbS7Ify9Hy35vaMmsHmfVvb/DY=;
	b=f6+8cpJ9j2V2kU/c+O8lQqYmKofdK+9NIE1BBIG8bqrs/ssl7TTk9BxlHu8/yerX7yY4KG
	HIWQuPy5OqLNSV0mG8kXXN/iPh7ezl2Km2H8rCQRTSVTOl6q3o5U1wtRUF0T+AWddJhXID
	H+FeiNN7WUnE0EGMFYs6PwR2//NFf0o=
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
 Re: [PATCH net-next] net: batman-adv: constify and move broadcast addr
 definition
Date: Wed, 09 Apr 2025 10:10:39 +0200
Message-ID: <2789676.Lt9SDvczpP@ripper>
In-Reply-To:
 <c5f3e04813ff92aca8dddc7e1966fe45fca63e56.1744127239.git.mschiffer@universe-factory.net>
References:
 <c5f3e04813ff92aca8dddc7e1966fe45fca63e56.1744127239.git.mschiffer@universe-factory.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4558621.ejJDZkT8p0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart4558621.ejJDZkT8p0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 09 Apr 2025 10:10:39 +0200
Message-ID: <2789676.Lt9SDvczpP@ripper>
MIME-Version: 1.0

On Tuesday, 8 April 2025 17:53:36 CEST Matthias Schiffer wrote:
> +       const u8 broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};

Should most likely be "static const u8 ..."

(checkpatch STATIC_CONST_CHAR_ARRAY)

Kind regards,
	Sven
--nextPart4558621.ejJDZkT8p0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ/YrfwAKCRBND3cr0xT1
y1fnAQCy1/kEIFf15jWwkR3S+Qdew6LxzAvY8o6jP+JPRDwUYQEAue+zH2A71OaA
UYqB9V4j1Sg7iuRxg9Ezzcdl47cB4A0=
=b7CK
-----END PGP SIGNATURE-----

--nextPart4558621.ejJDZkT8p0--




