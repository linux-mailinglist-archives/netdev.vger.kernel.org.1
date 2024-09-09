Return-Path: <netdev+bounces-126342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04814970C1F
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 05:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2190728205D
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 03:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5191AC8B3;
	Mon,  9 Sep 2024 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pid+jjWU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B003D8E
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 03:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725851171; cv=none; b=QAr9xyVXiaZ3ngfHADal5XLiWUoZPsHSlnnlrI/nF6JzEcPV1DR4gluTn48cw9gWqoPXZe1eUQ0KFPd/5NO2B0XE01zzmSMAW4XRuaBhxyp7rxCDCq9LDvyMSPN2V8yvKc6vaRlivBKyk+FfKf1WY0j1fz0D+2lImOEDUy64ww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725851171; c=relaxed/simple;
	bh=q1JdNYQGrCRSR0vRgjQAPfi9zjnihZi0ug0RzNz5IYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0zHAc9C7Kda6w95OYxEdzMs1TFhWGwklUfLI5HhsMHFKEq6BQzTYQ/7hgKQwD1P4fHtytqdq475yNU3n8RQNvJN2l8cCMMK4cGpxnyLes/srGFH0lyq05RT9Hcxxs9NCyjALd3J8gy5iXQ7S51mqrURChuZ15Z4Pyfb54pe6G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pid+jjWU; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f759b87f83so15444511fa.2
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 20:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725851166; x=1726455966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RuBM7EJJmx4DStBRTXOmBsBupwcCo+Wpp7aZ+4w+Zpk=;
        b=Pid+jjWUw72gxc1aUYAXovRsrkS4TSv7WOb6UnrcN0g8z3dw3xp3zMOoUlrgwf5PV3
         AFAx7C8XDZK8i44XYUfSuxG5kVfDCdjGiuXQxrc2Z7Qt4o31mVWl2h6KJYSao6VQ5pik
         k9OsqYzc12iQQFPqjOtt8X20Xdde9XP3Pkws4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725851166; x=1726455966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuBM7EJJmx4DStBRTXOmBsBupwcCo+Wpp7aZ+4w+Zpk=;
        b=QbX0CzQZhhF7VigoNlN+iC86Y9Ds0a70jAj5UlmgIyPClaSvxmAl0mGfbCf5mm8zu8
         nw1fdjqGq/As4vJhPBd6zJTjtoc/tcyKv4N023D8ccdG92irezy1v5eX3E23oDAGf4/+
         s7l29Lj+io/kWrqsji0EAP9NgNn/Hh6AHRImb52ZGd9pWaa8WbeyebsYnpTGM17BJ5uc
         yZp15mkxUgbcP7/fpD4cGFRvsZTbuHj0uYB0CP043lVSALM1d/PrOg1YXiZcSP+4fxlH
         yZaBsTWCkn3ZuyC9Eu2ovLfaKq0uDxqYbvQfcq82THDGatyJdv9OgTG2GGnygRXLQbjn
         2nPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO3JWX2vt5Btp/Fivw44r/YkBT12xqJUV3KTT/RvVu3chE6zvLm/DuBGGh0s/M5jDrOE4EwBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY5j5JdPDn+3/lwmZsT+mZjKWRcV9Hc3LQQ7uhJRnC9iL3QwZQ
	vZw6YznfKAKGICzwuiSP4RqfjFuXo/GD0G5qnMldVnJho5k1Ve7o9l03VYeLxRFbumdOlie8Rbr
	th//5sWSg/WcHLsyaKqdNwQUvp/VX21ZHo6R3
X-Google-Smtp-Source: AGHT+IGAcaJ1b5EUxgWYLADPmecdiuoYsyt3auXo/aJmtrMW0Mgi3uDG18B4FbPW25VxHULjwFZV9eCQt37+IYS4QEM=
X-Received: by 2002:a05:6512:3983:b0:536:53fc:e8fc with SMTP id
 2adb3069b0e04-536587ac031mr4734000e87.16.1725851165375; Sun, 08 Sep 2024
 20:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909023141.3234567-1-shaojijie@huawei.com> <20240909023141.3234567-6-shaojijie@huawei.com>
In-Reply-To: <20240909023141.3234567-6-shaojijie@huawei.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 9 Sep 2024 08:35:52 +0530
Message-ID: <CAH-L+nOxj1_wHdSacC5R9WG5GeMswEQDXa4xgVFxyLHM7xjycg@mail.gmail.com>
Subject: Re: [PATCH V8 net-next 05/11] net: hibmcge: Implement some .ndo functions
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shenjian15@huawei.com, wangpeiyang1@huawei.com, 
	liuyonglong@huawei.com, chenhao418@huawei.com, sudongming1@huawei.com, 
	xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com, 
	zhuyuan@huawei.com, forest.zhouchang@huawei.com, andrew@lunn.ch, 
	jdamato@fastly.com, horms@kernel.org, jonathan.cameron@huawei.com, 
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b080310621a70986"

--000000000000b080310621a70986
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 8:11=E2=80=AFAM Jijie Shao <shaojijie@huawei.com> wr=
ote:
>
> Implement the .ndo_open() .ndo_stop() .ndo_set_mac_address()
> .ndo_change_mtu functions() and ndo.get_stats64()
> And .ndo_validate_addr calls the eth_validate_addr function directly
>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> ChangeLog:
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
>  .../ethernet/hisilicon/hibmcge/hbg_common.h   |   3 +
>  .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  39 +++++++
>  .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   3 +
>  .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 104 ++++++++++++++++++
>  .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  11 +-
>  5 files changed, 159 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/driver=
s/net/ethernet/hisilicon/hibmcge/hbg_common.h
> index e94ae2be5c4c..d11ef081f4da 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
> @@ -17,8 +17,11 @@
>
>  enum hbg_nic_state {
>         HBG_NIC_STATE_EVENT_HANDLING =3D 0,
> +       HBG_NIC_STATE_OPEN,
>  };
>
> +#define hbg_nic_is_open(priv) test_bit(HBG_NIC_STATE_OPEN, &(priv)->stat=
e)
> +
>  enum hbg_hw_event_type {
>         HBG_HW_EVENT_NONE =3D 0,
>         HBG_HW_EVENT_INIT, /* driver is loading */
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
> index 29e0513fa836..f4e9f6205f04 100644
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
> @@ -9,6 +10,104 @@
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
> +       if (test_and_set_bit(HBG_NIC_STATE_OPEN, &priv->state))
> +               return 0;
[Kalesh] Is there a possibility that dev_open() can be invoked twice?
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
> +       if (!hbg_nic_is_open(priv))
> +               return 0;
[Kalesh] Is there any reason to not check HBG_NIC_STATE_OPEN here?
> +
> +       clear_bit(HBG_NIC_STATE_OPEN, &priv->state);
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
> +       bool is_opened =3D hbg_nic_is_open(priv);
> +
> +       hbg_net_stop(netdev);
[Kalesh] Do you still need to call stop when NIC is not opened yet?
Instead of a new variable, I think you can check netif_running here.
> +
> +       hbg_change_mtu(priv, new_mtu);
> +       WRITE_ONCE(netdev->mtu, new_mtu);
> +
> +       dev_dbg(&priv->pdev->dev,
> +               "change mtu from %u to %u\n", netdev->mtu, new_mtu);
> +       if (is_opened)
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
> @@ -73,6 +172,7 @@ static int hbg_probe(struct pci_dev *pdev, const struc=
t pci_device_id *ent)
>         priv =3D netdev_priv(netdev);
>         priv->netdev =3D netdev;
>         priv->pdev =3D pdev;
> +       netdev->netdev_ops =3D &hbg_netdev_ops;
>
>         netdev->tstats =3D devm_netdev_alloc_pcpu_stats(&pdev->dev,
>                                                       struct pcpu_sw_nets=
tats);
> @@ -88,6 +188,10 @@ static int hbg_probe(struct pci_dev *pdev, const stru=
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
>


--=20
Regards,
Kalesh A P

--000000000000b080310621a70986
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
AQkEMSIEIMDyV7vcnQl10OgYYX09klqQk+u9vzFXwfMT0zbcBthHMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDkwOTAzMDYwNlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAoEY3UK1gd
hJQHdYIzbkEWOCaoxkhEjW2HnO6Y6K9rWPTby2kK50KD4Gs4EYvkadPQn9nqroMzo3mM+M2NOfyo
voYNlt1jC/SAIL8o8QVMVh8QPSrwWgi8fbgLWnPBG/J1CkOkNE7yhok9DoJlttDY31+dEHp+CqzP
6ssSvtxNSD/b2tCVK2zEuj9lGyI54cfTA4Zu27oyaItV4c1t+q1I8+R6BIOFMJxb8Z+HoO0JBzzK
pq2FK5Ae4m280zcU/kDfmt9FWutAdk+q4HPfmc1psaXmtd835OIvFGMvmE45yjp0fhmxKSSoWpkz
y2VH9RmPI1DaCvq0TqMenohdOnHu
--000000000000b080310621a70986--

