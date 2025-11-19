Return-Path: <netdev+bounces-240089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DFCC70615
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9681F384676
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE0E30101B;
	Wed, 19 Nov 2025 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RfIsNGku"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D144303CA2
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571622; cv=fail; b=UOHze/2ZpYD8UW+42Kd2kGV+JwNz6ajZjaMND9QCINBDSeHLI/WZ1uxuzE0yYV2OfqznacchXa9/CLnh6t6vcfEAY3UNs0fwQtepLw2+X+UHrxYNg+r8clXU9dM5a8GLFp+mGsuA+W0RnbSGoLWbKN3xLVLoIUyxjkBtr1/fMVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571622; c=relaxed/simple;
	bh=DaUzKUXkQjeHScskRvVEIin4DV5kbnEhm6Nj0HpZidk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hv6HvISb4N96oyczikeo6tkbe0uQZxFusrmgZMZen9dL3n7PGwbqItBnT/9DzMXm/auKm6eZ9DFzN6XtC5kPGDOndxGBoecLVXY9XN/hTBf7V3S7vSHI6APK6marLfPZRVnBXj6Gu9NazUnedKrkTo/PDbOnDJiFTFLYx3sKrmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RfIsNGku; arc=fail smtp.client-ip=52.101.53.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDzShaoVRFhfeKToYHVj4MUyQjSfLtmiSbByKvdBJT8dyfGUMhrz0OYO3TrCWPMUh2QHONPeFd3m2mLM4cr8OLvTDOrSffb4eNXuGnStOAepG0WENI+2WE0T0G/mBi/QzgaTi7l08MXuV1eqb5UyY/hmkiFx7OveQvu11PNLL1hllLENdg37dOx1yc9YOwQfAr4LzdGUo9QZ7POAPCs9LulNYRcBcmUskMj9PayfplafAUGXHHIe6IIxoYualGp2KCV+GhQ44Th32EQORun9ws7vC9ow8if+MEi6AlaqwnBk6k4cpC+MdvbiuAZCYG+Q4yNIq25vYnJMkI3ngMSXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKQ9YQPB4oPQXJGNpoWAkIASvGBTwWZXozEsCyI53B8=;
 b=mkd0z9piYqrBG6OL1T0aAIYD7f/U+wwv34TOeZeIqpM63YHrWTfMYUtZ0HqdzRXtDRyQBDdaeNqLV2/T2r2xTkLoFZJfN6Wz2kIoSrQnD9rFkemO4wEJaeDS+lt7VWu7s8lfXegW3/JbCg79XFqZKaYP0HdlyQRavDjsSSBxMt8TQ78M/MqyVktQLSbDHwOv4omqrmtCokYfLumvU+fzg1BIp0X31tXOYPvpcsdEiX+dY+o4K23MHxtCAB3hfEkLc6zWOyTkFAteQUtZ8FC/BMuRFM41isach9K1ihsWe0wUTUjJG6Zu9vv0PcoKXs8DAQf5vN9odrAW5MHwvPGuBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKQ9YQPB4oPQXJGNpoWAkIASvGBTwWZXozEsCyI53B8=;
 b=RfIsNGkuIn3pA1irpxGgQ9M7rjuLZJKSAnDPv71pdQxrvScoobh14klPK18CkAHZvI6Z1KLEjjD1NtTakUQ+blERSX+9taWC9a6bhowuhljCRhlJ2XeGHgMHVMBsVs4by6jB1WqXfH113ACpxSXYviPbLrk8YQs92nwkv9VqYFnJmDpzsWfSedxz5D3BfmGWPj0LjoZrujdJGEOWvZYXhP4aLXE70a5K68kh7hfjWaCEHCjg0dguJoPIu8+ATJIKlo9ykQ+kdogooVozMGQaUhTw1xdCpDH0WeBwinsPnMAL6HztP597dJbGN5CPa1sS1MUE+1wDhBbtGMo3DnKjkw==
Received: from SA1P222CA0154.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::27)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Wed, 19 Nov
 2025 17:00:12 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::80) by SA1P222CA0154.outlook.office365.com
 (2603:10b6:806:3c3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 17:00:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 17:00:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 08:59:55 -0800
Received: from sw-mtx-036.mtx.nbulabs.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 19 Nov 2025 08:59:53 -0800
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next v1] devlink: Notify eswitch mode changes to devlink monitor
Date: Wed, 19 Nov 2025 18:59:36 +0200
Message-ID: <20251119165936.9061-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 299e2d18-7caf-4d1a-3d6d-08de278d1a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GG9W9eSnh2oDrQuOTF/Dbwtlmb81+1MdsVY/Xbeid4q5prh6FcnQJBjCpqaF?=
 =?us-ascii?Q?1k0ADud8xHOe6eRpTwGOcKDO2WCF9Fcvg7JhRCm7uXJjbGjA5cp7salUMH6h?=
 =?us-ascii?Q?Yt/lbxCEjGA3BJNg7d2exYVQkbYorRLv/bQW8UequDf3stz0C5DeX22FUllZ?=
 =?us-ascii?Q?XUMpq1dAyFrLTdFpqkOStaTfEJ5Jw5hSNGn3mbHJJb40KKGqF+U37Qrfuvn5?=
 =?us-ascii?Q?bohIC2A+3/piFCPH8aYvVsM42Qizf+Mv891nXzbuS+2B6pAbypWM4dLis4l/?=
 =?us-ascii?Q?2sdFNvpLduhzuk+3l3P812aNt1i1v/xkEBnf98O/iIxClqEt52Rr3uBOxtdK?=
 =?us-ascii?Q?oCFscklTswwsnfr/QrVgDcMU3Iq0rQmPb+tmwx1WExOQis2QOcVfKo73Vxfp?=
 =?us-ascii?Q?7N0+hg25H6AHbdk5SUN6vClHd4s0DQFSEes7JVymclV1Nq71TJAfxfirUmL7?=
 =?us-ascii?Q?rK+k1caP7Pi1XWD5pKJ4nFXLTq09O0ycXpwTH1zT72Vl7HAghe3OP/4J8vD6?=
 =?us-ascii?Q?9bmfHFs5TT2YRkmJwoPKILG2Al2ajN2CmK1htQ6NpkUrQSxXkE54JEaiiGGx?=
 =?us-ascii?Q?VIX7VsPnVKys38Be97bi0RxSmUoz+VlaolT155MwDZcUdT717npPkkt96ZHP?=
 =?us-ascii?Q?iLWdkPBw6Bt+bg5nc+xAjX+EBgspbB4YmCXau0JRWBIk4QxysjMgcxuiug8a?=
 =?us-ascii?Q?tx5xABm0rIHkUHBeQVLZXJk1AlUxngVLPXrSzt5hCvD9vH21iz+TcrkwY0XE?=
 =?us-ascii?Q?0yn99krRL4E+NOT0qbXPygBUJbM4HAXsRCArxxJ5IJme2NSjE+9RWvT0Tngc?=
 =?us-ascii?Q?93uMDAr/Ed4FkeCSqGjvrqarGdBOYMYdhxc9BXnwdPIi4U8Qudw/ZOUY0+G1?=
 =?us-ascii?Q?aegskIFUim+/R757YK0rlNVB3q6/XNYEcrKCckXEHGSG+Y0TnMxZtEAUblrJ?=
 =?us-ascii?Q?wIWWf3X+rj5NHRdtAaL+AmEWg/ai6DSU6jzuqrknRarF95itjuHWrD/LBcjQ?=
 =?us-ascii?Q?DrSm/agJfp2V+k+Aa6Gr4ACm71LMvFnvJCIRcHjImBx1Y5WgUl+kSSr9PxoC?=
 =?us-ascii?Q?8HzKGgiB6H7x1EAjkcfsPA4nxQNz+hkZZ3oCJgmuY2FDobtDgaAiV4nvQj3u?=
 =?us-ascii?Q?cGjXL3PebtXq+OlDxaBWoCRDkqFao6FdctIgsXRQcaWm+zJVBbqv0FQYTay3?=
 =?us-ascii?Q?FRa+PAurNB4WgagTMT0OHd64uF8NHrC16Jp7TOtsLjY44zWg8F23PTk5sIXQ?=
 =?us-ascii?Q?wj9D86leS8UJMbF+OSC4ScrEITUjO5EtY8DcIsB3d/RkQVQlrDbRPPbMyVH1?=
 =?us-ascii?Q?A3oL8qMI7H3E4gaDBO/xvsCBjaTweL7wiBVd3hASzhuUrbwNr7WGMXEl7fTb?=
 =?us-ascii?Q?4OYDXzMdul1TO0pKbdCwUFZ0Qq967WLBwBi/aGf7EOYXIlAW9fi23zkqC89Y?=
 =?us-ascii?Q?fIg3nujrXhtMM1JV/NykYaURhvDsUb0n2iBaY9A7iA8c65mJdr575ozD4lrA?=
 =?us-ascii?Q?Y7Rynq8Lxhci3eSAEGQyYUwGfNl4TbAP8Z1pes2qzvcw2En2hkEoJj/PZq6V?=
 =?us-ascii?Q?q4/bcnS48zKhLqdqJS4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 17:00:11.9390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 299e2d18-7caf-4d1a-3d6d-08de278d1a73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084

When eswitch mode changes, notify such change to the
devlink monitoring process.

After this notification, a devlink monitoring process
can see following output:

$ devlink mon
[eswitch,get] pci/0000:06:00.0: mode switchdev inline-mode none encap-mode basic
[eswitch,get] pci/0000:06:00.0: mode legacy inline-mode none encap-mode basic

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v0->v1:
- addressed comment from Jakub
- fixed cmd action from SET to GET to match the usual get command
  with other responses
---
 net/devlink/dev.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 02602704bdea..d0d77e6689c2 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -701,6 +701,30 @@ int devlink_nl_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return genlmsg_reply(msg, info);
 }
 
+static void devlink_eswitch_notify(struct devlink *devlink)
+{
+	struct sk_buff *msg;
+	int err;
+
+	WARN_ON(!devl_is_registered(devlink));
+
+	if (!devlink_nl_notify_need(devlink))
+		return;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	err = devlink_nl_eswitch_fill(msg, devlink, DEVLINK_CMD_ESWITCH_GET,
+				      0, 0, 0);
+	if (err) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	devlink_nl_notify_send(devlink, msg);
+}
+
 int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
@@ -742,6 +766,7 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 			return err;
 	}
 
+	devlink_eswitch_notify(devlink);
 	return 0;
 }
 
-- 
2.26.2


