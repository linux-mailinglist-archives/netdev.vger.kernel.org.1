Return-Path: <netdev+bounces-109130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5B992714A
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8B51C216EE
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 08:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B831A3BBD;
	Thu,  4 Jul 2024 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b6DUR+Wy"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E056010A35;
	Thu,  4 Jul 2024 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080745; cv=none; b=PYz7j6+w//aHDeohYbwJaZAwINl+BVtNKxCctmYOUtrrX7J4Jwwd/hsH40vKp1fUxtRR9bvagK4Gw7OitdOCI/8uxrBBcZ7THn2dn3QIlECxCfso8gNXX4owTI5J6e2Gppsl4bwJsvD9E7FyXhK2k1AXKfaSOpHEPAZIGhUg+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080745; c=relaxed/simple;
	bh=5JdVIlOd4l+2de6KAFWYixVxTURl/W97qcBCv/2S67g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Xpdoqm4WC25i6wfz/RdzfhVwniBahkEgQ3bUFxgbXoP9V9v8sC1F+8+bujJSrUpzqhNIkFdmOGFreKy7GzpL3iWtYJH7PDul+MHFwHYVm1w13AfDaoHFV5XnLAS8k/3JwTHldGIGXlgK0wDVvG2MeyWzCPbUxuCHpUgRYyS9zqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b6DUR+Wy; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 112521BF205;
	Thu,  4 Jul 2024 08:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720080735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gYl5D12JLYbJL9ZZSo47g+DrFd7XsKljC687NA4QLpk=;
	b=b6DUR+Wyy6+tfK3Ho0U4fZivFH+aLTxJkmXf8kNBMecFFQnVjm5PF5nw6rpbAeIY5EQ3kH
	YC9rr+0rKP+KlL3jupaB9AiccrgBESm/D4MaZeHb0vI3bk2S7SArY1GqINNkGAcKfcJEhv
	K3K3A/pdBhA2zFRQEnWuZJpRMYyR6/YxnfocEBNs7oZxzTkKAVUxwBhvDmNQ4yFo8PIFGy
	G9tkMaKYLzRa1CjFdd3b+4igbN3lDDxa9JdtKovU1pr8/Ec1fRbi9TeT0OVUvpW2mqozYB
	k7PwrglyA2+GO27yYvMDckPtOe6dgst2NE8K7WS5GnMRigbyN6ukJPR90+DDfA==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v6 0/7] net: pse-pd: Add new PSE c33 features
Date: Thu, 04 Jul 2024 10:11:55 +0200
Message-Id: <20240704-feature_poe_power_cap-v6-0-320003204264@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEtZhmYC/3XQy0oEMRAF0F8ZsjaSZyftyv8QGfKocQKaNOkYR
 4b+d2M2tjRZ1OJyqVNQd7RCDrCip9MdZahhDSm2MD2ckLua+AY4+JYRI0wQwSS+gCmfGc5L+p0
 vyGdnFkw1zMQaxWZhUdtdMlzCrbsvKELBEW4FvbbmGtaS8nc/WGnvuy3ZPLArxQQTJyz1cpbc6
 mebUnkP8dGlj25W9udMRI0c1hxHuGMerObGHh2+c6gYObw5hk1KC1CaU3p0xM4Z/qyK5liiKTf
 GS+Xl0ZF7R48c2RwJlCvpuabK/He2bfsBqB3fQOYBAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 linux-doc@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>, 
 Sai Krishna <saikrishnag@marvell.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch series adds new c33 features to the PSE API.
- Expand the PSE PI informations status with power, class and failure
  reason
- Add the possibility to get and set the PSE PIs power limit

Changes in v6:
- Rebase on top of net-next
- Link to v5: https://lore.kernel.org/r/20240628-feature_poe_power_cap-v5-0-5e1375d3817a@bootlin.com

Changes in v5:
- Fix few nitpick.
- Link to v4: https://lore.kernel.org/r/20240625-feature_poe_power_cap-v4-0-b0813aad57d5@bootlin.com

Changes in v4:
- Made few update in PSE extended state an substate.
- Add support for c33 pse power limit ranges.
- Few changes in the specs and the documentation.
- Link to v3: https://lore.kernel.org/r/20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com

Changes in v3:
- Use u32 instead of u8 size for c33 pse extended state and substate.
- Reformat the state and substate enumeration to follow Oleksij proposal which
  is more IEEE 802.3 standard compliant
- Sent the first patch standalone in net.
- Link to v2: https://lore.kernel.org/r/20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com

Changes in v2:
- Use uA and uV instead of mA and mV to have more precision in the power
  calculation. Need to use 64bit variables for the calculation.
- Modify the pd-92x0behavior in case of setting the current out of the
  available ranges. Report an error now.
- Link to v1: https://lore.kernel.org/r/20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (7):
      net: ethtool: pse-pd: Expand C33 PSE status with class, power and extended state
      netlink: specs: Expand the PSE netlink command with C33 new features
      net: pse-pd: pd692x0: Expand ethtool status message
      net: pse-pd: Add new power limit get and set c33 features
      net: ethtool: Add new power limit get and set features
      netlink: specs: Expand the PSE netlink command with C33 pw-limit attributes
      net: pse-pd: pd692x0: Enhance with new current limit and voltage read callbacks

 Documentation/netlink/specs/ethtool.yaml     |  58 +++++
 Documentation/networking/ethtool-netlink.rst |  87 +++++++-
 drivers/net/pse-pd/pd692x0.c                 | 317 ++++++++++++++++++++++++++-
 drivers/net/pse-pd/pse_core.c                | 172 ++++++++++++++-
 include/linux/ethtool.h                      |  20 ++
 include/linux/pse-pd/pse.h                   |  51 +++++
 include/uapi/linux/ethtool.h                 | 191 ++++++++++++++++
 include/uapi/linux/ethtool_netlink.h         |  12 +
 net/ethtool/pse-pd.c                         | 119 +++++++++-
 9 files changed, 997 insertions(+), 30 deletions(-)
---
base-commit: 2b117c82eb31424d12326707ba9085dd31fb193b
change-id: 20240425-feature_poe_power_cap-18e90ba7294b

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


