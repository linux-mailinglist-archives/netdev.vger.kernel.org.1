Return-Path: <netdev+bounces-121714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F3095E2A6
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 10:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F07FB20E19
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 08:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BB84776E;
	Sun, 25 Aug 2024 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RzexYrau"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5995A61FFC;
	Sun, 25 Aug 2024 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724574005; cv=fail; b=RST9MQOT+/3yXNd6JatPdg9ccQRrdnjIxOCEbBqHr87j9puVOQkrPYKnC709V+xj2twOtuIb8sIvTvCa0aqQp4xyo+bf1tX061Cx5JeyEBVAedb2a1o0n4uMbfmK/iA99ghrM7ieQ8SEALrgfe81jIGsE/kKuhb4yvRq7HQ4p+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724574005; c=relaxed/simple;
	bh=jBr/GAF2VX814U3jDkxOc+9D48Trhn5X0ly+pdPr1ts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CGSrPMfURFq3M31MtbpycLLBzlcOz7P3fX+y+Usvxse2qKjG0QZ9gvPnPhiQWyqsFs6yOd3japBAFrQvIFNWPBOCGSZD4PREj9q1+duW7OSzEr+a120jvAKufAVoQ2aATkOBk5FOLzwU22X58ED93edUj4zwmvnhc6Hrvsl8Wqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RzexYrau; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNZhmoMQk4yXYhf+zUZcwdPSy/o921U/HOYWq91aw1axST7e4fOtVan2QX282ycfOGTKFywXH+PruReXx6RBkXVREdw3EUYJUlpAnesKMGo/ygpdlhNvRF9Cd+GEsiApa67Skn6QIVUerv+2sAdA1abqSsWE5NpPtqz2ZfZpiYLC/ztuFMlO+DdcRDgC1vS9r8zDvwiaYWAdRsvNHtc6mhdN3W1pn+nQ5/6Brlw2yAHf1rPE7aVuwoCBVW93nOyji46M1cq8YqhaSvUMqotDFdCQPGDm/l9F5GPbq5eovpjqg+Yv7uG4zHSbruKf9BsuB4bfidxF0/W4ZMlzB7UmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxquqHwHheJRay+jT6mnUOObAqx9P1gyl2AxEy8peZE=;
 b=VNHIi/UPqiIKhJ3UwJ/o88zhxZDAfV7M5YMU5ifQtSADOMyiDn0vZ6r4KvGjmhjBZAUqURvrulU9XBNeOpqATiIed1NmNwPfjh1EHemSteWIFIiNgCnlMpbRN3XENgayFUYgBQ1aPriZj70fO6VkG4DPclwLpMc79sp714uuUrXb5Fy3E1y/tEmz8lV0AfeE217WjaslG4wld6x8YzmPoEq+Zo12bO/b+qI57vdzHmtT7QMsTFBI4MUxLbNnGNIdk50w6fD+sJ0PqAtLC/nkeBfzDZYtzBWwuQneDx9eBcpyBYgm9r/oYo8UZ3mviGsHQEs7X5VXhyytwF9Qh6rlUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxquqHwHheJRay+jT6mnUOObAqx9P1gyl2AxEy8peZE=;
 b=RzexYrauF1dCpPx0Cp2rdlGBXELbF39e36BUhQL1gbu9u88g28hByK0QA3gPSq2X2SzmVgEdQ5ELDAe7dhmwaZ0tXI2H7Zs3pjGxcHZ1IvNzoWkjS6nvQXFyApSaeePD89vtYcd5nH2NphQX+42v2JwtZ0Wrw0rUX+DqNZ81EMMqI/I86Vnl6c20ZjNd2MOKbBMaJxJcolqsJImNj7Enf3pmTLVrvhwA9nHPsa3R9OaxxmjKv2ZXcVf2pCEjyEPfpx/hX5RM/dJ6ko4OOgLLkcwnENYrcwwf+Ljj0buHu1qxHASGpv40ItqaivmCZ/1rbUZHXT+Mog+gsDdTvVbOyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Sun, 25 Aug
 2024 08:20:00 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%4]) with mapi id 15.20.7897.014; Sun, 25 Aug 2024
 08:19:59 +0000
Message-ID: <a1b025a9-4fa0-42d8-9ad7-5a3888574b3f@nvidia.com>
Date: Sun, 25 Aug 2024 11:19:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/6] netdev_features: remove unused
 __UNUSED_NETIF_F_1
To: Eric Dumazet <edumazet@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240821150700.1760518-1-aleksander.lobakin@intel.com>
 <20240821150700.1760518-3-aleksander.lobakin@intel.com>
 <CANn89iL+VTJ6tEe-PZ24h+0U9BYs0t4gZDndiy7j1DwuKMBEFg@mail.gmail.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <CANn89iL+VTJ6tEe-PZ24h+0U9BYs0t4gZDndiy7j1DwuKMBEFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0017.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::15) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|SA1PR12MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a902895-a391-4cb7-26c9-08dcc4deb5c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blVmM1Y3eVZ5ZHdwbkJTZmV5ait2N0N4OFNJNU8xT0k5aHpIRE5DNGFVVFRU?=
 =?utf-8?B?di9kS3l6Q252ZklnYkY0dWdLbEo1enVPL1JMYzBDYWMraFBJNFFxZk94amoz?=
 =?utf-8?B?OW9TNWF4TUpwVnhGa2kvTjg2bEk3QWRTYWNsM3BPN05wSVNqcXpwazUxYlNq?=
 =?utf-8?B?YmMrd0VyVFdGUFJKSzlRRzJDYmF2djlYRzM2L1NRMWxTQW02Rk5XRURNWnY3?=
 =?utf-8?B?YzFwTmRTVjkrQkpCaE1MSnhPWGZ2WWRlbUp1UmxTb0haQlNnUWJvV1VrV3Fo?=
 =?utf-8?B?N2dXTjBMSlgzSzEwMDVmK2QzTjBoUUlTSTdtY0M2ZzVZeTdaSmNoWUh4YXpS?=
 =?utf-8?B?T2dkb3BoaE9yU2R2QlFmdHJOSTkxVDJtZStXWEhJczI0ZmtRbVg2YzhySXd2?=
 =?utf-8?B?Y2dsUzdzdDVXaytkWlhWQTdIaWpHRjVhcm1Zdy9nSE13TlNXMW0vWm5zMlBZ?=
 =?utf-8?B?VjdqWXhWS3Z3WGx6SUpNdENNblU4SjFHMG5oUkJyN3dPdDhQSWx6RzlYOWR2?=
 =?utf-8?B?TFJ6UE5wNGNNOGRFYWlmRU9oMDRTY1paSVdKK2RYaUlwNHFENmE5THRTVUx3?=
 =?utf-8?B?eUhBOVV4Mk5aSjViVFUzUnRiRFY4cEk3YWZHTUJhN1VYTHN0YzNwTjFob0k2?=
 =?utf-8?B?QTE5aFZ5VCtpRWJyczZQSmdORjJnRWtHckk1RHhkdjZ6dkxEV29RN2Y4MkZS?=
 =?utf-8?B?S1pHNVdQRFJBTXJpbW4xMW1Pc0l3Z2l5ejVxUkNWWlArdkYreENRR0tjL01B?=
 =?utf-8?B?aWVVdXYrdGtxQkpYVVoybmc5OGFCWWRaSTQ1RXlMNnU2cUJNTW5FNm5uTE5X?=
 =?utf-8?B?YXZUTlR6WFpMVzlldHAxUVpFYTAxYTlyYWtBSlNrQ3BZamk5a3dBUFhsWUhI?=
 =?utf-8?B?VHN0alZEVkk3TmZjenhkaXBlWUxYMXpobmd2VzBCUkxvRUJWUW9ITzNiMFBO?=
 =?utf-8?B?MTFRRllqaDYzRGp0ZUdsQnY5UFdHWDhrc0NkVnhIV3cvUFlwUXZNWW1FeE5L?=
 =?utf-8?B?M0ZkM1dHQ0VGcXVqL0sySXl3V25nZW9OaHFlZG1ZMDI2MnJLNk1qbjdxU1dX?=
 =?utf-8?B?MjhZeUpMODZLNWtIMFl6SnpiVWF2RWVFdTZFVTc5K0t1eFBieW1KQ2lzUFgz?=
 =?utf-8?B?aWZ0Lzh5QUFnUU56OXpwRVZkSGRtV3Y4UTBxSlU0TnpZMVNiMG51bXNCVkMx?=
 =?utf-8?B?VHBiZElPOE12R0ZWd2tCajg1ZWVZbTQ2R1pLTHR3aEdibTNlejNwdUFpNzRO?=
 =?utf-8?B?N3I3ZmFuKzRaeTdYZ1RqU1ovT1F4UUlkeUkrWEQvV0daM3AwT1lMUEFuZUcy?=
 =?utf-8?B?K25QU2twd2Nub05EdVMwR3VFQ0U1MVFSWGtOQWRzS2pQVU1oQm9GMGRUVlNX?=
 =?utf-8?B?cndqaHp6RkVoTlF5Q2NUOGtLLzFCU0lGeHdybFNuVFlsYUNWSFduT0h0dzRR?=
 =?utf-8?B?UHZINFdnc0FQV2xmZGcxNWlWc3dKZVk0a2J4QWlyYWc3YXlJMjhkYjFNUGdO?=
 =?utf-8?B?Tm51ZGRXRElFcU5ranFjbFlvOVVCck81K1pLZXk3RWxQbGJJZldad0FidUpR?=
 =?utf-8?B?elBTY2RsYmxuVStkQitma1N6WjA3WVNoZ3lGeGdtUXVKbHhIZ2NKZ28zMUZn?=
 =?utf-8?B?Ni9sVFdMbkhrUnVmWVM1ZEUrcjA4SXh6aDh0RCtDbU55bUhERFErQWE0Zm1X?=
 =?utf-8?B?NktXRVJyU0JIVG5iMDRrWkgxOWV1ZkoveitBZVlzOHZvRktDUmZqTVVXTGVD?=
 =?utf-8?B?TlhVcjA4NkorbWYwMTlzSmVlcmYxcFFmNW12N1RRNFFPT0FEeS9zOHVmdGhq?=
 =?utf-8?B?bGNZRElzTDdCTjJHdklNZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anR6dlRONUdMc1BXU29GazBoeEo3TlFCNURILzdmNld6L3VUNDhVU0lSTGJs?=
 =?utf-8?B?c1pyOVNQRGM0YW9ZODYrOFovOVdGNExGS083WjgvbHRSY1hvbFNDeGYyTGlE?=
 =?utf-8?B?YUFyVkR2TEhqdldpOHBKMDRLaVNFZHZ1bFlwcXNaRkpGSHpTZVd4Z0hMZzh3?=
 =?utf-8?B?eEE1ekU2M2g3MDkybzlrc1g2czJDZm5SUWlIcElVWnlqMHcvc3VaaCtmUmlM?=
 =?utf-8?B?T1hzdmlickRLZ0l5dlUyc3d1TU5vRXhFcS9YNkVBWlR1QnBqQXErek1nc0RG?=
 =?utf-8?B?M0FHTWVCZGhSWm5WOGNMOE1xNmIvS3A0U0piVVdNS200UzFCcjlOek1GUkkr?=
 =?utf-8?B?V3ZYZkdMQ2kxMUFod1JSRkxEYm1Ka2NSYVRXTU9hYmJzVzdoOE1USG9SSGxF?=
 =?utf-8?B?eXZibndmTUpJM3cxWDZwOG5NdjBua2tObFJxbDdieXl0TE9GczhxWU1Iamkx?=
 =?utf-8?B?dDkzSzAvZm9MeHBoa3ZYOVl4TDJvY3V1UC9iRGQzdUZGdEFPcW15NDI0aEZa?=
 =?utf-8?B?bE9YenNXT1ZoWm16WHNESk4xZXFlUGxxVzV5Sko0dVc1YnJzMjUwQ0tXaHRE?=
 =?utf-8?B?TW1TbXJ6QzY3M1grWEd5SHNxcWc3K0FCRlpQU29LbkxnWS9YQWFmR1JpMjF1?=
 =?utf-8?B?SzBiUkdWd0xGWmhyaHRoYUJFMmdzZHFSMkhPQXBMcmZzeGdKL0RaT04wREc5?=
 =?utf-8?B?NllRVVlid1BSakxVbmV4eUsyTGdMK3NrOHNwQTZib05FVkN4eldQaVMrc29j?=
 =?utf-8?B?WHBGR2l6blg1bDEzaFRJWVJvSTJkQ0NBclRpb1hLRGtTOVpZclZuazdHSHdS?=
 =?utf-8?B?bkpkSDRZTWZWOWdsUGpmM05rTDQzSEV6MzBSUTBvV0FhVHExM2pqdFFMOE16?=
 =?utf-8?B?WmpGZVhsSmpoUnVBM2hDbXRlMzM1VDJ5QzBndlJtTWFGQjR4TjdPR3dHb0J6?=
 =?utf-8?B?VlpyMEhyQTY4cHV0QnkwU3N5ZEZKV0dZYWtVUUxMelNPaEl2Qk9oNWxtR2kr?=
 =?utf-8?B?V1N0UnJiUXFSVUdZYXh5d2FUTnhVOCs4QmNuTjh0cUI5ZUczK2FjU3FSK0Fo?=
 =?utf-8?B?a1VCU1IrblFyajFHRUFPazUwRnRjWUJCRHp0Q2xVTFVrOXZFc1Z4QjFyMDFB?=
 =?utf-8?B?Vkl0Q052bWEzZE12ZldoY3ZGTC9TMFFpSE5SUEZWb3M3ZVQ1anFEbEplY2VU?=
 =?utf-8?B?RUMyZ2tqQUNucVZYZlFtNktuUUZaVlc3a0R2U2ZoWjBqUWp5UE41SlF0OUZi?=
 =?utf-8?B?ZXU0QmQ3YmZta0NkTHhzUU85eUJrMTI0VDNRdkg4d09Qb2dyRXBIUWxqNVNk?=
 =?utf-8?B?UVlhOStIZGM0S3J3YWcwQkh6d0R0K1gyUFRTYllJeUZFVUYrYWhOSlg2b1dC?=
 =?utf-8?B?NWlsd0lsYXdVMHVJMFhUL3BMVE00eGVDYkM4Q2ZGSUkvMkRvYmU4YkFLSXdU?=
 =?utf-8?B?cnRTTTRFbTd2YVpCcjZ3dGF4QjNTVy82MDZCSUtBZm1qYUVvNVN1eFB0OXho?=
 =?utf-8?B?cDg2TWpCamFKSDdOOVE3V0tnVFhpcFU0Q3NCYjNTVGZjd0N5L3pNdTErQkI1?=
 =?utf-8?B?NjF1UlNPTmFmQXkwUE9sSTkybkdPZG9taXRaNDlKV0dQQ0Y1Uy9xM0ptL0hM?=
 =?utf-8?B?Tmc5NTJ0TStqRWV3MVRNblU4YkU2MUJjSGU3NTV4bkdqd0JGWllHN1FMbTZR?=
 =?utf-8?B?RmlqUlpIcEdwbWgxWHJ4YzRNTTFqQmpRamJ2VzZZcHlpZVhjbUU3QlBSK09K?=
 =?utf-8?B?akNwWTAvS3pWNGpwcWJsZ3dBVVpobEJCR1pKRUZKMkVNUWF1V2tDd3h4bFdy?=
 =?utf-8?B?K0VITzdzdUxhdXNZN3R2MnRSQzZwdHRXbUltcnBsVzZzZ2ExVkdyZmE3eFdo?=
 =?utf-8?B?d2l1UXdzM2dtNkZEa3hNZkx5SDFhSU5wbGZmVU5KZ1lyUkcvMll2NGtlNUZk?=
 =?utf-8?B?QW85Y2dHeHN4aTdmUFZ0QVgyMnZwZ3htNkZIKzA3RGJ1RDZ5b2hzdTRHRys4?=
 =?utf-8?B?VmI0cTVzR0N1bWY0WVJlbStxNUlnbExURWJ3TGhORmdBcDZqOUlJRDJXTUlk?=
 =?utf-8?B?VFUyNzZjTFJPcmIrU3JuTXJCVXFxTTFobFBpVlFPUmY3ZWhHZXdPMDdBVTVE?=
 =?utf-8?Q?r5lo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a902895-a391-4cb7-26c9-08dcc4deb5c3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2024 08:19:59.7132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSKtXxUIjeDzEj0AmtW1nRj94VQVkgaYzyD5jtsWQOTYHqtjNkd4KFVbQ06b7/Ml
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094

On 21/08/2024 18:43, Eric Dumazet wrote:
> On Wed, Aug 21, 2024 at 5:07 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> NETIF_F_NO_CSUM was removed in 3.2-rc2 by commit 34324dc2bf27
>> ("net: remove NETIF_F_NO_CSUM feature bit") and became
>> __UNUSED_NETIF_F_1. It's not used anywhere in the code.
>> Remove this bit waste.
>>
>> It wasn't needed to rename the flag instead of removing it as
>> netdev features are not uAPI/ABI. Ethtool passes their names
>> and values separately with no fixed positions and the userspace
>> Ethtool code doesn't have any hardcoded feature names/bits, so
>> that new Ethtool will work on older kernels and vice versa.
> 
> This is only true for recent enough ethtool (>= 3.4)
> 
> You might refine the changelog to not claim this "was not needed".
> 
> Back in 2011 (and linux-2.6.39) , this was needed for sure.
> 
> I am not sure we have a documented requirement about ethtool versions.
> 

This is a nice history lesson, so before the features infrastructure the
feature bits were considered as "ABI"?

I couldn't find a point in time where they were actually defined in the
uapi files?

