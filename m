Return-Path: <netdev+bounces-152329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F56D9F372C
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62618188C18F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D734A2066C5;
	Mon, 16 Dec 2024 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t/nzHAS4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE12066C3
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369213; cv=fail; b=ZulmWSws6wursxny2pKDhu30wce8yr3peTzLSy5eagPQLDU1ABFmG1oyvfr8QJ+pWHmWbqjzUj/h4jwlxf8rFTIipAp1o9/v9FdHw9wSMHje8Nia1G0lFhBcY3dJualfMC2hotJPZhWVkLnnexH9DOv4z8iq0TOhdU8IqpBk18s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369213; c=relaxed/simple;
	bh=KvnDQqq6PmY3HromCIaJtjgQrYw1a5oDa67gDkf9Zsw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqL0JbwAloGz6cKaySRzbcZC29f98Q3GMhcheSb3yUxf0Y1vxRbr5THiyzmy/Fk8WKY/wFFECsLMmq8+sFlY9Eg2R1a/Sq23EnNCGUQYRQ+HlrfLpp9B8cCTXvnOTAlw6dntfzqa21+pmnyBOdRKZ8ydpDxr9NgcoC8LuBIHHvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t/nzHAS4; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwHNRw86M/S5K5MMAxVCQYnGWbXTOBMRHs6u/6eu4WoI7BHyalC6SJMkyKNsHwLMfrIhwYV6aPPWCS93aNkCp1FnRvipYP26R04wj6kcR2ZM7Z+cGieYfm6NsrGfE4xpq6nEe43R9oXkIbIDo+wFBo7S9bGQ1Tj3A0Hk8ksHekp+mXU07YA4hYq7Jklbbn3LSczxS1zTA2JdwteSBZeGhWYQyl97f2ymcZ6FzkzhEw7j3teK8d98oB9OnB+E8IyeCsxLFwAXVAjR9pCbPCFy2jFqA6axAsqTWvzsix3Y33PG6O/CZRfD+CJTcoTKVGLpqETzU7/J7dt9yWhMVnPEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NN8PT7XXnux7xronDRunqhkv49Jzmb8i2Zbm9kdOUJc=;
 b=uhnq00WGbwzRYbFLCxqqfdsg2S/seVIOB1vRaWDDrDPwTSpngIXQbaMiq75mooZHkTks/bnjpM0oEAGyJ9BDDu2iS9+6ofG4uiicf6KwFIJ8f59vYS16h347WO2kwi78HnsCoO6LPgNP0dmA9YaXDWugXTKBapvDF8VsTXD5PW7AFYyAtYAEFDolXlCXni/bQ+dqJD2FRbAr0UURu3RBSzbc2KFkr6NnfQdHA19pofhs/Hyupc5DpS9+0EIiSre0A2x5M0zuHvYWfgBSmDqfsm6hoOlKZu0K7ueioh2lYAW3AjlhbyN90KzTiMHFtO99s/VoSvseciwc36sHiAINEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NN8PT7XXnux7xronDRunqhkv49Jzmb8i2Zbm9kdOUJc=;
 b=t/nzHAS4vuJLX+MV7fLvVMseWdNm6Hw6or0IQhmbVbmkGh6yp6+PnIKiCnPVDvVSgf6YETRAZ47iKPd/7hRawSEH05nwyR+r57rBBYw9O5gElTIqsrPS9UJ0NIsZ0TOlGF+vhGh69rDcBo6To26/2lYr3qVrAEsdgpex/NKOHNvC0Iw1cwAIwSlGw19/pGlyJw9r+VfsxzJm7H9A2xK235WYn8yDFqkyVAu42JbX7xYdtQIGxsxROsgTENn3gLhkiHRk+BHc8/b2MA2MfHyn1AhPoQig8nvNqxS8PyqK40QB3wujzp/ug7a8cwy6dJgfR/4FAgmyWNOIHy5aW38DTQ==
Received: from BYAPR05CA0090.namprd05.prod.outlook.com (2603:10b6:a03:e0::31)
 by PH7PR12MB7115.namprd12.prod.outlook.com (2603:10b6:510:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 17:13:26 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::5d) by BYAPR05CA0090.outlook.office365.com
 (2603:10b6:a03:e0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 17:13:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 17:13:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 09:13:13 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 09:13:09 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <donald.hunter@gmail.com>,
	<horms@kernel.org>, <gnault@redhat.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>, <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 9/9] selftests: fib_rule_tests: Add flow label selector match tests
Date: Mon, 16 Dec 2024 19:12:01 +0200
Message-ID: <20241216171201.274644-10-idosch@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216171201.274644-1-idosch@nvidia.com>
References: <20241216171201.274644-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|PH7PR12MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: aa070e4a-a989-42d9-32ea-08dd1df4f3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UymPIY4xwx6JwXmXotAPioxE/YE9rxZw2Q2QK5rp1hLM4DLGXDCzwrCxuiIF?=
 =?us-ascii?Q?UDrFjqTlCKUw2XcrFJas3lKEJLZaI/vfB6aVsh1aD9VZvJgp65rWxeW+O69a?=
 =?us-ascii?Q?kGG81Q4/aB8JlyNOg7x5JkSjF0FHi5ImwJAZ3rqB9avbgE4X0oJzj3YlupRa?=
 =?us-ascii?Q?ApSfjBORd906WTJCGEMrk8NPl4bzbYudKG1OP5f2VJgRUrfCTQT+Z6HBmhZ2?=
 =?us-ascii?Q?iIwOFrHe5KVzjpFAG+k6BtmHyjCwnfNicOkjKNABFisLr0bifpv8/lTJDUcr?=
 =?us-ascii?Q?GC7FXP+gM0KlAhoT2WpLm3W90wPEoHNRY0b9DJ84zMZ73/GadGWax6824JDJ?=
 =?us-ascii?Q?F5luwJ903RRiF5FVxI/ypflTUXP+S0m+1N+mSnmK75eTP9a6SnhAihkInfYN?=
 =?us-ascii?Q?JsCVqWJCpCIYi88Gf3N3aoC4sKrgzq+2NKDESk5TmOokdyBON1J2yFtoblRu?=
 =?us-ascii?Q?aI11SQje1IkFiRXZpuc0gBSDfSz8Hys3C/d9LueOvrRCOUpSfVYOQUh9I8he?=
 =?us-ascii?Q?zSjK/k8RYV4utHAK5yJ91LaSzOLoNhrtJBE5v4fWI/dBEqlOJCoit8LjJC9i?=
 =?us-ascii?Q?GltbVSzVpQR6mjpqJOltKlFfEmgAecqZ722CoaptluvVKDlD6r5zIGFB8x3I?=
 =?us-ascii?Q?Qm8iYOua+zFV+kJGg1IugY7IdTOpb/xeZaIERMKeoKGFylizkKNZ1HQYIf6x?=
 =?us-ascii?Q?+XR5uHxLqXSapoHGy1M3tM48dGMUyf4bVKz23HFO3lScj150A73abm1p1CIX?=
 =?us-ascii?Q?EqcSOYSxErey/on1q1KkEmwLVNfotfzhjFxxixEMIu4otL8/Mw4opkojJlCP?=
 =?us-ascii?Q?p942xSDPWUR4DMl50FxJXrwMBrLjbRGQ+sRTz3eGJymasdZ0FjmdH8gzNWSB?=
 =?us-ascii?Q?vAUIl/wXXj+wGhelMRgMYws8k1ScyUUwBjIqc9ANKqwkBKyuEPswNzrgQqKW?=
 =?us-ascii?Q?ETVDWAjOn5XKNfdMHnW3wHKUN1pk4J1WYaFqFJIzec2/jblWSqywUygOGk8u?=
 =?us-ascii?Q?48f3CDWoZsyGybluTuu3a8JxUqdom9kEhE2uWj1jxp5nYOa1Y7+YQnlPS+l7?=
 =?us-ascii?Q?vN0lVYDouDT+5u4o1mj/jlgSsZqeCbSu7wv+W+vZ4UAk1wNZGNIGWUGRf7ZB?=
 =?us-ascii?Q?U6Bziqqe4FDJu+vPTj7dqHypaBPvdT5IRHl+KEpZlZnk729EZ6hJioruPj6h?=
 =?us-ascii?Q?fTLRj/nEGEJlJWwr0CnesU1x+cbuwBj3uuk/M01bp+AWPU1MCiODnExhUsAN?=
 =?us-ascii?Q?l0MTIJxttIDvTrYnsitPo3gUiPlyTIUGU5KnsXxsif8+EAVtmR67dpdW3X3y?=
 =?us-ascii?Q?ZYi08922j6fANqvvEqPB5vvPitDPVdSRB6Cw7iJqYNORPe9EU30caY5HK6GR?=
 =?us-ascii?Q?Mq0IFrnaVqh3Y6FSO1J9lFmdx1EohVNNNgNGTVV4nUuyGclJF1RPUGnb8GFc?=
 =?us-ascii?Q?MjOnDhHDVNdZGWJgRb1461t4ZkTnDvThZu1h21kFj3wY3yuE/bMa1Yv8EE8q?=
 =?us-ascii?Q?SeNynP5/Oiu8040=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:13:25.7674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa070e4a-a989-42d9-32ea-08dd1df4f3f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7115

Add tests for the new FIB rule flow label selector. Test both good and bad
flows and with both input and output routes.

 # ./fib_rule_tests.sh
 IPv6 FIB rule tests
 [...]
    TEST: rule6 check: flowlabel redirect to table                      [ OK ]
    TEST: rule6 check: flowlabel no redirect to table                   [ OK ]
    TEST: rule6 del by pref: flowlabel redirect to table                [ OK ]
    TEST: rule6 check: iif flowlabel redirect to table                  [ OK ]
    TEST: rule6 check: iif flowlabel no redirect to table               [ OK ]
    TEST: rule6 del by pref: iif flowlabel redirect to table            [ OK ]
    TEST: rule6 check: flowlabel masked redirect to table               [ OK ]
    TEST: rule6 check: flowlabel masked no redirect to table            [ OK ]
    TEST: rule6 del by pref: flowlabel masked redirect to table         [ OK ]
    TEST: rule6 check: iif flowlabel masked redirect to table           [ OK ]
    TEST: rule6 check: iif flowlabel masked no redirect to table        [ OK ]
    TEST: rule6 del by pref: iif flowlabel masked redirect to table     [ OK ]
 [...]

 Tests passed: 268
 Tests failed:   0

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index 1d58b3b87465..847936363a12 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -291,6 +291,37 @@ fib_rule6_test()
 			"$getnomatch" "iif dscp redirect to table" \
 			"iif dscp no redirect to table"
 	fi
+
+	fib_check_iproute_support "flowlabel" "flowlabel"
+	if [ $? -eq 0 ]; then
+		match="flowlabel 0xfffff"
+		getmatch="flowlabel 0xfffff"
+		getnomatch="flowlabel 0xf"
+		fib_rule6_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" "flowlabel redirect to table" \
+			"flowlabel no redirect to table"
+
+		match="flowlabel 0xfffff"
+		getmatch="from $SRC_IP6 iif $DEV flowlabel 0xfffff"
+		getnomatch="from $SRC_IP6 iif $DEV flowlabel 0xf"
+		fib_rule6_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" "iif flowlabel redirect to table" \
+			"iif flowlabel no redirect to table"
+
+		match="flowlabel 0x08000/0x08000"
+		getmatch="flowlabel 0xfffff"
+		getnomatch="flowlabel 0xf7fff"
+		fib_rule6_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" "flowlabel masked redirect to table" \
+			"flowlabel masked no redirect to table"
+
+		match="flowlabel 0x08000/0x08000"
+		getmatch="from $SRC_IP6 iif $DEV flowlabel 0xfffff"
+		getnomatch="from $SRC_IP6 iif $DEV flowlabel 0xf7fff"
+		fib_rule6_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" "iif flowlabel masked redirect to table" \
+			"iif flowlabel masked no redirect to table"
+	fi
 }
 
 fib_rule6_vrf_test()
-- 
2.47.1


