Return-Path: <netdev+bounces-232117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E1AC01513
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27331A07874
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422D6314B90;
	Thu, 23 Oct 2025 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j92iaoNz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE2B314A90
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225510; cv=none; b=BnlIu6utzqeEcfJyjWLdzRQwEW/3ZuUkK0x4xr4+cbK2hUf0u8SpAHWf0MEY+z2vh10GjZxCECKAtgjKoFRGakIN6rpA91VTBfffr3SUYcdImPUHXR18xAkwZCH7b75uH2kak+PEPA+a3XkaubZr5xxhE9cv8vqXUm2yYSa6eI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225510; c=relaxed/simple;
	bh=Io1p8sRPePbI/yYp7eF8xFBiYUfxl05DJQuwL9i9Yvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCOmDdLZYy3Df8X4CPJ2u+1ZECQs2rNufXdeTonoEgkUvHln+Fc6wGQSlDKzAQlzuSuoBmhkrNxLnS/lqSkXmuXFffDIUrhu6+umc7wGvBxF0Kp/JV1S0jHBpbPYyDk6CXY/jfFd9bvfR93u08N9b+SLTVOoAUnijujm1CwX49Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j92iaoNz; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-378ddffb497so5148861fa.2
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 06:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761225506; x=1761830306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Gn0u6F4FcwNzytioOd4AYhSpwnJiVIhDhy5I+5Dm0E=;
        b=j92iaoNzR+bkh5B+2ju2qto4umPie1qtKjZzigSL4zq48/OQXjS0aye6ay2Mq3Lu7P
         B4Z5GgsDoOpzlwErlHStPa1TDQmqeLE8nqKCaxCTvtNdhONWOejUosWLj6RzrTc6t52g
         EHauXdLZ+TG2MK5nhMWkJtH3IEXEExBxqZKsqfxJnyfvnsMkaXZy5TF6aLgvnxnCFR7f
         KGN7obtEUTgt702sLDFXFdKAgxYmQbR427kfG7iH3ZJgpQMyFp/BqB0snIxJrETp/HPF
         A/GBNWKEmIyz59NxiKqp2mOflTWGnE7R054P1O3PlnkQwGE9XvYjPMA2pADa28g2PIr9
         roVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225506; x=1761830306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Gn0u6F4FcwNzytioOd4AYhSpwnJiVIhDhy5I+5Dm0E=;
        b=SJwWWQs3X2Kyhcc6wZLr/Pc/pDxJ2PcwlOCV9zsloLBrKicAuSFEJaZiOHhYP66hfD
         9zSE/pp7N7snFv/r7/FBJwWGRAHA4kuS4TdqlOTAULCwhPNaW8+4+Da557grnVPt1P4D
         5AF3cJl374QsbAMKMcwGV0+L4L92tyvm09EYfCiz0OoziqDot/Facw8q54t0kyjmXW1F
         R6doRZy6BlxZlKOu2RpauToT2jipm88/D6QeIlylBdZW2z0OzJgpC30k0YMQ2pbOOOnE
         N8TTbetSsuiM7P/OEXcvLEU/B88Amfp1y3ieOLrCNl0NgxOMunIK5dGp5MSs7VZiqn5z
         RvCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8HBdn2sIyNpW5PvhlCzgdEvf5VHzvm08awZNQt1sTE4CFWIOu4SE2yY1ldl2ABb//J2GMAGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzfg1KXgl5HCQ37IfBBClJf8111N8QKMvCmjzzT9Ia496ApdDs
	DRK4tZoWMy6TGb9LDKoDRS00lU8T7aZber+4evlK+SQActrsQ9Kc7m5u9KkqGQ8ccgZ+N24MYbv
	xw2ZWvmmxeAYFLM1UWaBJMHPGZl4EE7U=
X-Gm-Gg: ASbGncupwbAaZc9mGSPdYXO8XviSO1Gjfjby2gUZGMZ10cPK3qLezruPU1wx5sGO/bC
	s9wpBxr2v/Cwox8ZgmcAveMd4cIGUBk4S8PiyMHB2QYAW4GzqEol33v1kA1X69gMbKj9IG8AJTr
	2sqxaUbWg1bd3gc4X42/VKnoOQysQ6p1no+nkj+wWIUXVmpzfsq5Z8dRsAhBrVJkNDAleP1gRdi
	qzi5U+eyT3VmjEd21Dz31f9Pbg+N/oUxJeiRLrQrUvdLbqfp5gJwz4BTfVNqh/Tkip/Fw==
X-Google-Smtp-Source: AGHT+IF9mkLH9nWY6msPEXtSzp21zHIILiGGoh+1t404Gr2SEQ44oMEc/FKkF7qZ2Yh4aplYXJXL04MuqXK8NskaD18=
X-Received: by 2002:a05:651c:25cb:20b0:378:d312:52c0 with SMTP id
 38308e7fff4ca-378d312536cmr9636841fa.5.1761225506011; Thu, 23 Oct 2025
 06:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020151255.1807712-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20251020151255.1807712-1-Ilia.Gavrilov@infotecs.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 23 Oct 2025 09:18:13 -0400
X-Gm-Features: AS18NWAOr4vPXVJkPYtTy29M3zZKn1wN4ylPEGtp4Ibczfl2RaoyytNjp5Xysuc
Message-ID: <CABBYNZKUNecJNPmrVFdkkOhG1A8C_32pUOdh0ZDWkCNkAugDdQ@mail.gmail.com>
Subject: Re: [PATCH net] Bluetooth: MGMT: Fix OOB access in parse_adv_monitor_pattern()
To: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilia,

On Mon, Oct 20, 2025 at 11:12=E2=80=AFAM Ilia Gavrilov
<Ilia.Gavrilov@infotecs.ru> wrote:
>
> In the parse_adv_monitor_pattern() function, the value of
> the 'length' variable is currently limited to HCI_MAX_EXT_AD_LENGTH(251).
> The size of the 'value' array in the mgmt_adv_pattern structure is 31.
> If the value of 'pattern[i].length' is set in the user space
> and exceeds 31, the 'patterns[i].value' array can be accessed
> out of bound when copied.
>
> Increasing the size of the 'value' array in
> the 'mgmt_adv_pattern' structure will break the userspace.
> Considering this, and to avoid OOB access revert the limits for 'offset'
> and 'length' back to the value of HCI_MAX_AD_LENGTH.
>
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
>
> Fixes: db08722fc7d4 ("Bluetooth: hci_core: Fix missing instances using HC=
I_MAX_AD_LENGTH")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
> ---
>  include/net/bluetooth/mgmt.h | 2 +-
>  net/bluetooth/mgmt.c         | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 74edea06985b..4b07ce6dfd69 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -780,7 +780,7 @@ struct mgmt_adv_pattern {
>         __u8 ad_type;
>         __u8 offset;
>         __u8 length;
> -       __u8 value[31];
> +       __u8 value[HCI_MAX_AD_LENGTH];

Why not use HCI_MAX_EXT_AD_LENGTH above? Or perhaps even make it
opaque since the actual size is defined by length - offset.

>  } __packed;
>
>  #define MGMT_OP_ADD_ADV_PATTERNS_MONITOR       0x0052
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index a3d16eece0d2..500033b70a96 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5391,9 +5391,9 @@ static u8 parse_adv_monitor_pattern(struct adv_moni=
tor *m, u8 pattern_count,
>         for (i =3D 0; i < pattern_count; i++) {
>                 offset =3D patterns[i].offset;
>                 length =3D patterns[i].length;
> -               if (offset >=3D HCI_MAX_EXT_AD_LENGTH ||
> -                   length > HCI_MAX_EXT_AD_LENGTH ||
> -                   (offset + length) > HCI_MAX_EXT_AD_LENGTH)
> +               if (offset >=3D HCI_MAX_AD_LENGTH ||
> +                   length > HCI_MAX_AD_LENGTH ||
> +                   (offset + length) > HCI_MAX_AD_LENGTH)
>                         return MGMT_STATUS_INVALID_PARAMS;
>
>                 p =3D kmalloc(sizeof(*p), GFP_KERNEL);
> --
> 2.39.5



--=20
Luiz Augusto von Dentz

