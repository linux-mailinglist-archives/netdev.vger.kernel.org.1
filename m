Return-Path: <netdev+bounces-278668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBCTIOIq32nOPgAAu9opvQ
	(envelope-from <netdev+bounces-278668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:06:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1B5400B4B
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3A77302337D
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 06:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89526328B5E;
	Wed, 15 Apr 2026 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SzU+Lk/w"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010061.outbound.protection.outlook.com [52.101.84.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C8540DFCB;
	Wed, 15 Apr 2026 06:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776233180; cv=fail; b=eL7A3B7Lhi3wZDMqb61gubZZlpucU+K0hEV9SEQcD8iXRblXbrYRKbfD0dIb+ztLSz9g/08JrVgAjYhjcga5VtqD9nFRBasFQOPNhSd2cei7GoEH3H7DAKZOva7oKYTRzhjqQ6o/u4vTgDGVGDjSMPDaQSXulsMIaw0bHfw0Hck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776233180; c=relaxed/simple;
	bh=F1uyjoV4pk0EoLgY3jGtYWKFtzHwivwiSE3zk1vOofY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pjodQJoqCfFi/IIFUKIE1aMIudJCHmeUdU7BtlhVP2Au8ImLXxsg4559KP1lnBcCAJdpdaYVdcuxEmR2dv9/dDJJG6agTwmGlUfvcBYcnd8e2dg9AumMXWVz+qNH/RKaPXnyNV6HScEirTxSjn64q4PkwRFXmMxINJX9q1L9Roo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SzU+Lk/w; arc=fail smtp.client-ip=52.101.84.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUWOLNdrwQalDJc7+xBCOojbNs63ku5I+JMGONl4zWysiaFNhTqx0umhBCcQBm5LcjoX4LDyyrBFs5EUSoucU2m5kwKFSOGHvyQUJaBtOjmpLN0rYgRtACMJtvO6/BGkhriMh5/jveq45kb7QnA8mysoRufLJWYCKDKHTstT4y9hZKlKtaiAUZEoK3Qn7DzoYyhIBcbf/gxRrHcY2/Wl+N5qglF9IguJ4X1CsZmOmloUpkL+xe09+PB1YNQd1AOvm/JPq7N+Nf8KvRdfc21mOhiq8HuXqjMPNZQ9pQ5JQX1zZH8xx08AqxlgHXWFqbD5ZeUekfNeg2ueWouQrNh+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTC9lJCcpuLOSzNBVUr0uqWnvlBZGJTmTziOZTPoCGU=;
 b=sWiEw3ONP0MKiEAxmBgLMtpdoomerbpKxy/yMONIbw6myWC9XTKpCdpni5cq2R55cVmKIp2MGX1Gdi64PIBpuyOkMl+4K4Ik8dF8v9Was9oQuWK8JHX557ZIYugPDLcQJp1I2YhjYXy5Yqpn2erJO7eu5Xzv9RPalNdmyUtAi52pdHEfEONFGvbOYWje7ih7SWsIRyhOOdzqIx2TbALEoGuym21m1nHeBQiinWI7DIjs0uEugu9lKfnotcILsE/nkimOTRKqP+GUiB2Dm36JdgK6vY99MJ1yT9V+RSZGviDwEHljh1Dd+wYGUMIC6MHpBEW8rIobhRnzUKjWue3agw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTC9lJCcpuLOSzNBVUr0uqWnvlBZGJTmTziOZTPoCGU=;
 b=SzU+Lk/wxwVZzR0yS2sf8qjZnGzTEtVKWPQHs+wUSNs4iwHYpcv//STTO3mKAB5/fkownOU1VpoJmlEhFY19LibwokpB1dy+zJ6Pz+3vkGwZdOifopWNvyeK1Qe3VSYQ8qpEkoSbo1+E/dLHjfxgfp9S4SjxYmXOh9rgHLV1Bvt9THuIJCULb98dNZMOg0vizOxRR/NuhtR3tIF7GFDlRTmt1RgD9vgIccrUszl069beTksdnufJzi9UeCM1+cm8hZMCq5VEnnKtG9130/cU+muso6tL5DnsYltvb82gPZNNrf1HwcWdzwTGSan1LcTECWxbPSYSBl0jsxWM+iWqnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by AS8PR04MB7701.eurprd04.prod.outlook.com (2603:10a6:20b:293::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 06:06:15 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 06:06:15 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 net 0/2] net: enetc: fix command BD ring issues
Date: Wed, 15 Apr 2026 14:08:31 +0800
Message-Id: <20260415060833.2303846-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|AS8PR04MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ac28d0-4c88-499d-bffe-08de9ab51a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|7416014|1800799024|366016|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QGTyigMAhfAhu92czqsz3TkoCnUXMgaSRjtq9V/ry42n28FBhKmRDKqJHGm+bqLYSqvtR/LXZhVKGdFlRTYmV1/5xnF+h4VNLSFyrY32/ov5qUDJPkqB8KXQ5xXG63Ey0haHTyUmUxL0yCMyijZ2DCS7OBkcuGJ/Z7HEBf1bHMHaCtbWpgmH0PNfSgtWSR2LrEFg/QMotz9izaSHLcPlbjtuRDp4cJ/PIlLir+xDypw9lB3XP/OAUOHLpLCFRrPP4Li3EDLJfrWgmawjlHiQx0QoIPqliIZv2LBC7W17InKA2M+53rop3NzXac4l68q33NxhME+5mq8T+Y5IT8cK/RH/A11txLeodnQuh3FUyCKlENODxD46DjLd0/xCQ4YnTgu1MwfQHsYUWysD8S9DCbvtCYBAvrnJ84Ax4ZSudJsZC9gPVqZMauQL1tbllEUl449nJWsCePBzrDo5ofujqjNLGHmbY7QYh5Nhute696kaI9cRPs8Od2znGyel6q9SYEPexcurDpRM7YhkAqDul9/ircy9ZdxfBnyneZEs/Dru4YpJlN/uNO203qPJIGuKT6Im0+aTH3X8oJdrMaTKp5dI4TVMNbxZBcI1sjTXsLdV0pW5oTRVhutwGdLg6gKEOqorwdk0gnYRTXsK8u+YdQJpd3Aqm6EjImusGyiudGDOAZNMozCf7f1C09R5kViifzKe8oqp7GqW+5B6+M/5FsDn8J4n9u6lniMk/jSApkDUpfZ4LSxIhUUjptr5yemANgXYuGXA9MxEOvlLA3By/i1tn7DF7b/E+SUf+AlexQY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(7416014)(1800799024)(366016)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8KLi/qA01vm0EtFdD93NwjjJl1qJprNbY9E5rqH0z1BTA/O9b536FErcR5PR?=
 =?us-ascii?Q?mKfgimt9wn2+ErYgbJO7ItLIUnRfJV4OuU/FuVD49D7u7TzQ4JXPzLREUU1R?=
 =?us-ascii?Q?HppIO0/t9RTi7hG1aATUoaD0CtZcrTFlsQ012dkHXY2NZ4dk6D8FQuklZde9?=
 =?us-ascii?Q?NXITQZn5Le+xHTGXa/tpXS9yO32TE2g19BO0EWcd/wnvxUrDP+n3NRDZSbll?=
 =?us-ascii?Q?0CgiLcrHXhdWeFPm6OapbCy7QqykiIT5gGymjAF6spd6PL4uflIrGo3l60JR?=
 =?us-ascii?Q?MF4HL3FHDddFB0fBhKvd7Wn+QpT+QcJt283grb0yC/NGEliVOdDXdJM2uBDb?=
 =?us-ascii?Q?GnB1ddzMsdmDlYB4GwVcgwJG9mJjWoZF1bQJFBBNK70FqAHVkNUB/LxXZozF?=
 =?us-ascii?Q?yYDrltPluibCamBefcb40q1XgnL2EMAK7AxoFLPD/qAR/yoYccXzkwhoIThc?=
 =?us-ascii?Q?rurJ6KsqPt2e9BFISvjDeQhJFF5cNnxVKVFZwXWc7IL2AL2x6ZuW3y2fYEHA?=
 =?us-ascii?Q?h8uQy76hPGmey8JPBzV+PTltp1kskZj+SDr0ytl0mBmSWlHGAJnDOF2HaNtY?=
 =?us-ascii?Q?G/1sgoHSrL4lH+P/53L2Ki9dkd2+9IRdAXyxYbYGoMnco/MJZ0xX0bC9aQO0?=
 =?us-ascii?Q?nj0MWS4mHvt8sL0a3EZfH82zUpv0nxOV72IK24pd87M/P6x9Pmkd5lnZsI34?=
 =?us-ascii?Q?mymHmnr970Jdooges04CQlMLgUXlEL1RJjGy6dBPQgugOREZhMDn7Zeh3ex9?=
 =?us-ascii?Q?XJCXFLXLwUIzRRriVe5iGkjaVSca5XwgbdDr70gtH++jm6d2+CKJtC8oWbjr?=
 =?us-ascii?Q?Q3cF1n7dWH6RTtgI7hNT+KID3XvIATNpGp//8nFGvkjfudE89XlOJ5Q6MCDC?=
 =?us-ascii?Q?ksb3rT92ALSPdgzD8BGkJ6T4w7E4aj7+nvmj5V5Llqrp16s1x8ut61WSp8fw?=
 =?us-ascii?Q?XLDzVdcfIa+sVs58+rn13L7KD+r+vQhIVXXM1fxPP48bgerXg9/0DvPYsKRD?=
 =?us-ascii?Q?HNbuShxTF/T4ROyqQe1xlOgiWm/lsHa8iNUxk2hwblhXn7xp6KJd8+3mS67/?=
 =?us-ascii?Q?FfnBUMPfLL7l+stpoRy3+FRoSdObrVLH+uvKax5FyT7ITrKoCtTPzqx+0cHD?=
 =?us-ascii?Q?Y1Bwv9tX9YMbG28qCpVQeJUzDxCaN/eDQBTSelPgDpkvATqwgo0BdiQfjKNZ?=
 =?us-ascii?Q?JCn/eWvrSzoltvfmyuVD1XuggPvat6ColCBfiHF7HBh/NgKyg0qOR9G0fqVf?=
 =?us-ascii?Q?Ltaxq7BHOHuEIOg7daqWOxGum1equcbnhq+QxUE6YfzHQnrDdoFNhmnorVDN?=
 =?us-ascii?Q?ZBsum0dfqDEiDz24gLRI727i+mf3AlB4q7gAL04KXD44P6E7iaydPsws/IG8?=
 =?us-ascii?Q?Xw2EicD14mhSbiYV1fkPGHNoWgY0IA56PINKsTOjrKZ35LnjXpPQzMxFmFVC?=
 =?us-ascii?Q?dTfK7MihfEhynTdrmFNnHkzHn3REC7N1EpnMNdEebc/vda4V9nP0cLm+1I2M?=
 =?us-ascii?Q?nOWtltleWygB6rMkc/uJTO+SSEGBK4SiIjGDDbUiW2gEF5zJ2x5pwUZOT74O?=
 =?us-ascii?Q?CazJEJVeuOmVXUT6LGEQAAqkDjqbg57rbHgPSSBVj33pgbspYn4CiUlQINTi?=
 =?us-ascii?Q?Tn/fUd7ia/oc0Kehby/IcIAcHHtenQu08yFtwKnycU9sA27bLGt9rXsDden5?=
 =?us-ascii?Q?hIZs2p2LI/4BMf+5uUZwOat7P2acpPXS1Vx5O4PzSHZBfnyO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ac28d0-4c88-499d-bffe-08de9ab51a14
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 06:06:15.3009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9zuiyu3N/aNHsa3LMMe0w8VMEkQu2RWapnklxGZzmqx0vApibL9Yr2dSVg5zeZEGLuVFafpplg5T7to01rZgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7701
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278668-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: CC1B5400B4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, the implementation of command BD ring has two issues, one is
that the driver may obtain wrong consumer index of the ring, because the
driver does not mask out the SBE bit of the CIR value, so a wrong index
will be obtained when a SBE error ouccrs. The other one is that the DMA
buffer may be used after free. If netc_xmit_ntmp_cmd() times out and
returns an error, the pending command is not explicitly aborted, while
ntmp_free_data_mem() unconditionally frees the DMA buffer. If the buffer
has already been reallocated elsewhere, this may lead to silent memory
corruption. Because the hardware eventually processes the pending command
and perform a DMA write of the response to the physical address of the
freed buffer. So this patch set is to fix these two issues.

---
v2:
1. Check the SBE bit in netc_xmit_ntmp_cmd().
2. Fix DMA buffer leak issue when netc_xmit_ntmp_cmd returns -EBUSY.
3. Check swcbd->buf in ntmp_free_data_mem().
4. Move ring_lock ownership to the caller to ensure the response buffer
cannot be reclaimed prematurely. So add the helpers ntmp_unlock_cbdr()
and ntmp_select_and_lock_cbdr().
---

Wei Fang (2):
  net: enetc: correct the command BD ring consumer index
  net: enetc: fix NTMP DMA use-after-free issue

 drivers/net/ethernet/freescale/enetc/ntmp.c   | 217 +++++++++++-------
 .../ethernet/freescale/enetc/ntmp_private.h   |  10 +-
 include/linux/fsl/ntmp.h                      |   9 +-
 3 files changed, 141 insertions(+), 95 deletions(-)

-- 
2.34.1


