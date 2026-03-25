Return-Path: <netdev+bounces-271417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIVGOSuHw2lRrQQAu9opvQ
	(envelope-from <netdev+bounces-271417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:56:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F7B32058F
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 745DD30465FC
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 06:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB6935F182;
	Wed, 25 Mar 2026 06:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bev811sK"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433A52EBB86;
	Wed, 25 Mar 2026 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774421702; cv=fail; b=MnvKYsOlglkR/ZBSoPhWY76ehmusRjWuA2G3WJu5qhkkVrrCOOMtooP6mXTqPkAwZKlLAYBhUWjbPZCGuc7ATCUtFaBcrF1afPh3G7V3/g/9IXB4pgDWMewXekq9Cps0lZZc49gkanbSqlvCkYFMN847TuWu1OC1TISN3fp6Omc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774421702; c=relaxed/simple;
	bh=K6DMN7ZJd87yTRrton3X2/63KyY3YunosgprxDSb/Ow=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=U1M+gOoGh5RfS7DD6gWMeVarMvM/6pCUH7bfh8DW4UwIgLqNbUnstWZlGNNOX6jNyMcJaQ+048cLC7zDBS4ckfcYgKEQxdVgNR/Ti/mlcXRLFxRBPBz/9wy/gp9GPwcsPCnHqKs6HhVe4xxN4ZPvTuogXwXHMXUzEEdfovRV19U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bev811sK; arc=fail smtp.client-ip=52.101.69.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xixKflP5qPvREYJUDGKrejFcIAesz9mtzywZC+nTxG1AS1213fYQ3PCVYECYqLU6OKb6J3njTRHSLUqvxpecxoQDvb7ov1mmVhczcKMwav4wnnmnbQoKyqQcFYNxssZrxexVVMpgnBjGyybmsYC4tglT34rL0WkHJlAp2ADL7paPN06Y7yncARpuZwoz0fAIkIB8pL0nL7ICNblhanBi1rnip6ZFK0XVLtAxOVQDdpVlmnBO+KpZQRcy0XzEIMJrVzQ0gsEybSu6/xpJD4Kni8JtmeBnkShDjBskMip+k8r3tR0OWGgQbeWG3a/vEaeRr7BoF19L9Zg6uQ+h7xChEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCPLh25Z8vC0ZwX3fx6AFUcpaI+McMoZynvTegCxssA=;
 b=HA7+lMNTehMLJIvA/pkVmecL0vpoFVA5xsIOihuwGssEBGrpT1AL5d18bNVHD3XYEVxFncu9GbD+exBy+vsgN7n2YrA2YjDtFkzTvoZGIqud7zzOo8xuAtNVICr/uKQBJCeyPx97QPZkpFnChlsknnxAfstS54QE25LRHX2ewXBBwjnZnVayDuwPGXlBUXgtrbFZT5TfY8XVrpQloeQ1RHOba/20d2Elmq6CH+T0TNjtDQwevb/lS86DhOp1r8CwWOwOnc1o1tisDUE00JpA0NT+4geWGtocSSczA220ii7rSs571596+n2Wpsx1hqvRfaFaHJwW+0YvJz/65tjrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCPLh25Z8vC0ZwX3fx6AFUcpaI+McMoZynvTegCxssA=;
 b=bev811sKX7hcPR0EK5PM/wvzthZgZ7+4dH4kbCjgeBsF8coTq3KbTOkcfmU5Uq4DzMw4+LGvxOmmLEEGhDaQT4AZsM0zFm2dNSQwB2jeNYXI50nOOAZPIMQpSjcKXwH2L39Cpuk5AzLw9DZ78pEEs65GM5FjQmX7YVgr/f703pzaLzg+ZkAjLITG19kv3DbM2vGN6CSxlDI3jZ/rZUgBDtaBrfWjIP4+9RYAa6A1/hByDTlUmn4TXPKsldyDRhJW/iqTs46Z4uHVffy9anY2p33ZUj7djXWL0fcZGV4GjN+tXtE35e+E2tdHcwzIaTNIH+i1gXlp3qxW+G/yw9bXFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7459.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 06:54:58 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 06:54:57 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	alexandru.marginean@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net 0/2] net: enetc: add more checks to enetc_set_rxfh()
Date: Wed, 25 Mar 2026 14:56:45 +0800
Message-Id: <20260325065647.2882997-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::16) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM8PR04MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 5647fce5-19aa-402e-fb59-08de8a3b6d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	ZtEPW7WDiugJe05XL4+4VhnJhQt/KQaeEahx9iT/PUXLg8cY1DeXw2W5m9lve7LBiANywChY2Fb8M4o/mvPGYWDRcajjWPp6xt5t5nDDDh+W1DFEL8Zk3D2rzmmMDgw6t6oWK7NdEpMrApOGGvzjQqLSuMU7QKimhOlTFG1g/L3mBVx2ylnAwfrMqu2PPecKe7ER7AYPc4PK3jyLp/rFaj+tmz2Ga5ZI3fHGVFb+tSrezWMg2MkoSbVFX8QJ+QWq6kw5NURyC7BmjUMO58VlHIK7rOxvRS+npJHT3+vFY5A3HIZn6elv3ko471IkhGBfe5d+mnYbChjrV5F8PVBCswKTX3WaH0DWiSUx7t87XXdrgyHMttGZVourEqZnS8kvooigtfvKWmk3eozdvP+3bpmOyh0H7xvastc9V24UvdIlkxsLXy1MK6uNGCtoyXcCX0QanbO7lXmc7lNtv49Q2QdWV9C6v4MrGtamt4g/3O9Ap3/8UNV6ysVNOKl+wrWVQvjSJHlcmw/7zELnbVQEK7O/ypN4GjIXLQ5MCHIHMmDEeAmOBtUct0MGG3Mn1BgYDrZH3eom/vfX3OWaE8+50VZ+lsqO7qCJErDF34ML4+vBmmSwoUSApLpnAwNTq08YbJywesAePm85fC+ANem0XnQ8u5fMli+PWIC8JML4Do6YP2705bOC2hdd4TRsoTTwbeAXS7KO0Ma1UpnU0dLfrzINEV5Kbnit+vEj+DwNvcKoSOQMrZUfXf2LLT9n69X4aIxgcHKA9ZlT/HpfwIM4HATaM1V0uXIl1qXw9+bZd58=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C8b2isURLbXJdGWJl1BwGWfm/jZQjnqzsmbNSMyTDQpmlzy8C99+DB8fbGtm?=
 =?us-ascii?Q?tenSts5RzOnPQy+TrXm67NHcvfPVUmnE7mxIMfd3CoE0x+zLvStKkcERL+Rb?=
 =?us-ascii?Q?xmjwmz7BGdP7RnOEe2DA5sWTdM0G2CjyfhBDLknxe+Qqdj9XokJ61kR1wLGy?=
 =?us-ascii?Q?1PfpTekXgr+UC08LXXstySti1f3Z85VRtR7F3KGLsKwEZo9iDv6IHRFhWCiJ?=
 =?us-ascii?Q?1DcyqjIQTJXqkrc28sB8YuPpWr/trHi2x6Zbmd7uduCYqRwiS6UB3obZSRcs?=
 =?us-ascii?Q?cxyboqEQhZP/WFIY3NfvwtkwSe6ggK6EoWZASZZTaIlmklCCgV9G/dRA6zPG?=
 =?us-ascii?Q?AUVHPnR/PL8vcC8LJKV0Bso9laYWaFgvEb0oijnw7+t2oU69Kj8eEyTywkxS?=
 =?us-ascii?Q?nuin/gzhgs8yU5AMSNxpxxM+qwQV6O7xAqaFkSrSiQQWp7VXNC//zZQpvA4+?=
 =?us-ascii?Q?HCb05KVK1wgRBN5AuwPuHkjU44iwGhnC/ytRsF/cHFaZ9F3laraCd6m0n2zV?=
 =?us-ascii?Q?QTqcqdsqAw3z8an7uMKMg+Znaqe3V7RS5s4gQCN5+v7oWf6oF/YOGdoll4rh?=
 =?us-ascii?Q?IPU6ifH0s8AwWNQvCwxK3YoNEiTrVH2k68aF9sWHS2dsqJHEKT2SzGdcO9JL?=
 =?us-ascii?Q?3VLmDr/knB/xFIjwrX2TbBa1iYnvgD5dpuzzdbUaTFmoVkz+bD10cH9DF52n?=
 =?us-ascii?Q?cbixFKKf7KkBLIIflFMpkywtseYY0DZP7SVdkwfEao+CERIG/DFLaoS2Cc1j?=
 =?us-ascii?Q?aUqBa8Cl+jeYM4YWMU3ipak7tPNJVntEfq2jP+38J0EIZgRh8i92EcuLbXr+?=
 =?us-ascii?Q?oRmQALgc1g8rxUmsPg+WEqqHWYcODq1/Dn/+RTArhVRCj2GI3/KMdUtDt3vD?=
 =?us-ascii?Q?uccTpLErqj0sTPhBQB+rjmFe2T5nEITbOJHB8FP7Fb1KyTKWL6m86VxyqBwX?=
 =?us-ascii?Q?YLgwcAJzIyNcjm8tuIBIlWDw0jrBhjJB4ChbmAvXo3MdFIbBtYHRH7WMPQZe?=
 =?us-ascii?Q?Tc5F8MMAPgL1vE6J0zcpT6TWn9gFZeMJh0DVN9Oa8d0lPi0Mt+ModLxM0Kvt?=
 =?us-ascii?Q?zAsHHKYFQY9w/PDXlDVrdY9bLgO5sWYhY/8HPSIgwmRyZyuJf+F7Wd0TIuez?=
 =?us-ascii?Q?Sle2weLKRokGSkI9l00NIFmBANtcs86gOh9C/E3umjAo0pRv+9pQmaH2Qb8q?=
 =?us-ascii?Q?ken03mTDCgv5Ua0ObqiEmz8lPlZuLkzSsJyh6PtTmxx8CLUwlL7qxhJm+g6X?=
 =?us-ascii?Q?VQMD58f9pm2NYVdKqjpMytPLH3r4jATtDpoW0niKzcz0WXwb4U7+WnnxS+G9?=
 =?us-ascii?Q?jIllsltz/jx6tPTCUKapI3lgHk5ZeSJU0XEc957kinHygpfl5Z4Sj+ANvdv/?=
 =?us-ascii?Q?EGXhENsjaOht+NTx0DHteuFwLDeac1hnkPWm0x/NXfnvPr6MMVNqWws/EL9M?=
 =?us-ascii?Q?cd7G1NT1ahqwABcYku9nmBnPCrlAILHhapDJAdUFeZLypQA/EqVwiF+gUPlP?=
 =?us-ascii?Q?2REnxKHVLVDwdBbu9L6q/YX83XKNEgQDXamFqcFxdOabKLUh3Ee5tYmZXorn?=
 =?us-ascii?Q?VeviIDj0AS63LOMOlP7mWcKhdsk4hoIM7zhgy2Qwd/lunxGM0F2uhYnDCHBp?=
 =?us-ascii?Q?qssbZztancHr7qPiMB30usGRbM9gg+Dk80L4Ra4erRbBWLGIO4Ti+YxqkLH0?=
 =?us-ascii?Q?boKTarfBO4MkVKTMtUUdEJoqZfBMR7zwrR92+vyQY+5PeA9vC9RKltwENWyr?=
 =?us-ascii?Q?EjCmEXIsEA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5647fce5-19aa-402e-fb59-08de8a3b6d3f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 06:54:57.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vyx6jU7jnsInSp6Z6Abr/pfmO4mnakMPFJ3o+0i2Qcr40uI34dhgHJoxMG0MeiCd219Sfy5AHWPH3HAiiQ8RNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7459
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271417-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50F7B32058F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ENETC only supports Toeplitz algorithm, and VFs do not support setting
the RSS key, but enetc_set_rxfh() does not check these constraints and
silently accepts unsupported configurations. This may mislead users or
tools into believing that the requested RSS settings have been
successfully applied. So add checks to reject unsupported hash functions
and RSS key updates on VFs, and return "-EOPNOTSUPP" to user space.

Wei Fang (2):
  net: enetc: check whether the RSS algorithm is Toeplitz
  net: enetc: do not allow VF to configure the RSS key

 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.34.1


