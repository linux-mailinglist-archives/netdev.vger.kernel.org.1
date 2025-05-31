Return-Path: <netdev+bounces-194480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A75C3AC9A3A
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 11:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBDC73BB943
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 09:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61896238144;
	Sat, 31 May 2025 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="a/98SsFD"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5621921FF22;
	Sat, 31 May 2025 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748683107; cv=none; b=FaxN5NWFpf/enR5JhpoBgAT2QzB+OFgwMSrqvLP2QjD158s3JsnSXwlv91+SmVXvi+3NparIQFWtjUGy0TxeNTxAf0knw6M5KkAR4fITqguceVvOgYG6C1OIaoyCiU1MF61CKcquHEMi3e1/kqDoXpueqdLjZlGnOTd+oXu/K2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748683107; c=relaxed/simple;
	bh=iWr0zkYv1wNHDiLMVdxrVbj3HpclaXjmHLi03DGv0tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lk8HbG4njSo+v1VuwQ4GYpIBr37aiGkCx1K/hbyLTOj/nl9R7CkLjdRA7CJZ6GF1LK5/HsyC0K/4sjRYdSqr3TpqRfbyInoHpdhn251JtqToPSR0shPUw0k3HgjzJtmBVtsGWcd7Yr0CE430kznyX1UsIfOxzP7QcjoK1Bo0icM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=a/98SsFD; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1748683102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rQNzauAFKXYmmu3TktHsj7RSHhKaZTHxe8GsYvpuUP4=;
	b=a/98SsFD5kXArAHzvHH8VpBQbRoH+MSrN4n6w4o6J67jYoailA6AHGxLcCKYxou7iDgZ2O
	0TzCaG0awMXwf2X/17bBycrRHvcvjhTTnaNSufzqQIU19ro+mAK8ynzwtGzrwipXuJLIyv
	yYiDma7+42C8gKY4zuQoEyfQixTLibk=
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
 Re: [PATCH batadv 3/5] batman-adv: remove BATADV_IF_NOT_IN_USE hardif state
Date: Sat, 31 May 2025 11:18:19 +0200
Message-ID: <3730915.usQuhbGJ8B@sven-desktop>
In-Reply-To:
 <18929b62aafd4ce02940bea02b7a2bf6c5661089.1747687504.git.mschiffer@universe-factory.net>
References:
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
 <18929b62aafd4ce02940bea02b7a2bf6c5661089.1747687504.git.mschiffer@universe-factory.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5256341.QJadu78ljV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart5256341.QJadu78ljV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 May 2025 11:18:19 +0200
Message-ID: <3730915.usQuhbGJ8B@sven-desktop>
MIME-Version: 1.0

On Monday, 19 May 2025 22:46:30 CEST Matthias Schiffer wrote:
> With hardifs only existing while an interface is part of a mesh, the
> BATADV_IF_NOT_IN_USE state has become redundant.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  net/batman-adv/bat_iv_ogm.c     | 3 +--
>  net/batman-adv/bat_v_elp.c      | 3 +--
>  net/batman-adv/hard-interface.c | 9 ---------
>  net/batman-adv/hard-interface.h | 6 ------
>  net/batman-adv/originator.c     | 4 ----
>  5 files changed, 2 insertions(+), 23 deletions(-)

Acked-by: Sven Eckelmann <sven@narfation.org>

Thanks,
	Sven
--nextPart5256341.QJadu78ljV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaDrJWwAKCRBND3cr0xT1
y04gAPwMoJas4EzdQIDr04VKE1UCLzkUwpr53WaxvHRdT5BJDQD/fgj+8WPsYSSM
FX7YY8MrPBQD/KKyq+M4ZdC2rfVpkws=
=odll
-----END PGP SIGNATURE-----

--nextPart5256341.QJadu78ljV--




