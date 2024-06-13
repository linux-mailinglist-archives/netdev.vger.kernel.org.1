Return-Path: <netdev+bounces-103227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E94590732F
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C87286A6B
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D1C142E81;
	Thu, 13 Jun 2024 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/prxloI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22A11E49B
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284173; cv=none; b=ZdeXF1XYSmfgSh/T2oRicctSrD2aJdhtkjWQsCCegyD8xUBifxcMj70+eiRX3ZYaxl9/RCxXBX4z44Vic9jaXyGGyxhp17BQ8PHvobc/NsM9sk87iUTVqSp7w1b62+VOtzaPCEAMUEcxxNSblj03vjztzotZuR5MLWkQO9Amn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284173; c=relaxed/simple;
	bh=ObytPm8pcL7y5ZGPGb2J7I62bPvXDiqgzTsAvmDXBos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dw+NARfYHHBsNDXlNjf9f4uy7N1ZVaz2Avt3KQ9oauiJ/qcZk6Sy9rY9WR3VICStLSphz97ICMeufZkReapjEp5o07K+BzMj/05ZxDXJQHctdqKyq3KpeWrjUwwTDFUbkflVuBRArMIJorGYPVtp1D3p54dDqJyPBfcU+0o2lDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/prxloI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f21ff4e6dso167253166b.3
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 06:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718284170; x=1718888970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObytPm8pcL7y5ZGPGb2J7I62bPvXDiqgzTsAvmDXBos=;
        b=B/prxloI6EeT6l7gQdHlrC9fH0LGjNjDi8k8jvWRAiNEDsZg7p4S5XBzmpghknCmlD
         bP3KUrppoMw9KjUKhrtEC4qXnMMmlwbQMPqOwILEXbEUHzpgHL5umcwnBMizAeoD6TlT
         1d/8IFia9sjVGhye0VIPK15dWUphn+kbiHIFR0S8HDzv8/QWvxwPnKikOar0ac6aBF5F
         RDcHva2bVdke8UdXw6uYIQKmIxnvfHwa6W06uIlvgysm1SC2C8avGbWbUuInZoZKM+LF
         a0tuPJsVSKoVz0Zcx7IEAnjl37u98ouIRnPd97z2V3DEXp5RSewp/0Uu3UV5GdX4Oibi
         WQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718284170; x=1718888970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObytPm8pcL7y5ZGPGb2J7I62bPvXDiqgzTsAvmDXBos=;
        b=VDeq7CpfdLLZe4zmzCKWR83MS1m3pSb1PiqhV6N+A3FyD0Kxnrqu5CqKFZ+PI8zTiw
         1vWUCbe8ESyd9RxgAPnFNWMzNaXtoWyxik1XwBwq0287FMVmXB/Wrfo+iJHy6LIN0tkO
         beJL48Krjb3q5sBJj3gL3pzoasef2fHGwysEHfWigDHDyhrJYr6p6jezbo2Br/mDyyNK
         BuXlKAbDBL67AGcOpSjyupodvC8y9yvh4TJxfgiAFBCOtlkTL73tlGkfAB02pS8BEz5T
         Rolef9tZ95tuYt80G7FVjpIzZ3jhhT4rKq7IT4xqUJUSbzEwDuSwSxEo9yzNspsLyfgK
         p24g==
X-Forwarded-Encrypted: i=1; AJvYcCX7ZCXCBS3hZTFuE2U68+DOm8DW2gbFkh7p//oEANxe4kMzKaH9iXeCZpu3gQvQRrrV41tQdZN9IrmPxmHG27KXxHWR52sr
X-Gm-Message-State: AOJu0Yy7htRGHdfUtHQaEvWnaLvKlPVELhoOQ02VZIn07S5cZMBU9Zbh
	pXaY0nAvimj2A6Y4/nRIR/TWivxdAOsIYp/fXXy+XDZPON/2ebBWS4WewXmqQPftqeNQFrstBKK
	X5VpU2j9dWkMRn8H88U0h7V+Eyxk=
X-Google-Smtp-Source: AGHT+IESWb9IYL2vX/jrqk4AyrRR4KoHMGkbvdGret/61xVXytB2HEHM8bptZ46X2Fc+27vRclpe6/CZCYDHCzDvLYk=
X-Received: by 2002:a17:906:7213:b0:a6e:88cc:bee9 with SMTP id
 a640c23a62f3a-a6f47d52441mr283827766b.24.1718284169655; Thu, 13 Jun 2024
 06:09:29 -0700 (PDT)
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
 <CAL+tcoDZ_8e9SDRdbQSDz=TCRGQ3w0toSZ0U8poUKpQcAHhN7A@mail.gmail.com>
In-Reply-To: <CAL+tcoDZ_8e9SDRdbQSDz=TCRGQ3w0toSZ0U8poUKpQcAHhN7A@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Jun 2024 21:08:51 +0800
Message-ID: <CAL+tcoAbpnAwHV+zpM672W=1pxW4U0reh9s_R7a4kMKp61fxyg@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, dsahern@kernel.org, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	leitao@debian.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:26=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Thu, Jun 13, 2024 at 3:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Thu, Jun 13, 2024 at 09:51:00AM +0200, Jiri Pirko wrote:
> > > Thu, Jun 13, 2024 at 09:24:27AM CEST, kerneljasonxing@gmail.com wrote=
:
> > > >On Thu, Jun 13, 2024 at 3:19=E2=80=AFPM Jiri Pirko <jiri@resnulli.us=
> wrote:
> > > >>
> > > >> Thu, Jun 13, 2024 at 08:08:36AM CEST, kerneljasonxing@gmail.com wr=
ote:
> > > >> >On Thu, Jun 13, 2024 at 1:38=E2=80=AFPM Jiri Pirko <jiri@resnulli=
.us> wrote:
> > > >> >>
> > > >> >> Thu, Jun 13, 2024 at 04:35:49AM CEST, kerneljasonxing@gmail.com=
 wrote:
> > > >> >> >From: Jason Xing <kernelxing@tencent.com>
> > > >> >> >
> > > >> >> >Since commit 74293ea1c4db6 ("net: sysfs: Do not create sysfs f=
or non
> > > >> >> >BQL device") limits the non-BQL driver not creating byte_queue=
_limits
> > > >> >> >directory, I found there is one exception, namely, virtio-net =
driver,
> > > >> >> >which should also be limited in netdev_uses_bql(). Let me give=
 it a
> > > >> >> >try first.
> > > >> >> >
> > > >> >> >I decided to introduce a NO_BQL bit because:
> > > >> >> >1) it can help us limit virtio-net driver for now.
> > > >> >> >2) if we found another non-BQL driver, we can take it into acc=
ount.
> > > >> >> >3) we can replace all the driver meeting those two statements =
in
> > > >> >> >netdev_uses_bql() in future.
> > > >> >> >
> > > >> >> >For now, I would like to make the first step to use this new b=
it for dqs
> > > >> >> >use instead of replacing/applying all the non-BQL drivers in o=
ne go.
> > > >> >> >
> > > >> >> >As Jakub said, "netdev_uses_bql() is best effort", I think, we=
 can add
> > > >> >> >new non-BQL drivers as soon as we find one.
> > > >> >> >
> > > >> >> >After this patch, there is no byte_queue_limits directory in v=
irtio-net
> > > >> >> >driver.
> > > >> >>
> > > >> >> Please note following patch is currently trying to push bql sup=
port for
> > > >> >> virtio_net:
> > > >> >> https://lore.kernel.org/netdev/20240612170851.1004604-1-jiri@re=
snulli.us/
> > > >> >
> > > >> >I saw this one this morning and I'm reviewing/testing it.
> > > >> >
> > > >> >>
> > > >> >> When that is merged, this patch is not needed. Could we wait?
> > > >> >
> > > >> >Please note this patch is not only written for virtio_net driver.
> > > >> >Virtio_net driver is one of possible cases.
> > > >>
> > > >> Yeah, but without virtio_net, there will be no users. What's the p=
oint
> > > >> of having that in code? I mean, in general, no-user kernel code ge=
ts
> > > >> removed.
> > > >
> > > >Are you sure netdev_uses_bql() can limit all the non-bql drivers wit=
h
> > > >those two checks? I haven't investigated this part.
> > >
> > > Nope. What I say is, if there are other users, let's find them and le=
t
> > > them use what you are introducing here. Otherwise don't add unused co=
de.
> >
> >
> > Additionally, it looks like virtio is going to become a
> > "sometimes BQL sometimes no-BQL" driver, so what's the plan -
> > to set/clear the flag accordingly then? What kind of locking
> > will be needed?
>
> Could we consider the default mode is BQL, so we can remove that new
> IFF_NO_BQL flag? If it's hard to take care of these two situations, I
> think we could follow this suggestion from Jakub: "netdev_uses_bql()
> is best effort". What do you think?

ENA driver faces the same 'problem' because it also has BQL and no-BQL.

Honestly, I don't want to spend too much time on this patch because
it's not worth it. Allow me to set the IFF_NO_BQL flag for the default
mode to try our 'best effort' for virtio_net and ENA driver?

Thanks,
Jason

