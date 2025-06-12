Return-Path: <netdev+bounces-196875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23412AD6C09
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB413A3DBF
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 09:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D4E22425B;
	Thu, 12 Jun 2025 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL8t6SGk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5261DDC1B;
	Thu, 12 Jun 2025 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719982; cv=none; b=Lh+6NRYC3X/u2CIyV5r4hMmdLxiVew1qkFu1rXT7sLYuSIXbLgPzzBVLjn9VQRL0uLrQNW7f154nZFe4u5i2+QzQz2j3RfsggnUEgjL43Gjml14XuIA8ktcUYI4PHe7AmyAllPEdyKZ22DFLFm3LGYZeC5LbUbwtGESRUBt71eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719982; c=relaxed/simple;
	bh=SrOG5hWQk1zrLTAPc63bdygYKBmfRy2k8EtrfPp+WQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbn6Rlf527UkKExYMc8Irj2MAyf6DIYZrZxqhGxcJQXkR4vewdIUk+UnJkMkipgdiqiZbuENV9v+1yxG/1J2yirVYcpVarOE3++MyQnQW7IUBfsBf8G7ZDIoCpLrMNIPRilt36uTg/Uyk2euVT2xPqx8CM8bsOBREb24AyiLvXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL8t6SGk; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70e64b430daso6874817b3.3;
        Thu, 12 Jun 2025 02:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749719980; x=1750324780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6M9L0+MmrDMuS6KT7R4p+67RYgDJd/r3uFOA4tchHY=;
        b=iL8t6SGkkIoHmo3+VAfjAXEH+z7VsMuLQLXchET9DyMhiMJme8AtjCqCRiWMCUlCl0
         PEN6Eu2NhDktenNYTsZfoNgNUEwQXiqCL3RzVpkTiPq5q+bTsh9XAcv0zGchFmAMqcHE
         ouY+czvHvGUN0i66YDSeWP47gwg3RjJp6l90r5ltg16+2bARfmAS1+MolimXbupV7aRf
         yTihCTBaeUdGX4rmHOHeIZqVdw5e1QlFr08lxXO7X9mpU1PU1oJEBSDFbxQwy81l3QH2
         zQZk59jP/fMTbgGO4HzgwGyTu/1AJWA4KtMXDhu9p0CQHC1BUsmMZERWoWWlC+F2GZ8X
         gz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749719980; x=1750324780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6M9L0+MmrDMuS6KT7R4p+67RYgDJd/r3uFOA4tchHY=;
        b=Bdd+VmXe+QQibSrodyCsvFJAvaxse69FE9oqJ73dIdIuy13xy6VDziFggz62f6GUrp
         woxXIIb59sDfk/5hOtSz/KCWTwlyw3GJwFB0/BgEysHLuoho+RRSg2n0Cmwpe8sVrm4k
         Xd6a7LSNzo9MsRnzer7WhNM51VNjS/SK0FgnBFYGkrqSQ1OYH8AaF1Mq67Y4knyzPgLm
         tWcQjLrsMnIap+mgl44y5E+Wn7n9lGSoQV19EoVDBilvKp6N3H002NUlc2Yfx/tkgX3W
         0OaWrpJLOtjnbu91Ynd+GdidX9EZKto8LVNoR2lU1qDybHPCYYpSurc8CpE+k40qsSDg
         Um5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWraOZY+sTPx0TAqvlMnsJID7BpdW865gj2Gnw2ubAdqGvtO5KzgjclrKsthFpFhkqJJbnLdKIb@vger.kernel.org, AJvYcCWwbXIR/R84ULQpqmZ0nsiezLuDjwyz3JCjoTgHCjFs2AiAJ8d5TFENqKS1YLmD4qPYl4gGFedQxyUqVcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJfY+HsnV8L/AEnB8bRb3/ijapvEAs94CWX0MkpAgTYyoeg7Ob
	AvPPQLeJF9PvesBIfm10PgGUj5VU1pj0M6bUaH5gFatfpwVC9YusfYr/ZTDxYGx56ogz9EZFDLU
	WFKEhlycvfZYAP4LwuQNz1ixfyIgSVaA=
X-Gm-Gg: ASbGncvt7cYWJSMWwriP3d0BFgM3yzQOrfcdnpMXWKlPCkgGE/OhT2BU7KIEBmUEClW
	EooWACCcD/LWa9jl1paD52DgUj7m1Y8zvQu8N3chHrnTlJnHdxM05+IZ7TTN4X/tjpDfHO52du0
	GTtKDrWiB5sgx2ATKvt4M/ho5QPxT7fIczm8qtO6S9bw==
X-Google-Smtp-Source: AGHT+IGH7sDf4LiImDbm/Kz7/EEL16HJlECL7kfxq4SWDE4KT62jEgTnQBGcT2DN2wMasegvdLsVOv+xfegFEGIVF2A=
X-Received: by 2002:a05:690c:600c:b0:70e:142d:9c6f with SMTP id
 00721157ae682-71150a8ab4bmr32985267b3.28.1749719980218; Thu, 12 Jun 2025
 02:19:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612083747.26531-1-noltari@gmail.com> <20250612083747.26531-15-noltari@gmail.com>
In-Reply-To: <20250612083747.26531-15-noltari@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Thu, 12 Jun 2025 11:19:29 +0200
X-Gm-Features: AX0GCFvPK94DAfonjPX3Wgwd7edBJnKtLhpQ4BIlk7FUnpfqSYzn08RnYB1IvXU
Message-ID: <CAOiHx=ne3Bbkeja=F0uPbHjrqp3Y24Zf460uAfK6OxjLBz7MAg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 14/14] net: dsa: b53: ensure BCM5325 PHYs are enabled
To: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, vivien.didelot@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 10:38=E2=80=AFAM =C3=81lvaro Fern=C3=A1ndez Rojas
<noltari@gmail.com> wrote:
>
> According to the datasheet, BCM5325 uses B53_PD_MODE_CTRL_25 register to
> disable clocking to individual PHYs.
> Only ports 1-4 can be enabled or disabled and the datasheet is explicit
> about not toggling BIT(0) since it disables the PLL power and the switch.
>
> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> ---
>  drivers/net/dsa/b53/b53_common.c | 12 ++++++++++++
>  drivers/net/dsa/b53/b53_regs.h   |  2 ++
>  2 files changed, 14 insertions(+)
>
>  v3: add changes requested by Florian:
>   - Use in_range() helper.
>
>  v2: add changes requested by Florian:
>   - Move B53_PD_MODE_CTRL_25 to b53_setup_port().
>
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_c=
ommon.c
> index 3503f363e2419..eac40e95c8c53 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -660,6 +660,18 @@ int b53_setup_port(struct dsa_switch *ds, int port)
>         if (dsa_is_user_port(ds, port))
>                 b53_set_eap_mode(dev, port, EAP_MODE_SIMPLIFIED);
>
> +       if (is5325(dev) &&
> +           in_range(port, B53_PD_MODE_PORT_MIN, B53_PD_MODE_PORT_MAX)) {

This happen to match, but the third argument of in_range() isn't the
maximum, but the range (max - start), so semantically this looks
wrong.

> +               u8 reg;
> +
> +               b53_read8(dev, B53_CTRL_PAGE, B53_PD_MODE_CTRL_25, &reg);
> +               if (dsa_is_unused_port(ds, port))
> +                       reg |=3D BIT(port);
> +               else
> +                       reg &=3D ~BIT(port);
> +               b53_write8(dev, B53_CTRL_PAGE, B53_PD_MODE_CTRL_25, reg);
> +       }
> +
>         return 0;
>  }
>  EXPORT_SYMBOL(b53_setup_port);
> diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_reg=
s.h
> index d6849cf6b0a3a..880c67130a9fc 100644
> --- a/drivers/net/dsa/b53/b53_regs.h
> +++ b/drivers/net/dsa/b53/b53_regs.h
> @@ -105,6 +105,8 @@
>
>  /* Power-down mode control */
>  #define B53_PD_MODE_CTRL_25            0x0f
> +#define  B53_PD_MODE_PORT_MIN          1
> +#define  B53_PD_MODE_PORT_MAX          4
>
>  /* IP Multicast control (8 bit) */
>  #define B53_IP_MULTICAST_CTRL          0x21
> --
> 2.39.5
>

Regards,
Jonas

