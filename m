Return-Path: <netdev+bounces-139611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DEB9B38E6
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 19:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300962830F4
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 18:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4149D1DE8AC;
	Mon, 28 Oct 2024 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SqEKAfbZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D942563B9
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139381; cv=none; b=TbGEZiD7u2/1BJjAMaQo8HoFZP/a467prr0QjN2KFeAqdBWsw5C/pWZBHX04frQXvCV2uePXivZaEQD5tWsPLlv6ROGEiVYefqpS47Lz1lG2Cl8a+4U6OS5ZF/824W8mFxiZh2KsXbMdmhzJbmfiQlFt2DrjcjGwhe+YYL4OOzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139381; c=relaxed/simple;
	bh=QS4klwoEu3e2xszqTDupOtswi2JZ0tPlXl7i+4lTM3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gh6Y8otE1jgo7w2vo6CKDVljP4CysQN4ZnaiG1O9CCAuMUuGBHduFdsdtipud992EmP+anF/QYJNd3Nk7f+jxhEqhbnT95GVy3pGTCeZKectnEr9FIpP3Zpu9NCLJhkYb2lFqfadyZQ2znHv79JEFK1PRMkekcAGQyxQAmf34tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SqEKAfbZ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e66ba398so2718e87.0
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 11:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730139377; x=1730744177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgLfAN+cUKi+eVedCr/2krT+Fv8KuvQbdqVH0ZRKBd0=;
        b=SqEKAfbZatLTdg0l+hAAB2IVzyeBzAEzAUcGIYB13pdwxfpaUG3wV8hAODOvkOx47g
         PyHwQ9CIVW/EQ6V6usFYe6O2825ye/YGnidK7ywxddV8Vhl/NfwzV9ke1zqmI+TMglFA
         mdho/dEMf5iIGvp7rNDEuVjJF3/IJUZIkbx980QgsiW/lJFsBGDCHADOQDgDiyhEe6Po
         BUgnBih4gdTGNFChkxQnZn6+ztPGMAUlGnrbWLVq0VwqGY9Gw4GBVTpBUuAMCUKO8TQk
         h5z6oYJOoDsqRuSaZ4te6rC6IMBF2ggtJ0kY9M3SDEvTOb7OeDNQR1aFqjb2kAEJZjou
         vGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730139377; x=1730744177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgLfAN+cUKi+eVedCr/2krT+Fv8KuvQbdqVH0ZRKBd0=;
        b=Ey79ABtmv5hfm8f3uHJdw07/k3sNsnTXvmuDnxCfB4EkKKHYTgjJFXZxrMvN0Tugdi
         8wnzfdEfZB/3k4f7I9w4z/Ngkuv4Y5L2Abd9jpdp+IhwEV/M6fWxhllY4YLBuskIuE+b
         JdkVVkegwJUzDN4lNyjzOno4rhnuRkg13ldbxDJjBg1+bMGYbYV9pXySo3QSdUx95f/Q
         lcPesyVZt3Ycnamh6xbM605xraAXouXUh1nytpd/47z1m2HrrYf4pJfCzmYKDRDCsK3f
         o3FZ3aI1pZWDRI+am62SfmAgRz+fcU3YBcfvirbp/+Qzf07X2ANlu8m4H0O5Gt7VGt1d
         23zw==
X-Gm-Message-State: AOJu0YyQSDEwGMyDGBZu0xfyjF3dxc6hJt0EeKGHWq2PvRTQlplVzw2K
	qi8jekvliOrOwM3Vi6T2YQALOIZNRq3jzmvd8VpsxXxKc2teGCH/+k/iyQHRiUhNItti8keM9pk
	9w3lourXO7NtV+R7ARQfvX/RuWMpQo2GNvlDiN2Ed3i/pJiTYBdrF
X-Google-Smtp-Source: AGHT+IF0O8ZKsfcio/IapHc2jfmMV1pQYyjs5OqWMksTnc6G/qkNvTzu5blV+VR0DxWLSkT7PK7Y+ire+jW6rRVPnt8=
X-Received: by 2002:ac2:4e12:0:b0:535:3d14:1313 with SMTP id
 2adb3069b0e04-53b47f981dcmr45626e87.0.1730139376730; Mon, 28 Oct 2024
 11:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012114751.2508834-1-maheshb@google.com> <33e1fcd2-af99-4c8c-bab5-20fe98922452@redhat.com>
In-Reply-To: <33e1fcd2-af99-4c8c-bab5-20fe98922452@redhat.com>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Mon, 28 Oct 2024 11:15:50 -0700
Message-ID: <CAF2d9jjE4PDNWGjxrjVO8LuTaO0Azdz6s1HMTb=-8u+ABkBf1Q@mail.gmail.com>
Subject: Re: [PATCHv2 net-next 1/3] mlx4: introduce the time_cache into the
 mlx4 PTP implementation
To: Paolo Abeni <pabeni@redhat.com>
Cc: Netdev <netdev@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Yishai Hadas <yishaih@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
	Richard Cochran <richardcochran@gmail.com>, Mahesh Bandewar <mahesh@bandewar.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 2:20=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/12/24 13:47, Mahesh Bandewar wrote:
> > The mlx4_clock_read() function, when invoked by cycle_counter->read(),
> > previously returned only the raw cycle count. However, for PTP helpers
> > like gettimex64(), which require both pre- and post-timestamps,
> > returning just the raw cycles is insufficient; the necessary
> > timestamps must also be provided.
> >
> > This patch introduces the time_cache into the implementation. As a
> > result, mlx4_en_read_clock() is now responsible for reading and
> > updating the clock_cache. This allows the function
> > mlx4_en_read_clock_cache() to serve as the cycle reader for
> > cycle_counter->read(), maintaining the same interface
> >
> > Signed-off-by: Mahesh Bandewar <maheshb@google.com>
> > ---
> >   drivers/net/ethernet/mellanox/mlx4/en_clock.c | 28 +++++++++++++++---=
-
> >   drivers/net/ethernet/mellanox/mlx4/main.c     |  1 -
> >   drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  1 +
> >   3 files changed, 24 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/ne=
t/ethernet/mellanox/mlx4/en_clock.c
> > index cd754cd76bde..cab9221a0b26 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
> > +++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
> > @@ -36,15 +36,22 @@
> >
> >   #include "mlx4_en.h"
> >
> > -/* mlx4_en_read_clock - read raw cycle counter (to be used by time cou=
nter)
> > +/* mlx4_en_read_clock_cache - read cached raw cycle counter (to be
> > + * used by time counter)
> >    */
> > -static u64 mlx4_en_read_clock(const struct cyclecounter *tc)
> > +static u64 mlx4_en_read_clock_cache(const struct cyclecounter *tc)
> >   {
> >       struct mlx4_en_dev *mdev =3D
> >               container_of(tc, struct mlx4_en_dev, cycles);
> > -     struct mlx4_dev *dev =3D mdev->dev;
> >
> > -     return mlx4_read_clock(dev) & tc->mask;
> > +     return READ_ONCE(mdev->clock_cache) & tc->mask;
> > +}
> > +
> > +static void mlx4_en_read_clock(struct mlx4_en_dev *mdev)
> > +{
> > +     u64 cycles =3D mlx4_read_clock(mdev->dev);
> > +
> > +     WRITE_ONCE(mdev->clock_cache, cycles);
> >   }
> >
> >   u64 mlx4_en_get_cqe_ts(struct mlx4_cqe *cqe)
> > @@ -109,6 +116,9 @@ void mlx4_en_ptp_overflow_check(struct mlx4_en_dev =
*mdev)
> >
> >       if (timeout) {
> >               write_seqlock_irqsave(&mdev->clock_lock, flags);
> > +             /* refresh the clock_cache */
> > +             mlx4_en_read_clock(mdev);
>
> It looks like you could make patch 2/3 much smaller introducing an
> explit cache_refresh() helper, that will not take the 2nd argument and
> using it where needed.
>
> Possibly even more importantly, why do you need a cache at all? I guess
> you could use directly mlx4_read_clock() in mlx4_en_phc_gettimex(), and
> implement mlx4_en_read_clock as:
>
> static void mlx4_en_read_clock(struct mlx4_en_dev *mdev)
> {
>         return mlx4_read_clock(mdev->dev, NULL);
> }
>
Pre//post timestamps collections must be performed at that time of
reading the PTP clock to be precise / accurate. The infusion of
time-cache is to ensure that the cyclecounter->read() uses the same
value that we read during the mlx4_read_clock().

One can do as you have suggested (i.e. none of the 1, & 2 will be needed)

e.g.
mlx4_en_phc_gettimex()
{
         write_seqlock_irqsave(&mdev->clock_lock, flags);
         ptp_read_system_prets();
         ns =3D timecounter_read(&mdev->clock);
         ptp_read_system_posts();
         write_sequnlock_irqrestore(&mdev->clock_lock, flags);
}

However, this will not measure precisely the width of the PTP-clock
read call since subsequent calculations in timecounter_read_delta()
and cyclecounter_cyc2ns() within  timecounter_read() will take place
before the ptp_read_system_postts() call.

> Does the cache give some extra gain I can't see? If so, it should be
> explained somewhere in the commit message.

As mentioned above, the time_cache makes the cyclecounter->read()
passive so that only one clock read op is performed. If you want I can
add the above explanation in the cover-letter?

> > diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/et=
hernet/mellanox/mlx4/main.c
> > index febeadfdd5a5..9408313b0f4d 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/main.c
> > +++ b/drivers/net/ethernet/mellanox/mlx4/main.c
> > @@ -1946,7 +1946,6 @@ u64 mlx4_read_clock(struct mlx4_dev *dev)
> >   }
> >   EXPORT_SYMBOL_GPL(mlx4_read_clock);
> >
> > -
>
> Please don't introduce unrelated whitespace changes
>
Ack.

Thanks for the review,
--mahesh..

> Thanks,
>
> Paolo
>

