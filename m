Return-Path: <netdev+bounces-138087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348FD9ABE13
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 07:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83335B20B3C
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 05:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B36113D8B0;
	Wed, 23 Oct 2024 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="BPiAZ6bF"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CAC132117
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 05:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729661936; cv=fail; b=eUbuLZ3jTNBpy3QdRmDikJ5nUl37DcGgvL0fyySmNvhflg9DscyMSLhmet5H8TUdReObM4e8DgZUE0mca/QJmJd7QV+8rFNiBXIEVUvn/kwkaSp37w0l4zaxfffZLg0Tdc1ZtZjArPccwKOOgmvoEgDp+7F30F25p03a2ghFyto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729661936; c=relaxed/simple;
	bh=SroW4hvW2kqYfJmlMav7k0VJN/x7tJkL454ZHRfjljw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pC+1y5lfA2DIN45pICSI1cb1CmbX6uERX31betRswZjZ1qPDsYkVLiTHY0uIYtk8glGG3coCTOHCCAQFq00oQuFegtGC4scINQX7hMerjfodUCvcKkJ6Y+UMt6lYB8Z02l/dneMTFcd/KptGOtGnlNDvP+VfyjI67QP2RE0fXvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=BPiAZ6bF; arc=fail smtp.client-ip=185.132.181.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D63C5C005A;
	Wed, 23 Oct 2024 05:38:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awZaynZAZc81/pCBn8nP3QRxehevgjiQcytHpzrVsBYEPYqaYFmJHVBmMoRRqEjli3nXKALUI8x8kkJ8wj3k0vSvgCNjZE+ssfCfX1N3GYgl3bmovDySzD9IL+9QweUOfqW2AeWIclhmvU5Fu6aDBQbKKlLVtN0fFLINL5x6Z0DTXVuM6aHgl3ie6viuYBz/9B35tg74ky1V7DGpF+lTZx/EGTcTTWzC5iG6icPb1GM9Q3X5DkOTIo2zQQdoTXrtmKIuiv0GOcQap9eps9KWsgVJPXTYen4OhnATqhc33NidndST6jF3cApoJyg3YY+bVA7fizWVFldNrK1iMvLW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SroW4hvW2kqYfJmlMav7k0VJN/x7tJkL454ZHRfjljw=;
 b=wU33xfuz/Ynd3KttGxLQexkcBrjtxcLH57sdHKfMyTQnRgTiU8icdLjHBFQ5R6ZK9CeANWrI13D3MYtSkVkW8BPfFnd/UT66Puu4GktDCTjHvVtGSyGzNjUFzlULMEmdiKRP5KBJuTmCX1OffLdyVemTN03EEDC57U8RKgx3bnrQ740AGHOxKupOaHH3/B2lW7a9PU3VSPH5RwEAQZbzFoYDe9yjrkPeMRlZXAzX2W29WPi9Z+0mzSkgDbFEjE7wzYkZBdVkrtZUcyg5FDfDufBq7qk95vTd0HyF2amDkx0qJQ9DZ8pys1CtqgjZ01EosZKCH6WKlnrvkJRK/BjNcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SroW4hvW2kqYfJmlMav7k0VJN/x7tJkL454ZHRfjljw=;
 b=BPiAZ6bFzAgdamCOlkTMFkV58gzuvgaBGw3LFevl+z7mIlTT02dNEyJRTsaBE+uA2va7V+WGmjAbRJr7/6VTuYR8b2gR+LsKiDbn5v+EMI4aigyzOiloTpPy1uvz6d97BCpRaNduF5qZHPLd3yKX+WFbkqSL+iW0WvLmUB1qFqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AM8PR08MB5713.eurprd08.prod.outlook.com (2603:10a6:20b:1dc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 05:38:42 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 05:38:41 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: gnaaman@drivenets.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	kuniyu@amazon.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stfomichev@gmail.com
Subject: Re: [PATCH net-next v7 0/6] neighbour: Improve neigh_flush_dev performance
Date: Wed, 23 Oct 2024 05:38:33 +0000
Message-ID: <20241023053833.3565316-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241023050110.3509553-1-gnaaman@drivenets.com>
References: <20241023050110.3509553-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0058.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::22) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AM8PR08MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 98af4db0-b1c5-4022-8e3f-08dcf324f3e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cx9E0aH9ca56RR9hNSy/COy1I5oK9dEAOQL3uLBirVyxiU9dq9WA0Xjt35zU?=
 =?us-ascii?Q?nkvDkj5bjRxMYsliF3jxvDYgyoI3eVHSbMxBv3ue7FfjvjXMKzmOZp+FXmJG?=
 =?us-ascii?Q?HMfJW4m93wP9idCbs+ehXQ+k+Aucf7xu8PRJ4xGJA5AD4UNGLICNaj4/svr+?=
 =?us-ascii?Q?jJJn9IZYfef/mcHWEFpbyLLwT3CtAykfO3JAbXRu5raGNYJkaIgAnrRcAfSd?=
 =?us-ascii?Q?9PnabjGhP9GrR3Ox+Tna8K7JiawmjMaUfYz46YGp18V4NVB/rRqi/5mwq5Na?=
 =?us-ascii?Q?Z/7JrSKW5pq6Vp9g1odoBS7xENdd7PVlYcCaIymDroziHyLHdFbga2s0k6ta?=
 =?us-ascii?Q?fOWrEuHFmnoFos6mKSz3+q2JpKy7GEyZWj+g5drJ1/QMYMubt5pftQl2nPQJ?=
 =?us-ascii?Q?q0ILg0MRjEWuQDozGgtotfMXtssFBVINyeNEKjruHHAQ9kzedIRamwviY6Qn?=
 =?us-ascii?Q?ovFSt1w3Mlenft1RXEgdFORnisRJW+0PlJOi5HEZrk+nBGVuIuDfHD7mgTGX?=
 =?us-ascii?Q?1cb0p0f1hwrQ9kf1lyhCRws3JXcREty8PO/wy9xGy55Jw3DRWDj7rir9C7HK?=
 =?us-ascii?Q?K1AJf37k81y4sX0sBczUSKYq9Me8OCShmSPVkqJ9685XD4Kn/3l00n9d0UxB?=
 =?us-ascii?Q?KRmCWkDWyH9cSJT7mOuajjwMqDAOVwJfo4pcb22LOyc/GRD+xoS5dEzctMVP?=
 =?us-ascii?Q?3DUxWU4DRllTKmw97qjEmnCoOa/F7U5lBOmcrxEBo1rNxp/bZzPdduwti3Vs?=
 =?us-ascii?Q?fg4o2SxhWtGWvRN/a0M03S9K0RMvIMFuIrWKWSlLT03cD2O8y2aHtH7EvR5b?=
 =?us-ascii?Q?YHBVMgZoTUqe63QXVX5BtpvaPfA9aMvBi4T2UXP4rb+p/wXE/jv6vWLOjRQ1?=
 =?us-ascii?Q?MjSrSrgJktNxgwWFocDsxCNhK4mchQXv2a48IE6a8oY/6E97tF2CQt11qyuT?=
 =?us-ascii?Q?94+SJ9OYEQJU2kkKKRXAcPGABgma8sviJ2a6nBBqacfY+HYglA1/Kd/1NBDY?=
 =?us-ascii?Q?R0dVqWJx8kFLMrMc/z0sgRdQ3LJHQQEVXy5Ym/csgZYAP6MBYYEfwGLAL4ic?=
 =?us-ascii?Q?A6qMdtjpb+e9yR6WLlWzU1BDHBoAimq9uCs2SUJ0o7216qgIx/JKvfa8nEQu?=
 =?us-ascii?Q?j0G0RyUkZ5Sdvw3JWjIxloAMe4O/fZtEU/0KzS/Ht4ujKjNQ05LBuokuZuXz?=
 =?us-ascii?Q?FoRd2Qj4lnwrjnOQCa23KnAgSq3Y8C2VaYd/W4YTQNey9pXimtaDCBTTJ5ty?=
 =?us-ascii?Q?lNXJPrh7FJEs9zXTxG8ODgZ5zprziKJclxd25y1WK0Zk3eqv2zFAwIO3xf3t?=
 =?us-ascii?Q?znYT6OqYmtPkFOwgWn21TLDZ2y7qPihpmZacNq4EkZl7j4WH2CL+Dz1+lyMv?=
 =?us-ascii?Q?EqTNDsk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pt4CE4rN4m+HgnwNzdrrKy9JuGn4S/40d46+r3hSnZrWVWWnLSiQayaGxmYm?=
 =?us-ascii?Q?STQVpkrhGYDP/YsKLypq9pAveP7/VllqfdgKaaPjvJ2bg/DlzyPbx0e4bTCR?=
 =?us-ascii?Q?N5qHyb29kquvs8eW/HTZN30tdSmQTYpNq8SbIP049bovHDKewlvKlw/TJloy?=
 =?us-ascii?Q?vDa/G81DVDFUCaqKrLknjmqvb4ChQfCHLiLi8SMlnXpvlo7qC30Y32iJaMK3?=
 =?us-ascii?Q?mmgtfVNvCjExa2VhimdBGWNyPJLhax7OUJPa6a0KRpyS5NXdpJ4wpP5e91cS?=
 =?us-ascii?Q?5EdP8rFaGwHZGcrkNY7nkaTuCdj4Gp+HHsgfhIMLS5wCDtZZ96efLhvnnhAf?=
 =?us-ascii?Q?AZBSEIJTDUIJIN5i8HTEDX4LsaFmXzz24/c85ZTTGZnx42MTMC1nGXn0o7iJ?=
 =?us-ascii?Q?6uVNwf9EJG1+b3dg1b2LbIFPavdgaNm9qx2MarcTlsOeLeFMHvByYBSGWJbM?=
 =?us-ascii?Q?8PG3081Vykr/M9qDgfImMfep1zSunkVEehHZlyzoi3PCGpdRBbcBRtx9AdcU?=
 =?us-ascii?Q?5Hfu589ALrOUJKbJJQ+4Dj/cg/lgH1mEdrAN9NdwafFP6RSymvrHILez/qxX?=
 =?us-ascii?Q?A2QQpF7FSG9Zfwvki3SQI+qPgknUW5Th2XK1R0WDKlGKtNvJhnkjw37iLooc?=
 =?us-ascii?Q?f7egl7xf+0dyjvl+1XCCV2h+ux1uRmRc9Uo5KdK41x5Co1ujsCmKrbK/zudS?=
 =?us-ascii?Q?aDvW7ZBQOPjyw695GzZPnBh6lHQYlmH9Ez141d9yR6EprRjNQ3DKSJGEB9hV?=
 =?us-ascii?Q?O87dRBxvLLAKGs0jFnXdepQlfO4HgjpjKmml/Q/jL8nguDWdpyu1GaZ135iN?=
 =?us-ascii?Q?KfbG1S8GM2HZXS+/eZWXQQY1HGtWS1Bf7g7TflvbEpFrMnH6XQQA/Qs4ekv8?=
 =?us-ascii?Q?LQ+gh0EuMZWqc1fsKZhlPXNBX437e/X4D7VZC1dduezWd6YC++SyHB2wQFpP?=
 =?us-ascii?Q?C9M3sVKC5uoD5Wi44KVR9buVeO0CEM127el5EFc+3OpHXx/fjJo+h5R/h7N5?=
 =?us-ascii?Q?hVE2agvz8mbM5XW1paTwOkoqxbObTmh1rQAgKhmzkuuqEDPpUPzRYtcWs2SB?=
 =?us-ascii?Q?B6+7En83rxe3fiZ1gyvCG+qhRnbqp7xkA4shDWvda8PYog9iBAkcb3+e9pZH?=
 =?us-ascii?Q?HU38Cg4VH1Oc2gcSHpUVZpGTqm+DR9/4xK3ZwMBi8WH8zd/BhaxvNfbgN2Df?=
 =?us-ascii?Q?YO4OBEWKsfumipnkKYsU0c6tFw/vySLJOlzdr0tD4e5+9Zo6JsN/u1gemC1K?=
 =?us-ascii?Q?5b4+z97bFCk4hF1wMs/Z6XqFZNByk8xvM1LwPcxgSo/jxKS7EvlBScw3pKeC?=
 =?us-ascii?Q?cMDlSZ7AOmXfP8wakGe26CJSYUA+eMqK44YygdeGghm/oE8jdoASm71W+UPu?=
 =?us-ascii?Q?1qF6lmVDw89ZUQjINExHePhjkKHewhvNAVRueyI6Xckl701wPuW1l6Nqhbdq?=
 =?us-ascii?Q?ZBfpTpSjyq4wOA8iOhx1TnMXzWZgdmq8hhs/TUMGqd+fPSsoHO+urUsXrRZ9?=
 =?us-ascii?Q?QjnNqDkUqgRBkGcoJERbjRyEngG5Enq/vCMqub2jrTL0LaaiFuy3oz4IG2MC?=
 =?us-ascii?Q?a0AHiQeTUVksWBCVonaE5q7QbTTRX1IuKc09Z0YNPC/sk+Bw50ednKa42BS4?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vbrMCJgn9saYdVogaNPI5ED5wkCF8yT+9jUcy8HNJMtRdH/8h1PtU7GP/itsB1uq5BiyfEsaGEN5qZ8MUaXj7VFMxBGNoyyHW6gCu2TN1PZa3iJakneb6mQTIoPW1RNfiTo5z2XFdzZo+gpMIsxjS9kzpn8vz9bYMlOoQN6i4c9NRzC124KxXQnzbjq+QGEMLhaSQvgTMx4pDwuzVEF+VpJ6Of7BbZcV2PhxLUj9kfLTn987FOlh7OKSXzlQjtc2RrZEet6UabUXRSG+XpKcMVvA/P2wg8hKGjcpj4zo6ZaTRZmWiv0Hkmm7xFW8mGpSHghTk6iGpb4QpM+rfD6NeAm5CmeGUOM8FxSan/r7ZqZ5wi4xsGU0MsoknR6KruNWbqo48X5J+1j1u4pBlaVhOc1MXRGHskjYK70qz3Rcm8hOBr3pOzNSey506AyOOa2E+4B/PDoa26J2KA1NZypxt2IzOY4wdhB6sl5Q5V5wmklsX7/D3A/pq1F2/ONdVW6yUjCgVY731dZgXN8l1/BGS06FyTLDfZUkAGVyte0UPTtEcfy0LYJf7Zkn0bGyCHmj34Q32i2F1peI3MwBjSjAkwpy/8NrJ2az3XMEz8Wv4Vtn1TiLzcDj56OUkbFXVmZF
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98af4db0-b1c5-4022-8e3f-08dcf324f3e7
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 05:38:41.7968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ms9fehOyrBkIpEYcit8b/TYC8Z13WgJiBPuCNMVFphl3ZnqZAS4U+thM2nT43+0g/z+JGlhPTXI+gR3KgAfig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5713
X-MDID: 1729661925-E_AGmQiBAtPE
X-MDID-O:
 eu1;fra;1729661925;E_AGmQiBAtPE;<gnaaman@drivenets.com>;7d4d5839adf16a847fd5f829897ca436
X-PPE-TRUSTED: V=1;DIR=OUT;

> It seems the warning requires CONFIG_DEBUG_VM.

Ah, so that's what I missed. Thank you.

> But I guess the issue will disappear if you rebase the series on top of
> Eric's patch and avoid calling free_pages() directly ?

I hope that's going to be the case, although this warning looks a bit like
I introduced a double-free somewhere,
which I guess is also possible if Eric's changes go through the same changes in my patch.

