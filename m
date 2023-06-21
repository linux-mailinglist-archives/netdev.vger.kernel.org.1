Return-Path: <netdev+bounces-12608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42A17384D2
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CC6281590
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 13:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41D0174D8;
	Wed, 21 Jun 2023 13:21:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB11C11CA1
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:21:25 +0000 (UTC)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1649219B5
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687353684; x=1718889684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WH66lIuJlNBisUbKjuxmSU8egBjiug1TIhdPnlf9yiU=;
  b=Z9CQrLLpjBk76ai2Q1UexUObKMZv28y5lJ+wq6ZG+AD9KcD0LBwX79gp
   55tpnOCrs8DER1i79hHoQ3KZ3dPJi8vL2aakg2w9n38nss+44KD9lr68l
   BMnxSEt2/nA6/AXpyQFk0bN+i5mQlN7uewqVeq3pVzb789bKBc3GlYJvO
   Mdkzir3MEsnp9IQ3RR7+iY4a+dTT1ScMYqxvPsOUo4wf94r1N3qiPBISH
   lUgksteXLQoFHL8D+CoqSMC1sFUom74+M7fko4r8F96el8VZ7TqVc1VTy
   4GGPs//P/d9S7asyYUeqmHgfc+NaM1S+44NGFiWGxNGxv113w+M5E/5f9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="423831892"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="423831892"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 06:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="888651095"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="888651095"
Received: from pgardocx-hp-z6-g4-workstation.igk.intel.com (HELO pgardocx-mobl1.igk.intel.com) ([10.237.95.41])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 06:21:13 -0700
From: Piotr Gardocki <piotrx.gardocki@intel.com>
To: netdev@vger.kernel.org
Cc: piotrx.gardocki@intel.com,
	intel-wired-lan@lists.osuosl.org,
	przemyslaw.kitszel@intel.com,
	michal.swiatkowski@linux.intel.com,
	pmenzel@molgen.mpg.de,
	kuba@kernel.org,
	maciej.fijalkowski@intel.com,
	anthony.l.nguyen@intel.com,
	simon.horman@corigine.com,
	aleksander.lobakin@intel.com,
	gal@nvidia.com
Subject: [PATCH net-next] net: fix net device address assign type
Date: Wed, 21 Jun 2023 15:21:06 +0200
Message-Id: <20230621132106.991342-1-piotrx.gardocki@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit ad72c4a06acc introduced optimization to return from function
quickly if the MAC address is not changing at all. It was reported
that such change causes dev->addr_assign_type to not change
to NET_ADDR_SET from _PERM or _RANDOM.
Restore the old behavior and skip only call to ndo_set_mac_address.

Fixes: ad72c4a06acc ("net: add check for current MAC address in dev_set_mac_address")
Reported-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
---
 net/core/dev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e4ff0adf5523..69a3e544676c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8781,14 +8781,14 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 		return -EINVAL;
 	if (!netif_device_present(dev))
 		return -ENODEV;
-	if (!memcmp(dev->dev_addr, sa->sa_data, dev->addr_len))
-		return 0;
 	err = dev_pre_changeaddr_notify(dev, sa->sa_data, extack);
 	if (err)
 		return err;
-	err = ops->ndo_set_mac_address(dev, sa);
-	if (err)
-		return err;
+	if (memcmp(dev->dev_addr, sa->sa_data, dev->addr_len)) {
+		err = ops->ndo_set_mac_address(dev, sa);
+		if (err)
+			return err;
+	}
 	dev->addr_assign_type = NET_ADDR_SET;
 	call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
 	add_device_randomness(dev->dev_addr, dev->addr_len);
-- 
2.34.1


