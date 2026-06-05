Return-Path: <netdev+bounces-295487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V4wNMYwUImolSQEAu9opvQ
	(envelope-from <netdev+bounces-295487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:13:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3646F644179
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:13:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=sr4R6pAx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295487-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295487-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3375B3007668
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 00:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA12422339;
	Fri,  5 Jun 2026 00:12:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863263BBFC4
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 00:12:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780618376; cv=fail; b=U8+XQZVj1Yitrt+x5aqB9FRTbdLl2DTG+BehPlT9f80+d28t5L2n6214s2YlXS2eIRX2cNk7tdDbsj3xOVcIwNX6sdb7TS5U/NWUbXBwONLDrivRjcRO3vuyWA0KTU3B3mT0QQ8FRYZX6rtiYLCPpz7hQevC3+FdI/JhjsYDAlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780618376; c=relaxed/simple;
	bh=cCedtJ0qn8UtABG8DDCGsNyiYeMZGOoMDktQBDaigXs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cfv0kHxi3O5AJsSQQjd2hpF/ouVKWonX7blVkgEvGr21KFnWFZNJvL4NQeydb59i1yKqJFBVcyiX76oBDWnjDgJDEVHYulubyDE1BbnWY5K9mTEsaOWn+cewDoHhbJP+SMaIsoKLjkhuMe6iqnpHgsyGsmkBWSJQdVZO4vB2aPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sr4R6pAx; arc=fail smtp.client-ip=40.107.209.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvcupkpyboXOzeCfA2IIkwDqUPAPtOnklpqZMtJtfyMAHGunsPqpgQcrvs1Kadvqy6Kj1pCE/Y2UgsYdEVdQR0kI/JX0sIy3HLohyx4zd+UoOpP5tkcJvg9M4RjXu7CrCI/ZU4fM1+eEjZ2HJbdPIi/lRZcGURHHKzj65sDiqqrLzNaBNOeC8CHdrf9HN8eyNlyETdybLiAvbLUrZNZWTWeX0ogjNfEMvXKovKerNKf2QliRDl6HanCjNF/bWlIVDjy5Y/PAsjB4TawzcT9wETIGxqmUeipI/9M58bPFv8IBJTqLztgk9Tj4op055ome9bGVqG2wmakjvNvkDr7SWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ni026xIqlSKzWPfBlwj0CLXDx1hjwwbvPXTEyO+++U=;
 b=c1TYtRvULcvXi/lxlaLeAeUvPwVW9tnpsW5xHbtHfz3ZiWrRyNzhdoj9Su3Rc9FknL3f4qoAmCpUunrMVcdRa8PnfdZgGe9r4xwm8ZT0im8vF0aao1A/Vs0j8t8o/HU8rrCaLopmlRgWnHtHxCVch2X31gDicfTaK54ft0/PnKvd4apZBTj1hQooQa0qYgIt8kzZnj0Tso1rx1f1gmNysyrTXjGeFSylOgpILlyPnGpRWH9Sb5+dRpLB1mVHrLoScxlLE4Gy7qaTMdht5/bU7K6aJwJLdFEGntOMdKz4FG4Yf6yFT4kNfx4zgUHI28zRf5hsYk0ZSzfJT0M6O3nd+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ni026xIqlSKzWPfBlwj0CLXDx1hjwwbvPXTEyO+++U=;
 b=sr4R6pAxY0nuSL6N8qc2zOWK7t1kw47LlV03zdE9HnKwBd735er6xSEcs3nr5T6RcHXlEBmX6wvDADb5cQ8ETB1gt+iiygcOZjW7gwZTgjCwrOqybOVAV3cSrhp+QbulRIi0rIEk8CAwYDewJcyWHmtPEmXFcEOFSdkDqC/25wE=
Received: from BYAPR21CA0027.namprd21.prod.outlook.com (2603:10b6:a03:114::37)
 by SA1PR12MB9492.namprd12.prod.outlook.com (2603:10b6:806:459::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 00:12:51 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:114:cafe::2) by BYAPR21CA0027.outlook.office365.com
 (2603:10b6:a03:114::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 00:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 00:12:50 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 19:12:49 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Jakub Kicinski <kuba@kernel.org>,
	Michal Kubecek <mkubecek@suse.cz>, Eric Joyner <eric.joyner@amd.com>, "Jacob
 Keller" <jacob.e.keller@intel.com>, Nikhil Rao <nikhil.rao@amd.com>
Subject: [PATCH ethtool] netlink: fec: Add missing newlines in FEC statistics output
Date: Thu, 4 Jun 2026 17:12:37 -0700
Message-ID: <20260605001237.11708-1-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|SA1PR12MB9492:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e8196f-9644-4e72-ae47-08dec2972e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	fnPpH47GhdGF3Z2CFPeBaLSX4mZA0rZtx81upSaFF1FOB5CaoU9v+m0zIask1b3fmKWuyhy1nIGhbVG34kgin4Sujm+8+G6oNMSHQ3kZ/oloOr2dsVSQz1jAvLeqfUYjCOjqM6QXCzouYX4Lp8494Qcyx/ZVZqsPU94R+u3mqVuEwqfVFuKvXkHKxYOdE8Nh3fuIxn2j65pZjgIP5YOKSJdFzb5iradQAHTnVgZqkMvygWCzGjR0CntsazizO/UNLbj3Dmcm6Ob1Q3XkWg5roD2Umx+bzOlMcsAPdvCMo2vj2u3AuebAvZ828vdulsB4GsyGVXWQiOCh8SbunOu+v3IHA88S9TTKK74lKltRvOOPH+BbCq/U3xYHn4jw8mhj8uUMxaPwu4EaBYrhiiZjDGr5rjheDnisDfqx97R5zNd63cobD0sThHnVBTBt7ijNS8G66wHYSQdbYWBENbxF2JJsRilhSVkY+a0WMeAMkjepXSK88I0fTZFb3jyoVpAhqDYiNl6ggmH3+TYq+/2G06yKLKtaMXKBXCNco//k5sG5XChiCVpP0mHg6OHnIPge3ZRKsTG+tYZU2R1GvRRNDfQIsWSCd6J2IIcTwwtG+Q7jwjVuIK1jdraV+qslG28yk84maRIAdwUSfxEnB5S9F7jvpS5imPXE5t+Ntcn/eEONpGubtdfGBqXNbFQGPQojeOaUH7IvW6OAqhR/X1IIuWTnqzmyuZEpQJbQ1H0BLrY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nLyYfiKyvpwAS7APayAqfvKGCw9cHA6WFdnNPE3Saf17bYGlKS/cZteX2a9osAI/So7pMw08MqyZLn/TI+thmEAKHQCN1o12YQpuTSJWGdIKsWDf8Qz+P8YDFsO0Sxdmqtfy2lXvv1EcJcFbxtP/Da4EqCHTm/JCEAX9lSy1lhRDBYu8Ym5sZCQ2sp7SW34Lfyoqy9fKi1V8xUBB30ynd91sxZf+YddyhOcoMffQEjqucC/BOhgebKwq7Pc31LHHBl3Iu2PAELcEWvfSUn+XEcysmYR+jaijmiPreFSwBk2iyOddHEgjzVBvEROuLrKEqrkCNnLBNpYLvuBgMy99GfnEDcAAcJat4oHDkN44KuyNhs3uNSlwl2KxVif6fgVvg0fZf3aPXZKc3iFcmSyFRYVuyhPwKhJlVdNc8eJrKaE62KYwjSgK5D8u+eZjK+Or
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 00:12:50.7849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e8196f-9644-4e72-ae47-08dec2972e7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9492
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295487-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:kuba@kernel.org,m:mkubecek@suse.cz,m:eric.joyner@amd.com,m:jacob.e.keller@intel.com,m:nikhil.rao@amd.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3646F644179

The non-histogram stats don't have newlines printed after them if they
don't have per-lane counts, and so they (and the first histogram bin, if
applicable) were displayed on the same line with the rest of the stats
being displayed with one stat per line, which looked inconsistent and
doesn't match the display in previous versions of ethtool.

Fix this by printing a final newline in the case where there are no
per-lane counts so that each stat gets printed with a newline at the
end.

Fixes: 3426a920183f ("netlink: fec: add errors histogram statistics")
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 netlink/fec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/netlink/fec.c b/netlink/fec.c
index 36ad3f504a83..c014749ac950 100644
--- a/netlink/fec.c
+++ b/netlink/fec.c
@@ -166,6 +166,8 @@ static int fec_show_stats(const struct nlattr *nest)
 		if (lanes) {
 			close_json_array("");
 			printf(" ]\n");
+		} else {
+			printf("\n");
 		}
 
 		close_json_object();

base-commit: 75fd12445ffd6d697d53b7d296e345d524a9bedd
-- 
2.17.1


