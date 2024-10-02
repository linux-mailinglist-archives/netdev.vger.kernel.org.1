Return-Path: <netdev+bounces-131285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B039198E077
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87E12B22127
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17F61D0E1E;
	Wed,  2 Oct 2024 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HEIbCWhr"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2F11CFECA;
	Wed,  2 Oct 2024 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885691; cv=none; b=Aml1juNG2WwLAIISejFNouKtk/eb81GEJOE3JyUFC2REngPYksygnoWBPrtjqWamjnXR0umtRpt5tnpzjIm3eSzVypGaBjY53+obO7jDvMqnWyzsbaKB/1KfEm3sUHVymc+qcs1nPYKnlYMqQlLi0nKopa+F9UD3BxQ20Qan91E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885691; c=relaxed/simple;
	bh=k+l8NvHNF0Rq60lqLNz6z89Ccblbf/w4q4LDoOKMFmo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TJWlFN7vJe0doHa4zEtyL8+yWzLtFoE/QI/fqOkKVt/Dou99/riKiwJz0YauUCLqdv6l/c8Vl3k1Swe6YnVS4Q/CgEwUaMtn4QmX2Djr/NXWSDtBnqT3bTDWQ5kzf27OoNwK/TZ1rBy99hBaCrhpDKwFozrklXRzloaduIVPtiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HEIbCWhr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 020FDFF803;
	Wed,  2 Oct 2024 16:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727885682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3IOGE5DuxU1rVrz5JJqkijX1lb9Jty0fXaR7az9v+iI=;
	b=HEIbCWhrXP53+goeMI00fKNBdVxXwPGzCN115FpiqLF61o9ADTOj7FLXonqh2+0XS5l077
	Zt99UG19zWJzISL2bfnPre5vKxMJ8ubNuvYAvnRgWfX3CHev2btthfqjmeoVffqkwlU0N3
	UO2JYMHSNtykZRqkx8rJW8LLDyEsnA7Mi2ngTVOjPbZEmki7WToq4bgMDzipBO5xeB4LXA
	G78fM0CISUzPQDcMMTkFDuAX3SIcVIYocyEhLhhWB4flnynOlli+kjj5ydRhxqQuED9tbd
	2LVBSmjeC+YOyEUs4KTEzubOXhv9FwuVnbHX1EpvzUi80HYHCD342QjU3B3OLA==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH 00/12] Add support for PSE port priority
Date: Wed, 02 Oct 2024 18:14:11 +0200
Message-Id: <20241002-feature_poe_port_prio-v1-0-eb067b78d6cf@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFNx/WYC/x2MQQ5AMBQFryJ/rYm2RLiKiDQ8/I02v4hE3F1Zz
 GIWMzdFCCNSm90kODmy35LoPKNxddsCxVNyMoUpi0ZbNcPth2AI/kP2IQh75SrtMNXWGoyU2iC
 Y+fq/Xf88L+veG8VnAAAA
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This series brings support for port priority in the PSE subsystem.
PSE controllers can set priorities to decide which ports should be
turned off in case of special events like over-current.

This series also adds support for the devm_pse_irq_helper() helper,
similarly to devm_regulator_irq_helper(), to report events and errors.
Wrappers are used to avoid regulator naming in PSE drivers to prevent
confusion.

Patches 1-3: Cosmetics.
Patch 4: Adds support for last supported features in the TPS23881 drivers.
Patches 5-7: Add support for port priority in PSE core and ethtool.
Patches 8-9: Add support for port priority in PD692x0 and TPS23881 drivers.
Patches 10-11: Add support for devm_pse_irq_helper() helper in PSE core and
               ethtool.
Patch 12: Adds support for interrupt and event report in TPS23881 driver.

This patch series is based on the fix sent recently:
https://lore.kernel.org/netdev/20241002121706.246143-1-kory.maincent@bootlin.com/T/#u

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (12):
      net: pse-pd: Remove unused pse_ethtool_get_pw_limit function declaration
      net: pse-pd: tps23881: Correct boolean evaluation for bitmask checks
      net: pse-pd: tps23881: Simplify function returns by removing redundant checks
      net: pse-pd: tps23881: Add support for power limit and measurement features
      net: pse-pd: Add support for getting and setting port priority
      net: ethtool: Add PSE new port priority support feature
      netlink: specs: Expand the PSE netlink command with C33 prio attributes
      net: pse-pd: pd692x0: Add support for PSE PI priority feature
      net: pse-pd: tps23881: Add support for PSE PI priority feature
      net: pse-pd: Register regulator even for undescribed PSE PIs
      net: pse-pd: Add support for event reporting using devm_regulator_irq_helper
      net: pse-pd: tps23881: Add support for PSE events and interrupts

 Documentation/netlink/specs/ethtool.yaml     |  11 +
 Documentation/networking/ethtool-netlink.rst |  16 +
 drivers/net/pse-pd/pd692x0.c                 |  23 ++
 drivers/net/pse-pd/pse_core.c                |  66 +++-
 drivers/net/pse-pd/tps23881.c                | 532 +++++++++++++++++++++++++--
 include/linux/pse-pd/pse.h                   |  43 ++-
 include/uapi/linux/ethtool_netlink.h         |   2 +
 net/ethtool/pse-pd.c                         |  18 +
 8 files changed, 674 insertions(+), 37 deletions(-)
---
base-commit: 8052e7ff851b33e77f23800f8d15bafae9f97d17
change-id: 20240913-feature_poe_port_prio-a51aed7332ec

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


