Return-Path: <netdev+bounces-112100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 283BA934F5F
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 16:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E62F1F220BC
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 14:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9111422DF;
	Thu, 18 Jul 2024 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ijGRyZ7e"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDD66F312;
	Thu, 18 Jul 2024 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314156; cv=fail; b=BX1YH2tFH0miA7cCX4p0eNbyteKuTpOciYIm+UY+3sAaxF3f83MpWR4Oe0jvhewyRXjocJRyW7yA5RAYMRlBDurq4oBxsxG1fTQ6nR7PkqDq04/mCdaGg57wM/KxpL0a9aAitnmkvFYqFAiTJbhCS7PZ5YCClFwPFUClhB3Jcmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314156; c=relaxed/simple;
	bh=d43+vRnEpGvAVhXyR96tWB5+lPfIWzob99FthIvKAl0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qpJroSml6S6Ek3G1wSKv2MEds6ZkqtjEW6qlLoIqb6HE2IDgaMlCEsa+JT649qGMDQknjLDGIk4FOsu4uD3JpD6XVpAHFvQJ6Xnhz/su9WopLvZSsRT7j/XX4F4Uer8wFN6C7YDTyJIKmwrSpVTJpU8CZ/2BC7Gs93s18eaYOkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ijGRyZ7e; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOL5Vk+8ho7zsgX+7ryn4P7VOhciBI3CsAmsuI9FNZXkhpF1ovMmKjrgTcBrJ6UrS86X2lg6HqNdxIK6/btJ9rFFmbe3b+mRLWEvg1GElmI3Z7XqFYFEiqRWnWjF+7q3VKxPXvVPmgp4tlKuC24KOVSn7xmIs4agki6XhfP4LzAG+uAoYferMK2AFZ8ACdMT95FsXWK5blehTG4XfRWUTA5vS/IPmXVCjhy/Xzl6qArMlL3aC3CtCkMhRfemKJZ5CoXdMlrY1yLWDzapVRSk0ljzLyKHLBs+vrOpzNurKv3oaCl2de9M70L5mzz4F3KF59JBNlkTjjwFJ8VPZ6bPSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlEIpOCM5ODOsYaFAg9pjbPFzKOqJs2B2dzXXBF0uLs=;
 b=IVwUkjQ0NYIRrYEg7dd9NzmyzhGP/wJPZH3+X09KZDswKosovEw17oPzm6pZ6VuaizlCpgSNsZOIrbqeY3BqAgdKw5Zeh/ARUpyqnqOnS4DThowNCxmMvdfVSCKQ+hCFYAQoF0s7CbXNQDsv7TpTi0sRbln9A3xIP7a4FfoyfA83kPwgLl4TMS3DY8bE9QO5Jy/yf/qhnIZtdBuvZcCY47R76CiF2RoL4as+3alKQa9gUjPikq8Qxc3KeHjP3sTNsWJE+VWZV3es9Tt8BFugEyGvmnl0h70vY6h/egXgeA9hrSSHX/UrEamK2ywjNljjAsvLjbAcwk8sb5jM1RjXPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlEIpOCM5ODOsYaFAg9pjbPFzKOqJs2B2dzXXBF0uLs=;
 b=ijGRyZ7eJ0Fof9OXeGOzNRjFzBhYL2iZZpyT6jmTTP4cYcT8k3/G/E80EfOl+4K8GKJPneXoI/kLZB8bX12v/VeC+ECFie5+qjKILUoXQHOmzs+bJf3Ci6kYfZiSxVJgi4AJNJ/4Imb+mTkA/Zocz3hJnHGY4mma/v+r3XBjYO3ZG15tkyqjyCpysfq4W4pp5eW7t/UEa/1Eb5GQhl7eu2rb+39lQLZV6/+znLJF0WHJGO4/OBS/NYwBit38OeGy25CZLHMyo7FEasZchdw0ptca0dCMiI5uiCd47pnrDz2IkUUYwmfFevGzJTvyrNILfl89xVyFJhk0QNoOYr0fMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.17; Thu, 18 Jul 2024 14:49:08 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%6]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 14:49:07 +0000
Message-ID: <874f68e3-a5f4-4771-9d40-59d2efbf2693@nvidia.com>
Date: Thu, 18 Jul 2024 15:49:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net-next v3 3/4] net: phy: aquantia: wait for the
 GLOBAL_CFG to start returning real values
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Brad Griffis <bgriffis@nvidia.com>
References: <20240708075023.14893-1-brgl@bgdev.pl>
 <20240708075023.14893-4-brgl@bgdev.pl>
 <7c0140be-4325-4005-9068-7e0fc5ff344d@nvidia.com>
 <CAMRc=McF93F6YsQ+eT9oOe+c=2ZCQ3rBdj+-3Ruy8iO1B-syjw@mail.gmail.com>
 <CAMRc=Mc=8Sa76TOZujMMZcaF2Dc8OL_HKo=gXuj-YALaH4zKHg@mail.gmail.com>
 <6e12f5a5-8007-4ddc-a5ad-be556656af71@nvidia.com>
 <CAMRc=MdvsKeYEEvf2w3RxPiR=yLFXDwesiQ75JHTU-YEpkF-ZA@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CAMRc=MdvsKeYEEvf2w3RxPiR=yLFXDwesiQ75JHTU-YEpkF-ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0437.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::17) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: 059ae335-9f7f-47af-0a28-08dca738c703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGw0RGtzeFZ4MDJ2SXB5NHo1dC9ndDQ1YWFrUEYwVDdLYVhzTUpwc0FVYlFY?=
 =?utf-8?B?aTlCTTdwNUMvb1VyU2JKb2VMaHNQSTZkc2hDV0ZpRXlXZitQWHBQS2c1WThi?=
 =?utf-8?B?YVlyb0ZiZ1B1aVBRdktQZFVtdUpneGpsTTJGb0ZQUkZlWC9UdEhWcmdGVkJm?=
 =?utf-8?B?alpDSmNSdEFqTVNsQmNGWHRMNE9KUEpLRlVKTmVvZFpHNzVPSFNIWW5xZHpi?=
 =?utf-8?B?SHh6cEJHaUVBNzlhV1hVd0loMWcrc1M0NnVLZnpTT3VuTVBUekdNTDNvcFoz?=
 =?utf-8?B?VDNFS0Y2dUxadUx2a0M1VmVOak1mUUN4NTN4ZUZxSHRVMndQMUhPa3VmajM3?=
 =?utf-8?B?MjlHVUZ1N0JjZWNKOEpUTU4vYy9lenJWUEVIVmU2R2xURWFBdm9VRHBOb0FK?=
 =?utf-8?B?TlBvREYxUXMwUlhrQW1abXJlOUNrSEczYkFJQnB6M09uVVh1YjBBeHBlL0dF?=
 =?utf-8?B?UlNIRHV3eHdCVlBVcFg3dU9CTlJ2ZkRBUDdoOTYzY0M2R1VnYTcrNFZlRklu?=
 =?utf-8?B?MHhXalJOcVlwNCt1V2tsOTB2UFRsdDgwN0pTSTE5Z0ZHL0ZZM1ExaHc1MnV5?=
 =?utf-8?B?YTAxS015MStEMFZMVnc1ZnJPNnZOSk5jOTdDWXI4d1JyblEzUmY3TytQeEt6?=
 =?utf-8?B?Rm5JWHhPT3BVRFFLQ21IUWNaM3U4RHJKdDJVeXZLeWhDMCsyWldtU1RMdEtr?=
 =?utf-8?B?bXhWZjIrZnJDcEtvbVpraDhSWEF5Ty90QVRqelJWK0I3WFlGSktNNC96Y2dL?=
 =?utf-8?B?Mm1saTF3d3YxMXJ0aGg1Nklnd1E1R3hOOS9VRUZTTDh2MVcvK2RZaGUydXAx?=
 =?utf-8?B?Yy9saTlja0VjRUg1YXllL0RTeEZ2Z2hrL3ZpSitTSzN4dFAyNjZpalVWNi9n?=
 =?utf-8?B?YnQ5RTBMWUFHSkJqRnlYMTB3SnFwdzZlUzBmTnlTZzRhSlVKcUhUVWdETWhI?=
 =?utf-8?B?YjlvcXRKaGlrYWF3aFExcUlNd0dEMHpqRllubHVlNFR5Zm9mdm5MVVRNVHk2?=
 =?utf-8?B?VUZWTStXSnJFcjJ2b3lqUXBaTy83TDIxbERUVXRveTdFQU8zMTVmb1UzZi9v?=
 =?utf-8?B?aWdPazZ3d0h5Q2tjd2dCVEFTMGJNM0VKSUE4L1FMVXRrdThtdVhzUXZxWkR2?=
 =?utf-8?B?bnVzR3pIRkNwUzRwcDdDTVl0ZzJ2cnBlRkRSeWd6Q2JqVVFjd3crOXp2YVhr?=
 =?utf-8?B?a2lpQ3VpeWhNdzdESk5QZnE0MVpCdk11QTZadjNlaTFLNDNkWnJ1T2xXaEZ5?=
 =?utf-8?B?WW9lVi9hd3AxWjc0eDA1QWVYNFdkejRjV2xWdFZBc0MzQUhkaW5YdStUSE11?=
 =?utf-8?B?RTdxWjJoUmR2d1FSeEZBMmZZTnB5anNpK25WOElISVdGR3hTMzBIaEhVV00x?=
 =?utf-8?B?cGRMcVVqVVEzYy9JUkZ6dDR4K2xFZU1sUDArZlBxMVd5eFJ0ZU15MGhsWGV3?=
 =?utf-8?B?NUdHRHZwZ0hiT2c0UnZidlhhMkNaVFJQMDlLV2doQVduSUtlbzhzSXNpYXFW?=
 =?utf-8?B?TGxCdmp6WisvM3VHYXFHQnBYRkw5VjJZT2taOWNWaXhpOE1EN3JWdWFwSlpl?=
 =?utf-8?B?c3NyMHo5Z2VOV2s0Y1hRMDZkMHlLUWJOR0d1aEtNMnZpWkUxWVp4dUVCOEUx?=
 =?utf-8?B?WGlSVnF3STJieFVFM3gwbmtKOHdNNkltaHM5Zkd1V0k4UFdaeGZMMFRpRTcv?=
 =?utf-8?B?QVdUMHFmZTkybm9VM0pSS1IrTDI5Vng1dVl0ak1UdHZZZjlWNVBZZXg3V0dE?=
 =?utf-8?B?NC9DZkZ5bHllL0lBOFg3TUhRR0dUb1pCbDFPMFFTWWRsMmNXcjVDSjNTTGU2?=
 =?utf-8?B?MHlreUgxNnlodlVLTTIxZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTlIVlpGOWdXMWNHQ1MwZ2J5eWtWZDE5MW8xeFdnMkFvRDMydnZldW9ndHlB?=
 =?utf-8?B?Q3Z1MGtUMW9NUC9Sa3R3WVV2TzVid1hZSE50bXJLS3c1U3ZoeWg2MFJXcWQ0?=
 =?utf-8?B?dEt6YzdudXdmaTVGdVVUQzZENTZwczZ4T1VXUFYyRFpBTXYrV1JRS1E4bC9D?=
 =?utf-8?B?STNqR2FEdldPUmFjOWxNdUJhNFlOS0Z3eXV2bUhWZUpjeUtJRVoyU09iRmQy?=
 =?utf-8?B?K3h5bjd4YkxURFFIbG0wb3UyejV3bDJpN3E3cnJDUFBTVlgxSFJjWFBYWUhY?=
 =?utf-8?B?ZmVrM3JIbHIzNHo5aTJXVjBRQ0d2QlBjaVdPVGRDS2hiR3RoNG5RdzRxaFVp?=
 =?utf-8?B?ZDZuSVg0cjBPK1JsOXRFbTRiNVNKa0JyT0tSZnIxeXlHNVhnZ0RLa3lVQ1Fr?=
 =?utf-8?B?SUNxUWNDeVFsZThnSkdMVW9TeitjNGhDUHNZeTlIMVlUUTlkeUg5WnR2SWRs?=
 =?utf-8?B?dEVpSk1zeFF5WjNIc1YxMmhUZTlhNHZkd1ZQaTBBZ0VnKzcwSHRKTUtoSjEx?=
 =?utf-8?B?QUFPcHU4eWZjMWo5T2k2NVMwUFZ4c0FSTFZVek5YWCtmdTdqcGV1aHhyQk1z?=
 =?utf-8?B?azdGMUdiRnEzTDM4TytFSFVFMTVsOTlMY3Q4bFlJdk5ET1pNOTNpZWNPV0RR?=
 =?utf-8?B?bWZ1Rk90V2pORGxzMWJWSmdLZU9CaDhkY1lTQnNyRUVWYlhOOGtTeXhYbzQx?=
 =?utf-8?B?QVdsRENVN3J2cnVFYTZxUXBYZ0k3UU5GblF2WWtFWmplOXA1Y3RyU0VPNExw?=
 =?utf-8?B?RXh3eDluSkMzTkpxYmlFc0xFN2ZBbzNkbXNGRHNZNjNPcloyNlJJZm5ZVEV1?=
 =?utf-8?B?eHJVSXdXU3VsTVFhMzgvcEw0Y1JOUlp5Ykx2eUxsa1JCc21CeDFEY3RNVXlk?=
 =?utf-8?B?OUk2Y0VmOFZlNWJWY1dFRzFkUzhyYkM3WnhtMklEZm9XcHc4NHQ0MjEvMy9W?=
 =?utf-8?B?UVdZakcrZTA1bVFXWmQxWGNNekZCT0V5K09ueXRIazgybHVJb1VaL1duWlph?=
 =?utf-8?B?UnN5a1Y4L3NTTzd1bnU4T2plVlFWK00yZWxuNklsWDkvRWVaakh3VUE1d3R5?=
 =?utf-8?B?a0tQaTZyNW9ONy9FdTZ5UHloRWRHVjRYZktuQVB4aHV1U21jQ0U4aFV4aXJB?=
 =?utf-8?B?emZHaHZmSk5ldFVGQlpxTzdUNVBFdjF4VGt0aDl1MHovQUQrY1RCdnlzbEwz?=
 =?utf-8?B?Zm5SOVdDZDlEakZ2UHRhRFhhdmphWXA1Tm5mZzVETDZBcVpIWnBFUkIwQXlx?=
 =?utf-8?B?dzdwMDBFVHExZUExK0RRV09TT1I5QWNwMVRRRHV0WHRnaVlFRjBnbWNHNzd2?=
 =?utf-8?B?WXppRkpKSUdVK0c5N3AzZHYyOUZRY0tDY3ZCaEtOOEgzVVptMWxFNlJNcFZB?=
 =?utf-8?B?V2F2eHYyTCtIWlliU2FQRnJnT0pUc2thbi8rNllxVnpiSW9FbEIyVUtZOGJY?=
 =?utf-8?B?TTB3QUtEdkp1RlNwY1UxLzRNQ0U1cjF0SEVQOWhEVlA0QldESitRVWFGZmJZ?=
 =?utf-8?B?T0oyakN2YXY0bkxXK1VVSk5wTnJNd1pIMkExVUtzaEhLamJqZ3hYMnQwT1VG?=
 =?utf-8?B?dERlQnJHMFFxZWxUZkpDZGxNZTZsOE5mcGpmS2tlNTJ5UU4zak1GR0hRNmNo?=
 =?utf-8?B?MHlUTThLZEQxaktoQ2o2bHNZZStBZWREK2tKbjBCUndlSmJKcmNIMUZwYjBh?=
 =?utf-8?B?OUtQMCsxOEVBRklzQnlCM1V4WnRXRzR4bm15Q1NIWEtkNjBhTzBXMVNyMW1v?=
 =?utf-8?B?WklJRW9yYXcyQ0hFb3FtZHMydG5FdkpzcHY3VGhtc3FMaVM1Qjl4RUo0NWEy?=
 =?utf-8?B?d2F4eG5pQW13TnlzQ21rWkRWSUkrOEJ5OFp5Qnc5STF0Kzd3eVptZ3kyZjVx?=
 =?utf-8?B?enhBTkNZa25Uc0tRcDRuRlQvUWpPbmNFOWcwZjV2SWRBaXp6eHF3VDAwdUFQ?=
 =?utf-8?B?YjIySk9DQWpnT1Bmb01rQmhlR2w3SHB6d1VtZkM3NTFGOUJQZks5SURXc3Ry?=
 =?utf-8?B?aW13V29VMnI1dUhhVU5ZcXRWQlJ2WGFCbWQ3dUttUndUK3lDc0RFTEh5WjBY?=
 =?utf-8?B?RlhNWnZrZ3ozSU9ERnIrVjF1cTQvWTM2QThnNnBVQUtPOVNzYUoyWFNqRjk0?=
 =?utf-8?Q?1YID3lueMoztlvtetxx57AZG4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059ae335-9f7f-47af-0a28-08dca738c703
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:49:07.9598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LptYLfYYcBOBbAdI2I0ieeVnZdcLnUvZxtkst9C/pqRHrpit7rsx5uNYsEWCPjE2dW4s42d0fVPCVO8OvXvs1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355


On 18/07/2024 15:13, Bartosz Golaszewski wrote:
> On Thu, Jul 18, 2024 at 4:08 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>>
>> On 18/07/2024 14:29, Bartosz Golaszewski wrote:
>>> On Thu, Jul 18, 2024 at 3:04 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>
>>>> On Thu, Jul 18, 2024 at 2:23 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>>>>>
>>>>>
>>>>> With the current -next and mainline we are seeing the following issue on
>>>>> our Tegra234 Jetson AGX Orin platform ...
>>>>>
>>>>>     Aquantia AQR113C stmmac-0:00: aqr107_fill_interface_modes failed: -110
>>>>>     tegra-mgbe 6800000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -110)
>>>>>
>>>>>
>>>>> We have tracked it down to this change and looks like our PHY does not
>>>>> support 10M ...
>>>>>
>>>>> $ ethtool eth0
>>>>> Settings for eth0:
>>>>>            Supported ports: [  ]
>>>>>            Supported link modes:   100baseT/Full
>>>>>                                    1000baseT/Full
>>>>>                                    10000baseT/Full
>>>>>                                    1000baseKX/Full
>>>>>                                    10000baseKX4/Full
>>>>>                                    10000baseKR/Full
>>>>>                                    2500baseT/Full
>>>>>                                    5000baseT/Full
>>>>>
>>>>> The following fixes this for this platform ...
>>>>>
>>>>> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
>>>>> index d12e35374231..0b2db486d8bd 100644
>>>>> --- a/drivers/net/phy/aquantia/aquantia_main.c
>>>>> +++ b/drivers/net/phy/aquantia/aquantia_main.c
>>>>> @@ -656,7 +656,7 @@ static int aqr107_fill_interface_modes(struct phy_device *phydev)
>>>>>            int i, val, ret;
>>>>>
>>>>>            ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
>>>>> -                                       VEND1_GLOBAL_CFG_10M, val, val != 0,
>>>>> +                                       VEND1_GLOBAL_CFG_100M, val, val != 0,
>>>>>                                            1000, 100000, false);
>>>>>            if (ret)
>>>>>                    return ret;
>>>>>
>>>>>
>>>>> However, I am not sure if this is guaranteed to work for all?
>>>>
>>>> Ah cr*p. No, I don't think it is. We should take the first supported
>>>> mode for a given PHY I think.
>>>>
>>>
>>> TBH I only observed the issue on AQR115C. I don't have any other model
>>> to test with. Is it fine to fix it by implementing
>>> aqr115_fill_interface_modes() that would first wait for this register
>>> to return non-0 and then call aqr107_fill_interface_modes()?
>>
>> I am doing a bit more testing. We have seen a few issues with this PHY
>> driver and so I am wondering if we also need something similar for the
>> AQR113C variant too.
>>
>> Interestingly, the product brief for these PHYs [0] do show that both
>> the AQR113C and AQR115C both support 10M. So I wonder if it is our
>> ethernet controller that is not supporting 10M? I will check on this too.
>>
> 
> Oh you have an 113c? I didn't get this. Yeah, weird, all docs say it
> should support 10M. In fact all AQR PHYs should hence my initial
> change.


Yes we have an AQR113C. I agree it should support this, but for whatever 
reason this is not advertised. I do see that 10M is advertised as 
supported by the network ...

  Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                       100baseT/Half 100baseT/Full
                                       1000baseT/Full

My PC that is on the same network supports 10M, but just not this Tegra 
device. I am checking to see if this is expected for this device.

Jon

-- 
nvpublic

