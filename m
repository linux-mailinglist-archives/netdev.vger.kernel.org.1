Return-Path: <netdev+bounces-118957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F563953AE9
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB59B210D6
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 19:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6B978C73;
	Thu, 15 Aug 2024 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UOmGk4nL"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E257580A
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750588; cv=none; b=MFa41n18pci/ArxutLKx7TiyRByaesv97d3i/mrR/rwtb0rO3vk/raidTZwwHQ3tl6dbcMUq1uR8KCsRxnG66ZWDrztX8zksw2O0KGhRQcj60DATMoE0H+4DDGnCwdCxfaldWsG14B7q34N1izYWVULSaudvfXKcHiNWAm8sw8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750588; c=relaxed/simple;
	bh=QcM8GLB5+lVbex8gGtplA6bEZAXYjE9GY8O+dIjUI0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qito7FwbRzlc11tTt+5kCkbFCre3FsMwHRyQ2on/vSPPyz8RdvX0vjWfXu29kwWMWnDbyzUjq7hgAA757ab2AdBoAtG6wyPyPi8kooCysOT2srXSq/fzTrxu6cjDc4xadj1Hevh2jbuvk1zEnc524uJkEVqobIJZBp3GgmZ86eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UOmGk4nL; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723750584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JoT+PgcUjqGva36HBaNEdB+NyyP5wVwsRBkZBx54lXA=;
	b=UOmGk4nLeXkCSC0+YXNVSfGMqlup6GLGnG7ToTNOBToTVd6mU11HJz4SM6Uio9OFmECAq6
	wqoj7XP9iz9nKvQkcXlTGMkjRilsqm75jVcDuPu5s51P5ivCI9tD5Lx2i1xrMxklVPMIWB
	Kynlch9DHc+obH2SC2CQt4yHyqyXedk=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v2 0/5] net: xilinx: axienet: Multicast fixes and improvements
Date: Thu, 15 Aug 2024 15:36:09 -0400
Message-Id: <20240815193614.4120810-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series has a few small patches improving the handling of multicast
addresses. In particular, it makes the driver a whole lot less spammy,
and adjusts things so we aren't in promiscuous mode when we have more
than four multicast addresses (a common occurance on modern systems).

As the hardware has a 4-entry CAM, the ideal method would be to "pack"
multiple addresses into one CAM entry. Something like:

entry.address = address[0] | address[1];
entry.mask = ~(address[0] ^ address[1]);

Which would make the entry match both addresses (along with some others
that would need to be filtered in software).

Mapping addresses to entries in an efficient way is a bit tricky. If
anyone knows of an in-tree example of something like this, I'd be glad
to hear about it.

Changes in v2:
- Split off IFF_PROMISC change from printing changes

Sean Anderson (5):
  net: xilinx: axienet: Always disable promiscuous mode
  net: xilinx: axienet: Fix dangling multicast addresses
  net: xilinx: axienet: Don't print if we go into promiscuous mode
  net: xilinx: axienet: Don't set IFF_PROMISC in ndev->flags
  net: xilinx: axienet: Support IFF_ALLMULTI

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  3 ++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 52 +++++++++----------
 2 files changed, 29 insertions(+), 26 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


