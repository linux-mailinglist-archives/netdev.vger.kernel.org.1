Return-Path: <netdev+bounces-246880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E3ECF21E8
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A417300F8B2
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A9226B742;
	Mon,  5 Jan 2026 07:09:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36AB2417D1;
	Mon,  5 Jan 2026 07:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767596942; cv=none; b=IPZE0e/T2hdvxDS5d0Maw01k6uO1p5m2G61pe13THuB4RpTt7sQfkNXD6jCCMH0rGR0tJW8LSIpb0OvslhExvUfDAJJTKZpyPQeZseqVioM55B6jyZcN8J9Ln3GIznxQYjSkKfVzKXla9c+V/Ap8gPWRoCpCZ9lfppUZOtGHeYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767596942; c=relaxed/simple;
	bh=/0KJ/Htg5ugWG/7eI/O/Vrxl6L/6Q++lqpMM8XhoMpU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=T66gBrLbUl6/q43poERlmVboKKuOU2z1R9COBWNKNHiH1jZ0NrNYnm5uMY+4CEbSzS0nmEHh9O4ckxG451TardDssocNH0e2/GuEHn2pOindfTBN7WPAGZ0JB8x7XMu/KZNTi+2mVzaEKBOsXHjdJ8TBqPmWPJHz2sH9y+s+3+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 Jan
 2026 15:08:51 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 5 Jan 2026 15:08:51 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Subject: [PATCH 00/15] net: ftgmac100: Various probe cleanups
Date: Mon, 5 Jan 2026 15:08:46 +0800
Message-ID: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH5jW2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIwML3bSS9NzEZN3knNTEvNICXSODJCMj46Q0EzMLQyWgpoKi1LTMCrC
 B0bG1tQDkhpsBYAAAAA==
X-Change-ID: 20251208-ftgmac-cleanup-20b223bf4681
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767596931; l=1804;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=/0KJ/Htg5ugWG/7eI/O/Vrxl6L/6Q++lqpMM8XhoMpU=;
 b=YEXMW1irImLZlumQMShmLR+YJL3rM+ey7G1qit1le1lULGfN0HwiJxzG2xBGwgdjjV0OsE4iP
 W3LAXKdppqHAcLB/on26OH/x152g1sUxVHda+uRQN/NH7X+JTz9EM/e
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

The probe function of the ftgmac100 is rather complex, due to the way
it has evolved over time, dealing with poor DT descriptions, and new
variants of the MAC.

Make use of DT match data to identify the MAC variant, rather than
looking at the compatible string all the time.

Make use of devm_ calls to simplify cleanup. This indirectly fixes
inconsistent goto label names.

Always probe the MDIO bus, when it exists. This simplifies the logic a
bit.

Move code into helpers to simply probe.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
Andrew Lunn (15):
      net: ftgmac100: List all compatibles
      net: ftgmac100: Add match data containing MAC ID
      net: ftgmac100: Replace all of_device_is_compatible()
      net: ftgmac100: Use devm_alloc_etherdev()
      net: ftgmac100: Use devm_request_memory_region/devm_ioremap
      net: ftgmac100: Use devm_clk_get_enabled
      net: ftgmac100: Simplify error handling for ftgmac100_initial_mac
      net: ftgmac100: Move NCSI probe code into a helper
      net: ftgmac100: Always register the MDIO bus when it exists
      net: ftgmac100: Simplify legacy MDIO setup
      net: ftgmac100: Move DT probe into a helper
      net: ftgmac100: Remove redundant PHY_POLL
      net: ftgmac100: Simplify error handling for ftgmac100_setup_mdio
      net: ftgmac100: Simplify condition on HW arbitration
      net: ftgmac100: Fix wrong netif_napi_del in release

 drivers/net/ethernet/faraday/ftgmac100.c | 302 +++++++++++++++++--------------
 1 file changed, 169 insertions(+), 133 deletions(-)
---
base-commit: c303e8b86d9dbd6868f5216272973292f7f3b7f1
change-id: 20251208-ftgmac-cleanup-20b223bf4681

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


