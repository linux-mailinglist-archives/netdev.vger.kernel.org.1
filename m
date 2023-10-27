Return-Path: <netdev+bounces-44816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E76B7D9F33
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 20:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04AD1C2100B
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 18:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC8B3B7B7;
	Fri, 27 Oct 2023 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bbf+SujN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84483B781
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 17:59:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8C91A1
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698429593; x=1729965593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w8SX7WBgo35+IW7TgXe6OEceT+IApuxuDWdjvxMn610=;
  b=Bbf+SujNrdGgwVPpFyLt21zffkRFYr2MJ54rP6Bu/Vk4WdSGvII/yX3F
   3yP1AXKNXDTVbQ1MCBAZm8q/G5C/VPBtHpGt8xmJS5bu1TNIi+Z0+9olH
   cANpl95EFbQvTxfLgtfVYi+kSQlrctbDpL+NftRQWDmy44Ibike9z3Kgj
   U/EB6cWYxZx7LtLRd8Qi8z7UshDLCnWZs0xo5K69fR0kZ5m2+zkrP8PaH
   ddVqzfFdmgL0Bk1b9a3QSYV5FSrlcy+OD1LpvgcB35MCf7KByY7lAW/Bc
   kPerzb3+KAsIJLwuELW9PhVgCYpfzm9nou0rOAAJ9M1iH3x2+XoXoFsfm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="391695509"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="391695509"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 10:59:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="830064621"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="830064621"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 10:59:47 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v2 2/8] iavf: simplify mutex_trylock+sleep loops
Date: Fri, 27 Oct 2023 10:59:35 -0700
Message-ID: <20231027175941.1340255-3-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027175941.1340255-1-jacob.e.keller@intel.com>
References: <20231027175941.1340255-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Schmidt <mschmidt@redhat.com>

This pattern appears in two places in the iavf source code:
  while (!mutex_trylock(...))
      usleep_range(...);

That's just mutex_lock with extra steps.
The pattern is a leftover from when iavf used bit flags instead of
mutexes for locking. Commit 5ac49f3c2702 ("iavf: use mutexes for locking
of critical sections") replaced test_and_set_bit with !mutex_trylock,
preserving the pattern.

Simplify it to mutex_lock.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
No changes since v1.

 drivers/net/ethernet/intel/iavf/iavf_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index fefed96f8035..502ebba2e879 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3011,8 +3011,7 @@ static void iavf_reset_task(struct work_struct *work)
 		return;
 	}
 
-	while (!mutex_trylock(&adapter->client_lock))
-		usleep_range(500, 1000);
+	mutex_lock(&adapter->client_lock);
 	if (CLIENT_ENABLED(adapter)) {
 		adapter->flags &= ~(IAVF_FLAG_CLIENT_NEEDS_OPEN |
 				    IAVF_FLAG_CLIENT_NEEDS_CLOSE |
@@ -5065,8 +5064,7 @@ static int __maybe_unused iavf_suspend(struct device *dev_d)
 
 	netif_device_detach(netdev);
 
-	while (!mutex_trylock(&adapter->crit_lock))
-		usleep_range(500, 1000);
+	mutex_lock(&adapter->crit_lock);
 
 	if (netif_running(netdev)) {
 		rtnl_lock();
-- 
2.41.0


