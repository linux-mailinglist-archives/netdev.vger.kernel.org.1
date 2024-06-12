Return-Path: <netdev+bounces-102905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AF790563B
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3876D1F2199D
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 15:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614D117F4EB;
	Wed, 12 Jun 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bPhVrpmB"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E851DDF6;
	Wed, 12 Jun 2024 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204704; cv=none; b=VOIVGZ5K3Hz5qFbLeARmJ2ZvLlwhI8NhCdhk68FOAFS00WqwXKertQY/15Tl7T4CBzeDSgn7uaOcBMgee0YwMB6dTL0SpzrMk6ealbO/nxwAKe/an2a2n43dDXcZBJjQ8jS8wuGkR//VCFFDxGpvjm3AHTL5Fg8TUTY7BuwBJ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204704; c=relaxed/simple;
	bh=epah42P+sM8uvP4kzVU7f5KjWHmK7c9xEz2NjI3X/2U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K19saVFx9qkyhYACVHDlVCd/9hB46vt44hZGhlha9ZBA6zlDyZ0j7PNax0f1wzpFtLwLlX7lZIm0R+VfqOHH6YQaOxh0VUWIU1qQcePnoDEGLs34Kn8km0UEvpO7+KaNs9WmqdchKQxoaKP+SNNRfmadB8QlQIXRik6JCk8YCwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bPhVrpmB; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B872F40003;
	Wed, 12 Jun 2024 15:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718204694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6CPyut8mOdwZRLb5YdR+fcA2ISmvQyq0VV4xAyUgfog=;
	b=bPhVrpmBxegLaTH5571yBVjcgOMQK1C3PWOOfHGTagdv1mWqVSgsQFvJqdFUbUukfmazw1
	V3qsYclWNVIux2ThEB6Vb4mLrc5jB7CexzgN5eh2cxhtcMBpjx8SzZ5mKkk1g6QUElvnOs
	Um/sX8+sg07val9XWhrljRSa8kYRKNrVqJ1Y380ufOvH6Lxc86Go4YDodqtt+nyH/6LcJY
	0QFAyhAW3cdKcl9pwilBWd+OqbCfGH9GKhhb4conH79mg+4wXnaMe5B8AoCebsG1jNqY3/
	7nJn2t8MspM/dh0bBnSyV3/qHWY039c+6BJ68lVTZifzLnzqcwIyWC6pCNJacA==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v15 00/14] net: Make timestamping selectable
Date: Wed, 12 Jun 2024 17:04:00 +0200
Message-Id: <20240612-feature_ptp_netnext-v15-0-b2a086257b63@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOC4aWYC/3XSwW6DMAwA0F+pch5TbJyE9LT/mKYqgL0ibVABQ
 52q/vtctIlqhWNi5yWOfTED9w0PZr+7mJ6nZmi6VhfgnnamOqb2nbOm1g2DFnOwAJlwGr96Ppz
 G06HlseXzmOWCoXCh4IJKoydPPUtzntlXo0nZLcu8aeTYDGPXf8/3TX6O/8pxVZ58ZrMASaTCU
 Fp2L2XXjR9N+1x1n7M4hUUBoHUlqEIBOYTogMk+KsWfQhbBryuFKg6sEAoRSfmoxDsFN5R4e4t
 zHsBRFIRHBezCkN34GLDqWEnIyVVFTHHFgTsHccMBdQS0IBBMUBcrDt45ud1wUB2snCCVPkWgF
 SdfHIdbdeXqeK4T1aTlkaw4tDjebrRcR0EnJ5RePGvC/55fr9cfhdyFOP0CAAA=
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Shannon Nelson <shannon.nelson@amd.com>, 
 Alexandra Winter <wintera@linux.ibm.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

Up until now, there was no way to let the user select the hardware
PTP provider at which time stamping occurs. The stack assumed that PHY time
stamping is always preferred, but some MAC/PHY combinations were buggy.

This series updates the default MAC/PHY default timestamping and aims to
allow the user to select the desired hwtstamp provider administratively.

Changes in v15:
- Fix uninitialized ethtool_ts_info structure.
- Link to v14: https://lore.kernel.org/r/20240604-feature_ptp_netnext-v14-0-77b6f6efea40@bootlin.com

Changes in v14:
- Add back an EXPORT_SYMBOL() missing.
- Link to v13: https://lore.kernel.org/r/20240529-feature_ptp_netnext-v13-0-6eda4d40fa4f@bootlin.com

Changes in v13:
- Add PTP builtin code to fix build errors when building PTP as a module.
- Fix error spotted by smatch and sparse.
- Link to v12: https://lore.kernel.org/r/20240430-feature_ptp_netnext-v12-0-2c5f24b6a914@bootlin.com

Changes in v12:
- Add missing return description in the kdoc.
- Fix few nit.
- Link to v11: https://lore.kernel.org/r/20240422-feature_ptp_netnext-v11-0-f14441f2a1d8@bootlin.com

Changes in v11:
- Add netlink examples.
- Remove a change of my out of tree marvell_ptp patch in the patch series.
- Remove useless extern.
- Link to v10: https://lore.kernel.org/r/20240409-feature_ptp_netnext-v10-0-0fa2ea5c89a9@bootlin.com

Changes in v10:
- Move declarations to net/core/dev.h instead of netdevice.h
- Add netlink documentation.
- Add ETHTOOL_A_TSINFO_GHWTSTAMP netlink attributes instead of a bit in
  ETHTOOL_A_TSINFO_TIMESTAMPING bitset.
- Send "Move from simple ida to xarray" patch standalone.
- Add tsinfo ntf command.
- Add rcu_lock protection mechanism to avoid memory leak.
- Fixed doc and kdoc issue.
- Link to v9: https://lore.kernel.org/r/20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com

Changes in v9:
- Remove the RFC prefix.
- Correct few NIT fixes.
- Link to v8: https://lore.kernel.org/r/20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com

Changes in v8:
- Drop the 6 first patch as they are now merged.
- Change the full implementation to not be based on the hwtstamp layer
  (MAC/PHY) but on the hwtstamp provider which mean a ptp clock and a
  phc qualifier.
- Made some patch to prepare the new implementation.
- Expand netlink tsinfo instead of a new ts command for new hwtstamp
  configuration uAPI and for dumping tsinfo of specific hwtstamp provider.
- Link to v7: https://lore.kernel.org/r/20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com

Changes in v7:
- Fix a temporary build error.
- Link to v6: https://lore.kernel.org/r/20231019-feature_ptp_netnext-v6-0-71affc27b0e5@bootlin.com

Changes in v6:
- Few fixes from the reviews.
- Replace the allowlist to default_timestamp flag to know which phy is
  using old API behavior.
- Rename the timestamping layer enum values.
- Move to a simple enum instead of the mix between enum and bitfield.
- Update ts_info and ts-set in software timestamping case.

Changes in v5:
- Update to ndo_hwstamp_get/set. This bring several new patches.
- Add few patches to make the glue.
- Convert macb to ndo_hwstamp_get/set.
- Add netlink specs description of new ethtool commands.
- Removed netdev notifier.
- Split the patches that expose the timestamping to userspace to separate
  the core and ethtool development.
- Add description of software timestamping.
- Convert PHYs hwtstamp callback to use kernel_hwtstamp_config.

Changes in v4:
- Move on to ethtool netlink instead of ioctl.
- Add a netdev notifier to allow packet trapping by the MAC in case of PHY
  time stamping.
- Add a PHY whitelist to not break the old PHY default time-stamping
  preference API.

Changes in v3:
- Expose the PTP choice to ethtool instead of sysfs.
  You can test it with the ethtool source on branch feature_ptp of:
  https://github.com/kmaincent/ethtool
- Added a devicetree binding to select the preferred timestamp.

Changes in v2:
- Move selected_timestamping_layer variable of the concerned patch.
- Use sysfs_streq instead of strmcmp.
- Use the PHY timestamp only if available.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (14):
      net_tstamp: Add TIMESTAMPING SOFTWARE and HARDWARE mask
      net: Move dev_set_hwtstamp_phylib to net/core/dev.h
      net: Make dev_get_hwtstamp_phylib accessible
      net: Make net_hwtstamp_validate accessible
      net: Change the API of PHY default timestamp to MAC
      net: net_tstamp: Add unspec field to hwtstamp_source enumeration
      net: Add struct kernel_ethtool_ts_info
      ptp: Add phc source and helpers to register specific PTP clock or get information
      net: Add the possibility to support a selected hwtstamp in netdevice
      net: netdevsim: ptp_mock: Convert to netdev_ptp_clock_register
      net: macb: Convert to netdev_ptp_clock_register
      net: ptp: Move ptp_clock_index() to builtin symbol
      net: ethtool: tsinfo: Add support for hwtstamp provider and get/set hwtstamp config
      netlink: specs: tsinfo: Enhance netlink attributes and add a set command

 Documentation/netlink/specs/ethtool.yaml           |  43 +-
 Documentation/networking/ethtool-netlink.rst       |  38 +-
 Documentation/networking/timestamping.rst          |  35 +-
 drivers/net/bonding/bond_main.c                    |   4 +-
 drivers/net/can/dev/dev.c                          |   2 +-
 drivers/net/can/peak_canfd/peak_canfd.c            |   2 +-
 drivers/net/can/usb/gs_usb.c                       |   2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |   2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h       |   2 +-
 drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c    |   2 +-
 drivers/net/dsa/hirschmann/hellcreek_hwtstamp.h    |   2 +-
 drivers/net/dsa/microchip/ksz_ptp.c                |   2 +-
 drivers/net/dsa/microchip/ksz_ptp.h                |   2 +-
 drivers/net/dsa/mv88e6xxx/hwtstamp.c               |   2 +-
 drivers/net/dsa/mv88e6xxx/hwtstamp.h               |   4 +-
 drivers/net/dsa/ocelot/felix.c                     |   2 +-
 drivers/net/dsa/sja1105/sja1105_ptp.c              |   2 +-
 drivers/net/dsa/sja1105/sja1105_ptp.h              |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c       |   2 +-
 .../net/ethernet/aquantia/atlantic/aq_ethtool.c    |   2 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   2 +-
 drivers/net/ethernet/broadcom/tg3.c                |   2 +-
 drivers/net/ethernet/cadence/macb.h                |   2 +-
 drivers/net/ethernet/cadence/macb_main.c           |   4 +-
 drivers/net/ethernet/cadence/macb_ptp.c            |   2 +-
 drivers/net/ethernet/cavium/liquidio/lio_ethtool.c |   2 +-
 .../net/ethernet/cavium/thunder/nicvf_ethtool.c    |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c |   2 +-
 drivers/net/ethernet/cisco/enic/enic_ethtool.c     |   2 +-
 drivers/net/ethernet/engleder/tsnep_ethtool.c      |   2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |   2 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-ethtool.c   |   2 +-
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   |   2 +-
 drivers/net/ethernet/freescale/fec_main.c          |   2 +-
 drivers/net/ethernet/freescale/gianfar_ethtool.c   |   2 +-
 .../net/ethernet/fungible/funeth/funeth_ethtool.c  |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.h |   2 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c        |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |   2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |   2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |   2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |   2 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   4 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ethtool.c    |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |   2 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_ethtool.c |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c |   4 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h |  10 +-
 drivers/net/ethernet/microchip/lan743x_ethtool.c   |   2 +-
 .../ethernet/microchip/lan966x/lan966x_ethtool.c   |   2 +-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |   2 +-
 drivers/net/ethernet/mscc/ocelot_net.c             |   2 +-
 drivers/net/ethernet/mscc/ocelot_ptp.c             |   2 +-
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |   2 +-
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |   2 +-
 drivers/net/ethernet/qlogic/qede/qede_ptp.c        |   2 +-
 drivers/net/ethernet/qlogic/qede/qede_ptp.h        |   2 +-
 drivers/net/ethernet/renesas/ravb_main.c           |   2 +-
 drivers/net/ethernet/renesas/rswitch.c             |   2 +-
 drivers/net/ethernet/sfc/ethtool.c                 |   2 +-
 drivers/net/ethernet/sfc/falcon/nic.h              |   2 +-
 drivers/net/ethernet/sfc/ptp.c                     |   2 +-
 drivers/net/ethernet/sfc/ptp.h                     |   5 +-
 drivers/net/ethernet/sfc/siena/ethtool.c           |   2 +-
 drivers/net/ethernet/sfc/siena/ptp.c               |   2 +-
 drivers/net/ethernet/sfc/siena/ptp.h               |   4 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   2 +-
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c        |   2 +-
 drivers/net/ethernet/ti/cpsw_ethtool.c             |   4 +-
 drivers/net/ethernet/ti/cpsw_priv.h                |   2 +-
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c      |   2 +-
 drivers/net/ethernet/ti/netcp_ethss.c              |   4 +-
 drivers/net/ethernet/xscale/ixp4xx_eth.c           |   2 +-
 drivers/net/macvlan.c                              |   2 +-
 drivers/net/netdevsim/ethtool.c                    |   2 +-
 drivers/net/netdevsim/netdev.c                     |  19 +-
 drivers/net/phy/bcm-phy-ptp.c                      |   5 +-
 drivers/net/phy/dp83640.c                          |   4 +-
 drivers/net/phy/micrel.c                           |  10 +-
 drivers/net/phy/mscc/mscc_ptp.c                    |   5 +-
 drivers/net/phy/nxp-c45-tja11xx.c                  |   5 +-
 drivers/net/phy/phy_device.c                       |  11 +
 drivers/ptp/Makefile                               |   5 +
 drivers/ptp/ptp_clock.c                            |  39 +-
 drivers/ptp/ptp_clock_consumer.c                   | 172 ++++++
 drivers/ptp/ptp_ines.c                             |   2 +-
 drivers/ptp/ptp_mock.c                             |   4 +-
 drivers/ptp/ptp_private.h                          |   7 +
 drivers/s390/net/qeth_ethtool.c                    |   2 +-
 include/linux/can/dev.h                            |   2 +-
 include/linux/ethtool.h                            |  29 +-
 include/linux/mii_timestamper.h                    |   2 +-
 include/linux/net_tstamp.h                         |  16 +
 include/linux/netdevice.h                          |   8 +-
 include/linux/phy.h                                |  21 +-
 include/linux/ptp_clock_kernel.h                   | 178 ++++++
 include/linux/ptp_mock.h                           |   4 +-
 include/net/dsa.h                                  |   2 +-
 include/soc/mscc/ocelot.h                          |   2 +-
 include/uapi/linux/ethtool_netlink.h               |  14 +
 include/uapi/linux/net_tstamp.h                    |  11 +
 net/8021q/vlan_dev.c                               |   2 +-
 net/core/dev.h                                     |   7 +
 net/core/dev_ioctl.c                               |  56 +-
 net/core/timestamping.c                            |  49 +-
 net/dsa/user.c                                     |   2 +-
 net/ethtool/common.c                               |  40 +-
 net/ethtool/common.h                               |   5 +-
 net/ethtool/ioctl.c                                |  14 +-
 net/ethtool/netlink.c                              |  16 +-
 net/ethtool/netlink.h                              |   6 +-
 net/ethtool/tsinfo.c                               | 641 ++++++++++++++++++++-
 net/sched/sch_taprio.c                             |   2 +-
 122 files changed, 1521 insertions(+), 203 deletions(-)
---
base-commit: bbf3aebfc018abc1c99be01fb68930cdcd7dd59e
change-id: 20231011-feature_ptp_netnext-3f278578e84b

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


