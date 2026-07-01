Return-Path: <netdev+bounces-303836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ypwVBCCCRWpnBQsAu9opvQ
	(envelope-from <netdev+bounces-303836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:09:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 828686F1C14
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:09:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=hpSTWuwa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303836-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303836-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD224316196A
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778D73ACF05;
	Wed,  1 Jul 2026 21:03:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164B83ACEF8
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:03:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939805; cv=none; b=cEI+GEsJvrWYZ8D+bQ2mhcImqISHF1T4CRtSQR2lXbWBJRmW28Mz95FLY6hMUdoGBYRImSaQHkjvTMF6if1svrsfi5+JLnQUCbz82EevxoJhtFc0TzfgEy70KO91He1piG54cpsh/sLRZY0ABLL5xaqmNM5f8YTjfaTWABriowc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939805; c=relaxed/simple;
	bh=MvHDmCUvlIVPDEPwfR0vsZa4Bxv0NGkthAgXNZUPvpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMKGKCdJeBl76gLnqkYKcOVnXBqOB3K+YT+VEN0XoTazCfnUCqkc3LPVMoyiNvsQP8dPtSTvqKZnazMHoNd6G1Yq41WKL994WA/l6yIrWi/oWExCc1ykEVYZNk6ovPEW1kC/rLajVHDhL3LBY32balzYLAqGbuBp7wHEVEQZRLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpSTWuwa; arc=none smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782939795; x=1814475795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MvHDmCUvlIVPDEPwfR0vsZa4Bxv0NGkthAgXNZUPvpY=;
  b=hpSTWuwafUMd22Q0fDXdLXs5kYxNN14jxh29dWq6tTe2ejd8DcC8NNcy
   BJYpZ6K2+jGvq+bA2sCocjPtV+W6p0Mt5g3BkjatoiMQcLSO5DbNI+vai
   XtaN1tX0wlCuVQcMz7NNQ09RXpc/gF9kIt5tvIP1IMGiG6kskwaJO9blq
   0EODL58d8wK5denuMHxuQIcP9PRgEPuCs+TeT0yNcOTIQVK8NwZKMQ0WM
   sQ77c6LiDp+y2+Th6Co9a5+sOLgdMWCe73/ivw/HnQXue+8e155eQ/xC0
   B8YvMt6fm4YL8swCoOGZgwOv9bT8OSwGFY1S8BG/V3aHFWpydBkoNiAA0
   A==;
X-CSE-ConnectionGUID: sKeSgA/GQdaCg+LWWmyKzg==
X-CSE-MsgGUID: QiiS6fRNSAarmo6nWnV4mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="95069147"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="95069147"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 14:03:13 -0700
X-CSE-ConnectionGUID: 45X8DMZjS4+nUP0/u7IsQA==
X-CSE-MsgGUID: Osrx3eh/TGGyRQ0KgPPBbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="257561428"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 01 Jul 2026 14:03:13 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	khai.wen.tan@intel.com,
	khai.wen.tan@linux.intel.com,
	faizal.abdul.rahim@intel.com,
	hong.aun.looi@intel.com,
	hector.blanco.alcaine@intel.com,
	dima.ruinskiy@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Moriya Kadosh <moriyax.kadosh@intel.com>
Subject: [PATCH net-next 09/11] igc: move autoneg-enabled settings into igc_handle_autoneg_enabled()
Date: Wed,  1 Jul 2026 14:02:58 -0700
Message-ID: <20260701210303.1745310-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
References: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303836-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:faizal.abdul.rahim@linux.intel.com,m:anthony.l.nguyen@intel.com,m:khai.wen.tan@intel.com,m:khai.wen.tan@linux.intel.com,m:faizal.abdul.rahim@intel.com,m:hong.aun.looi@intel.com,m:hector.blanco.alcaine@intel.com,m:dima.ruinskiy@intel.com,m:aleksandr.loktionov@intel.com,m:horms@kernel.org,m:moriyax.kadosh@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 828686F1C14

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Move the advertised link modes and flow control configuration from
igc_ethtool_set_link_ksettings() into igc_handle_autoneg_enabled().

No functional change.

Reviewed-by: Looi Hong Aun <hong.aun.looi@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Signed-off-by: Khai Wen Tan <khai.wen.tan@linux.intel.com>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Moriya Kadosh <moriyax.kadosh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 72 ++++++++++++--------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index fbba3e84673a..7ee84c24dc4e 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -2032,6 +2032,49 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 	return 0;
 }
 
+/**
+ * igc_handle_autoneg_enabled - Configure autonegotiation advertisement
+ * @adapter: private driver structure
+ * @cmd: ethtool link ksettings from user
+ *
+ * Records advertised speeds and flow control settings when autoneg
+ * is enabled.
+ */
+static void igc_handle_autoneg_enabled(struct igc_adapter *adapter,
+				       const struct ethtool_link_ksettings *cmd)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u16 advertised = 0;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  2500baseT_Full))
+		advertised |= ADVERTISE_2500_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  1000baseT_Full))
+		advertised |= ADVERTISE_1000_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  100baseT_Full))
+		advertised |= ADVERTISE_100_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  100baseT_Half))
+		advertised |= ADVERTISE_100_HALF;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  10baseT_Full))
+		advertised |= ADVERTISE_10_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  10baseT_Half))
+		advertised |= ADVERTISE_10_HALF;
+
+	hw->phy.autoneg_advertised = advertised;
+	if (adapter->fc_autoneg)
+		hw->fc.requested_mode = igc_fc_default;
+}
+
 static int
 igc_ethtool_set_link_ksettings(struct net_device *netdev,
 			       const struct ethtool_link_ksettings *cmd)
@@ -2039,7 +2082,6 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	struct net_device *dev = adapter->netdev;
 	struct igc_hw *hw = &adapter->hw;
-	u16 advertised = 0;
 
 	/* When adapter in resetting mode, autoneg/speed/duplex
 	 * cannot be changed
@@ -2064,34 +2106,8 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
 	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
 		usleep_range(1000, 2000);
 
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  2500baseT_Full))
-		advertised |= ADVERTISE_2500_FULL;
-
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  1000baseT_Full))
-		advertised |= ADVERTISE_1000_FULL;
-
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  100baseT_Full))
-		advertised |= ADVERTISE_100_FULL;
-
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  100baseT_Half))
-		advertised |= ADVERTISE_100_HALF;
-
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  10baseT_Full))
-		advertised |= ADVERTISE_10_FULL;
-
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  10baseT_Half))
-		advertised |= ADVERTISE_10_HALF;
-
 	if (cmd->base.autoneg == AUTONEG_ENABLE) {
-		hw->phy.autoneg_advertised = advertised;
-		if (adapter->fc_autoneg)
-			hw->fc.requested_mode = igc_fc_default;
+		igc_handle_autoneg_enabled(adapter, cmd);
 	} else {
 		netdev_info(dev, "Force mode currently not supported\n");
 	}
-- 
2.47.1


