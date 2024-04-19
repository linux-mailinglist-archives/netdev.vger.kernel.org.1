Return-Path: <netdev+bounces-89482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807818AA636
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 02:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF631C20FEB
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 00:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9367F;
	Fri, 19 Apr 2024 00:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDsN4QwJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278FB170
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 00:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713486500; cv=none; b=dLbzlgfDPop+POjlBIfz//+3bd+5pXb9b74/aid2tUiH7ubj2qnxjvo+JHxv7JBLeZ/hI9kbfXUriZG2GhEGzxC0ykYs5ZmUE0Q3eSUKi3hrEjRGmbvrCbSrVDqIRzNPyjkPRC5WI4JcpWziuUXYlKuHp30iDUpG6EJOZFvrST0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713486500; c=relaxed/simple;
	bh=dSZNehnN9r5CezmIltdPA0VTrCS53EGh0PlQ+urRr+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcsfO+oFKOUtcgiJf/K35bSe90IltDeSJJLeNOskZeIQq2Up/HNuFSCzt3X6v+Xhc/wvG6uIJez9LJDJ/jt58WVhzoi1tITIK6VxJyl2aRRv/kj64/pB7C0PMi3XKk+ka1nxLwaL1oO3SbRtJY1vUJYpjQBE9zB5C694P4t6ZDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDsN4QwJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713486497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ixM43eKD6HyWWzLCviaitbDO8X0Exu4KtEmuOhFK9A4=;
	b=eDsN4QwJrwyiDZkkwcUYVLFfWWOCiIryxf4Mt+b/vEZyrnHpstcTBBjoMi9Iy0mp2iqHzX
	YVAay1q/5di5t40TbHQPf7AHiQ01rNsRcr1dPGBMGnsYs2TbTfxyzb6Zc7DxcwJgZNgiko
	uGHqMvsVkBwp7qiSN/f3AaNJyQutkn8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-vI1uybLDNna-DS5khutdnw-1; Thu, 18 Apr 2024 20:28:15 -0400
X-MC-Unique: vI1uybLDNna-DS5khutdnw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5cdfd47de98so1601676a12.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 17:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713486494; x=1714091294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixM43eKD6HyWWzLCviaitbDO8X0Exu4KtEmuOhFK9A4=;
        b=qIP+8WSgdD0gmEhCJQMSm4P5ZuC9bYebW7y4ldRjEDXVfrv7t4ymV+eMkFThTiBzwE
         zX6j8gN29QNTG3CK2gRBWfaoxBiBmo4uTnNA/UXXB+xdH9uWJ3ZoRmWPEkB7BBBYuO1X
         y3Ut1aAOqWBSDMDcso6DKsiO6llol6hNXLfncWxOdnvN5LdbbH51A38Y8biHhRhEYoSo
         xkCbAYygGiedbilGs4p6jkB9hRmQ4JYTNvSHPQKyyv7CUh7z7Z3Y943GS7Wx5ob1gQd8
         nL4+2Aq3k70YHDkEKzQ92ktqqV+pWzwYQtAlXvBpV0D3Cu7XZy+xepeIE9najwKkxR5t
         pJPA==
X-Forwarded-Encrypted: i=1; AJvYcCWw1ZKTItx3ZQR5GksxF3Lt8rSttXdaruvqZwEnZldn3PekR3Gd3hmOivKvjpSJ0xQLAOEb+gixWpqSKTDUjdxZMIxOfk0k
X-Gm-Message-State: AOJu0YxeT3l6YDl/jGVSkQQdUsPd7iCHLj/8lvGXI8TChWA9iJwxanAC
	qv+dAP1zYzCnwEaMIhfDvK3dumRfwhXpZCFlGvNCKsrPKk+78q67DUkcwh/5cqG3MXIzqN6Rpvi
	cHeUHgu8lMqiomMaAO9pWEiM4xUxo1iLsZp15zNON42nXjr9pEm6OzAfEaNon+8OmL1hstxYsm1
	0TysaWkwdFNsqBuHBYMNfWB4OHfa+W
X-Received: by 2002:a05:6a20:8415:b0:1a9:5ba1:3b1b with SMTP id c21-20020a056a20841500b001a95ba13b1bmr1121605pzd.9.1713486494584;
        Thu, 18 Apr 2024 17:28:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3Jx6OWwhEuYt8SWfOjpP++d37DU+JdGZ54PDsqtZcYg5DtQuOhWM39nlaCkspQD0TH6XPuJAOobZoJsJP6/E=
X-Received: by 2002:a05:6a20:8415:b0:1a9:5ba1:3b1b with SMTP id
 c21-20020a056a20841500b001a95ba13b1bmr1121597pzd.9.1713486494248; Thu, 18 Apr
 2024 17:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416193039.272997-1-danielj@nvidia.com> <20240416193039.272997-4-danielj@nvidia.com>
 <CACGkMEsCm3=7FtnsTRx5QJo3ZM0Ko1OEvssWew_tfxm5V=MXvQ@mail.gmail.com>
 <28e45768-5091-484d-b09e-4a63bc72a549@linux.alibaba.com> <ad9f7b83e48cfd7f1463d8c728061c30a4509076.camel@redhat.com>
 <CH0PR12MB85802CBD3808B483876F8C77C90E2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <72f6c8a55adac52ad17dfe11a579b5b3d5dc3cec.camel@redhat.com> <a8ffbe97-22d1-4afe-bc6a-b4f9e7a8089a@linux.alibaba.com>
In-Reply-To: <a8ffbe97-22d1-4afe-bc6a-b4f9e7a8089a@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Apr 2024 08:28:03 +0800
Message-ID: <CACGkMEsy54akTSCEeOqFiC39097F82kARmZv3F42xf2Xmq0-pA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/6] virtio_net: Add a lock for the command VQ.
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"mst@redhat.com" <mst@redhat.com>, "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, Jiri Pirko <jiri@nvidia.com>, Dan Jurgens <danielj@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 12:12=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/4/18 =E4=B8=8B=E5=8D=8811:48, Paolo Abeni =E5=86=99=E9=81=
=93:
> > On Thu, 2024-04-18 at 15:38 +0000, Dan Jurgens wrote:
> >>> From: Paolo Abeni <pabeni@redhat.com>
> >>> Sent: Thursday, April 18, 2024 5:57 AM
> >>> On Thu, 2024-04-18 at 15:36 +0800, Heng Qi wrote:
> >>>> =E5=9C=A8 2024/4/18 =E4=B8=8B=E5=8D=882:42, Jason Wang =E5=86=99=E9=
=81=93:
> >>>>> On Wed, Apr 17, 2024 at 3:31=E2=80=AFAM Daniel Jurgens <danielj@nvi=
dia.com>
> >>> wrote:
> >>>>>> The command VQ will no longer be protected by the RTNL lock. Use a
> >>>>>> spinlock to protect the control buffer header and the VQ.
> >>>>>>
> >>>>>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> >>>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> >>>>>> ---
> >>>>>>    drivers/net/virtio_net.c | 6 +++++-
> >>>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >>>>>> index 0ee192b45e1e..d02f83a919a7 100644
> >>>>>> --- a/drivers/net/virtio_net.c
> >>>>>> +++ b/drivers/net/virtio_net.c
> >>>>>> @@ -282,6 +282,7 @@ struct virtnet_info {
> >>>>>>
> >>>>>>           /* Has control virtqueue */
> >>>>>>           bool has_cvq;
> >>>>>> +       spinlock_t cvq_lock;
> >>>>> Spinlock is instead of mutex which is problematic as there's no
> >>>>> guarantee on when the driver will get a reply. And it became even
> >>>>> more serious after 0d197a147164 ("virtio-net: add cond_resched() to
> >>>>> the command waiting loop").
> >>>>>
> >>>>> Any reason we can't use mutex?
> >>>> Hi Jason,
> >>>>
> >>>> I made a patch set to enable ctrlq's irq on top of this patch set,
> >>>> which removes cond_resched().
> >>>>
> >>>> But I need a little time to test, this is close to fast. So could th=
e
> >>>> topic about cond_resched + spin lock or mutex lock be wait?
> >>> The big problem is that until the cond_resched() is there, replacing =
the
> >>> mutex with a spinlock can/will lead to scheduling while atomic splats=
. We
> >>> can't intentionally introduce such scenario.
> >> When I created the series set_rx_mode wasn't moved to a work queue,
> >> and the cond_resched wasn't there.
> > Unfortunately cond_resched() is there right now.
>
> YES.
>
> >
> >> Mutex wasn't possible, then. If the CVQ is made to be event driven, th=
en
> >> the lock can be released right after posting the work to the VQ.
> > That should work.
>
> Yes, I will test my new patches (ctrlq with irq enabled) soon, then the
> combination
> of the this set and mine MAY make deciding between mutex or spin lock
> easier.
>
> Thanks.

So I guess the plan is to let your series come first?

Thanks

>
> >
> >>> Side note: the compiler apparently does not like guard() construct, l=
eading to
> >>> new warning, here and in later patches. I'm unsure if the code simpli=
fication
> >>> is worthy.
> >> I didn't see any warnings with GCC or clang. This is used other places=
 in the kernel as well.
> >> gcc version 13.2.1 20230918 (Red Hat 13.2.1-3) (GCC)
> >> clang version 17.0.6 (Fedora 17.0.6-2.fc39)
> >>
> > See:
> >
> > https://patchwork.kernel.org/project/netdevbpf/patch/20240416193039.272=
997-4-danielj@nvidia.com/
> > https://netdev.bots.linux.dev/static/nipa/845178/13632442/build_32bit/s=
tderr
> > https://netdev.bots.linux.dev/static/nipa/845178/13632442/build_allmodc=
onfig_warn/stderr
> >
> > Cheers,
> >
> > Paolo
>


