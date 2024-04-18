Return-Path: <netdev+bounces-89008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E6C8A9373
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C531F21E22
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 06:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5FE57334;
	Thu, 18 Apr 2024 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a/s6STIM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712B839FD4
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422752; cv=none; b=umxy3IfdrAQgciWKC2jf2gsYoO6+fskkTWcuoll7g2Quw+6r915/lzJ3ZoqFX/9W3PubXBpiVT+YxYuHRbI1uO3VA2+aRhzo6No14aO4fYTreOH72XkQkEwKg1+Tfyz7tmAe0RlCJ/En5+i2i9lQDwnJjT+MLO/vC3nqrSgqhsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422752; c=relaxed/simple;
	bh=lCUHPdFnBd4NjcErHjO4SvijbWleJcowqrzwjulXax0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzWFJHr6lspbLS5WfQ/06hVPKEcdBWHaUSpePSeMciariZ/e5O7d246cWNFF4tyq/fwI9FEhIXKEZXUYuqWlj6TKIjtDjlCNn0oEkeP3AsHGSsRujOGY/1gqkzQ90npEPi4uF2DCOTP6dtRJ7tvQPAH0lMJXHvJWYn66FucU4AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a/s6STIM; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so6398a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 23:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713422749; x=1714027549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTTUlj7Aknj7w/0ZujTPXVavRhAX14b5W+gnVGdQHZo=;
        b=a/s6STIMTw7e5kPdfKRTCzMaplRs98Yqi6lYe1KeOID7ZBGo6+Gwcb+FtOfx4Boq+x
         BTgMpjGjgH2gcBhf+vyzXyXX26iLGZtdlcqc9FByKoA1U00JpNjYqi3cGncYy6Fhx6EO
         rc878vr8WPHo3IjIKYTxUn6OM8dFd2uVeI9PhUvY3H39I3KMxTRxntlE+/bgrNRSHBeN
         19atvpJdVpom123ikiJopoK0VGilusywbpmwRhT8yNv5NXhg+5lYojaW3lZ6UUYqovUF
         29KU1xicj0u+SIonruYWBwFNxp2NNIBpyCVUsh02wJAhtKKzUM2gwiguN2rQj+luei5U
         qdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713422749; x=1714027549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTTUlj7Aknj7w/0ZujTPXVavRhAX14b5W+gnVGdQHZo=;
        b=gT5l6Wy3fl9nYWkXpHx5J6oVTIH/cCFTNUzoiYcd/uqKkl2HyJMabCu1aU2iwgTZaI
         QBvBk1inKytvl5xWlY/T6+/yn/5Fdb/cS5h6UCPin670rWRaZLMSYG+N0kRcBOpt9ITL
         uBWRb0Q/XYww4IfInod70bQ3L5Tic3/kl23Ism0dHNSkpFiO8IvPzJendem0d1Y/V8hk
         xixqUl64UpHtESQS6I8L3UamraKgLGyaeFoQgj8gPWHWnKs8JWr90E6uBrAl4c6wWImK
         l2ArGJdSUeKN2DRAXCXtcgXs/22GiDOapyQDDslTnsqiTP0Sx168aJFHiaHX88ZWpyX/
         N4rg==
X-Forwarded-Encrypted: i=1; AJvYcCXwOTHnPIMtN3TjfH82WbwVPGWICxhKB5k3RLA6rk7pi+waMY8A8vVIIbszrKaPdpjNyD4YVu72oxhEoRLEtOgsRYbmfVIA
X-Gm-Message-State: AOJu0YzSAUzFvQ/TXKeXih+1S+aC2F5ownOdp0mJxje37jupbFeVWz+m
	7Lw+EslgG2K7Q4Lhl2yylWReND9Shzt1wLNewhoI8sVCNO0KzX2X+fry1e+2Zr53MSGxpmijDK/
	Nh+L+7bl6iCZbM/rAZCC8iU8qBACPs1FXX0uo
X-Google-Smtp-Source: AGHT+IH79HIhOjD3+24nsocoYQohHnYqmkg0z7+KJZUwyZFoxnNPwlOyQtFfC86jOGYSkBILODmtBU7BaDEL4YBkNFQ=
X-Received: by 2002:a05:6402:1510:b0:571:bc8d:4b6e with SMTP id
 f16-20020a056402151000b00571bc8d4b6emr26020edw.3.1713422748484; Wed, 17 Apr
 2024 23:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417165756.2531620-1-edumazet@google.com> <20240417165756.2531620-2-edumazet@google.com>
 <CAL+tcoB0SzgtG-3mAYrG6ROGbK2HwqXCTo21-0FxfOzKQc397A@mail.gmail.com>
In-Reply-To: <CAL+tcoB0SzgtG-3mAYrG6ROGbK2HwqXCTo21-0FxfOzKQc397A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Apr 2024 08:45:34 +0200
Message-ID: <CANn89i+BQR+yE8H-oPaGt86Vo9DHfeg4DRhSqkKM4WqY-tJ7NA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: conditionally call ip_icmp_error() from tcp_v4_err()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Dragos Tatulea <dtatulea@nvidia.com>, eric.dumazet@gmail.com, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Willem de Bruijn <willemb@google.com>, Shachar Kagan <skagan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 5:23=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Thu, Apr 18, 2024 at 12:59=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > Blamed commit claimed in its changelog that the new functionality
> > was guarded by IP_RECVERR/IPV6_RECVERR :
> >
> >     Note that applications need to set IP_RECVERR/IPV6_RECVERR option t=
o
> >     enable this feature, and that the error message is only queued
> >     while in SYN_SNT state.
> >
> > This was true only for IPv6, because ipv6_icmp_error() has
> > the following check:
> >
> > if (!inet6_test_bit(RECVERR6, sk))
> >     return;
> >
> > Other callers check IP_RECVERR by themselves, it is unclear
> > if we could factorize these checks in ip_icmp_error()
> >
> > For stable backports, I chose to add the missing check in tcp_v4_err()
> >
> > We think this missing check was the root cause for commit
> > 0a8de364ff7a ("tcp: no longer abort SYN_SENT when receiving
> > some ICMP") breakage, leading to a revert.
> >
> > Many thanks to Dragos Tatulea for conducting the investigations.
> >
> > As Jakub said :
> >
> >     The suspicion is that SSH sees the ICMP report on the socket error =
queue
> >     and tries to connect() again, but due to the patch the socket isn't
> >     disconnected, so it gets EALREADY, and throws its hands up...
> >
> >     The error bubbles up to Vagrant which also becomes unhappy.
> >
> >     Can we skip the call to ip_icmp_error() for non-fatal ICMP errors?
> >
> > Fixes: 45af29ca761c ("tcp: allow traceroute -Mtcp for unpriv users")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Cc: Dragos Tatulea <dtatulea@nvidia.com>
> > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: Neal Cardwell <ncardwell@google.com>
> > Cc: Shachar Kagan <skagan@nvidia.com>
>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
>
> I wonder if we're supposed to move this check into ip_icmp_error()
> like ipv6_icmp_error() does, because I notice one caller
> rxrpc_encap_err_rcv() without checking RECVERR  bit reuses the ICMP
> error logic which is introduced in commit b6c66c4324e7 ("rxrpc: Use
> the core ICMP/ICMP6 parsers'')?

I tried to focus on the TCP issues, and to have a stable candidate for patc=
h #1.

The refactoring can wait.

>
> Or should it be a follow-up patch (moving it inside of
> ip_icmp_error()) to handle the rxrpc case and also prevent future
> misuse for other people?

