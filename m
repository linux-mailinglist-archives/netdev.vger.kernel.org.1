Return-Path: <netdev+bounces-16008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD1474AED0
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 12:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEEC1C20FAF
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 10:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4198C06;
	Fri,  7 Jul 2023 10:37:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B078E6FA7
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 10:37:48 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3B21725
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 03:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688726266; x=1720262266;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QSCVdHlUMLWS+aM1yd1KVBawRiRXQ2mPENugDTad3Y4=;
  b=X135ZK49K8dL9J3VXvnHRz0Vr5Vm7RKbHlq7EB2NzuFIsdQAe4JuyryO
   eFjxTybOWK/yg33HAuRZkhYJfdgReUVRKLj13At+VtPd6s9DOhz5notKy
   ImKc5TFshnNortcDMiZB1g9Pj+mrMjSNygDAWd2awpcHdQKZt9lcXkFn/
   SIPUNb0PdN+RP3VHNHlbIeJeoKMOn+L6fXtNkgVsia/dkDydvHupzfBZZ
   c+OBi+a4jeOV2EW5jfb46Xs/iRjYMfsKpDZQsI9/Z4FwnEkZkw9UzxtwC
   w0kB0oIupTxQYcoI0WJNUS2huvm5wRFvEGfpYU5/ErgGwkzhDm+L/JYQY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="429921860"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="429921860"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 03:37:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="810023556"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="810023556"
Received: from dpdk-jf-ntb-v2.sh.intel.com ([10.67.119.19])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jul 2023 03:37:27 -0700
From: Junfeng Guo <junfeng.guo@intel.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com,
	pkaligineedi@google.com,
	shailend@google.com,
	haiyue.wang@intel.com,
	kuba@kernel.org,
	awogbemila@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	yangchun@google.com,
	edumazet@google.com,
	Junfeng Guo <junfeng.guo@intel.com>,
	csully@google.com
Subject: [PATCH net] gve: unify driver name usage
Date: Fri,  7 Jul 2023 18:37:10 +0800
Message-Id: <20230707103710.3946651-1-junfeng.guo@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Current codebase contained the usage of two different names for this
driver (i.e., `gvnic` and `gve`), which is quite unfriendly for users
to use, especially when trying to bind or unbind the driver manually.
The corresponding kernel module is registered with the name of `gve`.
It's more reasonable to align the name of the driver with the module.

Fixes: 893ce44df565 ("gve: Add basic driver framework for Compute Engine Virtual NIC")
Cc: csully@google.com
Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
---
 drivers/net/ethernet/google/gve/gve.h         |  1 +
 drivers/net/ethernet/google/gve/gve_adminq.c  | 10 +++++-----
 drivers/net/ethernet/google/gve/gve_ethtool.c |  2 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 11 ++++++-----
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 98eb78d98e9f..4b425bf71ede 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -964,5 +964,6 @@ void gve_handle_report_stats(struct gve_priv *priv);
 /* exported by ethtool.c */
 extern const struct ethtool_ops gve_ethtool_ops;
 /* needed by ethtool */
+extern char gve_driver_name[];
 extern const char gve_version_str[];
 #endif /* _GVE_H_ */
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 252974202a3f..ae8f8c935bbe 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -899,7 +899,7 @@ int gve_adminq_verify_driver_compatibility(struct gve_priv *priv,
 
 int gve_adminq_report_link_speed(struct gve_priv *priv)
 {
-	union gve_adminq_command gvnic_cmd;
+	union gve_adminq_command gve_cmd;
 	dma_addr_t link_speed_region_bus;
 	__be64 *link_speed_region;
 	int err;
@@ -911,12 +911,12 @@ int gve_adminq_report_link_speed(struct gve_priv *priv)
 	if (!link_speed_region)
 		return -ENOMEM;
 
-	memset(&gvnic_cmd, 0, sizeof(gvnic_cmd));
-	gvnic_cmd.opcode = cpu_to_be32(GVE_ADMINQ_REPORT_LINK_SPEED);
-	gvnic_cmd.report_link_speed.link_speed_address =
+	memset(&gve_cmd, 0, sizeof(gve_cmd));
+	gve_cmd.opcode = cpu_to_be32(GVE_ADMINQ_REPORT_LINK_SPEED);
+	gve_cmd.report_link_speed.link_speed_address =
 		cpu_to_be64(link_speed_region_bus);
 
-	err = gve_adminq_execute_cmd(priv, &gvnic_cmd);
+	err = gve_adminq_execute_cmd(priv, &gve_cmd);
 
 	priv->link_speed = be64_to_cpu(*link_speed_region);
 	dma_free_coherent(&priv->pdev->dev, sizeof(*link_speed_region), link_speed_region,
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 50162ec9424d..233e5946905e 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -15,7 +15,7 @@ static void gve_get_drvinfo(struct net_device *netdev,
 {
 	struct gve_priv *priv = netdev_priv(netdev);
 
-	strscpy(info->driver, "gve", sizeof(info->driver));
+	strscpy(info->driver, gve_driver_name, sizeof(info->driver));
 	strscpy(info->version, gve_version_str, sizeof(info->version));
 	strscpy(info->bus_info, pci_name(priv->pdev), sizeof(info->bus_info));
 }
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 8fb70db63b8b..e6f1711d9be0 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -33,6 +33,7 @@
 #define MIN_TX_TIMEOUT_GAP (1000 * 10)
 #define DQO_TX_MAX	0x3FFFF
 
+char gve_driver_name[] = "gve";
 const char gve_version_str[] = GVE_VERSION;
 static const char gve_version_prefix[] = GVE_VERSION_PREFIX;
 
@@ -2200,7 +2201,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		return err;
 
-	err = pci_request_regions(pdev, "gvnic-cfg");
+	err = pci_request_regions(pdev, gve_driver_name);
 	if (err)
 		goto abort_with_enabled;
 
@@ -2393,8 +2394,8 @@ static const struct pci_device_id gve_id_table[] = {
 	{ }
 };
 
-static struct pci_driver gvnic_driver = {
-	.name		= "gvnic",
+static struct pci_driver gve_driver = {
+	.name		= gve_driver_name,
 	.id_table	= gve_id_table,
 	.probe		= gve_probe,
 	.remove		= gve_remove,
@@ -2405,10 +2406,10 @@ static struct pci_driver gvnic_driver = {
 #endif
 };
 
-module_pci_driver(gvnic_driver);
+module_pci_driver(gve_driver);
 
 MODULE_DEVICE_TABLE(pci, gve_id_table);
 MODULE_AUTHOR("Google, Inc.");
-MODULE_DESCRIPTION("gVNIC Driver");
+MODULE_DESCRIPTION("Google Virtual NIC Driver");
 MODULE_LICENSE("Dual MIT/GPL");
 MODULE_VERSION(GVE_VERSION);
-- 
2.25.1


