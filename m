Return-Path: <netdev+bounces-92547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD02B8B7CF6
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 18:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49FDC1F23B26
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 16:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188653E478;
	Tue, 30 Apr 2024 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2Ux0ySh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69098DF78
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494651; cv=none; b=ny3iJaUH9tJCOglFD5DJRD9r6seu5saQu9A0FLttYcV95VVpRoGIv8+X06MS0MKpr4o2wC3/S+DgbDnnuhUidfAw368MA0MdTqmy/LIOZiebo7sXn2KLTXY8IwEiojSzblymOX/WyLiMRT0nfV3K1mYiY+ROE3+bMH2zCSO9zh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494651; c=relaxed/simple;
	bh=A0Lu/1O8DhbFINtKT0cJNNjc9D8DLfWDWIdbKzfKaTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyMYkJ7UGuMO+QilIrBAfEFSt812s2vMlLnUwADQUj5SROF7OXsKGYuPHqopV+6M0cGHCtZ8X54U6o01lkNCHzhTMuXjPxDuCv42kLSlRyRlf7XE+W/AACMlH4rTSuG4HkeSc+7tRatM+DEX77BYdR50mwtG7wPpIrNMxMeJBZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K2Ux0ySh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5722eb4f852so31a12.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714494648; x=1715099448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+52D/aEuySi7tMUZH7OXMZV8ybUw5jAus1KxLAtcHU=;
        b=K2Ux0yShdwL2GceB4u8YhVK+WCtZ1y0ew76TKCSjrb7B1P6L/rwxYNVIVOqr6xmTcb
         mZ8sFNZvrAI/PMjqKRqwSv17i3d3g5tgeVQaosW2ZyCoUlypboDUif2t11TZVaRwaxmZ
         KdLtWiKRiDPAGc9hzYpaOq6rKc0AQ7aRNzMVBfS03G5fMGL6X5jF2AWZn+VFS/ewqChi
         DRGHzybzaU/paF6GuOTIqeTIZVNkOSnz/WIjvxTxj7wD0vssD88JgDKYUmvt0DIFqaTN
         TUrQrNCfeuQ7R+gRtDTRb84wQucktppK2nZYGLZ4RmdgpmHp//tD/wv8LzZwyTbl8lBn
         i2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494648; x=1715099448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+52D/aEuySi7tMUZH7OXMZV8ybUw5jAus1KxLAtcHU=;
        b=KpRrjKAe3nfs7kmct6/OC36ya7bTEUYKv/af9M8mkL8+cuBHUlxiVt5NXB6uPqzTvo
         mfxuWaL8FlLQhyigGPSN63YttDrz3d7a6xIJ8Hok61ElwmwDIcw8AbiEOVCFFUS6s0Ls
         KDgmubVBLuJ9hKqm+TPICr450IeKK4PU06kozx1+OE6GBP+BXBNJdztWstvIBuIvpy3H
         t+aElGO1vYxcMpZqNVnmm2LrLDIViROld/+L1GyfdhRoboTbZoirBZRSgBz19AMsI0H7
         VqLG5RcmQV2HGXL1V5lF0i4kw7aBV1mkMSLlQUqOomZcBWeMrvZm0TTCVpNRJhnyNeBz
         Saow==
X-Gm-Message-State: AOJu0YyM6VohIlAoAIgsugoIhIRMKbl0IDzKQctm0u9IssZdXAVTAZNk
	0oOX36Qyyer6aP5rzuHMzWQuTrfEh5WYUVxe5LpC6xnxSZdYKqqyhfZr/8wdidyJ2XnyzHh3J9D
	BY/2AkHAwlE30qVw4RS+eBsogsag0xW3ntlG1
X-Google-Smtp-Source: AGHT+IGDsl57P+hQ9jz7y/p9w21Efa1l7krw+ymoaN1/759o6D9Ed9TDhdu3PlTBXUKjbL6bDOzNOMcQ1g8twqwsDRo=
X-Received: by 2002:aa7:c888:0:b0:572:a33d:437f with SMTP id
 p8-20020aa7c888000000b00572a33d437fmr62961eds.2.1714494647472; Tue, 30 Apr
 2024 09:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430011518.110416-1-marex@denx.de>
In-Reply-To: <20240430011518.110416-1-marex@denx.de>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Apr 2024 18:30:36 +0200
Message-ID: <CANn89iJyoMCaX=vCs-DwUzk6Pk-eT1KNNF1KYf-uav_5K-oJNg@mail.gmail.com>
Subject: Re: [net,PATCH] net: ks8851: Queue RX packets in IRQ handler instead
 of disabling BHs
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ronald Wahl <ronald.wahl@raritan.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 3:15=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> Currently the driver uses local_bh_disable()/local_bh_enable() in its
> IRQ handler to avoid triggering net_rx_action() softirq on exit from
> netif_rx(). The net_rx_action() could trigger this driver .start_xmit
> callback, which is protected by the same lock as the IRQ handler, so
> calling the .start_xmit from netif_rx() from the IRQ handler critical
> section protected by the lock could lead to an attempt to claim the
> already claimed lock, and a hang.
>
> The local_bh_disable()/local_bh_enable() approach works only in case
> the IRQ handler is protected by a spinlock, but does not work if the
> IRQ handler is protected by mutex, i.e. this works for KS8851 with
> Parallel bus interface, but not for KS8851 with SPI bus interface.
>
> Remove the BH manipulation and instead of calling netif_rx() inside
> the IRQ handler code protected by the lock, queue all the received
> SKBs in the IRQ handler into a queue first, and once the IRQ handler
> exits the critical section protected by the lock, dequeue all the
> queued SKBs and push them all into netif_rx(). At this point, it is
> safe to trigger the net_rx_action() softirq, since the netif_rx()
> call is outside of the lock that protects the IRQ handler.
>
> Fixes: be0384bf599c ("net: ks8851: Handle softirqs at the end of IRQ thre=
ad to fix hang")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Ronald Wahl <ronald.wahl@raritan.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: netdev@vger.kernel.org
> ---
> Note: This is basically what Jakub originally suggested in
>       https://patchwork.kernel.org/project/netdevbpf/patch/20240331142353=
.93792-2-marex@denx.de/#25785606
> ---
>  drivers/net/ethernet/micrel/ks8851.h        | 1 +
>  drivers/net/ethernet/micrel/ks8851_common.c | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/micrel/ks8851.h b/drivers/net/ethernet/=
micrel/ks8851.h
> index 31f75b4a67fd7..f311074ea13bc 100644
> --- a/drivers/net/ethernet/micrel/ks8851.h
> +++ b/drivers/net/ethernet/micrel/ks8851.h
> @@ -399,6 +399,7 @@ struct ks8851_net {
>
>         struct work_struct      rxctrl_work;
>
> +       struct sk_buff_head     rxq;

This is a private queue, so you can avoid the locking overhead for it.

>         struct sk_buff_head     txq;
>         unsigned int            queued_len;
>
> diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/et=
hernet/micrel/ks8851_common.c
> index d4cdf3d4f5525..f7b48e596631f 100644
> --- a/drivers/net/ethernet/micrel/ks8851_common.c
> +++ b/drivers/net/ethernet/micrel/ks8851_common.c
> @@ -299,7 +299,7 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
>                                         ks8851_dbg_dumpkkt(ks, rxpkt);
>
>                                 skb->protocol =3D eth_type_trans(skb, ks-=
>netdev);
> -                               __netif_rx(skb);
> +                               skb_queue_tail(&ks->rxq, skb);

__skb_queue_tail()

>
>                                 ks->netdev->stats.rx_packets++;
>                                 ks->netdev->stats.rx_bytes +=3D rxlen;
> @@ -330,8 +330,6 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
>         unsigned long flags;
>         unsigned int status;
>
> -       local_bh_disable();
> -
>         ks8851_lock(ks, &flags);
>
>         status =3D ks8851_rdreg16(ks, KS_ISR);
> @@ -408,7 +406,8 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
>         if (status & IRQ_LCI)
>                 mii_check_link(&ks->mii);
>
> -       local_bh_enable();
> +       while (!skb_queue_empty(&ks->rxq))
> +               netif_rx(skb_dequeue(&ks->rxq));

 __skb_dequeue()

>
>         return IRQ_HANDLED;
>  }
> @@ -1189,6 +1188,7 @@ int ks8851_probe_common(struct net_device *netdev, =
struct device *dev,
>                                                 NETIF_MSG_PROBE |
>                                                 NETIF_MSG_LINK);
>
> +       skb_queue_head_init(&ks->rxq);
            __skb_queue_head_init(...);

>         skb_queue_head_init(&ks->txq);
>
>         netdev->ethtool_ops =3D &ks8851_ethtool_ops;
> --
> 2.43.0
>

