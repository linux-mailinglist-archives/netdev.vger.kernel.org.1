Return-Path: <netdev+bounces-103116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01C090659F
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ECB3B246FA
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038D413C80A;
	Thu, 13 Jun 2024 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZCbUCSQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437A313BC39
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265006; cv=none; b=bRqfYIMQx/v9vwZlxgesszXP85FHSq3xTqV5LGgt/3Pg3YesGuBSRqn1hKZ9O0S5q7nzRtpHsjltRjJxrxl6P5HbriIsmpEk+IjQm3f8uqB1d854r3leubeKacmPOEM94B1J3cThngSmFBXuyBhIPNpyS9wBQNBoJ9nRinhLZh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265006; c=relaxed/simple;
	bh=GzYFvWSHpbONd4tPj5OCauOdEzxoUypCNSMdA3zCwK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luJNS0iucZLgWnno9ZGLC4ZCAD1qXyoDYggzqEdyozgVOnvFwSSFhJxDgE0mDVqpEb7b5Uc9ifLKt6OqY/2yilG7ZfbaTSAizkPg4LOwdIBAATorA2nFmPqyJe8xJX0fLaUciPJH7FxMOe0ICBZfmP0ApmMnv8z1nUw8WHLfjn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZCbUCSQ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a68b41ef3f6so89396466b.1
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 00:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718265003; x=1718869803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzYFvWSHpbONd4tPj5OCauOdEzxoUypCNSMdA3zCwK8=;
        b=KZCbUCSQOLArgR2a5RbVC357birgrAZsQqkSCRekrLr23XbZpSXoXPqx49uALKLx0L
         hIbOAUnkrgjbhlDDxSXlS8BNoZEgEAkZ90Tzjk7r8KrISjEk48IVeYMXdakZd5gGfAgU
         ffK3I+KXYSHsUgrX8m/AzOinYX6G31BbsjEH0LmLb7w1sJalPA7CEXSyYIsi5qauVxfq
         5CfKeX9DWoUtUOQaOC2n7RI3aquz4MC0XSzwPc8BJKTuV8GpRyUUK9+OO7jnSKBZDayi
         wdPtxcYa3+6ZeYNlLOjK35HZ4ef5Bsqh+yfAf1QPh+08tm3mvHa5/QsvuKLrjKoMtk5l
         0cSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718265003; x=1718869803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GzYFvWSHpbONd4tPj5OCauOdEzxoUypCNSMdA3zCwK8=;
        b=Vwf2+/XfB0W2qkJKHD6qHgrDAY1XyG8BCmCHLir/a5HR8XqiF/zVZxHdFWRkHETzvt
         RlDloqLgJ9FUHePGyee/LJwzdnkfbdRlkA+IyN+mDuHkvmJ7nE96cppzbvBElUjStght
         F8RJYRZI+anAzrvAMSsRY6k+viPupkxeYXG3x3YYO2PIz21NA50zPza4H4weUYgvsBeR
         +eKFZsX4B53mKtqqndPc8HL4iA6BcmKkoeAHNkkXI814ggllOqcI3nSlDYiittJt11w2
         2rqKYnsoZV/+AszB70MYXQ2c6nkgPwPURencKkscMCkhsK6IoIHjZaTjQBP/8J6AV1Rb
         zdvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW79sYttwc0l1QYOurS6PgRiHQFMjjRBXAv/PIRBura8Jd7tsurkjALwah5AR1hd7tJNyewv6t+vQmLFHBCpDm8pj1vD4hq
X-Gm-Message-State: AOJu0YwrDdNJyTrrdXd+o3lGsV2w66rcU0HdrxLEpjI69YpF8vv63+VV
	2B+eyf2x67M0lC584jAxSd0j0Tyvz0IWfhb5hXs3LHMMV2zWgXSMX57LDNPsHrfYemJ1eIlNf4f
	nNe3DxoUidBFtaahImN/o2JsMJVM=
X-Google-Smtp-Source: AGHT+IF4P2p9e/NYedQ1hOsWPkuQzbFSM5iO7s3j0WZDvKq92b1ZFdIq1hBsg2i7ONcsZ9ieYUMnSyRBUN16/q9ztVg=
X-Received: by 2002:a17:906:6d41:b0:a6f:1166:fb7a with SMTP id
 a640c23a62f3a-a6f47d56c20mr217694566b.32.1718265003138; Thu, 13 Jun 2024
 00:50:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613023549.15213-1-kerneljasonxing@gmail.com>
 <ZmqFzpQOaQfp7Wjr@nanopsycho.orion> <CAL+tcoAir0u0HTYQCMgVNTkb8RpAMzD1eH-EevL576kt5u7DPw@mail.gmail.com>
 <Zmqdb-sBBitXIrFo@nanopsycho.orion> <CAL+tcoDCjm86wCHiVXDXMw1fs6ga9hp3x91u+Dy0CGBB=eEp2w@mail.gmail.com>
In-Reply-To: <CAL+tcoDCjm86wCHiVXDXMw1fs6ga9hp3x91u+Dy0CGBB=eEp2w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Jun 2024 15:49:25 +0800
Message-ID: <CAL+tcoB53bS_gJHY-eWKmmxeENnNR2Nn=UKwdPcS4oTgLXLZbw@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
To: Jiri Pirko <jiri@resnulli.us>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, dsahern@kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, leitao@debian.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, shayagr@amazon.com, 
	akiyano@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 3:24=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Thu, Jun 13, 2024 at 3:19=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >
> > Thu, Jun 13, 2024 at 08:08:36AM CEST, kerneljasonxing@gmail.com wrote:
> > >On Thu, Jun 13, 2024 at 1:38=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> =
wrote:
> > >>
> > >> Thu, Jun 13, 2024 at 04:35:49AM CEST, kerneljasonxing@gmail.com wrot=
e:
> > >> >From: Jason Xing <kernelxing@tencent.com>
> > >> >
> > >> >Since commit 74293ea1c4db6 ("net: sysfs: Do not create sysfs for no=
n
> > >> >BQL device") limits the non-BQL driver not creating byte_queue_limi=
ts
> > >> >directory, I found there is one exception, namely, virtio-net drive=
r,
> > >> >which should also be limited in netdev_uses_bql(). Let me give it a
> > >> >try first.
> > >> >
> > >> >I decided to introduce a NO_BQL bit because:
> > >> >1) it can help us limit virtio-net driver for now.
> > >> >2) if we found another non-BQL driver, we can take it into account.
> > >> >3) we can replace all the driver meeting those two statements in
> > >> >netdev_uses_bql() in future.
> > >> >
> > >> >For now, I would like to make the first step to use this new bit fo=
r dqs
> > >> >use instead of replacing/applying all the non-BQL drivers in one go=
.
> > >> >
> > >> >As Jakub said, "netdev_uses_bql() is best effort", I think, we can =
add
> > >> >new non-BQL drivers as soon as we find one.
> > >> >
> > >> >After this patch, there is no byte_queue_limits directory in virtio=
-net
> > >> >driver.
> > >>
> > >> Please note following patch is currently trying to push bql support =
for
> > >> virtio_net:
> > >> https://lore.kernel.org/netdev/20240612170851.1004604-1-jiri@resnull=
i.us/
> > >
> > >I saw this one this morning and I'm reviewing/testing it.
> > >
> > >>
> > >> When that is merged, this patch is not needed. Could we wait?
> > >
> > >Please note this patch is not only written for virtio_net driver.
> > >Virtio_net driver is one of possible cases.
> >
> > Yeah, but without virtio_net, there will be no users. What's the point
> > of having that in code? I mean, in general, no-user kernel code gets
> > removed.
>
> Are you sure netdev_uses_bql() can limit all the non-bql drivers with
> those two checks? I haven't investigated this part.

I just googled it very quickly and saw the ENA driver which turns off
BQL by default due to the problem of head-of line blocking[1].
IIUC, ENA is not limited by the checks in netdev_uses_bql() but it should.

I run this command: grep -ir -E "NO_QUEUE|NETIF_F_LLTX"
drivers/net/ethernet/amazon/ena

Am I right?

[1]: https://github.com/amzn/amzn-drivers/issues/262

>
> >
> >
> > >
> > >After your patch gets merged (I think it will take some time), you
> > >could simply remove that one line in virtio_net.c.
> > >
> > >Thanks.

