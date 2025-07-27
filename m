Return-Path: <netdev+bounces-210413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B93EBB1327E
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 01:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE88188D6CA
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 23:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65CE25228D;
	Sun, 27 Jul 2025 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv4VjWjW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6624C676;
	Sun, 27 Jul 2025 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753659606; cv=none; b=sYVvrNZ8B7t4eiZdWSiAxeCNmpKek2nHlVBrqcXAzfB5bq3+LJs09YVhKaKXQXqFXkmJpp8XdISz8Zo21Z4sJmKVuIm7+i9dAzkIFYIZsyRfxghWRtaoPuXBzftXlmA+WYKtKmFo9U6zyjbN0R0wYk6m0wnhklJDQT829wNtb+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753659606; c=relaxed/simple;
	bh=FFK/jbQGkSv5TR6tFiR2HkysiaKYhTzpPkOJ/+kVgY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvlCrC97hBeCAMe40uPbq7Fxa10eRkaXOqPpq/v03n2PCHZ0YZBqJFMLxVRbULsMHhZ7FR8urZSJQSCARpX6qeswriQWASQhIvFZiuAoVY2QfjyD5ToItlAZDho/7enYwIrmfKQBGgdvIkp05Bqoz/XXPMNJBn1tI9TiOhj8z2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mv4VjWjW; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3df2d8cb8d2so17816925ab.2;
        Sun, 27 Jul 2025 16:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753659604; x=1754264404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2wL2azdKJgx7J4uTcrG5JE0GxUXAaFoKaRVUubWqLI=;
        b=Mv4VjWjWa1knLO+LUKacRQ/j8ixWlhpBSIFB4tmfIOPIH0NBESE7GFvheGXZ4K0EOF
         Oyl6g/J6SCK00x825sdr8ajizngdCf7wmwefznW1hDKrwHyv/CASikQzzYeQtJqC0J6e
         PIn7+bsOEayTRg4poA/RBVdW4DxfQduEnqCGNNyPbTR1KWKvfSMonpXDDYPkfkX4mdTZ
         sGACDc+jWTbfSlMIucRKmplWiRfe7zbVSZD4WAifGIFXa8JACNI/73uoaOdyKZJjGVIj
         C8mxumfytl3GDvwXbpyYHSabqQWxL1ZfdsZqKVgfXtmOAZ7ffnDTwV1f6jdAthbYcs0Y
         07YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753659604; x=1754264404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2wL2azdKJgx7J4uTcrG5JE0GxUXAaFoKaRVUubWqLI=;
        b=UUdm6MBpDo7l9435bXHjlw3MY0TYvxu7pbFIDBdIiAZyUVjbbcMvMwPcdoBpczSXu8
         C8CdwJhsljtJaSS5hvcTG9itZdiLYqO/fvJvCejBd5sXAE3QLjXaa6DCge5nX7rEjPMs
         XXZ5S9b7eTg2MtUemvHi5d8C2B0eb9i/XNdLLMhm4PJ9uhI+p0iAt9C/bjpo/ePTO9yz
         1nYg0Q2DjSFD2ndnFWzQ0BhQQZugbM59DsYJuFAk6un9YkMQW6jbDLAS5J+l9wcodEiN
         k5yOq+jYQ+NOPzBa0QfMXUpM9/Ejni6f42j1uD+r1cXHP4U43Mzn14fZYeqXXD1pOkVB
         yoHg==
X-Forwarded-Encrypted: i=1; AJvYcCUv3SZt+ggwEy/rioY6+oImj/uNIiw01+xhub+QWHrbO/6B8Ps9PMMl2K7WKT1LOcmzLr6qtdyO1NP0DDc=@vger.kernel.org, AJvYcCW6LDSWRZjduvhCgOH0MWrr5Rl5ALu1LoDPuM9m744Ck4rfS6Sbqif+sCt6igFqMY3hz7lJV6Le@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0iBCUwJhwdO3NwHnnO0bE6JjT+eTdiGI+AJkZeNv29+degpwg
	y79fW4z8XKq/rr/nZgBBcUxC0ZE1TMlMGe30A5TusCfLgWwiHvD59fx6IoOCpN6dqLVUpDlpbds
	YlglUP/BQSXBbJbSv3B65Fp1Zk1CtUkY=
X-Gm-Gg: ASbGnctWAJq3H3bznqhbwoWqxCWWRcdf01i4SLrfvP3ymPzmb3MoEmd/x9Iai/mQgNh
	AFsULMrpxZLtcGkF81s2No6cnRvm+PdPOjBaC5C0DXojw7ma6NnN/fGbVqHpmy7zsO+v9tjkNIn
	PEwz3OtKj2t+RHloGXDZvWWGNIEmv50j6d4AreU4Vsfoxmp2DyEO8B+7mYdn9ElL0uel1zRXzs2
	T9pbQ==
X-Google-Smtp-Source: AGHT+IF7Xj6nsks4HnGhw27xzEh01/M1K44tjCYV+y50D/BUE0SM9aNWe58FfFmYjYEEFrBXMylZRF3qn3YD25d83IY=
X-Received: by 2002:a05:6e02:1985:b0:3df:3ad6:bfb2 with SMTP id
 e9e14a558f8ab-3e3c5312379mr109009725ab.17.1753659604342; Sun, 27 Jul 2025
 16:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727231750.25626-1-27392025k@gmail.com>
In-Reply-To: <20250727231750.25626-1-27392025k@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 28 Jul 2025 07:39:28 +0800
X-Gm-Features: Ac12FXzXU_X9JyFA45_CqQyF2HhLrDI_w0N7UlEXxRyoRC_OzuXbMWZpFTZgCNc
Message-ID: <CAL+tcoD=KJdEPvWWg6BjYkD=q-5mUEARThGmdbnF=TbYTTM7wQ@mail.gmail.com>
Subject: Re: [PATCH] net: atlantic: fix overwritten return value in Aquantia driver
To: Tian <27392025k@gmail.com>
Cc: irusskikh@marvell.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tian,

On Mon, Jul 28, 2025 at 7:18=E2=80=AFAM Tian <27392025k@gmail.com> wrote:
>
> From: tian <27392025k@gmail.com>
>
> In hw_atl_utils.c and hw_atl_utils_fw2x.c, a return value is set and then
> immediately overwritten by another call, which causes the original result
> to be lost. This may hide errors that should be returned to the caller.
>
> This patch fixes the logic to preserve the intended return values.
>
> Signed-off-by: tian <27392025k@gmail.com>

A few suggestions as to the format and should be revised in the next revisi=
on:
1. add your full name (given name, surname) on the above signed-off-by line
2. update the title like [patch net] to show which branch you're
targeting. Next version should be [patch net v2]
3. add Fixes: tag so that reviewers can easily know what problem you're sol=
ving.

As to the patch itself, could you show us more about the potential
race details? Like how it can be triggered, how 'err' value has
adverse effect, what the call traces could be?

Thanks,
Jason

> ---
>  drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c  | 2 +-
>  .../net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c=
 b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
> index 7e88d7234b14..372f30e296ec 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
> @@ -492,7 +492,7 @@ static int hw_atl_utils_init_ucp(struct aq_hw_s *self=
,
>                                         self, self->mbox_addr,
>                                         self->mbox_addr !=3D 0U,
>                                         1000U, 10000U);
> -       err =3D readx_poll_timeout_atomic(aq_fw1x_rpc_get, self,
> +       err |=3D readx_poll_timeout_atomic(aq_fw1x_rpc_get, self,
>                                         self->rpc_addr,
>                                         self->rpc_addr !=3D 0U,
>                                         1000U, 100000U);
> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_f=
w2x.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
> index 4d4cfbc91e19..45b7720fd49e 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
> @@ -102,12 +102,12 @@ static int aq_fw2x_init(struct aq_hw_s *self)
>                                         self->mbox_addr !=3D 0U,
>                                         1000U, 10000U);
>
> -       err =3D readx_poll_timeout_atomic(aq_fw2x_rpc_get,
> +       err |=3D readx_poll_timeout_atomic(aq_fw2x_rpc_get,
>                                         self, self->rpc_addr,
>                                         self->rpc_addr !=3D 0U,
>                                         1000U, 100000U);
>
> -       err =3D aq_fw2x_settings_get(self, &self->settings_addr);
> +       err |=3D aq_fw2x_settings_get(self, &self->settings_addr);
>
>         return err;
>  }
> --
> 2.39.5 (Apple Git-154)
>
>

