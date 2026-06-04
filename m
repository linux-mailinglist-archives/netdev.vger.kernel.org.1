Return-Path: <netdev+bounces-295104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CRzsESw6IWq7BQEAu9opvQ
	(envelope-from <netdev+bounces-295104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:41:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB3063E119
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:41:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=EUxnrGrB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295104-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295104-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56535300F958
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3873AE183;
	Thu,  4 Jun 2026 08:33:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010020.outbound.protection.outlook.com [40.93.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECD53A1CFE;
	Thu,  4 Jun 2026 08:33:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562035; cv=fail; b=Ta1RdYaEH1FjO9oAxbukvfHSI2uL7epiuJIWadJLB8kfTliffbo8WV4kwrnHl2QqqOb8BJIvV8swFmR+yOg2JswkidjYzVerklSCSwMeeh/6UNiVKhwl7uCVMJQOYPQGjTD6lfrDGKzDPaSiEAkfUhKwa9X0I16iQruYhdKF6pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562035; c=relaxed/simple;
	bh=/VstURGDaPDuoEFwxsy57dn07cJGvz2w3JDjkIHuDlo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Cza9k1srxu2/h8Gv3WOwxRPvpMFcPUEJPt+wvVDkTY89XUcfhAzwKwxQFwUYZSHqPks7WwiB5Ebb0dkfUGrf97QwWJSkkYL/vNeeojfadSFXPgsyz8Km/398G5IN2PPeLlZyVPOYfZ56NWwmYbTyTs/4OEyGWpxqF/s7/s0ntTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=EUxnrGrB; arc=fail smtp.client-ip=40.93.198.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyPIST+4HWnpIwSFVLGpFIWFdp7plWPPNrDGdNlV6Tf4a/kUAwo7Ainq4n2J2Vcime/e9NcPoX+vqN2eIyuM+pcSp6hlShZYsjjnMzL5rkDCzIMzhJx1a7Pi2fNeTQM7MwnZMtYzEOjjQq4ilaeTA6ZhjR62q9ghvaNO/ChR9i1KN4odqPnYQuv4o9nMn/vG2ppoVC3vRyBXGCuTbk9Bh7qe4gn3fsK+dDmapxksa3VtvDutTiXaiIS8fOI1lpEh+pgAZazH7Ce6R4xU+yT9+7/Ee+Yo/7gjwyX3lUdCVeY272cm+uVc1aWv97NXysWvdHceYj/9+BZI+my217VAjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJ+Q9ZXE8rsenAUMlFOvZe+MZzstbRjW2Tgn7PEEKgI=;
 b=foYzCrwjszN4bVXZ6Drn9y2iXsHkCasJNdvU96eSVb1fdI76998Ibooura1tXkH3ONoCsTdH2htQMrmPQhrGw6DHTBtAP06YOydW6VenxEGLGESVjDCJnrKQ+am2foFucoQ58FqzYiVxBlR2OSRSLyicGPJ7/JFyMI1DFiY+/22P4B81tHr7eKgYvMDd8y5eiakox99lgj9KeLX4pkbb+j0ce0iMWnZljBkcBughaIP57XcxZ4vzIwFxLAeVVum2brkqmsZLe3UXgCIvCt/JXqpT6eMAEH0zVUSQoBsbr+EwaIhMaR3gj9FkEpsXiq/96Op9GLd6BdTYsq6BO1ouSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJ+Q9ZXE8rsenAUMlFOvZe+MZzstbRjW2Tgn7PEEKgI=;
 b=EUxnrGrBvPJBDbF9ho58WFUbSRKfPKHbQszo3CcllzFn8EhBd6tad1V2A8Pd/DPux8Vt/wrcAkJrHVxspI5yGH6dclF7eClzpi6PN2s8guqn3sTxDvukyg4beXTfrFW4bagHVzH5SD2JqJcSitCKRyS4IQ0AUr7RwaUGQIXh/SfS54PadDvhGQCMjXlfJfEJcESfK5Uo3GQWS+vbMTQRNp4TUwzUtxw2yv0MSQ3zmvInfJ46bgrX65vuiFEK4uvuBQCaAKk6HCX0XpYWdygI4RY94AFPnVQ3BXAfac5nMhi9fEP4BwcTAc+XA441khH4meVe3+K7dsHAEW0JAkkLyA==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB5941.namprd03.prod.outlook.com (2603:10b6:510:34::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 08:33:52 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 08:33:52 +0000
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
Date: Thu,  4 Jun 2026 01:33:46 -0700
Message-ID: <20260604083350.1701-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH0PR03MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6bebde-3016-4e31-60d6-08dec21401e5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|6133799003|3023799007|18002099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	YEmb8bIbkkvVtMReOiN7saJcmie25E6Bzkktc3Zbxk+kUQ9a1bIstF7oVJCzjLdHG+TAcoyhqmwraiZbDUjnU24kNDzZvKcJgBeShJ7aNwDHyji9q3pvx4IFjkb/hPHDmQQyS5R5arvNKz4z0BhtFo72+KCL3UbiNq8g+SN2w7ryxGDXmQ6pWHykA3/P1YHehrdU1DcWwwLSvpQILJnua+k5giCYEFO7ixV8ZT2bTbRUzoa9iRylzLciP8Z/VS6tDoBn1FXhl98W7/x0Ic1fkrwDqjPlfwQXVYuDt44qGsPnGGca9HJFuhbG5VBVDlbws2PmnOQg7mctYO9rUEiaMTidjF6afz56H0ioLNB1A42xH8CtntjQbC5RlsVTAmqznzZhBU/BSkn//ewP0jEr+/gVDd2Fs6CuqJt/2FfCeZAQBlJocMZbfwzKa5YH/lgJlcZNqiUTyK4dF/73t8CFhXu9Etk3e7trynUI3WeGUTiEtuLisRs2uacGzR6dll8s2m80js1W9AY21G5lyzn9BujPW5eXogiWdaMw6mDAFgT4NxFRQXMD8vUmehWFGyOIupVwD00ZfISomz/ZldhEuS4Z1zT8J15rUVXLORI1dqN2HlOiG0Ufc7XGTIHGJGg84Oe8TlCVQl9TzlHzEwpZ7fu1l5P67bEAd3P0Ykm6//NGo3mB28u3V7EWlt3yJE5N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(6133799003)(3023799007)(18002099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9NGwHadNQ8Zx3sZe1WAOyviuVB6QSCc/r3KBFhNAZVjpCrxuk8arNrpg99Ep?=
 =?us-ascii?Q?/CGG0q7i7k0o/19QXM9ucjB3SYMfU030GV+CrjI76LaELdzcLx/oVVG/Ussb?=
 =?us-ascii?Q?t5WjEfy0UUAnCFtJKMtAIj9fmlK54WUuW81+m1GPA8r/+mcopeVpGMC2MRWq?=
 =?us-ascii?Q?EQLkpSzHZgBMtBXgzTb6v1iWFIDWr7gYWed2uoNLGVjKSLLe5M67yh1/tofl?=
 =?us-ascii?Q?TcYvDn7j5I0MeLk67PK+F2mKg/W5xGWSaX5OJ8dOtuqR6cCwksn4KJ9j6N5f?=
 =?us-ascii?Q?FHSTdp938jOVSjbOU1VvgnwJ+JMnbuVhiTlqoEDZNd1uYIvbg4tgG4qGuDM4?=
 =?us-ascii?Q?qRrLiyEE27WJobr6Eq6sOqQmxpAUfVtEYtC3lDxwTy/XG75LI78/M6Zt242l?=
 =?us-ascii?Q?KvpwOIWS958XTcGjHqy5O8mU54kI5G3GDztRRvbxWKSIMi30Xq9Kf42erl7x?=
 =?us-ascii?Q?l6WkeRwtyXMmaEwkG7ay80yijIjWFmhCSusNEHOw4GAzbdfrTRcfZ1cTSlC3?=
 =?us-ascii?Q?x+k6mkt4L9CtJ+XzmRb2qmecf7p1I9TUFqNtHXNdL9Npplx5VEqsz6oWnCFq?=
 =?us-ascii?Q?zULxWE8U+tUPBs/cgLhSsJTzw2MZvhSHJpWscHlaSop9woTXxCppmzdUsXjo?=
 =?us-ascii?Q?sHLiSfHl8toMgMVi6M3vQhRgOpV0COqJMy7h35otMaAiEg+JMeopDgefkwne?=
 =?us-ascii?Q?MUPV5mm2lb3LLq756q9Hm1bCVDdQfmZn49tqjHft8kUbPxXSRBgi9jus4hsK?=
 =?us-ascii?Q?dauXfDVHC0mIxN8RPa03upbiFLr7pjaO8CBLq1llGhsbNeFnFW9jyMqKMRj7?=
 =?us-ascii?Q?FnEs/xLn8xsdDmLj5uv1RLB7aaIEhMHb3PQro08TKnpLrxnkex1RjqPlwaxf?=
 =?us-ascii?Q?5Q1WmoZtKhH3AfEwUFB/TDUyyVDLcXZ18HNh1oUxO8DM7ZtBK8J/TZVQuv7J?=
 =?us-ascii?Q?YkH1Wk6FrGZJtCBv0dUxe171CheyrhubVEGaixRNcwykA4L5OTVTrC4j0KQp?=
 =?us-ascii?Q?pt2PS3W6rYvdaVy0H0wmYUDf4jiBLjXlvaLzbRPy14f1e7lLx2yiAM2JbP90?=
 =?us-ascii?Q?nEBgtz+nsJQZXFg8CoWTwr6v1RRri8KlO2NwqXv++mbKaorxJWqeXUdMwyZD?=
 =?us-ascii?Q?FhzVOalo3C9keBjpqiKF6fzhLD9CXVvOBVE3ZYJ9eEUoD6317ZGaEmAEk5Dv?=
 =?us-ascii?Q?/GNc+DGgzEkhCDxCHm4Ey/de4vbJi880A87ZjmKy4nLcAzGv7xeWHP3jQ8KG?=
 =?us-ascii?Q?wVKZIHE9FGO1jFy6OBBue31ZUTm/co6VoUiszesP1fULHryeF0cPbieSpVtl?=
 =?us-ascii?Q?TGFXyveVaJbDD7sEUMN9T9Ieku5/+BsvEMZZ28uHppBWGtDcb8CDAB7YyqEG?=
 =?us-ascii?Q?S8SVCWdwOVxZg8w4dxjeBvQnsETl3AtqLppE+zA991ZiTmX/GpvKziUn396Z?=
 =?us-ascii?Q?kElplG06/Fihqop81FshZSzTwCok1Sw1dhvIzi2WDmCFSFdw8XYm5PX3dnXZ?=
 =?us-ascii?Q?nL2Q177NmeKXlG98smsFwWaT2wZ4mmr2GUZm4necXth8tAKIkWBIk72pAv9Y?=
 =?us-ascii?Q?GtW2ni/rYQul8kNl3ipcTz5WPbSIj1N99bEpnzIwGVPILj5ipYK/jXWH5SmA?=
 =?us-ascii?Q?fMgbNKkxoEE2Nbv99RJgVTFzgAHm3An5Dzkx+/+mkOcOTQND6C6AbcJcNPaD?=
 =?us-ascii?Q?vdwILgW8auBZkLPAUlfAaX+9/NpcJTJ6+R2dnr69nwY5H3IVu5h9QPbF3G+D?=
 =?us-ascii?Q?eKnvL/O/S5PmkgYbuSMfZ3OOFT7KKpCbNJUDn052x0HywhUfSO+qFBrb0t4t?=
X-MS-Exchange-AntiSpam-MessageData-1: JmEfHr015kZ7jA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6bebde-3016-4e31-60d6-08dec21401e5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 08:33:52.1935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pk4VxmrnjxZbIPgPz6sDg61EELTKMJYD0aaN4fiB1RtHt28qCIaXdDHbG9xNvsq0ds+4RAVC1C2ODkKhyOLTxE4LVmoeVDcWT7eNbKlKJDXd2DSZqTBmDtZk8VVEvv9zW17PuSWQVtLD/XNCjDLASA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5941
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295104-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,altera.com:mid,altera.com:dkim,altera.com:from_mime,altera.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACB3063E119

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


