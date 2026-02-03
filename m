Return-Path: <netdev+bounces-256461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBDTA4FrgmkpUAMAu9opvQ
	(envelope-from <netdev+bounces-256461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 22:41:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB7FDEE7C
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 22:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A7BA300BE24
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 21:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D55A36D4FA;
	Tue,  3 Feb 2026 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gEdV5DK/"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FDA29E0F7
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770154849; cv=fail; b=ARMjlUvB0irYu/6umOTeCmHA6o5/JHIE8l3UrHeWlG9E2m76MwcA/GBhdeZcLIsIhEUECV4mvUlTBFWnh14CIFG68bqknIzPqPYtZKnQpbEg5+0nKtaxGE9u1zUMU70saw0ccxSt3laS/pPd+toCN0VODXxC3FtgzE00QWjXdtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770154849; c=relaxed/simple;
	bh=kbHK6AQnLbYfSk2SqOXmJ74fMRlH42g4/gMVDerphVA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p6MbP1ip7bhPFWXBSdS4scpIZKW6woKu1eZZH/93Z9fxxdzcIKL8eIePn/HKKFCKHdjkhPtJlK7W1PQzzZ+VhZKo08LqjhCS3uMlMZ7iIftVcreU2XcNQGdmnj/ZReIs2Ke/siSoSlr9+sVgMqEOmm/D3BNlXY+sbSsf4jeCe28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gEdV5DK/; arc=fail smtp.client-ip=52.101.46.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXEniB+luPtqz70cqgOVAa/bAoWDGXES4aGHIrHCfZIx5eDsoEh4Wsj2bk1LIRCmppKjRaIu+4c3axxRheSrcAc9Ml6iBtounv/vNqtaS1Q//v11vTSo7ipnqtEVi7A7Ht5wBWheuB7R2h0qlWx8XVO4urC0LJdZQ5Ulm1h27UDHnztLccixYafM4mMhDDfuakV9mk/tbIFu09g2gmg1QEYaMRBKtC9o8gUaIRd5U+Sra2AjUSW4c/wgfvyQNe7Gc3Ejs+PF87JOqY7LONhtnLw7gkJsCAlpqJV/VgpYuMo28+pCg6UMDcCf9Fo+B2w73DCqCIkcAgs/29VCB1RIsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+qRUU5ryW+S9kgpKZW7fJXe7hbME8cOEkIXm18B/RM=;
 b=rDf8FVYLOOm1r1NgbpzuaTRqCr6HDjPhRJkoT8o/y8syIjdx6PFk1d6yuOzhbPJqkBk6G0MTxX1Qp0WFZ2LYcU+xg3yKc1rsjtWcQnN7fqtdSRhgvqC92kZ9lk6dMooK6ytUEAEWf3OY4WUl9CxsQqywdRG+W8y0R2uu9lIbF+48Lr8V+Te5olpnD1Co4kV0lFjfhAKhGpeqZZiuGhbW2qgbXovevPnvuSd0KRRK4Sj8/vPVE8eVy0MqKcuFO7oV1aHUH4NjCBJsGvkBEZqxQJg6ylB5G1jiyu2ylTRMDQ/Boj904MT/0P7Az/Jt/cmQJUB2msWtmALnjfvQmja6hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+qRUU5ryW+S9kgpKZW7fJXe7hbME8cOEkIXm18B/RM=;
 b=gEdV5DK/xYGme0VsQeED7tJ2bwq/bTl3azJFjYF7/yYJpspZ8gkvhFEu4bt/j1r8/tGiMwWcIdXB9axn66289+t+7O1rgnWgKLpYKRzxq1UNdFQ4/O/Cefkjif5VKdolUCoEKJj1LNboBHVVyXitInrC8b2GC6hPT7jGSXnbNv1EkNydq2PByt7h6xYVy8jrYHsFstzeGTfRXxj8SneAb4C3lQ0LzhgWG/6UrciIPotrA3JitiEhs9RyHeeb9dYupjE23KHe8V/facA3jjRQUJMIE49d2xpsWVGuXuVIA45tzTjekZDggGahyxF7Ar8oQgQS8MfrzKDSzIGWB9H2Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6748.namprd12.prod.outlook.com (2603:10b6:510:1c4::5)
 by MW4PR12MB6876.namprd12.prod.outlook.com (2603:10b6:303:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 21:40:45 +0000
Received: from PH8PR12MB6748.namprd12.prod.outlook.com
 ([fe80::a91b:e47b:4f8f:57fe]) by PH8PR12MB6748.namprd12.prod.outlook.com
 ([fe80::a91b:e47b:4f8f:57fe%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 21:40:45 +0000
Message-ID: <38585d6e-2388-4b9d-b3d9-9314c1421148@nvidia.com>
Date: Tue, 3 Feb 2026 15:40:43 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 05/12] virtio_net: Query and set flow filter
 caps
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20260202170518.9076-1-danielj@nvidia.com>
 <20260202170518.9076-6-danielj@nvidia.com>
 <51ea0ddd-07d0-4995-8c0c-faf526c2a8b2@redhat.com>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <51ea0ddd-07d0-4995-8c0c-faf526c2a8b2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:806:24::11) To PH8PR12MB6748.namprd12.prod.outlook.com
 (2603:10b6:510:1c4::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6748:EE_|MW4PR12MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a887653-feac-40e5-ed17-08de636ce2f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUNwOEM5elB3RmpDbWNtQlJEaDdwOXlDakF6Q1ZFekdrUGkxeExLRUNGL3Z5?=
 =?utf-8?B?TmJHQzJrcjd5N0pqa3Z3em5VQ0xEV1NGWHh1dG42SjAxYXc5UnZub0piZ3ln?=
 =?utf-8?B?MWQyckhDd013TjhWbzNVNFd2NUZRTmVZU01VV3hIMWVYZWtPK3B0SlBSSzJm?=
 =?utf-8?B?T3pwdXM2a29RVVhtbjNvQS9lRWMzeGRCakV2ZUJML3FiRE5STWd3a2ZMVkhu?=
 =?utf-8?B?ei82cW96Qk80VTdnTy8yVjFuZytMMkRnR1F0d3R4aDVpdEJ0aC9JVldPa3Fm?=
 =?utf-8?B?TSszekNlS3BBdkRleGQ0MW9xYW8wMjhGckNkRkEwUUdEOUlXMXAwQ01LNU9R?=
 =?utf-8?B?dUxZei9zd1M2cDdWdkY5b3hMNjE3dk9JaFBIcWhQbUFFYmRKVm1xOWtrRXBO?=
 =?utf-8?B?eTk1N3NhYkdoeVplaTZ3eFdET0pGb2VlajZyQThVSzJ4KzJTanZWS1h1RS9i?=
 =?utf-8?B?TVIxNFFJMW5NclVRZFVDdnFmYkQ2ZW16Qk0rZllGZlFuT2NQSW9vQTlQeExt?=
 =?utf-8?B?NXVaMm9tR1JKVTU3dDVsV1FNYWFmRlNta1ZzUCszMWZXeU41R1BPNHA2ZElP?=
 =?utf-8?B?aG9Ic2dISWNydzRZcXl6eno4Zlh3YXBveDJlTXVaRkRxOVVjSkVuSzVYc3pE?=
 =?utf-8?B?VlZmdi8rUTNFdXNTVkJzcDJPeGg1RGhxdVdrRFJ4RUFDUnN4UFNiQStnL1NX?=
 =?utf-8?B?ckl6UHVkZEVpWkVwSHAwZHI3R0VZanRYUGZ4a09PVnZGZTNsTjdmWjhURWoz?=
 =?utf-8?B?c3lYa2s1STkxTzFIZ1JZQy9McGNwUE42bnYxUXluRGdkaFlkaGY5N0RIT1Y5?=
 =?utf-8?B?VllQeTJ5RDJVUlViditiSnVQcnJvM3VydHhpL3h5ZUNaMFlRSnJWeXJ6YzdH?=
 =?utf-8?B?dFFJZG9ZN1pFM0lLdEtiMGNNQTZCRzdmRVIzcGVJWnd5SjE3TE9WMjRtQUNw?=
 =?utf-8?B?bGEzei80TU9tZWZNV3Vhd3Q5OEVtSmU0Vkx5QzhpYWtBekJBRUVvTkJTMnRT?=
 =?utf-8?B?cVljSkRpVHdQQmJFYTB0amJQenFzZStVNmtxK2kycDl5UHU0RTBuenk5UzFN?=
 =?utf-8?B?bTczQkoyOGhkUmc1Wkh4SW1QeTgrN3NRL2FnNDNLaUYrTDNtaG1lL3JpNmFs?=
 =?utf-8?B?d0xmWStQUnRzRUVKWmIxZEFjWS9YdVAxVktVaHNiQU9OdHgxVklqTnEyUmds?=
 =?utf-8?B?c0xtVU92Y2RiZ1BVSzVQL0ZCTUpRNGVpY1hyc0xSUmtwNENUdkRuNFNxTjFy?=
 =?utf-8?B?ZkhaNkF4MklQRGh5djVBOElhd3lXeTVhSllLMnM1TXZnTTI3VEMyK2MveHM1?=
 =?utf-8?B?c01yL3U5aGU1VVlDMng0OFlCUGF4Sk5yVXd3ZGZnOWNzUUVPSlhUdjdwNHha?=
 =?utf-8?B?dll5aTZ4SVZYRWd5VGhYL0hpQjE0VGVsMW5vMFkrUHBrRHBsd1dvMTc1Mjcw?=
 =?utf-8?B?RVZZR0F3ck83VnNmdjB5R1FjbXAyRDBVb3RDek4vcDZmL1l2SzdCNFJmNjVV?=
 =?utf-8?B?eitoNGRheEpvY1RrMzdSMW50VHFoSW4wNXVnK21IaE01MDJHYTZPZ3FsckVw?=
 =?utf-8?B?enpZb2ZRUHRadmprTHE2S295QzFCRnhOK0dJMnNTbFhvTVBTSDRoSzZ3T0Q5?=
 =?utf-8?B?M2xrRzQ4MHZ0WHdVMWJVemFOK3J0L1JDb0hndVBGREFHejdnZGVDcW83WmV6?=
 =?utf-8?B?UGt4dUlRcmYxRHdzenRqSGkrbDVPeGFIcjd3bkdnc3Z4K2dCbThWL3NkRDJW?=
 =?utf-8?B?WnB5Q0NoQ2pIVEhNR1RZbzJpV3I4Mm9oOHh1UXdKSFlja1BpQjdRV0RBcWxk?=
 =?utf-8?B?Vnk5Mk5TOGRITUhZZmEvclBHOFI3TUVUSkpERGlmUlVoVFFBbzhtZjBLNThU?=
 =?utf-8?B?MjRiOTd6SVdtOUlTLzdtcm5wcHhZd1Nmd1l4QzkrN0crYXB4ckZnTGdxRklG?=
 =?utf-8?B?TnYxV2pETENBaTVtMGNpSmx2Q3I2TnU4QkpYcGFlcmdBT3lKN2wrN2E3WVl4?=
 =?utf-8?B?V2VTNFFKeFByNXVsSFI3S2pEdDd4RHpSTS9GNmwwa1F4MnFpQ0kzQVJYTnFs?=
 =?utf-8?B?NnJXa1A5WjZCZHhLdC9Lejk5dmdsZlF3Tjh1RmxQZ1hzdGFGOFk5Wm4zWi9S?=
 =?utf-8?Q?1k9I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6748.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGpVYlFHQnFqSEhTZjVyamk3NGh5d0ZIbVF2N3VEL2NMa2hJbTdzZm1QT1lC?=
 =?utf-8?B?RGhjSFZZSjZ4ZXdUazlmb3lBcitCSXEvNFJUc2JDcFVDcWFIcDRNUXJQbFBm?=
 =?utf-8?B?Q0lPVnZJc21pK1R1cDdFY3V5Mm9PT2JCM243ajEzWVp1U29TTnh5eEdkNWhw?=
 =?utf-8?B?L09hajBXVFNMRFJwaXZkb05KVlpkSENSYk13U3N3dkRmcDZvR3VTWTFRQlRi?=
 =?utf-8?B?UG43Q1dPYUpjaTNDcmZobkdmL2tNNkZhdUFFV0RteW9ieGRiNjhTS0F2aXlU?=
 =?utf-8?B?MlFJdDRKN1pKNURZeG96OUU4M2lzK0Z4SVFyUndoaVR2Y3ZGbVNnWDBGaGZO?=
 =?utf-8?B?ZUdPdis1Qis5UzlpV2pLRHpRN0hrUW9pTjFmaW9DbDVqdC9RMFBiaDZCWnNS?=
 =?utf-8?B?ellQWldjN1o2Uk51RVBLcW9OL1ZIUUtXUEwwSnV5N0gyUy8xMWZxNXVGaytU?=
 =?utf-8?B?ZGppd205T0hkVUZmcXlUZnMrT0djajJXVnEyRzFDSFowR3FHWlRtRkh1YmdK?=
 =?utf-8?B?Ty95amJpMHNKSnhlQ1I0RUpjd2d0bVpIM29QZUVGYlhaU3NzK2U1NGxxMTZz?=
 =?utf-8?B?S0NvRFlUckdWeENIcjA2TGJ4ajZ4N2pwY1JJSjI5MXgwdk11dFkzZm8wUjNC?=
 =?utf-8?B?ZmJUaFNTQXN0bjkra0FCU0tlczFsN3FWWStjZERvekx4RHhvaTlhb204N09L?=
 =?utf-8?B?UEhqMkJmbnZNTDBtYjdKMTBaems1RUxiSU1MQUdlT1doeWE1UWZqYWpweENp?=
 =?utf-8?B?TWdLYWVkQXgxMXEycjZ5ZFM3KzhmM0hhVlJHdkRyMkp1dFY2VTlOTWNBVjR6?=
 =?utf-8?B?MGFpOEdwaU9mcituWmt4RjI3L3R2SG1XVnJzTEYwUko4TUJkTlJkNHNxUnA5?=
 =?utf-8?B?Y3UwMjNZSmJxbmJaR0w1Q2d4K3U0ck5FejVMdHp2ZU9sQ0lrdUdwL0lRYlI1?=
 =?utf-8?B?eHZSNFhBd01FKzRTTncxbXQrbWlHZVVXSGlYU1hJTVpOa0NTTFdMQUNsZ3o3?=
 =?utf-8?B?THN6cC84VWg5OVFKL1JSOTV4Q2NBNVZ1UjU0ODZiRVlEUUlOZ2lJcW9yY2h1?=
 =?utf-8?B?K1VGM1FPam90ME9KSjEwV1JyYUk1YXBuQklobXpaU2ZaNVkyZ2VjcEtka2x2?=
 =?utf-8?B?YUlnN28rOVRUME9wK2xBZVBydFhJWENERWtxQkZwZGZES3hZbEpUUER0czVI?=
 =?utf-8?B?Y0ZueEFrOWovTE8xSU9pdW1TZWpsNTZXcjI3cTNlaHFVZDAxQ0xyTlhYYXlY?=
 =?utf-8?B?R3NEbTFUbFN4Q3BSTk9GeDdtcUpyd3V4R3J0eWJOZUtFNDJKUUNVc09NMkZS?=
 =?utf-8?B?aXVISUZqbWN5eXdsbGcxRFZKODhyVm5wQlBVUytlajZGVkZuc2NQcFVUZkk0?=
 =?utf-8?B?SW40UTFHWmZ3c0lEclRFb2U0RzJCald2TkZUWXIyR0s2K2VJZHI5MlR2NjJo?=
 =?utf-8?B?d2ZNdnh6Tk1USEt4RVRWdmxtZ1U5RlFodDE0TTRheWdiL2NZUXZ5ampOdHpS?=
 =?utf-8?B?VEFOZ2ptNlJ5eHcrWkpqa1MyUUVxdHZsYWRRajJPQ05Td3V5ZDE2UFlMbmdY?=
 =?utf-8?B?cTBjSGdMcExWZDZQZnpJSHM5Tm9SVWdOY0hSVFZZNXMvS3QybU55eklHVk9V?=
 =?utf-8?B?QUo5WXdVYWJOQVEvMHBsdExHajJtN0VGa2h3WWsrZXhFa1VxL2FKSFVoQnBV?=
 =?utf-8?B?K1ZuNGN5bHU1ajE3bjRkTnFpZXlzSkFlenQ2YU8xazZJM0xMSUdqRHhab0xX?=
 =?utf-8?B?VW9rdjVZRldMUVZmdlBKRzNHUVJod1BQWnZGRysxTWt5WitzS3BLdmxIeUxw?=
 =?utf-8?B?S2FYVHh6TVRXaFpDQmJWdjZocjNUOEJiek1XdmNPV0UwcDJxZEluVnJPaWg3?=
 =?utf-8?B?Zmh1djVWeGFXSWMrOEZEMi9JTVJ5Snp4M0dsNWFNckNYV1JYYVYvSXZMYzFS?=
 =?utf-8?B?emErTXpGVUxxWEpmc29vWFB4aEJ0bWpRNkFqTEZjWHNNTWR5SnQwQlkyN21H?=
 =?utf-8?B?ajdMQXFvSXZxMFpMczZXWVlpYTd3Q1VmY3Y2NlVyWSt2R3B1WnBJRWNWTjlp?=
 =?utf-8?B?K1p5ZUFMWExDNDRJeVhPRDBQWUJYQy9XaUdQZE1TTjhJOUYyRGJrak5IcHFQ?=
 =?utf-8?B?aWxaZ3BZZ0VOamp0dEZnajBJbHowZldjUHU2YTd3eDFJTWVNTmFGaUtWZkJX?=
 =?utf-8?B?YldqN0FQUk55am1aaFgrWU44bHFOZkVTOElZZTNYVFQ3bmdoOVNhd3pGTTB1?=
 =?utf-8?B?aWRZWjFWTTlKQk84c2lTQlg1OWo3YkJFVlU4d0hUa3VVbC95WFpmS1ppR3Na?=
 =?utf-8?B?Tm9LakNpOE9TdWsyYXQrVUsvMmY4cEx4WG91Rk9vZ0gydEJKaGR1Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a887653-feac-40e5-ed17-08de636ce2f8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6748.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 21:40:45.0584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mj+8jCMNulxsE800TNpUbXcYiQBfi5/PbiPSvR5fLaEKEqDg41+231weL7lwogOS1T6noua3j8wSvXZhynlIYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6876
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-256461-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 2DB7FDEE7C
X-Rspamd-Action: no action

On 2/3/26 3:02 AM, Paolo Abeni wrote:
> On 2/2/26 6:05 PM, Daniel Jurgens wrote:
>> +/**
>> + * struct virtio_net_ff_selector - Selector mask descriptor
>> + * @type: selector type, one of VIRTIO_NET_FF_MASK_TYPE_* constants
>> + * @flags: selector flags, see VIRTIO_NET_FF_MASK_F_* constants
>> + * @reserved: must be set to 0 by the driver and ignored by the device
>> + * @length: size in bytes of @mask
>> + * @reserved1: must be set to 0 by the driver and ignored by the device
>> + * @mask: variable-length mask payload for @type, length given by @length
>> + *
>> + * A selector describes a header mask that a classifier can apply. The format
>> + * of @mask depends on @type.
>> + */
>> +struct virtio_net_ff_selector {
>> +	__u8 type;
>> +	__u8 flags;
>> +	__u8 reserved[2];
>> +	__u8 length;
>> +	__u8 reserved1[3];
>> +	__u8 mask[];
> 
> Is a `__counted_by(length)` annotation relevant above?
> 
>> +};
>> +
>> +#define VIRTIO_NET_FF_MASK_TYPE_ETH  1
>> +#define VIRTIO_NET_FF_MASK_TYPE_IPV4 2
>> +#define VIRTIO_NET_FF_MASK_TYPE_IPV6 3
>> +#define VIRTIO_NET_FF_MASK_TYPE_TCP  4
>> +#define VIRTIO_NET_FF_MASK_TYPE_UDP  5
>> +#define VIRTIO_NET_FF_MASK_TYPE_MAX  VIRTIO_NET_FF_MASK_TYPE_UDP
>> +
>> +/**
>> + * struct virtio_net_ff_cap_mask_data - Supported selector mask formats
>> + * @count: number of entries in @selectors
>> + * @reserved: must be set to 0 by the driver and ignored by the device
>> + * @selectors: packed array of struct virtio_net_ff_selectors.
>> + */
>> +struct virtio_net_ff_cap_mask_data {
>> +	__u8 count;
>> +	__u8 reserved[7];
>> +	__u8 selectors[];
> 
> Similar point here for `selectors[] __counted_by(count)` and `actions[]
> __counted_by(count)` below.
> 
> /P

I can add this.

> 


