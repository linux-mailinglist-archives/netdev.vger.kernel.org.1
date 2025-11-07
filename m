Return-Path: <netdev+bounces-236794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9E6C40337
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 14:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 165704F4068
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 13:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D573254A0;
	Fri,  7 Nov 2025 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQvC7A89"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E662C31D72C
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523535; cv=none; b=YexK1rWAl2ktlF5IPo3e5oExlXutyjvGlLI6FkLq42Dm80t0iCN54NbqbPWNzrhDKyP911aElof/43NqZlvxuX5ZnPBp2IFqPVwZMvmxFtH1NrX4xV7JtOQL60GuVDjVK0WFg+78dIwydLbPALFkWAQA1QWyEu2IdrOsh3q5S3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523535; c=relaxed/simple;
	bh=cvvDXx8UPJjdt9IMwE2GBb4WwAqtAb/3vY69RzeuqDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhU7aOyKwPaUy+JS3GFfv2+HrEAKmIJU+73CBTGkOqZNAPSxyWBIHxLf9pLCWczS0gAdWOyBSdLuhrMxahADXBEz5ziMbGNHV+z9rCA9JShIc/Mfmqmr6Am/kI3lhW1DBD7AqzF6DjiNu+uFd6r4mKZdFazmuXCl2oWeuhvfsZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQvC7A89; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-780fe76f457so7858317b3.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 05:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762523533; x=1763128333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBF1DSg+EQgQ2BuaBro+oEbO6pNlMjXCT3ag8XbwFt8=;
        b=gQvC7A89nRBzH3nL6fnHdxxny3nzwrL0ZZPZxLkEDEwelahShA9uIMg8x26hrO/UzG
         7ucQcKirzur08Be4bxZCdIQOkaLbG/kmXugwfzTv/t67vvzn+2u6NVpvewCmM8KLV5Cl
         iJ9+aI04NP6ZZuWrWaNXvUJV3Ci5XLlY2uxrNnSScsD8qk6icR5LNf0eQpVUiGJ5aCYc
         dN0NcsZELbUIxRgFlRGoxFlS6khUpZPSLh7cJxoFNKqIlpGUulk4DCdrTCqh+Xvesr/s
         ijrd/iZXGpcSZTqPZCHXSpBpdmso1OrLUA/jSRdg26r7rE+i13Wo65bDX3OfEsf9VZYg
         NApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523533; x=1763128333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tBF1DSg+EQgQ2BuaBro+oEbO6pNlMjXCT3ag8XbwFt8=;
        b=EmCTHN4qpnhH3roMxyh1LFU1Ihz2K/6ZOtVSTwSDMczFCWdGuTDXqtOC6v8y+IZ0QC
         m8XCsHdIQjJSja3Ye2OG5SwOf7ybY+WdvwtS2mlLvdfKLvTwDWAMbV+O+QQPK9q0dcc1
         T2OXnC6kIluijCsc1UUIpFW4lfx4+CmM80/dvYQeMXSk8N5B4289h8GiIbvPKPeLylS0
         8dG5TXVDStQGTioofB1fXhTRU3eu8+sYGWwClR1O2CCnm3Gbnc5r0S8b8WmVaBqn/IdR
         fjlpbmxQNWol827CyCmN6goz/3XYI7+WtrJFlnv52d7fksXIeuJeobmoaArdQVMNv4kw
         JnIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBLsyhwfhi1VLWf0VO20ZZ6JvzcVqTAQLrO8yUiaXYxGLBWPicjjkLMBfjgoM2ge84eARn9GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiTd0bpCG/UXNHyBvO0CqQlZ4vmPFyq0KoIhz3BhOYY3CUvBfz
	e+iVtXD4LvPgIeZ/P2ODjn4zjOxed99K1f42np/6d/jm72Wc9cJz87Xhn7K27SqttAFYuRX2aMY
	BSFOIIXtpxOOI7Iw4USsMD8RSNJF8hMs7y7qp
X-Gm-Gg: ASbGnctwrxXsSMlZgJPUZ4e+q0yK/kFVFhh5u3ehnZIrOKqcp2n0k7z/2rdBQnNgdDX
	eqrH9Yy0cZqiQBTrK4NtEY/U4+ghy6oQSI8aW0IA437pIpncTtimYwDVQyo039OW+jOeZakHChX
	tyAgkXfREu54uScVGKTAcvYz/LbBvBOTUCAVKk1Nj1l5bdgxzzxCbmA1C9XSCLluzvmE02+8MzD
	I6gqUueVGjZqaasaLRadKOfAC71q/pRfyFjQflMJ2WZD0nmL+h8o3xBQG9uF5B9yjiwGg==
X-Google-Smtp-Source: AGHT+IHC1st4dfAyqvGBs0ambY3Pr/eDSfVMrgaQxjo4fSDldfVIZM3zL4uj0D7QSPxgLZtGpNDPoRDqAIhBu8MV4xc=
X-Received: by 2002:a05:690c:48ca:b0:786:5926:ed9e with SMTP id
 00721157ae682-787c534a068mr51817197b3.25.1762523533026; Fri, 07 Nov 2025
 05:52:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107083006.44604-1-jonas.gorski@gmail.com> <ce95eb8c-0d40-464d-b729-80e1ea71051c@lunn.ch>
In-Reply-To: <ce95eb8c-0d40-464d-b729-80e1ea71051c@lunn.ch>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Fri, 7 Nov 2025 14:52:02 +0100
X-Gm-Features: AWmQ_bn3heeIea5Bztosge6ITx7JIqqwmMjMu9GeGOan3E6974da4vYuUXvphtw
Message-ID: <CAOiHx=kt+pMVJ+MCUKC3M6QeMg+gamYsnhBAHkG3b6SGEknOuw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: b53: bcm531x5: fix cpu rgmii mode interpretation
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 7, 2025 at 2:20=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +     /* Older driver versions incorrectly applied delays in
> > +      * PHY_INTERFACE_MODE_RGMII mode. In order to not break old users=
, keep
> > +      * interpreting RGMII as RGMII-ID.
> > +      */
> > +     if (interface =3D=3D PHY_INTERFACE_MODE_RGMII)
> > +             interface =3D PHY_INTERFACE_MODE_RGMII_ID;
>
> Did you look through the in kernel .dts files? How many systems does
> this effect?

I did, and the answer is 0, at least if looking at the cpu port node.
If also looking at the ethernet nodes where it is connected to it
becomes a bit unclear to me.

There is broadcom/bcm53573.dtsi defines a switch node in disabled
without any phy-mode, and all includers either delete the switch node,
or do not define any phy-mode (or phy-connection-type) either. The
ethernet node itself uses "internal".

There is allwinner/sun7i-a20-lamobo-r1.dts, which uses "rgmii-txid",
which is untouched by this patch. The ethernet interface uses "rgmii".

And there is arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts,
where a comment says that it has a BCM53134, but there is no such
node. The ethernet node uses "rgmii".

So one doesn't define one, one uses rgmii-id on the switch / phy side
and rgmii on the ethernet mac side, and one only defines the ethernet
mac side as rgmii.

Not sure what the correct move here is for the latter two, especially
since I have no hardware to test.

> I would maybe add a dev_warn() here, saying the DT blob is out of date
> and needs fixing. And fix all the in kernel .dts files.

Sure I can add a warning.

Best regards,
Jonas

