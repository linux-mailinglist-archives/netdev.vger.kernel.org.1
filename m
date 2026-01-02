Return-Path: <netdev+bounces-246629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E15CEF7F7
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 00:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84CAC3010A9A
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 23:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE701ADC97;
	Fri,  2 Jan 2026 23:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsLiJ9zc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3084C97;
	Fri,  2 Jan 2026 23:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767397800; cv=none; b=S0soyjKm/ZUOJzOho/9H0UuTyjRjKhaSH9mbtUOgQ8h9DrOMegFG9oktidv1yc1N4btFhY1+MhElIkj0uG+9lYO3c8WGi/T1E1EnIwoHYCsr3321ENWX20WFjxWiwR6a8uDYHYjSPt3QNt6l7wPluMjrGfojGyp+QeBA275LO/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767397800; c=relaxed/simple;
	bh=FGZfyLWZwMypD5GTLKJgwo9Of6CnESkoPmxim11w8U4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LshA4PGxB4uTkWFg/qBHgWDIWCAk9MpTFSfN0s15I3DLx0zHWEALzIBeinbTvLQQTvtB4JWh4bf1VfcNtmor7mAQq4lylWy/gLnmtI5zjyWPP9pnZuL0FtpWPDOcGWXp8lsMtSLBAUjt/3AI/43sn4SUjgngBEhrr034jjUS2ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsLiJ9zc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71BCC116B1;
	Fri,  2 Jan 2026 23:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767397799;
	bh=FGZfyLWZwMypD5GTLKJgwo9Of6CnESkoPmxim11w8U4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bsLiJ9zc8Dvlgy/M788okwA5uF4XOnChFOazuBVSN3CfS5kKE2U1O5RGoADKN4oUP
	 Ol+nZZsBU+YUlXwZ0p9HWu5cMf9dpyPNN3b41zXtr8OyGOYgr3oMALzQzjS8UtNadt
	 YKsHsY97sAXfH0LM0enyVxSeb6QuifGqJbZaFhSVtOgCxFsD6qddQHHhOVfpy93da1
	 sTSKd8M6P71iC9mBXZlAsBPrUrk2xxAIMB8SLXRyfwoMyfxo1v6WKXAKG1SAzyHOgU
	 Y90RY94D9ydTmbIc1FDK56s8atuEZT+zuKgPg1aIN2scBEa2WUffjqBV4HwiHJTy1y
	 tDtkInYGcNXXg==
Date: Fri, 2 Jan 2026 15:49:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lauri Jakku <lja@lja.fi>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC] STCP: secure-by-default transport (kernel-level,
 experimental)
Message-ID: <20260102154957.69e86d64@kernel.org>
In-Reply-To: <aceecca9-61ae-454f-957f-875c740c0686@lja.fi>
References: <73757a9a-5f03-401f-b529-65c2ab6bcc13@paxsudos.fi>
	<CANiq72mE5x70dg_pvM-n3oYY0w2mWJixxmpmrjuf_4cv2Xg8OQ@mail.gmail.com>
	<ac4c2d81-b1fd-4f8f-8ad4-e5083ebc2deb@paxsudos.fi>
	<22035087-9a3f-4abb-8851-9c66e835b777@paxsudos.fi>
	<c6cdc094-6714-437b-ba37-e3e62667f4aa@paxsudos.fi>
	<aceecca9-61ae-454f-957f-875c740c0686@lja.fi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Dec 2025 20:13:40 +0200 Lauri Jakku wrote:
> STCP is an experimental, TCP-like transport protocol that integrates=20
> encryption and authentication directly into the transport layer, instead=
=20
> of layering TLS on top of TCP.
>=20
> The motivation is not to replace TCP, TLS, or QUIC for general Internet=20
> traffic, but to explore whether *security-by-default at the transport=20
> layer* can simplify certain classes of systems=E2=80=94particularly embed=
ded,=20
> industrial, and controlled environments=E2=80=94where TLS configuration,=
=20
> certificate management, and user-space complexity are a significant=20
> operational burden.

We tend to merge transport crypto protocol support upstream if:
 - HW integration is needed; or
 - some network filesystem/block device needs it.
Otherwise user space is a better place for the implementation.

