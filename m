Return-Path: <netdev+bounces-126740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC4E9725DF
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 01:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4E91C21B08
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 23:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F35318E756;
	Mon,  9 Sep 2024 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dL5NKquB"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0818E36E
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 23:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725925938; cv=none; b=g0Dry5uKQ1+piv96fZfzrC8oxkLQeqCq60L1SLO351rnA6HHIGwSMmO2tvohTH72vEXePCX8U2XTNLBCOlp12wef8pjDfe3AxluzNIpbTCz2kZoD0d6W2SHjvJG8YvHm4I+j4rcwLCNlk67DID6LCWkkb2+kmmMpP5Fd4HuV7Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725925938; c=relaxed/simple;
	bh=1ls8W5dPlE0ywGOoL1WQCsY2c+ZafzfUJbikDbgkjaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HeKwPQNPoXW57cIEwPjWKStAuhDuZLTlOWGs1xbK2CmEQRzIWyepMaJP6mpAQOKShA8Tk+k1isw5I6Pzz+T37IC9H7gT+BaLs+CTmX5qyulxLH7Qq2rUphdltm2xv10lccrcURKJqU4kMK25vZG4xE0igQb4glXqka31F8SQwDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dL5NKquB; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725925933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XoY8HneQkhH5ZjxPqOoPttw1x0WMnLjBkxmjs118fsc=;
	b=dL5NKquBh3unx+vlb2FBfSby+vLEx+lrcUjNjJ2sPnLnSsAZwdFVJPL03X/J/re7lJL+XK
	LhrVWnZ02Xj4EuZgo6LwPvlIv9EkMkIJBIXKU3lcdiYxZpkUw/XA50Cw/hUHAZggVgqVh7
	b7mR8eLnwBi81b///22l4KtDRjM/ufQ=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Heng Qi <hengqi@linux.alibaba.com>
Subject: [RFC PATCH net-next v2 0/6] net: xilinx: axienet: Enable adaptive IRQ coalescing with DIM
Date: Mon,  9 Sep 2024 19:52:02 -0400
Message-Id: <20240909235208.1331065-1-sean.anderson@linux.dev>
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

This series depends on [1-2] and is therefore marked RFC. This series is
otherwise ready to merge.

[1] https://lore.kernel.org/netdev/20240909230908.1319982-1-sean.anderson@linux.dev/
[2] https://lore.kernel.org/netdev/20240909231904.1322387-1-sean.anderson@linux.dev/

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
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  31 +-
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 320 ++++++++++++++----
 3 files changed, 273 insertions(+), 79 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


