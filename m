Return-Path: <netdev+bounces-251019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EF0D3A29B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BAE7309BC01
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5820352F83;
	Mon, 19 Jan 2026 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XhGg6QwJ"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA3B352FBD;
	Mon, 19 Jan 2026 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768813965; cv=fail; b=DmrwTmlj5jOrYL+Uy4AUpCOSSC54CnKIoOs2yovwIo99B3UyvbavcmySRHe94mDdeQ0SALln9MMksudFSQN4SDKYcXNVI/wAIj/fwe1AHHEwBUzHEPec0lp51OM+1E6iTJBxJoitl2roEcQGUprOvAizZoaUr1Oy5i/vHQhDEw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768813965; c=relaxed/simple;
	bh=ijbo4SVhVFCXL7oV1ksGK50MoizdE+U4P4KXE8Smft0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i1lJtJYyA+ZPnjmLKbrqojb4eXXFWls7wh9L5T19zvij9lb8PGHZDmIziHh31cqGVdlhAXndeCxrIUw5s1wj/WkG0nwCGLC7NY6QKTED78RGU6ntExAd9xbzUHLogi33j+VAQ+rcif+8BuMrGboiL/aZIy6s0XHbo9boJtXA5z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XhGg6QwJ; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jR5VxS4qiX8bTI+EY7+4Y5EyCYS9ZfcM0cJR+KSzjLRVAHHwO7HzFP8GbnuqiPO3wHI6a1Nak86NyGHhcNM0Q8jddAnKk0rtEL6BihN3ZNi737PRHaxZq+4dz4r0eJADhhkrgkpRNcB/USSdDQN09iDtL3WWR/jINxQNoLeMnty4kvd64vGQuSaJcsNnKVTEtRxpBqgxpJlt1r6n4a4Hz66Zv3tv+dZcHKRdOKlBZG6b11Z8lqyXwQqpOYOCctlOzreNOrUdgNDb2TACL6cTU3js9aZE47LZTFUK+rctHKzXLPjw0PS4Tv92i+Ei07slsAijpWv20x+kGKYVZKo9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mHIoFwyqx2evrQHGMe8cjV/mFYMC22wi6njoPjoTvE=;
 b=Q5WDomWfKrfkNBE1AhX/3UXKlJ2nDmFu82P+ANkrINxKdR1OOr8FcAfeAoMbBWkO66RcXHBxkmZsl6oaZKXv/+u7eTNNL752Jyz7vfexKuFkKF5ixpNVLeIlI/s/pnJ9LodKciczPyW3Q/Y26Mw+FK39CX2Hve39/IjswS07VZP3d0HYRStVz/janqsS3BPt3LLiDajymWFQTA2CIOhJ6c0KLcfZBdnqyPlqG4b0FFs1KMWCdYNhwI6RL+2qv7t+Y1ejRWEhYpdpmur6zYnevE2BCFfo/IbiH8x0/3C2L8flPdU6WrXpX2u7bUkrlT1DVAnQelYwmH2b4WD0Ll5b5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mHIoFwyqx2evrQHGMe8cjV/mFYMC22wi6njoPjoTvE=;
 b=XhGg6QwJ+PS/U+L1jhpN3tzBQNSIe/tUrp/bHp2Cp5KnSYFcLLxXBSwjHChD2ffsebtFWb6D8NxWnVyRXX8dnVSjjH1zUchnaL8J3wND2xbnh1Oc6BF/KTd8CcpbJWgZxQU5lCb0mHIRL6jIJtVeVfXV5qB8dLWbkDHcxoIly8FdSdRtO1eaS7YI7M0ACcHCrTvZnVNk//HB7LtKmlp6WbI95vugGxAam7s+Amfpu/Lo2/k06QlzR0iV4O/KvbREj321fFdPD+nTq5VDuBbA80/CwAMAZ9jvf+/5Qjolf0B/GOa6VIT+bmC6Q7g/5vy2qiutcbjhWIb+vAfgKAq5FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI2PR04MB10762.eurprd04.prod.outlook.com (2603:10a6:800:26e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 09:12:36 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 09:12:36 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH v4 net-next 2/5] net: phy: air_en8811h: deprecate "airoha,pnswap-rx" and "airoha,pnswap-tx"
Date: Mon, 19 Jan 2026 11:12:17 +0200
Message-Id: <20260119091220.1493761-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119091220.1493761-1-vladimir.oltean@nxp.com>
References: <20260119091220.1493761-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0170.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::7) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI2PR04MB10762:EE_
X-MS-Office365-Filtering-Correlation-Id: e4416a6d-3409-4a03-2f28-08de573ae2cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3RjGazpDmsaN2iv6KqW60IxWYohHVRhUXga9dex9C4Go0vXg1Zs4CM5Q4hq8?=
 =?us-ascii?Q?P0TVpGqySVuBT1MVWP+KWrFucsNO4jJMnSJ6lgTUm0qpkaMn75Hb0h/dVv16?=
 =?us-ascii?Q?o9hbnte0VzjK65ZrB5dy0g02vuYH6Pbg4LGNrzB8UQJ4xxN/0dCxpBu26nuh?=
 =?us-ascii?Q?xajziYYdoUK62mNakX5KTSxviI761IlHBfrUp+3BL6rMJnFmk8X3cQPpQJ9f?=
 =?us-ascii?Q?amPx39RWey/Uz9p44n/pyMKKP35KEKSFZRREEq+Smy9yDqyG41aUVB0KI8hV?=
 =?us-ascii?Q?HrPq6Raz/wJlT3Knh6vYldVNV2za2CwGmLc79ed4h7Yy5zlZ3LnOiHrMdts7?=
 =?us-ascii?Q?SH+phxdUaHAocBL5d3GVECTninDkF27wFVqQMgUWXyvndHVjtslWvYVYglqA?=
 =?us-ascii?Q?GU/h1Y7/jVmcrUuE2S+43CrpfBr8+LPG1x+JrFV4xIXbtnAXzeQ4CfulePWf?=
 =?us-ascii?Q?Do0vZ2+0ImC6zHjbJ5NjAH4uvuPhA/f1ePuR//u9m8D5Fi2v4BZNe3GNFtPz?=
 =?us-ascii?Q?4Ma7+qeC1hWX++lrSADVPVvANoHkvn9NThISFAGRnhXpJa6tgPurkYFVpadC?=
 =?us-ascii?Q?TZm0mFJMh2lBN+aqyiu9pz7I1F7ErJ6+4K3FanWc1NSrYJRckkVDaVJkSxiE?=
 =?us-ascii?Q?fArG2hYgfrMVJ74v5SOTGAQ6gPr0OBXXY3cR4Rwar8ZPLvEOckhZ1Qo8pjVe?=
 =?us-ascii?Q?b2JV+mqC3wgkiwLipk8SE9M1UU+UdepWqk5Kjl3b09R5aLE+zlf692325nep?=
 =?us-ascii?Q?uPebMq8Zs5ZZnyvVRfzDhhvXLJTHTVsUPTHN4ZssD1bHQ058yCzpemxF0avb?=
 =?us-ascii?Q?GMFvrkO6aT3U3S9RuJQh0XOryDyxZ5VPFMd0cboGohaI1HYgAG79GP+TETZM?=
 =?us-ascii?Q?nHwDaYor05o53wo4Q9VkkEus/CBFTyjpuAg1p8Qwi9Beq/gzpEfBjLVXVvaA?=
 =?us-ascii?Q?fccMri6ImU6ylDRd1mtlf5YsQGyMZCZV3hsMTnWC8EBKzs75vEbJh+Q7lz13?=
 =?us-ascii?Q?gCxBmZXDYYUBdtk2b1fRl/jmxcsd/vbR2gBS2K68EZ1Y5ltbBaVRjqMJbAdn?=
 =?us-ascii?Q?5TfgN1uMAmL3zH08KZQzgFu0//kJYHILoZfewlgfue70lQZHvY81tmoObDd7?=
 =?us-ascii?Q?MeGD5iyu+6LwXb6YYoaBSS1x3z+K95avWrJTZ++iOLyUZRiP2VQsuFRO4c+V?=
 =?us-ascii?Q?lkGpyHykut+yCrLxt74MoalBops8NSpsmuFVNRrB04ZzoE83G2BnVcaUHWG4?=
 =?us-ascii?Q?wwKX7C7Nu30//IS/EIoWkoKJ1RsM6P9Iq6Ak6Y8z+2jlICIQLpt/+MiSzKYn?=
 =?us-ascii?Q?s3D7WCW2fpFg/rry/WAYsfYskJ+uGK9dShjUDBY80pT6ZBEGBnCuFXwuK1ha?=
 =?us-ascii?Q?Aw8VBOypEKwV3la5Wv2E+OnXu4S/A341Fi1Le3bBmnRSelb7BNfkM/iQAo4T?=
 =?us-ascii?Q?HABC4mWKq2Cp+iSAoXXC7jxhDPvx56kLeISojjCnovRqxNVDv1tp4oDOxpat?=
 =?us-ascii?Q?hC+7Voj2cdVntw3Gi+pjUEsCBiUnMciv+HuqIRCaQrscLjgruchu/8aSxyGM?=
 =?us-ascii?Q?EQO+lTnYWblEOyr6Uq+iBu8A+4T1oLY9+KdTdvR8fld0TD45d+flOTPYGUUb?=
 =?us-ascii?Q?rXV43T1b6aoza8pz/M4lpvQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ixFsFpRYYjKRLQod5P7nhhWVbZEdSOhN6fR6Q+WS4rMemfJOvQ+vn0w8nQ9o?=
 =?us-ascii?Q?Am3MhtH0c7EB3OTOK9chrpVowBr6VaMQfEjzpnriNvIfePo5R3ab8+akEG0I?=
 =?us-ascii?Q?9/33jxDaVLvG1CXI+/JCmkFvpE1laBGHrNCokYJUSBLacjtt9e6IaWJAav/j?=
 =?us-ascii?Q?ULC7tAEh2bDh0Iclgolg0R5ogsXLYDHXtNN/y6IYcHx9x3OBXbpwfMJtZY0d?=
 =?us-ascii?Q?lhb7CKxnhn0BYMNPWj4VTAB4zqx20h5OMpNRRDVrBgQJtnuyBvUSs6xVaGrf?=
 =?us-ascii?Q?GIqI0mtvqrDkFpa2ZqWd42OGhHth5IcpRkO1uedymNORHhFER9ZqB+LwR6Ao?=
 =?us-ascii?Q?oaTKa3ebh7Mslerc1ec3kyd97KrTfY8LbsFJUr+S9YDIdYQs1uxhsrE5x+Dt?=
 =?us-ascii?Q?04PF9YHXJhdHixQfgOch0JcGiwzefLB37dYVM5qaQUbQv59EZem5GgqLyrIP?=
 =?us-ascii?Q?x740WCC6TOM8fbH0lUAKoKDb6YVrUAhZ3kaLKkxCOb0W9VmwbCwGpAhoBw0d?=
 =?us-ascii?Q?+oUbCSS4Z48vMTl3iNdfmVh4E50MjEwYCfMOgnU9c5M4MigioTL6Gul5isxS?=
 =?us-ascii?Q?85EzP6NyxWJkUCe/43o4WUcMFmT/CQGgezdx/VnHOyNpV2sztaadd5N6aNU1?=
 =?us-ascii?Q?hC1giuTGWcDFqVGwny2hrZo2NfXFlpch2hDre6ONw8tL+TWnJX1rPlvhGfEy?=
 =?us-ascii?Q?7V21T+VRbu7Hj0J+PERU5H1OMtxfflCrqeEiJz1gaX6ff2pdg1fk8Di7wlIv?=
 =?us-ascii?Q?6B6gSwJoWKkFNakzho3kfdkwx6+tq1zWt4EdAIaEyMI+Kb73XGYrixPMiZD9?=
 =?us-ascii?Q?cW9K4W4ZrX1NW9ZuyEpB+jSJxKLUdl+qqpTvreVnuEnrGyRWgK0SnCboWImN?=
 =?us-ascii?Q?aF9kbuNjTuxQANxFNWn8jIlPAcKqMSq8sUoIGa0xO9XTksUvBZAyWdT9NvFj?=
 =?us-ascii?Q?uRm5GlVCok/A8C6kpsSL9B9aEzsBAI1SV1mbYRNe0tP4mVhiL3eItZewXoOW?=
 =?us-ascii?Q?YP8r2Vq+BGAWWDjDnEHyacD8/h0adImACzpDPZcmmb9gH2SP5L+N6OGaWh+/?=
 =?us-ascii?Q?MucbwmJ+A1OMRnoT2t0sV0Fuc+tpSf9nStleE6VAknhxm4C21nIrlX0+uK3W?=
 =?us-ascii?Q?NCJaBWmxnaa5WdJLj63/GUYR9JU5LGX73GvMG2Syw9A+ResgKa9c2rcKmN77?=
 =?us-ascii?Q?v2YlhsVO0Hz8LxYYYp9gTWfDsS1wbQBYnC0h3rxKz6KX6jJq0KMAmUmICDBG?=
 =?us-ascii?Q?uzHhTM2BD/y/2/gMPnbgs8rI4ESbqF6j0uA3C4Wjo0SUpbR4k2JfyG36fenj?=
 =?us-ascii?Q?hFbnKeVHqhUoogZWlKj1DixeBP5RjKn5bTbqywsiwoToCJ+t3Dwe80dD7+Fw?=
 =?us-ascii?Q?xWTOBq/HGPznlmsxD8oqkMz5SwFsvGyi63V9lkTdrigmA8Ut4Qcg0baNP3uC?=
 =?us-ascii?Q?8KtLlW9kgb7BzWyS4BznvlgQuWkasFTYkRErmCu5OAhwZ0M1TS7l7uxF3CvV?=
 =?us-ascii?Q?/vO2tQ5lHFzwJDGHW0wcPuVqNShVnywg5TR/5S/+upc1fzW+NRTOYB2+f2lv?=
 =?us-ascii?Q?LBxM7SsZUVa4ZiCf7k6+to8QhCMuhc4YNORTOquADl68auA7l38VrMExAPxs?=
 =?us-ascii?Q?RGgqwXi8jBUGeKKX/6RsboB1yb8wnuykMSfKn5tM3reyUNIhEhgr1rKAPORi?=
 =?us-ascii?Q?DiiHSQTXlqgbb9I/c03mhPX/mBopiSBSbfbGhIXlYkV/mC69arU32RhEag0K?=
 =?us-ascii?Q?8h7VIkzykA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4416a6d-3409-4a03-2f28-08de573ae2cc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:12:35.9675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJhw1tjJW0sFzBCrj0n1fU2KCqUiQqgVhnLQCe7eKDspmUHzzEOgAgHsH2qVMuMm9lEUA+QwifQ7osdjdDallw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10762

Prefer the new "rx-polarity" and "tx-polarity" properties, and use the
vendor specific ones as fallback if the standard description doesn't
exist.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v4: none
v1->v2:
- adapt to API change: error code and returned value have been split
- bug fix: supported mask of polarities should be BIT(PHY_POL_NORMAL) |
  BIT(PHY_POL_INVERT) rather than PHY_POL_NORMAL | PHY_POL_INVERT.

 drivers/net/phy/Kconfig       |  1 +
 drivers/net/phy/air_en8811h.c | 53 +++++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index a7ade7b95a2e..7b73332a13d9 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -98,6 +98,7 @@ config AS21XXX_PHY
 
 config AIR_EN8811H_PHY
 	tristate "Airoha EN8811H 2.5 Gigabit PHY"
+	select PHY_COMMON_PROPS
 	help
 	  Currently supports the Airoha EN8811H PHY.
 
diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index badd65f0ccee..e890bb2c0aa8 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/phy.h>
+#include <linux/phy/phy-common-props.h>
 #include <linux/firmware.h>
 #include <linux/property.h>
 #include <linux/wordpart.h>
@@ -966,11 +967,45 @@ static int en8811h_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int en8811h_config_serdes_polarity(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	unsigned int pol, default_pol;
+	u32 pbus_value = 0;
+	int ret;
+
+	default_pol = PHY_POL_NORMAL;
+	if (device_property_read_bool(dev, "airoha,pnswap-rx"))
+		default_pol = PHY_POL_INVERT;
+
+	ret = phy_get_rx_polarity(dev_fwnode(dev), phy_modes(phydev->interface),
+				  BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				  default_pol, &pol);
+	if (ret)
+		return ret;
+	if (pol == PHY_POL_INVERT)
+		pbus_value |= EN8811H_POLARITY_RX_REVERSE;
+
+	default_pol = PHY_POL_NORMAL;
+	if (device_property_read_bool(dev, "airoha,pnswap-tx"))
+		default_pol = PHY_POL_INVERT;
+
+	ret = phy_get_tx_polarity(dev_fwnode(dev), phy_modes(phydev->interface),
+				  BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				  default_pol, &pol);
+	if (ret)
+		return ret;
+	if (pol == PHY_POL_NORMAL)
+		pbus_value |= EN8811H_POLARITY_TX_NORMAL;
+
+	return air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
+				       EN8811H_POLARITY_RX_REVERSE |
+				       EN8811H_POLARITY_TX_NORMAL, pbus_value);
+}
+
 static int en8811h_config_init(struct phy_device *phydev)
 {
 	struct en8811h_priv *priv = phydev->priv;
-	struct device *dev = &phydev->mdio.dev;
-	u32 pbus_value;
 	int ret;
 
 	/* If restart happened in .probe(), no need to restart now */
@@ -1003,19 +1038,7 @@ static int en8811h_config_init(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	/* Serdes polarity */
-	pbus_value = 0;
-	if (device_property_read_bool(dev, "airoha,pnswap-rx"))
-		pbus_value |=  EN8811H_POLARITY_RX_REVERSE;
-	else
-		pbus_value &= ~EN8811H_POLARITY_RX_REVERSE;
-	if (device_property_read_bool(dev, "airoha,pnswap-tx"))
-		pbus_value &= ~EN8811H_POLARITY_TX_NORMAL;
-	else
-		pbus_value |=  EN8811H_POLARITY_TX_NORMAL;
-	ret = air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
-				      EN8811H_POLARITY_RX_REVERSE |
-				      EN8811H_POLARITY_TX_NORMAL, pbus_value);
+	ret = en8811h_config_serdes_polarity(phydev);
 	if (ret < 0)
 		return ret;
 
-- 
2.34.1


