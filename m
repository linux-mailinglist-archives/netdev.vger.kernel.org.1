Return-Path: <netdev+bounces-283078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCRWMRwb9GnZ+QEAu9opvQ
	(envelope-from <netdev+bounces-283078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 05:16:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 652094A9E51
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 05:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11C60301724B
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 03:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE542D877B;
	Fri,  1 May 2026 03:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HNGKkzUU"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D831E1E16
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 03:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777605390; cv=fail; b=e7XgYmIOxwmDuBegNdp0KDccT3fn4gOrKE1xuLkqOOQTEGXWjLOr0Mja8j6EUdcE+y/9Kqwzn1IJ4GyAqX3LmThq107QUz3onZWebNW+XIVQXCPQmrDjB/lCp41yvGDLlVUFIPGx0EYwry0oEZxntFtb/+D4KVdUlqVmJkxdzi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777605390; c=relaxed/simple;
	bh=YEMCwzRzH0mKhjvtvA/m4bw9s+JO8trUlmKgh8gFMhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpEuCu209QyuSPue61iLcUQuluOMlew5euBYzYpZjMZAmfGvQInwnDiUYLwr/pg9+RUkRl4Hl9UXsHV5CSRAwXrPiavmIATVzN1VFd5wBAOzSq+adzXG7E5r0rk5p/detD7FoRU4FAi238RPw1ye3WVY2AYAy/KYO6X/TD28rdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HNGKkzUU; arc=fail smtp.client-ip=52.101.57.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1jrtvRp+XVZ4HlVRQIf3OObTzUYrgziokZ7q3ww6JWrnpgXcwKYHjdeMtgqdZBOdCJ5Dq6UCrpX3uJ5R3SsqAm0igOL371w4T04XJeKnM3SZIqjRBQIatk15qHoJg9k0hY+te16HKQv6Lco3JjydHiN3zJQpy6N3r3mRUvR5MM6pJKpjS+YDk0bDlSMJJuPxGuBiWHOZf+ljhk8wRZF2r/C67B0eaQnGNlG5l9JtvinVvuCWrpV8MC++KmCoibFET4agVpVfLR29zbS2jSucAE6VVsuzv+V5hJWl2EgK56PXVFmNO+COFspOe1ZjyobeMbtA/lE5pKaN4KdTC2JlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38QN/08fQ0AFlfO24GCoZhFYbd/4oRukabZYomMcQ5s=;
 b=ufO4iOdqozClEZmae31AvG8wsoBxOSKFVlFlt4UdD33Nkk+gbDYjP78D6RwY0XL/uYciD8xUI8LPWIODIC4TSYTkSKICabj1KsDjdtlyltyeMODamhxHr1PEIRkq8kKwAhP8CpB23pR+amlN0Rhb5ATdpGi3efEPfgAXEDR85mcjpWr5A13UrGF2eBDOy+dGBCYhza/QrmZpKLTKPBqqVsebswDfrT9pkOUps4mhnAbykvYkFDgD/VdGHh4S3y4wjSCIxqqBKmWsEjeWvIriPSSH7TBe/vgF5jZ9F1rsIZwlcMqn07wZl5n0eIn8kLb29m+noTc7qaKqr1gJ9iVNXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38QN/08fQ0AFlfO24GCoZhFYbd/4oRukabZYomMcQ5s=;
 b=HNGKkzUUz7rXf0fWfmE7DT5pSEJdIQA7JOv2pgXz81PXms8+02OBP9o4dJUsYnGZWXA8Ubny+t4fU957qirjJciXlQW6bWHLx+h9fcJo1XBbhAxBfNi0yMViaxel/ig3zPuqLqP3SQ8PS+4FT/yyEygAKNayH0u6px0WiF2FslM=
Received: from PH8PR21CA0013.namprd21.prod.outlook.com (2603:10b6:510:2ce::22)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Fri, 1 May
 2026 03:16:23 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::71) by PH8PR21CA0013.outlook.office365.com
 (2603:10b6:510:2ce::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.8 via Frontend Transport; Fri, 1
 May 2026 03:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 03:16:22 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 22:16:21 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next 1/5] ionic: Small improvements in devcmd retry logic
Date: Thu, 30 Apr 2026 20:15:51 -0700
Message-ID: <20260501031555.43259-2-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260501031555.43259-1-eric.joyner@amd.com>
References: <20260501031555.43259-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b87ce4-8b3b-4a00-5687-08dea7300580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	IM75gFHAEsUDjRIqbpojx50PePTe3uhbnORnzM/6MUVhnKCZz7vRi9LioU2OT16etlZD53YotcUNkLpzeZ69YzpwQxgNo+3SSsqYVx8KGpRYoHjvT0ieJQTBtMCUNTtqz5NtMHI6xwzKawx3B4gcsmQ+qZ96mKDwIVekqGAWs+26Tdc06o/Zzzge3KDSt93koE0BFS+5487q1+0Wy6t4rZkFGXmGWnnmg5JLP5i5qQ6v1t3ldN8rE9CGqrHvGb0HwaEcMMNtvVU+DbU9kPoeW1WOFeSA6whTQwabZZ7LKjkcVRzas8OOz8qJmwf8nM5fHCn9MqOW7mKlzVk9HhlTMh40pUT6iQCYTKa3vS1CWagGMFj2j8Zunce8R59EJjVpPvw/OYnM9OKLvkp38wa4fjr3L8ApF7p4w4HwwT4YavKkmA2UqAQrAiishnET5EDDKiT6LbQHcH9VXUbulFx0Ats7QopN0u4gNLxSB3jv96U70Ik/aTY7JYheNU3HVvNgicGZQ6e/4UMzd6lU7o56OsCWOeX8h+4k9AvO0WxLIxFOzE0I6xaD/kNw6DKNJNOKpEvMZ2A8EMpJVFRylTsCh4gRocmIUVKzPVvsiuNI6FeFJP4630s2JAXbBKkmzjURqNqfgHko+dUnA1PDb3Lw2ny97QLbxxiyf8JdoLjQzDcmcgkubLib4Lg8nx4tsHtIFVhZyW1MKlcvILGaeHQ77EnlSwN3Ub+tZP8LZ+lsgIA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g8DjssOfYGyIGMDvkWBS9lIsHigJBZV+l2MzoXVbHpPsaeBiw+dsv8M7MThVRsxgIje1T+pRizjTuvY85brt4wfWNCnAGLbZVjXHFB0VxIJRDialJysbyqm06dHH1dQzc3tJ51gwGOVuUA2GHXXfLCH4Josa5eg8SXdFqYOva/5gkpu+zNhpEB+vOi37rGwYEvVYwdDvtbjWOri4UL6a3GIe7/2NcxYkzYZ6LlGzG84+8K9FO/yU9Dyz61s8eUa55RfEFfqK91RQDAr81iVHBcGGdAerGrTxbS0Trj/qaGwLjBRZHEjb3eJBNFNDxBD37Me0WYp75DWDAIjzbu8HODBvBGGfYTdqPyIk0URgFxzKHMeFlNr7RvD54qMFYA9ReARsliq1m47Z02dXIQW6+85zUN/7+5kvn/uW+j46vJXIg20Fov5MJsJGBuDeGzed
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 03:16:22.5094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b87ce4-8b3b-4a00-5687-08dea7300580
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431
X-Rspamd-Queue-Id: 652094A9E51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283078-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Brett Creeley <brett.creeley@amd.com>

If the timeout time is hit when the last attempt returned EAGAIN, the
driver returns -ETIMEDOUT. This causes the -EAGAIN result to be lost.
Fix this by returning -EAGAIN if the timeout time is hit and the
previous result matches.

Also, reduce the sleep between the write to done and doorbell
registers. The msleep(1000) was initially added in an arbitrary
manner. However, this long of a sleep is problematic because
it reduces the number of retries when -EAGAIN is returned, which
may result in the devmcd giving up early due to the timeout. Fix
this by reducing the sleep to msleep(50).

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 3c5200e2fdb7..92f2ec0bd5af 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -554,6 +554,11 @@ static int __ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds,
 
 	if (!done && !time_before(jiffies, max_wait)) {
 		ionic_dev_cmd_clean(ionic);
+
+		/* allow caller to manage EAGAIN from previous attempt */
+		if (err == IONIC_RC_EAGAIN)
+			return -EAGAIN;
+
 		dev_warn(ionic->dev, "DEVCMD %s (%d) timeout after %ld secs\n",
 			 ionic_opcode_to_str(opcode), opcode, max_seconds);
 		return -ETIMEDOUT;
@@ -568,7 +573,7 @@ static int __ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds,
 				ionic_error_to_str(err), err);
 
 			iowrite32(0, &idev->dev_cmd_regs->done);
-			msleep(1000);
+			msleep(50);
 			iowrite32(1, &idev->dev_cmd_regs->doorbell);
 			goto try_again;
 		}
-- 
2.17.1


