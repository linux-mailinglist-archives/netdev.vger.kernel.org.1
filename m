Return-Path: <netdev+bounces-86717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E53D8A0096
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 21:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4611A2860AE
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 19:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30AE181311;
	Wed, 10 Apr 2024 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M//6OrKt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E177181304
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712777403; cv=fail; b=XGqMYQUymwdSgzcy3zpvRE2iRnxt9b0OO4ey3AG7DmnNboYlYpBDGwfiIXHcCWzFs7ZDnlbgTBId7JvcFVagPsEi3QcV/Pu/SR9ZlVDR6zjXncNdVunRNtL35ImgxZPsZnAMZ5zj/Ha5HScrDMQNVyrJJzgF7avYqRjALY28q4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712777403; c=relaxed/simple;
	bh=BTkUrVLASfF375Vq1xjB2byo143HBiA9w9FNC2Ywa4o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IVHfRaSCRa10e9JtViHpqoNp3HhpX/NG42hBCKJ4eZs+7ighO0Msa4xLUzD5Qk2zMjCme9IesSDHX5UcIWC+A4XtXs+WxM41aD1tQ21nM8pvXTOVE78uX2Jrmx6c+EMl4AbMKVO24vLr4/Y885QQV3kyYDntbPuzIRoqjJB2Pfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M//6OrKt; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712777402; x=1744313402;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BTkUrVLASfF375Vq1xjB2byo143HBiA9w9FNC2Ywa4o=;
  b=M//6OrKt4d5igFKY7E6B+wT6VYIMT+xxXXMITm+6T4KwQByNnYhkkDhC
   5jyslLonNLgJQof+jhRW/AqZtJoniSLt4cadBjMsQ7YlWEjXkIYcxjjuh
   pov7suD1TybKh2zpmx7LLkFYTXykRrh9u96DOkM0unl5ZJwZ3eTl1Hxz+
   1gjIwKR1fLNLrTR8DLSrjxPtdf9HFZLhbeAEK2U2aK18iyTzPo2TXdfG1
   T0SYmt6WjTVFtMDg7+U02T15jhrHRp2y6+EDp9tADKPRaLY1yvhSJ8Kgu
   fjpX4Py8WKePiCTWStY47Csb/WDkRNWM0FpK15vfB2FBvJie4Buq3Zpb1
   g==;
X-CSE-ConnectionGUID: 0c2hp5HiRHy6jWkhv/elXQ==
X-CSE-MsgGUID: g4zCyaOaTV+PThtJtCckeg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11944325"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="11944325"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 12:30:01 -0700
X-CSE-ConnectionGUID: QUr42sQST9KcETkuV869IA==
X-CSE-MsgGUID: T19WzssMSxulbyPV23hgHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="43936364"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 12:30:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 12:30:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 12:29:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 12:29:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 12:29:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4bLu8rIUlBWY/4pUz26LWyjc0+YB4NpNTHR1yj8SSGG04zgcwOOPOv0YeNQqexoUnPu81qKtMsZPMilQlwvKxJXfu6Xs22+iUtCsA6Yxl5Yp8w1bkLENSPpiE0NgwZHBESy4jXo9x25ei9UUENBBY4XbvXvB+sKXmVUHy5Miys4VMHGXawjhn0tKAp3S12U4rK4BBEHZPW+OzyUBUcWpDlJSY/XWJIgSOB4TgnFgQ5xSaEwTD3A2AFkprfMhnN8ZoyGOyyMq1dcDus6dmPaT0U/dZOhR24pug5rwqjhXHBLS43a0C+nXClNdKRIhjSEXGpulHq5uKRxtUH96r6I8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJ2zxQEx9PvyWdz5vOZs7KhpuR289T0vVgBjcG6ROUk=;
 b=YeKsypWa8toON7pJBZdslZ7H+OjRww8WpPDYI3qASaej3Fv0boZk4gE75aJsUtTGJm41a/uqsh8GbxupKYHkbOmrEMLwxqfYgeUvHqE5scKrGHGxeO0tm3oKulL06GVFrIPEOrVtBWjtYMPG4x6ZvdmN6+Q3NlO+yyphDhA7gdc/0hVCviyacFajEF3W0/+O9YAfUXWS1Zk52Sg5a9dxNsTgSxoNJwvJdHrWJN9wrGiGgiv+CPbjSHTxDhlXJqUxmEFqCiOvGw05ThAS3G0hlSXZrRNPAxOu15NchkSk49DpkxyDrkYRa0lQdxBiZj2hlSBi5AtW/nZLZ1JO6G9pWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB4954.namprd11.prod.outlook.com (2603:10b6:806:11b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 19:29:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 19:29:56 +0000
Message-ID: <57833e6a-7d28-49de-bdc2-4e4c75ccc163@intel.com>
Date: Wed, 10 Apr 2024 12:29:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/7] bnxt_en: Skip ethtool RSS context
 configuration in ifdown state
To: Michael Chan <michael.chan@broadcom.com>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, Kalesh AP
	<kalesh-anakkur.purayil@broadcom.com>, Somnath Kotur
	<somnath.kotur@broadcom.com>
References: <20240409215431.41424-1-michael.chan@broadcom.com>
 <20240409215431.41424-2-michael.chan@broadcom.com>
 <721f07ab-4dc1-4802-957d-1e71524ac31a@intel.com>
 <CACKFLi=8wuyNxkmVYQjb2O2Vsb74zVc3QmDVZ9hchdDedY0gMA@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CACKFLi=8wuyNxkmVYQjb2O2Vsb74zVc3QmDVZ9hchdDedY0gMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:303:16d::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB4954:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ea0cOjm+Up0UvxKy8HgViz+dmUnS/MHT0fY/CVfKfNw9xpPKufKf4sS8AFBgQnI/sxvoJZPvg1GMnYI8eH3AkuxneGqQjycqmf3wyaN7e9+8jb1LqCQsCBlDC+gEzvWu8GIbP6Z6fX1E0o8cwFgTIUKkAfsTDfgk3TpS57IqDoZfq7Wop6ufA/4hdZu2hsU5IM+sMFg9K/A5InwhVW+xhzdZUPEQN0g3+ZLj/aZWgTbEAUNK0LGW8DI+yTNacVePtL1ljri+sO8nWVMYBRtE2ZS03Z/o2Iaa/4wxDPpxiDSlJvlHPhoFZQ9a/9EIaAsgyHzSLbKbkjYyxj7oqbQtz8uZtwato6QkHuKDr3CYJDBXqKVrpsAxs8MiabJERucXXbyuvLzq6wRXYhj9kDZCx1/2V/WdhsGjPOjSVbTFEr/CNjyuZt5kna++pks9w630Jn+tvqj39hE2rgHTnPGZn2/N6zpWHK25sfqbkV2lK81StT/ORR2TCcmnVdMYGD0G76aA029MsCz0i4/W4925BYHU2UK4llCIU+a/oJqplzSsDlLyvrGihMWw706C6OOQRPlT0KWHFib9dHqIkX+SiX6wx/OfTBVhkmtHDPfeklgiP6OOS0yzgHD5xk6swjqjganchZJvcEIObNAmWxxtPeibB+pLILiXD7XfZ4awFyw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0J3MG1XSXk3czJERWR2ODhFN3g1R3MzWis5dDZZTVM2b1ZCbTZwSmVSNDhi?=
 =?utf-8?B?R2JleGcxRG90NFBNc1FmOEVBRDkxdkUyVXUwVjIxQ2pTNWRqYU1BTThSRVFr?=
 =?utf-8?B?eHUwemZXWXlaUmhjbFh4WktKVCtQNTUvUTQwR0l1NGxTVnZqN3h2OHBDemdG?=
 =?utf-8?B?ZFZJZnIrTHpxSHJ6eDNBcGdpSGVWajRBVHZpbFdiZWxtY09JL2YwSUxEV0VQ?=
 =?utf-8?B?TDhDdHFqWTNYQ1RobzlibDU0LzhVTml3OVFseVpxL0JIc1dxYlVpWXRHWktQ?=
 =?utf-8?B?d2NTYTZUWE93ZHgyQ204TFNabjgyOTNIV1IwUzlUVEI0TnZQZWIxWVBLQnQw?=
 =?utf-8?B?cGdaNGQrRmswSUYzVlBVUzVQS1VrYnFRRTVlVFZSUXVtOHF2djVydElQd2cz?=
 =?utf-8?B?UTVKRnhhbndjRkJxRTVxMWtvMm9BWG9RaHNPY0hTekVZMDFOVjQ2RmxNRXVk?=
 =?utf-8?B?bHpLYy81TmJRU0VTazJSQk9Pby9BaFdsRGlkQ3drVGlpZXhDalhXY0krMlpk?=
 =?utf-8?B?dzEvOTRqUWJNSS9QcXlPbzE5MVFSSFpSVGFkenBXdUpDV0pmQy92OTNCSHlq?=
 =?utf-8?B?NGpKcFlFV29CbnNVMWorQzRHTEdHbTd2Mjc5MHMyZkJFTE5jcndLWjJyNDdO?=
 =?utf-8?B?V0ZadXlTY3FMZHRjd3FvYUlyc2FSeVI2cC9GQlBGNmNCTE9odjFWRnE1ak5n?=
 =?utf-8?B?NWpmMHpaV01odEM2eThFREplSjAxNmkxdmhjSW1Wc0swT3RkOFdoeFRCQ3BV?=
 =?utf-8?B?YktGN3JGVC9wSVZrVWJtaDZoZlFXVVQzSHA3WG9EWnVvTTNCZGMrazNNYmt1?=
 =?utf-8?B?SE5SbUNLM2t3UmYxZkoxZlNYek1pVXZtdGs4WGVFaWU1Qkg1TFJPcFV6aXVB?=
 =?utf-8?B?aDU2RWpFazM3KzVrV01mSDRHS0hwNTgyTXdJdm00SnZaS05PVFBIbDROKzBo?=
 =?utf-8?B?UlJwcnpKbCtNRWxLdWQ3dmI1Y01aZXAwZlRHakFwZkkxbEFTdlVWSmNzNjZ5?=
 =?utf-8?B?MzhQaXhBaHpGb0JHVG53WGkrNEhPOXFYSWVnUjYwOENZbGtuZGlpVUI4RlVy?=
 =?utf-8?B?Q2piYWdncURJK2pRalNIdW9MMXlDS2RTSmJYRXhvRWhsQlVxaVdXTGQ3N0U4?=
 =?utf-8?B?NjF3QStMQWNyenRPOUVMS0oyV25naG4zemNsYnNFVnAwSVBNcDZJR1IzQk9C?=
 =?utf-8?B?K3E4Sm5Rd2xtQVRzNHhkNHVoUklzZytYV09Ka3Z6ZGJhN3l6c0FzVUdnN0V4?=
 =?utf-8?B?Sk4wbW5Ubkd3TDB0dXZyeHd2c0lVcTJGVzM5UER6M2tQNVZYSWxHaVdXOGNP?=
 =?utf-8?B?WTFLMWFnOGtYVHIwN0djSzlZZWVqcVU1QktrQkN5clZLNWlUTGs2WUc0dDYz?=
 =?utf-8?B?SWQxZUpSdFFseXU0Z25oblk4cUFmWFdCYjdlN2hGTlpjalduVWFadFd5QW8z?=
 =?utf-8?B?QTFWM2VJb2lRenVDeWVFNVpDS3czbGFKR1pGMDl1b09QOWZIQTRKMTJnSWFM?=
 =?utf-8?B?NzlnZERkYmU0bEpuT0sxSGNSMHF4MHFVTVhwc29VZEdsdzAwVTRZcVVGRVVl?=
 =?utf-8?B?UlM1MEE3VmZvaVRkQVlFakpiRmI1ZVVYYm52ZFQ1ckFqRmU3NzhoMHNXV2wv?=
 =?utf-8?B?OXE5N1llcWVXcG5mQ0gxMklSdU1kRVg3UXUrblQzUllvSmV6dzRqN0NPY1pV?=
 =?utf-8?B?aDBRQ1djYTY2cGRicmJhenNkQ2laK0dYazRPTzl6N2ZqNkRlMkQrVnY5Vk9r?=
 =?utf-8?B?dmxoSDMzZFk0V2FZQnNJY29vM1ZHdTY5MGRsdHo2L2gvamh4akpZTGJZeGxX?=
 =?utf-8?B?V0Zoa1NjYTlzNzlBZWVuSTdQNFFhSjZsUjd0TVFhcVY0U2pqbVg5SEZLZXhS?=
 =?utf-8?B?S2hjVWp1VFEwM1k3UkpZTFlCUkM1L1Y2RytqaGxCMUVNcDNIbEp4MGpLMjcw?=
 =?utf-8?B?Z1cwY0Facy9VTVUySTNyb1BXTi80RTk1Z3hINHRpNXRwMkQ4QnFPeFlUK095?=
 =?utf-8?B?VmVVZC8zM1lPaFgzWlRGM0RVSHVaa1dKTkVEbUhlL2NyQS9uRVR2dXhybEE0?=
 =?utf-8?B?MEtlSGkrTE5BanpUUnU2Y01GU2FyaHN0dGUyZnJ0N1phRCtEWHZRekZIQXI4?=
 =?utf-8?B?aGpkVWl4Z1Q1VnJJMmF1U0FpR3NGQ3ZBbGM0TjlpYldNWFVJS0xoamFEUGQw?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02eb55c6-3a2f-417b-3716-08dc59949a5e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 19:29:56.0829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqJxvDcVLtKOQbWCgjjCCvk/dUGArG2YleTa9ymkoAYIVvXIDEiaRdESHb23R2OolYzX8yLNhNnjK6yXJ5Rhak99nzKOuGqois9xDc2KR4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4954
X-OriginatorOrg: intel.com



On 4/9/2024 4:51 PM, Michael Chan wrote:
> On Tue, Apr 9, 2024 at 4:26 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>>
>>
>>
>> On 4/9/2024 2:54 PM, Michael Chan wrote:
>>> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
>>>
>>> The current implementation requires the ifstate to be up when
>>> configuring the RSS contexts.  It will try to fetch the RX ring
>>> IDs and will crash if it is in ifdown state.  Return error if
>>> !netif_running() to prevent the crash.
>>>
>>> An improved implementation is in the works to allow RSS contexts
>>> to be changed while in ifdown state.
>>>
>>> Fixes: b3d0083caf9a ("bnxt_en: Support RSS contexts in ethtool .{get|set}_rxfh()")
>>> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
>>> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
>>> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
>>> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
>>> ---
>>
>> Makes sense, though I think you could send this fix directly to net as
>> its clearly a bug fix and preventing a crash is good.
> 
> This RSS context feature in the driver is new and is only in net-next,
> so the patch only applies to net-next.  Thanks.

Ah, even better fixing it before it hits a stable.

Thanks,
Jake

