Return-Path: <netdev+bounces-287501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOc9F5VJBGrNGgIAu9opvQ
	(envelope-from <netdev+bounces-287501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:51:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AFE530F46
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5A8A3003BED
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63333E869A;
	Wed, 13 May 2026 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R3PFZFA/"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8199D3E6DDC
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665239; cv=fail; b=nKgy8iS+T/RWW8bVfobpo3MVcjgLgPEs3RHfol7KIAAocU5XIB2uTnlZalPx2EFkRNhGuCxB5618TOaNB7WJn1H2iyCWiuPJv2RG7Joy5xyjE5y3TjXIvyCdq5fTyKHCJbA8XdIkopqXMm7UMYCUizrURGn/HYoZ3g5VndpAmdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665239; c=relaxed/simple;
	bh=C6733h6xBSyJYzORq+wPmpsvh874s5fOfcTwX54v11I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WdQMWd66eO74QJ9R8tCHtqafdqe9oP9ts7+mKBbY1EL9u48/VWTrnGO6Wm8BtBJo2hoWBgPc6/aBhc+w/Yb0mtxUwZmi9jL+VjcruL/+/ivxd5QHTyOlUeCQBi8qzRrWvwPnuQRTRridWSGukK/7Ni255+Vmcl5MKRd96uUPyEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R3PFZFA/; arc=fail smtp.client-ip=52.101.56.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTt5BhlsJOO1MmeVBfUMODK3wrewEv+wr2l8z+RLKwQUXAL1Lrvks4YrWgzTBpDvjczJn9ZElrYkq89hb8jBh0bCiWFl9c8Ax2kWH23qfwZxghpfoRxXHAiRoEuecJ1dSEzw4+9NEdHH6593F0JA3czqVLPN7jGN0sMx9QLcuSWhNRYrTRfajfXrnJD5Rk4zZNZcpV5Ks2vZPAYxdxMONy/r6ugWzdjo52JGE6KsBl/Fn9wl8SDzQjT5GLn97eEw/Wm2upaZ+RYD0Ez14ecL1eh1OikJ9ucGXV39xZ3G6ntEgWIEuUnbnp7x0NJA75QYyP5cedvc98DfX584giAk/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzErpiHjsm5Ly0/pktrhBbmA+QGT4+xUbyqBwvwEwRU=;
 b=AtHx8Fg+XsZWOwEg74J8p0h2U80qH3T6n3x8n9ryCaQqB73PH8mGugtF6ZUqPOeCnsytFqXpFHsHRHPHJsOLSyq1OnXqZspaYvFuJASXVoLikuLJ5kSvdeEMWi4WngZ2C1QTuwXn/ZwvE27eCWDaBSqUAIIag8XCQOriqyOM4qa+Z8Midfakveiqshw7ospfFVmChal2GI4y8cj31D5uKR0mpay3i1QmXXeXJkkD8meLs8pgokxy5YIJv8vgHOFzooDP9IM1fd2FBMLTx8B2i0SK5JJpRbXX8edoHckM2feFkr7ky/hQTe4wzktwOlqTJEBpMQH0y0hD/jOQ9pr9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzErpiHjsm5Ly0/pktrhBbmA+QGT4+xUbyqBwvwEwRU=;
 b=R3PFZFA/zPviHPFlZ5Fs85u9vmITa+2w3G+ZZOlHzGDb7RcRpHekN3Ipo1mFC2jr7rUJ85L9edTtInAkfQc5o0RamHW0BOKzNcZAwNL/cxouykenAxz5mjADq9CQwE4x7Zs/mJ8FSw7Rn7BzW+sehVM28qr1745788Ahp5CsnD1vW71T5A8ksCKjgDrUMmENbVEMmyomfWiRRQONdwdjjpwjnAyBWBrh+huXdZuoVrFUziJivb+2ZcL3Tx6Uy+dAfVlUPFIxROFFvRZX7OD28pxzsbF/jKvnIn5dsNSFkz0CjAlHxuou+3yTrFtNcg/ghGrn91UiD1NqV8AH4m0qRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by IA4PR12MB9764.namprd12.prod.outlook.com (2603:10b6:208:5d0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 09:40:33 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 09:40:33 +0000
Message-ID: <d7719a8f-83b8-4818-8301-15e145f551fa@nvidia.com>
Date: Wed, 13 May 2026 12:40:26 +0300
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
 <6bd88b37-4aeb-4783-8b92-62b38fe8603d@nvidia.com>
 <35cf30b6-f3ac-4af3-816b-53511625d916@app.fastmail.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <35cf30b6-f3ac-4af3-816b-53511625d916@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::18) To DM4PR12MB5248.namprd12.prod.outlook.com
 (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|IA4PR12MB9764:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d4f85dc-05a0-489d-f3ad-08deb0d3ad6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	T4IHhE1m7QsEY59tf9DC0EMlGd6P8Zq9Q97y2gKiJhPJv51vbOo4KRacnm9OMd+IHeXJqDHfzFMr62b6/hhzcc1IHkItrRp/fHdzUbtHhrRBuYw8LAnT1+OdqNzhGfO+PQMl1pLwC6lKoHVz2lwqtJCJSxiEsOetb6R8/VBZR33HCbhaig3rlCX9rPl3WvLlQygmn8/tY1AojgRA4waAQougAbXvZVLdPzBsPnnjb6huiixbSR5uD7x4hn2SjGlIZJr/Upx+9M1LKw+IN3YeuERETkL5XCSVBp+cMxLRDRuz7/AtyoLgf9qfVZ0TfnTHIZ7SuRWkzZc9kDEi7Sr/kZEYYawMcXUWBlq/fSZV3WvxJ9zIFyxLOz66bMFtSOV9ypPJfFwo/z+uib57ekwZHsUj/iKH7h7BnQoyvJ/2WQtOpoZJc0zk4Jd8Rr8BtgcIbza049zJ0VhBIoJJ1aVTNrLSmQnLgSklYe+yJf0obrF90l2TM7qJQesYShEcbW6c8zOjPXaJGS98UmX8YRixLboDW6/alkalzpVxITwdbozITCEOomRHnE1MCRORIJ93jqz7necGAOFUEwy2F+ABqS1xYgbb1CbdPukPmIQIAHTjGoptof4K4qLctMAc7nzVN5iQDgnRqnIQZF6M+DsSGamMhfHt15+P4sD3totVgb3cN3ZrUUnIFxXCPRni7VZfXndlt3+IG/ialuefXCIIMmINDrFiYxpw9YmumKjl0Ix6geGQzIFnY+v45jMwic+C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WU1Rd042MnpLZUJLK3lLaExZOHNId3dhaG9CTU11ODJkS3paTUVCNDB3ZWpw?=
 =?utf-8?B?SWQ1cFN0Vkp0RmpzaWR3QjJ6VU91SXkyaGEzd0hHMnJvWi9Ya2wxdzl0QnVs?=
 =?utf-8?B?TlZ2b0QvZzFPOGNpWHV4YjhkbEtEZXIvNXZqM3cwUm9IRU9CZnVmWGhIdzVz?=
 =?utf-8?B?NDd5cVFEbVVxRlZqbS9tOHdKa1JGYmsvaGpCd3JJTzdGa3BvZFRURjN3RmNE?=
 =?utf-8?B?QnJ5WXZhSU0wOHJLQU5IZm9LeG11VU8zSm1FTzBGL3ROaG5FMFVJSDdYR1Z3?=
 =?utf-8?B?U3ZNd09xQkF4cXhRZGtmQk11bklFSFRvdm50c21FT2JMSkc1NXB4bDg1VURo?=
 =?utf-8?B?YXl0NHN3QnJIempYMi9VbnhTWnlra1E2TG10Q2JFUERSUHRmbjJFeHRTcVUv?=
 =?utf-8?B?YTFSTUpyTjUzdm5nMDV6U1puS21BNUloWUFKOTVhNmJBQko0N1lzanUwa2RN?=
 =?utf-8?B?YmZkand5U25HbFFkc0l0MEtDeTcvaHVmd0c4WlJVcXAvTXpKanNBMlNHMTRY?=
 =?utf-8?B?czBUZFptTmI1cVlydUpWd2Z5Ym1GNlNld1A0RXk0RWJCYWljdFdiOGRuQnpV?=
 =?utf-8?B?bmZNMGJaQkdySDVvUjlXTXZ5VzhoSWVpV0gwOG41QmpqS1F3Q0pERzEzNGZ0?=
 =?utf-8?B?aC9BNTN5ampJb2MrSldIYVF0eUZNNHRvY1F2SWN3YVJjYmhRTmJkejB0czVP?=
 =?utf-8?B?bGl5YjBMdE9GWHRIczV5SlhUV2pnZ1hDRDZ4TGVRRDhyL293a2VOOFljNnFU?=
 =?utf-8?B?SlphOEFZK3g1VkJ6YnA5NEJHa3N2RTY0TGRxTjUrSThFZGxLcEYxWElPWGhS?=
 =?utf-8?B?cUtMeDJINjhqWnFZcW9KNUYrcFZoYnVWbDh0azM4cXJGNytoZVBQMThjaXNi?=
 =?utf-8?B?M3I4d2lOOXg3VzRYNjdDK1owT1VUdXpTbmp5a0lrNUo5YzB6TCt5OUhvbFNw?=
 =?utf-8?B?amlMZlFNSzJPanAvcmF2LzYwQWJEV1J5TVdQczcvVjBqeEx2N05rYWV1Q0Rv?=
 =?utf-8?B?VVVwLzlMcnJtNlI0VWpoTElQMnVRODFtRStJYitEVUh4bGZOL3VUUktreXVW?=
 =?utf-8?B?VFVGV3RReDhMVUFjaFdFcTJIUmUwdDI5Y2Q5dmNwT3lyb0JyMGdDQVhoejUr?=
 =?utf-8?B?Wk1uRk40UDF0UDFzdmdCY3NrV0JCWFVQZG9VMk5TK1BzZnpWa000THp2OTFI?=
 =?utf-8?B?dE1ZTWtBL0pIRnNpUm9xV0lTZUVpNVA2bGlmNWROWVNVY0VMbmRCbzFPVCt5?=
 =?utf-8?B?OElkZ1FoM29yMDYra1Z3eEYvU1VVNEFTQ1Bic0RKd1V5ZmE5Z054bXA2YUty?=
 =?utf-8?B?aE5NdWxDbU9XOGxteEcyeWFRL3hhQUR5SkVLZWRhaHErcXpZSE5FVFZJQSsx?=
 =?utf-8?B?RVpNbGZIbFhXTktIaGljY0YzUENHN2htTVRtOExkME9HVnY2UmdDY1pzNVdK?=
 =?utf-8?B?V3Y5RHhsMW1CZDVRcU0yNUZoTU5yN3Z6NzAxajkvOXlBL0JUT1l6NXFZZ3ZF?=
 =?utf-8?B?L211NWlHcXlkWmVZWi9WcGZHemN5QlV5a1g3TkRaSW45dFoyaXkwb3U1VUx3?=
 =?utf-8?B?M0pWWVhyN3ExQk4rbXZ1bXMxc0xwcDJNRjR4L3Z3Q093cUIxZ3Zmcktzc3Ez?=
 =?utf-8?B?VVNrSEwxVGlyN2lDSUw0M1BUM214enFGVnd2ME90Z1NmZktjRmJXc0NVbkhl?=
 =?utf-8?B?b2hiNjVNcnR6bUFBalRQNUpnRTdWdUZjTHJCUjllLzZCcVl1ZUJBTm5raEhF?=
 =?utf-8?B?d2lKMFdBV0orM2VJQ0JDSzlNUWF0djN1OXVDbXVzZkdZVCtqZDZLQWk5bEow?=
 =?utf-8?B?c3lLMGVpWDZjdlRkTDlleE9VWjRIdGhmc3JvMUl2UG1waWhMSzM5RnpseTI0?=
 =?utf-8?B?TjlKeFhld0gyQitDd1paMlRUM2d1WVNaaFFxekxvYUtXb2UvR0NZWElaSzRO?=
 =?utf-8?B?MVBiZUppc2NRejZxTlZSa1dxWm85NGQ0U05JdWc1SlJXL0tiaDB3c1IwY1Vl?=
 =?utf-8?B?V094K3ZVYS8zY0tZZkZROGxUT251TjJVeEo1UC9HTEhaalNMVElKeEZEQ2tz?=
 =?utf-8?B?YnNrMXh3cFVyMDNjQnQwVFZxcVNIUnExMDNzaXJtNGdycm1vbW1LSnQ4RDUx?=
 =?utf-8?B?Y2t4QXJTZ3pTbXZRL2YvNk52NlZkT2tic0NHMzRlSEF4cWhqTTVVcm9hUjRN?=
 =?utf-8?B?ZktrSGord01FWFJxc0VXSC9INGdWT2lTNit1MEQvek5qUENNdy9jc1dUc3ky?=
 =?utf-8?B?TGI1bkRHVk5kMVhjVm4vYUgvYnFJQlYzam5rNlI2ck5rZ0Qrd2RKM2RXcVNO?=
 =?utf-8?Q?fGCdlauPCpmYPtPrCM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4f85dc-05a0-489d-f3ad-08deb0d3ad6a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:40:32.9764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNhHOD80R7lPTDCA/C7actkaOcShksBnw7A1PtOcusJvia0yGnsCrgD+jzHHMRk1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9764
X-Rspamd-Queue-Id: 59AFE530F46
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
	TAGGED_FROM(0.00)[bounces-287501-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,isovalent.com:email]
X-Rspamd-Action: no action

On 13/05/2026 12:23, Alice Mikityanska wrote:
> On Wed, May 13, 2026, at 09:53, Gal Pressman wrote:
>> Hi Alice,
>>
>> On 12/05/2026 19:56, Alice Mikityanska wrote:
>>> From: Alice Mikityanska <alice@isovalent.com>
>>>
>>> Taking further the idea of commit b10b446ce7ad ("udp: gso: Use single
>>> MSS length in UDP header for GSO_PARTIAL"), simplify the implementation
>>> and fix the checksum (apparently ignored by hardware anyway).
>>>
>>> The mentioned commit started using msslen for uh->len, but still uses
>>> newlen to adjust uh->check. If the formula for check is fixed, newlen is
>>> assigned but never used before the loop, and newlen is overwritten after
>>> the loop. This makes msslen not really necessary, as we can reuse
>>> newlen, if we don't adjust mss before. The adjustment of mss can be
>>> simply dropped, because mss is not used anywhere else below.
>>>
>>> This brings us back to one variable, drops an unneeded arithmetic for
>>> mss, and fixes the UDP checksum.
>>>
>>> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
>>> Cc: Gal Pressman <gal@nvidia.com>
>>> Reviewed-by: Willem de Bruijn <willemb@google.com>
>>
>> Heads up, this is going to conflict with this fix:
>> https://lore.kernel.org/netdev/20260513074349.2152146-1-gal@nvidia.com/
> 
> Thanks for the heads up! When I submitted mine, your patch wasn't on the
> list yet, so it's rather the other way around :). Anyway, let's combine
> our efforts, since we are fixing different aspects of the same area of
> code. I commented on your patch and suggested to base it on top of mine
> to avoid creating a new bug with the checksum. If my series doesn't get
> merged in this iteration, feel free to cherry-pick this commit, it's
> pretty much independent.

Right, but the fix goes to net.

