Return-Path: <netdev+bounces-88472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362FF8A75C5
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 22:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367251C209DF
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 20:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6BE381C4;
	Tue, 16 Apr 2024 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sBzp55ZE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECD92231C
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299859; cv=fail; b=a6yrrvViZPce6qQrG2fcmbdVWGpS0yDqQHPMVt4KUxsQ+JBK45jfrEzjYm2qrrnFxGJ5eip4kHkl96D1XQRMbc7q7Y0uDH2wXz6hBF7tDelt4qMPssXbN1l7boox0IDNrTzUEnGtAUEcN2kdPSbFCeTSJKCv4HcOY+ow7/slowY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299859; c=relaxed/simple;
	bh=w+Q/MtdK65E0BDXdfrmCJHyvZY4lSJnbNA3xlFWuB0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eoxbCVhAk4wCsqtYQRd7nbcOaog+Ua6OOIsst0QNLsLUQLS22UheG4N5e91n/8+pYPGa66ZnWzMYTFM2wOSZpnD4D5ReiUMoJ/RecRqUIS4exDoiSnNONaMFlPlTjJXBeNNxyxHruaL0ra8fdAuinB4iReAIuwLbEfh/sJl30W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sBzp55ZE; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EndiYX7TQaC0egVKte6IY2KUnMT5umVQci4mhoasU/RxatO9PXjra7ovnXZkibFXNi/JNs/NXfH+gbfvF4qm7T7rvGdyt8xaNx+WJbb/MYJuy8Fc6rAH5JaTYJ6Bn5QhihO0Yjn9uHk7WTRyDOh/7q5uRHM8j3mCRtNZrf+xE5uHGOK58D3R4tOXMJpS17/sMOHWpD2bfkBWzaXr/JYEKfoZKajQ37mWK9Y2LcbCp4LpfXM2hhBkXuM8smK/wBa9uK9vkNdnG8S7MfHNIkU6Sk4uwHPDN/Ycg25Xot9R7BeahydbgsKTzCgxdJFnUo2bbl83bMY5mXoxrXVCw4Xz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/vTxPusR9yL2Ghkinn9eFlQnLYLfiMtyshpbLVJi7Y=;
 b=a3EmpOGrJfI1wTFiKT/kmxscFukHVkS7JfbgKMTKFCfjJWwh1BbJHjHnHPsaLFB5qUKCIFQjE5/jIzdEQHyrdgKL86jP+YuRTMnOY5GPCPkk1jODwmpIxa2J/RItIQrfWEIdjyzHB7hRZ7zvbTJMvs+rHpZkBpmyCiTMaYWuILuazUbUvz2eeRagvfJX6MCA51ixnqaXDqKxCelEl7G8Em+Ktnf4GDI04rVdnQiKKIi3SDbY9d9tcGwMmEkQfhbcruhuuRMuUQKI9tcORY4cahqrs0E8jTjOSBVHpAGnWegH58JSX/Ee7uoz+MaHcnGJRZSbLak1uCMGOyz22eDzZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/vTxPusR9yL2Ghkinn9eFlQnLYLfiMtyshpbLVJi7Y=;
 b=sBzp55ZECh2LBqE/RcwJD7tZi+iLd1VlpvYWY1CqrUbMVasS8pp1aWWPoevDHYTaYltmGEe16fa9z2cdyuXTKCzkdKh0qNm4GFkdz61Wb3j0aodjALG6t1Kcse4Y+huFAGIP1jIItDyMBszI8/DVXrJrS5VbfTTvFoF10uTAJyhLhtrnVpenQmFVhTqs8/dCeGgNCRBHCt7BVLw2hALQ4FbPZbzKq98hFHsu473Clr8VEz9r+ygNITVIzKvhzcNHNL0L5rHA8un2YX4Itbzwd4UBd6Z+1jfkqSqw0MkwHsgaiZtMaLQkuUDk3b1bx8dw9rUrUOnJJRpJe07huqPjkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 20:37:34 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 20:37:34 +0000
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
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH ethtool-next 0/2] Userspace code for ethtool HW TS statistics
Date: Tue, 16 Apr 2024 13:37:15 -0700
Message-ID: <20240416203723.104062-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: ac93ebe6-d150-433a-b833-08dc5e550be7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yjHdrAy++vS28ZFpZQrPSd6EEcdsbtWWTCNYxLF3G35BXNo+fmhMvmUD8zw8OKJH0WQ8+YHUQG3mXZPyBXJWomB1I1WIlhCB4XT6+jpdcmssDItz9jiG6pYEO3M76GdA1Wa/9BHNa0Au5xyDzwhmDllhwEGRMTwZT3sGrXbeQ474Z6fg9miJ+VKo7topCOOM3YXAzBloEbjMmhj5168UuSY4EVnYQVFFvUg4yp43y90MjJVl/34eZbpOhijhBWlBroRaoaF2rGUdOjR9hkA+lAJZ41pKzfw1bVZ/K+ildIumWc1JHPmcAEdKT899C0XctZ1VX1QglMab95UVcOFIn936CdJckacZFqCIziBBkwN+npKdS0ykS2dGGATb5qasds5MEgWXJj+wm8t6YJFcFABcwadQpaNt1yHqT/9pYeI0j/ge6TM/XgcLBeZ90eDAHodmV3JwiUZhMP/nBXSqpqghwQpMqolSrkt5K7eIRooMhcNFjih2+dndrVlttVq5qPORCZSestHlCRX/NHivS/lc9N7W1hqSeTQMWXUatbsm6lrJPAvwlLTsfDHb+vPyfuezh8//k25B6NRyKop1SBlfByowxevWbDgOM0XLCOliMiKvH6KQgr41VkzAi/k7mAHv1zB4Wz1FCSFy4qpxqaCk0Yo+fkEiYM5YQzQUxx0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+8lHzATBYfhCsFyVsDMSSxH9+a2/GJcE/+VMmD6bYKtcG2+ksPPydY4q7bwg?=
 =?us-ascii?Q?2HeNa2WmXLhYTDUX+G/UfaNcrDzQt8JfBfMpo136o5uliUbLBqcCiiCnMRO6?=
 =?us-ascii?Q?KEO8wu4fcCPxVxWbiBhj6OF37nTydpcUA9dNetKcf0vNB5exjp5MOFHkFPsg?=
 =?us-ascii?Q?5NqNnvwMYz6/qN/eo/R982r90rhoQzhrSLxgv3A3Lp3NQAAvuxIAtJr1ixYx?=
 =?us-ascii?Q?aKR6exIRbwq5NdRiDO4b1U2Xm2BcqMPEW6W97G/BVRQXc9u3RiV5xKdhPWl5?=
 =?us-ascii?Q?TamiIj9H9DpnqSaN8fQKCurnLVsDzofPM6+yG5CickI9iMikLANRFSW7VMCC?=
 =?us-ascii?Q?QM2ejK7LHAhURhzlH5tXCn11tYInEo1sqM4D1eqFvJSTGX6ySrh/oYMqN1iS?=
 =?us-ascii?Q?9vpnodqRpqEACDvhtWnEh4hDzWYVe/XRU23Q+J0MhykJL24eq+bgWeJo9ILy?=
 =?us-ascii?Q?zBcy4zPKdaL424+1AcAYddqinfQ3g6V+NzgTydiC392fHiqsJZY3dErnjvib?=
 =?us-ascii?Q?IGnUvCDXoDcaoJI5U5T4DS65aOf/nM4Wlk3qEcOb11ik7bKt4rjPspJX+R3H?=
 =?us-ascii?Q?qVEq/gQm7kjzy/EkD+OVeWhAiP6AzbSCotp5DPWBYQCn9X2K9exKo1n86oG5?=
 =?us-ascii?Q?e2IHBG9/OFqICxXoNI13JAAahIwtzH1ddbgb+RnbCP4HqUgqPZ6QmzVRsii7?=
 =?us-ascii?Q?GC0pRFI12qamPo7RaKpSRxWPzwQtVQabZOmfmMvNAr9AM2aDNvzP+Z6OF0T7?=
 =?us-ascii?Q?BUvrKoLgH3sWvlw58aEMvVfIQl2KERFAYLAsv6B9GIs/WmG9pPQReNUZuHE/?=
 =?us-ascii?Q?dbZuI/ve+C/PZ/anbrSo66B7PpkFbBExocNlXNsK/rHn0USJxUwW0XBMSK7r?=
 =?us-ascii?Q?Ec+Ph8wNJxaEdfe/xmN+2QRHfDOHXKLUcRSzQrTFkyP6TD2xh5RaxHouj76j?=
 =?us-ascii?Q?A4TdA/QfXGH5k/Hf/00sz9zTJtHOtjzlECKouuS9dXfkLEKWcYls88CwjP/J?=
 =?us-ascii?Q?Q5BMHsW98MRT6URT68xN2XBH9Ltx6xGMUq4zmQeRzOvtHbAOUQRIH2v0H0s/?=
 =?us-ascii?Q?zvxcRyLfY4XpjvhoeOtHOUF+1vEScoJGS4mgUb9H6G/vWhGovO0mvr4tB8Nk?=
 =?us-ascii?Q?gpqud0WUTp2Pw/UEanm9zZLJpHz0XOBhaZ3sPCszjucewH5W7MBwnpw4EkhT?=
 =?us-ascii?Q?/bdYBzfjMmOeJkwVUshxM4Gy7tEN22iSRJt3LXnC9B8psLquYqdz7bacotVT?=
 =?us-ascii?Q?jmNXXiKk5CIIblXteZnimeggJt2ssDxy/nyzbMwsdEX9VnSW16WWNO7kAB1y?=
 =?us-ascii?Q?Q8eXDmNNlupdoES9DmvDlFT4e0Q4ZfUKfhzJGQ6+HDYOGlM/RyA26PZdMnnn?=
 =?us-ascii?Q?5x4YADkSKFmO9BZNu2kLI/OybKAJQV/AHGoS1Ycy9hMXDNZbarCFhaZgP51L?=
 =?us-ascii?Q?gYuyaCc9J/+NadRCOrFq0HPjxvOmH5SR6kwCMIRLgdu16yKcGsWsZf8jp8El?=
 =?us-ascii?Q?tiM3z7x3aYZ6ULBj11MraaHNWBhINwholW0ovJ/550Q3yefwsqT/8x5+Zh5b?=
 =?us-ascii?Q?RsAUjq58kMJ3rJO3fWQCvLzS62a+3KdoZeVNP6HBKYOK9dk2ePPYTLMLuMLO?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac93ebe6-d150-433a-b833-08dc5e550be7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 20:37:34.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCASVoKoyxekatFiIrLsfi/f36ysCmWb0SAn9yeWmYYQ7jEDxADbf8entOBj0oVZlnJ/z8Kb8lYWMWPFeShXSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790

Adds support for querying statistics related to tsinfo if the kernel supports
such statistics.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Link: https://lore.kernel.org/netdev/20240403212931.128541-1-rrameshbabu@nvidia.com/
---
Rahul Rameshbabu (2):
  update UAPI header copies
  netlink: tsinfo: add statistics support

 netlink/tsinfo.c             | 66 +++++++++++++++++++++++++++++++++++-
 uapi/linux/ethtool.h         | 64 ++++++++++++++++++++++++++++++++++
 uapi/linux/ethtool_netlink.h | 30 ++++++++++++----
 uapi/linux/if_link.h         |  1 +
 4 files changed, 154 insertions(+), 7 deletions(-)

-- 
2.42.0


