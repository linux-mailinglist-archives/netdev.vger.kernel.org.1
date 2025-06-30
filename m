Return-Path: <netdev+bounces-202447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A6DAEDFCE
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 652297A7319
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E1328C00E;
	Mon, 30 Jun 2025 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="kLdQjMRL"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011066.outbound.protection.outlook.com [40.107.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75925E46A;
	Mon, 30 Jun 2025 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291941; cv=fail; b=EF3FnGXjzc6WAtdKzn0KIlNWeBnvX3ka0BV8TOwlF6r81EpFecXeYTMgjTnxS0cyHufzOT5TAXhKACq7ivk2iYS+PcN+d/lc/b2gnWckw3XNwe/RM/Ze+xcsyQtN/Lj/+y7CPankZPuinQJRH1rue40jkQeRx2eEKOKbKgZuqTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291941; c=relaxed/simple;
	bh=HONgQA1eIr7wBzdS5oVi9kMVVn3lvWyzuA2cGaIBw3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsBclNjKcgHxfMoOkWU+dhpfzMhjBPzHzkIWb0Gx2V0768KzkH/+RWtZ8UuIRBlnQenwkrgyRUFscYsRg0sYMoliTkdLwO07E80LFzQR+UQ4wm+WZ/xCuRF94VGLfR2XMVUIpGoN3H89kbbgd+lxguH6dfjQ79XayOJn1BN/omc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=kLdQjMRL; arc=fail smtp.client-ip=40.107.130.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHoXhbYiejNu0yn4a5OTEjr2Hts11aOQD8Nv8nYcPhhUHHPhxxS3+I/8fLSzHCw9kMD3Ny/DsfAlWWsNwtslgvbh2j6H2cgjxpApd64BX95dKca0XHKWcyXyeRbBxNOnPCYqv/tiacdHRku7WK7LCeDBtzY4ae5yr7LhXKUVoRFL/k4s6qIl4TX8L8iBS0OamQ4gso0FsD8D9JbriJr9csqR28uzmT3hprooVg4VcDIeBgnZvn8Oorh6O+6dpY0lAqTrA2iexfO8B65v47Z7IV+sSoj2P0gYe7VcnXx1d78mrzwOFOn/iUDi6EdKLb0nW8M9B/RtS97y8giXg7xVVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8SseEgXzFI+EGbKxjsgxkKCUBGaiCnrdeNrcvNdZiQ=;
 b=q98VcGdIIVDQ4UpQ2WZ0giL1Ghn/2iRVwWr7OD3+sEnge1jvn6lrWs73+F3CajP3V9u9Pq65W1xIGjMmaIdHShduL5G0nzWUbwI/qrIbLMIxbDm3UlUgXUSDoNejPCHTC9Z7o0FVQrzm+rwwF8O7KGsKgz/MNwpKTq6iX+1nPBrAvXcEoZ/CSqySyrnyuoi+CKA2uo/6w9hEN3SrlZ4311esroBOhS8xG+6se/ltYOFBxrkI3/x3NuNV5y5yErBsmQhdbb3RhWN4Wxmjnd8OcekTGeukLafznKxG2DwVIX430J4Wf2T3K5MPe7FeR6Z9cco5k7HqOAABnsGVUsU+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8SseEgXzFI+EGbKxjsgxkKCUBGaiCnrdeNrcvNdZiQ=;
 b=kLdQjMRLjCIYs3cP4CQQQwIx8UrbVKJrsudMMvcP6vquORkDzJtQHt0EIHYNttXt0lH1XbWGD85n9bUkpn5KoXtf3l4DJ3g/T6zgQ9/7HNsuq2S79g4VBi0ai3IWZsz5/M+aPjfveRzBBglHp9sBSbXeeAGcHW1VaqblDhligXc=
Received: from DU6P191CA0047.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::12)
 by PAWPR02MB9101.eurprd02.prod.outlook.com (2603:10a6:102:339::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 30 Jun
 2025 13:58:55 +0000
Received: from DB1PEPF000509F8.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::af) by DU6P191CA0047.outlook.office365.com
 (2603:10a6:10:53f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Mon,
 30 Jun 2025 13:58:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F8.mail.protection.outlook.com (10.167.242.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 13:58:55 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 30 Jun
 2025 15:58:54 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net v4 2/4] dt-bindings: ethernet-phy: add MII-Lite phy interface type
Date: Mon, 30 Jun 2025 15:58:35 +0200
Message-ID: <20250630135837.1173063-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630135837.1173063-1-kamilh@axis.com>
References: <20250630135837.1173063-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F8:EE_|PAWPR02MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 6844a4a5-3190-4019-d72b-08ddb7de40f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|19092799006|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXNaKzZrSEN2VjhXcFpNNDRxVDJ2L2J5dkFxdW9sNHFLbnF1YWhhelhHOFli?=
 =?utf-8?B?cDg2ME1FcDF1MXdrLzd6TjJuTFJGVE96VGs1Rk9ZVlg4QndNa3cvZGdWUTh2?=
 =?utf-8?B?U2JNUVZ0T3pMemFKbmFJSjgyNi9KZzFaVi91alp1eExCVHRKQWluUWVqaWZj?=
 =?utf-8?B?aVpycDlkbE9HSlR1K2d4SHF0S2ROQzZTVzZIUlVKbC9vR2NZZjRKejdjNUxy?=
 =?utf-8?B?ZWYrNlMyYU42ZUNwbWFhUXZYOUxjL1BVVUhoNFozTnlqZjhtaDZzMmFZbEJk?=
 =?utf-8?B?MXpnYVdXd2ZtRnpsT21vNGk4RDNlVlBPVUdVOHFRQ05CbGI3ZHQ0RmxFT3p2?=
 =?utf-8?B?TjluMXBQWkxRcnFYNjhjaHBKWTU5QUhWUGJGVjZoWTB1alZZRDZqbzVvOFNE?=
 =?utf-8?B?NFBScGpROG4rbmRuQXZpdXM4NXJyb1V6Q2ZwM1l4SlV2dElodmVKTUd6VzQz?=
 =?utf-8?B?RVk0S0RTeFFHMFRIU2Fidk1aanB1aFFRRXBTSVd2ZUNHVHVvbmRVenJBQVUz?=
 =?utf-8?B?YTFTZDd0bldNQWkxZzNSd0ZCWkVrNU4xbno3SURKVlQ3YVFvR2tnWFlhclJ0?=
 =?utf-8?B?TjJraHFRak1ZTC9mSWd6elpGRXN3VEdJejJoSmx1b1U2Ukc2ZEZDSmJQdllK?=
 =?utf-8?B?THRxeXNYbXJGWjVwaU9JN3hmaWhPc1YrSUVLOXNnTWtZcWRFRldaelJoS3FC?=
 =?utf-8?B?dHZWRFdUNDlHZE52enQ1eWxyRm5jVEdzUUl2b1ZORlV4TEJKWHVWS056WDB2?=
 =?utf-8?B?ZXcvbDNiRExrMndGVUNYY2doUUdIRmpDbUlJbUtRR3p0UHNMcndZY0RVL2ZN?=
 =?utf-8?B?TmUxSUpYVUFpeGJjYnI4MlFzZ1JCelh0TWZDc0VoaWFHUnJ0SXBqSFV3dDdI?=
 =?utf-8?B?Z09VSmZ5Q2VhcjRHR0k0bmpuRVI5Sk1LejBXVC92Z1lxbVBGT1FyaDMwdkU0?=
 =?utf-8?B?UnpBN1NVV2plY09NUVh6OFZlSDBYdUU1eTU2N3ZMZCt0VnFKcW9IdnBuZjk1?=
 =?utf-8?B?Y3VlQXBEWWkzdW5ZRU90OFp5OW9CWU5QZUFDTEdQQmRDOWxxVFdwYzMyZFZH?=
 =?utf-8?B?UDFBU042ejlZQ2VnMHBOZlBWVitrQUgwSmdCbkgxaXozakw2RXI1azQ0Tzdy?=
 =?utf-8?B?L0tjU1BFRjBOMkgxNzBBbDVsTHdzbGdRT1NtUCtRM0hUbzlaTFR1WWRqNGZ2?=
 =?utf-8?B?eEJObFZyZ2NZT09xVmVuaEwwNVlWc2xBNkFZZHpML3puK1k5MzdFU0V6NjRL?=
 =?utf-8?B?YjRkUDliQ3FaUzRZc1lyRW5IUTJienJPaHNhK0VZUk9mUDJwdmJsZ1MwczZT?=
 =?utf-8?B?Z2tEY3JxZGJjL3dsVmh2bG9aYVIxbWZNVW8vNzR0eWFiU1luTjVZK3hRTXlO?=
 =?utf-8?B?Rm9tRGxTSlFESmx0L3dmYk0xQW93UzUxelFER3QrVXVKWHFrMGRsampYa0xz?=
 =?utf-8?B?SFZxRXRKTHRJN3FmT3YvSnRCbCtFeDdBM0lYRDErRlVWa0xTeHJJeEFwTXor?=
 =?utf-8?B?akFGWVBHN3RQK3docnZMaW8wTDZpWlhKUFpYZE9CcVRPWWwzNEdHSlRlYi9h?=
 =?utf-8?B?WTU5MGRBY05aekYzK1NEN0pxYVF6UEFXa3lYVmJPdDlKbGl1akdVNXhzSGpq?=
 =?utf-8?B?emsvVTRGQXJONno1RVNKQ2FDWnlNYU1JRzJvbHE1RTMyTjU1QlB4MzV1U1ZX?=
 =?utf-8?B?VjVpTUVaOGlsUU9TSkovN2lwek5nUFJrRzVOZEVhVVB4UDFsQ1lSQ2tHd09m?=
 =?utf-8?B?TU5VNUlLeHRyUVNxMFRlU0k4K0s2R013R0xza09ZZnFra1ExUkRpS1dKdHNh?=
 =?utf-8?B?T25NUlBoYkZ5dW5FNVJPR1dXbGxjM1gwNGs3MGJEU1FXMGFGN051NmZZRmJk?=
 =?utf-8?B?VTkwN2crUDFTYnF6dHNvNGpUdTdPMEFJQmh5ZGMzMGxrQzlOQWtZQS92V1FC?=
 =?utf-8?B?Qk1uUXUxM1V1QWlyaXI2aEp2bWVvTzh3QktFdDlYUTNaeG9Bc2FmTUJlaFNl?=
 =?utf-8?B?RjVZWmloVFAzQU96TjJQdnEwbGcyWVY3RkQwT1NtT3FJKzZzQWlYelZWb0t4?=
 =?utf-8?B?R2Nhcy9pZkliMzdWWi94dE5xZHNLRUpCaHFRZz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(19092799006)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 13:58:55.6425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6844a4a5-3190-4019-d72b-08ddb7de40f5
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9101

Some Broadcom PHYs are capable to operate in simplified MII mode,
without TXER, RXER, CRS and COL signals as defined for the MII.
The MII-Lite mode can be used on most Ethernet controllers with full
MII interface by just leaving the input signals (RXER, CRS, COL)
inactive. The absence of COL signal makes half-duplex link modes
impossible but does not interfere with BroadR-Reach link modes on
Broadcom PHYs, because they are all full-duplex only.

Add new interface type "mii-lite" to phy-connection-type enum.

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 7cbf11bbe99c..66b1cfbbfe22 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -39,6 +39,7 @@ properties:
       # MAC.
       - internal
       - mii
+      - mii-lite
       - gmii
       - sgmii
       - psgmii
-- 
2.39.5


