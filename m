Return-Path: <netdev+bounces-163150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17001A296C3
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194F31886794
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82791FCD07;
	Wed,  5 Feb 2025 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JiaC81hu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2461DC9AF
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774348; cv=none; b=tgkqXH1YG/S4mYEpZX+A+4e2a+WowvLv5dfBHYxMxfAVUTcI1p3+XByWV0WWqLD12UvFtOlQrMi7U/rkXm8rYJ9PWb/oOAq8PvwPBkUdhPqDlltYpTJjVON8HxSeiytriV7EeYI3AHsFokUmY+bMAj5OohAysouMm3803ghg3Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774348; c=relaxed/simple;
	bh=k6r+9O24O/6ptm7/RJMaYWG09RHZsbPqM/uaBHr9BYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCpOvBiCVfHCxv8Gywkfowg1sJerCGwdmxBwgPeWY/VkeRp806SLLSnkxr3Pgg9h+dxvXgA6jB4uK5Phl5nSKDuX30T9L4bF/+j/9dZHCpAbNWCTa/caKIuOVNF29PS5mTJtk4F2AO9CEevUt8RSRGMHQ/F9bsy5CBCYF6t6WEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JiaC81hu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2165cb60719so804895ad.0
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 08:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738774346; x=1739379146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Nxx3EGa+GTVRU7ejcRa/9kNhyevLAsZKg3shCLPK7g=;
        b=JiaC81hunD5fq96PmJKgD3J/DXGZ0s0BAaXxi3jaiHWI+HtSvhqvH4GNHvTRH4nlBa
         7ukExiIIc+pBcdHd3ZZfDvKMF3T6yVUjFq8k9lI/wRke8rWfvRkalUzwDEvylnMX6BNh
         /+yNXUJi7EKm/4SDENNdlQeMnLNUw+XNEy2eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738774346; x=1739379146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Nxx3EGa+GTVRU7ejcRa/9kNhyevLAsZKg3shCLPK7g=;
        b=qkptMM7auB5N321NU2PAGrVAxse/aGiWi8aBoc6SDqjgDuxgA9OrIgiqnO3aEuRoVu
         s3rM6/P/OEkTSS9mGMN1kxDKY9hQcq85jli6pJlVZuELluDq5BnMPld6AWjXF3pZUFjo
         UJLhoYioOp5RrVN7Xe3NKsRTomUSeJ1DErjSWKsccc93ZpSVciKSZ6+baMVfPkWPKM3w
         uWr6nFBnIpLHm3i3WdrXEwzN283aKhWZXYbEGl5Ft2qZo6L/Qe3iVvgzxtnw6nj2UmR3
         7pJ3BybXJ/sKJZ2c+VXz0auwLHutp+JSOLGwoPbv4aeeW40Q8qmivPEJ56kCBS2JmDQK
         g4zQ==
X-Gm-Message-State: AOJu0YyN7/R4ZzdrUACYqFZKl0QbE2ntSulDc7yAAr7gjX5VOS3oazSV
	XM/9K1o9C8sb9szWWQLLGKHSchT8iAnmNbLCqAj/j3/TphbKnSYK9fxArg/0AsHROGH9grzNctX
	D8jxERX4ePHgqSK5YKL+Irh2uN9jRNdDNmAa9
X-Gm-Gg: ASbGncs4S+XwXlMB4jKN+8qPbIg2tSu9+c5P8jhO6idHDBdLzG4UiP7gvMMTs0Gfce6
	SFTIWBx1si1FyvppOAWsNn/SsMCB9AlpwkW2vyqiDkaSNveERk/WDyJ5k/hSPlKHCD7GKjFQ=
X-Google-Smtp-Source: AGHT+IGoU5g1yq+o3IWfKuMCweYnNeC3fSTjXtSBJL7f+or1cMDuX1a9NmYr+vWqIiX9eHfoN106on/NIla+g+aJdJQ=
X-Received: by 2002:a05:6a00:1946:b0:727:3ac3:7f9c with SMTP id
 d2e1a72fcca58-73035107de4mr4538556b3a.10.1738774345550; Wed, 05 Feb 2025
 08:52:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204213121.14195-1-jeroendb@google.com>
In-Reply-To: <20250204213121.14195-1-jeroendb@google.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 5 Feb 2025 22:22:11 +0530
X-Gm-Features: AWEUYZkTNQ2pHvkuavQFE7zQWNNzxNaIq5hcaAxfosY1F_5HjMYCPp9gfQ4rfNg
Message-ID: <CAH-L+nPRd5VmR5UAvpNkGCnhUvvOGyGC4fpVJ29FkK-c-YKeHg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] gve: Add RSS cache for non RSS device option scenario
To: Jeroen de Borst <jeroendb@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, pkaligineedi@google.com, 
	shailend@google.com, andrew+netdev@lunn.ch, willemb@google.com, 
	hramamurthy@google.com, ziweixiao@google.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, Jeroen de Borst <jeroend@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003cf567062d67f35d"

--0000000000003cf567062d67f35d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jerome,

On Wed, Feb 5, 2025 at 3:02=E2=80=AFAM Jeroen de Borst <jeroendb@google.com=
> wrote:
>
> From: Ziwei Xiao <ziweixiao@google.com>
>
> Not all the devices have the capability for the driver to query for the
> registered RSS configuration. The driver can discover this by checking
> the relevant device option during setup. If it cannot, the driver needs
> to store the RSS config cache and directly return such cache when
> queried by the ethtool. RSS config is inited when driver probes. Also the
> default RSS config will be adjusted when there is RX queue count change.
>
> At this point, only keys of GVE_RSS_KEY_SIZE and indirection tables of
> GVE_RSS_INDIR_SIZE are supported.
>
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Signed-off-by: Jeroen de Borst <jeroend@google.com>
> ---
> Changes in v2:
>  - Change to initialize RSS config when the driver is up instead of
>    doing that when the user setting the RSS.(Jakub Kicinski)
>  - Use NL_SET_ERR_MSG_MOD to log errors when there is extack
>    available.(Jakub Kicinski)
>  - Use ethtool_rxfh_indir_default to set default RSS indir
>    table.(Jakub Kicinski)
>  - Adjust the default RSS config when there is RX queue count change to
>    ensure the default RSS config is correct.
>
>  drivers/net/ethernet/google/gve/gve.h         | 16 +++-
>  drivers/net/ethernet/google/gve/gve_adminq.c  | 64 ++++++++++---
>  drivers/net/ethernet/google/gve/gve_ethtool.c | 60 ++++++++++--
>  drivers/net/ethernet/google/gve/gve_main.c    | 92 ++++++++++++++++++-
>  4 files changed, 209 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index 8167cc5fb0df..8e1e706c6f5e 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -68,6 +68,9 @@
>  #define GVE_FLOW_RULE_IDS_CACHE_SIZE \
>         (GVE_ADMINQ_BUFFER_SIZE / sizeof(((struct gve_adminq_queried_flow=
_rule *)0)->location))
>
> +#define GVE_RSS_KEY_SIZE       40
> +#define GVE_RSS_INDIR_SIZE     128
> +
>  #define GVE_XDP_ACTIONS 5
>
>  #define GVE_GQ_TX_MIN_PKT_DESC_BYTES 182
> @@ -672,6 +675,7 @@ struct gve_rx_alloc_rings_cfg {
>         u16 packet_buffer_size;
>         bool raw_addressing;
>         bool enable_header_split;
> +       bool reset_rss;
>
>         /* Allocated resources are returned here */
>         struct gve_rx_ring *rx;
> @@ -722,6 +726,11 @@ struct gve_flow_rules_cache {
>         u32 rule_ids_cache_num;
>  };
>
> +struct gve_rss_config {
> +       u8 *hash_key;
> +       u32 *hash_lut;
> +};
> +
>  struct gve_priv {
>         struct net_device *dev;
>         struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
> @@ -842,6 +851,8 @@ struct gve_priv {
>
>         u16 rss_key_size;
>         u16 rss_lut_size;
> +       bool cache_rss_config;
> +       struct gve_rss_config rss_config;
>  };
>
>  enum gve_service_task_flags_bit {
> @@ -1210,13 +1221,16 @@ int gve_adjust_config(struct gve_priv *priv,
>                       struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
>  int gve_adjust_queues(struct gve_priv *priv,
>                       struct gve_queue_config new_rx_config,
> -                     struct gve_queue_config new_tx_config);
> +                     struct gve_queue_config new_tx_config,
> +                     bool reset_rss);
>  /* flow steering rule */
>  int gve_get_flow_rule_entry(struct gve_priv *priv, struct ethtool_rxnfc =
*cmd);
>  int gve_get_flow_rule_ids(struct gve_priv *priv, struct ethtool_rxnfc *c=
md, u32 *rule_locs);
>  int gve_add_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd);
>  int gve_del_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd);
>  int gve_flow_rules_reset(struct gve_priv *priv);
> +/* RSS config */
> +int gve_init_rss_config(struct gve_priv *priv, u16 num_queues);
>  /* report stats handling */
>  void gve_handle_report_stats(struct gve_priv *priv);
>  /* exported by ethtool.c */
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index aa7d723011d0..a9ae094456cb 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -885,6 +885,15 @@ static void gve_set_default_desc_cnt(struct gve_priv=
 *priv,
>         priv->min_rx_desc_cnt =3D priv->rx_desc_cnt;
>  }
>
> +static void gve_set_default_rss_sizes(struct gve_priv *priv)
> +{
> +       if (!gve_is_gqi(priv)) {
> +               priv->rss_key_size =3D GVE_RSS_KEY_SIZE;
> +               priv->rss_lut_size =3D GVE_RSS_INDIR_SIZE;
> +               priv->cache_rss_config =3D true;
> +       }
> +}
> +
>  static void gve_enable_supported_features(struct gve_priv *priv,
>                                           u32 supported_features_mask,
>                                           const struct gve_device_option_=
jumbo_frames
> @@ -968,6 +977,10 @@ static void gve_enable_supported_features(struct gve=
_priv *priv,
>                         be16_to_cpu(dev_op_rss_config->hash_key_size);
>                 priv->rss_lut_size =3D
>                         be16_to_cpu(dev_op_rss_config->hash_lut_size);
> +               priv->cache_rss_config =3D false;
> +               dev_dbg(&priv->pdev->dev,
> +                       "RSS device option enabled with key size of %u, l=
ut size of %u.\n",
> +                       priv->rss_key_size, priv->rss_lut_size);
>         }
>  }
>
> @@ -1052,6 +1065,8 @@ int gve_adminq_describe_device(struct gve_priv *pri=
v)
>         /* set default descriptor counts */
>         gve_set_default_desc_cnt(priv, descriptor);
>
> +       gve_set_default_rss_sizes(priv);
> +
>         /* DQO supports LRO. */
>         if (!gve_is_gqi(priv))
>                 priv->dev->hw_features |=3D NETIF_F_LRO;
> @@ -1276,8 +1291,9 @@ int gve_adminq_reset_flow_rules(struct gve_priv *pr=
iv)
>
>  int gve_adminq_configure_rss(struct gve_priv *priv, struct ethtool_rxfh_=
param *rxfh)
>  {
> +       const u32 *hash_lut_to_config =3D NULL;
> +       const u8 *hash_key_to_config =3D NULL;
>         dma_addr_t lut_bus =3D 0, key_bus =3D 0;
> -       u16 key_size =3D 0, lut_size =3D 0;
>         union gve_adminq_command cmd;
>         __be32 *lut =3D NULL;
>         u8 hash_alg =3D 0;
> @@ -1287,7 +1303,7 @@ int gve_adminq_configure_rss(struct gve_priv *priv,=
 struct ethtool_rxfh_param *r
>
>         switch (rxfh->hfunc) {
>         case ETH_RSS_HASH_NO_CHANGE:
> -               break;
> +               fallthrough;
>         case ETH_RSS_HASH_TOP:
>                 hash_alg =3D ETH_RSS_HASH_TOP;
>                 break;
> @@ -1296,27 +1312,44 @@ int gve_adminq_configure_rss(struct gve_priv *pri=
v, struct ethtool_rxfh_param *r
>         }
>
>         if (rxfh->indir) {
> -               lut_size =3D priv->rss_lut_size;
> +               if (rxfh->indir_size !=3D priv->rss_lut_size)
> +                       return -EINVAL;
> +
> +               hash_lut_to_config =3D rxfh->indir;
> +       } else if (priv->cache_rss_config) {
> +               hash_lut_to_config =3D priv->rss_config.hash_lut;
> +       }
> +
> +       if (hash_lut_to_config) {
>                 lut =3D dma_alloc_coherent(&priv->pdev->dev,
> -                                        lut_size * sizeof(*lut),
> +                                        priv->rss_lut_size * sizeof(*lut=
),
>                                          &lut_bus, GFP_KERNEL);
>                 if (!lut)
>                         return -ENOMEM;
>
>                 for (i =3D 0; i < priv->rss_lut_size; i++)
> -                       lut[i] =3D cpu_to_be32(rxfh->indir[i]);
> +                       lut[i] =3D cpu_to_be32(hash_lut_to_config[i]);
>         }
>
>         if (rxfh->key) {
> -               key_size =3D priv->rss_key_size;
> +               if (rxfh->key_size !=3D priv->rss_key_size)
You have to free lut memory in error case
> +                       return -EINVAL;
> +
> +               hash_key_to_config =3D rxfh->key;
> +       } else if (priv->cache_rss_config) {
> +               hash_key_to_config =3D priv->rss_config.hash_key;
> +       }
> +
> +       if (hash_key_to_config) {
>                 key =3D dma_alloc_coherent(&priv->pdev->dev,
> -                                        key_size, &key_bus, GFP_KERNEL);
> +                                        priv->rss_key_size,
> +                                        &key_bus, GFP_KERNEL);
>                 if (!key) {
>                         err =3D -ENOMEM;
>                         goto out;
>                 }
>
> -               memcpy(key, rxfh->key, key_size);
> +               memcpy(key, hash_key_to_config, priv->rss_key_size);
>         }
>
>         /* Zero-valued fields in the cmd.configure_rss instruct the devic=
e to
> @@ -1330,8 +1363,10 @@ int gve_adminq_configure_rss(struct gve_priv *priv=
, struct ethtool_rxfh_param *r
>                                           BIT(GVE_RSS_HASH_TCPV6) |
>                                           BIT(GVE_RSS_HASH_UDPV6)),
>                 .hash_alg =3D hash_alg,
> -               .hash_key_size =3D cpu_to_be16(key_size),
> -               .hash_lut_size =3D cpu_to_be16(lut_size),
> +               .hash_key_size =3D
> +                       cpu_to_be16((key_bus) ? priv->rss_key_size : 0),
> +               .hash_lut_size =3D
> +                       cpu_to_be16((lut_bus) ? priv->rss_lut_size : 0),
>                 .hash_key_addr =3D cpu_to_be64(key_bus),
>                 .hash_lut_addr =3D cpu_to_be64(lut_bus),
>         };
> @@ -1341,11 +1376,11 @@ int gve_adminq_configure_rss(struct gve_priv *pri=
v, struct ethtool_rxfh_param *r
>  out:
>         if (lut)
>                 dma_free_coherent(&priv->pdev->dev,
> -                                 lut_size * sizeof(*lut),
> +                                 priv->rss_lut_size * sizeof(*lut),
>                                   lut, lut_bus);
>         if (key)
>                 dma_free_coherent(&priv->pdev->dev,
> -                                 key_size, key, key_bus);
> +                                 priv->rss_key_size, key, key_bus);
>         return err;
>  }
>
> @@ -1449,12 +1484,15 @@ static int gve_adminq_process_rss_query(struct gv=
e_priv *priv,
>         rxfh->hfunc =3D descriptor->hash_alg;
>
>         rss_info_addr =3D (void *)(descriptor + 1);
> -       if (rxfh->key)
> +       if (rxfh->key) {
> +               rxfh->key_size =3D priv->rss_key_size;
>                 memcpy(rxfh->key, rss_info_addr, priv->rss_key_size);
> +       }
>
>         rss_info_addr +=3D priv->rss_key_size;
>         lut =3D (__be32 *)rss_info_addr;
>         if (rxfh->indir) {
> +               rxfh->indir_size =3D priv->rss_lut_size;
>                 for (i =3D 0; i < priv->rss_lut_size; i++)
>                         rxfh->indir[i] =3D be32_to_cpu(lut[i]);
>         }
> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/=
ethernet/google/gve/gve_ethtool.c
> index bdfc6e77b2af..efcafc607b2a 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -482,6 +482,7 @@ static int gve_set_channels(struct net_device *netdev=
,
>         struct ethtool_channels old_settings;
>         int new_tx =3D cmd->tx_count;
>         int new_rx =3D cmd->rx_count;
> +       bool reset_rss;
>
>         gve_get_channels(netdev, &old_settings);
>
> @@ -498,16 +499,14 @@ static int gve_set_channels(struct net_device *netd=
ev,
>                 return -EINVAL;
>         }
>
> -       if (!netif_running(netdev)) {
> -               priv->tx_cfg.num_queues =3D new_tx;
> -               priv->rx_cfg.num_queues =3D new_rx;
> -               return 0;
> -       }
> +       if (new_rx !=3D priv->rx_cfg.num_queues &&
> +           priv->cache_rss_config && !netif_is_rxfh_configured(netdev))
> +               reset_rss =3D true;
>
>         new_tx_cfg.num_queues =3D new_tx;
>         new_rx_cfg.num_queues =3D new_rx;
>
> -       return gve_adjust_queues(priv, new_rx_cfg, new_tx_cfg);
> +       return gve_adjust_queues(priv, new_rx_cfg, new_tx_cfg, reset_rss)=
;
>  }
>
>  static void gve_get_ringparam(struct net_device *netdev,
> @@ -855,6 +854,25 @@ static u32 gve_get_rxfh_indir_size(struct net_device=
 *netdev)
>         return priv->rss_lut_size;
>  }
>
> +static void gve_get_rss_config_cache(struct gve_priv *priv,
> +                                    struct ethtool_rxfh_param *rxfh)
> +{
> +       struct gve_rss_config *rss_config =3D &priv->rss_config;
> +
> +       rxfh->hfunc =3D ETH_RSS_HASH_TOP;
> +
> +       if (rxfh->key) {
> +               rxfh->key_size =3D priv->rss_key_size;
> +               memcpy(rxfh->key, rss_config->hash_key, priv->rss_key_siz=
e);
> +       }
> +
> +       if (rxfh->indir) {
> +               rxfh->indir_size =3D priv->rss_lut_size;
> +               memcpy(rxfh->indir, rss_config->hash_lut,
> +                      priv->rss_lut_size * sizeof(*rxfh->indir));
> +       }
> +}
> +
>  static int gve_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_p=
aram *rxfh)
>  {
>         struct gve_priv *priv =3D netdev_priv(netdev);
> @@ -862,18 +880,46 @@ static int gve_get_rxfh(struct net_device *netdev, =
struct ethtool_rxfh_param *rx
>         if (!priv->rss_key_size || !priv->rss_lut_size)
>                 return -EOPNOTSUPP;
>
> +       if (priv->cache_rss_config) {
> +               gve_get_rss_config_cache(priv, rxfh);
> +               return 0;
> +       }
> +
>         return gve_adminq_query_rss_config(priv, rxfh);
>  }
>
> +static void gve_set_rss_config_cache(struct gve_priv *priv,
> +                                    struct ethtool_rxfh_param *rxfh)
> +{
> +       struct gve_rss_config *rss_config =3D &priv->rss_config;
> +
> +       if (rxfh->key)
> +               memcpy(rss_config->hash_key, rxfh->key, priv->rss_key_siz=
e);
> +
> +       if (rxfh->indir)
> +               memcpy(rss_config->hash_lut, rxfh->indir,
> +                      priv->rss_lut_size * sizeof(*rxfh->indir));
> +}
> +
>  static int gve_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_p=
aram *rxfh,
>                         struct netlink_ext_ack *extack)
>  {
>         struct gve_priv *priv =3D netdev_priv(netdev);
> +       int err;
>
>         if (!priv->rss_key_size || !priv->rss_lut_size)
>                 return -EOPNOTSUPP;
>
> -       return gve_adminq_configure_rss(priv, rxfh);
> +       err =3D gve_adminq_configure_rss(priv, rxfh);
> +       if (err) {
> +               NL_SET_ERR_MSG_MOD(extack, "Fail to configure RSS config\=
n");
> +               return err;
> +       }
> +
> +       if (priv->cache_rss_config)
> +               gve_set_rss_config_cache(priv, rxfh);
> +
> +       return 0;
>  }
>
>  const struct ethtool_ops gve_ethtool_ops =3D {
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 533e659b15b3..d726a4d39b45 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -184,6 +184,49 @@ static void gve_free_flow_rule_caches(struct gve_pri=
v *priv)
>         flow_rules_cache->rules_cache =3D NULL;
>  }
>
> +static int gve_alloc_rss_config_cache(struct gve_priv *priv)
> +{
> +       struct gve_rss_config *rss_config =3D &priv->rss_config;
> +       int err =3D 0;
> +
> +       if (!priv->cache_rss_config)
> +               return 0;
> +
> +       rss_config->hash_key =3D kcalloc(priv->rss_key_size,
> +                                      sizeof(rss_config->hash_key[0]),
> +                                      GFP_KERNEL);
> +       if (!rss_config->hash_key) {
> +               dev_err(&priv->pdev->dev, "Cannot alloc rss key cache\n")=
;
There is no need of dev_err message in memory allocation failure path.
> +               return -ENOMEM;
> +       }
> +
> +       rss_config->hash_lut =3D kcalloc(priv->rss_lut_size,
> +                                      sizeof(rss_config->hash_lut[0]),
> +                                      GFP_KERNEL);
> +       if (!rss_config->hash_lut) {
> +               dev_err(&priv->pdev->dev, "Cannot alloc rss lut cache\n")=
;
> +               err =3D -ENOMEM;
> +               goto free_rss_key_cache;
> +       }
> +
> +       return 0;
> +
> +free_rss_key_cache:
> +       kfree(rss_config->hash_key);
> +       rss_config->hash_key =3D NULL;
> +       return err;
Maybe you can return -ENOMEM here and hence avoid the need of the
local variable err.
> +}
> +
> +static void gve_free_rss_config_cache(struct gve_priv *priv)
> +{
> +       struct gve_rss_config *rss_config =3D &priv->rss_config;
> +
> +       kfree(rss_config->hash_key);
> +       kfree(rss_config->hash_lut);
> +
> +       memset(rss_config, 0, sizeof(*rss_config));
> +}
> +
>  static int gve_alloc_counter_array(struct gve_priv *priv)
>  {
>         priv->counter_array =3D
> @@ -575,9 +618,12 @@ static int gve_setup_device_resources(struct gve_pri=
v *priv)
>         err =3D gve_alloc_flow_rule_caches(priv);
>         if (err)
>                 return err;
> -       err =3D gve_alloc_counter_array(priv);
> +       err =3D gve_alloc_rss_config_cache(priv);
>         if (err)
>                 goto abort_with_flow_rule_caches;
> +       err =3D gve_alloc_counter_array(priv);
> +       if (err)
> +               goto abort_with_rss_config_cache;
>         err =3D gve_alloc_notify_blocks(priv);
>         if (err)
>                 goto abort_with_counter;
> @@ -611,6 +657,12 @@ static int gve_setup_device_resources(struct gve_pri=
v *priv)
>                 }
>         }
>
> +       err =3D gve_init_rss_config(priv, priv->rx_cfg.num_queues);
> +       if (err) {
> +               dev_err(&priv->pdev->dev, "Failed to init RSS config");
> +               goto abort_with_ptype_lut;
> +       }
> +
>         err =3D gve_adminq_report_stats(priv, priv->stats_report_len,
>                                       priv->stats_report_bus,
>                                       GVE_STATS_REPORT_TIMER_PERIOD);
> @@ -629,6 +681,8 @@ static int gve_setup_device_resources(struct gve_priv=
 *priv)
>         gve_free_notify_blocks(priv);
>  abort_with_counter:
>         gve_free_counter_array(priv);
> +abort_with_rss_config_cache:
> +       gve_free_rss_config_cache(priv);
>  abort_with_flow_rule_caches:
>         gve_free_flow_rule_caches(priv);
>
> @@ -669,6 +723,7 @@ static void gve_teardown_device_resources(struct gve_=
priv *priv)
>         priv->ptype_lut_dqo =3D NULL;
>
>         gve_free_flow_rule_caches(priv);
> +       gve_free_rss_config_cache(priv);
>         gve_free_counter_array(priv);
>         gve_free_notify_blocks(priv);
>         gve_free_stats_report(priv);
> @@ -1390,6 +1445,12 @@ static int gve_queues_start(struct gve_priv *priv,
>         if (err)
>                 goto stop_and_free_rings;
>
> +       if (rx_alloc_cfg->reset_rss) {
> +               err =3D gve_init_rss_config(priv, priv->rx_cfg.num_queues=
);
> +               if (err)
> +                       goto reset;
> +       }
> +
>         err =3D gve_register_qpls(priv);
>         if (err)
>                 goto reset;
> @@ -1786,6 +1847,26 @@ static int gve_xdp(struct net_device *dev, struct =
netdev_bpf *xdp)
>         }
>  }
>
> +int gve_init_rss_config(struct gve_priv *priv, u16 num_queues)
> +{
> +       struct gve_rss_config *rss_config =3D &priv->rss_config;
> +       struct ethtool_rxfh_param rxfh;
> +       u16 i;
> +
> +       if (!priv->cache_rss_config)
> +               return 0;
> +
> +       for (i =3D 0; i < priv->rss_lut_size; i++)
> +               rss_config->hash_lut[i] =3D
> +                       ethtool_rxfh_indir_default(i, num_queues);
> +
> +       netdev_rss_key_fill(rss_config->hash_key, priv->rss_key_size);
> +
> +       rxfh.hfunc =3D ETH_RSS_HASH_TOP;
> +
> +       return gve_adminq_configure_rss(priv, &rxfh);
> +}
> +
>  int gve_flow_rules_reset(struct gve_priv *priv)
>  {
>         if (!priv->max_flow_rules)
> @@ -1834,7 +1915,8 @@ int gve_adjust_config(struct gve_priv *priv,
>
>  int gve_adjust_queues(struct gve_priv *priv,
>                       struct gve_queue_config new_rx_config,
> -                     struct gve_queue_config new_tx_config)
> +                     struct gve_queue_config new_tx_config,
> +                     bool reset_rss)
>  {
>         struct gve_tx_alloc_rings_cfg tx_alloc_cfg =3D {0};
>         struct gve_rx_alloc_rings_cfg rx_alloc_cfg =3D {0};
> @@ -1847,6 +1929,7 @@ int gve_adjust_queues(struct gve_priv *priv,
>         tx_alloc_cfg.qcfg =3D &new_tx_config;
>         rx_alloc_cfg.qcfg_tx =3D &new_tx_config;
>         rx_alloc_cfg.qcfg =3D &new_rx_config;
> +       rx_alloc_cfg.reset_rss =3D reset_rss;
>         tx_alloc_cfg.num_rings =3D new_tx_config.num_queues;
>
>         /* Add dedicated XDP TX queues if enabled. */
> @@ -1858,6 +1941,11 @@ int gve_adjust_queues(struct gve_priv *priv,
>                 return err;
>         }
>         /* Set the config for the next up. */
> +       if (reset_rss) {
> +               err =3D gve_init_rss_config(priv, new_rx_config.num_queue=
s);
> +               if (err)
> +                       return err;
> +       }
>         priv->tx_cfg =3D new_tx_config;
>         priv->rx_cfg =3D new_rx_config;
>
> --
> 2.48.1.362.g079036d154-goog
>
>


--=20
Regards,
Kalesh AP

--0000000000003cf567062d67f35d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIOJEfanFNQMcqPuc87G2fT+guDXBVdoOQxI5UrOYbDaaMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIwNTE2NTIyNlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAKF89LmQZM
YdfCLTEGK5zc788gCmZsayyneyqTv4Ytehb1zJ8wmfjK8Z0fL6vXBFjJRJNnVO2d/h29osuauWkO
1zJ7UTAXAcgUqXMyGN4oj4F7qMItImc/cW8zOf3Pyi8fSjVWfdzGleTT8tBXz9LJgwOVHhSYMG+u
V5Ojq20veui/0f8rbg4cUHQTr08AAJPN+qDQj46ZgTz6Ud9YCST8X5/3qw6uG5bIxIWKEGYPFDZp
k+KtyAV8iWxKOfyvMYE/X/itb360UE8c75NU1zegc8+++i0Hv5fEcokbaJVS59kZ8hRMSIIqEusg
c5fSS0TteFEsZiOMWiZ97QfzBcaF
--0000000000003cf567062d67f35d--

