Return-Path: <netdev+bounces-188968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6C6AAFA65
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2537F7BAC39
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 12:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089E2219319;
	Thu,  8 May 2025 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NdmNRcmw"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A20146A72;
	Thu,  8 May 2025 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746708520; cv=fail; b=rrL1kg+3l7SR7LsgoUscz5+2eKi6j0AAwjrxtSdTPugnvJu4unnN5BDsBmHyll7AworgrIdcj+ePthDKG0FxWhtizFBtEIXpEiecFJiWuKA6Tpgpzc8n3N8Z9OHccapc1Hk4gWDhleVIAF4Diq7RJGy055D/yqu+whX46LmeMhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746708520; c=relaxed/simple;
	bh=nae/PHrKuZpCJApdQfL1oIxWv0Pxr8p2mj9fVoSMA7M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gVQsHiCMREWoXq9aWewcUayzZKtPHuCpDij5IL4xR8Iq6qWUaWGfcTvXMjVmrXzrmJnfu3h7OAuQqThCphBKnuw4TrgxJnVpjz3OWu8Szx5C4SviKVhLLjoKIuB0yfF/KElvELsYlS/7YpvcDjo2hTziu1ykiUvBhb6P/NGwDnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NdmNRcmw; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+NSNzXn4HYJgIpGgbn1zOLw5hSAiy/pLRrf3sTpBdzMOBj+wMDN/FB84q8Sog/u6WxPIT2gwIlpt/+aOuLWn0WkNVttyyknjEphqAK/qg6k/0wsrImcXb+bxJt2h3r43N7ydigmIieA8D9kg5VV5sROwbRnFlZj3Suk6AkWOw+NbNruUj+aMFx2SMpsU+SglKNVJurhNACfGnzp0Exd8Jbsc387KjjNJtjFC2Q1nTQYTICjjOpOtT2Pcr69Uehz8Upk3/00Zw8F4FdHLaeNAlSK8J17LDK/MRxWXgyJnIADDmRi9a7ouSD378xw4S7CzEHB6srCj8NqLozs9I675Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qu0Rmzz+ot3mRqv4Ac8Z8c/2CJslM2H60JEBkMmhBCw=;
 b=N3vMlKs/+5/JT+xUin/uO079mNewQP7cnvshFxYwq5paQyEJTVcpE8Y3598m2EwF2mTQXkBBPEBVJDmR9Af00HkvYEC3QQJv8JacXrnMA5fNrGqlswjUQfnMalkSeJc3pPb+S3O6/HKT0U0Uca3z/N3tQCcH9M3oghZO4oAx3r9TznIh6CaA47aOu4RKpG0AOLiWbWx4QJuRjZFXnvIMnub9jJ5L3FPagbzjRVvp0UreDbUfJ/O3zzdMhX1yT6zziBP6rrk46mqFF2WTrEsoQuPSpH4V0ApPMbeNpOewAHoJ6rqcCPtE9Aa8GhwCDuwtcCHSzm8Bce/X83wyCtVcoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qu0Rmzz+ot3mRqv4Ac8Z8c/2CJslM2H60JEBkMmhBCw=;
 b=NdmNRcmw3J2gND/1G2BIu6FCMxEdyFVJCHWfB0QrnF540Vmf95vRUQe+QtbaWMz/RvCnXOnJ0U9+0eUunrWWtureTegF92BJXkDGr15fJc5nb9lhO5Z/cir0PDYO0cL9HJZcl/HGiKXyJmUVwjIXoUs7ruzKUgaWTbAHoGiNBPet2aeYeGf97zgfctDG/JuS/gOPmraPh7eq2yTLMBnMXT0PqPZOFj6Sa8sto/AJvEajVPKA2Nz6i8lSgyR4aCXuUhq9bsr3ljjFD8YAa7fCwVUZ3KERk0BnG9RSQKYzN4PI2o3bEq7SpybkfQKfo0648q3hKgDBJy4TJQAHQ8zTYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10398.eurprd04.prod.outlook.com (2603:10a6:102:44d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 12:48:36 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 12:48:36 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] dpaa_eth conversion to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Thu,  8 May 2025 15:47:50 +0300
Message-ID: <20250508124753.1492742-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0157.eurprd07.prod.outlook.com
 (2603:10a6:802:16::44) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10398:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4196f4-637b-47c9-538e-08dd8e2ea606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sKZ1Ks79VGDtfa/4ckNC6Nk7ida8ap5HL+TUfYfdLEITQc6hBMW9Qd+M1LVB?=
 =?us-ascii?Q?WDMCH0NULkOFRgBs7E4Y4KJzNalgUvTqQ2T+rnsPzObUDFoEPEXjlVgq6doc?=
 =?us-ascii?Q?PuYEtyyRNyxgLbQu4Uv7TRJV87EfLsqhlu2Hja5OJKeliVyzQZ9sSjaDvNBE?=
 =?us-ascii?Q?I9vHa02FHGCn8jY9IC6s13D2IrtBnbOso8qOhFdbOFFrg5qr1UwqT3mO9os5?=
 =?us-ascii?Q?8h5KREOr2vYLuFRtYt1rdYpWBANCV/lQXhoYWMMgRQaChkHF9fi6WxWI4W10?=
 =?us-ascii?Q?Wd+AhGJXX/agurcpDfknd+TLrj9xJp+NkG1Ee7VP/5NIyh1QLih+rdr8qYPX?=
 =?us-ascii?Q?XYFaC0pYgvXY+NYZV1vMGGHVlV+VOATSTQYnydK59B6d990HLq/vorBhQBRY?=
 =?us-ascii?Q?gTv0YRMzfDzW61e7VvE1XF8rw/A+u2/ILgL1/ASZWOuneSElSY2er2jBh1i9?=
 =?us-ascii?Q?XHWYg1t9Nlu6ydCj6gyD6RMkqFbBRj5cNb6s0/Q6zs4XZ0f5AXIgHujnrp5z?=
 =?us-ascii?Q?lwZECTPy3M0hyCrCUQmOBKGgsM+YfY9ohGoENxwIc1BYbYe3WFeVs3oPobAF?=
 =?us-ascii?Q?7jvVhHQDlyaFIE+JvgeVbKZjLbjQpcB3+lYfQAgCWBZfaAhowr928AeolUyK?=
 =?us-ascii?Q?MSrOwZzPSLUeE9et6jkONVeha6+Xj2leOVGON7xmLmzi7oeCjyi2Jxkyo5q/?=
 =?us-ascii?Q?Wac/ds+7rdrie2OAu/MXrbKzcRZ4ZFerVbQoFz/uEC0qzPz7dLPC4Bz2z7tA?=
 =?us-ascii?Q?LUERdXObroJsQvyjTXR5JW04Ryid4aU702yazcgwguzfz3KffGKt+zuGkHVh?=
 =?us-ascii?Q?QRjEBV21ZtyUboKp7UO2x2prlQ3TS6VeApqwHe7PmagxIm28R4Hnd4o0csJ7?=
 =?us-ascii?Q?PaGyJqeTsSLpVEWNQY2reyyBjqDMx7euQWoZoYu5uEgIpfOkYXqMP1M+GmX3?=
 =?us-ascii?Q?5YmxqgpFjUi2/P4NDJK/s0jCeMyb2KdbqEYtCvkBTRp/mwnBd/RcO5w0IxNy?=
 =?us-ascii?Q?yzybsMxvCnve923pgI1ngosIOiBADUl0M8SOLgncuIJIIG1htWBzU3XB8RtY?=
 =?us-ascii?Q?LK8LFud/43iuHCevl5WgUUKFkXQKk20hbwRdZfupFylD3jnXE6uYc9SwzuEp?=
 =?us-ascii?Q?rMRICedqE10Y0Xe+KPhLtjwqCkVXBlRMsorKKdNiO+cRGknb+Lyt2LA81Pyz?=
 =?us-ascii?Q?SHCKjzzx2+JuxcLtLgdgBkTfgTFzIw6OuSsdA02k4kXDu38Qn4jx+OHfrLGa?=
 =?us-ascii?Q?5CWyU/BWIRfIqVrBQo3V6rV3UBvEbjk12XrM+SmqgkPV1IijMj9ovl0D2Zvs?=
 =?us-ascii?Q?LpPOpjK4kusLhFkiDFMo199pyZCYQntoZIBj3J7rirBxbJwcPRsFbg7AfVCE?=
 =?us-ascii?Q?5hcKzcKbgzizftXQ7tlZg2q3gY+s8yamF1EsdWmWTvClOb8N6RaZ+9Qxmg85?=
 =?us-ascii?Q?rTRgnrWKDWgmGC/TEoQnLtiE3oJ9F1N08JpnXebrfbuzB5zAxOHXpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AZemec2XqmvKQzSVgeHYiD4xM/0jyy0JKyqBSvKraBMMVSvjiFJCiXRzwzf1?=
 =?us-ascii?Q?ENqDC4Jhyqn/wIJrjJE5CAwKnje+gt/X9oE8NiTXhyOdDudR38sXAajdPNxZ?=
 =?us-ascii?Q?FF10MPGeXptLA+BXLUluq1TLqfADA6hNUsvY4W/pHomynMF6Ny2A/+blPLkc?=
 =?us-ascii?Q?zgfopf2kEsKkQUpg8fMhwv2ChMNS/D+ZmyP1MNyuGc75MRhpD/116N2mPNyz?=
 =?us-ascii?Q?MJdHz4xpPejFFdKmgbh1Sdt1BLBhnq54na+PTiDYtOMZSdVHKUTekHR7VD5g?=
 =?us-ascii?Q?lcYmiiKgw1IVJ3BCUKFCVKk2aLDqNo9+2TzSZz/fucJZj4s9jkZh0Wnqnl6Y?=
 =?us-ascii?Q?BeUFiCfLVYpFOh4Uht4OQhsaU0P6MYcIvuX/w9JHqWY2OUkCmjMmcj2SXcFe?=
 =?us-ascii?Q?jBnjHTfTUjNI7JNg6EqXwe5PZRqC8jogwvTiLybfgjgWV/kXnyFKAtZdJ28g?=
 =?us-ascii?Q?knFrmHR/jxRk5JGBkWkWr8nDtAFT0maNA9ruhnw9N/bc/bSQXTL6ecCYWHlM?=
 =?us-ascii?Q?WIVwXTRbEe5AjNJC0IWG0kVe4GLtOreyuXzBwr7w3NlFNqqZ7RZll86D3DxK?=
 =?us-ascii?Q?YQV+TrkwhJCgEO2w7Ctlkx+gNL392yCP1Y5cbaupfCP/0hLThO4D5YSksaUm?=
 =?us-ascii?Q?Gwg09WwPwFubryzIsi6t1eJE8MqIPpB1QQijeS2Mmi71vOb7RPZiQOkWQ6Ta?=
 =?us-ascii?Q?ypz8xPxgUA+kKjcT8e8ijMwgaWe3gHBinPin+wDDEiMgTeyRhJeI+dtxW6oJ?=
 =?us-ascii?Q?Fj5EI9zBL6PTv9cxYkuerW5S6LaaxwbbafDjD2z+BCEKYjj66eV2HTmreywE?=
 =?us-ascii?Q?/yzlBFY9GG9kBEkMBUFrWz6LuMvIvreeEzz7KgaMsFbMIyJZF/tlcotnHXUq?=
 =?us-ascii?Q?dG2Gj6zRh/7pyYDy4ZIKsWAPJxbiN0qaObc1YX0TcW6EQXbEqg2m0aSgNCcF?=
 =?us-ascii?Q?8/Zrffv+bzDDSVJDJB1++t2qgVjZQOan9810KZE+ieSCjFxhBCCr0HF++RuS?=
 =?us-ascii?Q?iif3yNgLYvWDqNkdKlvoZw8MT3WGFmz4XaMA5jdT37e2K0B2SKjOBXWgaMJd?=
 =?us-ascii?Q?qwSQN8st4xOrpwnTo4aWm1JeFMbbFPOTt3Av7cWeYiPAr5ntX2nXbkaah+dJ?=
 =?us-ascii?Q?VQN+kAUjjVc+bcaYKo3MIMcHzW5ULRkaZeI1r8pUwyEYvKLHtqn8FjL+rPyv?=
 =?us-ascii?Q?7jP0ZTcLZKvrae+QGDghXSVRMs6KdebUnMnMizJitstIJc5MnXefoc4xkaXj?=
 =?us-ascii?Q?DlrofXTDtwOvCDyApBRt2dZPm90pt9MWBmWP2WEK8C5GuB02vcDIP86LwiTx?=
 =?us-ascii?Q?+Yksl7ufaBWKW3PsEwy2QheN6sT5S1EC5StTsdyyayRsaIvtHYhNXRNixxEP?=
 =?us-ascii?Q?kyxWtVHjMCwSCvPNC7AOKwZ/oqCqSX52I7XrgBcDW7koWS9Gpgtq/ZHRHry+?=
 =?us-ascii?Q?EMDIqKTVlj2p4/7jrSMvF8s/tEF2j3IxMxcCbFk9Pq7+j0BtqblzKr2ZK3G0?=
 =?us-ascii?Q?ZtlIGmB2M5txOQI44+L135sEkZuLsUSFkFx80ne/1g+na46Fpb5Z6ZCNrxtz?=
 =?us-ascii?Q?g9cVK51DfY+EOuZawuRE1dRMAULyn4BvjkNokLY48+dF0cFIKa1arvLHW/bo?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4196f4-637b-47c9-538e-08dd8e2ea606
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 12:48:36.3877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zpTZvj7VyFAakbEC96xM6GiyDzCDaqT9EpZAHH1IUhUT9/+0OO5xb+d3YnIj9TjculoI8gmjpSVcD7TKc6lzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10398

This is part of the effort to finalize the conversion of drivers to the
dedicated hardware timestamping API.

In the case of the DPAA1 Ethernet driver, a bit more care is needed,
because dpaa_ioctl() looks a bit strange. It handles the "set" IOCTL but
not the "get", and even the phylink_mii_ioctl() portion could do with
some cleanup.

Vladimir Oltean (3):
  net: dpaa_eth: convert to ndo_hwtstamp_set()
  net: dpaa_eth: add ndo_hwtstamp_get() implementation
  net: dpaa_eth: simplify dpaa_ioctl()

 .../net/ethernet/freescale/dpaa/dpaa_eth.c    | 41 ++++++++++---------
 1 file changed, 21 insertions(+), 20 deletions(-)

-- 
2.43.0


