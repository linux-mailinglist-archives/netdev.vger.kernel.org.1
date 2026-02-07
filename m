Return-Path: <netdev+bounces-257709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZoAtFl2shmmKPwQAu9opvQ
	(envelope-from <netdev+bounces-257709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 04:07:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D09F104BE4
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 04:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C31B6301D6B0
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 03:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CF5332912;
	Sat,  7 Feb 2026 03:07:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80701305045;
	Sat,  7 Feb 2026 03:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770433626; cv=none; b=DFwbgxl8o3/bWqZlDa70NIQxjeAZabTZkTjA1B+ZaNbfPNXnaBABCAGEKM1KZ7WbhSVorNXicbUsYMAHoXUesfcirzskzVtZV+gNYtsxXY5VS23ZU5RjOYLOjCowCBtMHBmNc39FxmEleuUZ2ggKS5QeVSdVggqQbNm+2ZlYYAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770433626; c=relaxed/simple;
	bh=0cKh6UmDKC2OU1/w8TYi0/S8BBd1GG+NYHWpe22wCxg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k51l5OEdLmnB7wT80Zwp20mBXJtk08bWQTyfZxIvzZU+NSmltQK9HtVHhW2IeSQZv5EyLJOt9nmgI22lQytkfYBJCcDBNuSAI2Uv2jBnDR7E4pLzrBxHpI6NPVHMIGPakC4MOAa/Yzw+sE4bH0hM5t+xdoj4LyNWUkkhtSev5Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1voYes-000000003Yu-0IIG;
	Sat, 07 Feb 2026 03:06:54 +0000
Date: Sat, 7 Feb 2026 03:06:48 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>, John Crispin <john@phrozen.org>
Subject: [PATCH net-next v14 0/4] net: dsa: initial support for MaxLinear
 MxL862xx switches
Message-ID: <cover.1770433307.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-257709-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makrotopia.org:mid]
X-Rspamd-Queue-Id: 2D09F104BE4
X-Rspamd-Action: no action

This series adds very basic DSA support for the MaxLinear MxL86252
(5x 2500Base-T PHYs) and MxL86282 (8x 2500Base-T PHYs) switches.
In addition to the 2.5G TP ports both switches also come with two
SerDes interfaces which can be used either to connect external PHYs
or SFP cages, or as CPU port when using the switch with this DSA driver.

MxL862xx integrates a firmware running on an embedded processor (based on
Zephyr RTOS). Host interaction uses a simple netlink-like API transported
over MDIO/MMD.

This series includes only what's needed to pass traffic between user
ports and the CPU port: relayed MDIO to internal PHYs, basic port
enable/disable, and CPU-port special tagging.

The SerDes interface of the CPU port is automatically configured by the
switch after reset using a board-specific configuration stored together
with the firmware in the flash chip attached to the switch, so no action
is needed from the driver to setup the interface mode of the CPU port.

Also MAC settings of the PHY ports are automatically configured, which
means the driver works fine with phylink_mac_ops being all no-op stubs.

Multiple follow up series will bring support for setting up the other
SerDes PCS interface (ie. not used for the CPU port), bridge, VLAN, ...
offloading, and support for using an 802.1Q-based special tag instead of
the proprietary 8-byte tag.
---
basic DSA selftests were run, results:
 * no_forwarding.sh: all tests PASS
 * bridge_vlan_unaware.sh: all tests PASS
 * bridge_vlan_mcast.sh: all tests PASS
 * bridge_vlan_aware.sh: all tests PASS
 * local_termination.sh: all tests PASS or XFAIL, except for
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address   [FAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address, allmulti   [FAIL]
        reception succeeded, but should have failed

As obviously this is mostly testing the Linux software bridge at this
point so I didn't bother to run any of the FDB or MDB related tests.

Some mystery about the relationship between the sub-interface ID and CTP
port assignment remains for now, so I cannot yet fully explain the magic
numbers when calculating the two.
(Why is it neccesary to allocate 23 CTPs when using port 9 as CPU port
while there are at most 17 phyiscal interfaces in total, and only at
most 13 when using one of the two SerDes as CPU interface? Why is there
an offset of 16 when calculating the sub-interface ID? How will a total
of 17 ports be possibly represented in a 4-bit field in the tag RX
path?)

At this point this doesn't impact functionality, and I hope for further
clarification discussing all that with MaxLinear engineers.

I believe the initial driver is anyway in good shape now, a follow-up
series addressing configuring the SerDes interfaces will also have to
take care of CTP assignment and sub-interfaces to not hit the mentioned
4-bit cap in the tag driver.

Changes since v13:
Address comments from Jakub Kicinski

1/4 dt-bindings: net: dsa: add MaxLinear MxL862xx
 * no changes
2/4 net: dsa: add tag format for MxL862xx switches
 * Kconfig: fix Maxlinear -> MaxLinear, include vendor name in title
 * add comment clarifying perspective of term "ingress"
3/4 net: mdio: add unlocked mdiodev C45 bus accessors
 * no changes
4/4 net: dsa: add basic initial driver for MxL862xx switches
 * selectively use __packed only for structs which aren't always
   naturally packed in mxl862xx-api.h, drop '#pragma pack(push, 1)'
 * fix capitalisation Maxlinear -> MaxLinear

Changes since v12:
Address comments from Vladimir Oltean and add Reviewed-by:-tag given
by Russell King (Oracle).

1/4 dt-bindings: net: dsa: add MaxLinear MxL862xx
 * 'mdio' node is required
2/4 net: dsa: add tag format for MxL862xx switches
 * no changes
3/4 net: mdio: add unlocked mdiodev C45 bus accessors
 * add Russell's Reviewed-by:-tag given for v11
4/4 net: dsa: add basic initial driver for MxL862xx switches
 * use '#pragma pack(push, 1)' in mxl862xx-api.h
 * relax timeout in mxl862xx_busy_wait() from 10000us to 500000us, this
   turned out to be needed when using the driver on older firmware
 * reorder functions
 * remove unneeded checks for dp or cpu_dp being !=NULL, add comments

Changes since v11:
Address comments reported by Jakub Kicinski using netdev-ai
https://patchwork.kernel.org/comment/26767905/

1/4 dt-bindings: net: dsa: add MaxLinear MxL862xx
 * no changes
2/4 net: dsa: add tag format for MxL862xx switches
 * no changes
3/4 net: mdio: add unlocked mdiodev C45 bus accessors
 * no changes
4/4 net: dsa: add basic initial driver for MxL862xx switches
 * list switch variants in Kconfig starting with dash ('-')
 * remove the __packed attribute on structs which are
   naturally packed according to C rules (ie. one other struct
   with only a single byte-aligned member)
 * log error in mxl862xx_port_disable()
 * introduce !NULL check for return value of dsa_to_port() in
   mxl862xx_add_single_port_bridge
 * check cpu_dp being non-NULL before dereferencing dp->cpu_dp
 * use non-racy and deterministic name for MII bus
 * skip ports without cpu_dp assigned in mxl862xx_setup_cpu_bridge()
   to avoid potential NULL-pointer dereference
 * call dev_set_drvdata() only after dsa_register_switch() has been
   successfully completed

Changes since v10:
1/4 dt-bindings: net: dsa: add MaxLinear MxL862xx
 * no changes
2/4 net: dsa: add tag format for MxL862xx switches
 * arrange local variables in reverse xmas tree order (again)
 * use MXL862_NAME as .name in struct dsa_device_ops
3/4 net: mdio: add unlocked mdiodev C45 bus accessors
 * no changes
4/4 net: dsa: add basic initial driver for MxL862xx switches
 * fix fatal last-second changes dsa_port_is_unused vs. dsa_is_unused_port
   and dsa_port_is_unused vs. dsa_is_unused_port
 * use cpu_to_le16 in mxl862xx_configure_ctp_port
 * improve formatting of some kerneldoc comments

Changes since v9:
1/4 dt-bindings: net: dsa: add MaxLinear MxL862xx
 * add microcontroller port 0
2/4 net: dsa: add tag format for MxL862xx switches
 * count ports starting from 0
3/4 net: mdio: add unlocked mdiodev C45 bus accessors
 * no changes
4/4 net: dsa: add basic initial driver for MxL862xx switches
 * fix indentation in kernel-doc
 * remove misleading comment regarding sub-interface IDs
 * remove unused macros, set MXL862XX_MAX_PORTS to 17
 * count ports starting from 0, 0 being the microcontroller
 * improve port setup:
   - split tag protocol and CTP port assignment
   - use ports cpu_dp instead of relying on single (ie. first) CPU port
   - handle CPU port like any other port
   - prepare forward DT compatibility with multiple CPU ports

Changes since v8:
1/4 dt-bindings: net: dsa: add MaxLinear MxL862xx
 * no changes
2/4 net: dsa: add tag format for MxL862xx switches
 * no changes
3/4 net: mdio: add unlocked mdiodev C45 bus accessors
 * no changes
4/4 net: dsa: add basic initial driver for MxL862xx switches
 * remove practically unused struct hw_info
 * lots of kerneldoc improvements in mxl862xx-api.h
 * drop .mac_select_pcs() stub
 * better handling for firmware error return value
 * apply reverse xmas tree in mxl862xx_api_wrap
 * guard headers with #ifdef macro
 * include net/dsa.h and linux/mdio.h in mxl862xx.h
 * call mxl862xx_port_fast_age() only once in .port_setup
 * don't create isolation bridges for unused ports
 * replace errornous cast with correct range of values denoting firmware errors

Changes since v7
1/4 dt-bindings: net: dsa: add MaxLinear MxL862xx
 * no changes
2/4 net: dsa: add tag format for MxL862xx switches
 * no changes
3/4 net: mdio: add unlocked mdiodev C45 bus accessors
 * no changes
4/4 net: dsa: add basic initial driver for MxL862xx switches
 * use little-endian in bridge_port_config API
 * remove duplciate assignment of br_port_cfg.bridge_port_id when setting
   up CPU port

Changes since v6
1/4 dt-bindings: net: dsa: add MaxLinear MxL862xx
 * no changes
2/4 net: dsa: add tag format for MxL862xx switches
 * no changes
3/4 net: mdio: add unlocked mdiodev C45 bus accessors
 * no changes
4/4 net: dsa: add basic initial driver for MxL862xx switches
 * fix kerneldoc style

Changes since RFC v5
1/4 dt-bindings: net: dsa: add MaxLinear MxL862xx
 * no changes

2/4 net: dsa: add tag format for MxL862xx switches
 * remove unnecessary check for skb != NULL
 * merge consecutively printed warnings into single dev_warn_ratelimited

3/4 net: mdio: add unlocked mdiodev C45 bus accessors
 * no changes

4/4 net: dsa: add basic initial driver for MxL862xx switches
 * include bridge and bridgeport API needed to isolate ports
 * remove warning in .setup as ports are now isolated
 * make ready-after-reset check more robust by adding delay
 * sort structs in order of struct definitions
 * best effort to sort functions without introducing additional prototypes
 * always use enums with kerneldoc comments in mxl862xx-api.h
 * remove bogus .phy_read and .phy_write DSA ops as the driver anyway registers
   a user MDIO bus with Clause-22 and Clause-45 operations
 * various small style fixes

Changes since RFC v4
1/4 dt-bindings: net: dsa: add MaxLinear MxL862xx
 * no changes

2/4 net: dsa: add tag format for MxL862xx switches
 * drop unused precompiler macros

3/4 net: mdio: add unlocked mdiodev C45 bus accessors
 * fix indentation

4/4 net: dsa: add basic initial driver for MxL862xx switches
 * output warning in .setup regarding unknown pre-configuration
 * add comment explaining why CFGGET is used in reset function

Changes since RFC v3
1/4 dt-bindings: net: dsa: add MaxLinear MxL862xx
 * remove labels from example
 * remove 'bindings for' from commit title

2/4 net: dsa: add tag format for MxL862xx switches
 * describe fields and variables with comments
 * sub-interface is only 5 bits
 * harmonize Kconfig symbol name
 * maintain alphabetic order in Kconfig
 * fix typo s/beginnig/beginning/
 * fix typo s/swtiches/switches/
 * arrange local variables in reverse xmas tree order

3/4 net: mdio: add unlocked mdiodev C45 bus accessors
 * unchanged

4/4 net: dsa: add basic initial driver for MxL862xx switches
 * poll switch readiness after reset
 * implement driver shutdown
 * added port_fast_aging API call and driver op
 * unified port setup in new .port_setup op
 * improve comment explaining special handlign for unaligned API read
 * various typos and formatting improvements

Changes since RFC v2
1/4, 2/4, 3/4: unchanged

4/4 net: dsa: add basic initial driver for MxL862xx switches
 * fix return value being uninitialized on error in mxl862xx_api_wrap()
 * add missing description in kerneldoc comment of
   struct mxl862xx_ss_sp_tag

Changes since initial RFC

1/4 dt-bindings: net: dsa: add bindings for MaxLinear MxL862xx
 * better description in dt-bindings doc

2/4 net: dsa: add tag formats for MxL862xx switches
 * make sure all tag fields are initialized

3/4 net: mdio: add unlocked mdiodev C45 bus accessors
 * new patch

4/4 net: dsa: add basic initial driver for MxL862xx switches
 * make use of struct mdio_device
 * add phylink_mac_ops stubs
 * drop leftover nonsense from mxl862xx_phylink_get_caps()
 * fix endian conversions
 * use __le32 instead of enum types in over-the-wire structs
 * use existing MDIO_* macros whenever possible
 * simplify API constants to be more readable
 * use readx_poll_timeout instead of open-coding poll timeout loop
 * add mxl862xx_reg_read() and mxl862xx_reg_write() helpers
 * demystify error codes returned by the firmware
 * add #defines for mxl862xx_ss_sp_tag member values
 * move reset to dedicated function, clarify magic number being the
   reset command ID

Daniel Golle (4):
  dt-bindings: net: dsa: add MaxLinear MxL862xx
  net: dsa: add tag format for MxL862xx switches
  net: mdio: add unlocked mdiodev C45 bus accessors
  net: dsa: add basic initial driver for MxL862xx switches

 .../bindings/net/dsa/maxlinear,mxl862xx.yaml  | 161 +++++
 MAINTAINERS                                   |   8 +
 drivers/net/dsa/Kconfig                       |   2 +
 drivers/net/dsa/Makefile                      |   1 +
 drivers/net/dsa/mxl862xx/Kconfig              |  12 +
 drivers/net/dsa/mxl862xx/Makefile             |   3 +
 drivers/net/dsa/mxl862xx/mxl862xx-api.h       | 675 ++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h       |  49 ++
 drivers/net/dsa/mxl862xx/mxl862xx-host.c      | 245 +++++++
 drivers/net/dsa/mxl862xx/mxl862xx-host.h      |  12 +
 drivers/net/dsa/mxl862xx/mxl862xx.c           | 476 ++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx.h           |  16 +
 include/linux/mdio.h                          |  13 +
 include/net/dsa.h                             |   2 +
 net/dsa/Kconfig                               |   7 +
 net/dsa/Makefile                              |   1 +
 net/dsa/tag_mxl862xx.c                        | 110 +++
 17 files changed, 1793 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml
 create mode 100644 drivers/net/dsa/mxl862xx/Kconfig
 create mode 100644 drivers/net/dsa/mxl862xx/Makefile
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-api.h
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-host.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-host.h
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx.h
 create mode 100644 net/dsa/tag_mxl862xx.c

-- 
2.52.0

