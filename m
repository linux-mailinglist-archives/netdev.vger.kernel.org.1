Return-Path: <netdev+bounces-89639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B47E8AB043
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 16:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 978F2B2586D
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 14:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5888E136E1C;
	Fri, 19 Apr 2024 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SUqJ5VZg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E0E12CDBF
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535450; cv=none; b=mhOOx/GcLf9fXsqWYCXNSg/ddYEy/15jhvL+6MFAbya6nwUGQAbsMsR5bb0QkSDRhu3g3RaZbJR4MydGMvR60yAZcIso/dN+Om901k2M2DQvD5zAweNtI9+f5dKXU/9SQ+VTUzLpt+a5lk0yoGyjOPK72Xk8Djquj91uZVa1h1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535450; c=relaxed/simple;
	bh=081xBFDfqL5Vw/xAQiMf19HcLzBElvmjCJcgVbDj85E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXY61ajyHvNrwWSV9qLSltJNVE9ClloIIdV8xP5x0jD7KaiqQmn1k+bhIc2SW4cjbu2a4/8D7etNtDrgmziTryicbVI+j1WE1leFt6fUaF5q82vZWj1XN0ZJ3OaghDOl/g3bZhCysB9yhKckZ8zDioogMfW/11Zt2eYUA76UOYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SUqJ5VZg; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so12050a12.1
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 07:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713535447; x=1714140247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgdjcSpW45D9KNDKVsCnocu4g8t94PkEWHXaAaMBiM4=;
        b=SUqJ5VZgjaHqwKyfwPOn46b0Ek5CAQKMeZFfHJ7WGtMa9nxLoxtVqsaDeq9BJAU0zC
         jPyXpMjITfTW30MIjYaxFNUAumJaP82t6w2kXTMoRf24sm+SAboCX/i/u/FshrKcSptm
         G6fN1YgY2tipTQjUFt+nBewW8G0SBdkeuXjLydr5kP9IIegVrJjwBiCfarm82HbMcBAP
         SEAE6fDJuTysLJbAyOpogQBAImwNYlNt6hPsQSDRlJVkZ2hhe/9Hg+yuOJScDeAZ0BE4
         WViNNwvLIsbvt+Aj2hynAAXOcWijCcUfrS5+yfhXu8d5/BBqcbr6KSgTvyrT7IT4Ahld
         uizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535447; x=1714140247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgdjcSpW45D9KNDKVsCnocu4g8t94PkEWHXaAaMBiM4=;
        b=TtqYS64dJ9yYnbhERczbHZjIfH0xIB5p9x3HVKEdRuC3AWlTkjSKMpoEgzUyl5IEJo
         x1v2xaTr6+jLZVUQ3L4dU+OmI2N6D+YzwNgkO9ZAkHlDUvQBn4FxsqwsZCTF+chNMhHm
         epCbEW/P35YTlD9O1Nw0US9mN62xEl3u+WliP5Pf5igC8LhwzhSYQz/yNTf6vFq9gp9q
         gbYbw6xF0IbMqHWiUeWFp0FZhMR0TohqdqIjtYzbS8X8G2aohasZ2upuUbNehlY9CIRG
         W/qe5gdUIUXhMie7Npgw7+rS6l62ekItSTLKMayVc7W40Ktr1s13K+a22Keh7MG+uBP1
         Jq6A==
X-Forwarded-Encrypted: i=1; AJvYcCVd59yGOIw8SwG2cqQXQM134NS2CoVRXq0iOTOlEkKNhXnkgaV/4ngeZp44EyM3yflZgHhUxNJEwHpWzhMAr8bGgDMXQxJX
X-Gm-Message-State: AOJu0YzZF3SkFBEnp8VVq5XZivpAKn78klT8e3awbVPY+gARgY9CzrKT
	b1KRo0bOig3dZ1DYuMTwbNb8oiTl8c7j3u3DNFkmYFTTZtDRsGmybU8wTnsdVHC2hAlEADb1pz6
	d4QdXU9VGwYoJhrtPHBrvB57WpcMtMWXA2gZa
X-Google-Smtp-Source: AGHT+IGrCIxn0+mAAt74WL1Uh7YRnchWQBRUnU00Tsly++iSIFUA0fDnu/XcmtwzS840RE8Q8QtXCcAPzbd+n+gi7Kc=
X-Received: by 2002:a05:6402:1e94:b0:571:bc8d:4b6e with SMTP id
 f20-20020a0564021e9400b00571bc8d4b6emr184418edf.3.1713535446709; Fri, 19 Apr
 2024 07:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419105332.2430179-1-edumazet@google.com> <20240419064552.5dbe33e6@kernel.org>
 <CANn89iKjwOfGTiHjE-JaWaxxDZVfsWzaE7AkVigHGLEPwXaepA@mail.gmail.com>
In-Reply-To: <CANn89iKjwOfGTiHjE-JaWaxxDZVfsWzaE7AkVigHGLEPwXaepA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Apr 2024 16:03:55 +0200
Message-ID: <CANn89iLmY26C05__4L9esOkBn1nEU8N7w0yBOU=CSbF7DQ6Aqg@mail.gmail.com>
Subject: Re: [PATCH net] icmp: prevent possible NULL dereferences from icmp_build_probe()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Andreas Roeseler <andreas.a.roeseler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 3:51=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Apr 19, 2024 at 3:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Fri, 19 Apr 2024 10:53:32 +0000 Eric Dumazet wrote:
> > > +     in6_dev =3D __in6_dev_get(dev);
> > > +     if (in6_dev && !list_empty(&in6_dev->addr_list))
> >
> > There's got to be some conditional include somewhere because this seems
> > to break cut-down builds (presumably IPv6=3Dn):
> >
> >
> > net/ipv4/icmp.c: In function =E2=80=98icmp_build_probe=E2=80=99:
> > net/ipv4/icmp.c:1125:19: error: implicit declaration of function =E2=80=
=98__in6_dev_get=E2=80=99; did you mean =E2=80=98in_dev_get=E2=80=99? [-Wer=
ror=3Dimplicit-function-declaration]
> >  1125 |         in6_dev =3D __in6_dev_get(dev);
> >       |                   ^~~~~~~~~~~~~
> >       |                   in_dev_get
> > net/ipv4/icmp.c:1125:17: error: assignment to =E2=80=98struct inet6_dev=
 *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer without a=
 cast [-Werror=3Dint-conversion]
> >  1125 |         in6_dev =3D __in6_dev_get(dev);
> >       |                 ^
> > --
> > pw-bot: cr
>
> Ah right, __in6_dev_get() is not defined for CONFIG_IPV6=3Dn...

Nope, I just have to add one include, that was conditionally pulled.

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index e1aaad4bf09cd43d9f3b376416b79a8b2c0a63ca..437e782b9663bb59acb900c0558=
137ddd401cd02
100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -92,6 +92,7 @@
 #include <net/inet_common.h>
 #include <net/ip_fib.h>
 #include <net/l3mdev.h>
+#include <net/addrconf.h>

 /*
  *     Build xmit assembly blocks

