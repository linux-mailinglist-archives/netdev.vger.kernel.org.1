Return-Path: <netdev+bounces-238490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C0FC59A60
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 20:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF1174E9051
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D1C31A045;
	Thu, 13 Nov 2025 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjYyrZb7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FA83195E3
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060776; cv=none; b=NKJYmMTplaSeRUiCbuTxeVX3U+1KxqkEI7bKv3AZinWoihXBbdYCaOANHiGhR3JDw88lyOwoauOFQUt0tlQaH3KkPdSIvHw9wVVFJfMWh5V8iSvKJRz5mF7CRm0ZjVvhnWrjhI9kahkDPazsGIs1WyiMZGgEL2NgEQmpkvUvstw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060776; c=relaxed/simple;
	bh=Y/qJDae0edO4k+K0dyTsN5JAW0+9oSUkTYBUhCrJFqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xci/hU3VCzK15yj5fMs/HixBOyp9Fj2Gos+jaDZz3UGD4SUkob+ecZZlvEDcgo5YIT33LKxLF8l9eK/b/JIq+6jJxSH9U6ikwipGzDM34oXUKAXWFPB4Cm0YjrtGurzim7v+yFV68a7/KEQgOZvWP+a7WkjOt/ls1Q0uetB1R7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjYyrZb7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477632d9326so8553315e9.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 11:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763060773; x=1763665573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGdekgpTt91UdIPWzrNbb4Nq2jZCMcOWPkFjac+/WoA=;
        b=OjYyrZb7XdIQPB2lobb6PmX5xQTJplSMLp02Px8NSOUp3qzf153ulpvVTMvSV/hmDG
         dT5vJzJ8l1P4UWWNciofdomLeStetXYZ7S8z3a80CBYk5sHI6lMLc91/MnTXuXEz8DqO
         KnHkbLMxF/B/w0A1+FE3kvA6VNczt+VSylRQiJL7And0eTCKpuvzXkW1KM1/GfuhuVqi
         xmF50hnLQzEBOJONGPOp5OTMB2esuXn0ZpTEvNZ6h95yoLmNPRBekdbUb0Z5sQQYHO28
         Hert3tTIY3zFQ12epddIgqBiMvVsjiy6eR6InDiAFqQ4Fj5mw8FBCZ7Ld0dsQiR5OQq1
         iuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763060773; x=1763665573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XGdekgpTt91UdIPWzrNbb4Nq2jZCMcOWPkFjac+/WoA=;
        b=kHy+5+Kheagg8c5dzNse9DhfppZfGqSNL6gQXTKaMIeIqTaAOOekF7hMmi2MREoFKz
         SIvkKuEfFqDvtiPbTA+7O4FLH0bvNoGaGuxaRJuWE2/tzpGRmqz62OALswPGLj9li8Vm
         N9UJVFjNeCslxW59Bi6EzQzN0BbzsDiieyrZIQK8kqLY8xoYn00H/NIrOa4B1EQZI6Qc
         MomtqGSNFsDxHo6TUaJfsMT9U9S3TeuYXrmuzIqBDRWSMmXnlA4Kq5cPHlFc6DEa2+g8
         vBzDJq/KEUzZgV4mUkBbB87i3B97ImV7tGea0AhRp9y5LxVSfcAXGYMwwx+PwHGIMulT
         KMRw==
X-Forwarded-Encrypted: i=1; AJvYcCWml68HWzP3zYDGc+mMjkpnIxYKXDgXJsrT1kQlNI2bWaSji3aAz72cNH6JqYoM0t3CAuQdrvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Rtnobu0WsaJLNLZAhdtJmN2g0G30ErgzQi/EtHCYGrU3GleM
	a7mlVVf2o4XWFE6kwPGcH35gX7AqfcF+Kw/VEMT8aZMmVudZycEsH2ReKdCS2gz/9iNDK8YwaqY
	5kINI7Ze6R/LlvB9EwNQZWmzsrv2vndI=
X-Gm-Gg: ASbGnct0adCvMrRai2xsSb2crc2x9pqGo39i6XqjW4B/bIVT+VMRiCWL+LjvxLSEVU4
	rFsY74jXqJ1OlpEqOmLxKHiDR1VVRA2+pm8SeMNmT8DPQMrfHU/Ngbbm2nnL94r/xigQ0KljuJy
	7gicXQL8vcHe3uaWMnBMpSgD5jUVsrlgvnoG0XBEDs77g5vEoXR5dAli7U1/GeTDZMx95IzCfAu
	AEp2CmqZu80vO5dBLT0XfFp8TznqSK3yGEEkuXP68/5DcdVEb5p7ZlGJSeHSTTGBClCMZSs
X-Google-Smtp-Source: AGHT+IF6MyIJ6Ct3vYie0mDdjIrWxMn1NXyXarf1sD9pNdCcqDD+1yiJFDboSyiz7L7VDp5ccWLVd8RwNMQc/PomeEU=
X-Received: by 2002:a05:6000:2087:b0:42b:30d4:e401 with SMTP id
 ffacd0b85a97d-42b5933e396mr480118f8f.12.1763060772779; Thu, 13 Nov 2025
 11:06:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112201937.1336854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251112201937.1336854-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aRTwz5QHq9U5QbQ-@ninjato> <CA+V-a8s5fg02ZQT4tubJ46iBFtNXJRvTPp2DLJgeFnb3eMQPfg@mail.gmail.com>
 <aRYADfD8QkIw9Fnd@shell.armlinux.org.uk>
In-Reply-To: <aRYADfD8QkIw9Fnd@shell.armlinux.org.uk>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 13 Nov 2025 19:05:45 +0000
X-Gm-Features: AWmQ_bn_G7lk2p9_nHrGT-XISutiTcxO1n02vyZX182hP0iieQna-qPlaVUCc6Y
Message-ID: <CA+V-a8u5QAY2WheMxXhoHd09KTi31ZnVO2T0FmXiVWdH8x=rxA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: pcs: renesas,rzn1-miic:
 Add renesas,miic-phylink-active-low property
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Russell,

On Thu, Nov 13, 2025 at 3:58=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Nov 13, 2025 at 02:45:18PM +0000, Lad, Prabhakar wrote:
> > Hi Wolfram,
> >
> > On Wed, Nov 12, 2025 at 8:40=E2=80=AFPM Wolfram Sang
> > <wsa+renesas@sang-engineering.com> wrote:
> > >
> > > Hi Prabhakar,
> > >
> > > > Add the boolean DT property `renesas,miic-phylink-active-low` to th=
e RZN1
> > >
> > > Hmm, we already have "renesas,ether-link-active-low" in
> > > renesas,ether.yaml and renesas,etheravb.yaml. Can't we reuse that?
> > >
> > On the RZ/N1x we have the below architecture
> >
> >                                                       +----> Ethernet S=
witch
> >                                                       |           |
> >                                                       |           v
> >     MII Converter ----------------------+      GMAC (Synopsys IP)
> >                                                       |
> >                                                       +----> EtherCAT
> > Slave Controller
> >                                                       |
> >                                                       +----> SERCOS
> > Controller
>
> I'm not sure that diagram has come out correctly. If you're going to
> draw diagrams, make sure you do it using a fixed-width font. To me,
> it looks like the MII Converter is bolted to GMAC and only has one
> connection, and the GMAC has what seems to be maybe five connections.
>
Sorry when typing the diagram the mail client showed the diagram OK
but when sent everything was messed up. Ive represented now in a
different way.

                                    +-----------------------+
                                    |   MII Converter     |
                                    +-----------+-----------+
                                                    |
           +-----------------------------------------+---------------------=
----------------------+
            |                                                  |
                                               |
            v                                                 v
                                             v
 +---------------------+
+---------------------------+
+------------------------------+
 | Ethernet Switch  |                   |  EtherCAT Slave      |
            |  SERCOS Controller   |
 +---------+------------+                  |  Controller
|                   +------------------------------+
               |                                  +------------------------=
---+
               |
               v
  +-------------------------+
 |  GMAC (Synopsys  |
 |       IP)                     |
 +--------------------------+

Cheers,
Prabhakar

