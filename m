Return-Path: <netdev+bounces-186281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF5BA9DE08
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 02:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3137463CB1
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 00:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65410227E98;
	Sun, 27 Apr 2025 00:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S90+7MIK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F46188CB1;
	Sun, 27 Apr 2025 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745713644; cv=none; b=dugQf0G/KFXWlIy/nx+FqRWe9DVdEYqf/4UcdFK+pfsXJE30gfmJ0Qql2Q6vZPBQ5ufB42mgeRGXOPFISHEU9QtnIr2KlhEmRjLRjuisU4I/J1Ky5XH1AxKKTOEZQxPt47jz9sOTN1O0lahr/CfDgdoTW2YoWJJclFsF2Wa9V30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745713644; c=relaxed/simple;
	bh=cfoJPtdaN+0bmtn33dv3eunoIzOKi3Z9Z15hWwcPtmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssXBuPq1Ssfy6RSmEWiW3fRvTerRMwPirRKalqV+l4B9cixRIK8pvbZQDIvoprTkZ1UZ8VqRl7gK2mggOiByX2UxcSxnvIguBitKe5b8+e4Cf2agK8q4povnlrQfQr5Y9QEbdeBMDQyOMeHqUwHOIL+5Gc1sX57XgUWbPSw2IjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S90+7MIK; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d940c7ea71so7031335ab.0;
        Sat, 26 Apr 2025 17:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745713641; x=1746318441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWxfrXrYZOhk3qLM0uWuL6aLXWNg5CtRpcvhLHTklP8=;
        b=S90+7MIK1hYPZ8OB1A342Zk+jqooF3y5kdIwYTPQmAQF/KXQkW/1G0FtH5k0yZKh46
         pI6uWiQgaDAtlPBT6I8SyJfdwRL6IEvuK0tNqZlOdZe9ePVVwVyTUn1y6jyIsRaujWb+
         ddWq71yku+CxoWyKbBe9fsoQ+DHFGdgOLmkmgac7XWoEp2bWFWeiai1xX8WP1CkHtpNF
         u0cFTMcw8VJq4qsffjy3c9fDSvPqIz0FNwpoWsymcBG92OQdfhQHPkXiH89UYqy7RYaa
         hfWSNMZ719wZH8OEwZ//CgV3jwnm2BZXLFHA0zp9v85xXVxReIVmm6UQhZvVcvbQVN1S
         LksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745713641; x=1746318441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWxfrXrYZOhk3qLM0uWuL6aLXWNg5CtRpcvhLHTklP8=;
        b=k9rn7km3iyzfm2cBQ/An8SSNwDvv8WiH8UL8l0U1LUYDbfreIaAxL2Hd+BBMthc3UB
         A7i5sMyUBbhKgMKvKd8nYIj5zvv89YTwFzf0A1YLEIPao9LGOlA9Oah5XdoK9kb6jjCy
         ZJNec4x+BMyTEbwnG3/n9b5XbGoYUI8ZJmRUeNaqdJKcG9qjrEi/hXVn83aHu1NoXx43
         JskvWS5ViOIUj/dTn8JVSSvZbh6iP2O9zFVLTTkcuzuS2r88XosrZk+gkMWIbioNXIau
         SjJFqcamLwKih7t08pHyTQrvD6rCBzfEkKc43UL6+XMZLtT6lPp1NgSI6RW5ESq5erxw
         SwQA==
X-Forwarded-Encrypted: i=1; AJvYcCWXhi5jv9OcWEbC1aQUhAwmWz7x7MIhw+6fUhMtvyFZepF03iBWjGsmfykFzGw5hx2CddZ4kAmEhwJ+TXQ=@vger.kernel.org, AJvYcCWdffAnENVmVQMwuTFDaWNEC7blJYUW88mQggK+yI7/Z9mMhEt+O9WgCEsb4xYJSBGuWPAMoI4o@vger.kernel.org
X-Gm-Message-State: AOJu0YxV+myBBQ0S0eqRju5Ul+LDnQyKQkakZmw8jA7j4T+Emdmt+Ia7
	523jZZ9IHauG6YrqKtsCrULqRig68IP63hnwDEtebXQXKDnbNnRVqx/YBPB3KDigmv6mkC9+fz1
	27PkCPcoEDI2uUui9XjrLPCu9vbU=
X-Gm-Gg: ASbGncsH18AWSfwiL/p0pNNsXBUITu6aFNDEe8qw/MG/baSyLGoOLHJ33FXjgciqpgN
	+d++RLhegpLtjLN7+9wi/ePkFgmifI+Gxj1rhTV8pGIWKa8VYr0moYONNed8s/q/ex80ZCoITnK
	Y9g+lg4pSyTjSF6iqyOOxhH2oiFOSZFy79
X-Google-Smtp-Source: AGHT+IElQXxlDpZsJEfLh2uyZVLQAhnsMdNDrtpR74eunIl/aq1TpDdnIF6V2DkzkTSqVaLz8OKPGjE3TN+1CXemFc8=
X-Received: by 2002:a05:6e02:1c02:b0:3d8:2178:5c63 with SMTP id
 e9e14a558f8ab-3d942d1de40mr44654685ab.4.1745713641447; Sat, 26 Apr 2025
 17:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425-feature_ptp_source-v1-1-c2dfe7b2b8b4@bootlin.com>
In-Reply-To: <20250425-feature_ptp_source-v1-1-c2dfe7b2b8b4@bootlin.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 27 Apr 2025 08:26:45 +0800
X-Gm-Features: ATxdqUGnHUTBtfLEwk5njCEGPYSLReo3u1cF0UpkN528gEenb2IPiMOgWPqunFE
Message-ID: <CAL+tcoAziAJD5b+AMingR4QpTmHLYJCVMCeEsGUeC0TEuRjTHg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: Add support for providing the PTP hardware
 source in tsinfo
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Xing <kernelxing@tencent.com>, 
	Richard Cochran <richardcochran@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kory,

On Sat, Apr 26, 2025 at 1:45=E2=80=AFAM Kory Maincent <kory.maincent@bootli=
n.com> wrote:
>
> Multi-PTP source support within a network topology has been merged,
> but the hardware timestamp source is not yet exposed to users.
> Currently, users only see the PTP index, which does not indicate
> whether the timestamp comes from a PHY or a MAC.

Sorry, may I ask what the use case of distinguishing them is?  When we
get the hw timestamp source, I wonder what the next move could be?

The code itself looks good to me, btw.

Thanks,
Jason

>
> Add support for reporting the hwtstamp source using a
> hwtstamp-source field, alongside hwtstamp-phyindex, to describe
> the origin of the hardware timestamp.
>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> Not sure moving the hwtstamp_source enum to uapi/linux/net_tstamp.h and
> adding this header to ynl/Makefile.deps is the best choice. Maybe it is
> better to move the enum directly to ethtool.h header.
> ---
>  Documentation/netlink/specs/ethtool.yaml       | 16 ++++++++++++++++
>  include/linux/ethtool.h                        |  4 ++++
>  include/linux/net_tstamp.h                     |  6 ------
>  include/uapi/linux/ethtool_netlink_generated.h |  2 ++
>  include/uapi/linux/net_tstamp.h                | 13 +++++++++++++
>  net/ethtool/common.c                           | 22 +++++++++++++++++---=
--
>  net/ethtool/tsinfo.c                           | 20 ++++++++++++++++++++
>  tools/net/ynl/Makefile.deps                    |  3 ++-
>  8 files changed, 74 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/net=
link/specs/ethtool.yaml
> index c650cd3dcb80bc93c5039dc8ba2c5c18793ff987..4bb44c93e80a83b9520ea297c=
08a94616f7266aa 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -98,6 +98,13 @@ definitions:
>      name: tcp-data-split
>      type: enum
>      entries: [ unknown, disabled, enabled ]
> +  -
> +    name: ts-hwtstamp-source
> +    enum-name: hwtstamp-source
> +    header: linux/net_tstamp.h
> +    type: enum
> +    name-prefix: hwtstamp-source
> +    entries: [ unspec, netdev, phylib ]
>
>  attribute-sets:
>    -
> @@ -896,6 +903,13 @@ attribute-sets:
>          name: hwtstamp-provider
>          type: nest
>          nested-attributes: ts-hwtstamp-provider
> +      -
> +        name: hwtstamp-source
> +        type: u32
> +        enum: ts-hwtstamp-source
> +      -
> +        name: hwtstamp-phyindex
> +        type: u32
>    -
>      name: cable-result
>      attr-cnt-name: __ethtool-a-cable-result-cnt
> @@ -1981,6 +1995,8 @@ operations:
>              - phc-index
>              - stats
>              - hwtstamp-provider
> +            - hwtstamp-source
> +            - hwtstamp-phyindex
>        dump: *tsinfo-get-op
>      -
>        name: cable-test-act
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 117718c2481439d09f60cd596012dfa0feef3ca8..f18fc8269f7066eadd6fa823e=
0d43b4ae50b8c46 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -830,6 +830,8 @@ struct ethtool_rxfh_param {
>   * @so_timestamping: bit mask of the sum of the supported SO_TIMESTAMPIN=
G flags
>   * @phc_index: device index of the associated PHC, or -1 if there is non=
e
>   * @phc_qualifier: qualifier of the associated PHC
> + * @phc_source: source device of the associated PHC
> + * @phc_phyindex: index of PHY device source of the associated PHC
>   * @tx_types: bit mask of the supported hwtstamp_tx_types enumeration va=
lues
>   * @rx_filters: bit mask of the supported hwtstamp_rx_filters enumeratio=
n values
>   */
> @@ -838,6 +840,8 @@ struct kernel_ethtool_ts_info {
>         u32 so_timestamping;
>         int phc_index;
>         enum hwtstamp_provider_qualifier phc_qualifier;
> +       enum hwtstamp_source phc_source;
> +       int phc_phyindex;
>         enum hwtstamp_tx_types tx_types;
>         enum hwtstamp_rx_filters rx_filters;
>  };
> diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
> index ff0758e88ea1008efe533cde003b12719bf4fcd3..1414aed0b6adeae15b56e7a99=
a7d9eeb43ba0b6c 100644
> --- a/include/linux/net_tstamp.h
> +++ b/include/linux/net_tstamp.h
> @@ -13,12 +13,6 @@
>                                          SOF_TIMESTAMPING_TX_HARDWARE | \
>                                          SOF_TIMESTAMPING_RAW_HARDWARE)
>
> -enum hwtstamp_source {
> -       HWTSTAMP_SOURCE_UNSPEC,
> -       HWTSTAMP_SOURCE_NETDEV,
> -       HWTSTAMP_SOURCE_PHYLIB,
> -};
> -
>  /**
>   * struct hwtstamp_provider_desc - hwtstamp provider description
>   *
> diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uap=
i/linux/ethtool_netlink_generated.h
> index 30c8dad6214e9a882f1707e4835e9efc73c3f92e..7cbcf44d0a3284490006961d3=
513c58ccda98038 100644
> --- a/include/uapi/linux/ethtool_netlink_generated.h
> +++ b/include/uapi/linux/ethtool_netlink_generated.h
> @@ -401,6 +401,8 @@ enum {
>         ETHTOOL_A_TSINFO_PHC_INDEX,
>         ETHTOOL_A_TSINFO_STATS,
>         ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER,
> +       ETHTOOL_A_TSINFO_HWTSTAMP_SOURCE,
> +       ETHTOOL_A_TSINFO_HWTSTAMP_PHYINDEX,
>
>         __ETHTOOL_A_TSINFO_CNT,
>         ETHTOOL_A_TSINFO_MAX =3D (__ETHTOOL_A_TSINFO_CNT - 1)
> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tst=
amp.h
> index a93e6ea37fb3a69f331b1c90851d4e68cb659a83..bf5fb9f7acf5c03aaa121e0cd=
a3c0b1d83e49f71 100644
> --- a/include/uapi/linux/net_tstamp.h
> +++ b/include/uapi/linux/net_tstamp.h
> @@ -13,6 +13,19 @@
>  #include <linux/types.h>
>  #include <linux/socket.h>   /* for SO_TIMESTAMPING */
>
> +/**
> + * enum hwtstamp_source - Source of the hardware timestamp
> + * @HWTSTAMP_SOURCE_UNSPEC: Source not specified or unknown
> + * @HWTSTAMP_SOURCE_NETDEV: Hardware timestamp comes from the net device
> + * @HWTSTAMP_SOURCE_PHYLIB: Hardware timestamp comes from one of the PHY
> + *                         devices of the network topology
> + */
> +enum hwtstamp_source {
> +       HWTSTAMP_SOURCE_UNSPEC,
> +       HWTSTAMP_SOURCE_NETDEV,
> +       HWTSTAMP_SOURCE_PHYLIB,
> +};
> +
>  /*
>   * Possible type of hwtstamp provider. Mainly "precise" the default one
>   * is for IEEE 1588 quality and "approx" is for NICs DMA point.
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 49bea6b45bd5c1951ff1a52a9f30791040044d10..43e62885b46b5c0abc484d266=
1f7cdf8a3e23169 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -920,12 +920,20 @@ int ethtool_get_ts_info_by_phc(struct net_device *d=
ev,
>                 struct phy_device *phy;
>
>                 phy =3D ethtool_phy_get_ts_info_by_phc(dev, info, hwprov_=
desc);
> -               if (IS_ERR(phy))
> +               if (IS_ERR(phy)) {
>                         err =3D PTR_ERR(phy);
> -               else
> -                       err =3D 0;
> +                       goto out;
> +               }
> +
> +               info->phc_source =3D HWTSTAMP_SOURCE_PHYLIB;
> +               info->phc_phyindex =3D phy->phyindex;
> +               err =3D 0;
> +               goto out;
> +       } else {
> +               info->phc_source =3D HWTSTAMP_SOURCE_NETDEV;
>         }
>
> +out:
>         info->so_timestamping |=3D SOF_TIMESTAMPING_RX_SOFTWARE |
>                                  SOF_TIMESTAMPING_SOFTWARE;
>
> @@ -947,10 +955,14 @@ int __ethtool_get_ts_info(struct net_device *dev,
>
>                 ethtool_init_tsinfo(info);
>                 if (phy_is_default_hwtstamp(phydev) &&
> -                   phy_has_tsinfo(phydev))
> +                   phy_has_tsinfo(phydev)) {
>                         err =3D phy_ts_info(phydev, info);
> -               else if (ops->get_ts_info)
> +                       info->phc_source =3D HWTSTAMP_SOURCE_PHYLIB;
> +                       info->phc_phyindex =3D phydev->phyindex;
> +               } else if (ops->get_ts_info) {
>                         err =3D ops->get_ts_info(dev, info);
> +                       info->phc_source =3D HWTSTAMP_SOURCE_NETDEV;
> +               }
>
>                 info->so_timestamping |=3D SOF_TIMESTAMPING_RX_SOFTWARE |
>                                          SOF_TIMESTAMPING_SOFTWARE;
> diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
> index 8130b406ef107f7311cba15c5aafba3ba82bb5a3..62e82f43dba998abd840ea155=
05084e3127b4520 100644
> --- a/net/ethtool/tsinfo.c
> +++ b/net/ethtool/tsinfo.c
> @@ -160,6 +160,12 @@ static int tsinfo_reply_size(const struct ethnl_req_=
info *req_base,
>                 /* _TSINFO_HWTSTAMP_PROVIDER */
>                 len +=3D nla_total_size(0) + 2 * nla_total_size(sizeof(u3=
2));
>         }
> +       if (ts_info->phc_source) {
> +               len +=3D nla_total_size(sizeof(u32));     /* _TSINFO_HWTS=
TAMP_SOURCE */
> +               if (ts_info->phc_phyindex)
> +                       /* _TSINFO_HWTSTAMP_PHYINDEX */
> +                       len +=3D nla_total_size(sizeof(u32));
> +       }
>         if (req_base->flags & ETHTOOL_FLAG_STATS)
>                 len +=3D nla_total_size(0) + /* _TSINFO_STATS */
>                        nla_total_size_64bit(sizeof(u64)) * ETHTOOL_TS_STA=
T_CNT;
> @@ -259,6 +265,16 @@ static int tsinfo_fill_reply(struct sk_buff *skb,
>
>                 nla_nest_end(skb, nest);
>         }
> +       if (ts_info->phc_source) {
> +               if (nla_put_u32(skb, ETHTOOL_A_TSINFO_HWTSTAMP_SOURCE,
> +                               ts_info->phc_source))
> +                       return -EMSGSIZE;
> +
> +               if (ts_info->phc_phyindex &&
> +                   nla_put_u32(skb, ETHTOOL_A_TSINFO_HWTSTAMP_PHYINDEX,
> +                               ts_info->phc_phyindex))
> +                       return -EMSGSIZE;
> +       }
>         if (req_base->flags & ETHTOOL_FLAG_STATS &&
>             tsinfo_put_stats(skb, &data->stats))
>                 return -EMSGSIZE;
> @@ -346,6 +362,9 @@ static int ethnl_tsinfo_dump_one_phydev(struct sk_buf=
f *skb,
>         if (ret < 0)
>                 goto err;
>
> +       reply_data->ts_info.phc_source =3D HWTSTAMP_SOURCE_PHYLIB;
> +       reply_data->ts_info.phc_phyindex =3D phydev->phyindex;
> +
>         ret =3D ethnl_tsinfo_end_dump(skb, dev, req_info, reply_data, ehd=
r);
>         if (ret < 0)
>                 goto err;
> @@ -389,6 +408,7 @@ static int ethnl_tsinfo_dump_one_netdev(struct sk_buf=
f *skb,
>                 if (ret < 0)
>                         goto err;
>
> +               reply_data->ts_info.phc_source =3D HWTSTAMP_SOURCE_NETDEV=
;
>                 ret =3D ethnl_tsinfo_end_dump(skb, dev, req_info, reply_d=
ata,
>                                             ehdr);
>                 if (ret < 0)
> diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
> index 8b7bf673b686f17db06a3798d23d2350f7cf76c1..6c03b477f672eab80e2c71452=
c982b9561cb7c4a 100644
> --- a/tools/net/ynl/Makefile.deps
> +++ b/tools/net/ynl/Makefile.deps
> @@ -18,7 +18,8 @@ CFLAGS_devlink:=3D$(call get_hdr_inc,_LINUX_DEVLINK_H_,=
devlink.h)
>  CFLAGS_dpll:=3D$(call get_hdr_inc,_LINUX_DPLL_H,dpll.h)
>  CFLAGS_ethtool:=3D$(call get_hdr_inc,_LINUX_ETHTOOL_H,ethtool.h) \
>         $(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h) \
> -       $(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_GENERATED_H,ethtool_net=
link_generated.h)
> +       $(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_GENERATED_H,ethtool_net=
link_generated.h) \
> +       $(call get_hdr_inc,_NET_TIMESTAMPING_H,net_tstamp.h)
>  CFLAGS_handshake:=3D$(call get_hdr_inc,_LINUX_HANDSHAKE_H,handshake.h)
>  CFLAGS_lockd_netlink:=3D$(call get_hdr_inc,_LINUX_LOCKD_NETLINK_H,lockd_=
netlink.h)
>  CFLAGS_mptcp_pm:=3D$(call get_hdr_inc,_LINUX_MPTCP_PM_H,mptcp_pm.h)
>
> ---
> base-commit: 3a726f8feac35d9b9ee11cf9737d62fe2410d539
> change-id: 20250418-feature_ptp_source-df4a98c94139
>
> Best regards,
> --
> K=C3=B6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
>
>

