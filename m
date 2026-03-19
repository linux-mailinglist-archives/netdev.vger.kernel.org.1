Return-Path: <netdev+bounces-269329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMYhHkGlu2lBmQIAu9opvQ
	(envelope-from <netdev+bounces-269329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:26:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD832C7432
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFEB230C5B40
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 07:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40B939E176;
	Thu, 19 Mar 2026 07:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FeGMmXhl"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3172634E743;
	Thu, 19 Mar 2026 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773905127; cv=fail; b=DAFawzAgd2N7OvC8VlEKEpN5kRG7QJG8U6x1TUKhaQIIkIYoofBuIXkZ5RUMiCDR3SXj02EfF3G67jaQsb+7gydVnLquQL7H/yqGhwQm8mPE3RBVqATIyVEpL1q+YFLrL6eMpBIm0TxKUjvnlCqGWR3IisLBsP/HrR4AMCUrkIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773905127; c=relaxed/simple;
	bh=1JIjsZndMRmXl4e5EmfVbJ5Bw40WtC/oJ1oJPUc9dsU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sdCKMWERqpVLGR/WqJdXPGgQSWCiStHBCLJ1wO26Wcx4AsnrVCXci42eKGD8ZHe/sfFByUU9KADp5dHc2xUE/q9aaJqUtN+Q7YK6nUK9/oiA30khXtsDvi/05cSDuIM1rfgwhzLM59MmdhcWRzAh7yKz4SZ97sRTPwdYOu0rfKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FeGMmXhl; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxFYUjrAItUAj5oM0kmekYwSAbM9EbBMRzatv7hXGcldpnerW/XOEUkdE/ftjBanjeYl/uo65R21QeMP90DoiZmQCi9MNWnt0f/dxXbXkBVpz6X1cJRe6CQI2IEMj2ZAIl3GFtI8TxEDlIR4uVUbbvtpVit0iytX7Ao1G30ZbjnvmEA8l4fiQciCyhx8bb0kkqBmiKLCmC/atCxZFKluDrtIL2kRzzpv9QSfScr4DtlKw3E+AjjoA5KP8CGT0+Q4VSikK/ZM9pgJSjFpZBCjA2Oxp8ASecAXeBVR6rhS5cYwUrDoqog2XDtpAeQ3p8kCj7Lh1Gq3WwhU0JfvUiAHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwWJWfII/HfUsn8WD5Qcd/rnYYVaml+vlEubIgQ/hGk=;
 b=qBAvbdK/kXaSQ/bQI7pfRDQvFevVcEq+xKzoGq6sKVDAOpHCKvjaqwnpZ4FFDV84MXxA65N7DmIBmm1ASUqx148Zdxh6BC6bImWGEO8c1Tb4CbnDb6GoY1h27zuMXUpJzrc4AAmQrgbQ8qxB2SKdMntyJQSNm82vZgjiTY1+MXJYgyu9z2+1jRUJDFm2oY/TsY0K+TRJbeOh3RGL3TN6JcRdyhT77BONlm3NPBtlyVkHE/qPHEN4lz40Fzrqh46zzb8udlq5LlqWYL1EvzXDbteo8pOMpR+Lq03ftLg60hMK5VTKahF9npZXsP4BqXIKC/+PXLBb0jfrtIfyND3B7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwWJWfII/HfUsn8WD5Qcd/rnYYVaml+vlEubIgQ/hGk=;
 b=FeGMmXhlymEdZKeQDD/ht2VAwnIR3pjAsCdi2hSXf4u+kOk4pffJ5yG+SHeiVAPYMdQlQi+WZn5VFnERHAQi0Sc0j9CjfCj5cJ0wBEQpatfOPyenoADe2bLm7zq1rCBF1EaOb+p924t+Myvo8vG3WEMbTS6F9BCpcio+L01aCudbUNSsC7T/UrJTU1O8Z7FMkJspch7Wu2LRIl7YGU0XxgRETGRNEDEIgNOxBTRleI34u28UlWZj4t2C/WldxvfZdQT+Zl7ryJY78EqwXs6eMWTcZUEZ7vdk2dAAz7MlFWcyfqsyM0NxMZ/68QX1JbpuzsmHl1xsNWQqJgY9xLMBXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DUZPR04MB10064.eurprd04.prod.outlook.com (2603:10a6:10:4d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 07:25:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 07:25:16 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net] net: enetc: fix the output issue of 'ethtool --show-ring'
Date: Thu, 19 Mar 2026 15:27:16 +0800
Message-Id: <20260319072716.511992-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::9) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DUZPR04MB10064:EE_
X-MS-Office365-Filtering-Correlation-Id: d6107420-0caa-49a2-f689-08de8588aad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|1800799024|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	FnQLPKdaeqNV/wJrYx4dvU+Gdl+33lOI5p6DJTW0C3fG6fW30UmEMGDZfwOeO1t5C3pSIa1SdgybXxhLnox47wATub4ek5cnuTKvAUB+fLZ81JIvyNEqa72TMIqguqXMDKg5IKNPwUuZSBR0FLuFgpPuDAYQshVeeKOnhP8RpRdJbqpNp8o44TRsyPXrvwUwe/6sDXRluT5gyUpOaLPH56TxLssbN3D3RJ2u1m1Yiby7xV07SOY5whUDsEkMeDYo12c8JH4J5VARV3WPSFnPB/oQbzPhiFKRATqXBEw66VNJmHnzYAaV0iT03lNZbucae3uYaFkjfnpEYbmhR5tiPiZUcV3zA1ehil1Zwiz1aDCexxwJRMltClURzuems7NbuUaQ7dDK/BBE5OccZAFAmLu8MHFeAHcVpTcb6N3Wez2ovd/75Olj2QVxkspjIkg6XBDlzg3hoeS5bwes3WndHeEZtwG7NKDc97r6sfEhoIZ3v0D89ijGbMhiu96+jInu2JPLcWMHXVn9T8uwDxpflW5zChKiWa4HOwPcJx1LqnSKMSOlWzgT0fq876Ma1HBIOkBKHqKMjAiBgRk8Xu10IT2SpGaL5tIk/LR3ePE2G3l3jwmsUAcGpG6a9QTZQpLDpAUVw+CGV8i3KfUw9j9lL6p2vFnzTR+/oZffPy4HvcGch+GQC9Pe0kqZthHlkQcdGzj5J4hTr0VehvRO9FynKiHkFcQuWyyqx298WuD1SQ2LOWJOjcnG73Ls2qxLnNCC5F8JmBv+y+QQsKNng77RPy/KeTOOz3/wME0FMLtCDnI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oufV8tLMUS29B0wGghx6XJfKbxrezrqU6qsQhmhktx+GrMMdfdxUzhnXL9iV?=
 =?us-ascii?Q?eUOYZ0cAC0NH/6ozDNBTWLM3AKFRcBzHFwNt0+XsL8NaUmVVscyTeV/y5xc9?=
 =?us-ascii?Q?28H2RkufJ62IJTJ8p9AorHaJTeSqatLqtVczEV47CWuL5gzC455WgqpOY7R9?=
 =?us-ascii?Q?UPREn9VdLDikDifKThBaSC9FLECUkSI+7ACE4EQOy+iNYBhd7zlBTMJk9BGi?=
 =?us-ascii?Q?Mpa8347qyp6Y7HUXC+GvTw7IYGSzCjDEwk2eWwTiMbcRYzklwyZWMzuXHIl6?=
 =?us-ascii?Q?WOfbCDDSv2lFcoZLFVD14dOCXwdvyNioj3qI97XyYI7vmVIemapNqciMkTNB?=
 =?us-ascii?Q?HmLB5bl/O58YerDGsuIx7KG3BqcwKrflKk163Vbi5RlIhC6DdLvS5u7E0mnU?=
 =?us-ascii?Q?2zOZTdi81fnrAWGOylWALDCOTdVSgtkCRSl+D5k7SwK1xxxoIeCuntFL0I+a?=
 =?us-ascii?Q?Xe5IRxeUmYC/ZEk6q+ZyogMLqKk/O7zqaDyxJjJcJ9sPHK8UTclBt4Xv1Rz6?=
 =?us-ascii?Q?JxlAnHFai7PPGP0Bzqlx010AcDxzAzwbShy0K5HHbDigfA29D3roQQ5K0oM2?=
 =?us-ascii?Q?QWvcYzuioF56xiItltVD/j+Fl1Bq9XbCH+RyN8qtU2nDPLZ7XqaxKY1dZVXG?=
 =?us-ascii?Q?LAUvAc8m0ok/MfFfk/ty5ixZgeILv+quhaWl4Lv61GMzIGVmjnLI4mv3KIG5?=
 =?us-ascii?Q?G1zX0C9gJ8N1k9e2OquCJOu4i4P09FVN9Gu2yb6EImgy6tOlGMW6dGrEYggH?=
 =?us-ascii?Q?qkfD5njoz2zTGhlFJ2E/y+2rlb5e0TSOoCDDB6wBEugDXPM3RiqhxN0tbRfJ?=
 =?us-ascii?Q?qr79oOBalQeeN/QuMG9b5VXN8vQyMejNJV/dmRFRN3FD7UXOtv4cNTLzYFdB?=
 =?us-ascii?Q?aCv1s0Zp4xLvOLGOo3BPF6mPY4CuRNo8aURqN4DsNZ2aJmSV36A5G6DTOKB9?=
 =?us-ascii?Q?6RFzin+YgWQah1GXnrlRebquy2C4op94wXfmiaPWAZT69quPKhAOxTDBS94m?=
 =?us-ascii?Q?rWWN9j8T5B2JGgCFePiVLGTcCiq2sMLrIT1feFWz/ecrLawc50ol2zvsyk2m?=
 =?us-ascii?Q?saYzhsummV51u+e2iBatrLxtNNw9AXt7CfJJty/M6XYo3jyghNxKD62yDxGj?=
 =?us-ascii?Q?D7aaWaUlk+wIY3JqKznSr0PCJ6ahlHSLXgcSHTt5poXs2SWNKABH86Zp5HAw?=
 =?us-ascii?Q?tDkdLONhUIItnthD6XUVHhN1C/p+wf3gprmEebDbSAV65UEsSsaqq6ktWPij?=
 =?us-ascii?Q?IDKQIU4C8RIphN3Agao75K9wqp5cj5aYyvUJlqAxguUngkQw+ErZxUKjDEo+?=
 =?us-ascii?Q?VkjPvpjcDIqtX/o2Kx50aven7t95dfKvPsoqka4HTVNGVuBLa0AQ8+W1I4bc?=
 =?us-ascii?Q?KH6aY+XhcktOpySak0SmIpNlsobVdsxOTyDAM6QLjNuOT9wdnVipphPZ9zGB?=
 =?us-ascii?Q?sLxY6oKdmGDTenWxqUZtQPO3kNtrrIXAOqJtliimBuAY0gCWwl++cNsANXy7?=
 =?us-ascii?Q?JI/2zGtVQ9mD3425sNKGyJxf3vjdNLhinDQWpnIrQMakuwZdg+q9/H8JSFwE?=
 =?us-ascii?Q?Z/TWlJ54cf/ai2d37GR16CSHHDZ5ro9aU3S7cRnRgJqn5L4C/SrI9eDbkKGs?=
 =?us-ascii?Q?OQxIbV1bEJ5RsZ7NA0KLVSi7Tqy4bLdk/RZA9r/fD1nRspMFgZcf5lM/7GMw?=
 =?us-ascii?Q?5zqq7PpcGOePkzacyMFiFMhqJShUkb6lZFJAlxl4D4uS7j75?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6107420-0caa-49a2-f689-08de8588aad1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:25:16.4150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dcNDUXyISB46ObmlW+//Oqr69w0UThrTkPWU1U4Vl1hC9h4aqw7UaZa/pdjqzkxQwejszgWlufatVXS2bmLgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10064
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269329-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.969];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: CBD832C7432
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, enetc_get_ringparam() only provides rx_pending and tx_pending,
but 'ethtool --show-ring' no longer displays these fields. Because the
ringparam retrieval path has moved to the new netlink interface, where
rings_fill_reply() emits rx_pending/tx_pending only if the corresponding
rx_max_pending/tx_max_pending values are non-zero. So rx_max_pending and
tx_max_pending to are added to enetc_get_ringparam() to fix the issue.

Fixes: e4a1717b677c ("ethtool: provide ring sizes with RINGS_GET request")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index fed89d4f1e1d..0818a6e8e6db 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -813,6 +813,8 @@ static void enetc_get_ringparam(struct net_device *ndev,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
+	ring->rx_max_pending = SZ_64K;
+	ring->tx_max_pending = SZ_64K;
 	ring->rx_pending = priv->rx_bd_count;
 	ring->tx_pending = priv->tx_bd_count;
 
-- 
2.34.1


