Return-Path: <netdev+bounces-239211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C682EC659B1
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 18:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 749E228A3E
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EB53019DA;
	Mon, 17 Nov 2025 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JdidGYbK"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010065.outbound.protection.outlook.com [52.101.193.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AAC23C8C7
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401817; cv=fail; b=I37uEnx/b1S0QIZp5xehzIZUkLEwmMwZSmJTVRvRen2Z44gScn6I2dd4HKKLFCx/1nTS4lcL8qH04wau0QyRViRfpOZY1NF5/rGVB357BdAzyIVTUHjrShcc+PxsIaIbsARzrwKTuTA3r/HPr0UCgjSROF44JuW6amE90gReYdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401817; c=relaxed/simple;
	bh=7pOCHgfkSoZ4uLU2qWsM7Gr3fnisTiVM1H1TIYtLh6A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nuPY04ACfXlaM7UnJ1l2VKCZ6pSOhjU5UTd/Gkz0f5kJIqXRrfke4Nip0lF7W6FqxY+Hu1nOhb1s1Rplbjrtz4zv4ofRK/oWnFOlFnHCKUR9iUS7u5GMvGWoqv2JAArpCyqX6mOqjuzisZq9cU9D4Vgo+8b0fIPh6VWHYGudOXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JdidGYbK; arc=fail smtp.client-ip=52.101.193.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuWWe2kgI9iBNYplNl1WKj9GOybLFRDklH4gQoHZK+OnLU+5iKuM5bIA+qnzrKQw0dHQO+Uce4EtqAqhHqQ7jfN46u0pjyfmQS6WR82XGo97oNxrY1rlVqbIwaVSzdayavoaxDDkvbVVADuU4DAwTBzvLdD7yVkDa75N7+ri0c/ukApxQDq+3XMREXUZnQNQ0fFk9FUTZur5owFeU2TZvfgotyE9/Ozcaxe3lGo74eWgFg2RgYKfu+a6fZvjRcNKlWOHItFlhsw9W+7ma6ceZEGxJoSmq5Z+aMcsufQ2kd9jphfrDOIw2eo69tMpMymC/UZHmrWy8HekyPsJ6er8CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtiwfbj3f8p9tx3QKT4WN6nxchTA5RaV1lXPzzzKh+c=;
 b=x7k5+jNKFA57PcY+Dnq14mY2SHjUZsK0Dwf5nAHndXtevZF8EZ8fbP5YeVnLlmGAOJCoMV9Z0/Zyrpqi/4QFLXwPH5RuQ2lfruuNlb+Z67ev5Nao+DMQ7pFkZMk529fMZG8B2jQSG3FNth+uVbOd7L4ZpYXEJWXN6/1NTPM9upd31+y4zSzk/JrWitepeDBIZ4r4fPn/CEz35RlrdByS8J9VbL9ql7f1r4UstzGTx6Ms9KZMCfked86sDH0auf8WLLjS+Xz2ptF7pWBezgFxKYdNf3cRiOxqMLks7GvcC02Ku1in9rOr8ts6tSDox/3nlcE1FCfpyvuc5FJNJMyILw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtiwfbj3f8p9tx3QKT4WN6nxchTA5RaV1lXPzzzKh+c=;
 b=JdidGYbKzpSdNuyAurxXYIx488y5esADOGcAUNRXU0XjDDQ9LDj/Avb2O44NP56PnUiC+kiZVeSIl4N/FaBzfuFcE9OGZCD0BakdIn7Yu+37AwhOXfCLWZx8w5WXjq6FlTfZKs/J0ZYALs7QWTsMVazgMmlWR21riULaOrpP9lJ7V2xBbC67WlDbdxWpUyhH0UH084S8zs1DB1sKpKBrm6gv0QJcpSNw0zMLGs/CE0spCqzfHanIgB3k5rns1lwjWTlcKjzuBV/xiKWmZyshUvjTf+1cg34JTmFhowBHZIhXCQA+cFj8EEg2rK31n88M+U4t3+oYi28NNGiuxF4whA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by BL1PR12MB5994.namprd12.prod.outlook.com (2603:10b6:208:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Mon, 17 Nov
 2025 17:49:59 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 17:49:57 +0000
Message-ID: <0483aaba-0b93-41d7-bf09-5430b5520395@nvidia.com>
Date: Mon, 17 Nov 2025 11:49:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 05/12] virtio_net: Query and set flow filter
 caps
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca,
 kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251112193435.2096-2-danielj@nvidia.com>
 <20251112193435.2096-6-danielj@nvidia.com>
 <aRtYgplAuUnCxj2U@horms.kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <aRtYgplAuUnCxj2U@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR21CA0024.namprd21.prod.outlook.com
 (2603:10b6:5:174::34) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|BL1PR12MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: d74bc2ee-bdfd-4fd3-8e83-08de2601b8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWszZHhOSE53QWNJMWZJbFhCRVhqRXppWGplNCtIUHlydXJXZmlJd0pORmtt?=
 =?utf-8?B?Q2R1d2lyRTBjZ0FlSUNhMnNrbkpQZzdtRkdmeGYxTnpyZ0NJSmM1aS8xR01n?=
 =?utf-8?B?S3JLNzE4azdXVW9PRG8rQXg2cjZlalBvMDAyK2hjcXMxYU1IZFIvam4vWmt0?=
 =?utf-8?B?Sk4xK21pTUVnRTRJT2h1dVVwLzBkUkt6d0pKU0s5OFJ4YUx6Z21Cc09nLzlH?=
 =?utf-8?B?ek5KalF5dFduUDJ0cmIweVlPaUsrU1ZCdnJodXB5empWVE5GRThzNmJSMDFC?=
 =?utf-8?B?NWlBWjkyeTRFWTZtclFRVWd2OFBNOHlmMnlvV2c1NlYySzhlZ1NVT00rcHBH?=
 =?utf-8?B?dnJtUGZMMXlSVC9hV0cvNUV4aTBmQ3RWUVowMkQ3dFdHWlZLY2ptcWRIK3Iy?=
 =?utf-8?B?RUwvOVgvSlFKSjR0WFBTSk53c2RjWDh5YnEwbXU3TW9RUnAzY2hDbHZNNzNn?=
 =?utf-8?B?c0hSTkdyNzVPb2xleFJ5Q3o2UitXS3BuNXBKeFR5OXNZSzdudWtRc2N4TUxG?=
 =?utf-8?B?RllLOUlvTjZrcDFNSGZsZUhSQUQvRDlUdStCRERnNzYzb0RnMWNpZFBERmhU?=
 =?utf-8?B?R2w3eG5JWlo1NDFFTVQrK2pJNVhFUXZDai9HQzZjZ0tmMkQ3V3NrL0ZFbWhw?=
 =?utf-8?B?VFJtKzNDelg3cU45cWx0QXJsM2tWMkl4Vm9CZWRCbExqbm9LNzg3OVNPbElL?=
 =?utf-8?B?ZEljVWdJRDBkNms4QytQdEtTYVp3ZVFpc2hselR3VlB1clhVeTFGSFArc0Rt?=
 =?utf-8?B?NzU4VENsZFdjSjF0NFJBY3hkcHVUTFo2aHlNS0dQamJJdkJLMXdnMms3ZExq?=
 =?utf-8?B?eElHbVRJZUhiSU9Ed0VURFhOMStQREl6Q3NVNVRteW8xTVhrb3ZuRmdUVFVp?=
 =?utf-8?B?Ky9uaDZ2amtPc0pBK0xEYzBWUFYwVE1EeUpuNjVKVmNiUXB6Ym9IYnlFWkZ0?=
 =?utf-8?B?RFNFS2NFdnJTY0wvS2ZuRUh0T1ZudWg1bDYrNVRYbTlVdUpUMEpERXhBYkwz?=
 =?utf-8?B?ZFNQUkZGU1ZncHhiSU82SmZObjQ4a0ZzYlVKVVlLQkN4bkRuKytGY2dSeUNB?=
 =?utf-8?B?OFluMkRWTHFlYjhTaHUyZ1R1UW1RT0UwRDQ0TVAycXV6NFJBSThSQ2dSemdB?=
 =?utf-8?B?a0hYcU1OUUxjWlQzRGRvSjZZUXFyMlNZVGhBZ2FvYzMxcFY0NTRNUk94bzM0?=
 =?utf-8?B?U0dRQnJrMmVIbktMdUNDd2NxeFk5M2diZWQxbDh0djJveG9jN2ZBTEwrK21r?=
 =?utf-8?B?cGRCQzk4MXQ4R1dlOVlPYVhhRmpwOHNHRGlTcVBzaEkwNmNZZmNES0ljODI0?=
 =?utf-8?B?S2pOMmJjVFFIbmJVQnp4em9Ya2Y1RWFLZGx4dlRjUklhUFZmNEF3bTYyWVVm?=
 =?utf-8?B?bXF6cGl3VzM4SVRWOEdmbTdlMzJjaC9PcFBZTGRQUGxkT3I1dkxUKzlpMjM3?=
 =?utf-8?B?VDFVd2xpSkJOUHhFTGlFZE1MR3BCM0pJUlF2YXlDOHcxdGgyQW0vSGhBb1A0?=
 =?utf-8?B?ZmRLMUNaZUduSXBsbDB4dXBqejAzdmtIczdvcUJhRFVMNTJmMW4rNmQxRHBD?=
 =?utf-8?B?WWFKUjV3ZVdKdEUwclhxYTl0UWhrVVVhUWltWWlzS3BlYUhTdGJLR3hMOEZu?=
 =?utf-8?B?dnhOTnZiVktwbGU4TUJRZ05PeTMvanhMZzJrUTVIcmdIcUd1NGJuSkUwOXNF?=
 =?utf-8?B?VVdvTzhTY1IzWlhzaGxtOTNrbVZQdWcrUlo3SHFlSFhOejdMMmpOYUNTcDNj?=
 =?utf-8?B?NlJ6UTFieEIzTW1iVGdhdWFhbEhnQ2VLYVp3Y3FGMTArcVNKMFBlT3JFL3c5?=
 =?utf-8?B?b1BBZ2E1bGZFbHhMaC8xK293VzhhRW9oYzB4ckJTNkwzREJVc2VLMjk1N1RK?=
 =?utf-8?B?YkRVZWVMZS9DQ0dieTVlMDQxRkR3bEV2NVh0Tldxcll1eEtNK2JmNTNIVUts?=
 =?utf-8?B?ZXcrWnp1UHlRR2NTcmxiN1psQ25pWU01Uk1LOFVVTVoyL3M1L1h0cDVLbjhU?=
 =?utf-8?B?NTFheDY4dHZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUdUeVIxbURYSnhENXZJS0pHNkh5YjgxL0FDZzh6Yk10SWtpVzI3T2JNODJK?=
 =?utf-8?B?eUFjM3VtUXJpalE5YkZQM0JpNUkxUlRrd2c2UUdkNlhJVmpWTTBvL1hxZm5G?=
 =?utf-8?B?eUgrQk5kQzFYWDVVQXJFeUVEYVpZd3R5dlRQVi9Tamp6WHlqUzA5RVBSU1lo?=
 =?utf-8?B?VENRUGY0OElUNjR0bzVxSG93Vlp4Z3RSOWRDUkN5N1JtY1pBMWhFRUVvcHZH?=
 =?utf-8?B?aG15S1lxb0dNK1BxajUxTVkxaUxzVlBoZFdaeWl4UWpUWkdFb1RaUkNaYmFH?=
 =?utf-8?B?OWNuTEZubzh5SjQwN0tqQUR3V2c2M3dlV3JDbWR4NG1Jb1VGbGlOd3U0Rm92?=
 =?utf-8?B?bTRxUUVPeDZUMDYyeUwrUHQwUXR3VkErZUF5b042SFgyRXZLSDJWNWpweUpD?=
 =?utf-8?B?MlB4UE00Q1lTLzBqM2tJZ0p6OFZrOTl1SUwzUnRheGoyNFdYQzR3VXBFUHpO?=
 =?utf-8?B?aXRac0VtQnd3aS9mMmltVTk3SGE0Q211emwrMHh0YUJsMlhSS0J3UzRRbGdB?=
 =?utf-8?B?bDNQeDJLZWJROWdzQXpKUEFZb2Ryc0N0UDZkS1BYYmRnb1lFVWR4c3ZCd29h?=
 =?utf-8?B?M05tSzZ2Y01OZ1lUZVN3Vk0zcEg1K0M4a2lwWnQ1V1N3Z040M21TMkQrbmZN?=
 =?utf-8?B?Q1hRWmR0aUsxQVh4K1RuWFpaZW1jbVFlRzl2a09xMVdMSnphQlFLSE5hZUVP?=
 =?utf-8?B?UkxQRkZCZHZuSEhnYjUvVnZKaVlxZ2ZRbThZNUREdXFUbk1ZSkQxUHlTZmhJ?=
 =?utf-8?B?M1lINDFaYlhpMlNYaWZSQXdVcUVmeXByZzB6b2xXYm81bHdxd2k1OTBOa3BJ?=
 =?utf-8?B?eXEza0s5YXJzL2JVa0xNTm80d3QreU85bkRMWkhwM0RrOFNkS1pRb2U2T2VJ?=
 =?utf-8?B?RXR6L1lIKy9pYmRiSG1mZ3ROTmpJL1dSRUVsTHFRUDEvaWpXVmp4L2FBQVVz?=
 =?utf-8?B?OXkwUVpnbFJObFZrN0dZNTgzbFB0UVgyUUhhVDhuTHlWTXhJUTZtV2k4MHFo?=
 =?utf-8?B?b01iWm53NnVPQWtWWC9GQUk5VmtXclN5NGNabW9YdE55L3VkSTlJK2hGNnpO?=
 =?utf-8?B?blBiT2YyazBMMVJEWTFSRUxRMFIvckVqOFhkRktFWG01UWZ5RXlGRGdYRDhS?=
 =?utf-8?B?THA1Mnl4K2R4ZW5vbENzb1VCYjRhM0t5ZjRZaUpXbXBHRGoyWUgySmNHaEhY?=
 =?utf-8?B?MmVka2lCS3lram5yeG5yUUwwWC9tZ3RtQjZsczdYMUFiOFpvLzV0M3RhR1F5?=
 =?utf-8?B?RVFiT3ZFcXdaQzFNK3M4T3RudVFGc0hLb0E3M2t0NC9ia0Y2K0p1dVRsK3Rn?=
 =?utf-8?B?djhudWxScFd5cjZFYkQ3T2ZuZkpITGtJbXp0NFJ6Mkg1RGpuQTdiRkJ6cklu?=
 =?utf-8?B?eEY1ellZTDQ5Y3dFd2s2bTRwVUJDMkorSklJZVBsT1pIWitWYTM5QWl5Vy9Q?=
 =?utf-8?B?V0V2RWpZSVo1YlUrNTZidTRFdzdXM2hmVUg1OXZEN1M4NFVsL21HcnY0Wk90?=
 =?utf-8?B?cUkwcGV1Z1F2ZUN6NTR4Z1hIbXdmY1hyOFJ5a1hjUVZsV1k5a3dmMjZEenla?=
 =?utf-8?B?RzU3VDNkY3Byb2EyU2VEWUt0bStGQ3RuRXNrV0NMdG9GS2E0L3dYTFRreklZ?=
 =?utf-8?B?VVFtdU5RamQ2OTFIL3lBTUJ6dXJLNDhFZ2FJUDBWMElTaWxoOUVEQWN0MzlX?=
 =?utf-8?B?a0tmRzhkYUw1YWFPMkUwaXNiM2xEOVpYaGVhRkQzQU1Vck1QZWJhRGhOU1g1?=
 =?utf-8?B?Ri9UcEZyR1NNMU4yeVR5aU9VNGtaQklEODdpMlJvTW9Ra1A4M05LS3liWW5j?=
 =?utf-8?B?RjgzbXNzdW5IM2VROWM5UE5iVE5MS2lqQUt5bk5FUGlDb3hiamVSNTl4dGt4?=
 =?utf-8?B?aXFmbXc5dHNzT3Y2dEt6QUVGZE9NM0RWMlhwRDJ4K01uS2RKenVyTjBSam9Q?=
 =?utf-8?B?MisyT2tVYnNwQTJ6dHdZN0pzOXFQK2gvZFNGclFrTEl0Vk1VblRubWpMTUlo?=
 =?utf-8?B?WE9KYzRSTUI5bExhOHFUQllGc0hTc0Q2ZXp5WklPZWEySFN3MTUzUXFTNkR5?=
 =?utf-8?B?UzE3NkFjdldTenVWOGxNdE5BT09PRTJzTUxlRmMrRnJJZDlwWW94aUdrOUhW?=
 =?utf-8?Q?SDvyFe2Rai+NfU77WyD9VVszD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74bc2ee-bdfd-4fd3-8e83-08de2601b8c7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 17:49:57.1943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yubJ1gRKXLlHQD720qZoR46N+mdgAK0w5vc/sZlWqTyfilBEUZnLBi4oBPLkGyU32P/y02bGQg/fy2xIOoN0aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5994

On 11/17/25 11:16 AM, Simon Horman wrote:
> On Wed, Nov 12, 2025 at 01:34:28PM -0600, Daniel Jurgens wrote:
> 
> ...
> 
>> +static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>> +{
>> +	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
>> +			      sizeof(struct virtio_net_ff_selector) *
>> +			      VIRTIO_NET_FF_MASK_TYPE_MAX;
>> +	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
>> +	struct virtio_net_ff_selector *sel;
>> +	size_t real_ff_mask_size;
>> +	int err;
>> +	int i;
>> +
>> +	if (!vdev->config->admin_cmd_exec)
>> +		return -EOPNOTSUPP;
>> +
>> +	cap_id_list = kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
>> +	if (!cap_id_list)
>> +		return -ENOMEM;
>> +
>> +	err = virtio_admin_cap_id_list_query(vdev, cap_id_list);
>> +	if (err)
>> +		goto err_cap_list;
>> +
>> +	if (!(VIRTIO_CAP_IN_LIST(cap_id_list,
>> +				 VIRTIO_NET_FF_RESOURCE_CAP) &&
>> +	      VIRTIO_CAP_IN_LIST(cap_id_list,
>> +				 VIRTIO_NET_FF_SELECTOR_CAP) &&
>> +	      VIRTIO_CAP_IN_LIST(cap_id_list,
>> +				 VIRTIO_NET_FF_ACTION_CAP))) {
>> +		err = -EOPNOTSUPP;
>> +		goto err_cap_list;
>> +	}
>> +
>> +	ff->ff_caps = kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
>> +	if (!ff->ff_caps) {
>> +		err = -ENOMEM;
>> +		goto err_cap_list;
>> +	}
>> +
>> +	err = virtio_admin_cap_get(vdev,
>> +				   VIRTIO_NET_FF_RESOURCE_CAP,
>> +				   ff->ff_caps,
>> +				   sizeof(*ff->ff_caps));
>> +
>> +	if (err)
>> +		goto err_ff;
>> +
>> +	/* VIRTIO_NET_FF_MASK_TYPE start at 1 */
>> +	for (i = 1; i <= VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
>> +		ff_mask_size += get_mask_size(i);
>> +
>> +	ff->ff_mask = kzalloc(ff_mask_size, GFP_KERNEL);
>> +	if (!ff->ff_mask) {
>> +		err = -ENOMEM;
>> +		goto err_ff;
>> +	}
>> +
>> +	err = virtio_admin_cap_get(vdev,
>> +				   VIRTIO_NET_FF_SELECTOR_CAP,
>> +				   ff->ff_mask,
>> +				   ff_mask_size);
>> +
>> +	if (err)
>> +		goto err_ff_mask;
>> +
>> +	ff->ff_actions = kzalloc(sizeof(*ff->ff_actions) +
>> +					VIRTIO_NET_FF_ACTION_MAX,
>> +					GFP_KERNEL);
>> +	if (!ff->ff_actions) {
>> +		err = -ENOMEM;
>> +		goto err_ff_mask;
>> +	}
>> +
>> +	err = virtio_admin_cap_get(vdev,
>> +				   VIRTIO_NET_FF_ACTION_CAP,
>> +				   ff->ff_actions,
>> +				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
>> +
>> +	if (err)
>> +		goto err_ff_action;
>> +
>> +	err = virtio_admin_cap_set(vdev,
>> +				   VIRTIO_NET_FF_RESOURCE_CAP,
>> +				   ff->ff_caps,
>> +				   sizeof(*ff->ff_caps));
>> +	if (err)
>> +		goto err_ff_action;
>> +
>> +	real_ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
>> +	sel = (void *)&ff->ff_mask->selectors[0];
>> +
>> +	for (i = 0; i < ff->ff_mask->count; i++) {
>> +		if (sel->length > MAX_SEL_LEN) {
>> +			err = -EINVAL;
>> +			goto err_ff_action;
>> +		}
>> +		real_ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
>> +		sel = (void *)sel + sizeof(*sel) + sel->length;
>> +	}
> 
> Hi Daniel,
> 
> I'm not sure that the bounds checking in the loop above is adequate.
> For example, if ff->ff_mask->count is larger than expected.
> Or sel->length returns MAX_SEL_LEN each time then it seems
> than sel could overrun the space allocated for ff->ff_mask.
> 
> Flagged by Claude Code with https://github.com/masoncl/review-prompts/
> 

I can also bound the loop by VIRTIO_NET_FF_MASK_TYPE_MAX. I'll also
address your comments about classifier and rules limits on patch 7 here,
by checking the rules and classifier limits are > 0.

I'll wait to push a new version until I hear back from Michael about the
threading comment he made on the cover letter.


