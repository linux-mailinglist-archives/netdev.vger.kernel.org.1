Return-Path: <netdev+bounces-141397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096159BAC12
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 06:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01EE01C20A85
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 05:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC6A179956;
	Mon,  4 Nov 2024 05:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YyBFsnk5"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5F216EB5D
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 05:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730698286; cv=none; b=rURsdHhDhWOZ9R4pAzQ2GRUkI99K8giRF5dmTYL2K0nxP8ZujLTGkOy1AYrDGZmYRikF2Rr4MyE1g9ufpTE10MX9qQzTQD7Z+CJ+G6U3/Un7nZGT7tQ4gCVByUSugbIYHvnQrJ6VnGQXS529f9RyTI+CDOd0W56y934pmN268tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730698286; c=relaxed/simple;
	bh=eAscMrBtxFJNjQaJHm5mLwqn013BMV7IjcX21gR4UVU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jTDqt3m3B+gLr455xXGHZlC+7YDIpceN9lBdvJGKR4o0SLjbB4at/TNPWB0yynJ0WUGcEcwOSV7Ye2EIYILEH2AvahB6NfGZvFhgb79cOJqQexWZDAVJEjvUGfWxPz1uO5n9ger0RIJO3TNlOqEsmdyar46rZ2sHSld1yFWpZ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YyBFsnk5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730698284; x=1762234284;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eAscMrBtxFJNjQaJHm5mLwqn013BMV7IjcX21gR4UVU=;
  b=YyBFsnk5jGQU/30Vz1MZNDlbqhHRoOzYfEV+tIL31iWQUkxam6Da3kVV
   ct4sk4MCmFMnM3YgUOxjNrNhVq7Z64b6Xz6j/eVXLQydmfF/CkCGIYn/R
   lu5EfThYYr9QjA0TiUkazRGfOlf/SPokge4uS02qFnUaanYLMnusTvJKX
   dOAO8XU7pWS9p5Ne1B/NfKTwYy/lgl2a2LGu3Rhf2XjWydnmuG/ZdiZZZ
   /eFLV7IiXCgHvKboT9+5F7XStZZwIE4LZb1t7ckRY8Y1Re0nL21wj3aL7
   bmTgyAiQJjso0W4YiSkvbegAEzQMl9R7EqK2U9J6xRDwwFqysdTMM/ngU
   A==;
X-CSE-ConnectionGUID: RBSmdqnPT4+THByMDZKx9Q==
X-CSE-MsgGUID: GHqoPKDFS+eCo3Mzq7PASw==
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="201254695"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Nov 2024 22:31:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 3 Nov 2024 22:31:14 -0700
Received: from nisar-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 3 Nov 2024 22:31:11 -0700
From: Mohan Prasad J <mohan.prasad@microchip.com>
To: <f.pfitzner@pengutronix.de>, <mkubecek@suse.cz>, <netdev@vger.kernel.org>,
	<kory.maincent@bootlin.com>, <davem@davemloft.net>
CC: <kuba@kernel.org>, <andrew@lunn.ch>, <Anbazhagan.Sakthivel@microchip.com>,
	<Nisar.Sayed@microchip.com>, <mohan.prasad@microchip.com>
Subject: [PATCH ethtool v2] netlink: settings: Fix for wrong auto-negotiation state
Date: Mon, 4 Nov 2024 04:04:07 +0530
Message-ID: <20241103223408.26274-1-mohan.prasad@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Auto-negotiation state in json format showed the
opposite state due to wrong comparison.
Fix for returning the correct auto-neg state implemented.

Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
---
Changes in v2:
    Used simpler comparison statement for checking
auto-negotiation.
Link to v1:https://patchwork.kernel.org/project/netdevbpf/patch/20241016035848.292603-1-mohan.prasad@microchip.com/
---
---
 netlink/settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/netlink/settings.c b/netlink/settings.c
index dbfb520..b9b3ba9 100644
--- a/netlink/settings.c
+++ b/netlink/settings.c
@@ -546,7 +546,7 @@ int linkmodes_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 						(autoneg == AUTONEG_DISABLE) ? "off" : "on");
 		else
 			print_bool(PRINT_JSON, "auto-negotiation", NULL,
-				   autoneg == AUTONEG_DISABLE);
+				   autoneg != AUTONEG_DISABLE);
 	}
 	if (tb[ETHTOOL_A_LINKMODES_MASTER_SLAVE_CFG]) {
 		uint8_t val;
-- 
2.43.0


