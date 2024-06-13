Return-Path: <netdev+bounces-103252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F31B29074C4
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CEFE1F2158E
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECFB146A86;
	Thu, 13 Jun 2024 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXe269nw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEDE146A9A
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287915; cv=none; b=F9j3PTI3zj6LShkhtFJkCJ2AWMOPosmixykEtOkq7M633oZtGZcEQy6OYPxxpmqPHolHaMfHCdBT1cK4pXC56Lk6yw9t+Q6QhVHr8N1cKILdegECgIu4zqHWhjBaOUn5babtXjvl+5jBYzTEsBljJs3hllkVh1gDD99qJTh6mKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287915; c=relaxed/simple;
	bh=O6dr3kvkjUXYCKO3ot8Cmn4ORn113k/RdE9VQxXQ1+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ry+6AqdQiVrkVLgp4dJ4cgq83NTd7Cm94m09tXU2Z8G3d+Bqq1nhVDs7mdQ1Ec6l2yHcJJbtyH2OK3Ka/vdT6d7h10ZDyDSnqfhqMs6KZ1xxLNknhIyOOy1ek82uW6HrOlzhgHOVuf+GNuVT4wUrMzmzvNWXT5pTpbhcJNKV1MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXe269nw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57c75464e77so1234219a12.0
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718287912; x=1718892712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6dr3kvkjUXYCKO3ot8Cmn4ORn113k/RdE9VQxXQ1+E=;
        b=RXe269nwsPaNjzSSU4ZB5scLXXBqCl8j5ITGPxVCJka16RW2kogxLGctQtAZtSl6BQ
         9hs8uXiOvZg0fy05N+NTHAiKhG+HjyBkxjik+QOBR1sUEnGdN0SLi4tkS4MTAViHkwUJ
         l5ptGBtTxzSCPprlmONg83W7FZd2agTkebVprtlE6Uo8LEF4bkX1JrGE6qgsQked+Fl1
         m5QDXzZRm7NZC/j3k3AeeTUdTqXGQIaDInfYvavYNvb524IbI6Y73/Fu6pPDT04bTB4B
         y8emJELCJ5T/aqOrmss3a58wd+pPWGO67sracHglD/tm7NT0EZ4lDrOJg/+ZDKFSDNwc
         LhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718287912; x=1718892712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6dr3kvkjUXYCKO3ot8Cmn4ORn113k/RdE9VQxXQ1+E=;
        b=dmrU/UkkP8KLVg2fpU04sl8gSuY3xujgUSzmp1AC0OUuf2/Ht9kinx/MFU7HfBxqjf
         LQtJOOrhpZ185OljBn5G6ZeUsDmjUDHn8hf33HkOLHUQgtyi8pDXZA0DEk/W7HxpESfG
         CoRIt7UDCX73qnVSunwLVAUNHLfargW6TtwvCEvD9shf3QoebAPdoIHL9oycM+JXbX/S
         PqzfJkzTe5oYqfvxNyhv3fT2kgCXciBrVJcaNwChNPshr5HSDn/7AhQ+Ef93U57T+XiX
         n1Kq1cWDKW2t7Fz+tDJbXhFAEaRxjFrqTkBeoI+tqcXPPbGBUEH3WDc03hsSRYv29+Gh
         usFA==
X-Forwarded-Encrypted: i=1; AJvYcCVK82yd123faEqSZVa65PFrCti+bAtpEGdvNegajS7oSQ7601MPt9vU9rUWEEIA0BEptun4bJ7291XK5X6DzKp2R4NdeDyP
X-Gm-Message-State: AOJu0YyIs1hwQzYIUv71RuqFlWPUCqtnCr6bc9xctZ8kEhzOl2KKRoJ/
	P58DcdL9MeQGxQRpz41HEFUciMErH4PkatJ5SHoIytdqPEryo2iRZY6iIi0X6EM0zah3TRjaxUk
	MigIH2eQeHrJY2ntHkqXPM+nGhNc=
X-Google-Smtp-Source: AGHT+IEo2LC3lvHUA2bUJ/5YGwHZmF/x50WP6y3Q/TETKq0jJ/8mp3ihkqC9wo+l1ImNzP6E/+Aw4amRKZ4NdcxiNqY=
X-Received: by 2002:a50:a45a:0:b0:57c:6e0a:e8d0 with SMTP id
 4fb4d7f45d1cf-57ca9756beamr3476262a12.1.1718287911609; Thu, 13 Jun 2024
 07:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613023549.15213-1-kerneljasonxing@gmail.com>
 <ZmqFzpQOaQfp7Wjr@nanopsycho.orion> <CAL+tcoAir0u0HTYQCMgVNTkb8RpAMzD1eH-EevL576kt5u7DPw@mail.gmail.com>
 <Zmqdb-sBBitXIrFo@nanopsycho.orion> <CAL+tcoDCjm86wCHiVXDXMw1fs6ga9hp3x91u+Dy0CGBB=eEp2w@mail.gmail.com>
 <Zmqk5ODEKYcQerWS@nanopsycho.orion> <20240613035148-mutt-send-email-mst@kernel.org>
 <CAL+tcoDZ_8e9SDRdbQSDz=TCRGQ3w0toSZ0U8poUKpQcAHhN7A@mail.gmail.com> <ZmrxdwR2srw11Blo@nanopsycho.orion>
In-Reply-To: <ZmrxdwR2srw11Blo@nanopsycho.orion>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Jun 2024 22:11:12 +0800
Message-ID: <CAL+tcoBu0mCDeDTdEYZ5ccboYOuFeBfbNYvefo2dOWgoxAPg+Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, dsahern@kernel.org, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, leitao@debian.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 9:17=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Thu, Jun 13, 2024 at 11:26:05AM CEST, kerneljasonxing@gmail.com wrote:
> >On Thu, Jun 13, 2024 at 3:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> >>
> >> On Thu, Jun 13, 2024 at 09:51:00AM +0200, Jiri Pirko wrote:
> >> > Thu, Jun 13, 2024 at 09:24:27AM CEST, kerneljasonxing@gmail.com wrot=
e:
> >> > >On Thu, Jun 13, 2024 at 3:19=E2=80=AFPM Jiri Pirko <jiri@resnulli.u=
s> wrote:
> >> > >>
> >> > >> Thu, Jun 13, 2024 at 08:08:36AM CEST, kerneljasonxing@gmail.com w=
rote:
> >> > >> >On Thu, Jun 13, 2024 at 1:38=E2=80=AFPM Jiri Pirko <jiri@resnull=
i.us> wrote:
> >> > >> >>
> >> > >> >> Thu, Jun 13, 2024 at 04:35:49AM CEST, kerneljasonxing@gmail.co=
m wrote:
> >> > >> >> >From: Jason Xing <kernelxing@tencent.com>
> >> > >> >> >
> >> > >> >> >Since commit 74293ea1c4db6 ("net: sysfs: Do not create sysfs =
for non
> >> > >> >> >BQL device") limits the non-BQL driver not creating byte_queu=
e_limits
> >> > >> >> >directory, I found there is one exception, namely, virtio-net=
 driver,
> >> > >> >> >which should also be limited in netdev_uses_bql(). Let me giv=
e it a
> >> > >> >> >try first.
> >> > >> >> >
> >> > >> >> >I decided to introduce a NO_BQL bit because:
> >> > >> >> >1) it can help us limit virtio-net driver for now.
> >> > >> >> >2) if we found another non-BQL driver, we can take it into ac=
count.
> >> > >> >> >3) we can replace all the driver meeting those two statements=
 in
> >> > >> >> >netdev_uses_bql() in future.
> >> > >> >> >
> >> > >> >> >For now, I would like to make the first step to use this new =
bit for dqs
> >> > >> >> >use instead of replacing/applying all the non-BQL drivers in =
one go.
> >> > >> >> >
> >> > >> >> >As Jakub said, "netdev_uses_bql() is best effort", I think, w=
e can add
> >> > >> >> >new non-BQL drivers as soon as we find one.
> >> > >> >> >
> >> > >> >> >After this patch, there is no byte_queue_limits directory in =
virtio-net
> >> > >> >> >driver.
> >> > >> >>
> >> > >> >> Please note following patch is currently trying to push bql su=
pport for
> >> > >> >> virtio_net:
> >> > >> >> https://lore.kernel.org/netdev/20240612170851.1004604-1-jiri@r=
esnulli.us/
> >> > >> >
> >> > >> >I saw this one this morning and I'm reviewing/testing it.
> >> > >> >
> >> > >> >>
> >> > >> >> When that is merged, this patch is not needed. Could we wait?
> >> > >> >
> >> > >> >Please note this patch is not only written for virtio_net driver=
.
> >> > >> >Virtio_net driver is one of possible cases.
> >> > >>
> >> > >> Yeah, but without virtio_net, there will be no users. What's the =
point
> >> > >> of having that in code? I mean, in general, no-user kernel code g=
ets
> >> > >> removed.
> >> > >
> >> > >Are you sure netdev_uses_bql() can limit all the non-bql drivers wi=
th
> >> > >those two checks? I haven't investigated this part.
> >> >
> >> > Nope. What I say is, if there are other users, let's find them and l=
et
> >> > them use what you are introducing here. Otherwise don't add unused c=
ode.
> >>
> >>
> >> Additionally, it looks like virtio is going to become a
> >> "sometimes BQL sometimes no-BQL" driver, so what's the plan -
> >> to set/clear the flag accordingly then? What kind of locking
> >> will be needed?
> >
> >Could we consider the default mode is BQL, so we can remove that new
> >IFF_NO_BQL flag? If it's hard to take care of these two situations, I
> >think we could follow this suggestion from Jakub: "netdev_uses_bql()
> >is best effort". What do you think?
>
> Make sense.
>
> Also, note that virtio_net bql utilization is going to be not only
> dynamically configured, but also per-queue. It would be hard to expose
> that over one device flag :)

At that time, I would let virtio_net driver go, that is to say, I
wouldn't take it into consideration in netdev_uses_bql() since it's
too complicated.

BTW, hope to see your per-queue configured feature patchset soon :)

>
>
> >
> >>
> >> > >
> >> > >>
> >> > >>
> >> > >> >
> >> > >> >After your patch gets merged (I think it will take some time), y=
ou
> >> > >> >could simply remove that one line in virtio_net.c.
> >> > >> >
> >> > >> >Thanks.
> >>

