Return-Path: <netdev+bounces-292423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO1VCK88F2qg9wcAu9opvQ
	(envelope-from <netdev+bounces-292423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:49:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D70C5E935E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E34CD30AF630
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C138B47D938;
	Wed, 27 May 2026 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YQelLEpI"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A67283C83;
	Wed, 27 May 2026 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905973; cv=fail; b=q7XLM5Du3vFYU2ZJDmcXLd6P7rw5z5pZY6uLrQax4uC3GXXuDYe2MqgWShl8jxgnIY2ORtiuP4qTPhDhvImr28cy65lIvHzad/P8FFTUAbud5v/lyadAr8EbhO337lMQTeRHkVkcPuo8h6wS0KQ5NQskVBI3CcClRXbFWSVROPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905973; c=relaxed/simple;
	bh=gN4K/a9PTfv7p71mlOEqk4O2gr3SUGhHDX622kowwIg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSB21B1MvTQ+tOgfN+aYMqiqy4GoiXjb3bIVddOD7PIw4qd+L7OhrWaKe4Bj+Dgq2zCccq4YKUV3nglkSj8sYpIAHudxLjNG/RV5ciXY1cPIqNlFQPfLdTS0QspFAO/zSmHhXCq5Hxi7NwBnxNWUafNaGJxOyrbe7rvBziAMh70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YQelLEpI; arc=fail smtp.client-ip=40.93.194.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGfdwuXOHqJ3lxQO8BPtuVEmoTa+3Rd/UwZ/EKe8bHqT8LBejvMtr/ySpQxFpoet5gYNbQsO69umHBa7fdH8HYLA7l1i0Tol5PUvX522z3/I0FR7teb/Oyo3AJ9tbYIUB8mi+aU5wqjd8IMrNlmCOraWXoCYInkytEPmjlFgEqagg/61BUeBGya+aSGfQvowGvZTlPb2Kskt1jSq0wI7F/4GC0zBZfI90CmXm81jZXd5Up7fc0qEbD9Jjo5JJqaAncudA2r5qznjGI6/idrDvyVryN13NIJaqv8cGVPysBBgcr9XjQUzG7qEVXP/Kod1svaL9jGfCZwrDRp19PQGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siUhwQcZOxpzAFBCOdKBuU0TOIS0iMhCvqwiTh26uvQ=;
 b=tGMETlj/w86B5Vz97iyBWddfYhgH4OGpel8QenobIFRBa9eX5fuSnFhd33DXviCZuX25pYl6femRpNTHZ6DoF2XnAiqvJgvID0xUR35QnJGCELWowzSlyr+lEpDM8WgIShP0RauCOXrkDAXfwwJp1H3DUPRxud8lRjjEieOLsFw4tMTKCb9XQvb2p5XpbDc538elPcAzGpFhdMnnm7pmzi7y+UirAjF07IFZLEvaAEOicwul9cSRN8+cYzzxoPA4etEGFREJaa7TnQj874nfDv4dHHgXLysMjBhbXafx7VQJZypSyTySvZ90rVx8/xF9wmgiqvb493an7rtWTU3ORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=microchip.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siUhwQcZOxpzAFBCOdKBuU0TOIS0iMhCvqwiTh26uvQ=;
 b=YQelLEpIxmtNDQ1WjlExVIliWelvOF6OfG0ND5vv6Z0qg2auMRQrYe/hpfExxqS1ax5qJ8mitqjWwgFhXsdBk6PC1aqOLb9hlWxeSVChPtrli5H36UYjEatIW9A5Wu4qoJ9m9GaES+wa5dpX+3hfTwSh9evJFccJgyygXAqVZXxIFYCKhZPNbcGG22U1QAw4AUs40zILKaLvxOKh/jCgN8XhPmh5kPXPP88tClxA68BNeLsXleCWLlC14Dd2v32yIxDyBakXvvDtTtgeAIi2vyGnb1G3s/51MBoQnn8h9Aq3fpdVfn55M0MluC1QFd/N6Q8hJBdbhWuMvZ5u0kzHKA==
Received: from DS7PR03CA0092.namprd03.prod.outlook.com (2603:10b6:5:3b7::7) by
 DS0PR12MB999079.namprd12.prod.outlook.com (2603:10b6:8:302::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Wed, 27 May
 2026 18:19:28 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::31) by DS7PR03CA0092.outlook.office365.com
 (2603:10b6:5:3b7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 18:19:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 18:19:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 11:19:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 11:19:06 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 27
 May 2026 11:19:06 -0700
From: David Thompson <davthompson@nvidia.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Thompson
	<davthompson@nvidia.com>
Subject: [PATCH net-next v2 1/2] net: lan743x: add "message level" module parameter
Date: Wed, 27 May 2026 18:18:57 +0000
Message-ID: <4c240063db57c93541e3de61900a5d7adffdfd27.1779903597.git.davthompson@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779903597.git.davthompson@nvidia.com>
References: <cover.1779903597.git.davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|DS0PR12MB999079:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ad26a3-d812-4b1c-64d5-08debc1c7d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	awJLKUSIRjogwlxDuT1ogTyNUGW2IBvZTscnKGEL2NO6WVRxTT3r6Sggvm2UW2H8TUmJXr5fNxn0wcUBRXGMUXp8B1ZcKiNaz4WkRAQ7/sDsG6F2nKWE5UIjDASxMg/Sn8XWkYxKS9RMVqrpwZi7cESeOH823ot1GnXUlN1/+i8YLcSIzruYoH1lLuyAieUiP0j6kiasZjMjUwozjyZMhVuL8+9D2jQc0YocejaMj6gwNQKib3kGSGlSsyn0lBVAv7xJ02nW2oSLkH8i2lfeZP2u1mozKfKj62TiubXWsExpjV5z3gUEj+QUVHFfMTSYtgPk+akHRRbz55BisDW5BVXIQ+gFvf8pUFYpen+yeYl/JSJu5iZiY+Rl3UD1N/IvBsdIozzBHriIm3gqsv17Lc8BHmR/RbjgObn2Z4m8YY62X7CK2iXEUPrkuXezZR+W1FaWkvbHL8qF0dolqBb4YunS/vRX8bgDAo2NbM/6/hqaRU+zk+/0Rii5ACWqVXbtZVkV2Ltxi2LiOz/VtuAWbuELdP8zRlvsGPdnMClWGl+FfYlMos6D1rcdeLmAM/KSH0Fv20knmSZ70M7schMfpk2wAi2mZCMZo/bFl/FuRatEuZaKA7zxlKI+DVuBv3p0nsXRJH//jd1upYK2SWb7KXSIxzXhl0OMj1dHdr8mJdZlhyhiAoKs54t+ntabWb4X3/OLY8X0gY4zcQFQwnikT8UeJmTeqZxdKxK24VWzBGU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tZedFK5REpLCCX00A7opAz2fUEAjzomWEGePtjX353AkaAj8Mrtu9j+zy86WotWBmee54F0Qynk8GIVAMq2z54C4O3BsPjzhvuK7K0vEgCSEylYS4E1OznWZoNtpAc62v3TJK4lvN2WgJKKLS3Sf+iT9rkGJ8QNel633buiFGNWwzlzZt/09eMN4u0C5CvjNy1HRQZQvDafFba0MnWZWr9JTOWuASijRiv0hqqQqfeeYVQDdhvlfYN8i7beqMYiELmjsm+G97E0m5QlMFLYlIKJ+8gnCipRHtRH+IDUb9CphfVBRTG2ETez3MetnifJsyDDFteXLXeybYrgX9LbAqOTaBjxD/UrNWwGlJIIDXxQ67KtWwECQ++Fb5gtFEIor04eP42bH89rv6cokJfFGY7gsF4P9knSgNOned2QMseDHFwM8wXoVrfaGQ0KeqrEH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 18:19:28.2056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ad26a3-d812-4b1c-64d5-08debc1c7d7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999079
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292423-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davthompson@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2D70C5E935E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The lan743x driver currently hardcodes the initial value of the msg_enable
parameter during probe(), and uses this value for netdev message logging.
Instead, the driver should provide a "message level" module parameter to
allow users to configure the logging level at load time.

Signed-off-by: David Thompson <davthompson@nvidia.com>
---
v2:
- new patch added in v2
---
 drivers/net/ethernet/microchip/lan743x_main.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index f3332417162e..793633cced19 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -28,6 +28,17 @@
 
 #define RFE_RD_FIFO_TH_3_DWORDS	0x3
 
+#define LAN743X_DEF_MSG_ENABLE \
+	(NETIF_MSG_DRV      | \
+	 NETIF_MSG_PROBE    | \
+	 NETIF_MSG_LINK     | \
+	 NETIF_MSG_IFUP     | \
+	 NETIF_MSG_IFDOWN   | \
+	 NETIF_MSG_TX_QUEUED)
+static int lan743x_msg_enable = -1;
+module_param(lan743x_msg_enable, int, 0);
+MODULE_PARM_DESC(lan743x_msg_enable, "Debug message level");
+
 static bool pci11x1x_is_a0(struct lan743x_adapter *adapter)
 {
 	u32 dev_rev = adapter->csr.id_rev & ID_REV_CHIP_REV_MASK_;
@@ -3661,9 +3672,7 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 	pci_set_drvdata(pdev, netdev);
 	adapter = netdev_priv(netdev);
 	adapter->netdev = netdev;
-	adapter->msg_enable = NETIF_MSG_DRV | NETIF_MSG_PROBE |
-			      NETIF_MSG_LINK | NETIF_MSG_IFUP |
-			      NETIF_MSG_IFDOWN | NETIF_MSG_TX_QUEUED;
+	adapter->msg_enable = netif_msg_init(lan743x_msg_enable, LAN743X_DEF_MSG_ENABLE);
 	netdev->max_mtu = LAN743X_MAX_FRAME_SIZE;
 
 	of_get_mac_address(pdev->dev.of_node, adapter->mac_address);
-- 
2.43.0


