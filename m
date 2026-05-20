Return-Path: <netdev+bounces-290011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPjOJaXkDWpz4gUAu9opvQ
	(envelope-from <netdev+bounces-290011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:43:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CFC59251B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8516630688E7
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40EA369D4C;
	Wed, 20 May 2026 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IHNyvi05"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012070.outbound.protection.outlook.com [40.93.195.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40EF369D4A
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294876; cv=fail; b=Cf45L5k+ULwA7M3fxkOFCNBGYQQSvIqBStpeU9AaNRSzprLQ0sVPh8xlh7J0/AwL2yp/P+sGdzInnqPYhbA+SUVPeTW+KRJFYBA5S9OlY/0z/j8Cxa93KhX5ZuUVBo6DIyXyho91c9+iijbfvwNldXQ2rd478TwJivrL5y1wQHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294876; c=relaxed/simple;
	bh=Qo/4pYWl2KRfmMPqgiRhDjK3rhMHEE/5ClK5fGrOXwo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dggyx3rI2L4UdnP8W2QUlUIl0DwciPP0F0Ig5v/yCDC8zFx8xX5pd4CJm9oJzw9RYLieX/DNBVMjOata7f674085IddG7X9aT9DnlOy65C6EpHGj8I9A2YFXRLOSS2LffkZT+RBmQpzf7f9FII10BbB7fjBU1BYaGZjCHbYcK0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IHNyvi05; arc=fail smtp.client-ip=40.93.195.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fetvQ2J8OdMNIeOlRK66nZimEHt7l4/ORl/GI/B//LJ5RfQwdJogPwAE72ytRW+xspQJgsRIrsRXTw3C2o/ya2x+DzzYRjbZm3UeTfZpUbGt6KXReTohvFu6ZB/xboWawO8v+qGwMIrdzB1Q+9hslJacJkBHQajip/klY+k11PU7YzgSsDf2YfTn2uVFe4F1VChC5xFy0rTlGiyESqBNFA8hUIKKNbrSuN2tVlqWyYkSIAmCM9o0vt/uVwNpMYp9yRVDavsFZt3zOREzhrMqtegrHpfTmtljk0ovLwFV10Pmw0WQ6fw2x/VUmPoTxqp7tGKpSCgYZ2hd56+f9cYlNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31PgFVRlwIQEG6BnzviFCZHQmwAcXny02oQ6V7Yz0Uw=;
 b=eiYHinYisWdxDRAQto+V7N6iOX5lFDPBDYkkfZsbqBxQxkkI/YmL1a591RyvaRRaXkMMk/f7MrG0UOfZKMh6tU6TH3gYL/47ckYFLz2BGfr/TYsGtNRBq7xUmW+X0jLiomUi8ZgI87uWSlIr5A6DEsB2htkSxelIqC6vnclaUbedo69oTuA/byMKNwmD/vovFmZhCye4FjO6FMzSdBs9GEW7Ck8wfdDyLUyRcWg4GWb8Er7DmP+S2tevBk+WHl5CxHJKNX+kkwaVfpZlLPaLRJbLnpyY9IU+Iq47uEpTCKcoplI2iox2PY1DjbOVAyULersjiKT0YML1lSytuCxaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31PgFVRlwIQEG6BnzviFCZHQmwAcXny02oQ6V7Yz0Uw=;
 b=IHNyvi0595A6OA/cqe3qD8DHaX2tejs5h7rB2SKm0UFD2WavVlMsbUlGP+MpitKWM4ZIRBcuFVjoqlk0WRXBOeXzxey6HG8q9TXHLEK+VmdlwqrSTMzw8b/kEppsiKY3dWfILzUAyxSKm7IDhZWqyCXHBRBwAcm6leBlErW6dc+ZfRKbHwyTdyczklzEluy7PWiufYa1XOWDOGmS9V1FgBQtvG9HgNhQUxCR106rujeFtSdRYPvbA9b2zAG4aSurFlcN+6pGQxP5H7iMAHPatUp1oSJel16XTC5A4l0o9h6cw1xTPSmXONnPIw4smdRe6gncCkQ7tnG2VguQsGh19w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by SJ5PPF2CD49510F.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 20 May
 2026 16:34:27 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%4]) with mapi id 15.21.0048.016; Wed, 20 May 2026
 16:34:24 +0000
Message-ID: <f829d309-a4b8-4474-85ab-da5ffffc801a@nvidia.com>
Date: Wed, 20 May 2026 19:34:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] udp: Fix UDP length on last GSO_PARTIAL
 segment
To: Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
 Alice Mikityanska <alice@isovalent.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20260518062250.3019914-1-gal@nvidia.com>
 <20260518062250.3019914-3-gal@nvidia.com>
 <20260519181200.323fbaef@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260519181200.323fbaef@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0318.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::18) To DM4PR12MB5248.namprd12.prod.outlook.com
 (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|SJ5PPF2CD49510F:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8dbdfc-bbf9-45b7-5d31-08deb68da6e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|11063799006|4143699003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	C1aYE1DXBU3x3K5tuZiz5wUnwWInbOZxWdErcrQzEOaKB4+dPVwxTexKpv0BurJWhPCrI7olMi/9B12MgH831pSN8HRYoSVmW3TAmkmbzJRcYRPXb8SuTt5QLZ6NhlQHOo91h7+5VKJoqlIeAxQkvbGIyuR5vlbfjjuWp3PBlx1D2QkV7Fd8ZXqyLFjjjxmeC6qpKGNdeayT392O+iK/OqaLTK1VQYNcKlm/5og+WsNBy3WKTtbIQzdAg3D/dQnoJBwDjAacHTXucs/pp/8fxjzyIxMQL9YkSoUAoxtUAn4Bg4mGhhFRTY8YwwkV9uqVEKR0WVeaoamqsOR8fyPCJLbHRMJnbAiaeuuixGPWwUWamQoBFz+6TMDwXoY/BElz+vNaD0N/NCNkUCGpd4vFXNan8HtvVQNLDF8dD3+m72WPJhdRCgvNfmX+LzQ2L24E/wKXwF+SrF4ELfnCqdBih8GF61Qb9nAoySRSp1c0v/0bHuNbqOQS/W687rF4thGa9R3gSsEJ6/AgIIO9paHy1Vkbf1b8rnvkHY3KTcCPAgVxoOETGZ54PpGNPwyS5W0SoejSElURPat6LFMvaVQSoGqOErBPGzA3EvFj+OQThH+vD8e8w7+aQlKDOfwVWlsNlGOa5U97UFk/l9534NluG0l4yC77g7FQLttHK9a53/jwuPVQ5W+tnhJLtnX2gYG6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(11063799006)(4143699003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d29KbjFaVUkwcVpyREMwcWs4ZXRFOWVFSzNQbm0wV0lJcHlzMVAza1JIeGhq?=
 =?utf-8?B?cGNzS1ZNalViV1hkNG92VGRWU3BPeUtwd2JmeTN4RlVMSDNROEVpWjl5Tjk5?=
 =?utf-8?B?MldRQW96eFBxbVhGMFZxbUN1UUVQTXNEMXJ0WHA5c2VzbXRLdzcvUko1OWtO?=
 =?utf-8?B?RnducVJDQjVZZU90eEh4WDAzZDVzQ3VGYlJQaktUb1VIb0dibHkwei9uYjZk?=
 =?utf-8?B?NEZ1bnRScVdyQlE4K0IrL1RGbWxPeVB0VC9qOUNhYWkzNXdoNjFMQ3huT3N0?=
 =?utf-8?B?bGxVOTkvR01wRVhEeUdjQVJnRVZQVlA1bHpBYm5GRFE4b1ZpS3AveUNwcUYw?=
 =?utf-8?B?V2t0VkdKK2RTeU9lelBMTVMrT0ZEdVBBZ2JkYTJIdUI3Z0huWVZ2UTBYQzZX?=
 =?utf-8?B?Z2FidFVlRnUxQzNybUdhajR6eS8vMStNM0MxWVorN2p6Wm02b3B4K0lTT2h1?=
 =?utf-8?B?cGJTSXJweERuS3AybGVvS2YzZDlnTEc0Qm8wYmZ0bE9FUW9DaXFCTjVUK095?=
 =?utf-8?B?Y1Q0YXo4ZDdjT21PL2tHaTVLUDdLWXg2cFUzK1UwZy91N1dFNVY1WWtvTlpn?=
 =?utf-8?B?M0xrOERpRkVuS2RQK1NaR2N0SnhnTG10ZmxkYUs3Sml0L1EwU2k5WjUxcFBz?=
 =?utf-8?B?WjJ5b3FNWk9FcEZPTDRHSXBIaEFXN1ZGWU5wbXNoWXdVYWI0bXBibEpqTFVH?=
 =?utf-8?B?S0hSZlF0K1kwSGxrWkVZSm1sMVZ4eUhqUlhQZzd1SnpmY2IyTkVXeklBTUdG?=
 =?utf-8?B?VXpCTGpTc0hvanI5bVdIZGRYU2t5M3RheUJLSmhWMG9GdHN2T2RVTi91dC9S?=
 =?utf-8?B?QWl6cXNaZW1SNUxiVUhSbHlDRGRvVHBuTVZSSDBZbFJRT3VaaXNzOTFLYWJu?=
 =?utf-8?B?N01ZcVFLcjEyVnJjZVJnTGxuR05QNXBOR3ArdWlmZjY3RFhERGwvSGNLelVB?=
 =?utf-8?B?RDZYOEQrL0Z0Z0N3SEhFWm9mYWwrR1NkRWdpdlBhSDRzbzh3alBrYVlnVzlF?=
 =?utf-8?B?TUE1TjFYSk5FT0w0Mk95K2cwM0xhWDhUSktaMHhsOUJiOVB2ZzZQckcxbzlF?=
 =?utf-8?B?ZVcxSmJzNThZZUpBQXg4anJlOUZHVkp0SWpYRUE2aGJQVzBSMXZZVU9DZEN4?=
 =?utf-8?B?T3hoUkFuVmpXOGROeUUwU016T1Fucmprb0pWVUhVWkpWRXYzNGQ3RTl0bXdC?=
 =?utf-8?B?MnN2SlFpT0ptUFAwVEpGbkJNd0lNMUVGVy9TSVk2TUhNU3FzeFBhdHlDdFFv?=
 =?utf-8?B?eCtGb1QrbVlJa3VkSmRZSlg2Q29Jb1lONnl6Nlh1WHN6WmtIYWlPRkZtdjVY?=
 =?utf-8?B?c0VTSSt6bmtqcUFnN0hQT0E3amVkYjhpdmx6RCtJckFDZEs5VDZadHhPWStW?=
 =?utf-8?B?eTFsMjNDV0pMejhFZDN3ci9SYVhadmhFWnZyb3JuQ2lva2FXcnRFUjZ5Z0hV?=
 =?utf-8?B?UjlpQnpaNENSRU5CcUVmWCt5TDEreWVNZDJBOHRpQzFLRFJhdDRzTndpWTdy?=
 =?utf-8?B?dVYzL2xDWVN5YzR2aXNJVW9DQ3JoeUtHOUY1SWdTMkNPQS9HVkxKb0I4VmJS?=
 =?utf-8?B?V2JPTzdJV3FVZEhQOEhkUThadk9Od0V3UXZqMXYrRlp6TTc4b040SDBmVFVZ?=
 =?utf-8?B?a1d2WFFicE1qS3RlaHJqWVd3OHd2YUZNSmpoay9rSGorNlkxaFVaUVErbTVL?=
 =?utf-8?B?WjkvZ29zc2k1S2RobG9wTEtXK0F3MTNoVEVlRlozT0ptZ21USVVUQno0elNk?=
 =?utf-8?B?alJObjczT09WdzR1d2hCVjFqaGFHcG9wMmE3ZWFjL0hHS0dxMTRFSCt6MDds?=
 =?utf-8?B?V0FZV3hCb1RVTGIyYkZPNTJqTzFkbm41OWxuazdLVTlVaFByaE42UlZPbUpn?=
 =?utf-8?B?emlVOS9JN0trYkJYc09SRUNOZUxyV0JiUmUyYTMzeWZ4bGRxKzlib25sWE9M?=
 =?utf-8?B?Ni9PNytYVVhQazRFNG1OYzQwL0NVaVRqTjVUVjhHUFduampnVWhMd2pOMG9k?=
 =?utf-8?B?TjhySStPditudFA3L1hUdVJ4aGVXaWtOZGE1dndQdmk4TDZvdTd1REg2STB1?=
 =?utf-8?B?VGVnQ1VwYnNQMWpFd2VLdmM5cFVOSzRha2o1UlJSTkIwaVppcExqdFN3eVBI?=
 =?utf-8?B?SXBQa0tzc0hhTXAyeVVheXRRVmcyS2RHYU9qM1l0aTNhTzIwLzRQNkZud0Vr?=
 =?utf-8?B?YU83aEd5MFpGWEVGNGI2Mkw5aU5DMEpwQmFlQTRNcnA3ZGRUczZxTUt2d0d3?=
 =?utf-8?B?S211d1RJSS9nUTBQbWR2cWlGSHZBM1ljSStuUmNMdnpIdXdHbjN6bTh3eHh3?=
 =?utf-8?Q?WiQ1RG04zGJDCu6W8f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8dbdfc-bbf9-45b7-5d31-08deb68da6e5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 16:34:24.1927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EErzMGrAStv0zA8vkQgJmd9NoeKRd3aP5mr5CxMbpXIC8mqwT+t5eOOKAEyzyXd1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2CD49510F
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290011-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 58CFC59251B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 20/05/2026 4:12, Jakub Kicinski wrote:
> On Mon, 18 May 2026 09:22:50 +0300 Gal Pressman wrote:
>> +	if (!skb_is_gso(seg))
>> +		/* last packet can be partial gso_size, account for that in
>> +		 * checksum.
>> +		 */
> 
> No need to repost but I think we should tweak this comment.
> Saying "partial gso_size" when it such segment is in fact
> not part of GSO_PARTIAL is a bit confusing. How about:
> 
> 	/* Unless skb fits perfectly as GSO_PARTIAL, the trailing
> 	 * segment may not be full MSS, account for that in the checksum
> 	 */
> 
> ?

Sounds good, should I submit a patch?

