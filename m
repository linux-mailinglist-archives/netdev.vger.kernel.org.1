Return-Path: <netdev+bounces-272068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP2kGEA2xWk38QQAu9opvQ
	(envelope-from <netdev+bounces-272068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:36:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AD53360FF
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C98CC30E899A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384D93148DC;
	Thu, 26 Mar 2026 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TJJr2Hk0"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049C42FC037;
	Thu, 26 Mar 2026 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531747; cv=fail; b=Gb2PIBOF+4BLcplR49p6XjlMa7fr4c5IbWXPnV07hR8i3Ax0g2cc1mcveI6a0QnUhklex81DMdAzvG/9WWn/78dnbXfLnQBMAi57g+sWGmjQDnr11XCFRMCTfgEmg/yPRKSotUl/BPSK+HpQDFGAx/o9oXTAmTuTg0tlB6DENo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531747; c=relaxed/simple;
	bh=sX+/91dOguqHHU720x8cq6zsva6UbadCTA55LMcsJ+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I6y1lrE+YKy6iHi3d7kcvRQi6A+D6zwJrZ4Ww35MOADpK9IQkQnUWuFHlSb0ICcQSe1gwtVIPwJRR/gJ3ysQ0S1UvhpOmlYW8xTejzvQqb20FzwNkTPLesJoMtkONPXXJzYSlxT5wYV6Nia4vyIDy9yMLfE4nbqxKn5ohNG2WCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TJJr2Hk0; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdmNVinnB2vsvjCnNclEWaKmY+M0ViH+wlDrcfJ461TwPh6vG7AAYp7O4ulDR7a/0ZDhlEbAlMRbxL/CAAo5xlZ54zgZkdf7zXk4sQ3/6xE5aspQMfZkScsD/1p6TUHKKWVktx3Cl1+T+NUtUnf3S3RbaXIdTiFBudZXIoVUU2+qO8RxovS2PHM3m2QC38Ev5j0cAyDuTmouTrgr+Hw2AvrKy/l64nph+iWCsDykNbGM3a4yv0WZv87mC+qZedZFRH0umG7NwqL2cb4JOk8By/lifyRHrVET/gqiBR7t7xEB0Jfmx6zqd4eQhZ5TmmoNvA/RL/isgAyvfqzz93ew5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UcYc/wvZ+z6XxiY1PGz4zhS+dsjIIk2EVMeRD9nMuA=;
 b=ItpLUYpc4HBMlbsixJx1etQAQR+310CjaGq+75IWB58nBhQWv5Cp7mZjC1aTSTpi9eoHMRPdMV2VKifs40lYPQEdZGgAsHakMnGIlpmE/m7pTUIgFKHrp/S0sBiLxuXuHWHkO82sDjLNPh5xYu3oo9Sm+dntJfv7o/r8BxBbhDYISwqzVSg8btQ8oXMFKEJ/hEkp7xDBb1uOsuehfBq/sqe3/B7rDMRvTOXCJFqduhqqFivwuGurkGASmdwslrQffnls5umE9LKbIn/75g5b0TF4h4gd8xUpAoMyDnauPWVpV537uhQqT7XJvNd3yX5Im4VEswcdqWVvdcJk0aefYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UcYc/wvZ+z6XxiY1PGz4zhS+dsjIIk2EVMeRD9nMuA=;
 b=TJJr2Hk0lhij9r0NeWw9a0YJufIv79RRm8OEW2Hl2kT4f+eWuXpPmSnj+a4CQOQfOqelf/sS3UNTYIHOQ53/DCYVlVoa1MyqTMB8OskV0w2+RZlp/ZSOVeCSRpTftTF3sZdv4W79Io+GwwxnxPPVShvmIwWXUgO/FBpgUlXfwCyQjSVECY6f7pWSVDnXaiorK4e2o3cZKt2mliQm/TfhDGq85Wnm87UjqMNPFfdJD0SaHWl0u7wwKXsQTtW9nul7LWECWSIkQfKZxkJE789T4hKLNRp/FHzGn/0A+ZZ2LOxRfjldPk+/Zj754nX40h93rh4AkmuXVJEShIbF0aTH0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AM9PR04MB8337.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 13:28:56 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 13:28:56 +0000
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
Subject: [PATCH net-next v4 06/10] selftests: drivers: hw: test rmon counters only on first interface
Date: Thu, 26 Mar 2026 15:28:24 +0200
Message-Id: <20260326132828.805703-7-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326132828.805703-1-ioana.ciornei@nxp.com>
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0370.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::16) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AM9PR04MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 381a46f4-65c6-488b-5c30-08de8b3ba190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	wyX1bPrM/WW8jC1k+ryxSS7gMCkNYu+y/QyTzR39mWG4L4MIt0B+1GuZQXescqRSOGA0XN/DFFnuaX8x2E8n/nMvHiLnbrPowLN8l7EDXwSnBirfOaaiIcL4hvtcaldOU7GTBkWOKuJQr2r7xXXIv67y9JdtFXy75r7pD9VOjbCsbxSnVL6QRABByJ6u8fkqj+IC56D5kweZUPEDUPXpK8oDuxZRS4++FhjSJJdQ9k/BYZ8K53QvY6vwl339+jtzYEvzOypPbw3baNPJBspxh0Eaz76v6KL+XmJr/6mkxCAnwOokzIdP8s7iHzc2vYe/KzN8JKY9VbsZ6K4Pzb3PpnyWaN41KD1elf+WtAmhVB+Agi/whhUw2F82jFR9n0mT15/JWXthD3flvyHDO/QJ9pZfDiFub7TLGYnhftgh9Mqid/3hsDrg+6KTeUG445SUvuOzwJa64UqxF7j6v9SOMfdK/0NuDlKS9yRTTUvYLf/cR1TnRx6OBJlPwA+qSq+oGuT3Aj+BvIhMlZQ1vtPFJntK4pUYcHE4+cwB9JC+gYgBng0ycYgag/uNJer779n1yKpeh0hpu2tw3XngttNH5/gi4jvoPqKpX44+0Gu5AanqB29ApYF75GdigdQcEqMW4fQiNUeYbXkEnZ4iPr0H8L/hPKeZOw4NmnvNeAx6+nSiF3+RgEG53J1a6Dyigle/hpb8cVWjKrX/wmxAlxewAgkA5ln4YDL9bIByHPcnViE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UDOkj7PxzamMalG23hhzzaQLwbiKs6ryClT+2bkiSC+4bcs2AR25QFIOh8pN?=
 =?us-ascii?Q?jV262l+A6G/hboy91IZloYTmwNLCbBXlMJVrECAnfAlEiHW/8c+eo8AZt6SP?=
 =?us-ascii?Q?9kpUa/bECcxFPeiSDP/yKtx7CKkOWo7kVvIeTusM5PYMZzzbF8gRrttDjqNr?=
 =?us-ascii?Q?cd1kkOAr00EBCUxKub3VsLPBXBAqCsN0wyHGSr3TeQbQFrpiW6dBgaqnLUIQ?=
 =?us-ascii?Q?aRG62Zq7RGwPO2ezFYMFTbiqovdYKqE06x4QbMVWThhO9Z9yTC/6ixmIm+9I?=
 =?us-ascii?Q?lXwkF9zCqOwM8iTZw1H81zee8pAFF3yVbLFCVVYO3doc3N1jIosEMUXw9OLJ?=
 =?us-ascii?Q?K+l47BvT7QVebXQJXdROBsBvRTpfIed68lcY9Qm84qWzoqr0uDES1MeW26Je?=
 =?us-ascii?Q?1oHCeZHKJ4fBw8EFqOBg7YTfTO6RVvWifT+gFooK72DERdPdPp5m9YT298nr?=
 =?us-ascii?Q?mMXeqaCUhAC7CIWAWdy1XUL2zZWQYlyk8jc08uM2zV5ZfKqFrUSwPfTKPVrt?=
 =?us-ascii?Q?AkUwGnlKpZNkS4ST4j9QzelpLZnO4DgonvLHvsXlA3rL8UWwpLyi3foq12U2?=
 =?us-ascii?Q?Njs/NWQwRgqlLE7y/fCqGfbDhpX/TuZx2Lejzye/Yw7aDwIY5u55Bd0H8omc?=
 =?us-ascii?Q?x8idPXWTpS2X4TF+U4VxHRexthbygWrqUMf9xtXxJ3obAd1oX7GaJTNDg0or?=
 =?us-ascii?Q?PlLVSgjxZ+9Epatw5lC+cld12yRvzYj752Ep+4f6u97pWzEYnZ1yRwn0l0ny?=
 =?us-ascii?Q?PsT7KJ6s9WjcVWui/7nfoZ1/nAENDM+kTzuACNulOxL4cQJ22+w3THu6oNqd?=
 =?us-ascii?Q?5Fa8daLzzAG6J6pAiJ1O57YXRbnbHQxSjmbVZA9Rz+CfDgW9eY4LxBlgQ/ET?=
 =?us-ascii?Q?pckhJAC9KDKCcgQtVhnV29RJkjpEzVi2N/8JuEnz2Q/VtQT376NhxJGx3m83?=
 =?us-ascii?Q?56Sy6QHyBasTD8AiZa0LGTiq1vWm9t+M4R1SG32kHxqCoTSzgjPnPos9k+Rn?=
 =?us-ascii?Q?I02Ua4HUjFeVK76oqfIaSnuC0B+SGgdJiRoQTwDxv7GWwnxsjdEoWvVntXma?=
 =?us-ascii?Q?QRgm64Wf6vScmYOI1GewLMM1fpr/NpryllssatJoHdAOHgSGaWTCrdESmyko?=
 =?us-ascii?Q?EUufLyFBRkNAsxJzPS/lf0xJKiaSw93QYIoeqRLLboZ6oefcnYajh3mYRxNx?=
 =?us-ascii?Q?j0SsMdN9Al5Dfme+WP8DBVIwIpt4M2tIGicvjhGI8UXAZVrtUUGa4F0VBw2y?=
 =?us-ascii?Q?O7+v+ygdD8uW1yBXb3FHrL8b4IoFGuIQ6hgoytD+MVgO8ZtEV3mQNYtFACGg?=
 =?us-ascii?Q?uQJttEeiHhB6oy8pqhwhDrfDHKbsydR85a7Ue6NKca4X/kVUyRZ1DEFdLd69?=
 =?us-ascii?Q?NZzTxoH9Dn30YWXo/aKh/EPSXMjLZKwbWXbFhTj0AiAcN1vkrG4NKLyF2T1S?=
 =?us-ascii?Q?H9/PCVjs3lw6zmQPzLHkOHQZTZnxzmiqjJvZARZwjFgnT8Lu6pNbhlz8o6fM?=
 =?us-ascii?Q?AqyPqALIBGYFBA52GnN9B0rul7UnVsRgcX+/7haiV+SLxDMcwEWwBN11D+Ov?=
 =?us-ascii?Q?UNXSHQY+UWmfnzcL9vcsuWadkLsTttmPL30Dh9LCcaOiPSsAjXqoJDvEfcgu?=
 =?us-ascii?Q?rO1E7iX29ewAz1umLhF7izDwrnR91vOuI/nY5OY8uubhU1y6t1T8Y77qNLpt?=
 =?us-ascii?Q?xcStw5NvYvups0C3jJr0CYniZwmonBgQ9YBEXKL89641NRiYlfE29neVmJPN?=
 =?us-ascii?Q?6+TqtuFl/Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381a46f4-65c6-488b-5c30-08de8b3ba190
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:28:56.3972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGCbSbv91Gz6t4aheZZQQO5+268pkBamPWJZeyvzC6fESRuBsJ8LqFD+uVmqsiOAe7gue9ZxW14ytQmkP2mRQg==
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
	TAGGED_FROM(0.00)[bounces-272068-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ethtool_rmon.sh:url,nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: B0AD53360FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The selftests in drivers/net are slowly transitioning to being able to
be used on systems with a single network interface. The first step for the
ethtool_rmon.sh test is to only validate that the rmon counters are
properly exported on the first interface supplied as an argument.

Remove the rmon_histogram calls which intend to test also the rmon
counters on the 2nd interface. This also removes the need for the remote
system, which should be used only to inject traffic, to also support
rmon counters.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
Changes in v4:
- none
Changes in v3:
- none
Changes in v2:
- patch is new

 tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index 13b3760e3a40..80e75b9b40fd 100755
--- a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
@@ -106,13 +106,11 @@ rmon_histogram()
 rmon_rx_histogram()
 {
 	rmon_histogram "$h1" "$h2" rx
-	rmon_histogram "$h2" "$h1" rx
 }
 
 rmon_tx_histogram()
 {
 	rmon_histogram "$h1" "$h2" tx
-	rmon_histogram "$h2" "$h1" tx
 }
 
 setup_prepare()
-- 
2.25.1


