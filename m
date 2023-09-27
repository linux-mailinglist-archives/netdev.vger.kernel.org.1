Return-Path: <netdev+bounces-36568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1107B083E
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 17:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 805581C20833
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 15:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A412C450D9;
	Wed, 27 Sep 2023 15:29:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92C76FA2
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 15:28:59 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13797121
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 08:28:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50437f39c9dso16083643e87.3
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695828534; x=1696433334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVgwDObXb6UAmjjtbbeBb3r9BHG4gpzxjTumkUEWtbQ=;
        b=GPl5upZypiKDyhQ1HgTWEXUzL8qT6uk2246AjJ4ZyUjlVoT/ZrcqZjlMzHGohYyGAR
         pq3oTuDCmYFN04vujB4gMEUam2EIfFdmt5mb0ddHVuJ6zCsku+mB8Mz7n1jOgGWrJ004
         nOK8KyThjZwheFJTILm/B0h5++jT5NX9h3oLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695828534; x=1696433334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVgwDObXb6UAmjjtbbeBb3r9BHG4gpzxjTumkUEWtbQ=;
        b=RL2A5Ziowp6fDj7GMBSm+voJfnQSChgLKW5e2QhLHOJgDITpJ6KA5Xt6IUZPMK8cNt
         Wo7dNMAzYjGDF43Q1gGtEgynzYhOpd0rrngiUmdxkjGfh5EgaCDvizCcBQgODSx3za7L
         qgg7I6+Es8xoZK9vCFLuboqAI+bP8SPCFGupe5u7FdMR70X8xP3jl4dW3DF9JzwDWD8w
         YoI0eWpgILIXd+86Doev6rLpTgzrPlamQfjz8WDSZuHCZ2oh89wFNJEwBr39nC2I7kaf
         Oua0oDbi0iml+TB07QaTRE/zwqadhWtvMfUtApuKG2DA8ttyZJemJTliWW7doYdraHYS
         r0fg==
X-Gm-Message-State: AOJu0YzYhlxY1+6HC28TxXGRgjs+WOniA1gGpRyuU2j36ZcBgakHt0Q2
	nUHfCPxqAeipYT9HcktvpjLkWdc3iUDDEDeQFBRoMqdm
X-Google-Smtp-Source: AGHT+IHGnl8QLr4GB5KoKYpnIdaGOfVLT7ShezUkloK+KldBY1jDI1LWNpWbEiwECYNFTNTFQygpuA==
X-Received: by 2002:a19:f608:0:b0:500:b3fe:916e with SMTP id x8-20020a19f608000000b00500b3fe916emr1575225lfe.2.1695828533993;
        Wed, 27 Sep 2023 08:28:53 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id o9-20020a1709062e8900b009ae587ce133sm9415467eji.188.2023.09.27.08.28.53
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 08:28:53 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so22455a12.0
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 08:28:53 -0700 (PDT)
X-Received: by 2002:a50:d61c:0:b0:51e:16c5:2004 with SMTP id
 x28-20020a50d61c000000b0051e16c52004mr288987edi.6.1695828533058; Wed, 27 Sep
 2023 08:28:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926212824.1512665-1-dianders@chromium.org>
 <20230926142724.2.I65ea4ac938a55877dc99fdf5b3883ad92d8abce2@changeid> <62fec09e-c881-498e-9ac0-d0a6de665f16@rowland.harvard.edu>
In-Reply-To: <62fec09e-c881-498e-9ac0-d0a6de665f16@rowland.harvard.edu>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 27 Sep 2023 08:28:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V4R9TAGH+cCG=YBgCFO5F9hniPV-ycZjk5=z5mSjFQ7A@mail.gmail.com>
Message-ID: <CAD=FV=V4R9TAGH+cCG=YBgCFO5F9hniPV-ycZjk5=z5mSjFQ7A@mail.gmail.com>
Subject: Re: [PATCH 2/3] r8152: Retry register reads/writes
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jakub Kicinski <kuba@kernel.org>, Hayes Wang <hayeswang@realtek.com>, 
	"David S . Miller" <davem@davemloft.net>, linux-usb@vger.kernel.org, 
	Grant Grundler <grundler@chromium.org>, Edward Hill <ecgh@chromium.org>, andre.przywara@arm.com, 
	bjorn@mork.no, edumazet@google.com, gaul@gaul.org, horms@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Wed, Sep 27, 2023 at 6:43=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Tue, Sep 26, 2023 at 02:27:27PM -0700, Douglas Anderson wrote:
> > +
> > +static
> > +int r8152_control_msg(struct usb_device *udev, unsigned int pipe, __u8=
 request,
> > +                   __u8 requesttype, __u16 value, __u16 index, void *d=
ata,
> > +                   __u16 size, const char *msg_tag)
> > +{
> > +     int i;
> > +     int ret;
> > +
> > +     for (i =3D 0; i < REGISTER_ACCESS_TRIES; i++) {
> > +             ret =3D usb_control_msg(udev, pipe, request, requesttype,
> > +                                   value, index, data, size,
> > +                                   USB_CTRL_GET_TIMEOUT);
> > +
> > +             /* No need to retry or spam errors if the USB device got
> > +              * unplugged; just return immediately.
> > +              */
> > +             if (udev->state =3D=3D USB_STATE_NOTATTACHED)
> > +                     return ret;
>
> Rather than testing udev->state, it would be better to check whether
> ret =3D=3D -ENODEV.  udev->state is meant primarily for use by the USB co=
re
> and it's subject to races.

Thanks for looking my patch over!

Happy to change this to -ENODEV. In my early drafts of this patch I
looked at -ENODEV but I noticed that other places in the driver were
checking `udev->state =3D=3D USB_STATE_NOTATTACHED` so I changed it. In
reality I think for this code path it doesn't matter a whole lot. The
only thing it's doing is avoiding a few extra retries and avoiding a
log message. :-)

I'll wait a few more days to see if there is any other feedback on
this series and then send a new version with that addressed. If
someone needs me to send a new version sooner then please yell.

-Doug

