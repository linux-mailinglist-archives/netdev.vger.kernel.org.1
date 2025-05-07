Return-Path: <netdev+bounces-188655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110FCAAE0E9
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC62F3BCA9F
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 13:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B446280A57;
	Wed,  7 May 2025 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjMWbYhz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C1F1519B4;
	Wed,  7 May 2025 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625343; cv=none; b=MoregXu2QtiTsfMLeQlduJ8gkVCocRhXszjR0kNPmbkwf5rQ6LgcS4mkQRdZ9WXuLw94UewpkAyTha9dobb42mfQNSbcJnEQy+UAMesx7D5cb/rfvIG2E0Ki84P28Pb8G3/6AOtqy6cuYyj8mAQrPpy4oa4t2ilnB0fkS2eKFXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625343; c=relaxed/simple;
	bh=rt0gLT/Cx6uH7xEwJf4S/Dy3MmtJMMcOxB9M2SOESBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJsBOwONCGx6zKv9GOCIKjRiwoiPaba7v2CAYETsYYuZGIsn3HBomrGZof6z5DSQ0b0YMWcY6pf8Clr0LhZCeepSlHZ1sRnFH3YZn5GlMOcaLxRr0vi14d7f6SZFjL/eWBwJvGNn24IJFhUIFQkbGDXJPePxORpS/tbsgylL/iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjMWbYhz; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-acae7e7587dso1095572566b.2;
        Wed, 07 May 2025 06:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746625340; x=1747230140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fu5jAYqPptIEmaOmMbSmkEQLD/PP47xbmK8wHBaTar4=;
        b=NjMWbYhzKaIWQHlJa5fYGRqZnVD+kZmWMAAdCN9/RdItPoskCd7n1cqNm2Pqmd0tS3
         qob5viQ20wRc2dts1udBep55BvUUeQ7oSOSK/Vcg2o3luusGEMr5OZ7Z4W7teitG8DI1
         DqSqq0rCNCampJkCWeO8ySMndJ44ftKHBlvts9CLGICZvFULxZWKf1F7q0sZwip1Exw3
         5Lm9/YGKHKlmrBX9vCScoHz+Va0EfuWd/Qt68CBCYwq5MXA2SFM99jSVULhYs9a2fr/j
         mCaC5ePGn/dIePcL1M4tIBhg9x/3TrRWhKkucorEnQX0YLL76gkZeZQ5lWviObUm+y4t
         h53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746625340; x=1747230140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fu5jAYqPptIEmaOmMbSmkEQLD/PP47xbmK8wHBaTar4=;
        b=JUeicqjw4iscys/t9Jej/UuVhpqXzUu6DCeDivyul5R3BhzZH0UpnKrv/g2LMHToDO
         gLv6TU0Ovv+eWnt16LYPFlvx2Kn2HL/yumgIQLR97vyx+MW5sdCWXU7tyZIF4Dvq1hn4
         Dv+mc3vFJdtdnnGaW5VmJfpmw+AyoXW0PpTSqY5GQ4SgOxpdQUN/bFkV3JpJr+gAf61j
         tiU08xRnxUW1SDtuMmfIqGsMZTjz2rf1FQ5Fe/l89qLRYRLgqy2Yf0NYE7VxnPw7Grlx
         LkKQD7Kp094r3TxYl85qnHdxs3xZlihYl2CL3dVxfsxP1vngrtQLbzKjycclMhn+E/NH
         ClTA==
X-Forwarded-Encrypted: i=1; AJvYcCU045O7C1Cf4vPQr4JyUbLWUOolfihdt3WgZyqELnw1qFbBGvv00uaBJKCck7qefELBTmqjmly9iT0P@vger.kernel.org, AJvYcCWvvUMp2tIySzeIsIDM5ScdTKXZe+rZE1JuEw5V9e+YNvUHcOnOuTtlCPZSFo1x22UfzL0jesRMnLr1uldF@vger.kernel.org, AJvYcCXse4FSWWDK+lMDmtxyrn/R9NG2BzlyXpa+ZbIcu6F0WxsB7sBwNXTajVFruUOOEE0c0r7kTLyqKRTd@vger.kernel.org
X-Gm-Message-State: AOJu0YwNHjgG2dcaFtqSUUjrfbSjU/8vBdFp7Rs42FL4RTzjdc2KNN0g
	83k6tD82aKSIVWfRH8OGSPJN6sj8htV3BilTUFPeRYU3JOXmZQyjSUhH2Bld2pJBMrWG7YPTpR7
	JYwScjRl9FohB+beeqsqhPfys+/g=
X-Gm-Gg: ASbGnctNEq0+Obi56T2tYiEvGxeltIzn53Wxr+SbsGRSki+PZeeel9ubg2TaqrHt6Jd
	8prRD+gSKWdDIEfFZe4l8MSLXZUnX4oqPmEeFg6PppRAEeyzuDKDUAWjJHTT8DEzLGGI48E1/Ks
	kuSXQdkb6ssjlWe58TtEvR6jgm
X-Google-Smtp-Source: AGHT+IGQBtHrZwxhQakHc3ARhOEyA4EPrV8tDh/xRaawNPgEr75PKZsCLFzdhfdOeCaSHRB69AiXjNW3dOcH15xOGlY=
X-Received: by 2002:a17:907:d507:b0:ace:3af5:1de6 with SMTP id
 a640c23a62f3a-ad1e8d2934cmr350558166b.35.1746625340440; Wed, 07 May 2025
 06:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507124358.48776-1-ivecera@redhat.com> <20250507124358.48776-9-ivecera@redhat.com>
In-Reply-To: <20250507124358.48776-9-ivecera@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 7 May 2025 16:41:44 +0300
X-Gm-Features: ATxdqUFuxCdQxMTUYJnn6Zn0Z-yNV6W-XdaPO6tDqq9cIe3Jt33eP9TAQnxP48o
Message-ID: <CAHp75Ven0i05QhKz2djYx0UU9E9nipb7Qw3mm4e+UN+ZSF_enA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 8/8] mfd: zl3073x: Register DPLL sub-device
 during init
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>, Michal Schmidt <mschmidt@redhat.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 3:45=E2=80=AFPM Ivan Vecera <ivecera@redhat.com> wro=
te:
>
> Register DPLL sub-devices to expose the functionality provided
> by ZL3073x chip family. Each sub-device represents one of
> the available DPLL channels.

...

> +static const struct zl3073x_pdata zl3073x_pdata[ZL3073X_MAX_CHANNELS] =
=3D {
> +       { .channel =3D 0, },
> +       { .channel =3D 1, },
> +       { .channel =3D 2, },
> +       { .channel =3D 3, },
> +       { .channel =3D 4, },
> +};

> +static const struct mfd_cell zl3073x_devs[] =3D {
> +       ZL3073X_CELL("zl3073x-dpll", 0),
> +       ZL3073X_CELL("zl3073x-dpll", 1),
> +       ZL3073X_CELL("zl3073x-dpll", 2),
> +       ZL3073X_CELL("zl3073x-dpll", 3),
> +       ZL3073X_CELL("zl3073x-dpll", 4),
> +};

> +#define ZL3073X_MAX_CHANNELS   5

Btw, wouldn't be better to keep the above lists synchronised like

1. Make ZL3073X_CELL() to use indexed variant

[idx] =3D ...

2. Define the channel numbers

and use them in both data structures.

...

OTOH, I'm not sure why we even need this. If this is going to be
sequential, can't we make a core to decide which cell will be given
which id?

--
With Best Regards,
Andy Shevchenko

