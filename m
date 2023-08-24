Return-Path: <netdev+bounces-30374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9A778708E
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4FA1C20E7D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057BD2891E;
	Thu, 24 Aug 2023 13:40:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8D62890D
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:40:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66E6128;
	Thu, 24 Aug 2023 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692884452; x=1724420452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RKVN1bWO+6tJ6WlmxsOXbk1vq7oGMYXcJ+RHQjqKcpI=;
  b=miGJcwzDjN2sxgLNa9AX5aN9M63rzzgSfs9srsP6Z/WXHwJPS5MF4CPv
   kiJWLnUuCRVCT7HpFj3Vh/40p2xdf0Ibo541qNswGL9cXuCY8wqTZFRE1
   wUN9+Adz9+iEpZGadkdv1F3cyOGTL7WApPoYK/J2kVdzIrJ46xWWT3bqV
   0Yl0H9TasP7ywpkml1Im2An8MSq7D+4sO+f+BFxzHDysRW7+Gsal1KCPK
   8F/a/HWoa6YhaobSUJhC2ddi41hEaszEiC+6FH2lliKyooFAb4c8Aho+6
   rPi7xu0fuzNnblrcJ304zULCjmplOSKqp3z50YHZxgSGpU+fnO3EtwZOG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="440792236"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="440792236"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:29:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="802539734"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="802539734"
Received: from abedekar-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.213.29])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:28:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 04/14] atm: iphase: Do PCI error checks on own line
Date: Thu, 24 Aug 2023 16:28:22 +0300
Message-Id: <20230824132832.78705-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230824132832.78705-1-ilpo.jarvinen@linux.intel.com>
References: <20230824132832.78705-1-ilpo.jarvinen@linux.intel.com>
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


