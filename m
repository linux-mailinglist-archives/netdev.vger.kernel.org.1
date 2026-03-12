Return-Path: <netdev+bounces-267089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI6rF+HLsmlTPwAAu9opvQ
	(envelope-from <netdev+bounces-267089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:21:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A4327338D
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A25A0307FFD1
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB70B364955;
	Thu, 12 Mar 2026 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="apDcB+2z"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA1736C0DD;
	Thu, 12 Mar 2026 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325144; cv=fail; b=oyp4EV0S8Cgw45J6VQ/8uRkE2msL49MPrEMiKVOUbYqoIWx7lHi9ZgzVX06P1zrb2dUd1v9D5TvnMvqm9fX6wpQNOE366pAvS5hqDRFfQtAlvnQnyvNYsZqSzlAGc7vUjYJVFAVhvys7d4AM4o1Ewh1ZsesFd5uL8xwgL7bNGUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325144; c=relaxed/simple;
	bh=nsmnWl3h0EefXG0X+E6zt4yxx5YgvXfoPNPQAq+DbxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cm6MYaR+Y2wOanocapbK1W75J/wyxUYYj6kBaHsZLj20wvpRgf24VoPMljdIPBDo6glwQ48tjqJHMBBm52wadoCo5AKwB2JmP6xYwk1uEbpdzuGqRx0UN096q3gb8ZCbvH+OH+a6OgaaugBh8uLSM4Y0ymbY8e5nzYB6Twen0uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=apDcB+2z; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTs8c0mYdce74RBtK112Ib2aMks2YNLdIhDmJbHYRf6nf0NCHdp25GDgNlgshSjUeNjsUk78V2qBVMDm62PbK1NgGhDxJK0KGwqQl5AlzXMq97DvqHniGfRCUCfFHV3+y1bOxkHUo0MAEwOu698Swz14nSUuGmtWW9Qu4OGAgRFgAzIscCC0v2nGcPyUMyUo1nn5A/fx2bg6LcTWS+C1hbxqlfpeAEVFwNeM2JsuBJEslfDarZrY1v8R63uUw7qnfJAnl+DBxfuXCl6FmoorJs/bcScTFFPMjeTo6P0tb6xusvQ0pWRDD4bmSlzs1FEmQL+UhnJCEkSvlXPMcqVjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCWNcbASa4c2Rr7YZqdQLw+1ZBZ5NW8vZpDPwgttlqE=;
 b=gLKmaL11XfsdLnPlbX0OglEL5gtAquESNkV7/4yGDJYWx9dZGS3cabuMKTj+WLCfKTYQH2mojcEKhAXSPc8BYu9SNa58EFY79vXXsRuHlSX6m5btCPpJI3Bz47Jb7XVoDJDVksYCGvTHLx6lWmGdS1KwjJ/G9AZREbAnUgDqCNzTj2xxFcD+rZJpKKQAWy039ktnzs0xmUIqTlvGn0Oqa9YWqQZkyXGydXFVJGcwC1OB9oOfSomjJiUSKNiqgrw9HL7DMGWRvux3PGqhmpRrrrasu0EKCB9SZD3POaG+a8+6CWHG0QJAZLR6CWqY4Pl9sLJzp2ixJSNiXDvG3z42Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCWNcbASa4c2Rr7YZqdQLw+1ZBZ5NW8vZpDPwgttlqE=;
 b=apDcB+2zI6qEzu8oKNArRH7uYQjReULLae5SWmW+FACL8v98VPItTRCpLjK9KBaTM6uF+fZuVSptwTXx+WMXGJF9Krporrypq/vu7KOQMjLfLnXEVaxkoGWir44mb7tiCO1e9WoxkHCCdj++lsCimYriZX5JPrX4vhdsmMLw+/EzlV444IHjjJuaNxl7zWe7L1qSshXuSR2HGGzCF4ujUETfpvTmyf6pdB4CC6T86f4iauf6BtmcS5URGfUg2Vi1VYSNrg2uX1XHYEzq3MSzi70GSMDYRZYgObt9/DpxvQnubVYL6Vom9UmtmvoQ5ih4YZ3FzZJDjx7Wo/R7EGukfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 14:18:38 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 14:18:40 +0000
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
Subject: [PATCH net-next v2 6/9] selftests: drivers: hw: test rmon counters only on first interface
Date: Thu, 12 Mar 2026 16:17:37 +0200
Message-Id: <20260312141740.295353-7-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312141740.295353-1-ioana.ciornei@nxp.com>
References: <20260312141740.295353-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0375.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::10) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PR3PR04MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: fba9bfad-8bf7-4775-4fba-08de8042426b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	24MoQ+jwjz3Fnw+R0DT4bsrVoeE2xmVHqaHUkP1llgD+hjeKYSF1H7ePdUmuZ4yHlYmlCJv2ews3NvkxJ3TVQBVLNZsYzep59SSq3op6ZU8x1aA3yv/UHge3ZRsyz4jkYOLUEyI7iLq01A70Wcnpk4dCM05uyZytcCrbd5EWXZPvZ6qo7reLqPuAt0qmTGLrTziIM5o9zhXCj9grGZ2EcZW+O2IfJEBEoA/LODNnL/pTcZlFGz4vP4XFD8QkOFAVr3TzCRxycxzFqEVKTs8M1K1nnXqXeHEarDJiU800EkkoSJMjnMoVN7z41jg7XVwoIz+TdX1ZiXtFmHPV7DWxzHxvb02wufywKDjJqfdFeSQA5iYPmjx0TVeHM/pLWBpeDgDJ8vWURoohS2z4GJ+JbcX51awbFo5G9ucrCzviQVvKTze/SNvRzNxiQXd2LdaF0XzpRGatTeNiFaHpmFrEvCFi6YsDzyRP6tqsIqKXIl0Mf3mG486DdCwd+POiHTIkZz4/JRY2S1+f0wbQkP7zN8vjYpH5zn7WLZ20/HAay+sJcnjj2AJm5lKXO2KzMzuwwcvQ1AXp+ys4IxrT7nCwMsQAvftDC4Wd6yjtUEVgpTU9Jo+3oQ+aYLF1/CLRdGw/aynSth2AjTdef1CHLFlOmWnSbqiifwzjTUvrPy1sxUAc6QfwKfw9ENpiGrO64ubZnN5sKVEkMTwRC02Ecqa3XW5CdaeJ7kgSJq1qq2ofQro=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Snd9SpsMSNxvOWh7sZHMBXlVj/j2lqb1Mv3PGj6kuhMoXf2rb+3wam/3uzgN?=
 =?us-ascii?Q?ocLHeSBjExVjcnC1jr9dqJqfbGJE6xBFaR0sSESXexwWkhVJERm8tWLebJxj?=
 =?us-ascii?Q?hyPa66vSImmqY7F7wYrayD/iBMnl4qWzJwN0bB3up3CcCf5fvtTpw7z7YpcA?=
 =?us-ascii?Q?uAq0v6d9qE+edauuZCqRiwLvyggf9gTPZuh/G3PzORmLafixABUsYaVN8Dbi?=
 =?us-ascii?Q?uSO3NPzm5V+ijKa3XO+Me8DyUqeBJYLJwDR2mBX0U2zvZ0R/1PHIU/gIYK3I?=
 =?us-ascii?Q?hy0FVm77AJBGuU1N3W3Xz1te2pDkplpoBvXSbMaG/FHf/iD/wNSS620GRq9V?=
 =?us-ascii?Q?57pO7vt4fG1FU3VBwRa+F2fLp+SywDn0wb2yXAn00tpFAJ0zmy7WgZeZugFC?=
 =?us-ascii?Q?xf/lybdN4nSHkgNRKijBuw9QK3Q9eUNNujYnfKGaDoQTgAar03DSNVY38KTe?=
 =?us-ascii?Q?cjalLS5QBOjFg+B8oGV5ea6AxN0jvoFGDR4hkIWvQGI2EuLmXR/u4G/vlDFM?=
 =?us-ascii?Q?9NlL2CjVGkNeWnTacltiHP3wz9srI4LTDHgtLcIDhN+wKr8bDXeAmPw9+dmR?=
 =?us-ascii?Q?RSCnnK0g4fxwI9kNPrWUbGXkHrhvRuIkKXVia5G0lOI5bUsWReYhUy0xOTT6?=
 =?us-ascii?Q?Kb2+SRfwTj9IJX3qvAhZBzrD8LqO/39Hja24ahrzJ2rdf9UiX68+X4gpI/JB?=
 =?us-ascii?Q?CbM2D2V+IzZvlh9qHLRyADAFlZQEgOLpHy3dHnUW8Ot0vQNolyUyGAUQIGzm?=
 =?us-ascii?Q?S8V3J/XWWuwz9ZC6TxKZtFB+RjPkKD7e7pGHveWzJhMP2sTmKcpcAf1e0LbU?=
 =?us-ascii?Q?i1Lcz4JFt5N8ubLJYfLSrQ06S9yfcb3rHNzA48YfzmvDZGudAn/MiN6xE+Fv?=
 =?us-ascii?Q?caCkRej1NDd8RxTg93Hp0BNnnqE6gQjBFp5cG0U0kSOpY1pWWbWMH0FTT8mg?=
 =?us-ascii?Q?Sy3gjsWsa170g5QPSbrKgqtVYJ+pU8JAWdUj0Vl+ECo81GP2lukhZyu2h/gh?=
 =?us-ascii?Q?UOP2+PLEXDNm7hpUKEaoJY2wJm+2B940r+ijLKJ/p197YfO36Sk/z2pSisYZ?=
 =?us-ascii?Q?+Evtv34SBHqAHtiSgze+vvYsEcHv1sFUADq9bZ68hItn+yVhkDeYHKcvx+wz?=
 =?us-ascii?Q?ZBa6e339UFgYepudhtTPVY9iVEb+4yvFlE2+2NBVXYeg4jKEtsZwjaOiOst+?=
 =?us-ascii?Q?GFlZd5OMUlFb21/uhNdp89HDzsmw6sv9C7WvsZKlt7NxBjlzOnI8PzUlSo3X?=
 =?us-ascii?Q?2V2TA+a25v5vMiQe52+b58ZVxzlIRDRF9T0qNH0+xx7Io2SKQsV/IlHFNOQ3?=
 =?us-ascii?Q?YGybpoHGgbQyHwOlZf/BQQM5amROCLIAiYkWeff4iDl+Gtmo40TJhfWgij0i?=
 =?us-ascii?Q?d18J5wdp/1FtK8gVEndf7OHU902PWPeA0MHw23fUn7ZaKMOG1kJBNxAV0LhX?=
 =?us-ascii?Q?pM0fWHKYLKLIFVLQFrRxFo6gDSI31bLBcR5yWKMSeqXs7hAG4VF7KT2MxgET?=
 =?us-ascii?Q?V46YBU6neMMv4rsGf24VcDD6EFJu/hviNQyjQnQuoh7bDFSalfSZF91cYzsp?=
 =?us-ascii?Q?Zjp7QHfyunQQU2p+g4kAE7P41vVOhF4Df+cWpmgO+Z0KEABk3c6EtD+aJZbd?=
 =?us-ascii?Q?GbNm/7RgQgVjiCPajCTawEeXvxv7wvPbFnNb4T0mO1UjHvAcpY6Xi4XdOtEc?=
 =?us-ascii?Q?LMqefOSHg1cEaHrnKKdAb6EzA8IeDeniSnp7T4LTZswEQPFxlZT+rwe0K/O4?=
 =?us-ascii?Q?DgzywxzioA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba9bfad-8bf7-4775-4fba-08de8042426b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:18:40.5906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHIN/qC1ar+ZR3xcmEK874oVeAWPC2Y77ISziXOBKAuB1i9I9h/3zTbhoPoPXrVIVOFeQgyb6SFPKrwPHvqhaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7436
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
	TAGGED_FROM(0.00)[bounces-267089-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,ethtool_rmon.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16A4327338D
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
---
Changes in v2:
- patch is new

 tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index 417627e7a592..636429018b6b 100755
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


