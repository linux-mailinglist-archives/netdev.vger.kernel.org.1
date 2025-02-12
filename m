Return-Path: <netdev+bounces-165644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0556CA32ECF
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACCDE1633BA
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A79525E44A;
	Wed, 12 Feb 2025 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+R1sIAV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD36E27180B
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739385517; cv=none; b=Vqzk11HdC1TGHp2Oam2tC0DQVMwdiFGahCN0f3AT+Vfvzswd0vUHWE1H7C+VTHhIlLQ+CjZ5FYekQGJStlqsE+xSU/HyopcqLu/R0RTyEMVboYMc1DBg23RVfSML2+vPthp6kAbH4UMofC86xzvzUaUzu9eClciF5o8b9rytUsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739385517; c=relaxed/simple;
	bh=QVCYTVU8LiGmk0M3iNqijrKpq1UDqWpQa6sejgp2Ys4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJkB+dm1ZUGEmnzdvfHxpulMK41997/hwaGdtPXrcCE3CFsGmPC6pKXeWEJa9zaSVCvQzJ/u6RMf1tu/u+L/+xi/VLpW7H8w1W+ifWgsXwWa75fyYSJ7hGxtR3vdgRNSQ667/CqNPm0hpznku2WUbRIDC3ZavD3jzzQq2euV+Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C+R1sIAV; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5de4c7720bcso8879461a12.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 10:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739385513; x=1739990313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5jTIzx/bPufJIf1+ZJKOm91YQoGHKq4l5RNGzz7IbI=;
        b=C+R1sIAVCOsWiE9HQtEG1iNNoN+zKe5moR4fRBBJh9NavXMPybwS04cnrUlrDvgrqS
         qg/glZzUB7y+/jbc5We5rz3nmUEL8sTdxKzlEx180xCGX9qjh6hpFQreYio8jjJkqauZ
         PvUCZ343AnHDtifbqcu09hQHyTnKiZhXO2fj2bYEqRLK6XBVwypqadRnRDDIqi6PgbyK
         8ZdpEJcd6Z3eVwTUUcWJ176rXOLAHJ2zf3YDuF+e6nhhQo3TvVyQVRrufnPijqVUBIU9
         AeL0lJO4Tji1OqOi7jjC03XUSq2fI8vRcDlAtYw20p7Un7p8GsPrevtNG+W8VDKX/KOv
         U0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739385513; x=1739990313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5jTIzx/bPufJIf1+ZJKOm91YQoGHKq4l5RNGzz7IbI=;
        b=EQqcR/QmFteuvvNvK/rCL94xf4IwANv1yhQ5YoCgBBPZjipEYU6FxMBjN2p26KzhHV
         O1x9JmAKavtKTTPFOD0KkwzRxZ1UFNWcP0N5xYdcGeUgv537EVDIAkLfU4uhVSWXzfi2
         eM1wUd3u8evnu1SC8nJUQQ2vOK65pG1VfDqxjxT90DLvPig838GZ87ioOhbNqI5u6rLe
         jwWDmSXAMBALKveyQHpdqsY+a4++QUYW9V8z4XqtD6s+0Inx0p+Vtj5kgRu4CvCZKRM8
         VQJJTZwDD6W0V6WmmqUudtOQvXmdM/LdPhO1env02x/4rRfxUDPvq5wsDnTKsMZn+cj3
         3cvg==
X-Forwarded-Encrypted: i=1; AJvYcCXvSQoOmY/ZUDbh5JZ78sVSyCZ2D8Jcl29w/cjGO1DmcMiRUFSeh9qFPdUgu2TxYJMJVg/wVNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAv8qyHLtdV1gFEOBUKsei1b2P1AGFKxHKZddLeh+SPm0ez349
	Qzi55pD9iHHZRqP8qz2xsDPEJoYdC7E/4BcDSVoJOC/PZGH7oIWhhWiAOL2MLCGrtGBf7gnkSKB
	moyHxPIhxICA0j78n3RuvvYqSseHYKUWh3K+U
X-Gm-Gg: ASbGncuHrzMQG2DZpEzDaoMrva1qJpAfiabUB1GGKEIF5KCIkOEv/1P47I3rJXT+YZy
	faRuAtYjIk1dbKNnZALSvIkgYHaQ/VZiHhNz08m7mGWSJsVn9iKoRLdLNKGbeMwrEJnImiMMN/Q
	==
X-Google-Smtp-Source: AGHT+IEqzrGCoCKzyE7nbWSFFqAJZYcAj4nVo8djy3ULQafbk14rQlv917mN/v2a7FHeqYwE+erP5dC3RuTZGs2zaQY=
X-Received: by 2002:a05:6402:510f:b0:5de:5cea:869e with SMTP id
 4fb4d7f45d1cf-5deade0125emr3765753a12.32.1739385512953; Wed, 12 Feb 2025
 10:38:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212164323.2183023-1-edumazet@google.com> <20250212164323.2183023-3-edumazet@google.com>
 <9f4ba585-7319-4fba-87e0-1993c5ae64d3@kernel.org>
In-Reply-To: <9f4ba585-7319-4fba-87e0-1993c5ae64d3@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Feb 2025 19:38:21 +0100
X-Gm-Features: AWEUYZnVtUPoGPe1z13LSHIVV_GE1j5vuxJ_e89clDVaahbpK6uYv_ruyQqY8_E
Message-ID: <CANn89iLiEcbnbMj7MdCTPsxoT3fHANALZ9LAAsG9T+sWcv-vew@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] ipv6: fix blackhole routes
To: David Ahern <dsahern@kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Paul Ripke <stix@google.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 7:00=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 2/12/25 9:43 AM, Eric Dumazet wrote:
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index 78362822b9070df138a0724dc76003b63026f9e2..335cdbfe621e2fc4a71badf=
4ff834870638d5e13 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -1048,7 +1048,7 @@ static const int fib6_prop[RTN_MAX + 1] =3D {
> >       [RTN_BROADCAST] =3D 0,
> >       [RTN_ANYCAST]   =3D 0,
> >       [RTN_MULTICAST] =3D 0,
> > -     [RTN_BLACKHOLE] =3D -EINVAL,
> > +     [RTN_BLACKHOLE] =3D 0,
> >       [RTN_UNREACHABLE] =3D -EHOSTUNREACH,
> >       [RTN_PROHIBIT]  =3D -EACCES,
> >       [RTN_THROW]     =3D -EAGAIN,
>
> EINVAL goes back to ef2c7d7b59708 in 2012, so this is a change in user
> visible behavior. Also this will make ipv6 deviate from ipv4:
>
>         [RTN_BLACKHOLE] =3D {
>                 .error  =3D -EINVAL,
>                 .scope  =3D RT_SCOPE_UNIVERSE,
>         },

Should we create a new RTN_SINK (or different name), for both IPv4 and IPv6=
 ?

