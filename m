Return-Path: <netdev+bounces-207306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0111B06A3D
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B29563348
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9E9274B55;
	Wed, 16 Jul 2025 00:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TxwBT1ea"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDC9242D67
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 00:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752624104; cv=none; b=JVujUT3cxm9We2tRf54zS3toiUACJc6TTg7g49xxltSliagCxZ811GH/a7r6KND+nkCJhGfB9203GDBddmkMmZ537L0VKMtN7wV6XXkBv8h5ZIm4wqx/8nPEg8l+JP5vWUFqZZZOTEkzmlGU3rBSmZjI5h6E/adDSuX6/vbnD78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752624104; c=relaxed/simple;
	bh=7TcSB0KV5v2ivHNMn+2amZ4S5ERARJNZ0E9iaiJqJyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T1oRrDa1RJxjRxObRS+3/SDgp78TipgTfbD16GJlYcfOQ02dw56nz2dkpyYmNXuuypHEOH0h5RUYaI9MtmOQ95Al6k7J0nbjyuVrKtwNKatCSEFMuYwpw4ru3aVu3JCv2Y3coCWbhzYCtPNEFg0GYw+y1NPhitJc5FR9zlfP3p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TxwBT1ea; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752624090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zc6W1LqWhosxLy6inD+3Mw6xi1MjCToPHphw8hvqQkQ=;
	b=TxwBT1eaS2c9mz51J1mXjV4Nx+b/d5R9SKThusI7I+QKlZwzbwvHUzbdDXdN0iu5BY+jqW
	KkK49bWAWz+bvPDIjmEDw7HVvaS0Hnq2U2t1fvQwlJy2avkzw3FwBJ1sfxHhqhKyhmJgib
	MOgX6hzT+p5l2Mx5CAUA5wqCi5ID2po=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dave Ertman <david.m.ertman@intel.com>,
	Saravana Kannan <saravanak@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Ira Weiny <ira.weiny@intel.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net v2 0/4] net: axienet: Fix deferred probe loop
Date: Tue, 15 Jul 2025 20:01:06 -0400
Message-Id: <20250716000110.2267189-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Please refer to patch 4/4 for an extended look at the problem this
series is attempting to solve.

Changes in v2:
- Add example log output to commit message
- Fix building as a module
- Expand commit message with much more info on the problem and possible
  solutions

Sean Anderson (4):
  auxiliary: Support hexadecimal ids
  net: axienet: Fix resource release ordering
  net: axienet: Rearrange lifetime functions
  net: axienet: Split into MAC and MDIO drivers

 drivers/base/auxiliary.c                      |   6 +-
 drivers/net/ethernet/xilinx/Kconfig           |   1 +
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 422 ++++++++++--------
 .../net/ethernet/xilinx/xilinx_axienet_mdio.c |  31 +-
 include/linux/auxiliary_bus.h                 |   4 +-
 5 files changed, 263 insertions(+), 201 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


