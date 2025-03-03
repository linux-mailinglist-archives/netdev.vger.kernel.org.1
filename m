Return-Path: <netdev+bounces-171145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 764E9A4BB38
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9E8167A1C
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC761F0E3C;
	Mon,  3 Mar 2025 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oUTMPmu+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8731E2033A
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995614; cv=fail; b=i/Ea0AJxi0OO91GzEsEh878GuAk2t/d8sXqUiy+iSc97beRwy0sQhj4XQW7V6ySlwutLeudZ7Od5Q/rwS6iHdmoeux0sPaWm5oRPqFQKQ5KxuZDMkRPZioZnOsgRIEIDXZLE0P+RaLVY+wxbNyEpHg4vYQgn+KuLmmYmWy7n6Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995614; c=relaxed/simple;
	bh=MP5hMOvppKPGcx14yq3QFV/glCWPsalfKPPEr9oYDvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WGS/pQZ948KA8jICbv531sBNPd8acM7OJl2vC5JADKPOGI+U2POqXC6fCBKR94ks31YUKy+X/ka4wvTN8Bje+AiX7DUMU7u7jZvBjYorlKmDDVIysTP1gnPq3ehrJxM8uxrWYHFTwQ7OqePItjS2FLQ0Z58uvixLRbv9ssaaI0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oUTMPmu+; arc=fail smtp.client-ip=40.107.212.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCmtJ1I+QOJNBqnK+MMLIsaUoksA6+SzZRKB2hEaoCW5OI+eDPuk9Ya4iHG8HFS/8sA/FjLm0n9VqTOT1DLs9Ar4aHCJmWwmy+nxAu6zF/SVznFNTjc9vG7tlocyMfSoRpZSBZBV9863BCQcJGDj19w4ha5B9swCrGVDmDrkKyJLo/0NP4QKgzRlJrEb1jfUa5A9rYVsMVqFzr5OSBnw2FNE6f0L9kNi1wPJ9ROtQEGwCUPF0Vc79nOpgr+CCpJCp/FXdiFCJnduk1H31/yjwBa5UMoZZnoVg9LZUU86D61xiqpntMAE24tCHWm/lzdqlMeqqGTgX/EDL8uDwKfafQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8SkvmCXGp+VxnyOzV7VkJNb60uwDM9K9qbfQSmTByw=;
 b=ECfnazp1FaWYfTbyuZjxqb+PDRrTq/MnhDSKCgjrjXuOjeZFviLRpT/q9Zr0LmLZNegf9bIrMK/im/UIpWNpvp3wWY0dpjXjDjz/D4BqdeGm6/H2ZqGPV5NF/b60L8nWCqPKCgF0CrbAm+3zCwq4g63Erah6aYF341g46Ok2XEIIaRLHnERNc25JEyHOgTdo+PdnBpBUJdWcJbHEMEcQvRCKBe0fvYxcsTjzSiqYMHppJAUf1BjX9hRIzFHca2PEfoVL5L4RTg87+ceLL03UBJN5YK1ji/iuQQXHyiAnacDQ8ijGnKYmM2MyQkfAyyQdhlaE0KfiO+bCPtbHeUDe1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8SkvmCXGp+VxnyOzV7VkJNb60uwDM9K9qbfQSmTByw=;
 b=oUTMPmu+L3ASWqa1YEtiCDHBfIAs7a4zNaD7Glsxxhq204OjIrvi5rEGHMByNFPS/tP1wTcnoEhvt8T6f2cBLDHN1T2Hul1Nda/AJpBso96mLXfzgBPEQfitdZiQAqmZczIbzmMCmpK0sSd+Cb2Y3Da8/m6eF462Az0FKCE6yF0r0/+ZtGbwGJnyKofTHqf+AYqSdf+MVAS0ikpwtUhUizK6Z82RuYdOkKnLQHZqtSMxbsMZ9HhKuFlS5B0NH5rfiRHIBSS+O5EHJB7uVyouZhqoBlX2WwLnE9sQ2lRgmSMeFOXyRXavrqnKTHG4/YlsMcU/XbXYch9HZrk4132aoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Mon, 3 Mar
 2025 09:53:27 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:53:27 +0000
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
Cc: Aurelien Aptel <aaptel@nvidia.com>,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com
Subject: [PATCH v27 02/20] netlink: add new family to manage ULP_DDP enablement and stats
Date: Mon,  3 Mar 2025 09:52:46 +0000
Message-Id: <20250303095304.1534-3-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303095304.1534-1-aaptel@nvidia.com>
References: <20250303095304.1534-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0008.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::11) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 684271e0-9b96-43b8-8a6f-08dd5a393eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LRGgrPLAwkJJhbcW9WD8Cx4P1rHUEk2w/IdJBufzPjqU5dvZCfRurDnXdRch?=
 =?us-ascii?Q?xkHmDgUmMIDDyTs4oon6gS8ATBzpy/giuMFwAjKIfKiT/899ZYVZhuU8HYbY?=
 =?us-ascii?Q?dexNFzkU7Ux8dIV1LVzT+QkiXRzMIatzUGwgy/xM3XDt8EwCYdzMdJWIks8e?=
 =?us-ascii?Q?1loeT21Emm/m9U9DTds2rbDDc0FiaM3pko3Oe8Vi6DR8/zUBilzOR8IxV/Ow?=
 =?us-ascii?Q?WqYrHd1FE8SGualdlFvpLE840Gj6a9g3ZbDDrbi1hOc9P3Txl5GWh+wiGjxN?=
 =?us-ascii?Q?zwaH1/4xk72B2OBzxZiCK35sZ14sQPcLUBIw2f0pn/XAnClStal+Da2qp5AU?=
 =?us-ascii?Q?VU12lzKixvWk0A2soJTPCxKjg7+i8YcT1dsoxBDdBd/ShxfknpsTmNm5R+ty?=
 =?us-ascii?Q?CBZz4GiCRVwGo5Po12T5Yj0IlIWINyhtIsMNxBmXuFu35FQALFOGZcCfmYGR?=
 =?us-ascii?Q?MLC8dThvcJInSk+xjOIHOqhWJCFGnJ3niXjPdS5GO8mFdangw9gZpP/TjfTB?=
 =?us-ascii?Q?RiRQDQA9eBAVzfYSSqDzmxAsL1EkSQ81YrHzpe4rdmEpwVpUJIbcp6d0J8L5?=
 =?us-ascii?Q?Jrh6LKMpUbLCjGoSMD7E2W5tzhQ2U1WKawuwN+dUv+fyqf3EhoB9CJjpS4LO?=
 =?us-ascii?Q?kVKetT5oflAFLEg7InwqzeDTCP/kPbYe4sSXVlykeKtzqBGCO8utjmx95ui2?=
 =?us-ascii?Q?AHzUgLavADZi8vNHWeITJbUJ+MK49VcsisOTFXQ7RHz2oTI6ywX9la9yM0fo?=
 =?us-ascii?Q?V1Q3k8algni8CKZKPjMlai//tgDI617UdYDRDC1s0w3BRiNYD90zAMRhUK6g?=
 =?us-ascii?Q?Do3Xsf4d/gNLPLnSItnkFxmFJHHJhrNFfCm1yuRMe8Zd/V9mhvu4i8hCSylV?=
 =?us-ascii?Q?ryfKWeBvZ9aQOF7yJsoIrEQNMZabENAznliBMO6+FaG8XUdTQlaK3KmppedM?=
 =?us-ascii?Q?LKLDE9IGpUbNAiSjjqmsIRPMZ/18SFLk79LF/3wRQF1GUt07Ge9TaQHrjV1p?=
 =?us-ascii?Q?I/V+RSu1dphfeCBKjG8sJaNmpvrdJbIX/tA9Gdg/gk6aYr64zTU69JcM3wkJ?=
 =?us-ascii?Q?CBS/5a772sLUE+8wkPSBWDfsM4LfEwnEFmNGWf9ChVirTYkMxRZ0kBZcteaL?=
 =?us-ascii?Q?jTDGtsCHlTYqbdswUCmmGNxm9bzAGVSjjET9GKREcJkQ38UuTJ8aiux/upDR?=
 =?us-ascii?Q?2osvAyVlrDbm7FRiM2KUUYldgQ5QMU67djOv8+oOyWUP6RUA4d2sqOfo0cLP?=
 =?us-ascii?Q?3tz8Qok8qfDl2IuqbM5oZOC3Fsq177A7OkK1YaKE+K7J6UEoodooFOIRIOZE?=
 =?us-ascii?Q?nArQw6+nDxnggaoymG+XCoNiIR0fi1ebuUlO+qNHi9pHNm9N6WhIvKOpeL9t?=
 =?us-ascii?Q?7YjtjKCJWKrFKa8ateZSSZRYMfND?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QyBOf8JzMs+DmFhTfygIVopj5svbPT63ic871e2yvatzbY982LHd/vR0tt08?=
 =?us-ascii?Q?Jy3u3J4+18sUF5hjS16ZUYtPeh9QFkBjGa9iJGYQpknZ4qXJhw0YZTF2PftL?=
 =?us-ascii?Q?HwV5fHsrbVD2E+mw18LVbmFcrTJQEjE9259+PQDuqryLl9Kd4cqgFtYoJmrP?=
 =?us-ascii?Q?NmvoP+wSY2xUjV76nJIFwYCpHkor6UjbKfuJrHXu+I7BnrJQfnVoU51wAL7s?=
 =?us-ascii?Q?LZJeYITkYGu1BW7VmMur23XwqEXUn+w8EM7AUcbYzHP+UkeW+J8IXbRRuO//?=
 =?us-ascii?Q?Q9wQCFzRxN4xS3dwmPzNJn0MTYBHBBSF842R87volJ9u2+uPHjiVISacRcPc?=
 =?us-ascii?Q?QV0ePJWNZu03Jv5rhX2KZ5drICF/QHB96J6voiF01MuXhiOMXts7QhukBsqB?=
 =?us-ascii?Q?nrG6dDZBfBHQm5P4HwZ+0GxJ5jP7ZqEcNR3rRgkVfzOpprUspvO68q2+7bcp?=
 =?us-ascii?Q?9q+Q4olxRrZ7qXoqX6z/1WgX5rooMi5Z48yAW10SEXa9QmY+/b+QPmIcgBjo?=
 =?us-ascii?Q?OC1t602RLXhPfyejYPlzAXffRo7izwndYiEpb05pkftJvlVUKxvsFKIzVPbF?=
 =?us-ascii?Q?rPWaRDt3h+X+wFMf4WsLIIzPMI9mOLZnuPgNzNI/HElSHugfbdo2SvSzsHKC?=
 =?us-ascii?Q?t40ANyDVb9nz3R/X+M1raAV5XQPnTAZdQXkDtoY0P9wBRMiVz4r8mKk+7xE3?=
 =?us-ascii?Q?NvqH2585SGgBxPzyHykw9a260OjXsm4olKBdtsDD8zwtdp9RlIG+INgisVB+?=
 =?us-ascii?Q?WLCLhhbyk2OjGJU/w0RGy6ras88yEy73M2LOkoWAGw3l/uJYIdrnO+eR4qJw?=
 =?us-ascii?Q?bZK4jYNPSw3t6oBLeGj02jy6YxWV+1h/WLKff/j0iwZ2Pq8nQlVm76WVSBmd?=
 =?us-ascii?Q?tn/CaGNHg0KaLJ27aazVatpcWaOrVBuWp5IBi4dSPzNDLNPcLDxj9f7C62/A?=
 =?us-ascii?Q?T5lSIbR3R1RS4OKXaiaXKxijniVyABznd5+I3EhUx5GMvtXxDdanXbz+AUqd?=
 =?us-ascii?Q?7kuF9nGqeajM8zYJoLj83OirIh4CS6uyl5NtCR6xAuv8tn3CF9/RrFnuBEPu?=
 =?us-ascii?Q?gz990uJhOjk6zReJlCLwxnmfPfAs3otH8Ak6lglE8D0/RVJBz+lwGfi1dA/b?=
 =?us-ascii?Q?Sjb0Zk2pTU8E67a9WvbZpTcNa3D3O+Ep5NQyqsv3dFj1PHYOhlt/VNw/21XK?=
 =?us-ascii?Q?9lnUeSuOe6qtKH91toMz1mln5P7gSoMYRLcDPdPyFFKBQyPwLbDvrWoFSTVA?=
 =?us-ascii?Q?XcqSPLEra7IK6Pl8XQd7st6KA/JoSXhhLkPISD0t4Moju6WEHU2RwDgcZAzL?=
 =?us-ascii?Q?pB40o67RVkgamIAI2DINat3jbUfLddRwAxvL/6W74R7e9QC53JGMVevf88/L?=
 =?us-ascii?Q?tXuP+IrGiggJow+UB7OW0AUJIqWAq0AfBdqH42OL5siKJ/Z9AO29OrGgRA7V?=
 =?us-ascii?Q?IZ2vCU5XBRhhAedXw1dVfimCoUFmTe+iXyEjCq+r6Hspd3ruSjIqoTamsVBr?=
 =?us-ascii?Q?1n4XZ4h93qSdWYZSaebiRTQAzn1L0yYJAIZz0wQBXCnnyKXp8nlp/8Q8ksXZ?=
 =?us-ascii?Q?b8afprHWd450Dbkwt1UcK8CqBE65JQdXNy2LkOeq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684271e0-9b96-43b8-8a6f-08dd5a393eab
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:53:27.2253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D61bW36tfQNQ9SMopyvY1C26iCGBFQq0mU7yVGJD9hbGJEtZwV8QgQo44p4BHdZsJb8dHADl/UHplXBZ1DiC1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

Add a new netlink family to get/set ULP DDP capabilities on a network
device and to retrieve statistics.

The messages use the genetlink infrastructure and are specified in a
YAML file which was used to generate some of the files in this commit:

./tools/net/ynl/ynl-gen-c.py --mode kernel \
    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
    -o net/core/ulp_ddp_gen_nl.h
./tools/net/ynl/ynl-gen-c.py --mode kernel \
    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --source \
    -o net/core/ulp_ddp_gen_nl.c
./tools/net/ynl/ynl-gen-c.py --mode uapi \
    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
    > include/uapi/linux/ulp_ddp.h

Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/ulp_ddp.yaml | 172 ++++++++++++
 include/net/ulp_ddp.h                    |   3 +-
 include/uapi/linux/ulp_ddp.h             |  61 ++++
 net/core/Makefile                        |   2 +-
 net/core/ulp_ddp_gen_nl.c                |  75 +++++
 net/core/ulp_ddp_gen_nl.h                |  30 ++
 net/core/ulp_ddp_nl.c                    | 344 +++++++++++++++++++++++
 7 files changed, 685 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/netlink/specs/ulp_ddp.yaml
 create mode 100644 include/uapi/linux/ulp_ddp.h
 create mode 100644 net/core/ulp_ddp_gen_nl.c
 create mode 100644 net/core/ulp_ddp_gen_nl.h
 create mode 100644 net/core/ulp_ddp_nl.c

diff --git a/Documentation/netlink/specs/ulp_ddp.yaml b/Documentation/netlink/specs/ulp_ddp.yaml
new file mode 100644
index 000000000000..27a0b905ec28
--- /dev/null
+++ b/Documentation/netlink/specs/ulp_ddp.yaml
@@ -0,0 +1,172 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+#
+# Author: Aurelien Aptel <aaptel@nvidia.com>
+#
+# Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+#
+
+name: ulp_ddp
+
+protocol: genetlink
+
+doc: Netlink protocol to manage ULP DPP on network devices.
+
+definitions:
+  -
+    type: enum
+    name: cap
+    render-max: true
+    entries:
+      - nvme-tcp
+      - nvme-tcp-ddgst-rx
+
+attribute-sets:
+  -
+    name: stats
+    attributes:
+      -
+        name: ifindex
+        doc: Interface index of the net device.
+        type: u32
+      -
+        name: rx-nvme-tcp-sk-add
+        doc: Sockets successfully configured for NVMeTCP offloading.
+        type: uint
+      -
+        name: rx-nvme-tcp-sk-add-fail
+        doc: Sockets failed to be configured for NVMeTCP offloading.
+        type: uint
+      -
+        name: rx-nvme-tcp-sk-del
+        doc: Sockets with NVMeTCP offloading configuration removed.
+        type: uint
+      -
+        name: rx-nvme-tcp-setup
+        doc: NVMe-TCP IOs successfully configured for Rx Direct Data Placement.
+        type: uint
+      -
+        name: rx-nvme-tcp-setup-fail
+        doc: NVMe-TCP IOs failed to be configured for Rx Direct Data Placement.
+        type: uint
+      -
+        name: rx-nvme-tcp-teardown
+        doc: NVMe-TCP IOs with Rx Direct Data Placement configuration removed.
+        type: uint
+      -
+        name: rx-nvme-tcp-drop
+        doc: Packets failed the NVMeTCP offload validation.
+        type: uint
+      -
+        name: rx-nvme-tcp-resync
+        doc: >
+          NVMe-TCP resync operations were processed due to Rx TCP packets
+          re-ordering.
+        type: uint
+      -
+        name: rx-nvme-tcp-packets
+        doc: TCP packets successfully processed by the NVMeTCP offload.
+        type: uint
+      -
+        name: rx-nvme-tcp-bytes
+        doc: Bytes were successfully processed by the NVMeTCP offload.
+        type: uint
+  -
+    name: caps
+    attributes:
+      -
+        name: ifindex
+        doc: Interface index of the net device.
+        type: u32
+      -
+        name: hw
+        doc: Bitmask of the capabilities supported by the device.
+        type: uint
+        enum: cap
+        enum-as-flags: true
+      -
+        name: active
+        doc: Bitmask of the capabilities currently enabled on the device.
+        type: uint
+        enum: cap
+        enum-as-flags: true
+      -
+        name: wanted
+        doc: >
+          New active bit values of the capabilities we want to set on the
+          device.
+        type: uint
+        enum: cap
+        enum-as-flags: true
+      -
+        name: wanted_mask
+        doc: Bitmask of the meaningful bits in the wanted field.
+        type: uint
+        enum: cap
+        enum-as-flags: true
+
+operations:
+  list:
+    -
+      name: caps-get
+      doc: Get ULP DDP capabilities.
+      attribute-set: caps
+      do:
+        request:
+          attributes:
+            - ifindex
+        reply:
+          attributes:
+            - ifindex
+            - hw
+            - active
+        pre: ulp_ddp_get_netdev
+        post: ulp_ddp_put_netdev
+    -
+      name: stats-get
+      doc: Get ULP DDP stats.
+      attribute-set: stats
+      do:
+        request:
+          attributes:
+            - ifindex
+        reply:
+          attributes:
+            - ifindex
+            - rx-nvme-tcp-sk-add
+            - rx-nvme-tcp-sk-add-fail
+            - rx-nvme-tcp-sk-del
+            - rx-nvme-tcp-setup
+            - rx-nvme-tcp-setup-fail
+            - rx-nvme-tcp-teardown
+            - rx-nvme-tcp-drop
+            - rx-nvme-tcp-resync
+            - rx-nvme-tcp-packets
+            - rx-nvme-tcp-bytes
+        pre: ulp_ddp_get_netdev
+        post: ulp_ddp_put_netdev
+    -
+      name: caps-set
+      doc: Set ULP DDP capabilities.
+      attribute-set: caps
+      do:
+        request:
+          attributes:
+            - ifindex
+            - wanted
+            - wanted_mask
+        reply:
+          attributes:
+            - ifindex
+            - hw
+            - active
+        pre: ulp_ddp_get_netdev
+        post: ulp_ddp_put_netdev
+    -
+      name: caps-set-ntf
+      doc: Notification for change in ULP DDP capabilities.
+      notify: caps-get
+
+mcast-groups:
+  list:
+    -
+      name: mgmt
diff --git a/include/net/ulp_ddp.h b/include/net/ulp_ddp.h
index 7b32bb9e2a08..2e54d19c22f6 100644
--- a/include/net/ulp_ddp.h
+++ b/include/net/ulp_ddp.h
@@ -10,6 +10,7 @@
 #include <linux/netdevice.h>
 #include <net/inet_connection_sock.h>
 #include <net/sock.h>
+#include <uapi/linux/ulp_ddp.h>
 
 enum ulp_ddp_type {
 	ULP_DDP_NVME = 1,
@@ -126,7 +127,7 @@ struct ulp_ddp_stats {
 	 */
 };
 
-#define ULP_DDP_CAP_COUNT 1
+#define ULP_DDP_CAP_COUNT (ULP_DDP_CAP_MAX + 1)
 
 struct ulp_ddp_dev_caps {
 	DECLARE_BITMAP(active, ULP_DDP_CAP_COUNT);
diff --git a/include/uapi/linux/ulp_ddp.h b/include/uapi/linux/ulp_ddp.h
new file mode 100644
index 000000000000..dbf6399d3aef
--- /dev/null
+++ b/include/uapi/linux/ulp_ddp.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ulp_ddp.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_ULP_DDP_H
+#define _UAPI_LINUX_ULP_DDP_H
+
+#define ULP_DDP_FAMILY_NAME	"ulp_ddp"
+#define ULP_DDP_FAMILY_VERSION	1
+
+enum ulp_ddp_cap {
+	ULP_DDP_CAP_NVME_TCP,
+	ULP_DDP_CAP_NVME_TCP_DDGST_RX,
+
+	/* private: */
+	__ULP_DDP_CAP_MAX,
+	ULP_DDP_CAP_MAX = (__ULP_DDP_CAP_MAX - 1)
+};
+
+enum {
+	ULP_DDP_A_STATS_IFINDEX = 1,
+	ULP_DDP_A_STATS_RX_NVME_TCP_SK_ADD,
+	ULP_DDP_A_STATS_RX_NVME_TCP_SK_ADD_FAIL,
+	ULP_DDP_A_STATS_RX_NVME_TCP_SK_DEL,
+	ULP_DDP_A_STATS_RX_NVME_TCP_SETUP,
+	ULP_DDP_A_STATS_RX_NVME_TCP_SETUP_FAIL,
+	ULP_DDP_A_STATS_RX_NVME_TCP_TEARDOWN,
+	ULP_DDP_A_STATS_RX_NVME_TCP_DROP,
+	ULP_DDP_A_STATS_RX_NVME_TCP_RESYNC,
+	ULP_DDP_A_STATS_RX_NVME_TCP_PACKETS,
+	ULP_DDP_A_STATS_RX_NVME_TCP_BYTES,
+
+	__ULP_DDP_A_STATS_MAX,
+	ULP_DDP_A_STATS_MAX = (__ULP_DDP_A_STATS_MAX - 1)
+};
+
+enum {
+	ULP_DDP_A_CAPS_IFINDEX = 1,
+	ULP_DDP_A_CAPS_HW,
+	ULP_DDP_A_CAPS_ACTIVE,
+	ULP_DDP_A_CAPS_WANTED,
+	ULP_DDP_A_CAPS_WANTED_MASK,
+
+	__ULP_DDP_A_CAPS_MAX,
+	ULP_DDP_A_CAPS_MAX = (__ULP_DDP_A_CAPS_MAX - 1)
+};
+
+enum {
+	ULP_DDP_CMD_CAPS_GET = 1,
+	ULP_DDP_CMD_STATS_GET,
+	ULP_DDP_CMD_CAPS_SET,
+	ULP_DDP_CMD_CAPS_SET_NTF,
+
+	__ULP_DDP_CMD_MAX,
+	ULP_DDP_CMD_MAX = (__ULP_DDP_CMD_MAX - 1)
+};
+
+#define ULP_DDP_MCGRP_MGMT	"mgmt"
+
+#endif /* _UAPI_LINUX_ULP_DDP_H */
diff --git a/net/core/Makefile b/net/core/Makefile
index 767ed5186d4d..7b040d36cf94 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 obj-y += net-sysfs.o
 obj-y += hotdata.o
 obj-y += netdev_rx_queue.o
-obj-$(CONFIG_ULP_DDP) += ulp_ddp.o
+obj-$(CONFIG_ULP_DDP) += ulp_ddp.o ulp_ddp_nl.o ulp_ddp_gen_nl.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
diff --git a/net/core/ulp_ddp_gen_nl.c b/net/core/ulp_ddp_gen_nl.c
new file mode 100644
index 000000000000..5675193ad8ca
--- /dev/null
+++ b/net/core/ulp_ddp_gen_nl.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ulp_ddp.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "ulp_ddp_gen_nl.h"
+
+#include <uapi/linux/ulp_ddp.h>
+
+/* ULP_DDP_CMD_CAPS_GET - do */
+static const struct nla_policy ulp_ddp_caps_get_nl_policy[ULP_DDP_A_CAPS_IFINDEX + 1] = {
+	[ULP_DDP_A_CAPS_IFINDEX] = { .type = NLA_U32, },
+};
+
+/* ULP_DDP_CMD_STATS_GET - do */
+static const struct nla_policy ulp_ddp_stats_get_nl_policy[ULP_DDP_A_STATS_IFINDEX + 1] = {
+	[ULP_DDP_A_STATS_IFINDEX] = { .type = NLA_U32, },
+};
+
+/* ULP_DDP_CMD_CAPS_SET - do */
+static const struct nla_policy ulp_ddp_caps_set_nl_policy[ULP_DDP_A_CAPS_WANTED_MASK + 1] = {
+	[ULP_DDP_A_CAPS_IFINDEX] = { .type = NLA_U32, },
+	[ULP_DDP_A_CAPS_WANTED] = NLA_POLICY_MASK(NLA_UINT, 0x3),
+	[ULP_DDP_A_CAPS_WANTED_MASK] = NLA_POLICY_MASK(NLA_UINT, 0x3),
+};
+
+/* Ops table for ulp_ddp */
+static const struct genl_split_ops ulp_ddp_nl_ops[] = {
+	{
+		.cmd		= ULP_DDP_CMD_CAPS_GET,
+		.pre_doit	= ulp_ddp_get_netdev,
+		.doit		= ulp_ddp_nl_caps_get_doit,
+		.post_doit	= ulp_ddp_put_netdev,
+		.policy		= ulp_ddp_caps_get_nl_policy,
+		.maxattr	= ULP_DDP_A_CAPS_IFINDEX,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= ULP_DDP_CMD_STATS_GET,
+		.pre_doit	= ulp_ddp_get_netdev,
+		.doit		= ulp_ddp_nl_stats_get_doit,
+		.post_doit	= ulp_ddp_put_netdev,
+		.policy		= ulp_ddp_stats_get_nl_policy,
+		.maxattr	= ULP_DDP_A_STATS_IFINDEX,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= ULP_DDP_CMD_CAPS_SET,
+		.pre_doit	= ulp_ddp_get_netdev,
+		.doit		= ulp_ddp_nl_caps_set_doit,
+		.post_doit	= ulp_ddp_put_netdev,
+		.policy		= ulp_ddp_caps_set_nl_policy,
+		.maxattr	= ULP_DDP_A_CAPS_WANTED_MASK,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+};
+
+static const struct genl_multicast_group ulp_ddp_nl_mcgrps[] = {
+	[ULP_DDP_NLGRP_MGMT] = { "mgmt", },
+};
+
+struct genl_family ulp_ddp_nl_family __ro_after_init = {
+	.name		= ULP_DDP_FAMILY_NAME,
+	.version	= ULP_DDP_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= ulp_ddp_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(ulp_ddp_nl_ops),
+	.mcgrps		= ulp_ddp_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(ulp_ddp_nl_mcgrps),
+};
diff --git a/net/core/ulp_ddp_gen_nl.h b/net/core/ulp_ddp_gen_nl.h
new file mode 100644
index 000000000000..368433cfa867
--- /dev/null
+++ b/net/core/ulp_ddp_gen_nl.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ulp_ddp.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_ULP_DDP_GEN_H
+#define _LINUX_ULP_DDP_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/ulp_ddp.h>
+
+int ulp_ddp_get_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
+		       struct genl_info *info);
+void
+ulp_ddp_put_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
+		   struct genl_info *info);
+
+int ulp_ddp_nl_caps_get_doit(struct sk_buff *skb, struct genl_info *info);
+int ulp_ddp_nl_stats_get_doit(struct sk_buff *skb, struct genl_info *info);
+int ulp_ddp_nl_caps_set_doit(struct sk_buff *skb, struct genl_info *info);
+
+enum {
+	ULP_DDP_NLGRP_MGMT,
+};
+
+extern struct genl_family ulp_ddp_nl_family;
+
+#endif /* _LINUX_ULP_DDP_GEN_H */
diff --git a/net/core/ulp_ddp_nl.c b/net/core/ulp_ddp_nl.c
new file mode 100644
index 000000000000..04feefce23c2
--- /dev/null
+++ b/net/core/ulp_ddp_nl.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ulp_ddp_nl.c
+ *    Author: Aurelien Aptel <aaptel@nvidia.com>
+ *    Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+#include <net/ulp_ddp.h>
+#include "ulp_ddp_gen_nl.h"
+
+#define ULP_DDP_STATS_CNT (sizeof(struct ulp_ddp_stats) / sizeof(u64))
+
+struct ulp_ddp_reply_context {
+	struct net_device *dev;
+	netdevice_tracker tracker;
+	struct ulp_ddp_dev_caps caps;
+	struct ulp_ddp_stats stats;
+};
+
+static size_t ulp_ddp_reply_size(int cmd)
+{
+	size_t len = 0;
+
+	BUILD_BUG_ON(ULP_DDP_CAP_COUNT > 64);
+
+	/* ifindex */
+	len += nla_total_size(sizeof(u32));
+
+	switch (cmd) {
+	case ULP_DDP_CMD_CAPS_GET:
+	case ULP_DDP_CMD_CAPS_SET:
+	case ULP_DDP_CMD_CAPS_SET_NTF:
+		/* hw */
+		len += nla_total_size_64bit(sizeof(u64));
+
+		/* active */
+		len += nla_total_size_64bit(sizeof(u64));
+		break;
+	case ULP_DDP_CMD_STATS_GET:
+		/* stats */
+		len += nla_total_size_64bit(sizeof(u64)) * ULP_DDP_STATS_CNT;
+		break;
+	}
+
+	return len;
+}
+
+/* pre_doit */
+int ulp_ddp_get_netdev(const struct genl_split_ops *ops,
+		       struct sk_buff *skb, struct genl_info *info)
+{
+	struct ulp_ddp_reply_context *ctx;
+	u32 ifindex;
+
+	if (GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_CAPS_IFINDEX))
+		return -EINVAL;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ifindex = nla_get_u32(info->attrs[ULP_DDP_A_CAPS_IFINDEX]);
+	ctx->dev = netdev_get_by_index(genl_info_net(info),
+				       ifindex,
+				       &ctx->tracker,
+				       GFP_KERNEL);
+	if (!ctx->dev) {
+		kfree(ctx);
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    info->attrs[ULP_DDP_A_CAPS_IFINDEX],
+				    "Network interface does not exist");
+		return -ENODEV;
+	}
+
+	if (!ctx->dev->netdev_ops->ulp_ddp_ops) {
+		netdev_put(ctx->dev, &ctx->tracker);
+		kfree(ctx);
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    info->attrs[ULP_DDP_A_CAPS_IFINDEX],
+				    "Network interface does not support ULP DDP");
+		return -EOPNOTSUPP;
+	}
+
+	info->user_ptr[0] = ctx;
+	return 0;
+}
+
+/* post_doit */
+void ulp_ddp_put_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
+			struct genl_info *info)
+{
+	struct ulp_ddp_reply_context *ctx = info->user_ptr[0];
+
+	netdev_put(ctx->dev, &ctx->tracker);
+	kfree(ctx);
+}
+
+static int ulp_ddp_prepare_context(struct ulp_ddp_reply_context *ctx, int cmd)
+{
+	const struct ulp_ddp_dev_ops *ops = ctx->dev->netdev_ops->ulp_ddp_ops;
+
+	switch (cmd) {
+	case ULP_DDP_CMD_CAPS_GET:
+	case ULP_DDP_CMD_CAPS_SET:
+	case ULP_DDP_CMD_CAPS_SET_NTF:
+		ops->get_caps(ctx->dev, &ctx->caps);
+		break;
+	case ULP_DDP_CMD_STATS_GET:
+		ops->get_stats(ctx->dev, &ctx->stats);
+		break;
+	}
+
+	return 0;
+}
+
+static int ulp_ddp_write_reply(struct sk_buff *rsp,
+			       struct ulp_ddp_reply_context *ctx,
+			       int cmd,
+			       const struct genl_info *info)
+{
+	void *hdr;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	switch (cmd) {
+	case ULP_DDP_CMD_CAPS_GET:
+	case ULP_DDP_CMD_CAPS_SET:
+	case ULP_DDP_CMD_CAPS_SET_NTF:
+		if (nla_put_u32(rsp, ULP_DDP_A_CAPS_IFINDEX,
+				ctx->dev->ifindex) ||
+		    nla_put_uint(rsp, ULP_DDP_A_CAPS_HW, ctx->caps.hw[0]) ||
+		    nla_put_uint(rsp, ULP_DDP_A_CAPS_ACTIVE,
+				 ctx->caps.active[0]))
+			goto err_cancel_msg;
+		break;
+	case ULP_DDP_CMD_STATS_GET:
+		if (nla_put_u32(rsp, ULP_DDP_A_STATS_IFINDEX,
+				ctx->dev->ifindex) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_SK_ADD,
+				 ctx->stats.rx_nvmeotcp_sk_add) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_SK_ADD_FAIL,
+				 ctx->stats.rx_nvmeotcp_sk_add_fail) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_SK_DEL,
+				 ctx->stats.rx_nvmeotcp_sk_del) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_SETUP,
+				 ctx->stats.rx_nvmeotcp_ddp_setup) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_SETUP_FAIL,
+				 ctx->stats.rx_nvmeotcp_ddp_setup_fail) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_TEARDOWN,
+				 ctx->stats.rx_nvmeotcp_ddp_teardown) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_DROP,
+				 ctx->stats.rx_nvmeotcp_drop) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_RESYNC,
+				 ctx->stats.rx_nvmeotcp_resync) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_PACKETS,
+				 ctx->stats.rx_nvmeotcp_packets) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_BYTES,
+				 ctx->stats.rx_nvmeotcp_bytes))
+			goto err_cancel_msg;
+	}
+	genlmsg_end(rsp, hdr);
+
+	return 0;
+
+err_cancel_msg:
+	genlmsg_cancel(rsp, hdr);
+
+	return -EMSGSIZE;
+}
+
+int ulp_ddp_nl_caps_get_doit(struct sk_buff *req, struct genl_info *info)
+{
+	struct ulp_ddp_reply_context *ctx = info->user_ptr[0];
+	struct sk_buff *rsp;
+	int ret = 0;
+
+	ret = ulp_ddp_prepare_context(ctx, ULP_DDP_CMD_CAPS_GET);
+	if (ret)
+		return ret;
+
+	rsp = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_CAPS_GET), GFP_KERNEL);
+	if (!rsp)
+		return -EMSGSIZE;
+
+	ret = ulp_ddp_write_reply(rsp, ctx, ULP_DDP_CMD_CAPS_GET, info);
+	if (ret)
+		goto err_rsp;
+
+	return genlmsg_reply(rsp, info);
+
+err_rsp:
+	nlmsg_free(rsp);
+	return ret;
+}
+
+static void ulp_ddp_nl_notify_dev(struct ulp_ddp_reply_context *ctx)
+{
+	struct genl_info info;
+	struct sk_buff *ntf;
+	int ret;
+
+	if (!genl_has_listeners(&ulp_ddp_nl_family, dev_net(ctx->dev),
+				ULP_DDP_NLGRP_MGMT))
+		return;
+
+	genl_info_init_ntf(&info, &ulp_ddp_nl_family, ULP_DDP_CMD_CAPS_SET_NTF);
+	ntf = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_CAPS_SET_NTF), GFP_KERNEL);
+	if (!ntf)
+		return;
+
+	ret = ulp_ddp_write_reply(ntf, ctx, ULP_DDP_CMD_CAPS_SET_NTF, &info);
+	if (ret) {
+		nlmsg_free(ntf);
+		return;
+	}
+
+	genlmsg_multicast_netns(&ulp_ddp_nl_family, dev_net(ctx->dev), ntf,
+				0, ULP_DDP_NLGRP_MGMT, GFP_KERNEL);
+}
+
+static int ulp_ddp_apply_bits(struct ulp_ddp_reply_context *ctx,
+			      unsigned long *req_wanted,
+			      unsigned long *req_mask,
+			      struct genl_info *info,
+			      bool *notify)
+{
+	DECLARE_BITMAP(old_active, ULP_DDP_CAP_COUNT);
+	DECLARE_BITMAP(new_active, ULP_DDP_CAP_COUNT);
+	const struct ulp_ddp_dev_ops *ops;
+	struct ulp_ddp_dev_caps caps;
+	int ret;
+
+	ops = ctx->dev->netdev_ops->ulp_ddp_ops;
+	ops->get_caps(ctx->dev, &caps);
+
+	/* new_active = (old_active & ~req_mask) | (wanted & req_mask)
+	 * new_active &= caps_hw
+	 */
+	bitmap_copy(old_active, caps.active, ULP_DDP_CAP_COUNT);
+	bitmap_and(req_wanted, req_wanted, req_mask, ULP_DDP_CAP_COUNT);
+	bitmap_andnot(new_active, old_active, req_mask, ULP_DDP_CAP_COUNT);
+	bitmap_or(new_active, new_active, req_wanted, ULP_DDP_CAP_COUNT);
+	bitmap_and(new_active, new_active, caps.hw, ULP_DDP_CAP_COUNT);
+	if (!bitmap_equal(old_active, new_active, ULP_DDP_CAP_COUNT)) {
+		ret = ops->set_caps(ctx->dev, new_active, info->extack);
+		if (ret)
+			return ret;
+		ops->get_caps(ctx->dev, &caps);
+		bitmap_copy(new_active, caps.active, ULP_DDP_CAP_COUNT);
+	}
+
+	/* notify if capabilities were changed */
+	*notify = !bitmap_equal(old_active, new_active, ULP_DDP_CAP_COUNT);
+
+	return 0;
+}
+
+int ulp_ddp_nl_caps_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct ulp_ddp_reply_context *ctx = info->user_ptr[0];
+	unsigned long wanted, wanted_mask;
+	struct sk_buff *rsp;
+	bool notify = false;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_CAPS_WANTED) ||
+	    GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_CAPS_WANTED_MASK))
+		return -EINVAL;
+
+	rsp = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_CAPS_SET), GFP_KERNEL);
+	if (!rsp)
+		return -EMSGSIZE;
+
+	wanted = nla_get_uint(info->attrs[ULP_DDP_A_CAPS_WANTED]);
+	wanted_mask = nla_get_uint(info->attrs[ULP_DDP_A_CAPS_WANTED_MASK]);
+
+	rtnl_lock();
+	ret = ulp_ddp_apply_bits(ctx, &wanted, &wanted_mask, info, &notify);
+	rtnl_unlock();
+	if (ret)
+		goto err_rsp;
+
+	ret = ulp_ddp_prepare_context(ctx, ULP_DDP_CMD_CAPS_SET);
+	if (ret)
+		goto err_rsp;
+
+	ret = ulp_ddp_write_reply(rsp, ctx, ULP_DDP_CMD_CAPS_SET, info);
+	if (ret)
+		goto err_rsp;
+
+	ret = genlmsg_reply(rsp, info);
+	if (notify)
+		ulp_ddp_nl_notify_dev(ctx);
+
+	return ret;
+
+err_rsp:
+	nlmsg_free(rsp);
+
+	return ret;
+}
+
+int ulp_ddp_nl_stats_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct ulp_ddp_reply_context *ctx = info->user_ptr[0];
+	struct sk_buff *rsp;
+	int ret = 0;
+
+	ret = ulp_ddp_prepare_context(ctx, ULP_DDP_CMD_STATS_GET);
+	if (ret)
+		return ret;
+
+	rsp = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_STATS_GET), GFP_KERNEL);
+	if (!rsp)
+		return -EMSGSIZE;
+
+	ret = ulp_ddp_write_reply(rsp, ctx, ULP_DDP_CMD_STATS_GET, info);
+	if (ret)
+		goto err_rsp;
+
+	return genlmsg_reply(rsp, info);
+
+err_rsp:
+	nlmsg_free(rsp);
+	return ret;
+}
+
+static int __init ulp_ddp_init(void)
+{
+	return genl_register_family(&ulp_ddp_nl_family);
+}
+
+subsys_initcall(ulp_ddp_init);
-- 
2.34.1


