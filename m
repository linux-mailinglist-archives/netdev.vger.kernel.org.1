Return-Path: <netdev+bounces-61692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAA6824A47
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 22:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53FB1F23466
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 21:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8360B2C6A1;
	Thu,  4 Jan 2024 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XCTK7hbA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8122C69A
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704403627; x=1735939627;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hp9pgGU/PpedTMTHfhSQrQJ1TiWYFTILkrRJwX0gXr4=;
  b=XCTK7hbAeKWCtRasxMBvXHzcl2l2dM0qAOxvWHjIvYzNMvInAZMzkJOG
   Pa/+cr2RXMSJrwLjkZ1FmYxVMXtPuoEediKanzK0cyif7HgDbydVAcLvY
   J7GmEeUm+yqpJVjnAZf8nwWk59QRokoj89GFGT6/iDjoikCsmcFH0wRQs
   qGmPhGMy1oVfh9yEEeRXV3IL3u6S56EmKiNSJo6BJOyKXugfHTDq8Y3mu
   PJSRFFD9R832AytH+WGgy4eMPRYdV+lYuHrf+2qFXENDFO+GsABp+ltux
   eUAJEV1/eIBhAg7ndTXNQ4cIYxECeH8n63CEhuNlH+qJuEX2Z9lMgQ2qe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="401151890"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="401151890"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 13:27:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="924039938"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="924039938"
Received: from bmhoefer-mobl.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.249.36.224])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 13:27:03 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: corbet@lwn.net,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com,
	andrew@lunn.ch,
	horms@kernel.org,
	mkubecek@suse.cz,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next 1/1] net: ethtool: reject unsupported RSS input xfrm values
Date: Thu,  4 Jan 2024 14:26:53 -0700
Message-Id: <20240104212653.394424-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RXFH input_xfrm currently has three supported values: 0 (clear all),
symmetric_xor and NO_CHANGE.

Reject any other value sent from user-space.

Fixes: 13e59344fb9d ("net: ethtool: add support for symmetric-xor RSS hash")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 net/ethtool/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 4bc9a2a07bbb..7519b0818b91 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1302,6 +1302,9 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	if (rxfh.rss_context && !ops->cap_rss_ctx_supported)
 		return -EOPNOTSUPP;
 	/* Check input data transformation capabilities */
+	if (rxfh.input_xfrm && rxfh.input_xfrm != RXH_XFRM_SYM_XOR &&
+	    rxfh.input_xfrm != RXH_XFRM_NO_CHANGE)
+		return -EINVAL;
 	if ((rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
 	    !ops->cap_rss_sym_xor_supported)
 		return -EOPNOTSUPP;
-- 
2.34.1


