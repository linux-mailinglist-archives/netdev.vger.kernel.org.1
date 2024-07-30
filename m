Return-Path: <netdev+bounces-113982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15412940821
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3AA1C225E7
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 06:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B055516191E;
	Tue, 30 Jul 2024 06:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bigler.io header.i=@bigler.io header.b="sJU/TBxS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17D1824AF
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 06:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320179; cv=none; b=QwecuHJoyuq7ook38VMy30ub0VXAPMAHbQbw9Nokv4kxilhggCFefk7hL1Aj+mO0U5obyp/QYIN00j/wBPu4cb2ZtwYVP2ci9pgG3pGkIGdF6YGsFw9j+HK0VBYhe/exps/Hi2qzHSzy2mTdxfPReHhAPDdaeMbAhgKrCFiAGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320179; c=relaxed/simple;
	bh=fuvYsE7YuNf0OLoHWMykP5RwGVfXViTfBozMSahlYvs=;
	h=Message-ID:Date:Subject:From:To:Cc:MIME-Version:Content-Type:
	 References:In-Reply-To; b=gFnaZHzgOCi552YMxDpwMFRaLH/oOxBzft+X7IoQbE6J/4aq0jPopri6d/QmF/sdGusbU3aouHIjKqE8m//EHw3AmMKhiDBDfr2IQuI7iWRRecxxDCt5U9DHSNf+hkfHQ2X3mgCYF3kpvTeVK9z6W3rIZlClUjwYEe9X24KDZCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bigler.io; spf=pass smtp.mailfrom=bigler.io; dkim=pass (1024-bit key) header.d=bigler.io header.i=@bigler.io header.b=sJU/TBxS; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bigler.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bigler.io
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WY4jl2Sntz6ly;
	Tue, 30 Jul 2024 08:16:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bigler.io;
	s=20200409; t=1722320171;
	bh=y0xkzY4hrLGOqX655x1m6ZjmEkgz6HSluSWE+gtQnD8=;
	h=Date:Subject:From:Reply-To:To:Cc:References:In-Reply-To:From;
	b=sJU/TBxSFyZPAl0IJwoYiKhqVTUC1xhgkLGIo6xkEMP8kG3IKqcACo/QyFHOVhVs+
	 /La100Ok5F4HZ7WQFdBmG9LAsItkaxmfspi+0y7AntH2YgT4zABIz8cXZ0uzScMbsF
	 emaQFVjhmn3IUZ4oLFrHPL3VbO5RfBf4bxQEgKTE=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WY4jf3gW7zTyx;
	Tue, 30 Jul 2024 08:16:06 +0200 (CEST)
Message-ID: <c88f30906053214a207220e97b49868f@mail.infomaniak.com>
Date: Tue, 30 Jul 2024 08:16:06 +0200
Subject: Re: [PATCH net-next v5 13/14] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
From: Stefan Bigler <linux@bigler.io>
Reply-To: Stefan Bigler <linux@bigler.io>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch, corbet@lwn.net,
 linux-doc@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
 ruanjinjie@huawei.com, steen.hegelund@microchip.com, vladimir.oltean@nxp.com,
 parthiban.veerasooran@microchip.com, masahiroy@kernel.org,
 alexanderduyck@fb.com, krzk+dt@kernel.org, robh@kernel.org,
 rdunlap@infradead.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
 Pier.Beruto@onsemi.com, Selvamani.Rajagopal@onsemi.com,
 Nicolas.Ferre@microchip.com, benjamin.bigler@bernformulastudent.ch
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WS-User-Origin: eyJpdiI6IklpSGxLQ1hHOUdISUVidVM1YUVScnc9PSIsInZhbHVlIjoiZHZJL2VuOG9hc3pnRkIwVnhzeG5WZz09IiwibWFjIjoiNmI5OGQ3MGYwN2MxMDRiODg4ZDNlZTJlZDJjNmE1NzlmZTVmYmY1YmI4YTk0NTFmMzAxNjhmNjQ5YjY2ZjU0YiIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6IjgrMlZZYXhGK3hYem4vaXpLZ3pUcVE9PSIsInZhbHVlIjoiU1hHK1pvclY4R0xYeGNqRGtBZ21HZz09IiwibWFjIjoiMGNkY2E1M2Y3YWZjOGFiNWY1YjA4Zjk0OTkyZWU3ZTAxMDk4YmY0NDNmNThiYjhjYjI4MWIzOWFkY2U1NDg5MSIsInRhZyI6IiJ9
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.726)
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
 <20240730040906.53779-14-Parthiban.Veerasooran@microchip.com>
In-Reply-To: <20240730040906.53779-14-Parthiban.Veerasooran@microchip.com>
X-Infomaniak-Routing: alpha

Hi Parthiban

Thanks for v5. I tested and after some fixes it works (I'm still on 6.6.y b=
ut it was easy to apply the patches).

I found the following issues:

1) set of Mac-Addr is not working correctly
be ware to the fact that eth_commit_mac_addr_change() takes the pointer to =
the sockaddr and not to the sa_data

drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -278,7 +278,7 @@ static int lan865x_set_mac_address(struct net_device *n=
etdev, void *addr)
        if (ret)
                return ret;
-        eth_commit_mac_addr_change(netdev, address->sa_data);
+       eth_commit_mac_addr_change(netdev, address);
=20
2) Missing symbol export
drivers/net/ethernet/oa_tc6.c
@@ -1224,6 +1224,8 @@ int oa_tc6_zero_align_receive_frame_enable(struct oa_=
tc6 *tc6)
        return oa_tc6_write_register(tc6, OA_TC6_REG_CONFIG0, regval);
 }
+EXPORT_SYMBOL_GPL(oa_tc6_zero_align_receive_frame_enable);

3) My patch for Multicast support was incomplete=20
Sorry for this. I did forgott to write that the MAC_NET_CFG_MULTICAST_MODE =
must be set.
I addition I also added the correct implemenation for IFF_ALLMULTI

drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -330,6 +330,22 @@ static void lan865x_set_specific_multicast_addr(struct=
 net_device *netdev)
                netdev_err(netdev, "Failed to write reg_hashl");
 }
=20
+static void lan865x_set_all_multicast_addr(struct net_device *netdev)
+{
+       struct lan865x_priv *priv =3D netdev_priv(netdev);
+       u32 hash_lo =3D 0xffffffff;
+       u32 hash_hi =3D 0xffffffff;
+
+       /* Enabling specific multicast addresses */
+       if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_HASH, hash_h=
i)) {
+               netdev_err(netdev, "Failed to write reg_hashh");
+               return;
+       }
+
+       if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_L_HASH, hash_l=
o))
+               netdev_err(netdev, "Failed to write reg_hashl");
+}
+
 static void lan865x_multicast_work_handler(struct work_struct *work)
 {
        struct lan865x_priv *priv =3D container_of(work, struct lan865x_pri=
v,
@@ -343,14 +359,15 @@ static void lan865x_multicast_work_handler(struct wor=
k_struct *work)
                regval &=3D (~MAC_NET_CFG_UNICAST_MODE);
        } else if (priv->netdev->flags & IFF_ALLMULTI) {
                /* Enabling all multicast mode */
+               lan865x_set_all_multicast_addr(priv->netdev);
                regval &=3D (~MAC_NET_CFG_PROMISCUOUS_MODE);
                regval |=3D MAC_NET_CFG_MULTICAST_MODE;
                regval &=3D (~MAC_NET_CFG_UNICAST_MODE);
        } else if (!netdev_mc_empty(priv->netdev)) {
                lan865x_set_specific_multicast_addr(priv->netdev);
                regval &=3D (~MAC_NET_CFG_PROMISCUOUS_MODE);
-               regval &=3D (~MAC_NET_CFG_MULTICAST_MODE);
-               regval |=3D MAC_NET_CFG_UNICAST_MODE;
+               regval |=3D MAC_NET_CFG_MULTICAST_MODE;
+               regval &=3D (~MAC_NET_CFG_UNICAST_MODE);
        } else {

Thanks for your work.
Best Regards
Stefan


Am 2024-07-30T06:09:05.000+02:00 hat Parthiban Veerasooran <Parthiban.Veera=
sooran@microchip.com> geschrieben:

>  The LAN8650/1 is designed to conform to the OPEN Alliance 10BASE-T1x
> MAC-PHY Serial Interface specification, Version 1.1. The IEEE Clause 4
> MAC integration provides the low pin count standard SPI interface to any
> microcontroller therefore providing Ethernet functionality without
> requiring MAC integration within the microcontroller. The LAN8650/1
> operates as an SPI client supporting SCLK clock rates up to a maximum of
> 25 MHz. This SPI interface supports the transfer of both data (Ethernet
> frames) and control (register access).
>=20
> By default, the chunk data payload is 64 bytes in size. The Ethernet
> Media Access Controller (MAC) module implements a 10 Mbps half duplex
> Ethernet MAC, compatible with the IEEE 802.3 standard. 10BASE-T1S
> physical layer transceiver integrated is into the LAN8650/1. The PHY and
> MAC are connected via an internal Media Independent Interface (MII).
>=20
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com=
>
> ---
>  MAINTAINERS                                   |   6 +
>  drivers/net/ethernet/microchip/Kconfig        |   1 +
>  drivers/net/ethernet/microchip/Makefile       |   1 +
>  .../net/ethernet/microchip/lan865x/Kconfig    |  19 +
>  .../net/ethernet/microchip/lan865x/Makefile   |   6 +
>  .../net/ethernet/microchip/lan865x/lan865x.c  | 391 ++++++++++++++++++
>  6 files changed, 424 insertions(+)
>  create mode 100644 drivers/net/ethernet/microchip/lan865x/Kconfig
>  create mode 100644 drivers/net/ethernet/microchip/lan865x/Makefile
>  create mode 100644 drivers/net/ethernet/microchip/lan865x/lan865x.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ee490b9e363c..907522277010 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14949,6 +14949,12 @@ L:=09netdev@vger.kernel.org
>  S:=09Maintained
>  F:=09drivers/net/ethernet/microchip/lan743x_*
> =20
> +MICROCHIP LAN8650/1 10BASE-T1S MACPHY ETHERNET DRIVER
> +M:=09Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
> +L:=09netdev@vger.kernel.org
> +S:=09Maintained
> +F:=09drivers/net/ethernet/microchip/lan865x/lan865x.c
> +
>  MICROCHIP LAN87xx/LAN937x T1 PHY DRIVER
>  M:=09Arun Ramadoss <arun.ramadoss@microchip.com>
>  R:=09UNGLinuxDriver@microchip.com
> diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/etherne=
t/microchip/Kconfig
> index 43ba71e82260..06ca79669053 100644
> --- a/drivers/net/ethernet/microchip/Kconfig
> +++ b/drivers/net/ethernet/microchip/Kconfig
> @@ -56,6 +56,7 @@ config LAN743X
>  =09  To compile this driver as a module, choose M here. The module will =
be
>  =09  called lan743x.
> =20
> +source "drivers/net/ethernet/microchip/lan865x/Kconfig"
>  source "drivers/net/ethernet/microchip/lan966x/Kconfig"
>  source "drivers/net/ethernet/microchip/sparx5/Kconfig"
>  source "drivers/net/ethernet/microchip/vcap/Kconfig"
> diff --git a/drivers/net/ethernet/microchip/Makefile b/drivers/net/ethern=
et/microchip/Makefile
> index bbd349264e6f..15dfbb321057 100644
> --- a/drivers/net/ethernet/microchip/Makefile
> +++ b/drivers/net/ethernet/microchip/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_LAN743X) +=3D lan743x.o
> =20
>  lan743x-objs :=3D lan743x_main.o lan743x_ethtool.o lan743x_ptp.o
> =20
> +obj-$(CONFIG_LAN865X) +=3D lan865x/
>  obj-$(CONFIG_LAN966X_SWITCH) +=3D lan966x/
>  obj-$(CONFIG_SPARX5_SWITCH) +=3D sparx5/
>  obj-$(CONFIG_VCAP) +=3D vcap/
> diff --git a/drivers/net/ethernet/microchip/lan865x/Kconfig b/drivers/net=
/ethernet/microchip/lan865x/Kconfig
> new file mode 100644
> index 000000000000..f3d60d14e202
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/lan865x/Kconfig
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Microchip LAN865x Driver Support
> +#
> +
> +if NET_VENDOR_MICROCHIP
> +
> +config LAN865X
> +=09tristate "LAN865x support"
> +=09depends on SPI
> +=09depends on OA_TC6
> +=09help
> +=09  Support for the Microchip LAN8650/1 Rev.B1 MACPHY Ethernet chip. It
> +=09  uses OPEN Alliance 10BASE-T1x Serial Interface specification.
> +
> +=09  To compile this driver as a module, choose M here. The module will =
be
> +=09  called lan865x.
> +
> +endif # NET_VENDOR_MICROCHIP
> diff --git a/drivers/net/ethernet/microchip/lan865x/Makefile b/drivers/ne=
t/ethernet/microchip/lan865x/Makefile
> new file mode 100644
> index 000000000000..9f5dd89c1eb8
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/lan865x/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for the Microchip LAN865x Driver
> +#
> +
> +obj-$(CONFIG_LAN865X) +=3D lan865x.o
> diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/n=
et/ethernet/microchip/lan865x/lan865x.c
> new file mode 100644
> index 000000000000..b25c927659f4
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
> @@ -0,0 +1,391 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Microchip's LAN865x 10BASE-T1S MAC-PHY driver
> + *
> + * Author: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/phy.h>
> +#include <linux/oa_tc6.h>
> +
> +#define DRV_NAME=09=09=09"lan8650"
> +
> +/* MAC Network Control Register */
> +#define LAN865X_REG_MAC_NET_CTL=09=090x00010000
> +#define MAC_NET_CTL_TXEN=09=09BIT(3) /* Transmit Enable */
> +#define MAC_NET_CTL_RXEN=09=09BIT(2) /* Receive Enable */
> +
> +/* MAC Network Configuration Reg */
> +#define LAN865X_REG_MAC_NET_CFG=09=090x00010001
> +#define MAC_NET_CFG_PROMISCUOUS_MODE=09BIT(4)
> +#define MAC_NET_CFG_MULTICAST_MODE=09BIT(6)
> +#define MAC_NET_CFG_UNICAST_MODE=09BIT(7)
> +
> +/* MAC Hash Register Bottom */
> +#define LAN865X_REG_MAC_L_HASH=09=090x00010020
> +/* MAC Hash Register Top */
> +#define LAN865X_REG_MAC_H_HASH=09=090x00010021
> +/* MAC Specific Addr 1 Bottom Reg */
> +#define LAN865X_REG_MAC_L_SADDR1=090x00010022
> +/* MAC Specific Addr 1 Top Reg */
> +#define LAN865X_REG_MAC_H_SADDR1=090x00010023
> +
> +struct lan865x_priv {
> +=09struct work_struct multicast_work;
> +=09struct net_device *netdev;
> +=09struct spi_device *spi;
> +=09struct oa_tc6 *tc6;
> +};
> +
> +static int lan865x_set_hw_macaddr_low_bytes(struct oa_tc6 *tc6, const u8=
 *mac)
> +{
> +=09u32 regval;
> +
> +=09regval =3D (mac[3] << 24) | (mac[2] << 16) | (mac[1] << 8) | mac[0];
> +
> +=09return oa_tc6_write_register(tc6, LAN865X_REG_MAC_L_SADDR1, regval);
> +}
> +
> +static int lan865x_set_hw_macaddr(struct lan865x_priv *priv, const u8 *m=
ac)
> +{
> +=09int restore_ret;
> +=09u32 regval;
> +=09int ret;
> +
> +=09/* Configure MAC address low bytes */
> +=09ret =3D lan865x_set_hw_macaddr_low_bytes(priv->tc6, mac);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09/* Prepare and configure MAC address high bytes */
> +=09regval =3D (mac[5] << 8) | mac[4];
> +=09ret =3D oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_SADDR1,
> +=09=09=09=09    regval);
> +=09if (!ret)
> +=09=09return 0;
> +
> +=09/* Restore the old MAC address low bytes from netdev if the new MAC
> +=09 * address high bytes setting failed.
> +=09 */
> +=09restore_ret =3D lan865x_set_hw_macaddr_low_bytes(priv->tc6,
> +=09=09=09=09=09=09       priv->netdev->dev_addr);
> +=09if (restore_ret)
> +=09=09return restore_ret;
> +
> +=09return ret;
> +}
> +
> +static void
> +lan865x_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *i=
nfo)
> +{
> +=09strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> +=09strscpy(info->bus_info, dev_name(netdev->dev.parent),
> +=09=09sizeof(info->bus_info));
> +}
> +
> +static const struct ethtool_ops lan865x_ethtool_ops =3D {
> +=09.get_drvinfo        =3D lan865x_get_drvinfo,
> +=09.get_link_ksettings =3D phy_ethtool_get_link_ksettings,
> +=09.set_link_ksettings =3D phy_ethtool_set_link_ksettings,
> +};
> +
> +static int lan865x_set_mac_address(struct net_device *netdev, void *addr=
)
> +{
> +=09struct lan865x_priv *priv =3D netdev_priv(netdev);
> +=09struct sockaddr *address =3D addr;
> +=09int ret;
> +
> +=09ret =3D eth_prepare_mac_addr_change(netdev, addr);
> +=09if (ret < 0)
> +=09=09return ret;
> +
> +=09if (ether_addr_equal(address->sa_data, netdev->dev_addr))
> +=09=09return 0;
> +
> +=09ret =3D lan865x_set_hw_macaddr(priv, address->sa_data);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09eth_commit_mac_addr_change(netdev, address->sa_data);
> +
> +=09return 0;
> +}
> +
> +static u32 get_address_bit(u8 addr[ETH_ALEN], u32 bit)
> +{
> +=09return ((addr[bit / 8]) >> (bit % 8)) & 1;
> +}
> +
> +static u32 lan865x_hash(u8 addr[ETH_ALEN])
> +{
> +=09u32 hash_index =3D 0;
> +
> +=09for (int i =3D 0; i < 6; i++) {
> +=09=09u32 hash =3D 0;
> +
> +=09=09for (int j =3D 0; j < 8; j++)
> +=09=09=09hash ^=3D get_address_bit(addr, (j * 6) + i);
> +
> +=09=09hash_index |=3D (hash << i);
> +=09}
> +
> +=09return hash_index;
> +}
> +
> +static void lan865x_set_specific_multicast_addr(struct net_device *netde=
v)
> +{
> +=09struct lan865x_priv *priv =3D netdev_priv(netdev);
> +=09struct netdev_hw_addr *ha;
> +=09u32 hash_lo =3D 0;
> +=09u32 hash_hi =3D 0;
> +
> +=09netdev_for_each_mc_addr(ha, netdev) {
> +=09=09u32 bit_num =3D lan865x_hash(ha->addr);
> +
> +=09=09if (bit_num &gt;=3D BIT(5))
> +=09=09=09hash_hi |=3D (1 << (bit_num - BIT(5)));
> +=09=09else
> +=09=09=09hash_lo |=3D (1 << bit_num);
> +=09}
> +
> +=09/* Enabling specific multicast addresses */
> +=09if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_HASH, hash_hi)=
) {
> +=09=09netdev_err(netdev, "Failed to write reg_hashh");
> +=09=09return;
> +=09}
> +
> +=09if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_L_HASH, hash_lo)=
)
> +=09=09netdev_err(netdev, "Failed to write reg_hashl");
> +}
> +
> +static void lan865x_multicast_work_handler(struct work_struct *work)
> +{
> +=09struct lan865x_priv *priv =3D container_of(work, struct lan865x_priv,
> +=09=09=09=09=09=09 multicast_work);
> +=09u32 regval =3D 0;
> +
> +=09if (priv->netdev->flags & IFF_PROMISC) {
> +=09=09/* Enabling promiscuous mode */
> +=09=09regval |=3D MAC_NET_CFG_PROMISCUOUS_MODE;
> +=09=09regval &=3D (~MAC_NET_CFG_MULTICAST_MODE);
> +=09=09regval &=3D (~MAC_NET_CFG_UNICAST_MODE);
> +=09} else if (priv->netdev->flags & IFF_ALLMULTI) {
> +=09=09/* Enabling all multicast mode */
> +=09=09regval &=3D (~MAC_NET_CFG_PROMISCUOUS_MODE);
> +=09=09regval |=3D MAC_NET_CFG_MULTICAST_MODE;
> +=09=09regval &=3D (~MAC_NET_CFG_UNICAST_MODE);
> +=09} else if (!netdev_mc_empty(priv->netdev)) {
> +=09=09lan865x_set_specific_multicast_addr(priv->netdev);
> +=09=09regval &=3D (~MAC_NET_CFG_PROMISCUOUS_MODE);
> +=09=09regval &=3D (~MAC_NET_CFG_MULTICAST_MODE);
> +=09=09regval |=3D MAC_NET_CFG_UNICAST_MODE;
> +=09} else {
> +=09=09/* enabling local mac address only */
> +=09=09if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_HASH,
> +=09=09=09=09=09  0)) {
> +=09=09=09netdev_err(priv->netdev, "Failed to write reg_hashh");
> +=09=09=09return;
> +=09=09}
> +=09=09if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_L_HASH,
> +=09=09=09=09=09  0)) {
> +=09=09=09netdev_err(priv->netdev, "Failed to write reg_hashl");
> +=09=09=09return;
> +=09=09}
> +=09}
> +=09if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_NET_CFG, regval)=
)
> +=09=09netdev_err(priv->netdev,
> +=09=09=09   "Failed to enable promiscuous/multicast/normal mode");
> +}
> +
> +static void lan865x_set_multicast_list(struct net_device *netdev)
> +{
> +=09struct lan865x_priv *priv =3D netdev_priv(netdev);
> +
> +=09schedule_work(&priv->multicast_work);
> +}
> +
> +static netdev_tx_t lan865x_send_packet(struct sk_buff *skb,
> +=09=09=09=09       struct net_device *netdev)
> +{
> +=09struct lan865x_priv *priv =3D netdev_priv(netdev);
> +
> +=09return oa_tc6_start_xmit(priv->tc6, skb);
> +}
> +
> +static int lan865x_hw_disable(struct lan865x_priv *priv)
> +{
> +=09u32 regval;
> +
> +=09if (oa_tc6_read_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, =C2=
=AEval))
> +=09=09return -ENODEV;
> +
> +=09regval &=3D ~(MAC_NET_CTL_TXEN | MAC_NET_CTL_RXEN);
> +
> +=09if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, regval)=
)
> +=09=09return -ENODEV;
> +
> +=09return 0;
> +}
> +
> +static int lan865x_net_close(struct net_device *netdev)
> +{
> +=09struct lan865x_priv *priv =3D netdev_priv(netdev);
> +=09int ret;
> +
> +=09netif_stop_queue(netdev);
> +=09phy_stop(netdev->phydev);
> +=09ret =3D lan865x_hw_disable(priv);
> +=09if (ret) {
> +=09=09netdev_err(netdev, "Failed to disable the hardware: %d\n", ret);
> +=09=09return ret;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static int lan865x_hw_enable(struct lan865x_priv *priv)
> +{
> +=09u32 regval;
> +
> +=09if (oa_tc6_read_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, =C2=
=AEval))
> +=09=09return -ENODEV;
> +
> +=09regval |=3D MAC_NET_CTL_TXEN | MAC_NET_CTL_RXEN;
> +
> +=09if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, regval)=
)
> +=09=09return -ENODEV;
> +
> +=09return 0;
> +}
> +
> +static int lan865x_net_open(struct net_device *netdev)
> +{
> +=09struct lan865x_priv *priv =3D netdev_priv(netdev);
> +=09int ret;
> +
> +=09ret =3D lan865x_hw_enable(priv);
> +=09if (ret) {
> +=09=09netdev_err(netdev, "Failed to enable hardware: %d\n", ret);
> +=09=09return ret;
> +=09}
> +
> +=09phy_start(netdev->phydev);
> +
> +=09return 0;
> +}
> +
> +static const struct net_device_ops lan865x_netdev_ops =3D {
> +=09.ndo_open=09=09=3D lan865x_net_open,
> +=09.ndo_stop=09=09=3D lan865x_net_close,
> +=09.ndo_start_xmit=09=09=3D lan865x_send_packet,
> +=09.ndo_set_rx_mode=09=3D lan865x_set_multicast_list,
> +=09.ndo_set_mac_address=09=3D lan865x_set_mac_address,
> +};
> +
> +static int lan865x_probe(struct spi_device *spi)
> +{
> +=09struct net_device *netdev;
> +=09struct lan865x_priv *priv;
> +=09int ret;
> +
> +=09netdev =3D alloc_etherdev(sizeof(struct lan865x_priv));
> +=09if (!netdev)
> +=09=09return -ENOMEM;
> +
> +=09priv =3D netdev_priv(netdev);
> +=09priv->netdev =3D netdev;
> +=09priv->spi =3D spi;
> +=09spi_set_drvdata(spi, priv);
> +=09INIT_WORK(&priv->multicast_work, lan865x_multicast_work_handler);
> +
> +=09priv->tc6 =3D oa_tc6_init(spi, netdev);
> +=09if (!priv->tc6) {
> +=09=09ret =3D -ENODEV;
> +=09=09goto free_netdev;
> +=09}
> +
> +=09/* As per the point s3 in the below errata, SPI receive Ethernet fram=
e
> +=09 * transfer may halt when starting the next frame in the same data bl=
ock
> +=09 * (chunk) as the end of a previous frame. The RFA field should be
> +=09 * configured to 01b or 10b for proper operation. In these modes, onl=
y
> +=09 * one receive Ethernet frame will be placed in a single data block.
> +=09 * When the RFA field is written to 01b, received frames will be forc=
ed
> +=09 * to only start in the first word of the data block payload (SWO=3D0=
). As
> +=09 * recommended, enable zero align receive frame feature for proper
> +=09 * operation.
> +=09 *
> +=09 * https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/Pro=
ductDocuments/Errata/LAN8650-1-Errata-80001075.pdf
> +=09 */
> +=09ret =3D oa_tc6_zero_align_receive_frame_enable(priv->tc6);
> +=09if (ret) {
> +=09=09dev_err(&spi->dev, "Failed to set ZARFE: %d\n", ret);
> +=09=09goto oa_tc6_exit;
> +=09}
> +
> +=09/* Get the MAC address from the SPI device tree node */
> +=09if (device_get_ethdev_address(&spi->dev, netdev))
> +=09=09eth_hw_addr_random(netdev);
> +
> +=09ret =3D lan865x_set_hw_macaddr(priv, netdev->dev_addr);
> +=09if (ret) {
> +=09=09dev_err(&spi->dev, "Failed to configure MAC: %d\n", ret);
> +=09=09goto oa_tc6_exit;
> +=09}
> +
> +=09netdev->if_port =3D IF_PORT_10BASET;
> +=09netdev->irq =3D spi->irq;
> +=09netdev->netdev_ops =3D &lan865x_netdev_ops;
> +=09netdev->ethtool_ops =3D &lan865x_ethtool_ops;
> +
> +=09ret =3D register_netdev(netdev);
> +=09if (ret) {
> +=09=09dev_err(&spi->dev, "Register netdev failed (ret =3D %d)", ret);
> +=09=09goto oa_tc6_exit;
> +=09}
> +
> +=09return 0;
> +
> +oa_tc6_exit:
> +=09oa_tc6_exit(priv->tc6);
> +free_netdev:
> +=09free_netdev(priv->netdev);
> +=09return ret;
> +}
> +
> +static void lan865x_remove(struct spi_device *spi)
> +{
> +=09struct lan865x_priv *priv =3D spi_get_drvdata(spi);
> +
> +=09cancel_work_sync(&priv->multicast_work);
> +=09unregister_netdev(priv->netdev);
> +=09oa_tc6_exit(priv->tc6);
> +=09free_netdev(priv->netdev);
> +}
> +
> +static const struct spi_device_id spidev_spi_ids[] =3D {
> +=09{ .name =3D "lan8650" },
> +=09{},
> +};
> +
> +static const struct of_device_id lan865x_dt_ids[] =3D {
> +=09{ .compatible =3D "microchip,lan8650" },
> +=09{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, lan865x_dt_ids);
> +
> +static struct spi_driver lan865x_driver =3D {
> +=09.driver =3D {
> +=09=09.name =3D DRV_NAME,
> +=09=09.of_match_table =3D lan865x_dt_ids,
> +=09 },
> +=09.probe =3D lan865x_probe,
> +=09.remove =3D lan865x_remove,
> +=09.id_table =3D spidev_spi_ids,
> +};
> +module_spi_driver(lan865x_driver);
> +
> +MODULE_DESCRIPTION(DRV_NAME " 10Base-T1S MACPHY Ethernet Driver");
> +MODULE_AUTHOR("Parthiban Veerasooran <parthiban.veerasooran@microchip.co=
m>");
> +MODULE_LICENSE("GPL");
> --=20
> 2.34.1

