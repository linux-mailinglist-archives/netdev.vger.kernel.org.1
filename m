Return-Path: <netdev+bounces-122810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33145962A09
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFFB71F23422
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BA2188CC8;
	Wed, 28 Aug 2024 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F49rxc1y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B0642A8E
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854745; cv=none; b=cZhR5pk9SvMk3ET+LTlJyc7hZoXsdZeMeQYowywUXwfLKZd4Xu7Nc/PIEmzBVrjrHkghdM8ghdziOFkn+8CTrRZ1jytnCijgVyx56Plr6s3JivKsvMa7p+B4H8YhpqkLtvWv/COcW7JO1VBM+fpu7qyVz7Qd/Cjx9ZttkrHixm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854745; c=relaxed/simple;
	bh=B4pxl14vBJ5O5H1Yzp7mNyTVwdcUGksuUbsQOZzqGWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThXCt/qt7RDiXcD5vog6Asm5yv+BA28qkA7GqFk7mbazeXN5IgnfDqP6GfgwiQTusFvKyQslciku4nyzTg+K8T2HwqSID6uJNghP5N36fInwQat0XRBe7VMNjj3N0txKUA6EUSZv68pPYhVynldK2SpopKA7e+g9OYnr3w/jKSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F49rxc1y; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-39d26a8f9dbso22717325ab.1
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724854743; x=1725459543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0y9IhCoxqQfvBlbCNurqy2MSaaRiMgcuMUShtiCp38w=;
        b=F49rxc1y8GTADC9jNvUzQK4AmWN6zgosjMrVWZ6Z5d8FGzNLE5EGNhFsXNVDLUShqM
         2iRHMGHKta142l/FSry+An7MUS/M2ByCNhyc1sEVDCk/LMz6f2+cz2ZT0CHCbwmuFILj
         wdc0828m427slGG235mTVu3ol6e5wXM3hCmckcOl3ynjmIEagEwE+ak+V2GHDQC1hKU7
         6EYsPXSvWqOdMi0Qo8nFEtbkuLy+8B9Pdqo7KOivftLp2lSNB6lC6H+wjaw+TYWgIe6i
         rHQsumSl0h+qSeLfv6HupwFRyHwct3IoJS5Z0lgdueH/Vyl5R7bbGfBN3QBWngWVzda/
         cWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854743; x=1725459543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0y9IhCoxqQfvBlbCNurqy2MSaaRiMgcuMUShtiCp38w=;
        b=Bd+AfYk0txvv5WQ2fPlrgfuaopagp1Gba3HfL2uIiYGiyr7vUd24ki6k1PZ1Joe+LL
         +GS8O6uqq/5KCEqmaIjkKBA4XnB1HZP6dybpdoNb7NuCelCehYS1EDavEM+yx+Y8ijFn
         xSvPvC9NYZf+9pBPYo0uQlY2pUg/4zC8dYzfbFxuEEXLDQl8G5rgUS+R3bnjChYuIeEg
         muVxsekpWTU/nQBbbnupwlmWnPT5yZcYgA+T6SYk8czeca+LOo6KldHQ4NzrnUTjL2HA
         vCNPr127d/1wxWiF7FtNYea6WZl1vf81QcEqRGUwM1zNbF98pbLDmZXEQDeBMyPffbuJ
         L8pw==
X-Forwarded-Encrypted: i=1; AJvYcCXOcMAgCpena/evBA89Gvkb9/KwnKuo8bD6vH+Xf/iI/KFGd8pT5hTOODAibZPSUCdgVJrG4qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMen/R/H0TfqhpdMUWf3YB27NtL86NpQIKKAyIBPBHQed4Jl7u
	BcXCjDRAKOijHrksZ6yEOM2DIM/WPKCp4jcMApXiUleevRiBITgfofNmtxwIzPO+RAsZknbq3zR
	AT/IT5VFk49e3hDeEAOSeWcgW3Gw=
X-Google-Smtp-Source: AGHT+IHjZ+Urvva7BpYtv3Yo6D7kQhthdIWGzIxZc+B8iD8HQ5wKxbAUDk9d34cpRNrBhA1e7LYgBJMjYzcRTJcHtuo=
X-Received: by 2002:a05:6e02:1cac:b0:375:a5de:5d46 with SMTP id
 e9e14a558f8ab-39f325ed348mr26063715ab.5.1724854743279; Wed, 28 Aug 2024
 07:19:03 -0700 (PDT)
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
 <CAL+tcoDVhYpQwZ7xX4Lv+0SWuQOKMpRiJxH=R9v+M8-Lp9HGzA@mail.gmail.com>
 <66cf29b67d686_336087294f0@willemb.c.googlers.com.notmuch>
 <CAL+tcoDGZ_uWwtDAOSUS4-e+VXGuvJ16emyGymQT5vTF+-A_DA@mail.gmail.com> <66cf2fcbb0bd5_338e3529467@willemb.c.googlers.com.notmuch>
In-Reply-To: <66cf2fcbb0bd5_338e3529467@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 28 Aug 2024 22:18:27 +0800
Message-ID: <CAL+tcoCuPcpMf1Z3aT-TaEoo+Dp1tzg5YCuxcqLkf5tki0PqLg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: make SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 10:10=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Wed, Aug 28, 2024 at 9:44=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > > > > I can see what you mean here: you don't like combining the repo=
rting
> > > > > > flag and generation flag, right? But If we don't check whether =
those
> > > > > > two flags (SOF_TIMESTAMPING_RX_SOFTWARE __and__
> > > > > > SOF_TIMESTAMPING_SOFTWARE) in sock_recv_timestamp(), some tests=
 in the
> > > > > > protocols like udp will fail as we talked before.
> > > > > >
> > > > > > netstamp_needed_key cannot be implemented as per socket feature=
 (at
> > > > > > that time when the driver just pass the skb to the rx stack, we=
 don't
> > > > > > know which socket the skb belongs to). Since we cannot prevent =
this
> > > > > > from happening during its generation period, I suppose we can d=
elay
> > > > > > the check and try to stop it when it has to report, I mean, in
> > > > > > sock_recv_timestamp().
> > > > > >
> > > > > > Or am I missing something? What would you suggest?
> > > > > >
> > > > > > >
> > > > > > >         /*
> > > > > > >          * generate control messages if
> > > > > > >          * - receive time stamping in software requested
> > > > > > >          * - software time stamp available and wanted
> > > > > > >          * - hardware time stamps available and wanted
> > > > > > >          */
> > > > > > >         if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> > > > > > >             (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
> > > > > > >             (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
> > > > > > >             (hwtstamps->hwtstamp &&
> > > > > > >              (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
> > > > > > >                 __sock_recv_timestamp(msg, sk, skb);
> > > > > > >
> > > > > > > I evidently already noticed this back in 2014, when I left a =
note in
> > > > > > > commit b9f40e21ef42 ("net-timestamp: move timestamp flags out=
 of
> > > > > > > sk_flags"):
> > > > > > >
> > > > > > >     SOCK_TIMESTAMPING_RX_SOFTWARE is also used to toggle the =
receive
> > > > > > >     timestamp logic (netstamp_needed). That can be simplified=
 and this
> > > > > > >     last key removed, but will leave that for a separate patc=
h.
> > > > > > >
> > > > > > > But I do not see __sock_recv_timestamp toggling the feature e=
ither
> > > > > > > then or now, so I think this is vestigial and can be removed.
> > > >
> > > > After investigating more of it, as your previous commit said, the
> > > > legacy SOCK_TIMESTAMPING_RX_SOFTWARE flag can be replaced by
> > > > SOF_TIMESTAMPING_RX_SOFTWARE and we can completely remove that SOCK=
_xx
> > > > flag from enum sock_flags {}, right? Do you expect me to do that? I=
f
> > > > so, I would love to do it :)
> > >
> > > I did not say that. I said that the specific line here appears
> > > vestigial.
> > >
> > > > > > >         if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> > > > > > >             (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
> >
> > Thanks for your patience.
> >
> > I think I will remove the above two lines as one patch with your
> > suggested-by tag in the series so that later we can easily review each
> > of them.
>
> Please don't. As I said right below this:
>
> One thing at a time. Let's focus on the change you proposed to me.
>
> The above is just a hunch on first read. I would have to spend more
> time to convince myself that it is indeed correct and safe. At which
> point I might as well send it myself too..
>
> More importantly, let's not expand what is intended to be a stand
> alone improvement with tangential changes. It just makes reviewing
> harder and slows it down.

I got it :)

I think I will not touch the __sock_recv_timestamp() function and then
move those test statements from sock_recv_timestamp() to
__sock_recv_timestamp() in patch [2/2].

Let me send a v2 soon to see if they are correct.

Thanks,
Jason

