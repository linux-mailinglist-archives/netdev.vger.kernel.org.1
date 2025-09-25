Return-Path: <netdev+bounces-226250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BBEB9E812
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4D74245AA
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E6127AC59;
	Thu, 25 Sep 2025 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MDXhakmt"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013010.outbound.protection.outlook.com [40.107.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C138FA6
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793915; cv=fail; b=JksKoY4PP8vzoH/WMGe7i1XpthRFZStGyRJRY2LYS5LzQxRjx6GiT9OkLMQRLAD9aDnDYhpoYTyE3/OI8y8Sy6iCcBeGj94FkrwFqXnTji/NCxxJgtJeYgH/F8FkliHTCy8R2Vlx53Z7p6cv86SGecMuBKiMttS8GW/NyZD+/8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793915; c=relaxed/simple;
	bh=Wgrk7D2eDpNsAs2u5xmj5YkjzaKdg2CXL6HuTqcwjfY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nrtLgmFu5HXHhZFq8Elkdy1BXTgrQyiXYj90K9ty0OrGKQd5Gvi0fI42mLNsr+brdqd16C1pXolTkhiIlN0lJkgdPYvfWuUhd+Um6QExyYg1ZtWZDSJi0DK4wrnNz9C3WPdQikQI8IQJxQsW2y/ov3qixImr5ikKq0jXeYhglzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MDXhakmt; arc=fail smtp.client-ip=40.107.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+RdZpNlkCkGhoOpEJ7+kYwjbg+rbg4Ep+2jt+fNJcGyTTTQ4hVLnqLCv3qzc7bYFCalrRYRNStkgWleu9ixs/NeBz2LuspoFRvP84gTGwkO9BUoI7K6mQ2AeKpoXp0QVhHLOEOIq6JZyNHwEViSSk9IryJhFLMZ4g275gJwvMlRJmlT3AnTDk9yCx71Xtk3f4ZcO3PwRrLCkCRgrNy24inHmfKcXfW/1XULYsYO41MVVR8hrZ0glKx5CqiBvZZa5tbh1wjeQOSLwmJiU/Mb8JeTuI0tTgKlBi0SmaT+tuOskQd8WuEl/v78JLHEsSgYLwJgKCpQKSPy1q5MJ+EocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+b5zpKbujGIp05DtHAq2wbibz/MA0O8S9pvUbPKXc8=;
 b=AU3/BdtUIDmou5LdCsudstq8pJyhCkngFMBW1WDpsGHdOQUrMRineeGLUgvkZ+yMN45SufuHJd67X1by+f18mheQiwSMdkrp6eGyi8LqqX0Pc/a3NdlY8zP6iu0gGqPuGcG0C45GnC4iSHj8auY7UbQjxwRI6wWzEv50CPbzE+sDCI208/n6kX6x0VosXQgEDmBsgFGOjZy4TAAhSA2I+tI145XQJriCFrlondoBCyQqY0ZgzIS8U0pe26ghHeThaNKLxxTzmm2tNkUNKTdf7eyQTWlAC7ti2GkQOa5BEUpYXw4FlwXaJN+vDezqQGZXZxxQDX9DPrjX3xgvEOJ3kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+b5zpKbujGIp05DtHAq2wbibz/MA0O8S9pvUbPKXc8=;
 b=MDXhakmtCRDCn/4l7WjJZGLm/HDuHH3sAbSmY3KPFLJYVXPgiJS0s40d0vYGUtnZtMGf0LFIxDN5d8iraphRuF6nVHqqLYLqKTOpvJeL3V6bt5ok9l1veTre55Xehle3hIMrpPa7IFFS7ZRgfly46wB18E7ysGIgUEiutTPEnLDz3s/m8283ma5DItMkxd+a+nWW4kQc6ezKmB4m3hpYZJXNXLSMTnIrWBO70qQH1I5Nf5qdpLJmtT864kZwr/crj9EqxL1ezhOjkoC5EMCDMDHWnWPi/KPBBuvnivqEbSGRHcGiT1CHKDimCN+hcg6quHXdovoqJ52oWXfa0HizVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 09:51:50 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%5]) with mapi id 15.20.9137.021; Thu, 25 Sep 2025
 09:51:49 +0000
Message-ID: <4fa7bf85-e935-45aa-bb2f-f37926397c31@nvidia.com>
Date: Thu, 25 Sep 2025 15:21:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
To: "Michael S. Tsirkin" <mst@redhat.com>, Dan Jurgens <danielj@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 alex.williamson@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, shshitrit@nvidia.com, yohadt@nvidia.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
 Yishai Hadas <yishaih@nvidia.com>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-2-danielj@nvidia.com>
 <CACGkMEtkqhvsP1-b8zBnrFZwnK3LvEO4GBN52rxzdbOXJ3J7Qw@mail.gmail.com>
 <20250924021637-mutt-send-email-mst@kernel.org>
 <16019785-ca9e-4d63-8a0f-c2f3fdcd32b8@nvidia.com>
 <20250925021351-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20250925021351-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::11) To CY8PR12MB7195.namprd12.prod.outlook.com
 (2603:10b6:930:59::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7195:EE_|DM6PR12MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7f4d22-ab54-46d7-e442-08ddfc192559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmgrcStOZjd6L2lUeW5sdmZiaytXQk5ZcCtZb0J6eWFzc1VldHg3WVloVFFV?=
 =?utf-8?B?WmJKb0xKWDc4Sm1sWE9DdUpJMFlvOEUxQ3FMWDNHdFFVTEl2YzJvck1SQTBy?=
 =?utf-8?B?em82ZFY0N1ZRYStVQTF5U2NWUURaVSs4Mjl1a3VYS2xDY2E1U1BncDhVZU9h?=
 =?utf-8?B?OXUzdzBrdDNsRzdqeDZaZHV0Yjcwbk5tK24yRDBxcHIrWEthNUovT0VPSXg3?=
 =?utf-8?B?V3plU2ttNmRsNkdPL1dVNFArSWRJQmtoZFJRZW81bUo4VVM0eVNPbE9KYW0v?=
 =?utf-8?B?eWRKL09iZ1cvRFZ5TlhZNWtvclVLK0ZVb2V2VFhIZmI0bGJNK1ZlSFRYaHlH?=
 =?utf-8?B?WGhhbm4vTytqdWcyWGhqYjBwRWFKYThNZVNiVXNXbTRLSUttdnRyaWtaR0Zw?=
 =?utf-8?B?M2c1bGhpcnBQMzhYRVRVUDFvaTE5ald4Q090ckJkbS9naE5pQTh6YXRrSGcz?=
 =?utf-8?B?NnlqNzM0d3ExaGNENUozTUpWajQwc3NRYjhoUWJucm9YMXN1dGY1WC9zVlI5?=
 =?utf-8?B?V0dLQ0tYN2VCVmg5Nm5TZk9KRTNPTEwxOCtJRS8wUUJHRCt5cXU0eXhnVUtn?=
 =?utf-8?B?Q2wwSFhNamM2NVB4ZlRRc2FOUDRMOXhJRkRJa0JKTFl3SjBTdnFXeEZMdDBR?=
 =?utf-8?B?bGdpSHQxSmVUM2lDU2ExNWJDd2VLUDNtWHhxYXBiYTErUGE0cVlnV0ZLaktB?=
 =?utf-8?B?eSs5L2hIN3ZvQS8rcVdjT2Zmei82dUVkOXM2MlUxVktDYlUxbFFBM3h3Z2gv?=
 =?utf-8?B?Y3haM2NwcVB5M2xuOUdUT3BodW1pOHpCdDUwRzdUQXpLdjhLNFdBYWNUVWZy?=
 =?utf-8?B?NlYxQmdudmhrQS9vZUJBcTZ0eTUrOGRiRS84ZDdXYWFkQ1pKUk02UFNWTDY1?=
 =?utf-8?B?Wk1iUVBtdU1hTTNLRjFTK3JCNDdveTZRUkRDNEg3MjAxaDdFTFhyVU4zRE9U?=
 =?utf-8?B?QjlqbzRPS0I5NkpkcGRBV3kwZDZ6ekRlQW9PMnFFbDgzL0l3Q2NzejRiVnRa?=
 =?utf-8?B?VWNGbzhUWjhwd2g5Sm16dHQveng0WlEzd3dvL1phVkxOUGlaalRaRGtsSGVt?=
 =?utf-8?B?dFFLNHRFZmV4eXNVczI3d0dXSUU0dzB5dlZlNEVEeFpzWGRCc2p5TUtaR1Ra?=
 =?utf-8?B?c3VhcmM4bDI1QWtwdmc4M3VYSk9GNnNIbm1ZbXFtM1VzeUlRdFpYcVpZR1ZZ?=
 =?utf-8?B?N2JXQnhLb0hGc1Vqc0xsWElKVk5DbzlBYVFwWnVPcGN0SXJndjZ4SXBtd3kz?=
 =?utf-8?B?TGtkbjRhcGlBc3VFSG14UlMxVEE4V3BmZGRTQ25NalNxcVMxdGJTY095ZzBy?=
 =?utf-8?B?TEdMeE9IRittNVdRRFhkZS92VmN5dlphQ3VKWHVtVzRrQ05URHdCQVRlSHZ6?=
 =?utf-8?B?STlqV1NxbHRNNTVEVHJMUzU2dTd5Rm5mQ2w0L2J2Z1A4M0pyUW42TWg1dG1O?=
 =?utf-8?B?djN2dG1rSmI2MXRnWXo4WWNlL2pYWmdMbitGWDd4THIya3RHZnM5QTdDK1By?=
 =?utf-8?B?LzlSY0NYTldlUWVHelpvdnc2aXpDNTNtbWhlRnVnUXhONktpNkZSL0tkTVRM?=
 =?utf-8?B?UlRzL205bXltWm4zdnVDMlBnMjYvSDlZNUF5Qm1Dc0tDMHJFbStjb1A2eUlq?=
 =?utf-8?B?U2h4a3NaN1hyR0l6QVBUMFEyLzQrSkZxSXV1cWc3WSttYWVnZVFZZUg4L2J0?=
 =?utf-8?B?WVpMSzNkZmtnVkNyMW5pVDFvSk5HcUgwRWZrVFBadnk5Sko3UzBhdnhBVXhB?=
 =?utf-8?B?VERBYTlQWXBVNjlzYVozNGlUemtEWkt0Z1RkeVpqLzNqY2JuaERUdTAxOUxu?=
 =?utf-8?B?ZFJkTVFkaFRMVElQVGxFY1Q1UytUYjZVYnQyT1NEdGVIeS9nNzg5aElsQW0x?=
 =?utf-8?B?ZDIzVHppTVZ1QjZaeVE4eExnZXRaYWZHTGRkZC9ZZUd3cU9xK0pQWS9EK0tT?=
 =?utf-8?Q?bUXAqaJbRAY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmY0UTNxSFU4VHJ4ejRObllEa2JLOTNHbzZYM2NzYjFPdS8wVjNpREN4Uk5C?=
 =?utf-8?B?S2dFekFuT0FlOWFuMWNTT2U4TjZ6dkEzUm43VC9QcXpBaElzWEwyWmpDRUR5?=
 =?utf-8?B?c1c4VTZ4WmhHcHNHT0RJbDdyRGt0c01GWHpIaCtUOXlheGhPNlZqNFFocEoy?=
 =?utf-8?B?TGphSU1RU0pyNlBwTGlXR0lGUDc5MExqZzdaWU9Ma25IWFZFc1dRdmp6MFNh?=
 =?utf-8?B?anFMRDBxZTMvZlN3OERQbEkxRTBzalU5SUxjSHZRQXduSEQ5eE90NGNzM21N?=
 =?utf-8?B?Y0lXNTA4Mkxnb0ZqTms1TUV5d1FKT1VhL1IxVXZsV2RzVkxwalJ4eGRyVHRw?=
 =?utf-8?B?OHF5L3J3dnZ2c3JyRlpSNlVUblc0R1k3TW56N1B2V0Q2dU9VOHVlNlo3dFZQ?=
 =?utf-8?B?VzZsVWJGSWQyWkQ4Z1M3aDgzK2hBZndyTTNSeWRvMTRoQWU1Y0lQL0JqdXZv?=
 =?utf-8?B?TXlmcnhockd3Zk1aYmN4VUR5SnJoeDM2S1ozcEx1eUozNFc1d1VUSXZncFBP?=
 =?utf-8?B?TnNkc3lnbzNrU3lpWkxLR1ZoM1RxUmZzdmJJajhzUDlHK1lIcGRDL2ErOHFI?=
 =?utf-8?B?ZVFBT29qZ0pVTmlPdmVOY3pEMWZOUmlmOHg5N1BjK0dXODdKc0paVjRDc3Vx?=
 =?utf-8?B?T1RIWkxVQTZTZlBiSENYTG8yc0FHRkhuQ29Rd2VoYTBOWmc3VllKaC9HM3d4?=
 =?utf-8?B?VHNKem5QSjRRdG1MSkZLM2tlNGRmbWwxVmhNNkJvaGYzbGRCVUdnTU4wZjNZ?=
 =?utf-8?B?aDkzNmVkcUROV01qSnBMc3EyZlNIb1NKaU5iVkxmWVM1dnU2S0J5a3dCSnM2?=
 =?utf-8?B?QzllNEtzeHUydU9sM1ZMNGU3OGU0QXNkVWh4SlRiQXhiUGVGTlRhTkRMWnhp?=
 =?utf-8?B?MkltajQ4MkVoMkp2NDlhRUoxNXRZWFFIV1NoQ09VbmlVUDBCU3hEWW9uclEz?=
 =?utf-8?B?amVyaktwcWZKTXJWU2dHQTRVM2s0b1VtUnJZUnhFSzRpOHpEOGkyQlhyREVy?=
 =?utf-8?B?WVBoU05OS1UvUFUyV0pkbmtoekJhbHFBUmZXemJnWTluOCtjSVg4cUxLWkFq?=
 =?utf-8?B?dWxCZW0yRFdWQXJKenR4MzRPdlRyRU9CL09SZ2VGM1E4QzFoeGR0eDRTZEJN?=
 =?utf-8?B?RWt3UUVMWTFYbHMzVWpxT3dHTEpBS1NZa2NzNXZpVlJqL0hrMVl2di9PQUtW?=
 =?utf-8?B?RnJpajJNSUxkNEVJdWMxK1JJYzVLcU94d3VXcmI4d3FPN21WSStqNkNTcURh?=
 =?utf-8?B?dVhHc0w4QzVVemxBdXQ4VFVpeDNrU0Z2UWNtYWw2d3RYRVZVamxVQ3JQOFRy?=
 =?utf-8?B?L0ZFa28vMVhJcmJHWkxNQWpPK2ZXOVNSUUROUG90dmZOYW5xYVFaUjUxajE2?=
 =?utf-8?B?R3Z4aDFyZUovQjlDVW1UUUFDeHF0TlNFTnZpMmVVZlYwVGhMbzhqb3FuVXBG?=
 =?utf-8?B?WmlQNENjaWV2YVcwME9VTDUvNTNTZXhhbkg4Z0lqTzdhS3AwQnl0TlJjZnkv?=
 =?utf-8?B?dzB5eFk5OGphWVVmSFd5M043SjdrTHl0T1ptYVFWRkk1czY1V1F1SHVFanYv?=
 =?utf-8?B?REtCSnk4SFB2SHhMV3FtaitMd3o0SjdaMmwwZkgyajlzdVVvTCt2eFVSYzVD?=
 =?utf-8?B?Wk8xYlQ5cU5ZbFpiczZ3cTBnbkdlV2xXTUlyK3owVkJhVjFkL29yeFBjb1I0?=
 =?utf-8?B?WnVZVHF1VUFCOTd0blU2L00yT1Q2Wi9BQzVlVDZyY25TNlUxM3ZwVkprY2Ju?=
 =?utf-8?B?ZFRkVDdDaDkvbGRTdXBNb0RUL1B0OWR4TktPSDNnT0FnQXU2Vm16QzZ5QWNq?=
 =?utf-8?B?UVV3cDJ1NEs0M3JiL20yNC9Lb1lVWjhGS2pCQytDVWtvQUhldHZuWHZGTGVV?=
 =?utf-8?B?ejRnYUVYOG4wSHRkdlhCMzN0Rkp5M1YzMEpLM0ZvSjJFRE9SNmZaa243bkwr?=
 =?utf-8?B?aGJaRkQxYXVPZTZIR04yL1ZwNkh5NXNPSGhMQjdtTVhGR1ZJdzd4bEUwNHVy?=
 =?utf-8?B?U01ua3lJOTVLTVRJOXVwSWd4TndKRFdid3crbXczNjNZc0RsWmRpL3VsK1lZ?=
 =?utf-8?B?TGZrTUQxYzhscWI4QVN3QjE1UDRJNTdsb0FRYXBTdVVOc25kdjUrN2pIMERW?=
 =?utf-8?Q?0L6Gvb2FKs7XiI0YDbKT3vDo/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7f4d22-ab54-46d7-e442-08ddfc192559
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 09:51:49.1688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSQ2YR4A2Qgm4Om/gCreZ9fqY4kkuiHGaizPVXwhJVaf1NpEePQCLtpEpEycNgrvw7HYjoyapoNqtHseXxMsRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218


On 25-09-2025 11:46 am, Michael S. Tsirkin wrote:
> On Wed, Sep 24, 2025 at 02:02:34PM -0500, Dan Jurgens wrote:
>> On 9/24/25 1:22 AM, Michael S. Tsirkin wrote:
>>> On Wed, Sep 24, 2025 at 09:16:32AM +0800, Jason Wang wrote:
>>>> On Tue, Sep 23, 2025 at 10:20 PM Daniel Jurgens <danielj@nvidia.com> wrote:
>>>>> Currently querying and setting capabilities is restricted to a single
>>>>> capability and contained within the virtio PCI driver. However, each
>>>>> device type has generic and device specific capabilities, that may be
>>>>> queried and set. In subsequent patches virtio_net will query and set
>>>>> flow filter capabilities.
>>>>>
>>>>> Move the admin related definitions to a new header file. It needs to be
>>>>> abstracted away from the PCI specifics to be used by upper layer
>>>>> drivers.
>>>>>
>>>>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>>>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>>>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
>>>>> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
>>>>> ---
>>>> [...]
>>>>
>>>>>   size_t virtio_max_dma_size(const struct virtio_device *vdev);
>>>>>
>>>>> diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
>>>>> new file mode 100644
>>>>> index 000000000000..bbf543d20be4
>>>>> --- /dev/null
>>>>> +++ b/include/linux/virtio_admin.h
>>>>> @@ -0,0 +1,68 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0-only
>>>>> + *
>>>>> + * Header file for virtio admin operations
>>>>> + */
>>>>> +#include <uapi/linux/virtio_pci.h>
>>>>> +
>>>>> +#ifndef _LINUX_VIRTIO_ADMIN_H
>>>>> +#define _LINUX_VIRTIO_ADMIN_H
>>>>> +
>>>>> +struct virtio_device;
>>>>> +
>>>>> +/**
>>>>> + * VIRTIO_CAP_IN_LIST - Check if a capability is supported in the capability list
>>>>> + * @cap_list: Pointer to capability list structure containing supported_caps array
>>>>> + * @cap: Capability ID to check
>>>>> + *
>>>>> + * The cap_list contains a supported_caps array of little-endian 64-bit integers
>>>>> + * where each bit represents a capability. Bit 0 of the first element represents
>>>>> + * capability ID 0, bit 1 represents capability ID 1, and so on.
>>>>> + *
>>>>> + * Return: 1 if capability is supported, 0 otherwise
>>>>> + */
>>>>> +#define VIRTIO_CAP_IN_LIST(cap_list, cap) \
>>>>> +       (!!(1 & (le64_to_cpu(cap_list->supported_caps[cap / 64]) >> cap % 64)))
>>>>> +
>>>>> +/**
>>>>> + * struct virtio_admin_ops - Operations for virtio admin functionality
>>>>> + *
>>>>> + * This structure contains function pointers for performing administrative
>>>>> + * operations on virtio devices. All data and caps pointers must be allocated
>>>>> + * on the heap by the caller.
>>>>> + */
>>>>> +struct virtio_admin_ops {
>>>>> +       /**
>>>>> +        * @cap_id_list_query: Query the list of supported capability IDs
>>>>> +        * @vdev: The virtio device to query
>>>>> +        * @data: Pointer to result structure (must be heap allocated)
>>>>> +        * Return: 0 on success, negative error code on failure
>>>>> +        */
>>>>> +       int (*cap_id_list_query)(struct virtio_device *vdev,
>>>>> +                                struct virtio_admin_cmd_query_cap_id_result *data);
>>>>> +       /**
>>>>> +        * @cap_get: Get capability data for a specific capability ID
>>>>> +        * @vdev: The virtio device
>>>>> +        * @id: Capability ID to retrieve
>>>>> +        * @caps: Pointer to capability data structure (must be heap allocated)
>>>>> +        * @cap_size: Size of the capability data structure
>>>>> +        * Return: 0 on success, negative error code on failure
>>>>> +        */
>>>>> +       int (*cap_get)(struct virtio_device *vdev,
>>>>> +                      u16 id,
>>>>> +                      void *caps,
>>>>> +                      size_t cap_size);
>>>>> +       /**
>>>>> +        * @cap_set: Set capability data for a specific capability ID
>>>>> +        * @vdev: The virtio device
>>>>> +        * @id: Capability ID to set
>>>>> +        * @caps: Pointer to capability data structure (must be heap allocated)
>>>>> +        * @cap_size: Size of the capability data structure
>>>>> +        * Return: 0 on success, negative error code on failure
>>>>> +        */
>>>>> +       int (*cap_set)(struct virtio_device *vdev,
>>>>> +                      u16 id,
>>>>> +                      const void *caps,
>>>>> +                      size_t cap_size);
>>>>> +};
>>>> Looking at this, it's nothing admin virtqueue specific, I wonder why
>>>> it is not part of virtio_config_ops.

It is very clear from the virtio_admin_ops definition that it is not 
specific to admin vq. It is a admin command interface.


>>>> Thanks
>>> cap things are admin commands. But what I do not get is why they
>>> need to be callbacks.
>>>
>>> The only thing about admin commands that is pci specific is finding
>>> the admin vq.
>>>
>>> I'd expect an API for that in config then, and the rest of code can
>>> be completely transport independent.
>>>
>>>
>> The idea was that each transport would implement the callbacks, and we
>> have indirection at the virtio_device level. Similar to the config_ops.
>> So the drivers stay transport agnostic. I know these are PCI specific
>> now, but thought it should be implemented generically.
>>
>> These could go in config ops. But I thought it was better to isolate
>> them in a new _ops structure.
>>
>> An earlier implementation had the net driver accessing the admin_ops
>> directly. But Parav thought this was better.
> Right, but most stuff is not transport specific. If you are going to
> put in the work, what is transport specific is admin VQ access.
> Commands themselves are transport agnostic, we just did not need
> them in non-pci previously.
>
Should config_ops be extended to have admin cmd interface there?

No strong preference for putting function pointers in new admin_ops or 
config_ops.

I just find it better to have admin_ops clearly defined as it makes the 
code crystal clear of what the ops are about.

Today, one needs to be cautious when reading config_ops of below note.

"Note: Do not assume that a transport implements all of the operations".

Having well defined admin_ops appeared more clear. But config_ops 
extension (or overloading) seems more simpler, no strong preference to me.

Regarding Dan's comment on "net driver directly accessing admin_ops 
directly" seems a bad idea to me.

Function pointers are there for multiple transports to implement their 
own implementation.

it is not meant to develop open coded drivers. In fact some day 
config_ops struct definition can be restricted to only transport drivers.

Major part of the kernel does not follow open coding function pointer calls.


