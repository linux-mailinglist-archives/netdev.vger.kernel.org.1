Return-Path: <netdev+bounces-114410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A28CB942730
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 08:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FC2282B08
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 06:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9ED4EB38;
	Wed, 31 Jul 2024 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rt4766mw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6178316A39E
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722408758; cv=fail; b=SeSWyhi/PkipgHSg60HUaVQmLnk56BNIqse6hWBUudCsZ1IskkVuWGj49BcHlZDAPjmMXMPmJI7hpPoNSKUBGj/F/eWFdn9s4f3fJFCnjh6TKLjaQfMXJp84Kb9YdXf2fwUaBUK4GLyOkA3teggCRNLZRJL3MXT08ElOlPxqoWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722408758; c=relaxed/simple;
	bh=O+saZd99yfCpDhvdsVPLK09wnX6eoivrVgug5u2RZ8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lyuEZR6qu0SRefDUEZcCw60vXRArCvSQX60KhFcUFalhgZUzx/xE/yNyHZqTvrnC4AOvq+oMCPEvjYFnzcREjVFWPKMLDPU045PiVSNC3sm07T5XrFZtFjVJE7blEu0B7OwgCTu7wvLuM5oCuwVuPEcsLdkWuC9ZGoqH34etH8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rt4766mw; arc=fail smtp.client-ip=40.107.101.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4ilgif42nFniSJUWRl0nuH8514en/l2rrxTJJBNX8eCCtmfOgobqecbQwqZNLiCBRVABm7cA9Cq5RXNKjrlzGXhaze7P3Z1exM2Sm1WVJyCgaMmgkYk65S9Y51eQoUNxtKOSG7S9rPkRKJCrw/sCqXwSj59wDFPjnBsloE4QM5QNGm/+3lt68Vzjt7sks6eUacEjFp0l/ZoXuCmOBtWrLH0Cfy7/AdcZ+X4+mlYyGDuDJyOUqOGLZUqu9FjijJkxfitCdeNcw8pxDyuSx3dO6HBLCaRh8cmMlMNFvdF6imLVjMSdBNJQGbpD757iJJ9rzRjVrpEATg8iqsxwz7D4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+saZd99yfCpDhvdsVPLK09wnX6eoivrVgug5u2RZ8M=;
 b=lAMtElpkN4J+6LI91Olb/9qYo3f2v6sRygzK5vT/9sSpClEsgPjuxWzCwSkqOO8vpLBSWDvZe+0+w4truorW0okK4jP/11wn64oN3wiacG/JeclT1QbniyUVQ70IaeTPkaBXEIHiKh30WI2vQbClkSO5m0z6CX/DSWN8TA9XN30lvQjO1jK65QUK4RunCVC2iPZf2HGwjfyNvYJsUEI04dfhR9fHKMcpwRob0W+u23E0mVLVsoN+jBg2fQW3CgdT39Ze0nvPQd5tW3pPcv8QNOGzV6mbw6+Mg7qz5PVj/Lck6ORMWNC+2EtsQsiukyWv7S89nxHWVvNaLL8azmYw+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+saZd99yfCpDhvdsVPLK09wnX6eoivrVgug5u2RZ8M=;
 b=Rt4766mwobwoo0FTwZM4/OiALkcHAw1RDZKKLMxIbEY5IuBW94RWjqDABx9lbZnsgUcIU9XA1bzETYUd78lbBeFZOo93SxgppP/oo9A+mPSDk/y7w+GPkjvdqUuT96gbzUHgKvkFYBQNoF3ZNxKGLLLJR+JJ1h1EJcVRguHN05L5X2FIb1mtONw73g0xzhiL3tEz/7sBHWu5Hu6VwBhHl/xinjPaKjL0A+OmPGsFwo8lCzMyXAqoDJ/DqrmE9IKN9FmiuK3l5JBfS3pkw/3UE6SkayiMtdhp00hzVcbbvp1On2qSvN/JdhvTLoW0a/G+ebtm8Vkl2zCqVrG6VgXw3A==
Received: from IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 06:52:33 +0000
Received: from IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::da5c:5840:f24e:1cd4]) by IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::da5c:5840:f24e:1cd4%4]) with mapi id 15.20.7807.030; Wed, 31 Jul 2024
 06:52:32 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, Leon Romanovsky
	<leonro@nvidia.com>, "andy@greyhouse.net" <andy@greyhouse.net>, Gal Pressman
	<gal@nvidia.com>, "jv@jvosburgh.net" <jv@jvosburgh.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net 1/4] bonding: implement xfrm state xdo_dev_state_free
 API
Thread-Topic: [PATCH net 1/4] bonding: implement xfrm state xdo_dev_state_free
 API
Thread-Index: AQHa4bU6zXFjxN34VkauWtmt6xnx3rIQL6SAgAA5NwA=
Date: Wed, 31 Jul 2024 06:52:32 +0000
Message-ID: <49743cc1e561349040964ea06817d8e3e3b75e01.camel@nvidia.com>
References: <20240729124406.1824592-1-tariqt@nvidia.com>
	 <20240729124406.1824592-2-tariqt@nvidia.com> <ZqmvD4gzdDILMHiI@Laptop-X1>
In-Reply-To: <ZqmvD4gzdDILMHiI@Laptop-X1>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6235:EE_|MN2PR12MB4487:EE_
x-ms-office365-filtering-correlation-id: 796ccd92-29d3-4e15-5b0e-08dcb12d5a42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TUtQTEVOb0g3OHhobUFDVjViZW1aSW01czI5V2Y3OW5XZUczbmNzOERId2h2?=
 =?utf-8?B?cXNFeDQ0SFMrYWJPM0JEYmpBbzB6VlQxRmNJTE9ocDF2WEJDWkIzUzlCVnlH?=
 =?utf-8?B?UDA0MzhJeE51MHNqdXBmcEZoblcvcVJzajhoazQzRmJKN05PL1NMak1PY0Rp?=
 =?utf-8?B?d0VPeEREaWhrNHJCTVlmemVUS3lOc2s3WVZhdm1oV1VlWVdzYXVuek1KaG4v?=
 =?utf-8?B?ejRCQkNKZEx0bC9mN21wNlJZWS9Ock1pZXorMGNJbUl4VUhibXdsby9YZUxC?=
 =?utf-8?B?bUJpbkd5dHIwaE0vZUw0S1plNE5wZTNYYUhqWFpCM3pvZEk5YnBaRHMraVVw?=
 =?utf-8?B?M1BBNnhReHV1RzNHbEt4WE5jRFlYOTQycTRXaWIxYkdhY0VSaUZqUWJaZ09T?=
 =?utf-8?B?R2s0RmFMeVVaNTVHM2FaOElKUVU1eU9jM2N3L0VtTVVQZnh1eXpZOG1QY0xl?=
 =?utf-8?B?bUxiZi82RFVySktvTXcrVjlJcEpZdG9hNUdhVkduWUFEazBJWmFrT0FaSWw2?=
 =?utf-8?B?N3ZFWW9MQ2JOZ3kvVkkvS0hZalBzcnpIR21WQ256M3lIb0p6Z2lBUGxMVXBI?=
 =?utf-8?B?MzNZcnlPbW95dGJJYVRWTGxqK1QrVk5QMW5POGdzU0V5cXdSRXZnQndJMGQ4?=
 =?utf-8?B?REJ6eng4OWF3SHVUVWFZVmV0ek1PZUNTM3pPZlFRYVpCdFZEaDc2d2lobHpQ?=
 =?utf-8?B?ZXVDTHIrNE1ZWktiZ2o2UHAwVS9sL245dC9haTA1ZGM0TFNEcTBPRkd4c01D?=
 =?utf-8?B?R0NCWWZVc3YwK1h4R05maWswSWl3OWhsZGpCYmIzY1RWcXpwcU1HUXlwN0dM?=
 =?utf-8?B?SWVHdUNiZ29STFlxL0hNdXQ3ZFp0U3IyWUErYkJyZW5qVjRJaWd6RUY2eHY3?=
 =?utf-8?B?TGJjWnlGUngvRTZKYUlaRU1VNnd4Y0M1UnVkcDRKQ0Z0RWFEemw4MnVmdkNW?=
 =?utf-8?B?dG9xZnVycU1reXVRcTBmR004QWYwRUQrVWJYek5pWGpwL3hHVUQ4YzJkRk9J?=
 =?utf-8?B?RU5hSEJIZlR6bHdSb043cGxtc3IrYVllQWJxVE9PYVN6MzNidjBUSUhDcktQ?=
 =?utf-8?B?eUVhb1pqV0RyT3loYks3TXZyK2VjZUdnMlBQMk9tKzkySzJGYlFrdkJzMDVE?=
 =?utf-8?B?cUFrU21SWWFnNm85NnVKZEtUeHhmaFd6d0prdEhMQzBxdFFXRGNkeS9tckFF?=
 =?utf-8?B?N0FqbVNEcjgyM1QxWnhnQVlFRklIeGJwVlFVT1A0bmozbk55OU9yTnQ4Vm9Z?=
 =?utf-8?B?RnlnbWk1YXNDOW5HS3hwMFlscUNxbHl5T1ZnRzNWUFZkdUM3cG0wZ2pYV3ZY?=
 =?utf-8?B?WGlBV0NVTFE1RlRlV0o4RTZTSnJDM2wyUnk3Vjh2d1pya2JSWitMQ05YNGVt?=
 =?utf-8?B?Z1BNSnZnVVlRMGxvbVVWemd2ejJRZjFHcFp3VU04TUFpeG1kMEtCZnhnbnBP?=
 =?utf-8?B?ZmJoY2NSVUl4bk4yV2NvWURiSHpQVE0vSGttUHpnNTc5SDlJSWJxa0t3MWVE?=
 =?utf-8?B?a0tCWU5nNElra2RVbDRtT3ppMUJQY0RUV0QrRTlJTFZTb2JjbitaZnhiQjRq?=
 =?utf-8?B?WFNxWmlrZHpObFoxeExBQndrS0huOEF3c3NhN09SRWQ5V3Y4MTY1bHV1QVBj?=
 =?utf-8?B?VnZDc1FJTEd6ZnpiRnkrK2l2NnZvZnVJNWVJQm9pcEUzcmZtMFdLVnRJVHVN?=
 =?utf-8?B?NU82ZEZLcDJXa3ZGZ3hUbkJROXdTOGQxNFAxdVpzQ0U4UjhyZyt0L214bTg4?=
 =?utf-8?B?OElsc1lmV1JnbTlrdkk3WEhzVzRuOUpPUk41YTBkanRMaGlxTWI3ZGFlQWtI?=
 =?utf-8?B?T3JhYWVudGo0VHhtUnNSTTlUVEd5T1A1ci9LamlFVnd3V08rbnFlUCtoUnVR?=
 =?utf-8?B?MW5RYjgrL0JGRGVhRmVHK0s3WEM4WmJvSVc2SnFrdzMzWHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6235.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cm9GdnNOeHA0YXZJblNSNzN6eXNGYzF6SWlsalZYSU45Y3piWlpTVzNXSjVQ?=
 =?utf-8?B?Tmt0UUIvOUNwT3grN1c5ZXFNbjl0aHVLU29RQk5IZjZ3b2wrVXV6ZHdiQ0ZU?=
 =?utf-8?B?dm1rNmtNMjEyUVV2TWlzR0gyZnY5ZGIxS0lLQysxRnhKeVc4KytBTUlHOWVY?=
 =?utf-8?B?Q09paGFtdUpVbW9tMnhWMG9xOEJ5eVBacWRKZitSNzQwNkF4N0lpQytQL0c4?=
 =?utf-8?B?bDk0OExkUkJpTWhUQTF2dG11OVMyRUc3QUNxWW0wVE9UVkt5d0hmMUFjK3Jx?=
 =?utf-8?B?SEVidVlEVkNtZ3gzemRIdjB2d0NSNzNmanVKNHBaWUlUbmtYaVE0d3poa0VV?=
 =?utf-8?B?ckkzOCtmUFNxdHpSQklOWHF0YkNEUS94YzNPUFBHZGU5ZGNuZlhaZUpXNkds?=
 =?utf-8?B?SVFuN0JtR2ZiTXBpdDJ4ZDY1c1BOT1NldllFS2tBM3lEdlVoTFBkOGcvQXoy?=
 =?utf-8?B?Vzd2d2tFcjdDZ0FYR1gwMHNLMXFUelZlV3pyajVrZTVBL2xqaGxiYWRrcUFQ?=
 =?utf-8?B?VlJCUm9rUzBJV1VWVHJ4M1AxQytxZjNRYzVVbTdCNFZVM2g5N29pVTN5UTEr?=
 =?utf-8?B?eThQd3hOcU1Fei8ySWtGV3c0QlEyL0xkVkw3d25teVpBSmg5RmhSWkRSK3Fz?=
 =?utf-8?B?Sy9HUEJMM1FuaGZnTDNEVjlWWDZZdXlzYUpxTWp0R0dWb0RaRkk1ZU4rV0k2?=
 =?utf-8?B?bkpmS0ZiTmRubUhtYjhHTDNjOXF3cDh0a2UzY0xoK2JOYkNCRTdjV2RmTU5S?=
 =?utf-8?B?TmkrYUtQMUwrUENVd0EyYXYrTmwvN0gzSGhpZkdVajNrZ2U3blJuK0pPaFVG?=
 =?utf-8?B?cG13YXJJd2tVa2taK1A1K2N3NklHYyt6amlCdlVuU1NHZ0dWWExNa2xZbVRz?=
 =?utf-8?B?M0lVRHFIeDgxaVIvaDlZVG03N0hRMUxRdnFzVzNuVDAwVVNGbHVkL3h6Qmow?=
 =?utf-8?B?MVR6alpreGVvWUZhVDMzKzNzbGcwVXJpVVdjdHVXL1FBQXFIbXpZNmNWUlJS?=
 =?utf-8?B?ZVp1K3puVHQveDgySUZuS05Pc2FTbHM0MnpWZm1ObXA1Mkp0dGhzZEFMWDBU?=
 =?utf-8?B?dTh5Q0xxSVBJQkpRdXV1dHVrUWFIOXdjeVlMRGdwMWYxaVNWNERaMlJDNmh1?=
 =?utf-8?B?M2NlMnpXL3JWL3cvalN4RllTa0RFQ1l6b2JIenVSa0FQR05QVlBLL0JaMzBk?=
 =?utf-8?B?dVVRTzI4eVVnaE5tTk5CQnpMSXVLeGlxUUVUb3BuYjdkK3FhZTg5dTM4WmE4?=
 =?utf-8?B?YXZSSURMMmJPRDYrTDM5VE1SS0dOdzJOaFJxZWdPYXY2RjRCZEkvaksxWW5W?=
 =?utf-8?B?M3hNV3VJSUt5N2NWaVJ2ZFJQeVlIc09SQTljKzU0UWQramYzbUVYLzFwN3Zo?=
 =?utf-8?B?bit2VlNiSmlIc0RRdzdzWmdFVnRaM0hhSGtrQjBSc2Z5aEVyMW82TldkaDdv?=
 =?utf-8?B?OVFnNEVkUElqK1FDOG9uQ2hRZ3FHb0hZd1c0MGU4a1RlSFhvZzM2VUJGZHpQ?=
 =?utf-8?B?cUJ5cjZYdGlWOVkvSlJ1UmJyZkl3RTBSalZaV1lRMjhKeWZnaGUzS3I1OEZo?=
 =?utf-8?B?UUpUV2FVODlvNHNUMFBodlVwYjhkNjY1Y0xwc01sSTFNRlZOZ0tBVUFHNzUr?=
 =?utf-8?B?NGt6c0tFZXp3NGc2cUdZQ2kwby9HNU0yTHRSK1pXM3VBaWpSb09tazdITWpj?=
 =?utf-8?B?SGVtRkdwVUxPaHVQNTg2UHZmc0wxV2g3ZWk2MkhwNzlVZFFkSmV3eFc5L3F4?=
 =?utf-8?B?SWdWVnNyR05rNDdYYVl2Z24xZ2hlVzAwSEhla1owREdLWkhkbkU4ZzZxSDdP?=
 =?utf-8?B?RVNzZ1JrU0xEaE9WbFdQbDlPdFRYb0xQU2p1K2ZsTmZNbnZoNEdGTzFYMWZp?=
 =?utf-8?B?WVROeDE0azF5RUFaaklhcTg1NVVPNGNPdkNPQUp4S3E2THE0SlB0dlNkMGlq?=
 =?utf-8?B?L2lnWlo3SldDT1RmTURoeGdSYnpQMzQyRVVpZEJrNllnY3UreXBQK1duVnUv?=
 =?utf-8?B?SGJXY3MrWmY2Yy9hWWxZb3NwZVd6Y2JwelJTcjdKVnBXUk1HQjRHaGd1MjNU?=
 =?utf-8?B?ajdDNDhkT3RzU1R6ODArZWtDdks0RUJTTWN5L3dMZFFyaU1ubHBrbW53bE9Q?=
 =?utf-8?B?ZmkraEVZc1VWZ0xjL0pkRXlobXBEaW9YVUNOTzl0Uk9XSDlaVmVQaVk2STJC?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <014A1A10948C8A49BDAC2B790C757832@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6235.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796ccd92-29d3-4e15-5b0e-08dcb12d5a42
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 06:52:32.5355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6IkfDY8waPZ/EBuRhwfIcT0x6TjX0w6eC7U6lJWD+i0p2OuOwNV16zzVuvrUEjP9dhmPfxwWz4BA4AP3EZxIZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487

T24gV2VkLCAyMDI0LTA3LTMxIGF0IDExOjI3ICswODAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
T24gTW9uLCBKdWwgMjksIDIwMjQgYXQgMDM6NDQ6MDJQTSArMDMwMCwgVGFyaXEgVG91a2FuIHdy
b3RlOg0KPiA+IEZyb206IEppYW5ibyBMaXUgPGppYW5ib2xAbnZpZGlhLmNvbT4NCj4gPiANCj4g
PiBBZGQgdGhpcyBpbXBsZW1lbnRhdGlvbiBmb3IgYm9uZGluZywgc28gaGFyZHdhcmUgcmVzb3Vy
Y2VzIGNhbiBiZQ0KPiA+IGZyZWVkIGFmdGVyIHhmcm0gc3RhdGUgaXMgZGVsZXRlZC4NCj4gPiAN
Cj4gPiBGaXhlczogOWE1NjA1NTA1ZDljICgiYm9uZGluZzogQWRkIHN0cnVjdCBib25kX2lwZXNj
IHRvIG1hbmFnZSBTQSIpDQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhbmJvIExpdSA8amlhbmJvbEBu
dmlkaWEuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBDb3NtaW4gUmF0aXUgPGNyYXRpdUBudmlkaWEu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRhcmlxIFRvdWthbiA8dGFyaXF0QG52aWRpYS5jb20+
DQo+ID4gLS0tDQo+ID4gwqBkcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfbWFpbi5jIHwgMTAgKysr
KysrKysrKw0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvYm9uZGluZy9ib25kX21haW4uYw0KPiA+IGIvZHJp
dmVycy9uZXQvYm9uZGluZy9ib25kX21haW4uYw0KPiA+IGluZGV4IDFjZDkyYzEyZTc4Mi4uM2I4
ODBmZjJiODJhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9tYWlu
LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfbWFpbi5jDQo+ID4gQEAgLTU4
OCw2ICs1ODgsMTUgQEAgc3RhdGljIHZvaWQgYm9uZF9pcHNlY19kZWxfc2FfYWxsKHN0cnVjdA0K
PiA+IGJvbmRpbmcgKmJvbmQpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoHJjdV9yZWFkX3VubG9jaygp
Ow0KPiA+IMKgfQ0KPiA+IMKgDQo+ID4gK3N0YXRpYyB2b2lkIGJvbmRfaXBzZWNfZnJlZV9zYShz
dHJ1Y3QgeGZybV9zdGF0ZSAqeHMpDQo+ID4gK3sNCj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qg
bmV0X2RldmljZSAqcmVhbF9kZXYgPSB4cy0+eHNvLnJlYWxfZGV2Ow0KPiANCj4gSSB0aGluayBp
dCdzIGFsc28gZ29vZCB0byBjaGVjayB0aGUgYm9uZC9zbGF2ZSBzdGF0dXMgbGlrZQ0KPiBib25k
X2lwc2VjX2RlbF9zYSgpDQo+IGRvZXMsIG5vPw0KDQpJdCBzZWVtcyBubyBuZWNlc3NhcnksIGJ1
dCBJIHdpbGwgdHJ5IGFkZGluZy4gVGhhbmtzIQ0KDQo+IA0KPiA+ICsNCj4gPiArwqDCoMKgwqDC
oMKgwqBpZiAocmVhbF9kZXYgJiYgcmVhbF9kZXYtPnhmcm1kZXZfb3BzICYmDQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgIHJlYWxfZGV2LT54ZnJtZGV2X29wcy0+eGRvX2Rldl9zdGF0ZV9mcmVl
KQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWFsX2Rldi0+eGZybWRldl9v
cHMtPnhkb19kZXZfc3RhdGVfZnJlZSh4cyk7DQo+ID4gK30NCj4gDQo+IEFuZCB3ZSBzaG91bGQg
Y2FsbCB0aGlzIGluIGJvbmRfaXBzZWNfZGVsX3NhX2FsbCgpIGZvciBlYWNoIHNsYXZlLg0KDQpZ
ZXMsIGl0J3MgaW4gdGhlIG5leHQgcGF0Y2guDQoNCj4gDQo+IFRoYW5rcw0KPiBIYW5nYmluDQo+
ID4gKw0KPiA+IMKgLyoqDQo+ID4gwqAgKiBib25kX2lwc2VjX29mZmxvYWRfb2sgLSBjYW4gdGhp
cyBwYWNrZXQgdXNlIHRoZSB4ZnJtIGh3IG9mZmxvYWQNCj4gPiDCoCAqIEBza2I6IGN1cnJlbnQg
ZGF0YSBwYWNrZXQNCj4gPiBAQCAtNjMyLDYgKzY0MSw3IEBAIHN0YXRpYyBib29sIGJvbmRfaXBz
ZWNfb2ZmbG9hZF9vayhzdHJ1Y3QNCj4gPiBza19idWZmICpza2IsIHN0cnVjdCB4ZnJtX3N0YXRl
ICp4cykNCj4gPiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3QgeGZybWRldl9vcHMgYm9uZF94ZnJtZGV2
X29wcyA9IHsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgLnhkb19kZXZfc3RhdGVfYWRkID0gYm9uZF9p
cHNlY19hZGRfc2EsDQo+ID4gwqDCoMKgwqDCoMKgwqDCoC54ZG9fZGV2X3N0YXRlX2RlbGV0ZSA9
IGJvbmRfaXBzZWNfZGVsX3NhLA0KPiA+ICvCoMKgwqDCoMKgwqDCoC54ZG9fZGV2X3N0YXRlX2Zy
ZWUgPSBib25kX2lwc2VjX2ZyZWVfc2EsDQo+ID4gwqDCoMKgwqDCoMKgwqDCoC54ZG9fZGV2X29m
ZmxvYWRfb2sgPSBib25kX2lwc2VjX29mZmxvYWRfb2ssDQo+ID4gwqB9Ow0KPiA+IMKgI2VuZGlm
IC8qIENPTkZJR19YRlJNX09GRkxPQUQgKi8NCj4gPiAtLSANCj4gPiAyLjQ0LjANCj4gPiANCg0K

