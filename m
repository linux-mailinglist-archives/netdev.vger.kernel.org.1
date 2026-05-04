Return-Path: <netdev+bounces-283960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOttMPzK+Gma0wIAu9opvQ
	(envelope-from <netdev+bounces-283960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:36:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DCD4C17C4
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 771023018AF9
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089D43DBD43;
	Mon,  4 May 2026 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bsBQ0s0V"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847D61CEAC2;
	Mon,  4 May 2026 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777912569; cv=fail; b=cLXpOmHo8xjuuJ2oytW2aqdO9jdmHw2r18yZInOCMQYu1zZ0ApwUhlWZwBhixHKy9qimyTDTqti5CFeYuwc/gT8IzkEMvYrIQW0JpS0EcIkvYn5seNn+qp8dVWcx9Z1PAFf1/AQq5AMgN0gHAv3/mm/Gip3wvGhw++RDYtFN2A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777912569; c=relaxed/simple;
	bh=5gutF3N2aHAfaU1OyW7qwCnpJENFD7+0oKKbwtjuweE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T4yWytkCerG+C43b+66mnB2dVIe5TcxCJxTNXX5l7pwWbZpQPfBCoBh8ZjCPrULvoZWlANdZC3fS5TIN5cc683AKvlFk/9B2ML+g+cO3QPBxI51mKxnzptiujVyz9QQSHzP75J5W56zWQMnCxKINtjVO07sZCGeypNqNj23jpMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bsBQ0s0V; arc=fail smtp.client-ip=52.101.57.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cmf3QLGSHZ08iC5IgbWJPkbdrc+My0VpPtiLXENNqRkndzFaOHj53ljoSNGM4JPwpEDuZ6lLhgwuHcTD2PwH67mdhtenECGEda4HVeIy65iogfo5RZv9WVfTFUxs27A38kxij8wth4kzPAmpDKG8qyB58pRjGfHZdb1yI0GyiHzGNT4IjNUA7ptyBKQhVTZ/HYiZyCMWzxYYkdhfG4rbZbaJ4irR0yjZoHJdPaF3WW3OD7MVM3uhivKkjm0m/e0wmgof3itNYGkL5Eb+sV+i1ljbllajJvkk6tW0eaz0Nrx5jvN+EIm8VEG/lPtlxpTSfb/sBaiugSgt0rLY+GgkbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLaS0NwRiUuFlXLCcuPo9seaXk4N5HL499lBaRjqAwM=;
 b=a4D/recTpk6codlnWm750v84KcNpS45xj4/ybuTGcd+FOC9RJlHpyVpe/ZMLbVvUwYjbxAD+s0a/vJA+KBSrSs/G5Ol76KaZTodyLarK4TSLTggjciUi/K8qS+/gS+d2/fcBhmEPfSxCLN8B5H7GAXWW3sLUrqVu1Y/+JxEqWlXuy2gMlcOEPmZHqDdHwDBWZzBDIDyDI1keJva1/YjVAfqyL4jnDY/IVNQZSEyTFj5qxrTYHrqtCDTiE9i8uwCb0IEBF/36cusSvV1U6f3pNfOjjN1gZ1E/Ga20oiQiEZecIUruwesWTfHrk/VWqcDI30FKraOAFqb9OaP3IjWnOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLaS0NwRiUuFlXLCcuPo9seaXk4N5HL499lBaRjqAwM=;
 b=bsBQ0s0VjQkl8J/00KHgnMklF4sTSuTtnL8AaATx2C7xlnfTKsL16Obn/D45g7EpnzMKa+NHrmF6dRvSoBzRuR03QZpERpDg8wNxUYmBC+vLtTfmkNRU8g/xDIiF7CY3DPVS1WPdNTsZn5c44PjTywGD6p0orW7wFMnwDOtvUcejC3v2LzqYhMmCqLRfFir5iGMYq1IZSv7Qhy9t0ejtc73/IBUeHSDpPaTCtG1v1ihtpnpvKArqqvhBNKxn3ctZzmjAOo3kzjgg45910QsuKgkIdD1IWh0cInnBnFb9/PtthDnd0lC4/pt1SuAgb3LF9tXQMF5smjJydoavo/h+7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ0PR12MB6966.namprd12.prod.outlook.com (2603:10b6:a03:449::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 16:36:01 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 16:36:01 +0000
Date: Mon, 4 May 2026 19:35:49 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
	=?utf-8?Q?=C5=81ukasz?= Stelmach <steelman@post.pl>
Subject: Re: [PATCH 1/2 net] ipv6: addrconf: fix temp address generation
 after prefix deprecation
Message-ID: <20260504163549.GA385401@shredder>
References: <20260503221139.3742-3-fmancera@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260503221139.3742-3-fmancera@suse.de>
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ0PR12MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d2424c-82a0-40d1-21e0-08dea9fb3a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	a8aoQt0IxBMqkLY/lq/pdvwxWMEjkbfnkLQ0CzmzyMeoxCKet4i6QKi3bQWLDvZfN2ROH6+z1Z+Cx2rRTAIasD//AHBwW+AkLr6Hov9JKf2zTUIfeuVea7IzUz35mcZlAtzhaI2GMAsAAQcOQlJh7R4Sdgnu25cSB3v1iRolFD0M/oxo34ovzfOAa+7xHAM4kqh3amV8A5ybHEXbh9kuSdOvd5EhNeTcVdhUg5bKSuCp0hHc/Xrynvyo3wTqpSjmpNEUAeAxZbNK6fb+0h7o6XNp69D4R5FTWFai+2QbP7fG6l44qTByWh1kiqDO75kjpYEUmpkrmWlhZvVN15MYkElo1j/9KSDye+yi3iojkIbENhVk3bxiu5oRe7+EhA9Tjoq5PnqxwlTpETSGxwJYJzMWg4eDPGg8Jgzqy1UJLm1JwSwvzce+yTpPru1OiSQJQIfYU1xpw5drTbVOXmax26uOepu6zCDkt5QYvywDq0YAD8rL/Y2Uun94klpCKcvQ+j0OVXaQJd7M6kh2R2spU7cT6Temb+b8h2lWzyyB7J/HnmhoS/Dd6UhNRsp2G6+AWMTs9syB5rIoJAkyPjWPpmYqtBGY+2OexuaHjNSmuaSOOoFhGewRDRAmrE2Iai7foXTjOafPKdN+7Yz2vw/BjNfax9bVFlTPJwLJFmuq9ZpAP2t9ttv5Me+pTBt6c1pyp8N1YFAeoDcppn5slekp2g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVMyTGh6eit6c01aZ2RaUi9wQ2hGZHJzN0VuVERrN0lHZ2dGUkdnQ0pNaTNv?=
 =?utf-8?B?bUw0VnVyRXIyVFZHcHZURFlGbUd4VmtWN25RL0kyaEdFbEdxSm5UdDRKMVUz?=
 =?utf-8?B?eUw5dHIzVnQ0djA5Y1hQeGF5eGxoSHczR21wOGhpa2pJUmdKdlFKenZwOVZi?=
 =?utf-8?B?RHJJR1RpNXpnU2J5SEZoTmtoOHl5d01KQnNMTkhYRWtwS3A4K1pSVlJJRXkx?=
 =?utf-8?B?WDdaOGt2d0tPZWRYQVBHbzFtOWgxZUpBUjVvTXBack8raGthVEwzUC8yR3hV?=
 =?utf-8?B?T094UElsaXFYNkYxMjQzeGRpN0NWMy96K0hwOEcrekw3TzdXc2wvcHMyOHNo?=
 =?utf-8?B?SFRIdEtPYjNyOW53b2lva0RMdWNLSGs1VDVVOEZUdzFJdGI5MHgwMG9rcTNw?=
 =?utf-8?B?bW8xMEwybWFDeDFiT3dOWVd6b2ZMUUtqTUYrcG9yVmdKODcvdEt2NVJiWG1Q?=
 =?utf-8?B?TGJHbGdxSUkwVERQUmczZXRkWGxPRVlHNEhKVjIrL2dKYm1QdVBYOElxZUdN?=
 =?utf-8?B?WXArV2tOcGJjRERtRnBnTktkdWlZRzMzaFpqVkJtWjNETXFtSVdoK1hEVGlz?=
 =?utf-8?B?MTc1b1ZhMnkycU1LYVFSdUpMdy96T3h6UE14R1dTanBwaUtxbGZxejhVcktk?=
 =?utf-8?B?TjQ2QkhtSHJYNkk1U3dFem1ZWk5XTDZIQ091ZDJVWVlJU0ZXN0xQYmtYa2FG?=
 =?utf-8?B?Z090TjZlMmg4eTlkU1k5cTZBRmZqZVpwMG1jVDNxUUVnb0lOL2NycGVTTm5D?=
 =?utf-8?B?RVZ4ZTRXRklSazBSQ2pnb0V2aEcrbDU2dnZXeU1YN3N1NU9FQ0t2S2pZREVj?=
 =?utf-8?B?eWxyWTJ2NHhuNFF4QkNYYnArbGt2QUFBbEV2MnkwSDJleUloY1BYNDhiOXgz?=
 =?utf-8?B?VHRCOTVtcFBqa2hJazNZS24wTFMwK3lVV1o4elNmK0t3OVhsSi81SjlWbzE5?=
 =?utf-8?B?ek1WZ0tTVm1nQjN0dHJ5dWVXQjUwbDFzYWpTV2k3YTU1TUtOWlEyRDdlWTdu?=
 =?utf-8?B?VkpMNlU4enZTVndzcktPNVo4Y2w0OTdlK3J2VHQwYmFkRCtmdUdvS1U4Sm1U?=
 =?utf-8?B?TnVFTVVXNklKTFlKak91Mk8zWkloV2oyWkR3OU8xdWUvVEdCYnM2UWp1b1Nr?=
 =?utf-8?B?ZVVHTlpjV2ZqK0JRWEp6b1pGY3pvZFVHUm1XS21OR1A5bit4M1JPWDlYbGxD?=
 =?utf-8?B?cnNVZlRqZ2FDNUJUMm83MmQvdGpWdDhucGxPSCtQeGV3NUg5K1d0NzNjK2I4?=
 =?utf-8?B?NWcxWGdxQUpoa21JOW9SczVQbnhTYWgza0VnZ0dhZlVMaVZ6Yzc1N3VyWlJ3?=
 =?utf-8?B?L2N5MzQ3blU3SG9LRmNPNGo2VTNBQ3BiMFN2ei9nSHF1M3pReTYxQitXVTkw?=
 =?utf-8?B?ZjV2QXpiaDVsdEEvMnVuOVk4bTZZMzZ3aklaeG1NcUMxS3h6RzdFbEdLVnlm?=
 =?utf-8?B?L0hLd25iN3RxRml5ZXdIYTI4QVZYTjFmOFN4SmlZUzl5QjF5SExsRGNLS1JP?=
 =?utf-8?B?alVkaGx6YUc4bjZkUjhpbEpKWjNta3Y1eVNpRVh5b252WUhDNURkUTNKYmM2?=
 =?utf-8?B?bTMyeFhLKzh3eDJJckgrNkZWUTBzTTFiL0YycnV2Q2orOS9TR1FqTEFXaWJR?=
 =?utf-8?B?S1JGMVcrT1BxR2FlWUpRNkZwN2dMOUJxTklLQVh1SnAzbzN2QVdmbjM1eWp5?=
 =?utf-8?B?Vk1jTnV5VVd6Nnlua1pjQ3hoeWpSamtqS0U2c0FPd05icG9VNWtMdTROa2JH?=
 =?utf-8?B?alNNR04xN1VTWjFzVTlRVFlVK08xMStSVUoyaGQ0V1FOWEtHMmwrZ09TS0E2?=
 =?utf-8?B?dkRiN0xiTFRlT1d3U3piMlVsQnd4REkyRllwUWU4dnF6TVVyM01pZzBHa3Rs?=
 =?utf-8?B?bnhub0d3ZjEybStjYTZvMWdKV3Y0Zk9QbDNVaDVzSDM5U2U4WDZhekVnK09a?=
 =?utf-8?B?T2Q2SlVoV0RBcWVmdXZzeklKekE1SFdEeldrTmtWZUJ6bTBXcFZObG1vOFJP?=
 =?utf-8?B?WG5UQzJseCtuQzVFSVkyQXlNcTlXWEJpYTk3TVg5dVhSZUNnZURrNlAyYm5q?=
 =?utf-8?B?NDY1YndPL0JiTzFQbm1jbjYrN01PZEVSN053Wkt0MGhGdnAzZk1vc3hEbkZP?=
 =?utf-8?B?bTVZcTR3U004ajJmZE5rMERmSDdTMjdaaUdhMFhWU1hrbjZDWXRXWkhnMVJj?=
 =?utf-8?B?Qm91bjRwWnpleDZ6T2FyZjFwVUNGUzZyYkJWY2RnZFpOWXJQWDBoUVJUaHJt?=
 =?utf-8?B?eFRzb2FYL2hWODhHSjZJc1pjT3p1dFNQQThnMEx1RFZsV3RZWGNaSWlRUUtV?=
 =?utf-8?Q?gEqB+wHyGwmwl7CHja?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d2424c-82a0-40d1-21e0-08dea9fb3a20
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 16:36:01.3047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLEIxukkD4SlFZOvKzdEkKPp/KkHNwRGPZK3cROgEPbv45SufvlxB9z1ePO08oAt62HA1khMRt0yHzXAtppo1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6966
X-Rspamd-Queue-Id: 28DCD4C17C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283960-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]

On Mon, May 04, 2026 at 12:11:40AM +0200, Fernando Fernandez Mancera wrote:
> When a router temporarily deprecates an IPv6 prefix (either by sending a
> Router Advertisement with Preferred Lifetime = 0 or by letting the
> lifetime expire) and later restores it, the kernel permanently loses its
> ability to generate temporary privacy addresses (RFC 8981) for that
> prefix.
> 
> This happens because the address worker attempts to generate a
> replacement temporary address when the current one nears expiration. As
> the base prefix is deprecated already, the generation fails, burning the
> retry counter for temporary address generation of that prefix.
> 
> When the router eventually restores the prefix, the temporary address
> becomes active again. However, once it naturally expires, the kernel
> sees the exhausted retry limit and permanently stops generating new
> privacy addresses.

It's not clear to me to which "retry counter" you are referring to. Are
you referring to the counter of the temporary address or to that of the
"public address" from which it was generated?

AFAICT, in the case of temporary addresses (those w/o "mngtmpaddr") this
isn't really a counter, but a boolean that tells you if an address was
already spawned from this address.

> 
> Fix this by verifying that the base prefix has sufficient preferred
> lifetime remaining before attempting to generate a new temporary
> address. This prevents the worker from burning through its retry counter
> during temporary network deprecation events like a router reboot.

Again, I think that "retry counter" here is confusing. IIUC, what
happens is that the kernel marks the temporary address as having spawned
an address ('ifp->regen_count++'), then tries to spawn an address by
calling ipv6_create_tempaddr(), which fails because the preferred
lifetime of the public address is 0.

> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Łukasz Stelmach <steelman@post.pl>
> Closes: https://lore.kernel.org/netdev/87340td30q.fsf%25steelman@post.pl/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  net/ipv6/addrconf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 5476b6536eb7..f6a3d9da3cb1 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -4654,9 +4654,11 @@ static void addrconf_verify_rtnl(struct net *net)
>  			    !ifp->regen_count && ifp->ifpub) {
>  				/* This is a non-regenerated temporary addr. */
>  
> +				unsigned long pub_age = (now - READ_ONCE(ifp->ifpub->tstamp)) / HZ;
>  				unsigned long regen_advance = ipv6_get_regen_advance(ifp->idev);
>  
> -				if (age + regen_advance >= ifp->prefered_lft) {
> +				if (age + regen_advance >= ifp->prefered_lft &&
> +				    pub_age + regen_advance < READ_ONCE(ifp->ifpub->prefered_lft)) {
>  					struct inet6_ifaddr *ifpub = ifp->ifpub;
>  					if (time_before(ifp->tstamp + ifp->prefered_lft * HZ, next))
>  						next = ifp->tstamp + ifp->prefered_lft * HZ;
> -- 
> 2.53.0
> 

