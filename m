Return-Path: <netdev+bounces-28192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F0477E9D2
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0096F28182C
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EA517AD1;
	Wed, 16 Aug 2023 19:40:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA9417AD0
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 19:40:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8A12710
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 12:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692214802; x=1723750802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UtFfTQ6sjaZVVoelV5xkzeCbk4MZGHcrcDZ1p4xDDjE=;
  b=bN4IaFG9u+lkhgX/dbfsVNsZLwnesPvVvk56AfiwtJ5CYlBLsxJv2+Ah
   u/g9gfTxGY0VfYeZQVlcBZr3PfisMfDMiGc45MpggHDixYsmT8pTyE/D9
   SjHyQs+JacOgvaKyKxc6BHze2lETk9qyFpbz8lKNRgTmBSFV0EP1TBsgl
   YBRjIXUqy8YI8S4nEPe0OREZwUwUtSHM7z6g52tsJx2wCY0jnoQKu0fWn
   PvAOlAegQkE5+g91R561plmWQYwaxsZzeFxvoHIe+I3MNpH39eCkkTVEX
   fGF5uuCqfghl3N2ajiy4nlqonKL9rbORAEY30xS6/h8I7M19ch/kGXmLw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375386511"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="375386511"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 12:40:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="763749447"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="763749447"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2023 12:39:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Andrii Staikov <andrii.staikov@intel.com>,
	anthony.l.nguyen@intel.com,
	shannon.nelson@amd.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net 2/2] i40e: fix misleading debug logs
Date: Wed, 16 Aug 2023 12:33:08 -0700
Message-Id: <20230816193308.1307535-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230816193308.1307535-1-anthony.l.nguyen@intel.com>
References: <20230816193308.1307535-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Andrii Staikov <andrii.staikov@intel.com>

Change "write" into the actual "read" word.
Change parameters description.

Fixes: 7073f46e443e ("i40e: Add AQ commands for NVM Update for X722")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 9da0c87f0328..f99c1f7fec40 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -210,11 +210,11 @@ static int i40e_read_nvm_word_srctl(struct i40e_hw *hw, u16 offset,
  * @hw: pointer to the HW structure.
  * @module_pointer: module pointer location in words from the NVM beginning
  * @offset: offset in words from module start
- * @words: number of words to write
- * @data: buffer with words to write to the Shadow RAM
+ * @words: number of words to read
+ * @data: buffer with words to read to the Shadow RAM
  * @last_command: tells the AdminQ that this is the last command
  *
- * Writes a 16 bit words buffer to the Shadow RAM using the admin command.
+ * Reads a 16 bit words buffer to the Shadow RAM using the admin command.
  **/
 static int i40e_read_nvm_aq(struct i40e_hw *hw,
 			    u8 module_pointer, u32 offset,
@@ -234,18 +234,18 @@ static int i40e_read_nvm_aq(struct i40e_hw *hw,
 	 */
 	if ((offset + words) > hw->nvm.sr_size)
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "NVM write error: offset %d beyond Shadow RAM limit %d\n",
+			   "NVM read error: offset %d beyond Shadow RAM limit %d\n",
 			   (offset + words), hw->nvm.sr_size);
 	else if (words > I40E_SR_SECTOR_SIZE_IN_WORDS)
-		/* We can write only up to 4KB (one sector), in one AQ write */
+		/* We can read only up to 4KB (one sector), in one AQ write */
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "NVM write fail error: tried to write %d words, limit is %d.\n",
+			   "NVM read fail error: tried to read %d words, limit is %d.\n",
 			   words, I40E_SR_SECTOR_SIZE_IN_WORDS);
 	else if (((offset + (words - 1)) / I40E_SR_SECTOR_SIZE_IN_WORDS)
 		 != (offset / I40E_SR_SECTOR_SIZE_IN_WORDS))
-		/* A single write cannot spread over two sectors */
+		/* A single read cannot spread over two sectors */
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "NVM write error: cannot spread over two sectors in a single write offset=%d words=%d\n",
+			   "NVM read error: cannot spread over two sectors in a single read offset=%d words=%d\n",
 			   offset, words);
 	else
 		ret_code = i40e_aq_read_nvm(hw, module_pointer,
-- 
2.38.1


