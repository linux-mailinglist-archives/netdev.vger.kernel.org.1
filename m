Return-Path: <netdev+bounces-104159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8302690B5C2
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD9D2817CD
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884F41D9508;
	Mon, 17 Jun 2024 16:06:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196F76AB8
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718640372; cv=none; b=RxynHV9WaVwqgQzNfhs6iUuZh9La6qgo6olKXEjxVd7DNkgGUfazC6ZyUlrD4ANG4L9mQgiSKEq9bugVfrgOb9ImDpse6RbR34uGHJaQk9JtpsnO3qsQy9HXW2/JhvnsBMQnyRGtGV4VdgZb5uvwEB0/HafMLgZDe66mI9VStR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718640372; c=relaxed/simple;
	bh=FNDt7b/xJL70INBGu0gOjJD4Xr0fVM8AEKvVy4GXwII=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eew0usvLWCB1NifBU7lU9SGgMUBMpqBfyr1uPgWO9TWFXlMNAsHtVlKobAeyg5K2YhwiEytFq4PB5boXMTpxJE/OqhEDtwYUrbCF5EjqJ4jCvANfesse8F2l2QdmpGFL++XNpV0IoIj9fEvqodkuUxcJwZH9JtgziDCQFPaaICg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from smtpclient.apple (unknown [199.253.184.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id B18857D031;
	Mon, 17 Jun 2024 16:06:09 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [devel-ipsec] [PATCH ipsec-next v2 0/17] Add IP-TFS mode to xfrm
From: Christian Hopps <chopps@chopps.org>
In-Reply-To: <9f3c7667-f5ad-48b2-9f30-454c30d6a933@6wind.com>
Date: Mon, 17 Jun 2024 12:05:56 -0400
Cc: Antony Antony <antony@phenome.org>,
 devel@linux-ipsec.org,
 Steffen Klassert <steffen.klassert@secunet.com>,
 netdev@vger.kernel.org,
 Christian Hopps <chopps@labn.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <993B1CDA-DC03-4FA3-BC65-BB82D0A0B328@chopps.org>
References: <20240520214255.2590923-1-chopps@chopps.org>
 <Zk-ZEzFmC7zciKCu@Antony2201.local> <m2cypc3x46.fsf@ja.int.chopps.org>
 <ZlB_eSJKUKwJ2ElP@Antony2201.local> <m28qzz4dk5.fsf@ja.int.chopps.org>
 <m24jam4egz.fsf@ja.int.chopps.org> <ZmftmT08cF6UTMZJ@Antony2201.local>
 <BC54C211-FD19-4105-833C-BB3B297B9BD5@chopps.org>
 <9f3c7667-f5ad-48b2-9f30-454c30d6a933@6wind.com>
To: nicolas.dichtel@6wind.com
X-Mailer: Apple Mail (2.3774.400.31)



> On Jun 17, 2024, at 11:39=E2=80=AFAM, Nicolas Dichtel via Devel =
<devel@linux-ipsec.org> wrote:
>=20
> Le 17/06/2024 =C3=A0 17:17, Christian Hopps via Devel a =C3=A9crit :
>> Very sorry, it appears that when I did git history cleanup, the fix =
for the dont-frag toobig case was removed. I will get the fix restored =
and new patch posted.
> Please, don't top-post.
>=20
> =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst#n338

Yes, sorry about that, I normally don=E2=80=99t but was replying from a =
hospital bed =E2=80=94 things are a bit jumbled currently. :)

Thanks,
Chris.

>=20
> Regards,
> Nicolas
>=20
>>=20
>> Thanks,
>> Chris.
>>=20
>>> On Jun 11, 2024, at 2:24=E2=80=AFAM, Antony Antony via Devel =
<devel@linux-ipsec.org> wrote:
>>>=20
>>> On Sat, May 25, 2024 at 01:55:01AM -0400, Christian Hopps via Devel =
wrote:
>=20
> [snip]
> --=20
> Devel mailing list
> Devel@linux-ipsec.org
> https://linux-ipsec.org/mailman/listinfo/devel


