Return-Path: <netdev+bounces-69958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E5A84D22A
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EBA286B8D
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1593985946;
	Wed,  7 Feb 2024 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PH6e/laI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4461F8563B
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707333428; cv=none; b=VWduOALCqya9bZOwbTtp/5W2H498dlj/1JAYABqSTHWQX9oupGSBYqyDLxPMxFBfl87gw5TJgTiHvqts0hRchXDVyJJ+oBfxZILg/ut7+uZ6K+LpMivnG5WFuv6ZiEme/wSr+hJEtkUpU6nVvN1ytLp4/ev7V6bh3GQB7stKDLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707333428; c=relaxed/simple;
	bh=QcMkGcNNF4reIOtw9t+7RDAg2WXuqs0V8i+Zj8h2a/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0hqBqfGSTR/lYMKmSeX6AcHcm4mO6ArE7riTcez+BAgx0Yr9RMQ8WFmFfC3EaPzixoNa/YevM2uvGWQ3ZPiyuyDGmLXPs9peyLtyE7A4AlwlEQi77UI3nQotzMJ8MNqODDVsuPCHzLJLBBb1Ad01nuhLAZ4UtRWA5jUcPKvIsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PH6e/laI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707333426; x=1738869426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QcMkGcNNF4reIOtw9t+7RDAg2WXuqs0V8i+Zj8h2a/A=;
  b=PH6e/laIWGIEO0cIADR6oZzj4PupT9kRg6S67dBByJMbTXXnbDv52Pzp
   SfaMFOYz1SvyDw/WV53W2XXJaBtT7k96XQ+Fo/keG+73H0bTYOR4qUwrx
   7y+OShl0zIp7R033doXvpCPyques3CGrRa4n91AZ9XK2MiTqrDoRg0hPE
   IYTVIm1SbmXAYneRz+G4HrqEifSj82XCzpdHXSeqISWfvb0NMZqojIXbZ
   y1OEaQEagKgHLP64+IA+6plFSyFdXJ1B/4ddc2MYOFjvQfQpOrfhz33/U
   CYhhvfJCbZ8nbh+mJsV46qBE1liOqk5uTWOlee0q8lI+m44FHI6+ewG9x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="953472"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="953472"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 11:17:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1780659"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 07 Feb 2024 11:17:03 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Simon Horman <horms@kernel.org>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net-next 1/3] igc: Use reverse xmas tree
Date: Wed,  7 Feb 2024 11:16:52 -0800
Message-ID: <20240207191656.1250777-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240207191656.1250777-1-anthony.l.nguyen@intel.com>
References: <20240207191656.1250777-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kurt Kanzenbach <kurt@linutronix.de>

Use reverse xmas tree coding style convention in igc_add_flex_filter().

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ba8d3fe186ae..4b3faa9a667f 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3577,9 +3577,9 @@ static bool igc_flex_filter_in_use(struct igc_adapter *adapter)
 static int igc_add_flex_filter(struct igc_adapter *adapter,
 			       struct igc_nfc_rule *rule)
 {
-	struct igc_flex_filter flex = { };
 	struct igc_nfc_filter *filter = &rule->filter;
 	unsigned int eth_offset, user_offset;
+	struct igc_flex_filter flex = { };
 	int ret, index;
 	bool vlan;
 
-- 
2.41.0


