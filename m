Return-Path: <netdev+bounces-287461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAhKJqAuBGo/FAIAu9opvQ
	(envelope-from <netdev+bounces-287461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:56:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 129DD52F221
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7D7B3007887
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 07:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71383D45C3;
	Wed, 13 May 2026 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZwOwX42f"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A28E3672B5
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658846; cv=fail; b=ap77MX6onH5wdBXdRJ/Y2t6IZeVuh1UmnkrnTXNf41hkCy8aIu2uXKGt0Yw0iyYmGh/tZjNbPiSbChsBbakYjaj+nbCdttbhNEjXJw1+zcaf7LnKAuOTCD+UAOl6WazIVbzKM6KLkHmv9qkCze5//BBQzakKHo2Kb1OhzTsO6xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658846; c=relaxed/simple;
	bh=IEerp2Y0SwqpgWJHRP9NL2jAKH6UWS7Hcqa8DMZ7gu8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ej4ljWI8DrJPQdcxoe62pmqfcy5uFIk3AnOXqXa6odx5F3cHMS2JguOP5UpAA1Q66eEVAz2eIdQCb1nuAxOYXcng7ekqSc7H24QDeAXoBwElq2i/7nB0ir/q1o57A2YbZyHFdz5RTXCUaTvaE8SBnZl2rWFvcSM53Tmzp/C0Jew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZwOwX42f; arc=fail smtp.client-ip=52.101.56.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8ZMrB+MczjLFAPT+TcH6IgCT9gPT2e0H1BRDJJTqzDK037ZSWHWT7dw52zUJO0/GWLXf8308X9R/qFMx1TEGS5New4GhfTpG2zzbvDLHNLS85up3dpLaAXsrx7exeLHgtj3p7fCUWyLKqUFsGKFxoT2XDfHpoiVWqWnB9YjhR5ZgTx8dPPLr3E/J7tllTIGyBM2TlaB/n16eKtJMqu8DnlbUxrYF4vX9NxBkjyKwk2HKugwXnjg6sWaT1UzPLVUCSqRqzstGxLxYqzmLX3OgvWHdES2oCtbigQCES3DkTyEZHpfHikIEzGdVDwI14x3eoaWw+pMOHvAkF95JxDnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7b8qED0BQer3S/AQNZSkF6x0z8G2/qfeE2OXz0b1Ls=;
 b=eeFXR6hduBVmvexFult8v0vMZBIsB+ZepwmnPA/wpgEcROF8PwSSBE5IEJ6m86k2hlT1wdw0PFfJZRk/g2DVdJHgeIEo9+mpVKr3+ZHyHzMFVK7lFjat5NOQ0ughJ5AY4u5GYDgL9OkhEbC1J845C1yFtoCUeb1qD+YeQhRIIk1vkM9+ZRpzse1oedIt/mrEQIZ/RZHMoKabU4CGSOyCuqmtDGRZA6YgOYbBLfn/UxKkEhUIS9dOcWOB3larFJDoIRisD2nYQOtGJmWOuhmvC6cPppJBY+1NDr/+s5193zoo0jFScUr1nbY2Xx/xqUAPoVAGurTA0cMZYuZDMTa9yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7b8qED0BQer3S/AQNZSkF6x0z8G2/qfeE2OXz0b1Ls=;
 b=ZwOwX42f1p78aqG7bD6d2hMd0u3tRm/6PK3/Zk+WkpQLiQFjc7Q9VlxtoKnkYUun/ZTMTogMeRviQe1q7gowSVuZZ0+hFVRpDEHot2JQmRHDW3hOD1en1GY7HbIuLz52NSBmcK1CeECAnezl4vOocKtFxHXouAvwhGKHIY562bNyGi2mCPLOHT+t9+IDULByXPadev9DOSyVNVtELf3//vWZVhnnkDSA3h4W4yluQWFdug+jlsd4yiQuvwFkyPRtIj7MgVcKqL+5Mi7H+IZFkrnftrkRtpg89oU21Ivv6CU28c3j9CSbUU8HbhwvYZ78F2goy6QFfP+Co0uYx0MhpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by IA0PR12MB8861.namprd12.prod.outlook.com (2603:10b6:208:487::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 07:54:01 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 07:54:01 +0000
Message-ID: <6bd88b37-4aeb-4783-8b92-62b38fe8603d@nvidia.com>
Date: Wed, 13 May 2026 10:53:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 02/12] udp: gso: Simplify handling length in
 GSO_PARTIAL
To: Alice Mikityanska <alice.kernel@fastmail.im>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Xin Long <lucien.xin@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 Alice Mikityanska <alice@isovalent.com>
References: <20260512165648.386518-1-alice.kernel@fastmail.im>
 <20260512165648.386518-3-alice.kernel@fastmail.im>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260512165648.386518-3-alice.kernel@fastmail.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To DM4PR12MB5248.namprd12.prod.outlook.com
 (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|IA0PR12MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: 31719d50-dec2-453b-32fc-08deb0c4cbe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	vUx0mydU/2xYcRoczE2wFGBPk5fsjzN+YUTxuGpPcwf0ZmVoYYTVoGIxviA9FK60fg5Rx+TSAMlpBUJ/2gEKn8c1HzbqVhGIP6yOVQUbKK3NzHZRQxjR8N6Gm/YVvzd6/r63DoN7kE68kTpaQ3ktqNxHQT5PUes5falWxRaGDIESY3Iw3uMXS2VS7xeermKcbLrjV3GJ0AmXZmtFEchell4NSATNBi8WhyZGjfsONjPWk8AWr0s7XhTP+IJ9G7kHD8dHgwtjWYrarVaWDMgHq9/WnYa+D5LfQ838XV6RwQpRY7SAogc4gtKwwMVYhDyIRKrz5cc+nAm64l0hapbLkPgGo5+j7CzftD3gYRlRUEnHNLj6PsGY7k9dCn25gEnR1pF4G0M9zG6xl/j822EozQTQNsoDYnWRRCnQRgo6Ro9uI47ZMF3uo969Iwe+gdbbz4MlTduurPqjQOBUgNlAzrz8sA2brDMkKhyTginOl+EN+H+Y37OJ7MhlrbaSmgLjUn5YOcM/JhUKwIRJ0z9jTY4AUBla8xaqKvxc0F5fDdU5HeJCKmsSDlLIbi7oZA/meYuWKNhas8jSy8UdBLVKyTS3XgHRIDQW5QUyJuqTlpSsWhkEykX1SFuc6IJEi/s2NNYC9PCbbxEcuIFe9RDqkyVJOFwt7pnV2Cu+cDTsUTwpDw+i39/aDQ2UL9ZeDmjeKP59vLiWTVVhuTNJY6oWWQaDc9nktqX71H/F6q3Wogv5XMb1KVLvfp2ai6oYKqfu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXlTYUN4QjJkdnlNamQyYkQ3cEFteDhvMFJlcUlMTVhJRnV6ZDkrVG5Hb0NI?=
 =?utf-8?B?clB6MlFwZ1BWUzV6RWJiRS9KMVhkd04xbUs5cGptN0dqRC9PNWFPYnJONUZi?=
 =?utf-8?B?b3VDN1ZXWm5BeTE3VWJNZE5RRy9Hc0ZZcGMrQ1lPbk1Ibm5NMUdYU29iRFh4?=
 =?utf-8?B?bXlJYjkrTHpLT0NGbWdsZzRxc1lSc0NCRTJxbmEwM1Q4TEUwN2UyZ1RjTzVI?=
 =?utf-8?B?b0ZPNjFYdTl5bTlLSzNXL05UOExtSXI5SVpGdDdacFZpM3B0SGhZWks4amli?=
 =?utf-8?B?TlFZbE5XUmJjbEs2NDJxQnFpRkNqTHJNcW9WU0gzSjBIT2tXVllVc0RHcEV1?=
 =?utf-8?B?Y3ZxRGU1Zkp1SHJEKzhQcVIvNncwTWh2TEVFbW9yUnJkYlB6S2xmZW82TEVW?=
 =?utf-8?B?anJGVkZpOTgrWUVIMnpYWDc1MzNCVXdJaWkvT1VDVDJ5YW1OZGVJL3dRWi9Y?=
 =?utf-8?B?dVZiMm4ySTljS1MwT0VIbDBuZ0E0Vk11dGNnUUNqdXpvSmpQSGtkT0g1d0g1?=
 =?utf-8?B?TUhNR2ZrQTFVWEtLM3R2Q1Y4M042NkFyOXh6Qkp1RmY3V205SGpUOURIRHdZ?=
 =?utf-8?B?UnE1WTBQMjU1eGg4Y256TlZJZ0hDMU1rYkZNVm54TW5xZXhxQm1qdWw1YkdP?=
 =?utf-8?B?MUJFVk1weG1lbVY4VGpDZUVpQVRIekZuVndxTWdEQlBhcHFxci9EeTkwSGtV?=
 =?utf-8?B?TE5UaWlnSU80cFlveUIrbW1nUkpoQS9JMTNUVlc2NUI0a1VLeVBFcHlRVStQ?=
 =?utf-8?B?cldHOVF4bDgvOWhaRDNHVDhORGpPaHFSamZZKzNZdmdacDZMeWQydXhyKy9M?=
 =?utf-8?B?b1gycXNrWW1NKzQ1anhBaGhuMnNFMzBuVjE5MHFtSDIva3lrblRmOGJRTmEw?=
 =?utf-8?B?c3FmZXN6eFhXVEFVZHl4cjM1cndHRlBCYlVxQy9NY0pzaU1sUUloS0Z6UUZM?=
 =?utf-8?B?UDVYcnN2VEZCR3dmRlh1OWVqSXhzcWJKenZ6RjI3czdpTHVZNmhsZE1BMEQ1?=
 =?utf-8?B?ckpSeFJScTZnWXA3VDBHaTh1ekk5ZGJpcUhLNlhqbTY5UHl2VnVPUytmM0FN?=
 =?utf-8?B?VStoTjdrK2x6RTdJUnpqUjFVWU54WVN0SjZzbTZOVytUb0QyWXR3SWpLZlQx?=
 =?utf-8?B?eEFoMDl4NFZ3cmh3a2lhWG9xaHNFUWlxaTdYcFlBUGNJenB4ZTRjQWRXUmw1?=
 =?utf-8?B?Z2F1RmlWN0tVdXJrb0RxZ1UyampsZHBqZGJ1Y2Y0dVRnanEvQS9GZVNpWno0?=
 =?utf-8?B?NTA0aGhSbm9lTUlTTTVtUEI2YkxYMWVzdUdOWThHK2NCdmdDQkd1M1BkMUJY?=
 =?utf-8?B?YTFxUFVRTkY5M0p6K09zeVZzblB5KzNmckVjVVNTV2tXMVVzbVZqaUtmS1l3?=
 =?utf-8?B?YjdkbktRNnhYQjNVZnhmWFFLSEI4NmNSbkVNS2loaCtNNjNMU1MxVlVSTnFn?=
 =?utf-8?B?MUYzWXg1enVjZEZqeitMSTZvSWdXUlZZWGlLQ3B6K0N6b1k1MnlpUTVPeHZy?=
 =?utf-8?B?d2pNcDg5bGRZOHY4bXp0YWMrZEJjOFZxR2xEc0IxRUNXZ2VuZGZZcVdENHh4?=
 =?utf-8?B?aEpaRDdDelpCZktEY0g4QTlQQkU2RXlERGxnbVNyTWwzSkZ2dnd1VkhsVDVa?=
 =?utf-8?B?SEExRHhTWlVxMEM0RDVCdDN2MGVwV2ZCWUJLRHEzYlVSQ1NrYVU1VVF1allX?=
 =?utf-8?B?OUdaZ1V5RWFWblZtbktoMkx0M1h2bXZPRGNWNEVETllEa0N0aEVPRjhBU3Fh?=
 =?utf-8?B?Q3o1bGZTM1VjNmZTc3IxZ1YxUTlZYUpsWU5jT0YxMTZnUVFDazdBSTVWZ2Er?=
 =?utf-8?B?UndQWmltemVwdmxxVXo3WnVmRzFyZFRwMEJsVmYxTnVZSGFtclFYL1F4cDB3?=
 =?utf-8?B?NVhJUVVuakZkL0lwUkpJVndYTmVFZkFQeFhCZGRUODhtRk9sWk5MM3R4MmJz?=
 =?utf-8?B?UUl2TlQzVVoraTBqZEx0UTFYNUF1UFpGYTRWSTdjc1phcUF0blBLTlhRaHlY?=
 =?utf-8?B?L3d3SFJYaDVhSHZRU1pSelZ6bWtHTnRUUTY1Qi8rQU1EdGJRV21VWUF3Q3FN?=
 =?utf-8?B?WkdkU0tQWDZwUmZ4S1U4V1hUL2hiR0VkYStTSVlzQVY3cEVjandCemtMK25G?=
 =?utf-8?B?eWl2MW9mdTd0L0NHS1R2QXVwSHhUQVlMY2JjdStTWUVCR0NpT2p2VHdqQjg5?=
 =?utf-8?B?TDdkQkQyQVJOZjFwSE5JdzBVSGxJSTRnQTNud2xCQTNEbUhsTTFTajJ3SWlJ?=
 =?utf-8?B?WGVCZFI2UFpZbnVXSHdCejVrVDZmaTdYbWJRUEo2RkNwMDdjMDdZVVQ2MGNl?=
 =?utf-8?Q?avXqoYciwxzgaW5dkd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31719d50-dec2-453b-32fc-08deb0c4cbe8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 07:54:01.6603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UB4opdMuuSQa3ym6eHO7JF1lJHsrZNOf054r+r7US9Pqx4ShqHmNPgikXOJGM2wd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8861
X-Rspamd-Queue-Id: 129DD52F221
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287461-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action

Hi Alice,

On 12/05/2026 19:56, Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> Taking further the idea of commit b10b446ce7ad ("udp: gso: Use single
> MSS length in UDP header for GSO_PARTIAL"), simplify the implementation
> and fix the checksum (apparently ignored by hardware anyway).
> 
> The mentioned commit started using msslen for uh->len, but still uses
> newlen to adjust uh->check. If the formula for check is fixed, newlen is
> assigned but never used before the loop, and newlen is overwritten after
> the loop. This makes msslen not really necessary, as we can reuse
> newlen, if we don't adjust mss before. The adjustment of mss can be
> simply dropped, because mss is not used anywhere else below.
> 
> This brings us back to one variable, drops an unneeded arithmetic for
> mss, and fixes the UDP checksum.
> 
> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> Cc: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Heads up, this is going to conflict with this fix:
https://lore.kernel.org/netdev/20260513074349.2152146-1-gal@nvidia.com/

