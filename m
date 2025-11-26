Return-Path: <netdev+bounces-241826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2187AC88DBE
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 10:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055BF3B0D67
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8FA24166C;
	Wed, 26 Nov 2025 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQSYhYWM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17926311C33
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148083; cv=none; b=mi4GSO4VtlOEcoA2j4wlwZYSue48XNAqZD9qefJdFFdr2+J5mXnN4mv28+n1DimzEZA7sa83ciEIkVeR1gXJrWsQxAM0Hl9uZ89Shqg2QqJjSPkHViBwZ2JHB3xJo/j6OrtbTkiep3FWTi0ozWyuQKumZ3qUGz/vtdB+ZTZW9eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148083; c=relaxed/simple;
	bh=HwiqTfc0ORQUbJNLeAsHqDBa+rkjLR6ljPCGa4YxK14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhwcG6yB7d03bU5ZuHHw6785QcZnWPK/gROCWzxai5D4MuPLiv0tWjfXiYLKpBnlb2ZE33+0CfbJxiAsrzwSEi77XFjqwBlYYDRyhrUZaW7JFE6/wId/BSGm1ER6igRl9wjXR5O8aA/jovC2bB69m6BtYNlc04kdMwSqW916Occ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQSYhYWM; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78a76afeff5so62647857b3.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 01:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764148081; x=1764752881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjAGTBpMxxBSQmxs5UnRo87q9r9evSqhYfSB+cRvCWs=;
        b=KQSYhYWMw8UNq2z2Rfg5WHuUWSn1ldpm71l8owOgzdz5Bt9W7BSokUJBoci1YKNVls
         LaSrGfCXjHlpPcfsnPTVuIrCrM2uw3nlalGy3UADwXBj8sf63DLIzLERRuoTP40twVj1
         gvJFtQ5/IdlHkkrQ3SKykDvw8H3nvSiTt5O3OH+krbFL7r3mBra/BGl675pAu7B4d7Mr
         PTUQMirHOa6e7I9ggzcvNAFh3tI1GCNXz/PfAULyqPbmHnBdAVJrevMm/TsD+xO5t0Sr
         xfkX80AYz6sCGVep+tSa3762n5g1rz0XsLYpZkY/eqImmgDLm1lsLad/Fq3vP+wcyI8P
         l72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764148081; x=1764752881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CjAGTBpMxxBSQmxs5UnRo87q9r9evSqhYfSB+cRvCWs=;
        b=MOs00IUGjQbzKG3pVK2b7pgvovNAFKdNROmLlpnSO4FXZilNm/Eut0cpw8BJcmxLSF
         2AJFRQwOFz/hRvTMTzPxYFNip9nO50L2SEzeZmYeF1HLbyMFMy7d35E8nN3P/qhDv+6f
         pnOXbY7tEjJzWV1ca8Sw23illtfmDlfcdj6I5bAZLBg09v7eYRB4HaVf3yVQ+qzD1uSu
         qT0jJV6KowVoMAjW1NlvnFaxUy4Py0J7xzvxJ+yv9k6rtu0gYYTP/Sj0dqnIvaNT5Wvb
         yylOK0zYYNHhXs9hFAxa2FvO7lf9FSPOQVc9pvEtTmdhgI2wUWdBGU98leBeMgwIOCCa
         miPA==
X-Forwarded-Encrypted: i=1; AJvYcCWg5mXC4hOJ2jcI1cUUs+7tdeShbiuH4u29QpiTNpyP2Kf8q4vTjzI7jXAboH5ayzHTpQSna0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCOUFJ+EtWHx13UVpfmmpxxk+XM4tejifx0hfsL1EtphMGashR
	PNW/vzf92TIjkzK8lpmXkDS4lBItcbg1ngYiGU7KkHL91iLTeM7eP1x1SM+ob5faaP5UnEOUpsV
	hv/6xl4cvvAqCKhtb3iG/vwx/tTQiljQ=
X-Gm-Gg: ASbGncsY7TF/tg4paqY0yfjU4kzVWz5KY9/2PuzFzgFRu5ieqhGQHszv0X6K1i0BT/1
	6+bUQchg94x6r2bwwJ+s4HSKCzwvUKBIjRsUZpDy0vnFMtPpfvE54FcZReVXIR8zeslB3biijk2
	VkWBy+YXI2u1NXGtLnFNr/E7creIQd3vGGjeb3qSy4TGRcnSzeyxpQtsTNzK1lce/QTtu0KBwk5
	jeVvFjh4IZAGlvpzNgGjJCDPi+LW9wEqcY9eET3CT63Ucb/4XGB195JVogVsfau3QYjrw==
X-Google-Smtp-Source: AGHT+IEDokaxQva4zlrRNnp1WFQDpvzDgUHXvz7vbLSmVkLCLdfIksfumSZ2iHOW9eVV0aL1wCWxxRBx6KIE1wevpl4=
X-Received: by 2002:a05:690c:7302:b0:786:5c90:922b with SMTP id
 00721157ae682-78ab6f1bc5amr54574677b3.35.1764148081059; Wed, 26 Nov 2025
 01:08:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125075150.13879-1-jonas.gorski@gmail.com>
 <20251125075150.13879-5-jonas.gorski@gmail.com> <20251125204215.2lz44qdegapgncn5@skbuf>
In-Reply-To: <20251125204215.2lz44qdegapgncn5@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 26 Nov 2025 10:07:50 +0100
X-Gm-Features: AWmQ_bll3UdEjOyoEFRk7CBCUQGw3JLq2bBLVPDuhdDwAVW8tw4Y62qQCx7hcDA
Message-ID: <CAOiHx=nZvCGf9f5_07pUS+nS3FOrn9e2-eoyAkOw_oTHO7Aujw@mail.gmail.com>
Subject: Re: [PATCH net-next 4/7] net: dsa: b53: fix CPU port unicast ARL
 entries for BCM5325/65
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 9:42=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Tue, Nov 25, 2025 at 08:51:47AM +0100, Jonas Gorski wrote:
> > On BCM5325 and BCM5365, unicast ARL entries use 8 as the value for the
> > CPU port, so we need to translate it to/from 5 as used for the CPU port
> > at most other places.
> > +     ent->port =3D (mac_vid >> ARLTBL_DATA_PORT_ID_S_25) &
> > +                  ARLTBL_DATA_PORT_ID_MASK_25;
> > +     if (!is_multicast_ether_addr(ent->mac) && ent->port =3D=3D B53_CP=
U_PORT)
> > +             ent->port =3D B53_CPU_PORT_25;
>
> Why not use is_unicast_ether_addr() to have a more clear correlation
> between the commit message and the code?

There is a very simple explanation for that: I didn't know it existed.
Will change it for v2.

Thanks for the review,
Jonas

