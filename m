Return-Path: <netdev+bounces-249197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BE6D15667
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFDD0300DB87
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F59E2EBDE9;
	Mon, 12 Jan 2026 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FLbGKUJ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f225.google.com (mail-oi1-f225.google.com [209.85.167.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772D772617
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252609; cv=none; b=f3p6Fmn5hqc0i8CbbSn63lqGKgCnXMn8ozm5/wfmWO1TTgr47L8oiBciKjZ7cR9ng6LF0pNEbruPvpVmpXPbLzRtgViSnFuGaSKG2K4N4ploZ+we4nVQClYjwlDYE807jI+sw5vleYqaC7DNYdNBzIkiQKNltXlGgaiQ/jainAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252609; c=relaxed/simple;
	bh=lptPwHj8YrdFhw5//AFJQX7S240rRJnSm51t2CFrA/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVnl761dljhxlr7Fx3iqgAQC20yp18xD+zxu4mKhVyi9srO8K6jX66mJwwMU+0f8Rv2gkY4ZrYmrRDwr6nFqMAwJPx6l6nCIDu134oHBJDdFxt3kholaW8DnV8ONmBadHL8etCdKm3f+mtZ75uYibBOHNVjuxITU6mPxUhXNjs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FLbGKUJ9; arc=none smtp.client-ip=209.85.167.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f225.google.com with SMTP id 5614622812f47-459ac606f0bso4019051b6e.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 13:16:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768252606; x=1768857406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KE29seAxVK9AKFnmYIaHXNXSABwxLywSIqxDlf2nCY=;
        b=Eis00ZOpoNsDW/Otrf0/KIPDIfd3oP1DoViFvnPZ+g5LX1EpV/raT8h8o+EF5PtXac
         FGG0b6Ve/0h+CEAH/5dhODpcz8jOsWegGPDsFygvqqrSY8z/dkKVo8mu9sbetTFh5yuo
         5LzVEWEp42eIEFWcvkBvL5EhihsMrLgC5zP14YSdfo54erNCVeUV4vBxQihvUyNGCRkE
         N/8EXHwvG3nGnPRayPywM7iU2Xzb3P9qAcHJcyCq6U8IBWG23A8J7ZEKshKskvItWrP7
         3ghcg1Me5w2IBsvGNloy9Z0paasjPZgRGTIk9fDDMI48/4K0XfhyN4dsKmEJaprjn80f
         M31g==
X-Forwarded-Encrypted: i=1; AJvYcCUlmPVG++iDjM+YklsGtr0VrKcpbLJeymnRG0+zQyvL7YFD2Kxn1K/+17XZ21NJc7Wn+Qi8fxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7h0NArzjIwjhejxLgIsMJn94kMc1VpJmCRJGp2+WheUvcLDG6
	zOC0u1B4AE/B+yzs0jPpk0OtB56jh6LtJS2a4Vgn5OZsNXugzZbLyTBpfr63U8wZRveIwtzYR3Y
	pViTw/k5pUc/j5XFlKx1skPpl5lTEZlruL/ilD5nvlN/9Y8of5xRnVknBNKSSeYJbDfnmEUuh0p
	LIRbCnKizqR5iV7EcSsCM6SJhnhXtHp5bf90TdR/jL0YCa+uyqf1P9ILEvIkMMPpPmU7PTbsOGd
	HqEa73OLcEZYLCJYw==
X-Gm-Gg: AY/fxX4sTOtxMISxQuu+/uHK2EgSLFf1BcGgqhos65wdSq05H8ob9wdm5VL4pCKLMqZ
	/yaSVpVpHLQo2AzAa9XdHNo8mgiJxabsMuf/TKcGzYRr59sQgC4Fb9Z4iS2SeMb7NztHa6jFfBv
	03BGroXyLHJnldrd9vmP6cQ+qd0jTQHgQMlCrFnyOqsn2jS5AdZwtWSXu+QmR6vdGR+ZvjQoy+O
	jr5l3Z/kDPVe4hIuS/+WprJWDUQ2bmL12cRhJ6M99Wa1ZI4ZOE9upeYmPYz5h7xPggAnYziTyH2
	P4M5IRw9sZsTj8Cffiwo2AQvNDnbJKFXYkK06uYRcO4GkoUmG8nVaNhP8xM1qy6hiSwGZboOMCb
	M4YLbXhmUoDW+Dkwqq1X9VEekGzEm56FjmzjNKWMDY5E48baJlg7bKXQvTtk7m+TJmk6J/JvMok
	M=
X-Google-Smtp-Source: AGHT+IFjQuNj94G/ukUJb4mnZuaay8mjMx3dlnbhqAjpU9cRCawk013fSPG9Ui8JWzbf2OGaDB6G1wClccUq
X-Received: by 2002:a05:6808:124d:b0:44d:bc43:11a4 with SMTP id 5614622812f47-45a6bccffc9mr10062780b6e.4.1768252606271;
        Mon, 12 Jan 2026 13:16:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3ffa6aeebf7sm2233220fac.16.2026.01.12.13.16.45
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jan 2026 13:16:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ac363a9465so5939450eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 13:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768252605; x=1768857405; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0KE29seAxVK9AKFnmYIaHXNXSABwxLywSIqxDlf2nCY=;
        b=FLbGKUJ9mvOI4ZLdgDNLWGYZlBUQH16z2e5uKNtBt4cOLNoBDtSHRi794x0vVWN+4x
         VtZqtRHvjCWMLu0jGUpSG2qjHhYuBHFSGqXdR6Ii2PiXRqPhLeYCTjs3M0g3xpXNkF0T
         OWowPYOKrqqKgp8cwsdYZkfZhno8ryh2S/ZQY=
X-Forwarded-Encrypted: i=1; AJvYcCVdkoZ3QkLuf8WL3svYdh3PzpRmS3ioRb/Zj1a0iD7GcXwI17krkoxEifuAMK92QYmK5TPefJs=@vger.kernel.org
X-Received: by 2002:a05:7300:d717:b0:2b0:1602:469d with SMTP id 5a478bee46e88-2b17d3212b7mr13513394eec.34.1768252604623;
        Mon, 12 Jan 2026 13:16:44 -0800 (PST)
X-Received: by 2002:a05:7300:d717:b0:2b0:1602:469d with SMTP id
 5a478bee46e88-2b17d3212b7mr13513362eec.34.1768252604027; Mon, 12 Jan 2026
 13:16:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105072143.19447-1-bhargava.marreddy@broadcom.com>
 <20260105072143.19447-5-bhargava.marreddy@broadcom.com> <81fe0e2e-5f05-4258-b722-7a09e6d99182@redhat.com>
In-Reply-To: <81fe0e2e-5f05-4258-b722-7a09e6d99182@redhat.com>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Tue, 13 Jan 2026 02:46:28 +0530
X-Gm-Features: AZwV_QiVP5aSHg2bRpgteNyvfZpgBQeIFBhBQwfet51BoV2OONwy7XhAQoZVYp4
Message-ID: <CANXQDta2Xn33j+Da_K=7LUHKj-SgMNdKT2wx5W1Z5nFw2uKDhw@mail.gmail.com>
Subject: Re: [v4, net-next 4/7] bng_en: Add TX support
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, 
	vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000066d6530648376457"

--00000000000066d6530648376457
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 3:39=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 1/5/26 8:21 AM, Bhargava Marreddy wrote:
> > +static void __bnge_tx_int(struct bnge_net *bn, struct bnge_tx_ring_inf=
o *txr,
> > +                       int budget)
> > +{
> > +     u16 hw_cons =3D txr->tx_hw_cons;
> > +     struct bnge_dev *bd =3D bn->bd;
> > +     unsigned int tx_bytes =3D 0;
> > +     unsigned int tx_pkts =3D 0;
> > +     struct netdev_queue *txq;
> > +     u16 cons =3D txr->tx_cons;
> > +     skb_frag_t *frag;
> > +
> > +     txq =3D netdev_get_tx_queue(bn->netdev, txr->txq_index);
> > +
> > +     while (RING_TX(bn, cons) !=3D hw_cons) {
> > +             struct bnge_sw_tx_bd *tx_buf;
> > +             struct sk_buff *skb;
> > +             int j, last;
> > +
> > +             tx_buf =3D &txr->tx_buf_ring[RING_TX(bn, cons)];
> > +             skb =3D tx_buf->skb;
> > +             if (unlikely(!skb)) {
> > +                     bnge_sched_reset_txr(bn, txr, cons);
> > +                     return;
> > +             }
> > +
> > +             cons =3D NEXT_TX(cons);
> > +             tx_pkts++;
> > +             tx_bytes +=3D skb->len;
> > +             tx_buf->skb =3D NULL;
> > +
> > +             dma_unmap_single(bd->dev, dma_unmap_addr(tx_buf, mapping)=
,
> > +                              skb_headlen(skb), DMA_TO_DEVICE);
> > +             last =3D tx_buf->nr_frags;
> > +
> > +             for (j =3D 0; j < last; j++) {
> > +                     frag =3D &skb_shinfo(skb)->frags[j];
> > +                     cons =3D NEXT_TX(cons);
> > +                     tx_buf =3D &txr->tx_buf_ring[RING_TX(bn, cons)];
> > +                     netmem_dma_unmap_page_attrs(bd->dev,
> > +                                                 dma_unmap_addr(tx_buf=
,
> > +                                                                mappin=
g),
> > +                                                 skb_frag_size(frag),
> > +                                                 DMA_TO_DEVICE, 0);
> > +             }
>
> There is a similar chunk in bnge_free_tx_skbs(), you could avoid
> douplication factoring that out in common helper.

Agreed. I'll address this in the next revision.

>
> > +
> > +             cons =3D NEXT_TX(cons);
> > +
> > +             napi_consume_skb(skb, budget);
> > +     }
> > +
> > +     WRITE_ONCE(txr->tx_cons, cons);
> > +
> > +     __netif_txq_completed_wake(txq, tx_pkts, tx_bytes,
> > +                                bnge_tx_avail(bn, txr), bn->tx_wake_th=
resh,
> > +                                (READ_ONCE(txr->dev_state) =3D=3D
> > +                                 BNGE_DEV_STATE_CLOSING));
> > +}
> > +
> > +static void bnge_tx_int(struct bnge_net *bn, struct bnge_napi *bnapi,
> > +                     int budget)
> > +{
> > +     struct bnge_tx_ring_info *txr;
> > +     int i;
> > +
> > +     bnge_for_each_napi_tx(i, bnapi, txr) {
> > +             if (txr->tx_hw_cons !=3D RING_TX(bn, txr->tx_cons))
> > +                     __bnge_tx_int(bn, txr, budget);
>
> The above looks strange to me: there are multiple tx ring, but they are
> all served by the same irq?!?

The design allows multiple TX rings per NAPI instance, so the loop is
required to service all rings associated with that IRQ vector.

>
> > +     }
> > +
> > +     bnapi->events &=3D ~BNGE_TX_CMP_EVENT;
> > +}
> > +
> >  static void __bnge_poll_work_done(struct bnge_net *bn, struct bnge_nap=
i *bnapi,
> >                                 int budget)
> >  {
> >       struct bnge_rx_ring_info *rxr =3D bnapi->rx_ring;
> >
> > +     if ((bnapi->events & BNGE_TX_CMP_EVENT) && !bnapi->tx_fault)
> > +             bnge_tx_int(bn, bnapi, budget);
> > +
> >       if ((bnapi->events & BNGE_RX_EVENT)) {
> >               bnge_db_write(bn->bd, &rxr->rx_db, rxr->rx_prod);
> >               bnapi->events &=3D ~BNGE_RX_EVENT;
> > @@ -456,9 +548,26 @@ static int __bnge_poll_work(struct bnge_net *bn, s=
truct bnge_cp_ring_info *cpr,
> >               cmp_type =3D TX_CMP_TYPE(txcmp);
> >               if (cmp_type =3D=3D CMP_TYPE_TX_L2_CMP ||
> >                   cmp_type =3D=3D CMP_TYPE_TX_L2_COAL_CMP) {
> > -                     /*
> > -                      * Tx Compl Processng
> > -                      */
> > +                     u32 opaque =3D txcmp->tx_cmp_opaque;
> > +                     struct bnge_tx_ring_info *txr;
> > +                     u16 tx_freed;
> > +
> > +                     txr =3D bnapi->tx_ring[TX_OPAQUE_RING(opaque)];
> > +                     event |=3D BNGE_TX_CMP_EVENT;
> > +                     if (cmp_type =3D=3D CMP_TYPE_TX_L2_COAL_CMP)
> > +                             txr->tx_hw_cons =3D TX_CMP_SQ_CONS_IDX(tx=
cmp);
> > +                     else
> > +                             txr->tx_hw_cons =3D TX_OPAQUE_PROD(bn, op=
aque);
> > +                     tx_freed =3D ((txr->tx_hw_cons - txr->tx_cons) &
> > +                                 bn->tx_ring_mask);
> > +                     /* return full budget so NAPI will complete. */
> > +                     if (unlikely(tx_freed >=3D bn->tx_wake_thresh)) {
> > +                             rx_pkts =3D budget;
> > +                             raw_cons =3D NEXT_RAW_CMP(raw_cons);
> > +                             if (budget)
> > +                                     cpr->has_more_work =3D 1;
> > +                             break;
> > +                     }
> >               } else if (cmp_type >=3D CMP_TYPE_RX_L2_CMP &&
> >                          cmp_type <=3D CMP_TYPE_RX_L2_TPA_START_V3_CMP)=
 {
> >                       if (likely(budget))
> > @@ -613,3 +722,277 @@ int bnge_napi_poll(struct napi_struct *napi, int =
budget)
> >  poll_done:
> >       return work_done;
> >  }
> > +
> > +static u16 bnge_xmit_get_cfa_action(struct sk_buff *skb)
> > +{
> > +     struct metadata_dst *md_dst =3D skb_metadata_dst(skb);
> > +
> > +     if (!md_dst || md_dst->type !=3D METADATA_HW_PORT_MUX)
> > +             return 0;
> > +
> > +     return md_dst->u.port_info.port_id;
> > +}
> > +
> > +static const u16 bnge_lhint_arr[] =3D {
> > +     TX_BD_FLAGS_LHINT_512_AND_SMALLER,
> > +     TX_BD_FLAGS_LHINT_512_TO_1023,
> > +     TX_BD_FLAGS_LHINT_1024_TO_2047,
> > +     TX_BD_FLAGS_LHINT_1024_TO_2047,
> > +     TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> > +     TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> > +     TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> > +     TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> > +     TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> > +     TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> > +     TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> > +     TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> > +     TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> > +     TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> > +     TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> > +     TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> > +     TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> > +     TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> > +     TX_BD_FLAGS_LHINT_2048_AND_LARGER,
> > +};
> > +
> > +static void bnge_txr_db_kick(struct bnge_net *bn, struct bnge_tx_ring_=
info *txr,
> > +                          u16 prod)
> > +{
> > +     /* Sync BD data before updating doorbell */
> > +     wmb();
> > +     bnge_db_write(bn->bd, &txr->tx_db, prod);
> > +     txr->kick_pending =3D 0;
> > +}
> > +
> > +netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *de=
v)
> > +{
> > +     u32 len, free_size, vlan_tag_flags, cfa_action, flags;
> > +     struct bnge_net *bn =3D netdev_priv(dev);
> > +     struct bnge_tx_ring_info *txr;
> > +     struct bnge_dev *bd =3D bn->bd;
> > +     unsigned int length, pad =3D 0;
> > +     struct bnge_sw_tx_bd *tx_buf;
> > +     struct tx_bd *txbd, *txbd0;
> > +     struct netdev_queue *txq;
> > +     struct tx_bd_ext *txbd1;
> > +     u16 prod, last_frag;
> > +     dma_addr_t mapping;
> > +     __le32 lflags =3D 0;
> > +     skb_frag_t *frag;
> > +     int i;
> > +
> > +     i =3D skb_get_queue_mapping(skb);
> > +     if (unlikely(i >=3D bd->tx_nr_rings)) {
>
> Under which conditions the above statement can be true?

This is a defensive check to prevent out-of-bounds access during rare
races, such as an
ethtool -L reconfiguration where an in-flight skb might carry a stale
queue mapping.

Does this approach seem reasonable, or should I remove the check and
rely on the
stack's quiescence during reconfiguration?

>
> > +             dev_kfree_skb_any(skb);
> > +             dev_core_stats_tx_dropped_inc(dev);
> > +             return NETDEV_TX_OK;
> > +     }
> > +
> > +     txq =3D netdev_get_tx_queue(dev, i);
> > +     txr =3D &bn->tx_ring[bn->tx_ring_map[i]];
> > +     prod =3D txr->tx_prod;
> > +
> > +#if (MAX_SKB_FRAGS > TX_MAX_FRAGS)
> > +     if (skb_shinfo(skb)->nr_frags > TX_MAX_FRAGS) {
>
> You should probably implement ndo_features_check() and ensure the above
> condition will never happen.

Thanks, I'll address this in the next revision.

>
> > +             netdev_warn_once(dev, "SKB has too many (%d) fragments, m=
ax supported is %d.  SKB will be linearized.\n",
> > +                              skb_shinfo(skb)->nr_frags, TX_MAX_FRAGS)=
;
> > +             if (skb_linearize(skb)) {
> > +                     dev_kfree_skb_any(skb);
> > +                     dev_core_stats_tx_dropped_inc(dev);
> > +                     return NETDEV_TX_OK;
> > +             }
> > +     }
> > +#endif
> > +     free_size =3D bnge_tx_avail(bn, txr);
> > +     if (unlikely(free_size < skb_shinfo(skb)->nr_frags + 2)) {
> > +             /* We must have raced with NAPI cleanup */
> > +             if (net_ratelimit() && txr->kick_pending)
> > +                     netif_warn(bn, tx_err, dev,
> > +                                "bnge: ring busy w/ flush pending!\n")=
;
> > +             if (!netif_txq_try_stop(txq, bnge_tx_avail(bn, txr),
> > +                                     bn->tx_wake_thresh))
> > +                     return NETDEV_TX_BUSY;
> > +     }
> > +
> > +     if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
> > +             goto tx_free;
> > +
> > +     length =3D skb->len;
> > +     len =3D skb_headlen(skb);
> > +     last_frag =3D skb_shinfo(skb)->nr_frags;
> > +
> > +     txbd =3D &txr->tx_desc_ring[TX_RING(bn, prod)][TX_IDX(prod)];
> > +
> > +     tx_buf =3D &txr->tx_buf_ring[RING_TX(bn, prod)];
>
> The naming (TX_RING() vs RING_TX() with quite different meaning) is IMHO
> prone to errors.

Thanks, I'll address this in the next revision.

>
> > +     tx_buf->skb =3D skb;
> > +     tx_buf->nr_frags =3D last_frag;
> > +
> > +     vlan_tag_flags =3D 0;
> > +     cfa_action =3D bnge_xmit_get_cfa_action(skb);
> > +     if (skb_vlan_tag_present(skb)) {
> > +             vlan_tag_flags =3D TX_BD_CFA_META_KEY_VLAN |
> > +                              skb_vlan_tag_get(skb);
> > +             /* Currently supports 8021Q, 8021AD vlan offloads
> > +              * QINQ1, QINQ2, QINQ3 vlan headers are deprecated
> > +              */
> > +             if (skb->vlan_proto =3D=3D htons(ETH_P_8021Q))
> > +                     vlan_tag_flags |=3D 1 << TX_BD_CFA_META_TPID_SHIF=
T;
> > +     }
> > +
> > +     if (unlikely(skb->no_fcs))
> > +             lflags |=3D cpu_to_le32(TX_BD_FLAGS_NO_CRC);
> > +
> > +     if (length < BNGE_MIN_PKT_SIZE) {
> > +             pad =3D BNGE_MIN_PKT_SIZE - length;
> > +             if (skb_pad(skb, pad))
> > +                     /* SKB already freed. */
> > +                     goto tx_kick_pending;
> > +             length =3D BNGE_MIN_PKT_SIZE;
> > +     }
> > +
> > +     mapping =3D dma_map_single(bd->dev, skb->data, len, DMA_TO_DEVICE=
);
> > +
> > +     if (unlikely(dma_mapping_error(bd->dev, mapping)))
> > +             goto tx_free;
> > +
> > +     dma_unmap_addr_set(tx_buf, mapping, mapping);
> > +     flags =3D (len << TX_BD_LEN_SHIFT) | TX_BD_TYPE_LONG_TX_BD |
> > +             TX_BD_CNT(last_frag + 2);
> > +
> > +     txbd->tx_bd_haddr =3D cpu_to_le64(mapping);
> > +     txbd->tx_bd_opaque =3D SET_TX_OPAQUE(bn, txr, prod, 2 + last_frag=
);
> > +
> > +     prod =3D NEXT_TX(prod);
> > +     txbd1 =3D (struct tx_bd_ext *)
> > +             &txr->tx_desc_ring[TX_RING(bn, prod)][TX_IDX(prod)];
> > +
> > +     txbd1->tx_bd_hsize_lflags =3D lflags;
> > +     if (skb_is_gso(skb)) {
> > +             bool udp_gso =3D !!(skb_shinfo(skb)->gso_type & SKB_GSO_U=
DP_L4);
> > +             u32 hdr_len;
> > +
> > +             if (skb->encapsulation) {
> > +                     if (udp_gso)
> > +                             hdr_len =3D skb_inner_transport_offset(sk=
b) +
> > +                                       sizeof(struct udphdr);
> > +                     else
> > +                             hdr_len =3D skb_inner_tcp_all_headers(skb=
);
> > +             } else if (udp_gso) {
> > +                     hdr_len =3D skb_transport_offset(skb) +
> > +                               sizeof(struct udphdr);
> > +             } else {
> > +                     hdr_len =3D skb_tcp_all_headers(skb);
> > +             }
> > +
> > +             txbd1->tx_bd_hsize_lflags |=3D cpu_to_le32(TX_BD_FLAGS_LS=
O |
> > +                                     TX_BD_FLAGS_T_IPID |
> > +                                     (hdr_len << (TX_BD_HSIZE_SHIFT - =
1)));
> > +             length =3D skb_shinfo(skb)->gso_size;
> > +             txbd1->tx_bd_mss =3D cpu_to_le32(length);
> > +             length +=3D hdr_len;
> > +     } else if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> > +             txbd1->tx_bd_hsize_lflags |=3D
> > +                     cpu_to_le32(TX_BD_FLAGS_TCP_UDP_CHKSUM);
> > +             txbd1->tx_bd_mss =3D 0;
> > +     }
> > +
> > +     length >>=3D 9;
> > +     if (unlikely(length >=3D ARRAY_SIZE(bnge_lhint_arr))) {
>
> a proper ndo_features_check() should avoid the above check.

Thanks, I'll address this in the next revision.

Thanks,
Bhargava Marreddy

>
> /P
>

--00000000000066d6530648376457
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGqjCCBJKg
AwIBAgIMFJTEEB7G+bRSFHogMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTI1NVoXDTI3MDYyMTEzNTI1NVowge0xCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzERMA8GA1UEBBMITWFycmVkZHkxGDAWBgNVBCoTD0JoYXJnYXZhIENoZW5uYTEWMBQGA1UE
ChMNQlJPQURDT00gSU5DLjEnMCUGA1UEAwweYmhhcmdhdmEubWFycmVkZHlAYnJvYWRjb20uY29t
MS0wKwYJKoZIhvcNAQkBFh5iaGFyZ2F2YS5tYXJyZWRkeUBicm9hZGNvbS5jb20wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCq1sbXItt9Z31lzjb1WqEEegmLi72l7kDsxOJCWBCSkART
C/LTHOEoELrltkLJnRJiEujzwxS1/cV0LQse38GKog0UmiG5Jsq4YbNxmC7s3BhuuZYSoyCQ7Jg+
BzqQDU+k9ESjiD/R/11eODWJOxHipYabn/b+qYM+7CTSlVAy7vlJ+z1E/LnygVYHkWFN+IJSuY26
OWgSyvM8/+TPOrECYbo+kLcjqZfLS9/8EDThXQgg9oCeQOD8pwExycHc9w6ohJLoK7mVWrDol6cl
vW0XPONZARkdcZ69nJIHt/aMhihlyTUEqD0R8yRHfBp9nQwoSs8z+8xZ+cczX/XvtCVJAgMBAAGj
ggHiMIIB3jAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADCBkwYIKwYBBQUHAQEEgYYwgYMw
RgYIKwYBBQUHMAKGOmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZz
bWltZWNhMjAyMy5jcnQwOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMzBlBgNVHSAEXjBcMAkGB2eBDAEFAwMwCwYJKwYBBAGgMgEoMEIGCisG
AQQBoDIKAwIwNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3Np
dG9yeS8wQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2
c21pbWVjYTIwMjMuY3JsMCkGA1UdEQQiMCCBHmJoYXJnYXZhLm1hcnJlZGR5QGJyb2FkY29tLmNv
bTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAd
BgNVHQ4EFgQUkiPQZ5IKnCUHj3xJyO85n4OdVl4wDQYJKoZIhvcNAQELBQADggIBALtu8uco00Hh
dGp+c7lMOYHnFquYd6CXMYL1sBTi51PmiOKDO2xgfVvR7XI/kkqK5Iut0PYzv7kvUJUpG7zmL+XW
ABC2V9jvp5rUPlGSfP9Ugwx7yoGYEO+x42LeSKypUNV0UbBO8p32C1C/OkqikHlrQGuy8oUMNvOl
rrSoYMXdlZEravXgTAGO1PLgwVHEpXKy+D523j8B7GfDKHG7M7FjuqqyuxiDvFSoo3iEjYVzKZO9
NkcawmbO73W8o/5QE6GiIIvXyc+YUfVSNmX5/XpZFqbJ/uFhmiMmBhsT7xJA+L0NHTR7m09xCfZd
+XauyU42jyqUrgRWA36o20SMf1IURZYWgH4V7gWF2f95BiJs0uV1ddjo5ND4pejlKGkCGBfXSAWP
Ye5wAfgaC3LLKUnpYc3o6q5rUrhp9JlPey7HcnY9yJzQsw++DgKprh9TM/9jwlek8Kw1SIIiaFry
iriecfkPEiR9HVip63lbWsOrBFyroVEsNmmWQYKaDM4DLIDItDZNDw0FgM1b6R/E2M0ME1Dibn8P
alTJmpepLqlS2uwywOFZMLeiiVfTYSHwV/Gikq70KjVLNF59BWZMtRvyD5EoPHQavcOQTr7I/5Gc
GboBOYvJvkYzugiHmztSchEvGtPA10eDOxR1voXJlPH95MB73ZQwqQNpRPq04ElwMYICVzCCAlMC
AQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMf
R2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMFJTEEB7G+bRSFHogMA0GCWCGSAFlAwQC
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBl1jZtiXjUeygCJ9yYRayv4MTE+kJWJnWEYtkJa9J+fTAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMTIyMTE2NDVaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAiPmT4
VT4LNjYcd0DLHHe2X432kCgVzMnDDC8UWFUpXb7sQaTsOdVLVEWHaDj2UV4uy2Mliv/A93qQe+BU
m7VRTUvfGqd8J9GAvbTnpD6alEuiKFqFckBP9GBckEMtKstXkk8eQIzINOx0TFUQ1wEuIM/Baf/+
ol8OhckFPH/WpaOWYolFWJ8ie7m3IboMH1yzB11EMNnFtItfT9wRfm0OhPvMhm7lzNM4EDIVStTJ
5eQSaBdNWZ8V1PPwiJqZJmGt6ZKCfDqJvRG5t7Yyt3Bn5bGOtdN4CCBMuq/PIclUOEqDv4Qf17Qp
1E9RPbtZvD0h9BNhDK4uii2XMjpKuMfq
--00000000000066d6530648376457--

