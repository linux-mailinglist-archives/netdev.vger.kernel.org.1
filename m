Return-Path: <netdev+bounces-148701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 650469E2E87
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE67281689
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D513320CCF7;
	Tue,  3 Dec 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2s2YxKY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3EB20C497
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262937; cv=none; b=C8akR/0Llc1XEArFasFjjlgUmzbAYrwHGdj5oHAVWTu/tRQ9xdl9r7fukXenfqwI+xkPf4Nw0OeTRQjKxz0FmcP2Ghz6BXSncelLFUKQqlweukOsnkbrHI4fYdRJplQKlwDhyTOxEzjvey2RNmXDeOszKtSlJXb55cXm3jqhNLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262937; c=relaxed/simple;
	bh=mfWak91xVrSV62CVvvx7Nmp4Ro6KIxjB0GgynmGCXHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4YP054DaQl69dlHjQeYqhYXoadLd2dtxA57/+imEUVtmeWAM51rrd8c93tKoyLw9M5H/hom9DfGJopFoLsuvR279Ok+OBqtB/Lf+7qyrTtZRRLgMHwpgkjWCW+6neryJHpsXcA5USih/ctT9dQWKbmLYT2CSNTsOlH9b92f5ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2s2YxKY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733262936; x=1764798936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mfWak91xVrSV62CVvvx7Nmp4Ro6KIxjB0GgynmGCXHo=;
  b=Y2s2YxKYs4RyFFnKXiEkrjfMzJ8bQIZHeUJ2ni0zIAgEblVgvBR6dAyY
   kv+ffseSgCO4KCUVbEtYyzqPgVMHxgHV65LdhVxOsPR+slypHstXZb3dy
   r5BR4CaqbaVSmU9+otH9MEaXIfBuaivDnNIpJV7XTce6YxZQ66TlXzrfO
   y0fy3xRNWQD0SEzxJ/gazUh9HBaIt+YXTqaLEvqiQsq99VG2u0VpsuJqw
   Fy5si0I6B3VZfJ6o5fMoHHZFIn2HTgq4cs9ai8KpUfoLvA3cpKRyYFm1n
   Z4KvEI+g47VYm1iLtGZpuSEyF3GWZvUHxTQ/yDGLJiGEVs9gD2DYnPygH
   w==;
X-CSE-ConnectionGUID: C9bawt0rSuCODSaVSEKC3w==
X-CSE-MsgGUID: dczZMUTSRZiPq4u3YmD80g==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="21087167"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="21087167"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 13:55:30 -0800
X-CSE-ConnectionGUID: 8P9D0qBUTuKBrwCxu2jabw==
X-CSE-MsgGUID: ymLP07nbRSq2QXnV/2VwXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98578894"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 03 Dec 2024 13:55:30 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Yuan Can <yuancan@huawei.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 9/9] igb: Fix potential invalid memory access in igb_init_module()
Date: Tue,  3 Dec 2024 13:55:18 -0800
Message-ID: <20241203215521.1646668-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241203215521.1646668-1-anthony.l.nguyen@intel.com>
References: <20241203215521.1646668-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuan Can <yuancan@huawei.com>

The pci_register_driver() can fail and when this happened, the dca_notifier
needs to be unregistered, otherwise the dca_notifier can be called when
igb fails to install, resulting to invalid memory access.

Fixes: bbd98fe48a43 ("igb: Fix DCA errors and do not use context index for 82576")
Signed-off-by: Yuan Can <yuancan@huawei.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 08578980b651..288a4bb2683a 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -637,6 +637,10 @@ static int __init igb_init_module(void)
 	dca_register_notify(&dca_notifier);
 #endif
 	ret = pci_register_driver(&igb_driver);
+#ifdef CONFIG_IGB_DCA
+	if (ret)
+		dca_unregister_notify(&dca_notifier);
+#endif
 	return ret;
 }
 
-- 
2.42.0


