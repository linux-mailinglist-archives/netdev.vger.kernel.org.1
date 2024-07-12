Return-Path: <netdev+bounces-111091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FDB92FD29
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 17:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18BC21C2322D
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E61172BDA;
	Fri, 12 Jul 2024 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ZJOM2bZ0"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012069.outbound.protection.outlook.com [52.101.66.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEC116FF2A;
	Fri, 12 Jul 2024 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796873; cv=fail; b=dGx78cuAOZt5jE8ayihnx4N1UmAQxE/n+8r0fT3dbTm+oOjdSL684+iBKXCqdXEFYUlvjpnxHV+sAP+HxCMWDwxa4gzoBzXS+r5gqgtYwBuXQjRcY5nxf94hhRY0n9Nx+Kb/hv2t+xeeNFL3SgYU+mWWdVV397i4BPTsJrDZlSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796873; c=relaxed/simple;
	bh=LYoUhg32a3eG9AFmNq02tap0Hqnf08vgQbvIWn6k7+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAYauX9gMVCQrlWi9Fl4BEkiLWgHqWKQZK1uK4N8e9yL8ck40ADeb7MTNm4JEr3OVvgIRRfMyPvVgyrWk6RNxvZP/U/8HCFzWHPlRdyCoPny7V6Nnqa/ah8fUJXlR0n9pIjvVnGHDegHHtkNMyXN/SGW38yQrLgoUTKh5INzDSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ZJOM2bZ0; arc=fail smtp.client-ip=52.101.66.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lm96SA4HirpzHJ+0HabX4o5OvNyQPtWnlDBxoHMwVmOniO89mCO+994Z1Az1DY3AaPyzMcSifMNN6YS7zoceuW24hNmAPLIR3YIrHRSXx5M98/js05u94kyRIcgwE6a91DKpaEfXph4QtT8BEoRSwDVfV128W0JifwJZ2ALCG0GN+P7lHA+h0qudCqYYLz/SmYStWbTPOla1tfSZsCH9jZpQOedQMTOxn8B2nL5dt76imB+7b02wMrLa7nBb5DsFinoQ0KxQItFkWE31tGgJBZgkpqN2sEHgXJyeMggy6VgCSJCqhf52nFBsuA/t/aT+jf+QMoCpxBOdRqMIG+x7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2UGSuof/XvQNv5jrGrK7kvmHCBK04XUSYxXMQI9C+8=;
 b=OE7DcB+J44qz8cRWAVHzuyZP1w4mB1n66HIbXz0FIrtcS6cm/K2XGSSMGwFXY18Tl0wAyaIqq1NWGaDliHIOeNnuP4oMYA6JEX9/YugJM6QN3Jfs/XfJOeVLF2vgoehLwhQg2fyfkGZvfVfKyK/FAxMILbwKfqZ81tFVcIFHVwkHniGM+tPyJKeGYkd8oNEMxQieqzwOkXFFULMAo1u4d7B0inwo7vyNkqUgpqOHa+lhNq7cWZV8KGLhaS1urfnjxX62uDPzypBykSDiq7+29Wlw/iynTLeVFRnLD3HE7ekQVxbwAm7NvuWGqyBl0BzrmWsAjHUhU1n5SfLBN7iU3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2UGSuof/XvQNv5jrGrK7kvmHCBK04XUSYxXMQI9C+8=;
 b=ZJOM2bZ0dpnOmr8oVaO8tCe+oSM1S37JVDPxKKZSLktrdinsQXoSxSgAuDUqyz7rxXwtD3V0/7C3Tc2aeO/0EWtDa7dv+nC9Y5lU2WREiM/xUYQmxynD1o9VhCKHBVtjfwT1VdF3kfa7u/QHl8mcdYTviKLAucuZFnQcI3JOXY8=
Received: from DU2PR04CA0229.eurprd04.prod.outlook.com (2603:10a6:10:2b1::24)
 by DB9PR02MB8348.eurprd02.prod.outlook.com (2603:10a6:10:397::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Fri, 12 Jul
 2024 15:07:48 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::ad) by DU2PR04CA0229.outlook.office365.com
 (2603:10a6:10:2b1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Fri, 12 Jul 2024 15:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Fri, 12 Jul 2024 15:07:48 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Jul
 2024 17:07:46 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <f.fainelli@gmail.com>, <kory.maincent@bootlin.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v12 3/4] dt-bindings: ethernet-phy: add optional brr-mode flag
Date: Fri, 12 Jul 2024 17:07:08 +0200
Message-ID: <20240712150709.3134474-4-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712150709.3134474-1-kamilh@axis.com>
References: <20240712150709.3134474-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|DB9PR02MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 15130b6a-5797-4083-49de-08dca284644a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVhuUU5tWGRnZ2Rtb0J5TGt1dW9FeDFtMWhQSENobmVqdGV0OUUrVU9FMDBO?=
 =?utf-8?B?VWlDc0hpdTh6MVZpSzdxV0NvdDVWOGhuM3BqbldtY1dOYnJaYXhYWC9rM2Fm?=
 =?utf-8?B?YmJwVFp0NDBCbFg2M0hIbHdOVDFOMVpRdVgyYUViYXZZQml1VkRrOHpzR0Zo?=
 =?utf-8?B?S3hOZGZ6RWs5OXZ2a0YyTE91TG9oVjRITk50UEl6STBCQW5UdlRURkZDQXFP?=
 =?utf-8?B?MnJDTWpUd0NiNzJPSlg2SzdvMXQ4ak4rNHQ1VDBOcnJzYjNRWVViY2d3Tkln?=
 =?utf-8?B?WHhyK05hZ1RyUGF0WjliY3VCUVRub1NUN0NuM3ptVTRHL1c3V2FmZUlWL0cv?=
 =?utf-8?B?emtvTjVZaEJVbWsyamJuNGxnSjdZMURnMjZsTHBMai9ZWWY2dXFkUVU1N29s?=
 =?utf-8?B?djhUWFo5ZkNCdlMrYnFWdHVXckR3SFlGNm5hSTdVVzhqdjVIR2J1cmt0bDNy?=
 =?utf-8?B?elZCaHM5QXBGV25yaERVdWJQVk5SRW02VmJKNFdHWU95Ulkza3F1alJkZmRx?=
 =?utf-8?B?cjdXZnRNdTRCdktpZy9ZNERYRHFmNEg3MGt2UUlKNXYyVW5MWVpMMEdxZzlt?=
 =?utf-8?B?NDVndFZpNUYxQTdWdWpHK3dScVdhbTJ0aWNYSW5UM0w0L3ViamE0UmpURVVP?=
 =?utf-8?B?aXY4ZzcwNTJybVhlVXNDb0ZYNnZLK3FkTGRCZy8yQmpBZExLc2V2UWc1UVRZ?=
 =?utf-8?B?VSs2bmRObnF0VG9BMy80UERaWG9FT3hjOXdLUHZDL29vTFRCckN1MW1vWHFz?=
 =?utf-8?B?SkhZZmQwUVlkMHhLQlU5UmFFVWNJN0VCN21KSXZlc3pFOHNOS3Y5dXY3dUNa?=
 =?utf-8?B?TlBKZDhqMno3VndKVVRja3ZlMFpETHJ2dE52SDdqNkpYalBRMlRPQnNQSmI5?=
 =?utf-8?B?RDhiOTk0Q1VjNEt1cGdHaHdwU0RCUHhZWWFMSDYxckZTbWR3YnhnOERhcHdB?=
 =?utf-8?B?d3AxQVA2S1ltdkY5NXVkRTdNVXNJdUgrS2FDNWNibXBnSHF3RXM2Y0ZKS3ZP?=
 =?utf-8?B?U1htWkdqbk9hUlExSUovNXBVM2Vnb2lTdDFTazdLbDJuWWtqdmozc252Rmhy?=
 =?utf-8?B?cEVUSk85d2VDOGVSMEZqeFFxckNWQVFGaVdEcjNTWnR2WU5MNGlkc0NMenA5?=
 =?utf-8?B?SUxPdGF1UUZFV1puNHJBQXFmRGVkUWxHbm9PZmYxdnpRNEZHYXVDa2RieVhT?=
 =?utf-8?B?aHh3czZSS21LazhHU2ZGT1ZoWjBrN1J3cmpuYVRob3FxeTV4V29GUlRYKy83?=
 =?utf-8?B?cDl3bDB1MnM3U1NOZytNK3ZqOCtxV2NYK1orMDF3SGZ0WXRyZDhUMkhqbmlN?=
 =?utf-8?B?ak95MjNmT3dya0xoallicUZ5WkJUVVYvNGEwSXFFd2hVaDRNVS9Ud1JVd3Zx?=
 =?utf-8?B?cHRWRXUwSkJLK1BTaFd2TmxJb1B2VlpOMWxoZzdkR200N3RGSXk4T21ZOGdx?=
 =?utf-8?B?SG5Cblc0Vi9zSHRxOUxRNmQwcS9lVjVJU3czRmVvbHZvcEtnNWlNRFdZaUZE?=
 =?utf-8?B?dGVnWTR3all2UE1BS25SUVVDMFd6SjNvSENVYm1wTzJjSHE3L2drMUlQY3kv?=
 =?utf-8?B?cGswRHNvdVNRNCtHT0U3SFJKajY4dEdUZDRwVmI0TEhCbGJMTmJNVGR0RS9J?=
 =?utf-8?B?VzY2QUJxMXUyRUVOU3VQODdOWnByRzdFTzRnbjZDMG5Qejh6eGVpcVBpaFZ1?=
 =?utf-8?B?RUV3Yk1KTWw2dmdYbmtoWGM5ZTMvblMxc2RPeFdpMkI4c2xjNG9RR1VWWUtN?=
 =?utf-8?B?cWpxL256eWh5YTJnWVpNNmo1Z2REQ0I2U1lwSFpGN05ZWE5BU2RuOE9JbHJQ?=
 =?utf-8?B?L0pJZk1jWmJEaWpiY2FhZmlsclA4NFp6NHA5ZzlQcjZWc2xzRW4xbUVJMlkx?=
 =?utf-8?B?T0x5VHFNM3VsbjhPUmp2UkFMMW01bzRFcHhRWFFqZlgvK3YyTFArMDkycEEy?=
 =?utf-8?B?QW9CZ3VHNFBxb2xBWnhFUGVtWjNza09wdnRGaW4zS3BVV0IxcitvUU13cEVj?=
 =?utf-8?B?TTJUT29jMkV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 15:07:48.0959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15130b6a-5797-4083-49de-08dca284644a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB8348

There is a group of PHY chips supporting BroadR-Reach link modes in
a manner allowing for more or less identical register usage as standard
Clause 22 PHY.
These chips support standard Ethernet link modes as well, however, the
circuitry is mutually exclusive and cannot be auto-detected.
The link modes in question are 100Base-T1 as defined in IEEE802.3bw,
based on Broadcom's 1BR-100 link mode, and newly defined 10Base-T1BRR
(1BR-10 in Broadcom documents).

Add optional brr-mode flag to switch the PHY to BroadR-Reach mode.

Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 8fb2a6ee7e5b..d9b62741a225 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -93,6 +93,14 @@ properties:
       the turn around line low at end of the control phase of the
       MDIO transaction.
 
+  brr-mode:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If set, indicates the network cable interface is an alternative one as
+      defined in the BroadR-Reach link mode specification under 1BR-100 and
+      1BR-10 names. The PHY must be configured to operate in BroadR-Reach mode
+      by software.
+
   clocks:
     maxItems: 1
     description:
-- 
2.39.2


