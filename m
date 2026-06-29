Return-Path: <netdev+bounces-302574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MSNXOW5XQmpn5AkAu9opvQ
	(envelope-from <netdev+bounces-302574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:30:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B096D972A
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:30:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=C8IgTxV6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302574-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302574-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84B0730221E3
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E64036C9DF;
	Mon, 29 Jun 2026 11:23:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FAB15B998;
	Mon, 29 Jun 2026 11:23:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732206; cv=fail; b=QTWxSUoMHlmMZZFyhJYSc+zYOrvR9xng2qsQv2xSmUS0oitz7SwXmIfeBR17Hy3v7lJxtY3mJmllu/0JuObHRYYl1FKjsJZ4hknvDWOE9iw/FTkKCuNmKx6N4k42zXtXAPMUL3+/8hioWp9N7rWBmcbNKi1SJDPsLU8uEse3j/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732206; c=relaxed/simple;
	bh=MokUzETEpoywHvG6W7dI3TdxjbSO1DXLi0Jilsmfhlo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TZ2WcWULNTAtCBWzrsxNtbfd+MSnCIYigQbCijPvjLVFL9y5LoHDiIbQMM/ns2ZZeEStr5IY4N4t2FEipGb5d0F1aeMQRT0f4/68DQP/THeAYv5Dl4OJ3r0Prg5O52QDOlZZz2ESYPUoZ8knYpbfaEf4ajff/eKDYowrtnDvaTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C8IgTxV6; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJuXibgjCStMrnmgMu50sTT0KHHLsEbI+PsvvvCK0NKKJVGbmgtJI8FDrihlTCYnJh5TpkvzblshSXkylDZnZQm8qQhpq7KyLXvqcQlgLkHp7yR+ICKUpAFi/ej2DeoHTxNez/TWBLFXwMlFPLvmYPZCsDMKbeW7YiCOQMK9YKETDxq3HwGO4TvKuSCuYa2t2DQju24MH+h3BMdwATq6fg3ZsMXLlBgvQJ3Pr70DyV1P4whNlHq1P8zdnZoVDHKSK/lafRTmY7LO0NPvls3zlHbUBecAUAeVu58wi3eU4YP6FEPM/EJh+QoDfiX4tC8hwIxBFJl9sy7QmvUG4RE81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rb6p6p/VNRgSzH3rcVrWmUNrTjivqpvwAtJAkvplKME=;
 b=zMoUAw7B2Jy/urwgfYP9M7hug1IokzcW4zzpr00l0upcbTaG7Dc0LOOQK+DZfTHbyYfXD4zqxH2Yq+US4sRGuGV0/Wkg0GC8iRb8b/FoYPWfVhXO0+Cbj2Ze6fZBc8/uEMl4UF9j1Algv6VuL2RsFkqSSVIfBP571BMsxWjMPUt0vDNMzmU69XLHr0yBFp6MpfZgkuuVWj+GDmJHNaerA171tFcXAxpn6c8+xXtbRljMoNOgTvNXeOMWVS0pEXp8epboMc6brxwiWc4Kxp6XVnbIJrzhoWLTNcMR237/1dk8y8YcMh2NFZKUQbK0U/kiqjLplmhXie2Huznqxh9UaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rb6p6p/VNRgSzH3rcVrWmUNrTjivqpvwAtJAkvplKME=;
 b=C8IgTxV6wTR0CZ1KujrPeaeviz/tG1IUjwFLoJ+8Fa2zLnlki4SpuBXs/8YJslyHbua7NfFbQW5ZFerkx+7rMVM5FZtwtTB050iKHimy4yp835qjO4nSNA+3c2SCdU6nkVG+K6vee0fd7QjyKtnThN7ducTnlUf4T5sfYhhfXRQ7x7fGgnoqTDM/jQM7fg4ZJ+Q0SmF/tDO3ZYc907VyxMlb35I6KtzabsoIxHOmMgoKIzyyvPfAyrMg+wwhSF1F0JMmWQApd13ar5zto4Ct6tf/FmJVwxLu8muNnrtaJMW9Dj8lYVCzGs6T9huF7oGsgJ0LLzxvAfqyZh35Mcnj0w==
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com (2603:10a6:800:31c::9)
 by AS8PR04MB8563.eurprd04.prod.outlook.com (2603:10a6:20b:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 11:23:22 +0000
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b]) by VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:23:21 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 00/13] dpaa2-switch: add support for LAG offload
Date: Mon, 29 Jun 2026 14:22:56 +0300
Message-Id: <20260629112309.154328-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0014.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::19) To VI0PR04MB12302.eurprd04.prod.outlook.com
 (2603:10a6:800:31c::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12302:EE_|AS8PR04MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 829e4b8d-b705-45b6-8cb0-08ded5d0d3e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|19092799006|1800799024|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	8Y3BFGcJfJ5elgGbdY47DBa2bmeeT98eQm2lHkHpA0hfKSKS6Sx0+mNHloKJO23dI5AhyYr77uHlJ4o2erg440l8AOqT+kqfeiupf1p3jwf+5SWzMisnTLdWV1fVDYyo2P3zgPJ4chhyYm81s4yLDvGy6V15YWbseaLhJ76teNnDC5vpYv9yH1zNSygdrqokuNdxL+qZckYSW3NIX0lejs9HaSdgETeD1VuPrLcpkgfB2mocJ9KtMqWX5z14ukJNI3QlHDHxBnTujRJEGUcKRPTeQ+/G2EwU1L0GNLACd/h++j2r1Mtf68kkUGGLioUodIzb4wylVcCrVdaf4modQtNAQUTwD5iDNUem69jTfwfc7834N8xF6YhUCqhBJyJniJTkPqBMO20IiZPgI4DhEiZfc4OUiq4VCdiD1oRcYy3CeZjMa8vAKFgmZZz7tSuU8WZVXtO3qQhzZAg8za+sKrtTOmWbgIfsijNqZ9G2FXDWLmyW8XKO0qipVVQOoUXtQXHvcZ2aGLMY3sswyzIXdOElgtfiaTGb3Q8ddtlJSVc4Vtbl9i3/cV2dNR3rvBlixNsb873I+UA4bbW2p9s6M5ZZrYOeei5zJUrllOCz5KeWpBmBp98pbU9AB8aotDYZb1Tnsx51v2Dn9eJSEuStLicCIwATmUPbsA6nFSMY1RI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12302.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(19092799006)(1800799024)(18002099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9xsGKJSofGPFFuSEfjTBwzqYPA2tQfUY4FGPzZp1eycU0ILS7lPjrILB55/Z?=
 =?us-ascii?Q?0JBpkHqkNNBD0hWuBzVguK10ePhG0MCOEcHGjDY9j4/1Ad/YtzA8WR6t3Zbu?=
 =?us-ascii?Q?whfaU6W1X1egjlsslterHWcXzJjv+g6jQX9bPit5a6RJgfviPo3eHYMPPPkR?=
 =?us-ascii?Q?Wn0jSU1RxgeIzhzhOrnRrwvmkN0miAtrhuyNQX5mBm0uyaM/vkhUOCKy1UEw?=
 =?us-ascii?Q?cakO77LBjII8B+ZrmCPFtu3n+LHNeEcnBLroaUTZkapSB+WaZAXXwakydALJ?=
 =?us-ascii?Q?k/6xJCCWvFBgN9Q7mjHQE5JL4eTJgjNk23abEpw3wffER6noDKu4V3TQ3vM8?=
 =?us-ascii?Q?6vPY22eqFT/4I7WXI1ME2/JAoeQDeU5wQsb46g87qBXzpajLKkV7fw0xhSCF?=
 =?us-ascii?Q?LWRM7wNs1erXIStnx8We1CxTPkq9W0RR70CvL9oImm4aaDq/x6OxAdAqz6QU?=
 =?us-ascii?Q?r4rKslNFZjf9m21flEpCZ6fwIMfy97JEdA9d9v+2d9NBlXu+YLb9b2RqUUmD?=
 =?us-ascii?Q?pqt4EYiWwep3uK0EGYhjtI+5VOy998QNGK5xRROh0F9Ckv4DMahANsZN9ji0?=
 =?us-ascii?Q?slzUAjmZH4tQ3BimIz7Ont+ebVNDv2NHdPvc6q7V2vyWe/ZLhTExttiQTpfv?=
 =?us-ascii?Q?GC7RGz3xNxeMSumoWcmNwt3TPF6xhrVH5vn+PMTdMLo/e2/rZZ6HEZUv/QmA?=
 =?us-ascii?Q?0pYe93hCUG4z8GzTKtwR/axZIVdCD4qLnA/csoRy+0dh0+GRCS+EtU26SgBw?=
 =?us-ascii?Q?LncqaDYpeaPhDG2Zafxdop58Mue2W9cKzTtE2/uA5ey8WpbCINb+TcNnL2Sg?=
 =?us-ascii?Q?lMJgUipbBt1NEBGtgDSH54NAvN0GMTyv/ntzCvYGYVdLmQzgEdZ4V5a2G+ys?=
 =?us-ascii?Q?NjP1LXvj0QS2yKfHIDPnnPSVx9S673bgdOly58NCmABhHNqjWRBWcsnMzF6t?=
 =?us-ascii?Q?eTEprMHDIWxqxy5fJ7XoUvA/9giqGfPx1JS8YdJj5JGh1nhsu0KYzvKlWPoU?=
 =?us-ascii?Q?xwFFkhJ4a9qvfm5czJ538IwExOlUXX30dIkBj2cm+FNQj3s33Yf0zOGNzk3k?=
 =?us-ascii?Q?c6g4TJ66TgBwQbVojLJ+MlOaAzXGdY6FI1B4DiA98AixYP/sB13mkk8Rpflb?=
 =?us-ascii?Q?av+QoJGitq7yRtVDR+VAH4qPfTiGN9/+I2eYEMPcahYQo+p1Scatposwb9Lo?=
 =?us-ascii?Q?K6qITJxDN5Yd8rUAhKfVcq+sQJJ3KPWtc0UEzeKMbX0heGgDjvapwMQvxUQa?=
 =?us-ascii?Q?X1esAbwXbLI0t9odtreWMEiOBpigzpOp5NeIjTazyr5GsQYf7rhitG4ZEcAX?=
 =?us-ascii?Q?1a3GPLdRq70DcG8/nY7+iEq1S33tKkgPg/MGA3AJ5X2wRI3yaWJuXVRo3l/S?=
 =?us-ascii?Q?CB/9WmcJir5vPp/0bsQRKZtxW5XpuUoOuTEiRaOLCQoIMpsFUNTJg+B1sp7X?=
 =?us-ascii?Q?NfgmcM8vuFr0f8V6gm5U/avMPeVy+M6sqriGPWtFsqDOTWYbIIFAIavmdX9h?=
 =?us-ascii?Q?WsaYXkZ9Aszu/8rXi2Pjctww5+ujAHngW8qF2BzD5gio8Gszhf6vPtaxggZt?=
 =?us-ascii?Q?0YBq5S5xl6VEudw2Jue0panj3GO80HlurxMwnrK91jub3HVHHbloao3LjZpM?=
 =?us-ascii?Q?hwo58vKz9+havzwhZWo1Y0RAfusWERrHK297qp6B3EGDYa5GFwy2W4MfPSNd?=
 =?us-ascii?Q?9U1P1CYKcCPt9bZp0536agFfDXZN31OHBoX3hwpHiJzLPfRonhjDnb5n7QO1?=
 =?us-ascii?Q?pJ87kCeLoQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829e4b8d-b705-45b6-8cb0-08ded5d0d3e0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12302.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 11:23:21.8908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GuOA/WB2ZH0vI0h+oWsXC/PVW2v7ABZ3z5r4BQAYt7KqAej+C9BQA2DBzHS6FrdMw+fYKdaatFk9+dr07xOKFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8563
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302574-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:dkim,nxp.com:mid,nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79B096D972A

This patch set adds support in dpaa2-switch for offloading upper bond
devices.

The first two patches remove the necessity to hold rtnl_lock during the
event processing workqueue by ensuring that all event were processed
before any changes in FDB layout happens.

Patch #3 updates the logic around choosing the FDB that should be used
on a switch port. This is necessary since with the addition of the LAG
offload, we need to take into account all ports which are under the same
bridge, even though not directly.

The next four patches clean up the FDB event by making them easier to
integrate with bond devices and also add the
dpaa2_switch_port_to_bridge_port() helper to be used in the LAG offload
support.

The 8th patch adds the necessary new APIs for the LAG configuration
while the next one uses them, both in the prechangeupper phase and the
changeupper one. Which ports can be part of the same LAG group is
configurable at boot time, thus we use the prechangeupper callback in
order to validate that a requested configuration can be offloaded or
not.

This set also extends the handling of FDBs and port objects so that they
are handled by the driver even on an offloaded bond device.

Changes in v4:
- Moved and split some patches so that any preparatory work is being
  done before the driver offloads upper bond devices.
- Add a defensive check in dpaa2_switch_port_bond_leave() for a NULL
port_priv->lag
- Extend the dpaa2_switch_prevent_bridging_with_8021q_upper() function
so that we prevent a bond device with VLAN uppers joinging a bridge.
The restriction is related to VLAN management in terms of the FDB which
can change upon a topology change. VLAN uppers can only be added once
the bridge topology is setup.
- Remove all FDB management from the bond join/leave paths. Decided to
reconfigure the FDB only on bridge join/leave since the FDB determines
the forwarding domain and when a bond is not bridged, from a
configuration standpoint, the individual lowers can be viewed as
standalone.
- Moved here the update to the dpaa2_switch_port_to_bridge_port()
function so that the LAG state is taken into account.
- Add a new per LAG field - primary - which is used to keep track of the
primary port of a LAG group instead of determining each time we need to
use it.
- Set 'skb->offload_fwd_mark' only when the port is under a bridge.
- Migrate FDBs in case the primary interface of a LAG changes.
- Use lag->primary instead of determining each time the primary
interface of a LAG device
- Link to v3: https://lore.kernel.org/all/20260603143623.3712024-1-ioana.ciornei@nxp.com/

Changes in v3:
- Add a check in dpsw_lag_set() for cfg->num_ifs against
DPSW_MAX_LAG_IFS
- Add kerneldoc for the dpsw_lag_cfg structure.
- Fix logic in prechangeupper callback in order to not call
dpaa2_switch_prechangeupper_sanity_checks() on !info->linking
- Fixed up the logic in the dpaa2_switch_port_bond_join()'s error path
so that the FDBs are cleaned-up properly and we do not end-up with FDB's
leaked, meaning that they could have been marked as in-use but actually
no port was using it.
- Mark the port_priv->lag field as __rcu and use the proper accesors for
it. This will eventually become useful in a later patch when the lag
field will be accessed concurrently from the NAPI context and the
join/leave paths
- Access lag field through rtnl_dereference() so that we adapt to the
__rcu change.
- Check that the brport is non-NULL before calling
switchdev_bridge_port_unoffload() on it.
- Get hold on port_priv->ethsw_data only after we know the device is a
dpaa2-switch one
- Update dpaa2_switch_foreign_dev_check() so that we check if there is
any port in the same switch as dev which offloads foreign_dev in case
this is a bridge port.
- Add mutex_destroy on the per LAG fdb_lock
- Make sure that all FDB events were processed on the workqueue on the
.remove() path.
- Delete the refcounted entry in dpaa2_switch_lag_fdb_del() as soon as
possible, even if the HW deletion would fail
- Access the port_priv->lag field only through the proper rcu accessors.
- Change the mask so that we restrict the trap only to the link local
addresses (01:80:c2:00:00:00 to 01:80:c2:00:00:0F) instead of the entire
reserved bridge block of addresses
- Link to v2: https://lore.kernel.org/all/20260512131554.952971-1-ioana.ciornei@nxp.com/

Changes in v2:
- Extend dpaa2_switch_prechangeupper_sanity_checks() with
netdev_walk_all_lower_dev() so that checks are done on all lower devices
of a bridge, even for the lowers of a bridged bond.
- Manage better the default VLAN on bond join
- Clean-up the error path in dpaa2_switch_port_bond_join()
- Call dpaa2_switch_port_bridge_leave() in case a port is leaving a bond
which is also a bridged port
- Update dpaa2_switch_port_bond_leave() so that in case of any failure
the driver tries to cleanup the LAG offload configuration.
- Call switchdev_bridge_port_unoffload() in a switch port is leaving a
bridge bond device.
- The rollback in dpaa2_switch_port_mdb_add() uses the newly introduced
dpaa2_switch_port_fdb_del() helper instead of the _mc counterpart.
- Update dpaa2_switch_foreign_dev_check() so that we check if between
the switch port and the foreign net_device is an offloaded path. Before
this change we also checked if the foreign_dev was offloaded or not by
the switch port.
- Update the switchdev_bridge_port_unoffload() by passing it the proper
context and the notifier blocks.
- Add dev_hold() and dev_put() calls for orig_dev
- In case dev_mc_add() fails, remove the MDB address from HW with the
proper function, dpaa2_switch_lag_fdb_del() or
dpaa2_switch_port_fdb_del(), depending on the LAG offload state.
- Fix 32bit build by using BIT_ULL
- Take a reference to port_priv->lag instead of reading it multiple
times.
- Link to v1: https://lore.kernel.org/all/20260506151540.1242997-1-ioana.ciornei@nxp.com/

Ioana Ciornei (13):
  dpaa2-switch: remove unnecessary dev_mc_add/dev_mc_del calls
  dpaa2-switch: avoid holding rtnl_lock in dpaa2_switch_event_work()
  dpaa2-switch: extend the FDB management to cover bond scenarios
  dpaa2-switch: create a separate dpaa2_switch_port_fdb_event() function
  dpaa2-switch: check early if an FDB entry should be added
  dpaa2-switch: add dpaa2_switch_port_to_bridge_port() helper
  dpaa2-switch: consolidate unicast and multicast management
  dpaa2-switch: add LAG configuration API
  dpaa2-switch: add support for LAG offload
  dpaa2-switch: offload FDBs added on an upper bond device
  dpaa2-switch: offload port objects on an upper bond device
  dpaa2-switch: trap all link local reserved addresses to the CPU
  dpaa2-switch: add support for imprecise source port

 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 931 +++++++++++++++---
 .../ethernet/freescale/dpaa2/dpaa2-switch.h   |  42 +-
 .../net/ethernet/freescale/dpaa2/dpsw-cmd.h   |  18 +-
 drivers/net/ethernet/freescale/dpaa2/dpsw.c   |  60 ++
 drivers/net/ethernet/freescale/dpaa2/dpsw.h   |  30 +
 5 files changed, 948 insertions(+), 133 deletions(-)

-- 
2.25.1


