Return-Path: <netdev+bounces-265333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHYoHVHMrWkm7gEAu9opvQ
	(envelope-from <netdev+bounces-265333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 20:21:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBB4231E05
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 20:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77B5430036C3
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 19:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3609B329E57;
	Sun,  8 Mar 2026 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WjKgWtee"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E736E284684;
	Sun,  8 Mar 2026 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772997696; cv=fail; b=Fojk26e6tuuhPPvKNVyMtchpbzS1nPeDo9saESMoWkVrUKShVytGDJgEPkY/XwGceJP/gKTcxNa3rSZF67vIbPRt1R8/CBFK/L8MuctnzHNURqHCK2jKffnCc1B0WrMmTjicw3j3NDvuvlE8BreqZ+COL7+mgwPYZbp66ETtJpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772997696; c=relaxed/simple;
	bh=WdRm2Tn90oXu+9gYJKSCILWfqUctiFUwWEScfVo2078=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJ6/s2jVSlV7lF2d1RogEUR4iq7ckHMJzHwWrLzUArpVUxcdpBLGR4PEsNahsxbTxwes3r1qp6G3j71T7r+34JY/YRZi61mgoU+mrXk5tGooKEvGgL2bt9HGco0cRiQYzVWTz+0wGJYZ9eYWFZM+/LAqMC3kNxi0P1g/aDzqP/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WjKgWtee; arc=fail smtp.client-ip=52.101.62.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7QcsfkvE++yef80EtMxpjN4tu/sz8+UKgY4QX0YKsmYwlgZiQ5zS5LGp/dy+lPlFLxQduZn44kFHQsRz8FX2g6RD9HBObZBeZLxlmDPdDtXeOIJp7XL1BY4Fz5mmqCpYn2ASJvWA54ILBmd8PORaNu9ufm1EeubRhA8ziaL2uA9YqvUyYQAOglLSq75eaSOQ47DasNAkuL/iD+G2s7VkEdXAWBON4qHZbXl5RgwqglUKYN3aBwPjaS5zEw6Zx7U9dEW5BUDW9BX3v3/ldjjs7a6cKH+jtZfNA7V4OW3X3GRUPImuwUY/g9fDSsgYvbx6cG72J8PkbRukxwyMDD9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5y0pPk7ReYEvBas+WKTZHBhrw7E+QdYFLeXyRJx5qc=;
 b=zDFiOWcRhVF09kK/jj2V9lTf5HEPMJ01dcmv9xbQ3EAr7tL2H3B6MPPgXZ8UnpLD24h+WWaaWPPCUw4omqc+trMn/8qW2iSHcLTpeFsvLKjkIF4nv9RjlwhIkXy/K5ws1cXBp5vwHPahzY7D1iFLjjm3aHNj/Jr8nn92XaCPOOKv06tchcgmb/ic/lP/XbIe+ySn1skZxvV1qtI8FvhBFsAf1asp/xk4c5U4kDE191ZC3to3jxevv/C6fz2TRLleZV9JDhiyzkkp+7UkiYNHqo38Mm24cZ5MXvx8i6m872OCwjAsrelH4zxlwKMCgA2BqIhyi7MDPUxlfP0WZG0u+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5y0pPk7ReYEvBas+WKTZHBhrw7E+QdYFLeXyRJx5qc=;
 b=WjKgWteeG0p81bbstA5kS1oOoFewIWM+v41K6tq/M8rd+6H4jfR0gUxCt5If8JxwL3xJm65rCwAFD70GNMpYPy77FJSww8AJUQY1U3np2KI5WGvJ0BIa1Om/dZ0onAHJSekHvzvzWjcE0voyWZTzxRCt8qoBVySTqJ3EPHHjq8XRWvWqTWs6oLqCr6GvpBjzvK1Rl6kMom4am+wWAu4diuQ0VSl05t4fBGOkqjSxmVg+qDBKin3RBNYa8Drg1drlPS5IE0gAIU8nGLVqeks0YSBsBasLKX58DkyYhDFG0AikmPofhTcdo/HRB/15DBSG66uQ0WB2luI4oHhDkWrDdA==
Received: from BN9PR03CA0611.namprd03.prod.outlook.com (2603:10b6:408:106::16)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Sun, 8 Mar
 2026 19:21:29 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::5) by BN9PR03CA0611.outlook.office365.com
 (2603:10b6:408:106::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Sun,
 8 Mar 2026 19:21:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sun, 8 Mar 2026 19:21:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 12:21:18 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Mar 2026 12:21:18 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 8 Mar 2026 12:21:15 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, "Breno
 Leitao" <leitao@debian.org>, David Wei <dw@davidwei.uk>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>
Subject: [PATCH net v2 1/2] selftests: net: pass bpftrace timeout to cmd()
Date: Sun, 8 Mar 2026 21:21:25 +0200
Message-ID: <20260308192126.2490631-2-gal@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260308192126.2490631-1-gal@nvidia.com>
References: <20260308192126.2490631-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|CY8PR12MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5a0336-d750-4c66-a2a6-08de7d47e608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|1800799024|82310400026|7416014|36860700016|376014;
X-Microsoft-Antispam-Message-Info:
	aVPHyp4JQB1/4bBNLceYsnyv5PaUDhhynFr8xI6TjZ/NtWYsCWSjcfR3JlWsAk8RjrG4y2K2VFBPNuXdj+32Wwb4DPg98dRjKjqX8kpppWGDnl101LdqtXGs7Y7f+fyuZuEFZw2QsbIHZgQZ6g3aPSdxsDoGAfnUiDlYJF6S64QoPooIRaOSbCtnxPCqgx1cy/k5LV6Em5/8lqIGpU8Dj9fnjei97AuKls+DYo+OiRe+Wkp6gy6z/f4Fg7dZHrn/tY7u9Z0QZp4OX6j8c+sLw88ADNfVksJUJTlCJUIrJ8SePRtDiiJ4Ksiu0Ll+Ehxxd5hpXaQ7qc6s4taLozuplnnBY5NyXfIVbG73iqWKRsnvEZo/Z6UEDAE7qMmjPbHlb2eEvzVEO0jL0GO2G3j4K775YdO/cRbaFbGFB9by+CZbgmuoy/6cDUghRyOrkheFRMse1xQXBT13uSy9Zo8ngvSvBllGz2S6scF25rEQGqkyU44Kh04Ss3sWSB4vapphnHSGlbM3UCcUzesegBBYxUiJPVHEL3erpVfWlRKpJaHR+Adc/Ku0yqBe8GXNZAhBrvxknP4lfdY1SuloUbBf8EJhggvtK9vzQenUoZ3hCFiiIviXgk0VXO42v+dx+VUrI13pGwGL65a7R1jyXmQyM6VQADSvER74/BMTJ2TQD+XEkBzxxrQXmuGBvEe28nhyWwtcx0Wg1M4hx3QtU42BGboCzYYoB8xI1MjiZLaj0cWyjiJYdF5X5LbtffN28lVhWDM/0+YHK7GgoutzSF9vhA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(30052699003)(1800799024)(82310400026)(7416014)(36860700016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gwcpaQTNGfAkES63VV6oOccO++to5nPc4VwqCr8LH2rMxl/SI4SwbU2bEeHUCXPiZZCe6hhb7dxiRKIBOyLUZ9RQ6oBbZHdtDeLVxyv7KEwzXi0hrQ7WxC+5R3UNxrb4Fa5n4wEeP6ExjObcn8IHhF4+ty7MPXZqxLsTDxheX7E3xzj98Hni3JAFCIp9Ouv4Vyso4BIsGz6fXHCe3dnqNT6RHrLXSnB/s+lZ03c2cX06GrTCXDqbuJg5tSbUVuocLwuqLEOOq7qb2Ed8JKLkSdXkUXxECAcauMIczFKdSC4ZnWcDVOD5J5nP+qFNERpm7WOxTomZX1GW3zZsGRE5uVT5gV2MDjfKLvxu8ocDgumyILUQCy6w2cupzIqEEjyTbVb5jNUpSB/JPOiZ9o7HuEZKnqmSb3OjvO3/kKvlzavKYdMVPtLc2SvVSHoluwmD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 19:21:28.6896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5a0336-d750-4c66-a2a6-08de7d47e608
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291
X-Rspamd-Queue-Id: EFBB4231E05
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265333-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
index 85884f3e827b..ce4fa4aabebe 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -240,8 +240,9 @@ def bpftrace(expr, json=None, ns=None, host=None, timeout=None):
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


