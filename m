Return-Path: <netdev+bounces-144689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5FD9C82DA
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 06:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D55B245DA
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 05:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4AC158DC4;
	Thu, 14 Nov 2024 05:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hve1d7bO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DBF1E0E13
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 05:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731563941; cv=none; b=VBw7fC2AhMi2gdcAamKJxmu3alvKtWeO6P0eDa3syTEsY4fAT3WXZ9uZ/I2barCgbcVOGucREMaeUiK/72D2P/TN16qovg3wHucooAYXrm/OHBV3KvtlpuF6EK63yJVmdQPERc0NJaKCcF3VdMYUIAVrpqhTFFE/7v0XLH+1vdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731563941; c=relaxed/simple;
	bh=ZXr+TjIk+3TUAi31MB7jDf2GOibO2uww2OXknCfrPLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPh5hw36meSuP54P8P/2hBxA0ErCWjU4poYPfknD72f5HJyrErQgA5z8V5sQx5+8ulUkJnXGDaD+Jr3Khk5CkcnABV5hgCSj0DmY9fU5e0uBHI71tjM+nJTmwDBXVYbb+XuoWQJj8xq65gK9p7NYHOyHjiY++vePjBVtW5ENoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hve1d7bO; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e64ed090so1e87.1
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 21:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731563938; x=1732168738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVF4qoblAyYWJlGgMA5ludEFaL4HP1vW57d3cFH2t6A=;
        b=hve1d7bOdeAv1hBEGxDzPDeWl1Lq6TtWfc84y2WI+8NEaCffvnFH3wEiBRZmd7Ztke
         v6SK3nywkov6BXhYS9apEIc+74Van8QvtvNUSck4mBVUtPBSwNHRhp0WbPVIPD0/sLOX
         phgqz/kWn+VKbrUY0gJaqn9nUX25YQE4m1j6oUYAbCGGKzWrHs7lHLBC5VXF4nfI0XCN
         H2Rd89f2bWTqQds9eWdOBtkJjRxgtf8xQHcXltVPHj7g8C2bmEGQm1yaWWe+eQPLCjjM
         HaZeUsZg7/h2jU2q5nc4n7jWu6bmW2yGQhWN4xtMVEV3ztmtEd/Kf9HjH34wGF8a3ro+
         hH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731563938; x=1732168738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVF4qoblAyYWJlGgMA5ludEFaL4HP1vW57d3cFH2t6A=;
        b=vj1Jt7IMyojmdScVv9G0OHxgVA5YdX7kG+iAYVVJI/tr5OGhJb2m9dyXEnqODrYI95
         7Xykih/Sp7x02iqYFQVeZwZsLQLs1dKLc2iez+IwnlXyOJPsTc0eMaxwJ2iiIYpd8r8F
         6vESjTKVclRvsnJZejD3ktsFUZ+ELBez+JHDwP+P6reyJZg/6RLnHNhYOHQ5Cmb9Iftl
         QspqvObZuVordAWTZmB68bICEOGwGj9DihLSNK0unaVAPRFdrtFBCFdGhkQ5J+sPafNT
         +GDekcYaYR1gbK0clhJcB/bufTTbo4vasowTRawcIIzqO0h6qlofZUv0hRX5sQ4+4hfj
         23qw==
X-Forwarded-Encrypted: i=1; AJvYcCVJF6VeITp7420EprsvpFk9x3T6WHFdUOUdXn205QhXNwqXG2JgMAYs0OPQNb/xBL/zbYevsx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcdDvYLq9WiIU4zvK8xFcFnOdIcd4d7dIbMzSGvMRh5pspIrnc
	QbCv5t0d7EyLsLz++gUX9UX+O5dN/5lVTqTSMC0ALYc9kSXroHXHqHm9mbOoTUSwZQEXKaMpycV
	lJgRXvoMP2AU7HSkN4a8ngRJPYotNQWWjgfPJ
X-Gm-Gg: ASbGnctzJa8i/JzthwPlwhI1k6RAAqcHymMP5826gBXbdw7YjEezeWMESsbcHYCecUu
	SDwrw9NWlk8CUEufLtOoyXwKu1OG03l67kmfvAjldwKZbJqikx36GKu/kpxVcrQ==
X-Google-Smtp-Source: AGHT+IF5dXy6KjRfaBmYjnPPAJ34MqLgJMphKtAJin7WMYczm0KOqYHT3gTCgxPxs0rdu2CHFUdawDvhzlmCnVQZcZg=
X-Received: by 2002:a05:6512:318a:b0:535:60b1:ffc2 with SMTP id
 2adb3069b0e04-53da8675a80mr246e87.0.1731563936730; Wed, 13 Nov 2024 21:58:56
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110081953.121682-1-yuyanghuang@google.com>
 <ZzMlvCA4e3YhYTPn@fedora> <b47b1895-76b9-42bc-af29-e54a20d71a52@lunn.ch>
 <CADXeF1HMvDnKNSNCh1ULsspC+gR+S0eTE40MRhA+OH16zJKM6A@mail.gmail.com>
 <ce2359c3-a6eb-4ef3-b2cf-321c5c282fab@lunn.ch> <CADXeF1FYoXTixLFFhESDkCo2HXG3JAzzdMCfkFrr2dqmRVQcWg@mail.gmail.com>
 <9fa93b71-cd81-44ce-b7cc-24b12be8cb24@lunn.ch>
In-Reply-To: <9fa93b71-cd81-44ce-b7cc-24b12be8cb24@lunn.ch>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Thu, 14 Nov 2024 14:58:18 +0900
Message-ID: <CADXeF1HQH=bhNWAtafUKD3-WoHhQEB-=TpwN9GdOOZ9PSaLktQ@mail.gmail.com>
Subject: Re: [PATCH net-next] netlink: add igmp join/leave notifications
To: Andrew Lunn <andrew@lunn.ch>
Cc: Hangbin Liu <liuhangbin@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com, 
	jiri@resnulli.us, stephen@networkplumber.org, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> So that probably leads to a NACK for these patches. If APF is your
> target, and to me it seems unlikely APF will get accepted into
> mainline, there is no need for these netlink changes. Hence a NACK.

> And this is probably your way in. Forget about APF when talking to
> mainline.

Thanks for the advice. I'll remove the APF context from the commit
message, as these patches should benefit mainline regardless of their
APF use case.

> Show these patches are useful in general. Explain the use
> case of IGMP/MLD control in user space using existing APIs to control
> the network stack and hardware.

> Yes, this is going in correct direction to get these patches
> merged. Focus on this. Solve these problems with ip monitor etc.  Once
> merged you can then use it with the out of mainline APF.

I plan to include MLD modifications and rewrite the commit message as
follows in patch v2.  I will also send the ip monitor patches in
parallel.

Please let me know if you have any further suggestions.

```
netlink: add IGMP/MLD join/leave notifications

This change introduces netlink notifications for multicast address
changes. The following features are included:
* Addition and deletion of multicast addresses are reported using
  RTM_NEWMULTICAST and RTM_DELMULTICAST messages with AF_INET and
  AF_INET6.
* Two new notification groups: RTNLGRP_IPV4_MCADDR and
  RTNLGRP_IPV6_MCADDR are introduced for receiving these events.

This change allows user space applications (e.g., ip monitor) to
efficiently track multicast group memberships by listening for netlink
events. Previously, applications relied on inefficient polling of
procfs, introducing delays. With netlink notifications, applications
receive realtime updates on multicast group membership changes,
enabling more precise metrics collection and system monitoring.

This change also empowers user space applications to manage multicast
filters and IGMP/MLD offload rules using the same netlink notification
mechanism. This allows applications to dynamically adjust rules and
configurations via generic netlink communication with the Wi-Fi driver,
offering greater flexibility and updatability compared to implementing
all logic within the driver itself. This is a key consideration for some
commercial devices.
```

Thanks,
Yuyang

On Thu, Nov 14, 2024 at 6:06=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Nov 13, 2024 at 01:26:29PM +0900, Yuyang Huang wrote:
> > >O.K. WiFi is not my area. But i'm more interested in uAPIs, and
> > > ensuring you are not adding APIs which promote kernel bypass.
>
> [Off list]
>
> >
> > WiFi chipset vendors must implement the Android WiFi HAL to install
> > and read the APF program from WiFi firmware. The Android System Server
> > will talk to vendor HAL service using the WiFi HAL. The datapath is:
> > Network Stack process -> Android System Server -> vendor HAL service
> > -> WiFi driver -> WiFi firmware. The Android WiFi HAL is specific to
> > Android. The vendor HAL service, WiFi driver and WiFi firmware are all
> > vendor proprietary software.  In other words, those API are not in
> > mainline yet.
>
> So that probably leads to a NACK for these patches. If APF is your
> target, and to me it seems unlikely APF will get accepted into
> mainline, there is no need for these netlink changes. Hence a NACK.
>
> > >Do the new netlink message make sense without APF? Can i write a user
> > >space IGMP snooping implementation and then call bridge mdb
> > >add/del/replace?
> >
> > The RTM_NEWMULTICAST and RTM_DELMULTICAST events introduced in this
> > patch enable user space implementation of IGMP/MLD offloading and
> > IPv4/IPv6 multicast filtering. I have limited knowledge on how to
> > implement IGMP snooping correctly so I don't know if they are
> > sufficient.
> >
> > These two events have broader applications beyond APF.
>
> And this is probably your way in. Forget about APF when talking to
> mainline. Show these patches are useful in general. Explain the use
> case of IGMP/MLD control in user space using existing APIs to control
> the network stack and hardware.
>
> > It might also make sense to consider whether to accept the proposed
> > APIs from an API completeness perspective. The current netlink API for
> > multicast addresses seems incomplete. While RTM_GETMULTICAST exists,
> > it only supports IPv6, not IPv4. This limitation forces tools like 'ip
> > maddr' to rely on parsing procfs instead of using netlink.
> > Additionally, 'ip monitor' cannot track multicast address additions or
> > removals. I feel it would make sense to have full netlink based
> > dumping and event notification support for both IPv4/IPv6 multicast
> > addresses as well.
>
> Yes, this is going in correct direction to get these patches
> merged. Focus on this. Solve these problems with ip monitor etc.  Once
> merged you can then use it with the out of mainline APF.
>
>         Andrew

