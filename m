Return-Path: <netdev+bounces-127049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F397E973D83
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238EA1C2524B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476E114F12C;
	Tue, 10 Sep 2024 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tZLss05C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0D613A3E8
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725986481; cv=none; b=qplOqqCW4uOaxy1oGjMpo3JffAkkyW1IesNvjYuSysvjk88JYZ3K3DOJezRUtYmPoL8gxpiQY1PpYyxJVBZM8mAVOdv0c3R0wYyL4wZyg0s9kUIq+fuSE3kvv4pj+n/75taAw5m3sfiVpK0gf/qLKhLKzU6qIREkA5E5ahZBO0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725986481; c=relaxed/simple;
	bh=+MS6ncxt0cHJtyoorOgsH3LbEwEYBX9qMhqvmTXjx0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gh0IT2CIn/1kebgWS3BoyJarDrGtkS74YC0tmuKExGcnQQ1pprlFLsOQGbzyI2CZBb1TWrPazyA2K9VZ4UMQ1v9bbqlAYZtjTYX/WX3YJWyJEbBqKQoU44Ga0wuCGl3Y4qiRBi6+3P2X9B8cisdN6W3MTcz3BosESyKZan/dUkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tZLss05C; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so33937095e9.1
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 09:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725986477; x=1726591277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zE2be6BQD0lfHhEXL8FfLhHCYji8KerjxVH0W5gvkhQ=;
        b=tZLss05CmvFdE8nT/CRzlnPxdR61+EU+nJezSB+Nq8MpMl0FRF8BaMaTeWiNgn+AP6
         3Yt3QbE/TwqXc43/DNP0Guf2V5NEVw3PvzmbuOPNxIyluKmfA5WnpKcO517qWo3jjrT8
         ZuWLwtybca4F/U0dZksfMXeJ/b1Un4vPXwFWy2Zbq7fwBnX4PXJjfy+mXcLqaU14oqbt
         9FZXj7Z9pYvaxsP43jB0LZXoJwUc/c/EEP2E0Tl95s/ar5r4oszD51r4HWniLHXGzOyA
         QondXS4faUhKD4SRzrojcO2ivwatF7DooyXPa2OdqyAtRSKGVxIC7P9cp0pJkP8CMu6b
         Z5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725986477; x=1726591277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zE2be6BQD0lfHhEXL8FfLhHCYji8KerjxVH0W5gvkhQ=;
        b=FMxsfSPfwh46O11AaHPBUWk47dXz1otctcc07/I97BJFwokzMHE0Sup/Oyi4mB/Y8q
         ERMORWDXQRybVCFUU0RqTj2M5r6SK5THd6o6s3Gk+/DySH5kYAh2iUJCZIMRITerrJIU
         MDbniKLTgwkNCKBk9HMskgdsXHKARKt0WhE/nAzjS9Ppm1E9Fy+18KBIeOuQsILsyxKb
         wkYlGxp2E/yY6YDzKYEWWRevDC7Aw9BrWBQrDJYYiNK42GT9iKjqVTHOXImZrc9cVPMC
         O+tgudlWswIty4L4SVpE5qx9oJKvfOhX1YmtbWjEo48qKVR7BBur1ntfvATH4+lBCvOc
         dNfA==
X-Forwarded-Encrypted: i=1; AJvYcCV8BjIEkotDwLbUE5KhH/8vYhDq4mzccqhbEkyXMjaG/wD5/Tlzm4l+vU4SylO4mxymy7SA9fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR7Ry2ZzXjy1v4YHPdmpWLaHQ+E46p/vvNRmrmUpDVQn8fmn0H
	nYcZ/o9lF4Lg5ZzM9xpO9nGgpZPH/WQCd8HnET0Fmr6lys44w985VnOQ4mNCeVWBUopQlOVvXg1
	CX+pLgtm7XV6oq2l4ZqcTiJFshFrETINCQKAY
X-Google-Smtp-Source: AGHT+IF25XKyZvPc0D10ndKd+ZNubD7YkjXpOcwTJtvwENAl5iYURvYdof5Ebt0adOxlZ1Wb9qySIN7DY3X7pfzDN20=
X-Received: by 2002:a5d:54ca:0:b0:376:5234:403f with SMTP id
 ffacd0b85a97d-3788954e720mr9577783f8f.0.1725986476380; Tue, 10 Sep 2024
 09:41:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821151009.1681151-1-maxime.chevallier@bootlin.com> <20240821151009.1681151-8-maxime.chevallier@bootlin.com>
In-Reply-To: <20240821151009.1681151-8-maxime.chevallier@bootlin.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Sep 2024 18:41:03 +0200
Message-ID: <CANn89iLQYsyADrdW04PpuxEdAEhBkVQm+uVV8=CDmX_Fswdvrw@mail.gmail.com>
Subject: Re: [PATCH net-next v18 07/13] net: ethtool: Introduce a command to
 list PHYs on an interface
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	=?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>, 
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org, 
	Nathan Chancellor <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Romain Gantois <romain.gantois@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 5:10=E2=80=AFPM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> As we have the ability to track the PHYs connected to a net_device
> through the link_topology, we can expose this list to userspace. This
> allows userspace to use these identifiers for phy-specific commands and
> take the decision of which PHY to target by knowing the link topology.
>
> Add PHY_GET and PHY_DUMP, which can be a filtered DUMP operation to list
> devices on only one interface.
>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  Documentation/networking/ethtool-netlink.rst |  41 +++
>  include/uapi/linux/ethtool_netlink.h         |  19 ++
>  net/ethtool/Makefile                         |   3 +-
>  net/ethtool/netlink.c                        |   9 +
>  net/ethtool/netlink.h                        |   5 +
>  net/ethtool/phy.c                            | 308 +++++++++++++++++++
>  6 files changed, 384 insertions(+), 1 deletion(-)
>  create mode 100644 net/ethtool/phy.c
>
> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation=
/networking/ethtool-netlink.rst
> index 2d14b8551348..8c152871c23c 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -2191,6 +2191,46 @@ string.
>  The ``ETHTOOL_A_MODULE_FW_FLASH_DONE`` and ``ETHTOOL_A_MODULE_FW_FLASH_T=
OTAL``
>  attributes encode the completed and total amount of work, respectively.
>
> +PHY_GET
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +Retrieve information about a given Ethernet PHY sitting on the link. The=
 DO
> +operation returns all available information about dev->phydev. User can =
also
> +specify a PHY_INDEX, in which case the DO request returns information ab=
out that
> +specific PHY.
> +As there can be more than one PHY, the DUMP operation can be used to lis=
t the PHYs
> +present on a given interface, by passing an interface index or name in
> +the dump request.
> +
> +Request contents:
> +
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  ``ETHTOOL_A_PHY_HEADER``              nested  request header
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Kernel response contents:
> +
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +  ``ETHTOOL_A_PHY_HEADER``              nested  request header
> +  ``ETHTOOL_A_PHY_INDEX``               u32     the phy's unique index, =
that can
> +                                                be used for phy-specific
> +                                                requests
> +  ``ETHTOOL_A_PHY_DRVNAME``             string  the phy driver name
> +  ``ETHTOOL_A_PHY_NAME``                string  the phy device name
> +  ``ETHTOOL_A_PHY_UPSTREAM_TYPE``       u32     the type of device this =
phy is
> +                                                connected to
> +  ``ETHTOOL_A_PHY_UPSTREAM_INDEX``      u32     the PHY index of the ups=
tream
> +                                                PHY
> +  ``ETHTOOL_A_PHY_UPSTREAM_SFP_NAME``   string  if this PHY is connected=
 to
> +                                                its parent PHY through a=
n SFP
> +                                                bus, the name of this sf=
p bus
> +  ``ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME`` string  if the phy controls an s=
fp bus,
> +                                                the name of the sfp bus
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +When ``ETHTOOL_A_PHY_UPSTREAM_TYPE`` is PHY_UPSTREAM_PHY, the PHY's pare=
nt is
> +another PHY.
> +
>  Request translation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> @@ -2298,4 +2338,5 @@ are netlink only.
>    n/a                                 ``ETHTOOL_MSG_MM_GET``
>    n/a                                 ``ETHTOOL_MSG_MM_SET``
>    n/a                                 ``ETHTOOL_MSG_MODULE_FW_FLASH_ACT`=
`
> +  n/a                                 ``ETHTOOL_MSG_PHY_GET``
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/et=
htool_netlink.h
> index 49d1f9220fde..45d8bcdea056 100644
> --- a/include/uapi/linux/ethtool_netlink.h
> +++ b/include/uapi/linux/ethtool_netlink.h
> @@ -58,6 +58,7 @@ enum {
>         ETHTOOL_MSG_MM_GET,
>         ETHTOOL_MSG_MM_SET,
>         ETHTOOL_MSG_MODULE_FW_FLASH_ACT,
> +       ETHTOOL_MSG_PHY_GET,
>
>         /* add new constants above here */
>         __ETHTOOL_MSG_USER_CNT,
> @@ -111,6 +112,8 @@ enum {
>         ETHTOOL_MSG_MM_GET_REPLY,
>         ETHTOOL_MSG_MM_NTF,
>         ETHTOOL_MSG_MODULE_FW_FLASH_NTF,
> +       ETHTOOL_MSG_PHY_GET_REPLY,
> +       ETHTOOL_MSG_PHY_NTF,
>
>         /* add new constants above here */
>         __ETHTOOL_MSG_KERNEL_CNT,
> @@ -1055,6 +1058,22 @@ enum {
>         ETHTOOL_A_MODULE_FW_FLASH_MAX =3D (__ETHTOOL_A_MODULE_FW_FLASH_CN=
T - 1)
>  };
>
> +enum {
> +       ETHTOOL_A_PHY_UNSPEC,
> +       ETHTOOL_A_PHY_HEADER,                   /* nest - _A_HEADER_* */
> +       ETHTOOL_A_PHY_INDEX,                    /* u32 */
> +       ETHTOOL_A_PHY_DRVNAME,                  /* string */
> +       ETHTOOL_A_PHY_NAME,                     /* string */
> +       ETHTOOL_A_PHY_UPSTREAM_TYPE,            /* u32 */
> +       ETHTOOL_A_PHY_UPSTREAM_INDEX,           /* u32 */
> +       ETHTOOL_A_PHY_UPSTREAM_SFP_NAME,        /* string */
> +       ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME,      /* string */
> +
> +       /* add new constants above here */
> +       __ETHTOOL_A_PHY_CNT,
> +       ETHTOOL_A_PHY_MAX =3D (__ETHTOOL_A_PHY_CNT - 1)
> +};
> +
>  /* generic netlink info */
>  #define ETHTOOL_GENL_NAME "ethtool"
>  #define ETHTOOL_GENL_VERSION 1
> diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
> index 9a190635fe95..9b540644ba31 100644
> --- a/net/ethtool/Makefile
> +++ b/net/ethtool/Makefile
> @@ -8,4 +8,5 @@ ethtool_nl-y    :=3D netlink.o bitset.o strset.o linkinfo=
.o linkmodes.o rss.o \
>                    linkstate.o debug.o wol.o features.o privflags.o rings=
.o \
>                    channels.o coalesce.o pause.o eee.o tsinfo.o cabletest=
.o \
>                    tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
> -                  module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o m=
m.o
> +                  module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o m=
m.o \
> +                  phy.o
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index b00061924e80..e3f0ef6b851b 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -1234,6 +1234,15 @@ static const struct genl_ops ethtool_genl_ops[] =
=3D {
>                 .policy =3D ethnl_module_fw_flash_act_policy,
>                 .maxattr =3D ARRAY_SIZE(ethnl_module_fw_flash_act_policy)=
 - 1,
>         },
> +       {
> +               .cmd    =3D ETHTOOL_MSG_PHY_GET,
> +               .doit   =3D ethnl_phy_doit,
> +               .start  =3D ethnl_phy_start,
> +               .dumpit =3D ethnl_phy_dumpit,
> +               .done   =3D ethnl_phy_done,
> +               .policy =3D ethnl_phy_get_policy,
> +               .maxattr =3D ARRAY_SIZE(ethnl_phy_get_policy) - 1,
> +       },
>  };
>
>  static const struct genl_multicast_group ethtool_nl_mcgrps[] =3D {
> diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
> index e326699405be..203b08eb6c6f 100644
> --- a/net/ethtool/netlink.h
> +++ b/net/ethtool/netlink.h
> @@ -484,6 +484,7 @@ extern const struct nla_policy ethnl_plca_get_status_=
policy[ETHTOOL_A_PLCA_HEADE
>  extern const struct nla_policy ethnl_mm_get_policy[ETHTOOL_A_MM_HEADER +=
 1];
>  extern const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1]=
;
>  extern const struct nla_policy ethnl_module_fw_flash_act_policy[ETHTOOL_=
A_MODULE_FW_FLASH_PASSWORD + 1];
> +extern const struct nla_policy ethnl_phy_get_policy[ETHTOOL_A_PHY_HEADER=
 + 1];
>
>  int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
>  int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
> @@ -494,6 +495,10 @@ int ethnl_tunnel_info_dumpit(struct sk_buff *skb, st=
ruct netlink_callback *cb);
>  int ethnl_act_module_fw_flash(struct sk_buff *skb, struct genl_info *inf=
o);
>  int ethnl_rss_dump_start(struct netlink_callback *cb);
>  int ethnl_rss_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
> +int ethnl_phy_start(struct netlink_callback *cb);
> +int ethnl_phy_doit(struct sk_buff *skb, struct genl_info *info);
> +int ethnl_phy_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
> +int ethnl_phy_done(struct netlink_callback *cb);
>
>  extern const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN];
>  extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH=
_GSTRING_LEN];
> diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
> new file mode 100644
> index 000000000000..560dd039c662
> --- /dev/null
> +++ b/net/ethtool/phy.c
> @@ -0,0 +1,308 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2023 Bootlin
> + *
> + */
> +#include "common.h"
> +#include "netlink.h"
> +
> +#include <linux/phy.h>
> +#include <linux/phy_link_topology.h>
> +#include <linux/sfp.h>
> +
> +struct phy_req_info {
> +       struct ethnl_req_info           base;
> +       struct phy_device_node          *pdn;
> +};
> +
> +#define PHY_REQINFO(__req_base) \
> +       container_of(__req_base, struct phy_req_info, base)
> +
> +const struct nla_policy ethnl_phy_get_policy[ETHTOOL_A_PHY_HEADER + 1] =
=3D {
> +       [ETHTOOL_A_PHY_HEADER] =3D NLA_POLICY_NESTED(ethnl_header_policy)=
,
> +};
> +
> +/* Caller holds rtnl */
> +static ssize_t
> +ethnl_phy_reply_size(const struct ethnl_req_info *req_base,
> +                    struct netlink_ext_ack *extack)
> +{
> +       struct phy_req_info *req_info =3D PHY_REQINFO(req_base);
> +       struct phy_device_node *pdn =3D req_info->pdn;
> +       struct phy_device *phydev =3D pdn->phy;
> +       size_t size =3D 0;
> +
> +       ASSERT_RTNL();
> +
> +       /* ETHTOOL_A_PHY_INDEX */
> +       size +=3D nla_total_size(sizeof(u32));
> +
> +       /* ETHTOOL_A_DRVNAME */
> +       if (phydev->drv)
> +               size +=3D nla_total_size(strlen(phydev->drv->name) + 1);
> +
> +       /* ETHTOOL_A_NAME */
> +       size +=3D nla_total_size(strlen(dev_name(&phydev->mdio.dev)) + 1)=
;
> +
> +       /* ETHTOOL_A_PHY_UPSTREAM_TYPE */
> +       size +=3D nla_total_size(sizeof(u32));
> +
> +       if (phy_on_sfp(phydev)) {
> +               const char *upstream_sfp_name =3D sfp_get_name(pdn->paren=
t_sfp_bus);
> +
> +               /* ETHTOOL_A_PHY_UPSTREAM_SFP_NAME */
> +               if (upstream_sfp_name)
> +                       size +=3D nla_total_size(strlen(upstream_sfp_name=
) + 1);
> +
> +               /* ETHTOOL_A_PHY_UPSTREAM_INDEX */
> +               size +=3D nla_total_size(sizeof(u32));
> +       }
> +
> +       /* ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME */
> +       if (phydev->sfp_bus) {
> +               const char *sfp_name =3D sfp_get_name(phydev->sfp_bus);
> +
> +               if (sfp_name)
> +                       size +=3D nla_total_size(strlen(sfp_name) + 1);
> +       }
> +
> +       return size;
> +}
> +
> +static int
> +ethnl_phy_fill_reply(const struct ethnl_req_info *req_base, struct sk_bu=
ff *skb)
> +{
> +       struct phy_req_info *req_info =3D PHY_REQINFO(req_base);
> +       struct phy_device_node *pdn =3D req_info->pdn;
> +       struct phy_device *phydev =3D pdn->phy;
> +       enum phy_upstream ptype;
> +
> +       ptype =3D pdn->upstream_type;
> +
> +       if (nla_put_u32(skb, ETHTOOL_A_PHY_INDEX, phydev->phyindex) ||
> +           nla_put_string(skb, ETHTOOL_A_PHY_NAME, dev_name(&phydev->mdi=
o.dev)) ||
> +           nla_put_u32(skb, ETHTOOL_A_PHY_UPSTREAM_TYPE, ptype))
> +               return -EMSGSIZE;
> +
> +       if (phydev->drv &&
> +           nla_put_string(skb, ETHTOOL_A_PHY_DRVNAME, phydev->drv->name)=
)
> +               return -EMSGSIZE;
> +
> +       if (ptype =3D=3D PHY_UPSTREAM_PHY) {
> +               struct phy_device *upstream =3D pdn->upstream.phydev;
> +               const char *sfp_upstream_name;
> +
> +               /* Parent index */
> +               if (nla_put_u32(skb, ETHTOOL_A_PHY_UPSTREAM_INDEX, upstre=
am->phyindex))
> +                       return -EMSGSIZE;
> +
> +               if (pdn->parent_sfp_bus) {
> +                       sfp_upstream_name =3D sfp_get_name(pdn->parent_sf=
p_bus);
> +                       if (sfp_upstream_name &&
> +                           nla_put_string(skb, ETHTOOL_A_PHY_UPSTREAM_SF=
P_NAME,
> +                                          sfp_upstream_name))
> +                               return -EMSGSIZE;
> +               }
> +       }
> +
> +       if (phydev->sfp_bus) {
> +               const char *sfp_name =3D sfp_get_name(phydev->sfp_bus);
> +
> +               if (sfp_name &&
> +                   nla_put_string(skb, ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME=
,
> +                                  sfp_name))
> +                       return -EMSGSIZE;
> +       }
> +
> +       return 0;
> +}
> +
> +static int ethnl_phy_parse_request(struct ethnl_req_info *req_base,
> +                                  struct nlattr **tb,
> +                                  struct netlink_ext_ack *extack)
> +{
> +       struct phy_link_topology *topo =3D req_base->dev->link_topo;
> +       struct phy_req_info *req_info =3D PHY_REQINFO(req_base);
> +       struct phy_device *phydev;
> +
> +       phydev =3D ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PHY_HEADER=
],
> +                                     extack);
> +       if (!phydev)
> +               return 0;
> +
> +       if (IS_ERR(phydev))
> +               return PTR_ERR(phydev);
> +
> +       if (!topo)
> +               return 0;
> +
> +       req_info->pdn =3D xa_load(&topo->phys, phydev->phyindex);
> +
> +       return 0;
> +}
> +
> +int ethnl_phy_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +       struct phy_req_info req_info =3D {};
> +       struct nlattr **tb =3D info->attrs;
> +       struct sk_buff *rskb;
> +       void *reply_payload;
> +       int reply_len;
> +       int ret;
> +
> +       ret =3D ethnl_parse_header_dev_get(&req_info.base,
> +                                        tb[ETHTOOL_A_PHY_HEADER],
> +                                        genl_info_net(info), info->extac=
k,
> +                                        true);
> +       if (ret < 0)
> +               return ret;
> +
> +       rtnl_lock();
> +
> +       ret =3D ethnl_phy_parse_request(&req_info.base, tb, info->extack)=
;
> +       if (ret < 0)
> +               goto err_unlock_rtnl;
> +
> +       /* No PHY, return early */

I got a syzbot report here.

Should we fix this with :

diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index 560dd039c6625ac0925a0f28c14ce77cf768b6a5..4ef7c6e32d1087dc71acb467f9c=
d2ab8faf4dc39
100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -164,7 +164,7 @@ int ethnl_phy_doit(struct sk_buff *skb, struct
genl_info *info)
                goto err_unlock_rtnl;

        /* No PHY, return early */
-       if (!req_info.pdn->phy)
+       if (!req_info.pdn)
                goto err_unlock_rtnl;

        ret =3D ethnl_phy_reply_size(&req_info.base, info->extack);


> +       if (!req_info.pdn->phy)
> +               goto err_unlock_rtnl;
> +
> +       ret =3D ethnl_phy_reply_size(&req_info.base, info->extack);
> +       if (ret < 0)
> +               goto err_unlock_rtnl;
> +       reply_len =3D ret + ethnl_reply_header_size();
> +
> +       rskb =3D ethnl_reply_init(reply_len, req_info.base.dev,
> +                               ETHTOOL_MSG_PHY_GET_REPLY,
> +                               ETHTOOL_A_PHY_HEADER,
> +                               info, &reply_payload);
> +       if (!rskb) {
> +               ret =3D -ENOMEM;
> +               goto err_unlock_rtnl;
> +       }
> +
> +       ret =3D ethnl_phy_fill_reply(&req_info.base, rskb);
> +       if (ret)
> +               goto err_free_msg;
> +
> +       rtnl_unlock();
> +       ethnl_parse_header_dev_put(&req_info.base);
> +       genlmsg_end(rskb, reply_payload);
> +
> +       return genlmsg_reply(rskb, info);
> +
> +err_free_msg:
> +       nlmsg_free(rskb);
> +err_unlock_rtnl:
> +       rtnl_unlock();
> +       ethnl_parse_header_dev_put(&req_info.base);
> +       return ret;
> +}
> +
> +struct ethnl_phy_dump_ctx {
> +       struct phy_req_info     *phy_req_info;
> +       unsigned long ifindex;
> +       unsigned long phy_index;
> +};
> +
> +int ethnl_phy_start(struct netlink_callback *cb)
> +{
> +       const struct genl_info *info =3D genl_info_dump(cb);
> +       struct ethnl_phy_dump_ctx *ctx =3D (void *)cb->ctx;
> +       int ret;
> +
> +       BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
> +
> +       ctx->phy_req_info =3D kzalloc(sizeof(*ctx->phy_req_info), GFP_KER=
NEL);
> +       if (!ctx->phy_req_info)
> +               return -ENOMEM;
> +
> +       ret =3D ethnl_parse_header_dev_get(&ctx->phy_req_info->base,
> +                                        info->attrs[ETHTOOL_A_PHY_HEADER=
],
> +                                        sock_net(cb->skb->sk), cb->extac=
k,
> +                                        false);
> +       ctx->ifindex =3D 0;
> +       ctx->phy_index =3D 0;
> +
> +       if (ret)
> +               kfree(ctx->phy_req_info);
> +
> +       return ret;
> +}
> +
> +int ethnl_phy_done(struct netlink_callback *cb)
> +{
> +       struct ethnl_phy_dump_ctx *ctx =3D (void *)cb->ctx;
> +
> +       if (ctx->phy_req_info->base.dev)
> +               ethnl_parse_header_dev_put(&ctx->phy_req_info->base);
> +
> +       kfree(ctx->phy_req_info);
> +
> +       return 0;
> +}
> +
> +static int ethnl_phy_dump_one_dev(struct sk_buff *skb, struct net_device=
 *dev,
> +                                 struct netlink_callback *cb)
> +{
> +       struct ethnl_phy_dump_ctx *ctx =3D (void *)cb->ctx;
> +       struct phy_req_info *pri =3D ctx->phy_req_info;
> +       struct phy_device_node *pdn;
> +       int ret =3D 0;
> +       void *ehdr;
> +
> +       pri->base.dev =3D dev;
> +
> +       if (!dev->link_topo)
> +               return 0;
> +
> +       xa_for_each_start(&dev->link_topo->phys, ctx->phy_index, pdn, ctx=
->phy_index) {
> +               ehdr =3D ethnl_dump_put(skb, cb, ETHTOOL_MSG_PHY_GET_REPL=
Y);
> +               if (!ehdr) {
> +                       ret =3D -EMSGSIZE;
> +                       break;
> +               }
> +
> +               ret =3D ethnl_fill_reply_header(skb, dev, ETHTOOL_A_PHY_H=
EADER);
> +               if (ret < 0) {
> +                       genlmsg_cancel(skb, ehdr);
> +                       break;
> +               }
> +
> +               pri->pdn =3D pdn;
> +               ret =3D ethnl_phy_fill_reply(&pri->base, skb);
> +               if (ret < 0) {
> +                       genlmsg_cancel(skb, ehdr);
> +                       break;
> +               }
> +
> +               genlmsg_end(skb, ehdr);
> +       }
> +
> +       return ret;
> +}
> +
> +int ethnl_phy_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +       struct ethnl_phy_dump_ctx *ctx =3D (void *)cb->ctx;
> +       struct net *net =3D sock_net(skb->sk);
> +       struct net_device *dev;
> +       int ret =3D 0;
> +
> +       rtnl_lock();
> +
> +       if (ctx->phy_req_info->base.dev) {
> +               ret =3D ethnl_phy_dump_one_dev(skb, ctx->phy_req_info->ba=
se.dev, cb);
> +       } else {
> +               for_each_netdev_dump(net, dev, ctx->ifindex) {
> +                       ret =3D ethnl_phy_dump_one_dev(skb, dev, cb);
> +                       if (ret)
> +                               break;
> +
> +                       ctx->phy_index =3D 0;
> +               }
> +       }
> +       rtnl_unlock();
> +
> +       return ret;
> +}
> --
> 2.45.2
>

