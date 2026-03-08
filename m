Return-Path: <netdev+bounces-265334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO5EAmvMrWkm7gEAu9opvQ
	(envelope-from <netdev+bounces-265334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 20:22:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6B1231E1B
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 20:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7E13302413A
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 19:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84E134C81F;
	Sun,  8 Mar 2026 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ha8MjeP2"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011024.outbound.protection.outlook.com [40.93.194.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D47332633;
	Sun,  8 Mar 2026 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772997697; cv=fail; b=ioUdIERvDAyxiC9El48mkmIYShdDMD5FUyh8FDD8HMMnSMJFuoh0hRQ6/lT/drOzQU6la9E6Xxw3GlRF4TQLYeK2IrR6BZ6TgMZghm1KR5BReV0TxfdRL3KuIsuUZeJLbYnl6B770J+/4++ZiFNfiZSLczkTyAITAN8DL9BbX1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772997697; c=relaxed/simple;
	bh=JTxe0qGgetTwn3E3NjrwFHOT46p+O6A4YnNKYuOXTPg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIi+F/64GOcOIgkUTTEE/VtjC/lOO3Moi4TQuihSvF1EDmXqZjnKSL4UQ1vMND4YdBnm0Y2Whfe68snieSBnXfiAkiTXtGGOY2A0uwbFEKiuDcp2QUwlayvyXQmSYJO75vmAYoU9abXkeXLWKwXJHRL+cZKaZdllLEqA4nCTKJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ha8MjeP2; arc=fail smtp.client-ip=40.93.194.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaVNeU35FuxpZJVE4psLbuLT9Ab4HKkEcT4NpG0BY0jdPRrW12lvPhLXz0mGtZKQOyq5EBeN/XoikTrSxj5GSc88Z58k+sVyQER8tgnHEX/qzSJSbYUx8LvDsBzJFxQlKq0/3AI5gCyAL6y1SeHkFbNJwUHR979H/mbckmrS2JR7VoB5xPLYRfFJt1EOYrfGrb86kwLEsi9WvAbiluowPlS7KtJPu7xaYCdlzZgRINeEiMJsay2YcVOIqrTYkAHphS5/QaAqxgOBnBa+XFGMUdLjQ3Lge2DnaXDZ/mgXQtlSO416SkIZAkbSrPqoex3uEP9aaqPitkr0DMA4+NjD/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKh1C/fXtMrj9h/cuqoq84a8wJ6qEL0ZYLWP/9xS674=;
 b=TpEzaGtxX/FHZ7cZdnTraZqWr5VCZe438rGcD698YTy9thgv0F3fsZ/6xLWHn7p5+oH+vJczE5qjNAQUUyhn9XiuyXH0/hEPijfQC469vMlmoN2KBXUGclud9kFPLkL7cK0hC+enUM2m6oDHMWrdczWE5mkbzvm3CxTq8v96cPmxH1I05ecGxlPJk5bxNxMH2bopK9CtoT2DDVta+xLPt5ioz3iTJkXVs4C+EX95RKJfGVj/J/1m3vaUQr9Lxrlte6FfMRUFrqZx4tmvQfm6aM2lY5XIyd+b5M1Y+Rk+ZyTVFnifNR/YX1JDTX22A4qwdaEXYgx36LpR/VzpXzkLow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKh1C/fXtMrj9h/cuqoq84a8wJ6qEL0ZYLWP/9xS674=;
 b=ha8MjeP2CJZEyGbPmxNeE5eU1ZXcioDhfVDUqjgoW4Gkgdr4O9BBzSvjQ1+0vICt9NGc0ElyLEfqcoQ8mP9vmdBAui5Ow/TxsotcrnC2TZTpYFFyqfTzPcKSlMuF/vdqJhjiSjuNzLheJkQ4iY5nY10eS1/b4SEMKyCe5m1SjiS+LUI1nUSGYF0ccdhKVJ/ncehegOZaDbNEkMTLFW5mu0jNn0kHnVs7gdKUOuTx4uWRocXyStnlzvjxXGjRYAau5ehddzmU6j8OXPFqlCqpQUnfj3nzkVvCyUJ/cNIGvSq65JEsMpItuUguc6rqMfycYiZ7MVM9Afus7x4UkDeS7A==
Received: from BN9PR03CA0359.namprd03.prod.outlook.com (2603:10b6:408:f6::34)
 by CH3PR12MB7498.namprd12.prod.outlook.com (2603:10b6:610:143::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Sun, 8 Mar
 2026 19:21:30 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::71) by BN9PR03CA0359.outlook.office365.com
 (2603:10b6:408:f6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.23 via Frontend Transport; Sun,
 8 Mar 2026 19:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sun, 8 Mar 2026 19:21:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 12:21:21 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Mar 2026 12:21:21 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 8 Mar 2026 12:21:18 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, "Breno
 Leitao" <leitao@debian.org>, David Wei <dw@davidwei.uk>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>
Subject: [PATCH net v2 2/2] selftests: net: fix timeout passed as positional argument to communicate()
Date: Sun, 8 Mar 2026 21:21:26 +0200
Message-ID: <20260308192126.2490631-3-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|CH3PR12MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: f59fcfdd-d7f0-4a8a-a5cb-08de7d47e676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	GyrUljdxJnutxyI2MJpfX8Nqeljm0xVKd+i19QfMiFTfni4EH2fsjBMSaOHpGzycY0wH6ZCl+Ku5T5VK8h04KvgUDyi6nPLZOcRXbDZFU8kCumDt8mREbmr4KwKHBeEqnyf6BTMZ+SRvzy+O7zMsRNvMBPZ3n1N8wnGxrHkQyorPpfbO0zHK4+bjJ3pXGzQJkhR7NwdZD0WPOwWNk5tnuf6VTGYhSU4UMlJtpz9Uv9hnnDAXCje6f/RYdI4GKgAqjEoIoZa9GZR64wBu/4uDzPqqTRUxLT1HsBPRuR3uBoT0bVKtMZhIPmT77nZVVIEVK70gr84+WaXF+Gld6Mjg9iJf/Mevkblp0zVtgKh8xxfiOxQWxA05qzrLQvYvSSG66U+UZHS2mOutQzyE160ZD+LvStCEwRhqfqekM3IpKp0a4MqGEQnpiyntFj6CB4TTeC8eqk0yanV5slBWPkaMTMbUdvgVG/OmRcFmolYxZFzdlDEmHl76sHmjKJxDfJAkmhJRIqQnnw5KfisclPl3tXm++6aczSdSrrJQ3/ktPh6sitSg5hokW5qiFAifPyRnBm7I9QJZlBj8AZB2H7DMnU/0/IZv8/buYqkKHPAUl2a3zmIT0HtzwQvxKS6ZQ+wJKOMxxSQt0HyoOLKuKwamafXAFah5mCBPiQ98MMpBgSVd00Kbv7I2CBQQuA/h1/AMI/OP/gDzTwRGqrWqA4DedHU4doUzYym84yVxvAn7AvQ4s8BD22Xb28DCdU6WqcitrhBJ0I0tNEpTofJ+SOc9zQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yyqhPkOnKJZlPlNWGPs10l4WyRdCrYkK1xREXVimDu7kdDVvSNK1PJa4ar+4g4bzV80FK+fUhWmLJOL0d9DVborhMGvZ6dBmIKeNomrSUOSbKb+WKbYldVWJX6qvV1sfhG11nWTzRDigjMCB3qUQ3OafJwg5pliaCk8FEM1Qhmz9spTje+qdAoCc9qWKIL/Tgy/2+P+tf6GiR7xUAcC+J4E83wSNjO2ACrNh9xd5avh7i0eLO3XL5BZrePKjp9iP/w9w8TXZcSx5D49sFKqFse9Z7jb+W06NBc7S0BdUCHZiUeqHKhBQaJgkXoDroGLIZHVIc3/VGqz+mx6+LCRbEjGUOeh9wCnExj4dc6ih+Sg8jlP8uaKXcI1WU8rEzm8aSmAGQEOIvwFUoJbHh75IWWuzZS/AAin1jUk4M+v4E+VOO/Qp2e2fCFKRsOIhsry/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 19:21:29.4081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f59fcfdd-d7f0-4a8a-a5cb-08de7d47e676
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7498
X-Rspamd-Queue-Id: 9A6B1231E1B
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
	TAGGED_FROM(0.00)[bounces-265334-lists,netdev=lfdr.de];
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
index ce4fa4aabebe..4c98ddafdeab 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -88,7 +88,7 @@ class cmd:
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


