Return-Path: <netdev+bounces-294646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n7eOMqfaH2q2rAAAu9opvQ
	(envelope-from <netdev+bounces-294646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:41:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 293CE63551C
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:41:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=rAR7jyg2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294646-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294646-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0244231B8722
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D4C40FDAD;
	Wed,  3 Jun 2026 07:29:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBC440962E;
	Wed,  3 Jun 2026 07:29:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471784; cv=fail; b=N2qqCa/qgAYVaoFFVrcwH6wHXaGXHA7GTVFPyPwFcJfeQsywKuiwFkyRP167xPuYd+Zgyvg1nm4maM4GLBx4q/JsUwkWkLKzNGc20Hn8ThkRWpb/MOsCPxXyuRTkgcmZTglfVjlmqv79HaepK+FifPAt1V92i4hE64qgDpgbMso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471784; c=relaxed/simple;
	bh=/VstURGDaPDuoEFwxsy57dn07cJGvz2w3JDjkIHuDlo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YThCAK4p2Jyt/VIe5mfzrFNSqReeRsdXlyr4OaFYHeQj+yWQ9qMean1AKbKBcWrY1c5m+Bbtrv54rwNsA1QlBfcaasOUG20ORvVDl1CMBCe0P1kiPOnB6R97UPob0bR9m+Rd3i2sRa/oHXbkFCyc2pBHNLrqMsmQ7x3g8yRm5vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=rAR7jyg2; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Osaao7boixs3GpeXjccQho21V/fT9Z4Ryv0UI7ThjLW7b0LAH11uQSm+c71h0tIj1tPfELn7ttejdLHyoTJX244Ye7W7mH5AAzyYr/mbwILvwZmfSLPFgZVeVcLtIz6TaThmPRc9GABtOxczjhtrr2teTw1P5lQNTEde2slqGmPbJTaHBh+O2jCWIomVSWYHX6Y5nZAgsEPIBQNnQN+dDy/O+gwPTNV4/EVvXxxzRwG8zmgTVq1Rp34+qN4Cotknu+oS93B5VSTLboMZXYM5/iEoj+OB/3nKcjewqvBUTEzpkThtjesRVSpRVZRCrj8x+Sj/El2kBxYDEswy+tSs8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJ+Q9ZXE8rsenAUMlFOvZe+MZzstbRjW2Tgn7PEEKgI=;
 b=CcbenMII1qhQgPV0KE+bnywMZSQNVC3MkWqFklTZLZDuZSkGX6ih919iL5KIUfdfMKdU8ARWdvx9oevfzBEtsQ40UmMWwWLMBIw9ilK0YkAGsHzqe7ETmz2O2NmPRenL5bBKSaZMpomLCNq8f4wTSJyDIRHAKecerjZH8qXBSAGzBzEXYCdTSTK2/GS/eK4n0iO8p5Ul7bTe9l7oxsErgCDn+C0IYsmqdIVTAcP1xbW71UFpe2S46z/deWZtUjACKNr0lZhhKn/MB2lIbTRTraFsCve4Y2gDso4QU5o6+NHYfL8IE3prermkI4HD4CEBct2R4XjhvCAeQPijk0Q7xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJ+Q9ZXE8rsenAUMlFOvZe+MZzstbRjW2Tgn7PEEKgI=;
 b=rAR7jyg2HlWH3hXfWbKWfjs3Vhtb25g2FFOkgS2txwlb/rulVhkvPMeuhQ/orHyfY+IV6/pawn3HKuxH3UCRK5TZHoCfxhiENmyTFzHMwLHQGKTwCO5i5+n0i3ZzVaMXwAOWvQe4PcTdphD23zGgriqs7EIl0fBmyvIEgg+VE7Vdkcp+aIh1/GuWWKyrupm8IJKeVSMvD1OT5+o1nguGHd2JG48jPhIKGtpJDG/H+AoqfAbinV9rLsNl9i8PuRNHIIgjrp2QUzTcSREzgT21tA+4lJklIc4zhRKwbAk58JAkYLXHk/zXtimwxOqvozOSXaDCp/DbZArB+r1kIpu9WQ==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB5813.namprd03.prod.outlook.com (2603:10b6:510:35::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Wed, 3 Jun 2026
 07:29:27 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 07:29:27 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	Jose.Abreu@synopsys.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] net: stmmac: L3/L4 filter fixes and improvements
Date: Wed,  3 Jun 2026 00:29:21 -0700
Message-ID: <20260603072925.27890-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::22) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH0PR03MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 0411bfbb-d634-43ec-2a42-08dec141d7c9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|6133799003|11063799006|3023799007|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	KTI4AQabERkDFJ4eHYJTLJZzz41XfwhPHe5wtJKaFgY+Q1DS1wteWSkzqiRDMhLo+zEQdlE1rVg3heuBF0ve1HrX/g73Vc6Rl6hqe+iJH2oIbS1WzdVusEzP8h+fXDbrfZkIYIAIJjSu9MPXwGSivsmHsumaYUCML6Ay8/GaaDrAeuKZkZZMMBLcEaK/SGKbPwyimeb6v1D3EQxaVo2Ro7D+D83aOAgRNsmv78btpnjYVpPlAMRRmXUrBJ9f7fQ7T52DhSB3JSrdNVLfnY1gz5rCFGwOO6ya/ZTmQBCdZhO0IkwYjUAn53KCh1vpiWUnb0KwoEf1bUEY4mPKjrkUD0WvLx02PIPnmiIAun7jeA7ZyB92J5Yva7A2X3Fy/+tGTzP8eKST6WHVXMU2/OapNMX57lz3ruQXk9lT28SGcCyVf7vIAHlLrszIC3VgAo5bGEs0Mu4srhEVNVfPJFmWlvU7Hc/P/W0zwhvKoqTgg9vjU5Ywmb8nS+ZqJiwPld+TGXZMwPKQ9C6WNnW7jIEP+OekeFKkfBQHlCU1lE+fdv3rElRGmMcUJ4WodM6LEmadyvDiqEfi7SOHhFqHQiaZSlWN9UL8rdKPRoXxv9HXom6pt7oPegcQOKnPDpVVvjrqACwETh7eHqlmDoTk3rc2R1zv/pZ3Dk9ShdwxdCQJWr4GlrseoW9qsXk/vwMzo86/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(6133799003)(11063799006)(3023799007)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MZwZ8WDG/Q1dG4flB1LEWjV+oAdq8yUbdMS3X1x7viamw1zGEMiFDeyZFffZ?=
 =?us-ascii?Q?ae9We+u7612K1t9qP/Hgpwbb4n9ZKgHiekpmeonEMXXzhkQB/cODqI+iRNA7?=
 =?us-ascii?Q?Sp4//5mH+pR3T69OakpXFR8qeWKFf24ow/n7tgGtO1+PK0eCXv/hmG1FfUnY?=
 =?us-ascii?Q?kicSu+LgjPWhF90cEKYomxO3s0WW3FeD52dwEyDYSQDiqyPeYFCthpuUn4ab?=
 =?us-ascii?Q?vu1Wo9BrIvzW+IP9EkxMc0qHHSySkIp5IbK0A1sLjuwIiSgzapkNZPD1aj9J?=
 =?us-ascii?Q?l6YTKXAaoyloPLzQwnYfBylGZi7O2O+2bvxH+wdhnDKJLX6uqK3aYfcknah3?=
 =?us-ascii?Q?KnWm5dduZjJCukoz/12GWSdLBB5BSu0ozgcO+pkLSWnbefUn5sFVNP1zoXlj?=
 =?us-ascii?Q?fDPcOKQ2bzOV2AGLXVV6SvfwNnKU5qv/f7+18LGx7DI1jP6gP3otRnkArIq+?=
 =?us-ascii?Q?/AmpjcuYPnMLpugrPVC1+2Qc0GaL2zLwLWwUkOdyUMymFI8wsxwd3T5sceRZ?=
 =?us-ascii?Q?rJB8VdgeaWdgtASM2xVID/DPqQGuKQIxGLMD+VagtmvU9b98xCQvfBhpfzRu?=
 =?us-ascii?Q?eCsR2Sl83RqSYzZK+7hCbljKoPT6oMPqvUBJdX9karF80LQ9Wqyyt0tGONIB?=
 =?us-ascii?Q?lcKKDHx9wo2fapjrfSbl0F3rYPMxUwY5r+XYMYEG+A9oWF1uRfPuLJEqxlbA?=
 =?us-ascii?Q?kWh3BE4uZ1VhDx4HkSGp8IRcdanHTJRKTGWggZnAZeMapp19ckaJYxmyMmL3?=
 =?us-ascii?Q?IL4y4bImVO6yXWMs/xR4a0aGTQBgFnTqH2nPEwc0aKBTj7Fm7VzbGozg1kn0?=
 =?us-ascii?Q?PzWwmbkCUXcLzVOduRILHfh+VXu+hlZdPszYCvh97oBdH1xoQU39fD8dPQR3?=
 =?us-ascii?Q?HDZhwNocp3CBcHM9gjzNz+EY+lPpIntniHhyX9mJOdhTryk9/bGUgXk+5A9+?=
 =?us-ascii?Q?UI/G1WsWg0f/yj7VRh9osXN1dsCx66t4v2Iapb4+TlkLwExmx3RVGwDyf4Qw?=
 =?us-ascii?Q?KN8pu5GDFNTcmbARw4dGcN2syEP6Jufk3OLuEjlGwRLN3fDK33hrzDy83gML?=
 =?us-ascii?Q?NQtFZY+EPx/rte2gEtP7+NGrrlTV51Ko58AzB2BmkzycE6S60wqyuB97kNIO?=
 =?us-ascii?Q?ofyDrBKlmkOtool35EZv1CMTZ78w8LCS3sVmIoYYhbblVfxl9arPRXa8DQ8J?=
 =?us-ascii?Q?Z0iRPXrYT73gmatgDmCfuWflSTj9w8ldMt9dK+Kq2OTaZIKgR6W+YQxWeSaQ?=
 =?us-ascii?Q?kDB4r8beoJefc5kKASj0NC6CsQHiseTdu9auUYCIHbq1VIam3JwqoLZU1HGA?=
 =?us-ascii?Q?R497dHEIm2OvE/cBInJv+9GbxchX+CX3jYh5MGZbmtr1V28rlhj2bswaU1Jg?=
 =?us-ascii?Q?8nZedb0Ia2zqoxEd3ddhnHR2jjgLcXEXwpOuVRu9vUeiI/J9FN4AHivq5fQH?=
 =?us-ascii?Q?BWtZHFFOfhZZy6XX5fNY+Pfncl8Jy0HC6+OdIiGGzg6MxRK3kj6WZVTslLDm?=
 =?us-ascii?Q?5t8o2bwgmmhQBpcO+oYeCPMvDi0lTJ+c40xvmf2VnKUbrdvUL493CThIk3AZ?=
 =?us-ascii?Q?DaxcQ3Pe/6OzcpWT51ayL19t0Z76LdBhe0G3eV0+H2LbarRy6Sb08W8BPhzz?=
 =?us-ascii?Q?SPjkeRwB5C3/Sn336vktOxySLUNLhVgi+cbFpWm+VQh0fKQPFW2HvWESPWEP?=
 =?us-ascii?Q?1jCmNEpd1KKrz/iJ/Qd4SjeaAnATSmWKsyftU7gwsIWXbJjRCrPpEjD44cv7?=
 =?us-ascii?Q?gsSOOpSbAn5kJquJdUnVkV6QyC0RgZecxtg5R6KqzqFAIN8r3/Hp0i8K61nB?=
X-MS-Exchange-AntiSpam-MessageData-1: zE0OTol43GiFOg==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0411bfbb-d634-43ec-2a42-08dec141d7c9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:29:27.4089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/grfGW496JY+Jm+VI5tnDIhk68YBzSzLiPWvrWbdtICT1qJ/XmIYu091zhirj2qa0y9EVasBjee3xPjWZwOAG//4Gt31Zmgb0hRzF8p7Ky2zXmXETL13u92Xi3SKQ/zFMYgEkQVadvEKMZqs5f4Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5813
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294646-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,altera.com:mid,altera.com:dkim,altera.com:from_mime,altera.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 293CE63551C

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

This series addresses several issues in the stmmac L3/L4 TC flower filter
implementation for the XGMAC2 core.

Patch 1 fixes a register corruption bug in the L4 filter port configuration.
The XGMAC_L4_ADDR register holds both source and destination port match
values in a single register. The original code overwrites the entire register
when setting either field, silently erasing the other. This is fixed by
using a read-modify-write sequence.

Patch 2 fixes the basic flow match parser to properly reject unsupported
offload requests with -EOPNOTSUPP instead of silently accepting them.
Unsupported cases include partial protocol masks, non-IPv4 network proto,
and non-TCP/UDP transport proto.

Patch 3 fixes a stale action bug on filter deletion. When a filter entry
with a drop action is deleted, the action field was not reset, causing
it to persist and potentially affect subsequent filter configurations.

Patch 4 adds L3/L4 filter match counting to the ethtool statistics by
reading the L3FM and L4FM bits from the RX descriptor status word (RDES2),
allowing users to observe filter hit rates via ethtool -S.

Patches 1-3 all fix the original L3/L4 filter implementation introduced in
425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower").

Nazim Amirul (4):
  net: stmmac: xgmac: fix l4 filter port overwrite on register update
  net: stmmac: fix l3l4 filter rejecting unsupported offload requests
  net: stmmac: reset residual action in L3L4 filters on delete
  net: stmmac: xgmac: report L3/L4 filter match count in ethtool stats

 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 ++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 28 +++++++++++--------
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |  6 ++++
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 27 ++++++++++++++++++
 4 files changed, 51 insertions(+), 12 deletions(-)

-- 
2.43.7


