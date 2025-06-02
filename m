Return-Path: <netdev+bounces-194662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB91ACBC24
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 22:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6885817181A
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 20:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6020617B402;
	Mon,  2 Jun 2025 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ma+JWcly"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6382C3253;
	Mon,  2 Jun 2025 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748894908; cv=none; b=KdR/G5qIY7Rr5vDF8F1v26DGnx5RoL67opP7GBFxrDjbmbFT4j1KyYKNz+e0sMemxiM6zmb9qCPz34iLmdxzGL+9gtEIE0HUGMo4dHiVwk4DEF4UDnqT5WNn8FpsEcfyi6OVlU53jTeEMLVg3jnMFRgKEbuRtwTz7v+Wor50GiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748894908; c=relaxed/simple;
	bh=PIPXBBZg7C2yvQ3j8IiIoplr8n25rRMwqIvEeOI8Zyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSbX974ywB0gSy5o39XHSCCcYZMauPXEfJHJT4tG7mID4pbM0k+cf7vRnx7EV5NDN6u1kPului890+8kNnTKg8JtWJVNBPHCKkii/q+7tNHJPyAceYRAbmhP+4wampruWpItJToTxv6uipsLEON2zVCK/ohLW6aUnvzGjoA0hFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ma+JWcly; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70dd2d35449so37956057b3.3;
        Mon, 02 Jun 2025 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748894905; x=1749499705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cprm1S+tUstmLA7CDXo1VIR+8RYNYAjuJZ/dc4j69j8=;
        b=Ma+JWclyG08cdLwyGDj6hl6T+se2E2aZMXEOCKUU7dNgGUzl8dwaQz6y/T1r9NjlBm
         Z9fLWO0k+kYSoqHfZxbOmXwUQ1LpDrRR8s8syuz7UmYuwP65YxjB0Kx4EppZF8jmosMy
         Nzsb/yXQEKowUXJ+0dCRYx6An3EEnXTJt5C0D5xkQpUXwb5xPQLmmz+dYvPLqZHd9KRx
         n8X4ANTmBTFByOWmGNh37lGgtaiaOpVkrGd52KnOwMih/4af7N5yhu88s7iH6Dp3IsAG
         XlonIkdfi7m8Oy5DcbI3xMKvP8mhBc3xnldCgOx6Exi+PWZDLpQx9+ErLoqcfKrHJdl0
         diCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748894905; x=1749499705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cprm1S+tUstmLA7CDXo1VIR+8RYNYAjuJZ/dc4j69j8=;
        b=rkipu5mZNcGfReGkRveZjY8fs68aq9d6Mu3ZCKC2awGlePAjZlXjCH4nBsRJOuphpc
         aMoxungisgbFFD4d2JXfo9TONTnUfUffZhpfE0ktffUaSd3ztH7PwkFUQL79VK/TZBYp
         tLScS8SgtAgpKjF7dVS8F3XT+ziIax1S55r0kAuFA2mVBBtHwSbHJLDsqLbY1fYZe/Fl
         771QsgOS5VTcwt06zYZBkhXBnQW+AEnhxKM4Ky2uicxb5v0ABddbEA4VUjnmRHcMJ3fm
         4espV/82+rC8C4LciS8XjIlwV6PcnB0C5QSWTB00+MYi0eQI317rhvGETMih+JefCRNd
         TA3g==
X-Forwarded-Encrypted: i=1; AJvYcCUtEBA4cgu79EhURsG1fwb6rTYye3WgZqP8jTnPCLyF28yL2eY4+2Fe6/O6h6d0w34mNBlcxwlV@vger.kernel.org, AJvYcCVNpvpsTQZr+AS94C3ysurAe4B7HJ8JTv2KZGIt9QqMHJE//T+vlw/V+cYj8wr4sEhAJ9Ro7JdQaZvf2KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXfTYs0eSVNS56vNAPTIgExW0nICcE2m4r40YQ2XdxeNZCs+ZS
	hOcxW9+m9bPVKbYPl4dVr+0CFe82UCkcg5guJeygrFsghgeh1HnXlJyTjuCtvudePoQRGjSqsVm
	K7ssehwf/7Q6VQAcufCScUaaKo2jkOeU3Tj30
X-Gm-Gg: ASbGncuRUKFPdGmRk9ADcymQNvEEMwK2HjMEftDd1/QsBeyghkd9+Di9yRxuPvQLkK1
	Acv1j1QuJnQgDIVhGnnT16fC1Zw1VRwW3m2VjXSU3Dv63QWlCTpmUPN9eOdg+Gs2XqOlaw2raKa
	93aVIQ6B2eFPDCSFb9VNyZnLR5O9L7aTw=
X-Google-Smtp-Source: AGHT+IGIfc/pYTINL/txMCM0UIRxqjrhrD/US0i9WnhRYDeio3LeA1O34pfBxJ0yxGNaeMkzKqhWpZ1hoxXmnUVZ4pQ=
X-Received: by 2002:a05:690c:7082:b0:70f:6ebb:b29a with SMTP id
 00721157ae682-71057d1f0f1mr173561767b3.29.1748894905699; Mon, 02 Jun 2025
 13:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531101308.155757-1-noltari@gmail.com> <20250531101308.155757-9-noltari@gmail.com>
 <a8332eba-70c3-482a-a644-c86c13792f8b@broadcom.com>
In-Reply-To: <a8332eba-70c3-482a-a644-c86c13792f8b@broadcom.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 2 Jun 2025 22:08:14 +0200
X-Gm-Features: AX0GCFviWleKw2g6aZqmuOU2dKeAi2btt5oaGRYh2N5pR0_3zrXJkv2uPErW3nQ
Message-ID: <CAOiHx=nmuZe+aeZQrRSB6re1K0G9DzL-+w+dAs5Bkdze72Rf0w@mail.gmail.com>
Subject: Re: [RFC PATCH 08/10] net: dsa: b53: fix unicast/multicast flooding
 on BCM5325
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, vivien.didelot@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 8:09=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 5/31/25 03:13, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> > BCM5325 doesn't implement UC_FLOOD_MASK, MC_FLOOD_MASK and IPMC_FLOOD_M=
ASK
> > registers.
> > This has to be handled differently with other pages and registers.
> >
> > Fixes: a8b659e7ff75 ("net: dsa: act as passthrough for bridge port flag=
s")
> > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> > ---
>
> [snip]
>
> > +/*********************************************************************=
****
> > + * IEEE 802.1X Registers
> > + *********************************************************************=
****/
> > +
> > +/* Multicast DLF Drop Control register (16 bit) */
> > +#define B53_IEEE_MCAST_DLF           0x94
> > +#define B53_IEEE_MCAST_DROP_EN               BIT(11)
> > +
> > +/* Unicast DLF Drop Control register (16 bit) */
> > +#define B53_IEEE_UCAST_DLF           0x96
> > +#define B53_IEEE_UCAST_DROP_EN               BIT(11)
>
> Are you positive the 5325 implements all of those registers? They are
> not documented in my databook.

They are in 5325E-DS14-R pages 112 - 112 (134/135)

That being said, I don't thing we need to touch the MC/BC/DLF rate
control registers when enabling/disabling flooding - these only limit
how much traffic may be UC / MC  on a port, but apart from that they
do not limit flooding. We don't limit this on other switch models
either.

Regards,
Jonas

