Return-Path: <netdev+bounces-289780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNeEHNZZDWpuwQUAu9opvQ
	(envelope-from <netdev+bounces-289780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:51:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F35588635
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A5BA30760A8
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DDA341AB8;
	Wed, 20 May 2026 06:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KVRJXNrf"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE1F33D506;
	Wed, 20 May 2026 06:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259330; cv=fail; b=aMQ5QzznaaBYl76YjTdOx1d0xJH0nAsOi+jTrpujPNCIR/7OvCHLdcoWAJDCnJm4ELxV21G8nOwcmoVlAdcBh4gUdSaBQKnkTdlP+SXCPpJqqNZOdjoQ/EhygbpwgntimnzV+/eGR1eGFBhSSHOj+2U/vADH2mL4kaXWSlLGNY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259330; c=relaxed/simple;
	bh=j0LbQ4Mqbdpsn3wX6jRsIWS0PQ25ocNcOhLj53U41rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dgBZrHcdttEK1rz5L/IqiPHrPymMYUw8ErAfzOfeDkUv8e6Pd7so7BfBAuSOIDdohWOWqNRY/cKBkPuvxLXUy/FNyZQFxthO1KgiJEJ3JBXs4pV87pig0PSmQsUDnw8qcG1R2S27XjrLALZuI85+MOAquJVst1l/j6P/JX+WL8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KVRJXNrf; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmOIO+r7eRpnftHwTRiNT8cnHVI8o6AQnlLVtfiT3ZaPvKeqJZJXOilbAnQP+KuN0JBjYDr9Ak72UEXeTqo5KBmZSBraJyxU5hVL/8rGATiFB6J9VtWagtgoZuFDwtPhMv3VM4xXQGM4pb/oVrroHwVUiT0Xj42b/Xk5PAEZX6v3EevU4tv3HULYWi1S07MKEkrwe9gcDPee4n4lONebqrs3Ziky4OQFO2GjwZa/SgV81sxK9NEFUhMj0NN2QVfRlmpMxFv17jDTNnOcfPZW96HKmWpgMjlh4ob/6goZgLhybD381dodiUV6A9YwLPRNRVlg2+hE+cy+DGzbu5OuNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kA/4zwKvyhI1a6uhO1O/wTIUaBXuJyC2qSADqDI8vac=;
 b=nh44l81tCxwqXVNmIsEuLlHiEM+6lsVPtM1Me+b2294Se6kLJZMu4Y2/YOi4Rvh9T/clCOOJeSfax/LAHzKG3FkpfovGk3pq7+NgTuEx7R6yttnPKO6TNcspvHNb2rOUlwyJrebnw0UamWnMsOdJYtElCugjDfbFVLN30zMGMWRrl7v83Mfp0P+e/8Giu99gfAeOAcU70Xal0HtOlBtOOR97jN51Me7f6hV3Xx1rONVBCUWo8KJfOFwQObHFUXf7++JMmxIUdjAK6/AvVSoWZisDKz9BizK8l3CFEzOqPKTVCwZ8/2KuldzTRBwyPX/peHS6Pwh2BUS7s3OsWS0Tcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kA/4zwKvyhI1a6uhO1O/wTIUaBXuJyC2qSADqDI8vac=;
 b=KVRJXNrfL20l19o/cXy1FgtJS4msQPrNjSa7kZoY6Kkb9dEa5X+jLxPncyXE4kaT0MeQtw3TuGGfAEwuc9Ok6NehzTnnSoL5mbLe/tzvH8xoT2IjLyPkt07PGlAXSitYD6oOhfWjV4JUVPt7c4kq6qPQwTaKXWbSzTcOB7g5ey4YBmVLsSUhG+HmL+px+yDUdaOMaXzeOSzaSlV4oGYT6kd20/tyJfFey3Mk+lB/uP/xBSVk2ulWxRpKbot3EuXoMhGoUJsnR+S/dBpQHXmP3ek4KE9osMlnuEQoIDUk0wDVd6leyGKGT/oGtX60DiMEnq2uj/B8i7EW2XoTXRI6bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM0PR04MB6948.eurprd04.prod.outlook.com (2603:10a6:208:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 06:42:03 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 06:42:03 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hramamurthy@google.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH v3 net 2/9] net: enetc: fix missing error code when pf->vf_state allocation fails
Date: Wed, 20 May 2026 14:44:14 +0800
Message-Id: <20260520064421.91569-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520064421.91569-1-wei.fang@nxp.com>
References: <20260520064421.91569-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|AM0PR04MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: c22c2306-b722-45bc-969b-08deb63ae719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|366016|38350700014|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	vY3I2S38mLBG1muPmYhDZt+DznRnOb2Q5iMi4zUV3O2Gs8poKo11ChZNluGoh3Bt/Jtj7tGncwPxSIY9mfulHiGDqROJVCUHj/JsCP7YE0W4/BuMa8hu3PS1wUl9bkQYPPP+3axh8wwsZ41StsDHXGtEWyNNdGhX1kcjtzLPLqRV5EmCG6HbfgBjIvmaa1BV329QZ5PdjmY4YA1ZxCn6hkHGv/prUg0d5xBtdi3cgSVcVTEwKolG3d5vYgIVsWl/knwi4pFROMMDolJx5/gDItgkGfQp9Yae4VDmBX7/d8x+bmWbMhm6ErIbCze6eajZ8GZcE+miXdfFoniYGzT62Bl6hOnsZesDO1Cq78APlQCSUjeceT+vAcgYpik9i8IEnqNX5jiYJhos/eJfNXZnGt0Qd1LGLSt+klpGZ3s4wJV+Cc9jtP23cWeB9Z7Wm88d8fZ/9TgKgGGzu9D1cFI8pOZMx7KtdmoA+EGzSN4bHW4Aq7O3e7PF+gnoEvAyKgGTaWq52udw/oJnomcmsbsWkFuE24mSu8ZDsYXU3kDJ0xY5UOe3mSNS1d9hnXTUYlb7d9Cdp5yyanqFkwYaigH1MTDGEa8aupoLRwGji9yQfScWBqgmi3OUcz84l3j1l6u3IuzMetfgwrMbaj7Ob+4QHq8WneCSF/6FSZyPF/VVmL7oEfpoganZjmi+JXhPYiJckLwpmeCqGpRs/LIrCV6o29zvI1yrcXwoxpe+ArVu0e7Cz/K8MRsALNzE73R/xgGf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(366016)(38350700014)(22082099003)(56012099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9AmInqNlgkS6fOUy+zNTTTDpcYiM4GmMFcvjjrucW28rO9KitWaDacQGF3VS?=
 =?us-ascii?Q?T/L0uT5rqt9uBIr/QeE5VetEnyZ+3bVujH6U/7/yugI/sQtO3aYI+pgBWJt8?=
 =?us-ascii?Q?rcaxGywyWYqRMre4wiSZ9ZS+mO7JwmBsNhOqH9UWGD/K0fe4bzFIAbUeWPs8?=
 =?us-ascii?Q?KFmP7XUDn2YM2qgHWa4ZDgcNnla0Fb+ovGi0GuUOoY3iHOkV8+m8kxURbsxO?=
 =?us-ascii?Q?Lkls/VG43wCxhLkO8jPztoxxzCIBzut5HbjiQN1MEsZzFGl3eOv3kI2+H01o?=
 =?us-ascii?Q?gQWJtVgS6f+iNFFpQWwhVC9njTJ1XXO7Kgf+6uTVcW/IzlkwlX/zroMVWIqL?=
 =?us-ascii?Q?dVokxeiFf5VCsgiu/oYt1AZyROxRZDgyuRH9eP9R53k/XFl5WBodMQ+lOjat?=
 =?us-ascii?Q?l2wDuzET9jjgN3unvXhchP9RvsAZaFecO2NRdj7JMQlZPDEJParltpqwy5dR?=
 =?us-ascii?Q?DV0vzwshfC/UKy1T8OFcPAt+KZlqLZeWrnLA/43Cb+yBEE7TWho8I0/E7s5W?=
 =?us-ascii?Q?SZfALdTHS38SAuYxxrkWvkNZHxGNinGK0ImEAV/aYtAF3jv4fc1WklXLuU9X?=
 =?us-ascii?Q?dSXBSXuKWaIdegEssmkxxVgS9syx+LCo0Y0S6tt3Y08NFIHm3JLbINGqNzt2?=
 =?us-ascii?Q?PDdqsuQ8zTAfDRU35W9Td7xhpmkNVXC9B93CrfH1SOsq5Sm+MI2IeLuTuRXI?=
 =?us-ascii?Q?+SpCeZkACOghvOZVikNf/RnIDOJrnVg5P76Ffvi8hZYAO2SQ7Fpj9R3z1ax1?=
 =?us-ascii?Q?p6xI180pHDFQvwknoRCQYh/af2oiWYvB3w1GZTC/ORnzZUhlQt3/jL/PEotI?=
 =?us-ascii?Q?hRyWTjLcYPtuFue6xx90YWcUMKHHaQAFOkA0YddMTnzWJyMPXW4GcbGNell0?=
 =?us-ascii?Q?6IudyfwmXYZDdVdWpM/yR3Av9a7Nd8atj4tatmn58bOf5+UooyqrP0phOja+?=
 =?us-ascii?Q?aGaiyiqDYzNs4xyh2hLS7WABZlDDb/+m/PYHYZ7RK69QBl3lTilyOR2oHMLj?=
 =?us-ascii?Q?uKrpbIOUwxwBLhnsUZUydGrwDPcFllLzq6KXfiLGeelwW+2R7NIINyVyzDze?=
 =?us-ascii?Q?KQMQnMNfujzgNe9GSHBvn280SVbl8p2TgXFcp7e9iHZZJiAxffinA2Kl3CoD?=
 =?us-ascii?Q?LJgETREZ/BIAFCoyNy+NfidVaiGYnCYFIr0ckO7tALFlckJUwK6wj21sTvR0?=
 =?us-ascii?Q?VyKp02iiRj8LLZVeS6ZKqVhcRH8fe/eczyfR0ECJMRQVA4Mx9is8LVdxXbpK?=
 =?us-ascii?Q?WkLMd167LTA9me+N4PeRTcUtuvEfoSFQ0vLecbmy2PNJgKIeIs02eZejS8dt?=
 =?us-ascii?Q?bYDylvtikflNs7JfStJLyVM0gWQtvAYsBmUfjpUS0trZeisegBB/Rx1G2f2z?=
 =?us-ascii?Q?OW1OqhpRV4Dak/O76iMi8JoSCcv1nIPW7QXN8PDtcQf4+sY0eGbo4TRWWMVp?=
 =?us-ascii?Q?L3wAU5QysmKNKcBnYaNgj0BGkgO8Sd8AJuggnIla6OPa8gVo6myKn6Fq2etD?=
 =?us-ascii?Q?lEVcq0vuN+La/7Q8ZPSDRgEr2lLntSr8Qgmc4/7/PoTfhaCrFzeVHrF9ELNc?=
 =?us-ascii?Q?ResUWSHMEYtPqp9toG8jQ7WEg2YWjSWzQt3743jDq0DyEmCjet6tScczy9fc?=
 =?us-ascii?Q?bozetDO/v0tHKdYM/qBKwwUZr18VkY4MWBpTLFaYsA/2o9aKxzKmBRmqwXf5?=
 =?us-ascii?Q?1PI+5okOsgAHY4tVipGL/32/NgjeFUgbP9f8EYd3FluICwUf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22c2306-b722-45bc-969b-08deb63ae719
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 06:42:03.6232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXVVaaZka+SiWYf9FqV3HayzIoz4srmonRD2Xx7zFHWX6AC/lk1deINXniYY+ilskTCNkwPydNPGHoE60mNrnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6948
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289780-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Queue-Id: B9F35588635
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In enetc_pf_probe(), when the memory allocation for pf->vf_state fails,
the code jumps to the error handling label but the variable 'err' is not
assigned an appropriate error code beforehand. This causes the function
to return 0 (success) on an allocation failure path, misleading the
caller into thinking the probe succeeded. So set err to -ENOMEM before
jumping to the error handling label when the allocation for pf->vf_state
returns NULL.

Fixes: e15c5506dd39 ("net: enetc: allocate vf_state during PF probes")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 27d4bb65e017..b743b6d33ccc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -962,8 +962,10 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	if (pf->total_vfs) {
 		pf->vf_state = kzalloc_objs(struct enetc_vf_state,
 					    pf->total_vfs);
-		if (!pf->vf_state)
+		if (!pf->vf_state) {
+			err = -ENOMEM;
 			goto err_alloc_vf_state;
+		}
 	}
 
 	err = enetc_setup_mac_addresses(node, pf);
-- 
2.34.1


