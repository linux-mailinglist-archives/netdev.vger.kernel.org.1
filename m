Return-Path: <netdev+bounces-117797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F8A94F5F4
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 19:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B6D1C212DC
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104C8188CB0;
	Mon, 12 Aug 2024 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xhtje9aW"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144513A3F2
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484502; cv=none; b=L86hnUTyr3+N0IsVA3lrl0qWah2gBfjU5RpWnIikS9vkRe5QZhKPLcP/7KdGcohVjXTTtT2GpiFA8BqAQUgpr422EeQpzZpduAIa/fpHPZwRBVkR1CaCenrOiQTSQWByKAfj+RUUwbwRvILmALv4vvr0PJjEDzL+7wSS4kTNg6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484502; c=relaxed/simple;
	bh=kXXZT85UyhSvboALSl9yLQUmbOHKTa+FdyS0pC7ssPY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O2V208QhPrCsewP5BJW7sMoUPsL/+/XYgX1TFA7ZXeh72BT2IAJfE3EuSFyPW7e6kCouiP666Vr/6fOVlZhMZgmSzwrmzyePNmethKLqtGYH80hW7J7+KLFgamYpXoGA6Iqs6iYnj4+NOulPZPdmzH8p6OblXlIJRJHHA3OdCtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xhtje9aW; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723484497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fXYNwbibo3q9+9v2rnTRfaKvdJQgQ9R5OR8/YZpKJV0=;
	b=xhtje9aWmJAotKGwyWjy/A18WJtnae2SsNhqtAqpYSpb7Z/a2zZQAFCXlEaP5Cqf40gWxH
	tYlpeN5xeXbWkq/Xq5k3UiphZd+MSwOZ/gWAuDtSFwzkj+msb6Pfx9RsTBIplv5PU2xUtF
	toZUU2DQQD+XdtQ6oMyvdrnSHe+NcFw=
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Eric Dumazet <edumazet@google.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v2 0/2] net: xilinx: axienet: Add statistics support
Date: Mon, 12 Aug 2024 13:41:16 -0400
Message-Id: <20240812174118.3560730-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add support for hardware statistics counters (if they are enabled) in
the AXI Ethernet driver. Unfortunately, the implementation is
complicated a bit since the hardware might only support 32-bit counters.

Changes in v2:
- Switch to a seqlock-based implementation to allow fresher updates
  (rather than always using stale counter values from the previous
  refresh).
- Take stats_lock unconditionally in __axienet_device_reset
- Fix documentation mismatch

Sean Anderson (2):
  net: xilinx: axienet: Report RxRject as rx_dropped
  net: xilinx: axienet: Add statistics support

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  85 ++++++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 259 +++++++++++++++++-
 2 files changed, 343 insertions(+), 1 deletion(-)

-- 
2.35.1.1320.gc452695387.dirty


