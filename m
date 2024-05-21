Return-Path: <netdev+bounces-97265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BF68CA5E1
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 03:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E39B1B21DF1
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 01:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37BD8BF8;
	Tue, 21 May 2024 01:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xYxYBCmo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF7125D5
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 01:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716255463; cv=fail; b=ChMc8jfzMU8fz19O/OCIBYrUBFQHsBizR83mAvoi57eCzMFxPI/ToWh6nSeoyC6QnPh0USPYErSG2kMqUgDZKYToAaJWge+K4f8q58RnXoMIgrM/0HdkpnEKBI+//haPLIvu9LilLfhQ3MMVkkXoWvAyoVYMqZB5cXUxyjEIvJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716255463; c=relaxed/simple;
	bh=dWlw9lslkLpUeZLUzQaMGWVWlV7RaMC7IyGHw/F4f1E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWYJz9pqhkPV7qaAB+F3JKIzIsvyFEV3p3/WuJOOjHXD4i+SICAkcTCbzjhg97ZCkDm8zJStRJ+DuwOX4AiQDPxlm3O6mpKdhGrGuBFJwrw9fTryjccxSWoBtRoweSsLItJUba4785kgWHJVRyQ4z6z2HUQ1XkTa/VBQ3nnctD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xYxYBCmo; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wp+uvv08BfdhqP90wVo5vF4WLLVDFmy4evLa4XWLUvthuwJZpx94VNAWmkphRe8jq6gHoqzPCVLm1Cqoj1MC4aD+IGJ+7G/phTlcXtLQwv6I4miWjIoFzxJPqVESXiOxfPIYC8JXZhqkPFyBU63wLa3gxHbrpsMtDfxJNQ6eHhYn/eTYSw+Vtvd9Ed/k6RxAp20DhFz5md6d6QfoCVBSVuwP35lxFam6Y/+MuOMDLPoy0mRBBaI/JsaQUpEl+R+uQn9QpNwjnUvbDIjfPJ8N1G+HlPQwkW4txfULUMHcudOv7FTJQeywfKSVPtopFPDAt01QBFUmQb2Z0N57e2utIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SdsHeCTNQMmOryOE1f9UJu0PRmJjqVTvGKU670G48Y=;
 b=LmrQT3c3MX5gTN2HY/LqYhW7PMPYEl3dX12QJEA0lprgKTJneqLhuP4jCfK6j/hYf2wpLwTHXN/nv/B2ofj4tVuFd3802z6LPlTPuYxWxh/EUYHHrSNjde93elaGONswK+51H2l4CmN4itVAmJKW6GUIJrenL6Jj0dyk4tcuwr1Sfiri4hJzSl5NSaTDEZ3h3nsev2FizqJw/B+NYCNlA92Xdb0P9xJN9OHFJvA9am+xolz5z117TgUC6mnJyRbKt3GeN0AbqcwqPUU5QvtRcpgN8FoTTgpSsWUxogFKA+tyV90dxVttqXe9olKK7hJA/C9y+AFmO1dUk1nsxVmstw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SdsHeCTNQMmOryOE1f9UJu0PRmJjqVTvGKU670G48Y=;
 b=xYxYBCmoIF/bus56pS1VCF7R2kJuX2ySedPNGjlBOkOjH5Jpa4Ub22kRYXho76dqfrBET4avDrAqwZXZO0z8qqSRVPtINiETtEtjMXwCYpn2AYXMP6KHaYJcToG8/p7mGosMxA76z+jI1rAm5P8phzw58jtFRV93YxTuHh8dfVw=
Received: from SA0PR11CA0027.namprd11.prod.outlook.com (2603:10b6:806:d3::32)
 by CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 01:37:34 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::93) by SA0PR11CA0027.outlook.office365.com
 (2603:10b6:806:d3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35 via Frontend
 Transport; Tue, 21 May 2024 01:37:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 01:37:34 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 20:37:31 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 2/7] ionic: Reset LIF device while restarting LIF
Date: Mon, 20 May 2024 18:37:10 -0700
Message-ID: <20240521013715.12098-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240521013715.12098-1-shannon.nelson@amd.com>
References: <20240521013715.12098-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CH3PR12MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7ab2ff-bd01-48e7-8b69-08dc793696e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4hS+UPaKGJT9ippq2r+C/vT1jPjeKefPNByl+AwmD2j37kFkTSHcx4+9xNrA?=
 =?us-ascii?Q?bvXvyo0Cbf5XNU1SEvpigfCa8cifdpKQO1smqjejxFhIotE3nbbxYvpk3C8M?=
 =?us-ascii?Q?cYn7Z+KF0hSfVIkHhyI9Hy0dmyaRkJOUl6y3W6jqA03oXFiKmfi0HYfNAsYr?=
 =?us-ascii?Q?Ikwbz4u3S+dXjKpCWYtFgYwgDaMN0rhnFckCaSbN+8kvgNwec9MzFoaJUxTg?=
 =?us-ascii?Q?NbAATKYaqMOLu8VGEiJS3kKVkrmzxfaRiliuF5XXDQ/8snZjmCaynR4Uic8W?=
 =?us-ascii?Q?UmiuNI5ADecTm3TkgTEFDjVyQD8mFO/DozGTNZr55Z6o2AJl6JZJvNrhqL5z?=
 =?us-ascii?Q?WWFhIGsczP5Nqn6Y+UaQiy4rt0JMxycG3KusiJbey2K5GzvJEiSqt/pkF6WW?=
 =?us-ascii?Q?+40Quhy9uGHog6v73gKfop+SP1p3qdMAzI3ZnY06fY5V/ew5K9m5xlwNQxB7?=
 =?us-ascii?Q?ug+vDxnmwmKC//xEN4c7IBPPmBhBE9h+VFuociSgviBuko4Z8fNyynMFx7Pm?=
 =?us-ascii?Q?oq5SXVYoZ1TT+fB8rNreOVOyG6D+OM5Csx5oKtfJVdGWWn5bAj36//74eQDm?=
 =?us-ascii?Q?zjJ+58Ac3YDCM7/DUtvuT336LDVIsuvNgQtQUONDVJ2Ry+26MiH9xa/0JXG5?=
 =?us-ascii?Q?sv5xSl7LCDObaX2W7FAXY9dZSf1+72Tf/L/alih3iu4kXLHRC1oqbpkDPGda?=
 =?us-ascii?Q?2CJhhTvs1qS/7Rw2QNCbS6HsxlOyG1SmFKV1TKuUn6NjDjjgQy7wZrCLU4lV?=
 =?us-ascii?Q?bdInKEfInzPV2izei1S3PrvXbzvqj7MtIOfyO6B1KZ6iG4xjgy7PoBghDRRd?=
 =?us-ascii?Q?CsEoFJNPYsazn1amjJPyNDzTF97ZEl040oGEml4CqTAcja4sf11I+WXmuCwi?=
 =?us-ascii?Q?1Zq+2t05u9DuRpN6GFjS14nss27Odeog2maPGGJPcefuLP2qnxAlULfHHL/j?=
 =?us-ascii?Q?hS5zjC3LrSiVx1Wax7D4V22xDrZD2hTNzowPoJxYCsfrpla+eJ5BGW5CgaXc?=
 =?us-ascii?Q?a7ww0lRDpYDcUVdkI14RfMdCmXKIjsVFCb7cQxWWH2N3O78xwY1eKzQsEa6z?=
 =?us-ascii?Q?4dKU4Vy8brBicAvh0eLUHdr426jo+j5f3ctZGEoR28aAuSn4evMp7kqPYIM2?=
 =?us-ascii?Q?IO4tk0SCZYJznpGP9vI0LNxHpG+Lw56lTGtOl3b6wFlgm4Txl5qs4wOdlCwb?=
 =?us-ascii?Q?bMxxlAexHtRa5H1FASqmlLiRQVpOIg3B07HI2lxQ4dPjCbIDT0kZaI/78+tJ?=
 =?us-ascii?Q?FPJlTV7yvLZjz/vuPssGdG2t2NQoMD0U2sWWcDfGdaq0EU1P5jVPErPGwrWb?=
 =?us-ascii?Q?KYh9I3IU/IViX0/vhP1h0NXR7G1DiBdnFaFLIBwZkko0qKLFRdB6kq5CF5Zi?=
 =?us-ascii?Q?FlsyWnM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 01:37:34.5872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7ab2ff-bd01-48e7-8b69-08dc793696e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8657

Recovery from broken states can be hard.  If the LIF reset in
the fw_down path didn't work because the PCI link was broken,
the FW won't be in the right state for proper restart.  We can
fire another LIF reset in the fw_up path to be sure things
are clean on restart.

Fixes: a21b5d49e77a ("ionic: refill lif identity after fw_up")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 12fda3b860b9..101cbc088853 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3388,6 +3388,7 @@ static void ionic_lif_handle_fw_up(struct ionic_lif *lif)
 	 * just need to reanimate it.
 	 */
 	ionic_init_devinfo(ionic);
+	ionic_reset(ionic);
 	err = ionic_identify(ionic);
 	if (err)
 		goto err_out;
-- 
2.17.1


