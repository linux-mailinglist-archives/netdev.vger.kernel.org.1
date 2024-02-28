Return-Path: <netdev+bounces-75575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3DB86A947
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 08:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8F728A14B
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 07:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4DE2562A;
	Wed, 28 Feb 2024 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="HLOGqNZf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2117.outbound.protection.outlook.com [40.107.96.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA3525573
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106747; cv=fail; b=MVZpx2dkZVU1A1dZpJVABgN8vIjHwG3OIZoE9/8bqkJWdx5PBcH4nhFNZN2+0qqS7ZgOfPTGAzd14Y/dAyuA/aLehDqwrqdeOxuCn1+c1MoZ7/e8GYzYz8idC2xX/N6u88s+g2OgCWXJvUvIpmKrf7XMeUSUsSxzQFJV5BCsFW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106747; c=relaxed/simple;
	bh=GXzJx/W8rhopCs+xYZcrJB8ahZD18igWj/oNei+C9UI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LjmXH+wLKRx9sQdiTIc9UEbtoKL8FsZkq6rgqCN8tEQ9M/v7rzQH1K9tMhWUiLcXOpCrU3tHY5zTVVLSWv94Re/OOQGdPCbzm37o9DCrfhNEmcKflQmGlydQHS3CM4gmfA+wH9DA6zIahxeSGsIFJZ13zPt5FuLVvFNlVKS7Ipg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=HLOGqNZf; arc=fail smtp.client-ip=40.107.96.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgDsmLR5kXnNr2haT9dUVpXf2E3dmh1btsisXqVtUniJeO6m2YegPtzdC4z4FygSbgvIiZMJCMaOLnYiGtC7jhf3xaKdvEU8W56Sap3u4xuHM/P2BSbzf8ky/OXeOpNhnmA9/07IKWqxj4rjvF6Env5URjRSQqqz9UeBBbOfMvQIO1cy1PUjDy+Qzle/Xdcmrl5NY/bs5E3IiBIa1ehnLxyxeXlFTU4/FfaDIO1qmrwbTmxOyRIRfo/UyN+PzCrtbKtHnqax8DVF+BRBUOOE+YCfaNkAok8/jCrDMLu02CRTwWxNcpA2WBis91ASB49kUld8zWKOylx2OIHXZidmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMyE5GkEpinggf1t0nHgqvwald8nv8Rilz7Nh43Pe+A=;
 b=CymeM8yXrp+5nNoBq3LZ1fcNiS/CMU60rSMNVBYtb+xtuv6s9LhB+p61PAW+827qg/sIZ0/yQo4KOXC1E9TNdQYpiPEExxlENqJEm/VJf6NF6jMKZFgjtPEqTJwQ4/RhDcd0eZgIWf4i4YDs4hnKHmLfphUDlAgYp3SDHO2ozDU5bjHYPLsB6FG9gf4kr3R1KB3FO1ksl3tCR6ZkN9nx7mDeINKDFWNYYGTfFKuZo5uL4+mWZakogZh9NEARbXblS3fOp5aCRcU4/GHK+7f6ws26ijg7bdDHKr4CG3XEKiQE59bGkcXSiJ18dF7goz+jqXpFl9OMLM6GURNBxTazlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMyE5GkEpinggf1t0nHgqvwald8nv8Rilz7Nh43Pe+A=;
 b=HLOGqNZfyFAgzZY0Vijp0Q5Yb5vH48UDgR85TIFpcCCYk+nvtmmm75grM53N+wRfIq2iYoNxi7o+xkLUPM65JTPQpm106xAbXcrJAgm1pMXZEUIfkn8dJFZMJSbCmhOtpDGVTAloGWefKmoQFqGIYOs+VEMA2vRUSAYacdXDaaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by DM6PR13MB4496.namprd13.prod.outlook.com (2603:10b6:5:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Wed, 28 Feb
 2024 07:52:23 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::c57e:f9a:48ad:4ceb]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::c57e:f9a:48ad:4ceb%6]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 07:52:23 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 2/4] nfp: update devlink device info output
Date: Wed, 28 Feb 2024 09:51:38 +0200
Message-Id: <20240228075140.12085-3-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228075140.12085-1-louis.peens@corigine.com>
References: <20240228075140.12085-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN2P275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::27)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|DM6PR13MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 0450153c-646a-4b67-47e3-08dc383232d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vQHoN2uAfnqFRm5PsP/e7fkemwCWV5yuVcSPBDNtnfT+Zuta0tdbhgzin/xO3g6LyXtij1CNrRflRwKaEOb452rMtJ5tqghYxx/Dg77Fl/4TyzrqMt7n1SPoPlG99zvdAJxHMyKXRdZN8iaFftGbMbTlg4mx5h7jP/ouUMRF0xBke4/N1d+OeV2UpD3dwUAA6IuZZ5vZal+0yzrhos31M2WkfZmJ42M6niZ+MOvaDtqPTfgfgUKAfE05UnpS6Qv+AYrDFeB4QXAKo0rB7ZTerStvDBKtA/jGOnCaPPP7B0p9ms3db/xOCFyDSSJjAPUw/m0Z7rlOXtDrxd0zngBlejcF+dCD7R6hb6Vf4wiNf6dmvoryljCgzTesAISrKK9fnWN9hUD5BOK8L23BANie+DxRilKNxeha0Dfpon09D1QEEphmnGtiJqsUAc/+L6/zI02Ux45Lu13WG3IkD8HcrdjDGmcWawkR6EmDlg5O1kg7Yi35PM5Y1+dV1sF9jMbyZtQzu16KHCcbpmLoDHKhbkTIX7SFDoIHkr7CAx8lmA3cqnedPslnqqYyPfoj+JK4GxZ9xe+VFrH2VX7EWzDDCphnQOy5pOzHkINOndqBtORB0iZieWQNcNfXssJtraJL1iuY2xHcz7hKFrYKZpUKW4Vf5wjpBG9EEG+EvSKSNTk6hODis7nj1KLk9jbgHcWrL7NRZfHgYDD/viv2qKun1fBzLzqow6wkImVRUknSYjE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cvue8KQbS9IPx72E2Mol2MDGv0IaswfBCQbOTXWR7KG6u9cwOaFuTiOPcp6i?=
 =?us-ascii?Q?XlEPsYgm7KrY63WIOfg1rf37fs2QDBVc5f0h9I8UQ933vc2uaCbZb+ITcmIG?=
 =?us-ascii?Q?5EsFklI3XYDm83EA3mzfSpy4J5GrnITCSI87XcOqscVXwnApw/y3dj5iLGBF?=
 =?us-ascii?Q?IoxTvOVAS685lhi5cUNnECLx9QV34aBEkyt/0N4S8cix1gicopQULNDrl3v7?=
 =?us-ascii?Q?sg02LuwwIz7nCzXYFsGToK4EKFMrOhqXoiBs/D+D/iHmPNT1J9ppQoyP69jX?=
 =?us-ascii?Q?fzSvjK1KJupz8HVViknrMa38C29SymH7iY3JFZkF4POnjS+2KTHtofuwnU8C?=
 =?us-ascii?Q?3HLcoLZu6E2FZ/YBUfsVRwY7WIGcp7ACTIDBA+DpLzagy5apCUew/95sZj0H?=
 =?us-ascii?Q?gbneGh0vm1TwDJ6I74+7K8t5g1oFgwHKtLA/Ne3/Z4r7PA+Wg0LjJaR9c63b?=
 =?us-ascii?Q?ynxveO57vGwpIGG9bMmN8J8Q3Rv2oVVgs2ly4SFumrZluePiRoQq4paMuV00?=
 =?us-ascii?Q?LBAlIseTQxli2jZetBJWCTJQWd3TEsMEdFdcWUyET/lnmwBq/51XxKpCOxY3?=
 =?us-ascii?Q?anlOlerdsMh+vL12iYHi06CtCN3FNOlN6FEEnP9ZvKVzPQm5QGOTTi3feJKf?=
 =?us-ascii?Q?Mz8ojLlOfYI0bvF3eafpLyDbdknxHxENT+GZRslZHqTy2Fghng3h9WcBILjl?=
 =?us-ascii?Q?BTnHSASH5JUo/qG6bNk0ME5GlgAI0Qe8+kmrbO0/oh5P6VHY3M9unpX3u1DZ?=
 =?us-ascii?Q?ByqediPsZN0VE2fw+1gTjWltCRFZHzZKD9TuUFmzwrJv2F6mpNsP2ZJ5ozG2?=
 =?us-ascii?Q?M/ULb1KNg5TvxRRq4OAI8Mx9ItFIY9DoIByaWRJvu7ELC58FMs/5p6l38M9G?=
 =?us-ascii?Q?29Yrf4xsISU1h9SG0gd3DqkA6vKm7CGH6vlsFhfh7/gZAm5PmFl6ZTUvm4e1?=
 =?us-ascii?Q?PnQn1G7ClUVeslJrX99eg6QnOPkFkiV3HHTBQIQrPvu8jffEHgGDIA7bBCjS?=
 =?us-ascii?Q?z/7FFuLewUyFt+/z1k4LqrWhfjD59tBe4nTM4dc14HJloOJ/1tHJKVfcEwjO?=
 =?us-ascii?Q?iotbudVP7zcfjcai9aCCg8DRSMqybWnyQtfemXg7IMrBysp+ASpWIrPV865d?=
 =?us-ascii?Q?oASpShfqYkIMNbjY0csx+GvWaUrKNO6Ca2r8WMZNAiByXNDYa0jGpFneRQXj?=
 =?us-ascii?Q?e+SZEIF/VI4IDKx21cuDCId0SuJuPk6xR+4aBb38eKuFlKfvPZSEK1ytscas?=
 =?us-ascii?Q?eQZTTVSFuoAFJv9mIWuN/0nDlpGcFpxQt4O2l9vKOmO7TMLufYV+k3xd3B6W?=
 =?us-ascii?Q?f7emTyIMkk4PKIfzESkRho+xn238XsYm0uHLLZcKkz6bb81z8STWId8ftI3K?=
 =?us-ascii?Q?A38UUuxMfPW1TL3qkSaxNYc28wKLPOk0Pal9bTnf4IzKXpPVN3j3J2yjbeBj?=
 =?us-ascii?Q?KyRUakkbWNWVY9EBN9Q9rp1LsLuQGwb2zmbj1cd57MPyWnrVG8p5uQbN/hSw?=
 =?us-ascii?Q?jtlUqA7JiEiHvttWaQTLvJvuqTXB7IYETG45u+DW9GbdNbbWGmZCP8V6iJrK?=
 =?us-ascii?Q?fFsNHeuVF9JPk6+gnJ9PjKjwOd8W64vXetnebca1KLDoV5MlA2sou9QvX6IO?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0450153c-646a-4b67-47e3-08dc383232d6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 07:52:23.3181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3T+nDGesv2UCZY2P6lfv4mhKzG8SsmkWqxhReYOPPOM3tAiqM/Ji5BGVBCpYCmrMehw2ub5WUspQQQSejgOiF8F6/+eWIXMcQl995vMUn/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4496

From: Fei Qin <fei.qin@corigine.com>

Newer NIC will introduce a new part number, now add it
into devlink device info.

Signed-off-by: Fei Qin <fei.qin@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 Documentation/networking/devlink/nfp.rst         | 3 +++
 drivers/net/ethernet/netronome/nfp/nfp_devlink.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/nfp.rst b/Documentation/networking/devlink/nfp.rst
index a1717db0dfcc..f79d46472012 100644
--- a/Documentation/networking/devlink/nfp.rst
+++ b/Documentation/networking/devlink/nfp.rst
@@ -42,6 +42,9 @@ The ``nfp`` driver reports the following versions
    * - ``board.model``
      - fixed
      - Model name of the board design
+   * - ``part_number``
+     - fixed
+     - Part number of the entire product
    * - ``fw.bundle_id``
      - stored, running
      - Firmware bundle id
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
index 635d33c0d6d3..5b41338d55c4 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
@@ -159,7 +159,8 @@ static const struct nfp_devlink_versions_simple {
 	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,	"assembly.partno", },
 	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_REV,	"assembly.revision", },
 	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_MANUFACTURE, "assembly.vendor", },
-	{ "board.model", /* code name */		"assembly.model", },
+	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_MODEL,	"assembly.model", },
+	{ DEVLINK_INFO_VERSION_GENERIC_PART_NUMBER,     "pn", },
 };
 
 static int
-- 
2.34.1


