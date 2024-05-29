Return-Path: <netdev+bounces-98892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337108D3181
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627B41C23635
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C96180A62;
	Wed, 29 May 2024 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SintWRtc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01F516A381
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971379; cv=none; b=rCufLw+sEN8w98kVAokNNoozywV6RlAurwlVyv+zmpMXt/rfoMv0AzIzuJjt7fD7K9w+zB1nEAxT24VjW05/laDwtrRsN3ZWcTqMKCb7iJ6MWi5ISMMsv2mC/dwtpdCM4H3PX2I0SrLljVyqdSXskyuhDbk7Q7QZMrzoCgw/hgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971379; c=relaxed/simple;
	bh=1YVdUCwouStxfwxnG32hP50AhXVdPgyiygSC//AbcxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKNZyfswN9KDIc0AGNoEKeaeFPf9xVg2FtUz9lifk38eBobr7OHeOqhJKZ7wb07ZmHBgjfp8fMARfINsHYu0zSmZx0KEP2N5nYsQqm4qPlZD/diIMH8J8l1y/CtzKiQeIpl7RyNqM6N9vkaA4yP6H0oUavK+vtioEUtcUnxlODQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SintWRtc; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57863da0ac8so7253a12.1
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 01:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716971376; x=1717576176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YVdUCwouStxfwxnG32hP50AhXVdPgyiygSC//AbcxE=;
        b=SintWRtcydtx+Z5Gyw2nxTtEI9RjAyWtlUnkEQCsI/EvwHmU+Be7mvcukYIirr1T1K
         2DumjSqQRcBBtpRp1LhZkjMTUJ9Iq3Lo7+rgEnvGaJpvTMixFpG2OngX1CJlkwvAyFPi
         IO6zQbnGpup1yL08fn0Ev7/MwUXirH+uGKbLGikIUncYAGkUMjmOkJe/Q+itcXBh2I4S
         NKZau1nK1Nd/abk6lj6JSNUrBPOzW9nVHXzMUG25ZYAhjIjF2/4ViXtcpy9jWvhlbRv+
         pF8Su7fhUaAvLOQ57Zp/gkFo3AAsMKto+XQskzh+/26haOrO7El/0AbUAztD1zvNIpG7
         k/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716971376; x=1717576176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YVdUCwouStxfwxnG32hP50AhXVdPgyiygSC//AbcxE=;
        b=HDoIlSmAwiMl22oitUZJ/KZjwm8WbO1bvY0OZZpak2BTMcGudhYTA1aAIZQOK0+Hlt
         xwMZ0q7AYYKXVy90rBdr7NHvU1mECtjhK5jeADByB6QjPXH24zWWXIYD3jiwoeBf2pBx
         t2WzgtR4uxSHKarySLY/D9PW7YsSz3y6G0Py3ayyTdk6E39lNb1W8lTsYKcH/+6QVFSI
         +WzBULqMJlHPlNyoqtnqRkCw77BRbxN+Wj04tq8T1mP5IDkokdZ1rTlbdM9bblua4UCH
         SoY1dUFEbHhQxvED4MfWvGRbP+r3hPn8scTnXaGxRKhb7bZVriLadCQrfPOeRrK4/XTe
         416A==
X-Forwarded-Encrypted: i=1; AJvYcCWGBwR7jeYTpQ54TqBhQsfVz5NXqx5g1BXDPEVJSEjLoCPgDDw/SUWhwkEnBsxJemUMk4qkMupE9TnzUYbz7C5jT755IwE7
X-Gm-Message-State: AOJu0YwaJmSZpAMCCeVGmxtPomz+WQfJd81eGNWjHNed5EniHOQ0TvGG
	uNBzZ0JI0InXJfSThdgY+nCRsNvuZ5dQEgFgLrobCuBBVvNv/iF9d/hoF4Uwa/2xr6yy6FgmqVn
	C//P+qf8CgKJGW8+1W4dFFtPdSWJQIT6OM5NK
X-Google-Smtp-Source: AGHT+IGAhtDvsJERwf3pb+t/VLOUXZcR/4+FfDaCdhT+APDm0SbJawgi6YlMKOwTLAhHnB/JKadI8zSAKP0IVHve4qg=
X-Received: by 2002:a05:6402:40c1:b0:578:61c0:eb0f with SMTP id
 4fb4d7f45d1cf-57a05d1fae1mr93618a12.3.1716971375558; Wed, 29 May 2024
 01:29:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528203030.10839-1-aleksandr.mikhalitsyn@canonical.com> <20240529-orchester-abklatsch-2d29bd940e89@brauner>
In-Reply-To: <20240529-orchester-abklatsch-2d29bd940e89@brauner>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 May 2024 10:29:24 +0200
Message-ID: <CANn89iLOqXZO_nD0FBUvJypgTA6NTL2dKvXYDxpMuZReYZXFDQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: correctly iterate over the target netns in inet_dump_ifaddr()
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, kuba@kernel.org, 
	dsahern@kernel.org, pabeni@redhat.com, stgraber@stgraber.org, 
	davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 9:49=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, May 28, 2024 at 10:30:30PM +0200, Alexander Mikhalitsyn wrote:
> > A recent change to inet_dump_ifaddr had the function incorrectly iterat=
e
> > over net rather than tgt_net, resulting in the data coming for the
> > incorrect network namespace.
> >
> > Fixes: cdb2f80f1c10 ("inet: use xa_array iterator to implement inet_dum=
p_ifaddr()")
> > Reported-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> > Closes: https://github.com/lxc/incus/issues/892
> > Bisected-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > Tested-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> > ---
>
> Acked-by: Christian Brauner <brauner@kernel.org>

Thanks a lot for the bisection and the fix !

Reviewed-by: Eric Dumazet <edumazet@google.com>

