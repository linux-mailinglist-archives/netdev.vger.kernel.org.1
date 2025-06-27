Return-Path: <netdev+bounces-201779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E51AEB03F
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 09:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8316516B877
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 07:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E531221265;
	Fri, 27 Jun 2025 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="J6bvy+gy"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010022.outbound.protection.outlook.com [52.101.69.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1FE21E08A
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751009971; cv=fail; b=Nm0s9Ig3ktxU6ozSN389AkLCEzV3X4To+EuG6Q386vbnGuQHzhrOPuy1Cln/I+I9qdifiAH+OWqbr2qFFGa7L7wL9FltOzUiDWCHCDHtqv/XpxzShX+AdI03ZOjeA+NIJBrehBoiKDAgrHzsRwHQKC9czMwbDUX9M4aJfiWZP64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751009971; c=relaxed/simple;
	bh=6/NSwjtiph9Wtd16tUyDSZK8kWqq/zCNVxaYyoor4ao=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DMQmkHPfcyd24IOZmHTmHMacjg2G1zAMHfOLIhngQzPjxVc5rsEZKC0ygTQd+XvUrM1u+Az/F2pQLEB4aHSnHwPKR+kzLKbxEzXGis0sL521/bV0gzU4U26+KRhm4QlFxsa0FRb59rwko0k6+52wCnd3RrcdXE9D6FqsrvdNBwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=J6bvy+gy; arc=fail smtp.client-ip=52.101.69.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8mNKI1UhJLOaBuZ/H47ZnLH6OcuXHBjfYsHDzGJ8iEfZDxDgz8lM3T/R6TbDKotUut3JZyAOI8q0lNAQd/e0p/rHsmbo5ej87IcknFsmNV9vfPP87qF8cs0pSdEcJfxxAf9a7FITfESYnTCufUcxanghdomqzV22XeSZGRMaNCriERP4N+FKJfr0RaMCdyJw2RVqQ0fBsBxn3+35M+MM0M54A0Y7TCtJjpA6yFV1FdCSCtPcqZTOTbIj60QYWVYP7ICOpI1tj4s6NUsLjG4iSDMTGumCVaDEnOa6oEEEM1nU6LbvYxSEHth9utRKwJqIUCd1GQ01CRXO23ht/o1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swdFnGkMhLA/fxMBjbB1n7OaPaX4/bgAK3IZpTHzpVY=;
 b=gQvdI+ud1qP9qWC4ADZxHpvF7yxtEAFP7FpOi/knYnHWsxbdOSPX+uNcXWza+nRvoaQeWCAFbufNah3wPikb0y9stktEmYw9ue1Vndt8s7UcdKk1vdX7E+wyBNq4Z7l7QjT5rDginaW9PUWYognTpYoYzr0/zkZ/q5eksSxxNRhtFk0vV8QY9D29MpVQDWi6Qpey7icxvZeEGFeu8TDjKMf4nA6EZYEWqcS6y7cuQJeSuLetfo//Gd/+w4JChwJDa148b+oG3x2+whwiCg2MCkFasvH6Tp61XrW2mlwMS/d/JzTo9Mp8mxDgR3kAYriwtpCi6e+DQRf3Uo24SUe8kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swdFnGkMhLA/fxMBjbB1n7OaPaX4/bgAK3IZpTHzpVY=;
 b=J6bvy+gyNZ96zBuBVPzm1e7+7IRbsIbTDoNE6j9IhdZW8Ia8rgXeNq5kmSZMtJDE1G6cFO4kz1uxEFFvGMo7GIqGzY1Mj0nrmqkARJgQDtqlxyzmFfM5ZX+VChLQV/ZqYmOlLoe1dIbs4GeYA7A/int6SfR9W+zhfSYsHqhzKeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com (2603:10a6:10:488::13)
 by DB9PR02MB8276.eurprd02.prod.outlook.com (2603:10a6:10:390::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 07:39:25 +0000
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d]) by DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d%4]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 07:39:25 +0000
Message-ID: <779dccd7-0573-43d1-b2f3-cf9efdc76e06@axis.com>
Date: Fri, 27 Jun 2025 09:39:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: phy: MII-Lite PHY interface mode
To: netdev <netdev@vger.kernel.org>
References: <20250626115619.3659443-1-kamilh@axis.com>
 <20250626115619.3659443-2-kamilh@axis.com>
 <aF1E2G69T4IlkCl9@shell.armlinux.org.uk>
Content-Language: en-US
From: =?UTF-8?B?S2FtaWwgSG9yw6FrICgyTik=?= <kamilh@axis.com>
In-Reply-To: <aF1E2G69T4IlkCl9@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0444.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::6) To DB5PR02MB10093.eurprd02.prod.outlook.com
 (2603:10a6:10:488::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR02MB10093:EE_|DB9PR02MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 8149cb8e-55f5-4985-ae54-08ddb54dbd8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlpkQVAvOXZ3cHB0aG1lQkhNUnJqU085VW1XYXNXUGxPZGdyNHdnS3haa0VU?=
 =?utf-8?B?TDNrUWtVRVlGeTl6YWdJcm5MSHlXdGJzSWRvRjltZ3pKd1A3aFFhQi9waGhD?=
 =?utf-8?B?blk4U0xmMWRJS1ZFMzVhN3F5VzE0RzlhTEwvUXF3UWpka2VHaGdhajZoSUkz?=
 =?utf-8?B?bStpQXdRcStwU0dSamt0T09KczM4SjNGY28vZ3c1VXAzbmlORmZGRHp2VUhF?=
 =?utf-8?B?UEgza3JDQmI1aVlWRXF5Tk1tN1c2ZDZlaWRFQkxsem94YW9iY0YwRFJKNlp1?=
 =?utf-8?B?VkJmWDdXUEdSMEpHZE1mb0RXeDZzUU1XcE4rSEJrazVPeEtPWmVJdzFUaThq?=
 =?utf-8?B?VVY5cktFMzZlVXN4UTl4V0F1TXowNjJCWFRNa3FqVmwxSlYyMW53YmVKdTJG?=
 =?utf-8?B?WFJaMlQ4N0VUbUVTMGRIMGx5Sk5CT1J5TDUvdHhQdWpEN2FUU2lybFhaUGNV?=
 =?utf-8?B?WUs3aU1nMWMvMERBYjUycjNvRGUwSjRibXkrT05aTmUxYnA3eFUzbXNldkZM?=
 =?utf-8?B?MmpYSU5QK0twVlJqcHB0Zk9LWC82SjlodFR5U0ZjSUJUamxvZ3R1d3VEaXBP?=
 =?utf-8?B?WlBiN2hlOERjTTZJQnkxSDcySzNaUjlQelN6dG9EdFp2TXNoeEpvMW9nSXRa?=
 =?utf-8?B?NS9DTFhncnBTUm43dkg3Skg5VG50US9kdSs3Q1ZzR0VaZnB0cjJhNGZaUHRD?=
 =?utf-8?B?WkQxQml3azdNRzk1VWRBYWgxUkJpbysxdjRabVZxVUpYcGliQVBPRWxsKzJV?=
 =?utf-8?B?WjJ4K0p0OG1qTzU3aE1mMHo3SVZXWWhhRUU2WkFZZ2tjd25XR1ZleWluYVNU?=
 =?utf-8?B?UmljRC9oZWpNTnMzVkI4WHRDQ3pqNzVHUjJHUjN1cEUxbXh2M3k1ejA2RnJW?=
 =?utf-8?B?ajBJcWoyZHRpZmFhT2Vrb0d6M3ZIclBBaDFub1Noc2RFUG42N29TVStqdDZy?=
 =?utf-8?B?SnNxTk1nWmg5UzQwY1V6eEk2TkFoUkhVd21wSENzWlFsNGh0OVUyMU1rQnZC?=
 =?utf-8?B?YUxySW5pTWRtci9FN2xVOEZSeGthbzN1VHc3bTdVK0NFK1dvZm04dXpmU2I1?=
 =?utf-8?B?S2RYYXhvaHEvUGNIZ3NkYlpQejhiV0Y3b3lMYU1CWDdWUUh1Ui9NemgvNURZ?=
 =?utf-8?B?VXE2eXJWYUVNNXZDWlkydFFIT2lHNmQwQlJPQWY4cWM5OVBLMXdqZjJMaDBz?=
 =?utf-8?B?SjlDVkpMS1VuQWROYWNaOFZYZkl4K1hlNFpTT1c2U2d5N3BneVBucVE3a21R?=
 =?utf-8?B?cHk0eHpqUkdDUitBRk5SbHVLZDZidXRqOU1qVDBjQ0x4Y09vaGtxUWJHMnlG?=
 =?utf-8?B?RnFlbFpNQllvV1hiKzhKd1oraW9hOUdhaFNKd0lWYTBUaWIxdXF1QmhpajZS?=
 =?utf-8?B?ZGNkekZFc0JlY0s3YkZyVFlTaEJrdTZoZ0VvcWtZRTJLdDQ5c203dDFrblk2?=
 =?utf-8?B?VHByTEoyd2tNcmJzTU80YnA1ZDY2czNHMWlDbUpMYVByNnRSd2lPWmppRFJs?=
 =?utf-8?B?VzlackFGVG1haEd4NnJNdUIwZ3AxTVFlR2VDRVhUZjZKeXEzMkh5bS9IMUY1?=
 =?utf-8?B?Z3lCeXdHOWxJakYvNEQxSnV5K3VleStRM3hGWi84NVpvZUZoL09ZTjNJVnhs?=
 =?utf-8?B?M05sMWhGTTRvdDRsRXh0TStpUTJlNWhPZEMwTzFIYlQzT1M0a2JjdTJULytj?=
 =?utf-8?B?dFY2TlRiR2FhcmtLVFA0bTAwbFhtWWRKcGE4WTYyNXYwU04zekRCN1hsWGtB?=
 =?utf-8?B?QTlOSmFVWDFKM0dPRERUS25hb3BzVFYxN21nWFZMTEFCL2dPRktxd2oyMFB2?=
 =?utf-8?B?R083WnNYUzVBS2tHanRWbzlMWFJjNTNRYXc1Nzk2NFNTdnlOUVpTUk1JcnhL?=
 =?utf-8?B?MzVrYXY5TUhGYUlGVXY5anArTWZkdEFBcjhWQ1djSmNHVkd0OVZuREloTE1a?=
 =?utf-8?Q?TbEuHG3fdJ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10093.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3ZrL3FmZ3djVFFlVTJkTkgzY1hlQXhuSzB1L3g2NlI1TGlIZlhZK3d3bzhJ?=
 =?utf-8?B?SCtjRmVCNUJ4ano0a3E3NzBCWTQyUThUSEFsa25HNzBPM05UVnFqUmQycEQz?=
 =?utf-8?B?V3JWM01KNXVOa0Qvd2I0dm42TXozaGVTbEtZU3p3dGgzVmFnSDdCMUlQcWtU?=
 =?utf-8?B?RHBiR0x5di9HUVBaNmFvYTNNMWdzN1pnSGN5QUV2UXk0V2lkU0k2eW5iVGt2?=
 =?utf-8?B?RHZtNkIrM2IyQU1Yd0tYWEtUc1RteEEyYWp1aHRjeGVYODNpRk1Bbk1HaDV0?=
 =?utf-8?B?bXd6ajllNEw0ZkZSVHN2S2d3cFpZV1FFSmVtSTRUQzVFQkl4U3pZTmpQZ1dU?=
 =?utf-8?B?c3BrYmNCVEVvVkUrdW9mS2VSSUpqdHZidXB3RFRSRm5mMFFJalcxWm5yY0U3?=
 =?utf-8?B?Yy9IYUVwOWRSMHRXeDRzanZCaTZhd2xONDRVNStVVUhxQ21xdFJRSFU1Ylcw?=
 =?utf-8?B?LzljWHk0cHFFVHlORktRN1ZsSVdFaElCK0YwNnZZazNDUnhZNGZCVWxOZ3pm?=
 =?utf-8?B?ZHRoSnl6WHlMTStHODhQY3U3N2JhRERMZVBidVIrTUdna1R2RWE5V25kdzVl?=
 =?utf-8?B?ejhWVzZzRFlCMFpieHVjeUdyL3BkMk9YbFZLb2pKT21Zc3czNTdGUjFMS1I2?=
 =?utf-8?B?d0E5SUtGWk1GWFhOckdiZlQxMEprdi9oQ2dvK1ZUd2M0VmlUYW5iZHMxVGJY?=
 =?utf-8?B?NjhXcnk2SVhyZG5QNDRxcDFQUVVReTk5NXRFTWtWWDhzdHNqbGp5N2Q3Um1B?=
 =?utf-8?B?N1E5RkxuZ25MNytoREUySll0dS94VVQrWWhtbktPeFczTDhZRGNGai9PMjZM?=
 =?utf-8?B?YTZSZkhic1Nhb0Mrclg1L2xOUGd3RjlCOUhDVXhINnVGNTIxSGJJUldmbkhx?=
 =?utf-8?B?eitjbjhCWW5hYWtvNUV2MmJFTmRZcDFPMkw1ZmQwWHZHL01RRFMvaTlnOHhw?=
 =?utf-8?B?ZWdzVGs3aDVkeVo4bUNoQVdRNzJranV1UUtzTExqMTZPK2ovMm50UXNDN04x?=
 =?utf-8?B?U2haRDBZWHg4WHhad3M3eUlwSy9NS3hBV2dXRGpZL204VlVVQk96aitqSTh4?=
 =?utf-8?B?Q2xCQWFibENzWDcwdWxkY3N2aXhKb0JIVzJKZ0cwWWtnQVYyZFNCNDF4ZTMv?=
 =?utf-8?B?Z09pUmhndGhiYVpNelZHb09ZS1IzVmFQU1Q0Zk82WTlwenhIdmxZZ2xYZ2Q2?=
 =?utf-8?B?OHcwNjVqVng2ZjNXTFNqRWNDN21FczlqS0hmZ1praFJyWWpsQ3hueE91Z0Uv?=
 =?utf-8?B?TFhKQmpjejg2MGVmM0N6blRRMGZwOXE1SHFpakgyV2FOQlZmZ0VJNklFd0xS?=
 =?utf-8?B?QWIybzFSRjRQTjkyTDA0NjkxK05yNm55T0lDU0JIbG1DVG5YMXhKTmU3MEwx?=
 =?utf-8?B?YURDWi9xZXdLSFRGeFdKaE1oS2d6R3NHTEZJOHd5azQ4VVFqaDBkUlQ1QWVs?=
 =?utf-8?B?aFVqQjF3R09VbGU5c2ZTWnh3aFIvckQ0QmwxanBtUmdoaE1WbkdjVWtPc2pF?=
 =?utf-8?B?ZFB3MkZJcmprVXdwQnpNN2JZTytWUlNGQzNZYjNSRWlNYW9OSE1LcSthOHlW?=
 =?utf-8?B?ODUxdDM4ZkRuS25TTmc2dHdQeE1KTzU5UmtncEtld1Q4Z0Exb0R1Z3AzYjVN?=
 =?utf-8?B?QnJkZTU3azgrY0RVcnZSd3ZJSFoxcXhzRkdGZ3J3M29EUjVIU3ZOTzNUOERm?=
 =?utf-8?B?RUpXUVZxTjZPQkVNUmpKYXQvVW1aTEk3SjNzZitNQkcrUHBMS1hPMytZWEZp?=
 =?utf-8?B?bk5DVWF5eG91ZzNoZndVWjJtU2xhRUVnWTVETmx1UlZTdlFFNzB6cklVQS9R?=
 =?utf-8?B?L2pteWROMlhEVmlKM0h2aDV4bWNwM090MklzN3BzS1gybzY5Q2g3dlhOZXgy?=
 =?utf-8?B?b043b3NFWGpYSEJLVnlrLzM3Tkp1TzVpYU9sSm16c3JveFZkRE1lMmlxcVpi?=
 =?utf-8?B?SHExbm5XNGRZVEgxb1lsMWpXYlpNOUU2b0xRRE9HTEU4b1AwWlhqVzBnMFhl?=
 =?utf-8?B?bmVBbFdQT3N2Nm5BN3VxVzJYUmNiUitWMmtlemNnaktqR1hjZ2xaRi9HSENo?=
 =?utf-8?B?VDgxVkpveXQwcllEbVZPdk1rbFlnWWhYWEttYlRrM2hxV01DOERvQ0oxL3hx?=
 =?utf-8?Q?CnEuj497USC9TkOREpUk51o9Z?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8149cb8e-55f5-4985-ae54-08ddb54dbd8f
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10093.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 07:39:25.4854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oQ/Gek06XvYeL8uvSQBn09SnKoZfuTYpvmoxZer6Bv36ilSn2KpGJGvVqDiSNlw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB8276




On 6/26/25 15:02, Russell King (Oracle) wrote:
 > On Thu, Jun 26, 2025 at 01:56:17PM +0200, Kamil Horák - 2N wrote:
 >> diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
 >> index 9b1de54fd483..7d3b85a07b8c 100644
 >> --- a/drivers/net/phy/broadcom.c
 >> +++ b/drivers/net/phy/broadcom.c
 >> @@ -423,6 +423,13 @@ static int bcm54811_config_init(struct 
phy_device *phydev)
 >>       /* With BCM54811, BroadR-Reach implies no autoneg */
 >>       if (priv->brr_mode)
 >>           phydev->autoneg = 0;
 >
 > Blank line here to aid readability please.
OK
anyway, this is removed in the next commit handling auto-negotiation
 >
 >> +    /* Enable MII Lite (No TXER, RXER, CRS, COL) if configured */
 >> +    err = bcm_phy_modify_exp(phydev, BCM_EXP_SYNC_ETHERNET,
 >> +                 BCM_EXP_SYNC_ETHERNET_MII_LITE,
 >> +                 phydev->interface == PHY_INTERFACE_MODE_MIILITE ?
 >> +                 BCM_EXP_SYNC_ETHERNET_MII_LITE : 0);
 >
 > In cases like this, where the ternary op leads to less readable code,
 > it's better to do:
 >
 >     if (phydev->interface == PHY_INTERFACE_MODE_MIILITE)
 >         exp_sync_ethernet = BCM_EXP_SYNC_ETHERNET_MII_LITE;
 >     else
 >         exp_sync_ethernet = 0;
 >
 >     err = bcm_phy_modify_exp(phydev, BCM_EXP_SYNC_ETHERNET,
 >                  BCM_EXP_SYNC_ETHERNET_MII_LITE,
 >                  exp_sync_ethernet);
 >
 >> +    if (err < 0)
 >> +        return err;
 >>         return bcm5481x_set_brrmode(phydev, priv->brr_mode);
 >>   }
OK done so
 >
 > I'd include this with the above change:
 >
 >> diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
 >> index 028b3e00378e..15c35655f482 100644
 >> --- a/include/linux/brcmphy.h
 >> +++ b/include/linux/brcmphy.h
 >> @@ -182,6 +182,12 @@
 >>   #define BCM_LED_MULTICOLOR_ACT        0x9
 >>   #define BCM_LED_MULTICOLOR_PROGRAM    0xa
 >>   +/*
 >> + * Broadcom Synchronous Ethernet Controls (expansion register 0x0E)
 >> + */
 >> +#define BCM_EXP_SYNC_ETHERNET        (MII_BCM54XX_EXP_SEL_ER + 0x0E)
 >> +#define BCM_EXP_SYNC_ETHERNET_MII_LITE    BIT(11)
 >> +
 >>   /*
 >>    * BCM5482: Shadow registers
 >>    * Shadow values go into bits [14:10] of register 0x1c to select a 
shadow
 >
 > ... and send the changes below as a separate patch as these changes
 > below are modifying generic code.
 >
 >> diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
 >> index e177037f9110..b2df06343b7e 100644
 >> --- a/drivers/net/phy/phy-core.c
 >> +++ b/drivers/net/phy/phy-core.c
 >> @@ -115,6 +115,7 @@ int phy_interface_num_ports(phy_interface_t 
interface)
 >>           return 0;
 >>       case PHY_INTERFACE_MODE_INTERNAL:
 >>       case PHY_INTERFACE_MODE_MII:
 >> +    case PHY_INTERFACE_MODE_MIILITE:
 >>       case PHY_INTERFACE_MODE_GMII:
 >>       case PHY_INTERFACE_MODE_TBI:
 >>       case PHY_INTERFACE_MODE_REVMII:
 >> diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
 >> index 38417e288611..b4a4dea3e756 100644
 >> --- a/drivers/net/phy/phy_caps.c
 >> +++ b/drivers/net/phy/phy_caps.c
 >> @@ -316,6 +316,10 @@ unsigned long 
phy_caps_from_interface(phy_interface_t interface)
 >>           link_caps |= BIT(LINK_CAPA_100HD) | BIT(LINK_CAPA_100FD);
 >>           break;
 >>   +    case PHY_INTERFACE_MODE_MIILITE:
 >> +        link_caps |= BIT(LINK_CAPA_10FD) | BIT(LINK_CAPA_100FD);
 >> +        break;
 >> +
 >>       case PHY_INTERFACE_MODE_TBI:
 >>       case PHY_INTERFACE_MODE_MOCA:
 >>       case PHY_INTERFACE_MODE_RTBI:
 >> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
 >> index 0faa3d97e06b..766cad40f1b8 100644
 >> --- a/drivers/net/phy/phylink.c
 >> +++ b/drivers/net/phy/phylink.c
 >> @@ -234,6 +234,7 @@ static int 
phylink_interface_max_speed(phy_interface_t interface)
 >>       case PHY_INTERFACE_MODE_SMII:
 >>       case PHY_INTERFACE_MODE_REVMII:
 >>       case PHY_INTERFACE_MODE_MII:
 >> +    case PHY_INTERFACE_MODE_MIILITE:
 >>           return SPEED_100;
 >>         case PHY_INTERFACE_MODE_TBI:
 >> diff --git a/include/linux/phy.h b/include/linux/phy.h
 >> index e194dad1623d..6aad4b741c01 100644
 >> --- a/include/linux/phy.h
 >> +++ b/include/linux/phy.h
 >> @@ -103,6 +103,7 @@ extern const int phy_basic_ports_array[3];
 >>    * @PHY_INTERFACE_MODE_QUSGMII: Quad Universal SGMII
 >>    * @PHY_INTERFACE_MODE_1000BASEKX: 1000Base-KX - with Clause 73 AN
 >>    * @PHY_INTERFACE_MODE_10G_QXGMII: 10G-QXGMII - 4 ports over 10G 
USXGMII
 >> + * @PHY_INTERFACE_MODE_MIILITE: MII-Lite - MII without RXER TXER 
CRS COL
 >>    * @PHY_INTERFACE_MODE_MAX: Book keeping
 >>    *
 >>    * Describes the interface between the MAC and PHY.
 >> @@ -144,6 +145,7 @@ typedef enum {
 >>       PHY_INTERFACE_MODE_QUSGMII,
 >>       PHY_INTERFACE_MODE_1000BASEKX,
 >>       PHY_INTERFACE_MODE_10G_QXGMII,
 >> +    PHY_INTERFACE_MODE_MIILITE,
 >>       PHY_INTERFACE_MODE_MAX,
 >>   } phy_interface_t;
 >>   @@ -260,6 +262,8 @@ static inline const char 
*phy_modes(phy_interface_t interface)
 >>           return "qusgmii";
 >>       case PHY_INTERFACE_MODE_10G_QXGMII:
 >>           return "10g-qxgmii";
 >> +    case PHY_INTERFACE_MODE_MIILITE:
 >> +        return "mii-lite";
 >>       default:
 >>           return "unknown";
 >>       }
 >
OK, separated into "MII-Lite introduction" and "bcm5481x MII-Lite 
activation" patches
 > Otherwise, I think this is fine.
 >
 > Please remember netdev's rules, which can be found in the tl;dr on:
 > https://www.kernel.org/doc/html/v6.1/process/maintainer-netdev.html
 >
 > (There's probably an updated version, but I can never remember the URL.)

Kamil
 >




