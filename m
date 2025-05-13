Return-Path: <netdev+bounces-190156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA407AB5563
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F4E3AE475
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3359A28E5E1;
	Tue, 13 May 2025 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TPl1/WEa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9028028E56C
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747141029; cv=fail; b=GNW/idStj/7BX9QQms3ErCq924PbHdQMN3oKpMC8ZBt5u1yRD7W0GNedqLgrpc3Gc3kTLj5KfyYFaCMpwxbhDp87VGQg0zHQAXwHTXFgKNVHnuTIGWscKaxm51mfjP8Cba+DPcYkRzpKN4wIhtTZvB+iizahs+o7+GjslZ0UwLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747141029; c=relaxed/simple;
	bh=FRBsn6qP6vh0KwlVFTiLpqktkQ4P6lCSjzr/bznki14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=LLhoEmiAOtn3c+YkGE8x6Heb+r6YZwhWalVxuBQnUzwPQX69CIyxa6osisZiviEiGqUHmfHSdtnVvPMRQKxsiiK5JG9j5KzehvSGAgLZrZaQp74vSBdS1kXaFtvYHJXYaOjog5TH2l0euV2yL+4RX+6R7dSuViFyHBD/uBbfnXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TPl1/WEa; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7CsBtietEK3JS09IoT4GWEjPfK+AMrRD/90rPg4g5FW0LaOub9RwBFXs5nTnKGxa57LU8KbNo9S6sxKJASU3Gyfc9nYF2FLCsjMNhhHbHkc4RQBbPB4Z4rlsAm6T47WluKgXYkWXnDjcZ81+FvV3V3Gbk/bhguc2w6dpKKX3Z8KqTVN+z/v48p81sU31at9pqGb4m8Qj3VTqZvhDPfMxoLlkqHbR5bWCk6RZt9JFuM7U/1F+Y4+RFFcHQGkzJMC0N+2t/xZujZ1pRyDX7YU6YptJkxh+T1J8VuPT5oJ92D38ubUoL3O/wFmoiPN9bHXyRKrwaJAg8AbHHsQpybYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRBsn6qP6vh0KwlVFTiLpqktkQ4P6lCSjzr/bznki14=;
 b=sjW8IC+tIYUoHNDgS6c66Nkla8tvHD49Fpn7pPZn50Tp3Z0YLLl+Dci+rFmtIhDedLWZ7wHcU5RP7Ua+L9Dz38Ymu02nExZ3kmbJUmPkYyc1NZc3y6Afbzz25VhAGu4SOazrQ/VcbH026rh5RSZs0mNuB7aqI7uNlMGdD2RnSkRlWBadDxRe25c49oKiA9flxapwZ3N/aFzCNzye4rW81S8znCVlFmfpj3B7hCLLyzUlwN9Jy7vLFaJ8GGstfWPC+F/9I2Rp14cB9TsCpA0vA37Vn7+N1BT51M/fuZW+nVIDUeC1Wz5FdP8jIvkZXhPZ+bRHB87IIm4l7KyrSCaJrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRBsn6qP6vh0KwlVFTiLpqktkQ4P6lCSjzr/bznki14=;
 b=TPl1/WEadIJPfwLtkURYCLb2Z7B2qdkuKAEL8X8mo/1G5OUS4myKp+kdS9dSLyVIDaODAhhzznSgZyjIDB0CbJiV6TcfmpTl9WdNsFwHUIMfT/bUaU7Un5Wk4OTtjj4Zf5GaASQWexA5v8eMS9qt8vFjP4uACQYk3LJUCBGRnibmyCx9Y7BZIeilT8P2NhPU4HS146jXECceVKiMkW3nIDbavGAHrntRP8gpIq3y4Z7eEYx6C8LBAASvE7G3MhSJILaerNLVChiejxOXBgdYrKyeN6BrUo4zvgw4oqpnhxs+P9HEXhDWR0sofnLsoeeScRzDvTUkfpDWGTanOGvAEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Tue, 13 May
 2025 12:57:03 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8722.021; Tue, 13 May 2025
 12:57:03 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Keith Busch <kbusch@kernel.org>
Cc: Gustavo Padovan <gus@collabora.com>, linux-nvme
 <linux-nvme@lists.infradead.org>, netdev <netdev@vger.kernel.org>, sagi
 <sagi@grimberg.me>, hch <hch@lst.de>, axboe <axboe@fb.com>, chaitanyak
 <chaitanyak@nvidia.com>, davem <davem@davemloft.net>, "aurelien.aptel"
 <aurelien.aptel@gmail.com>, smalin <smalin@nvidia.com>, malin1024
 <malin1024@gmail.com>, ogerlitz <ogerlitz@nvidia.com>, yorayz
 <yorayz@nvidia.com>, borisp <borisp@nvidia.com>, galshalom
 <galshalom@nvidia.com>, mgurtovoy <mgurtovoy@nvidia.com>, tariqt
 <tariqt@nvidia.com>, edumazet <edumazet@google.com>
Subject: Re: [PATCH v28 00/20] nvme-tcp receive offloads
In-Reply-To: <20250505155130.6e588cdf@kernel.org>
References: <20250430085741.5108-1-aaptel@nvidia.com>
 <19686c19e11.ba39875d3947402.7647787744422691035@collabora.com>
 <20250505134334.28389275@kernel.org>
 <aBky09WRujm8KmEC@kbusch-mbp.dhcp.thefacebook.com>
 <20250505155130.6e588cdf@kernel.org>
Date: Tue, 13 May 2025 15:56:59 +0300
Message-ID: <253a57gzn1g.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7cc2bb-d8a2-4aaf-ed77-08dd921da851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G4DEMbOEKiqabICD8SjmsVqNu+WMoHntMw8lxniETUCav6LQJbMQNahT25SZ?=
 =?us-ascii?Q?esh/6HMQQ8WWvtnlm3ROrkunbghGGLrf1B5eajtvdHsAfe0d9MJUgnhDnZV6?=
 =?us-ascii?Q?pjvzmPkfj/IaK91f8E7dtcDBV2LhqlEmZ0sngTkj9j+ddmw6ZqqPy7t9PeFx?=
 =?us-ascii?Q?i+01GT7GPjAN+7oyQQZqNGwaMOPFKdrZB2ioNevVCMQMod1RI/9mo6cNv6+0?=
 =?us-ascii?Q?oIHOb7yUsRp3mIu7zChKtN6NuYFdf9gi81mW3pJl2PX35Y4rOuESTB1/kOXM?=
 =?us-ascii?Q?m/D/cBeqd0eKEx9VeESVbDX+NzgJPnium7Myi2rxiHvElpUkKPNNW22D3QXe?=
 =?us-ascii?Q?xsifV1dv9yhLRZUfkDz2mnVhd6XbKlxu+FjTledTn2qrTKb/6cuO8QrKrWbw?=
 =?us-ascii?Q?EVZ8c5Rrs+IfuHUus+mui6FVKXohoGoga2ZD5mCj6V7TO0M8r/SJQYVDonAo?=
 =?us-ascii?Q?IutQ/n8A6aEPLpsTvSkTWoFIKzPdQbsuq4SK/N0/Og882HalHWCtkK7NtmqG?=
 =?us-ascii?Q?WCTRxfKwKB/nfKWkG9o0zOLfW40XbHqk8TZaAZdByyZ5MpaxJ7pP4fXh0ixh?=
 =?us-ascii?Q?Fd+XxbEVnLmcfhNH6RNR0801Fs5FdTE/iVHlntggcNF6A/L82V7OFnxnL0EI?=
 =?us-ascii?Q?kjJpiiie9oYdJs1ztwcNbOVAnzZTa8KHdyIUIqy7u0HM9R1BSIfMysxmOezQ?=
 =?us-ascii?Q?JYrDFqWkQx9T8m9w1KiW+KNfnQ4crMrqGRIEXEQOuWWtZg6E/UcNc4kD3Mbl?=
 =?us-ascii?Q?1MfsoeGfWwbCaocjg4Rp1uRWHPJhbYGNO70tThkiqe77deGTGZ0VdZSR9Tcq?=
 =?us-ascii?Q?moU4ATEz3BlYP2ofx4871ARDYw1vHQYlm+0f8vdJcTPzclsiqVHHpriPtXEv?=
 =?us-ascii?Q?umnD+7vYxXuDwiB/VOz76sYn67qAdNaWSUPh0olyCggHZhAa2+eT3KR5KNU0?=
 =?us-ascii?Q?6x+NSc41tpT9/EjKZNwKyC9v1eS1t0xe641LlQsk+3Q9MIReI7Ve/iNr5jy/?=
 =?us-ascii?Q?tfLZ3Qd0rffyPnCEheo/v7YskKSdougT3eWHZAix1WixiBbz9x75N3jPxp78?=
 =?us-ascii?Q?l6mQRADL5bfSidvxyzWMaw4EJS6Xm0sU+qCUDrz29KCEBQQ8NseHNhBhDqXG?=
 =?us-ascii?Q?CSh4CrMAt5e3PxZIo+vPZp/ridY+84SGaluAuXdGTp4/mQHJc/l2eVdJeGn3?=
 =?us-ascii?Q?eZ0bGkwGxtlx8ZOT5EG0ssZc9nIEl+UQ7CLtIh/ptL5N+7zJo5VmSIRKDgWC?=
 =?us-ascii?Q?7h9DG7HGLr3yxgbtjOpQ+cAWv95YW8576O4srW0Fa2ZQenPCQmlqlizsJKwx?=
 =?us-ascii?Q?MTreDrtAp3UqVvi3XCl5dcWub2vkYV4fO3YuwrSBQFXY742KoY4Vt8z+6a0S?=
 =?us-ascii?Q?SDn19vZlYrOXUEPTaBw3p+Yq06dRcVRnLgS09TzaX/o7fRLC+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sYYIDDvmIxkUiwFr5BHQFxiS6topsu1fpCqVbhWApy0xcXyVIeBPG+5geadO?=
 =?us-ascii?Q?V+30ZbRKlkKVZPodKgohFxyMORVRfmt83cmQBNbFpopSy3D0/Q6a7L7cvoU8?=
 =?us-ascii?Q?DyRwyrOK1/aUj3UhP55/1jB6abXcvvN3JSn3j6BZmLrx66Ua8hodEZAB+j+/?=
 =?us-ascii?Q?/HtjuoDz4k4qXqWlI//C/DeHs9tp7KQQFrbdMitsPW4TosU8EgqxRBM0lU3Y?=
 =?us-ascii?Q?RivznKB4zUxFc8QCTGptFWplQX4qtMXVSjB/wZFQEB9RaVZGhPuT6Hl0gjb7?=
 =?us-ascii?Q?liWjOM8Qj+lCPQIaqYyWgQsIELziU5m38FcvtxGxuZzaSyek4R4Pi34xd18e?=
 =?us-ascii?Q?ggtOQtAwaqY36RRPkZrDTICAEYU6PjgMcHta83qAluiGV7nk321i/Y5jcwga?=
 =?us-ascii?Q?pgbmGw0GvYGGjk1XXPeIWYF6tjikQsCa73LtJGLvkA0a+hP22XAWCPL0IPsT?=
 =?us-ascii?Q?Wo+kUmyFLLoSA9jdO9v02DpO4TAwcc10NN0BSna+8/4FVfIPX9iJ1iyNQK1v?=
 =?us-ascii?Q?m+mthH7j68x/3kQQkwrjpWsVYg+Itkd4ttdnr/2aHN9raV3m0bErBGloEWS9?=
 =?us-ascii?Q?IVSGFhbeobRO4XxqWIN2bRe3AWRQZKl2VCpPmEmFCqsYX85r3J64GSd1I0VR?=
 =?us-ascii?Q?ewYNI4hupEzawTT0C7i+jeZGyPaJnE5zvUsbFmFUbYBBMJBY7c9M3ccW3Ysg?=
 =?us-ascii?Q?I4CMRPmxpjPOoWbiKPW7EuRmjVLoFAMHx14PlLV2OY14ZvCGL4OAJ6LnVDHu?=
 =?us-ascii?Q?eQbLOjjaN1DvPNveruQYea7xiWk0UEKhBZ2NVubqGAoGph2g5pBc66rxJXUe?=
 =?us-ascii?Q?tv2hcx/YQarneClkPNwhhiytPHg9CvlvY4Q+Z0q12wEDajhqvx3Juh8HPFIo?=
 =?us-ascii?Q?UUW0NB1G2WeCBkAWA8WKGH+J1sJh0xZcWFoGPoo7PeO03BqBEJwMzaNmdpgO?=
 =?us-ascii?Q?B/PoVOwmngEGVaEi5dPVZK13shog/vWlKcdxg2682puQM19fqwckqfScqcGg?=
 =?us-ascii?Q?NoFE2LjdGwnIwhwv8mjiI5lVtEaABo/6sAqvj7LPcA4qtNdx2FIM5Is2TVm0?=
 =?us-ascii?Q?6Maqh2OifcKpPSzNzMWBwUoTbXh4CBZQ0QUnwjsA/aPepWspwvrKuJtqkXZx?=
 =?us-ascii?Q?zOs0Ga2XbuJdY5CrTx1g4pTiHvanaG0TWo5hL93SCaGwMb4Wa6CL0FxkccFy?=
 =?us-ascii?Q?+yXZSnzqrmLL0WT7iLStDqDIFWhxwMoHRstQvbd0f380fSzPVmIniD1U+sd/?=
 =?us-ascii?Q?2bVni1CiNqGzwgEfIwJoAOOaT5kVLzdP+DsWuS6MYl/UrovfrgkenufAd0IN?=
 =?us-ascii?Q?UoEKclbX6Rs91mI2zuF4peEUFJ53AsZ6L+ISsJYfvLer6eUW5jZ8GYD+CCf6?=
 =?us-ascii?Q?z3pzz9t3w4Aru/yYrc1zTxHNKJam1piZdsccz3gIoiK5GOUObAq88apoG+Dh?=
 =?us-ascii?Q?nEzICvosQh1eeWodoF84d5nlKiBHzfJotUuOZwn0VXayJlOh+ZNHMtTp6zGX?=
 =?us-ascii?Q?4Ga9QgHlLs2hKLlepjg/Z4x8/8HNZ2Wt+1IpPhsHO/iCWGGWlieidkNJ7uyD?=
 =?us-ascii?Q?nCfl0dzGcV2iAgEvTHvSFnxvEz9MjvO4885pLacO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7cc2bb-d8a2-4aaf-ed77-08dd921da851
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 12:57:03.4132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: un72eX/7JKDBSdmMPZUM0GxIugQ0/n7ggInMb4kJs8nfRX0XYtJR4B3mmu+zNdwZeVnKDwphtCQyvhWda8AerQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250

Jakub Kicinski <kuba@kernel.org> writes:
> Thanks, so we have two "yes" votes. Let's give it a week and if there
> are no vetoes / nacks we can start.. chasing TCP maintainers for an ack?

Sounds good. Do you have anyone in mind?

Thanks

