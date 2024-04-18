Return-Path: <netdev+bounces-89009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2948A938E
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895221F216CB
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 06:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637BC2CCC2;
	Thu, 18 Apr 2024 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck3jYpuo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF83200DD
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 06:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423226; cv=none; b=ZU7FyY3/k8KIlRgsknkR/2HSXLwTjVwKI/G6roPj7Mv5vpTetF7Bd1oIWLNY9ofVb+dHNcGUqCpmAPBiuqXh3ouTsEx+ASN7t/k28sp7UR3eeHtxGsgQPUCCTCoK73zNOi4YHRlPSif+Ux80pdsWA9lRFPG2NQI/VBsluTM//u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423226; c=relaxed/simple;
	bh=RMfzxNFIU+6QsnVvuNbbep04AAFVBqsSgjjCS5OioYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inLLwKjaX6WvtO/jrO/VfhO1rcXQeKVZBP22haphUUvZ8zC0KnXbwUdWapnsPCTVIhen1D/4R5XXgnNLbloWRHk7QpVJX1CQVyKAyLJTCHSXLPCDaV6s+Au4eZOJqIsd6LndT30MB0NszlBfQ/MBJVT/WVa9bRnor202i1WzIMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ck3jYpuo; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a526d381d2fso285302766b.0
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 23:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713423223; x=1714028023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGcK8BpacS93dC0FGsCLPelZu1ffIr9i82qrlsXryb0=;
        b=ck3jYpuo/oFkaLTjXFgP6+KmbhUmHpKmg0UYkzbp5c9E18z61ZdNhRWabpHuvzEQob
         yT2EcHkcemzq05FXDrDI/dnsfDGAWmdimBU55ovq/7XBCQ+W2r8UfIpZeYFtErINDIzR
         X7dBoFTClkIltVrg3mIKaP6xR+JTJd1UeSG0s2GGsNC8dLI0xknDuJYxUfHIcn8HnJnE
         rKrN/UTigDL3IrvFI3H0abjBe9KAhBSRJqKWQju0+C/hAFyYoPf3OIIdK1t/RKq9CkS+
         +v4xlupigPw/jQ5+2QJHWy8mjXFTvgrdFoKArFBC+HpWnTyT5W7Im8skNiT2e/ZeIUO8
         LfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713423223; x=1714028023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGcK8BpacS93dC0FGsCLPelZu1ffIr9i82qrlsXryb0=;
        b=b8TvN/+dgbICMzSn9ftmgFPG2w/4GEsWPZJFF9yDNHfoxU5ZpMALJyoXX1TQvR3ti5
         6EoEqZdTgT3DBBpf9Qy8wnYWiEZOxvF0oxCnVOudsvPP4v7bup+ZHyFSJ+X1VVKLQ+Bg
         yTZcaAkj/+TKHcgCVR698j04QKmkwLdT4soy2nTaloLp80gWW/K7n+5UY6Lfayo0KLWx
         siO2aZfPZbLqsQ+6vMrXy4IvDABKcicDxmhfcUwMkz9dBEAokVMe30wDKNPZUtG8Euvu
         dokqhlnoefqxJlU3XsGEJcsGd/9LY2yLb5Yd4P8LzviC0KYtlYeJDPRjF3gOha7EuCRG
         cOIw==
X-Forwarded-Encrypted: i=1; AJvYcCVa3L/x8vDbsV+SFFw1/PDJoCEcgI8m4N91MKxe82+rcOIMesBB5n3oG8rlgnfhooDTGrSI+TjOJTA9/WNl+qtiUmh4B8+S
X-Gm-Message-State: AOJu0YxcRwbOJvgI/MZAILMhUGY0MJtNqMIWQpZ/iSfxB2yAkkdKFLx9
	g15NVKhJoSbIt8P37CY8km0pmN3Y6XA7dEMyfiJKQj21v1ZdA8VNUZFYB9YHyBmRT2LoPemlcmf
	bvOj4TVJlmmknVvpnzNGbxXS62II=
X-Google-Smtp-Source: AGHT+IFhE9FtQ86pIPr0E4OmYEU6tYGUN3kdvTcvFxmW6Z9l/sC1VLd6ERmXH8CaAgM8yVJ+0vyODf1rk2Ln6h3Rkyc=
X-Received: by 2002:a17:906:b20b:b0:a52:54f2:6d0 with SMTP id
 p11-20020a170906b20b00b00a5254f206d0mr971477ejz.15.1713423222755; Wed, 17 Apr
 2024 23:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417165756.2531620-1-edumazet@google.com> <20240417165756.2531620-2-edumazet@google.com>
 <CAL+tcoB0SzgtG-3mAYrG6ROGbK2HwqXCTo21-0FxfOzKQc397A@mail.gmail.com> <CANn89i+BQR+yE8H-oPaGt86Vo9DHfeg4DRhSqkKM4WqY-tJ7NA@mail.gmail.com>
In-Reply-To: <CANn89i+BQR+yE8H-oPaGt86Vo9DHfeg4DRhSqkKM4WqY-tJ7NA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 18 Apr 2024 14:53:05 +0800
Message-ID: <CAL+tcoAMEM-yyahPY=bZkj+i8niePOVGEO8OzjeuWA871xFc+g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: conditionally call ip_icmp_error() from tcp_v4_err()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Dragos Tatulea <dtatulea@nvidia.com>, eric.dumazet@gmail.com, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Willem de Bruijn <willemb@google.com>, Shachar Kagan <skagan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 2:45=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Apr 18, 2024 at 5:23=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Thu, Apr 18, 2024 at 12:59=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > Blamed commit claimed in its changelog that the new functionality
> > > was guarded by IP_RECVERR/IPV6_RECVERR :
> > >
> > >     Note that applications need to set IP_RECVERR/IPV6_RECVERR option=
 to
> > >     enable this feature, and that the error message is only queued
> > >     while in SYN_SNT state.
> > >
> > > This was true only for IPv6, because ipv6_icmp_error() has
> > > the following check:
> > >
> > > if (!inet6_test_bit(RECVERR6, sk))
> > >     return;
> > >
> > > Other callers check IP_RECVERR by themselves, it is unclear
> > > if we could factorize these checks in ip_icmp_error()
> > >
> > > For stable backports, I chose to add the missing check in tcp_v4_err(=
)
> > >
> > > We think this missing check was the root cause for commit
> > > 0a8de364ff7a ("tcp: no longer abort SYN_SENT when receiving
> > > some ICMP") breakage, leading to a revert.
> > >
> > > Many thanks to Dragos Tatulea for conducting the investigations.
> > >
> > > As Jakub said :
> > >
> > >     The suspicion is that SSH sees the ICMP report on the socket erro=
r queue
> > >     and tries to connect() again, but due to the patch the socket isn=
't
> > >     disconnected, so it gets EALREADY, and throws its hands up...
> > >
> > >     The error bubbles up to Vagrant which also becomes unhappy.
> > >
> > >     Can we skip the call to ip_icmp_error() for non-fatal ICMP errors=
?
> > >
> > > Fixes: 45af29ca761c ("tcp: allow traceroute -Mtcp for unpriv users")
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > Cc: Dragos Tatulea <dtatulea@nvidia.com>
> > > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > > Cc: Willem de Bruijn <willemb@google.com>
> > > Cc: Neal Cardwell <ncardwell@google.com>
> > > Cc: Shachar Kagan <skagan@nvidia.com>
> >
> > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> >
> > I wonder if we're supposed to move this check into ip_icmp_error()
> > like ipv6_icmp_error() does, because I notice one caller
> > rxrpc_encap_err_rcv() without checking RECVERR  bit reuses the ICMP
> > error logic which is introduced in commit b6c66c4324e7 ("rxrpc: Use
> > the core ICMP/ICMP6 parsers'')?
>
> I tried to focus on the TCP issues, and to have a stable candidate for pa=
tch #1.
>
> The refactoring can wait.

Got it. It's clear.

After this patch is applied, I can adjust a little bit (only by moving
it into ip_icmp_error()).

Thanks,
Jason

>
> >
> > Or should it be a follow-up patch (moving it inside of
> > ip_icmp_error()) to handle the rxrpc case and also prevent future
> > misuse for other people?

