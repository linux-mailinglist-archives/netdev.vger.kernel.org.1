Return-Path: <netdev+bounces-194749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B10ACC40E
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 12:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 357C47A16B9
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F8D1C3306;
	Tue,  3 Jun 2025 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONSM1g9R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4725826290;
	Tue,  3 Jun 2025 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748945558; cv=none; b=oh1nmB0PbMATvS8Y833KK4s9MOF9jKqC177hhqeCOVevzxgnP635IKhtJKgDv8LzEWTqdl8yIrbZOA0rqblY0wJSVXlfL6iXO/8IqxxF466dmIneT/lamu+9Q5Fh5na1CjjnNz52JySqi9D9NE8Rdfv3Io2jP8ju8QtR7QET+LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748945558; c=relaxed/simple;
	bh=fb+1aoVEIY3lvgFvicVgPsuZu53K3kj2915ek084rRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeAhySFfdfrvxsXC1HEJTreYG9Y/n/T0kqNTe3suQcofousGH4f/fls2fUstDpVs94hEM5bu9dZFnGwQoZF+kxbK0RfiS4VktGqaTCRIoY7Be8ATvr3rW/qa+UQlyiwcq56sbNYnP32PlfcNLbepKRcMOXK+h6PjzPkkZrOFr7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONSM1g9R; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b26f01c638fso4851208a12.1;
        Tue, 03 Jun 2025 03:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748945556; x=1749550356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MxnhBc+O3vpHmBRAaLCl1aOvgfUSOP4JyB4k/c7duo=;
        b=ONSM1g9Rn7kFaOQcfHk8KQIXoQwdpDOQvAszp3Yl8TsU2ESKUTquk5O3wEihRk0v7F
         dlgr6dYMelz8Ld0r3SUWb0+676PBsVHmlLdLyaMwtsmbHavoy9sVKGcVmVRsxTdqOkvh
         kFJ5T5WmxllyyKzxzEre2BcNBPy7MvzAuSJXBhiLgkPk2+wB29bDjXjZQetPkCAivlVA
         YRf6YBYou4wVmJioZ2Jmh02cwN8GNmi7pl+tQNnq4sCXijKxj483aWeWriA2jFlMig2G
         WIDeQf2ijxYTbqj5FHjQNstdIaRuz7Tt/rkbkLxDTUHPQyO2zXUeVxk2PpnbauWqZOe9
         NAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748945556; x=1749550356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MxnhBc+O3vpHmBRAaLCl1aOvgfUSOP4JyB4k/c7duo=;
        b=oqEmc1dum6xPVbbyFEcRY258Fq+cFs30NpvGppyL8kHDVWk4JA7t6QZ/fcy5rmpJFo
         HXGXHjSAP0HncKJ6AVAjHXjupHrsjH49mNJRe9SnZ6sQDwPsmZepdx6R5Lpwh4tbLra7
         ZKKV4L2ksXlp+8knonO4jI9emwUIyeFbBGd+9mOPW/vPpyOt/gTIjNlpwZeok5oWqbDZ
         HxCgKMD1VKKEyAtR3aVuvMBKkt1mXFaYPIx5zotljDb3DwjIO1vfwxthGBKY54nH6Yay
         YHH54igIBQBxkTkBMPJtrX5gFPDxNg8I0f0bOiAC5/+HXQkeDxIjd53fXUFpC9qf6Ue7
         kp9g==
X-Forwarded-Encrypted: i=1; AJvYcCUt9nLLWVHok5/aIWDLTF74UvWnuhc8XsZ6ecLm2/NJv2lrxk2on+Y8tOL4YLGBJWKmDwO3gUrSxHqnVP4=@vger.kernel.org, AJvYcCVRNrGqqcXe80feIdJm3EPjlAQpCM0rkn8ah6tZ4zMYmu5AV4B4zRqD1stcAe3g6jn1Xwx9z5OA@vger.kernel.org
X-Gm-Message-State: AOJu0YwYHxbgISZi4hesxw18x/BjB+HMHn7M0bBEOlmLE90N+iuCJ2Tn
	Ef6ENuotDUhYOyNMEF5F3CBPNeS2l/eX4vDv9ITdHNDseYvLg+GD199iFCxaSxWTM4kjR6CjQFv
	FrNK4LT2u+x4JX2e9YjxA6hQnMzhZSh8=
X-Gm-Gg: ASbGncs9m5SzWMsypr6oatxF10cf/HKWUIxrTX6lTf1IPTqiPGSW0cu8AmvlmBtSlqD
	/nY7wYojWUJmPDP8+l1VScl9PdQhaQrsQSnj+V4pVeb4HU5Vk6TCKx1JBY/KHNDXV2Nm+n7ePB5
	PVnGPet9u57CTnvhjPsPwtLcFyG4Ryd53+7Ve8P4Lht661fq8rYE7BxHTTvb6mKFx6ECw=
X-Google-Smtp-Source: AGHT+IGdrSQjP4rJ8T/Sa2miwSpApd88R5Td7U6KQDGe3xw3mMPJJkK3NjL8KmDWn2w5uF+kr6yqXS0rcElvgAO2dgY=
X-Received: by 2002:a17:90b:2dc7:b0:311:c939:c84a with SMTP id
 98e67ed59e1d1-3127c6ec095mr20445724a91.15.1748945556376; Tue, 03 Jun 2025
 03:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531101308.155757-1-noltari@gmail.com> <20250531101308.155757-10-noltari@gmail.com>
 <455d5122-7716-4323-b712-9a7d84063c0c@broadcom.com>
In-Reply-To: <455d5122-7716-4323-b712-9a7d84063c0c@broadcom.com>
From: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date: Tue, 3 Jun 2025 12:12:03 +0200
X-Gm-Features: AX0GCFshSXcSsBhqGSUlWkOAp_xe8ImHNIAwihgvNfHTL013-EJ0y_m3uSttTJU
Message-ID: <CAKR-sGcqVv8LO2sqE-wsh5As=9f+s1EcaVcMF264RafdWVVkdg@mail.gmail.com>
Subject: Re: [RFC PATCH 09/10] net: dsa: b53: fix b53_imp_vlan_setup for BCM5325
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vivien.didelot@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,

El lun, 2 jun 2025 a las 20:11, Florian Fainelli
(<florian.fainelli@broadcom.com>) escribi=C3=B3:
>
> On 5/31/25 03:13, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> > CPU port should be B53_CPU_PORT instead of B53_CPU_PORT_25 for
> > B53_PVLAN_PORT_MASK register.
> >
> > Fixes: ff39c2d68679 ("net: dsa: b53: Add bridge support")
> > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> > ---
> >   drivers/net/dsa/b53/b53_common.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53=
_common.c
> > index d5216ea2c984..802020eaea44 100644
> > --- a/drivers/net/dsa/b53/b53_common.c
> > +++ b/drivers/net/dsa/b53/b53_common.c
> > @@ -543,6 +543,10 @@ void b53_imp_vlan_setup(struct dsa_switch *ds, int=
 cpu_port)
> >       unsigned int i;
> >       u16 pvlan;
> >
> > +     /* BCM5325 CPU port is at 8 */
> > +     if ((is5325(dev) || is5365(dev)) && cpu_port =3D=3D B53_CPU_PORT_=
25)
> > +             cpu_port =3D B53_CPU_PORT;
>
> Don't we get to that point only if we have invalid Device Tree settings?
> In which case wouldn't a WARN_ON() be more adequate?

I just copied the same code that's already present on b53_enable_cpu_port:
https://github.com/torvalds/linux/blob/master/drivers/net/dsa/b53/b53_commo=
n.c#L753-L755

I believe that the correct configuration should have the CPU port at
#5, but certain registers expect it at #8:
https://github.com/openwrt/openwrt/blob/cc5421128e44effd5df05227cec4d4c5d05=
be8dc/target/linux/bmips/dts/bcm6358-huawei-hg556a-b.dts#L155-L204

> --
> Florian

Best regards,
=C3=81lvaro.

