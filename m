Return-Path: <netdev+bounces-191106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF0BABA194
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 19:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 586B57A73B8
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 17:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB25274646;
	Fri, 16 May 2025 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KaceztCM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB98E253941
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747415222; cv=none; b=AxMD4K4t7ksBLfoq73oBv4ZJDYnR4LiBsKAnvnw33mjNsQwGcrJAfDhiyRe2QVT6kkVkIdmFf04XDzulZDhkMChjB/hgjHODloQjTMfWGKBFcEbhU/zcXUpYOK4VoQHyXmJpRwaGkyhi9DVg1mYOoVlyvhukEfToWcikXftL3uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747415222; c=relaxed/simple;
	bh=2tLHrvWEuE0V0pkP9lHtqKMjXDu+aWdjWHNArZ1pRNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djDs5IL6vPYiW47g0tBWNPWRnVZaPYyhilY76CGNVUPEdp+EYZn4obUaLiKkQv5PSfSbyJw6gB4E5dp7Q18nIlIK9Ewk1f50IxNiNLRPspKa0jzs+O470gGYs8rHpVjEpDWjBNwc6qmPXdd+gHr3WiFLGUfWViTbVdhXwE8S3kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KaceztCM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747415221; x=1778951221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2tLHrvWEuE0V0pkP9lHtqKMjXDu+aWdjWHNArZ1pRNE=;
  b=KaceztCMcGoNvdyFRKYyAEuTP69tuyE3f5jtMKfC4pj3alICeCOUo/lx
   B2tB4ppupIbGTrspTPaQqculBMlAgfpYEPhJEX6NBWY4PIVIbk7LiYjWu
   hhGlWA8TEOgWRyWLJ73Fkz5ra1aw+7VttdSF8a13O+lCjAMl6E9VC4Txn
   zYWy6lK2PAuN8iDx7sb/rm16A+BcLq5y9zclBVWgyMO0ULC3Zd+Lz9sOe
   dn7VEQoumjw4SG1nNildwrPkpnrpEFp3Ehn8KccE9g77QbT1sSaS2LW4d
   h0o9F6hx+x/EiKqqA7IE52tx7ZVUjmNWtDQtDvTr7DKRO0fIvrK7e0q/A
   g==;
X-CSE-ConnectionGUID: GF0O4cKbQZ6tvaquxPfHTg==
X-CSE-MsgGUID: LYmzTtuUSZioz6DmWlSF/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49270911"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49270911"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 10:06:53 -0700
X-CSE-ConnectionGUID: MhcWyXGuSd6koK2oDaDPwg==
X-CSE-MsgGUID: /H4NSmfWSaOXKK4Ldb+Tqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="143868367"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 16 May 2025 10:06:52 -0700
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
Subject: [PATCH net-next v3 01/10] idpf: change the method for mailbox workqueue allocation
Date: Fri, 16 May 2025 10:06:35 -0700
Message-ID: <20250516170645.1172700-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250516170645.1172700-1-anthony.l.nguyen@intel.com>
References: <20250516170645.1172700-1-anthony.l.nguyen@intel.com>
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
index b35713036a54..ae7066b506e6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -199,9 +199,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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


