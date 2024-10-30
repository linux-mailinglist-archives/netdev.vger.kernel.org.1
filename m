Return-Path: <netdev+bounces-140387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B03C9B64DC
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 14:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC7EBB2219B
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7D71EBFFD;
	Wed, 30 Oct 2024 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RaH471zt"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B1113FEE;
	Wed, 30 Oct 2024 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296513; cv=none; b=TZ5jvja/g0fERsGhca/oz8pYol5t6lShO3LfDlC6SvH1i605GIuevsicr57AWnuB8ZCChcVPEiOgwPAnjqy+5OxJOAWLIiQxrqNlgxYLiYV+QaCNtNTAgc5UEtVal9eXmI3PK9U+NZcXjkxxJ2OJG5jqDR1x0IfEsqW2YqbO0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296513; c=relaxed/simple;
	bh=TXrFoqiLIVQIm9dtPctzF9SKQnoSn+OVC4M4CCMrhB0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ti4y6lE99rTdslTVWM5N3SIQY+BzpCAcq7I1ZODDOD8BQ1+3sqvQWK2z2WBhvwtpwL87HOlnPiEoPm72T99xUYpaNOJ4C8RDSEuuQ5VCkIoZ9tm5iRkfmEbVDwZwTSAxTrFDM7qUYaUqcXtM67PhQr54Lk9hjcR0eIKMcWAKlfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RaH471zt; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 664A81C0010;
	Wed, 30 Oct 2024 13:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730296501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JmPbpWhdpXF+y4ZSTK549aUGaPsOlGl6m9rI7bDobw0=;
	b=RaH471ztX/rSBP8dwI04RvvW9KXD4zzhCLeQtr4HgA+VnZDrLx2Jv6x2GeuvJvft6TnGTE
	yvloTWKkqrqS5LiqHKEZCufEXXmDB2huVVfWKGhgFXI79rDgDFLIEbDvnRk44724C2t2Rt
	V5gY5YuQ3d5IHB0a7UlcPy6CTTonRBlJhMtlCGqAifq8Kf3d2/K15cpAQmbpKyhcRiMUCl
	ZqBOP84YUJGlyyyDKVlIktUmacGh37WKeQwFZpkmdRv1IaCYAkkxg2mudbmWuC3Rcxz4g6
	3xUhMAZk76fkeD9W10AAfq4s0Vr55zpx+kPgG5i0dkyAlKIkBB7aYE+Qt/5zUA==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v19 00/10] net: Make timestamping selectable
Date: Wed, 30 Oct 2024 14:54:42 +0100
Message-Id: <20241030-feature_ptp_netnext-v19-0-94f8aadc9d5c@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKM6ImcC/43TzYrcMAwA4FcZct4US5H801PfoyyLncjdQJsMm
 XTYZZl3rzK0JMvY0GNs+YslSx/NRZZRLs3X00ezyHW8jPOkHxCeTk3/Gqcf0o6DLjRosAMD0Ga
 J6+9FXs7r+WWSdZK3te0yOs/Oi6fU6MnzInl8u7PfGw1qt6jmWXdex8s6L+/3/13tff+vHIry1
 bamdRBz7tElI/wtzfP6c5y+9POvu3h1uwJAZcWpQg7FucAgZB4V/08hg2DLileFwWTCTEQ5PSr
 hoGBFCdtdmC0AU8gIjwqYnSFTKQwYdUyOKJF7H2IoOHBwECsOqJNBE4KMEQZfcPDgdKbioDrYc
 0ZKNgaggtPtDmMtr04dK0OkgTQ9ygWHdseaypNrK2jnuGSzFQ0ovTnwwYFafVidhNF4i6xcV3D
 s7jjDFWfrZB4ccKfF0fwLjjs6tfpsvRwlJh8GSkifJ+Lp9D/HE3fgMptBX7xwjX0WQKeq4mzDI
 EMgn7tkvXefndvt9geA2ixEXAQAAA==
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

Changes in v19:
- Rebase on net-next
- Link to v18: https://lore.kernel.org/r/20241023-feature_ptp_netnext-v18-0-ed948f3b6887@bootlin.com

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
base-commit: 3c3db3a945f183e4e2693a730305d8a77473bdbd
change-id: 20231011-feature_ptp_netnext-3f278578e84b

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


