Return-Path: <netdev+bounces-284871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEZiJ1BR+2mSZQMAu9opvQ
	(envelope-from <netdev+bounces-284871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:33:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F16B44DC444
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CCDD3034286
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 14:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DE846AF0F;
	Wed,  6 May 2026 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WrsecZDK"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013021.outbound.protection.outlook.com [40.93.196.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6273B4266A3;
	Wed,  6 May 2026 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077246; cv=fail; b=UJy4MLbnUT6uqwr1lCoi3Fyb2VSDnGnXUFNSCZk4nSw/nbxF5jdKFNYLinl3uVfYgxNWdN8IrXIX2Hcc333UT45C6w6kob/oX6KtDiunvtUIp+rknzcwLEYkrPiXujfk56tvVeNLWJBOrEeKigf+lJrSehdYDxxDla3+h6QKfVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077246; c=relaxed/simple;
	bh=FnlWeuYrlgIh3sxJ0HkoO8wFoYPDnec3XTTAld6tI8A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MFPyv1vypn3mMoviF8dSmyN+cv0OGEh4uZOmChB6fFtrXfAvdN3M+Sl8Jk/+EkAIQFGFReFLhYWXPMMMC7XjpuuYAauFZWO3/9K4mxf2IpVBgOi0WJzTQKFEQXfVMQCMrnIOLKxPx5Y200aVP2mpmE/Mex35zUYAvc9xsS3YOy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WrsecZDK; arc=fail smtp.client-ip=40.93.196.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNVMo2sFo8autm+XFV7XPJ/bEkTTlCLIQYUT3+mvqzIxRrpFG5F/ZSBsEdsY//55k+h8OYBdEHahHKVOXgjfL/TCSnJ/Em6d2mzeFDov4t32W9pkAUx2BmNX6M3FYQ125lz+A9QgJsgqVB11/kidlyZ6mLfwFM87BC9r/Aoy9XrVvyopMSG7AxNXlF3UTv79ForOpvO1zVHhjsT1lz57s5iFThxMS25I0GNDGXE+aAGa390gXpBIo0SpW2dsBLV96bP/XEom3nRP69/QK4NrFXm2wVKl7e4la3UNkKqcTh2/esh0GcW59beE9qS+uIHaASky04x3e+fT6AeAAU9B8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GLO7lg8uazTmvKGdqShhd//0OARG+pmPd8AbA43Grk=;
 b=yN7s8olpzRejHa2Y+AWdk8m+1boaWmY7Bfak85Uizpp1cA4HVGo9DxA5rL//o0kDC0ka04M1lyUShVewRm+uTBTQrXvXCxbPj8HU/+kM9iD/UbJKw8xtyE2Tg6sldiT/xBTCczf3nrg6m3aDX4MSfyFOM/KL0/i3tkQTzlUOfySo5BGCW74Mm9TQErEeG9tppDW+duVKJsymz9csjPkkNzFXVBfcGdPA654W5hOWRxGA/zQKlrZ1X/CXNVn+ytGl1rqypwPUBeQMyq2Uowwd0yQj3hhiVSmqdbfpoPXaY7lmoOdLH2zVO9ESr4lnWWrE/eVqtif+CdN9gUPLxoyJDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GLO7lg8uazTmvKGdqShhd//0OARG+pmPd8AbA43Grk=;
 b=WrsecZDKP8dLFKrwYw19uv2at8I1P8k3N/fnZE5q1qtkbj4PWFXs1h8aRPydeCrxnbINUgv5jByTQBgjtPGtqoU/fFHNVNopTjE37UPftP0BvQkv4c4n1N8gZxHLCmAzn0lfmI5Zmqh1c8uWFDXJmMmmttjOonBY+Prf7nwKqRtVsuY6Ew1yo7+9aMT5QvEKJFRKaKGrtysuZlqyxkflDgBvBW85Wq1M//MTYTuwBO2P58jvkeiJI9+yIolbVvWznNqhA7OCKxAF5nqw3tOW+kVpLuxhAKqtbI4rhvHaJ10NK4cT26zO8ied+Ed4GZH1gXVDZO6DInKB3fIcsz8vBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22)
 by MW4PR12MB7286.namprd12.prod.outlook.com (2603:10b6:303:22f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:20:40 +0000
Received: from CH0PR12MB5236.namprd12.prod.outlook.com
 ([fe80::f025:9f2:ccaf:6edd]) by CH0PR12MB5236.namprd12.prod.outlook.com
 ([fe80::f025:9f2:ccaf:6edd%7]) with mapi id 15.20.9891.015; Wed, 6 May 2026
 14:20:39 +0000
Message-ID: <9f601313-cade-4bd8-8e38-3777139de46d@nvidia.com>
Date: Wed, 6 May 2026 17:20:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] aquantia: Sunshine/Moonlight UDP video streaming
 broken since 5b4015ad833c ("net: aquantia: Remove redundant UDP length
 adjustment with GSO_PARTIAL")
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 regressions@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <980382a2-3b8c-4da1-ac9b-efd8c0d2c1be@nvidia.com>
 <F03BE787-07D1-440C-81FD-F7B4D5F1E0C6@linux.dev>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <F03BE787-07D1-440C-81FD-F7B4D5F1E0C6@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To DM4PR12MB5248.namprd12.prod.outlook.com
 (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5236:EE_|MW4PR12MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: be79debd-227b-480e-9767-08deab7aa56c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WTx5FfswT+WwLvb9Ym3Gjpew8WQAN95idWfrdkCLKFs2hTVlMdIy6Dtfu5wLMc94QQAJVJhjOlmsqjMncYKQrUaMjgW1NOCEdOIIYZuhID1+BeXKM5WhAZMiniElZ/XretvlP14LkYCogSNFUAdZvsa3ieogpHqAPqagiTjBzP1oMr2b3AN3mp3e3gbLiG2dpFL8OthrdJTTzue3I+t7S1JDsoZ6DUyDWK8WfdIuZl+HS/761qvSVGB5w/3JjRgGyUIUHH1GMFyccAFWnlfG8qN0dk0IpySnONGJFxdlqsEO2TLfOgWnYuShdtGR/kp/K03eqJ/0v4dTPeqUrqeCpg6fYgy+IbMHfiX3Sf8BswrJ5B7ihjPoM2yXclL4fp4+a/9bxgQLnIRaZBAceG2DpTvGqD7TTMEU0l0dik+6JvgTZ6krKh9JHD2Wkm2nqXec8kigmj1RONc0mjOhfXtR9jM86d+GbpNP/cRA+XyzmK07+54sLC1gA+gDI335qFNGSi8tmkh6Qig760F84O+/+9vDZqYF5zOD+UN1CCNMvrJyOLOp2G7fsAbDwmv/35QInSetSsG6kKuWhIjJ4hBoIQ6ppfToQL3TQdcsoDwHL5w2tsOyzr8CLYYLbMI+dcPqa9/alxrJhzBMig3yXy63FwGmUCJ5XEJ4aFiJSf5SOX76+4DJ4q8mIHaCaVxp0Rfd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bElLdFdZdjliUXpPNmI5bHFaZTBEQWZpWUY5YVZnV0I5b0xpa3VyVW9xRndJ?=
 =?utf-8?B?VzBaWkEwMFJPKzMvcmdCWEY2Zi9JU2VaY0xHQjNNeUkyVnBNbWJmZHJGaGdi?=
 =?utf-8?B?cnZOdFFQUEo1ci9KR1JySjhDZFI3TW95bmJrNmdJQmtOMS9TK2xLcXhtaktt?=
 =?utf-8?B?S2pmc3RML3ZWMVBRY25weVBISGZQUXMyMERaeVRYVjN2SDduSGx2ckFGbzFS?=
 =?utf-8?B?bkNhNGhDVHRvbXA4bXByRHFLUzFPOWZ5WFlUMFVQU0ZaMlNkbFdLSDI5UlZa?=
 =?utf-8?B?Wm5WVlRLb0NHaXhHYWVXWTE1K0pJU29zdWNUcUlicFdKK3hLRXBDOXhFR0Jt?=
 =?utf-8?B?ckN6Uzd4RFhGRys1dEZtTnhOTTFKN29sbFFPcjg1TjkrMlpsWjZkbUpqaGh4?=
 =?utf-8?B?TEZReHhYeWZpYWQ1QTBuTzJ3NWRHWVRqeUQrdDZQU25BL245UHVhY3VKMFhU?=
 =?utf-8?B?NVUrY2VuZ3ppYlBYTWw4YVgrM3ZzNzJlTDI3TkVYeTVPQ1ovTVNhOXMrOXZF?=
 =?utf-8?B?OURQYklaelYzdU9xRks4WFZMcGFVY2srTlAwais3U0Q4N0FQdEEya0paYmtw?=
 =?utf-8?B?RkZ2dFVpSVQzL2ZZSnIrMGNWSEJ5NmFBRkRjNUtPUU85NXJUUVJSRkdudlly?=
 =?utf-8?B?REdVc0MxVWVhdDBWM2F1NnpiRXhZdzdCWUNGc3ErZDlwUGdzdTlPSGJId3Zv?=
 =?utf-8?B?ckdOZUFNaU1jTDZDcU5nTjJpaVdnS1NSek9BUDdTM2w2SVZrVXBaazBIbm5N?=
 =?utf-8?B?R3BHWG5BVDRHTkZpY0Z5eVBrUy9BblJnYmZtOWUwUGhaYkFEdVZoM3dXVG8r?=
 =?utf-8?B?czFDbTBwdlZmN1NQVHBsM1dndEZYUllCbjNjWlRqKzNsRjVUbysrSks0V2hC?=
 =?utf-8?B?cmdWcXpGQ0NmWWNCRk1iZFF1R28rRTZGRTY2eGlQY1lrTmIydloyeFI1VTV5?=
 =?utf-8?B?eklFTGp4YWdJek9LWFdYVDd3N2pkK2dRU2ZlQUlPaHV3emNucC9pNCtQUkFF?=
 =?utf-8?B?bTZJbkZ2b3FqSzEvdjQ4NXU2R3Z2MFB4OFlLd2l2UHZXU3JoVzVmT3dzYjhC?=
 =?utf-8?B?aXJIVlNSLzlHSGtvQW9wb3ZHbWc1M3NJQ1dnUmJNUDhoZmEvdHhodVBGVEpI?=
 =?utf-8?B?ZWlaNFkxU2JINjJ5ODA2Q0Y5aVFDVFFDdUQ4WTZ2d0d0RWY0cFpaejFJYTMr?=
 =?utf-8?B?MlBpS1pBTzF3QUlQNng1OWpRbTY3a0R0ZmZYTndrTG0xQi81cU82RmN4M3ly?=
 =?utf-8?B?MU0wUHk0dTNwQTZqak44WTBPb3Q2ZUt6a1NETG5IN1ZTbXV1cVlHUW9PWjlJ?=
 =?utf-8?B?V3JPandlakZUcEx4T2treWd5Wm54SGVVZ3J5TFdQU0l2NHZKdGlFZWNVOUZX?=
 =?utf-8?B?T3lkc2phRDB6S2dqNWdienlHaDhmZnJMdVhYajBBUnZrSnNKTFBHZ25jbDlH?=
 =?utf-8?B?UmZTRjFvN3BYUFRwdVVCNHB5L3J0OWhJZDR5NGp0WnZZMVhRNEhEeWlIcWNQ?=
 =?utf-8?B?VHVDdWdCb2Q3Q1pMZTFlaEhuc2lTM25QVHdPc3hqWjc4eCtKbEN1TEwxQlUv?=
 =?utf-8?B?WGE2V0puZmdTWW1JZ2d0TUlJQk9XMmlFRmpkemdYNzcvTW9RaS9LWDA3aE5s?=
 =?utf-8?B?azdxanV3T3htem1uM2gxajBsOUNSSnJENGJhOFJYYzNyTjRjT3BveHNZaUJo?=
 =?utf-8?B?WlViaUxKMnEybVR0MVR6ODZ5ajZjdmtwK1Q3R0ZzTU9ITjR1NlpzQ0U3cHNz?=
 =?utf-8?B?dGxxS1BHVGZJci9Ec1l2dDZadHdYMW0vRDV3Z2EwcFBrZFNLaWhGQndVSjUw?=
 =?utf-8?B?empPS0hWOXo1cTQ2Z1IzRWdsVEJrN2NZQy9PdmhqRGxsRityVk8valJDSlBG?=
 =?utf-8?B?bU4waE5hbUNuUTZIbFVEMEszVDJDVjdGVWJDZHB4WjJMRHEwQnFzL2xSM1Jt?=
 =?utf-8?B?SzVsaXdzektCMVhiNVFUdUp5Lzg0cDFCMzRKTFlMcUxWZmtYMmtHSW0rRHBq?=
 =?utf-8?B?REoyODV3YURvOWg0SWN1UGVzOFdPUk9RckxnQnZGeWE0dUhPQjZIMnBTeFRp?=
 =?utf-8?B?bFc5ZU1jSVVYdW1VK1dTY2ZCREQ0V2pIM1hUaUlVWkxBM2JlQnlVejVEaXFV?=
 =?utf-8?B?dDZBRVNEZitRdDF2QzdpZkd6MFFNMjUvQXVmUVhkNXY0RW12VzM0SWpwcXlV?=
 =?utf-8?B?VG5tRVd4cVc0SzdsbnpsbDgzYmlhTnBTT0tMODc1aXVnb1JBZkM4SmE4THhB?=
 =?utf-8?B?ZEhGM0pZVTZadkh5c3ZwSkF2UzB3Q0ZielBPUzlBbzVDaUhLaVhMZHVUNGVV?=
 =?utf-8?Q?0dFY7aer0viHjvmwIV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be79debd-227b-480e-9767-08deab7aa56c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:20:39.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65LWqBl02mukUhMDxG+yIJHPySIXY8xSrQjYXrtxwLQRNO0nPZDTwmt4I9PPX8+5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7286
X-Rspamd-Queue-Id: F16B44DC444
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284871-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,lizardbyte.dev:url]

On 06/05/2026 10:49, Matthew Schwartz wrote:
> 
> 
>> On May 5, 2026, at 8:05 AM, Gal Pressman <gal@nvidia.com> wrote:
>>
>> ﻿On 27/04/2026 21:26, Matthew Schwartz wrote:
>>>> On 4/27/26 11:09 AM, Gal Pressman wrote:
>>>> Hello Matthew,
>>>>
>>>> On 27/04/2026 2:20, Matthew Schwartz wrote:
>>>>> Hello,
>>>>>
>>>>> When using a previously working setup of remote streaming from my workstation to another device via Sunshine (the host server) and Moonlight (the client app) on my home network, I no longer receive any video output on the client app after upgrading my host workstation to kernel 7.0. Reverting back to kernel 6.19 on the host restored my setup to a working state.
>>>>>
>>>>> After bisecting, I landed on 5b4015ad833c ("net: aquantia: Remove redundant UDP length adjustment with GSO_PARTIAL") as the first bad commit. I confirmed this by moving the cable to my second on-board NIC (Intel) on the same workstation, which restored video output without any other kernel changes. My affected on-board NIC is Aquantia AQC113 [1d6a:04c0] (rev 03), atlantic driver, firmware 1.3.34, MTU 1500.
>>>>>
>>>>> Looking into it a bit further, ethtool -K enp97s0 tx-udp-segmentation off also serves as a workaround on my Aquantia port without changing to my other ethernet port. The working Intel NIC reports tx-udp-segmentation as "off [fixed]", so traffic falls back to software UDP segmentation on there.
>>>>>
>>>>> Please let me know if there's any additional info I can provide.
>>>>>
>>>>> Thanks,
>>>>> Matt
>>>>>
>>>>> #regzbot introduced: 5b4015ad833c
>>>>
>>>> Thank you for the report and the bisect!
>>>>
>>>> I will take a look and try to figure out what's wrong (though I don't
>>>> have real hardware to test on).
>>>> Is the userspace app open source? can I see its code and try to run it
>>>> myself?
>>>
>>> Thanks for the reply. The code for Sunshine is available here: https://github.com/LizardByte/Sunshine and the code for Moonlight is here: https://github.com/moonlight-stream/moonlight-qt.
>>>
>>> I have been using the Arch Linux Sunshine package which I installed by following the Linux instructions here: https://docs.lizardbyte.dev/projects/sunshine/latest/md_docs_2getting__started.html, but there are also binaries for other distros or it's buildable from source. For Moonlight, I have been using the Flatpak distributed on Flathub because the client device runs an atomic rootfs, but you can also use any other device that Moonlight supports.
>>>
>>>>
>>>> I will be OOO for the rest of the week, hope to have some meaningful
>>>> reply by the end of next week.
>>>
>>
>> I think I see the issue, do you mind testing the following diff?
> 
> Sorry for the delay. I applied this diff and I’m able to stream from my host to clients again without any issues.
> 
> If you send this version upstream, feel free to add my Tested-by to it.

Thanks for verifying!

I will finalize this and submit a proper patch soon.

