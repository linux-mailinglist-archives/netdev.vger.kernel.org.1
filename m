Return-Path: <netdev+bounces-186929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABD1AA416E
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 05:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D3A7A5CEC
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 03:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEA742AAF;
	Wed, 30 Apr 2025 03:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJC1mlr0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134912DC76D
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 03:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745984107; cv=none; b=k88oGgU//0lXt5gHXSOQFBdaMpbz7vx0lh9nY2cHW4h6QzqYE0tyYk4P2u8386tWHI/lK0/8bVtKHdCtAX0piZYSO7RCVwbFEtzCIbwnxNg037Okd/NK3rvKFNTzued4ozOxzQ343Prw9Lx/VvTTt2IhoUP/DX0ehZdNbevV7c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745984107; c=relaxed/simple;
	bh=8CP1/l95AAIu2RBu8lBb5i+OSNRKCka5XvJ9McWKyls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tipBeNiEuIhiECehIBa5Z3NVgomwcj9cZ1r+lmVBKCAEKYoF1aR05mus4SBHoY0uc00wlXXSx1PzbAtrrTpWlDtq3ymVQXjLwyEtbZYW1dCLCgL/g6SrG0AuW0dc3xXDGHP6nWn/F07dZA0mvGtoP4QHTmrv9PibNySRjFPIryQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJC1mlr0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745984103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CP1/l95AAIu2RBu8lBb5i+OSNRKCka5XvJ9McWKyls=;
	b=WJC1mlr0MwoAy10vdwwOJCfHQYtQ+z1lcnL1Lc3hwU/WMRG/l9ffw1HSBbHSY5fr6pVvNQ
	XX5LIxVdU1KIpqgsrVG2ywWJ0FovpT4R+Ur8Ap/i3gNnpkWYv2Qi5+5dVlV5sXT+I09vZ7
	qANFDqyQCNg346M8kTn+9Mh3DIk8O3s=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-KrE6iXSqMu6RiXAxEI7SUw-1; Tue, 29 Apr 2025 23:35:02 -0400
X-MC-Unique: KrE6iXSqMu6RiXAxEI7SUw-1
X-Mimecast-MFC-AGG-ID: KrE6iXSqMu6RiXAxEI7SUw_1745984101
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3086107d023so5811786a91.2
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 20:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745984101; x=1746588901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CP1/l95AAIu2RBu8lBb5i+OSNRKCka5XvJ9McWKyls=;
        b=EOmzoIHyFkG9g1cjWMZHQ42313axjMuWnL/ei9MnS6kQl9e4+5WE/jjoKR/TBMQ9GV
         6V9CIAfy7Has56Z2rPWpuhBDM5hx/us74EnOcBH9I558JzKKgcr2N2yhAQbtgKHL60bB
         BpUSmVBMFCZJOaDObq/XqrepnOWNH3kb25VVDI3jurygPsW++i2eNAxk0ER0zZkSBYO5
         ZoU6Q+6i7puv/9iDaHjWduQ+x0onXivTr1cRLFzISpEeyyUMzW10RZMUZuqPAaKYPvNZ
         jZxfKDGaeZbVFe2lMQBWi4UQnFvd9h9D1CaVoBrrwlENu3Hh6/CF4RD5kSBBsepQc7JU
         9tmw==
X-Forwarded-Encrypted: i=1; AJvYcCWscjo5MI1vc1d4oNEUeHzP0N98r8ULp/OjB6JkwMSu6XYXnwwPLxfZc0jddszWJ8B9qpVLRGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkc/X/l8o+G53hKO1ggi4h42Cs/HSD8fV/4oPJX71K8/LKgQgT
	ihNoZafxTdSCGzmT5ER5gJ6GlmreOBI4YQqPOdWqDICpSdwtwJrfdYXJrYjq5yWc6wn5kODkZxX
	4RlJQj09U/X3nhdK/5X9VESphtCBoxwlVpBkPlt5/naTFnQLlNG6FjtMGQsWQ4cGGDawY/2fHqx
	EzoCq4rr56ziawIl2lHWPbBU7r1mdQ
X-Gm-Gg: ASbGncs2N+DVr3YauxsmVcflTnk8Hs/DABrdly2Yz8UOj4kDFmo7qNHSajj/eJLCANf
	xbTSUja++KQD8nBZRN5t+so2DzWg8Usy9i1Is+hvLs7FJe7JAZ9e+ys/4Z8TgHbxw+bdP
X-Received: by 2002:a17:90a:d883:b0:2ee:b4bf:2d06 with SMTP id 98e67ed59e1d1-30a3331ef58mr1953081a91.19.1745984101060;
        Tue, 29 Apr 2025 20:35:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSS7dOdgP7A+HNpiMxiMx5KPQzzq0FQebByqw2CgDOWtoUxx+JmBHparnOyVfe7iSSZKWz7P4f0WwnDi967iI=
X-Received: by 2002:a17:90a:d883:b0:2ee:b4bf:2d06 with SMTP id
 98e67ed59e1d1-30a3331ef58mr1953058a91.19.1745984100613; Tue, 29 Apr 2025
 20:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421024457.112163-1-lulu@redhat.com> <20250421024457.112163-5-lulu@redhat.com>
 <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
 <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
 <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com> <20250429065044-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250429065044-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 30 Apr 2025 11:34:49 +0800
X-Gm-Features: ATxdqUHqfIZKZZ7USbEVYrV7yi8BrNiRLgIgSnFckLR6vC0VClLgTNwjOGLKeT4
Message-ID: <CACGkMEteBReoezvqp0za98z7W3k_gHOeSpALBxRMhjvj_oXcOw@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 6:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrote:
> > On Mon, Apr 21, 2025 at 11:46=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > On Mon, Apr 21, 2025 at 11:45=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > >
> > > > On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu@redhat.com>=
 wrote:
> > > > >
> > > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL=
`,
> > > > > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > > > > is disabled, and any attempt to use it will result in failure.
> > > >
> > > > I think we need to describe why the default value was chosen to be =
false.
> > > >
> > > > What's more, should we document the implications here?
> > > >
> > > > inherit_owner was set to false: this means "legacy" userspace may
> > >
> > > I meant "true" actually.
> >
> > MIchael, I'd expect inherit_owner to be false. Otherwise legacy
> > applications need to be modified in order to get the behaviour
> > recovered which is an impossible taks.
> >
> > Any idea on this?
> >
> > Thanks
>
> At this point, as we changed the behaviour, we have two types of legacy a=
pplications
> - ones expecting inherit_owner false
> - ones expecting inherit_owner true

Considering vhost has been used for more than a decade, I would expect
more will expect inhert_owner to be false.

>
> Whatever we do, some of these will have to be changed.

If we must choose one to break, I'd expect to break less.

> Given current
> kernel has it as true, and given it is a cleaner behaviour that will
> keep working when we disable CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL in 10
> years, I think it's the better default.

The problem is, if we set it to true and only an ioctl will bring the
old behavior back. Who will use this ioctl? We can't modify all legacy
applications.

> If you want to change it transparently, look for ways to
> distinguish between the two types.
>
> The application in question is qemu, is it not?

Looks not, it's the application or management layer that tries to set
the affinity to the owner of the vhost.

For example, if I start a testpmd + vhost_net and pinn testpmd runs on
cpu0. I will get half of the performance since vhost will contend with
cpu with testpmd.

> I do not see how sticking an ioctl call into its source is such
> a big deal, if this is what we want to do.
> A bit of short term pain but we get clear maintainable semantics.

What's more important, the way that introduces new fork behaviors
without a new uAPI is a bug. We need to fix that by introducing new
uAPI for the behaviour. This seems to be the short term pain instead
of introducing new uAPI for the old behaviour.

Thanks

>
> --
> MST
>


