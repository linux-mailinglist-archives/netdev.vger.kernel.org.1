Return-Path: <netdev+bounces-184720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 560B9A96FFA
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9FB16A04F
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85976280A3A;
	Tue, 22 Apr 2025 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Klg4oUbm"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1C028CF4D;
	Tue, 22 Apr 2025 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745334486; cv=none; b=o3VmQ4YmNOktTo2MuQdXSrmCFs24Qu0H0J+I9Z05yEyX6nvU/XehwTMLRISqAByyYq+v9f63dXsa4X7B/GHOyWtMdmteDWnMji3w535F/PZXwiswHbVRiGOYI/khdxKHAflD6AAz2/GUOXIvZGb9754OTpidRa1sx0JRl1OPdaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745334486; c=relaxed/simple;
	bh=bbds3/ljpL2w6cU0AY/QkzufL6oVAsWOZsG0sjhrwbI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c9Jqx19xd9T5qf7MDR18AS64BHJolAld9iL4rXVfYiwBll1qVNMb5zPehLj9tt0kYTZUdy+iw7X5JhxM2gWgam+MPRBSJEfuE7XSEz0M0ojpIAFDvwq8Fc6ilfMCMatL6sl1vIULrxvql6NaNSXr+Pu1oQIWwZcEoYateZC4jU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Klg4oUbm; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72DC843A39;
	Tue, 22 Apr 2025 15:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745334476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lncP1rgWm9k02UlHRTvf0YUucg0MEeMGEKN5pvhXfVQ=;
	b=Klg4oUbmi7xLuZmCjFNsc05CfSpssVHYxTn25E52mKt2mIoaCeIPzSDpCldl01RURD5NMz
	Bq8pU+hvK91Y8IreCt5mO7mvG0nlnD10upAROk3xG5TI0ZgafSj1AbtX0PDLEZ2o6lAaJy
	F96CJNRTpiZnj0vCoL/clxM5ajLLWkS0C5hgqIg1fGSRjbLTX2dvrpINlo704iIgc3akeQ
	aPYVQxzZy7DauupSzJnRVWvi0KW0I82Rk4973/sXJnramg3tCzf/WQ4vcn0cRCgY3/dbGn
	k7enfcn75Taz1ZAIRW0IydA/DDptU4o9fBVNDicuzrR7WgnPPbS0zQBBssQF6Q==
From: Alexis Lothore <alexis.lothore@bootlin.com>
Subject: [PATCH net 0/2] net: stmmac: fix timestamp snapshots on dwmac1000
Date: Tue, 22 Apr 2025 17:07:21 +0200
Message-Id: <20250422-stmmac_ts-v1-0-b59c9f406041@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKmwB2gC/x3MQQqAIBBA0avErBNsyqCuEhFiU80iC0ciEO+et
 Hzw+QmEApPAWCUI9LDw5QuaugJ3WL+T4rUYUKPRHaKSeJ7WLVGUQ+ytafUwEELp70Abv/9rAk8
 R5pw/kvsRhWAAAAA=
X-Change-ID: 20250422-stmmac_ts-c226a53099e2
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Daniel Machon <daniel.machon@microchip.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Russell King (Oracle)" <linux@armlinux.org.uk>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegtdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthekredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhgvuceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeitdejieffgeevteegveefledugfffueeludejffdvteejffdvjeeuvddujeeugfenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgdujedvrddujedrtddrudgnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehli
 hhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsthhmfedvsehsthdqmhguqdhmrghilhhmrghnrdhsthhorhhmrhgvphhlhidrtghomhdprhgtphhtthhopegurghnihgvlhdrmhgrtghhohhnsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,

this small series contains two small fixes for the timestamp snapshot
feature on stmmac, especially on dwmac1000 version. Those issues have
been detected on a socfpga (Cyclone V) platform. They kind of follow the
big rework sent by Maxime at the end of last year to properly split this
feature support between different versions of the DWMAC IP.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
Alexis Lothore (1):
      net: stmmac: fix dwmac1000 ptp timestamp status offset

Alexis Lothoré (1):
      net: stmmac: fix multiplication overflow when reading timestamp

 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h       | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c  | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: c03a49f3093a4903c8a93c8b5c9a297b5343b169
change-id: 20250422-stmmac_ts-c226a53099e2

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


