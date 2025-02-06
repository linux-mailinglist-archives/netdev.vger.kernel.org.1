Return-Path: <netdev+bounces-163381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEA8A2A0F6
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 07:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42AEB3A7535
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 06:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B34224AF3;
	Thu,  6 Feb 2025 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Chw46CEM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C5F19BBA
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738823665; cv=none; b=DoFSofhBEBjLvTy5bUsH+vUESd40nloIhzeiswSc88lagliX1zJLb1GO2k/Gb4667svGxNlrpsTJ0ovlNbh6ee+fqaeZGyRx8wRSRdG/kS6GeNn9gbKsVFbOsaB5rTyNvAlbYrCl7cpOi8514tK52acR63evJk/vgPbwcIDxXA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738823665; c=relaxed/simple;
	bh=gdcvRnkJqf0QdwqHB8XQmbzPBlLn1mXkBQEcu0sAHq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZgosN5ubYDPCmFMsC3M7ow/hqoumkQxY6Zuwj35eO8G1YN35bhFRz8VbTBqJCS2+y+ir7MuZiWHlKg5ma8dCkEZwYz4YWMo33DGnppa6aLuzSTR0tVNUQ3hcM6zcsfnQ8EECBi0pWYTnss06hgyLgqBwbX0gYZ0UGstBIYu9gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Chw46CEM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361d5730caso16385e9.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 22:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738823661; x=1739428461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vr62OeFas5Z/te+lmyfFkt0xEwjd1tjGZy/VydV61m0=;
        b=Chw46CEM2M89DTBl0FzaIn86wephA8ehNgRo5ijYT5s8pmA5vyfK1120xLemHCD/cK
         LJ4Al6daxiXLq2K6TE2cAVTFQ1M6Esc1Ma2RLP3mRwT5I6LB7jh+T3hCkIGl53vPOJYV
         FWp5G5d2XzxEj2u9YyrfvP7X6tVEl6y+cCf0oR/DKLSmb3TxYDJ0S2CVrMCasEy15k8c
         3zeHISwXX0b1FaLEkwly5sUlzQR6msfHhQuZ9OOKUO3zvd8CN1MGeZAg1Q49O8ya3oGS
         Cqs/w/lb4u2yNaxnbiG5zzPOndozKDuFCbpgj7UFSZBlY8ngEReLnj9fcIxERmMc6WQs
         oN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738823661; x=1739428461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vr62OeFas5Z/te+lmyfFkt0xEwjd1tjGZy/VydV61m0=;
        b=IwlBJRtawcfRMmRR4yDQ2niX3E0tdHzltfb2s9tp2SWiZsyCI5Nv1XQY/hmzMeiOTQ
         bM+mbRdjih55issJ3bYhHPrk/sMSY4q3/wMkKRA57tmq3BAkwZthYgoVE+sXi0dNcdI8
         mrSkWTsWVKyzpu796ba1cE7MsNBvMnm+Br8IUFI8BflXm7iKmGP7NzHWqjYHhUTV0ehY
         e73wlKmwAmjrY2HXr+uRb7TwksBbGcXnv7L/HGmxtIti3mj1LuKjR2p2Gj2MuxPRYSMx
         d/WTbgUsjB19zYkJu/XP0TTLr6VsCsxzcOkcWRiGg6fWvS/m833EDRIz/TxzYfqcMqwz
         il/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnyF247F9bn6kZ8TY9mu243jd4aWRsgz43gPv7gfseWJDgs32X4AXqRpwRVsxQ1/zZY+iPzIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzuUueFTjEvxWsYXDGNOee/rRN2d59tLxkeMExk2Dk0+sZxi0e
	IxQK2QPZWwdpw3f6pnefx91Zd3I6BvCDUmdRN5X3i0zOWR/3tWW8jUV+fAzPrtnMBwButwqEYoh
	e7BYv2Wx734hr5eyjQvopHKaGrrivwVR9IewN
X-Gm-Gg: ASbGncvDhcXas9S6wngiLbz0wPXwzCu80cFnJJanrDj4kcwP8V3CNS+fy68xcUr0vve
	hyO3szNwIml8y27IN1Cadfv4NP2824zgbgKqkP7d8RX3S2r0M81Z/WD+DC1XKnMMxC4cW3Mx+lw
	==
X-Google-Smtp-Source: AGHT+IH2lvp+8KWpOMVZmxZ3XEv2GwX6Wp+Tkkt59GxN53RzyxB9oPgy2Acx3MJ/SoN+h45IaAyiREy6iDxYpO+n1EQ=
X-Received: by 2002:a05:600c:4ecb:b0:436:1aa8:d05d with SMTP id
 5b1f17b1804b1-4391511dbb2mr466795e9.0.1738823660551; Wed, 05 Feb 2025
 22:34:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204213121.14195-1-jeroendb@google.com> <CAH-L+nPRd5VmR5UAvpNkGCnhUvvOGyGC4fpVJ29FkK-c-YKeHg@mail.gmail.com>
In-Reply-To: <CAH-L+nPRd5VmR5UAvpNkGCnhUvvOGyGC4fpVJ29FkK-c-YKeHg@mail.gmail.com>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Wed, 5 Feb 2025 22:34:09 -0800
X-Gm-Features: AWEUYZl4NHiQ6n133pOkEPK9cNoGyjURfq273lFYl6WaraOTkX_kEQoMHNdVYSM
Message-ID: <CAG-FcCNvz2oBT=+kpCCu-Roav97TUaaAQUosymXM_nGd+QEbLQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] gve: Add RSS cache for non RSS device option scenario
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: Jeroen de Borst <jeroendb@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	pkaligineedi@google.com, shailend@google.com, andrew+netdev@lunn.ch, 
	willemb@google.com, hramamurthy@google.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 8:52=E2=80=AFAM Kalesh Anakkur Purayil
<kalesh-anakkur.purayil@broadcom.com> wrote:
>
> Hi Jerome,
>
> On Wed, Feb 5, 2025 at 3:02=E2=80=AFAM Jeroen de Borst <jeroendb@google.c=
om> wrote:
> >
> > From: Ziwei Xiao <ziweixiao@google.com>
> >
> > Not all the devices have the capability for the driver to query for the
> > registered RSS configuration. The driver can discover this by checking
> > the relevant device option during setup. If it cannot, the driver needs
> > to store the RSS config cache and directly return such cache when
> > queried by the ethtool. RSS config is inited when driver probes. Also t=
he
> > default RSS config will be adjusted when there is RX queue count change=
.
> >
> > At this point, only keys of GVE_RSS_KEY_SIZE and indirection tables of
> > GVE_RSS_INDIR_SIZE are supported.
> >
> > Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> > Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > Signed-off-by: Jeroen de Borst <jeroend@google.com>
> > ---
> > Changes in v2:
> >  - Change to initialize RSS config when the driver is up instead of
> >    doing that when the user setting the RSS.(Jakub Kicinski)
> >  - Use NL_SET_ERR_MSG_MOD to log errors when there is extack
> >    available.(Jakub Kicinski)
> >  - Use ethtool_rxfh_indir_default to set default RSS indir
> >    table.(Jakub Kicinski)
> >  - Adjust the default RSS config when there is RX queue count change to
> >    ensure the default RSS config is correct.
> >
> >  drivers/net/ethernet/google/gve/gve.h         | 16 +++-
> >  drivers/net/ethernet/google/gve/gve_adminq.c  | 64 ++++++++++---
> >  drivers/net/ethernet/google/gve/gve_ethtool.c | 60 ++++++++++--
> >  drivers/net/ethernet/google/gve/gve_main.c    | 92 ++++++++++++++++++-
> >  4 files changed, 209 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethern=
et/google/gve/gve.h
> > index 8167cc5fb0df..8e1e706c6f5e 100644
> > --- a/drivers/net/ethernet/google/gve/gve.h
> > +++ b/drivers/net/ethernet/google/gve/gve.h
> > @@ -68,6 +68,9 @@
> >  #define GVE_FLOW_RULE_IDS_CACHE_SIZE \
> >         (GVE_ADMINQ_BUFFER_SIZE / sizeof(((struct gve_adminq_queried_fl=
ow_rule *)0)->location))
> >
> > +#define GVE_RSS_KEY_SIZE       40
> > +#define GVE_RSS_INDIR_SIZE     128
> > +
> >  #define GVE_XDP_ACTIONS 5
> >
> >  #define GVE_GQ_TX_MIN_PKT_DESC_BYTES 182
> > @@ -672,6 +675,7 @@ struct gve_rx_alloc_rings_cfg {
> >         u16 packet_buffer_size;
> >         bool raw_addressing;
> >         bool enable_header_split;
> > +       bool reset_rss;
> >
> >         /* Allocated resources are returned here */
> >         struct gve_rx_ring *rx;
> > @@ -722,6 +726,11 @@ struct gve_flow_rules_cache {
> >         u32 rule_ids_cache_num;
> >  };
> >
> > +struct gve_rss_config {
> > +       u8 *hash_key;
> > +       u32 *hash_lut;
> > +};
> > +
> >  struct gve_priv {
> >         struct net_device *dev;
> >         struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
> > @@ -842,6 +851,8 @@ struct gve_priv {
> >
> >         u16 rss_key_size;
> >         u16 rss_lut_size;
> > +       bool cache_rss_config;
> > +       struct gve_rss_config rss_config;
> >  };
> >
> >  enum gve_service_task_flags_bit {
> > @@ -1210,13 +1221,16 @@ int gve_adjust_config(struct gve_priv *priv,
> >                       struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
> >  int gve_adjust_queues(struct gve_priv *priv,
> >                       struct gve_queue_config new_rx_config,
> > -                     struct gve_queue_config new_tx_config);
> > +                     struct gve_queue_config new_tx_config,
> > +                     bool reset_rss);
> >  /* flow steering rule */
> >  int gve_get_flow_rule_entry(struct gve_priv *priv, struct ethtool_rxnf=
c *cmd);
> >  int gve_get_flow_rule_ids(struct gve_priv *priv, struct ethtool_rxnfc =
*cmd, u32 *rule_locs);
> >  int gve_add_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd=
);
> >  int gve_del_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd=
);
> >  int gve_flow_rules_reset(struct gve_priv *priv);
> > +/* RSS config */
> > +int gve_init_rss_config(struct gve_priv *priv, u16 num_queues);
> >  /* report stats handling */
> >  void gve_handle_report_stats(struct gve_priv *priv);
> >  /* exported by ethtool.c */
> > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net=
/ethernet/google/gve/gve_adminq.c
> > index aa7d723011d0..a9ae094456cb 100644
> > --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> > +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> > @@ -885,6 +885,15 @@ static void gve_set_default_desc_cnt(struct gve_pr=
iv *priv,
> >         priv->min_rx_desc_cnt =3D priv->rx_desc_cnt;
> >  }
> >
> > +static void gve_set_default_rss_sizes(struct gve_priv *priv)
> > +{
> > +       if (!gve_is_gqi(priv)) {
> > +               priv->rss_key_size =3D GVE_RSS_KEY_SIZE;
> > +               priv->rss_lut_size =3D GVE_RSS_INDIR_SIZE;
> > +               priv->cache_rss_config =3D true;
> > +       }
> > +}
> > +
> >  static void gve_enable_supported_features(struct gve_priv *priv,
> >                                           u32 supported_features_mask,
> >                                           const struct gve_device_optio=
n_jumbo_frames
> > @@ -968,6 +977,10 @@ static void gve_enable_supported_features(struct g=
ve_priv *priv,
> >                         be16_to_cpu(dev_op_rss_config->hash_key_size);
> >                 priv->rss_lut_size =3D
> >                         be16_to_cpu(dev_op_rss_config->hash_lut_size);
> > +               priv->cache_rss_config =3D false;
> > +               dev_dbg(&priv->pdev->dev,
> > +                       "RSS device option enabled with key size of %u,=
 lut size of %u.\n",
> > +                       priv->rss_key_size, priv->rss_lut_size);
> >         }
> >  }
> >
> > @@ -1052,6 +1065,8 @@ int gve_adminq_describe_device(struct gve_priv *p=
riv)
> >         /* set default descriptor counts */
> >         gve_set_default_desc_cnt(priv, descriptor);
> >
> > +       gve_set_default_rss_sizes(priv);
> > +
> >         /* DQO supports LRO. */
> >         if (!gve_is_gqi(priv))
> >                 priv->dev->hw_features |=3D NETIF_F_LRO;
> > @@ -1276,8 +1291,9 @@ int gve_adminq_reset_flow_rules(struct gve_priv *=
priv)
> >
> >  int gve_adminq_configure_rss(struct gve_priv *priv, struct ethtool_rxf=
h_param *rxfh)
> >  {
> > +       const u32 *hash_lut_to_config =3D NULL;
> > +       const u8 *hash_key_to_config =3D NULL;
> >         dma_addr_t lut_bus =3D 0, key_bus =3D 0;
> > -       u16 key_size =3D 0, lut_size =3D 0;
> >         union gve_adminq_command cmd;
> >         __be32 *lut =3D NULL;
> >         u8 hash_alg =3D 0;
> > @@ -1287,7 +1303,7 @@ int gve_adminq_configure_rss(struct gve_priv *pri=
v, struct ethtool_rxfh_param *r
> >
> >         switch (rxfh->hfunc) {
> >         case ETH_RSS_HASH_NO_CHANGE:
> > -               break;
> > +               fallthrough;
> >         case ETH_RSS_HASH_TOP:
> >                 hash_alg =3D ETH_RSS_HASH_TOP;
> >                 break;
> > @@ -1296,27 +1312,44 @@ int gve_adminq_configure_rss(struct gve_priv *p=
riv, struct ethtool_rxfh_param *r
> >         }
> >
> >         if (rxfh->indir) {
> > -               lut_size =3D priv->rss_lut_size;
> > +               if (rxfh->indir_size !=3D priv->rss_lut_size)
> > +                       return -EINVAL;
> > +
> > +               hash_lut_to_config =3D rxfh->indir;
> > +       } else if (priv->cache_rss_config) {
> > +               hash_lut_to_config =3D priv->rss_config.hash_lut;
> > +       }
> > +
> > +       if (hash_lut_to_config) {
> >                 lut =3D dma_alloc_coherent(&priv->pdev->dev,
> > -                                        lut_size * sizeof(*lut),
> > +                                        priv->rss_lut_size * sizeof(*l=
ut),
> >                                          &lut_bus, GFP_KERNEL);
> >                 if (!lut)
> >                         return -ENOMEM;
> >
> >                 for (i =3D 0; i < priv->rss_lut_size; i++)
> > -                       lut[i] =3D cpu_to_be32(rxfh->indir[i]);
> > +                       lut[i] =3D cpu_to_be32(hash_lut_to_config[i]);
> >         }
> >
> >         if (rxfh->key) {
> > -               key_size =3D priv->rss_key_size;
> > +               if (rxfh->key_size !=3D priv->rss_key_size)
> You have to free lut memory in error case
Thanks for catching that. Will fix it on the V3 patch.
> > +                       return -EINVAL;
> > +
> > +               hash_key_to_config =3D rxfh->key;
> > +       } else if (priv->cache_rss_config) {
> > +               hash_key_to_config =3D priv->rss_config.hash_key;
> > +       }
> > +
> > +       if (hash_key_to_config) {
> >                 key =3D dma_alloc_coherent(&priv->pdev->dev,
> > -                                        key_size, &key_bus, GFP_KERNEL=
);
> > +                                        priv->rss_key_size,
> > +                                        &key_bus, GFP_KERNEL);
> >                 if (!key) {
> >                         err =3D -ENOMEM;
> >                         goto out;
> >                 }
> >
> > -               memcpy(key, rxfh->key, key_size);
> > +               memcpy(key, hash_key_to_config, priv->rss_key_size);
> >         }
> >
> >         /* Zero-valued fields in the cmd.configure_rss instruct the dev=
ice to
> > @@ -1330,8 +1363,10 @@ int gve_adminq_configure_rss(struct gve_priv *pr=
iv, struct ethtool_rxfh_param *r
> >                                           BIT(GVE_RSS_HASH_TCPV6) |
> >                                           BIT(GVE_RSS_HASH_UDPV6)),
> >                 .hash_alg =3D hash_alg,
> > -               .hash_key_size =3D cpu_to_be16(key_size),
> > -               .hash_lut_size =3D cpu_to_be16(lut_size),
> > +               .hash_key_size =3D
> > +                       cpu_to_be16((key_bus) ? priv->rss_key_size : 0)=
,
> > +               .hash_lut_size =3D
> > +                       cpu_to_be16((lut_bus) ? priv->rss_lut_size : 0)=
,
> >                 .hash_key_addr =3D cpu_to_be64(key_bus),
> >                 .hash_lut_addr =3D cpu_to_be64(lut_bus),
> >         };
> > @@ -1341,11 +1376,11 @@ int gve_adminq_configure_rss(struct gve_priv *p=
riv, struct ethtool_rxfh_param *r
> >  out:
> >         if (lut)
> >                 dma_free_coherent(&priv->pdev->dev,
> > -                                 lut_size * sizeof(*lut),
> > +                                 priv->rss_lut_size * sizeof(*lut),
> >                                   lut, lut_bus);
> >         if (key)
> >                 dma_free_coherent(&priv->pdev->dev,
> > -                                 key_size, key, key_bus);
> > +                                 priv->rss_key_size, key, key_bus);
> >         return err;
> >  }
> >
> > @@ -1449,12 +1484,15 @@ static int gve_adminq_process_rss_query(struct =
gve_priv *priv,
> >         rxfh->hfunc =3D descriptor->hash_alg;
> >
> >         rss_info_addr =3D (void *)(descriptor + 1);
> > -       if (rxfh->key)
> > +       if (rxfh->key) {
> > +               rxfh->key_size =3D priv->rss_key_size;
> >                 memcpy(rxfh->key, rss_info_addr, priv->rss_key_size);
> > +       }
> >
> >         rss_info_addr +=3D priv->rss_key_size;
> >         lut =3D (__be32 *)rss_info_addr;
> >         if (rxfh->indir) {
> > +               rxfh->indir_size =3D priv->rss_lut_size;
> >                 for (i =3D 0; i < priv->rss_lut_size; i++)
> >                         rxfh->indir[i] =3D be32_to_cpu(lut[i]);
> >         }
> > diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/ne=
t/ethernet/google/gve/gve_ethtool.c
> > index bdfc6e77b2af..efcafc607b2a 100644
> > --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> > +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> > @@ -482,6 +482,7 @@ static int gve_set_channels(struct net_device *netd=
ev,
> >         struct ethtool_channels old_settings;
> >         int new_tx =3D cmd->tx_count;
> >         int new_rx =3D cmd->rx_count;
> > +       bool reset_rss;
> >
> >         gve_get_channels(netdev, &old_settings);
> >
> > @@ -498,16 +499,14 @@ static int gve_set_channels(struct net_device *ne=
tdev,
> >                 return -EINVAL;
> >         }
> >
> > -       if (!netif_running(netdev)) {
> > -               priv->tx_cfg.num_queues =3D new_tx;
> > -               priv->rx_cfg.num_queues =3D new_rx;
> > -               return 0;
> > -       }
> > +       if (new_rx !=3D priv->rx_cfg.num_queues &&
> > +           priv->cache_rss_config && !netif_is_rxfh_configured(netdev)=
)
> > +               reset_rss =3D true;
> >
> >         new_tx_cfg.num_queues =3D new_tx;
> >         new_rx_cfg.num_queues =3D new_rx;
> >
> > -       return gve_adjust_queues(priv, new_rx_cfg, new_tx_cfg);
> > +       return gve_adjust_queues(priv, new_rx_cfg, new_tx_cfg, reset_rs=
s);
> >  }
> >
> >  static void gve_get_ringparam(struct net_device *netdev,
> > @@ -855,6 +854,25 @@ static u32 gve_get_rxfh_indir_size(struct net_devi=
ce *netdev)
> >         return priv->rss_lut_size;
> >  }
> >
> > +static void gve_get_rss_config_cache(struct gve_priv *priv,
> > +                                    struct ethtool_rxfh_param *rxfh)
> > +{
> > +       struct gve_rss_config *rss_config =3D &priv->rss_config;
> > +
> > +       rxfh->hfunc =3D ETH_RSS_HASH_TOP;
> > +
> > +       if (rxfh->key) {
> > +               rxfh->key_size =3D priv->rss_key_size;
> > +               memcpy(rxfh->key, rss_config->hash_key, priv->rss_key_s=
ize);
> > +       }
> > +
> > +       if (rxfh->indir) {
> > +               rxfh->indir_size =3D priv->rss_lut_size;
> > +               memcpy(rxfh->indir, rss_config->hash_lut,
> > +                      priv->rss_lut_size * sizeof(*rxfh->indir));
> > +       }
> > +}
> > +
> >  static int gve_get_rxfh(struct net_device *netdev, struct ethtool_rxfh=
_param *rxfh)
> >  {
> >         struct gve_priv *priv =3D netdev_priv(netdev);
> > @@ -862,18 +880,46 @@ static int gve_get_rxfh(struct net_device *netdev=
, struct ethtool_rxfh_param *rx
> >         if (!priv->rss_key_size || !priv->rss_lut_size)
> >                 return -EOPNOTSUPP;
> >
> > +       if (priv->cache_rss_config) {
> > +               gve_get_rss_config_cache(priv, rxfh);
> > +               return 0;
> > +       }
> > +
> >         return gve_adminq_query_rss_config(priv, rxfh);
> >  }
> >
> > +static void gve_set_rss_config_cache(struct gve_priv *priv,
> > +                                    struct ethtool_rxfh_param *rxfh)
> > +{
> > +       struct gve_rss_config *rss_config =3D &priv->rss_config;
> > +
> > +       if (rxfh->key)
> > +               memcpy(rss_config->hash_key, rxfh->key, priv->rss_key_s=
ize);
> > +
> > +       if (rxfh->indir)
> > +               memcpy(rss_config->hash_lut, rxfh->indir,
> > +                      priv->rss_lut_size * sizeof(*rxfh->indir));
> > +}
> > +
> >  static int gve_set_rxfh(struct net_device *netdev, struct ethtool_rxfh=
_param *rxfh,
> >                         struct netlink_ext_ack *extack)
> >  {
> >         struct gve_priv *priv =3D netdev_priv(netdev);
> > +       int err;
> >
> >         if (!priv->rss_key_size || !priv->rss_lut_size)
> >                 return -EOPNOTSUPP;
> >
> > -       return gve_adminq_configure_rss(priv, rxfh);
> > +       err =3D gve_adminq_configure_rss(priv, rxfh);
> > +       if (err) {
> > +               NL_SET_ERR_MSG_MOD(extack, "Fail to configure RSS confi=
g\n");
> > +               return err;
> > +       }
> > +
> > +       if (priv->cache_rss_config)
> > +               gve_set_rss_config_cache(priv, rxfh);
> > +
> > +       return 0;
> >  }
> >
> >  const struct ethtool_ops gve_ethtool_ops =3D {
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 533e659b15b3..d726a4d39b45 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -184,6 +184,49 @@ static void gve_free_flow_rule_caches(struct gve_p=
riv *priv)
> >         flow_rules_cache->rules_cache =3D NULL;
> >  }
> >
> > +static int gve_alloc_rss_config_cache(struct gve_priv *priv)
> > +{
> > +       struct gve_rss_config *rss_config =3D &priv->rss_config;
> > +       int err =3D 0;
> > +
> > +       if (!priv->cache_rss_config)
> > +               return 0;
> > +
> > +       rss_config->hash_key =3D kcalloc(priv->rss_key_size,
> > +                                      sizeof(rss_config->hash_key[0]),
> > +                                      GFP_KERNEL);
> > +       if (!rss_config->hash_key) {
> > +               dev_err(&priv->pdev->dev, "Cannot alloc rss key cache\n=
");
> There is no need of dev_err message in memory allocation failure path.
Thanks for the advice, will consider that.
> > +               return -ENOMEM;
> > +       }
> > +
> > +       rss_config->hash_lut =3D kcalloc(priv->rss_lut_size,
> > +                                      sizeof(rss_config->hash_lut[0]),
> > +                                      GFP_KERNEL);
> > +       if (!rss_config->hash_lut) {
> > +               dev_err(&priv->pdev->dev, "Cannot alloc rss lut cache\n=
");
> > +               err =3D -ENOMEM;
> > +               goto free_rss_key_cache;
> > +       }
> > +
> > +       return 0;
> > +
> > +free_rss_key_cache:
> > +       kfree(rss_config->hash_key);
> > +       rss_config->hash_key =3D NULL;
> > +       return err;
> Maybe you can return -ENOMEM here and hence avoid the need of the
> local variable err.
Thank you, will change that in the V3 patch.
> > +}
> > +
> > +static void gve_free_rss_config_cache(struct gve_priv *priv)
> > +{
> > +       struct gve_rss_config *rss_config =3D &priv->rss_config;
> > +
> > +       kfree(rss_config->hash_key);
> > +       kfree(rss_config->hash_lut);
> > +
> > +       memset(rss_config, 0, sizeof(*rss_config));
> > +}
> > +
> >  static int gve_alloc_counter_array(struct gve_priv *priv)
> >  {
> >         priv->counter_array =3D
> > @@ -575,9 +618,12 @@ static int gve_setup_device_resources(struct gve_p=
riv *priv)
> >         err =3D gve_alloc_flow_rule_caches(priv);
> >         if (err)
> >                 return err;
> > -       err =3D gve_alloc_counter_array(priv);
> > +       err =3D gve_alloc_rss_config_cache(priv);
> >         if (err)
> >                 goto abort_with_flow_rule_caches;
> > +       err =3D gve_alloc_counter_array(priv);
> > +       if (err)
> > +               goto abort_with_rss_config_cache;
> >         err =3D gve_alloc_notify_blocks(priv);
> >         if (err)
> >                 goto abort_with_counter;
> > @@ -611,6 +657,12 @@ static int gve_setup_device_resources(struct gve_p=
riv *priv)
> >                 }
> >         }
> >
> > +       err =3D gve_init_rss_config(priv, priv->rx_cfg.num_queues);
> > +       if (err) {
> > +               dev_err(&priv->pdev->dev, "Failed to init RSS config");
> > +               goto abort_with_ptype_lut;
> > +       }
> > +
> >         err =3D gve_adminq_report_stats(priv, priv->stats_report_len,
> >                                       priv->stats_report_bus,
> >                                       GVE_STATS_REPORT_TIMER_PERIOD);
> > @@ -629,6 +681,8 @@ static int gve_setup_device_resources(struct gve_pr=
iv *priv)
> >         gve_free_notify_blocks(priv);
> >  abort_with_counter:
> >         gve_free_counter_array(priv);
> > +abort_with_rss_config_cache:
> > +       gve_free_rss_config_cache(priv);
> >  abort_with_flow_rule_caches:
> >         gve_free_flow_rule_caches(priv);
> >
> > @@ -669,6 +723,7 @@ static void gve_teardown_device_resources(struct gv=
e_priv *priv)
> >         priv->ptype_lut_dqo =3D NULL;
> >
> >         gve_free_flow_rule_caches(priv);
> > +       gve_free_rss_config_cache(priv);
> >         gve_free_counter_array(priv);
> >         gve_free_notify_blocks(priv);
> >         gve_free_stats_report(priv);
> > @@ -1390,6 +1445,12 @@ static int gve_queues_start(struct gve_priv *pri=
v,
> >         if (err)
> >                 goto stop_and_free_rings;
> >
> > +       if (rx_alloc_cfg->reset_rss) {
> > +               err =3D gve_init_rss_config(priv, priv->rx_cfg.num_queu=
es);
> > +               if (err)
> > +                       goto reset;
> > +       }
> > +
> >         err =3D gve_register_qpls(priv);
> >         if (err)
> >                 goto reset;
> > @@ -1786,6 +1847,26 @@ static int gve_xdp(struct net_device *dev, struc=
t netdev_bpf *xdp)
> >         }
> >  }
> >
> > +int gve_init_rss_config(struct gve_priv *priv, u16 num_queues)
> > +{
> > +       struct gve_rss_config *rss_config =3D &priv->rss_config;
> > +       struct ethtool_rxfh_param rxfh;
> > +       u16 i;
> > +
> > +       if (!priv->cache_rss_config)
> > +               return 0;
> > +
> > +       for (i =3D 0; i < priv->rss_lut_size; i++)
> > +               rss_config->hash_lut[i] =3D
> > +                       ethtool_rxfh_indir_default(i, num_queues);
> > +
> > +       netdev_rss_key_fill(rss_config->hash_key, priv->rss_key_size);
> > +
> > +       rxfh.hfunc =3D ETH_RSS_HASH_TOP;
> > +
> > +       return gve_adminq_configure_rss(priv, &rxfh);
> > +}
> > +
> >  int gve_flow_rules_reset(struct gve_priv *priv)
> >  {
> >         if (!priv->max_flow_rules)
> > @@ -1834,7 +1915,8 @@ int gve_adjust_config(struct gve_priv *priv,
> >
> >  int gve_adjust_queues(struct gve_priv *priv,
> >                       struct gve_queue_config new_rx_config,
> > -                     struct gve_queue_config new_tx_config)
> > +                     struct gve_queue_config new_tx_config,
> > +                     bool reset_rss)
> >  {
> >         struct gve_tx_alloc_rings_cfg tx_alloc_cfg =3D {0};
> >         struct gve_rx_alloc_rings_cfg rx_alloc_cfg =3D {0};
> > @@ -1847,6 +1929,7 @@ int gve_adjust_queues(struct gve_priv *priv,
> >         tx_alloc_cfg.qcfg =3D &new_tx_config;
> >         rx_alloc_cfg.qcfg_tx =3D &new_tx_config;
> >         rx_alloc_cfg.qcfg =3D &new_rx_config;
> > +       rx_alloc_cfg.reset_rss =3D reset_rss;
> >         tx_alloc_cfg.num_rings =3D new_tx_config.num_queues;
> >
> >         /* Add dedicated XDP TX queues if enabled. */
> > @@ -1858,6 +1941,11 @@ int gve_adjust_queues(struct gve_priv *priv,
> >                 return err;
> >         }
> >         /* Set the config for the next up. */
> > +       if (reset_rss) {
> > +               err =3D gve_init_rss_config(priv, new_rx_config.num_que=
ues);
> > +               if (err)
> > +                       return err;
> > +       }
> >         priv->tx_cfg =3D new_tx_config;
> >         priv->rx_cfg =3D new_rx_config;
> >
> > --
> > 2.48.1.362.g079036d154-goog
> >
> >
>
>
> --
> Regards,
> Kalesh AP

