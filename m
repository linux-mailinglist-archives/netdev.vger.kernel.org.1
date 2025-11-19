Return-Path: <netdev+bounces-239815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5623C6C9EB
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 04:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3598C342834
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376CC238C08;
	Wed, 19 Nov 2025 03:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="knOtWC+4"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F02135CE
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 03:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522954; cv=fail; b=D4aurLvmfeXZRTwjyb6IAqmnOiVmj3mlZ9ix6QBS/QaQyazmh4RWK+aDmxmtpMyaQqvoEKpAEBkn969ZsbxAKC/uRKIiXTmwUoZQm5mXeT/wW2XtkHxmqJR1mzCuAD5RKqFVcwbRYRJUtK1aqFbP+3oL5bvX1Ld5EbgH9YZVmQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522954; c=relaxed/simple;
	bh=SFpYgfx6+QHXS5y8a8b6gAMJVdqf5b97wE8bHunWesw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aLwYvNMhEKjkVp35Ey+wMAT+zKevaaeoyjPT77h6Lx6rZhHs6Y9JKPqsKcP4Lcnv/+hOYEvbUNHNESkLvTnjNLd0CvIlpYMPvlfPEcXT9e5mqZtorlGfsz07lS5JBvramxzQAjQUa2J8IgEWmaJbp2NYaIwVoAYZM1oZdhkKNW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=knOtWC+4; arc=fail smtp.client-ip=40.107.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9GXqybQ+1wKg783c9SY3hk4Xs+83mL31k+FGtAm/ZhZpqSjD2Ge0+yPH0a06Zv9yh8Xp7hD2xzo75qWf+2udsHQfmyuql+XIkWQEQiZLcEiBfBV1nlBcwqQ7AXE5EB3hXSpjZssMI6CQA3MzNB8oFPVx5ZKW6o75UTZ3V4ko6Iu4/+gz8TkiOSNPohaoSTExA94DV8eneQEJx8ihcKQ3KW9jabQkMSUEUciuGV2gthcU5xWdWC7TkSKEm+Bqp3yXpWwmSbt+sh+5ddD7/KeCWtXJtvhEA2i1Uf9fFSJvaXOc6w91PTI77REVxKPsJgP5y3pL1qYuF6YmVVwQiGsiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dx6St2gR9mql7eU9HN8/j8on1sgrl5CsmSqP0CUoVaU=;
 b=yXl6Jb9HOx3MbjPR9H4rICEM+m+wTBIwvVeNuyoIMjTqhRXLFe55dqJV2BRWYr7o04+Nb5QHBlOPUmxZY0AxMyzwBY/m6dazsSSgaMl1O7F8PRXcIVB4O/Rn1gDnokjgvAqzGIRlJj+i9TeyRrbjCcqrBzH6kCs3D/K/GOoJE2ejPAPxOwza5QfdK/M7wV7tFguZS5Axyk93y73SoZ3is3wbCOE0q3/SpKs26aNissfpA7NlZ7Sv/T55uiKDmKA3LqagkSmc7CvfUzAZxBKFIPJawHIy0IpskHuDI13pk+TanrKYdYLxTXwMHjTkLbzQLqnuNn3QSJilBULDiG4P1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dx6St2gR9mql7eU9HN8/j8on1sgrl5CsmSqP0CUoVaU=;
 b=knOtWC+4YhxxHSlGc7DYuM45zEsq1Rz0mGbSwHkVUNxfyDu8wrY6MuOXMI2gf+ZRlF+0eocAHncFWWwIKA5QpEUusAKY87pyAxw4yXGNzXfUYlJjnOcHW5S5XPbyUuCcnG/B/H2g/R7gr344ui7S3dkpv559t3GZ9eERwqioCpdbRMFOJ6wrt/Bw4ug/I3R2E+/HtkRlibYO7a6uJqi8kWAGSE2w4UQy9db2auvq53k2ATDldiyQWQQ8bVKz1k2HhmWWQQNxFJDwTeBEFMzpKqj5TKaCNaWty24gwNumBqCKs+jjpzsKbZzJjunZZU9XMTdGWya1GPqmG/dSnWf9eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 03:29:08 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 03:29:07 +0000
Message-ID: <e5641fe1-e1a7-4f3f-b4d0-1dde55e47c83@nvidia.com>
Date: Tue, 18 Nov 2025 21:29:05 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 04/12] virtio: Expose object create and
 destroy API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-5-danielj@nvidia.com>
 <20251118171338-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251118171338-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0079.namprd07.prod.outlook.com
 (2603:10b6:5:337::12) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a82090-0ed6-47ce-3057-08de271bcc22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnN3ZHp2RC92Z1pkVHF6dERBSjlZQStnZmJoUkdueFl1Q2RITzdNQTh5UHdV?=
 =?utf-8?B?Q2R5YTNmTGlES05CUHVQRnhCN1JLMHNnZlBDN2NQS1FhRUZBaGdxcUNIN0lM?=
 =?utf-8?B?TXdQOW4wWmdiNDBSa3E0REtiU1V3d2RhMEtoSXdXcGNkWDZkV0JLTm9kWU8y?=
 =?utf-8?B?ajNhSWhGU29jOHZsbFdJMWpiQUkvalp6aDhNbDhwV0JoMzk2aXZNSmQvQkpJ?=
 =?utf-8?B?Ykt4L21PbFhYRkF2QzhXc1pxMThTV1JaZ1RYQk5hS0FRanRTaWVsWHJmMGVG?=
 =?utf-8?B?V3VhL3JnZURBVE9YMngxVlV6QWQ4RGF2VHpqMHRzL3l2d2F2K05IeTg5bU9J?=
 =?utf-8?B?dE00MXhtMUZGL0w5dVhvckhxZFg0djJvMkJwalVVNUQwRlRwcnZYbnpjaWY3?=
 =?utf-8?B?TWJ0WTFTbzhVTFoxQTJlOWNTVWtBSzRzcGJvaXltS2xJV1hFR2dncnROTE5X?=
 =?utf-8?B?eko1ZG1aZFV2aTBJM2tOaXFnTDlJSThDM2hKblR6bGZhMlNJckdSbVErNWRG?=
 =?utf-8?B?akl2OVY2cmkrbCswOUpyVTJVWGJKbWNnRk53Qm5JL0gvTVBna3JLOEtMdWFl?=
 =?utf-8?B?MUxwSHpIUkt5TXhyTVhhbWVEbm8yc0Y0SW4xdHZGeE14ZitYZnlXajZEU2NR?=
 =?utf-8?B?UGMrNkV3cE9jSDBidXdtdDFmbm5kcnJOTlNIRkV6WUlmLzNsQ0dMd1lueXha?=
 =?utf-8?B?empSTHZIN0RIcHAyaE5LYnd1elVuZ00vbDI4OVhJM29GN09QVklQWm50ZGor?=
 =?utf-8?B?WFlYU1AvaEovY3oxa0xjSHBKYVpxdFcrbitYaktMeVBrRXJTdGhZRlpnMHV3?=
 =?utf-8?B?V01kT2dRTjltalBHL2ZwY29kUERMRmhvY1MvSW9Fblo2ZGh4MThQOElUQkhU?=
 =?utf-8?B?VlFGMGFINUZGdElZRktUMzZWdEd0ZGZoWWJ2SEFYYmJLT21rd3cvMy90MFZ0?=
 =?utf-8?B?WlhWNmU2dlJYUVRISnZxMEk4cWlVaUdkZHBTdkxjaW5ubzB2MzhPbi9FdldO?=
 =?utf-8?B?b0dsbk05NlRrY0I2NXUrdXl1bWZBMGcrZXlQaEltbTlyWVI0ZEJpS3QvMnFl?=
 =?utf-8?B?SnRTTFpvNmVLUGZzTGlhVVkrZnJxZEFQYmp5SGRvSWRGR1FmcUxNUis5L3ZN?=
 =?utf-8?B?eEI2TXB3cE9EWVpwUFZNK1RpUmFhTjZGcE1nSXV3TzNJZEtyc1dNZys2OEhP?=
 =?utf-8?B?K0hjYnRkREdCTHBMV3NjVmsyZW4wcUF4QWJPc0ZJZXUwZnRFemNUMXVHVjVi?=
 =?utf-8?B?bVVEd2tFT1cyd1VlcEVjcUlvMkxnRjlhQklrZXdFcVRxOGZ1MXZMRjVIZDQr?=
 =?utf-8?B?TXlQUDNxVXc3QmtCV3VvbWFYa09OUDMwODI5NWhzS3ZPeXplZTA2d1FZL0Rz?=
 =?utf-8?B?Rmd3M0t6aXU0N25XNEE2dlF4WnVHM21OVDQ1MjlIblBmaktRK2xDNzRJaUE5?=
 =?utf-8?B?ZXlLM3h4STlBdGJSZ2ErdE5uU2VPNFA0dm9lVE50UkQyZ1BwZzJrU0lIY1I4?=
 =?utf-8?B?a3ZWR3Q2d1QzNGliaWFVbVdZMGdLTGZFdVp5M1FuZE9NVnhQYUIxeVp0WUtG?=
 =?utf-8?B?a0xEN3RBZWpOUjNkRFVrak1QVXhlZTRFSjRucXFLVVVlVmRtUVhCOXBCU3BS?=
 =?utf-8?B?OWF5bW5hSUo2R29kczhZQlZCbmdkR2pUcGhFMk9rSGZCYmllQjV2WDcySUMx?=
 =?utf-8?B?K01QVDRXamRzOGpCVkdYNTB4NzBZOE0zckE2WDJjSEpRMmczeDZwMHFQNElk?=
 =?utf-8?B?ZHI0YzhOTlVsMy8yTFAzeDQyWDlCWjVaKzI4b2RWMEhvYWZTTHRIR3BDdlFl?=
 =?utf-8?B?VDNVOVlxSndNYkIwZThOWTZQY3czbytHUTZnYkhrbVQ0dXR2STdFSXZucnlr?=
 =?utf-8?B?NUpsQjF3VXJzQys3Slg5bTdMTkVBR2l2aG9hOWRzVnlzSEdaeWdaWVhJa2hV?=
 =?utf-8?Q?GdCvTfx3WmK154CFurwN0fOEl5C8+7+Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWxMQkEzOExUNk5FYVM4cHp1a21uSUw3UVVWUWRwVHF4eUNWK0NHQ0hWZW0y?=
 =?utf-8?B?dkloOVhHVVVOdE1QTG1kSnJmRmJoZlgyTnZZbnVGc0VEdTZUZytNUEZNTXZs?=
 =?utf-8?B?UzlxMEFqUWNzajlMWTNsLzl6NXNoT1lPMnNoVnBaeWVLaVhmS1NUcDJ5UW5X?=
 =?utf-8?B?MEh2ankrS2liS2VDdk5uVkVGQU5SR21uL1dGSnhBNlB5d0F6dVE3R0ROYXE1?=
 =?utf-8?B?NmNneldoL3VsbE45YS9XS2FzQUVtaFoxNG5mK3RMOHhEUlRLUVlWUHUxNTRE?=
 =?utf-8?B?YnJobnFhUDRiRGU1VFBycE93Y1JhYUM1akNBK21Bd3hndzBkdGNvZ05YM3cr?=
 =?utf-8?B?M2x4SEdpdVFZWmtzVnhnbEx0NFltejY3NVBNb1dnMjh5cm15UC9iSTZBWThp?=
 =?utf-8?B?dVBmSitPSTVIeE1INmtZdCt3MzkyQWllN1hDUzJ5N01qQUJmWUlIN0Zidmh4?=
 =?utf-8?B?bDVvVFVVYmg3WldsVUpmMDVJZEdJejFib0pDMXBBTXhxbW53RndXYktCRlZr?=
 =?utf-8?B?dGhPZ3dod1NNb2FXSzZFWXZ2Y1AzSDhwM0k2YmV4RHhmNU9aY2pWVlk2MDhm?=
 =?utf-8?B?c3dQYVI5TktwSkhuUmtNcWU5Y1pPRmxMOTNUZEhhZ3BvbmF0cXVKQS9xUXQ1?=
 =?utf-8?B?WGE1UHVseS96QTJLdE1Xa3oyWGhRclhtK09ybHUybGFXZWtqbGVUdVFXaFRU?=
 =?utf-8?B?OUgydlVGQlo1SWptTUM2bmY1b1FHdTh3Y3lmbFBVMDN6RFdpdURxMDdOSTFP?=
 =?utf-8?B?UUZtOURMZFBGK3lTaTArMHk2TU5CK1JQb0dtdEFvWXdIcUNNaWVSMU1NdzhU?=
 =?utf-8?B?TmxvT1NWcERPL1ZzUzU0cWVFU1luRURTQk5tRU90V1pKZDVSL3hoMnBRdzRz?=
 =?utf-8?B?ZnR6VlRDMHBUNnJOMHc1Z2tqbUpvVmxLUFZxSWg3eWJmKzBIcHZkTkRxNWZZ?=
 =?utf-8?B?L3NVQkJtS01DSENHalBlczl2YlNxZHN3c283WGVyaE9rYUxZaElzc2hvN0ZR?=
 =?utf-8?B?bDc1VVpBeUVNV0tYbGpvTGVla2JhOGNJTXp3azF3NFREdkdNWXUvN1pBdXk1?=
 =?utf-8?B?REJzZmJFWThxT3Jzd2p3T1RRRStLeEFaYnJBT1ZmZDlJSVc5OGxvNGgza3hU?=
 =?utf-8?B?SDJpeFBmL0o2WUw4NWFLOFRBRm1rQ3JOSVpXSUNwRC9mRFBXNHlWbXg5ME12?=
 =?utf-8?B?c2ZSQm5uei9jVVRrTmswN3JEUHF6RjdwSld3N2R5dWszc0h2OUd5UmpKVDNK?=
 =?utf-8?B?RmFTdjJ3SWQ5NWJreVR3aG8yZDJib2ZhcVFGQ2ZYTDR6ZlhnbUVLdGhFZ0M3?=
 =?utf-8?B?UTlTT2k3blNaUDJCeDFURmlLaTkwM0drV1VoY2Vnd0l2MzhmaXdiSDNoNWsy?=
 =?utf-8?B?djg2QkdIOGNaeDZEZklVM2dtOHdZelVONFYxZHB3RDMxNHhBdW96RlByK2tk?=
 =?utf-8?B?b3Q2ODVkRzJpaldVaFFHVnJNNG1OcloyYXUzYXovcUwvMXlxZ3lrZGR0SGZY?=
 =?utf-8?B?V2hIL0tiaEYzMzJ4YnI3RXF1NFMwNXZIOUdCMDRXR3MwdWFLRFdWa1NhT3Rs?=
 =?utf-8?B?T0tRT01aRmxqOHFOSmI1MkVzeFA5Z1NYZ1V0QnBZKzdCQ0ZPL09TckJ6STh3?=
 =?utf-8?B?UFVteW1ZM1k1cllrUnNRL3lXbHhOYXVXeGJ2R1pmcmw2REtSNnVoRzR3Y0w3?=
 =?utf-8?B?YzFTOVFqa1dtUURUYi9aZVAyVVF2V1JTRWhkWCtueEpIcS9maG1neFIvSkNC?=
 =?utf-8?B?TjZPaFRYSmVsMjhPc05HR21ReTlrZXdCTDIxMXNXUy9FQ2RaNE5ueVFuUUls?=
 =?utf-8?B?c0JkTERxSFRsdGFuWWpFNDRQN2dmNGlXUGx5MUkzYTJkcjdkTjgrenF6UURp?=
 =?utf-8?B?dmcwNXpXR1VBNmhtMHZjc0dvTzVmY3Y0MUVUdlg5aituQzJNSmpiMVJ6OC84?=
 =?utf-8?B?YmFmNkExZDJNRkZ2RlovYmx2SFpCclZIWGU1bi9acitiQWc3OEtyZFZLQjFx?=
 =?utf-8?B?VUt3QkcvNDZ2dlgvS0l2VGhiOFNNejg0UGNBeWJkR2hEUFluR2dlSGlMdlBq?=
 =?utf-8?B?eStZcFVhUG1QcUNzOHhEV0gzVFRRVVlPcEl2czZwZHF6dnZDMjZ6Z3VVbHNY?=
 =?utf-8?Q?UkwUVxG6DZgPqba+VSysIL+1J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a82090-0ed6-47ce-3057-08de271bcc22
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 03:29:07.8388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73fHtyJgU+6G2vOJMXCmLSxZd0De9bqF1KxtyNQaO/urksDszh59rTsChK8KRUE3GYQuOEbzk4HYWf61M2T6hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329

On 11/18/25 4:14 PM, Michael S. Tsirkin wrote:
> On Tue, Nov 18, 2025 at 08:38:54AM -0600, Daniel Jurgens wrote:

>> +int virtio_admin_obj_destroy(struct virtio_device *vdev,
>> +			     u16 obj_type,
>> +			     u32 obj_id,
>> +			     u16 group_type,
>> +			     u64 group_member_id)
> 
> what's the point of making it int when none of the callers
> check the return type?
> 

It's an API, and return codes are available. I don't have a use for them
in this series but perhaps a future user will.


