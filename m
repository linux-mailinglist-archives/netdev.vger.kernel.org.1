Return-Path: <netdev+bounces-212698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB1DB21A02
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9D44631EE
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18802D6624;
	Tue, 12 Aug 2025 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfPIYdXV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DCA26E6FA;
	Tue, 12 Aug 2025 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754960747; cv=none; b=VGRD+geXgkUX2I+bDgsU3EdSdFNtzncOWk1SZwfE3CyL5xOWCUTnfFwD02fp5gBIqT9/a8ygHRmiTzsdou6Vg9478IyI0EX1wN9GDVi3xpiMtoKfaskJNRc+L0K/6o7pmPCGFokIcUxj39U7kix86f/58bx46vRP/WIJlF+uZWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754960747; c=relaxed/simple;
	bh=tnadAJJ3gvSe37IaQuoRsAc1fSW7akru9HMWFLtRq6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HnIfI8OkIXT6tGPTq/H2wrzAusMTjW66Xit2v+h+PT944zHwwibhFb/2YLXhSHapHvs9E6UzqrTkKzRtlOXNPGyVWZ44YwF4exON2AqMIjWuo2CtILtDP3fReXroadAXOKH3uIhYAV43j6s62XuzviMEI1dv2l/oEhP85CUo4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfPIYdXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE9CC4CEED;
	Tue, 12 Aug 2025 01:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754960747;
	bh=tnadAJJ3gvSe37IaQuoRsAc1fSW7akru9HMWFLtRq6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GfPIYdXVExsgK3SguULzi1D9OBQHnD6Cq59maXLIDI9fp1EdKCkxhXaeMQDV3xwgB
	 TIfMdoqTBYipUC2dScd6XEvtCpxrCH9X8r/FD227jjjqlB00fHvxEZ55LUCJuAmcPh
	 nrXUPcy9dSTVXkKBhYcZYpNjL+JjuvSFzwXA++KGQj7ZF17EW5BYnZ+DcRtq1DfMQ4
	 1fjC/E4U6Qep1542NRAvg+6k0XR3IiVKbaT73urFu7WDOBzYQHYwsfNZB+pNjVwx10
	 uT8B9+gGtj4FaBSOJ9egf+CXODpRxYM3wsqtMFNOdZWNkWkSxrm8H6YVn6Mrvoo0p3
	 iE5EetAqAncHQ==
Date: Mon, 11 Aug 2025 18:05:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Miguel =?UTF-8?B?R2FyY8OtYQ==?= <miguelgarciaroman8@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, skhan@linuxfoundation.org
Subject: Re: [PATCH v2] net: tun: replace strcpy with strscpy for ifr_name
Message-ID: <20250811180546.1bd97b0c@kernel.org>
In-Reply-To: <20250811203329.854847-1-miguelgarciaroman8@gmail.com>
References: <6899fde3dbfd6_532b129461@willemb.c.googlers.com.notmuch>
	<20250811203329.854847-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Aug 2025 22:33:29 +0200 Miguel Garc=C3=ADa wrote:
> Replace the strcpy() calls that copy the device name into ifr->ifr_name
> with strscpy() to avoid potential overflows and guarantee NULL terminatio=
n.
>=20
> Destination is ifr->ifr_name (size IFNAMSIZ).
>=20
> Tested in QEMU (BusyBox rootfs):
>  - Created TUN devices via TUNSETIFF helper
>  - Set addresses and brought links up
>  - Verified long interface names are safely truncated (IFNAMSIZ-1)
>=20
> v2:
> - Dropped third argument from strscpy(), inferred from field size.

Please don't post new patches in reply to old ones. Please read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
there are multiple other problems with your submissions.
Please fix and repost.
--=20
pw-bot: cr

