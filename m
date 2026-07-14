Return-Path: <netdev+bounces-307340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jUTqBfGgVWqDrAAAu9opvQ
	(envelope-from <netdev+bounces-307340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:37:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 14601750665
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:37:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=Q+PENMly;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307340-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307340-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E4BBC300FE6C
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF833815CE;
	Tue, 14 Jul 2026 02:37:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9159F37F745;
	Tue, 14 Jul 2026 02:37:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996643; cv=fail; b=oaALim99Kn5+v2MsE4DzZBsyPcomink+/D6YZcPYfZGrn+ayp2XmKbRLW1F44A65/UF7AqcGMmz8zCkpD1yhMpvxzzTN7njsKFu9dAsLYvEUAz/YiTwTHU8Ag6QbP3vk6MaV5Qs9taf8GssmdhE0KDs/ee6/2kjxZSSzD+t+m8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996643; c=relaxed/simple;
	bh=b5tWHjXUojhLYuBfRPl5IkljUzUr0iQjkV8e36kbXqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EUTlk5nadP9o2aUoPyxv0/EOKrzewY7DuRkRZ8rlPHZaxgfAMtMZf9OA6we5XuH0b0HveR+D4ZbPXuf2SmkQdHwwog5wHUP4C/zRHv3Yms5wCtH0wN6VeHOEc0m2MKFT7cq5xY/blERzR5iArT7gbUSYK7tMd4Oduy4eqPsU0GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Q+PENMly; arc=fail smtp.client-ip=40.107.209.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwcfZjMfeA1Tw9gqd5tK+emvHWF21u/rFJNvYl5oMODsK/625APA2xbgQmRjCCzuy401TEp6vEm+Bp4dtqvWwDMMZeuLoe9eOY6dioF4NeV1OFT/HqXvm00CxQgTY8suihvS91OZyeHyfzK4GilT3jujysMyvOMqJF+UhDxJ/dfHi840yP+WtTiOWO+gF6PWqzzf5kcpr1lSs1qxLK3cs/uxBHCU+ewuRv+Y5pK/hiERe5/34SMDt7xBzFoN/GsWc9ozr4Xat42aRYTbREy/Xc+G/p38QWeAxTw1hjq8oNho87aHy5nD4byaSJ7CQLlcqdnQKnTowWa8FOwM2Cs9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFO/QBaeaW+UlJXrtAPBhSLnyo5HjPOeQbVTLlJ7cSQ=;
 b=SIdQ23wZjdNU8WQjJkIsvTK6vVXduoEsk96CxGGQR816QjRcSJIBVt/4U14MpcazrIFtJglVfScZOlizTc1rfM2WxD5evngezxFYLkVMxnmFxRHh8Nydx5OwojZKSCm8wZ0Js+SrJ63fc8lHkXhnZ5kUWCeKs71lk2Sp+PiQo+WrfZ0Lb1CLNsoTb/dojsOqnd+nsuNjgkHY+ult+NS1qtBnfhSUI7J5nk/wGdlYOzfBGeSFCtH9pIuG5UP1MkDwwwdq+3lkUBaqWPXE2cfOcgXhF4m0gmFK7+QgEEdcF/uc8+F5dcGuOS4MsQ2uWn+CNCJEQRENQ/ZxfKCaOXzTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFO/QBaeaW+UlJXrtAPBhSLnyo5HjPOeQbVTLlJ7cSQ=;
 b=Q+PENMlyG7UNqSPGiSooJB2r3WVIjQ58Wfia/SG/xDxRYItdC4EWhr+AD1xu9L5TO112ZYkC2qvED4FNustCRjr0gsN2UZiuaqULdhd4h9xHzNffZNbynltp1XiWQFD3lyO7X9F8H6vVcqL/tbXlTTWzKLZ05jTgCBGoB0OTlb+krjNtRJ2R6piNHe9tIZA+JfkesIeQzPRvtYUa5x9ymOUQ/h+cyjBhS1ZI5e0BObAIg3EAwQtnYRJXisrX8bLznKoPxmjoTLigwdOOrWCe8aSPz1GhRSbi34Wre+H6jYoLM44xe3yc8RKOR7Vh/ZazsR5vSMDVxD9YFOqgbk++wQ==
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
Date: Mon, 13 Jul 2026 19:37:13 -0700
Message-ID: <20260714023716.29865-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260714023716.29865-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260714023716.29865-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 69aae3b3-c89f-491e-e2b7-08dee150d24d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|56012099006|11063799006|18002099003|22082099003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	GcSFqlczrnJsltzU4tr3BGsthS7XaTd3bYCfk1qeQ4zJZa0i7vWcu1eqpkEUZM9nAiRAtY1YCg3iLpKgk4n9FD421bxPNF30R1R0RTvolSmnmA7VI/Es7eVfxQ76fFehrg35wN/OalqOci2G9Daa2yniMm5YnKmsABxWdfjWcd3YKz1r2GGR/FJT8jr0MZjyzK7rVh/rwrLJNu+SqUFx02xjj9VZuyL4D1Yg1bXKTKSeeWih96hzHhE8AN4q8/Ae8KcFRUf5aWOv7N7zEKjrYFuDVCHJf5MQrKrM6c3SGuHnmzzh+DBB+k+KTJk6mEzBfkInsOOyC4P/ECSO9APnLhu6QLxWc0iwT6yUfE5tAyJzg3SSSvbIfSvyUt+DbGc4UXs4dfNyIDM8+GeuuMwVg1jsLvO357th/+ubitZ3imgXF/yFU3yBcXbuyXGoDkmmHNxMb4o8KgI4hGhvXYG8ob5AlFKFxaKiq2R4rmu5sdeB1uczuBynW3E/+rnB74JBwp+SlHCsKUuy85/GHbPhQa5eAvy1FYu+BzMxAyPllcvQoI1UL7eKyMlv4qTCYTAR8ga4b8KEwfE2FQlJExXz1JUi5PaQGAAbEeA4pJPM/VEfRqcGjQ+MEwIks1CY/MUQpX1mDdUvlUsPB4RwPfcKaiqzadaDT5wTiquX/Ef38ww=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lK6ssQb0iw0w7uISRlQxWecKjTcU9tBEq7sRBaJNFke4W+DvYA9ygFZxFcb2?=
 =?us-ascii?Q?sn3hE98hJyu0BfL4O9K8fGAwK1OxEtOT9v2liNm085qOpV6DOkEPmUd3sRTP?=
 =?us-ascii?Q?Wnylvzm8ezQals5zQOV8AFd3FxBFueCNfs9E+q/6lu5ghKeVpAFQzuBmIJFu?=
 =?us-ascii?Q?kqbIJwpbTzHzDZIjjgSjmcjZjWpvE+5LpzvddgIQM60XjX0uzKZirnQDOFoJ?=
 =?us-ascii?Q?THCxRUugcAkH4UsFBfB8PtvX3LsEmYanvmug2EoJls9od3a8KuFf5/+du+uR?=
 =?us-ascii?Q?jDAvfda0PNnYnrJujNkTMSh1ND0Ghh9dPoLL304typXLfZswQkI+TilfC552?=
 =?us-ascii?Q?12eaTmdD0QOZ47rSO+rCQ7gwA31lEjC/W1l6GXT+ZpILMl5oiV3mhUmF7wdq?=
 =?us-ascii?Q?XSBqFx3p2xOd4zTmJeMi9zQzAUercuwKXMS4CbKxNJ10M9cljQxHpIgRkU46?=
 =?us-ascii?Q?zBXl8z+RKZKN90nfCr6J1+BhF8D5ChU/zdu2B9xnirclw1sIAIFfxrwD+568?=
 =?us-ascii?Q?PRZm1Jx00MOT+IblFUQRWYaZRPHSaEUOBMKcOsPGwb2vjU+4/qmNiP5VnHbB?=
 =?us-ascii?Q?fp5rEnxcKSAh94BjPAEvazEJW8DqEjCYVbes0AZ7ppkSOv/WGFe3VBzIWQRh?=
 =?us-ascii?Q?yJPRkE8o50yDIH/5EuKNfbgohPKlXYhvQwFr2VnK4EIE/ZtZIlA2iDHbgL3H?=
 =?us-ascii?Q?Ng1VWWrjuLdhQEf8R7S+cYsOzuxZvJ1xiyox2KSfEjeUJToXYhZOYk4w1hGt?=
 =?us-ascii?Q?NQ7SaYNBj+6HwQMuouth6S2f8o2QYvtu+umOXpXz7/z5uhG0R7bm7bfol8rH?=
 =?us-ascii?Q?3mEFqjr1u0ztWYE6/YyQbLw95Q4dnalDh+AqPpzqje7TvW3k5LfXLqOELCxF?=
 =?us-ascii?Q?190DOAZ0h3SN79rleq+kH0iJHzGh3lBN1HC12OCKPO0NA2ey+sI079elwYWT?=
 =?us-ascii?Q?rVr0+HBzQMMl6QFLCbEiH/ZnSrl0cpC0JdezlqTtg6JDJnGxnhFjx0EelX6H?=
 =?us-ascii?Q?yU00e2ZyQsYrdbM/1B2tPuY31iSpdLUd37TPsrL3bAj1APMmBS869DiF98ry?=
 =?us-ascii?Q?1y9U/y3IyoLO5+gwouXLkMp+ENaiXN0uensmgoyWsPzf9Dr7Ex2GipX+fA2V?=
 =?us-ascii?Q?cJS7wXSA+lsdLIplytYAjICcwwp0myGqxHdrdqzs7eXNIrT25VgbDX+7ErVc?=
 =?us-ascii?Q?FzKl1trCQuVH/SY2ianVqID42Zgjifw+JBrzgaCngzU2yxmiBNNPH5deUOYE?=
 =?us-ascii?Q?azxw3MgNE7biq00h69mdnNvGCGdCaTyC/PMcMmQJ+xKyj5U4AssMLgSwmZWb?=
 =?us-ascii?Q?EeerWJypOD4frCHWh1yHJ2Cb7cHzUUD9Z5uIrDNDwX1qenhPSIxUMX3pCbuO?=
 =?us-ascii?Q?c0zO1Nn02ryLYouX+eA62al6Dk8r7uIEtpiV+gAhWUhiY5AhozSjeYGsT0DQ?=
 =?us-ascii?Q?eDhKE7EI4MybismW0Z5/YOs4yOJf+kHapv6C9U6CLblN0103vLoee5LIgux4?=
 =?us-ascii?Q?f+80Ao/R5tN8LedpTNaNdwuyS2Ob1rDGD1XbBe31jrUK28BtuTJCj5GMAgxc?=
 =?us-ascii?Q?zWBBL32MutM9Hrp+IFYEPjxupgnxg6WelECUkHB/IU9FOxxgmR1VEXxwauY7?=
 =?us-ascii?Q?0omYuRlyt3bvBsKxdrYt+V2sh/Hzx7T41pgAlR0dukn32a4IeOY3a9BAQCgC?=
 =?us-ascii?Q?khm8veDSdwr3ITi/TyFJZgsT8K2rTJ1/BLfQvMrI0IbkHtlN1WFpHdi2N/7x?=
 =?us-ascii?Q?PLUBwq3twcyF5CaQuKp3Iymt+62ObALV0oT3mang3rZTfbdAvW/d0I5QSjfn?=
X-MS-Exchange-AntiSpam-MessageData-1: sLJdXpltOZdrVg==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69aae3b3-c89f-491e-e2b7-08dee150d24d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 02:37:17.5725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVJoXQgMOf6a5n/7SELfAhP8vdoDYuhY5kAf105JG8lk0Ho4ZVjRiKCi4eWpx+hj6Ip5FTRIvwf19S0uTg7LH4GT7beSVH9ALo1flaTWZP0mXhd4vpwy2W5U7zPgmDxS6r7+owe8XPRDavJaw8KjOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6032
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307340-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14601750665

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


