Return-Path: <netdev+bounces-186968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 136A4AA4613
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 10:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40881BC6ED7
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 08:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AA321B182;
	Wed, 30 Apr 2025 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QjpSUGFy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE87A21770D
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003484; cv=fail; b=e4LCkrO8bS6pm4jl1SbqPTykWsPHcJ02OtXN9qoAJ/pqcM3A044P7sDcXJPumbXdXyfTnnZMLIUsNXxunsm/dnhWM6pvY4lF9W7/C1Ejdoh//JYN/LalwbFdrYxSajOtSUALMGMm4L1EpiIqgVw7Yzb8nmoRmeFBm9tE6DXQ03s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003484; c=relaxed/simple;
	bh=5qkDl7n6IFI9Ku1XHa7UUyC5gkn98TwlcC2fcIpBdhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E2Q2ijQ4PaIkLpUwPYEoR768e4hkZ/7cRbPzoYcrHNbtPS92O5ZS4KadI7IsFVgqmE8VFwfUOcQK0+GCYcklZx0K2gEDytdH9xazZFQUX4HbQS34oIJei3xf6lsuLhX8vuWC3TNjJJf0wsAzEP5eG8/TKvt3cvVfIT1ieEXlA6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QjpSUGFy; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wl79XXOF0l1Im4bpQErIo7vkNRb9cg/1Gh11x4ShMyxcGHSMZNC74HIzlqvwHdQMaSwoZMceESOg7oklFRvLcDC16wxyiX21Dy5a+UCK8NXm6AkvbW45AQEpDANkdag+tXZQmOdiTPrKEjpXEtHkVPTarOgFarqA4HYeNaWJK2VzIqtcoM1vCNRG9lSHQm1d3wed9mxHBOXCXt6oS49ljrzewseQ2xCF57q8c5eKEpj9YGeKwsXy6magyMmK5dCa4eNis0WqsYUpnhVRh9g2xc7PiJmv9uIMBvUyW4/L+v5olX89etHRIpKF6tzjYOLbe1bdJYzUshu/myNI6rEXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXNQ1T42eAsmb0CP1CX+0UpNpsc7NXUohA5zgU+Iy0c=;
 b=HQZXqKfhV7mz22gH65qjuw7NLOnufaJQkDr/oENfmC5Gt1vY0+yqWEG/W21i94faSwKx7u4slo9LcLIFy/FYQ5tlxUKBojoyReI46Ao6ka/eCm7iRLEYKEgvZN36rrAc4LHbsdgaZijLMCh/0Ry/EM1Wjdk0Dr6t1/fEKhfOhdwSH6Gzp2fxrdhFWUnudUir973FoXlJ8Yw8Bql41mUyPx/i0gFQzsaPf87fMhgNUan35/VZwUL0X2P9zIHGrUWBoGjI2nlBfwiorW8ZmXydLKUQxPYo8p7iZBc6ZFotp29FgLQneRBjRCx45kSA5CC9BepWO4CeDkdrTG/FXBMGJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXNQ1T42eAsmb0CP1CX+0UpNpsc7NXUohA5zgU+Iy0c=;
 b=QjpSUGFys5h5cAP9cTrDPL3OqkPDsIiTMECKxnZ8Jp0cFRQcVN7dwxldftAqQc1wFVlUiAt/j3WuE6wddr72utNjKPSs+VH9pseApnWekvQJE0sZ7Rce+7mYKm2yaOAl6qF5m6X//DUVng5HoSCFCPc8L5U9B148yoQF/11RheDf6XMtjr+YKK0MbbgEIYbX+HEpN27861zetMkNdJavkhL/i/YJT/RwNLGxHCTk1osfH009ouTpHUT3gsb2ZIlu61v3v32prFB+bhMtS4qJTTYD/wl9gayaXQlRiMge4ETGZNKsIZsnsfZc+6WNmXsKkNUYL3klJU6j0uCPGK3Ndw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Wed, 30 Apr
 2025 08:57:57 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 08:57:57 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ast@kernel.org,
	jacob.e.keller@intel.com
Subject: [PATCH v28 01/20] net: Introduce direct data placement tcp offload
Date: Wed, 30 Apr 2025 08:57:22 +0000
Message-Id: <20250430085741.5108-2-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430085741.5108-1-aaptel@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::17) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a3fa14-dae3-44e9-bae2-08dd87c519b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P0mxewrAAd+6XPND1voVULELt2lP68146ZTvqtENY7Y4AEs3aip1OAjvcmV9?=
 =?us-ascii?Q?1265ktpOLr3rWFitLcBYwjAN9OQRamQe9F4kukLqRmv+1cMfsMS3SgufsWkX?=
 =?us-ascii?Q?znNfddFIZjjDx2W2uU7NPyidYdRrtQwIbp8v7E+lafTuag7LHP52wAhOruz/?=
 =?us-ascii?Q?nxke6DZ4wMgmmKTfnrPkWYtT+VulBCPxMO1WbT1rH6Hb3acvhfyyCYjxDM9q?=
 =?us-ascii?Q?rXnE7qrFgnrKA+GULkUJJzHq35VwdvdGRECGmrBlkWIQCJuvxnpJVf5Yp9Kl?=
 =?us-ascii?Q?4vsTJ3/Hvoz063Hay63O3rmQrA/IvJZaJYJKhZCqz4TJUrXhrWJepAgITN/8?=
 =?us-ascii?Q?iJTT2uOG1XwAHGNAV5JsRJOB6CzdqBknwZkdfi5gTLVN+A5UOR1GgMmgddYq?=
 =?us-ascii?Q?UwLGXBf7lQyc8VTckvl9pGRunSGJhZ6UWE80ak/9Bx7jGkdOC2f6iFPqe6qZ?=
 =?us-ascii?Q?2UEos3fUa8XwdJmePVOytCgxZWCgt3fGhKhw8WqQPPDlZmViY/mL1eD6NuQQ?=
 =?us-ascii?Q?5F4kv4FI5gXfzIxeYM1XX1W+xd1P6oy2G6GmFt9l7vV+qZGVk6MNLOryQ1eU?=
 =?us-ascii?Q?TzkXMZiKL9G+AL8ueZtCr7vhU3W37ob2goJDWoWm+alLTphavAYkSxBBJxjY?=
 =?us-ascii?Q?i4PBWePk745vCOe9lu3tWvAODKHV8g0A2ILPl52KAhqxkY7x0t9o02gu4L7N?=
 =?us-ascii?Q?HWQfOTE/e6x02Y73PnEXFhu/Xy9ZnS+Ns7//QyPhasVi8eLSXh4jG2lfSz/G?=
 =?us-ascii?Q?niYnTr3m7xyku3keKy3d6sTy2MZtO8BBuJt4xMH0p+y/hG8aFlyF4NZuMu73?=
 =?us-ascii?Q?ERUrW1zfLIE84UjWxZ8JQfZXw+S1EYDapei8kKFsgp4qXk+pHdFfsu2IQTL/?=
 =?us-ascii?Q?nR92n02kXOQGGEGPzJfZRk3iLS9/+hg5aHi7uTyq1EADamI5ZBbHYen1HJEy?=
 =?us-ascii?Q?E0HGCXvArmNDhaade5LnUNDlXnp3iyBfQo6Va2tXEOu0HgMGx734j4IFLyLl?=
 =?us-ascii?Q?Ef378+Fjebyd42fWwtfCd5yyBNru3LWWahR7hOyFu/fD2dbJUfETnrfvV1Bm?=
 =?us-ascii?Q?YJ1HqWem7+B2jMRLpyJ1vwo78zjxC7+RXi/+Ot038X1d0/v+pnv5okWzcgyZ?=
 =?us-ascii?Q?lOO1dN33mbCqC+AFISpHN4N6wdQZ90bhAc1TPOOHGPSs+fiOxPs+SirdX6ID?=
 =?us-ascii?Q?BDcNJcNVlAzy+z5cBEY/u1ioBBZ+xI1M/Ysr6cQwfYVFJ6ixom2keASavNJI?=
 =?us-ascii?Q?6xM1fvSTy/9KnGA7s30pnKPdRS0s7NqQXpzPWI5aeZvsXBgxT9WazHSbG/hL?=
 =?us-ascii?Q?01FrCZYUPBJv37/JyzmitraRchyZEH//w+3B4sMRL7Ykp1Fozef8DGy/eADu?=
 =?us-ascii?Q?CVU7StYD0nqOFrerUIqwH1KP9J9+CqJtk2WWd6ZUTa16dCCDIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4BaZKdg7MvakQEYsf1/tMiMFJwFlYTUZEDpu0HorgfAdoYd/AI6ZwLhWCatx?=
 =?us-ascii?Q?7EDPEvg7sgZ5acnXVXYTn434yeaWKiA8T3f9mPcY9s6Qhawt2xxmK9elqVDo?=
 =?us-ascii?Q?4pVGwmPn9ookZANz2aCCBKZOA/oK2FQxrqXuneBjwoMGQkwt7hrv1mR6WKJw?=
 =?us-ascii?Q?1jOmE/gNx04+0roNM8n0tSBpYUuqkQx/yDonnje2ZZCtOn/Hib6N/aYLL1ee?=
 =?us-ascii?Q?hcNGfGicaymYL3FZHzpNJBFmCQbFEJH9qDq2CAImwgAhJMqgsLnHMVuZM5uC?=
 =?us-ascii?Q?KQJqxwlERsvX3uzNN4RlOE69Fm+/WBYEqURqjJ82ITOfgJvNog2kMXgescaf?=
 =?us-ascii?Q?MtKeVWKJcWsUn25A5Y4Jacfjdr35XbpssCW5jPpwWVTL389K+zeQnlFkPpub?=
 =?us-ascii?Q?ELiLcWFFyh2gc5giUtbWz7q/ilXzcH6/5DB1MzyhoRAU4yjurFZOT58CFu6B?=
 =?us-ascii?Q?B7vfxMSS9RZo3ToLHf8aRa377657z/LOcyHWkrIRJJ1oRDhtliRpmRVcNglx?=
 =?us-ascii?Q?tSIhFE2Sg2OCvhXWBjNxhCaeCoYoVQSUkyorP03SJkkDuGSHWRbPYWnIx+PH?=
 =?us-ascii?Q?VJoBjGPy5qTolcszJydrw5Sy0BXLyFGuQjIYgKXmKwIiieKnBpCMHa9Ilg4v?=
 =?us-ascii?Q?JcM/Ymg1rEam6J3MgBwV+ltngmcUjv768Xd8YEwLpZRXKGrcuSYjXUmoiNP0?=
 =?us-ascii?Q?qfpc7+LnxquA2n6Ta+DrGFvW9Nh1E2FsrdSD0Y2D8j9drkaTqoyZjHoSmsra?=
 =?us-ascii?Q?sPl9MpHIXlaOVoVgAGkB6g0Z4/bFTiWi3igf+xMt6OTLKRWu54x1lRHB6uzT?=
 =?us-ascii?Q?OXaGLQZS2ZjKz1H0u+goxB0Xu5XWmMyiwEmFmsmKdNIsyMFLFi92o0Ep0zBy?=
 =?us-ascii?Q?PHrM09ND1+2pXfFRAom7tGm/PlzNtjdF9p96ICgBI/cKzAGx5vpN+0b2jxQP?=
 =?us-ascii?Q?W/0RjTQSKo/veWpgADvpjVFGvefpT/qGbuz76KcZHwOzzcKPUIjyg1OQe470?=
 =?us-ascii?Q?8BCS0KwW9NGfwUL7V1jP/to+ihP+VFMO2xREDKnC0AX7niURn4Jv8Ru9NlSt?=
 =?us-ascii?Q?/JGkYnpGMnm0KE0yFpaoPoMoVzEVqwmxKqcWD1dOjLzsE60vbkQFsOW33hxg?=
 =?us-ascii?Q?rH/rzHdlF9gS244diMizLlVZ5Z+5lA/gKSekcNnUzsc/DWGI8xmCbkV6ZihP?=
 =?us-ascii?Q?L5zNsNtnnvFW0RZkzAyV3HxsaKTwJtIUq8AGd8VEedb1mKgyhWa+dEIJcV0x?=
 =?us-ascii?Q?7F9RQhCMom7zQVD57F/V7m8/JSIqTN6J8Bjynb1JcXw4/6xEs50A/uyZNxWS?=
 =?us-ascii?Q?vThh4MNGNqESS5pUxFwl3GfLXtTm7ChV6Gjh+i8yAwwhs3In8Z5T1Vk5mgLG?=
 =?us-ascii?Q?ppWM9QZDo/EqAGeP1uOOwIy7E0mbIzMIKWqUpJQr6BgTWGnLQBwA5m7ZlIzt?=
 =?us-ascii?Q?8rn38+ddQW1Xv7e9THYdkyg+wr2P+z4cWN51kmReKMzrGMoK/a8QORdTO69p?=
 =?us-ascii?Q?vTzn4wQdqFNwarnXsXODaZEAmSywfwiQlrcXMB1N0nJzGE9UFd0KAkWb4O/b?=
 =?us-ascii?Q?3iO02w6HgoRau+nrnUco0DULFhT0HFawpqM09Sqq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a3fa14-dae3-44e9-bae2-08dd87c519b6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:57:56.9556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDwcA7NnH4+rQ0sMMaS+5fEunL5uorVo992902tdPtNMsDi7yvUaZSR/35SHozyMwCZ8gMyj0LKulnK4O2u1Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329

From: Boris Pismenny <borisp@nvidia.com>

This commit introduces direct data placement (DDP) offload for TCP.

The motivation is saving compute resources/cycles that are spent
to copy data from SKBs to the block layer buffers and CRC
calculation/verification for received PDUs (Protocol Data Units).

The DDP capability is accompanied by new net_device operations that
configure hardware contexts.

There is a context per socket, and a context per DDP operation.
Additionally, a resynchronization routine is used to assist
hardware handle TCP OOO, and continue the offload. Furthermore,
we let the offloading driver advertise what is the max hw
sectors/segments.

The interface includes the following net-device ddp operations:

 1. sk_add - add offload for the queue represented by socket+config pair
 2. sk_del - remove the offload for the socket/queue
 3. ddp_setup - request copy offload for buffers associated with an IO
 4. ddp_teardown - release offload resources for that IO
 5. limits - query NIC driver for quirks and limitations (e.g.
             max number of scatter gather entries per IO)
 6. set_caps - request ULP DDP capabilities enablement
 7. get_caps - request current ULP DDP capabilities
 8. get_stats - query NIC driver for ULP DDP stats

Using this interface, the NIC hardware will scatter TCP payload
directly to the BIO pages according to the command_id.

To maintain the correctness of the network stack, the driver is
expected to construct SKBs that point to the BIO pages.

The SKB passed to the network stack from the driver represents
data as it is on the wire, while it is pointing directly to data
in destination buffers.

As a result, data from page frags should not be copied out to
the linear part. To avoid needless copies, such as when using
skb_condense, we mark the skb->no_condense bit.
In addition, the skb->ulp_crc will be used by the upper layers to
determine if CRC re-calculation is required. The two separated skb
indications are needed to avoid false positives GRO flushing events.

Follow-up patches will use this interface for DDP in NVMe-TCP.

Capability bits stored in net_device allow drivers to report which
ULP DDP capabilities a device supports. Control over these
capabilities will be exposed to userspace in later patches.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 include/linux/netdevice.h          |   5 +
 include/linux/skbuff.h             |  50 +++++
 include/net/inet_connection_sock.h |   6 +
 include/net/tcp.h                  |   3 +-
 include/net/ulp_ddp.h              | 326 +++++++++++++++++++++++++++++
 net/Kconfig                        |  20 ++
 net/core/Makefile                  |   1 +
 net/core/skbuff.c                  |   4 +-
 net/core/ulp_ddp.c                 |  54 +++++
 net/ipv4/tcp_input.c               |   2 +
 net/ipv4/tcp_offload.c             |   1 +
 11 files changed, 470 insertions(+), 2 deletions(-)
 create mode 100644 include/net/ulp_ddp.h
 create mode 100644 net/core/ulp_ddp.c

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0321fd952f70..21fb312816bd 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1397,6 +1397,8 @@ struct netdev_net_notifier {
  *			   struct kernel_hwtstamp_config *kernel_config,
  *			   struct netlink_ext_ack *extack);
  *	Change the hardware timestamping parameters for NIC device.
+ * struct ulp_ddp_dev_ops *ulp_ddp_ops;
+ *	ULP DDP operations (see include/net/ulp_ddp.h)
  */
 struct net_device_ops {
 	int			(*ndo_init)(struct net_device *dev);
@@ -1652,6 +1654,9 @@ struct net_device_ops {
 	 */
 	const struct net_shaper_ops *net_shaper_ops;
 #endif
+#if IS_ENABLED(CONFIG_ULP_DDP)
+	const struct ulp_ddp_dev_ops *ulp_ddp_ops;
+#endif
 };
 
 /**
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index beb084ee4f4d..38b800f2593d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -851,6 +851,8 @@ enum skb_tstamp_type {
  *	@slow_gro: state present at GRO time, slower prepare step required
  *	@tstamp_type: When set, skb->tstamp has the
  *		delivery_time clock base of skb->tstamp.
+ *	@no_condense: When set, don't condense fragments (DDP offloaded)
+ *	@ulp_crc: CRC offloaded
  *	@napi_id: id of the NAPI struct this skb came from
  *	@sender_cpu: (aka @napi_id) source CPU in XPS
  *	@alloc_cpu: CPU which did the skb allocation.
@@ -1028,6 +1030,10 @@ struct sk_buff {
 	__u8			csum_not_inet:1;
 #endif
 	__u8			unreadable:1;
+#ifdef CONFIG_ULP_DDP
+	__u8                    no_condense:1;
+	__u8			ulp_crc:1;
+#endif
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
@@ -5259,5 +5265,49 @@ static inline void skb_mark_for_recycle(struct sk_buff *skb)
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 			     ssize_t maxsize, gfp_t gfp);
 
+static inline bool skb_is_no_condense(const struct sk_buff *skb)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb->no_condense;
+#else
+	return 0;
+#endif
+}
+
+static inline bool skb_is_ulp_crc(const struct sk_buff *skb)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb->ulp_crc;
+#else
+	return 0;
+#endif
+}
+
+static inline bool skb_cmp_ulp_crc(const struct sk_buff *skb1,
+				   const struct sk_buff *skb2)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb1->ulp_crc != skb2->ulp_crc;
+#else
+	return 0;
+#endif
+}
+
+static inline void skb_copy_no_condense(struct sk_buff *to,
+					const struct sk_buff *from)
+{
+#ifdef CONFIG_ULP_DDP
+	to->no_condense = from->no_condense;
+#endif
+}
+
+static inline void skb_copy_ulp_crc(struct sk_buff *to,
+				    const struct sk_buff *from)
+{
+#ifdef CONFIG_ULP_DDP
+	to->ulp_crc = from->ulp_crc;
+#endif
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* _LINUX_SKBUFF_H */
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 1735db332aab..65cca0d4d6c2 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -63,6 +63,8 @@ struct inet_connection_sock_af_ops {
  * @icsk_af_ops		   Operations which are AF_INET{4,6} specific
  * @icsk_ulp_ops	   Pluggable ULP control hook
  * @icsk_ulp_data	   ULP private data
+ * @icsk_ulp_ddp_ops	   Pluggable ULP direct data placement control hook
+ * @icsk_ulp_ddp_data	   ULP direct data placement private data
  * @icsk_ca_state:	   Congestion control state
  * @icsk_retransmits:	   Number of unrecovered [RTO] timeouts
  * @icsk_pending:	   Scheduled timer event
@@ -92,6 +94,10 @@ struct inet_connection_sock {
 	const struct inet_connection_sock_af_ops *icsk_af_ops;
 	const struct tcp_ulp_ops  *icsk_ulp_ops;
 	void __rcu		  *icsk_ulp_data;
+#ifdef CONFIG_ULP_DDP
+	const struct ulp_ddp_ulp_ops  *icsk_ulp_ddp_ops;
+	void __rcu		  *icsk_ulp_ddp_data;
+#endif
 	unsigned int		  (*icsk_sync_mss)(struct sock *sk, u32 pmtu);
 	__u8			  icsk_ca_state:5,
 				  icsk_ca_initialized:1,
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5078ad868fee..d0b0e73ad14b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1148,7 +1148,8 @@ static inline bool tcp_skb_can_collapse_rx(const struct sk_buff *to,
 					   const struct sk_buff *from)
 {
 	return likely(mptcp_skb_can_collapse(to, from) &&
-		      !skb_cmp_decrypted(to, from));
+		      !skb_cmp_decrypted(to, from) &&
+		      !skb_cmp_ulp_crc(to, from));
 }
 
 /* Events passed to congestion control interface */
diff --git a/include/net/ulp_ddp.h b/include/net/ulp_ddp.h
new file mode 100644
index 000000000000..7b32bb9e2a08
--- /dev/null
+++ b/include/net/ulp_ddp.h
@@ -0,0 +1,326 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ulp_ddp.h
+ *   Author:	Boris Pismenny <borisp@nvidia.com>
+ *   Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+#ifndef _ULP_DDP_H
+#define _ULP_DDP_H
+
+#include <linux/netdevice.h>
+#include <net/inet_connection_sock.h>
+#include <net/sock.h>
+
+enum ulp_ddp_type {
+	ULP_DDP_NVME = 1,
+};
+
+/**
+ * struct nvme_tcp_ddp_limits - nvme tcp driver limitations
+ *
+ * @full_ccid_range:	true if the driver supports the full CID range
+ */
+struct nvme_tcp_ddp_limits {
+	bool			full_ccid_range;
+};
+
+/**
+ * struct ulp_ddp_limits - Generic ulp ddp limits: tcp ddp
+ * protocol limits.
+ * Add new instances of ulp_ddp_limits in the union below (nvme-tcp, etc.).
+ *
+ * @type:		type of this limits struct
+ * @max_ddp_sgl_len:	maximum sgl size supported (zero means no limit)
+ * @io_threshold:	minimum payload size required to offload
+ * @tls:		support for ULP over TLS
+ * @nvmeotcp:		NVMe-TCP specific limits
+ */
+struct ulp_ddp_limits {
+	enum ulp_ddp_type	type;
+	int			max_ddp_sgl_len;
+	int			io_threshold;
+	bool			tls:1;
+	union {
+		struct nvme_tcp_ddp_limits nvmeotcp;
+	};
+};
+
+/**
+ * struct nvme_tcp_ddp_config - nvme tcp ddp configuration for an IO queue
+ *
+ * @pfv:	pdu version (e.g., NVME_TCP_PFV_1_0)
+ * @cpda:	controller pdu data alignment (dwords, 0's based)
+ * @dgst:	digest types enabled (header or data, see
+ *		enum nvme_tcp_digest_option).
+ *		The netdev will offload crc if it is supported.
+ * @queue_size: number of nvme-tcp IO queue elements
+ */
+struct nvme_tcp_ddp_config {
+	u16			pfv;
+	u8			cpda;
+	u8			dgst;
+	int			queue_size;
+};
+
+/**
+ * struct ulp_ddp_config - Generic ulp ddp configuration
+ * Add new instances of ulp_ddp_config in the union below (nvme-tcp, etc.).
+ *
+ * @type:	type of this config struct
+ * @nvmeotcp:	NVMe-TCP specific config
+ * @affinity_hint:	cpu core running the IO thread for this socket
+ */
+struct ulp_ddp_config {
+	enum ulp_ddp_type    type;
+	int		     affinity_hint;
+	union {
+		struct nvme_tcp_ddp_config nvmeotcp;
+	};
+};
+
+/**
+ * struct ulp_ddp_io - ulp ddp configuration for an IO request.
+ *
+ * @command_id: identifier on the wire associated with these buffers
+ * @nents:	number of entries in the sg_table
+ * @sg_table:	describing the buffers for this IO request
+ * @first_sgl:	first SGL in sg_table
+ */
+struct ulp_ddp_io {
+	u32			command_id;
+	int			nents;
+	struct sg_table		sg_table;
+	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
+};
+
+/**
+ * struct ulp_ddp_stats - ULP DDP offload statistics
+ * @rx_nvmeotcp_sk_add: number of sockets successfully prepared for offloading.
+ * @rx_nvmeotcp_sk_add_fail: number of sockets that failed to be prepared
+ *                           for offloading.
+ * @rx_nvmeotcp_sk_del: number of sockets where offloading has been removed.
+ * @rx_nvmeotcp_ddp_setup: number of NVMeTCP PDU successfully prepared for
+ *                         Direct Data Placement.
+ * @rx_nvmeotcp_ddp_setup_fail: number of PDUs that failed DDP preparation.
+ * @rx_nvmeotcp_ddp_teardown: number of PDUs done with DDP.
+ * @rx_nvmeotcp_drop: number of PDUs dropped.
+ * @rx_nvmeotcp_resync: number of resync.
+ * @rx_nvmeotcp_packets: number of offloaded PDUs.
+ * @rx_nvmeotcp_bytes: number of offloaded bytes.
+ */
+struct ulp_ddp_stats {
+	u64 rx_nvmeotcp_sk_add;
+	u64 rx_nvmeotcp_sk_add_fail;
+	u64 rx_nvmeotcp_sk_del;
+	u64 rx_nvmeotcp_ddp_setup;
+	u64 rx_nvmeotcp_ddp_setup_fail;
+	u64 rx_nvmeotcp_ddp_teardown;
+	u64 rx_nvmeotcp_drop;
+	u64 rx_nvmeotcp_resync;
+	u64 rx_nvmeotcp_packets;
+	u64 rx_nvmeotcp_bytes;
+
+	/*
+	 * add new stats at the end and keep in sync with
+	 * Documentation/netlink/specs/ulp_ddp.yaml
+	 */
+};
+
+#define ULP_DDP_CAP_COUNT 1
+
+struct ulp_ddp_dev_caps {
+	DECLARE_BITMAP(active, ULP_DDP_CAP_COUNT);
+	DECLARE_BITMAP(hw, ULP_DDP_CAP_COUNT);
+};
+
+struct netlink_ext_ack;
+
+/**
+ * struct ulp_ddp_dev_ops - operations used by an upper layer protocol
+ *                          to configure ddp offload
+ *
+ * @limits:    query ulp driver limitations and quirks.
+ * @sk_add:    add offload for the queue represented by socket+config
+ *             pair. this function is used to configure either copy, crc
+ *             or both offloads.
+ * @sk_del:    remove offload from the socket, and release any device
+ *             related resources.
+ * @setup:     request copy offload for buffers associated with a
+ *             command_id in ulp_ddp_io.
+ * @teardown:  release offload resources association between buffers
+ *             and command_id in ulp_ddp_io.
+ * @resync:    respond to the driver's resync_request. Called only if
+ *             resync is successful.
+ * @set_caps:  set device ULP DDP capabilities.
+ *	       returns a negative error code or zero.
+ * @get_caps:  get device ULP DDP capabilities.
+ * @get_stats: query ULP DDP statistics.
+ */
+struct ulp_ddp_dev_ops {
+	int (*limits)(struct net_device *netdev,
+		      struct ulp_ddp_limits *limits);
+	int (*sk_add)(struct net_device *netdev,
+		      struct sock *sk,
+		      struct ulp_ddp_config *config);
+	void (*sk_del)(struct net_device *netdev,
+		       struct sock *sk);
+	int (*setup)(struct net_device *netdev,
+		     struct sock *sk,
+		     struct ulp_ddp_io *io);
+	void (*teardown)(struct net_device *netdev,
+			 struct sock *sk,
+			 struct ulp_ddp_io *io,
+			 void *ddp_ctx);
+	void (*resync)(struct net_device *netdev,
+		       struct sock *sk, u32 seq);
+	int (*set_caps)(struct net_device *dev, unsigned long *bits,
+			struct netlink_ext_ack *extack);
+	void (*get_caps)(struct net_device *dev,
+			 struct ulp_ddp_dev_caps *caps);
+	int (*get_stats)(struct net_device *dev,
+			 struct ulp_ddp_stats *stats);
+};
+
+#define ULP_DDP_RESYNC_PENDING BIT(0)
+
+/**
+ * struct ulp_ddp_ulp_ops - Interface to register upper layer
+ *                          Direct Data Placement (DDP) TCP offload.
+ * @resync_request:         NIC requests ulp to indicate if @seq is the start
+ *                          of a message.
+ * @ddp_teardown_done:      NIC driver informs the ulp that teardown is done,
+ *                          used for async completions.
+ */
+struct ulp_ddp_ulp_ops {
+	bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
+	void (*ddp_teardown_done)(void *ddp_ctx);
+};
+
+/**
+ * struct ulp_ddp_ctx - Generic ulp ddp context
+ *
+ * @type:	type of this context struct
+ * @buf:	protocol-specific context struct
+ */
+struct ulp_ddp_ctx {
+	enum ulp_ddp_type	type;
+	unsigned char		buf[];
+};
+
+static inline struct ulp_ddp_ctx *ulp_ddp_get_ctx(struct sock *sk)
+{
+#ifdef CONFIG_ULP_DDP
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return (__force struct ulp_ddp_ctx *)icsk->icsk_ulp_ddp_data;
+#else
+	return NULL;
+#endif
+}
+
+static inline void ulp_ddp_set_ctx(struct sock *sk, void *ctx)
+{
+#ifdef CONFIG_ULP_DDP
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	rcu_assign_pointer(icsk->icsk_ulp_ddp_data, ctx);
+#endif
+}
+
+static inline int ulp_ddp_setup(struct net_device *netdev,
+				struct sock *sk,
+				struct ulp_ddp_io *io)
+{
+#ifdef CONFIG_ULP_DDP
+	return netdev->netdev_ops->ulp_ddp_ops->setup(netdev, sk, io);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static inline void ulp_ddp_teardown(struct net_device *netdev,
+				    struct sock *sk,
+				    struct ulp_ddp_io *io,
+				    void *ddp_ctx)
+{
+#ifdef CONFIG_ULP_DDP
+	netdev->netdev_ops->ulp_ddp_ops->teardown(netdev, sk, io, ddp_ctx);
+#endif
+}
+
+static inline void ulp_ddp_resync(struct net_device *netdev,
+				  struct sock *sk,
+				  u32 seq)
+{
+#ifdef CONFIG_ULP_DDP
+	netdev->netdev_ops->ulp_ddp_ops->resync(netdev, sk, seq);
+#endif
+}
+
+static inline int ulp_ddp_get_limits(struct net_device *netdev,
+				     struct ulp_ddp_limits *limits,
+				     enum ulp_ddp_type type)
+{
+#ifdef CONFIG_ULP_DDP
+	limits->type = type;
+	return netdev->netdev_ops->ulp_ddp_ops->limits(netdev, limits);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static inline bool ulp_ddp_cap_turned_on(unsigned long *old,
+					 unsigned long *new,
+					 int bit_nr)
+{
+	return !test_bit(bit_nr, old) && test_bit(bit_nr, new);
+}
+
+static inline bool ulp_ddp_cap_turned_off(unsigned long *old,
+					  unsigned long *new,
+					  int bit_nr)
+{
+	return test_bit(bit_nr, old) && !test_bit(bit_nr, new);
+}
+
+#ifdef CONFIG_ULP_DDP
+
+int ulp_ddp_sk_add(struct net_device *netdev,
+		   netdevice_tracker *tracker,
+		   gfp_t gfp,
+		   struct sock *sk,
+		   struct ulp_ddp_config *config,
+		   const struct ulp_ddp_ulp_ops *ops);
+
+void ulp_ddp_sk_del(struct net_device *netdev,
+		    netdevice_tracker *tracker,
+		    struct sock *sk);
+
+bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr);
+
+#else
+
+static inline int ulp_ddp_sk_add(struct net_device *netdev,
+				 netdevice_tracker *tracker,
+				 gfp_t gfp,
+				 struct sock *sk,
+				 struct ulp_ddp_config *config,
+				 const struct ulp_ddp_ulp_ops *ops)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void ulp_ddp_sk_del(struct net_device *netdev,
+				  netdevice_tracker *tracker,
+				  struct sock *sk)
+{}
+
+static inline bool ulp_ddp_is_cap_active(struct net_device *netdev,
+					 int cap_bit_nr)
+{
+	return false;
+}
+
+#endif
+
+#endif	/* _ULP_DDP_H */
diff --git a/net/Kconfig b/net/Kconfig
index 202cc595e5e6..5059db6d41cf 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -537,4 +537,24 @@ config NET_TEST
 
 	  If unsure, say N.
 
+config ULP_DDP
+	bool "ULP direct data placement offload"
+	help
+	  This feature provides a generic infrastructure for Direct
+	  Data Placement (DDP) offload for Upper Layer Protocols (ULP,
+	  such as NVMe-TCP).
+
+	  If the ULP and NIC driver supports it, the ULP code can
+	  request the NIC to place ULP response data directly
+	  into application memory, avoiding a costly copy.
+
+	  This infrastructure also allows for offloading the ULP data
+	  integrity checks (e.g. data digest) that would otherwise
+	  require another costly pass on the data we managed to avoid
+	  copying.
+
+	  For more information, see
+	  <file:Documentation/networking/ulp-ddp-offload.rst>.
+
+
 endif   # if NET
diff --git a/net/core/Makefile b/net/core/Makefile
index b2a76ce33932..6d817870d7c3 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 obj-y += net-sysfs.o
 obj-y += hotdata.o
 obj-y += netdev_rx_queue.o
+obj-$(CONFIG_ULP_DDP) += ulp_ddp.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d73ad79fe739..f9a77e44be1e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -79,6 +79,7 @@
 #include <net/mctp.h>
 #include <net/page_pool/helpers.h>
 #include <net/dropreason.h>
+#include <net/ulp_ddp.h>
 
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -6910,7 +6911,8 @@ void skb_condense(struct sk_buff *skb)
 {
 	if (skb->data_len) {
 		if (skb->data_len > skb->end - skb->tail ||
-		    skb_cloned(skb) || !skb_frags_readable(skb))
+		    skb_cloned(skb) || !skb_frags_readable(skb) ||
+		    skb_is_no_condense(skb))
 			return;
 
 		/* Nice, we can free page frag(s) right now */
diff --git a/net/core/ulp_ddp.c b/net/core/ulp_ddp.c
new file mode 100644
index 000000000000..f8ebd729e119
--- /dev/null
+++ b/net/core/ulp_ddp.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * ulp_ddp.c
+ *   Author:	Aurelien Aptel <aaptel@nvidia.com>
+ *   Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+
+#include <net/ulp_ddp.h>
+
+int ulp_ddp_sk_add(struct net_device *netdev,
+		   netdevice_tracker *tracker,
+		   gfp_t gfp,
+		   struct sock *sk,
+		   struct ulp_ddp_config *config,
+		   const struct ulp_ddp_ulp_ops *ops)
+{
+	int ret;
+
+	/* put in ulp_ddp_sk_del() */
+	netdev_hold(netdev, tracker, gfp);
+
+	ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev, sk, config);
+	if (ret) {
+		dev_put(netdev);
+		return ret;
+	}
+
+	inet_csk(sk)->icsk_ulp_ddp_ops = ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_sk_add);
+
+void ulp_ddp_sk_del(struct net_device *netdev,
+		    netdevice_tracker *tracker,
+		    struct sock *sk)
+{
+	netdev->netdev_ops->ulp_ddp_ops->sk_del(netdev, sk);
+	inet_csk(sk)->icsk_ulp_ddp_ops = NULL;
+	netdev_put(netdev, tracker);
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_sk_del);
+
+bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr)
+{
+	struct ulp_ddp_dev_caps caps;
+
+	if (!netdev->netdev_ops->ulp_ddp_ops)
+		return false;
+	netdev->netdev_ops->ulp_ddp_ops->get_caps(netdev, &caps);
+	return test_bit(cap_bit_nr, caps.active);
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_is_cap_active);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a35018e2d0ba..ba4f40aab826 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5499,6 +5499,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 
 		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
 		skb_copy_decrypted(nskb, skb);
+		skb_copy_no_condense(nskb, skb);
+		skb_copy_ulp_crc(nskb, skb);
 		TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
 		if (list)
 			__skb_queue_before(list, skb, nskb);
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 934f777f29d3..99362ef49128 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -353,6 +353,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 
 	flush |= (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
 	flush |= skb_cmp_decrypted(p, skb);
+	flush |= skb_cmp_ulp_crc(p, skb);
 
 	if (unlikely(NAPI_GRO_CB(p)->is_flist)) {
 		flush |= (__force int)(flags ^ tcp_flag_word(th2));
-- 
2.34.1


