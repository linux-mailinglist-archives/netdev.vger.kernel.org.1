Return-Path: <netdev+bounces-83945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B0B894F5A
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 11:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6071F23BC8
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 09:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5A158AAF;
	Tue,  2 Apr 2024 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1DJ+Zzh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9335A0FD
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051909; cv=fail; b=QW59mtgTGbXrL5W3WhanURWInTZ7hzOw1CpTjoV0Bdo6F9ZJiVfTbvOfDJrvV7wKpdEywXVxDRjPMF4k456K6DzhUfZDsa3OSYk4RAff43Rob89qwroNtzagkEN0HHWXGnfMPhUD0vz99WBHXEAlzMKrPWU9vI74wtI/Em3ylXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051909; c=relaxed/simple;
	bh=ORASnyTXZ+jB2YYyF/n5hJEpvFzZ0lYpVomZ483RIvU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QZZTTuWhuaZ0u997+v0xSyChnnWu5widj12jMEH+agIUJTpqt448Cn7DMpQy5N+GLTLtZ+Ds5sB7XIPoYgkEaTI8LsNWlE0aPN9yXqYlRj63wAFY5i+6q/WRvtIYE5YBBlJl2L/ae81wdU42cpUinpRPd2m+uvo+I4yK6dx4EJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1DJ+Zzh; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712051906; x=1743587906;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ORASnyTXZ+jB2YYyF/n5hJEpvFzZ0lYpVomZ483RIvU=;
  b=c1DJ+ZzhUDhsgEccek0aAQtg25LkikkmhKvU12bbinXhlOiOCHPHIHdZ
   aI0q396VNKy9OomCS73CNdbdyU0p/3UqyuBenKvdIUPWau5xqL3ZlspHU
   Zd+dTOw6BUVccsCErurnU+HG4RDqumsk3bYFpBqUw9Vi0t1QEvRvN9F7R
   rcXX+KcFmt5Z2NDrTfg+az+Puoru54dkYCrrBp/mej+NZ4UJvOTl9321K
   ndjQAQSYww+Dd4UtqzfcdTGBVI7FmAP+7TngVMwrPqne7+jea21EcHcg9
   mYIznYShWaliy+Yc/nOSNYn79E+T8KBGSoDgh1pHQmNTzAkvyR/8OONKS
   g==;
X-CSE-ConnectionGUID: bUEv7dJ9Qj+OgvpttJoVeQ==
X-CSE-MsgGUID: Qe6riDWESyqBIkDhRdmXkw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="10995665"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="10995665"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 02:58:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="22461583"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 02:58:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 02:58:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 02:58:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 02:58:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxrRKaIMN4IgCTXck49aOd14+HVtrkdwU1mfg0/sG/64KKdo+hbHG5o5CPMn2dErSmYdmCIeizFyJBqljcNY9HxzY/3TQGVeYWmtFv49JTK+hpYpjZz13ITsXk0EEEa6eQvtvXtSFMfkY09Miclbu/CUZyrJIsmD6mFZpK/EQITui+9y/6VEsiB3Hr2Cp1xONPyjZqaQZdC3jMwlGz5sRGPaHaq3Zbr19nkORfCd7qStVhZewupc+5rRarigLLZdT4N0ndJUEBln0zfP+dCMu3kxXfY8TlMU5aZVHt2xsV6KCkGMOKKfCepoW5ccuzmOdxk1Er2gpMFZq6az3b9iNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68N6jg3B0XVihKgwLOD8QuIz64Yf+hig0gGKHg96mR8=;
 b=nqRfYg1HPduULGfFpYO6dNCKsCQcmaUaMcjJsC3nCLRyDEcRNnp0daBvB+FcUwYHnhKxZD+aG16Km9z1ozFSXRqvhWgIK1B4nQAKzk9fff34/Dvoe+BOCfw9/nUN8/vPnp2vPnA405o3YQ+W24jFc5JCdgW6JQa/oS3li9XckUpsbd679tMBpcCsfi+rKapOG0NeXbSS2sVZuFUL/POWxSl5Hq+T1Rm63nEL5G0KJWhVP163PTf0zJ75LXHKQ6qrJTNLS3mxzHup+zAn7jKLmAJaZCuMshu6s9Ss+J4s0wFMJ6qTec0Li7j/sRo8VBOyhVOmmHAaRsHh30c18y8DTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA1PR11MB8523.namprd11.prod.outlook.com (2603:10b6:806:3b5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Tue, 2 Apr
 2024 09:58:23 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ac3:a242:4abe:a665]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ac3:a242:4abe:a665%4]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 09:58:23 +0000
Message-ID: <fe558a64-f554-43c8-a368-39f63151468c@intel.com>
Date: Tue, 2 Apr 2024 11:58:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] ethtool: Max power support
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<simon.horman@corigine.com>, <anthony.l.nguyen@intel.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <idosch@nvidia.com>,
	<przemyslaw.kitszel@intel.com>, <marcin.szycik@linux.intel.com>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
 <20240329151603.77981289@kernel.org>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240329151603.77981289@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0019.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::16) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA1PR11MB8523:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3qljWsR9e3Xa624c+EaHKu1g3onfUKmK83/VfOAdZpQmwEO8tCq9O7xQcdpP/rWnS97NaERzBWHCTVOPqniyjvToTB0yRlIp+wyWVNjamKgBweoZBdA5TlDkXAQtzPThmawEPVvtNE2mRvSKmIIr4Nor/w2n/dUP6Wyw5Uxn+Gy8uQ6yRHXknNkr9QqKdck2wcgXJerpTGQgwr2z6a8MWC8aUNyJPYtNKEL5o3VdaKo3fSvZ9jAObCHtPjpKZ70Hs2lDEi/jXe0PqEHSTHyjOMjukxef+JLzTd/K2zgioomu6IxNvpWv+noxH33gzErtzMWJLo8MAhvto2YWCrkEv/MLwJR9VXSc4hhYx6b4CzD651JIrOZzBJYFBeMSFm7jX/bLB7i/SBnODbReAca8hzXofVfhPf5FvxlqtwvUYqY1jjQ91yy3AOo+jGhdG5PdLmZ30CsN2eM/J7dimAOUMp5g5vN3UIvs3dK2/vkj0rAMVUvo11wh34ywaxmIgIXAh4ubLM/5Cd5uh2Ka1Xgx5rGH/wCg/sVCIYS1+dyeCgAJBgA6v22DPPo0qk0RTb/tEH28ljMgdu3imu4e19lLN1N4sjDwwDPuhWrWZO/s58BJD7wCNninPDh5vDn9a0dPNSomWAx0gal/HP0CuYTpYBXMFTaG4Nxdn4y3yIPCMs4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTZzdmtXUi82S04rZWdyMFdLVHlWcXl3NXNoUEhwTjUvLzdmbS9iYWdrclh6?=
 =?utf-8?B?MS9uY2Zqbm9MUkJ5QmdwMFdRdHVDemhwVm5vNFhzNWswUHo5K3EwVE9aTHpp?=
 =?utf-8?B?cnI2dlBjNVRDQXZGVktBNVdlRE1RcUpsaTdtbVRSSTRCbG5uY3UwSFlrTlQv?=
 =?utf-8?B?bGtBKytSdndhMVVSMGJaano1ejFUOVZxdVBrSXBnMlNGWHIrYWRhR3pwcVRQ?=
 =?utf-8?B?N3IyejlaazhsSlZpbGt6VC8vL1lxTTJNWXRyaW5JOWZSK2haQUlDSE1aN1lv?=
 =?utf-8?B?c2daZ2luZEh0ckJPSzBmelZPNEd4bTgxako5anB6WGxyTHMzTlJnQThmNHov?=
 =?utf-8?B?VW1udDVaVTNsZFZZVWJtVjVnNlJPNWs0a1ZSY2dsalN4eWo4WVlIRG5JYkFR?=
 =?utf-8?B?MWVNelhZUTYyaU5LSDdkZjhHQTZGRHhFQ0dXWU5uTElLcFR2dms2M3ZxV2J6?=
 =?utf-8?B?bitCYko3aXNpOVRQNU1qL2pDUWdZYVB6OVAzdzY0UW50MG5rajN3RzI0OU9B?=
 =?utf-8?B?eGQ2Ym5SbUZaaitUZXFxUUgzQmhIbS9LUEhES1lFbUJsK3haTmEvclM1M0Mx?=
 =?utf-8?B?bXFnZmY2MVlzWXVmRDdDZUl2ZzlBTmVQZ2dvYlY0NHFFdUNmeWVUUWs2Y0xo?=
 =?utf-8?B?bEJ0TkltcFFSZEFNTUhzWkEvRSs5b0N1NHhQZWtqZjY5OXNFbXFHajBzdG11?=
 =?utf-8?B?dUpGQTlwQjYzc1NKcENjdHNtc3psbDlwVGxQclFXRDhEZC9DWE9JaHJkLytx?=
 =?utf-8?B?RWtFYnRZRmpuVDRGR2NOSDB1dVZ5dGt3RVNqWS9kL3pDd2Y1NHdOSEN6Uys0?=
 =?utf-8?B?U1lWWjYwdG9aNW9OTFM1d080Nlo2d3Z0ZktQZUcyOCtMV2ZvUDJRVUpqZ2FK?=
 =?utf-8?B?aUpiRGgra0JDR1RYcW9NU01KQTZXN3VDbGJCQTZEVWRJRTA4ZnZWdExLZGN5?=
 =?utf-8?B?OGRMcXFKZWZJSFNxQktsa2txTnhiTHg1SEsrRy9tUXc2RUE0MjZWdGxEeGZq?=
 =?utf-8?B?a2VyN1JzSGQ5VVRVWWFwUUZmY1pQOUxSTkhvR0hDZmQydzRicUxtZWg5M2wx?=
 =?utf-8?B?d2FvYXVKMSt6K1VlQjdPeFViMm0ySDRlMUEzVU92dlJJaHFNUVAyc2h6M3Z1?=
 =?utf-8?B?aUlJeTNHemVPd2NxeDZ6WXh2TGpoenhBQ0l4YStUZUhFWGV2dmdha25vYitu?=
 =?utf-8?B?bi9WaDJOalJ0akY0TXMyaE0zY3lMS081SUh3VWJ6MzRyNEx2WWhXRzBkWk40?=
 =?utf-8?B?enU5TWFZeEE3eHA2N3VIYkM0ZGFEOHdURzFWMDJ1Y1ZXNEJxR3lCeThwc0sx?=
 =?utf-8?B?d0JGbTRMQ0hOVWFpR01TTnUwT1RRQ20vQURNUWdHZ2kxQnpDd0dFNy8yZHJD?=
 =?utf-8?B?dlRCUnA4c1dIcXJUOXBPTFdKTlBJRlhReUJvSTVDdk40VnJscVpMdjExa1FJ?=
 =?utf-8?B?VTBkSkc4NzNyYS9QbVpHemg5RWtWUzYwSFJmUnhRc1lGOEdRNkdJSmlMS0hZ?=
 =?utf-8?B?VmpUT2xjcEtPbzI0bkxhbDZLY0pHdGdTYWV4ampMU29vNkY4TDVqV2lSTW1z?=
 =?utf-8?B?QTRvVUVLREZYYnhGS1pqcGpWS0JKUlVlRE1iYmxnbHE0d1p1RGVxT050VHZQ?=
 =?utf-8?B?d0dSYkw1RFovU0VXOVhOdUx1MWcvY2xkVGIrS0FIWlBFYlpxTEtuSUhOaXY1?=
 =?utf-8?B?RGhHaHFDQjdreG1oMDMzdFU2ekhXSWxxK2grS1JXZ09Lb0xLelh3Q2ZuZkky?=
 =?utf-8?B?bnRzQU5wTjFoNFRNQjhldEtLNlZwZEdFblJ4K0QveENiZWc2NXplRDJuRHZS?=
 =?utf-8?B?YnZXRENmRmdNUXBwRi80aVduUzJHRmN1bkZWd1d1WUZqVS9kZStlL2U0VGZx?=
 =?utf-8?B?enVOODlYaXdFWG1NNWNFdTlqOHNHclowWndXeXJuSTVrZlVTRnhFY1ExQzFS?=
 =?utf-8?B?bTVNTzg3VUJnMFVqaVNIMGlORGJuS29GWlN2TXphMjlPeW5aejFCUURhYVBr?=
 =?utf-8?B?TU5UNVYwMlBNMEQvSnRLcENoQW81MDlOUS94UGhMSG81Z01uUDEyaE1sQldr?=
 =?utf-8?B?eHhyWk9xbkpyaWtKcUJJV2lycTFKa3IyNlBXc0xmK3V3Z0JWOEE5WWwxQXl5?=
 =?utf-8?B?cHE4cVdHWGdhM2Juc21wNzZCcmdLMGtibmROeEQvQnFJdW1DUGNKT2MxdEo4?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b1fb87-322d-4dd9-9b88-08dc52fb6f17
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 09:58:23.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g80yHvM/T6cZyUGDyJae1I5pelP5H8kags4muvu/IKEisS9zqq7exmuwrS9l6X+1OsZG024lCOfcgAoSUcraQ0gK5OzgXupjZW+DfHLelR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8523
X-OriginatorOrg: intel.com



On 29.03.2024 23:16, Jakub Kicinski wrote:
> On Fri, 29 Mar 2024 10:23:18 +0100 Wojciech Drewek wrote:
>> Some ethernet modules use nonstandard power levels [1]. Extend ethtool
>> module implementation to support new attributes that will allow user
>> to change maximum power. Rename structures and functions to be more
>> generic. Introduce an example of the new API in ice driver.
> 
> I'm no SFP expert but seems reasonable.
> 
> Would be good to insert more references to the SFP / CMIS specs
> which describe the standard registers.

Sure, I'll search for additional references.

> 
> Also the series is suffering from lack of docs and spec, please
> update both:
> 
>   Documentation/networking/ethtool-netlink.rst
>   Documentation/netlink/specs/ethtool.yaml


Sure thing, I'll write the documentation.

