Return-Path: <netdev+bounces-106099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1049B914941
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309BC1C236E6
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 12:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F98913B58C;
	Mon, 24 Jun 2024 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsQ3nAEs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A55132120;
	Mon, 24 Jun 2024 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719230397; cv=none; b=K0AzzyyatuL7Q5VWbCbUvdzD1T3W83FvyD4arqJfjiK3lgNK7t7K0jtVQG12XENozsv8evL+wtzEX8kSehmiocPXLt+Y4xB00LgDNoubKwkzLJ2GUK0J5CinL+DNmWtAFjbz5JGH2s5Agu7T0jn3axHHJbrnrTq1hEpJRzNKbQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719230397; c=relaxed/simple;
	bh=mrw/F4Ya6RFfXo3J5jULK+03oRfHGgdK5t/Zq4Kh1Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tweQxnUNciLCZ+TA1BNYYn2crN++rT/rL/5wseO8MPACo1CJTZhELUKZs3Te7khPGxYb5RxBhpscvJmoka9wnY7iVbhb8EaBvrIR9k5KiMZT5nQMi/48J0MaTzR1U3rfpDYQ89dWtoiJYTsSj7bjySh6kGhkWfIbFWZTcayp7Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsQ3nAEs; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-70b2421471aso2935512a12.0;
        Mon, 24 Jun 2024 04:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719230395; x=1719835195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iwu8kUHGKGcTymQuxe9Xnw/0GaQZONNbqIunVMZstL8=;
        b=EsQ3nAEsfqLXckj9hw3+adU+Ng333QxyTjiBrEgHqxGiq2aKW24apdJW9XM5Hzwwf6
         /ifTNCI2smZYF+GndV/3cXAKdgakX+KZKdL3UAVBQfcih4T07u4igR/Qx+kax2U5cPIN
         BQjPia9oryfcvAbMU6b7rqAEjk8lJI9lxg4DtXk49hTwatMtKurl09NTqEHW14n5eNsF
         KbvyRX3iZuUJinQOf7ZqvZQ6xVWRmjT38pt8KTebVTT7rWlE0yX3boyFbzFJnYzEUGRw
         JehO9sj1pVFIoaIPISMWJY1UPK13oJfiL4Nd2IzWC/GPXL4v4SRBFNPsfu5UCNuHoKTa
         SQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719230395; x=1719835195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iwu8kUHGKGcTymQuxe9Xnw/0GaQZONNbqIunVMZstL8=;
        b=LlrWFVwFjd5jW14AdEGdBr2N87xIeuPgQ7eqtHoDist4bZviQ64kscVtjyjqDlioYz
         WBFysJL3y4sycWbxZm/XgJxfc5rv7XwFqw8cIl0Ke0CuEsGenvhm0eJ2u7DMyJfQzsJQ
         5cKyf32F9aEgJYIHxP2ddytsg+4gXXANiuZEnj5qFshKgVv9jz/3hNjgcWpfyQjvsVTn
         cXLzbz/18cXOtzn75u63JYX+cyJ+qDLg0TA4TyyY2/h9IY8px/4UMu7/2OERvC1HANy1
         /GK8iVFg67epnLEQoz6lUVAtNbfQB0Ap3KRRE5pOhGoHHv16LuCcon5P3tB6fcloJjdI
         +Rsg==
X-Forwarded-Encrypted: i=1; AJvYcCXPZVt2OYSCOXKYHcBLY7JHSXDlZqogSH6wijc35WXSz8Fb07AOQXL5RSnJ0LepCR/Cpu8EnSVhB/x8V+4GrGz8EmxnWESTay0g1QuhPoSUVAYId+rfdMdKpnruIytty5Z5m2JN
X-Gm-Message-State: AOJu0Yyjss1+8HBom6xbwuAWaBM5Mex1rqQ9rmuOx2UrQM165C7gfC+z
	klKok/9P1F+7ASHaN1G5gL/PAvQuaCQT07QK4c30pCMmBEDek8+PZdCoemyYn7jOmpsENGkSLYG
	0ltaTB2igm8N3ocZ4VIhPpg1KOQA=
X-Google-Smtp-Source: AGHT+IHB5YT5XqnR4lG46K5RH2swPEZn3XC4R+DJ+LKw1MjUenLgfADqv67Pq44U3Ej0iYW+3M14k/7z/ckqAY4N/XU=
X-Received: by 2002:a17:90a:604e:b0:2bd:f1d5:8e3e with SMTP id
 98e67ed59e1d1-2c86146c80emr2850938a91.35.1719230394874; Mon, 24 Jun 2024
 04:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623170933.63864-1-aford173@gmail.com> <3f970d67-5f14-428e-b8ea-02c62e1b5f82@kernel.org>
In-Reply-To: <3f970d67-5f14-428e-b8ea-02c62e1b5f82@kernel.org>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 24 Jun 2024 06:59:43 -0500
Message-ID: <CAHCN7xKTnbDec2uJu0vJMY-NMTDvhb=C_FPM+5QeDNBwwRgZeA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: net: davinci_emac: Convert to yaml version
 from txt
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, woods.technical@gmail.com, 
	aford@beaconembedded.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adam Ford <aford@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 12:07=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 23/06/2024 19:09, Adam Ford wrote:
> > The davinci_emac is used by several devices which are still maintained,
> > but to make some improvements, it's necessary to convert from txt to ya=
ml.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/Documentation/devicetree/bindings/net/davinci_emac.txt b/D=
ocumentation/devicetree/bindings/net/davinci_emac.txt
> > deleted file mode 100644
> > index 5e3579e72e2d..000000000000
> > --- a/Documentation/devicetree/bindings/net/davinci_emac.txt
> > +++ /dev/null
> > @@ -1,44 +0,0 @@
> > -* Texas Instruments Davinci EMAC
> > -
> > -This file provides information, what the device node
> > -for the davinci_emac interface contains.
> > -
> > -Required properties:
> > -- compatible: "ti,davinci-dm6467-emac", "ti,am3517-emac" or
> > -  "ti,dm816-emac"
> > -- reg: Offset and length of the register set for the device
> > -- ti,davinci-ctrl-reg-offset: offset to control register
> > -- ti,davinci-ctrl-mod-reg-offset: offset to control module register
> > -- ti,davinci-ctrl-ram-offset: offset to control module ram
> > -- ti,davinci-ctrl-ram-size: size of control module ram
> > -- interrupts: interrupt mapping for the davinci emac interrupts source=
s:
> > -              4 sources: <Receive Threshold Interrupt
> > -                       Receive Interrupt
> > -                       Transmit Interrupt
> > -                       Miscellaneous Interrupt>
> > -
> > -Optional properties:
> > -- phy-handle: See ethernet.txt file in the same directory.
> > -              If absent, davinci_emac driver defaults to 100/FULL.
> > -- ti,davinci-rmii-en: 1 byte, 1 means use RMII
> > -- ti,davinci-no-bd-ram: boolean, does EMAC have BD RAM?
> > -
> > -The MAC address will be determined using the optional properties
> > -defined in ethernet.txt.
> > -
> > -Example (enbw_cmc board):
> > -     eth0: emac@1e20000 {
> > -             compatible =3D "ti,davinci-dm6467-emac";
> > -             reg =3D <0x220000 0x4000>;
> > -             ti,davinci-ctrl-reg-offset =3D <0x3000>;
> > -             ti,davinci-ctrl-mod-reg-offset =3D <0x2000>;
> > -             ti,davinci-ctrl-ram-offset =3D <0>;
> > -             ti,davinci-ctrl-ram-size =3D <0x2000>;
> > -             local-mac-address =3D [ 00 00 00 00 00 00 ];
> > -             interrupts =3D <33
> > -                             34
> > -                             35
> > -                             36
> > -                             >;
> > -             interrupt-parent =3D <&intc>;
> > -     };
> > diff --git a/Documentation/devicetree/bindings/net/davinci_emac.yaml b/=
Documentation/devicetree/bindings/net/davinci_emac.yaml
> > new file mode 100644
> > index 000000000000..4c2640aef8a1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/davinci_emac.yaml
>
> Filename matching compatible format. Missing vendor prefix. Underscores
> are not used in names or compatibles.

Thank you for the review.

Would a proper name be ti,davinci-emac.yaml?

>
>
> > @@ -0,0 +1,111 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/davinci_emac.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Texas Instruments Davici EMAC
> > +
> > +maintainers:
> > +  - Adam Ford <aford@gmail.com>
> > +
> > +description:
> > +  Ethernet based on the Programmable Real-Time Unit and Industrial
> > +  Communication Subsystem.
> > +
> > +allOf:
> > +  - $ref: ethernet-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
>
>
> That's just enum, no need for items here.
>
> > +      - enum:
> > +          - ti,davinci-dm6467-emac # da850
> > +          - ti,dm816-emac
> > +          - ti,am3517-emac
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    minItems: 4
>
> You need to list and describe the items.
>
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: ick
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  local-mac-address: true
>
> Drop
>
> > +  mac-address: true
>
> Drop
>
> You miss top-level $ref to appropriate schema.
>
> > +
> > +  syscon:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: a phandle to the global system controller on
> > +      to enable/disable interrupts
>
> Drop entire property. There was no such property in old binding and
> nothing explains why it was added.

The am3517.dtsi emac node has a syscon, so I didn't want to break it.
I'll take a look to see what the syscon node on the am3517 does.  I
struggle with if statements in yaml, but if it's necessary for the
am3517, can we keep it if I elaborate on it in the commit message?
>
> > +
> > +  ti,davinci-ctrl-reg-offset:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Offset to control register
> > +
> > +  ti,davinci-ctrl-mod-reg-offset:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Offset to control module register
> > +
> > +  ti,davinci-ctrl-ram-offset:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Offset to control module ram
> > +
> > +  ti,davinci-ctrl-ram-size:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Size of control module ram
> > +
> > +  ti,davinci-rmii-en:
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    description:
> > +      RMII enable means use RMII
> > +
> > +  ti,davinci-no-bd-ram:
> > +    type: boolean
> > +    description:
> > +      Enable if EMAC have BD RAM
> > +
> > +additionalProperties: false
>
> Look at example-schema. This goes after required, although anyway should
> be unevaluatedProperties after adding proper $ref.
>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - ti,davinci-ctrl-reg-offset
> > +  - ti,davinci-ctrl-mod-reg-offset
> > +  - ti,davinci-ctrl-ram-offset
> > +  - ti,davinci-ctrl-ram-size
> > +
> > +examples:
> > +  - |
> > +    eth0: ethernet@220000 {
>
> Drop label.
>
> > +      compatible =3D "ti,davinci-dm6467-emac";
> > +      reg =3D <0x220000 0x4000>;
> > +      ti,davinci-ctrl-reg-offset =3D <0x3000>;
> > +      ti,davinci-ctrl-mod-reg-offset =3D <0x2000>;
> > +      ti,davinci-ctrl-ram-offset =3D <0>;
> > +      ti,davinci-ctrl-ram-size =3D <0x2000>;
> > +      local-mac-address =3D [ 00 00 00 00 00 00 ];
> > +      interrupts =3D <33>, <34>, <35>,<36>;
> > +      clocks =3D <&psc1 5>;
> > +      power-domains =3D <&psc1 5>;
> > +      status =3D "disabled";
>
> Drop. It cannot be disabled, otherwise what would be the point of this
> example?

Sorry, I copy-pasted this from the da850.dtsi node.  I'll remove the
label and the status line.
>
>
> Best regards,
> Krzysztof
>

