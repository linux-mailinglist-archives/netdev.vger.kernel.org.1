Return-Path: <netdev+bounces-101905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35FE900850
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 17:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63F31C206A5
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D953325740;
	Fri,  7 Jun 2024 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDvzvAbN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0C910958
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773140; cv=none; b=jL1ZfnhqSoc+qpKjyRj76vXUKJyMRbvyv5LdVLHqiIw792BzXDEFarigvfrkgn9F7VxDcWhM7AZJk7Ppn23itRTYNG8mqNhMPfzCz8/mzWAipaxtOHMpvjCP20FbqV9jV0yzt48rgrnyO6fIiNtbL4dbMk/Tg/7N0pogyTaTaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773140; c=relaxed/simple;
	bh=HFe7BaPeY9Li/Qvx4sQmfyvK2g8oPfZy9Ahw49ULev0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=te3Dzg3S8Pd4FALDHnZpYywPzTPernjRxff5OkGFI1b3tI5/UdmMlkeir4E9c+aHSZOoWYC52xm/whZz6xhrE+nalgV1Q5MVrs2GiwptE70yafFje/vzJpG4hR0p4QohgQBzBHfQLAKre0eEyRnEwSnJOHXyRuq9FU+aHUol5J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDvzvAbN; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3cabac56b38so1297755b6e.3
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717773138; x=1718377938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZZJUUsSwK2loGWxZ2zbS/7LilGmYV+G8362d12Wxpo=;
        b=jDvzvAbNcn7V/M8ZwaUAvmoEJVsS1FRNZ+/QZjv57mAi3uQj/ur3URHty1N6rLZ5Wp
         l9R5R787g+hL9W5O0Mke5kWcSRetFSPHBUPy7fCFr4EjD1As5jjnKo7kTYqctzEdbcNK
         N5e+8vdzP9eT9oS/eJPVTB7XutiRbTKszQxUeaQ43n68LNytqC+wjIAsh8TmXsIU5iYT
         ij+IhjjFjE76v9fsrTONohb1xyBz8b4QVVahhpHRSLkkk8SWCAav0Ne57KNv78B7TeMD
         yJ8Xfjc3Y32cFnzlhPFkOM6I82WBZqhrE/rdWbVgPKj7tgqdqWKUvNsEtU5xm289023h
         rxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717773138; x=1718377938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZZJUUsSwK2loGWxZ2zbS/7LilGmYV+G8362d12Wxpo=;
        b=LYa3ZhzbCVNHrHHS1KAkfRQ1JXxzR7YlsPBIr/KjSsZuLgbDfqAGVyFbEZhLJvoPRM
         YHi2Hb45qSGX7kd1EqjnuMALDT0pGUbbR1JOu9UADbIC91/HRH3qc2T6EdUG40MUNMbg
         fQ/n3uZfv2xAttAsBgWitMKRMtS/dKiLkknP3K9fZsAKSTOHQHxUDuca0QT0FDT5ZXzP
         z/zxHkls6eFAznNwKow/s27h4Fj3NkLsYcUvMXjOdfYcyIBQxgiSG49zctcmm5ECYNWy
         pdj3rmuj2ObX8+Tu9rYFwqRxIVf3E0yAyQ8JYZMHiGQoq9+ApcDX7jlqoKZS5+DFn0jC
         bSKw==
X-Forwarded-Encrypted: i=1; AJvYcCWtwM3KyHXlqdTToDaFpgI5K2CFfx9mZeLhYvFXOtroGHITk0UauIKgG9gJx4cJYPhFmBEL1fdmyZx/MdmezIfYtlBJk8F3
X-Gm-Message-State: AOJu0YykW3CnIj7eePIrPi2E/p4lWySweGozvXeBRBa5lrwkdlFh55Au
	ECEYq1GZUpmntPFvrv6h6rPk6/3kEym+nQPPOeJiqH9tQ3fLvotoPTsk7pU6tPWDlIOAnrKCCdL
	v0InlcMjYU1PQwL/CFXi9q6QiMzbYDPwcZtpm
X-Google-Smtp-Source: AGHT+IEoUmWnlwXe+8+HXzBL3jRiYg/cXrtytMRuk8TEzRAOiYNPLxQrOxk9SIKN2whCJqQhOgxfSyWpxUQLE9cIhPo=
X-Received: by 2002:a05:6808:2122:b0:3d1:e261:14d7 with SMTP id
 5614622812f47-3d210d8cdadmr3039737b6e.29.1717773138047; Fri, 07 Jun 2024
 08:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607125652.1472540-1-edumazet@google.com>
In-Reply-To: <20240607125652.1472540-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 7 Jun 2024 11:11:57 -0400
Message-ID: <CADVnQy=3o8MF3eZ-drh1EPbNLfiW183AkUAZwbg4N3S=1DQN_A@mail.gmail.com>
Subject: Re: [PATCH net] tcp: use signed arithmetic in tcp_rtx_probe0_timed_out()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:56=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Due to timer wheel implementation, a timer will usually fire
> after its schedule.
>
> For instance, for HZ=3D1000, a timeout between 512ms and 4s
> has a granularity of 64ms.
> For this range of values, the extra delay could be up to 63ms.
>
> For TCP, this means that tp->rcv_tstamp may be after
> inet_csk(sk)->icsk_timeout whenever the timer interrupt
> finally triggers, if one packet came during the extra delay.
>
> We need to make sure tcp_rtx_probe0_timed_out() handles this case.
>
> Fixes: e89688e3e978 ("net: tcp: fix unexcepted socket die when snd_wnd is=
 0")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Menglong Dong <imagedong@tencent.com>
> ---
>  net/ipv4/tcp_timer.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 83fe7f62f7f10ab111512a3ef15a97a04c79cb4a..5bfd76a31af6da6473d306d95=
c296180141f54e0 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -485,8 +485,12 @@ static bool tcp_rtx_probe0_timed_out(const struct so=
ck *sk,
>  {
>         const struct tcp_sock *tp =3D tcp_sk(sk);
>         const int timeout =3D TCP_RTO_MAX * 2;
> -       u32 rcv_delta;
> +       s32 rcv_delta;
>
> +       /* Note: timer interrupt might have been delayed by at least one =
jiffy,
> +        * and tp->rcv_tstamp might very well have been written recently.
> +        * rcv_delta can thus be negative.
> +        */
>         rcv_delta =3D inet_csk(sk)->icsk_timeout - tp->rcv_tstamp;
>         if (rcv_delta <=3D timeout)
>                 return false;

Nice catch!

Is this a sufficient fix? The icsk_timeout field is unsigned long and
rcv_tstamp is u32. So on 64-bit architectures icsk_timeout is u64 and
rcv_tstamp is u32. AFAICT it is not safe to subtract a u32 jiffies
timestamp from a u64 jiffies timestamp and expect to get an answer we
can use in this simple way (at least in general, after a few weeks of
uptime when the u32 jiffies value has wrapped and the u64 value has
not).

I wonder if we also need something like this for a complete fix:

- rcv_delta =3D inet_csk(sk)->icsk_timeout - tp->rcv_tstamp;
+ rcv_delta =3D (u32)inet_csk(sk)->icsk_timeout - tp->rcv_tstamp;

thanks,
neal

