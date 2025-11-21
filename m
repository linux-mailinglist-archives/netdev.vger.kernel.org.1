Return-Path: <netdev+bounces-240721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 786FCC788EF
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD5F5361F26
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 10:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D93433CEBC;
	Fri, 21 Nov 2025 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bu97VSWF"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012033.outbound.protection.outlook.com [40.107.200.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E9B2E7F11;
	Fri, 21 Nov 2025 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763721658; cv=fail; b=H+PjXk5S92V+trEUw1M9T7CcuuubvejrVnMY4d8Y8xOBahSp6SzE5+h6O5NYLlkfgUOoTAvZH8r0Z2lv2ophV4o/+eANy5qoOQdkehwWLkmaFdbZI0jRrYEpX6cxeNI0/9UHIe9N8HhZ+sk1hAqywE8AskEPbJIZ0Rrt9Oyg+Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763721658; c=relaxed/simple;
	bh=S/5CG/2lLPYq2mi37loGmNWoh+nhDxq0qcsJ6QC5roI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GkR7Kfpf2V1pla1bOvXoKHAYZOVsHannKBNqGBKjyTzq2vN0aM6VF68aQRcwlH13ZuCDGx52SzeHtw6hVdGFEVY9ZCEbxKI0H5f8WRsFGqTZOXuEngl12/sLcP2ftvJsomCjbzEx1TKO4ntH3yGcBX4BPnRdh6zxuw3qRbKKt7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bu97VSWF; arc=fail smtp.client-ip=40.107.200.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDfs79S5Ya8VglJgh/lLbxTqo6e8MYwLzde8cnUc8rQfKU+g0ZVprXUULdsN8VMVKpDM+n+O9mj30SyQPYjC1dGtSCWVoB2MEY4dDoWUbwDZw813msJN2djtsOnWgP106gRNWGU2Dk5Om/5HhkOF7xa2VivYkJsHHviCr/NBfgBS9XG3rAFSGeBpUaDiHE9ReWQPnzHHGMi28Mr6KqK47c+1hfgcKPJSE4ruMSr3sfP3hUmxN9V1YxA3H8va2lfKXAacqNqqFLO2xg2beRKCjsetXMqdzJToH/uPyRdIvU48x6wmpEcmVwMXcCJoj2CpCul2Kal069f2cjekA6yPPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ev7Fr/o2aBMdJ4NtnBjYmxj3u/UBRASb2gIB6Tght+U=;
 b=CtISkjw51oOQws5IbV3V9ldANVnLCDcUjJiW/FaV42e36XMXCKS0aWU75yG+PA6rz0HsqUIbGxLX68iYFQ64tlnhHOpeTw/fo/zU/NbdV+UpSZ7roIxUfjSd7gEF1ukUqf6OqsPbz16OO54SoNPP9g5u1pL2R8/o8D7+cTb27MPy92k2dQP5HBwMlFagu4sFlYSlfw0LIY7DQIEV5UwX9lHkvJqySpHPg6EmQs7n5qNaaDalXfsQLlL+Lisvzp3Tgsv6OfktU4sCO7xC/d7EGaGsOjUGtQcgun18kovXqjEUtV9HDxLPxMbaWN5a5pva1WyBdIpT0KYM7PqZlZ3E6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ev7Fr/o2aBMdJ4NtnBjYmxj3u/UBRASb2gIB6Tght+U=;
 b=Bu97VSWFkt1eBnj3J8m/GBgkqk4iNa/d/5bFABHxvlU8lLjfRzVq/njuJClIjVTvNujTLwBuXxlYJsCKnJWaqgA2JgWPEZei22PgXtDX0lnmK+KWGXtKUpHzb3U3wVboD17O3Qbo+G6e58Lxow3DSbp9rKjtVx/3wByfUyKrNtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 10:40:54 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%6]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 10:40:54 +0000
Message-ID: <8d8cb631-1d72-436f-ac97-5449ba46ef42@amd.com>
Date: Fri, 21 Nov 2025 10:40:49 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 00/23] Type2 device basic support
Content-Language: en-US
To: PJ Waskiewicz <ppwaskie@kernel.org>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
 <e3d376c8a1ac1ee9b75d02f78bdc25f7c556bb20.camel@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <e3d376c8a1ac1ee9b75d02f78bdc25f7c556bb20.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::19) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb157ae-eabc-47ab-3f07-08de28ea724b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emxpd3FmTHFhNWJaaFJibGFoSUJWRGhJODV5amlBNWUvbzlkeCtLVFNRUlhM?=
 =?utf-8?B?NTBsOTlOMkpjbHdselJJbVBiRUlUc29QNGpZcG5veVU2VVRweERoVXQ5U1JR?=
 =?utf-8?B?WEFRMEVkVEMzVmgrdUVIK0lPQXZCU1dGbGl5WHZVYmM1eTFyc0NzZGhaQkVC?=
 =?utf-8?B?YndpUHFhT3pkTDdWVlVOYmZZWDg4UGYyekhkR3d0Tjl1aXl5dHdqV0Y2NnJj?=
 =?utf-8?B?WCtFU2VLUVZya2p3eHYvUUdtUlFrVE1sdFd1aEJtaGVTeUgvdVpsdlZqTmFr?=
 =?utf-8?B?Z3YvT2k2MkdldFpRUzVSZ0U0aUhKVGJDRmRwaUdHSU03STVhMGJob2M4clJh?=
 =?utf-8?B?TGQ4djB1WWlpMnlZcUg0MVBRdXI3Zkh4TExrcjNucUs3THQwOEtrR2QvUE1k?=
 =?utf-8?B?Ulp2bFpzTWxuTDBuRjNybU9zUHRxdUxqejg3dXI3aGtkVVMyT1BXMzZJZ1BN?=
 =?utf-8?B?NUZ1ZjYrNW44RjIyaCsxL05JVElDcTM2VEgwNUVzWjF4enYxZXRFVDFsai94?=
 =?utf-8?B?VkpyZllvQ0FXbTZYU2tTYlNhY2dJbVJTTEgrUDNvVjhSMzNVdDV4cXlVb2lE?=
 =?utf-8?B?V2NJVEk2a0Z5cmNFT2lWWXJudUp4azhjS2VXTmZDRTBtYzI2ZVgvbml5TCsv?=
 =?utf-8?B?cnZvc0Y5bVNGRTlBU041c201V1l0bklqNTlxZ2pCTjY3dU5CdVYxaFlzREVG?=
 =?utf-8?B?ZzVSbEd2YmEzeG01SHpIVzQwN1ZLVkxLT2c0bzE0V0xQb2FxT2trY1BDVDFI?=
 =?utf-8?B?N2xmbWRmRFBMVDgwLzJqaDlIYStocC9aRFNTTTB5QkVDTUk3RUs4Ykx6NHR2?=
 =?utf-8?B?Q08xNmpielpkMy9PTmczM3ZrTzRKSTJKNE5hUGpYMDlMUktsaTVBMExJaEJv?=
 =?utf-8?B?VkMwZjVZL0EzV3dkeUFJTm1zeElMRWd0ZkR3MnRYMnhGZUF6OGZadFR6Sms2?=
 =?utf-8?B?cFNvK1ZZK1FlRy83Z0NQUklXRUVxS3U2eG1RSnZxNERRWU5pME1YMkFacjNM?=
 =?utf-8?B?ZnhDNitSa2t4VldaeGFCb2dnVGk4SVpPdTNJOU1DbThXUTJ4U1c1WVdTdE4y?=
 =?utf-8?B?K05LUDkwbG1nc2NtanlXZUZMVWRSVnlCK3ArNXVwWis5SGlTemhJUFVGeUpR?=
 =?utf-8?B?a3NOT04yM3Nld0UyZ0FuTS9rRWdLcGM0d2FaR0lyYjRKVXdEbVZ4VmticXRp?=
 =?utf-8?B?L1NxOFdHZmpGbUY5WE0veENSSW1MVmIxS0t1Tm1YZXB0aVQrUytjYkdCTFpF?=
 =?utf-8?B?ekpJUCtLdFUwTURIdjhDbTR4VEhHbG8wZGt6blh5MFJya3pTdjN0UnhsUmpo?=
 =?utf-8?B?VmhIQ29LOUxvd0xnMEQ0TC9VNE1tOHZRajhZY3dGU2xWQ2xmZE5UZTc4bTBB?=
 =?utf-8?B?QWhOUStheWxUSklGbytIR2F4aXVsQU8xc1doOWpLbUw5WHFWcU1MZ1FBRVJW?=
 =?utf-8?B?SXV0ZzJNUUY2eWpaanBYcWl4eEFLYlJTeFdwd3RaOVhHdFNlNUlPc2ZRZ3Jv?=
 =?utf-8?B?Smd1NGJ0RlMwemJjcE5lTmZLNzNENDNZektYY002SXVmRVEwQVJ2eTNlSDhH?=
 =?utf-8?B?Q2Raam85b1l5ZUlPeWY3TG94SnIzeE9iSll1eHNxWFl2VTBLclZ3L0tCbXdX?=
 =?utf-8?B?M1lDbVAxMEwrM0ZRak51RXEzeENpdTRmZ3FsNGE1RFM5RmQ4ZjB1RzdIUGtm?=
 =?utf-8?B?QWlkeU9pV1Y5UUNiQVhjRHpQemYveXh2NXk4ZS91TzZaSFJaQUc4YVJhQlNU?=
 =?utf-8?B?ZFpQR2V1NGpzQ1RxQWlpWENySTZ1VUwxSVBZazEwZWVyVDZzTXJoYnduZ1M5?=
 =?utf-8?B?ZTZVMU1GOUtCc2RyZXFpMlhzVnRFdTQrWEt3Q1NnUDVkNDVQWEpCZkl1QVBE?=
 =?utf-8?B?TmlHeEpBRTBvMmwra1RUcVF1bm1kaGxyK0tnYjA0SW5iVmNyaUFwMlhqcTZu?=
 =?utf-8?B?TWo2aVE4RE8ya2ZBWjUrMzcrQW1lemtocDdNVXgvTXN2bUl3a0t4SjF3akNZ?=
 =?utf-8?Q?szCS+NDnyTfSUS4HJPX/IhBUt9+LaQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVRyWVFkSjVjT3VoM3B2WWNZQklwakM5R0pCeTVYQmNaWEhxbTZ4cUhNVk9C?=
 =?utf-8?B?bE53VG5rZ1padmJYM09UTmhVTm9Ra3lHamxNNldYVnlpTHoxWFJJcGtZa0lQ?=
 =?utf-8?B?SldwNDZCY2RVTEJwTVBncGxncEdHYzJNaUZxWXZEZEVhdndndmNSczJscXQ2?=
 =?utf-8?B?VE1TUnZkY2lkaVhWQTRDY05OMHArUjRReFUvRFVrd1JDZHVtSGtwcm8xWGFS?=
 =?utf-8?B?UStOalR3ZFVKMWVuSTJETVNRSExSQXpqMVFNYlFEZS9GWkJjWjRhMmsrYlE2?=
 =?utf-8?B?RytRbWE4U3gzR0QvK2pjYmhKTmVOS3BTQkZJMEdPSXFaZG40WlZMUzIyZi9S?=
 =?utf-8?B?b1h1cFFFY01QTXVaaDdxSXBNb3JmTUhYOHU2elFlaW5DZzdhbmMvbUo2UXI5?=
 =?utf-8?B?Z0p4MEVjMWJLNmRsVlp5UWEwVzNnU01vNmtkYzNpTGIzazFkSzN1RzFMd1p1?=
 =?utf-8?B?YTZubjhCd0Z3UDJHbWJrMFJZdjhINmdjMEc2dUxzamRDRGhnd0Rxd05heDV5?=
 =?utf-8?B?aUJWZGZKSHNmNW9hVW1TYUZlVGo4ZFE0Vzd5ZHNNSTd0ZmR1QXV3eTh0VVhW?=
 =?utf-8?B?Zmptcjc0NkVySlRtYWdaMk1ObnR5aEZRSStHQ1gwYTZnWGtRaDl6cy9SakNY?=
 =?utf-8?B?azY4SG83bUdsdFptY1JOUmloWEN5QWVIYU56TFBReVBjWDVCUnFTWmIvaFd0?=
 =?utf-8?B?elEwZnV4aFE2RjVuQjJEeEVDaVVCM1A2MDFTZEVQY0dtVkN5TXZud1I3dkdC?=
 =?utf-8?B?TGV3ckRNUzhDTnR1LzFZNDh0MUFiRnk4bVUyZnFTV0s4bDNjNjUvSGhmZDZ1?=
 =?utf-8?B?aEJWeUUvWi9USXd1T3pJMzVpUFVpYzFsQ25jM3JmSm85ZGRZLzNPQ01SWmVW?=
 =?utf-8?B?OGg3dk44UTBWbkltRDE4NElPdlR1WmVCc1JOSFJXdWg1ckg0djZHZEtxNm92?=
 =?utf-8?B?cElSQ05WMU5GNUZMVk04UnNCRC9HamlwVThMWHJyeHd6UXd0T0swaUdDeVNm?=
 =?utf-8?B?TlNTcjhUa29MRE5BZ0QzL2VBQVF0bDlHZDhNSkdFYjJXWFZydVVaVE9KaE1y?=
 =?utf-8?B?N3BsejdteG9ZbU9pQWtUSUN2dnhNNjIwMC84RkwvY0NxYmJEK1JqU1ZTMTc4?=
 =?utf-8?B?L2FtWWtpazZob1NOZW1WemJpdmxXUDdKeXJpYng1ZW4xem1WN3FiNHRDb291?=
 =?utf-8?B?Njk1SnhpMnFjUFUrRGR3WjdYb2lzSERySUF2VUhIWkxUbUU4a3p4VlJZSFph?=
 =?utf-8?B?L2RVR1d5MGdKRU54VGEzdE9VZURrUURqT2RzZUlwS0pFMncrWmxkQTVxbVFV?=
 =?utf-8?B?N1ZLWnNvZENPM2pBK1ZsTjVNcUd2VER5aHNTWE1WeDlrS2F4L28zeit1TXdz?=
 =?utf-8?B?ZnZsRnptVVdER2h2a1hqQmtING52UDJZZmJ5a2dXV2l0SVpTWTAvUm5RUWxV?=
 =?utf-8?B?RFdiVjVLaUNNSHF3MzJ0QkVzYXppbGtySzlrd2ZGK2VpUnFlVGhoekc1RTZh?=
 =?utf-8?B?czc5VW8xNFRrUWZOK3p2RUlEdXByd2Rqbkw3VXF0TUxSR3E2emhQWG9NR0Nr?=
 =?utf-8?B?UTRtM0hpMjFsZWlPWXRpL0tmNDVOUFRyRW4zeHlka2g3SUViU1M5ank3SDdz?=
 =?utf-8?B?eVJuOVAvY2w2Wnlhd2dyMk03aE4vV0ZGZ3dMSk5EZzBxSFZUR3FSODFUWGpL?=
 =?utf-8?B?MDQwblZPeHEvd0R2SWlxSndwYTJqTVpDOXB5MmRJSytYWVlKdWcxMDFNVzF4?=
 =?utf-8?B?QS9HYTFrbkhNeXBXYlZQSzRkekdpUmxPK283Uk5RQkVQT3IrUkE1aitGUXJo?=
 =?utf-8?B?NGxzWDB3M3ZIWGtKbm1zTG9La1RGMDRYSmFZM2JTOEZQVjZPdnEwcWYzWFFO?=
 =?utf-8?B?ZFgvRXpycG1aSDdyaDdqbEU0ZnFFMmQxb21qY2UrNjM2L3lBclZFRm1oeVJG?=
 =?utf-8?B?OVcxbHh6cGs1MVBibVhkZWdWbnh5eVFLeklaa2hEaHkyeFkwS3hCQjFtZm5j?=
 =?utf-8?B?Rzg2cXE3T1Y0L1Z3K2g2dnJjMUNyVC8wM284QkdqdFZ2eVJHRUNmR2dRbmdz?=
 =?utf-8?B?bjU5ckM4RS9GaG9kR1dNTlAzUVVnNzNEZzlUOEF2OE9ZOTN1Nnhya2IwYTdW?=
 =?utf-8?Q?sdNfl64k1gDx2DykQsWnhT7+2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb157ae-eabc-47ab-3f07-08de28ea724b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 10:40:53.9636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34YWxzywqKZ22DKWYj8yW7XYeK8zBW22rGE5WvL0Ag67CGT91jPfqYCivimFN+EprLFUPtcZIbV1xTVBs9D4Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495


On 11/21/25 06:41, PJ Waskiewicz wrote:
> On Wed, 2025-11-19 at 19:22 +0000, alejandro.lucero-palau@amd.com
> wrote:
>
> Hi Alejandro,
>
> Sorry it's been a bit since I've been able to comment.  I've been
> trying to test these patchsets with varying degrees of success.  Still
> haven't gotten things up and running fully.  One comment below.


Hi,


No worries!


>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> The patchset should be applied on the described base commit then
>> applying
>> Terry's v13 about CXL error handling. The first 4 patches come from
>> Dan's
>> for-6.18/cxl-probe-order branch with minor modifications.
>>
>> v21 changes;
>>
>>    patch1-2: v20 patch1 splitted up doing the code move in the second
>> 	    patch in v21. (Jonathan)
>>   
>>    patch1-4: adding my Signed-off tag along with Dan's
>>
>>    patch5: fix duplication of CXL_NR_PARTITION definition
>>
>>    patch7: dropped the cxl test fixes removing unused function. It was
>> 	  sent independently ahead of this version.
>>
>>    patch12: optimization for max free space calculation (Jonathan)
>>
>>    patch19: optimization for returning on error (Jonathan)
> I cannot test these v21 patches or the v20 patches for the same reason.
> I suspect v19 is also affected, but I was stuck on v17 for awhile (b4
> was really not likely the prereq patches you required to get the tree
> into a usable state to apply your patchset).
>
> When I build and go to install the kernel mods, depmod fails:
>
> DEPMOD  /lib/modules/6.18.0-rc6+
> depmod: ERROR: Cycle detected: cxl_core -> cxl_mem -> cxl_port ->
> cxl_core
> depmod: ERROR: Cycle detected: cxl_core -> cxl_mem -> cxl_core
> depmod: ERROR: Found 3 modules in dependency cycles!
>
> I repro'd this on a few different systems, and just finally repro'd
> this on a box outside of my work network.
>
> This is unusable unfortunately, so I can't test this if I wanted to.


I have been able to reproduce this, and I think after the changes 
introduced in patches 2 & 3, we also need this:



diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 6b871cbbce13..94a3102ce86b 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -1,6 +1,6 @@
  # SPDX-License-Identifier: GPL-2.0-only
  menuconfig CXL_BUS
-       tristate "CXL (Compute Express Link) Devices Support"
+       bool "CXL (Compute Express Link) Devices Support"
         depends on PCI
         select FW_LOADER
         select FW_UPLOAD


This changes implies neither CXL_BUS optionally being a module nor cxl_mem.


This should be enough for at least you able to test the patchset.


If this is agreed, I will send a v22 with it.


Thank you!


> My .config for CXL:
>
>
> CONFIG_PCIEAER_CXL=y
> CONFIG_CXL_BUS=m
> CONFIG_CXL_PCI=y
> # CONFIG_CXL_MEM_RAW_COMMANDS is not set
> CONFIG_CXL_ACPI=m
> CONFIG_CXL_PMEM=m
> CONFIG_CXL_MEM=m
> CONFIG_CXL_FEATURES=y
> # CONFIG_CXL_EDAC_MEM_FEATURES is not set
> CONFIG_CXL_PORT=m
> CONFIG_CXL_SUSPEND=y
> CONFIG_CXL_REGION=y
> # CONFIG_CXL_REGION_INVALIDATION_TEST is not set
> CONFIG_CXL_RAS=y
> CONFIG_CXL_RCH_RAS=y
> CONFIG_CXL_PMU=m
> CONFIG_DEV_DAX_CXL=m
>
> Pretty simple to repro.
>
> $ make -j<N> && make modules && make modules_install
>
> Hopefully there's a solution here that doesn't involve building the
> whole mess into the kernel directly.
>
> Cheers,
> -PJ

