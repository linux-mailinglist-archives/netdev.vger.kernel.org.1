Return-Path: <netdev+bounces-303466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id olKMJYamRGrIyQoAu9opvQ
	(envelope-from <netdev+bounces-303466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 07:32:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D62AD6E9D98
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 07:32:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=huaBOJk4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303466-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303466-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E0DA3024176
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 05:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4D8241686;
	Wed,  1 Jul 2026 05:32:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011071.outbound.protection.outlook.com [40.93.194.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9532EB0F
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 05:32:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782883971; cv=fail; b=E6HI4hoKR2R2x/SWrGxWtkWGZ89/If2greToYc3W81n+mzooXXYrmlxZS/mgJi/NvoTMZvgL0AamYBbfDBTYj8Ar8hv8ZxzSMriBnnVH3wBeeOXKVtHksnW9pDNC5CXcTH3OiCsX7sjg57SNYvqIyeBANWRKJprH0wzzpJu84d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782883971; c=relaxed/simple;
	bh=L6BWpjko38uJ6kE/H3uONrDHrmr2qXZ1y1luNPSc7iw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MpwW9nXDwqCalvsN81QHE2sX5TXZ+NY2RZojO9aE4BwViBx88Jqv3EePOA+29IcrIMI7slCYJSEktsOxkrhiJEX+HcyEOakJAQYuehn81BYicor10BmSg76NrX7Pu5UVa+arRPCtPOczsg2gICbZTE5pU6uURH0FgNbbc2XQcpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=huaBOJk4; arc=fail smtp.client-ip=40.93.194.71
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFT2cqBQdGLgAEYFVkaEifaJfRgHhkZX5PZuWNMp7k52MT2zLEV5rnp7MLaHU43ZGleq/LzP64eRp8fH7WEHU6KoSVo5wQtapecsCewSlhJl5xdQcPADybKy5r1eLP4JKrtrdw3Nig1M0m4AyfJ+BCWFwEVi1+c4lDUa7bQxx9P0uGy2gs22inkgZiIfP5i86XL2thfdgBMavsrsRz7Z/sqhvMNDKzgSCqhEDZ8o8YXqdXQ/W/P2OXI2ORrOyuBbLvC3ajPuFmjlbxwa9uLvBk1gSEQsq9/z/pQB2PB46zLF9suCmxtC6LEY7Ftf7AUqq8vJt2BkSO5cyES3j5B9OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoZsTNL5KtpInVNQMxoj4qhQlsNqVrbiGVWAQ5OjIXQ=;
 b=iVJoAtGFBvlGfcgB/fZ85Oc68w04/4c/rbJiipXad7Kg2Ye8lOng+VSLlFQOZaEqnxUFFGwXe1l6LgTJ9aBvfrRBQBZnsiZ2OjCk8s7dAUxjJa94AxxNBrIBpd56B4Ihykf3zfjJVvIfiCne6xqyBemBPN/yOcfgm1ofD2meWahaXWPkbJXerZH8TJEQbCXDJXbwxK0BvpTXVGZ7i5YbwkdXqv5xCVkj7Zptfia44iSmsAtmmGU5Uhg8CXdQqHgqbzD/lKTDUm/cR+AZiqxt5d3go502CMFLoSMJlzXYzUsaSHkTQRW7OaCsqdeRRHbldJLjcOK8pz7OlJksNZ3sMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoZsTNL5KtpInVNQMxoj4qhQlsNqVrbiGVWAQ5OjIXQ=;
 b=huaBOJk4XDQV+kFuSDIlR5oZFDTic4WUn8VLTMoMP83vdSatTdsrPvIlMtwn0Bs6s2dJFvKGocGWgDDdgX9Gg1mI/4x+vvcGlfWRws/EtwzzOBfA1z8/PAHrfq/NAHwCz6Mcr3blSMvH8Bsq6bKpxPWFFhKBIaLDD462V3gjSF1ipq+zLzYPZLVR3np+pUPZd97dOgmobiYYcSuN/OlAe/5SoXVJKR+Qh9ryg+K9RCg0Gh/39zX7668jvUFWEQrAgRLxVxG33m9mPnF7wqw4yyAQUaaEB7KEypY32MPhx9OFLEPYXhy1Xggf4CVW0gb9fNEP3RYwTfFQWQe/jtYRIw==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by SA3PR03MB8232.namprd03.prod.outlook.com (2603:10b6:806:45e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 05:32:47 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 05:32:46 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org,
	kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com
Subject: [PATCH] net: stmmac: recalibrate CBS idle slope when EST is enabled
Date: Tue, 30 Jun 2026 22:32:44 -0700
Message-ID: <20260701053244.17172-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|SA3PR03MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f040413-f4f0-4edd-f4cc-08ded7322e64
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|5023799004|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	yu7Onseq4wqdNBJ1ayjH/pFkl5K9VBsH16qYJuZftN2c+SNM15dOidFR/wGUuscvPiUBm5CpJjcz2IfCKgzTF4WppoG1QS1Vz6qCx1pgPqpzpTGDd/MMtTwp2uMwNb0nRgzxXNgIpNNrRFL4lDolgM9ImZVTdAVQasINUzEBODvs2LKe6ZfNrhBWeiQVrKKKsLPPqMLWJCRQsSfBwjY+DuyVp7fUQF4gT1QE6Lro0VTeqrnQ7W7i/LNgeQme5TKa7/45DO1n1xt6+qq4DX/2dp9Rmh/j+rXHolCHBLIQ0sxLV0xVYkN0/gQxllSKqeXsbKBjNC8q0LCWmynJgZCgleeWXRWbLiXiLpTJ799ZC6tHKGubqPTXLwYiioCRQ8u7wygCGshtaq95TO9xVXtU0IaNCXt3+1OQ/zGsxsB61DZPpHaf5sjOqhoSlSLMttPTdte1+KDZ+4mi5jhmUydddvl+hlWZn2NcLHNy5auVYQ/fSrouLUKJH4o1pTVdkA/6PmTpa0k75PhaQdsaxM/OGSy8SIdZA/1H5QVsNKRCRIx+HBY23+bNA+kuxSe4EYGZBESx4+shAOWZ6JKGajJFD3UPyCdBM+TrabIbgStmmm0Z3IyUz/Dt6PP7PaMZRP/fvue54IeVS7ssfL/CXUwQ1yNAOqCT9oI+5BeG9XGixUc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(5023799004)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UG3F+pU+rlFwMKoUWASy3u4WoGOymwfdtXR3ClEyJNKhhMci7YAv1gv3uRan?=
 =?us-ascii?Q?6ZiVoVnlAFyrh+y1oEXAdu2X+TAbERRGRf533KgayOVJsHja8R8q4RAigyAJ?=
 =?us-ascii?Q?ro6dt5lIzTjqWYXPNW/FQz07lsXniK32YSJcWYyWz24So6IvVMTE9mfN32ZR?=
 =?us-ascii?Q?U2hL5f61DZyJbDUP7bG+fXjXRNMxC9U/e+hZ9yfCjbUOFpMfDRlWfJmds4uQ?=
 =?us-ascii?Q?wHkHCJ588CzzsDF7wGk5FjfxgVbJFRUMq7lB8p6gnokxSfNedNtWn/xZY39q?=
 =?us-ascii?Q?/+BHPIxeK53Ljk7wIAxfIv80bQRQ0bwMOHdWDztaEum59SeuZgNfWO0mAQxL?=
 =?us-ascii?Q?PpyEfQKcaxrPdvb0fzIcJR2YwMAMU9b2vuzXvli1OyFDgEt/qcSsF1XtF+ZD?=
 =?us-ascii?Q?L6MyE27cUx/83bq33d53OnR81HX7p6VEQDDwoFnRz+7qniEMnip45ly2MRaV?=
 =?us-ascii?Q?ilv5qFBbJ0XRmMWZfeebKQzrvaU8JdzsKqa8rY8m4cb+TfkD78L/WL+XUxR7?=
 =?us-ascii?Q?YT8Dv8Y8e7/cAsuRTAif0b1GNZCfgMN49dTzMlLDqP2vkLXJqoMHDtR5QLyb?=
 =?us-ascii?Q?GqqZjGwDPHkdK3aSFH3ESN/Uut5qnkRjbT0vY24JHZCt+Ic2KE/EaL8jQ1IT?=
 =?us-ascii?Q?xV8ZANELJKxzz8dcXlDj6D6y0M2HZrr1p21O/IZywH3WlflBd+DioBPxx7SA?=
 =?us-ascii?Q?rCVtpl74nOYnwAVEiEPzWp4/U/YBJu1rNiH30k9hn0H7rj/5E3bbi2c77zEL?=
 =?us-ascii?Q?KbaQuTO9uDjsjlsH3NMyJzAUh98ynlANCeDklLJWOWJt70gCmqWKQL6CaJ78?=
 =?us-ascii?Q?3w+nrQJYnH/F72WXnXO3/kJjBumDEMQyzQzJKXkRPUoiWiqCtcILD4bV5x40?=
 =?us-ascii?Q?gc73FQwYNkqUXhhrsU8it2wiXKjIGU/ynnUuVYvk9C7G2mIxV2FrogTOUiGr?=
 =?us-ascii?Q?BkPaRGT3r7SC4iPS5l+ziNBHLN4UZ+vHy0//a8pkQG7k7cYKM621UtX9TSk2?=
 =?us-ascii?Q?In206YMN2v6vLNmwgQO0h80/GZTWcJSXbr5Ou3Wsb8JLzU7+Afyq4ngukDq7?=
 =?us-ascii?Q?9oHXEmofLF+30G6WVjDuwoSAKirURdQK4OP2bUCSZeyN4w5oeul+D+0o87C+?=
 =?us-ascii?Q?uiBwE1d/5fW3LLLHrsRJZdDoOSLg/z224uWVSpOIV6rgB7h1QacKhhOjcWTZ?=
 =?us-ascii?Q?rcuOykXO//75ekwuIjvAfOJfrEI3Q5Z9QCdnqhntt20HEhaZhtAnOIyijkoB?=
 =?us-ascii?Q?oYuIW1VfIBIdVc9WXboYrCTdEcMCgFfFk14kBq2aJ9j1qGnA+q5F+Yoik9rn?=
 =?us-ascii?Q?0qliKOLbpPNcc7nOv7sxk9vcnHSXbCLkd4RTA8BLJKxYlgjvoBIhEw+qQiwb?=
 =?us-ascii?Q?4HHrdFZ26BgODalPsYEfT+AMPMS8UJfY4uhbQThWgJ20CuGJcn+mWHP/J5jG?=
 =?us-ascii?Q?Bj7lzHyvYxJh3RnJxYYYi569gwlS9uT9u4g0gOBopa6KWG54e8SwTo0meoOD?=
 =?us-ascii?Q?qy6CZ4kds9M4F8xxyocwRUeIydzxEVxdXuw/85CHoRCe+P0px2rVpAMbfRxB?=
 =?us-ascii?Q?bnuHkR3dYgXC4DrudNPrWe5KUwh69jMrIyIRBm8ZzBNLpOiecqdwe1oWTf2W?=
 =?us-ascii?Q?6w9UsfOxqFaImP1EaAjh0LpQrpCPGUSfluyyURI3iDbqCShTN1GLJimHhe41?=
 =?us-ascii?Q?IB8zNY/gItM7kVsnUasDDR0sB4lx0FTlISG0DvWI0EVq2LLygp4nBhmLKDrW?=
 =?us-ascii?Q?tOYcBk+GMU9NG2uhjOUxVxeMC4+shLXZda9Zn1Bpca9yn+q7pJmW2PP+79Mm?=
X-MS-Exchange-AntiSpam-MessageData-1: UCPCC+Xa0qpDMw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f040413-f4f0-4edd-f4cc-08ded7322e64
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 05:32:46.6155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1wD2zAf4CRpq8rwWoqUGmSyJX2rpOg2rMQt6zQaf9uPY8UToJgN1h5kr3OSX66Y/Tw3J8L7Vyi/vjqqclUuWCkwQMSdAcJoSjswYGv7lyQnxBjl9QwWQJd9vDOgYb6LYle74VKVeXtb0pnT+ilHfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB8232
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303466-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D62AD6E9D98

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

When both CBS (Credit-Based Shaper) and EST (Enhanced Scheduled
Transmit, IEEE 802.1Qbv) are active simultaneously, the CBS idle slope
configured for a queue must be adjusted to account for the EST gate
duty cycle.

Under normal CBS operation, credit accumulates continuously at the
configured idle slope rate. However, when EST is enabled, credit can
only accumulate while the queue's transmission gate is open. This means
the effective bandwidth delivered by CBS is reduced proportionally to
the fraction of time the gate is open.

To preserve the intended bandwidth allocation, the idle slope must be
scaled up by the ratio of the cycle time to the gate open time:

  idleSlope = operIdleSlope * (cycleTime / gateOpenTime)

Store the time interval (ti_ns) and gate mask for each GCL entry when
configuring EST via tc-taprio, then use these values in tc_setup_cbs to
recalculate the idle slope when EST is active.

If EST is not enabled, the cycle time is zero, or the queue's gate open
time is zero, the idle slope is left unchanged. The recalculated value
is capped at MAX_IDLE_SLOPE_CREDIT to prevent hardware register overflow.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 55 ++++++++++++++++++-
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 8ba8f03e1ce0..8eb73ca6e7e4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -237,6 +237,8 @@ struct stmmac_est {
 	u32 ter;
 	u32 gcl_unaligned[EST_GCL];
 	u32 gcl[EST_GCL];
+	u32 ti_ns[EST_GCL];
+	u32 gates[EST_GCL];
 	u32 gcl_size;
 	u32 max_sdu[MTL_MAX_TX_QUEUES];
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index d78652718599..1215946e49cb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -11,6 +11,8 @@
 #include "dwmac5.h"
 #include "stmmac.h"
 
+#define MAX_IDLE_SLOPE_CREDIT 0x1FFFFF
+
 static void tc_fill_all_pass_entry(struct stmmac_tc_entry *entry)
 {
 	memset(entry, 0, sizeof(*entry));
@@ -332,13 +334,14 @@ static int tc_init(struct stmmac_priv *priv)
 static int tc_setup_cbs(struct stmmac_priv *priv,
 			struct tc_cbs_qopt_offload *qopt)
 {
+	u64 value, scaling = 0, cycle_time_ns = 0, open_time = 0, tti_ns = 0;
 	u32 tx_queues_count = priv->plat->tx_queues_to_use;
+	u32 gate = 0x1 << qopt->queue;
 	s64 port_transmit_rate_kbps;
 	u32 queue = qopt->queue;
+	u32 ptr, idle_slope;
 	u32 mode_to_use;
-	u64 value;
-	u32 ptr;
-	int ret;
+	int ret, row;
 
 	/* Queue 0 is not AVB capable */
 	if (queue <= 0 || queue >= tx_queues_count)
@@ -402,6 +405,50 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	value = qopt->locredit * 1024ll * 8;
 	priv->plat->tx_queues_cfg[queue].low_credit = value & GENMASK(31, 0);
 
+	/* If EST is not enabled, no need to recalibrate idle slope */
+	if (!priv->est)
+		goto config_cbs;
+	if (!priv->est->enable)
+		goto config_cbs;
+
+	cycle_time_ns = (priv->est->ctr[1] * NSEC_PER_SEC) +
+			 priv->est->ctr[0];
+	if (!cycle_time_ns)
+		goto config_cbs;
+
+	/* Sum the gate open time for this queue across all GCL entries. Entries
+	 * beyond the cycle time are truncated. Any remaining cycle time after
+	 * the last GCL entry is treated as gate-open (implicit open).
+	 */
+	for (row = 0; row < priv->est->gcl_size; row++) {
+		tti_ns += priv->est->ti_ns[row];
+		if (priv->est->gates[row] & gate)
+			open_time += priv->est->ti_ns[row];
+		if (tti_ns > cycle_time_ns) {
+			if (priv->est->gates[row] & gate)
+				open_time -= tti_ns - cycle_time_ns;
+			break;
+		}
+	}
+	if (tti_ns < cycle_time_ns)
+		open_time += cycle_time_ns - tti_ns;
+	if (!open_time)
+		goto config_cbs;
+
+	/* When EST is active, credit accumulates only when the gate is open,
+	 * so scale up the idle slope by the duty cycle:
+	 * idleSlope = operIdleSlope * (cycleTime / gateOpenTime)
+	 */
+	scaling = cycle_time_ns;
+	do_div(scaling, open_time);
+	idle_slope = priv->plat->tx_queues_cfg[queue].idle_slope;
+	idle_slope *= scaling;
+	if (idle_slope > MAX_IDLE_SLOPE_CREDIT)
+		idle_slope = MAX_IDLE_SLOPE_CREDIT;
+
+	priv->plat->tx_queues_cfg[queue].idle_slope = idle_slope;
+
+config_cbs:
 	ret = stmmac_config_cbs(priv, priv->hw,
 				priv->plat->tx_queues_cfg[queue].send_slope,
 				priv->plat->tx_queues_cfg[queue].idle_slope,
@@ -1031,6 +1078,8 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		}
 
 		priv->est->gcl[i] = delta_ns | (gates << wid);
+		priv->est->ti_ns[i] = delta_ns;
+		priv->est->gates[i] = gates;
 	}
 
 	mutex_lock(&priv->est_lock);
-- 
2.43.7


