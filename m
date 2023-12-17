Return-Path: <netdev+bounces-58328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF09815E30
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 09:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75974283C24
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 08:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138943C16;
	Sun, 17 Dec 2023 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eiXGRe3i"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605492599
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMuXK7UZ1RBZjwGlGT+bML3zGVvBukF6gw/nF3l/eTO6ZzFlPiPrDxSv1xukLCkpo3et8tTLyVaasWojNlQAKcz4Vftevjl6d5Yu813M6obrEGJR7sxLKOH+FIrnUQziTyXrrSVwfh4DDM3njCz0uKWeyYlBx2dkObJXH9fDeKm9IWowyKwTa5Jm/3Nm6AZfHe9Y7aSMNaKM7vHma0kJm1KFiuFawDZdrJIFZ95Vl0auTktY3Aaxc8pDtWHKtrR357F5e8oKrA7Mwb8s9iE6Uouvvr0OtOI++e/fq60Z62J99A5TsQ6B1G0/Kj8ZBckc76FuxrTtNpR8qMLDQaf5Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcEVtV/F3RfGxH/X5EnJ1YoZFVCNLwCDESA0ZUa/8S8=;
 b=P/5vp82tf4dqx5Iuil0Cz+9O1C4ybfTJpG4GCX6ppWuit0Du0B/4QkGx0KM7X/AA//0KR4H8Z9y0b4utjq4B8Btda36+z7wdqwGmjZsDRatB3pKKXruw7jyQ8HqC8NILEzggiI79N1kZsuFtw+wiCXqcqm5SJVWxTlzY+JcGATicgEt56nN4kGUnR3blwhy+qNVh4O5th2mkH6g4rdfJy9aeb8XcEjH1t7PrqrnoUM9mcwpTBEfU6F/H3SjbRrg4CpMRZt1EdbFuv9G7fNusAup4W9gYoq11oBFq2HTO+7WBlIgrAIMeGshuHL35OOa6aMhjNlpJEFnzPRc74zyFpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcEVtV/F3RfGxH/X5EnJ1YoZFVCNLwCDESA0ZUa/8S8=;
 b=eiXGRe3iC4vyTQva0AnmVYdYPpPNclw8yFstJO/MR7nKwqmSh5MHUUfCUU/inD38iZcBziMP5kNiP1J1PaZFoJNyP+PcRYsyGozsLloVjUCtkjJvkyLOA+ZgbGfrXJocnFIDpBb9eHjmz3XaX1ehtFxsbEocXS5mINH7VUAZcWCafRiwLCdHepNoQI3p+a8TOemMR4CRZh3vmwCDMK9NlfGIsbjahaqY1FicnMxnMcIHdjwEL3xK1kvzu0GrZgf2ZYs9fcR5syFBtsqjp0lZcegyrUKcxXVrrIUKY5zCeuumbFsdIknYlboUEMpJ3R91pulCbcrgFuJK9MOtmDuXgA==
Received: from DS7PR03CA0302.namprd03.prod.outlook.com (2603:10b6:8:2b::11) by
 IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 08:33:36 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::30) by DS7PR03CA0302.outlook.office365.com
 (2603:10b6:8:2b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37 via Frontend
 Transport; Sun, 17 Dec 2023 08:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Sun, 17 Dec 2023 08:33:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Dec
 2023 00:33:30 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 17 Dec 2023 00:33:27 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 4/9] rtnetlink: bridge: Invoke MDB bulk deletion when needed
Date: Sun, 17 Dec 2023 10:32:39 +0200
Message-ID: <20231217083244.4076193-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231217083244.4076193-1-idosch@nvidia.com>
References: <20231217083244.4076193-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e503e53-5906-4d7f-af61-08dbfedadc6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sPMkx9BwmAhkYT8PwEb26pJ+GcvReyF6bcMbXHk3Xf21NaKgItikbn8JLH+jaa3esThtwY8uEYU1UkjHTdzzqzULqwqAM2F3uw4FlIThVWac72gNmTQNBwuOGnNmexWl9VkWnP35wkFKgPxknm2SO19kO5fLaO3Nv9+wiv0ieYLvQskcIw3hAgiGzMmknkYZPD1gCe1csOKdFrXg140MNjiDPwbD2tlb0omIdPDKWGPOvsAbP1vAXJa7p/jLvDLwNGBXJNHP7vLVC4AJLvBdmkh/TxEzr2kHpo8/eo4zEwTvl4eRS0AZfpFy77g4W8TgHTgy3iVr3dHK6Dj88EsKziBI+NfEAHa7a7PQd+wO+5OPJNtq77qFwNWkCcfTC9ydJTulxp6SDo6C1bP7d3K6/m1/uEkBTUsC10J9odkhxB9z90eDqJL3aTNJX+O/m0WhEkWGHFqr6QpI1fhvyamc9euQOYTbkumCGX9QCl5UE3IWmtUhL7uJStYs+5OZasgNM/Yyc23Bq24wULn2WX3wg7TdOmyivsjigERUv/wcNBlphkvHi0bcHKGZY7D8Pb+fe4yIncBySAgmXLikzdgWmbO/GfxrBLFdOrsVbkSv7RggvgHLlEfF83HzqVnMozP8+F7id7uTpAjZIXTMwYLxnqhEhrcLiZZho21Lb60U8Iq7weQs/TmsyWtJrYUapiie6TCnQJrjO7E706MGk6irJuFysE8vHNmdmyXDUfjzimih5K2RvVbfR6yUg7DeA9Yz
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(36840700001)(40470700004)(46966006)(82740400003)(2906002)(40460700003)(356005)(4744005)(7636003)(36756003)(41300700001)(86362001)(70206006)(54906003)(70586007)(110136005)(316002)(426003)(336012)(83380400001)(6666004)(40480700001)(2616005)(107886003)(1076003)(478600001)(26005)(16526019)(36860700001)(5660300002)(4326008)(8676002)(8936002)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 08:33:35.5996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e503e53-5906-4d7f-af61-08dbfedadc6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589

Invoke the new MDB bulk deletion device operation when the 'NLM_F_BULK'
flag is set in the netlink message header.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 net/core/rtnetlink.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 30f030a672f2..349255151ad0 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6494,6 +6494,14 @@ static int rtnl_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EINVAL;
 	}
 
+	if (del_bulk) {
+		if (!dev->netdev_ops->ndo_mdb_del_bulk) {
+			NL_SET_ERR_MSG(extack, "Device does not support MDB bulk deletion");
+			return -EOPNOTSUPP;
+		}
+		return dev->netdev_ops->ndo_mdb_del_bulk(dev, tb, extack);
+	}
+
 	if (!dev->netdev_ops->ndo_mdb_del) {
 		NL_SET_ERR_MSG(extack, "Device does not support MDB operations");
 		return -EOPNOTSUPP;
-- 
2.40.1


