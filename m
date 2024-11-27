Return-Path: <netdev+bounces-147571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD2F9DA448
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 10:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3BD1658AB
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 09:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94AD1553A7;
	Wed, 27 Nov 2024 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k5S4g5Ke"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7451547E3;
	Wed, 27 Nov 2024 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698050; cv=fail; b=bwiPW982IB9/+i6oWmCdq7UFRbgavOoHduqZ8AP7JHx3mdmEU99HY55oSzdtGKY8y2WdnqxJrlgVr1FSb0LmjKqwZ+53AobMVrpK0MuOjXbSYZtzRsLXrugFkcuNrz0QWObAciPbOahA+NpiMwtz1KCkmB7vbwfLlnbSjr5hh4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698050; c=relaxed/simple;
	bh=z2LKs1qrZa/BXkapHbVvcNKS7djwR6J8dO4Yv/XKvj8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uMrSnNae7L7sGX9HCG03c1tmOzTIyvYG+ibGxSLA/gkwk4UaTcu3atdSQ6gyTL8WwRo/e0aFBsJZi1h7txI5jOmj1A6QB0yo2Rw92iA2KDIgMTXw0AeUGz6hVLGjhakOdd+kNZbIEomC/rMChCutazYbw0Y4oxXe84dV1E0QmXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k5S4g5Ke; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=El8ovCdyPx1FarYd/ymx1zNSupJjXa/HcPeuJUCa2lwNEYLOA646HeC+/C2+xLnq8IXv4M1lqc4WVqkZKFBBqR8Ew3WTuFHN+IrEdX0nVLnHWFxixAUHsmxStYzvpcKDecFRidUUE3dNi3Mqo/j6CQF+xVb5CA+LFaj96C1A0HZu5UuPHUQNg52qOcA6o41SrkR0IXePe5wq+6+8QXQgdMTH08/07f0p3syxyGoGhUIgEMzX7Y9jc+eUp2iytM5hXKcUJ1ZfTdfh9Lq3ontnxoOTtUHTw4u7qsfhcYwqWtVix6a4Xya33rOwkC7j14Nc2pt6WKHv87K5K52txvEwJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jj4LQSGy/Nh68vCXBqp4TYwCIhjonJdVj96tfqgAXBk=;
 b=kc3Pk40q5UR07iv9V1vc0B3b0pMH1stw+06CMv/kxu+VsLKqmdznJYGv/WSs7kmJ67ZqqIFwnCTUk4ARKrPlm8Q/rPIyeif498x9H/NIgFDYmKMFmeMkLEgK9+qA8tgJDeJTzsaAwcXY97jq0pf7mod97eCky87U/XyQAemfCBLPbV6FP275y8VtAbCRg2Svbc7QttTXZdY+u1FdX03kDb9Y9j9XLD47e7KXdgICQCuMz3y1VN0WBEfjKHKzjDuEvBudQ9rJxG9KhSk7bsP/kEWkxRtEL5X0ovZ2YUoBORUAihKXzQnSO14VCxz88tAfSw+E9uoK8jDn7iwoNg0MlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jj4LQSGy/Nh68vCXBqp4TYwCIhjonJdVj96tfqgAXBk=;
 b=k5S4g5KeOLyZA23aAldue2SnvZkIyDvZrRq7tzfhKYfBB4Yd9cNDsw54/y/h1q0Cmj7nb7UuAZdu1eJ9MHl19O+v15gBf0TGx8xI/hiRr70ex9ILtaJfTUw2/7jG5v8Gnz08uDkKxBhfFpcFlbNJn8cVcAL2XshZUDe3KAMY+g8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 09:00:46 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 09:00:46 +0000
Message-ID: <2c320f3c-907f-639a-6e5d-ecab8204172a@amd.com>
Date: Wed, 27 Nov 2024 09:00:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 01/27] cxl: add type2 device basic support
Content-Language: en-US
To: Ben Cheatham <benjamin.cheatham@amd.com>,
 "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, "Cheatham, Benjamin" <bcheatha@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-2-alejandro.lucero-palau@amd.com>
 <35be71eb-7261-441c-8677-355658fbcb4f@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <35be71eb-7261-441c-8677-355658fbcb4f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAYP264CA0034.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f::21) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: b24aa58d-1b94-4742-9a02-08dd0ec1fae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?am1QSE5BYU1MR05pODdNOXVIQ05WRVZHVklmbVY4RWhWTUtWRkZJbXNJMmtY?=
 =?utf-8?B?dGRwVGZMR1NKNmhOdjZETnhvNTVObG9yMlVmZ2ZGTnEzdVdORElKVDB4c3ll?=
 =?utf-8?B?OTJsNjlkYnZEQXUxN3NlQnpHeEVjY1pNeHZBalpOeGdLNjdwV1RVWklXTGxi?=
 =?utf-8?B?YU1kbVJIUDc4K3kzb3pVUHY5dFlvTnhhTWZ6Tkxlb1JSMURqU0I1SE9uQzBK?=
 =?utf-8?B?VHZjeVJ5cEFJQjVRUDNZMm4rdTFZSldRWFVUaFlIUmFqZmlTdUFzK3lTWDMy?=
 =?utf-8?B?dlNsdVB1Z3ZCUHpRUEw1M3VaVG1OeUZHNmtTb2grem45Z1Y2VDJaRDJSdTZM?=
 =?utf-8?B?cWNRQitXamJQUzRIMVQ0NGtWdGZxelU3V0VrU2JxY1pTeEVENUtoOVZqRnVj?=
 =?utf-8?B?YXlTamtNa0IzWkNOTUFRTnhHT2NRWDJoTmNzbFhIRUFkdzM2Qko0VDRhZSs3?=
 =?utf-8?B?dUJ4ZERiL1lncHZPcGpCcG9KRS83RE51dzJ2cTRWL0poUHdOZVBuWTNVRHlD?=
 =?utf-8?B?THhOSFhackI0aDBsc28weVAzZEpLWGNzRXNXa04rU3p4Y2VsZXJCTTZRMDgx?=
 =?utf-8?B?MFNFekNpbWJJbExNeE05S01aUDE3YmJqYXIxK0hIczFBL0lRUzdWbEQvZ2VI?=
 =?utf-8?B?aWpQYnpXNld1M3cxbDVVMENkOXJGUTE4MG9seWFxQzB4TkhMN3dZbG5GZnp0?=
 =?utf-8?B?dmxaRzUxUmF2bitxQ0MzM2E4bXVJWm0wSU9Eb1N1dlNRaGVpWkhtWkJxMWpn?=
 =?utf-8?B?aFlYazZzSGhZb0dwaCtlNjhIZkhsa2dSL05qajVxQVl6a01rdzFLQTRsclNh?=
 =?utf-8?B?YVZFb2JCQjVmRCs5YklHY0pNSDFYVnlsQVVNV0hpNjdJb1I0eHVuWVVIN24r?=
 =?utf-8?B?aXErNXpQa3lFYVEwOWdUaFJiYjN3c2wrdGI1a3I2eTR6ZVRXYTVwTkJadmFY?=
 =?utf-8?B?WnQyd2hKN2tJRXF6UTVzb1RjYlNuWWhlZE5XalBzUmhBejlJZFc5aUVDazJH?=
 =?utf-8?B?b1hVTDZpN0prdzhpWXlpem9nYklxZW10RHNEMzhRTm9QVG9DVWZYRGY2bFNI?=
 =?utf-8?B?SjNVZDJtazZ2MnpvOW9EU1h3TzRReGpiU0VMZ1pvU25CS2p6TVQrWFVkTWY4?=
 =?utf-8?B?Z21tenc3OCtzWFVFOWYwNXhxUXB6S1JaZjFKSDY0TFdITkhQUlpXbVFLZGs2?=
 =?utf-8?B?Rjc1dkl1SWpPd0RLOUFWMzFMT3c1V05tcXBLN2pWYUg1K1YybGhBd3F5QzJY?=
 =?utf-8?B?N0V0NGdpTDBxSHVPNy9zQ056SW1xQUgzWThyNFAzbml3bkxEZExzYzBGdU9F?=
 =?utf-8?B?aFF3SzRST2t5V1ZQNWVKOHRwK1pnaWNvcjVyS1ZINURObWxBVDVnTzZMeEhk?=
 =?utf-8?B?ZU1JN003cE1POE5wcXVWdVgxdzZjYm9xWjZwV1cwV2JZV0U1eVVGT2luMzNI?=
 =?utf-8?B?MFJmaDJKWGM0RVZqSWs0NzVuMW8zMmxkeFpvTkRMZkx6UVB3WHNyYnlreXkr?=
 =?utf-8?B?WnhhdkxCKzFqai9vR0p6QURaamFwclBaS2Y4NWZMVzUzL1MvOFNncHNVdFlz?=
 =?utf-8?B?bTAvRGtnd0FXa3g3cnErbFRyREUyODVQcDJBZHhDOWRZVzNoanF0c2ZwMFo5?=
 =?utf-8?B?d3NrQ2VhYUlza3g5Tm44MXpoUGJNeHIxWFJ6M2l3THpUWi9nYWduS3lIN3NP?=
 =?utf-8?B?MjNST0RLbkxUeHBBVldIRFFza25pQUcyZEpCQTZWZ205MnFjTGEwVVROd3hI?=
 =?utf-8?B?V1cvYlBsb0Y1TmRDN0FNbWhxbG9VVjVjY2VtWlJZWUJQbndtM3NTRWpDcGRN?=
 =?utf-8?Q?0oWfZtk4lBTymKteepjLDdlnhr0cMr061WQE8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2dZRVd1YW55b2psWGJYckdlY3RxYkpldzVtSEEzTmZKdkNGNjgxMlRMY3I1?=
 =?utf-8?B?MTRBdDNEU2RqS0g5QU43R1JqbUpiZjFBZk5lcStBRUV0ZjRoazJYUzRWZGRB?=
 =?utf-8?B?S2t0UytEZ3RsRm9rS3dSd1E2TkJHQ3hzSVFIb0M4K0tUdk10R0gzQlYyaXIw?=
 =?utf-8?B?WDBKQmhwMy84TllhYzNXSGdlVzRTdjV1WDkzOVVHaEx6SXNod2RHOFhxZUJW?=
 =?utf-8?B?NWUycUxGbzF5WHhOdUxXR0x5OVNXNFpBSitCNGQvVG11VHN0TlM0R1VhbVdH?=
 =?utf-8?B?VFc5T3N5RURzMGwyZTdRUVk0V0FpYlpJWGhIVFBGS2xSNEYyT1hsYWZhUE9J?=
 =?utf-8?B?Wm1lRmhYM0xXT1FPNEVFSlFuWUZTYWtsdTJEOTRId3NCZlZmWkhZZE1EREU0?=
 =?utf-8?B?WWNpdmNKVFVleDdxVXEyV1NPUkJiVlZ6Z2pSY09WTmxJUUk0Sk5iK2pFZmFn?=
 =?utf-8?B?WGthTWtjWDVRRy9OWTVFRC8rRVByRGs0L1FzSzM3NTQ4cXJBYlVYTmtacjFU?=
 =?utf-8?B?UFJOakhGZzNVTlpJRko0YzJmbWcxdEJNNkQ4a1g5K0w3bjdMaGRsbWpUR0lv?=
 =?utf-8?B?ZW4rTkM2aEh3VldOdERaTXNTckRCRnlSVG1NTXBHSTlLbzFOYmhQWFhZZzFP?=
 =?utf-8?B?U1FTbk9SUDBEL042Q0hYK2JKaWJkUE12cG41SmVvK1lTVUVPKy9ab0VaVFJx?=
 =?utf-8?B?a05iYnpMMU1nbFZVMGZIanBPU3E3MzJVcXlVeTA3cnUwRGM4TysvYzhuRU1r?=
 =?utf-8?B?QlpMZXE1NFVyK1BIVzRmbi9wblFINjhoMlpZMmgzS2NHZlBMVnVqTzdWWE93?=
 =?utf-8?B?c0MzdnIwOXBoN2RjKzB1dmF0TTN1aWFGejFobDljTmQwdHo1V29RWlRCcm9l?=
 =?utf-8?B?U1FoWGpVMzNMMzVUYkUzYitYbWNWZ1MyQU1HdmsyU3ZhVUhKSjkxcU5FS1Br?=
 =?utf-8?B?eWhId3ZYbzFlenFiUUdJWW5tVFZIM2tnUHRtNTROTzZmUlVrVXYyYzdpWkEx?=
 =?utf-8?B?S2REMEx1T1VCT0p6MXVlYTRJN3ZIVy9XV1JkODQ2U1JQWTkxZ3pBQ3RLMlRn?=
 =?utf-8?B?WjQ2d3Vxa0laeXdPZ2ZiUnA5WGFPSytOd2ptaU14YWs0U2FNYVRUQ0hSaWE1?=
 =?utf-8?B?bEhlVVlHdGhkVSt0alRCYURKSmZtTUdtdnh0cVpUaGdqMzM4MUtlYVBLbHlH?=
 =?utf-8?B?R0kwbFhFYk5zK3ZMc05ISlI0d1JPeXdYc3Q1YkZ1TTlzbytUWmozT2xNQ0pL?=
 =?utf-8?B?UmVoa0ZoVTg3dDg0WHQ2N2g3L0xpS0hRZ1VVUjZDT1Vjd1AvWFlkQzZ3cFZY?=
 =?utf-8?B?N3VQUmNQeTB0WGx3Y2FMUlRraGUyUUx2M3NOWG5td2RkOENxaCsyQlRFdVha?=
 =?utf-8?B?SHdSZndmKy8rU3lXWEVxNjJ1Z2lpVXhaSUdVVlptOERwdUdwbUJaT0w5R0xa?=
 =?utf-8?B?V0pqQXlkTCs4TFNLbzYxYXd1dWl5TFF0bW1MNThCSXRndFlVZVplTndLdXVo?=
 =?utf-8?B?VU95OUdXNHB6R3BYaHV6REJRVUZUNTNxck8rOXl5Um9rOWR1WmF5QTl4SEtj?=
 =?utf-8?B?OGVHRVNRbElPQ3dMK2pvcXlEeC9iZXRjZ1ltdFdkSmcvU3psbW95N0VVWU5W?=
 =?utf-8?B?eUt3WFFTTVA2Sm16MTBuQWpRN3E3UG9oWUwvY2wvUm9TbW8wN3ZYVGRja3dR?=
 =?utf-8?B?bGdvcmJpdmpab3hlcGFDZm1pcTdsY2s1ejdqT05ZTkxsTVU2WHFHRzdwWEND?=
 =?utf-8?B?eHRiTDlTa1dCVDJ5cHZjem5xMEtjMlQrblpoVkFQMDg0TkpDcVc3VVRuTFZh?=
 =?utf-8?B?M1RBQXdzb1ppc2hvSlBFeGhlT1RraXVzdHBoR1l6T0NoMDJ2MVpiZ1NMeW1l?=
 =?utf-8?B?UDNOZWEvSEEvRUFFUkdxd2srV09sYi91UmxZMWs3Z2M4b2dURUpjSUlJcDk1?=
 =?utf-8?B?Um9JWHVNR0t2UTl3RnZzSmkvaElhQU5xZWpwN1VSL0dOODBKSzZhUVZ4WkZi?=
 =?utf-8?B?c2FBdFZpSlg0VmNZZFhCTEJGTEJUdUxpSW5VTTlpQThhMzMySWU0aGlKT3lj?=
 =?utf-8?B?SkM2aG1SZm1ZenJxR1lKY2JzcFUrayttclNzWUovSmRZM0x4RjdFamQ3QWRK?=
 =?utf-8?Q?PowSlrcdfyXnxL5NxJTzX3JIj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24aa58d-1b94-4742-9a02-08dd0ec1fae2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 09:00:45.9887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgFV0hUpyhxLM3lhY1q/Y3Lenh6HnenXNoNb6zJltZHN7a3eKIKrtSvWUXjVYh1X6pIehxdt4BUT3o71F4Myog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302


On 11/22/24 20:43, Ben Cheatham wrote:
> On 11/18/24 10:44 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differentiate Type3, aka memory expanders, from Type2, aka device
>> accelerators, with a new function for initializing cxl_dev_state.
>>
>> Create accessors to cxl_dev_state to be used by accel drivers.
>>
>> Based on previous work by Dan Williams [1]
>>
>> Link: [1] https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/core/pci.c    |  1 +
>>   drivers/cxl/cxlpci.h      | 16 ------------
>>   drivers/cxl/pci.c         | 13 +++++++---
>>   include/cxl/cxl.h         | 21 ++++++++++++++++
>>   include/cxl/pci.h         | 23 ++++++++++++++++++
>>   6 files changed, 105 insertions(+), 20 deletions(-)
>>   create mode 100644 include/cxl/cxl.h
>>   create mode 100644 include/cxl/pci.h
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 84fefb76dafa..d083fd13a6dd 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /* Copyright(c) 2020 Intel Corporation. */
>>   
>> +#include <cxl/cxl.h>
> Pedantic one, you'll want this at the end CXL does reverse christmas tree
> for #includes.


That seems to be true for this file, but the reverse christmas tree is 
not applied through all the files in the cxl directory.

I was told to put it in alphabetical order (not remember which specific 
file), what implies there is no agreement about how to put the header 
references.

Anyway, I think for this one your suggestion makes sense.


>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>   #include <linux/firmware.h>
>>   #include <linux/device.h>
>> @@ -616,6 +617,25 @@ static void detach_memdev(struct work_struct *work)
>>   
>>   static struct lock_class_key cxl_memdev_key;
>>   
>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
>> +{
>> +	struct cxl_dev_state *cxlds;
>> +
>> +	cxlds = kzalloc(sizeof(*cxlds), GFP_KERNEL);
> Would it be better to use a devm_kzalloc() here? I'd imagine this function
> will be called as part of probe a majority of the time so I think the automatic
> cleanup would be nice here. If you did that, then I'd also rename the function to
> include devm_ as well.


This is complicated. As I have said in other previous reviews regarding 
use of devm_* by the sfc changes in this patchset, it is  not advice to 
use them inside the netdev subsystem. This is not the case here since it 
is cxl code, but in this case used by a netdev client (although other 
clients from other subsystems will likely come soon).


So, I'm not sure about this one. I could add the specific function to 
use when released like when cxl_memdev_alloc is used by 
devm_cxl_add_memdev, but frankly, mixing devm with no devm allocations 
is a mess, at least in my view.


>> +	if (!cxlds)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	cxlds->dev = dev;
>> +	cxlds->type = CXL_DEVTYPE_DEVMEM;
>> +
>> +	cxlds->dpa_res = DEFINE_RES_MEM_NAMED(0, 0, "dpa");
>> +	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
>> +	cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
>> +
>> +	return cxlds;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
>> +
>>   static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>   					   const struct file_operations *fops)
>>   {
>> @@ -693,6 +713,37 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
>>   	return 0;
>>   }
>>   
>> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
>> +{
>> +	cxlds->cxl_dvsec = dvsec;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_dvsec, CXL);
>> +
>> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial)
>> +{
>> +	cxlds->serial = serial;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_serial, CXL);
>> +
>> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>> +		     enum cxl_resource type)
>> +{
>> +	switch (type) {
>> +	case CXL_RES_DPA:
>> +		cxlds->dpa_res = res;
>> +		return 0;
>> +	case CXL_RES_RAM:
>> +		cxlds->ram_res = res;
>> +		return 0;
>> +	case CXL_RES_PMEM:
>> +		cxlds->pmem_res = res;
>> +		return 0;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
>> +
>>   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>>   {
>>   	struct cxl_memdev *cxlmd =
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 420e4be85a1f..ff266e91ea71 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1,5 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
>> +#include <cxl/pci.h>
>>   #include <linux/units.h>
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>   #include <linux/device.h>
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 4da07727ab9c..eb59019fe5f3 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -14,22 +14,6 @@
>>    */
>>   #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
>>   
>> -/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>> -#define CXL_DVSEC_PCIE_DEVICE					0
>> -#define   CXL_DVSEC_CAP_OFFSET		0xA
>> -#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>> -#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>> -#define   CXL_DVSEC_CTRL_OFFSET		0xC
>> -#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
>> -#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
>> -#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
>> -#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
>> -#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
>> -#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
>> -#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
>> -#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
>> -#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
>> -
>>   #define CXL_DVSEC_RANGE_MAX		2
>>   
>>   /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 188412d45e0d..0b910ef52db7 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -1,5 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>> +#include <cxl/cxl.h>
>> +#include <cxl/pci.h>
>>   #include <linux/unaligned.h>
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>   #include <linux/moduleparam.h>
>> @@ -816,6 +818,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	struct cxl_memdev *cxlmd;
>>   	int i, rc, pmu_count;
>>   	bool irq_avail;
>> +	u16 dvsec;
>>   
>>   	/*
>>   	 * Double check the anonymous union trickery in struct cxl_regs
>> @@ -836,13 +839,15 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	pci_set_drvdata(pdev, cxlds);
>>   
>>   	cxlds->rcd = is_cxl_restricted(pdev);
>> -	cxlds->serial = pci_get_dsn(pdev);
>> -	cxlds->cxl_dvsec = pci_find_dvsec_capability(
>> -		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
>> -	if (!cxlds->cxl_dvsec)
>> +	cxl_set_serial(cxlds, pci_get_dsn(pdev));
>> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>> +					  CXL_DVSEC_PCIE_DEVICE);
>> +	if (!dvsec)
>>   		dev_warn(&pdev->dev,
>>   			 "Device DVSEC not present, skip CXL.mem init\n");
>>   
>> +	cxl_set_dvsec(cxlds, dvsec);
>> +
>>   	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>>   	if (rc)
>>   		return rc;
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> new file mode 100644
>> index 000000000000..19e5d883557a
>> --- /dev/null
>> +++ b/include/cxl/cxl.h
> Is cxl.h the right name for this file? I initially thought this was the cxl.h
> under drivers/cxl. It looks like it's just type 2 related functions, so maybe
> "type2.h", or "accel.h" would be better? If the plan is to expose more CXL
> functionality not necessarily related to type 2 devices later I'm fine with it,
> and if no one else cares then I'm fine with it.


I agree, but I did use cxl_accel_* in version 2 and it was suggested 
then to remove the accel part, so leaving it as it is now if none else 
cares about it.

Thanks!


>   
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
>> +
>> +#ifndef __CXL_H
>> +#define __CXL_H
>> +
>> +#include <linux/ioport.h>
>> +
>> +enum cxl_resource {
>> +	CXL_RES_DPA,
>> +	CXL_RES_RAM,
>> +	CXL_RES_PMEM,
>> +};
>> +
>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>> +
>> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>> +		     enum cxl_resource);
>> +#endif
>> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
>> new file mode 100644
>> index 000000000000..ad63560caa2c
>> --- /dev/null
>> +++ b/include/cxl/pci.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>> +
>> +#ifndef __CXL_ACCEL_PCI_H
>> +#define __CXL_ACCEL_PCI_H
>> +
>> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>> +#define CXL_DVSEC_PCIE_DEVICE					0
>> +#define   CXL_DVSEC_CAP_OFFSET		0xA
>> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
>> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
>> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
>> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
>> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
>> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
>> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
>> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + ((i) * 0x10))
>> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + ((i) * 0x10))
>> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
>> +
>> +#endif

