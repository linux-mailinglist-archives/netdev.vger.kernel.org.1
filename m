Return-Path: <netdev+bounces-260885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHRUJhHXnmkTXgQAu9opvQ
	(envelope-from <netdev+bounces-260885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:03:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ABB19631C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 618CB300E68B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB8F3939C1;
	Wed, 25 Feb 2026 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oWX0dFuy"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012012.outbound.protection.outlook.com [40.107.200.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5D32DF132;
	Wed, 25 Feb 2026 11:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772017286; cv=fail; b=E/ZEUcELn1xMq5JUeVn42kieZfs3oj0zW7quRhrtZ1wTxJXDISxGHIJQsVvDB4ozFY0mmEe2nVehbnFe7jzpY+akYtpz8Sfovm1/BIhBNFHsId7JuslGD07Zkb+22KGa54P/PEb2yAbaafE+Lc+ZYx2S0ie7VsPvknOg+BdMnvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772017286; c=relaxed/simple;
	bh=HkE4fD1aECNSYibdkIMzoVw+j7+JiZSYj2p29pjX5UY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6mwHrk/ucyp1Ru1uxtja07EXUKB5uj1qtCwICO7kvVOkzRUYnjysB4+Z4xe6MmQ44ewr/IsoJnO1Z0ajD1wvpCnnNFOE/u4AekNtXlPjBp6WsGjQXeqSmQHLRCQ+JbZV6mDz75TGiNmGpRXS6EbJVkOYzTclNj7cqd94ANgps0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oWX0dFuy; arc=fail smtp.client-ip=40.107.200.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iq01+8dOoaJvoYaVS/B6LO24GLOF/j06YprGBWkei8gPNRUsKqkz/Ke7PWzidQ5LeNWpgJza45y3VM+wszhcSlrUuK8EaSP4kGU5HSTkoZqalouwNTxe9UExSJWtwBqlgorKl5ngId92keiqJSHTwqbcZB3Df4zvzYmAiftAP01lAu7R3Yr9yH5AgEO9vsNJzrM7C3fQuxo7hhef60hfcC4Mv/aUdgI1Uau8INaxKu4cbzRjhwtweka2iHaBUthgnOWWbf0g36fs60EhNtkM2x3MEvf/Xygc9O2PPo7UJkXkj24EKi68e5//9V5VxDhNPkcq80+viIwWx9DHZjWhlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq+mtPyWnYv93/XfO+ElE6R7HQtbOXwadHs9y2V+Ssg=;
 b=g/m6WSEQXmFy1xDAqhYViwKKTH2Mone88lEWD2SZ9Fk0UPrQ+vcpLUZtnY1AH7+5WCFBYeD2QVfxIL43DDZ77mzduCE1E6+99IcuXtz4HCIQYv4Ltf5Ah5bz6vHaBxEUUmq3dQK8u7Z8zXjnBsdzkxOlJ/Wv26iN1W54CsE4Y2RhVYYa+6qZl4moLu73jeFtHJx15v1wHV7unGme3eHOKwwo5kpEhxsm1SJMr6UDceDlk0mn7UcSbwtLBpQzUI3REabTnukeiu0f6lHs3w1Gvd7ylbs/pi0iLNTs4vwvHC4Bmh+dbvSHKbkSeQ/y7X6uE76gn9W2TzBpbp/8SgTx1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq+mtPyWnYv93/XfO+ElE6R7HQtbOXwadHs9y2V+Ssg=;
 b=oWX0dFuy3iD6eRJ6RwquuWEUZu/ZgxpnxXhUs/A1UPwQsNmeCiWG+zdu/pZFyf6GBcbHNAdhQGDPYxIQoG47PF2PCNnqACnWi7DeyBr+wtFB8syRaMwZi++UysPPaoGxZe6JJEhBd7mK/5xLDxrZGYhj9RBjf9hHt5bWiRklEbw=
Received: from BL0PR02CA0125.namprd02.prod.outlook.com (2603:10b6:208:35::30)
 by IA0PPF64A94D5DF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 11:01:20 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::86) by BL0PR02CA0125.outlook.office365.com
 (2603:10b6:208:35::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 11:01:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 11:01:20 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 05:00:58 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<Thomas.Lendacky@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net 2/2] amd-xgbe: add PCI power management for S0i3 support
Date: Wed, 25 Feb 2026 16:30:01 +0530
Message-ID: <20260225110001.1000014-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225110001.1000014-1-Raju.Rangoju@amd.com>
References: <20260225110001.1000014-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|IA0PPF64A94D5DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 590713d0-1508-489a-f19d-08de745d3526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	r234hormlWyuEed3eB3T6onC4yqvVMbQ/lZrS4Q369hK9iWIFB48wR8v+KcYjkxGSSeAY8aMKA0JB4h2kWyM5aj/2Rhr+pVanc3LxrPeLrm1T39Nfe5HgsbkQIAPcLAm7xkA8E2lTOAtApYsaLK0wAxz5h/9gz4bswy4MUxDV78WNxnRjDOnmqWHWAPqGl1hu9Ac8APc9T64hjtmQYayJM/40xNGLiqgkUWpysQ4vEKSrsBc1PEcr8AFsATtgTmXm+Z2XIbUQWfLDL2RhMyqNILv709Dqk3LZXbjM8oWBnuLfgBbY1qXN4VAvjooT2MA+kOn0sPdLI5SJy5d3PCr7D9nszHDb5FxC36KELGrIE8B95tpUuWst7TsO7mIxAr9AV9tyofIaXSD7MRAyfyai8gu8VaKIMJilk3rqrwBpz8jvNKw3BigGIRfLt0Y/pNtb7+JicqFMZPMouEw1/EqXIHcU5W74GckG1R2Rb8DVEp5KS9d7YfbQBVODRxGW9JQ/tp+AkwmFpE3oLAs6/Y457VvFbTV7ujYg8/s5I5Z5N4tZa2Osi+OZmjiz1xTNCpArX3pF7KRpctncrQMd+fHGIAE7BdzVRiixLqrJMro3CPjL0WqXFQHZ/SvHI0gPmXO+LC7D4tzmtwD4Bk7L5XjCf5TqZIB6PtplWWfWxvJrXU87+2scujX+wZpX6t9sxf6UUExcL9l5uJzp7uiuTCZJejDYETCZ1aLWUi3PXFDseW632MqlPGMnC9a/mMvb8ML7XqS56u6bmPEeLidtoQRryTS18ka0G0rxss/AZ63ZP8prAJt5G19K6KPk8Jz2MGsQRA6stbzTpRNaQDge+9c/w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TMoUUTo0jgKAylS7+oqY5lz2mNbuLCSvdFOuFCIhtIQhlpx3xqH9vcchrxYMpFRDnlP4Nk1IIhD/fI0HWuf8weH23//y9lnNBBsmrU+TwynwO/bld8kua3LbihCirWhn12tD1aYmhU3HhqV/xQmvW3Edv/7ynzbY57Hu/LozkYDDbgmB/lK+VjcU95pCmQxm7DdX9GLSdEXJuFpZZOFQSMsqmlB0oaDPCHlv78Gp6IzKpxN+6VCod6wNsiQm2vYFr/BFQmdhxTd7V36ZJb1wgkn6Jq6aaxISuZnlWFOfkHTymsO5rH/LGG5ycz9kxAK3/bPTZdd9nqD6kR0d6QN5fCUBKaaezIgLQCYWfIgYGv6+ZF7SOJV9zIdWVFellrf1B0/RSmFc7OeFta7iOLVasznq48sTa4wabyC8qI6DSBbJMI1wNZV4rFlokjBYJB5S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:01:20.5354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 590713d0-1508-489a-f19d-08de745d3526
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260885-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A5ABB19631C
X-Rspamd-Action: no action

Add proper PCI power management operations to support modern standby
(S0i3) on AMD platforms. The existing suspend/resume implementation
did not properly handle PCI device state transitions, which prevented
the system from reaching the deepest sleep states.

The amd_pmc driver was reporting "Last suspend didn't reach deepest
state" when the XGBE driver was enabled.

The implementation follows the standard PCI PM model:

Suspend path:
- Powerdown the network interface
- Set PHY to low-power mode
- Disable bus mastering to prevent DMA activity
- Save PCI configuration state
- Disable the PCI device
- Disable wake from D3 (required for S0i3 - no Wake-on-LAN needed)
- Set device to D3hot power state

Resume path:
- Restore PCI power state to D0
- Restore PCI configuration state
- Enable the PCI device
- Re-enable bus mastering
- Re-enable device interrupts
- Clear PHY low-power mode
- Power up the network interface

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 39 ++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index 112d7697174c..8e392cccd065 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -356,15 +356,34 @@ static int xgbe_pci_suspend(struct device *dev)
 {
 	struct xgbe_prv_data *pdata = dev_get_drvdata(dev);
 	struct net_device *netdev = pdata->netdev;
+	struct pci_dev *pdev = to_pci_dev(dev);
 	int ret = 0;
 
+	if (!netdev)
+		return 0;
+
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
 
@@ -372,13 +391,33 @@ static int xgbe_pci_resume(struct device *dev)
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
 
+	if (!netdev)
+		return 0;
+
 	if (netif_running(netdev)) {
 		ret = xgbe_powerup(netdev);
 
-- 
2.34.1


