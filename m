Return-Path: <netdev+bounces-302580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n9DYI7xYQmqx5AkAu9opvQ
	(envelope-from <netdev+bounces-302580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:36:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3A16D9820
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:36:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=KFsSF9+O;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302580-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302580-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 239B030B7769
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55E63FFFA2;
	Mon, 29 Jun 2026 11:23:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011065.outbound.protection.outlook.com [52.101.70.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349A13FF8BE;
	Mon, 29 Jun 2026 11:23:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732219; cv=fail; b=YRo64gLeMFQv6pzc0KkTPbxCokdM+MeKxsa+n+DVr+5KITXRDi+wgR9TDZ5mUYbR+OULOGpiZMRed1Sakuai/XuMa6usLCp8rgipsEK1s+DK1FhIklcrcffooBvfrsIUjqReJJ1ndD0mbGIP8+kLgHDeHzTd+IuuhuJVcUI4xow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732219; c=relaxed/simple;
	bh=tpxpeZeSQBN88em6yH53qRuQ2jOZFZtEC/a3u/C+3x0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J2hCQnYr951rp7IoedHMWO9URZz7lLyShkiTzGbYYlyEdZZ4h5dP1IRFuxc0aP0xQJ578QT7fsEizpNw9ZaBb823FaXZazpugSN8zSTAPwu/yUfdcCNm+fEtm2HY2fax1RQMwxWImnBeuvj9aJCHCp5A8PjPCaw60Z97SlRyKUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KFsSF9+O; arc=fail smtp.client-ip=52.101.70.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHzknQ90Qt7N7LRwKRcz+db/RlgURT1GjhP7tbTQT9FpPq7RsqQYBdbULXOs9yID8X20oSc6wK2l1Pu7Juiasw8fy9JUfB99v6GErEbl3SQ66q4pD5GqM3q6BbJJeggUnGjqFMqxtdqancV4WVlHQ6k4wDDiOGgkGLslY9Q4GmHfZrNzt7dW8h6wQtN3rlp/3n2ch6eh8mvtSp/hGuaccHl/J5m6hhYWoiw5UH2UDz4C6IvKebWyEP3YpT+1JwRqz77WD5yx3IJwpsmQ/nec9g9804/eN75ZfGqluzWSGO+OVNhf8G/xgWvLUnppb+5L7N24AZxFl+NTajQvc/Oy0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vhHVivFpc0DzDbQ9WIIbpo+XQYH8VpnVwvjTmKvJ7M=;
 b=ijibikWV+8dCkfDFKVBv0214v83n+NlOZyRVFwhZtkK6ULKwQNn9eTcah1cxob+AVjQnfX9dEEE98UpVqJzN5FW85l8QgdldaxRJmMhgErXQKApZmYdkoPj4T2IUEH2X7oDhenATX8TH2N5qS/NWIxE5CFcA0JvZvSgpleR6+aV4BsoqKfo5wNAF5TwwA0mrIfyV67XCXm1PS77B6GiDSrzBRpn0EjcMFJyDPvfHYz/rkNXSiYoYn1Xr2oxyu+zSOXD84md891U7fGCHC39pH+MVQSYhSLqKU06CHLHtWyL21YMueUZMkiEaHckVogghMTziAy3bjhCHzP/uOtEDRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vhHVivFpc0DzDbQ9WIIbpo+XQYH8VpnVwvjTmKvJ7M=;
 b=KFsSF9+OBY1Oe3kOkCOcs5gyniQWbsub2jtqMap43qire+4z/tJbSLB80kAK1SUOCY7hrBugQtC7UnfW2Nq1D8/96d+Xxq9TBD5fCwAzywYKZPTLSWv5bO6lu16pHzWS3jy66MEzc6LvuLTLPiSgPTEYVrjxHbuk3wU0csGVYm5HQEEoP1eDn4XiP6YleFwZzDlahaDD73hfcsiEgp+Q4eOYRbR+QrctxYPv/2Qp06Kc7O+Hkv3orvfiQAQR8OAEvAXuSXb8apeukD64BizrSU+2a/Bxib8Pf7Aa1vHJTLhJHcFIVrnHdWcBxP1Xt67ISl5TlvAVZqlm0TvAR5ovgA==
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com (2603:10a6:800:31c::9)
 by AS8PR04MB8563.eurprd04.prod.outlook.com (2603:10a6:20b:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 11:23:35 +0000
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b]) by VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:23:35 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 06/13] dpaa2-switch: add dpaa2_switch_port_to_bridge_port() helper
Date: Mon, 29 Jun 2026 14:23:02 +0300
Message-Id: <20260629112309.154328-7-ioana.ciornei@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c1299e46-039c-4dc5-9e7e-08ded5d0dc0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|19092799006|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	XBbMCprWWo0zRjy6x3/9781jdQCpDxWBbdPjP5gyL4dftprtRg2OUY5C7XHu26Zx6KrYlf+Rz+rEDXoISGUVfFDQWnxWewjt6FK1YZ9y9vIs24c8RTHa7IwGi+pwDjcJ4C84W1oLw4bGAMKJwqJtQa7BGZAlAaepwEUMOcmYtwiN2av36d2Me8hUhJ38kmkObPg5NUN85FqIecG2J6ti9WNA91mRsTIOsjivUn9Ykq5Y6PEDE0DhEYO2fwyR0OqrgGbgbhXB8rcxyXK1FsjZZLYSSE8B+44VmnM5Ozi4cK6QgNQGdYGA9K64SmPA3XaP2iDNBw7rayX8yTvX+YJ9GEMbYqSVwHKudHEn8JZ0GprlkPN4iXZHNue6xg5hkcNbP6cu0aTb7KJOQjVwq+XsacIHEfs+5oqmhlWyuJwbBHn+B0iQ9Mh9iofJted3ocHyEvFanf/GYV1bOXg8yxikhVLjRbVSbYGU2OXuFW1BfCvID3ST/EbnFM6oWDbSGTcIxENkabuhQgNLF8XSGy9ww6cgg240JCrESmttKVea1tTTcu6GtJzS9S3oJwYbMR0JwquCx4rVkdiPy07S7YUE7USD+oro6Gqhc3MsgeS2DIstgU8Avb4UompTRP5ivmiivjZj5FRJMvD1CRSYn03xlC1D80z3hOukXF3RfGi1BQs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12302.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(19092799006)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WLSfFaRyR3znmzf2JFyK12MOL70qsBf31vM4SPK42xFjHTZTITDfKHdV6WLL?=
 =?us-ascii?Q?7U4OrDcmMS61TW1L0a+njppsF62PXdy1FHpy7rLlAB4jqfybWv8piB/Wo2Or?=
 =?us-ascii?Q?GCcYGxW+szAhU7nGOdcNdf0ls/xVLf0lCE2EuIgAo9dhDNBgceKPDP3fOjd1?=
 =?us-ascii?Q?iuJi7UFktS0r0Ms01Wc7ZFGbOhQF1qxz6aBl8lhShQjkniAp0A3CnZ/FZZpr?=
 =?us-ascii?Q?z7rWjVjbNM/eKyJ4hcC94XT6c5CqE1fvVGW0rJmm6elystgbxfSmhjlOpkBg?=
 =?us-ascii?Q?RRlh+0GE296tveWw2fOeTrg6Ec+DJtDlYKJrgXEDMD4sogorU3PlCk7WMv+7?=
 =?us-ascii?Q?5ofeFGIkZRnkLm0ZkWrB+dM3dWOKV1dqcSvjXybihCz7OBqrrLd4xSdCylWx?=
 =?us-ascii?Q?lvS4HnGIiqzB6uBJJBVhmrunY9BWQwL9FYAFrJukwvfGB3RUyKdCTBSK43op?=
 =?us-ascii?Q?fMZVjOh2Sl3kojpZDJQbsVCwSPml/LrliaS5WxuL30tXHtdBHrO0JETHIoGA?=
 =?us-ascii?Q?LVJxcVkvCFfgxixkKv8xuFxgBLDf1KCRpIL4oBh17KcbdwoLJNvIxkXgtIeX?=
 =?us-ascii?Q?Mc2RTq3iKf5AMJz+60HTxur4CzDfLk/EnnSbmcUlYV0Azgxuyohr4Fibg05k?=
 =?us-ascii?Q?DeEK5HqV5vBK86TcwT3N/0ft1qiArF0iBz7NAucNJeJBHZkzh7dD9HwFKREH?=
 =?us-ascii?Q?usEYeQwSTd4i9VpUb1XNmYtAzydjuRI2VOqnjVHLbKlHGxhlVWrMYBPgYBXv?=
 =?us-ascii?Q?6eRsPD+Wlw2CXK0i8++KfkLanmL5IWcq5bjwjAadhuKhZAv9dEV095gyH0L/?=
 =?us-ascii?Q?qSNNHzkD2cF1K2jDrMMM7CdyQdEjjCew7tVQLXIB8ejcnTwKIQggThRIbPuZ?=
 =?us-ascii?Q?1GbRhT+sLkQwhqu2LbKpW3WQux7LHYdyO7St1L9MS5W2hf+vBA32yZjbkf0x?=
 =?us-ascii?Q?ARdCD5lUYJ4I3jse0GO3gI/MdDfR1cJr9EN+nBXHDB4wYCunOBBigayy2bl3?=
 =?us-ascii?Q?FVz7EBsnS0If58LS0kclQ+Fe3X5QtPAWOE7ylplMbF9cPLM0eJyR3n50J2rz?=
 =?us-ascii?Q?nz98CZzV89jeqG6RBljG/o21VwFevm6FphMf4M8joh+4qmVv+WIRxEdkp+MX?=
 =?us-ascii?Q?EjHd6/WvPNmqABPBPF6V4nuWf2jLjRAe54qoFDbai02YRZwRvdLFMYP5eEOz?=
 =?us-ascii?Q?qK4AMWX3cDmTAOlgHpvuDtVoD1QolmMRch2MGNSz/OSBJVc6R7eOQscudBQ+?=
 =?us-ascii?Q?eGQ1C7mHW/fWzLeVy/oVNAoyD41E9SNGY6e78u5YK3uRceolPwVDR5bbHZrK?=
 =?us-ascii?Q?h4zHWJcp2ALJ9K/9m9ImEKIytA82Mw0MHDomuIKtoVG4CkUcudO8kU7GO5iR?=
 =?us-ascii?Q?EqSXaSRXsdcfTU/tCxykoXomCAxb+3Oh4ym8BCHoMdODAUQ5Ecy3gEgI3HVr?=
 =?us-ascii?Q?VT563vZe1ThtdOW2R3sFcuWxRxggq9TkbUX4Gy7iAA7PVTyyywSpXkc3s2s+?=
 =?us-ascii?Q?Sjv8LjCs+Fz+hPnfv38p3k46kS8RqQHi1RETy3MPBbzKWFkMAC/PneHuaPcE?=
 =?us-ascii?Q?fGgg/a5Kxu6moK/AZBAeiWIkIj5XS9F9x+HMGsklDHu5gBHHOf126YAMefYA?=
 =?us-ascii?Q?Fny5qNL9Q8jGjrqDmvS0k9SPb8Gr/wScNdglxpotQAxXvTUgrzHV8HPFe/5y?=
 =?us-ascii?Q?dpwF46cE0oi8oAex22A4tdqpVBAIvEenhCQJPxX8roxL76PtRTRmb78TjBph?=
 =?us-ascii?Q?ljNa9is0GA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1299e46-039c-4dc5-9e7e-08ded5d0dc0e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12302.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 11:23:35.6372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5Jv5yLQmkGkUJ2+GopgXtk48s1ZAqPqLReQEv1D7S2LutUmby3BttG+2XWGIpRZo6UZgCL/lpeAI1FGRgoTKg==
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
	TAGGED_FROM(0.00)[bounces-302580-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 0B3A16D9820

In preparation for adding offloading support for upper bond devices we
have to let the switchdev framework know if a specific bridge port is
offloaded or not, even if that brport is an upper device.

For this to happen, create the dpaa2_switch_port_to_bridge_port function
which will determine the bridge port corresponding to a particular DPAA2
switch interface and use it in the switchdev_bridge_port_offload call.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v4:
- Split the patch so that the first part only adds the base function and
its call sites and the logic aroung lag is added later in the patch
which actually adds the support for LAG.
- Moved the patch so that it's a preparatory patch

Changes in v3:
- Access lag field through rtnl_dereference() so that we adapt to the
__rcu change.
- Check that the brport is non-NULL before calling
switchdev_bridge_port_unoffload() on it.

Changes in v2:
- none
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index d4975d08fa44..88d199befbd9 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2017,6 +2017,15 @@ static int dpaa2_switch_port_attr_set_event(struct net_device *netdev,
 	return notifier_from_errno(err);
 }
 
+static struct net_device *
+dpaa2_switch_port_to_bridge_port(struct ethsw_port_priv *port_priv)
+{
+	if (!port_priv->fdb->bridge_dev)
+		return NULL;
+
+	return port_priv->netdev;
+}
+
 static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 					 struct net_device *upper_dev,
 					 struct netlink_ext_ack *extack)
@@ -2024,6 +2033,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	struct dpaa2_switch_fdb *old_fdb = port_priv->fdb;
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct net_device *brport_dev;
 	bool learn_ena;
 	int err;
 
@@ -2035,7 +2045,8 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 	dpaa2_switch_port_set_fdb(port_priv, upper_dev, true);
 
 	/* Inherit the initial bridge port learning state */
-	learn_ena = br_port_flag_is_set(netdev, BR_LEARNING);
+	brport_dev = dpaa2_switch_port_to_bridge_port(port_priv);
+	learn_ena = br_port_flag_is_set(brport_dev, BR_LEARNING);
 	err = dpaa2_switch_port_set_learning(port_priv, learn_ena);
 	port_priv->learn_ena = learn_ena;
 
@@ -2049,7 +2060,8 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 	if (err)
 		goto err_egress_flood;
 
-	err = switchdev_bridge_port_offload(netdev, netdev, NULL,
+	brport_dev = dpaa2_switch_port_to_bridge_port(port_priv);
+	err = switchdev_bridge_port_offload(brport_dev, netdev, NULL,
 					    NULL, NULL, false, extack);
 	if (err)
 		goto err_switchdev_offload;
@@ -2086,8 +2098,13 @@ static void dpaa2_switch_port_pre_bridge_leave(struct net_device *netdev)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct net_device *brport_dev;
+
+	brport_dev = dpaa2_switch_port_to_bridge_port(port_priv);
+	if (!brport_dev)
+		return;
 
-	switchdev_bridge_port_unoffload(netdev, NULL, NULL, NULL);
+	switchdev_bridge_port_unoffload(brport_dev, NULL, NULL, NULL);
 
 	/* Make sure that any FDB add/del operations are completed before the
 	 * bridge layout changes
-- 
2.25.1


