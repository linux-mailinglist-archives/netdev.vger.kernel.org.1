Return-Path: <netdev+bounces-207853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43F5B08CDD
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 391147AB1AD
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722EB2BE051;
	Thu, 17 Jul 2025 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="XyN0+qcF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF402BE034;
	Thu, 17 Jul 2025 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755224; cv=fail; b=fmaPQ4VmT4zV7ZblwY85TZW2BmEi0/fre27ngMh9ioxDp6GBWmRjTIszLbaMtGPrPw6Vxl4Lb+TMmeKnTsjB88cZ7Tp76Pafqb65UtSMDeTki1Qjgt8oh7+c5krIaDKMQJJUvUvkZmdSl1l7amNQ61LMB0vansOGrnzxTddJgNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755224; c=relaxed/simple;
	bh=xGKuFY3319l6pBXtc9K3vnAiXURGz3wVsP95EDMSiTA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PHltVSgb5vwwqOjS96TOYXkfIhOtEWixeS3cMkhIM5JLA+5fn6DXpUimfsCRWvKDaDgC35iXMJKBGSgukI+HhF8Zk1gfT4I0bPq2zFT2Y36zsS3qdxV4qrjfOASZdtFM8peE4tP7ZP05WHgHF6Z9XBPOQH3HyYnWuICJ+jiQHNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=XyN0+qcF; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X26mg6ZIcrX+8jLGASfuLCjvx2anWVM707jBXgq283Zq1u1DfiRiRwGJxyX0C+ghgUmL55UNlPwJKpzaqO470hS9uxmvnNyt2OpJ0zb9SOCHBjXOlG158ut+qUGIxPpHZSb+FwkXEtF0kujlvE4NPRrAodSW9d3dv8BpgFdmr6r2Cz6ZNlScwVCvJCaPj5As48WZa/D4Pof7Wt/HemKIJCBb8V54BvBHVYhdHjKClyu9iQ4eIIoE9ZDE8KwfjFxzOdLf9cXXI2mjEZpseb65WuMefS0191taO+hQ5kLgfKf+evW+Y6j1fcXbddguQobbSajml/RwUTz3MnOhaM29rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LF3aXo7s8jSoHZHfH1Y45V2Y5si0+HLXRgDNPqhr5SA=;
 b=S3EjqPWxfYIWK06XUTcmoAUp3Zol2JY7TpGPS/0yAu6qF8wh+13Er0S9MgfKxf1ekmVh/0bq75WDyKBdFKd0M1R2w9ZEL2tc1Tol1boR6NKtdwffnPEVr7QZanoQlgHLUJE6ak9NyhsMhkeTtMQs9WJ/fzG3aUEO21igiYPrEEBWVXU+QmtAc34i+WZMuU/1RnucSk0yntg8S7sU84X9jTzAYQn4XXDayULDhcWIuOBHfSGjuzjKQnjMdHsm7A6O+VS9jvujf/I178uhhnxyogovOXbB5OzkwpP+KzkAi2+qNQvAIJZUr2GdZwhrfJLCwD5CKnxzefLfXUhd5ALgjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LF3aXo7s8jSoHZHfH1Y45V2Y5si0+HLXRgDNPqhr5SA=;
 b=XyN0+qcFnxReAFai8xTw7mCq2yi5czBdFw1/HdSIpqnXfBsAYpCcqnAF4ptCaz4ghTyAm8bD11g+EnAM45ZGD5WzWi995x/nLADZerPF7HyHpJ9y8hTIxjgpZ3CUrBI4B4GHJyQmr1DI3SR2cflhaZWWSdqiBzwbeZ9CpV+O4PzOtZS5Z7t8CnX3VoFtxai8KQo7+Ygt1i9F4kcuP6wuyNUJt9kdmG2L+UXcngDL79wDrkyUo33mYtnNooIZ6IsymVl2/QYyGdaPwG7FuOinwPIAfFBWbeid4fJKwLsay1hT81Okz+xpX6A0X5CEaFEWRNSU0In/N0cBjesqp/TqGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by BY5PR03MB5063.namprd03.prod.outlook.com (2603:10b6:a03:1e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 12:26:59 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%3]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 12:26:58 +0000
Message-ID: <9fe98cb8-f1c7-472c-a619-1ecabd636b07@altera.com>
Date: Thu, 17 Jul 2025 17:56:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: stmmac: xgmac: Correct supported speed
 modes
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Serge Semin <fancer.lancer@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
 <20250714-xgmac-minor-fixes-v1-2-c34092a88a72@altera.com>
 <aHib9V1_WZfj3S8M@shell.armlinux.org.uk>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <aHib9V1_WZfj3S8M@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::32) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|BY5PR03MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c73884-7c76-483c-8def-08ddc52d38ec
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djcveDE5WjlFZXJjTHQvdEhGaTJFakNCeFZjakRrMG1UUFhpNmZYYVFsMHg0?=
 =?utf-8?B?Rll0RnhUeWdlZ0RZbG1RaFJNTVhCMkJQY3NEVGxWQ0pReEVYbENudjVKRGFQ?=
 =?utf-8?B?S0F4eUF5ZHN2UGJ4RFlyR0tXT2dPazExSGt2ZE45RkwzWUZTcVZXbEljcHBG?=
 =?utf-8?B?OUY5SlcvTHVJbG45QlZsck1uamZZZGRSZ1FtdjJjRDd3SWliSTVkYURrdFdF?=
 =?utf-8?B?L21Qb0o2VVhrS3BwTDJZNy8raHBod0xQb2FnUi9xeGtYQlpadk1icHBuNFFK?=
 =?utf-8?B?VTlTMkRlazZHemg1K1Y5TUdlZ0piL1BmdHMvS2lISWRSSkRiZ0Y4RnZBamlW?=
 =?utf-8?B?bHQvelNLWE82TUNidmJpdUNZWjUvaUp3cldiMk1VQVUvaXluRG9KNFBQT0kz?=
 =?utf-8?B?WFlwRzUrb3FxYXlWOW1lbkdPM3BBR2Q1dk5Da0Z3eFU5RXRjVDhFY3hKdFY2?=
 =?utf-8?B?RDVTa2xYV0FCTHBRd1RFdlpvYXdKaDN6MllydDF4ZGJRWUFyU2UzeG5DTXJ1?=
 =?utf-8?B?MHdsaDVmYWZJNENPcUFrc1pCaS9uNGhVaDVGRXhpL29uU0Z6NGtrZ01ZTjdP?=
 =?utf-8?B?ZWsyM29KQ0FuVERaYVBxck91K3k2MHRuMXk3M0xTVUkyRUdiTGp6TGlTZERF?=
 =?utf-8?B?c0VjT3FMeEJPeWx3MzRHOFBCM3hSbHpjQ3B3SnN3djJ2T0VXVHorTC9KQVFI?=
 =?utf-8?B?OGlzZ2pYanE0OXlZczMxdGFzczhyMzRpS2xaQUppRHlJeVkxMjRKZjhXRDVa?=
 =?utf-8?B?ckZBNy9OeEZEYmlZMzl3SlVHdG9qMUdQUU9FMkoyTUpYZys3RWJxem9ORnVL?=
 =?utf-8?B?dCtRcG5vZXV6YjZHeW1VY3NoNkdGYWp4b1FySlRpRENCeGZpVlF3UnhhSEh1?=
 =?utf-8?B?SnZ2eFlPQnk5ODRZNmlYSzQ2bW52NG5LS0V2S3RrZm1rUGRFOEhKSElQUHhV?=
 =?utf-8?B?OFNRT3NEcUVwM2p5ZWJjRERHelVYaDhtV0VwWkRkaU9QNmpGM1JqLzJLSEV0?=
 =?utf-8?B?QmlLdXgzMkdzZ1c0ZUdjMHVqZnVGVUpBZk85OHRvT3NudWE2Uk00clpxY3p4?=
 =?utf-8?B?OU5MaEZpcmRMMlBQOVNRS3kvVGc0Y2krNnZ4bjU2YzluZ2J1bkFueWpENjFl?=
 =?utf-8?B?SUdNR3ROdC81NmswTUhsZ1RFQmdOdm1rempscy9YeTVpcmtpclBTZFh3OWhn?=
 =?utf-8?B?MjZmVlZFWEE0S3BncXl3aEJyM2gxZTQzTWZpZ1cvejlSNG14bjVMS0xETTB4?=
 =?utf-8?B?ZlhBbUpQa2VFZGkzNHJIb2d2bmFkb1J2UVlSVHdELy9XMmtPZnJVTDBDMDE0?=
 =?utf-8?B?dkVFdkJoamlRcXdQM1FqbzlYY2o5VGxVbVVMUll3RVFhcmY2N0hxcTMyM1JP?=
 =?utf-8?B?bWo3WGcrZWdmdytPL2s4RFdYdUFpSi9VOXpmdFNZdm9ycm9pOVd3UmVuK3V0?=
 =?utf-8?B?L3dpbER5bHBhTFhUYlJDZUFyQmdkVmhldXNjZEM5bkpMTmdSNmZ0UU02QWRi?=
 =?utf-8?B?bzhkL0hMSjdKZG9vK1NJbTBYbmYwVC9EeGNQMXNYMVp2eE5qcExJZ2VvdTlC?=
 =?utf-8?B?RStKcnNCbWVYMlljRHRDbmFia055a3I0VFFjZmNTRHhIZTB5R0M3K3Uyd1pT?=
 =?utf-8?B?dzNqN2xiajd1N0thM05Dd2tDMmNra0lyU1VxbWRVYVgvSUZPbTdNY21JK1Ur?=
 =?utf-8?B?cmxMdm5nNmN0SnhwT0JpTnVPbnY0ZVBld0twdEpGZll5cHR2NGo0YzRMQ1Bh?=
 =?utf-8?B?M0lNUzRSeFJpWUwwSThQcVNuOUtuZVp5c2pIM1I2NU5IODlSNmptcVR1dFpG?=
 =?utf-8?B?MnpGd0lXd1MwS2YwSlYvRzN6MzdiN3FwTE91NXovZmVuU1gvRGMvSERaQTlZ?=
 =?utf-8?B?YUVqVHBLU3RBRnlyMVJsRklZRGlKYjNDM0pZRWxsa0Q2SDl2S1NjczQ1WVJF?=
 =?utf-8?Q?zxumegiY4qk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFRmd0lCT2I5emJIckdEWmd3Sll5QmpuQ2hhdy9KTnpaSGtZMzk0ZThJekdE?=
 =?utf-8?B?UllMT2VWUWpkZUp5dUR2N01rNmhNTzFtdlZsVVFpdGxQd1ZKMmRNcnBPd2dK?=
 =?utf-8?B?bTJxLzVTTlluQVBGdFExenVYU2k0UGtJWDM1eHJhVHJpd2d6Y3NvMnQ3WlBR?=
 =?utf-8?B?K3RSMExmNFg2WGI5cUs2MVNTVzlhak92RmR4Q2Nlb1Z6cGNKdjNjRHB6eDdp?=
 =?utf-8?B?d215WXBWK3NSeXhMYnlBejRFN2w3SG93bERUS203UG5uTzRWam56eDhxQkhX?=
 =?utf-8?B?TmswdEx2SG1OOS9pUjFEMFpORklkQkd1d0dHSUc4akhJV2RWVzZPcWVTMzht?=
 =?utf-8?B?QlF3ZUczU2xZaU83b3M2QlNtY2pTUS84SVU4ckdjSW8zNkNESU41UXQ3NVFh?=
 =?utf-8?B?V3lkRmhhQU9xK1B5VHNwVUo0dEQ3Um5Lc0RSSURzWTVNWTdkd0piNUdaOGhh?=
 =?utf-8?B?TUNreTFma2NkZW1HZmU5N0psbzNSaWprMFB4TGNyZ1JKSFc1MGFJV3RXMnZP?=
 =?utf-8?B?ZDRMY1dVb3dlZXkwTDRGSUlvREVGYlN2citDcjdOVDRoTG1iOGxUbVduWjVk?=
 =?utf-8?B?ZGkxazFSQ2FaMWFCWEhoaHR3dGYyZTRtaFVhS05rZ2VnVVdaVGEvQzltSUN6?=
 =?utf-8?B?M0ZyakYrdFlQdUw1TUlwZWNJVXlIQU5zWEh4MlFDRCtUaGdVRGI1a1ZRd1FO?=
 =?utf-8?B?V1V0cHZoK1VjQ3JFRW5QcUpDRDVrNDlvbU54Z2JRZVg2c0ZsazZ3WFVzR245?=
 =?utf-8?B?MzFNdC9UY0x6OWlSekpuYm1PUmdVSjRMYjM1bVZlN1E0ajRuMmIxMnk3RkxP?=
 =?utf-8?B?UDdTWEU0YXFXQmI4TmxkRUM2ekd2bDhPb2NpWHdQT3dlcjdhYVlPQlFreklF?=
 =?utf-8?B?WWZ5YVdVOWRaN2xSM0FQMzVRV1hqZmZJU21IVWtDZ2RhNFdmV1crMTNzQnBv?=
 =?utf-8?B?c1c2NTVvWGQ3T3lNSUJXVlE2OVg4M0c4R1c1SUY1WjFvSzNFak1uNU1vWFU2?=
 =?utf-8?B?MU9HMWdNZnVtQzR5SHEvNlB6aFl5MTY0WW1YRXZ0NGkrMnJFQ01UUzZkOXZu?=
 =?utf-8?B?ZmJuSWxmNndBa2xXVE4wTG1OSnN4VTBEVER1MGlBbVVqWjk5RHZkQW5NanBW?=
 =?utf-8?B?THVheGpxRXNlZDRWanFPWmc3TjBWak9qcHkzRU5zY2xhQ3JPMk1Cd2NNR3Rv?=
 =?utf-8?B?eUxrT3g3Z2Vxb1JSK1lKUHJXNW1RckZKOXNndXZLSUNEc3NNSTg3SncvaGYy?=
 =?utf-8?B?bHFacVo4aEdBWGNya0JJdld5aHk2MXVURHh1TzJMaldSOWNXQm1rNjltOEdC?=
 =?utf-8?B?T3RuSGhPbnVqT2x3Y3pIamZKRGlKaitNako4dStReUR0cUZOUFpjb0doV01T?=
 =?utf-8?B?OGxjZUlsM1ZJS09NRENTcnF3ZG96Q0llbjZqYWE3Yks2NDlQWGhIYXRMRGNn?=
 =?utf-8?B?dmpHVWpoVjd2RzI0ekFjeDVtY0RHUnZsQk5DRlFtcU9YNTJ1VUN3bndPTGV5?=
 =?utf-8?B?b0I4eENjeG1xQlZ1ZzN3dWZ1UTBZRmVkMTdtc2tlWUMrL0tpTkRGcVRib1pW?=
 =?utf-8?B?RTY0U1p4VWE0U3B0UW1xd1hQZ0FMdkh0MUNlRENjNzM3T0dXSmN4QWNETUI1?=
 =?utf-8?B?VHEyZG5aRG91dWl0NCtRYVZDcUYvTmQrSzFkMG9leEo5QXViQ09ZRGdkNGtV?=
 =?utf-8?B?OEtjNFplV1ltZnU4WFRSRm9qTUNKYnlXVmJuWGZSbGs3T25qVWdkQjdYaUFq?=
 =?utf-8?B?QXAveVN3b0V4VXE3dlZ2bmVmVis5Zmt5aE9nazcrV2g1ejg3N09JVzF6bXhm?=
 =?utf-8?B?V3hURUY0L3kxWlJDS0w4R0VMS3ZsRDhjcVdlVkVaME9ud1VoY29ZZXdPUlYz?=
 =?utf-8?B?QjJraWpHU2UvN1dtZlhabjFhRmkrc0FnbDJ1R1dJaVRxUERXZVAzenp2UGEz?=
 =?utf-8?B?ZEFvUmdVcW0wU2hiOG5rQlBDTjErMThadG5PRkdFSHNZdy80UE90RHdqSXNR?=
 =?utf-8?B?SzR4ZkF4REpSOUZSZDI5ZUhEV05VNG5FMWY5bVZ6VHhXQ1ZuZlZ2NytURnpE?=
 =?utf-8?B?Q1VSVnVzOGUwSERDMHBGRjh1WmRTc08xcDJEMWlRcWZYVDZhaHdycE5EVFAz?=
 =?utf-8?B?NjNZS3UyT2VNOFBKdkhob0tlUnFUeUtjN1BOQ0MvWWpIaURxZ1F5c1c1OHBR?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c73884-7c76-483c-8def-08ddc52d38ec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 12:26:58.7113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJzL7md7p1X8ivCnBZaZe/NdDmUSbPYHRDH2R4Wk3oxy0J4XTmA0hVo/xoaT8J/3fAZrj+ICJfm2XWqXGTEcUVa40NPmnpAXnId4Yk+cp48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5063

Hi Russell,

Thanks for reviewing the patch.

On 7/17/2025 12:15 PM, Russell King (Oracle) wrote:
> On Mon, Jul 14, 2025 at 03:59:18PM +0800, Rohan G Thomas via B4 Relay wrote:
>> @@ -1532,8 +1542,8 @@ int dwxgmac2_setup(struct stmmac_priv *priv)
>>   		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
>>   
>>   	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
>> -			 MAC_1000FD | MAC_2500FD | MAC_5000FD |
>> -			 MAC_10000FD;
>> +			 MAC_10FD | MAC_100FD | MAC_1000FD |
>> +			 MAC_2500FD | MAC_5000FD | MAC_10000FD;
> ...
>> @@ -405,6 +405,7 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
>>   	dma_cap->sma_mdio = (hw_cap & XGMAC_HWFEAT_SMASEL) >> 5;
>>   	dma_cap->vlhash = (hw_cap & XGMAC_HWFEAT_VLHASH) >> 4;
>>   	dma_cap->half_duplex = (hw_cap & XGMAC_HWFEAT_HDSEL) >> 3;
>> +	dma_cap->mbps_10_100 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;
> 
> What if dma_cap->mbps_10_100 is false? Should MAC_10FD | MAC_100FD
> still be set? What if dma_cap->half_duplex is set but
> dma_cap->mbps_10_100 is not? Should we avoid setting 10HD and 100HD?

As per the XGMAC databook, 10Mbps/100Mbps/1Gbps speeds are supported
only when the GMIISEL bit is set. As Serge pointed out, I also need to
consider the MAC version (≥ v3.00a) when enabling these modes. I’ll
update the next version of the patch to include checks for both the
GMIISEL bit and the MAC version before enabling the 
MAC_10FD/MAC_100FD/MAC_1000FD capabilities.

Also, regarding the HDSEL bit — it is set only if 10Mbps/100Mbps modes
are supported. I’ll include this condition as well when handling half
duplex support in the updated patch.

> 

Best Regards,
Rohan


