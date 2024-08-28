Return-Path: <netdev+bounces-122556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE978961B24
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 02:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD541F23D84
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 00:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4E311CAF;
	Wed, 28 Aug 2024 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tpp+BuPJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DA41B969
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 00:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724805842; cv=none; b=Im2gqc1OPyIhcOcAIg7PF0kRRoSN+0FVf1aY8lkUpAl57FZAxA5Ppgv2a3vo/HVN1XJLxNfbK/mcW5Kfpro0nK1eEmiJwCvDRwnQfdUIp3c5jEl3JnlKYGmDrUMzC+75XHASPQ1Y5ubSEEYVyWWBO3cRGWPlYnS+BdcBvRp2sk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724805842; c=relaxed/simple;
	bh=0BiOO60bMLHXVY/IWYsR8GcwRe5d/QWh+C0MevXb914=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhXpFEafQ7933RFph9tUGGpHgJH5Z4bGWDo3eeRU0avEOtB+ajVQSk053gfUjEW4eay9+zFA2fMrTvh1hod5b1X7J29DOSe/83qOCvgE7/go2sT7T1mXM7WinGwjrDDTUDEt6pDr8oJPNRTGjLOjGQ3j2V50HsYKV4UWEewUJ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tpp+BuPJ; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-39d26a8f9dbso20815335ab.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 17:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724805840; x=1725410640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkYtcLygJe0kisfiPMwuvLJCDc88TzF8NS3zeA9dx/I=;
        b=Tpp+BuPJRhCYTVm2bSpjx40m0u7zc14LqaHIz2q5oiW7ZpLJD3ZLtECi03THx5T2KG
         ruX1wake9VgwopoRF1PHjNM1dFFDPierZ2cPCQh/7r9GN31UPUtwQL778XrG55wScgo/
         aDR5APd6Ad0kfAJyU29abC+cjj3cfSfq3iiJYtXjR0iP1EWzp6GsUEMleLasR3sXUQpH
         04CPN4Vrs2eRuOFMgFQZc7LnrU22yNLDSR43hb4Wjs1iPZLguN0BtMzrtpfin6P/CxDg
         EqJ0FpL3Z5PBBb4/RiHStC8dSbzuXLiNrfZkLdEtP5e4/LUJMSfi6nofvgpXkZBlbSlU
         XDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724805840; x=1725410640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkYtcLygJe0kisfiPMwuvLJCDc88TzF8NS3zeA9dx/I=;
        b=NnNmrvN/rpX2RksdZpIPmSTPvUP95hQq16mkb5sQml+oc4Y3j/e4xgX+D8Io4fRgop
         9Ejolom6pVnNFLqyj95bd1x8McqftHQVO5tPl4bdTMbare6D81Q/K4zreCYbqgYXUTji
         NpUc1tnJjLJvEtxT8Fv4uJkvIjA1/rQQAKrSa9XgWBmn5a5YZI0VTji2nwdm3Zpdq+wA
         lT2FxGw9Gc1+O5RZwxqogoZ+cvRlhqcMR16J2fscFeF+arO2v6za/up6R4S9D4WpO6oD
         DKcuzaDhsSKaWFUM/7J9tGUUt58Wc8Om2LHY6ZEi0FWGHvnfswlyswA4vBH8ivrwlYDf
         pLHw==
X-Forwarded-Encrypted: i=1; AJvYcCVydXEa5uA0ZY+iWk89zdrnR68dJ99aW7DM76X6O64zDj4pv4c/k6l0wPDnh1++nTYXCsiZ9Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG4Kw9Ks+L6+ffRZYFhyGFuh04saTyMN9OKfj004RBw23y+xhU
	Gaop3+Jzx79BMpFIci0zeqVZFzyZL1CQqyGMr1/sHAF/lYpAsXnniVpZcKEG35+At1qcPwcpPNT
	PABTsLkZgNJiB2AhlyOhz+FWRMBw=
X-Google-Smtp-Source: AGHT+IFMUa9Rm8/l1XipvYhloJoqq5ILC+6zLkLTcRYrQrDHsizDkarXJ8v03CDbTA0EqKXwohP48iF7iklHXyAUcdA=
X-Received: by 2002:a05:6e02:1787:b0:39a:eb4d:4335 with SMTP id
 e9e14a558f8ab-39f325ed038mr5926275ab.4.1724805840157; Tue, 27 Aug 2024
 17:44:00 -0700 (PDT)
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
 <CAL+tcoCZhakNunSGT4Y0RfaBi-UXbxDDcEU0n-OG9FXNb56Bcg@mail.gmail.com> <66ce07f174845_2a065029481@willemb.c.googlers.com.notmuch>
In-Reply-To: <66ce07f174845_2a065029481@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 28 Aug 2024 08:43:23 +0800
Message-ID: <CAL+tcoDVhYpQwZ7xX4Lv+0SWuQOKMpRiJxH=R9v+M8-Lp9HGzA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: make SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 1:08=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> > > > > > Besides those two concepts you mentioned, could you explain if =
there
> > > > > > are side effects that the series has and what kind of bad conse=
quences
> > > > > > that the series could bring?
> > > > >
> > > > > It doesn't do the same for hardware timestamping, creating
> > > > > inconsistency.
> > >
> > > Taking a closer look at the code, there are actually already two weir=
d
> > > special cases here.
> > >
> > > SOF_TIMESTAMPING_RX_HARDWARE never has to be passed, as rx hardware
> > > timestamp generation is configured through SIOCSHWTSTAMP.
> >
> > Do you refer to the patch [1/2] I wrote? To be more specific, is it
> > about the above wrong commit message which I just modified?
> >
> > Things could happen when other unrelated threads set
> > SOF_TIMESTAMPING_RX_SOFTWARE instead of SOF_TIMESTAMPING_RX_HARDWARE.
> >
> > Sorry for the confusion.
>
> No, this is referring to the current state.
>
> > >
> > > SOF_TIMESTAMPING_RX_SOFTWARE already enables timestamp reporting from
> > > sock_recv_timestamp(), while reporting should not be conditional on
> > > this generation flag.
> >
> > I'm not sure if you're talking about patch [2/2] in the series. But I g=
uess so.
>
> Nope, same thing. I mention a commit from 2014.

I thought you asked me to change these two last night. Actually you
were only stating the fact: two cases where we use both generation and
reporting flags already exist before.

Okay, I finally got it. It's fine to me from my point of view :)

>
> > I can see what you mean here: you don't like combining the reporting
> > flag and generation flag, right? But If we don't check whether those
> > two flags (SOF_TIMESTAMPING_RX_SOFTWARE __and__
> > SOF_TIMESTAMPING_SOFTWARE) in sock_recv_timestamp(), some tests in the
> > protocols like udp will fail as we talked before.
> >
> > netstamp_needed_key cannot be implemented as per socket feature (at
> > that time when the driver just pass the skb to the rx stack, we don't
> > know which socket the skb belongs to). Since we cannot prevent this
> > from happening during its generation period, I suppose we can delay
> > the check and try to stop it when it has to report, I mean, in
> > sock_recv_timestamp().
> >
> > Or am I missing something? What would you suggest?
> >
> > >
> > >         /*
> > >          * generate control messages if
> > >          * - receive time stamping in software requested
> > >          * - software time stamp available and wanted
> > >          * - hardware time stamps available and wanted
> > >          */
> > >         if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> > >             (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
> > >             (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
> > >             (hwtstamps->hwtstamp &&
> > >              (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
> > >                 __sock_recv_timestamp(msg, sk, skb);
> > >
> > > I evidently already noticed this back in 2014, when I left a note in
> > > commit b9f40e21ef42 ("net-timestamp: move timestamp flags out of
> > > sk_flags"):
> > >
> > >     SOCK_TIMESTAMPING_RX_SOFTWARE is also used to toggle the receive
> > >     timestamp logic (netstamp_needed). That can be simplified and thi=
s
> > >     last key removed, but will leave that for a separate patch.
> > >
> > > But I do not see __sock_recv_timestamp toggling the feature either
> > > then or now, so I think this is vestigial and can be removed.

After investigating more of it, as your previous commit said, the
legacy SOCK_TIMESTAMPING_RX_SOFTWARE flag can be replaced by
SOF_TIMESTAMPING_RX_SOFTWARE and we can completely remove that SOCK_xx
flag from enum sock_flags {}, right? Do you expect me to do that? If
so, I would love to do it :)

But I still don't get it when you say "__sock_recv_timestamp toggling
the feature", could you say more, please? I'm not sure if it has
something to do with the above line.

Thanks for your patience:)

> >
> > I'm not so sure about the unix case, I can see this call trace:
> > unix_dgram_recvmsg()->__unix_dgram_recvmsg()->__sock_recv_timestamp().
> >
> > The reason why I added the check in in __sock_recv_timestamp () in the
> > patch [2/2] is considering the above call trace.
> >
> > One thing I can be sure of is that removing the modification in
> > __sock_recv_timestamp in that patch doesn't affect the selftests.
> >
> > Please correct me if I'm wrong.
>
> I think we're talking alongside each other. I was pointing to code
> before your patch.
>
> > >
> > > > >
> > > > > Changing established interfaces always risks production issues. I=
n
> > > > > this case, I'm not convinced that the benefit outweighs this risk=
.
> > > >
> > > > I got it.
> > > >
> > > > I'm thinking that I'm not the first one and the last one who know/f=
ind
> > > > this long standing "issue", could we at least documentented it
> > > > somewhere, like adding comments in the selftests or Documentation, =
to
> > > > avoid the similar confusion in the future? Or change the behaviour =
in
> > > > the rxtimestamp.c test? What do you think about it? Adding
> > > > documentation or comments is the simplest way:)
> > >
> > > I can see the value of your extra filter. Given the above examples, i=
t
> > > won't be the first subtle variance from the API design, either.
> >
> > Really appreciate that you understand me :)
> >
> > >
> > > So either way is fine with me: change it or leave it.
> > >
> > > But in both ways, yes: please update the documentation accordingly.
> >
> > Roger that, sir. I will do it.
> >
> > >
> > > And if you do choose to change it, please be ready to revert on repor=
t
> > > of breakage. Applications that only pass SOF_TIMESTAMPING_SOFTWARE,
> > > because that always worked as they subtly relied on another daemon to
> > > enable SOF_TIMESTAMPING_RX_SOFTWARE, for instance.
> >
> > Yes, I still chose to change it and try to make it in the correct
> > direction. So if there are future reports, please let me know, I will
> > surely keep a close eye on it.
>
> Sounds good, thanks.

So let me organize my thoughts here.

In the next move, I would do such things:
1) keep two patches in this series as they are.
2) add some descriptions about "this commit introduces subtle
variance, if the application that only pass
SOF_TIMESTAMPING_SOFTWARE..." something like this in the Documentation
file.
3) remove the last key SOCK_TIMESTAMPING_RX_SOFTWARE from enum
sk_flags, if you want me to do so :)

If there is something weird here, please point it out so that I can
make the right move.

Thanks,
Jason

