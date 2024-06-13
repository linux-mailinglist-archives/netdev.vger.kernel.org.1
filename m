Return-Path: <netdev+bounces-103147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B373B906892
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 11:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 080BDB20E6C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C2913A3E3;
	Thu, 13 Jun 2024 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHKfTcce"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E1513D891
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270807; cv=none; b=l+zH1M5j5N1WG9cSW5mVkiE9Vz/g34KjG6wDGiGqT6b7XwYXT88BwRpv4eP8qdVaq0VIy92z+FzRXsj7m8TVKcUDI1jY3ypzgT2NVOMqxve7VsgdQ7KlT9bJkEi3NDuZW2qpbgqZtQ4NirJ0lNBDk9JyQhU0INiRlZQhAUkVcfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270807; c=relaxed/simple;
	bh=fKfbpLG4kj1MC1G2aw+4ubK5fDus1DJOJbdJrkS81J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7jjLxVRRCvCB24lP2mJYIDMvyL1r0dhDsSKwynweb2rIJwRraHQCj0M32YrlJvnLiY2ISYHvg+3cjM3TtG8q0RYtrvUQ6bNmkmZMTU68z1xVTQ2tufbgD/eSFqEFCYM4vZJWnN8F5ZqjPIHYWswQk3uMKHNb28+gfLBnRtgFXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHKfTcce; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eabd22d441so10982471fa.2
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 02:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718270804; x=1718875604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKfbpLG4kj1MC1G2aw+4ubK5fDus1DJOJbdJrkS81J0=;
        b=NHKfTcceMchDn9JwbTTtYvJkr1N0sYhVtFskmss0MfckkQ7akRp1gRW8/2AWmFmwt1
         dJLRtjGMGsgo6IkwSnvSCNgwqg0Z+NXus1lE195HvyD3oX4L8Ch2+M3r6VWw3TsNMtrd
         f8Un0gOR+zEOBklDtnsI9eBIhznFg29JoZ0xqTvAR1qs4wllG/vjGyYOSbsVMVWgpSoL
         4ocQdUnWmErcW7K+6gJtQNj6R+dBNh4MvIgQdXYOWClrsRfYWI3EUykhYRj4323NwIjX
         1khpT9H6QTpMIpjjLU/lV7Je5sjBqEaU1FkHhKUAOP+g2dsDn/AOCLEjJrdGeXACv767
         ebHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718270804; x=1718875604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKfbpLG4kj1MC1G2aw+4ubK5fDus1DJOJbdJrkS81J0=;
        b=l8Cm6OdHinxbLwAoCcL9zrB8kygDBE6GSpaKWA4roISGL96IMCJZZ4+0XyxQp7dlVK
         GKVBQPAjEbX4vtj4Td31SgJ4Vit7Z69vy/1B91aDhQSlj+mR8hjvPrQ1rc+5mMmBpUYn
         r6/OuiE2ZP4Rrnw0kLQF8BLtxtyTg2/3KFjXqIF4ZVlm06qz2bTEZ8NlvkQQHkSHNX+t
         HO9/V/7Ych2ZBhnSW95i87bamyCLvwovwGBmPtVhBghxkFvqdQ+GntiDhmZFqQlXgdH7
         aXocrEwee1gAdmWObai+BZ6OZUmripwWWbB/pAa3NrwIgplBPVt9VuXiQfr+dmOLrj7q
         nxrg==
X-Forwarded-Encrypted: i=1; AJvYcCXFNk8Rii4PwxYKilcweOgjPvdOa4bwK3vpPmI75U8gJKJcZG8mFVPff+5Cdw/rk7KSj4eTDG2pTc3UtVeMBQ2GWYNSiSD8
X-Gm-Message-State: AOJu0Ywp1ja9JFp7GUxbyQait7pgqs6GA4kTj8WqWNvxsxsL7R7uoRR7
	m4eRMazXZPA2lIhy2k+GplrQX9AaaycfBmOBr3gPz40cpFzIObFnffTEWFMT/1eNcsJPClwph2F
	pflJ22B4fxbhuecxWBqhl1R8kMuw=
X-Google-Smtp-Source: AGHT+IGaxvv+6TgfdhKbWU6inD4esTITqvOe50XISM/rjyDrvEMvjeQEKSnkPxlZHSqWofobtbL9AwVz+B//7vV8p+c=
X-Received: by 2002:a05:6512:3f5:b0:52c:83c7:936a with SMTP id
 2adb3069b0e04-52c9a403749mr2717239e87.42.1718270803474; Thu, 13 Jun 2024
 02:26:43 -0700 (PDT)
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
In-Reply-To: <20240613035148-mutt-send-email-mst@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Jun 2024 17:26:05 +0800
Message-ID: <CAL+tcoDZ_8e9SDRdbQSDz=TCRGQ3w0toSZ0U8poUKpQcAHhN7A@mail.gmail.com>
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

On Thu, Jun 13, 2024 at 3:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jun 13, 2024 at 09:51:00AM +0200, Jiri Pirko wrote:
> > Thu, Jun 13, 2024 at 09:24:27AM CEST, kerneljasonxing@gmail.com wrote:
> > >On Thu, Jun 13, 2024 at 3:19=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> =
wrote:
> > >>
> > >> Thu, Jun 13, 2024 at 08:08:36AM CEST, kerneljasonxing@gmail.com wrot=
e:
> > >> >On Thu, Jun 13, 2024 at 1:38=E2=80=AFPM Jiri Pirko <jiri@resnulli.u=
s> wrote:
> > >> >>
> > >> >> Thu, Jun 13, 2024 at 04:35:49AM CEST, kerneljasonxing@gmail.com w=
rote:
> > >> >> >From: Jason Xing <kernelxing@tencent.com>
> > >> >> >
> > >> >> >Since commit 74293ea1c4db6 ("net: sysfs: Do not create sysfs for=
 non
> > >> >> >BQL device") limits the non-BQL driver not creating byte_queue_l=
imits
> > >> >> >directory, I found there is one exception, namely, virtio-net dr=
iver,
> > >> >> >which should also be limited in netdev_uses_bql(). Let me give i=
t a
> > >> >> >try first.
> > >> >> >
> > >> >> >I decided to introduce a NO_BQL bit because:
> > >> >> >1) it can help us limit virtio-net driver for now.
> > >> >> >2) if we found another non-BQL driver, we can take it into accou=
nt.
> > >> >> >3) we can replace all the driver meeting those two statements in
> > >> >> >netdev_uses_bql() in future.
> > >> >> >
> > >> >> >For now, I would like to make the first step to use this new bit=
 for dqs
> > >> >> >use instead of replacing/applying all the non-BQL drivers in one=
 go.
> > >> >> >
> > >> >> >As Jakub said, "netdev_uses_bql() is best effort", I think, we c=
an add
> > >> >> >new non-BQL drivers as soon as we find one.
> > >> >> >
> > >> >> >After this patch, there is no byte_queue_limits directory in vir=
tio-net
> > >> >> >driver.
> > >> >>
> > >> >> Please note following patch is currently trying to push bql suppo=
rt for
> > >> >> virtio_net:
> > >> >> https://lore.kernel.org/netdev/20240612170851.1004604-1-jiri@resn=
ulli.us/
> > >> >
> > >> >I saw this one this morning and I'm reviewing/testing it.
> > >> >
> > >> >>
> > >> >> When that is merged, this patch is not needed. Could we wait?
> > >> >
> > >> >Please note this patch is not only written for virtio_net driver.
> > >> >Virtio_net driver is one of possible cases.
> > >>
> > >> Yeah, but without virtio_net, there will be no users. What's the poi=
nt
> > >> of having that in code? I mean, in general, no-user kernel code gets
> > >> removed.
> > >
> > >Are you sure netdev_uses_bql() can limit all the non-bql drivers with
> > >those two checks? I haven't investigated this part.
> >
> > Nope. What I say is, if there are other users, let's find them and let
> > them use what you are introducing here. Otherwise don't add unused code=
.
>
>
> Additionally, it looks like virtio is going to become a
> "sometimes BQL sometimes no-BQL" driver, so what's the plan -
> to set/clear the flag accordingly then? What kind of locking
> will be needed?

Could we consider the default mode is BQL, so we can remove that new
IFF_NO_BQL flag? If it's hard to take care of these two situations, I
think we could follow this suggestion from Jakub: "netdev_uses_bql()
is best effort". What do you think?

>
> > >
> > >>
> > >>
> > >> >
> > >> >After your patch gets merged (I think it will take some time), you
> > >> >could simply remove that one line in virtio_net.c.
> > >> >
> > >> >Thanks.
>

