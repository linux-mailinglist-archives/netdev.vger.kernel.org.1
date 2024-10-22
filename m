Return-Path: <netdev+bounces-137758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334EA9A9A2B
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BADDB2252F
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 06:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6216314B084;
	Tue, 22 Oct 2024 06:42:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F45514A08E
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579376; cv=none; b=muS3vgGQ1MET6LDlLILrT2+CR8ehRQQvp5FvjCmXDazCFBm+7GkZdJ/wonSeK3f93UAf/zKjjskuaSdcCcT9cYVAYP1Qk3eqe/jJyChB6YTIAdtkP8iposPzYIylwfqcNfebMUnmwNbMf9pb8VpiJlmUQA/he1ZdnoLX4T5k1eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579376; c=relaxed/simple;
	bh=uF6kMXHeHakdnS2DqGFe9XhoPGkZxk0CzUjAPWFdazU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mi70NANR0lDt7zrW52QHLCyeEtsm7hkj3KKvHH2fuMmpXvOQYPgjaGDLIm3eK/RIuW+IZO27fQLO270KDAFiQAdYiXz69T0/bmBgY7j/FRb2oMWeEhoNB/CHlnK10bf3yeBRLQXVk1YtlcKzhRbtSvuyseKvQG5p85ucdE/Dl54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XXjHQ2LSqz1T94l;
	Tue, 22 Oct 2024 14:40:50 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (unknown [7.185.36.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 7623818007C;
	Tue, 22 Oct 2024 14:42:50 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Oct
 2024 14:42:49 +0800
From: Yuan Can <yuancan@huawei.com>
To: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <cramerj@intel.com>,
	<shannon.nelson@amd.com>, <mitch.a.williams@intel.com>, <jgarzik@redhat.com>,
	<auke-jan.h.kok@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>
CC: <yuancan@huawei.com>
Subject: [PATCH] igb: Fix potential invalid memory access in igb_init_module()
Date: Tue, 22 Oct 2024 14:38:07 +0800
Message-ID: <20241022063807.37561-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500024.china.huawei.com (7.185.36.10)

The pci_register_driver() can fail and when this happened, the dca_notifier
needs to be unregistered, otherwise the dca_notifier can be called when
igb fails to install, resulting to invalid memory access.

Fixes: fe4506b6a2f9 ("igb: add DCA support")
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index f1d088168723..18284a838e24 100644
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
2.17.1


