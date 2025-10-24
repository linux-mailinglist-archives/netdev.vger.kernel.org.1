Return-Path: <netdev+bounces-232358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D85C048D6
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 08:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2103C3B7BAF
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 06:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7388236453;
	Fri, 24 Oct 2025 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eh6tsion"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185992AEF5
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 06:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761288535; cv=none; b=mr/a2Fa3JawmDAMz2BdCRKz7iaFl87gyMCCTnJI0jZe8BjHgcfqfLzvcBLz7oUk/qeBhWi3uJ0nKKE4Swjbi62Ra6Y9Xr/SXgsHw7tobQwaL8O1PXABgX9FY6lON2A6cR/gnjjeZQOaEZjdwtE7ArKHrdmM8ajqDvctI7vPVA/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761288535; c=relaxed/simple;
	bh=HI9l/2GIrQPo+OXf5z20Y7MBqsrplan07TM4+RZsXTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCpZsC5oA1AB87O4ZnGSIdXHgET+SIcTWjIVFFLHCQNciG6NSaMKdca6woM+aWpA6oZW9jqjqS25Imlv/X5834Q/0aurmCMTBLFmk0MVywf5/HEUGK3b/uPPnYjoeJ9ZVQxYnLnd5csqK8AWTDqdFdfXfWI+H2jSAdcJL1tiTHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eh6tsion; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4e883b79269so22726511cf.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 23:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761288533; x=1761893333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/38FhIYGOVCZ7MM1NZOLC3UOgmd5FAvjDkVzze7LWGc=;
        b=Eh6tsiong86Pm3n+EucuBXRRd7JXX6lUAjTRLoHn8tr2CdmBvM89uoliUIx/45MizU
         pBSGEyrd+pjZ1rG/Jdufp6iCiXM8+ZG6t0oIGKVbkdFBYLOlp1yjqlNVsfTeaKt9LyPj
         UB9WXtEYdNlomk5mhaC3iFL+DcZTf3FUbikO1J+wXVBEu+JKIAAzAxukhnRzG7W2g4fR
         j7hKvA869SbvcoDsAjc1bdH4QCepcJw8K21a8Try+z+BDlqvVvIpXCXR7nc+KdfOAeKJ
         5B8D/TovOa+2GNwuEpJJtjRT2i5+C6ACGAl6KXTJjciyVKCaIzhtdzqR/72kwOT/2n5+
         +sXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761288533; x=1761893333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/38FhIYGOVCZ7MM1NZOLC3UOgmd5FAvjDkVzze7LWGc=;
        b=Oz4rtcCb3va6OiT/qRWwuY3ezaPxqAfdJlJ7yjPGTuhbEL79lCGFsZvguoOq4+DB3E
         JX1SglAbrCirygRTntoHkUMEaArduArzQhVj5UpjGeXC0kx29AZ7MUg2p7axQbphJG1K
         PWBqlPis6/hNm5CjfyMBTfwOrYw6lWdH7sMeuYlMLwwKc7zunUVk8Lb1R4vXUvpt4F9o
         7N8KgNX6MlMhRuanPBgVhKbpgt4twwcW9PToYI+1nNmGTHhmVgYewtqUw2SA96u8WE1e
         IsPS/iZBKtFE/DkTVXHBEnmZkPhb1G8kYfsw3wW4J3VtCnHBk3ofS0a/3Zw9uCX7yg2i
         vDpg==
X-Gm-Message-State: AOJu0YwbxKFwUqACmrG61Ee2qES2NiwZU8YgXL7UYsftoG4uJAOGfQRF
	v8VP6Ab7FmkWQb2P+2VhV15wDhzbV/hxSfeO0KRqA2oq+Hs88IYnyjTNT9GtE2hD5Ftltqra3dO
	En9uy7xW3gufLxHfnFeiYweKkC4GFDRPd3cyU5pt0
X-Gm-Gg: ASbGncscrzW8FwtywKcIm1rMMa8p3hzlQ5ncbG4Y6BS/zYbS3TmSxlqrztjSodczkJz
	Unr0XcDevz8HMlAVXRfihf7R0EurKoNakeJ3l/IrGb/xaHwgzwxkQ8fYKF04Fwc7lpmvhgy0QMn
	J7XGLqSTj/AfHd3zn1MXKc/oBIh1dwTzQgf1D7I8BInZrawi5BCL29p8v9xMHwksJ0oWWER0Eqi
	4o7Mqtj09WMBXwEOb1wqFweZtfFkU3fUuEO1D4TxzpOce8ZqtADPGHNirKIIvAfjX/18bM=
X-Google-Smtp-Source: AGHT+IHz9+Kk5P5ITHsdBuOTCRFJzAnsm7mtNFupn2U2Xh9LEoGYGLXVzAAhuxrjf4nzlJMYd+ek8HpIpfphSsXi2zc=
X-Received: by 2002:a05:622a:1812:b0:4e8:9402:a809 with SMTP id
 d75a77b69052e-4e89d263d69mr327730481cf.31.1761288532540; Thu, 23 Oct 2025
 23:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024044849.1098222-1-hkelam@marvell.com>
In-Reply-To: <20251024044849.1098222-1-hkelam@marvell.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Oct 2025 23:48:41 -0700
X-Gm-Features: AS18NWCsCWO67Hn4gcPy4NieUathy_Bq1iDFs0NmxaeR0ICyoCyRSU7NsuJa4Yg
Message-ID: <CANn89iKVpihmWn8u3AT-zEX0aDU6tD+c9KhjNriTRNxTcofuzg@mail.gmail.com>
Subject: Re: [RFC net-next] net: loopback: Extend netdev features with new
 loopback modes
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Kory Maincent <kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>, 
	Jianbo Liu <jianbol@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 9:49=E2=80=AFPM Hariprasad Kelam <hkelam@marvell.co=
m> wrote:
>
> This patch enhances loopback support by exposing new loopback modes
> (e.g., MAC, SERDES) to userspace. These new modes are added extension
> to the existing netdev features.
>
> This allows users to select the loopback at specific layer.
>
> Below are new modes added:
>
> MAC near end loopback
>
> MAC far end loopback
>
> SERDES loopback
>
> Depending on the feedback will submit ethtool changes.
>
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
>  Documentation/networking/netdev-features.rst  | 15 +++
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 93 ++++++++++++++++++-
>  include/linux/netdev_features.h               |  9 +-
>  net/ethtool/common.c                          |  3 +
>  4 files changed, 116 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/networking/netdev-features.rst b/Documentation=
/networking/netdev-features.rst
> index 02bd7536fc0c..dcad5e875f32 100644
> --- a/Documentation/networking/netdev-features.rst
> +++ b/Documentation/networking/netdev-features.rst
> @@ -193,3 +193,18 @@ frames in hardware.
>
>  This should be set for devices which support netmem TX. See
>  Documentation/networking/netmem.rst
> +
> +* mac-nearend-loopback
> +
> +This requests that the NIC enables MAC nearend loopback i.e egress traff=
ic is
> +routed back to ingress traffic.
> +
> +* mac-farend-loopback
> +
> +This requests that the NIC enables MAC farend loopback i.e ingress traff=
ic is
> +routed back to egress traffic.
> +
> +
> +* serdes-loopback
> +
> +This request that the NIC enables SERDES near end digital loopback.
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index e808995703cf..14be6a9206c8 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -1316,6 +1316,84 @@ static int otx2_cgx_config_loopback(struct otx2_ni=
c *pf, bool enable)
>         return err;
>  }
>
> +static int otx2_cgx_mac_nearend_loopback(struct otx2_nic *pf, bool enabl=
e)
> +{
> +       struct msg_req *msg;
> +       int err;
> +
> +       if (enable && !bitmap_empty(pf->flow_cfg->dmacflt_bmap,
> +                                   pf->flow_cfg->dmacflt_max_flows))
> +               netdev_warn(pf->netdev,
> +                           "CGX/RPM nearend loopback might not work as D=
MAC filters are active\n");
> +
> +       mutex_lock(&pf->mbox.lock);
> +       if (enable)
> +               msg =3D otx2_mbox_alloc_msg_cgx_intlbk_enable(&pf->mbox);
> +       else
> +               msg =3D otx2_mbox_alloc_msg_cgx_intlbk_disable(&pf->mbox)=
;
> +
> +       if (!msg) {
> +               mutex_unlock(&pf->mbox.lock);
> +               return -ENOMEM;
> +       }
> +
> +       err =3D otx2_sync_mbox_msg(&pf->mbox);
> +       mutex_unlock(&pf->mbox.lock);
> +       return err;
> +}
> +
> +static int otx2_cgx_mac_farend_loopback(struct otx2_nic *pf, bool enable=
)
> +{
> +       struct msg_req *msg;
> +       int err;
> +
> +       if (enable && !bitmap_empty(pf->flow_cfg->dmacflt_bmap,
> +                                   pf->flow_cfg->dmacflt_max_flows))
> +               netdev_warn(pf->netdev,
> +                           "CGX/RPM farend loopback might not work as DM=
AC filters are active\n");
> +
> +       mutex_lock(&pf->mbox.lock);
> +       if (enable)
> +               msg =3D otx2_mbox_alloc_msg_cgx_intlbk_enable(&pf->mbox);
> +       else
> +               msg =3D otx2_mbox_alloc_msg_cgx_intlbk_disable(&pf->mbox)=
;
> +
> +       if (!msg) {
> +               mutex_unlock(&pf->mbox.lock);
> +               return -ENOMEM;
> +       }
> +
> +       err =3D otx2_sync_mbox_msg(&pf->mbox);
> +       mutex_unlock(&pf->mbox.lock);
> +       return err;
> +}
> +
> +static int otx2_cgx_serdes_loopback(struct otx2_nic *pf, bool enable)
> +{
> +       struct msg_req *msg;
> +       int err;
> +
> +       if (enable && !bitmap_empty(pf->flow_cfg->dmacflt_bmap,
> +                                   pf->flow_cfg->dmacflt_max_flows))
> +               netdev_warn(pf->netdev,
> +                           "CGX/RPM serdes loopback might not work as DM=
AC filters are active\n");
> +
> +       mutex_lock(&pf->mbox.lock);
> +       if (enable)
> +               msg =3D otx2_mbox_alloc_msg_cgx_intlbk_enable(&pf->mbox);
> +       else
> +               msg =3D otx2_mbox_alloc_msg_cgx_intlbk_disable(&pf->mbox)=
;
> +
> +       if (!msg) {
> +               mutex_unlock(&pf->mbox.lock);
> +               return -ENOMEM;
> +       }
> +
> +       err =3D otx2_sync_mbox_msg(&pf->mbox);
> +       mutex_unlock(&pf->mbox.lock);
> +       return err;
> +}
> +
>  int otx2_set_real_num_queues(struct net_device *netdev,
>                              int tx_queues, int rx_queues)
>  {
> @@ -2363,6 +2441,18 @@ static int otx2_set_features(struct net_device *ne=
tdev,
>                 return cn10k_ipsec_ethtool_init(netdev,
>                                                 features & NETIF_F_HW_ESP=
);
>
> +       if ((changed & NETIF_F_MAC_LBK_NE) && netif_running(netdev))
> +               return otx2_cgx_mac_nearend_loopback(pf,
> +                                                    features & NETIF_F_M=
AC_LBK_NE);
> +
> +       if ((changed & NETIF_F_MAC_LBK_FE) && netif_running(netdev))
> +               return otx2_cgx_mac_farend_loopback(pf,
> +                                                   features & NETIF_F_MA=
C_LBK_FE);
> +
> +       if ((changed & NETIF_F_SERDES_LBK) && netif_running(netdev))
> +               return otx2_cgx_serdes_loopback(pf,
> +                                               features & NETIF_F_SERDES=
_LBK);
> +
>         return otx2_handle_ntuple_tc_features(netdev, features);
>  }
>
> @@ -3249,7 +3339,8 @@ static int otx2_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
>         if (pf->flags & OTX2_FLAG_TC_FLOWER_SUPPORT)
>                 netdev->hw_features |=3D NETIF_F_HW_TC;
>
> -       netdev->hw_features |=3D NETIF_F_LOOPBACK | NETIF_F_RXALL;
> +       netdev->hw_features |=3D NETIF_F_LOOPBACK | NETIF_F_RXALL |
> +                              NETIF_F_MAC_LBK_NE | NETIF_F_MAC_LBK_FE | =
NETIF_F_SERDES_LBK;
>
>         netif_set_tso_max_segs(netdev, OTX2_MAX_GSO_SEGS);
>         netdev->watchdog_timeo =3D OTX2_TX_TIMEOUT;
> diff --git a/include/linux/netdev_features.h b/include/linux/netdev_featu=
res.h
> index 93e4da7046a1..124f83223361 100644
> --- a/include/linux/netdev_features.h
> +++ b/include/linux/netdev_features.h
> @@ -14,7 +14,7 @@ typedef u64 netdev_features_t;
>  enum {
>         NETIF_F_SG_BIT,                 /* Scatter/gather IO. */
>         NETIF_F_IP_CSUM_BIT,            /* Can checksum TCP/UDP over IPv4=
. */
> -       __UNUSED_NETIF_F_1,
> +       NETIF_F_MAC_LBK_NE_BIT,         /* MAC near end loopback */
>         NETIF_F_HW_CSUM_BIT,            /* Can checksum all the packets. =
*/
>         NETIF_F_IPV6_CSUM_BIT,          /* Can checksum TCP/UDP over IPV6=
 */
>         NETIF_F_HIGHDMA_BIT,            /* Can DMA to high memory. */
> @@ -24,8 +24,8 @@ enum {
>         NETIF_F_HW_VLAN_CTAG_FILTER_BIT,/* Receive filtering on VLAN CTAG=
s */
>         NETIF_F_VLAN_CHALLENGED_BIT,    /* Device cannot handle VLAN pack=
ets */
>         NETIF_F_GSO_BIT,                /* Enable software GSO. */
> -       __UNUSED_NETIF_F_12,
> -       __UNUSED_NETIF_F_13,
> +       NETIF_F_MAC_LBK_FE_BIT,         /* MAC far end loopback */
> +       NETIF_F_SERDES_LBK_BIT,         /* SERDES loopback */
>         NETIF_F_GRO_BIT,                /* Generic receive offload */
>         NETIF_F_LRO_BIT,                /* large receive offload */
>
> @@ -165,6 +165,9 @@ enum {
>  #define NETIF_F_HW_HSR_TAG_RM  __NETIF_F(HW_HSR_TAG_RM)
>  #define NETIF_F_HW_HSR_FWD     __NETIF_F(HW_HSR_FWD)
>  #define NETIF_F_HW_HSR_DUP     __NETIF_F(HW_HSR_DUP)
> +#define NETIF_F_MAC_LBK_NE     __NETIF_F(MAC_LBK_NE)
> +#define NETIF_F_MAC_LBK_FE     __NETIF_F(MAC_LBK_FE)
> +#define NETIF_F_SERDES_LBK     __NETIF_F(SERDES_LBK)
>

I do not think we want to burn three generic bits in netdev_features_t
for something which seems device specific.

You have not shown any change for taking care of these features in net/core=
.

