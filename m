Return-Path: <netdev+bounces-76306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E2386D362
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 20:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE788286CD3
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0F913F42F;
	Thu, 29 Feb 2024 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sEdKV9dT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A099B13C9CD
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235616; cv=fail; b=E/pERGWXUpuBBNpkYv1MB4ZfSfo9eUOuhjC7HeYWbTmRWZbNPGXkl9pykzA5EtkXRGF4u9VnEO4lUUJqbWeDGXvdeW7gPedkPAYPfW3PuP2WgDBiSY0jJ1GZ2ggzP2C2sJ0Eezn74/NKIFPz2qoj6kpht+UJo96WbDVZGQgeZY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235616; c=relaxed/simple;
	bh=7nbKKcSsYltF3we7K3Rzb821Krxm6ZUm4oXlKu0DieE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NyZaKnhetzkHrWnvbQqHMzrCRq2Mpq0CLUGqlsOlkz5isomGOWY4Ix08pY0sEcgLwdxoWIxVSoi4vBQlcz6FDRoNGUbVLIBN5oHSlYyYley9JBxOgQn0V4WPhdr+uuLb0ZN4Ab8SR0zpDwE1SEulsZ57WlpDdT6pIy/bkkJhLUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sEdKV9dT; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bt7ZGMrB9Pyl/T0IVXGtScKslNTMd8ZOhW5dAlf1vjn37dw0ZOffXJ3M6C95rmhSxAewl/GPgvPIj5zf0e8goip5zzcevlJ9rYryAyGeo0G/dM3zCCJM8zfoOHUBfe9JIS3lEy89lctO9faKtr8DLX98Q7fnLMhXICwx1nDLfqHFOdR1WeO+t9ZTVI4+nE9Fq7WN3PExyKuZbaZq3xJ/TyUzq1lmok8FAdzIaFlFkX7fXSMfHDjIiBBaOPikRvb1fo6N755E2uNz5DwACX9ARcb7eU59q9S2hlvrwb2dEXcr34r41zifbFtCLur3dMX8a0tJ8BBBHhXzok8y9iRFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6A2eylX/kcTdfb5ouxyHibXQY4e2UjNmAfkT/LbzKo=;
 b=jyMhCkNHOabiZYoh4ICHXs8th6EcssGe3DJLM/5RX8eLd0sN3XOCIOJmYFMpxguxSCHO7bwl1km2UEj63tqryiqxSEImiZSy1fkxOjbP5J6YcXwA6RR8nCZdqYtBHwUn77JunLN9PY/LxHxQ2cuc6dPWO7P2uQCq85WgEE6fckDZCMOMrwGf0bo1BxP7JNGmf/dRkbI8CKOr+1fwtdn7TY4Pv8zTpqZooF/OwlLIaH1h74nlHiYIqMGDRZHmMJ3dRVBhPpeVbSIUN9u8rTspQt4owNsWj54kWWByvz3Xpa6a+w7P7nK+Gx8yo6867iZnN20N5xhYYv5kdFc4RjnTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6A2eylX/kcTdfb5ouxyHibXQY4e2UjNmAfkT/LbzKo=;
 b=sEdKV9dTvQvZ7/aGy47JjYpFUJPhAMLf9z9ZH578HbSJrQVrWMF5dJn1nCT9GMdrhK7TUZ9Ujb8XfbgvELCTnd1oZ9zLazxiptFrttIv9mNNvpnfgrh8uHr7CXWiQNOwDy1mhnN5HLWkJCKovKucfClp4iEYwMqsrTdhis6NRvQ=
Received: from BLAPR03CA0157.namprd03.prod.outlook.com (2603:10b6:208:32f::27)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 19:40:12 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::fd) by BLAPR03CA0157.outlook.office365.com
 (2603:10b6:208:32f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Thu, 29 Feb 2024 19:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 19:40:12 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 29 Feb
 2024 13:40:09 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 03/12] ionic: Shorten a Tx hotpath
Date: Thu, 29 Feb 2024 11:39:26 -0800
Message-ID: <20240229193935.14197-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240229193935.14197-1-shannon.nelson@amd.com>
References: <20240229193935.14197-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a5a5727-ce16-4bf4-1cd8-08dc395e3ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1X0bz4Qn8GXq7Zd96diF+at3N4OlBQDWgDrBOGMcomRr43KXeJdtQg+JnAyfKnFCZGdbNEDY318DrEyg1wJ98SVwzF4QQTJL7q5wXQvXejWUxuyj6RdYhZC56y1Y+ajIrFjcXux9sVKbrVLSCdVRSk9L/FoLjkujvcaqKmAc3qcOYq2l7HXgpueRGdmueDeKtiqEj0rNrW74gRsZ4EM+3+n8dFr2zBCROkWIjlbCI7c9UmISETKJ+X4zs0oDOWR7vHelJkjA0ykGLbszUD9sNUJ7PBZFuwvNr4K0V48flV0cjw1X4geHTjD2zDu+vTXYkaRWh9j4SSw6NaK8bJybvHQl4wQrMMLgk7HwMHRVm7DKkoKzXd5uhr1jAepcO+ir9VBYhcW/DxQlloHmAQPvYG8ESVotF7QHEvEtMu0hpWGQvT3swp2Ifdov725b5RuJR6kbQrBRTDIAZq0bH2af8cSkaOYIkpYWDborgBNMLJ/xiSWU6kh8LftYvvf715EIo+aBwxpHTvxqkVaSCFaw1qA75hADkl4lN0ojNqerxMS6k1CW5zTOb1UElsFb8sKalhMh1VmKZucMQM3MKOFoo+S7/8dgETMZcKAMaZRSlN/UjqtPjxNMwTa4wJ9rN8fgBL08HbW99PDjfCfF4yOheenK+dwsYX4BRjPMtt3tBk9onw4WljljRszDIM8uryf2XCmd5Kyk7T2jOzMmZfdlDnZ2Zcn7nnexV6k/ZL9Gj8yXZgNB0kBh4/KWTAZYPUdZ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 19:40:12.1614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5a5727-ce16-4bf4-1cd8-08dc395e3ebb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260

From: Brett Creeley <brett.creeley@amd.com>

Perf was showing some hot spots in ionic_tx_descs_needed()
for TSO traffic.  Rework the function to return sooner where
possible.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index dcaa8a4d6ad5..2837f2cc0151 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -1669,7 +1669,7 @@ static int ionic_tx(struct ionic_queue *q, struct sk_buff *skb)
 
 static int ionic_tx_descs_needed(struct ionic_queue *q, struct sk_buff *skb)
 {
-	struct ionic_tx_stats *stats = q_to_tx_stats(q);
+	int nr_frags = skb_shinfo(skb)->nr_frags;
 	bool too_many_frags = false;
 	skb_frag_t *frag;
 	int desc_bufs;
@@ -1685,17 +1685,20 @@ static int ionic_tx_descs_needed(struct ionic_queue *q, struct sk_buff *skb)
 	/* Each desc is mss long max, so a descriptor for each gso_seg */
 	if (skb_is_gso(skb)) {
 		ndescs = skb_shinfo(skb)->gso_segs;
+		if (!nr_frags)
+			return ndescs;
 	} else {
 		ndescs = 1;
-		if (skb_shinfo(skb)->nr_frags > q->max_sg_elems) {
+		if (!nr_frags)
+			return ndescs;
+
+		if (unlikely(nr_frags > q->max_sg_elems)) {
 			too_many_frags = true;
 			goto linearize;
 		}
-	}
 
-	/* If non-TSO, or no frags to check, we're done */
-	if (!skb_is_gso(skb) || !skb_shinfo(skb)->nr_frags)
 		return ndescs;
+	}
 
 	/* We need to scan the skb to be sure that none of the MTU sized
 	 * packets in the TSO will require more sgs per descriptor than we
@@ -1743,6 +1746,8 @@ static int ionic_tx_descs_needed(struct ionic_queue *q, struct sk_buff *skb)
 
 linearize:
 	if (too_many_frags) {
+		struct ionic_tx_stats *stats = q_to_tx_stats(q);
+
 		err = skb_linearize(skb);
 		if (err)
 			return err;
-- 
2.17.1


