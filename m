Return-Path: <netdev+bounces-126366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 556F8970DB1
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 07:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF0F0B21A61
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 05:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2B81AD402;
	Mon,  9 Sep 2024 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="NqYy5R7r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E241AC8A5;
	Mon,  9 Sep 2024 05:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725860695; cv=none; b=bCQYg58t6UMpFnc7Aoa+EqLCAP5z6uGREsHO4yKijxkO63NHndm8p+16Uy1S67fCLWXkB7+Uw5kcI+m8f0BekvqEHwB+yLQ7UWUkHM/Cv7WnUS4Yd/Nu9b+g2hZzIscXclyXcROXp8PN7WZ9mTUX9BSBONggXvvCZraeTDnmMJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725860695; c=relaxed/simple;
	bh=O1ycc38W3VldvShja86StoBI1PGMFy9V2eFhQuTFQxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laDW05Rc8JpR3H7UxJqP+eZIObpuUydOl2s+plwIOguIXb6Sg6Kzlxtcyma/iVSIAipzTU2RhRPYE7RYtvdT6pRalw9uvGAqTGnX2J8hsWf+c9k0wVUcoJsxFHu2CVk17A6A2T9oryLq48QfilTO+KdJATK0eLf6j3cIBisllcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b=NqYy5R7r; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a80eab3945eso361362466b.1;
        Sun, 08 Sep 2024 22:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1725860687; x=1726465487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7pxAZ1eVjHpYIL+4uC4a6YpmXbPdojL06PzoA4vC2/M=;
        b=NqYy5R7r1soyOjQ60cz7AvFUF1GyGtv8VWArxrgKZ3UYniL2pRiFrr0VPBpQokh6C+
         WOPv26JgD1IzcevFanbcRQXQZlg3DZDOYkC/Ks+2pDxqwXNmnFmAvAGYdFPoBpMa/cdC
         R3wu8Ao5eWRTA5c2pCLW+QmBFmTOx3gJxy5oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725860687; x=1726465487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pxAZ1eVjHpYIL+4uC4a6YpmXbPdojL06PzoA4vC2/M=;
        b=iJEgHTDm9jASnM1q245YGlr9SM1qimXf4fVaKOqI8yArH3gHTZVkFOlcGRorxP3NVp
         41yaHrK7rGG2LBXSPsBysanVzaBDWH+ioYapmdtKLKu5B+jKz8hfN4K3BgMsXy5eGQXW
         UW24iPRMStf0cItOGUClwYpvsU1cVA9G4p+wxfJbKrEmidfNyHeHlrTjFSnsiM3GOiE0
         K+0JzWEeH1L4ECOPE3F6c6ckTPImUFkjvN4xD0wW6YgVs7VucfoimLDCPA0LwLxhPyET
         LDd146DJ/5+lI7fcI93E1edG38wCEkA7y/Niy4vUVeYKn2sqQPs6kOctP/Ac5rmYjvuc
         aKdg==
X-Forwarded-Encrypted: i=1; AJvYcCUqLUBKsDglPA+sVOkQxKZ9TPsGoXo8kcfPFraH1aqshb32KTxvxYibm1ByYsfPA1U7zOe6Kgzd@vger.kernel.org, AJvYcCXhRwG9gDzAllc3jSNG5W8EBpVmHb2eGAzNhslt1YBoWG+ohEr6PlVF4Pl5JYrvyLs30Vdd3KNKQ0+w/M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpnbJJRgqJzcwIfOm7sYSRzp+UGmLr8Sd8TKf6g3seUqJ3qbKA
	SG8M6obiIP/DYNyIAJmE8qJwWQoUbwLt50i923dJRxo+5cUTXUOvB7rgkjps/0a2SKOaMzNFMTJ
	sK9Yvs5+LO73ut/YWwyIgamC19Z8=
X-Google-Smtp-Source: AGHT+IGGCW7PztODXPKl6CWmPcAl2mDjthVbQgyNHUBRxCLRm6aJ9UQu58RWOsQEHFJuuvHZqvDIG++0o+uNCSo5MVE=
X-Received: by 2002:a17:907:7f25:b0:a8d:6648:813f with SMTP id
 a640c23a62f3a-a8d6648846amr9112166b.3.1725860686300; Sun, 08 Sep 2024
 22:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822073006.817173-1-jacky_chou@aspeedtech.com>
In-Reply-To: <20240822073006.817173-1-jacky_chou@aspeedtech.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 9 Sep 2024 15:14:33 +0930
Message-ID: <CACPK8XddKEgT9QeDkx2Shftj582rV8sfWwJGPxuv-2HOG0GxcA@mail.gmail.com>
Subject: Re: [PATCH] net: ftgmac100: Ensure tx descriptor updates are visible
To: Jacky Chou <jacky_chou@aspeedtech.com>, Ryan Chen <ryan_chen@aspeedtech.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, u.kleine-koenig@pengutronix.de, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 17:00, Jacky Chou <jacky_chou@aspeedtech.com> wrote:
>
> The driver must ensure TX descriptor updates are visible
> before updating TX pointer and TX clear pointer.
>
> This resolves TX hangs observed on AST2600 when running
> iperf3.

Thanks for re-submitting my patch and getting it merged. In the
future, it would be best if you left the authorship, and preserved my
commit message.

 https://lore.kernel.org/all/20201020220639.130696-1-joel@jms.id.au/

Cheers,

Joel

>
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  drivers/net/ethernet/faraday/ftgmac100.c | 26 ++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 93862b027be0..9c521d0af7ac 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -582,7 +582,7 @@ static bool ftgmac100_rx_packet(struct ftgmac100 *priv, int *processed)
>         (*processed)++;
>         return true;
>
> - drop:
> +drop:
>         /* Clean rxdes0 (which resets own bit) */
>         rxdes->rxdes0 = cpu_to_le32(status & priv->rxdes0_edorr_mask);
>         priv->rx_pointer = ftgmac100_next_rx_pointer(priv, pointer);
> @@ -666,6 +666,11 @@ static bool ftgmac100_tx_complete_packet(struct ftgmac100 *priv)
>         ftgmac100_free_tx_packet(priv, pointer, skb, txdes, ctl_stat);
>         txdes->txdes0 = cpu_to_le32(ctl_stat & priv->txdes0_edotr_mask);
>
> +       /* Ensure the descriptor config is visible before setting the tx
> +        * pointer.
> +        */
> +       smp_wmb();
> +
>         priv->tx_clean_pointer = ftgmac100_next_tx_pointer(priv, pointer);
>
>         return true;
> @@ -819,6 +824,11 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
>         dma_wmb();
>         first->txdes0 = cpu_to_le32(f_ctl_stat);
>
> +       /* Ensure the descriptor config is visible before setting the tx
> +        * pointer.
> +        */
> +       smp_wmb();
> +
>         /* Update next TX pointer */
>         priv->tx_pointer = pointer;
>
> @@ -839,7 +849,7 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
>
>         return NETDEV_TX_OK;
>
> - dma_err:
> +dma_err:
>         if (net_ratelimit())
>                 netdev_err(netdev, "map tx fragment failed\n");
>
> @@ -861,7 +871,7 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
>          * last fragment, so we know ftgmac100_free_tx_packet()
>          * hasn't freed the skb yet.
>          */
> - drop:
> +drop:
>         /* Drop the packet */
>         dev_kfree_skb_any(skb);
>         netdev->stats.tx_dropped++;
> @@ -1354,7 +1364,7 @@ static void ftgmac100_reset(struct ftgmac100 *priv)
>         ftgmac100_init_all(priv, true);
>
>         netdev_dbg(netdev, "Reset done !\n");
> - bail:
> +bail:
>         if (priv->mii_bus)
>                 mutex_unlock(&priv->mii_bus->mdio_lock);
>         if (netdev->phydev)
> @@ -1554,15 +1564,15 @@ static int ftgmac100_open(struct net_device *netdev)
>
>         return 0;
>
> - err_ncsi:
> +err_ncsi:
>         napi_disable(&priv->napi);
>         netif_stop_queue(netdev);
> - err_alloc:
> +err_alloc:
>         ftgmac100_free_buffers(priv);
>         free_irq(netdev->irq, netdev);
> - err_irq:
> +err_irq:
>         netif_napi_del(&priv->napi);
> - err_hw:
> +err_hw:
>         iowrite32(0, priv->base + FTGMAC100_OFFSET_IER);
>         ftgmac100_free_rings(priv);
>         return err;
> --
> 2.25.1
>
>

