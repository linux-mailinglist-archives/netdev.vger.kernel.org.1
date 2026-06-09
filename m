Return-Path: <netdev+bounces-297120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fZRNCgg4KGp4AQMAu9opvQ
	(envelope-from <netdev+bounces-297120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:58:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E728662110
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:57:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=g+KlIphO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297120-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297120-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B30DF3062AAB
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7987237E308;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550A11AA7A6;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018889; cv=none; b=YW/zBzFFEuPpSJNePj600VonR/sL8ZfuOKBY/9mRZi88uXUQG62EdHGK4JkhxHeeNX6xYvp01PBaAblc9Glr/O7RlDBfWzwCCuClEgZQlToAilDWn6gy7XtSRWFjQc4K2YfwoeDUAT2kPSpCMQOaAICy3smORtgYpw2ymg+TOPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018889; c=relaxed/simple;
	bh=uTSgo2Hade6Jh/MPlBgc5FQy3Tx8XXA5YulUFieVPjM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UYXlWGEK1WayZmBj0werJHmCRXUCBGiFa/ZrHxCx09ClD1WrH2QlLkOpa4Xk+m8lzOCu2E4laD6Y5O6hJvJsO4Fx/pBk27L7C7ECTfHoGbcCHLxCkmeMxz5covPkfAo4iMAxBp8/9tZ09U9wfjcXp4MVi2F4zQiVC3xbtQKRH0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+KlIphO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B3A4C2BCB4;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781018889;
	bh=uTSgo2Hade6Jh/MPlBgc5FQy3Tx8XXA5YulUFieVPjM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=g+KlIphOzDHYTokstbBZ20/mw8pAcVRoMzNZjB6X/qNYrGGwpqQK4wM40zqXZzxMh
	 rePTv4n0Po0mSAhhxwpjxg6zNXbjPI1trArfPG41JhF/EBS3KVCe16EOGFjDLVt46O
	 3yeh+48p4HkhRiZ2ZCL7YrMjD5ue54Hgy4D0FNkJrzlxcPmbzNww13Ad/o15LAwgFW
	 y1hJUwtcrsNMX2RsfSleEqYH8eEZwpkscCXCMpZrDWwPbt65nxRSOqJXqLRkfNiq/o
	 L0UVKiZpVd+j5KmYA4Fe93jSEF/P+p5FOW2yjOkn1V1C2Se9ekewQ4J244eQnmUXzc
	 uUzYShx9QXVpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2115CD8CB9;
	Tue,  9 Jun 2026 15:28:08 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Subject: [PATCH net-next v4 00/13] net: Add ADIN1140 support
Date: Tue, 09 Jun 2026 18:27:59 +0300
Message-Id: <20260609-adin1140-driver-v4-0-0753e28ee004@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP8wKGoC/2XPTQrCMBAF4KuUrI0kmfTPlfcQF2lm2gY0lbSES
 undDdmodDePx3zDbGym4Ghml2JjgaKb3eRT0KeC2dH4gbjDlJkSqhJatdyg81JqwTG4SIG3YEg
 g1BXIhqWtV6DerVm8MU8L97Qu7J6a0c3LFN75VJS5z2op4KBGydOMQoNFbJpeXI03j2k42+mZs
 ah+AFUfAZUAqKm0DWoS5gjAF0ifHQFIQInUYQeyBqv/gH3fP/i+Lq07AQAA
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
 Ciprian Regus <ciprian.regus@analog.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781018886; l=7215;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=uTSgo2Hade6Jh/MPlBgc5FQy3Tx8XXA5YulUFieVPjM=;
 b=lpraPxnBK11u3SvsfywV/YSzB11DCsePuzIggYV1U5Uw14QcnyqnKqDJASQ0zsZCZUrEyZFTk
 BgW5ZsUw3UWB7DxGVNdgFUTFLUU9r6TNgV0yAJixLQVpCWv+j5hl+BW
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297120-lists,netdev=lfdr.de,ciprian.regus.analog.com];
	FORGED_RECIPIENTS(0.00)[m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:devicetree@vger.kernel.org,m:ciprian.regus@analog.com,m:conor.dooley@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[ciprian.regus@analog.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,analog.com:replyto,analog.com:email,analog.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E728662110

This series introduces support for the ADIN1140 (also called AD3306)
10BASE-T1S single port MACPHY. The device integrates the MAC and PHY in
the same package. The communication with the host CPU is done through an
SPI interface, using the Open Alliance TC6 protocol for control and data
transactions. As a result, the oa_tc6 framework is used to implement
the communication with the device (register accesses and Ethernet frame
RX/TX).

The MAC and PHY are connected internally using an MII and MDIO bus.

The PHY is a half duplex 10Mbps device, which implements both the PLCA
RS (IEEE 802.3 clause 148) and CSMA/CD methods of accessing the Ethernet
medium. The 10BASE-T1S standard allows multiple PHY devices to be
connected (in parallel) on the same single twisted pair network segment,
so PLCA can be configured in order to provide a fair access scheme to
all the nodes and reduce the jitter introduced by the unordered CSMA/CD
transmits. The PHY's internal register map can be accessed using the
direct MDIO mode of the OA TC6. The control, status, phy id 1 & 2 C22
registers are mapped to the 0xFF00 - 0xFF03 range. As for C45
addressable devices, the PHY has PCS, PMA and PLCA blocks.

The oa_tc6 framework patches are changes that would make the library
usable by the subsequent ADIN1140 MAC driver.

The protected mode patch is required because the ADIN1140 only allows
protected mode OA TC6 control transactions, which the oa_tc6 framework
doesn't currently implement.

The OA_TC6_BROKEN_PHY quirk patch is required in order to allow the MAC
driver to have a custom implementation for the mii_bus access methods as a
workaround for hardware issues:

1. The OA TC6 standard defines the direct and indirect access modes for
   MDIO transactions. The ADIN1140 incorrectly advertises indirect mode
   only (supported capabilities register - 0x2, bit 9), while actually
   implementing just the direct mode. We cannot rely on the CAP register
   to choose an access method (which oa_tc6 does by default, even though
   it only implements the direct mode), so the driver has to use its
   own.
2. The ADIN1140 cannot access the C22 register space of the internal
   PHY, while the PHY is busy receiving frames. If that happens, the
   CONFIG0 and CONFIG2 registers of the MAC will get corrupted and the
   data transfer will stop. Those two registers configure settings for
   the transfer protocol between the MAC and host, so the value for some
   of their subfields shouldn't be changed while the netdev is up.
   Since we know the PHY is internal, the MAC driver can implement a
   custom mii_bus, which can intercept C22 accesses. Most of the
   registers mapped in the 0x0 - 0x3 range (the only ones the PHY offers)
   are read only, and their value can be read from somewhere else (e.g
   the PHYID 1 & 2 have the same value as 0x1 in the MAC memory map).
   C45 accesses do not cause this issue, so we can properly implement
   them.

Even though they have different driver, the MAC one cannot function
without the PHY driver, since the PHY is not compatible with the generic
c22 driver. As such CONFIG_ADIN1140 selects CONFIG_ADIN1140_PHY.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
Changes in v4:
- Renamed the dt bindings file after the adi,ad3306 compatible.
- Renamed a few register address macros to match the OA TC6 standard and
  the ADIN1140 reference manual.
- Link to v3: https://lore.kernel.org/r/20260604-adin1140-driver-v3-0-5debdb3173c4@analog.com

Changes in v3:
- Added adi,ad3306 as a fallback compatible in the DT schema.
- Keep the current spi_device and net_device parameters for
  oa_tc6_init() and add a new struct parameter for passing the quirk
  flags, insted of changing the function to take a single config
  parameter.
- Add the oa_tc6_write_register_mms() and oa_tc6_read_register_mms()
  functions instead of defining a new macro for MMS and register address
  formatting.
- Split the OA TC6 register address macro exports patch into two
  different commits (export + rename).
- Use the devres API for mii_bus and net_device management in the
  ADIN1140 driver.
- Fix a bug related to the destination MAC filter mask in the ADIN1140
  driver.
- Link to v2: https://lore.kernel.org/r/20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com

Changes in v2:
- Add the OA_TC6_BROKEN_PHY quirk flag to the oa_tc6 framework in order
  to allow ethernet drivers to manage their own mii_bus struct and PHY.
- Move the OA TC6 standard register definitions in the oa_tc6.h header
  so other drivers can use them. Do the same for the C45 access
  functions
- Add the genphy_read_mmd_c45 and genphy_write_mmd_c45 functions to
  genphy, which allow drivers that have been discovered over C22 to make
  direct C45 operations, without using the 0xD and 0xE register. The
  change was implemented based on the suggestion in this thread:
  https://lore.kernel.org/all/CY8PR02MB9249CDA8F2C560FDD0F662D883382@CY8PR02MB9249.namprd02.prod.outlook.com/
- Link to v1: https://lore.kernel.org/r/20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com

---
Ciprian Regus (13):
      dt-bindings: net: Add ADIN1140
      net: ethernet: oa_tc6: Handle the OA TC6 SPI protected mode
      net: ethernet: oa_tc6: add OA_TC6_BROKEN_PHY quirk flag
      net: ethernet: oa_tc6: Export the C45 access functions
      net: ethernet: oa_tc6: Export standard defined registers
      net: ethernet: oa_tc6: Add the OA_TC6_ prefix to standard registers
      net: ethernet: oa_tc6: Add read_mms/write_mms register access functions
      net: ethernet: oa_tc6: Use the read_mms/write_mms functions for C45
      net: ethernet: oa_tc6: Add new register address defines
      net: phy: add generic helpers for direct C45 MMD access
      net: phy: microchip-t1s: use generic C45 MMD access helpers
      net: phy: Add support for the ADIN1140 PHY
      net: ethernet: adi: Add a driver for the ADIN1140 MACPHY

 .../devicetree/bindings/net/adi,ad3306.yaml        |  71 ++
 Documentation/networking/oa-tc6-framework.rst      |   3 +-
 MAINTAINERS                                        |  15 +
 drivers/net/ethernet/adi/Kconfig                   |  12 +
 drivers/net/ethernet/adi/Makefile                  |   1 +
 drivers/net/ethernet/adi/adin1140.c                | 815 +++++++++++++++++++++
 drivers/net/ethernet/microchip/lan865x/lan865x.c   |   2 +-
 drivers/net/ethernet/oa_tc6.c                      | 259 ++++---
 drivers/net/phy/Kconfig                            |   6 +
 drivers/net/phy/Makefile                           |   1 +
 drivers/net/phy/adin1140-phy.c                     |  72 ++
 drivers/net/phy/microchip_t1s.c                    |  32 +-
 drivers/net/phy/phy_device.c                       |  25 +
 include/linux/oa_tc6.h                             |  71 +-
 include/linux/phy.h                                |   3 +
 15 files changed, 1261 insertions(+), 127 deletions(-)
---
base-commit: 9415471e01c1aaac43daa6af3a261dc0c6c3a47c
change-id: 20260429-adin1140-driver-93ae0d376318

Best regards,
-- 
Ciprian Regus <ciprian.regus@analog.com>



