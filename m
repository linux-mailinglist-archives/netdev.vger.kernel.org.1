Return-Path: <netdev+bounces-272067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LEIGNw1xWn/8AQAu9opvQ
	(envelope-from <netdev+bounces-272067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:34:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0446336082
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E8BF30B20AE
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4721C31714B;
	Thu, 26 Mar 2026 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QItkl+k1"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8B62D8379;
	Thu, 26 Mar 2026 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531738; cv=fail; b=DRfyOYa7RWtekS5wvD06hcOvmvNISae3+ydFXNYk+7VX6Ya1S6kRbCrcttycpVBEq1w/DS5c9xs9U07cv6K5Tqw8urs5hYoMlgEEtLQbTMWyiD7U0m3ZE2Pj2wVSR87xxEzx8e99DRB91uJb/5uD3vYNZDjkZWZ/lkmxoNyNZ84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531738; c=relaxed/simple;
	bh=IXINDd6fjpTrocx0lFdGRmT4dauv2tthBMDnOceT8os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JX2l5HTtdj0d6EeTw1U+pJFgU3UyX/7hY7SWMfFWB7bt28aeQvd8PSslT498mYwxFM2yNaLBLfY01AbqhMXtTdkv+uTje4tY/jcznTbbLhe1xppdDyMwMAKsPm7EbavNX32np8NNutz2EyAfg4j+wejnz7cjWvmHQW+SfXB33Bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QItkl+k1; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCTShFaWue5CO4kRIIBFyVuNpdRgPG49r3mgwZkFqzLTO78783LEJCK8190q01FlWolFzUWoYvQy0FjQNs+gojP2Mr6uSUXXbZMquc2Dj0nWI+q49Brxne18SdNzDL5wcw68gogvy4NNg2CvlbisxYMuVCxU9Lw3mgqpk/KD/uVLbSQMs6s0FJLm+GcJEQBE5vK6HkrXXLvkAY3NYS2CxcLI6/90yuCsVll5w7ZgJqYjP/3kfJJNz022bPejkiplFeuTTce8CL+bhxL0ZSywolzKJPWi+Bt+XQ6ke7L9G9T72Ls9xP2Sb8RslYHLWk7mpUS56Rddwm+ku7AQ/pUpdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHkc70sgKT6fFqi9rEnCd4fH4opyMK+6aUKpwt2EevQ=;
 b=iYWrq2bKYGkRyHXo4YQJQap+MqsQ9nlQ6lMoli265nk3UlqkawtGDYiEuvB7hKf2K+RGth6YNdeHAjz9RaOaR1d/t6xoshy3+u0XSV40XHUcmD+3mg9IKinZgYiUc1Ff6umRTcD+ZgjeOM5UtVMnE7v6pnMEDlMFwMajNJxMeCyvrQoBA4+KrBms9Rq1HF/hPDD/XWMQkmRvioUSEbT9kUdlABl+clgdhHV9vHUzPsHqsdElmYZDxGVdggx3nCVe3kLS9l2UIogRuoFyQY/0MQNh9UWxp9gANZNhW3sMZZgcfuZCJosI73RIiU5tUj++zHBsl1N1gSv6TRONjamBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHkc70sgKT6fFqi9rEnCd4fH4opyMK+6aUKpwt2EevQ=;
 b=QItkl+k1wAtfmGCULwnbpvhCHtUhn1rKrOCWBG57q2x3sIxHqdAtr++NvhLciB8NdQHGunF+UwFjrO/Qe4MfwFYIfWNx1mVWnH2VRLLnSRxlJtjw/9m4j94DeE/5l0/jZSsLqCnU9kOZOEgRc6cr7QYU8uduHWWgtRZwVqfs/CiCt0RsTo18OIadAW9fq2gJnknIRcQM7e2kzzncRY9J+bag/iiBag4KVKcCfLStrDwTz96XbAxYmsRat4WrJ7Sf3kaySMQHj2wfUS4EZnz+hdxHAQqn2qwKa32jXHHNahdwkKMjZVTL408UanQGtfb7NkKhIfvmpwTtjtp5kIi8EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AS5PR04MB11324.eurprd04.prod.outlook.com (2603:10a6:20b:6c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 13:28:51 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 13:28:51 +0000
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
	willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v4 04/10] selftests: net: update some helpers to use run_on
Date: Thu, 26 Mar 2026 15:28:22 +0200
Message-Id: <20260326132828.805703-5-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326132828.805703-1-ioana.ciornei@nxp.com>
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0363.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::19) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AS5PR04MB11324:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ebd0cf-a965-4fca-2157-08de8b3b9ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GSrRzVQp1GI/Wb8UvcuC3N8M7dzU+vFnqQmp8zCgZhJuSn8flDiUjqrep5V1bJn8O3DZCTYC+yq8iF2WKmUIzjs8Ix834oMsv2uhmzbp/W9bzLMTb3+QvmhwwXchz3J7ipy8yS2wcca6FYKz0RoByZuYPxXb3kEgh067PdF/emBjKgtJTDQicQVk4BFjY5TtiArjpJIEY3On7ZV5+oq9W5/PYUpoXwi2k/a0TLGpm2mlM87rhUQEEYW2CBeb6VtQQVLzP736HvZr8CezSzSm6H1FDRJeVkjuQw8D4ez7TN2vsUmNDJcJMeO6CYuiwfeoIXf/DyaJakabuq5RAR8L7HMxIKK2R/dM43GmscPpu6W7ZIYcG1HkbgH7uFQJdXICuui2pEzWlONQSDaqDEv3P2nHkRLrLAm/CX8jVgWg7/gvyXYtEGMS13P0FckpjGc5yv2tZguMwBTlxnwOZZxkK8mxqjLWUoM0zUxPiCXTuD07rZuO9f2tu7RQ7KKiaGjhmXTX2XE50v88PNLPO/rZB+OQl7gRSHn0IEIH2oCu8v1Vrv6HwnqZtwMdmcjsastGNfrfJ1vgjtWw2RbLFw/HpWNYAB64ecR5eyLCDSKqVegJcsjDX8pM4xln6awcs9iJFwQeC20SzcNkaIInm4IwZPYt+73z97UjYBS3cWYLXHeQSui4XnY1Pe9Tx5KTlkVpNhRcegaSnpKWBAnSeKXvW6FeCL1ey2JVHmkFvjVCBHE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dhx5hfIaX8NNA9jkYnvXMxBPPuc8uPUMh0OO7G3Z+b7p7oMrAdlMfT3a50SX?=
 =?us-ascii?Q?ft7I3mz0IxoqIQHv4MDgUm4AVPyCXHyrw9gy4KfMeQl0EfHhaWTJ+XoPg4B9?=
 =?us-ascii?Q?EA0Z4BQwqtZECZzamEQ1LH+q/aPhyYp0oCAB/nBGMb3MAiE3zr4xdykOnCR7?=
 =?us-ascii?Q?k1Rt7D86KpQGO6cXJfb0OFLWtDM/1kMcWlApw0XSxmyKjusQt9nYWhHK4V6q?=
 =?us-ascii?Q?D9hAoh4WNeYF67gs3c9BAFGRxP0y/ChR6wUsw0R4/HPNp2JWFUAAu0+FgWTV?=
 =?us-ascii?Q?4/nrCky0Qygjn+zRF0DObEJD4jSW5GahjNYl8EbwVFBwAIu3axqp0lCmF18R?=
 =?us-ascii?Q?NkP/Xo8wrh4ewPLpyDi2xdyBElRWubaNuG8LRdleGi3RunjbL+pJn/8rIMeQ?=
 =?us-ascii?Q?S8ymg+SWrzOUGzrB11wxWuYmQZTLpH35/m/o9DZ0z91/ddFmbX8uBCjEW3Vn?=
 =?us-ascii?Q?67FKnM6G6gcXkx5SxeJlXiAinJKWJcL9fdtxTJzG3ZD79X7NU5QW9/WcORd0?=
 =?us-ascii?Q?LEcwb49WEvjncP6XPZ+r+2Lygyi/cwIAe9dBv24q+eJO3CXrg8nD3++Cnz00?=
 =?us-ascii?Q?hloo31BjhTVD1RLTQt3C2RUp7tzHBzgzjgSpFJcI3deQ4Y6Rt1gZIyFxk/N9?=
 =?us-ascii?Q?YjDdski5gLv6hTdFZtP6m/8BVJ8cqoT3mwXoo+oZLCMaWAJyAArjXS9UKMph?=
 =?us-ascii?Q?YsBazP4lM3TD1uQu+0rg4isvza/9VPPmwgMgceYm/9nrw3zjBqy8q+N5xyQW?=
 =?us-ascii?Q?/sgcOnNmAyr/E6ZYWTI4QivlOi0WtzDnRqd94bQnPu4wYPgAklpi/zj/qnlH?=
 =?us-ascii?Q?LllmRGDLbmQMwPmfoVO5Be3/6DO8Emt4NsQ/6QaMJXkEIzXkcdG1W0zkyQi8?=
 =?us-ascii?Q?mf29Mfwb34BPPUmk1S8Tiz3MaODT9WNKeaty0H++k97bDaWY832OC7zSvavr?=
 =?us-ascii?Q?/AjbX4FRK2MVCdqbVQs8u11+TxJHp19uuj81AO9C/K4caii+1ZrO7JPODYSe?=
 =?us-ascii?Q?/IGXTfBYiO+06MhUYh3Qp8OglIFxMEIih8w/m64zQ3jc+zh8dZEl/1P4Ozid?=
 =?us-ascii?Q?XTHdEQUw+n3BOWMJ0p3QqoszKAJpBzy/37b7IxNDqhecs/IACcDFhWZRlptA?=
 =?us-ascii?Q?/8/wDuoyVVRlleK4bFHyQ3eooVfKegjBmXJiK8zXbj9DSSzv7FYsrIOYy76U?=
 =?us-ascii?Q?Na2gywU6C+JsTpQ67N41A3vxPjSqVkMz0/R1Cnpgyr2vcYH02+bm+q1QhSt5?=
 =?us-ascii?Q?cyeORjU7PKt1kxEb7LyvuBQqBUpCFsI8B77GLWm3IiKn9uJCvp8kKkFOSvwn?=
 =?us-ascii?Q?qMwotegT9o+ABOfvXeFNPkWEnVV7SsC/zJ6wih22X3xxFLwNN8U+Zwuvgbta?=
 =?us-ascii?Q?Li5EkxIfVD2prJb3LQLpH6qgprx/mrSHHomruE8a8nQ7Ya3ttyJ+TVj5mTHB?=
 =?us-ascii?Q?DKppgdDqjRR4zl5twq8cYj+bETduBZWY2hp9n6mLbORIunT+MQk1greIjmQi?=
 =?us-ascii?Q?UBywSXB4pvEAkRnj8mZ0DRtFaPnnTcPrCstQO0nKLC+bqYoCO5qNT/zFXkut?=
 =?us-ascii?Q?65R6SkUS4GUs4K8YtbFJPYpjH5uR9GJoYPV6O1admDSTIbAXId6kCdBEiVO1?=
 =?us-ascii?Q?2neZk2R4ixhCi8m+ZUlwy+bDN3y7rBnpMjFENEyV7W64nOm6yB/wb6+V3/kE?=
 =?us-ascii?Q?SgclUVdz/LvSJUh+lleKVuRVtVZuZFuSe6JFYf8xw1hI88EhsZKwPCDSPj/n?=
 =?us-ascii?Q?3WzK/ShPUQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ebd0cf-a965-4fca-2157-08de8b3b9ea6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:28:51.5070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AKZ7OyhtDHl+ZiuaJX8+jjPo1P/OgFqHObOMgbHdYiUZjosVt8z+eTiuTGhAZL3Ukq0Mo2dzluCzZAwcbWXRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11324
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
	TAGGED_FROM(0.00)[bounces-272067-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0446336082
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update some helpers so that they are capable to run commands on
different targets than the local one. This patch makes the necesasy
modification for those helpers / sections of code which are needed for
the ethtool_rmon.sh test that will be converted in the next patches.

For example, mac_addr_prepare() and mac_addr_restore() used when
STABLE_MAC_ADDRS=yes need to ensure stable MAC addresses on interfaces
located even in other namespaces. In order to do that, append the 'ip
link' commands with a 'run_on $dev' tag.

The same run_on is necessary also when verifying if all the interfaces
listed in NETIFS are indeed available.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v4:
- split some lines to 80 chars
Changes in v3:
- added some more double quotes
Changes in v2:
- patch is new

 tools/testing/selftests/net/forwarding/lib.sh | 19 ++++++++++++-------
 tools/testing/selftests/net/lib.sh            |  3 ++-
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 93b865681840..98434da6e36b 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -506,10 +506,11 @@ mac_addr_prepare()
 		dev=${NETIFS[p$i]}
 		new_addr=$(printf "00:01:02:03:04:%02x" $i)
 
-		MAC_ADDR_ORIG["$dev"]=$(ip -j link show dev $dev | jq -e '.[].address')
+		MAC_ADDR_ORIG["$dev"]=$(run_on "$dev" \
+			ip -j link show dev "$dev" | jq -e '.[].address')
 		# Strip quotes
 		MAC_ADDR_ORIG["$dev"]=${MAC_ADDR_ORIG["$dev"]//\"/}
-		ip link set dev $dev address $new_addr
+		run_on "$dev" ip link set dev "$dev" address $new_addr
 	done
 }
 
@@ -519,7 +520,8 @@ mac_addr_restore()
 
 	for ((i = 1; i <= NUM_NETIFS; ++i)); do
 		dev=${NETIFS[p$i]}
-		ip link set dev $dev address ${MAC_ADDR_ORIG["$dev"]}
+		run_on "$dev" \
+			ip link set dev "$dev" address ${MAC_ADDR_ORIG["$dev"]}
 	done
 }
 
@@ -532,7 +534,9 @@ if [[ "$STABLE_MAC_ADDRS" = "yes" ]]; then
 fi
 
 for ((i = 1; i <= NUM_NETIFS; ++i)); do
-	ip link show dev ${NETIFS[p$i]} &> /dev/null
+	int="${NETIFS[p$i]}"
+
+	run_on "$int" ip link show dev "$int" &> /dev/null
 	if [[ $? -ne 0 ]]; then
 		echo "SKIP: could not find all required interfaces"
 		exit $ksft_skip
@@ -615,7 +619,7 @@ setup_wait_dev_with_timeout()
 	local i
 
 	for ((i = 1; i <= $max_iterations; ++i)); do
-		ip link show dev $dev up \
+		run_on "$dev" ip link show dev "$dev" up \
 			| grep 'state UP' &> /dev/null
 		if [[ $? -ne 0 ]]; then
 			sleep 1
@@ -920,12 +924,13 @@ ethtool_std_stats_get()
 	local src=$1; shift
 
 	if [[ "$grp" == "pause" ]]; then
-		ethtool -I --json -a "$dev" --src "$src" | \
+		run_on "$dev" ethtool -I --json -a "$dev" --src "$src" | \
 			jq --arg name "$name" '.[].statistics[$name]'
 		return
 	fi
 
-	ethtool --json -S "$dev" --groups "$grp" -- --src "$src" | \
+	run_on "$dev" \
+		ethtool --json -S "$dev" --groups "$grp" -- --src "$src" | \
 		jq --arg grp "$grp" --arg name "$name" '.[][$grp][$name]'
 }
 
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 6c0d613a4de5..ed2291588a67 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -514,7 +514,8 @@ mac_get()
 {
 	local if_name=$1
 
-	ip -j link show dev $if_name | jq -r '.[]["address"]'
+	run_on "$if_name" \
+		ip -j link show dev "$if_name" | jq -r '.[]["address"]'
 }
 
 kill_process()
-- 
2.25.1


