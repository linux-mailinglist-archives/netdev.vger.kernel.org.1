Return-Path: <netdev+bounces-128754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF29697B7EE
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 08:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0FF1F23B5B
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 06:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE0B14C5BA;
	Wed, 18 Sep 2024 06:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BL+M17uM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EE3339A0;
	Wed, 18 Sep 2024 06:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726640790; cv=none; b=bmdspkJxT5e3uCxzj7XOpsIzhWARK6KAh0Bf+pZJVFat8qIqE8Nbfh1y5JJyvSrVZwpabFsEQ+RPONqUhfr5NDPs2OVWy23GTrqa/RfgxvtzlxIwhhy0RawzCRVMvJOmKn0g0ZOOjY+6I3dPJ4v4pWl5LshsKm30qFS9X3CKgkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726640790; c=relaxed/simple;
	bh=zSOYUxVDYof5O8HzjP7w7b3TgXQQUUKw4vi7RnEmVQA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uEtiiwa/n8scCSfzvOql42T04fYD2UHlY5ymWi6ZGa8pl+U94eeFz/0R3EyeYggzo97HR2QXhzgSzq1yg9JI54kwhY+d8SnVZgr2weJO2/otunH+1ZtPV5DjdYXMgvVGTV5br2lIBbasIsqO1CTDJi4YypM6scD9UGfB+5g+gQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BL+M17uM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726640789; x=1758176789;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zSOYUxVDYof5O8HzjP7w7b3TgXQQUUKw4vi7RnEmVQA=;
  b=BL+M17uMD0C/pqYX1YS41zYBSchrN4oSUCVc0LanAqydZ1fQuOstyaGo
   4lkpk9V+524xHM1ICAmyFgWl2Av2fFJRhekC4DYHj4cPW/zWHayTg08BF
   DeajqCcXmDHiOAcrexHeulUlLrcGt1kjroNdWVqH4s3nSi9vJicL33uSi
   gJfJD95xoiiCkof8Jr3RaIOTD/RYK7ZAoVKVpA9I4vjSBSQvohge4pOcW
   r0Ak8fh/O1NOpImCv4vE3Hrdy7TbU2v7modenm04QpZai2b5cfYJH05TI
   seQX/npO0NqfnNhfkUozW2Vx5Y7XUvS1LLJeNu+GrUu8aoS0LB1P0shRn
   Q==;
X-CSE-ConnectionGUID: kYX7OxzERd28AbIguTfvxg==
X-CSE-MsgGUID: zwqb6+KyTN+puc7uZQxbVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="29320981"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="29320981"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 23:26:28 -0700
X-CSE-ConnectionGUID: cof3tvK7TpKfLtSMiaEe2g==
X-CSE-MsgGUID: BP99Hid8QN67+/+d5Z4i8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="69300193"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 23:26:28 -0700
Received: from P12HL2yongliang.png.intel.com (P12HL2yongliang.png.intel.com [10.158.65.196])
	by linux.intel.com (Postfix) with ESMTP id 0530E20CFEE5;
	Tue, 17 Sep 2024 23:26:24 -0700 (PDT)
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Tan Khai Wen <khai.wen.tan@intel.com>
Subject: [PATCH net v2 1/1] net: stmmac: Fix zero-division error when disabling tc cbs
Date: Wed, 18 Sep 2024 14:14:22 +0800
Message-Id: <20240918061422.1589662-1-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit b8c43360f6e4 ("net: stmmac: No need to calculate speed divider
when offload is disabled") allows the "port_transmit_rate_kbps" to be
set to a value of 0, which is then passed to the "div_s64" function when
tc-cbs is disabled. This leads to a zero-division error.

When tc-cbs is disabled, the idleslope, sendslope, and credit values the
credit values are not required to be configured. Therefore, adding a return
statement after setting the txQ mode to DCB when tc-cbs is disabled would
prevent a zero-division error.

Fixes: b8c43360f6e4 ("net: stmmac: No need to calculate speed divider when offload is disabled")
Cc: <stable@vger.kernel.org>
Co-developed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
---
v2:
  - reflected code for better understanding
v1: https://patchwork.kernel.org/project/netdevbpf/patch/20240912015541.363600-1-khai.wen.tan@linux.intel.com/
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 832998bc020b..75ad2da1a37f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -386,6 +386,7 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 			return ret;
 
 		priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_DCB;
+		return 0;
 	}
 
 	/* Final adjustments for HW */
-- 
2.25.1


