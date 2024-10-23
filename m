Return-Path: <netdev+bounces-138264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A48A09ACBAB
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C111C22208
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9971AAE00;
	Wed, 23 Oct 2024 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CscA1IPH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897B21459F6;
	Wed, 23 Oct 2024 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691587; cv=fail; b=YV5H/cBQ8yeo97nRxgwqdxXh5v99tWwldwxxrvXq4KEZ5vkSlbTq28C/YF9UF5CTqMb8TBPaaa3SDcViEWnuKdDd4eKe9/fOtwFbmU99rbh0khdO9OagDWw6BKWK5vtGoGJZsfCJ0LFutUncpX2VD357e7NIW8phZ68ts6qsi5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691587; c=relaxed/simple;
	bh=T72fg7Ne5lix6U3308YwmDg0Ll2VaI1TYQYhdXvPYho=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dRgOyKL2SPgLJUbwvm8b1G9DZXl3ixVh9R84WRVim5aLlS4WS3LiZA1KL0uGQI9xiS46l4DtEP0GtRsjqFDdtu6CrQclRB2TIb1+4P+D+v5XmIfizN5uj9yUSoL8F5SuuaoLOWxr/NYg7xsuOcxJdGSf+5zx91qwIgy6tdB0l0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CscA1IPH; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d87MF+RRvVF8nZ88Xjy7B80roMp2ygvH16mznPUIv0jK559md9caxEua2Hi6K/xHUPufM2p34o1qxIzKkf8LvPlxHvnxMu3qb/XzuwT/cMdCmG02wZ48ukKhbtIWDkh/bd2C8azn2sMEq0AWRYMDD456wifGgkmVzzJQD5cgGrDXY6Mm+IQ8PI86OhZd10BnhDWWMvhWcD3WqdDLhueOFydE9mSxt0wDQF+sIY4FPV8l3creB4SVdHhyiPwR7rHFeCiG1X+oCrqiIeNr8fHER5akv7WPtXZC+2kYIxkk6oG+1aaWZ+YolFWJumEOwOSeWfEI9xPV0XFa8GooO0xHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XC9CkkBWy48ZvFpZrYmDlYf7RiN0PSG3KohJ4frxgQs=;
 b=qJ0k3HILqDTlzi+IoisHol7yj4/WJ0IHFkzexpEZwjZ/J+oRfeE5yw88UWVlmL7u3lZKpz+bNOoFNh7soMKQ2fjtjg70dKSOaaSyhQpqDgwVacRh7RbgEVPxjblzp/PaLzhOiAoQ+/mP4MYzA6Np7dI9McXeuV0XiQgdaP+Ya1F9DW1TDrBvvQlzZ0EHYTefLeAAjXo2IQIoQ/Xdtd4mnaLygSQZA8fSwZ3fvSF8nVg4ThSoPBg2Cv6F7WYLasWnwpJHrncipb94FANGw7UFrRkaAz8i5HQCQ0BvJDLPmwOo0dssFlP4gnVc541m8Ht4SuuTJ74NT8hAKxPXeNZFjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XC9CkkBWy48ZvFpZrYmDlYf7RiN0PSG3KohJ4frxgQs=;
 b=CscA1IPHt8+h02EdASF23BOw0TY6IhOWx6RDqeCMjCpY+84SC+SjRlfGmXEacxM4NtjikTfUz3pNmd0TA1mhD0/nuRUgbQTxPROQYiTbd76y3I+ZEr+q/CKGpDZG7tCU6LM6sJO6eHGPQeZk9SdtoD60khpSlM98vh+hLptUlcbenrIq8kbf8XRZI7ef+A1VK5jMg2EHzit7c3my0Ituez+cwJ964LffH637LfbNQG35XvQH4S6UkbSW21fpuJOrP2Tok6oHZbE0HLj4ubcG28IOl2uE0sXm50Efs3KtJklvMOtZtFKxiCU7AERmua/sRiNDLrtie1KuHmmm+1boSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS1PR04MB9683.eurprd04.prod.outlook.com (2603:10a6:20b:473::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 13:53:01 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 13:53:01 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vlad Buslov <vladbu@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 0/6] Mirroring to DSA CPU port
Date: Wed, 23 Oct 2024 16:52:45 +0300
Message-ID: <20241023135251.1752488-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0105.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS1PR04MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a536d3-6498-4219-2421-08dcf36a0282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gkKYxX8bEml9iBt1p05v/mI4sWl5WVfHVgddSMEGd4SbkNcl671C0hJid0wJ?=
 =?us-ascii?Q?SFYoin7gZumXuqjdy3GQ6RjB5Kj471YdmUqfmKOwEfwdARzKbgia2VoNRPhH?=
 =?us-ascii?Q?Y/kRxsxmkwL9x8ss9zTqQrsQnh1PGARU0YJPSq4CyA2gZAnCeguT8e0Sh0UX?=
 =?us-ascii?Q?PmCpfI+oCNtGbM5zRCuMTPNiDzYB/rfoAehN4w26hdBF9ig+2+oambx0WsPP?=
 =?us-ascii?Q?EMLyvqRqVA40pevyXANUwGfyj6WR7NUaDGDJzQ+1zabdXetmkfx1HQSOOED2?=
 =?us-ascii?Q?IfbggQqsXnYNh73Fjg8CBrjXXM2da+Fs/GqgaSrToErFd9A9zHBA2J9CtIyn?=
 =?us-ascii?Q?sQ6Jt0ByS0UfejjU6KazHJsqaTxxV2vm/0MhzjYBIbFMVR3sAuChmCLVcJP1?=
 =?us-ascii?Q?KhueWY4QbjxUL51FVUtgtrEyGUia8pVLxftulfK76wtQhO2XH/yjShUuyfFZ?=
 =?us-ascii?Q?gO5k1bdqH0Zi0DcyH79joLlyjqj8OkI28CUne1YU9c1c325uJOYr86bpolEG?=
 =?us-ascii?Q?pvlmROhVZOX7PmGmI1Xu5kjzR6TG2X27zPSlVBeZTME0SGSLSnh9lL7DB0sy?=
 =?us-ascii?Q?fzxEZRm4wYnuPPkTMN4aYgXNhjmYTS71ZirKQbFvanTNx1sOd0bJQgb4WLI/?=
 =?us-ascii?Q?SpfPAKXsoiGuqmdNT9yl+l/XIyyHeHwkw+iI55iblsuCXzxeyVuGoL4kLujj?=
 =?us-ascii?Q?ivgWV0/JsyOBW1syCtwR6fB+8yFQJ5rs0z/Atrfx3DZTuHv1LghDz4qLQs8g?=
 =?us-ascii?Q?fmBQgqJ8YC23/dzSagaGy6r972f5CZmB0RZEPdczqJflK8FVZ2e839db2wW0?=
 =?us-ascii?Q?CkUR9nklHmyPWtCmXKdOtq9BYkL+RNNG0ZbSCHVRV5fquwM6X8yri4eoNkoP?=
 =?us-ascii?Q?NTha2BW08ofVzPyZnCrsSjzXc+FDxQql6+Sa5uuLZt/Z4hD2HH2chQmftE21?=
 =?us-ascii?Q?dm6QgGsU+2A0lknbt3PTINTq8NnhcQfH22uT9aRRn2k7Sk3woPSuol0vn+1q?=
 =?us-ascii?Q?A3R8q94kMMxgg1XimEgz+P/c8P6e4Uh3LgAiOCaTlsMEuWpN7IyT77piwdMk?=
 =?us-ascii?Q?UwDSx+Plp4sVObLLWZdcKo/9Dz30nJlkJ6/aT8T7DTTKF/MSMN8QrqoqU4ub?=
 =?us-ascii?Q?o4y8uOHEJHSRDuAWgbyBH56GIjaV8lphvI2lQGSFKI5IU9qbh7JMIos+w7Ra?=
 =?us-ascii?Q?lGeM3rLCdyJI7F4Kyvv80Ug60CCgXMSBQ59d7diNddXxwZms9qUnfuQYAuzI?=
 =?us-ascii?Q?hkh12NOMaX9cJhL8AdFKvRHhtlHyhk/67xOSH4dB5IrCwUaKPn1CQjULpPyT?=
 =?us-ascii?Q?Io4PX9U8mdov35FgCRkWC8VZTw6uQ9hepPnwEcOrtX/HRx4bKZcTOaCSZiT+?=
 =?us-ascii?Q?NwnLfKel39C0anboPmMyFtb+7mSQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uo8Aypmr2au7/7KRUsOmB2QXExcIOG8jLF7F7AbQ3VgGV2Wlc1g79E2jVfbS?=
 =?us-ascii?Q?ljDuAFVB9pWchOEfZ2MXmBERZw3x0g6Q4JIIXMIHfd9GSPwJzNXzVIa5lwLS?=
 =?us-ascii?Q?8+cbLflrXRVt50U/TB2We1MctwHgfhU/SCppz1CJyoog9jhBHk6y2mJd6gjO?=
 =?us-ascii?Q?dxyjxKlKzQzZSWe0pTxdUhxXxn2FU7PwlV90Z80A+HonwqbJ+eR75RMfgSc2?=
 =?us-ascii?Q?R4L+L7ZJ2eGdHMNxHleLQ1I5Zvhb2UAROcWMLtyd7sO550rqitnrA8BsOXX0?=
 =?us-ascii?Q?0yRo9m+xg8tNGdSmZxm8S/97vTJfXv7eaqSMUZgTaH6IwzuskY/QVHx3UaI8?=
 =?us-ascii?Q?KW3L3ZyoRsnIYdcCDC3jVkyMqfNYaq8HEN0NK8JUWVw9Os6Ak5F53k/I5cE0?=
 =?us-ascii?Q?ZfO4Ti+mcALAuBK2rWQ4IrYAPcFrfiYSHHUWBUSkWuztPWFn2wLucNZ/puwG?=
 =?us-ascii?Q?EDsX6xmXnrJrthmTRZlVYwGooxsAsYk3sKNHHwsbPt64urYt22FxBjAqGEff?=
 =?us-ascii?Q?6CqYo/Y8dHl9G+vS0UFlxbz0T8GwjBISZIG3bVTsf56tPNhFHd5IFuHiAuVb?=
 =?us-ascii?Q?4VcD+P9jxlUBbV4uX3NgDUnV7ANMdl0VbN5pLQuVaxp3cETevgFAPVqsq9XF?=
 =?us-ascii?Q?oZpJ3cnI85bZEOTwZ25LmgaEH0E+SiZnhh970ioP/Ls33Fe8dBj6LGhkeClq?=
 =?us-ascii?Q?dwk+EGg7xJUhq+GtxkifMVrJmLBz6Ih4aatnoi7qMY0e22CJgX5hBgBMkaPu?=
 =?us-ascii?Q?1d5tXZEWPFdhX3hAUdyoisoiyyd+pY0IAhBCp/C8pfr8trtCy6jXquRsxNuF?=
 =?us-ascii?Q?TMh5AGDjpf9sZoDrnZmtq7uxmLiqLGZzeFom99932m/a88mh++CEZaK2hqom?=
 =?us-ascii?Q?OQC+TbqtcJemyWXiqG39W3IYNSeD/4fK9EyUtH4V9E2rOttSzB5Q5McXg6Nz?=
 =?us-ascii?Q?CXzmWwxsarQX3IpZwBWZPBQP2pGGE4qI1PkXrvLpqVTUJUFp/nfIzkEwt518?=
 =?us-ascii?Q?7gBUdxZuRbP93uoDqx5XufbChPgjdELE6nXiY7hbIfhoi3xCCI6C4Ejjh0px?=
 =?us-ascii?Q?mISQE0//c/UTjoAHSXOnw8tzMN0V1GO1IuzfsSBbzuJKaKXciVkMml2E0hUa?=
 =?us-ascii?Q?wxHAAxsJyUFH6kPbDbWtC20koPcYU5N0Mg+g9RB3uETLAB45oSAzVSAZ1ApK?=
 =?us-ascii?Q?BRUREMOcJHoYEEPcH03ANPY0rJMEdFWEdh9d5hAjKTiY/qzk9SYJTu75DRSD?=
 =?us-ascii?Q?lfjz9saw7Fog/02vHHg4UdB193G3DPSiQhTblcLPdHr3jTKNCsdxPP+6KbE6?=
 =?us-ascii?Q?mYdi+7lVmDxNF635zmt9QFL4Bz+nWvREw+3xZUcyFJTzsLChC5KGFU4XOAHB?=
 =?us-ascii?Q?8xgCZ73TVEZLaVj96nH6AvJFqgH1Dj+5quwhhKIlM6Hsmsx2sIGdqZLu0Uzb?=
 =?us-ascii?Q?BEo63eOo+hAGIk8yKKCTx34SrcZqCFOQJ+Z88LcXOsvu0SCuNUYG/p0w8ymF?=
 =?us-ascii?Q?dlDeiIbYjOrbj5fXVZFsuBSwzUaWCKK+xwScdX0NWn0daJjICIZdw3kIgNk/?=
 =?us-ascii?Q?vUdufx31AnwEuqka6SToT5DIBL7Taw2u94bnQdu30vh9RElyjQFNP+7szH1I?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a536d3-6498-4219-2421-08dcf36a0282
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:53:01.5634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqL/D8qHVlIzDI00eNhXtamM7wht4laOYPdUtRkiJ+Obar376NMqkECVv+WAG/h7L3ZBl32OYusd2tdCriCxDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9683

Users of the NXP LS1028A SoC (drivers/net/dsa/ocelot L2 switch inside)
have requested to mirror packets from the ingress of a switch port to
software. Both port-based and flow-based mirroring is required.

The simplest way I could come up with was to set up tc mirred actions
towards a dummy net_device, and make the offloading of that be accepted
by the driver. Currently, the pattern in drivers is to reject mirred
towards ports they don't know about, but I'm now permitting that,
precisely by mirroring "to the CPU".

For testers, this series depends on commit 34d35b4edbbe ("net/sched:
act_api: deny mismatched skip_sw/skip_hw flags for actions created by
classifiers") from net/main, which is absent from net-next as of the
day of posting (Oct 23). Without the bug fix it is possible to create
invalid configurations which are not rejected by the kernel.

Changes from v2:
- Move skip_sw from struct flow_cls_offload and struct
  tc_cls_matchall_offload to struct flow_cls_common_offload.

Changes from RFC:
- Sent the bug fix separately, now merged as commit 8c924369cb56 ("net:
  dsa: refuse cross-chip mirroring operations") in the "net" tree
- Allow mirroring to the ingress of another switch port (using software)
  both for matchall in DSA and flower offload in ocelot
- Patch 3/6 is new

Link to v2:
https://lore.kernel.org/netdev/20241017165215.3709000-1-vladimir.oltean@nxp.com/

Link to previous RFC:
https://lore.kernel.org/netdev/20240913152915.2981126-1-vladimir.oltean@nxp.com/

For historical purposes, link to a much older (and much different) attempt:
https://lore.kernel.org/netdev/20191002233750.13566-1-olteanv@gmail.com/

Vladimir Oltean (6):
  net: sched: propagate "skip_sw" flag to struct flow_cls_common_offload
  net: dsa: clean up dsa_user_add_cls_matchall()
  net: dsa: use "extack" as argument to
    flow_action_basic_hw_stats_check()
  net: dsa: add more extack messages in
    dsa_user_add_cls_matchall_mirred()
  net: dsa: allow matchall mirroring rules towards the CPU
  net: mscc: ocelot: allow tc-flower mirred action towards foreign
    interfaces

 drivers/net/ethernet/mscc/ocelot_flower.c | 54 ++++++++++++----
 include/net/flow_offload.h                |  1 +
 include/net/pkt_cls.h                     |  1 +
 net/dsa/user.c                            | 78 +++++++++++++++++------
 4 files changed, 103 insertions(+), 31 deletions(-)

-- 
2.43.0


