Return-Path: <netdev+bounces-260883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO9DDevWnmkTXgQAu9opvQ
	(envelope-from <netdev+bounces-260883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:03:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A23831962FD
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09BA1300B557
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B401934A790;
	Wed, 25 Feb 2026 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JuetxJ+W"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5967F2DF132;
	Wed, 25 Feb 2026 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772017250; cv=fail; b=miy7SrUhp1lsnpRpdVneSCAo2QRtGiV5Rg0Oe0bE/nxnIR5swN8IG4Zu6LbuZKVDV7LK9cZtbVq63TlhzsVxRGyvQRhCOyVQf+qpDt0mVvhjHNm1v/1RE/5AOLCdEWtjxX485GFDr75WYpDlYr4utEHrKVuE48l4p/Gouf9Pe6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772017250; c=relaxed/simple;
	bh=fwW2yo4JeusdpnSHMFPFnEq6sgOQl9mUFVbHLdxKBdU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m2dKnpjnXRTSE0cKvNTTgeieccwngd2o4rJxLEzba390h4Vdp5DzZaTpM3kH1MpKztc/aPHc2LaOIhpECIDcjEE6dn0U83ZAzgWX9U48GRORgKFOnnHgk2wYZCiWaU2Nq+/zO2tMLAFDttnICxgtTk6uakQRZMHFBmWi2cG3Yz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JuetxJ+W; arc=fail smtp.client-ip=52.101.46.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9pjLQLOv+eO/a51Fr75cZuZRe9oq4iZNSk54Kov9emFuI/1EyNnHStPPNKRDbmoWnzB0wVF4ZLq8U6a2u1FDa/82S5fpQxvpAVzzyD3gKaWEx1RcqKwuhaSoapeIJbXkdXJNZBXeEIEVkbfmioD9jj2kQAfTXCgXgSnCgSlkq3ioj/MOKtLx8jtglbt3oal6Ww54x9qUPqsHurjctDdeDxqOU8ccj4h6PyuKJ2cFrxJZYQJXf8sZA+ejDnyFwS7ujFu+sv4OayaaVMQ1l0QRAKCJ2dKMuHClEhWW+mIO1vOqfoeMnZSi+DH0AzTfOCa4Rplmj4gD27390hFKk+CNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y63dCRshxeD1M2WsxY0iWWNLdYQprxe6+LpIv9aFI+I=;
 b=WNv4kUXt2T166sHtA4mX2YvcAQSMoGfzFaGkMRdYM4gHeurvnafLwqcjHc51KImYlcqcFNwXTJjxCVgYkzRNgd6AW/onB11D4FRetzzEXLrbOB4KFjsjdCyJJaMaBP/iyrWiGhJ1pECXDC1lplQRkbwLCRye06ILLGSEZbYB5b+DjbX1d+HltJOaNkYXOofQl2SBj5J1B6AdjdKd0HVVm0CPCELhW05gpeHlc71ox/RezZ656TT9G8mTytX6INjndnyeg1tngi78D1GPXP3o7gFfnrpAT/yrczYIB4C7iobr8D1e6tHOLQPkZDUdOL+Bt0hqcdHeMI+084qsIuiUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y63dCRshxeD1M2WsxY0iWWNLdYQprxe6+LpIv9aFI+I=;
 b=JuetxJ+WWybT3+Ufj6cnz/ac77BAmwWnKhps00ggt6HF8VCT8GWh8/Be53CGzk1OSuCgNS5AssS1bAkYm9VM6Nd7P4/cJHcK46F6CfcbJm2/Fjv1gfC2t5wXSlGU7KExymxOXYhsg0g6g+FGKpD6lUB+GN5PVp44dsQvFT1dtBE=
Received: from BL1PR13CA0072.namprd13.prod.outlook.com (2603:10b6:208:2b8::17)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 11:00:44 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::c5) by BL1PR13CA0072.outlook.office365.com
 (2603:10b6:208:2b8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 11:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 11:00:44 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 05:00:40 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<Thomas.Lendacky@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net 0/2] amd-xgbe: fix S0i3 suspend/resume issues
Date: Wed, 25 Feb 2026 16:29:59 +0530
Message-ID: <20260225110001.1000014-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c78317-add1-45bf-bad8-08de745d1f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	HVGiKu1HWZGjun/E6p2mgKlWObcD7Ym8TgcAD1tUxpzVcUThwS1XnC0EzsKTOp9adaX5pN+2T8Aq32G2vQ83jMKCZp5gmHUvi4IdKpPcTJ0j/rgbI4PB8maYHE48eWbG4mCTWoF4AHfWefXx313MOln7kaqR7MUWu/YGxdgMoD957TlfA9VIinFWkdsVn4VsqGUOzfMh4rTmo/fs9itpYHLcDHudic6Y/eKKOEGITl+ZHFRv/n7rpECGw/BNObkMBzs3TSsSazzfPpt1kR4htoqZMw8U0pDEN+QbvnrocYaBtOXOpBOaWsCC9SvxQXQFEq4mHJkn3x0WvaEdTUAQ3k0TPhIIeZOTMXzURtizxGxRGYqb9yu4j4DC5bE73dN0y0nN7hil7ec3rPfz26OVKcs59KQFYUmZEX7+uFnOvj1zHEfX/GQuOAG+PxGLvwKNjtE/DRpUxyzL2G+NRnsr+WWV0Qxmy1xd7Mj1LL7Vaq0kVsPKPmCauyG1Mg9fwxWGCpeU+SVryaDdcHp6XTR5mc3FgQyEc+ZM+AOs7cm+wkqLzgLd0AAIEvHdPAaZotxcGCzhSD7Qpz+g06L9QuaowCIlvO2igoqmRuutUGrfnYHxwMB5HQaHMynPMWIdHGDS63J6BlEt6ao05PW2YI7Msd7UADt/jY/5fpAtDQu9aBDj44v2ABxehNIGpdS71pagsjMLNbeXM35O7YfEaVaJe6yFgWVyxv+QMQPOR3A74Kyi5HBnoSorVUQjbYNDamWWvL7dNBWVp6lOiPr3zPpjQprzEkaevSFzsXt2z4fPEp1+wpLIxEJ99pp4zQemmv4trLJb26qdzADpkkY55nG5Ag==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0qM66roHo+eTgVqbVoW+1qv4dsrwERveMsOBjiBVVPbTZU3hRTlENmkQOaGJfkFWDI7DvqNiXJFchaZxie2TnPPClvJloL078TqNIQVBE20vNsAWh5CEpfe3TpiJXJsiIJOKweb0Fldiehp7+s2TpRIYpFHyYZoOROnkOSIp/z6keCn1aFlrpjwmCT09XaIzrI3eMCU4knAyRaBWDQ1Ig5ChWH2RHgywG5cY0yw/ZADtV8SHEMWUqgHnyzXX+e06R1nWtCWV3Kqv5W/AJfWyH62zXO+dldOvL9IEJTdc7N/a9POJX6qi+YJB5AG2SQghbfN2Q+Gh+6vDvsX45GPM+rFfnu0roE55X9yQ0Wpld2eaXWOsN9vuCctMbiTeZvjjWVda7Pc2Ra+BnTnxywJBzbNepcZkZCOjd4tI+9SlXEZylODQIOKrTOe+93pLmMD1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:00:44.1490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c78317-add1-45bf-bad8-08de745d1f76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260883-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A23831962FD
X-Rspamd-Action: no action

This patch series fixes suspend/resume issues in the AMD XGBE driver that
prevent proper S0i3 (Modern Standby) entry on AMD platforms.

Fixes include:

1. "BUG: scheduling while atomic" error during suspend/resume:
   The xgbe_powerdown()/xgbe_powerup() functions call napi_disable()
   and flush_workqueue() under a spinlock. These functions can sleep,
   which is not allowed in atomic context.

2. System fails to enter deepest sleep state (S0i3):
   Missing proper PCI power management operations prevent the system
   from reaching the deepest sleep states.

Patch 1 fixes the sleep-while-atomic bug by removing the unnecessary
spinlock from the power management functions.

Patch 2 adds proper PCI power management to support S0i3 by saving/
restoring PCI state, managing device power states, and properly
handling interrupts and bus mastering.

Raju Rangoju (2):
  amd-xgbe: fix sleep while atomic on suspend/resume
  amd-xgbe: add PCI power management for S0i3 support

 drivers/net/ethernet/amd/xgbe/xgbe-drv.c      | 57 +++++++------------
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c      | 49 ++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c |  4 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  8 +--
 4 files changed, 68 insertions(+), 50 deletions(-)

-- 
2.34.1


