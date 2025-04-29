Return-Path: <netdev+bounces-186872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A1DAA3B0A
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 00:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBAED4C4E1E
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495AB270ECE;
	Tue, 29 Apr 2025 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DnD7X3L/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9516026FD90
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 22:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964642; cv=none; b=Oyi7XT6zVBAsKjNRKDemgiZpWVmirDt97csLIph7nJ9/Mj0zeHIt7mJIbR8DTrh9Xw1Da/dYUOEgDGKjGhHgzPW8BLLfIsnb9TsWqnpSkEKEUBGcyiKR8n/cznF4Hm6Dgn7Gemd2sCd/+/sehdsRqFpcdrixGZKm9B/VfigjhtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964642; c=relaxed/simple;
	bh=NH5A2v6dodSCBA4rBWLtw3BPE+x8o1/rZxKUXm4l08A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfCx45Ryg/Vnn9V3iWZI2d0XGcn9j1pgS7Cm5AfFdOyw6ujtz7KxHe8CpvLjuCIo4u9dWSG8/3RXNs2RRuIMMsf/YvzIOeUVqY0BE9U24E0NYAJC4ExzYd7yA5EinSr70rcqQ2rljv64RkYNIuBXhxNeFGf17xvlBBs3U/b9mbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DnD7X3L/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745964640; x=1777500640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NH5A2v6dodSCBA4rBWLtw3BPE+x8o1/rZxKUXm4l08A=;
  b=DnD7X3L/dhOfKYMFkDeqsn8LGpKPG8Di/pK2wRCttj5uquA0SqgYURDx
   YDrzfb40+dnuFvQv9YhMssiVhyKcPHT03naLPf0qX+CxTXKL3ZFK1sbfp
   2GOlUF0D4y7eCIFjyZqGfAdVtmR+XdQRS5ZYSgL7aoMFca5dYWZcGgtuu
   Tr99mmAev3vbxt4U9TLOSFkETjGuphZMmQMbqxy/8nvIfTAdTMKwBl0KL
   KAi/Ovc5EN2d+pceXQDnhKF1ljNOqKTmWZjlDa393i1f3Zj6vuB3TaDW+
   TcOjDT1Fx0oPs42zKyDqlEU+le/h8UvVfLAT1XFkGwb3HhRsknMQovK9K
   g==;
X-CSE-ConnectionGUID: FcIEdjl5Qau9Eo/Cc7c5vg==
X-CSE-MsgGUID: cOte/g35TDSIcuG4xF4DFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47620126"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="47620126"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 15:10:38 -0700
X-CSE-ConnectionGUID: Wf3SjuPGSGGBhsm4n3b4OA==
X-CSE-MsgGUID: MP5bQTH9QuW1LQNuoxp6/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="138750765"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 29 Apr 2025 15:10:37 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 2/3] idpf: protect shutdown from reset
Date: Tue, 29 Apr 2025 15:10:32 -0700
Message-ID: <20250429221034.3909139-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429221034.3909139-1-anthony.l.nguyen@intel.com>
References: <20250429221034.3909139-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Larysa Zaremba <larysa.zaremba@intel.com>

Before the referenced commit, the shutdown just called idpf_remove(),
this way IDPF_REMOVE_IN_PROG was protecting us from the serv_task
rescheduling reset. Without this flag set the shutdown process is
vulnerable to HW reset or any other triggering conditions (such as
default mailbox being destroyed).

When one of conditions checked in idpf_service_task becomes true,
vc_event_task can be rescheduled during shutdown, this leads to accessing
freed memory e.g. idpf_req_rel_vector_indexes() trying to read
vport->q_vector_idxs. This in turn causes the system to become defunct
during e.g. systemctl kexec.

Considering using IDPF_REMOVE_IN_PROG would lead to more heavy shutdown
process, instead just cancel the serv_task before cancelling
adapter->serv_task before cancelling adapter->vc_event_task to ensure that
reset will not be scheduled while we are doing a shutdown.

Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index bec4a02c5373..b35713036a54 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -89,6 +89,7 @@ static void idpf_shutdown(struct pci_dev *pdev)
 {
 	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
 
+	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->vc_event_task);
 	idpf_vc_core_deinit(adapter);
 	idpf_deinit_dflt_mbx(adapter);
-- 
2.47.1


