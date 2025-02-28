Return-Path: <netdev+bounces-170636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 387E8A49696
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190F23AE581
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DE425F7B5;
	Fri, 28 Feb 2025 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQ0V4l/a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364A525C6EF;
	Fri, 28 Feb 2025 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737146; cv=none; b=shE6ugIdWGXugg43P7KhBfXarbRThp2ekdSB5zKVXK068rj1EMC17UCBPy3jsUwVEgw6YPizCVejabmo9zG2jKhwvT1y4ZQvQqlugQosjiEeZJgWcsPEfaTUIa8ro7hnQnRDy1ap98L2dRcwr3+mYetFRGyhAKGaScm2rXfcXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737146; c=relaxed/simple;
	bh=qDEJ+d+75sslUhU1HUIsBZVyUzoQa6ezI/EzDwzjCYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HoGlHQBFuDs7vlraOu7UKt1U1u/zX7aXgdg/17WYTF/WBSJBTYOincIsofFfkU1KMZOdyeEp0DeP6RAb/523GNdE070j4GT4fXZPwbgEPEkL5AEeLrRdfaRaPKHhsrQXp5UhFIeZxkHO+2LeIrMCl9l89cS6YQA81vVRbTvS3Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQ0V4l/a; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740737145; x=1772273145;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qDEJ+d+75sslUhU1HUIsBZVyUzoQa6ezI/EzDwzjCYE=;
  b=SQ0V4l/a62GTfAQZObUaAyXU+fZ62ZepjVBLxldSfv22N/zbNauc6fiL
   rtg2VAShOrIvSmnUb1HlfTbHcSxLfHzijnMbzggEgCg74sTNSMiZ79FTc
   2xmWfKWE0VbboAXDJCapD+x4h9x5/OnQxcldVBrd9m9aMGQMvCa4ypfmj
   CpkRzIQ1h924m4gDydF8T7N1qhbfKOJDnMv5Sj9YXfcLDWRw9w3SMGfW5
   L5RxslXyaL2LBr60D1/W7x8S0MHNPtZVBFnFtN3ct64TKO5HvoK1bNlU2
   axWosXAN2O6+YckE6ZC74XMc9zTUPT6zjGXYWgzRIak7ajHJo6gkHXYiy
   w==;
X-CSE-ConnectionGUID: 9//llqxTQreM2da3sMv6gw==
X-CSE-MsgGUID: IdOZTKnDTr+l6qEEUpZv8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41912594"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="41912594"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 02:05:44 -0800
X-CSE-ConnectionGUID: LZ+7hHCkSuCbGxuK3t1TIg==
X-CSE-MsgGUID: SHrG8j6eTRKnE5wBBom9Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="122241276"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 28 Feb 2025 02:05:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4A608297; Fri, 28 Feb 2025 12:05:40 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net v1 1/1] bnx2: Fix unused data compilation warning
Date: Fri, 28 Feb 2025 12:05:37 +0200
Message-ID: <20250228100538.32029-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some configuration, compilation raises warnings related to unused
data. Indeed, depending on configuration, those data can be unused.

Mark those data as __maybe_unused to avoid compilation warnings.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/broadcom/bnx2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index 6ec773e61182..a40ef3ec38b3 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -2887,7 +2887,7 @@ bnx2_tx_int(struct bnx2 *bp, struct bnx2_napi *bnapi, int budget)
 		last = tx_buf->nr_frags;
 
 		for (i = 0; i < last; i++) {
-			struct bnx2_sw_tx_bd *tx_buf;
+			struct bnx2_sw_tx_bd *tx_buf __maybe_unused;
 
 			sw_cons = BNX2_NEXT_TX_BD(sw_cons);
 
@@ -2994,7 +2994,7 @@ static inline void
 bnx2_reuse_rx_data(struct bnx2 *bp, struct bnx2_rx_ring_info *rxr,
 		   u8 *data, u16 cons, u16 prod)
 {
-	struct bnx2_sw_bd *cons_rx_buf, *prod_rx_buf;
+	struct bnx2_sw_bd *cons_rx_buf __maybe_unused, *prod_rx_buf;
 	struct bnx2_rx_bd *cons_bd, *prod_bd;
 
 	cons_rx_buf = &rxr->rx_buf_ring[cons];
-- 
2.47.2


