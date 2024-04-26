Return-Path: <netdev+bounces-91568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1F68B3141
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914921C208F1
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 07:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBE713BC18;
	Fri, 26 Apr 2024 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IXS6WDfP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDA513B298
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 07:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714116116; cv=fail; b=iIMMe7KybtlT/VxLA1XF3p8yUfPnj304bGxsPF0V/GgFEHPpxoEfPaB+DGPsp6DkFO91EnTWVm2EmnJh7B2iph5nfQIY3+muL6VD/OSmoUzC/984SuLtLGe/EXoBlHqnTAqkATZiWPZ1PqPXrMYxzcV7hkaSLmdF5dhguBw0gDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714116116; c=relaxed/simple;
	bh=7JMGIfaOiAyjD29WMXxnfdYuuA5IZY/QXrhmyV4VPP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=QyxNRtzlKRVhxO3FaoFo37G/woHzScH/rJzsb+VSbIoyjRb1IwSjWs9wammXTDWIucQE8j5ooji5UDconYPGct7LvlKN1cEkaxr1E9Ukvm/rOcmjqX6b/nHYOiCq7zgRXDJUCLb1YizxSOnzTIaT3LJjGHAF52TbjX/khbJatOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IXS6WDfP; arc=fail smtp.client-ip=40.107.95.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dg/OE+Qc/uIBFMz+Jzqa+sGZEXy0AW19RkkBEEV+ooY7bat4M0hwTdW9N2mm0lh1TCRRaVjl7OVATqOYohfzXoPbWgcFFwCnlNPl4HnLkxrBCIVfGGstWJz3rfGkj8oF6ey2gFzvd0P9djA/uTaYNp0K5KrG1PRp378bIxllaP7JNZ/JPSv2H0xup6HI76DIaDAYRIt5dbRYzkZDcWr0mOeDpEmByZITSrUrgtQAhCUu1rdqOMa7+Bs2BWcLHcMNphc2xvhEkoiQyK8jhmkMapd+PFGjYyNqRCmOTBBzGReBzggUZ6X93mxmj8goD+RF3Ds41vxMz6cSRottgb5nhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=713rz+fahhJqnZiRL1KjepoOX1AHKROFwGBdBQtlDEw=;
 b=ZuSPHNOT93pJGasDVrdY9fLFkooaaoQSuosV8VWo9u5fnu4qG17pjFj1MfBUyT2VaC6fsG0ZLmG+zyScYRDyDWUuI55kX9qXPXTAflC0jSXKPTqH2eSjW7aWguwYTy2JsOPGOdKx1TWtj1A7ht7slbz2PwgjCBTyG7goKHywjC4NTuP+SWyxw9pO7uRFdhBcCKy0nWp4RKIkh3plh3+Qna9vfCjn0jeDlXVTT13T262Rhn1zlXSA30dOetSN0glzucpueJtP+50odJ0RPywEaY0AvIZCQd3fd9exlMAGfc1kBWEh8mLv4VO7M7asjdftPzddgZgiuyZE0TvjnCq5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=713rz+fahhJqnZiRL1KjepoOX1AHKROFwGBdBQtlDEw=;
 b=IXS6WDfPDwzIAHwSxNudDaUtdd0l3bYDDTV+nHbh/I4Jy0uHhdTM2JWvsPBn4E/7N+yHJsSmV+c2I4OPSuSiiUXojlWyguk6C5tMH6DgmLPbmLZcsw/SxUAkQFoHIU2YnUjUTT0nUFVjXAWs3tiG3DeV1Js2JhDyhUcLxOHB7y/XfjWrB1LP/Hv70avAcEF//J939TE92lTL5D93hzhtvmZv82pRTMCaplNDuc5tQuUKMGdL8mlotVVQCO3FpOopEW/bSAPbeqOPChkuqwzvGVDE6MZNFRIErfQLKKn90uJXG78mdFZQkLtY2jKPuT0ne0GerXnH8OsYV5QdarwMuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 07:21:51 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 07:21:50 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org,
 ast@kernel.org, jacob.e.keller@intel.com
Subject: Re: [PATCH v24 01/20] net: Introduce direct data placement tcp offload
In-Reply-To: <3ab22e14-35eb-473e-a821-6dbddea96254@grimberg.me>
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-2-aaptel@nvidia.com>
 <3ab22e14-35eb-473e-a821-6dbddea96254@grimberg.me>
Date: Fri, 26 Apr 2024 10:21:46 +0300
Message-ID: <253o79wr3lh.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::21) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 252317d2-8551-4039-eba9-08dc65c18a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rRqk6H/ivR1RaRjBzOB4qViIP2rkdP4TJfTK6vYmKFrC7ACfEb7PAOvbF26f?=
 =?us-ascii?Q?K0c2z9wUtB5Y5BLxht8Qz9benaMPa8jDX2Oj4dw5l+UCD0d1mGfqzN8ySJ+E?=
 =?us-ascii?Q?KppztFHQlKL89oyWPHQw7R8+zq/mJgLHIeM6B2ByY/LqWJpqPIoGqU5C5Kwf?=
 =?us-ascii?Q?iccNB2QBYTPgUAMz/aMzfOjPI7LBmvxUE0nL50TdnG1bofyc4OdCqSGHZkPk?=
 =?us-ascii?Q?5Yl/BdNZg8Y8h6ABndLIrH3l0Pq6L/I9kXpS8FiSBvACOVp9hx++Y/Bn3tJF?=
 =?us-ascii?Q?CQRYZ4UlAC+/TY1ygiZrnl4yJ3gWFJAbbLauaMVDOsOwNXJ+0yDn61uSqrfH?=
 =?us-ascii?Q?lguEW9Z+HLmDlLskiXAX30aIufrSWeGMLqG5AGWYzyCLqrT9iQ8cCEKmZTve?=
 =?us-ascii?Q?r3lMTKH1a1SbtfhUXHJ/Z1mFpHiScSyYy8FYgYBXnIp9tRuKFQWNgXaaqOqV?=
 =?us-ascii?Q?OIBdbNe7GUa1uz06QkKCHkpFVwRD7PfixfC8y+NAl/x69xCTmXpbrhZplC1O?=
 =?us-ascii?Q?ryk8Gh+BhvdE5MhKcTzV5h49B5HFX/X1TSorsjl/RM/UymnY2dBnj3ak4e8J?=
 =?us-ascii?Q?/W+cdd/SUOz7TpQLTMbAA1h+Zb2gmN7wK29FZ7iKxZkMIeGRSQFFwNXKEX0n?=
 =?us-ascii?Q?EvioBbHuASPi/Z6w+/KVPYiwiR0GlMHfwLl9BgW1xt815szvnxxHBHPX5O51?=
 =?us-ascii?Q?WIt6moZFv/ZMul2WVlA733a47gy73jnfIxP8dDQ38BAHvK3cS1Uc/SodipMy?=
 =?us-ascii?Q?vlKMsnf7q/+ETlWXD64GhS7IXZS4CBCLuRjmhec44OVPgtCpUFgki/wjpeiM?=
 =?us-ascii?Q?cYXMs4VGD1sHsSCqA66ifAIqPCrrG2Qd7uProTf/c9EsxnuX/zKHiXBD14YP?=
 =?us-ascii?Q?j/IjTL9Q74N0lWKUTcaQawTNyo3/3Lss8ME68wAW/v40j1KaLpvSeRhQ3igR?=
 =?us-ascii?Q?z8w9yejpODL3Mt4PFyy5TmYyGTh9nIKZzqWJHPPhWN9RD9lbnvR3Eolai1vZ?=
 =?us-ascii?Q?EP4pCYPEPyrnr+RT6Nxe9r+kiszZ1h0cITKDdkBul3EAP4W8ryyJi03hqUo1?=
 =?us-ascii?Q?F3E4nr/pJvrJNazKMQarn7BWUpKnHwknx+ra8gTiMbup2v8dHDRtfczndNdh?=
 =?us-ascii?Q?n473JKc9ErS9NEurdR9w6+mJ0USXmEC1FksNXcbIktpUFLYm73WAmTIgWBR4?=
 =?us-ascii?Q?h5378abwKx9+efAZvt2N8CMysCY6Yz7tHD8/27IW8I/0BcO5RrW8ybJbeZca?=
 =?us-ascii?Q?VHiX5N7AvPLVfhWoSqjrcQPp54mrDqy8PHczXTN11A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kw6QfefDOyDAnbAbMoqEZG7h3zfF5zp1z17t0ImgQoDA9JKLw/RHN0BAaGQr?=
 =?us-ascii?Q?LPLRVMLoZRocinqH+9nzAgeWght6yqfhjRFp7hA30Df3DpsPaZIx3qxvW4x9?=
 =?us-ascii?Q?9yEicxhWUgO+Er7pdh2c3pfbet94pTSTGe1TjJ88tW1eZo5gwXgBkY9uKnaz?=
 =?us-ascii?Q?JcGP++qtL9lKLUf2cmrU1E6ekhSyGz6yOyGk/kzkWFBZV2SYrrSMGseW5EEi?=
 =?us-ascii?Q?eDd4BBDlT2Gb0FAwTQVOlXIS8PJ0tM3steFxupZw9J8CQEAf3u4FzrXpbWIG?=
 =?us-ascii?Q?cn3tiS6qpEVn/qfi5wnYnWh3SUeeS4eFkjmULTFSbbTzdEwXKQB9u81YgDNi?=
 =?us-ascii?Q?3f2RBM664dcbMS6q4vjyPhqC7/OyRUzm2a0E07vEkS0Zmp1j66OZY7hxF+t4?=
 =?us-ascii?Q?ESIPWiPEy/RvDsPmJpJ5/yIxsoS2oOQ9V9vC9lZ9Bol/02lvUnXgGW87IJ4M?=
 =?us-ascii?Q?pnmeg7aNqjjNgjJv/0fAxYbLtHoT8TH+g7lR84HT+Y5H0IR3eS2WyQkQGxmq?=
 =?us-ascii?Q?hRKX2bvIsC36v9yANoqSLBiHWHHLUvdV8IdlK/7fWkltNQCPKEa1M15qdVFi?=
 =?us-ascii?Q?WW2YrXoySV7gxNHMkXhHIPqbeRZGGbQiO2a2ffsaQO13vsyeQdwGHx2+3Nyk?=
 =?us-ascii?Q?h0k7QmfCWfQPa07UNjnIVw4dvjW6qY8G4hN/hOBOZwKQuunPfjgN8P//fOWJ?=
 =?us-ascii?Q?q7t/o9I8RbaLRrziZc8ro8qguZmAi5R1pqxF0wF8vQzJUA30YMiZBZayD5yP?=
 =?us-ascii?Q?axBPreco0TXq6dK+bKI09cFkVFwzKBKKGOG2uU5LqwJpI7d3weieHGfIwFsM?=
 =?us-ascii?Q?ib8Ae4Bexz2ExJx1+poSOp33Z4HxgvfmI6bm5JJoJh029yLhvRZ+Ig9NrdkC?=
 =?us-ascii?Q?5pG3PzEduFNfqhOK6fkEGRF/axubCRhLDlWWpUIrB1Qrp/S2pdN0pph9zApW?=
 =?us-ascii?Q?M6jo4SIo2HlSvLakcgis/eEgtHPH4EZzS80P/HdRxsmS5vCltAmMpU9JZN8K?=
 =?us-ascii?Q?9CffZ3e0bPc7vPUpDfVdnRRNuhKzasP4LtG4TFGjoZHjDcG1yzrIxIdQ/h9i?=
 =?us-ascii?Q?UQ6U15QS0PoXULG43U2AuJsPI4oliPj/yMz6H6xcDa0boKxjpUYyI55Oey86?=
 =?us-ascii?Q?LaOl6Wwql/Ms+rNnN7kGZ0wlHIU8zdxTZoI0sfeCNe4hhpu5vhkjkJoDr1Xp?=
 =?us-ascii?Q?EsN1va3nJtzK+f7Mo/q5pFTjU6ARGE93al2SBBOOY830VagfVz/LOLJ4U5Fg?=
 =?us-ascii?Q?m5CrBoXKtQq38EZoStY5Ww5BSFlpKlW7giJHw2U/sdnSVnqHJqH5bSc2Ts20?=
 =?us-ascii?Q?JGQ62QL9qv2R4YQG/PqxMFVYMb+5DC9++keHxXGb+lP4ajSB6+h39OKIANsA?=
 =?us-ascii?Q?i+GHUR2opKzgf9NWLZtl0xuMnB4zKmyL/rTMrwXSDMqDaLXO41hCKJ02ywv8?=
 =?us-ascii?Q?d84wNu8YGAPflXbkpXHijBTl8LotHSQYMR6U++P2Oj25y41cyPGR8jlH2Le+?=
 =?us-ascii?Q?z/+G4RU7fAwO7m8Tun5+1i7avqLA2SyvTFUkRepaaWBCnZgzao9UHKMhJEFL?=
 =?us-ascii?Q?zdU037aepaMylZlyajNTaAB/l6PTwsYqJvHdrFXN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252317d2-8551-4039-eba9-08dc65c18a77
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 07:21:50.7281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECFlax1f/Ut4jxNuoGMqRk9SMc5CtwLJYKxVcvLefYAOgiVHNr6tixaqEQidL72ESY8P3ZklH9qONmINrEgeww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982

Hi Sagi,

Sagi Grimberg <sagi@grimberg.me> writes:
>> +     config->io_cpu = sk->sk_incoming_cpu;
>> +     ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev, sk, config);
>
> Still don't understand why you need the io_cpu config if you are passing
> the sk to the driver...

With our HW we cannot move the offload queues to a different CPU without
destroying and recreating the offload resources on the new CPU.

Since the connection is created from a different CPU then the io queue
thread, we cannot predict which CPU we should create our offload context
on.

Ideally, io_cpu should be set to nvme_queue->io_cpu or it should be removed
and the socket should be offloaded from the io thread. What do you
prefer?

Thanks

