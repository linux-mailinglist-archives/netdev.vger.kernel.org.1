Return-Path: <netdev+bounces-302579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VX4pHTpXQmpN5AkAu9opvQ
	(envelope-from <netdev+bounces-302579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:30:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C61686D96DE
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:30:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b="WFmgQSv/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302579-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302579-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB80630AEDA4
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB193FF890;
	Mon, 29 Jun 2026 11:23:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAD13FE645;
	Mon, 29 Jun 2026 11:23:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732217; cv=fail; b=UTUxudcmM1NGy5osp274VyZnaZQ9fIqYcBHsi+1uXQ7hvA5zOfxj1tExj8Ld/lLqSnhp60xO5ra/RcWmf5QuGjixXx7SnSob8193f5TaTAcstkmph4vApG4HvRGI5rkDtb+SxTq1IOAVXZ/oBjwkuILWSw4QmPN2Y/aF8UFtUEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732217; c=relaxed/simple;
	bh=I+20vlXuoGpLsAPptKCmyAFAjYgIArTbrARcpS8aA78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ktpccq/Xbxlwwh9CWUThbHtWzdMjpvp3EsUZWQVWaETbfTUQeopiIMGdeigjI0FfPxcxHo5yQ5iBKYHCCvxFAGrTlyQ8lWsBbb6YP40fZU08zbcrlPz7KiUodEX7/kBYT9K95sUHMraWZM2V5JnJ3zmwagEzFdUYleHSRmP4Bqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WFmgQSv/; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdy68s2Z9JpsiF3R6FSAdljIhazOQYXUNOEfme4xKPUxix79kMeQmPkyWKMPou6/Lv56kLgyvWdwiKWG5dlQacjAWXWja/dauLGUwpANuPotzH+M7dqkmYVyfmqTZbqDH3TBptPWDyzY3JtbX1tM5RaYA1acBri/Rub98ia+5ttOPWQ3GeUpWVIYU7nG5WZVcaeDmsysbsSIN+raZ+H43xMqjSbR6ngbpimne6W0OrwxUnPqNqwT2drXwKvMv2lByMrq1XLuCJ+8mMWzHrx/GvzbhrT/S3QE4vBkYzyk/5brH+yk/GOE/F3qfd7idOV+drx191PTqwkkph8mDjxdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHbWQMB9n27dRZntzNBpgJo6VIu4zcj3EwzOzu2npYk=;
 b=NdTYWwE53MrkdTuKWEyepj3QeflGU5GPLS7VfC/PwKuZSOgDIFtI1eP8qNUPJX7B0WBeRu7k1L9nSqYQJYkYHaPI7ioaahvtCcqKdqFBua9m9L7BPXL7VMW3+CUL3rBJ3mxObHwk2vdJuXzqnmQ3Sc0ByAumunb/XoXDJsVNFfASjeJ0j58FrLEUgjWgdSjSUUeJs4DXElyLqu5TkB81W60prAHzQ4DUUiWYa3V2VxqaXDFCchaifRDDk/ZZu/LtbbHACaJcqZ87Iye2UjqWbRKDka21z8m4KgIMkEXs+99UeHpG9cSFuvlKcdobTpFmY6F9WQkETTaxv1nM/xEptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHbWQMB9n27dRZntzNBpgJo6VIu4zcj3EwzOzu2npYk=;
 b=WFmgQSv/qRdW7vJvwX2f6VhXRpIAYMTxMLzP9P9u3MbXBmkBNJg7OxWioogdEWE4AIFpnWc3g56a+yQwzm5hzRLWtp+/DpJvzF4M1TGsx7/kGjPVAQ3iCava0vZUnAnpDpJRx/AJqn+egmiTEW2+uAok8vCyTIu31cweo25dRufhl7xgSsIg6ULshKi1Ll4FnD6n+XY+9ODoAFLylK2ApD8gzKqjt8VL7TeUmAZjU0kuAe9dAG7dttqPHtDU/0+JXQAs/sjqWi5mbdwlenI4fBbxGxsst2trhHODHrG9Ou/+DAIuz/CVA9+pe1QzWYYEA9TM/VHtX1RYyIh4SjTAOA==
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com (2603:10a6:800:31c::9)
 by PA1PR04MB10628.eurprd04.prod.outlook.com (2603:10a6:102:490::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 11:23:33 +0000
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b]) by VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:23:33 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 05/13] dpaa2-switch: check early if an FDB entry should be added
Date: Mon, 29 Jun 2026 14:23:01 +0300
Message-Id: <20260629112309.154328-6-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629112309.154328-1-ioana.ciornei@nxp.com>
References: <20260629112309.154328-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0021.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::26) To VI0PR04MB12302.eurprd04.prod.outlook.com
 (2603:10a6:800:31c::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12302:EE_|PA1PR04MB10628:EE_
X-MS-Office365-Filtering-Correlation-Id: 1faf337a-1f08-418a-5201-08ded5d0dab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|1800799024|366016|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VUoogF7BJcGBjEXTucKThoAmkbvrkGaiR6MhuY22wdk3Ie1nXttwuJtYAkxVXveYkCNVLXmFRdJt0eqfYphFtwiAu2C42Qzq98PLyU1uqRu7Kl22Lcidgip5TekaSCAYCEfwwHswNywQb8Et5NHq/LSNnF59wKDgw1X0EnCEBiF4JHTlCf5NbvOZ7UeHXT16Ih51vNQhNYYBdJs9DlTOK8qKvWBxD0gpj8/kroZQYX57h3y9xIEZ43zUUOmmHAHBeMwC75VmWrZ+h474KLkMgkHTDs98S3IuaooG8AoGktdgBBF8GKU5y4c4Ube4kvF0jFrP1ai86QQa76d6EsGu7sq5mNcbjeDs7iSJanpClRySDyKi4qpskoS9JMYU/8snfwhWezQuREn8xIucRNBrMt/hpfuWkiE/nsJ57ZSS7SlCsz4STLJ1wCFsfSkYfz2oiFL5fogWx02Y1kcIxjoNoZCKNU1j3ckx+pc+j0Y0jhtkry5/5i4ynyujHnnSvsiOl9KFx6pQBFGyxmaPKylzTjD/dtB26vtShZtFHspgU9F2mL5DiyLRrC0BUUoj0OvaIR4wDtpcchBeCD7qxzcwNmrIi3xbw3GV9B6XTbXH/ICf2PRfNfpf2OIx2zN7hspKl3bi7hQCZEp+ZHprysRziTrCbV22CK8yWkFzihj+1c4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12302.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BeIzaE6ZCGhsaDJnz4Ew73JSUL3a1KgqDwoSszdV33Q+ZFE0uujq/xjxDZho?=
 =?us-ascii?Q?dbcfR5yWdNXo67nOYSKH/KXNjjnoRrbIp9Kyd0YW5eSrax76S7+JQyu94hgR?=
 =?us-ascii?Q?tGioaaVhzM3xe4uim6RVV4c2J7c1bwCIhJ1dWSzAxhOLm31OVFQHBSdgK+/x?=
 =?us-ascii?Q?MAPrr89JY0MlREU8AQhBNh/anAreEZ2kvJOmBpktvGfQaJ1GYZ4GkGc8cI0u?=
 =?us-ascii?Q?jOO+reQ+0xqaQ9WVkhGBoxynpGeDayM9HItxuXAuGCtNQl6MpjzDWqLuyW+m?=
 =?us-ascii?Q?03kgqlI3J6ujISjE0xqYXFwmRKfqyQ0AA9H+5R/3MUGbDbHZgkChq/8A4KI7?=
 =?us-ascii?Q?TDfW8RaQqPfqeHNEv9MT4dZ9e/iVxVBW4USQuKIApZIfELcJI/Ee3K/7jDl3?=
 =?us-ascii?Q?LXnrqfbXXlUXXX0oGkLfGzpsjJg19hh9B1Wd0kj07L+AfGoww3Ni9W9K3roy?=
 =?us-ascii?Q?buG0rcelD1RyXms3/g2Hgq+vBK9YvSICCRx+sJPsYy6guOYKOkq4XWvCKyGq?=
 =?us-ascii?Q?4TswOKkyxOE9B8OvKJhy8RKCsyai36g4m7S3/F5mwQpCmly1We0x57X53jAr?=
 =?us-ascii?Q?AeG5gwKNL2+P+iiUq0rc6AdCQS9016KjUD2Gwu6S/CwLf9z2tSiCy4Ul3G94?=
 =?us-ascii?Q?M5dpHWQRqoz7zn+AYyyN70RdY6g93fp6UEzi5anqvNfMvJ5orWEFQMboCFYz?=
 =?us-ascii?Q?NbRSFK//PqoSRq9Ao9lY2RC7cGzZz9pDOR/M6lflqJrdOHHuCFmzlnuq2I64?=
 =?us-ascii?Q?Fn0T7aYJmRJmAqI+WF6cmL1tTM85ujuSXXGK6DjRII+NfEJHxqX0Rgz3ijQ2?=
 =?us-ascii?Q?/RoBv3FG6NuBkLNBFyckW9HK2ewj1FOs3538WrBPJgStnUg7VjMchuotsyuY?=
 =?us-ascii?Q?MljFmZvtqkZjLVBdlI0cL+qSjDeriow9fLPoVxnIliGXdh+ziaN446/EiLZF?=
 =?us-ascii?Q?OcOF/uHz5w9qtD7MWvEERlvJPtGh5sxvXhiVwoGxFc7WRKxREpOY0c4yVc3N?=
 =?us-ascii?Q?iUZ9/vP+SYSeikeoY1Ls3lJVNKPyd22o7CfariLx8CYpicFLorOcVEJ7k9IG?=
 =?us-ascii?Q?TNZz1jsjhD00nvnZshq06HpfVctULEo3z2DmBiC7t/vk6hnY1ia85M0NS7pF?=
 =?us-ascii?Q?bH9U8ZCPOgG0tWSd4GDUh5g2mgtqq8lqoHd8M051Yf+gQaTyQaz2+W9oRqGk?=
 =?us-ascii?Q?ORofV6AoHPGKX1GkAvf3m2aX2WhAp6A6Ee6YljpOAcsHNqUGAPgofXqVglsz?=
 =?us-ascii?Q?8crFV/OytphFh5Z5tZDwmPtTXneb5QrQVR1LDno+vgMxwAlAVwCLpQtqAoIb?=
 =?us-ascii?Q?t4Fx6KiMcl7mZTJ7/D4dbJHWm4sq0TJKWpSqKnCXI5CL1NdA5dKdsbBZv9PT?=
 =?us-ascii?Q?eJea0H4zLEEcv6b4PE5JiZN/U/VxUCIibzdhFTU3U3U+cZW6qfPhQq+kPM9k?=
 =?us-ascii?Q?w0DpovUSO/Mxclv9WYp7yZ3ZwTCt3uibH/fwgHeB+JA/Q3AyUYyWzLc3ziGN?=
 =?us-ascii?Q?wO/QNLkcmL9JWLt0vMNK5tEFr3X/9HkPrQ2aPhHlflj2CMDOdTUHwnPy4OKy?=
 =?us-ascii?Q?Ub70njyI8MTcO17OgWztcl7jGRmhJ33Hbs4A/UhBGRXZegRkjgAZip+ts2q7?=
 =?us-ascii?Q?RiqmSpKHb/bRrAWbRGTJ3iMcp2xIxkml0wZLfaqsxca+PLj6kQIou7zL4hMf?=
 =?us-ascii?Q?4QQuNhBjCJKxkFyiyn+VMgsDBhphOQgAKP2eEwxZInVme5O8f0LAHt0V8e/P?=
 =?us-ascii?Q?WQbIsICQBg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1faf337a-1f08-418a-5201-08ded5d0dab6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12302.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 11:23:33.3330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RWxorLIpQNehmodLbjiOuw6KPp0M2xg1jgfzkF1OKe+nG9W+22SNdf3fJSxlNfGkiOslJQeReoRMur45jawiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10628
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
	TAGGED_FROM(0.00)[bounces-302579-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nxp.com:dkim,nxp.com:email,nxp.com:mid,nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C61686D96DE

Instead of waiting until the last moment to check if an FDB entry should
be added to HW, move the check earlier (before even scheduling the work
item) so that we don't just waste time.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- none
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index c7c84bf2fde7..d4975d08fa44 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2308,8 +2308,6 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 
 	switch (switchdev_work->event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
-		if (!fdb_info->added_by_user || fdb_info->is_local)
-			break;
 		if (is_unicast_ether_addr(fdb_info->addr))
 			err = dpaa2_switch_port_fdb_add_uc(netdev_priv(dev),
 							   fdb_info->addr);
@@ -2323,8 +2321,6 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 					 &fdb_info->info, NULL);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		if (!fdb_info->added_by_user || fdb_info->is_local)
-			break;
 		if (is_unicast_ether_addr(fdb_info->addr))
 			dpaa2_switch_port_fdb_del_uc(netdev_priv(dev), fdb_info->addr);
 		else
@@ -2350,6 +2346,9 @@ static int dpaa2_switch_port_fdb_event(struct notifier_block *nb,
 		return NOTIFY_DONE;
 	ethsw = port_priv->ethsw_data;
 
+	if (!fdb_info->added_by_user || fdb_info->is_local)
+		return NOTIFY_DONE;
+
 	switchdev_work = kzalloc_obj(*switchdev_work, GFP_ATOMIC);
 	if (!switchdev_work)
 		return NOTIFY_BAD;
-- 
2.25.1


