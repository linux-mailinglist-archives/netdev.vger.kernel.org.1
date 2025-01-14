Return-Path: <netdev+bounces-158239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBBBA1131F
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97FEC188A285
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EF71D516A;
	Tue, 14 Jan 2025 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6wZ/RpW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294629406
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736890610; cv=none; b=K0IxUMyxHm4yPTwT3uYCgCte24abrv1NyHXHsT0gE/yZWYbwCqvLcMR+/xMIboav05x58pRa4vgQZRCNuB4VVOZZYexw/DlUeDm+7YHVQ5broK4JxKxbpNZ510fZmDPB1Iuuv/pEIOVb/pAN/lObsXXqtpqC/fcKr88U8GkajLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736890610; c=relaxed/simple;
	bh=khg8uktsYykUQX7JNA/3gsR9UMXC5UQ3BDCAKb62ws8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTYbfqeQOcnaJ68pFX29k57tYQgSLnDKoyRkAqpr6a6qmmP7lOKly4DpSoZMdpdIFFN4jMBXVIc3LwPbe1fy6Ml6NK+VLsoTOuwHRXbxZatRzNyUWDFrE/pu2sJXxHVnMzRto6EUEKGSJUkxZB+8zkZuqWS4fvcrImHz3aYNgrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6wZ/RpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD77FC4CEDD;
	Tue, 14 Jan 2025 21:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736890610;
	bh=khg8uktsYykUQX7JNA/3gsR9UMXC5UQ3BDCAKb62ws8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D6wZ/RpWi8FcVhzV2yLyVhaEZ+zMxq7GvY6bWWHwdNuRcO7M6zHwxZRf6Y7TXwBD8
	 ppsQ0wYFIrrHEOdywkIsfBOP83OjqZVjSVIXq0CeI0Q62PwZpiFIaWbysmLioYNH2W
	 7zSreijxbqg8/So2gln5ZAYXp4ha2rVQsVk36qX3AqebvRqn0cgk87fbS9sgWS48Nx
	 ABRFJV4+vMDNL4uD76rWJp7iBim8eSu10YkSQGOsfQ8n2jRNjPpmg26OxldNwKc0ID
	 6vjbdQePzr3DbCeZaKEPjSPLzm+qG/GTplj/Yg7qx2hoCcJWi2GDRkvH/ioVQxlz+v
	 taAd400vWKaWw==
Date: Tue, 14 Jan 2025 13:36:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] inet: ipmr: fix data-races
Message-ID: <20250114133648.36702172@kernel.org>
In-Reply-To: <20250113171509.3491883-1-edumazet@google.com>
References: <20250113171509.3491883-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Jan 2025 17:15:09 +0000 Eric Dumazet wrote:
> Following fields of 'struct mr_mfc' can be updated
> concurrently (no lock protection) from ip_mr_forward()
> and ip6_mr_forward()
>=20
> - bytes
> - pkt
> - wrong_if
> - lastuse
>=20
> They also can be read from other functions.
>=20
> Convert bytes, pkt and wrong_if to atomic_long_t,
> and use READ_ONCE()/WRITE_ONCE() for lastuse.

Drivers poke into this:

drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c:1006:43: error: invalid o=
perands to binary !=3D (have =E2=80=98atomic_long_t=E2=80=99 {aka =E2=80=98=
atomic64_t=E2=80=99} and =E2=80=98u64=E2=80=99 {aka =E2=80=98long long unsi=
gned int=E2=80=99})
+ 1006 |         if (mr_route->mfc->mfc_un.res.pkt !=3D packets)
+      |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^~
+      |                                      |
+      |                                      atomic_long_t {aka atomic64_t}
--=20
pw-bot: cr

