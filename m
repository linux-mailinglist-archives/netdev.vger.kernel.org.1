Return-Path: <netdev+bounces-91711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFF18B383D
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 15:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B721F21B37
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 13:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FF9145B21;
	Fri, 26 Apr 2024 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEXsaZYf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D248824B3
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137738; cv=fail; b=PDwB+I+4YJqoBXW6oXGwlqftcEM8E4PfmYAjyOQRxf8eUbrSdsQAeTVnToj2EXw3+73YJb9/sfVzj+TjBEYlYU9kM0rgylZyAtyoD3s88uf7oaGdxN4F7bu0FTsT3h1yReKDacTINuQ3OO4v5xPKpyjznXlt5tqbHyfba65ki/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137738; c=relaxed/simple;
	bh=04JnRd/Z22Uc7ZPxl8Q3VVKWpnMc+P1Vk0GLF1TT8VM=;
	h=Message-ID:Date:From:CC:To:Subject:Content-Type:MIME-Version; b=klSRHrlTx66at48BFRh2W8690W/uHqLfoGaRll0U88ioLNRHh6A+TIVm9aLb2NFiSdzoyur0uDJLKOaiJ+1tSD60B3UwDHNKcRQbM8ee3+qPv2dqqru+Y61DPZyU9eW+AVVTWrnznm6+qClJtxJqVPfynMhX816qqs+tLhblE1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEXsaZYf; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714137737; x=1745673737;
  h=message-id:date:from:cc:to:subject:
   content-transfer-encoding:mime-version;
  bh=04JnRd/Z22Uc7ZPxl8Q3VVKWpnMc+P1Vk0GLF1TT8VM=;
  b=jEXsaZYfUopX5akP1Z5g0wcjqrNxBzYiQHFRAEHMT6cIboP6UfAlT9Qp
   iQrk6gm5nD869GEQ+Nj9v97YBk1QfF+febr0zM7nSjeMZ78OBBefHq95z
   vS0D5/X8EW9Vp0p4d0JLvSW9XvirPFGloungpxvz4oABAe1kwyEuDxpPU
   W1Rq0tAlJQfUhKoNHlpzmcRxcTN5vlyMSVeDfmZrut+2LBJS8pxYOSCIX
   3ISzhM2YeKCvHtipwwlbqOgLUlTwBkHuwqM5+i7nscGc132gdcUhQ3ze4
   HtpZeb32e2OpnuZUh78zgHnddUTdxx1DgjNs+bq5YjmmAjpwUpToYNYCc
   Q==;
X-CSE-ConnectionGUID: 0uWHYV1UQvuggE8DI14NXw==
X-CSE-MsgGUID: aeIkbCg3T/exAwObBy1VEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="27326271"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="27326271"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 06:22:16 -0700
X-CSE-ConnectionGUID: B8lRDV53TrW9W07x5ZPB9Q==
X-CSE-MsgGUID: fhHji0gZS3+ffyzZXtz4Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="30072525"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 06:22:16 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 06:22:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 06:22:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 06:22:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqJkk1TOsirf47t6F1dNdRcYjoUl897YCBXese+x9jQf2mrPblYqJnkQopksbltZotiUvr3XxOKkrPNhePKNjUfljcoJLk80NujoOpaAp+LZP3lcKh3G0jmwP5KUqPPv3ECJo5kpOzjaGIO8fLSnwXlcSanlOjP4H2nCaRAxcL0SMFo/pmpXpie5M0yIy48U/JmyCQSGZTDPHn9s9Z2XtBlGaJLqwUna4VwIw1nqkPSd/3rXsAo4nWRl8ByB44ECGwUYnSYnQu/iTJnAWqwtRnCVoXaPkYFA4zprUJj3jsxYMQvCVRXdYufhSVQFTg5L6BVZIOdJtrKgCPTH3aMzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=910fh9TQVkz428hNT7aDpBwfp7Vz8jIqX2fjiwsFxb4=;
 b=mTC0Eks8+mYzwUFDLygJrHMwttgzOGYXS2Ml1aLyP7+4KSfAfuLlTY/BQGGiy38i0NYFki/QyCvSu+W3wrp0X51RcY3rGpKDWp9NYAwKNwM4aM2YBaqa34VlJyRBdbn3aEe2vnY90lpgg3oocwcAyiLaWU1Vz1vC8Gc0t8UNQc5Lm6aM5cIWDieMvqy0ni+9SQXKozW8Hy7gDa0s87BZOVeRRRTZBbWlpegGaSoWkij9KZVnWe4wG+ePogC2QRTLW+Plb47cGnzBmj0kCrf55jq8v+R8EUMB5eUQG4bOO+iN62fxHAgkfNJbuLWjkSco9m503lzk0o9KYmxvvLct+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by MN0PR11MB6110.namprd11.prod.outlook.com (2603:10b6:208:3ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.27; Fri, 26 Apr
 2024 13:22:12 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3%5]) with mapi id 15.20.7519.020; Fri, 26 Apr 2024
 13:22:11 +0000
Message-ID: <73ac167e-abc5-4e7b-96e3-7c6689b5665a@intel.com>
Date: Fri, 26 Apr 2024 15:22:02 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Knitter, Konrad" <konrad.knitter@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>, "Simon
 Horman" <horms@kernel.org>, Michal Schmidt <mschmidt@redhat.com>, Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko
	<jiri@resnulli.us>, Pawel Chmielewski <pawel.chmielewski@intel.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [RFC net-next (what uAPI?) ice: add support for more than 16 RSS
 queues for VF
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0032.namprd21.prod.outlook.com
 (2603:10b6:302:1::45) To CH0PR11MB8086.namprd11.prod.outlook.com
 (2603:10b6:610:190::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|MN0PR11MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e3eeca5-7896-4d05-5920-08dc65f3e1b3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFFjeWIyS0JrMkxLRXlmSlg5NjYxTUNuWjZReGRzVlNmTHVCR01FNWM2S3Ez?=
 =?utf-8?B?VERBdnNxSnFRdU4rRHg3WFl5b0JlbjRGb3BkRmVqM2NxVUxXcjBybThWZEFl?=
 =?utf-8?B?S2lBOXFmRERuVVlTWWhUZnlPUlVleEZ4L1VwMDNvOVBTdUZDSDJwYnVBQ3Fq?=
 =?utf-8?B?WUZhSnNodzJJK0hnb1VzWEtOUithU3ZVajNBRGV6dkQwc0t2eTk0YlhaWVha?=
 =?utf-8?B?ZVVNSDJjRkVHb3JDRGJYWDlqd2kremFpSUJVblBxalVtMXFvT29hRldzRzBS?=
 =?utf-8?B?YjdZdURxUjJtbU5pY3BCbUZPNUdoLzB4U2orSWpqNG4wQitmZTBwSEhXNkl2?=
 =?utf-8?B?Uy9kNlJTMVlFVnIwTUJDdmcrN3RtQ3hMNG92Z2VlbGZMRkU1WjdLbnBkbCs2?=
 =?utf-8?B?dmdITTduT251K1ZnWnphZTk1czRwTHNhWmtWZHc5WnBZY1B5L05LQ2o3eC9U?=
 =?utf-8?B?VVhvSlhLWUt4RlVoQVdlRWp5b1ZlNHFnVVRCS3k4WDQ2aW8xVmlIRjR0NW1W?=
 =?utf-8?B?cVlKdG01TkFaNnZITnBma0NCTFd0Z0ZkaGR3bm4wcTdtK1g4Z0dxK3pSUklH?=
 =?utf-8?B?WEdEMS8wVmVieWVSK0d1YTlhd0V4Zjl6aitrN2pqWGtJVUhzMENCRmNvdTFn?=
 =?utf-8?B?SzM2Wk5sQkJoLzBhL3FlQWhWMHJkVjkxOVYxUTV4NWV2OGdrYWFDL1RtbTM4?=
 =?utf-8?B?Vm1xdUNnazcweSsraEdUb2t2bnU4WURNbkNrVzEvcUpSbDNoWWF3SjlIbmMx?=
 =?utf-8?B?akpZV2k0UGtTdXRHejhOd0hUVkxHRzZBMHBhK0tDK0kzQzJkUFlDaG1QZHVM?=
 =?utf-8?B?dGN1ekgvVEdYZEhGUnR4Qll0ckYrYUJCZjdMcStiZktnTlJUVmxNdEFsc2lE?=
 =?utf-8?B?KzBncnF6OG5PYnF6RFdqNnlJbjJmaXJTbVpZZUhvVk9VbDFXNzFZNTlwQzFC?=
 =?utf-8?B?SE1TS1J6VkNOYTFTb1dmbkxJSWI5Sll5bHNwT2VibWI1d0k0ZFhFSlJJL2pp?=
 =?utf-8?B?R1lkblA1NXhmWGFyVUM3S2VRZ1prODAzY2xuS0x2NFRZMGZlVEpvVitDTmpV?=
 =?utf-8?B?d1g1Qm5veGhhTHZVM3B2cTdra0JjdlMvMzlBZzlINkdCN1QxcVlCWDZpNHIw?=
 =?utf-8?B?ckprZlpkT3hiZkJtREdGUkhGLy9iRmVRRUF2NmtvYk5KWWhxMDNNV211bVpw?=
 =?utf-8?B?d3FMN1hSWUpGTzZFOGIrMU9Gc3VkNEEyaWJCWGR6enYwZlZFaXRBU0JPR1dn?=
 =?utf-8?B?U3BVL1R3bytKQXRNaVgvbzhZZTI5ak9FVkdZcTVyK2h5eURZYzJ4Y2VoTnFx?=
 =?utf-8?B?VWpXQ2ZsUlgyOXczY0RJK0FvV0gzRkl4eHhrTjdIK210MTgzUFZ1V3NLK3Fs?=
 =?utf-8?B?SkNiV2NjdzRlSHNvTkEvUjFwR2Q5cVg4SldoVkNvVnZCODJjSjM0K1B5L21y?=
 =?utf-8?B?bmQzS1pvSkxYNkNCOWovMkE1R0hsQlB4R1BVWHliVGJUOHgwS0xXK2MvTFVW?=
 =?utf-8?B?bVJOZStvMTM4eGtsdlFaTzR0MUNTbHVqVXI0TXlIT1hEbStaUUYvNUVKSVls?=
 =?utf-8?B?VmovZDdIbG1JOTdNbmNFWXlCSDNad2JwODVwQm9ETFZaTTE4T0NIWHpSSWsz?=
 =?utf-8?Q?q43PisV/CdSstoLes15KpzO6PVu9AzCYJBDDhClCnKGU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Unk1R1VUc2sxQWgwOWFXQjZiVWx1NnNZNkRyQnFTSkFSaTRQZTJqcGIwMXU5?=
 =?utf-8?B?bTF6V0JQalc5QkU2S283MkExVERwcDNabm1MZzRtOWtGWU9hclR1czlWNWdP?=
 =?utf-8?B?dmFJeXdyWEVFb1hLeDF2ejlVVzZ0MWVuczRoMms0Q1NWV0FwN3lKeVo0cy9V?=
 =?utf-8?B?V01xalFsRFgyTEZTOEQvZFRVOXYyOVlRa3l2ZWdPQTNiRDVmckNhVHliNUpH?=
 =?utf-8?B?TUJtYmhmUkNXNi9HZkl3aUVHUVFId21QV1Y5TWhnUEJSbnRvR3RORnBkVGxs?=
 =?utf-8?B?QStsRHdFaW9nNnNLYUUwa0NYTUFLWUhSUWxYVHlqaFRFb25ZdDk0REdBZXdM?=
 =?utf-8?B?Tm00eVZlT25LUUs2dWNpYWpBbWZldmJqbHlqaTFndDNkdjdwd2dpaDRpQUla?=
 =?utf-8?B?N0dlaFRzTm4zaWtQd2Y0VEIzdE5ZTW1yWDYzbjlWRkh5YXpGVlVQRHVZWDZn?=
 =?utf-8?B?ZS9BR2VqMHBPNzlydzJTcXNDaElnUTBWbExwNG1SOEVyemdaeDBFVmpvblJQ?=
 =?utf-8?B?anZrWDRpZm5qSlRPUzFuaGpxV3VSVUNPbnpZWmF4NFVDR3hwbGtFSFFoWWg0?=
 =?utf-8?B?YzZWNDNFejBvYTNLejd0RmZ3NTBsSkN0Y0szN2ZBTHZ3cXN3NGFneGJPTmdI?=
 =?utf-8?B?OUJlU2VQNDNyZ1ExaEIwS3BNZmVHK2pGSW91YnRxZkQ4V2VHdFVQT21pTGxv?=
 =?utf-8?B?ek15T1FSRHlCekJDVWlsUUJhanpsNVE5QkQ4dFNKMDl5cStYNytrVHNadlRv?=
 =?utf-8?B?VzZpaDlqRnROMS9Eb2p2YjBhVU40RHRTWHExTEVRYjZxeHRjQ0NPdkNVaXdQ?=
 =?utf-8?B?TXF0UnM4V0FndjRzS3Fnazg5YXRORWZkKzRidEZudnhuenBnUTRTVHlzbkFW?=
 =?utf-8?B?QmFZUG1YblJ3UjlQUk1XYU9qeEQzbGNscnFqY29hbmk3S3IxWHVlbDlCb3Fj?=
 =?utf-8?B?M0FRdnJiNGR5aWJtVGhHWHhqeWsxdWllQk05SmdISkl6V2wreFRYQWM2azIy?=
 =?utf-8?B?bXdobGlYTUo5VTZxM3B2QXdVSmRySk51T1V1YmtjTkQyNllGWEw3c2R4ZHZK?=
 =?utf-8?B?cUxGc01ZcytXSzg2NGp6VlkxV0ZmMG1EVGs3RVU0VkorY3NjR05ZdExLcitO?=
 =?utf-8?B?L2l2R3pQYUpqdnBiaHFYVXd1cXh3ZjVlTjdZQU5BVi9Tc2pHc0FiYytMRVEy?=
 =?utf-8?B?Zk1NYlpVbTdBTDJ3ZXhaU2k4dkFoMHJMTU96bnpUVCtNSEVPYjJyME9sYVpm?=
 =?utf-8?B?OEkzSFl4bWxLL3B4TUtXYUw0bzNzNUNUWEZKb3loQ2tuUXd2M09CNXZ6NitF?=
 =?utf-8?B?SENBY0FtdG94dkNjbEdkRGF2czk5K201RmR0NThOYzYvQ05DaGhDS1FQNDFU?=
 =?utf-8?B?ZzQ1ZzJEcDBEdnZhWEhnR25PWUtUY0E3K0lKT3pIWnNTYkxBaDIzQXRsM0o0?=
 =?utf-8?B?ZG1KYnB6OXBIRmVhUUNFSktTd1N6YUNGKy9LM2ZqY0s5Wkc3aGF4dzhvSjV1?=
 =?utf-8?B?RGhsNi9xQ1o0Mmk4NGZxRTNXSjFaNVR5d3QvNWV2cldBL3c5NkhnMEwvaGNr?=
 =?utf-8?B?VWs5ZFBQaHVmbkVhWmRuMHgyUzZRNldxb1lwVldFbUtQQ3YyMmdRTE50QXFm?=
 =?utf-8?B?Mnc2THJUSG0xZlNoN2VCNjRaY0lzc2tOVjR2WE1WSGhrbUludVZTYWc3U0FD?=
 =?utf-8?B?U2pocWZIYWpyWWFhZVFXN2did0lCdEY2UXM3MEpsMjVlVTRHRzF3blJjdlZw?=
 =?utf-8?B?Q0NJejY5bUEvYUtLZVg1NUxJbWhnRWhXejNvRmgyaVR2b1BaMFJBNnZCdUdI?=
 =?utf-8?B?YUd6L2RNM2oyU0doaWRnTVA3bjg0dHlTZTZYTkk3eHBkS0w3czgrTE9QOXV1?=
 =?utf-8?B?S3ladzZqTXVGaE5mSWhLOFpWblZocTNuem0vd0EzSi85YVZMQ2ZqTVVVTHR5?=
 =?utf-8?B?eWNxVFlkcGF2bGJNc2VDNVc5L3lVQ3BDVnUvTkRNMDZQWFRhRU5iU2tTWHgx?=
 =?utf-8?B?UUdkOGJudjhHUFhoYVN3Y1QxNjNyNjZDczZFaExZT3l2L2tnUjNNUXNsNUFa?=
 =?utf-8?B?SjJGQkRHQVJhL3VjZEpQVVFpVDVDV2U2dERTSVJyMVFoUjdaOHRpc2hFUGJD?=
 =?utf-8?B?SU5GdzRBcndkUmJQTEM0RWJTaVNFd2ZIUWJVVTNiaGh0aVQzY2xvaEw3Z2J0?=
 =?utf-8?Q?y5XqltFWuVFpHTpFx9bjUWg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3eeca5-7896-4d05-5920-08dc65f3e1b3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:22:11.9067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwOLliZf8vogRhS93NwpJSFjnxziAXEkVWEmQO+vBHMdhaUdW1Zd0FL8iaTGeWqz3DnGgLn5UjpugiUO4rUfaFuT2yHuQpv6tgQuSdp/e8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6110
X-OriginatorOrg: intel.com

Main aim for this RFC is to ask for the preferred uAPI, but let me start
with some background. Then I describe considered uAPIs, from most
readily available to most implementation-needed.

## why
We want to extend ice+iavf in order to support more than 16 RSS-enabled
queues for a VF. To do so we have to assign a bigger RSS LUT than the
default VSI LUT. This feature is known as Extra Large VF to the users of
our OOT driver. iavf would be notified about changes by ice, it's not
touched in any way by this RFC.

## what
There are 3 types of the RSS LUT in e800 family, and the resource limits
are per whole card. Smallest, practically unlimited is VSI LUT, allows
for 16 RSS queues, then there is GLOBAL LUT, allows for 64 RSS queues,
finally there is PF LUT which allows 256 RSS queues. Sizes for LUTs (in
terms of entries) are respectively 64, 512, 2048 (that size could be
used later for ethtool -X). Hardware limits for e810 card are 16 GLOBAL
LUTs (unused at the moment) and one PF LUT (assigned to PF VSI) for each
port, (what means that the limit grows after a port split).

In case this is not yet clear, PF needs to arbitrage resource allocation
to avoid the case that there are two users of the given PF LUT. For
GLOBAL LUTs arbitrage could be deferred to FW, but PFs need to be able
to report usage. It is still possible (and preferred) to arbitrage
GLOBAL LUT distribution in SW, struct ice_adapter could be extended for
that.

Please find various interface considerations/propositions below.

## sysfs
Our OOT solution is based on sysfs, with one RW file (attribute) for
each VF and PF. Example flow to reassign PF LUT from PF to VF0:
echo 512 > /sys/class/net/$pf/device/rss_lut_pf_attr # switch to GLOBAL
echo 2048 > /sys/class/net/$pf/device/virtfn0/rss_lut_vf_attr
Obvious, easy to implement, but cursed sysfs.

## ethtool -L $vf
It's tempting to think about all of this Intel RSS LUT as an 
implementation detail that should be transparent to the user, but
anything other that the default flow would be obscured then: not all Rx
queues need RSS; one could benefit also from bigger table even if there
are less queues; etc.
So I'm opposed.
Any ethtool base interface would also be least convenient to implement,
since we will have additional virtchannel communication to pass request
to the PF.

## devlink - priv params + priv port params
Direct translation of sysfs interface into 2020's, would require a
bring-back of unused (thus removed) port params API.
Would require registering of entry for each VF, which does not feel
right (keep in mind that the entities that we want to distribute are
LUTs). Straightforward to implement.

# for PF:
devlink dev param set DEV name rss_lut_size value { 512 | 2048 } \
		cmode runtime
# for VF:
devlink dev param set DEV/PORT_INDEX name rss_lut_size \
		value { 64 | 512 | 2048 } cmode runtime

(I wonder why there is no "port" word for port version (VF) above in the
man page: https://man7.org/linux/man-pages/man8/devlink-port.8.html )

With `show` implemented too.

I don't know if this would require "porting" our "port representors" for
VFs, right now we don't have any devlink interface for VFs.

 From user perspective this is my most liked variant.

## devlink resources (with current API)
`devlink resource` is compelling, partially given the name sounds like a
perfect match. But when we dig just a little bit, the current Path+sizes
(min,max,step) is totally off to what is the most elegant picture of the
situation. In order to fit into existing uAPI, I would need to register
VFs as PF's resource, then GLOBAL LUT and PF LUT as a sub resource to
that (each VF gets two entries under it; plus two additional ones for
PF) I don't like it, I also feel like there is not that much use of
current resources API (it's not natural to use it for distribution, only
for limitation).

## devlink resources (with extended API)
It is possible to extend current `devlink resource` so instead of only
Path+size, there would be also Path+Owner option to use.
The default state for ice driver would be that PFs owns PF LUTs, GLOBAL
LUTs are all free.

example proposed flow to assign a GLOBAL LUT to VF0 and PF LUT to VF1:
pf=0000:03:00.0  # likely more meaningful than VSI idx, but open for
vf0=0000:03:00.1 #                                       suggestions
vf1=0000:03:00.2
devlink resource set pci/$pf path /lut/lut_table_512 owner $pf
devlink resource set pci/$pf path /lut/lut_table_2048 owner free
devlink resource set pci/$pf path /lut/lut_table_512 owner $vf0
devlink resource set pci/$pf path /lut/lut_table_2048 owner $vf1

(ASSUMING 1 Port)
the above 4 commands would default to transfer ownership of "1 unit",
the $pf still has 17 LUT entries under it, and would display 2 GLOBALs
as taken by particular owners, same for the PF LUT, and finally display
14 GLOBAL LUT units as free.

This option will be the best if 16 Global LUTs were given to each port,
but that is not the case.
(ASSUMPTION off)
`show` command would have to aggregate over all ports, or simply don't
show free global LUTs (show only those in use).

If it would be possible to register a "merged device" (==all PFs or
physical card), for which we don't have a driver, as an entry for
devlink resource command, then it would be straightforward to implement
`show` subcommand for multi port case.

## conclusion
I like the most devlink priv params, with devlink resources modified to
have an owner semantics as the second option.

