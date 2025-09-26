Return-Path: <netdev+bounces-226780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98353BA527D
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B55B325361
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACA92877F0;
	Fri, 26 Sep 2025 21:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iTAeg5fm"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013070.outbound.protection.outlook.com [40.93.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18AF2857C1
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758920672; cv=fail; b=AReuvEP6/7OEqRpwPfzqcorX+ng/QK5M90jruXkNrXcTYwLrWo/qKVgVRqq5fqHFeRYD12rqIm+r2G9cIpkqyLL1vWr7JooNcKQgARKvtoTQIzsBg2kK5dhY7DgiRqhly5pP0JHnRWyVFC3K0GlALOSNQCGbG0HixbxskWLgr4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758920672; c=relaxed/simple;
	bh=KTuANJOACnUTltmgA4eCpLGO9xzes74s9a0wgfoJQ1o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oaH3apuikO3h9k9BnMvh6uzpW2jZxjEujqZ4mUFX6osHCl5/Op/JPY0Oef4v+QG/TBQEhEoG/uFJOJOAT7zldMTP5m3DkWYlGNlGsfHS4Lz1lxbXU1mn0Ym/yml3u4mAYqwowOdQPvJ58MoTb23IlAVrOLnpUX0tPq4OZbzoAD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iTAeg5fm; arc=fail smtp.client-ip=40.93.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5Kp+ASktIBgYdkpNF6nG602edhB95jslV16zYe2LbQ/0LuMo/Run5JciHEHdWlXrYOq4zPzVKnRu7CmBFTeKjNLKxDgW0tLjkI0OVY6pQjf++LzHDYLC5exPLsaCAXP+Yj4oBPGsw+9X56AeCTGrpo6+2OpIdtkooBZsQjI+0uZibHCvhmHf1L0XbTX+ou2V6aGPJsAdVzRsfYYhUa09yKkI48qX4ZeGEP/lxvvM61t/9F2OAu/91kSLWB9oDTZHh0dQR1BwHdkhKeJeOdo8Odt/J+/xTsOT0GG5srLTMCkC30uBicSYMTZO9c2SEqp7qqeDgy+RyNJOHGWGkTNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIPoGco2dGmGDM1YTUd4z+V1hKTevq6N/jU0azWF0AY=;
 b=gzjxuv1UEXGUxzNZzbKPZyxaEM3r/iXV3vvGBH0syfuwsHaEnjWaw33tsf78VZocS/lUthHv54wrQP3b4EFzI4VGy2ih3SXDLRTiZGnH7JIzB46vzZlk+yCZkx1SwhBolRg9wfqCT8CRh6DXlaUp6F6uNqeBrFTl3WGh0puvVe0bdty/D2Eia/jiym4GJR0uSQbSAOmZf5bX4w9yxW8x7OlqPTwhcz5hZHfxAFUH2tHYidOgEUTUg9PfIcMlmMMXHQGYKc7yyARJRmcCdkivp/zFN40BRhkUX3PM+TeJP93dw8pTef/MGQhR/SYeWO2P1EzK2NMBpzpgA+0g3N3PRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIPoGco2dGmGDM1YTUd4z+V1hKTevq6N/jU0azWF0AY=;
 b=iTAeg5fm1qn0nLBy6MNDIW2Pe6j3tp1QETj0UJeAo4KKR3Erz674T21rZzcnaCps2AUjTpt3cqbc1FOXbp1O3bPkfBBx9d3sPlQ7njTJy0viILWb6lUp4wB1MLwpMxqnlbLsMoKkn613H3ktgdYcfAn/Jd+9CKofV22gbDuygcZawKZ8DbjTpJzYwyg19GFY0ZukHVXMBR7quCA0ER6u71aFx6uSCZbQPbFRM4eleQ09CAJGUgCWWwIyK4abvZ68wJLZgXdPoLTXvSoMw7H6zNC5NwtDQ3fD6ZUIoI0IXajpk1NO8rsrt32uekVYY0lAfgEk+YYv6RyNdG8TbpGDzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by IA1PR12MB8585.namprd12.prod.outlook.com (2603:10b6:208:451::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 21:04:20 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%4]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 21:04:20 +0000
Message-ID: <f464d2de-c577-42ec-b99f-4d45ffb2a8fa@nvidia.com>
Date: Fri, 26 Sep 2025 16:04:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 06/11] virtio_net: Implement layer 2 ethtool
 flow rules
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 alex.williamson@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 andrew+netdev@lunn.ch, edumazet@google.com
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-7-danielj@nvidia.com>
 <20250926134824.6d0dc043@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20250926134824.6d0dc043@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0001.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::14) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|IA1PR12MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dedee7f-6b86-4793-3177-08ddfd404300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTJsWVJPajQwNGhWZHY5b21aOUxEVFZjdXVHdmEwdkhIV0lvWXF3RVhQMG4y?=
 =?utf-8?B?ZUgxUWhjWEhrV3Rlak9jbk9MYmY5dkZlb1BycXBQazJGL2hEODNhMFQ3MDhK?=
 =?utf-8?B?d1JrQU1NTTRjTFFuelI4UFpNMmZiNzM2TC9sVVlwdmduRnB3cTVaTnpCWU9r?=
 =?utf-8?B?Mmx0MjBHTE5lY1BzVzArbjg3QWE3Y2gxTTl3ZlRqczVZSlZNdFFJejZIWFdZ?=
 =?utf-8?B?QXNQenBKbEtkcCtZcWRKMDVJT3lGL3VTN1RJYXR2bGdqaFFNQkJzT0daSXVH?=
 =?utf-8?B?VFFsUU5ldHlsMVdSQ0xQcVRmVjdBUjBkc05kazR1VmNwV0h1aTBBS29MbVZO?=
 =?utf-8?B?YXRZVWNoWEUva21oWXZOVGxuN2VSVDVzMHkzN2hMdzBySXFzZHlVTGhMazgw?=
 =?utf-8?B?T1BpZm5RcGtIcjZzTGcveFNML3BTS3A2eVZXTHVOR0lGaG01TkkyMTJQY2NG?=
 =?utf-8?B?cG1oek9TTmUwdFBkdk4reDVOcUdKbEErTW9wYnc2d25nTkhXaTdZWkxObzNQ?=
 =?utf-8?B?MXl5SFlna2V1TGNKUUtTVWJkVS90UlhITXVnSm44azJCaTRuMmt6Z1FZNlUw?=
 =?utf-8?B?Qk5FN1ZWQ3lYU1kvcUplcVQ1ZjZONmttTm1DV0tGWXFqZWRkclFjNHd1d3c4?=
 =?utf-8?B?VG15cWhleEk4aUQvZGJMZjJFRTVBWFdQbUNUTkoyckJLTGtKb1o2ckRIOVY3?=
 =?utf-8?B?L1BrTE9HeCtSMEhqVW1tQ0duRmpwZVB2VHJzaHp5MjlTYmR1WHIwdWswVzFC?=
 =?utf-8?B?Q0ZUUU44ME12VEFaUmlvMWFWWks1am9mLzFuUDgrZ1lkQjRELzg1cXkrYVZR?=
 =?utf-8?B?TUhKMVBVNzNvTE1RSXQxaGk0WjZEQUdoRUJLV245emRMSEdML080UTExWW45?=
 =?utf-8?B?VnArVWNwN0lldzBnalEwT3FicFl1NFZtdzZUQXVOS1RvZ0hsRldBWjJyUGkz?=
 =?utf-8?B?MERyY1VXU2ttQ3djUmE4ZCtNNTcyL3BmTzlUWkpHS2RZVGtSMTM5TmR0MXhN?=
 =?utf-8?B?dVN3NGVZVzJ1M3owVVdzNW5KWklGRzh4WGxaaXJKdXRBbGlYT0R3NjIvaldP?=
 =?utf-8?B?TTlYNzc0QkVWejZHdDhUeXhSMVV4WG9ITkxjQ0JtbFR4d3BGcUZ1czYyL1Fs?=
 =?utf-8?B?Qk5RakFTS09iMzhRUXVRL05PMFpVWUJUWGJHUHBNWHdzWHVBYzBtTWx0eUJv?=
 =?utf-8?B?bGU4MnZSUFBMdE11SFdnYkZYU25xQjlRVitjQUNueFI3a3JQSlU0dXMxZUU0?=
 =?utf-8?B?QktwZHNWNWcvSDM4bXEzRit6ald0dXZCSCs0WklCMkZDa1hOQ1poRzNVanVV?=
 =?utf-8?B?K2RCLzFOc1dteXBPZzEwamNPZ0V4SUo0WHptemU4K0lZVVpRQjdPRVN2blhE?=
 =?utf-8?B?MkQ0Ylg0TDdDTmNrYjZyNDdmdU5tMS93THkzdnYvRjREVitDMlJQTEVCLyta?=
 =?utf-8?B?eWZDN1RiLzRSK2YwOU5YemxBeEJVZnMvaFRjeHpJaDlwSW12UDlDVnVTb1JJ?=
 =?utf-8?B?VVlwVzNnOWw1eHJrZVM4TG1jWjN6VkphRjJmSFNEVFRLU0YrSWdsUzZTYnBC?=
 =?utf-8?B?UWQ2VEJyKzV1SmpCRVZ0MGZMRFQxOE9TS2crU0w0cERoNUlKNVFqRFpudkYr?=
 =?utf-8?B?WXJsTjllUUlZdWpvZEJUZFNTaEMvVTF2VVhIcmltVnJVRmFoVENVNDFpRGNv?=
 =?utf-8?B?RUY0ZGNMeXppcnZhTElDRE54amxxNUc0TS81dzlDRkMwc1IvOVFvdkN6a2pZ?=
 =?utf-8?B?bGJkKzluVWdWQmJnbFQwN2Jza3M1bWxDQWVLekZlajJJM002cWtudkZseFpo?=
 =?utf-8?B?Q0JnRVVRTUhHdmFrNDRLeWt2WjVyc09OMStia3NRU1lJYlErTUJJTmZHWWhu?=
 =?utf-8?B?R081OXhOcDV5cjNxVFFuMnJsWlJKQlJiMzJnY1l0eGgrWmFzR0pzcDRNdmpP?=
 =?utf-8?Q?b8AXNpbC1ojpnQrHEwkxBpjwWcagpV2t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T095d1J3NUZNRmx4M0lsa0Y2OW16VDhaaXoyelhlR01XaWVSbmkwNHZCb3Ey?=
 =?utf-8?B?YXpXVUZsNzZWTVNDbVVLTmltRVllM2J1dmZZSnFueXVVNVVNREU4bDR0bHMv?=
 =?utf-8?B?YlpmNWd2Q1JyYkpUSDBHS2wyMkZ6MzZqWDc3TG94NDlNNDNFaXRGS3ZZWHR5?=
 =?utf-8?B?c3p2b1JjWVh4UEVEODdQVXdkcjRjTElhd2todm11NlRZQ09jSnRSdVlkSmNy?=
 =?utf-8?B?NGhaaWFQWEJhWmduNEJzbzhqV0poRmtPcDZGSzhWNTRSNmZORWprUlBmYllw?=
 =?utf-8?B?cXhvamxmMlFrclJ2aXQzUHAyKzZwcHZmdXRNenJqU3BYVzdVM2hXOUNFbHBz?=
 =?utf-8?B?MThLNDhJVWZ0Y0p2V2pyNEQvc2tBYmNNYWJIOEtxZ1BCSVI1MXB3QzdjOGVo?=
 =?utf-8?B?Kzl3d090UW9oOW5QVURNTVFDNDl5aUZvZnRPaDI2WFJvdzVIQlZINWd2VU0x?=
 =?utf-8?B?eXROVHNDMXZsMXdTSjFMdGIxd1hYc2JUK0FGS2xwM01PenBEUVhOZzBjalRx?=
 =?utf-8?B?T0lvb3ZYRnVmY2djT2pWQmw4aDBueXJMK3ZKN2xqaU4zRVd4cWJ0NExIdmU0?=
 =?utf-8?B?UE1GZkk4VEI2V21rUDk0cGJZeHRoK3lyOHhkMFE2dGgrYURhbDRFcmQvakpG?=
 =?utf-8?B?N2VQQmNCc3NEa0ZpSlVVQmZEL2ZqTzBjUHNnS0p2MDRjclZ0RXNqb3JtMUJI?=
 =?utf-8?B?RUVPRFNyUTVXVUtrMS8rVGRWWHByMDdtMmorYTFxTjZzdDRFQ09JdlJLYzM3?=
 =?utf-8?B?c0RLSFhxZDdZQi81cDBTWmhZK0VDS2hiT3lHMThJa1NCRlJpYnd6WXdCR2RB?=
 =?utf-8?B?RGh0OWtxTmdvNEdvUTA4QUJ2Y1AvNlJBNURscFpTMlQ2UjMxM0xSMEl0WlNO?=
 =?utf-8?B?Qm8vMG9CdWtROGRzelFpdTNUaENPbFJjVVo0bDdQM1dMVUVoeXJnZjhOMUli?=
 =?utf-8?B?N05adnlmUEJkNHFSMGE0NnlTVGlqNVBhbUZrcHp6NUUrVWx6NDJ5WDJVSWl2?=
 =?utf-8?B?Q2dUNEVBQ2xDRUhYYy9CcENONlVXS1pGSDk4R2FGcXYvTjNyaUdjVGxOOHJE?=
 =?utf-8?B?SVRyWjZKRWE2aEhTSzVGT0FvYlB6S2xKL3g4Wnd3WVhVMkdjak1xb3o4VFVx?=
 =?utf-8?B?bXZxb0hlVkIyVUE2SzA4WjdoTysyTEhSRjhFd1JZQTg2Zy9vVFV4Snc5OGFj?=
 =?utf-8?B?SllEeHhlTDg2ai9mQ3BrSDJ6MCtocGFjVUw1bUxZcHVVWXFWdG1nNDFRUU9J?=
 =?utf-8?B?Mk5PMVVpYTdqT3NkQTJqWjB0U2liM3dRR3JzQkZDNWdvN0ZEdVhJeEI0N0ZT?=
 =?utf-8?B?R1UxQW8va1pNTE9UZURHOXJtYlA5S1RXMW9ZaXJIT3prUkRlKzAxMHc5VDhi?=
 =?utf-8?B?NytCV3doWE0zTHBFSndFU0xSQUJvelIrRlUvY3B6Zk1aY3ljY0sxUWhHdVdk?=
 =?utf-8?B?TVdhT1hic1ZDWWQvOERTa0JobmlraEljaDltdS9BR2NpdkZpMjZYaWpubWoy?=
 =?utf-8?B?Y1hpemZRVkF6bzBRM3d3UENNcXVVOExkL2lFcW5ZVzVSWjhZb2hUdkNmSkNS?=
 =?utf-8?B?NG1DTTVkaHVMRG9wN29FZWJDMDN1U05Ra051YUdnKzErN2o1amt2MTM0TENm?=
 =?utf-8?B?QVBMU0JPcUZ3aDFOMy9XSVU3L25oV0lJTVdvNWxiOUZ3c2NqVTZwRUJxNGlz?=
 =?utf-8?B?b1hjcS9sbzlIMGpBM21yTU91elNmY3lJWm5DSWcwZHBYK1BVMWt0RzdNb0FE?=
 =?utf-8?B?VGFHWjdkbzhGMGU1bWZjWmhUMTVCaWNzQUZGZEl1THcwb3Z2MUl3cnVtbi9G?=
 =?utf-8?B?b0xFNmoxVmNLdzY0ZDNWemE3M2huSU5ZMTBwZHJKUkhidkFsS0VtdTZDZEdh?=
 =?utf-8?B?QTM3NW9kcVBOOEJDTzRnR2R1M25GSkUvejRBemhwWWpWT2h1N2ZKZld2NFBa?=
 =?utf-8?B?dE5xRjFSakYyR0k1bVZNM1lSQzUwbUswVVZUdzhUTVhiSzJ1cTBIczYrSXh3?=
 =?utf-8?B?Tm1wenlZZ2d4YkwzSC9VSUNLNjNmcnVTcUY2VlErMU5ZSlVXOEpwTHo4aktv?=
 =?utf-8?B?SVAySTBubGkyUzIyd3hYcFRNU1lOR3pIMGFtYzVmOGRZT3lVaWZDeENXT0VX?=
 =?utf-8?Q?491r/eeeXFos5dX+k+y7iu+I1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dedee7f-6b86-4793-3177-08ddfd404300
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 21:04:20.2090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yizzQfQUnc0akRNRvwzBNeDGMzN0mrScrTEBDImx7+miZ4B9vg5WVIHU7eQkV78/NazuFGJZBWZd+rNpQsMOrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8585

On 9/26/25 3:48 PM, Jakub Kicinski wrote:
> On Tue, 23 Sep 2025 09:19:15 -0500 Daniel Jurgens wrote:
>> Filtering a flow requires a classifier to match the packets, and a rule
>> to filter on the matches.
>>
>> A classifier consists of one or more selectors. There is one selector
>> per header type. A selector must only use fields set in the selector
>> capabality. If partial matching is supported, the classifier mask for a
>> particular field can be a subset of the mask for that field in the
>> capability.
>>
>> The rule consists of a priority, an action and a key. The key is a byte
>> array containing headers corresponding to the selectors in the
>> classifier.
>>
>> This patch implements ethtool rules for ethernet headers.
> 
> What does the spec say about ordering of the rules?
> If the rules are not evaluated in an equivalent way to a linear
> walk / match please support location == RX_CLS_LOC_ANY only

It does support RX_CLS_LOC_ANY. Specifying a specific location is not
supported.


