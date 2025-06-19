Return-Path: <netdev+bounces-199286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90780ADFAB3
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 03:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21C71890E80
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 01:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5442B9AA;
	Thu, 19 Jun 2025 01:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gjY70vhx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0968D522A;
	Thu, 19 Jun 2025 01:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750296833; cv=fail; b=H5Kn+TYuhLZLL0t//cdw262Xmz4r7JZMVoqrwMUiqzP1PFhRttgTXCqE9Cm7tpw2ZZHbwn/MHc+Y1qzKyavSmrb67rFbrf8AtQ1RE76HtbTjHBCDAwYzeR9UC5e5GifTTsJ7xBQEvzg4Xo5l7amh4ww5Ngiq99IFJubkgTA8xWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750296833; c=relaxed/simple;
	bh=jQNNdNM2P/IsdJtXsF42RjjbPgGdZ4QVkIzTPg19G5M=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fEQRBzrX90tRfCOZVws39ar/8XqwqxSRzqHrg5nkPFwJFpcHgU6tMAx/MvgYzRUlR3UWx/ftio8gI35z7+m0HZgr/7OHKMRtqu4z900wHfbKeUt8Q2n4VaTY3sSS87onuMXdnQQ0nXbevNchTqxlJPyXdcMmU1+IF82Sv3GIcY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gjY70vhx; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJz2uhmWCiFOYzAzDEtsUyvjJXHMgqXMQXXB3VZ7E1jqrO8ayULNjgD0eodXVtgC48NZzPreB9l3W+IMHXtgwsJJQKHJur625oG6LlNFnseZDLOW7VswroIWbueYx398r4gX2/+NaiNURPzgzPyRT2dzS1tp1I7sDwfj70YRSMCy0g4bTna0kRkc92htkjhwMKO/HTMSVrDUwpI96Evzw2sgYXQlVmMjswmx0+RKWUUJjLctt0KG00kdC+ncWJu9cNkiXL/ZjQLsVP0QrTnH3Akrx4Lmvd39qqSlr6ik3p73/q9QkMNkBbfeVOByWC9PQ2csoPDORJEWs8OuD2Co1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQNNdNM2P/IsdJtXsF42RjjbPgGdZ4QVkIzTPg19G5M=;
 b=AY6zM6G5ohbfdjfF7cMTlDqQus6eoVl1IPnSz86VCVJYVp9vDbwuYIwrkrr8cm5X2+AC3BlzdSFZXTRQaDzpSCh9suytBPUdF1VBPn2oYmnCa053m09S7DELYWzHsCXV8ZPNlWVZqXqeh67t413Ngh5Pka6tkY0KBCyLca8v1wiEQsTYPrkWN5/KAd61CTtCn9/TtDTlhR8WsUGPxFi0fvQwfVzWEfJW+u0ZPEByfEYqYSHs8LAFbqDjBAg5/8dXuNUnv2C7e+hliiyfaJlgf0KcuMPy3nhdvxoMTja+vFzFrRhVx2es+X5J28BgPogmR7hRa5J7A0xbULx/sbAwdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQNNdNM2P/IsdJtXsF42RjjbPgGdZ4QVkIzTPg19G5M=;
 b=gjY70vhx/Wdf582aqrM4FqGabkN1d4UckjJjyg0Eqp2dFthuwVmvwIXFm77H1bE1BHbXmDrfHrAT3E5jq2BM2NbZUvU5bgrmHxqoZsGS1YpY+xKU3Zy1Jydayf7+COhL05DDODPruKxS6B6L60XKn7TSeH7NPEVwhqIIQuWPkZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.33; Thu, 19 Jun 2025 01:33:49 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%6]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 01:33:49 +0000
Message-ID: <a49f5447-eb5e-4b3a-9285-903536c71af7@amd.com>
Date: Wed, 18 Jun 2025 18:33:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] mailmap: Update shannon.nelson emails
To: andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>
References: <20250619010603.1173141-1-sln@onemain.com>
 <b58b716e-a009-4b9a-a071-3989662e9652@onemain.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <b58b716e-a009-4b9a-a071-3989662e9652@onemain.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::17) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c621be-f80d-40ec-2e07-08ddaed1570d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVlCZ0UrRkoyQmJHRjZBVHEvYk9mZlJ1L245OUVHejV5ZHRLR0l4UFVrbEQy?=
 =?utf-8?B?bVBBQjlPK1dVaE1oR0hWajIyektFOHBXWXZma09vTEVFM2d6SWhJZTlHek03?=
 =?utf-8?B?MURsNExDUjI0bDVYVFJEaGNPSmhFQ2tnTlh5bHFFUGRQcm15dnRKWUJYTkUr?=
 =?utf-8?B?eUZWaTlCSWE5U0Nxbnhpc212K1drSUEyaktpQ1kzck5xekJLTW00U1hWMXRn?=
 =?utf-8?B?TUNwbzRpZXJrVFh6cDhkMTBTUDFKVThrbll0ajJ1cmJNeXRLNGt4Q2cyeFFs?=
 =?utf-8?B?dHZnM1V4UWRhZEJVUmIwTEMvUzQzL1p5NlNZMHY0N0doSURIV1V0VXEwQzlT?=
 =?utf-8?B?cWc5M2xjdDFHTThkSGREeWFxUkR5aTB1aWd3WFlzdWlBeDU3a0IrSVZQcUpr?=
 =?utf-8?B?RDdLbmVWb1gxSG5Db0lrUTVIVTUzU2trUGRCRHByZ0NZUHVoZFhZaVc1YXB0?=
 =?utf-8?B?NnpxaUV6amlnMXhYSVBBSytkMnNldHBsdGhyOFBOZEpyY29UQnhsa3JKdXpJ?=
 =?utf-8?B?VDljRjByOXR1Nmx5bGNYR0xGSXlLRFhBSFdmNjA2VFNYRk5PY1dxTXdQV29I?=
 =?utf-8?B?WEgzdU5hWVdQMGFTbTBwTVlaQ25Lc3dCNlhodzBEZnlPNEZRNCtjU2NGM0w1?=
 =?utf-8?B?bUs1dGFxc3l6Y2dETU5idTg4eEIxdXBRR05zN1M5RGVaM0pNN3VwQVdvT2RH?=
 =?utf-8?B?YkpjTnozcjNyWlZVajY3U0YxSThPMkdHeHd5bUxDNHV1YzVZQWM2ZEVaWUlj?=
 =?utf-8?B?VjZQK2Y2elo0SUlhaG12c1JaL3k1NDREdmxxeC92SkZrWjJlcFdqWGVwcStL?=
 =?utf-8?B?Mm44VmVxanN0U2M2RCtuQ3FTODJPWHNYQlNPY0l5NFA4SFYrWERiZUNkV2Zi?=
 =?utf-8?B?YkZHUkhmeERERHA5ZjRIUG0rS29uMkxvejErTWhtaEJWYko2b1BFVUFzQTNo?=
 =?utf-8?B?ZXFpazBKYTk0VWE5MkljL2hPZUNESVZUWnMwdHlVK0JCdEc5VWEzQjRWQzlF?=
 =?utf-8?B?MkhuQVNuZkM3MllrWk1MMU4zanRjVVFRZjFXb0dmWkdFWTd2S1NuclpVSFR5?=
 =?utf-8?B?UVhuaUl2aWFQUU1XU0huTEo1RWd4bTZHSVI1MjhlQllpbzUyTzFUcy9qSlhU?=
 =?utf-8?B?cTRCRzB4REI5Z01HSVlBOHlBVmdWemtSRjVyaEU4c0JPY2NpTld4cER4OE43?=
 =?utf-8?B?ajBqdElHODB5N3UvbElEMno4a29TQjB0V1NiSS9SVDloeHZ0aGtoZnVXS1hx?=
 =?utf-8?B?eVFwdFRrZjU2NHNBcVV5QUtsYmg4Q3RLYzRWY2laMXRDdEYwZklidjd0RXVK?=
 =?utf-8?B?SXE5S25aWEFwT2I3bVN6dWhWMUpqbTA0MGQ4TnRuSUROYUczMnk4YWtNRkpX?=
 =?utf-8?B?bG1wQmZWZHh1cjd4aVdyRFdxZFpudjhBZXVHenUwOGFBS085S1hxaGVOckx6?=
 =?utf-8?B?QjE4RVVQSm1iVk5TOTAremZEREw5SGxoTjE0Wjh2QXd1aXVrVEVURXZOcFJS?=
 =?utf-8?B?dTVrcjRpUDFNTXFCY1AxeXkzRlJiZnFhaWk0cm1QZ0hKZUt3SHo3alNtcUFT?=
 =?utf-8?B?eTJjWmc3OVBLaytkUUFwOFc0ejQ0Q3Q0K21JWmt0QzgvSzZGakgwWWJ5aG8v?=
 =?utf-8?B?VW5UQ3dEMkwzQ21TQUVXdFpxajBsRTZMY2hpRGRGMDlWZWF5azFKL1hleEti?=
 =?utf-8?B?KzZVWHM4R2FoQXVXRHZ6K0NGVVNVQTByM3F2WnQyMmFQSTRiWE1mdGh2eHhi?=
 =?utf-8?B?OTNsUFplRHByY3c5NTY5Sk5UN0pSblRxL1NCcExpSmc5cSt1eUYyRC8yK20y?=
 =?utf-8?B?bk5SRzJ4MnFhWUZ4SnRNV3hyYW8zakhPREN5NW1FT2x5N1psMHlLV0o2cEZr?=
 =?utf-8?B?bWI1NFUrclh5MUhEb2NkWFliWkZ5VFQ5MmhCZXdSVmQyUGpCdTdHYmxVcWlJ?=
 =?utf-8?Q?p3AEoKaXSNA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L00yVnNidktURzY2dFdzUnJlemVoSythWENiT21rRHlZUmNMR1VzcmFYb3VE?=
 =?utf-8?B?NXhPSzQ0VloxWE1TMWxsdWl2bFh1SFc1Q3hDOWsyZnJJSWdmSFdwNmFMNFND?=
 =?utf-8?B?Rnkvc3EyNXVDVGpMQ2VlZldjdTllQ2cxRS8zcVlnWXExUnpKTG1FMFR0bWo5?=
 =?utf-8?B?dnVpNVpFQ0YvQVF4MklSbVhOa1ZzU2lzN3ZEMG9kOWt6RnRJTlpSZTNYM3A3?=
 =?utf-8?B?SU5PMWZZNWlBTzFSMFJBZ0U3LzZUNHpxN1NVS0lLVzBCd2gza1ZLWEdtRTRB?=
 =?utf-8?B?ZTBpWE53TGVZaGRFYS9MNFUzQ2dYeFVrTE45UWtMaE1FclBoK0hhZE1Rb0ZV?=
 =?utf-8?B?cktHVDJ4UDljQ3pSaWc2WUdXaVdkQkR5dDlRbEdablRIM0gzTWVxMVlBK0Nt?=
 =?utf-8?B?R1lRSytWSUI2ai9DS25teVp0WEJrbUZHamJpbWMwVXQyWlJYZ2EzSWxTZUlv?=
 =?utf-8?B?WGJmZ004Y1FCczVLK2wwOUd2NE9pWjRFL1NzeXFxTkh5VlpaUWxIQzBSejAy?=
 =?utf-8?B?bTBSS3JlbERtTU4wUnNJZkRobXhUQ08xcHRjL0VpOU9oQ1JqdDJwK0thL1FI?=
 =?utf-8?B?UUs5QTJKaTJ5bUk4VXFFeWs2UnhKbzdNdFdObDFGUlJLWGo4RHFWa2xJbmJ5?=
 =?utf-8?B?RlJkUm9ZSnF0dWxqRXlXZk1MbTIrNzkzV0lWV09UcTVOek1YOUNWSnZtMUVG?=
 =?utf-8?B?Vndidk1oUDloZkZZT1AveGVLRDNwK1Z6U2hXZkd0RmxtR1ZmQ2lWeU5JYlBp?=
 =?utf-8?B?YkYra0J1dkJORVVYd0dSekRGUG9zREJydC83V04xRmJlNkR2ajUwbGVXMnhs?=
 =?utf-8?B?aDlqZUk1NWpHOE4vR3NlR1NBb1FCYlFja0FJcWs4RjIvMVFUTk5pN1M0cnBv?=
 =?utf-8?B?a1ZNZHFoby83VEpnSXZvK3hmNHBTc3QyLzU2VVcwdk56cXFOU3duZEkvMzFN?=
 =?utf-8?B?R09RS0wyT3B3OFI4OG53Vi9PZmpubDFsK2wwRUNSak1DYzk4MGtnU0twbWV1?=
 =?utf-8?B?bFF1TFE2TXNncDF1YWhoNGZYRVAwR0JVazVuMTIrMzNKUVhHRG9GaFB6UU1m?=
 =?utf-8?B?cTFGdEFVZEpQWmFKMHRvTkJiQTNaa2IyOGpKU2d5bkJjL3RaSVgwOFdqVUhY?=
 =?utf-8?B?YTIwTFBDYS95dmFYRko4N0hpRExTMjZ0S1lvMGxxREwxU1dPTkNzTjVGckpu?=
 =?utf-8?B?T1ZmdnFQbEtaRnZTSDNMQjdHdHovQ04wbnpsRVcxay8xeHZXcmxUOW1rQ01O?=
 =?utf-8?B?YnBRSnRCSmxUTlJjeWYxNk9aeEx5UUdtTk5JY0RjNjk3OGFVNXhUK3RmU0Nm?=
 =?utf-8?B?bUFvWHhrTVVMdFVxajJieTU0TWlVeHNUeVBRandCODU5RFJ3M2FoYnJQeU5F?=
 =?utf-8?B?RWd1L3hJdm93ZnpjcXFZdE12amdHTmRlejBLNjV6SmluVEFpYko4ZkhubG54?=
 =?utf-8?B?UFFnR2QrRzA0Vm1sSlZXZ3dYZ0pTbDc3cW56eW1odFc5TXFyR3RGUlM5N2Rw?=
 =?utf-8?B?V2FRUUFnc2pXY1czZmgyWVpyKzN2anBMdXNRTnhSc2NQOHViVW9hQzR2MGJZ?=
 =?utf-8?B?RkhqSXg1eHp4c0U3dHJJT1V3eXZVMXNESWJSdFBTc01aQlB0M21TRTFuRGxS?=
 =?utf-8?B?T2RoVURycE4yL1VCcTBza28xR0lZaStxdlZZSnF6Y2NBN3k2Q1I5SnRHenFz?=
 =?utf-8?B?dGRvK1hXNEFJYjFjYyt4QlRCNmNrQUY3cVl1aWorSnNTVVdFTm5YTE5pK3d5?=
 =?utf-8?B?TG5uajRaMjNndGg3bzV5THIrZk1wU2Y3citqbEd4Y0s5eWlvbFRHaEhyNkJa?=
 =?utf-8?B?TWRYeUlLNEN2U3ZFNTBUbXBMMEl6UXkvL3NkWW1Nc25IOG9MdVVaMmFQVmxv?=
 =?utf-8?B?QWk3NnpvRktBVEhjeHFNZlIyaVFHNHljbFppU3NrcnpvaXdiRzVOaDBDQjQ3?=
 =?utf-8?B?cHpia2pSWDZoVldZVTJxQzV0WHdoUDRnalBpUExlanVmN04rcjJEVVZ3alBG?=
 =?utf-8?B?dkhseEE0MFBPTFpvTytkMmEvbVQvR1lVYkdnUVEvQ0ZuVHRibitWL2FmUWpa?=
 =?utf-8?B?Y1pPd0NTT3ZFUFM0YW9YNjlrL0xzUEU2TUl0cDFTUnhqTkJDem9CTnFMZHF5?=
 =?utf-8?Q?5nRoZN6dnYtIS5qHOzXZKQ7I2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c621be-f80d-40ec-2e07-08ddaed1570d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 01:33:48.9838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LR8kA0/N3X2CD94pCjTAs4UFUK2TNJBtxIjOVRFe9CW2lLxU53IaAYNh9+ijR20/Pn1jlj8ezEnxSsZe7B+Gzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538

On 6/18/25 6:06 PM, Shannon Nelson wrote:
> Retiring, so redirect things to a non-corporate account.
>
> Signed-off-by: Shannon Nelson <sln@onemain.com>
> ---
>   .mailmap | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index b77cd34cf852..7a3ffabb3434 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -691,9 +691,10 @@ Serge Hallyn <sergeh@kernel.org> <serge.hallyn@canonical.com>
>   Serge Hallyn <sergeh@kernel.org> <serue@us.ibm.com>
>   Seth Forshee <sforshee@kernel.org> <seth.forshee@canonical.com>
>   Shakeel Butt <shakeel.butt@linux.dev> <shakeelb@google.com>
> -Shannon Nelson <shannon.nelson@amd.com> <snelson@pensando.io>
> -Shannon Nelson <shannon.nelson@amd.com> <shannon.nelson@intel.com>
> -Shannon Nelson <shannon.nelson@amd.com> <shannon.nelson@oracle.com>
> +Shannon Nelson <sln@onemain.com> <shannon.nelson@amd.com>
> +Shannon Nelson <sln@onemain.com> <snelson@pensando.io>
> +Shannon Nelson <sln@onemain.com> <shannon.nelson@intel.com>
> +Shannon Nelson <sln@onemain.com> <shannon.nelson@oracle.com>
>   Sharath Chandra Vurukala <quic_sharathv@quicinc.com> <sharathv@codeaurora.org>
>   Shiraz Hashim <shiraz.linux.kernel@gmail.com> <shiraz.hashim@st.com>
>   Shuah Khan <shuah@kernel.org> <shuahkhan@gmail.com>

In case there was any question, yes, this was me from home.

sln

