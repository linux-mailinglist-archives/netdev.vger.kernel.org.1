Return-Path: <netdev+bounces-78733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD7D8764A1
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368C81F2298E
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F291F61C;
	Fri,  8 Mar 2024 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j+co84vl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AD61D52B
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902965; cv=fail; b=I3uIICLaNnE5D3C6jiVl7IND4R/D9d4Zd/vgW3MYNANev8kt1iwBokgZcfHHTDslPO5x81NQuq37d+4zQjsVWF5RWQJPSZ48Y3SkBI6oglyfSVI3hoV19ShbhV6hPXwJ/32mkPLBHH5s36WUBjC0by/wZEyZPjY043v2bu5Fbb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902965; c=relaxed/simple;
	bh=i/zLVAjd+HIIUnIHAKKYbe9G8RroMajIYOAwe2trn64=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0jmdUH6WJ3EBmY4IBH7mNPtnEbUfAaXHP7jxeKf2x9xJ5SFr4B9QfwEmP697umKDVYU/5vfGzeDhVY1bKJjxCQc1LMgrMYeKyygU9LR+yqz5C+eAXEkBp4lrc8s7Krj0BawprYjqCheIVf5bG5qMRqZjQHyLatTdMy/jI+U6ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j+co84vl; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrNPqg8Nf+uP6SzFLzxSKcdjwW4U63La41afJ8XJHYWXZo3njGllPe5zEheleaNaxFP0VDu0tIOtFd3KfS/BmDCFbpQWNkU51WdtoRbVaTIkY7TP6A+lqTQDlZGBjLgZxR/ZIemd7JsA9N24L9eMT7htBo/S1OfvIrs2hZ1CszTCKk2lHphYXIj1w2Cj+hsulhgwW/p6Ib/jcA7HPmMqMSML62YutOPTjknP7GKyweq8fR+Ng6yA0sNKLFOhyCIgwzh2V1VeQKOX7QRHya/cKXCj/0cKdR4yq6ckMOT8/xcCFW9uXfDp9U0k31euHA0wDkXrj7s5RQuVnfZKx4vaqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFw7jw7ZrThWZUex5cp7RA0Vpi5zHOOtr0jlqf+H0B4=;
 b=SblbmWvqwZoX5cdp8D+YrLUUbCvNCwyzgu1SAz2zGw/sY8imvcPa0c8GpgvcVzu1tlbt6UoNxRNa6Cu5B4kmPggEfMpGjDbKnmXzdsRLPElsABnijqj7sYHlvWR4vnTKPwn+wXYF2a2w25W3x5UVD/+whXm/J1JBRUzkqYf/4NBkIXm7WFUuIT5hJke8GjtVALavSG2JIjVxziJJqDif1mRZEEoSJThG6/eS3uSGkKKUOHtwwQHavWUcFTiwcOrgTlD+O+9s4gogm/OkBPV8d9nws28FBI3SlAWHZ+nAwyGsM4epg3YZT/oB3w+iHq2PGh7ivUUJS/jYDAUOPOxOsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFw7jw7ZrThWZUex5cp7RA0Vpi5zHOOtr0jlqf+H0B4=;
 b=j+co84vlyQXQYVCSvarkzTgar5qc6ZdX9eLC9NbrAevl/MOB1SiP5ri3mjYP8BIKEXFc8SZbfQL8mFHJei8OMHdcSzxyMjPwe/yGt3lDFseSRcczYUUmptPyigSapic0hwVJWuRWoH8DvuYyFTXugGkoOH94P65CrDGWLWpU9/rJvMcUC4RHOIkGf9DfmCIaaaK7gzv9gSmxclmIH0FG4YWFissXmxY3a7iTf+DaXJAPHQerju7aWl1HUPKbjJF0yFZPTBB4F8Y+lyUGbeddNkvjLuHr2c8nxCs26Wfshycm7VMAuhEfBMhLLtYGEJvL5TEXpQYQKFG6TON9VdY7tQ==
Received: from DS7PR03CA0089.namprd03.prod.outlook.com (2603:10b6:5:3bb::34)
 by PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 13:02:40 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::8f) by DS7PR03CA0089.outlook.office365.com
 (2603:10b6:5:3bb::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29 via Frontend
 Transport; Fri, 8 Mar 2024 13:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Fri, 8 Mar 2024 13:02:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 05:02:22 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 8 Mar
 2024 05:02:18 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 01/11] net: nexthop: Initialize NH group ID in resilient NH group notifiers
Date: Fri, 8 Mar 2024 13:59:45 +0100
Message-ID: <025fef095dcfb408042568bb5439da014d47239e.1709901020.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709901020.git.petrm@nvidia.com>
References: <cover.1709901020.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|PH7PR12MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: 071b823d-77b6-49b7-322c-08dc3f7008e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZYv5TR9wOKEdqnYUKpBUkHAyRrs3nUV/VPxCbRzx+5+kF98ptdzdv1XNKkPPcWDvgDf0AJxJO21I0w4Ln38ItMa6aWq+fviyODyv1PknVTPHg4QSQOmLgoosZSaeqism58p/XuP267k1RYZswEj6EVAa6o+zEA3fzDpt3uTrDgRMWEM0UMpDYg9dqFNtQIgSIgweZm4woEVu5E8djOBetmbZPDe2HUaS7mu5SWzkvphhEicGm/RtRaTEWcKCYuAFh1UnU4oZl5iLvMp0fhiFopGAY5J2Fmhui8vcR7pfjfOKFPAf0EU8hVYWYdCt9h/OgGKr0T9YE1rLv2G+GCGwLdpOLFuvAefdVOOIJG9YZ6TyjkL2BVRBkQg++HVFpVscQpzHmIHljI/LnQKL6ii7lYkEpC54B+T4CHIS7rUzvRt61fk8TNYfwvzOMZUNRy2YEh20XjuE/WkpeuVTUfc/SXn53kMWhC2iwNmOGHIfgkhK941mw9vy0Rz/6/P5MJ7yVIRNQFwn61wNXzbADQzHhgjsfZ4PjOBvD415LWff2yEEIIy850vdcR5Oc1Ean4OGpMDSOT211bIEPsaYD08npjonEdFUzOx3q7iITkm/kezmB6FzCUN+zBpFUrcZTeiUWvHer6ZDK+rjHy0+eHZiP9MlkDHByhE7muAxDOtqtUaSIx9yDx94XHyDdXFlMbA2Le/lMp2MJ/GxaMAlR3p4zMc6X5Vf4CO375TA9vbbQQiLofVxZ0gGzrTEWnIhnJph
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:02:39.6396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 071b823d-77b6-49b7-322c-08dc3f7008e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6538

The NEXTHOP_EVENT_RES_TABLE_PRE_REPLACE notifier currently keeps the group
ID unset. That makes it impossible to look up the group for which the
notifier is intended. This is not an issue at the moment, because the only
client is netdevsim, and that just so that it veto replacements, which is a
static property not tied to a particular group. But for any practical use,
the ID is necessary. Set it.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/nexthop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index e34466751d7b..0548d1b46708 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -407,6 +407,7 @@ static int call_nexthop_res_table_notifiers(struct net *net, struct nexthop *nh,
 	struct nh_notifier_info info = {
 		.net = net,
 		.extack = extack,
+		.id = nh->id,
 	};
 	struct nh_group *nhg;
 	int err;
-- 
2.43.0


