Return-Path: <netdev+bounces-98827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9868D2938
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 02:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C8F287154
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 00:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B24C363;
	Wed, 29 May 2024 00:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qjZy5x2w"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2442A48
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 00:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716941014; cv=fail; b=Cs/soMdibf8d4R+nQ2NkYeMxmZiQPubOKtzyTRW4ogd7uuvhZpjdSuLulwPq/HFUqjix9c+A5BY5J5NesCre/ueZZqHTsHoIx11IosN/xc5aC2heDTyK4rxIB58A5CaD2rTl6p64i7VzDj6Rk0hlz3qO2+5YlWRrp8SW2hX0NAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716941014; c=relaxed/simple;
	bh=7SCf8edoeRZnXE9HgOulFi/qrBoVTJqnnArSaiWWGBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUzFl6SO0YeI7glclPRYao2Ls5xt6v978ryAwpvkKEY1mU2qutz38K30yCnDLwHGQjY44GhJgaOkr8neJCj+fdhX1FulGvdaoQ8zjdby9bTnc4fhs9JBmZMzGuQEl8TlfFFdFhe3MxnANFSzrgImDelQl+MV6jw5o1NbTnw8uTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qjZy5x2w; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaFeEVcMPog2RKt67Y+fCY2wz6JEANqM+hZsh9gfg0YZtjr3T8JnERf8MCIc4HcZj1Es9oov97DpjqEqBhKHYZhDjiZ1RajQ+nJdfWMVXFPlgN9hIF0iRkFqIoHPUrTHjdR7L8LWfQTJUuLSmU62Gxv6UMUZBzZALFs3ungyn/fJeQZdZmWzy6jVeMp+eyGsAmHaDjBtLpo3jqQRZK58v5+rD+7JStvyhVS5mZ8xUrRB4Vruec8PouJNi97/itnOzKZFTpOJlTAqPybJwB6/EwHo3JJMtg8nXdQPKHOc7hDXsuh+14+TwfYAr+jx1yKLx062k7kllLivfs+O3NLPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jt0o6q8z9hu/78FJDGbMK+Tr8NznW/CDAALfsrxouV8=;
 b=lwBoJFrg3oaWsqw7wy7yG8P4vqlpcvGa6Uhn8QumdLm8XMwNGjl0rs3JRhaxBS4FBnoCxRqcRxiRoD1Qof6KcbHKsxmop0yjGlqJ8mJ2BSXUcT8X8eoywAelXy5YELmiV+Je2uM+SHrDEI++78ludjrkHjnAvx2gXZGR/lpRPCJg6A+uxp0QMhu1Mk6Ei2qwlRdXHkPMmUOf83r4IjmfZvH0rCqvNMiriRSrODhcvkGuA1syqLdiFfStA3Rthw9an6yxno+Cf/DcB8lpXhWr6GBs2z0Yq55eqXw9ka1TitnfSiiJPccKDrTaYlpLb+P95ApKISqDZSEwrywUrNrZ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jt0o6q8z9hu/78FJDGbMK+Tr8NznW/CDAALfsrxouV8=;
 b=qjZy5x2wpCwkuYi4STXfgLalUjTykaySUKA8nGbmuP2zqYAypk9rCBOtbeX0RS1rJRIrZp/M2UCHeapGiTL2qeE8cfYbt56luEtZMGHqYJ5peUQ1qVEa9f7c/PDwMaErpnYBuULL99lF5WVXGFSr6UURdH5wSbzcMDS2TFimls4=
Received: from MW4PR04CA0331.namprd04.prod.outlook.com (2603:10b6:303:8a::6)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 00:03:29 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::b4) by MW4PR04CA0331.outlook.office365.com
 (2603:10b6:303:8a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 00:03:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 00:03:28 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 19:03:27 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next v2 1/7] ionic: fix potential irq name truncation
Date: Tue, 28 May 2024 17:02:53 -0700
Message-ID: <20240529000259.25775-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240529000259.25775-1-shannon.nelson@amd.com>
References: <20240529000259.25775-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe64144-bd62-419e-5f14-08dc7f72c4f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hWU+zyFkjAqL+CI8d3ETU1eQ42jojLPo8ByrVA11halrpZsMJSGYNBgvZtD9?=
 =?us-ascii?Q?IFBI5hS36oc7r/F12jkE5uMflcpDUWvcb6jAegXz0D22/yRZ542NKXPUKAlH?=
 =?us-ascii?Q?xbmAKqFOlNo533gV7UDSjFpCj/Rz2yaIyufJcCKH9HXCai/DbPWxBpBJAWJe?=
 =?us-ascii?Q?XRTGRd/8CpZnfmtsvx2WyrX/ksB1kspvtwX7ncGfGYxB3TCWPwuMc/httfaP?=
 =?us-ascii?Q?/kU3md7r+qKM7LT9xSxZh2A1CBogaZMaiX+ulceteDX1AFd2GhNY5TZrslnk?=
 =?us-ascii?Q?Eb4Z8L6T5tMEXXAa4SD/Z1WcjSKhP9Yfewp8kIk6HImrtSphhHZiHDTTsz2f?=
 =?us-ascii?Q?hGB9epSiXjnI3MjilepvYWW+zZyJXm8L9QN0CNmly7WplRvGRu24P++98WuN?=
 =?us-ascii?Q?FXqD7a6gp0mkMT0z6Jb2HjdbRQPokyxJXc3qEBqvKisn/Jxq6EHtISN73OPi?=
 =?us-ascii?Q?6EGS0YExQSBn9puxjK2LCvmM8FIkZJZE8zikPSRnwn/P40+ZfDE65+jFkIGD?=
 =?us-ascii?Q?MJtGRTVCAv/7WYPMc+coYNkDUPraRhVO9MMjMAmFwNnY9Dt7poxwMZPIFGs5?=
 =?us-ascii?Q?NxScz6k8RjFVa6Os3+sfabp7ljiL35m2/5EZVvEkb7SfVjFqrg4F0j70X3Fl?=
 =?us-ascii?Q?7SSm1US1MqOCG87QzBsMpstqq/wx4RlSnLv6cAMV+jXN3nVTZyYNkf00Whpr?=
 =?us-ascii?Q?UL+d0RGwFxybY2M9xLNYcXQQt4q/DFvq7Tr1P94Y9ZP+24Ct1kNdXS4zwEzP?=
 =?us-ascii?Q?+zr8uja9pJhgeH6Y8lVRL8lee6QHlEf1XY+mvZ5s45w3y7GfxryqGaq3OR/Y?=
 =?us-ascii?Q?cbDYxripiR5VVVFxn0dpJS+c1ms2irbN3jkIUewlj52hVHZerlRCLoRC5nGF?=
 =?us-ascii?Q?6RnAlooKZXNCWOoVtdLR/ZOWijGOUwXk6SypQB3stZTY3Foh1EAcIBA537eI?=
 =?us-ascii?Q?kGonhgLUdzh+N+Orjg6Yv7KjkzQRhUMMstAtdSPcTMRFQp664/y74KcGpwv8?=
 =?us-ascii?Q?/vi7/GwHbeTYS9s+in+cReHuGpnVzM8kymSJbBIZKStRxa8qh700Ny3+80Tx?=
 =?us-ascii?Q?XOjN83/u9duX5K3pWKgp/69znzCWwGfHFHpcmoNIi52rPU3YrvPg8Xn8zQU5?=
 =?us-ascii?Q?ZEe5eK2eoDI8hag4jq9ty8stc8p/ZcsOe7PxL8Hq6LwgXSai7EdV4GtzkZuy?=
 =?us-ascii?Q?suQjoNDFxvO8ZoBwxh9UFBCsgSLGrQAt9cPhwJvFKuQZLNC0bsm98BVw7JVd?=
 =?us-ascii?Q?zSTORmRQdaoWJV08UuZGjpv1P6JBapXTO5z+lXGbQDWw3xGwO6wnIB6I19/8?=
 =?us-ascii?Q?9jgwN3Ca+5uX/6hK6NZudZfuVOL6iISZjAhWONT7ou1B5xlF3LIJsCX0Extz?=
 =?us-ascii?Q?3p3NAAMtn2KnSuIJSA+/+5k8kq0v?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 00:03:28.5932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe64144-bd62-419e-5f14-08dc7f72c4f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684

Address a warning about potential string truncation based on the
string buffer sizes.  We can add some hints to the string format
specifier to set limits on the resulting possible string to
squelch the complaints.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 24870da3f484..12fda3b860b9 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -242,7 +242,7 @@ static int ionic_request_irq(struct ionic_lif *lif, struct ionic_qcq *qcq)
 		name = dev_name(dev);
 
 	snprintf(intr->name, sizeof(intr->name),
-		 "%s-%s-%s", IONIC_DRV_NAME, name, q->name);
+		 "%.5s-%.16s-%.8s", IONIC_DRV_NAME, name, q->name);
 
 	return devm_request_irq(dev, intr->vector, ionic_isr,
 				0, intr->name, &qcq->napi);
-- 
2.17.1


