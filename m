Return-Path: <netdev+bounces-110981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7335492F310
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979731C21DA3
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D6E391;
	Fri, 12 Jul 2024 00:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y4d5J5DB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FB94A3D
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 00:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720744367; cv=none; b=Lsp9YjGjSLc3FwPhk5LEKzeGouUzZ2G6F9uYgrLUR6blxvMmQvUe+pEiwzUJMV9fHS0cUKY+rwRZliMXJ63wT5vZdlRwP1LVEw0slppK1oSaNQEI/MNvJR/hgb9Wjm90s9xVMKe5JbAvHgxmN7wbJOn1WEA+rOQBTywvEoWm0+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720744367; c=relaxed/simple;
	bh=wpgoJguMwn7o8yzGi2iL5hW9q/5MQItSVaBeAQFEm3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJs85qgZ52PHJLp4ABQ5X4e6pDTX8+Zaky7iDGuySWUT+JPwuCH7cH1cAg3kVZqEQvtpLDUMtA84Sg8wuVI+Jyl2kwElz3as8OCSvZo4lBAC3gB6d5b8NEmoWCpBrnSir+VnmeP8aU7/XBzf8uHlXRk/rv1vzhmS2FoYiqccloI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y4d5J5DB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso7056a12.0
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 17:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720744364; x=1721349164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yxJuyc7PiRtOvwwVK+FIY9e7tcQr52+W2RWAv2zI6Y=;
        b=y4d5J5DBT6mJBQsSASE/ShdsuSUBsynK4GSQTvNNHx+YqMxZ5py9+56nnfqN/xVhc0
         GcmNR27tkZlNO1FfRTdQimBgkcrrLSnl0FcSkykRp1P5DaGQjIBDon4Il8ptxX/R0Tzb
         AfWppnM+HQaZvgNKPsPZau5OeusBRvAspEPyERHfNINdhfiBczmfvn1TU+WMmgYNwun1
         jSa4a94ZLbRD9pBff+lw1ME7HRgkJxj/NaHf8JrOeQQncwJbfMfLmrokvWywGpDkq9//
         vMlmOP/s7tyGGhSvux1xOvPLY2buz/MnMybo4+Ul4IOTYK4ZMV+DpOMb5girQ5W+PxiO
         nmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720744364; x=1721349164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yxJuyc7PiRtOvwwVK+FIY9e7tcQr52+W2RWAv2zI6Y=;
        b=fAT8tt8rhdAdvVFro9dFtu3WxOFnEqNSqyQ9lVJtYWJpahdTpQQYWVQ+srcAg+s+Wu
         72Qng0+h0TMechHChRw4DZ73VfKa0WYWC/ftiQy5Vrm3izHkIpRfnoI4WAnHYCpr0xPC
         Vfl1FQAolLcdf0QfGjmzTvY5Ga4Or/9peeu9dpdRnQg/szTTMVFDy249zSpG4/iD8qF0
         vy/SA7FZKISlOfdGOcsGPILoL7EpyXVsNZu9H0fP0eY4oUgnVXYaksdrIEqykzRYn5ya
         6SjBefNyGUov/ndy0pyQnkzdUuCih1KSGhLfQwM3IgQmV/3iAN/BNmfL8viqCVPFWouM
         3XYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWprG4m9aY55660wnjtLnDUJGW2S88AfP/3Wc1cr1P84rbVJbpmTNjvt6NXo034j59cVT7kiGL3MR1D5gzYzomvREHIA2ao
X-Gm-Message-State: AOJu0Yz5Nxq8FYXgvQ0eDQ+L1XvSgNvJL0iwNIApoIPdgmaqF+c+31/c
	JDwp+OuYjoXlIPKU+wwN/HEFXxWJA1uEBG29OEFy7ctpiq3dbhGXhHIgbUcmvNlR/GEImWunvOY
	ZDsTGJfRUFZfXwunZrLPk2udE+F3dWObKhZSC
X-Google-Smtp-Source: AGHT+IE6pKvhrqfVYXMP8HQMD8feH8eCkjbI2ACKhm0XvcEnPugmaUgq2IbKA1JOvTLJzIHDgO0XvAxr70NzSE+oGx4=
X-Received: by 2002:a50:aad2:0:b0:58b:93:b623 with SMTP id 4fb4d7f45d1cf-5999f5eb999mr52467a12.5.1720744363835;
 Thu, 11 Jul 2024 17:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711071017.64104-1-348067333@qq.com> <CANn89iJS434T_knwiX2mHYsyD5xQzJceeJkRg5F-kaLy8OqD9w@mail.gmail.com>
 <CAL+tcoAzshARTCVjQXAFBOS=O4EYo-t6ACtP+h0ynyFOjarfUQ@mail.gmail.com>
In-Reply-To: <CAL+tcoAzshARTCVjQXAFBOS=O4EYo-t6ACtP+h0ynyFOjarfUQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jul 2024 17:32:30 -0700
Message-ID: <CANn89iK-kaAUBF4MkAZJuRiJOO5LCE-SCRKDLBjz6gGoR5G4cA@mail.gmail.com>
Subject: Re: [PATCH net-next] inet: reduce the execution time of getsockname()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: heze0908 <heze0908@gmail.com>, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	kernelxing@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 4:58=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hello Eric,
>
> On Fri, Jul 12, 2024 at 1:26=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Jul 11, 2024 at 12:10=E2=80=AFAM heze0908 <heze0908@gmail.com> =
wrote:
> > >
> > > From: Ze He <zanehe@tencent.com>
> > >
> > > Recently, we received feedback regarding an increase
> > > in the time consumption of getsockname() in production.
> > > Therefore, we conducted tests based on the
> > > "getsockname" test item in libmicro. The test results
> > > indicate that compared to the kernel 5.4, the latest
> > > kernel indeed has an increased time consumption
> > > in getsockname().
> > > The test results are as follows:
> > >
> > > case_name       kernel 5.4      latest kernel     diff
> > > ----------      -----------     -------------   --------
> > > getsockname       0.12278         0.18246       +48.61%
> > >
> > > It was discovered that the introduction of lock_sock() in
> > > commit 9dfc685e0262 ("inet: remove races in inet{6}_getname()")
> > > to solve the data race problem between __inet_hash_connect()
> > > and inet_getname() has led to the increased time consumption.
> > > This patch attempts to propose a lockless solution to replace
> > > the spinlock solution.
> > >
> > > We have to solve the race issue without heavy spin lock:
> > > one reader is reading some members in struct inet_sock
> > > while the other writer is trying to modify them. Those
> > > members are "inet_sport" "inet_saddr" "inet_dport"
> > > "inet_rcv_saddr". Therefore, in the path of getname, we
> > > use READ_ONCE to read these data, and correspondingly,
> > > in the path of tcp connect, we use WRITE_ONCE to write
> > > these data.
> > >
> > > Using this patch, we conducted the getsockname test again,
> > > and the results are as follows:
> > >
> > > case_name       latest kernel   latest kernel(patched)
> > > ----------      -----------     ---------------------
> > > getsockname       0.18246             0.14423
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > Signed-off-by: Ze He <zanehe@tencent.com>
> >
> > There is no way you can implement a correct getsockname() without
> > extra synchronization.
> >
> > When multiple fields are read, READ_ONCE() will not ensure
> > consistency, especially for IPv6 addresses
> > which are too big to fit in a single word.
> >
>
> Thanks for your reply.
>
> I was thinking two ways at the beginning, one is using lockless way as
> this patch does which apparently is a little bit complicated, the
> other one is reverting commit 9dfc685e0262 ("inet: remove races in
> inet{6}_getname()") because in the real world I don't think the
> software programmer could call this two syscalls (connect and
> getsockname) concurrently. What is the use/meaning of calling those
> two concurrently? Even if there is data-race in this case, programmers
> cannot trust the results of getsockname one way or another. The fact
> is the degradation of performance, which the users complain about
> after upgrading the kernel from 5.4 to the latest. What do you
> suggest, Eric?

In the 'real world' we need results that we can trust.

Fact that it was missing in the past is not an excuse, this was a bug
in the first place.

Feel free to implement an alternate protection, if you really need to.

