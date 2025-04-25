Return-Path: <netdev+bounces-185884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EC7A9BFC5
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDA91B67EA6
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 07:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6228A22CBF4;
	Fri, 25 Apr 2025 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkTD64xk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F191DDE9;
	Fri, 25 Apr 2025 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566231; cv=none; b=f4h2aAEVGJJjrt1oL/5exBpHOlbDy7WkP68zSBPVJpXTImTg/OSNAXxfp2QfslazIzND8AnYmmgyKlxTfW4HcpfKv1boOqzihfMI72Uw49oLVvHo/A4AIDlQoxjXBz1IByekC4pdFkaK01LQnS/bstFfCadFEYp4Crm5CFWVrmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566231; c=relaxed/simple;
	bh=OWvy44TnOoF2Xr9rCIjsqTfY38fVghdoAqz+8yWzeiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDKCxny42WlQ7dxnVveuFQKC+tDYEprcDvbiE+2+O4LVbAbXxzwMxCSl6+upXjYQ7xgW04IUiOdQnAFWnljn5GA7e6kSwZ06BwhPg0LinCoudRthAYqB0ZJq46I1JtY4l8njm93vTAum69/DQ5B/O9vE6PUuE1EtyzYn5rMMDzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkTD64xk; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e6deb3eb7dbso1614016276.0;
        Fri, 25 Apr 2025 00:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745566228; x=1746171028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWvy44TnOoF2Xr9rCIjsqTfY38fVghdoAqz+8yWzeiE=;
        b=lkTD64xkfmuPvga8IW34AGtw3lZn18u5ZnI+uo6zv/I4IOGRIf93z9JapXKcIgSquz
         NrnMZCucTowXNzOj3/DWETgXrkiOfRXuHUk7Sfb4MzSKqDmDbCZznFhWMC/41mk4PMWo
         mfJAJuD7tJg7w9sMnC/jEaPPVYvglAa5QlQng5dFJsdpQxYTu8SySjdC8+F3CTvbK0yu
         +QCCsRTWFuN26pRpM5kOseQKClHdfn9NgjywO7/YfVM+rwbcLD1aT/2W3cClbTD8WyMm
         8UtDr0AnD1FEjUyk87grl/dUVkcFDcGx6t1NuVpEfAWTjKaR+TvtWM9bBtXi4xMCSKgG
         Zt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745566228; x=1746171028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWvy44TnOoF2Xr9rCIjsqTfY38fVghdoAqz+8yWzeiE=;
        b=rOzNv5ciRJ0IqzywrisJHZUnCdGUzX9vRiJbyp3xsLfbug1Vd0dZzPiYHlpLiAnhl0
         tNYQJnpL8MQ0+k3Qyt9gDENoSie21FdUMU++qOj2fHF3nroCpsULe+wHxrhsm2BiErWT
         4bX7KhuEDmxT4A7vsGb1YnVGjvO+UkS+Ebwh79ymvVFR2RXWlxLSk2Py4NOrAkz9q9o6
         hdrfQxewEmMEVysu3p7Pzo1+7RRKyVJSawaSlIQCfZJfVkkYJTlDA38x3ia4FSANOOGb
         21VboyirtZGN4GFI5ts6VbcHvtgMdiAwYDknoeHOsLdi31A2pi0we2mjHS0+MZV2KI2J
         SOUw==
X-Forwarded-Encrypted: i=1; AJvYcCWFe0YRWO9+bGV6E4x+bV+4W6F7FPj9qYgf2evah6pX5nQghAhU9WsWtFu//l77OwgwBfd1IwmLsatjdt4=@vger.kernel.org, AJvYcCWrveSikYhsPauxXVC5beLK1gGao7iyu3SoGmLcZSSaHEpcRpstyPAuO8nnJEJFsY2SJ2N6it7E@vger.kernel.org
X-Gm-Message-State: AOJu0YxYCcO63snB+BqoLQvCrHZ8y6h0k1i3raXzRKQz/yk+F6vMAkR6
	KamAZu4CzakwpZRaCgyBZToEJjXka1AR/nnQnDp1t/BaSeBDrA2zyuuHdKKJ/1DMYlLPxU5d49s
	X+3qCW8XnVUF1G/HRnSxyUOIfL5Q=
X-Gm-Gg: ASbGncvPqkS5q0W+cu5FmJVen1RbaqNkOM4u5xygn7OLzZfVXaW1kzR1F7Vss0P9g8M
	JAso8z4xa65bUAcGu6Li6V4qMs8oii0SFf1m0dH5V/5SY9+e7HNNE5LF3l55hxOPw7epTDSiUfi
	VwnxJf6TwRpLmzP7iPQJa98/0EB8g7Lg==
X-Google-Smtp-Source: AGHT+IEWV18KS8MumgZb8OB0QJeoK1Zd+UkrJ95ng4qoBG03B/slgD3wqgI2ekZkNmF7B69VFTKtCzF6mDRYhdO/BTo=
X-Received: by 2002:a05:6902:2387:b0:e73:930:cc31 with SMTP id
 3f1490d57ef6-e73165c3e38mr1843193276.13.1745566228645; Fri, 25 Apr 2025
 00:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422184913.20155-1-jonas.gorski@gmail.com>
 <cf0d5622-9b35-4a33-8680-2501d61f3cdf@redhat.com> <CAOiHx=mkuvuJOBFjmDRMAeSFByW=AZ=RTTOG6poEu53XGkWHbw@mail.gmail.com>
In-Reply-To: <CAOiHx=mkuvuJOBFjmDRMAeSFByW=AZ=RTTOG6poEu53XGkWHbw@mail.gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Fri, 25 Apr 2025 09:30:17 +0200
X-Gm-Features: ATxdqUHGRxEKMxxN2LzsQ4XQH9Vmxm-WedPheRLmBBKrtF9mIxhxgkLohyWfgjw
Message-ID: <CAOiHx=m6Dqo4r9eaSSHDy5Zo8RxBY4DpE-qNeZXTjQRDAZMmaA@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: fix VLAN 0 filter imbalance when toggling filtering
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 11:50=E2=80=AFAM Jonas Gorski <jonas.gorski@gmail.c=
om> wrote:
>
> Hi,
>
> On Thu, Apr 24, 2025 at 11:15=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >
> >
> >
> > On 4/22/25 8:49 PM, Jonas Gorski wrote:
> > > When a net device has NETIF_F_HW_VLAN_CTAG_FILTER set, the 8021q code
> > > will add VLAN 0 when enabling the device, and remove it on disabling =
it
> > > again.
> > >
> > > But since we are changing NETIF_F_HW_VLAN_CTAG_FILTER during runtime =
in
> > > dsa_user_manage_vlan_filtering(), user ports that are already enabled
> > > may end up with no VLAN 0 configured, or VLAN 0 left configured.
> >
> > Why this is a problem specifically for dsa and not a generic one? other=
s
> > devices allow flipping the NETIF_F_HW_VLAN_CTAG_FILTER feature at runti=
me.
> >
> > AFAICS dsa_user_manage_vlan_filtering() is currently missing a call to
> > netdev_update_features(), why is that not sufficient nor necessary?
>
> Good point, I missed that (looked for something like this, but
> obviously didn't look hard enough). But checking the flow of it in the
> kernel ...
>
> netdev_update_features() for NETIF_F_HW_VLAN_CTAG_FILTER triggers a
> NETDEV_CVLAN_FILTER_PUSH_INFO notification, which would then trigger
> vlan_filter_push_vids(), which then calls vlan_add_rx_filter_info()
> for all configured vlans.
>
> This is more or less identical to what dsa does with its
> vlan_for_each(user, dsa_user_restore_vlan, user); call.
>
> And AFAICT it also has the same issue I am trying to fix here, that it
> does not install a VLAN 0 filter for devices that are already up,
> which it would have if the device had NETIF_F_HW_VLAN_CTAG_FILTER set
> when was the device was enabled (and vice versa on on down/remove).
>
> So I guess the course of action for a V2 is fixing this in the core
> vlan code and make vlan_filter_push_vids() / vlan_filter_drop_vids()
> take care of the VLAN 0 filter as well, and then make dsa use
> netdev_update_features() to simplify the code as well.
>
> Does that sound reasonable?

After looking into it a bit more, netdev_update_features() does not
relay any success or failure, so there is no way for DSA to know if it
succeded or not. And there are places where we temporarily want to
undo all configured vlans, which makes it hard to do via
netdev_update_features().

Not sure anymore if this is a good way forward, especially if it is
just meant to fix a corner case. @Vladimir, what do you think?

I'd probably rather go forward with the current fix (+ apply it as
well for the vlan core code), and do the conversion to
netdev_update_features() at later time, since I see potential for
unexpected breakage.

Best regards,
Jonas

