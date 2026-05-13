Return-Path: <netdev+bounces-287533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDF5AhhZBGozHQIAu9opvQ
	(envelope-from <netdev+bounces-287533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:57:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F08FE531B91
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6545330237D7
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526063F2109;
	Wed, 13 May 2026 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NwrhZ/xC"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45103FB05B;
	Wed, 13 May 2026 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669824; cv=fail; b=tIN9zaPclpJXP5fXs9J994ZSTnIVJHNJFwS35KWu/U036+OcFeZHFfnd7grnBzvESYXfEl13fpTTq+tPL9yIYNk9rVkvzbobjBPrDVmySdfgYNXdS8+rdqRuuyIMuUtpZdz1o89P98k43GccFAzu/XjUda9hiNufSRQ1P4JQJB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669824; c=relaxed/simple;
	bh=Z1JfiqqHEkkNtT8VcxL1giiotJZURYF6B3NqxvyGFrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=czWwzC0g1bK0cmP/wT5Z2be6+p8+rXk9ZmVohu6fD/3nfHZwtDoDT5adU9R4q4qgA1UXTy1K+jf+YglQqa5STyJegzxFUJuFWBNLOoyOHUE1dOpfif2fGoQtlcRU3LOWriGSiLV9IbdhhECdQEXELyb8J9C7b/EKlwW4eCTmQ4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NwrhZ/xC; arc=fail smtp.client-ip=52.101.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKzYkv3pUUxrVAeRLfK85PC88xeWAMjuwhUVV4AO/8NX650rxcne3dzuwFDpbZku3szisvjXRodG+8KwKQ0P7kOgNYr8luT+CesJQeoDm5uY0LoCQJQeDSzm8wTlDiBouJbsvcRmoC0XYLuCtcHWK/aPQBbNlizHmPwMXIJF7jN0PMoJp91Xby6xbyFv0V4IfR/VwSq/RpyP0ouCJINaxAre3+g4OLomKm+ZA6gbF+rAkiDjtecfonPyp6ZgYmenKh1Gahz6qMWSmEE4oYPWxFmp+39UmKGDSXy3v0W23d2XxcSVk/LXcAc3W+LdLTmLuYSkI9rAkaWTSWXJG1zvDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvN68+eALDE7l62J9EyB1CDq1+TkfzMr/LqAjqMMMnY=;
 b=RK7lhFlup7ohB6+5qRWtlm7ciw6cHTleXWQ+cp26adfpqFLqrxUoXcUhntLqGHJUhc3U+cdSOTdxgNEM+5bHwS8Z96/JYYi3n8+cbodWuUyDzVEdJ6Kf3ZsY02iAswL9DIlnEJ/K8ulkjKQQyr2eean6d1jXAriIbVzEnuAbKF/VITBKHH7s3nRoa/Yi4kqje/z1+38EVomB95e9RhiYWypoYgN2kkApNbhc6/jJvzbpVIJh2MMD5q/GNo8eJHdY7SzpHJeYUIQCA4r0xt3SpyTfO+aS+iW43tcv0bfHnjfGODQnDDMmokxQ1vYTNQgjU2edwnmYP9cSMZMNqJWgMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvN68+eALDE7l62J9EyB1CDq1+TkfzMr/LqAjqMMMnY=;
 b=NwrhZ/xCrnCKGa1KDd5JPctBtECr8EfxSlQelF98CkIrZsC3k08Z5bsp3GLyDnde9zMn5/ZJ5CgFPEWByYXYygiwUUUXNBI9/4wZOb4nA+l4riP+Qj5O8McWFwhtfPpr8ajqLYjtyY1xhTAPzXXUXS+SHJcIJqM2XqC+YuMRdhHV4hnyGloBxqEYXyAaIv1MCWhkM3Tg9fl6OG/2g+U6jNl4ED3958zhD2W95k6D0ISS8Io43ada2Xeicbe+jhMNdOdUsTv0l3s7JncelAlnom2q1LI8PpeSdvRnYcM5Cfb/SY3DeD3/jogSVUQENuHp+v7PvqrRFBiNGtlVMf0G1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by VI1PR04MB9788.eurprd04.prod.outlook.com (2603:10a6:800:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:56:58 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:56:58 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH net 2/6] net: enetc: fix race condition in VF MAC address configuration
Date: Wed, 13 May 2026 18:30:17 +0800
Message-Id: <20260513103021.2190593-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513103021.2190593-1-wei.fang@nxp.com>
References: <20260513103021.2190593-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|VI1PR04MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f5c48c-8e64-4b81-6bc7-08deb0de5a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014|11063799003|56012099003|3023799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	M4LZ1yLLmb9eUGojZVH7Z7mPVLoyVOJR83mbJZLCjx/P1QIo/Tb8ah/xXMhNAROgq8uV2vMucIUW85xq4ssL7bEJdwI1yOP1eXnsdQ9l9s1hE0SwYS6rdEYOcpEM6n8/4eJrEVbywfGXnY07dlpBgwlQgt6JXE43CAToem8b0N3SuQ1z+dajK8dQZrBMo/EHGnOUN2VcXQYq1RQAO5REzU6Y7jbsYT+/IlK2Q01f/RKFsN01i6wMXskD8xu+JSESN8qt7I5J398UjOGpRr0e/dtEK/RV6QZLG7J7bZC9nSgLkjHVqucX/qYxrIbIOSdKiBxg1DJUR98XRWfh8GgzdsFcUqLEOLAyjPNE5IjvaUGSvmlyFMqYGdSjkHUkx2Oze3tVRqrP4OScUkeuLZtpzDncv3DCVrX6z4unDdP+0nnge2jthZzzBABNuW1/ZzOt0dzCR5oEPaQsom1VfbViEm9UvRdKd4KWEfDf1yWdGTShwAHKXMyCMPWuPXVIiGpq9ojFKJSPOHv83PPZm7hIvwNeS3jDVY3F4TBUeKzYXKacupWkFyJvpalmOwvQfdLg0v74C2oPAjw2dVAGMyh/2zXRUyyYu+zWLtPa2aOd1Ef4uI45cbJcCjN/ocrDKwk8ruL4EzWywyBuzatISXOJMa/yHG6Z4qT1BKKB7APlMEddU4KBjEON0N41y3k9RGV0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014)(11063799003)(56012099003)(3023799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ra/8NxKUWN1R5UPlyQS2oTyFqy9v759Ilk+nTlUHIrnubnmhiyu1yaIIrngU?=
 =?us-ascii?Q?6ltINjkkk/hAZgYWq6rPinjkKNhqE917/f5ELAFkCO5UMZJD4OsPj6uKtC7y?=
 =?us-ascii?Q?KngwmZ6N8PcS4aUPO3kUkvczwXsbXdKqZ4S9rrec/Tt7FDLRPC+G6FkmUD5/?=
 =?us-ascii?Q?xs/roi2Vi51JlPSTQTC2f4u37DJ/7VuWCqX5AExB2tLWya5ZXlmQkOYSI0Li?=
 =?us-ascii?Q?707+oxwSVX7IPPig/CUIJoypSFwaoylCColwXm02ad9U9USe0pStx/JS/caE?=
 =?us-ascii?Q?O7eAsNBpdcVtGqG4eJ26iqCXBwGNkwEG2WY3CmtNqEfU3LpwLrbvtkD7PVxh?=
 =?us-ascii?Q?oAzu7p0Ur3nAaoU1c4OwJsUxLA+usgSjhyq9uqh+A2ZWRAS/eC77HUUOgLaf?=
 =?us-ascii?Q?pMrW4uUzW20+UukXB/r/Nt25AcD4mjkWMw3uvy7w8G+UKyRv1O4Qp19EmFb+?=
 =?us-ascii?Q?QeHW5TlHdMgSb9cCsc4qUYHgbWGDA56bWNoJ2lyM4KsV1o2SXeJ38zZlNQzX?=
 =?us-ascii?Q?ehERCILM030D8yz2tU9Z6ECf9CWyupuntijHLje9GvrVqgnU47Ig+YsYKhLe?=
 =?us-ascii?Q?7C7xhoUJAldxZBm+3/kBVd09mBDC9L3/TWdx6Xv9YyiaKyU8hydaY+Z7kX2E?=
 =?us-ascii?Q?z77AcjMTI7OVJseujpp696u+A9PaEhhI7JWvMh3Kg/xWu9nwLUuoDy6CYIEr?=
 =?us-ascii?Q?URxTpcnjxGI3sOR5+lz3mGj6wXJQnY+64yKVq2IltdiVenVsgklKKJd+x7Ia?=
 =?us-ascii?Q?3hJeRtjoiRs74scNii8Ggw4JAOBb/X6pIQAMWHR6fti20a+AYSAzU4EY4axE?=
 =?us-ascii?Q?uTgHXvwPEo+GpVbxn4XJJ6gRggVHFpRmns+ANljKoAFFpjzsTsTtk9hr8Wud?=
 =?us-ascii?Q?QcETvC9OsND9pb1O7fN6wI/7CPorB3Dut2Jos8ezmZ3L2mouoRTHBWkMUNiB?=
 =?us-ascii?Q?bz7msQQY9jrrRXaHzowx3ApnXyldqem5S/EBLiM9ClXQ2u3KxbNX3XXbps+D?=
 =?us-ascii?Q?xU9uBwWSn/qESgJqheiNzyl7jNTqlWH4iU0ORnaNmRgzfLZ94kGJAEnfDYWV?=
 =?us-ascii?Q?9GXKITi8BkPGEd7/xFdkePSouF+YM1rbhyLVh9NKpQyaeJv+6uGKNEijNNxV?=
 =?us-ascii?Q?zXzZQNgsIhGmcxWOWn2LTHd0i++vf4TZtB1UQx0O5SG8DDewFmBac3sH2WPA?=
 =?us-ascii?Q?ylFu2G6dfOpqdzZgZQus/i2FONOT1KghU0QZ3bs9uV0oMWbTbV7er/LE14W2?=
 =?us-ascii?Q?lmR3bLHaNtwbSgaVuz+0pAlvcV+7z9In5m2xziPGriJZVvMEY64qcx1feYkf?=
 =?us-ascii?Q?Enw6djPmlLKwcV4RZ8ut+ZIBBmR41AVPxJ8bF5DiZKehZMFJDMu6IPoZRQAU?=
 =?us-ascii?Q?DkQqeiA7fNlvEZbV2GoOYrOYPRyy/ZPD2QXcVT0dovWIKWT68aScGQkmclJk?=
 =?us-ascii?Q?oSxAWOdo6RhM1ntp6fE/DDRvrPSFj7H/pfKiAc28Q0fGc8ytSUv3mumDf4UZ?=
 =?us-ascii?Q?2z7YfLlMlxJNDXqLCqUuiNtGFcJvbD/FrPqw4+1UCk5bq9A57TijUK5/Nf7s?=
 =?us-ascii?Q?JHMj+MaBv8Gbn+UIa4Gta8jwCwnJMDGVSjFf6rgfptLtSw952/aFR54ZrJ8I?=
 =?us-ascii?Q?CIG5gan1LFjcdYwVB5QVhejwwhtxX5zwyjApWh6Wtn2XO6821pvQH2J01FMB?=
 =?us-ascii?Q?OznlG2OGjm461mRsriVmSVgvuTD+8D772Ln50JMo8xaHOnoPjh3oHiAVT7nm?=
 =?us-ascii?Q?YZwMD1qDxA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f5c48c-8e64-4b81-6bc7-08deb0de5a9c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:56:58.4975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mETwqKtSLjzMtgTk0chCDZv9zmzONhno/Q/F6w3DHSB0bqNwZH3BxMIKE3FcufzybopUv/IzDPfDBl2jLKEt+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9788
X-Rspamd-Queue-Id: F08FE531B91
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287533-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Sashiko reported a potential race condition between the VF message
handler and administrative VF MAC configuration from the host [1].

The VF message handler (enetc_msg_pf_set_vf_primary_mac_addr) runs
asynchronously in a workqueue context and accesses vf_state->flags
without any locking. Concurrently, the host can administratively
change the VF MAC address via enetc_pf_set_vf_mac(), which executes
under RTNL lock and modifies both vf_state->flags and hardware
registers.

This creates two race windows:

1) TOCTOU race on vf_state->flags: The check of ENETC_VF_FLAG_PF_SET_MAC
   and subsequent MAC programming are not atomic, allowing the flag state
   to change between check and use.

2) Torn MAC address writes: Hardware MAC programming requires multiple
   non-atomic register writes (__raw_writel for lower 32 bits and
   __raw_writew for upper 16 bits). Concurrent updates from VF mailbox
   and PF admin paths can interleave these operations, resulting in a
   corrupted MAC address being programmed into the hardware.

Fix by introducing a per-VF mutex to serialize access to vf_state and
hardware MAC register updates. Both enetc_pf_set_vf_mac() and
enetc_msg_pf_set_vf_primary_mac_addr() now acquire this lock before
accessing vf_state->flags or programming the MAC address, ensuring
atomic read-modify-write sequences and preventing register write
interleaving.

Link: https://sashiko.dev/#/patchset/20260511080805.2052495-1-wei.fang%40nxp.com #1
Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 10 ++++++++++
 drivers/net/ethernet/freescale/enetc/enetc_pf.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 756614ffa8c6..6939ab04dcdc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -252,8 +252,12 @@ static int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac)
 		return -EADDRNOTAVAIL;
 
 	vf_state = &pf->vf_state[vf];
+
+	mutex_lock(&vf_state->lock);
 	vf_state->flags |= ENETC_VF_FLAG_PF_SET_MAC;
 	enetc_pf_set_primary_mac_addr(&priv->si->hw, vf + 1, mac);
+	mutex_unlock(&vf_state->lock);
+
 	return 0;
 }
 
@@ -499,12 +503,15 @@ static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
 		return ENETC_MSG_CMD_STATUS_FAIL;
 	}
 
+	mutex_lock(&vf_state->lock);
 	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC)
 		dev_warn(dev, "Attempt to override PF set mac addr for VF%d\n",
 			 vf_id);
 	else
 		enetc_pf_set_primary_mac_addr(&pf->si->hw, vf_id + 1, addr);
 
+	mutex_unlock(&vf_state->lock);
+
 	return ENETC_MSG_CMD_STATUS_OK;
 }
 
@@ -968,6 +975,9 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 					    pf->total_vfs);
 		if (!pf->vf_state)
 			goto err_alloc_vf_state;
+
+		for (int i = 0; i < pf->total_vfs; i++)
+			mutex_init(&pf->vf_state[i].lock);
 	}
 
 	err = enetc_setup_mac_addresses(node, pf);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index ae407e9e9ee7..35d484858c7b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -14,6 +14,7 @@ enum enetc_vf_flags {
 };
 
 struct enetc_vf_state {
+	struct mutex lock; /* Prevent concurrent access */
 	enum enetc_vf_flags flags;
 };
 
-- 
2.34.1


