Return-Path: <netdev+bounces-99057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3188D38CF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420DA1F242E8
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182B93D3BD;
	Wed, 29 May 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GUF8ZPN9"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99BD1CD00;
	Wed, 29 May 2024 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991782; cv=none; b=nc25p3nlc0QPVRxBFSLRTbGAlOT9Vqbrgpp0DW06jCI5iWa+7mzmPdmCnwFJLUCzG3/uCLB9R9qVe6CU9sXQdhhI2yiMUjArFNmpgmcRcxE7YuBtS0K0SlGBsOm8JiaYo75AAYWPRxNwRDSnxJ2eytrsOZPcJ2hOEzMFEeqdiBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991782; c=relaxed/simple;
	bh=BukAmjTSMdl4GuW6eUVOoMcpg7Q+WrXFpcdl8mIHzLM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LaqD5p/DkcQpNCqI1b/Z9QMTzjywb5CVtJd0enKGoZuUbKNpaHsTeQ61cUqtfFDso0i1lrYjKCM9tUdI44WJyH6sCvw0rnaauXeSf8ApI8/UO+UoP4OgzlUXCZxTJXZUkKlUmjUuu3tpjNmPKdwYlsyA+Lwtlns9D0Qe59PIN6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GUF8ZPN9; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF41240004;
	Wed, 29 May 2024 14:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716991775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KoB8X5jisUebu5WDGHopNzSEI6k685dh5SMNh+rV5WI=;
	b=GUF8ZPN9VAsgzFC5bQBCe+CbhQqfeyIaf6fWSguVZ+TwqB2dpUSWZYjonfoA3jjEFXXEfT
	5lB4VVukIp3F5B4pCa2B/0c8bf/YAyULK9NWpvqBaauT/w+e+nBl6p0U4qH5XNMtefRZGF
	BK9ZR+x5i+hYzmWT3nz/WF6RB6QZzdZgz8Cc2ZWS7hW2NTXqENf09D2pwiuW6XHXBsgRgD
	VZ+HMSpHok00Lo415eF3D6mGZJzFFnif2nh2bPp0tpTEjRMe6FtQ1cFGVpPFnFGTx1VbiL
	J8EQNTfGKtlvjHPl8Hb7gAC52u0eRzOwDQNbYQCuEWhPsULqjOKBC5ZzytpSTg==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH 0/8] net: pse-pd: Add new PSE c33 features
Date: Wed, 29 May 2024 16:09:27 +0200
Message-Id: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABc3V2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEyNT3bTUxJLSotT4gnwQLk8tik9OLNA1tEi1NEhKNDeyNElSAuotKEp
 Ny6wAmxsdW1sLAHXCzjVnAAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>

This patch series adds new c33 features to the PSE API.
- Expand the PSE PI informations status with power, class and failure
  reason
- Add the possibility to get and set the PSE PIs power limit

Jakub could you check if patchwork works correctly with this patch series.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (8):
      net: pse-pd: Use EOPNOTSUPP error code instead of ENOTSUPP
      net: ethtool: pse-pd: Expand C33 PSE status with class, power and status message
      netlink: specs: Expand the PSE netlink command with C33 new features
      net: pse-pd: pd692x0: Expand ethtool status message
      net: pse-pd: Add new power limit get and set c33 features
      net: ethtool: Add new power limit get and set features
      netlink: specs: Expand the PSE netlink command with C33 pw-limit attributes
      net: pse-pd: pd692x0: Enhance with new current limit and voltage read callbacks

 Documentation/netlink/specs/ethtool.yaml |  20 +++
 drivers/net/pse-pd/pd692x0.c             | 261 ++++++++++++++++++++++++++++++-
 drivers/net/pse-pd/pse_core.c            | 169 ++++++++++++++++++--
 include/linux/pse-pd/pse.h               |  48 +++++-
 include/uapi/linux/ethtool_netlink.h     |   4 +
 net/ethtool/pse-pd.c                     |  63 +++++++-
 6 files changed, 544 insertions(+), 21 deletions(-)
---
base-commit: c7309fc9b716c653dc37c8ebcdc6e9132c370076
change-id: 20240425-feature_poe_power_cap-18e90ba7294b

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


