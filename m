Return-Path: <netdev+bounces-267084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBSSHqbLsmlTPwAAu9opvQ
	(envelope-from <netdev+bounces-267084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:20:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FF627334A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C89D315AD85
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD1236403D;
	Thu, 12 Mar 2026 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JvCKyytR"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E48366068;
	Thu, 12 Mar 2026 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325118; cv=fail; b=qRSGNw5ELQiwBBkMv+OgsEeeGpgqgy9IHDwndRmZeitgpsqjUycpcb7GPyMutXviXP1rg6cvq91Ze3ulJtbe17Z7ep+ctPOCFbn/FFGSEflQstMSmeS16WfVaSib+6vNlkQMS3ISnm2RtFF/fkestymvRITMnJpv8gV3PFdNwqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325118; c=relaxed/simple;
	bh=5eAauudLDjezRTichWKKcc5drau1Nyrmr4B1wADlVx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OurD0rT4eCHU2t8QmMHUysu+gbF64OIsflpDFZoTr4Qk+qgEZxqjaxgmFkIPllHgYn8/qpLhu4bMoUrVpL3hsidzyIjgEiHUrAI57Oa6oZ3hoOIvIVcLaHvIqRaa2EBAmGllFNbmudzLcgU1bpCK+cl3/L9bJQzxl1VZfC7D/ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JvCKyytR; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+AA1weqiOgLL/jEIxvgTIaPr4ARrsVb4v8nx5uWJXxLRt75yJrRGZ9/aA2aAetQFvK59+3bPpsIn5vBJf59BWFv4PIFkgjPqa7dx4slMIdQrordiiJJKkCtfuaZhNeUwaT1h1K8h5M2Yl52sTfHz1iv7erMeEX6eijEkTXARcaUw1AjBZcMa1GcSwc4r5m0SKaW7j0LvNsz89ibY2mMXOYRFcbbK410UbYr2VEdQ581MSX0dTZOH4472rk741WYRe3ZvBtTq5G3mhFb6sxwoOcYtheNqS/tWNpUIizG0gUUqmrBhN5cYvsdzD2YiWLHPx0Qad0asLKQQsdi3YZyWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgNC097NHjlrJ566XQ/BJl2GQMOop/1u/DqzNTVDcXs=;
 b=p6BuFfuPft6ntPTNQNcRDGe1UeR8BmJS66Mkh//IcKEW/jBjrDxjVN2Y54lFuJURwziq/6pD/hVN6iErV+okeWsnv6BNTVYhzg7ixCFYUvXUA+jj8hFIdoIiKrmyBrEIQso7373PVx8hx4ztww/cRSVZ0nMigEpJjT21Qf2Sq98VnX77pGxLxMAkT9ladpPcnVxt8uH/PUiv3cgB5lRWuG4eZZJiNS3qF6xtfJ4R5WSyku58GxXDPmHYBHR7+B8rVpCOilHay9a3qkx17LAka315PYxM9TCBpdyiG9TWq+Z4rTdVi7+gu/vMglIGOA0RMnXgIFjnV0rHmYnv8WfroA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgNC097NHjlrJ566XQ/BJl2GQMOop/1u/DqzNTVDcXs=;
 b=JvCKyytRXMv402lkE3EhMXAZ1BXQFhZT3bAnAXIm9ZF3NBDwn34zw3ElJ/dw+PxMWKHOJ0k+0/LXXNfRVyMhbWN4yUEOAclUUGYm9Kxg14O/GMnfSYIL/ejs/SLDTVCSJDWJ9eCbg5wku2zO/2TxRPqnWBgN0FwiNzDO6NETKCf1lRqLwuvYInr0PO+CCgD0yDq9htkUmq6LaNlXbDSeORO3HNzo4TCQTwsl2XEfMgcSwsXBqtPv27NhXrzAfxhO54wqEesfMEQTwIMhBzvVSUwdanMXz/aOlq0DVM+lh67HNcJ5/r8cvX4sEBNK/Tpouq6iLLZzVVk59sDnWJqR2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 14:18:26 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 14:18:28 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 1/9] selftests: forwarding: extend ethtool_std_stats_get with pause statistics
Date: Thu, 12 Mar 2026 16:17:32 +0200
Message-Id: <20260312141740.295353-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312141740.295353-1-ioana.ciornei@nxp.com>
References: <20260312141740.295353-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::23) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PR3PR04MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 14134de2-4523-47c2-c529-08de80423b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7jkzLyBPLDE0q9gBEHzdWazuXq1aTgdu+b7VxFLo8TXo5VlFz28g7P1fKlYiVLRQ3I1Pa6rV128dxGed9Hotwqc1YFRnqbo8h3KBvt4wNv4eIdU4hot6P6+MT6zv5ZBhDCx9Wee3pbwbAZ0WRbYhrNFm6iotDOw8Ku9ki18Nf+CaHhtQfd2XFuI5MXraT7H8GpyAeQnmp3zj1AmdQXLJiY/aUeYQRGSfdJVZyojotj1zXWS5HTEp4Kwdf/+8bnwXSWHyTkHlF2eDJkfMfTecOQ536XQfz2TxxenMLtUL8qCWDUU4dX7WDwr3H67n41YgGP8Ge1qWeFqSIQ8n4NtxTWnPHoZVYUccSiO1klSGJXBLoo7Uj73lwlnPWZzeGbqYURMtIEerquH8eRqLaxpJearouspYK2mcMsCQJGIP4LB22FouNQ93yaqB6eeZgX/iLgijMAz84ziRxlCy4odKvhYT6k/+0xU+NL64YPEEg4Gz0hDc9CdN250yy328ElCM4RNNhSjkF08Rl7p8kZB5GnHbb7616GhGj62VSj8ObBVI9QmcxY96F6GmGuqCz0NWzSD5xiE9Jl37+pY8rSfw6PaQgUF0swf0l8SE8wW6jc5OYIS6rfAi8r8SgcXDu2qPyFrW4LATtfn4xIvYF8p33CtV72ayMPujcyyML80XYAkH4VoCcRs0CONg8gv8xichp42g8N8AmESr0BNwUHNXmmIJ9F45ZuTCiriR280spbM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9aYXn5WeyFNo1yM+u7ptfmDs8oXgOlfFmGGeKuNn32R6t/UrAokVi2CdhyNP?=
 =?us-ascii?Q?B013tx9RPK81JNvfbNk0lvr2IyuGyyH+EEezo1wmMJPPRrJwRApuWJyFc/AE?=
 =?us-ascii?Q?pufEZtKAD6PJfrc87A4pag5CGshGLuoG8joI6f7F0I7niBu71wwcQW+iDO+1?=
 =?us-ascii?Q?y0/efATQxzH1RXZTy57K7kCcIK5QVQotvcotTjMyrQ0rfzIpMgAi6yoRTl00?=
 =?us-ascii?Q?EGgoot7BNZrWweGf9hOfUsVedJjO3+gjTQCn6GNXL4uPkHbUZhiKwEnk6TWA?=
 =?us-ascii?Q?g+oBgIISjM9T+HQVqJxg8knbOe7n5iqUKOtEeF6d3B42F/IaW6FH4eHzSTvm?=
 =?us-ascii?Q?LPgCZdo0o40CMPkk+0WK8YlSkEbAYqakj3vzikgDMS1XK3ywj+3g/0DMwgwb?=
 =?us-ascii?Q?GDRUbJp/BFjt20wxzoLZ1uTt4rbAtpL+ngnnPuDLKjsPVoDSY6f5KctFTOZi?=
 =?us-ascii?Q?ULClGnpxBQSFq4rvrxOaC9oApDdgz0bcn6pzwJAOsmnthgyKMpMrtpJLd8r4?=
 =?us-ascii?Q?HZRTdb+Q7qbMOruKLhrVRwR1YXmJmc3PtT8+aKrqSQIlGCJTezh1Fs0oCPpq?=
 =?us-ascii?Q?z5wVsffPaV7fW+V6qba8X8ECcbg0yKg699EQr5Km0Ipec29TT9CsdA0imkIQ?=
 =?us-ascii?Q?ciR0kGryArnWSgFxPDk9fDr1KcrdxQe2LRQSV1Its7X1ni7sQK39UzzxZLP2?=
 =?us-ascii?Q?gucpA6HU1o+p1J+1YRF1oLM96oGP4u/WunI/5mmwY+zTDARLHiTHzmakjWXw?=
 =?us-ascii?Q?I+X8lturGoDM1yxTBbqgOM57tn8WwIDwPe1/ya1dEAyEs8ku3WVO7/O8Y9E6?=
 =?us-ascii?Q?Ly7gyiV63JKxduGdpbpEFRh70TMakA94vwehMaH01V/hJjhUR2e11tSH5Euj?=
 =?us-ascii?Q?PYocoXvGUwS56L77JRWYH6BET9472VV4iiaBH3QDF/X0lYr/zMb6+1au3COb?=
 =?us-ascii?Q?KXd4BTPMsylufWpa1dIHEOYPhS0xX18ZiXMkXOZfaU5RXJxZHV9kwMLTZa8E?=
 =?us-ascii?Q?+fbbMUEOHyOtG2su67w5WW2naBVIRF7nmNtryNvQiKn4b4vQyeieukWMLNGU?=
 =?us-ascii?Q?zJY1OsjEfuwCqPSjmd0inck2o8e4BmxprWAi4OMOrUMhMlG6Tk5hnmWtWEiz?=
 =?us-ascii?Q?62QsiLE/Vyn3EqSQpmwKcFKu94u91kZ7m72xq0jVkMNGYdRQCy3mMmHNUqiT?=
 =?us-ascii?Q?of3tfwXZNSmIoDvX79T8GK6D7uPWa27nxjagbIhQooewP6JVAWFMNFd74yD9?=
 =?us-ascii?Q?T9xTRCyUkXHs436I97gGfpE/K68MGvODYP9llJPjgS8Oa5blTHTJHlBe9LF9?=
 =?us-ascii?Q?Y2l+GiGAbNx6NJBM2oech0usMu3dxEsJteXUKQAk847/i3Sg8gSJc6ZAm7qs?=
 =?us-ascii?Q?Nq2QeVmEUmPFDvooLQ9nkB43ck00/tYSqdFDwHxfH7IocF02w0/fozlEqhDb?=
 =?us-ascii?Q?qLAHLTfWKURE8CrZ79Htp+P3G0OaYWW3syHu/ZI/sCBKGP1f0jJzOVyVtoy4?=
 =?us-ascii?Q?iEHSDEWTTXqqo6sfCwNEerAj+NlABJBdWLgQMEMvU3/PHABe+iTOJtr1JhsL?=
 =?us-ascii?Q?2lxLWXZ3jIUGGDhqUclChPFH1aKomAa7mAfcQ4fZ0dx9qKBl3jn7mOEFoZ41?=
 =?us-ascii?Q?k5gV5jRTWEgO23aziixep8FmtUb3ZKobotDr8vVDEnMI8HpIvoIbANcduFuM?=
 =?us-ascii?Q?FESdfjSJ/yNjLxGWZEm4uFC3h8HHc7c+v82Bb6O2YJWKc+j+nXgvmPL4vTXg?=
 =?us-ascii?Q?N84MISqQSA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14134de2-4523-47c2-c529-08de80423b53
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:18:28.6203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVjo3qzqzLS0tswuTAvyoGC5sTfOf6D2Wjsa3k0n8s/8T90WnmQPeWvopGunPSWyRb8OyLoLDWHEKCqJURVH3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7436
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267084-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4FF627334A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Even though pause frame statistics are not exported through the same
ethtool command, there is no point in adding another helper just for
them. Extent the ethtool_std_stats_get() function so that we are able to
interrogate using the same helper all the standard statistics.

And since we are touching the else case, convert that as well to the jq
--arg form in order to be easier to read.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- convert jq to the --arg usage form

 tools/testing/selftests/net/forwarding/lib.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index a9034f0bb58b..cf40cb766c68 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -831,8 +831,12 @@ ethtool_std_stats_get()
 	local name=$1; shift
 	local src=$1; shift
 
-	ethtool --json -S $dev --groups $grp -- --src $src | \
-		jq '.[]."'"$grp"'"."'$name'"'
+	if [[ "$grp" == "pause" ]]; then
+		ethtool -I --json -a "$dev" | jq --arg name "$name" '.[].statistics[$name]'
+	else
+		ethtool --json -S "$dev" --groups "$grp" -- --src "$src" | \
+			jq --arg grp "$grp" --arg name "$name" '.[][$grp][$name]'
+	fi
 }
 
 qdisc_stats_get()
-- 
2.25.1


