Return-Path: <netdev+bounces-53670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D62A8040CC
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 22:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483D01C20BCC
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77382381D1;
	Mon,  4 Dec 2023 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b/xTUGqk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54D1A9
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 13:10:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xeo/akGSPSHlY3mYwR+WzdXTChqromJ3COIlKU9b0OtdSonCbS/hwMYS6IxW/9GpsAg95dac6nPH8Z88Pc8wEQqZdIJqk52DUbzIEmWyooTX/5QTwl7Jqoj1P+rZvIVrIYrLTJTZ2xUlcXHYn4+hOku3IxGB7vPhBV7CUxHkFg0VNIPKqu3Xtm/ZqifmM4Y6D6WHt2nAp7ULVBIR3EY/xFQUArevAkp4jq5iKmkdr/i58RTW4qBeK2nvsw11wCRsabtudJJx/ESVfKRMMhSpyt4WggGXrK99cVaS/IdoyCNdws5eEAZd0nuwjndRwOf7CBsBZUxr13FpwnXGiYxq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmXdTHdKFeS8lgypOEA3KwRfpHfj48EQpNOYHQMz9Cc=;
 b=Rsz8q2+ToRSzMJECDTL98intGcyhs8P1+t8bxQhTM58/PM0W+Fj/9gvKekTLw9QW+c5eB9aOE2TcS1t6HwxPTR/FjNAwHI5gmqBsQ/wJyERoxhtvhUjEJKl+78caY6Xw6PFaDJnufwu03C2oPo2uEmuxcRngpFoQtuDYLWFfDemDXnpdPNh798eOOKqaCke1Az9HNEozjTdguqsXXGK7NfRY1+XDrWzgSN0UWUwaaJh9rn87P2Kc1iN29aq5MBYBkFp7AuVdlpahnegpqcMYzqzbbuDT8/QKytopfksmiwaNYA2N9Z74bDr19BiXVCpgLXYEk9mj2I035Mzn5TN7Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmXdTHdKFeS8lgypOEA3KwRfpHfj48EQpNOYHQMz9Cc=;
 b=b/xTUGqkzQ+P9s4YIs5Z0tFjkaHGHYzAo0X9dOJN9iqLO7gOwqKRjU1CjyQD8s8CM4AIyfsbZxTFiVzkJb+74vzX6DNQymoox0kgo7MmXmlz7XhBOsLiuLh1e6S76nuTaesh1b6BaiIQsqh5AMMrSQ2fNLjBDM566PMXFAigKpg=
Received: from SJ0PR03CA0378.namprd03.prod.outlook.com (2603:10b6:a03:3a1::23)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 21:10:05 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::fc) by SJ0PR03CA0378.outlook.office365.com
 (2603:10b6:a03:3a1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Mon, 4 Dec 2023 21:10:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 21:10:05 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 15:10:02 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <f.fainelli@gmail.com>, <brett.creeley@amd.com>, <drivers@pensando.io>,
	Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 4/5] ionic: Make the check for Tx HW timestamping more obvious
Date: Mon, 4 Dec 2023 13:09:35 -0800
Message-ID: <20231204210936.16587-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231204210936.16587-1-shannon.nelson@amd.com>
References: <20231204210936.16587-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: a47b2c87-b903-4e0f-468c-08dbf50d6364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/6J66yuP8jGpE+6ZzXBP/hhqcsr9ApxRfhEzXKijs7IHFvOetfO6E41zAG6I2uYj9NEahCUixhIfOS61zKu9TLx4CsAipNS+6+248h/up7/XVCuH7nnZWXnLG3lSha6CsdoVO5EUN41GIIhr2LdnhX6QKXeLVGDVVZEyjs4YT1CacC/H8d55LKnZjU2+KkMVE9pIrEx7WzaaFoj3K4CBLuNYMRr3WufW79vO9Eoi7gnAJg5MnVVhYfjDvRXKPSOtk4fe+pOiajENwfms14QVK0YUcN0xkRLr7nQvr5UJ7zQoKH9Yel701nojAnoAiJKjRnugaVcOmruHW4YfHk8Wu7HNu2AtvImtdKe6d6x6Z4Jx1wnank593rTeavRpnSRB4XU7aoGgmBrUmNFZCpt3zFv7OQgt/Y5Hl8cAdtxmjfbhBkFsA7VUBRQiTaklmLtZ4UbuSsEJxo9pLIW6xiEC2zTC87isI9YdSYxi4JVwLtp6UMjzOq4lIdI3onl4LM9TdgJmSq+1fh7o73qV6P/0c6PUED28nk0qshIcePrxlhdLz13xEAdz30b5jQFRuaIjlhX8CaX0D0WEnbJJBg/6+5U7wBTisd0PlYQLMZh9iB7uxIZe+Zyb0yt5C7MPnlXK98WQxF2+7T9GST3DWsoaq4Ann93yskqkPTceW/rNR0limRGIl/RFJcgBdrc1dLmCRxtdDaKsu+3zX5R+WwRpXiEmpj29oX4voWR7GIDKNfP64Nv8ajbuXd6ElRsZF8N5BUPvi2LjsKgWlMWAF2vaxw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(70586007)(54906003)(110136005)(70206006)(316002)(478600001)(40460700003)(6666004)(5660300002)(36756003)(41300700001)(2906002)(86362001)(44832011)(4326008)(8936002)(8676002)(1076003)(2616005)(36860700001)(40480700001)(81166007)(47076005)(83380400001)(356005)(26005)(16526019)(426003)(82740400003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 21:10:05.1921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a47b2c87-b903-4e0f-468c-08dbf50d6364
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149

From: Brett Creeley <brett.creeley@amd.com>

Currently the checks are:

[1] unlikely(q->features & IONIC_TXQ_F_HWSTAMP)
[2] !unlikely(q->features & IONIC_TXQ_F_HWSTAMP)

[1] is clear enough, but [2] isn't exactly obvious to the
reader because !unlikely reads as likely. However, that's
not what this means.

[2] means that it's unlikely that the q has
IONIC_TXQ_F_HWSTAMP enabled.

Write an inline helper function to hide the unlikely
optimization to make these checks more readable.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.h  |  5 +++++
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 10 +++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index 457c24195ca6..61548b3eea93 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -312,6 +312,11 @@ static inline u32 ionic_coal_usec_to_hw(struct ionic *ionic, u32 usecs)
 	return (usecs * mult) / div;
 }
 
+static inline bool ionic_txq_hwstamp_enabled(struct ionic_queue *q)
+{
+	return unlikely(q->features & IONIC_TXQ_F_HWSTAMP);
+}
+
 void ionic_link_status_check_request(struct ionic_lif *lif, bool can_sleep);
 void ionic_get_stats64(struct net_device *netdev,
 		       struct rtnl_link_stats64 *ns);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index ccc1b1d407e4..54cd96b035d6 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -803,7 +803,7 @@ static void ionic_tx_clean(struct ionic_queue *q,
 
 	qi = skb_get_queue_mapping(skb);
 
-	if (unlikely(q->features & IONIC_TXQ_F_HWSTAMP)) {
+	if (ionic_txq_hwstamp_enabled(q)) {
 		if (cq_info) {
 			struct skb_shared_hwtstamps hwts = {};
 			__le64 *cq_desc_hwstamp;
@@ -870,7 +870,7 @@ bool ionic_tx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info)
 		desc_info->cb_arg = NULL;
 	} while (index != le16_to_cpu(comp->comp_index));
 
-	if (pkts && bytes && !unlikely(q->features & IONIC_TXQ_F_HWSTAMP))
+	if (pkts && bytes && !ionic_txq_hwstamp_enabled(q))
 		netdev_tx_completed_queue(q_to_ndq(q), pkts, bytes);
 
 	return true;
@@ -908,7 +908,7 @@ void ionic_tx_empty(struct ionic_queue *q)
 		desc_info->cb_arg = NULL;
 	}
 
-	if (pkts && bytes && !unlikely(q->features & IONIC_TXQ_F_HWSTAMP))
+	if (pkts && bytes && !ionic_txq_hwstamp_enabled(q))
 		netdev_tx_completed_queue(q_to_ndq(q), pkts, bytes);
 }
 
@@ -986,7 +986,7 @@ static void ionic_tx_tso_post(struct ionic_queue *q,
 
 	if (start) {
 		skb_tx_timestamp(skb);
-		if (!unlikely(q->features & IONIC_TXQ_F_HWSTAMP))
+		if (!ionic_txq_hwstamp_enabled(q))
 			netdev_tx_sent_queue(q_to_ndq(q), skb->len);
 		ionic_txq_post(q, false, ionic_tx_clean, skb);
 	} else {
@@ -1233,7 +1233,7 @@ static int ionic_tx(struct ionic_queue *q, struct sk_buff *skb)
 	stats->pkts++;
 	stats->bytes += skb->len;
 
-	if (!unlikely(q->features & IONIC_TXQ_F_HWSTAMP))
+	if (!ionic_txq_hwstamp_enabled(q))
 		netdev_tx_sent_queue(q_to_ndq(q), skb->len);
 	ionic_txq_post(q, !netdev_xmit_more(), ionic_tx_clean, skb);
 
-- 
2.17.1


