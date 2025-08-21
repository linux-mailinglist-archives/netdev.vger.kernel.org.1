Return-Path: <netdev+bounces-215757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E70D1B3022E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB50AE1EAB
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AB734DCD4;
	Thu, 21 Aug 2025 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NlJee3fe"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011025.outbound.protection.outlook.com [52.101.65.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8878D34DCCD;
	Thu, 21 Aug 2025 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801268; cv=fail; b=NXu6XSCdo4cvfhrWo4vLiMDh8agN6v85h2PdhheZwo7jvKFu8XNovE5GsnrG1shoMMivMsBs7/G58P7abjmjB3+iUAjuy42ifvtUqT7uqeynAHWb2mHuZDhlpzrynSbpUy2eXSEY5Emq//jXSctBxGzhpW5dwG/puuWwwATHe0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801268; c=relaxed/simple;
	bh=0v1T8WSE2wwci2MwGQCkl1hxBUhRWjM5z3p91UGXEbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SgHaUEOOw9jhB6k7HcZsSo1SnYA+5uGgjcf5J+kLQOj+V9fkmcUr8koHSj6GcvRyIrrNspMip74C0dQbTXLom1jpN3sbD0WXNO/nwCkxnAzVx6Q76osW1drC+9/bj63T43rjlNSDNpnEVJfsshmGxDSfG/uo+KOXrjWxMs7GGx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NlJee3fe; arc=fail smtp.client-ip=52.101.65.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXpkTYVLDkD6LnBA9rRjQYl8ZFyYVf4Rrap70yoYW3KS7JKafdw1EWyFluB46RgEZ8AyFcOFzat3hLEFlpIIz5zhXTcHuE9zlhTwX1DS/ylrb7p5R+hk25CGlfXcTPnfVfAAA17KgslkfGXk0UiHAoT0fk6ROHagwbWCrUDKvJf2GHUe4giG3uFjl6KaMy+SXuQtS6kmOCEqs000POt0WFJjNm8QihtOsW2e7s7UPrX7Xdr3eRHokKCR3zNCOIEwyzlyeee9NrECypKsS5yXw3xth51bQc2+pxnXERxTfj4IG/Ef1bliqVPNvjBgAvVfxyNleHkYJ2pDwDCOftvONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/UC949JTRjfE7ufVt7bgfG5q185tnZ3QYnOYo0THHA=;
 b=yQrnz+uWxHWn8UCQU7ghevqEvRmP+9dbmt6eBUhBu8vM1TeeKiBnwNLA7IkACiBBcOv5Hph/ZkZJxhmOid7qSLAGo4cSaqTo15GJEn78g0Ci3QlorVgLTA+G7CfuHcHWBhwPloMRuZ8Yn95lb5uiHwcoI93SsVb+rHAArP3OlunrR83WUT27s31N4YlIlW8t7E2KxIO6L5NTl+/WBCsijRjtQ6KSqc1qifxLcc+bIGdcux5tig6jLeWVR4kIAWp86KM1Bu2ki4EMPd/ucEspbbsD8OISKHgu2Q/RvtX10v2kq/5mW9v2gx4hukTuQIGy8RWlPrC2A6rtNEOAeYLIBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/UC949JTRjfE7ufVt7bgfG5q185tnZ3QYnOYo0THHA=;
 b=NlJee3feDB7pmBPprEJcfJCQZvFkxvjBsbLugra2tJavgqivrQV4UGW0CXPKz/NVBCQdub3A4V3CTIytfSGHNB9gRJSg4pcxmqkiDWZJrrl92NJbvRtcjaE7baSxwYwk/m76D4hOHSBQ3mV2ghOhahSDyVJ0dfAZvH0j3wH9dnQV05ZhpgDYcn+/Kl3IB5OLVHzhXc/ZAlR2DMYmHfJWTfe1SSbMDyB1MJhkLdDCPg/WTWsK1s+8fQet2fLd6CHUFhS5f5aGG5YTi76ZP089rsGdTY0dJEYx1wdXQh10qAtfoaoMDHQd/4d8Gj87epzI8RALm6Z13KFALzqW5QUBeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by VI1PR04MB6925.eurprd04.prod.outlook.com (2603:10a6:803:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 18:34:23 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9052.011; Thu, 21 Aug 2025
 18:34:23 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: [PATCH v2 net-next 5/5] net: fec: enable the Jumbo frame support for i.MX8QM
Date: Thu, 21 Aug 2025 13:33:36 -0500
Message-ID: <20250821183336.1063783-6-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821183336.1063783-1-shenwei.wang@nxp.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH5P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::10) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|VI1PR04MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa64621-5991-421a-642f-08dde0e1598e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xliQ1prZA+//x0s7wpmFyzmqDm6YCvkFVC5EeKjipvy5W6i1mF1ZnzelMXn1?=
 =?us-ascii?Q?h1+IegXIcYBuGJLwZq5AKe+ig1qIq/Q8lHvjvO/qY8XcETmUYWHYV4DjBzgy?=
 =?us-ascii?Q?wgC3MqDCbXeNk6P8q+AEQhToadYFxkKv1Q1dqMB2IY/UX3JJTS7DxZJPZ8s7?=
 =?us-ascii?Q?JxZgLWrSZbF2KWyM/4+RfpmLkTlzT9faAD33X63IaZMreDCTc91mNta3tKb/?=
 =?us-ascii?Q?uYXDG3oEmNExHZGSXSgsjAmfx832mHR9jPDQZE32lfT0UG47eYvgf8EZA5Gk?=
 =?us-ascii?Q?sbonNKPmuxO85sPvf4yh67xsx9Vmt3lCwjXZXGXB7HPLb886Ov6Lfp3kAEzd?=
 =?us-ascii?Q?AFyuNtYxzrSamwLZ0NCTErXBdDZEGubx2KAI0kn3wyuX4Tp1DbvM+YYMXAW9?=
 =?us-ascii?Q?aiQj3Us8zNn4Ov/HCT3GFxvMJMTQ+A1p5Tu9z+fu9mackGwwRB5wMkXqqoV7?=
 =?us-ascii?Q?aOKO3oisEbW/RSr5DhBQ2dpbHYzysQLhzAlcTiklScpZbVlbQwP9ecHObMtZ?=
 =?us-ascii?Q?uzwJAQ+fBGmvzczV1n6skEZL1Zhw9yanvGe/td30q6iYQfjWtKC61tH59jQt?=
 =?us-ascii?Q?YelVX4aiwCKgkrDVxw/1qEghdrPwYCwYlv1jAnyx69m0RDqOIvVvw9XJ6O6A?=
 =?us-ascii?Q?EnPPYuRO/qdtB0PtoJXks0fkDb1Xl9Qh22No5x3Qf+mqvfVUQieTX3JTNYEw?=
 =?us-ascii?Q?F7tzQCZ2auDzYRViey9yh7WBvcJedH8unIb2AieYHx5rqIW+ctmkXmpQvUa9?=
 =?us-ascii?Q?xNUUVeDfaZ/k22cy4HWx98qC0oACmDMINsxckKx0KvEA0bFs3o+pnT3pI/MS?=
 =?us-ascii?Q?en/o4hnhqZriIWX+TFUgMQIi6BF4rrCmRxqj/fpPWjavqMQXvaxsJrxWxC6F?=
 =?us-ascii?Q?jru0FB9/EwiV1FQeoTkghJkH1PwcVTf1ASo7zUOb3PfgtNL+DSXECalCtwgV?=
 =?us-ascii?Q?UfgciacpwaO9+QY8GMOSNUNLtnxMw0TP1v1ePGQS180ItYxCO2cA5NJWMiAf?=
 =?us-ascii?Q?eGCqQ41NcvKSVHbQ7UeQwF76eRgfGpiUVRopyvfgbI5yQ+8nTiMNyqaxhR+2?=
 =?us-ascii?Q?RzU8bMv11YQb9iEAksYfAbCJ+WjmVXZ/BGYKSLRpXfWK3rBwDeCAsNcA+Y23?=
 =?us-ascii?Q?wARf8Ct3bjWQMzm0LjjEhI5fn7nKBWgzWefybKhpEDIumDZsK1VGDLXuLm4R?=
 =?us-ascii?Q?Yy48nbgf4pE51rYKmskoO1rzZNEM8SKeU0wGdDrswTL8aIwPFcfBurwRX3md?=
 =?us-ascii?Q?nTXkazhPcVu5UyRrLZlxb6T/2SOnlfswj8PzsaTri12UZd8oR1xXkkUo0w4A?=
 =?us-ascii?Q?kdslc3zcgIbhByMdNp7jMDcs3LAudI2aFANadMYb42QY5K/UR95Ri87vf+fp?=
 =?us-ascii?Q?oOvXHIsBEAnc+ymddSpPOfsbpw8W31gmt8RL275y53ecjZxKLM5ngB9COfoQ?=
 =?us-ascii?Q?6ymwbGYxhQjMvgFZADOTEMW/LUxbpV2OLPn07qFMCkwHv+H/Cx4Ghogo+eIi?=
 =?us-ascii?Q?SqQtN4YvE0aSO3w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0lNB8J9vvVYnPjyCfrtSwBOF13JdK0/5Fz3AEb6geIucnj3aqKJLmAlINqlL?=
 =?us-ascii?Q?nzMPVRt4pFI1DVYvk+VM5k4wdnJ9tC+FTLqq7JcR7SLPvSdhz5eqwaw1ypsb?=
 =?us-ascii?Q?yYkpDdX+UYKHkLF56NSIq9qnihRMKQT8Aq8fBIAgU2EvAi3P6OZCrQckukBW?=
 =?us-ascii?Q?k6d8c60XsbRjNICIgWj5+bnmgKAMw/VPOHK2BmSuNQN13XkfZnf0Y+40+XCp?=
 =?us-ascii?Q?Ba+iIFgFcm0lvr5rncOq5FmZRqiz4KEF9d3STgwh7AxLdKssppWBVER+SEOD?=
 =?us-ascii?Q?XYC4e9iDP/46KFzwkPqVvzDXDNE2YL7xAdI6kFxbPVOt5S0UjsfeChgk5vkK?=
 =?us-ascii?Q?C4nHFntmuOPHE3XbQYqkfEWTGW2cwpPinI7MRWr/kXGMILmOZFDgXGtFNPY4?=
 =?us-ascii?Q?0OB/zlfyieTYvo4wJ0D3C2MvyrXPNXdXK5QI/PxGHjT4rDoklli5OUBrJTKo?=
 =?us-ascii?Q?++p1zuB+aoxioOU7jlrkhQ5FRCsJ8qkm6JMwKRpdgHd+av1YomIkVNIhOrjY?=
 =?us-ascii?Q?jK6y6PD6HaiOmaasG1bg2HOuhNQlg1jq2FKbkQOykcO/0xwpXlWgulDnSk5a?=
 =?us-ascii?Q?R0G7vA6VdoLS38XKqmiIeasSSjLq+2DlH7e2lxWhVV054DO7r32tryvjPn+o?=
 =?us-ascii?Q?iXNQmOgPMATH+u30rOlhI3v3znYS9uw0w41C096NtBvX084BzyU/2MB+7azj?=
 =?us-ascii?Q?5XKgNT9naPkjcpvwuZpePmD1r0ylZxmcO6oKGSCi6EwwYPoa1jEcs7Cm2Bor?=
 =?us-ascii?Q?qDhc/exF+ry8+FlM0obTSrEG0YyNttApFtU+YeYRFCoyNRGoD5qMzzZCYewH?=
 =?us-ascii?Q?AdE/QFz8Hx5EQgKxeWrkVwQ1kT6keKzBClVmn7Z8/s4G069MAjdOtbn7T9qn?=
 =?us-ascii?Q?uaBB7ZP3NHlTeRFG3giL5qv6lbWy2efPW8H3+3bMjSCcVU5riye4IxsDFZYr?=
 =?us-ascii?Q?H7Gu1tWrJSbmjGejGKGr0uuiiZnyTdAvMAoYz1KIGoCB0E1P4X9Prawo87W9?=
 =?us-ascii?Q?LC2exCta1ZfPbczMMTvp5guBWjB6P8aBlm4bASJ59mok7CJ41FeFheO3avoQ?=
 =?us-ascii?Q?o7dYkF+7jSxmaw1F3m7KsK9CwT/U+Z3ZYEkGQGFAbO2H6DhDxSbDGRbeObMV?=
 =?us-ascii?Q?hI3dvNy+eJc9/YhTwrXMJvACIDHNoIR6MWjRwsvPghqCoFNw+L1O1Pr451DU?=
 =?us-ascii?Q?lTB4Rgjx/mAIZDjVmmAiaOUj96WtnYMWCSUZiU5hgV7G4FLoZHYbZAo0GFhP?=
 =?us-ascii?Q?xagm9CsTF+ROQZyJKZSa4VSzIoFymqmdsUruZi+f9jKq3sFeZJAlol+dCS/p?=
 =?us-ascii?Q?+ZkKhnfHaca9nuxwqsOkFMTo4h2e9i8nrdtgN0VV7RFAV5P0IiK6740bFDmV?=
 =?us-ascii?Q?OvTJuMx2heojc445QoEXY57HT28wmjlTutq0ZTvAhiXpVxuYgu1MFMm6jRIZ?=
 =?us-ascii?Q?VjGNFHNjPrvfPyX1FYEhDlKg535pKVsv+oMA9whLVg20TToUo+7VL5RegKp+?=
 =?us-ascii?Q?Fl7jH5Jynpum21d4YZ/SXp0k1g0f7ZytNz9smBSPH2uXhDwaNKZ+UqzfPJX3?=
 =?us-ascii?Q?vvL3uYXEvQVULhFP1xGTtELZPfoxcdntlNlGsHxS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa64621-5991-421a-642f-08dde0e1598e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 18:34:23.6770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zS1hAp4Zxy9qu1dRHGIxI+US8AyJd7T1xbQb+SDXACteHb2FLzUNsbxNgVAxiB9ei/q2ak8IaZpxYwzlTJTFQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6925

Certain i.MX SoCs, such as i.MX8QM and i.MX8QXP, feature enhanced
FEC hardware that supports Ethernet Jumbo frames with packet sizes
up to 16K bytes.

When Jumbo frames are enabled, the TX FIFO may not be large enough
to hold an entire frame. To accommodate this, the FIFO should be
configured to operate in cut-through mode, which allows transmission
to begin once the FIFO reaches a certain threshold.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  3 +++
 drivers/net/ethernet/freescale/fec_main.c | 28 +++++++++++++++++++----
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index f1032a11aa76..6802773c5f34 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -513,6 +513,9 @@ struct bufdesc_ex {
  */
 #define FEC_QUIRK_HAS_MDIO_C45		BIT(24)
 
+/* Jumbo Frame support */
+#define FEC_QUIRK_JUMBO_FRAME		BIT(25)
+
 struct bufdesc_prop {
 	int qid;
 	/* Address of Rx and Tx buffers */
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index aa85a6d0b44f..160d49e6f86c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -167,7 +167,8 @@ static const struct fec_devinfo fec_imx8qm_info = {
 		  FEC_QUIRK_ERR007885 | FEC_QUIRK_BUG_CAPTURE |
 		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE |
 		  FEC_QUIRK_CLEAR_SETUP_MII | FEC_QUIRK_HAS_MULTI_QUEUES |
-		  FEC_QUIRK_DELAYED_CLKS_SUPPORT | FEC_QUIRK_HAS_MDIO_C45,
+		  FEC_QUIRK_DELAYED_CLKS_SUPPORT | FEC_QUIRK_HAS_MDIO_C45 |
+		  FEC_QUIRK_JUMBO_FRAME,
 };
 
 static const struct fec_devinfo fec_s32v234_info = {
@@ -233,6 +234,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
  * 2048 byte skbufs are allocated. However, alignment requirements
  * varies between FEC variants. Worst case is 64, so round down by 64.
  */
+#define MAX_JUMBO_BUF_SIZE	(round_down(16384 - 64, 64))
 #define PKT_MAXBUF_SIZE		(round_down(2048 - 64, 64))
 #define PKT_MINBUF_SIZE		64
 
@@ -481,6 +483,11 @@ fec_enet_create_page_pool(struct fec_enet_private *fep,
 	};
 	int err;
 
+	if (fep->pagepool_order != 0) {
+		pp_params.order = fep->pagepool_order;
+		pp_params.max_len = fep->rx_frame_size;
+	}
+
 	rxq->page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(rxq->page_pool)) {
 		err = PTR_ERR(rxq->page_pool);
@@ -1281,8 +1288,16 @@ fec_restart(struct net_device *ndev)
 	if (fep->quirks & FEC_QUIRK_ENET_MAC) {
 		/* enable ENET endian swap */
 		ecntl |= FEC_ECR_BYTESWP;
-		/* enable ENET store and forward mode */
-		writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
+
+		/* When Jumbo Frame is enabled, the FIFO may not be large enough
+		 * to hold an entire frame. In this case, configure the interface
+		 * to operate in cut-through mode, triggered by the FIFO threshold.
+		 * Otherwise, enable the ENET store-and-forward mode.
+		 */
+		if (fep->quirks & FEC_QUIRK_JUMBO_FRAME)
+			writel(0xF, fep->hwp + FEC_X_WMRK);
+		else
+			writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
 	}
 
 	if (fep->bufdesc_ex)
@@ -4608,7 +4623,12 @@ fec_probe(struct platform_device *pdev)
 
 	fep->pagepool_order = 0;
 	fep->rx_frame_size = FEC_ENET_RX_FRSIZE;
-	fep->max_buf_size = PKT_MAXBUF_SIZE;
+
+	if (fep->quirks & FEC_QUIRK_JUMBO_FRAME)
+		fep->max_buf_size = MAX_JUMBO_BUF_SIZE;
+	else
+		fep->max_buf_size = PKT_MAXBUF_SIZE;
+
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
 	ret = register_netdev(ndev);
-- 
2.43.0


