Return-Path: <netdev+bounces-207108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F05B05CB2
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB991C25056
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F712EA494;
	Tue, 15 Jul 2025 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D22UEriV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB52E7F1D
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586111; cv=none; b=fDgUdbUXiZObIt75QccsPN/mwgxvfNBkdWKdgE/VpCys2mRAbwtCVCFkUC9sR/X3vCZ+TFLhaxEeNGhuZqEYRMJgu3VNlWZTrgkX3MIHuEJ2yseiEhrQ+KrEhaDON9On0PN71jlNXf4feVuCjiiU0Yojbl5EP/VFeNYmRWILoy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586111; c=relaxed/simple;
	bh=EWGkR6Lx9mbVlTQNbryZBJap6TMRNyDG+0JgC1ARmbs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2tPx7Pdm/X4Qyx2uLjuIbhOUXzoXT9VNWKP93gOPM+rPT/7KJm33JiYB58fhWA7jEUHs/BHWKV6noUwHMd3/aM07heSy6OFlXR2CI0TQOgkWtzfJs1yceaY6/0HbJgkqbZP2gcLEvsSxtmkwTFQ/Z/TbcHSpGlpULPrDBmyyr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D22UEriV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BD7C4CEF1;
	Tue, 15 Jul 2025 13:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752586110;
	bh=EWGkR6Lx9mbVlTQNbryZBJap6TMRNyDG+0JgC1ARmbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D22UEriVwlhdsgHzHLaRZbaw7xqODAzzW6ovxbSt9CdB0cvFpp1k81POCMcQzGEvZ
	 WvaoGyizH0qzkSnUkvRI5pXm6Xso19PWiwFvuJUvUxmtPJQ6PuAz1xXKyfL3VYdAAP
	 2lSimXVc988j/pi2EvIjnLmLrxWVj0vQzaJaTdVNyOQnuiAlRjYdDWnwutjUWzHeqR
	 KO47ieD9OzxdkqEuqTnKzRu3DARvhxI4cwQKljTMIdMep0lCT4H1Y/cNyPLShoQP/n
	 GTHz7NuJ91pv3XRDJQ8ScrN1+LM6cyf8FJtp6VYzexuh4MEkXbxdlyb4axNH+BIKyI
	 n/zWg3qiqrUiQ==
Date: Tue, 15 Jul 2025 06:28:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, "David S . Miller"
 <davem@davemloft.net>
Subject: Re: [PATCH net-next 0/8] tcp: receiver changes
Message-ID: <20250715062829.0408857d@kernel.org>
In-Reply-To: <6a599379-1eb5-41c2-84fc-eb6fde36d3ba@redhat.com>
References: <20250711114006.480026-1-edumazet@google.com>
	<a7a89aa2-7354-42c7-8219-99a3cafd3b33@redhat.com>
	<d0fea525-5488-48b7-9f88-f6892b5954bf@kernel.org>
	<6a599379-1eb5-41c2-84fc-eb6fde36d3ba@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Jul 2025 12:14:34 +0200 Paolo Abeni wrote:
> > Eventually, because the failure is due to a poll timed out, and other
> > unrelated tests have failed at that time too, could it be due to
> > overloaded test machines? =20
>=20
> Not for a 60s timeout, I guess :-P

I think the timeout may be packetdrill-version related.
I tried with the Fedora packetdrill and the test times out.
With packetdrill built from source on my laptop I get:

# (null):17: error handling packet: timing error: expected outbound packet =
at 0.074144 sec but happened at -1752585909.757339 sec; tolerance 0.004000 =
sec
# script packet:  0.074144 S. 0:0(0) ack 1 <mss 1460,nop,wscale 0>
# actual packet: -1752585909.757339 S.0 0:0(0) ack 1 <mss 1460,nop,wscale 0>

:o

But the CI just gets the failure Paolo quoted.

I'm leaning towards Eric using a different packetdrill, and/or this
being packetdrill / compiler related. On Fedora I'm hitting this build
failure which may explain why the distro hasn't updated recently:

cc -g -Wall -Werror   -c -o code.o code.c
In file included from code.h:29,
                 from code.c:26:
types.h:64:12: error: two or more data types in declaration specifiers
   64 | typedef u8 bool;
      |            ^~~~
types.h:64:1: error: useless type name in empty declaration [-Werror]
   64 | typedef u8 bool;
      | ^~~~~~~
types.h:66:9: error: cannot use keyword =E2=80=98false=E2=80=99 as enumerat=
ion constant
   66 |         false =3D 0,
      |         ^~~~~
types.h:66:9: note: =E2=80=98false=E2=80=99 is a keyword with =E2=80=98-std=
=3Dc23=E2=80=99 onwards
cc1: all warnings being treated as errors
make: *** [<builtin>: code.o] Error 1


Neal?

