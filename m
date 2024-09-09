Return-Path: <netdev+bounces-126351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F85970CEF
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 07:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7A21F2272A
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 05:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886D21ACE1F;
	Mon,  9 Sep 2024 05:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="aIfRcZo4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A29517C9E
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 05:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725859526; cv=none; b=tQuNQpeTkYmVTImpI7WaTz3gXkvRi9AZX8DiUGNgfDrvDYI7fsPfK9ztds5pFK+oMUsZGZTd6SNU0adSHUwbZZTwXtn7MsdxozUB57IWlKfiCDCzuULGgINlasy8SA0DGvwjb5U4ST9pHZEN2+BIYLlad1BVoRCXXMB5EEL3puQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725859526; c=relaxed/simple;
	bh=lt+OdRciJs/mbejZWkEBMLSMKdCLgvDG/+2V0adw8WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uyinq3bSh+Sg/cklZFqo8RxUtmjoliCOl6nM5wC1cFFGzYaaet/wUsm99oPYdNzqaz9BMhotF8ok3ObwGRhjBigAOJjm4INHunq9ByypMYwOmO6Gm+qRdjlczBMrx/dFZtMrcZH2/noXhNbYNAFtPmx6qkbTArHGspa5Zy2kwuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=aIfRcZo4; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 651003F46B
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 05:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725859520;
	bh=IAvfaTdfZpA+q/X0iFHezyi7oVQNx0sFqSrEiTlhudg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=aIfRcZo4uXKz3De7hIEyT2ir098alN+S002BrdZ3kcyUJwCiU9hVLJBIHLrHys/tt
	 DqJZ9NsXE2Hzn73doWso6AMpE/bdYPx4/BCGUR3B0Sfv/uWwoOtQB0trRI9LuIkyI/
	 EQ/eNBYOMxWefqP92qgBqL3+ZEIqgtDFH+0Ho2GjRZ9AeFW/mq/1wP8avAzOrfMoFI
	 zLPRGCVUCEs08cGgMKMYOqqhjPERBOMQSgiO7erq/bMCw2oFRZUnvOqt4eMyIgnveY
	 tnjmgvfZsVAlbv9P3aNCJ+N8bNtCV1A8EcOMAW8pp+joi11VRRMnjve8m4mlv04RG7
	 G9F0S3aj4lnnA==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3730b54347cso2229797f8f.1
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 22:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725859519; x=1726464319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAvfaTdfZpA+q/X0iFHezyi7oVQNx0sFqSrEiTlhudg=;
        b=paVaF5Wx2aPUq2skJq0IZfEUHKrOMAV4AVOtezewhySi4A+93wrBVAUcq4diVpuSMP
         k2v8yvvdywuKhw+gcMkqeIFNasmVQUF5oKNXirpu1X65bCyHrIy37n614h1IJvvjjA+K
         +uv2v/requWd8iWHM2j8aQc88yJnl1E6Vkd/+A8UIaWMeR0woTYOLdqHgL0dRjF/Xl5h
         e3IfOlN3uCzRiEdO6WbV3Js/ZqaaPh7XbE+8XvC6craRUE+Q6F3iGVB3qv8/aPYa8WZF
         jv+74zPkcWliVF05l0ReDRPY9lpH01JT/mynPKPeRITybCzYyyiN5+LCZIC7i1aTkSKW
         9PDw==
X-Forwarded-Encrypted: i=1; AJvYcCV52CjrhgUT5p160MChol0WeZCJ6pom+8t4F2ZxHoPvUuDYS/0NkMak8CBhEcs0Vjv7AM27lnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg53pYzTrnSHBrB7Uys2hFPFpsCrvtXsiodbT4N63h1P83y7M4
	xz/5EW5sGnC13nmWfeNstaJCOUErsLu9aIa1FsT/8YtJJbwzzNwcgZ2/2EM6V8Nf+5zjoJ40vcW
	4N+p0Lbiw82MeuNoT0tOWTbFaduEnJ0rNtmawRFBDtlNPbr0UPno5DYJfVuZXRpPBUvgKdIQsVK
	r1olbkVZmesPyJxPY63v7mHM/yjA+PP9f8Po/cCpEKue3i
X-Received: by 2002:a5d:6184:0:b0:374:b6f2:5f30 with SMTP id ffacd0b85a97d-3788960cf44mr7308367f8f.27.1725859519026;
        Sun, 08 Sep 2024 22:25:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIPPCybN2BiTI2xpSNXMCruJnTb4YO1MBV8kg20InRqKER78xtzV66i461GGVGHG/iBXDgZu9RDbVImAg8yOE=
X-Received: by 2002:a5d:6184:0:b0:374:b6f2:5f30 with SMTP id
 ffacd0b85a97d-3788960cf44mr7308345f8f.27.1725859518349; Sun, 08 Sep 2024
 22:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906083539.154019-1-en-wei.wu@canonical.com> <8707a2c6-644d-4ccd-989f-1fb66c48d34a@gmail.com>
In-Reply-To: <8707a2c6-644d-4ccd-989f-1fb66c48d34a@gmail.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Mon, 9 Sep 2024 13:25:07 +0800
Message-ID: <CAMqyJG0FcY0hymX6xyZwiWbD8zdsYwWG7GMu2zcL9-bMkq-pMw@mail.gmail.com>
Subject: Re: [PATCH net] r8169: correct the reset timing of RTL8125 for
 link-change event
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kuan-ying.lee@canonical.com, 
	kai.heng.feng@canonical.com, me@lagy.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heiner,

Thank you for the quick response.

On Sat, 7 Sept 2024 at 05:17, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 06.09.2024 10:35, En-Wei Wu wrote:
> > The commit 621735f59064 ("r8169: fix rare issue with broken rx after
> > link-down on RTL8125") set a reset work for RTL8125 in
> > r8169_phylink_handler() to avoid the MAC from locking up, this
> > makes the connection broken after unplugging then re-plugging the
> > Ethernet cable.
> >
> > This is because the commit mistakenly put the reset work in the
> > link-down path rather than the link-up path (The commit message says
> > it should be put in the link-up path).
> >
> That's not what the commit message is saying. It says vendor driver
> r8125 does it in the link-up path.
> I moved it intentionally to the link-down path, because traffic may
> be flowing already after link-up.
>
> > Moving the reset work from the link-down path to the link-up path fixes
> > the issue. Also, remove the unnecessary enum member.
> >
> The user who reported the issue at that time confirmed that the original
> change fixed the issue for him.
> Can you explain, from the NICs perspective, what exactly the difference
> is when doing the reset after link-up?
> Including an explanation how the original change suppresses the link-up
> interrupt. And why that's not the case when doing the reset after link-up=
.

The host-plug test under original change does have the link-up
interrupt and r8169_phylink_handler() called. There is not much clue
why calling reset in link-down path doesn't work but in link-up does.

After several new tests, I found that with the original change, the
link won't break if I unplug and then plug the cable within about 3
seconds. On the other hand, the connections always break if I re-plug
the cable after a few seconds.

With this new patch (reset in link-up path), both of the tests work
without any error.

>
> I simply want to be convinced enough that your change doesn't break
> behavior for other users.
>
> > Fixes: 621735f59064 ("r8169: fix rare issue with broken rx after link-d=
own on RTL8125")
> > Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> > ---
> >  drivers/net/ethernet/realtek/r8169_main.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/et=
hernet/realtek/r8169_main.c
> > index 3507c2e28110..632e661fc74b 100644
> > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > @@ -590,7 +590,6 @@ struct rtl8169_tc_offsets {
> >  enum rtl_flag {
> >       RTL_FLAG_TASK_ENABLED =3D 0,
> >       RTL_FLAG_TASK_RESET_PENDING,
> > -     RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
> >       RTL_FLAG_TASK_TX_TIMEOUT,
> >       RTL_FLAG_MAX
> >  };
> > @@ -4698,8 +4697,6 @@ static void rtl_task(struct work_struct *work)
> >  reset:
> >               rtl_reset_work(tp);
> >               netif_wake_queue(tp->dev);
> > -     } else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE, =
tp->wk.flags)) {
> > -             rtl_reset_work(tp);
> >       }
> >  out_unlock:
> >       rtnl_unlock();
> > @@ -4729,11 +4726,13 @@ static void r8169_phylink_handler(struct net_de=
vice *ndev)
> >       if (netif_carrier_ok(ndev)) {
> >               rtl_link_chg_patch(tp);
> >               pm_request_resume(d);
> > -             netif_wake_queue(tp->dev);
> > -     } else {
> > +
> >               /* In few cases rx is broken after link-down otherwise */
> >               if (rtl_is_8125(tp))
> > -                     rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_NO_QUEU=
E_WAKE);
> > +                     rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING=
);
> > +             else
> > +                     netif_wake_queue(tp->dev);
>
> This call to netif_wake_queue() isn't needed any longer, it was introduce=
d with
> the original change only.
>
> > +     } else {
> >               pm_runtime_idle(d);
> >       }
> >
>

CC. Martin Kj=C3=A6r J=C3=B8rgensen  <me@lagy.org>, could you kindly test i=
f
this new patch works on your environment? Thanks!

En-Wei,
Best regards.

