Return-Path: <netdev+bounces-177828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 140C3A71F0C
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 20:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4CA71897A45
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 19:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD616250BF3;
	Wed, 26 Mar 2025 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZU1QTDwm"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757C1F3B87;
	Wed, 26 Mar 2025 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743016987; cv=fail; b=O+ZuvnF685LlZyUYtyb4VZYebwdOvage/WuKTHC30cnHJ0wtGAGtaPtDxWPcfGNZdSAvC0QXJbBuFEh5KpDwZ5uIrmTwm8Hv0MIm7dS3Gf2oUZ3uXVZf1kRzfBW05O14r5rgBUJ8/6F2RNrGIIOgPzVJKj69E6mEYPO73X6ceBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743016987; c=relaxed/simple;
	bh=MZFEDfj3IxOV+YLyAaYM8O1x3HIz36WI+Y5bfW+qvNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e5k7BEn5FIMXJfuDzd+7xNBNc1VzsGtgheLyRRAylCkDNSlelLtG4P7Cu2n9mdkgTB12dwo4mq8HeWNCACSPf2BmQEAyIPOE8jytrSX7BIh114ZTq9sfMjzr4otZk5o6kgyAl8SJVo7G0LQr7l+jfZjjVh/8npWIYZjsTGv1Mn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZU1QTDwm; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x425VnMU0dZYdjOSVKuqOFsBVG4vtRoPl6IrVyz1fNx1qadTGuCoRpeUTrPnDo8WP2F5T67WhN7y0q3y8ATYh7fZBrbwvSncmrW6Y83eIqG+W0iqjKMA9YxxD1nPgyUyo7Yc2E3dM65lkSR6cxdUwDpDIqL/ebsbOU9vHEzfQSfVydUNIpBE9JA58MFUF32+7HG3iwHz2ooDksty+Ks4jEC843CHob90IsJGgrHQOhLjuy9g+k6lPqeryB1M34zeId9Akmsrkn1fKuOX9M9+Xmw5vwCwMxuKstmlmOFhnHJmVLA+6LpLqvf6NuJoVCAg288OZhZ0bidsKIIzBsy8hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAH41MToxWSdx1oWfedSrVHvPwOoLvn5wPAt1ziE0xs=;
 b=UvOejmPhFDbGu0V2FBNRKcA8P50/uV5loF0LX3OuInYTj5eUTRZYmOTf35zskNEJ4owGXu0rlFlDp8BJY+UVSQ6YKOWtgMeI7sP0WpLP60P8MuSPZWZdwELKc9yhfMRsbTTfjaQHV0jUSh/nN9vH9xgY+syVhKb2KmXCKXuZcSRL7ELDEp5D3jHlK/6h6GJiraxZ8x012fQd2bHnZR/JnHqFUbpMi9nh4h+8cXfUKhioeeVJfhnzlSplSB6tRtigLRtF3KKksyCR0oaY+DmtDjBFe7CTeA8tWy+hhKDts/vYlGpx3t0REsrW3hNgfvzr84YyR7ycahgQdWHPzWV7tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAH41MToxWSdx1oWfedSrVHvPwOoLvn5wPAt1ziE0xs=;
 b=ZU1QTDwmw+xP2le0CAsdmX7R6iI+fj+0tD3s7dCZMYj8dCTt8J6uxRnHwdp32v/jQwGVTn91yTpZOh/w6t2tv2waj++AX6Jo6UyapycIBTDEQgVh67juZPVOgGcPcayEeCCk69oEsrHz5uEdmxWpNHKKYO3NnP+90kD+jr0zQJKf37g9UK3AwACk43heCaD4ry7eVqA56G2p6xfl2E/gaPDRehVLCwmHeNsF99PFc17cQOUPQ0+b4d4PIz7buCr0Zf4HjZwp+J/8tJptyxi+DbRNQO+y8hfTbzFVpVy/4ZlfCG1N5/3NvjUn4RRhuF1L67R9OqMXK6hIyU9mIncVKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB7813.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:23:03 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 19:23:02 +0000
Date: Wed, 26 Mar 2025 21:22:59 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] net: dsa: felix: check felix_cpu_port_for_conduit()
 for failure
Message-ID: <20250326192259.e3m7ydgkeo2ix6wb@skbuf>
References: <20250326183504.16724-1-v.shevtsov@mt-integration.ru>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326183504.16724-1-v.shevtsov@mt-integration.ru>
X-ClientProxiedBy: VI1PR08CA0255.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::28) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2e39f3-ae93-43f7-7f3f-08dd6c9ba07c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Fe8iQICij8Kw3gp7rBWaYXRQPN3D/+y24itWHUFJryBmNUakKdOZQWysbmd?=
 =?us-ascii?Q?0m1Fb7y1lR//SX8racWv40z0Wwf4wpQ6JCJM8O5VdigmJurR9al/k4I1nuzz?=
 =?us-ascii?Q?JF2e5Ij9biVVtT4luAEmaXk3xK68GEoDmHBeWtULE0pjNTs3BwfSMaGbr0Ma?=
 =?us-ascii?Q?FM7BAwTO24D1jvHOsJX7bIexaRYWUuUv36Vx/HrVHvBPs+kKXxQAEfVnJ0A2?=
 =?us-ascii?Q?UMFB+PIqs132YDlmEOnxFxx8i1s3riQDRh2gnBXK6VrVDkLLRhNPxRoLSDSp?=
 =?us-ascii?Q?2ImxZmaDgb/6SStIuch/VTzXkxbvVAX4Jn7Qxh1taUCgDRoCZP0Hr6baxGqN?=
 =?us-ascii?Q?rFbgPvKi9xqhPwJYtngrlHBe8F6w2ToaiBbnhZ9R+ncP38HGtlhsCWzuZFjV?=
 =?us-ascii?Q?/TORWS1IVxkfAenL8PSKLLCERIVTArGR2av5z3prZsqT+DhqPRDs9ElNI0TS?=
 =?us-ascii?Q?rQjNaMOtUePsZ2yh5937YdmzWmEow9075EEr8hH/OisVyb5hF1jyldL2O1Jf?=
 =?us-ascii?Q?qadBv5P6jWymxJfWW3kBTyfsqLyF9kqu6DdXoMbf/tzws8no7cDpXMG6jMjX?=
 =?us-ascii?Q?yv8qhJZpE0oTlaacgTyAiHIQYVEP1iN1alHnpkX9Es1y9VWAKwtNh7JzPAF6?=
 =?us-ascii?Q?NUzFjCgRVHFYg7z+v5GsAUXONds9f1xxRsojSeI+80ld5Ubo9iEdW+znuj4e?=
 =?us-ascii?Q?FVCCh5WCnmbspnt2xKne3oL5c7oXBHVLLKDaHZxDgPqo3uvHXxWHKO9kigbG?=
 =?us-ascii?Q?hIGc8x6tI6dpTrR9o78SQDNyyUCwKLwH5E5MJWu6QTjH7Iyro87mn65aZmQC?=
 =?us-ascii?Q?w3OKpw11ogAPji5JXTDkcB4epIwwt7HHYmVxS6QIy6gsz0BPql68fsIQqy9c?=
 =?us-ascii?Q?jCxmDCbx98DsMMVCX60Wg51dRWC9mDTEGc6M9ojKzqBKNQAjL02Txpy//qRQ?=
 =?us-ascii?Q?a4iUCzTl4HKRp6w0YNpn43dSn6T58BJXHNDSYEr5FiUVAi1S63TkNgC95O2K?=
 =?us-ascii?Q?7h/SEbaISQ6yR+iTMmbohxnasTSdpfppbK/OFNtfZWGts+jW+1CvORIhg+y7?=
 =?us-ascii?Q?0dftzScnWsPReJZa2KV40mWvAR6XT4oBf49l5/p+c6RH7GdjbckxPDv/M684?=
 =?us-ascii?Q?E1G29847IwbVflDMSxaghWGwAR+2fBF7aiwx+0PfCoyp4w/jOYzy2TV2foch?=
 =?us-ascii?Q?3tbrYGMxMttARQ1WgvfOXi/W8gDdFKo4rqDm3OEDX5GCpa6AVnEGOzi3D806?=
 =?us-ascii?Q?25rHDIIsH4o7fm6owNUohcP9M1/eGdhESsaXVIYXDrTE2pW1YEPzAk3ymbYS?=
 =?us-ascii?Q?k1j32rvZvXZkvleRUXfISzheZid36cN638vziA96nyOHfP+BYjVtZ/jnW1tu?=
 =?us-ascii?Q?rCoNSDhO85yr/iwub95oJ4AvlLH++9Wz4HM5MOzPY4O0EokQymkkyJeJIXlm?=
 =?us-ascii?Q?P8GGVDOHXPw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P9P/zU6I3La5fbQuvMgQnbrHunUBOiG6Sfu8K13PIvAHmKtK5jD/dIjc0wyu?=
 =?us-ascii?Q?OI712X0IjrLWxN4BB01v3Y9CKcbYY9v/wi/KfKqqkzwTmYjIBfx0doJ+QGTc?=
 =?us-ascii?Q?3EJ0QWG8qp4ZTctGgh19vQOdVahrKWewEcUmjoekeTSLc3ilHdCxRig1+jrY?=
 =?us-ascii?Q?J32NYY8uOkeCmhEj0t8CXiNGfGslwIO9nqvh2agnhxRGFOfvfXKxau60apnh?=
 =?us-ascii?Q?oAKsBotsbDspj7ozgDU9n5czrKKca2ipaeViHKV+LYnSxol3wuxGjcGJanaZ?=
 =?us-ascii?Q?vmh449faer7xPf0WRapTlw/D8dhJcBqv4Vt58cb+w+yci5wsTfwgeUYry+ot?=
 =?us-ascii?Q?zCRFdeKBYVH1lqx1zNe6IuSUVMf2GbWMfPN76iFKu0Kx/VaQO6K0iGC78wtY?=
 =?us-ascii?Q?CIjJNd+bApoz4x1LQ4s4iQLt5YhO1J2SqAb3HJ0Gzc8xhCGESP6C7SlizswD?=
 =?us-ascii?Q?Zf7yCjNKiE6j3rNOvnShnZSilby5luBcIyOFyrtaBoCj9qIuR9OKCv6guQVG?=
 =?us-ascii?Q?MxMNkcV0SeNplVnreUzZhtE9DdGRpuRgy9RRQzQv+6vQi+dZ8hllfaMwzkX7?=
 =?us-ascii?Q?r40ncWFxTCDoPyq/hmQXPWuMuf8nkK+UBJwYhZh7phmQ2E58bzVW8WL+KFrU?=
 =?us-ascii?Q?rABQrvEL+P4JfQnbXI1cZqRA39ixScA15+FjCrUC3BWrsIieu1zfHktrva1T?=
 =?us-ascii?Q?4Nx3lRRgU/otxefj4JVMz8vF/dAO/FY/gzpTv3iy3GfVraVBa6lBGTtcolwL?=
 =?us-ascii?Q?O/sJX0nAUTs/2DYJy9KFsFgFX3AhRSGPnueiBa4stOVcIZ/q5NGrnTmq1hVw?=
 =?us-ascii?Q?r58706NChoJYyJY+Iosrf/XOGfLRxxs//7oWlER2YImV0MiMEuGrFfzxI+BL?=
 =?us-ascii?Q?XSwwhqD5+dROkmWjhccasOlLGYuNi/V7zEd5M9S1w1Ih+pVV+Lc3/bbfEKLJ?=
 =?us-ascii?Q?vf/aO/Sg3ztHgFcwBpgPafV705EcZ8Plzh/y23JGm1wTzILrUQGtIY3pyR4x?=
 =?us-ascii?Q?boXhf8uHBXr6tMjijrd4ne0T5lLLosRVbHstuOnHxk8ZQPcitpwS9Jgg1Wyk?=
 =?us-ascii?Q?RneBN+eHivN4sUuoGMfrN7wDRz2dv4tWkH6JoM9ETM7yEyZKUXqoOkYM6u1x?=
 =?us-ascii?Q?eC2wrAdAkIHpt/s5fTbQXDPBfapxNhpXHUyLSB4bhX5pdeX5mRR4NuRBGoRh?=
 =?us-ascii?Q?bd/efxLiPiQDDwMUF8jsqcJdD4QWNVAfgdw52DlrvUfjHmKw+61tA/xpnNRB?=
 =?us-ascii?Q?51kEOcxWfQbE94qi+ZlnPtZ/1JzOrwfmyubfnUklpCfFTYP7jPjN9fLx7bXR?=
 =?us-ascii?Q?BFRMZ+P41LCdmNW+hC1Gpzf8hgEsBA1yyzBuUBL8T3hHpPCEyGioDneGhIsX?=
 =?us-ascii?Q?GnrCS9UiRPHCVxpNWErkUbAaJZszlyLQUFbyys1E1DMoYDDX6Qy/fXUlApFc?=
 =?us-ascii?Q?+gdhDb4JYG7mWNiZ5xn2Uj6WUkLMqHkXuNGB0l0BhpMS862MikUyWxYaf5zX?=
 =?us-ascii?Q?/ezy3SIxDnpJ2X0CoNb/gNO3/YD/kxVVWJQPN3QiZ9tyhCZjViva02EVCkQJ?=
 =?us-ascii?Q?vvP1RIx8b+3aNNGV7AXhuZ08PAgjD637TkScXphuBbVXD8FbIA45chuUgSUn?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2e39f3-ae93-43f7-7f3f-08dd6c9ba07c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:23:02.8327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jjtw9zF7Q04WaM+mvoZZfPxQLpyJxX1lDeBimp/RDVxU54BhLxmzYrGmvN+gXGabD040FX/xQ5g38EBXPa6o9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7813

Hello Vitaliy,

On Wed, Mar 26, 2025 at 11:34:57PM +0500, Vitaliy Shevtsov wrote:
> felix_cpu_port_for_conduit() can return a negative value in case of failure
> and then it will be used as a port index causing buffer underflow. This can
> happen if a bonding interface in 802.1Q mode has no ports. This is unlikely
> to happen because the underlying driver handles IFF_TEAM, IFF_MASTER,
> IFF_BONDING bits and ports populating correctly, it is still better to
> check this for correctness if somehow it fails.

If the bonding interface has no ports, it is not a DSA conduit.

See the logic in dsa_conduit_changeupper() which, starting from "dev"
which is known to be a DSA conduit, it looks at info->upper_dev which is
a LAG device, and calls dsa_conduit_lag_join() when it is linking with
it. Thus, the LAG device (info->upper_dev) has at least one port: dev.

Also see this comment and walk through the dsa_conduit_lag_leave() path:

		/* If the LAG DSA conduit has no ports left, migrate back all
		 * user ports to the first physical CPU port
		 */

Given the justification provided thus far, I don't see a reason to merge
this patch. The "somehow it fails" needs to be a bit more clear.

