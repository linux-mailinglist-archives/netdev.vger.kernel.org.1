Return-Path: <netdev+bounces-196081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF0BAD37D8
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C3B9E3F7D
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D654329B8FE;
	Tue, 10 Jun 2025 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dUtQ0X6G"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D382980BC;
	Tue, 10 Jun 2025 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559813; cv=none; b=EvMA3SiIVWNsSPgHAJIr0AuzyJAeGCpRNC8KS5LhnYWNmY+UncYBf4R/CdAOLnQljEryOUUG8HKtrYZmBGByf6MWzNVRw5vDTDirPCxXzQ1l7HIx4PCGqvv5jEpI5maAkIJ/4sAF3/N+38LMfgd8fKUwrb3WxZPrEc+Y2fc5vPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559813; c=relaxed/simple;
	bh=xYRmbHCiSt/4kk7rpcC2ftng1cfPPYAJDj28TMRmGfo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=sIElr9/H+9+hDsXS4CxsBaXILfChvMO/tv1agV/1m4oW1J0EAd+bxZ/qh/3NcFtXm0WDry4xAtlVR4/BS3X8u9fC00ftjU8g99nTO8/7mw+GLmdjgSWh6Bz9mzCKYwfA2yKTUDG8ATK80pw1+28O0ZoUe8g24RgH+GjJF8xHmh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dUtQ0X6G; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7280B43A10;
	Tue, 10 Jun 2025 12:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749559803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3C3o0IMeAbxHYY9zE2a3M74zmHC7R/FFLuOJDYKXdFo=;
	b=dUtQ0X6GNgLioF8U6KVXXljzf7QwK1Ud0DXKLaPwnEvjWk3oLvVsVG8XKWmkHQdUws/HBt
	AQf4gl67TWtpUx8paycCDT9ATRIu1XQ7GoND8fIOdE/eks08h4/GoF1BthM8GCDrXswD18
	be0+dBf7PeP39aksSwowtofcWWuWSJqPTgF6szvefIojucBhbhFBDuZGfxvsB07PDEXNFO
	VdeLKMjWxwbWLn6NMSb5YBKvtVN/bzylgZqxRC7BRAqhbYjKdSXP1xJHS3g1N3geqct4tn
	s4ThtPJ/2j1nExrOC5/ECeN53aw88qCa4uuaCm0tlgdTrVSbcn8+FLPY5YICsg==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH ethtool 0/2] Add support for PTP hardware source
Date: Tue, 10 Jun 2025 14:50:00 +0200
Message-Id: <20250610-feature_phc_source-v1-0-cbd1adef12aa@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPgpSGgC/x3MwQqEIBRG4VeJu07QYiJ6lYgQ/R0vRMbVIojef
 WSW3+KchzKEkWlqHhJcnDntFaZtyEW7f6HYV1Onu48ejFYBtpyC9YhuzekUB+XNAHhv3Rh6quE
 hCHz/pzOhxJLSRsv7/gAVLyVebQAAAA==
To: Michal Kubecek <mkubecek@suse.cz>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Xing <kernelxing@tencent.com>, Russell King <linux@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvofesthekredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeduudevkefftdelffeiffeikeefueeutddvtdehteehgeekvdejgedvteegffetkeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehmkhhusggvtggvkhesshhushgvrdgtiidprhgtphhtthhopehthhhomhgrshdrphgvthgriiiio
 hhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhk
X-GND-Sasl: kory.maincent@bootlin.com

Add description of the PTP hardware source to indicate whether the
timestamp comes from a PHY or a MAC.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (2):
      update UAPI header copies
      tsinfo: Add support for PTP hardware source

 netlink/tsinfo.c                       |  34 +++++++++
 uapi/linux/ethtool.h                   | 134 +++++++++++++++++----------------
 uapi/linux/ethtool_netlink_generated.h |  19 +++--
 uapi/linux/if_link.h                   |  15 ++++
 4 files changed, 132 insertions(+), 70 deletions(-)
---
base-commit: 9338aa51d4856273539a052332de3695e09620bd
change-id: 20250610-feature_phc_source-d16eeddac8f3

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


