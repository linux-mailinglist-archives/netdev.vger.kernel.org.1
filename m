Return-Path: <netdev+bounces-238995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21033C61E53
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 23:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23E7D35E61A
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 22:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA2227B327;
	Sun, 16 Nov 2025 22:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkQGLN0t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C232765DC
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763331089; cv=none; b=YYALSkIsrzhIODk/SWS4euWK7kXusEx0ilE4eGCBtD4LgRUePxGVO3zAz95ysq7eoZaCXaQYR4XOdvMuDg8C79NhR9WgYx0+vGKqrnXQtiMHilrUSx5rNIYaQD/SKdNB7wY5+Qj4CPOmBnxAFQHn30e7sFKraMCPwM1WMo0q7gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763331089; c=relaxed/simple;
	bh=KhDCJ/pLIn3JxyfWNW6sK/V3iecihT9sXFGu4MgKHv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ix5/FLzBE0dmK8AHAILN6uFQIWKkWEgg3CmIhIo+7IztHAghmKQ7hAzq470hgK7TNOvZiZFHjDnfCFKz6IBXofNZ4lvLPP0Nojrdd0tqac/3N9UWaBaeswjCqXWVY8jPW0nY+5hqIzLflCo2c9NWk2uFuWvglAiF942oVUV7L80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkQGLN0t; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5942bac322dso3393392e87.0
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 14:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763331086; x=1763935886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23pD2xaaXKb6Se4PHwl6ns1fAITw5VZfnMrrAf2mf0k=;
        b=YkQGLN0tr2/kUpPx8EufBUdgVy3SxGyw7BZjeTq2i2IMCx92d96veatJI4BoaMaF0U
         f8U++QY28vlYJmzYKX1cDKGXGKbvmYDDYdlw8MCrhBThVAG6EtIiSbGiqnGTHU+FwmsT
         CxMXAVbC6ErQsxE2aRs6unAwL/VBqI+6XT4YW+ZwdgCKqs2rreYOBCjoLhQOJ5I0LcOs
         ZteLK6w5+szbG8qWaY0GYewZ/ARGazfBXV6qETEkFRLuZsmMzvkw/IIU00fRcB+hwhw+
         ipITe9xvhrSVZMFPpS4cahtLmsJAVoSa3gwj2JQFQL2Kblgcf5eB0zwI5LSjUaMXoU+B
         Dd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763331086; x=1763935886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=23pD2xaaXKb6Se4PHwl6ns1fAITw5VZfnMrrAf2mf0k=;
        b=i16HAS2TnKCXEXevS/OsEy8zmQzo62BTKk1esS6Zh+naSh81pyMSrFIYloeeZKuC3y
         4vNLJ/xf3HaXCZxxSNeS1om+Sa6ixbG5XZuZYyWGSBw5HImaUOhypdrgh9+v+TPKzwvj
         V+xkv3QWlEQfo2+u4EOZ7KOCTNsPKTPzLJSkLoHorsLbw+E8hODDUreoamqPDDG1zd6Y
         rJa7v0nOFtVB+L75JTDF+GAuMPI+HUT1kBaEuGy6dQBC64AsiX+kgME9GvCY4L7q1mr3
         oXQG5/dDtl5YSmcM0qdrPO2cl+QavvzC+R8DbtMP/mqNDavytUis2e9RPqVKp/jcZkJb
         0nrg==
X-Forwarded-Encrypted: i=1; AJvYcCVjEmIK2kLGNYt03DDclcWVUmdkxAcrz2GRFxEXtQDQbHwY5jm4EuebrDC93vKBBxMnhnc4Xpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEUFJWRl7HeTHPvVOGOUC1u9tzdPPPJi0rWWTapnx9eic3KK5E
	3dsHnYugi9REBwvTazqjVEHT6/0dFfixmJjVV/Lf9wKkQFu7L7Y++lCjVoJi0FrAar635FZZ+Py
	r/sXPEPp+y15YjKSSGGgVRSLOieYsq04=
X-Gm-Gg: ASbGnctZTAOTXuzCOL8Ce3aPZnEYH174h7+uLpyC1w1faZU/WZMLltvUQTgUGmlIUvO
	EZC9Vrh1sEmTU8+nQw7whvW+n+8heiJNLQW5zROldV8NP/HpyO/74ajnsrirpy0DFLgaoOZMq0f
	St1rP2ObvDGQjQq1gvsmTHSDUq+myCfQwOeaDdv6mIhD3JDhAZObeDMIP0jnpIWAatbaZSM7AVm
	bA4goQOcTgbFlsNHMsKbX22rrQbZobjbJaf0R1paSL/HnAp1cGnQR5F2IozbvptFZ2mbx2fmkbj
	tI4dXW1OwXYlz1gLp2kUh+VWwHQ=
X-Google-Smtp-Source: AGHT+IEja6RJdMtIVd79SKCFT0xVc8fZxs16Y088Oigq3h3zotRH1aM1akdC0vqBlMgTBjNXu2bHxOPzl7LRfm8Gm1g=
X-Received: by 2002:a05:6512:3b1e:b0:58b:8f:2cf3 with SMTP id
 2adb3069b0e04-595841bb1a3mr2850063e87.21.1763331085653; Sun, 16 Nov 2025
 14:11:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116154824.3799310-1-festevam@gmail.com> <aRoFB3MunCS-_Qvl@shell.armlinux.org.uk>
In-Reply-To: <aRoFB3MunCS-_Qvl@shell.armlinux.org.uk>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 16 Nov 2025 19:11:14 -0300
X-Gm-Features: AWmQ_bl2j7JBYUo3kzRYuGsCYp3kT51WTNAVkDkT6sac0xXlNnsWmSbGDMmHZqY
Message-ID: <CAOMZO5AsTFLL+Q6qwwi+eftb4ZpVnrmX5rLTz9n5gUhhf26B7A@mail.gmail.com>
Subject: Re: [PATCH net] net: phy: smsc: Skip soft reset when a hardware reset
 GPIO is provided
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: kuba@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	manfred.schlaegl@ginzinger.com, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, f.fainelli@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 2:08=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:

> > +             /* reset the phy */
>
> This would be a more useful comment here:
>
>                 /* The LAN7820 datasheet states that a soft reset causes
>                  * the PHY to reconfigure according to the MODE bits in
>                  * MII_LAN83C185_SPECIAL_MODES. Thus, a soft reset is
>                  * necessary for the above write to take effect.
>                  */
>
> Please also insert a blank line prior to the comment to make the code
> more readable.

Thanks, this is much better indeed.

>
> > +             return genphy_soft_reset(phydev);
> >       }
> >
> > -     /* reset the phy */
> > +     /* If the reset-gpios property exists, hardware reset will be
> > +      * performed by the MDIO core, so do NOT issue a soft reset here.
> > +      */
> > +     if (priv->reset_gpio)
> > +             return 0;
>
> Have you tried adding a 1ms delay before the soft reset, in case the
> hard reset hasn't completed?

I can try it. Actually, I don't have physical access to the board, so
I need to ask someone to test it for me.

> As Andrew's feedback states to the thread that we were discussing it
> (and now we have a forked discussion which is far from ideal) we
> still don't know "why" the PHY is failing, and without knowing why,
> we don't know whether someone else will run into the same issue and
> end up patching the kernel in a different way (e.g. the network
> driver.)

It seems that it is the i.MX6Q MAC that is failing, not the LAN8720.

After the hardware reset via GPIO, the LAN8720 generates a stable
50MHz clock to the i.MX6Q ENET_REF_CLK pin.

After the software reset is triggered, the following happens as per
the LAN8720 datasheet:

"For the first 16us after coming out of reset, the RMII interface will
run at 2.5 MHz. After this time, it will switch
to 25 MHz if auto-negotiation is enabled."

This glitch in the ENET_REF_CLK confuses the MAC, causing CRC and packet lo=
ss.

That's why avoiding the software reset in the case the LAN8720 is
driving the clock to i.MX6Q helps.

