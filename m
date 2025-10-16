Return-Path: <netdev+bounces-229997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4881BE2DE7
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7EE1A6322C
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD432E9741;
	Thu, 16 Oct 2025 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dGC8cNp3"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5942E0938;
	Thu, 16 Oct 2025 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611376; cv=fail; b=N8PsIBsB0s1ipSuxLaL/3aIixShzi6SeHX0V3wfTG75LYKPklN9gk4F9WmDofmhiWgBbbJTGBNlLHqAl3eWg61dClX9YQk7Z9oQF1VdL9zjCc/BxUAH8AwAfVoR2J0wsJ4M7Ecy6uCVIgzTpBhU1rXEOe6nQ4q2JastNQQ5OgsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611376; c=relaxed/simple;
	bh=eZVsjWV4JVijHP9bYcDZQpR6h6yhM8aDl5za8Wtb98A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XOJoeB8YJmOooMCW0NYsZGZKCgo1IcAogtlhUsWPyFoX7myj9ByIyi58miiClPnIRa4A+CG+KrtpMmZBbDtm4S/rUB/yuN1/iehnwnuTGXEkRINWwl65MZKinH4aUjDsZ3ogc0ztXhQbP+qLAFvuBRMPdUGe8vXa+JVnb2cQnec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dGC8cNp3; arc=fail smtp.client-ip=40.107.159.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAutaRVsTJAX74NeQ6cXkPmr/Pf1UipQoyLoSFiefTp0r9sPLAW0HSS5072YAYBgeYYMOvlYKGjZt3oqzkwsActsO1Nie8zqQaOWhKXaWxzA25jHrmdOBDcYY4owu5YRJskbw99OB1rnlM1/u+jQk2XiUkj+yuitwfysvBaTGdE5XMVDJmqN1eIWv+htfV8slta0QzQG4G997qS+tcTsoUkf4QyIRmZOSKkoxVDO+swFWQxTpyIIMHpc1Nuv2O6zVsh+hFOosh1k+sH+wcz0SEQsUu1+eziErgLMjhg1YiAYMh5tDlgVHp3NswJuCRNdHTwdOOhLcd2Xm1weIbCUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDQrvHqfIuFihdk0dPKHk91G5UzxIGKGfIbMbrnOpd8=;
 b=SEKKIhkmaUewpkh6052RTKtIBuWvSki9N9Tvg2kPUs3tvpnGh6BEwDwk04XwIpDgoxWln/3cmUzfW/fftbpDN0N3WnpWjW0cZ7aCzonVw08eR2ZFCnVGD9PVMSDdEw/S/SHcrjDHqMf+dUMms/fxZQBhFQVEeeiXnuTSug+8QZO7TJRI90rRttA+u0xgC2iUZ/dzWBRuaED0opawE6g1TxnRuwwBTsrXvPWC0OQkjeTk8WFJ5mt97f1LzD/ldRRGfjxE1iUDAFCNZcMgqDit0ylimKnbnRuJLQ6FmsHL7Y5wYDwprNZ0fScyqDKyb/dDF+IBgoeIkyv1zc/0V3JZYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDQrvHqfIuFihdk0dPKHk91G5UzxIGKGfIbMbrnOpd8=;
 b=dGC8cNp3xsQCuh7HFX1aWyrdAguaalzmLcEi4+HF+j8YpnLGVcsfIH6RGG4XtI9d4uVHIAsd9wzd3Zx+smViIw2623+wfiw6rLlgcok5qJtS14vBzwxNYsf+7gWRKQd/Hh2WStdoy62+PQu2GsGtIPF/I+YtwovNQXqAvu/T3Z2a1lc+ckD5vIVEJrnjWoDI2YCcxS45xnzEl9nQJOFTTQtAr9Uf/xn3E1DmH47FgUi+FyBG424Fx5xBtym/0hwKb+VpLcL/m40Ugm+W+so3dz/ji2SfhCy4ctaRVFBkatTHLV82RqZTypj2rMMXEVNQTxVZE0T1vOmUP5v2GwVPfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7361.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Thu, 16 Oct
 2025 10:42:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 10:42:51 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 0/8] net: enetc: Add i.MX94 ENETC support
Date: Thu, 16 Oct 2025 18:20:11 +0800
Message-Id: <20251016102020.3218579-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM8PR04MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: b59d51a8-5d02-4ceb-fd26-08de0ca0c157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|376014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sxLjBLD62PMj9aedyDDsdlDylXt7QLR4Qn16jIl0DUGR4KHNS6UwWzquv2Oa?=
 =?us-ascii?Q?xTRMoYG9gVwbKWdgr9kIqeSSciWOuqLJvJ4lfHDyTeXE83x60ZYLlMPgU2tf?=
 =?us-ascii?Q?4UYFqUu/PAIk3KMvtlMF934r8SAfQKoZ819/CXOa37Z+K1UBKXflBXLbwXmR?=
 =?us-ascii?Q?MBR0cM8vUg+sBWp0Hetsc1/ymHHCJhkAz4gEKCXR6xPzgVwxk0kIDguTrLm3?=
 =?us-ascii?Q?TlmIB8iBdGdst04H+zlSAZMLdRYOqhWukED19S5Xyr975JT0mCk8Ge9vWzAI?=
 =?us-ascii?Q?CSnBNCmmQ31VZMaW7ZdulwsWBF49ls9DM+HxYcfIqL0/dxADxDrBzVH4t1AE?=
 =?us-ascii?Q?GSw/iwzKyZQhvqTxEHkKpXjH6R7Rq8edzq9skdci2dfwhOgbssXykla+caDa?=
 =?us-ascii?Q?d+zB9W7nB28MxPt6gxxWPNUzVARFAwpDyfYCs3oQAIxMj2mxkL7ZRTWW0/Hm?=
 =?us-ascii?Q?riWtZK1n/375UYuXhQgFbjrj2UZlZLrRx0M+GAa3tXsynuSDvVMqO1w2lB/L?=
 =?us-ascii?Q?efR+Meorhlh/1mYHocByg25XWunH3FJhBxs0heyRGK5xDq+xBcZlJ5KIfhMG?=
 =?us-ascii?Q?8xo1fF+mf+iIkRB0vA8vOTuw2ge5aefFhpawUHv8xJ6/NV/HOHNq3YA2aCA2?=
 =?us-ascii?Q?DpZpf74fFkb/l7hA54CaI6ReLsZDAsrP62J6DZhdjR6EePTpAViO5/3oXj5c?=
 =?us-ascii?Q?q99pyVb67ps/CGov+gW/8rC4N5udBRZn0XM5JVNCLaUs2nx4ukWN+hlpIHbT?=
 =?us-ascii?Q?g2pqCqKVX8zSPFVOunuXC1+qZjakvRCJXIsfS1juf8QeLy8H11YSUwQwS1gT?=
 =?us-ascii?Q?aNgOz8sszho+XG2mxlWO87bsqJsznnndLfYhLk7yKCfiT4aLz2y3R7aykLh8?=
 =?us-ascii?Q?LNi/wBi6lhaY56thw8wcRBuXZsA1dqjCKxlw35IzZbag7U3wK3mXQ7lvUi42?=
 =?us-ascii?Q?jMCILr5aEkZsda5K9mlIRM55G5ghjW8tIMX0hUHDgPMnbeTU16IZZGjEqh6u?=
 =?us-ascii?Q?gp+ciKISXteEAfwhYV4YxJIoyW6WRd+lC1DsMk0yqUhRlwvr7qkYj38AN9uq?=
 =?us-ascii?Q?f0Wa23ZPjxRq88tc35xsxMe1OMqK5trQtyG+VuFkdCaq9W7DUX79UgXFXVCj?=
 =?us-ascii?Q?XK6qJ6zpSCZObFqmqtm8gaFokcwflqfPK/BRjdXLWO9q2EYWY/C/4HPBI4F5?=
 =?us-ascii?Q?PfzKHCpRAKe35U/q1fFjo5NwQV9snTz22YORbtPzplUo1SADSsPzEHkasHeG?=
 =?us-ascii?Q?0/+k2HKQ+UvvK7JJjObutAflwmtTQVDdm2s3+Doq/oYolSAinJqpwAUvxtpk?=
 =?us-ascii?Q?7LJbmq7Eg3PIwwv6SjTIcbXOVOqpZB/UE3cdPwQYYYXQAfc3CYUxR/RXcYEv?=
 =?us-ascii?Q?QnEVYt5l6p8cgLJ1Z3wwUiTiVqLCYoiwRFe2KLBirMx7NetcPrL9iMDwP4LM?=
 =?us-ascii?Q?jz2QPsmpEhFeTB7LtQnKS1frY6XY+xV6dXLneKyUuNErZMsi5WBFMgnDbL0H?=
 =?us-ascii?Q?qBsSWOdGLBmliC3qcM6pmxZ+BCHkakEa7Ymy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v0/YQPLeIiR8gf/u6X4dN08yIO4DMzzw8j67C5gGoDmoEx/uijE2wFV7YYul?=
 =?us-ascii?Q?hnXRaMoO16vb8NpOwJphG4CpIZDBj79uIH9pD/+ftKWB6bcGDt11J5d1yLj8?=
 =?us-ascii?Q?7zbwGCqVl31csQOudiG39D8YJPrQ4fltCWEBIYtNf9OklWtXelsGCySwdIK4?=
 =?us-ascii?Q?7G7UxNYxo5luT6/FtwmBqBLy9Py9lj5ZFydr9Q0aDLdwjY1N8mVeJBeWzpq3?=
 =?us-ascii?Q?zjxu6QCPDVqr1ZJ9ullpQW15jcGJ51HfEmNEhIL0fkzMWmfvgzoZ2tWpq4Gy?=
 =?us-ascii?Q?ANrCM4l1rLq+nfPLFjtpNdBu0w+EXZZCf0GGmqKi8KFjtnt8uxT2oevv0/r8?=
 =?us-ascii?Q?HmwkTTvAAJ1Ta9b7MeP7tLKg0ooziP5ZjZ6zFOzO3wOFTWaloIB8M6zISHnp?=
 =?us-ascii?Q?6bjcshPseUw5CrRmCjJyVMq741KM4uoLzcPRmPC6/jatQWf6RufVGjxvaxEr?=
 =?us-ascii?Q?3bH1WsrvAFBWImJwtD8AAKw/PZxiNBtbHf3SIhk5Nr36xqvoLjxeE+3HS+o0?=
 =?us-ascii?Q?EuSSpWwYK5od3/CBAmLq0Ldq3jASjNioOXZT5xdBFDwhWwF8uRqe4E6lm3UH?=
 =?us-ascii?Q?bbXQlz2/zOsSdK/KGiIEYiUC45TQNyz7wckoIE6EOnu9kA9vJquOz9yt7TMZ?=
 =?us-ascii?Q?N1ThtU3Z04AaWet4DzG8V1CVUhqyvZSKGwHMal83h+QxS4wFzUM2u+etVJij?=
 =?us-ascii?Q?cRW7/g8of1r3h+N78P1EKS6hzavFvGX5ctrnLm3lLYPmUk9ExaoTVh5MGcxS?=
 =?us-ascii?Q?76DBBn3kaZbUhnPuXt3Ik1KEgjtviW8ecUhdAKRr+rD33k6jX0f9lwNRFxPM?=
 =?us-ascii?Q?Lerq1SvTdDsrc0LZRO9Jk75bCraYWNXdpvLsYBjhS+Pil62e6gJEPK82/DMr?=
 =?us-ascii?Q?9NqWtBAQvEiN0WuCGU/kRzp4SAGDAIJZW8D5LAgBkUYPX3trHKH2Z2z+Sp/C?=
 =?us-ascii?Q?eEpCvab4zXkG3AylmSugD0IPQEj6pYGgkgyQ+vSlsgHBQu3k0QW3ljpOTp1E?=
 =?us-ascii?Q?K1VUU6SDUILoe4m2laK3ek8wWWtLbRuIfpdu9/CFr8QX7CloTHdyO0i7lNBp?=
 =?us-ascii?Q?POiHEsJevup6sgex2f1aB97pi26kvv64lzxj5gs9nLXt7PBMs4sIpGLaOI1x?=
 =?us-ascii?Q?Eu/zdokV8tOnuAU5h4iYnqUAqdrpujHHeagHhW7iR8ys5qYWSZnQbcmtVMbL?=
 =?us-ascii?Q?8QSeK3Kw0MNjHLhqcvPjbXoySgy6h70oiYGW09xVbTo1Y0N3vBoLWrxgQxmc?=
 =?us-ascii?Q?nJ792JWbqNwIFb9t4sEq667/h6DcvcTOIqn6KX691liDzDqDn9GO/wo2TfdU?=
 =?us-ascii?Q?T936qmSXKxx66YSE8z+YBUytih+sZeXLr4tDvwxBk7bGWKxykmJc7xdsUzHz?=
 =?us-ascii?Q?XTepmHGVMwfWUvSohHOyxbcmOM/OB49oVm2gMRrx7YXGLhnyoC0uwbLhZfZh?=
 =?us-ascii?Q?N3xnReNd5/YX/zyWxbMC5B/ro6oCtCkZoIIkgt93NC4eswjde0e5bEJRPRVU?=
 =?us-ascii?Q?lXqfFCoL355PrFCKSsAQaF2L7t9FjJU+jk53vJovvDsN8YEBHvetIb7hAXbf?=
 =?us-ascii?Q?O9ko1+GUXhOijiyMcgCgMgr0xo+xUvDq5N/+S/gT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b59d51a8-5d02-4ceb-fd26-08de0ca0c157
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:42:51.3294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ni1LlGVRKTfiA7VVrSeLFZpAbaELGC7aTejJkwRi5b/evzovC0CYa6CshIy+LOg0gSmDf/5wQPWK4ywKdFUIzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7361

i.MX94 NETC has two kinds of ENETCs, one is the same as i.MX95, which
can be used as a standalone network port. The other one is an internal
ENETC, it connects to the CPU port of NETC switch through the pseudo
MAC. Also, i.MX94 have multiple PTP Timers, which is different from
i.MX95. Any PTP Timer can be bound to a specified standalone ENETC by
the IERB ETBCR registers. Currently, this patch only add ENETC support
and Timer support for i.MX94. The switch will be added by a separate
patch set.

---
Note that the DTS patch (patch 8/8) is just for referenece, it will be
removed from this patch set when the dt-bindings patches have been
reviewed. It will be sent for review by another thread in the future.
---

Clark Wang (1):
  net: enetc: add ptp timer binding support for i.MX94

Wei Fang (7):
  dt-bindings: net: netc-blk-ctrl: add compatible string for i.MX94
    platforms
  dt-bindings: net: enetc: add compatible string for ENETC with pseduo
    MAC
  dt-bindings: net: ethernet-controller: remove the enum values of speed
  net: enetc: add preliminary i.MX94 NETC blocks control support
  net: enetc: add basic support for the ENETC with pseudo MAC for i.MX94
  net: enetc: add standalone ENETC support for i.MX94
  arm64: dts: imx94: add basic NETC nodes and properties

 .../bindings/net/ethernet-controller.yaml     |   1 -
 .../devicetree/bindings/net/fsl,enetc.yaml    |   1 +
 .../bindings/net/nxp,netc-blk-ctrl.yaml       |   1 +
 arch/arm64/boot/dts/freescale/imx94.dtsi      | 118 ++++++++++
 arch/arm64/boot/dts/freescale/imx943-evk.dts  | 100 +++++++++
 drivers/net/ethernet/freescale/enetc/enetc.c  |  28 ++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |   8 +
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  32 ++-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  37 ++--
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  64 ++++++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   1 +
 .../freescale/enetc/enetc_pf_common.c         |   5 +-
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 202 ++++++++++++++++++
 13 files changed, 574 insertions(+), 24 deletions(-)

-- 
2.34.1


