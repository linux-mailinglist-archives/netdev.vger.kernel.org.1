Return-Path: <netdev+bounces-106983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FB591859B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61471F27BEE
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818F91891DF;
	Wed, 26 Jun 2024 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="POVil36a"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82EC1802B2
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415329; cv=fail; b=iUcj7vmqOw7trcLOd8Ub/09r1ZMyvk9gXJfL4G18mBwF55nEeCPCAJtqdRxcRtHTFRcWnEHDuAeLTALa+ykdIF5TzYOooAkVPerP3V0fYacNc3sMvMMlafU2MBQ4ztbAU+olapXyLrSVmAn3hIjnVhhxzI64D4hmaEeRf74Tdcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415329; c=relaxed/simple;
	bh=yVA2h+BfdDm+5RLH2Lxa1zmc+LdNF9A/aBaEtui24rE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=tinGcrWRp19AyyJybizAgINcQrMIcz1iO3LFqez4IbJQolRWaMEO93K1+DUv4eeiLoAc8jDxrdy2+QMfiKJRi8rYPCdRnCVr4V0vDbQ5o2qGutQf7snEGd8AKFn/SIms4nzvAcpfwWcKNewD3teA29q3DuNK4RD2H0d7yhEvdDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=POVil36a; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzmGAu08dtIF/ifkQv+MY1osfYdsZY4T8R10/f0UBbmcVAu/Zi/BZZImWP6lTP9T3qMvYjO+HnHzF1MrOb8EC5jo0T40CivvCC7iwOuMC4+jnKUEtjvglLmtnJPnCAlOuZ8m7wi7nHULwNIpRBhy/qd6j2aIwKqtWw6dpVFFxv+eL3vNmFEz0eB+TwYFoo6LtDkj4qvygc2GhykX8YIsIuvzHMI4nA25ZrJ273iY9u1yShOrOeSh7WHei03RSq6f3IEga49yThYTXqmJ8vjl5vV41i0TfghibOiBMt254pyF8x2gjvUw0j89AlewUWZnUIV5PZlFMN6+KF/lVrE6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKYLxlPZ/Z/Ce1zlFklXjP31P8T+OWxnz3zo+2ITPCU=;
 b=HMuvd32BIRhrCuQduHJodbW+Ni8YxJXWDZGfLY8/qEG3bJNtZKqrUmmFAim25oaNmQbygH7j7+Ij1JffWTwN+oLejHOmsaQXrnmGTIzrMSbji2GNKx/mbki4INsI73//UZKRCp1EKvh0fclMxhHWgcjeEguIHaTXbMOUGmxT6BXI3xs8pTbSKQsMO5exKxDhbMfjhLghO6oOtW626k/3Idr86qNqUeRz8l+sGXOTPmKc7TUYbBRBk1yjGTb54+E2iy5HHArE8VnfSOMnQL7HHqygYyIpJlU7rXOpuu7CfswVNmVSqNxshkIeuyZ/UYTdviDc7zWQIhZr4kAmODUcCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKYLxlPZ/Z/Ce1zlFklXjP31P8T+OWxnz3zo+2ITPCU=;
 b=POVil36axBOLhSr9hLqCGtUfOP8vHMzpJRYRZWM/9L888I86USUWrUmwUI95M0sHI8jCVbx1dQ8FbHl1ldAdZSENfRj1twisvH/PIzZid1/8Jrq0blVloob9BZ4LT0g8Zt+Twcw5L1ctNch49DkyycHgSNRyilH5aCbEcM4a+d60tk83sf5R4AngBN3SIZCIB8bo+NScddD3pHQHpPTkb2VnBo7gTTEVKdS/WvyLk8wPFiUxUNjzvUajPYZE8MxqJrfKHEMDJAlygMqFeoF5CzJRr9MjJ0G+RTJlwRmGH8f5/l+zTmSeEn6RbPkcbi6deYtyBNDn7h+Fsq1Km2R1Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 15:21:58 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 15:21:58 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Jakub Kicinski <kuba@kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "hch@lst.de"
 <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com"
 <axboe@fb.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "davem@davemloft.net" <davem@davemloft.net>, Shai Malin
 <smalin@nvidia.com>, "malin1024@gmail.com" <malin1024@gmail.com>, Yoray
 Zack <yorayz@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, mgurtovoy@nvidia.com, galshalom@nvidia.com,
 borisp@nvidia.com, ogerlitz@nvidia.com
Subject: RE: [PATCH v25 00/20] nvme-tcp receive offloads
In-Reply-To: <SJ1PR12MB60759C892F32A1E4F3A36CCEA5C62@SJ1PR12MB6075.namprd12.prod.outlook.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
 <20240530183906.4534c029@kernel.org>
 <9ed2275c-7887-4ce1-9b1d-3b51e9f47174@grimberg.me>
 <SJ1PR12MB60759C892F32A1E4F3A36CCEA5C62@SJ1PR12MB6075.namprd12.prod.outlook.com>
Date: Wed, 26 Jun 2024 18:21:54 +0300
Message-ID: <253v81vpw4t.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0372.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: c8525f44-d6e5-4afd-5489-08dc95f3b840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rJwwdw2XE21xfxcNXkMn2whM10r8y//DZrnHAY7rE6XMPx9lCJdq1NK+f/sj?=
 =?us-ascii?Q?IWg/Q2xb0bYEhOsLloycbSWpTWrnmtOMJKL54xcNflR5OV0sJzRzpSo97/i8?=
 =?us-ascii?Q?3GDxsuTeNV+sTnemDIgWT6r2+iRB1kSwiu+ZfRClEI2Q7JKMuscBiKpFhvbR?=
 =?us-ascii?Q?pBSLbdGFRXwRZ9+6YEnrK8eZv0gg7geWRTjqTFJ45cpJO12vJxF1mbohLXSg?=
 =?us-ascii?Q?yIRG8B7nyEnqCtkn7w2hGrPrxuwUCJOZKXnFizKLs3okVvrR3dhPncrLdsQo?=
 =?us-ascii?Q?AI9NCFBJf7v/KuduIRuvaKnO5u7mdAZ7YlFUCQSUk6f3n8pAQMSiQc63lhpO?=
 =?us-ascii?Q?6gVRtmjqfYGI2Q31NDGkLl8VvMmTORbcvAJdOfjuUQGXmELbKNpbA+apSVum?=
 =?us-ascii?Q?YyYYyRY9HIqvgjXuvTYfPdyxtZjEB3LiVrN9nenzuLajmakyfYAE04GtGG/q?=
 =?us-ascii?Q?tcpKsgj5bmSY1hePVvTc6DSX4maEPUE5N43FR8PEWoKZGEGGtEassxDPtErM?=
 =?us-ascii?Q?IGS14QaeryH9J1oPxWuxGhfaE/qKdTuxQPycoZO+9ul7H2oWlqEsO+f9XUdO?=
 =?us-ascii?Q?Olt05ksy6DesD5JSdAa7J1VR20fheLAOeQfpAKhtPzFX2nz9OKVExcOLrspL?=
 =?us-ascii?Q?GKBcF9lGFnwa6t8Pea67LmefXbfx2hO65dmRqB9wHztS+byqIkMTHynPK0e0?=
 =?us-ascii?Q?W1gFUWO0VkJIaL1WJWnJgvXfP6wmHbBuTbVDdpepUD8gI412GR9eNZsV/IMN?=
 =?us-ascii?Q?t0gXbsABMNTAkC8duZCjDEoBm0WFurZwyxZprlfw7LDW/Xi9MeWYp1KIJD4h?=
 =?us-ascii?Q?rzupJqxN4lbVbfPtoQKhIGjmSeN+zbe+122IYEM3bajdBchUwPTAFDPJESYd?=
 =?us-ascii?Q?U59USUi0v1taTqFoOcEF0HObC497oTqDxIN2ysZq8h/i8EcKoyhiLTohRKA5?=
 =?us-ascii?Q?u+ZwOthbTs8WDgqvliwG0oKJC2sxR8SeHUElPT6088L7QdE/niw2Wd1q0LWZ?=
 =?us-ascii?Q?0xFJ39SUkhTISr4gLCidKpo7JR9S/YL9qiW0S9LMZ/ntSTze5C1d1UYzJW9B?=
 =?us-ascii?Q?msQJMmHpy/hLXux13Kpls0OOvJ+7tTW2mFHkgLxyiOv3idXUMeavnTuQr1z9?=
 =?us-ascii?Q?SXFPLTbe/OqO6lAivWEg8h7Dmo85k7mwBwhizFCKw1gXYEg8BhebnQyxwxpr?=
 =?us-ascii?Q?vqVx9Kopc+pSrizVrIDUE+RVreoG4aingyUm1QKi/GgM6G6xIo2fWiW6n83c?=
 =?us-ascii?Q?4awjUq7c6RHiaC9piJH4mTPhOWMsLbKq2y1lBKTwcBAgUxZEJ5JsSMoRhm5k?=
 =?us-ascii?Q?RMIwVC9k8RIl68Cyi5q3nTF9VHUKi3awC1yiQm4S08eqpg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IVTMUSpQ/bzZG82Dvx2B25ryDn4SPh3lPWqh9/pEH6kmH8pNwBTBLgRy7K1z?=
 =?us-ascii?Q?mitaXsQS4IHkY0PiOfpw4NPwTDAelbP67iBSAa9wH1edPSuoimwKyKUSPrPR?=
 =?us-ascii?Q?sqE2t/0KRbOMYFW4r+lKo5wKcjXPwCz/hP1K1yGQvyoU9Lu614MJVMccVKyZ?=
 =?us-ascii?Q?jf2qqhVivPmGaSvmQqHFiakteo3u/WkeGQOYGMv7Kh50jYqgZarcXh5qyN/z?=
 =?us-ascii?Q?+39BGQVYnFe9PYeywcl5FVmaCjF4ihe+34Z3NKy/g5KzpZtx+37vnBamRZoQ?=
 =?us-ascii?Q?7T+GSuy3cFLggZ8rbPWz5mzl5OlBU8wnu+fRIwq+VcxYtQSTST0bgxR48aMl?=
 =?us-ascii?Q?QOJpgXeliiy313W33m6KMximhJoEKR4Fx5/f0i8nt39SvjCrXJ0T06xIKeMu?=
 =?us-ascii?Q?WmTRoIoE/1wi/7/05Kwn5/2Usjqw1dxtyxPr9iBz5DL0poCniYOZXjlCXChC?=
 =?us-ascii?Q?8wuHVkIfdhVLPcq4kEXBajUgACqFMFyen21Pczs3j1znD5rQoqslz+oXm6Vu?=
 =?us-ascii?Q?BX84q+nqFcViOfzDBJCgxWmNXPZrQqpUnsjqmZcazLpBWpHWuvfQ+2UNwXkH?=
 =?us-ascii?Q?NIlq1Jnq7bXUcN7AB3h4Nd+Pj3SfLXD9O3y0LlBpTwbhPNB7FTRus4r6zM4e?=
 =?us-ascii?Q?LqXCaOQuZnBRxBqUieH9UOYkpyB+KDbc0f7/9TXAjFjJeVIIKne/zWVZUMYF?=
 =?us-ascii?Q?Qo5k0u+sWz39vqlsJFZvAQfUKH5p4PaQ75ymBmcsY6JC4JzuJZc8ra4YMfzx?=
 =?us-ascii?Q?DBXEUs+uj6Vvp+10BYYxa1ho51bPTy4Q24PXI8p2l86vGEOainC6xEZ1sf71?=
 =?us-ascii?Q?HSdM41AE7ffca8PhrOlUVSzS5C88loYiVnl988Ln2ul7eEniwNG9sS+wlEJh?=
 =?us-ascii?Q?lCIZCetMWN+QfezOAedsmZqczkHs2+2FDLQoow2hQzx0e0Axt2C+CbEpBr05?=
 =?us-ascii?Q?zkqcy+wuLt0I0fHO0aKCn6OO+/2uLXCUHLh8bWTM1QJLVwluWzbB19Ja7efo?=
 =?us-ascii?Q?TRQA3Mwqrp1G2MDsQUiKedmra77Zpuxfl8pyU7i/iYjto+NcWK+kwc2g1mqK?=
 =?us-ascii?Q?qlLOWBUJpxxn+0E9gQ5olPJbut0gKGVAqYH7j9Xqlx4c2Mk4JrHCiZhq0I2x?=
 =?us-ascii?Q?ErpUCVzUFRP698YJDKvi8SCJGu8r+Y+mIO1jHloa//hfayVmmHVtgZ/HMTrR?=
 =?us-ascii?Q?/Fdk+ydp3CVgivbuhP58g8GTRn5Znrj84k+6HCCy/2gZGiLRFErTNfXVweq7?=
 =?us-ascii?Q?qCna4OhcxQNCnC1en2WELujNPRGp6ED7q1QQmsWi41kEat1yBM4qnyyGMNiV?=
 =?us-ascii?Q?VnPCB4IJzFnBqfEUKhncepq3Bjbs7RATcZRTVyNNkiQt8c2LgmGQS2I6Q/B3?=
 =?us-ascii?Q?8fD6jAGLEEuIUhE5JM6f0QwFcvxHHa51ImUx2g0RSPY/xJZuTw15pU1VzaZj?=
 =?us-ascii?Q?FrCuSa5EbYfT8y/XJ1PNZvoXTkWe3LMAB3cWU7bkipTwaS6cOGsOgu4dQUh0?=
 =?us-ascii?Q?w4obe0Rull4lR9wzDvdQYrnroiAt5T0ITfV8wrKuRF9kbWc6/nacd9lw/GCm?=
 =?us-ascii?Q?ZJpuPRKy7WPnicImbn7QjFfUTh28zuWstAsEx0al?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8525f44-d6e5-4afd-5489-08dc95f3b840
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 15:21:58.3280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFzxSgSGv4HR/3Ebt9qZoTz9UJicyx+OoOHfHAA7xLShZsYiq7MMRKJLOPLdlPldAj77WZnwg1DnO+6CijXQdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873

Hi,

We have taken some time to review your documents and code and have had
several internal discussions regarding the CI topic. We truly appreciate
the benefits that a CI setup could bring. However, we believe that since
this feature primarily relies on nvme-tcp, it might achieve better
coverage and testing if integrated with blktest. Your design focuses on
the netdev layer, which we don't think is sufficient.

blktests/nvme is designed to test the entire nvme upstream
infrastructure including nvme-tcp that targets corner cases and bugs in
on-going development.  Chaitanya, Shinichiro, Daniel and other
developers are actively developing blktests and running these tests in
timely manner on latest branch in linux-nvme repo and for-next branch in
linux-block repo.

Again, we are open to provide NIC so that others can also test this
feature on upstream kernel on our NIC to facilitate easier testing
including distros, as long as they are testing this feature on upstream
kernel. In this way we don't have to replicate the nvme-block storage
stack infra/tools/tests in the framework that is focused on netdev
development and yet achieve good coverage, what do you think?

Thanks

