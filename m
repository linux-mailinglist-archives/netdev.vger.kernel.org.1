Return-Path: <netdev+bounces-273253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBOPFOeaymmg+QUAu9opvQ
	(envelope-from <netdev+bounces-273253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:46:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4D035E1F2
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F4253001ACC
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F0E36D9E9;
	Mon, 30 Mar 2026 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YIsjU6XL"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013021.outbound.protection.outlook.com [52.101.72.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE936C9E6;
	Mon, 30 Mar 2026 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884652; cv=fail; b=glEZMKmo+713TvPdifX14sB+MPrVCO/iSAjsqgdR0Rtma3RKtQWdI5+Ey09O6PhiHu3AjWSyiSxXEu/HuFtkCK8DtpMGH3SooNWyIonqahYfFCzkwylPBR5ZIF4JeeeIEGresdHUgRX9Jl3U66Ms/YcMppILewozoNUNaXzlPu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884652; c=relaxed/simple;
	bh=53ZF15lwA5S5Ztl9mVLNgklp1vEpsLQ2F3DUkm80A10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y5VsflE8AIAMUy3P2noHHxOF/pUiAZbkROGk/D1a9C/0rVerjFb9ooPbR53z+OYHtaOLCCgUYHtseZ40aONWp82FtY/PhTxFT8/56LOx5BnDYs5wArIUV/EDm3zsxhaciAYQoruRDFksRqBkdqW7IJLeCJeHWFGNQZ7AmsLXukc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YIsjU6XL; arc=fail smtp.client-ip=52.101.72.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LktpSpurx6TlWaasg+DZXH/5ULHtWVSFV9ycw6xcmJff8jFyBQn8lBkRQV6Qegi3ikpx282zsPbuUChksJNxFqDXmbbyxolQKBm0pzVZBOAZq1OKfJyy6+V75zxe/oH5cSho1Mu0ZC7X8WXrZvtJ572jrwY/dDSqf4Ji1GUZ5WtsISngBPFlOnG1GJNFgD7/cfM0rsDSzRvny0+h7B5jEeZMwYzzUEbWzhzSC8KeBkYICtJIN4SiDqWij92Zm1EW4E/NTcXndiqykDviTy0YpZWuDsJ+v+pyKmw/Yp1sIOtvdLWTtCMKTL+glvMpH5VXM2JdXQRiks0MDUQ49ZifAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lcg3ynY0gyERLnWBZhfn3C3sEG6Q6VdgGocQdK2/Tzg=;
 b=ZwX5KnuYUmRqRJ/woWHsr74Q/9zLWmNxzLoP5cjc0qSnIotqFmsRbZnbkH2UTomY+fK0Nuk3BL4beHl1SGmjUt/cXpBFDtn2Vfsr4WFbplCCpcD7VVco/HybNLBXw7WvvrxO4gJnqvWnWsJS+HnLPBU13mhXnf8OKgdAb6kamRke4IizzcACovTD2xwm7KFMleMayHxseTqUGRgTyNiUbr5MIT4gYXMifZ+0fsHVYi7/Fi2ny/PXo6axxgDqOGXyn+0PjkmUWRRdClnMjoOH7WKY12JcMLy50jOsauGqQP3h560hcsdFZoes69KFAf518H2KFWYvnVkQKbxXfC+6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lcg3ynY0gyERLnWBZhfn3C3sEG6Q6VdgGocQdK2/Tzg=;
 b=YIsjU6XL1k3vN6zUDn0KUmPCAJVGY1SAGVEpom/SQ+DAk4kyPsQVpHI95GI1paj6bEb2ySPVfp+QlYUMI5+3tNHAopOD9456tvyRQc3H25TMurMApW3rzNeW6m1DN+xnri4o6lCJX0PyeckOHZFPGak9bO5StUm99r92Mjzz0dQv7gGpJNIHyAUFRWCNvB9V1n8dBfycSFsSUAYq1orjOnPFDyBfsHIaoKvkDUFTobvvJmJ5YGbEa5/mnLBWAITKrDfZkzeTpOowZH08q3UQq13sdSPgTLfHoQas+r3EZBMJnX9U+rTGQeo5//fmb863kBD+5Y7ZBGrUFewgdvndKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:30:48 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:30:48 +0000
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
Subject: [PATCH net-next v5 6/9] selftests: drivers: hw: replace counter upper limit with UINT32_MAX in rmon test
Date: Mon, 30 Mar 2026 18:29:30 +0300
Message-Id: <20260330152933.2195885-7-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
References: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0011.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::21) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|DU0PR04MB9372:EE_
X-MS-Office365-Filtering-Correlation-Id: f329b8c1-404b-4e36-ce73-08de8e715160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UaBNJTnxTqTipuLo4lm4ibzDA2Sd890XYE5W7nwGeyLZGI6O2glEscwBb36WCPIBCKIAiLDzIMai92ZDcWlG7sb72UoAS9Y6B3nZQbyP9YAlMY35AzrOdPhen4QN18Nai8BoyOoKiJvslBLrrue9ypHquBLwSbAonIoY2q7SNNIhWe3hlWFBQRCsMIXynyAZvfmQHkbYZfs9/liR7sG6PAZjGuCC1J9B9RfEXuEkOllrx0MjbMxQ8MEfRv3ptjr0SjPwg1bWnmGujs/ei/PN3U1GKp6b4Eb3qkchu/gLiuTRlKAlUNwjngaui7IyK4I0RAMwY1ZbZ4oABbIXALAXxyYX4zepzYuCDlLkAxghtAqOGvCSjJ+tzfC89SPyKA5mPjl4YdLAyYdeMkNdWngrAKUGWZpjfH8d42YhAMxSko4gHUC6eFm8F6JIqrL+wFRW5tqXhwIcyPDMWTDPFYVMcYdIWqxMVRJwD9PjMhryzv4a6ccaoHcwua1VVmvmpL/VBFq8jglzqHzOKFnppcZgkDg5rqE1B+vK4ukmhSf7E3yfme4y8Qz7PZMHJH8Poa1naem9E+4VBvz4wTetirl/5Mi/RjDDcuikCIQIIHdg/1msFAv+Em3yXr8GT4B6eE5ghExzL/A8OOKdex9RGCAh3Nk0chqrSDj+Z6jnh8PnNYvaEVRa06W3LtWK1tlrKw9kshJl8C7YXhADSyFoWO5h2XDI5P809wYRz0oFKZXPmO8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SvOiFLp2+pjx4KYINKNBGtQQ/7oWs8BiRwo5h7ptVbeDBuR5SebJ/0ly66No?=
 =?us-ascii?Q?NS6qW+Mti7g+JmAEv0cbwQTkhcXtnHVdyIXNmzNXF2S3X+hxXlEmqnKpgEUb?=
 =?us-ascii?Q?9gWUwOUzxwcm32SRpFUNFqGu6XsJkkmG9UmFY1xxVEzwRAx9BVocFfCS7Ejg?=
 =?us-ascii?Q?18QMEmei/zJ8dqQY2bBplQ6w7VwnmNJbFD4yqu2stw3ecZlMcwuo38oCzzo1?=
 =?us-ascii?Q?UVLI0wUDXDqr9ehDc2H+pTc7RcRHavcMLidwdjXDMDALvf/YqCWzQ05M8+y+?=
 =?us-ascii?Q?Wrfr9hCAP7336gv73R07n3KmiaAEGhyh9M4itH8Mank3n2eH65SXjZmWFg5U?=
 =?us-ascii?Q?LTe8IV4x77KbRzuKA5q81vS4ZisdoqxEBx8sma++2YIWvlcqxyj+PTQCry0W?=
 =?us-ascii?Q?uaJk5r72HPOA37mgAm1rpfU61+fZfvuraPzZ75q+oH2t4XcoscuOzhzeGGDA?=
 =?us-ascii?Q?t5BS8Do2TYLrDGYLm/hkN7DKJlTTBEXSPKlRUA0N4h62bliFkBsLdMXZOUe3?=
 =?us-ascii?Q?2y0BPnpX/JFUlkGf0ztoYSEpcxRjWWgz2M2m1dzSVVmiB3f4QYTjs9aCqrea?=
 =?us-ascii?Q?WuzDXnxekhkwcWNlnbK8Sg350nd5oUwNvg+BVCDsHzS1plXGyhpRA+FfXii6?=
 =?us-ascii?Q?6Kb2GJzo9Gfv+J+wIxinLOJHJw4Yk1zFu09pMe3kqQ+9YpY2ry4DfgLPdUxR?=
 =?us-ascii?Q?VEZtoHR/TzX7yXy4QvlPwC0cYXR4F1K1fs2/2zttrFpbMIpAxy7VLGHvIJlB?=
 =?us-ascii?Q?FweL4/EKeJn56zU/uda3RuUX/uk/CeCBfYl6ALgwrEcTyhsn+tg5btWIc/3q?=
 =?us-ascii?Q?lFqHCek88orTL5okZwxoKoatSkQpRbp9+ivHrpY7XLwI5aFwaWffkEIyNfia?=
 =?us-ascii?Q?4OARL/NAZjE7XPVDfdAOKlNT/9VUdFnOZdk/jFCDjv/QogyHNEpYSv7crpoJ?=
 =?us-ascii?Q?0Y6ZCidh7LUGC5eVH9AIIMsag/mH8APxxySQFG4b4BVdsDOZi5LB1DmpTatU?=
 =?us-ascii?Q?+Tktp09Qmx3JPuUz0pcu0jIvsVl5+wmjIdk7ZRABom1p4A5U6wN5aw95KQRy?=
 =?us-ascii?Q?qGsg4A548QJHw8GUTcq5JF0Tk5npZfVumqmhMp+89gUQX4Hhv4xJ/7ObLffB?=
 =?us-ascii?Q?jxIzxsHZ2I0PRArNu47FjVbBUd94BmjHUsSZCWEXgM5FsYavXMjS3BEVfkEe?=
 =?us-ascii?Q?bSSOvenw1cIwWAGEH7jEAUQMlpQS/cp+1HeMS/PBmIYrt17PobS+97AE7ZT8?=
 =?us-ascii?Q?/jJ1ntLYOwnWZjCzQmcdx/CP4StZDnldFxGpANM/ezWj1m08V+FTKneTJSEc?=
 =?us-ascii?Q?Xy4REDJ5oe4z3hUqBHHj25RVy+twzHY8ssHCodeceym+OJP5ym3BlXFjpzEV?=
 =?us-ascii?Q?/6mx/3xN8YwOScthUZV5vBH2Mm1IxTy3CveeFG5or24Bth8g5pwwEg7NQ+8P?=
 =?us-ascii?Q?RA3pstv92emxQ1n2sGX2ISiuLZSbK+pfYyxw/IRxLkTfo4SJ2nwKAdWYJKxs?=
 =?us-ascii?Q?5Yphm6zYGfqsR8BVWEfLf2X/wV45utsPVPojQYWSiUXYI6YaVvDBtADCCdiC?=
 =?us-ascii?Q?8Q3Rg4XmyGilmmKM0wjCLz8ZeJ//67MeyYB58Uxg3ga8HJmqsvDa3KuviHZT?=
 =?us-ascii?Q?qN9X9yxRnvVsGdIH+gKMIq9GvWK/UWMpHNOMvC9TbTe41GgLKLKl5a0PbebI?=
 =?us-ascii?Q?9zb82BwPEOS6Icf4fP6Aqx1n6yaJaNwNooG/wiCEx3acOIxFYCMrtPJ1wbpP?=
 =?us-ascii?Q?OaEOfJ+t2A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f329b8c1-404b-4e36-ce73-08de8e715160
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:30:48.2607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zwz9d+PYkttpHhyh8OO1loG5WlXuAEQvm2bTc0XQW13ZupeqsCTfcm2k/VtLF4XYGNIO4d5teTLXNqzRnoXZOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9372
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273253-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,ethtool_rmon.sh:url,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: EF4D035E1F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ethtool_rmon.sh script checks that the number of packets sent /
received during a test matches the expected value with a 1% tolerance.

Since in the next patches this test will gain the capability to also be
run on systems with a single interface where the traffic generator is
accesible through ssh, use the UINT32_MAX as the upper limit. This is
necessary since the same interface will be used also for control traffic
(the ssh commands) as well as the mausezahn generated one.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
Changes in v5:
- none
Changes in v4:
- none
Changes in v3:
- none
Changes in v2:
- patch is new

 tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index 80e75b9b40fd..f290ce1832f1 100755
--- a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
@@ -12,6 +12,7 @@ NUM_NETIFS=2
 lib_dir=$(dirname "$0")
 source "$lib_dir"/../../../net/forwarding/lib.sh
 
+UINT32_MAX=$((2**32 - 1))
 ETH_FCS_LEN=4
 ETH_HLEN=$((6+6+2))
 
@@ -64,8 +65,7 @@ bucket_test()
 
 	expected=$([ "$set" = rx ] && echo "$num_rx" || echo "$num_tx")
 
-	# Allow some extra tolerance for other packets sent by the stack
-	[ "$delta" -ge "$expected" ] && [ "$delta" -le $((expected + 100)) ]
+	[ "$delta" -ge "$expected" ] && [ "$delta" -le "$UINT32_MAX" ]
 }
 
 rmon_histogram()
-- 
2.25.1


