Return-Path: <netdev+bounces-204703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFC4AFBD5C
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 23:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5461658A1
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B813287261;
	Mon,  7 Jul 2025 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkD6JvC7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581A528725F
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751923161; cv=none; b=t8NKnOgvt2WlEfWXXNaZCRVl6pzKkBmIntTHUvTrbwswHg9lS8qKyJcX+Fv+RcKLEyYt8l7J5ZfgAnN+LC+L9R4OeW9VLCw5OC4HUCLvQYWYUe8whEhE2IpKR+PBGZXkv9zri2GNO5cBUlT5TtqhEYcKj8A7Lh75cD1iSNaDcoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751923161; c=relaxed/simple;
	bh=BbaT4pDFWkutJ255vpPuCP2ZdMaKwcYRMq2Cx1d5sP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9RiE9QJjRXjR7Hx5aF6JuKRiOZqqYHkKhP6tFcN/MMcXbS6M2ckRiw+Y/d/OJV4ghC49RQgGG6R3B5lSYCWHsefnBhQ7ArOziIOx/E3YlUWT1soyd7JFhi6VKl7WHiNQmTbRXkyqFKyVnUcpoBKA54X2epdHbEQmlWl6ZIWB5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkD6JvC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6962AC4CEF1;
	Mon,  7 Jul 2025 21:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751923161;
	bh=BbaT4pDFWkutJ255vpPuCP2ZdMaKwcYRMq2Cx1d5sP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PkD6JvC7nQv3I/f8Wk+v2brMMTA+I+ObglAvDJbvMrpIAiVE9Y+kyfyud/Qf8rwpd
	 ytD9k9HG21ytVoX1kGQPlLfoVQXKz18habkzp3ZSn8sVgvdsM7D0wOaXuf8UhQOC3H
	 JKIm+o89JWyCyJIEG5QykQi3xO9X0G7+X2rfNonPcf3XEIoMKC+uOcaE4Ja0zCFYkH
	 ZL+zIHpWlXXvhJtjqaSpOsuf1MYdkPZWRy3erVHIwV241Hwb7iZYqNC7dUHCh38tH5
	 Sccen0sqZiTYLEKQu4BXTQr9ShkyjYVs2q2iySlZ2G4a2gB7sd7glVwzTm1qxk2T4D
	 TJUan8AJvf4yg==
Date: Mon, 7 Jul 2025 14:19:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Boris
 Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, Willem
 de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, Neal
 Cardwell <ncardwell@google.com>, Patrisious Haddad <phaddad@nvidia.com>,
 Raed Salem <raeds@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?=
 =?UTF-8?B?bnNlbg==?= <toke@redhat.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 10/19] psp: track generations of device key
Message-ID: <20250707141919.3a69d35f@kernel.org>
In-Reply-To: <686aaac58f744_3ad0f32943d@willemb.c.googlers.com.notmuch>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
	<20250702171326.3265825-11-daniel.zahka@gmail.com>
	<686aaac58f744_3ad0f32943d@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 06 Jul 2025 12:56:37 -0400 Willem de Bruijn wrote:
> > There is a (somewhat theoretical in absence of multi-host support)
> > possibility that another entity will rotate the key and we won't
> > know. This may lead to accepting packets with matching SPI but
> > which used different crypto keys than we expected.  =20
>=20
> The device would not have decrypted those? As it only has two keys,
> one for each MSB of the SPI.
>=20
> Except for a narrow window during rotation, where a key for generation
> N is decrypted and queued to the host, then a rotation happens, so that
> the host updates its valid keys to { N+1, N+2 }. These will now get
> dropped. That is not strictly necessary.

Yes, it's optional to avoid any races.

> > Maintain and compare "key generation" per PSP spec. =20
>=20
> Where does the spec state this?
>=20
> I know this generation bit is present in the Google PSP
> implementation, I'm just right now drawing a blank as to its exact
> purpose -- and whether the above explanation matches that.

I think this:

  Cryptography and key management status:
   =E2=97=8F Key generation (a counter incremented each time a master key
     rotation occurs), when master keys are managed on the NIC.

