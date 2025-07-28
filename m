Return-Path: <netdev+bounces-210673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D734B14447
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 00:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CB33BC770
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 22:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD111EE7DC;
	Mon, 28 Jul 2025 22:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RCRhzBwW"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385DB41C69
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 22:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753741115; cv=none; b=S76794kv5HHIbKmNGT8Q5yL2LA8ZsSoB7JGDWu/tR3aeRaIlk1skRj84chNlzzAOV+uL9VS0gCnuoYTpnz19PSDPV9RRV8z9PburwivppW0VYYVTjjmy71/aESYrRu6DgASRkvU921+o53HiGoiGrmTfazcwoYBP341FP3u48p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753741115; c=relaxed/simple;
	bh=K89Sbciy9IKPrC7+QLg4lIglWg4Feo3nIoG4lOmFdb8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bz9nVjb06c5U9fLxd2JVMvN1Ln6IpW2ug2Mt6/NcSCqmxHqBbe5ZrtwvAKf6O6N4uUnz7yeOJoUDOfPPQL0FWzeMS0tRoGnFClM/cTXcVn46W2r+3AsVF5CKWE9nkBz9l4Cuuun0p1g9LeFPYw+5wd1owb4cOtiuzmistwYHZ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RCRhzBwW; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753741110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RoBkZ5QUGz1TAZ0kZZyxij8ERJRPO6rkWOERhOGR4E4=;
	b=RCRhzBwWB66EFMEUo4+SlMC8Wf8eO3Ct6LmhikouZYnDrwGVRTBN39NDKZUtC2PGZLvUoP
	o37D2sNdjPLPrTPsgw4uY7JEXYbQg7ciI+aqjdEL9DG6NJelWJ0vD+9m6uCcNuoy9Xk7vH
	ysbM2DLWFBMnjef8LnqeK/K2O6NXsnE=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Leon Romanovsky <leon@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v3 0/7] net: axienet: Fix deferred probe loop
Date: Mon, 28 Jul 2025 18:18:16 -0400
Message-Id: <20250728221823.11968-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Fix a deferred-probe loop by splitting the MAC and MDIO functionality
into separate drivers. Please refer to the last patch for an extended
look at the problem this series is attempting to solve.

This is a rather large fix for a rather rare bug, so I have sent it
for net-next. The first patch is a smaller fix, however, and could go
via net.

Changes in v3:
- Use ioread32/iowrite32 directly in MDIO
- Use MDIO bus device in prints
- Use device variable to probe
- Rework to use a separate axienet_common structure, as netdevs cannot
  be reused once registered.
- Use ida_alloc for aux id

Changes in v2:
- Fix building as a module
- Expand commit message with much more info on the problem and possible
  solutions

Sean Anderson (7):
  net: axienet: Fix resource release ordering
  net: axienet: Use ioread32/iowrite32 directly
  net: axienet: Use MDIO bus device in prints
  net: axienet: Simplify axienet_mdio_setup
  net: axienet: Use device variable in probe
  net: axienet: Rearrange lifetime functions
  net: axienet: Split into MAC and MDIO drivers

 drivers/net/ethernet/xilinx/Kconfig           |   1 +
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  45 +-
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 383 +++++++++++-------
 .../net/ethernet/xilinx/xilinx_axienet_mdio.c | 158 ++++----
 4 files changed, 350 insertions(+), 237 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


