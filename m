Return-Path: <netdev+bounces-99154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1588D3D8C
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 19:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD0128549F
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6045F1A38DF;
	Wed, 29 May 2024 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4yenTQY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F115B558
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004584; cv=none; b=ZhGlXNodQFKaRs0uIvIko1/3IRj+qByvScfevZoCPP68ko95eZvtZpXEmLWekJ2SWjggN9iQfXS0zkDjCqVAJizjztxkDRTYyvlOsZPkjKL7hXY//0PZ/MhcdiL9LWLdKWFNlUluB5QE8D277jnZf6vNZK5yQK6aPxHzsjWRt3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004584; c=relaxed/simple;
	bh=GTVz0oMfsaD8/Os/hGnF34WQL7Z2s7SojDh/mzqMOSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PxUtanvz9k4Pvdt16NMD2lA88/ZPQxprg7GhJ0xDffn5jX3a6/0AwX37FtxFXoclwZkXpZRgoCsvtgULSmQI8kbF13tZBIBbV8WLLvCKGJjKyrnsY+Rp7J78uuTCDQMLWReknFqRBthRhAF0Nf4EWe8NU5SPyr1oZIK+IptlGVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4yenTQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D79C113CC;
	Wed, 29 May 2024 17:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717004583;
	bh=GTVz0oMfsaD8/Os/hGnF34WQL7Z2s7SojDh/mzqMOSA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N4yenTQYmDbYBN5d+VZezOMKjv9Df2CbrFvLimbSZ3Gu+ds8mfP4UmQn5KiJC/yNt
	 n3t/YHNM0rhv1VpYSyrwTwljdrnUevP733y25uA53WTEfuasaIkJ8qsl3Oy6OlYzd4
	 irPK0Lpcx9GDNFmEsh8WKxq5VM6wO2abwL350hIKvgSufnygf4Az3tyy7SogLEQhxe
	 Ret6ynvs7yVhgu71Ac9B1TJ+9UyetELIg5FflchCVHqFjvd6q15l9LNgsjOph96fvK
	 Pq0dSBTLFxBINDa2IysSKGDXzEAwlWtOqlLM0Bi0KmOE6IS0vhu6VBbJqkeFoag8ZE
	 ym6QjfFa7e7Ig==
Date: Wed, 29 May 2024 10:43:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lance Richardson <lance604@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, borisp@nvidia.com, gal@nvidia.com,
 cratiu@nvidia.com, rrameshbabu@nvidia.com, steffen.klassert@secunet.com,
 tariqt@nvidia.com, Lance Richardson <rlance@google.com>
Subject: Re: [RFC net-next 05/15] psp: add op for rotation of secret state
Message-ID: <20240529104302.70c96c25@kernel.org>
In-Reply-To: <CADuNpCxb3NV84BLQd7064q5YEjnYutDqerY6dvTRDsqdK2fO3Q@mail.gmail.com>
References: <20240510030435.120935-1-kuba@kernel.org>
	<20240510030435.120935-6-kuba@kernel.org>
	<CADuNpCxb3NV84BLQd7064q5YEjnYutDqerY6dvTRDsqdK2fO3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 16 May 2024 15:59:14 -0400 Lance Richardson wrote:
> On Thu, May 9, 2024 at 11:05=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > Rotating the secret state is a key part of the PSP protocol design.
> > Some external daemon needs to do it once a day, or so.
> > Add a netlink op to perform this operation.
> > Add a notification group for informing users that key has been
> > rotated and they should rekey (next rotation will cut them off).
> > =20
> Does this allow for the possibility of NIC firmware or the driver initiat=
ing
> a rotation? E.g. during key generation if the SPI space has been
> exhausted a rotation will be required in order to generate a new
> derived key.

I think it should be fine - I was designing with that use case in mind,
but ended up not needing it. We can export a driver facing function
which will basically perform the equivalent of psp_nl_key_rotate_doit().

I added the "key generation", because I worried that if unsynchronized
agents on multiple hosts can rotate the key - the chances of
double-rotation and immediate reuse of a SPI are much higher.
Not sure if the extra key generation bits are really necessary..
it seemed like a good idea at the time :)

