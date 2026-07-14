Return-Path: <netdev+bounces-307339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d+CGLf2gVWqErAAAu9opvQ
	(envelope-from <netdev+bounces-307339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:37:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C2675066A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:37:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=HIIXpIWj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307339-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307339-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDAED3058733
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAEF37D10A;
	Tue, 14 Jul 2026 02:37:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DC23033E6;
	Tue, 14 Jul 2026 02:37:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996641; cv=fail; b=ixfqfb9KCr96uItDpT2SjXgNivW5NXg9rY5Zd9NOKofL4d7H+hkHXyOkf7mQ5fSaOR5klM9LPHMr+SC5zsJQeLE2p5Q+8i80r67hiAlQcJchLQqlgm+MPjE5LNHqkCbV4c66Ns5y0uQX02MFV4wcYU7IG0f7b9UtzCqzGtrETS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996641; c=relaxed/simple;
	bh=b5tWHjXUojhLYuBfRPl5IkljUzUr0iQjkV8e36kbXqs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SbL3ut1Y6raRmmBpueKW54R81gr+b/nc+cLgX/NF8AAR9hLPp4q5UJHCzkJlEzzI4zVL2CNLoDFwa3PSoxFGlyPF2RzD7PxGCjNgz+xzJA0bYiVJx8olyYcqYGaubF/rEXd6Kqj1g6kqM1c3rhjNAktbPnvB5IevWb1sISG8IKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=HIIXpIWj; arc=fail smtp.client-ip=40.107.209.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QI90JDi0fj80903vqDXQMov3/HjpS/VFqSCxLiOWrOXP2Mp0x9pkTTKF37yyp2PdTgRBg5DmzEu3+cGmg31APV8/eFKWy/WLOC/zcp36CJ9iMQIzoOWD9xnysBBp7kn2oHZVLwel5DER+5mrM3zAW+0QAwCPcNHgshWME1OAkAJhodLFzt/+Sl6CBZkiXMaAABYNpIKR/oUN9iRtHcqfioMx+4xn7pkUORFYLHTpsosaPdBHy4kTzjUpc27i4V5elENUrceMMeZswkSP+55ZJ4UliHeMnRDQR3ZOjxa+kE5oID4aFwVsbcBy+YRdq5iGABTDPMQWt8EbFDsVHsUIIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFO/QBaeaW+UlJXrtAPBhSLnyo5HjPOeQbVTLlJ7cSQ=;
 b=gPQdpDANsvRQoS4qa8ure4M0ashtYxqI3uKDVMiVWvF/Z81nXm/rd89u9htt0SS8SnSC+Yvo4kLVY6gdksQ+OFp802lyvC5p/sLvPxQb/HkFW5cjhAKmDGowHD4AovaRzFbsYQYghj2igsdNkKI/nDXR17QoBNKTjy/TKf52iQKiZWlpBfNBqJPMvjYRQTukHpCf6MNhqdaXUmV2rbO6Z2ieUpOlLq7tFYIUp1Feti+cNYCX8cDRu5g/KsWAXtwXvW5AY5x2cFiK3lr1IPqeiCyTCdRsnbIqu8rGiVpP02MtlsXyktVSu3mIWSSKPxc6fRVKUe0jGXvgbcyIBmL8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFO/QBaeaW+UlJXrtAPBhSLnyo5HjPOeQbVTLlJ7cSQ=;
 b=HIIXpIWjrWq9F8vP839ijCrdWf0pU4VVWpmNQgyOAEPkH+s5QiW6H4Dm+3S0tyRQH9needXj+MuYnlz/NGu0dG988mioluT3Wd+/uuVMGHRECPAL14iQtmt5v0ry2xSdbEflLtduPX/m3sMuFJegiybveXQnti3vv4RMnc00RuTbhnAupe4cgF7MTVBli04XgRq99ZoBa8qgdce4iH+YF5dWObMZ2gFvq7DeMVwZJyKabWo8UH20SnscZ7GUoI3yT90HoVsR35HGaM/NJKEonb+1tJyoZLQ6zYZK0utEJ6Xq/KX1FW7n3Gx5rifUrvXnjCPMEk78pOaQ4X/KTJQcqw==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DM4PR03MB6032.namprd03.prod.outlook.com (2603:10b6:5:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 02:37:17 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 02:37:17 +0000
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
Subject: [PATCH net v3 0/3] net: stmmac: L3/L4 filter bug fixes
Date: Mon, 13 Jul 2026 19:37:12 -0700
Message-ID: <20260714023716.29865-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0116.namprd05.prod.outlook.com
 (2603:10b6:a03:334::31) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|DM4PR03MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: a34ff52b-73ea-40de-5abe-08dee150d215
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|56012099006|11063799006|18002099003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	M7Oml1zBiMMtgHtuMut4Gt1CjgXjQGvZLKRM+UJmtgyU+rPszhk2EWYbVlSlthz+Afw6xlwwBRNGJ7aqHogYFoezx9tjcZepP1hNs+rmB2mBLx1rfGmPSF0JCniJOuU+VlHZAgcKkrT7p3IUl+y0EoRmnVL+gW9Lwfycq59mH3rVffDf7NNbztKpMDGm13wklvVIsNWs9TMF2T+7FurjChxDYolhQZ/vtncD0hSRxxiwEio2HDMNnp6HZNtG4dj0PyGhCLDgTfJxagQ9BjB6uEB2pFvTCJfUNimS7kJWTswSA6omZwUm8EaWn0z7DaIykC54Hgr4dGU0JXf8yV/4hfLiiaAnl/hMcjXS2EP6c0d870Eo23GYeyEe4MJO9yu+RDqC6LDS4lwANuCguL2/4aW+gEAwPgSB2jgrUKpgiofpOhuKgkwmj7UNYjriu31sSAru7aPWcy+AeczSfpV1H1lCsDvoz3kNMAPK17/XLpUcXFR4+uQeMaXh2X/J75hda+T3zxG5RaCgUeKfirZoBfMAyagu0MUHufzo5tB/HRSmr6StOwRzdShXrQoIF3emzhc6n5zlsMymUpXKIlTy8bfhlbLf1focTNYBYtV9OEyQrotw28pqNGfTd7bBoeSxj+Aw11qkGf9yg02iUflPZ9y6yBj9sdWrQEukKkrZex4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(18002099003)(55112099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hlCiOfkjk9ilDsZ/hbIDzAg4VqqD91umXOkEvN/+wRH518NAQZl6KnPKsNVT?=
 =?us-ascii?Q?FxJ9r2OQ3pA/br5IFEQttANjwAauSa4CgXWVyl90mOpRFRKRL/JAVsSynLBC?=
 =?us-ascii?Q?f1faizQ0/OL7BhgEMMNhJXMBsgO/Nu4DlyVhtMApGX2caE3BCvh+HkDxfiJu?=
 =?us-ascii?Q?OjREqtq27vGtD/VDq63pdvCym1VAw4scL+Tn7C3rMflMhYz6IlrNqKfU0Bsy?=
 =?us-ascii?Q?EkMtCyOwxOjoRUUyRBP+AeLmgxsn6HN/es9oGPkR9FtjxgqZlELWB7Ub1xBd?=
 =?us-ascii?Q?0NuvrP0cAq3Ei0HIDW/rN5QeefLaGMbieiEOBAjq8Wqn83Fu4kOm2mefxKix?=
 =?us-ascii?Q?lqe3kNaMy4/zUqUx0XAXvL/4xDbgkSJqWPHVsVq02vefNHEhYdRBWqlGnFGx?=
 =?us-ascii?Q?VDrwCdwE4C1/pMFHyopoNzirGJmkD5989/JNjRN2QD6dcsFsgvGsc8gx9siA?=
 =?us-ascii?Q?+x7MBWnS41PDfJcGYa16O+851/C325IBQYIJMMKYputqNwQ3yyNN3yRmQ9+p?=
 =?us-ascii?Q?+N1gCVkfeK6TPqqBMr/SLV8gyfpzYYOqKzGUMuiD4Pzv/lrDeTGnPOYTN3Q2?=
 =?us-ascii?Q?SgNq7ogk7WdKyrs+de+Qdq5OQ3QdKpTa447BC6voJZADq/7zfyP2CIN3zRdC?=
 =?us-ascii?Q?dGSn/2goTyKs+gLRW+5Dwhi5f8ua/Lu/5wq2BIkzV7CCrg53+jJRKIu8M/Eo?=
 =?us-ascii?Q?WyRte4BERBEb7x9R0SElWe9EaE2IXqON2vkpEi0c+pJk6tnkcrh7WYwXZ2Rt?=
 =?us-ascii?Q?PpInSMddIb0dj7fey/AY13R7zJ5DoWm0Sz0lYGfpjgJkYKgd9lrJLEZ67qrp?=
 =?us-ascii?Q?1OSjcwE9G9zRcEOiuiFpTNw6Vn2JTzCuvrsiHJA64eTP5UrsH8kK2ktttSW8?=
 =?us-ascii?Q?Pq0c8tHuA0LNBwMPzXWi2w4U0bp33uMz4K6P6D+NYE+7XU7WV6Ye8iW8Cpft?=
 =?us-ascii?Q?obtGQsUOOFHulrLV+b0eETY+SR9rbnFvd3PeqtAQ0AR/fgImaQaPiZuqnI5F?=
 =?us-ascii?Q?Xe4ns7uB2ALCsFURbCjZxpioYbUTQo60+Qu8f0SJlTYSNbKLgsiblnVeKCcz?=
 =?us-ascii?Q?ZIrlGUJu2EuAf8GWGBwEjIO/36RjATUcMOYVPLn1thycGkTpTtYx4bcfohxQ?=
 =?us-ascii?Q?OMxe+sRP70efD92W42KeD68kIqkVMhtvRfBcMoMPEaJf1TsnPxKmMJpXNehY?=
 =?us-ascii?Q?ea92a3e5G6+ecIpAiFsyfdiqTMN6WMIlKHcUg0w1A0EKAIyfscLHc39kmcb0?=
 =?us-ascii?Q?krhoLExGhVgAzCJk3YkbUVfCG1SkEdVn/laaStmkvoGmL4K80c0o2EC64I4n?=
 =?us-ascii?Q?4o3fZgtbg6Ei40fpYTwnzyWMcmxJL+FBfOAevC7AU2HP2T1nEU3NyJQHowla?=
 =?us-ascii?Q?QXhH4yCmaUyDO1oqoWs4xHa5gfH/Drtiyy5JxPW0+oKTKOOVygV14NV42Lk1?=
 =?us-ascii?Q?oTe96iosKccWEGqsKV8zy5pIhp6zjmwQ6QB1mfCLoQdTHR94dt/CKf4gflxn?=
 =?us-ascii?Q?ipyZBpXKRBuSPYJEFrphS2TmNDsEtcqvIG6Lq/dTtgug4BEQQff7yqTheegG?=
 =?us-ascii?Q?Qvcu3xji5B82M5GTEfN8G4xxLWdpy0yIV5cwgE1Pan30t2zRc50ipL6wM1if?=
 =?us-ascii?Q?BTIo5jiRrJs3vkyWptJMKbuvOQTKdt//EC9Bxkd4o/EualcJ7oCc4TuIoeFo?=
 =?us-ascii?Q?Tz/UnHKj2fVn77gPqeO6SX80TtS+F1smXzxMuW/QP6oUYJnv35XbNu4M/u7o?=
 =?us-ascii?Q?dtSlbMrHQ/qM4HhEnxqFZ8A1qnejvQfCJSpj53p1iocPCdKBaHVk5KVbvLkG?=
X-MS-Exchange-AntiSpam-MessageData-1: HFAR1FLKgjnelA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34ff52b-73ea-40de-5abe-08dee150d215
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 02:37:17.2752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SOZFKmvVqT61+YGP4vPcfPERl+V3QtGrb3QuCBsMiUYSAA1SraDmswmwnIj204U3HTbkRjqGPfYYrIWn47Vt6wV2N6/s35SYjg4pn3Ms3u0dDln3LBmO2NX9IKRlxUA82kje6QMr7ER3N6Sz24DdzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6032
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307339-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29C2675066A

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

This series fixes three bugs in the stmmac L3/L4 TC flower filter
implementation for the XGMAC2 core. All three patches target net.

The L3/L4 filter match count statistics patch (originally patch 4/4)
has been split out and will be sent separately against net-next per
Andrew Lunn's review of v1.

Patch 1 fixes a register corruption bug in the L4 filter port configuration.
The XGMAC_L4_ADDR register holds both source and destination port match
values in a single register. The original code overwrites the entire register
when setting either field, silently erasing the other. This is fixed by
using a read-modify-write sequence.

Patch 2 fixes the basic flow match parser to properly reject unsupported
offload requests with -EOPNOTSUPP instead of silently accepting them.
Unsupported cases include partial protocol masks, non-IPv4 network proto,
and non-TCP/UDP transport proto. Extack messages are now included so users
know exactly which part of the match is unsupported. The -EOPNOTSUPP is
also now returned directly instead of using break, which was silently
discarding the error on FLOW_CLS_REPLACE operations.

Patch 3 fixes a stale action bug on filter deletion. When a filter entry
with a drop action is deleted, the action field was not reset, causing
it to persist and potentially affect subsequent filter configurations.

All three patches fix the original L3/L4 filter implementation introduced in
425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower").

Changes in v3:
- Patch 2: add extack messages to each -EOPNOTSUPP return (Jakub Kicinski)
- Patch 2: return -EOPNOTSUPP directly instead of break to avoid silently
  reporting success on unsupported FLOW_CLS_REPLACE (Sashiko review)

Changes in v2:
- Split patch 4/4 (ethtool stats) out to net-next per Andrew Lunn's review

Nazim Amirul (3):
  net: stmmac: xgmac: fix l4 filter port overwrite on register update
  net: stmmac: fix l3l4 filter rejecting unsupported offload requests
  net: stmmac: reset residual action in L3L4 filters on delete

 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 28 ++++++++-------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 35 +++++++++++++++++++
 2 files changed, 51 insertions(+), 12 deletions(-)

-- 
2.43.7


