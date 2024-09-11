Return-Path: <netdev+bounces-127461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB4B9757A9
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33CF1C22FEA
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936021AC43E;
	Wed, 11 Sep 2024 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A60jFxyz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F0185954;
	Wed, 11 Sep 2024 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070027; cv=none; b=PENcIfTM1Rl4wYltCk20tXttTfnRqyFrkk9kwo7ls/Z7tW/FdVGo41v5JxqmmdzpV08CfzwVuz2q95qrm/E6RsLaInyL/aQ0OP/lqxZpRlVXhtFQyFy7nBRrE9p8AX1SmGO7b986aeT12xfd2noao9ewDnTHb+a+oyx2ARr1vBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070027; c=relaxed/simple;
	bh=PykaLIQc5PFb9VZbYJD1u6reZe5uMqUmFEqmoBKOKEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OO41MxUKNtumEwSOyWKFLaGWWHOaILqcHZhNzu7bxkgc1sYEvW8Y5NFmxM3SKhhzqpXR7pGKTt8GpJrz6IO197yg8T4PAuIydutRseL1ix4o6fl2Z9sLGJ7sFmYGm1tICEqB5fICtzcUZGITayjO7yrmfCQrG/zi5ktUimM9BmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A60jFxyz; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f75aa08a96so24939151fa.1;
        Wed, 11 Sep 2024 08:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726070024; x=1726674824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PykaLIQc5PFb9VZbYJD1u6reZe5uMqUmFEqmoBKOKEA=;
        b=A60jFxyzxVGivX9jZXsWehLVwf8G3qkpDfnBOHav/QDAdJbpw7IGgNMh09J/swCEwS
         0RBwYR2ybtnUiB30NDmSaXlihxwvSphu5M0fjJWf8sedq2gGlh6nKikUviMh5w6VlKtW
         FjClduoau/YUx3rG8D+wCPl44CZpPVDtSewZE+d7tgqGEShmh/JdnAHGoN+Gh1tge5Dq
         S1S0j2nID7SSsDsBb4lnpz3vOC1k3yLIIZ7zmuyi3GsYveFejOi1Y1u29PJIJ2eRAu83
         vtL6ZqLY7bAW59z7yGF1uv+Tmep175ONbsL6hArltMrQSprxN2HP8fDZQXhUSEGVNhBR
         iWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726070024; x=1726674824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PykaLIQc5PFb9VZbYJD1u6reZe5uMqUmFEqmoBKOKEA=;
        b=OvY8mnTzA2EDh3EG7q8pGxb+uJucauX6n664Y6IiWPw0lrwyi2xogoYjp1enbi+EAk
         jaH8XyQuxWft+mbBYtZ0bATBr1ek0guqLSRjN5MdycRNZqwFvPG34Lsxp9meQWigoACB
         0PoWGklS6ZD9G1RRKLBQda3LgoCsOcEA/eL5AmgdHoOlxoqMawQZnFw63i+RqhN7inCV
         53CRUJ8cpISxDpiBZOm3f8O3OHp8xaIsVFBY1HqXWl7L2Po6roH/vBetU2VS67NVb0Wc
         svFZmLqloG9pX/lQax5g79qHjvxvaA6pj9cCzfowxV5etuBHIuZ0b5QMzMwQVrddRfR6
         6kJA==
X-Forwarded-Encrypted: i=1; AJvYcCUQB+IjPySbi5ns+64a//re8wEActg+xgsGtqPp2y03iSd/KEKIlkZvdoDs5R3TE99UheA3HsIg@vger.kernel.org, AJvYcCUUQudooeFrN1QNxIcK9iFdDI702U6p6OBTsYBWHjMZv7WHdWvOy4s5wJH0/fR1qfWF8RivNgtJC1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YylHxNZmnsMCvRIGS2ZtDecMtg9y6ykFbcszGE0z0SQiYLQe7gm
	7pv1muV7asiKNGyeFEgtY8gfyv1d5q1YTBKRvfPnxJe6L50U1NwM1qosPv0ppaw/QYMcqpXwsqQ
	/mcn3AAEMoOBBbRPHLxJBBdvfi1g=
X-Google-Smtp-Source: AGHT+IG6HDeJrRkkQpPrvy9ow4vpOrfE8vFYsk0y/hRRcHirnJZMGNx+8B7kHrtWZy9vnnEoyjG4KnGVlKIt4JGzul0=
X-Received: by 2002:a05:651c:b2b:b0:2f3:b078:8490 with SMTP id
 38308e7fff4ca-2f77b73af57mr22133291fa.6.1726070023460; Wed, 11 Sep 2024
 08:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911145555.318605-1-ap420073@gmail.com> <20240911145555.318605-2-ap420073@gmail.com>
 <a5939151-adc6-4385-9072-ce4ff57bf67f@amd.com>
In-Reply-To: <a5939151-adc6-4385-9072-ce4ff57bf67f@amd.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 12 Sep 2024 00:53:31 +0900
Message-ID: <CAMArcTVH9fRU3kHf8g4U+e3fawMGiBNy1UctWG1Ni5rS=x6QQA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/4] bnxt_en: add support for rx-copybreak
 ethtool command
To: Brett Creeley <bcreeley@amd.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, corbet@lwn.net, michael.chan@broadcom.com, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, andrew@lunn.ch, hkallweit1@gmail.com, 
	kory.maincent@bootlin.com, ahmed.zaki@intel.com, paul.greenwalt@intel.com, 
	rrameshbabu@nvidia.com, idosch@nvidia.com, maxime.chevallier@bootlin.com, 
	danieller@nvidia.com, aleksander.lobakin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 12:36=E2=80=AFAM Brett Creeley <bcreeley@amd.com> w=
rote:

Hi Brett,
Thank you so much for your review!

>
>
>
> On 9/11/2024 7:55 AM, Taehee Yoo wrote:
> > Caution: This message originated from an External Source. Use proper ca=
ution when opening attachments, clicking links, or responding.
> >
> >
> > The bnxt_en driver supports rx-copybreak, but it couldn't be set by
> > userspace. Only the default value(256) has worked.
> > This patch makes the bnxt_en driver support following command.
> > `ethtool --set-tunable <devname> rx-copybreak <value> ` and
> > `ethtool --get-tunable <devname> rx-copybreak`.
> >
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >
> > v2:
> > - Define max/vim rx_copybreak value.
> >
> > drivers/net/ethernet/broadcom/bnxt/bnxt.c | 24 ++++++----
> > drivers/net/ethernet/broadcom/bnxt/bnxt.h | 6 ++-
> > .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 47 ++++++++++++++++++-
> > 3 files changed, 66 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
>
> <snip>
>
> > +static void bnxt_init_ring_params(struct bnxt *bp)
> > +{
> > + bp->rx_copybreak =3D BNXT_DEFAULT_RX_COPYBREAK;
> > +}
> > +
> > /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flag=
s must
> > * be set on entry.
> > */
> > @@ -4465,7 +4470,6 @@ void bnxt_set_ring_params(struct bnxt *bp)
> > rx_space =3D rx_size + ALIGN(max(NET_SKB_PAD, XDP_PACKET_HEADROOM), 8) =
+
> > SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> >
> > - bp->rx_copy_thresh =3D BNXT_RX_COPY_THRESH;
> > ring_size =3D bp->rx_ring_size;
> > bp->rx_agg_ring_size =3D 0;
> > bp->rx_agg_nr_pages =3D 0;
> > @@ -4510,7 +4514,8 @@ void bnxt_set_ring_params(struct bnxt *bp)
> > ALIGN(max(NET_SKB_PAD, XDP_PACKET_HEADROOM), 8) -
> > SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > } else {
> > - rx_size =3D SKB_DATA_ALIGN(BNXT_RX_COPY_THRESH + NET_IP_ALIGN);
> > + rx_size =3D SKB_DATA_ALIGN(bp->rx_copybreak +
> > + NET_IP_ALIGN);
>
> Tiny nit, but why did you wrap NET_IP_ALIGN to the next line?

Because It exceeds 80 characters line.

>
> > rx_space =3D rx_size + NET_SKB_PAD +
> > SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > }
> > @@ -6424,8 +6429,8 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp=
, struct bnxt_vnic_info *vnic)
> > VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV6);
> > req->enables |=3D
> > cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THRESHOLD_VALID);
> > - req->jumbo_thresh =3D cpu_to_le16(bp->rx_copy_thresh);
> > - req->hds_threshold =3D cpu_to_le16(bp->rx_copy_thresh);
> > + req->jumbo_thresh =3D cpu_to_le16(bp->rx_copybreak);
> > + req->hds_threshold =3D cpu_to_le16(bp->rx_copybreak);
> > }
> > req->vnic_id =3D cpu_to_le32(vnic->fw_vnic_id);
> > return hwrm_req_send(bp, req);
> > @@ -15864,6 +15869,7 @@ static int bnxt_init_one(struct pci_dev *pdev, =
const struct pci_device_id *ent)
> > bnxt_init_l2_fltr_tbl(bp);
> > bnxt_set_rx_skb_mode(bp, false);
> > bnxt_set_tpa_flags(bp);
> > + bnxt_init_ring_params(bp);
> > bnxt_set_ring_params(bp);
> > bnxt_rdma_aux_device_init(bp);
> > rc =3D bnxt_set_dflt_rings(bp, true);
>
> <snip>
>
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/driver=
s/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > index f71cc8188b4e..201c3fcba04e 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > @@ -4319,6 +4319,49 @@ static int bnxt_get_eee(struct net_device *dev, =
struct ethtool_keee *edata)
> > return 0;
> > }
> >
> > +static int bnxt_set_tunable(struct net_device *dev,
> > + const struct ethtool_tunable *tuna,
> > + const void *data)
> > +{
> > + struct bnxt *bp =3D netdev_priv(dev);
> > + u32 rx_copybreak;
> > +
> > + switch (tuna->id) {
> > + case ETHTOOL_RX_COPYBREAK:
> > + rx_copybreak =3D *(u32 *)data;
> > + if (rx_copybreak < BNXT_MIN_RX_COPYBREAK ||
> > + rx_copybreak > BNXT_MAX_RX_COPYBREAK)
> > + return -EINVAL;
> > + if (rx_copybreak !=3D bp->rx_copybreak) {
> > + bp->rx_copybreak =3D rx_copybreak;
>
> Should bp->rx_copybreak get set before closing the interface in the
> netif_running case? Can changing this while traffic is running cause any
> unexpected issues?
>
> I wonder if this would be better/safer?
>
> if (netif_running(dev)) {
> bnxt_close_nic(bp, false, false);
> bp->rx_copybreak =3D rx_copybreak;
> bnxt_set_ring_params(bp);
> bnxt_open_nic(bp, false, false);
> } else {
> bp->rx_copybreak =3D rx_copybreak;
> }

I think your suggestion is much safer!
I will use your suggestion in the v3 patch.

>
> Thanks,
>
> Brett
>
> > + if (netif_running(dev)) {
> > + bnxt_close_nic(bp, false, false);
> > + bnxt_set_ring_params(bp);
> > + bnxt_open_nic(bp, false, false);
> > + }
> > + }
> > + return 0;
> > + default:
> > + return -EOPNOTSUPP;
> > + }
> > +}
> > +
>
> <snip>

Thanks a lot!
Taehee Yoo

