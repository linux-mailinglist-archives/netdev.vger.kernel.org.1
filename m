Return-Path: <netdev+bounces-249858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84176D1FB70
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30E8E30133EB
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2392139901D;
	Wed, 14 Jan 2026 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OvQaSM3i"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013038.outbound.protection.outlook.com [40.107.162.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23D1395275;
	Wed, 14 Jan 2026 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404101; cv=fail; b=ebQSQWYBpk8DaJwZX6tiJ9R6zhtW1UkM41aDhin32IfeupYwodKb39beA3EDGF0tOagGUIS4QJL0UGkqmmWYxkuVLdgsopttsK7FFt/lY5OlGohDnh5AXckCNoh/pv0wyAeabSMoAujgOa7tWchDAvHS8xBxN+VD2cMTW2mQpqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404101; c=relaxed/simple;
	bh=4yFAWruSblcDWtmK0rBaYyczP8z5K3a8NUQV/6shTH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NgAr1ZTNyi7ZljBtq7Vv6UpHPXKJ21qLAfUjHdY/7NHi0oC/v6u3cRxvMANFpqt+1PHjHJwLvPFHeX2sirS19FZ5vXW6raXaha4S4HxC+fhsYriy+SpgVBhBdrKOLhkzs8G7OGghNV326BniEBOkEmsA6YwJ61uWC9vlHZdVcKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OvQaSM3i; arc=fail smtp.client-ip=40.107.162.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8NeCVE/fp6B3lGiARS2d8Eg9z23Mzg+eJnrrVK/c3fMsXWc7G98pRGVp3Ukp0FQspdepDp+AOEtar1/OJkPy+xd2My2AHEvmNDXvFXSOoB2fKEaNUBrAgCBZmQ84DtIdd8JAzHDcHJ+qTObuR4YhuNTvhozjmEhwPXiYarXe+1TPI/zkVCYPHxvlrt7oapLvsEq/3cvBYx6vDWv5aR0PVaZGMshxj418GDZ60hYYPzV5hzFSz+RMXZrs56R4oIzK9g2k+ZFELJdi7Qw7OxueZC1cuwyx3HLuuZJP+pjN5oRcxs8f+FiX3C4/cBJcDDVtkrtxTGCtDlu9XXqGvkSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vk7+9rgKnM4kOyhaqIdBEBqfG8OZ6vYf04Zje6jhFDI=;
 b=ibk5zBWCwFqJCp4esy/OaJwVKVDxOSaZP6M1OmLeQCdMsDxUTfaFbms31352LQDI+/9kjlHJCAJeQFmeZAteGbdmB3NmotiH31b5UFRiwQebdLX5ju3NuBjIzjXH10BXJQP9u6u0VCvpZZnmLlhUFQ/rsFkXGnWFJfe3ys5Q3XsI7Q0LaTsF1h78UOoFWCBmr7jyeQ+X+BBbBSZlSMCMMjmpu79njHRo2fvi3E306uJ2yRLjz2rUjApqvhkI+7Dq8MAjAJFADSB3uaVBojhmzND/p97GG70nq7YgOVETMvnNjxQUmJe+ci3wt74Y7reUytkhHgkVABs7W76Wh4ef0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vk7+9rgKnM4kOyhaqIdBEBqfG8OZ6vYf04Zje6jhFDI=;
 b=OvQaSM3ibNYwyy7sRrndkGcqZqdOCTcz+Fis8Gs94aPO6Z+sCsPDbgG0V00IvTEG6tvRJMu7W0Y1lpiuf98u+Sjv2xb9c3dvy2rXzybXWEX3bNEkmNuqhEGZSo4Tm6NVmhUHZf6K7m2hEEpeXTvhhPCeFou2zpPQq2E77i4GfXNDvEks8/4QNT8Nr6RvHXdshkQGZdprAuE49w9Z9QSrxe+nQ5nnJJsPEitSsN0Cy4sGEC0irITMtcnEVFPDCmVNjMCq3QcOGyBZJON3auPOcxyumdHT0rCWZQ4rdFKqpz0oGhsPkXD49YSL8AMkEZUlmjCQcgkhfHNg2bTASf4zZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB8PR04MB7068.eurprd04.prod.outlook.com (2603:10a6:10:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 15:21:21 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 15:21:21 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH phy 1/8] phy: lynx-28g: skip CDR lock workaround for lanes disabled in the device tree
Date: Wed, 14 Jan 2026 17:21:04 +0200
Message-Id: <20260114152111.625350-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114152111.625350-1-vladimir.oltean@nxp.com>
References: <20260114152111.625350-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB8PR04MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: 606943ae-e624-44dc-ddcf-08de538092c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4dCXhhmPnjwLlim5Hl9BCj6cUJ9WMMmd3Ea53yu2+T8JInjfzJgT5si9LAGF?=
 =?us-ascii?Q?mPY3uxZH0BKD134iobEEvr+YfVaGfeMKQc4GyIh2PQODPkioV2eymQ80XVcT?=
 =?us-ascii?Q?GZVfZB/9NA3yugyttSJE7OoQSffHDfaYLt5ZThlRnu9Ak1jKLty0sq9ywzDQ?=
 =?us-ascii?Q?jJ8OHWJHh4AJ4k1Xu3o+7tu9BNg9GOuSdlSS5MDx8/Q5AsfiGsoKZa+PLTHW?=
 =?us-ascii?Q?0i/pJIt6p3AHyK5Wxd7SQatAmMbusuCxgWVA1bcV48Yo5JZ/BZC5t4hxFF86?=
 =?us-ascii?Q?4oPvxp/QaY1kaGjVu2CLd2/yoyGG2tuACQiZcp2kT1G/o5maq3gzdkWv/qX4?=
 =?us-ascii?Q?Xqj3Oy+wsg3TmVzwGwvKJK6LiiN4sE7SdkkgcT9J2yDoX+nKpSKBbC3OpVfe?=
 =?us-ascii?Q?rUOiybZCzQbDvp5yxG5D5Ovux44XsYoH7c9/6CdbEcrRq95FJPJteyq81yP6?=
 =?us-ascii?Q?I7xcYGfXbX4imiMWGI/T4Yb7G5tmIkmlzeLJpfNN0pkbdYaPuvDn2GaRtCjM?=
 =?us-ascii?Q?gSVMV8uhZq0poNtFlF4gyw67aJZsk26Q0wEA39T4aPk9QtVkS+D7jrcGLw/Z?=
 =?us-ascii?Q?ucO0dYLR1F34BAbhdMorbmPYbV68V1NTvv9c1M2wy0B3DtIAJDyYsjw4f8bu?=
 =?us-ascii?Q?BkojLMc+PdIIi4D0Fi2bCXVNvOuR2aJkMJLDVzTmwsMYfUqZs8cV25J2qccT?=
 =?us-ascii?Q?StzUw/71Rt+bbDX+nG3emUhc9jrii3ft9DljTZzV2mAvZTiJCGlvPqzatXpN?=
 =?us-ascii?Q?A2YyAM9MJkd8fqM1R+1tMn0PiexWvcsIOHX/2gGRbLuwUQcSc+aau8riKZdF?=
 =?us-ascii?Q?gDkp3Ar5LRhcYTASHGeoNtmPYSOFCpAbBrUb1TJZIflhXeHSrxHQejuU1hJa?=
 =?us-ascii?Q?iEuabYI7gqw/xLUnET4/YTwk8gj94XRipqTPwyUPjnp+raBFQl+DbFZAvCWh?=
 =?us-ascii?Q?V6uNcBuHOAi1vGhnMpPmIVXCYZjntoL3NcPu56oinWgjK9Ouvn+pqvA4VVRv?=
 =?us-ascii?Q?tErPHxbyCbKLu7jGj12RXDyYh7lVbyQWcEGcp2HjFGigPbD/fijsj7wGSdvz?=
 =?us-ascii?Q?LCfjvclYLx+yB/5EtXnv9v+we4NXoubQPMx3a8bIxGehtD4bbEIllGP5Fl5W?=
 =?us-ascii?Q?oFk+zxH9h6IC74qJMCEfOGHPdbUXiVlOVAS83vD5KBkqifL3LpWBEhNVtUA/?=
 =?us-ascii?Q?oW7Du4EIcA/qqQLGcR7y2z0tV4CsQleRwmK47pDch/SP6ZiWPMaifWkqpCKC?=
 =?us-ascii?Q?Ucbu/OqKdipjuOmZrjnHnbDB+1F3eDPFfZDwPaeBL3oHVYQQ3VfoBX7EgrU8?=
 =?us-ascii?Q?PAa5w0Yd34GlFrwl3zypLxsa4mvcmlQZwdjE7fUTcKQfrperCzXdGiKKR+XI?=
 =?us-ascii?Q?cDi9bn8ZYCuClcLjNnPqye7nB//v/eY48s6mppv69wcj736CfwYCkGjjfI21?=
 =?us-ascii?Q?XA2WGRzfYeUhddEEOi8s5hdCoCZcQA6g4L+fm54n8n5/nsi5vqyCI894w1pL?=
 =?us-ascii?Q?BcZCWHunRjhYNSL2ZpLqGwQZJQri6BcTOBToSlTitowhWROR8GhtiZnRNq5B?=
 =?us-ascii?Q?fQAIaWKOh5JBOKhZvF67/Fzmu9pZvd2q48Pj09VnpNCyFCbc49CixIN31RS8?=
 =?us-ascii?Q?7a3usLG8Oc0ZnemcUqbJJP4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?163y+ghuWL738WSmKzHKg92auUlsXp7akWHEk5tZ6YdkXkGI+P/WiIuIP5sg?=
 =?us-ascii?Q?+Z885nNTTv5pLJvO+sIi1IDZVvIIPzwcgjViEVXjbw2/xCLtcw89En0t6ZWW?=
 =?us-ascii?Q?Ep03iVAEyKjk5U5Xx1TtOX2Vpg/cMzaQZfDjEZY0uofs1m1WbUkLJt8OHx3g?=
 =?us-ascii?Q?3zOORLHUGa3OhpCLVJn9bjUhr0VmtuiKJPli0zEToV1Tz1/u13DbpJhr0N6J?=
 =?us-ascii?Q?B42IALc1NybocQbw74Z3ilchCdqklCQy1dgSavz/2LPzahEOETQ8pW9k0i0R?=
 =?us-ascii?Q?Cu9DbkkBYqh9VAgUKbBX/TrDcF8Bs5aD0x8Sy1RxbVrwTnZn7Rlo5iS9k51w?=
 =?us-ascii?Q?gD9m+Ev8kp0JdYJnnRcugKy/VPu0vp1TtasiYc7MOCE66x/tZnq8Uam1DWGj?=
 =?us-ascii?Q?t9niUDhUBQcq3pn0Wo8io0HKwcxBnxAVPjpgfRJ1OAV1+B+X3pzYGozzNeYI?=
 =?us-ascii?Q?/tFhgTXiGwZxrYvVxPocPCLs3jX+oVLAdXB6wej3BrerA3+wK0sPgCdA2Jw1?=
 =?us-ascii?Q?mleJlH5XFudBACKP2CmWYFOSZlyLx7nUAdstWjM/s9jyIsr8S98nZKZ8ZIgJ?=
 =?us-ascii?Q?vRK+AhIVDYoXuCLWf4GWa+kk0lDjIla2AbdTKsCiC0UhFWrSYzeTDACpcw7A?=
 =?us-ascii?Q?DdFQZYLrkvfvXzu+PuGfsuPsdTUnfrkryu1FR+HomKBfQhm3DTa3ztu0YyOG?=
 =?us-ascii?Q?/f2pDjtgs+cBFdTikQs9LaE8Y4Yi7wBuxse4tbMXgpsJok//sOUGOJ2ryuum?=
 =?us-ascii?Q?zsTor1kBwQ88sjkKjW0BNTGcqyBIm2Rt8kWzXqX/NYl1QMNRJx4l+COt0lGL?=
 =?us-ascii?Q?utMxPMnFyv67YzzHi9cX/50FzF1n6yIeNw517nIFarB00IkXklxMIqwAE4aX?=
 =?us-ascii?Q?xoFl4RdB0R3AM4At502//BRP679UDHq+gG2PrOmCs85GjxtcX4zH2lcwRWGX?=
 =?us-ascii?Q?MXr9gkNfUTZnmrKsLQDW6pRF0sQApGEKUw8kmk4i6xOisNuZvpYKrZsgV8Bs?=
 =?us-ascii?Q?TJOhAbPMI9R9VRwbLJOuDUCKAnuYQugLuT07PxWlpqSqzKJGJAtx9EHO6W2v?=
 =?us-ascii?Q?I3ohVTpWcmgRqhkd+d6R6BxiXxJvdW8WALpYI//DgnjJ/qEJjtzTXuUS502b?=
 =?us-ascii?Q?OyHmAQA2yH2mY24LCM72Ju2JYphPtBlb6dUN2ut02oZR8N69TtgD+609nMH7?=
 =?us-ascii?Q?NHyymMar4caUm0lnYlCzP6ywSNIMUmp2YZYKUez93q0iL/WTTj69YOBGElxX?=
 =?us-ascii?Q?BPJYCNQdVHyb4KwE/BXN3hRvvX1XcL5WR3Ef1XLdbeKNcp0Suqaqy8yo53g+?=
 =?us-ascii?Q?H4eumj/n/1WBnueUrgnzsCBNupJesZRU196EeHHCfG5ajIgKuCoG51eH95c+?=
 =?us-ascii?Q?dlv36AJFDe8twBoVJMV+Oh1Fk6YSMoCTWJtFWz/czb/28E8fCObNEI4z09da?=
 =?us-ascii?Q?KVGpNwRgpgrbSe6ag3ibnFUErLLTJlneNTHb/mEEVPCFBV8Qd6GHAMCApAAw?=
 =?us-ascii?Q?Bd/BefEsSZFlsc2MuHuydjSje+5gjvR9JmQRgwN3hhKNh9J1duZb//GDmKFK?=
 =?us-ascii?Q?a1l7pDlTR/O63J04aWbuSnGBXjYJS7O9FGlCBzCWDOWSBajvn7LWRFpkgVgC?=
 =?us-ascii?Q?emU0+bqT++KDQMR27zf/p2TCjDX/Ep9ZRyol0dHTGd42qfJ60NyuQBP6aY9z?=
 =?us-ascii?Q?Emegb/YVsB+mW9Nl1+sz+WaS7ytKmXYWN6E0BxcIyPNdwBdNUfv0UdWFWaC3?=
 =?us-ascii?Q?T6wjQ2wp4mYomvFC9oe++hj1fH38GRA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606943ae-e624-44dc-ddcf-08de538092c3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:21:21.8489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rj/PmdG2OUft8zMqqss263dKJfDlATm90fiIUfpZCb/8Bydy0WrG8ZTY3LvMPAz84EvpYdMiiMwezsfWxJnvRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7068

The blamed commit introduced support for specifying individual lanes as
OF nodes in the device, and these can have status = "disabled".

When that happens, for_each_available_child_of_node() skips them and
lynx_28g_probe_lane() -> devm_phy_create() is not called, so lane->phy
will be NULL. Yet it will be dereferenced in lynx_28g_cdr_lock_check(),
resulting in a crash.

This used to be well handled in v3 of that patch:
https://lore.kernel.org/linux-phy/20250926180505.760089-14-vladimir.oltean@nxp.com/
but until v5 was merged, the logic to support per-lane OF nodes was
split into a separate change, and the per-SoC compatible strings patch
was deferred to a "part 2" set. The splitting was done improperly, and
that handling of NULL lane->phy pointers was not integrated into the
proper commit.

Fixes: 7df7d58abbd6 ("phy: lynx-28g: support individual lanes as OF PHY providers")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
part 1 -> part 2: patch is "new"

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 2b0fd95ba62f..63427fc34e26 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -1069,6 +1069,8 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 
 	for (i = 0; i < LYNX_28G_NUM_LANE; i++) {
 		lane = &priv->lane[i];
+		if (!lane->phy)
+			continue;
 
 		mutex_lock(&lane->phy->mutex);
 
-- 
2.34.1


