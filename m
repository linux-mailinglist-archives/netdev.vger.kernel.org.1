Return-Path: <netdev+bounces-151456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A19699EF46A
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F18A29184B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553BA22488E;
	Thu, 12 Dec 2024 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EoZA0xCG"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4324222D70;
	Thu, 12 Dec 2024 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023229; cv=none; b=GrP+Tpyp7VZj+UHf1TMkkqV+I+uOwhIxRFH/zwHU3cWI0OoW/G72Gtej73+kKlpONDqmmSF3MYnO6rar91wD5T8HRiu7Ls3ch3/GL0Ez4SYoiPgxr5j35loTsmCdrPX9y3BK6evUWE9Ew6r/zKmJlLKNpDJ0kCs1jSpr+WVc9fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023229; c=relaxed/simple;
	bh=mrbsSfzzdrjZLFoo6AOqR/m3Q7W9E+09S4uegpejTvA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iXxI4cooi8xsDT+2/texyHsLLXc8cyUm34vA8fHS2ANS79jRVfWw8eZ8MQlyHt7NJ1oz4P3G+F81VMFpkQVPw3LlYUKix5PH0dTAuneO4lWDarTaqI1ibYs+QRKkzCJAFxuGOJFvMnRxety/UIv67w+kNoBY/rQbauI4bp4T+5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EoZA0xCG; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9ACDA60008;
	Thu, 12 Dec 2024 17:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734023217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aZ+4Lfpaoq0nYVwzO63U+vFepVJ9Vk8hGhOKzN3e23U=;
	b=EoZA0xCG4zmyVFYDi8leukZ45ekChFA7CZ3qaho8oZAktEJo1hSv9zJd/2O6OlRQJhGuJS
	OvIWEwRW35ZJ0DJN8uzHv/ViulPhoBe3B8ZutnY7FdmdCDL3n5lAIx5jx7adlUjXPkU+Y/
	JII57KnnHQ2KvR4UhRaR++6MsKJZ7YQt1HhlzSUiGtVjPC6COc9Oua/nJkl5jq6vcce4F0
	yBEHOQT23WKAftHGY3HKAPzNwSdld2di5kQj3P2KF+kedEOyVo1re+uXv4qo3wVCypCEDm
	86ZuZZ6ayZAtYvTZ/BeePNDwNk5e9kcBk+LEmb5PdHvPVfV8MHc7nHskb3Blpg==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v21 0/5] net: Make timestamping selectable
Date: Thu, 12 Dec 2024 18:06:40 +0100
Message-Id: <20241212-feature_ptp_netnext-v21-0-2c282a941518@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACAYW2cC/43T24rbMBAA0F8Jfl4XzWhGlz71P8qySJbUNbR2c
 Nywy5J/7zi02G0k6KN1OdbcPrpLXsZ86T6fProlX8fLOE/ygfB06obXMH3L/ZhkoUOFGhRAX3J
 Yfy755byeX6a8Tvlt7XVB69i67Ch2cvO85DK+3dmvnRzqt1Pds+y8jpd1Xt7v/7ua+/5v2Vflq
 +lVbyGUMqCNKvOXOM/r93H6NMw/7uLV7goA1RUrClnM1nqGTOpRcX8UUgimrjhRGFQhLERU4qP
 iDwo2FL+9hdkAMPmC8KiA2hlSjcSAEkeVgDnw4HzwFQcODmLDAXEKSEBQMEByFQcPjlYNB8XBg
 QtSNMEDVRy9O4ytuLQ4JqdAiSQ8KhWHdseoRsmlFaRzbDTFZDlQqznwwYFWfliciEE5gyycrjh
 md6zihrN1MicLrCU5En/FsUenlZ+tl0MO0flEEenviXg6/c/1yBpsYZWk4pVn7LMAMlUNZxuGn
 Dy5oqNxzlYcf3CabbONg6fiQkiDTzw8OriPA2Cr3LiNg4/J+zS44Mw/77ndbr8As+DJzOwEAAA
 =
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

Here is few netlink spec usage examples:
./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema
             --dump tsinfo-get
             --json '{"header":{"dev-name":"eth0"}}'
[{'header': {'dev-index': 3, 'dev-name': 'eth0'},
  'hwtst-provider': {'index': 0, 'qualifier': 0},
  'phc-index': 0,
  'rx-filters': {'bits': {'bit': [{'index': 0, 'name': 'none'},
                                  {'index': 2, 'name': 'some'}]},
                 'nomask': True,
                 'size': 16},
  'timestamping': {'bits': {'bit': [{'index': 0, 'name': 'hardware-transmit'},
                                    {'index': 2, 'name': 'hardware-receive'},
                                    {'index': 6,
                                     'name': 'hardware-raw-clock'}]},
                   'nomask': True,
                   'size': 17},
  'tx-types': {'bits': {'bit': [{'index': 0, 'name': 'off'},
                                {'index': 1, 'name': 'on'}]},
               'nomask': True,
               'size': 4}},
 {'header': {'dev-index': 3, 'dev-name': 'eth0'},
  'hwtst-provider': {'index': 2, 'qualifier': 0},
  'phc-index': 2,
  'rx-filters': {'bits': {'bit': [{'index': 0, 'name': 'none'},
                                  {'index': 1, 'name': 'all'}]},
                 'nomask': True,
                 'size': 16},
  'timestamping': {'bits': {'bit': [{'index': 0, 'name': 'hardware-transmit'},
                                    {'index': 1, 'name': 'software-transmit'},
                                    {'index': 2, 'name': 'hardware-receive'},
                                    {'index': 3, 'name': 'software-receive'},
                                    {'index': 4,
                                     'name': 'software-system-clock'},
                                    {'index': 6,
                                     'name': 'hardware-raw-clock'}]},
                   'nomask': True,
                   'size': 17},
  'tx-types': {'bits': {'bit': [{'index': 0, 'name': 'off'},
                                {'index': 1, 'name': 'on'},
                                {'index': 2, 'name': 'onestep-sync'}]},
               'nomask': True,
               'size': 4}}]

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do tsinfo-get
             --json '{"header":{"dev-name":"eth0"},
                      "hwtst-provider":{"index":0, "qualifier":0 }
}'
{'header': {'dev-index': 3, 'dev-name': 'eth0'},
 'hwtst-provider': {'index': 0, 'qualifier': 0},
 'phc-index': 0,
 'rx-filters': {'bits': {'bit': [{'index': 0, 'name': 'none'},
                                 {'index': 2, 'name': 'some'}]},
                'nomask': True,
                'size': 16},
 'timestamping': {'bits': {'bit': [{'index': 0, 'name': 'hardware-transmit'},
                                   {'index': 2, 'name': 'hardware-receive'},
                                   {'index': 6, 'name': 'hardware-raw-clock'}]},
                  'nomask': True,
                  'size': 17},
 'tx-types': {'bits': {'bit': [{'index': 0, 'name': 'off'},
                               {'index': 1, 'name': 'on'}]},
              'nomask': True,
              'size': 4}}

./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do tsinfo-set
             --json '{"header":{"dev-name":"eth0"},
                      "hwtst-provider":{"index":2, "qualifier":0}}'
None
./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do tsconfig-get
	     --json '{"header":{"dev-name":"eth0"}}'
{'header': {'dev-index': 3, 'dev-name': 'eth0'},
 'hwtstamp-flags': 1,
 'hwtstamp-provider': {'index': 1, 'qualifier': 0},
 'rx-filters': {'bits': {'bit': [{'index': 12, 'name': 'ptpv2-event'}]},
                'nomask': True,
                'size': 16},
 'tx-types': {'bits': {'bit': [{'index': 1, 'name': 'on'}]},
              'nomask': True,
              'size': 4}}

 ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do tsconfig-set
	      --json '{"header":{"dev-name":"eth0"},
		       "hwtstamp-provider":{"index":1, "qualifier":0 },
		       "rx-filters":{"bits": {"bit": {"name":"ptpv2-l4-event"}},
				     "nomask": 1},
		       "tx-types":{"bits": {"bit": {"name":"on"}},
				   "nomask": 1}}'
{'header': {'dev-index': 3, 'dev-name': 'eth0'},
 'hwtstamp-flags': 1,
 'hwtstamp-provider': {'index': 1, 'qualifier': 0},
 'rx-filters': {'bits': {'bit': [{'index': 12, 'name': 'ptpv2-event'}]},
                'nomask': True,
                'size': 16},
 'tx-types': {'bits': {'bit': [{'index': 1, 'name': 'on'}]},
              'nomask': True,
              'size': 4}}

Changes in v21:
- NIT fixes.
- Link to v20: https://lore.kernel.org/r/20241204-feature_ptp_netnext-v20-0-9bd99dc8a867@bootlin.com

Changes in v20:
- Change hwtstamp provider design to avoid saving "user" (phy or net) in
  the ptp clock structure.
- Link to v19: https://lore.kernel.org/r/20241030-feature_ptp_netnext-v19-0-94f8aadc9d5c@bootlin.com

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
Kory Maincent (5):
      net: Make dev_get_hwtstamp_phylib accessible
      net: Make net_hwtstamp_validate accessible
      net: Add the possibility to support a selected hwtstamp in netdevice
      net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology
      net: ethtool: Add support for tsconfig command to get/set hwtstamp config

 Documentation/netlink/specs/ethtool.yaml       |  76 +++++
 Documentation/networking/ethtool-netlink.rst   |  82 ++++-
 Documentation/networking/timestamping.rst      |  38 ++-
 drivers/net/phy/phy_device.c                   |  10 +
 include/linux/ethtool.h                        |   4 +
 include/linux/net_tstamp.h                     |  29 ++
 include/linux/netdevice.h                      |   4 +
 include/uapi/linux/ethtool_netlink_generated.h |  26 ++
 include/uapi/linux/net_tstamp.h                |  11 +
 net/core/dev.h                                 |   3 +
 net/core/dev_ioctl.c                           |  47 ++-
 net/core/timestamping.c                        |  52 ++-
 net/ethtool/Makefile                           |   2 +-
 net/ethtool/common.c                           | 148 ++++++++-
 net/ethtool/common.h                           |  13 +
 net/ethtool/netlink.c                          |  24 +-
 net/ethtool/netlink.h                          |   8 +-
 net/ethtool/ts.h                               |  20 ++
 net/ethtool/tsconfig.c                         | 444 +++++++++++++++++++++++++
 net/ethtool/tsinfo.c                           | 358 +++++++++++++++++++-
 20 files changed, 1353 insertions(+), 46 deletions(-)
---
base-commit: 9e13d2515e0b19d56bce15410b8000cf2eef0d46
change-id: 20231011-feature_ptp_netnext-3f278578e84b

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


