Return-Path: <netdev+bounces-157944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B06DBA0FE72
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A2618893A2
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 02:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EEE22FE1A;
	Tue, 14 Jan 2025 02:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Jq7Br5JP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7AE22FE19
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 02:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736820376; cv=none; b=feez5hRUx8dhKeU6bc7GY65DNoEpM+5mRpgS1eFnf4YDJ0KBkpkxbP78qKNulqIiqdUuQCzlcNocN1Y5dvv7RIz9coXmbaWsXEHcuQRC1+wOrxFY3uJEz7blC42eHM3WBZWydvU/9miSjQS+PaFmrWlqNv9NBFUTkxV8bOSpN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736820376; c=relaxed/simple;
	bh=IwcSj7VS7T1seP/zracA2WZrTtgjtoFCbhdC5ZoLHMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBu9cR4R02nZWc+/RvPXrnkl63WbBaESxVeTePQpCOXssE4qC0gjRi5BKX6nfhBIXY52zildvzyK3NQlooSefNOMpfMMDMUrs4mCyFvzIHdduwJDV5Jfm9jISiPZ4CBVCXRXi95q/nGAqLR0bZFxQ0cj7jAT/s6QDQSem3lT3Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Jq7Br5JP; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86112ab1ad4so1374704241.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 18:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736820373; x=1737425173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sa0tUkDMOetFxrHyyVrPW7YTo25wi99SgYCQzjgiEGM=;
        b=Jq7Br5JPd2t9s4JuOXYVMFOEXgJkmfJhbfClqjMcM/h4f4+W6lMtt8VuEgf7i402Qo
         YbfLOtllWO4X54Ip/Sr69IQ+bBQ+NEgrPnxS/HFugkSW4IXl1E9y6VxgOm+O7deWGAyX
         YgIZExKcY3sJI7nPt5reKaWiSoBMtGzOmBQmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736820373; x=1737425173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sa0tUkDMOetFxrHyyVrPW7YTo25wi99SgYCQzjgiEGM=;
        b=sfFChHua2c+tY4Oo83JifClVfg9yTSBPYNSrhYUUZpeguoWiU3sSa9ju7mIspAdRkE
         0AOBwWV9m+OlAqIJx+WxAazBWOllEBeVXVsXtEFOM5KiLwpTeWu57TI8hzbCNMyf5xxN
         umwlIu4HK1M55O93flv/sK7zxNlKeR/YkiizrGNvxCmzXkzDUafQdZhl/Vb9iDuHeNdj
         mOGaEGNEj4DL+ACtLW63IvOWoa9ppq/Nyjs0V0YMXpboGXQqUVvUIiYl4X9Jrbk/yUHK
         v/B747izxldSVgAKlFiuk8Mr018Y3gnur5KIraToM13Z9dW4VE1Mc3mt2Ix7k8/E95JQ
         hkIw==
X-Forwarded-Encrypted: i=1; AJvYcCWot4jVwQG+fozEO/VznUfOeeP/X+8w5euBVdmU1q1l56Dv2C94Z0oY8C381sGJr1STry1Mm1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk9F2tguufGJT10nkguKSmIhSE+liX3tRi2oYdm8MVnYANOAHO
	0DRvk6qxdPRRHLqUWjp2KXD3KO+0AnRD9ozujI1E05XoF7cP+/8FHop/i8mCYNbHe+90ukjsgGg
	vBY8iixUXLPDf8Rb4Lw5tcf8r4fN1JubFuK01
X-Gm-Gg: ASbGncs71A7KFPr9Dy3YMKrufJdZukfbVCL3D9nkIHmVGOJyQCUPsGZxwS7D0z1RAsJ
	sEU01lxJpHXCPrIcDGfWJfUTm6wvSUik/KuN4
X-Google-Smtp-Source: AGHT+IGu7rBxKSrvpQQNRxk7Uiqu8uKacTgUK+M5MTlxwcYJLOFyRkiBG7fhb21/kfOM5r25LPQTG8AzCyBmZ7q0U6Y=
X-Received: by 2002:a05:6102:578e:b0:4af:eccf:e3ca with SMTP id
 ada2fe7eead31-4b3d0da8a8cmr20541770137.10.1736820372789; Mon, 13 Jan 2025
 18:06:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113063927.4017173-1-michael.chan@broadcom.com>
 <20250113063927.4017173-10-michael.chan@broadcom.com> <Z4TRYfno5jCz84KD@mev-dev.igk.intel.com>
In-Reply-To: <Z4TRYfno5jCz84KD@mev-dev.igk.intel.com>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Tue, 14 Jan 2025 07:35:59 +0530
X-Gm-Features: AbW1kvaPXfVQlM89QjYDfPpKE4VCnoX4Ze2Rx3LtvCdPhVURKU5HeODy9-zwAYQ
Message-ID: <CAOBf=mvgMAjd8ynsMWCEq_nYQdTz=EFDG-hq6hpMEFhJ7Nm1BQ@mail.gmail.com>
Subject: Re: [PATCH net-next 09/10] bnxt_en: Extend queue stop/start for Tx rings
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Michael Chan <michael.chan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andrew Gospodarek <andrew.gospodarek@broadcom.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>, 
	David Wei <dw@davidwei.uk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000060ca33062ba1017c"

--00000000000060ca33062ba1017c
Content-Type: multipart/alternative; boundary="0000000000005c0aa9062ba10102"

--0000000000005c0aa9062ba10102
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Jan, 2025, 14:13 Michal Swiatkowski, <
michal.swiatkowski@linux.intel.com> wrote:

> On Sun, Jan 12, 2025 at 10:39:26PM -0800, Michael Chan wrote:
> > From: Somnath Kotur <somnath.kotur@broadcom.com>
> >
> > In order to use queue_stop/queue_start to support the new Steering
> > Tags, we need to free the TX ring and TX completion ring if it is a
> > combined channel with TX/RX sharing the same NAPI.  Otherwise
> > TX completions will not have the updated Steering Tag.  With that
> > we can now add napi_disable() and napi_enable() during queue_stop()/
> > queue_start().  This will guarantee that NAPI will stop processing
> > the completion entries in case there are additional pending entries
> > in the completion rings after queue_stop().
> >
> > There could be some NQEs sitting unprocessed while NAPI is disabled
> > thereby leaving the NQ unarmed.  Explictily Re-arm the NQ after
> > napi_enable() in queue start so that NAPI will resume properly.
> >
> > Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> > Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
> > Reviewed-by: Michael Chan <michael.chan@broadcom.com>
> > ---
> > Cc: David Wei <dw@davidwei.uk>
> >
> > Discussion about adding napi_disable()/napi_enable():
> >
> >
> https://lore.kernel.org/netdev/5336d624-8d8b-40a6-b732-b020e4a119a2@davidwei.uk/#t
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 99 ++++++++++++++++++++++-
> >  1 file changed, 98 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > index fe350d0ba99c..eddb4de959c6 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -7341,6 +7341,22 @@ static int hwrm_ring_free_send_msg(struct bnxt
> *bp,
> >       return 0;
> >  }
> >
> > +static void bnxt_hwrm_tx_ring_free(struct bnxt *bp, struct
> bnxt_tx_ring_info *txr,
> > +                                bool close_path)
> > +{
> > +     struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
> > +     u32 cmpl_ring_id;
> > +
> > +     if (ring->fw_ring_id == INVALID_HW_RING_ID)
> > +             return;
> > +
> > +     cmpl_ring_id = close_path ? bnxt_cp_ring_for_tx(bp, txr) :
> > +                    INVALID_HW_RING_ID;
> > +     hwrm_ring_free_send_msg(bp, ring, RING_FREE_REQ_RING_TYPE_TX,
> > +                             cmpl_ring_id);
> > +     ring->fw_ring_id = INVALID_HW_RING_ID;
> > +}
> > +
> >  static void bnxt_hwrm_rx_ring_free(struct bnxt *bp,
> >                                  struct bnxt_rx_ring_info *rxr,
> >                                  bool close_path)
> > @@ -11247,6 +11263,69 @@ int bnxt_reserve_rings(struct bnxt *bp, bool
> irq_re_init)
> >       return 0;
> >  }
> >
> > +static void bnxt_tx_queue_stop(struct bnxt *bp, int idx)
> > +{
> > +     struct bnxt_tx_ring_info *txr;
> > +     struct netdev_queue *txq;
> > +     struct bnxt_napi *bnapi;
> > +     int i;
> > +
> > +     bnapi = bp->bnapi[idx];
> > +     bnxt_for_each_napi_tx(i, bnapi, txr) {
> > +             WRITE_ONCE(txr->dev_state, BNXT_DEV_STATE_CLOSING);
> > +             synchronize_net();
> > +
> > +             if (!(bnapi->flags & BNXT_NAPI_FLAG_XDP)) {
> > +                     txq = netdev_get_tx_queue(bp->dev, txr->txq_index);
> > +                     if (txq) {
> > +                             __netif_tx_lock_bh(txq);
> > +                             netif_tx_stop_queue(txq);
> > +                             __netif_tx_unlock_bh(txq);
> > +                     }
> > +             }
> > +             bnxt_hwrm_tx_ring_free(bp, txr, true);
> > +             bnxt_hwrm_cp_ring_free(bp, txr->tx_cpr);
> > +             bnxt_free_one_tx_ring_skbs(bp, txr, txr->txq_index);
> > +             bnxt_clear_one_cp_ring(bp, txr->tx_cpr);
> > +     }
> > +}
> > +
> > +static int bnxt_tx_queue_start(struct bnxt *bp, int idx)
> > +{
> > +     struct bnxt_tx_ring_info *txr;
> > +     struct netdev_queue *txq;
> > +     struct bnxt_napi *bnapi;
> > +     int rc, i;
> > +
> > +     bnapi = bp->bnapi[idx];
> > +     bnxt_for_each_napi_tx(i, bnapi, txr) {
> > +             rc = bnxt_hwrm_cp_ring_alloc_p5(bp, txr->tx_cpr);
> > +             if (rc)
> > +                     return rc;
> > +
> > +             rc = bnxt_hwrm_tx_ring_alloc(bp, txr, false);
> > +             if (rc) {
> > +                     bnxt_hwrm_cp_ring_free(bp, txr->tx_cpr);
> What about ring allocated in previous steps? Don't you need to free them
> too?
>
Sure thanks, will take care

>
> > +                     return rc;
> > +             }
> > +             txr->tx_prod = 0;
> > +             txr->tx_cons = 0;
> > +             txr->tx_hw_cons = 0;
> > +
> > +             WRITE_ONCE(txr->dev_state, 0);
> > +             synchronize_net();
> > +
> > +             if (bnapi->flags & BNXT_NAPI_FLAG_XDP)
> > +                     continue;
> > +
> > +             txq = netdev_get_tx_queue(bp->dev, txr->txq_index);
> > +             if (txq)
> > +                     netif_tx_start_queue(txq);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static void bnxt_free_irq(struct bnxt *bp)
> >  {
> >       struct bnxt_irq *irq;
> > @@ -15647,6 +15726,16 @@ static int bnxt_queue_start(struct net_device
> *dev, void *qmem, int idx)
> >       cpr = &rxr->bnapi->cp_ring;
> >       cpr->sw_stats->rx.rx_resets++;
> >
> > +     if (bp->flags & BNXT_FLAG_SHARED_RINGS) {
> > +             rc = bnxt_tx_queue_start(bp, idx);
> > +             if (rc)
> > +                     netdev_warn(bp->dev,
> > +                                 "tx queue restart failed: rc=%d\n",
> rc);
> > +     }
> > +
> > +     napi_enable(&rxr->bnapi->napi);
> > +     bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
> > +
> >       for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
> >               vnic = &bp->vnic_info[i];
> >
> > @@ -15675,6 +15764,7 @@ static int bnxt_queue_stop(struct net_device
> *dev, void *qmem, int idx)
> >       struct bnxt *bp = netdev_priv(dev);
> >       struct bnxt_rx_ring_info *rxr;
> >       struct bnxt_vnic_info *vnic;
> > +     struct bnxt_napi *bnapi;
> >       int i;
> >
> >       for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
> > @@ -15686,15 +15776,22 @@ static int bnxt_queue_stop(struct net_device
> *dev, void *qmem, int idx)
> >       /* Make sure NAPI sees that the VNIC is disabled */
> >       synchronize_net();
> >       rxr = &bp->rx_ring[idx];
> > -     cancel_work_sync(&rxr->bnapi->cp_ring.dim.work);
> > +     bnapi = rxr->bnapi;
> > +     cancel_work_sync(&bnapi->cp_ring.dim.work);
> >       bnxt_hwrm_rx_ring_free(bp, rxr, false);
> >       bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
> >       page_pool_disable_direct_recycling(rxr->page_pool);
> >       if (bnxt_separate_head_pool())
> >               page_pool_disable_direct_recycling(rxr->head_pool);
> >
> > +     if (bp->flags & BNXT_FLAG_SHARED_RINGS)
> > +             bnxt_tx_queue_stop(bp, idx);
> > +
> > +     napi_disable(&bnapi->napi);
> > +
> >       bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
> >       bnxt_clear_one_cp_ring(bp, rxr->rx_cpr);
> > +     bnxt_db_nq(bp, &cpr->cp_db, cpr->cp_raw_cons);
> >
> >       memcpy(qmem, rxr, sizeof(*rxr));
> >       bnxt_init_rx_ring_struct(bp, qmem);
> > --
> > 2.30.1
>

--0000000000005c0aa9062ba10102
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 13 Jan, 2025, 14:13 Mich=
al Swiatkowski, &lt;<a href=3D"mailto:michal.swiatkowski@linux.intel.com">m=
ichal.swiatkowski@linux.intel.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On Sun, Jan 12, 2025 at 10:39:26PM -0800, Michael Chan wrote:=
<br>
&gt; From: Somnath Kotur &lt;<a href=3D"mailto:somnath.kotur@broadcom.com" =
target=3D"_blank" rel=3D"noreferrer">somnath.kotur@broadcom.com</a>&gt;<br>
&gt; <br>
&gt; In order to use queue_stop/queue_start to support the new Steering<br>
&gt; Tags, we need to free the TX ring and TX completion ring if it is a<br=
>
&gt; combined channel with TX/RX sharing the same NAPI.=C2=A0 Otherwise<br>
&gt; TX completions will not have the updated Steering Tag.=C2=A0 With that=
<br>
&gt; we can now add napi_disable() and napi_enable() during queue_stop()/<b=
r>
&gt; queue_start().=C2=A0 This will guarantee that NAPI will stop processin=
g<br>
&gt; the completion entries in case there are additional pending entries<br=
>
&gt; in the completion rings after queue_stop().<br>
&gt; <br>
&gt; There could be some NQEs sitting unprocessed while NAPI is disabled<br=
>
&gt; thereby leaving the NQ unarmed.=C2=A0 Explictily Re-arm the NQ after<b=
r>
&gt; napi_enable() in queue start so that NAPI will resume properly.<br>
&gt; <br>
&gt; Reviewed-by: Ajit Khaparde &lt;<a href=3D"mailto:ajit.khaparde@broadco=
m.com" target=3D"_blank" rel=3D"noreferrer">ajit.khaparde@broadcom.com</a>&=
gt;<br>
&gt; Signed-off-by: Somnath Kotur &lt;<a href=3D"mailto:somnath.kotur@broad=
com.com" target=3D"_blank" rel=3D"noreferrer">somnath.kotur@broadcom.com</a=
>&gt;<br>
&gt; Reviewed-by: Michael Chan &lt;<a href=3D"mailto:michael.chan@broadcom.=
com" target=3D"_blank" rel=3D"noreferrer">michael.chan@broadcom.com</a>&gt;=
<br>
&gt; ---<br>
&gt; Cc: David Wei &lt;<a href=3D"mailto:dw@davidwei.uk" target=3D"_blank" =
rel=3D"noreferrer">dw@davidwei.uk</a>&gt;<br>
&gt; <br>
&gt; Discussion about adding napi_disable()/napi_enable():<br>
&gt; <br>
&gt; <a href=3D"https://lore.kernel.org/netdev/5336d624-8d8b-40a6-b732-b020=
e4a119a2@davidwei.uk/#t" rel=3D"noreferrer noreferrer" target=3D"_blank">ht=
tps://lore.kernel.org/netdev/5336d624-8d8b-40a6-b732-b020e4a119a2@davidwei.=
uk/#t</a><br>
&gt; ---<br>
&gt;=C2=A0 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 99 +++++++++++++++++=
+++++-<br>
&gt;=C2=A0 1 file changed, 98 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/e=
thernet/broadcom/bnxt/bnxt.c<br>
&gt; index fe350d0ba99c..eddb4de959c6 100644<br>
&gt; --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c<br>
&gt; +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c<br>
&gt; @@ -7341,6 +7341,22 @@ static int hwrm_ring_free_send_msg(struct bnxt =
*bp,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static void bnxt_hwrm_tx_ring_free(struct bnxt *bp, struct bnxt_tx_ri=
ng_info *txr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool close_path)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct bnxt_ring_struct *ring =3D &amp;txr-&gt;tx=
_ring_struct;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 cmpl_ring_id;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ring-&gt;fw_ring_id =3D=3D INVALID_HW_RING_ID=
)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cmpl_ring_id =3D close_path ? bnxt_cp_ring_for_tx=
(bp, txr) :<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 INVALID_HW_RING_ID;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0hwrm_ring_free_send_msg(bp, ring, RING_FREE_REQ_R=
ING_TYPE_TX,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmpl_ring_id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ring-&gt;fw_ring_id =3D INVALID_HW_RING_ID;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void bnxt_hwrm_rx_ring_free(struct bnxt *bp,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct bnxt_rx_ring_info *=
rxr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool close_path)<br>
&gt; @@ -11247,6 +11263,69 @@ int bnxt_reserve_rings(struct bnxt *bp, bool =
irq_re_init)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static void bnxt_tx_queue_stop(struct bnxt *bp, int idx)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct bnxt_tx_ring_info *txr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct netdev_queue *txq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct bnxt_napi *bnapi;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bnapi =3D bp-&gt;bnapi[idx];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bnxt_for_each_napi_tx(i, bnapi, txr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WRITE_ONCE(txr-&gt;de=
v_state, BNXT_DEV_STATE_CLOSING);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0synchronize_net();<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(bnapi-&gt;flags=
 &amp; BNXT_NAPI_FLAG_XDP)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0txq =3D netdev_get_tx_queue(bp-&gt;dev, txr-&gt;txq_index);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (txq) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__netif_tx_lock_bh(txq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netif_tx_stop_queue(txq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__netif_tx_unlock_bh(txq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bnxt_hwrm_tx_ring_fre=
e(bp, txr, true);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bnxt_hwrm_cp_ring_fre=
e(bp, txr-&gt;tx_cpr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bnxt_free_one_tx_ring=
_skbs(bp, txr, txr-&gt;txq_index);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bnxt_clear_one_cp_rin=
g(bp, txr-&gt;tx_cpr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int bnxt_tx_queue_start(struct bnxt *bp, int idx)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct bnxt_tx_ring_info *txr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct netdev_queue *txq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct bnxt_napi *bnapi;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int rc, i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bnapi =3D bp-&gt;bnapi[idx];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bnxt_for_each_napi_tx(i, bnapi, txr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D bnxt_hwrm_cp_r=
ing_alloc_p5(bp, txr-&gt;tx_cpr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return rc;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D bnxt_hwrm_tx_r=
ing_alloc(bp, txr, false);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0bnxt_hwrm_cp_ring_free(bp, txr-&gt;tx_cpr);<br>
What about ring allocated in previous steps? Don&#39;t you need to free the=
m<br>
too?<br></blockquote></div></div><div dir=3D"auto">Sure thanks, will take c=
are</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return rc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0txr-&gt;tx_prod =3D 0=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0txr-&gt;tx_cons =3D 0=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0txr-&gt;tx_hw_cons =
=3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WRITE_ONCE(txr-&gt;de=
v_state, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0synchronize_net();<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bnapi-&gt;flags &=
amp; BNXT_NAPI_FLAG_XDP)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0continue;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0txq =3D netdev_get_tx=
_queue(bp-&gt;dev, txr-&gt;txq_index);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (txq)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0netif_tx_start_queue(txq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void bnxt_free_irq(struct bnxt *bp)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bnxt_irq *irq;<br>
&gt; @@ -15647,6 +15726,16 @@ static int bnxt_queue_start(struct net_device=
 *dev, void *qmem, int idx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cpr =3D &amp;rxr-&gt;bnapi-&gt;cp_ring;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cpr-&gt;sw_stats-&gt;rx.rx_resets++;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (bp-&gt;flags &amp; BNXT_FLAG_SHARED_RINGS) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D bnxt_tx_queue_=
start(bp, idx);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0netdev_warn(bp-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;tx queue restart fai=
led: rc=3D%d\n&quot;, rc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0napi_enable(&amp;rxr-&gt;bnapi-&gt;napi);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bnxt_db_nq_arm(bp, &amp;cpr-&gt;cp_db, cpr-&gt;cp=
_raw_cons);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt;=3D BNXT_VNIC_NTUPLE; i+=
+) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vnic =3D &amp;bp=
-&gt;vnic_info[i];<br>
&gt;=C2=A0 <br>
&gt; @@ -15675,6 +15764,7 @@ static int bnxt_queue_stop(struct net_device *=
dev, void *qmem, int idx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bnxt *bp =3D netdev_priv(dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bnxt_rx_ring_info *rxr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bnxt_vnic_info *vnic;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct bnxt_napi *bnapi;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt;=3D BNXT_VNIC_NTUPLE; i+=
+) {<br>
&gt; @@ -15686,15 +15776,22 @@ static int bnxt_queue_stop(struct net_device=
 *dev, void *qmem, int idx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Make sure NAPI sees that the VNIC is disa=
bled */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0synchronize_net();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rxr =3D &amp;bp-&gt;rx_ring[idx];<br>
&gt; -=C2=A0 =C2=A0 =C2=A0cancel_work_sync(&amp;rxr-&gt;bnapi-&gt;<a href=
=3D"http://cp_ring.dim.work" rel=3D"noreferrer noreferrer" target=3D"_blank=
">cp_ring.dim.work</a>);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bnapi =3D rxr-&gt;bnapi;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cancel_work_sync(&amp;bnapi-&gt;<a href=3D"http:/=
/cp_ring.dim.work" rel=3D"noreferrer noreferrer" target=3D"_blank">cp_ring.=
dim.work</a>);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bnxt_hwrm_rx_ring_free(bp, rxr, false);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0page_pool_disable_direct_recycling(rxr-&gt;p=
age_pool);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (bnxt_separate_head_pool())<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0page_pool_disabl=
e_direct_recycling(rxr-&gt;head_pool);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (bp-&gt;flags &amp; BNXT_FLAG_SHARED_RINGS)<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bnxt_tx_queue_stop(bp=
, idx);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0napi_disable(&amp;bnapi-&gt;napi);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bnxt_hwrm_cp_ring_free(bp, rxr-&gt;rx_cpr);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bnxt_clear_one_cp_ring(bp, rxr-&gt;rx_cpr);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0bnxt_db_nq(bp, &amp;cpr-&gt;cp_db, cpr-&gt;cp_raw=
_cons);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(qmem, rxr, sizeof(*rxr));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bnxt_init_rx_ring_struct(bp, qmem);<br>
&gt; -- <br>
&gt; 2.30.1<br>
</blockquote></div></div></div>

--0000000000005c0aa9062ba10102--

--00000000000060ca33062ba1017c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
nSGLsSobByQoGh1GyLfFTXI7QOGn/6qvrJ7x9Oem5V7miUTD0wGAIozD7MCVoluf5Psa4Q2a5AFV
gROLty059Ex4oK55Op/0e3Aa/a8hZD/tPBT3WE70owdiCwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzb21uYXRoLmtvdHVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUabMpSsFcjDNUWMvGf76o
yB7jBJUwDQYJKoZIhvcNAQELBQADggEBAJBDQpQ1TqY57vpQbwtXYP0N01q8J3tfNA/K2vOiNOpv
IufqZ5WKdKEtmT21nujCeuaCQ6SmpWqCUJVkLd+u/sHR62vCo8j2fb1pTkA7jeuCAuT9YMPRE86M
sUphsGDq2ylriQ7y5kvl728hZ0Oakm3xUCnZ9DYS/32sFGSZyrCGZipTBnjK4n5uLQ0yekSLACiD
R0zi4nzkbhwXqDbDaB+Duk52ec/Vj4xuc2uWu9rTmJNVjdk0qu9vh48xcd/BzrlmwY0crGTijAC/
r4x2/y9OfG0FyVmakU0qwDnZX982aa66tXnKNgae2k20WCDVMM5FPTrbMsQyz6Hrv3bg6qgxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgx6wAr6NdQY0sTG
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBFoY+QplaAPjZvpqRrjON0M7eb6
Z+NNCbkA/1lX30jkMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1
MDExNDAyMDYxM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCRiBM16s/uFODT2YFRx0xcDaLGqCxyvCVfLvTKWNFTTuIu
ZrNl45IBDzFNKp+BFIZ90oMcheF+aWL0q+2Ssu4vxKBvLXTkWYCyFm3ndQ1GbADgqXZsSmyW+wwr
UWVivfKLhq1T4CgEkIMx+Y8Ido1lyyr7eadkPCbxB7UnYUJ7eFn3hYC6tutfj2JHMM7sAMkMdsWB
YtkGSkyUKpGjvGuTnuX9iKf1JvHzSv/Dqme6Qki42igZ8XxcOf7NeAlaN4i0ScNcN6IXzDhXaxpV
g/imqMEI4ZuNDl/9ddZYleGUldqpANFIjmEka2ru+M6oTzGZZG6sKSH9NyoQZZSh6/Vd
--00000000000060ca33062ba1017c--

