Return-Path: <netdev+bounces-284686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBVgJTu8+mknSQMAu9opvQ
	(envelope-from <netdev+bounces-284686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 05:57:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3114D6056
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 05:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADE793021ADF
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 03:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522D02E11B9;
	Wed,  6 May 2026 03:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hfrSGADa"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15F52D837C
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 03:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039865; cv=fail; b=MG4doBlUiRdCp76PI5DAZItVGmaPTp4wbLXlEzclHz4x377440pNgcjLGUtC/Ey5hzWHQJpzN7TgZmaInYjuda73jY4Q64mYhUIRKdlm2ePZn0yBeOwE4GWJOuxxW7Qrc/YtA0fpOm0BEdEXRuMjWuANT9rv+eYBPgWEPYhdQPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039865; c=relaxed/simple;
	bh=5oMuqtvfvTh7zZ8r4NetVyWVy2vKWijR/1LqtfDb058=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MF8DD82saZ8nYNiH5TgzsFU1+xN3oXyCb5GW2kPf+OA9nYgW8sFIcwO2i9mUDqW/oo3CYVHtwg3mHfzgx96vhJP6s1IM1y8Xc/kZ4TTmIzsXD1msKdtSZL4KS8anJCVxHVZIevMMXI+y9phxRIPJvU0dgrFfDdFq8dIg+UkiAlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hfrSGADa; arc=fail smtp.client-ip=52.101.62.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pt3TSNCccltn3IAvUhSqn9cC3dhlFYV6QTFASDk8RxZ9NiJ1zs3VvYLfd9Ae4wLMsV1Q/L1OO6CHCwRZu3NS0lwG15pO/su1SWnB2AWV7kylbxkblKE47MUhAH8s181/wCjJ4o1aKiXabAp8lDsfgPTTvDd/BaJQUusszsS68MBBGFdPh+fJVd2to0ffGyb2Tb7I252ECDS03BHwnrSoUF+ziMMPQC5jKah7oeFQyRtJL9yMQiejxlWPeIO4zY5rFEc+/3a0UdvP16ExcusRDB8f3AsdCRHO42+juv8a/gV6ZJemCACgcd9olaKvaXMDU9W0wAuNculiYpHBkCm6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5+5Ybntpgu2hNJvIT92S3Ai6Ac1I+EIhUrdbuaGaFQ=;
 b=L+y9yuQ9FM+5+fha8vLJlrYccWLhcrJXDA+7HofljRUjb46J7L9GhmjAqeqWKVKrnOfeWHv5n3Jfy7dKE+8p6T2Yy2fWJc8oVjbAFk2LeUD8m4Wgis3byFRAQFMdiEgnPvnZHfY1ftS5plCqWsh/G+8KGUGt69Mz2c7s+cZpj0n5qDkbhhkzOGIw9CRIDix9SBWsw8OceS+surHSZWSGdhKlWuBpxfuGU10v+pK/0T0l1bdgTujsb0Ejj45/IXRmMKNqkb7nhal+UvGW0qcsiiNxpHmPKZfJ3PJ7PkUzsGcraGwSMAakXg3MebTnlOaa1elJ5vuE9aInxsw9tkxS5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5+5Ybntpgu2hNJvIT92S3Ai6Ac1I+EIhUrdbuaGaFQ=;
 b=hfrSGADap5SM1AFH4idkUxeNJas4t2NjC/pQuAoKX/nyn77piJD+HsLhh2XB4PxXOnOxctXa9J5VZ88M+yfZBbdjwzb0u5UZtQqrrbQRopj2DDpaKSk0YJ6Yoqb19oxszoVNdhvZht7rFkSJoDtdvG0OVTyNV8x44TwV8sQLYTg=
Received: from CH2PR19CA0021.namprd19.prod.outlook.com (2603:10b6:610:4d::31)
 by SJ5PPFD525C5379.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 6 May
 2026 03:57:29 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::1a) by CH2PR19CA0021.outlook.office365.com
 (2603:10b6:610:4d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 03:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 03:57:29 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 22:57:27 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net v2 4/5] ionic: Fix check in ionic_get_link_ext_stats
Date: Tue, 5 May 2026 20:57:05 -0700
Message-ID: <20260506035706.12373-5-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260506035706.12373-1-eric.joyner@amd.com>
References: <20260506035706.12373-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|SJ5PPFD525C5379:EE_
X-MS-Office365-Filtering-Correlation-Id: 177399ff-757b-4ed0-859e-08deab2397fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7jPUS8b62nXrBs9lMIGYhrBR5/JODfroSlFuI72zcwFbY+tmnGUw7VM1UEfFgV1f7YWhjv1s4feNZQKy+bhFHB1UYUT+MoBFVeCT7YdkiTxK+UjK12CHxF+6fDe2kgJ47Td9rnuWiF1ty5Rt2BBRRk2o0/+KW8kMd1wuPsizMcBh3ZLPl1A/soL9e4TmEmo5S1XqtPR6rZ2+k7VC3hje0pXKLNRDC/N6ac7/pqqepEUac7fupA2WPawtoHKWTKzCdQM67NyUDiQNa59CH215HNzYPxiFkgibdBKuHbjDo+v3/PKQX79zbyDfEItxYERZttikt43e5pDmUFXcMoEVYna51M6G3gnZUfhk6j6yLla++xhLot2TYvZnnnOI55XBJjsAV/EP5JXC6GCYNj09nkwWsVQIHBsIJ8oMEZA0jMkT6lHhwBakyLM0vinz04uQs1wouatiCBkZ8DzQ3l2uztusF90iF5/RjMuq8ZLSs/QBPBwWC0wKsA/yr6YR5JcxmpaEuIoueLxWLIRx0vLPxePd+JuPYYbBGzDUMbSJQZpcAUnZ+ePJmH3ob+nIKvBiWLuxgy3+Hg0PQI3vcKHKL7HWw8yhrJiPak3TRmk5xQZKrwivoWXXv2fdkYTY13gR+VG22/kCVM5NG6j4Xsp0RKH10xu18euyS/VcOaSFVpbiiQSevG66Mkg0+PoMt1BegdFzrPdWlgcl57mByhp+n8AEfZjZPKoIPyTZF/ySapM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vzTI7+dMsw6vdChrkcoGfoA3fQ+LjA4zWBJ8O8BBYfbvZhwVN8LHJe6f2JDs+HmawdgCEthcSamD5fsPPh3Zn2v5po0CO8z9i1Q6k4cMc8yPYzovfibM2VtC445IZoHu7nTD84jW0ULLCYHt/teP3sOMj9MAoNXCBfmE2lqw3ZjP2pwlSWMlSn1LVEh1Zn7NY3oPR29lo4OT5gLxRQBm2IdAB4aahFQOhLRSFr28mWZ2wIJ3em5sW9NivJddhWIndgnI7gyFHjfoI0Pvsyw9+d+RdWKDyarQ3+otzPGqe+K7Un3yDD0phuCGPl25X7vSFGr5cNwexC0tfphBq5nkurxdpjDXKGBQdBPzGDhy1WFRia3SxklZflWgoM+JZIbgY5782pa5E9NQOojsOUpuFCvVTSZjQy8oiFY6tnXg/N0ludaoKr2Kt0noKp/1K/Xp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 03:57:29.4428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 177399ff-757b-4ed0-859e-08deab2397fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD525C5379
X-Rspamd-Queue-Id: 5A3114D6056
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284686-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Brett Creeley <brett.creeley@amd.com>

The current check will fail if SR-IOV is not initialized for the
physical function; this is because is_physfn is 0 if sriov_init() isn't
run or fails. Change the check that prevents getting the link down count
to use is_virtfn instead so that VFs don't get this functionality, which
was the original intent.

Fixes: 132b4ebfa090 ("ionic: add support for ethtool extended stat link_down_count")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 78a802eb159f..296f831a514d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -116,8 +116,10 @@ static void ionic_get_link_ext_stats(struct net_device *netdev,
 {
 	struct ionic_lif *lif = netdev_priv(netdev);
 
-	if (lif->ionic->pdev->is_physfn)
-		stats->link_down_events = lif->link_down_count;
+	if (lif->ionic->pdev->is_virtfn)
+		return;
+
+	stats->link_down_events = lif->link_down_count;
 }
 
 static int ionic_get_link_ksettings(struct net_device *netdev,
-- 
2.17.1


