Return-Path: <netdev+bounces-195884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D64AD28F1
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382E33B3FDC
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7322253B2;
	Mon,  9 Jun 2025 21:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dFqe7mCI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8622489A;
	Mon,  9 Jun 2025 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749505639; cv=fail; b=mSfNiD2OCXCh+SdlROvS1pciaa5/k4hu5E75GkRdT1IqN1JlaZpoX3Z9injx35JZ84GQ3/FaIsT4IbbKQyUVd8qfEWzgLwHfnJJfI8aFpQFcEq3RPtJRIMgLM/XDCynWOpWE/jKCtQLtpP4kT2EHh2VGQWNoTDxr9ymF5RxCVw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749505639; c=relaxed/simple;
	bh=70qWc3+slwQNwCXowy6wXNFk88pzR8J+FbB52vu4t98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WsIJY5ehL3hGRbj0a2nB/cUgP1+tIQUclHKffxJa3zuCAUI4pex8YvunOmOVj6oGh1S90RSM6mczujGCRXK4QuYkSpW9p1AYJLCaK2OL16Qr3UomvzQ+U76ETrTfP76chg0iezmyP5hyLqCjX8sReLDhbyUeaska94TpMMNlpww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dFqe7mCI; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+vALzEAHP+V8fZugQyUxkE8uICesswd76FodTfg4q1vdnhqeOqwFjg9babEHsmu5Ec0PKn1uhWJul7/BPkqF3P0li8bhBEpOd998U885ZL2s8fglZFLzZUXRmXMENPFGIj093IotDxyBPYJNO0y66jchISXFM/2DdCJWoFZeME5XO82VsYdgRONhhz9DcX4ZwiJM4rmNzd0VLBxnd6BZFvypVE2fHtW+qAKLQ7ndyk6lgr+5BQOnh9N672lp7hFivKGeK1yK5yxbJJZrDEfKLRTeay+cGeUOH1+vgNBNmvR3eeM90/KJpYgdbGz7JputNoBObvHtVbMgOSF84v+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qlTwD76eIHLxZ8juIRglXKjBAxSfWYrK+7QwCGaI7k=;
 b=atL0ONh80by3daXY8UzqxgonjWqcqPB8Tw4xHTsMS6yMshi6DMSEBa5D3PFReaM4YIWbbZs58+AjZwG4AmbLEhRpFIeVbxzMjaWHUyvKT81ry1q+kdZYVwzbmEatzsE5vDmAxpgqvyClfNO2aQtOlCiWXVZtZ9RFKRETXiw9l0+PbIFgwWLQ99LKx+tecJDYx5yT8Sgclsa/FGzIfojWxe0nPNM1p1AEIbOQp6Oc5wiw7U78F3YxyQ0llQjS8XaljN0qy07COqLCmKRc0Q/yr3HGfsemg0v3Pbzx0OLEWdtW9u5/Nc3PugP2gjX3/1SgjrGo4fSaMCnj3NPfDZSvfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qlTwD76eIHLxZ8juIRglXKjBAxSfWYrK+7QwCGaI7k=;
 b=dFqe7mCI4BphhDDEmk22b8ZoiUn1zV8pL8/S7Ja3udk0BirITiA0GVtLpYpC44o1DMe+JmZB+PB0tB0N+PYQ0GdF9QIOTZby48CkIo3ruggcy1MWhpPXP5Wil82N50vyCjCSkOFvWWruNZDGheC37cENR+eNKKfuDPoWalGl69g=
Received: from BL0PR02CA0141.namprd02.prod.outlook.com (2603:10b6:208:35::46)
 by CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 21:47:13 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:35:cafe::5b) by BL0PR02CA0141.outlook.office365.com
 (2603:10b6:208:35::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Mon,
 9 Jun 2025 21:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.2 via Frontend Transport; Mon, 9 Jun 2025 21:47:13 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 16:47:12 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 3/3] ionic: cancel delayed work earlier in remove
Date: Mon, 9 Jun 2025 14:46:44 -0700
Message-ID: <20250609214644.64851-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250609214644.64851-1-shannon.nelson@amd.com>
References: <20250609214644.64851-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|CY8PR12MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b3642ea-8b39-4fea-17cd-08dda79f31a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c1q0sJvxRaZkMhcHFWcgxIEw09Un2OtC2jd8vdbw80ICwfrNB9TbojDsdxOE?=
 =?us-ascii?Q?DOLKiN+Lv+QGjfDS0pXtxuE9Y4XensC81hUD2jTiHmexizyIKyXD3lylYpY0?=
 =?us-ascii?Q?LdLOsLX8YdHgqtTdMBAWgePDPS5MyxQWLcfhX96KmgiZPLwbvB2Sx6XjfZGm?=
 =?us-ascii?Q?h7eo3PPoew77wLuC6j3SrNCGaKhL5XtxukXd9gpF8s0Le2PMiWckgANv50N5?=
 =?us-ascii?Q?XziO+daTKj14esQ6jhrGaDOKPwii0W8bwTmWBkaJRgGZemcFIF+tD94KMa1C?=
 =?us-ascii?Q?ERXhthQNfal8AQ2RcB14WApgbCUwQFcpB5JukK1TxeCQ9jj2/alf6BRs9PLU?=
 =?us-ascii?Q?us/ehRHf2U6DF3MRLFeJDj+S7Zku83h3vcCQ0RUt2fPvJc8DIiVd4w9i5A5T?=
 =?us-ascii?Q?UCdIgniFMbOXcu4UW77+Q1ezbN0gbohblAILPer1CeU0Z9IrouDOne6x8Inz?=
 =?us-ascii?Q?5D0DPzzLc7i7VMAbKHjq9i8UB1l3SvR2pXvu6WG2U1auwF+gDuY6ISaPp+SI?=
 =?us-ascii?Q?YmnhYNkZPRzRN8jRR8NMutUpQNvGCFyEGHGSgaW1U5L4QiFptA4Mk7cXM/TS?=
 =?us-ascii?Q?hRsMe5r7S8aYwB+MccuHguq77wTwO8lKGN1hrUgsDSmCo0NwOytpSJIuSljj?=
 =?us-ascii?Q?0KvieNoUfJRkqGXbFDmCGpYlsbp4va6241O4spfJ4QvOwmW7jQml5rfJP3Mn?=
 =?us-ascii?Q?y+C90+yjXsHLoWNoKwn03mUkJSJY/KCyx992ekPSoQpooh3/cMa2GL002TX1?=
 =?us-ascii?Q?FJFMMuL/BqWPbbQNmVo9NbmiQmV2UWb9drx+4MbDVZtVbhq3VSMs4tVhbMDh?=
 =?us-ascii?Q?zjrTo7I7R0VTzZjcLgdz+BS6TAR5GwBwMr45VEuW3Wu2JbpKP+i8cH0om+1P?=
 =?us-ascii?Q?sRWjGKYguwe4kxnincyw8cwZoJ+Ow3CZJsN6NhGJzOgLd+H4ePqY2iT0zxhb?=
 =?us-ascii?Q?t+Olxa3B/e9nmfMcL6iaDHgw/D4iNaOWn4fLkSui1wnj/nuzDdl12G6Gfjrz?=
 =?us-ascii?Q?95etUjTaMCegHlsX2os4P9FHVI6tuZHhuG5ZhPmYc0d6u54GN7IePcbjFIW7?=
 =?us-ascii?Q?/QRGn9hDx/gGNN097lE6e/xLDrB00AiqDI3jUuFog6CVvRgYUgIbXge7v8Ex?=
 =?us-ascii?Q?u+yLY9BRtENw3hjnyhQV4gd7vxi+zzKdwa3zcIYka36YfS6sVj7AQzQVwpJp?=
 =?us-ascii?Q?2SvAHOWCnMc0MCgtY1TvL3a45iiOTCDIZGO2ZxKqNA0eU/OY9SOsdCnYYDdb?=
 =?us-ascii?Q?Z+e9gJ0+M2V/MxebB3yvW8TdsEYUIWvOvgca/iuPSK5YMfd9Tc7/tPpNTgm2?=
 =?us-ascii?Q?8tfuzKkmZ+Jlm48xWHz9P/ElMVKmu3EGEz5Hs06i5pXmHXH57oUVAsqE+fle?=
 =?us-ascii?Q?fZp1krJ2M7ICb69fvozWIOHOsRoLxD9+0lM7nuN0ja3DKGtjuhuUoZHYPsZY?=
 =?us-ascii?Q?WwRliR7SnUKfmKnOd4Ldk+pPn8sOPCSrUeVfdid1W0hkJcXaUmoEZs7aFRBN?=
 =?us-ascii?Q?Vc1DrEiuB4yHUJzOQ6tre+XEahx6yojKzTrN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 21:47:13.0212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3642ea-8b39-4fea-17cd-08dda79f31a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364

Cancel any entries on the delayed work queue before starting
to tear down the lif to be sure there is no race with any
other events.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 4c377bdc62c8..136bfa3516d0 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -409,6 +409,7 @@ static void ionic_remove(struct pci_dev *pdev)
 	timer_shutdown_sync(&ionic->watchdog_timer);
 
 	if (ionic->lif) {
+		cancel_work_sync(&ionic->lif->deferred.work);
 		/* prevent adminq cmds if already known as down */
 		if (test_and_clear_bit(IONIC_LIF_F_FW_RESET, ionic->lif->state))
 			set_bit(IONIC_LIF_F_FW_STOPPING, ionic->lif->state);
-- 
2.17.1


