Return-Path: <netdev+bounces-120289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78C9958DA0
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 19:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8E91C21A0C
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B92A1BD51E;
	Tue, 20 Aug 2024 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OxXx2w6L"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C84E2F5E
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724176446; cv=none; b=rEKU3Mvg0CYrwGCUr4r4JGAuicBVo19ldY432JAC1bT2MAz00H9fP+yI+exc822eGJZNwkG+DFbn0XWJN70HtD0x/6Vj5YpE3sanpPbVbO3+YSC+rkhhHqABk0ShH8hqT5Z6dS67jj20BXsXH8nIL2HlSeKQFm+UGo8cM2pRtgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724176446; c=relaxed/simple;
	bh=F2PUkTkAK7wYXWeJnYjtmAhxRi2txwJMl6OqHcY8RGU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rQygLMIiBEPgdVNOPanlBsJTPXnoC90Ej4iUMtrLhn3WlRI47lYaPDDypLtkeHlXIyDXT93bok/2AGs/gCEtQpFUiu6iQkmyykJJPsjPIh+N3DPAhOVBJqGKRZlFOnqjKyET0CDVD+HrfG8i+0MR4rJm7pQ9yB59CAMzgz0NHV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OxXx2w6L; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724176441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iauch5809aYw0zcKrq/ncZUeuHwbewH9i2gZIKc7qnY=;
	b=OxXx2w6Ly9sbN1gs6iqprEn6klo8+nLRZnaJQG4zeqjNn7ZTUUnx65DH2bvaYeXFzxExak
	MwdYwdHlJiFNRrSfOIQOSXCEl+WhYyQC/5G57+jVqsQQooOR0AAEkJhcYlJOCHqGj+oAaB
	O9DKQBSNoxK/vRpaZVhZ4cKaVR5M+K4=
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v4 0/2] net: xilinx: axienet: Add statistics support
Date: Tue, 20 Aug 2024 13:53:40 -0400
Message-Id: <20240820175343.760389-1-sean.anderson@linux.dev>
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

Changes in v4:
- Reduce hw_last_counter to u32 to ensure we use (wrapping) 32-bit
  arithmetic.
- Implement get_ethtool_stats for nonstandard statistics
- Rebase onto net-next/main

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

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  85 +++++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 327 +++++++++++++++++-
 2 files changed, 408 insertions(+), 4 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


