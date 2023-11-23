Return-Path: <netdev+bounces-50561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D1A7F61A5
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 15:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78611C211D2
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1311724A1D;
	Thu, 23 Nov 2023 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="G+oJBm3S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EB9A4
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 06:38:48 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-daf2eda7efaso868793276.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 06:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700750327; x=1701355127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovMpLrfNMZwSjDSihKlua99SmeK+uIC79Na9Hrc9jcA=;
        b=G+oJBm3Sa5LeOwvaQZy7EzmOPTFozhqoQBGxBGptUF0g6TWLcoBIL+gxn2tffwA7zw
         WATvrb3/r11nAf5be5m5WYDmcLHhnVWbF9aMLAVRW8KsdSIzOhs++3wyZ5uJ8FbJfU/+
         /7jgNOI+aJUwez8OF3bk/CdelDAPWcdLLL8lI4jUqrgqFqbV7019IDv3p6LD2jKKY62A
         8rPPy62GqLyGT1hIftnU87uO2eQNpyxSnzq5Z7k7YBPqqlFzjAmxPejpwoK5yESb6vAw
         IA4TggDHkLDc85hWOlldRHdYYXoQAmEKZNioqdAgT5AnFM53+dtrJVd8jZDMSQD1FpPq
         0zoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700750327; x=1701355127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovMpLrfNMZwSjDSihKlua99SmeK+uIC79Na9Hrc9jcA=;
        b=cJvGrNPdE+JwQRjQK9XCNeFLjOevO5zEF4DR0YJWqWk7iFgvh1V+T22axMS/4u+rBv
         85qpIKK7siyr7OdJ0+8Ie0P4dA0+7yV2x5m0SxE03iQOgStUMJ0Ak0mmO771GzYj1cJn
         aaVDeWSB7UB5y3TUgB1QWaREC2hZjVlsm9v1N4IcA64ymDRs8gnX9US/Brizfd2j77jP
         Hn+ZRQDNVpC7RYNX42C1n1zkXbmika+uGThERwQU8I62NHsUh4Z+cTshDVnTElb6Aept
         fY4l6+XUw1n1XJpUJvmlUC3IrDxKiK4sSESzw1JyWXyg6Vi4spTqfRg6RE8waBWaMsJc
         sDpQ==
X-Gm-Message-State: AOJu0Yxb+c5Y1ceug28A1tTFe4x1GtZ7vcieq7S0sfyhN2/GvzguxhMS
	7Gv22Qp7pvuFzEoF3dCk0cluqtZ+A5o+lx/tMcSbWw==
X-Google-Smtp-Source: AGHT+IGzyWn4pm/o4gez/MZNwB9HjJa+++okehKgwNhKF4fzJoblkGUhZvgcHj7N3OG+cnYmYeAflR9kBqdP9V16YUM=
X-Received: by 2002:a0d:d94d:0:b0:5a7:aa65:c536 with SMTP id
 b74-20020a0dd94d000000b005a7aa65c536mr6377866ywe.0.1700750327277; Thu, 23 Nov
 2023 06:38:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110214618.1883611-1-victor@mojatatu.com> <20231110214618.1883611-5-victor@mojatatu.com>
 <ZV8SnZPBV4if5umR@nanopsycho> <CAM0EoMnwM836zTWJJsLa0QcqByGkcw0dMs8ScW7Cct3aBAQOMw@mail.gmail.com>
 <ZV9b0HrM5WespGMW@nanopsycho>
In-Reply-To: <ZV9b0HrM5WespGMW@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 23 Nov 2023 09:38:35 -0500
Message-ID: <CAM0EoMnwAHO_AvEYiL=aTwNBjs29ww075Lq1qwvCwuYtB_Qz7A@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v5 4/4] net/sched: act_blockcast: Introduce
 blockcast tc action
To: Jiri Pirko <jiri@resnulli.us>
Cc: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com, 
	pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 9:04=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Thu, Nov 23, 2023 at 02:37:13PM CET, jhs@mojatatu.com wrote:
> >On Thu, Nov 23, 2023 at 3:51=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >>
> >> Fri, Nov 10, 2023 at 10:46:18PM CET, victor@mojatatu.com wrote:
> >> >This action takes advantage of the presence of tc block ports set in =
the
> >> >datapath and multicasts a packet to ports on a block. By default, it =
will
> >> >broadcast the packet to a block, that is send to all members of the b=
lock except
> >> >the port in which the packet arrived on. However, the user may specif=
y
> >> >the option "tx_type all", which will send the packet to all members o=
f the
> >> >block indiscriminately.
> >> >
> >> >Example usage:
> >> >    $ tc qdisc add dev ens7 ingress_block 22
> >> >    $ tc qdisc add dev ens8 ingress_block 22
> >> >
> >> >Now we can add a filter to broadcast packets to ports on ingress bloc=
k id 22:
> >> >$ tc filter add block 22 protocol ip pref 25 \
> >> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22
> >>
> >> Name the arg "block" so it is consistent with "filter add block". Make
> >> sure this is aligned netlink-wise as well.
> >>
> >>
> >> >
> >> >Or if we wish to send to all ports in the block:
> >> >$ tc filter add block 22 protocol ip pref 25 \
> >> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22 tx_type al=
l
> >>
> >> I read the discussion the the previous version again. I suggested this
> >> to be part of mirred. Why exactly that was not addressed?
> >>
> >
> >I am the one who pushed back (in that discussion). Actions should be
> >small and specific. Like i had said in that earlier discussion it was
> >a mistake to make mirred do both mirror and redirect - they should
>
> For mirror and redirect, I agree. For redirect and redirect, does not
> make much sense. It's just confusing for the user.
>

Blockcast only emulates the mirror part. I agree redirect doesnt make
any sense because once you redirect the packet is gone.

> >have been two actions. So i feel like adding a block to mirred is
> >adding more knobs. We are also going to add dev->group as a way to
> >select what devices to mirror to. Should that be in mirred as well?
>
> I need more details.
>

You set any port you want to be mirrored to using ip link, example:
ip link set dev $DEV1 group 2
ip link set dev $DEV2 group 2
...

Then you can blockcast:
tc filter add devx protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action blockcast group 2

cheers,
jamal

>
> >
> >cheers,
> >jamal
> >
> >> Instead of:
> >> $ tc filter add block 22 protocol ip pref 25 \
> >>   flower dst_ip 192.168.0.0/16 action blockcast blockid 22
> >> You'd have:
> >> $ tc filter add block 22 protocol ip pref 25 \
> >>   flower dst_ip 192.168.0.0/16 action mirred egress redirect block 22
> >>
> >> I don't see why we need special action for this.
> >>
> >> Regarding "tx_type all":
> >> Do you expect to have another "tx_type"? Seems to me a bit odd. Why no=
t
> >> to have this as "no_src_skip" or some other similar arg, without value
> >> acting as a bool (flag) on netlink level.
> >>
> >>

