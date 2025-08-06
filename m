Return-Path: <netdev+bounces-211873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB19B1C223
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 10:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC0C18C1359
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 08:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300AE222593;
	Wed,  6 Aug 2025 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JtJ/X+dK"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31781B0F11;
	Wed,  6 Aug 2025 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754468846; cv=fail; b=i2AAmKaR1zB3bRb1UeGMSjFoyJ1NYvo2vQKPSpCHBsmM6XSqsrM6s6417Ucnyonjc+wk8pU1zTCNfjZj6UfhhnJcLF9MWCT0mfdZFuie3ZOWU/apsMSDbI7hjbm407FqfdufUTN/9JA6IOrecOt4s9YPT5sJzz9cVjfXZ+ZzaAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754468846; c=relaxed/simple;
	bh=U3DiT5qLrzo32DyXoB/Vwba9BEbc/juVijzoYF8rgh4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Rkll/AmyRvNEp38tEk4NFox/aUfDpGYxioC/OUnUcOxP8zM4pLZ694o1Dq/JkXtNPijQILFiojbtlpObi33GPfmvc3IF/jeWjRm+LY5cNwwPffIgtFkja/aLdoAFWLevrm+TIPpP7tgmyiG8JPpUTUgnAmVPY7ELQVnjbolvuu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JtJ/X+dK; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xP9PN6ym1OR8gXrPMiEssQ4UP5hc58NozNkLugk/huwPjEUNoSu64G0QERX5ycVZkx+VNcRoO5nlex9eOONSR6dHFL5cV3rmYPSqK9P0cODPRKaXRBpJym6k7JS4WAR1KFsygsWtNiexSmKQmtfxFxSr1s5yLApAb7MCRXYmC5kh5SsrfY7ucYsukNwr6gXVHZoiXiZ7z7Yip5j0PAH4YehkyyplGskAqBrx+DQVMnOxt7wjB07gn4D7J3tOQNnnrWZv7TE9kgtgg6bQIzvJ7OTkHYBgKHKL0kaNcK0f6HcrcwZVU6CEphMC5BzxT3hva7xcntyxEPBPknhR/QktUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRq1S08Ll/5aKTpe+O3/NZ0LrtpVurBQyNPLw94Fulo=;
 b=rAvoVDFU4NTLK0TCvQw99xbyjiq3Blp0YPoPJEurRhB8vCkBFVoCCjroYvPKdyFs6NYOF+Xa67mDw9TckHW7br+CqGYPveRhg1leK2O4eIib6f1ewPSCzAEAl1NkeUZkpI2AbQmcsqtOuKZYVaNEidX9HiAqngHm0qKKjMqRzyBaASvJ/S3XTTQta55kY5VICzfvrcPLfCaEas4S5VwCDYnuUS0yK+r4on1xe6RLi4BTrdzMeIiGqgtY5RJh4XmMncYM+AmWY3HkE/1fsQ8enM5DG8BrIu/eeDDpv3KYjeaAfKgLzQcyhhR/fkCG9m4vKLTyztXkkp2oGUS+vGpddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRq1S08Ll/5aKTpe+O3/NZ0LrtpVurBQyNPLw94Fulo=;
 b=JtJ/X+dKusKF8slGaFxsFo7gNJVIeP9Z7Asl+EqQ/em1rRIw7BXepQkValadPfxewh4f5V8YEWhTkB1wn14VOyTOM3cqKc/Ejj9Pkvc42nqvgvLc/5gyNSgeC/QxMB49qPpTKdD8qudFU/82RTWgdsqjWklHQ1oNY5yYMKj8yolfTMvz1pZAemRZFs6RBObWJ/DyjKB6rl5aMi4w1Z4FpUoH8xvAdP6KSeqexE5x7xUybzctk6wNWlGA0g1YLHR4iV0sWW0znP/XMQRZeMEHloi510DjXj4TOxPSpUNl7jITf0nf9IPV6nIg9bogb2vNUfSKWbWT6A7r73V4USPzBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB8560.eurprd04.prod.outlook.com (2603:10a6:102:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 08:27:21 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 08:27:21 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	max.schulze@online.de,
	khalasa@piap.pl,
	o.rempel@pengutronix.de
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	jun.li@nxp.com
Subject: [PATCH] net: usb: asix: avoid to call phylink_stop() a second time
Date: Wed,  6 Aug 2025 16:30:17 +0800
Message-Id: <20250806083017.3289300-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PAXPR04MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a2b026-bc90-4c9f-021d-08ddd4c30ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mmd9SaWa0bjFkHdvnGxPBq2Zimdg/2QgNwkgxrwBdHo7jgI5CyobrKFXSV+F?=
 =?us-ascii?Q?4BbdIJ1U3fAUvFke/ijGuk8e6pV8OsdRMUDWUIdYKfSF2aCsDTGMZYhbvLZc?=
 =?us-ascii?Q?ylpKAQ54UKUCRlIy6gpnqmtnIgVtGRZcGXb8SivQ+F67HtosELSDQVTuT82F?=
 =?us-ascii?Q?NJuhcAi9iamMoU58395FUdTEe1ZQSRj+hDqq72+k+0OGJ315UNtGDsOQd13Q?=
 =?us-ascii?Q?uNjXmMR45e1buQbwd56bdIR+jNuGqjEa/YK/ifgIwwbg9nICe0P4ckTf4NmS?=
 =?us-ascii?Q?dCTDdf7oDqboiy3qc1Lc2qC4gecRZXxor40HAGpHZW0XCF+LbyfbDtppcFId?=
 =?us-ascii?Q?yojQiVL5fCtM8sITPv8BNrKdPscmtykWNHxrinuz/rj3PkMA6npKvErAWZ7j?=
 =?us-ascii?Q?BcsJEw3LYcoSmwBEDr8XsxwcpmAgzhnPGgIsL5yKamG0qWx5bTcEQdtvI7D+?=
 =?us-ascii?Q?Wzv3hJogQ17+g4l5U3LKd53DQiBROg1ZGSx0BY/T3zTXg8EueytQ95Ious9X?=
 =?us-ascii?Q?qkzXUgaVEchtAjHp8T6d0+7KQw4fqh9d7zRMB9ZV45lNDlEbZUtoxVz234zX?=
 =?us-ascii?Q?blYc8KF1tmWW3Z/3sXkAWvihCDeP3SDRPOt/evmrywTLxfeaUkiGqKfeqEG5?=
 =?us-ascii?Q?FCy01QlM0jiWFhJ3ry3yr0Ibi965C9a4wUaEwKFVWczCelg4NIcqa5CEMkeL?=
 =?us-ascii?Q?l3xs3ybAKe9kcSv83GuScGrgBUVu6AQLUlx8IEvWlahpoO1ERlQ4nOtTMPFN?=
 =?us-ascii?Q?RTX4F3rHPOjXhk9ErkjMIouZz0hWc62nLZkK8xla3qcbk0ty9mGdl1OQjPpN?=
 =?us-ascii?Q?GUkS5ZbumQo9s4fwbTRh/8P6GI4ng9M6D41ezentPyIuXY6ApFgIcyB0+dsR?=
 =?us-ascii?Q?1mI0LzhWj5CK4wPa2y9JYc0LUVTbtqFtorFbFCekbEod8+7C1WRbWpgka44i?=
 =?us-ascii?Q?wA22NkxHRdUVeGDYQZvjIRm1SVTv1rXY9iKW/sjK4yLxVQluDHsBQ0bzxU1T?=
 =?us-ascii?Q?aAA64MLZZHZTNDxhruU6xPB0SfiKpfZj6Ujgft0ghRgpMevVmHWJIJ13Xc6c?=
 =?us-ascii?Q?6yxB3VqSVZpaViIiKKFgNynCEKotvph2ToPFaQHqiDWFzWE/2BsJHeh0WWfu?=
 =?us-ascii?Q?BZF9Xy2hE+faG/+msJIsGZXzyFKwpFa0R0jm46GWzwTLGQV0SUXeF+aeN9nQ?=
 =?us-ascii?Q?COgy4C1C6806qpMJ4YLuJKdw/LlIaF6/5hQa6VtU1RZQpkZ2QXLnhHGqzZgZ?=
 =?us-ascii?Q?FpVHPP1snH1dLycb1WlR6+WRIMd/Sbgu2msbUG2Qp78YWobeygMcqTq6Ly5q?=
 =?us-ascii?Q?YF/Kj6ZfthFdpnsig+ZxIHbf72iAaYR2q+rrquhFl9Hq8hbfcHb0ay5HvhbX?=
 =?us-ascii?Q?wLOixnpKyKlt9Jo9oeY7IcMzlBXw38oWpO586muhtd7PkM/NU0qU6B7Kvb4a?=
 =?us-ascii?Q?/dJFHo1uWJACrVi5q20k53oFASogysPaMkHqBGziWVZMLb90JOVl1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+hhcwgi90AByZw9Y8YyANOL/GG21HNZehIBBzeUjeHchOp1TUjH6XpDQenMa?=
 =?us-ascii?Q?GMpddVfVmmX97ymnbh/Zb+Io+gJ8bvSmBCo1KDCOupOHMgMI0rzkXa5t1FAH?=
 =?us-ascii?Q?onFXNWjHqnBMU2KcnfswDaMy67yynpSQZODj5n2ZwGYuFp95IKCG+r/qEIWL?=
 =?us-ascii?Q?/3bOuDdS7pPbBjwttgX3kbdZbzP97DtvuWfvjPuEIaECKb4EzU62xJxPeLkD?=
 =?us-ascii?Q?Vw6aAlSMImrSk228LfmgLVMYUdm/inVIt+PhIEObQyF6Tcs0oE5cON0HrDE0?=
 =?us-ascii?Q?NTieuSVbrBxWC08GAOTAab/UOWfERtunzUwJ6fczvcFRSCf/JCkdA89ia0UU?=
 =?us-ascii?Q?IGjJyv6Zug+H3jPfGTRpNh+Kk0OOyf0gFQBBN/J73Lc2vpVeRiOfYFFuKaB5?=
 =?us-ascii?Q?Rpib/hdPueHLaJawUQejDI0fvtq+NpM+nOdPoVA+kIj8ESQZquPISe24f6kw?=
 =?us-ascii?Q?s2O2OZ8auP0pnTAMN6Jjgz+9gRIz4wht33p0BE8TuoLDazaNicHrOj1jaC5g?=
 =?us-ascii?Q?K9NNXEoPMFVFkQbfvOjmBAz/+S1SbfaOP6LWXRh4Fjigu1+NikKZri4xEOgg?=
 =?us-ascii?Q?CIxo+8+d13K3RvlbmKOf6gJJXXYnltfntfz7EhM6biadgCRmJJcEiyybYsNg?=
 =?us-ascii?Q?tsXaVdIT7zlTN1wZlBsvxXyDn4BQkoJ1GdUg2EqB784Ac+DUjtOGab2D9A9v?=
 =?us-ascii?Q?9AHNNNkgdRV+yooHJUj82tFk3Gae/2YAQ0Hw1oFjXYg8E9ZBtQ6cjpVWg5A4?=
 =?us-ascii?Q?x0c4ArLT6Bq53QfdpsBQKvpYTFeVcl0QXsp9MLCfeoxodZyorEan2nIfTn5N?=
 =?us-ascii?Q?/+grvW/N68BDkfbTVJJv+ayrG25NnXxTp0DkYcqOxPf324TC/47favcBWLs7?=
 =?us-ascii?Q?+9jmIMsqm1gtaLKr5vst5C6/lWwe4Dm/iKRUE9//bLsx0OJR/6VkwgXIuy/+?=
 =?us-ascii?Q?kM8f6i7O6FPkdEwO+AIqbdewt8wMzzXGnF6igbM5w5mYrQlO3AnLNnqM5y1N?=
 =?us-ascii?Q?tfPRJ3yOxcUw0MkvGJBzDzJgbqbaQ8XdtNogNE3X9nuJJ8spv9cUDSYPF2pd?=
 =?us-ascii?Q?QLDuReNTu3j3uX/a5sZb3L3YIZn6T6JcYk6VdxgAJ7holGyxHO9ZdlUWiDUl?=
 =?us-ascii?Q?h8h1EYeBDzChY/rZEVkhQrYj/gW8uzkHFmfSPm+m23x9OpqsE/thM5488y1S?=
 =?us-ascii?Q?M/WwfYOIjRAxTHKdkV9svUpg+0g39Mr4uUr69oqjS34Q75DlGsZpiVe2hG3P?=
 =?us-ascii?Q?y1NX0rJWiJ/9STr3cmCWEHj0MUkPhQCk91wNq/6vuhsY37ZFIFKaMPWbqiS+?=
 =?us-ascii?Q?lzd7qygdxP3qVWVF1cZVBxW0byhx9/r0FG2ci6dXYHqGk4TqiXS1RmOdQ9F/?=
 =?us-ascii?Q?z9jiVEZsJV1SH58zDmdhP76bfgzs1qYGG06sPycHHoTEGeUbfzE0UYNvtCJ1?=
 =?us-ascii?Q?n2klgDm/BtjvCM2bHeL1Uxt8178RJOZrAbeL7zwRQM89Cd2IE+/m8jBwiUNA?=
 =?us-ascii?Q?yJpka3x5pTS4XrplaCz+46vND9k/Y4IQ+XpK8eEqNK5OYMgo9bPogblgjO8j?=
 =?us-ascii?Q?25mnHSSjOQZ8TXmrjToaZl/dTixKKiFalsm2Zets?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a2b026-bc90-4c9f-021d-08ddd4c30ffb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 08:27:21.0952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33vMu67xZiBxYTdI2Ggg5wqST6LsGBQcV+HWGWE6D3pemWl9xCajTXv+PmRIzaXWvk06jq//yq3Vj32IJm4Ekg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8560

The kernel will have below dump when system resume if the USB net device
was already disconnected during system suspend.

[   46.392207] ------------[ cut here ]------------
[   46.392216] called from state HALTED
[   46.392255] WARNING: CPU: 0 PID: 56 at drivers/net/phy/phy.c:1630 phy_stop+0x12c/0x194
[   46.392272] Modules linked in:
[   46.392281] CPU: 0 UID: 0 PID: 56 Comm: kworker/0:3 Not tainted 6.15.0-rc7-next-20250523-06664-ga6888feb9f45-dirty #311 PREEMPT
[   46.392287] Hardware name: NXP i.MX93 11X11 EVK board (DT)
[   46.392291] Workqueue: usb_hub_wq hub_event
[   46.392301] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   46.392306] pc : phy_stop+0x12c/0x194
[   46.392311] lr : phy_stop+0x12c/0x194
[   46.392315] sp : ffff8000828fb720
[   46.392317] x29: ffff8000828fb720 x28: ffff000005558b50 x27: ffff00000555b400
[   46.392324] x26: ffff000004e4f000 x25: ffff00000557f800 x24: 0000000000000000
[   46.392331] x23: 0000000000000000 x22: ffff8000817eea10 x21: ffff000004fc5000
[   46.392338] x20: ffff000004fc5a00 x19: ffff0000056eb000 x18: fffffffffffeb3c0
[   46.392345] x17: ffff7ffffdc3c000 x16: ffff800080000000 x15: 0000000000000000
[   46.392352] x14: 0000000000000000 x13: 206574617473206d x12: ffff800082057068
[   46.392359] x11: 0000000000000058 x10: 0000000000000018 x9 : ffff800082057068
[   46.392366] x8 : 0000000000000264 x7 : ffff8000820af068 x6 : ffff8000820af068
[   46.392373] x5 : ffff00007fb80308 x4 : 0000000000000000 x3 : ffff7ffffdc3c000
[   46.392379] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000004ed4600
[   46.392386] Call trace:
[   46.392390]  phy_stop+0x12c/0x194 (P)
[   46.392396]  phylink_stop+0x28/0x114
[   46.392404]  ax88772_stop+0x18/0x28
[   46.392411]  usbnet_stop+0x80/0x230
[   46.392418]  __dev_close_many+0xb4/0x1e0
[   46.392427]  dev_close_many+0x88/0x140
[   46.392434]  unregister_netdevice_many_notify+0x1b8/0xa10
[   46.392440]  unregister_netdevice_queue+0xe0/0xe8
[   46.392445]  unregister_netdev+0x24/0x50
[   46.392450]  usbnet_disconnect+0x50/0x124
[   46.392457]  usb_unbind_interface+0x78/0x2b4
[   46.392463]  device_remove+0x70/0x80
[   46.392470]  device_release_driver_internal+0x1cc/0x224
[   46.392475]  device_release_driver+0x18/0x30
[   46.392480]  bus_remove_device+0xc8/0x108
[   46.392488]  device_del+0x14c/0x420
[   46.392495]  usb_disable_device+0xe4/0x1c0
[   46.392502]  usb_disconnect+0xd8/0x2ac
[   46.392508]  hub_event+0x91c/0x1580
[   46.392514]  process_one_work+0x148/0x290
[   46.392523]  worker_thread+0x2c8/0x3e4
[   46.392530]  kthread+0x12c/0x204
[   46.392536]  ret_from_fork+0x10/0x20
[   46.392545] ---[ end trace 0000000000000000 ]---

It's because usb_resume_interface() will be skipped if the USB core found
the USB device was already disconnected. In this case, asix_resume() will
not be called anymore. So asix_suspend/resume() can't be balanced. When
ax88772_stop() is called, the phy device was already stopped. To avoid
calling phylink_stop() a second time, check whether usb net device is
already in suspend state.

Fixes: e0bffe3e6894 ("net: asix: ax88772: migrate to phylink")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/net/usb/asix_devices.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 9b0318fb50b5..ac28f5fe7ac2 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -932,7 +932,8 @@ static int ax88772_stop(struct usbnet *dev)
 {
 	struct asix_common_private *priv = dev->driver_priv;
 
-	phylink_stop(priv->phylink);
+	if (!dev->suspend_count)
+		phylink_stop(priv->phylink);
 
 	return 0;
 }
-- 
2.34.1


