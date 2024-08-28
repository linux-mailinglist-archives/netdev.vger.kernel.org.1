Return-Path: <netdev+bounces-122805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5339629DD
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC260B21FD6
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3361898F1;
	Wed, 28 Aug 2024 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH5Io/pe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D05A18786F
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854223; cv=none; b=FaENNx8ieA1I/B+be0Ugiq/PyfhFmpVSddeR4jJbvjtVUYZNsJ4iEE/c0dX2zSLwA/CCLz8rlKHEW2KUTUR+r+cftJpeJ3NHy+28c+qWXbt7yTRW3y3077tXBsHIuvn9JqWPDZWhl+g03N/EG9yY5e+3iLgrDP1z5MmFLXd4E6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854223; c=relaxed/simple;
	bh=PaVoxS+uHJDyhc7nWD7GsW0js8cxtjiVWd5g86rShw0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gu6dy+wxkiaP91JUUJTjiLysnj6Z21dXINAKjmJ6EN1hV8xrxVuOrefd7Q/vwJ8Cz+m7a9OzHjERUFLSSnpO+9TpWBUKephB9ZyjosqTxaSnUAlsKv4k1snSvU5Dh11i3plP9cz5tRDB7QMOKGcXq6i5wo0DgTg+m9r3tcCIIr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH5Io/pe; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-450059a25b9so5985941cf.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 07:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724854221; x=1725459021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUohbey8KVo5fFA1+9lt2O9iEJma599ahHtt/vAMSsw=;
        b=mH5Io/pe56KR99tUMIPA1/q3fLRd0DHSrlEq/H4D2A+8k6y6FZWjg2YSKc4yvPLSo7
         jQElkKf4R9/FSrunxLyDILFzHvjf9e6QX3lQ6nkvQQMMvvtf+/FYCDKI5/DsZGD4HLJA
         aFZ8hNR8Y0zZuZwWBoODmCvWEY1QVhNb1wMmHkAF2UpYYwvS0td4l9A2THxpWNwpvuoH
         FcPw9oNKRLfUhCfhPAoAT6KxB7Gv9kqdza0pJLPv/yYjzjD5oGcZVZOFi465EXBhN4PX
         BIiT0TNFpnLgNcHH3lGQTqzvLVuSbVj46//pfIc7AZoek5RRse5aXmet8Okapnnes+zq
         JmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854221; x=1725459021;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bUohbey8KVo5fFA1+9lt2O9iEJma599ahHtt/vAMSsw=;
        b=QyM2cl5E1KMfpERtC9kiMxRMgyUQd72NiX7ocz8MKCO65rUX2BfiiOIPz4p54ZOVOv
         NYfyEyOFdji00Yy5HoReZ5CzTUa0WWXU2RfnZaBHeFZabwThqwoeX/ziGosjFm+VWosL
         PKGsr1nBmtm8LEQhJE0/GrD7KZFDZ1AvRXcsSquyVC62VNUcYdAnLW2su9nIk7rELSne
         IzLVUDOekFahMuQ43kmIkCSuc3WHFOZckq28o5PX4Pzx65ixh5DRRB9UO4LQ9e51vIVK
         elgtbqDNJfhL3PdCL8xzKGqRJIJdK/WkGiVoR5OKPC7KjVDxC0mgtWnot/yQwfvXyDqS
         h99w==
X-Forwarded-Encrypted: i=1; AJvYcCXkKeBhCzKZBvuvvDy2JX++f3gORPehfiW9ihcxMgfPWp14nA8GzaKIRqKYHKllZfA9L0B2zmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6XgCjnUf6h7yiFJ3zXPngKzjBoOmFXu2NGLqTweDgKc8Fmo1z
	b6khS0nSpLqZ0krUaFruWv9Um6Yi1pf8Wth01utNFH96L1i2yEaG
X-Google-Smtp-Source: AGHT+IHUliuEzW8eRQFd+hvatYHoik5TS9ymPudAVYQAI1DmbXUAY3ftFVqFgrBxZMhNCy+vy2TZ2A==
X-Received: by 2002:ac8:5442:0:b0:455:9dd:8bb2 with SMTP id d75a77b69052e-4566e611f62mr33364201cf.7.1724854220864;
        Wed, 28 Aug 2024 07:10:20 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe0f0512sm62267171cf.48.2024.08.28.07.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:10:20 -0700 (PDT)
Date: Wed, 28 Aug 2024 10:10:19 -0400
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
Message-ID: <66cf2fcbb0bd5_338e3529467@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoDGZ_uWwtDAOSUS4-e+VXGuvJ16emyGymQT5vTF+-A_DA@mail.gmail.com>
References: <20240825152440.93054-1-kerneljasonxing@gmail.com>
 <20240825152440.93054-2-kerneljasonxing@gmail.com>
 <66cc82229bea2_261e53294fd@willemb.c.googlers.com.notmuch>
 <CAL+tcoBWHqVzjesJqmmgUrX5cvKtLp_L9PZz+d+-b0FBXpatVg@mail.gmail.com>
 <66cca76683fbd_266e63294d1@willemb.c.googlers.com.notmuch>
 <CAL+tcoCbCWGMEUD7nZ0e89mxPS-DjKCRGa3XwOWRHq_1PPeQUw@mail.gmail.com>
 <66ccccbf9eccb_26d83529486@willemb.c.googlers.com.notmuch>
 <CAL+tcoDrQ4e7G2605ZdigchmgQ4YexK+co9G=AvW4Dug84k-bA@mail.gmail.com>
 <66cdd29d21fc3_2986412942f@willemb.c.googlers.com.notmuch>
 <CAL+tcoCZhakNunSGT4Y0RfaBi-UXbxDDcEU0n-OG9FXNb56Bcg@mail.gmail.com>
 <66ce07f174845_2a065029481@willemb.c.googlers.com.notmuch>
 <CAL+tcoDVhYpQwZ7xX4Lv+0SWuQOKMpRiJxH=R9v+M8-Lp9HGzA@mail.gmail.com>
 <66cf29b67d686_336087294f0@willemb.c.googlers.com.notmuch>
 <CAL+tcoDGZ_uWwtDAOSUS4-e+VXGuvJ16emyGymQT5vTF+-A_DA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: make SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
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
> On Wed, Aug 28, 2024 at 9:44=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > > > > I can see what you mean here: you don't like combining the repo=
rting
> > > > > flag and generation flag, right? But If we don't check whether =
those
> > > > > two flags (SOF_TIMESTAMPING_RX_SOFTWARE __and__
> > > > > SOF_TIMESTAMPING_SOFTWARE) in sock_recv_timestamp(), some tests=
 in the
> > > > > protocols like udp will fail as we talked before.
> > > > >
> > > > > netstamp_needed_key cannot be implemented as per socket feature=
 (at
> > > > > that time when the driver just pass the skb to the rx stack, we=
 don't
> > > > > know which socket the skb belongs to). Since we cannot prevent =
this
> > > > > from happening during its generation period, I suppose we can d=
elay
> > > > > the check and try to stop it when it has to report, I mean, in
> > > > > sock_recv_timestamp().
> > > > >
> > > > > Or am I missing something? What would you suggest?
> > > > >
> > > > > >
> > > > > >         /*
> > > > > >          * generate control messages if
> > > > > >          * - receive time stamping in software requested
> > > > > >          * - software time stamp available and wanted
> > > > > >          * - hardware time stamps available and wanted
> > > > > >          */
> > > > > >         if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> > > > > >             (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
> > > > > >             (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
> > > > > >             (hwtstamps->hwtstamp &&
> > > > > >              (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
> > > > > >                 __sock_recv_timestamp(msg, sk, skb);
> > > > > >
> > > > > > I evidently already noticed this back in 2014, when I left a =
note in
> > > > > > commit b9f40e21ef42 ("net-timestamp: move timestamp flags out=
 of
> > > > > > sk_flags"):
> > > > > >
> > > > > >     SOCK_TIMESTAMPING_RX_SOFTWARE is also used to toggle the =
receive
> > > > > >     timestamp logic (netstamp_needed). That can be simplified=
 and this
> > > > > >     last key removed, but will leave that for a separate patc=
h.
> > > > > >
> > > > > > But I do not see __sock_recv_timestamp toggling the feature e=
ither
> > > > > > then or now, so I think this is vestigial and can be removed.=

> > >
> > > After investigating more of it, as your previous commit said, the
> > > legacy SOCK_TIMESTAMPING_RX_SOFTWARE flag can be replaced by
> > > SOF_TIMESTAMPING_RX_SOFTWARE and we can completely remove that SOCK=
_xx
> > > flag from enum sock_flags {}, right? Do you expect me to do that? I=
f
> > > so, I would love to do it :)
> >
> > I did not say that. I said that the specific line here appears
> > vestigial.
> >
> > > > > >         if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> > > > > >             (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
> =

> Thanks for your patience.
> =

> I think I will remove the above two lines as one patch with your
> suggested-by tag in the series so that later we can easily review each
> of them.

Please don't. As I said right below this:

One thing at a time. Let's focus on the change you proposed to me.

The above is just a hunch on first read. I would have to spend more
time to convince myself that it is indeed correct and safe. At which
point I might as well send it myself too..

More importantly, let's not expand what is intended to be a stand
alone improvement with tangential changes. It just makes reviewing
harder and slows it down.
 =

> >
> > One thing at a time. Let's focus on the change you proposed to me.
> >
> > > But I still don't get it when you say "__sock_recv_timestamp toggli=
ng
> > > the feature", could you say more, please? I'm not sure if it has
> > > something to do with the above line.
> >
> > SOF_TIMESTAMPING_RX_SOFTWARE is a request to enable software receive
> > timestamp *generation*. This is done by calling net_enable_timestamp.=

> >
> > I did not immediately see a path from __sock_recv_timestamp to
> > net_enable_timestamp, so I don't see a point in entering that functio=
n
> > based on this flag.
> =

> I see. It does make sense. We don't need the generation flag to test
> if we need to report here.
> =

> I will remove them by quoting your saying.

See above.

> >
> > > > > > I can see the value of your extra filter. Given the above exa=
mples, it
> > > > > > won't be the first subtle variance from the API design, eithe=
r.
> > > > >
> > > > > Really appreciate that you understand me :)
> > > > >
> > > > > >
> > > > > > So either way is fine with me: change it or leave it.
> > > > > >
> > > > > > But in both ways, yes: please update the documentation accord=
ingly.
> > > > >
> > > > > Roger that, sir. I will do it.
> > > > >
> > > > > >
> > > > > > And if you do choose to change it, please be ready to revert =
on report
> > > > > > of breakage. Applications that only pass SOF_TIMESTAMPING_SOF=
TWARE,
> > > > > > because that always worked as they subtly relied on another d=
aemon to
> > > > > > enable SOF_TIMESTAMPING_RX_SOFTWARE, for instance.
> > > > >
> > > > > Yes, I still chose to change it and try to make it in the corre=
ct
> > > > > direction. So if there are future reports, please let me know, =
I will
> > > > > surely keep a close eye on it.
> > > >
> > > > Sounds good, thanks.
> > >
> > > So let me organize my thoughts here.
> > >
> > > In the next move, I would do such things:
> > > 1) keep two patches in this series as they are.
> > > 2) add some descriptions about "this commit introduces subtle
> > > variance, if the application that only pass
> > > SOF_TIMESTAMPING_SOFTWARE..." something like this in the Documentat=
ion
> > > file.
> >
> > Make it crystal clear that the distinction between timestamp
> > generation and timestamp reporting, which this document goes out of
> > its way to explain, does not hold for receive timestamping.
> =

> Sure, I will add it into the documentation as well.
> =

> Thanks for your help.



