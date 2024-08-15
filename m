Return-Path: <netdev+bounces-118863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4969535BE
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A951C2526F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577741AB519;
	Thu, 15 Aug 2024 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UTCZV5e1"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7729B19F482
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732862; cv=none; b=fgsxkom8vuCM8kaJK+Lr82Ref4FEqK0BHqHtIGQ9JR+gUk/fwD2RXJS50aZs/6t46uAt99v84h3uUTYfdzCjEsqccMB5KxCKnZu3xKoYU+MMm4p7hMkFG5S4dSljlh0nM+q+4TW3ETag3zGboOtwxxwaLAYQ8fdmRDBYTHZVdJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732862; c=relaxed/simple;
	bh=FFzqqdAxsh07T9JjkFdDoa667ciSEMaxic2l3YT3ck8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JepqZjEnhEBHaCLKGa0L0oBv4rmusSBDPe6O7UBTQ+/3VhvoVSdjJYeEMiVrpiNAIz8cTU7ab4u4EXtGSGzwqhTJRAf3dkQIqO5h4876p2rtXIO2xbyLIjy0CRAXMv7dy4GT68HDnUj0vHdN+03v5BspwmC3ThZOcYV2w+FSABU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UTCZV5e1; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723732858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ay0ClSUBYnrL9R9xZ0n3GEdh4ukn5Baj+mckgzUBt9w=;
	b=UTCZV5e1GHZP1xMpztYb/kaTB+GD/ngmi45Cn8lzOsZM82QpyQk5rfnotQu7R27jFAOu3o
	NFnQZISEVRCN1XC2coPUHLMOKCT5lrzgQ9s01/YXs7lnoKSoAS/vf9iIWBded2THZC6XGt
	DY6J3GdAskESASUwuWMvcG7JbYuCDu0=
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v3 0/2] net: xilinx: axienet: Add statistics support
Date: Thu, 15 Aug 2024 10:40:29 -0400
Message-Id: <20240815144031.4079048-1-sean.anderson@linux.dev>
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

Changes in v3:
- Use explicit mutex_lock/unlock instead of guard() in
  __axienet_device_reset to make it clear that we need to hold
  lp->stats_lock for the whole function.

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
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 267 +++++++++++++++++-
 2 files changed, 348 insertions(+), 4 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


