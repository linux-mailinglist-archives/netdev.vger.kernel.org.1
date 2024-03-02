Return-Path: <netdev+bounces-76767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F1786EDDB
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 02:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94918B22F2F
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 01:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4FF566A;
	Sat,  2 Mar 2024 01:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jISt5m+w"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CCD63D5
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342964; cv=fail; b=jX7IIwB27CvZGhBmM4HZ0POr7cLNo7xF0pR5ESmyXAHVdVhq41tG7Hee/0EdjHcGQzpOzd1zW4j4sNde8qk/9/urv/KHTbYNzpx8QUoOcVlKGh07YC0zN4ua/QddG4w/yGM3TBXvD/2ApN16YB11LR/GAKmt3IvlWkEstaJR4gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342964; c=relaxed/simple;
	bh=s8rEokW68iawkBqQwFnLKjLGSRLAK3M8ALTJIA01wbc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WNHv5BrRnMIP2UBdZMGx46qO8jiqyuqAGv7qrd7/0zcTv+PFR0dTBIO7Fr0QGC1Bid1F22V+sb5i5SxVFfuRYNzgLy/n+hfBsXkShkj5yJwzIva99t+tqVZ6ajygPjhQzdaMCbXgXUOH9YGz/lXNHD2AM1A5/WcAzJIWXJwZ498=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jISt5m+w; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMSgbryYkozJlJmLGCB+iL8khcwaK7ZUc9bF4EDgj32s/OhlATuMJ6u1naWvu+UT5WSN30sYm4Ikxs4BEPw7cOuwEnCn3ZOKUQYtyM7Kd6sGAEm2EFj5CnLrsD4USZ2Fi9PZASoKgSfERnGK7OZi9xFlXce3bXSBUwnpvbPq65LiEyDd0Wysu8iPlULvN+ba4JlHwdmvtdsWrmY9tD+XsDbkp9rsNPur/Oh4VMjtnLUv6D221sPD/QIUU0DYbPMOWCV5KFFP8EKeop2diSCLXHdXN16EJFKhdFGPJJYh6jPlB76QWmUwIWrVd43NgJc9DhZdV8NVtfarwUeeNrcUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtZeLX8VpIXULyI4w+LnPAh3/hfzlSkK932G7ZcajIc=;
 b=F0ud2Q5jso9DLVECrUprxmzPAyVfz7VhHXNNJg2e0tTC7mSbg0bQS5DbdW20QpIuiL+pp1VKIHMwcwSuV5xGxT7TsI/zJ39OWznLaFQ7c23HFmv1cyW608MnCDbbPQD3S2X1CI8CdrLVHFn8VN/xnuoA30p24IJ5kFvqXBwY2kx2gsAIrhDq3e3tIsaFzNHpKMy7sXdcooTcTD4EOCCoId5Q96uqSQIH+/clbVY2MHfuTeMlkjT77Wdl/07QvYUhK3LL8K1KyR0WYEfncvtEJnrbcYlfn+SnnTe7cNsmuT1fxRhdHi/XRPNp2HPX6Q824g2/WVYUB7Uf1dqqLU4/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtZeLX8VpIXULyI4w+LnPAh3/hfzlSkK932G7ZcajIc=;
 b=jISt5m+wU7aJOsojeheRfow6TemsQbiflDS0u8NjDHN+ZzyW8kUO6MCPeXXHNbY1239szJCo2vUtSXdJffb0ZCHUxds9mStNcFWzJnYFcqIg0anqoLt4IYewb1S921I3wLYtcwy3yw+XXE0EyLcSdQYvX9metf6pbK1ETVZsoOyHAFuC87pRWS9ff9/fAA2W9xp2Qstj/zNqGau4KXq/3sjupHJP2HMQzU1jBZtgGOj78amcMP1A2sSE4xPE0p6/vkxTfxfd4zWsp0xlE1eXif7npOYwD+jGfKQcFyTkjjUr04kfEJHGLblCUVyf2nfAq+ukOv94ouDDLXyVkqvvCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Sat, 2 Mar
 2024 01:29:17 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::b610:d12a:cca7:703c]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::b610:d12a:cca7:703c%4]) with mapi id 15.20.7316.035; Sat, 2 Mar 2024
 01:29:17 +0000
Message-ID: <a70812b5-63d4-461c-8458-b31e1ad25910@nvidia.com>
Date: Fri, 1 Mar 2024 17:29:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 iproute2-next] devlink: Add eswitch attr option for
 shared descriptors
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, jiri@nvidia.com, bodong@nvidia.com,
 tariqt@nvidia.com, yossiku@nvidia.com, kuba@kernel.org
References: <20240301020214.8122-1-witu@nvidia.com>
 <20240229193933.38e0bf32@hermes.local>
Content-Language: en-US
From: William Tu <witu@nvidia.com>
In-Reply-To: <20240229193933.38e0bf32@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:806:120::33) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 3532f493-88a7-4172-3a7f-08dc3a582d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y1mV/cxwZfdEtLUT1jKEoeMK3jGMF5+tv2/JMtmYbw5IbKQA/QuFEDPsaNtw1Skuf6hLELdbNvekWtVNLZdsguzpOGJc9cpT80jWB2p7NXJMry8aBgU7mAgpc0E/ltPxfFvdrTsMbKdtXjSlfiZ3BYgNjCOw0hQJpNUUrM/RTLDunlLQU4Y/ngF3Npf0sk+mKztOy8hnjxAfcf6XzClk1KQYkdUGec5n8JhA6hjJvdOdNsekHM9E+HKWlJU3SDW2Oq+t/xGEsw0SnkyZldOPN4ig+jmV7a+NYp4C7phEI3NX6jmp5ourPjmG6KtLBOUw8vgXN9TbCN+iiPZBBIY+H8SDJxKe1LudmB1T1nmmbc0zLDkpYtTvXaDiAH829bAu8hK3g5nRRWEp7PKu6tVv8NG61VIMUMQtGchPSqz2nBntUDorYRbUpcfIJe+AOo95oIdndvBZKcl/yLuP1+9HLc2IexC5gv7irco7NNkefEG7xBqv522zHzyLmvj+uXZePWkAZ+3H+9xLYBhE8mZ409W57RBapoQ6cMgpCwQi2TYZVZU7i9AcJPcF+yxAtDfaStFoBJTPZONC3a0RniHdwAapz3wd7yfH2hQZU7HZkIr/bqC1+LJMRlcQ5tNQ47/s5R75X2c1d0ftQEawshb4QK9ukWw8usy3cXhxOGxEHLQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGl5cXZnSHBlL3llOGF1N3E5OFozN2YzaVkzVitlZ2JxcUxhRUJFNi8rdDFW?=
 =?utf-8?B?NUhDbWdZbGRSV3RJN010dGxjOTZaRER1NzN1NHArZVc2azh2alh0WU8xNExx?=
 =?utf-8?B?bmYvOE9IWjdBVzkwVjJNd3pDeCsxU040dVlxT0VPVWhrdlg5TEU1TldCZ0VL?=
 =?utf-8?B?NElPc1YwSXJCQjFVN2h3bkd1MWJ4N1pFZ3NhSG5BN1U5bys5eURtQXRET0hI?=
 =?utf-8?B?UFJRanZvcUxvaHBOUG9LUElRVHI3Nmczc1lnd2s1Ymcxc3dYU3lWUkE1UHhj?=
 =?utf-8?B?MFVrZDdoVWI1M0N6OElZRXUxZHRnZXhVOWE1dW42RGJLRVUzVlhiS3g0VHQw?=
 =?utf-8?B?QWRWSWpUQjdmbEF4eUFTTTQwU1l2MWQ3VWNVQUtyQ1JCS25JNHhDT3NReUxH?=
 =?utf-8?B?UXdoTHd3d0xwQ3VFV0xWZzhia2NabG1GRUl0eEhLSmNlQXdlRlFOWDU2S0N2?=
 =?utf-8?B?Ym02UmNtTjVnVitNYk5SYXZwSHZnUzlWcSt2V2NvQVdGTmlYVjVRc3NiQXp2?=
 =?utf-8?B?aWIyTlZhYytYTXc0ZVowSm9lUnJZYVVLVEM4NGgvdHFwckZUQlA2VDB5K0VF?=
 =?utf-8?B?bmVLaDJ0eFZxWDdQc2x2aU1OOTZPZkdtb0xOSEFzck9Tb3h2OEVKL3RXRjVZ?=
 =?utf-8?B?K2xrTEFqeHB3Y1d1b0ZmUTdad2ZMU2JxcEpGa1VrMUxCb1hIQkhTc1ltYzBN?=
 =?utf-8?B?M1NCVDZmWitNcmFUOVZ2QWtmRVdqVHhDYXFrdlE1b3gzUVFuRXR5QS8vZkZX?=
 =?utf-8?B?Y0NMNmhkdis5a1FsUWlLdUd4Sndua0VWSkVmbHpTOHF6b1BlaVM2TVpkZ3ly?=
 =?utf-8?B?K3c2eVQvOGc1blNqWENPMk9rS1BJVEdTd0NGbEpWM0p0ZmgyRHV0eUsrcWd2?=
 =?utf-8?B?WUdFZVFaRWc4dEkzb3BseWY2WTRzQmJTWUJyYzB4eDg5ZjhmaUpScXhWWktx?=
 =?utf-8?B?b1p0cVhjRmFKUHU2MTQwcHMyV01NNG5NazFPc1BnbzIrN2JoZ0RJYmwvQUdN?=
 =?utf-8?B?alYzSEJ3bExtdDgyT1lhR1VoUHU1aGVjSkFEZytUZjJKYm1pdTFvQlp6dXZK?=
 =?utf-8?B?bEZCaUZ5b05pWHZtOHp6Vkk5Mm1wUzVMTHdZaGQ3MW5GNHRuemtwZHVpaGNJ?=
 =?utf-8?B?VnBZYWJNbHlNWHRpWS9qZzRxc2hKc0RLN3cyZE9UL015bS9NdGs5VFdHN2M5?=
 =?utf-8?B?dGU0RDFKemFuQ3owY0dwVFU5ck4rMmdYeWljZHdXVnR1bkRxYUdWbVJYcDhs?=
 =?utf-8?B?QjVaK3ltTXM5VE9UMFNIU2tsWFBhRU1FQlZwdVl2d3hFa2VJcEJseWMzbjdz?=
 =?utf-8?B?N3NDYUZzRVc4ejc4dGJIUGs0L3RscU1Eb0pmdmh2a2VPWS9iMk4wOEFQSTQ1?=
 =?utf-8?B?N1NQR1NqazZEd2prd2tCYnc4Ym11akNnVU43U0xPL2t3aG1leWFlaG5STDdM?=
 =?utf-8?B?bklPY3NrVmppbUZvRlBST1d2Zkc0bXM4bkdRdHlCekFDYnQ5ZzhBSkJ6dDdP?=
 =?utf-8?B?MS94OUQ0K1p1WTg1SzhLSGw0emtpWHg2T3o4K1lGOUg3NXkwRWczaVZWbkVD?=
 =?utf-8?B?RXVPYnRlNmh2OVNTbjJWRUxOTk9vQm9EZUx0TGNHaW1EdXRuOWhUV0dWS0c2?=
 =?utf-8?B?dVE1Rzhpbm5tcURMZ3pkWUp5QjBkWmEyb0I4eWxoc2RWb1QwK2c3aktPWVo4?=
 =?utf-8?B?Z2swRE1UalFWaHlSRmM4dWpZNnZYaHhYZjhvY01ydC9zZnBjQVhleEl4a1BM?=
 =?utf-8?B?ZngxTXppQVVmMTBQWmwrbE5RcU1obWdCV09wNHRYWCtNczUvRUlqTjZSMHdo?=
 =?utf-8?B?Ty9LR3BETXRUMS9OMDUxZ1ZKbEhCdVJGLzJhakZvcG8yZmUwQW4rbVBLU3Zn?=
 =?utf-8?B?SHo3V1BabkxZSElMYlRlRFlTaFFockNpYWtVcDJYRXlKbjRNTW5CR1FBMFlr?=
 =?utf-8?B?ZkhJY2M0eEM2R2cwUm4xOUdqMHRSVk05SXFLSDk0YmJvc2ZzRWpaVUVLRlRD?=
 =?utf-8?B?b3BDSTV6QnpGTnVxcXNkTU9DQVZmMlpQbFQxNXBlMEdlaFYrMWpEZi9NM3B2?=
 =?utf-8?B?bUNub1N5YWZEcVJXbi9FWFVlMnZ4SHBkWEplMnNvTzFPRjNaWXdoV0QvMFA4?=
 =?utf-8?Q?/R97MkqPuRfXos/epp8HJZkFy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3532f493-88a7-4172-3a7f-08dc3a582d7c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2024 01:29:17.5835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAhUn9TmeY8NiHSzZKLeHbl472xq1lXMW+WXZyZbPIdh18rmVgSf17amXpCsBPRz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833



On 2/29/24 7:39 PM, Stephen Hemminger wrote:
> External email: Use caution opening links or attachments
>
>
> On Fri, 1 Mar 2024 04:02:14 +0200
> William Tu <witu@nvidia.com> wrote:
>
>> +             } else if ((dl_argv_match(dl, "shrdesc-mode")) &&
> So devlink has its own match problem.
>
> We stopped allowing new match arguments because they create
> ordering conflicts. For example in your new code if "shrdesc" is
> passed it matches the mode field.
Hi Stephen,

Thanks! in this case how do I introduce new argments?

Should I introduce dl_argv_exact_match like below, or should I handle it 
specifically in "cmd_dev_eswitch_set(struct dl *dl)".
Thanks
William

diff --git a/devlink/devlink.c b/devlink/devlink.c
index affc29eb7cad..1521c2c24acf 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -466,6 +466,14 @@ static bool dl_argv_match(struct dl *dl, const char 
*pattern)
         return strcmpx(dl_argv(dl), pattern) == 0;
  }

+static bool dl_argv_exact_match(struct dl *dl, const char *pattern)
+{
+       if (dl_argc(dl) == 0 || strlen(dl_argv(dl)) != strlen(pattern))
+               return false;
+
+       return strcmpx(dl_argv(dl), pattern) == 0;
+}
+
  static bool dl_no_arg(struct dl *dl)
  {
         return dl_argc(dl) == 0;
@@ -1921,7 +1929,7 @@ static int dl_argv_parse(struct dl *dl, uint64_t 
o_required,
                         if (err)
                                 return err;
                         o_found |= DL_OPT_ESWITCH_ENCAP_MODE;
-               } else if ((dl_argv_match(dl, "shrdesc-mode")) &&
+               } else if ((dl_argv_exact_match(dl, "shrdesc-mode")) &&
                            (o_all & DL_OPT_ESWITCH_SHRDESC_MODE)) {
                         const char *typestr;

@@ -1934,7 +1942,7 @@ static int dl_argv_parse(struct dl *dl, uint64_t 
o_required,
                         if (err)
                                 return err;
                         o_found |= DL_OPT_ESWITCH_SHRDESC_MODE;
-               } else if (dl_argv_match(dl, "shrdesc-count") &&
+               } else if (dl_argv_exact_match(dl, "shrdesc-count") &&
                            (o_all & DL_OPT_ESWITCH_SHRDESC_COUNT)) {
                         dl_arg_inc(dl);
                         err = dl_argv_uint32_t(dl, 
&opts->eswitch_shrdesc_count);


