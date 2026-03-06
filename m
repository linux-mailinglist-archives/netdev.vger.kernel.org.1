Return-Path: <netdev+bounces-264762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGaLOcLEqmnVWwEAu9opvQ
	(envelope-from <netdev+bounces-264762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 13:12:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8428E220463
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 13:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9506A307A549
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 12:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC680386C20;
	Fri,  6 Mar 2026 12:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K9vpO9JO"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D58B38E13B;
	Fri,  6 Mar 2026 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799085; cv=fail; b=EeHU/Dn45Q5FaFiSdX83JR/y4DbeqQXXlfIJ2zPQgzNDRnPaziIV5/xoSiRPZ0u44vOTG0mykPtU3d2mM+u9o3mh9mTAqgfoOSa4H/j+0P9k7soLva6jhabvi7RyuaUHJExe1D9ongO8pvYRing+rbn1y3wieKxBLy+WlKJ1Qrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799085; c=relaxed/simple;
	bh=XbU1YZ0YYPsLH+cRdxznjWjgyc9HXutGDorZgTfqT6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgKPisqs/71c0AoqDSZYQd+px60ei71OxZCtXPdl1+1hSHw0vwQ0TgOn/RsBqdbjCX9gU2+5k6/j1DsqPWvgLbOtr5qN6k9TCjIuMHZc+mstv1B5tp+bS3Q66Ao4EEjTioHFBV1UPUvga62SL8csnJPBa616va9Irp8MHgc7rug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K9vpO9JO; arc=fail smtp.client-ip=40.93.195.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylvBH7504pBw+y8Ga3BV/YbhBt4ploT2GlUgDjHQDRubds8k48zPKWNbfZtfUCeILhDaiX0KDEp5MQJxgRBi4TywqNt8MQAJT250iaGkStNMAUfjxp1y/SZjRKqYxnTDobr/qQT2s3FTLm7YmfVtP+grw5F5zHfRlzVDggPhPEaaZYrYRga1XwDOK1gzLzLXhp4N5XKh8KkyxaHpRyJuEWqyZC+BGj7CNn+P7+NgGOk/0NzGjvhmHLFMehQhLhAtTAOGl7h4tEqPNgXeFYtOk/GU/oXINdVLnzp36vMq0fKvyRcCua5pYYP7y3jpHf4vg6nPWUqLOjiMrRw+AdVHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQSdTi7ZH3eOCBx3FFjy2tHpOsJVO46rQamEQFO2Umw=;
 b=I1G8JvF47VwettwljtNmkZIK6+6LE+qTv+hgCKvOw46rHs8uvtQeRlqs46F2NnKMi/1p1xXW/z3WZMeh8dOjp2K3FL2xHW+LHIO5vvy1v6P+TWfFGh6yKQEP5s+YXkGq6XOE/MqNv9Vk31xlyLdk6QxiYxQIpsdpYhf8uIWCoVx0g/e3flDSt4h+PmL8H52sQjmKMK8QJi2EFxZT66nmGJIKelDL8z+0SB4uNEKUbaVUf/J+D+wyyX1c5Zkn3iuvG1sUYaIbTVRihNFGLWNU+2HdgXERiwDI6oGTdGANoY3SPv45Gtqj8BsQDYj2z4uxK9U1nctdLI08XxOpldnSLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQSdTi7ZH3eOCBx3FFjy2tHpOsJVO46rQamEQFO2Umw=;
 b=K9vpO9JOVaukQtwyLH+bmNwsWxBCHsg1MHCsLiWAhuYu8y5tM1QbpnC0M8zOrq84Z8Urg7XBg0XXmRoXaCvpFytSJGCP23FqWRJ0GvQFBCHhKKY2xry0LEQBYumieo56VL++3OkJ640PmbGlw5EDVv6PJaj2NFvwNbCuLlRQmKg=
Received: from BL1PR13CA0238.namprd13.prod.outlook.com (2603:10b6:208:2bf::33)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 12:11:19 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::7d) by BL1PR13CA0238.outlook.office365.com
 (2603:10b6:208:2bf::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 12:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 12:11:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 06:11:19 -0600
Received: from airavat.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 04:11:16 -0800
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>
Subject: [PATCH net-next 2/2] amd-xgbe: add PCI power management for S0i3 support
Date: Fri, 6 Mar 2026 17:40:47 +0530
Message-ID: <20260306121047.1231755-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306121047.1231755-1-Raju.Rangoju@amd.com>
References: <20260306121047.1231755-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|BL1PR12MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: 6520c527-afcf-41f1-d8d0-08de7b7979a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	cEtA2R0VWLb6NcxPxfV8+U9opXXVJUbZdXRiGngbs7h+I/3ow+YqfK2QXuoiqE+qmYlkIvXdQoshtYn9kFe/iBABk4Y99fhFjwx2qos8+KDVPLowvuju2UkZSYgn43zg/yzly6zfqFeaSOjF8vahj6as1WBpJ7phdS0xgsRrVoZAuABW451cJ895CfzcqYkbM0wBfykqhm9OLF7fLicVYAJ5HTBk5oJJmVPb4QQ84FhE/p3icfxOOa1zZkwFpCYJMM79ozhkK6Oiv07RAz9LCkhnU7oB0rlYbMLZyArmQ38sok82rNhyaYKkPJYJcNOcJlPT3UaFSXWXy1nxRdD1vj6KMUpv655vWRIyPmExDcazx/XRINzukDsAPAOAVTX9OIDKrHrZPkUNXiUeEi5VO/HImEHepHCeLev4wFxa8DFJ2NmEnXExp8hNuLZ/fXeCifoACtHoddm76LEuwanxpbe+dSL9I9w3yRWySuJ+nQ6rxEbAcos9dBJzv/cyS2pnarIN0bnA3F0PFNJ00IWMrRj353/JyEHy5F377oD3OKO66cRUTR6tAwYFxuGbDWPORDB/6MvIOGFMDDmMXsjusgklmdYVUvgDxg1FsH/i7+8P0x3HzoiGbVJbR9PJ3dnq7oiaMfewXL2IsNMtcKMS804sIoGJgbj/1+b7y22eoEsOZ4LZfPo8h1AHSVNkQ+uzspBl4WHxTvlLpXQbg9tb5tdgWA+QWig4CujJD+gsZowZ6Oz5dzcali1DVpKwoT2SUZVCBfFRL0wg4mBTXRzUOQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XJekJxGWSlDOzypatc7bUEgvGB9SkvSPF9lrSCesf1yY0gFzJTv0tbJTcHvRlk9/xv20gOKAovm15UGX2Egk09lFLzlA6EylfevS0qRTiKMPPMVQ8o1A3UJ955at2d+rIbRL9cG/qsDCZ5mOGmzqQM27lS3JjrEYVSLubO2d+1Ip3dNB6azmKl51oe5dISkOMonAUiWyvdCM7hfGIdL/iH7ELqxDIkQ34Y8aEfdisKuQOegaSuw7Uj1CS/PVRo0slNj8SvEhEuPbkb6u/DRCUebfxFt8tpB9VAdWQtpigX+fXBTaeUcgAvjIf8+hXj5DM83Jgm2TOewND96iq3uzvwwjb3pMYvweXBlPVRIEzadfhI/UfeQc/2KFFF/C+oAtGvVj3PWX1TbeuMX1McxuMuc1K+5QiHdONPuUOKGOX+S9LUJ2NkKY6YNXkcHvT+Tl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 12:11:19.5126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6520c527-afcf-41f1-d8d0-08de7b7979a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947
X-Rspamd-Queue-Id: 8428E220463
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264762-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

The current suspend/resume implementation does not correctly handle PCI
device power state transitions, which prevents AMD platforms from
reaching the deepest suspend state (S0i3) when the amd-xgbe driver is
enabled.

In particular, the amd_pmc driver reports:

  "Last suspend didn't reach deepest state"

when this device is present.

Implement proper PCI power management operations following the standard
PCI PM model so that the device can be cleanly powered down and resumed.

Suspend path:
- Power down the network interface
- Put the PHY into low-power mode
- Disable bus mastering to prevent DMA activity
- Save PCI configuration space
- Disable the PCI device
- Disable wake from D3 (S0i3 does not require Wake-on-LAN)
- Set the device to D3hot

Resume path:
- Restore the PCI power state to D0
- Restore PCI configuration space
- Enable the PCI device
- Re-enable bus mastering
- Re-enable device interrupts
- Clear the PHY low-power mode
- Power up the network interface

This allows systems using amd-xgbe to reach the deepest suspend state
when entering modern standby (S0i3).

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 33 ++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index d8c1037dec45..061dfc9f75e3 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -364,15 +364,31 @@ static int xgbe_pci_suspend(struct device *dev)
 {
 	struct xgbe_prv_data *pdata = dev_get_drvdata(dev);
 	struct net_device *netdev = pdata->netdev;
+	struct pci_dev *pdev = to_pci_dev(dev);
 	int ret = 0;
 
 	if (netif_running(netdev))
 		ret = xgbe_powerdown(netdev);
 
+	/* Disable all device interrupts to prevent spurious wakeups */
+	XP_IOWRITE(pdata, XP_INT_EN, 0x0);
+
+	/* Set PHY to low-power mode */
 	pdata->lpm_ctrl = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_CTRL1);
 	pdata->lpm_ctrl |= MDIO_CTRL1_LPOWER;
 	XMDIO_WRITE(pdata, MDIO_MMD_PCS, MDIO_CTRL1, pdata->lpm_ctrl);
 
+	/* Disable bus mastering to prevent DMA activity */
+	pci_clear_master(pdev);
+
+	/* Save PCI configuration state and disable device */
+	pci_save_state(pdev);
+	pci_disable_device(pdev);
+
+	/* Disable wake from D3 - required for S0i3 deep sleep */
+	pci_wake_from_d3(pdev, false);
+	pci_set_power_state(pdev, PCI_D3hot);
+
 	return ret;
 }
 
@@ -380,10 +396,27 @@ static int xgbe_pci_resume(struct device *dev)
 {
 	struct xgbe_prv_data *pdata = dev_get_drvdata(dev);
 	struct net_device *netdev = pdata->netdev;
+	struct pci_dev *pdev = to_pci_dev(dev);
 	int ret = 0;
 
+	/* Restore PCI power state */
+	pci_set_power_state(pdev, PCI_D0);
+
+	/* Restore PCI configuration state */
+	pci_restore_state(pdev);
+
+	/* Enable PCI device */
+	ret = pci_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	/* Re-enable bus mastering */
+	pci_set_master(pdev);
+
+	/* Re-enable all device interrupts */
 	XP_IOWRITE(pdata, XP_INT_EN, 0x1fffff);
 
+	/* Clear PHY low-power mode */
 	pdata->lpm_ctrl &= ~MDIO_CTRL1_LPOWER;
 	XMDIO_WRITE(pdata, MDIO_MMD_PCS, MDIO_CTRL1, pdata->lpm_ctrl);
 
-- 
2.34.1


