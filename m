Return-Path: <netdev+bounces-164382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1D2A2D9DE
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 00:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1EB91666F7
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 23:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D451C15098A;
	Sat,  8 Feb 2025 23:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="plpGmp+Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F72824338C
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 23:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739058454; cv=none; b=gxfgSajNa3PFQMldXrK9pNssSo0XfiRGIHliWxdAr8Q+azfqItdInAB9rbSroFmpNaNNbBmvwp5rbtPxFw9jYgqaZ/nrWvfcs11mk+GQ3yDFQxihrZzVtz36H8N8J2D5qBUkcmQfqSTvW2yKXJvIEuax8kBhQuomSVjqF/bCSJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739058454; c=relaxed/simple;
	bh=a/V6gU91u8c5TI/zgsBtn8vW4Q4mYaOWMA9T0lEiU4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vl53e3RUC9k6NJ2Vkj7eZDMaRQAwNwh9ITCBfMjhP1P5hXh+7XkrC4ESqfJEeNgVUwRhfMy/fF1fwvgB5eLjaN6AowZzoZHX06xvrGjF/VwRotq0c3Aifq4uuwyTqK2CStp8YqVo+lEHzi9bv7lreP09dqNgufebU8ccE6t7UHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=plpGmp+Y; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4718aea0718so17771cf.0
        for <netdev@vger.kernel.org>; Sat, 08 Feb 2025 15:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739058452; x=1739663252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ak8Pda/vuiPhQbiBcsLOKpynRxDkmjb3xLh6rNqV+4=;
        b=plpGmp+YmmJ+XBsbNHflR//VFeLRnIGN/CTfygi13yD22J3J/4dm/msZTPdS4qNPif
         OjZXqpy+9vvFNImn3/A1Rzy0Cka2aN8Sl53/HLu83oct39dZT77lKoXxLmM6ImJCRxLx
         +wpL0yQ3ByFXCJGVzFhcm8QsJAB2k5zFNR/+1sAtZqfgDu7KAY3HF416MVl2p7Pa+tHP
         +zUfZm2l0He/2pFo3uacZiM2CpC/Y5u0ikMfP/P+IWbyUbjbfospnHXRmMS9Rr/AoJwj
         GlQT0AeHQkhAlbkYJ55RhOabYfk3Gt3Ch35gBmKnCMeh7l3Tyc4RCtJFbBzGeBMF7u7A
         j67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739058452; x=1739663252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ak8Pda/vuiPhQbiBcsLOKpynRxDkmjb3xLh6rNqV+4=;
        b=gqsmgxdQUn0TMPiEhWOVWArHe+UC9Hd9taTn5py1knA/cqBKWl2IwdlG2tl2IL5++p
         hPSqfKk+H97v4pMERG0tsO6OKqghZc0tnEVxVRoEBb5YkwmPm8KpMVBeuTHcFLdMHQ2J
         x/qeLl1scTrIFpTr9nAXgtL6X3C0cQs4x+y4kyw/AfBaiJzjli4NpQJxFj8NALOPP8Pf
         CUYOm6f+YMlogUHQ8jEECOeMQeYEk7wUBaBPmEr/KvqakDAHM3LgdyV9B8MeAN4kAp9h
         1ewWheyLv1QoEamvcqZC2c2CaqnEJQDvq37kJ6w3jyhvndOxb61AagYf2xqOOSHmyxaP
         wNXg==
X-Forwarded-Encrypted: i=1; AJvYcCWpp62UQEDJIEq5ROzpxt66WiM+IpFcpfhUDj1RSV3iTDsXqwievUVNTW+h6lyVIPL/d5m6LSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO8gESM6jQv5KmzMMTdGlj1MpX+MHuGvrLiZrS4KZHO244ALNe
	CIX3y8KoCnOjNyOCV69gioKdlmzns5gPgQpQQo2cWAKEgHhh7xUnVvd9X/gOjSnklmLWfJw8hLU
	glcymBjUDdqqPFo9a67Q9VcNERKWBPLw/sXpc
X-Gm-Gg: ASbGncvqbHTaJYa7IKjbjs+UyxzMmoNcR771CDIx5VAG9Lq2EBQwIHRtzVEPRtSxSWf
	aWXMjwBht3eoDvJ7j4A6Vpg+0WxGvYZVwd8rYnFb/SHGYNMsmTuse9ZU+f+gGDabJlnW5XZQ=
X-Google-Smtp-Source: AGHT+IFIUp7XdyN4bbk3rG3zHqxJs8syMgGzsBsAuphkouX4olp3h4P2R0JNzFRv3dY9G/CqG5dPAAqTSrm6h1jPkFU=
X-Received: by 2002:a05:622a:590e:b0:466:a22a:6590 with SMTP id
 d75a77b69052e-47177e8b82bmr3045701cf.9.1739058452048; Sat, 08 Feb 2025
 15:47:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207152830.2527578-1-edumazet@google.com> <20250207152830.2527578-4-edumazet@google.com>
 <CAL+tcoAKqYMWQZrVReZ_LB4mFqAh_nwtk0AfyYV2BSNNY6pgdw@mail.gmail.com>
In-Reply-To: <CAL+tcoAKqYMWQZrVReZ_LB4mFqAh_nwtk0AfyYV2BSNNY6pgdw@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 8 Feb 2025 17:47:16 -0600
X-Gm-Features: AWEUYZkESFK-ss0bwIjfO6ueAj4b9N1zXGDsWRTdy83EjMRo4ibd5Sl3vPLK2NI
Message-ID: <CADVnQymb6q0mthtHxhzwANftQw+kQyJCMCpAvjeGJ31T92dtdg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] tcp: use tcp_reset_xmit_timer()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kernelxing@tencent.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 11:33=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Feb 7, 2025 at 11:29=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > In order to reduce TCP_RTO_MAX occurrences, replace:
> >
> >     inet_csk_reset_xmit_timer(sk, what, when, TCP_RTO_MAX)
> >
> > With:
> >
> >     tcp_reset_xmit_timer(sk, what, when, false);
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

