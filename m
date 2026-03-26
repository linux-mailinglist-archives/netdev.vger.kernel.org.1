Return-Path: <netdev+bounces-272069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDY6Bfk4xWn/8AQAu9opvQ
	(envelope-from <netdev+bounces-272069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:47:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CB13363A4
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44D7E3150A35
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D298372B2C;
	Thu, 26 Mar 2026 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WkC9z6OZ"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD95332616;
	Thu, 26 Mar 2026 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531748; cv=fail; b=W0qtqh4aqOE0oae0O6mwIXt1uTZMspuUuCFYaGfKANhNavWhnZiRsCzel1q/rAEAN6dwv/ChUF+Qppt0BnOZd8F/C/PcV+TORXmjYXIJOsrdygwks1NMpBiYRuDnHeQ1cO93TCdkaDoc5iISZeDPoo/0FN/aAx1NwGtaZ+VeZEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531748; c=relaxed/simple;
	bh=OugFYMz4ui3xVZ/ssDJR+343REq4vZonhOEZVuTJvAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uy52wyrhj3ssP3r8s/8XKk/hIq6OagLVfHhlGpXVg7ztMey72AYbiZvg4wfUxC/2jUQIescNPFdct32ACT/3UohxFhjZ6HQddixrfrW1uB+Aw3cU0euauTnB0pQj6WI5XMZc/L49VaKz87Jc5R7tTl6z8iSpKN8QM02OXbdXioI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WkC9z6OZ; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgk3tlLcN0H/8JfJHS3rKUoTuIXx5L9fa0IpzGEMVH3chgy24twc9v1LAdN+yYaHjzfTfeV5AsXz8fb08aaD0oImYufz9SrpAkQTPLYpCdpaFk9B2Tn2Pda7BzYR7mK5Diy5Ex5dA1FbWmSTrt+9RMmWhXK7oBbzdehIbgppmNyTIjGa2bLYOeFffNov2XnxAs1wEbB2DbE3X1IdXM4FQS/w5Ra4CFbJL7nyugIbIt+sac47mekSdjBH6QYRHlw9qolRDO8EQErhwjH7F1kahjeifYAJc/rjGfLGbPa6NrQP4ljYLfE4vOyhvWbnBLDiP4Yhpf3g5xOoSg0G3QK9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPVo5Vg65GBJCoTTaYLYXcQDaCnV49AXiFe+cb1Cw90=;
 b=Xi7WvYsiaAv4tSQQIeZF4kD4HrUrfjg3hb8auxtSxIP5eMuImKF8Go6KRTcmbJGWFoFfxZZriHPRgpvku1AnBrO4wVsu3aESYdZ/q+2fPHvPkFOwDq+sXQyffzExhdIKkIxImK3qmqtYpiWt7SWQRU4ZxKFvVoPmdt37jZzLxZCqnHOvYwAWsbRvw0QB1u++RPenTILQtbjmK4y98NcgVWa0m06WuXek9H1sIE9kQghRZKmquubn1diwIXg8oYrKLvAxEByYnvETX+ao6fu+/SylJOKZ0wJpztUWb1ERz9bF9zP+q3gtu3JV7q4XoBp2U/jyRpb9HGP0gdJ6WU8abQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPVo5Vg65GBJCoTTaYLYXcQDaCnV49AXiFe+cb1Cw90=;
 b=WkC9z6OZAkEjxwaFtPr1JsLHdpKRN3Cf1rmRtnxLofNf7lC41AQYHUE2YHPH4bkd4aCm7DZF7HN2rJNVxo6GufwNe3fXssNFT6Oyr8WL3q2CaQj6lbCUQH62y91FC6UbVtOpiMwvklAvlm9oQSvozIKJXwe6g6D43UFU/vmZNhSIG1+M45PWYyGi2xejb9A5C31OJDDx0RNrJZC9aszpBK0Y2jM6u9p8ZtBpbmBadJ+RKRMVBwaC6Cjs+vBj2r0PY7BCuoBQY7NegGztQ1CVJ1Ish84aCakGBpk8YubCgkp+Pg2iErDuBtwmb8m01SvT8uIn+AONMNWJpitPJHEeuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AS5PR04MB11324.eurprd04.prod.outlook.com (2603:10a6:20b:6c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 13:28:54 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 13:28:54 +0000
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
Subject: [PATCH net-next v4 05/10] selftests: drivers: hw: cleanup shellcheck warnings in the rmon test
Date: Thu, 26 Mar 2026 15:28:23 +0200
Message-Id: <20260326132828.805703-6-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326132828.805703-1-ioana.ciornei@nxp.com>
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0371.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::7) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AS5PR04MB11324:EE_
X-MS-Office365-Filtering-Correlation-Id: 474441a4-a5d4-4bf9-b187-08de8b3ba021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	TPN4NEsLnq5TySXknFSUpeaSv+KGb8LFizI8opMrDN28pxmoW6M1IQvF4IuEzPOfzP+09CKRb4dW6kGBrKFUtSCIbXruEZXLwh6n2E83+V34Jh2Feo3hcHR/6OyIi984a8z8lY0KWtzEYQwWsI/ElFsRCDnCvp4PyKlLFlvG0DkVDOKpX/re2oTZnBl4v4ITbLtoJLZf6lRc1em0rdLkw9cE/hisQkG2tng8+hIuAYdP0SO0b4SH6cC0GIR+1/zhSItiXUGPsN+PDjyM8DIUGroIJDcUVee4UdQyL3helHz6lFLAWky44mnF2T3LINSuDe8ESOmf+Fntr8rNRaWYNL2iHUj9zs71CEgMpT/aLM0t+LE2KY9TiHqOP9nyarTtjxT0HeOlq+tBCUKtCFZSkzgo7rjBSJo15kWno6UbKyK+dEZNyWl4ha/SrEkT9hZz25tdEkfu3tt7nkh2+nYGph8YQKb86FeJNylPty6WvXFOzW7zEoDrEJWAfjp3pylxZ3hKwOBZ0hR7onxje8AG9sn2lFSIxzrEnekV05HVyC7Gmh08ZyTwUF7nUEt1Tfbq1Becm4G8ZdjGk3gdpc7aPJlBYJ1kh111Ukbqme3tEGT5fMFRStXHosF+bBvGbf/Yzo5Y1uYydkGx3sOeVWS+N9aE/3EIRMMCGBX5BgYm7yVyqt3LMDYO9/pbgw+je++7shfDEDK1ehh4Kh8ibOoPf54Y95f+IGRoCpjCfda5Fqw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gXZAvEssjiRn2ABSfFyEh+GLcC8XtO/EU6y7wmfiY5RHhKP0tsrG43j/u+Ie?=
 =?us-ascii?Q?SqNd2AZA3XUgwQNYuTDlMz6j6XkhN4WvpZ2NvKiR5yyMKmVasAVJa2YxwHur?=
 =?us-ascii?Q?kmgBypf+YwYlU1vWyGoMt7YWhdGdpiSLszAogrMGG/Cij0+oaIafW8HmwNiQ?=
 =?us-ascii?Q?4WC47lzwgX3McyP03ZLGM+h7Hd70Xtsjdw4TVFh4/WcCu3hbAKMnVmGAds5V?=
 =?us-ascii?Q?kN9FepYGfddBmIVnTq4SkAKXDE8qMwyleFcY8Etja4y0XXf8UWRYkLMPF4RT?=
 =?us-ascii?Q?zXGQxVxoXKeCC71j5TqHlS+IZhVbKIJzWVbCODsbYjnchxXXvSQgx4ghT1wI?=
 =?us-ascii?Q?9lAIXxqrhpHrpta3by7Wgiu+pT6hG95Iy/f0YZ14XEgKwuLFL5uaPJ0FvyG+?=
 =?us-ascii?Q?/SdVEn8tnVPqcki3ohb/lfWJ4w6graUXMMW6s2Yegw8bZN5hAAOzOudDKOi7?=
 =?us-ascii?Q?350fbU9TOplvdDnz1jzshn8NyoI6AudBzdbKBlk6vUCXK4U1UgLpWHQ3tbNt?=
 =?us-ascii?Q?EDeQHJ0oZfZ/t64bfQ+xhmsG19An/7iE4frT7u6mraw083ZyjVxYbhAGIGlB?=
 =?us-ascii?Q?6AYNnpxxNinDsc1p+x36vb/eVxiyeysT826QIsxf/IJajgi+qffoO3pIulwW?=
 =?us-ascii?Q?x1fT33ZPQeSTgTUq/iVMfJrMCDs3hjjIbUTK1diUuD1+gqy/ZCac+g2k9F1i?=
 =?us-ascii?Q?AK+X7MLrEom6GjoqgbegDqYdFXd5NRBUpcpjd6AED3GDvnBtGJX5xtDX2xtu?=
 =?us-ascii?Q?/gpKZDVVHniiWljhMxYGK2g/flMeEG7YPzi40IuReCYl2gu5FunkMuLRmTTh?=
 =?us-ascii?Q?uJsrk2CG0L+yVJWYUlTtPCbIqCO88XPbM8cHBxjTrkTTtesHIULK4+GuvRJ1?=
 =?us-ascii?Q?K0E0iwgc3AQRBhZsmTYJmBNMVx+Rnr8D2IZqKgDVGfsChkHLo7dPePZmppAH?=
 =?us-ascii?Q?eQ2wCi0wrvUEfpWiYb0P+4fxXrHf6jHTbV7k3n1xlagy2Y6VJZGNvC8cd0IO?=
 =?us-ascii?Q?V6r2lYkpykEclvOJ1Wx561CtJ/Ny7+2kcUaGaobmr5yRkQLA+cBoeZdmfRGT?=
 =?us-ascii?Q?zsgQqK2ekRrl0EKqbdrdGATdD11Eh1A118R8qqk5M4M9S+Z52fWbovCsgIye?=
 =?us-ascii?Q?JsY9Yb0YBItD80YuVoch7jZdzVPXLkZpF+9y8aslqZa2SLCk4vIDC76TTayA?=
 =?us-ascii?Q?bgmczzbPb20fgadRMsf+CGdEUIC6RqYOn/ihGYfPLKjG35ByBiRW7yF54Loe?=
 =?us-ascii?Q?7Hl3fHEOD8cDTAuyj08tMBZwCtOpDVdMErt4oQK9FMH6yi5y7MnIJgGPdhB4?=
 =?us-ascii?Q?QYYHayIOpiB6GHLOe01TUhQtqTni8mLKvJ7KsrdfsXDMFYdEISfqufshZQ96?=
 =?us-ascii?Q?o9j6JDypZEtfhVjWnbE91DQ2YMVeqmFG0UM4qziYcckjOguwz/7GcPqoCLrd?=
 =?us-ascii?Q?HeU2Vb8mDnuA44KopVUYLKGlLwK2Oo3teiyW54oCrpjj20XE4sP4Y45zLTkF?=
 =?us-ascii?Q?oSAL6vdgDU3RxAQeYmKEDY/JoQksaqujVrOL+WqEbhMlOeVlONu5qObNYb+r?=
 =?us-ascii?Q?hRLAgj3nnet9D1vY9601lOX/rKRch3N+U9WaOnQS+ko6gQDE89TPnvfFXZjS?=
 =?us-ascii?Q?qV7mSZykhjFz7gcK/N+tmL3u2R/ulFRuTJpqf73kC5pe6OR9W3fZyQFV8AkP?=
 =?us-ascii?Q?3jCmnmCRtxY1lGpXs2rN4+JQdB5L4aad0fsc5X+BD+2Hgw8RZ9nVQ3/9cm9I?=
 =?us-ascii?Q?+HCqKL209g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474441a4-a5d4-4bf9-b187-08de8b3ba021
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:28:54.0711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvcTQca2NLvbA2jFalPHzpWjTJBpF72BtnIUvGCveWEb+90nN3twBGSliILVjP3jahB3Mu3sQAaIIzrsDBbDoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11324
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272069-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,ethtool_rmon.sh:url]
X-Rspamd-Queue-Id: C5CB13363A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If run on the ethtool_rmon.sh script, shellcheck generates a bunch of
false positive errors. Suppress those checks that generate them.

Also cleanup the remaining warnings by using double quoting around the
used variables.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
Changes in v4:
- split one line to 80 chars
Changes in v3:
- none
Changes in v2:
- patch is new

 .../selftests/drivers/net/hw/ethtool_rmon.sh  | 54 ++++++++++---------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index 8f60c1685ad4..13b3760e3a40 100755
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
@@ -117,9 +120,10 @@ setup_prepare()
 	h1=${NETIFS[p1]}
 	h2=${NETIFS[p2]}
 
-	for iface in $h1 $h2; do
-		netif_mtu[$iface]=$(ip -j link show dev $iface | jq -r '.[0].mtu')
-		ip link set dev $iface up
+	for iface in "$h1" "$h2"; do
+		netif_mtu["$iface"]=$(ip -j link show dev "$iface" | \
+			jq -r '.[0].mtu')
+		ip link set dev "$iface" up
 	done
 }
 
@@ -127,9 +131,9 @@ cleanup()
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
@@ -142,4 +146,4 @@ setup_wait
 
 tests_run
 
-exit $EXIT_STATUS
+exit "$EXIT_STATUS"
-- 
2.25.1


