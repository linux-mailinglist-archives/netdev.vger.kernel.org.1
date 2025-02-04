Return-Path: <netdev+bounces-162560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F4FA2738E
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0D03A7FC2
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB97E217646;
	Tue,  4 Feb 2025 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pnQzL4Mh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F214037F
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676468; cv=fail; b=T4cRr35ZoLkIetqbJOdi05eWjn5y/vb63FAsGEjCfKJu9LSox+DR1UzU2GiV1MFM+0nHBmcHIqSCLqQVs7fivucviZp+M1gvdTbVWSKhPO2HM+UXuh+pliyUBc0h+zbDrPU+mfjlc2uNJi1ejaTI8WolUgj7ghZveoJMzqZ+jzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676468; c=relaxed/simple;
	bh=vsRo+Z1XitNlYDclhx+v75Vz03TetQjnchs5IY8Svb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efUScPZ5XJsOK7bYWXxoiq3DRfHqa3FkiyMufpTQu73rwLgQvwvgDArY2kUzE6q7c1968MTF11D90g58FGvL91Ed0zHknQCobC7F7QzEb9EPb/4g8LAgh+nTuZrjT18OkEi35Z+GczTjKmARhnFYGOUrg+XUxXOknfjHBjZ8lSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pnQzL4Mh; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPnaxqWNr19Lcj1cHeoOipDokfYMSi+rRYX72rIpJGH85yfRv4/atVeUUJREaIcX+AjPPJJmPyY/prlv+4Nd8wHCSi+l9nglCnSgUtO0i4b11lSlRcQU22Ocfh892qTjpQQ7zDvmzZ3IM2jSUDEs4+NId5l7EUyPx2dfeduV5E4Cs6O0lAf1O3JZEEh50Dr7HQxkFb46+klwK23kqr75EU90sguaikSPGB8IPnL3AaYmKdvraWsvIYRf7oaTtdO+l2pXTsxp36eLD9K3rHTFYSBMqoFpL2oX2+WKiv6LHvW7uGYTTaqFAIW7spWHSGRMbj421HsoEQUhmUEQLWZ3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qk9ZBXs6e1APGRRmxpRsTHmUYslKDWpIIp1+TKR/WoQ=;
 b=BzG2TV7m7/CXQ4vPYcFRRIthfnB2aU4ADq+fcJ8M3GFs+/87V0GIX0CTTFe8H2fjzGjfV5gOrlycG+2Ga+SLSoxS/duvpp3upq/KJ8UMZxhsd50BBzE1twVXNcZ/eCGFakMeyqL9StQ0A0gos+J8PLY4BxWT0notbNCfW5pOWwwL5ZmfsQppveZCVaRx31VQY4wQbdq/B8u9fKH+uAxnjRRCM/28f83m3tPMTQev55NAQlFnGjeIMfyh2kLpYw5TTKfgKKlAlJ/YMlz1pyTocqzkB6bJS50h7yhj4FgcFOJyzdghiGcA7FwrM/o/OEF085WQfjdZ7pHlzAU3C3A23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qk9ZBXs6e1APGRRmxpRsTHmUYslKDWpIIp1+TKR/WoQ=;
 b=pnQzL4MhSJvV9uVdPrDqs68VFkGe6lD0HODp/6i3rNBk27HWaGqpCDhOy7F5VXpwk0996wnrY84eN3ysm127MbmGQDMJL0utkyumDkErbGG1A28JjBoPtFRruxXKoV8zgAgXuK8UZjx3wA1ilGDdyCK7zsbX9nI+gqThUCfliiOlr8Dx0s/IVgvL88lrngvly0ziHv0luR7qOh6b8eQLFcolvkeWZMKOgD2M27NK1uPgyq+q89ApOvFuPnXmlMV0QdN6bX776mq80VJ1g2hjAvC50dJt2dzmgMgppM/DjD/RstrB/R5m0SeWWSfaCCqeOTxzqnOMy0mY78ALwMUSSw==
Received: from SA1P222CA0056.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::8)
 by PH8PR12MB6915.namprd12.prod.outlook.com (2603:10b6:510:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Tue, 4 Feb
 2025 13:41:02 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::4d) by SA1P222CA0056.outlook.office365.com
 (2603:10b6:806:2c1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Tue,
 4 Feb 2025 13:41:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 13:41:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 05:40:45 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Feb 2025 05:40:43 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v3 14/16] ethtool: Enable JSON output support for SFF8079 and SFF8472 modules
Date: Tue, 4 Feb 2025 15:39:55 +0200
Message-ID: <20250204133957.1140677-15-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250204133957.1140677-1-danieller@nvidia.com>
References: <20250204133957.1140677-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|PH8PR12MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d2b6d5-c8f7-4d24-4a4f-08dd45219122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qx+tBDkkhZAo4GKoXNRnl6voZ3nH/eSWHDNV097SB9msMa2u2VQ6kjhfm0eM?=
 =?us-ascii?Q?6j+H7fhr1R/vI1cDSNSSvOEGfyhURR0bmErHL+d/o810ZAeSdysf4vb5dv3b?=
 =?us-ascii?Q?2UZg3cNea960k/imoL2fcdpZ5x/58DRQFZGfNhd0zeOyjQN3iDueKtH1/SKT?=
 =?us-ascii?Q?thoyGoC1yh2EQX+1KsCxwgqvgGhDJmySdcHi7kHeR1nuELwFiVJw9HReL2Bl?=
 =?us-ascii?Q?TIYpMqrfKoL2Bz7Lomdr1dAQy1DhhNz6EEnz1V/ooKUKEuFxOq0hdNvFOVrZ?=
 =?us-ascii?Q?5JGcjxBINMRH/NXt2+mAgnRtQS6uxj0ITySolhusHeGXj9ZA7KUBrKiuRK7W?=
 =?us-ascii?Q?cEs2ygHgRmEVbnsiINK3C7FamNKERxsxJvFrGYf/2ubbz9NcZswO0AKzG6DC?=
 =?us-ascii?Q?DWWh8dpF9YxOl8f8x4fBfiy39Wv1KgrFn3llKiJFXbKht7iXlnEnotHCbbE0?=
 =?us-ascii?Q?6+PzMjA3hVexxqYCSmxFQD5OGr58UYZ1F8eO00A857Bd0ziHEckEz8X1Geeq?=
 =?us-ascii?Q?sBggDXSlvaFNLRLSv+n9pnEGd0k03KbAZv+VKAyTmKPD3bduBc2fTNYKFi2t?=
 =?us-ascii?Q?ajl68DEVarg37rwHFzfy1Xu/tdpYQSKgyttorOxLZ/BkcdEcz9iP/ffrHYx4?=
 =?us-ascii?Q?C976ita/9mwuuWoaJoJrBNLDHYORK5jNQBltx447KGyjGKJ39crz6phopBP3?=
 =?us-ascii?Q?KM2l7mpH4idIvjrxctSk5HG63sfyXnavVPhlVYhExNWc1ZSUwUXdow1nK7Zf?=
 =?us-ascii?Q?XAqrf7z4i+WsXeHRLYTLdfpaqli3FRoA+Q7bSggvI3UyGkCefcxmcBjUFGT7?=
 =?us-ascii?Q?gRJNGh/S4yDp4TQs0ODVJL/WJSV9MoyDcfM6LlHkf51cm5ph4+tJZwH1vsSd?=
 =?us-ascii?Q?lwCwZ+ye0S0o/njal3fmAjGPoMHqiNwM9v9yttLSpwIfVNJ4VKSgFlqHcIPA?=
 =?us-ascii?Q?8q7JIMsa8IM3N9srIYOhWcnIiK8UB5GFKYetcOe+32Q5KIh7QGAZWib4defF?=
 =?us-ascii?Q?dw54zJcLVItBPyaydYetY6IsuSfQzckcs+xqT/sfnU/2Ui+hVl1iod9ps6SL?=
 =?us-ascii?Q?6G/+XOr9dZ0MMOCnPnxn47ObnC5EFpaylC+enTzFNLZ+SvMy8L/SPJ5GSWzc?=
 =?us-ascii?Q?6xqEDSzcyKsFgdbYxQ5nersBdKqXVuzIqt8YGukNsXb/r8iEeqOkKYHm49Sy?=
 =?us-ascii?Q?MX8QQaXRbxsgW3ezQYSf2vQup+XMybj0bX0ehiGBf62WPwWe98Ko8s+TmiMO?=
 =?us-ascii?Q?av49pPJdXFV4bVaL3xMVSbOON5LhNwtez/WXrSc/AqDLLIl+LhOpQvMGIiXM?=
 =?us-ascii?Q?kYWvubyuHi33ycZmOOWjWVe8lhJYhzj4x+Yn4TSE+P/Dq8wBOOwu2DZXD3kH?=
 =?us-ascii?Q?JeEjSYVaRhC/sYmA7k3EpqhwTUuiJ7gM/KkfwVpJTSv/xeaQp8DD3uwmvKN1?=
 =?us-ascii?Q?Y9O5ITL7vT1oH1oeH82clKQCWDsxAbhi7Jt9FzQfnBX0Nnlmh7EVcjFPi/N7?=
 =?us-ascii?Q?VjZZ93+CpJ1oGVA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:41:02.6253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d2b6d5-c8f7-4d24-4a4f-08dd45219122
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6915

 A sample output:

$ ethtool --json -m swp1
[ {
        "identifier": 3,
        "identifier_description": "SFP",
        "extended_identifier": 4,
        "extended_identifier_description": "GBIC/SFP defined by 2-wire
interface ID",
        "connector": 33,
        "connector_description": "Copper pigtail",
        "transceiver_codes": [ 1,0,0,4,0,4,128,213,0 ],
        "transceiver_type": "FC: 100 MBytes/sec",
        "encoding": 0,
        "encoding_description": "unspecified",
        "br_nominal": 10300,
        "rate_identifier": 0,
        "rate_identifier_description": "unspecified",
        "length_(smf)": 0,
        "length_(om2)": 0,
        "length_(om1)": 0,
        "length_(copper_or_active_cable)": 2,
        "length_(om3)": 0,
        "passive_cu_cmplnce.": 1,
        "passive_cu_cmplnce._description": "SFF-8431 appendix E
[SFF-8472 rev10.4 only]",
        "vendor_name": "Mellanox",
        "vendor_oui": [ 0,2,201 ],
        "vendor_pn": "MC2309130-002",
        "vendor_rev": "A2",
        "option_values": [ 0,0 ],
        "br_margin_max": 0,
        "br_margin_min": 0,
        "vendor_sn": "MT1146VS00060",
        "date_code": "111110"
} ]

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---

Notes:
    v3:
    	* Enable JSON output support for SFF8079.
    	* Reword commit message.

 ethtool.c | 4 ++++
 sfpid.c   | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/ethtool.c b/ethtool.c
index 0b876e8..8a81001 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -5007,6 +5007,8 @@ static int do_getmodule(struct cmd_context *ctx)
 		    (eeprom->len != modinfo.eeprom_len)) {
 			geeprom_dump_hex = 1;
 		} else if (!geeprom_dump_hex) {
+			new_json_obj(ctx->json);
+			open_json_object(NULL);
 			switch (modinfo.type) {
 #ifdef ETHTOOL_ENABLE_PRETTY_DUMP
 			case ETH_MODULE_SFF_8079:
@@ -5026,6 +5028,8 @@ static int do_getmodule(struct cmd_context *ctx)
 				geeprom_dump_hex = 1;
 				break;
 			}
+			close_json_object();
+			delete_json_obj();
 		}
 		if (geeprom_dump_hex)
 			dump_hex(stdout, eeprom->data,
diff --git a/sfpid.c b/sfpid.c
index 0ccf9ad..62acb4f 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -517,7 +517,11 @@ int sff8079_show_all_nl(struct cmd_context *ctx)
 	if (ret)
 		goto out;
 
+	new_json_obj(ctx->json);
+	open_json_object(NULL);
 	sff8079_show_all_common(buf);
+	close_json_object();
+	delete_json_obj();
 
 	/* Finish if A2h page is not present */
 	if (!(buf[92] & (1 << 6)))
-- 
2.47.0


