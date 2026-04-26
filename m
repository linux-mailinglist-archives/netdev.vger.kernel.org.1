Return-Path: <netdev+bounces-281152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CloOnH87WlipgAAu9opvQ
	(envelope-from <netdev+bounces-281152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 13:52:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F41A84699E6
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 13:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29DDE30015BE
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 11:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863AA291C10;
	Sun, 26 Apr 2026 11:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TUVGszzi"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1150B1F0991
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777204331; cv=fail; b=cWsnQvsYCMCq2uzBY2yDLJQKoO7A0j2Cm/v4cNrCtjh+HPMvtN8zhI14K7SS1hwQVgUYdzHXMf/kHCapa9tvf5MTIt3H/Sowovny1Wkqk5tti+qMtTJYbUwIfqWvydRUqRlOCvXSJz3Y5GiNqNvsi/dxDWWY9BddsMLGPndO/m8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777204331; c=relaxed/simple;
	bh=OP4eHis2F8CaHAoQrW2QfiTH0r/N8s6PepPAuTMtzcg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HHMWgP2Ro/igwoFPoqjG1M0t08fh9U5qYYWApU3BsxjtfO56dZaetUvbhvCMGcmPjJ8DapXIkA9ssoQ5iKJva0cbnytlcj+63KCLkmWChd7Bdx4kxxau1kkQrTFcIApkDHMpe8ilJlRrJzJpW1WSQA9bQrwzyAbL+ErSEoq/MXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TUVGszzi; arc=fail smtp.client-ip=52.101.46.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUy3k7Orca9SKbjCNIHah513sCwPOvx69JdT/+UkSY8JKUV7UPWZOdQJQtnVHjuGcpixkl0+ce4g2bRlmPAj5iStbG2OI2mXZ+rq31wFs11PpS3nqT4WDBTQReRDZ/2pQCTwIcu4K+rM7mtpicMc51rhOcc1On1ScCHy1h6OdFFefhIv+pwIXXFZqelCSfl81+5cilo1osMP5tdhcPyqk9dkB2B5WTLiA4vd26II/bu5zmD89SZSyxNWZwlxzz7UMfiiZALmfZpN+7raBmW32ygb9hciqmb72p5b53pS5iGTKyIk5FFWj6mnm1zFIa0Qex6lxvYxVmRmIQspX8E9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ndo3mBeKMKlEQmWwSuds/KZqJ/X8sD/poiIl1F3XUi8=;
 b=r9++XkyZ2usIcpZVq59sz9bLEf2Zs0rDHXm2V2jhteHPE8vRx8cr5LGNAePZTHeZd3ZlEK8mkZch8RaWwgaa27Czr52ghA/sNri3EnpYwHGhSrZdCpMW3Zerd12Vc3mNEu6bGSVg0eIUworQoaAeyjCE4v24Yx6D/YHCrzIia5MCZ/akFsB/MXLve1v/GzVXx/+7Q5mSgq8dFlHWqhWPi68g+p03k0NDwQIS/VELDvHjOGPJH5yv7PwyDpsUj8RN3w4I18WT0OQO9Al9Uw88ZM7JQUCmqlXzNc0rU84c5YyO6cLSZWzLHp9WF/FreIfUzIOxp8r6tg4facieIne4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ndo3mBeKMKlEQmWwSuds/KZqJ/X8sD/poiIl1F3XUi8=;
 b=TUVGszziGR62x/gcp+qF+xVpE896vcGQd/8kpeo9jifOQLO7EkDUy10JEGzBUzijzVgLjDFO8lsw26eZknELc7UEFeyp3dUcXsNUpz0H6e7s8WBcS90f+wqe9PpDC9tSwlWEuR5RTf7uvLEEXVmZOQ+VR0qp01rP6tfqdtoPeLO/05c2b5QkumOWJ7HuykgErUUGI/5e519dRDFgrOa0L+vz5rnE2cNq/exIum94mbd1J8MJzudubOOWNZIODqpgKFVkNpNWCdW/gm/hCqbfl7ttBVWTnMYxLzH0k74jhbhvrg+rONc/iqiCbNcqZP8AgB3qpyQ7XRn5/ZQeyOl2+w==
Received: from SN6PR05CA0008.namprd05.prod.outlook.com (2603:10b6:805:de::21)
 by LV3PR12MB9401.namprd12.prod.outlook.com (2603:10b6:408:21c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sun, 26 Apr
 2026 11:52:06 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::78) by SN6PR05CA0008.outlook.office365.com
 (2603:10b6:805:de::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.25 via Frontend Transport; Sun,
 26 Apr 2026 11:52:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sun, 26 Apr 2026 11:52:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 04:51:56 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 26 Apr 2026 04:51:54 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@resnulli.us>, <dsahern@kernel.org>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH iproute2-next] bash-completion: devlink: Fix dev completion trailing colon
Date: Sun, 26 Apr 2026 14:51:39 +0300
Message-ID: <20260426115139.712959-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|LV3PR12MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc05070-6fa1-4ca2-9daf-08dea38a3d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uP0b+DayoO48U2k87LWFzHduxmxnDydUobA0wbwp4FhY/g5gtpJIri5yQEpEzjI0yS7yT5iqvQeFS7qKeOo33nL30N8RkEUpMzs7jjMAtVELGkfzib/JFGtKpYqaBW/LAkY90FzWCgcA2sSd/rbOpRSahXkoOYUxXUmWk66M0goTFnpurI6DWsfm/EnAfM//UoS4z8iep4mMJjZN9XFSiApK7otTCi4M35cAmSH1NG/Fv37rheLrJ0yiy5LE4wRbVYCj6pYT+h1sKr4KRC2jv+ffFf9nY8ReJawQxmWb3A0sjV0kqhvydi7nPzatDjvZpP7pthmjrwqpCTWoy5bmkUag/D2zv9PVUtAc9hP8TnGCgebgFXT31HaAK8E7SmEXtDqKzVr1IvdqGzS6G2O3ab30ouOH4NtvRIqFYKmUoVa3AuiCpbBzu1f5l8S7OqGEM71DRHRCQRON/6tY/JuRXb0zTykldaL9pvi2xN+7uk1WpS2NE/r68gZWkkxtiK05t7XAFWzMENSL5VP/7kKhFWT1L2Tk5O7PP/ByrNaPfdWDWvd41VlOw7BB5eGyBOLb8FarD/BIDXisQUzK7DJ26Z/8ULKEHNFN4Y/8im+kL5Vh8cDEybesXPwwbOw93+QvkLx8E8wchKY1idn78RTqXVKg7KO47Vx1k8XhDVqUe0mpEkIEm/A0/H+ZMRace3csW2RSG/VG6jhwh/WssHWjfsOmKKzoW/deWsdWJK8pgM8sW/uPkwKVsQJkiRMlaaiiazw4z+JleBg0MPKmTfH4Cw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OgqX52oPOqytNX1D1axsTFwc6ERVQKnZMowqJyr4vgRa5IX0AtEeSaYJkHM4MMfXS01jM8h9B4qSII9M8A1PgCcqq+sJDyMSvyJQfpkwA9cTUY9aHx2MHEBUuEqTKPXgil+cc/UqaEfepzmDqBrQ3bjKQF36ovIy2pJN9BnqNG1yndeYh/awMFZpsGT9oi60Et9g9bydr95Ms2Fhyo5XS8K5R0SzGtRRiN7dnXAl5+AmNcwBXSODQbaXIXrDLjA5eP0dQafUHwGSIcEHooufamDy5gLT3fhCEay4Efn9a4uo0WoolHZBREixxgXdIHh6fB6eFheexLRsGJfr9zuVZ/iwdCQBXl2riY4YiGlbXhB1nMKtD2NTN8WzfrIfuFb5YozAV7oJDAD5DnRk9YLHk217ve+CTPXMv34z/BFsR9U0DoWTqQ9qU0BHeOyIUHon
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2026 11:52:05.9914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc05070-6fa1-4ca2-9daf-08dea38a3d3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9401
X-Rspamd-Queue-Id: F41A84699E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-281152-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

Cited commit extended 'devlink dev show' to print the instance index when
the kernel provides DEVLINK_ATTR_INDEX, printing the device handle followed
by a colon and the index. The completion code was using the raw text output
as a word list, causing the device handle to be offered with a trailing
colon, e.g. "pci/0000:01:00.0:" instead of "pci/0000:01:00.0".

Switch to JSON output and extract device names using jq, consistent
with how port completion already works, to reliably get only the device
handle names regardless of what additional attributes are printed.

Fixes: 36252727bfc6 ("devlink: show devlink instance index in dev output")
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 bash-completion/devlink | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bash-completion/devlink b/bash-completion/devlink
index c053d3d0..7ec6a7cb 100644
--- a/bash-completion/devlink
+++ b/bash-completion/devlink
@@ -31,7 +31,8 @@ _devlink_direct_complete()
 
     case $1 in
         dev)
-            value=$(devlink dev show 2>/dev/null)
+            value=$(devlink -j dev show 2>/dev/null \
+                    | jq -r '.dev | keys[]')
             ;;
         selftests_id)
             dev=${words[4]}
-- 
2.51.0


