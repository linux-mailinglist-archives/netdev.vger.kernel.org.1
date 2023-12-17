Return-Path: <netdev+bounces-58331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC8B815E37
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 09:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC11EB2109B
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 08:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC872109;
	Sun, 17 Dec 2023 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L8w47rw6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5012420EB
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+Ai2Tk83E3xah16MP8h0CvnNIshucWHxpmtChlPKQQsplPbl+2OEaCNf3npkG2x37GJ13EbFMZIpmwWeZtWT3IQRma3p1J6Wy2IZCOoDGP0DKWrCF3NJFE+RWFJsMhgoihweEK1GpjUQvmWDUN4ipgiyVHEUFZS/ABL4nNueb6SKhoGaJBSck0i/zkQA1c1pXpv1Metqn9ZZhV56+Ku+oQP6DKR4KwHdKDeSnOj2yfh6nELklX+91kZvsj0aPl/pOweJM+e8dqUF6IQoOU6VOwIWrTXTsoObat6faPipmGC8iEaGiaqQW5q2hfzcH5feWf1a3uWF85a5y338Arp/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORTV6P64Lhcs0pkZNCixlRDGS/NUkaFHrsgieOuSgao=;
 b=UZuQ9t4n/y5KTNAIWXhu7kZF9kQTumVOQrJRop/sR2g0y6uBPx6QXS9gkrfb9oJk6uZBeNgfBrOht7osGpcWV408QTC5oC388FZBgE1BD6TE8d1A2KmcTGC+UPjeoG0PC0KHdf3ycOYE2gRQsUCPEXIJ7FV6qC9JRxsdZmhTTd8IzOTo3DYX056be3tO924DbacdpRS73pKUVGsjk9B0XyqicN9RD0VOj3z2TYTwaf9g2k5BHeQ8mXMRLI5oZoNyvkqnBRN30LeUitJOyYHBex+desAf3kef2yQ/dcUV/gwrcoIPa8BBsMAPTnDTXSQF4urlKqyyBzVpMr8xwRqGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORTV6P64Lhcs0pkZNCixlRDGS/NUkaFHrsgieOuSgao=;
 b=L8w47rw6sZM1Z7vTMgLTvb8y1SC1at2t/aZh0rSvLDdDGlb8YggjKICsxZaD1rhoKkssKYBWgxh69aTKkmP7D+/9wJcrk5heRuYFZWbrZ8+J/WHeYYPbWs7tjbvxDLpW5nDrnJWvNTzF7wGfwa+cuOx3Nik831OHvHeeY0Qrdg9B6aBD0KJ84/bRgjjO8DH5c4fmiI1Lt3OUov9sZrgpnv9c17wzNtLznSOWvFiUTVIpFi9OxRCrimpOVKHJuiTvgNAS43tIYWpT3201ejgb9I9l6YCcuIuxN7RzOolk5JKvVB/eF8/wNXyUHz8DhkK2aXglP7WiNfuZVRS3zpqlRw==
Received: from DM6PR21CA0014.namprd21.prod.outlook.com (2603:10b6:5:174::24)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 08:33:49 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::ec) by DM6PR21CA0014.outlook.office365.com
 (2603:10b6:5:174::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.43 via Frontend
 Transport; Sun, 17 Dec 2023 08:33:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Sun, 17 Dec 2023 08:33:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Dec
 2023 00:33:39 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 17 Dec 2023 00:33:36 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 7/9] rtnetlink: bridge: Enable MDB bulk deletion
Date: Sun, 17 Dec 2023 10:32:42 +0200
Message-ID: <20231217083244.4076193-8-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 53fd4faa-c611-45c1-feb6-08dbfedae437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QVuyf+SI57A8J9KNC9N4BcrEnC+uWUXYCnRQmZnW0JI5t+0pRpdocHbAOAlwoVfYOZi1TizD5vebEgSiPMc3CYf1Fuj1War2mBAHaJ8Xy6m/LhkG4h5jAdIUh43MiVX+manEQtEXQbuuM12CotiYFmWx/+p602sOjLlbiNACqBXQiKuP11gTokLIkGpJ5pRKzSLWhrXevJQ5rvPxPPlG58yJD1kEhLK6J+PJvt1KlHXSh14rORNEO2Ersphwnuzjwt7d/oYJTc0cpOQ00gXxHEjIVrP022NisvQwnpRyvfvn+6+QvcR7k/ODqnq9Te3Ew+hA7ExIK53bk3RwfSvw1HAk+c52a2QhEjXl/P9Ezn4qE+vzqfjVl+TX95Q42/UO9wGziAX+4uHUBjSVyoEicD9lvs0BWYNd6wchv9UPrGOUAlOiLnDAJNro5/jPY+qSzVeZJmSC2Y+U+o1bryf+d1Lyq5sSvJsLODj6pb4BVhpRiAmcUmd9iWYdLLC1plu4qFhq7OBnTWGm7dvIHC0BXVpw8lBh2z//EKMAc6Aq2b92fiFhS8EDyZF2xcYy5A8AScOsd/uMtY+kP7BY66OplDcExrqkljQ0dxz0c0RR4G5buZXd6A9efrFyTAP7JHChZx5ylkZA5agkxuMtOe170eBHzA5a1mBd/NJLA/5EGrJNhBR7EgpDpZicRQLjB2ldw4GFuFuve/dKSDrqpQy8fClWsaKxcM1VY+cCjW0ZQ3dpsGkDiQ4bBnYaLoFR9QH3
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(40470700004)(46966006)(36840700001)(16526019)(107886003)(1076003)(2616005)(336012)(26005)(6666004)(426003)(36860700001)(83380400001)(47076005)(478600001)(5660300002)(2906002)(4744005)(8676002)(8936002)(4326008)(110136005)(70206006)(54906003)(316002)(70586007)(41300700001)(7636003)(356005)(82740400003)(36756003)(86362001)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 08:33:48.6695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fd4faa-c611-45c1-feb6-08dbfedae437
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878

Now that both the common code as well as individual drivers support MDB
bulk deletion, allow user space to make such requests.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 net/core/rtnetlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 349255151ad0..33f1e8d8e842 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6747,5 +6747,6 @@ void __init rtnetlink_init(void)
 
 	rtnl_register(PF_BRIDGE, RTM_GETMDB, rtnl_mdb_get, rtnl_mdb_dump, 0);
 	rtnl_register(PF_BRIDGE, RTM_NEWMDB, rtnl_mdb_add, NULL, 0);
-	rtnl_register(PF_BRIDGE, RTM_DELMDB, rtnl_mdb_del, NULL, 0);
+	rtnl_register(PF_BRIDGE, RTM_DELMDB, rtnl_mdb_del, NULL,
+		      RTNL_FLAG_BULK_DEL_SUPPORTED);
 }
-- 
2.40.1


