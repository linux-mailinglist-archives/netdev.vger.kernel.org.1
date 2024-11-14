Return-Path: <netdev+bounces-144939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D57C99C8CBF
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B495286F0E
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C403BBC5;
	Thu, 14 Nov 2024 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cU2fPGeH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5997A7603A
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731594012; cv=none; b=hlTRo7ScEOZ+fdVP3Wbqh+JKYn+QDsJt76dGwlF4ZYSwajXqpR3WP0/et7FMlZF+8WZUjTLgMAiVqbLqvkd8SNNa5vqNhLPDJv1xQiLpxmCHGADjOmjr+0na2hACeeEfu4G628Ul5eGGJbUVxkqbUu2t3VZM3I4V2b5bhuvbVPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731594012; c=relaxed/simple;
	bh=KUI7cEMy24n5t6R9zkWnGm3n60uUoV5jg5b0EnpKUds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGgqbhU0S5vpHO76gex0GBJzE52INnVh07Nm/Xbv3GEu7EWjKmMctGRLbEIB7vSSWie4aRB/lE26zLrw6YJ9XQWi6i2nRUZ6zRHOwQMa/LxwEpGVKO1DEx20O4TtKbEDUL67G3iDaeKxACgjiBAyw0DmeoL2NAuPgdv9/Lq8O5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cU2fPGeH; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e044d4f7so4e87.0
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 06:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731594008; x=1732198808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4v/jG2aRUZnL5YZ465ulr/WON0zCfI7mJCLVKy7MkI=;
        b=cU2fPGeHRHOhnScVroeWPY4BVxXknlvQ/yhQQJAWCi6h/0sm5TBuG/hmOlsisYkgQ/
         jpNy8hFhkDiKdMNGbt9cNYypfn40PBdAJxo5tJjrN8nlNNlXIPBXL1CRsSeFiTGOBvF4
         rIsRJzYhx22okJ2ptjPGRycX+jJg0gRlvhkn8Y56zIp1Wn4XcGxE+YeFW5gLfRkL2fSM
         uuzelABTG5HYXlpvRTKp4RV7apt8WCJhTLEkz2ukUq5ctyYl/AzqCE2ENTmjvsFW7IYU
         ujMg1E3WUsBM0rI6ZafjiDmTQPHaf4gVvG5KVzwSGKUVcJ047wXlv+R0ilWLnlJX2C+N
         8Img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731594008; x=1732198808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4v/jG2aRUZnL5YZ465ulr/WON0zCfI7mJCLVKy7MkI=;
        b=hQIrGqU7XsCZ+g5cR4bW/JzhcsYnpPhabIrDrUMGghJigWsHb9zRBNeArTWhCxE79f
         2BqiARBBTHgro2G/nVJ+/e7rP7pmeoX9VJDPHPIZti9TNEY+HXCIpv/bn9B3k1T8AyKu
         HVyI3y8SZ1sOphctIsvYViDwtIEOf5cSyY7JOW+A3m08yy6E8sjAIMotfPpNRND7AO92
         l70vXb7/ehjSP1NGxy2/GUwqYfWKjY24WXPaiBsoTKeGrWO6nVomMy0DLkVrBNwM2qx6
         MSvJW2UhpA6A6AtzX3l4pO8db4N6AXgWR3QOI7uvm0fxo8Dl99Eaq2QOnU498Mv2kVmp
         FHUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpF+vcWqJsdzuUnTrbcNrPNemd69gQUMoimmEwwnd7oW7yhJQ5xWR3LWhrMMMW2RceJ8v2TMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YybuKpDmTOz6a9zAi3MacoHGgSkD1lK1fAkvY+w0k79bYJ1G/F9
	G92YFNxdaWttrQ9S+PaHJ6Zy53oifryyGY1DmPuKiftB+861lm0bOTyaLiTzHnLVTj1tDPvCW+P
	X5uE0/EHQ7keLk6I8SDsGCGGPNDKabrzrjOxu
X-Gm-Gg: ASbGncvaGbCiR9lZ8R1b7w3OKtHZjKiQidKhvJ7QNP/kNmXIQXgnRDEiH2Ur2ZqAIcd
	GATCEiQE9LhVCYshjPEeOMS4tSfgRM824rDHkYrc0Jf+2cAaKBEbPDOg5AZayTVA=
X-Google-Smtp-Source: AGHT+IFLCAmwa3E6unLd67bDmoGhuoM0jI7u4P5imEH/bfK+rOIGIQ6R2iu1oEteuUXXbejuWDIdiiIMP0qJwbqsRXc=
X-Received: by 2002:ac2:538b:0:b0:53d:a866:ff6e with SMTP id
 2adb3069b0e04-53da9e99e8emr626e87.2.1731594007559; Thu, 14 Nov 2024 06:20:07
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
 <9fa93b71-cd81-44ce-b7cc-24b12be8cb24@lunn.ch> <CADXeF1HQH=bhNWAtafUKD3-WoHhQEB-=TpwN9GdOOZ9PSaLktQ@mail.gmail.com>
 <dd54d1ac-cc53-43cb-a42e-d255ac688e6f@lunn.ch>
In-Reply-To: <dd54d1ac-cc53-43cb-a42e-d255ac688e6f@lunn.ch>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Thu, 14 Nov 2024 23:19:29 +0900
Message-ID: <CADXeF1F7nR02ZDKBEa=SXDbfgP9ZGumuzZkf3WSeomhrsntfDw@mail.gmail.com>
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

>You are still focused or your narrow use case. Why is this only for
>WiFi? Why cannot i use it for other systems using IGMP? Switches? VPN
>servers? etc. We want a generic solution for all use cases, not just
>some obscure niche.

>And Linux does not care about commercial devices. And you would never
>implement this in the driver itself, that would immediately gets
>NACKed because it is not generic, but the concept should be generic.

Thanks for the further feedback! I've revised the commit message to
discuss more generic use cases without mentioning specific drivers or
devices. I also removed the discussion about commercial devices.
Please take another look and let me know if it needs further
adjustments.


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

This change also unlocks the potential for implementing a wide range
of sophisticated multicast related features in user space by allowing
applications to combine kernel provided multicast address information
with user space data and communicate decisions back to the kernel for
more fine grained control. This mechanism can be used for various
purposes, including multicast filtering, IGMP/MLD offload, and
IGMP/MLD snooping.
```

Thanks,
Yuyang

On Thu, Nov 14, 2024 at 10:26=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> > This change also empowers user space applications to manage multicast
> > filters and IGMP/MLD offload rules using the same netlink notification
> > mechanism. This allows applications to dynamically adjust rules and
> > configurations via generic netlink communication with the Wi-Fi driver,
> > offering greater flexibility and updatability compared to implementing
> > all logic within the driver itself. This is a key consideration for som=
e
> > commercial devices.
>
> You are still focused or your narrow use case. Why is this only for
> WiFi? Why cannot i use it for other systems using IGMP? Switches? VPN
> servers? etc. We want a generic solution for all use cases, not just
> some obscure niche.
>
> And Linux does not care about commercial devices. And you would never
> implement this in the driver itself, that would immediately gets
> NACKed because it is not generic, but the concept should be generic.
>
>         Andrew

