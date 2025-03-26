Return-Path: <netdev+bounces-177865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA525A726A0
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 23:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05AFC171318
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 22:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AD01C84D3;
	Wed, 26 Mar 2025 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNoHmogY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3127C1BC9F4
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 22:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743029362; cv=none; b=hSjV4cp0EFYtLepPim0nDUhlD8hZwKcG3oqsc1smRbmcf+ooNtkJ2UJxRyx4jzory/8YGXmHMMsYxvcYiPimGC/M3CKZEVuDYPCJXuN4ZvfgM5kf0/oEEAAqwY/Nq5ub2TDDshtpq/AQzZUB/gUB/5HGRV59BBoJeszuK5wuFPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743029362; c=relaxed/simple;
	bh=pb62k3uPmcrFUbNnneW6CR+k/UDgFy/e/C8H10DakC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=un16IYlKMW+XcBIlUSdFXbK9rbOjwvbe1NgbkgpkmBnsBuXAkzacMvrxfktsJ6NUGgDYMAQl6j3ls2oc3EKPy5NsdQdkG0UU2LWDsi72BZvJAyXqmwbcOyrFw/88GdhvJ5NOK0P2ZrabiGXjAtuXau2xOm0OGJH+I66VNB2aomg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bNoHmogY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743029360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qi8wdhM7rmWkvLOlU6keCbGUfSvgCk1Wxsh4f3EOl8Y=;
	b=bNoHmogYplhApZ/9n8oJkLbjYvcIpojfxzPvabIJ+rVljnbdVL3VomktII5dPLyxFbuduv
	V/YiDN08ecuYuEoe4hFGrCg8T2q03L3PGVqO/foBMPYKNvACk0nG+32qnd5ZCsxFe41IRZ
	yDOBVcfWTnIoJbP+BHsHAC2GD3Z9zPs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-4fVRtGZNPYynIgwJTZ4AhQ-1; Wed, 26 Mar 2025 18:49:15 -0400
X-MC-Unique: 4fVRtGZNPYynIgwJTZ4AhQ-1
X-Mimecast-MFC-AGG-ID: 4fVRtGZNPYynIgwJTZ4AhQ_1743029354
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30db1d3b643so1880931fa.1
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 15:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743029354; x=1743634154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qi8wdhM7rmWkvLOlU6keCbGUfSvgCk1Wxsh4f3EOl8Y=;
        b=IRDmR6T5iF8ISvXu2HAchh0/rNYFEhnVcat0I8iBFb+zyYDHyhMm2A+x1Lg2O3KP0U
         wCgcHMvdPif8AzvUN9MWzNnuiJMFGBeIKb9zjjI6z80ctE7qUB9FygNT2OH2Z6OmPZhh
         GY2o5E6CsIUaVrQlwdhdkd98spihBlbsBZQpqDbLpP4rg12X/7t1gV8fT3yzcjAkettx
         2dXfGezOC92diAhUQUtB3+rqOHd/BaAO4MT0I83srMs/U5U1wcdwcIQzPSqW5X+Vd5tj
         GkaVzCV/bBFFcgGwJCiapkA/WNobRuDcAVHiudpZq2DuYKt0ActkhRcrCIGfzskb8vVX
         UEPg==
X-Forwarded-Encrypted: i=1; AJvYcCWwj5MfJSE4piw2QtEu7hJ/39EytdJq0rZCQ1YrSZdLjOEPXZ4FtpoOc7TbPDOulB15wZVN96Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXMizxr5sJ/wyWXGlhGPn7OyR1bzPF+hfclpI5UGN97zu4M2uL
	cAV1jz4uAaWbmsmJ6/ftYAxZJ6PGvEAvf/43JQJhRczQ3EWWb+WM46BRKe427odsdNia4WOn1Wn
	H6fhqsVlgxRSt3GWSuYA5GEUoxlOdWjSd+ng4Z1/+5gWLKN09ANCDsXD6wBZ1xQIFfedWF+zUjR
	OJdOcQxY1FFUGPnC3JAwL+pGkVvttZ
X-Gm-Gg: ASbGnctJwIUfKMRBRxtc9QEr7dmysyWcwE1ydrithvHM1w76KgeV5xcbHj0cwK1j43Z
	yeOm5QcT0IOmoWRwbeY4XwC+c6M4IUC7ablKIFvcbfGM/XacotQpasgqHJcMGqnvyMZEXw5hKqM
	fvHTg/dp5Yhi2sUjvNuPv3AWjswng0Fw==
X-Received: by 2002:a05:651c:2050:b0:30b:bdb0:f09d with SMTP id 38308e7fff4ca-30dc5f515bbmr5510301fa.32.1743029354110;
        Wed, 26 Mar 2025 15:49:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8cMCyuMwWy76IQjJTWRHtr9mD0i57Aua495nDnRXXsLw6FXvJjoQX0xrXHm47p5VgTZevUnfzjDqhw/Un7Cc=
X-Received: by 2002:a05:651c:2050:b0:30b:bdb0:f09d with SMTP id
 38308e7fff4ca-30dc5f515bbmr5510251fa.32.1743029353699; Wed, 26 Mar 2025
 15:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326180909.10406-1-ramonreisfontes@gmail.com>
In-Reply-To: <20250326180909.10406-1-ramonreisfontes@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 26 Mar 2025 18:49:02 -0400
X-Gm-Features: AQ5f1JpGqx_OPjvXDypDk2rq6InmEg7NNHY5U7uN3dc0VBCMkBBj7u5F0xqSZks
Message-ID: <CAK-6q+hkHByFK2hWkrbZqFT5=h9U9nXuZJNF+_LhqmqeEC+Sng@mail.gmail.com>
Subject: Re: [PATCH] mac802154_hwsim: define perm_extended_addr initialization
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 26, 2025 at 2:09=E2=80=AFPM Ramon Fontes <ramonreisfontes@gmail=
.com> wrote:
>
> This establishes an initialization method for perm_extended_addr, alignin=
g it with the approach used in mac80211_hwsim.
>

that is based on the phy index value instead of a random generated one?

> Signed-off-by: Ramon Fontes <ramonreisfontes@gmail.com>
> ---
>  drivers/net/ieee802154/mac802154_hwsim.c | 18 +++++++++++++++++-
>  drivers/net/ieee802154/mac802154_hwsim.h |  2 ++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee8=
02154/mac802154_hwsim.c
> index 1cab20b5a..400cdac1f 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -41,6 +41,17 @@ enum hwsim_multicast_groups {
>         HWSIM_MCGRP_CONFIG,
>  };
>
> +__le64 addr_to_le64(u8 *addr) {
> +    return cpu_to_le64(((u64)addr[0] << 56) |
> +                        ((u64)addr[1] << 48) |
> +                        ((u64)addr[2] << 40) |
> +                        ((u64)addr[3] << 32) |
> +                        ((u64)addr[4] << 24) |
> +                        ((u64)addr[5] << 16) |
> +                        ((u64)addr[6] << 8)  |
> +                        ((u64)addr[7]));
> +}
> +
>  static const struct genl_multicast_group hwsim_mcgrps[] =3D {
>         [HWSIM_MCGRP_CONFIG] =3D { .name =3D "config", },
>  };
> @@ -896,6 +907,7 @@ static int hwsim_subscribe_all_others(struct hwsim_ph=
y *phy)
>  static int hwsim_add_one(struct genl_info *info, struct device *dev,
>                          bool init)
>  {
> +       u8 addr[8];

why not using directly __le64?

>         struct ieee802154_hw *hw;
>         struct hwsim_phy *phy;
>         struct hwsim_pib *pib;
> @@ -942,7 +954,11 @@ static int hwsim_add_one(struct genl_info *info, str=
uct device *dev,
>         /* 950 MHz GFSK 802.15.4d-2009 */
>         hw->phy->supported.channels[6] |=3D 0x3ffc00;
>
> -       ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
> +       memset(addr, 0, sizeof(addr));
> +       /* give a specific prefix to the address */
> +       addr[0] =3D 0x02;
> +       addr[7] =3D idx;
> +       hw->phy->perm_extended_addr =3D addr_to_le64(addr);
>
>         /* hwsim phy channel 13 as default */
>         hw->phy->current_channel =3D 13;
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.h b/drivers/net/ieee8=
02154/mac802154_hwsim.h
> index 6c6e30e38..536d95eb1 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.h
> +++ b/drivers/net/ieee802154/mac802154_hwsim.h
> @@ -1,6 +1,8 @@
>  #ifndef __MAC802154_HWSIM_H
>  #define __MAC802154_HWSIM_H
>
> +__le64 addr_to_le64(u8 *addr);
> +

This is a uapi header for netlink which is not yet delivered through
kernel-headers installation.

Why do we need this prototype declaration here?

Thanks.

- Alex


