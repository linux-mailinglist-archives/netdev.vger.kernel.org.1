Return-Path: <netdev+bounces-126874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EDC972C05
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C7E287D58
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55330184555;
	Tue, 10 Sep 2024 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PMYQegIF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2A214F9D4
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956454; cv=none; b=X/xoq+5jFxT0sNow76/K/0TgSdhrl+iIyP1ChXFrrRC7pKMCCG/mlI+VqOdM8TzDoGbSj48pb8ANZuwBVS7qHhWdMATEyhng/A5NI3LQ5C77EhRMPboaIN8BjtyDm+9bJClj3J50B/3VlrNSFkMXLXejB/7ngFOQA+0GTWig5X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956454; c=relaxed/simple;
	bh=XT1jJ3Oli1iIT8X3y7YTTWNXVRxqLxROua77ZVnvzGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdxKu9xebhRQ5S7BSOZzAgIuI/T/TegEwFZ3Plpd4kmUmeKXOF1ID5+ahKGQm33vS7DEJeQYN3NGdJdPAWWAiCPfZNaqbXFHbwYfBOrrVf0sFpZJWMro438kEAdYsJ4PQ6E3bM//ZTr8/Y7ODHMCno5GtYpUB9BPItf/DwqzNJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PMYQegIF; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5356bb55224so6084208e87.0
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725956450; x=1726561250; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y+PdYgdaRQoCkmwguXoTQgEQ6QEvefOUgiNLLC1gctI=;
        b=PMYQegIF5KW4+W4CpRx4yHRndeAPWbXNhGNFdh3gLdJz4k8PbVWEhmkywzOIR+HaT/
         7F+WeUYy1azm5pP3zw4zlzTlPR4dySZrpZo8yFR3+GmFO5Oww5s06m16w4NN4aqt0GMX
         +iJr4wKq0/iKESvSXazAR6RlgR79sAX4czVTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725956450; x=1726561250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+PdYgdaRQoCkmwguXoTQgEQ6QEvefOUgiNLLC1gctI=;
        b=jUcwbZVNM0GShJ1GVa534yI/gPGZftHC2n+bk4cisKFKKP0c00XUg7R7SI/UlWGbho
         oxEkSkYJSghaVc5X3HRSlBwiGLIIoIfPTD6uv2Vs56aPkU/ChBidRFhCwPgIm5Pd1CEO
         HFPUyMYQyd5cjmAu+jEvkYg501oDoVNxQzafgYxw+oKHNv47/Wl07mx0G+aerFTZ6KUS
         EJQoLsoDo7oYt0Cp+bAkZ/UyD8Gk+yHb99kH36AL7u7yYop3zY7o71TF8tejixmfHtj4
         odnSVdcvTg9F7e2AgXke7wp0xFCU442p64+hDHqa7VoXUwLlW1u23atFTbNUGtBBcjw3
         KbwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+it1YO2NbVT468SZehPW37BQWMOxItlwNZ7wltXzxqkItOYa7PEHWitHl4ONF7hmg81ApwMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1OlIbm6fX4DlUm+i2Mn1gtWDo/8UO8QNVArej+vubbUTHDAPK
	tN2QriIc2EM6LsKNOt7RrfGNK9ZhlNcWJJo/jLzQtnXIIZ8hc/wxOWC0p6qRcuY1XA4R1Ed7IZf
	xf6yX9nXdJmP/Wm0Y2qg/dWhfzKM7jeTDWp/R
X-Google-Smtp-Source: AGHT+IHzUJEsJR/Hzu2YpA/yazwCJSI2GcA1XZM8BIK9yNrF5gv59afppn6SlrrC0cK+JghP0kGxXzX5RknughfZELw=
X-Received: by 2002:a05:6512:3ba5:b0:533:4785:82a0 with SMTP id
 2adb3069b0e04-536587a42eemr7909798e87.2.1725956449176; Tue, 10 Sep 2024
 01:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910075942.1270054-1-shaojijie@huawei.com> <20240910075942.1270054-6-shaojijie@huawei.com>
In-Reply-To: <20240910075942.1270054-6-shaojijie@huawei.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 10 Sep 2024 13:50:36 +0530
Message-ID: <CAH-L+nMPOyhkjt530-L9EvAAQ87nBJ7RdShgHJ+VOC4fpvLXoA@mail.gmail.com>
Subject: Re: [PATCH V9 net-next 05/11] net: hibmcge: Implement some .ndo functions
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shenjian15@huawei.com, wangpeiyang1@huawei.com, 
	liuyonglong@huawei.com, chenhao418@huawei.com, sudongming1@huawei.com, 
	xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com, 
	andrew@lunn.ch, jdamato@fastly.com, horms@kernel.org, 
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com, 
	salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000020b0b80621bf8de5"

--00000000000020b0b80621bf8de5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Jijie for taking care of the comments. One comment in line
though it is not directly related to your changes.

On Tue, Sep 10, 2024 at 1:36=E2=80=AFPM Jijie Shao <shaojijie@huawei.com> w=
rote:
>
> Implement the .ndo_open() .ndo_stop() .ndo_set_mac_address()
> .ndo_change_mtu functions() and ndo.get_stats64()
> And .ndo_validate_addr calls the eth_validate_addr function directly
>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
> ChangeLog:
> v8 -> v9:
>   - Remove HBG_NIC_STATE_OPEN in ndo.open() and ndo.stop(),
>     suggested by Kalesh and Andrew.
>   - Use netif_running() instead of hbg_nic_is_open() in ndo.change_mtu(),
>     suggested by Kalesh and Andrew
>   v8: https://lore.kernel.org/all/20240909023141.3234567-1-shaojijie@huaw=
ei.com/
> v6 -> v7:
>   - Add implement ndo.get_stats64(), suggested by Paolo.
>   v6: https://lore.kernel.org/all/20240830121604.2250904-6-shaojijie@huaw=
ei.com/
> v5 -> v6:
>   - Delete netif_carrier_off() in .ndo_open() and .ndo_stop(),
>     suggested by Jakub and Andrew.
>  v5: https://lore.kernel.org/all/20240827131455.2919051-1-shaojijie@huawe=
i.com/
> v3 -> v4:
>   - Delete INITED_STATE in priv, suggested by Andrew.
>   - Delete unnecessary defensive code in hbg_phy_start()
>     and hbg_phy_stop(), suggested by Andrew.
>   v3: https://lore.kernel.org/all/20240822093334.1687011-1-shaojijie@huaw=
ei.com/
> RFC v1 -> RFC v2:
>   - Delete validation for mtu in hbg_net_change_mtu(), suggested by Andre=
w.
>   - Delete validation for mac address in hbg_net_set_mac_address(),
>     suggested by Andrew.
>   - Add a patch to add is_valid_ether_addr check in dev_set_mac_address,
>     suggested by Andrew.
>   RFC v1: https://lore.kernel.org/all/20240731094245.1967834-1-shaojijie@=
huawei.com/
> ---
>  .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   | 39 ++++++++
>  .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |  3 +
>  .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 97 +++++++++++++++++++
>  .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  | 11 ++-
>  4 files changed, 149 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/ne=
t/ethernet/hisilicon/hibmcge/hbg_hw.c
> index 8e971e9f62a0..97fee714155a 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
> @@ -15,6 +15,7 @@
>   * ctrl means packet description, data means skb packet data
>   */
>  #define HBG_ENDIAN_CTRL_LE_DATA_BE     0x0
> +#define HBG_PCU_FRAME_LEN_PLUS 4
>
>  static bool hbg_hw_spec_is_valid(struct hbg_priv *priv)
>  {
> @@ -129,6 +130,44 @@ void hbg_hw_irq_enable(struct hbg_priv *priv, u32 ma=
sk, bool enable)
>         hbg_reg_write(priv, HBG_REG_CF_INTRPT_MSK_ADDR, value);
>  }
>
> +void hbg_hw_set_uc_addr(struct hbg_priv *priv, u64 mac_addr)
> +{
> +       hbg_reg_write64(priv, HBG_REG_STATION_ADDR_LOW_2_ADDR, mac_addr);
> +}
> +
> +static void hbg_hw_set_pcu_max_frame_len(struct hbg_priv *priv,
> +                                        u16 max_frame_len)
> +{
> +       max_frame_len =3D max_t(u32, max_frame_len, HBG_DEFAULT_MTU_SIZE)=
;
> +
> +       /* lower two bits of value must be set to 0. Otherwise, the value=
 is ignored */
> +       max_frame_len =3D round_up(max_frame_len, HBG_PCU_FRAME_LEN_PLUS)=
;
> +
> +       hbg_reg_write_field(priv, HBG_REG_MAX_FRAME_LEN_ADDR,
> +                           HBG_REG_MAX_FRAME_LEN_M, max_frame_len);
> +}
> +
> +static void hbg_hw_set_mac_max_frame_len(struct hbg_priv *priv,
> +                                        u16 max_frame_size)
> +{
> +       hbg_reg_write_field(priv, HBG_REG_MAX_FRAME_SIZE_ADDR,
> +                           HBG_REG_MAX_FRAME_LEN_M, max_frame_size);
> +}
> +
> +void hbg_hw_set_mtu(struct hbg_priv *priv, u16 mtu)
> +{
> +       hbg_hw_set_pcu_max_frame_len(priv, mtu);
> +       hbg_hw_set_mac_max_frame_len(priv, mtu);
> +}
> +
> +void hbg_hw_mac_enable(struct hbg_priv *priv, u32 enable)
> +{
> +       hbg_reg_write_field(priv, HBG_REG_PORT_ENABLE_ADDR,
> +                           HBG_REG_PORT_ENABLE_TX_B, enable);
> +       hbg_reg_write_field(priv, HBG_REG_PORT_ENABLE_ADDR,
> +                           HBG_REG_PORT_ENABLE_RX_B, enable);
> +}
> +
>  void hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
>  {
>         hbg_reg_write_field(priv, HBG_REG_PORT_MODE_ADDR,
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/ne=
t/ethernet/hisilicon/hibmcge/hbg_hw.h
> index 4d09bdd41c76..0ce500e907b3 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
> @@ -49,5 +49,8 @@ u32 hbg_hw_get_irq_status(struct hbg_priv *priv);
>  void hbg_hw_irq_clear(struct hbg_priv *priv, u32 mask);
>  bool hbg_hw_irq_is_enabled(struct hbg_priv *priv, u32 mask);
>  void hbg_hw_irq_enable(struct hbg_priv *priv, u32 mask, bool enable);
> +void hbg_hw_set_mtu(struct hbg_priv *priv, u16 mtu);
> +void hbg_hw_mac_enable(struct hbg_priv *priv, u32 enable);
> +void hbg_hw_set_uc_addr(struct hbg_priv *priv, u64 mac_addr);
>
>  #endif
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/=
net/ethernet/hisilicon/hibmcge/hbg_main.c
> index 29e0513fa836..d882a7822299 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
> @@ -2,6 +2,7 @@
>  // Copyright (c) 2024 Hisilicon Limited.
>
>  #include <linux/etherdevice.h>
> +#include <linux/if_vlan.h>
>  #include <linux/netdevice.h>
>  #include <linux/pci.h>
>  #include "hbg_common.h"
> @@ -9,6 +10,97 @@
>  #include "hbg_irq.h"
>  #include "hbg_mdio.h"
>
> +static void hbg_all_irq_enable(struct hbg_priv *priv, bool enabled)
> +{
> +       struct hbg_irq_info *info;
> +       u32 i;
> +
> +       for (i =3D 0; i < priv->vectors.info_array_len; i++) {
> +               info =3D &priv->vectors.info_array[i];
> +               hbg_hw_irq_enable(priv, info->mask, enabled);
> +       }
> +}
> +
> +static int hbg_net_open(struct net_device *netdev)
> +{
> +       struct hbg_priv *priv =3D netdev_priv(netdev);
> +
> +       hbg_all_irq_enable(priv, true);
> +       hbg_hw_mac_enable(priv, HBG_STATUS_ENABLE);
> +       netif_start_queue(netdev);
> +       hbg_phy_start(priv);
> +
> +       return 0;
> +}
> +
> +static int hbg_net_stop(struct net_device *netdev)
> +{
> +       struct hbg_priv *priv =3D netdev_priv(netdev);
> +
> +       hbg_phy_stop(priv);
> +       netif_stop_queue(netdev);
> +       hbg_hw_mac_enable(priv, HBG_STATUS_DISABLE);
> +       hbg_all_irq_enable(priv, false);
> +
> +       return 0;
> +}
> +
> +static int hbg_net_set_mac_address(struct net_device *netdev, void *addr=
)
> +{
> +       struct hbg_priv *priv =3D netdev_priv(netdev);
> +       u8 *mac_addr;
> +
> +       mac_addr =3D ((struct sockaddr *)addr)->sa_data;
> +
> +       hbg_hw_set_uc_addr(priv, ether_addr_to_u64(mac_addr));
> +       dev_addr_set(netdev, mac_addr);
> +
> +       return 0;
> +}
> +
> +static void hbg_change_mtu(struct hbg_priv *priv, int new_mtu)
> +{
> +       u32 frame_len;
> +
> +       frame_len =3D new_mtu + VLAN_HLEN * priv->dev_specs.vlan_layers +
> +                   ETH_HLEN + ETH_FCS_LEN;
> +       hbg_hw_set_mtu(priv, frame_len);
> +}
> +
> +static int hbg_net_change_mtu(struct net_device *netdev, int new_mtu)
> +{
> +       struct hbg_priv *priv =3D netdev_priv(netdev);
> +       bool is_running =3D netif_running(netdev);
> +
> +       if (is_running)
> +               hbg_net_stop(netdev);
> +
> +       hbg_change_mtu(priv, new_mtu);
> +       WRITE_ONCE(netdev->mtu, new_mtu);
[Kalesh] IMO the setting of "netdev->mtu" should be moved to the core
layer so that not all drivers have to do this.
__dev_set_mtu() can be modified to incorporate this. Just a thought.
> +
> +       dev_dbg(&priv->pdev->dev,
> +               "change mtu from %u to %u\n", netdev->mtu, new_mtu);
> +       if (is_running)
> +               hbg_net_open(netdev);
> +       return 0;
> +}
> +
> +static void hbg_net_get_stats64(struct net_device *netdev,
> +                               struct rtnl_link_stats64 *stats)
> +{
> +       netdev_stats_to_stats64(stats, &netdev->stats);
> +       dev_fetch_sw_netstats(stats, netdev->tstats);
> +}
> +
> +static const struct net_device_ops hbg_netdev_ops =3D {
> +       .ndo_open               =3D hbg_net_open,
> +       .ndo_stop               =3D hbg_net_stop,
> +       .ndo_validate_addr      =3D eth_validate_addr,
> +       .ndo_set_mac_address    =3D hbg_net_set_mac_address,
> +       .ndo_change_mtu         =3D hbg_net_change_mtu,
> +       .ndo_get_stats64        =3D hbg_net_get_stats64,
> +};
> +
>  static int hbg_init(struct hbg_priv *priv)
>  {
>         int ret;
> @@ -73,6 +165,7 @@ static int hbg_probe(struct pci_dev *pdev, const struc=
t pci_device_id *ent)
>         priv =3D netdev_priv(netdev);
>         priv->netdev =3D netdev;
>         priv->pdev =3D pdev;
> +       netdev->netdev_ops =3D &hbg_netdev_ops;
>
>         netdev->tstats =3D devm_netdev_alloc_pcpu_stats(&pdev->dev,
>                                                       struct pcpu_sw_nets=
tats);
> @@ -88,6 +181,10 @@ static int hbg_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *ent)
>         if (ret)
>                 return ret;
>
> +       netdev->max_mtu =3D priv->dev_specs.max_mtu;
> +       netdev->min_mtu =3D priv->dev_specs.min_mtu;
> +       hbg_change_mtu(priv, HBG_DEFAULT_MTU_SIZE);
> +       hbg_net_set_mac_address(priv->netdev, &priv->dev_specs.mac_addr);
>         ret =3D devm_register_netdev(dev, netdev);
>         if (ret)
>                 return dev_err_probe(dev, ret, "failed to register netdev=
\n");
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/n=
et/ethernet/hisilicon/hibmcge/hbg_reg.h
> index b0991063ccba..63bb1bead8c0 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
> @@ -37,18 +37,24 @@
>  #define HBG_REG_SGMII_BASE                     0x10000
>  #define HBG_REG_DUPLEX_TYPE_ADDR               (HBG_REG_SGMII_BASE + 0x0=
008)
>  #define HBG_REG_DUPLEX_B                       BIT(0)
> +#define HBG_REG_MAX_FRAME_SIZE_ADDR            (HBG_REG_SGMII_BASE + 0x0=
03C)
>  #define HBG_REG_PORT_MODE_ADDR                 (HBG_REG_SGMII_BASE + 0x0=
040)
>  #define HBG_REG_PORT_MODE_M                    GENMASK(3, 0)
> +#define HBG_REG_PORT_ENABLE_ADDR               (HBG_REG_SGMII_BASE + 0x0=
044)
> +#define HBG_REG_PORT_ENABLE_RX_B               BIT(1)
> +#define HBG_REG_PORT_ENABLE_TX_B               BIT(2)
>  #define HBG_REG_TRANSMIT_CONTROL_ADDR          (HBG_REG_SGMII_BASE + 0x0=
060)
>  #define HBG_REG_TRANSMIT_CONTROL_PAD_EN_B      BIT(7)
>  #define HBG_REG_TRANSMIT_CONTROL_CRC_ADD_B     BIT(6)
>  #define HBG_REG_TRANSMIT_CONTROL_AN_EN_B       BIT(5)
>  #define HBG_REG_CF_CRC_STRIP_ADDR              (HBG_REG_SGMII_BASE + 0x0=
1B0)
> -#define HBG_REG_CF_CRC_STRIP_B                 BIT(0)
> +#define HBG_REG_CF_CRC_STRIP_B                 BIT(1)
>  #define HBG_REG_MODE_CHANGE_EN_ADDR            (HBG_REG_SGMII_BASE + 0x0=
1B4)
>  #define HBG_REG_MODE_CHANGE_EN_B               BIT(0)
>  #define HBG_REG_RECV_CONTROL_ADDR              (HBG_REG_SGMII_BASE + 0x0=
1E0)
>  #define HBG_REG_RECV_CONTROL_STRIP_PAD_EN_B    BIT(3)
> +#define HBG_REG_STATION_ADDR_LOW_2_ADDR                (HBG_REG_SGMII_BA=
SE + 0x0210)
> +#define HBG_REG_STATION_ADDR_HIGH_2_ADDR       (HBG_REG_SGMII_BASE + 0x0=
214)
>
>  /* PCU */
>  #define HBG_REG_CF_INTRPT_MSK_ADDR             (HBG_REG_SGMII_BASE + 0x0=
42C)
> @@ -72,6 +78,8 @@
>  #define HBG_INT_MSK_RX_B                       BIT(0) /* just used in dr=
iver */
>  #define HBG_REG_CF_INTRPT_STAT_ADDR            (HBG_REG_SGMII_BASE + 0x0=
434)
>  #define HBG_REG_CF_INTRPT_CLR_ADDR             (HBG_REG_SGMII_BASE + 0x0=
438)
> +#define HBG_REG_MAX_FRAME_LEN_ADDR             (HBG_REG_SGMII_BASE + 0x0=
444)
> +#define HBG_REG_MAX_FRAME_LEN_M                        GENMASK(15, 0)
>  #define HBG_REG_RX_BUF_SIZE_ADDR               (HBG_REG_SGMII_BASE + 0x0=
4E4)
>  #define HBG_REG_RX_BUF_SIZE_M                  GENMASK(15, 0)
>  #define HBG_REG_BUS_CTRL_ADDR                  (HBG_REG_SGMII_BASE + 0x0=
4E8)
> @@ -86,6 +94,7 @@
>  #define HBG_REG_RX_PKT_MODE_ADDR               (HBG_REG_SGMII_BASE + 0x0=
4F4)
>  #define HBG_REG_RX_PKT_MODE_PARSE_MODE_M       GENMASK(22, 21)
>  #define HBG_REG_CF_IND_TXINT_MSK_ADDR          (HBG_REG_SGMII_BASE + 0x0=
694)
> +#define HBG_REG_IND_INTR_MASK_B                        BIT(0)
>  #define HBG_REG_CF_IND_TXINT_STAT_ADDR         (HBG_REG_SGMII_BASE + 0x0=
698)
>  #define HBG_REG_CF_IND_TXINT_CLR_ADDR          (HBG_REG_SGMII_BASE + 0x0=
69C)
>  #define HBG_REG_CF_IND_RXINT_MSK_ADDR          (HBG_REG_SGMII_BASE + 0x0=
6a0)
> --
> 2.33.0
>


--=20
Regards,
Kalesh A P

--00000000000020b0b80621bf8de5
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
AQkEMSIEIMGynqshO0tKLuMF2B17lfCu80It6r98BwfxWKbgFXBBMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDkxMDA4MjA1MFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAcneuM/QFi
7hBMYwfzid7Ua0qL6QxH5eJOUcFBrziMDaDiuhZ5VuW7o/4n4GmSedHchWSB+tEHqObIAmiyOg05
8QHHFGZ4RKqkm+cE0xXmDyLUT5iybR9O7t3aZsoiUOMkyFaKl/e7eNuTCbhokgw+7oAxB2u+lZbx
+pbNl1TyxKm9/j0xI7EPz1dR6Gusa8sUmW4gSVmwuHvEPUccDHXZDiaFyzIpAQ04lZBRUhQ0PbiD
fp+cx4IUr7wpQpkMoJHYV5t6u5ilVvq1q1j2SyWUarxyNJJs065DmYkYI7t03osPG9ooY33qutqA
SgVGiI4MOlDj8smDoOHzRNR9tHjm
--00000000000020b0b80621bf8de5--

