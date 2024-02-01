Return-Path: <netdev+bounces-68013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A98484597E
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC761C258CE
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 14:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6445D465;
	Thu,  1 Feb 2024 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OKyikPEe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F175D461
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796065; cv=fail; b=s/rzvFGGEXMX2qW35mlvJ7b4QGd8RmSw1ffiurpw7dIKN3WpQM50YPqm0thGqiDpRtFqM1ceEz9SXzivdf4XSuIcIegB1HiM3kPkjgudQKR5aRGK9yX3b1NBjMPLHUICd4R8FfxPqKWoDqS6yfknkSXIQbJ37Vbl2gQh06JJqZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796065; c=relaxed/simple;
	bh=z2gorhJniwLL2+4pXW/Kj66HtiK+YSULah0uJDekiX4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WqQe2qW9A0g3YeHLnBZ3XrMMkbVDkN1DF/PAZLWZq/PsUeRB6avKjW7d0ukeoA4urN1G8YBvYt2cNylc2Cf80kbGB2Tmp0TOSCaeufm9D9po1zzwf4Y1UAhiJsIVAybbpY1ty74FFX+pGYfbp5+SOWAUHpukjXOkqpc915yooJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OKyikPEe; arc=fail smtp.client-ip=40.107.212.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtIeIgBJQmHebGtL4byHFXVTE2zG0v3TnE7tc6YI5YidciupJb869nAqM8f3u/dNaeOAuPyqP6hibGdCiqsv2lGDqthlZ0er+3Gyju1ld4+GlBWzsRBXX1i17EOOG6Gm+uewNVmonSSVuVT1iVah8wxdex+bRhe57F/uWMbOO2KP3vrWvSsgAMZ8kt4KICcUCO67w6i9W3IoAI1/A4lD27Re8zvpNr39QUNiR7ZTCo4IUuEqpLeW9XE58MBJsGzGLD9ypoMZEXCKV7lrZMMiFmPOoowUFk7eQa4yKMjSZmb1kpHnhZtwfslD/gdUM57xk6M9RLC+AcW7eLfaudK9Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZ5K3hCYi/EtHF27sc0goWZ/yOgGSDaqO0yNxvHPSuk=;
 b=EG7o0AF9lrV8NhmMYii6WxMzIH2A9p4pksG0LnnrRQnLkJXIAFH3wOlAzpWc8pSuwPV7mFjwPSWBCAtwY7/tJXvxThpJgP23ycM47Huh0G8PQmMhhWYU7xk4GOKrcRs7E0MWPA6zXPQxeVQDVDoQgOeLDX+V/Hw9Zonn488jtTJJqHm8ZCzUWdrM1pPWyggQtP+nUdyZJkTNbSnZEDyJfZqZImOKt72PlJvgUUo8nHK+mS7yorjz+R2CNnpIQaUltYuylaS7XRvW3CgJAm1REjBMHVApRDoBCc1vJgVYubIRN21Qzv9TzIqn+uvO/7q1JMrjO5cygkuS0FKTuCyD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZ5K3hCYi/EtHF27sc0goWZ/yOgGSDaqO0yNxvHPSuk=;
 b=OKyikPEePJZ1eN+MQ9c7h/G9VgL/A4HQAHLOgXVAn6eBXP/J+wKvzne5TIghaMfxklYFO9afyqX+9TnqLvXqUCinR4PkI2XPNztQkQ371HN30wMJOgpoGsm56LukCqi0RD8Q1+H/5EyBSmiftYjBXzZxroG1NWwvJjpeVtp/BS8NAGu4Stfcd9+DMi/AcF/jX2OBQrEeZH5ajJ6lsDZwyYMbAxz48gglENRq/0NzQTf0C4rupkn+oFMv+3nRNPuNnLcrg/LHrK+E8yiOgke15C4JBYEQohKFyUtAfH7yZmoEJQT6ZFkxzDwRy06Yk3uXRmZjziwRP0UttVUgh+WYPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8; Thu, 1 Feb
 2024 14:00:58 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::c4cb:7b15:ece2:2a3b]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::c4cb:7b15:ece2:2a3b%7]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 14:00:57 +0000
Message-ID: <82c97129-5d87-435e-b0f0-863733e16633@nvidia.com>
Date: Thu, 1 Feb 2024 06:00:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, bodong@nvidia.com,
 jiri@nvidia.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
References: <20240125045624.68689-1-witu@nvidia.com>
 <20240125223617.7298-1-witu@nvidia.com> <20240130170702.0d80e432@kernel.org>
 <748d403f-f7ca-4477-82fa-3d0addabab7d@nvidia.com>
 <20240131110649.100bfe98@kernel.org>
 <6fd1620d-d665-40f5-b67b-7a5447a71e1b@nvidia.com>
 <20240131124545.2616bdb6@kernel.org>
 <2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
 <777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
 <20240131143009.756cc25c@kernel.org>
 <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
 <20240131151726.1ddb9bc9@kernel.org>
 <6bea046d-326e-4f32-b6cb-dd92811b5fcb@intel.com>
Content-Language: en-US
From: William Tu <witu@nvidia.com>
In-Reply-To: <6bea046d-326e-4f32-b6cb-dd92811b5fcb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:303:b7::20) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|BY5PR12MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 28431444-2559-4808-dbc6-08dc232e36df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WqqlCbrnvzg9qCyd1jgLH80d46IsyNVGLptD9aQKkGGRtlOTEbJd5KT29MacRlHugB0btugO+g/khYgtJ7lovj2RdDWJPIs/BoNTP1oHqJWHS6ISOI6Gb858DTe0mOtQjFab3UbeTrsZ55TAUw6CHGm3XEpLFq5DMSMnNZh8Eg/MNxTvhZeIJ2HjxXZbn13/m8QsDSQ8eF/nt6o7GAvFFoAMK++ccdcE9Opl8RadFnY7r/R4/qhVEYVLJkFE89oqzYSseKbynClnRs1WNHXx5WtmExTbASMGM+XRKHJ+QgbIvRTdPd+7bpkVOXccA8G2M5nvPYwXTwTPDFYCS3o7ZfqGH6kXm1bobhRIIPg/srpOUhsamaFgCNWpkvDWefvK6cEWvWzW3JRpSocDJm0DmkMg6KuN+/FEUb/KSsCoTm+2kcSuBkXN/Y0UUkbbbIq5SOROby0EOoGlpXobZ4GqmEyUgEZs5urbiCAYplAvW1r42qh5EjB8kW8P3FxcdxTuOkhKZ7K2fjcYAVpeM1h0KRUq0sKth2ZiWeBGI2A/H1Ed7gXCIj4nTIEpCuvn8ajAGN/xq3GsSXMICwg7hs5TXMeznQmpD+rox2KFCE+6S9+4MJyGn2IHMOidZK3c6lSfc+vCLlYoSxQIuur2mjIkFOer+asfeh1+yp/1yeIWqwPkxG6KLrlo3w5+b/DmcXvu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(230173577357003)(230273577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(66946007)(54906003)(8936002)(4326008)(2906002)(5660300002)(31696002)(8676002)(86362001)(110136005)(66476007)(316002)(53546011)(36756003)(66556008)(38100700002)(6506007)(6666004)(478600001)(6486002)(6512007)(83380400001)(26005)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uzc3L3NhMXk4SWcybjBzNVNKRjVBTFY2MU1XS2VtTGFqUCtwUjlBMDBMb1ds?=
 =?utf-8?B?OFo2ZmJobUpYaU03bjZTMWV0MUUzMWlmNW1TeThxdm5kd3N4Q2hja01DUEJE?=
 =?utf-8?B?Z1NKc2d6eGFzTzFvSkZSTGFsYXFCamVZZGVZa2hhTGVyWVVueDJwU1ZGNlpT?=
 =?utf-8?B?NVVDcGtGTkt0SnBHUzVWMlVqeE1qaGtuVWRWTHBENG8vdWNzK0gyTzVyK0Rw?=
 =?utf-8?B?RTA0c2N5eEJUQytFaHFKQXlTZ1NFVGhNcG5LV0hWOWVMcTQ0RkRmZ1Y0QkNC?=
 =?utf-8?B?Rlk4TDVNdTdXNllKMk5SZ0RPL3dWdUNiVW45N2toRzdjbCtEbHJURWM1ci9y?=
 =?utf-8?B?QWNSakVOOFZibWNtNmRUQlJWRDN5aGJySjRldGFXb0tkd0l4VXdKSkczeDJG?=
 =?utf-8?B?ajJQdlJHMzFMQWE4elBNM09GbzZ5OW1KWmVlenRPak1KSjNMWkluQXliYnRF?=
 =?utf-8?B?R0dDMFBnK3dlaFRRTU9jMXVKcmFkamdYUmdkYU9OQThDN1lhYTlMYkRHdFQx?=
 =?utf-8?B?NE1yYktteThZMEdQa2E0RGQ5V0g4aUI3TEU3SDJhdmNDQ1pXQ2dhSHliMDhy?=
 =?utf-8?B?TlIwWU5WcVNZc3RGQTNhcTlOZ05Yem4rQWZINHhjRnJQVDVCN1ROUTNIQnVa?=
 =?utf-8?B?TFZBZTNmeUZqaFJKRnpBaUtva2dlL0tCQ2ErZkJLRUUrSkg5NlY5V0pvdWVK?=
 =?utf-8?B?akRrN3FLNFFuKzVzT3VMOEtZWFJaRjczWGk0ZFNDQUdnVzVYVDJGU3JsYmJW?=
 =?utf-8?B?SzZudGZBNjhyeFNPRjM2VjFKYUpOY0d3b3NoMjVpMTZLdGxwc2dyUUoxTVlR?=
 =?utf-8?B?elFLOFpJMkNMZGluOWErZEF0VmlxaVF4ZmprcEZYWmh5QlRIS1hySEhmS2hQ?=
 =?utf-8?B?ZitVVWtIYWhtcTJDelo1QlQrTXAwUFhTSTE1bFdlNTBSWFA3L3E0WEZKQmFj?=
 =?utf-8?B?QVVjb0xMZ2wzeEpRd0ErZHMxd2ZnVGF4cVU5UUh1N21nRjl0ektmclJPbzQ5?=
 =?utf-8?B?SGpER0djVTZJdVZKdi9VYjhVMjlDcG9KYXZiNnBkRVArMHVuS0EvcHNDVUhH?=
 =?utf-8?B?YnFqaUNDNk1FMTRFcGUzRlFUcm5hMndWWFZIYWgrT0dTVUFHZWloUVBEell3?=
 =?utf-8?B?anBZSDBheHBUU2VaV3ZKb0FJaDBCTU82S3RST3hQU2VGSEtObEhnTXkyOEJP?=
 =?utf-8?B?WXlyc2NrNUNGWmJDb1FqNmhTTFhFTzBuZlZRMCtWRjRKWHpOVEZFdzhUZmxU?=
 =?utf-8?B?TFg0ODVQR3RpS0lrY1YwWGluUkRvTkQ0S1Y5Z09PMFk4Nlp1bkNLOHRObnlr?=
 =?utf-8?B?Nk01NnRDL2F5NDB3endwOXIzQWZTeTVsQVU0SkNvQm9qWjJpbEJmRDJyWHpB?=
 =?utf-8?B?VXUzVkZVbFVqTmcrTmFtK2l0UTFmNDNjbDdMdE1xWXFxakxGbUpvL1F3QkZT?=
 =?utf-8?B?Y1NoeVk0blRCSG4vQ2hvYmZBQnQydTgrVDlGRmV6NkNMc3lac0VHcVdLZDky?=
 =?utf-8?B?MHlWWUFnZWd1akFNTlNOUmRyR0NBUnEvR0ttL01jVFY1VEk0OTZqbjlWbjJw?=
 =?utf-8?B?UjhRaEFSK2FTY29BR2pKL1J0N0huRUFXVmdiSFl3cXg3RG5EYUhra1B6UExO?=
 =?utf-8?B?bTFuZGRxRzdrdHZXYTFMNmNROEh4aWxsVWE0VE5IWElNazlyTG9pTDNBRjZo?=
 =?utf-8?B?RCs5U2ZSOUk0MTRnSzdtQVNHZUNPNElDU2hmUFFOY1Y1UkRTY1c0SWNYY1Fj?=
 =?utf-8?B?RmJqRCtrM3g4T05MYzZQaHZXUVN2NnExbHRzdDdIbjB4MUJhVmRPeFJxQml1?=
 =?utf-8?B?UDIzWGJhc3lpMGVuSnEyOVdQU1dXblNFdklQdWpDVUJQeG9PbWkrNGUraEdv?=
 =?utf-8?B?M0pyQjhBVWRJQkQ1Qk5HRjcyckhndW1abXJWNUlpMTF2aExaMGtsSEFmUjFX?=
 =?utf-8?B?bUFXVXFSdlEwWGpTaDdHVWM2RzlJaE1VUHJ3RVNtbkZsWFFaTEllZGpROEhp?=
 =?utf-8?B?MWw1SWNudjBLa09uenYxdlQyK2pLaFVBd0tUMkMwZkswYVhUVElick1hczJo?=
 =?utf-8?B?MnlJdzduYkZqK2NHR2M1ZDlFaW1NSUozTlIyWEVJVk9LU1JOd0xQa21xNS9p?=
 =?utf-8?Q?MpyMFF5rqcQ94Jq2L86TjVKwc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28431444-2559-4808-dbc6-08dc232e36df
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 14:00:57.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjfvK1/ejUvYUzHXtE8eYxTQLnsQxYtcjSxWv1rrtFYh7TBoIC0PANxbEenXj6VC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130


On 1/31/24 6:23 PM, Samudrala, Sridhar wrote:
> External email: Use caution opening links or attachments
>
>
> On 1/31/2024 5:17 PM, Jakub Kicinski wrote:
>> On Wed, 31 Jan 2024 15:02:58 -0800 William Tu wrote:
>>>> I just did a grep on METADATA_HW_PORT_MUX and assumed bnxt, ice and 
>>>> nfp
>>>> all do buffer sharing. You're saying you mux Tx queues but not Rx
>>>> queues? Or I need to actually read the code instead of grepping? :)
>>>
>>> I guess bnxt, ice, nfp are doing tx buffer sharing?
>>
>> I'm not familiar with ice. I'm 90% sure bnxt shares both Rx and Tx.
>> I'm 99.9% sure nfp does.
>
> In ice, all the VF representor netdevs share a VSI(TX/RX queues). UL/PF
> netdev has its own VSI and TX/RX queues. But there is patch from Michal
> under review that is going to simplify the design with a single VSI and
> all the VF representor netdevs and UL/PF netdev will be sharing the
> TX/RX queues in switchdev mode.
>
Thank you!

Reading the ice code, ice_eswitch_remap_rings_to_vectors(), it is 
setting up tx/rx rings for each reps.

"Each port representor will have dedicated 1 Tx/Rx ring pair, so number 
of rings pair is equal to
  number of VFs."

So after Michal's patch, representors will share TX/RX queues of uplink-pf?


> Does mlx5 has separate TX/RX queues for each of its representor netdevs?
>
Yes, in mlx5e_rep_open calls mlx5e_open_locked, which will create TX/RX 
queues like typical mlx5 device.

Each representor can set it TX/RX queues by using ethtool -L

>>
>> It'd be great if you could do the due diligence rather than guessing
>> given that you're proposing uAPI extension :(
>>
Working on it!

Thanks

William



