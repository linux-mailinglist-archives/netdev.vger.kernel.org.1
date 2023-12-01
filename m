Return-Path: <netdev+bounces-52996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4698010C7
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D9AB211D1
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D401C4E1A1;
	Fri,  1 Dec 2023 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n4Vi5Tt5"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89764C1;
	Fri,  1 Dec 2023 09:11:37 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C96FF24000A;
	Fri,  1 Dec 2023 17:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701450696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cf3RboC7v/50jqCoPEsittoiIyTcKQhGJ+tHg/wFrhY=;
	b=n4Vi5Tt5sKveHLBat483FVqcza4IsZpHTrtcSEZINAubs6cAcbVayEPxmGIEB9QfRADqr5
	XcE2LrhHThb28R7H2xyCe2x94jrAfoPpPH70qnTGakXJEMebTLLkWXpyTlmKHGjX7FZrF5
	xJK/NILhT7XoHMBC2uxzfw1ysxRKKznhYnNPWCzhNjDAoshb/yOD+ZgRmDVowaBX3k9p4d
	+0/FeHYPDjxn9Gll/OpGpOE5GJHFSQCaTTUvw5twG43ZmcGxDV2qkVMrEXLrUOiCDPIz5W
	RrQeIFfa2dkkalFhClmW5imt1E2ZT5OJkKN2YVXPvYUg2CNOB7CvI2nQGT/RxQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v2 0/8] net: Add support for Power over Ethernet
 (PoE)
Date: Fri, 01 Dec 2023 18:10:22 +0100
Message-Id: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH4TamUC/1WNywrCMBBFf6XM2kgeg1pX/Q8p0taJHdCkJDFUS
 v/dkJ3Lw+Geu0GkwBTh2mwQKHNk7wroQwPTPLgnCX4UBi21UVKjsDSkT6D74kko02Ir6WxQGii
 LJZDltdZu4CgJR2uCvpiZY/LhW2+yqr4WlTr9FbMSUoyEF4k4Wo1tN3qfXuyOk39Dv+/7D4mr0
 SuyAAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

This patch series aims at adding support for PoE (Power over Ethernet),
based on the already existing support for PoDL (Power over Data Line)
implementation. In addition, it adds support for one specific PoE
controller, the Microchip PD692x0.

The PD692x0 driver is based on the patch merged in an immutable branch
from Jakub repo. It is Tagged at:
git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git firmware_loader-add-upload-error
The patch is already merged in net-next.

In detail:
- Patch 1 to 6 prepare net to support PoE devices.
- Patch 7 and 8 add PD692x0 PoE PSE controller driver and its binding.

Changes in v2:
- Extract "firmware_loader: Expand Firmware upload error codes patches" to
  send it alone and get it merge in an immutable branch.
- Add "c33" prefix for PoE variables and enums.
- Enhance few comments.
- Add PSE Documentation.
- Make several changes in pd692x0 driver, mainly for readibility.
- Link to v1: https://lore.kernel.org/r/20231116-feature_poe-v1-0-be48044bf249@bootlin.com

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (8):
      net: pse-pd: Rectify and adapt the naming of admin_cotrol member of struct pse_control_config
      ethtool: Expand Ethernet Power Equipment with c33 (PoE) alongside PoDL
      net: pse-pd: Introduce PSE types enumeration
      net: ethtool: pse-pd: Expand pse commands with the PSE PoE interface
      netlink: specs: Modify pse attribute prefix
      netlink: specs: Expand the pse netlink command with PoE interface
      dt-bindings: net: pse-pd: Add bindings for PD692x0 PSE controller
      net: pse-pd: Add PD692x0 PSE controller driver

 .../bindings/net/pse-pd/microchip,pd692x0.yaml     |   77 ++
 Documentation/netlink/specs/ethtool.yaml           |   33 +-
 Documentation/networking/ethtool-netlink.rst       |   20 +
 Documentation/networking/pse-pd/introduction.rst   |   73 ++
 MAINTAINERS                                        |    7 +
 drivers/net/pse-pd/Kconfig                         |   11 +
 drivers/net/pse-pd/Makefile                        |    1 +
 drivers/net/pse-pd/pd692x0.c                       | 1025 ++++++++++++++++++++
 drivers/net/pse-pd/pse_core.c                      |    9 +
 drivers/net/pse-pd/pse_regulator.c                 |    9 +-
 include/linux/pse-pd/pse.h                         |   35 +-
 include/uapi/linux/ethtool.h                       |   43 +
 include/uapi/linux/ethtool_netlink.h               |    3 +
 net/ethtool/pse-pd.c                               |   64 +-
 tools/net/ynl/generated/ethtool-user.c             |   54 +-
 tools/net/ynl/generated/ethtool-user.h             |   81 +-
 16 files changed, 1481 insertions(+), 64 deletions(-)
---
base-commit: 98137c429a4854583210707a82114b4f5c171c5e
change-id: 20231024-feature_poe-139490e73403

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


