Return-Path: <netdev+bounces-224829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB22B8AD59
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 282E07B81D4
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADFF3233E1;
	Fri, 19 Sep 2025 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n6jW3CLd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3D1322C90
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304466; cv=none; b=NlyDPsU6eVyvkgi5bV7WQfdLawQDWKuuRorHD2R1qPvsRPu7xMM2SWeIKX9X3PGNy7u9rdie+hK9J/qDZ4qN3Ivm/+xR0BNLsEkd4o0HOHKbZtmNxL0vpn2gHvlvUTtA+MnQJnzWaLvUvgZqWbRt2R5gVOQxRI7OUD3nsubyhQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304466; c=relaxed/simple;
	bh=rWj3Go506wx8XTPijqCRUIpgOBztnJAX4RbsbLiNCVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHCKJqnW6fl8J+w1XBC4yQaytYwyy5em1jYyHzIjrD3Vlr+VRnvWPM2NJB514isCcdV/qwUcARMQIRPPfNRubs5E0lFNjb2McEno7NettVBI2NWPAV+wphLAufRquRbNvVJG2Hnq5Gty8bv/hllkDpCsynxOkOYy4XlLxNS6rG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n6jW3CLd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758304465; x=1789840465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rWj3Go506wx8XTPijqCRUIpgOBztnJAX4RbsbLiNCVM=;
  b=n6jW3CLdrrp6lM+5GmuUE7gaQeMUkkUTZDACyk0Ouf7BmKjeMTxbVHAj
   q/I6Hsqi01gdvnrbHibhOQLaWMy9YTv63edPjAiTlknqabKomY5kKUg8D
   ZUpg+cUan+0QmAziEWcO34cefdtl+HAO2vJ3NvKKaVK9WNOE1Q53MP8EZ
   97+msQ6ccF67R1myptV1omTD7B7l8yQ3GZznFv0h1VnMGySFKuq5ZK5Uf
   71e1ydJLR9CL4Nka2A0x9S7K+QKfFDhP2LSLzYrNFGjSX5dSO6fT6XbXk
   s6jNIkJjlE4CNA9Mwrv1nBPxyIFhwEASBKkTZv9Ydevh4SCXXNdFURMAh
   w==;
X-CSE-ConnectionGUID: TqQD3qFKTpim8JgTa/pXmg==
X-CSE-MsgGUID: dhJC1glJTeW/lq/4XcRKxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="78097098"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="78097098"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:54:22 -0700
X-CSE-ConnectionGUID: Zl7yzj4pQCCofFmYQPFBaQ==
X-CSE-MsgGUID: Gs+3OWS7TF+fCUta7HpE5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176709497"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 10:54:21 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 6/7] ixgbevf: fix proper type for error code in ixgbevf_resume()
Date: Fri, 19 Sep 2025 10:54:09 -0700
Message-ID: <20250919175412.653707-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250919175412.653707-1-anthony.l.nguyen@intel.com>
References: <20250919175412.653707-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

The variable 'err' in ixgbevf_resume() is used to store the return value
of different functions, which return an int. Currently, 'err' is
declared as u32, which is semantically incorrect and misleading.

In the Linux kernel, u32 is typically reserved for fixed-width data
used in hardware interfaces or protocol structures. Using it for a
generic error code may confuse reviewers or developers into thinking
the value is hardware-related or size-constrained.

Replace u32 with int to reflect the actual usage and improve code
clarity and semantic correctness.

No functional change.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 535d0f71f521..28e25641b167 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -4323,7 +4323,7 @@ static int ixgbevf_resume(struct device *dev_d)
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
-	u32 err;
+	int err;
 
 	adapter->hw.hw_addr = adapter->io_addr;
 	smp_mb__before_atomic();
-- 
2.47.1


