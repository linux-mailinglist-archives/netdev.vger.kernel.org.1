Return-Path: <netdev+bounces-92100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D768B56DF
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 13:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87812B22B34
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 11:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C8D524BA;
	Mon, 29 Apr 2024 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q/JSInUx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEC545957
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390542; cv=fail; b=ZuaNQ89BKL5NES/Y3rnrNLdfj8qQ1NF5w9Rwjir/4oVmwj3OjNGKM76LO/VBb7FUPV7lWiqieSyXOcmI+zcJv0jYM28bl8CukwYQBD8+WnmDSR0n8Ir/+rqf0Y9Y0f9809uSr3Ul43oHeBEh+l3N04yZETxUU48D3jTef5hRGCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390542; c=relaxed/simple;
	bh=fyX2u/O927RlFQlbb53X7qorloEI/Uz3NdvvX2do88E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=j2XvzaaVayNhRmXSXYsOqakfLpHjux6Rp8MD8gvEAQN/3myE+G9a9dR7d6nfnx/i0ziMTDfFJe6XB7t/jd7U13Ph7AD7XcCs0v6+92aqA+Kwg2ZVnYp0mlvKfa9dPHRJW8JVUXhmD7ClDE80xwgX4LToGvLhqcH+V9FrKKVn4zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q/JSInUx; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9iqUv4yuPr6FlSOFrj28Nhk5zBfm9i7KEAKYljC0/Ilp+RdXXxXYDhSe63tESp4AzZCY8g/09BK4VnA1lU5+7tz0ITAku9JvFYbckhmw+iwiD5kkmE3gIvg3aMHV+nwDMlB+9Z5/ou8nm9JWtOYiDOM/ZKn3pxUPJw7N93JduVx6EmfrQo+seGaP4GgOKRfApRsuerreciNTnh/D7329cXaGPa9pNo4dMU44jZXvyV5gL1M2ap/QCm2mhk3CAIiygub0yNY9o/qJDIjBI6n5UR8j6B+xx1R1WDBSL0/+RnsWRrLsg7GuhSQTn8fp2EMXzRnvv/dZ9HO6NjTemm5AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWnsD/qPqMfmXVxRpFGwTIHr+JfQ0B8e4qtY08o5lSQ=;
 b=WY0C2H8Xz+gSfEjyZcSrkN/p3hcaTc2mkGIoNwSskQhZeoXDVwa+ttejatq8kIx+iM0gbrhPMrcPk2vqFDtOwhhggI3a9mRJY3ipKM3RFuJaQBlOiUwr9lgFpeFs+KY5+iMXGmMGIS8iGJ/jtLlLBQyqkfMYQ2JYFq6m/1Ixa+H4tUH99ptJA5Koxa7qncFPye0a7N8Ig2EHzQd8R8KMbJb6LJNBfALAFI4EILiK5aee0AIYqHkeDZrYxPxNeqMJhZssQ9Eb9Q3an1k4mNcIzlB4f/aUZ+TTURJdaZErUF9oi1xSUVqPFFda96NLXB5j/9Lb1wq/n2JVyb39jamwXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWnsD/qPqMfmXVxRpFGwTIHr+JfQ0B8e4qtY08o5lSQ=;
 b=Q/JSInUxbOshRSR6O4zXeoNDVAkrGZpvgjXGwu+SXlBJsYNKjBWE5lkYkw5ZE6rzenh83j4yPkBNjxMv5teStcf2uJVIsPvQTUdAgfibVBj5u/Qi0PnAZ+XqJEjcbmUL28vmSfhG94bzxTfdsL3VZVrpGl1+PEZbzsV9AqhBV5TeiBMQLmoHu6lcePDSxzBVLKzo87YOBQJAjKHKF/n9T1c7xXovo2VQi8GNPWh6fFaj1KMC1mSYtgtPdD9OxWniqJzum9C+g9GtagqFn0TBDrtW+rcyxQOng4SioEc3vdIhS5P20fnxllE4Kpd2/AaJNNbb0PvX+P4+/OWFAiONZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 11:35:37 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 11:35:37 +0000
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
In-Reply-To: <9a38f4db-bff5-4f0f-ac54-6ac23f748441@grimberg.me>
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-2-aaptel@nvidia.com>
 <3ab22e14-35eb-473e-a821-6dbddea96254@grimberg.me>
 <253o79wr3lh.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
 <9a38f4db-bff5-4f0f-ac54-6ac23f748441@grimberg.me>
Date: Mon, 29 Apr 2024 14:35:33 +0300
Message-ID: <253le4wqu4a.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0319.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::7) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c79b2f-de36-4a88-04b5-08dc68407d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AXTBCjlzLw+2RrvCIGX3kK6Ykyc3CY3EQr2uT7xLi6Fc4fITEMGg8kaH52lF?=
 =?us-ascii?Q?dDr4dCvrJTY2QNsY644x5Nui/IyoVjfhXQPA9sR84DXKJCGTwuMeFoPmTPLt?=
 =?us-ascii?Q?LtztNEk22TkpJJmA9UONn1ab2QdpnTFiB0Tg+2QTV9sAn0x6IujMjpS9Nc1X?=
 =?us-ascii?Q?lc/vysbIzL8hSe6j7+38NcA+4F9U85AfQvN0OAO3zSV9AFCJAMpNCpCbLLX5?=
 =?us-ascii?Q?HGvbT6nuNKXYmSSamJvffOkNAHGxv3/DxNEmYtjpbSswXJb9o03igldYB6MH?=
 =?us-ascii?Q?yamREPbS2zg36C6mXrmh4x9yhfEgBSKQY0dnzbix23qejchadNGUq0RIDZHO?=
 =?us-ascii?Q?0HSA24HbWEb9Q6vQp1rA4qEyHsm+/RUmVxvTGADGzIK1QDJdpejOXoBIXSJq?=
 =?us-ascii?Q?VmYDUz1SHHsPmyFCppdXBGKo1IPj+f5sx8PJVzwOQ42+AZ0z9xRx8W+6f6Mm?=
 =?us-ascii?Q?abEut9IMWZZ5i+rL2gSRIm+xTgSwilJUpLICtGmLAOnJEh7n8FX1dad4nD21?=
 =?us-ascii?Q?O5xFaPytS9Tq4kgkFUyi+IymqcbEtv7HVXDkCEhVuCCrQtGxFqP1L++e0u0x?=
 =?us-ascii?Q?COPYcmThG2/aBV4Nj9YfPHOYNH6JHhbeEiDiTnRvK1elmIQYX72i4m43Wweq?=
 =?us-ascii?Q?G0HSGBqgRgQbko366gxPcBzCkAuwgiVQu0CbXnisDz+6Rgs61XGfoQVmfAl8?=
 =?us-ascii?Q?2+uRQBmu8U5yD6LSsBXSRDd+IQJuErbxNugvBtLGC5EwpysDkJQOxAHMEiPH?=
 =?us-ascii?Q?wHITMyEgJfoabL0kKJlMO74BeIGX8lTjPDxWmI4/kIQraXjzFW71VrAzGQSA?=
 =?us-ascii?Q?4wgaG0sNBWLUdsBZ7YgmlqD9bn3RuFOQrtOCc+Pj3XwbQaSU/XyhB6ysJp31?=
 =?us-ascii?Q?7F1kKujtOeM0OTkqZmNOHTnr1UUYHfivE8znuOr72e6HMG+Un13w2DdVQqrs?=
 =?us-ascii?Q?ldnnD2Z55Lg3T3SfURUz6VMuSKLvv95cdwOd79Fa+uNV3oyD6ueMW0aOnfqf?=
 =?us-ascii?Q?lygajEZ49GMW4Cp1x3zm26xEx/e+VwAbJWIywfZNedNX1LOO5XU0vhiuFlXy?=
 =?us-ascii?Q?oZ0hHSCqJ1m5kL1MNytW/bai43gLrB9nMcxVnsD7HObP68cn2gsXuXSz71QR?=
 =?us-ascii?Q?kAph34WrWMCz/GI9Vu5K+881s2x9QMagZ2IF0faIt5tjLD/GLFG6+Sg1/veQ?=
 =?us-ascii?Q?KL0sVpG2PCsiMJ4XJopnPoby34pTAOQRX7HG7jqStgv6/ByeX2tVq3orRoEs?=
 =?us-ascii?Q?msKc6+kp0DBUjwBiT2H2JFeNfs8RNZczmB3mchLj0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ngMDJDUwPQPjzYuPULDa8ulLQkc0tv551l2+ddVXxN6mN0f/evALR8eD43VX?=
 =?us-ascii?Q?Bxbb0b2tNuDL+U9xbHAsi9wJlmtmR9uHcJYpnBOOhjdIK/CU6GHIbDZk+gUU?=
 =?us-ascii?Q?ef5oJaJcrKveA3mB6MO+AMmmUURE64nRR0Gt9r68rzPcMnLs2zaJ7+IHa173?=
 =?us-ascii?Q?AdZxuAfbWWjuIwcOSIyqojWVAhPSjbWWFVjUXwYbmDEwi2kJVCldjyebk3YY?=
 =?us-ascii?Q?ejpEA0/l//iummMEolaoMT2bpzTemPQdz3/LLGllS82d+YZBsQ8fcSzFnswQ?=
 =?us-ascii?Q?iyAhveJO+vMu1Z7nzd4SFpBq/wTUs54QuUoVuHwXrc3k/m7k3obKhtSg7Ues?=
 =?us-ascii?Q?+UBLW/bjXmC0xX0QclZvaR+9DuyqKlMemTYyUidzaWmlYbl1rpcCjBzxbWyF?=
 =?us-ascii?Q?nrf9MioIxs9RfVSPryJkZdJji18HqyBpRkcv2n1fezQzWLAYCQsn9yzAYJ5j?=
 =?us-ascii?Q?WAFoC1iQAtBYpYwZSPJcMWpgemJ8JgMsmFSb2rBlQfC/khlw1bk/PsW6Zo5s?=
 =?us-ascii?Q?8MLG2VSnpX+dIrZc+j8XmOFOjuiIahEts2/CoFCHkdWVEnWwUu/YK2/GKxh5?=
 =?us-ascii?Q?BxUACa73dm8Hnx43S38VECTpsI9nHkVVUg7b5SkuyFIKTjaK0iQbeD7mrIRn?=
 =?us-ascii?Q?tbUNeraVfiUXPeCaBMoPeMpGGTcCBAI6xBHv07uOAEkcz4Ba8iV6z8NQtm8Q?=
 =?us-ascii?Q?AETCChsaCWSIwX1pM0wwWb/tmpR7Yqgvd/jLICel1eObYfV3aaWq+XWIqaRD?=
 =?us-ascii?Q?jWxHujaZi1L+CxHq1UkFfZJf2dlf2qH6g1suhaEUFyN8E//nU4tdm4qN7963?=
 =?us-ascii?Q?j4FIWuu2tgHFIPGqZ4+tgAZdGJOVe1S3uhfTK/RU+azqel/IwbzifdY9K8Aa?=
 =?us-ascii?Q?9AwUK+cZy0Sxgt+6ID7qN7xo4zO4E/+UTWqAxMIihU1tGwsdXlu4P+ECGKsn?=
 =?us-ascii?Q?cXaAeZMi7SUxejiVW5JPDLxbl2H2d0IZxlfvA+MgSz5rKQ05jP5wguCR3tpu?=
 =?us-ascii?Q?X/yOiOf6S/mjg6ktXH9vhgFrjzmeqJhJjaLl3N0Vd/sJM85MLbM4Vi7DSNvF?=
 =?us-ascii?Q?rjhOXDYQUKYHkZL0r+9NSAu0xxjqZE9X4NHuEq4RJwC79P7J0Vq6bnYxa1z2?=
 =?us-ascii?Q?eCM1ZD7DFNKxisCqcxYqcrz6yYgAaxOlLcSN5BZa14FKviqUjDlyU6D0pEd1?=
 =?us-ascii?Q?IiJBs2GgA3JRmTrR4GuHoZtAwa2bQo45T1zdzto0ptq7QYEY6EJgLqkD7LiD?=
 =?us-ascii?Q?SjFjC/Rmf5eIFUy+jTUeL6UFfEpaOdxN0DKKSRWHQ9VsT1ykoM0WwMU4o2Hp?=
 =?us-ascii?Q?wkHyvLdP4XP9rWinQ2+xXCwpAA7/ZXHQwi4UqlF2pLIYNRdLoLDbWAJ7p1c4?=
 =?us-ascii?Q?/wQoYqkMMs0eagNuNrnesmrqfe5Uzp7szkMnHQT2VkJJDkSqQAGuQWptKAuj?=
 =?us-ascii?Q?ywWIbfEW8EqWfvcgr8iSH+bLDughKHjmE1BucbjqdSUMI5xOy34eK2f9ncGS?=
 =?us-ascii?Q?6ixOx7F8l1uPYusizG09u7dIYfbQiCe7GH55Tjt97gJ+s+prfU2Q/IONQ3WW?=
 =?us-ascii?Q?SAOOGGW4FEV6eVONCHjOiODi1hhDpSzGvx5ZnBWm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c79b2f-de36-4a88-04b5-08dc68407d4a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 11:35:37.1695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HoS3tkDvl/LvVts2acC+nDveFwyGFQ9HoAkdWA+rqi2dPOsRkw1h+JGVJdvxF8HajhjhFeCT3l6R58961q0Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577

Sagi Grimberg <sagi@grimberg.me> writes:
> This is not simply a steering rule that can be overwritten at any point?

No, unlike steering rules, the offload resources cannot be moved to a
different queue.

In order to move it we will need to re-create the queue and the
resources assigned to it.  We will consider to improve the HW/FW/SW to
allow this in future versions.

> I was simply referring to the fact that you set config->io_cpu from
> sk->sk_incoming_cpu
> and then you pass sk (and config) to .sk_add, so why does this
> assignment need to
> exist here and not below the interface down at the driver?

You're correct, it doesn't need to exist *if* we use sk->incoming_cpu,
which at the time it is used, is the wrong value.
The right value for cfg->io_cpu is nvme_queue->io_cpu.

So either:
- we do that and thus keep cfg->io_cpu.
- or we remove cfg->io_cpu, and we offload the socket from
  nvme_tcp_io_work() where the io_cpu is implicitly going to be
  the current CPU.

Thanks

