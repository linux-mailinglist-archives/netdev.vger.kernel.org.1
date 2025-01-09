Return-Path: <netdev+bounces-156856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84379A0807E
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 20:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B470167944
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3201ACED5;
	Thu,  9 Jan 2025 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="znTBC2fS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228ED18F2D8
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736450019; cv=none; b=A2GPH7da1x9adZHQK76Ie2/QG91aT4agWEgwq62hdcjLuWqdUc93OBsVr8KP5K7vGkoQHEC0IBvD75t9Cw/24pvkQ4lY1+TshQeCqzXdEvaxubgfxSUnBriZzwsSFl8nKU07xF6ers7ZmUwDSuPLLra4Zo7/vJJNGI/CHYhI3sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736450019; c=relaxed/simple;
	bh=cWNNTMwUiPUk++b12RZwvCqXJ/+tQYofDL5bp/qsJDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLfQF6Ig9hL57K1QtGHaE1IT3SED5HqlZ0cLTUna8ujfm0F3C2n61hjXNA/NN3Wi0SFKkxyRo5FQzyOj4xE/GIFKQVERi2mcxnA6YVgRFCYS9Q3YItRoVnRyGRrOAQrf8sAVrG2YHpkxTKpp2dqmmYxr7395Kz5rN38VZckd8d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=znTBC2fS; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844ce213af6so37293539f.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 11:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736450017; x=1737054817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4WzP5HtNir+r7CeRdJh0bMItnEqgcGYq4xqfQEUm3Y=;
        b=znTBC2fSexamaCqLfDrIJ0lr5UX5J6AoIZRQphtqBvgnDzAcRdyPmqrJtS5eB9TF4j
         isJfC12kRdRo1XGYQIRbPi5t4vQrjGe2iWSu95fGyQPMDKMzGwaIU7rjM2svqz6A1Mvk
         PI7y1e3CuVFz3yaL/LrGMv4Su2yF4uCm0k+gIBPN6T4uYx8t8BLnEFZ2gwsSwzOOQ5FN
         FK3PgyXk7SRiavoHZSrK40gwmny8sFwF9EcXbHz00VReE8AzQUVo3PHUBChcWOUxw+Ta
         nQkJofJt9NyOEla00sMHuPR2Cey52RdLf213+i5NZHF2PYswlkE8ZkVEvkaHqETEkdP5
         N9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736450017; x=1737054817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4WzP5HtNir+r7CeRdJh0bMItnEqgcGYq4xqfQEUm3Y=;
        b=T9YHCAEsU3kn8LU5C1T5kxJOGAR0UGcaJBQcv/0josU5P5CQmpZhI2plTgorITxq1Q
         ModxDIImqc1v0geCOUlqx8nHNU5VS5kB9FUSxU00YGGrZwYyN1WDrriw3WD5OKLhqDjr
         DA/awbpBSgLKD/x8eNuehsuJVEvZXwaHuqN0/DIAUhbKonf8tAG8KiyNPTVe+5e+DRNC
         1vJ3wmrvTX55cFNj/Z7qMZQ9m1NoOZJJr4fQGOrRGQ7C6Q8MPe9BQ5ZEkofO4EEhQ2Cf
         KxKisxxQoijV4mrqITv/SziD3tBJAqqFEc/3ljoeXcgHGShGKbs3OTUYUnkD1lv+IALk
         US4g==
X-Forwarded-Encrypted: i=1; AJvYcCXFp5VPfKCtb9FD6DfhdTIneqfFyh5yRQUfZdQ79fv6MzLOsHYkT2Pl+x291/vUtNAydncrRa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy73qUx8YvvKfV/pLbldxI9Fxz2ne23jNZmdRdtzZ2H7A87DV1o
	zHf+N85aPII3rrzY3WHqo0fBCygNC01yjDnUx43FGz7nULPHb23AU/6DYTyIbXwhI2rjcdQoXqO
	RRxMew2Ifld1yFc9hylKzKUPcsc6GSRPvHIyY
X-Gm-Gg: ASbGncsEPwZLgDxWwifzx2CFB8zKixcPmsQYbi58mVkWzlb5pGBm0RWUvOnKOlEupG6
	K5NZ3BvMFbmaYCu2t95sdPnV/ANSd2D1jUeUGgg==
X-Google-Smtp-Source: AGHT+IGsSvBb5NeTFEFieuFRV5HyhLeE2dx52X87sfKenFd+NyMxsYAEvI/Og3agTmlQN/UhBYvd4ItQLKLRn+UdUns=
X-Received: by 2002:a05:6e02:160e:b0:3a7:e86a:e80f with SMTP id
 e9e14a558f8ab-3ce3a9a5b0cmr70579085ab.3.1736450017111; Thu, 09 Jan 2025
 11:13:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109-sparx5-lan969x-switch-driver-5-v1-0-13d6d8451e63@microchip.com>
 <20250109-sparx5-lan969x-switch-driver-5-v1-4-13d6d8451e63@microchip.com>
In-Reply-To: <20250109-sparx5-lan969x-switch-driver-5-v1-4-13d6d8451e63@microchip.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 Jan 2025 20:13:24 +0100
X-Gm-Features: AbW1kvY541xsGK3VQ1Tx1nbW1TdevUEFbMVaEmv3muHe44ALUjGSOGu6eh99ALk
Message-ID: <CANn89iKA=ha6y0_UHUp6Pjkf0H4RevRbD-CHswdBqk0O=KkNqg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/6] net: sparx5: move SKB consumption to xmit()
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Lars Povlsen <lars.povlsen@microchip.com>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, UNGLinuxDriver@microchip.com, 
	Richard Cochran <richardcochran@gmail.com>, jensemil.schulzostergaard@microchip.com, 
	horatiu.vultur@microchip.com, jacob.e.keller@intel.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 7:38=E2=80=AFPM Daniel Machon
<daniel.machon@microchip.com> wrote:
>
> Currently, SKB's are consumed in sparx5_port_xmit_impl(), if the FDMA
> xmit() function returns NETDEV_TX_OK. In a following commit, we will ops
> out the xmit() function for lan969x support, and since lan969x is going
> to consume SKB's asynchronously, in the NAPI poll loop, we cannot
> consume SKB's in sparx5_port_xmit_impl() anymore. Therefore, move the
> call of dev_consume_skb_any() to the xmit() function.
>
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> ---
>  drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c   | 2 ++
>  drivers/net/ethernet/microchip/sparx5/sparx5_packet.c | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/driver=
s/net/ethernet/microchip/sparx5/sparx5_fdma.c
> index fdae62f557ce..cb78acd356d2 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> @@ -239,6 +239,8 @@ int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh,=
 struct sk_buff *skb)
>
>         sparx5_fdma_reload(sparx5, fdma);
>
> +       dev_consume_skb_any(skb);
> +
>         return NETDEV_TX_OK;
>  }
>
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/driv=
ers/net/ethernet/microchip/sparx5/sparx5_packet.c
> index b6f635d85820..e776fa0845c6 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
> @@ -272,7 +272,6 @@ netdev_tx_t sparx5_port_xmit_impl(struct sk_buff *skb=
, struct net_device *dev)
>             SPARX5_SKB_CB(skb)->rew_op =3D=3D IFH_REW_OP_TWO_STEP_PTP)
>                 return NETDEV_TX_OK;

If packet is freed earlier in sparx5_fdma_xmit(), you have UAF few
lines above here ..

stats->tx_bytes +=3D skb->len; // UAF
...
if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&   // UAF
SPARX5_SKB_CB(skb)->rew_op =3D=3D IFH_REW_OP_TWO_STEP_PTP)   // UAF


>
> -       dev_consume_skb_any(skb);
>         return NETDEV_TX_OK;
>  drop:
>         stats->tx_dropped++;
>
> --
> 2.34.1
>

