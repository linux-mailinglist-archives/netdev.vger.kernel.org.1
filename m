Return-Path: <netdev+bounces-188958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1F4AAF9C4
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57C21C21608
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 12:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5BF228C9D;
	Thu,  8 May 2025 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYeyukRy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16887227B95
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746707010; cv=none; b=uFzUhimI4jlrlx6jIcfPk4FlIJLg/bcgV01I5Sck2lDWF15aCw9VcGhTxGQ4OcobDYFUZi/IY3sJv9ahbduRpKjf/Yw+V2WUO44F4A+ivpps5DEUnJP0xffRsuX7PO6pgr0h/+eauPNp2DIAKUVT5e19G62hhkv2MaFAY2c0OK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746707010; c=relaxed/simple;
	bh=IJiVHfiQ/sN6BEfO7MXn+IH8AM0+CIljhV3S0beWA2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQESVVITzQrD4cdflNbDgIx/+BlJmUWcyQyo9aVVyZ0iO+MOD21riPRaqPfEcGZe6VkKBO+ztTD5zqUncQ2rYzWJB45UuZ24KV8DOEfktwtsvpiYlmFenRhtTAZC3knWKypDZ0e291Fz6X0FZOxcH+nWjyFC1LfjHruVSruOTIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYeyukRy; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-477296dce8dso10117471cf.3
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 05:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746707007; x=1747311807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYX8qqDD4JOYlfuvNPe4ZEMyg6c1lBo9WKWQB/eyoT0=;
        b=FYeyukRymg6YgXTyGyM55KWUt8uNIYZ4tyadcpBMw9G+4A3h8eM12LDyzNjkbmsQGy
         XPbw8pk3vAr4k3pPkA6HL8y2QnNb1BbbEsrlksr+QgEpn8cJA5ZJ7rtUADrOYwAjVZyR
         TD1fArrPcQzhRbNmyVnt5aFrMRfsDbr9XQVMtZFoxbKf+ktv8Vgviz9hMIBBtLHWjvRE
         qgK9zXROZYEwF4bGXb6kGMOCSPx/ve89jjHgjy6ujuSxT0Lbwbo5RXhDo7h8l8xzxnh2
         pMicahlil1VY3x1jWVlesxmrmmbHqbWrA0v2D/WPJRD7s5LiAy5FLal/0Ag6Dea0knDb
         3Cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746707007; x=1747311807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYX8qqDD4JOYlfuvNPe4ZEMyg6c1lBo9WKWQB/eyoT0=;
        b=F1WkYgYkUlkU4WGXEjRgahQlnm/H7eGUPM6jYK1XP8kPN/keM7sz2NJutnlZgUldyL
         sEWb4mHUdiMso6TYnsi6Y5yRTA+FjHLc3i1wlJRqzuez8H+QKkDO40ccNxX8BChumgHJ
         mALcnkLmbma5KdiqY0yvZkgPobp6O1RaRNWJyxuxHypSEw/sQQSfDMi+XUGpEHRUVoAj
         xeZILc1OwFOtth7pgXpj0q8HOxHY9yz/3xtMGrVk2hXLc6IrBtvD++xyeorFUAnHd/g4
         7xqbvUeqvP2U5vtHeByVPByd/dgU5vrsE7yXLoZbaVwCaGD0EelMHeL8JXkPpZGXZ6/u
         MIrA==
X-Forwarded-Encrypted: i=1; AJvYcCXGQMoCcYJx3lUXtakBeB6mv1yQKGZzHnI78oogcaDixaDd7RlssfMQCSQXoAbsQg//fEV3b+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmWd7iAuU2ADQUgvYMkAUT4MzIt0G5m0Aaz2eMnLYSPRrktLEj
	k1oaBdVTEfNAXQgsEDP8VKGtUqZKXwplBiSZpSmQhfvpZ+moKrQQnE5QwmfUiOt/2M/gpknuSgj
	TK3KreglVZGxCP4ymgEpNFa3Xh+gLwaJegCY=
X-Gm-Gg: ASbGncv4QIsIoYsBeM8+K6heM4nJpYXW6rXmHL2s+V9jqspCoaFIh0u5M8f7aGUXHOd
	lhbDl5c8u9SyuDTZ6m56t6FWMYe9Cj0RL0G4FbVH42+xKjt1mGcPUneaOqcijJPzLIUHE4hWnRp
	5a2cEzDJc0nnPCam/mvI1jAg==
X-Google-Smtp-Source: AGHT+IE+uL01gV6BnaJuogyasEEOBXMdeInFnUaS5xfQn4hQfGn/seeOu61dluwOGAXIkgHX/HPbWChIzJK/4OO/xCI=
X-Received: by 2002:a05:6e02:12ef:b0:3d9:6cb5:3be4 with SMTP id
 e9e14a558f8ab-3da7392c8d3mr79276605ab.15.1746706996046; Thu, 08 May 2025
 05:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508033328.12507-1-kerneljasonxing@gmail.com>
 <20250508033328.12507-5-kerneljasonxing@gmail.com> <20250508070700.m3bufh2q4v4llbfx@DEN-DL-M31836.microchip.com>
 <CAL+tcoCuvxfQUbzjSfk+7vPWLEqQgVK8muqkOQe+N6jQQwXfUw@mail.gmail.com> <20250508094156.kbegdd5vianotsrr@DEN-DL-M31836.microchip.com>
In-Reply-To: <20250508094156.kbegdd5vianotsrr@DEN-DL-M31836.microchip.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 8 May 2025 20:22:39 +0800
X-Gm-Features: ATxdqUF7fr2w19MfngP-Su9tvfrXMs7O2uRtM2xM9K46rrKLvtXS-sBBlIBE5e0
Message-ID: <CAL+tcoBrB05QSTQjcCS7=W3GRTC5MeGoKv=inxtQHPvmYcmVyA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 4/4] net: lan966x: generate software timestamp
 just before the doorbell
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: irusskikh@marvell.com, andrew+netdev@lunn.ch, bharat@chelsio.com, 
	ayush.sawal@chelsio.com, UNGLinuxDriver@microchip.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	sgoutham@marvell.com, willemb@google.com, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 5:44=E2=80=AFPM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
>
> The 05/08/2025 16:40, Jason Xing wrote:
> > Hi Horatiu,
>
> Hi Jason,
>
> >
> > On Thu, May 8, 2025 at 3:08=E2=80=AFPM Horatiu Vultur
> > <horatiu.vultur@microchip.com> wrote:
> > >
> > > The 05/08/2025 11:33, Jason Xing wrote:
> > > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Make sure the call of skb_tx_timestamp as close to the doorbell.
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c =
b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > > > index 502670718104..e030f23e5145 100644
> > > > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > > > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > > > @@ -730,7 +730,6 @@ int lan966x_fdma_xmit(struct sk_buff *skb, __be=
32 *ifh, struct net_device *dev)
> > > >                 }
> > > >         }
> > > >
> > > > -       skb_tx_timestamp(skb);
> > >
> > > Changing this will break the PHY timestamping because the frame gets
> > > modified in the next line, meaning that the classify function will
> > > always return PTP_CLASS_NONE.
> >
> > Sorry that I'm not that familiar with the details. I will remove it
> > from this series, but still trying to figure out what cases could be.
> >
> > Do you mean it can break when bpf prog is loaded because
> > 'skb_push(skb, IFH_LEN_BYTES);' expands the skb->data area?
>
> Well, the bpf program will check if it is a PTP frame that needs to be
> timestamp when it runs ptp_classify_raw, and as we push some data in
> front of the frame, the bpf will run from that point meaning that it
> would failed to detect the PTP frames.

Thanks for the kind reply.

It looks like how to detect depends on how the bpf prog is written?
Mostly depends on how the writer handles this data part. Even though
we don't guarantee on how to ask users/admins to write/adjust their
bpf codes, it's not that convenient for them if this patch is applied,
to be frank. I'm not pushing you to accept this patch, just curious on
"how and why". Now I can guess why you're opposed to it....

Thanks,
Jason

>
> > May I ask
> > how the modified data of skb breaks the PHY timestamping feature?
>
> If it fails to detect that it is a PTP frame, then the frame will not be
> passed to the PHY using the callback txtstamp. So the PHY will timestamp =
the
> frame but it doesn't have the frame to attach the timestamp.
>
> >
> > Thanks,
> > Jason
> >
> > >
> > > Nacked-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > >
> > > >         skb_push(skb, IFH_LEN_BYTES);
> > > >         memcpy(skb->data, ifh, IFH_LEN_BYTES);
> > > >         skb_put(skb, 4);
> > > > @@ -768,6 +767,7 @@ int lan966x_fdma_xmit(struct sk_buff *skb, __be=
32 *ifh, struct net_device *dev)
> > > >                 next_dcb_buf->ptp =3D true;
> > > >
> > > >         /* Start the transmission */
> > > > +       skb_tx_timestamp(skb);
> > > >         lan966x_fdma_tx_start(tx);
> > > >
> > > >         return NETDEV_TX_OK;
> > > > --
> > > > 2.43.5
> > > >
> > >
> > > --
> > > /Horatiu
>
> --
> /Horatiu

