Return-Path: <netdev+bounces-302577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UisNCCVXQmpD5AkAu9opvQ
	(envelope-from <netdev+bounces-302577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:29:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 676136D96BB
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:29:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=O6Eu3JkA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302577-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302577-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A3A4319B6C7
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5C43FC5A1;
	Mon, 29 Jun 2026 11:23:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAB83E0096;
	Mon, 29 Jun 2026 11:23:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732214; cv=fail; b=ByTCgW3kwL++8zUZRFiohVycbu0Thrd4KXK/dzNQY5HFuD0FupHmRbPR6tygMsarpxU9qTrzyWM2Ju0hEE3mvLtSJmQGDgY1RC6vBFsloYK0Xq+/jjx1Heya/xvLq3g0OcsxQG29pfoRtWIIF9haQGKBGFAmhP6ulqx+9ak4b9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732214; c=relaxed/simple;
	bh=ddW7i++GFhR0mJCUmzbKCFZzAgQ1Fs165WjOqAN07mA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J01zwWCHB6pfOLrZUnbLwETp125F9IS+nuk9+fcsKI3idg2kQ4c+H+T/Tcabm1AFQirQXKsENSckrvIrH00EtqRchbtpItN52QCQ3Bt5vPIpqwkjk9Sr5QNkknwC1EPwmnkSDWcZasMpQaLeujcMAF7B6/+uTszufGv89/XEXLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O6Eu3JkA; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeullIa6eS9v/cfSRqK0CLQbs6wzoMp1t60RG9TRXImOhy27LwiJwTGL2oIBM/uHrgpPcqp/BgS3wCg5Cd/E7XWniZS7LULy40pVzQipJnD5hcKwDcdc+NDSDDEhmzrzs9z3gxV372xx0LNHGSuGZ4GatvJMGQBmO6T4KMm7aLGvcSqPu+LjA2ryQaGsX3QwtZdRhJezGm1jD1vKZ3CpYZeUyF6pgMhUeIDl8zVFklkgP21q45RoTBU+y0aUKbzuqGgLpuUTreBqjLoI/0mquayrit1Vwmc1FCPfjfwYxzapgMeef7a8BDa+E7YImizTeQud0yQKWI8fbVzLUd2Dnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uC7IP9rchHNT8lhN200N7VjuZP2gWcaLza/6tdqpTFg=;
 b=CuaSuO0eoEY2d29DOBnVO9w10XQ17fDdVx1JDKK70HeZLCfzfybswxOom7XBCUUFYec1jpPFjptU00fxRUfrUYvTWRXq3+8Fy0UjcIiZIX9a2756f70j5cjpy4pqBUzm2y+xEvtkcKK5a+4ToKSsxp8OKOCSP4O1b3Z/hq8K/dm9uj64e2EbKFOvXgCvLVbZ9bwt/qyRVbrvD2PGb9yvosiMy5NV8PnmUjnCscxXwrXdW0HM5FvCsdqQw/TXGDurcg9FZ/Em4meho24UEAveQXO6Dd9uQ6Tako8xXu2+supuwlXQcvgdqJau9qUim9hdyUAtZGRY0sj7e4bWCzIsLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC7IP9rchHNT8lhN200N7VjuZP2gWcaLza/6tdqpTFg=;
 b=O6Eu3JkA2HLT0BbZhwlrRUj1E4U1/Qjf/5l4sQaQyxHfuP/WX66CFOPDQgzZZpYV5hZjrl0//xHn9h/5P/zgUi2KcvK8evLV9lyG1MeUUJWJqtyrjR7Ncft5r9126smax8g0lOGxn8Ig+b9NnSTF6mBEkT+xpMO9BlLhJMfotNLMeZ64GgktAgNsDzKbomJfTpnochoZkLGREC23j8m7fPKMi4pnLItsHXYOhs9O8Fmt2Vcrv4C2P9ihGnNAt/dCtCTuiviFzZYo0M0oz9zhqNDrGpkEuOAtzLUWcIVLi0ROc+FV8+BOApfJp7sYzlXrovwMWGhLve0UH/CJausIng==
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com (2603:10a6:800:31c::9)
 by PA1PR04MB10628.eurprd04.prod.outlook.com (2603:10a6:102:490::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 11:23:28 +0000
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b]) by VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:23:28 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 03/13] dpaa2-switch: extend the FDB management to cover bond scenarios
Date: Mon, 29 Jun 2026 14:22:59 +0300
Message-Id: <20260629112309.154328-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629112309.154328-1-ioana.ciornei@nxp.com>
References: <20260629112309.154328-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0024.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::29) To VI0PR04MB12302.eurprd04.prod.outlook.com
 (2603:10a6:800:31c::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12302:EE_|PA1PR04MB10628:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a9cdf8-9bb4-4da9-6cc2-08ded5d0d809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|1800799024|366016|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DqYy8XzeilRI1DEDCcbbEpj1p6rDnf4Et0lUZ3VawTh2+WcYkqx+T9xXMgENXBr0F4EeTIGF13jDsifnVdPJ2gg6yeajVuci42scod4WGRgucCsMT5Sz4B6Kd34bKNZDME4cRkEpUU/LSlrsdmJwcHeQCOtUqvOiHC/OQo344Bnb2y8+p9yCYQzKX+PSFBUjq9eYjGHiD3pReBkgHKAWL0E9nnFYoipo9V+257f/LYnojF/m2xCO6B1C+cv2OyMZ1w905WAOxuwdJTcly2X5OEM3NGLPWV4m43sTdB+gZSib0NFWRHFTLnCbH6O227KSO/ZxSiY8OSCuqwYIq+iVMINa/nN/Az4nDVV3JKiPA6clOTOzU6guPeIPIeTyvxgO2xM6+C4q0HAsXoH+BDRd5DBLluxHYOxv2a7jEeYVlhc4AaXYozqHheTQRwaoV06pCWM31JTiHtogp37J8aaRWSsRgyUI3W6XvphEE2XQbEUgaAom0tYUJOp7AJTFTDT1POh/X7ozZcxpLQ8VEz+q8zpi0DWs8MgU/C7mIZ+MRPHHMyaXBsZp96igEKYrVaxUzAP0W58ir/IdbkOiOEfhnmaU94S6eCNy6Kzq4E6Ph0XD6r/okdNKoa4iyRq1TzExIj3NGsXXUSomZR+CUoegTBvRwKEUtWo/8aKxPgNJalU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12302.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0hLXdFcw0mAjQNyq2Lx6BnfK0jWOSedLEgco+bMnhqQX7o7vpbqrN4zVFMdi?=
 =?us-ascii?Q?PAD4xF3zGgnvpqDlPQjEQZcGNYFIjlFeVOnV3CsIKwDEuE/ysy05If9EGt/x?=
 =?us-ascii?Q?gWh5S+FdiMRRt6XiJnzgFD/ccbNhEtpIT+/j7i6pelkcPqWsoR0shkMp0Y0c?=
 =?us-ascii?Q?qM5TFSxjrEBZ81TvQXsII54zBZo6HmmMKATzWfHowYlG+VyIDSsdfk6fmOgD?=
 =?us-ascii?Q?2BwumIxWMvOC5Wcqz9l58+Sf0coMi1esUSBttcpa2Jtu9bZ+pEk/bs5vA3nx?=
 =?us-ascii?Q?IJdvUVEhSW9uyVNkvDIZ3HVzPRyEdFD3He1YKGT/ArQvNf+/hrGyAaTdLq3H?=
 =?us-ascii?Q?wkMIsVd9Vbaf9bgN8CrdD7o1OyM8d5r07ofzlgJ1KJXR9rTE/e6VMbUsfCIx?=
 =?us-ascii?Q?3NFkJlSfzdKv/GAsLqWFqrXpvq9tEK3UQbGUKk9Od6iJng5G6IhBiknl3cKX?=
 =?us-ascii?Q?mjgY/t74uja6Ctis7Hm9XKO3j2Qryx324K2UqUgKONGukg5n23Nh0b5GFepr?=
 =?us-ascii?Q?MYGAZ3Ed+pA5wN6MOGHohw0tYLGOHmdDFFwNjDO9Vy/MflZy7KtRsO+nBitV?=
 =?us-ascii?Q?2SKj555ucZLyEqWTOiiPri1i1ohcQdBh/xuItRGQHt99ONKLRLWXbs+qj/Xm?=
 =?us-ascii?Q?hHiN4HXTzH5ODsHZUMjIokFDnmfny8GtfrZMZt0/LWWBONEFmInjrks8MsBC?=
 =?us-ascii?Q?P+tg7K3GMkAC3EfMEFuZNgDQRT4tjV4ul4ARFASc/Vd7gxfYfKAupp0WFySo?=
 =?us-ascii?Q?Byoc/g8A+QhsZfgP7WsChzBxl+GSueQ2eZdCEI6zvfHELfmzDmefb/Bz+M7H?=
 =?us-ascii?Q?KjvPdHDTmhXhEC4k6qeu+FjT7T8OFyLtymcoSRIhaC2rbhKNsd8+3kjnrPE4?=
 =?us-ascii?Q?aTpF77rXCl3Diqk523O94XYBe3pUj9z4opDz8Wo+OHhzPI3izu5k8rEZc7jT?=
 =?us-ascii?Q?2QPVTfCxEsS2Gw6WQeRSnRqWdPn37kD6Fnl2xe13Vo71C0XSbXWgY2kmX/uR?=
 =?us-ascii?Q?kzxNBPcGDuMQKBu4DXgNlk1i6fLRZ1SAHSnf5LfKHjuyEzUebaHW1wI+J8OU?=
 =?us-ascii?Q?aUcqn7/2MgIRlp8BG1ENDS6+BNEgZu+NYdFnkb/Lm/sIfWdQ0zjZXMhNZTwX?=
 =?us-ascii?Q?cz+SQEYEkEO7gRLJeyT/MIhotPLYvb52wh4lBDevr4LcmVN6r87nC4FK38tH?=
 =?us-ascii?Q?NyYaoe5FqVXQ5gV64MpcI3kiwtDLzdFkiYni8XWwbl7vuSZkmQrTuXvE757f?=
 =?us-ascii?Q?b1AK1PToMxWbECqaPcPaCOwpr5Bj2btfHE8ZUHdKO7mpG5zZxbCMuTRFx07Z?=
 =?us-ascii?Q?4nUPPplj0rnOf0F27Ppdggx2csnqNzIJvpwUtsIHFxXqvuayF5dW/6dgWpEH?=
 =?us-ascii?Q?XgvvOuMFt8ZWj482h77F/lciCRjQaPQ6D61Ayxc4PafBuMxVHLjUxoRagJTN?=
 =?us-ascii?Q?NHbpBVlGnROnN8KeeVngqtaiBg0jwAqG8qIxeKsmzDJyiLME1o8f8Y3DEtkO?=
 =?us-ascii?Q?qNTlb2NwMtfcATqtLN5/l5sCQTmtZXoEmEs2gXAiTvCnJgpOFSCqcJ2ilLe9?=
 =?us-ascii?Q?R6r8DkCQaq/VeBdPbaCKVaP5ULk/dV0Y5onDR/XCkltCkBN+fAnJratxUfXT?=
 =?us-ascii?Q?6hNir/voHRPghNAb4OYW7U/NDNHP/G9lFdcEZSWk+m0y7VYEXUittI4rjWMT?=
 =?us-ascii?Q?EKudrx+uMniWWfu7PYQtLvAkXc7416lPQQR2ZS0T9B2PKjJKs4VmuH1oUxa/?=
 =?us-ascii?Q?XhXQ8mvA2w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a9cdf8-9bb4-4da9-6cc2-08ded5d0d809
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12302.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 11:23:28.8337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NB8vwl8bdrDIT07IUwgsV+1mUSjoyfPyPTgSA6J9Wk0PpzXYfHrF5cvBgJeJ0pT8jbu5tJDdR5DNRiy7X8k7gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10628
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302577-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:mid,nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 676136D96BB

The dpaa2_switch_fdb_for_join() function is responsible with determining
what FDB should be used by a port as a consequence of it joining a
bridge. The rule is that all DPAA2 switch ports under the same bridge
will use the FDB of the first port which joined that bridge. Extend the
function so that the function also covers the scenario in which there is
bridged bond device.

For this to happen, in case a bond device is encountered through the
bridge ports the function needs to descend one level through its lowers
as well.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v4:
- New patch. The same idea was present also in v3 but the implemetation
changed quite a bit since there was some restructuring work done to the
main function in the meantime.
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 35 +++++++++++++------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 67c639fad0db..eacab00b586a 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -71,9 +71,9 @@ static struct dpaa2_switch_fdb *
 dpaa2_switch_fdb_for_join(struct ethsw_port_priv *port_priv,
 			  struct net_device *upper_dev)
 {
-	struct ethsw_port_priv *other_port_priv;
-	struct net_device *other_dev;
-	struct list_head *iter;
+	struct ethsw_port_priv *other_port_priv = NULL;
+	struct net_device *other_dev, *other_dev2;
+	struct list_head *iter, *iter2;
 
 	/* The below call to netdev_for_each_lower_dev() demands the RTNL lock
 	 * being held. Assert on it so that it's easier to catch new code
@@ -82,17 +82,32 @@ dpaa2_switch_fdb_for_join(struct ethsw_port_priv *port_priv,
 	ASSERT_RTNL();
 
 	/* If part of a bridge, use the FDB of the first dpaa2 switch interface
-	 * to be present in that bridge
+	 * to be present in that bridge. The search descends one level through
+	 * a bridged bond's lowers as well.
 	 */
 	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
-		if (!dpaa2_switch_port_dev_check(other_dev))
-			continue;
+		if (netif_is_lag_master(other_dev)) {
+			netdev_for_each_lower_dev(other_dev, other_dev2, iter2) {
+				if (!dpaa2_switch_port_dev_check(other_dev2))
+					continue;
 
-		if (other_dev == port_priv->netdev)
-			continue;
+				if (other_dev2 == port_priv->netdev)
+					continue;
 
-		other_port_priv = netdev_priv(other_dev);
-		return other_port_priv->fdb;
+				other_port_priv = netdev_priv(other_dev2);
+				break;
+			}
+		} else {
+			if (!dpaa2_switch_port_dev_check(other_dev))
+				continue;
+
+			if (other_dev == port_priv->netdev)
+				continue;
+
+			other_port_priv = netdev_priv(other_dev);
+		}
+		if (other_port_priv)
+			return other_port_priv->fdb;
 	}
 
 	return port_priv->fdb;
-- 
2.25.1


