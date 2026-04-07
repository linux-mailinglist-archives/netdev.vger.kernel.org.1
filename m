Return-Path: <netdev+bounces-275934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBANIMHb1GlxyAcAu9opvQ
	(envelope-from <netdev+bounces-275934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 12:26:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2951E3ACCD3
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 12:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4900630036E2
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 10:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B16C3A7F5F;
	Tue,  7 Apr 2026 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eaqJh+w5"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013006.outbound.protection.outlook.com [40.107.159.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A163A6B90;
	Tue,  7 Apr 2026 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557270; cv=fail; b=alZTFuZjkGXnuWFf2flJSYkg2vXhHQACWBteP9QYjYx2lv/1dnxFN6ryfRkEQYUuWrZ6OMNDI0ByFKb3vhOdHr26tOJTzItbEwnyo+PWS7gSjZyGdWKHrFFA5+zY8s4dMSaskJ/qzP0DTFcF4XxX3sqOjnaR7K/dbXET4UIMSBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557270; c=relaxed/simple;
	bh=WJFb4R/s8OMWYkwXn83pgAuVtlleJDNa/q8X6MJIWJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TSkmLZoi/67YSxyeLB6gMru5TQIu1Urh6pVxoJ0KcCchovcZWLfcCiXHniHFVuOquCkQOwYahXP8FGzbC80zQ9kt2+vEofCfTbh1QsrxzhlKKkZmvY3+d9rnkyTWDjFTlqcl1ztnFL+2fkhW5lFtPzlWsmNdEcBYm9E2iAcfHso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eaqJh+w5; arc=fail smtp.client-ip=40.107.159.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BaG/e3IJGStb0yJTnhnutQY/IhC58CQuvKHPQeLk9BL9Br2CfAE5aApRngInMr9PkrK+yEv60c1hTHMQ7oN02ger4neZm38gaoEHV0rvHfGfOCLON/GAdXaBQRUMmYj2SvEH/FQIB2LB3TtJnskNBdVk0wuAq7C+L0DtANKjBF/kWGhHYP2Sb3kNEoYUNR4OabZId82FlbXwcRn0MLot8WayKo8qjyWLZy/lbALq70TmDoWht77nEiQRgjFc7ohhZ6OS+NY/ubcEYj3nnNg18hww8EK/Fq4wHOxIqenjkHXyuTkVxTfHZtusoSJYGdYVsCKIfFTS6fRvvAhGv8VuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWflR5l7MirVWb+Hgemc8DnBA6ZsQNpf/B1eNiTNdVQ=;
 b=wl/D4kKNQ7BuSefXvQtiW8TwNd2jboWSaRxzHjn7FIkOqNQThm8B7eSZlJ0MxAbYjTRcE7DyUPcHmGOweUH3blw0oHYkSPukotF9mze4DjUtV0mzZyTyrcuxAbaEzTo5EUrx1APrHmqbEcB4IOIMg8aid1ICSuQx6GSNOIiBtcJAUHmGWPybidAVGzYVo+jzwfQr8gtiJ2VZYfgNh74d7hBCDsXvfIPp9wV60GWQmv7TP9e3Pehisp0dWI2K8XDV1EDchZz8zw7rD55W5aYyB8VPVb838RL641KGm/FcMyN5aA1mpKLGGXnS92HNnwV2pInBEKhdzM2448ha7Ug/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWflR5l7MirVWb+Hgemc8DnBA6ZsQNpf/B1eNiTNdVQ=;
 b=eaqJh+w5J5v2luXt9SHGnE6M7vFW8dde/B0efhiNpjA7fr7mpyoAdjIPv0PQ6gtROYah5wDMsj+byAKG2VGvPrgcKJgXZhDwoH+lxxBNr58gRqCEEtOkzq5dXrgW+toWge2TY33ZKajPQXo/1cWYkmDH8Vxgx/HGhRvFbe7Ox/VVZiLc25c89V95P055KP0AW4RvHA+3AjKLeWHwWty9/pW7Z+9QgguRhRHG9RA12lO6qoIM/QmdjSvmJseD/ljldW/8ChXn6puXnV72SsKCSL0QFRq6iifkZ0hpLA0p06GYwxom15+8Z2PCXXYLRwpCynDf0vhjW4DcRdJkrzKwFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by PAWPR04MB9741.eurprd04.prod.outlook.com
 (2603:10a6:102:37e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 10:21:04 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 10:21:04 +0000
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
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next v2] selftests: forwarding: lib: rewrite processing of command line arguments
Date: Tue,  7 Apr 2026 13:20:58 +0300
Message-Id: <20260407102058.867279-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::17) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|PAWPR04MB9741:EE_
X-MS-Office365-Filtering-Correlation-Id: 946f89cf-143c-4f66-6bde-08de948f5ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8EIBO8k6A2BevPNLm58UHiXc3brN8eORg9/oULJ27Dk9gXZwIjygMmQmaqqxH7teo1qn51rUEDMSFGfrt3U0+spAzPVw+M6loD9hxua3tzGyvZjkBSBdjtHs+W2kc20HQWaqygh0PgNtV4GwMbyofutp8X0+pay/Vou8pCkiXOafPXUygrovpXCEViAIxSgZ7zft49S/NNc82+mt4Opu2FxKK8F5lLmExcEjXU0GasCmwuWWPWQZkARkYXopT0Lut+0AyJbjoVqMRQSR9qsTBSgKWvveg/DvzDMvuJrD/fNvs7ZSFoXPknrd+sDzDpgbcbNCt8nt9q+1aDH773seU8B/MeP6ny/U23IiPktTwMj+U7gcA+E49C+xO7xs2yX+WphuevGVSVcjxcf7tcAJrx527A6f8m6l6G12CzhMZlIfjl5FKoVdryJaTBZo/ej93SCvj/ixZrv4ZbcAOOKO/kOTC92+mUFwj/HDaoJ5dVxJf7DmrBeq7lFFf9p76VLfHa+aD2k/uY1CWf2/o6bOJ3+RPSFB1WfNGO6i5/+/P1mGjg8ct4vdmTDRIXLSqFc7MvZ8mj+fZNLwHQ/wiPeMYTIBfY8i6YKlHDwIyqGgTOFM9sPbwqbFcb480Abf9REJcXWQOXJKbsShqf75VYd5VjxKOyGvhQEfmsqUVASyzo3cES4cSXhf+38L47vqf23Hk0IDijiSo3Gvtq2OLy5zrJEIp5NT5gziVqR7lS9dBok=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZT4lqonh1hvluLjuG1NkJqboPmYZwYNImOyVVgrFxOEwK8bU4ei2C3DG2V87?=
 =?us-ascii?Q?s8uiKJ2aT+Pmp4tIWNwS2pSL4+uE2PgxQ6uxzHgybODbNlG6A3aEuSiiMYT+?=
 =?us-ascii?Q?LryCxJveN8WqQsSeO78QG1pWJWUYnePOT9pP+cbeNRXdNJfhP5H3+d48//Oh?=
 =?us-ascii?Q?l4PjHq41g84PD6xHzNouuRfODpL18ViLjrZEgZjuptQ9mscrASoEVdk32S+t?=
 =?us-ascii?Q?tFrt9p37eO4ZkaE7LcZsDITIokIsI4d5lkAarX2ofYlYDI8toqucWeu1SkjP?=
 =?us-ascii?Q?XKMQEcbQkFQ2+O+/z4WpFuyT/dpUImkN4npkiGdm5aoGXCGwS59BiyZ+KO2/?=
 =?us-ascii?Q?8rU+kjkd4dXFvgxLSEbAD+r96Jsc8NBk5hIEM4WfPz3fZktwrkzHvLns7f7s?=
 =?us-ascii?Q?Hl+VGzlFL4CUQlPljF/3iTbzp28HrzqaLXXQWoYpMZbbhBUD0EW4uu2hfkgN?=
 =?us-ascii?Q?z0QA9soEHRDGSUqrN6zUX0nVZrzU7zgipwTseAgAqkCrGoAok6+RtxczzVtm?=
 =?us-ascii?Q?DwpcnUC7ioxv1LGIEr/mmgOc945i2O83PDp+Kx1PcYDrMp+vLlksT8+NZkmq?=
 =?us-ascii?Q?zQVHyZFfPET3M8SLBnurQHigSj55dpOUaBC7PYSZ00P0BaIyTd8TMYzRxTD9?=
 =?us-ascii?Q?pyAVsg6vH2qDvxUpqvvIi9kX8LXiy1gik/3LKBFmK6anNQK6kF2/Nd5fnvwS?=
 =?us-ascii?Q?Z7K/GbVTl6KD3zvUdJagXz2QLHKyLNcw6rcIOif2xGNtbKNNXHcc1Ou3K1z7?=
 =?us-ascii?Q?pbkBcVhtdpbjxmcQUBXuPZBv6ZJo/wE0jDNhS4hsoXNUGCVbruOgd1lP4Ax0?=
 =?us-ascii?Q?+Y6bUOVEaEgEA+2CI/06Ox9HAjCNC8P7B+QIy3SU+I0jBGYHeB7iMAyUWVn7?=
 =?us-ascii?Q?hh9/aEvSJ5g0oi8sMCeop4fdZxhNi5TqBCegBoITgwfMh3fdor8pT3iZdBNF?=
 =?us-ascii?Q?jsjCxKRUH+gICzb98IRh2Shh8uGyC8yXlOvAPO1u2oiHlVmv66mjFZlNEXfU?=
 =?us-ascii?Q?yXHH8mvUpdSncGT/Cj/vrAU+GZ0/d2V1XhQs5bO6a1gQXrI522t+/OGKZn4f?=
 =?us-ascii?Q?pkabc4JyC3Bntl41ViTLls34luWMA2qIYTw8I2DeBjkuaQTkO/d3LvnxaIDq?=
 =?us-ascii?Q?huIVVgzrbLVrr+bJ3lcZcNNh8ig9wprSVQOzNlokHgobWgANqmCxcuTo4ZcY?=
 =?us-ascii?Q?M0dfpx4ihVqqAgMS3iYUo4uDmHFUHRmJZF1s20oDoy53cBdsPd6np3XG4HGq?=
 =?us-ascii?Q?iC2BaD7z8Ci3Yu1drEOzzC1P6LTBI+Xu1r8cjHDp1+3CJXPsYGqI62wQaM8M?=
 =?us-ascii?Q?yUbhpt/EgpIiSWKNc0HNWJ6XC+6yz05+WiDmaruen6Ukd8k6PtrZXirgzDZ+?=
 =?us-ascii?Q?PZA/O5dakx+TkWFnB4vrVTz4jjIgDwrc0vADqeNxeM03ak1rPYrki39joEwS?=
 =?us-ascii?Q?GX5Gop6j9Zx0et2Ib9VCbqUZOFLVZ2q1LBFEjfzvR3Opu0Qh7NXEZaxbiPMw?=
 =?us-ascii?Q?6MLDjfZBGsF+8krL+BSEsYeYHt0Sf2fCt9tzGFCBO3giAOtnvND1i0IevmDM?=
 =?us-ascii?Q?FsBM64usOy5d+Q8TQhrYRm1PigIRDTr8tDLiZ4ROapPC30rs50dLXav/KSoa?=
 =?us-ascii?Q?Ia+s+8LRm2ONikCxLGgN1Oaytd9iwzoJIvYfGG14AhOn5NKnPIVf3kFbCIiJ?=
 =?us-ascii?Q?F6zdp1LeXJFvii66x5s9ZKEbf1Annj1twDjOYhOSm0oigupN1FZJmFuHVTAq?=
 =?us-ascii?Q?xBlWoHzoKg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946f89cf-143c-4f66-6bde-08de948f5ff8
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:21:04.6753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOjqezki4nl1OAwDLVqfE8O5VrcylHlsBZ8lBKvv0wjOaTcvJKz0K9iUKvIWGw5hjrDFUpJGChosQ11ihRUU9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9741
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,nvidia.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275934-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2951E3ACCD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The piece of code which processes the command line arguments and
populates NETIFS based on them is really unobvious. Rewrite it so that
the intention is clear and the code is easy to follow.

Suggested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- added back 'count=0'

 tools/testing/selftests/net/forwarding/lib.sh | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index d8cc4c64148d..d2bdbff68075 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -467,17 +467,18 @@ if [ "${DRIVER_TEST_CONFORMANT}" = "yes" ]; then
 	TARGETS[$remote_netif]="$REMOTE_TYPE:$REMOTE_ARGS"
 else
 	count=0
+	# Prime NETIFS from the command line, but retain if none given.
+	if [[ $# -gt 0 ]]; then
+		unset NETIFS
+		declare -A NETIFS
 
-	while [[ $# -gt 0 ]]; do
-		if [[ "$count" -eq "0" ]]; then
-			unset NETIFS
-			declare -A NETIFS
-		fi
-		count=$((count + 1))
-		NETIFS[p$count]="$1"
-		TARGETS[$1]="local:"
-		shift
-	done
+		while [[ $# -gt 0 ]]; do
+			count=$((count + 1))
+			NETIFS[p$count]="$1"
+			TARGETS[$1]="local:"
+			shift
+		done
+	fi
 fi
 
 ##############################################################################
-- 
2.25.1


