Return-Path: <netdev+bounces-138332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861AC9ACF53
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA49286EBE
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB72D19F13C;
	Wed, 23 Oct 2024 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JTrmW0P8"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A29A76034;
	Wed, 23 Oct 2024 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698585; cv=none; b=Knd3Blofic35oSVxDZu+7LG/KQpV+HgUq5qQLg16lNHgQdbUA23sEWmHTcaXmaDu1aSW176M3sNMWL+Ylja27o3oywfFg8mzqDo+oCMxZD36XPSNWtB2N3sseia6g9XjidEhilKe5uTXyjJUsI8aG+Xj5lwOqRz/cqVjtdUoh0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698585; c=relaxed/simple;
	bh=nQkp4X0SskJmy396hgWjTbhxj1auWoh5R2fL5iB1SWs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kIOoN5CYRkLlxDEEwfmg3klU6+gAwjZWjJrXWtIgXvH0vMbFvALm0d0SG84nsaIPk+cQNYJXa12H2RdcriXSm0DuwEeZbP2X/uHTFRuBGZOUMYzO3I9QlzmfXgmLRRQ3TN7W5wB9mu3pyXTFqWJEGgUBgmGHDl2qIF1mePjSHcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JTrmW0P8; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4DBFA60004;
	Wed, 23 Oct 2024 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729698576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9Epff+s3t8AyDSv3wOXui8XJp8BHX2eTCs0L5dytWYk=;
	b=JTrmW0P8CrfS4v7jb5Iz248+E6qE22BoC3VVCWsHgt2qnF+8i1WpGRMmxCDk0ZWoTCcMfs
	IxxmwmjlDiQyRV32wSvD2mKVHFs5c8fuQf9sUIgK4VLOg5RHDFP9nd62+XLD4GMPyww8Mw
	aquQwEWFiVkliQHmA/WvlbBXvEY69a806G2AWSy1Jdwk8YJvth/jhE3xgJejcJNE8pPMoI
	gfrTTZOZOlkCwxC+GV5DTaeitgzTB5rhvXd2dIU/lEfqdxspXQ9kh+aY7mmdPeNeT5SFlC
	vMCeQA3eSc5oAq+TmqqxhjMtMCKH7K1ddyxFX9aEtGpkLwyTndVZQdxVzh5yTg==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v18 00/10] net: Make timestamping selectable
Date: Wed, 23 Oct 2024 17:49:10 +0200
Message-Id: <20241023-feature_ptp_netnext-v18-0-ed948f3b6887@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPYaGWcC/43T227bMAwA0F8J/FwPIk3qsqf9x1AUkk2tBlo7c
 LygRZF/HxO0sItIwB5lUUfixR/NSZZRTs3Pw0ezyHk8jfOkC/APh6Z/jtMfacdBPzRosAMD0Ga
 J699Fno7r8WmSdZK3te0yOs/Oi6fU6MnjInl8u7G/Gw1qr1HNo+48j6d1Xt5v953tbf9TDkX5b
 FvTOog59+iSEf6V5nl9Gacf/fx6E89uUwCorDhVyKE4FxiEzL3ivxQyCLaseFUYTCbMRJTTvRJ
 2ClaUcH0LswVgChnhXgGzMWQqhQGjjskRJXLvQwwFB3YOYsUBdTJoQpAxwuALDu6czlQcVAd7z
 kjJxgBUcLrNYazl1aljZYg0kKZHueDQ5lhTabmOgk6OSzZb0YBSz4F3DtTqw+okjMZbZOW6gmM
 3xxmuONdJ5sEBd1oczb/guL1Tq891lqPE5MNACen7H/Fw+J/jiTtwmc2gHf/+jMvl8g/y2T0xF
 AQAAA==
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
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
 donald.hunter@gmail.com, danieller@nvidia.com, ecree.xilinx@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Shannon Nelson <shannon.nelson@amd.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: kory.maincent@bootlin.com

Up until now, there was no way to let the user select the hardware
PTP provider at which time stamping occurs. The stack assumed that PHY time
stamping is always preferred, but some MAC/PHY combinations were buggy.

This series updates the default MAC/PHY default timestamping and aims to
allow the user to select the desired hwtstamp provider administratively.

The series is based on the following netlink spec and documentation patches:
https://lore.kernel.org/netdev/20241022151418.875424-1-kory.maincent@bootlin.com/
https://lore.kernel.org/netdev/20241023141559.100973-1-kory.maincent@bootlin.com/

Changes in v18:
- Few changes in the tsconfig-set ethtool command.
- Add tsconfig-set-reply ethtool netlink socket.
- Add missing netlink tsconfig documentation
- Link to v17: https://lore.kernel.org/r/20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com

Changes in v17:
- Fix a documentation nit.
- Add a missing kernel_ethtool_tsinfo update from a new MAC driver.
- Link to v16: https://lore.kernel.org/r/20240705-feature_ptp_netnext-v16-0-5d7153914052@bootlin.com

Changes in v16:
- Add a new patch to separate tsinfo into a new tsconfig command to get
  and set the hwtstamp config.
- Used call_rcu() instead of synchronize_rcu() to free the hwtstamp_provider
- Moved net core changes of patch 12 directly to patch 8.
- Link to v15: https://lore.kernel.org/r/20240612-feature_ptp_netnext-v15-0-b2a086257b63@bootlin.com

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
Kory Maincent (10):
      net: Make dev_get_hwtstamp_phylib accessible
      net: Make net_hwtstamp_validate accessible
      ptp: Add phc source and helpers to register specific PTP clock or get information
      net: Add the possibility to support a selected hwtstamp in netdevice
      net: netdevsim: ptp_mock: Convert to netdev_ptp_clock_register
      net: macb: Convert to netdev_ptp_clock_register
      net: ptp: Move ptp_clock_index() to builtin symbol
      net: ethtool: tsinfo: Add support for reading tsinfo for a specific hwtstamp provider
      net: ethtool: Add support for tsconfig command to get/set hwtstamp config
      netlink: specs: Enhance tsinfo netlink attributes and add a tsconfig set command

 Documentation/netlink/specs/ethtool.yaml     |  70 +++++
 Documentation/networking/ethtool-netlink.rst |  83 +++++-
 Documentation/networking/timestamping.rst    |  38 ++-
 drivers/net/ethernet/cadence/macb_ptp.c      |   2 +-
 drivers/net/netdevsim/netdev.c               |  19 +-
 drivers/net/phy/phy_device.c                 |  11 +
 drivers/ptp/Makefile                         |   5 +
 drivers/ptp/ptp_clock.c                      |  39 ++-
 drivers/ptp/ptp_clock_consumer.c             | 182 ++++++++++++
 drivers/ptp/ptp_mock.c                       |   4 +-
 drivers/ptp/ptp_private.h                    |   7 +
 include/linux/ethtool.h                      |   4 +
 include/linux/net_tstamp.h                   |  18 ++
 include/linux/netdevice.h                    |   5 +
 include/linux/ptp_clock_kernel.h             | 188 +++++++++++++
 include/linux/ptp_mock.h                     |   4 +-
 include/uapi/linux/ethtool_netlink.h         |  30 +-
 include/uapi/linux/net_tstamp.h              |  11 +
 net/core/dev.h                               |   3 +
 net/core/dev_ioctl.c                         |  49 +++-
 net/core/timestamping.c                      |  50 +++-
 net/ethtool/Makefile                         |   2 +-
 net/ethtool/common.c                         |  33 +++
 net/ethtool/common.h                         |   3 +
 net/ethtool/netlink.c                        |  26 +-
 net/ethtool/netlink.h                        |   8 +-
 net/ethtool/ts.h                             |  52 ++++
 net/ethtool/tsconfig.c                       | 406 +++++++++++++++++++++++++++
 net/ethtool/tsinfo.c                         | 239 +++++++++++++++-
 29 files changed, 1532 insertions(+), 59 deletions(-)
---
base-commit: 76a212bdb59ed3da084203356c0df41c4cabd428
change-id: 20231011-feature_ptp_netnext-3f278578e84b

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


