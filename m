Return-Path: <netdev+bounces-52737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3077FFFDF
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 01:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073511C20ECA
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 00:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87CF2566;
	Fri,  1 Dec 2023 00:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L1iEmMIt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF63F10F8
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 16:05:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjq58pyWlFobiSjw6W49U2V0tvrV1/7HZ0gkMqfvgdekyB7brvPytoM4YBaSjmhMEftARfMfIAoqNr5p2i2uGHKxwgYTGOg4JRIl8UTx3w0FquwOLlobn2Uosn/w1nkcStk+eVr+nTm8S7Tvmno7wSorqHzIKPM4Tss6dNO13opYmu7NlABuxWLhrKX57+mhpkCc37yViKAEwhl1Ts9FneVQiUnL4TcEAZoYQRQ3WU/YG8px/QglI2vuOvHKvheXIm9c42e/utBAmvwjSocWXRjHjaxk11uAguXCFAvs9EMPNK77Hk4cvdm2msCdBc03jJb8DpUTltYvoIRSFyeSKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5CwC7SUwbf3k4l3QzZewxoJfptXNqbvcp+M3Anj4H0=;
 b=kNkDYs0bymWgDdH4+ryEjcM2bp5iTvHQIJmRTLi/Yt5Hb2jImmLxPdmiISHDZUdWaZAewiPg6FogMsH0QqvpkzD7ChJW771wYFWaw6hNXA2ll3BizudKb3+r5MacR31YZlq6Ct99z+hf14MDYUqhFndfvIllc/4sHph8m3bE7eJwJdyeVF+w0ivdzQvJCCAHcqGHQB2eXgrDvWXExCi+jNi75pKmlrB96wNibKf7XDKST6p0gpf8kZJPLK5seY1X48BfiAsBtm6bR1dfBXsnv5U/ByXqPoYvez08EjVFmHDyiSXttSg+SBk5ocAaxH0umthJlb7e1LvzavNTdSt6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5CwC7SUwbf3k4l3QzZewxoJfptXNqbvcp+M3Anj4H0=;
 b=L1iEmMItHx/ST3ZS8tA7clf4540YgIb5tHkagIo6tarZlH1FtIvwkJUTrzyvN3MzFGaF6jeoHqxvoxp6JA3Ido8xgRAqf90Tmu6qlo/98AiXqRFVUCOGbNLHw91FrM0rzeBOccjjPZcI5GMmAId0godCO/IeIQ+ZN0oG3V26/xo=
Received: from CY5P221CA0108.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::39) by
 DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.24; Fri, 1 Dec 2023 00:05:45 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:9:cafe::82) by CY5P221CA0108.outlook.office365.com
 (2603:10b6:930:9::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 00:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:05:44 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:05:42 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 5/7] ionic: Make the check for Tx HW timestamping more obvious
Date: Thu, 30 Nov 2023 16:05:17 -0800
Message-ID: <20231201000519.13363-6-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231201000519.13363-1-shannon.nelson@amd.com>
References: <20231201000519.13363-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|DM6PR12MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: 889c2dcf-94fa-47ee-8678-08dbf20143ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RtJVtIfPDhUreH96NUZTlazb5v96ZMUtwgHivgcfpp2HLBRm3h9IEoaHCMcbU+rhUttO8iWzMbNqJj0C+miPE9Cbtrz5x7oVYRjmpcStXXy8m5B7oeScQsJbpS8x8xPoMqiAq9EZZc/bnZx7v+exJUnLMD5h8FdFYFYCM3tN43vmPzQ5ZdDC1fS59aw3jsONVod53RqP59hmg5TYDY/LihiMykUkiW1lHNt1eV3vKDmdyJUE22ByGNWYupkgGNDxFR4imkD6ON1f5oZ/W3pMIyh9YsWs1L2ix75p1iMQTSK6hY04Yy9kYoqk0j+BTobmmn6N1orKSqwoCiBVo6bJWbuRIqxLyciuQMAb4kOtnALD+ynla3GZxgBbRdf1EDQIDTpOwA5lFSkaxOUW3Lkbjhocfz1nwA5e7EVk/Nii5RoHoQGw+9+yOf/+YG+W4ruBcIVrqmHph2QH1n2iAL0xSQ7u3/8j6MZ1f7FCEch9kV0sfE+7Z1pdYBKFE9KOhq0cNMdmsrA6tnBaZXOEZzQ1ZRzMEuwSJR9Y7ImjgKyjvp+gdB1TwBP4X1k6ofW2k9SEIvvuuc9h7pfkBTy5x3tA9bSjUjvk/K2BAKqkuzzyajaNuwWFLQWUacwSKZzPfhAm6Nd/qszjW7/uGUX1zMV2RMRW6kNiJbHVEgXstMpgYV6hCSkjJGHtdkUSoq6AqtFIw9tC++LKyCjwH8GPv5IQg1vQli6sQXQcTduRyaTcDl81KXewwOrF62pF8J+PeWmdhaXjhsv4i9c4Dy9L9dGBYg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(70586007)(4326008)(70206006)(54906003)(110136005)(8936002)(8676002)(40460700003)(316002)(2616005)(478600001)(6666004)(41300700001)(2906002)(36756003)(44832011)(5660300002)(36860700001)(40480700001)(86362001)(47076005)(81166007)(82740400003)(356005)(336012)(83380400001)(426003)(16526019)(26005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:05:44.8042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 889c2dcf-94fa-47ee-8678-08dbf20143ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332

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

Fixes: a8771bfe0554 ("ionic: add and enable tx and rx timestamp handling")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
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


