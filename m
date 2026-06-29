Return-Path: <netdev+bounces-302583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LighAORYQmq45AkAu9opvQ
	(envelope-from <netdev+bounces-302583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:37:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F236D982D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:37:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=A0uY+QqH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302583-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302583-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C3D630CE9CD
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10541402442;
	Mon, 29 Jun 2026 11:23:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD1D400E0D;
	Mon, 29 Jun 2026 11:23:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732226; cv=fail; b=h2XOS1995X+7N50DD0XxXS8NIAESyQztgvXM4i7BNeD8wLmM0u1AJv3dG6DTJknhpoviWPDurmL4nRxK1TF0cdZW++pTlGd2OFUCOZ18H+6EfdVtpwu444eRQihX0u96oJLWTd2kh3j+U3JUtBwnRLC7yJJnBpwSYQtXnMMniHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732226; c=relaxed/simple;
	bh=zI0SmxVqityOidim1Ss3asZOc+mEp+5bnoHL/OolH/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bTV3u36ENyhxr/nhk8I5y/BdiPLLXb6cVb0PjPxiMQaODKRivn29Hzm4FHvFieZIoYjQ9GEYN5/3ba8tUkhS24LPu0+4FO9SzmQhSE2om7W7zBHhqZtuH9h3myAXAtEspyi0VOtMKqQZLHMxHA/nhwmUtHCuGOyrCte6TbqlMWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A0uY+QqH; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kusRd/wI0HR/xZDXAq5Gk85zHIE0wKCDTAoG9xs/bWZa27Ry67s1eyu3IbJ99N0IkUq0JhVQQZP2479LJiL6BjRZhePj5wXpLP8qzn4RtanqqrA9rCcNqiAcUdY6cwBd/FcLYiGLzGggnlS/S9+7GO7omjp81kYvUqhmCBQhEvFN+AVbh2QdHdpKLznMARfUbuWOUCMoofHLpJOlGy5bwrT6qGQd9dSxvt0PE8TQo3QWq6D4Nc6/gTxt9MM3ej1PgVBqKhyYoDYWkSFXZw9FMiRl4KiuZNO3PcJaV2hBTJs7oaXj1DRWhpxYQ0VMqYWZQhYFnycpxrmJ3BAyb2+LvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUqdb0NhXHNQaRCwM84yY53xMI/CIVS0pzFGYQ5tHLM=;
 b=ApDKuLoygZDG/OtWpOPqaCZWKBiGEfP43YTh5VRTkOe5cSugXEOlOnzr97r37zGQ1c7g2ZeJxb+5QE+r7lnMSxqafhO5Zdc8IjkA9Pvqe8JGMKm45kfY4C+V3heR4NH0JmKVsIUDbUSYk9I1VjGAGWYx1jt0SgtRKZgDPq9UKQyXpFSqXbWMB0UP0HZjw3t5iOPmcXKvXm5uKEqegMYfJMurOzApbF3Tdo2X3IbMso0z2FBDt9fBN/0LJW/5S8A1xdShq5b0T8OJrRvKPzaAOpghcaYPfeX+XcPGhzDVtF90hX3K3+N+IMKlF7ythYKBpvIcQXD5L9P393SXH9L+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUqdb0NhXHNQaRCwM84yY53xMI/CIVS0pzFGYQ5tHLM=;
 b=A0uY+QqHEWaWoirEHfpKwNsxs9oh3kPdeJFLWCUqeg7+rAJw5AJsoablTKftQ/ljeJkaX0MpfmGUAyK8MXCqDF9T5niW5FUi7YFL/w6J8Ztd34cP24yS8YPCvOOUrHlxuDQapj8r7V06Vv7T3n6mgi3fk6Y4rGxRo2BrThY1Pt3ZW1uZebQOvTk4faxYQMPvfPPQLjd6fRhAHjvuQhyEWxMPYKdPQf95jofKfsYQZAwvbtJq8xwXBu5YjRXGRn7FAw2xIXaTXyd8CImYjRFoNABqGSBpAQfdhOesGU24R4CcK34uvCzuAcoKxt84J3ALMVUyUsBL+v3Y/V5h8orNRQ==
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com (2603:10a6:800:31c::9)
 by AS8PR04MB8563.eurprd04.prod.outlook.com (2603:10a6:20b:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 11:23:42 +0000
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b]) by VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:23:42 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 09/13] dpaa2-switch: add support for LAG offload
Date: Mon, 29 Jun 2026 14:23:05 +0300
Message-Id: <20260629112309.154328-10-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629112309.154328-1-ioana.ciornei@nxp.com>
References: <20260629112309.154328-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0001.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::6) To VI0PR04MB12302.eurprd04.prod.outlook.com
 (2603:10a6:800:31c::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12302:EE_|AS8PR04MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b998a80-e399-42c8-21af-08ded5d0e05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|19092799006|1800799024|18002099003|22082099003|11063799006|5023799004|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	HYv56X/JTUaHWg1L3RJd/zZu5cESayLEYeiYX0m+ZXZ28MmeMYkbEr/Wbm7XPjsiIAyaos70kEZx33ZvzQJ64aAuvfRVYWQRswTXkAdUruJjqk+6f+HPGwBBWWc2s8hfrjURBa1I2PIe47ljDdbwQdaLXsbAmpYDCmxSn/2QAO/h8ldqZSDUCUoNMr3fHotKUyFrTCcKHyyPOqQp+x+tqHpN+qhUaib9vmci1+PU4WHpZLeOlkGsaItwfU3QLiob8epJcDD7520q6jK5bm7mJNiAbrRfYcEJ7l/FUaDkg0UlOFVwKt5jCEUoJ4GYQARNIFn4Oj8i//UFKBCJ6pHfxdYjIzY/54MFlivz0YQ5hLCOmknvOa8wX8pjD5G2/6SB3cW7YNCoSZ16/0oKUGSeh4Esqve2CrJESGdT+lnPLjW3IO+Xq9ux+OGN77gA2P93ha2U8Vyyo0/Pr/RTIQJ1oZUFDg+KkD4cNDjs3CcSdAv5jArh6fxlslw6FFVmrp+j7ZSAcd2PW3ojJtEtPl1DX3G+VZtO76/PMnq/Jofptvxq1OneeXfOcHdzwKHRAFOspEZ6En7e9pgmho1AJ3yqdCjelSvuRz1RGwMgUInzL8qYtrF+Ji9T1BEo74pjltuD5HKrxjnzVuUWlFU2Kp1m+S8BeaU84QBOFZpRudVEYoM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12302.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(19092799006)(1800799024)(18002099003)(22082099003)(11063799006)(5023799004)(3023799007)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3BdcCIiOTD0HLNsWJ7mzLty13ERfp43xvNax3d2kq1pDcPXx5iKbfqnLdEb/?=
 =?us-ascii?Q?6g6P5X+KtapH0L615Jzk/qb3W/BXBfljt3ghoRwX+MuMuNQsqH+PGLaXySVp?=
 =?us-ascii?Q?uFITV1Z6kS1/d5WaPQ1p1KEHZ60DigDrfE6nqoxS7IlZ8+7KjoW9WERkvGdI?=
 =?us-ascii?Q?XROaZeF2ryNlZImklyauGfGsrBXvTyw5IXYa5DzpmOOQr3KCuNikgkkSt62v?=
 =?us-ascii?Q?G9Do9QnQM1RQMI6X9R/O1MSmuP0jDqnqbrOnLmzZ3iy55xf7vxBYB1u5IwoX?=
 =?us-ascii?Q?O3xVaXslzwyGg2qsLewSthEfe+x6FGbj6GdzbPk4SCusgJjuw5EIKtUTiWyu?=
 =?us-ascii?Q?wbXPqlWyki9HvRecfQdCpqXJ/yYFpYVFsqgZpH5kE8gj5dGTiCQTCAeayZvd?=
 =?us-ascii?Q?za7nUEjvp5HHCBlmFS5X0SVYziqx/XoWHz3725xgI4GlM/SMXqDFIOi7YMgF?=
 =?us-ascii?Q?80CrvQke4YRR28dZkPK6qFyZNYYaAkBoRblErOj9ZULfRKikjAO8UTT1/Vo9?=
 =?us-ascii?Q?Y0IvVtUt/33AxJnwT9yxBv56/SV2t3qXTeQPUgOgkRbFFKnU0joMZziJ5mod?=
 =?us-ascii?Q?WmMBqAvYrCIqybwS59B9gXVNuYVI/Zfi1tPXTfi4K7UzvMgx0Niw8vZtnuMh?=
 =?us-ascii?Q?dMnrI5XC4UPhlKAJv4UP3fkWG1cNTqT1xsPxA4upE3i1PP3Imv3CN3K6hZXF?=
 =?us-ascii?Q?qhU/KnayX0ton7syuGnuMRwE8+E+XXfxhMKXLLCzULWzv+0UINlBfQqL764I?=
 =?us-ascii?Q?EygbH9UyqzZkQlE0EQalSmS69DJhz1s5I6Wtou7J+c3KVyC3PBANTZNn/CC2?=
 =?us-ascii?Q?AbsIc9ni9u1/eSz6FawGvZUJu3omE7272nKoTheHCcCQwy0kn6JX0ZqjlGr7?=
 =?us-ascii?Q?F4FS8eFLoocPS7pdKCyYuN07eYCgBE/ePc2xhRF8WMoDKI0VYukTBwM/FGoV?=
 =?us-ascii?Q?Ud6Fwv+Gvih3QNFh0U4oCthARJIckEQUuTqjE0aHaF2IYpktr2krXoC8wIOh?=
 =?us-ascii?Q?H3K5lJ8xkKL7M1VcIAV11uxuFkqRP6TcIRM5VnfyNVWYi3Y+RprRt33LlH2N?=
 =?us-ascii?Q?fQKeETJBTe/5v/Y3K3Oe4FSKPYDdBpQdvWVZuayhWxmnfgOGTLITiA8uwxB/?=
 =?us-ascii?Q?LGwi0U+imp74JpEAXyi1BI/r+UnVFRlBM2Ze0wiprqoJ8xoxgx3tTkKOpLtt?=
 =?us-ascii?Q?t7kLRFy1lpslnMhPVuii/iigvkdr4Y9Q0q08EN60B3YsfTzooTNtDtT4gpnp?=
 =?us-ascii?Q?JuKWiS6cyopEdFtVznR2ebIUR2Dsa1KKamcS+Y9tmYhS/uNkgvVUeo2xGI2q?=
 =?us-ascii?Q?NK/n6I/3BF/bkjeO2YzEYGPoz15WkTQVTvjHvV3+7QJt63M6uUhvaKmlhwh7?=
 =?us-ascii?Q?PaYFDUOwTQEDOZFpySd1vNWTQKspU0J25jEiX9lCSouDV2CP3vWi2SqDAA1T?=
 =?us-ascii?Q?dDRjgcqJUeNz2ykB+S0YkXFIqLhWq4Dyym8+d5gSv3dTXpUP4iMOwXly06lO?=
 =?us-ascii?Q?VL45VlfGJpTNSnwOKyLUBxz2Y+zE3HdK8DOr/1uapJ8zwUF6f40H7a2fs9Gb?=
 =?us-ascii?Q?59Ca27YgnwcP2xztVJXG5Zx5myYY2YiZ/KaTIVZhkEXkm97SClm/Q2y8FaEr?=
 =?us-ascii?Q?BguHB+vBS96UrPiGH7k3QgRHY/9XDGYzcnzvo4otwTiQeUEU2GPT8N7E1seS?=
 =?us-ascii?Q?tv+Of9tTw0JyWAk906bgkYl5AAZbHefa8TFSFkzUsc4zVBno2VE0CKnDlm1B?=
 =?us-ascii?Q?ktrFj/RxuQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b998a80-e399-42c8-21af-08ded5d0e05e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12302.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 11:23:42.8360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqzV2Mt1BezMhuGmlExJEQ52vputidHItkBHjNWuVDelFE2besU36MQE4UWJLVi0EpK1ncos0RSOeHIpd5o1yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8563
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302583-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:dkim,nxp.com:email,nxp.com:mid,nxp.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43F236D982D

This patch adds the bulk of the changes needed in order to support
offloading of an upper bond device.

First of all, handling of the NETDEV_CHANGEUPPER and
NETDEV_PRECHANGEUPPER events is extended so that the driver is capable
to handle joining or leaving an upper bond device.
All the restrictions around the LAG offload support are added in the
newly added dpaa2_switch_pre_lag_join() function.

The same events are extended to also detect if one of our upper bond
devices changes its own upper device. In this case, on each lower device
that is DPAA2 the corresponding dpaa2_switch_port_[pre]changeupper()
function will be called. This will start the process of joining the same
FDB as the one used by the bridge device.

Setting the 'offload_fwd_mark' field on the skbs is also extended to be
setup not only when the port is under a bridge but also under a bond
device that is offloaded.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v4:
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

Changes in v3:
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
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 473 +++++++++++++++++-
 .../ethernet/freescale/dpaa2/dpaa2-switch.h   |  15 +-
 2 files changed, 476 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 3472f5d5b08a..949a7241a00f 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -51,6 +51,17 @@ dpaa2_switch_filter_block_get_unused(struct ethsw_core *ethsw)
 	return NULL;
 }
 
+static struct dpaa2_switch_lag *
+dpaa2_switch_lag_get_unused(struct ethsw_core *ethsw)
+{
+	int i;
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
+		if (!ethsw->lags[i].in_use)
+			return &ethsw->lags[i];
+	return NULL;
+}
+
 static bool dpaa2_switch_fdb_in_use_by_others(struct ethsw_core *ethsw,
 					      struct dpaa2_switch_fdb *fdb,
 					      struct ethsw_port_priv *except)
@@ -2042,9 +2053,15 @@ static int dpaa2_switch_port_attr_set_event(struct net_device *netdev,
 static struct net_device *
 dpaa2_switch_port_to_bridge_port(struct ethsw_port_priv *port_priv)
 {
+	struct dpaa2_switch_lag *lag;
+
 	if (!port_priv->fdb->bridge_dev)
 		return NULL;
 
+	lag = rtnl_dereference(port_priv->lag);
+	if (lag)
+		return lag->bond_dev;
+
 	return port_priv->netdev;
 }
 
@@ -2193,30 +2210,53 @@ static int dpaa2_switch_port_bridge_leave(struct net_device *netdev)
 					  false);
 }
 
+static int
+dpaa2_switch_have_vlan_upper(struct net_device *upper_dev,
+			     __always_unused struct netdev_nested_priv *priv)
+{
+	return is_vlan_dev(upper_dev);
+}
+
 static int dpaa2_switch_prevent_bridging_with_8021q_upper(struct net_device *netdev)
 {
-	struct net_device *upper_dev;
-	struct list_head *iter;
+	struct netdev_nested_priv priv = {};
 
 	/* RCU read lock not necessary because we have write-side protection
-	 * (rtnl_mutex), however a non-rcu iterator does not exist.
+	 * (rtnl_mutex), however a non-rcu iterator does not exist. Walk the
+	 * entire upper chain so that a VLAN device stacked on a intermediate
+	 * bond is caught too.
 	 */
-	netdev_for_each_upper_dev_rcu(netdev, upper_dev, iter)
-		if (is_vlan_dev(upper_dev))
-			return -EOPNOTSUPP;
+	if (netdev_walk_all_upper_dev_rcu(netdev, dpaa2_switch_have_vlan_upper,
+					  &priv))
+		return -EOPNOTSUPP;
 
 	return 0;
 }
 
+static int dpaa2_switch_check_dpsw_instance(struct net_device *dev,
+					    struct netdev_nested_priv *priv)
+{
+	struct ethsw_port_priv *port_priv = (struct ethsw_port_priv *)priv->data;
+	struct ethsw_port_priv *other_priv = netdev_priv(dev);
+
+	if (!dpaa2_switch_port_dev_check(dev))
+		return 0;
+
+	if (other_priv->ethsw_data == port_priv->ethsw_data)
+		return 0;
+
+	return 1;
+}
+
 static int
 dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 					  struct net_device *upper_dev,
 					  struct netlink_ext_ack *extack)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
-	struct ethsw_port_priv *other_port_priv;
-	struct net_device *other_dev;
-	struct list_head *iter;
+	struct netdev_nested_priv data = {
+		.data = (void *)port_priv,
+	};
 	int err;
 
 	if (!br_vlan_enabled(upper_dev)) {
@@ -2231,6 +2271,70 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 		return err;
 	}
 
+	err = netdev_walk_all_lower_dev(upper_dev,
+					dpaa2_switch_check_dpsw_instance,
+					&data);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Interface from a different DPSW is in the bridge already");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int dpaa2_switch_pre_lag_join(struct net_device *netdev,
+				     struct net_device *upper_dev,
+				     struct netdev_lag_upper_info *info,
+				     struct netlink_ext_ack *extack)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct ethsw_port_priv *other_port_priv;
+	struct dpaa2_switch_lag *lag = NULL;
+	struct dpsw_lag_cfg cfg = {0};
+	struct net_device *other_dev;
+	int i, num_ifs = 0, err;
+	struct list_head *iter;
+
+	if (!(ethsw->features & ETHSW_FEATURE_LAG_OFFLOAD)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "LAG offload is supported only for DPSW >= v8.13");
+		return -EOPNOTSUPP;
+	}
+
+	if (info->tx_type != NETDEV_LAG_TX_TYPE_HASH) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can only offload LAG using hash TX type");
+		return -EOPNOTSUPP;
+	}
+
+	if (info->hash_type != NETDEV_LAG_HASH_L23) {
+		NL_SET_ERR_MSG_MOD(extack, "Can only offload L2+L3 Tx hash");
+		return -EOPNOTSUPP;
+	}
+
+	if (!dpaa2_switch_port_has_mac(port_priv)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only switch interfaces connected to MACs can be under a LAG");
+		return -EINVAL;
+	}
+
+	if (vlan_uses_dev(upper_dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot join a LAG upper that has a VLAN");
+		return -EOPNOTSUPP;
+	}
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		if (!ethsw->lags[i].in_use)
+			continue;
+		if (ethsw->lags[i].bond_dev != upper_dev)
+			continue;
+		lag = &ethsw->lags[i];
+		break;
+	}
+
 	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
 		if (!dpaa2_switch_port_dev_check(other_dev))
 			continue;
@@ -2238,11 +2342,229 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 		other_port_priv = netdev_priv(other_dev);
 		if (other_port_priv->ethsw_data != port_priv->ethsw_data) {
 			NL_SET_ERR_MSG_MOD(extack,
-					   "Interface from a different DPSW is in the bridge already");
+					   "Interface from a different DPSW is in the bond already");
+			return -EINVAL;
+		}
+
+		cfg.if_id[num_ifs++] = other_port_priv->idx;
+
+		if (num_ifs >= DPSW_MAX_LAG_IFS) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Cannot add more than 8 DPAA2 switch ports under the same bond");
 			return -EINVAL;
 		}
 	}
 
+	if (lag) {
+		cfg.group_id = lag->id;
+		cfg.if_id[num_ifs++] = port_priv->idx;
+		cfg.num_ifs = num_ifs;
+		cfg.phase = DPSW_LAG_SET_PHASE_CHECK;
+
+		err = dpsw_lag_set(ethsw->mc_io, 0, ethsw->dpsw_handle, &cfg);
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Cannot offload LAG configuration");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
+static void dpaa2_switch_port_set_lag_group(struct ethsw_port_priv *port_priv,
+					    struct net_device *bond_dev)
+{
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct ethsw_port_priv *other_port_priv = NULL;
+	struct dpaa2_switch_lag *lag = NULL;
+	struct dpaa2_switch_lag *other_lag;
+	struct net_device *other_dev;
+	struct list_head *iter;
+
+	netdev_for_each_lower_dev(bond_dev, other_dev, iter) {
+		if (!dpaa2_switch_port_dev_check(other_dev))
+			continue;
+
+		other_port_priv = netdev_priv(other_dev);
+		other_lag = rtnl_dereference(other_port_priv->lag);
+		if (!other_lag)
+			continue;
+
+		if (other_lag->bond_dev == bond_dev) {
+			rcu_assign_pointer(port_priv->lag, other_lag);
+			return;
+		}
+	}
+
+	/* This is the first interface to be added under a bond device. Find an
+	 * unused LAG group. No need to check for NULL since there are the same
+	 * amount of DPSW ports as LAG groups, meaning that each port can have
+	 * its own LAG group.
+	 */
+	lag = dpaa2_switch_lag_get_unused(ethsw);
+	lag->in_use = true;
+	lag->bond_dev = bond_dev;
+	lag->primary = port_priv;
+	rcu_assign_pointer(port_priv->lag, lag);
+}
+
+static bool dpaa2_switch_port_in_lag(struct ethsw_port_priv *port_priv,
+				     struct net_device *bond_dev)
+{
+	struct dpaa2_switch_lag *lag;
+
+	if (!port_priv)
+		return false;
+
+	lag = rtnl_dereference(port_priv->lag);
+	return lag && lag->bond_dev == bond_dev;
+}
+
+static int dpaa2_switch_set_lag_cfg(struct net_device *bond_dev, u8 lag_id,
+				    struct ethsw_core *ethsw)
+{
+	struct dpaa2_switch_lag *lag = &ethsw->lags[lag_id - 1];
+	struct ethsw_port_priv *primary, *new_primary = NULL;
+	struct ethsw_port_priv *port_priv = NULL;
+	struct dpsw_lag_cfg cfg = {0};
+	u8 num_ifs = 0;
+	int err, i;
+
+	cfg.group_id = lag_id;
+
+	/* Determine the primary port. The caller clears ->lag on the port that
+	 * is leaving, so a NULL ->lag on the current primary means it is the
+	 * one leaving: elect the first remaining member as the new primary.
+	 * Otherwise keep the current primary.
+	 */
+	if (rtnl_dereference(lag->primary->lag)) {
+		primary = lag->primary;
+	} else {
+		primary = NULL;
+		for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+			if (dpaa2_switch_port_in_lag(ethsw->ports[i], bond_dev)) {
+				new_primary = ethsw->ports[i];
+				primary = new_primary;
+				break;
+			}
+		}
+	}
+
+	/* Build the interface list, always placing the primary first */
+	if (primary)
+		cfg.if_id[num_ifs++] = primary->idx;
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		port_priv = ethsw->ports[i];
+		if (port_priv == primary)
+			continue;
+		if (!dpaa2_switch_port_in_lag(port_priv, bond_dev))
+			continue;
+
+		cfg.if_id[num_ifs++] = port_priv->idx;
+	}
+	cfg.num_ifs = num_ifs;
+
+	/* No more interfaces under this LAG group, mark it as not in use. Wait
+	 * for a grace period so that any readers of the lag structure finished.
+	 */
+	if (!num_ifs) {
+		synchronize_net();
+
+		lag->bond_dev = NULL;
+		lag->primary = NULL;
+		lag->in_use = false;
+	}
+
+	err = dpsw_lag_set(ethsw->mc_io, 0, ethsw->dpsw_handle, &cfg);
+	if (err)
+		return err;
+
+	if (new_primary) {
+		synchronize_net();
+		lag->primary = new_primary;
+	}
+
+	return 0;
+}
+
+static int dpaa2_switch_port_bond_join(struct net_device *netdev,
+				       struct net_device *bond_dev,
+				       struct netdev_lag_upper_info *info,
+				       struct netlink_ext_ack *extack)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct net_device *bridge_dev;
+	struct dpaa2_switch_lag *lag;
+	int err = 0;
+	u8 lag_id;
+
+	/* Setup the port_priv->lag pointer for this switch port */
+	dpaa2_switch_port_set_lag_group(port_priv, bond_dev);
+
+	/* Create the LAG configuration and apply it in MC */
+	lag = rtnl_dereference(port_priv->lag);
+	lag_id = lag->id;
+	err = dpaa2_switch_set_lag_cfg(bond_dev, lag_id, ethsw);
+	if (err)
+		goto err_lag_cfg;
+
+	/* If the bond device is a switch port, join the bridge as well */
+	bridge_dev = netdev_master_upper_dev_get(bond_dev);
+	if (!bridge_dev || !netif_is_bridge_master(bridge_dev))
+		return 0;
+
+	err = dpaa2_switch_port_bridge_join(netdev, bridge_dev, extack);
+	if (err)
+		goto err_lag_cfg;
+
+	return err;
+
+err_lag_cfg:
+	rcu_assign_pointer(port_priv->lag, NULL);
+	dpaa2_switch_set_lag_cfg(bond_dev, lag_id, ethsw);
+
+	return err;
+}
+
+static int dpaa2_switch_port_bond_leave(struct net_device *netdev,
+					struct net_device *bond_dev)
+{
+	struct net_device *bridge_dev = netdev_master_upper_dev_get(bond_dev);
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct dpaa2_switch_lag *lag = rtnl_dereference(port_priv->lag);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct net_device *brpdev;
+	bool learn_ena;
+	int err;
+
+	if (!lag)
+		return 0;
+
+	/* Recreate the LAG configuration for the LAG group that we left. */
+	rcu_assign_pointer(port_priv->lag, NULL);
+	dpaa2_switch_set_lag_cfg(bond_dev, lag->id, ethsw);
+
+	if (bridge_dev && netif_is_bridge_master(bridge_dev)) {
+		/* Make sure that the new primary inherits the learning state */
+		if (lag->primary) {
+			brpdev = dpaa2_switch_port_to_bridge_port(lag->primary);
+			learn_ena = br_port_flag_is_set(brpdev, BR_LEARNING);
+			err = dpaa2_switch_port_set_learning(lag->primary,
+							     learn_ena);
+			if (err)
+				return err;
+			lag->primary->learn_ena = learn_ena;
+		}
+
+		/* In case the bond is a bridge port, leave the upper bridge as
+		 * well.
+		 */
+		return dpaa2_switch_port_bridge_leave(netdev);
+	}
+
 	return 0;
 }
 
@@ -2250,8 +2572,8 @@ static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
 					    struct netdev_notifier_changeupper_info *info)
 {
 	struct ethsw_port_priv *port_priv;
+	struct net_device *upper_dev, *br;
 	struct netlink_ext_ack *extack;
-	struct net_device *upper_dev;
 	int err;
 
 	if (!dpaa2_switch_port_dev_check(netdev))
@@ -2268,6 +2590,24 @@ static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
 
 		if (!info->linking)
 			dpaa2_switch_port_pre_bridge_leave(netdev);
+	} else if (netif_is_lag_master(upper_dev)) {
+		if (!info->linking) {
+			if (netif_is_bridge_port(upper_dev))
+				dpaa2_switch_port_pre_bridge_leave(netdev);
+			return 0;
+		}
+
+		if (netif_is_bridge_port(upper_dev)) {
+			br = netdev_master_upper_dev_get(upper_dev);
+			err = dpaa2_switch_prechangeupper_sanity_checks(netdev,
+									br,
+									extack);
+			if (err)
+				return err;
+		}
+
+		return dpaa2_switch_pre_lag_join(netdev, upper_dev,
+						 info->upper_info, extack);
 	} else if (is_vlan_dev(upper_dev)) {
 		port_priv = netdev_priv(netdev);
 		if (port_priv->fdb->bridge_dev) {
@@ -2299,6 +2639,80 @@ static int dpaa2_switch_port_changeupper(struct net_device *netdev,
 							     extack);
 		else
 			return dpaa2_switch_port_bridge_leave(netdev);
+	} else if (netif_is_lag_master(upper_dev)) {
+		if (info->linking)
+			return dpaa2_switch_port_bond_join(netdev, upper_dev,
+							   info->upper_info,
+							   extack);
+		else
+			return dpaa2_switch_port_bond_leave(netdev, upper_dev);
+	}
+
+	return 0;
+}
+
+static int
+dpaa2_switch_lag_prechangeupper(struct net_device *netdev,
+				struct netdev_notifier_changeupper_info *info)
+{
+	struct net_device *lower;
+	struct list_head *iter;
+	int err = 0;
+
+	if (!netif_is_lag_master(netdev))
+		return 0;
+
+	netdev_for_each_lower_dev(netdev, lower, iter) {
+		if (!dpaa2_switch_port_dev_check(lower))
+			continue;
+
+		err = dpaa2_switch_port_prechangeupper(lower, info);
+		if (err)
+			return err;
+	}
+
+	return err;
+}
+
+static int
+dpaa2_switch_lag_changeupper(struct net_device *netdev,
+			     struct netdev_notifier_changeupper_info *info)
+{
+	struct net_device *lower;
+	struct list_head *iter;
+	int err = 0;
+
+	if (!netif_is_lag_master(netdev))
+		return 0;
+
+	netdev_for_each_lower_dev(netdev, lower, iter) {
+		if (!dpaa2_switch_port_dev_check(lower))
+			continue;
+
+		err = dpaa2_switch_port_changeupper(lower, info);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int
+dpaa2_switch_port_changelowerstate(struct net_device *netdev,
+				   struct netdev_lag_lower_state_info *linfo)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	int err;
+
+	if (!rtnl_dereference(port_priv->lag))
+		return 0;
+
+	err = dpsw_if_set_lag_state(ethsw->mc_io, 0, ethsw->dpsw_handle,
+				    port_priv->idx, linfo->tx_enabled ? 1 : 0);
+	if (err) {
+		netdev_err(netdev, "dpsw_if_set_lag_state() = %d\n", err);
+		return err;
 	}
 
 	return 0;
@@ -2308,6 +2722,7 @@ static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
 					     unsigned long event, void *ptr)
 {
 	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_notifier_changelowerstate_info *info;
 	int err = 0;
 
 	switch (event) {
@@ -2316,13 +2731,29 @@ static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
 		if (err)
 			return notifier_from_errno(err);
 
+		err = dpaa2_switch_lag_prechangeupper(netdev, ptr);
+		if (err)
+			return notifier_from_errno(err);
+
 		break;
 	case NETDEV_CHANGEUPPER:
 		err = dpaa2_switch_port_changeupper(netdev, ptr);
 		if (err)
 			return notifier_from_errno(err);
 
+		err = dpaa2_switch_lag_changeupper(netdev, ptr);
+		if (err)
+			return notifier_from_errno(err);
+
 		break;
+	case NETDEV_CHANGELOWERSTATE:
+		info = ptr;
+		if (!dpaa2_switch_port_dev_check(netdev))
+			break;
+
+		err = dpaa2_switch_port_changelowerstate(netdev,
+							 info->lower_state_info);
+		return notifier_from_errno(err);
 	}
 
 	return NOTIFY_DONE;
@@ -2581,6 +3012,9 @@ static void dpaa2_switch_detect_features(struct ethsw_core *ethsw)
 
 	if (ethsw->major > 8 || (ethsw->major == 8 && ethsw->minor >= 6))
 		ethsw->features |= ETHSW_FEATURE_MAC_ADDR;
+
+	if (ethsw->major > 8 || (ethsw->major == 8 && ethsw->minor >= 13))
+		ethsw->features |= ETHSW_FEATURE_LAG_OFFLOAD;
 }
 
 static int dpaa2_switch_setup_fqs(struct ethsw_core *ethsw)
@@ -3370,6 +3804,7 @@ static void dpaa2_switch_remove(struct fsl_mc_device *sw_dev)
 	kfree(ethsw->fdbs);
 	kfree(ethsw->filter_blocks);
 	kfree(ethsw->ports);
+	kfree(ethsw->lags);
 
 	dpaa2_switch_teardown(sw_dev);
 
@@ -3397,6 +3832,7 @@ static int dpaa2_switch_probe_port(struct ethsw_core *ethsw,
 	port_priv = netdev_priv(port_netdev);
 	port_priv->netdev = port_netdev;
 	port_priv->ethsw_data = ethsw;
+	rcu_assign_pointer(port_priv->lag, NULL);
 
 	mutex_init(&port_priv->mac_lock);
 
@@ -3504,6 +3940,19 @@ static int dpaa2_switch_probe(struct fsl_mc_device *sw_dev)
 		goto err_free_fdbs;
 	}
 
+	ethsw->lags = kcalloc(ethsw->sw_attr.num_ifs, sizeof(*ethsw->lags),
+			      GFP_KERNEL);
+	if (!ethsw->lags) {
+		err = -ENOMEM;
+		goto err_free_filter;
+	}
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		ethsw->lags[i].bond_dev = NULL;
+		ethsw->lags[i].ethsw = ethsw;
+		ethsw->lags[i].id = i + 1;
+		ethsw->lags[i].in_use = 0;
+	}
+
 	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
 		err = dpaa2_switch_probe_port(ethsw, i);
 		if (err)
@@ -3550,6 +3999,8 @@ static int dpaa2_switch_probe(struct fsl_mc_device *sw_dev)
 err_free_netdev:
 	for (i--; i >= 0; i--)
 		dpaa2_switch_remove_port(ethsw, i);
+	kfree(ethsw->lags);
+err_free_filter:
 	kfree(ethsw->filter_blocks);
 err_free_fdbs:
 	kfree(ethsw->fdbs);
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
index 42b3ca73f55d..c98bddd7e359 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
@@ -41,7 +41,8 @@
 #define ETHSW_MAX_FRAME_LENGTH	(DPAA2_MFL - VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define ETHSW_L2_MAX_FRM(mtu)	((mtu) + VLAN_ETH_HLEN + ETH_FCS_LEN)
 
-#define ETHSW_FEATURE_MAC_ADDR	BIT(0)
+#define ETHSW_FEATURE_MAC_ADDR		BIT(0)
+#define ETHSW_FEATURE_LAG_OFFLOAD	BIT(1)
 
 /* Number of receive queues (one RX and one TX_CONF) */
 #define DPAA2_SWITCH_RX_NUM_FQS	2
@@ -105,6 +106,14 @@ struct dpaa2_switch_fdb {
 	bool			in_use;
 };
 
+struct dpaa2_switch_lag {
+	struct ethsw_core	*ethsw;
+	struct net_device	*bond_dev;
+	bool			in_use;
+	u8			id;
+	struct ethsw_port_priv	*primary;
+};
+
 struct dpaa2_switch_acl_entry {
 	struct list_head	list;
 	u16			prio;
@@ -163,6 +172,8 @@ struct ethsw_port_priv {
 	struct dpaa2_mac	*mac;
 	/* Protects against changes to port_priv->mac */
 	struct mutex		mac_lock;
+
+	struct dpaa2_switch_lag __rcu *lag;
 };
 
 /* Switch data */
@@ -190,6 +201,8 @@ struct ethsw_core {
 	struct dpaa2_switch_fdb		*fdbs;
 	struct dpaa2_switch_filter_block *filter_blocks;
 	u16				mirror_port;
+
+	struct dpaa2_switch_lag		*lags;
 };
 
 static inline int dpaa2_switch_get_index(struct ethsw_core *ethsw,
-- 
2.25.1


