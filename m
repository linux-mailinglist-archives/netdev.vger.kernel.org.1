Return-Path: <netdev+bounces-132466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAB3991CC5
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 08:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727E31C20EF8
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 06:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D96158D92;
	Sun,  6 Oct 2024 06:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="kekJDmTP"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDC754F95
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 06:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728197302; cv=fail; b=mUuBG6n0a5H9sUvHNqYMN/rRagZ15d2cpAtb0LiIJVDUe3hvsMdCXuGh7yY2Rt3SlLUFJFTBEGNna+YQPjMZj78KkY2J8oE0UDcdwL2HxgIKDluTD8aqFl9fpgfNJAEiovt5GNkIneupkjqhG1nouV75ogfnWdgX9D36etmxNAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728197302; c=relaxed/simple;
	bh=jOAuz6sWlgDWO8biUfJ+DEExq9uaucjBI14lXebpG3g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kLc5hBECKOd6hT6qMUc1O1UXwEWxN7rt24ZNtDDDjLdcH+9uf4zZB4q969ZaaOu2rBH8TftJ44mYeJtYkPPu5MA/bJdHjZ0qP2kl3p9oO81tczNepSF65NT6NHdHk7QOY0QUOCAknNOxZa6qx0kqlyzEEDo2aALIJ8criva2/vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=kekJDmTP; arc=fail smtp.client-ip=185.132.181.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 6C20D6C0060;
	Sun,  6 Oct 2024 06:48:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQVBUOqYEZ5YwZj73BDBXf91yABY1P1HlbwBPJMXZYmvEFAOb+etFYcME6O+pr7cSAcJaNXSk/aEAfZ4EHoHcamoc1JYn9ucCFDo1/QKca3CE2yZmWhDzgAfdZuofJeSpXFmw9BeURG3mq1g2trufPcEJ/95SRYY+6TFIQKG2rJ9Gq3X3VTsKvQbUSylESK4aSNokJD+5F0arXcozcS8mbkp3D1JWRqOPhilZdViT7+LGEGBuD3YpK3Ph+1aaubajW3ardWESPPAwxJs49ijTi5F8wSCm7I/ucF3AjF/uI3YpKQKcZOsP85GBe9DO2KggxB2R4ewiZrpK6Zix5BpWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6x2wcxXZz9fb3R5iUCM1VYN/luIbJoGs4yDD1LHjULQ=;
 b=P3ABAePNiJeiQCZBvZ111ew8+tPIn+hvrdjRNW1GyeyzBoy1Oo+Q5iegh8IZR0T6U0dKSYIoHBLBTw0GxlmyBIILmZ0aO0kFeN/msRAsi5kqzQKbFsuC6uJ6UYyu+RfUzmd3SytiQ6OByqr6vO4x1xdXhYIIGx/erby6VVohSMnCpueXgTBWfRaiDRIup0bZSbB00zGBK/Vy5YPAS0WehlURy+fcJihq2B4Ggf1ug4iiesiAq9LOHzXccTk4x8HZi0w6qsdKQxXF4D6xq76eyYAPxnIMkqDrh2iXiYsxbATI/rPZW/SMsmLTrdGWuHYLkcKKejuAOwZQRTw3ip1dSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6x2wcxXZz9fb3R5iUCM1VYN/luIbJoGs4yDD1LHjULQ=;
 b=kekJDmTPXUWB06jFhbyR981MmYOdpfAE3tG6QXEPLewELHnzur3F7IbmcEnAmdzzOLpdJ3G/xjQVZ1+wTI4Kk4GpqUWQHgZoH+YYNKHVDWuK+LSqeNfXaQf1qJm1QZ9gYR9lnsh4W0CzAOAthKLicnVwJBKBWz1mz05V0RQ/8Ew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AM8PR08MB6324.eurprd08.prod.outlook.com (2603:10a6:20b:315::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 06:48:08 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8026.020; Sun, 6 Oct 2024
 06:48:08 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v2 0/2] Improve neigh_flush_dev performance
Date: Sun,  6 Oct 2024 06:47:41 +0000
Message-ID: <20241006064747.201773-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0071.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::35) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AM8PR08MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be2723e-73b1-45b7-86cf-08dce5d2d677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+EAPVWco4zEb87CTvKyxtHk9lkj3y3CVsRDEmX0mHiTVAmQoKidlN2QBisSg?=
 =?us-ascii?Q?yyosjBHuk8P5EiCn7n7Uh4IW4YLniao+ssgUo2bm7B9vg41/FF27LBgYfkfo?=
 =?us-ascii?Q?WtqOhxTwvO8+RJ+lvdhbXsNO20t4KoXwa+liNGAOSeBQS8zW2yY1VBhOkmj/?=
 =?us-ascii?Q?hx/8QG7Qom9m85Jc2r1h6At28JvlZnEdaf9bcwBIfRehm09V8P+/+qDrQlAW?=
 =?us-ascii?Q?utiHoAzDkb3fgtTf/qH0jFkxD7VChAzXbT8n1noqshWOZbNuMR7TY/9Gfqvr?=
 =?us-ascii?Q?0mKGxIwWGBc0ryRDQaW8zwu2OGJMy/EGxi8+VdUYhv2RGEO/cRh2URpcxLhU?=
 =?us-ascii?Q?7Y9YwF6HH1VbW9lBJVAUIK92TKR//AL9G/R3JC4Ut4SgUfPkKM5t2gfSfCd5?=
 =?us-ascii?Q?YD0LWz61mOmF6HMIw/nOr4Tq47IMbKyRoNdmGYpfqxUuzrpf/qhd2jvcop9d?=
 =?us-ascii?Q?kS4zXJoX6MwJGy9V4fjQRx83Yrx4l8dzQPEA/sQQseJ+X1QVAo0sw0cdWYhA?=
 =?us-ascii?Q?uw/5lWXh4659+fLh7X1u4zFsLuV16C7LMgCVHVxY6LurNTF5lO6PyVRhTq/y?=
 =?us-ascii?Q?f1oe9xpbbDXs9nw/Xa+EsGUgkY8lCVbk1Me0wEggpJC04qn2dvMrsLtPjCxC?=
 =?us-ascii?Q?UbkWghyp2UvWEfsXGsbvHXJVnzmdl+wQQ6rLsm71W2C56Eb7yjJsd41lGUoL?=
 =?us-ascii?Q?giEHSoOda+vJ0fcGKWtGsJW/c3uDDkzbs0a3mA2fO1yEybGf6Hw0N/skLB5n?=
 =?us-ascii?Q?O+BPhVPeyAHlhF02hHustj+1ChaQWmW62nPiPPZ86XzNHcvk2galIYGVLOix?=
 =?us-ascii?Q?EnAye7zSD/j/xajLb5rV9dKiHSnqOGmYApCQVHmNrfiqzr7JlywRtK8OnCAE?=
 =?us-ascii?Q?KPh3HHQg2Zz4ZPDOdmi3+z6YwTWnV9CCk2apDvppN/SGv4YFKGRcAFpDxCze?=
 =?us-ascii?Q?YMMfbibXkRQyPuCaS+5iZezd3K/5u6wglVAfDiiNRRSGc2N4z83kcN3IyeEj?=
 =?us-ascii?Q?WuoLU2GSRO9NL9WSv41BijQLCa9Ci4KA/kqMrt0QO0S4hFq+rgh5n5aMcY36?=
 =?us-ascii?Q?5eBNh45UwLD44e67PMUsfumraY7590xOP6wl3gSuT6jBO9cIcL6rBaG1HfXz?=
 =?us-ascii?Q?1NRPsnMKdKfmLQiWfuij3DbaPlDA2b0fJYm/F0nHpkNovJSWPW9N9pQZ+F2m?=
 =?us-ascii?Q?eDDmCpV9P9gWbPsAj/KSgIJSbTKrLEAAPMK6kQeeQBL62cGYovwCcRtxO+q4?=
 =?us-ascii?Q?XncQnDaQfR7DMa032KIhlH5HKjuio10wg1xn00eouCGORQ2OvhbYj1G+CZsg?=
 =?us-ascii?Q?YCB/8cSNRH/7qWVr1YcUNbNsR5YPsxUUbqyfFQsnM+Gxwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QpUZUIp5Nw/Smej7XQgY+U93lnTODOv8hHe4H1Dw3sp14pOgZOjNSmx7++zP?=
 =?us-ascii?Q?fyefH06ePZi84iJybH8BF7C98xoBQDRKV1/z7FTXCO1TREfRfhciDs/9/I99?=
 =?us-ascii?Q?OiPbRCL+luQX0g5D7kWJsgQa9bVDEDm3z9KB/L3wp3mE4q5yHPeBmIr7D3oS?=
 =?us-ascii?Q?xDW/5p7oJ0uZseJeJiDyvveBGHcYeqAzmrH1DZlZvEStFlhaPq36xzwodxJK?=
 =?us-ascii?Q?5ET5E8naIKFGeMckHakgPAyYwAgA+8tzdLV1CVZDT2oabgd718IGzcVDDy5O?=
 =?us-ascii?Q?jws9n/HklONsuWYsoCPhh5IiGhJoLDZrtBgWUzD4iBSuaxZZUX8fE/+y2uYl?=
 =?us-ascii?Q?NpqBGeWZQuXHHULLZaRexuFAH8S8zO983e2wfw8nSIcQ/CJDEymJlfpsH3vT?=
 =?us-ascii?Q?9E/xHa1wUuRVi3OmLeakJ7kacsi6NXghuK24CaPXbmktkYnDd9L43RU5/QEg?=
 =?us-ascii?Q?3MVmSo8+C5oZI928FBnXU23+nF07ABxwskJ44WtShdmFe++BEe//TtheXSnf?=
 =?us-ascii?Q?idxp+F8KWtuPugDdlJaO7Xe+dH3Yw+82KrGPfQKoSoGOcC2vGpTI4FiZQUrv?=
 =?us-ascii?Q?k4U26Rg2cD2MIO7hF6wDtNo4gjEqXn4NFNMNgi0T8qUsseN/okCnzP+dIApW?=
 =?us-ascii?Q?BDdoM/lS/gqzx+DHNWqxk8+2eyLYt4lpIf5AHO5CXw6cxTOnSh5unmr/vGS2?=
 =?us-ascii?Q?pcI/iDTEHBE3QW9Defsd0n7LIPLV2aOKukywAMnuWHbw2Qp8ymEyMWkdEgIZ?=
 =?us-ascii?Q?V6xlu+mmnYgBn2z92gMu2jaqW5tPIX9W/wSaX3OGJPCeEPnjzUBqFSG5Khdn?=
 =?us-ascii?Q?VePWJ+hYw0mSreAiEh7Fv/UqXcD8up/T1LtYXwvJbiUaEEj77VnBzCFUrcmI?=
 =?us-ascii?Q?To7VpP/CE7MqCYW9QHAGYSQu1LCpgj+m2J0HQKf4lWJQ5FoMvHD4a79olsmf?=
 =?us-ascii?Q?uQzzTo8Vut5mgd10RtzzARNiqmG4Hfc7QkpveLGQJT155Vo7Zk7P2rg93SY1?=
 =?us-ascii?Q?8JUOwMDOfPyissig6/FDoArVg9kp2ZGLogjki5vifu/fXF1DvsCaelwYIFo9?=
 =?us-ascii?Q?Vrj7Em9P97a3kwxeN3fhKPNIE6CqKQtelipQ8X3FNDxAo8MmCZKXTECiy7o1?=
 =?us-ascii?Q?mGgAh+vyRgmo3sE7jlHj5OwFHmNKVEs4HTl1mME9cP+rNSXeR+quTxk44z4a?=
 =?us-ascii?Q?dY09x6P991CXUynkDAUEK5Q4EBrOWjEZLlzNMwMcJldATkQWUmaF1fzilbR4?=
 =?us-ascii?Q?/ihZmljIgS23I9ipubW3BOUdKDTjUgchouL4fMlT12XE4vwRrC8LXWaCq9c9?=
 =?us-ascii?Q?c/FvA/gmmJjPHBjSTOcdmjKk26QyPVaxh0/hCzZOQ2/191w7SGtgrRvzKRS7?=
 =?us-ascii?Q?lcb1wejfWooJYmY2SfHJDncCd9+7gSleCwN6fTzgoa5nrUXJcA1O6kgngzPu?=
 =?us-ascii?Q?D8OtF5uSa9M8/+RBkbqKISuJwcG+DBbIyGFphhJSDUGe2MVmvgqeIjbUhOyY?=
 =?us-ascii?Q?uFDUW0OCoQdCTGv6aRFQnl5PTBgUFNIS5BtdQ1zVKIRuzLap/X2d+DEfL/WM?=
 =?us-ascii?Q?L8xzzwY86SFokZtUFO+wRcleheM/dW8ChGR6dZ/G0rRc8v0/bz1zGRsuZkQG?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O8+AUQ/aFD8Txs1DuMyxpABe3IJMOdH+KEeEh70VDiG8ZHL2ZzhQ9xyXBtFA7ZwQHlq/zAkKYR1iw0LlgvQG5SZyfxsDPTN2KIV1/qolufr1GLI1ol6KYdHJ3yufZTyVr3ZHU4YBeBUWR0N7+2vCsKgqXvy3Rn3UZL2Aj9gns3YHMDn442i6qkWugpLNyaE4YvDJq4bG3K4AeCzD1/3te9yz0qnBTJWU3hqLVxK3/VbA7NvZv4b8fyGRWEoTfdeL+Pz08UTDGefzsBc1eXbypuG4MFnbLzBZjotq9z43VbUQLhT+z7LomqmoSlq4PtGjvc5QqMefW8Lq/6ktacEwLUHNVBgB4oFsWP3sR/FACY1fx9zIXp6Hk4TheiXrwImyjQ0JSg3S7jGuuR+IOdWfffydlmb6uslKAe2RzTJuv9/gSmpKCTidr7nqRGETIJPfvCWpFjK16NiKBFBCyZHj+NW7ydMotL3K+M34Yfx5xuszUPWCFm/Vqc2RmlsPt+38v6lJnJXvpFMOLl/jm25PpcbvWtX06tx01C8CcZlffhaDyKGoHTO2xBg8z607SS2eUNWQo1SUEAMi+5z0l6SVRCeqUbrZ5AtIEBaBPgDV69oXDf0FBwRV7dfBWhqIlImL
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be2723e-73b1-45b7-86cf-08dce5d2d677
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 06:48:08.5273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TD4+2FfRrRSCBqqRdzxEiJ99atIDtpEWFhuRzINM0MfSXUUT9wGhuMhy3B6Pi1htqy0NWi5rh+L078vKH0ih5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6324
X-MDID: 1728197292-Pv3aPS1m82lk
X-MDID-O:
 eu1;fra;1728197292;Pv3aPS1m82lk;<gnaaman@drivenets.com>;18cd01b0b368a0fec4275fdb61cf0c87
X-PPE-TRUSTED: V=1;DIR=OUT;

This patchsets improves the performance of neigh_flush_dev.

Currently, the only way to implement it requires traversing
all neighbours known to the kernel, across all network-namespaces.

This means that some flows are slowed down as a function of neighbour-scale,
even if the specific link they're handling has little to no neighbours.

In order to solve this, this patchset adds a netdev->neighbours list,
as well as making the original linked-list doubly-, so that it is
possible to unlink neighbours without traversing the hash-bucket to
obtain the previous neighbour.

The original use-case we encountered was mass-deletion of links (12K
VLANs) while there are 50K ARPs and 50K NDPs in the system; though the
slowdowns would also appear when the links are set down.

Changes in v2:

 - Fix RCU usage
 - Document new net_device->neighbours field

Gilad Naaman (2):
  Convert neighbour-table to use hlist
  Create netdev->neighbour association

 .../networking/net_cachelines/net_device.rst  |   1 +
 include/linux/netdevice.h                     |   6 +
 include/net/neighbour.h                       |  18 +-
 include/net/neighbour_tables.h                |  13 +
 net/core/neighbour.c                          | 224 +++++++++---------
 5 files changed, 144 insertions(+), 118 deletions(-)
 create mode 100644 include/net/neighbour_tables.h

-- 
2.46.0


