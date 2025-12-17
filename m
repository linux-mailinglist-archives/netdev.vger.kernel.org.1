Return-Path: <netdev+bounces-245238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A49E9CC970F
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 20:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A097B301CDB2
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 19:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D2E2F8BC3;
	Wed, 17 Dec 2025 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+LkbpkD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0742F6170
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766001007; cv=none; b=fn7dRArLMHa1QbvVDhFcjZ4DdLT8KHzcBk3p+M7YHRvqmRxrc3LXiffv5NzxmO3OGjpwE1gfiwVrfVuul3ZNxiQFwoY4dpWqukRXQBBxWk4yPl+0u6goPtCIWjXRLHfMCrIAngIHjM372eacYLtuIJtXWm0rZaj8yD05V0SvZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766001007; c=relaxed/simple;
	bh=Vfhq8bWSR5vPbQF3UAiZ7r9T4KAwwg1X8LJmbb1dips=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgeConkHW5nYiLvO7h0j19Y0YOpe5w23lXRen6+/Dogoi9+I3eZwht1Rh9EcuJ0iwwdXId67zLm2ICWcsXVRUXH5+z+FUcJ4dtML4Lb50kbbsJHA+T1XlMekju5MPVZ91JRcXqQpqB6vVXNwAR102f90d+L0pj2RRNx4PmFMeQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+LkbpkD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766001006; x=1797537006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vfhq8bWSR5vPbQF3UAiZ7r9T4KAwwg1X8LJmbb1dips=;
  b=P+LkbpkD1r/NP2fmrFgg5JUqvDNCG3/oOky5gmOuvb5rX175c4itVW8u
   unmm3tM4WVKEpA94JKEjr2ItzvWhZVvlZxZIEwcgqFMGncO10N/7hzRje
   Pv5fgT5zpSo1AnO5G+hM2KatsoauV/57ga/9xR91OPzitKKnLd6dmVfli
   sjDIoAxgxTi4RimtqDv7bLk6uFpSSuP3ZCy6fozEDMYpC03Q3ayxSCNbj
   4sTMLpAl5u75rNNuasGTHPV5pfuXiBWi+m/EwcZd8sr4PXJ/Y/bWnDEJR
   dkTGQPPwNhGX1HH9Is4TLqhQL2ktlKz+KuxnPOLLdw9DlyCKuXF/vM9ZR
   Q==;
X-CSE-ConnectionGUID: YicSn3xsSjy5eDM68DY9Fg==
X-CSE-MsgGUID: LnSPjKOkQIWpKTMlAb6nMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="67841446"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="67841446"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 11:50:02 -0800
X-CSE-ConnectionGUID: MOTF6ijOTx+ZrqMsnspUew==
X-CSE-MsgGUID: uef/J1KVQPSNNfczrHmamg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="202898049"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 17 Dec 2025 11:50:02 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Brian Vazquez <brianvv@google.com>,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 5/6] idpf: reduce mbx_task schedule delay to 300us
Date: Wed, 17 Dec 2025 11:49:44 -0800
Message-ID: <20251217194947.2992495-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251217194947.2992495-1-anthony.l.nguyen@intel.com>
References: <20251217194947.2992495-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Vazquez <brianvv@google.com>

During the IDPF init phase, the mailbox runs in poll mode until it is
configured to properly handle interrupts. The previous delay of 300ms is
excessively long for the mailbox polling mechanism, which causes a slow
initialization of ~2s:

echo 0000:06:12.4 > /sys/bus/pci/drivers/idpf/bind

[   52.444239] idpf 0000:06:12.4: enabling device (0000 -> 0002)
[   52.485005] idpf 0000:06:12.4: Device HW Reset initiated
[   54.177181] idpf 0000:06:12.4: PTP init failed, err=-EOPNOTSUPP
[   54.206177] idpf 0000:06:12.4: Minimum RX descriptor support not provided, using the default
[   54.206182] idpf 0000:06:12.4: Minimum TX descriptor support not provided, using the default

Changing the delay to 300us avoids the delays during the initial mailbox
transactions, making the init phase much faster:

[   83.342590] idpf 0000:06:12.4: enabling device (0000 -> 0002)
[   83.384402] idpf 0000:06:12.4: Device HW Reset initiated
[   83.518323] idpf 0000:06:12.4: PTP init failed, err=-EOPNOTSUPP
[   83.547430] idpf 0000:06:12.4: Minimum RX descriptor support not provided, using the default
[   83.547435] idpf 0000:06:12.4: Minimum TX descriptor support not provided, using the default

Fixes: 4930fbf419a7 ("idpf: add core init and interrupt request")
Signed-off-by: Brian Vazquez <brianvv@google.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 7a7e101afeb6..7ce4eb71a433 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1271,7 +1271,7 @@ void idpf_mbx_task(struct work_struct *work)
 		idpf_mb_irq_enable(adapter);
 	else
 		queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task,
-				   msecs_to_jiffies(300));
+				   usecs_to_jiffies(300));
 
 	idpf_recv_mb_msg(adapter);
 }
-- 
2.47.1


