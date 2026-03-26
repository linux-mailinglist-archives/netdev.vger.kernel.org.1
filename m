Return-Path: <netdev+bounces-272064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI6SMEM1xWn/8AQAu9opvQ
	(envelope-from <netdev+bounces-272064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:31:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E51D335FD6
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E64C303EC3C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B36D33EB1B;
	Thu, 26 Mar 2026 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ir8QhvKY"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013027.outbound.protection.outlook.com [52.101.83.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156F42F5328;
	Thu, 26 Mar 2026 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531728; cv=fail; b=PHDJtH5fGXPWg+cxJd2grmHvItQt2FI6csGMAVXf7cKya4gCbP3sBum4iBR9g2DOzunSxVaU8BHPz0LVsKOx0gZR8FspfoIjf+piJA3Rx60EboxgopTR/TRY14mvCSZ0mCzTgchjf5p892QFRY8fAmlCQnAT1c0h90fBh+Qwgro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531728; c=relaxed/simple;
	bh=uWxdDB+kJCGXMBvLAxL+wBPOw36rSMAijTuJPRYVSww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kKiM37kIj31vuhMOEAKXDI46+dbl6HsUN40OOEhORqeZKcRGfpe8wGu8/0cORlNkVhy5xzj1HDtNb0POTZM/A/HP1b2RvYuSbRxnB1LTqvPiGGKZIFgFxzr/ktGuWljbgdPo9VkDIaOrlZt4qYmBoH6G7BShCGixTIMg3lpu9nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ir8QhvKY; arc=fail smtp.client-ip=52.101.83.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wz3gVknSg90R5xBh2ELVWrYVIsFby2rKgvIqTCNaXe+vqv5uio74la/BNmygA5OS9ysyEvgRh089hTw27wTRBr5uDXgxvfFMYklcxeOGx7lqZNeow967sE78CwYofbse46PBGCTcq9aHm/ewnHqBXlzRXhkuJiabIropJW7b/s6ZseYcituyuNirsA1rUbuAsEA7dhg90iXPVi9lkskHHarBy2DiVaIIV7jM4mMVx5iU+hVorV1zPQazeXZgXvTwpv6Y/OriXBpBM4dC20kg0PEhVwsPFDg6IWEfpaSCytW/4PGo0pKr8+I90SWtxETv9aAwJr1i5A6YceHbASToZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81H2nsAaubONUmWvvg1H2SpZQE59zW4pgOlPNyC3PwU=;
 b=FQmlFWqzNVXkXdt5ZJg8wrTnRlzW4/OZ/SZZ0CVgs0y6VOuAaNsbtcVzCfYVlOVEFw1pZBimPfiY+nGcKbzdsOVEB5364Yukb3VQdO7w8i2mJLToU+vSaQdVMlhOATmlN1+84DXfr3YltEGo3M5gqrWpdPRSBE0iDUmIeEn0WausTMg2F1imYpTSx664wtR27Qy4GKiWteWLVgk59aJuwkfvJ4IDg+IzXgF4+UAutl1CLtEn1kMl4BbYqYBaLoG0dHNoB/AH4uJdCMffR79Yl31Y7BNjd2+1U0qk3FL6to6pywDD1cT3TiteGr20+mj6YAIxCK8dEn1FdJUpUkA1Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81H2nsAaubONUmWvvg1H2SpZQE59zW4pgOlPNyC3PwU=;
 b=Ir8QhvKY6r6AOGKRflcS8PdlbcQhbLsHOrHSBNO8QepEd23whBk59Nkl2a4BCEFmCATAVCgkBxR62bPLK8WQCgeiCN3hk3DJAFkknJ4mHcfSCySR1zOK6RQ4c3qKFzXSyVQYrkjnl1ectIjewW7Qps0Uf4lNCI48Iwk15wVPPIo0BUcOM2JFwip6IPglk0GWSMtrIMDj31ke60Piuadctx9hRRkW5W7ewkZh9eBPgxnCO9k31bXiBaPaqPJ1vcbVhyGVsuyMaHTZGjABFDlfe2vDGEKzoQVTZ7NpsSIs4Iyn6W2gEMr7yiKBhfWtP/wLRSzfkcFAA32DV6jFVC4tPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AM9PR04MB8337.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 13:28:44 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 13:28:44 +0000
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
Subject: [PATCH net-next v4 01/10] selftests: forwarding: extend ethtool_std_stats_get with pause statistics
Date: Thu, 26 Mar 2026 15:28:19 +0200
Message-Id: <20260326132828.805703-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326132828.805703-1-ioana.ciornei@nxp.com>
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0362.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::14) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AM9PR04MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 538cd8e8-f7ac-4530-d6d3-08de8b3b9a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	mCo0dzUxOxVqYDkOJL39x5QfF/Nvu/U6bC6TczOMvA2678vM8kXLsXSiNhV3vFWje+mKDQpSB14eHLIaFOT+rgWK8+xlqwdOfzhZbe85O+a8eiMkFKd8COAyUYqrw+9PLCS8GdsEHRotUxQTijIWwohVRYh+EZOdXqaSIqQQ4bkJc3T7W2blbF7vaMMT8ku8qtgV8CHXOKSoGvNG8eyIwcNkVAg7SWb7j1hd4+TB/vmZgeG4bd0of+SOMUoc3UyoDOz61pICj08NRDhqa7WOJN6HyVMNGVUb42gdyk6CBl/OOxge37YuQIIaqLli06FvjGM4hdFePBVbeElxmFxkfmcto8KorZJpav/ZrjZfS918bWJsfAod0ZDFFyDDGzUhEXh5oD9EicRUE65gzv24Ae9EI5e4AGohYMLuTrwii4dOsLDPmhT8Sh06zawd4Pgnuq4mEYi6qrcP2RbQuyKUigS7xRBreG+1crDAZqJ+LveSBNG+dLq2+eHXPJ74TsqIsGphOJfhLCdGxWd718Jo5VXX29fKbPlihEmwys0yoiLNTwGOBTjtKKroomgiyysh/5K7bV/RstKLQjSQnp+6I0y3EXOFv9k0YdypbLlXTTUecH2ZnzNorVgIM6X+hS9/XK/rnSo0P4dNPCZHgl0D1X0Ve0pg9KuRVXRt37s8z0KGDm56OETDKJwufpSWqrC4PZ20Dcp3H0YzK3u5GLqUky18DZIIyXZgGdVl9Y5B/iM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/P7lTAvuyW+RXFWPKDPmJW/DcioA/poPg9O/O9VqM7FXASpemsNZjcECb9YY?=
 =?us-ascii?Q?9yiG2NPQPhTk0eHat7i8YnoFMaZ6Bu2tMmNWdyW6ir1j6UYMkgw2yfb2wXh6?=
 =?us-ascii?Q?rfPDrCIfym70nMJrAe+QLHLM/kvZFZz3I2P+Y5azx/ttKJc8c7T0dgviWZ1J?=
 =?us-ascii?Q?2phnW9OPgVk5afi0QlkH7SGFWwfREP8Auzr/lhr5GYBbrcLNBHZo+LCTQxJn?=
 =?us-ascii?Q?AJj4z3HvZsXsn4GP9l+sOzFLikbNovMLeSNGQLjZi0PfpzBOMcNev7aRyLlc?=
 =?us-ascii?Q?bM7yiJ17Ez404HDNkaACNJ9pcMuWwSBi/mQ7J4gi3Jiix1dx5QNxkl1GFTwn?=
 =?us-ascii?Q?lMF+SbO79sytUfOTFiShKGU5qiSJlBogICpsnez3RybTlka7+it7S6lhxmiP?=
 =?us-ascii?Q?ES/G/rGmovgfdVD032DTUYL73Jp4sywNcitfut+oKRZUGfkea8hLh+T44ERM?=
 =?us-ascii?Q?rYT9c20NsV/nBoijpsEyZHgbrtzJkRFSf9NNfRlLW2jWxVyfn5Ksbu6aMjEB?=
 =?us-ascii?Q?kUROn/VsSxCyFHerYJWWvF66SlbdxiKXs7P0NDDJ4dgkJynNYHMTxLqg04Xb?=
 =?us-ascii?Q?Bf2AKYtgfP6bsgfuD90S9uTjTHY8VU2UR5NYuM3aRytF4ipMKITPzkb0BKYy?=
 =?us-ascii?Q?xCLtXAI+B+ogw7VwNmbXsdspxQUdu0v48yK3vy+VXFxvtXro1apC+ylKGI/9?=
 =?us-ascii?Q?xH6n/I8ppym7TC+yCJFnW9woI8VVWrty8pQwUMEsbUmgtPLbCRGXosuMdbbf?=
 =?us-ascii?Q?UBqz4eyBNJ5FvE63/FO7H+Gu2E/WMFvXfkmtqa9xBLUJcFQoVtYRiFWG+dEM?=
 =?us-ascii?Q?46nDQ556+TVK0P/zf1lEEri1z7c0GcSg+spjXmdCq1GRW7y13B37ZEEjsPnM?=
 =?us-ascii?Q?s4U+eYKiy+gl8nHGb92995KOgv5M39/jh2d2uCkHfrLTEkub3p5/WCXzdUgv?=
 =?us-ascii?Q?BNCbIoBQqvJeenPYpvuDpkBiASdfvFU62upt15mWbs3ScAdxMJUXsxgmhA7D?=
 =?us-ascii?Q?9HjPAFsZFdFXmMT+vqEv4kT9AkjE73ICH5RSpcwREHpriGU6KVIBxsEmha72?=
 =?us-ascii?Q?fkqYQY0IyBeAw6CXy6Br+bk/4iNM4HK9DXLi7OGPw2pCI5ervX2g+ZevBLqH?=
 =?us-ascii?Q?TGucH2xMiW5MDoIbPTTSElnKcrPx+LtUf4nzFSDaioPP+fpTV0XZlgmreJV0?=
 =?us-ascii?Q?+bLdGB9guxJF+6HbtQ0iZTN3jbVwQrWVF/u/2muYs8m7tlmHd79f3AMfn6r7?=
 =?us-ascii?Q?rAKCsnwQxNqrNNY0Hm1zX7b0LciQwlsOkCG5cTrQf70vMLTn1RNPSXS9hZqg?=
 =?us-ascii?Q?xtlmbStdH7NvDYUmElZwb4TYOrPdQx+6llGuyqHWS/NtAXdK+tcGgptq7GoD?=
 =?us-ascii?Q?XWBghbsXRqCNk7eBgaMeAVNRQjNI76wKLc/DH+mJqYm4iiNtNxL9AvD6vFLi?=
 =?us-ascii?Q?sgwVdwUqW3aIhP60VGZo/4mH5bdOgZQRDfOZ071nkkf7PqQqoG9pEIFLsniD?=
 =?us-ascii?Q?8EFtoYq3A3TRJNVLAC94Yz/vA0Y5qbUag3ytMNJvvj/iNlCu6PyyGyHvCuDs?=
 =?us-ascii?Q?ZqnA5T+5nWtkOSwRYsLeA7khKi1h5yqfABZxDCf8XTjDEcHJ7YbVBBBKgCmm?=
 =?us-ascii?Q?lXlMgPFsgKmDdsjTmmN9sEfD75TxpgklDokrvhxt0A5SjlR4Dh8yyUVp7AwB?=
 =?us-ascii?Q?csigICqN1JiCGqsigQjnznysqnrpAuX8AgraLuqbS/iMIkzIWDJn+HNSvmxs?=
 =?us-ascii?Q?zwjxZEWF6Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538cd8e8-f7ac-4530-d6d3-08de8b3b9a65
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:28:44.4275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCOg8m7+G4iAburu+glXyzzBZfznHLmTT9pm3Tj4akcMc/jmCxt8tBvWnTtufhQ95rKRVD90BYduURK3qwCE0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8337
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
	TAGGED_FROM(0.00)[bounces-272064-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 5E51D335FD6
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


