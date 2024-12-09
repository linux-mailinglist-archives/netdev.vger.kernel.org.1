Return-Path: <netdev+bounces-150402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4F59EA215
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72401880572
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 22:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3C419EED6;
	Mon,  9 Dec 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="HQvkls/g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA66E19E82A
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 22:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733784277; cv=none; b=FhnyfLvRlNW1aDM07OiaC1fT8CR75J6TOgNJhIFL7/QVcGzNUI+E53dCUxAeN2KvPB/kCtDT0Gfqz6Rdpp5BbWvYq4BYUZMFJpnsoTL5a1/WMXQIaeBif6HzGohHz3eCk0d0khGgjBKFK11vXLp8JoUG1e94Kl4dMazH4uaCYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733784277; c=relaxed/simple;
	bh=HRGqOPCaLbq228ZUiSJ6vJsTPafBSjXQGcZDtnJGJAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfOaQwFd/YzVcCvWKIUymPe21bXP/XKMzYXF0Xo/FkXHX7365lVE6FWMkTfKJx8Pr7M7gDb0jWvczNvU17ixabVX9E8XFG+n/IhJT/O33+4G9T5bk10bBoQnQ3VD4nAmaJP6map14eP4Ht3U6FLmRh3NN3KuaEszxGeffpvNahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=HQvkls/g; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-725ee27e905so1654626b3a.2
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 14:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1733784275; x=1734389075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7WLaPjP/6/VqZCsN8r4DgRpNo9GopH9P2vAEBfUq7M=;
        b=HQvkls/gTivPZCrYA+BozcmOYa7eeZjet3w4emvLXOOd1oCW5g3ACKMV/+J+YcfJ8W
         UG4eivKxHo6n6gzf7E1rCQu1R7a/v0D/1n911XNUDObj+c8iLsU5xCCzR8Y/MRDmC2+n
         GZ86N8HV8b9uaOIvGJH0+wCV8P+O3fTwmzETTlQz97mmPyCm7cERfrppCzH2rYEYchxM
         qv5gGP7DHHQih4F2085RiQAYcIvBgIhS5W9lMZhgZ6pTkizsTD8C+lLYHfhEvBQq8Idn
         WDFykLnKlufX9vjnbQU2IgUuRjkaUsoXkuFN3Wz9D0rNSDzRiI5isEYs7C0Dht25oAuu
         bEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733784275; x=1734389075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7WLaPjP/6/VqZCsN8r4DgRpNo9GopH9P2vAEBfUq7M=;
        b=obHtI/9DE5pWnopZiAELsnStx0ntcqTtphgK0exz9y9QOGdv9kCr1nD8xV/BgIuICO
         3ynLXf7fyWz2OpINNBB3tkFBSbs/pD8sMPI1J833Q3WaZkF/p/32aop0sAVZxFTtWLJk
         1R8INneOjAyspdWyjk1a1PFwyeoxhAf4kwKqNpdikmfPferOjLgUzX+Nv2F761E5gRrQ
         AwUam/+3YmaI/YDYR7yig9sINPp1GV95jk4D2d3i2pUMPOaJ3Fo+uLQg6W2hzFsc7GtB
         4fH1815aibvfP+q+xZtNmvt4DOIAM+yMLqVRqIcf4xXpNrd5Qz2YT+z06Yf5FnAskYER
         kSHA==
X-Forwarded-Encrypted: i=1; AJvYcCVH0vuVoRTfO5xUbm1fhFK60xRQxupFbgBUtImx5rUvyK6Np42NPZzw+hY1XlJ4IF7Bkh+PI9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKUOU913BjrhKLKbCMKMdJGHUTuFw1+Pnj41HO9SfFFbR0AyCA
	iUJ8Rmi2DHtW0aCFSST64z1PsACFepZJ0Qb0Pj7RQY64h/Pb26QSN8+viPrdz+3tP6V0UbCyfie
	VuFRXDN/IbDlE11oIKIM3scCCVqdX0IxkY5iJ
X-Gm-Gg: ASbGncstxhEFnF/GdEAz59rJabaiT3JNu4xrAOv2bKhV5qQIp1wEYAaI7j3Ap2Ese8u
	s3YHMZqw3xvM2m7eRkFwGIqRUyVqYo/pV4w==
X-Google-Smtp-Source: AGHT+IEgP6rIYwWx2fF62aAs7gDYhI5tl3KxoKfvMp4XkKMmhIH53d2SgbjXP/UiXP5p4RDmYWlBqsXP6z0KWFb1W48=
X-Received: by 2002:a05:6a00:a17:b0:725:e015:909d with SMTP id
 d2e1a72fcca58-725e01593b7mr11196856b3a.21.1733784275161; Mon, 09 Dec 2024
 14:44:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202191312.3d3c8097@kernel.org> <20241204122929.3492005-1-martin.ottens@fau.de>
 <CAM0EoMnTTQ-BtS0EBqB-5yNAAmvk9r67oX7n7S0Ywhc23s49EQ@mail.gmail.com>
 <b4f59f1c-b368-49ae-a0c4-cf6bf071c693@fau.de> <CAM0EoM=sHOh+aXg9abq6_7QLCaqH28Ve1rjSjnHNkZTsE7CuMQ@mail.gmail.com>
In-Reply-To: <CAM0EoM=sHOh+aXg9abq6_7QLCaqH28Ve1rjSjnHNkZTsE7CuMQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 9 Dec 2024 17:44:24 -0500
Message-ID: <CAM0EoMm1Qv3_0ak2vtRjSmuW4+zZ7izzBVjDMawfnKm3dLcjyA@mail.gmail.com>
Subject: Re: [PATCH v2] net/sched: netem: account for backlog updates from
 child qdisc
To: Martin Ottens <martin.ottens@fau.de>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 4:13=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Sat, Dec 7, 2024 at 11:37=E2=80=AFAM Martin Ottens <martin.ottens@fau.=
de> wrote:
> >
> > On 05.12.24 13:40, Jamal Hadi Salim wrote:
> > > Would be nice to see the before and after (your change) output of the
> > > stats to illustrate
> >
> > Setup is as described in my patch. I used a larger limit of
> > 1000 for netem so that the overshoot of the qlen becomes more
> > visible. Kernel is from the current net-next tree (the patch to
> > sch_tbf referenced in my patch is already applied (1596a135e318)).
> >
>
> Ok, wasnt aware of this one..
>
> >
> > TCP before the fix (qlen is 1150p, exceeding the maximum of 1000p,
> > netem qdisc becomes "locked" and stops accepting packets):
> >
> > qdisc netem 1: root refcnt 2 limit 1000 delay 100ms
> >  Sent 2760196 bytes 1843 pkt (dropped 389, overlimits 0 requeues 0)
> >  backlog 4294560030b 1150p requeues 0
> > qdisc tbf 10: parent 1:1 rate 50Mbit burst 1537b lat 50ms
> >  Sent 2760196 bytes 1843 pkt (dropped 327, overlimits 7356 requeues 0)
> >  backlog 0b 0p requeues 0
> >
> > UDP (iperf3 sends 50Mbit/s) before the fix, no issues here:
> >
> > qdisc netem 1: root refcnt 2 limit 1000 delay 100ms
> >  Sent 71917940 bytes 48286 pkt (dropped 2415, overlimits 0 requeues 0)
> >  backlog 643680b 432p requeues 0
> > qdisc tbf 10: parent 1:1 rate 50Mbit burst 1537b lat 50ms
> >  Sent 71917940 bytes 48286 pkt (dropped 2415, overlimits 341057 requeue=
s 0)
> >  backlog 311410b 209p requeues 0
> >
> > TCP after the fix (UDP is not affected by the fix):
> >
> > qdisc netem 1: root refcnt 2 limit 1000 delay 100ms
> >  Sent 94859934 bytes 62676 pkt (dropped 15, overlimits 0 requeues 0)
> >  backlog 573806b 130p requeues 0
> > qdisc tbf 10: parent 1:1 rate 50Mbit burst 1537b lat 50ms
> >  Sent 94859934 bytes 62676 pkt (dropped 324, overlimits 248442 requeues=
 0)
> >  backlog 4542b 3p requeues 0
> >
>
> backlog being > 0 is a problem, unless your results are captured mid
> test (instead of end of test)
> I will validate on net-next and with your patch.
>

Ok, so seems sane to me - but can you please put output on the commit
reflecting after the test is completed?
Something like, before patch (highlighting stuck backlog on netem):

qdisc netem 1: root refcnt 2 limit 1000 delay 1s seed 17105543349430145291
 Sent 35220 bytes 43 pkt (dropped 7, overlimits 0 requeues 0)
 backlog 4294958212b 0p requeues 0
qdisc tbf 8003: parent 1: rate 50Mbit burst 1600b lat 224us
 Sent 35220 bytes 43 pkt (dropped 17, overlimits 1 requeues 0)
 backlog 0b 0p requeues 0

And after your patch:
qdisc netem 1: root refcnt 2 limit 1000 delay 1s seed 11503045766577034723
 Sent 42864 bytes 49 pkt (dropped 5, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
qdisc tbf 8001: parent 1: rate 50Mbit burst 1600b lat 224us
 Sent 42864 bytes 49 pkt (dropped 16, overlimits 5 requeues 0)
 backlog 0b 0p requeues 0

backlog is now shown as cleared.

Coincidentally, removing your tbf patch (which is already in net-next)
and rerunning the test it didnt seem to matter whether GSO was on or
off (as you can see below backlog is stuck on tbf):


GSO off:
qdisc netem 1: root refcnt 2 limit 1000 delay 1s seed 12925321237200695918
 Sent 26284 bytes 39 pkt (dropped 7, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
qdisc tbf 8001: parent 1: rate 50Mbit burst 1600b lat 224us
 Sent 26284 bytes 39 pkt (dropped 17, overlimits 1 requeues 0)
 backlog 4294959726b 0p requeues 0

GSO on:
qdisc netem 1: root refcnt 2 limit 1000 delay 1s seed 18236003995023052493
 Sent 35224 bytes 43 pkt (dropped 7, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0
qdisc tbf 8002: parent 1: rate 50Mbit burst 1600b lat 224us
 Sent 35224 bytes 43 pkt (dropped 17, overlimits 1 requeues 0)
 backlog 4294958212b 0p requeues 0

Please resubmit the patch - add my acked-by and put the proper
before/after stats.
Fixes is likely: Linux-2.6.12-rc2

cheers,
jamal

