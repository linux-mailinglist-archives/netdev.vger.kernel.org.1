Return-Path: <netdev+bounces-284685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJXoIlm8+mknSQMAu9opvQ
	(envelope-from <netdev+bounces-284685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 05:58:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E811A4D6070
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 05:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C80DA302334F
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 03:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7D62E762C;
	Wed,  6 May 2026 03:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sFBgmy/Y"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477199463
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 03:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039856; cv=fail; b=KlG8GJSYiahWL17ChNmajyU4hTCuzJy4Pe4S4p24Ew3FuuOJrFcGCSPyOPxBZwoilzMMGFfMTrAHnzhY97fEe0F4mERioKu4wXzCaqARTmEiXg3uCibUkjYIR0OxUpWQir0a5+W9s/yJHZkmoMKce5ffFnbk58yVnGkadrIe65Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039856; c=relaxed/simple;
	bh=P0QjgXI95CeUARarehn0tONAdcZcenqgQneJ/QoIGKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uv6Z59aof4X2Ba8KfoZzWGMPQd2vznzmDkkZakqIQXQ+Bg+w9En4+8BlW0jgVhavuKR1u3xwweqr45OsKDqBpepzW97+zMiW9r81zP8Pb0/75s0r7u7S+Q+j5U9yreWXG1hHAkdbRTZYD+AJk3XRsHkPgHY6zimo/2R2IJxGanM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sFBgmy/Y; arc=fail smtp.client-ip=52.101.48.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiZE39LLVJt8/HptW7N51J3F3Y7MrdLusFfO/byceIpp/tUi7v661NIr5H0ZhF8TAO6ZzZRFyMvHYf9xTUFq/F/PXm/NowJkZAwsv6CR0EtbmO5SWYAWm4exUjRJI2yRTmJ2z9g1jqMzCXr301K6hlB5CKMkiIUa0ZY/9Cof13xiR0s4G3V7ETihqYTFtpafarfIh2anmGbt1z6B/puGZIS1r03bmQExwWeELpuesbv7TrVxCQjRyawN9yVG4UmDN6aTB5Ox6gN0pqLogGpsMxQ3r11O0uKQ6RqkunUP8DI7iTzMOFm3XuaX483SEsCWKpVMuO1LXaqlcxd17ZWvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoufF3Kx0xaEmU1HtuDdmk6nfz+mE+RfQupy177E6d4=;
 b=vdlZbCcUHJ0Hmnkd6bXSPDhC2UPV9SHhwjF9KTjuV0Z4xOA1In9EwPcTm8NN/9cg7gwLXu4RfLXu38JdBnSRvvPTNkPeNVvWnW8f0YSPMTYl/PGtmZZCT/qtT0nmTu59y9B7lBJZbwfGJ56Q3BKMfIGii4IEHtcuprFesalaEbV0YKqrPDajpszpDKf71kXv+mr6kR8SFCoZyX0NZzZsqcEbz8ne3x3nJbHXvHkh55ewX1KIzrXlVc3EGn7n+VdkZkfNFyJrinQlX/3b//83dRaYlQ1QzDLA94kRe7l++4ALRo3NMSGU25S/+mwICvXpgc+UOjhJtHo4tyqCXrDqdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoufF3Kx0xaEmU1HtuDdmk6nfz+mE+RfQupy177E6d4=;
 b=sFBgmy/YbvVa5wIccqPmZG9W+L7LbgRRdcegnwI/DFTQL9p7mMtcI198yXp58WenNUbCe/zC8IP9mxub36F9ex+ji5CYas+usGAs4cspwMcW59IjZHtjkpUw2dWElVeLXPbJ3F5dMFAFqNOTXHy259/EvoDRp05u1rwM+YnhWD4=
Received: from DM5PR08CA0044.namprd08.prod.outlook.com (2603:10b6:4:60::33) by
 DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.25; Wed, 6 May 2026 03:57:27 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::eb) by DM5PR08CA0044.outlook.office365.com
 (2603:10b6:4:60::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 03:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 03:57:27 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 22:57:26 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net v2 3/5] ionic: Fix unexpected dev_cmd failures
Date: Tue, 5 May 2026 20:57:04 -0700
Message-ID: <20260506035706.12373-4-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DM4PR12MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec7f563-6886-44f6-a74e-08deab2396e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+NgTNlOg8MpTX8WPy1FJGAGS5NxtFT0L5Ant3TFl3fj3NJ7tRv+XqPn57/DKze84fO0L4V3rEj24xX6//tj20JJaks2hcLDulQHo7bceTqmdxaVN5d7PWPRXhool0faPFYck13SibqKjrkP4UsXI2BkI2uaiWloxfh4UdZuMcB+43LpXWFyudB28wlP1TS3ibxkpQQebnGbW0LXuKmQMShFzLZcUMKphFMpcgdPqpigW3zOxUMZFJpGQ/liJLNWXO2tfKbAmpzZZ/OAwJDZiXGqFNdNXpZGbZVdC6rmY9sGmfN4vog7kq121ukgwGCu03LFY3CM8urkoB56HXRj+v3NxEw1EnoBH+tEkY1PR3c0Ih1ims2yDyh+/eSOiDhxgP7zYtv7c1bJNkI6J5dxeO/0cmFIVJNTUM0EAuQtAsXuhiN0YJTLfP6nO22tm88srkBUIn/PUUr36VR9E+xObYC1cdp0k1jZKFzQhIfsP9JIyaFQ6+Cs/uOQgZ6bwa7vyB6/UHu96pkWhnSVF3K67nFeCvQ2ay5i2B44GCf9/1eEZAgyT1encyXXKg4h0c/6AYMAsqfXNCbYcimSqzrYgjY0uTp2Zr9PATNQEAenZ2BJSSdEGplGe1nC/bGhTP7e3gjjjyuArBhYA/jaBo8UYMsPibUy9es2o+Ln7otbG5kC3FmgRYvENelO+/CL7FOOR1l0+hbtvPcsp+3OxXbABoLFPgDWTHM098U19HlzCkkw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pA82piBBEsxZW7CkAgu25IspYGvpGiLWi7UHMyxaIEIKxTa97yiRChZlemODQNCdf9Vqt+XJpsmt19oRPlBrp2vnHCdsx+FGsnG5+LEIB4mN8dzaEDDFLze+P/pIBy+QiR2IPmTdGk2G4gfg4y2UHb+TJPjifl8+RZJWMXnA6/L6Rye/tMk7vlxm50xqAlqG0mTl41TSIYgesnCMnbIccKcFQUQKmLM9scxX50XFVcja0F+/NSeLwdczFkEjARMWHyCTZiknOlMs99BbNOv/YwQbFU4W5o50tYTrWusi9XhfPo/i1VJhfmcmA2rWPEEvj/NWtYSQbz0H3npTGBYmuHId3uJWfITnheOqrNUho/eialVIl/uHBOxvJKuv5Uy3XVQ3L5q82Wf3wgdEl0cP39gU64O5/0Hoyco/oI6PyzIn/5FyXwn6Zgdjm0h7FGGB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 03:57:27.6073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec7f563-6886-44f6-a74e-08deab2396e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232
X-Rspamd-Queue-Id: E811A4D6070
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
	TAGGED_FROM(0.00)[bounces-284685-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

When polling for a devcmd completion it's possible for the driver to
timeout the command even if the dev_cmd has completed. This can cause
unexpected failures and device probe to fail. Fix this by reading
the dev_cmd's done bit one last time after breaking out of the poll
loop.

Fixes: fbfb8031533c ("ionic: Add hardware init and device commands")
Suggested-by: Neel Patel <neel.patel@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 91f89b9ff807..810cef0fec93 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -541,6 +541,10 @@ static int __ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds,
 	}
 	duration = jiffies - start_time;
 
+	/* one final check to prevent unexpected timeout */
+	if (!done)
+		done = ionic_dev_cmd_done(idev);
+
 	dev_dbg(ionic->dev, "DEVCMD %s (%d) done=%d took %ld secs (%ld jiffies)\n",
 		ionic_opcode_to_str(opcode), opcode,
 		done, duration / HZ, duration);
-- 
2.17.1


