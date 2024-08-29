Return-Path: <netdev+bounces-123435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14288964D8B
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B729B285601
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6661B375C;
	Thu, 29 Aug 2024 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+zh0PsZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6B61547FD
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955317; cv=none; b=aljQOt/uA6l13tPHiBrfJO06beLnLfpS1CL7cMAON9llmYUStnHyr0y3Pr06OindcahTIcnMUYF6Lvw5enAVOBgMjcYBqDqyCvWHDb2UxJl9FOHudDCWslwCR8r51ycoC6ffO6COUmPU+bZrlnd+Rz9xpTDh4ixlPmL7lfzhx6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955317; c=relaxed/simple;
	bh=286Q1sHNxniVqSzlVPzGlGz4+vkXCd2LeI+sx0RPun4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KglQl3ojyuDh89+WGG+M710jLUkHxwNGcPacOitJO9WkE+3UdD0kWVfPh9rxEuqtBN9ooh2mFxFZdTvBnIFOIzXVQn/tk/QTfsWGBHyiDQ+HUxWmTZliZhbKKuU9ybPrmCeYVb6rKi6nIh8wfRaSvKguIpOLb+q65shlUzdUO3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+zh0PsZ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bf6606363fso5480816d6.3
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 11:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724955315; x=1725560115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDqlaygLqrNw7btRzhPpZHmK30Fz61NYt/enkyNk8F8=;
        b=m+zh0PsZonMpJITNfd3DJTbS+QO4mLm0yGlkGl/DV/7GVYRnzaEPVv9NtlapEpWiuD
         5ZiFvI3fh1ed7axIkq/j5ItiY03gWnMwLrMdGag1/jugAZazWqTQ7alTKiBV5sjcXXOm
         XyLTh8l9jCLSm2FWA40N63gMzAJzWfSGAWONUx6GWW95o7CS2qof0TzgovyPGapgJ0Bu
         B1RraVuVnC3dPm/0Zr7z7nXJxCvw2FvlBxzulw0RZoyacP6nVYsGw9HguGW27WpzSC5/
         kNLT1O39TItwO5swYkzjjaYZCOXQp7pVvpGqoFgX0o9773V0lCnnuXRKQ3+fA+7zPMmv
         FMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724955315; x=1725560115;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CDqlaygLqrNw7btRzhPpZHmK30Fz61NYt/enkyNk8F8=;
        b=rUErfqc1lrny6A/Qn/m9GVDtL1bxv4fYhg12XCHt7T8y8cV6V28EqXiWRxxcchOEkL
         LfrnuAWj4L1RXExoYT5SfFnnwS/U7ZBcc5zpaK1f2/CflH7QClnXvaM3ZgSbUDuyrWzk
         bFq+1bY2JHMjX8vGrp6EYRA9/U2dMUXy4PeoCN9C4ViYjbIhxvuGS+3lEmkDQiwRgx0k
         C+7acAp57i/VnLMnqsl4TjdXVT0vxn4EyKiM/U5HGSEE4D0iYBGuhpYh+S5PL4dNipB0
         oErviR8mjxNfYYuS+8iUPMTnVIMFlIxaecFa9bOxuXNowXiudOsyXG+xUeqb5zAkijOZ
         ePDw==
X-Forwarded-Encrypted: i=1; AJvYcCUgEoaevHEx+ZkwNFVDdLwulLonSx7mnoT293uyVM8IwLNe6G+fDB3vXGx2kSSwdcAM/QzEkI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd+1HKx3QGpW1RGzApEPoQNSpoDRd1pHwRf8Gn74DbIg7CWkua
	E+tV/v+lxnBnCNMqa6+4slWgC7F0BTny9GNhYvd77IATDeOu/yJh
X-Google-Smtp-Source: AGHT+IHb9y2upRMnFdpFmAjT8531Nt57wIXNBlAHxPCjeDbmiWR7lG6N0hgd/4522yU9Cw4fLnf98g==
X-Received: by 2002:a05:6214:5711:b0:6c1:6362:8363 with SMTP id 6a1803df08f44-6c33e68d2d4mr42110546d6.47.1724955314789;
        Thu, 29 Aug 2024 11:15:14 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340dae127sm7327446d6.133.2024.08.29.11.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 11:15:13 -0700 (PDT)
Date: Thu, 29 Aug 2024 14:15:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66d0bab153f94_39548f29451@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoCUhYH=udvB3rdVZm0gVypmAa5devPXryPwY+39mHscDA@mail.gmail.com>
References: <20240828160145.68805-1-kerneljasonxing@gmail.com>
 <66d082422d85_3895fa29427@willemb.c.googlers.com.notmuch>
 <CAL+tcoD6s0rrCAvMeMDE3-QVemPy21Onh4mHC+9PE-DDLkdj-Q@mail.gmail.com>
 <66d0a0816d6ce_39197c29476@willemb.c.googlers.com.notmuch>
 <CAL+tcoCUhYH=udvB3rdVZm0gVypmAa5devPXryPwY+39mHscDA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] timestamp: control
 SOF_TIMESTAMPING_RX_SOFTWARE feature per socket
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Fri, Aug 30, 2024 at 12:23=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Thu, Aug 29, 2024 at 10:14=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > Prior to this series, when one socket is set SOF_TIMESTAMPING_R=
X_SOFTWARE
> > > > > which measn the whole system turns on this button, other socket=
s that only
> > > > > have SOF_TIMESTAMPING_SOFTWARE will be affected and then print =
the rx
> > > > > timestamp information even without SOF_TIMESTAMPING_RX_SOFTWARE=
 flag.
> > > > > In such a case, the rxtimestamp.c selftest surely fails, please=
 see
> > > > > testcase 6.
> > > > >
> > > > > In a normal case, if we only set SOF_TIMESTAMPING_SOFTWARE flag=
, we
> > > > > can't get the rx timestamp because there is no path leading to =
turn on
> > > > > netstamp_needed_key button in net_enable_timestamp(). That is t=
o say, if
> > > > > the user only sets SOF_TIMESTAMPING_SOFTWARE, we don't expect w=
e are
> > > > > able to fetch the timestamp from the skb.
> > > >
> > > > I already happened to stumble upon a counterexample.
> > > >
> > > > The below code requests software timestamps, but does not set the=

> > > > generate flag. I suspect because they assume a PTP daemon (sfptpd=
)
> > > > running that has already enabled that.
> > >
> > > To be honest, I took a quick search through the whole onload progra=
m
> > > and then suspected the use of timestamp looks really weird.
> > >
> > > 1. I searched the SOF_TIMESTAMPING_RX_SOFTWARE flag and found there=
 is
> > > no other related place that actually uses it.
> > > 2. please also see the tx_timestamping.c file[1]. The author simila=
rly
> > > only turns on SOF_TIMESTAMPING_SOFTWARE report flag without turning=
 on
> > > any useful generation flag we are familiar with, like
> > > SOF_TIMESTAMPING_TX_SOFTWARE, SOF_TIMESTAMPING_TX_SCHED,
> > > SOF_TIMESTAMPING_TX_ACK.
> > >
> > > [1]: https://github.com/Xilinx-CNS/onload/blob/master/src/tests/onl=
oad/hwtimestamping/tx_timestamping.c#L247
> > >
> > > >
> > > > https://github.com/Xilinx-CNS/onload/blob/master/src/tests/onload=
/hwtimestamping/rx_timestamping.c
> > > >
> > > > I suspect that there will be more of such examples in practice. I=
n
> > > > which case we should scuttle this. Please do a search online for
> > > > SOF_TIMESTAMPING_SOFTWARE to scan for this pattern.
> > >
> > > I feel that only the buggy program or some program particularly tak=
es
> > > advantage of the global netstamp_needed_key...
> >
> > My point is that I just happen to stumble on one open source example
> > of this behavior.
> >
> > That is a strong indication that other applications may make the same=

> > implicit assumption. Both open source, and the probably many more non=

> > public users.
> >
> > Rule #1 is to not break users.
> =

> Yes, I know it.
> =

> >
> > Given that we even have proof that we would break users, we cannot
> > make this change, sorry.
> =

> Okay. Your concern indeed makes sense. Sigh, I just finished the v3
> patch series :S
> =

> >
> > A safer alternative is to define a new timestamp option flag that
> > opt-in enables this filter-if-SOF_TIMESTAMPING_RX_SOFTWARE is not
> > set behavior.
> =

> At the first glance, It sounds like it's a little bit similar to
> SOF_TIMESTAMPING_OPT_ID_TCP that is used to replace
> SOF_TIMESTAMPING_OPT_ID in the bytestream case for robustness
> consideration.
>
> Are you suggesting that if we can use the new report flag combined
> with SOF_TIMESTAMPING_SOFTWARE, the application will not get a rx
> timestamp report, right? The new flag goes the opposite way compared
> with SOF_TIMESTAMPING_RX_SOFTWARE, indicating we don't expect a rx sw
> report.
> =

> If that is so, what would you recommend to name the new flag which is
> a report flag (not a generation flag)? How about calling
> "SOF_TIMESTAMPING_RX_SOFTWARE_CTRL". I tried, but my English
> vocabulary doesn't help, sorry :(

Something like this?

@@ -947,6 +947,8 @@ void __sock_recv_timestamp(struct msghdr *msg, struct=
 sock *sk,
        memset(&tss, 0, sizeof(tss));
        tsflags =3D READ_ONCE(sk->sk_tsflags);
        if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
+           (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
+            !tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)




