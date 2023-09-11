Return-Path: <netdev+bounces-32827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1994F79A815
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 14:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496111C2088C
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 12:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6C511188;
	Mon, 11 Sep 2023 12:54:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534D4F9DC
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 12:54:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB85E4B;
	Mon, 11 Sep 2023 05:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694436895; x=1725972895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2++8yCZGRSSz4uOxVbgjndMH1wIP9iMn3E11M0dDVTs=;
  b=gCGHIlGfQjuCY7y+fw999ccOxpU8+lC4sYWL1gBcU19oOVzJJfErBGjc
   11x2jZct6m/2n1sAGsv/3jczRAj00bEXS8/EAtvo/GzZU1hrbTc+DHcX+
   jfIwgGYkJLgeUJL2SjSlMzpnnXlCQVuARADh1oOqPUIVVTXG7NmaorA3F
   xZC6eVPZQ5w8JCBNituSRJYblbU4S1sv5HCSW+3F+ozPK/xWYdphrhDi8
   mKgQ1Cx0Cq8Co11VohjYDI+CEDGyCvp3+ww0UM8xV3cTRfNiZ2JFwvx2b
   Xrqp6iD3gf1R5KfMSmMvq946MuR1l6zaBG4DRlb9GG9+dR64CrdowA3Hj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="357511300"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="357511300"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:54:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="858304520"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="858304520"
Received: from mzarkov-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.36.200])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:54:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org,
	Brian King <brking@us.ibm.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: 3chas3@gmail.com,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	ink@jurassic.park.msu.ru,
	kw@linux.com,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-atm-general@lists.sourceforge.net,
	linux-sh@vger.kernel.org,
	lpieralisi@kernel.org,
	mattst88@gmail.com,
	netdev@vger.kernel.org,
	richard.henderson@linaro.org,
	toan@os.amperecomputing.com,
	ysato@users.sourceforge.jp,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 6/6] scsi: ipr: Do PCI error checks on own line
Date: Mon, 11 Sep 2023 15:53:54 +0300
Message-Id: <20230911125354.25501-7-ilpo.jarvinen@linux.intel.com>
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

Instead of if conditions with line splits, use the usual error handling
pattern with a separate variable to improve readability.

No functional changes intended.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/scsi/ipr.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 4e13797b2a4a..81e3d464d1f6 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -761,12 +761,14 @@ static void ipr_mask_and_clear_interrupts(struct ipr_ioa_cfg *ioa_cfg,
 static int ipr_save_pcix_cmd_reg(struct ipr_ioa_cfg *ioa_cfg)
 {
 	int pcix_cmd_reg = pci_find_capability(ioa_cfg->pdev, PCI_CAP_ID_PCIX);
+	int rc;
 
 	if (pcix_cmd_reg == 0)
 		return 0;
 
-	if (pci_read_config_word(ioa_cfg->pdev, pcix_cmd_reg + PCI_X_CMD,
-				 &ioa_cfg->saved_pcix_cmd_reg) != PCIBIOS_SUCCESSFUL) {
+	rc = pci_read_config_word(ioa_cfg->pdev, pcix_cmd_reg + PCI_X_CMD,
+				  &ioa_cfg->saved_pcix_cmd_reg);
+	if (rc != PCIBIOS_SUCCESSFUL) {
 		dev_err(&ioa_cfg->pdev->dev, "Failed to save PCI-X command register\n");
 		return -EIO;
 	}
@@ -785,10 +787,12 @@ static int ipr_save_pcix_cmd_reg(struct ipr_ioa_cfg *ioa_cfg)
 static int ipr_set_pcix_cmd_reg(struct ipr_ioa_cfg *ioa_cfg)
 {
 	int pcix_cmd_reg = pci_find_capability(ioa_cfg->pdev, PCI_CAP_ID_PCIX);
+	int rc;
 
 	if (pcix_cmd_reg) {
-		if (pci_write_config_word(ioa_cfg->pdev, pcix_cmd_reg + PCI_X_CMD,
-					  ioa_cfg->saved_pcix_cmd_reg) != PCIBIOS_SUCCESSFUL) {
+		rc = pci_write_config_word(ioa_cfg->pdev, pcix_cmd_reg + PCI_X_CMD,
+					   ioa_cfg->saved_pcix_cmd_reg);
+		if (rc != PCIBIOS_SUCCESSFUL) {
 			dev_err(&ioa_cfg->pdev->dev, "Failed to setup PCI-X command register\n");
 			return -EIO;
 		}
-- 
2.30.2


