Return-Path: <netdev+bounces-242292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA06C8E646
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 14:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 468AC34FC9B
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A3D1AF0BB;
	Thu, 27 Nov 2025 13:16:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5921A9F97
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764249379; cv=none; b=rKwv2ON3IBHuHE4hGWN3I6Ozadeg1rB/tmDizYPe4ohNb+KwG2SUNCW0f51+mkwSFyvlL5pds7Id0wIfziBduArFYNjX/X1oTTu7ElkuGhdOkeXh4b98cl1U9qvBCg+L5ZKxDDW2kldTDNGJwuBX3peadyfamhfI+qIE2/Q+M9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764249379; c=relaxed/simple;
	bh=i0+NI2Bud3BlBikNUo49+8Zo8rRsxq05UxY0PW6sYJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3a7JaDBbLA4JE30IdkssMB8Urcw6+q6RFjg2HzhGabjKLUPTrgcCMJi0rFCGcHWXkK9Toej/eE5mlWHq6Vp3A4UP9UFAEFKAG+nWVnCZHYZXjNEmINguTsxWTdm8hb6iP6f1VKwDAUDBUQIIEYTBynVqxJROI8jFXsFw3SlREc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b2ec756de0so79897385a.3
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 05:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764249376; x=1764854176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/la0b8NwFw52ANl4NaAU+Zs/xhH8L5L8IfhP5J6VHSo=;
        b=dDk3pmVL+njVh3v3j0tgADVaTaDcfTWw2lmHVhr9dO1wb6JkA6jgRwgx14mNM3lBVT
         oQl+dCY0LHrbgVC0LYGqDuxmO8C75rKa6/Asjcr/12lp8xFag9vSMTtz4JmfxWNKmHmM
         yhbH1dwlDSP+hkKT49vv71ep+RpKfy4bpeFZDf2w8vQLQkfiSVdkLf0ijfknShrQN1dr
         s7oh+vdq1AS80xsZrl1ZZbyS1RmTA55PbO7NcTVHvR3u+b0Awl1qIiuUuViyI5IklIKT
         nlXyo6088WbGlkeT8JxtX00EoMrfmKxRU1Noy7VxmhE+B3n/XxK8hfdq/gryzdfXUP8I
         WK6A==
X-Forwarded-Encrypted: i=1; AJvYcCXJ41X4Z436Tf/ojqdgsD8TPsSi+b1QE+tljTkGvkOWisRs6NuBCUiPS60m8+HGibasYU+lhX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7+NYUyvf0PLKUteHLq21EKM9TuX5ct9hpyC9m8BIwnbywZgGW
	uRuimxSNO8NPHtpdYCkHlK+wnxBNiP/MANM9EvpU6KPGhqqfznmWmxzkr7/wKjw9
X-Gm-Gg: ASbGnctHv9GoFMRr55q3m+JOzBDLJVPQtk/VqX4sBnYB2TSzT6X1Bx4U32E1xjhLQoO
	z9pGrDhloWEg8HJMsCybpEPMhqY28DeH6T7WKAbB7czweYX372oj+b02Hbn0gG31bbZ5d5thFWD
	V7dy7u9OTGB39FLRKnhJHM7hBET6hVsM4w4tQW/EcM5S62y/GPMSzsSl1QIGSrRRB8Ug9LBQhlF
	VbgeUd0lF24qRIsHOA7jRzOgP35wYv978kaFPZpAdnGiv1+dAd975zK3DCF5UPFBt8wv8KmjqAu
	JHGYr0n/6w2XHp8Whbj8pE++M393AC1oHiNyobx9ip9FlXd9e7GEW1AWwJpblbjEmE8kavKg9sb
	9fktH0xGvirXj5alq7I/JEQBzJX69x4qJApVSUlyCtyTjEySy6j97fKUWXAA74FPCipC3ZTtVcx
	U4GMWQ3m6AeWsQjGTHmMtZ/wXcjRACd+vM7X2HnADXeGrYlU9x
X-Google-Smtp-Source: AGHT+IGzuqatvvrNZ84luy5p14I7EflQsLt2sJErX3JZyGPStdG3krQ4Qqnd7a2ttFLt8/2Z19RFzQ==
X-Received: by 2002:a05:620a:4116:b0:8b2:d259:6138 with SMTP id af79cd13be357-8b4ebdb0681mr1222079885a.58.1764249375824;
        Thu, 27 Nov 2025 05:16:15 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1dd353sm103611885a.49.2025.11.27.05.16.13
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 05:16:13 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-93720298f86so478171241.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 05:16:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWuC4RDox0RGlNqHCHUfhLkOlbQkDFMAlR9WpI/NKyYmz0oBEx/0wsSBRvjQAHTn/0xAvpsipA=@vger.kernel.org
X-Received: by 2002:a05:6102:5e93:b0:5db:ceaa:1dbf with SMTP id
 ada2fe7eead31-5e224417a9bmr4411857137.41.1764249373279; Thu, 27 Nov 2025
 05:16:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251121113553.2955854-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251121113553.2955854-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Nov 2025 14:16:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVtxLCRHdhj5=iOHyDJFQUfALYj8MXGLA+bT=YSvWtbbQ@mail.gmail.com>
X-Gm-Features: AWmQ_blYrSklJ3vMkio_CRlMnvD_t9kp1obUj6YpfU6Kqg0TYQcNKUPeqWm26t4
Message-ID: <CAMuHMdVtxLCRHdhj5=iOHyDJFQUfALYj8MXGLA+bT=YSvWtbbQ@mail.gmail.com>
Subject: Re: [PATCH net-next 04/11] dt-bindings: net: dsa: renesas,rzn1-a5psw:
 Add RZ/T2H and RZ/N2H ETHSW support
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar, Cl=C3=A9ment,

On Fri, 21 Nov 2025 at 12:37, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Extend the A5PSW DSA binding to cover the ETHSW variant used on newer
> Renesas RZ/T2H and RZ/N2H SoCs. ETHSW is derived from the A5PSW switch
> found on RZ/N1 but differs in register layout, clocking and interrupt
> topology, and exposes four ports in total (including the CPU/management
> port) instead of five.
>
> Update the schema to describe these differences by adding dedicated
> compatible strings for RZ/T2H and RZ/N2H, tightening requirements on
> clocks, resets and interrupts, and documenting the expanded 24-interrupt
> set used by ETHSW for timestamping and timer functions. Conditional
> validation ensures that RZ/T2H/RZ/N2H instances provide the correct
> resources while keeping the original A5PSW constraints intact.
>
> Use the RZ/T2H compatible string as the fallback for RZ/N2H, reflecting
> that both SoCs integrate the same ETHSW IP.
>
> Add myself as a co-maintainer of the binding to support ongoing work on
> the ETHSW family across RZ/T2H and RZ/N2H devices.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml

> @@ -73,14 +145,48 @@ properties:
>                phandle pointing to a PCS sub-node compatible with
>                renesas,rzn1-miic.yaml#
>
> -unevaluatedProperties: false
> -
>  required:
>    - compatible
>    - reg
>    - clocks
>    - clock-names
>    - power-domains
> +  - interrupts
> +  - interrupt-names

FTR, this causes warning for RZ/N1:

    arm/boot/dts/renesas/r9a06g032-rzn1d400-db.dtb: switch@44050000
(renesas,r9a06g032-a5psw): 'oneOf' conditional failed, one must be
fixed:
            'interrupts' is a required property
            'interrupts-extended' is a required property
            from schema $id:
http://devicetree.org/schemas/net/dsa/renesas,rzn1-a5psw.yaml  DTC
arch/arm/boot/dts/renesas/r8a7740-armadillo800eva-con15-quad-7seg-red.dtbo

    arm/boot/dts/renesas/r9a06g032-rzn1d400-db.dtb: switch@44050000
(renesas,r9a06g032-a5psw): 'interrupt-names' is a required property
            from schema $id:
http://devicetree.org/schemas/net/dsa/renesas,rzn1-a5psw.yaml

Cl=C3=A9ment added the interrupts to the binding, but never sent a patch
to update the DTS.  I have submitted a fix:
https://lore.kernel.org/53d45eed3709cba589a4ef3e9ad198d7e44fd9a5.1764249063=
.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

