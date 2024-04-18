Return-Path: <netdev+bounces-89054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4806A8A94D2
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF701C20C0E
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235517D3E6;
	Thu, 18 Apr 2024 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hgjdfGxD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970265FEED
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428573; cv=fail; b=sVt5yLjhbkalorWwNWOTb5IB6m46fzh3RyrcMkFH6K2Kp4Kla0Jz8ErbG5Wzt2oLQDfIaR0a1G344bEUzTdGZ1mpySb/z2z65Lni7FLwiRs0z7VWNbqCexqYA1/Hjj/zerCv/UIJZso7daknTbqSqnXhU0ZyWgMGb+vRYbAa4Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428573; c=relaxed/simple;
	bh=SdczkbitVh7Gh8bUVibb++C4ohTCd+RW8aJL5EyRXd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=RAurTE26rFbwL/+DxOcOmze/cQaPgSb7qJA1Zyw8Oob0MDUjbBPqUUD+2OByALg+0po6c/BDKZPrzeKTm85epCAapgrthttFfJ11xWbvzDJyd/GQiEV6EZfJSm7epYSW6vjRGw69vH5TPZITPlQYlPaSWWvI0Dc4d7bA1ovhcEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hgjdfGxD; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXN/l9o9pzuvlj7kDtCsE3pdvAXR5QBIhNWa8jgfnRbDil2WIJ9UI4XHXGMYD0NN03bmrnPGVOV1zfYYdQmbzj23c1QO8/FOvWcrdHDPkZX0S4ZUaASL+1tDYw4UpMZFYY4HU6ooN1WP/EJx8MoSEbZwf9mkuI39nhwXlOcVkAmJH1ruFxbtxg0KhciGsPOrKue1llzczLorb7K5aIsIxMoMRURNeBQMv7ZWZFKJ7S3U6ErVhWA3a343yflDI3AKWxTbtFPxYJ7h04MrkGnaDymCVHg2EPoniudwq425KhIs9SuowKwfyvQH5q62opaNC4csAar/ttpOvy8CVojwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdczkbitVh7Gh8bUVibb++C4ohTCd+RW8aJL5EyRXd0=;
 b=nC+tS4bmJpbGHRMe01H6e1MSS0FRc162v7lAd/Jbn2u9Wc4P8nwg2pO4vlup0HzD9EppsA3VkTYZACWR0pXUtmcCkIDiO3UkAkfnPzVW8DPwDTmLKxp0Xu3bsecxbiVjOQjUolf0b3/s2MthR8jjHzblJThHsbu4Kng2QRLBy9gWODjh+eFserlx++4OWcApX6n14//OUD29Hbd4RWIvU9kKPo0hj2c/x+g+ahLeKj8WV/8rX3C2nkZGripBLaSxJkrt/hUgoHsCoByamDqNKcJslvpOIWn84s+Oq7BZhg4d0StldhBkxk1KPzFr3WZGBt09ybMve2wIWhp9+swhMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdczkbitVh7Gh8bUVibb++C4ohTCd+RW8aJL5EyRXd0=;
 b=hgjdfGxDun05pJvHOTPVOxxLNrNIWZUIj8YvyTPyHgBiRlXRZe72PtOJ2m7S/llSm21xr2fZM9XkUjMZHqYKVL0SAAR50qcPM8QsM5UXN6J/16x7U0PzoonJoQx9GWc2k1L95p8jnjRnnoLU5H/3xX1u2r2NGGGEPiCCvBG4PknGvWlYECn2cTwnfyF7512lkb26otwXcjObRRsX9qNqShTc82buMraOze94kA3rKz1TZQhMlMweOI2PYgI/FWbWi6T6nYvnpXnCTTrBkm7RnAIh2kYoVXyqw92bwt5a8exJFNToTv8Wxod3Op3Wq0dlNXsuaHxfziYIfD2vDrgWDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Thu, 18 Apr
 2024 08:22:47 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%5]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 08:22:47 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: David Laight <David.Laight@ACULAB.COM>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "chaitanyak@nvidia.com"
 <chaitanyak@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>
Cc: "aurelien.aptel@gmail.com" <aurelien.aptel@gmail.com>,
 "smalin@nvidia.com" <smalin@nvidia.com>, "malin1024@gmail.com"
 <malin1024@gmail.com>, "ogerlitz@nvidia.com" <ogerlitz@nvidia.com>,
 "yorayz@nvidia.com" <yorayz@nvidia.com>, "borisp@nvidia.com"
 <borisp@nvidia.com>, "galshalom@nvidia.com" <galshalom@nvidia.com>,
 "mgurtovoy@nvidia.com" <mgurtovoy@nvidia.com>, "viro@zeniv.linux.org.uk"
 <viro@zeniv.linux.org.uk>
Subject: RE: [PATCH v24 03/20] iov_iter: skip copy if src == dst for direct
 data placement
In-Reply-To: <a779982fc59f4b9b94d619d0bb111738@AcuMS.aculab.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-4-aaptel@nvidia.com>
 <a779982fc59f4b9b94d619d0bb111738@AcuMS.aculab.com>
Date: Thu, 18 Apr 2024 11:22:42 +0300
Message-ID: <253h6fzaxm5.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0080.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::10) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MN2PR12MB4486:EE_
X-MS-Office365-Filtering-Correlation-Id: 243e4525-2ab1-4f20-24b5-08dc5f80ba71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8j75tksI+ttNuiQ8FU608m5taY3kmMTkmZn7pogosXxcz+o11sRBMgriDldVfZtTkZgg+uurNlVqXOqgCKsn0Ee/5bI87X4l3FqC+Y0gZt543n163bqJydClWsWnR233dBmM6nW+sdjpOOBqTzlkXWwSzp0EZQY3Ho0qbhGAYTkeRq7/NB7nnMsiP5nq9/g5fNuz1FWQuUXCGia2rw/RKER2q5mCS3V8rePXgKG6skaCAB6wqkDeu2D5iUSfUl7A4iVOQkWqaW21f1yQzPJ4/P1DQsLS5yrm+HtrGA549P46GbOJkdI1tz/YAvFUCgtLy4eEaeGaCMCEJwD9xAI0VdeEB0LuUwAMGWwSrVFwvnXqmC7acm/wMUb9yHtunmVPuITOxpkIXTOc8dLryvO/u0qUYpgSS4ZbNjZPUYKIoELto2UCmMz0kbqXPvtvJJlqGEUxcZ+92XdXC6Mbb4QvTMSAJmpbpzd+g2BT4FiL6FiD9OIi+EbjHSRcoZphqV7KjMoZTrLJ4VU/6qta2y9MjVGwbstqpwwvr6R9XLLHr7cKTEg7A9kXZFM9HwQKHTtWCzdm2uyQy/fiRKpfiqWLLMkMih1XJDqGHwCWKkyVt9A6MPxp3t+MUZ6Xx/bY3JHc3S3dYPF3Nj3M713nm3S3wVD1RYABzwK/qySE05t7YXPd0urEkSFJpH3+hOax4PyaXRSILFpECMs8UiPVIYIFEw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yJR8WHzCMRgYH8gX4WcA8C8O9HZRY6mumsKWzA2hx6Ir5WuH50Ea/hQK+uHZ?=
 =?us-ascii?Q?EKfhJ70W4hMsoSukK5JBy8pvXAzgdTx3uxdya/8/gXWhq/g0lNd07p8ShxYG?=
 =?us-ascii?Q?6ygOSq77sqq62o+0ow5yGiajIbqPBK9KnvcQ0tr6Rc4vVEf6OYc4O012IyC9?=
 =?us-ascii?Q?hKvI2qw2hoEFNQYByXBlWZYzEPTHBpBeC7WVQkB7WQqKfFg1zZnGswZNfYUY?=
 =?us-ascii?Q?diRqudZE1j0ZPe6Mrs+shK9JgsYufTeX+ViT9CoE/51AHhTMTFwBKLVbrrY8?=
 =?us-ascii?Q?KB2QrHBxSBOBgCfj76q69WeTe1Q3M2E6azt8w58VQ4oEoSfQOHZvMZBIrUtt?=
 =?us-ascii?Q?ZOigHsV1yk6T8ky5cwdtRjOpLdIakKbDZ1Golo98Cfkbwuu5T68vF/qXxKSn?=
 =?us-ascii?Q?N/0dNrGzAbP3bFD9RsdRZQRrGzzwkRTUij9ZT59Yikw2eqKrz6n4ro7/KgPX?=
 =?us-ascii?Q?W/LR72qPO3C3d/uLcALthO9FcrYzqLWINMx9FOvC354e0p5A2hi4q6s2nOtR?=
 =?us-ascii?Q?wn43CfRf8cVnaxAYHiZRoIPyIMYPezDNoNt+WDeWlnnAWBGBtAFc7xWvTLZe?=
 =?us-ascii?Q?V6bE8hK7jKlq2ljdpOPWNotonFBtZZRTssxXdoB8xt14IER5V96Qk0UUHW8b?=
 =?us-ascii?Q?eX3CkZfisO0u24N/pd2b9YWbfue7WjZvYtu6h5v+1o8wIKez2u94lL1/n9RT?=
 =?us-ascii?Q?kbBEb6+5O8q+D3IPiNhJNiHiOanDvfinR5CfjQKCzGuxB9IDWmIeF7CM98L6?=
 =?us-ascii?Q?inEvThMsBb71C4k+asT0laDpGxhmGAyUZEQBg2/4rQaz5sBcl0j3P1LNjH8a?=
 =?us-ascii?Q?IYpV37eAwy3F/aZslj0xkFnboYjMaB+kgtAhranxkSvF6r8Fu3te6d5l2LYW?=
 =?us-ascii?Q?PsT3asBsfRvMod4+0R10wtrOT+CIaW+rqXHoSGs1uvbe14pTkt9MXDVbydVq?=
 =?us-ascii?Q?Dw/0cIWdZVKGCn8Bav8+CmegveYd/CSeLq0yj3iaJHEj8lHcETnwUaM70IzC?=
 =?us-ascii?Q?LA0gxmBw1Cu5clz/Mo5Mw81Fsye3szTm4wGUb+cpRD3t9eHjF+SfsDfbVwXB?=
 =?us-ascii?Q?Qf4vVfBixs5ZtRIey3GPpBXSR3CZKogFUUB0slguaKoyJV9Gh/khCkMDfid0?=
 =?us-ascii?Q?ih8nEIAdLgYC+dAX2gqUIMmxha+2Iw5cCy+KZzbm4ehTwxJ8XJwnUvA3BZ3Q?=
 =?us-ascii?Q?Da2Am7CHiey/nf9EiyNlGrT3uk8xhaqu2o7PeT40pKDngnh6Py/DgnozYpyK?=
 =?us-ascii?Q?XaS4SuIj5OcfDLYcE/4+LgM8wdIusQLdJXcGuys199CT8tOD+Uk7oS06hDLn?=
 =?us-ascii?Q?X5J1HCqJndFiWemkMQuNaBUIO55tQ0dzYDTDXN9Izf2cYZZDalDspKTHfCO3?=
 =?us-ascii?Q?4NVm3H0qfi3ET8lnk/6Xfwx4nRWFWPrT5wDqEVfL58FlIV1tEB4VfUQ6ZlFA?=
 =?us-ascii?Q?ImA0uTwtzfb3a2oi2/sZfjIXnzlHQDWhAW50TIbPUydh9PLb+pRavYtxkGox?=
 =?us-ascii?Q?PZCVMGcR8/dnAEgkDfzCTvXd3uJwtyBy7ax1VE/RbHrM5K98Pmhd74ascwIT?=
 =?us-ascii?Q?7WLDkBmkhCIoNHFKUnOogqEUKNy6TpAZZCBAlM3t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243e4525-2ab1-4f20-24b5-08dc5f80ba71
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 08:22:46.9614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlA85TArzCS/cjxMCEwVnFq2A9HKc0DqehOqLv2MFIZJt2d3lf8OA4B0VpK1UWduVCVg3Sf95zElGyBzuOLk9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486

Hi David,

David Laight <David.Laight@ACULAB.COM> writes:
> How must does this conditional cost for the normal case
> when it is true?
> I suspect it is mispredicted 50% of the time.
> So, while it may speed up your test, the overall system
> impact will be negative.

We have done some measures to evaluate the cost of the additional test
and we don't see any noticeable impact on performances.

If this is still a concern, we can add compilation-time check on
CONFIG_ULP_DDP i.e. ifdef or IS_ENABLED() (which gets optimized out).

Thanks

