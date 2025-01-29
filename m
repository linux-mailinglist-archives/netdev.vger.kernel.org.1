Return-Path: <netdev+bounces-161508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9586CA21DC1
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 14:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5D4168659
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5903914A4F9;
	Wed, 29 Jan 2025 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MKsG6nd3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90621A8F68
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156621; cv=fail; b=pCOxpeGaZGrZyZaWQDozPoptZhuLzl5AVD8PxD6qqjXxFil5mFp3WFyqIV5nHF6xk0rS7q2dl1uGbKNW6CtKTOzm1VZl7l3N/XJp6PF64D5kj2aOJQ2c8xxOkii5fhkd2sOnq5XUV0pee+/WZhDULpMXIECq4qJgZvL/DFzSeqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156621; c=relaxed/simple;
	bh=IZRJjXwChqAxsN/2T9NZ7RHg5Tmt2b+uXO4M+HYE8kQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKh6kpErZKnEEW/w7Vu6qKhI1M272DR950/cD+/KmZK2JPF1ExyVVAQiw4VdzRHOUg94On1t6IacLKsMAU1hxtCmmmmvl2SvfZSpnRF39HRx57mYW3grR+g+r2p7kVhZ14E/iKwKJSJQRSjrHnQSdzzhO0MG/CpSD78yIH6DxS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MKsG6nd3; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1EZBHrnLlq4BR3CFxRhrHig0jF9f7l4O5q7WrjOcQQOIZpEImRdNbGJAdhbRHGLQYpdzsEVEvHQRnrft0VDIrVvfho3M9WsQBDoeQU79nEbfZo6W1WyNDyjYze2bPUPXJo8kR75X/N3ADByngRifh+8DNMTNMVlMwMhfSSYC2EObSAHT5/seReufeS3hMEuDP9WtkZ1oaGH6cqd8waCvAimie0eD+UY3Hj3hJ4/wtEaBiCIFOB8g3pnBjf0sBhNZuEQyKcaHMo97jFeY0W428I3Vkh8VRHPeYdrsi0Di0ZmfeXh+S+5fMfYR76p24zn/CatDvW+88yLJrzbirPRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYwfgEaRU1NHuMgOq9ZNUXj1FwMbCqLYI9PU7w4nKaI=;
 b=rL9vl1zszkmYofbtI+z6DPTbSrB5nWtEYTOPSuGUDWxKes6T3fAY1Oyesnw1cjLh50XhZxXxLB+0ap3B5Ug0Sb1KG5uezxC6cvsLLLfSkhb0DBPHI1Mk2fk0KBT2K9S9QWFGbQxp5sD6q27BV86HEa8bHl9dAoHCsUluD8LPfV8imZ2mNwT02xevs8Oveismmh4zFGoR/JL3HOpf9H8VL8zrg9YjnWuyVpYMd3p16bd+hi2TNs7m3tqYIyLACigFQhJOhdtIwcq4pbVL+TZdxiIX70S54Ea8nvpetMAmFjfGZzw2MuDRiJ1biwQCClYqVsFnx7URMPmL95pqfkITZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYwfgEaRU1NHuMgOq9ZNUXj1FwMbCqLYI9PU7w4nKaI=;
 b=MKsG6nd3Bx1RbBlWiG8jaxGqb8ltKr7JOjh0YH0E7NmnI6VDNcJQSLB2iou+ubTSSse8QGSJ9KmgUJfXOTjshbHXw04VEgjqIxnRUg8pWGFUfxoN/mJY0Ff/MAEk+Ay0bXwijAdm6vZbtbsWtDwzixBGbC9sVP9D3U92sBddIK1UU41ms8rpukI7+WTncwc4k5ZAYj48gorUjGqN7HAC6MT1XAtTJga6Vdp4YZgjA0ukD2SRyAw/Q5H9PrhZlBpw9a/PmOQXaU49aOt7MEexbsf+8Aqlt/7V6DvzMvB/KKRmXsKlSYVWOUoEazE+A4g3IG8a8EtVjkmfaHw3vt4MUw==
Received: from SN6PR05CA0036.namprd05.prod.outlook.com (2603:10b6:805:de::49)
 by DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.23; Wed, 29 Jan 2025 13:16:54 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::7b) by SN6PR05CA0036.outlook.office365.com
 (2603:10b6:805:de::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Wed,
 29 Jan 2025 13:16:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 13:16:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 Jan
 2025 05:16:36 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 29 Jan 2025 05:16:34 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v2 14/14] ethtool: Add '-j' support to ethtool
Date: Wed, 29 Jan 2025 15:15:47 +0200
Message-ID: <20250129131547.964711-15-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250129131547.964711-1-danieller@nvidia.com>
References: <20250129131547.964711-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|DM4PR12MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ec4edc-e657-4156-637f-08dd4067338a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W+tqixgXIq8d06cIe5UPNpdb9Qojhy6a+cczRLqCEA8gLJychD0SlBDyL7r+?=
 =?us-ascii?Q?otmeVgySgsqbtrR+V5UE44gpK5syXs4XT/YRicGrOj3rLCqitftsFC4iok4s?=
 =?us-ascii?Q?1cg2Foo2G5b6Z257A2n9fca9q/pHlB+h9xketPi+EqEBBj4oidqRPhwkLoba?=
 =?us-ascii?Q?R1thm/KQV9Pu2eEtD+T6dnPdNhYT8tTU3w+YVkojDMwMih52LJUOZ1Q53z3Q?=
 =?us-ascii?Q?GfKv+0Nujt7tLnyAw6DmOZQkvvBwHuWRO+BVXmDKMz0LUwDz5YA3FrxuLs0J?=
 =?us-ascii?Q?9JhJ7DW83N4/d0vZM6hALCEMEukyfU3WRV/RNYcEHizziOBdYo4x5vjtjzDR?=
 =?us-ascii?Q?ADs4sbJ5r1nzAnA8qTJWwU8XK1zrlG2levcKEEVSmjqwPuD0NQOQXojUfMy8?=
 =?us-ascii?Q?gzsNW7JSAOyPiMEG/fX7OSrH98/Zi/EGPLkBO7jv8bOXOuJBhEeWy+0s+/bm?=
 =?us-ascii?Q?qUEHU2C2s1+a/15HS19eYtu6NZz6oIXjzjglV04s8o+0FHUw0vuywCqOH6qo?=
 =?us-ascii?Q?aX72xLnihmn/3WPkufDf60xcGMd3s6Xs1huGRjoBQF/UhT7JXfIwyQnkm0nO?=
 =?us-ascii?Q?/kzrQAEbHamMeDVmdOYOqXMEBPNaVHuWI15ge/3llKZ2H04x4D2fserDr95E?=
 =?us-ascii?Q?8QBAfqU1VtjQ+XRtdsAKO7TDRpoguT3BrNwc047txQx9mzVc3tJR18tDzd0Y?=
 =?us-ascii?Q?RhGfFLUtC5ocH6WWYyOcFtA/7Hr7fCf1PIRFCx3pqid/r4bRWy0usDT0JsIS?=
 =?us-ascii?Q?qoKB/3wrmUpGcBeWvYFa+oiwolN3wWeeQGPAu2hP7Rua9OM78gnUZYDD98sW?=
 =?us-ascii?Q?qy8cCzewLhIC0MHnCoFreo4F9M9gCVkCndVSOUSBpU5XT9yY/FRoqa0a7Mtk?=
 =?us-ascii?Q?yYrmsX8dCWORr6BZODsp0KtS4fTfihfmb3jGBJ0JG/Wz2R32UjyQkQgwSLJ/?=
 =?us-ascii?Q?PKZ2Gath2u40Avq1pkmjBm+faRBDWdDTmq+yuNu18m3rWh84QHVaRIa8AcMY?=
 =?us-ascii?Q?c7z5RvRKmBY0bkrcP3T0BxxyK3+YH1DCzA4HbDw3UrxCVcPKCTED1NrtwQ+2?=
 =?us-ascii?Q?sDIPZX36/XW6XIGmVF3ishCtnyjsnFMgqWFh9AqgGz/1U+dEjdkfdfXSHGW/?=
 =?us-ascii?Q?F28W4Z/nBWBp2QxwVmOtwkk370kq1VQgCoiKEYcPbUnSZcxp375ptr6tpLz7?=
 =?us-ascii?Q?zxQy7/L2JwZaMnXXxXRi3FckF+2k27AvxzMJDOz6KjRN1ldgFhhmAUCUnxMo?=
 =?us-ascii?Q?9OjgSg+8JTzkZMJA8Syy2baq5Jvtu3oZ4IO/Agd/NqZAay6cyTSz4y9TC84K?=
 =?us-ascii?Q?A0rnyHzPq6FFSyUQkO1XiQJG0+kf/0TEBTmNMVmbVczYooayeIHfo0wXAw0z?=
 =?us-ascii?Q?8IjitPaBwe7HAPl0J2Ly1uqKwij2UTsGhN+DlELrU27dgcyycYnLOB5xDX2M?=
 =?us-ascii?Q?lihSkufNEmIvi9Y6FErrmyI1fgD3ZhOK6nRBHITRK0neon1C2V0ImcuNxB95?=
 =?us-ascii?Q?rSiePs5Gdg4sePA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 13:16:54.5588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ec4edc-e657-4156-637f-08dd4067338a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135

Currently, only '--json' flag is supported for JSON output in the
ethtool commands.

Add support for the shorter '-j' flag also.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 ethtool.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index 8a81001..453058d 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6303,7 +6303,7 @@ static int show_usage(struct cmd_context *ctx __maybe_unused)
 	fprintf(stdout, "\n");
 	fprintf(stdout, "FLAGS:\n");
 	fprintf(stdout, "	--debug MASK	turn on debugging messages\n");
-	fprintf(stdout, "	--json		enable JSON output format (not supported by all commands)\n");
+	fprintf(stdout, "	-j|--json	enable JSON output format (not supported by all commands)\n");
 	fprintf(stdout, "	-I|--include-statistics		request device statistics related to the command (not supported by all commands)\n");
 
 	return 0;
@@ -6565,7 +6565,8 @@ int main(int argc, char **argp)
 			argc -= 1;
 			continue;
 		}
-		if (*argp && !strcmp(*argp, "--json")) {
+		if (*argp && (!strcmp(*argp, "--json") ||
+			      !strcmp(*argp, "-j"))) {
 			ctx.json = true;
 			argp += 1;
 			argc -= 1;
-- 
2.47.0


