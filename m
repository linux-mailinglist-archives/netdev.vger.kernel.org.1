Return-Path: <netdev+bounces-32824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0E179A810
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 14:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B505B1C20854
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 12:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C905F9F3;
	Mon, 11 Sep 2023 12:54:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9150D1170F
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 12:54:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F19E4B;
	Mon, 11 Sep 2023 05:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694436869; x=1725972869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RKVN1bWO+6tJ6WlmxsOXbk1vq7oGMYXcJ+RHQjqKcpI=;
  b=bUWitqMHJGU633zc/Q/sIHhMdeFHAvfs/B8VP5XJ6il1JBZefbVulsxG
   fA00ac7Cnc/s2hzzvrtjBvHQ3abVM59iirsEfL44JgMnVu6E8DVTJ4YTY
   aBqVxCFXyX9ZGPjAd/NlthlVSiv6WkggN8i4buRyBOEP7NGwdxvPoGxAQ
   OwUqoudOJJ4x44nqUCJPy+vDr3jbUo9uSehQSSHUlmmBcws646fMBOMX/
   98LC0B5OOerAZ/G6LP/Mp2YRY4UVMiox4xMS7d9fPR3z7eJfSOCRM0UDg
   VxgSX5Qc2qeDjwjgj1kx6ibvN5N1OLjQg0I3nksP9OQY8E2fQVwvOFDkb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="357511221"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="357511221"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:54:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="858304289"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="858304289"
Received: from mzarkov-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.36.200])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:54:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org,
	Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: brking@us.ibm.com,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	ink@jurassic.park.msu.ru,
	jejb@linux.ibm.com,
	kw@linux.com,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-sh@vger.kernel.org,
	lpieralisi@kernel.org,
	martin.petersen@oracle.com,
	mattst88@gmail.com,
	richard.henderson@linaro.org,
	toan@os.amperecomputing.com,
	ysato@users.sourceforge.jp,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 3/6] atm: iphase: Do PCI error checks on own line
Date: Mon, 11 Sep 2023 15:53:51 +0300
Message-Id: <20230911125354.25501-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230911125354.25501-1-ilpo.jarvinen@linux.intel.com>
References: <20230911125354.25501-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In get_esi() PCI errors are checked inside line-split if conditions (in
addition to the file not following the coding style). To make the code
in get_esi() more readable, fix the coding style and use the usual
error handling pattern with a separate variable.

In addition, initialization of 'error' variable at declaration is not
needed.

No function changes intended.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/atm/iphase.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index 324148686953..9bba8f280a4d 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -2291,19 +2291,21 @@ static int get_esi(struct atm_dev *dev)
 static int reset_sar(struct atm_dev *dev)  
 {  
 	IADEV *iadev;  
-	int i, error = 1;  
+	int i, error;
 	unsigned int pci[64];  
 	  
 	iadev = INPH_IA_DEV(dev);  
-	for(i=0; i<64; i++)  
-	  if ((error = pci_read_config_dword(iadev->pci,  
-				i*4, &pci[i])) != PCIBIOS_SUCCESSFUL)  
-  	      return error;  
+	for (i = 0; i < 64; i++) {
+		error = pci_read_config_dword(iadev->pci, i * 4, &pci[i]);
+		if (error != PCIBIOS_SUCCESSFUL)
+			return error;
+	}
 	writel(0, iadev->reg+IPHASE5575_EXT_RESET);  
-	for(i=0; i<64; i++)  
-	  if ((error = pci_write_config_dword(iadev->pci,  
-					i*4, pci[i])) != PCIBIOS_SUCCESSFUL)  
-	    return error;  
+	for (i = 0; i < 64; i++) {
+		error = pci_write_config_dword(iadev->pci, i * 4, pci[i]);
+		if (error != PCIBIOS_SUCCESSFUL)
+			return error;
+	}
 	udelay(5);  
 	return 0;  
 }  
-- 
2.30.2


