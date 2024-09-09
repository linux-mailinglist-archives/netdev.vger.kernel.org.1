Return-Path: <netdev+bounces-126601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA84971F97
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66CD41C2175B
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 16:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821BC165F05;
	Mon,  9 Sep 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t+59aztg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B472E1BC40
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900823; cv=none; b=jErZZ0VoG2+gGz29xE33TxilVK1VMTSwQrWo9M2bSjrqMdcZaSY47puaklLM2sF8t6eKzEWjsc3WkCEs/o9CTqO1oWsEZrOJVU/SUbXnplDuvRNf+7Pk7d5bmMAjj7CMxy08tkWNLINpcAIAhCrnMCd7D6/DfVWZiVUexEz4w9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900823; c=relaxed/simple;
	bh=PtXgWEMdhBCfxrMV5M60xLjhB32Phc2QBpQlAcUGfP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVLZHOCZENlczrUF4Do9/ZwtIf3goCqKXGJ2i19BKRTVgTCsfh1N8OX4KZlokHau+bbfGWvRVf0bSEb4FclYg+RTQbarJqiWHLJDj3lx82wHha1cR6E2Cqi7TQbpybpt2E80wS6VXhx7SC4DOfNULv3kFvVpDL0obalhMs3QgaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t+59aztg; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53659867cbdso5367131e87.3
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 09:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725900820; x=1726505620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9SiO6xUxnqXAw/LgFoH+/dHfvx+t44phKmxj197jCQ=;
        b=t+59aztgClMSuP/dVqExsRLBygSoq3einCXVUOGXDdxOuKV+49iRrYP/NaFtumKKnL
         RC5vX+pl8FuP67eI+Q5VrKlgRxC47HqhkSX4XbYSgsimb+BgLBMGjvvgbxW9D6Bo2d0U
         QlxEhC6HxgvVHZiT6mgIuGC0lTpqJOiaSce+o89XL4Qm3j8zk691BwPPrUvx99/wVOoT
         /XUK/QaXy7IJLd33DmQFROnEKt5XwqBeW6VqJBhnQxeqVuEO5juEGA6ujUPz63Fy1Mwx
         jSco486wNusKGZqVlLjL+4TN1Oi1QoxnJJflRFeIo9Que+MQdZgc5zWKScD8yZG6nvjM
         KtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725900820; x=1726505620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9SiO6xUxnqXAw/LgFoH+/dHfvx+t44phKmxj197jCQ=;
        b=qqz/ozZ4Hl0wQyywF6fxbUnTKUpNoo9xFfydezI2UaIx1fx2BJ4sn0E3k7YinOfAEA
         YVavGKpNtiZ56hLqlo7/g2lUFrEIuXBR7cvkEZ/m3crbBwtwrypSnmuzp8jCyvOeV97p
         Ld0+35IXT1KVz2ILLDN4OmAb/r0KZpBXUm/avdlUp3JreDk44mBqv9PJKYoeXHl0MA9s
         A9KwKXjxm9txeClEpONrmkjY69JGVb65S7xPA8Or7N/vtdTeue2ECkejcT3JhMH6gYOm
         prJ+4SMmw+8fVN6wlgd2NUtDrsCDfKWgYjmVpeAoIgCBL2NnuRtjEYL7jcYAk0H/ZqFh
         nh+w==
X-Forwarded-Encrypted: i=1; AJvYcCU/FtS9VMoDKtx55TVmGtLAWhqFW9biQdg5U7cD9wAr6cLBrGlqdyfSOwC3YBYyLpDnv2LPnxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YytWhaZ+abRph956IsiimYMv7bsey0cyi5rbE/x8mS1SsnIqNog
	302zniShrAkjAS427opNswucZqhtP3piH/ZKdNQtp/lAY4vT8Msi0miecvv2TjXMA0dTLHf7AQJ
	y6v0HyWDjPaUK0LWVHEkg7/Q6YBdyp7QhQYR0khjmfJmH70kQC+Po
X-Google-Smtp-Source: AGHT+IHxMIgEPETdtRxitPOndtVl9VPFTYCRnwDB3ln3xDf0u1U9D0XTOVls54AhGFDHccAWSysMIxtaaiN4liuEd/U=
X-Received: by 2002:adf:cc91:0:b0:374:c658:706e with SMTP id
 ffacd0b85a97d-3789243fb15mr7369793f8f.39.1725900376219; Mon, 09 Sep 2024
 09:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909160604.1148178-1-sean.anderson@linux.dev>
In-Reply-To: <20240909160604.1148178-1-sean.anderson@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Sep 2024 18:46:01 +0200
Message-ID: <CANn89i+UHJgx5cp6M=6PidC0rdPdr4hnsDaQ=7srijR3ArM1jw@mail.gmail.com>
Subject: Re: [PATCH net] net: dpaa: Pad packets to ETH_ZLEN
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Madalin Bucur <madalin.bucur@nxp.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 6:06=E2=80=AFPM Sean Anderson <sean.anderson@linux.d=
ev> wrote:
>
> When sending packets under 60 bytes, up to three bytes of the buffer foll=
owing
> the data may be leaked. Avoid this by extending all packets to ETH_ZLEN,
> ensuring nothing is leaked in the padding. This bug can be reproduced by
> running
>
>         $ ping -s 11 destination
>
> Fixes: 9ad1a3749333 ("dpaa_eth: add support for DPAA Ethernet")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net=
/ethernet/freescale/dpaa/dpaa_eth.c
> index cfe6b57b1da0..e4e8ee8b7356 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> @@ -2322,6 +2322,12 @@ dpaa_start_xmit(struct sk_buff *skb, struct net_de=
vice *net_dev)
>         }
>  #endif
>
> +       /* Packet data is always read as 32-bit words, so zero out any pa=
rt of
> +        * the skb which might be sent if we have to pad the packet
> +        */
> +       if (__skb_put_padto(skb, ETH_ZLEN, false))
> +               goto enomem;
> +

This call might linearize the packet.

@nonlinear variable might be wrong after this point.

>         if (nonlinear) {
>                 /* Just create a S/G fd based on the skb */
>                 err =3D skb_to_sg_fd(priv, skb, &fd);
> --
> 2.35.1.1320.gc452695387.dirty
>

Perhaps this instead ?

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index cfe6b57b1da0e45613ac1bbf32ddd6ace329f4fd..5763d2f1bf8dd31b80fda068136=
1514dad1dc307
100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2272,12 +2272,12 @@ static netdev_tx_t
 dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 {
        const int queue_mapping =3D skb_get_queue_mapping(skb);
-       bool nonlinear =3D skb_is_nonlinear(skb);
        struct rtnl_link_stats64 *percpu_stats;
        struct dpaa_percpu_priv *percpu_priv;
        struct netdev_queue *txq;
        struct dpaa_priv *priv;
        struct qm_fd fd;
+       bool nonlinear;
        int offset =3D 0;
        int err =3D 0;

@@ -2287,6 +2287,10 @@ dpaa_start_xmit(struct sk_buff *skb, struct
net_device *net_dev)

        qm_fd_clear_fd(&fd);

+       if (__skb_put_padto(skb, ETH_ZLEN, false))
+               goto enomem;
+
+       nonlinear =3D skb_is_nonlinear(skb);
        if (!nonlinear) {
                /* We're going to store the skb backpointer at the beginnin=
g
                 * of the data buffer, so we need a privately owned skb

