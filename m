Return-Path: <netdev+bounces-214700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C91B2AF0B
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 19:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE15562289
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EDB32C31D;
	Mon, 18 Aug 2025 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtVOJoK0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD07432C303;
	Mon, 18 Aug 2025 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536799; cv=none; b=KjnYAkKUHctkXpWhHcMa36FbYJagCdS9JTr3gQAgZX9vv0/UgMuks7XG5BtmeyS9ckiy/GFlrKjm8+dCh7Q+VMRWuEr3ZNdJCpJa4i1bdbFZn+2FJOASn5f+aEYjdUpnuzVGThDdIN907ZT7n9NouM2QMSmVwknFweNni2Js+6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536799; c=relaxed/simple;
	bh=IeJAvPYGowlNqG0tKXTAAw5U2CNi0Ssvck1hJEAGs6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QALwP5lHQJ0iR8m5J9CER+G+QK+lTHS6F5U8nFPDa6Titzr9U7QEZHM1usZ7tvGeRYvQlXvsWcvQYnJFIPg+S8k2UXbwZ78rlI3szzsiHmrllDffoWVChHLxwGO9lsjzxcuk5u4EXrMMwIdZESStXLVj9Xt7Qq/rgCqS9qq6lXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtVOJoK0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2eb3726cso2674830b3a.3;
        Mon, 18 Aug 2025 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755536797; x=1756141597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2iT+OSwu/o+q7or9X7skDkQLBASb9/+W0LldLqelFY=;
        b=XtVOJoK0ERhL9EB066+C9FE4zdRLGXRRX5ow1k9sYbvNZYrrEzFosGkCceQUJNaHNh
         awUhjOy/xGemSAeM+XCTs3KWA8EtbX45OixNJfcsjQl8PKkxwxIbKaaXbXftwwHWkvfW
         P8gsRF5A6TwRj+vifu3eHDk3XuY7uzNsjx/H/DiqBMc9Ckr5O3H+LJDbpx3hi3vTPjol
         2ToTEgAGRBFZdYr4ILf2WvA9in3yJLq3Q0luTbRzTTYZeo3dM3toRJeQL3YBKNYyz0pj
         ecAOvJhnfKMZ1h+IBtcsdi7nP4pBmP6tcO6UkRGqGXcmpWVKkXFCfGvLqSTk7PZ8VRAR
         Lgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755536797; x=1756141597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2iT+OSwu/o+q7or9X7skDkQLBASb9/+W0LldLqelFY=;
        b=wvmSdw77pK+Ezlj2xbgAKIFGe+mo6/5eI4domDrN/6ZdddVxh4ycbxuGYlPF12n27l
         X7zbohiuhTp8L70RHl+5d/kL4pO72Fb2jFDgVLGwprmF01PLltFVo4+ODUysZfDK2e2I
         3zTFh+fxNwH2LTJBfa8Ch1J3MCVzlCKTPCkbbfr/lUCcJQ/SC0bUcGpej7Hawebz+CI7
         5pbPfhloJxGVF+HqfYhckDHLwdYn7sQmNUnjUdF1sl6ExgdWsm8+Ji8NCPPCrCSbBwRg
         LJvNyRyAZOvDWgyjEZlwOlORRaUDrbBOy3wTOtyK7Skf4+YKKxHxNsdO1msqHDUfRUiN
         WL3g==
X-Forwarded-Encrypted: i=1; AJvYcCVnPAIZRSpWIqop+aHN28Zs5qFg3ZWuqOSOgLtQQLdJfa1h8UpC0t6dlS2iUOMGPmo2kUyhr+Hw9V1R3qu7@vger.kernel.org, AJvYcCWdkU6leWcOMk0aPDKqoVyYdOT5fmfCdpeAC7ihukm8oN189CfDdD0pLzwMxKPYozTYvBwPJQZC4lTg@vger.kernel.org
X-Gm-Message-State: AOJu0YyJHOUSsFlr9q7lTNF1V+u0vmizMv0ccT9kg3YlM0+00uNQVXY0
	Jp3QEatua4LoWprGh0l+VZ47OcNmGfMgQGzZu7csgxqD4M7QJbwFtF65sovmSq0WRDezCApORUu
	QwkVBZXysBGRawYR4qLZgMupjxmOQWPs=
X-Gm-Gg: ASbGncsJAfeVd/zBbvw2+gtrSQIQy0TQymLB9woFUM9OTTSALg3Bi2Xa30y2Wrqbyr1
	fZ2leftpoI1VQwlAYESlrtosudkId+mkxTPCfAtFv7CorKcUMyELSwGHpWVfCyIikQLnEtVbm2P
	MndkKpPOjxn2z4y9nLGTDQoTpLZ7+oat3UrzlmlOguH8SbX+10mmudmT1VCze3jzvPWAfX49rBx
	mbV+xIvSqJIRm2xoZ4qlEL7E48TyQamZIIcz5Zn
X-Google-Smtp-Source: AGHT+IF/QJMrEMQPzbBzY7vIb+Foj7ppMLAxdjKItoT5nJURBlPzhQEPywwfYC0zUOFLILvb5DAoYAXceHbyA8KuDw0=
X-Received: by 2002:a05:6a20:7fa0:b0:240:16ef:ec16 with SMTP id
 adf61e73a8af0-240d3039127mr20713868637.46.1755536796853; Mon, 18 Aug 2025
 10:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818162445.1317670-1-mmyangfl@gmail.com> <20250818162445.1317670-2-mmyangfl@gmail.com>
 <7c4bc4cc-61d5-40ce-b0d5-c47072ee2f16@lunn.ch>
In-Reply-To: <7c4bc4cc-61d5-40ce-b0d5-c47072ee2f16@lunn.ch>
From: Yangfl <mmyangfl@gmail.com>
Date: Tue, 19 Aug 2025 01:06:00 +0800
X-Gm-Features: Ac12FXwuLvpC8LuxwEme6O2C7yqhVBT8YF_nKHQpnyOKfjL8_3O9E7iinwjGlH0
Message-ID: <CAAXyoMP9aoSbDkSJhSDJ68-F6qubeVmV08YgvQS1cTKJYS-spw@mail.gmail.com>
Subject: Re: [net-next v4 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm
 YT921x switch support
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 12:55=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> > +  motorcomm,switch-id:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      Value selected by Pin SWITCH_ID_1 / SWITCH_ID_0.
> > +
> > +      Up to 4 chips can share the same MII port ('reg' in DT) by givin=
g
> > +      different SWITCH_ID values. The default value should work if onl=
y one chip
> > +      is present.
> > +    enum: [0, 1, 2, 3]
> > +    default: 0
>
> It is like getting blood from a stone.
>
> So what you are saying is that you have:
>
>     mdio {
>         #address-cells =3D <1>;
>         #size-cells =3D <0>;
>
>         switch@1d {
>             compatible =3D "motorcomm,yt9215";
>             /* default 0x1d, alternate 0x0 */
>             reg =3D <0x1d>;
>             motorcomm,switch-id =3D <0>;
>             reset-gpios =3D <&tlmm 39 GPIO_ACTIVE_LOW>;
> ...
>         }
>
>         switch@1d {
>             compatible =3D "motorcomm,yt9215";
>             reg =3D <0x1d>;
>             motorcomm,switch-id =3D <1>;
>             reset-gpios =3D <&tlmm 39 GPIO_ACTIVE_LOW>;
> ...
>         }
>
>         switch@1d {
>             compatible =3D "motorcomm,yt9215";
>             reg =3D <0x1d>;
>             motorcomm,switch-id =3D <2>;
>             reset-gpios =3D <&tlmm 39 GPIO_ACTIVE_LOW>;
> ...
>         }
>     }
>
> Have you tested this? My _guess_ is, it does not work.
>
> I'm not even sure DT allows you to have the same reg multiple times on
> one bus.
>
> I'm pretty sure the MDIO core does not allow multiple devices on one
> MDIO address. Each device is represented by a struct
> mdio_device. struct mii_bus has an array of 32 of these, one per
> address on the bus. You cannot have 4 of them for one address.
>
>     Andrew
>
> ---
> pw-bot: cr

Of course I cannot test this, since I only have a stock device, as
mentioned in patch 3.

But I think this is what the vendor wants to do, if I got it right
from the datasheet.

If this is not acceptable anyway, I might as well remove switch-id
completely since I doubt if anyone would concat more than one switch
together in real world.

