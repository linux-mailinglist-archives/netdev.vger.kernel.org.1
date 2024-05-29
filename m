Return-Path: <netdev+bounces-99096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DFB8D3B9F
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C662B1C244E4
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB51181D10;
	Wed, 29 May 2024 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fWva/Onc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C84180A61
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998484; cv=fail; b=Pd9T+5bP9ildRc1JIVUMjYv6Z0fQybxGOrl6k/Bg7/PaFtDgo/ofjHDWNqzJU9QkswnvjOEQQpfrtQ/AHWZqIHVrf1Ldc8i0fi7JM5Mj1FinQzfvQR+5hHAFh2xysOdSkjIYAUe/5QfoeB4GXC9YBymUB5UF4mWnPZOTrb2Ig1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998484; c=relaxed/simple;
	bh=W4Rs14ibR4k6sehh3D8v8wtphPXxPvBoLHnpI8fo2GI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wr46gpxD9hqHNeWdqMmdwd5SsZoO/ZWC0FlECSoVhcM98oG3karlBb/jNKnaOsEXU47fFaY8/P4ECsfQzBC36U4r+8qggJpkgIg6P0VALxwYiA8lynWuW/jKE79M8cwaMXfHuB0bswuSh+lTb5nhMhqgK9UfJn4VXGOWbJ1pGUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fWva/Onc; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZUrweW3PMnxcU3xZ4Cbw9NVlPU5tsriDH9Jn3wD8CEFZpuAMInpawArt5IKURfZjXHSWcmhr9eWa8r72w/CBTvjrgL1yOrf8ybk5NOol7u1rLbqUyY4ck4yWVFzcAyvipjmQy3K+HAL/QdVVEY+yga4oIp9Mr6At4diXaAyWgF3AScljWGfdfqdrnDeJMfE7/KVS2nU1rDxSx3oR4udy2BlKEBa4YPTngJ0Szvww2uK52gqy7saegMTIzWu4n/iX8ofdwUkls3+6AuaieVnkPLY/I0xgKIW4jumLTG1Sx3CNG+qn5MSizGTm46T5c4nTa9dw9NPjqcwQpdbajqH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUPfuYxUZaTFD7QjBwLOtSL+lxPoVYgZt4I7tltB4Ls=;
 b=WfHhPhrZxKh5aI9c7fyu26DrmqQMXH1S/0TdiKiJWq3rpeNMG9NCOs5qlfHDGcqtHdc4/ufrQGSzBM/oA/mJWLNMmt6oaqpwG6jmU4nUDkjTBkj+k/2Ue6WZFc5ABMlrbryK214+FvZtxFI1AViM0QUw8f2ig6APVyfLAm6WK5WTmSpsv5EDEoUckkBPRDTUliG2WsxqQsjHOrvLcOFWk7DeUdaucIFPFW+rmeDaxZiwwhC9M9huLmLut7A+a/p/oT/Z+JSAaa4Ur+vmzaJDE0aZ3fEMsaZ/hdScyOrkekZyGpuMbjBsRiVIMFlUCEROr5vSyr4j+F9mBvN6kbLzhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUPfuYxUZaTFD7QjBwLOtSL+lxPoVYgZt4I7tltB4Ls=;
 b=fWva/Oncn1JUPCWGF3KG+W/VtipHUtR+dkyDFTZl+2gDHan+2p7m2yOMUSMauxobu8znTjMdQGRTrD1gHAbNr9LpBPWPg08l+/+9gZWXOV3Kxs/mDft9o2+5J+IOcWTC2TSsbLr7MjtQ5ZZfWPxA7Ky/IQrzCRI2fwTNu1yhLBGNCvUk8mry3vQ8WVKa8+OCCEqZxV8TkY+pr1iHIpzf8GW8pYAq4Qd1bfpLUyjd17iS4Sd07ZLkpyrIqy9T6FLBqcNzNW4miCPl5w90G8tMunEjnQ9nO2TIbGQDAPYbOLbkug3UiKmbTqzb4052NUgkeo0KmI9CqwjnTda1+QjzLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 16:01:18 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:01:18 +0000
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
Subject: [PATCH v25 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Wed, 29 May 2024 16:00:36 +0000
Message-Id: <20240529160053.111531-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160053.111531-1-aaptel@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6d0d41-72f1-45d5-b2a7-08dc7ff89347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cVzMOo008haa/Rqr72UaLn08UZADh9Cp7FABgxxeo7Kw1w5NIRqCW1eqosct?=
 =?us-ascii?Q?mjRj8P2cCb+D+zMj84HTOGnRF+W1YSXn7bGUCGGcJCq5zE8+QchWX59AvOZr?=
 =?us-ascii?Q?M0xukFvMSsFcOxXLy6qhEfmbuLEW7vT/CDtyL7bXUxXBuxk257us6eUt+Zyi?=
 =?us-ascii?Q?BkikRakRRHP6suN0i+lGEbssbDxKSUQicxf0RdNHkfGz7AgeGBoNwm//rCkc?=
 =?us-ascii?Q?hGOFvdCxc1emKGdcgac3MgzUQxjUlv8xF4zhCXyv1XvYrq0ncgJrdTmy53eC?=
 =?us-ascii?Q?jijJwgNJE3n0gJzCiEn+B/+ud2SuMomV9Lk5bsktWY+ogUSIHg8PkY+awM6/?=
 =?us-ascii?Q?r3+1PLttp0tVg//hEnN32mwn6k/EwojsJOf7ofdiWBbeL64/gQp+8TuHSRQY?=
 =?us-ascii?Q?BOQPRUN2gYJWeqsng3nNB1qiyQSnX2qizhyBfDJ6mXVqbkr4XPsFag9+RJoG?=
 =?us-ascii?Q?vyHj0QXgSv/JjaBhxY3zweB84X3jE78BznW178vO01LWVeixXbwIg11xbpNn?=
 =?us-ascii?Q?pwqYUVJhHI1UFpxaOgF1FIVD2HL3KF7vvn3/vxNag6vGS9gTH/PiQu0TquJE?=
 =?us-ascii?Q?EQqivcL/xfZkiCcnT4Nh+MIvJYd51kj/+fW6eKNl0+2PJbmCnVCIaOquPkcK?=
 =?us-ascii?Q?52ENtU4KtcDX5MPU1Nkp1TRGOEc0VeOCKYFe6ekec4WXX8aw/R004YnGUuWA?=
 =?us-ascii?Q?Fwf+zD1bAacTZ+V9tgOwwfmTpJ1VpNLVz7ybNUpIupxw144+c/XrsSoelKEB?=
 =?us-ascii?Q?aj3mMuVQLOrv6QmcuybrIWAIhicDCcpe0ltvwhhzsSo2ckqQMDO4HAp3ngPH?=
 =?us-ascii?Q?J+zwesTzW3fbE9MZcFV6RiAdJJ4fV1jVsSDC6qXn1ywuntkHKtASk+3Yoo9G?=
 =?us-ascii?Q?fRPnlii2UYBKMEa3yzemt2qCbPAauHqxx8i5zlz/bBBWBWf2Pfe6yyzYOo8s?=
 =?us-ascii?Q?HFHqwzu6uwKzs2fRAxH8KhK+e/YwnIm54ufw+ygpYe22B/Hob6EeM29GAvqF?=
 =?us-ascii?Q?jSWZyYfHt9KCTuoIRW74QO4Qx7rmckaCKC2SeOLuHUnqHmQXH0v+6et+0oTN?=
 =?us-ascii?Q?2IG8koWZrPGU9Wk5tFc3qkhL0kcmzVxzrEPVr0rHZ6FEgN1nGasFCT9o49d4?=
 =?us-ascii?Q?CI3cD0T7o29AkUcDfpOKGZCAff4ARyoOhzWSbTX8IC6wOCz4J/UD0ki7az4P?=
 =?us-ascii?Q?Gi9RbMVtiTUK9q4v9qvqsxLrv3YL4Xt4abQJFJmJrvwiHJNf5ol6MFuPHzFU?=
 =?us-ascii?Q?Worjwf6+cwPo+l4Uyah9TLDWYmAqp0duVTMaK//bYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qD1QGbeiISbtfagubD9Cw/UzYEtPTVBDvt0Sd0MfHKoJcLPV1Mjd65W+iy89?=
 =?us-ascii?Q?d6Sljrb1b+vfImAcSVykZl5XVmxkP8tBRhvFIJvq0P73pZDUBa2S88WHxhay?=
 =?us-ascii?Q?qkbVWLPhLWKP+NcKWBJbSNIztGBKPuyTXZjpsoiVdU4N4C9TDJNxPradeT1O?=
 =?us-ascii?Q?QvrmGmeE/MkmwN0j6pOu+Iv2hO1YCMKfIWFReiv9CHxmdUfe/HP51mnBsddb?=
 =?us-ascii?Q?4U279J3GRm+teibVR5P7kDYni7qVHHf0j8Y6Ivd/XLRfmFyvGBHZ+QRbfk04?=
 =?us-ascii?Q?yYoyxoLozHe8p+zvWYgBkWPaLExnYHVLUoTqEV9EmRgqEZ2NMzf1h7IEoFkq?=
 =?us-ascii?Q?tUzfXcUuM5gp2OENlR++vZYOPwnVhJUII4mC+U2WQFmpCBIoad8C90VvW3rl?=
 =?us-ascii?Q?ms2KDYnonBdrq3RS6enYvSaLsV0UsKVS8dFfhBLp3i8c0Wo3HgRX82HBvHEb?=
 =?us-ascii?Q?fkCSKCTzpQVHEnKZWjtNUl1ahihAZ+sD9WQVKM9CO2Pp9QlWKHcGwuNEZCnx?=
 =?us-ascii?Q?eaOKAFL9SNAlMSnYOq/inlDltEX1qk3L50aAPBg+7JGuu0OMCWeqUbEF3S1I?=
 =?us-ascii?Q?vRSgC228YbYAdDZlW5IC2KlGPhVRJOHiGecb9sflminFdkIKAasfFYnx9hKN?=
 =?us-ascii?Q?PAvkF2vcikngW+jbo7kk3OffwkcHqApsvRtkNZF/I1JGqC/yDzocWh31nqMT?=
 =?us-ascii?Q?C2Kg2wlP5PT768GHpfpVHHtCLodSMscof0XOvXoXF46eny5T8CVtS6j7Y40a?=
 =?us-ascii?Q?kT35/RK5lC2WC3BwfgSfbnQUzPi6c0PPGOU9V2iVlupoHXnKeTrvrH4oKjpl?=
 =?us-ascii?Q?KvEhsBowmQCExh82Q6kvhmNMxpBaRSCTe0qCoqO8ycNcvUiYEwpBf4F6qnjz?=
 =?us-ascii?Q?wv7BiyQEHSjIjCjsaajMoe6FbC79jyzM0QQvuSM5WtXxnZsgRitrOSZn7XcN?=
 =?us-ascii?Q?FMLaAJYB5gXedBrrgSpplfP0VXhcwCLsiE3zgOHYHhDWj/aA0Tl5nUlF7SMn?=
 =?us-ascii?Q?0sV1gLX3H37NFmut2vkBz8E5FvxEt9U7Ttb68PuNkdAOrFYG/f4Rhey0GE5V?=
 =?us-ascii?Q?9BZTnYfn8hXXI2d1qGeS0Ry6lnQp7IqyCB4LDO3oLJWM283EiDWhnOr6La3G?=
 =?us-ascii?Q?BIASpXrdeDfkBX1+58K+nUM39lx6nEu0gP2u3D58Hza0zYKyVgP+bPc17h4f?=
 =?us-ascii?Q?bUkErhfixyMoKTDM/oeWjr80+/bS1prOCO1piAF0giEE6MDM1uLAqB5AHC7n?=
 =?us-ascii?Q?pMjWIhS0Xd6VWGpftT+4NjSGdMIAH71VyJV1fu2xGqieTPhtLPRBqtJXeYcP?=
 =?us-ascii?Q?GOZfIFUBxFrguJ09fr5bWASz34vvJq5gJ8tX8yM6vEK0sgYWkCaawgRZB4wP?=
 =?us-ascii?Q?a/4W91BiTMqPR0oKwVW+rt/O1uZlBVFeM6lCXpSyBr9mOI6xBRIdGdj8l5LD?=
 =?us-ascii?Q?szfd+KDMJFXMjqxQ5tSvURFtQKBIfWhQh3R8eWKG8xOdb7PjDZ5+/Jtl1Dwv?=
 =?us-ascii?Q?91kekmdB5uXNJ/PQwc1tD3dPL9DnR+iK0qk2rnK/ivwFH1sg4V77wr7Vxef8?=
 =?us-ascii?Q?efrl3vhWzKwZhKtO47R+2h5lOcdoiuVsL5LHnGCI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6d0d41-72f1-45d5-b2a7-08dc7ff89347
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:01:18.0467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRn/EGVPi4h+qSagRa0TYGPiO3TxpG1a7A6FB3br56+4elfDlsgKppTlmy9yW5aFi/Ken4Eg7d2H3oXayUqAwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396

From: Ben Ben-Ishay <benishay@nvidia.com>

When using direct data placement (DDP) the NIC could write the payload
directly into the destination buffer and constructs SKBs such that
they point to this data. To skip copies when SKB data already resides
in the destination buffer we check if (src == dst), and skip the copy
when it's true.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 lib/iov_iter.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 4a6a9f419bd7..8a250b120c4e 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -62,7 +62,14 @@ static __always_inline
 size_t memcpy_to_iter(void *iter_to, size_t progress,
 		      size_t len, void *from, void *priv2)
 {
-	memcpy(iter_to, from + progress, len);
+	/*
+	 * When using direct data placement (DDP) the hardware writes
+	 * data directly to the destination buffer, and constructs
+	 * IOVs such that they point to this data.
+	 * Thus, when the src == dst we skip the memcpy.
+	 */
+	if (!(IS_ENABLED(CONFIG_ULP_DDP) && iter_to == from + progress))
+		memcpy(iter_to, from + progress, len);
 	return 0;
 }
 
-- 
2.34.1


