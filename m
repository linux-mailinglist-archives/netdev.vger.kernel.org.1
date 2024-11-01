Return-Path: <netdev+bounces-140897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 488AE9B8906
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 03:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030EE282DC2
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7DF126C0D;
	Fri,  1 Nov 2024 02:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fP7HKYdq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF3617C91;
	Fri,  1 Nov 2024 02:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730426728; cv=none; b=kenhR/rsDGw//g1GRNFAGw2A3jyeQg8zZ2kcS413qEG9WW2kd80iKqrz4VkoH5+dD1ogrRD+27XeyUPLsLtD0GDM+QRD793NpCG+KSALgGHxVb7uDP0YbMG4XD/2HbU3vS0hIzTNq5mKmSF4U0MxQuJ1WarhXaLC4Dtzj4yccUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730426728; c=relaxed/simple;
	bh=ueU1PNLGGKx0bme6zMvuP5czCJdWPzAE5oLKIyX/qdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/cpwLT7CxV1atATUSYsYkKrDczYT/sTkoubZ6LGkNyjsOKrq/d3sBLE29/ogDt0MBJJOMmWRA8PiFJohi8m0h/s3cqht/5bAxjlP02YhrpGvh9R7+OzfTAipp+6fHG88eK9O9HneEeTOL0DbRzzFDRtC643CkQtQvPWFj4A9vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fP7HKYdq; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e2e3e4f65dso15566627b3.3;
        Thu, 31 Oct 2024 19:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730426718; x=1731031518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLzn1MMBIPEo6fbVBUjn/OfItkMN4yfiigk4UHNvxN4=;
        b=fP7HKYdqPDj1i5m613cBEUQjzjGO7qXfik+/vZgw6vsRJI6SNLh91dg6vSenx/1zk6
         8J5+ovCWCGAoj6SwjGbI8q110mi/BSI8/TXCacxluXR48T+eSq0TRPQgmGTP4YRRnTf7
         VFQnokClyFKiFFHvjAvEhL1UOkIXJA1ShdVPuY9oFCa+/2TfOoP2boZhtnKkKyGlte+1
         fCMpI54mzafKivBWYV1EOVnBqfaj8SX/WwS78YPeu1EbDPQ1fS37+MyoOed4qjUg+2wP
         0ELpiv69d24sITH1nqRChzcQK1xhOQjHbUxPRhiiDhuzHEvy+V0dae9lXAdnDVG/uRso
         dBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730426718; x=1731031518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLzn1MMBIPEo6fbVBUjn/OfItkMN4yfiigk4UHNvxN4=;
        b=Q0EYCS0gA4RiYvrrH+CpxbIK7mJPl+oqAuyaNOWHRbZ4AYCf0Ti75qgO6V/2VgOet3
         URYQa6VoIaeFRMwtKvdu3bJasiOw+0cvm+ZrmRXx04NoJs3ZMf1hqfEqS+xMg/6B0m7L
         FZUKBc1ThQeeaHfSYXJhzBuJYs8Q8MZbC96HxJ1vlPaFhdUkoDSLWGA6FVW9poYVOFFc
         bG17utZA8QA8NaLJrQcEU9Cxp5C0n1SJd6bj/TzJ63xmFr5SoUFOt5Uqi0VMGWidVKTw
         g9Vlm/LGgE+wBT2aud6lDvTYYC3dm7ZW0jlu30z1ULiJFBwQwK2KqR05lXFBt5HL26Cg
         ZIng==
X-Forwarded-Encrypted: i=1; AJvYcCUHZ/hHKuPRnWGGFEFQaoPmubVGg3UW9t73Ld7NqrEk7B9KBU4jzYxKc3H4DbgDus/m3dNBikMW/yrfV8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv9QKn1wtNW3NNyOb7niYwu5DON9mQyBt4gItb9Z18ox9wSIEP
	2H4GyGjoRAxn9uO2LhfPuaBQDSp1x7dU/82Egi8f42TmknASZDPvT1CaXWaOTiCwugguRLexUmv
	XBIit8ppschmrL19X3C8Qq5hrIhE=
X-Google-Smtp-Source: AGHT+IEjC2dAuc8GJYSA3/m9xd8KPfJjdjjI31Ym5jtv/S7wVS6U/Xx6XizrnDrMwY1qh04304Yzbc/yhbBUs105WxU=
X-Received: by 2002:a05:690c:60c7:b0:6e2:1570:2d3d with SMTP id
 00721157ae682-6e9d8779f7cmr244682167b3.0.1730426718348; Thu, 31 Oct 2024
 19:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030220746.305924-1-rosenp@gmail.com> <4338ea28-9f24-48c6-9bca-0b2d0effd3a7@huawei.com>
 <885d3701-f057-4b02-a26b-7eab6ab47cfd@huawei.com>
In-Reply-To: <885d3701-f057-4b02-a26b-7eab6ab47cfd@huawei.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 31 Oct 2024 19:04:08 -0700
Message-ID: <CAKxU2N_8LFCUDqJyofv6XFzPpfCiUG76ufiNb9=nSm=boGJUMw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: hisilicon: use ethtool string helpers
To: Jijie Shao <shaojijie@huawei.com>
Cc: netdev@vger.kernel.org, Jian Shen <shenjian15@huawei.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Wei Fang <wei.fang@nxp.com>, 
	Louis Peens <louis.peens@corigine.com>, 
	"justinstitt@google.com" <justinstitt@google.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Wojciech Drewek <wojciech.drewek@intel.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Hongbo Li <lihongbo22@huawei.com>, 
	Yonglong Liu <liuyonglong@huawei.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Ahmed Zaki <ahmed.zaki@intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Simon Horman <horms@kernel.org>, 
	Jie Wang <wangjie125@huawei.com>, Peiyang Wang <wangpeiyang1@huawei.com>, 
	Hao Lan <lanhao@huawei.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 6:36=E2=80=AFPM Jijie Shao <shaojijie@huawei.com> w=
rote:
>
>
> on 2024/10/31 11:21, Jijie Shao wrote:
> >
> > on 2024/10/31 6:07, Rosen Penev wrote:
> >> The latter is the preferred way to copy ethtool strings.
> >>
> >> Avoids manually incrementing the pointer. Cleans up the code quite wel=
l.
> >>
> >> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >
> > Reviewed-by: Jijie Shao <shaojijie@huawei.com>
> >
> > Tested-by: Jijie Shao <shaojijie@huawei.com>
> >
> >
> > Thank you for your work.
> >
> >> ---
> >>   drivers/net/ethernet/hisilicon/hns/hnae.h     |  2 +-
> >>   .../net/ethernet/hisilicon/hns/hns_ae_adapt.c | 20 ++----
> >>   .../ethernet/hisilicon/hns/hns_dsaf_gmac.c    |  5 +-
> >>   .../net/ethernet/hisilicon/hns/hns_dsaf_mac.c |  3 +-
> >>   .../net/ethernet/hisilicon/hns/hns_dsaf_mac.h |  4 +-
> >>   .../ethernet/hisilicon/hns/hns_dsaf_main.c    | 70 +++++++----------=
--
> >>   .../ethernet/hisilicon/hns/hns_dsaf_main.h    |  2 +-
> >>   .../net/ethernet/hisilicon/hns/hns_dsaf_ppe.c | 31 ++++----
> >>   .../net/ethernet/hisilicon/hns/hns_dsaf_ppe.h |  2 +-
> >>   .../net/ethernet/hisilicon/hns/hns_dsaf_rcb.c | 66 +++++++++--------
> >>   .../net/ethernet/hisilicon/hns/hns_dsaf_rcb.h |  2 +-
> >>   .../ethernet/hisilicon/hns/hns_dsaf_xgmac.c   |  5 +-
> >>   .../net/ethernet/hisilicon/hns/hns_ethtool.c  | 67 +++++++++--------=
-
> >>   drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  2 +-
> >>   .../hns3/hns3_common/hclge_comm_tqp_stats.c   | 11 +--
> >>   .../hns3/hns3_common/hclge_comm_tqp_stats.h   |  2 +-
> >>   .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 53 +++++---------
> >>   .../hisilicon/hns3/hns3pf/hclge_main.c        | 50 ++++++-------
> >>   .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  6 +-
> >>   19 files changed, 166 insertions(+), 237 deletions(-)
>
> Thank you for your work.
>
> It is more reasonable to split the modification of hns3 and hns into two =
patches.
> hns3 and hns are two different drivers.
>
> Each patch can add my Reviewed-by.
Which was tested?
>
> Thanks,
> Jijie Shao
>
> >>
> >> diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.h
> >> b/drivers/net/ethernet/hisilicon/hns/hnae.h
> >> index d72657444ef3..2ae34d01fd36 100644
> >> --- a/drivers/net/ethernet/hisilicon/hns/hnae.h
> >> +++ b/drivers/net/ethernet/hisilicon/hns/hnae.h
> >> @@ -512,7 +512,7 @@ struct hnae_ae_ops {
> >>                    struct net_device_stats *net_stats);
> >>       void (*get_stats)(struct hnae_handle *handle, u64 *data);
> >>       void (*get_strings)(struct hnae_handle *handle,
> >> -                u32 stringset, u8 *data);
> >> +                u32 stringset, u8 **data);
> >>       int (*get_sset_count)(struct hnae_handle *handle, int stringset)=
;
> >>       void (*update_led_status)(struct hnae_handle *handle);
> >>       int (*set_led_id)(struct hnae_handle *handle,
> >> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
> >> b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
> >> index bc3e406f0139..8ce910f8d0cc 100644
> >> --- a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
> >> +++ b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
> >> @@ -730,15 +730,14 @@ static void hns_ae_get_stats(struct hnae_handle
> >> *handle, u64 *data)
> >>           hns_dsaf_get_stats(vf_cb->dsaf_dev, p, vf_cb->port_index);
> >>   }
> >>   -static void hns_ae_get_strings(struct hnae_handle *handle,
> >> -                   u32 stringset, u8 *data)
> >> +static void hns_ae_get_strings(struct hnae_handle *handle, u32
> >> stringset,
> >> +                   u8 **data)
> >>   {
> >>       int port;
> >>       int idx;
> >>       struct hns_mac_cb *mac_cb;
> >>       struct hns_ppe_cb *ppe_cb;
> >>       struct dsaf_device *dsaf_dev =3D hns_ae_get_dsaf_dev(handle->dev=
);
> >> -    u8 *p =3D data;
> >>       struct    hnae_vf_cb *vf_cb;
> >>         assert(handle);
> >> @@ -748,19 +747,14 @@ static void hns_ae_get_strings(struct
> >> hnae_handle *handle,
> >>       mac_cb =3D hns_get_mac_cb(handle);
> >>       ppe_cb =3D hns_get_ppe_cb(handle);
> >>   -    for (idx =3D 0; idx < handle->q_num; idx++) {
> >> -        hns_rcb_get_strings(stringset, p, idx);
> >> -        p +=3D ETH_GSTRING_LEN * hns_rcb_get_ring_sset_count(stringse=
t);
> >> -    }
> >> -
> >> -    hns_ppe_get_strings(ppe_cb, stringset, p);
> >> -    p +=3D ETH_GSTRING_LEN * hns_ppe_get_sset_count(stringset);
> >> +    for (idx =3D 0; idx < handle->q_num; idx++)
> >> +        hns_rcb_get_strings(stringset, data, idx);
> >>   -    hns_mac_get_strings(mac_cb, stringset, p);
> >> -    p +=3D ETH_GSTRING_LEN * hns_mac_get_sset_count(mac_cb, stringset=
);
> >> +    hns_ppe_get_strings(ppe_cb, stringset, data);
> >> +    hns_mac_get_strings(mac_cb, stringset, data);
> >>         if (mac_cb->mac_type =3D=3D HNAE_PORT_SERVICE)
> >> -        hns_dsaf_get_strings(stringset, p, port, dsaf_dev);
> >> +        hns_dsaf_get_strings(stringset, data, port, dsaf_dev);
> >>   }
> >>     static int hns_ae_get_sset_count(struct hnae_handle *handle, int
> >> stringset)
> >> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
> >> b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
> >> index bdb7afaabdd0..400933ca1a29 100644
> >> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
> >> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
> >> @@ -669,16 +669,15 @@ static void hns_gmac_get_stats(void *mac_drv,
> >> u64 *data)
> >>       }
> >>   }
> >>   -static void hns_gmac_get_strings(u32 stringset, u8 *data)
> >> +static void hns_gmac_get_strings(u32 stringset, u8 **data)
> >>   {
> >> -    u8 *buff =3D data;
> >>       u32 i;
> >>         if (stringset !=3D ETH_SS_STATS)
> >>           return;
> >>         for (i =3D 0; i < ARRAY_SIZE(g_gmac_stats_string); i++)
> >> -        ethtool_puts(&buff, g_gmac_stats_string[i].desc);
> >> +        ethtool_puts(data, g_gmac_stats_string[i].desc);
> >>   }
> >>     static int hns_gmac_get_sset_count(int stringset)
> >> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
> >> b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
> >> index 5fa9b2eeb929..bc6b269be299 100644
> >> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
> >> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
> >> @@ -1190,8 +1190,7 @@ void hns_mac_get_stats(struct hns_mac_cb
> >> *mac_cb, u64 *data)
> >>       mac_ctrl_drv->get_ethtool_stats(mac_ctrl_drv, data);
> >>   }
> >>   -void hns_mac_get_strings(struct hns_mac_cb *mac_cb,
> >> -             int stringset, u8 *data)
> >> +void hns_mac_get_strings(struct hns_mac_cb *mac_cb, int stringset,
> >> u8 **data)
> >>   {
> >>       struct mac_driver *mac_ctrl_drv =3D hns_mac_get_drv(mac_cb);
> >>   diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
> >> b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
> >> index edf0bcf76ac9..630f01cf7a71 100644
> >> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
> >> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
> >> @@ -378,7 +378,7 @@ struct mac_driver {
> >>       void (*get_regs)(void *mac_drv, void *data);
> >>       int (*get_regs_count)(void);
> >>       /* get strings name for ethtool statistic */
> >> -    void (*get_strings)(u32 stringset, u8 *data);
> >> +    void (*get_strings)(u32 stringset, u8 **data);
> >>       /* get the number of strings*/
> >>       int (*get_sset_count)(int stringset);
> >>   @@ -445,7 +445,7 @@ int hns_mac_config_mac_loopback(struct
> >> hns_mac_cb *mac_cb,
> >>                   enum hnae_loop loop, int en);
> >>   void hns_mac_update_stats(struct hns_mac_cb *mac_cb);
> >>   void hns_mac_get_stats(struct hns_mac_cb *mac_cb, u64 *data);
> >> -void hns_mac_get_strings(struct hns_mac_cb *mac_cb, int stringset,
> >> u8 *data);
> >> +void hns_mac_get_strings(struct hns_mac_cb *mac_cb, int stringset,
> >> u8 **data);
> >>   int hns_mac_get_sset_count(struct hns_mac_cb *mac_cb, int stringset)=
;
> >>   void hns_mac_get_regs(struct hns_mac_cb *mac_cb, void *data);
> >>   int hns_mac_get_regs_count(struct hns_mac_cb *mac_cb);
> >> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> >> b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> >> index eb60f45a3460..851490346261 100644
> >> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> >> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> >> @@ -2590,55 +2590,34 @@ void hns_dsaf_get_regs(struct dsaf_device
> >> *ddev, u32 port, void *data)
> >>           p[i] =3D 0xdddddddd;
> >>   }
> >>   -static char *hns_dsaf_get_node_stats_strings(char *data, int node,
> >> -                         struct dsaf_device *dsaf_dev)
> >> +static void hns_dsaf_get_node_stats_strings(u8 **data, int node,
> >> +                        struct dsaf_device *dsaf_dev)
> >>   {
> >> -    char *buff =3D data;
> >> -    int i;
> >>       bool is_ver1 =3D AE_IS_VER1(dsaf_dev->dsaf_ver);
> >> +    int i;
> >>   -    snprintf(buff, ETH_GSTRING_LEN, "innod%d_pad_drop_pkts", node);
> >> -    buff +=3D ETH_GSTRING_LEN;
> >> -    snprintf(buff, ETH_GSTRING_LEN, "innod%d_manage_pkts", node);
> >> -    buff +=3D ETH_GSTRING_LEN;
> >> -    snprintf(buff, ETH_GSTRING_LEN, "innod%d_rx_pkts", node);
> >> -    buff +=3D ETH_GSTRING_LEN;
> >> -    snprintf(buff, ETH_GSTRING_LEN, "innod%d_rx_pkt_id", node);
> >> -    buff +=3D ETH_GSTRING_LEN;
> >> -    snprintf(buff, ETH_GSTRING_LEN, "innod%d_rx_pause_frame", node);
> >> -    buff +=3D ETH_GSTRING_LEN;
> >> -    snprintf(buff, ETH_GSTRING_LEN, "innod%d_release_buf_num", node);
> >> -    buff +=3D ETH_GSTRING_LEN;
> >> -    snprintf(buff, ETH_GSTRING_LEN, "innod%d_sbm_drop_pkts", node);
> >> -    buff +=3D ETH_GSTRING_LEN;
> >> -    snprintf(buff, ETH_GSTRING_LEN, "innod%d_crc_false_pkts", node);
> >> -    buff +=3D ETH_GSTRING_LEN;
> >> -    snprintf(buff, ETH_GSTRING_LEN, "innod%d_bp_drop_pkts", node);
> >> -    buff +=3D ETH_GSTRING_LEN;
> >> -    snprintf(buff, ETH_GSTRING_LEN, "innod%d_lookup_rslt_drop_pkts",
> >> node);
> >> -    buff +=3D ETH_GSTRING_LEN;
> >> -    snprintf(buff, ETH_GSTRING_LEN, "innod%d_local_rslt_fail_pkts",
> >> node);
> >> -    buff +=3D ETH_GSTRING_LEN;
> >> -    snprintf(buff, ETH_GSTRING_LEN, "innod%d_vlan_drop_pkts", node);
> >> -    buff +=3D ETH_GSTRING_LEN;
> >> -    snprintf(buff, ETH_GSTRING_LEN, "innod%d_stp_drop_pkts", node);
> >> -    buff +=3D ETH_GSTRING_LEN;
> >> +    ethtool_sprintf(data, "innod%d_pad_drop_pkts", node);
> >> +    ethtool_sprintf(data, "innod%d_manage_pkts", node);
> >> +    ethtool_sprintf(data, "innod%d_rx_pkts", node);
> >> +    ethtool_sprintf(data, "innod%d_rx_pkt_id", node);
> >> +    ethtool_sprintf(data, "innod%d_rx_pause_frame", node);
> >> +    ethtool_sprintf(data, "innod%d_release_buf_num", node);
> >> +    ethtool_sprintf(data, "innod%d_sbm_drop_pkts", node);
> >> +    ethtool_sprintf(data, "innod%d_crc_false_pkts", node);
> >> +    ethtool_sprintf(data, "innod%d_bp_drop_pkts", node);
> >> +    ethtool_sprintf(data, "innod%d_lookup_rslt_drop_pkts", node);
> >> +    ethtool_sprintf(data, "innod%d_local_rslt_fail_pkts", node);
> >> +    ethtool_sprintf(data, "innod%d_vlan_drop_pkts", node);
> >> +    ethtool_sprintf(data, "innod%d_stp_drop_pkts", node);
> >>       if (node < DSAF_SERVICE_NW_NUM && !is_ver1) {
> >>           for (i =3D 0; i < DSAF_PRIO_NR; i++) {
> >> -            snprintf(buff + 0 * ETH_GSTRING_LEN * DSAF_PRIO_NR,
> >> -                 ETH_GSTRING_LEN, "inod%d_pfc_prio%d_pkts",
> >> -                 node, i);
> >> -            snprintf(buff + 1 * ETH_GSTRING_LEN * DSAF_PRIO_NR,
> >> -                 ETH_GSTRING_LEN, "onod%d_pfc_prio%d_pkts",
> >> -                 node, i);
> >> -            buff +=3D ETH_GSTRING_LEN;
> >> +            ethtool_sprintf(data, "inod%d_pfc_prio%d_pkts", node,
> >> +                    i);
> >> +            ethtool_sprintf(data, "onod%d_pfc_prio%d_pkts", node,
> >> +                    i);
> >>           }
> >> -        buff +=3D 1 * DSAF_PRIO_NR * ETH_GSTRING_LEN;
> >>       }
> >> -    snprintf(buff, ETH_GSTRING_LEN, "onnod%d_tx_pkts", node);
> >> -    buff +=3D ETH_GSTRING_LEN;
> >> -
> >> -    return buff;
> >> +    ethtool_sprintf(data, "onnod%d_tx_pkts", node);
> >>   }
> >>     static u64 *hns_dsaf_get_node_stats(struct dsaf_device *ddev, u64
> >> *data,
> >> @@ -2720,21 +2699,20 @@ int hns_dsaf_get_sset_count(struct
> >> dsaf_device *dsaf_dev, int stringset)
> >>    *@port:port index
> >>    *@dsaf_dev: dsaf device
> >>    */
> >> -void hns_dsaf_get_strings(int stringset, u8 *data, int port,
> >> +void hns_dsaf_get_strings(int stringset, u8 **data, int port,
> >>                 struct dsaf_device *dsaf_dev)
> >>   {
> >> -    char *buff =3D (char *)data;
> >>       int node =3D port;
> >>         if (stringset !=3D ETH_SS_STATS)
> >>           return;
> >>         /* for ge/xge node info */
> >> -    buff =3D hns_dsaf_get_node_stats_strings(buff, node, dsaf_dev);
> >> +    hns_dsaf_get_node_stats_strings(data, node, dsaf_dev);
> >>         /* for ppe node info */
> >>       node =3D port + DSAF_PPE_INODE_BASE;
> >> -    (void)hns_dsaf_get_node_stats_strings(buff, node, dsaf_dev);
> >> +    hns_dsaf_get_node_stats_strings(data, node, dsaf_dev);
> >>   }
> >>     /**
> >> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
> >> b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
> >> index 5526a10caac5..0eb03dff1a8b 100644
> >> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
> >> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
> >> @@ -442,7 +442,7 @@ void hns_dsaf_update_stats(struct dsaf_device
> >> *dsaf_dev, u32 inode_num);
> >>     int hns_dsaf_get_sset_count(struct dsaf_device *dsaf_dev, int
> >> stringset);
> >>   void hns_dsaf_get_stats(struct dsaf_device *ddev, u64 *data, int
> >> port);
> >> -void hns_dsaf_get_strings(int stringset, u8 *data, int port,
> >> +void hns_dsaf_get_strings(int stringset, u8 **data, int port,
> >>                 struct dsaf_device *dsaf_dev);
> >>     void hns_dsaf_get_regs(struct dsaf_device *ddev, u32 port, void
> >> *data);
> >> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
> >> b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
> >> index a08d1f0a5a16..5013beb4d282 100644
> >> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
> >> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
> >> @@ -457,24 +457,23 @@ int hns_ppe_get_regs_count(void)
> >>    * @stringset: string set type
> >>    * @data: output string
> >>    */
> >> -void hns_ppe_get_strings(struct hns_ppe_cb *ppe_cb, int stringset,
> >> u8 *data)
> >> +void hns_ppe_get_strings(struct hns_ppe_cb *ppe_cb, int stringset,
> >> u8 **data)
> >>   {
> >>       int index =3D ppe_cb->index;
> >> -    u8 *buff =3D data;
> >> -
> >> -    ethtool_sprintf(&buff, "ppe%d_rx_sw_pkt", index);
> >> -    ethtool_sprintf(&buff, "ppe%d_rx_pkt_ok", index);
> >> -    ethtool_sprintf(&buff, "ppe%d_rx_drop_pkt_no_bd", index);
> >> -    ethtool_sprintf(&buff, "ppe%d_rx_alloc_buf_fail", index);
> >> -    ethtool_sprintf(&buff, "ppe%d_rx_alloc_buf_wait", index);
> >> -    ethtool_sprintf(&buff, "ppe%d_rx_pkt_drop_no_buf", index);
> >> -    ethtool_sprintf(&buff, "ppe%d_rx_pkt_err_fifo_full", index);
> >> -
> >> -    ethtool_sprintf(&buff, "ppe%d_tx_bd", index);
> >> -    ethtool_sprintf(&buff, "ppe%d_tx_pkt", index);
> >> -    ethtool_sprintf(&buff, "ppe%d_tx_pkt_ok", index);
> >> -    ethtool_sprintf(&buff, "ppe%d_tx_pkt_err_fifo_empty", index);
> >> -    ethtool_sprintf(&buff, "ppe%d_tx_pkt_err_csum_fail", index);
> >> +
> >> +    ethtool_sprintf(data, "ppe%d_rx_sw_pkt", index);
> >> +    ethtool_sprintf(data, "ppe%d_rx_pkt_ok", index);
> >> +    ethtool_sprintf(data, "ppe%d_rx_drop_pkt_no_bd", index);
> >> +    ethtool_sprintf(data, "ppe%d_rx_alloc_buf_fail", index);
> >> +    ethtool_sprintf(data, "ppe%d_rx_alloc_buf_wait", index);
> >> +    ethtool_sprintf(data, "ppe%d_rx_pkt_drop_no_buf", index);
> >> +    ethtool_sprintf(data, "ppe%d_rx_pkt_err_fifo_full", index);
> >> +
> >> +    ethtool_sprintf(data, "ppe%d_tx_bd", index);
> >> +    ethtool_sprintf(data, "ppe%d_tx_pkt", index);
> >> +    ethtool_sprintf(data, "ppe%d_tx_pkt_ok", index);
> >> +    ethtool_sprintf(data, "ppe%d_tx_pkt_err_fifo_empty", index);
> >> +    ethtool_sprintf(data, "ppe%d_tx_pkt_err_csum_fail", index);
> >>   }
> >>     void hns_ppe_get_stats(struct hns_ppe_cb *ppe_cb, u64 *data)
> >> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
> >> b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
> >> index 7e00231c1acf..602c8e971fe4 100644
> >> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
> >> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
> >> @@ -109,7 +109,7 @@ int hns_ppe_get_sset_count(int stringset);
> >>   int hns_ppe_get_regs_count(void);
> >>   void hns_ppe_get_regs(struct hns_ppe_cb *ppe_cb, void *data);
> >>   -void hns_ppe_get_strings(struct hns_ppe_cb *ppe_cb, int stringset,
> >> u8 *data);
> >> +void hns_ppe_get_strings(struct hns_ppe_cb *ppe_cb, int stringset,
> >> u8 **data);
> >>   void hns_ppe_get_stats(struct hns_ppe_cb *ppe_cb, u64 *data);
> >>   void hns_ppe_set_tso_enable(struct hns_ppe_cb *ppe_cb, u32 value);
> >>   void hns_ppe_set_rss_key(struct hns_ppe_cb *ppe_cb,
> >> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
> >> b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
> >> index 93344563a259..46af467aa596 100644
> >> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
> >> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
> >> @@ -923,44 +923,42 @@ int hns_rcb_get_ring_regs_count(void)
> >>    *@data:strings name value
> >>    *@index:queue index
> >>    */
> >> -void hns_rcb_get_strings(int stringset, u8 *data, int index)
> >> +void hns_rcb_get_strings(int stringset, u8 **data, int index)
> >>   {
> >> -    u8 *buff =3D data;
> >> -
> >>       if (stringset !=3D ETH_SS_STATS)
> >>           return;
> >>   -    ethtool_sprintf(&buff, "tx_ring%d_rcb_pkt_num", index);
> >> -    ethtool_sprintf(&buff, "tx_ring%d_ppe_tx_pkt_num", index);
> >> -    ethtool_sprintf(&buff, "tx_ring%d_ppe_drop_pkt_num", index);
> >> -    ethtool_sprintf(&buff, "tx_ring%d_fbd_num", index);
> >> -
> >> -    ethtool_sprintf(&buff, "tx_ring%d_pkt_num", index);
> >> -    ethtool_sprintf(&buff, "tx_ring%d_bytes", index);
> >> -    ethtool_sprintf(&buff, "tx_ring%d_err_cnt", index);
> >> -    ethtool_sprintf(&buff, "tx_ring%d_io_err", index);
> >> -    ethtool_sprintf(&buff, "tx_ring%d_sw_err", index);
> >> -    ethtool_sprintf(&buff, "tx_ring%d_seg_pkt", index);
> >> -    ethtool_sprintf(&buff, "tx_ring%d_restart_queue", index);
> >> -    ethtool_sprintf(&buff, "tx_ring%d_tx_busy", index);
> >> -
> >> -    ethtool_sprintf(&buff, "rx_ring%d_rcb_pkt_num", index);
> >> -    ethtool_sprintf(&buff, "rx_ring%d_ppe_pkt_num", index);
> >> -    ethtool_sprintf(&buff, "rx_ring%d_ppe_drop_pkt_num", index);
> >> -    ethtool_sprintf(&buff, "rx_ring%d_fbd_num", index);
> >> -
> >> -    ethtool_sprintf(&buff, "rx_ring%d_pkt_num", index);
> >> -    ethtool_sprintf(&buff, "rx_ring%d_bytes", index);
> >> -    ethtool_sprintf(&buff, "rx_ring%d_err_cnt", index);
> >> -    ethtool_sprintf(&buff, "rx_ring%d_io_err", index);
> >> -    ethtool_sprintf(&buff, "rx_ring%d_sw_err", index);
> >> -    ethtool_sprintf(&buff, "rx_ring%d_seg_pkt", index);
> >> -    ethtool_sprintf(&buff, "rx_ring%d_reuse_pg", index);
> >> -    ethtool_sprintf(&buff, "rx_ring%d_len_err", index);
> >> -    ethtool_sprintf(&buff, "rx_ring%d_non_vld_desc_err", index);
> >> -    ethtool_sprintf(&buff, "rx_ring%d_bd_num_err", index);
> >> -    ethtool_sprintf(&buff, "rx_ring%d_l2_err", index);
> >> -    ethtool_sprintf(&buff, "rx_ring%d_l3l4csum_err", index);
> >> +    ethtool_sprintf(data, "tx_ring%d_rcb_pkt_num", index);
> >> +    ethtool_sprintf(data, "tx_ring%d_ppe_tx_pkt_num", index);
> >> +    ethtool_sprintf(data, "tx_ring%d_ppe_drop_pkt_num", index);
> >> +    ethtool_sprintf(data, "tx_ring%d_fbd_num", index);
> >> +
> >> +    ethtool_sprintf(data, "tx_ring%d_pkt_num", index);
> >> +    ethtool_sprintf(data, "tx_ring%d_bytes", index);
> >> +    ethtool_sprintf(data, "tx_ring%d_err_cnt", index);
> >> +    ethtool_sprintf(data, "tx_ring%d_io_err", index);
> >> +    ethtool_sprintf(data, "tx_ring%d_sw_err", index);
> >> +    ethtool_sprintf(data, "tx_ring%d_seg_pkt", index);
> >> +    ethtool_sprintf(data, "tx_ring%d_restart_queue", index);
> >> +    ethtool_sprintf(data, "tx_ring%d_tx_busy", index);
> >> +
> >> +    ethtool_sprintf(data, "rx_ring%d_rcb_pkt_num", index);
> >> +    ethtool_sprintf(data, "rx_ring%d_ppe_pkt_num", index);
> >> +    ethtool_sprintf(data, "rx_ring%d_ppe_drop_pkt_num", index);
> >> +    ethtool_sprintf(data, "rx_ring%d_fbd_num", index);
> >> +
> >> +    ethtool_sprintf(data, "rx_ring%d_pkt_num", index);
> >> +    ethtool_sprintf(data, "rx_ring%d_bytes", index);
> >> +    ethtool_sprintf(data, "rx_ring%d_err_cnt", index);
> >> +    ethtool_sprintf(data, "rx_ring%d_io_err", index);
> >> +    ethtool_sprintf(data, "rx_ring%d_sw_err", index);
> >> +    ethtool_sprintf(data, "rx_ring%d_seg_pkt", index);
> >> +    ethtool_sprintf(data, "rx_ring%d_reuse_pg", index);
> >> +    ethtool_sprintf(data, "rx_ring%d_len_err", index);
> >> +    ethtool_sprintf(data, "rx_ring%d_non_vld_desc_err", index);
> >> +    ethtool_sprintf(data, "rx_ring%d_bd_num_err", index);
> >> +    ethtool_sprintf(data, "rx_ring%d_l2_err", index);
> >> +    ethtool_sprintf(data, "rx_ring%d_l3l4csum_err", index);
> >>   }
> >>     void hns_rcb_get_common_regs(struct rcb_common_cb *rcb_com, void
> >> *data)
> >> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
> >> b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
> >> index c1e9b6997853..0f4cc184ef39 100644
> >> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
> >> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
> >> @@ -157,7 +157,7 @@ int hns_rcb_get_ring_regs_count(void);
> >>     void hns_rcb_get_ring_regs(struct hnae_queue *queue, void *data);
> >>   -void hns_rcb_get_strings(int stringset, u8 *data, int index);
> >> +void hns_rcb_get_strings(int stringset, u8 **data, int index);
> >>   void hns_rcb_set_rx_ring_bs(struct hnae_queue *q, u32 buf_size);
> >>   void hns_rcb_set_tx_ring_bs(struct hnae_queue *q, u32 buf_size);
> >>   diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
> >> b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
> >> index c58833eb4830..dbc44c2c26c2 100644
> >> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
> >> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
> >> @@ -743,16 +743,15 @@ static void hns_xgmac_get_stats(void *mac_drv,
> >> u64 *data)
> >>    *@stringset: type of values in data
> >>    *@data:data for value of string name
> >>    */
> >> -static void hns_xgmac_get_strings(u32 stringset, u8 *data)
> >> +static void hns_xgmac_get_strings(u32 stringset, u8 **data)
> >>   {
> >> -    u8 *buff =3D data;
> >>       u32 i;
> >>         if (stringset !=3D ETH_SS_STATS)
> >>           return;
> >>         for (i =3D 0; i < ARRAY_SIZE(g_xgmac_stats_string); i++)
> >> -        ethtool_puts(&buff, g_xgmac_stats_string[i].desc);
> >> +        ethtool_puts(data, g_xgmac_stats_string[i].desc);
> >>   }
> >>     /**
> >> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
> >> b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
> >> index a5bb306b2cf1..6c458f037262 100644
> >> --- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
> >> +++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
> >> @@ -903,7 +903,6 @@ static void hns_get_strings(struct net_device
> >> *netdev, u32 stringset, u8 *data)
> >>   {
> >>       struct hns_nic_priv *priv =3D netdev_priv(netdev);
> >>       struct hnae_handle *h =3D priv->ae_handle;
> >> -    u8 *buff =3D data;
> >>         if (!h->dev->ops->get_strings) {
> >>           netdev_err(netdev, "h->dev->ops->get_strings is null!\n");
> >> @@ -912,43 +911,43 @@ static void hns_get_strings(struct net_device
> >> *netdev, u32 stringset, u8 *data)
> >>         if (stringset =3D=3D ETH_SS_TEST) {
> >>           if (priv->ae_handle->phy_if !=3D PHY_INTERFACE_MODE_XGMII)
> >> -            ethtool_puts(&buff,
> >> +            ethtool_puts(&data,
> >>                        hns_nic_test_strs[MAC_INTERNALLOOP_MAC]);
> >> -        ethtool_puts(&buff,
> >> hns_nic_test_strs[MAC_INTERNALLOOP_SERDES]);
> >> +        ethtool_puts(&data,
> >> hns_nic_test_strs[MAC_INTERNALLOOP_SERDES]);
> >>           if ((netdev->phydev) && (!netdev->phydev->is_c45))
> >> -            ethtool_puts(&buff,
> >> +            ethtool_puts(&data,
> >>                        hns_nic_test_strs[MAC_INTERNALLOOP_PHY]);
> >>         } else {
> >> -        ethtool_puts(&buff, "rx_packets");
> >> -        ethtool_puts(&buff, "tx_packets");
> >> -        ethtool_puts(&buff, "rx_bytes");
> >> -        ethtool_puts(&buff, "tx_bytes");
> >> -        ethtool_puts(&buff, "rx_errors");
> >> -        ethtool_puts(&buff, "tx_errors");
> >> -        ethtool_puts(&buff, "rx_dropped");
> >> -        ethtool_puts(&buff, "tx_dropped");
> >> -        ethtool_puts(&buff, "multicast");
> >> -        ethtool_puts(&buff, "collisions");
> >> -        ethtool_puts(&buff, "rx_over_errors");
> >> -        ethtool_puts(&buff, "rx_crc_errors");
> >> -        ethtool_puts(&buff, "rx_frame_errors");
> >> -        ethtool_puts(&buff, "rx_fifo_errors");
> >> -        ethtool_puts(&buff, "rx_missed_errors");
> >> -        ethtool_puts(&buff, "tx_aborted_errors");
> >> -        ethtool_puts(&buff, "tx_carrier_errors");
> >> -        ethtool_puts(&buff, "tx_fifo_errors");
> >> -        ethtool_puts(&buff, "tx_heartbeat_errors");
> >> -        ethtool_puts(&buff, "rx_length_errors");
> >> -        ethtool_puts(&buff, "tx_window_errors");
> >> -        ethtool_puts(&buff, "rx_compressed");
> >> -        ethtool_puts(&buff, "tx_compressed");
> >> -        ethtool_puts(&buff, "netdev_rx_dropped");
> >> -        ethtool_puts(&buff, "netdev_tx_dropped");
> >> -
> >> -        ethtool_puts(&buff, "netdev_tx_timeout");
> >> -
> >> -        h->dev->ops->get_strings(h, stringset, buff);
> >> +        ethtool_puts(&data, "rx_packets");
> >> +        ethtool_puts(&data, "tx_packets");
> >> +        ethtool_puts(&data, "rx_bytes");
> >> +        ethtool_puts(&data, "tx_bytes");
> >> +        ethtool_puts(&data, "rx_errors");
> >> +        ethtool_puts(&data, "tx_errors");
> >> +        ethtool_puts(&data, "rx_dropped");
> >> +        ethtool_puts(&data, "tx_dropped");
> >> +        ethtool_puts(&data, "multicast");
> >> +        ethtool_puts(&data, "collisions");
> >> +        ethtool_puts(&data, "rx_over_errors");
> >> +        ethtool_puts(&data, "rx_crc_errors");
> >> +        ethtool_puts(&data, "rx_frame_errors");
> >> +        ethtool_puts(&data, "rx_fifo_errors");
> >> +        ethtool_puts(&data, "rx_missed_errors");
> >> +        ethtool_puts(&data, "tx_aborted_errors");
> >> +        ethtool_puts(&data, "tx_carrier_errors");
> >> +        ethtool_puts(&data, "tx_fifo_errors");
> >> +        ethtool_puts(&data, "tx_heartbeat_errors");
> >> +        ethtool_puts(&data, "rx_length_errors");
> >> +        ethtool_puts(&data, "tx_window_errors");
> >> +        ethtool_puts(&data, "rx_compressed");
> >> +        ethtool_puts(&data, "tx_compressed");
> >> +        ethtool_puts(&data, "netdev_rx_dropped");
> >> +        ethtool_puts(&data, "netdev_tx_dropped");
> >> +
> >> +        ethtool_puts(&data, "netdev_tx_timeout");
> >> +
> >> +        h->dev->ops->get_strings(h, stringset, &data);
> >>       }
> >>   }
> >>   @@ -970,7 +969,7 @@ static int hns_get_sset_count(struct net_device
> >> *netdev, int stringset)
> >>           return -EOPNOTSUPP;
> >>       }
> >>       if (stringset =3D=3D ETH_SS_TEST) {
> >> -        u32 cnt =3D (sizeof(hns_nic_test_strs) / ETH_GSTRING_LEN);
> >> +        u32 cnt =3D ARRAY_SIZE(hns_nic_test_strs);
> >>             if (priv->ae_handle->phy_if =3D=3D PHY_INTERFACE_MODE_XGMI=
I)
> >>               cnt--;
> >> diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
> >> b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
> >> index 27dbe367f3d3..710a8f9f2248 100644
> >> --- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
> >> +++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
> >> @@ -677,7 +677,7 @@ struct hnae3_ae_ops {
> >>       void (*get_mac_stats)(struct hnae3_handle *handle,
> >>                     struct hns3_mac_stats *mac_stats);
> >>       void (*get_strings)(struct hnae3_handle *handle,
> >> -                u32 stringset, u8 *data);
> >> +                u32 stringset, u8 **data);
> >>       int (*get_sset_count)(struct hnae3_handle *handle, int stringset=
);
> >>         void (*get_regs)(struct hnae3_handle *handle, u32 *version,
> >> diff --git
> >> a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats=
.c
> >> b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats=
.c
> >> index 2b31188ff555..f9a3d6fc4416 100644
> >> ---
> >> a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats=
.c
> >> +++
> >> b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats=
.c
> >> @@ -36,27 +36,22 @@ int hclge_comm_tqps_get_sset_count(struct
> >> hnae3_handle *handle)
> >>   }
> >>   EXPORT_SYMBOL_GPL(hclge_comm_tqps_get_sset_count);
> >>   -u8 *hclge_comm_tqps_get_strings(struct hnae3_handle *handle, u8
> >> *data)
> >> +void hclge_comm_tqps_get_strings(struct hnae3_handle *handle, u8
> >> **data)
> >>   {
> >>       struct hnae3_knic_private_info *kinfo =3D &handle->kinfo;
> >> -    u8 *buff =3D data;
> >>       u16 i;
> >>         for (i =3D 0; i < kinfo->num_tqps; i++) {
> >>           struct hclge_comm_tqp *tqp =3D
> >>               container_of(kinfo->tqp[i], struct hclge_comm_tqp, q);
> >> -        snprintf(buff, ETH_GSTRING_LEN, "txq%u_pktnum_rcd",
> >> tqp->index);
> >> -        buff +=3D ETH_GSTRING_LEN;
> >> +        ethtool_sprintf(data, "txq%u_pktnum_rcd", tqp->index);
> >>       }
> >>         for (i =3D 0; i < kinfo->num_tqps; i++) {
> >>           struct hclge_comm_tqp *tqp =3D
> >>               container_of(kinfo->tqp[i], struct hclge_comm_tqp, q);
> >> -        snprintf(buff, ETH_GSTRING_LEN, "rxq%u_pktnum_rcd",
> >> tqp->index);
> >> -        buff +=3D ETH_GSTRING_LEN;
> >> +        ethtool_sprintf(data, "rxq%u_pktnum_rcd", tqp->index);
> >>       }
> >> -
> >> -    return buff;
> >>   }
> >>   EXPORT_SYMBOL_GPL(hclge_comm_tqps_get_strings);
> >>   diff --git
> >> a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats=
.h
> >> b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats=
.h
> >> index a46350162ee8..b9ff424c0bc2 100644
> >> ---
> >> a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats=
.h
> >> +++
> >> b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats=
.h
> >> @@ -32,7 +32,7 @@ struct hclge_comm_tqp {
> >>     u64 *hclge_comm_tqps_get_stats(struct hnae3_handle *handle, u64
> >> *data);
> >>   int hclge_comm_tqps_get_sset_count(struct hnae3_handle *handle);
> >> -u8 *hclge_comm_tqps_get_strings(struct hnae3_handle *handle, u8 *data=
);
> >> +void hclge_comm_tqps_get_strings(struct hnae3_handle *handle, u8
> >> **data);
> >>   void hclge_comm_reset_tqp_stats(struct hnae3_handle *handle);
> >>   int hclge_comm_tqps_update_stats(struct hnae3_handle *handle,
> >>                    struct hclge_comm_hw *hw);
> >> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> >> b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> >> index b1e988347347..a6b1ab7d6ee2 100644
> >> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> >> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> >> @@ -509,54 +509,38 @@ static int hns3_get_sset_count(struct
> >> net_device *netdev, int stringset)
> >>       }
> >>   }
> >>   -static void *hns3_update_strings(u8 *data, const struct hns3_stats
> >> *stats,
> >> -        u32 stat_count, u32 num_tqps, const char *prefix)
> >> +static void hns3_update_strings(u8 **data, const struct hns3_stats
> >> *stats,
> >> +                u32 stat_count, u32 num_tqps,
> >> +                const char *prefix)
> >>   {
> >>   #define MAX_PREFIX_SIZE (6 + 4)
> >> -    u32 size_left;
> >>       u32 i, j;
> >> -    u32 n1;
> >>   -    for (i =3D 0; i < num_tqps; i++) {
> >> -        for (j =3D 0; j < stat_count; j++) {
> >> -            data[ETH_GSTRING_LEN - 1] =3D '\0';
> >> -
> >> -            /* first, prepend the prefix string */
> >> -            n1 =3D scnprintf(data, MAX_PREFIX_SIZE, "%s%u_",
> >> -                       prefix, i);
> >> -            size_left =3D (ETH_GSTRING_LEN - 1) - n1;
> >> -
> >> -            /* now, concatenate the stats string to it */
> >> -            strncat(data, stats[j].stats_string, size_left);
> >> -            data +=3D ETH_GSTRING_LEN;
> >> -        }
> >> -    }
> >> -
> >> -    return data;
> >> +    for (i =3D 0; i < num_tqps; i++)
> >> +        for (j =3D 0; j < stat_count; j++)
> >> +            ethtool_sprintf(data, "%s%u_%s", prefix, i,
> >> +                    stats[j].stats_string);
> >>   }
> >>   -static u8 *hns3_get_strings_tqps(struct hnae3_handle *handle, u8
> >> *data)
> >> +static void hns3_get_strings_tqps(struct hnae3_handle *handle, u8
> >> **data)
> >>   {
> >>       struct hnae3_knic_private_info *kinfo =3D &handle->kinfo;
> >>       const char tx_prefix[] =3D "txq";
> >>       const char rx_prefix[] =3D "rxq";
> >>         /* get strings for Tx */
> >> -    data =3D hns3_update_strings(data, hns3_txq_stats,
> >> HNS3_TXQ_STATS_COUNT,
> >> -                   kinfo->num_tqps, tx_prefix);
> >> +    hns3_update_strings(data, hns3_txq_stats, HNS3_TXQ_STATS_COUNT,
> >> +                kinfo->num_tqps, tx_prefix);
> >>         /* get strings for Rx */
> >> -    data =3D hns3_update_strings(data, hns3_rxq_stats,
> >> HNS3_RXQ_STATS_COUNT,
> >> -                   kinfo->num_tqps, rx_prefix);
> >> -
> >> -    return data;
> >> +    hns3_update_strings(data, hns3_rxq_stats, HNS3_RXQ_STATS_COUNT,
> >> +                kinfo->num_tqps, rx_prefix);
> >>   }
> >>     static void hns3_get_strings(struct net_device *netdev, u32
> >> stringset, u8 *data)
> >>   {
> >>       struct hnae3_handle *h =3D hns3_get_handle(netdev);
> >>       const struct hnae3_ae_ops *ops =3D h->ae_algo->ops;
> >> -    char *buff =3D (char *)data;
> >>       int i;
> >>         if (!ops->get_strings)
> >> @@ -564,18 +548,15 @@ static void hns3_get_strings(struct net_device
> >> *netdev, u32 stringset, u8 *data)
> >>         switch (stringset) {
> >>       case ETH_SS_STATS:
> >> -        buff =3D hns3_get_strings_tqps(h, buff);
> >> -        ops->get_strings(h, stringset, (u8 *)buff);
> >> +        hns3_get_strings_tqps(h, &data);
> >> +        ops->get_strings(h, stringset, &data);
> >>           break;
> >>       case ETH_SS_TEST:
> >> -        ops->get_strings(h, stringset, data);
> >> +        ops->get_strings(h, stringset, &data);
> >>           break;
> >>       case ETH_SS_PRIV_FLAGS:
> >> -        for (i =3D 0; i < HNS3_PRIV_FLAGS_LEN; i++) {
> >> -            snprintf(buff, ETH_GSTRING_LEN, "%s",
> >> -                 hns3_priv_flags[i].name);
> >> -            buff +=3D ETH_GSTRING_LEN;
> >> -        }
> >> +        for (i =3D 0; i < HNS3_PRIV_FLAGS_LEN; i++)
> >> +            ethtool_puts(&data, hns3_priv_flags[i].name);
> >>           break;
> >>       default:
> >>           break;
> >> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> >> b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> >> index bd86efd92a5a..05942fa78b11 100644
> >> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> >> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> >> @@ -594,25 +594,21 @@ static u64 *hclge_comm_get_stats(struct
> >> hclge_dev *hdev,
> >>       return buf;
> >>   }
> >>   -static u8 *hclge_comm_get_strings(struct hclge_dev *hdev, u32
> >> stringset,
> >> -                  const struct hclge_comm_stats_str strs[],
> >> -                  int size, u8 *data)
> >> +static void hclge_comm_get_strings(struct hclge_dev *hdev, u32
> >> stringset,
> >> +                   const struct hclge_comm_stats_str strs[],
> >> +                   int size, u8 **data)
> >>   {
> >> -    char *buff =3D (char *)data;
> >>       u32 i;
> >>         if (stringset !=3D ETH_SS_STATS)
> >> -        return buff;
> >> +        return;
> >>         for (i =3D 0; i < size; i++) {
> >>           if (strs[i].stats_num > hdev->ae_dev->dev_specs.mac_stats_nu=
m)
> >>               continue;
> >>   -        snprintf(buff, ETH_GSTRING_LEN, "%s", strs[i].desc);
> >> -        buff =3D buff + ETH_GSTRING_LEN;
> >> +        ethtool_puts(data, strs[i].desc);
> >>       }
> >> -
> >> -    return (u8 *)buff;
> >>   }
> >>     static void hclge_update_stats_for_all(struct hclge_dev *hdev)
> >> @@ -717,44 +713,38 @@ static int hclge_get_sset_count(struct
> >> hnae3_handle *handle, int stringset)
> >>   }
> >>     static void hclge_get_strings(struct hnae3_handle *handle, u32
> >> stringset,
> >> -                  u8 *data)
> >> +                  u8 **data)
> >>   {
> >>       struct hclge_vport *vport =3D hclge_get_vport(handle);
> >>       struct hclge_dev *hdev =3D vport->back;
> >> -    u8 *p =3D (char *)data;
> >> +    const char *str;
> >>       int size;
> >>         if (stringset =3D=3D ETH_SS_STATS) {
> >>           size =3D ARRAY_SIZE(g_mac_stats_string);
> >> -        p =3D hclge_comm_get_strings(hdev, stringset, g_mac_stats_str=
ing,
> >> -                       size, p);
> >> -        p =3D hclge_comm_tqps_get_strings(handle, p);
> >> +        hclge_comm_get_strings(hdev, stringset, g_mac_stats_string,
> >> +                       size, data);
> >> +        hclge_comm_tqps_get_strings(handle, data);
> >>       } else if (stringset =3D=3D ETH_SS_TEST) {
> >>           if (handle->flags & HNAE3_SUPPORT_EXTERNAL_LOOPBACK) {
> >> -            memcpy(p, hns3_nic_test_strs[HNAE3_LOOP_EXTERNAL],
> >> -                   ETH_GSTRING_LEN);
> >> -            p +=3D ETH_GSTRING_LEN;
> >> +            str =3D hns3_nic_test_strs[HNAE3_LOOP_EXTERNAL];
> >> +            ethtool_puts(data, str);
> >>           }
> >>           if (handle->flags & HNAE3_SUPPORT_APP_LOOPBACK) {
> >> -            memcpy(p, hns3_nic_test_strs[HNAE3_LOOP_APP],
> >> -                   ETH_GSTRING_LEN);
> >> -            p +=3D ETH_GSTRING_LEN;
> >> +            str =3D hns3_nic_test_strs[HNAE3_LOOP_APP];
> >> +            ethtool_puts(data, str);
> >>           }
> >>           if (handle->flags & HNAE3_SUPPORT_SERDES_SERIAL_LOOPBACK) {
> >> -            memcpy(p, hns3_nic_test_strs[HNAE3_LOOP_SERIAL_SERDES],
> >> -                   ETH_GSTRING_LEN);
> >> -            p +=3D ETH_GSTRING_LEN;
> >> +            str =3D hns3_nic_test_strs[HNAE3_LOOP_SERIAL_SERDES];
> >> +            ethtool_puts(data, str);
> >>           }
> >>           if (handle->flags & HNAE3_SUPPORT_SERDES_PARALLEL_LOOPBACK) =
{
> >> -            memcpy(p,
> >> - hns3_nic_test_strs[HNAE3_LOOP_PARALLEL_SERDES],
> >> -                   ETH_GSTRING_LEN);
> >> -            p +=3D ETH_GSTRING_LEN;
> >> +            str =3D hns3_nic_test_strs[HNAE3_LOOP_PARALLEL_SERDES];
> >> +            ethtool_puts(data, str);
> >>           }
> >>           if (handle->flags & HNAE3_SUPPORT_PHY_LOOPBACK) {
> >> -            memcpy(p, hns3_nic_test_strs[HNAE3_LOOP_PHY],
> >> -                   ETH_GSTRING_LEN);
> >> -            p +=3D ETH_GSTRING_LEN;
> >> +            str =3D hns3_nic_test_strs[HNAE3_LOOP_PHY];
> >> +            ethtool_puts(data, str);
> >>           }
> >>       }
> >>   }
> >> diff --git
> >> a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> >> b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> >> index 094a7c7b5592..2f6ffb88e700 100644
> >> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> >> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> >> @@ -130,12 +130,10 @@ static int hclgevf_get_sset_count(struct
> >> hnae3_handle *handle, int strset)
> >>   }
> >>     static void hclgevf_get_strings(struct hnae3_handle *handle, u32
> >> strset,
> >> -                u8 *data)
> >> +                u8 **data)
> >>   {
> >> -    u8 *p =3D (char *)data;
> >> -
> >>       if (strset =3D=3D ETH_SS_STATS)
> >> -        p =3D hclge_comm_tqps_get_strings(handle, p);
> >> +        hclge_comm_tqps_get_strings(handle, data);
> >>   }
> >>     static void hclgevf_get_stats(struct hnae3_handle *handle, u64
> >> *data)

