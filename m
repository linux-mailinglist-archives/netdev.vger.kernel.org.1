Return-Path: <netdev+bounces-269526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEPCJEwgvGnQswIAu9opvQ
	(envelope-from <netdev+bounces-269526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:11:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CFA2CE7D4
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 008CF32E0A67
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F553ECBED;
	Thu, 19 Mar 2026 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nIeWg2eR"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AFD3EC2EC;
	Thu, 19 Mar 2026 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936273; cv=fail; b=Yop78bFJSLF5bbsIYROSwFUeoIboS0qZ/qZXKta/tU8WvaQX/bwaCOiA/WakgcnRi1udGr+IqPMEzG46ZMfTD/ror5vgxaVTcu64WRvaTibjgPciKSk29xFAEYVUummugLvfugqOAIgZ+06P5BqoXxkrFhXFF2XxG/ECbZPWkqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936273; c=relaxed/simple;
	bh=tfiZrW+J8Blq7A4ogOt7YiU2pvOkimJL17EW4WiTBOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ELcz3e7gpzTsk55YpKALqdU93hnIgcfvAAJpcRt84t4+Kc6woD2d8ln5w0Lm1Xqdi/83etroB5J9f47LFDbIg9HLFtK8bjgtCKXeI/lYdbh9bbpCV8yFeFyT1JdtGSGZ+pyjx82ngizPafAKyuZpiX3XgmvjPua6nZmWseHmLvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nIeWg2eR; arc=fail smtp.client-ip=52.101.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3qek2/9m7twbTRI37Qu+Pwo2l+VIjeWIilu4mmmjQ9dZChuxA4geBDhB89OQ35WU0lNElrHE/JN0qiwguLYMRHGFHbT2qSX0yxw8tnNvpqCoIQ890TPAuaHSLDb5+FWWsDVB84gy6q4H1tcRVOv0tAZ0ybonINi6pjDjzNv40whzWMT24RIyQp8xTY28mQ+WDaTIBJEIjpr13EX87xIfhp4hDAtB/Xhh4rlPM1gJVvdEBtsdW24s080LXeballhKVG1H1zwJgGetSSfz4IQyEf+CR5MePBldDPWDugMlWIZ4hnKzqIxZgnNhsyUvN/lg6hfFNyID1qnqx2Bug7+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1L73IrMu9sEXEnjFKfMvaAHkIprpzNJiihnttoIg39Q=;
 b=HctzYBg94nDJYqlfgXfqhLnNPbFdv+u+Qm6qWVh82bRYtJVoWFLYt4ip2SX8rXnFvEKM1zMsFrnPgnxs1jFLn35HFJu7dHNlS8qyiTvR1KQIjj/zyn8s0+gHDGFWgEkXYmwA28abXXZ/qlUrCappXFGIahsWeUreLwlcMbLhNpR0gPS8N6RAVMizlMVsm7Dy+DBd6f8FS2v55EDYOKrqJtZ7bWQ4JypScK+V3HcfmqxQ0ISZWIvE5cFD5zpoyBW+oRayWLm8Q/yR7Uilt0KRTzAr6oz23kv21S881Q7BWjF+apOikpDnJ7YDO+gmwacz4hpeZXPZJqOqOw3GDIkbUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L73IrMu9sEXEnjFKfMvaAHkIprpzNJiihnttoIg39Q=;
 b=nIeWg2eRTgCQSHJkzTZ9FblHXKbyrcSIUgRnF+a8ojYpLkg1okTBrSn4BbFKJwpvvX+CHPIHhaPMoMFAk7PVFIwrd9M40jq/AVWL6b2ePYiukbzYvTG8oa+Tqs+T/ygDhXwbh7AeKYKJLtkLDMQbrXMS7YBvhWFy9sB5a9nezBgIMmtN49F3Cz5XD9qMh3S3qKjcS/8PpKs9gAsMUsRKOkgTeM4ZvM35o+h3KPi9IpwsK0aZRQm6VuHH16AJ20pxy0WS/F6QENOiB89+noQcZ21m8lwp8tY+JIi0QSekZrWUWe5Is1/YpW1kWqmywsZf/uIcf7TiMw8JKvNmtdaeYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GV4PR04MB11451.eurprd04.prod.outlook.com (2603:10a6:150:29b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 16:04:18 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 16:04:29 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	petrm@nvidia.com,
	willemb@google.com
Subject: [PATCH net-next v3 5/9] selftests: drivers: hw: cleanup shellcheck warnings in the rmon test
Date: Thu, 19 Mar 2026 18:04:06 +0200
Message-Id: <20260319160410.2515105-6-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0316.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::16) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GV4PR04MB11451:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f56501-e06b-458f-45fc-08de85d13358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EqMxF9PdK9CSPsNQclzN88U+8ZCB7UD4bvcylfnhHpBSsPA1PzGtHDCsqYDSmQhqPHfPzsU/bnFx3o4rRz6OLP5Q/OSD+VmAq7SHwXmnkKOEFbhzyX6W3+Rprf+PiwGqzQ0SGCN4xzdvzoKqOkI1Q/xkpfoGRu8+swqJoE/pbP+ZwWnWJV2zmDiNRtLeEujD1Ho6PpebmIcFo71VXX0yFQd4pfMRRI2vmbhZOfeMynqrFVxeqHGy3aTf7U2NtncVSy9LC/1kb1iI1ulGIH5npDgNLO/hc3el3vdh3aIlvgdTri+YcPUGIwT8J100HpLtyJMM9Oc9yvEf0hdAqv8InR8SdkigopUy4hPIZ6ilWJ/UyMb0V9CHPQbEYjXM7BV2G+yKKiulCXV/NzQieMhfOtFIceaV3R65GqFcfFVMxIa2+pJxwM6J8hiJ4ifebaVzpPYAht9W+1a5UeUbaC91Y7nzpcE/RRSvwcCmar5GOh9i2EFczVBc1Ez05ZnCxzKrnl58Fv6LTA3DxLwaAThKr9LU/sBW5PdHBCXdsYqxp+B5v8Vv7X+Yx3x9zgzntnslZ6ni2E0bJnVXnNvntRiLIUNdql5Cg3px5qdgsZbhJHirIZ7U0UWaMtojcBOgvN+dofmGtJbrYnJLDZtloEjAX7cx288hrBWD6MU+EYGi+Qa/XJdJ9jNOeg+kxLG1J8x3ZZipCZ812RA4DMAP2iiqtAfiB7ObiVScTmDpOj9cF1E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xKq9SOpoknvWn+FaKpKlXAJ6tqdNt1Q4G5IHg1+fNsnYDr/RAJTyskVo/5Tu?=
 =?us-ascii?Q?ckqgUUmBK4iiqvcRA1o/FeFfKMTipcsrCtTthu/c7B1KFWBBn1fIAiCvHcWN?=
 =?us-ascii?Q?6VM8N4gL0lNE0BFRnuQHwHnf0pwbZx2Xif7Fhqw7inFDF+/IEJhaosNwbf0X?=
 =?us-ascii?Q?rZMHgTQe93cVXUlnxPuk+EEmVfpY/3HXr1HeoV+hNOsSmZ5ojEBX82cNLUOL?=
 =?us-ascii?Q?+JsAhj9ZjcUpO8GKhE9Wv8PmxlO/TrU0/nVBqNxN5GVlXgKUETWXwd6i13LV?=
 =?us-ascii?Q?He8u0C0D/UUFFW7qPD1aLBSmBguP7srXr5DAKyJqjWiFEgUi73GsN7J8b73d?=
 =?us-ascii?Q?JR+/TscZs5Td24XWyuX6Hs6HnmhH8S+ATtZzhMqpEmXQnmIZ86G17drqMnep?=
 =?us-ascii?Q?ciumbPKpPpP9tMR9aZpPkraLWmrsCJnC239njTyWxW/42zWQkLfRaglROh+X?=
 =?us-ascii?Q?a0xuGoOZlscCTaHBcdgQcXyNwwCAIOUyLxuw3JrYlz5apmWM1dcT4GWMNVgr?=
 =?us-ascii?Q?CaCUv+XCyx8yAPszN0Q3Jed9/WBA+g8efQVqwmEBU/0YUaQWMPHUYF1ojWUP?=
 =?us-ascii?Q?+3w/1oBwIpbb7oJUa94pcLsLRMW6jRk9AX07Q9xhTjhHQ/QNDOeJia9Ld4A4?=
 =?us-ascii?Q?+f0OhAhCGI75l/RIdzpOk5SE0VGiKJ9xP2Fe1hwMdCo+6Kf3RGtOoOkZEVUi?=
 =?us-ascii?Q?foU9y6Ui1amyn5cCN0vIpSviM/wZfaRJbvwJGw3/X7KVtPJ4hhoevZM5QiNy?=
 =?us-ascii?Q?UKpXSBsUI4H8yALO/X6bgq46yYyldSADtJ7SheVrZcKCW2549cXhvJo8wMmv?=
 =?us-ascii?Q?496rqtHJBRHpxsfdxUolopHfPur9a8hZHBhBMk1uEYzAN2d04IUXn8+8StpQ?=
 =?us-ascii?Q?MZwWwwEXuegxeg+CK4hO1F4LlLNTycY2R7PmtVDBVxBTQl2Dvoi+fuc56RLi?=
 =?us-ascii?Q?Pfeqc+w/LqMzOaJODCw0PmXHqdjf7VjmGMIUqJnYw+gLyQjwy2qvdpdp+3V4?=
 =?us-ascii?Q?QJb39zkDDuMfag3FBHVPqIRjwBLEXVwlte8+BelCG/64tsLs5ZxfGMIOS0ih?=
 =?us-ascii?Q?0ceWjlygxIqRLjMbPj3snj8WMlhwR5wCMEwwwbkka7pKudigCQG8cH1IP/hX?=
 =?us-ascii?Q?MIZiJHBZof1+KKKMo+UfxTSUn5pXiF1ZTeZDFCiF9NVJRkXWqAe2ErZkG2I+?=
 =?us-ascii?Q?O5UUoxyvXQA0d2Frd+OmA5ACLAQ1E6jLOh1bVQLcXop5wdk27ftnhupBMFoN?=
 =?us-ascii?Q?5SEf330Q+yct47Bm0Ju2uX/C/1mvmQXNNtOahUq82khZPI3xu8Z6scMwErOu?=
 =?us-ascii?Q?AKWHUwn0iWoEtVnR7FrVVBJvmoODnW+f1+ajl2c77j3XAe1qDereA2tnIS0n?=
 =?us-ascii?Q?7SyuegEM7JKEDjxIqNC9E1oFXqzTs6LwunngZX802atFsUEDsygRXpv842w9?=
 =?us-ascii?Q?wKU2AG0Zbd3wpc7TiQ35ETrwUDvW4n0ExY/B1k//VTw6cMJpza4ohUrjYbss?=
 =?us-ascii?Q?Qn9hWQflgm1NSNNqMOT4M8tvq9Io+Zw4xgeyup/YYnq67Z8+vgoXf9/eU69H?=
 =?us-ascii?Q?ZhQ3EJRchCm/B1KzgsZGjVyT8MRpbm9C15qiz6sTyJ0vrUpkl5M6AwGnY866?=
 =?us-ascii?Q?I1eTKaZ0FA2PSWbfYifVhgYKuOguj+3J3gfRplU9SWzrw52o1SPyVQCOaQ04?=
 =?us-ascii?Q?BL80oiM+2oFt+bv16FYJtTjQVzb0Ar+46E/uUgwBwVbZSnjXllzYODrYCA65?=
 =?us-ascii?Q?1Hq3u7yY0g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f56501-e06b-458f-45fc-08de85d13358
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 16:04:29.0331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtkmcgL+KkEOwpa5CltP9pF7M2yaMkSW6oHuEoMebxl1O5DHDsT9E7QEmN3F/1fqWEiDVDEHBbHh6BBoxlHjKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11451
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269526-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.955];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ethtool_rmon.sh:url]
X-Rspamd-Queue-Id: 39CFA2CE7D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If run on the ethtool_rmon.sh script, shellcheck generates a bunch of
false positive errors. Suppress those checks that generate them.

Also cleanup the remaining warnings by using double quoting around the
used variables.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- none
Changes in v2:
- patch is new

 .../selftests/drivers/net/hw/ethtool_rmon.sh  | 53 ++++++++++---------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index 8f60c1685ad4..417627e7a592 100755
--- a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
@@ -1,5 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
+#shellcheck disable=SC2034 # SC does not see the global variables
+#shellcheck disable=SC2317,SC2329 # unused functions
 
 ALL_TESTS="
 	rmon_rx_histogram
@@ -19,11 +21,12 @@ ensure_mtu()
 {
 	local iface=$1; shift
 	local len=$1; shift
-	local current=$(ip -j link show dev $iface | jq -r '.[0].mtu')
 	local required=$((len - ETH_HLEN - ETH_FCS_LEN))
+	local current
 
-	if [ $current -lt $required ]; then
-		ip link set dev $iface mtu $required || return 1
+	current=$(ip -j link show dev "$iface" | jq -r '.[0].mtu')
+	if [ "$current" -lt "$required" ]; then
+		ip link set dev "$iface" mtu "$required" || return 1
 	fi
 }
 
@@ -46,23 +49,23 @@ bucket_test()
 	len=$((len - ETH_FCS_LEN))
 	len=$((len > 0 ? len : 0))
 
-	before=$(ethtool --json -S $iface --groups rmon | \
+	before=$(ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][$bucket].val")
 
 	# Send 10k one way and 20k in the other, to detect counters
 	# mapped to the wrong direction
-	$MZ $neigh -q -c $num_rx -p $len -a own -b bcast -d 10us
-	$MZ $iface -q -c $num_tx -p $len -a own -b bcast -d 10us
+	"$MZ" "$neigh" -q -c "$num_rx" -p "$len" -a own -b bcast -d 10us
+	"$MZ" "$iface" -q -c "$num_tx" -p "$len" -a own -b bcast -d 10us
 
-	after=$(ethtool --json -S $iface --groups rmon | \
+	after=$(ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][$bucket].val")
 
 	delta=$((after - before))
 
-	expected=$([ $set = rx ] && echo $num_rx || echo $num_tx)
+	expected=$([ "$set" = rx ] && echo "$num_rx" || echo "$num_tx")
 
 	# Allow some extra tolerance for other packets sent by the stack
-	[ $delta -ge $expected ] && [ $delta -le $((expected + 100)) ]
+	[ "$delta" -ge "$expected" ] && [ "$delta" -le $((expected + 100)) ]
 }
 
 rmon_histogram()
@@ -78,23 +81,23 @@ rmon_histogram()
 	while read -r -a bucket; do
 		step="$set-pkts${bucket[0]}to${bucket[1]} on $iface"
 
-		for if in $iface $neigh; do
-			if ! ensure_mtu $if ${bucket[0]}; then
+		for if in "$iface" "$neigh"; do
+			if ! ensure_mtu "$if" "${bucket[0]}"; then
 				log_test_xfail "$if does not support the required MTU for $step"
 				return
 			fi
 		done
 
-		if ! bucket_test $iface $neigh $set $nbuckets ${bucket[0]}; then
+		if ! bucket_test "$iface" "$neigh" "$set" "$nbuckets" "${bucket[0]}"; then
 			check_err 1 "$step failed"
 			return 1
 		fi
 		log_test "$step"
 		nbuckets=$((nbuckets + 1))
-	done < <(ethtool --json -S $iface --groups rmon | \
+	done < <(ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][]|[.low, .high]|@tsv" 2>/dev/null)
 
-	if [ $nbuckets -eq 0 ]; then
+	if [ "$nbuckets" -eq 0 ]; then
 		log_test_xfail "$iface does not support $set histogram counters"
 		return
 	fi
@@ -102,14 +105,14 @@ rmon_histogram()
 
 rmon_rx_histogram()
 {
-	rmon_histogram $h1 $h2 rx
-	rmon_histogram $h2 $h1 rx
+	rmon_histogram "$h1" "$h2" rx
+	rmon_histogram "$h2" "$h1" rx
 }
 
 rmon_tx_histogram()
 {
-	rmon_histogram $h1 $h2 tx
-	rmon_histogram $h2 $h1 tx
+	rmon_histogram "$h1" "$h2" tx
+	rmon_histogram "$h2" "$h1" tx
 }
 
 setup_prepare()
@@ -117,9 +120,9 @@ setup_prepare()
 	h1=${NETIFS[p1]}
 	h2=${NETIFS[p2]}
 
-	for iface in $h1 $h2; do
-		netif_mtu[$iface]=$(ip -j link show dev $iface | jq -r '.[0].mtu')
-		ip link set dev $iface up
+	for iface in "$h1" "$h2"; do
+		netif_mtu["$iface"]=$(ip -j link show dev "$iface" | jq -r '.[0].mtu')
+		ip link set dev "$iface" up
 	done
 }
 
@@ -127,9 +130,9 @@ cleanup()
 {
 	pre_cleanup
 
-	for iface in $h2 $h1; do
-		ip link set dev $iface \
-			mtu ${netif_mtu[$iface]} \
+	for iface in "$h2" "$h1"; do
+		ip link set dev "$iface" \
+			mtu "${netif_mtu[$iface]}" \
 			down
 	done
 }
@@ -142,4 +145,4 @@ setup_wait
 
 tests_run
 
-exit $EXIT_STATUS
+exit "$EXIT_STATUS"
-- 
2.25.1


