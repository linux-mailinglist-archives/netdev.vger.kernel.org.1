Return-Path: <netdev+bounces-267097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BNLCA/NsmmPPwAAu9opvQ
	(envelope-from <netdev+bounces-267097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:26:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C915827352E
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50E583062433
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D246A36C0DD;
	Thu, 12 Mar 2026 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="crk0iNG5"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010046.outbound.protection.outlook.com [52.101.69.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D517636C9F4;
	Thu, 12 Mar 2026 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325396; cv=fail; b=efZSWNGCTZihHcZME3R7xPy79x8JIcUy+tF/olDyg8Cjo+HUmpXIsqk2LWw333BnIvTd/klkOUChiUExfEDzhDs2yMe/AQLpPM33Y82Y4bWej76A+7nPB408t3eu9h6f8RYmUxSrh8RKKQs74Ldotjz/aUAtoWJlW6EYoyGns00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325396; c=relaxed/simple;
	bh=rZxtTItYiWfVO3XK63xser3x2FiNy1HafejcTJsUous=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dCstEjdB2XdEPpN0GoOhbAQRPUu13CZYxdO7e3m1nodOLgCbeT4p09pCECEnzBztsUIEfz+ha2/J4KB0Yk/tFGGLXjHgHyetx8K6GCG+CDXUzIxThdwEGpvaUkqTxzLk9p4IJdWGaY12LK+1Xz0hmU7UFbMx2I+lMsG/bVrv3MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=crk0iNG5; arc=fail smtp.client-ip=52.101.69.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwY+OjuB1XXUTWiLKXgQHIDOeiKokFapR6quBkJTow48r+NNtpEhLe8050gQ4gTD2LqpB2xL8Nj84wkp+hhrKXuc5OPZcwVqlfKINn9mXFjUjF76I7ALwMG4m70MheQ8Mr+BRPdlWRPuwJvParY1CoFgiD3UGDp+411N9Z7jKf2RCkFfSmz8+7cA5hzl2aTxj+9pNF91GFuFU7uZI22pqa90Y/TPwFGc8zuHTgDvpa9xTLY5co1O0319K7tzi3TC78Cpcj8dKhXt1bhPXo+BrwCsDpvYdBYI3mF0MP9Tp6GElo7WMV2PbswAEZVrdxKOj9KZj8YdBHosRzzTGqBxng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2IPsbth1C805ZbIvlM17eXjv5g1azaD4hNx2R7pEPA=;
 b=l8zKo/PQQ7b7pbryQeTWkvnGUf9r/kSLa35o5JbvTtcZNSSAds4vstVobIgwptWofEsaReHnrl12DJH7vLk4bJYIoFPj01DOTa118VwMsACRf0Q77K6BaMc6jLP6lYtPRWjWFzYGhKah1y+j4zBaS9Pp+ZYGAdEIx1ro+2QySC1Sa+SmNypsWFe3te2L6XX6rvPTY/+XdlSl4b989r5iuymCHc8pIcUH4l2VMiuldGJBH8SpHhGJXR2yA2/oKsZUtqSH+ULY9nYtl7XzLQ+3ppd63cy6syOqYYusg++fvde3OkfqE7LuOw8O2erTB+K1JROIi+L58CD79YCd2mpdcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2IPsbth1C805ZbIvlM17eXjv5g1azaD4hNx2R7pEPA=;
 b=crk0iNG58Ws07hmjFOxJFJ9YLTtSTg/sSZqM1zAFu+xFLG3ggsfK8x+tAEKDEW19xSGaoGE1tq2l0g5lm/eBtraAZs0ErWfV5AYvNKMzYJMofgW35AlFWxSWlzaeVYEGQUDmRdxf2SEUsajpDqCK7OSTp4H06+KheUdHOsyBpLrQyBErJnh5XyOuot6dvZ+TaO7Y9ACm4B1v7reeByKY7FgrYKbr3xq5CEk5HC0H81bjfKoB4NVNx1HIlVDao7kcPQneatuYjoL7Tj4tq+8pxWWCqDB0AOPiBhdmpIpQWbVGqzCUmoInN04Eu2cekvJsCDwzBoWB9gioAVok85Asjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GV4PR04MB11773.eurprd04.prod.outlook.com (2603:10a6:150:2d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 14:23:08 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 14:23:09 +0000
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
Subject: [PATCH net-next v2 1/3] net: dpaa2-mac: extend APIs related to statistics
Date: Thu, 12 Mar 2026 16:22:47 +0200
Message-Id: <20260312142249.297192-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312142249.297192-1-ioana.ciornei@nxp.com>
References: <20260312142249.297192-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0027.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::10) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GV4PR04MB11773:EE_
X-MS-Office365-Filtering-Correlation-Id: a1227680-b87e-4141-e4dd-08de8042e223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|1800799024|376014|18002099003|22082099003|56012099003|7142099003;
X-Microsoft-Antispam-Message-Info:
	1HUpOwYjKt365PyWzbhvqsnYDGYvTGFuVobkznzwyAsPuHGvX78aInLYo0ZRuA4sQb3zzBqLwKFuoTO6L5f+3s6lOdpzWkTVtmbXYYFh3CvLPp/LlOrZzSTUa8kyNAA6DEbotXkMkAiL5Zc6V5efGwrxACkM04VrI/CITQjIsXrfevnKz9CbWtzzxDyZc4OEj4OpnqA1jdEU2RxhqdiwrsEo2vpqeH+dsS0p+pC/eLgWBLtvgLE+ImXZQ+voe8eqrNuRPeQ3GBBo89iLLYM3VdiPSjpCtcX5p5SYsqZzmOjLvrf3fUDC1B5wz8SqDmSq6c1+YoMtoMnRo3b0u9PE5UIDhhPpb6lST9i2+AUUU77WkS1KreImY8rb8rnvOXBv5O+K0n66G7Vrit/SLaIf7TsUG05xm0hgahPABAumHLHP4OgdyZDErDsJra+Kfk25zF2S4ZzRTyE2UbOI9amKfE/UsGDCte0pyCsFMlAG1+EzBUepMbPjWrdBl66/ZpPxo6H9U5Zfja7yYAvFSRIGiP2QKMJpzGPdVoUtdEyK47uBhteWyunjlH4Ord8Rptjk50Kch6zIK85bq31Kfll6aV7TYsMzYF7tpLfZPNJpKUxTv/EkrD4Dh5pIZQuaBLxysO6CbV9C2OQm5dlysbXld/qyGUh8FXfrpOyKOmijlWrDZuzgTdzauIco7LUnW7Onn4S5UJWWbBT4WYQlvDB3jH0O0ZoeRbzcAb9WttM4w3c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gz+XLY8UAsy5ZHnshBsWLjspW2xlmDXCs9jxOYzGKWhO4qP62L/zr6iI5HtX?=
 =?us-ascii?Q?5Z1MUidHvEO5M2Ksm3H5sNSEMNgm200sX01poR/HETEL6JXCBXsMjB1A0Ial?=
 =?us-ascii?Q?LhDp2MXThSDMkcrLFEQoIcY2h1yp5fSdRXoWGmOHUuSVbQIGRL6KpyJDLtt7?=
 =?us-ascii?Q?Mw/B+bggF6/h9JD9pxBmz+43uYhZgYoZgYhrSzDsuQ395rgbhV7wUVvUPNeD?=
 =?us-ascii?Q?GYBn25fAnywCIViWGLWxKgkkLP8zWNXzRALNaHcSBBDrMjyd711p8KXfbP5o?=
 =?us-ascii?Q?uOsq9YgXHlIn6sBllzE+6vo7WwhrSH4lzibOCl5Sae2hZ8TczKf9DRDV/Sa/?=
 =?us-ascii?Q?i4/C3OFNRYZtZ1lkuhmEb1oyx1Z3BlYRoRv3NdkGE0S9krVCiRUaQuRfdFLS?=
 =?us-ascii?Q?dpxkrV9A5r7R7MLboq8pfVTS74mRK7WJEw+9mZx+rRKCpFMhJE4KsSRwm9YM?=
 =?us-ascii?Q?td36ysc9pGhQashDADyWm2idzQKJAszTjZhqpUEMO6hdPxM4pVbM5PB65Wj4?=
 =?us-ascii?Q?dxMmu5qg0/9HZVOghGPXkH1gpSkCEWFBvzXyP6vXg9B3RUs2gpCA+bR/zJkG?=
 =?us-ascii?Q?+mc++7FBjlt6mbWDi06kjwFm4+qyzlqtpRlNJDzgLnr9XguLzo/aL5hVI29d?=
 =?us-ascii?Q?kKwqIYNtmlj72sqOPkHImTBL/OMOrt4EMejBKCfPcTr9JM6IxF09eWW+kWGJ?=
 =?us-ascii?Q?tyPAtp8h+sLh5mVr3vYux76YxZGFoiVttrpXn9CbDPY2vWVg8fvSkdo3JJI6?=
 =?us-ascii?Q?9elo0jkIdrAhM4gMn1GJ5yoevIf0bvZN1ez9pvM152DKi0p4oTO6GDR2GVjT?=
 =?us-ascii?Q?DAfSyAQ27kOVAHbDIB+EZbTsDgWgPPd6VK8mZQOgoqLFQ84/7I6UdFlC2GH7?=
 =?us-ascii?Q?jlCfjyw/jIio85U7SOpuMSECEeRSwOWfYwqVsW/Ca3zmMDbsfF5zIZeESLg0?=
 =?us-ascii?Q?SUQHNe5jhxihwHZRMcRE5QnSRORTq9iZdYUttbHb3jPFrK/1Ohc1zuuT4voc?=
 =?us-ascii?Q?H8pmpVrTOiCvIVhpkprPVAaX6GNrd5mFf64xsq5FaP6cR6D3/3E3JLxyTqCh?=
 =?us-ascii?Q?7AnCA2Lm2XJ0sVoFq6uGYWIjOBW7ySYtYM+VsmXG7s9S9BZv7YcQiw5hIX4u?=
 =?us-ascii?Q?b2/+wMs6Z9GV0Pp7jqzhLxQFZrivNyvnviLpn3CKlhY30y5rpDj6WWRHRghs?=
 =?us-ascii?Q?QgjqjvX9cV+f8PGLrRVN+A8BNFOEOMN4RXhFFl0CSAz/2SdiT4HB5inS2FWK?=
 =?us-ascii?Q?PmYkTNJUpMc+h4eC6bzslw5TJYSalGkcHdZXwXiarpmrdCc1EwSU+3eU924J?=
 =?us-ascii?Q?xDKCeVSFwgWB+Vd5QYoAfOwVjLEtk8mA5CGQZTU/koLqRkh+PF2O/Ft/b6LZ?=
 =?us-ascii?Q?AdGoQENCW7nMdpB1XjeVreLz/G+iEe6RoBKfH8keJ8i0QWih4o7cZQVIVobH?=
 =?us-ascii?Q?0lGf+0QWe39kOSYsJzEcY1Dw+vOtUOegBW2Jxu5rKYQ24XAShZRK7JkmHMdX?=
 =?us-ascii?Q?2VHniuMwZGsZLB6KnPyhc0unes3opcr9w59yVFvHg1V37M6jB0ljolBz0qSJ?=
 =?us-ascii?Q?uO1xWLuwl+j/JbENPdXgVl5gVkwbFAr4bPM9WhIcQqHzjMRAlYwImjQXorbn?=
 =?us-ascii?Q?o/RqFyTNjY3i7XJDML3RUbTU0958zjzIB8YUYA0u1VYdx/QMY5XPeI8yKBbn?=
 =?us-ascii?Q?IpOI3CUPMZapyLRO27S7GeNl3tJTz4VVy/sobEIBv4T7H6oQrKqgd4XktaMN?=
 =?us-ascii?Q?iM3jh4cbfA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1227680-b87e-4141-e4dd-08de8042e223
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:23:09.1802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQ7CrZ5UBmu3429Uho7loYjz1ChRWfNRq0rmxOJKbYS5/etDQU/E8EK/ZzmHhOFMhHScfHLKsN3z5q8TZ0NHwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11773
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267097-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: C915827352E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend the dpmac_counter_id enum with the newly added counters which can
be interrogated through the MC firmware. Also add the
dpmac_get_statistics() API which can be used to retrieve multiple MAC
counters through a single firmware command.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- none

 .../net/ethernet/freescale/dpaa2/dpmac-cmd.h  | 11 ++-
 drivers/net/ethernet/freescale/dpaa2/dpmac.c  | 30 ++++++-
 drivers/net/ethernet/freescale/dpaa2/dpmac.h  | 86 ++++++++++++++++++-
 3 files changed, 123 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h b/drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h
index e9ac2ecef3be..a864a99a0f75 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /* Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
+ * Copyright 2019, 2024-2026 NXP
  */
 #ifndef _FSL_DPMAC_CMD_H
 #define _FSL_DPMAC_CMD_H
@@ -28,6 +28,8 @@
 
 #define DPMAC_CMDID_SET_PROTOCOL	DPMAC_CMD(0x0c7)
 
+#define DPMAC_CMDID_GET_STATISTICS	DPMAC_CMD(0x0c8)
+
 /* Macros for accessing command fields smaller than 1byte */
 #define DPMAC_MASK(field)        \
 	GENMASK(DPMAC_##field##_SHIFT + DPMAC_##field##_SIZE - 1, \
@@ -82,4 +84,11 @@ struct dpmac_rsp_get_api_version {
 struct dpmac_cmd_set_protocol {
 	u8 eth_if;
 };
+
+struct dpmac_cmd_get_statistics {
+	__le64 iova_cnt;
+	__le64 iova_values;
+	__le32 num_cnt;
+};
+
 #endif /* _FSL_DPMAC_CMD_H */
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpmac.c b/drivers/net/ethernet/freescale/dpaa2/dpmac.c
index f440a4c3b70c..8957665c05fc 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpmac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpmac.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /* Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
+ * Copyright 2019, 2024-2026 NXP
  */
 #include <linux/fsl/mc.h>
 #include "dpmac.h"
@@ -235,3 +235,31 @@ int dpmac_set_protocol(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 
 	return mc_send_command(mc_io, &cmd);
 }
+
+/**
+ * dpmac_get_statistics() - Get MAC statistics
+ * @mc_io:       Pointer to opaque I/O object
+ * @cmd_flags:   Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:       Token of DPMAC object
+ * @iova_cnt:    IOVA containing the requested MAC counters formatted as an
+ *               array of __le32 representing the dpmac_counter_id.
+ * @iova_values: IOVA containing the values for all the requested counters
+ *               formatted as an array of __le64.
+ * @num_cnt:     Number of counters requested
+ *
+ * Return:       '0' on Success; Error code otherwise.
+ */
+int dpmac_get_statistics(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			 u64 iova_cnt, u64 iova_values, u32 num_cnt)
+{
+	struct dpmac_cmd_get_statistics *cmd_params;
+	struct fsl_mc_command cmd = { 0 };
+
+	cmd.header = mc_encode_cmd_header(DPMAC_CMDID_GET_STATISTICS, cmd_flags, token);
+	cmd_params = (struct dpmac_cmd_get_statistics *)cmd.params;
+	cmd_params->iova_cnt = cpu_to_le64(iova_cnt);
+	cmd_params->iova_values = cpu_to_le64(iova_values);
+	cmd_params->num_cnt = cpu_to_le32(num_cnt);
+
+	return mc_send_command(mc_io, &cmd);
+}
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpmac.h b/drivers/net/ethernet/freescale/dpaa2/dpmac.h
index 17488819ef68..857b40a5b339 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpmac.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpmac.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /* Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
+ * Copyright 2019, 2024-2026 NXP
  */
 #ifndef __FSL_DPMAC_H
 #define __FSL_DPMAC_H
@@ -170,6 +170,50 @@ int dpmac_set_link_state(struct fsl_mc_io *mc_io,
  *			      pause frames.
  * @DPMAC_CNT_EGR_GOOD_FRAME: counts frames transmitted without error, including
  *			      pause frames.
+ * @DPMAC_CNT_EGR_FRAME_64: counts transmitted 64-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_127: counts transmitted 65 to 127-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_255: counts transmitted 128 to 255-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_511: counts transmitted 256 to 511-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1023: counts transmitted 512 to 1023-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1518: counts transmitted 1024 to 1518-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1519_MAX: counts transmitted 1519-bytes frames and
+ * larger (up to max frame length specified), good or bad.
+ * @DPMAC_CNT_ING_ALL_BYTE: counts bytes received in both good and bad packets
+ * @DPMAC_CNT_ING_FCS_ERR: counts frames received with a CRC-32 error but the
+ * frame is otherwise of correct length
+ * @DPMAC_CNT_ING_VLAN_FRAME: counts the received VLAN tagged frames which are valid.
+ * @DPMAC_CNT_ING_UNDERSIZED: counts received frames which were less than 64
+ * bytes long and with a good CRC.
+ * @DPMAC_CNT_ING_CONTROL_FRAME: counts received control frames (type 0x8808)
+ * but not pause frames.
+ * @DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC: counts the fully dropped frames (not
+ * truncated) due to internal errors of the MAC client. Occurs when a received
+ * FIFO overflows.
+ * @DPMAC_CNT_EGR_ALL_BYTE: counts transmitted bytes in both good and bad
+ * packets.
+ * @DPMAC_CNT_EGR_FCS_ERR: counts trasmitted frames with a CRC-32 error except
+ * for underflows.
+ * @DPMAC_CNT_EGR_VLAN_FRAME: counts the transmitted VLAN tagged frames which
+ * are valid.
+ * @DPMAC_CNT_EGR_ALL_FRAME: counts all trasmitted frames, good or bad.
+ * @DPMAC_CNT_EGR_CONTROL_FRAME: counts transmitted control frames (type
+ * 0x8808) but not pause frames.
+ * @DPMAC_CNT_ING_PFC0: number of PFC frames received for class 0.
+ * @DPMAC_CNT_ING_PFC1: number of PFC frames received for class 1.
+ * @DPMAC_CNT_ING_PFC2: number of PFC frames received for class 2.
+ * @DPMAC_CNT_ING_PFC3: number of PFC frames received for class 3.
+ * @DPMAC_CNT_ING_PFC4: number of PFC frames received for class 4.
+ * @DPMAC_CNT_ING_PFC5: number of PFC frames received for class 5.
+ * @DPMAC_CNT_ING_PFC6: number of PFC frames received for class 6.
+ * @DPMAC_CNT_ING_PFC7: number of PFC frames received for class 7.
+ * @DPMAC_CNT_EGR_PFC0: number of PFC frames transmitted for class 0.
+ * @DPMAC_CNT_EGR_PFC1: number of PFC frames transmitted for class 1.
+ * @DPMAC_CNT_EGR_PFC2: number of PFC frames transmitted for class 2.
+ * @DPMAC_CNT_EGR_PFC3: number of PFC frames transmitted for class 3.
+ * @DPMAC_CNT_EGR_PFC4: number of PFC frames transmitted for class 4.
+ * @DPMAC_CNT_EGR_PFC5: number of PFC frames transmitted for class 5.
+ * @DPMAC_CNT_EGR_PFC6: number of PFC frames transmitted for class 6.
+ * @DPMAC_CNT_EGR_PFC7: number of PFC frames transmitted for class 7.
  */
 enum dpmac_counter_id {
 	DPMAC_CNT_ING_FRAME_64,
@@ -199,7 +243,41 @@ enum dpmac_counter_id {
 	DPMAC_CNT_EGR_UCAST_FRAME,
 	DPMAC_CNT_EGR_ERR_FRAME,
 	DPMAC_CNT_ING_GOOD_FRAME,
-	DPMAC_CNT_EGR_GOOD_FRAME
+	DPMAC_CNT_EGR_GOOD_FRAME,
+	DPMAC_CNT_EGR_FRAME_64,
+	DPMAC_CNT_EGR_FRAME_127,
+	DPMAC_CNT_EGR_FRAME_255,
+	DPMAC_CNT_EGR_FRAME_511,
+	DPMAC_CNT_EGR_FRAME_1023,
+	DPMAC_CNT_EGR_FRAME_1518,
+	DPMAC_CNT_EGR_FRAME_1519_MAX,
+	DPMAC_CNT_ING_ALL_BYTE,
+	DPMAC_CNT_ING_FCS_ERR,
+	DPMAC_CNT_ING_VLAN_FRAME,
+	DPMAC_CNT_ING_UNDERSIZED,
+	DPMAC_CNT_ING_CONTROL_FRAME,
+	DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC,
+	DPMAC_CNT_EGR_ALL_BYTE,
+	DPMAC_CNT_EGR_FCS_ERR,
+	DPMAC_CNT_EGR_VLAN_FRAME,
+	DPMAC_CNT_EGR_ALL_FRAME,
+	DPMAC_CNT_EGR_CONTROL_FRAME,
+	DPMAC_CNT_ING_PFC0,
+	DPMAC_CNT_ING_PFC1,
+	DPMAC_CNT_ING_PFC2,
+	DPMAC_CNT_ING_PFC3,
+	DPMAC_CNT_ING_PFC4,
+	DPMAC_CNT_ING_PFC5,
+	DPMAC_CNT_ING_PFC6,
+	DPMAC_CNT_ING_PFC7,
+	DPMAC_CNT_EGR_PFC0,
+	DPMAC_CNT_EGR_PFC1,
+	DPMAC_CNT_EGR_PFC2,
+	DPMAC_CNT_EGR_PFC3,
+	DPMAC_CNT_EGR_PFC4,
+	DPMAC_CNT_EGR_PFC5,
+	DPMAC_CNT_EGR_PFC6,
+	DPMAC_CNT_EGR_PFC7,
 };
 
 int dpmac_get_counter(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
@@ -210,4 +288,8 @@ int dpmac_get_api_version(struct fsl_mc_io *mc_io, u32 cmd_flags,
 
 int dpmac_set_protocol(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 		       enum dpmac_eth_if protocol);
+
+int dpmac_get_statistics(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			 u64 iova_cnt, u64 iova_values, u32 num_cnt);
+
 #endif /* __FSL_DPMAC_H */
-- 
2.25.1


