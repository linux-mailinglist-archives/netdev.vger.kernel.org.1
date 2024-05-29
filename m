Return-Path: <netdev+bounces-99114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7258D3BBA
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FE9280F12
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8428B18734A;
	Wed, 29 May 2024 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="axQtGvk2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78461187344
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998578; cv=fail; b=FfGn3Pc/RljCsj9MSVsm8Vb9mSl4iDbRwDg5qBHXTI/npodqHk3H6vvWe4q2UwZCUUqftaborY8Wr3OGLRrxB7OaqZKJXYSkAD4oZgVWV4y7ydQ6FhMnMl+NS5pMAuBxElr7XTc2yQeiQRbA5kt88sUhkHthYBD/lg+hRPUXnIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998578; c=relaxed/simple;
	bh=+f8xfSkjiE4qC0iCQZ6QfURzXGAzpEFyD0/IiSHwyKg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lvrJ6ZUuRmo+Q1GU87wkJYqp0xQAFmAx0yw9mnH5Yt0AX2EzUdP1LTx71YAWr99IoGUfl0H+qFLk76jVsjQWZekTBOX68sJp3o/1CNLsNU9eTRpqKJ1LV5tZChzkWxB8iTGSDaXXgvKqdX+/7kMWM0RTNPwGFh1m6fe27I7W8NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=axQtGvk2; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neWl+AN+PcHMabYQPQDIUMLr13p9F5EU6zHdP5FTouCSeQAkrYY6A5wC9lXHLruj9x6XcuvHmEwsZRDvfzb6MHv7neq7X4ol0+aQyGgdk3dMFE80KmdT0a0Etc6JLV+W7MTYzjqo6mdX7GTmT2D7HmyeinEoSXl5OKOm7lJj5Frc2JeFRrznXYqTvpODN3mWaw9QiPCRKImf7IwY3jNFHkheFKkch5ftslNS0NRg4mw57rt0/UePRYmVawevMYb9HHHsyRrGgYcJUfiH/0ybLf4bfvVTvJNtxdFj/eskXfHke3x2Vfq3Dn8NXvOFNjPxnNW6RMF0GNzsJH4mueKK0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JzCyvX44HgIfN6COqD7vGYnxitcxlxcfnA+u2NNALQ=;
 b=gB+eIVVKWpqlfCvhPYqIVR00rcAc8h4aEeoNVd1yL+z/vh73GpJZO4q+U03zmDhnC+qy+wDg1D6gmtITB0KEC8ZZ9KFrSPYzLpO69Qsh/M2+eCLTqTPFceu9Susht+fqPYBuhZd2yzxN5ZQnm9Rs+eny0Wcgcx6ejw6xkjVr2gITDbkSE6okUrpfNCiiJoi6lrWKL+tjBtzRf4MQKsj1mvq8OzIg1FDcf4andpHwip1dYasMvMJ8QoO1av+rg0qwD4DShhOSII0AVphT9Mht022tp4LBlhmhB8/8TCLslmTiytHRosNXrxHMkHpUgJBbVYUd4W57j9Lu+pOOggWwNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JzCyvX44HgIfN6COqD7vGYnxitcxlxcfnA+u2NNALQ=;
 b=axQtGvk2gYcwU7SvHNo3S6AHBypMnX8GK3jdE5aAcHnJdWYCwMht8OpkPtJrq6WmwdvHDPRLDahfXcYrzqYAUzgAvqJe4Sp15/VTH4gDBMqWChjB2p8kipqIUwANSq7IgnPU0gbPVriSRs9Wy/nmcGrwIknt2T7VLv/EqtWAHdzk3fQkAL4n9+PD5Xwuo0Hou4rJuvhYPuAqI/SWokr9Q9syPU8CoByGhFuFrleWIDDOzOIp9DOTcAxH3c6sxACmzfPmuHCmJgZUI/Zyr7LUiYGiLbOzfy6Z/wgqjskcstQanGM6fytIZRBaZ/w3EKzJ85vU8FWOx4GMHthVaxBpUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 16:02:51 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:02:51 +0000
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
Subject: [PATCH v25 20/20] net/mlx5e: NVMEoTCP, statistics
Date: Wed, 29 May 2024 16:00:53 +0000
Message-Id: <20240529160053.111531-21-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160053.111531-1-aaptel@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0380.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::7) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: 8122eea6-5abc-4fee-39ca-08dc7ff8cad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ibd8TjT+ngURPSiSMpLOa3KU5eIaOH/UFMgoOHewdhjK9HdOHArxzkwDOK1w?=
 =?us-ascii?Q?V8wQcmjyC/PrkckQGvgMxxigKgwxxHj1P/rQBsikndTKalkzcPneAXHJKDUZ?=
 =?us-ascii?Q?YRjL6qJXvltqy3lHnGUMAK+nMtw+348+Rxjhb7dus3w/WSyeajR9xHFuBcFR?=
 =?us-ascii?Q?6ouAqffGSH5JZ199MiUHn90m/IKiRD28SgbLG0gVvgjnxjUySMSn03qbKrIO?=
 =?us-ascii?Q?q6vOebAOLZs8ZcX81OVUGjgQDvfvF3xy+GhFADuVUnqH4Um2Cgpjcrz3krbq?=
 =?us-ascii?Q?iLeZ2egoxhnWtvkUcrjFu2vcRfr7RORJFCP4ScyFMqmMjA056IkT5UwdD5pK?=
 =?us-ascii?Q?wn+fLmCACMZv/GBIGLHZfHC9MIZCzT+XAWZc7hTbS2yPtBNoDPF2JWRg0lNP?=
 =?us-ascii?Q?/aGOJBXJPq7S141ikmFObL/0hgQrN/wTkUWXNC1Lgdv2kbEXq0bfFWTQU57R?=
 =?us-ascii?Q?VMuJpKhLmTydYhp1gfL2AjMlrLEdTo5L02Xjl7BUsTf4qRHsootKtsxm5PMY?=
 =?us-ascii?Q?PYnKbaBg4EHc8QIIx45vIJ5LqjFtrrsc5vBGoqxXaTbrBtntYajNBBiDbUes?=
 =?us-ascii?Q?X/0W5MzYgWiMnDM1RDC27jq3HhLXhosgXbqHjIXA3JdIMvjrgJ6uFSx3at1J?=
 =?us-ascii?Q?Bv3zRrH2q0lmzE1OsElCqx/La6BXC+D+NsT7TYk/YQr1wtFnJJvfIq1mFPin?=
 =?us-ascii?Q?cyG4l/YpI5MNaGvaNG+E6cZLgW6TdB5iMMHpfuzgxw/nNyBDqiH0rgG1XjNE?=
 =?us-ascii?Q?5vxCBl8McMDVl6mUHgP7GpIIVwRk+S1emNOgmBo++hXlRRV9T2g7bp+bnpMZ?=
 =?us-ascii?Q?jdRDysx6pcuprdzwsU5h1RbfinvYjgima0zIauNo/ejYAd621fn1yjnUC71E?=
 =?us-ascii?Q?Ekia6P7ZUkFbNYIUuCqz/pnAirqAFsAnwjv7hkZukYT/D23DcAgRRsUeR9cy?=
 =?us-ascii?Q?6jmsTCVbG1R9d4G0yypaMXgXqfxIDA49V92lToTU/gKY/v0wZRvzKas9pTsC?=
 =?us-ascii?Q?wDNyI8iyDPrVzPoHfSWyvOu7VKIfHz08iXbHGIrawBIgGrDkqhQ5seXY9a4K?=
 =?us-ascii?Q?GTWsU+t2D0i/OxplBflFEp04466te8SX2gPmgbmpVxvj1YCZCQ6tUIonPFs6?=
 =?us-ascii?Q?gFyfHL/Oqt9fMR4SyDyCKdvsOOj+F3LsW9oXqE1qJB9jZAingKLkwsM2uTHZ?=
 =?us-ascii?Q?ZVFvQBaG3p4d1kylOsAuyDWoo+PZ1dESUFQH7xKhWQvsLeM1u1mrIbMryP0Y?=
 =?us-ascii?Q?V0Lhtpv3PvTjF4erQHkF+nvBv2y9n7MojOfdjOQttA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WhEH88nqcW//OH8uVoLofevpLZsjGjufU8HHtGwm4iM5DPaZNHK/izMzNAlO?=
 =?us-ascii?Q?roBaPjteasmfUuHaga0Zb7h2OX8T7/BvVmi3sTvD9jahHub+rpiTIWcnkrs7?=
 =?us-ascii?Q?a5DlmCkQUE3DirzpXSpaDhUgGkX0o+NWaqhMwaTs0pmoi8pAZQ+PUpJV2MCj?=
 =?us-ascii?Q?OXVLt1QF4D7s1w5csBP3GuCLQf4HkWAVoB351GYsGSXEBXOPQuuADle6oGZ9?=
 =?us-ascii?Q?f6QXFDCfo5DPHtk2oku91BCqglbGGaTOKUoUxiTpUmaILnCm3e6U7uU/305O?=
 =?us-ascii?Q?OjuMIRYo6thIvEDJka50q5vh1zVU9db3B0GZRalIjklESYMeX2m66Wlea/y/?=
 =?us-ascii?Q?5Dwj5kQwHedB4/ZFIh5vrU/C7RD0t9JZehuUsaoSQ1AOSy7siiFQgD0lxuG3?=
 =?us-ascii?Q?CR96pXPTaRVTHMDEUu6d1RgAUFNF69WQqfzBsxwVsPejfLyyTlE97NFSk0SF?=
 =?us-ascii?Q?3PBhWek9NB3oYGzB2UUX9Nfwq1cG92WRx1YK7MdvEnakHlKi+5rm6piZ9Qmt?=
 =?us-ascii?Q?81eyb17URHFtEFGJ6+fODLA6aJacsCLtTVIVRbO9QKt8YepaXs1pb2b23rzq?=
 =?us-ascii?Q?n0stzUl7e8lEHqn378DUqiR2WqwYvrW9yqXzaJbagW5N0xeMuF8v69E+1P6s?=
 =?us-ascii?Q?VEelj+pLtgDLZ4BSpubL7rWGTQeJOTWT2n4m2ovEVklpCBH3VeS2Zy7lOxJU?=
 =?us-ascii?Q?qEZFiCoKntnuQB+faVG736ZYrLBihKOrDYJp2e/cAId0RLz6qRbIAM13yUxV?=
 =?us-ascii?Q?volDWI/QwZcupYOx3uqo0I4/1OhP5dV6vXqpDbCJ2wYJDyQCr+1pS1dZgoLV?=
 =?us-ascii?Q?EcNIXlySwV5zAwGwj30hCIjTU1u2315WdfTlgrh/KzQmn2sEugjHarzkhfmg?=
 =?us-ascii?Q?qpNArp953w6WLNLmpuCcpDsdsgkQCkw5qp7qGQYdPDn9//nKqMZSMhEjZexy?=
 =?us-ascii?Q?XQbVAXGrrmKbqA2MevC6rXNriINxmhrBs2DOrL6llpWio1QefHCjzxuktpfl?=
 =?us-ascii?Q?4IiQ6u3mFG0zqxUHtrWtSeF0wgQLyRA/03i29KiXAMUrear73gcdj+kDvUzZ?=
 =?us-ascii?Q?V/6/+FbXq1vW/GyjGCaRbK9vcw73jhe7GLZiQuTP5lqeGkZirhKmIzdLGMio?=
 =?us-ascii?Q?EBk6MVXkga3aYSbSCgcpURHOybREnvOWwPJOivZM/AO4mltVF+tls/lYQaXX?=
 =?us-ascii?Q?l9kwUvSb8blOhDxm7A6CNNw5tzQkyFVNOXD5nLT08Gr/qBbePfP2sFlodt9e?=
 =?us-ascii?Q?Snwdh+Ew5UoJg846l0HX0ih772IRZWtJe4v1aaqFBSwofeEwI4/kbqmIAEc/?=
 =?us-ascii?Q?rp1uEO5etm3j8z8lg6xE55hjB03U0XR0Aj98Hm2ck0XH1UgCxVvPpR5+VPN4?=
 =?us-ascii?Q?qtOraZP5IcRpFxWSn/3GugloequbTF6cD0pA8Jf+ygeaVHLnc5hriYlbuVtk?=
 =?us-ascii?Q?7II+cfZ57i74AsYxbnRHBnGbo1U/qwY1mEtqoitrlBWjfcc5h8w2xrvYn+g0?=
 =?us-ascii?Q?BBX0mJ2FC0+WltfnEVW41gfMox3UFs/kkfMSz5XdzaJH31jv6kfsZjhYKJFp?=
 =?us-ascii?Q?+LIjIeXQcPBS7oNF+Q/9mSGmUGDXhJEV1Zmn8YYN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8122eea6-5abc-4fee-39ca-08dc7ff8cad3
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:02:51.3412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/SpGodGmqIUJ4aystUwWwgI3i0y6hxi2vFY/4lETU7a2ZY9W+G9T3xDmhC8Kwe3mABhMX28pPljVaG0BZDxVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487

NVMEoTCP offload statistics include both control and data path
statistic: counters for the netdev ddp ops, offloaded packets/bytes,
resync and dropped packets.

Expose the statistics using ulp_ddp_ops->get_stats()
instead of the regular statistics flow.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |  3 +-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 52 ++++++++++++---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    | 16 +++++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.c        | 11 +++-
 .../mlx5/core/en_accel/nvmeotcp_stats.c       | 66 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  8 +++
 6 files changed, 145 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 19691917682e..65d6555bb8a5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -109,7 +109,8 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
-mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o en_accel/nvmeotcp_rxtx.o
+mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o \
+					en_accel/nvmeotcp_rxtx.o en_accel/nvmeotcp_stats.o
 
 mlx5_core-$(CONFIG_MLX5_SW_STEERING) += steering/dr_domain.o steering/dr_table.o \
 					steering/dr_matcher.o steering/dr_rule.o \
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 5ed60c35faf8..1375181f5684 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -616,9 +616,15 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 {
 	struct nvme_tcp_ddp_config *nvme_config = &config->nvmeotcp;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_nvmeotcp_sw_stats *sw_stats;
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5e_nvmeotcp_queue *queue;
 	int queue_id, err;
+	u32 channel_ix;
+
+	channel_ix = mlx5e_get_channel_ix_from_io_cpu(&priv->channels.params,
+						      config->affinity_hint);
+	sw_stats = &priv->nvmeotcp->sw_stats;
 
 	if (config->type != ULP_DDP_NVME) {
 		err = -EOPNOTSUPP;
@@ -645,11 +651,11 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 	queue->id = queue_id;
 	queue->dgst = nvme_config->dgst;
 	queue->pda = nvme_config->cpda;
-	queue->channel_ix = mlx5e_get_channel_ix_from_io_cpu(&priv->channels.params,
-							     config->affinity_hint);
+	queue->channel_ix = channel_ix;
 	queue->size = nvme_config->queue_size;
 	queue->max_klms_per_wqe = MLX5E_MAX_KLM_PER_WQE(mdev);
 	queue->priv = priv;
+	queue->sw_stats = sw_stats;
 	init_completion(&queue->static_params_done);
 
 	err = mlx5e_nvmeotcp_queue_rx_init(queue, config, netdev);
@@ -661,6 +667,7 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 	if (err)
 		goto destroy_rx;
 
+	atomic64_inc(&sw_stats->rx_nvmeotcp_sk_add);
 	write_lock_bh(&sk->sk_callback_lock);
 	ulp_ddp_set_ctx(sk, queue);
 	write_unlock_bh(&sk->sk_callback_lock);
@@ -674,6 +681,7 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 free_queue:
 	kfree(queue);
 out:
+	atomic64_inc(&sw_stats->rx_nvmeotcp_sk_add_fail);
 	return err;
 }
 
@@ -687,6 +695,8 @@ mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
 
 	queue = container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
 
+	atomic64_inc(&queue->sw_stats->rx_nvmeotcp_sk_del);
+
 	WARN_ON(refcount_read(&queue->ref_count) != 1);
 	mlx5e_nvmeotcp_destroy_rx(priv, queue, mdev);
 
@@ -818,25 +828,34 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct ulp_ddp_io *ddp)
 {
 	struct scatterlist *sg = ddp->sg_table.sgl;
+	struct mlx5e_nvmeotcp_sw_stats *sw_stats;
 	struct mlx5e_nvmeotcp_queue_entry *nvqt;
 	struct mlx5e_nvmeotcp_queue *queue;
 	struct mlx5_core_dev *mdev;
 	int i, size = 0, count = 0;
+	int ret = 0;
 
 	queue = container_of(ulp_ddp_get_ctx(sk),
 			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+	sw_stats = queue->sw_stats;
 	mdev = queue->priv->mdev;
 	count = dma_map_sg(mdev->device, ddp->sg_table.sgl, ddp->nents,
 			   DMA_FROM_DEVICE);
 
-	if (count <= 0)
-		return -EINVAL;
+	if (count <= 0) {
+		ret = -EINVAL;
+		goto ddp_setup_fail;
+	}
 
-	if (WARN_ON(count > mlx5e_get_max_sgl(mdev)))
-		return -ENOSPC;
+	if (WARN_ON(count > mlx5e_get_max_sgl(mdev))) {
+		ret = -ENOSPC;
+		goto ddp_setup_fail;
+	}
 
-	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu)))
-		return -EOPNOTSUPP;
+	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu))) {
+		ret = -EOPNOTSUPP;
+		goto ddp_setup_fail;
+	}
 
 	for (i = 0; i < count; i++)
 		size += sg_dma_len(&sg[i]);
@@ -848,8 +867,13 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 	nvqt->ccid_gen++;
 	nvqt->sgl_length = count;
 	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, count);
-
+	atomic64_inc(&sw_stats->rx_nvmeotcp_ddp_setup);
 	return 0;
+
+ddp_setup_fail:
+	dma_unmap_sg(mdev->device, ddp->sg_table.sgl, ddp->nents, DMA_FROM_DEVICE);
+	atomic64_inc(&sw_stats->rx_nvmeotcp_ddp_setup_fail);
+	return ret;
 }
 
 void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi)
@@ -896,6 +920,7 @@ mlx5e_nvmeotcp_ddp_teardown(struct net_device *netdev,
 	q_entry->queue = queue;
 
 	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_INV_UMR, ddp->command_id, 0);
+	atomic64_inc(&queue->sw_stats->rx_nvmeotcp_ddp_teardown);
 }
 
 static void
@@ -929,6 +954,14 @@ void mlx5e_nvmeotcp_put_queue(struct mlx5e_nvmeotcp_queue *queue)
 	}
 }
 
+static int mlx5e_ulp_ddp_get_stats(struct net_device *dev,
+				   struct ulp_ddp_stats *stats)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	return mlx5e_nvmeotcp_get_stats(priv, stats);
+}
+
 int set_ulp_ddp_nvme_tcp(struct net_device *netdev, bool enable)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
@@ -1028,6 +1061,7 @@ const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops = {
 	.resync = mlx5e_nvmeotcp_ddp_resync,
 	.set_caps = mlx5e_ulp_ddp_set_caps,
 	.get_caps = mlx5e_ulp_ddp_get_caps,
+	.get_stats = mlx5e_ulp_ddp_get_stats,
 };
 
 void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
index 13817d8a0aae..41b5b304e598 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -9,6 +9,15 @@
 #include "en.h"
 #include "en/params.h"
 
+struct mlx5e_nvmeotcp_sw_stats {
+	atomic64_t rx_nvmeotcp_sk_add;
+	atomic64_t rx_nvmeotcp_sk_add_fail;
+	atomic64_t rx_nvmeotcp_sk_del;
+	atomic64_t rx_nvmeotcp_ddp_setup;
+	atomic64_t rx_nvmeotcp_ddp_setup_fail;
+	atomic64_t rx_nvmeotcp_ddp_teardown;
+};
+
 struct mlx5e_nvmeotcp_queue_entry {
 	struct mlx5e_nvmeotcp_queue *queue;
 	u32 sgl_length;
@@ -52,6 +61,7 @@ struct mlx5e_nvmeotcp_queue_handler {
  *	@sk: The socket used by the NVMe-TCP queue
  *	@crc_rx: CRC Rx offload indication for this queue
  *	@priv: mlx5e netdev priv
+ *	@sw_stats: Global software statistics for nvmeotcp offload
  *	@static_params_done: Async completion structure for the initial umr mapping
  *	synchronization
  *	@sq_lock: Spin lock for the icosq
@@ -88,6 +98,7 @@ struct mlx5e_nvmeotcp_queue {
 	u8 crc_rx:1;
 	/* for ddp invalidate flow */
 	struct mlx5e_priv *priv;
+	struct mlx5e_nvmeotcp_sw_stats *sw_stats;
 	/* end of data-path section */
 
 	struct completion static_params_done;
@@ -97,6 +108,7 @@ struct mlx5e_nvmeotcp_queue {
 };
 
 struct mlx5e_nvmeotcp {
+	struct mlx5e_nvmeotcp_sw_stats sw_stats;
 	struct ida queue_ids;
 	struct rhashtable queue_hash;
 	struct ulp_ddp_dev_caps ddp_caps;
@@ -113,6 +125,7 @@ void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi);
 void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi);
 static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
 void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv);
+int mlx5e_nvmeotcp_get_stats(struct mlx5e_priv *priv, struct ulp_ddp_stats *stats);
 extern const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops;
 #else
 
@@ -121,5 +134,8 @@ static inline void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv) {}
 static inline int set_ulp_ddp_nvme_tcp(struct net_device *dev, bool en) { return -EOPNOTSUPP; }
 static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
 static inline void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv) {}
+static inline int mlx5e_nvmeotcp_get_stats(struct mlx5e_priv *priv,
+					   struct ulp_ddp_stats *stats)
+{ return 0; }
 #endif
 #endif /* __MLX5E_NVMEOTCP_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
index f9e63923a142..ac04b5faffcf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
@@ -141,6 +141,7 @@ mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq, struct sk_buff *skb
 	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
 	struct net_device *netdev = rq->netdev;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_rq_stats *stats = rq->stats;
 	struct mlx5e_nvmeotcp_queue_entry *nqe;
 	skb_frag_t org_frags[MAX_SKB_FRAGS];
 	struct mlx5e_nvmeotcp_queue *queue;
@@ -152,12 +153,14 @@ mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq, struct sk_buff *skb
 	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
 	if (unlikely(!queue)) {
 		dev_kfree_skb_any(skb);
+		stats->nvmeotcp_drop++;
 		return false;
 	}
 
 	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
 	if (cqe_is_nvmeotcp_resync(cqe)) {
 		nvmeotcp_update_resync(queue, cqe128);
+		stats->nvmeotcp_resync++;
 		mlx5e_nvmeotcp_put_queue(queue);
 		return true;
 	}
@@ -231,7 +234,8 @@ mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq, struct sk_buff *skb
 						 org_nr_frags,
 						 frag_index);
 	}
-
+	stats->nvmeotcp_packets++;
+	stats->nvmeotcp_bytes += cclen;
 	mlx5e_nvmeotcp_put_queue(queue);
 	return true;
 }
@@ -243,6 +247,7 @@ mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
 	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
 	struct net_device *netdev = rq->netdev;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_rq_stats *stats = rq->stats;
 	struct mlx5e_nvmeotcp_queue_entry *nqe;
 	struct mlx5e_nvmeotcp_queue *queue;
 	struct mlx5e_cqe128 *cqe128;
@@ -252,12 +257,14 @@ mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
 	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
 	if (unlikely(!queue)) {
 		dev_kfree_skb_any(skb);
+		stats->nvmeotcp_drop++;
 		return false;
 	}
 
 	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
 	if (cqe_is_nvmeotcp_resync(cqe)) {
 		nvmeotcp_update_resync(queue, cqe128);
+		stats->nvmeotcp_resync++;
 		mlx5e_nvmeotcp_put_queue(queue);
 		return true;
 	}
@@ -331,6 +338,8 @@ mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
 				       hlen + cclen, remaining);
 	}
 
+	stats->nvmeotcp_packets++;
+	stats->nvmeotcp_bytes += cclen;
 	mlx5e_nvmeotcp_put_queue(queue);
 	return true;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c
new file mode 100644
index 000000000000..af1838154bf8
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.
+
+#include "en_accel/nvmeotcp.h"
+
+struct ulp_ddp_counter_map {
+	size_t eth_offset;
+	size_t mlx_offset;
+};
+
+#define DECLARE_ULP_SW_STAT(fld) \
+	{ offsetof(struct ulp_ddp_stats, fld), \
+	  offsetof(struct mlx5e_nvmeotcp_sw_stats, fld) }
+
+#define DECLARE_ULP_RQ_STAT(fld) \
+	{ offsetof(struct ulp_ddp_stats, rx_ ## fld), \
+	  offsetof(struct mlx5e_rq_stats, fld) }
+
+#define READ_CTR_ATOMIC64(ptr, dsc, i) \
+	atomic64_read((atomic64_t *)((char *)(ptr) + (dsc)[i].mlx_offset))
+
+#define READ_CTR(ptr, desc, i) \
+	(*((u64 *)((char *)(ptr) + (desc)[i].mlx_offset)))
+
+#define SET_ULP_STAT(ptr, desc, i, val) \
+	(*(u64 *)((char *)(ptr) + (desc)[i].eth_offset) = (val))
+
+/* Global counters */
+static const struct ulp_ddp_counter_map sw_stats_desc[] = {
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_sk_add),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_sk_del),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_ddp_setup),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_ddp_setup_fail),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_ddp_teardown),
+};
+
+/* Per-rx-queue counters */
+static const struct ulp_ddp_counter_map rq_stats_desc[] = {
+	DECLARE_ULP_RQ_STAT(nvmeotcp_drop),
+	DECLARE_ULP_RQ_STAT(nvmeotcp_resync),
+	DECLARE_ULP_RQ_STAT(nvmeotcp_packets),
+	DECLARE_ULP_RQ_STAT(nvmeotcp_bytes),
+};
+
+int mlx5e_nvmeotcp_get_stats(struct mlx5e_priv *priv, struct ulp_ddp_stats *stats)
+{
+	unsigned int i, ch, n = 0;
+
+	if (!priv->nvmeotcp)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(sw_stats_desc); i++, n++)
+		SET_ULP_STAT(stats, sw_stats_desc, i,
+			     READ_CTR_ATOMIC64(&priv->nvmeotcp->sw_stats, sw_stats_desc, i));
+
+	for (i = 0; i < ARRAY_SIZE(rq_stats_desc); i++, n++) {
+		u64 sum = 0;
+
+		for (ch = 0; ch < priv->stats_nch; ch++)
+			sum += READ_CTR(&priv->channel_stats[ch]->rq, rq_stats_desc, i);
+
+		SET_ULP_STAT(stats, rq_stats_desc, i, sum);
+	}
+
+	return n;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 650732288616..70a8ea5cd7a3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -132,6 +132,8 @@ void mlx5e_stats_ts_get(struct mlx5e_priv *priv,
 			struct ethtool_ts_stats *ts_stats);
 void mlx5e_get_link_ext_stats(struct net_device *dev,
 			      struct ethtool_link_ext_stats *stats);
+struct ulp_ddp_stats;
+void mlx5e_stats_ulp_ddp_get(struct mlx5e_priv *priv, struct ulp_ddp_stats *stats);
 
 /* Concrete NIC Stats */
 
@@ -400,6 +402,12 @@ struct mlx5e_rq_stats {
 	u64 tls_resync_res_skip;
 	u64 tls_err;
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	u64 nvmeotcp_drop;
+	u64 nvmeotcp_resync;
+	u64 nvmeotcp_packets;
+	u64 nvmeotcp_bytes;
+#endif
 };
 
 struct mlx5e_sq_stats {
-- 
2.34.1


