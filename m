Return-Path: <netdev+bounces-243145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D801DC9A06A
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 05:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB963A3C98
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 04:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED052DE6F1;
	Tue,  2 Dec 2025 04:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBbPvA1V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4684F29E0E6;
	Tue,  2 Dec 2025 04:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764650614; cv=none; b=oBaK5JttkPc/Um9BBz0d0L4FPAtCqI3BU6jqs0eeNS+u3EQYqMVTb6HQ3m91RHfrL8GxqWKT3vZMhcfchOJKaiq0BMfoQZZVu0GuheDj2EX0UrMFKm+6BTJSWNAUimjmSImuB3J9mnybmw2dGuCoaBKzQ5TpJ7LgQnPVs1GE0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764650614; c=relaxed/simple;
	bh=YHuykW3BY2bKlagS0Shm67CUfpc2QWoDRQovzkp6umk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YI1TCdfcxZHO0FXlGvZgTNt/XobkYMv7qT5zpRfoo1FhbgVepziVJUIpdiu1PKHsJ/36yQeHaaMGjzbq0aXjPbrhHhdZ5lZNMjSxC9REKIzkc2m+W6GjJuVdbKMmeeh6XpDA2jq+YbPUwkWBK+p0Sudg7EsLyfIS2qm9kPChf/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBbPvA1V; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764650613; x=1796186613;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YHuykW3BY2bKlagS0Shm67CUfpc2QWoDRQovzkp6umk=;
  b=OBbPvA1VSW8e0Tukn7tzjbqGmz+Qrp48vucAE5iAh/OwvAHq2YfdFsAb
   1oGjBRraTjkoQRJ8YV8hUv5sElE8kl3s+x8PIy7TKz4QOa4My6caaV7+j
   EtE8Z4VjRdveZRCd5MNazRQRkQFaSkMi0NUfrzUGF/rSPZY7TpgWbjUAI
   StXE7A/xH9P4pUDt5Vol1Bj0bGWunyZrqpk5Ew1X79kMT7fyv5aFszCFx
   RE2IB6tVe9N+IhLqCIdInCJqgv4K9y+MuWL5MpDGQMYiKRgcYAL0oX7DV
   3Q/jPIR81uOtrr+lEu81j0kWQqZtxdUXhz8QlfyLWlE7CaC7+uBUq03nl
   w==;
X-CSE-ConnectionGUID: laEbvlArTqWTGjgX+ieTjw==
X-CSE-MsgGUID: aS4dTyxCQ0mUoRX94jjdnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="78071879"
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="78071879"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 20:43:33 -0800
X-CSE-ConnectionGUID: JNZIT0lsRZCYkNQ9r7s52w==
X-CSE-MsgGUID: /K6JqyLSTxmDi1MrzGeTjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="194363908"
Received: from p2dy149cchoong.png.intel.com ([10.107.243.50])
  by orviesa008.jf.intel.com with ESMTP; 01 Dec 2025 20:43:30 -0800
From: Chwee-Lin Choong <chwee.lin.choong@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bouska@web.codeaurora.org,
	Zdenek <zdenek.bouska@siemens.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Subject: [PATCH iwl-net v1] igc: Use 5KB TX packet buffer per queue for TSN mode
Date: Tue,  2 Dec 2025 20:23:51 +0800
Message-ID: <20251202122351.11915-1-chwee.lin.choong@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update IGC_TXPBSIZE_TSN to allocate 5KB per TX queue (TXQ0-TXQ3)
as recommended in I225/I226 SW User Manual Section 7.5.4 for TSN
operation.

Fixes: 0d58cdc902da ("igc: optimize TX packet buffer utilization for TSN mode")
Reported-by: Bouska, Zdenek <zdenek.bouska@siemens.com>
Closes: https://lore.kernel.org/netdev/AS1PR10MB5675DBFE7CE5F2A9336ABFA4EBEAA@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM/
Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 498ba1522ca4..9482ab11f050 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -443,9 +443,10 @@
 #define IGC_TXPBSIZE_DEFAULT ( \
 	IGC_TXPB0SIZE(20) | IGC_TXPB1SIZE(0) | IGC_TXPB2SIZE(0) | \
 	IGC_TXPB3SIZE(0) | IGC_OS2BMCPBSIZE(4))
+/* TSN value following I225/I226 SW User Manual Section 7.5.4 */
 #define IGC_TXPBSIZE_TSN ( \
-	IGC_TXPB0SIZE(7) | IGC_TXPB1SIZE(7) | IGC_TXPB2SIZE(7) | \
-	IGC_TXPB3SIZE(7) | IGC_OS2BMCPBSIZE(4))
+	IGC_TXPB0SIZE(5) | IGC_TXPB1SIZE(5) | IGC_TXPB2SIZE(5) | \
+	IGC_TXPB3SIZE(5) | IGC_OS2BMCPBSIZE(4))
 
 #define IGC_DTXMXPKTSZ_TSN	0x19 /* 1600 bytes of max TX DMA packet size */
 #define IGC_DTXMXPKTSZ_DEFAULT	0x98 /* 9728-byte Jumbo frames */
-- 
2.43.0


