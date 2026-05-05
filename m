Return-Path: <netdev+bounces-284468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC4+IO4H+mkEIgMAu9opvQ
	(envelope-from <netdev+bounces-284468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:08:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3154CFF55
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7322304403E
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 15:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD98E48167F;
	Tue,  5 May 2026 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RzsD43B/"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9CE48123C;
	Tue,  5 May 2026 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993534; cv=fail; b=glZk/ZIhIAvhUuyGp3Kf3GfGCZzRx9QU2DldNf2M2UXx9GQ8Mi6dPv+yN9lTFRFdpGBoz6UwsIca/ftPremSsOZp6mAFE4KCIgOl//4u8VRjiGFdhjcDkbeoea60g0j9dfRstr/smiWJMHBSt4kean7ig6i8eadrpwe832d/wMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993534; c=relaxed/simple;
	bh=xMlLyJ58uEY81IxP7J9WA6O9c7ywOXM8Z/WSm//J46A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nY34RJG0SahYvtUoCe3om3OO9bROYlrak1UnCtEVad0gOm6cU0QWrUVeUn5IvbU6wLZbL/Fp/MQXVrlXgTovSbRlzDMnpKK98NNJ1r05BjVse7xmMVyCpYR13ooZz1fX5GI2NhOO8XA/IWJ4Y3SlgeL0yF7KnOCccKtVVlbCthU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RzsD43B/; arc=fail smtp.client-ip=52.101.56.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJbWPFhOMfAzgsoSpqiO3HrnGAmj98Ioj8O28I+F/QAzBp0zerX4uoD1z/6YWmTol3OG5zzHRfR1fksimPXloVxFiOyh9PvBne7+7qIZ6Gek+cfuHl7NoQWFRTo13mXe95xoq3SbSMh3wH+nnrmB5gLLxpxQZY69Na9DT7WuJ9P5LnTJyCfLuIb/bY9hD2cU6ZhbLHtkbZXJcjcCMtmS7N67HwVAU2G14mOw17B7ntuHEm0V3c0lYVAjbmDtfDKhWqc1sspDUrRQuVbBwqFttiCEfz/PchvUweXDAtNNOdu8OhDIiEW5BQ6lL5KrDRXEvA5ip5zkoGN+ZKjVqYR7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jf2aIwrdQkySFzA765s/xcY4Fo+YLk6dmqOc0YSs7zM=;
 b=ApMiZ+Q1YvuNoGoN2HvUPpWz922SeBn5RdoemDtwFtvuM1IUUlfSvZ4C3NBYIope2RxVtuvP/aEBoYdD5EAmtIg9Qeyh/7Dp/PPqxXk2VgDMqo2M2eUVg165D95bfBHw2C775YHrtv4rWhL6g9k3ZPltcxYzz9SgY0VYDsJsMtuzYl8xs+S1QbR9IJP+faMBDUAzWpxrFAFd/ww4WApbHPj6ZRV8UA9Hfa3XL4vsGpz7gDQPyH2titfAbZlZ5vcPuZRdoCeD9PLY8lJciYAn9UMPUUIPiklWsLwbTC83ZFMM7RQVUxB2QQMwq/spw3CJ59RsaNSI8eUTWmQAVl8jrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jf2aIwrdQkySFzA765s/xcY4Fo+YLk6dmqOc0YSs7zM=;
 b=RzsD43B/aFl/DG0z0KT15w0GEjI7zHy5A6rdJwfh0RIwR9chs1CkQyDrfJA8TWNmbQmBhx8KXzzy3Z/F5tMQ4Ms9kbiqz+XCfyd9DZYTebw0vggf/bkxIV0c/nkPBjiaBkPn90t7V7mL/ZQ49MEJ4VJO3Ae4hf8tu27lhB4Ert4uLPyEB/IYBT+2w9I+SurYMB61PQOkZNU0bTZb0VO6Go7aN8iGCD/dqbRzQXc41w7LK6THHfcEsuWogVOIVUSKXgeSw4oZc88Xx9TzVA9OU2j2mdSEOAwtgX9A/bJ4QP8LuxnXp+jAloHuQBWnSkWA6N6JqFaTwV5qhng+adLKpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by MW9PR12MB999209.namprd12.prod.outlook.com (2603:10b6:303:301::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 15:05:27 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:05:27 +0000
Message-ID: <980382a2-3b8c-4da1-ac9b-efd8c0d2c1be@nvidia.com>
Date: Tue, 5 May 2026 18:05:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] aquantia: Sunshine/Moonlight UDP video streaming
 broken since 5b4015ad833c ("net: aquantia: Remove redundant UDP length
 adjustment with GSO_PARTIAL")
To: Matthew Schwartz <matthew.schwartz@linux.dev>,
 Dragos Tatulea <dtatulea@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc: regressions@lists.linux.dev, netdev@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6c3fb15e-711d-4b8d-b152-e03d9b05293f@linux.dev>
 <5293b717-6a8e-40b6-bd6b-61043a062451@nvidia.com>
 <cdce7fbb-671d-48b0-95ff-56b882d3e9a5@linux.dev>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <cdce7fbb-671d-48b0-95ff-56b882d3e9a5@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To DM4PR12MB5248.namprd12.prod.outlook.com
 (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|MW9PR12MB999209:EE_
X-MS-Office365-Filtering-Correlation-Id: c95743d3-dc28-4cf3-d434-08deaab7bd74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/4mZ9diS/CPhL+Ox1124u2F1+WhUDI60XwXIk1VGeEQrx3dbOSYBYnVoNxi6RC1mXYNjtfYHfDdMHLnsGXbFpz7Up2m5SFfJ2gIgsQOL9osbOeWMHdSIkdpFz7p6bqJPR7/E9NNEWZ3wm1retD+BpsoWcle7rPviUGM66LSFNaTRKLtnPz2DzOU+yiLcTXCT4nnftP5AjUprs9JaRv9zuASAHoufCx2t1s6Z9oKcK3VE7B7ZRIQRQNtDiB3/uy7JeFczs8EZDRjBWVyPZs7MCZMgLmLckmDgXMMet6IW9F5B/AWGqEra6dU/ryaX39hNfy5FeHba8LhfnSUPym1Kzt/Pv019Hp1TR8oTQMgYeYRNtvuLfx6LuoBKcQU8iDyPGonqLBr/0Rt1tLwc0eZSW0NmTu+N3saWmLxUX1MLWk4fJ2f9t7Wy154yS1dh+N+utF3NDp0zN68MN9evfhJFhk5gJyF1NBvslm/XC63LYHuypRvOcRuA0MBk+G/zs3OzHPQMFToRkLAAB++BpEnEwWq6kSnA/Yrcvk36rg9+UqCpmK7QUQeIQhzDza/zKojr8vX5nWNGfjTJhFK/boJjyMH+QcfZoJL9ePYJLZPGfkskBJrcTVEYDEt9ZOdJCQ0TvL2ILz1mZAZLV+rLGI+MpHKVEyqQ+rlStm9xgIzXpSwpjyqvnhEYvIT2WDw6r+so
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VURXOWFwT0VNVzlmMS9HaDY4dlFudTVPN1Rid3FQMUhCcDFNZzNKbVZsaEFN?=
 =?utf-8?B?WDBDRVRSZkJXeWRDcHpEa3lvd250MFFPQVg2WlFDZjI1UUp6eXFwcm85TGhH?=
 =?utf-8?B?U0FXdWRNT0VaYW9WK29aaW5rTFNGTTBPOVVrcjgwWGxzcEhORGkvTEZ2Qjlj?=
 =?utf-8?B?cG81S1dsVUJ2bU1GUDdHcWRlQ00yL3JUY09ob0FBSWpjd244WEVVM2VlUWNK?=
 =?utf-8?B?NVhyTm0vejd6WXloL1BwcHRpMXZjSlljUlhoL21wRWR5cXBaT1ZlWmxYRkdF?=
 =?utf-8?B?TW1IMUcwaHFVVm54SWZtRndEOUU4eHd3RXYrRUk2UzZScEl2d3oxbHVJUGxk?=
 =?utf-8?B?ZHNncmlFQ3NQMWJ6UVZZaTV3cU4xNk9VS3k2MjNEUlZFU3NraUs5UEdLVWlv?=
 =?utf-8?B?b0ZEYUY4M3JGM0NKUUExaUJGb3ZFN3EyUmFHNzhXWlBkTnZUZVhienJ3cWF6?=
 =?utf-8?B?MUp1bmNTYnVtc21hMENoUnVDN0pJVkFIMTVXTithUzBKbm4rbGtxTTJ1MGl0?=
 =?utf-8?B?dnZ3RnlKczVJUmIxRDZxaFB1VVVqbktSSVdyRTNQMVAwL2RoYlN5TFp5VFM0?=
 =?utf-8?B?cERWek9iVmhCb01oZEh1RU5JRW9Gd2tSNEpZbjZxbVhwL2hMYUtTUlh4WDlx?=
 =?utf-8?B?cDhmZ0dSSFE5enRCSjNZZFN2SnNKRnY3WTluV0RIRnRJbytCMUxoVi9nOVNp?=
 =?utf-8?B?RE8vNHFDQk5yaVFsRkVmcHdrWm1qRm5mY3N0alR1UjBIajZrbzNKNVA3Ni81?=
 =?utf-8?B?L2F1a2NWckhJcW9HTGJDVDdGM1o3ZEtXekZDR2w1RXFSc1djd2s3cWFvMFdu?=
 =?utf-8?B?OUZGelorcVNGL0x0MXM0Y0g4UVZUNXY4SjNwQ0xhOS9SeVZjQWNvMHJBY0lz?=
 =?utf-8?B?Z0RtK0dEZzczS2lBMjZGS1ptNFhwckJhTUpLNnRUYkxobVhFKytpT2lVdENT?=
 =?utf-8?B?ejBVMWJhMjJEeUZid0ExcU9wRGhNczgwNys0S05zU3I4WGdDLzRTSlhLRUtr?=
 =?utf-8?B?Uk1qeFRwU1lCWXhlenZaZUN5NzFMSFE2R21xclhyR3FLSGhRdk9Mb1paaFdr?=
 =?utf-8?B?MWVtRWh4QTdpelBEY01adWxlNDloYkIveE1Qd2dQOWhSckhPYXVRLzJMMEo2?=
 =?utf-8?B?Y2JGd0IzdXVNT2l0U00xRFBPY0VwNzN3MTNGQkRyVHJSMnNETjgxQytseHJG?=
 =?utf-8?B?eHZpT3JWYVpKZ2RQa2o1Qk5LZDFtQnY4dTJXQ0RTaFAwRFViR3gyQitIZEY3?=
 =?utf-8?B?TU5Db0grZHlZbDZGY3MyUGJaVEIzQ0FrMWhMbGk3YzRjeC9xK1NmNnJRMEhX?=
 =?utf-8?B?RFllcW5DUXV1YTRSZ25FWWVwU1NuWXlZZzIzMFRNd1plYUJrNGFKSExJS2pH?=
 =?utf-8?B?aW11VTU2bmh2K2haTW53eG9FZEd2TWlWd1RFc1JHOWxhTFZOUEkvTXBxRW1I?=
 =?utf-8?B?dll1bzVXbERaaWs4a0YyTzZxNHFMK0c3L21OMmEvRnYxckhZWTRXSzBYV3ZE?=
 =?utf-8?B?MDNxT2hkRFFIMnVmY3dSNUJ4MmRtVWpjeFhPVzFuN052WjNDUnFEM0Z5TlJG?=
 =?utf-8?B?eHZSd0pYay85dFllY2JMNUhlcWF3bzM1SHZyRXZhRkg5U25JL0RNYzVqZDl2?=
 =?utf-8?B?WWtidFZmTGZvckhPKzVzV3VualpZWEpjMTd5N1FzSmRiRmZsYkFwU2x0eG00?=
 =?utf-8?B?M25la3FLWW91Mi9ZUkdod1RCclpsRW9TUUhRNERQYXMwbkxLaUViamgvbGRY?=
 =?utf-8?B?WTlhakNtNytlWW1hbjJ2eE5Nbk5UTnpqZXpFL2hkT05PYWdSY3dyaVlWSU9p?=
 =?utf-8?B?ckVwaExkR0VweWFIM0x2eGJEWW1Ea042R0VkU0VrZC9ENjVkZUFsakhXMEJ6?=
 =?utf-8?B?azVpRmRUQWFkRE1OVmNvSGNTMVFhWGJ3N1QvbHZKbGVXNjNKMDNFeEpxbEtq?=
 =?utf-8?B?S0dnZExkZ2dHeUJLT1hxbS9Jd3lmano5NG56aktXdkxQeU5BR1BWMWdvdkxq?=
 =?utf-8?B?a2c4YzRhOXJxWGZick83Q05qU00ra3VhbTJaMVhHNjlTVkR2VnJCNHlhSktK?=
 =?utf-8?B?WXhpWWVheTRFVm1ZNWM5dnlycGtRZVNzRHB1S2phQ216aWh2YzJGaEVjYXc2?=
 =?utf-8?B?SWhuSFJjSkUyM083alk5amtlaFZWWnV2aDhkaHdEQUVpUDBDSldidGI0QlFk?=
 =?utf-8?B?M2RWY2h0dWVkdDZWWkhubFNnRHUvY3I5elZQQ3JqU0JBaVFPcVdmS0plYjEz?=
 =?utf-8?B?cVNYUWxUTi9Nbysxd3BlcGlhbFM0UmpjcndGekJ3dWxoR2pxNVJpdUdyajIx?=
 =?utf-8?Q?Wj/n0LfRuxQGmGVaXs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95743d3-dc28-4cf3-d434-08deaab7bd74
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:05:26.9067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llVqCU6+ceEJ2kT4AuYg0s91/TqsTHMSLdym0Us1uNztRmNruDrtO9iDilFtJdJQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999209
X-Rspamd-Queue-Id: 1A3154CFF55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284468-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,lizardbyte.dev:url]

On 27/04/2026 21:26, Matthew Schwartz wrote:
> On 4/27/26 11:09 AM, Gal Pressman wrote:
>> Hello Matthew,
>>
>> On 27/04/2026 2:20, Matthew Schwartz wrote:
>>> Hello,
>>>
>>> When using a previously working setup of remote streaming from my workstation to another device via Sunshine (the host server) and Moonlight (the client app) on my home network, I no longer receive any video output on the client app after upgrading my host workstation to kernel 7.0. Reverting back to kernel 6.19 on the host restored my setup to a working state.
>>>
>>> After bisecting, I landed on 5b4015ad833c ("net: aquantia: Remove redundant UDP length adjustment with GSO_PARTIAL") as the first bad commit. I confirmed this by moving the cable to my second on-board NIC (Intel) on the same workstation, which restored video output without any other kernel changes. My affected on-board NIC is Aquantia AQC113 [1d6a:04c0] (rev 03), atlantic driver, firmware 1.3.34, MTU 1500.
>>>
>>> Looking into it a bit further, ethtool -K enp97s0 tx-udp-segmentation off also serves as a workaround on my Aquantia port without changing to my other ethernet port. The working Intel NIC reports tx-udp-segmentation as "off [fixed]", so traffic falls back to software UDP segmentation on there.
>>>
>>> Please let me know if there's any additional info I can provide.
>>>
>>> Thanks,
>>> Matt
>>>
>>> #regzbot introduced: 5b4015ad833c
>>
>> Thank you for the report and the bisect!
>>
>> I will take a look and try to figure out what's wrong (though I don't
>> have real hardware to test on).
>> Is the userspace app open source? can I see its code and try to run it
>> myself?
> 
> Thanks for the reply. The code for Sunshine is available here: https://github.com/LizardByte/Sunshine and the code for Moonlight is here: https://github.com/moonlight-stream/moonlight-qt.
> 
> I have been using the Arch Linux Sunshine package which I installed by following the Linux instructions here: https://docs.lizardbyte.dev/projects/sunshine/latest/md_docs_2getting__started.html, but there are also binaries for other distros or it's buildable from source. For Moonlight, I have been using the Flatpak distributed on Flathub because the client device runs an atomic rootfs, but you can also use any other device that Moonlight supports.
> 
>>
>> I will be OOO for the rest of the week, hope to have some meaningful
>> reply by the end of next week.
> 

I think I see the issue, do you mind testing the following diff?

index a0813d425b71..5bd1706b11b0 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -599,10 +599,22 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		uh = udp_hdr(seg);
 	}

-	/* last packet can be partial gso_size, account for that in checksum */
-	newlen = htons(skb_tail_pointer(seg) - skb_transport_header(seg) +
-		       seg->data_len);
-	check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
+	if (skb_is_gso(seg)) {
+		newlen = msslen;
+	} else {
+		/* last packet can be partial gso_size, account for that in
+		 * checksum.
+		 */
+		newlen = htons(skb_tail_pointer(seg) -
+			       skb_transport_header(seg) + seg->data_len);
+		check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
+	}

 	uh->len = newlen;
 	uh->check = check;

