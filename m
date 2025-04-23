Return-Path: <netdev+bounces-184989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F4239A98027
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 09:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C8217FA3B
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 07:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32623267395;
	Wed, 23 Apr 2025 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OyNIlDDm"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38E51E1E1E;
	Wed, 23 Apr 2025 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392344; cv=none; b=Dwff/BKNGIuHlXONu+Aj0QZhkwx6DIkBGIu7lIg8xzwzMWcBmeu+TS/OyUP/g3K4sub5sbbbtH4ThhCKOwDkl04pmdqt9Ucx96NgkQl3mVT8N9/x3L2GVbDHlIpJHKbeGhlshPthevbx4JCayRscAV+hkSb6IN6VjPUlQcWzAvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392344; c=relaxed/simple;
	bh=Pv6ZZR7QtSqhiYl5hs3FGWuovNn4uKA1JA0M7H4acYw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EDkdsPp8cI7APYdJsBJ8Qzo0yf+aiCbtoILErbgRL+k8BorXM0bc31g0rxi3zMRdpc6IhMtY9VIzqOYg3htxGkqqB/uLf/q0PRV8jGyPCpLchgB5MpVKIhX5LHXG/5cIOK/2siIBNPvIZBu/PaA6j7T22aQ+5fwD8EwGzRUm4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OyNIlDDm; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2539643A30;
	Wed, 23 Apr 2025 07:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745392338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TkQ7C8jgkCaEq9rXFk0Vbf3ZVjNr91B4Eok6HCwhjgE=;
	b=OyNIlDDmh31ZODQSRl36ioGEdYX9s/zBp8vjomnpUrxi6KLMPBpOciJcPYeYlRDFgXzvmB
	Sqmbzp4Ip1AzVF7LqCev+ngzZGUMO37gsSTXv8LGmjtO1bxov5rQkxw+UAm2xQrlenzyIC
	2KouizGjb6pKGEMEWHBqsdnPGpHDY1JXnOv3oiDdwV1Y+HIQnfwLazowzsfJ5YGW0BwdE1
	BnBDtvHLaaf7XNWQ7TNRaEiORKJLdBqiA/fq/Et3VM2hRHLe8TXi8r4COp4pRwtrZainc5
	13MkBdwDYsPv/M/2PUTVQJjD+wwFHJgk/4Ftdy2BmevXBYOk2UaTKi5USAfWhw==
From: Alexis Lothore <alexis.lothore@bootlin.com>
Subject: [PATCH net v2 0/2] net: stmmac: fix timestamp snapshots on
 dwmac1000
Date: Wed, 23 Apr 2025 09:12:08 +0200
Message-Id: <20250423-stmmac_ts-v2-0-e2cf2bbd61b1@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMiSCGgC/22MQQrCMBBFr1JmbSQd20JceQ8pksapHTBJyYSgl
 N7d0LXL9//jbSCUmASuzQaJCgvHUAFPDbjFhhcpflYG1NjrDlFJ9t66RxblEAfbX7QxhFD9NdH
 Mn6N1h0AZxjouLDmm79Ev7XH9SZVWaTX1xpm504Pu2tsUY35zOLvoYdz3/Qd1aoL/qQAAAA==
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeehleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthekredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhgvuceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefgleelieejgfelfffgiefhleeijeduueejvdekudeludetleelhfevhffgudeikeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrvddungdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtohepmhgtohhquhgvlhhinhdrshhtmhefvdesghhmrghilhdrtghomhdprhgtphhtthhopegurghnihgvlhdrmhgrtghhohhnsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrlhgvgihishdrlhhot
 hhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgigrnhgurhgvrdhtohhrghhuvgesfhhoshhsrdhsthdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,

this is the v2 of a small series containing two small fixes for the
timestamp snapshot feature on stmmac, especially on dwmac1000 version.
Those issues have been detected on a socfpga (Cyclone V) platform. They
kind of follow the big rework sent by Maxime at the end of last year to
properly split this feature support between different versions of the
DWMAC IP.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
Changes in v2:
- drop additional parenthesis
- fix wrong hashes in Fixes tags
- add Maxime's RB on first patch
- Link to v1: https://lore.kernel.org/r/20250422-stmmac_ts-v1-0-b59c9f406041@bootlin.com

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


