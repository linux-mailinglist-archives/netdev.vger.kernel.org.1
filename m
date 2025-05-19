Return-Path: <netdev+bounces-191618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B61ABC7F8
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F4D4A0455
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 19:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B657A1E3DFD;
	Mon, 19 May 2025 19:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bm3RM7PE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF541991CD;
	Mon, 19 May 2025 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747683870; cv=none; b=k0lVK4WF7YCRnoGDBcSHiZvw7WyzCvO4kR7UtYfGY9bS4H2R+jgsFhBON1h+grRd3UuD8BMpvj6Iz4vHvwGsYFlUIuzkbhJzpJuet6uWdOzgWVB1K5/MQz0nNErqvbCyhIxPEZ+i4oqdk8/dICCPU1eNZOjpb8JGPGRqbsi6e0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747683870; c=relaxed/simple;
	bh=0BG2qTSny/9bII3Psc/rWo5mu8gwi70viyUPWHe/yPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+QaY6cu3dV6SRR82F0I9MT0bWEDHG4g2DFMNs8FnPceoooKklxT7au7gnuq/aNuCa02A2Xx8ImSg7mQH8IEe25vFH3EUBS7s28j4mVhxRmovH6Jmo/cYufa0+OAqv0q+XAZSfiXBGTNNwotDClq5JrwVnfuxw53zNsPTWVD1H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bm3RM7PE; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70b4e497d96so44088077b3.2;
        Mon, 19 May 2025 12:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747683868; x=1748288668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6JuoPzobTHCt5OKsq1o9KXqnjSQ3QfWMyTRzXfyFpc=;
        b=bm3RM7PE2ajml+4ysTbQygeM1IsAB0JR1aVxN9DR0Pzx7Y2N/innlRvldr1U+aqAGX
         ZFJKBhfp4V5XGGk8Xv/T8nm2UO5cwnT1Br1EZgjdDlzxKBxiaaOBwoawpdCdcTLENkY/
         cb0tUtP6YKwQHfZ57luZ+cXnh/b8BHJmfRg3LLns/L7hQQGB9j0J3lQR/8vemb8S+Ntv
         VkAJ2tlxUj89/p/hq+HsqszoIJjaPDBYMtZd/M8YLQ7ozT2L1sN9BKmU4mHqkVuPGKrd
         t4wCahPys8EJy9Wr2gIZtheVK1sUVcjMWb3WaGdSjbTkkdIiHUj1jNFc4eBVaRmk0SWh
         Zr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747683868; x=1748288668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6JuoPzobTHCt5OKsq1o9KXqnjSQ3QfWMyTRzXfyFpc=;
        b=cCBARDlg4slA9QEpxsXSPBfn0TlIShunNLWMzdN1zzTRDPF3+OyzCi1I1TfLQXF9iX
         XBKGGrDIV4uzqW70+QpMGRB5EUGg8HSO0Y7vXk6DmYLGDVS92xIpPZg9U17xEqsVL9Cc
         2VQdPX1VAIiqY3LxsKc+BpMnNR6jno2DHkE2q8u+jnqOmrf3JxRiP6dQhC0LhCdYvOSu
         SJcHHDLZuIKyVyodulGx1M6NWpnalJQ2i0nbVhJTfNWTbzbOwbufA07vHnvWPOqagfk7
         S07KnxCxxzHJOW/mnlc8FvUDcAue78XLOQn0vgjpN/ZlNQsf0M+C7m6ncoAPEpUMrgoT
         tAjg==
X-Forwarded-Encrypted: i=1; AJvYcCVwonr93JSp3DnlHNAIgqiV/+bebBdsS5rvYnjZhYAMjpDuYTXII6+EzwPuX9JTuMSZvKK9RkaMbyhpnS0=@vger.kernel.org, AJvYcCWO0LHhupSPyZPvdcmnrcSCcVew50mpP9IkQU1OMYum50v/6gAnA5cfQgQ6u9H/n0PuIf2fQ6FR@vger.kernel.org
X-Gm-Message-State: AOJu0YzwTnrqnqFWcc7wFH81fRfehmawEUIFJxA8WbDhrpzNPbPAmivw
	DRM+ZmlTR/Wy2pN3JlsnUFC7CRpGfmUcxhMWVyy2vBNEMTSLBNXzO3lPEzTzOwWF8Ky0b0UATut
	3p/JqP5+kreHIYlnrf6cgmudpQH80Vt0=
X-Gm-Gg: ASbGncuHZnpInw5RMYnf1fWCTh62vGGffEm9nYcbTNpbo4WsJVUxAjAXcuM2mEOfz4d
	s0jrSBaRzaq5mpGJGbIZgFSZf5tEI4c4ypQzgy5h+aLUFAxfzBgekmQilMRdzIk1zMXvbSHcNc/
	r5hmadcFnNmPPFCR6UmJj8aYnvocmvqUI=
X-Google-Smtp-Source: AGHT+IGkS2OyWTwUaOWgoLBVAvePUKrbimRSkNgSwJAQZY+icmmpIK7UzI6GaxFBRn28Ch73962y5SvZa22H3pGfxfI=
X-Received: by 2002:a05:690c:4b8f:b0:702:72e3:1cb6 with SMTP id
 00721157ae682-70ca7b7eaf5mr210167127b3.26.1747683867797; Mon, 19 May 2025
 12:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519174550.1486064-1-jonas.gorski@gmail.com>
 <20250519174550.1486064-3-jonas.gorski@gmail.com> <ed75677c-c3fb-41d1-a2cd-dd84d224ffe3@lunn.ch>
In-Reply-To: <ed75677c-c3fb-41d1-a2cd-dd84d224ffe3@lunn.ch>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 19 May 2025 21:44:16 +0200
X-Gm-Features: AX0GCFtFITqyu-CNwfAYSvS_C8kUE8gqY-RKfGoxIRCVc5wh5DOtOZFIUS_xD9o
Message-ID: <CAOiHx=nwbs7030GKZHLc6Pc6LA6Hqq0NYfNSt=3zOgnj5zpAYQ@mail.gmail.com>
Subject: Re: [PATCH net 2/3] net: dsa: b53: fix configuring RGMII delay on bcm63xx
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vivien Didelot <vivien.didelot@gmail.com>, =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 9:14=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, May 19, 2025 at 07:45:49PM +0200, Jonas Gorski wrote:
> > The RGMII delay type of the PHY interface is intended for the PHY, not
> > the MAC, so we need to configure the opposite. Else we double the delay
> > or don't add one at all if the PHY also supports configuring delays.
> >
> > Additionally, we need to enable RGMII_CTRL_TIMING_SEL for the delay
> > actually being effective.
> >
> > Fixes e.g. BCM54612E connected on RGMII ports that also configures RGMI=
I
> > delays in its driver.
>
> We have to be careful here not to cause regressions. It might be
> wrong, but are there systems using this which actually work? Does this
> change break them?

The only user (of bcm63xx and b53 dsa) I am aware of is OpenWrt, and
we are capable of updating our dts files in case they were using
broken configuration. Though having PHYs on the RGMII ports is a very
rare configuration, and usually there is switch connected with a fixed
link, so likely the issue was never detected.

> >
> > Fixes: ce3bf94871f7 ("net: dsa: b53: add support for BCM63xx RGMIIs")
> > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> > ---
> >  drivers/net/dsa/b53/b53_common.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53=
_common.c
> > index a316f8c01d0a..b00975189dab 100644
> > --- a/drivers/net/dsa/b53/b53_common.c
> > +++ b/drivers/net/dsa/b53/b53_common.c
> > @@ -1328,19 +1328,19 @@ static void b53_adjust_63xx_rgmii(struct dsa_sw=
itch *ds, int port,
> >
> >       switch (interface) {
> >       case PHY_INTERFACE_MODE_RGMII_ID:
> > -             rgmii_ctrl |=3D (RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC)=
;
> > +             rgmii_ctrl &=3D ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC=
);
> >               break;
> >       case PHY_INTERFACE_MODE_RGMII_RXID:
> > -             rgmii_ctrl &=3D ~(RGMII_CTRL_DLL_TXC);
> > -             rgmii_ctrl |=3D RGMII_CTRL_DLL_RXC;
> > +             rgmii_ctrl |=3D RGMII_CTRL_DLL_TXC;
> > +             rgmii_ctrl &=3D ~RGMII_CTRL_DLL_RXC;
> >               break;
> >       case PHY_INTERFACE_MODE_RGMII_TXID:
> > -             rgmii_ctrl &=3D ~(RGMII_CTRL_DLL_RXC);
> > -             rgmii_ctrl |=3D RGMII_CTRL_DLL_TXC;
> > +             rgmii_ctrl |=3D RGMII_CTRL_DLL_RXC;
> > +             rgmii_ctrl &=3D ~RGMII_CTRL_DLL_TXC;
> >               break;
> >       case PHY_INTERFACE_MODE_RGMII:
> >       default:
> > -             rgmii_ctrl &=3D ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC=
);
> > +             rgmii_ctrl |=3D RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC;
> >               break;
>
> These changes look wrong. There is more background here:
>
> https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/devicetre=
e/bindings/net/ethernet-controller.yaml#L287

This is what makes it work for me (I tested all four modes, rgmii,
rgmii-id, rgmii-txid and rgmii-rxid). Without this change, b53 will
configure the same delays on the MAC layer as the PHY driver (bcm54xx,
https://elixir.bootlin.com/linux/v6.15-rc7/source/drivers/net/phy/broadcom.=
c#L73
), which breaks connectivity at least for me.

E.g. with a phy-mode of "rgmii-id", both b53 and the PHY driver would
enable rx and tx delays, causing the delays to be 4 ns instead of 2
ns. So I don't see how this could have ever worked.

Also note that b53_adjust_531x5_rgmii()
https://elixir.bootlin.com/linux/v6.15-rc7/source/drivers/net/dsa/b53/b53_c=
ommon.c#L1360
already behaves that way, this just makes bcm63xx now work the same
(so these functions could now even be merged).

I did see the part where the document says the MAC driver is supposed
to change the phy mode, but I haven't really found out how I am
supposed to do that within phylink/dsa, since it never passes any phy
modes to any PHYs anywhere, just reports what it supports, then
phylink tells it what to configure AFAICT.

Best regards,
Jonas

