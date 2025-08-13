Return-Path: <netdev+bounces-213270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C63B244CC
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4037188CA9A
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CFF2ED175;
	Wed, 13 Aug 2025 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Oc5+H8V1"
X-Original-To: netdev@vger.kernel.org
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794742D061E;
	Wed, 13 Aug 2025 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075502; cv=none; b=FupDyBuPfnHr9aqrsHNlQ/8kwrMHJO4A6+Fhmu9hHu/dhc7qPhtrECnvQNZui42nF8MdW9wYzZyiDsomhfsphhCuDROPErk7cqHNX/vcJPE9vjRSlpff6RAjcpV1CDLpvLzm3rwxOb9c+R3ELA6K4NBVhssveEU54kvKHQzYkZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075502; c=relaxed/simple;
	bh=o9sBv3uWVhgNJc2jzb/XTDzr77JaC5G3nW4je6txHZM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HT5+28L6dG4jtl6th+bO9ahxpgoBEpAQrW/e7G6dWtu2DXPC2xzI58mVLOYs970UhcGNJgUL8yiY9lptC1toJ/q+WnQzIAri0yKuGEUZCrw/BrYdElkrkotmERPxjAwxWIBtIs65oDYGS28Ih9fI0DFQTG+p7L2H77GCoKRF1Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Oc5+H8V1; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E271843888;
	Wed, 13 Aug 2025 08:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755075498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bcnlfncs0tTOrnBAv8lWMTl1GGwu4KPhepL66SNxFiA=;
	b=Oc5+H8V1glgn99KdP55+X/h8lTK8eD59sr/Zl8z8FdrwbYIH5oi3wvjfPdyOTBjMJzFJBC
	6B+v7BtcZRyEtSwOqEgmNicTMr6FbsDKXEdIYD8Af8FihkUw9m8hoa1ttu4nwqz6R+Yoik
	EepwsnlEAXxBS6L2EjO/oSLIngoVuujo7EEqpNYOXJhOj6zbwmz6McNINan7G1mkV1zSv3
	9vDOekvx4URCcJo4s4VC5IUy9Lp+mMmM3939cEtka5Ez3/OT3Bg4Umj0TT938IIDLrHHjQ
	/WqBX8/vfZAIUpOv+MBx7Wwu+/Wyt/4iiqg7OaapicKMBsuPLO9Mn6reNQfwdg==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH ethtool v2 0/3] Add support for PSE priority feature and
 PSE event monitoring
Date: Wed, 13 Aug 2025 10:57:49 +0200
Message-Id: <20250813-b4-feature_poe_pw_budget-v2-0-0bef6bfcc708@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAI1TnGgC/3WNwQqDMBBEf6XsuSlriNb21P8oIibZaMC6kkTbI
 v57g/ce5vAY5s0GkYKnCPfTBoFWHz1PGeT5BGbopp6Et5lBolSFRCW0Eo66tARqZ855t3qxPSW
 BHVFdSeVMWUKez4Gc/xzqJ1AaEvMITS4GHxOH73G5Fked7SVWEv/b10KgQG311Up9M7V7aOY0+
 uli+AXNvu8/lJRMn8sAAAA=
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Dent Project <dentproject@linuxfoundation.org>, 
 Kyle Swenson <kyle.swenson@est.tech>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeejjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthekredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfevudetfffgkedvhfevheeghedtleeghfffudeiffefvdehfeegieeivdekteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmkhhusggvtggvkhesshhushgvrdgtiidprhgtphhtthhopehordhrvghmphgvlhesphgvn
 hhguhhtrhhonhhigidruggvpdhrtghpthhtohepkhihlhgvrdhsfigvnhhsohhnsegvshhtrdhtvggthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepuggvnhhtphhrohhjvggttheslhhinhhugihfohhunhgurghtihhonhdrohhrgh

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add support for PSE (Power Sourcing Equipment) priority management and
event monitoring capabilities.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Changes in v2:
- Split the second patch in two to separate the PSE priority feature and
  the PSE event feature support.
- Regenerate the "update UAPI header copies" patch.
- Link to v1: https://lore.kernel.org/r/20250620-b4-feature_poe_pw_budget-v1-0-0bdb7d2b9c8f@bootlin.com

---
Kory Maincent (3):
      update UAPI header copies
      ethtool: pse-pd: Add PSE priority support
      ethtool: pse-pd: Add PSE event monitoring support

 ethtool.8.in                           | 13 +++++
 ethtool.c                              |  1 +
 netlink/monitor.c                      |  9 +++-
 netlink/netlink.h                      |  1 +
 netlink/pse-pd.c                       | 87 ++++++++++++++++++++++++++++++++++
 uapi/linux/ethtool.h                   |  4 +-
 uapi/linux/ethtool_netlink.h           |  2 -
 uapi/linux/ethtool_netlink_generated.h | 83 ++++++++++++++++++++++++++++++++
 uapi/linux/if_link.h                   |  2 +
 uapi/linux/neighbour.h                 |  5 ++
 10 files changed, 202 insertions(+), 5 deletions(-)
---
base-commit: 755f5d758e7a365d13140a130a748283b67f756e
change-id: 20241204-b4-feature_poe_pw_budget-0aee8624fc55

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


