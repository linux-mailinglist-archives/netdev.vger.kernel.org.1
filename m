Return-Path: <netdev+bounces-282491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBhyLaJx8mmJrQEAu9opvQ
	(envelope-from <netdev+bounces-282491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:01:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B06C49A508
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 226773017050
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8FC36EAB9;
	Wed, 29 Apr 2026 21:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fDVF6u9l"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3F33858B
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496478; cv=fail; b=CMGNi7xUaYbgZBCOC36RuW6gHdFLp0kX6n1ufNPASarAvtv4e5w9AnZmL5fXz4Yt8VIDkcOd4ItM4V9n2rEmEUmGD2qOKui/9AZ/RKwqq6h2YGlw29jyNaRW9uP5Og37MkE0h+CTWSsWgDPfscBYbDEvFGmzmM19xkGEZzSPHFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496478; c=relaxed/simple;
	bh=5oMuqtvfvTh7zZ8r4NetVyWVy2vKWijR/1LqtfDb058=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkk9FoQplhVBDhyUxxKgitRq+NrotdS32nTeCmGH5cNL9cQJigX7M2Q49uQih6Q8cHplfx21rWDy1G58Rh3uKceSejPpY3/8fLXl5PhBkUsjidQHioPfoXKtorQHE3ObxB6yn6a7h1U38MYUjL1keWIw/8QgdD6vATTY4hoCN/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fDVF6u9l; arc=fail smtp.client-ip=52.101.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0Rd++fImN57+qIx16LpN3VcIYcuE9wuYo/lR7CnnSCKRcI6HGZXNfauCT8EajYILyLq80Od130DVlLmHe0bmifUl56Ut+JKvR9OR+IcwHkJkuIYmPiuQDNSXssCCPwlIHzYqjgVw7HEsaHfFfj/glMiSjDTZJEgJjLnkITigb1fRzso3soJmzwdPzneNSRMBpLX4nvMj+CqQwJtlMUvvs9RNoMfkxDHVoVsQ4X2kcCa35qsK0q5IZ/IK2fFYplNU28AHaEUg0969vdI7xLDMSu3ihv1UPBZHmvPbgaGEhJY68uBhdbVuj6SHLvJJtB4+AjEwvI6plARl6s8SkVkfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5+5Ybntpgu2hNJvIT92S3Ai6Ac1I+EIhUrdbuaGaFQ=;
 b=CohD7EGjiUpCwnMm7l3W+X8pjVJabOU1oyUdPUC/X/9YuI+FakTw0iKwPVp7IbdL1SS0T+88AQoI5MmY2tlE43ngnbxpFc5K4XrIhL0uwolug3ZoVyrp/cpkcPmhW8zNNJIQVVq4W5c+xcph5ygECl7mcyQScLCt5oLW+0DlUxbYaLWwM2D+fSxvHGEN5VKjHV85Tjs7MKZmN+XRFeG7KzcQHVR1uAQMj6V5emm+QolT9E0YFcavjTpd9zPN+/SqgEeXFwqyfF6g6Hvqqnj4mAzRoai8wj7O1d36V+hEnOzv7wGbZI/uiZp9TuIbqbEqA65oWzTzJCkMfJ0dmOUClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5+5Ybntpgu2hNJvIT92S3Ai6Ac1I+EIhUrdbuaGaFQ=;
 b=fDVF6u9lzdWmSJJitF+VHqsLbBJWFpY7hc/omrdWeo9O3bJ9OJsfkbzFgp3sfG3U++IZD7zK0/FauPeqVTi33TsmFT3DrX+3oU9islbH6DpMdrLl0fWIjg6QveUM2afcBsEZ9dAP2Cax4nHOSyZ/fOU0pze0N4erJ8a9KwzhYIk=
Received: from SJ0PR03CA0117.namprd03.prod.outlook.com (2603:10b6:a03:333::32)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 21:01:13 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::cb) by SJ0PR03CA0117.outlook.office365.com
 (2603:10b6:a03:333::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Wed,
 29 Apr 2026 21:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 21:01:12 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 16:01:01 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net 4/7] ionic: Fix check in ionic_get_link_ext_stats
Date: Wed, 29 Apr 2026 14:00:04 -0700
Message-ID: <20260429210007.40015-5-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260429210007.40015-1-eric.joyner@amd.com>
References: <20260429210007.40015-1-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 814ba2ab-33c4-4ed2-7571-08dea6327258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	XOGdORQaNSTz/R16K55PV+PUhgBvaCYbwcQjnUcTFfZ4KsnlMOBPUXv1IeZ0PitSZl0i5RKA5p8aYYwf7bkMusT+eNHbCPTiDiAl/xAT0dC+KlR5g88amtNoTSBlW50J+9GcK/mJ4LnD3BExYJXBxG/ArK0Uvu4TBxA/4DknVBuHkLqL3g9alhxsCFLYx9EzV95iC83pOj/6W/R7zF1n65ANG2gpclKUd4ueZk8nzHP9mlkrssRQLPSp9OWSl+pPb4hDRysV+beJ+CUGLMdEJBu6zAxyn4fJJwrniD1VfXCKSx/fuMUgyFZl1jlXPV0pPNmC6ZGzCo+x3Ktk2lWIgNSKqeOb/h2Ewf2hHIf3om09YdMHFuscI9HsdqyMTvpJrQifJ6oIxZBhq7paiUZC3+/MUtbWBwuVBb2P80xOf5EJMA8reThRS5tauEFfbDDQYWMiuJdcpfzGwxT60nlsBfsd8jA39TPHOSvdur4+U5WWUSFQEd6qHiDAejNX5yXAJfav0QqkZcjrPLNB9QkFyLB4wVLi7KmP4+bzFi1Y3lIBAmnlSDv3jqg42xsVC+H+pS5hLBNJstqBPws+XJ5xL1PnjKdJO2gg4opAreqNCPgK2EBnIiRqzRenfXfL2IVY2zt+XoW8kcvfHRIvAAF5g1Vektl+etullH0KUyxuupU/B9awZfNO2mezpzfiaQwJRVcpcfswLIS3LgmjhzfeyfMorFoKqzw/AQRnBCL4+/WpNnQdF3tSpNlph5JLoCY6U87rRMp9omP7Ksqboyt3Ug==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7w23aAn/e8YgdQB+W2UhoFbLxaOxzR+6//CCEYok5ZbOv4d3riathLUyuXLYLdWmq9rj8G6sJ2QMHlsojuUDVfqJrjUsulkrtz5irBEA3x4r6pd2Y/+ZZGTApllwx9vpJjQ97sSjM7wGd7JvcBF8ABln2XNplK9hoXwHb8+K4tf906GvX5GdGQ97jBp7qf6ovvoRK2fRHukVDggeK+H00vnJvBGnpjnH77NivaIwXL352ynYlL8FJitCqUdxA73njUxWj8LZVY1B/LnY1sD7AfHOY09rHYNWeCgOlzTy+R1BtquvP7T1GFhqlzb3WDa2hkv1j4Pa5c/YtV2dTuu2nWwIaoNiqCRTKKHUWBi3hDOcetEa4Bj7VG/bJCXHGswcuPbYWeusb93Y/+vBn6jGu4YNR2hR6qPMk+yL8tdbXHB+Hifby4E4N3HaeMVZvL9I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 21:01:12.8382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 814ba2ab-33c4-4ed2-7571-08dea6327258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632
X-Rspamd-Queue-Id: 8B06C49A508
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282491-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid]

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


