Return-Path: <netdev+bounces-76309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E289C86D365
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 20:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101771C21609
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5B313D2ED;
	Thu, 29 Feb 2024 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fke/wpsB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C54413F436
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235619; cv=fail; b=iBGrPAQ1lQK9UlKu6WoX0WBlXF5PJtPtVXGLAaoPsCxuUYBMh7Q7axWdzaNMp2PCz/ubXN436z+m5W7tl7Wt+U/VdzuLGPlR/CPBpazeB3pyuLvp5dwADy1frWK5EvEPmYRz/aYQKDGyIaGgOGl4BOnpvrK58jGuH1ZLKBVHD7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235619; c=relaxed/simple;
	bh=xRzY225dHkZnDxueZg+vto6AwzRKaxOQoljTQ5koHsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQxfeVpRIzQeq9zitBSFZHSnHwTswBFmKCkmzNsWc6s9NC3WdhtPLhH371TKWZdjpqtmZXSl3exg3WJjbXnod+UGCkG8QD2pU2ncZebacXlnamUHICz8eH9oUAECilTJiN8ZFeekcj7TAOKxR815Bdb0MdzI64Tt2qv2DtAn/wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fke/wpsB; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boAiqVOj3NCloHqOFlUTWZaDy8GW+qiBDCADLpRCjcXeIrmIDfctAlYYoOX16buq0S5z0+4oUG8w/cMnVYPwzN3zGsfi+mzi2X5SzhzlS09JzSYMaotlKSgSkNp/05IX/jjtBn0iLPy7c6dVJyTIr1mBk57PeximC4CqQldQg0PeQYjyIYUvx0qK9mhS0fOy2wOpgYRwnbDfa2KYAv6HBFz9j9P3QjBT0qHbH9a7ZwD3NgVWP0yiu6Wa750uRFVOY8zMpk7UsrgEkF7lG29WFDR0gX8rs9GONaX1pw44zeFg9liOKRSgky+qBrXU5c1MIc7IriWAX5a9uwOQcmReOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Dl/CMxz6Oh7usgMqweG7EmUwKLbdz84WDEQF4PZTfg=;
 b=LNxl8muldyt6/C1ioe8qfbYXTr0Nr0Ae5wxaqoLRZc5cr6tLJNM2hWc/GuIvYcP61fUwC3HVpvSzW+gCk0JJdJoyN0P80Y8JogOObMU3mp7H5ePqcVz2RtAvZQH5Y+hzJHbmaujPlAF1WVSea7X172WaBfZei+1Y99XgNDWa7/xDXVAVDK0ndGjwsUAeYjDKcFuthWzd1Bhm/rzqjAyOHtqlNry7Mg8185I7pnObqPkf8Lk74VQ7a+y48eD3EfQ42KJ4aVEbnPAF/p95ZsUT0Gl5cXKdP6Uq0AgtBw4ZHbvIVNNYgpq0ZwurDyMjy5kHhpkkpe5yLlyN7aEfnMY2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Dl/CMxz6Oh7usgMqweG7EmUwKLbdz84WDEQF4PZTfg=;
 b=Fke/wpsBfIWLUSWygJwnwWlwcaJZWAqkoNJSYEjxOB0T75pD/eLuchkBjJ4R7xknxwO00UId+JICMQO+wm1Nmpb/JvE+UDH6pweJ2Wq7isPBjCfK05a8JM8tK5LxZ7nmg82+gQzTIRo/MfPOFES1OZEg1qvm/crnT9gsHZ/QUt8=
Received: from BLAPR03CA0164.namprd03.prod.outlook.com (2603:10b6:208:32f::20)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 19:40:15 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::b2) by BLAPR03CA0164.outlook.office365.com
 (2603:10b6:208:32f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Thu, 29 Feb 2024 19:40:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 19:40:14 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 29 Feb
 2024 13:40:12 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 06/12] ionic: Check stop no restart
Date: Thu, 29 Feb 2024 11:39:29 -0800
Message-ID: <20240229193935.14197-7-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a81b2f-c2df-4ed2-d287-08dc395e4033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a9h2GRgDb8CXc3uoNRaY5raN73iE/TUSG7Fn7iS4J+ri28s7SBuJMKpz0dn9HyH5YByK7RLqBMwDczuaNikrfwgChDBY/z/zWc1hEjGEnFbSiCupfL86v8tnDZiLE1aNvR6TOa2kPCjcTwMLsyg+tUNt2gzkx073FdY9PU0ppWUpHOhh/8GHih2ZtdSaku+n3iPUnzBgTImYwMJLzGdAIy/+I7EGACaXmg/r+ZUrIP1VEZUuAx/KXsbBkIt9luGILp/0d6BJmfPRVeP+s9odzm9Xv9m03psnAUU/lc7J9C7XI1V3CLDLWxB0W39oNzjXOJ4/uNOdramw/6YtK1PDm+5vbj0aahL8nkwXscoF8TyT43K3hxYyobhtH1nq+UtYJmQ8YQHoq2NiR9VISOS3kVvzQ0xlxUBpAF+juCixmLEEjBn9/eyS0zwAahpxeA8oPCpnFLju/yrdGKjNvVy56iiMCsJTIZvWlhqS5B4vufR8jUqZnl//0F+3FeA6DkHTbDfPdXY8qW1VwqNaXdSpXA6f/ymRFIVNcmWTLlY/mbV/WMPZXs0U2QgtEGkZOWEZ8k0j8crD3qkb8zKjTdd+p5Z1kYpFHur+wgiNvhA1uh893+FRtcGXlezppPU5kTQEKhDP04sJG2P/wc0dqXD8RioGFnqxQZkp8cx3oPRg1ElYnV5pRnYQeHBHSJhNF+KesDf/G5CopfwEDwZ9yXqTH9672ImbnQ6Ar0GPZe1uEc9lRRM/4JGAfIgL1oJljoSu
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 19:40:14.6302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a81b2f-c2df-4ed2-d287-08dc395e4033
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942

From: Brett Creeley <brett.creeley@amd.com>

If there is a lot of transmit traffic the driver can get into a
situation that the device is starved due to the doorbell never
being rung. This can happen if xmit_more is set constantly
and __netdev_tx_sent_queue() keeps returning false. Fix this
by checking if the queue needs to be stopped right before
calling __netdev_tx_sent_queue(). Use MAX_SKB_FRAGS + 1 as the
stop condition because that's the maximum number of frags
supported for non-TSO transmit.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 1397a0dcf794..d9e23fc78e6b 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -1665,9 +1665,14 @@ static int ionic_tx(struct ionic_queue *q, struct sk_buff *skb)
 	stats->pkts++;
 	stats->bytes += skb->len;
 
-	if (!ionic_txq_hwstamp_enabled(q))
-		ring_dbell = __netdev_tx_sent_queue(q_to_ndq(q), skb->len,
+	if (!ionic_txq_hwstamp_enabled(q)) {
+		struct netdev_queue *ndq = q_to_ndq(q);
+
+		if (unlikely(!ionic_q_has_space(q, MAX_SKB_FRAGS + 1)))
+			netif_tx_stop_queue(ndq);
+		ring_dbell = __netdev_tx_sent_queue(ndq, skb->len,
 						    netdev_xmit_more());
+	}
 	ionic_txq_post(q, ring_dbell, ionic_tx_clean, skb);
 
 	return 0;
-- 
2.17.1


