Return-Path: <netdev+bounces-174154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1657A5D9E9
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4780816FE17
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EE723C8A8;
	Wed, 12 Mar 2025 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NytSCwUG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2007823BD0F
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773193; cv=none; b=bWKCKbnAlVtUmfNyUX/Ttrl6cUfsE4N+O8cj+XCLSK1XksG3MgRUPWWH0xDT61Ik5neoo6N4X8Huc94EL93scJCXrufRzN/EQs++jPKazpRWucPacNUvO2AKHg5zRDmEZBqexiC2OOAszXWWcdNQF3sBEvLi2tiNOhmbf/zI0cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773193; c=relaxed/simple;
	bh=or1UvSdSZuGCEhp1NCyS6XgY42ZgipUqsj466RaxgqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAK3ikl1rG4Nd7mW1fu1lqTuMcELb7XRvVxDMoa9TeFEgLbb2ZUITPSWpBeREsx3se/YhhsD9gomllF4HgGdgE8TU113/YPdtNkCYdhtV1r3Cilg5t7RnYueOWs4RkXcVOy/lhvTEfefuoNq4t3k7rZ5giPW/6uHww6upQglcvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NytSCwUG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741773192; x=1773309192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=or1UvSdSZuGCEhp1NCyS6XgY42ZgipUqsj466RaxgqE=;
  b=NytSCwUGPkHpfrvycixKmNOEA2sh1zShGrvCXz7bRcJOAXlYHyt6MCQw
   nXYnfwMkX961PkYFeSAOisC9U/YMyL7BSjr78wVuttW+utcOY5IUkMNBQ
   zG5/y5cuTrx7g74QAr5xqjPidjiAmNBMTuNSpyuVRgXVpmVaMaUXGs+Ks
   WwLcq1P7fiywJR9C5ZBlInNuqGHbjn2adtdyT0Ikc5V9JEvnpFpP/6uWZ
   pA++xnci8SR23e/ByZxFJpT7+3Uxxc0n//lNswnSraJuMFyDwo5c15Ytm
   awgtkeOjgcIr0qd2qPKasphqUfXaKY6JTSXJlotWJPd1a12dz/JhHQw98
   A==;
X-CSE-ConnectionGUID: 68kJwxNbQZW/7W2q3dm4MQ==
X-CSE-MsgGUID: Bfy0JMg4QN67pmYH/n2tSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="60246410"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="60246410"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 02:53:11 -0700
X-CSE-ConnectionGUID: 0THv90d2QeuoqmbV5qLjkQ==
X-CSE-MsgGUID: r6S9C1a7S6acDJfVawkjeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="151548128"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa001.fm.intel.com with ESMTP; 12 Mar 2025 02:53:08 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pierre@stackhpc.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	christophe.leroy@csgroup.eu,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH net v2 3/3] phy: fix xa_alloc_cyclic() error handling
Date: Wed, 12 Mar 2025 10:52:51 +0100
Message-ID: <20250312095251.2554708-4-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
References: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xa_alloc_cyclic() can return 1, which isn't an error. To prevent
situation when the caller of this function will treat it as no error do
a check only for negative here.

Fixes: 384968786909 ("net: phy: Introduce ethernet link topology representation")
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/phy/phy_link_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index 4a5d73002a1a..0e9e987f37dd 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -73,7 +73,7 @@ int phy_link_topo_add_phy(struct net_device *dev,
 				      xa_limit_32b, &topo->next_phy_index,
 				      GFP_KERNEL);
 
-	if (ret)
+	if (ret < 0)
 		goto err;
 
 	return 0;
-- 
2.42.0


