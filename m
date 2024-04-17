Return-Path: <netdev+bounces-88863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9268A8D11
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 22:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E485B1F218B7
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 20:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AF73BBFF;
	Wed, 17 Apr 2024 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OOVli5i1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A60E2C69A
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386366; cv=fail; b=ASLrOVm6Y0ux6w0lqG4MK85VdLqMcVzTcE0iGNQw0LoUiQn7Yx077JuOPF8nhkLT4Sa+NWHkdy3W9UqNbta92zae4vu8Vfj0Nv74Qms5LS+7F2/1Ss+IPY9G/l76k68iVdu1HUnrUUKz1ksBXzcBGTA7Tu0S0PGpUjwrTGvp8aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386366; c=relaxed/simple;
	bh=XXqzKR3HE2jjynsqPYqUV400HwR3+Bx0aI5dG6TGOZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=c/sTLRA3bC4MNRdJtcqiSj5q83n8KHcRrs0x7FMUdY/EEdUjtSaiBbClHVQ+k+bsgmgb1HDrYpmMLd7lZ1PORXjoAcCr1EFC2PvMosXByR7h80XzAxRFF5qlQpH0l02WHXVwNJMknhqdWcHRx8VCBVAPnV5xqqwQNbrgH0w18SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OOVli5i1; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tb6gVX04aFgUY1uy+Q1Wc5iTLj6JYiw3C69r2ca7VIdL2vFbGkQ2jVJQLuXtZAfx71rEdWUQUpUXj+h1Ovo2I0ltFX5QJai0Tnw2/hkkFafZydN+8MKixbt/p02I0NvhAAaVtJUy/f4mIkZhoD/247sD5yr6jRGBYUkG0a5/xpgzdSxevPeKo3iWC9EkH8CvvP/1gEEZnYC9whFbkOyyW6pTw2daZHbxd86w32GMTDCCDOn7oiAK8dz74HydSJaDyO5tatHYE2nJnIIwMyIqYLRGaLRMM1wGBJTOSkK4ceGiuAKW6vAdsQaRfdjFtXWrebCNYqktvrkQ0ososSWYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8SpFa0r0q7U/6iYYb7mZ7lNIWiGCfYcPJP9PrhDQ6E=;
 b=Eja/cuFpK93vAergZ2LO6rdrNyMQ6BSsDj8wa0uiTMoqEXT972YZzS3CWsRfjBws9/PV8CWxPU3rdG0MCjgYZNqKtzW6vhq8wkFxm1gh32nf118Dwoau/dPWUiTXg90I8Y9FMXEzN5aWkGZexV+5GuRqF2YdszF7CCpf7c1ErOMSNntFXTtXXIYSSurWPfdzszgSywEK2vPwkhIB7RwrwJGeujrsgyclZFiNJ3pQRhjPoWDqqPx6DXKfkbVPJhCCK3NxSPJKhX/dCbo+F1mdtCC+DlYYbD1PrbhmA9eIaTElgljMdXIrAT9WtLQUlD6jWN2NBIcN2VzhJSVoGu8WjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8SpFa0r0q7U/6iYYb7mZ7lNIWiGCfYcPJP9PrhDQ6E=;
 b=OOVli5i1NjBdEPBebDdrXj4a4UJJ7/c+pq8PToK6WUUXflZsrzcgn+ksraDUQ24DXW4UnwhvSmTj2U4KuaanTWDSJuz72wclawvdFcrWShlw3wtYDu1meW9Fw/bcdlXr2RQNsTeepa4gDeBQtrHl17wSxpOMS4XeVgAJeexk8QQOowbhBXbC/k7IslS6xbCj+QARCrEa90UTq3Lc7MrhLhoAGeVGW8L4VHjxS3rmYphiCmvnOi7x7NU7F0wLBGg4S8O6QWCdekhfB3fbnqsB0XlPl1Gp7b57poXpH+hJP84W5qUV6/lyHN6aq3o73aUsga2Ns8FtSXN/j3oK2rOi3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 20:39:18 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 20:39:18 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH ethtool-next v2 0/2] Userspace code for ethtool HW TS statistics
Date: Wed, 17 Apr 2024 13:38:27 -0700
Message-ID: <20240417203836.113377-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0072.prod.exchangelabs.com (2603:10b6:a03:94::49)
 To BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c4816b-ba45-4bd7-049b-08dc5f1e746e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0cRwSiNqPdqTUARwXk3ZmFok/8GXyZRyxayJEi9VrRSYFW0H1Mn9asnqNRqjV9+CXO2PuF5DxHhVO2yYiNs2y51ynbn84oVMCW8WXeqn6Jogugc6Ecvr6ttEB3zMmlka+1qozJQKZPh/K8J0KxKjOQ8Go+mf4qzGlnMn+N4oUaFumeHcZkT3HYdCSIStVWXK+7RW8xV9EwbpP2Ufs3EaRGYVVOxM7GuwxRMhUZQyK4paNHtE4saKZ3Ptvrr3hs8sxBO2Vbsws3S7xAJmLnvCejKTVqIdQB2S49TLcO9xaU1f8pNBypmGrV6MlkcdkjrFbveLqXJJ5Wac1mVhn+KjGk4prjuctF/XGzxciy7ZsgNzVOxnnLhaX8NxDJXurgHUQ0pxeyizr1nhouMTu1PE7s4jWKEdNSirbNbJk9iDh0reZxqPhzR2Q8700FuVfSdBMAlInuPRz6O5q5Dpd/E/YzI6icvt8tEDh2GbKIFofG+AIBuEr7YynMnZlL3kO90n/pWc8LBr1lFgGAcCh8hF0nPjwM72XaKMCaTKVBchhfGMdMyQPvlBZKak0tVKnDb9L6fAs+q5nx8kSl3qEviy1CZm9iwPqcdSjmsw4Aq/WatV0XXqxnI2o3F73jefSAZLEXShVQj0El1/6u9nJOFsq4Pzb7Xi+2G97UFqwqat8q8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9uhjbmM7I+5W9uWGtbSk8xAQt1FRUS9ma4GrKNWTwsmZtGs29aEcxN+1uZYo?=
 =?us-ascii?Q?NiMGl1CzhcLwZgZu+lhEBDSBshV6uXJQfSUi3/CXdCxao2YOSVPdkjHR7632?=
 =?us-ascii?Q?hZfo6LSlXzRJjJxqGDDskfXu9+9Nm+NqIpVeFebjNb9+D9YU48vqVIW+fWUr?=
 =?us-ascii?Q?J4yUJdCaWMog7k6woZc6KDs/MHE9dfcBQ0YWspT7PL31jhnXkW//wTETHFCf?=
 =?us-ascii?Q?bqVVUMxftXFsbCkARxNW2ZjnlMf0eugF0o6Dsk/kQ5bD8aKxk33wdxbQCyg7?=
 =?us-ascii?Q?guoD749z+AAkwCVYF99zOuFhQt5tMf/qejXP6VtAEBZhN/vCFfGr0+viKZbJ?=
 =?us-ascii?Q?wtKN6vkvQkOLJcJ6Qg58N/ZUd5xNNB4umiXfTa+sbkWfgxla1v58T2pD7JuV?=
 =?us-ascii?Q?nf/Dd38Nga2A29kqDCWa+MGdqib6Y+tobsoPwm89g0pU5ym7yoixUuLOMOOr?=
 =?us-ascii?Q?o/71TVdWX3/19Y/ymufNSV0jEOt/OyEuIADY/SYIVg8wt3gm/Cl7JYn94gwr?=
 =?us-ascii?Q?8D7Lu4Uy0Zuufzoi3AR7Cmy5+lPZISufpEueiXsKc42rFSnSg9opN0kzP/xv?=
 =?us-ascii?Q?gI1ae7zUIqTBFo9yZtjEHpHQRACOv2VBGRjnru7U77d8yc3+9TPxQqUwqrx1?=
 =?us-ascii?Q?4flNe/2+SGxUokZULdniHuuf1UYJe0k9IDMedKDAhzv8VTkecZ+9w2a8rVRn?=
 =?us-ascii?Q?zzlTy2KJIJCfcX3qzMCuPl8bprwZcMD7w8/DYkofVSE3W+gyRm+55+WB3+vE?=
 =?us-ascii?Q?a17e4jMffMy8FLILt0OekxpJy0hTmFuTT921BMpW2+ehiykFt8IZrw6QdKEQ?=
 =?us-ascii?Q?72vgqb0xaA5pap8/0IYBxp+2Re0BWKfSIzrv1lLh3Xu8+TwvjbfBSzGtwNGD?=
 =?us-ascii?Q?qPSyas/JqOYqJv55NAqTekYINfkYWU/umZnsy4v8Rdwg6mFpNnSzIoH/HTsr?=
 =?us-ascii?Q?s5EVg44XXoLbamWpkcNtkR20GXY+mKPzYqWu4zhzjxHcN39mugwb9jWmPlJ1?=
 =?us-ascii?Q?cwM4B5OlOxJ6Cj00dMVAZ+IPdeKASD5SY5YIOTCjtzUdVVcnxKB1FMSqF/6T?=
 =?us-ascii?Q?jkdRCafrWvyKPQfQpZ9+6Fi+WA501B1sgSe/ap4vyen2/2lqs9fge/msRYOw?=
 =?us-ascii?Q?YW6zTwW+5/CAegaQfJQvFt3kzCXtjhB/rFumJ/IisWhyVhEPP8/1/9ayKxUN?=
 =?us-ascii?Q?8eW2fMTA0XMf/g/pxy7ZAjUBb5V7llbrPiCecfaKUTVZDu8gVgo3wc+t1yzV?=
 =?us-ascii?Q?oSbY2XNEO+CoeGLOLrxWo+w9cLWvBeoYpWCFZpSl3XOxTkLLDaPuGtXY2W08?=
 =?us-ascii?Q?8KuNIwN2TiPJ3V2Fd/ejsD5bL8tgNB3mjt5knqtS4hJxv9cRrLAonih4ScWP?=
 =?us-ascii?Q?a3vcedXCOTJIrxACpums6FgVQn1gdgRuoZUPwi1jkQnfGeaINLdguuf5gnVA?=
 =?us-ascii?Q?qrvXz1nIFKGRyTuGpAZvwFNqyovD4GiQCT1/0hc9tC4SQWNSll8THpwymMVA?=
 =?us-ascii?Q?dy1ijglryRVx+kyzxh89YCc0Axz2TN6U9iyhvOOalJQOWQfYozKwnQT41opM?=
 =?us-ascii?Q?KDByuxH5hztpA36awVOHGSqsMI0hK6erJYi7JxfYrwJyNKM7I+ZPK7J904wN?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c4816b-ba45-4bd7-049b-08dc5f1e746e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 20:39:18.7973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WQFahKSQHF2Fj5QKcizH+zBXSPYESf07qGF20XuiRrxBkX1ceoUB+2KpCM4sWa/sZrVoxznOXTTT5XF0YQc7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243

Adds support for querying statistics related to tsinfo if the kernel supports
such statistics.

Changes:
  v1->v2:
    - Updated UAPI header copy to be based on a valid commit in the
      net-next tree. Thanks Alexandra Winter <wintera@linux.ibm.com> for
      the catch.
    - Refactored logic based on a suggestion from Jakub Kicinski
      <kuba@kernel.org>.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Link: https://lore.kernel.org/netdev/20240403212931.128541-1-rrameshbabu@nvidia.com/
Link: https://lore.kernel.org/netdev/20240416203723.104062-1-rrameshbabu@nvidia.com/
---
Rahul Rameshbabu (2):
  update UAPI header copies
  netlink: tsinfo: add statistics support

 netlink/tsinfo.c             | 65 +++++++++++++++++++++++++++++++++++-
 uapi/linux/ethtool.h         | 64 +++++++++++++++++++++++++++++++++++
 uapi/linux/ethtool_netlink.h | 30 +++++++++++++----
 uapi/linux/if_link.h         |  1 +
 4 files changed, 153 insertions(+), 7 deletions(-)

-- 
2.42.0


