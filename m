Return-Path: <netdev+bounces-186146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2433A9D489
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7DD169454
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C185226183;
	Fri, 25 Apr 2025 21:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFD96xjh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1DE2192F3
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617959; cv=none; b=NJlLNtO0TeipDiNpEcgWRFtFyVto0TLsM60G97HxojjsWYlVFAQVkPltGetXkKUP8/zIE40rChw4glMlwfYGD/eRrgGI69IIU/c9wbnNSCKiQO2Y8xvwiIRP7o9PzCwKdhSxuZwqSRNq6/Lb8dcF+ouKZgDtnmz/8uUM/uPPdus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617959; c=relaxed/simple;
	bh=6jpiEaJsmry/V79v42qwkjPt7HsP6WjY/tDnyAOBWnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lf7tNNhXBL9rEAwyAFanV/NG03Q4g9f9Qi/VTwVJR4Pr2Dw0xui9MdTJXSi+9YyfBeHf3pZlmYfLLo9hFQMt7pB5TyqqmuoVrzUmto9IvZSxGDBfy9VFyWhCujdIoOIStNS5q9BxEUaj8KOcP8aZw0FiU9v3RY0EMcx3RsMLd5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFD96xjh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745617958; x=1777153958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6jpiEaJsmry/V79v42qwkjPt7HsP6WjY/tDnyAOBWnY=;
  b=dFD96xjhgKNTnFuRsW20DOccr14FyA3M/Va4drctfocWvIRC0WFBHKId
   laV+V+w5C9OzWN/30X1fEzjUV+N7zGkTh0InwYcW6kv5tDKJZSD7WNpkG
   PTZV+D94iWXNdY5USMv8uIXk4WjVkmfAodAkLAHOyaRV60nInsOsNpJlM
   grLkMgdPPMwXrdchLN0OWLxYCJzDQwx0NxyYxJr9XlsxSWYqNq0FsBeQr
   74eO7JYapTsq3e3JOXm952q1dVC/iaE3Me1DhTQZ393GtNZ3Dmj+tXCWg
   NjZjZLyzR9o78C/TxaGnNsZGJ7nCs04ELx6vhoxPetlRDhMoMg16/DS19
   Q==;
X-CSE-ConnectionGUID: YibTJJl0RKyh6YdTjdS5vA==
X-CSE-MsgGUID: xBDMWVZcRa+KErkdKgO3MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="69784526"
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="69784526"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 14:52:36 -0700
X-CSE-ConnectionGUID: 4T7hai0jSXapn/EiIume9Q==
X-CSE-MsgGUID: VeaBTC35SIKM3lIu2dxEkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="163973505"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 25 Apr 2025 14:52:36 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Milena Olech <milena.olech@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	richardcochran@gmail.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next v2 01/11] idpf: change the method for mailbox workqueue allocation
Date: Fri, 25 Apr 2025 14:52:15 -0700
Message-ID: <20250425215227.3170837-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425215227.3170837-1-anthony.l.nguyen@intel.com>
References: <20250425215227.3170837-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Milena Olech <milena.olech@intel.com>

Since workqueues are created per CPU, the works scheduled to this
workqueues are run on the CPU they were assigned. It may result in
overloaded CPU that is not able to handle virtchnl messages in
relatively short time. Allocating workqueue with WQ_UNBOUND and
WQ_HIGHPRI flags allows scheduler to queue virtchl messages on less loaded
CPUs, what eliminates delays.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index bec4a02c5373..1284ab2adaf1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -198,9 +198,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_serv_wq_alloc;
 	}
 
-	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx",
-					  WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
-					  dev_driver_string(dev),
+	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx", WQ_UNBOUND | WQ_HIGHPRI,
+					  0, dev_driver_string(dev),
 					  dev_name(dev));
 	if (!adapter->mbx_wq) {
 		dev_err(dev, "Failed to allocate mailbox workqueue\n");
-- 
2.47.1


