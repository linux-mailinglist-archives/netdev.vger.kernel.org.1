Return-Path: <netdev+bounces-144961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6A09C8E80
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39061F2831B
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C895D1A00D2;
	Thu, 14 Nov 2024 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PHgxnqys"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669D219E990;
	Thu, 14 Nov 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598575; cv=none; b=SdaYa4fs1FokGHSeEHR8c/4U1UBac1Bx60UKzBqcWPg61OVIhNcx1kj6jvp4Wp7tRjMrwUlubjF4NyTQolqt+aWIhPdGOf2jzG9GChydQNT5abElp5twQtYBvHqkYUcc3Rzq1yGY1A/eTyoBV1xLQqlNwlKHaZlukPIXy0YAopE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598575; c=relaxed/simple;
	bh=kQ39Rsyn2g4EDGB5xm+OxhRlfal4DKLP5XFNlKLBRic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aANSPmx9EiNrlEvAcqnIL+S2Rd5Knf68mTELwXkg0iPYrCHdh9woqw4QUNBDhUIFbjB3moDMc/gDgSMwTrGuJQHTHjlNLwIa2xG0uza4/9H9ImEqFfO7AtQm6AMSffBkyyWNx/tDH/UoqyUW+1P7vNfb2YoTJaLvkoQpQzF/wUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PHgxnqys; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 24C0B1BF203;
	Thu, 14 Nov 2024 15:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731598566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VlbPUfJTfjR4el0/XaLK036mk95ZItSTahQIOW8fAxM=;
	b=PHgxnqysattdywIh3LkhH4IdLjGjtYzbCWoX6xdldJ0v8MyWWWJMgIM2ruBo7MdD9V+DaF
	+uBJcnFSXJORpsWiUXXThqd0TVhJ/XWRNLxHq5kWlQfulJKy+eulflir2FhPVarvD+gjcl
	Y/WutCDBGl4NGwbUGgi6J9vzHmjOqTXpq7lyHE9Ifd25idaLfriMDmjepJEoMVtH1zVeLq
	fpWUjLfPG9ZCK3n0AfhDh7lFt0eXHuEsZkg0HSvFjCUU0RV6MeRqU1KFKvKx1lpfdyVlCL
	q/wze7B415Q4j0h1NoOuOQi3RJ8xinVrQ+j8UxIE57nG5ae8VFujlN1gv1SO3g==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v2 00/10] net: freescale: ucc_geth: Phylink conversion
Date: Thu, 14 Nov 2024 16:35:51 +0100
Message-ID: <20241114153603.307872-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

This is V2 of the ucc_geth phylink conversion.

There were two main reviews from the first iteration :

 - The WoL configuration was not accounting for most of the WoL flags.
   The Wol config was reworked (however, not tested unfortunately) to
   better account for what the PHY and MAC can deal with. However this
   is still a topic I'm not fully mastering... I think the modifications
   done to patch 4 addresses the shortcomings, but it does look a bit
   convoluted to me.

 - The last patch of the series, that does the phylink conversion, was
   hard to digest. To address that, I've split it up a bit more by
   introducing the phy_interface_mode_is_reduced() in a dedicated patch
   (patch 9), and by moving around some internal functions in a
   dedicated patch as well (patch 8).

Thanks Andrew and Russell for the reviews on V1.

Best regards,

Maxime

Link to V1: https://lore.kernel.org/netdev/20241107170255.1058124-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (10):
  net: freescale: ucc_geth: Drop support for the "interface" DT property
  net: freescale: ucc_geth: split adjust_link for phylink conversion
  net: freescale: ucc_geth: Use netdev->phydev to access the PHY
  net: freescale: ucc_geth: Fix WOL configuration
  net: freescale: ucc_geth: Use the correct type to store WoL opts
  net: freescale: ucc_geth: Simplify frame length check
  net: freescale: ucc_geth: Hardcode the preamble length to 7 bytes
  net: freescale: ucc_geth: Move the serdes configuration around
  net: freescale: ucc_geth: Introduce a helper to check Reduced modes
  net: freescale: ucc_geth: phylink conversion

 drivers/net/ethernet/freescale/Kconfig        |   3 +-
 drivers/net/ethernet/freescale/ucc_geth.c     | 601 +++++++-----------
 drivers/net/ethernet/freescale/ucc_geth.h     |  22 +-
 .../net/ethernet/freescale/ucc_geth_ethtool.c |  74 +--
 4 files changed, 265 insertions(+), 435 deletions(-)

-- 
2.47.0


