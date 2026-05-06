Return-Path: <netdev+bounces-284906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMe1IFBd+2n2aAMAu9opvQ
	(envelope-from <netdev+bounces-284906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:25:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC364DD280
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8E70305FD2B
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F4549550A;
	Wed,  6 May 2026 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dAMFfGSQ"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999914921AF;
	Wed,  6 May 2026 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080596; cv=fail; b=IEQyBfoYloDu4UesQHgPTW7CjwBbjWE6lKhSkFx/WasT7opT2vNacD4t4nukUhIOUpsnS7/dxHbxRLzCdMOv40LCfA9cZjwEQSVakIKJVUVi3z/rQV7EBbJv7SYfsBr1sHL0MRlZw19EFyjsQbAVORAAN9uBXTw1CzjbqL8OsF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080596; c=relaxed/simple;
	bh=ScAjFihVFXkt4m3saqKZw7N58l0msADKnkdkFN3RXlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hms1nbmkqghkhXHVQNkkASpQP7C4jJjCdv8QON5pEqhactsKJIVGwFC+59/ryDJByFX7N2eilmq4ae96qBh4S7hTe9rpmY1fv649lqctvU2NGw3fZfqk2xR5B4RDDhNIbV2a9xeoPCkgBE9RqDktlJsowDMEkTq4H4N/4W+xBS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dAMFfGSQ; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRdC8q9cwt3NISrd0ltjPpNZWiAsbn84oAsIU1qjx5cnoOdXRA50sMaRwaD6HYTsVUDnD82UFxMGnwtHZeKKlieha9pNGfEvEOmL5aycm6fB/Rz3zl5BP+kh3g23iM8jbzKrrjS6+alZPt/u66LtOHBasznZ7pEeki+rVgtyxha18ezg0OQKcV1hJB4AJOQfPEV8yhcpKXJq/ZsL5wPsexxcwg0ZmPSF6LwEZb4QptQJ+a+xPfhuOwZg9czSYrg4ODO1gfdjmuH/ycogW6jLoUNyj/jetFcTtdfCg02qMFjOIa855bkAx0H7Q+zV7IWiRyd1ey5xLzBqOrHy72IIcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JE5IS6IxVZdWVj1he44bNGH/hOoTwKUrlEGwWg9W3LM=;
 b=y46xoGHT9OeQO2ZD9Oh2qjNTdyuwq2qjX9ZSd4hjg5ntLq5TasZUv4UQalkzV2sJRDAZjpfRp8WJC88S3g+4vRfocntv9c+Mpgxit+5iskhQZnpfi6msksVkG+s3V2dNoASGL8kkoXpbrbHDvI77qKdWRGJQQLfLL/sSD5ZLOBzK87qeDR70GvUmpPGI72dwj5MTcDBeGPQ6A2doFOM3vmJaNH+7HL+d8un/3K5nkzvOIyD4BcHyShqUqlcf/24pSlarEnqzZnxfHfutyKxIyLrC58AqNsKQMPTjwSvk7u5w7qonUxciv8wvKxLKXTDB4j+Ctq0IDXo3DZwRut8gdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JE5IS6IxVZdWVj1he44bNGH/hOoTwKUrlEGwWg9W3LM=;
 b=dAMFfGSQay37XlMPqo5Q/L4eHym4ftW4q2gKU7IYizPYKckPVLl248H/yYlWyDnUnCq2MhuXZBH7BWGJOhkI4OvEKMVrSg1bd9powtbkGjtHiHOg9ea51YSr8/rMRaDSG4aBrp3c4/7WiEoF5or6l0fRGRQwfa1qxieOadAqvqesn/q8WS1FR7KikaNV7eiVcF177xRA9mNt5wE9bgfzqT/U7mtafYNi2DY1o6u8nzxMaP8MOFazB2/Oa5bONkg1o7sgvkbpil0HCTpx8gtzsuXBolLyuIfnHzpxECGLitM73ExXitMFOtGWA/CNyi35t96II4/eOIXnb6SIAf6Qfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by AS8PR04MB8277.eurprd04.prod.outlook.com
 (2603:10a6:20b:3fc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 15:16:18 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 15:16:18 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 09/13] dpaa2-switch: offload FDBs added on an upper bond device
Date: Wed,  6 May 2026 18:15:36 +0300
Message-Id: <20260506151540.1242997-10-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0012.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::15) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 143b1ca2-56c1-4544-22f5-08deab826c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hQwo/kWykMFHN2dA73UC68J3ikTGRFffxfTGistVDeyUH+vXJ5UhNx2hKZpR9kC9Z/Rr7HOZb7QHFqv5mnyfTaxFsc4w5THEjyz2dqZAr7aRbzo59pwyet/r6KJ2aHKY/wAFNtZw01KAax8S5rCL3JRp/jRTQpfFcLyCzcZriB6GGhjLYeOMdTos2AQCHc/KxDP/2f9mvPpAsDXHOzWrmUFNIpS5h3uOK2BjwavWOajFzhWOxcfROdxE7CKMog6+t0cQAQJBizPhXnbBDXA8i2bOIaOYKPMX/RGdUW810ExKdo67nZ2qVP0HOeLoFnS51g/OtN9bC05j/elCdQbMyz/OiDX2DJqBPSvU+QieIP8Kr0Mn0ZU/+1ISaj/zJBhQMS4OeVZ5e7txTwKoqxwQUXw6PFrhAiVeLzxqpRz9q4Jo4IVUf5J885OG6UZ68Xxdw+K+E5Pn8yr44tcvT4UfizIQ9R33ocXRu+C14DiplD4m9wBcSt2xG1ATbFP3Mu+GBbeFDdF/9eK33QvXksHtBNI9woi1j1VwkhygjDyLlgRhIhJ+Zsv26LCN+tJw5zJfmVq5PrHr7qvm4m3JpGQHwA6cRBDroV+ys+bsu4Lrkgc+MzxMNUHavam7cteeVrPKQKwZHjK5k3UjRM0Ifes72552ZLRQ4rD2rpJoatqwHwMNsm2XldVW6lzq7876XqHy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lWRna0D8IcGJetgxV9CzyPGMDv3qOLNvA0oDs7O5PWrpR1SBWeAKRt0tcFp/?=
 =?us-ascii?Q?n3O//p5SDEWgclWa/5yp8Jxpolg6CLFNcSzErmDF2Y5VMTiryd21bOfv3Gg1?=
 =?us-ascii?Q?/SwRhfzOuydP2pQQAJAMAsM/odjy+kkZvaoTOWNH11ommG4FCTuq+Rv7YSIt?=
 =?us-ascii?Q?pjcbzrh+zG4YIQWfzQPN9lMdg43hjqZOWy76iX+yM65Nwxl8fdXRV3DVWJRJ?=
 =?us-ascii?Q?MMZDQK4gvNSB+lrvUqx5wyr61lbfPJ/tIU6i2YFk4QQJyE3FtmG2sQ3yrn06?=
 =?us-ascii?Q?+6qP0P/thudtYWJklpkcq7BVDSWt14z0eFTHkyYw8Ucn6XF1nkqFwHGSdOdp?=
 =?us-ascii?Q?gy58hvSQlWnP14xO0QFbJcwzU4dVyDTT9fGcOfGOaN0d9IQybfYI1DRm0a2W?=
 =?us-ascii?Q?85SSp1uP/tbdwghDITAWkG8kv++jlMwXwOppG3cGgzmYAKlqPR3fJBLoU4dt?=
 =?us-ascii?Q?Y60CCii0RUy2oPI1geDyGNssuDU0tFLbohuL2CZYXdTNqb4fvw47bWaRQjht?=
 =?us-ascii?Q?ZX7uFMYGXeMiVbbKMHUcqLGmMBRpSfDb0EkjsSAvDZxyHl/a2af8eU2tz4lB?=
 =?us-ascii?Q?e8Cr+C/9bhBnhACSo912r7w1jYRYu5R3oZZqLCGoWHLwkW9dRNs2qbhCsu2j?=
 =?us-ascii?Q?2vleQ1R9oz3SQSTqYFp/p4hJl/75wg/J+0h0zmuUIDNfOy62Our1HHpZ6a+P?=
 =?us-ascii?Q?axNj2oqlvJKmKgTu5VlPz8qu9WAAM3rSu8G6irdG2S0bqgidJx3IsTW8Udtu?=
 =?us-ascii?Q?hrFOELMsJiX+WVVgMIMgPhYqWC331s2JOSgxp8zMgpYKymmoeD0C07QN9GQr?=
 =?us-ascii?Q?fuNC+apxqssMnBL66PPWWkxhncBfu9ATRX65flA9oHZOIy9AdmxV+htocY3F?=
 =?us-ascii?Q?q6iHuqSakx+509TtoJt0M66QK7A9bpZz+ExGsJrM4L5LEb5OWJxFMRhsHju/?=
 =?us-ascii?Q?7waC76osAz6YzZlOp0yJy4u4One/GA2awIhzxALhrkf5pRyLAHl0hpnNRdv1?=
 =?us-ascii?Q?4AculQo86dnPNnCLOHTTrl+qDoUVs85wMcA4OzXgq5K790IgPsY/t4jbVOKz?=
 =?us-ascii?Q?js2OzmNM//fV5sNORnoCYqy4KQLbw3GapXEn/ZarLdixxNKrLJqlhUZki/vG?=
 =?us-ascii?Q?5PhLXUFaYrKktuXSgRIuSxdmvS73Ql8hzhl+emvgC4kLhTk9lUDbOdeecfw1?=
 =?us-ascii?Q?03b8rK4bwOJg3aCnyTSOYsMUQFg+ClTLyi+H8QWvjb7h3YSOmd6LkPZApAVy?=
 =?us-ascii?Q?pBKJLod9JOLbJkCXYFrSBVFasN2dB6lrcAkEQEM5+pfpsFZDdbM7Thjeqqk8?=
 =?us-ascii?Q?Z0vVCwPBfNCY1i0C/O2JQ6WvcqJr++Ur3FQnwdbq5J+UHxjX926EodhF7ucJ?=
 =?us-ascii?Q?TJ92DrEWBWJ7xVU406paWc1mBpARsvxq5cHMeNv8htkpA0JZw/sIBNpa9r5r?=
 =?us-ascii?Q?vV8tYdWuA9JjA9hVIP0Ld/E6x2MlkutucOY5tZ1GS8d7Zewszr5128GdHVfe?=
 =?us-ascii?Q?vpF8g7QBLMCvorCN8Ofh3h0rllH/Jjgbd3TVIq/B6V5Mq79059QkzTd3wDRH?=
 =?us-ascii?Q?Gpz6W4DBA/ZlATs93c7h7NtU5997oAbI0Sh8WTXYybDkqpQgSPXNeHj0zAED?=
 =?us-ascii?Q?abPd6cdaCD24ow+5Ilp8U69FaDnhGiTFLOpo5iTzCIjv3JGTq19pZwlXMqK3?=
 =?us-ascii?Q?wTO2Cn632K3/ZvqXLvN1iXJJiAsxt7u4pVePgw75Nwf4aCsPkzUds9aFwYl5?=
 =?us-ascii?Q?stJVn+J5pw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143b1ca2-56c1-4544-22f5-08deab826c6b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:16:18.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMTAlkY0USj98cbX4FbkDTdUDoFgwIPK2PBqz2sk8YqvEq0y4zU4rdKsomEnK07tYiMR5k/TdO0X1xqTikULhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277
X-Rspamd-Queue-Id: 7CC364DD280
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
	TAGGED_FROM(0.00)[bounces-284906-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

This patch adds support for offloading FDB entries added on upper bond
devices.

First of all, the call to switchdev_bridge_port_offload() is updated so
that the notifier blocks needed for FDB events replay are available to
the bridge core.

Using switchdev_handle_*() helpers is also necessary because each FDB
event needs to be fanned out to any DPAA2 switch lower device. This
triggers another change in the return type used by the
dpaa2_switch_port_fdb_event() - from notifier types to regular errno
types.

Handling of the SWITCHDEV_FDB_ADD_TO_DEVICE/SWITCHDEV_FDB_DEL_TO_DEVICE
events is updated so that the newly dpaa2_switch_lag_fdb_add() /
dpaa2_switch_lag_fdb_del() functions are called anytime a port is under
a bond device. This will allow us to manage refcounting on FDB entries
which are added on the upper bond devices.

The DPAA2 switch uses shared-VLAN learning which means that the vid
parameter is not used when adding an FDB entry to HW. The current
behavior when dealing with FDB entries with the same MAC address but
different VLANs is to add the entry to HW every time while removal will
get done on the first 'bridge fdb del' command issued by the user.

The same behavior is kept also for FDBs added on bond devices by keeping
the refcount on the {vid, addr} pair while the HW operation disregards
entirely the vid parameter.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 190 ++++++++++++++++--
 .../ethernet/freescale/dpaa2/dpaa2-switch.h   |  22 ++
 2 files changed, 193 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index bced37335a9e..cce0af47ca07 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -25,6 +25,9 @@
 
 #define DEFAULT_VLAN_ID			1
 
+static struct notifier_block dpaa2_switch_port_switchdev_nb;
+static struct notifier_block dpaa2_switch_port_switchdev_blocking_nb;
+
 static u16 dpaa2_switch_port_get_fdb_id(struct ethsw_port_priv *port_priv)
 {
 	return port_priv->fdb->fdb_id;
@@ -62,6 +65,25 @@ dpaa2_switch_lag_get_unused(struct ethsw_core *ethsw)
 	return NULL;
 }
 
+static struct ethsw_port_priv *
+dpaa2_switch_lag_get_primary(struct dpaa2_switch_lag *lag)
+{
+	struct ethsw_core *ethsw = lag->ethsw;
+	struct ethsw_port_priv *port_priv;
+	int i;
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		port_priv = ethsw->ports[i];
+		if (!port_priv)
+			continue;
+
+		if (port_priv->lag == lag)
+			return port_priv;
+	}
+
+	return NULL;
+}
+
 static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 				      struct net_device *upper_dev,
 				      bool linking)
@@ -573,6 +595,91 @@ static int dpaa2_switch_port_fdb_del(struct ethsw_port_priv *port_priv,
 		return dpaa2_switch_port_fdb_del_mc(port_priv, addr);
 }
 
+static struct dpaa2_mac_addr *
+dpaa2_switch_mac_addr_find(struct list_head *addr_list,
+			   const unsigned char *addr, u16 vid)
+{
+	struct dpaa2_mac_addr *a;
+
+	list_for_each_entry(a, addr_list, list)
+		if (ether_addr_equal(a->addr, addr) && a->vid == vid)
+			return a;
+
+	return NULL;
+}
+
+static int dpaa2_switch_lag_fdb_add(struct dpaa2_switch_lag *lag,
+				    const unsigned char *addr, u16 vid)
+{
+	struct ethsw_port_priv *port_priv;
+	struct dpaa2_mac_addr *a;
+	int err = 0;
+
+	mutex_lock(&lag->fdb_lock);
+
+	a = dpaa2_switch_mac_addr_find(&lag->fdbs, addr, vid);
+	if (a) {
+		refcount_inc(&a->refcount);
+		goto out;
+	}
+
+	port_priv = dpaa2_switch_lag_get_primary(lag);
+	if (!port_priv) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	a = kzalloc(sizeof(*a), GFP_KERNEL);
+	if (!a) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = dpaa2_switch_port_fdb_add(port_priv, addr);
+	if (err) {
+		kfree(a);
+		goto out;
+	}
+
+	ether_addr_copy(a->addr, addr);
+	a->vid = vid;
+	refcount_set(&a->refcount, 1);
+	list_add_tail(&a->list, &lag->fdbs);
+
+out:
+	mutex_unlock(&lag->fdb_lock);
+
+	return err;
+}
+
+static void dpaa2_switch_lag_fdb_del(struct dpaa2_switch_lag *lag,
+				     const unsigned char *addr, u16 vid)
+{
+	struct ethsw_port_priv *port_priv;
+	struct dpaa2_mac_addr *a;
+
+	mutex_lock(&lag->fdb_lock);
+
+	a = dpaa2_switch_mac_addr_find(&lag->fdbs, addr, vid);
+	if (!a)
+		goto out;
+
+	port_priv = dpaa2_switch_lag_get_primary(lag);
+	if (!port_priv)
+		goto out;
+
+	if (!refcount_dec_and_test(&a->refcount))
+		goto out;
+
+	dpaa2_switch_port_fdb_del(port_priv, addr);
+
+	list_del(&a->list);
+	kfree(a);
+
+out:
+	mutex_unlock(&lag->fdb_lock);
+}
+
 static void dpaa2_switch_port_get_stats(struct net_device *netdev,
 					struct rtnl_link_stats64 *stats)
 {
@@ -1520,6 +1627,22 @@ bool dpaa2_switch_port_dev_check(const struct net_device *netdev)
 	return netdev->netdev_ops == &dpaa2_switch_port_ops;
 }
 
+static bool dpaa2_switch_foreign_dev_check(const struct net_device *dev,
+					   const struct net_device *foreign_dev)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(dev);
+
+	if (netif_is_bridge_master(foreign_dev))
+		if (port_priv->fdb->bridge_dev == foreign_dev)
+			return false;
+
+	if (netif_is_bridge_port(foreign_dev))
+		return !dpaa2_switch_port_offloads_bridge_port(port_priv,
+							       foreign_dev);
+
+	return true;
+}
+
 static int dpaa2_switch_port_connect_mac(struct ethsw_port_priv *port_priv)
 {
 	struct fsl_mc_device *dpsw_port_dev, *dpmac_dev;
@@ -2145,8 +2268,10 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 		goto err_egress_flood;
 
 	brport_dev = dpaa2_switch_port_to_bridge_port(port_priv);
-	err = switchdev_bridge_port_offload(brport_dev, netdev, NULL,
-					    NULL, NULL, false, extack);
+	err = switchdev_bridge_port_offload(brport_dev, netdev, port_priv,
+					    &dpaa2_switch_port_switchdev_nb,
+					    &dpaa2_switch_port_switchdev_blocking_nb,
+					    false, extack);
 	if (err)
 		goto err_switchdev_offload;
 
@@ -2731,7 +2856,9 @@ struct ethsw_switchdev_event_work {
 	struct work_struct work;
 	struct switchdev_notifier_fdb_info fdb_info;
 	struct net_device *dev;
+	struct net_device *orig_dev;
 	unsigned long event;
+	u16 vid;
 };
 
 static void dpaa2_switch_event_work(struct work_struct *work)
@@ -2739,6 +2866,7 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 	struct ethsw_switchdev_event_work *switchdev_work =
 		container_of(work, struct ethsw_switchdev_event_work, work);
 	struct net_device *dev = switchdev_work->dev;
+	struct ethsw_port_priv *port_priv = netdev_priv(dev);
 	struct switchdev_notifier_fdb_info *fdb_info;
 	int err;
 
@@ -2747,16 +2875,26 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 
 	switch (switchdev_work->event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
-		err = dpaa2_switch_port_fdb_add(netdev_priv(dev),
-						fdb_info->addr);
+		if (port_priv->lag)
+			err = dpaa2_switch_lag_fdb_add(port_priv->lag,
+						       fdb_info->addr,
+						       switchdev_work->vid);
+		else
+			err = dpaa2_switch_port_fdb_add(netdev_priv(dev),
+							fdb_info->addr);
 		if (err)
 			break;
 		fdb_info->offloaded = true;
-		call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED, dev,
+		call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED,
+					 switchdev_work->orig_dev,
 					 &fdb_info->info, NULL);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		dpaa2_switch_port_fdb_del(netdev_priv(dev), fdb_info->addr);
+		if (port_priv->lag)
+			dpaa2_switch_lag_fdb_del(port_priv->lag, fdb_info->addr,
+						 switchdev_work->vid);
+		else
+			dpaa2_switch_port_fdb_del(port_priv, fdb_info->addr);
 		break;
 	}
 
@@ -2766,33 +2904,40 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 	dev_put(dev);
 }
 
-static int dpaa2_switch_port_fdb_event(struct notifier_block *nb,
-				       unsigned long event, void *ptr)
+static int
+dpaa2_switch_port_fdb_event(struct net_device *dev,
+			    struct net_device *orig_dev,
+			    unsigned long event, const void *ctx,
+			    const struct switchdev_notifier_fdb_info *fdb_info)
 {
-	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
 	struct ethsw_port_priv *port_priv = netdev_priv(dev);
 	struct ethsw_switchdev_event_work *switchdev_work;
-	struct switchdev_notifier_fdb_info *fdb_info = ptr;
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 
-	if (!dpaa2_switch_port_dev_check(dev))
-		return NOTIFY_DONE;
+	if (ctx && ctx != port_priv)
+		return 0;
+
+	/* For the moment, do nothing with entries towards foreign devices */
+	if (dpaa2_switch_foreign_dev_check(dev, orig_dev))
+		return 0;
 
 	if (!fdb_info->added_by_user || fdb_info->is_local)
-		return NOTIFY_DONE;
+		return 0;
 
 	switchdev_work = kzalloc_obj(*switchdev_work, GFP_ATOMIC);
 	if (!switchdev_work)
-		return NOTIFY_BAD;
+		return -ENOMEM;
 
 	INIT_WORK(&switchdev_work->work, dpaa2_switch_event_work);
 	switchdev_work->dev = dev;
 	switchdev_work->event = event;
+	switchdev_work->orig_dev = orig_dev;
+	switchdev_work->vid = fdb_info->vid;
 
 	switch (event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		memcpy(&switchdev_work->fdb_info, ptr,
+		memcpy(&switchdev_work->fdb_info, fdb_info,
 		       sizeof(switchdev_work->fdb_info));
 		switchdev_work->fdb_info.addr = kzalloc(ETH_ALEN, GFP_ATOMIC);
 		if (!switchdev_work->fdb_info.addr)
@@ -2806,16 +2951,16 @@ static int dpaa2_switch_port_fdb_event(struct notifier_block *nb,
 		break;
 	default:
 		kfree(switchdev_work);
-		return NOTIFY_DONE;
+		return 0;
 	}
 
 	queue_work(ethsw->workqueue, &switchdev_work->work);
 
-	return NOTIFY_DONE;
+	return 0;
 
 err_addr_alloc:
 	kfree(switchdev_work);
-	return NOTIFY_BAD;
+	return -ENOMEM;
 }
 
 /* Called under rcu_read_lock() */
@@ -2823,13 +2968,18 @@ static int dpaa2_switch_port_event(struct notifier_block *nb,
 				   unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	int err;
 
 	switch (event) {
 	case SWITCHDEV_PORT_ATTR_SET:
 		return dpaa2_switch_port_attr_set_event(dev, ptr);
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		return dpaa2_switch_port_fdb_event(nb, event, ptr);
+		err = switchdev_handle_fdb_event_to_device(dev, event, ptr,
+							   dpaa2_switch_port_dev_check,
+							   dpaa2_switch_foreign_dev_check,
+							   dpaa2_switch_port_fdb_event);
+		return notifier_from_errno(err);
 	default:
 		return NOTIFY_DONE;
 	}
@@ -3917,6 +4067,8 @@ static int dpaa2_switch_probe(struct fsl_mc_device *sw_dev)
 		ethsw->lags[i].ethsw = ethsw;
 		ethsw->lags[i].id = i + 1;
 		ethsw->lags[i].in_use = 0;
+		mutex_init(&ethsw->lags[i].fdb_lock);
+		INIT_LIST_HEAD(&ethsw->lags[i].fdbs);
 	}
 
 	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
index 56debbdefd13..96d780980d77 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
@@ -100,6 +100,13 @@ struct dpaa2_switch_fq {
 	u32 fqid;
 };
 
+struct dpaa2_mac_addr {
+	unsigned char addr[ETH_ALEN];
+	u16 vid;
+	refcount_t refcount;
+	struct list_head list;
+};
+
 struct dpaa2_switch_fdb {
 	struct net_device	*bridge_dev;
 	u16			fdb_id;
@@ -111,6 +118,9 @@ struct dpaa2_switch_lag {
 	struct net_device	*bond_dev;
 	bool			in_use;
 	u8			id;
+	/* Protects the list of fdbs installed on this LAG */
+	struct mutex		fdb_lock;
+	struct list_head	fdbs;
 };
 
 struct dpaa2_switch_acl_entry {
@@ -286,4 +296,16 @@ int dpaa2_switch_block_offload_mirror(struct dpaa2_switch_filter_block *block,
 
 int dpaa2_switch_block_unoffload_mirror(struct dpaa2_switch_filter_block *block,
 					struct ethsw_port_priv *port_priv);
+
+static inline bool
+dpaa2_switch_port_offloads_bridge_port(struct ethsw_port_priv *port_priv,
+				       const struct net_device *dev)
+{
+	if (port_priv->lag && port_priv->lag->bond_dev == dev)
+		return true;
+	if (port_priv->netdev == dev)
+		return true;
+	return false;
+}
+
 #endif	/* __ETHSW_H */
-- 
2.25.1


