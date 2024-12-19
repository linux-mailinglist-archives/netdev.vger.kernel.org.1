Return-Path: <netdev+bounces-153292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4185B9F78DB
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE45169409
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7C7221D80;
	Thu, 19 Dec 2024 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UCkbdwPk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC269221D9A
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601726; cv=none; b=N7b8+EfSTMNiD9LQuq6bjZwK1SEQiwxjBFlZSwz/3P0eL5rl3VJMNvtwsZOJsFz9zKtOjY9P7wn3wPyqG+fwcJ8IQJistqYh14Quzw9IByd0IRAcT34TC2qPoDNINobAvuttc8n/rLIIkhSqE58WoJ47uwkbYSuimRyAcac2V+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601726; c=relaxed/simple;
	bh=zof4/IAQexPAqzjLnsif5OGnaWtERuR/MyIlBNTSjK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P6ODWhP3sLMVShbomjl6vrdfRNuXvSqP3gjDcePlToY/sZFDEHJM7d1/bQSrqt6hVe0PWL/Q+mTtxVtZF1bJiXNsZkh7e4RjQtpgxe8Yci37o6Zq3hwuIiptQDjozbAi3RBQwiOMIUxIrtpVeIrCt5B0g04jm/iopZAbEoSPKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UCkbdwPk; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734601725; x=1766137725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zof4/IAQexPAqzjLnsif5OGnaWtERuR/MyIlBNTSjK8=;
  b=UCkbdwPk8VUGOFjUb3jvWA/CuFzSL+/TBGQHbWnB13FrviDKFQecqt90
   L63+Jf9KocKhZbAngsjcaamPUrrsd0zGXW9GrLZ1xhSpABrbArdWsYSL+
   UXftI3NpS2D0fM9+TgtGaaB+LfVLOOvlHTFLza4OH0tWQ1WDjEvz1siMt
   bFyd3MQGeHoJFsekfERZpUb0EkS+Yzc9Tz/iDmitfl41FYweIeoaRh9Bc
   Lz24eU+L9izi773n538cgOG6QMVxCc4kP7w/krFB/pnjz+Q5PdD9TBWKz
   GbZA4BhiORQfL8/pdyus8PCg4yRbkgpYnWeQIvDfx5YZPEWzONUWs/aUe
   A==;
X-CSE-ConnectionGUID: DmjEz0QcSi+Nd97AMy1gQQ==
X-CSE-MsgGUID: IAnbqtjJTVegbK27HAeOUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="45702751"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="45702751"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 01:48:36 -0800
X-CSE-ConnectionGUID: 1Vz41/1YQMicjP3Jg0B2qA==
X-CSE-MsgGUID: VZq6iG+NReWgVHGEsKnSZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="98207316"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.22.54])
  by orviesa006.jf.intel.com with ESMTP; 19 Dec 2024 01:48:34 -0800
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v3 iwl-next 10/10] idpf: change the method for mailbox workqueue allocation
Date: Thu, 19 Dec 2024 10:44:22 +0100
Message-Id: <20241219094411.110082-11-milena.olech@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241219094411.110082-1-milena.olech@intel.com>
References: <20241219094411.110082-1-milena.olech@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since workqueues are created per CPU, the works scheduled to this
workqueues are run on the CPU they were assigned. It may result in
overloaded CPU that is not able to handle virtchnl messages in
relatively short time. Allocating workqueue with WQ_UNBOUND and
WQ_HIGHPRI flags allows scheduler to queue virtchl messages on less loaded
CPUs, what eliminates delays.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index cbfc8e7fb547..bb3bddf074f0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -220,8 +220,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_serv_wq_alloc;
 	}
 
-	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx", 0, 0,
-					  dev_driver_string(dev),
+	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx", WQ_UNBOUND | WQ_HIGHPRI,
+					  0, dev_driver_string(dev),
 					  dev_name(dev));
 	if (!adapter->mbx_wq) {
 		dev_err(dev, "Failed to allocate mailbox workqueue\n");
-- 
2.31.1


