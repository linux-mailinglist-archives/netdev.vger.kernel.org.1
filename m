Return-Path: <netdev+bounces-225697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F321B9713B
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 19:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593F92E72CC
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 17:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127D8285045;
	Tue, 23 Sep 2025 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kSFx2ka9"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6962848BE
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649495; cv=fail; b=Qza+rtK56BLww/WHGRo/MeHC8xNnNhfZF5Qm1OS4ikTt7dwJ0XrQJMY0TSL532obyVZ/a7jFlX79Lskgm2JwHzLSItB3RsrcMG8nIdnDtpRwr8Eb9HI1uryDN/LloYtWCqqjGYGlkLTttzQfTJc8MPrqZPXTKHjREUztiH7mb7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649495; c=relaxed/simple;
	bh=FIyBJzBEp0PMHXnSHmvpqQlSx4Voc/XZvYMkGSiWwPw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EtDyweA5dsvhdUSugyD3cZTWr2aAfyLFis4pt9KPewV34AQLHBvZKGCaDstHnR+4UjRbVUQtFN5zqAGb92fL+6G7BMjIuGRdm6/mE1nJiH+nzRR85xSD+vmvQ1LalOMm4A4JceFH8LMT+O5rKX9yYTEN1JfAQoxjkKLytxoE53I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kSFx2ka9; arc=fail smtp.client-ip=52.101.62.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bf3FMOJkXCSAwfuQYc58WxfsKqCSHhqqgQx0wumAhzwRdeQsq8lah7XM4fDNa60m2/5roJdRwijcUBrmTAxKu/sglGX//sL5I2OwqqBnc7NGpGsjWUXEtr5RIu0xGONDIL3oxXZu5QEzekSwswSdD9sNKN3PBkMsWPnSHB5karFxJBghA61aqjirtbcR6qgSHA5AICwCDplCRHcuBVkU+fYk9g17z6Zn79SDhpmSlFsbkK/PuzRgkQQH0nTm9KaX0YfZcQI66CI0Q0BQZTaShsMxhOQ878v3EI3+BXP6ATG584duDWfL0sxhjJAA09tt9vuPr1Q/3h/CNfHmQzZfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brev+IAypASxGEaJdE19GPZ+j4R4Gv+0xvwDf/roVc8=;
 b=vj1hmftjyXdu5vifV5TTMMcpWgcnu5Zfk99Zntwm1VXWSjifB9UAlDqZEXI46EDlCTzBaQmkduWADmHnWj1wEkb3x9Ffog7mR5Zp3Ru6RShxmcfgm7o52U+gLGSIkVi+LZ9Qr6122QxbzhK1EZWX9VQT1nJPOBU7JpiaSZNIWmko/LIGLYuU4OMAkZDqlxE3fHKbMJiDE1iJYkWFXzktYA9Fh7FCd9U9o0Yj77067wX0K5/v4FMTK1uFbZ8sD3PIQytfmehfSe6rf4Ky1zFrf1xg3kppM1pucN4KIRWZ6g4xD4MSoHIDMuCS5NGB/MIlwnqAnBYTBXpXFLmnqE52/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brev+IAypASxGEaJdE19GPZ+j4R4Gv+0xvwDf/roVc8=;
 b=kSFx2ka9McZFTIVtKP5vZSPc/nX4+4GmlPID/tuTMkAJ7FYmEYsCY6gdRBbGx9XJQP0GXLQr/eZCLKniQNamQIOrq3b2JhZ1c1J+WRuTsFsyms2lrN5unJDzLQeF9IkCvUGoQ6OaZxrtbm/FKlVdYF6FZAKs+YmTfDT2srrxxN/0PdSiSd/LaG1OTe3tugHZknuP6+KJx0ZKx/LpSdp54BJJk1TOwkLoVVEOtSO4nJ7pYk2YCef1Q04H7hAS1XH0d+QJvywBG9UbAMI2qIoDGcHjOhPKWScG7r/bnYE97D37O5l8/q6ZI90OCpVbWZtzhRMzh00+SORj3iWJ43mm3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by DS0PR12MB8218.namprd12.prod.outlook.com (2603:10b6:8:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 17:44:47 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%3]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 17:44:46 +0000
Message-ID: <5b42dbf4-cc20-4cf7-bad5-fbe3e9055c0c@nvidia.com>
Date: Tue, 23 Sep 2025 20:44:40 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] mlx5: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Michael Chan
 <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>
References: <20250922165118.10057-1-vadim.fedorenko@linux.dev>
 <20250922165118.10057-4-vadim.fedorenko@linux.dev>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20250922165118.10057-4-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a016dab-195c-41d4-ff10-08ddfac8e264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2h4Z2xzaWMxc1cyUzltRVR0MmpkamxJbnhOc2F0bndOb25oVVpWNk43R2lR?=
 =?utf-8?B?VDdWN1RHblhackN1YjkrSkpEOEVpMVdOanMreHBjelNpeGdlZjRsekZFY3p1?=
 =?utf-8?B?WWFFK21vL0p5L3QxUGREenFlUGgrY3ZRNG1uU1NBU3JhVnVYcUtXWlZGdEFk?=
 =?utf-8?B?RU83TVNkcVZ0dDZnMnd4a0E3Mkl5SnBMUm54dDFES1BiUnJxRHB5VEVxcUo1?=
 =?utf-8?B?dEo1TFhuTDgvYWh5OWcyc0lROUJQT3NDdlFXTGFhRVNIRDJaMzNsL0kzb2kx?=
 =?utf-8?B?R0NKbEYxbmF1Rlhpa21La0pXL3RTTW95a2p0Tm5oNCtEekh5ay9GdVlTdGFF?=
 =?utf-8?B?QVVHdUl2dGNObG5NdzFadEQvbEk3LzJnRU9jZk9DSk9ZOEpiTXZMSFErQ0s4?=
 =?utf-8?B?Ry8zYWNSK3hVZEFrZzJTTm82ZVJsQVpxNk5iNTh0VjdmRkl3TnRoTU96WXdN?=
 =?utf-8?B?UXRXMldrdWZmZWtHTUdDdTFJNHpsSThISmkwT3Nmc2NwNmpDU0ZMc2FuL01I?=
 =?utf-8?B?T3Uxb1JacmI2UmozQmU2cHNqTUpFYnFScS91SEJsSUZ3alRRenI5SHMveFhJ?=
 =?utf-8?B?TC9CMERXYlRKMWdjU0lLdEdrci8vaUExZTFjUnIwdkN1OUxSZjBRQXFFRXhK?=
 =?utf-8?B?RG5ieEgrQkFwNmVmNU55L0RFQzhzU0NFcHpmWWlJUjdjY1VlVWtqZEhFSkY2?=
 =?utf-8?B?WCtQWmtaS0NmNXFSemxDZHhCa0x5UVkra3VaRXZ5OHpYYlRsL055a1hCNllo?=
 =?utf-8?B?SnJiTGFyQldQQzV3ZkJ4M3lwbVVYT2tTRWxST0d4Qm45NFdDcWJEVWdxTkl0?=
 =?utf-8?B?M3kvZ3huRGUxSGltSnh3WmpOOWJ2RGtZVkRuQi9JV2h0VlNSSVBlckwyYTI2?=
 =?utf-8?B?M01pMXF5dkpNSkFYcDdEL0xGeUpYLzhiMmNUOWQ4azBWUGJRMUt3ZVdPQWpw?=
 =?utf-8?B?dXB1dnJVSDBzY3oxbFFqeDZ4ZFJOZ3hCYUtNaFhVaWg4SDhhVHhhSUZnMUF3?=
 =?utf-8?B?V3JnRmQvdmJaSFRnY2dZUDBzVGFONTBhYTVJM0d4YTArbjIxM2lMOGhpeWVm?=
 =?utf-8?B?YWtWakdnSWZWRmdLTXdVYzZFdTlJUWZQY09qVDZWSGdicStaMWNuc1krUm1Z?=
 =?utf-8?B?Mlp6QWs2Mk5IdElNQk1RMGRBaXpVb25nNDdhQmxEWG5aTmxNS0dCWUk1bFNF?=
 =?utf-8?B?MndZdmpKL08wVXU3V0VBbDhzT3FwTTh6SkhMMURwQkozeUE4U091T3R4Y2ZI?=
 =?utf-8?B?cmtqRkJ1NUE5aU5jUzBZM3dHVWxid1E3dnA4eHcrTmpTZm5aTm54eUNqbVAv?=
 =?utf-8?B?Q1ZyTWpzSm9OQzJKdWl3MTJOYnk2MjJjQjl0dUs3eXJ4djFxbGRONEpuZFVR?=
 =?utf-8?B?dG40cytRUHNNQXB5YStrZm5KNmhtaXdlNERJNWFSdCthZFkvNVl5UFhnd1Ir?=
 =?utf-8?B?bE9UcWUyWnJ6cDNIK3hkT1h6ZHFLZWNWWUpFM3lUYmhNY3BOeThNaElDZW4r?=
 =?utf-8?B?TFBZK1oxWGo5OXNvSEUvbXJCZHdlKytveENaeTYyK2Y1SVdzZFNybzJzL0lH?=
 =?utf-8?B?czBYSVI5QjlrTVZlcDNyZFNiYTRobGdJbE53RUVRYWVJYW4xQ2pKWmVWRUdr?=
 =?utf-8?B?bXlyMGRoZHBGdkQ4OXBmNGFCM3g3WGVya2pTam05SjljZ1NuS2l5VmZ6Q0VN?=
 =?utf-8?B?R1RRTUVGdk5WcW5UQTJOQUZpMkhXSjd6QTRmRWxYSFRSc0RIU1daeWdHSGoy?=
 =?utf-8?B?dDVpTUhETFF0bXBRRnFtNVVZTTVobEFmUnUyRmVlL1U1M0c5TjJUc0grUkJH?=
 =?utf-8?B?ZEtDRnNKbDZyb1VUT2wrMlc0U1VGenpKYy9ieVRESnE4MGRpMk83cmhlcWlr?=
 =?utf-8?B?Q045VGhtWExFTjQ0MDZlSDhFcmpNWjRTQTQ3S2VMQ3ZiNnhlUnQ1TEpSSExB?=
 =?utf-8?Q?KYxjQZXKqFY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejBjaXluMXdXQ0dVV01KMUt6NjhyMUEwOHlNOWN3UUowWEZQSWNONUYxTVV4?=
 =?utf-8?B?cndGR09FWDhpU250RXdOUmVKSERRNkUyM1YrbEpEdWI2OXN5SDkvT0haSDN2?=
 =?utf-8?B?bWxFUHkveEVtMTdCb3laRk1tb3E0VUM4c0kyL2NGSVhEVXZzWktvUnFTUkp5?=
 =?utf-8?B?U0pXM2s5bjBmaFVRdkhHRmM2THFuUWJrU3krNW1jT3EvK3pSS1o2QmNYR3gy?=
 =?utf-8?B?RlZJeXQ0YXBDenkrS1lUQ3RCMkN2cDJUdmN5UmN4TXBsMXRMRDFQbTVoeE1o?=
 =?utf-8?B?cVVjb0dZM0owcThZT0RNZlE4a0ZDK0s2a2IyTlNVMU01eGdvZW55UVczZjJr?=
 =?utf-8?B?ZHkraDQ0VTJWRnFCS3MvbmN2anJRWTVLQnU3V3lqODdJVXNKWURqazVsR0Mr?=
 =?utf-8?B?dWZjSlZKUkhFNmd4Y3NLQjdadU5ZMzlHdmRZejJFaHBRV2NaanB4S2Uwb2sr?=
 =?utf-8?B?ZU9GbmsvT1ZnaFp5TVJTQmE0M2xvU2FYU082dUkrNzI3YUc4TUVyVklHUldZ?=
 =?utf-8?B?b3Z1VzJhbmZkK245U0JwTll0b2d5amtiWDU0bnNqNklZMjhjYlNXZGlBY2dq?=
 =?utf-8?B?dklHeWRzaHp1K0dSNDZWem12TGVjdTFiVU1YRVM0VTNoa3prcUUrNnE2OW4r?=
 =?utf-8?B?UW12cDAxaittLzFGMzFYeFpNb1ZjdlVERWFJRTVkb1RPTlJpVDV5clVoQmlQ?=
 =?utf-8?B?YmEzUDFhMGVNcTNXajJQWG9yclZEZDgwYWdCRkczeHB2VUt6MmhjbGdmSzJO?=
 =?utf-8?B?RlJkVFdqQkZpbDRUQzljZ29jbkdqNDNicjZPYlNYcW5Ja2ZUWFAvTDBOdlE4?=
 =?utf-8?B?S3EzMWtneVJWQnV6T0hFSzZFNFFVbDdpWHVTbDZzQTJiWFk3NURiSGJyaXow?=
 =?utf-8?B?VXBPais0UXdlZm5PaUkvSTdyOHhOazBWWWpycUFVSVI3dVExaTRaNzFGK2FY?=
 =?utf-8?B?ZVpvc2tENHNnQlhCRDVDN25BSEQwbjNpUHFsd3BUMks4Y3dPQ0Njd0o2T1pO?=
 =?utf-8?B?VnE4bkxUdFh4OFh4RkV4RWdoa0s2RFpSZkhiY2cyNGVFdis3dDVMM3lPaitm?=
 =?utf-8?B?Q1hDaE85QTlEUXFYSDBMWHFMcTdyQnhSMncxWnhJVEpmWUt1RDJjZmh5S3VZ?=
 =?utf-8?B?aHVMdEw4VW96U0doVnBqWkt1VjMwS1BnMVdBdkVJUkxrdjZpYnQrT3VDaXM3?=
 =?utf-8?B?SE5pSjI5bW8wMXMxLzZqUEY2RkR4TS9oQlovRVBvcUVJeDljVlZmeFpIcVpx?=
 =?utf-8?B?NlJOaWJib0I5YlBkL3Q1NDRYOXdDazAra28yZFlpekFiaEE2MGluZlBORkdN?=
 =?utf-8?B?Y2VCd0dsd3R3MEhMeEhlSlRYbmVHV1FmYlBaUGtYc3JFckFoSkdlTXJQdDcz?=
 =?utf-8?B?d2NHR0JsRlZ5NnRoQ092dThkNFo3alc4UkdicHI2MEtYUVRnaUF3cjFoMzdD?=
 =?utf-8?B?MVY5ZStnVlRLamg0QVJraDl2UllMcDNrZGFQNlZYdkJvZzlmbnQrVGkvZWZ0?=
 =?utf-8?B?QmRFRnhLbktCTllQNDVFM1ZoemhyRk9oRW1ZTUQ3eW1xMVJHclNBN0k4K2Uy?=
 =?utf-8?B?N296clFNV1psNmNreWIxYjU0M2JYdHZmQlV3S21HaXBSbFZwQzBwZm5OaVh0?=
 =?utf-8?B?YkszcGFPa1RiZEFsZGorRFc0NVdlNVVxNFQvbHk3V1E1d2taSnBORzYyQVpy?=
 =?utf-8?B?RDRpbGErUDB4S1BvdHJoNzVDcktsc1JIQUkyd2VtRi9SekQyWHJEL3BMOXdz?=
 =?utf-8?B?VU1kOEkyWHdmUnd2SHpNZlJkeXRKY25sbUNkY29zeVRJbmJFNHZGSGNKZHg5?=
 =?utf-8?B?RUVnR00zS0xxU3RTRFkwcnZKc3RpYjAxSTh4V0p2cUZ6ejVOcWk1TXhuS1c4?=
 =?utf-8?B?NUh3Q1lPOEV1T3RJLzFYWHFab1F2Skc1QlJJZk4zRzFhUzN0aGk4MklYeDhS?=
 =?utf-8?B?MHAvVUJMVnVPdXdxL0ZodkxObHVGWDVnd0x5dkRpdHNoR3hZOHFTcjVlTklH?=
 =?utf-8?B?d2NZOEEyVlBmbHZVbDdzYVpKVDNycC9iMVVTd01YVGF0RUlaZ1lyZWs4RlBU?=
 =?utf-8?B?eVhLc0J3MmdCUlRHbWlva05VSUlKVU1HUFZOWm5jOFEweHBVbTdVOVBVU0Vq?=
 =?utf-8?Q?LZVWMfxKTCoMbnT/e+CZT+8i6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a016dab-195c-41d4-ff10-08ddfac8e264
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 17:44:45.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuZxA5FNN4dN9XhK1J06NEtODcec27uEXHBO2Bqa7OdK/b5e5a3sAcvSRygzuudvb6iMpBRXz5lZ3uHskIFCnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218


On 22/09/2025 19:51, Vadim Fedorenko wrote:
Hi Vadim, thanks for the patch!
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 5e007bb3bad1..74a63371ab69 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -4755,9 +4755,11 @@ static int mlx5e_hwstamp_config_ptp_rx(struct mlx5e_priv *priv, bool ptp_rx)
>   					&new_params.ptp_rx, true);
>   }
>   
> -int mlx5e_hwstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr)
> +int mlx5e_hwstamp_set(struct net_device *dev,
> +		      struct kernel_hwtstamp_config *config,
> +		      struct netlink_ext_ack *extack)
>   {
> -	struct hwtstamp_config config;
> +	struct mlx5e_priv *priv = netdev_priv(dev);
>   	bool rx_cqe_compress_def;
>   	bool ptp_rx;
>   	int err;
> @@ -4766,11 +4768,8 @@ int mlx5e_hwstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr)
>   	    (mlx5_clock_get_ptp_index(priv->mdev) == -1))


I would add an |extack| message here.

> @@ -4814,47 +4813,34 @@ int mlx5e_hwstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr)
>   
>   	if (!mlx5e_profile_feature_cap(priv->profile, PTP_RX))
>   		err = mlx5e_hwstamp_config_no_ptp_rx(priv,
> -						     config.rx_filter != HWTSTAMP_FILTER_NONE);
> +						     config->rx_filter != HWTSTAMP_FILTER_NONE);
>   	else
>   		err = mlx5e_hwstamp_config_ptp_rx(priv, ptp_rx);
>   	if (err)
>   		goto err_unlock;
>   
> -	memcpy(&priv->tstamp, &config, sizeof(config));
> +	memcpy(&priv->tstamp, config, sizeof(*config));


A direct assignment would be cleaner.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
> index 79ae3a51a4b3..ff8ffd997b17 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
> @@ -52,7 +52,8 @@ static const struct net_device_ops mlx5i_netdev_ops = {
>   	.ndo_init                = mlx5i_dev_init,
>   	.ndo_uninit              = mlx5i_dev_cleanup,
>   	.ndo_change_mtu          = mlx5i_change_mtu,
> -	.ndo_eth_ioctl            = mlx5i_ioctl,
> +	.ndo_hwtstamp_get        = mlx5e_hwstamp_get,
> +	.ndo_hwtstamp_set        = mlx5e_hwstamp_set,
>   };
>   
>   /* IPoIB mlx5 netdev profile */
> @@ -557,20 +558,6 @@ int mlx5i_dev_init(struct net_device *dev)
>   	return 0;
>   }
>   
> -int mlx5i_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
> -{
> -	struct mlx5e_priv *priv = mlx5i_epriv(dev);
> -


mlx5i_epriv should still be used here. on IPoIB netdev_priv gives you a
struct mlx5i_priv .

Carolina


