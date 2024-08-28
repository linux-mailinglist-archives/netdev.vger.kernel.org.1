Return-Path: <netdev+bounces-122799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676F396299A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADA91C22AAF
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB2416CD07;
	Wed, 28 Aug 2024 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mB8yZm9g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1111DFED
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853805; cv=none; b=QdBaTbCcAGelVp//TeGtdil1I0FHNQMj9nka8L8PTX5BsQqn98HGuAIuSNnAWgFZTn1IKaGMHMP3DL/rJkDH1LGNG03o6pvbk3kIFizV5owP5D+E3snH+aF4+mcgHUdWedoFVPDyM7/YHAb51ezXKkGsA6eD1/o9xB3cpEoqpjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853805; c=relaxed/simple;
	bh=ttPxPcWS8EpQbmTAAcnx/bKcijyOkMUyS1iwWTs3pzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFxGaFmzPCbyQhXVOQ55fsQAUJyvHgApOrkp31Swp7Xxim8zM0w34ubhEwJNQOrD/t8gssqDduXYyzTnTzKgH7OCyEwORkwhoLu5K3qsYQE+02l9p6Uc+Q4kx9Z3sTwQ2L+lWmhzAPmxp+rTipw8orfZHq6idxlJjTh8N/6dblY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mB8yZm9g; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-81fe38c7255so428640239f.1
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 07:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724853802; x=1725458602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7DZE1CBInwp9brbItcuGezWoQ2oaxiubgksuUEksoo=;
        b=mB8yZm9grBL69zmjmQrT2YR2zbIZgRDKkY9idvuekRUXjxAeF1W2RQ95psrB57uFhP
         z/75NvLeU9lZJ8EXLvoB38NdFV7roRKNvwKc1PGgJfIBzpeNW8oJnjHWA0UbJTErG24/
         pPB+wyFU+pzRsGpI7IqpymCo0lhhVca6AHUckAvw3hfkycHWxdNcCGrQFJ0UXZK+/3Hd
         YxgV/GfmWbSKwip6muqnATeSbLY+BzDB0URJa4zXmF7HlW0oWZxsUH1yY2tn8YpkH6ng
         pP+Q7DpT6u+h0M+YScZeRCC73E7N5BEY7I5wTD0AVOOQic6wuwJEk7re6RIHIv/vfC7y
         VYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724853802; x=1725458602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7DZE1CBInwp9brbItcuGezWoQ2oaxiubgksuUEksoo=;
        b=EPVfmWEINaRcSlzYN5aKB4AwBai287NV59cPaFznm3cJGwygJuIjndIz8t246BpLtB
         ceavc71PbDTdYQahshjwT/BntUOqHZ9JfMYFteDWA+/9iwcjz7VtXxc37gQQBgnPb+sH
         bN/xxcXoqZRiuNDpAnL3L0SsUTDNIfz4K8txYFUQ8P8QVjfU+ZTKlHcI7dGyxcdDr6F2
         IksRkHUmXZunGdgxP7GMTD8/YxeAmzAubmhfdHMiy+pCNPpVbSWqhNNPx63BgCRY1WnS
         4cbTqrq4TB/w8Ne/yIkw6DI8bEFAJMF0Te29m1r7QQSt78WtQ5N1sUqYwZtMQtlON9vC
         ewTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPE7wbJa4C6pBoRvO/0KE5niVhoZkSLgB2esRM8SSIt+B/+wudWA+lP2s+d+tFDvETDzLfU7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGBRupCtXekAM9ykcAzYVXANPbOVJLBMlDUfmfkVEO1PRWr7z/
	bcBFWDfXzvusK2INA7CZ7xqHw16F2OqaRhsdTnwFn/vPwNljMZHTocUhM37mNqyes6oJagolJu/
	0/WoOtWQ24/NPrDl28+EB4x1tVqQ=
X-Google-Smtp-Source: AGHT+IHPGvSGpVFS4Bunnmc0vuw3Ji8PvUjzabq7DF0RHPlxRMp+4Ghvr/eaT0oU5PBq23BsUQGQaQj8gPfjNILUToM=
X-Received: by 2002:a05:6e02:178f:b0:39b:38c5:fa4e with SMTP id
 e9e14a558f8ab-39f3264728emr23678415ab.19.1724853802338; Wed, 28 Aug 2024
 07:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825152440.93054-1-kerneljasonxing@gmail.com>
 <20240825152440.93054-2-kerneljasonxing@gmail.com> <66cc82229bea2_261e53294fd@willemb.c.googlers.com.notmuch>
 <CAL+tcoBWHqVzjesJqmmgUrX5cvKtLp_L9PZz+d+-b0FBXpatVg@mail.gmail.com>
 <66cca76683fbd_266e63294d1@willemb.c.googlers.com.notmuch>
 <CAL+tcoCbCWGMEUD7nZ0e89mxPS-DjKCRGa3XwOWRHq_1PPeQUw@mail.gmail.com>
 <66ccccbf9eccb_26d83529486@willemb.c.googlers.com.notmuch>
 <CAL+tcoDrQ4e7G2605ZdigchmgQ4YexK+co9G=AvW4Dug84k-bA@mail.gmail.com>
 <66cdd29d21fc3_2986412942f@willemb.c.googlers.com.notmuch>
 <CAL+tcoCZhakNunSGT4Y0RfaBi-UXbxDDcEU0n-OG9FXNb56Bcg@mail.gmail.com>
 <66ce07f174845_2a065029481@willemb.c.googlers.com.notmuch>
 <CAL+tcoDVhYpQwZ7xX4Lv+0SWuQOKMpRiJxH=R9v+M8-Lp9HGzA@mail.gmail.com> <66cf29b67d686_336087294f0@willemb.c.googlers.com.notmuch>
In-Reply-To: <66cf29b67d686_336087294f0@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 28 Aug 2024 22:02:46 +0800
Message-ID: <CAL+tcoDGZ_uWwtDAOSUS4-e+VXGuvJ16emyGymQT5vTF+-A_DA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: make SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 9:44=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> > > > I can see what you mean here: you don't like combining the reportin=
g
> > > > flag and generation flag, right? But If we don't check whether thos=
e
> > > > two flags (SOF_TIMESTAMPING_RX_SOFTWARE __and__
> > > > SOF_TIMESTAMPING_SOFTWARE) in sock_recv_timestamp(), some tests in =
the
> > > > protocols like udp will fail as we talked before.
> > > >
> > > > netstamp_needed_key cannot be implemented as per socket feature (at
> > > > that time when the driver just pass the skb to the rx stack, we don=
't
> > > > know which socket the skb belongs to). Since we cannot prevent this
> > > > from happening during its generation period, I suppose we can delay
> > > > the check and try to stop it when it has to report, I mean, in
> > > > sock_recv_timestamp().
> > > >
> > > > Or am I missing something? What would you suggest?
> > > >
> > > > >
> > > > >         /*
> > > > >          * generate control messages if
> > > > >          * - receive time stamping in software requested
> > > > >          * - software time stamp available and wanted
> > > > >          * - hardware time stamps available and wanted
> > > > >          */
> > > > >         if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> > > > >             (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
> > > > >             (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
> > > > >             (hwtstamps->hwtstamp &&
> > > > >              (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
> > > > >                 __sock_recv_timestamp(msg, sk, skb);
> > > > >
> > > > > I evidently already noticed this back in 2014, when I left a note=
 in
> > > > > commit b9f40e21ef42 ("net-timestamp: move timestamp flags out of
> > > > > sk_flags"):
> > > > >
> > > > >     SOCK_TIMESTAMPING_RX_SOFTWARE is also used to toggle the rece=
ive
> > > > >     timestamp logic (netstamp_needed). That can be simplified and=
 this
> > > > >     last key removed, but will leave that for a separate patch.
> > > > >
> > > > > But I do not see __sock_recv_timestamp toggling the feature eithe=
r
> > > > > then or now, so I think this is vestigial and can be removed.
> >
> > After investigating more of it, as your previous commit said, the
> > legacy SOCK_TIMESTAMPING_RX_SOFTWARE flag can be replaced by
> > SOF_TIMESTAMPING_RX_SOFTWARE and we can completely remove that SOCK_xx
> > flag from enum sock_flags {}, right? Do you expect me to do that? If
> > so, I would love to do it :)
>
> I did not say that. I said that the specific line here appears
> vestigial.
>
> > > > >         if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> > > > >             (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||

Thanks for your patience.

I think I will remove the above two lines as one patch with your
suggested-by tag in the series so that later we can easily review each
of them.

>
> One thing at a time. Let's focus on the change you proposed to me.
>
> > But I still don't get it when you say "__sock_recv_timestamp toggling
> > the feature", could you say more, please? I'm not sure if it has
> > something to do with the above line.
>
> SOF_TIMESTAMPING_RX_SOFTWARE is a request to enable software receive
> timestamp *generation*. This is done by calling net_enable_timestamp.
>
> I did not immediately see a path from __sock_recv_timestamp to
> net_enable_timestamp, so I don't see a point in entering that function
> based on this flag.

I see. It does make sense. We don't need the generation flag to test
if we need to report here.

I will remove them by quoting your saying.

>
> > > > > I can see the value of your extra filter. Given the above example=
s, it
> > > > > won't be the first subtle variance from the API design, either.
> > > >
> > > > Really appreciate that you understand me :)
> > > >
> > > > >
> > > > > So either way is fine with me: change it or leave it.
> > > > >
> > > > > But in both ways, yes: please update the documentation accordingl=
y.
> > > >
> > > > Roger that, sir. I will do it.
> > > >
> > > > >
> > > > > And if you do choose to change it, please be ready to revert on r=
eport
> > > > > of breakage. Applications that only pass SOF_TIMESTAMPING_SOFTWAR=
E,
> > > > > because that always worked as they subtly relied on another daemo=
n to
> > > > > enable SOF_TIMESTAMPING_RX_SOFTWARE, for instance.
> > > >
> > > > Yes, I still chose to change it and try to make it in the correct
> > > > direction. So if there are future reports, please let me know, I wi=
ll
> > > > surely keep a close eye on it.
> > >
> > > Sounds good, thanks.
> >
> > So let me organize my thoughts here.
> >
> > In the next move, I would do such things:
> > 1) keep two patches in this series as they are.
> > 2) add some descriptions about "this commit introduces subtle
> > variance, if the application that only pass
> > SOF_TIMESTAMPING_SOFTWARE..." something like this in the Documentation
> > file.
>
> Make it crystal clear that the distinction between timestamp
> generation and timestamp reporting, which this document goes out of
> its way to explain, does not hold for receive timestamping.

Sure, I will add it into the documentation as well.

Thanks for your help.

