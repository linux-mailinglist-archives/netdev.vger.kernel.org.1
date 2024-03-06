Return-Path: <netdev+bounces-78128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59661874267
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5031C22C56
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 22:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADFE1BC4D;
	Wed,  6 Mar 2024 22:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJJVvMC/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1931B951
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762825; cv=none; b=lHM99rlOo4IP3QzyGRIKJMEoTDIKcHRnQ6vkdk5RcrK0xCbK1IlO9SALFYK0Nhdl6DVaNzkfC4k0tym6KQMtLGZLJvaAQ/q7bnIdt1Dam1ziQCkgH/517HVo15vpY+bV7n/NgF0mhlCqrBwVlvMGHS7/L6qDQQm1Lc3awGs3Go0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762825; c=relaxed/simple;
	bh=ddWclsIrZmG7DcuYqq8CTQqxVac+nM7UabRFsnBt9Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9lky2rOVIHdQ4RfH3qjjEZZEqM7KjFr15es0gGwh39kT8r6sMi33Aohu3WDxZl7Xg1OlJMyTJW6OCQs5jVMZy0j009e+ldCegdYLA4e2SSw/RQaaVkAlUIDiqTlizRFtDA0TCQmBG/UZCGtQz8xGJ2yAbKlneeURDPykODC7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJJVvMC/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709762824; x=1741298824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ddWclsIrZmG7DcuYqq8CTQqxVac+nM7UabRFsnBt9Z4=;
  b=mJJVvMC/aOsMU1hwwZ0pIwi5hy8C1k1ECGP+kOxyLSwIhwbUqFpm/wlJ
   OuNbJNsqvcqKITnmzH4uBSlZVncTiKP0r/LCh/+e7DnHsEo8KPznTP0b5
   pJO+ijjjAOicH7YglMUuaXY847VM8ewdgGlCXsWMf2P2AmrKq5q/fObgN
   K1cenbS4plb+cg31t+iuX50IXxmuCou9hAQ7ltYTcP5wAOPQGaknjvrvF
   S6I8fA061ZKa93aznQc7wytHQxygVxV4tvmsF80XW/KioIrDjk9LMVC6T
   0k2fShOvDI7+J2ZxmSFFAuhQ7tWn9nWlvXUdLcZWHix2bJPRNAF+uc0yY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4982622"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="4982622"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 13:56:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="9979671"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 06 Mar 2024 13:56:19 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
	anthony.l.nguyen@intel.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next 1/3] iavf: drop duplicate iavf_{add|del}_cloud_filter() calls
Date: Wed,  6 Mar 2024 13:56:11 -0800
Message-ID: <20240306215615.970308-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240306215615.970308-1-anthony.l.nguyen@intel.com>
References: <20240306215615.970308-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>

There are currently two pairs of identical checks and calls
to iavf_{add|del}_cloud_filter().

Detected using the static analysis tool - Svace.

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index aefec6bd3b67..ef2440f3abf8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2170,19 +2170,10 @@ static int iavf_process_aq_command(struct iavf_adapter *adapter)
 		iavf_add_cloud_filter(adapter);
 		return 0;
 	}
-
-	if (adapter->aq_required & IAVF_FLAG_AQ_DEL_CLOUD_FILTER) {
-		iavf_del_cloud_filter(adapter);
-		return 0;
-	}
 	if (adapter->aq_required & IAVF_FLAG_AQ_DEL_CLOUD_FILTER) {
 		iavf_del_cloud_filter(adapter);
 		return 0;
 	}
-	if (adapter->aq_required & IAVF_FLAG_AQ_ADD_CLOUD_FILTER) {
-		iavf_add_cloud_filter(adapter);
-		return 0;
-	}
 	if (adapter->aq_required & IAVF_FLAG_AQ_ADD_FDIR_FILTER) {
 		iavf_add_fdir_filter(adapter);
 		return IAVF_SUCCESS;
-- 
2.41.0


