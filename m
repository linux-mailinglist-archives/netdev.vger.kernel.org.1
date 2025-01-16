Return-Path: <netdev+bounces-159103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6D4A14673
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 00:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4F61605D6
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 23:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8028246EA9;
	Thu, 16 Jan 2025 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G0nM/EMK"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EC724415F
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737070214; cv=none; b=pSaFXywVVO8M4LmmElJBm8Xv/SPNRp18Y1RBgFm47n04DFnZsZtMjjIc/X9XuiRvIVhUcdmQLSCEswyKsUlKkW8e4LjHB6dpfgvYklGNBBRtojCnqBOZ8pOQ23iMOTSo4mHBftlVnDGA/UygnEAgV9vTbPylZu2++NEsEe++wmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737070214; c=relaxed/simple;
	bh=l1tObXhd/EFR5RtmdTwYwbJwmRyIheDR720blDLTjBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ok0JV+/yGhqnchut7/TRMNMk4NFkiAWSz+rwZ6VMPuKj6tfepCLotOUeV9V8G+G3w3a+ryRZ9pyuBwpoMaB2uhLwyZrYjJIES049ts8aWPQ7UiezkuD0cvh02/xoC9i7vpwXBY+RPR1+AkK8IMv49mgbBzQia5AAZwrjqhcQ5LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G0nM/EMK; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737070200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+1pCZCYTxd9JIXQBkYmreH5OVS2P9P4SJ14S/oIDWYo=;
	b=G0nM/EMKXh83jcV/sMw08ZNJ53XFyCQpN+/KzNrSt42f49uDqtqaMaySZu7cK0q6n0b5EB
	bFVXz6oTPBWBKdVprlBwEXdgadrXaupusr/c4aGBiJpIwXJa/El3kKYZiT/SUmtyP0xSO1
	7BbbxBvtCRCbovZiUN0oM6w36ZBK814=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Shannon Nelson <shannon.nelson@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Heng Qi <hengqi@linux.alibaba.com>
Subject: [PATCH net-next v4 0/6] net: xilinx: axienet: Enable adaptive IRQ coalescing with DIM
Date: Thu, 16 Jan 2025 18:29:48 -0500
Message-Id: <20250116232954.2696930-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To improve performance without sacrificing latency under low load,
enable DIM. While I appreciate not having to write the library myself, I
do think there are many unusual aspects to DIM, as detailed in the last
patch.

Changes in v4:
- Fix incorrect function name in doc comment for axienet_coalesce_params
- Rebase onto net-next/master

Changes in v3:
- Fix mismatched parameter name documentation for axienet_calc_cr
- Integrate some cleanups originally included in
  https://lore.kernel.org/netdev/20240909230908.1319982-1-sean.anderson@linux.dev/
- Move spin (un)locking in IRQs inside the if condition of
  napi_schedule_prep. This lets us hold the lock just for the rmw.
- Fix function name in doc comments for axienet_update_coalesce_rx/tx
- Adjust axienet_local doc comment order to match the members
- Rebase onto net-next/master

Changes in v2:
- Add some symbolic constants for IRQ delay timer
- Report an error for bad coalesce settings
- Don't use spin_lock_irqsave when we know the context
- Split the CR calculation refactor from runtime coalesce settings
  adjustment support for easier review.
- Have axienet_update_coalesce_rx/tx take the cr value/mask instead of
  calculating it with axienet_calc_cr. This will make it easier to add
  partial updates in the next few commits.
- Get coalesce parameters from driver state
- Don't take the RTNL in axienet_rx_dim_work to avoid deadlock. Instead,
  calculate a partial cr update that axienet_update_coalesce_rx can
  perform under a spin lock.
- Use READ/WRITE_ONCE when accessing/modifying rx_irqs

Sean Anderson (6):
  net: xilinx: axienet: Add some symbolic constants for IRQ delay timer
  net: xilinx: axienet: Report an error for bad coalesce settings
  net: xilinx: axienet: Combine CR calculation
  net: xilinx: axienet: Support adjusting coalesce settings while
    running
  net: xilinx: axienet: Get coalesce parameters from driver state
  net: xilinx: axienet: Enable adaptive IRQ coalescing with DIM

 drivers/net/ethernet/xilinx/Kconfig           |   1 +
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  32 +-
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 330 ++++++++++++++----
 3 files changed, 280 insertions(+), 83 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


