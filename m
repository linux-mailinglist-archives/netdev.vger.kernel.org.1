Return-Path: <netdev+bounces-211871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CD6B1C20E
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 10:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD611863B8
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 08:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B80221FB8;
	Wed,  6 Aug 2025 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lBbh1fJi"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013033.outbound.protection.outlook.com [52.101.83.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9623F1B0F11;
	Wed,  6 Aug 2025 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754468542; cv=fail; b=tAFBNtL1iZfn7XBsuEO0mWvzqalec47x7UpjH9IiiACIBv8DEQ5hIvpzcgbdfEY8V6YyFsFmpHUnO1om3fHDpV3YYzT4zaGR+Z7Gl7VWL6Mhji17uhxSFJTDfSOgHNUvg/juMln1xmLxqGzswsnWe9F0tekyy+h/EGe9NTSIA7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754468542; c=relaxed/simple;
	bh=RcWbIkzzeYBoqs3YaikGMnTgKWioejDpbzW0QOgJ3KY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=n809pXik/5BD0a06VzLdQtmIbkHesjm7qPX5rmsYmFbDO/n2zMiyLEvCOR30QKGyOTx/0OuYL8dfiKTLJdvyXdvZS0DPCsAs5GrDEv+9ujNP0mCoS8E4wAlifRzdwZJhewOX3bdW2RF8sdRW0vbID5YPthluTrcf0nRpS0Xar8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lBbh1fJi; arc=fail smtp.client-ip=52.101.83.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sj+/rpMqg8bZkhi2SPJUykMeIi5QgMaQvZXfIXH5XQy0AvGe5vi8WNJHII28Q1/jqNE7qbmcxfa7mYq3sUYKHyR76Pv2vF9VKOOmOMUCoTSdZiPKF398rDGmOh28pnUVOfYesgD8LozOUjKETtWFeVlmsr90rcTx9glG12J13fmAnJjvYEMjcZt+4KYZgvNXMi8ReG9gmgB5CjY+V6mxRc/b+XGDUuNnvZR45WALG4z3yb8T58FEsXkFarJkjAirsVxVQZosIrIgwkX3SyejmtLfzcb8wruzpYBUyLS9nWTzJ2h5bUT9I0Y8rbVUtks2f7Ik76FaW+3XcdbFPh4IHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD4fLyE3bG5M+xDECvgfGcpNlpLMLOzyjFKV6k1QgT4=;
 b=Zd1GanvV6dGqMhArlm1lHh65CFR6nz6sbaRA1OjkFVgxBETPqC3Fy1t97liCzfbdomb64AnulsLPUevTAtoBq/MqlajJfiyb59o61oJbFCO4pSDlAIlWIDXOYBlWpcSkkfk7mNFmtaHyxbKM+GnwtnpsTq/6ZYzoiKEODcM5LI94VJlt5qhu8FglyAw88ojLSPzp4oV/jgnOFE+9XO9ohWkmGaxgG1UYW5dAP75wByWLhxvPS8YBDVjwi3fIFHiaEOzBwK/AiGdSDAu7/lT9LVDGlKAR+TlXdDBk8B2JGWSE0qyVlPfn1DnMFICZEs5e6CRNt9hX272oSAw5yfWDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD4fLyE3bG5M+xDECvgfGcpNlpLMLOzyjFKV6k1QgT4=;
 b=lBbh1fJiB652RO6m3iAwneVMyVUU7aFT6MWoTxZfN45ELZhlJiWZCKn5ZGX9kcaasuzq2yhduHMol74PucHqhRuQaSpZe/JeHVVYyjvB7cJ9OWEgrRbaBhWfh3WPVvOJ8bIu6IiANi5fJxUP34O6YLOcFl2RZd8pe/TI7DOGb2MxTWASImwMIoIbt738V66UFwUfQXcz6Irp4YFQT6xXoOvFAk4ItTwnbMAILxeoVPx+SCsCYeC7cYt+kuG9YXRfsplZzt3sjkPUlTHoh3zy2WEoJRHLY5gQhRSbxd93Pkw/Z7qhK0KoxVqmNNk1pBEdHWVhuQbDIzAQsp/Y0UFCRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 6 Aug
 2025 08:22:17 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 08:22:17 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	o.rempel@pengutronix.de,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net: phy: fix NULL pointer dereference in phy_polling_mode()
Date: Wed,  6 Aug 2025 16:25:12 +0800
Message-Id: <20250806082512.3288872-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS1PR04MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: dd98d2a4-0057-477d-7cfc-08ddd4c25ad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KS6/4LJ3oVfFTOyGou0v6kd8ACVtCGHZKy/ZsO9Z6EhaAPKAnRhxyI7xVKrk?=
 =?us-ascii?Q?MQDe//UYMWgbOeDQZ2GYxWByaHdVnQayoE7GJ8pJsAVaNiARJq3XjiRPpGJs?=
 =?us-ascii?Q?Gseg9Lpk2dPDp841TSp7hurpMrRf6uu1vK3oKgiUt8JlgLORYOGpSBL5g6ef?=
 =?us-ascii?Q?fQKAoX3LDh4E7t6s/V6YjdjROGtRCUey4Qu7HkX7vT27o0Os3CV+8zgNcBOM?=
 =?us-ascii?Q?wRMOzmJqDR/BQazMTz1bhxEQM5jC3uhEjcf7yfX8LVl76UDozTH6uXNQYV6T?=
 =?us-ascii?Q?H8GcG6W1uyvl2/6oIJ6iDEt141xR/DuL5MDcZXsGy0QhlpjqS2NkCaObBRm1?=
 =?us-ascii?Q?J13SAcZrAFfC3v2r63d7ZuNmFObPKcZrLb+R7Krr4ia8rUcVt01+CGFz5seI?=
 =?us-ascii?Q?naDL1vyj8rp8TCu5gY+fi5H9oJtKzJ/v18OVo6AO3bSFWVI1JVtmagGFW5AI?=
 =?us-ascii?Q?lCFbx60ompzkhfKbZALyM7SI1BVjkeHwuiTAOLhexvaoCWrahPsvkr05+YaK?=
 =?us-ascii?Q?rocDNNg0gf1rmvxOgBO5O1gumNZQpQv1Cl6vOzgxaEOq7qUPZnB/Pkcek/r3?=
 =?us-ascii?Q?wP642PHJmvYcA9WEcR2roSFnLObkCIQJu3Rj4IIf/upxoK9zulhEkQEzpr4C?=
 =?us-ascii?Q?WpBVpIbE2xb8X/j/nwzX+It0GsZ+FyToiiy2xJDmVUpzLppRacUYGYLdyOKX?=
 =?us-ascii?Q?7nLtlVjL7X0Ou5eC//9P4phdi6jWDEZ3MPfIUSNRkzXfiemHC9X8rReANGYY?=
 =?us-ascii?Q?v0YPXIQ9IY7N8L5g8iBp+g8fPM+3DlGxOXQCrutrbkDlKffqGJSYaCBjCXyP?=
 =?us-ascii?Q?wyKKLXOAjRwaQRNzh39LP0qrgjzyFltEVPWBEvT59bzK8qZgtildF9NSkdqy?=
 =?us-ascii?Q?4T75VXQkT7pu/5BsR2yAZ+emjpwWclw7LejYj+0VqC6qvaAncT7O0wRj911U?=
 =?us-ascii?Q?5PCI+H3Bbd8Dymqudf8uN4GNOOTCVXY+nebH1VVZXITbwelbZJQXbT519M1A?=
 =?us-ascii?Q?xTOkezv6J2QJuARmeBfUAU4QE8dWvY/jNAqj1EMsW9o+yqSrUkD1Ty2pH3dZ?=
 =?us-ascii?Q?eV3hMxXmaAcJ7eoyTKWNvSx35ANjSXGxFUPz76CWXdFIkOwrFaXZ5PF2xm7C?=
 =?us-ascii?Q?yv8RBDZpo7kpuYkjuctWpA9iMVHuvnOO8Oby7ZVajgvcWlwR+g+A2b9AnjM5?=
 =?us-ascii?Q?HbIvxfEmJQQ+/PHiRdEI6fX527Er3WroKxr/QyIGS6yps30I7MjeqMaOIGlS?=
 =?us-ascii?Q?kflAP0jG833U0pwb1Yqol5P+DwCCRyglpxuIcsNJUoSH4/srN3JxNIl8whWj?=
 =?us-ascii?Q?rH5llF9T1dv5WV8ikYT4fNJgdlqVyVlgu70qhx8/+tErMvCa0nvnU9rqTDiD?=
 =?us-ascii?Q?fkrzGDC1YMtaOGOsQdrK/Df5g84k5yIujSpv9Mx+8HccgUU3KNbmdzHcDapi?=
 =?us-ascii?Q?PILbW/JCZjJzp7xRS0eMu2U3B12IKEg/+fj+cv9f9+jXihYTs6rC2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jDdc4nuWuyHqL4pd+lD7D/cunDt3CZ59hF2OtNssbUFRU1TxiwgCcz3URj5e?=
 =?us-ascii?Q?TsQPRYHOqTWfHdwi4Yk/eSA1Sx8r4PTnVxN/WslLiBUBD+mKrkk3QmDOGAm4?=
 =?us-ascii?Q?5i64a+lgsroKJKZEl6aXfRbkzQ8RAsGoT2691j9g/dlCXo9sYNfyR3bj6rv8?=
 =?us-ascii?Q?QSyzKrByRf6UAEt+66ZOHa4vy5nSp/ZqTR1iAkWycWJ0C3sTuJPpBTjUcU23?=
 =?us-ascii?Q?1UahPYGULuGnrcx5AJejRaCkPsRhHhR498l+kCZWYzXDaxtP9IXa4cbRIe/Y?=
 =?us-ascii?Q?RIB4VUJJGZuWyuJS5eZIr9vTXCMZq8ENPY6yl1Yw68s4max1kRP7uDZebOXX?=
 =?us-ascii?Q?IDn+P6fONwU+rbQvZ5Xw46wtmrWnI2Uyctg/hoqdzSE4Il3/KwExFziUUgiL?=
 =?us-ascii?Q?aQsn4AfrAoQ+U6J7TqbUKvAmWGXUxDdQ+OcnTU30pj5ho1okpO7yusgT7n5o?=
 =?us-ascii?Q?uvIAIOJqzqHNK+WB49jeoDihiLdivXzVyP9YHdv7ObHoZl4RmfOteoDCpxtD?=
 =?us-ascii?Q?pwB3Jt8gdx7gCti/W6yCOnJH7PNtnK57buLaxKpNvUej5CKKE1I43yqOPPxf?=
 =?us-ascii?Q?xZFmSDbUypGLMvv8fl3gKWBE1TDaXUnGKOMxbyFquOmHiZAdXqUfy6hDf599?=
 =?us-ascii?Q?uV98ub0il9/Vd6Sa/fhRdnPkqs41zPJpjts58pDpQ8uDgqEjLmGu/Uybxn2D?=
 =?us-ascii?Q?T+dsAhDvlw+V3jA2OeQv6IavCQoj7e0t4sHwd9IVhtFSJZpfdEmZtPZhqCJk?=
 =?us-ascii?Q?+RxCdTfb16tqKovpEjGRsou7UNIiU8lmCjTvC4eS2rzyADpb+SLba/ThCVnG?=
 =?us-ascii?Q?0d2iLOAD5MdCzJEKddkLNPu+pDqgpG/CovirpTrPqFFjNEiQZ6EnUG9rRo/b?=
 =?us-ascii?Q?584P8gpNXsqyKj1Kndfg2RWZKhNWowk7zgocQMrzECkjtinMow13yMzEcmgD?=
 =?us-ascii?Q?9pAO8qjUl7peLCS6LStDFwtv4OCKn3nRAJQelKQo48Ld4xqcfSbgxEjveVEh?=
 =?us-ascii?Q?ABh8MZ/9j449/52JhHQK0LiUMKHdCg7UCbPakUw+s3NZNse6+dCM3/YMfv5N?=
 =?us-ascii?Q?eBtaSnVVJ0AVQsv8fT94pJ/emNLbxc6mb+lploRjTr6CquH0t4BnYUwTy5//?=
 =?us-ascii?Q?OQ9qEVk9wz5xRvxj1AZvkb2WQROaktrv77L3RB8EzR4AFebAuiUk0yXDDQLi?=
 =?us-ascii?Q?oZ4p8hwt6mYz+N4Q6Ezd/f+22C8omi4F3959w5oSxqAo9AnEe/osU70mIjYL?=
 =?us-ascii?Q?dXh54HXHKVJfD6TaKCKhKXmvkaEQ+pAPz6PlM0j4EthQaxNQvU4NY5C2j4wQ?=
 =?us-ascii?Q?yN6qJmcUu85hXKdCbLtiDjTQNJFzoBHMmmfHWHKGy47YMc2edOuVbTL+K4Se?=
 =?us-ascii?Q?TyPB3TX/boOuCawm+fC/SyQE0vY61K+0klwcas9EQ1iIMOnBjhPKnk1PhG9j?=
 =?us-ascii?Q?q40FRiBx6JbKq2FhI5QE3bzePTaYpMEd4SAlE2uAjA4jWWP3lc3xJc+DYak0?=
 =?us-ascii?Q?yLhbfNr0f7aT8wTJqlsg2LTadER+mY5tYcKeD0NqqouK6GyJW6jhwxU9Bxo1?=
 =?us-ascii?Q?6tYlcuUVLRK2ULmjWojZHYkgZfFIuzAug+qgnx7v?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd98d2a4-0057-477d-7cfc-08ddd4c25ad7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 08:22:17.3327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fN5fH5qU86DkKyDchlrQVOevHr79atBdjbDRAllUW2gR42Fda5yGVcnyXvIFkcT3bcrX4CIaQPiHMvSJDFK70w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9358

Not all phy devices have phy driver attached, so fix the NULL pointer
dereference issue in phy_polling_mode() which was observed on USB net
devices.

[   31.494735] Unable to handle kernel NULL pointer dereference at virtual address 00000000000001b8
[   31.503512] Mem abort info:
[   31.506298]   ESR = 0x0000000096000004
[   31.510054]   EC = 0x25: DABT (current EL), IL = 32 bits
[   31.515355]   SET = 0, FnV = 0
[   31.518408]   EA = 0, S1PTW = 0
[   31.521543]   FSC = 0x04: level 0 translation fault
[   31.526420] Data abort info:
[   31.529300]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[   31.534778]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   31.539823]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   31.545125] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000085a33000
[   31.551558] [00000000000001b8] pgd=0000000000000000, p4d=0000000000000000
[   31.558345] Internal error: Oops: 0000000096000004 [#1]  SMP
[   31.563987] Modules linked in:
[   31.567032] CPU: 1 UID: 0 PID: 38 Comm: kworker/u8:1 Not tainted 6.15.0-rc7-next-20250523-06662-gdb11f7daf2b1-dirty #300 PREEMPT
[   31.578659] Hardware name: NXP i.MX93 11X11 EVK board (DT)
[   31.584129] Workqueue: events_power_efficient phy_state_machine
[   31.590048] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   31.596998] pc : _phy_state_machine+0x120/0x310
[   31.601513] lr : _phy_state_machine+0xc8/0x310
[   31.605942] sp : ffff8000827ebd20
[   31.609244] x29: ffff8000827ebd30 x28: 0000000000000000 x27: 0000000000000000
[   31.616368] x26: ffff000004014028 x25: ffff000004c24b80 x24: ffff000004013a05
[   31.623492] x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
[   31.630616] x20: ffff00000881fea0 x19: ffff000008515000 x18: 0000000000000006
[   31.637740] x17: 3a76726420303030 x16: 35313538303a7665 x15: 647968702030303a
[   31.644864] x14: ffff000004ea9200 x13: 3030303030303030 x12: ffff800082057068
[   31.651988] x11: 0000000000000058 x10: 000001067f7cd7af x9 : ffff000004ea9200
[   31.659112] x8 : 000000000004341b x7 : ffff000004ea9200 x6 : 00000000000002d6
[   31.666236] x5 : ffff00007fb99308 x4 : 0000000000000000 x3 : 0000000000000000
[   31.673360] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
[   31.680485] Call trace:
[   31.682920]  _phy_state_machine+0x120/0x310 (P)
[   31.687444]  phy_state_machine+0x2c/0x80
[   31.691360]  process_one_work+0x148/0x290
[   31.695364]  worker_thread+0x2c8/0x3e4
[   31.699108]  kthread+0x12c/0x204
[   31.702333]  ret_from_fork+0x10/0x20
[   31.705906] Code: f941be60 b9442261 71001c3f 54000d00 (f940dc02)

Fixes: f2bc1c265572 ("net: phy: introduce optional polling interface for PHY statistics")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 include/linux/phy.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 4c2b8b6e7187..068071646a8b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1632,12 +1632,14 @@ static inline bool phy_interrupt_is_valid(struct phy_device *phydev)
  */
 static inline bool phy_polling_mode(struct phy_device *phydev)
 {
-	if (phydev->state == PHY_CABLETEST)
-		if (phydev->drv->flags & PHY_POLL_CABLE_TEST)
-			return true;
+	if (phydev->drv) {
+		if (phydev->state == PHY_CABLETEST)
+			if (phydev->drv->flags & PHY_POLL_CABLE_TEST)
+				return true;
 
-	if (phydev->drv->update_stats)
-		return true;
+		if (phydev->drv->update_stats)
+			return true;
+	}
 
 	return phydev->irq == PHY_POLL;
 }
-- 
2.34.1


