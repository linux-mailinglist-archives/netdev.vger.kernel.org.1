Return-Path: <netdev+bounces-188918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B97BAAF5E9
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 10:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CF816EDE8
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 08:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FBE2222BD;
	Thu,  8 May 2025 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USdIOoaw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8206215748F
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746693685; cv=none; b=LXveIPWLTRhS5M2akKySLK1hP8c864FfSEmbLthIUiEN/dIRzEM6LCMWQm8hTe6UUfEdwUjxZlZ3nUX9m+VbFUysstJlYys6um9cosJY5bAXM0Iw6kjWfHfjEz3o4p+rRLYZPIU10/jiDCkFufpwf5FtrTesfRAkUiOcRdXJZyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746693685; c=relaxed/simple;
	bh=1u+85/yQCaFAql4dv+UvGPvxmyVDFWnbqdq21xRso1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIU215QMpR6DpTn7bl629AVrqHpSYym/RpZUpwP5SnvkcF56Qi7h+Nd0jLy3xGxxY4Eqo+6PIyLU37YMnd/+J5DMAPiS9z3X+j+i1q2l+L5mPAKapo2A1xzNwpQhHshIphqEgUgOUWvlBFNVpOg0eoP16Hx5dK8S9sNcug4M4B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USdIOoaw; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d91db4f0c3so3728115ab.3
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 01:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746693682; x=1747298482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06V0SS4xl9NrencCcbDKamANFiU6WEUFYCHR8UmLwS0=;
        b=USdIOoawzcu6H3RaIjJqghFbHcLlOdWVW8FAO/uYUfCqn0B5jDNF5fH5UCEe3T92N0
         b7eofl/1pBpwTVKbcEvyJFsDm2kzNFZNVCcVwKdDVKDqPSZK54m/f4BqKd64ZwHDv5Lt
         C5zRtHP2uCUagVYakvjsrWak19PWJuiUrVCS03QSIuceXzRK5PcdVSKUXrH6wCMoyGHi
         i9plsbi5+UW3VMlkDUMVuW9qwnT18JXg5accWOfL2/proS4exn8DeGV23RZLYP+3kPWW
         efHSOJwz/CQQt0vEodYcf5Q3rRQmTxFhxQPIf2fsKDvaNmUbqULfQBYmB6XphM2E16gZ
         x0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746693682; x=1747298482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06V0SS4xl9NrencCcbDKamANFiU6WEUFYCHR8UmLwS0=;
        b=ZZSdrsgPiEOLff5LhX2hL8dcW0DYeUExPNiCPp4kXSUYURZn4zHCiV1yh8DW1q/WV8
         4SKDyyy/50MW8AuZxT8cD/aWsnUWxk/lKeIb2tU1TcgbwCIxly7r5BAA2SEUNMK3unOw
         3DXdMwPyjLcN9+mjn3IitRZ9C/UgCmrDK/oIPn5+4rt29qKFfcIsnqEz+21zNLMyY6HY
         p6UsJCRXB8+dr7kV0SINMwt6g3PxOx6Ai8SeOPymO/jFZNbGqW53HamYIooTC0vF8g1j
         jcD9i1RZTOms+KOnK/lTwZU0S6eQndhha0nknM4OU4YUFkDUG2y041F6ml1ScUxvu9kB
         d+Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWli61F4db/aXj8a5rU5pDJk6PZHbI/Ua8Pw6lBraP3JqisC84aqU6z+1oucxhwJwnHBibAckk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPET7SBpS2gM7O9FzQGwwh04oUdH95YqXxt+VDPlOHj448z1s4
	LusWHEYWBUbweVrCe17XgnFXLEMQ7dDQPmWpKgAQjTBsTbCUI0QregKv3S43p1kRkjbw21qMG8L
	w+IkR5/dxxo2PGfrD6AONlLWiuro=
X-Gm-Gg: ASbGnctJzzbYbaqpum5+LjAob7BMGfykeqzVAnb+JpKCdqjb7G+t8w5ZLC/VLOnzU9F
	89L+zUaQq+Rsqvg0cRkgGFDdCYu+PQqVWcYQlQ9AxJtfcIX7OR36QwwXNt1pajwiVPiS1g0yt3h
	5u+zkZGaya85nyLAy/ICY+bg==
X-Google-Smtp-Source: AGHT+IEmLMp/D0QNJevDYMLRMp0mBTWELujqPt8xXnR9sEVc1PByWElS1L80M8Da1ScWVQSTQUb1nxbOD2vClVz1m7w=
X-Received: by 2002:a92:cdaf:0:b0:3d8:975:b825 with SMTP id
 e9e14a558f8ab-3da738d5b28mr76314015ab.5.1746693682592; Thu, 08 May 2025
 01:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508033328.12507-1-kerneljasonxing@gmail.com>
 <20250508033328.12507-5-kerneljasonxing@gmail.com> <20250508070700.m3bufh2q4v4llbfx@DEN-DL-M31836.microchip.com>
In-Reply-To: <20250508070700.m3bufh2q4v4llbfx@DEN-DL-M31836.microchip.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 8 May 2025 16:40:45 +0800
X-Gm-Features: ATxdqUEcxKj-NjeNAJFeUmwL48LxaGkk92YGikxUXT0m3HVba_HcMEWlVXVCuUY
Message-ID: <CAL+tcoCuvxfQUbzjSfk+7vPWLEqQgVK8muqkOQe+N6jQQwXfUw@mail.gmail.com>
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

Hi Horatiu,

On Thu, May 8, 2025 at 3:08=E2=80=AFPM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
>
> The 05/08/2025 11:33, Jason Xing wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Make sure the call of skb_tx_timestamp as close to the doorbell.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/dr=
ivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > index 502670718104..e030f23e5145 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > @@ -730,7 +730,6 @@ int lan966x_fdma_xmit(struct sk_buff *skb, __be32 *=
ifh, struct net_device *dev)
> >                 }
> >         }
> >
> > -       skb_tx_timestamp(skb);
>
> Changing this will break the PHY timestamping because the frame gets
> modified in the next line, meaning that the classify function will
> always return PTP_CLASS_NONE.

Sorry that I'm not that familiar with the details. I will remove it
from this series, but still trying to figure out what cases could be.

Do you mean it can break when bpf prog is loaded because
'skb_push(skb, IFH_LEN_BYTES);' expands the skb->data area?  May I ask
how the modified data of skb breaks the PHY timestamping feature?

Thanks,
Jason

>
> Nacked-by: Horatiu Vultur <horatiu.vultur@microchip.com>
>
> >         skb_push(skb, IFH_LEN_BYTES);
> >         memcpy(skb->data, ifh, IFH_LEN_BYTES);
> >         skb_put(skb, 4);
> > @@ -768,6 +767,7 @@ int lan966x_fdma_xmit(struct sk_buff *skb, __be32 *=
ifh, struct net_device *dev)
> >                 next_dcb_buf->ptp =3D true;
> >
> >         /* Start the transmission */
> > +       skb_tx_timestamp(skb);
> >         lan966x_fdma_tx_start(tx);
> >
> >         return NETDEV_TX_OK;
> > --
> > 2.43.5
> >
>
> --
> /Horatiu

