Return-Path: <netdev+bounces-93079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894BF8B9F6B
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 19:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACAD51C229B7
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 17:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3210C16FF4F;
	Thu,  2 May 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iq3km+K4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC2016FF4C
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670656; cv=none; b=YhY9cQXsjZecnTzplIXOzAggL2Po7B4KGv4XYclwKg5LVY17n9aWpJp0Igosia1EoNzFsMMZnIsaayfpxlVQ/RFchnGwL6r5QAUiMXlfd8e60TyGm1rRqQgkWU4/ptNGrqNpAMeqzEbQnX5TzFEZXDYGLolkvxeRnkF53CakoGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670656; c=relaxed/simple;
	bh=DerQC7cwpWKpYIzA56cWG/2WzUdRzHs4W9c1IPQcmWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uM/DmWMuH2t0k7fT5gM0+mQZ7v/OEIL7yoUTxdreRULGyrl+VFcQJzZsJl2+PCx9XannO74na4wYDNLAJkJG3fr0tc6NLXFZRb35l1THYtV+jXIL+UlRdOh/Tf8pP+BZ+IesdFWP9lZ3xCP9YPq9F2fcF4nadzKGVfi/IB6gbjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iq3km+K4; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61af74a010aso82471497b3.0
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 10:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714670653; x=1715275453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHurU9A7TsN4QjjIqlHQOd5aztKXw0HKxXqFji8Ohvw=;
        b=iq3km+K4KHJ1morLN7gm8Up9qLoxagjJVtP1OfJb5aYI73niCipMMfe21tjFDMrTVO
         XwT5Qg3q54cJwMmid9K/A2VA2lnulU2CkJfUIkcpwul+3FLxzpzik3mpeZJJmd9c1X7G
         cEz1+H71wIZzS7wAjdYDAKgB4YPHbFYBICVp1zLcIAySyl9P9f5qAM9F5Tiaon7ZKYp+
         wy8qPZ3QWRB2/5+xvnrIEQGZriBHJ5Sxv+BC+JOR3HjsJ8BFMUesWfT8VAJK7WoyYTO5
         SYiXn2ZlR28dHat2/+t+51wSIcOL+CTywUCNTGXp+Md71Qi2kwpAxcZmG0BqXUlq5ZbP
         /UEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714670653; x=1715275453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHurU9A7TsN4QjjIqlHQOd5aztKXw0HKxXqFji8Ohvw=;
        b=aTcnHYvMVflbU7LKpqlsAoNd+aFCHfMk6N3s+6R6plt7zp8kOF2V6W/Fc6U9RuiPNn
         zWt+EsMywVCOdGbt4/YEe0xLD7LMwfw2ZwNm+U+kuozj5J7Vit8IHOq29T+aWGLfTd8M
         +BZL3BSA3SRVDAxlbjSpVHBteyIWsgCxINGbZfZBQ6s9ZGfyL8U9iU3zAmeri/CBjFF+
         ZaMzpC62BgfubKHfUssPXvlqi62JnumaQKOqlJmxptcpkFiJZXLa/ENTudC8h0IMb517
         aLWHor8/El7iP+yBg3itkRpjRX3qS66sNNb9u/a9jrubf/fRGgA4I9nRiCSMKS4vOmH2
         ZISQ==
X-Gm-Message-State: AOJu0YyYzgsd00Y/RAOJSUEK7Xk7MSlTqGnkY8xnuZ1Nqlyvp0I6Gxd7
	6Tu5utJ0rWX9unWBZvQQD7Jf6DTTLvuqlc5e/RhKFh2hzObVj9dQpinbomBKg0xYnRM5QENt52F
	mKOYES4szpX1C0H35uz/kW28soxrdR3wToLDr
X-Google-Smtp-Source: AGHT+IG5z9Kbw4ehfSjBYvYgS49w/+iebzigEUUhMd+8TYXwCc9ZbuUB5gLrGgzgNKsNLMbIWjKiwF3wueLPG/FqZzM=
X-Received: by 2002:a81:6c93:0:b0:61b:3304:cdc7 with SMTP id
 h141-20020a816c93000000b0061b3304cdc7mr197454ywc.29.1714670653327; Thu, 02
 May 2024 10:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502045410.3524155-1-dw@davidwei.uk> <20240502045410.3524155-3-dw@davidwei.uk>
In-Reply-To: <20240502045410.3524155-3-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 2 May 2024 10:23:58 -0700
Message-ID: <CAHS8izMcJ2am+ay1xLxZsZFRpaor-ZKPuVPM+FXdnn4FBpC2Fw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v2 2/9] bnxt: implement queue api
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	Adrian Alvarado <adrian.alvarado@broadcom.com>, Shailend Chand <shailend@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 9:54=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> Implement the bare minimum queue API for bnxt. I'm essentially breaking
> up the existing bnxt_rx_ring_reset() into two steps:
>
> 1. bnxt_queue_stop()
> 2. bnxt_queue_start()
>
> The other two ndos are left as no-ops for now, so the queue mem is
> allocated after the queue has been stopped. Doing this before stopping
> the queue is a lot more work, so I'm looking for some feedback first.
>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 62 +++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 06b7a963bbbd..788c87271eb1 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -14810,6 +14810,67 @@ static const struct netdev_stat_ops bnxt_stat_op=
s =3D {
>         .get_base_stats         =3D bnxt_get_base_stats,
>  };
>
> +static void *bnxt_queue_mem_alloc(struct net_device *dev, int idx)
> +{
> +       struct bnxt *bp =3D netdev_priv(dev);
> +
> +       return &bp->rx_ring[idx];
> +}
> +
> +static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
> +{
> +}
> +
> +static int bnxt_queue_start(struct net_device *dev, int idx, void *qmem)
> +{
> +       struct bnxt_rx_ring_info *rxr =3D qmem;
> +       struct bnxt *bp =3D netdev_priv(dev);
> +
> +       bnxt_alloc_one_rx_ring(bp, idx);
> +
> +       if (bp->flags & BNXT_FLAG_AGG_RINGS)
> +               bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
> +       bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
> +
> +       if (bp->flags & BNXT_FLAG_TPA)
> +               bnxt_set_tpa(bp, true);
> +
> +       return 0;
> +}
> +
> +static int bnxt_queue_stop(struct net_device *dev, int idx, void **out_q=
mem)
> +{
> +       struct bnxt *bp =3D netdev_priv(dev);
> +       struct bnxt_rx_ring_info *rxr;
> +       struct bnxt_cp_ring_info *cpr;
> +       int rc;
> +
> +       rc =3D bnxt_hwrm_rx_ring_reset(bp, idx);
> +       if (rc)
> +               return rc;
> +
> +       bnxt_free_one_rx_ring_skbs(bp, idx);
> +       rxr =3D &bp->rx_ring[idx];
> +       rxr->rx_prod =3D 0;
> +       rxr->rx_agg_prod =3D 0;
> +       rxr->rx_sw_agg_prod =3D 0;
> +       rxr->rx_next_cons =3D 0;
> +
> +       cpr =3D &rxr->bnapi->cp_ring;
> +       cpr->sw_stats.rx.rx_resets++;
> +
> +       *out_qmem =3D rxr;

Oh, I'm not sure you can do this, no?

rxr is a stack variable, it goes away after the function returns, no?

You have to kzalloc sizeof(struct bnext_rx_ring_info), no?

Other than that, the code looks very similar to what we do for GVE,
and good to me.

> +
> +       return 0;
> +}
> +
> +static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops =3D {
> +       .ndo_queue_mem_alloc    =3D bnxt_queue_mem_alloc,
> +       .ndo_queue_mem_free     =3D bnxt_queue_mem_free,
> +       .ndo_queue_start        =3D bnxt_queue_start,
> +       .ndo_queue_stop         =3D bnxt_queue_stop,
> +};
> +
>  static void bnxt_remove_one(struct pci_dev *pdev)
>  {
>         struct net_device *dev =3D pci_get_drvdata(pdev);
> @@ -15275,6 +15336,7 @@ static int bnxt_init_one(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
>         dev->stat_ops =3D &bnxt_stat_ops;
>         dev->watchdog_timeo =3D BNXT_TX_TIMEOUT;
>         dev->ethtool_ops =3D &bnxt_ethtool_ops;
> +       dev->queue_mgmt_ops =3D &bnxt_queue_mgmt_ops;
>         pci_set_drvdata(pdev, dev);
>
>         rc =3D bnxt_alloc_hwrm_resources(bp);
> --
> 2.43.0
>


--=20
Thanks,
Mina

