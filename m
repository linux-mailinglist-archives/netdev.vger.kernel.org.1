Return-Path: <netdev+bounces-84531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D51897307
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD32286C48
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B16D2F844;
	Wed,  3 Apr 2024 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TVGqOFy3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D496A2F28
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155758; cv=none; b=Sd2UEurGW6pciiwW5JlYsvciwUpZlzW7wsCU1fP/yrvi8cnqSM8yT5PBxvprtuPlNEYJe2/2cR0tt/yRQl8vKE/4TMezUdJqV4W45CqkDq1/cGiQ1uZr1nE4LZOryp0kQUOsm+q10pOAEsXmTrLcElF4qwwqTTCiIJNJKPiM34I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155758; c=relaxed/simple;
	bh=4awJPXLZISd/HEXrTQxK8Hu/xsDdgCjosSawGYmE8ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDS8QpTLjeO0G9TN2gNg+DqoDta7vp9NV+37zyBzMfcwqOmhXaTmdyIDkdnxhvYn0uamwLeneaadbWJuaqf555KeDVrEBwfS6oLWDSxYYpGFXYTo0WhJ7Fd7vZ+7P4scwlWqwnLNfs5v//fFUHPwAtATO4BeA+Zs+B5WFuiWlnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TVGqOFy3; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e0430f714so14510a12.1
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712155755; x=1712760555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4awJPXLZISd/HEXrTQxK8Hu/xsDdgCjosSawGYmE8ZE=;
        b=TVGqOFy3rF1WnRfoJVDIvnWq5wt8YvxFvPR1hKmfeKfCBxt6RIMARR/IZLkSLOq5Pa
         JSGBNcFtta5kd8RLXFMc1cDu/Iy7NKCJx5FJKhOVt1W/ZVz3lrJ+Wl4TV/xxDNLXgtdn
         9h0DeITlURHvJJ/HYhj0WV4+VJM5bJ8NYMFFvAqznr84EHpE/Xm19JbaGg0FuGxLEkQy
         kL8lYeSAhAXiBTY4UbiN74yVbmXSzITd0OpzHMwAGg13DcCwcQi8I6AawEL6pCQnElan
         CyePmJdDW8JlKidsom2n9zzqfvAnDmA+boN26i8XJcPGsRsxNPCKjXZAzBoJqzZ14kAr
         P9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712155755; x=1712760555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4awJPXLZISd/HEXrTQxK8Hu/xsDdgCjosSawGYmE8ZE=;
        b=L9TrsuRCLscyEoFdUlV2cU8MEryGVzuZEs3lSAa5NmjnfVJjehcqo+kh/gP0DsG9ag
         /pdPZQU54lH5b2wbHhicZcmosebGi9DJtT8TG5qtGb5yoY4fDEtZVGwSxb5jwpQWcZr0
         fLALtWrd/D2XlRpzttnYAkOd1En5FBhiWR0kQHSMUfIp0qaBakaLR0qbCw0QqUhBLrMg
         m3lN7mh67sWOponqQfq0+EqpHXeTg2Ps92nAK7OISOOKyhcog4WH5nfkzZj8f0ZweLvD
         eLeWa9RrA/Wp8HKP4kaZH5GMFWCeYd5MBcQ09CEE2RF7jKf5t9EzXmbC5Ehih4BJfQL9
         JvxA==
X-Forwarded-Encrypted: i=1; AJvYcCXS54VrXYAgYoGDIzNQWdmhHrnPjyuiV0KqTKwHUVUVE7tffe/TNLmN6mwocToupZ15NhPPT4vxDWQi4VizEMG8F6t1f5TT
X-Gm-Message-State: AOJu0YwhE7YaScPxSOM4B/F2bfzuYJEiINsrZEKNsO1Mm4t0oDuxqbg2
	1wq2NHlpQ+r9yboo/IHPAP+j09gTLiCsZTPT5qxhKKwDuEBXvi/qGLmi3758mSMbs5bai7zSd3c
	Nh+TBQUI+gbh2MDcljKS1nOVpqzyoar10Quvf
X-Google-Smtp-Source: AGHT+IHdRA9FiadBl+tCyoU/K+6T+Ezs85509lMS6QuZPI0aP/28Jem/y5QgepFgzzYC0wnrV63+ee1i/AtoLwRtDkY=
X-Received: by 2002:a05:6402:5c7:b0:56e:ac4:e1f3 with SMTP id
 n7-20020a05640205c700b0056e0ac4e1f3mr106849edx.7.1712155754858; Wed, 03 Apr
 2024 07:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402215405.432863-1-hli@netflix.com> <CANn89iJOSUa2EvgENS=zc+TKtD6gOgfVn-6me1SNhwFrA2+CXw@mail.gmail.com>
In-Reply-To: <CANn89iJOSUa2EvgENS=zc+TKtD6gOgfVn-6me1SNhwFrA2+CXw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Apr 2024 16:49:03 +0200
Message-ID: <CANn89iLyb70E+0NcYUQ7qBJ1N3UH64D4Q8EoigXw287NNQv2sg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: update window_clamp together with scaling_ratio
To: Hechao Li <hli@netflix.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, 
	kernel-developers@netflix.com, Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 4:22=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Apr 2, 2024 at 11:56=E2=80=AFPM Hechao Li <hli@netflix.com> wrote=
:
> >
> > After commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale"),
> > we noticed an application-level timeout due to reduced throughput. This
> > can be reproduced by the following minimal client and server program.
> >
> > server:
> >
> ...
> >
> > Before the commit, it takes around 22 seconds to transfer 10M data.
> > After the commit, it takes 40 seconds. Because our application has a
> > 30-second timeout, this regression broke the application.
> >
> > The reason that it takes longer to transfer data is that
> > tp->scaling_ratio is initialized to a value that results in ~0.25 of
> > rcvbuf. In our case, SO_RCVBUF is set to 65536 by the application, whic=
h
> > translates to 2 * 65536 =3D 131,072 bytes in rcvbuf and hence a ~28k
> > initial receive window.
>
> What driver are you using, what MTU is set ?
>
> If you get a 0.25 ratio, that is because a driver is oversizing rx skbs.
>
> SO_RCVBUF 65536 would map indeed to 32768 bytes of payload.
>
> >
> > Later, even though the scaling_ratio is updated to a more accurate
> > skb->len/skb->truesize, which is ~0.66 in our environment, the window
> > stays at ~0.25 * rcvbuf. This is because tp->window_clamp does not
> > change together with the tp->scaling_ratio update. As a result, the
> > window size is capped at the initial window_clamp, which is also ~0.25 =
*
> > rcvbuf, and never grows bigger.

Sorry I missed this part. I understand better.

I wonder if we should at least test (sk->sk_userlocks &
SOCK_RCVBUF_LOCK) or something...

For autotuned flows (majority of the cases), tp->window_clamp is
changed from tcp_rcv_space_adjust()

I think we need to audit a bit more all tp->window_clamp changes.

> >
> > This patch updates window_clamp along with scaling_ratio. It changes th=
e
> > calculation of the initial rcv_wscale as well to make sure the scale
> > factor is also not capped by the initial window_clamp.
>
> This is very suspicious.
>
> >
> > A comment from Tycho Andersen <tycho@tycho.pizza> is "What happens if
> > someone has done setsockopt(sk, TCP_WINDOW_CLAMP) explicitly; will this
> > and the above not violate userspace's desire to clamp the window size?"=
.
> > This comment is not addressed in this patch because the existing code
> > also updates window_clamp at several places without checking if
> > TCP_WINDOW_CLAMP is set by user space. Adding this check now may break
> > certain user space assumption (similar to how the original patch broke
> > the assumption of buffer overhead being 50%). For example, if a user
> > space program sets TCP_WINDOW_CLAMP but the applicaiton behavior relies
> > on window_clamp adjusted by the kernel as of today.
>
> Quite frankly I would prefer we increase tcp_rmem[] sysctls, instead
> of trying to accomodate
> with too small SO_RCVBUF values.
>
> This would benefit old applications that were written 20 years ago.

