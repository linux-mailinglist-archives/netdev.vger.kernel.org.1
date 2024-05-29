Return-Path: <netdev+bounces-99102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B46A58D3BAC
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2803B1F26976
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D70181D15;
	Wed, 29 May 2024 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DmtzTGnn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B28181CFA
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998516; cv=fail; b=n1GMiInVJpywGKNL8e9ey7sEelsLgqvlnJT0AZe1CZb9nzaai+ANhEknUDa6UjV1CLTdMaYfwxfwtuf4sq3J6oj1qfhn3JtY/R9wvwMQXce48sgzlHUcIC6eU04Bh9XuincUvWqwYT8DhNEEL43qQV02Rlkup2NwJClyTnMVJuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998516; c=relaxed/simple;
	bh=7ZXWI1TPOSb7sNRUNYmtiz3mQt8PCahw+Gv7iLe/oc0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rWJSp2ZWMwc9qvv8aW0GbvNT81nCgKvbCK+4Duj6WV2dNV3oD2/1K0OAKixYIXEnJYvgj2GOEwf2hXT1B5039gjSTdGhB+Biy6dIAu1KzFUdKSopTu7pYck4nweegWA4pzBzxgJdSddlH7scjON39Cq537Wr9sm+qwhTSHd8JWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DmtzTGnn; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTnFncrXlFbK0YO2ldu5O70namh3AEe2YU4706hxH209ITxJOMhADLZGTXh/Lh4wdcK1eDBXqWldZtUpieUE9YM6tmMZszhiYyy3SOBu/khb941w9rtWqa7pqOGzSviZTLYxk3mVZ8FoOdJCJMdkVp1GucuxQM0Qyxbe02eplwsDh07JsmsnQSeyGTl+dYyzEsDXzqw+FGSfOeIPsXx0TObUXie6qlMG6ZflqjVDtTvLgz2YulX3SZOt2J+qg4HRiUViOyrSSakacl0g+N+9OHeDN2fY/lGvMy9o+mQYb99qDrcqE7W26Xnt8LnCOcL66Qgnj8m2os2eb6QUbGgv3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hs/Ey71XzQtxGPD+6kD91PttcI+3Nao/buZ042CZdaw=;
 b=IrFnFTxB2jCUUz28dyQ+Msgj9BlNabgW5oy4IvUywTjg05zHwdXkPfnJxDNA3eUAWKyRr0NRwTO2iYsgS3kLFmlq8owu8MeV5NfK13Bpo0zxManWT0ymyY2S6pyiwf+PxAeCkF0e+4AuWuHCU8hESmzPt+YHnXkPvPfAb+cQ0o+jKWpZIxG65AgwV+TSVZTYMJzJNU+H+URBk8F1EDYpXC+gEgRoWgAKQKwEaVHhyo1NtelzaZ5H1A6pOQLSAaYIx7oFwQ/IQPyjvxZPEN0AsAEg4eYUKiHByVGZpQU3/u17igExdFm/YX2MD+uxNAFnx4FDa+8FxWeo8SOCEDZBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hs/Ey71XzQtxGPD+6kD91PttcI+3Nao/buZ042CZdaw=;
 b=DmtzTGnnHRaybRes4JC0Hh+IGTvfayKnFx+M2GgcKwpyuD4uyOyvbehTKKqP9ajVyVnJXbOoeiN1Ro6bur0iZRsQyFWp0C1EhjlkWU41n3DY35vUkdDoctVrp6PYFubZizbt/31YBjEivx+LoNcojZIt6wC3uALLkDlfD+7R6OkCOPY3u+ssOIkEre9Z8M6NcaDTB7jr7UokFsy+/J82Jywe4iupzy4SPaJzxXjlkxBCWO64cMJeUPYswtbD443C5oxN1Rr8us1WvHoluYQKwAKU1OFEo1P0D77m/lTW9KqXI4dG1NUEwfv1P1/PpJu0tjWNG1iX2xGqPCGWOA7dPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 16:01:50 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:01:49 +0000
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
Subject: [PATCH v25 09/20] Documentation: add ULP DDP offload documentation
Date: Wed, 29 May 2024 16:00:42 +0000
Message-Id: <20240529160053.111531-10-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160053.111531-1-aaptel@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0105.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::20) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b6a1ee-a01b-4efd-63bb-08dc7ff8a5e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ib6FbuB9pSBVNE9DC1JGhx5JA/WAD4kiTmSiV8sZno1FyIMk4BgNnZsWY3lu?=
 =?us-ascii?Q?ptucbDFLfV2jERQSWLm0pr31H5BKX0IrtP2HSvwN/eFGL1D8gLHJYQ6/orq0?=
 =?us-ascii?Q?j5nMuzv8GzUCjjSLzLPffZycaZ1Yo19B2VsMehnppYZqLpjGGJjUCC0Z1oM6?=
 =?us-ascii?Q?+Ip4muxHpMfuH/sKzY+/UYX1Py1HHqOhwTvTDUn++XU+67H3+gzP+2v777Zf?=
 =?us-ascii?Q?jSR2P6EQYLJw6Mxz2g/0fyFgoS6lqDXXBu1oIIXeVUa0MKP3YqmgOwHd4bK/?=
 =?us-ascii?Q?eLIuLXrLHU03bmDgc8XgBeEpWcGcvo+9sACgkTPI3tNZN6dw7/YTJULFhKMY?=
 =?us-ascii?Q?rGJ0zDHnCHbONz8pZq+ET110WvjXSqJj1n2xdPdopkTyos1WQgk5rwODgLo1?=
 =?us-ascii?Q?4PM6Tfb1B95moRDqEtjUBZ/Z4NEHEWdIlMq6YG6FQlJF7WQxUkCuoExDQ1A1?=
 =?us-ascii?Q?2vZuE01LLuRkR6EzayLB+RmCqRtLk4zNGXybdCi0RYaGmKE75yxUvFu2oyFd?=
 =?us-ascii?Q?octiNKavE2tQ0iqIhKvgM3GMdmqT2x6Op5Sa60iPWs0QPYIYgZ8pe3MDljAs?=
 =?us-ascii?Q?D5vD4UwzEbrnl+QryKQopBaAl6NA7My9JEBxxKjHW7XeFK5X2s0jgSSlG0vB?=
 =?us-ascii?Q?0DFCwK0rgHdW5OI5mtKmSK5SD9AgvNb7OteUhxt8mZDrpNOyMpD4e41m0bo4?=
 =?us-ascii?Q?DNlJnAFckJCrU+bJPeRNJRkG8/rDiv0OY1NVo+41VGmLTbTRufM1koSsTOP1?=
 =?us-ascii?Q?HbP2nIau+0InoMMvBDDua49kocxxXO9JOWdZ3whxG8Jpnyn0dQ1uDGauWHRx?=
 =?us-ascii?Q?3/ZCedIMs8FY9WOIQ7W49p7YPC6aQUdjmS95RLXMxXp6hOclvP1fagqYXTla?=
 =?us-ascii?Q?eKvaYgzKuAgNfK4tAGQJoTvt1O8ICmbOt1q2YggiY+YZVYebBCbj2ufnOIEj?=
 =?us-ascii?Q?2StkUcNSc+xIR2h2FCVVKya0ISfdhGeHwlBsozRu6uxCEQY/mBgrzxlFy3u2?=
 =?us-ascii?Q?PEM6lTyPH8vwePQfV1j9ighA1XXw0lzEDonP9XOVc5/O6RU4TQo9q+Ed9mah?=
 =?us-ascii?Q?0tnNxRdT2tsiEeC2dnH/AZjXWL7Xw7BnwmMP77LjE5gOqeotFnHtdZIaOZUx?=
 =?us-ascii?Q?QLjuG8jykJ/FEBsJJUGI7v/jy94ark6512GP8HA84SgyVJVuU34Bmfa2hwzR?=
 =?us-ascii?Q?F9AdqRQSbWJeZaRYIiySkMNl8eGGpP4vnWETJOpb3Kc3mmC7MCD8UI72hFB4?=
 =?us-ascii?Q?hH2zz+kF2h6II2ZwODzXrxWhvK0E7Tt+4X7bvGqi3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AM+V6NIMFpItUCWFA6I30ZWVdpNIoyh5PKGaxIIJX8rKX11HrkMwahk+zRF5?=
 =?us-ascii?Q?KCsFt7jNP7Qb5CQFL9CanYmXK0bat8ADHdlN+97TBJVWm5lmiCy4eOwSqxs6?=
 =?us-ascii?Q?tpamwljV9BQnHLMgtfT9xpHT3bBldTxBeb2MCkIm74MsboIB/MfSuz7+96x7?=
 =?us-ascii?Q?GBMhWr1IKujfjlRzBp2WR+AhnfQXFcbcT7eNgu52wU829QHeUTf5Oa9Egs9J?=
 =?us-ascii?Q?2GoeQtxt1eiS/OOFfCrDp2EgCj4Wse/6Cg5nRVllWLvfcQaeXtqOrrEC43Bb?=
 =?us-ascii?Q?cpjkx3RFlUtPEVIXSJk/aOpr6OBO6kpiOnA8zoaXvo3Mwzj/Vsmtl8gPBm6h?=
 =?us-ascii?Q?AsL64s3Y0HHC2f8lAbBq2PYtMmODiCXo7G7QCiENMSYLQt/9pBl1Oi58rSSt?=
 =?us-ascii?Q?MpajYRfqzz6lid0wIuKZP5Yy118u65CfQLAFhTohmgyaxrdsGI5n61YibG1J?=
 =?us-ascii?Q?OfuX4Qordxd4BbZZliUj2TZFb/0WhIIoVKy7x1Z0RlZqAOXeh8DbBCzYqB69?=
 =?us-ascii?Q?Ou8Gj7WUTRLHQyHh0bzhe+ty0uJR9cD8DJMPw6zN/T3RW2gR3n4R6jmAO48R?=
 =?us-ascii?Q?hp0t7pwdAVyRTczBPNvnGU8MzrZr1EUQpg+OkgOO00cCKnO55ZUA1SpbEi8t?=
 =?us-ascii?Q?SEvSVuIecg7LMvr1lUx8Mqy0fdJAdwzPTE/CDbmSLMQDY/5xGpf2e0MSimD+?=
 =?us-ascii?Q?SBZWTZU+YbQi3/4jBk7lTrKZu72CEW/HHw7J51eKzKUMnJbFybWoW24hmiB3?=
 =?us-ascii?Q?EOC54YdoDZ0D5GeECe+UQkJlMJ7qxQsgNtssPBgVWzSW+pZ7nyrj9FTNkjEj?=
 =?us-ascii?Q?p14y0YCPmiKpYgRKG9ecUGjL4D5epc3yv6P8wjPddAKc6GdMCE471aP+X0Hp?=
 =?us-ascii?Q?y62MEPr+PSiVrhTGegw6aZSu7lvEG2TLSUiWK460OUk2FkinUsJHjx8O1An+?=
 =?us-ascii?Q?r51W3I4re01Ww4i1QwVuB3e+WV5JmeaDJlaWnhmMM67omQJRl66HzhoNb8mH?=
 =?us-ascii?Q?wSEkxQyVN3pTgWIfvJK3MRXY0YF8gWuKYwyh5TYbU0AcR/dd62mUC6sT6KQC?=
 =?us-ascii?Q?9bGtLt7YLLG8Fia92m0b671V3d4dwEJAju+rtqU12z7M+3RJ+ZzRrYgk4iQl?=
 =?us-ascii?Q?ZYrTYwLLv6jdkhPt5lh9+4OHboeZOuH8NfLXbhItn/gMLvth2Up7ZAKV8u1Q?=
 =?us-ascii?Q?QvVWs1Imj/Jp9UrWS2V0lgPnsyl9CWbNoEveA3D3fneT/RdQrxCpvpvigAnP?=
 =?us-ascii?Q?s2u75dbCZCVGSkIrqFG5PbEKchvajip93q5Nm90DbvP/IRFWWKkMaJ06bSGv?=
 =?us-ascii?Q?k6LBH81LLhJsSEZrxh5qmfW2qqh+yyXRPRBx6hVRzAzYQoEmc/RmO03YRSYk?=
 =?us-ascii?Q?/0cgAw/W4CeUoaCiTUytJDbAvfhAFfjHcuz7Tj2VzLKbilC8I37LLyY8s615?=
 =?us-ascii?Q?ofWDGkznp5mLJfej2vLqGtm+T0DkQWQyGXRUYNlxZRe1hLgIuHjL0VIKQ34E?=
 =?us-ascii?Q?5lFAS0YtnK1Wghiasz+tpvnScf8sZcudrRI+qPzS4TQIx9eWCDI4I1HHhHn/?=
 =?us-ascii?Q?nQCwQkujZY9nzIsUv9lV0fhPs7BFK8ZcEjlCwo87?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b6a1ee-a01b-4efd-63bb-08dc7ff8a5e2
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:01:49.3432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxR9Pd8HWiN0uRVn1sKvann8+oH8ojVFDMfRcRN5w9OEOdsKiksdrQaNQsr/83pWsGzP4xDtGeaEw7Mm1J4IVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799

From: Yoray Zack <yorayz@nvidia.com>

Document the new ULP DDP API and add it under "networking".
Use NVMe-TCP implementation as an example.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/index.rst           |   1 +
 Documentation/networking/ulp-ddp-offload.rst | 372 +++++++++++++++++++
 2 files changed, 373 insertions(+)
 create mode 100644 Documentation/networking/ulp-ddp-offload.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 7664c0bfe461..62be641ca4e3 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -112,6 +112,7 @@ Contents:
    tc-queue-filters
    tcp_ao
    tcp-thin
+   ulp-ddp-offload
    team
    timestamping
    tipc
diff --git a/Documentation/networking/ulp-ddp-offload.rst b/Documentation/networking/ulp-ddp-offload.rst
new file mode 100644
index 000000000000..4133e5094ff5
--- /dev/null
+++ b/Documentation/networking/ulp-ddp-offload.rst
@@ -0,0 +1,372 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+=================================
+ULP direct data placement offload
+=================================
+
+Overview
+========
+
+The Linux kernel ULP direct data placement (DDP) offload infrastructure
+provides tagged request-response protocols, such as NVMe-TCP, the ability to
+place response data directly in pre-registered buffers according to header
+tags. DDP is particularly useful for data-intensive pipelined protocols whose
+responses may be reordered.
+
+For example, in NVMe-TCP numerous read requests are sent together and each
+request is tagged using the PDU header CID field. Receiving servers process
+requests as fast as possible and sometimes responses for smaller requests
+bypasses responses to larger requests, e.g., 4KB reads bypass 1GB reads.
+Thereafter, clients correlate responses to requests using PDU header CID tags.
+The processing of each response requires copying data from SKBs to read
+request destination buffers; The offload avoids this copy. The offload is
+oblivious to destination buffers which can reside either in userspace
+(O_DIRECT) or in kernel pagecache.
+
+Request TCP byte-stream:
+
+.. parsed-literal::
+
+ +---------------+-------+---------------+-------+---------------+-------+
+ | PDU hdr CID=1 | Req 1 | PDU hdr CID=2 | Req 2 | PDU hdr CID=3 | Req 3 |
+ +---------------+-------+---------------+-------+---------------+-------+
+
+Response TCP byte-stream:
+
+.. parsed-literal::
+
+ +---------------+--------+---------------+--------+---------------+--------+
+ | PDU hdr CID=2 | Resp 2 | PDU hdr CID=3 | Resp 3 | PDU hdr CID=1 | Resp 1 |
+ +---------------+--------+---------------+--------+---------------+--------+
+
+The driver builds SKB page fragments that point to destination buffers.
+Consequently, SKBs represent the original data on the wire, which enables
+*transparent* inter-operation with the network stack. To avoid copies between
+SKBs and destination buffers, the layer-5 protocol (L5P) will check
+``if (src == dst)`` for SKB page fragments, success indicates that data is
+already placed there by NIC hardware and copy should be skipped.
+
+In addition, L5P might have DDGST which ensures data integrity over
+the network.  If not offloaded, ULP DDP might not be efficient as L5P
+will need to go over the data and calculate it by itself, cancelling
+out the benefits of the DDP copy skip.  ULP DDP has support for Rx/Tx
+DDGST offload. On the received side the NIC will verify DDGST for
+received PDUs and update SKB->ulp_ddp and SKB->ulp_crc bits.  If all the SKBs
+making up a L5P PDU have crc on, L5P will skip on calculating and
+verifying the DDGST for the corresponding PDU. On the Tx side, the NIC
+will be responsible for calculating and filling the DDGST fields in
+the sent PDUs.
+
+Offloading does require NIC hardware to track L5P protocol framing, similarly
+to RX TLS offload (see Documentation/networking/tls-offload.rst).  NIC hardware
+will parse PDU headers, extract fields such as operation type, length, tag
+identifier, etc. and only offload segments that correspond to tags registered
+with the NIC, see the :ref:`buf_reg` section.
+
+Device configuration
+====================
+
+During driver initialization the driver sets the ULP DDP operations
+for the :c:type:`struct net_device <net_device>` via
+`netdev->netdev_ops->ulp_ddp_ops`.
+
+The :c:member:`get_caps` operation returns the ULP DDP capabilities
+enabled and/or supported by the device to the caller. The current list
+of capabilities is represented as a bitset:
+
+.. code-block:: c
+
+  enum ulp_ddp_cap {
+	ULP_DDP_CAP_NVME_TCP,
+	ULP_DDP_CAP_NVME_TCP_DDGST,
+  };
+
+The enablement of capabilities can be controlled via the
+:c:member:`set_caps` operation. This operation is exposed to userspace
+via netlink. See Documentation/netlink/specs/ulp_ddp.yaml for more
+details.
+
+Later, after the L5P completes its handshake, the L5P queries the
+driver for its runtime limitations via the :c:member:`limits` operation:
+
+.. code-block:: c
+
+ int (*limits)(struct net_device *netdev,
+	       struct ulp_ddp_limits *lim);
+
+
+All L5P share a common set of limits and parameters (:c:type:`struct ulp_ddp_limits <ulp_ddp_limits>`):
+
+.. code-block:: c
+
+ /**
+  * struct ulp_ddp_limits - Generic ulp ddp limits: tcp ddp
+  * protocol limits.
+  * Add new instances of ulp_ddp_limits in the union below (nvme-tcp, etc.).
+  *
+  * @type:		type of this limits struct
+  * @max_ddp_sgl_len:	maximum sgl size supported (zero means no limit)
+  * @io_threshold:	minimum payload size required to offload
+  * @tls:		support for ULP over TLS
+  * @nvmeotcp:		NVMe-TCP specific limits
+  */
+ struct ulp_ddp_limits {
+	enum ulp_ddp_type	type;
+	int			max_ddp_sgl_len;
+	int			io_threshold;
+	bool			tls:1;
+	union {
+		/* ... protocol-specific limits ... */
+		struct nvme_tcp_ddp_limits nvmeotcp;
+	};
+ };
+
+But each L5P can also add protocol-specific limits e.g.:
+
+.. code-block:: c
+
+ /**
+  * struct nvme_tcp_ddp_limits - nvme tcp driver limitations
+  *
+  * @full_ccid_range:	true if the driver supports the full CID range
+  */
+ struct nvme_tcp_ddp_limits {
+	bool			full_ccid_range;
+ };
+
+Once the L5P has made sure the device is supported the offload
+operations are installed on the socket.
+
+If offload installation fails, then the connection is handled by software as if
+offload was not attempted.
+
+To request offload for a socket `sk`, the L5P calls :c:member:`sk_add`:
+
+.. code-block:: c
+
+ int (*sk_add)(struct net_device *netdev,
+	       struct sock *sk,
+	       struct ulp_ddp_config *config);
+
+The function return 0 for success. In case of failure, L5P software should
+fallback to normal non-offloaded operations.  The `config` parameter indicates
+the L5P type and any metadata relevant for that protocol. For example, in
+NVMe-TCP the following config is used:
+
+.. code-block:: c
+
+ /**
+  * struct nvme_tcp_ddp_config - nvme tcp ddp configuration for an IO queue
+  *
+  * @pfv:        pdu version (e.g., NVME_TCP_PFV_1_0)
+  * @cpda:       controller pdu data alignment (dwords, 0's based)
+  * @dgst:       digest types enabled.
+  *              The netdev will offload crc if L5P data digest is supported.
+  * @queue_size: number of nvme-tcp IO queue elements
+  */
+ struct nvme_tcp_ddp_config {
+	u16			pfv;
+	u8			cpda;
+	u8			dgst;
+	int			queue_size;
+ };
+
+When offload is not needed anymore, e.g. when the socket is being released, the L5P
+calls :c:member:`sk_del` to release device contexts:
+
+.. code-block:: c
+
+ void (*sk_del)(struct net_device *netdev,
+	        struct sock *sk);
+
+Normal operation
+================
+
+At the very least, the device maintains the following state for each connection:
+
+ * 5-tuple
+ * expected TCP sequence number
+ * mapping between tags and corresponding buffers
+ * current offset within PDU, PDU length, current PDU tag
+
+NICs should not assume any correlation between PDUs and TCP packets.
+If TCP packets arrive in-order, offload will place PDU payloads
+directly inside corresponding registered buffers. NIC offload should
+not delay packets. If offload is not possible, than the packet is
+passed as-is to software. To perform offload on incoming packets
+without buffering packets in the NIC, the NIC stores some inter-packet
+state, such as partial PDU headers.
+
+RX data-path
+------------
+
+After the device validates TCP checksums, it can perform DDP offload.  The
+packet is steered to the DDP offload context according to the 5-tuple.
+Thereafter, the expected TCP sequence number is checked against the packet
+TCP sequence number. If there is a match, offload is performed: the PDU payload
+is DMA written to the corresponding destination buffer according to the PDU header
+tag.  The data should be DMAed only once, and the NIC receive ring will only
+store the remaining TCP and PDU headers.
+
+We remark that a single TCP packet may have numerous PDUs embedded inside. NICs
+can choose to offload one or more of these PDUs according to various
+trade-offs. Possibly, offloading such small PDUs is of little value, and it is
+better to leave it to software.
+
+Upon receiving a DDP offloaded packet, the driver reconstructs the original SKB
+using page frags, while pointing to the destination buffers whenever possible.
+This method enables seamless integration with the network stack, which can
+inspect and modify packet fields transparently to the offload.
+
+.. _buf_reg:
+
+Destination buffer registration
+-------------------------------
+
+To register the mapping between tags and destination buffers for a socket
+`sk`, the L5P calls :c:member:`setup` of :c:type:`struct ulp_ddp_dev_ops
+<ulp_ddp_dev_ops>`:
+
+.. code-block:: c
+
+ int (*setup)(struct net_device *netdev,
+	      struct sock *sk,
+	      struct ulp_ddp_io *io);
+
+
+The `io` provides the buffer via scatter-gather list (`sg_table`) and
+corresponding tag (`command_id`):
+
+.. code-block:: c
+
+ /**
+  * struct ulp_ddp_io - tcp ddp configuration for an IO request.
+  *
+  * @command_id:  identifier on the wire associated with these buffers
+  * @nents:       number of entries in the sg_table
+  * @sg_table:    describing the buffers for this IO request
+  * @first_sgl:   first SGL in sg_table
+  */
+ struct ulp_ddp_io {
+	u32			command_id;
+	int			nents;
+	struct sg_table		sg_table;
+	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
+ };
+
+After the buffers have been consumed by the L5P, to release the NIC mapping of
+buffers the L5P calls :c:member:`teardown` of :c:type:`struct
+ulp_ddp_dev_ops <ulp_ddp_dev_ops>`:
+
+.. code-block:: c
+
+ void (*teardown)(struct net_device *netdev,
+		  struct sock *sk,
+		  struct ulp_ddp_io *io,
+		  void *ddp_ctx);
+
+`teardown` receives the same `io` context and an additional opaque
+`ddp_ctx` that is used for asynchronous teardown, see the :ref:`async_release`
+section.
+
+.. _async_release:
+
+Asynchronous teardown
+---------------------
+
+To teardown the association between tags and buffers and allow tag reuse NIC HW
+is called by the NIC driver during `teardown`. This operation may be
+performed either synchronously or asynchronously. In asynchronous teardown,
+`teardown` returns immediately without unmapping NIC HW buffers. Later,
+when the unmapping completes by NIC HW, the NIC driver will call up to L5P
+using :c:member:`ddp_teardown_done` of :c:type:`struct ulp_ddp_ulp_ops <ulp_ddp_ulp_ops>`:
+
+.. code-block:: c
+
+ void (*ddp_teardown_done)(void *ddp_ctx);
+
+The `ddp_ctx` parameter passed in `ddp_teardown_done` is the same on provided
+in `teardown` and it is used to carry some context about the buffers
+and tags that are released.
+
+Resync handling
+===============
+
+RX
+--
+In presence of packet drops or network packet reordering, the device may lose
+synchronization between the TCP stream and the L5P framing, and require a
+resync with the kernel's TCP stack. When the device is out of sync, no offload
+takes place, and packets are passed as-is to software. Resync is very similar
+to TLS offload (see documentation at Documentation/networking/tls-offload.rst)
+
+If only packets with L5P data are lost or reordered, then resynchronization may
+be avoided by NIC HW that keeps tracking PDU headers. If, however, PDU headers
+are reordered, then resynchronization is necessary.
+
+To resynchronize hardware during traffic, we use a handshake between hardware
+and software. The NIC HW searches for a sequence of bytes that identifies L5P
+headers (i.e., magic pattern).  For example, in NVMe-TCP, the PDU operation
+type can be used for this purpose.  Using the PDU header length field, the NIC
+HW will continue to find and match magic patterns in subsequent PDU headers. If
+the pattern is missing in an expected position, then searching for the pattern
+starts anew.
+
+The NIC will not resume offload when the magic pattern is first identified.
+Instead, it will request L5P software to confirm that indeed this is a PDU
+header. To request confirmation the NIC driver calls up to L5P using
+:c:member:`resync_request` of :c:type:`struct ulp_ddp_ulp_ops <ulp_ddp_ulp_ops>`:
+
+.. code-block:: c
+
+  bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
+
+The `seq` parameter contains the TCP sequence of the last byte in the PDU header.
+The `flags` parameter contains a flag (`ULP_DDP_RESYNC_PENDING`) indicating whether
+a request is pending or not.
+L5P software will respond to this request after observing the packet containing
+TCP sequence `seq` in-order. If the PDU header is indeed there, then L5P
+software calls the NIC driver using the :c:member:`resync` function of
+the :c:type:`struct ulp_ddp_dev_ops <ulp_ddp_ops>` inside the :c:type:`struct
+net_device <net_device>` while passing the same `seq` to confirm it is a PDU
+header.
+
+.. code-block:: c
+
+ void (*resync)(struct net_device *netdev,
+		struct sock *sk, u32 seq);
+
+Statistics
+==========
+
+Per L5P protocol, the NIC driver must report statistics for the above
+netdevice operations and packets processed by offload.
+These statistics are per-device and can be retrieved from userspace
+via netlink (see Documentation/netlink/specs/ulp_ddp.yaml).
+
+For example, NVMe-TCP offload reports:
+
+ * ``rx_nvme_tcp_sk_add`` - number of NVMe-TCP Rx offload contexts created.
+ * ``rx_nvme_tcp_sk_add_fail`` - number of NVMe-TCP Rx offload context creation
+   failures.
+ * ``rx_nvme_tcp_sk_del`` - number of NVMe-TCP Rx offload contexts destroyed.
+ * ``rx_nvme_tcp_setup`` - number of DDP buffers mapped.
+ * ``rx_nvme_tcp_setup_fail`` - number of DDP buffers mapping that failed.
+ * ``rx_nvme_tcp_teardown`` - number of DDP buffers unmapped.
+ * ``rx_nvme_tcp_drop`` - number of packets dropped in the driver due to fatal
+   errors.
+ * ``rx_nvme_tcp_resync`` - number of packets with resync requests.
+ * ``rx_nvme_tcp_packets`` - number of packets that used offload.
+ * ``rx_nvme_tcp_bytes`` - number of bytes placed in DDP buffers.
+
+NIC requirements
+================
+
+NIC hardware should meet the following requirements to provide this offload:
+
+ * Offload must never buffer TCP packets.
+ * Offload must never modify TCP packet headers.
+ * Offload must never reorder TCP packets within a flow.
+ * Offload must never drop TCP packets.
+ * Offload must not depend on any TCP fields beyond the
+   5-tuple and TCP sequence number.
-- 
2.34.1


