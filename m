Return-Path: <netdev+bounces-253150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MhaIqr2dWlBKAEAu9opvQ
	(envelope-from <netdev+bounces-253150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 11:55:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC34F8021D
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 11:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCB423007C8F
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 10:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AEB3191B1;
	Sun, 25 Jan 2026 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GuJYlEOP"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011001.outbound.protection.outlook.com [40.93.194.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEC4217723;
	Sun, 25 Jan 2026 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769338533; cv=fail; b=KG+jjoiJFifXBz2f9BZjKrHwwDSWFQZhBD9k74EndoQBwcaM8zvqVQdzd8st5lOYTntEa0reGs20peBIPkl38hEnXpPhl3YhYRYes8BzowBOzC90e2t0sK8tfVfzOtJqowq/I6rPZWciXtSggCGuhWmRdPDjKBnP49IxzeEPmgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769338533; c=relaxed/simple;
	bh=RJGzMkFIFR2zPUPIWjviKtQV6q/Lf5BnLInal9DceRY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QI4Yva6pisF4LQxMzyLvUfRvdc6zstZrAYo1UFwWpII4DGZ4o+BVyRXyexEj9WTfjOOK23tFMEpu6odkTMfOL6idLEGYowflpglhl6LN91760sEOt9Npiqc6nfmjalCoIrxGlfdQ17ZHV0ZFZFANvfU+6Kado8Bsopiv/yYY//4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GuJYlEOP; arc=fail smtp.client-ip=40.93.194.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybXIKWyl4LpOelCG/SnVu48GxB64KpCslRlpqXIS1QWjetzvJFZ+6SBwl4yuLNoQYdWcNhO/L2teBAhPQLGn0jT0ce3d930zmdF4vRUpvywUL6gFXI61+kZQ+wK67u9aEPO43P7+w+lAtp2llShIV79AsmxwrnXUbrZ3Nzukz8ZzT351j9q9wmD/XKsO+AvONGXjYM3N1iqzRP2cnihmhdAOhzX91awyS8q4XUEBOdUAZH8NDVDqLIh1wIFhMYzfITb4Tq5nWWizUrdAkY6rtdX5s+Q2D+eNWQavJ9Hhc7tOBmxSPrwJ65pwYi/HDgxH4hlbvVbAYr/qQRr6AWuunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyhUnDulX+2Ky/e0R+IqVrRfEYC5LxKQr/l/Q/UkzIQ=;
 b=PHnPoDE9ydeVov/DxGkorz1XXuU4SPhFwi09NK3DBCIpdYDe8EcuRo1quO5iUSUJhQ0Wu7KhYdg+R96c6zFcP1oQgKImJDfEqJ0WYzRE8iVTDdcmjOORloPzTQsH2siq+elt92tuWUvblU6wLYI27ncvkqD7aX+lWBxlcYQ+LrHOqUsyg5Uxx9oUII3QfuoB3p0Fo8mwFzAUF6ieUpoeclTlrHp4FmZc/Sd/IS7tAzdTYmvyE4MoMkhz7Y9wIHqWu36RTq/eihjGz7e8lffs+FZ/qCQNtzIJpe3eaJLzl2uFqDFZ2j6TwPHciZ3uC17MsHBbt6G8NUmKueGyFXUZhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyhUnDulX+2Ky/e0R+IqVrRfEYC5LxKQr/l/Q/UkzIQ=;
 b=GuJYlEOP8VtsSLkJOt9gmpkt5wsdVZhEts1Jqs67ZDF6UzJtV/1RhN33GYuulxS9iGDqrhga9+KKHq6f9uiSWD11F0gG8ltl36wB979/mCYAy5Th+jQSDTKiT+yNYM+p/RRAuR4O8AWLxaD1r7C8kiJjcxVrJ2OqLLaYkhGfiX0UVFVDJFkoM9k/FZzHaGuBEGO/2d08sv/Ys64sb8n5ehz5HeKF0GEUz5HKEDqBPcaW5zLFDblJ6WLtMo6N8if0c+PxbL4hplFWTXveqWixcWcSiXjy1bhUB53YQA2Txwl7vaDm4hoa2pD3Db35zu+wwaz+5/whnRNTjvmohxq/uQ==
Received: from SJ0PR03CA0152.namprd03.prod.outlook.com (2603:10b6:a03:338::7)
 by PH0PR12MB999113.namprd12.prod.outlook.com (2603:10b6:510:38f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sun, 25 Jan
 2026 10:55:28 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::89) by SJ0PR03CA0152.outlook.office365.com
 (2603:10b6:a03:338::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.14 via Frontend Transport; Sun,
 25 Jan 2026 10:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Sun, 25 Jan 2026 10:55:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 02:55:25 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 02:55:24 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 25 Jan 2026 02:55:21 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Joe Damato
	<joe@dama.to>, Stanislav Fomichev <sdf@fomichev.me>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>
Subject: [PATCH net-next v2] selftests: net: fix wrong boolean evaluation in __exit__
Date: Sun, 25 Jan 2026 12:55:24 +0200
Message-ID: <20260125105524.773993-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|PH0PR12MB999113:EE_
X-MS-Office365-Filtering-Correlation-Id: de69dfe1-00af-42a6-8cb6-08de5c004021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xy1B9CXQKrTLIwWg/xxOT1Wa8pkINMTVxWccBv03rJ/0KEXRfre76xIXyFzo?=
 =?us-ascii?Q?9mSDyAaTdLfqxda9JqgA96am8ziZZ960awlEwk2vZl1WG7IPSZeVPJuP4Eim?=
 =?us-ascii?Q?0H8neCF50RaecosJbNyQMJElHcUGinr0dpOljodmRieVZR8eTn6wTk1+gYbX?=
 =?us-ascii?Q?Y+XAD7rumKLoEY2cwfE1fVUT762xj4vqaRAZ8IndS986/6ASXZ+a4S1RIzrY?=
 =?us-ascii?Q?hkszx+vXQtiViZs2pvNrL0+vS54AnA8UnmYEomZxRgjxDQ+2i4ltUQy/DDNK?=
 =?us-ascii?Q?wrhA6Jm3W44aeuLBke2syWpzGJSiZ/L1ob1GpaNyPCbfzxrbP3eLUHIFmr6I?=
 =?us-ascii?Q?16ke36JE13vYPWUllsGBMtQkA2n8qxGVWLOUDlzABpkGK8pZYoBLc2XvVIRw?=
 =?us-ascii?Q?U0I9cuiM+lMW/7lFP3++B+6C5SI5tkDtEQeQ2GNT6F3QK3GxGhhb2HJhPs87?=
 =?us-ascii?Q?WfHWguFX5KsNNobIF8x3B41n2T7wGdzjTf0cTvyzrZKQKodeeyOPIFlc3Lcm?=
 =?us-ascii?Q?mH8F2Fgez4Ap86isthZhsjSQItryR6rDnT9bh0tVe3LBYoX2699aBjZmAbgd?=
 =?us-ascii?Q?KBe37I8adWxDrZHCekwgo67VM+Jipd0mLAPeGm2j4apXUG0QYq78oJ9Alqb1?=
 =?us-ascii?Q?awYzyqfVXetahF2zy5KzXwMpEjslk5drIUceD78S6NtoKdXJ3aytIqhVS2Ez?=
 =?us-ascii?Q?Vh8r+PnClJOKzDzf4jzf+sq/NXrPXKKWe7GALXMKl2lRu/70ZxYMsZ37P4Mf?=
 =?us-ascii?Q?Uck1udhLCKGjatX1xxrAhHxKRZfwaK5deQg+ykZIXaZQ8yRwIHf2V6zVC07W?=
 =?us-ascii?Q?XeHkNMJWBXa0pAtvoTE5yWvgE8GfewPpsYP/oj8Z5acjXaQ5ROhvniGhw1TL?=
 =?us-ascii?Q?BkudNmbvmWfUrl+T717BcEtc+SJ5zrCRBLJLKkfip4RUl+ZAkave8uXL75M/?=
 =?us-ascii?Q?0WJp53n+26papoYUk+uX0KrnDLckTPpPtlK1N+uPAuGbQUU6p+FUNId1TutY?=
 =?us-ascii?Q?hLsRtrd1PAaLpL8VbZ9mGwkgKGfL394mzPmA0Yidez7z82Zrou+jE45SNNvJ?=
 =?us-ascii?Q?Z8D9xQuFGw1ZaVa/2qeHUA4XO/ylfPdsGMn+hY0K95TK3VK2o5Sa6UWqWEJc?=
 =?us-ascii?Q?1+xjb3Y2S/i5uYqWtOuEVbawWkYaPIwJgkf8Uu3Jq7fWYxXVj2lG0D6ZpjU1?=
 =?us-ascii?Q?1/YqM7CnLOQYR/CyPFrHva5sAq1fc3IjqIhARpC+Dj2WtwYeAXeJ/iRSqWO2?=
 =?us-ascii?Q?j2cdsJNFyutQ3aeQM/otMBJLG9f5skQx0bhv2YBoR2VI+ZOe5gDeM5tARkBX?=
 =?us-ascii?Q?SjolJI1IF4xaB7XlFx8NQsyBo6fk6PV46FouKNMWC21Hxn0QEkEkehLmhdMn?=
 =?us-ascii?Q?mi+XU6QNIbSRKA8bRJ3M5Rb9H58YzU7DdhmXfgeUgV23m4sJ83Om9ClcSXh4?=
 =?us-ascii?Q?+3G5RInLiuTnOI484u2twCjkVVwGkxDGCPxOV8aUtXmRjxRtoXI4c5bJmonl?=
 =?us-ascii?Q?BmnJgwmqWqAIQSMbCgU9FvUNPbj+eoOcAPQb94cvq94iG5cbB3aFSNTxVfZT?=
 =?us-ascii?Q?kPiSGkwYiQ+tCVe/uX9fbZHx6Q7sR+1sPEzPq2rG9Az77RnZARHyqfisO5fh?=
 =?us-ascii?Q?sobJywOhHmgVP3ITTOyyBt3B3i3NRvBzHZfkfg7P6zWMHyYCRPZp2clAFxus?=
 =?us-ascii?Q?Y+Q5Qg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 10:55:27.8298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de69dfe1-00af-42a6-8cb6-08de5c004021
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999113
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253150-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DC34F8021D
X-Rspamd-Action: no action

The __exit__ method receives ex_type as the exception class when an
exception occurs. The previous code used implicit boolean evaluation:

    terminate = self.terminate or (self._exit_wait and ex_type)
                                                   ^^^^^^^^^^^

In Python, the and operator can be used with non-boolean values, but it
does not always return a boolean result.

This is probably not what we want, because 'self._exit_wait and ex_type'
could return the actual ex_type value (the exception class) rather than
a boolean True when an exception occurs.

Use explicit `ex_type is not None` check to properly evaluate whether
an exception occurred, returning a boolean result.

Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
Changelog -
v1->v2: https://lore.kernel.org/all/20260120124733.604590-1-gal@nvidia.com/
* Target net-next and remove Fixes (Jakub).
---
 tools/testing/selftests/net/lib/py/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 106ee1f2df86..dc1db78b5304 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -137,7 +137,7 @@ class bkg(cmd):
 
     def __exit__(self, ex_type, ex_value, ex_tb):
         # Force termination on exception
-        terminate = self.terminate or (self._exit_wait and ex_type)
+        terminate = self.terminate or (self._exit_wait and ex_type is not None)
         return self.process(terminate=terminate, fail=self.check_fail)
 
 
-- 
2.40.1


