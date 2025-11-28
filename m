Return-Path: <netdev+bounces-242625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4CFC931D7
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 21:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31EF34E15F7
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 20:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E430221C160;
	Fri, 28 Nov 2025 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wfNHc4wE"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013071.outbound.protection.outlook.com [40.107.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084D729E11B;
	Fri, 28 Nov 2025 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764361784; cv=fail; b=tSjIuLwVxaxtxo8lzbycy9u6XiLNQTNp5LtPIcB37efDynteMajbfYIJmDOoIvfDwkCXYJptSKhtbP391Bx/3NUe/GtneGFxwYhz4lmay4/Wp/q56H13YIP3uIjvF33j455T04ki7eEq+4RhnRsAYzWZNCMdmHL3wzx0Q/KYKzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764361784; c=relaxed/simple;
	bh=bpPhB68D/IGQhDAWGsiAnNDRimcYU6b8qgy8hKIUc7I=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SJRolK6twIyAWH75+xw9j34WsxdG2sqDbM9wka1NTBUQ8nYMCFomU8EwbrzOFPv7NENSmu3Ww3IYt8Qkgym+hvU0QPl0fD7grtTDBNi4EeT0EOCIDxLUmdPhtotSgvLTI7Lt7NNyTzM0Oe3GeO0XiaxGAU2zfgwsEdPluL6JIiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wfNHc4wE; arc=fail smtp.client-ip=40.107.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9/Yj0LoMa4QvGFEcQcOG8nezB6lX43budQJZkaE3oOXOkyrsr3AZXpybtOxfea1V5SeipuD7QYjxOGtRi4pJ76Gdw5ACuv4+RS/kRnTfkenj+bmG5lzRqE77NZFhzp2R7aWqOxWG/645RXtf8WqD/zLxAbyczjCIjY773QtJrgIDwhgiTCHzWIcD7gh1WBQ4/USgMvXOZLsq03LV9isOjuhhTg+xN3pE3twkzKAfZAGziXUU7uKrI8jQ20v+fOIafCIRt7TJYVHx14y0Gfo5bBv49SzpA27IpbNx1s8TdmDQT/k6sx9gdDyv3u7NsECEOcBgeBmW8mVmFUSImxRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jM0/iII2Ma0Am0spUsEbbdG9sDVAw27lpT7Hiifmuzo=;
 b=Loamk4bJT/X72zf3VCJUUO219mD7kJpL2xYNe+OtCHhd8zVLrdIjEi1ju3LwIJAQnjiG8t5p7bQWUi0i8o1+fOnblAA01ZfAZSrog7oFVU6W7efAa9XzKMr3cBxCI8y5RytU7a6di/WhDtW7lL8xKTSWHdDuWlqyj0dTdyGwAs/eMfOLSgA4BvjeMp1td26p7McbRicoDFrlI/P8zPg6zDFRDzeOJbJo/HZJioxZEt+x7cAtWj5Ch2N/u24lHNhN23gEXzCO1/2WfrIFi0IcaIHn9LniE+8W80xbd9md9SbDEqtXsvTwqXSGgpfK83mdQZC39n2Uwo7cesuVtOcFsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jM0/iII2Ma0Am0spUsEbbdG9sDVAw27lpT7Hiifmuzo=;
 b=wfNHc4wEd4yN7ngknoGhM+UwM+SB+DDBjDmwAdxlZ9PzCWrrAo1qVrgtPBMB6BElc7APBWSXk40ypfGlI+JHphXo7LnS8BaK9Vbn4yOMwG//EO5u+hHj1NKQx4LaJqKcxVE6Smvkc8zrKIr8FTNafiuaXzuqR6mtX+hUKWEU7W0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.14; Fri, 28 Nov 2025 20:29:40 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 20:29:40 +0000
Message-ID: <d1de6633-e068-442f-98be-8d0cf5345f04@amd.com>
Date: Fri, 28 Nov 2025 20:29:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 00/23] Type2 device basic support
To: PJ Waskiewicz <ppwaskie@kernel.org>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
 <31dae6910b0863dee44069d01a909f8ed0b19bb2.camel@kernel.org>
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <31dae6910b0863dee44069d01a909f8ed0b19bb2.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::22) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 024b3382-c8de-47a7-f9a6-08de2ebcdb14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTlNSTVvRWZBOEg1V1Zyam1tazlOWXVvSDJkcEdlMnRCV0d4SStWL3hXQnFn?=
 =?utf-8?B?WVZlTmw2SEpzU3dUTmxzaGY2YVp0VHVsbytXSlozTHJwUFNwelpSZVZ5Q1Fp?=
 =?utf-8?B?Szg0NWZqRmlwa0hveGtNbXliQ0RxZzVkODlHQjhWVUhKRk9RdElnK25mdnhP?=
 =?utf-8?B?dTRManJLRmdHOGc1Z0hzQlZ0cWZYc01kYXBWekpIdm1DTndlNURMeEp6RDV1?=
 =?utf-8?B?QVBEVlk0SUVzTFRCMjV5UGhhQWp3RHgzaW5kNDhmdU13SFdLa1RnWnpBQjhs?=
 =?utf-8?B?RDlIUTNlMTJUaWdoendFRm1CWlZLQjhFeTNYbTB0UFRzVHRybEFFM2Q2bUxW?=
 =?utf-8?B?bzZXdnlDME9hVjd2QzdFbjFnSHZKSm9sYjNIUTJ2NUFUUklucUp0Y3RFM0FV?=
 =?utf-8?B?aEMyYldLWFpHVWZyZmdvbUZiOC91c1lLekJvT1lqNXZVWTk2dytHWTRBaUZF?=
 =?utf-8?B?QzRMRC9mSVRsek85dzlhdGJhUVp2YjhXdmZBNHV3NU1wdUxSZlFBdFR6c3Zx?=
 =?utf-8?B?bTh4eHUwcFY5MkdMeWhqY2o4OEJValdrVFFpc05hZnhFcGtmMnd2NUJkUVVV?=
 =?utf-8?B?RUJvdlhOTTNMYXdlVkZKN0RURExNSTljVFVtN3FJemZnVUJIWE0zZ2Z3b1Zr?=
 =?utf-8?B?QmVhdDRwTGVmOXFtcmNFRGU3L2NGUTFCaUdTVXE2MTRsL1hnY2cvT3g4bUlr?=
 =?utf-8?B?MFc4ODlZUk1aNkZ3YjA2RkdXaGJ4SW1iQzAzQ2dhbVlSTmUrZWNnZWNyeWdB?=
 =?utf-8?B?dEV5YnlFV3pDMllxWWtzeGVsSHkrK3RDZTQ0MXRFL1VjcVoycXF6OGR2UVlo?=
 =?utf-8?B?UVU2OXBnTHlSOE5pbDFXRjNMRVhZU2QzN2FXZVVNR0c5MWUxYXRuUEluSzJl?=
 =?utf-8?B?MkZWNWdhdU9uVXB4TWZGZXJ1M1VNeXBKMFU2dnM5M3FpOHhPbGVxWm9Jc0JS?=
 =?utf-8?B?NXJDN0l4WldQU0pON1MvNnZPMUY2YXBubm9LQTFoajd4QlpldjF2dm5TWFdX?=
 =?utf-8?B?VU9mN0hydlBiclZYaTd2UThJQUFnMTY4b0tYeXF0cWFwVkFYY0xveWNaUHVs?=
 =?utf-8?B?RkgvdCtva2wrbDh5L0NiMGRVTjVFUHNqUzZFbGNyMEpOdzJyVVhobm4wdVZB?=
 =?utf-8?B?YmdRaStGN0xrSk5SOXQwcFcwSlUrejVHVkNsRDA2ejV3bXAvUkowOExjZkZq?=
 =?utf-8?B?S3p4TUZWT1cwWnQySldLZW14TFhLOThRM1owWmhUbTNqdkNCaVFNczhKTm0w?=
 =?utf-8?B?VDk2SDRCYjFWZnk4YThJK3Fsc2NHR2RldWF0cUlqVWdMR2tKMkZPditqRUVj?=
 =?utf-8?B?VjNoK2RxbGpOM2d2bDNKVTBKN3g0VVl6RHduWUhRTFlZUEp1eDVpVHArbkNP?=
 =?utf-8?B?WkhiWjlXQjhXcFlSQnJlMERJWmxidERHcDY3S0ptM1BzM05XYmp5dFNPRUMz?=
 =?utf-8?B?R2cwMU80aUJVQjd2Sm0vRDErZFhWQlZDZThJSk40a1dLQlZEZThPWnowMUpz?=
 =?utf-8?B?MUV0NUUwUVZkSFB0UTJiWjhuVXJ1ODZmM0lGRldSM1A0dlVyNkNOZFRsOG5m?=
 =?utf-8?B?YWNFdTJsMEJuOXZiemFKaXJNRkluUDh5eUdtSGw0SGYyaHlyejFvekxCS3U2?=
 =?utf-8?B?a3p4TUlTcnJCelU4UE1aVkxWQWFlUXhjRDZQek1ZbFlVekVsZGtkako1MmtL?=
 =?utf-8?B?dTNIdnRNZXRzYkU4K0pPckZNU0pXY1k4bDgvOWI0Q24rWVM5bGhWYlFiTTRO?=
 =?utf-8?B?N1BUY0dEMEo3ZkhUUWZUWnRPYTJhQ1JhNEYvSXI5OU9icEJVQmd1SW8rTVI4?=
 =?utf-8?B?Q3dPZitGSTY0NlozMWRCdlFvcDZ0TnZwYXF6MElIWU9hRTYrR05GTlF1VWNr?=
 =?utf-8?B?dUFWT0U0c3lPSmQwdVlLZGJkVmFzMFIyM2RxMUhlSW4wSFhZT0R6dm5iZnk1?=
 =?utf-8?B?RzVEdEE3QWx2OHcxbEJTQmdlQkhxKzdiVnN2d3FzeXUyNFlQL2FhdTVYN0Yz?=
 =?utf-8?B?K1NoQU15U2h0RTVUeUtYMVVCS04rdEs0alFLdWxiRkd4QkZWT1FtV0NTc0hR?=
 =?utf-8?Q?quj4TK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVIycXZQRmJhckFhMzFPc0xVOGFLWFIzSDc0YUFVZXdLdmJIYjNQalV1eGRU?=
 =?utf-8?B?aWE0VEpQOG4zdW4xVUJOdHdXcDVJajd0VHEvR1pIbUdtV2Z5eHRVbFRGOG9a?=
 =?utf-8?B?TTdDdVdGbU1qUVN0TjZNZjhNRFVUOTNvOTcvU1IwZUpBMXpMVWU5SnlHUzRt?=
 =?utf-8?B?SjlUcys2c1YrVzVVcWR3Q2Iya2Jad1pVUnAxSS8zVkFNbG1YZmJJYmxuLzNO?=
 =?utf-8?B?QzAzYkRSNGU2eVE0ZDhOVklaamZ4RlJzSzJGSUJSWHR1dUQxQTMveElobTRq?=
 =?utf-8?B?VmN6NDluNVcvZjhMWU5TZG9pVHVlOXpZVm5mVnJySHVrSlh6eW1Kc1ZqeklB?=
 =?utf-8?B?M0FxVW44U0NObFFmQlN5SUhKOXZMWmF2aDdTU2dHNnRaQXJIRkg4a0FRMkJG?=
 =?utf-8?B?Z1pmQ0IyVnRwd2NzMTlYRjQydEtNRnJOZkwwclR0MnVLNkR6V0thdVRac1RB?=
 =?utf-8?B?a1BXbDdtaitqRndhY3lMNXZCdkx2WG1IcllVZHVDOEpFZVBBYkQzVEV5NmJj?=
 =?utf-8?B?NzhCWEJUM2hvdldIZWhvTmVJV2xZRTVRSkJzQVYyTllwWDRKdTcvV3JvVXJF?=
 =?utf-8?B?RjZQUDNzbGF2TldDQlF6cEZkNVlYbEZQTFdzSHdjK1h4VjlVSFFjRTRRUy9r?=
 =?utf-8?B?YjVHaGVVS3l0SjhLSFhUT2JxZEVydjAxTU54alpraG8zUXROdzdhWVpqZDVp?=
 =?utf-8?B?WFMzVTNWRFFNVEhadGlXYXYrdmwvY2J4VWE4THRVaGFwSWhHZHozdEM4TFBa?=
 =?utf-8?B?M1pTaVA2b1pwODhjZUNTdGxMREh6UHQ2WEgxVDc0NHJSOUhlMzR5MVRUcGtM?=
 =?utf-8?B?QUR2Z0NLeTB6dmxNbnFvNUNDREZYQ0RlMDNPeE5tV3pqa01xQTErQStsWkFa?=
 =?utf-8?B?dTE1blAvM2JrV0h6Z0ZyNW5XUWlnQTEyQjJ3T2pTZUt5NWtJYWdkeEMwWTg1?=
 =?utf-8?B?NGxlQ3VDMzhsTzErTTJ2ejBhbTBNL2FUeUpNNDJuWHVNWjhBT0dHTi9ZVFhi?=
 =?utf-8?B?QlZ1b2J6c2I4bGxVbHNPRDVaV1N6eStaSk4zVG4ydnVtcW1lS3FIUVNKK1I5?=
 =?utf-8?B?V3NUcXQ2ZlAyUzhiQUl4Z1B0Zmh5N1ZRcXpTMUNVZ0VJMFJZTXpHem5DZ3lF?=
 =?utf-8?B?TWRQZHhyWENPY3A4TTMyNnNrSTJVeWk1WktoVDdzSlVCRHNYYlRLTi9IWURI?=
 =?utf-8?B?MjRKdUUwK1FDbFA1WkpRWjlCWXlqYWY0UzZiNktaVmQ5Q1dlT21SNnJzYmI1?=
 =?utf-8?B?UTROQUFVZkNCRm1GQS9LcEtTaEhOZmZsTy9COGRrbzVxczRmMHE3d3lxVDlR?=
 =?utf-8?B?bTF3dVB6YXY1WVRYb1gzQlBtcm4xYkoyK2tDUzFXdzduUUFkMGVDb1U0M2Q3?=
 =?utf-8?B?ZUlTS1dJeDQ0V0ljQkJrSXFaSVRmVzFEb0ZFY0JGUWt3OVlUWUF0M1pjR1l5?=
 =?utf-8?B?ZDZLM05HYmp1NlluNXpSeTY1T3ZTVk9mMVpQNHFjTTVGQmdZM3pBZTNPeFNR?=
 =?utf-8?B?eFVNbTRIdVluNDl2T05uMFFQcDlJdmZqTEpqTUwrZHBEcGs4cExsR1huaXBj?=
 =?utf-8?B?WjJjQ04vUVliazh1eFd3V3lYM0N1RDdZUVNaSXNKN3haR1NpaVhNSStsaGFt?=
 =?utf-8?B?TW9CUWFURTZiekNRdk5sNmx4V2N2YVpWZnVBdlduMlFsUG1lL3V4cC93MVZp?=
 =?utf-8?B?UVNXYmFsOVdTVnAvWnZYUDliaEFlR1pWY0hwWGkxdHBRbDB3d2xOL3hUTG1l?=
 =?utf-8?B?UURtS1JBZnFFMVp6d0crOFdMcnRqRWdVREFrck9abUUxWU80MjR5cXlseklI?=
 =?utf-8?B?bFdxU1ZVV2NTeGg3NFpzUW1RVUFSYVBOOGJiSjJiYVFoNUthaFRxUlNOQWNs?=
 =?utf-8?B?Y3VxdHFTM1FYSUEydEpQM2hhMXg0V3lLa3dUU01WTGtTMHRvN21Dc0NnRy9Y?=
 =?utf-8?B?WkxFQ3dhTWFheUpwbGsyWE44NXlpZ21yakFRZHV5RlZXRzdwMUNtdm9Ddzkz?=
 =?utf-8?B?dlNvb042c2MyaG8vTTN1aTJsRHI2ZHZWdkJIVVk0amdFek9ERjN0dFlaVEU2?=
 =?utf-8?B?aS8rb0d5MjBEK3RwZ2pCNm15ODdJTlM2UnNkK2R5cDJkalVRN25zb1g1RURV?=
 =?utf-8?Q?9Dx2/dTScTXyuAvdtNMDJXVOR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024b3382-c8de-47a7-f9a6-08de2ebcdb14
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 20:29:40.1132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDFny/foV36FShYnJNSr2kyNnVYZDHyJLfaAxFFZsG+OHOIh6zi+rJ+VRnb9q4B7BAdYwEcYOmVfFKkuM+hm4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392


On 11/28/25 19:44, PJ Waskiewicz wrote:
> Hi Alejandro,
>
> On Wed, 2025-11-19 at 19:22 +0000, alejandro.lucero-palau@amd.com
> wrote:
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
>>
> So I'm unable to get these patches working with a Type2 device that
> just needs its existing resources auto-discovered by the CXL core.
> These patches are assuming the underlying device will require full
> setup and allocations for DPA and HPA.  I'd argue that a true Type2
> device will not be doing that today with existing BIOS implementations.


Well, I'd argue this patchset is what the sfc driver needs, which is the 
client for this "initial Type2 basic support".


> I've tested this behavior on both Intel and AMD platforms (GNR and
> Turin), and they're behaving the same way.  Both will train up the
> Type2 device, see there's an advertised CXL.mem region marked EFI
> Special Purpose memory, and will map it and program the decoders.
> These patches partially see those decoders are already programmed, but
> does not bypass that fact, and still attemps to dynamically allocate,
> configure, and commit, the whole flow.  This assumption fails the init
> path.


Fair enough. We knew about this and as I said, something I would prefer 
to do as a follow up work or this patchset will be delayed, likely until 
a new requirement is found out like the problem about DVSEC BAR already 
being mapped, then waiting for the next thing not covered in this 
"initial Type2 basic support".


>
> I think there needs to be a bit of a re-think here.  I briefly chatted
> with Dan offline about this, and we do think a different approach is
> likely needed.  The current CXL core for Type3 devices can handle when
> the BIOS/platform firmware already discovers and maps resources, so we
> should be able to do that for this case.


I'm sad to hear that ... I'm getting internal pressure for getting this 
Type2 done and I realize now it will require "a different approach" for 
being accepted.


Being honest, this is quite demoralizing. Maybe I'm not the right person 
to get this through.



> If you're going to be at Plumbers in a week or so, this would be a
> great topic if we could grab a whiteboard somewhere and just hack on
> it.  Otherwise we can also chat on the Discord (I just joined finally)
>
> Cheers,
> -PJ

