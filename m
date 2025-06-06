Return-Path: <netdev+bounces-195462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96474AD04E3
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 17:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96AF53B38D2
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975EE289E24;
	Fri,  6 Jun 2025 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="slq0ubxP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5E928981C
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749222480; cv=fail; b=RgbcW25hdJ/PpfBTkRJKZ0IyNBTbSrEY/5LxXCEWQAReM2DADVKLin+jLRTkWPXfFWUUGwePv0wkqliPTm9jnV2l+Ym3z1moxW/aemQAzFOKavdWRK46jA+Eh68R/DXcYPQrv6clHUC0obJE1r0OZYNDK6t0KEsreuQb3mYjFOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749222480; c=relaxed/simple;
	bh=czdquEtBqGTVc7KjAKzWy/On36BkPVZBOgxTzQSNUPo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQ1hHzGkKP161fPnqYuvZtTHkCwNK+CAl7cycJsWfMWC0OllTAGw7pM9MQFd5X6uNpsLKTUr3MFVdUezI9wEusKJbS1LpOm5jshjnzE7R4/Wl2NOza4O51vhl+Y3JxGP24EaJpiN+kVY0wWc8Fg6pu8J20C3HRmTsmhhuKmMGhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=slq0ubxP; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kn0YV1/KBwLGDcoADHBurUyY2N/YuGIuQFKK4VE2clP4mb0G1fxftvtep3TglyHdt6Ic0m536vjEiWnOqvh4QZN1SsPeKdIqphTBiiaAvbWs7MxO3+BEKQpcw6uCfUNeP0KVOfNe29gfA7sEfgAaRZP2QZ/x9B8SLV3aG8/1ZJIuV4bGxRGKV3GmipKEkGLjhuHZ8AjE5oeWc0787Irsx5RQF9FvBJyAT2XJe6mDb8UV1etBJUYOOXaHrhdDDpfL/A3lHQmVduXdssaFvHSu+edVPZogIQYdg2DgvnzkAMxNzvpvnFhI8hXkmxHQUiOPdnl5e7CvfZQqmC3RNroCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUk9QfT4gZ0Whf112argET/3V7I10fD1Qol1C2FOUpo=;
 b=b14jkgtmM0d45GEdtZPWHtS3MVEYZa/6HA5AKN4yhxaNUPAVZfq179coh1Lm0+zzr65RL+gDrMli/AXBXvCN6iteq1pDTUhGNF08i+YBSo4F4ddEf/JkLltmAIxFEBmKPaHr8MHU8n8UaeceVOBxGRqawV8khdPZEMQazCmxZLgeCl9IadkfRPFXi38z/GTolOGHXUoWbFpZW5EkWhKMK5c23+2IzP7NNyF/VMblBuGc42ffmkWPU/wt1teUN0Xe8Y7yIn7v0F/UQR8v5pcXDOlXGc1y5vldr44qdyMQU+GI3GkCmlUZYJiepgl0VyXKCrTYTkXazWykhNucZ02LHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUk9QfT4gZ0Whf112argET/3V7I10fD1Qol1C2FOUpo=;
 b=slq0ubxPp4ErDy7e5gCkal7x3fg2aN+kFuhAdOFJ8XGao3vlwJTsPuH7oT+Pl0NPfz2HNxXYjfHJrLiIii48mQNatsvn7LIvd2oSJVfN9j2OzBbsc/TQRkz97ra/AaUHNLpCp4YbuYczWqzQRvkXv0Zu1PDbtkORIg78r9dmyUURz0tVbVk7Kls5lwuckbDNnOfUHN1r9dZ0TQfb5mG4cfKugZIzdI6pINo0OKq8Ypk/u+1T2duEwv824dPjdi7LNwC/tTY9tlarU5EiMGugPkw7jR6BYFgAYJeyQmhcuDVcfnY2kv4zhmqYg0bFIzlsfBrv/8NkYgtFdSjKT34CgA==
Received: from PH7PR17CA0003.namprd17.prod.outlook.com (2603:10b6:510:324::23)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 6 Jun
 2025 15:07:55 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::4a) by PH7PR17CA0003.outlook.office365.com
 (2603:10b6:510:324::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.40 via Frontend Transport; Fri,
 6 Jun 2025 15:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 15:07:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Jun 2025
 08:07:38 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 6 Jun
 2025 08:07:35 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH iproute2-next 1/4] ip: ipstats: Iterate all xstats attributes
Date: Fri, 6 Jun 2025 17:04:50 +0200
Message-ID: <fc317232104be45d52cc2827e90f01a0676441c1.1749220201.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749220201.git.petrm@nvidia.com>
References: <cover.1749220201.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: fb884ed1-b0b9-4aad-cf53-08dda50bea51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LS9R16iEkVJi2Qsksp2z/LCsY9ONgw9zVkA51fuZwGG92Ce5oIIjVbo9I2fo?=
 =?us-ascii?Q?V3YG78VHJ6OQq5gNEvhkY+fkCddl6Ww/Yyg29Fvain0DoYz/RJappJHE4ETi?=
 =?us-ascii?Q?VKRY6rhSP/pFfoFDNDpbfPLUUalYsOhZmWb6Db9dQ9H3HK6DUgTr5596h6RN?=
 =?us-ascii?Q?54q+KV6z90n79jc22fPMv3iY9ZHvbko7IdOkW/keJmnkP0R7m9bWgXojAODU?=
 =?us-ascii?Q?oGAGEGyDLR3vrI9WC0t5MmgUD3fHphStFB+YDiMCM0HL/SYU5xie6xLhEu7D?=
 =?us-ascii?Q?eQYLF9jh3CnWaVvkWCDKmgBzMu89WjYtfzvEE5gTyToJBNopOyoboLyQn1T9?=
 =?us-ascii?Q?lh6wcWWttuIL/jO5mgQr6ZP1pRcrdbfvulM7RnPBFL6/YIgTHaGMP+wTUIjE?=
 =?us-ascii?Q?oNyVIEAvE+AdfWDv8vFNX2hCUES0KkOqhAWwOdMqrLsy/nGwic3dzSTQmByK?=
 =?us-ascii?Q?37vOuQtnrlnWAjoPseurtWWYdw/D5aeqjVBSYkyjId+TKeLD1L6bkqAFFMi+?=
 =?us-ascii?Q?zW3RJqPRPqXuF2vgmvW2cC0yz4oQajGXXodSOtI0/Zh1QjtRkLFuY6YXBZtA?=
 =?us-ascii?Q?IP4I56xQy1HlGQLce8aum0dFVgYVpsymAu5cFHbjMvgC81FYlVYe3kReHW4z?=
 =?us-ascii?Q?oJDeCZieo+8oOg1KYhfrZzq9oy8nfDt5wR5KCHaKCkV8Lnli2gDc5xotkFKN?=
 =?us-ascii?Q?R8YESjW6dROj0+CtayY8H7tx70JX7UY80np6cF+78ugkiU6RLvAx+3xCxkxY?=
 =?us-ascii?Q?D2wLojwyGwx9ZFaTO6EmOZfVj30z18lFezBcP3Duoe76mvsHL77loOmlbPlF?=
 =?us-ascii?Q?pO93I2MxnzMIU9OzJ4l2G44Ya4KNaw+1EKXBi6//F2FjizEJZ107s1Ab8QPV?=
 =?us-ascii?Q?XIGbWF7aiUtxkSVl766zMDIN9q4Ec2IrLrhhbs3bn9taeKN/yyK5ovP3rwhM?=
 =?us-ascii?Q?QXexQ3DIKhsesaRegMTXPpRiPVSOL5TmaN8RzEps1GtKImB2a2NK2lMFYZN6?=
 =?us-ascii?Q?mWM+MYLm21FdtDtAw/cuZun7383o8wV0WIlPMpy2ZZJlHjdiErWDWNxlhpi4?=
 =?us-ascii?Q?+MR+zEWIPUxrJoM4p/W7syymVSZPA6qspzhpB2UlZ0HHb/g/AgEXnxt1XpU1?=
 =?us-ascii?Q?tvsJGBw9yXVfiMVw3qCwZbcg2huAIU5D2fP1/595qNabCXIdy1HyA3o7YPaI?=
 =?us-ascii?Q?Ds25DQIdUaXeUhhIOSRtHDPpjJ8sUHE/6Cuoo3dBaYhjiHlFjq7rifCLFQKB?=
 =?us-ascii?Q?cNcFJKotXVmTi82yj8A4BihBo1mtM1cJJFVlheiyh5fG4B3MznLB1X9wRRVN?=
 =?us-ascii?Q?O2agb1K7q1VsNDr6zVzhXg+5wSMcdJcD+fKonFChvTf25uSU0xLLOxIJed+W?=
 =?us-ascii?Q?3ht6isUfXISiYJqSn7FxVg1gUJ8F4znvAtpjAHCwtXOD4te1OMHWsaRKuZG2?=
 =?us-ascii?Q?UyAZ3wYaSVqN+lFeTg1yiHoveCBT4qAnv9Dc7aoWbfDBmA4/PYVUq8N2Dz/W?=
 =?us-ascii?Q?Y2dBesDlUDsXswObR9KJ3Fr62CPaiF4C9Kx3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 15:07:54.9427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb884ed1-b0b9-4aad-cf53-08dda50bea51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342

ipstats_stat_desc_show_xstats() operates by first parsing the attribute
stream into a type-indexed table, and then accessing the right attribute.
But bridge VLAN stats are given as several BRIDGE_XSTATS_VLAN attributes,
one per VLAN. With the above approach to parsing, only one of these
attributes would be shown. Instead, iterate the stream of attributes and
call the show_cb for each one with a matching type.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 ip/ipstats.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/ip/ipstats.c b/ip/ipstats.c
index cb9d9cbb..6f7c59fd 100644
--- a/ip/ipstats.c
+++ b/ip/ipstats.c
@@ -590,7 +590,8 @@ int ipstats_stat_desc_show_xstats(struct ipstats_stat_show_attrs *attrs,
 {
 	struct ipstats_stat_desc_xstats *xdesc;
 	const struct rtattr *at;
-	struct rtattr **tb;
+	const struct rtattr *i;
+	int rem;
 	int err;
 
 	xdesc = container_of(desc, struct ipstats_stat_desc_xstats, desc);
@@ -600,15 +601,14 @@ int ipstats_stat_desc_show_xstats(struct ipstats_stat_show_attrs *attrs,
 	if (at == NULL)
 		return err;
 
-	tb = alloca(sizeof(*tb) * (xdesc->inner_max + 1));
-	err = parse_rtattr_nested(tb, xdesc->inner_max, at);
-	if (err != 0)
-		return err;
-
-	if (tb[xdesc->inner_at] != NULL) {
-		print_nl();
-		xdesc->show_cb(tb[xdesc->inner_at]);
+	rem = RTA_PAYLOAD(at);
+	for (i = RTA_DATA(at); RTA_OK(i, rem); i = RTA_NEXT(i, rem)) {
+		if (i->rta_type == xdesc->inner_at) {
+			print_nl();
+			xdesc->show_cb(i);
+		}
 	}
+
 	return 0;
 }
 
-- 
2.49.0


