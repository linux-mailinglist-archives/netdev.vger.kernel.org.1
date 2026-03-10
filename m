Return-Path: <netdev+bounces-266101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M5wDvYcsGkJgAIAu9opvQ
	(envelope-from <netdev+bounces-266101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:30:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B08250551
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B455E321E42A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10C03A543B;
	Tue, 10 Mar 2026 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xm+wfQpH"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7403339BFEE;
	Tue, 10 Mar 2026 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143907; cv=fail; b=CiTmF+mdUfsRIoKByg5xvfLQ9HH06tKaYhqnaTg/aCzk8efd7FxksEb47XLTdulDP25oue/iJlZpBr9/bPcrHxJ1JTbsWqS+nfcwnSmgF9nfE0EGMM7QCnfVruxww5ODl7gN7HN92+cDkYCzrIB5I6zdtjiIdpGftXZg8IVy2Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143907; c=relaxed/simple;
	bh=vZ2c7gNZdA2I0PFdzgiiIq1tKWyE9TkfxUnRN0Q1ZHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHFD9WdAANu6USve09EvXVQhNdmIkxvX0xe9SvunAc1Le3oWMmsoyk9oAH/REuhZ15s7qYni4MXNiFGOfP1e+zVl6yFjPqDjPN71zk/hoR6yvrWQX1lSsjMR/YP1alwv1THNg0Din8yFPwznlvTVzYGnBqwMC273iJ+uBy6PwhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xm+wfQpH; arc=fail smtp.client-ip=52.101.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IedAVtRsSHQDJaUbMQSGYE0eveq9loPS9qMvVWWmv/tajOy3RT7wV8YqmKLce6twdLsSocshud1Bza6u059vCSNiAtXkBks0Tmd5nyof1sU5NBeyDQj4Y9pTMEX6IAFLenHMiPDT/cLlnilD6DInZEB/fcfViyLRseTEPdWNTfcezI+o54F6ZAQYNZtw3woWQLxqtbDeZ1YVSfzriQG0VdZqUFl25sFyzYe0o6uI6VUB65gWfVOGyxxq258OLs1kro7iCfEemwkou0H7eWxm3VcwIGl4zJ/5gAxlZkwPZ9gFYgYcdMhFm6yHAED5o8pOUNmroufGZ0bftz8zzjsFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wST8gMgTQKmlUyYKDSBfuHpe9CHzV835xSYOeV4tnwM=;
 b=XVDfB9geIZg1AU61SBK6CygluvJu1EXTsR6v1/MM9NpwUbHLQNa/F96OaxuFXkRw7+ijztBVAgC//QHKzs8+WhSTV2RXZ5veth2dpb/ZYaqE3mmQJw8dPTs1CgnqV6F0HG0KAE/hrBLrYhWaicwvpUjXn5vksx0wiD9+QhY48YnNxuUAc9aQ091sYUSjNb09Q1ZCX0tNjqV9Hpyiu0zIWG+KtborRS3HR5n1KJjSrJgoL8E/9VZOZ40FRBPlFHxp4WKzsupvpr/cIHR8+ypSqClnVkULC2Bin/uudH+XuVhOQU4XErPIiVsChBtIiP4/1Ba/0bAiQRrJAk5N3LHC1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wST8gMgTQKmlUyYKDSBfuHpe9CHzV835xSYOeV4tnwM=;
 b=Xm+wfQpHAEzrwf3mknoUmGoMamUVQnO0SHzCGFq4TXMYRJa0bk6+X/M8Zx0hqArKayUvhMOQloo83HdIYOTOGdTPrC2++MaWlOWyuX3tmE+SvuAX0rmqLE6uAQIUv8Hs8KpnXVcsyR+QbxmLH+LxUHUOyYJ06W5T7kC7Vks/FNd9PMSty9kTo493P+ZXfmNKGgkuzuNChdDmyxFgk5JaJCZrACuvrcM4zz4jCrkcq1mSuyHT7RJfL2WJTwQfy5LbXqRK3708uTW81amv0Sl80CyQdzdI1oOIEOHRZu+7l68YREBm4ZgaesooyZ4a8faOL/JpCPNAUqLbrPfZ1y9rDQ==
Received: from BN0PR02CA0026.namprd02.prod.outlook.com (2603:10b6:408:e4::31)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 11:58:18 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::d5) by BN0PR02CA0026.outlook.office365.com
 (2603:10b6:408:e4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 11:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 11:58:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 04:57:57 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 04:57:56 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 10
 Mar 2026 04:57:53 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, "Breno
 Leitao" <leitao@debian.org>, David Wei <dw@davidwei.uk>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>
Subject: [PATCH net-next v3 2/2] selftests: net: fix timeout passed as positional argument to communicate()
Date: Tue, 10 Mar 2026 13:58:03 +0200
Message-ID: <20260310115803.2521050-3-gal@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310115803.2521050-1-gal@nvidia.com>
References: <20260310115803.2521050-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f7e963-65bf-47eb-0dcf-08de7e9c517a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	UyGkIoQLzCCluM+HFY4tCLT7CDrlvyNuT/0rdQIitIa+/PxWCvlSfHJSEJFSqZgkVqXPuLg/k/XulVHndmzOoENGKSYT7fIca0IH+Ykk3t3MYBp1Q3qjrTyZozGxjqNdHVBKuuLIzkZOpEq53I3BHKuOwvjFScNdsfujkSq4WoVPcjPM8cJma5D5gqYvaZlnG+qthssL6i5OxLN4C1qKxkStqb1YaQ0nLpFBwWj2UCdoJIICdJxwPgtxzu1h0klNfEt4FVwsf5/dgqYxtSbT0MQQiReW+ZnFKZa60+m7JO0ZZFqMzQ+zC4Dn4g38w8xMigttqq9eZWN+l2O597DRRrxTiE6TRs/6SmgBWdSuQXH7fP7OlzJLkOhqHNSRPVtjoUu94ViHG85yp8UmYwS9Las8tu/tRkBzQFh2410BnPUxF5BYx83CZRwMhxG8kLC/bjrDJXtLZH7siKHPqsRW0xh8X+rJo2YCcnCLOmSWDZcRvSYoA2e7VrdboIlVLHCumF8lL68cwNIIkuerFrf3oJI1YaHxkPK8FYiJyAkFzt/sX7CmGseKrAg/783vlTzjpp6xEo/9OBsXeO06gIgwqW4xIRdihx452zmigvgqhCn12Btm4ks/MlQcroM/KtNCO3N+cOp+mrV/89Lj6nfnnH5Na33kIWFtSKorftIzMlSZccFB6UlcYYgTMcAdrF8bpaDuGvun9VfoV8Zo9dnPzrZZxF0hvHEf05U6Cr7MJLzqrZMUItQ8BWVcWIijcNzy+Dz7YzC2AaRayZQHA0peVg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aR083cSJFQ+dOc7BNQSvgvzobnDiuehSkaLudlBHuP98cL1br30XZHe16Jqp2WfxfviZ1GtfIBMTdv1FtsohRwrDOWBmEt4q0sFLPs35PDIW3pZlW7M5bg408Tee5FB89xfd0RlSrZmRNBrAwjq7ekOebQ54KR3HclSQoH0zIEDgpctHU+lOJdH5VHtsx09a2WEAnqjrEnc5gzcOMyoEyQOpkUtMn0etHynCVJcwRyg+tSprhuQa79TFkZxW+lLUX6mArh7NAbJhphTPvT5c4Gq41bFZfevsIHKc7abieFJ5Yo+BvodVq1lzAmY+WBY6opSxZaqU1S0XT4CoxuwwoKma5RUZ0TIEVZVRuDJCTz9Ak0dWlaiaWnDdomelKfRrDsBw+nntuNCFUEe/wQH0RlINZ8Di8U3H17Q8W8pGuRsfX1ZSZoEe+jwQnchBssqA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:58:17.8317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f7e963-65bf-47eb-0dcf-08de7e9c517a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009
X-Rspamd-Queue-Id: C0B08250551
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266101-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

The cited commit refactored the hardcoded timeout=5 into a parameter,
but dropped the keyword from the communicate() call.
Since Popen.communicate()'s first positional argument is 'input' (not
'timeout'), the timeout value is silently treated as stdin input and the
call never enforces a timeout.

Pass timeout as a keyword argument to restore the intended behavior.

Fixes: 1cf270424218 ("net: selftest: add test for netdev netlink queue-get API")
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 tools/testing/selftests/net/lib/py/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index a6d7fe15e6e4..17adc2b67ee0 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -93,7 +93,7 @@ class cmd:
     def _process_terminate(self, terminate, timeout):
         if terminate:
             self.proc.terminate()
-        stdout, stderr = self.proc.communicate(timeout)
+        stdout, stderr = self.proc.communicate(timeout=timeout)
         self.stdout = stdout.decode("utf-8")
         self.stderr = stderr.decode("utf-8")
         self.proc.stdout.close()
-- 
2.52.0


