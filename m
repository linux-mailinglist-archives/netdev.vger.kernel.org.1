Return-Path: <netdev+bounces-297718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zAu+C8Z/KWruXwMAu9opvQ
	(envelope-from <netdev+bounces-297718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:16:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9622966A9D4
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:16:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b="hTk/+2sL";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297718-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297718-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E705B310FC99
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210BC423A7E;
	Wed, 10 Jun 2026 15:09:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013015.outbound.protection.outlook.com [52.101.72.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91823405C2F;
	Wed, 10 Jun 2026 15:09:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104180; cv=fail; b=P25CB3z43TDkggtISCQzgvPpC62T1655OW7fqZr/cg9tlaZFnHWwFP6ZKlIxlPVY5L15p2uYtmEluKy0cNQ02nFaYEmP2XVi9G8ojniEkUUoVM31C4P4arfhNIv4KVFUJB1ex4r1bmz6uIXLw948bURwA5tXz62/VqM6Qd2W9Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104180; c=relaxed/simple;
	bh=og0/rTJuudbQX3ZvHmfWb+4/FQ5ZLLfzBuQDd9pVt44=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ihsk3fdJsxllUO8j13jeQePcusqOkEFwVZMH0hB3MRbZxlphC2lCXKUhawc55kKUR5iX5SgzEISMxekPmfwjPynGw9YZMo9RvITH+6/CCWEs34mFX3HjJxqqtXYBEBJQVFk2PA/nQhUy69ZNiX50iI8duMy/V8kqb5sukohd5Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hTk/+2sL; arc=fail smtp.client-ip=52.101.72.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbD+/4PcavByh/4YboIS40o4fglWYkK83DmCI8pkK+yG5xPD95XdeyDQ5EMAN0FzM2r5mGH9Nse0XoZtOkbjUYdXuBMD6KfefptLBrgLBFbwBvLho6i0PauXL1LGPjztOhj13RPUMMueCrgnX53EmngYr65inPX7gMBZ404swQz6khHHZ2h1e1EOr3FCN6JXBNpN4Few5s2B2NwCWgOo3ZFwPMGPFc0POs3sSxcnQldOPg3VFd5Y583WplcY3nQWQJ+d/2FqS2rUqxd1Y+vzEi4tyLtObA2tke5us0jJJyQruO8Lf4a3XWzjT7hNH0Wwz8VyjDJ8xAAwPdT2uF7w/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emAqNZZDnptlSyM/C3Fc32RsYVTxa8XnVNwooprxJ7Q=;
 b=c/0LEab2adMgiv9ehXB2+Yhp6ocrEk7AYN64H3wy5ehZCktguAqqCj28nK5voT5v1s/xGkEL4r1FsXcujYgHCWrLXZNTSE2Qb6AhH1HA/5frCEVj5kH0fNu5WxPCxYOH7WtsGjiS7n77t4k+krIQ6Oes1QRovjzr63vbEnfhLMMg+HCQ2jdgTS1vqj41SNcdDNFETLizqdmeUNHL03M1eO8IU9SxN6mzhqgxOCttA7TaVHruBHnShqW+T0v0AgaVmM+SaUVyXlD0034FTw2TxCQF8p04zct8rIogPwJBfbHkY2kXWeV4Yr7BCkXFuuvPX6Fjsd4kckPwQseMhzOKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emAqNZZDnptlSyM/C3Fc32RsYVTxa8XnVNwooprxJ7Q=;
 b=hTk/+2sLh9XiAHj/lNucg9qkZpMXIsR8t+McSwfANZ3TsYcaPxvVmhzWic3SZKf1FPq3LTLQI4TwpK6UB2W0lWlT7EbdsxIvcR3+ldeEJIaUWtP96Ak3xHQhi/oksiSICaiPHS/9OXyHXlSSxEBcCj/IPds/vdSoGBVFGEasRjmMkGRoNcZh35niXjimqQocwPsaft+8pOG5HTs1yQehtfff5/Bzat0v0wdKk4d1beyVzommLLv5IA58FFO4KWWuJ4avpByvJ0nca9PugoCH9QGiei120Z71i6nsBviBIZ8Dtln6ktj/qJP35Jfl6EUU9b4A6ymeSWslv6bk7dTmNg==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by DB9PR04MB8268.eurprd04.prod.outlook.com
 (2603:10a6:10:240::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.16; Wed, 10 Jun
 2026 15:09:34 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 15:09:33 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/5] dpaa2-switch: FDB management refactoring
Date: Wed, 10 Jun 2026 18:09:07 +0300
Message-Id: <20260610150912.1788482-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To GVXPR04MB12290.eurprd04.prod.outlook.com (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|DB9PR04MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: fd0e4315-0e47-4508-d6c0-08dec7024711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|23010399003|3023799007|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	/7IwPKUb2cNko2XzpNBzopjIFAvKdJEbJq9EvoWZGyu1zkBBEHCcBO0oBT2+6c4mLLOqeaxBsCxl5IuRM2ysr0w3sgJCrKkGcihqTFfA8L+yHMgYreoDku8DYlU//v6rMA8ZkLt1VM0Fe6RyoKwDAZsPMYA0MDSwepV97jWd1H+ABPTW0iUUB852G87LYb2Wd+qIHxq9mgERoizV7smK87KskAzq/7/MM+Yh7B/XHWRz5A9RgBbLP/62VcKXLcRNpHzKGMyQQA4+v60lpn0UcudC/zM6CVHZQw6SjBVX3CrrOCeyMmWQDpvjowuv0G/l2cBncyNsKG9LKaljP1Mc5VYDth592OS+7ejutt48zJqNPOyGYOADah1bCxk2nEERU04OlEA90a62UeFIG0+jtvZ8BHhAnQ/VwBRcuCiNZM6dwqQVt6grubwdq6/VrlopUov1aAxSbFobzEBtbC7YiblSMnO+WqmqhIMzHIW0Y0XatNTUAcWbX4ojiO0WacbKbZWLUdAOTEpbWxEcAt97I5sEDimIRHNgAVYP6yfup5MK91+iRx9Kao7Dxl2kpDy8t7QOTngyh4PyAnmZ6IWQhbe5TxnxtkGEJL+lpfkQKSg4Ocy30a4+XZ29s+kUyLOeJM2wR/yyyZod2+5JElU3iQMzW3N51qhZZMEOP3FV1TXPt4QUL7gAJQKRs58erzG7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(23010399003)(3023799007)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?911+G37PoYRBc+En/pb1eDuwhYb0FFtRvISQSXnKTidylmL0P4n/tu8ASLyo?=
 =?us-ascii?Q?Wfu/xOA7JCoe8oq5syjqR+RMhiq0hUoOkzzfx6wcjOpoL9MwnlYw4EqfbSy8?=
 =?us-ascii?Q?ZsK/ND8+GnecgRMNWM5fE6jWdDp/mJNDO87ZuZygoDELpUs3BRssVRJgKlPp?=
 =?us-ascii?Q?RWxdH29mIW6v173af9VqTIlIyrhhci5wnezs0mshuOIBYSKK/lnn/VPuvi9C?=
 =?us-ascii?Q?Kk/XBODtpwN8OjrMPPItBzCKPoZiSyQFs6JybG1PKII44k9pgflcxU3AsCu6?=
 =?us-ascii?Q?z2oH0r5aeu1fb0tIp2zY3uhHXm1HxMjM36SvzfhSQ0mp/kHNubokON54GP3M?=
 =?us-ascii?Q?4GCRwSEqSJAaLrRnnnrOBIzGG8sUwUSP6ansLaOtyOmkKBsqnqNjyj2YANJ1?=
 =?us-ascii?Q?p7iakA/T23FTnMl4D04TJmY2RWnF9NBKWLeNGLJKwrhKj/I1k1oJXwoEQv6i?=
 =?us-ascii?Q?DmlO91XLk6ACrwX0uEY05BcxmaeyuGFTBpi1KWkT/hkuO1R2iZy+E/iyvQuz?=
 =?us-ascii?Q?hso4IZnYWlv2N2jb2bs/ZJcP7FQYVC/9TN1yu3ivGh03mXecb0P816sdNnxq?=
 =?us-ascii?Q?k5pwHx8mmKptumNrMKpvdkZp1tMDhzsGBNxluTG0ISJIBaEqBANmYRqVEQX0?=
 =?us-ascii?Q?+zotFh5l1iedQ7gaVTEDXfxss9sp/u+5ZTOW6PHa7ORtYAtOignqGSWZRsCq?=
 =?us-ascii?Q?84cLwfjFkWelUWA71tyY8hI83bmepv02QtM3UVq6ao2BomR0nk1n9jhqluAq?=
 =?us-ascii?Q?dXMmOKwnYY00efcCmnqHKFAZzhSRKo3mO26GWBVnePDgnzxZiOzHMNob0SGZ?=
 =?us-ascii?Q?6lf+zhbnoQjdorG5ccsiE37NneSBgo8M+HVR13ZvPjpMFJK06MuV3jFetIey?=
 =?us-ascii?Q?J8iY5JNv7W6C4l6bU9W3h0PvRz5v13T70KLMo37r9vjQfpFqBfjYeL9etSTJ?=
 =?us-ascii?Q?NA/D/T0V4DqhTplpvAJoe3kzWxj5mGwWa9AkedbuZUjTGrWMM3ask0E+Oou7?=
 =?us-ascii?Q?pzdR9KgJNzs9wvyHBKktc+RXE/h8d7kXYSu6RTSHDJt9Maa6Wilq22MVhydY?=
 =?us-ascii?Q?zB89/XMimiawpVwG/NDW/PIaSWQ9L5106aW2d3qydCmffKq2jYnYhRAjp10r?=
 =?us-ascii?Q?mDi9nF1edxT4FRZjKp/dHVHhd1Jaf6q2RuLDkKDDQPzo4LzV5mG9x+P8JeH7?=
 =?us-ascii?Q?heJwOHOpVzYedSm1Xuz6I17uvax4Hdv4fyZz58tRpV8YiUg6MK6T6Z5jBcGX?=
 =?us-ascii?Q?ryganMdHvLR8XSXf6zwP9GZ03vr7mhqUt5AGC1Jse84GbVfN+tY6yQkJsEZY?=
 =?us-ascii?Q?aqNN0LVtPs8Pn9JwR5gmRh/JyRkeOX3/CvPAK+f9EayFY3Xot/tL/kcfFlT/?=
 =?us-ascii?Q?1sBb5AAIaT2l/h02Avp/xz5XMnPt+7mi4VnTYi7Wyz4msaYPCiEi1xfbe3r2?=
 =?us-ascii?Q?mUHSPNiUlmQoMAx67/FMUYaFDX3khFoHdm9wofe59VFTkDckz0ycOcdfMU52?=
 =?us-ascii?Q?mGJ5+KWl61zJCxpRyXd+N+LrAJpsZWwAyg8Ds7RifVD2CFIdITaHCBOfqlLM?=
 =?us-ascii?Q?KPBbKy6Hx/09VxcNxsgcPcrblhytjLU12AVR7s76Wp6i68Ug3pEUUSi4FANR?=
 =?us-ascii?Q?yIYrLLBvph6Oq+COFmjtR7ZQJgZbZeYWo3NHh6Xa+n8ixUEqlXu8/wlAcKpp?=
 =?us-ascii?Q?OXnw4NlMHY006jXeKrLZetFkzn1PBKn6aCrnfvmnM4d7lijdBNGl5ySnZXmx?=
 =?us-ascii?Q?mG7PVMg1Hg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0e4315-0e47-4508-d6c0-08dec7024711
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:09:33.0560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cyRRDXzIFT+HETrEd2AyTCQjufC8jfZgJh9Ff1yJlTOwwYwtC1CSFtFl1rCumIk2IvJA6+FN1vxpi/44ewK/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8268
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297718-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:dkim,nxp.com:mid,nxp.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9622966A9D4

The FDB management done by the dpaa2_switch_port_set_fdb() function is
hard to follow even by trained eyes. This series tries to make it easier
to read and understand it by factoring out some code blocks into helper
functions and unifying the join and leave paths in terms of FDB
management.

Ioana Ciornei (5):
  dpaa2-switch: change dpaa2_switch_port_set_fdb() function prototype
  dpaa2-switch: factor out the FDB in-use check into a helper
  dpaa2-switch: move FDB selection for join path into a helper
  dpaa2-switch: move FDB selection for leave path into a helper
  dpaa2-switch: unify the FDB update logic in
    dpaa2_switch_port_set_fdb()

 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 128 ++++++++++--------
 1 file changed, 70 insertions(+), 58 deletions(-)

-- 
2.25.1


