Return-Path: <netdev+bounces-168445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DDFA3F106
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22487188FDEB
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971F820458B;
	Fri, 21 Feb 2025 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kn46J++Z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C981FF1CB
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131607; cv=fail; b=ofyFW2zS5VizvfZejD4KkmgkLzfmG9yBGEKruEZJVOov4RNsn4zG/vAxSq42gFT3Q17ZNQ5vNeNo6s8EiUju3IcxDApivaO8H0QG+5FrlMc9BhiYpr0+5RFTNFd7lVHs1DvPw3f6Ra4yAW+GUfQokxb9WinhFxkA+DxZJhEC6D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131607; c=relaxed/simple;
	bh=/WPCdil5wHES8/ZKJ3tqTujVwbuMP+gduSQ5Votf7DI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UZd4e8PkuVCT2+mEp5IOYQVyGyTWgDWUtI9YhME4dxZEJchR+fWR3a/IbgHeaJjYQcep8eqLv+0GEtY4Sp4H7S4+8K707RrQtriTvv98w+2UWmooWRzEHXOVyRPX4eQ1dGAEiflbLTrUdtGdWFnWKNrw74y6tgPGTwZgLvzg95o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kn46J++Z; arc=fail smtp.client-ip=40.107.100.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZbqJHYY3AOHDReXgXkM03wspBFTxdGLSa7W73A85X8eB7zQx6BXjEhw28F5tJDuVbMt9SOTgET0aQfgam+nrdx3enlIPS7VCxKtVKoLCUNVvApHXnXzpgIn6V27M3gQkoCYQEwYcVLPn70T+J1UkZ3WhlkdJkQt4SrcnSW/ayM00qCLVjhC0QY+ejr51MRoqIAXDONhmWLz2mvbS18oWa3wvW4HRYH+krS2fh1YLkdVgoh/bebQfUhFiQLIPfnKnvb2TLQuN/l0HacpCHd1iT1/2ZDs40JyP4SdrC4XbZzgVJntNOOZotHdCz3bFW2GgSpnEwB//fiC9L/rGLINFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AUDmn4b6z4ja6b1LkqVDWdFFABcmaXLEHlYdNONdW0=;
 b=eIf5FGee68Nl1yZoR4sI4JYeSG7hLiG7DueS6qw910Tm83XJdrPCqCRrEdIRz3XqGSJcF8PnSJdRtyAaYj2aIGIJlSgcZBWg0CEIuwL+fzhkm7PWhkZllh2PMes23i9ai6NyJdqu7cWVVrrUyYBCkGOhFDxvA4lCd4CtnaVNJKLvii3PjT2r59DGkJSpfbcOcT6KXKdmyyNaWeOnKCvaq1i7tfjzv34CFxYRz1yQrd7cbHAZ6ql0u45prdYiyI+sGgSBOJPhnhp4gJHO2MR28Dch2lvaGk4P82GEp33agdZxgtWi6sINVJIcmg9lk5So3CALeCjlYUiJM4agZfURfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AUDmn4b6z4ja6b1LkqVDWdFFABcmaXLEHlYdNONdW0=;
 b=kn46J++ZofVWGDU8YM0+GepDUlofKoyBrsr5Fihj9Q6pDYngk01Qowg5vDEx87AbKnAEKGuddkDet9tlgZHapmHgknf1gZTuwSrtpJcHzli5Rm0GOyeHEZtUmPmsg7IO/mDTCpCMnrjm1+rhsRvWCj4Xv+0CtHVUwBbUklbXa//tQy7ds1lh/80cmyYFesCgSmyBB6zqs5mHRdL1jqPYVluuwjoeiXCMskUZKFzfm66qQQhr/xQAT2JZeCrHd0CGI5i3P79qFh47TzKMjt/Oamh8l1mf4oNP7V/5L28pvyOM8Xa3lQwSzsNEJ03FLm0L578ACP4ms/6aSl498HFNLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:53:20 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:53:20 +0000
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
Cc: Yoray Zack <yorayz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v26 07/20] nvme-tcp: RX DDGST offload
Date: Fri, 21 Feb 2025 09:52:12 +0000
Message-Id: <20250221095225.2159-8-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221095225.2159-1-aaptel@nvidia.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0472.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::9) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: 63cea582-6383-4c4b-4dfe-08dd525d9289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iG7DGLagfvw0aMtBx7ojdNYEbjuFL4zbqRoubO32NV9F/LGZ4o3+fZ7MUDiJ?=
 =?us-ascii?Q?AKyPj34aBbSF94nvMHMosjEA+xsrzSsw1WzINWWm9OL1NHvlwhh/sRQJVCGh?=
 =?us-ascii?Q?E1kr+6sNUmheXby1zVZB9wHiDqx+iuEqCa641Lkf5W3AsleY3090PFv3Zv97?=
 =?us-ascii?Q?TA2b9rcSdmkDLChVTxUnC+I+NmLM868f4OreCriGSFUk/yq2xMFGuutIoR4O?=
 =?us-ascii?Q?GuAuxbmqaDhGNqULreo3xO7GRrbHstzAFoOSfgeSHbGvwHO4mRkuaLH2dgMj?=
 =?us-ascii?Q?7yY3+H/3yj3uiAQLRdN3QdPS3Hs2JkFw82OiGETeQv5JXvOSDs4/dBgBb7mf?=
 =?us-ascii?Q?VQG+YH+IPZXaqSxuxtfPM8WUGCN4agEJ8wXbLOEw0Dw3AtqufcjEjnd2xtZw?=
 =?us-ascii?Q?yXJeHRh7Oo8pWHvLhT0v/9QeXBqFHOjbY1oDJraygQ3q0pv2ZbBekPUgefvB?=
 =?us-ascii?Q?Tbj8HUZfRInfPi7DnI8L+sUHagtKHAXXpg6txiO3asiXp4WVpi338FYPf/rA?=
 =?us-ascii?Q?iGs+S6RmT58Ku490Bnu/IF0voB2oXhpSz+BsIVqKs3THtZKR94Iv6DpKUD10?=
 =?us-ascii?Q?V1q5A5jq4Bx8ifQ+oZBlX4ya5tNaeLk+J9h2lMV1sjoB7RLq3Ecbgcle7+fh?=
 =?us-ascii?Q?M/N9ZYVJhdYfhVQbNSwFtbZFd3sDQP5g6uGBi2nkaXCsKCaStCwDKA1pajxM?=
 =?us-ascii?Q?Xgqa9K+aFkp7q1LjM91w5TS6Eh+g7FvxSJCrYhO8B6augPciAQHAXX+YaD+9?=
 =?us-ascii?Q?hL25azIuHKr+gXIxV7dTv/6LaZ3BuMliw/u+JS27MibH8YTgSs4uMD0k/Qyc?=
 =?us-ascii?Q?jTfEefmyUQwkp9EDQDfC1jQ+eJoetbegohbeoAFnYq7TH0KqxIFzUx7eYifi?=
 =?us-ascii?Q?liBdv789boTBNvt0Jw7amjmwfHng711Cg9bPMsuUpXZ4D9/4lsGMAl5ykTIS?=
 =?us-ascii?Q?Xn+xr00i6/4dX1sWruK5YPKHaZ49WKiveP43UbYwZdhELuAwkFjNTVYXj8sZ?=
 =?us-ascii?Q?EZSjqnR5RvwqB3kbv8ytAefS8oSnb3VbAgw5Cnb9mW+nfIkFEkRW4tSnWWCZ?=
 =?us-ascii?Q?goIEq82yveAaDrX9Zwuf9wff6HsirACIzy3Sluer+cS+BrxDKe4r3NlaAozH?=
 =?us-ascii?Q?HOHb61CXgeM5xPsv00nRd4MeR7qbn1gcgiNWPMYU5qP/LFEX6s2ueWJBnqBI?=
 =?us-ascii?Q?wzNTeXq0SIhRg9n2OjHeX5zzVfj3+ZesVin8oPkU/xIiJgDm9b6MgRgET8cd?=
 =?us-ascii?Q?8bm35Vuywc3hTVmF6dODWVXQjA9xLsP9QT0jdX5fKZdhXTskXDkz2Of3TSmj?=
 =?us-ascii?Q?POeK17d6/XmNG9TwarNt3Js5hngPWVAg6xUypU0pDJMZtnD2lq5fLIRMMW4U?=
 =?us-ascii?Q?DJeuvLEbdbzKhwWb4u4cf3nZKL8f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DLUaqDGNoAdBSQdkYZrZ2M64ZaHuW4RemTu7B0QRPs5/Quuqrt2yJyIlxM3q?=
 =?us-ascii?Q?TBHJuQGzo1fVqspWb4c1g0x2DH2JZqurdaY6EpJma1ofT0DOXc0WHybTBKNo?=
 =?us-ascii?Q?PD+7MhuRzhNuuygcr/wFUOyUGCBiK5Pgew0qZ+afh1f1Av3nFCbX5kyKabE5?=
 =?us-ascii?Q?ztzC5Q4B1z69pET9TPDqJlEKhNTBpFcyPs8OYPd7AvfCqsuh7T9Bo+Czb7Dl?=
 =?us-ascii?Q?w27I260NQTqH97aP/P4EzFEePD324XstETde3rEdA7y4jbaqyOz1SZwa4ivk?=
 =?us-ascii?Q?1PvRkC1aoPyMmTq/bTNOney6wQSG80jBFoZwCRWTlMsN5oIyuEaPcgkTlLbd?=
 =?us-ascii?Q?JZL7grXZRdqfRuKRZhKdTnb+pYVIt/32WroTVvDPuHNXHEmcr6+TlrRIEy5T?=
 =?us-ascii?Q?MetHhXq8Ns8Ej4PQiaZenp4D3eGGrIAmSJADML3S3hgoQByHaziJUqDoszkR?=
 =?us-ascii?Q?VDF5nRW8SC/xfOmYG2auDt9r2taWz1FmhsJru1lp1eJMTIFe1qC0H5784f6T?=
 =?us-ascii?Q?LxlKTKWUF3BcnEKL9YIDg/FwujGiN3bYjneQuahZxUwQD6nswzEN5Jj6OohW?=
 =?us-ascii?Q?ytzSt+nrbnI4NzcH1YZ6uNtysHWGv4y9vpmH06t3dc4gBodB5MvJS7/50pHx?=
 =?us-ascii?Q?4QbHPLEIUOYLZwIICtTi+FwoU1s7yjjDLyIEw5VMR3s3Y5D3fFsmNQ9lvDQy?=
 =?us-ascii?Q?HJp0CpKLb7AANgAMU9v5ZSDSPjmW7UHQNE6RCLc7LWC3XvuTBoow7MdbtY8R?=
 =?us-ascii?Q?XD1a8vjN0opnHlxrSS26Din57p99XOyQuLif3ZWr4Ooe9z9WSsoaCNKuKVr1?=
 =?us-ascii?Q?/9f1tz0ikN44THhMHw7Ik3Yaw4YwSFeUiqhmbtLxXAPF+4epMMwaIerCe4yf?=
 =?us-ascii?Q?IBliqcG3Fd241on7GBFFMYcgXKj3ObghBHELXF/9uVxwqC+PLw5dxDFsu7SO?=
 =?us-ascii?Q?9T4FTFgaMKrxnneQgpTef6L4pRAxnkFTfzbtJG24ZdmB6/VonKbZTjwE85Wn?=
 =?us-ascii?Q?n068YYMbpBxkgcdWT4cT5t2Z8ynN8k/6zJ5RwNI6VN8BcNQfDjBqF24b8QJE?=
 =?us-ascii?Q?rc/N03MmvNNzE4nG1+LeQBW9JqytJ+SZCyqeDZ74PZc4j4V3KR2SRTlw6Qw/?=
 =?us-ascii?Q?Or2jf4b+7dkVkPPHQbMvQmIulqkI73YHSR/HT2ag9o5VQnJm+dafJJ2F1089?=
 =?us-ascii?Q?EXOJ6YWvEEdjy6kaODnXK5M9cQmf+yORJLGRoMCm+hI3ktY79YYjDJjdFRrs?=
 =?us-ascii?Q?WHu12MOE/QsDmZqrNx48WlhULqEljQzKPf0u726ugEKe9b4//4STx0ybTDV+?=
 =?us-ascii?Q?X6V4KiVjDuzOym9oG07OYAuxRfohIEIGkq9G6HN1MS5Nh1OPrGeC4tUbfSjz?=
 =?us-ascii?Q?a2hwuS1htUzWuywAefn8BHTPnY5o7OCICAb1+AfRFEWLtwn0eDmy1GjSJUvX?=
 =?us-ascii?Q?61CoA8gCkRVSaENiUXjJl8hmArTUKkPVRTvzT7tMrZml6HO3Tw+CNqi1Lpxr?=
 =?us-ascii?Q?jZN4ObzIEwA0WaqKBCtbkFYQ7tpMpZ/f3PaFbAsekDF4y9E6HCNQHNvV6hk4?=
 =?us-ascii?Q?RWdF5tZMG6A6rg+3V/tb9QzUpTEi8rklr384Bu1w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63cea582-6383-4c4b-4dfe-08dd525d9289
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:53:20.2009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEQhvlTMj13x3Kya1Ql6AVq9zIhPlHeQCjgb3hf7fhHnpj4EeHFd74vMTCBbyEhHz3WTJc7T/kNtYUdn3kZ4lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127

From: Yoray Zack <yorayz@nvidia.com>

Enable rx side of DDGST offload when supported.

At the end of the capsule, check if all the skb bits are on, and if not
recalculate the DDGST in SW and check it.

Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 96 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 91 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c16b8f9fad57..3037c6480f56 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -153,6 +153,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_IO_CPU_SET	= 3,
 	NVME_TCP_Q_OFF_DDP	= 4,
+	NVME_TCP_Q_OFF_DDGST_RX = 5,
 };
 
 enum nvme_tcp_recv_state {
@@ -190,6 +191,7 @@ struct nvme_tcp_queue {
 	 *   is pending (ULP_DDP_RESYNC_PENDING).
 	 */
 	atomic64_t		resync_tcp_seq;
+	bool			ddp_ddgst_valid;
 #endif
 
 	/* send state */
@@ -420,6 +422,46 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 	return NULL;
 }
 
+static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
+{
+	return queue->ddp_ddgst_valid;
+}
+
+static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
+					     struct sk_buff *skb)
+{
+	if (queue->ddp_ddgst_valid)
+		queue->ddp_ddgst_valid = skb_is_ulp_crc(skb);
+}
+
+static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
+				      struct request *rq,
+				      __le32 *ddgst)
+{
+	struct nvme_tcp_request *req;
+
+	req = blk_mq_rq_to_pdu(rq);
+	if (!req->offloaded) {
+		/* if we have DDGST_RX offload but DDP was skipped
+		 * because it's under the min IO threshold then the
+		 * request won't have an SGL, so we need to make it
+		 * here
+		 */
+		if (nvme_tcp_ddp_alloc_sgl(req, rq))
+			return;
+	}
+
+	ahash_request_set_crypt(hash, req->ddp.sg_table.sgl, (u8 *)ddgst,
+				req->data_len);
+	crypto_ahash_digest(hash);
+	if (!req->offloaded) {
+		/* without DDP, ddp_teardown() won't be called, so
+		 * free the table here
+		 */
+		sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+	}
+}
+
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
 static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
 static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
@@ -506,6 +548,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 		return ret;
 
 	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	if (queue->data_digest &&
+	    ulp_ddp_is_cap_active(queue->ctrl->ddp_netdev,
+				  ULP_DDP_CAP_NVME_TCP_DDGST_RX))
+		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 
 	return 0;
 }
@@ -513,6 +559,7 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {
 	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 	ulp_ddp_sk_del(queue->ctrl->ddp_netdev, queue->sock->sk);
 }
 
@@ -621,6 +668,20 @@ static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
 				     struct sk_buff *skb, unsigned int offset)
 {}
 
+static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
+{
+	return false;
+}
+
+static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
+					     struct sk_buff *skb)
+{}
+
+static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
+				      struct request *rq,
+				      __le32 *ddgst)
+{}
+
 #endif
 
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
@@ -887,6 +948,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->pdu_offset = 0;
 	queue->data_remaining = -1;
 	queue->ddgst_remaining = 0;
+#ifdef CONFIG_ULP_DDP
+	queue->ddp_ddgst_valid = true;
+#endif
 }
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
@@ -1154,6 +1218,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
+
 	while (true) {
 		int recv_len, ret;
 
@@ -1182,7 +1249,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		recv_len = min_t(size_t, recv_len,
 				iov_iter_count(&req->iter));
 
-		if (queue->data_digest)
+		if (queue->data_digest &&
+		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
 				&req->iter, recv_len, queue->rcv_hash);
 		else
@@ -1224,8 +1292,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	char *ddgst = (char *)&queue->recv_ddgst;
 	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
 	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
+	struct request *rq;
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
 	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
 	if (unlikely(ret))
 		return ret;
@@ -1236,9 +1307,25 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	if (queue->ddgst_remaining)
 		return 0;
 
+	rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
+			    pdu->command_id);
+
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags)) {
+		/*
+		 * If HW successfully offloaded the digest
+		 * verification, we can skip it
+		 */
+		if (nvme_tcp_ddp_ddgst_ok(queue))
+			goto ddgst_valid;
+		/*
+		 * Otherwise we have to recalculate and verify the
+		 * digest with the software-fallback
+		 */
+		nvme_tcp_ddp_ddgst_recalc(queue->rcv_hash, rq,
+					  &queue->exp_ddgst);
+	}
+
 	if (queue->recv_ddgst != queue->exp_ddgst) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 		req->status = cpu_to_le16(NVME_SC_DATA_XFER_ERROR);
@@ -1249,9 +1336,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 			le32_to_cpu(queue->exp_ddgst));
 	}
 
+ddgst_valid:
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 		nvme_tcp_end_request(rq, le16_to_cpu(req->status));
-- 
2.34.1


