Return-Path: <netdev+bounces-156311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 177E8A06063
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43831885983
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757E21F9439;
	Wed,  8 Jan 2025 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pr6FzkSu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B840146013
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350754; cv=none; b=f0uePQT8G3rzEJDhejp5NIIS7Q0jtW9D9yC6DcKKLW5XEUgUQwDAf65NTkg7o1Hil+b3DZn5HbvPaJm720yDjM9Do+ePw9Q91ta7gMZr6hvwIQEriGZzZfShd2nW1QgizQymH+9/xM7C04AHcX6VkWLjs/RtB2xv8+T8+kgNF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350754; c=relaxed/simple;
	bh=WJvY0n9CFnVY3sVay89zt1YdQy7+3mdDPiGNU2WsEBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G48MeLlRE0k7nDLv0vVPBC3Ks11grL2zWUGPOXbc6VHQ/KUG2d3rpLUmCK298xfwBMQ6EZMpC06ou4cZwRyLuufKvEBWOTAKUp5D5AAckQuO69PgVmuUdxrKrPxLWYBG4kL1tPxm5qKs4pD2tUGXLyursWyy7HvaXEyJkG74oN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pr6FzkSu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43626213fffso6516355e9.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 07:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736350751; x=1736955551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+aSOvONdFyhmrO+jqrZkww0MpBSXctJ2jpRLXwVS9g=;
        b=Pr6FzkSuBfqcXOxRtd2Mjr/TMgCtj5/XWcz57St3ywQBt4nU8wAh8PG3YVgxGq8Pcx
         xroAqQMwtTMj7yr/vRBYlRvk9UiHJEPleLv4LtlNG3DyWbB521hk7+tvsm+FvaGIlYRb
         LHljk122+9sZma91ROzyDXeewzvU7ykWzicQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736350751; x=1736955551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+aSOvONdFyhmrO+jqrZkww0MpBSXctJ2jpRLXwVS9g=;
        b=D9V6QG0U2dwvZ5ZgNswl6MswfXU/OQpQnfBi0bJdUZuN+n3BHGOXTkGzVBsf8dzIkt
         Vz2lZb9gxkbQWDI9CJRKYyRAZ5mPKgRA0pvMMQ5x1qcpqUYQHKUB0nnvPGbjD8spR/1U
         UlGBvbu2qaf5wFd7+X/h5WniYPsDleBihG/aI91dNwV1xqARyhVezy5RxC6kuXJITtNz
         +OQGXyu1oJ57QxqFZdDOI55vzpInljH44Wb9gLcvPLucDUS9gHLy11ZDartCjo21P4xV
         iePq1pNF/e2iEhV0UvJ2Te2yywYXOcEnws3MidvpfiAHjLp7ng6WnbdaYj3RpG1FHZup
         RRWg==
X-Forwarded-Encrypted: i=1; AJvYcCXngwlQ6HupPIjMZGT11Hg/iA3MBS3A2ovb8sKE5Q4BUdSkEkEHGWeZXAYvq24ClkH518jsnYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm91b7TMbREcW9a+Jck3HhYXqauDpSxfKk2YaEanjGk2dte9Gu
	nPW6crxnpnDbwbdlubJVDVsjg2RsVAh5gAym0s8N9r4cSeIFlCpVsIUXZVakzOBBbsaS1R2Gt2s
	u8QGogtanQZXjXfp2LK7O0mWwp9ws51Ik6OM2
X-Gm-Gg: ASbGnctzUQw+K1yytg5BkOl4HJ09ofuYKblM3Mr7rlJSsKD9ERW3VqHQfCrl1Z+1ln3
	jFtUgtQ8AqQuIxEYLNmTtg2kXIpfOuGzmXeAfzwc=
X-Google-Smtp-Source: AGHT+IGPY74MBGAU0LsBJB2Ailb/DuyikuWPYJrmjBeEKxVGxdA+s2tEotPVAoMYKBbd0o+a5+ANNrvt3EiIBQ1NCc8=
X-Received: by 2002:a05:600c:1c28:b0:434:ff08:202e with SMTP id
 5b1f17b1804b1-436e1de8c6bmr29785035e9.8.1736350750876; Wed, 08 Jan 2025
 07:39:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103150325.926031-1-ap420073@gmail.com> <20250103150325.926031-9-ap420073@gmail.com>
In-Reply-To: <20250103150325.926031-9-ap420073@gmail.com>
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Date: Wed, 8 Jan 2025 10:38:55 -0500
X-Gm-Features: AbW1kvYRuMRM3tO28uD7z3f4jq_ntBkJM8i3JilGlL-55DOPPPx-Zq_b9nFrFvw
Message-ID: <CACDg6nUcoaumrk-9gm2gp6PnsUCLy0K0HAs5ka9u1F4vH+Rz=Q@mail.gmail.com>
Subject: Re: [PATCH net-next v7 08/10] bnxt_en: add support for hds-thresh
 ethtool command
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, almasrymina@google.com, donald.hunter@gmail.com, 
	corbet@lwn.net, michael.chan@broadcom.com, andrew+netdev@lunn.ch, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, dw@davidwei.uk, 
	sdf@fomichev.me, asml.silence@gmail.com, brett.creeley@amd.com, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com, 
	Andy Gospodarek <gospo@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 10:04=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wro=
te:
>
> The bnxt_en driver has configured the hds_threshold value automatically
> when TPA is enabled based on the rx-copybreak default value.
> Now the hds-thresh ethtool command is added, so it adds an
> implementation of hds-thresh option.
>
> Configuration of the hds-thresh is applied only when
> the tcp-data-split is enabled. The default value of
> hds-thresh is 256, which is the default value of
> rx-copybreak, which used to be the hds_thresh value.
>
> The maximum hds-thresh is 1023.
>
>    # Example:
>    # ethtool -G enp14s0f0np0 tcp-data-split on hds-thresh 256
>    # ethtool -g enp14s0f0np0
>    Ring parameters for enp14s0f0np0:
>    Pre-set maximums:
>    ...
>    HDS thresh:  1023
>    Current hardware settings:
>    ...
>    TCP data split:         on
>    HDS thresh:  256
>
> Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> Tested-by: Andy Gospodarek <gospo@broadcom.com>

I'll give this set one more run today.

> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>
> v7:
>  - Use dev->ethtool->hds_thresh instead of bp->hds_thresh
>
> v6:
>  - HDS_MAX is changed to 1023.
>  - Add Test tag from Andy.
>
> v5:
>  - No changes.
>
> v4:
>  - Reduce hole in struct bnxt.
>  - Add ETHTOOL_RING_USE_HDS_THRS to indicate bnxt_en driver support
>    header-data-split-thresh option.
>  - Add Test tag from Stanislav.
>
> v3:
>  - Drop validation logic tcp-data-split and tcp-data-split-thresh.
>
> v2:
>  - Patch added.
>
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 4 +++-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 2 ++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 7 ++++++-
>  3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 7198d05cd27b..df03f218a570 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -4603,6 +4603,7 @@ void bnxt_set_tpa_flags(struct bnxt *bp)
>  static void bnxt_init_ring_params(struct bnxt *bp)
>  {
>         bp->rx_copybreak =3D BNXT_DEFAULT_RX_COPYBREAK;
> +       bp->dev->ethtool->hds_thresh =3D BNXT_DEFAULT_RX_COPYBREAK;
>  }
>
>  /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flags=
 must
> @@ -6562,6 +6563,7 @@ static void bnxt_hwrm_update_rss_hash_cfg(struct bn=
xt *bp)
>
>  static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info=
 *vnic)
>  {
> +       u16 hds_thresh =3D (u16)bp->dev->ethtool->hds_thresh;
>         struct hwrm_vnic_plcmodes_cfg_input *req;
>         int rc;
>
> @@ -6578,7 +6580,7 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, =
struct bnxt_vnic_info *vnic)
>                                           VNIC_PLCMODES_CFG_REQ_FLAGS_HDS=
_IPV6);
>                 req->enables |=3D
>                         cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THR=
ESHOLD_VALID);
> -               req->hds_threshold =3D cpu_to_le16(bp->rx_copybreak);
> +               req->hds_threshold =3D cpu_to_le16(hds_thresh);
>         }
>         req->vnic_id =3D cpu_to_le32(vnic->fw_vnic_id);
>         return hwrm_req_send(bp, req);
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.h
> index 7dc06e07bae2..8f481dd9c224 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2779,6 +2779,8 @@ struct bnxt {
>  #define SFF_MODULE_ID_QSFP28                   0x11
>  #define BNXT_MAX_PHY_I2C_RESP_SIZE             64
>
> +#define BNXT_HDS_THRESHOLD_MAX                 1023
> +
>  static inline u32 bnxt_tx_avail(struct bnxt *bp,
>                                 const struct bnxt_tx_ring_info *txr)
>  {
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/=
net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 413007190f50..829697bfdab3 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -833,6 +833,9 @@ static void bnxt_get_ringparam(struct net_device *dev=
,
>         ering->rx_pending =3D bp->rx_ring_size;
>         ering->rx_jumbo_pending =3D bp->rx_agg_ring_size;
>         ering->tx_pending =3D bp->tx_ring_size;
> +
> +       kernel_ering->hds_thresh =3D dev->ethtool->hds_thresh;
> +       kernel_ering->hds_thresh_max =3D BNXT_HDS_THRESHOLD_MAX;
>  }
>
>  static int bnxt_set_ringparam(struct net_device *dev,
> @@ -869,6 +872,7 @@ static int bnxt_set_ringparam(struct net_device *dev,
>                         bp->flags &=3D ~BNXT_FLAG_HDS;
>         }
>
> +       dev->ethtool->hds_thresh =3D kernel_ering->hds_thresh;
>         bp->rx_ring_size =3D ering->rx_pending;
>         bp->tx_ring_size =3D ering->tx_pending;
>         bnxt_set_ring_params(bp);
> @@ -5390,7 +5394,8 @@ const struct ethtool_ops bnxt_ethtool_ops =3D {
>                                      ETHTOOL_COALESCE_STATS_BLOCK_USECS |
>                                      ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
>                                      ETHTOOL_COALESCE_USE_CQE,
> -       .supported_ring_params  =3D ETHTOOL_RING_USE_TCP_DATA_SPLIT,
> +       .supported_ring_params  =3D ETHTOOL_RING_USE_TCP_DATA_SPLIT |
> +                                 ETHTOOL_RING_USE_HDS_THRS,
>         .get_link_ksettings     =3D bnxt_get_link_ksettings,
>         .set_link_ksettings     =3D bnxt_set_link_ksettings,
>         .get_fec_stats          =3D bnxt_get_fec_stats,
> --
> 2.34.1
>

