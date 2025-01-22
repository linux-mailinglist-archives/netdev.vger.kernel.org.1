Return-Path: <netdev+bounces-160225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AF0A18E7B
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 10:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3201E165EDE
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 09:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518F984A3E;
	Wed, 22 Jan 2025 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d9j7ihzX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494EB1C4609;
	Wed, 22 Jan 2025 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737538679; cv=fail; b=iZ6R82O5C6gTXpVFIk2mla1wawEYh+bZVs+TCznhgOFCPFQCQd3Fhd1JL4ltWn1dCjcHzo/JomqQ7+JMRdvnValJyJlOeRXYNIs7tf3LwJifDwZmyni8YH0bmpDbOscoG4I4DBkKDpGbnQHwrddEUxgX0Wx9TjXK7KtonfcYEVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737538679; c=relaxed/simple;
	bh=B+WGxY5jl1jH/+lUZ5eTWGiOLMDTli9b9xdSwfaSkPI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YwGWMkPMiTK87Qk4C9CDgDIpj/0K132FQMENhcRqhNJAKrycQVwM5Y2FEqhI4CkBN2e/21GfK7DQtWoQlEhfDvkS4xGw9+LwDBnJkxpXAQ4OG4pxI4+vJAbnIF3ii9qTzoO8W2Ewl+CZM+uMUeBppdpe6rIKDUk+4mlyrdkyWFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d9j7ihzX; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRuTqF4ZMTItRyr9HlY0MsTqYVNDwPfEWvuiJZNx68IYW9wpisUqfrt87ilgII/UF9YaciykYMMgbjdDtjiA633XSIUYoOn11D7l341FxkjwDTpD8Yh2qMHyOtjYEEjBdpMso0WF3dd4fsUb7PV80sUzd+i4OmoKK+Edgze5L1wCCWutr1k+kfi3y/Lh9NLnBr1rg9qpwFABoVP/8Cjlt/raMCGawIhTRHjp8jFbbLVq3ZczSBScroGbpkp9nVPgVBBVZYoUgKx78mQ5fZ4qpGlWNYetZtVAtIcaKPDwF9JX360MlBtWh9ZSbxs3+fpBQva+8bjqMRcfkq2QBOs66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJDPjquXfWnX9BgTLfvIca77AQuGHpIBajdckh6K5fg=;
 b=lB6T8CXtTYNb87CzDg+qiO+m5XO8Ap3aa6ol8iSFmdSNVrP0oouEC6yRCENICkMAyNcxmnY0NhJYMQy5//lqA1W6qcZhj4K+E9qHG0fg0RjfwBXFhekOMYMlhqgqeok+McqnqcfGxDyqiRwU4O7vcmIbtZhyfuzR2u4mC1mext1RDP7QeADqFDntHjSPOmpHEv636oZXNdcBKNJVKfv3d8oVwTtpmLEQALDGVxUDbqxMO04w4GjaKzxK3TcdL2DiEFQ1NnrgDJ7ZAR5fq1GECXV77Mpc6Q/40ITpa8/CRlKr9JeDjq4YEfo28mncnX9i9tbXEOOuDirfjXOfxxKl/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJDPjquXfWnX9BgTLfvIca77AQuGHpIBajdckh6K5fg=;
 b=d9j7ihzXQG+SfQ5e/Y6r9G8EEGi7aX5SMzi5tCGJ+fJo4pCbb0KoXOG7auzmwXnJhJd6xTFW5OpcOIyK0lMcqNT6VxQ27gABxN6LQsqUlwX8I9Tv0pCnmcjpnw+k4/BQxgdrJaDhNhaXhIM2UevHE9m5tlR92K5mP47m3lnG9jU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 09:37:53 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.017; Wed, 22 Jan 2025
 09:37:53 +0000
Message-ID: <f355d9c5-35e1-7663-78bd-6b83613a83ee@amd.com>
Date: Wed, 22 Jan 2025 09:37:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 10/27] resource: harden resource_contains
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com, bhelgaas@google.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-11-alejandro.lucero-palau@amd.com>
 <678b0c0ca40ca_20fa29484@dwillia2-xfh.jf.intel.com.notmuch>
 <fe48e2e9-5a13-78fe-d8f6-6c3faeecebcc@amd.com>
 <09d6b529-57f3-290f-7e92-0291cdd461cc@amd.com>
 <a97f50df-5b0f-6ab5-80c6-531d4654c0b3@amd.com>
 <Z5AFvRl87OFtfF8-@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <Z5AFvRl87OFtfF8-@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::11) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: 7852799d-84c8-41b6-fdbe-08dd3ac8716b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXVBWG9LOWM2dDg0c3M2TElZU0g5bmorVEpKc2ZZNlVDcTc1OGpUREIrVXRn?=
 =?utf-8?B?b20zWnhtYzlCTFRaQzljUkFWaHovSWdHQ3h4OVFNSjhheGNKUUJrMGZHWURh?=
 =?utf-8?B?Rlc5KzJ1MlFJSzJMNm9jZWxYTEx6Qjk4RldoN1RZOUt4aW9hS2JrajBrK1ky?=
 =?utf-8?B?Nk01dkdwRzFpKzYzMnBxNmZzZ2pBRCtKTkxyajUvV0ZJNVRCUjIxZHB6MzJi?=
 =?utf-8?B?MVlIdldRby96a1YwWmszUzVJQ0RhOXVOS0NtYXFOQVpjQmJWaUtWN3hzSUZW?=
 =?utf-8?B?cmFHK3NnVUxsS3hRcmFoM0lQTFlIaWVTWDZWVVhQYjA2MnZJdUxBRlNHUWUv?=
 =?utf-8?B?VzhzeFI4bXpHOTgxVWZYNk92MjM3Z0JzeHJDUFNXaXhEUTF2TkdZTjhDYkNs?=
 =?utf-8?B?blBDam5Fdi9vQmNjSWs1MElqRjVTMG1NcE1RcW04SWZJL0h2WndsNVc3NVg3?=
 =?utf-8?B?QlRpQkw2VEs5dDJSWnFjaDAwT0JkTk9FUDJsQlpVT1RUa0xaa1hpNlZ1OUUx?=
 =?utf-8?B?OEtySm90REJnZnhPUkFHQWQrclEvQjJQTDVxdjBSYnN2NVFCeEh0UUV3SVhm?=
 =?utf-8?B?QmdwV09pUk5PMHNFVjgzM2NZRy80T2dnbFBqclVUVG54dXNGZ0x4ZjZaZVJp?=
 =?utf-8?B?cFJZZzhPaTVJUmhqRFRnQWhyZ1M3REhlZFhXT2VrRWRXNUdvWFBoZXpza05x?=
 =?utf-8?B?MzYwVTZSOWU3amZOcTBOTFNYN0lIM2RCK2hwZENNZStlblJGUXZ4Kzd0a0VM?=
 =?utf-8?B?dGtUQ1dlSU4rTVAwVUxwUTVpbGlDQm0wdEVnSmJZOFh6R1d1VExTaGNKTzBp?=
 =?utf-8?B?eDRuQ21mc2R1d1kvb0VnTFoxY3BLQTdSQTAxeU5YNm41RHBTK2NWcmR3ZEk5?=
 =?utf-8?B?emN0czJuRm5Ld1hOditsTUxiby9LeVh2MkhPUkZDTHNSbDUrNmk5bkFzeWdV?=
 =?utf-8?B?bXkzbHVIcWxud084VjJzaGw1cGFtanNvRDZsR1MrajFrOHhoUUd2YTBkSVlM?=
 =?utf-8?B?bC9uRkg0RzB1MXJCMVN1cVJsdnRBM3p4T1V4SFlHWEF5ZHg4aGdpakVmTFhG?=
 =?utf-8?B?WlpwK3AxRC9NNEYyUTNRcTZ4dHcxU3BneXNMa3NHNGlxVWZoWXZBeEl6OGZ6?=
 =?utf-8?B?eEJsVjNsRDVnVEtWRXJjamxUM0lvWWNpQ3pScmJPVE9yVXhTUElSa3FmSVlT?=
 =?utf-8?B?TktXMUIzSm05VGViMXJRWVVZTFZLV090dnpYK21VQWV0Q1hKNDI1Y21jVjg5?=
 =?utf-8?B?WjV5a3ltL2kveUhTOXFsbm96NXkxQis1UE9FWkxBRUlSeHlGcnNoNzN4QzVW?=
 =?utf-8?B?OFVBZEFzMmFWMDZDYTlTNnUrd1B1a3RHczBCZTdqbkNZcjJpUzhKazNnMkg5?=
 =?utf-8?B?cnFtS0JzdHRrdGlkRlR1OHJ4bHdwcmZXdHllQUJXZ0JDL3c0dmRUWmhKTEFY?=
 =?utf-8?B?bDJlSTk5b1BDdm8yWGhoZkFHdW96VnJiMEVGRXdudEpydzk3RTM5b3dWSkhi?=
 =?utf-8?B?Z3hRbE9QTldMZUxGRUpFam9ERUl1S3U0TUdsRTBsZUd2MytqNkFCUHVNRStz?=
 =?utf-8?B?RmZ2Q25udG9memVEYkZzWi9qVEhBTGpESWwrc1VOQnBJM25lVHNNUFhCMFJy?=
 =?utf-8?B?c05vZXBUc1U3NUxxQ2d3UkFkOW9xeTlYZEN6ZWEwZ1EwT3NDNDg3VTIxMGlY?=
 =?utf-8?B?REJVZVpZWjlPZVMxVk1hQTVxN1RmenFYRWlWMEVJaUUzd1VZdTBhZkZtM2pB?=
 =?utf-8?B?UUpuZW9JL1NveStsQzl3RXdLY2ZqTDIrdzRJTk0ySUxTckJZZHBKaDFhRTVq?=
 =?utf-8?B?TW5nL245QVplSzcycWdWZllUczFqNGE5NHBsR3cvUDVCTUZuSXNlZkVMY0NQ?=
 =?utf-8?Q?YejvNsu8wxFi/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MStNeDdxUWo4N0g1SzZxbU1lZ0MwclgyNkNNNjRsWlVHRGdSUStUdTJvUlI2?=
 =?utf-8?B?WXFIK3JpUFNZV2FEdVRIdm1lbEhFZ2Z2Z1pQNUNBMi9scDN0eVNZcTVhSlhK?=
 =?utf-8?B?UjlxZjRVRU01WWdhT0RvRWNjcE94K2dwclZQM3Q4c0ovWlJrczJPRndqSVV4?=
 =?utf-8?B?ZzNsTmJCTkJmZytRN1J4aHJQSDNIb2oyVmZBRGd1SEg3YUJ4UG91dWdnbjJP?=
 =?utf-8?B?VWdxY3ZLUks4VkJPaTBYY0VPd3I5cHRScVhjcTNnN3U5Z0xCbGJZUzRSM2tX?=
 =?utf-8?B?Q3orZnhBeFgzdHBCVEFWb09ESThEYmg0by8yT05XRThNQTYyZm9lOGgyTXU0?=
 =?utf-8?B?c0FESjEycEhqRk1HZ2YvanJMUFdlckJadEQ3QnU0Y05XdEtjd0FURVNlSnN2?=
 =?utf-8?B?dXFtN3pTZ0xneHhncE1mUnRPRmFTb1VXQjRSZTRqY2Z1MURtWnR1VnFhL2xk?=
 =?utf-8?B?b2hSSzEzQmlIczZiMG9keXZ4dFJUV25yRlNSaGN1ZEg4NjNHM0pPbEpKb1o2?=
 =?utf-8?B?TjRNTHNoVXFIdW8zVjh3cHhtamZxWklPUE5XdVJRRTdzSW5NM3ZkY2tOQS9F?=
 =?utf-8?B?R2hnSS94ejAweWNLTi94L3p1RERyRnNodHppTGR4eE9jMEY2dVBhR0o5ekZr?=
 =?utf-8?B?aGpSWkVUUDh6emN6VksxNWs2bWluK3V1UExJZjJBTkg2aFl6OTQyUGZMY040?=
 =?utf-8?B?WUM2YlBmK1ljQzVPdkcrVUt5WCtmMkFYbGlzZDlFMEMvcFR0MkxUNnBMSGVl?=
 =?utf-8?B?aXVFQUFKWktGTjMvTXZNVDVGVE9xQXBQNEF2Zm9XNjc0R0syUEJLT3hTLzA0?=
 =?utf-8?B?TUJWUEk4aGJ0UUhYaXB1WE5GZU1FRUE0T3BJdEQxOHBmZTROeUdMWjZ3THBt?=
 =?utf-8?B?Y0RyQVMxSUVxMHdhc2h3STFnUU1QVGFybHlheEVXZ3g3Q1hoc0YzemI5R2tX?=
 =?utf-8?B?VE1UWWdzdjBkeFA4Y1lqckk0V0pUbFhiR3l6QmlhbXRQSDdOOGZaczdqQnE4?=
 =?utf-8?B?YWpXQzZKM1EyeTNQWmlicHM0ZW5rVWpBdVRqcEx5MS9hNDliQzVEUDJSZ2RW?=
 =?utf-8?B?dWhtbWQwcmQ0UEZ4THFnVWRhYVpWdEd0di9QOFNOSldWV1dCM3l1eG9uUlBs?=
 =?utf-8?B?c0QyVWdDVysvR2xvQWtOZnJnOXg4YUlYNkpLZWloVGhoc2ZtdVo5dXpkdHFM?=
 =?utf-8?B?NzdkVDhtMGFId1RsejdFVm9RdHA4aXdIcmdpNTV3NEoxa2dreXI2ZXhpWUt4?=
 =?utf-8?B?bEVmcjhTcUhyck41M2pCaWtkKzZPL0pCTG04c0diV1MzY2NvTndKKzRFMTdt?=
 =?utf-8?B?ZDdZeDdCWjdGUlgyZ3VDblVvSnV1Wkt3THlEYVJpd1ZzRnpqU2kya1lBcTVk?=
 =?utf-8?B?N2puNHdURXBnUis5L0prTlg0dXIwcGdoSWkzRkhDYnUvNVl0dUMwcmhqYkVp?=
 =?utf-8?B?YW5UYWlwTU9zYk5sSndUR2xUeWY5V0tQekdYR1M0MitwM0dHTEEyUmpDUDBu?=
 =?utf-8?B?NW9BMng3dkQ0NkJiMkpLaG5oRGFwa3EvVkwzOXpDYlF6eUtXbnZOYUs5WWtG?=
 =?utf-8?B?YTFZTE5DNlNVUitxcHVUbU1Oc3hwZVQ1STJXdVlnVi9LQUQrSmREZG1NRUcv?=
 =?utf-8?B?WWFYbko1dkU2NGsybVhEaXFGWXpXTUVGeUJaUmsrVDR6U1hSaXpsS1RBT2pC?=
 =?utf-8?B?ZDVKTlJDZWVrZmUxbldienpsS3Bic05aNldDU1k2UHhGWUNIK0N1L3VUUFdZ?=
 =?utf-8?B?OGFMNkxOYjRDZS93MUIvK3lxVWpEVkpxOUYwNFFoOHVBRnYwTUVqOUZEVTlL?=
 =?utf-8?B?dUlMWTZSbEVtNVN5NjRMYTA2ZFlkNU9FOW1EYlIxYTIrWjF1RjF1SGw4V3FM?=
 =?utf-8?B?bWhLbElZV0dId2loUVRQa0NUaForS0dwa09TZ3h2OWQ1QktEb2UxMGpXZi9s?=
 =?utf-8?B?bVVOd1JkYThMYlV6OXVQaFlMT3htL0tpLzlnRDE0TnYydXFrMnd6Q0FkOEFS?=
 =?utf-8?B?TjE0NTYxVEJvbFhoOHJmQmgxeS9LZmhhakkvc2U0NUdRUThhbE1iZ05LWENG?=
 =?utf-8?B?YVBwRzV4VnRWbDFYeWlSQ3FqQlB3SFpGMUJOMXVKWTZDMlhYWU5vYzg0V21x?=
 =?utf-8?Q?XooDWCffxOCNF88e5xNZj2S/R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7852799d-84c8-41b6-fdbe-08dd3ac8716b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 09:37:52.9506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJQLB3g65C20ulKLFy33V1M2BFB7MqRq3peVKOtP4tGT58QDGfC/IxMfIx0oW1duPcyCWcllfOKBAzHcKFR6Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183


On 1/21/25 20:38, Alison Schofield wrote:
> On Mon, Jan 20, 2025 at 04:26:42PM +0000, Alejandro Lucero Palau wrote:
>> On 1/20/25 16:16, Alejandro Lucero Palau wrote:
>>> Adding Bjorn to the thread. Not sure if he just gets the email being in
>>> an Acked-by line.
>>>
>>>
>>> On 1/20/25 16:10, Alejandro Lucero Palau wrote:
>>>> On 1/18/25 02:03, Dan Williams wrote:
>>>>> alejandro.lucero-palau@ wrote:
>>>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>>>
>>>>>> While resource_contains checks for IORESOURCE_UNSET flag for the
>>>>>> resources given, if r1 was initialized with 0 size, the function
>>>>>> returns a false positive. This is so because resource start and
>>>>>> end fields are unsigned with end initialised to size - 1 by current
>>>>>> resource macros.
>>>>>>
>>>>>> Make the function to check for the resource size for both resources
>>>>>> since r2 with size 0 should not be considered as valid for
>>>>>> the function
>>>>>> purpose.
>>>>>>
>>>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>>>> Suggested-by: Alison Schofield <alison.schofield@intel.com>
>>>>>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>>>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>> ---
>>>>>>    include/linux/ioport.h | 2 ++
>>>>>>    1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>>>>>> index 5385349f0b8a..7ba31a222536 100644
>>>>>> --- a/include/linux/ioport.h
>>>>>> +++ b/include/linux/ioport.h
>>>>>> @@ -296,6 +296,8 @@ static inline unsigned long
>>>>>> resource_ext_type(const struct resource *res)
>>>>>>    /* True iff r1 completely contains r2 */
>>>>>>    static inline bool resource_contains(const struct resource
>>>>>> *r1, const struct resource *r2)
>>>>>>    {
>>>>>> +    if (!resource_size(r1) || !resource_size(r2))
>>>>>> +        return false;
>>>>> I just worry that some code paths expect the opposite, that it is ok to
>>>>> pass zero size resources and get a true result.
>>>>
>>>> That is an interesting point, I would say close to philosophic
>>>> arguments. I guess you mean the zero size resource being the one
>>>> that is contained inside the non-zero one, because the other option
>>>> is making my vision blurry. In fact, even that one makes me feel
>>>> trapped in a window-less room, in summer, with a bunch of
>>>> economists, I mean philosophers, and my phone without signal for
>>>> emergency calls.
>>>>
>> I forgot to make my strongest point :-). If someone assumes it is or it
>> should be true a zero-size resource is contained inside a non zero-size
>> resource, we do not need to call a function since it is always true
>> regardless of the non zero-size resource ... that headache is starting again
>> ...
>>
>>
> Maybe start using IORESOURCE_UNSET flag -
>
> Looking back on when we first discussed this -
> https://lore.kernel.org/linux-cxl/Zz-fVWhTOFG4Nek-@aschofie-mobl2.lan/
> where the thought was that checking for zero was helpful to all.
>
> If this path starts using the IORESOURCE_UNSET flag can it accomplish
> the same thing?  No need to touch resource_contains().
>
> Is that an option?


I think those are not mutually exclusive. The main reason for this 
change is hardening, in this particular case a resource 
definition/initialization apparently right, leading to this function 
returning something it should not. Even if you suggest the solution is 
hardening the resource definition/initialization, what I agree it is 
another thing to look at, I would leave this extra check here for 
correctness. This is assuming there is no case for what Dan mentioned 
and therefore auditing the callers being necessary.


> -- Alison
>
>
>
>>>> But maybe it is just  my lack of understanding and there exists a
>>>> good reason for this possibility.
>>>>
>>>>
>>>> Bjorn, I guess the ball is in your side ...
>>>>
>>>>> Did you audit existing callers?

