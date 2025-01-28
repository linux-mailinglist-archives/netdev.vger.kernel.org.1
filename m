Return-Path: <netdev+bounces-161355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE12DA20D25
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AFA67A2A31
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8351CD205;
	Tue, 28 Jan 2025 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BzwJznvu"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7D9F9F8;
	Tue, 28 Jan 2025 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078555; cv=none; b=KqSHWzYGTMIZtq6F2cW/j0r614j/1CxyFbSuMs1a5HL4OvOMD1UmmKKGltyS+jRbLxZz3T76xhGMT3oPk6oyILAnwhGKsHtGr4js4LKchSN5Gc7239FdcoaoNNMnLQqJwXeLj94SREUJe7d6nnepm0Dwm6CSRR/kCiAvKoZBF/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078555; c=relaxed/simple;
	bh=5SnNAweaUJzgWNzxaQCAcG/s4YCOVgaJffen+dIeSgc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=djkgj6yO9vyLHKb3iSMzVidP/y+KOQ2BSezeJcqULjRfwzDBy96aCQIqXqnPicMsY8+oaq2YDee5/I+AubMCkwCCq1DbtzpPzKrxxi28kDJXtyZO0zW5HGRRFrhJopjHAewKetJ21n2V7dau/IqL3Lk9BoLAL/+Is40Ruh5CBaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BzwJznvu; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97A28442EB;
	Tue, 28 Jan 2025 15:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738078551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UOdNbCvTkwasrvBGdPpUds4RzGBtER/c2YHw01OaSSk=;
	b=BzwJznvuVhKrOKQImJt/Zz4Dc526JObIDeNCW6wZAyr6BSRD75+Pittca1eGO1mLC4Ogje
	uNsovpqMFy+PRYSAPqjLzuPOpBbtrSsV/N03jy+wZPQvwWbDBt1fB58cLVA/KiTeSjqblE
	UwgDrKRV+H9x4LYH6GABk1DSI6VY2VdCi1ZuDTcsiWXDT+GKQ3GVdg7gX3rCGs/6APQTdv
	TeTfa+SiQopOmE6/qNsZgmVpJnnq+yA65osQyjRB0MMu4VXK0f7wymBYZM2YrZ2+qG/nd4
	tiWo2Vm5LahFoSaP4NmVJBNc+EZf2HDHjxiMVcWmanw+r0Xf7+FPUCxahE4t3A==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net 0/3] net: ethtool: timestamping: Fix small issues in
 the new uAPI
Date: Tue, 28 Jan 2025 16:35:45 +0100
Message-Id: <20250128-fix_tsconfig-v1-0-87adcdc4e394@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFH5mGcC/x2MWwqAIBAAryL7nZBL9rpKRJRttT8aKhGId0/6H
 IaZBIE8U4BRJPD0cGBnC6hKgLlWe5LkvTBgjbpW2MmD3yUG4+zBp2wJ16HZDCrdQ0luT8X/uwk
 sRZhz/gDebEIrYwAAAA==
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtkeertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudeggfduffethfdtgeehtdeiieeuveelleduieeiteejkeetheelheefteeugfegnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopehli
 hhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

Fix the hwtstamp flag parameter type by changing it from u32 to bitset,
ensuring correct representation and usage.
Correct a minor issue with the enumeration size check to improve
validation.

Add myself as the maintainer for socket timestamping to oversee the
changes before Linux is released.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (3):
      MAINTAINERS: Add myself as maintainer for socket timestamping and expand file list
      net: ethtool: tsconfig: Fix ts filters and types enums size check
      net: ethtool: tsconfig: Fix netlink type of hwtstamp flags

 Documentation/netlink/specs/ethtool.yaml |  3 ++-
 MAINTAINERS                              |  4 ++++
 include/uapi/linux/ethtool.h             |  2 ++
 net/ethtool/common.c                     |  5 +++++
 net/ethtool/common.h                     |  2 ++
 net/ethtool/strset.c                     |  5 +++++
 net/ethtool/tsconfig.c                   | 37 +++++++++++++++++++++-----------
 7 files changed, 45 insertions(+), 13 deletions(-)
---
base-commit: 05d91cdb1f9108426b14975ef4eeddf15875ca05
change-id: 20250127-fix_tsconfig-6e2a94bc2158

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


