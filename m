Return-Path: <netdev+bounces-288723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNoUC42mCWqxjQQAu9opvQ
	(envelope-from <netdev+bounces-288723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 13:29:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF585560BA1
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 13:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B59FA302D0AB
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 11:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9CA35F611;
	Sun, 17 May 2026 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qyuaUO66"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011005.outbound.protection.outlook.com [52.101.57.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A17C361667;
	Sun, 17 May 2026 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779017250; cv=fail; b=FI6tAw87hg2o9s5KNXRoUIlyyx+GRoxuS43dkHax4tMRR0mebSDg25VIDu4LjIwV2NCKCjWxL5EwsPPTTW/9EKTpDICDZlyWmty2VLuc5G3ww1h9XrDEh8MVwcebKtTl5Ngs5ObdFcHjEvVPcw522mPuBJDKoDZ/AVdwwyViIMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779017250; c=relaxed/simple;
	bh=AcpU6J2kjZv44DTXiXJPvEfXm/yIkt7/9SgC6b18Qwo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E7inAV2uT6vqAxp7xrpvTocFettizVdmcsXXPtw9C5lCcxM/aZGjQ1mHAVyGxq0A9gvlDSA2GFe3P+gLO9eNJ+utm1OAdh+HfMvZww56MwHIdgxdWrxO9SLXQg8QX+sMZse125H9U5Gt+x1Y88lkAy8wUbvRymV+KChnUFlFJz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qyuaUO66; arc=fail smtp.client-ip=52.101.57.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYKdyXaIXVGNqSOo9ByvMgq30ha6oHd2NV+RnIFvsbfLC+Rk8Y6gM7asCWyPSsovQKOslnVEKHD04dn4A/jLBNqZpeXplcd49NMpf6bWsSVBkBDhzgeh5JTbApf+rnBiOLz3h4LYH3/8xYhp9MgxNbFZ0UH9JcEnFDV1j2m8iTVHTGJtFoddoxN+LACD30ovm+AOi6Xov8oGC3pCY/6BmdmzPOv8IbauMNdsEVQ8AQF6qjq28nxIfvfDC9sQwj/gy8BHPbKoWmGZXbZCbOiReHKG8LeORdfAWpSAqeKSB9wdLtkAlOXAHlq4/bQ7j+fzh8VCyWGLQPyTXHm0oV+tAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8MXiYSjsezHTTnoKMIxBQH5qg+qHU0Qv+sXpilipno=;
 b=cjX54pDcu6Kycc0S4lrzDtyso9jw9qbn7BskyvZBl2fwimDnDJedhkmOZMhCQ03jh/PRSdBpQaNII2lrVGtyqG81NzlV/M7xgQKo91DEYm2MA82Y6C6K37w9Cz/zykS+kJcBM7ghZvPVpCJgM+wx/jnb8Xn6ywaelmSb3NWaQeO6DB5w3/Ts7Y0AVvmVqCpL/1ri7H21ADZs5dUIWnUGQx3nxFPGT/9n5M9DeL2pbgdmQ5ooN2Asr6CasT9YaUXZ2r0eLW5EsbBBa3or4Js0/Oi0Kzi5BnknvW2t8EpyBkFPCRTTtcpsaerSYP3lYDdn6l9ZZY+Mwy/ygO8shi9bRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8MXiYSjsezHTTnoKMIxBQH5qg+qHU0Qv+sXpilipno=;
 b=qyuaUO66/urdnzo5RXsJLVmHb9g+YcR/jo0d9TP1WGHVabkmuj38uxA6jKNVjYrtWysF/H0mqVCRD7vTL0bOBvztas9aqb5snjfgvHSEwHYjHG3heTNd77V/FiAx5LS0Ps+DA5ixbRkZZolyAs0hKXlOOZM/9z7dz19gBuCtKmktp7Cq+9PQ2gKxGVQkDtR4xYR2Qt/MkGY4iV9SbXpqqeLZ1I6OHWgnuBPr94+E8nJOMvurOkIqyByzZ4kjdbF6OMWHnaNuKmKjIwLP8ETsESpv/5mTbxY7aJrh2deGk1IOs2xTdmeFfmIlOB1sf33D6U9rQDkuzw8cGd0Dkrrykg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19)
 by DS2PR12MB9821.namprd12.prod.outlook.com (2603:10b6:8:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Sun, 17 May
 2026 11:27:24 +0000
Received: from MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587]) by MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587%5]) with mapi id 15.21.0025.020; Sun, 17 May 2026
 11:27:24 +0000
Message-ID: <aa818076-6e5a-4b61-bc7f-0bfe3907fe2f@nvidia.com>
Date: Sun, 17 May 2026 14:27:15 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: net: Fix checksums in xdp_native
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Mohsin Bashir
 <mohsin.bashr@gmail.com>, Amery Hung <ameryhung@gmail.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20260513072355.1083381-1-noren@nvidia.com>
 <20260514183832.5ef205c1@kernel.org>
Content-Language: en-US
From: Nimrod Oren <noren@nvidia.com>
In-Reply-To: <20260514183832.5ef205c1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::22) To MW4PR12MB6802.namprd12.prod.outlook.com
 (2603:10b6:303:20f::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6802:EE_|DS2PR12MB9821:EE_
X-MS-Office365-Filtering-Correlation-Id: 229ecbd3-5f30-4603-95f3-08deb4074475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|11063799003|4143699003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JTVlxqZJaQSQroOvNmyvagqVFK75d84ftyMJbJs4SacQxnBo8EZpRtOvnw9P2NeRhgos/6mFp8ZhDl2oJCiuTtcNsY/z4X8yJ2yeYQfLL3kyiP3olhU5f1+Fj+2aG85wXehScX0dj4TLC2s5BBRyT/K/A3XRZqF0qOqOyz/WYonw2ym0odYJuaSuDeiXWfgjaTZY8/WetAZZ71CUkkN2JvqgBf4i7ow7/sqtJwbLtrpziW4UypiAySZ1TbYtPJz5Wi9B3JcGZewyarPJkctl2yMB4GGurleh/a+KJcn982KKS2IZe8U+6h4Lbbjx7VTGvOCGijii/2DemaZs1xSl6oDIf8BiXwGFIKSOpl1W/Fc40xTeFd7WKt85zsJB0euK6kx+z64vtbyrAzkG/5I4SnsYFK97EKlaXPK27Y85gxE/g7Y8OCfIfJS4vd4k26Ev+v0+gpoPEY+W2cCDxXgwPFSTX3BbFeEUTZ+51TIF53AKYEcz3yQYesznlvFhkLeN15YoTrhc1Y0mqF4GOuWxAq+OaVrcLbM11ekajDJmK9XCDfyEbEHTSWjBip+UyhQPP6x89n1TkpH95g/Ct7YcjljY+C+OQBCGFwsx2vuwJLEhMVgfQVzPFr5ruewlyWr9yENezPf9CQk3/PpYMmYT/P+NVJvbD//1uCZf1Styc/csot+PtDDc+lmsEBJBxpBP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(11063799003)(4143699003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTJUVkE2Mlo4VkhCcXlUNUJIbmtoVFp4SUlrQms1Mm8rWStJN1BHNjF5UFNB?=
 =?utf-8?B?bG1nWlBnR01KWXpEZlJhQWNvdERRdTdlRmdGNWZITjhPZ0g4RnNKREcyR1lX?=
 =?utf-8?B?UUtQcVB2VjBzamxCTVZncFZudG1VamFUY3FhbFIvSFNOdHFJbml4d21lNFRX?=
 =?utf-8?B?Z2hwcEVkaHNzeHc2OFI0dVphQ1RYSzYxTGdSM3hYWnZvNU5vZnZOSHNQa0RM?=
 =?utf-8?B?Nk5lbDNQRFVQMHFtL3JNWW5xRU1aSFJETlZpMEE4dllEdnhmUll4N3RLclNh?=
 =?utf-8?B?ZVE4ckJnUFZjL3ZWbm9jVzBuWC9zOTFxVS81Skw5Uzlwb1B4Mktqa3gwTTNo?=
 =?utf-8?B?Z1NWdnB0SnJxVyttNEJ5WjBHaXgrVmtGTHZ2MWF5TURSZWkwR2ZjM0pSc1JF?=
 =?utf-8?B?MUNRaGtPZGNyT01XVTRRQjNYZ0JXYWJ5SkJnMGxsZm01THdOdUpQUnB5YVFN?=
 =?utf-8?B?MllHb2xHajFNY0FwS3JFbzFMVDBueGJuS2N5QXBNNFJwelkwSElZUm83MFVl?=
 =?utf-8?B?WGFMMzBmOFBWZDJkdjVPaEljc3ZYRGpwaHlRNW8vVy9MOGtNR255bTlIVkF4?=
 =?utf-8?B?bDZWMllqNEJGdGY5WDlqWW9sdUZ2TVhiV1FiRXhZZElIQjMyM08xb0h5NDFi?=
 =?utf-8?B?azNtYUVFeGlzODVQWXBvN2M2TFpBa2lkRis1SXI5SFNIdjRpQkc1NDBEV2NM?=
 =?utf-8?B?TkVHbE4yZ0tOMkJTWDlxZUFhbTBNencvYVQ0Zmw2cjFmOFJ1VmpuWEZ6REJ3?=
 =?utf-8?B?cnloN2I4Ujdzb2dvemxETW1KZ2xuQjgxSmVHWG42UXJ2RlBsUnYyaHJ4aEF6?=
 =?utf-8?B?UnNHZlYrdzUzZ2FsaGhwbEF5Z0V1RFBDZ3ZXZ3BqM0dMQk4xNWpWNTNZS01n?=
 =?utf-8?B?M1JocTVyVlMzbzBuL3o5dmNtZ2JUMFJsUnBRVzVYaTNOZVV4Tm9kRHhHQUJB?=
 =?utf-8?B?bi8xVmEvL1c4V1dnOXlra2ZpNEk3K1VNMm4vd2ZDdzYveGh0ZjMwaTR5NnB0?=
 =?utf-8?B?cFFXSFV6Q0drSzl2VXJ5djcraVo5SWVPUHZ3SmVOYkNZdjNvQVdjUk1HcG40?=
 =?utf-8?B?cmM2ZVducTF5NnlhamUwSjQ5SllGN25kUDA2YXZaZnhKT1IyU3dJWDl2RzVV?=
 =?utf-8?B?SzBuUHJ5Nkx3Q2RoaDVLRU5idmE4UlV0SVc2aGsvWjlLSEs2S1dHUFFpbVFZ?=
 =?utf-8?B?Z3VDRjN4cWhBMnY4UVU5ZUFueTZqL0pGTU16R0UwMVYwYUJObittZlMzTWIz?=
 =?utf-8?B?c0czWnB5Q3FrczRnNFcxVUZkcGtwbDRrcm15amIyUlpLS1MvM0FIZXEyRUdo?=
 =?utf-8?B?UVJab2lqZEVYV3pmcDhkeHNiUnVDWFQwU0VJNjh5eGtmWXV4dzJBV0NqWFVy?=
 =?utf-8?B?M0ZUQnFjMExYMURDS3JSU3NTQXQ1d05YQlVNMVYzVjMyQVorbzQ2Y3cyRFFy?=
 =?utf-8?B?QlFVYWRxSHNKZmk2YytESFd3cVZuSEJyTThEdGhMWDIzWmFKMTAyVURtREFS?=
 =?utf-8?B?VTNMYmhZZkdoekFXL3RZUmRjakQwaG9ZQzk3eFdYeWJNRENPZHBtaEptWkJW?=
 =?utf-8?B?ekxMbGpDVG5UbTJDUFQ4SGNvcmh3THRHZ3hOWVAvM29oOXFNWkcxQk1LNTdQ?=
 =?utf-8?B?MEExN3FSU3hRakp5VFViZnZwRGFxUjM4Y2lOZThoN1JEQkdkUzBMUFRqdW9Q?=
 =?utf-8?B?cTkwWlZOcndDdVdqbytDcllLNmhTcXhJSjhGVGVXZkdFMmdERDRvaDhNd1pD?=
 =?utf-8?B?Znd3QUlzSmlNaE9oSEFJV044NXVITm5Rc3RXTGVRUkd1a2NtWU9jU3NmWXpO?=
 =?utf-8?B?STEyTFV6RjRSdjYxT1VkTnhaSk9YTXVaeHQxY1hlTjduMDdRL25uaFdNbW5U?=
 =?utf-8?B?WGFtWllxSk5YNmJIUUV4N1NKZjR1UzBNNzc1NEtaaHFhSUE2SWJlOS9HTUh4?=
 =?utf-8?B?d1BCMVAwQUVwelhjV0ZlNDZPelpXUjc0V1hPOEE5SmJESjBmOTZGZlN6Wlp2?=
 =?utf-8?B?aGVPVU5BVVFqeEQ0eVE4OUR6aVAxc2ZyU1R2VWQ2a1J0SG5OQ25iUmNkU09x?=
 =?utf-8?B?SnRuM2REN0ZONmFvTlgxamE5RnRkMytYSFNrcjJFV3Q4MnBSREE5T0V3alBm?=
 =?utf-8?B?dDhWOGVNVnUrVGFHREdXaENDVUZuSzVGTG5vb0FJM1ZmdzN2MzNVcFFndFBx?=
 =?utf-8?B?QWpPNmIyTVovOS9GZkEwUW9kdjlNQVAzVURnLzRmaERLSlJpYk0yVkFHWHNT?=
 =?utf-8?B?ME1pZ1ZldmZ2ZDNiV1o0c1NWNmI2RUxjV3NneWF2ZXdBYWpHSlkrNnB3U2dT?=
 =?utf-8?Q?WRLTg9VAgfX/yYVXHa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229ecbd3-5f30-4603-95f3-08deb4074475
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 11:27:24.5388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iO3Tx6WA5LZen9RANFJXuGV+oikswN8APc2ix/3WIzDHy1TdUcvjz19AZIVCHEjiHuAxIi85V7lozZkFvLNS8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9821
X-Rspamd-Queue-Id: BF585560BA1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288723-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noren@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action



On 15/05/2026 4:38, Jakub Kicinski wrote:
> On Wed, 13 May 2026 10:23:55 +0300 Nimrod Oren wrote:
>> Data adjustment cases failed with "Data exchange failed" when using IPv4
>> because the program did not update the IP and UDP checksums in the IPv4
>> branch. The issue was masked when both IPv4 and IPv6 were configured,
>> since the test harness prefers IPv6.
> 
> Oops, maybe we should run against both IP version after all?

I can send a follow-up to run all xdp.py cases against both IP versions
when both are configured. Or are you suggesting this as a broader change
for all drivers/net/*.py selftests?


