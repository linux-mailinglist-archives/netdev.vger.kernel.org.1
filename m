Return-Path: <netdev+bounces-158564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B86D7A12805
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62D3161CD7
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 16:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9365C14658F;
	Wed, 15 Jan 2025 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rwaCa7o5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F345136E37;
	Wed, 15 Jan 2025 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956925; cv=fail; b=m4R2MMe2sYQhkf3FXH+I5sflIHmjIytRUF/xg/MZ1eoE5dwucwMcBW/Onwhu9jed5/ZKw3K6znmLpDJLPY4CvNxt4rbHAEfRDfsXDIUCP6rKN7SeG/v/oDPx/JGNB/q2bDAFaeFS8rQwtzhmfTjtg20KvLJPRizjqp9D3DB4rQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956925; c=relaxed/simple;
	bh=xMLExBJh1cJ7RTC/sIAJF0gWNq6j17VffNG7AOXYIrQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xa0xv5FIuvsxQOgmEsvJcJ//keXxpVlNZtQhRQuLWeEHxN82GdUbUugWVhc8w5tQRBmNkrsSa4Q+Ds1hamlV+dghgqwDO8r8AawujbD8uAVnRsrkzMWaLlWnm4L5pxuU41LsYbTldTnm9iv13brWTnTetGjPuIyITdNR9v0CNRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rwaCa7o5; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOAy4lWA4mO7g392D4WXuZqi0mofl1Qq0m/uc7l1JLtjChdbJKgicRjy5gW6DjdnmwbZZUU1TW7FXpVq0NHmommGoS0Np3UKiillGwUvAGPBbkPLlMkSgJylCR+vslZoWiv3zOhp8UAUhKGgFcjvJJca7U57J6ec+IGlHuX5fbZeSkZ0AKCIARd2nEta4wDIasYrgUjNWQWbJt+cxNz4tiXEWTZfioKBCNHytzzC3Nrpza6V1+HryHOsVrq67JAZEIcQckSrlPn3JeE7mO/Xh9AL69Ak+Nj0azh/9xlYR2ZHGdCj8mTEZ4s1dV2LHLfU2BD1IgD3XVQtlGkX86Q/dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaT+kdC+x/d+/Bs4eFvkGQkcSvtS4fTphO7bZdC53Dc=;
 b=SbO17O/y//tcOHzOTSiG+f39iEBG8Dg0aw81oEaQxyL7FG4Pnz0Qix8aqxn3VDs7iuKt13Rs3iP6Z5XgEZh0evsJT9ox/0MYuSZ9kDnQzJJFprtcFUFXag51SyZhqvsMKo9KPP+6psQoP3EL9GrEyGIQ0gAwQoqzIRKg4U1HcHUsC5DozEyZhlJYQVXcJrLHHyOPaILEA4FTY6mP6AltiG5Idqb/3EWfckPmbs3QKzjMELv7Mx9Jd9mlCLtFN3bywqQiO6Me8v74bmR1Njy1x+6C8Kjc3MVBwlYM2iUeqFwwrUx38FIO8VqnZnheJmGmUoBuQD1IcS42nRTflwoS3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaT+kdC+x/d+/Bs4eFvkGQkcSvtS4fTphO7bZdC53Dc=;
 b=rwaCa7o5HeWlqA8xJpyghNLUurAEc3//3CnfsFgwxr0RDaFx/aa8jVdIXUFYRbo1AKIXIYqqk/iC1V4++doNxPufrj9278rOZRgznsKa7zsKxMRwPpBedPhEp9cNhzJ9BBufhjqrPJl5ezKnmY6f3ww6NqwWtzx1A9/bld97RJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 16:02:00 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 16:02:00 +0000
Message-ID: <7fc0b153-9eea-af2c-cd42-c66a2d4087bc@amd.com>
Date: Wed, 15 Jan 2025 16:01:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 01/27] cxl: add type2 device basic support
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-2-alejandro.lucero-palau@amd.com>
 <677dbbd46e630_2aff42944@dwillia2-xfh.jf.intel.com.notmuch>
 <677dd5ea832e6_f58f29444@dwillia2-xfh.jf.intel.com.notmuch>
 <c3812ef0-dd17-a6f5-432a-93d98aff70b7@amd.com>
 <92e3b256-b660-5074-f3aa-c8ab158fcb8b@amd.com>
 <6786eab3a124c_20f3294f4@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6786eab3a124c_20f3294f4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: 5539c7f8-9c0f-4090-235d-08dd357df1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTM0SlB5SGMxREdRUG1US01vZmpNMGY4dUVMMjhGdHFKdTl4WmIzSG5CQWht?=
 =?utf-8?B?eVk0UWNTZHlib2plVTVoTURKZTV0U3RNSGZmREFuREJxcUpKMUt6QVUwdjI5?=
 =?utf-8?B?Q1h1SDJHeEF6UnA4REhpaCsyR0dlTTRmZldaUHk0dWFTT1NkWkNKZk13ZFFO?=
 =?utf-8?B?eVFha1dvNytkNkhsamk5WWhkVGhnOFBpd2U0elU4czVNa1N4UGVYVUs1RC94?=
 =?utf-8?B?N1lTSFRNWWVSUVhram5JSWFsZ25KeE1waVV6b29KVUdPN3pvUmo3UmwzM1Ix?=
 =?utf-8?B?TmRncERvTkd0L1ZFeU8xcng2c0o2R0lUWk40aW9GVWduejl1ZUdVaHdBcU1E?=
 =?utf-8?B?OXo2YjVxeitVTFFKdi9WRjZNcjJHWDRtUFkrTUY4MVpjT0JwdWh5TURoV2R0?=
 =?utf-8?B?WnNXRCtVUFFONHZPRGdSR1ZpS0lGRlRSYkhyMW54bnRueXR5UUREU3FpdkFK?=
 =?utf-8?B?aUpGZGNCTUxLUkJINU00ZmlWMXUxZDJ5aFJrclFhWS9kQy8vNTBXL2NhL3g4?=
 =?utf-8?B?UTRZUjBYSE01MndXSnZESnRSV244QUI2SWljQkNaMGE0ZmRyZzk5dHdvTlhD?=
 =?utf-8?B?Z3o4Z1VGZ05scC9xbHU5L3NVaHV0RENPMXIzOStmVERxVThJYklOUks1UWx6?=
 =?utf-8?B?My9OK1VFOGtQMmg4N3I2Y2ZRT2t0OTA4K25XeXc5V3VzWlNaMyt5U1pXNExu?=
 =?utf-8?B?ZURqSkJHOUltdm1BeU1VV2tqZGw1YnowMWNlcU8yc2NnL3BRNEUyMXM3dkZI?=
 =?utf-8?B?NGVuQmhWSGhlUHJ2ZTdKQU84eUoyTDdVNG0zczB1WGxxN0JOSzREUGpXck1x?=
 =?utf-8?B?UDFES3I2S0xYUTlKN2VROERsclNjSDZ1bmxXbjNNdVZkQXRKeVUvRlIxTnR0?=
 =?utf-8?B?U25tQmJBTnNtOUZZckpMeGV3eTBPSkkzZXNqNHNDbGEwc0E0NWtLSHBZTGI0?=
 =?utf-8?B?Z0dNOFB4S090aTBaTklJS3BsZzArUWZ0RGNHNzFoYkxJRGxjNXZBNTdGaXRY?=
 =?utf-8?B?Smd6YTNBVVA2RFFqRHhGczNsNXQxSlBkeW9uMkpWMUJab0x0enJBcU4yQ05J?=
 =?utf-8?B?YzQrVi9MUHJ6bVkrMWdGSDY1dGw2VXgrSm1WeFVaay8yck1wejVnK25nMHAv?=
 =?utf-8?B?NGR4QzdCcmhGV0dnSWJBSllvaDIrbjEzNVEyWHFocnZwYzV6Tkw1WXhTVzBP?=
 =?utf-8?B?ZldndEloeE5XeG5pdUw5WU9FN3BHVE8wRW91bmtLTC8rVTdqSzRBem5PNUZq?=
 =?utf-8?B?bVJ3ays1bDRXVjZFM2l3UVNWN2VjNktzbkd6MlA2VE1yL2VBYUFWUFZvRGNW?=
 =?utf-8?B?dEFFWWxkTW5HLzhsVDVyRzhCSlV4dlRuTGFhZzRoYmFiVzJhcU5ld2lhNElo?=
 =?utf-8?B?alczTTRnSll5SkRMbk82aE5VRlBrcVpaNG9YMWVybnJPVnZUbjZkN1JIQmYz?=
 =?utf-8?B?NkhqeDBsWnpTZDh1UWZ1SmJaSndUQjJ6eU1VSXpYRUpxR1VJeUxrQnVnNjVj?=
 =?utf-8?B?ZERxMENQZVNqNXhiUFAxalIwSmp6Q3Z1aEo0YTV6VDN5bEZsUmFxTGpwakdE?=
 =?utf-8?B?TEZrTUNzR1ZCd05JL2VSNjcraW52ZzNXOVJtcmFnMWVCUTF1Rk1ydWZENEdj?=
 =?utf-8?B?YnYwWWo3Vm84ZXhNWU1CbWlRS2xYcFdqcEZVd2tQRFRvK1dzNEFYWHhUWGV0?=
 =?utf-8?B?aXFSdVpVOWJkbFF0c29QblVaVjRlV2JCT09ueks4Q0ZhLzE4aXVjWHBCd1ZO?=
 =?utf-8?B?UjMzK0t5czY4SW9Iei9qYk00YlFuYVJuaXVTM0lEVGowbkhrWVFLb0dDbzdv?=
 =?utf-8?B?K2V5Rzg2enliOVZPSjMrM1N2TVVHQnR0dkF5S3ZDc2ZLSUZhVlkwS0pMNFdn?=
 =?utf-8?B?ZEROWTlTejVQbjI5ck13NlljSDBRcElYMXJsMHNJK0pSWkpPejd5NlhYYy90?=
 =?utf-8?Q?paR0hvEW8JhX42PrpOxj3a7UDWnIYEd/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0kvVklkaENJSXM1amZSVGVkemxLSHdvRlZaR3VpRG95U1EweVBRVG9vYXJj?=
 =?utf-8?B?VEczNmNDWEc1V2h3S0FpMFlEVUJWektBNmJEaE5sdHVBd1JWQkh1cGpORmdN?=
 =?utf-8?B?SFN0MTI2a3RmN01rTkdZRWFQSTRxUzI3Ui9xVDczNTJTaEdOdGsvVU5RcFhB?=
 =?utf-8?B?NjFBby9pNnBvMHkyYUxtbG1ienczQmdaa0RxMVMwVDEzRFhEUlh2OHUxR3lY?=
 =?utf-8?B?QjVPaHpHK3pqYmxIRkI1MXZwZjV4V1lDSHFoRm5lQ0ZVNUpWZmVPckk3K1di?=
 =?utf-8?B?RC9MVTY5SFhtdWphVDRGVG1PTzJDaHFaV3dvM0h6RXhXQllxLyszczJ0Z2sy?=
 =?utf-8?B?cVcwcjRsU2N5dUZZU25lRHYxL0ovQ29Od25aei93ZTJzdEl5YVRZNE9jTnly?=
 =?utf-8?B?Uk5qKzBrdTlIYTN0OFJrMnA0dXVOblhmVmcrN0dWcWZWcUk5QWNkR0tsSFcr?=
 =?utf-8?B?ZVN1aGUvbXU3N212K3lOMVZjV0xjY01yZkdma1JyQ3pWNlRPOU5YZjAwMlc0?=
 =?utf-8?B?emh6dXhlbGhqTERNQjRITFhCUlV0Umd6Qm0zSU5sSE8wSEt0NW9IbU5nL3RD?=
 =?utf-8?B?ZUx1bS9PRkdCdU1tTHN2RFg1a3B6S2xXOWNoQVNac0gxM2szV0ZsOU1QL2Ey?=
 =?utf-8?B?V3ZUcG1raTR1aTlHcUhxNTltTHh3Wi9uVlplc3B1OEMvNlFFWTRCbllyYTRK?=
 =?utf-8?B?YzA4cFRxM05CVkp0Uk5NS3ptUnFPQXM5VWw5Sm9meVhmU3B0dHUvWU5HU1Vw?=
 =?utf-8?B?RWdvQ3U0NXJzMHJSNGwvQzYxSHMyNU5Tck9oeHEzbkp4Mi9Hb1ZPbkFjdWZx?=
 =?utf-8?B?R21mTFhBZDZzVHQ1d2dKaWNBSFBqSjNtWWYzcnFuRk1ldWp0SVlOeStDWTJ1?=
 =?utf-8?B?ajRhYmhmVmtRRGxveFJnOTNSckVBUXRzejZzVmVMVlJKdU14eExndEhMNzk1?=
 =?utf-8?B?UVNrOFl5Rk1uNzYrUG1sN2U5eTBlaVBlNEVZYUMxcE9lZithUnJudVJ3QVpq?=
 =?utf-8?B?UzhBN256alJ5Y0gxakh5MGdKakg0b29EYVlhRnhpaDc3SktxQlpRMys4N2VM?=
 =?utf-8?B?VU1hRWVZYzRrU3pUTXlDZ1V1K25OSmltQVA1M2Q4dStQbnVabUM2ak9XYWwr?=
 =?utf-8?B?STQ0TlM5VVFuU3BQTUhNYUZzbzVUTFVpZnZFMUpLN0tOVE00L1JtaGVBRlBF?=
 =?utf-8?B?WTZCNmN0ZGhmKzVIRXRYODhuK2NQVW8rcmxWT01xR0V0S0NVamdMa0FrekN0?=
 =?utf-8?B?UWxHakNUTWduU0FOVXFFSkxjbXdBTmZkWE5XNnhmdVZtcm1TUVZaSG1zaFYv?=
 =?utf-8?B?dFpvMG1ub3E1R1NiYjUrSjd0b2lCYVJDWHhZWEVObW9sU255NzMrUFc5RGx0?=
 =?utf-8?B?MXFLZXpUdUVNeWhsbTNMRmJ5NWRML2tTc2VtbFNhM2ZwTGxrWUxIcHFhWDI3?=
 =?utf-8?B?YlBNU1JJbHhwUjBZcWc2SGJ3VGtLWFZWbE9JSWtOYnZPalpob0t3T3g1MGw4?=
 =?utf-8?B?OXJsQStwMXdDclFpMUMvd0YwbnhCQUhDNmJpcTNSbVdRRzdzbWg0L1A4TS82?=
 =?utf-8?B?THBzazZoc3ZjMUp6UUJoSlZnOERDanRwOUdGTVpQL0QrSGluMDNWNENPYkVR?=
 =?utf-8?B?WFVLMm0yVUYrRm82bE1uNk50Tmo5WjB3WTFxcXJTUkdaQktvVTM1cm02UTIz?=
 =?utf-8?B?dGRDNmVDS214MVlXRUt5NWRJa2h6K2tuQkVUSnJHM3UybHJ2dHQ4dHc4MUF3?=
 =?utf-8?B?WEx1N1B4RGNOclExeFAyT3lCQzNPV1RlYnBwN1ZmZWRXNTNmT2o1Z3F3S09o?=
 =?utf-8?B?WmZjNjdsUHhMQ1U3V3g4RCs0Q2hLRFBsemZSeFJ5TEpMbzBLVXpveWdHeS94?=
 =?utf-8?B?NnhMUmdEZmh4TnJqdTZkMWFUb1hUaStmSEk0cW92RDEvT0FjRzZDeXFqV3My?=
 =?utf-8?B?Kyt2SkRDREdnUG5FT1IzV1psVG5rWVVzM3ZQQ01vc25GdTRubllSNzJ0ZU5X?=
 =?utf-8?B?Z2xaZk93c084MFlybi9XK21XdEl0Y2x5cmtYV0JJaU85aTV3b0RmYUVTWWFw?=
 =?utf-8?B?dUpkLytkcWFlZm50dzFNWGZudGFFWFZrNG5jWjVzSkZNNFVVRjBmTnl3NjdJ?=
 =?utf-8?Q?1x9s9wNUZ5uS/i33cnwVsiVhn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5539c7f8-9c0f-4090-235d-08dd357df1b7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 16:02:00.1928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEQEMk5RL/TYCxdcjIhurx8CwgGdJX1gturNjO2ZgyickaLf9lIBXdzEVMmamnmsCkH0H9pkMlw9DQ/L8dmgYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148


On 1/14/25 22:52, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
>> On 1/8/25 14:32, Alejandro Lucero Palau wrote:
>>> On 1/8/25 01:33, Dan Williams wrote:
>>>> Dan Williams wrote:
>>>>> alejandro.lucero-palau@ wrote:
>>>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>>>
>>>>>> Differentiate CXL memory expanders (type 3) from CXL device
>>>>>> accelerators
>>>>>> (type 2) with a new function for initializing cxl_dev_state.
>>>>>>
>>>>>> Create accessors to cxl_dev_state to be used by accel drivers.
>>>>>>
>>>>>> Based on previous work by Dan Williams [1]
>>>>>>
>>>>>> Link: [1]
>>>>>> https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
>>>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>>>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>>>>> This patch causes
>>>> Whoops, forgot to complete this thought. Someting in this series causes:
>>>>
>>>> depmod: ERROR: Cycle detected: ecdh_generic
>>>> depmod: ERROR: Cycle detected: tpm
>>>> depmod: ERROR: Cycle detected: cxl_mock -> cxl_core -> cxl_mock
>>>> depmod: ERROR: Cycle detected: encrypted_keys
>>>> depmod: ERROR: Found 2 modules in dependency cycles!
>>>>
>>>> I think the non CXL ones are false likely triggered by the CXL causing
>>>> depmod to exit early.
>>>>
>>>> Given cxl-test is unfamiliar territory to many submitters I always offer
>>>> to fix up the breakage. I came up with the below incremental patch to
>>>> fold in that also addresses my other feedback.
>>>>
>>>> Now the depmod error is something Alison saw too, and while I can also
>>>> see it on patch1 if I do:
>>>>
>>>> - apply whole series
>>>> - build => see the error
>>>> - rollback patch1
>>>> - build => see the error
>>>>
>>>> ...a subsequent build the error goes away, so I think that transient
>>>> behavior is a quirk of how cxl-test is built, but some later patch in
>>>> that series makes the failure permanent.
>>>>
>>>> In any event I figured that out after creating the below fixup and
>>>> realizing that it does not fix the cxl-test build issue:
>>>
>>> Ok. but it is a good way of showing what you had in your mind about
>>> the suggested changes.
>>>
>>> I'll use it for v10.
>>>
>>> Thanks
>>>
>> Hi Dan,
>>
>>
>> There's a problem with this approach and it is the need of the driver
>> having access to internal cxl structs like cxl_dev_state.
> Apologies for stepping away for a few days, there was a chance to get
> the long pending DAX page reference count series into v6.14 that I
> needed to devote some review cycles.


No worries.


>> Your patch does not cover it but for an accel driver that struct needs
>> to be allocated before using the new cxl_dev_state_init.
> Why does the cxl core need to wrap malloc on behalf of the driver?
>
>> I think we reached an agreement in initial discussions about avoiding
>> this need through an API for accel drivers indirectly doing whatever is
>> needed regarding internal CXL structs. Initially it was stated this
>> being necessary for avoiding drivers doing wrong things but Jonathan
>> pointed out the main concern being changing those internal structs in
>> the future could benefit from this approach. Whatever the reason, that
>> was the assumption.
> I think there is a benefit from a driver being able to do someting like:
>
> struct my_cxl_accelerator_context {
>      ...
>      struct cxl_dev_state cxlds;
>      ...
> };
>
> Even if the rule is that direct consumption of 'struct cxl_dev_state'
> outside of the cxl core is unwanted.
>
> C does not make this easy, so it is either make the definition of
> 'struct cxl_dev_state' public to CXL accelerator drivers so that they
> know the size, or add an allocation API that takes in the extra size
> that accelerator needs to allocate the core CXL context.
>
> Unless and until we run into a real life problem of accelerator drivers
> misusing 'struct cxl_dev_state' I think I prefer the explicit approach
> of make the data structure embeddable and only require the core to do
> the initialization.


Ok then. I'll make cxl_dev_state public in v10 and do the allocation by 
the driver.


>> I could add a function for accel drivers doing the allocation as with
>> current v9 code, and then using your changes for having common code.
> Let me go look at what you have there, but the design principle of the
> CXL core is a library and enabling (but not requiring) users to have a container_of()
> relationship between the core context and their local context feels the
> most maintainable at this point.
>
>> Also, I completely agree with merging the serial and dvsec
>> initializations through arguments to cxl_dev_state_init, but we need the
>> cxl_set_resource function for accel drivers. The current code for adding
>> resources with memdev is relying on mbox commands, and although we could
>> change that code for supporting accel drivers without an mbox, I would
>> say the function/code added is simple enough for not requiring that
>> effort. Note my goal is for an accel device without an mbox, but we will
>> see devices with one in the future, so I bet for leaving any change
>> there to that moment.
> ...but the way it was adding those resources was just wrong. This also
> collides with some of the changes proposed for DCD partition management.
> I needs a rethink in terms of a data structure and API to describe the
> DPA address map of a CXL.mem capable device to the core and the core
> should not be hard-coding a memory-expander-class device definition to
> that layout.


I think you say is wrong because you did not look at patch 8 where the 
resources are requested based on the parent resource (dpa).


After seeing Ira's DCD patchset regarding the resources allocation 
changes, and your comment there, I think I know that you have in mind. 
But for Type2 the way resources information is obtained changes, at 
least for the case of one without mailbox. In our case we are hardcoding 
the resource definitions, although in the future (and likely other 
drivers) we will use an internal/firmware path for obtaining the 
information. So we have two cases:


1) accel driver with mailbox: an additional API function should allow 
such accel driver to obtain the info or trigger the resource allocation 
based on that command.

2) accel driver without mailbox: a function for allocating the resources 
based on hardcoded or driver-dependent dynamically-obtained data.


The current patchset is supporting the second one, and with the linked 
use case, the first one should be delayed until some accel driver 
requires it.


I can adapt the current API for using the resource array exposed by 
DCD's patches, and use  add_dpa_res function instead of current patchset 
code.


> I am imagining something similar to the way that resource range
> resources are transmitted to platform device registration.


I guess you mean to have  static/dynamic resource array with __init flag 
for freeing the data after initialization, a CXL core function for 
processing the array and calling add_dpa_res and aware of DCD patch 
needs, and the resources linked to the device and released automatically 
when unloading the driver.


