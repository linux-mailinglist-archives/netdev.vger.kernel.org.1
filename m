Return-Path: <netdev+bounces-265944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDw/BB3dr2kzdAIAu9opvQ
	(envelope-from <netdev+bounces-265944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:58:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9CB247BE5
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AD9A307C24E
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF75D42E01E;
	Tue, 10 Mar 2026 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b3atzCN7"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1CA3F23AF;
	Tue, 10 Mar 2026 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132754; cv=fail; b=stT7t1SSixQOU1DMymZYbxxpruCg6rA710VOQWikMVaLC/FJ27dfpU4pjyEKgW0Bg7sF1nHvJBDpiKRjjQac/9VTIHMx7H3nzJceRRLuWV/+K959MDCs+jE781/EjBcM+oOkTKiM5sqfWtGtVlcFN/yy5CGe6k5nzxoaaDR6LF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132754; c=relaxed/simple;
	bh=THpqDi7fnjnH1yzc/5CxI7CoPcpe5Qb7zj8g2cNwAu8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IXylT2L81BdDKvg7w9Io78P3I5PEi4DCMvLXVthv+pT5cPcBDSUhentPu9QfowxABYSYzS6x4D1PQNo9HkY7y4diapU6KDCliUnopNXwbPlYXTKkOngaYFYSBCViIkMFJahfqOgi7cc4h7tYG4N/jD6ReztO5X06uh7HOJZJsYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b3atzCN7; arc=fail smtp.client-ip=40.107.209.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXVaJVCzNMDHchARpuQqs6je4ARDUvLo8/fquE6HNHdnrrZ3M01ItECRYY8NJvUcQIfQiZDYwDB+7gbYYWs7Iomom6hF4JUPl3bzwtgImN4hEwTogaG3OixtQeub+Nuxzg3mBlYT4u5+1q7cvwg9pZu+BAVYM7hH23r+1AG7IdSS0G50mes1Lp/84Kk0FHxY6u9AxIpioOHKvUzyUVtD29Kv2oL+lAToZlmsl5Y/pH+WclSCi/K1TNd33aKwn0r6z7zd3/2d/uCgXzMRdyJ/fgtZYobQKqeUAxON2mijD+IhylRt25TRYmYv3julx75Ku6GWI45drfO8bHqvkdWX4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOwNli4ZgiZiIVTQHPQSbugiRBoADJi66357GhXAR9U=;
 b=YkkgtHQ9YtFSsE/Wk4Hd2wZsTJ3p9d3PnY2C1jgM5TlrLFBIqy4x7crgF0iOBv0GzlHy0/j7NOFYtGbrEAqiNtZ5SzUf5WrzgZoicxRCpV77zwtO43ZMsaNiQ3Qf/S8iaFU+bDPdGEfW8LOUgmfpxlvBZ18D8jT3P3BLgAWRmAgUX/Grqn8Cp3ZxhLhKJJ8p9jOkEXsibDbaedpuWHywJ+2q4QMDmdHC3iQJBlQ2/yNsV4MclKChHuzoyUaSr0S0FcmEBUE6B3778Jm0xheq0TTQ/JYKAcY5fQPE/kq2i8yNSEZ39C7mc+v3Xf8u3R+zYEgJ5a9GvwTrVCWce3aAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOwNli4ZgiZiIVTQHPQSbugiRBoADJi66357GhXAR9U=;
 b=b3atzCN7mVJe/z2WwtfXhsLcVGnJdDm1rVxmekHfMNJyNeNjObjmTgjXMmmyzOpO/uzmYAtILzXsjiKUjBaPfAqVMewaQkJOCslXjWt9V8WlvhVFR4N3Ce/XM9njsnPvO2X+84t5gLqfEI2u4Y4/KyZR6N0CkkIRGNpPv9kw6kybz88ASNWIRtmDUP18knZjO4iHRctL6JyCESe6VL4iqbIRJVMswgKG0+SWhSuZZWBEYg2eOdc2uKJDZ2vzSGFNPn1e7XMauRZxenjZwOuIufKGO4BO3p/JuxbvrxGX0bcewF8yuxxV51o+dTfFTV53FkDCVeBc/Z0C4LBOHVC+Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 08:52:30 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%4]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 08:52:30 +0000
Message-ID: <3b8299b1-68c2-4bd1-b10a-1d8933ae23a8@nvidia.com>
Date: Tue, 10 Mar 2026 10:52:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] selftests: net: fix cmd.process() timeout
 handling
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Breno Leitao <leitao@debian.org>, David Wei <dw@davidwei.uk>,
 linux-kselftest@vger.kernel.org
References: <20260308192126.2490631-1-gal@nvidia.com>
 <20260309194008.10f24ba9@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260309194008.10f24ba9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0444.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::6) To DM4PR12MB5248.namprd12.prod.outlook.com
 (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: c89a9b7e-f0ae-43d2-4b13-08de7e825ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	6E3GaTir65ycL/CPC7EA9WCtk4pomxfF0m4/MYOyPb2KRgtB/XlqCv+XtVcDvAJOJBOwVAQmSymQ7CnFjKklYDRytxTSt2ik48Ppo9b8Z3nHmtg1jog6Yjf+P0udC6D7fNDftY+OOMFPXWW6OXN3Ntar+YhyFZUwolc5VoKmmcnKri2kddMvDNkezOu1oNCI0vZPRT4ipoyImcXC3Y8LLk9YQX7sb91KX/KGN5j7N6P/mXqSRCl0yW2cCZfOBK2okB1Ms0/P8PhBvzZlcmMy8jHw4lGbt2Jn3T05zFmB9/X+YvaQ7OM7a1cbz6HCzEfxmHH29/E+pndan6ctMgxrKltVFJYJUPBRrbKIht96yoJfOEnHV0xusO96c51b8GD0Ak+cTp08raHGj/pXU3GQ01VcY2O9kxVVEZ4vTgNt51uE+NFhUHKXv3FZEbHM6Gl4sj92LKWO4CZtsoopzBBEEX4eAyEt0KPslmM2WKcE2iCNQ0DvqKM7n4QYAxnazM48heNxBdzQ0cBqo5UKhoCkrMmYr4474E1TF7zrAE3xS2AGPP78+CLUyPEzAqV9uVDeeCAEmca2Yc+hRzLtDK7Pr5xEo7cahaIX6HcY2EJwXVCL8KEH9Dg3n+1U/UyYda4bc1oBmweAR0EKbNo2be9oRDbFSbNxqwKMhYPLGnzHpgSK1hX6pyHWL93UJLJkkZyUWIeJDfm/aB6lHcLDjcFkrIdm77llOmIzQ1g0Cv9ging=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ME9qbEp5UjdVa082djhQYVJqOSt2dHBOSmNlSzJXeHZleERJMElFSTFtbkRv?=
 =?utf-8?B?QmJ1MHhsTExHWE1MSCtpbnQzN2hlMzhnSFpaWVRlN0pVaXZiSUtjZ3k5UVEr?=
 =?utf-8?B?NXFwTFpYdUd5VkUxcE5ZbnIrbm9UR21kd0x1UkhTS29VWUtoSWFlNE4wR2tU?=
 =?utf-8?B?L2VCY3M1emVZSGx5N0lQa0pwUzFGNTJNUktCYkhBV3hHejRBSlFQRHlkalhY?=
 =?utf-8?B?RTFDUUFnZ2FpTHlGdmpzNGZhYkFOTitOVlM0WDQrWTBBMVpWUnZGQ0QvM0Fn?=
 =?utf-8?B?aFduMXZnaDdnaWdSaS8vaHNTWUpYbDBiL0lMTHJkaGY4VzNoanBJQi84SmRB?=
 =?utf-8?B?cldBUThQVGErYllYOFZ0K3h5YllGb3pvQjViMnJGRkNoeDljd3R4aFdWR2Yx?=
 =?utf-8?B?VU9WalFWaFBGbkZyalBhMCtySUxGK0NuU2lpeS9xUDBxNUZDYmxQVXVaalNk?=
 =?utf-8?B?V1dRaWRzTDN0RXNCVjZqTFluK0djNW8yeUhIWkpHZUp6VTJTeFpnMVFUdk5M?=
 =?utf-8?B?WEVCVUlUOTNKYlJRbmloNXp6YTdXUWJDVU8xc2tGQW1YWW5ycFZlMmpFNTZE?=
 =?utf-8?B?WnJWOUpvRnByd2hHWXoySk5tNXNCdFJCUjFRRkVVZWN2QTRQcXA2RG9OWWNu?=
 =?utf-8?B?dVA2aVhmTSs1d2xuUUtTTmk0WGp5NVhZTE1XS3FKOUpzNG9qNmdVNmR3UXha?=
 =?utf-8?B?ZWdKSXhKNEh6QUVabS82N0txS3BST2ttVU1wbmlOcEJ5UHhDNDlzZTl2czJk?=
 =?utf-8?B?aHc1ejdDMldHZXFzb1NSQi9VMjI4OHB0VWVVU0hxZXB1N0tIN1BEV0NZRzRH?=
 =?utf-8?B?RXdySS9ORGpZa0lXRytUMjRCRm9LUW5QdElhYXJSQmVGVEZ3VzNiQ1FxeDNh?=
 =?utf-8?B?NjN2dmxEWm1YT3BsR0c4aGJsblRuMWNzRTB4bUhIN2V4SUpjVExpdFREQklE?=
 =?utf-8?B?L1k1ZHJWSmk0VnkzejBUYzRQV1ZhK0VHSGoxUW4yalU1ODArQ1JqNGVIVG5j?=
 =?utf-8?B?Q2w2WmFOVHRsOFJ5UkJORjVTcTM3dElsd3FGQ3ZmcjIrelZqdGgzSzRKTWV5?=
 =?utf-8?B?N2RFU0FOYUZZVkJEUDlSdXhtNS9HamdFQTJhRXlEbE1QSFMycWw1UHpFdnNS?=
 =?utf-8?B?M09MK0ZNbFVJallGSEVsak1WTkRnT1ZoMG5jR1F5d3RxMUhzYWcrME1MUkZO?=
 =?utf-8?B?QWY3dXM3L3cxK3RiVnE5Q2pyeW9qUnVnMGMxQy9DSjhVTG5OL2p1ZHgzdVZ4?=
 =?utf-8?B?WGRCVWlwVFA1Z0tGMnE2aGFFcWhyTmlobEdpaWJHQmRPL2VXQVdkWDd5NlVO?=
 =?utf-8?B?TWRYVnBMOFQwYnVpK3pIcUNDZmpLaHRQOWhka3RuY1RsMHc2WkNZckJyb2Vv?=
 =?utf-8?B?QU81Ym5qc2xBZWF4K0FJSDVFcGU5T1FDME44WVV4LytqU3o5eWNBNUFjeDNi?=
 =?utf-8?B?Nmxyd0Z1d0JPMnRzTG14NVYwT0ZaclVNOUdnbWRMdU9PVUVLdVUrRHJrOHY2?=
 =?utf-8?B?TlFJUi9qd2JHSHIrTWl5bzQyZnVtalg5Z3EwZVoxSEU1OE9aQWpTamFjbnE1?=
 =?utf-8?B?QnZPbEFFSGFIL1VmckUxd0ltcXZkNitoV1VVMUZNaE1LclUxT0JOcHp4aWw5?=
 =?utf-8?B?WXZLRWtIOGVlUmp5TVNjRWduSUhtZWpkOSt5M2IwMmE3RVZSekxPOGsyM1ZU?=
 =?utf-8?B?bTJnQXY0OVNJdkpSZXN0bWwrd3J1TmpuM0VSWjF5Z25SSm9ERjVBd0tDRzRm?=
 =?utf-8?B?TWpUYXFpT3Y5eERicWdzS0ZpcWMvYXlJYW1RK3Y0YXhYYUZVU0M2dmVBUnRw?=
 =?utf-8?B?NkZSOUFoSnI5WU1CZDE3LzVKeWUxYzJBWUNvWHN6eFJjeVJ2d2pLWVBPYUZR?=
 =?utf-8?B?Y0hMWFFuZ3V5emFxN2JOQUVSa3ExVmVIb25iQWk4enphTC9BTjVSbGFoK09r?=
 =?utf-8?B?RmMrTXBnK2VRYjFRb1Qzbi9QUnZwbzRzN3cxNm9pT0tJRHF1M2pqelhDcnZH?=
 =?utf-8?B?alN6NjVhazkwRUFJNzNLNU55d1VJZHY3bysrZGt2ZXFzUGlsTEswbFMyTVBz?=
 =?utf-8?B?a3VxWC8vSHZIU2N2TFB0c2hKYk1vb0FJMnU4U0F6WXVYajBzSmc0UTJTRUNT?=
 =?utf-8?B?eU5DaGZZUnQvWVhLVldYSHpyR3VDVzkyTmdsRTlpbEpFS2tEYkVFdXN4UmhL?=
 =?utf-8?B?dnFvRGdJbnNCMFJ6TDE3VndabllFcDlKTzRCMEFBWC9zS1Bsa0tSVmE2ZzBC?=
 =?utf-8?B?MVVWU2RYN01ObDZYMjFtck9DbnFvTms3TnNSTFY5WlUwbnpGL3VmOXZveE1j?=
 =?utf-8?Q?CGAeleeRd9nGMugriA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89a9b7e-f0ae-43d2-4b13-08de7e825ce7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 08:52:30.3853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fA5czcfKgOB2Pd3d5s9h1O6ZiZYws90p6cnwr49+PeFy+y49C6qsriqZoDKvTMWQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
X-Rspamd-Queue-Id: 5F9CB247BE5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265944-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Action: no action

On 10/03/2026 4:40, Jakub Kicinski wrote:
> On Sun, 8 Mar 2026 21:21:24 +0200 Gal Pressman wrote:
>> Pass the timeout argument correctly in cmd.process().
>> As Jakub noted, fixing the timeout broke the bpftrace() command in
>> netpoll_basic.py, so fix it first.
> 
> patchwork says this didn't get selftest-ed which usually means there's
> going to be a conflict with net-next. Can you respin this against
> net-next? 

I'm not seeing any conflicts, but sure, will resubmit to net-next.

