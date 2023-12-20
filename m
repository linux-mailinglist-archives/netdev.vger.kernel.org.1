Return-Path: <netdev+bounces-59273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA5281A33E
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB431F25E76
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844F641741;
	Wed, 20 Dec 2023 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owaaY3W5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6947C41228
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFCFC433C7;
	Wed, 20 Dec 2023 15:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703087723;
	bh=CtW56XS8j9p7+/+Z1e/3bEG5YOaJmHTP8YwNHwVdoDM=;
	h=From:To:Cc:Subject:Date:From;
	b=owaaY3W5tsrkwWZQXzuJy6uI0K1tuKyt4gqgOECWujzes36Ia2O5PC5FcJ1/GB1UZ
	 02esMt2fyY8s8GoCloF8WpIoD4MEZ0mIumM+HV3DrBtOS7L7lxJEGHQ7fxn0lssI/T
	 zQVeKFhAQyJ98acZjquagqwA+81esqrq7OUTkZiAvcmRZmS9BjcK6UuMh4yr5qkSsr
	 kKAUSjK/6ZofU7ZxfqPuOf/sowVb59Xe7uEhc85TR9AfDgEKB5AGgYb/mvsGrsHrD8
	 R2l4tbDmpJoQz2ctXvY/RLe3kM6a0Xm9nD8PbMbFPc+JW1Doh1igkTxz03iEgqm6eD
	 5brZyRTNflnNg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Willy Liu <willy.liu@realtek.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	=?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
	=?UTF-8?q?Maximili=C3=A1n=20Maliar?= <maximilian.maliar@nic.cz>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next 00/15] Realtek RTL822x PHY rework to c45 and SerDes interface switching
Date: Wed, 20 Dec 2023 16:55:03 +0100
Message-ID: <20231220155518.15692-1-kabel@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

this series reworks the realtek PHY driver's support for rtl822x
2.5G transceivers:

- First I change the driver so that the high level driver methods
  only use clause 45 register accesses (the only clause 22 accesses
  are left when accessing c45 registers indirectly, if the MDIO bus
  does not support clause 45 accesses).
  The driver starts using the genphy_c45_* methods.

  At this point the driver is ready to be used on a MDIO bus capable
  of only clause 45 accesses, but will still work on clause 22 only
  MDIO bus.

- I then add support for SerDes mode switching between 2500base-x
  and sgmii, based on autonegotiated copper speed.

All this is done so that we can support another 2.5G copper SFP
module, which is enabled by the last patch.

Marek

Alexander Couzens (1):
  net: phy: realtek: configure SerDes mode for rtl822x PHYs

Marek Behún (14):
  net: phy: fail early with error code if indirect MMD access fails
  net: phy: export indirect MMD register accessors
  net: phy: realtek: rework MMD register access methods
  net: phy: realtek: fill .read_mmd and .write_mmd methods for all
    rtl822x PHYs
  net: mdio: add 2.5g and 5g related PMA speed constants
  net: phy: realtek: use generic MDIO constants
  net: phy: realtek: set is_c45 and fill in c45 IDs in PHY probe for
    rtl822x PHYs
  net: phy: realtek: use generic clause 45 feature reading for rtl822x
    PHYs
  net: phy: realtek: read standard MMD register for rtlgen speed
    capability
  net: phy: realtek: use generic c45 AN config with 1000baseT vendor
    extension for rtl822x
  net: phy: realtek: use generic c45 status reading with 1000baseT
    vendor extension for rtl822x
  net: phy: realtek: use generic c45 suspend/resume for rtl822x
  net: phy: realtek: drop .read_page and .write_page for rtl822x series
  net: sfp: add quirk for another multigig RollBall transceiver

 drivers/net/phy/phy-core.c |  54 ++++--
 drivers/net/phy/realtek.c  | 343 ++++++++++++++++++++++---------------
 drivers/net/phy/sfp.c      |   1 +
 include/linux/phy.h        |  10 ++
 include/uapi/linux/mdio.h  |   2 +
 5 files changed, 257 insertions(+), 153 deletions(-)

-- 
2.41.0


