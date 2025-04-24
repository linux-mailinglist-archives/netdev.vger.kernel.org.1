Return-Path: <netdev+bounces-185470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35220A9A905
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE59D18885CB
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4133229B21;
	Thu, 24 Apr 2025 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCTQn0qi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7472288CB;
	Thu, 24 Apr 2025 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745488218; cv=none; b=RAvK/+d7o+J+nWqSYp+o02xFP4yDRvKGuzwu2Cv0FgcWk/8Aiv4zHsWGLbPY8Mhs1BlQeumKy/TRCaE6BpY2RsOWO7E6iRAGrBkw6z++tYmhiJ9JOahFh1t4MMkqkFnZh7ggz97e5/yjwRwDIlGVzrH6Yr9Z3IiIO9NNYUiBgvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745488218; c=relaxed/simple;
	bh=dN45aUMVgHBPtq+YH4TWkdlu7mWJvcThP9tdki6doMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKt1m474KcXP8W0d5XxdlY/bmGXZdhJfLk+uGGa7jJ1e1Nps6SejNvXOkCV9qud3hgRiPGAzrIpMzHJIPNZx+RBIhWrfD/6x6M5P0T/dlKNrLZ1S06Vb87qKiLMpR85eaFqnboziGr2QLiLcrOfqtVFxBONV47p2/mUgRg2ls7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCTQn0qi; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70811611315so8165627b3.1;
        Thu, 24 Apr 2025 02:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745488216; x=1746093016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dN45aUMVgHBPtq+YH4TWkdlu7mWJvcThP9tdki6doMY=;
        b=eCTQn0qiRD6mwwzpa+iNGK6Op8AA50DtcB36F6XXuYb80SI7U5UsXngVVJMZuWjWpg
         JjoNB3FIhnzQXZbRK850Eby16vKem+VVZo/euZTTHU7grAx4VZWEby6TZfq5k9mnsD48
         kfrWu2Z47sy3+4Dw156qKhqWr3isd7yp637xPhY8iDAPAoBlAX80HsrlTlxBGeiOM5rK
         wu/NkjMnDamW6WKuXuBzVMOHZWi6kmRXEYbTQ7UZxdqP8ung5NtKocstu2D89x49LZV6
         EqgkglkZlrpx0ipJHPsgCl5Lz8AmKeIw5jgNHnjJQLjFvWLnHhIXJf0XfAka42h5IwF6
         ibcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745488216; x=1746093016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dN45aUMVgHBPtq+YH4TWkdlu7mWJvcThP9tdki6doMY=;
        b=PnYUd4sWiDULEptJpDEfb0bye+CT3PPKXDKAcLO2YpNmRnrEXUPJgEfW0YllswwxQx
         MJok3R/3Md77lwnJdFYIhozntgd8WPZbeHVJFNJGZpvyw7tyYRkMho6pw7D6iX8O9KB1
         TwoVYbCm6503bSQ3IzBJLeovqymijVv/apDbkO8vK8J6O9wQQjQKm0UdMe57rL/7q+ZE
         lw0ob45kN3x5QeaHlGpM8IB7+X5EYu/B/HqoTG5RRzE9HbxW4PZvZXr/esefGddGwn6F
         fxDu3dAf0lDLblm+uiC18rmEVsyVAcKhW9KLP4F4ChGfisSFUHgtKf8B8bWlKX2m4dP2
         qOuA==
X-Forwarded-Encrypted: i=1; AJvYcCW3chZGVw/h08oAC948PfinREKyxz7NUHVNHuidziRDRsPuQDgCaocr6M7vNOrQkeyC3nF10WbbY05jUn0=@vger.kernel.org, AJvYcCXbAye4OMxiuCkRyAo1Y3Lv5wHDqqEoAe3+QkjD1vkok19MS6iT2PDL/jcY1kmidZUFzpcLsQUs@vger.kernel.org
X-Gm-Message-State: AOJu0YxHyD8OB0yAaFZgL9o6/J8jqJ4zWbM3wduz0j5m8yTRV52Ut1jd
	NsNs5R34mHqUTJL0AkafDea2U4qxS0Vbl+1f1Fea2wDlumXUnVMsMFxmDY4h1a6ebQO2KhEsjve
	ICX3NC3Fsm4kpAaa1PGtK+cVQ/oU=
X-Gm-Gg: ASbGnct9//hs3TDnpm8lGMoCAEjbX9qT+19RAVoMw+yTKxu7OMkYlxmAQo3Tq06FRsY
	jW5Z4QtEKYgXP+xn2hTDbJavevxBaDzU4GpsnC5+dh5eOAzMZR/5hlPeaMGk6ZvMzzvTjSkH5GW
	4MJ4b+5WHJjBhDPoRyOq/seSBCIYk/YNg=
X-Google-Smtp-Source: AGHT+IEPBoHxBQkLqgwJdK5VnALG9LwFIMjOSiDEnaPEdcz42TZZ2zCBMAs+R6fotsRDyYozw32iUW3Rn+b+3Y1wTTI=
X-Received: by 2002:a05:690c:7447:b0:708:39f0:e673 with SMTP id
 00721157ae682-7083ed270bfmr28187897b3.26.1745488216038; Thu, 24 Apr 2025
 02:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422184913.20155-1-jonas.gorski@gmail.com> <cf0d5622-9b35-4a33-8680-2501d61f3cdf@redhat.com>
In-Reply-To: <cf0d5622-9b35-4a33-8680-2501d61f3cdf@redhat.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Thu, 24 Apr 2025 11:50:05 +0200
X-Gm-Features: ATxdqUFd54daii3d4UaXpxRUJjHk49B8MSEUqlO5rgZOugl3Dy0MxnRClmOIGYs
Message-ID: <CAOiHx=mkuvuJOBFjmDRMAeSFByW=AZ=RTTOG6poEu53XGkWHbw@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: fix VLAN 0 filter imbalance when toggling filtering
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 24, 2025 at 11:15=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
>
>
> On 4/22/25 8:49 PM, Jonas Gorski wrote:
> > When a net device has NETIF_F_HW_VLAN_CTAG_FILTER set, the 8021q code
> > will add VLAN 0 when enabling the device, and remove it on disabling it
> > again.
> >
> > But since we are changing NETIF_F_HW_VLAN_CTAG_FILTER during runtime in
> > dsa_user_manage_vlan_filtering(), user ports that are already enabled
> > may end up with no VLAN 0 configured, or VLAN 0 left configured.
>
> Why this is a problem specifically for dsa and not a generic one? others
> devices allow flipping the NETIF_F_HW_VLAN_CTAG_FILTER feature at runtime=
.
>
> AFAICS dsa_user_manage_vlan_filtering() is currently missing a call to
> netdev_update_features(), why is that not sufficient nor necessary?

Good point, I missed that (looked for something like this, but
obviously didn't look hard enough). But checking the flow of it in the
kernel ...

netdev_update_features() for NETIF_F_HW_VLAN_CTAG_FILTER triggers a
NETDEV_CVLAN_FILTER_PUSH_INFO notification, which would then trigger
vlan_filter_push_vids(), which then calls vlan_add_rx_filter_info()
for all configured vlans.

This is more or less identical to what dsa does with its
vlan_for_each(user, dsa_user_restore_vlan, user); call.

And AFAICT it also has the same issue I am trying to fix here, that it
does not install a VLAN 0 filter for devices that are already up,
which it would have if the device had NETIF_F_HW_VLAN_CTAG_FILTER set
when was the device was enabled (and vice versa on on down/remove).

So I guess the course of action for a V2 is fixing this in the core
vlan code and make vlan_filter_push_vids() / vlan_filter_drop_vids()
take care of the VLAN 0 filter as well, and then make dsa use
netdev_update_features() to simplify the code as well.

Does that sound reasonable?

Best Regards,
Jonas

