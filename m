Return-Path: <netdev+bounces-42806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 990377D033B
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 22:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1E5B212AE
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 20:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CFA8F6B;
	Thu, 19 Oct 2023 20:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgzRWwcZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB57D6AB3
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 20:38:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE728A3
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 13:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697747938; x=1729283938;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JqG7ksi4MXRGQ2MDZSN0SVj5pEm9xYqMmaI183g6ZQY=;
  b=kgzRWwcZZi5yaTOUuYS6ifdIp4HjIMJ8AS9bGTDJfMjDdY6DyF8hFwmg
   CcNGbeg+Nz3MLJKn3S+VBZRqbPzafuY6bcyAAFJzS5CrZh4UUXCwxVTYK
   JZAg6sOYlNhrYabtqXk1SPMfJ4ctZJJcOUydEplRh0DfW+gwowkwbW/v/
   JN8SzQxf9F4++lJzNb8BN+gJB9DWKdSENaAkgApSRvJdcsK5jXvJGg9G6
   kkLJV4HqygqEKocUV3hRKDMvuszITGPFYYmw9kawCE94K6kaq/IZtVRBG
   7crGGKDEk6IrktNcbH8YnRmxYzYkz9K5abyk4ifjh6SaL2Xp/hk9JfH6m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="472591285"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="472591285"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 13:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760788256"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="760788256"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 13:38:58 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	hq.dev+kernel@msdfc.xyz,
	Arpana Arland <arpanax.arland@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net] i40e: sync next_to_clean and next_to_process for programming status desc
Date: Thu, 19 Oct 2023 13:38:52 -0700
Message-ID: <20231019203852.3663665-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>

When a programming status desc is encountered on the rx_ring,
next_to_process is bumped along with cleaned_count but next_to_clean is
not. This causes I40E_DESC_UNUSED() macro to misbehave resulting in
overwriting whole ring with new buffers.

Update next_to_clean to point to next_to_process on seeing a programming
status desc if not in the middle of handling a multi-frag packet. Also,
bump cleaned_count only for such case as otherwise next_to_clean buffer
may be returned to hardware on reaching clean_threshold.

Fixes: e9031f2da1ae ("i40e: introduce next_to_process to i40e_ring")
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reported-by: hq.dev+kernel@msdfc.xyz
Reported by: Solomon Peachy <pizza@shaftnet.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217678
Tested-by: hq.dev+kernel@msdfc.xyz
Tested by: Indrek Järve <incx@dustbite.net>
Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 0b3a27f118fb..50c70a8e470a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2544,7 +2544,14 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 			rx_buffer = i40e_rx_bi(rx_ring, ntp);
 			i40e_inc_ntp(rx_ring);
 			i40e_reuse_rx_page(rx_ring, rx_buffer);
-			cleaned_count++;
+			/* Update ntc and bump cleaned count if not in the
+			 * middle of mb packet.
+			 */
+			if (rx_ring->next_to_clean == ntp) {
+				rx_ring->next_to_clean =
+					rx_ring->next_to_process;
+				cleaned_count++;
+			}
 			continue;
 		}
 

base-commit: ce55c22ec8b223a90ff3e084d842f73cfba35588
-- 
2.41.0


