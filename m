Return-Path: <netdev+bounces-201267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F220AE8B14
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 19:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1781894C2B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 17:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EFF2DECAE;
	Wed, 25 Jun 2025 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wcbPZDSV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04F22DCBE5
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870576; cv=none; b=fiTQZIdEZTST0dmQ793Q+MJZ7mpWxT3ZE4WHXS7WZfVHKSzIo6jaR164VMk5G+TEoKYYV2Krq0PKfvLC4AAS8JF1COGQWtXa+PuIcPJ3t5gaGk8Cwo72Wsxz5LXiPY11q1rzLS9ba2cbyca+ZP2bRVoR7zr9W8gS1dP1tfhDcks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870576; c=relaxed/simple;
	bh=H+cFqSabCeKTGbah2nsZUc45iEYTSMB7GZ6xmwcKhAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5oAV9ZqLLf/6EUeL+orgrFIILnp3scbl12etipSGpzwQX9gHrRjPnnpnwS914WtqAMxFI39t9nCfVQNJ7HBsfAgxOC8SnEFLuobTBfx1g+IzloPebv7VaPxqMhiHPMZDLCD16zz8diyxG8uJk+0SXHfmaLFaMSXEySYRBTyh8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wcbPZDSV; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c3d06de3so275299b3a.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750870574; x=1751475374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+cFqSabCeKTGbah2nsZUc45iEYTSMB7GZ6xmwcKhAE=;
        b=wcbPZDSVlknHKgZZ7ZhYvw8vS6jiSyuAssWzLKzNlAyJVAjZghxdhgHyo1Am6SUj6U
         yEQzj5v0R1HzIx85x5MRSnIhxFBmt794hhvdyNXyp4eflBUBQL3LN8ZfyW5gFNxK2Fst
         fA6Qncat+kNc6vG4zRYnJTJceR7AnOCobhjvIqbrAKOV3TSXQ8GVqxXZOsJU/gQTnWKT
         RdW/Oehvd4cX/Aa699xfsKJiMMugxVAGtRlYuT5XRNQgt00r9scpgmL1OGFJZAZWCkl0
         anyol7Ljn9W76uB2r8OmoaiVGb3eC4MP/M6M5Fn6sO91Qy6RY9k68CUeOO09LC1FXD7j
         k1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750870574; x=1751475374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+cFqSabCeKTGbah2nsZUc45iEYTSMB7GZ6xmwcKhAE=;
        b=XDT7M4Zv/3k98lpSNZDBuXX9MIPyNTGNT8h5l8YusSfKS6KhYrcXQZHmMVisnEOqR+
         HoWxIDs8nQzRtk8s7habGNfc00dIW9Ff7HuPV3qQIsRYKkRyGh1tc4FWDwEEtCmpWtvh
         drbHSuWAUYtNKqS7CLAyMto5GNXuumhUnzs0H4UvSTWCCS2h2mx2d22K45RG1s+EJS53
         jE359zWNNGs8FGQRylUjiFgWDQjkHKEw4/LCvtq34FT8srpCLZ98bfU8rTzvHhJM2Qsh
         TLBaSOSXByKxspyYkLcs5brmU/U1Q1drf+8AqhMruBGnLluywdK/VmRqfMiEa3CssWaH
         ijrg==
X-Forwarded-Encrypted: i=1; AJvYcCXyRBx54AqzCuHP5sBgARO66y4gzxi1puM86EdF1mY+rLxkhzwXCdFyFqsYDewdfnvb243TtKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHWkCWleS2n7QFDBdLyQV2knFbDqu1W0jPRCIh/iIwQ0wjIUsC
	5v+KGeAEYxIyQFhTcVcaiDkq7dQdJWZEArunW8CW7T6k+EqELLIZouoXM/o5rXY6dAuvkdZwiql
	csHlpkzzY4/up/dxfhNg34MO0LL9FhRdfNI6MwZIRbcLWhRt06XsrJE5RMW0=
X-Gm-Gg: ASbGncsRQLQtXmMeW1/dEj08dHjBicElNwNgy0RXp/YfI/VXOjwDFPgED0YiOQFQ1TJ
	CZY7wQXqTp/9ZkcHGBpzxeo8yEm621Ky1X/Ao4uq9yQm7YKSjslxcD5NKK40vBja1OGrGkeYp90
	bzerkrHFXT+wTMdcloyNAaI0RiCmUQLgft2D+D9ocfKO5Rr4nPz/XmTbU16vqVpdTNCvUsER1VY
	w==
X-Google-Smtp-Source: AGHT+IGtpZGUmsISxXXLGDOjRgzHyozWsCZr+VOIaqCjeJTw32n+Yj6YAyU4/ppRJfMywleO8kjpwgV/YIztVjchcV8=
X-Received: by 2002:a17:90a:c890:b0:311:ff18:b84b with SMTP id
 98e67ed59e1d1-315f268d08cmr5563811a91.25.1750870573927; Wed, 25 Jun 2025
 09:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624071157.3cbb1265@kernel.org> <20250624170933.419907-1-kuni1840@gmail.com>
 <20250624150357.247c9468@kernel.org>
In-Reply-To: <20250624150357.247c9468@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 25 Jun 2025 09:56:02 -0700
X-Gm-Features: AX0GCFvjHo-rL4hmbaiAqfAaZJCZaMTB8owwK8SX8EpxVGEhAghiBjX9elId0JA
Message-ID: <CAAVpQUCxDGD-rd1-GaqrpeZCSSRi_U=CaRnGYCNM=MDoJqvM=g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] netlink: Fix wraparound of sk->sk_rmem_alloc
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jbaron@akamai.com, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 3:03=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 24 Jun 2025 10:08:41 -0700 Kuniyuki Iwashima wrote:
> > Date: Tue, 24 Jun 2025 07:11:57 -0700
> > From: Jakub Kicinski <kuba@kernel.org>
> > > On Tue, 24 Jun 2025 09:55:15 +0200 Paolo Abeni wrote:
> > > > > To be clear -- are you saying we should fix this differently?
> > > > > Or perhaps that the problem doesn't exist? The change doesn't
> > > > > seem very intrusive..
> > > >
> > > > AFAICS the race is possible even with netlink as netlink_unicast() =
runs
> > > > without the socket lock, too.
> > > >
> > > > The point is that for UDP the scenario with multiple threads enqueu=
ing a
> > > > packet into the same socket is a critical path, optimizing for
> > > > performances and allowing some memory accounting inaccuracy makes s=
ense.
> > > >
> > > > For netlink socket, that scenario looks a patological one and I thi=
nk we
> > > > should prefer accuracy instead of optimization.
> > >
> > > Could you ELI5 what you mean? Are you suggesting a lock around every
> > > sk_rmem write for netlink sockets?
> > > If we think this is an attack vector the attacker can simply use a UD=
P
> > > socket instead. Or do you think it'd lead to simpler code?
> >
> > I was wondering if atomic_add_return() is expensive for netlink,
> > and if not, we could use it like below.
>
> Ah, got it. That does look simpler.
>
> nit: Please don't hide the atomic_add_return() in local variable init,
> as it need validation and error handling.

Makes sense.
Will post the official patch later.

