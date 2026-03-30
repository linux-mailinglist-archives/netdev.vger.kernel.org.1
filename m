Return-Path: <netdev+bounces-273248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIZgJrWYymmg+QUAu9opvQ
	(envelope-from <netdev+bounces-273248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:37:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE0D35E01E
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DD6D301BD49
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3587736308A;
	Mon, 30 Mar 2026 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y00KCAXX"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968F345CA5;
	Mon, 30 Mar 2026 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884642; cv=fail; b=hcnmsGc6cO8rkJyxQnGtz6speTWWkS+pDT/3qsLJuA2qJr8Cz8BBHNoE/yjoFNi2jRd725iwkOQdu16KlfztWirGYXQ0llLOdH3Xx879AFM+t9BX/1VA8/A/JvOg0rf7nJVg7wgQ9hsVEzNwCjnA6Uzk7I8aKa+rfzZSql0re4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884642; c=relaxed/simple;
	bh=36llxT0ME6Tuimk9mzAam1o7/6/ylKePcgofsiSSgWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nqq0nPfSUoKIiAylQ3PCTIZ+CRze6gDOYeK9hkCThvtHHpx64B1ei1tUDdF4y/rpX3yXF+9RSqNO+61Hg1nWEewr0gxYbDRiwS2MUb5rlpF/ZmBgxqegz3dRd5rE55XgDtRZ2n3xJYxYzfQrIHDpUQXxepYXgYLlUWcCxDRZUKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y00KCAXX; arc=fail smtp.client-ip=52.101.66.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3JZQVXzdf1Ga8a8wI5o5lg03jrBdbtR6QUe03OEGmVtG/sZg74izSMuIYsRt14W27aNLI+ywbmbuwr+ADJpWtVJgNpyTA+SoMH0js6WhMWHscohQY7S6YHo5MNFdWwflg4i2ErSes5y5bMASK/m1bu1/brUKvUfzVNh1zT045hxpnPhyV1nYZ8iPbN1VrIVZLKbtMrU7ri+LlXs+huNjuqsARcWTkB3xem3XIM2Y6pomxnXUfZjhoEIhafGT3w9vh5X2uAihjhVn2+dk8SdlklNIOD9VJ+X7E8kWWjb8B6aYQQqmrPH/RI1C0CBOLww3NgdGFgdo+hQCgAg551nBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QttF5WFPizd+76WEx0REijRGMrvgIV/t5QQvRatZ7Qo=;
 b=JsmJnZw964axXZFmdnQS+4B84+U6NvW9oeHGDx0EmdtZ46j7B2K92r3O6pN8b0cVU0Gip2oG/L4KVQ02hefykC0LhUfFL4LGV2n/+Wpw2fSOsx2zOLFLoKA7pZEVYEzEptpwv0C2AsfzgoaYcFnJSrTr6weJfX7cYpVpuqxzYS2rHRG9cNyqiLq7+dt/4ogrct1lYPXloR283ASpuhE+FX+X3rOGFp18AcOSOzPUOW05kMV/1whFMTEUPdu1bC7NUVhuH+anKYPxI6mlk3lYsZCp5eDMG9GjQM/2Wziyv1pbQNJoqnEtSuWYZHZPvwr4TyZ2AZi/ssRmES8IxU6VLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QttF5WFPizd+76WEx0REijRGMrvgIV/t5QQvRatZ7Qo=;
 b=Y00KCAXXpzHnk4kotkcIb65y+8hyEFLh3QjPP021V+pHufexHUeXVW8vGt9vWIq38cVhLxPucAtH4YgEXo3ahhkh7jz8hYChlIvvJ6rlAG9gljhPq0LqiVxQJaXU4UMCMOqLxZ+osUzDHmkZX1nDempHG7oSV5WR3tm9kTUDWWXz+WGOv6yDWz9x6H5UFWUMxMRinmH6W7/QdwRGwAwasHzsSjpRoKmvauYdPb3U2tGZyx98gEF/NDDDkcLUz+4VAnGuGCLA7vVi/03MdtlrMOxtpPRLt+JDVzNvrxTSFa2PSCmScVpuOCOd7daC401BaqYj9TLR83ZryBIT6DJ+Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:30:36 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:30:36 +0000
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
Subject: [PATCH net-next v5 1/9] selftests: forwarding: extend ethtool_std_stats_get with pause statistics
Date: Mon, 30 Mar 2026 18:29:25 +0300
Message-Id: <20260330152933.2195885-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
References: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0141.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::8) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2cfa2c-3d17-4cde-aa32-08de8e714a33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zmy9VrgCG37GqUWV+0ZM98QsyA8F+4JFqtO4GW5/rfp+BnOQIfPzAwdVoLqSG0Ni5jugxlklhmHtnzcXCidCCIF1DR3CmfDHZgceqaetXwk89wfvEwSkwyUiLZQkLJBtNfmgTfFErpKTnkopEYez20LWNH0nm2pRe3RC9k3X+S/GPQ/Qlq9raS0hyjMGs/AR7fD91s/jws9iGHHc2XvJcKSI1uqBFxA+0IKCC1OOiY+VDhYt9Ci/JCiCOkyvbz6tWr4Sf2FzHsMZRJXdFMlbtGDgAOlCaxWG9QIC7WYpztwrHc65eBL1JyEyyLwAo7UZ80xoHytmeKAG/bGBCxZGP4iIWaKxRa3AE6L/isQvA1J/8pc3zZNmJFUGcMiZsc6wA8mrlQewLe06p5MI9GGw4soyEC1suWJs7VwgnXE4nOe4WWSfrpjszD4YRqZFwcJm7sFV84ER9WN/QHUL+YvcExznRPS40KoMjiKMXuJGZ/d7Lq60dWmIfEl737DLh6ReM/bFmrpg/WqwwnxirGZqdymH0FIppot5xi4f6WkgATDSqLFKcfSWMVyznDoW1st+Ty8H5js1hm6ktcCtXbSWCxr/p7OK4ELhLaQ2NI55LSdjJ7mdHv46cRrMSt/5WzjtYHvLfFyXAwSlBq7r17ot+SOG64AF6XhQz64VmXTdEGi7qxuYPFj2GzZFOXdC8wRuLo+oUXStGd+SsYqyFdvI/HeW38PZmlyzUJ5c7vBRvR4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LBvOmwVAe2DxaH3nqgIMjvUkfnm3FXxIhKe6yMNnh0AFG6EJxkfLsGaTt8hF?=
 =?us-ascii?Q?RTCinZtrGIoqE3v0K5Tql9sISVrt5S3o0j37zjCROs4XQhDcA+aLCYDlzqLQ?=
 =?us-ascii?Q?kv0sNH757A2JrpGE2aHiPx9lGbj1cA7BwD6ddzm/KFc0Wta+EAN5HFBMLmKY?=
 =?us-ascii?Q?K3E00SJJGePpdEJ9nU1LcJ/vgkYs7L3QVnsD5L855ftLL31zBZpVbiSe8a0/?=
 =?us-ascii?Q?igAqN/VzAXGkWoQODcSgNMxQg8hhEGRiCFN1nLGU7okoyikEzsXTfdgHUBra?=
 =?us-ascii?Q?1F8tewzdkfrswR4iSbQQeAbL4naVwJQbxIMwG8nrmun6cM2R8aeAHeOT+3oj?=
 =?us-ascii?Q?C+ev3/Sn+SYrBg9siwelTnTffUSAn9w7GfCIJ3v/bkbFoDIDI7EpEAzvDJGq?=
 =?us-ascii?Q?K6SNv6/EGdUk8Vtj0l2W4qDWFvHWQWDQY/H8ndJKHYzu2nnyj67sFcZZr410?=
 =?us-ascii?Q?7ex37AgkEhgY+ay6+wAFtLFQDWCpVyjiE90vC3nfa7fxTrjZZ9utry6OIErX?=
 =?us-ascii?Q?Cm15zMEmsTq7ITlaU6NgORdd9XupQYHMEKqmG40EgaNYZlHktLBHNODuQ2lp?=
 =?us-ascii?Q?gcjvs4LrcraEaEMf5XsaBaR468oGCYiXFQGuA7iu+weoj2ZBeaiePryTF4TM?=
 =?us-ascii?Q?RNQYTTgo5UOs7tt86xjOMw6bZGnjqLOE23xym5vXHAAuzUZnG289MsoCya69?=
 =?us-ascii?Q?QjQY4PAYivei8SF5MlBuTyGJjc+lV8T3f3cESOdA9go+S1AGp9tq4vgD01Lz?=
 =?us-ascii?Q?gFcpNXLvOpVxVflKvUpclDMczc7ng/QFtI6fOOqAUwJKxu13Ro7JhEMVQxD3?=
 =?us-ascii?Q?AuZiudtleVmHLlwQhp0XKsO+K1DU5+VhboEu02dg5P54j/30CTrOT4Np9dvF?=
 =?us-ascii?Q?8D0DRmgfZmXUeQLA2tv6Yd4K0lCEDp0A3OPWxF62JU6cdrMd8YSnAvFd+v5u?=
 =?us-ascii?Q?8BaNII5+gzwJHWZNSGsxzUW6zEQjTjFMjhmOkCF903Fizgpld1FHk9ZEhWdT?=
 =?us-ascii?Q?I993rEbWqmBcr0OQnD5rbWikl/qB+F0JCSrgVXD/GK2u3gVMXTsMdB4C/Nem?=
 =?us-ascii?Q?gWRai4jcDtAwIk5/Ix1ww3YMHUS6EhoNYPX3nvertxhH11Nits1YV2FzoNPJ?=
 =?us-ascii?Q?uaOTa9Ho7BrN2TiT7Z3biSEUmjAtIW/ke9zxIMsRAiayobtoYfpCrCkjYe3A?=
 =?us-ascii?Q?aGogUUiBQ0sa2pXgLM/MKxdx5hOxEVldsevzaHZ2l0AeOtPD5Vzk8FzPv0k7?=
 =?us-ascii?Q?H3vo1butdCUxmwwqlLMfX3OsrLLoOhzgJLOxG2WlMY6hadRAnIkUSAUBYjmB?=
 =?us-ascii?Q?pnAcg4dxhvkGc3eTISJs+kISSV7S8EFcqS8FTgCcJg71QR0+hojPXMnhZ83I?=
 =?us-ascii?Q?dOIxmAQ/IGLv4SR+QvuxV1SowRI2UbeWYq1Rb4q3Mbi9MVMDOz5hVsdYV+dT?=
 =?us-ascii?Q?EvK+U3sm/PZHLpL70DbHRaZH2UZ2IsVOXijQOQRS8hDLrpEi5bJBntpsjDx1?=
 =?us-ascii?Q?t5mXzLH9mP8ixjErfTWX11Sk8IVpwPUECyRp5FLE/v7xq7rHdWifybDI4wjM?=
 =?us-ascii?Q?9UGtpUvq1bW30xSoSKQpjmskyPNxnuYHeenlegxsL8dpNGntCBUdhjJVlLPG?=
 =?us-ascii?Q?bHGBCbpfE5ArFwm0NdAv259ffQKPVlwA6pEuykmxq48TAuYhM5yAXIUcmckT?=
 =?us-ascii?Q?pzSz3e+p+yC7uBb9aTrYMNeuZ9kOznTFdzTD6Q1tfX79jSKliyMN2kA9x4Yz?=
 =?us-ascii?Q?2GmBIvCBrA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2cfa2c-3d17-4cde-aa32-08de8e714a33
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:30:36.5143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ua8AzTeCMOHGA6GeKBmu2+lRTxbCEFRZFWguEOAPDSRe06RR8orVC9YjX5KfILtiqf7OzjBS/qx6FrfThn0oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273248-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 9DE0D35E01E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Even though pause frame statistics are not exported through the same
ethtool command, there is no point in adding another helper just for
them. Extent the ethtool_std_stats_get() function so that we are able to
interrogate using the same helper all the standard statistics.

And since we are touching the function, convert the initial ethtool call
as well to the jq --arg form in order to be easier to read.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
Changes in v5:
- none
Changes in v4:
- wrap the lines to max 80 chars
- replace the if-else with a simple if and return in order to be easier
  to maintain the 80 chars limit.
Changes in v3:
- none
Changes in v2:
- convert jq to the --arg usage form

 tools/testing/selftests/net/forwarding/lib.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index a9034f0bb58b..3009ce00c5dc 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -831,8 +831,14 @@ ethtool_std_stats_get()
 	local name=$1; shift
 	local src=$1; shift
 
-	ethtool --json -S $dev --groups $grp -- --src $src | \
-		jq '.[]."'"$grp"'"."'$name'"'
+	if [[ "$grp" == "pause" ]]; then
+		ethtool -I --json -a "$dev" --src "$src" | \
+			jq --arg name "$name" '.[].statistics[$name]'
+		return
+	fi
+
+	ethtool --json -S "$dev" --groups "$grp" -- --src "$src" | \
+		jq --arg grp "$grp" --arg name "$name" '.[][$grp][$name]'
 }
 
 qdisc_stats_get()
-- 
2.25.1


