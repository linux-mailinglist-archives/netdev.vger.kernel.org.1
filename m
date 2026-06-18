Return-Path: <netdev+bounces-300376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bWkIJEa6M2ojFgYAu9opvQ
	(envelope-from <netdev+bounces-300376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:28:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3112C69EDD6
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:28:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=bShKZyQH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300376-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300376-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81DAD3014A80
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2313DB332;
	Thu, 18 Jun 2026 09:28:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013010.outbound.protection.outlook.com [52.101.83.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6453DB960;
	Thu, 18 Jun 2026 09:28:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774908; cv=fail; b=m1nFkp85fos9y7ts1MM4kHvDQJCm0drcTK2dc+hR4FKI6PXzDN7GQEXGbwYz8bBOuwfaz6xK/YGwG72rFt6zXdyzuI2+cFkYg6hqocAFPjY+dwO5TPeBSRrGU0GRkzsVAuoHsboKYQsDp+ZrvuHygMn7tLFsvYM9rDnBMEpyudI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774908; c=relaxed/simple;
	bh=0m3QcCKzGJMMhja0x1xMnijEz4wK437bwSHxVbJAdT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=byl3JazIok4K2/5AMhoUfdH2DAmzvMyl1jToYVkmpdRZSzq96bnNCJ7z5nay+Ufj4XXXdeemhCTXHQExIcNKOFPFNcSIJvQbReVKQ9LjhazX4GZQkHNQlRZ8KBLYghQzBNH2//6z4j07fsqB26A0xrXdg8wSNG2BSYdz4O27d/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bShKZyQH; arc=fail smtp.client-ip=52.101.83.10
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBvRKtEC+WOWvcYYiYUAGhO32K56AWSDaWbs9ocnNB/6Pgf0qnAXCuWqsZyJy72r2YPqrnAI8rPnOMWPK0/Zv7co916DVnTfXPESUf2ojeP7Y5ecaLDzt/uXJK9T7DE5HMgdNXu2nhHaEKEvFh1juEH4tWHpm0dE8PewDnQFVwIYzwlrwGRL8Sg3o13Dclr9YPD6xjHnrrdFlVC7dc0C2xivBtFzP3yGtD230it5vr92YSGtoL4UgHp9Hunjn+BUPBqi5HCBDeosDFPdIWU6n3yFg1ZheobQ5YpR10yfUdhV86rNozcBx8PRg2lN/Sq2mhQt2GYYtYWXzYz1GcnPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgxEtE466grGHj8LlEJj15fp7X51sXUjThy6fzGiB80=;
 b=Qn5GosSVdpkeQkoggQz5vS/c7+w2UYJ9GZjLDok5wT7zLeN536BtYyqZnz54QJwya2vlTG/5/K7DQHL46fZhZJ+4V6vFhIg1rmvTbmyd1jthZ/Ax1xXpJVcAFgEnMtLZ/15tyulbUxMX0jsqfVnaK8xezJzhgZ/3h2nSdRIRuRRln1ON+2NzyOsoPBxcQ+sVCm6S45gDG+kh2+0LcP+a3JDONUYIGHK07cJRevqWRClNbB6WaBv7J0lg+bNQAO4RbVjUmlb+y8zdECybVaD6Wl5zcR9DvhYQ7W1kLNJ3LCXzYQVvZJ+Tbc7oHKcOJQqR0kKv/jYBDvCxcpTycndgGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgxEtE466grGHj8LlEJj15fp7X51sXUjThy6fzGiB80=;
 b=bShKZyQHxxBxrCdfqrpsM8bunrwizQoPhfnHj24mKFFz1pgTLQEosiaL6C8n9UDGAAlZpzLZynhnmcps0XNukTKaxPIo1I1xMmvZP5yU9ff4vM084hGs6pUyjXyz9tNqLYv7AIQYyl/x3jZroatq2/ZhnTsNeeDlzd6dU+BbG8/giBHOF9CFNdFaHosuI4wxZ+FWa1+W1HvCcBYIT0cH8q1lRs5SO8DFXGLkoQYphy0U1oVVrn131XDZlUn7hkoAJt0LUkPISGKjaYiiYzi4bsw08tqVolpNZ4UfmH6v3slMMHRkIW89/0yPKcaRx1u/LNJ0bsJs5kA8zJCetlLyTQ==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by AM9PR04MB8163.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 09:28:23 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 09:28:23 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: f.fainelli@gmail.com,
	vladimir.oltean@nxp.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/2] dpaa2-switch: fix VLAN upper check not rejecting bridge join
Date: Thu, 18 Jun 2026 12:28:13 +0300
Message-Id: <20260618092813.432535-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618092813.432535-1-ioana.ciornei@nxp.com>
References: <20260618092813.432535-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::8) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|AM9PR04MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f92a29-8af8-4432-a0e4-08decd1bf1cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	x39fUAjrxU9jce6ruoTVpW7ulzpaRWa03LsrZDPqfGpG3itUW3SpEFeP1aWIC49Hp3sxw334dkdZ4lrVAI+OGqqiu7I0L+4THsuhAtDeLm64mlTz+DUKIGSmFZe2o0swwPoBxl46eg9F9IoWdfkI0Nftmh2tXq9pq8pbDLbjxA8u19aEq+/6P/3ar3W18pPOnZW93eg6gkqEpEZxAcCX/e1q/mBONOz2EERt2TXO8ihUK7wUCTxEABI/yzQo2a+m25NDdxVLkFQ4nvEzpqPWj+dWNwYFgaL8xLa/pQHAPXF9SwhjtkI7v2B4Y+moy0iL1DPgY8lc8iCITelmuG5lr3No6ecQFaT1c/kOUqTBPr0P9TNgyGDMMgRUN4Dub7Hf2Xzp39o/EK7+K+2S4bZ9ifzbOIi2vVQ3zEtLVVUUkim2nA+cmp5YCmib9Y4eHf3cTo+z9ntEigd7vf7zdnbQWYe8NA/9Fxr5H6sLa8Whp5g2HsRDGnmfVQLB25DRGp+DS5RBdmu5/TldFQBRhQ4cophQeG2ymquFa1Y92F7gOblW8VNTz07DKZ2SqDlvMhltAtVlRfWVgfKQ1zxNoYsMVyd7O104WJsxB6pwvkdb+/Pzc2GnVHHNuCybhDqzimSQA4cqRsPc6F9e8GLMgqwn+yR/TVHm0dSv63uYlwk8FrBvhgbbB7CTTtPPNpCJ3dIa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mVN5OdrjdJipFfaNxkxveZ2cdGRAjU5kOFyW70ekQ2ydjfc567iBT2ll5z37?=
 =?us-ascii?Q?fVO+Q+Yp1Ci/VHxZZmqPXJq483Hp444W1bvRd+lr2zXO5E6AMwHQcbCDm39X?=
 =?us-ascii?Q?/S4SZ02EX2Kx0f20UWksyblEqA537BbxNBhWtqcRItL9fbN2wHYH1j4WxluH?=
 =?us-ascii?Q?2d28SG82ULxLlEJpYDRLuvyuR/KURATHx2STRSRQTVscv0uz5YNQxl0PmsAP?=
 =?us-ascii?Q?k+5dP0HMK9RWjtLOU+Ba9J7RHfbdTryMw+UZSHl+fzIV1vMJwIqPt6TxiznL?=
 =?us-ascii?Q?+8mN6/HiP3thAownK2jt8Uiz4FTIIkeEnum2eiDNvPKx4NGZCkH2i+J4pUay?=
 =?us-ascii?Q?Gzo8SRlQ1/fiuSPNBebygIz8jZQYA+DjjHI/81X4iICzgO6n5q5cx+3q1iKc?=
 =?us-ascii?Q?DQKTGc5pBmP3lgr76ijicvGR1RtB3xTApJpnx0G+UuKefNcM6rpcd2bOH0SH?=
 =?us-ascii?Q?WIt8amyboKVc2XYZT+swLJOs5kEZQW/H4VGFmLfelQXbdzdhXlLulpjY5sCY?=
 =?us-ascii?Q?PnTLAHhSoAm1tc2D+yHOxc3bpkg7KcN5bpdSFisbstv1kXJd0MU2lS6PyWLr?=
 =?us-ascii?Q?oKvWVp7siMWTYh4Moo2WWCNXTElTXidbK5UjKqvbLsac/c/VJnmRvmHbCrSV?=
 =?us-ascii?Q?oG/2LImhG4pZFdL5J9t50OoR2FWGPK0q1ImAPe71fl6vYzhAf8kHetp2jBL0?=
 =?us-ascii?Q?7k1cClS/ZSxtFtuNwTNYuvjnU2PYiAZ56TvKoYVcmuhG5Cxmxh48vpuFofKr?=
 =?us-ascii?Q?NVvwq3ySbsBBYN7ff55Cf79ecTIKKhnOQE9XRZZGIXxtrhyoEBOkPxkz75ky?=
 =?us-ascii?Q?wdR7rObiOGd4mV4fKsIJCOi1az+aKDCRuJgQEv7TOv4/cbl9UdGIi1yBNkSF?=
 =?us-ascii?Q?I0O9cmXvO2tF77sEyvlIJN6WGEUBPEYMo8BHcVm3xZBvujekrM5Ykpt+qkVu?=
 =?us-ascii?Q?FvtEjosHElP97XNsgCRJUXJltBjSfRo3L+LnNwqsUO5/l4bCTqPXv6Ua7j+M?=
 =?us-ascii?Q?LwJBCBeQFuXPYwMZqh+uUDcsos8faIRqj1I45HcxSEFNuri2ZZjGf77jNwxn?=
 =?us-ascii?Q?qkfjMuXUjSqAr0F37To8fepHi6HCOIao4qYgfWl8SBJigengbY5qkZP/GI3c?=
 =?us-ascii?Q?WQS+wCrp+FaLDZwefjPbeE/3YYD/yOw9JWsG/Ux54LLrRidQL20QR9M8LtlF?=
 =?us-ascii?Q?ErLGxLcnG05Vh10DSNH/jDZso9TsxI2x2mE9bmsPdl5A8nclJBBIfLa5/yd4?=
 =?us-ascii?Q?kHR8+odQ228uOusAPNlKEXXgNbjIqYlTI2lfZ0YEccGIp1PX58xrhNEZ9MM5?=
 =?us-ascii?Q?NYVXvNR/peNHdXi0MPCEL2YvmcilT578PeZMtRJHzJMS2UNUn5cI5jih9CGp?=
 =?us-ascii?Q?PSAT4RSZwAdzLUMr7VlYEU3t0/0pyS9RGfIuvW4F6+bwci08Ia9uk3HWpQrU?=
 =?us-ascii?Q?7+Mr9YA1M3SpRrqniRp3M6LgPwZ/Gb0QN5YbtWl4RnRY+uiJ5IIAnnIEP7Ae?=
 =?us-ascii?Q?nF7QGtkMLnSJzo/9fneXfFGHaypMtSFl4yT9K+WxO7uKNKknW71Lkhbyhd9H?=
 =?us-ascii?Q?fPa8BMGiWQu4ep8cxlj/lwgBoc8nYbLh5E58w7E80bRfbhYfnXsswdQUv5cb?=
 =?us-ascii?Q?SUBWObfnnrdVGHiMfRJcnwou9gATkljHKunXdY9tsJa7MsBzIN9zz85hAyrI?=
 =?us-ascii?Q?km1l59zxBODF0firk8ecFrVfoOF6NMgEqJ0cRkudgHZzJrl4Un2XiIzlmSf6?=
 =?us-ascii?Q?JckgNRESYw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f92a29-8af8-4432-a0e4-08decd1bf1cb
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 09:28:23.8522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3grZe6y6sPn+DMIxPkctgU7kvbJnCHPf0vsMLVYgsEYyDzszM/6/+bn2mLuLnDvzwd0jgK8tp1ifRauIyaYtMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8163
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300376-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:f.fainelli@gmail.com,m:vladimir.oltean@nxp.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:mid,nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3112C69EDD6

The blamed commit refactored the prechangeupper event handling but
failed to actually return an error in case
dpaa2_switch_prevent_bridging_with_8021q_upper() detected a 802.1q upper
on a port which tries to join a bridge. Fix this by returning err
instead of 0.

Fixes: 45035febc495 ("net: dpaa2-switch: refactor prechangeupper sanity checks")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- none

 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 83ccefdac59f..858ba844ac51 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2212,7 +2212,7 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Cannot join a bridge while VLAN uppers are present");
-		return 0;
+		return err;
 	}
 
 	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
-- 
2.25.1


