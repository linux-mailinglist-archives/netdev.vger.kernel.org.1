Return-Path: <netdev+bounces-117827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EE494F7DA
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 22:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D308F1F22CDE
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 20:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01463194122;
	Mon, 12 Aug 2024 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pikZ2+Uh"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363219307E
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 20:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493096; cv=none; b=pSiztoc5YxLR48huXuRqbo1dq7j7mfPkW8tDgfYmCgXla9hM9SrppT4dgx/z9S5glT+vAA37T1XqrNDJM7tspU7nqhB8dNDctIYW/YdwrkmVmWb/Z1W2ZQvtqBJFaI0oxe3AlXVCrjMHuJd0BMiPWH6PROUHMahB7+S+02JWyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493096; c=relaxed/simple;
	bh=KIMQFBseFMi5iLOq4DV6qtFicGW0JCVQITDOesbbiqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GVKKB4TerkgPpY9Rmkxvie0013TgFYejbuHsVW4+/7gGgNNfdKAvqdqeTChEC2+9OhIzNFYqAnIC/wrhUr5xWE4x6gvYY8++NxKtTdQb+xZfxjRgaHTsc0DhxUNo+N9gQn9Q2M6e3Eemhduj7NpexudtgMsXGhRkDQGIMSyspEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pikZ2+Uh; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723493092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ea/hepG1riZcgQ3a/aL+ihST+BRCrV+sO+KpTY3LT20=;
	b=pikZ2+UhYxs0BNIb309hytaGFYcpGifNsWrv1Y3v2fDMsgJqWR03t1bm+xaOsKB1zyN4oQ
	LOMQCd7Ubl98NvX20OYHOnBsZ1Tda23S3PnxIH/nUewE8yYev4LK4Nlv3BSlGNQyxG5FbN
	WXob9jRW96mJzgAHgVykdaP6Tr68CmM=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Michal Simek <michal.simek@amd.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Ariane Keller <ariane.keller@tik.ee.ethz.ch>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next 0/4] net: xilinx: axienet: Multicast fixes and improvements
Date: Mon, 12 Aug 2024 16:04:33 -0400
Message-Id: <20240812200437.3581990-1-sean.anderson@linux.dev>
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


Sean Anderson (4):
  net: xilinx: axienet: Always disable promiscuous mode
  net: xilinx: axienet: Fix dangling multicast addresses
  net: xilinx: axienet: Don't print if we go into promiscuous mode
  net: xilinx: axienet: Support IFF_ALLMULTI

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  3 ++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 52 +++++++++----------
 2 files changed, 29 insertions(+), 26 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


