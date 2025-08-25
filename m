Return-Path: <netdev+bounces-216380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D64B3355F
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3DC48410F
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175CB28A1CC;
	Mon, 25 Aug 2025 04:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XxtMDPIT"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A91A2101AE;
	Mon, 25 Aug 2025 04:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096687; cv=fail; b=dL58q0A/McJn7N1wioIeOE2acy3Clb3qel7mJunziOt4zqv3YO2J8CqRo9hz7HIwvwO0/T666PBjNoq1xK/s5ZL14qmTsoKVvNu1RfYfQYNZ183IAnNOhgJ1on85JSjUfMMZbakRpvMy7hv9whjK4IWvrJQyCndxk4d4BnjZ3tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096687; c=relaxed/simple;
	bh=cYS0HXE3B4wJQStICvzXd5lCHjpfNL+pjnnjmMYPBQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hxzBVHhMkBr3p1G8JgUsIOWcggpxmQW1IAqrQ+OWDMeDNok0Ritb4XaIFylbCX7IXG9W93Dv72ORyy232TpnyBGZvogz7AaZmO17wmY+cRww29TRcJ6DYuN8cd0J5XBagRUboCsDO/svNOCNoBoBQ4WIJ4jVWe4rBKttHMBwiFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XxtMDPIT; arc=fail smtp.client-ip=52.101.69.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5WQ9j/nzg2FTKgUi6wZS4EYiVVWkrTakajRvyz1xcKs5Pb7Ga+/5Bj8A01sGGysdmUqraHb2x4Pr8J9PtWhyLzAm1nMfCcaDfF7xLykj/TDncGYyckhrVZQcfOh9ZRthG3DjAXNK03f9omx/5vIkuFaW2RlYK05XyEctXbi18TTWPn7HXDgfLcR9lSyaMRTIuQbzgXbLTXDzrpKjvZTDiU2Jpzi3q3ZRm87PKSc5faS0BYmXIwdPv1zJWD7jMM+MVrcfnLESPZH4gwH9T4Gsa510gVqftvGdpp6YBx4s/bTQFl7tos7GJEtr34qrQke+shmh+9T4kMKIODsPBqaFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUbNOOoRgkXrJ9IQbAo5aU7HeAXkeG4yXtSm9rmzo7I=;
 b=LXtJwell4fsdo0fPb9EWbvy0J/Uk7rfXF1XvicRUXp/0S57JPlYh1Ze3yCALmZiDlgTcYN0oX73EOpyBRYS16jsZVhsSCqHHD3pWKAd4MQ4sZO2forRnqqjLGg/FT2phxOp2Dx9rpRjKkcorZUmIj+INT+LRq9xTf1E5Qz44IqkIrS6BgUt48eiMZIIUm52DRO9ejVFPCLyaKrIvqqxcNSjH9C1eqZj4Ml3lOO8AFORfYj4NY9f5M35czgUzw9kF3ofzeemM+cdQdSEXWxCI2DWcTAEPjcW1CWuqZ6GQmEwlBbpbhR/GTFw52xC9bS/Vqk97204RJjh/DRpdY/uAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUbNOOoRgkXrJ9IQbAo5aU7HeAXkeG4yXtSm9rmzo7I=;
 b=XxtMDPIT0uERnNMPyUtzb7QE0YKQVbWfjFw7VT7nNaZArP+BzgVr5FkXvym5IyhcdSWD/PryiLXY7+Qzy/V2lEaxQahJBsAPP3TQr8OXyr2zBV1JUSYf3rzMUyttHrVrkactgWh3adDjYaLcUUSVqNsrDUm/HG/Xs7aGxGGUyHvXjmTx1w8Gd3o97+SUDkYCiNMhAx+gIejbFuwEL9L4P4IuOwIa3PVYWktLt4zKJ3pRdC1iyKszc6Jykvx/3UujAmX7lci2479cx2DNTLQx0FkP3vUkLQzoIqvPuw1w4P/TrNeVwChXOt9aSKkWxmgo4jqZuEjwodvv0h5VqvD/2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10570.eurprd04.prod.outlook.com (2603:10a6:800:27f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Mon, 25 Aug
 2025 04:38:01 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 04:38:01 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v5 15/15] arm64: dts: imx95: add standard PCI device compatible string to NETC Timer
Date: Mon, 25 Aug 2025 12:15:32 +0800
Message-Id: <20250825041532.1067315-16-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825041532.1067315-1-wei.fang@nxp.com>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI2PR04MB10570:EE_
X-MS-Office365-Filtering-Correlation-Id: 4190cb1c-8c66-44bb-b92f-08dde3912c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8WWRy3njloYUaGXlY69NCSuKiNB7qAiYXY3/dfY3lNx+8MfvQZ80fGrgwqax?=
 =?us-ascii?Q?jyEzIRirhj2HNUDkm27QtOhO2UF0zhVl5IqfxzMibhmYxes4UlegQYBcCWjG?=
 =?us-ascii?Q?rmtVw0MFfCh2hM1QSc9SlhgRohM7fqOGUQ2/tyA8qlfMykJ1iphvztQA3EVG?=
 =?us-ascii?Q?AEl4uk/GC912v+saJnoKzSqOsMlAZL/MRuSacqcb1quAH3sgRv9o/V/71pTm?=
 =?us-ascii?Q?mFRcxRJKcq0DlTnrdMI8Vw+0uWP+qi4tYHNMhnWYE+OhZUQ6XBSF+gO58YSO?=
 =?us-ascii?Q?80qEcO4gx3qJfD9+loD2jJQNOXCcBkZHEwdKoPcDyFm6We+0BIidvqLEf9o/?=
 =?us-ascii?Q?1QfmbReJe6TvFiMj7umq/aueGOnWdjot36CxYDIRaVxXTzIZ8HuvfWO+eVp4?=
 =?us-ascii?Q?zHE22NbwocPTY4JVKa4GzVi4hwhtWc4hIbekQl+FMnKB2Eo2PxWifSY91Ja7?=
 =?us-ascii?Q?XyfkipAvWUUkCAiS4gMh2mCcXXqdscMl6/38eaGrzAmi/xlZBc1v2Nu5eAY9?=
 =?us-ascii?Q?g51drBB5myd2OI0NwxrOCy31wwOaHemBRe/Bcjg9NsU7ZL1WBQ74Ckq30eqr?=
 =?us-ascii?Q?aTLWilH/BLNZidZsYjEMXer6abstWVIgAXoxUuX3xBAflgm5SQHRBnpqJjmU?=
 =?us-ascii?Q?8pXc1PT3jktzVlWP23WFICUlRgE/zd4aVma8dN8vg8RFsltAoFNfWXduxPXG?=
 =?us-ascii?Q?k6fZsTbtHLQ2AENgKOIb4fey8qb4oUb8ji5TU30PKdvjSxce/Ggtb7qixcRf?=
 =?us-ascii?Q?repk199Xl+bKfbxXSjs9sHq3YxMXRNUdAqNKb4XIsqgkIX/jyJ4BF33NDYQQ?=
 =?us-ascii?Q?PFImbYVFQEEO7BNPHWfvH/cckkJ6kLhOsXo171jEm3XpteoV1s7i3QLI+f3V?=
 =?us-ascii?Q?1FE/pJWZKrLDB0AcsgriJYixA/n1EWKomy5O6dRMH5XrUJjTPskQ1PrSN1Q2?=
 =?us-ascii?Q?MsGbT/+9KeWNyvwbCZXrbSkP+XOzSYw6THVmJd8lYkzE+RwzvfnW7YDkulPi?=
 =?us-ascii?Q?oAuhOa4i11+68Fg70MeaJoeU1hhn/jdaS3Sis/mK+IfEFpFb+2fpBUhEfBUK?=
 =?us-ascii?Q?mTrz5J3XU3VyzuzeH8i7XJKgGeBj8jdBY4lttgQbtAxh33z8pkpXQ+QRFYtS?=
 =?us-ascii?Q?ZPvxbsdkpCcy719LikrA9xsrORROdgOhn6zCAI/ca1j0wQbUScp1K14f051w?=
 =?us-ascii?Q?EU5S6pn74KL9rJnHoink/bkyQD6VVdyPtpW46ltSaMHJI9NllewuTQL1pE0j?=
 =?us-ascii?Q?WI3YE27daRSsmWchvIBu4lRhF7hOCtkk+X4pJ9Su/e6HQ7CqQ2Q6UdSdp7jp?=
 =?us-ascii?Q?/TnrH7jtNOi/S0dmr6m8yiuuvvNswfsOcn3KwMhY63Ugx75AbPj4zYM3dk7c?=
 =?us-ascii?Q?6nLlW2Nl9DMxgSZqnBEjRVNZ1ypWW3VTzEVjsOvF67PACM42nrH4nJyQnfne?=
 =?us-ascii?Q?MLhMLtjTqpPXlA6XZUyl24s7TsxPd8Wbhsj9kXt3iCs4x/rg9na8w1U9mnnR?=
 =?us-ascii?Q?vCaWuTPXqMJ0HN0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rKv624zLrH5fxEf6nFOCMMKPmQ0jjMd/YGxk6DuAC5vQ2b99vqh8sKygvRbL?=
 =?us-ascii?Q?+12XnUA42mZ5tTJsSd0RSvpa6L9WN43EpMsaGHyonCMGJ0ch/CNYmfRWfDS7?=
 =?us-ascii?Q?Byntfa00o8O7zunh4dLquCEwFe4EizlVkf4STGu3nA3PZu954+R3uE6/nIy4?=
 =?us-ascii?Q?0MJLDDLyvWFJjLV3Udz6jJ+uViB4ntE3vdCFgQK7TwTJCILk9FfjLBkvAEOw?=
 =?us-ascii?Q?yWC/XUrBEHFkniKSkfhKWuS9KFBzPZM1gopQ1ZJN0Z2EXj6GVce4/ZZEDsaW?=
 =?us-ascii?Q?q11cc6UHVVtAcedBIRQZkVQclIRZ72TdPLz1tv47sZ9Yao0pDD6oQ9IyEXd0?=
 =?us-ascii?Q?6PRaWIh3GcL2A0PsDN60pdLUCjL5FEhDc4MBKc1DcE2MZ3+/sOVUYCaewZWL?=
 =?us-ascii?Q?WhqjOxCoP5xJE0TMzrFy64dRJS+sxghXrpRb4JYxs0Pc8Qn834tOuGsIqvAC?=
 =?us-ascii?Q?C9/T6hHu0INlIRa0PV/vQkGJ3fDorKonJm/7bgaU7SVVunAJx4R/GxHEu8Pz?=
 =?us-ascii?Q?BWKOiqnOOOGA2awU694lbbKNnPGN9EF6IHdWEJ0Q70Z0mbbwcdDqRchlPtUa?=
 =?us-ascii?Q?A/DAK+0AtrvAYx8tqMqD+BQFbk7bTbSqYzDBi4q7P8hrcjgOMdR02ShIwgtl?=
 =?us-ascii?Q?e+0vyEZPmSGlFCbw6asvH2/DYF7GL/5MWZ18k6O67ItIl2DyTKJARO76DbCm?=
 =?us-ascii?Q?6BX7iB065g1wdBC+ARXLgZlNJU5i0IAufU15uWDewpoeSCJV7Vhl5z7Za636?=
 =?us-ascii?Q?fw+Tu4Op7LMktQdcxlinYyxPulieUxp7cztQ60m2iJz+UlOZsUuIBEbDiXC/?=
 =?us-ascii?Q?FrkYE5qGijcWI6D7GmfP63ov6FxE7h3iJK+5kmRWeSrPRbqFFk6JscE2R9MV?=
 =?us-ascii?Q?ax81DNE0E4hZk1+C1C3MVX0vy3U9FQGnjxUfwKKQQJgTG8y/0MPr7T+esnMO?=
 =?us-ascii?Q?dQBBOa017dXgQOEmIZGFbSeb9aC8zOKmCDQ+LDbPGmicfYFSoSGFF2M4bXaH?=
 =?us-ascii?Q?PTIup68CqOsn80DoMhPRZTEI0tWhwUq61Gm6TN1hBCmmzgkvpAhhQiSU9sX3?=
 =?us-ascii?Q?BaHbBHoZ87mGNSSJhzYQIJRqowMC4nHlsKDWUWOQnvcCvVVqW0O6qCpRZrd3?=
 =?us-ascii?Q?4CqMjY/CBWlLkr0k3wY3GlQbMtgPFVDopfMIsheq6VhXs0oEFcXwZRxGFBgm?=
 =?us-ascii?Q?IX24IBWUvq76xRFCCN83bK8WUF+mNvUoUNpM8V0RYo19ciJYBWUYr7a7/bdZ?=
 =?us-ascii?Q?lSatZx2DSiKqcPffqgvZGdDda03kkRDl3EFGgz/5fRvDuJsONqF18ZbQp3W/?=
 =?us-ascii?Q?xgxCR2plqOhS4ORYLkTVZZBSK0M6jcQaePTrc1mpGTGEaKqBoLY7/ztFIKg3?=
 =?us-ascii?Q?80NClsSztf5MjLy+obCDfqvRatpq5GkZhEw4b9fO1JpGjjYQUrSMX6opS4XE?=
 =?us-ascii?Q?rnvmUI+zy8dfnxHHoPNvkHRItF93o3Jbm6ov3eSsigTiD5+c0MA2pIMt++bi?=
 =?us-ascii?Q?q0lDBYl0ONqN2IxzmxtjB5GwA3zDegw0KgePl4+D7Lrqg0EN7rcIdxuGRhRH?=
 =?us-ascii?Q?BK0tEHGXRjn8eNnmHkJCujmi2ThSImDESJQ6Mv7a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4190cb1c-8c66-44bb-b92f-08dde3912c3f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 04:38:01.5257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNig+OdADbuzlthE2Xc5xcCfWbfOGBFnLqIheCjIL/KB5x9WBCt+aoM824fcRuZmwp3Ot1CAtL3ANf3bB2+g3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10570

PCI devices should have a compatible string based on the vendor and
device IDs. So add this compatible string to NETC Timer.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v2 changes:
new patch
v3 changes:
Since the commit 02b7adb791e1 ("arm64: dts: imx95-19x19-evk: add adc0
flexcan[1,2] i2c[2,3] uart5 spi3 and tpm3") has enabled NETC Timer, so
rebase this patch and change the title and commit message.
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 4ca6a7ea586e..605f14d8fa25 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1948,6 +1948,7 @@ enetc_port2: ethernet@10,0 {
 				};
 
 				netc_timer: ethernet@18,0 {
+					compatible = "pci1131,ee02";
 					reg = <0x00c000 0 0 0 0>;
 					status = "disabled";
 				};
-- 
2.34.1


