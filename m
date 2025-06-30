Return-Path: <netdev+bounces-202463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD27AEE028
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E909616CFB8
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1024328B7E1;
	Mon, 30 Jun 2025 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GaHOL139"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31B8148850
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292539; cv=fail; b=eZrCWFA4w0VklgUX4M/ibBd42JHmUAfbeI1dhTI1710CSprGDsTkb21sv7ASD4wvJuk3KCD4MtuuRAcbJdYmvK1T2fk6OFN74N06qlEJxxtKLz6wDN9Ud+xqLATtD7rkssYx8Z960klcJJigl0gGjmX6Ilidqx1vcTzlFNijFMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292539; c=relaxed/simple;
	bh=whzDAjjnUliHP2MqWCLn9csCc6FRut9RYEuTCgXEBpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T94RvtdxHuH3F5YkPQDIUoWy7Bw8+59UYYwpQvFqLoach2Sh6mldvTJbBTqpJS7vzlw0bw6nA47caenumQpZg2gvhwBiJmdNwahAb+6kvdYlbM4Pg4CVPgDb6M3j3ObiJ0MuavEWno4z1vytfUJKQpX/UEp2XcZq2a6m3vtEueU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GaHOL139; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQe2vOhgngZ8iW5l3utK2myW9Zt3/jIjyQX5R25BVxYbfXIX8/3R4uHR/q4eNSttgx1YHNVgDsrBRW2a92xAcMAt6z/mYk/yWnus3KgYNaOrU6T+TGs4gXCgz9klL8NxXI/gPr2+sMron7uhqB5bcnPYdxa0dGRCsDFger0KPhyG85F0o0Jwxki0AwG4AegwlmWu02hStgk9zlOG7PURdhq85SJ5Z9I6+/IBUjxPNGAa8jWDjxPr2IvoMv60rGcw1BOZkiq2mWlH85A75c5WbKqTwi7ZHDuvfxfdYTNFlWrZYZTBipYBOWfBiLjxQP85gfbU5UUkYauyW83NM9C9jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLnOVR+se253sIrvSH+a8Nfa1OUHZFQKvo+mymrTK+o=;
 b=PzXonM8S7hAKWM7Q1+YRsMX0jGcyY8ga/I5C8xYqqZG0T8vg77sr0S3BlVcYm2aGxSHenhU8PappcBraSJ9XuErv+vosQxTlTM6V+byI9sRCn37F2yetupVnmuYRj42JGlSGVohgam43qLlno7GAOMlGdcA7cAHqAv91gyIao/9PP5TfCuXfTWJ6JfhADSIdcgDRjPrFYyTJGJmU49v4TcLajqBWu5vTI6WwRfTGx3z0AIgg2Q2hNglj8mfTOoJ6+KI1+eUF1zabdFVttZAwqoxs7xjopXar4QeV9pwoSmlR+6GPEBmLziP7FCOF5yFx7lAh2tWhpWIlINNLG2JQRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLnOVR+se253sIrvSH+a8Nfa1OUHZFQKvo+mymrTK+o=;
 b=GaHOL139CXGS8L51/BGj4AkQNQ+n6XS8s3bGG4DC8YcLZCStx+9uDszYUu2zRhmmY4+6MGNSqnuqflrewgy9efV83/1h9gfSVVqjCSynMiTjC5oNfYuuLGC8k56LtrIEuqsCFTP6QvJHWOLtSGnlQrjcJtKFY+LiAab0+LwIt+peKZ9A+BrBJ7Cp42fRqmXgqW7qVk2QFVDvkMOmkedF8VX1U12SGfARPiWIwfB0AVTxKv7jMOD3haykUYP/15+xxpw/wRg0XZ9PJJbNyCtGoU1Vn2VCAyoYtyox2YPDXWoWP+s1YE0vQNf9AWbwmVSxIVysV+hD0RpptoLD3Bjyzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 14:08:51 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 14:08:51 +0000
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
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v29 13/20] net/mlx5e: NVMEoTCP, offload initialization
Date: Mon, 30 Jun 2025 14:07:30 +0000
Message-Id: <20250630140737.28662-14-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630140737.28662-1-aaptel@nvidia.com>
References: <20250630140737.28662-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 70737eb4-79f6-4f5a-2ed9-08ddb7dfa3f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hF1t6Q4nsdf/n8TbmpJ7+QT9uP5MJfl/9JCIUYbS//rufb9LyZQMq36g2kUp?=
 =?us-ascii?Q?8Xxp1vEuyTo6810wJxfwlkZotZNE1lhYTW5cK9zpvHyYHJ1ooAPTUjZGTBtL?=
 =?us-ascii?Q?OyIkkdr9eCNIVrHx7ov3uJwi1/N0K2BG/Bq8YaSgcjw+jvQXTtXZp1IuO5sP?=
 =?us-ascii?Q?abFlnJe/7HOLWpPPdgqBXUX5e9ZZL2+GqvZ3v8HX+uk3ZKL0lozK+bhC+TP/?=
 =?us-ascii?Q?JbXfmn71FZLErsXHVYrLzcSyOIWJGWQlVj9wpl1pDpqXzaZFdsC4zH2ysYVX?=
 =?us-ascii?Q?kj+nU4LuWYVdVNMWo8OpDMMkvvNduQGFF0BMtNDf2TQxXXmTCNQuvdYCSfq0?=
 =?us-ascii?Q?0LIISe9MjZ+gfo2/tW6VkYEwDq/QHFMA5Yvg6jdVfjEQBDi+XF+9IWc6T7dJ?=
 =?us-ascii?Q?DPZbTn2GgY8Oaf3ezXe71K9JxKoJTwm6R8SULU5ljw5AAolc2P/C0jmXj/98?=
 =?us-ascii?Q?eu0La/UmLfpHr+4ZcsBFeHLzCASUCRzePSp8Ni//jqYsPL76WiLUicDVZf+0?=
 =?us-ascii?Q?fiuFmPPjY/BMKRecQtUYqEgdxXzAV39ztbXx5SUD32yLHI5DhExJuQcc1zM1?=
 =?us-ascii?Q?n7HACuQqDn2Sk9JC7ClKOSTww3FEd0q3ySN/4+Bwrso3nC4DMrZv357vi1cy?=
 =?us-ascii?Q?TG6ZBVUIm42PxuOcqceC1i15IhaNjA28gmtkdJXaT+UK9TT92RuIvwFVOohU?=
 =?us-ascii?Q?Z7wadvv3EoLDEroFPFsn6z6JheNzbZieaz1XiAtnZbBvkJm2qywQ44B5cFNC?=
 =?us-ascii?Q?f0BCKFnyzWZDgACP7oG0L5sfDp5oT2BmSp0OYTwbnf3LPsje4GzqdjbeuCo8?=
 =?us-ascii?Q?MB6uim1iTqWWlACihzeVmixxC2cS1NAE/tPlyXuIiE42aQThs+X6D0c5WUg7?=
 =?us-ascii?Q?tSX03GY5wbizquNZazkgDVgRdexw9Er07JF4zpmx5hP1xcPDfFy0DoN98+Lb?=
 =?us-ascii?Q?KhO8B/RSkxKOabBy7oc3NipXhEdI49rkTFUZTKAO1+uQzG6pZzukxkaWTE6k?=
 =?us-ascii?Q?p8D2AuSHVNrFk5QuH2eX4JUG8WPTbe3w3/FMtROflqsM838SQbTCYCLJAepf?=
 =?us-ascii?Q?Km3O/Xz3o7583bpjjP2TMfkJDNkdJc1VmnjlRrmwZzoQBtywRqVupCA3LbKM?=
 =?us-ascii?Q?gkVzHq9wWDejeJtjcfjeV7uxoSEhvmP6vc8fnn9b0pXwv+2nAhSMvPh6IotG?=
 =?us-ascii?Q?oIKKKF/nSKS1MDLUA3g6eGJBMMcV6i/q8qawsYi1trJK/J5V6WCkNirxkeHL?=
 =?us-ascii?Q?H4gYIzWWwlOdPs4T+MgVrl+obPBel5dS5BdJThdRVyInbmukU3kX5c8vkpoD?=
 =?us-ascii?Q?T0+3zQAtu0XhRrEtlBOWIAG5djMKYepwsaxpS4KKNRzvcfCd90ZBF1KV8Wkb?=
 =?us-ascii?Q?sCroZbNvA1XNqeojAAnduCwMP9k5rti49MklbzrfpIvN19VxKHchCXxcS9XH?=
 =?us-ascii?Q?sdaLaKOZI8U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xwem8SWktR0nUFinE9LPk1roq+TMgVuiIqqUNbhKkmbTYja0mntoLYavg2gr?=
 =?us-ascii?Q?Gh8kC4eVxd/fdSQ7nm3QS39eAEHEeJYg0CUOH1r3rWn7Yu9IVb1ZFfl2pm2j?=
 =?us-ascii?Q?kbxHylxAhEWVLDlh4kEBbdCoSvHUB1Ah4WnzEjB2BpoSNBlPijxv1KhV9OPi?=
 =?us-ascii?Q?0/+6MeXzwpKBMxSdDzuJOuqeMgZDKzAyvrNJLh8/xsumAv33WnkeMVcUJEc/?=
 =?us-ascii?Q?zzShENWgoKDK87UTJt5tKwDNKVAFrUjO+XYeAOIYoNNXohsw6SgUOIZZ7pCW?=
 =?us-ascii?Q?Uyeij9FnZ4GyisHD+ckDXPcMZLNkoMxh61SHBMpq1dvi3BSKavpLUiWE6QC3?=
 =?us-ascii?Q?KMG/oSWVLCJLH3Qcu344GHnB7wFIw0NdUR3iYtQSZJQJ/S8LUHiM4mPEcvzU?=
 =?us-ascii?Q?ooAr0G5CcqGc3e1qbvRJn5OUUjyMPUb8qQ+qyNZOQ5hcI/BUsDEy9Z8ebmDy?=
 =?us-ascii?Q?btjlMfPWnrIwksG5FvEx233p++fHItWiJ2Zojq4cCpvdVAAofPlPFacuIYF4?=
 =?us-ascii?Q?Jb49Wp48HgPlPx5spAscqzyC/CbbILG15sbLn/qj3ht6x8EeWs8hjCv8Twv/?=
 =?us-ascii?Q?3mPwPAUCTQIN1QGt/W+EfiKvbwn3A8jumzR8LCYYi/scy7HdVC/xup3xIzDF?=
 =?us-ascii?Q?9lZ4F+EFjXqpmETxp94NjLwF12VZM+WGomDz+EJCKXZKzVgMD+hoSfGu3tWb?=
 =?us-ascii?Q?dMJDuJeGSaDYypLfSl5Ywwqkv1LFDukKhRN0JssYPzDL6lvw8mtAPzJpwfuf?=
 =?us-ascii?Q?/KLPfGNJ1voi/pMwibwEtaigubWaMuMOwVxgXU/MbEC+ALS61YX7BSiQKJvE?=
 =?us-ascii?Q?RX6pcupNBWpZNrsGKeeEek3HjRj0ZCSNa4aGMYGicUxTZS6iFq6cbeVyawiL?=
 =?us-ascii?Q?PcoK9glD3rPc9pHF0m/FM2FJXlVMUZYHf0tMZLBN5Poe6Vc4bHKh6oRO62Wd?=
 =?us-ascii?Q?YLgQcJuhtG+S+9SQ/Oob5BxTMbSj3ydKyi3JIKuYL2oulBpPl+i/BrBauCJk?=
 =?us-ascii?Q?0XI0dEe8TLX5650+UlH4ExWntoI7hZfKe4Fc0cg/DSxfF7B+NNTBlR664973?=
 =?us-ascii?Q?MrXcLjGUAW4uM0yGv41dHwJzJmfiXTC0xr27A4MvheD63hRsQ6P9CEeAqPQ4?=
 =?us-ascii?Q?OUotJ2hbTqCXd0TvO5Cq5ZbRwv49J37IO9nOIsetjdrk2G2SlEkNwHzFmNwe?=
 =?us-ascii?Q?qAgQIyU5NYc9iEhjHTD/rgy2qCVbYts7lTiIef+xpBWjYea+UkZTMeQr1qfO?=
 =?us-ascii?Q?+o1kd6VYnrZ0R9xNleCmBnI6cnZeQy3qW8TRvCt2osvlRxYiemdPNYDwUhW2?=
 =?us-ascii?Q?w1njOWnRdsXsfJlxKpuEgZeUombxItvRiigNjQCOc3CsiBncHvUp+IogGANy?=
 =?us-ascii?Q?BrCZNvCh5d7IW0msMv/XKKP/G+qCyxlZA7O2Ub/NUIxhI1RqlM9jmZQjqhRn?=
 =?us-ascii?Q?FVoidPefnEGCbbXYMs33hcQmDtRhNh52JHOZhu6dlENvuBZPwko9txqHkyyQ?=
 =?us-ascii?Q?Sc3OKu4y97faYvvZK9dQjW49NWx53VYMJLY6pO0BEyA5uxxMaVUzpvpecBpj?=
 =?us-ascii?Q?D6WU4WAqQu6MeVfaNv5N4NVyO6TP56kRjJfkgdZQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70737eb4-79f6-4f5a-2ed9-08ddb7dfa3f0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:08:51.6120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MF8w9xtEM72tGzXCjHhlPOEhwREIOJ31Vnn3NLyRzVKoxYTAPiawcEMRmYQ6aU57lH5qC1A/vUkJsvzBe+OMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

From: Ben Ben-Ishay <benishay@nvidia.com>

This commit introduces the driver structures and initialization blocks
for NVMEoTCP offload. The mlx5 nvmeotcp structures are:

- queue (mlx5e_nvmeotcp_queue) - pairs 1:1 with nvmeotcp driver queues and
  deals with the offloading parts. The mlx5e queue is accessed in the ddp
  ops: initialized on sk_add, used in ddp setup,teardown,resync and in the
  fast path when dealing with packets, destroyed in the sk_del op.

- queue entry (nvmeotcp_queue_entry) - pairs 1:1 with offloaded IO from
  that queue. Keeps pointers to the SG elements describing the buffers
  used for the IO and the ddp context of it.

- queue handler (mlx5e_nvmeotcp_queue_handler) - we use icosq per NVME-TCP
  queue for UMR mapping as part of the ddp offload. Those dedicated SQs are
  unique in the sense that they are driven directly by the NVME-TCP layer
  to submit and invalidate ddp requests.
  Since the life-cycle of these icosqs is not tied to the channels, we
  create dedicated napi contexts for polling them such that channels can be
  re-created during offloading. The queue handler has pointer to the cq
  associated with the queue's sq and napi context.

- main offload context (mlx5e_nvmeotcp) - has ida and hash table instances.
  Each offloaded queue gets an ID from the ida instance and the <id, queue>
  pairs are kept in the hash table. The id is programmed as flow tag to be
  set by HW on the completion (cqe) of all packets related to this queue
  (by 5-tuple steering). The fast path which deals with packets uses the
  flow tag to access the hash table and retrieve the queue for the
  processing.

We query nvmeotcp capabilities to see if the offload can be supported and
use 128B CQEs when this happens. By default, the offload is off but can
be enabled with `ethtool --ulp-ddp <device> nvme-tcp-ddp on`.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |  11 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   4 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |  13 +-
 .../ethernet/mellanox/mlx5/core/en/params.h   |   3 +
 .../mellanox/mlx5/core/en_accel/en_accel.h    |   3 +
 .../mellanox/mlx5/core/en_accel/fs_tcp.h      |   2 +-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 228 ++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    | 125 ++++++++++
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   6 +
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  17 ++
 .../net/ethernet/mellanox/mlx5/core/main.c    |   1 +
 14 files changed, 414 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
index 6ec7d6e0181d..8e64ec593725 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
@@ -165,6 +165,17 @@ config MLX5_EN_TLS
 	help
 	Build support for TLS cryptography-offload acceleration in the NIC.
 
+config MLX5_EN_NVMEOTCP
+	bool "NVMEoTCP acceleration"
+	depends on ULP_DDP
+	depends on MLX5_CORE_EN
+	default y
+	help
+	Build support for NVMEoTCP acceleration in the NIC.
+	This includes Direct Data Placement and CRC offload.
+	Note: Support for hardware with this capability needs to be selected
+	for this option to become available.
+
 config MLX5_SW_STEERING
 	bool "Mellanox Technologies software-managed steering"
 	depends on MLX5_CORE_EN && MLX5_ESWITCH
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index d292e6a9e22c..7e01096bdde0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -110,6 +110,8 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
+mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o
+
 #
 # SW Steering
 #
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 95cb1bd0403c..6a4adfb3ea59 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -312,6 +312,7 @@ struct mlx5e_params {
 	int hard_mtu;
 	bool ptp_rx;
 	__be32 terminate_lkey_be;
+	bool nvmeotcp;
 };
 
 static inline u8 mlx5e_get_dcb_num_tc(struct mlx5e_params *params)
@@ -937,6 +938,9 @@ struct mlx5e_priv {
 #endif
 #ifdef CONFIG_MLX5_EN_TLS
 	struct mlx5e_tls          *tls;
+#endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	struct mlx5e_nvmeotcp      *nvmeotcp;
 #endif
 	struct devlink_health_reporter *tx_reporter;
 	struct devlink_health_reporter *rx_reporter;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index b5c3a2a9d2a5..88b1d01f6c19 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -77,7 +77,7 @@ enum {
 	MLX5E_INNER_TTC_FT_LEVEL,
 	MLX5E_FS_TT_UDP_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
 	MLX5E_FS_TT_ANY_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 	MLX5E_ACCEL_FS_TCP_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
 #endif
 #ifdef CONFIG_MLX5_EN_ARFS
@@ -182,7 +182,7 @@ struct mlx5e_fs_any *mlx5e_fs_get_any(struct mlx5e_flow_steering *fs);
 void mlx5e_fs_set_any(struct mlx5e_flow_steering *fs, struct mlx5e_fs_any *any);
 struct mlx5e_fs_udp *mlx5e_fs_get_udp(struct mlx5e_flow_steering *fs);
 void mlx5e_fs_set_udp(struct mlx5e_flow_steering *fs, struct mlx5e_fs_udp *udp);
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 struct mlx5e_accel_fs_tcp *mlx5e_fs_get_accel_tcp(struct mlx5e_flow_steering *fs);
 void mlx5e_fs_set_accel_tcp(struct mlx5e_flow_steering *fs, struct mlx5e_accel_fs_tcp *accel_tcp);
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index fc945bce933a..6d74f89462d4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -826,7 +826,8 @@ static void mlx5e_build_common_cq_param(struct mlx5_core_dev *mdev,
 	void *cqc = param->cqc;
 
 	MLX5_SET(cqc, cqc, uar_page, mdev->priv.uar->index);
-	if (MLX5_CAP_GEN(mdev, cqe_128_always) && cache_line_size() >= 128)
+	if (MLX5_CAP_GEN(mdev, cqe_128_always) &&
+	    (cache_line_size() >= 128 || param->force_cqe128))
 		MLX5_SET(cqc, cqc, cqe_sz, CQE_STRIDE_128_PAD);
 }
 
@@ -857,6 +858,10 @@ static void mlx5e_build_rx_cq_param(struct mlx5_core_dev *mdev,
 	void *cqc = param->cqc;
 	u8 log_cq_size;
 
+	/* nvme-tcp offload mandates 128 byte cqes */
+	param->force_cqe128 |= IS_ENABLED(CONFIG_MLX5_EN_NVMEOTCP) &&
+		params->nvmeotcp;
+
 	switch (params->rq_wq_type) {
 	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ:
 		hw_stridx = MLX5_CAP_GEN(mdev, mini_cqe_resp_stride_index);
@@ -1211,9 +1216,9 @@ static u8 mlx5e_build_async_icosq_log_wq_sz(struct mlx5_core_dev *mdev)
 	return MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE;
 }
 
-static void mlx5e_build_icosq_param(struct mlx5_core_dev *mdev,
-				    u8 log_wq_size,
-				    struct mlx5e_sq_param *param)
+void mlx5e_build_icosq_param(struct mlx5_core_dev *mdev,
+			     u8 log_wq_size,
+			     struct mlx5e_sq_param *param)
 {
 	void *sqc = param->sqc;
 	void *wq = MLX5_ADDR_OF(sqc, sqc, wq);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index bd5877acc5b1..7349478e4c30 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -17,6 +17,7 @@ struct mlx5e_cq_param {
 	struct mlx5_wq_param       wq;
 	u16                        eq_ix;
 	u8                         cq_period_mode;
+	bool                       force_cqe128;
 };
 
 struct mlx5e_rq_param {
@@ -140,6 +141,8 @@ void mlx5e_build_xdpsq_param(struct mlx5_core_dev *mdev,
 			     struct mlx5e_params *params,
 			     struct mlx5e_xsk_param *xsk,
 			     struct mlx5e_sq_param *param);
+void mlx5e_build_icosq_param(struct mlx5_core_dev *mdev,
+			     u8 log_wq_size, struct mlx5e_sq_param *param);
 int mlx5e_build_channel_param(struct mlx5_core_dev *mdev,
 			      struct mlx5e_params *params,
 			      struct mlx5e_channel_param *cparam);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
index 33e32584b07f..ee35925d987f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
@@ -40,6 +40,7 @@
 #include "en_accel/ktls.h"
 #include "en_accel/ktls_txrx.h"
 #include <en_accel/macsec.h>
+#include "en_accel/nvmeotcp.h"
 #include "en.h"
 #include "en/txrx.h"
 
@@ -208,11 +209,13 @@ static inline void mlx5e_accel_tx_finish(struct mlx5e_txqsq *sq,
 
 static inline int mlx5e_accel_init_rx(struct mlx5e_priv *priv)
 {
+	mlx5e_nvmeotcp_init_rx(priv);
 	return mlx5e_ktls_init_rx(priv);
 }
 
 static inline void mlx5e_accel_cleanup_rx(struct mlx5e_priv *priv)
 {
+	mlx5e_nvmeotcp_cleanup_rx(priv);
 	mlx5e_ktls_cleanup_rx(priv);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
index 7e899c716267..6714644986a1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
@@ -6,7 +6,7 @@
 
 #include "en/fs.h"
 
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 int mlx5e_accel_fs_tcp_create(struct mlx5e_flow_steering *fs);
 void mlx5e_accel_fs_tcp_destroy(struct mlx5e_flow_steering *fs);
 struct mlx5_flow_handle *mlx5e_accel_fs_add_sk(struct mlx5e_flow_steering *fs,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
new file mode 100644
index 000000000000..ca9c3aaf941f
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.
+
+#include <linux/netdevice.h>
+#include <linux/idr.h>
+#include "en_accel/nvmeotcp.h"
+#include "en_accel/fs_tcp.h"
+#include "en/txrx.h"
+
+#define MAX_NUM_NVMEOTCP_QUEUES	(4000)
+#define MIN_NUM_NVMEOTCP_QUEUES	(1)
+
+static const struct rhashtable_params rhash_queues = {
+	.key_len = sizeof(int),
+	.key_offset = offsetof(struct mlx5e_nvmeotcp_queue, id),
+	.head_offset = offsetof(struct mlx5e_nvmeotcp_queue, hash),
+	.automatic_shrinking = true,
+	.min_size = MIN_NUM_NVMEOTCP_QUEUES,
+	.max_size = MAX_NUM_NVMEOTCP_QUEUES,
+};
+
+static int
+mlx5e_nvmeotcp_offload_limits(struct net_device *netdev,
+			      struct ulp_ddp_limits *limits)
+{
+	return 0;
+}
+
+static int
+mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
+			  struct sock *sk,
+			  struct ulp_ddp_config *config)
+{
+	return 0;
+}
+
+static void
+mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
+			      struct sock *sk)
+{
+}
+
+static int
+mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
+			 struct sock *sk,
+			 struct ulp_ddp_io *ddp)
+{
+	return 0;
+}
+
+static void
+mlx5e_nvmeotcp_ddp_teardown(struct net_device *netdev,
+			    struct sock *sk,
+			    struct ulp_ddp_io *ddp,
+			    void *ddp_ctx)
+{
+}
+
+static void
+mlx5e_nvmeotcp_ddp_resync(struct net_device *netdev,
+			  struct sock *sk, u32 seq)
+{
+}
+
+int set_ulp_ddp_nvme_tcp(struct net_device *netdev, bool enable)
+{
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_params new_params;
+	int err = 0;
+
+	/* There may be offloaded queues when an netlink callback to
+	 * disable the feature is made. Hence, we can't destroy the
+	 * tcp flow-table since it may be referenced by the offload
+	 * related flows and we'll keep the 128B CQEs on the channel
+	 * RQs. Also, since we don't deref/destroy the fs tcp table
+	 * when the feature is disabled, we don't ref it again if the
+	 * feature is enabled multiple times.
+	 */
+	if (!enable || priv->nvmeotcp->enabled)
+		return 0;
+
+	err = mlx5e_accel_fs_tcp_create(priv->fs);
+	if (err)
+		return err;
+
+	new_params = priv->channels.params;
+	new_params.nvmeotcp = enable;
+	err = mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true);
+	if (err)
+		goto fs_tcp_destroy;
+
+	priv->nvmeotcp->enabled = true;
+	return 0;
+
+fs_tcp_destroy:
+	mlx5e_accel_fs_tcp_destroy(priv->fs);
+	return err;
+}
+
+static int mlx5e_ulp_ddp_set_caps(struct net_device *netdev,
+				  unsigned long *new_caps,
+				  struct netlink_ext_ack *extack)
+{
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	DECLARE_BITMAP(old_caps, ULP_DDP_CAP_COUNT);
+	struct mlx5e_params *params;
+	int ret = 0;
+	int nvme = -1;
+
+	mutex_lock(&priv->state_lock);
+	params = &priv->channels.params;
+	bitmap_copy(old_caps, priv->nvmeotcp->ddp_caps.active,
+		    ULP_DDP_CAP_COUNT);
+
+	/* always handle nvme-tcp-ddp and nvme-tcp-ddgst-rx together
+	 * (all or nothing)
+	 */
+
+	if (ulp_ddp_cap_turned_on(old_caps, new_caps, ULP_DDP_CAP_NVME_TCP) &&
+	    ulp_ddp_cap_turned_on(old_caps, new_caps,
+				  ULP_DDP_CAP_NVME_TCP_DDGST_RX)) {
+		if (MLX5E_GET_PFLAG(params, MLX5E_PFLAG_RX_CQE_COMPRESS)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "NVMe-TCP offload not supported when CQE compress is active. Disable rx_cqe_compress ethtool private flag first");
+			goto out;
+		}
+
+		if (netdev->features & (NETIF_F_LRO | NETIF_F_GRO_HW)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "NVMe-TCP offload not supported when HW_GRO/LRO is active. Disable rx-gro-hw ethtool feature first");
+			goto out;
+		}
+		nvme = 1;
+	} else if (ulp_ddp_cap_turned_off(old_caps, new_caps,
+					  ULP_DDP_CAP_NVME_TCP) &&
+		   ulp_ddp_cap_turned_off(old_caps, new_caps,
+					  ULP_DDP_CAP_NVME_TCP_DDGST_RX)) {
+		nvme = 0;
+	}
+
+	if (nvme >= 0) {
+		ret = set_ulp_ddp_nvme_tcp(netdev, nvme);
+		if (ret)
+			goto out;
+		change_bit(ULP_DDP_CAP_NVME_TCP,
+			   priv->nvmeotcp->ddp_caps.active);
+		change_bit(ULP_DDP_CAP_NVME_TCP_DDGST_RX,
+			   priv->nvmeotcp->ddp_caps.active);
+	}
+
+out:
+	mutex_unlock(&priv->state_lock);
+	return ret;
+}
+
+static void mlx5e_ulp_ddp_get_caps(struct net_device *dev,
+				   struct ulp_ddp_dev_caps *caps)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	mutex_lock(&priv->state_lock);
+	memcpy(caps, &priv->nvmeotcp->ddp_caps, sizeof(*caps));
+	mutex_unlock(&priv->state_lock);
+}
+
+const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops = {
+	.limits = mlx5e_nvmeotcp_offload_limits,
+	.sk_add = mlx5e_nvmeotcp_queue_init,
+	.sk_del = mlx5e_nvmeotcp_queue_teardown,
+	.setup = mlx5e_nvmeotcp_ddp_setup,
+	.teardown = mlx5e_nvmeotcp_ddp_teardown,
+	.resync = mlx5e_nvmeotcp_ddp_resync,
+	.set_caps = mlx5e_ulp_ddp_set_caps,
+	.get_caps = mlx5e_ulp_ddp_get_caps,
+};
+
+void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv)
+{
+	if (priv->nvmeotcp && priv->nvmeotcp->enabled)
+		mlx5e_accel_fs_tcp_destroy(priv->fs);
+}
+
+int mlx5e_nvmeotcp_init(struct mlx5e_priv *priv)
+{
+	struct mlx5e_nvmeotcp *nvmeotcp = NULL;
+	int ret = 0;
+
+	if (!(MLX5_CAP_GEN(priv->mdev, nvmeotcp) &&
+	      MLX5_CAP_DEV_NVMEOTCP(priv->mdev, zerocopy) &&
+	      MLX5_CAP_DEV_NVMEOTCP(priv->mdev, crc_rx) &&
+	      MLX5_CAP_GEN(priv->mdev, cqe_128_always)))
+		return 0;
+
+	nvmeotcp = kzalloc(sizeof(*nvmeotcp), GFP_KERNEL);
+
+	if (!nvmeotcp)
+		return -ENOMEM;
+
+	ida_init(&nvmeotcp->queue_ids);
+	ret = rhashtable_init(&nvmeotcp->queue_hash, &rhash_queues);
+	if (ret)
+		goto err_ida;
+
+	/* report ULP DPP as supported, but don't enable it by default */
+	set_bit(ULP_DDP_CAP_NVME_TCP, nvmeotcp->ddp_caps.hw);
+	set_bit(ULP_DDP_CAP_NVME_TCP_DDGST_RX, nvmeotcp->ddp_caps.hw);
+	nvmeotcp->enabled = false;
+	priv->nvmeotcp = nvmeotcp;
+	return 0;
+
+err_ida:
+	ida_destroy(&nvmeotcp->queue_ids);
+	kfree(nvmeotcp);
+	return ret;
+}
+
+void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv)
+{
+	struct mlx5e_nvmeotcp *nvmeotcp = priv->nvmeotcp;
+
+	if (!nvmeotcp)
+		return;
+
+	rhashtable_destroy(&nvmeotcp->queue_hash);
+	ida_destroy(&nvmeotcp->queue_ids);
+	kfree(nvmeotcp);
+	priv->nvmeotcp = NULL;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
new file mode 100644
index 000000000000..f6432a3737cd
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_NVMEOTCP_H__
+#define __MLX5E_NVMEOTCP_H__
+
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+
+#include <net/ulp_ddp.h>
+#include "en.h"
+#include "en/params.h"
+
+struct mlx5e_nvmeotcp_queue_entry {
+	struct mlx5e_nvmeotcp_queue *queue;
+	u32 sgl_length;
+	u32 klm_mkey;
+	struct scatterlist *sgl;
+	u32 ccid_gen;
+	u64 size;
+
+	/* for the ddp invalidate done callback */
+	void *ddp_ctx;
+	struct ulp_ddp_io *ddp;
+};
+
+struct mlx5e_nvmeotcp_queue_handler {
+	struct napi_struct napi;
+	struct mlx5e_cq *cq;
+};
+
+/**
+ *	struct mlx5e_nvmeotcp_queue - mlx5 metadata for NVMEoTCP queue
+ *	@ulp_ddp_ctx: Generic ulp ddp context
+ *	@tir: Destination TIR created for NVMEoTCP offload
+ *	@fh: Flow handle representing the 5-tuple steering for this flow
+ *	@id: Flow tag ID used to identify this queue
+ *	@size: NVMEoTCP queue depth
+ *	@ccid_gen: Generation ID for the CCID, used to avoid conflicts in DDP
+ *	@max_klms_per_wqe: Number of KLMs per DDP operation
+ *	@hash: Hash table of queues mapped by @id
+ *	@pda: Padding alignment
+ *	@tag_buf_table_id: Tag buffer table for CCIDs
+ *	@dgst: Digest supported (header and/or data)
+ *	@sq: Send queue used for posting umrs
+ *	@ref_count: Reference count for this structure
+ *	@after_resync_cqe: Indicate if resync occurred
+ *	@ccid_table: Table holding metadata for each CC (Command Capsule)
+ *	@ccid: ID of the current CC
+ *	@ccsglidx: Index within the scatter-gather list (SGL) of the current CC
+ *	@ccoff: Offset within the current CC
+ *	@ccoff_inner: Current offset within the @ccsglidx element
+ *	@channel_ix: Channel IX for this nvmeotcp_queue
+ *	@sk: The socket used by the NVMe-TCP queue
+ *	@crc_rx: CRC Rx offload indication for this queue
+ *	@priv: mlx5e netdev priv
+ *	@static_params_done: Async completion structure for the initial umr
+ *      mapping synchronization
+ *	@sq_lock: Spin lock for the icosq
+ *	@qh: Completion queue handler for processing umr completions
+ */
+struct mlx5e_nvmeotcp_queue {
+	struct ulp_ddp_ctx ulp_ddp_ctx;
+	struct mlx5e_tir tir;
+	struct mlx5_flow_handle *fh;
+	int id;
+	u32 size;
+	/* needed when the upper layer
+	 * immediately reuses CCID + some packet loss happens
+	 */
+	u32 ccid_gen;
+	u32 max_klms_per_wqe;
+	struct rhash_head hash;
+	int pda;
+	u32 tag_buf_table_id;
+	u8 dgst;
+	struct mlx5e_icosq sq;
+
+	/* data-path section cache aligned */
+	refcount_t ref_count;
+	/* for MASK HW resync cqe */
+	bool after_resync_cqe;
+	struct mlx5e_nvmeotcp_queue_entry *ccid_table;
+	/* current ccid fields */
+	int ccid;
+	int ccsglidx;
+	off_t ccoff;
+	int ccoff_inner;
+
+	u32 channel_ix;
+	struct sock *sk;
+	u8 crc_rx:1;
+	/* for ddp invalidate flow */
+	struct mlx5e_priv *priv;
+	/* end of data-path section */
+
+	struct completion static_params_done;
+	/* spin lock for the ico sq, ULP can issue requests
+	 * from multiple contexts
+	 */
+	spinlock_t sq_lock;
+	struct mlx5e_nvmeotcp_queue_handler qh;
+};
+
+struct mlx5e_nvmeotcp {
+	struct ida queue_ids;
+	struct rhashtable queue_hash;
+	struct ulp_ddp_dev_caps ddp_caps;
+	bool enabled;
+};
+
+int mlx5e_nvmeotcp_init(struct mlx5e_priv *priv);
+int set_ulp_ddp_nvme_tcp(struct net_device *netdev, bool enable);
+void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv);
+static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
+void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv);
+extern const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops;
+#else
+
+static inline int mlx5e_nvmeotcp_init(struct mlx5e_priv *priv) { return 0; }
+static inline void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv) {}
+static inline int set_ulp_ddp_nvme_tcp(struct net_device *dev, bool en)
+{ return -EOPNOTSUPP; }
+static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
+static inline void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv) {}
+#endif
+#endif /* __MLX5E_NVMEOTCP_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 995eedf7a51a..94946cb94485 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -42,6 +42,7 @@
 #include "en/ptp.h"
 #include "lib/clock.h"
 #include "en/fs_ethtool.h"
+#include "en_accel/nvmeotcp.h"
 
 #define LANES_UNKNOWN		 0
 
@@ -2164,6 +2165,11 @@ int mlx5e_modify_rx_cqe_compression_locked(struct mlx5e_priv *priv, bool new_val
 		return -EINVAL;
 	}
 
+	if (priv->channels.params.nvmeotcp) {
+		netdev_warn(priv->netdev, "Can't set CQE compression after ULP DDP NVMe-TCP offload\n");
+		return -EINVAL;
+	}
+
 	new_params = priv->channels.params;
 	MLX5E_SET_PFLAG(&new_params, MLX5E_PFLAG_RX_CQE_COMPRESS, new_val);
 	if (rx_filter)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 04a969128161..151a22d4278c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -62,7 +62,7 @@ struct mlx5e_flow_steering {
 #ifdef CONFIG_MLX5_EN_ARFS
 	struct mlx5e_arfs_tables       *arfs;
 #endif
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 	struct mlx5e_accel_fs_tcp      *accel_tcp;
 #endif
 	struct mlx5e_fs_udp            *udp;
@@ -1558,7 +1558,7 @@ void mlx5e_fs_set_any(struct mlx5e_flow_steering *fs, struct mlx5e_fs_any *any)
 	fs->any = any;
 }
 
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 struct mlx5e_accel_fs_tcp *mlx5e_fs_get_accel_tcp(struct mlx5e_flow_steering *fs)
 {
 	return fs->accel_tcp;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index d2936a75e5e5..ca408f775d40 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -55,6 +55,7 @@
 #include "en_accel/macsec.h"
 #include "en_accel/en_accel.h"
 #include "en_accel/ktls.h"
+#include "en_accel/nvmeotcp.h"
 #include "lib/vxlan.h"
 #include "lib/clock.h"
 #include "en/port.h"
@@ -4493,6 +4494,13 @@ static netdev_features_t mlx5e_fix_features(struct net_device *netdev,
 		netdev->netns_immutable = false;
 	}
 
+	if (features & (NETIF_F_LRO | NETIF_F_GRO_HW)) {
+		if (params->nvmeotcp) {
+			netdev_warn(netdev, "Disabling HW-GRO/LRO, not supported after ULP DDP NVMe-TCP offload\n");
+			features &= ~(NETIF_F_LRO | NETIF_F_GRO_HW);
+		}
+	}
+
 	mutex_unlock(&priv->state_lock);
 
 	return features;
@@ -5249,6 +5257,9 @@ const struct net_device_ops mlx5e_netdev_ops = {
 	.ndo_has_offload_stats   = mlx5e_has_offload_stats,
 	.ndo_get_offload_stats   = mlx5e_get_offload_stats,
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	.ulp_ddp_ops             = &mlx5e_nvmeotcp_ops,
+#endif
 };
 
 void mlx5e_build_nic_params(struct mlx5e_priv *priv, struct mlx5e_xsk *xsk, u16 mtu)
@@ -5826,6 +5837,11 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 	if (err)
 		mlx5_core_err(mdev, "TLS initialization failed, %d\n", err);
 
+	err = mlx5e_nvmeotcp_init(priv);
+	if (err)
+		mlx5_core_err(mdev, "NVMEoTCP initialization failed, %d\n",
+			      err);
+
 	mlx5e_health_create_reporters(priv);
 
 	/* If netdev is already registered (e.g. move from uplink to nic profile),
@@ -5846,6 +5862,7 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 static void mlx5e_nic_cleanup(struct mlx5e_priv *priv)
 {
 	mlx5e_health_destroy_reporters(priv);
+	mlx5e_nvmeotcp_cleanup(priv);
 	mlx5e_ktls_cleanup(priv);
 	mlx5e_fs_cleanup(priv->fs);
 	debugfs_remove_recursive(priv->dfs_root);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 41e8660c819c..2c2422b1cb03 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1804,6 +1804,7 @@ static const int types[] = {
 	MLX5_CAP_CRYPTO,
 	MLX5_CAP_SHAMPO,
 	MLX5_CAP_ADV_RDMA,
+	MLX5_CAP_DEV_NVMEOTCP,
 };
 
 static void mlx5_hca_caps_free(struct mlx5_core_dev *dev)
-- 
2.34.1


