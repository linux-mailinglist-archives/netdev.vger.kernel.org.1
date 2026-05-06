Return-Path: <netdev+bounces-284897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBIXLrBc+2mUaAMAu9opvQ
	(envelope-from <netdev+bounces-284897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:22:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7BC4DD1A7
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E0FB304B152
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ACF48C40C;
	Wed,  6 May 2026 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jo85wuOT"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013060.outbound.protection.outlook.com [40.107.159.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5A048B38B;
	Wed,  6 May 2026 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080562; cv=fail; b=ttiu4CyJKVTHTxAnpxtMzQIFGeWyCVssdGfPlEw3S5M+3wiieiVO9ZbTWUYKe/rWeeLQqlaUH8d4bNqFYTxW2ZlSPLFDCNYEd6TgrqhV4lnYp4CbJ9Sfgci7YFsok5xfAIKNLGBwTbPMPbOAJpmO38MATqSVpojALKSjTcsjDKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080562; c=relaxed/simple;
	bh=epaNULHIDuoxBK5w4JI2W6VrO6OVHRNEWyKiK0uNziQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AjpkjuqvhBRtZlWlz5D3xAZxZG28BTUaBgrLfSObN8oQMC/2+Kgdum2EvEYMXt0y7S4kq/GfxpL/OGuT44fGMdBj3MedBeYp1rpe28wENNJKtTjy1MsH9cGnSCBDG6zrVTmhLcP8Sb0U6s5jAnFeGJLOnQpSOCxvC6AH5O2tktQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jo85wuOT; arc=fail smtp.client-ip=40.107.159.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdoXWa1q45kjC4EH0ykSxEg+X6T8Vqosz+SaH5wQTo/3ArvY6aQ66o7z9+zCr/aN5XR8paFCRqDm2a2gbkJTgxcuBmw/YbKMEe43rV+sf4NOCU0lTOtWQj9weWLVhAOuIMuJ2FXA3wFuGXQ6ohyCebJuMyZEuBTcnov08aqv27heT3EYizL8cPHHj5ISrjwNJ7MAqOhVE8kNUfFpHNZsLTNlBHU7WOwy4x46vUwLx+WmgyQOuY4+Ox5QczMot3KIwoFFtiMaeMUIH0SzrVEPOLtiBJ3rlWJ7PmSVn0xD/yG0WioiZPGzs2ZBBCHe7Z5FZVGmb7KSqMhaeJgGZexWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7T+yWdvtXbZXBwyJmVyvLYUkMkwHBTjcPamFWOtzlY=;
 b=bEHipeDp9qwFPDyMptMun9YE30VfuS+qaaukBuwcYLyu7jBg1LpCdUhmlJZB86kKRZSS48zgl9u5a/rFVar1H5wClWHISSRpwfiqtiaS+GFZo7mT3HaZ3uQxNx45oSAS2M/l8CITkoixA+Rysl1dyQ6LVxFBEnblMOhBcV4OTH6Dj0c8wtU+HWQQj5QilQWsPKhAQcLiq76P38+xGsFTu+28Bi3ssR10OUDFH8iCGIMqmCW7IikHJbTfBdEgUNF0y6JRx+EK/omH4zMLdnJUSucEfBZrHZd5yCYBhKsjczNovxFBpORErkGocwBxLCVJFDosqq2XMDG9se70UgfJDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7T+yWdvtXbZXBwyJmVyvLYUkMkwHBTjcPamFWOtzlY=;
 b=Jo85wuOTXrcIQxf0ZiOluK03qUoRcvPDbyKZ3AHAnyxjNz6xpPxPrPNrvqJX0htYx3uKFEOeufLYMUkikbZiyKXN60cvbHV9ciS9OmnUuMba2MmVwRTuydCcpcFGqvcvQ55xp7BE9Dx3KJUbZoUpm9+DaL8Tap9vCFhRqfaoVn8v3I1hkcBpHQekqIdzMIHv4Yuq9aOQuxmPneEM30wdYHmaStrZJWvNXQ+3MeuuCRGEOJZibyLFKiyrONHSmVSBmw3yCrWV1xhBIUBh3swLAMSH9+Ts94KKNwvztEK7C2XogZXCG9948zp5pFRNgYbIgLrpDBbnMlhtZpyUqZixBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by PA1PR04MB10626.eurprd04.prod.outlook.com
 (2603:10a6:102:48e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 15:15:55 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 15:15:55 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 00/13] dpaa2-switch: add support for LAG offload
Date: Wed,  6 May 2026 18:15:27 +0300
Message-Id: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::12) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|PA1PR04MB10626:EE_
X-MS-Office365-Filtering-Correlation-Id: 4815285a-f243-4d2f-720c-08deab825e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5srkGt92MuagTPPjTSxb49UKDHMw7eiP3RKFfNJJO2NyZH4VlCy+1vsjGBlkDyWhaZX2KeDZyNNzG5Wul01Z7NPdO6yYbdwkEfO5bcRO8Et2Kc5PJuciUTmIQ6zVxddBliUtNLIZuas3YN5KrlfYH6dser0Q3nLLD5+oK89vfrf/iGSSI44HJxguAv0/KvxNiYoE2g97Vd9golJ4aOiBinQwHlgbHNwuhr5uB01dhYL8M5wklbRWNM8WFiOj531amOlI8ylETvxbVphAzeFP3G2iNYxp086rlGSmkxYFNFkuqC76Nu/ANPgjeMogdxhCVb/uDs//r6Fkd+Fx8FCcFMt1+So4q8F+tNWHMfVO7Ovooo5jSGfgMslxBUCxRD3utv0X+CuG2bhmUrFzJtffuZyOw5IsomgYYxwJAQ9/BNdHzW1TxexMistOtqOnq4/pLiiyNcjMcTmZwFTHQc4DsQbNYiHRgLGLMtlKFEuJzGLQul1jV3DxcaRWn7DX3eUE2xSAv+ILM9lwEgLkxg4iBS+zDrLEk6+xhq3B9iSs5B+NkKm/bWJy5wGF/dX8dw9LOPwHYqlAGISjqo/mGzigWZohzc64gXt5B71HxnXEq2lKHQS7zRFfT7W47ioS+m8RXqD3/Vd0H++iDhvVAqexeFyPLlMAgl0KtugP1ZgzIfzwYAY61Y7SzhxFRrPWEzF3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HeamOT0M+JZPedtvqTuVIh8IdKvSPnCnCrjfsbvVEWPOhkdJMo6Ap0aQnn5j?=
 =?us-ascii?Q?zAROP00Tn/VKNMGMthQbKwI3dIwcY5oGKRR8QoJkZitrfOJl4bsCwn+1RYoQ?=
 =?us-ascii?Q?Lg0x8hMyjeBe3JOT+xTHGnElCeCNjYrTE8jWgqQaZMhViqbeGudLTMtY2QoM?=
 =?us-ascii?Q?2L5vD3V54VkZ/yaxyfqkZ5OmQ7JEIdX/7eKr/zfhOlXHZEK9a9FfL7NcNK6G?=
 =?us-ascii?Q?s4KeKEBs5MdSQZMjpJdCfqaWM1ozolIZhfmxx/Ib/kJdeGNq9/aY4Wl7Khec?=
 =?us-ascii?Q?f4mX9VJXv3QxhYXNH/Ft+Dv1FZgScWKalH8RRFQWMr6qmUZB2k33dX2l728s?=
 =?us-ascii?Q?+o+FlTA4WnLHuznoYfM1OEO4cqf90P23pfW0/4azxRaH6B2qfi90ozqp8UIG?=
 =?us-ascii?Q?f+uZYEXTmdDmZcl7ey4YF48Woisphrz3wNgxMo4XHcB6NNUPRGRAsuOQ6Z5m?=
 =?us-ascii?Q?eFERYQwMTyxo4siofWpJwPZ64hN91nWqM10pmm24tJ0WwoufrtV+1pqwSii/?=
 =?us-ascii?Q?ujkHuT00SgzmojD3A/rgZTtWjoJZF0PhAurcBY1rWbzCdyyWF+9Ij6cmlkdH?=
 =?us-ascii?Q?odIkDQzMepg9gL+ICkNrN6SpcEmGpvljkEw0tyJxV33/qAuvpxmThii58xeA?=
 =?us-ascii?Q?VE3begkH88N4zKkwdzVVPzUq/sUnEh6tIT9uxMsESs9wWXWmWbfYD/50KvoO?=
 =?us-ascii?Q?9g43WiLU2TMDzv4Wzpvnt+C5rtF/yXYt23i4OkMImqa3dUoZXq4n3VsenZgt?=
 =?us-ascii?Q?msbVYh+W97qQGrxO0ID4i4D88uY2jk/Osygefjrq/IaBPGb9bXOG/Yj7s0wL?=
 =?us-ascii?Q?f3z4lAEQtb2wI1iAyZ0cqHdvvFZPJBQxQTkFuHm6OgnYiiDh/BeNCu1/b18o?=
 =?us-ascii?Q?SGSeegmZu4rZCHoYjNPrY6/I+PyE+7s1xZWJj41kvRm7AIgnDJkCQdeqGIuo?=
 =?us-ascii?Q?QcHjQhv63cWrHxwcOsu3LmZkntSzoR7w4V4xDW+9sX4ym3KaUTmWJlWDQTEQ?=
 =?us-ascii?Q?WJf2QeOB4cDhNebw5Y6V/3G5zQ4wrTPvPcrYEiISh7JTe0eKZwGcb+p14GyZ?=
 =?us-ascii?Q?W4YttIvWBy2YBOxNuNM/VlJhizfaiYZydX8B2OgtDkWy8NSx+3vTyWgbr0mD?=
 =?us-ascii?Q?Q+t6F7x4GDIJyq8FWPDIKRCBuJWN7ZQAFz4+V2uCbodBl6FSy11G8bvRHY4q?=
 =?us-ascii?Q?isRSMfN1BtNwdw09gdiNYHG9lr6/1yPb3qvV446N40BvfoAnAw+vXrJph9ky?=
 =?us-ascii?Q?u2bsHDB0S51m1vMtsNLYZgjyOzdMLyXhQ3rcOJ5NzmZuC4FYSAsXJiuUTbHA?=
 =?us-ascii?Q?ktUwYBN08cY91fhU9hn6eb+14XpGYY+5kjRcmOS+5NBkeBfDIZivu2kVIsbE?=
 =?us-ascii?Q?Nlb9yIKEjGORQkNKY9gQ7D9FnODkCsR7uXLyLGFXX7KdNUBJqWYCJitrF9FK?=
 =?us-ascii?Q?5XpWyTi8OT5j1FalIWuyRIioEITLn1OMIWLfu94Pi5D5ynnEr8i/jLgZbXRK?=
 =?us-ascii?Q?j1EkEZzqpa3Bd5OerQHjgvyWqqU2eAnLYQ/g4dU5vtSc5QWT1jNnP78C3j+D?=
 =?us-ascii?Q?mKIR1Tp+Wxl397jmd6s7m6c/7fnYVtwUXbj4B3BbiKuj9c8JWlj8dJnevbZf?=
 =?us-ascii?Q?tD829rpjBfT/Ggh5mVqdIIUjc1tPVkfIapeG6xS6lHgf2n9D3kZluKyu+Sjy?=
 =?us-ascii?Q?/8puVKYun8CBcLyctD+2c5Z1zHRvpmVbyjVm2kgeAr7x5Mc0oZ2pQqYlQxPL?=
 =?us-ascii?Q?g8b/V/QLtg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4815285a-f243-4d2f-720c-08deab825e94
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:15:55.6709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKCsp4M580QRa160rzhT2Z1Ac9hRE1v3Z0zFI5dUHFTggRXO0JDq2l535g5VGxHIXZ/VCflK/6elN9C0PP1WTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10626
X-Rspamd-Queue-Id: BE7BC4DD1A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-284897-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

This patch set adds support in dpaa2-switch for offloading upper bond
devices.

The first patch adds the necessary new APIs for the LAG configuration
while the second patch uses them, both in the prechangeupper phase and
the changeupper one. Which ports can be part of the same LAG group is
configurable at boot time, thus we use the prechangeupper callback in
order to validate that a requested configuration can be offloaded or
not.

Patches 3 and 4 are updating the logic around choosing the FDB that
should be used on a switch port. This is necessary since with the
addition of the LAG offload, we need to take into account all ports
which are under the same bridge, even though not directly.

This set also extends the handling of FDBs and port objects so that they
are handled by the driver even on an offloaded bond device.

Ioana Ciornei (13):
  dpaa2-switch: add LAG configuration API
  dpaa2-switch: add support for LAG offload
  dpaa2-switch: change dpaa2_switch_port_set_fdb() function prototype
  dpaa2-switch: extend dpaa2_switch_port_set_fdb() to cover bond
    scenarios
  dpaa2-switch: add dpaa2_switch_port_to_bridge_port() helper
  dpaa2-switch: create a separate dpaa2_switch_port_fdb_event() function
  dpaa2-switch: check early if an FDB entry should be added
  dpaa2-switch: consolidate unicast and multicast management
  dpaa2-switch: offload FDBs added on an upper bond device
  dpaa2-switch: offload port objects on an upper bond device
  dpaa2-switch: trap all link local reserved addresses to the CPU
  dpaa2-switch: add support for imprecise source port
  dpaa2-switch: do not error out when the same VLAN is installed
    multiple times

 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 866 +++++++++++++++---
 .../ethernet/freescale/dpaa2/dpaa2-switch.h   |  39 +-
 .../net/ethernet/freescale/dpaa2/dpsw-cmd.h   |  18 +-
 drivers/net/ethernet/freescale/dpaa2/dpsw.c   |  57 ++
 drivers/net/ethernet/freescale/dpaa2/dpsw.h   |  20 +
 5 files changed, 886 insertions(+), 114 deletions(-)

-- 
2.25.1


