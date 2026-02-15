Return-Path: <netdev+bounces-258771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKr/CHPBkWkSmAEAu9opvQ
	(envelope-from <netdev+bounces-258771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 13:52:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8511913EAED
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 13:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FED1300954E
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 12:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6191D90DF;
	Sun, 15 Feb 2026 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f9UICsUn"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010003.outbound.protection.outlook.com [52.101.193.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1BB17A303;
	Sun, 15 Feb 2026 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771159919; cv=fail; b=kxRiuEGBAPmmDry8ZSxQAUNfFQQpRmedtqIa0lvPgjKlbCo1lRs/nks+rfrsDd48t/lnZVouqvv8pXs/2lmRR3WjK8vuevnP4GmpryEHVfSe9AhenlrsQ+r6KeRcR/EZhYpYqWaSm4dcoVK+QBpA5n/9ZoFmyhS1K5hoXHDZecQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771159919; c=relaxed/simple;
	bh=0yERrHXSPj07L8HhZxKFD6sXuN6x9FqVyOuG3lNRqfw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UpU8N/uv5LMaNUXctM7YL4IvXfMZyOQeGcpn2LuF5ZwtI34wpABP836w+Sjzk3G6+eTbXNhlEUsKVGsqT2ySqAmBir53lQ4ah4FQDVyv31SGrABdzFkpjpvKa5pnPjUV9BLKFcSOR5iL1R04qzYS6WctQwAflI38aDtlO6n44t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f9UICsUn; arc=fail smtp.client-ip=52.101.193.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkQUJ3srPfPEaRIBjTN/IrrO/iAwqJjBFAOEEItOSxw2FAxP4rk+szPjgA6rG9HKRPFzbSVJv8Scw8mfQtjM2HGuJdtumhFxqbXbmx5tWn+RmCObtKWKiaGeeOzQb55fC2LHBdM5e2Pt8FlrlSjXZ9bx49BMcffop9O/FxGnb+vn5iVf5AE38D8FiCNRHHd3ssYvsdAgZyQnxU4Gn4lily77NIzoDfZYJ1bSbD5s5McOQ3ZV77yFRwjEhZLsGcAtD45b2Ca0WCyOMG/AAgDABR+10gZh3xfT3JyKy1OhDjeyIMZgnjrXQmmUfQRCPyTDBTFuW/tMFmnBPyTctjRDWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+w+WyImjvjULelNKhhFNRG6s+nsoyuUkaEOTaYW9D0k=;
 b=C1toFntHAJ6clncQTJ9Oso0i4jsSbmuMuLvcsv5PoUgpY0LOkabb7G3P9Oj3RQfGo/RzqMW2qkNWCZ9dsyNRb4L0qts+huZ5P79ronbUBN4PGR5FPieVDQy5dE8/qTZ8nIfJ6ATT3rfZc6CvUMP9sH8U8p1UoZh3wT+O6zTeCD5qI+lEx0IYDOmd5L8bkF07x+WFqQAbo83cqq1p+L0Jw7XqSHliaDULv7z1o4/mgeiSEgPTmAgHTj6Zcc74+GCg+6RYxiZavG0LXgMv8zEHnpkSR4i//YMd5j/0Am8vCQPPCsaIvBRnw/VGDgDDV/hKNjHO9MVhtOCkN/vQwqGvrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w+WyImjvjULelNKhhFNRG6s+nsoyuUkaEOTaYW9D0k=;
 b=f9UICsUnZ90qOWeOinoiIToP0H26KHHGb+wj9b20J4LhrRmbsi+3adqyHpdj+806ejs2FbXE2OUbZx15e+6a5Dx8EptiZMo0l8TmQu0KNsNWz0S+xayuGj8zySsRWlwsFMwC469rf9BX2wZkOL+fjysnQivvV7X+jiEFJsTqsmeAk7e8G5j5IsDDrTUPj+KI1xoCs8WPGJ51KQ1B26Oe/tB8aKGDbPrW480enQ5teSoBN2dbVG9jJGaYJWoiAegOdj928kuYA9nVcwhT2uNbXi5Js4LaiovuL1qM934F9AaLXH6qxIQSbn8ngJFUSBB7Cp6qpvW3yWf8JdLMPvrwYw==
Received: from BYAPR05CA0013.namprd05.prod.outlook.com (2603:10b6:a03:c0::26)
 by DS2PR12MB9687.namprd12.prod.outlook.com (2603:10b6:8:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 12:51:50 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:c0:cafe::cd) by BYAPR05CA0013.outlook.office365.com
 (2603:10b6:a03:c0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.10 via Frontend Transport; Sun,
 15 Feb 2026 12:51:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sun, 15 Feb 2026 12:51:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 04:51:48 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 15 Feb 2026 04:51:48 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 15 Feb 2026 04:51:45 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, David Wei
	<dw@davidwei.uk>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH net] selftests: net: fix timeout passed as positional argument to communicate()
Date: Sun, 15 Feb 2026 14:51:49 +0200
Message-ID: <20260215125149.2106612-1-gal@nvidia.com>
X-Mailer: git-send-email 2.52.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DS2PR12MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: 7813463b-06bc-4bd7-6c7d-08de6c90fc50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p1kmLWrX08rSttIpXSPOuX/jcz5Io0hqJDY4uhSmrXjn6JH8UGFKRe64z5I7?=
 =?us-ascii?Q?tkFUxYWUjwlNxJjUCmvckKNlQ8H64qwcKA/lFwPK4h7XCNFCGACgVqZ/yr+2?=
 =?us-ascii?Q?w1CFOMFty9+aE9nveEujGBLLptMDFL8vz/QWj38KEgLuJ/v8boy1/mm0vdxg?=
 =?us-ascii?Q?pzitySzGBee92XWPZiS4f1fQNpvOCKbgAsHv/GOgo7nrpis+h0Dnsi9vE5wT?=
 =?us-ascii?Q?zDcZVC4ZbCE6U6HpMc6I9Mn75suywvqHbYeQPcPZGIKgMB6HFPm/yinojdZL?=
 =?us-ascii?Q?cZLTyNpIB2HTNKx6AInD3mj9UARGv9ZokeJsE8R0HoprxKCthGSR821VlkOL?=
 =?us-ascii?Q?wgBDLwcByBl1FJH0DxSTFqUNLKa4ZReaokufyb7wRT7EC9QITAISVnRKhnFh?=
 =?us-ascii?Q?XNzMMZSbkhA8C5Pp92jQzktWVwBe0brj0LgVkN//VeOXlDoR1cGqKIA4NBhT?=
 =?us-ascii?Q?4QfhtGSqJ6uFmNAuXRRlZnxCV7039RRAe4Oz5VQlaFjmBy6DmW9v6T2i7+LI?=
 =?us-ascii?Q?7SSrDU6VZOap6c+aq65hR1t/UdezmooHqG3xKDHnTuw/ccDKqKtaxMzsqjJA?=
 =?us-ascii?Q?nXxzPK2DVPL/wNpxWmWl/iEqbUNAAT8ZhpWTCqBhccpHzatnqGu8UWAUMYT5?=
 =?us-ascii?Q?7IsZ3u2mIpW9B4M/Thk91Fm+DmcI6NfYpdTMGod1ujtQkiBiYQcRtzmdeLsW?=
 =?us-ascii?Q?BZwUFD51EndWlPWjuFqqBeQ4guuYe5XTe01oGbkZ+CvLieDxb19572dk2zZ4?=
 =?us-ascii?Q?Be/6qGT+1jPf0FyRK+Cqsdra1PaOBPTacQSayE64+EHguEB6h/gxDpPqrasf?=
 =?us-ascii?Q?+7shKjMXxtPYyXYixOKc2dYA05QyWv5xZtJnBl0S+M+tX4+kt06U6mqDJy7i?=
 =?us-ascii?Q?lLYcmeiLjMqlQd39cE9q8StxPMHm2g59KWczn6v/2q0BIfhIdwhscn5QYQCH?=
 =?us-ascii?Q?gDeGxhZKGklTgTzWu39ZmDEc4z/lWWRJpqPZuGXLX480Wyp7IeItoO9XNrBS?=
 =?us-ascii?Q?KO+BOhHcuDSkzBk08Tp1/OKh2JbZqiWNtZQcJFDY4rymRikofZISZOx8+jbC?=
 =?us-ascii?Q?E3khTYX1uQ23mwU5w6IyTrtUCbHDDIQvL5uNXKYWyOU7SvymxkIT90VWUb+p?=
 =?us-ascii?Q?m4ZNvxNGNmojcmD17JC57Q663ina5qUdrVL0z2I9s0ykm3v4XesZH8YpTXwW?=
 =?us-ascii?Q?x/+zHeceTgbkF+FNBCVaAJ2ld7KTgfMuw9Ih8UcWN3orQnPfNRL5M8wp8vZo?=
 =?us-ascii?Q?7MuxoZwJUmXquKpHktS4hxEOFYi0CFp4P7jygC0vZCAIVtdG3OV1meJVJDpw?=
 =?us-ascii?Q?rcY//+sgUiQ8AXUbRK/Thavm6Kky0Y86/1aCkk2DHSt875MYaKVASykPoK5t?=
 =?us-ascii?Q?aoAWvR1qJjYtYQuyJs6UgdMX6ZhXT4kc7Qx5TBgz3IGJWNejVBz/gfgoEAkz?=
 =?us-ascii?Q?s0rBb0IwRVtKy63xRh79UTSLDCAV+3TqN3DqOq6Cp4zqiB1PMTGiGmtqqRTY?=
 =?us-ascii?Q?EW/v3qVReOL5orqd6azRxvWoe6asHfzv6KJCneY4kYxo8PVLP2EH+/yH0ZBN?=
 =?us-ascii?Q?ViwISFbeoch/b9L/XPieRMzlsWN8dRunoBsaxvJsDHMxIGx74AIa/68oMaOL?=
 =?us-ascii?Q?xK9Dp45CIxAoU+V8L4LWg5bej+wPI5yNbO1P+iY9iClQwQRVx8UYJpNaPEOy?=
 =?us-ascii?Q?d/qCpg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m54WVTMTxBeFVLUQP+PsDKT8rS7MoAqL2SHdzypA1SV/dIbq9JGsbmS2V+KnuR/h6nzh6FAr+EerW3HLmYSzKiqLF75BzmVmxsNYRNmguEvRWfWrdMqcObesnQ1ySABLKWGQ4/crJQIlvJ/9sSZHat0AjaGSlCwD+mNyR3AhRvXIeVEgIbd2P2bD63fs3dAj/0El029j5GNTFEtYhpTLFvzkhFD/XamYINsnMxKywb/5cIyg8ejQYejCzR2hYy0PEkldwlsZUIJ+s4t1zOvbPNB7f5qKEHOYEUzNhh0DByYfwVLwgkDbGw7p4ajYsf3oL+mHnXGRR2heqYSPazqXy47Ayp9nliNO1xlFIguQOp2SoIdf7YDUnZYOdl8riSU0rAzoaA0t7LN7v2LICXwB797C7WtnSQpPyzGohOZjzZSxwMz00PCbxJH9pejx7qVv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 12:51:49.7083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7813463b-06bc-4bd7-6c7d-08de6c90fc50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9687
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258771-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8511913EAED
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
index 106ee1f2df86..73b1b0460436 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -86,7 +86,7 @@ class cmd:
             os.write(self.ksft_term_fd, b"1")
         if terminate:
             self.proc.terminate()
-        stdout, stderr = self.proc.communicate(timeout)
+        stdout, stderr = self.proc.communicate(timeout=timeout)
         self.stdout = stdout.decode("utf-8")
         self.stderr = stderr.decode("utf-8")
         self.proc.stdout.close()
-- 
2.52.0


