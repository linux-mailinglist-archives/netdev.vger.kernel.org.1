Return-Path: <netdev+bounces-247227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F247CF6067
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 00:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0326F30754E8
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 23:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595011EFF80;
	Mon,  5 Jan 2026 23:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8vJXZlj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302743A1E77;
	Mon,  5 Jan 2026 23:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767656732; cv=none; b=Db49NSMp6VcgEZLilSVaZJFMzulN2eVaNgQqy1Qjuw2RIYNpIRZhiyGQ3RQxDBJGmstlaX9+m/Alt0Tk8GXMoLZuD2E88Xx0U5jxVz8znduxieTFv08tx8iB1uX7NXS/YlS/kxW/nwb7eUaMrryNtSDd1LMuISnQIHhJVbK9sn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767656732; c=relaxed/simple;
	bh=DiYqZ/Pf2GSi3emLm5ET/ydq3+ER9lxyBwJZxpdhAXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9KlHgdLJyydg6kliDFDbOvP+JIXBzBaRSWivJyVWR6x0aX1gu2jWUxTX2fzJmEvCvSwzHk1yyerg1cgl3K+u2O1ZiVTM7fl639H4cQYAt7klsEfQF33HwGBjYWWqLf9J7px6Sbqop1rnWksb/N9spvvpBw4oxYBRGcabDqzPUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8vJXZlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5250DC116D0;
	Mon,  5 Jan 2026 23:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767656731;
	bh=DiYqZ/Pf2GSi3emLm5ET/ydq3+ER9lxyBwJZxpdhAXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l8vJXZljdAhduGxIMk8KvNRp6pgSytBKKKTNL8pNACxBBDjcfPpFrknwWNlxpHa2G
	 9s601rUx4NT5KJWuqAaaxrdmz/9divQZWF8iDmw/sFB+F1PTBzNii94BpyFVFbTF8r
	 wj/B1bawX9HtxDSMKJkpuq2oG2c3ZJzg1Ron0YN8JPti0lFbo0EIw5ozjUbeEIQJmC
	 XMWzx+Q8fRUrQX3r6xDTWb6EGRD3OBJOCxQRpHzDgT1kLTSyklkk3JIRgAOAsCDof2
	 it7i50bRWWa5cBunkXwS8N5WQD3ZlXLoYot+O6bACie0me0xji4hTX4mHJc7AOsXIX
	 Y+uYIW3dBHTrg==
Date: Mon, 5 Jan 2026 15:45:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lauri Jakku <lja@lja.fi>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC] STCP: secure-by-default transport (kernel-level,
 experimental)
Message-ID: <20260105154530.4e8153be@kernel.org>
In-Reply-To: <ad8f797b-529a-49e2-bcda-a30d0396c1a9@lja.fi>
References: <73757a9a-5f03-401f-b529-65c2ab6bcc13@paxsudos.fi>
	<CANiq72mE5x70dg_pvM-n3oYY0w2mWJixxmpmrjuf_4cv2Xg8OQ@mail.gmail.com>
	<ac4c2d81-b1fd-4f8f-8ad4-e5083ebc2deb@paxsudos.fi>
	<22035087-9a3f-4abb-8851-9c66e835b777@paxsudos.fi>
	<c6cdc094-6714-437b-ba37-e3e62667f4aa@paxsudos.fi>
	<aceecca9-61ae-454f-957f-875c740c0686@lja.fi>
	<20260102154957.69e86d64@kernel.org>
	<ad8f797b-529a-49e2-bcda-a30d0396c1a9@lja.fi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Jan 2026 17:38:28 +0200 Lauri Jakku wrote:
> Jakub Kicinski kirjoitti 3.1.2026 klo 1.49:
> > On Mon, 22 Dec 2025 20:13:40 +0200 Lauri Jakku wrote: =20
> >> STCP is an experimental, TCP-like transport protocol that integrates
> >> encryption and authentication directly into the transport layer, inste=
ad
> >> of layering TLS on top of TCP.
> >>
> >> The motivation is not to replace TCP, TLS, or QUIC for general Internet
> >> traffic, but to explore whether *security-by-default at the transport
> >> layer* can simplify certain classes of systems=E2=80=94particularly em=
bedded,
> >> industrial, and controlled environments=E2=80=94where TLS configuratio=
n,
> >> certificate management, and user-space complexity are a significant
> >> operational burden. =20
> > We tend to merge transport crypto protocol support upstream if:
> >   - HW integration is needed; or
> >   - some network filesystem/block device needs it.
> > Otherwise user space is a better place for the implementation. =20
>=20
>  =C2=A0I got Nordic Semiconductor contact, that asked if it is upcoming=20
> feature for kernel, the need is there (For modem use).

Please come back once it's actually adopted and deployed somewhere.

