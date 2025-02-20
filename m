Return-Path: <netdev+bounces-167987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FB8A3D01A
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 04:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F923B9252
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 03:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55332339A8;
	Thu, 20 Feb 2025 03:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzUrdJgD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825494C6C
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 03:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740022415; cv=none; b=ukD5HOlIu0NIalkoB1GREZNRroJl9K49AaCajCw2KlaF9lgAJQTC3yAkQ6nhg1OJ69isb60cZZEyqhf6RC+TbXl9uoXeSMtZJnXGGdVmbKU30T3i/6u9nmXtr+6PHy3dpI+6JWcN/OLA/wWU+tuTqU1j8OVHnJysLzOfoO4g/dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740022415; c=relaxed/simple;
	bh=TiDbb8Sj7p8vcGA7oO9KN99if2/ItQHR1nkuSDKwYEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhFPkR86lhaw8V4VbwzyV7sQYceYZKlxRi5JDhvXARauWtTnknQ/X9YpnHm50vB5F9UEMEX2smEKs4Z7WT8PM1rwwCEj3leAHeS8777IliefBCGFcU9pDEWeHYfAlKuzBHB3DPYuvPKr+EKMXjoTzWXxMSl5jzOesZZVqfB99cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzUrdJgD; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ded51d31f1so743257a12.3
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 19:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740022412; x=1740627212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZTm/h6PefFkC+fcSpUpqxMLVMI5XYCfvcIfVwcl1qQ=;
        b=HzUrdJgDh881VjtSWPILyVST2gQp5EPSCGEUHis+MoNfxypv1RRgTKqSlpUTdelq2l
         HihEmIAhHu5LMr7X8XzdGOi656u+cfNY1OGqfPVfI86TBvXcEkD00h05/ZSkH8tl68V+
         P/O9+hVVNYGGIx9T6z5rYZdPXPM6Y63gR0FAKu+Up4WIY5ovq2WvY2jj9TRlp/oJ/fRg
         iLrj36f2WE4wLaqkvyIGTZqDzuSEhn2gBuBx0oetaRcnfuPVaz3+MVugVfsCxzNdRL/J
         T4uEd1RlywJvpQ2wfBmRw3ioNsHXNGK4NQMmyoLVBeqn/jpsb0ar6ldalmK608dB8NeM
         58Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740022412; x=1740627212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZTm/h6PefFkC+fcSpUpqxMLVMI5XYCfvcIfVwcl1qQ=;
        b=KxopbOs3rE+7/l9R+xSG3VhyfM/YtKtIx6NsiqyJ0oOk9D33/+bcP9GtKF9rFwha8G
         q5Pyl9IXKCsyV47xuBX+duOLyjOo/Klobw/o3RzGKGI9ZpSFdsO+I9S2PeP9+8A3zuEB
         ZAxuYelXG9BPkRbkWf5RZM4gkx6r2sWfKrku9DCDiz56Gs+uJhwkEnoBaInTgEdF72rE
         DbUQzORzJ5t/HR3sQ5Q+vW5YCWMnik4nzvbMU2FroyyhVtwOcypsVZoO48hYujYaJ7dH
         Eib1pN8a4O87f6LfRp7xXlDoAPqpgLHHUns/I0UdR+1mvAkich6SsUyEruCe/GHxzi/R
         e9BA==
X-Forwarded-Encrypted: i=1; AJvYcCUY21Vp0wfKoUez5JPaqj+vlojw24IVOm4rOxU/N9zE6vSm8/Qxk53XCqy5ngpOVso8UZXcIZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa4Zv/FrWR1D080EyjI23bdrzn1Ixay2+DKwoGKlBOr0fO1lbB
	jP+JhzSCPHEGdWzSZjf7RQgFy3Akp4NOUsYC4ewngz3HPZM4avFvAE64rhcjlaqOdQPAg33DCA8
	KITTM0Ng/tCYjXTP2lPhRmlidzx8cm6PkbbE=
X-Gm-Gg: ASbGnctP323YIeY71sx2NFgjj7/K/Zd+TzgY+EemyKdijt6VhIUU+q+a0FXxrixjPix
	U+Ktzug1BnnCQhgXr5C42JFepstM9CefnoWV9THVBmUrcIP+I4evDM0jVKYVE9ftqbgD8dU/6iS
	s=
X-Google-Smtp-Source: AGHT+IEKhLe4ZsRP9YazygOnm0EaoCD5g+2qqVt8D0hSYYAYFiMlRanF7+mAHAdcQg7GNdU2MajMKjMUq26wM2ABSnA=
X-Received: by 2002:a05:6402:40c7:b0:5db:f423:19c5 with SMTP id
 4fb4d7f45d1cf-5e0894f7cbcmr6111114a12.5.1740022411506; Wed, 19 Feb 2025
 19:33:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220005318.560733-1-kuba@kernel.org> <w3kr4zyocloibq6mniumhtcbp6hqfur6uzqeem6hpoe76t2gqr@4jmz72w3wrw3>
 <20250219181427.3d7aa28f@kernel.org>
In-Reply-To: <20250219181427.3d7aa28f@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 20 Feb 2025 12:33:20 +0900
X-Gm-Features: AWEUYZmjw3TwmrKiHFA1gnGiPQAr3vkEpwQ4R6LuMctYUM_eICQuVnbw63SZNGw
Message-ID: <CAMArcTXzGXBBjkhefM3iFiwYWxtsQ70QTRtVLSv_+hAERtaQKA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] bnxt: don't reject XDP installation when HDS
 isn't forced on
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Xu <dxu@dxuuu.xyz>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 11:14=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:

Hi Jakub, Thank you so much for this fix!

>
> On Wed, 19 Feb 2025 18:58:02 -0700 Daniel Xu wrote:
> > > @@ -395,7 +397,7 @@ static int bnxt_xdp_set(struct bnxt *bp, struct b=
pf_prog *prog)
> > >                         bp->dev->mtu, BNXT_MAX_PAGE_MODE_MTU);
> > >             return -EOPNOTSUPP;
> > >     }
> > > -   if (prog && bp->flags & BNXT_FLAG_HDS) {
> > > +   if (prog && dev->cfg->hds_config =3D=3D ETHTOOL_TCP_DATA_SPLIT_EN=
ABLED) {
> > >             netdev_warn(dev, "XDP is disallowed when HDS is enabled.\=
n");
> > >             return -EOPNOTSUPP;
> > >     }
> > > --
> > > 2.48.1
> > >
> >
> > Nice, that fixed it.
> >
> > Tested-by: Daniel Xu <dxu@dxuuu.xyz>
>
> I looked again after sending because it wasn't sitting 100% well with
> me. As the commit message says this will work, because it forces all
> flags to off. But the driver is also only setting its internal flag
> when user requested. So why does it get set in the first place..
>
> I think the real fix may be:
>
> @@ -2071,6 +2072,8 @@ static int ethtool_set_ringparam(struct net_device =
*dev, void __user *useraddr)
>
>         dev->ethtool_ops->get_ringparam(dev, &max, &kernel_ringparam, NUL=
L);
>
> +       kernel_ringparam.tcp_data_split =3D dev->cfg->hds_config;
> +
>         /* ensure new ring parameters are within the maximums */
>         if (ringparam.rx_pending > max.rx_max_pending ||
>             ringparam.rx_mini_pending > max.rx_mini_max_pending ||
>
> This is the legacy / ioctl path. We don't hit it in testing, but you
> probably hit it via systemd.
>
> At least that's my current theory, waiting for the test kernel
> to deploy.  Sorry for the flip flop..

As you mentioned, I tested it with legacy/ioctl path.

How to reproduce:
ethtool -K eth0 lro on gro on
ethtool --disable-netlink -G eth0 rx 512
ip link set eth0 xdp obj xdp.o

With this change, I can't see this bug anymore.

Thanks a lot!
Taehee Yoo

