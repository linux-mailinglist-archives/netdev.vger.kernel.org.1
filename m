Return-Path: <netdev+bounces-284698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EfRIzvF+mkzSgMAu9opvQ
	(envelope-from <netdev+bounces-284698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 06:36:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6434D6231
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 06:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F88F305DF69
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 04:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E262DCF52;
	Wed,  6 May 2026 04:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fAM1g3o3"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011069.outbound.protection.outlook.com [52.101.57.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985532FDC38
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 04:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778042149; cv=fail; b=hbHVuDwaMku6ucTX9bJO7oeiz7UOqeOWr9GlZjoQDM7YfOD6HZqcGmN//cbmUKYIcT7G5mek6ruSvwo2bSFzGGtZOrGxR1HX+XVqj4ySz/dWUB8M3kb0FG+FPCqQu7VYNfU0ADX1oByVd+akp99Qp8BEZN0y/us16CcJbwtumPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778042149; c=relaxed/simple;
	bh=zg5lSlh4EJk0UueVy93mQvUt0a8pacMQnjbcs3iBJf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6tDQi16sYqY57MOWa9iuw3w4uGEm3sINavwaMi2YxPytiDpl0pmXgPAFGAO7OlWOw/8K4nwiBKNTw0a8rHFtQ15KUFLW8ecPodNcO+XERSI3ePQgVTz2K34ZOm3kHrr9xqCxRBfIGbSslIn5qctQBFMzbSKcyM+ix0IVTIAzgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fAM1g3o3; arc=fail smtp.client-ip=52.101.57.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOlpgLM9cNdv0W0g54BTNkYbJryODkgzuo1p/x+t9hWzFSzo5ciCZzGb7Ojunj8FZV4ZvE4RvTwl5Ww8eFiyMiD1a4r2CPBZrOz72loks8iIn7R+o1Ex5fNSFEKiEDCICUqjJeL2EprGqjojpZRdU5LpRTrTf2e1LCWsPXky5fYMX2eWAx2gdPfRVggUS2Z8hjq6b4xlefNpCmB0GOjhbpROAjae2U8JcOf4KJjdF8hVw1XUAtgNdNwjF5PKHej8jpOCE18It4aPokezCGNnFEwYuikqfPtL7nL7R4M24ghVqrWqdjtJLj9+xyc/tA/2LHulfy4U1Cr4JIBJgQIO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KQ/uX2cpdGGHhdy0a/tjhvwZIlDliBt4cKbOLLGWWY=;
 b=XG6KJvbaf5ryjaC+lUou0KiENdQqOokSqYgcsoxCY29tXdFEMDkcs9yT0tFnzFGY8IqgIehKyGjoLYnnyI+x7O9CgX3VV2XVX+GfeIWgoUgZUQaVJV1FOJmUj5HclKvFAGg/w0rLiZqr0Xaby25gAxd91lipvs6oGgNyH+7iO1jvwpOdNMNizXih81rIb4zOUW38xXEkJP94Y+gPvguho7k7TcSwP5iMnIK/I8IIk7G/DOHIZ4tPV1D77ODfOzG8T2Gm8yssyl8rpY0vUXh5wJdVDNOfmy7RlgsoF6pCUXdAFI8G9a4F6qxkpL2IE23TIgBWXyM4a6eUiT5LLFwKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KQ/uX2cpdGGHhdy0a/tjhvwZIlDliBt4cKbOLLGWWY=;
 b=fAM1g3o3Xd4LNRWq+kz5E4rWQ80GJ0y7ykcfqVGyt89XqkfUO2wHN+2uDGH74PC8Q12abNM8AMj/nNZnjUdLLCjWZZqlko8QvNeCyYILDvIEuGDkuzX/v1eNBXlyOF81Xm/vY/CorszQG8SIstalUGbokjodDEkfq2a6qhaVEIA=
Received: from SJ0PR03CA0375.namprd03.prod.outlook.com (2603:10b6:a03:3a1::20)
 by MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 04:35:40 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::1c) by SJ0PR03CA0375.outlook.office365.com
 (2603:10b6:a03:3a1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Wed,
 6 May 2026 04:35:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 04:35:40 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 23:35:39 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next v2 2/5] ionic: Get "link_down_count" ext link stat from firmware
Date: Tue, 5 May 2026 21:35:22 -0700
Message-ID: <20260506043526.64301-3-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260506043526.64301-1-eric.joyner@amd.com>
References: <20260506043526.64301-1-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 29667a19-fcdc-4c09-9bd9-08deab28edad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	fe9M8OIfxdsfzSs5+eVGcHL1dJJs9aTK0a6bSpaFi00QAXW/JMrMq2+HABBGcFH4zmejn0jE65jwNWSPs3T7stE6etj9GeNcIhQATxOl4dko+J76am8/X1mUfZpfI2uVONrGnBDCK2Lj1gQvipkHceUZK+Iv+zdPyNOAyiMlV3NpDThwSAGQA1R238H5QfH7C0sEy84iD4pFt6mSOditF0lQre9ndDoQIEq7qkTOIFIspxGfBVvhofpB3gER9yzT/SghSyodMuI5tURft5G1pZWIjmQxEKO1Dd0YugBYgLkkK+lTa17/8bQpj0PW/73r1MRzSsi0dDDWo4OdgQGayjpbVPztgGsUmWJVSCliNrTWxtcGfCydB9oGYzaWxHXUFNmbbgC0RlKyEtQ4tAreDvAX6kccWfr64GBZZRuwmIf7bVOelYpcJjBaS0klDdW1mCzJP8VTUij7+z/AuDwHcgcDZ15hjz281EiAoBRvwD15a6ADqPCxoA1jutnqkWTDpn9lZsR8E1wSAf98Zg5BtaD3YmrYjb/kyOTWdusLrecRgI8fQAs4bI6fRgf83TCnhkqa+dMLUZXtJDT7gb9WAJY3hY0G44JF6zsRBtE5jIGi338oKr3XvQeeIANz7v1K/wA9MrW/cmPg24axjA/UzFpao92vLBVRiE9jr+xlEFZm3PzHQ56vcDx2OerrIZ0YsMYaGaDzZWYHgdKwSLT4dUlrNTb8T5x/IABdj/CJuo4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	24Nnqt5bOo9ZuaZc6oS+fbY5niNI3Hb98gs3cTfT/8A/8FhTJJsLOqOsKs7zO6s3Pw/I6NhDhU48hI2rTRgxrJdGwixv9g9vlLD+0Asj+Eu37AinS8RFapuTS3ltTO/haG7bbIz8pDmYIR2cPHjun6WSJohwkVSTiHagCjms8RVKY161mLqGhoBqG/0iqX23kD8RGf5h6jJZ+bN85a7adpqpSUj0GR/IhzBOEw+5FqRwVAIYw5W2+jJwP+zbfkMdLN85RxXuspA0l4aoMMHE/j1S8N/oEy5v6vFhWR90vcfbiF55Jv764HYrtIhYvA+0uGmNKvW3TVohQNMu/rgT4GVJNb4bEAFc1hDhjrVjuoTxY4KmQ9aYcdGyGvBPJBunX66wjRxnEShIXuuDKmeZ4B/p0mRpQieIpKr5Y0CxlKP0odOyPJPSKhF6EJdVmN9w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 04:35:40.6697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29667a19-fcdc-4c09-9bd9-08deab28edad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683
X-Rspamd-Queue-Id: 0C6434D6231
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284698-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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

The number of times that link has gone down at the port level is tracked
by the firmware and sent to the driver via regular DMA writes to an
instance of struct ionic_port_status in the driver's memory.

This statistic was never reported in favor of a driver-derived stat, but
doing it in the driver was never necessary since firmware had been
reporting it the whole time. Since it would be more accurate and true to
the description of the statistic to get this count at the PHY level,
replace the driver-calculated statistic with the firmware one and remove
the driver-calculated one entirely.

Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 3 ++-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c     | 1 -
 drivers/net/ethernet/pensando/ionic/ionic_lif.h     | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 78a802eb159f..af0c4cc8ad8e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -117,7 +117,8 @@ static void ionic_get_link_ext_stats(struct net_device *netdev,
 	struct ionic_lif *lif = netdev_priv(netdev);
 
 	if (lif->ionic->pdev->is_physfn)
-		stats->link_down_events = lif->link_down_count;
+		stats->link_down_events =
+			    lif->ionic->idev.port_info->status.link_down_count;
 }
 
 static int ionic_get_link_ksettings(struct net_device *netdev,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 637e635bbf03..eb7e552bc12e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -179,7 +179,6 @@ static void ionic_link_status_check(struct ionic_lif *lif)
 		}
 	} else {
 		if (netif_carrier_ok(netdev)) {
-			lif->link_down_count++;
 			netdev_info(netdev, "Link down\n");
 			netif_carrier_off(netdev);
 		}
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index 8e10f66dc50e..d34692462036 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -214,7 +214,6 @@ struct ionic_lif {
 	bool registered;
 	bool doorbell_wa;
 	u16 lif_type;
-	unsigned int link_down_count;
 	unsigned int nmcast;
 	unsigned int nucast;
 	unsigned int nvlans;
-- 
2.17.1


