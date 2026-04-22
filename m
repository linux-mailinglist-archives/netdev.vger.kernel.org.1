Return-Path: <netdev+bounces-280434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKnOFGnW6GklQQIAu9opvQ
	(envelope-from <netdev+bounces-280434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:08:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD47447134
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BEAD30210A7
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0332E3ED120;
	Wed, 22 Apr 2026 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HYSRXRRh"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3963ED10D;
	Wed, 22 Apr 2026 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776866870; cv=fail; b=LkCYS7AjSe0Fy0gKpTBrCRaZumJ/7AUfXgsBl9/3CArvlxqmzGcbC98tu1JxBslL6TOQmthx+9ppgba1nXuBOxgD2+5eH+iHnljY28LbiyK3KnB/yncasikswKPugJvVeK0SxwwOHBbb45369TCLONA799i0dVtjG/96Me5nZ90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776866870; c=relaxed/simple;
	bh=ZJ4UYbz+98oOtBoiq5CkYbqJKQhd88FiC/SQddXdBT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0ujdxgQeY9zbx+zHZCkqxWvF27K2aTLatRS5qE1GyKVV/wJZpE+gfUqnTVl54tC7yFpa5wpwNbztE3GuDVJsoCWh+XEQGdQj5fWZVCBV2lmM+WJhAos03IRn6yiU59fvvf6c/jIcDwKUvlCh8JPD4RS+Zzlw32YEEdBTkRw/Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HYSRXRRh; arc=fail smtp.client-ip=52.101.85.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbFx5ENUZjOYtEHeNmucxf0j8HIWASnQ7LI7x8vjZI1jsFNOMdazZNAkeS2lX+q5sT8OFAWqg41P//uv4r8fYRwpCRa4fPZNC3Cp2yzBmrp0bTtRuT+sk5xjHeQ7fN8hMbTsnLzQIRG9zNYG5jOLHDu5U3aTXJgMYoLvOJvZQnplfgPy4aGWJ+H4D2nToSiO6obJEyWDV3bjQlKqGCvuFAzX436aiSk9RLRwZfuBOk0/suXUi/Ck4KMpbhIx5FDZ9MT+hSBAh1/QDLDCD4VL5An/rTHywj4krxHdpABIuEpryeNVYGM7rEQkl57LC/tF6O0s+hRdMQR8r3MKNA87RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4POw4qjzznSWgNxQhEEXdGLxSPPriNnnVw9FVJazPw=;
 b=d4EYMq/99AATe/G0/iJQXFLZyloxM3s41fHGnTQa+jb+qi2MEt7s5tXBA/wLJ0wlY60acp0asXNsYddeW5JGNPKlIvML1saS2oebqqv14aLrflhyTCNlg9PsNIzNmiR6KVArd8kvppfvBntvaCGxFjl5b1DQRxmDI3nWl9rlKSjb7ij3GJQSMWU3RWxC6yYzWZJjXi5VM1X9wUZpY/+SswuhjGGz5CaR24D3AiCu9wmopmBDdikivaulhljfZoDAeACRDT4Jh9eTiknjluT4212jS5KkOMlv8Qjz9cSlweOIaVC2vx6PRVK5GIpYMSYhauBMplZibd+HjA+XYpVYcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4POw4qjzznSWgNxQhEEXdGLxSPPriNnnVw9FVJazPw=;
 b=HYSRXRRhnNjcqfEqhY33yI9mLFIq09W6hk4tgXhCdDQ6b4Tau+O0/QVYRTlsfcstLEqQSG42ACylmL8XQ626RExMtzs/5a5c7Foz6SAuzltQYSxbhCFLI874b327VETJP5TYVhYvnJI2T5ur3OnVxAM8JQdemBG4r+ekL4rjSWjQF3OxjX1kOZCMyQslNMsgE8Uj+rRcAjBPLjeLoF40Jr2xnz0Zj4dJagn8RL2NXeqc8qydTjUJVLj1m+s+q7Vl3d0VVynX9+bh9l8/dw3mCBUmHkrwWsZZ/gO7CC6tw0JoocqqmmTjJlMwshYANrRO2xzrag3VrYmxRZBYBEKhBA==
Received: from SJ0PR05CA0118.namprd05.prod.outlook.com (2603:10b6:a03:334::33)
 by DS2PR12MB9751.namprd12.prod.outlook.com (2603:10b6:8:2ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 14:07:39 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::3f) by SJ0PR05CA0118.outlook.office365.com
 (2603:10b6:a03:334::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.20 via Frontend Transport; Wed,
 22 Apr 2026 14:07:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 14:07:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 07:07:15 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 22 Apr 2026 07:07:11 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH ipsec 1/3] tools/selftests: Use a sensible timeout value for iperf3 client
Date: Wed, 22 Apr 2026 17:06:46 +0300
Message-ID: <20260422140648.3877129-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422140648.3877129-1-cratiu@nvidia.com>
References: <20260422140648.3877129-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|DS2PR12MB9751:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aeeb4c0-6cf1-4521-43a6-08dea078836e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V7lEQINlpzrmpaW0eIaBmwSH7/LWnjhlRhD0u2Bh7f4oYmnZALfBKhbueTBYZoFl+Niib/X1wSC0W7Ueu2yIrzakXd/iWz8Za/UQpeHPucL4Zv3t95E9gkwcKIk5NvoQutpDifvie7PxUzF2tFvTzTsghTIMXARG9U1F0u6PrPjhlziXcnpKj8ndEQqlnA8mGmufdPubBjE/fI129ilmaC4VeMM92nCiefwKcHUcRBPoIZCGkMxM/MfmxY/Fh7174FcK6sw9eWEZGvH2mFFm4Ip8wAfaY7UsRDHbPfpgMuhRCdE7wjjvuex9sJv6vv918xYc0QqU0fP3JGJO5nMGib4C3VkE7pkYJHJ0iXmFq/SPS7egbvHYmPflim/Rmbcy01F+GABO6B8HXm7VKDHvRsnqA/sDTo4kSO75AaLA2EcJ//6xRpIpOYtjYUFjj5jP8STR8H6Dj8K0AlLDOCo2lNjNpNFRagCrLX+zKINOdn6PBl9af4s4e0fC2JLmybSrazuS9jDqQMnsUrML812PMAQiDMsbNSPrR207OyWKK3s4YSBWWEuNnluDyWVV9jdfW7eP05kCmuKi7k3yNp7A3Ch2QMPJhvxstr40TqezStTn5HP44ua2620XnQ5nATFOOJ1gqwmv4j7/GGZ9UBgTTChtjINqIfDpk7vkDHzgDCdTUEiC/PrskvJMKjgbx2n/a2RzPL+3kxDhILSOA8+hybPRn8clIWm1wjGZBL2OeqUozguURcLdISn0SDAFNMesE2ZZQRT1uPOTjBG24Dwmaw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pcNkkNzh2nsfoexZo6wSTupcNyIsrHAs/OCx+tCUX2ongQBnmrJ9Qt+pWhtzVvpzb9dCijKMiS2oVbt6uYZ+7dBnsHympJeON9ZvJS2xUstUfpsCqiQdl9+9Lwr3ffC/fvJFmADbjuGQm+UYEh/0ze7rFFEIqb7cbuSR2oQXN0UM6U1cu9uPnlA3YlHpdzc/PeEXqxFAedjSekOcvmKqc5UMu8fjUGbzhSdBiBfCPCV8F36Bb6LvSY4MqAsbwSGYFd+zqQBdP7hh9moUTgARcNnmKfrEwnvul9jr0cqIUzaOKT/PaJT3D2HlnHd5gyxoMlNTAjVmLd4cabuGzFSrydp4y7s5qxAAACQb/1MiwE5dho27tueUeRVGoCoyOPK9p+9I3Vp+Maql7JSY7QhABDgwFF/SaQ2qx0g/bTxoUjrzFrS8zTyhYk8aZFPhhAcs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 14:07:39.4390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aeeb4c0-6cf1-4521-43a6-08dea078836e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9751
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-280434-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MAILSPIKE_FAIL(0.00)[2600:3c15:e001:75::12fc:5321:query timed out];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 5AD47447134
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The default timeout of cmd() is 5 seconds and Iperf3Runner requests the
iperf3 client to run for 10 seconds, which clearly doesn't work since
commit [1] enforced the timeout parameter.

Use a value derived from duration as timeout (+5 seconds for
startup/teardown/various other overhead).

[1] commit f0bd19316663 ("selftests: net: fix timeout passed as positional argument to communicate()")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 tools/testing/selftests/drivers/net/lib/py/load.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
index f181fa2d38fc..e24660e5c27f 100644
--- a/tools/testing/selftests/drivers/net/lib/py/load.py
+++ b/tools/testing/selftests/drivers/net/lib/py/load.py
@@ -48,7 +48,10 @@ class Iperf3Runner:
         Starts the iperf3 client with the configured options.
         """
         cmdline = self._build_client(streams, duration, reverse)
-        return cmd(cmdline, background=background, host=self.env.remote)
+        kwargs = {"background": background, "host": self.env.remote}
+        if not background:
+            kwargs["timeout"] = duration + 5
+        return cmd(cmdline, **kwargs)
 
     def measure_bandwidth(self, reverse=False):
         """
-- 
2.53.0


