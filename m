Return-Path: <netdev+bounces-147409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384D09D96B2
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B5528A5EB
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 11:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556F51CF7A1;
	Tue, 26 Nov 2024 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/ApH4XC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22031CEE9F
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 11:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732622084; cv=none; b=UZhu2AcGoXIAUiM4phIhBwU7EyZ36f1Llw2rfVDrNATcaBg8s94Ne6WqnpV64l88u7/I6Vc45DtiP21uYBq0FHYZArNborc1abQD6aF9r3m6+kK1eKJBgWWtqTKnPSnXnUQHSGnfNSkZBweYd6F70iSjRf/Vita7kwSx8RDF564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732622084; c=relaxed/simple;
	bh=PKo26T3bgOqQbV1j/M6VA+TVNn/UhXn4giGR66NQrSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=koWI+7J90dJNVLifgbJBf9rhsi7QBjrclL1qtmiuJlK6cCLu8yOO/AqQEolfxBs7JhtBawx8OfzgsQ/XIE3YTK1vxnF11P/TodaOfuxejTqXhOZDzsITiFTowYy9Q+YxZX4XdW82aRFsr1xjUrrSGbW+jyHHF12UpbvMFtIKOLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/ApH4XC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732622083; x=1764158083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PKo26T3bgOqQbV1j/M6VA+TVNn/UhXn4giGR66NQrSo=;
  b=G/ApH4XCNR1VVY4dmgelUDlD0v5pJOCKDJUUsSzjH1M79T343WVjt4qu
   uG/KOl7P0u2aCNCuYhXBy7NQ2jmfwU/mKEylbDky9yNpGoVTi8dXU6z9+
   xaEmFBMlaZ90pPrmYwKe4hGkp+2S6OlLz2sDdFa0mvN9rwOzBlwl0rG3U
   WHnah+dZekyjfBICJi4lmWJgrx8r0lwCPax7lJqusOJNWl484ZIrnKOeg
   XYcxgP63T+Ik28fBiYQIfmKX9FqD4dqR6EN9LFs9rqWQaLkUU9/L1KE6j
   lNsBmgk5K8+SV+k3u2il8FQRZRfyK8mqCrsuOrWh28mybsbW/XJ3XuY2n
   g==;
X-CSE-ConnectionGUID: VXs7UBxDSs6EWhOmyc9oFg==
X-CSE-MsgGUID: GX0wdn/MRniIMn/yVHC4Gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="55276399"
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="55276399"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 03:54:43 -0800
X-CSE-ConnectionGUID: cEbS0UvKRwi+BuQ2VGO12g==
X-CSE-MsgGUID: anQH9psJTseFYL7bJ1++pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="91767003"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.22.54])
  by fmviesa008.fm.intel.com with ESMTP; 26 Nov 2024 03:54:41 -0800
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v2 iwl-next 10/10] idpf: change the method for mailbox workqueue allocation
Date: Tue, 26 Nov 2024 04:58:57 +0100
Message-Id: <20241126035849.6441-11-milena.olech@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241126035849.6441-1-milena.olech@intel.com>
References: <20241126035849.6441-1-milena.olech@intel.com>
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
index 9fe0940f81b0..afc39e894cd2 100644
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


