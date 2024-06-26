Return-Path: <netdev+bounces-107021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE4C9189E8
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 19:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30E5282B8A
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF2918FDB0;
	Wed, 26 Jun 2024 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="3FxJpaIW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2103.outbound.protection.outlook.com [40.107.236.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166F913AA4C;
	Wed, 26 Jun 2024 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422078; cv=fail; b=rDP7JiNzxPBuRV0+fVuj7WdvkwbcWdIjPLjZkV5FC5rjBpp2RFUaxoYxdVbwHteKWXq2fpi46JRXzyHdw0oM8ZjbBNpp3nxaJlsz0ab2I+VSE8fLYG7Ccza9N+f9BhbWQc2av7J1RP+P88nV2LlulNJTvwcjjCtJnQK+z1FrZeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422078; c=relaxed/simple;
	bh=Mz4RNc+HORr6K/ogTdMR8O2E0EBHKBDKWlXP+Md0k+0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bUHCfhId5JX26ItVLjzyozcBuPXhU6pt3IVVvthrbr6NEzPS1PhezBpOzUFrX7W0FJKriQtIbweqGzuF9spAyK9fzsJ3ejlUDIWUYZoiUhcieXB7RsybORBEx2OzPfGI1NNQu3kuVeJPxdIBGDXHH4NMR8bZMccZ4cWOxlC/7xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=3FxJpaIW reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.236.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgHRS4RRKpZzfQyxlUplGkFrhf0JM/c3cD2IFGz+L+2NGivJyoXXEgREAGUE/zFZ5Y6CjeKadq5wf7YyAvKmM2wwlSDRSXIr9irWLN35Wag6n9zGZU1nHpJp5Yo8dZeTKVNSSz+4BdUfdpxs8BFMGB4r1516DopxdiL+Ujt7L0gy5NOTW3QRj5wQwqjrLjy7YYh6tJZ42d/6s++2MXilrOCJBbuDT4N4p0xrR+qhrRaPWIkPYpzi66J6ekb5xP3L9KPDUrBeZ+lwFmksN/Pj70EIOH17xYDQ/MmL/jjKzV4BsIrbdWWkt8NAhLAgSJzBAXDBn3qXQfUS7dNQh28fmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psrsuEk+dTj9xErDEbmQnfMgaGQjLFmMCTmPVLm52Ro=;
 b=en79wjk8I/I3ORFC+DhXwGFXqw7PVDcLx6UzV6EKBxNp2u4lTYLcCQsJKnqYJKnFpho7Kps4hjTELkvjhVjo6RHpRmabtDW8h6VCBnErVNric/E7/zVb9pBi+STa5BeW2rFHQnlEUiFGOIkF7oKwx8BVsY02isiW3GXoG1HDE6m9PtNHDIYJW4dKfC/xWFQoLJsF1f4VCiXgJLYFbYOt/O0F3SlDmAgxc5YpSZ0ZnfqhK/m4pQnmdPZuOYptb0EMXbDbtor4/GBYoKE0kuGEvBySwoAfBIezI8UpakvgmkEFLKm7D6cQdy7bxMfvGH9HZw2YuJ1oWOD+4vriVsK/kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psrsuEk+dTj9xErDEbmQnfMgaGQjLFmMCTmPVLm52Ro=;
 b=3FxJpaIW5MeClt4xjBSj66Tmr9NjlXiz/oWFBd6KbDJF2mLAL3kcWeCdVUC/FMekWOhWxgec1BBgGH6EEDAUyDHoSHPc9hr0m+ATCX0AqjxfQnkRzWOTzfMHYQqhxFZPWuYSL1Kl/3YjRL5xm1uKi/giQdCtjGWUGG/YT/LlEoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 LV8PR01MB8552.prod.exchangelabs.com (2603:10b6:408:185::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Wed, 26 Jun 2024 17:14:32 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.7698.033; Wed, 26 Jun 2024
 17:14:31 +0000
Message-ID: <e97ca7dd-8ab6-4313-93cd-62e075f4b6c7@amperemail.onmicrosoft.com>
Date: Wed, 26 Jun 2024 13:14:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mctp pcc: Check before sending MCTP PCC response
 ACK
To: Sudeep Holla <sudeep.holla@arm.com>, admiyo@os.amperecomputing.com
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240625185333.23211-1-admiyo@os.amperecomputing.com>
 <20240625185333.23211-2-admiyo@os.amperecomputing.com>
 <ZnwJH5lJpefkzaWg@bogus>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <ZnwJH5lJpefkzaWg@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0149.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::34) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|LV8PR01MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a85cf51-ec53-4454-014b-08dc960371b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|1800799022|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTdVMjMrMVNmSSt3bEpJTUt6L2REakhTbmpzSmRlRDB1YmtQRGFjRittbGRP?=
 =?utf-8?B?WVgxcXJNa2VFWjI2UWs3a3NBVjBjN3ZTMG15MGVSRkVzeCszMk44ajhrTklp?=
 =?utf-8?B?VTRkQnZndzFIdmtaQmhabU1TR2FNM3p6VkdINnZCUHRST0JhbndjbTQzMXgz?=
 =?utf-8?B?Z1JZT2dIcGJJOXBzY3pFZC9oM0ZUeVhrRElSUDJlTGxKd3ZYQS9TYWFyOVdv?=
 =?utf-8?B?SGVLK1NucEo1bTkxNXNsdzZXVVVpTHpHSHRHNHFZSVo5blV0UkxCeTNZVmhl?=
 =?utf-8?B?RHlsNnZEcVZJMWc3S0M2NUZQazBGSkdvbzJPTWtzYmZMMm1yV21xMEl1bWRU?=
 =?utf-8?B?SitDTklxbDhTR3pZUmhaK2hsa05IT3N6SFMyZ3U0ci9OYVBkRk51QVJpM2ZT?=
 =?utf-8?B?RVBSU2wrOEw3K2RHK3hXY2xwU2ZNQ1p5YVNoQ09NUVIvb1cxbTFLQnZEbkg5?=
 =?utf-8?B?b1FpWHhPd2hueVBMTU1CeGFmbnJySWdwSnZqMTZTaUZXNkROYVdlYS9mbndu?=
 =?utf-8?B?MFUxbTFwd3lTTlF2T25FUjJZYktkbllnNVltdWtWam84WU51SlErbndxSThT?=
 =?utf-8?B?SDlrMXh4Wk9SWGJjQ2sxZFgvc3hnTFgvbWM0NzR1cEllOTNQdW5SRkUyaGow?=
 =?utf-8?B?TnQ2cnBoVEFvdnNOOTZpdVhiM2pwaUt0NHZielZZU0xGdkZBNDlzU3lKUVZ3?=
 =?utf-8?B?TjFyM0pFZ1RseVBpRmtkdHR2U0l3NU5pLy9GVGtYZlhmYXVhZ1MvTUQxV3Ev?=
 =?utf-8?B?d1F3cUtWNSt4MW1HUnV3Z0hVL3hVRmFaODRyWDFtRzBZNTVTMzRDbTFuTDFp?=
 =?utf-8?B?RS9PUGNxNndZT2RTc1BHbE5BTzA1MXJTSXZ1S2ZrOC90ZnREY2RDTFB6YzFC?=
 =?utf-8?B?OGVRZWJUK0d2b2pPS3F0MVFUQnlNOVVXRXRPVGswY3ZabUZSVHR1c3BPVG5z?=
 =?utf-8?B?Sk13bExVVlNISWp1TkJZOGhleWhwTnNVMWdjcllIZ1NpTktkK0hONmRFc1ZN?=
 =?utf-8?B?enNlaXY3SWtabnA0QUpOZmpyM2hWcmpBMDRsSHVuMjBZMDNGaWRxU1o4dUJw?=
 =?utf-8?B?eUpZMUdkTlNCdGxGVmFEbmpoMVdNSjUyQnBKNy82NjVLTUJSaTUwQ0ZTakt3?=
 =?utf-8?B?RW1OY2M4NkVBRGxKSDlJd1Z3OVdEWW9kRUQ3ZEZnMW0xeXhzY1U0NkswTkZs?=
 =?utf-8?B?V1J2VGxHM1ErM3l1NVpEZEI2L3hENHR3Nm8wcnRjTXBsWlNCamhjM3VXUmtR?=
 =?utf-8?B?dWJUa3lsTmtnKzU5clkzUHRFQ2p0MU54Y2FpVGF5bks4dXRvWk9iYlN5OEZq?=
 =?utf-8?B?Z0ZoaTVsb0RpVHFwZWJzTnVzRnFleVJONUJhamdKc1BYVVd6YUJPaHczUzMr?=
 =?utf-8?B?TG5INkY2STBGUFJlUnJMTWRUOW16UGxDY0hScGRkdXVINi84TVBzR0w0eGxU?=
 =?utf-8?B?YjlocjdubGVoZTJKVjI2S09ka0NSdXR0Z0hXbXZyM1JXVkpXRDF0V3dUa3BL?=
 =?utf-8?B?MW9yamV0UXZkQm1ydnNHKzNzWFFoeElWWEJJTmUxbWp2WHFPaDBPYWhvMTRY?=
 =?utf-8?B?SndNVG5VejUwcCsyT2R3WG1SSFFPV3Ivem5JendDVTRuMUNGMkhQbzdaVVdT?=
 =?utf-8?B?WGZRMHF4eERnWUFTWCswNThYTjlDMTFuSlRYTXI0MENhZVRnWEJZekxnZTd4?=
 =?utf-8?B?OEZ0YjNzK1hNcWhkMm1MS2RFd3JzR1VYa1BtY3JyV0g0OVpFbll4THlQaVN0?=
 =?utf-8?Q?SnM7a1nvGudqtV9ba4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(7416012)(376012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3BCZldwV3FUWnlUNVNyS1FQeEdjM0RnM0dLUVorUTRZQ2JORnhlakFGQkNv?=
 =?utf-8?B?OHhqL1V0eEE0bE52cVZ5U25WcHlvMHpudytTVzBGZXVXaHlhMUdaZ2tNYk1o?=
 =?utf-8?B?aCsvT2VKNlcxbldYL3VKS3I2MmtoTCtUdVNOY29SSXducjZzODlSbzhNTUJz?=
 =?utf-8?B?ZWJrMFFBb0oyQitvczNsU1lScU5hU3JsRXYrYU44cGNBb25WZEYxbXpZMW9U?=
 =?utf-8?B?RHdQaURFWDF6SFZwSitVeCtSVTBmS1VFVHEyWGsrNHZzcnkzRUhzWDFrOEhP?=
 =?utf-8?B?WVpMcEJmcFNDV2owN28zQ2VRWThqT3dDVUZDRDJwd2NPUVpQMlF2cFJmakd2?=
 =?utf-8?B?RnI5TTVKTnVnbndDNks1SlhqTGI0cGVRUjR0cy9Hc1E4NGxiYU9RYk5lNHUx?=
 =?utf-8?B?cDJjdTlrWTlmZVpZM3hKZlIzaXozNnFvWHV1dnoxWXA0WEkzKzljVG9oREJt?=
 =?utf-8?B?cDJVSXBtSlZLdlZnK21hdkJaK3lERk5Bek54a0NZcU1HUXVsaE4rWkpSSito?=
 =?utf-8?B?emtlY0dzWHRVaGp6bnJnYWc2M3J2SDk0S1I0Y0g2a3RnbVlhK0lnY0tORnY1?=
 =?utf-8?B?M2tTNTFBcVdHdzJZTERUc1dzUlpFc1RZRUFCZXd4aHczbFNjVWFCNmtpRHlo?=
 =?utf-8?B?Zzl6UGZEZStBN1dJQ3p4cEREbEhwYjdwTFFxN21sU1p6LzhsY1oxZDdwR0xr?=
 =?utf-8?B?dFdpMldXNWtBemxhRzkzdE96WEdMMnRqRCtYZ1hWaG5DaThKRE5tUU0rQkpH?=
 =?utf-8?B?clhlaFhkVGY5RysyZkphb2kyYWFWV0pkZVpqM3lzZ3BBOFAvYTdyclgvbzFS?=
 =?utf-8?B?R3FkU2Z6a3JISmpRQVl1eEV3V0FNcUFSUnJBZXhKNkFSdjdnLzFvME1CNFhj?=
 =?utf-8?B?b2Q1V1d0SHVZeEN3Tk1LMkQwTCt5YmxVU283SXMvVm44SUpXZThFTFhvc0p5?=
 =?utf-8?B?UUhBckxaczQwT1VMRmZtWTdRcnFUaVJxR0xQdzRDUmcrajRmNXFJcDdZbllY?=
 =?utf-8?B?TTBvdFd5U0w5Nk5qRG9OQ3cyNXhINElYalVtOEkycmwyNlRsajd6b09MRUx6?=
 =?utf-8?B?dloyNkhCR0F1anNKcSs5N1g0QU52eWYvMXJoanVOMVhaTys1ay9uMldMdHRv?=
 =?utf-8?B?NURmQjVWTS9kR0Y4V2V6U2ExVEhUWERFVE9wVW84eEMvdk1ZNDVCb005ZEw1?=
 =?utf-8?B?MkpwN2xIVHBrdWhzZ2JyejhjSkR4TnZKUW4wM201MmU5TVhpaEJKeERSMnFT?=
 =?utf-8?B?VU85N1V6dDlCdFdMUGZseCtwN3VZWFR2MDRPMzFuQUZNN0NrRzd4S3VXTktD?=
 =?utf-8?B?dUJRY0pteUxEN1d5ZDk5OXVIVC9ReEdDNzR4OVJrWEJCdEEwQkhsM1BiS3d0?=
 =?utf-8?B?amYxemNSK0lYNUpTdzdIWms5ejluckw5ZUJCY2kxQWtBYlZSWHdEUHUwRnFI?=
 =?utf-8?B?bUtjTUt2WmdyYnJpaEZzNGU2WjM0TndsOWRuQlV6QlJ3bkZqTm4yamlpTDRL?=
 =?utf-8?B?SWVsc1BiM0lUWEV4emhRS1hpOGQ5S3VIWHlWUmh1MlZ5OEQ0c25JOVNoTE9B?=
 =?utf-8?B?S3pvcm1abGJ2cEJTN1RkMEEzQ01hakU3QXhST0x6NituMm51SjRUdjEwN0ho?=
 =?utf-8?B?azRkMTA2Z3ptUzlvd0tFWEE0b0VFL0ppdDcvVFdMa3NBRzZySGpxNE45TmRC?=
 =?utf-8?B?RVZVOTlXd1BpcGErSWZ5RlJ6OURhOVFsUFdheTZGUlJPT1NlZmhHUXZlejdW?=
 =?utf-8?B?bEZyWUJUQnpTZlZqbFQwUVltYTY1WlBEamhBcnA2R1htK3RpOUFUbUhTY3hC?=
 =?utf-8?B?NHhEZWhFZThGUUFoY1hzZnIvNkJ1L0JxOE1aaFNjUGdxSXJBaXlYN3Rub2ll?=
 =?utf-8?B?NFA4dGY3L1NZY1EwYXViVGpub0duNDJFNk4xOWoyK3N0d3FOQmQwbC9kc3M3?=
 =?utf-8?B?MHpibTA5SGlxV2h2WS9xSC9KQlIyc3ZFNGNEaWtaa3M4WTArNFRxeVVnSmZz?=
 =?utf-8?B?RjIxbmpkN1Evd0xRL09Ya1hKSUhicjdPczZoNkErWUdoQ0l6U2MyQ1RuWFM5?=
 =?utf-8?B?WG1ZOEdHcTQzMzBlT2dGb2xhTjN5aWJublVQVVROL0xnM3FQNHFFa3IzbExT?=
 =?utf-8?B?TE5jQUNpZHpLR0p4aTJ3NEtGdFJEU0NmQktRVWNFNm5XWXAwa3hLeHBkd3RN?=
 =?utf-8?B?T2tCY3VuajdGc1ZGNVFCSi92R2RrcGQzVUprQ28zYlFQUS83a2JHY214UFJn?=
 =?utf-8?Q?U/wwjx73YoDZXula/gpPzsoClZCWslngIIbkSXjaq0=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a85cf51-ec53-4454-014b-08dc960371b6
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 17:14:31.7697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGomIxfm/ou/nh4iKT7Tbr40qMuTbRgHOd48Rkwsit97Gvt10MgY446mQwuyOT1/Vf14du/tu4mspLyGJbranvY78SI+jM2T92oo1UpWErutm8CLVS8+SjocnJZV1u3L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB8552


On 6/26/24 08:27, Sudeep Holla wrote:
> On Tue, Jun 25, 2024 at 02:53:31PM -0400, admiyo@os.amperecomputing.com wrote:
>> From: Adam Young <admiyo@amperecomputing.com>
>>
>> Type 4 PCC channels have an option to send back a response
>> to the platform when they are done processing the request.
>> The flag to indicate whether or not to respond is inside
>> the message body, and thus is not available to the pcc
>> mailbox.  Since only one message can be processed at once per
>> channel, the value of this flag is checked during message processing
>> and passed back via the channels global structure.
>>
>> Ideally, the mailbox callback function would return a value
>> indicating whether the message requires an ACK, but that
>> would be a change to the mailbox API.  That would involve
>> some change to all (about 12) of the mailbox based drivers,
>> and the majority of them would not need to know about the
>> ACK call.
>>
> Next time when you post new series, I prefer to be cc-ed in all the patches.

I was using the list of maintainers for each patch as pulled via the 
Kernel scripts in git send-email for the first two versions.

I have started hard coding the list of CCers as a superset of all the 
maintainers, as this patch series crosses a few boundaries.


> So far I ignored v1 and v2 thinking it has landed in my mbox my mistake and
> deleted them. But just checked the series on lore, sorry for that.
>
>> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
>> ---
>>   drivers/mailbox/pcc.c | 6 +++++-
>>   include/acpi/pcc.h    | 1 +
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>> index 94885e411085..5cf792700d79 100644
>> --- a/drivers/mailbox/pcc.c
>> +++ b/drivers/mailbox/pcc.c
>> @@ -280,6 +280,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>   {
>>   	struct pcc_chan_info *pchan;
>>   	struct mbox_chan *chan = p;
>> +	struct pcc_mbox_chan *pmchan;
>>   	u64 val;
>>   	int ret;
>>   
>> @@ -304,6 +305,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>   	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
>>   		return IRQ_NONE;
>>   
>> +	pmchan = &pchan->chan;
>> +	pmchan->ack_rx = true;  //TODO default to False
> Indeed, default must be false. You need to do this conditionally at runtime
> otherwise I see no need for this patch as it doesn't change anything as it
> stands. It needs to be fixed to get this change merged.
>
> Also we should set any such flag once at the boot, IRQ handler is not
> the right place for sure.

Ringing the doorbell to signify that the message is received is optional 
in the ACPI/PCC spec but was hard coded to always get set.

There is currently no way to pass the value from the rx function to here 
where the code is actually triggering the response.  The Mailbox receive 
callback returns void.  Changing that would require changing every 
module that uses the mailbox code.

You can see the spec here:

https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html#platform-notification-for-slave-pcc-subspaces-type-4

note in step 2 of the  send process, the part that says "The platform 
can request the OSPM rings the doorbell once it has completed processing 
the notification command by setting the Generate Signal bit in the flags."

The change that made the response mandatory was 60c40b06fa686 and merged 
in the 6.9 timeframe.

The actual check is done at run time, and you can see how it is done in 
the third patch, at the end of the  function mctp_pcc_client_rx_callback

+       flags = mctp_pcc_hdr.flags;
+       mctp_pcc_dev->in_chan->ack_rx = (flags & PCC_ACK_FLAG_MASK) > 0;

While we don't anticipate our backend requiring the ACK, we did encode 
the possibility into the driver.

I am willing to rework this if we have a viable alternative.










>

