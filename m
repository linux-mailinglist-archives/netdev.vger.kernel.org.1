Return-Path: <netdev+bounces-266100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHtFB/AcsGkJgAIAu9opvQ
	(envelope-from <netdev+bounces-266100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:30:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9119925053B
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4FC730F4C5B
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720CF38D6BB;
	Tue, 10 Mar 2026 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oO7nSow0"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F0738AC84;
	Tue, 10 Mar 2026 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143899; cv=fail; b=jscb9nbrcSgUExufatkBm76gX+Ti1nzzvxByuQP1jf3Gy3lk9X0EK5pSdjuS4860vSpc9nGTivvIyKurk7VqnPGJO6b3e86A2JQjUBV5QkZN29pdcCkR9HM28luFHVeKRNovdwwYgtE0E2/1x80N9eZ65K8LbMuS4l9lsJPKkiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143899; c=relaxed/simple;
	bh=54Wqd3vXXGld3v6RCe5vCAirESgh0j676JdYefM6+u4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYfoIgrQ3UOkUza8X3ZqkhAfw3yEiCKoFz+PvMzPOiJDnKfu2vBey+swhAGe4DkCzNddSxNN69ATv4drSd/vVnz/v6kzub14cDS9rF404lOpUb5rwOkpkVnpDueJc/z9Y7lEcT7cFySYx7UKKUJtW9yLStGcisoGYCRHk5LoLAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oO7nSow0; arc=fail smtp.client-ip=52.101.62.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izPjMJRYjrNg3KPmpJm7UmCgCjrbbuW6E1AvpUyXJwrLe0RSPdkGVzpfuQED0unQ9q4sE6QIgDv6RJsKChsXZOe2cdiKCQvIOzmdHhbHas4EGFa1+UDqnVgVUaS2HvPCw62lwd+s+PaWuhezjwgeNV2Xr5owWqD6L54snicqt4lcszb9zPi9TucSZGMk2rFK+/2lOridLmYhYEFXPrhW1YhX+4dexObjcW+Kpwm0yzSMIfWaSbtKGVUICZx3DlQ5mWRRedWFFmijl4Whbu12gdO5oFDSTTD3hrp0aqu4+Kaudc1nECa3AWGj2aVLSg7ZKvCs0DPTrlqVi3pvkXr6YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7R6rV1aoO6L/2KKAzrf1GjZGmh44XJoL+JjvZBfkEk=;
 b=n7CwuIqACIPRjrs23vpafVuHxQb+IGRZ7JrcSXVR3/pbfgFRbyZJOrcY9vNMZ0RWYo738LRClZJS8/YK0bpp/9mYd/X0YKmShk3Kn2GhQWVm0FXLoltGTjekmrv0eGQe7yLmvb0w1Hy8v2nqmHLCkKFWI4D3No0wkZe0V7ZO2pL0l38jl3vayz0kZ5bY+87hMZdCDbmeyoBI3NEPWfdusyEl0mLooCI1NEbH4cAaYFVkWVmd6mT5coICXdwQ7V7FnHGCQm5lUXvN/g7uFhSaiFdZ+CyyWP2upYi9xosdkm03kIZ72UzUpjPG+0Y4xQIhMJM5S4adJ4BXvN5NhYZBhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7R6rV1aoO6L/2KKAzrf1GjZGmh44XJoL+JjvZBfkEk=;
 b=oO7nSow0D6PaZCj0PK7/M7XPxux7P7VXl3OjNaYh0J0oUZNQRjm2jU26XiH4b6LLO9PQiyMfUBy9bcB2w8aGtnqMAa3rAWFNKptmORCFPtMVpVAmQtP2hOw5lSji5tiVNVdop7EteWcZSQK22CwzBKNgnJvp4RiBldJDAhXluGIH0MoTCbSpSM1bMtdV6TOwNpFocsaHuNo0LyYX6+072bfghLZCwqlzkkTxnK0pBhYFWg2T4kJu6CaXZYjfmvgcHlqLJv8IpjoTEXx1RqOIolfugoVso3ij8RBdSRU1Rt/M+IczC0Q7HWbG7AmTp6qAM8I//Dma2vw0i225Ves7nA==
Received: from LV3P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::32)
 by CH1PR12MB9576.namprd12.prod.outlook.com (2603:10b6:610:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 11:58:13 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::9e) by LV3P220CA0016.outlook.office365.com
 (2603:10b6:408:234::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 11:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 11:58:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 04:57:53 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 04:57:53 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 10
 Mar 2026 04:57:50 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, "Breno
 Leitao" <leitao@debian.org>, David Wei <dw@davidwei.uk>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>
Subject: [PATCH net-next v3 1/2] selftests: net: pass bpftrace timeout to cmd()
Date: Tue, 10 Mar 2026 13:58:02 +0200
Message-ID: <20260310115803.2521050-2-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CH1PR12MB9576:EE_
X-MS-Office365-Filtering-Correlation-Id: 54dd08e8-9d9a-4581-6279-08de7e9c4e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|30052699003;
X-Microsoft-Antispam-Message-Info:
	j1IS5kj97Pfq1PptLQdo/VGHDY+kTsDEe46zyq1YkRFzZSW3RFErApJs9k0n9svMITjFPfodlgxbLH1FwG9Tm7N2z+YbxZIe7lyLLjifJdk5GYxVIwvnwAf097APELt8vHzENdR8Ub6wyCMbZuPZaY4g/+3y8C10Em81Yb7wlxRGvWzHiGALyIaww+j6f3w+PnMhT2sE1O/+M4tQwaNmmhziZkGjHM+g9KyPP8cvOrC33yBXQh6Neumvdeybvm+Q2GUgmoIkJ0Y7KEYlEVU9ZwLEqR3P+SxTCRUbKkoluVKYPgeebO3wj1wm6JRu16sZmYxqpCYJ1EQbiMUfYMOno5Qtgb4WdztbNrNLroVcebV4hal4bv8inQaN31a/xJI37AqSsTkUEdbQrBL3ZAgDmp1WCQ5+pKf7dpHuwgqFskYe1ZFtZwtwfqAu0HPuBbwLVhfMh+V86G+BuICTcTKGnOL9HYTNJ6l+RQBUtIhoMK/UhqwrfCqqdVC7AS4Fs4K3C3v+cVK6aGt3A3N+je6P7CRxMU3RaPky0vN76it+iRUJcOsEC+y4G7Qf6KG7dq8imFcuHp/Bf7VAvrWlE+mnKlxRwj1VibMkpMcV47frayKGIcQa862RP99BLSrRqEU3IUZoDiJSBe84f5upNTaF++1RK150J0+RDA5juBPwdy/vsoy8C1uUc+5tpFtuEJD4bZQf1HlhCRk4Pqh6zwOC0AN7Jslc8pqAItPtuhUW61xPqn7UKTPdJLWtpgYjAvwdHGKBQ1C0uVVZqwNJ3blikg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(30052699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y6lRg2TVSWWWbqkwCkvnKOetPc+FA/OVQOLffmm2Vvm9l4FZvv0q51BSjoFCTACS7rpOiZ++u7NlPe59LwmXwybsxA5qYKGOnHO9JOnAOeWEM52uAQcQBqQlJCpVB/tUgKfcy5N96mGd7a9OY5UVAMBiCqI4hCTVinZ8p085x6KGtM6vHTMd8ztecHcHr52AFNikodAR3EEK/eFkt0Bv4QLM8yt+mt1jTFU3na87hl0UNQzmhtpTeyCllksKf1i2t7g+gIWljh4MdNTKhAFUgRb5ZHA3V9oxCH07s24M2b3LsCB9kkBVaKCMOLQ6i3upuVpw0ujQ+2BgwDLJb4vw1v+M138yb7yi6bj9O3T/q93aXEDedwzdEVeBqoXvtg9z8YmsjL4aD8+42L/pC5Ix7JEI2FwICvDG9JX7aIcruHyb5q4ffSD801R35+0XXE2g
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:58:12.9204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54dd08e8-9d9a-4581-6279-08de7e9c4e8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9576
X-Rspamd-Queue-Id: 9119925053B
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
	TAGGED_FROM(0.00)[bounces-266100-lists,netdev=lfdr.de];
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

The bpftrace() helper configures an interval based exit timer but does
not propagate the timeout to the cmd object, which defaults to 5
seconds. Since the default BPFTRACE_TIMEOUT is 10 seconds, cmd.process()
always raises a TimeoutExpired exception before bpftrace has a chance to
exit gracefully.

Pass timeout+5 to cmd() to allow bpftrace to complete gracefully.

Note: this issue is masked by a bug in the way cmd() passes timeout,
this is fixed in the next commit.

Fixes: 3c561c547c39 ("selftests: drv-net: add helper/wrapper for bpftrace")
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 tools/testing/selftests/net/lib/py/utils.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 5ffd9fb2a8ce..a6d7fe15e6e4 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -258,8 +258,9 @@ def bpftrace(expr, json=None, ns=None, host=None, timeout=None):
         cmd_arr += ['-f', 'json', '-q']
     if timeout:
         expr += ' interval:s:' + str(timeout) + ' { exit(); }'
+        timeout += 5
     cmd_arr += ['-e', expr]
-    cmd_obj = cmd(cmd_arr, ns=ns, host=host, shell=False)
+    cmd_obj = cmd(cmd_arr, ns=ns, host=host, shell=False, timeout=timeout)
     if json:
         # bpftrace prints objects as lines
         ret = {}
-- 
2.52.0


