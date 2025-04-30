Return-Path: <netdev+bounces-186978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB5AAA4625
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A783B1293
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 08:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F6F21CC56;
	Wed, 30 Apr 2025 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XUhFU3nK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578ED21CC59
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003532; cv=fail; b=GvbjatSeFxgFG+5MZYIYnMrYbaqHH4SPYP+/MQppS+twYzk6hzY0GE1GdmKRXlc2fi14bDJKVqiM8oILHnSYOGzuRO55LwH36EeZXTq/4/NF6FFOmfVDjhgPDQYyk84yy4hjbnNQMqW6rzWJ7lYAEkKr417O6BNdhTsvRenZiCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003532; c=relaxed/simple;
	bh=SRZsL6G/1BeEZTLvuE+wB/MJA8zdZsOxfMR9pqGjLz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ItAgi8QVICETtXS1vJwkIiYLDKtkYWLMOtEYm3L6QMDabHTkqmvC9T2UP1lWKwkTTAeaHhez0+ZJqWZdxQngmsddnN6yl195+RMHtu5Q+uaNYwMqTX+uUvpm9DEd7WX6aQ+ESr5MZLORbuU6r4BtFRkp8oVXNzLMmkv+LGK1gkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XUhFU3nK; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xfrrv0XhsHVgXbypuWT33FGYBGQSVIcuv2UByq3EhOU1kKX6bEVTu4zpt994lJfBHKzxbyWwaefwxGAj2Gk2T7IwmdA//20TPRiZtdmiDYWrWRX2XrwNdHlDmf/pIEBsV/x3CjVHrZGmOInUGiohE17Kaw0NXWQBrvQxYb0CpI+6bqeRGeGE6leF8ZgI9rDRji+yuw86YmwvR3oK13Q7snLU5mFC4qBfEIX3FvSp5cy7UE3EuxBicEEqCm+QEWN+ZLlR7ThqvU44BB6dGMFaPREcgmFaxg/d186QWtZy7V7OXxuSM0qHg8K7dKkHYflI8rohEtVDzYTYcB7LQZqTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgFGaMklFEooTwq2CVrOnEYuWoS4b6SIcViklMDPSc8=;
 b=g/wjLb26SLEhWOI7q4JH+wLpsrqy9taMT3qUZ0Cxo3HRSWB8qeCUwg0zMfyDS5dAIx5K1EtO6QJwVreZ650HscZkItDoHEIGFCun1/QP6giBvd8jo3lB/xic1u7LUJsC0AcZIjolao1j6yHOSojQ0i90OdXj5BV/LMLzM2XCLUZmiSWsLrbUySJEpgaAro5/2FtiCF+y0x4tbaQ9ay79ak4i2PfNEWtT/aG/5pcGpY7zftQ3m8oSUcCRqqJtyfqOIwWajeE69DwDzOQappUlxRZRNXwXEpmnbQAbJ8hmOy9gCdJFSRbzjuOT0ZzfqL1gKV0640Exx2AyISJi5tWpdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgFGaMklFEooTwq2CVrOnEYuWoS4b6SIcViklMDPSc8=;
 b=XUhFU3nKOIrYdW83WWY4WgPLeI4l62eTbKXPxdX9HUW3A3811bo2K1azSEvr61ioQST+63FBpKjWdePErLcL8X0qlE6DhE683Y1suSjmjPZZOCd1KZf1EW3jU12H1Dk2QEHtKc5gDoDVxZEQV5/jNJ6UKrx68RzWBjQ6iOwNYwC0QERWQU7bFDAzKXRBAoYN551hCvlVXB6As28j3t1rJYxGeVChWrqh9LHJGuPfcPKRgUocirrf9EzRE+fVdGTGPa/02S30Y9TZrvXLPIACbvjkLF9KAQ/wHpz9nzfIBCkQee6zYYcR9wekePLw/Aka3UqBPSwSNRpc2jGTqnN1YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 30 Apr
 2025 08:58:46 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 08:58:46 +0000
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
Cc: Or Gerlitz <ogerlitz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v28 11/20] net/mlx5e: Refactor ico sq polling to get budget
Date: Wed, 30 Apr 2025 08:57:32 +0000
Message-Id: <20250430085741.5108-12-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430085741.5108-1-aaptel@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d400fa-4460-4c5d-4ff3-08dd87c5372a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jowJj2kaIYqObGhUSs902y/QNZsee0y8hvqLD0U+GSsu/yW1TomJwC/V5p1f?=
 =?us-ascii?Q?605JLAMiiUmVWL8kWMD4Hodz4oJ8zjOSnRC6R897g6n/j2nkDYRlHza/yK/t?=
 =?us-ascii?Q?j60ZO36Wca4bjr5B9BPKaURzqu0GUtNrVbHlORNAjcXLibqmtZRmfmyixNj2?=
 =?us-ascii?Q?rQKrM8M25HdWrD2l3fQgl9BkN4+LG8oWJhzqsSYy6esPzLwmo9q3GPyrpnWN?=
 =?us-ascii?Q?1zHO4VnniITPlEorD9ENICOxOPDZOvv+jxxyCzaKaHtoe3EjHiws5Q/pLEVu?=
 =?us-ascii?Q?xQ+NbVAFjx+b5ZZzRdX2wnET1IbJMiFfhUFhXghMZum2qu4oTl3SWi14Tkpz?=
 =?us-ascii?Q?IOmW+pITWVGTYJWXtH0bqNU4W20XN35Fb7RYX4AQcAz7OBqF+HoGaznHZCjx?=
 =?us-ascii?Q?SKzZVqb6O13dvENFCn7H9ULXWhjeBcR7sH+2yaQoBCm/BIZJl4DvYoyABWPo?=
 =?us-ascii?Q?wouuqRZo6nQ2XE8XQZzMaCtteQRvSxQBBWlcJEVbLJqmmFwL7rcl3PBLeSL1?=
 =?us-ascii?Q?4+stq1lPZHEh//mOX+79MXCoKL22YvdVwQ5tR2be0s83DuwJpftGt6uyDKj/?=
 =?us-ascii?Q?Y4RdL9GNtg7g2IlA0k/o05SkQD/jnx6Fk52KZpBkui71An3RwdR3qqEf+qZ7?=
 =?us-ascii?Q?vUkeN1spb9pQAEwaaLjPf8lM1DTTqWX3O3otX1Fow0sCIpEk6bPKZT32bqSZ?=
 =?us-ascii?Q?db9Nk19ltBF5EmUfSRbamDop/c/bKw7qhUmr7HjrU4G2t1p4jibjGtdpzUpH?=
 =?us-ascii?Q?bzmC7oAq9sodJ6Q0gyXmKtrRiIk0AMSicPFlguT9cND/Vo+Xtj0Zilwuj7fK?=
 =?us-ascii?Q?3Gi9g2oQanlpMtHyE5sjWfUb042hiXm/wly95YsiFu2BKq5nnU+uzZLSpLH2?=
 =?us-ascii?Q?LoTDeV5qPgxHIHBbkueJHm4aFb9O3JRFqOjLY1KljjPQrBbt6s/pCpgaWTtD?=
 =?us-ascii?Q?cEa/LLSPjBPqRKrhkOkc1tIR7Dri1mRoTxa4PPzpD3fb2EwEk887TmKSVOhl?=
 =?us-ascii?Q?b2VcxzxkYYKkNkV1v0LRiQRcYY07+NUZawzckgeMokOCq00pVDuNgzaO9BZI?=
 =?us-ascii?Q?wuP6tiOXXmiSGwZ3uAtMAw2UjiNUpGQEdwMdFQ1ny7Bq6UtFck6FqZ+tP7fh?=
 =?us-ascii?Q?dQ0XzKZC22uS/J2M690Tu5d0exjOPllFoYZEMIfQ+grhzQfsZ/Rgq6ZwYexc?=
 =?us-ascii?Q?TmQaFKetcl+mmaMN/fcVpxXlZR5b5+nb+n53D2UbR7RMgDVjWIJ51AR+qDTu?=
 =?us-ascii?Q?8Hw5eDY331yZldVB3HA0LZg9gxVipwQ79DqNTBog9kVBYkbYAdRZiXmLCZJk?=
 =?us-ascii?Q?Pbx1FvupHwjvXjxAYStODPaAYpD3lRu5+zvMNpWxuvjjC47RDYAyJrpDsLT3?=
 =?us-ascii?Q?zyVnbeCr9XBggdoQn7EGRYK0pSxh4eVepzernlcGAiIAceL8gJpku2eizPb4?=
 =?us-ascii?Q?T1QWyvpCsUQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k4r0Ssz4vFuBnM8AVxtyelmpdZ5qjRwZko3NheCoUmBZob7nslfRY1whAyfj?=
 =?us-ascii?Q?m+p73/YEZzUv2mhBndpHJUcx6McdfAVNRiXfD42QptQvgsbXyfhjmwB6Q4I0?=
 =?us-ascii?Q?N+1Jasx+YLr7B4/VjwtLHaYP0CHNmYfUcuWrzxg0W4UWQ55e+jLuK1jnUcLs?=
 =?us-ascii?Q?Ji9RZ3Hz0yfupkt6WSLd187RMPyZxfoIt+AF2EyC1YbbiMVi8RX1fmsDDqwC?=
 =?us-ascii?Q?DY+uU88WjZot2IiGHBt7+nX/dW0eyzBDUZxHOAA5c2V6uqQYYTovuU1dD7Lr?=
 =?us-ascii?Q?yskV+j4ecJGeNQVn6Rrbpv5KnH5Y8iu9XlnQWC1Y1FMZEXqIvBpXpUJXGL8W?=
 =?us-ascii?Q?a746qgB6PWCRtzdRDC4Lv7KB/PYKyVIuSrERnjfbaxJ1+4rzmozkuj2SUPHh?=
 =?us-ascii?Q?5GrksyS3cLFfiC4zhh7e2RNbysUhgftdBPtynZ7WI9xvigckYvIcJL4YQzEW?=
 =?us-ascii?Q?Z3HmLXnSLaLGFRxDPZmSOVIEzSXbV4GdFlRYVJjWsbU4bShRny+8LGREwy//?=
 =?us-ascii?Q?wwskfovRIx0Cc8cmAhQ8ofa9sARXhUhOIWwi8koAH06QUr119Dq1d9ijP7iG?=
 =?us-ascii?Q?t+s7QjSkIbGD+bWGfRh8daP7rSVK7FsNH9d5x3jkAeznVm6TI8UDgyd4TWOa?=
 =?us-ascii?Q?snAw/vbPI4YA6UYmOyg2tcS7tGdjscANXeIOpcUBkHzO7jGMMfjZp8qbDRRj?=
 =?us-ascii?Q?bJtOooUwKY9hOTWhTaHztQClTMTS6gYR1iDLsiwxWvJ+sKVmMavc58prF+BP?=
 =?us-ascii?Q?gb/MbTLlGqqOsjV6BJmLdyb3VPYnbg/CC1Pv8JnI6lBCb7RECEE/CoTgDvmU?=
 =?us-ascii?Q?e5h4XMY6aU8d0RAzzrHXHrBJMtfNToLxTswH+HLS/n1NQRzVECbOMkVjOAYa?=
 =?us-ascii?Q?hvW5di0HkQrTzEWJW4VAX1nLwDowILzitBkokUmPd2p42ji2Frh0+QJJvmSR?=
 =?us-ascii?Q?O13Sb/nnaE1g3Y2Wej91+OOpjQg/Mc3KpYMZjrqYDUO+nJN52LSrQlCpu6Hy?=
 =?us-ascii?Q?I/wH9mEvs4Bd5I4h8lZJ8fC3ELgl2Cg3v+9Uq232wI6SOLZ8O/bqSqt3CXHt?=
 =?us-ascii?Q?FrTK9//U52+9JepAkLyz2DP6fa4RO2tmxVtOAvvm7gDxhGbezoPGYxmSFeTg?=
 =?us-ascii?Q?ojaOaUy6Kxptpy1HCz8n72pQ59kqQsTiO+e/8XdzOTOBBxor3epYCTXOWVIc?=
 =?us-ascii?Q?2XMoF+NG7qsmbYFiocbASL4r7hwqs/aI8Y9TPji9DxUuheITgIMp58QDxhwY?=
 =?us-ascii?Q?KJgm98dE0ynXo4Xg2MbTZa48egM/+SGkv4ts++ts2ZYXPjoponTGD3FypYSK?=
 =?us-ascii?Q?KALUfYAiRyCTQKRB3wgwGfQ6I79KPg5wemkxmUWh63lSNJ5oz11eg3Te7ULw?=
 =?us-ascii?Q?innOJEmNwubccVmb3rShdopAkOrHpU5Kdr89NTbihqaE1mwP8cpXekZ4jhN+?=
 =?us-ascii?Q?W7KB5lbjPhVb97OihxvfgS8xXjkHOQmbWo4Uhxrw1KxkmIS97i/Y/bxFEB0B?=
 =?us-ascii?Q?+cxQBzRn9uJXAE0oNac/2sR31sbpofsHsle5fABrlVsRWXUai0M2g7dSkDwo?=
 =?us-ascii?Q?8a3vGhgRkKtozCtL3RTg9DdopqxqCN97eL3271kk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d400fa-4460-4c5d-4ff3-08dd87c5372a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:58:46.1615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trHasftbAodpOG36lqrLMv0zt3k0yCUFfB6KWWibRGqa5Hb45A2/elyJCM6bcctWEXbLFAdx3L99FDOzU4Vxsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319

From: Or Gerlitz <ogerlitz@nvidia.com>

The mlx5e driver uses ICO SQs for internal control operations which
are not visible to the network stack, such as UMR mapping for striding
RQ (MPWQ) and etc more cases.

The upcoming nvmeotcp offload uses ico sq for umr mapping as part of the
offload. As a pre-step for nvmeotcp ico sqs which have their own napi and
need to comply with budget, add the budget as parameter to the polling of
cqs related to ico sqs.

The polling already stops after a limit is reached, so just have the
caller to provide this limit as the budget.

Additionally, we move the mdev pointer directly on the icosq structure.
This provides better separation between channels to ICO SQs for use-cases
where they are not tightly coupled (such as the upcoming nvmeotcp code).

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h             | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h        | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        | 5 ++---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c          | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c        | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 32ed4963b8ad..d87ab31dd0af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -546,6 +546,7 @@ struct mlx5e_icosq {
 	/* control path */
 	struct mlx5_wq_ctrl        wq_ctrl;
 	struct mlx5e_channel      *channel;
+	struct mlx5_core_dev      *mdev;
 
 	struct work_struct         recover_work;
 } ____cacheline_aligned_in_smp;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index e75759533ae0..89807aaa870d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -46,7 +46,7 @@ static int mlx5e_query_rq_state(struct mlx5_core_dev *dev, u32 rqn, u8 *state)
 
 static int mlx5e_wait_for_icosq_flush(struct mlx5e_icosq *icosq)
 {
-	struct mlx5_core_dev *dev = icosq->channel->mdev;
+	struct mlx5_core_dev *dev = icosq->mdev;
 	unsigned long exp_time;
 
 	exp_time = jiffies + msecs_to_jiffies(mlx5_tout_ms(dev, FLUSH_ON_ERROR));
@@ -91,7 +91,7 @@ static int mlx5e_rx_reporter_err_icosq_cqe_recover(void *ctx)
 	rq = &icosq->channel->rq;
 	if (test_bit(MLX5E_RQ_STATE_ENABLED, &icosq->channel->xskrq.state))
 		xskrq = &icosq->channel->xskrq;
-	mdev = icosq->channel->mdev;
+	mdev = icosq->mdev;
 	dev = icosq->channel->netdev;
 	err = mlx5_core_query_sq_state(mdev, icosq->sqn, &state);
 	if (err) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index e837c21d3d21..0d31d012954d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -83,7 +83,7 @@ void mlx5e_trigger_irq(struct mlx5e_icosq *sq);
 void mlx5e_completion_event(struct mlx5_core_cq *mcq, struct mlx5_eqe *eqe);
 void mlx5e_cq_error_event(struct mlx5_core_cq *mcq, enum mlx5_event event);
 int mlx5e_napi_poll(struct napi_struct *napi, int budget);
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq);
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget);
 
 /* RX */
 INDIRECT_CALLABLE_DECLARE(bool mlx5e_post_rx_wqes(struct mlx5e_rq *rq));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 3506024c2453..de25401547d2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1539,6 +1539,7 @@ static int mlx5e_alloc_icosq(struct mlx5e_channel *c,
 	int err;
 
 	sq->channel   = c;
+	sq->mdev      = mdev;
 	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
 	sq->reserved_room = param->stop_room;
 
@@ -1997,11 +1998,9 @@ void mlx5e_deactivate_icosq(struct mlx5e_icosq *icosq)
 
 static void mlx5e_close_icosq(struct mlx5e_icosq *sq)
 {
-	struct mlx5e_channel *c = sq->channel;
-
 	if (sq->ktls_resync)
 		mlx5e_ktls_rx_resync_destroy_resp_list(sq->ktls_resync);
-	mlx5e_destroy_sq(c->mdev, sq->sqn);
+	mlx5e_destroy_sq(sq->mdev, sq->sqn);
 	mlx5e_free_icosq_descs(sq);
 	mlx5e_free_icosq(sq);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 5fd70b4d55be..c4c612ab62c4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -988,7 +988,7 @@ static void mlx5e_handle_shampo_hd_umr(struct mlx5e_shampo_umr umr,
 	mlx5e_shampo_fill_umr(rq, umr.len);
 }
 
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 {
 	struct mlx5e_icosq *sq = container_of(cq, struct mlx5e_icosq, cq);
 	struct mlx5_cqe64 *cqe;
@@ -1063,7 +1063,7 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
 						 wi->wqe_type);
 			}
 		} while (!last_wqe);
-	} while ((++i < MLX5E_TX_CQ_POLL_BUDGET) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
+	} while ((++i < budget) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
 
 	sq->cc = sqcc;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 76108299ea57..af0ae65cb87c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -179,8 +179,8 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 
 	busy |= work_done == budget;
 
-	mlx5e_poll_ico_cq(&c->icosq.cq);
-	if (mlx5e_poll_ico_cq(&c->async_icosq.cq))
+	mlx5e_poll_ico_cq(&c->icosq.cq, MLX5E_TX_CQ_POLL_BUDGET);
+	if (mlx5e_poll_ico_cq(&c->async_icosq.cq, MLX5E_TX_CQ_POLL_BUDGET))
 		/* Don't clear the flag if nothing was polled to prevent
 		 * queueing more WQEs and overflowing the async ICOSQ.
 		 */
-- 
2.34.1


