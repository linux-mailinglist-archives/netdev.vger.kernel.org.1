Return-Path: <netdev+bounces-91086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296118B150E
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 23:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD861C238A4
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 21:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D188A15698E;
	Wed, 24 Apr 2024 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2fT9utL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EB4156973
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713992900; cv=fail; b=IxWH+clh2Ln/FVvcFmAbH1JoSi6rSeCR6cBZ2PuyUo649AD9bQZdMXRcGh67mpKEQt1UDFgq5OHlbCvHa5wrwF4wz2X1hCTYQQyYZR0Z77hvUKvO+fPc9ajMoFFIObFhsuonyjUy7f5+erijufqQAJbZMrM0Dys1/laV0JWxCFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713992900; c=relaxed/simple;
	bh=W/pajr8frqwYQWyXNQfDQxoooVOzoofNcq1uoxDbcp0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TguUOCBG6vLAQ4v47Vz30CXKAKKHzA3BEpg4mc91FMFEaBiaNsZJ5J+C1gJMA3oW5b2w+iLSeVS1xVdiREfg7WLMArwq19U7XkeQEvl2IBUrxlWMJpmxTEH02nLnODpemxUj4dUFNieHTWwEAwhGeEgYtPSKaV120MQCtQb9eS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b2fT9utL; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713992900; x=1745528900;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W/pajr8frqwYQWyXNQfDQxoooVOzoofNcq1uoxDbcp0=;
  b=b2fT9utLGu487a/TBTHjEdjR6ySdAqOrx6hCSCtL/8YR5uOmqVllp0wq
   ZTchExkLP7ahcTEHi62g7SG70zAudryfgVS94lMk6NWO4uf1d/8zdR2ho
   dJVPL8hkf3CYEOnUTzC3FMkoPz1jVB9JV3POIavOJPWHHnVUdM2XAx7wq
   z0o3bc2WQuHVAh9wtZ6I6kpZrPL2ctiCkUR9uRipd2e7EOFuRI7STvERx
   KJL8opUbpDtcnjlCwsRTpFcEjXhc0NBR7ICR+Y8S1EB5AHai7MyKAjgoY
   avSlD/wqjMIFN6i9f1L10kolW3M52urd0MjKlHJUK7lQGZvgFxXif5sOG
   w==;
X-CSE-ConnectionGUID: /VTZfx+pQGSdp/NzaIKjEQ==
X-CSE-MsgGUID: rsxqTQljRcCX1RJC4dUTIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9814416"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="9814416"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 14:08:19 -0700
X-CSE-ConnectionGUID: etwvHxuXQUOhagokZR6bFQ==
X-CSE-MsgGUID: BSpwdnGxQSarx8RhBgzJqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="29629182"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 14:08:18 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 14:08:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 14:08:18 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 14:08:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGlOgRgEM76AzHLkxbL3CF5XNld6i01DzecDSFkzNpiW5u6flU1sXLtnwU2/rDcxUOO7cQ6bODow7n6maZ7lH/dpgElADETNmkcP0huoVUkZCIkjjI3X/PNoeeObMNmbCYUe7y6gRa7bKKYktQRyrvNV9VNUCE0m7IWRyYBIb2koKDrQ4x2LuBfdhXHmj6afRTOzXWwB3NLgANh0j0QsP/xzfnFFeofG9iolBTqSuH8ABzbj03l1G+3XpSSCaPjZKMTVMmMxZmO1tJW6IaeO1vZo9RUKgAoxeljWiefflgyUhYAc1wVLUe5O2HojTm9e0lxsaA7ITl5bS1MPxZj3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoeRLMwlkUAGISS77NDiwnVWTQ1rtkBYH8Scy4Am6ww=;
 b=EsMBN5sdsf8TH4c/YsyStpb/O8N0TKj8BYZZaqoSOVfY2GywaPVi6gjAv25RDGOJ1nNBaQV1KN7L6kYM4q9a1gVj3xhE/OrRh3b1bX9BXuiI+5RYCnz7shDlpP977Nv1EfDvwShHoZdDBp6w/7x6QoxVf6B8i/egWP/dAwUQaqP5fLwe4F3z9lCX5HB2Rp5FOaKRduBrwPIZNsBJTSnfgDhf6z0HGp6xCQBWn51R7l1IftfMKTGPQuivDcq3AE2416p2kbRhWV7JkBwZgkha1Zue/BqwpNO08nP2PBBHJaZRop/j8i3nIuDbSHgqAHkG0i4fWPGHEuqNU5+EU4vz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH8PR11MB6562.namprd11.prod.outlook.com (2603:10b6:510:1c1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.19; Wed, 24 Apr
 2024 21:08:15 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308%4]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 21:08:14 +0000
Message-ID: <7003fe5e-4bb9-8335-6d3f-9edab0aa3570@intel.com>
Date: Wed, 24 Apr 2024 14:08:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [iwl-next v1 3/4] ice: move VSI configuration outside repr setup
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <jacob.e.keller@intel.com>,
	<michal.kubiak@intel.com>, <maciej.fijalkowski@intel.com>,
	<sridhar.samudrala@intel.com>, <przemyslaw.kitszel@intel.com>,
	<wojciech.drewek@intel.com>, <pio.raczynski@gmail.com>, <jiri@nvidia.com>,
	<mateusz.polchlopek@intel.com>, <shayd@nvidia.com>
References: <20240419171336.11617-1-michal.swiatkowski@linux.intel.com>
 <20240419171336.11617-4-michal.swiatkowski@linux.intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240419171336.11617-4-michal.swiatkowski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0135.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::20) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH8PR11MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: aecdf8e6-0748-4150-c786-08dc64a2a7d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wi90ZVpzU3N6c3NvV09HQ2tDUk5FeVJjeXVzbUdsVU43YUVicWtqVjB1QlVk?=
 =?utf-8?B?d2NFb1orcHltT1ZidG43Q1g0NW4yYS9tUndiZ3FWWERKZVdXVlNFeWNucm5K?=
 =?utf-8?B?U2hCTEZ1ejczM0Q3RE5sMlQyaW1LeWloNGYvZXdGMkdGdFBkSTFLb01EVnpR?=
 =?utf-8?B?RVJsajVRcG5aZ21TWnV1aU45d2hJUmZINWlyaGNPSy8vS1pxMGFzQmEvcXBw?=
 =?utf-8?B?dDMrVGQ4clhwb292VWxQdXpIa0NJRVJTUGltQVFLaXFBWDkxSVFqSE9XdVEz?=
 =?utf-8?B?aWthVDlmRzBwLzhGeSt1QUJmS1M5NmhLT1BOT1l4UEkweFpLMnRQZkdxLzIy?=
 =?utf-8?B?MEV1NEhqTGs1a3pJNndpWWUwcFN2Zms0Nnc3ajlqSXN0NkpGNVcwdUVHTVRZ?=
 =?utf-8?B?N0YzbXhQb2xxeHp2eDVXSGRsOVBRQUw5OHl1dWl1WHg3RnBKZWJLbUhkbjJy?=
 =?utf-8?B?bHZiN0Y3YVNKcyszMGVHQXVSVUgyVXpsOERla21jb0JVdnlnV1YrRVRDZXZI?=
 =?utf-8?B?YUc4NVRiR09vb3hZZGg1aHdkaDlpZlY3UkpoMkZ6QWIyRThoWjFTS1lieDlF?=
 =?utf-8?B?U2grbCs3VHpubHNGZitFdC9tRnZoYkZ1S2VWNFVyN2YyZTJjcUE5KzBaaGV6?=
 =?utf-8?B?S3RvWXp1Z1VEeG5OdVlwRmdESU9oWTE1SHhXT1FRRm9zekFWLy9qTzV6aCtR?=
 =?utf-8?B?N2g2Zm5OMGhBQnFDQlQvNWJYSWNYWERqaGg0bHJORzBIdmlZU3lCM09aaWN1?=
 =?utf-8?B?bDlJVzFVUkxDVm4vSDBCUnNLNFRFeDdjK09Yc1VIT2t2cWRtU1Z2ZlU2ZWNz?=
 =?utf-8?B?TWlFL3FHV1ZBSUVPTFl6NVloZngxeU1Tc2x4eU5Sdk1KcUVlWEV4YzRLdkpr?=
 =?utf-8?B?QmdNejZqTDM0WkhlR0FCM1QzN0E4NkdJN0dHSHJXOUtiT2ZEaXZzOUtScmhK?=
 =?utf-8?B?M292MmcxRGgyZDRhdW4rMUZXcGQzTy9tb0ptclY5WDkwZkxBUG1od0tjVCtQ?=
 =?utf-8?B?bVRINWFMb3BWcUo1VU5JNUlXK1lIOFJFTDFyQUw3SHAwbUJ6QTRGSTRQYU01?=
 =?utf-8?B?ajN5bkpHQ2N6YTlTSDZ3QTcya3JYbEgycy8vVEtkdFRneUU1V0d3NGY1K1Fn?=
 =?utf-8?B?c2pjb0g2b3cveFhrSktIUDZObEJWcXk0NWRlZnJZMEdKdFg4Uy9Kck9YUTdI?=
 =?utf-8?B?RGFsWVZJUXVnZWoyNW5rRk5rNGR3UjEyUERNcWR0YVgyUVRWQ1NwMVJrdEgy?=
 =?utf-8?B?OFhsV2NNTnBtUmsvWGtTbjB5QTBWKy9jKytFdVJNVGsrdUtDcDFxWENSb2JZ?=
 =?utf-8?B?bEdMbjU1NHo2Q1RUdlk2M3VwNTVNUDVNR1FBb29IR3hvbFkzWVd1UHpLbjhu?=
 =?utf-8?B?b3R2VXBRY0FVUXBhNElhZUJOcHQrNVN3S0t0aG41TnZxL09KcS9RMlVUT1lo?=
 =?utf-8?B?WmJBbnBQbDNXNzNROGJrd2wyYjFsK05vcXh2YzQ1cTFraVJBZ2RMOE1qM1dT?=
 =?utf-8?B?MFp1cjk5UHM2VGxDQWRqaXFDbHlVZnNHb29CWE82S01BWCtvUHR4b25IQ2dt?=
 =?utf-8?B?Ym5CaUh5TWRKeHFHZGUyM1c2dTZsOUpBbk9rWlVUeW9XeWVwWDdPQURQWDcw?=
 =?utf-8?B?eGE3OEx4N1NLUmFhR245N0FiblZ2TUVJbUlHbFIzckpKWG1VTlpWSXZycWZh?=
 =?utf-8?B?NXZWVzVEdzhqOENKQUFDSHhaalZ1V3pnZmtLZTVsWHB2WHpJNm04WHBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGg4MEp6ZXpIbWhKRWNzZUdKVHNoRmZ2SWJPZmJwSmxlK2hkTVRsV1RuT0JR?=
 =?utf-8?B?Wi9tQzU0YlF5VDFWL0RmdGFvY0NlRVlZMXFOYVhBKzZFU1dWRmdwRy84enE5?=
 =?utf-8?B?bDc4OTNWTGNkRVltOVA3V1NpcmxaYXJxMFNpUmhTRDBCWS9qOXhyanBWWlZM?=
 =?utf-8?B?YS90Uk90KzVjMS9aSTc3czFRTWNZZjNZL1JLa1VsSW42ZEVqVC9URWVuVVNO?=
 =?utf-8?B?M1p3ODZKZ0krZkkxSWQ4ZHlYZncrL1dnTWpBSkhMTSs0Q3JrODRnYWRkNDFN?=
 =?utf-8?B?aE9sb1FmR1BCM2h3RnhHeFNXR09ueFhmVVoycHN2STNhbWlzT1JDWUJvclpK?=
 =?utf-8?B?VzBVSVRrTGRua2FJb1M1cjd1ZGF2UmJsTnFaVDE0ejlYOThBbDdaUFJBcTBU?=
 =?utf-8?B?Q1lRVnBsbmRzbHNrVjd2Z2d2UG9wWkRHQVpFYkpiT2dzVzNJQzJsN3dRNHB1?=
 =?utf-8?B?MVBIVUtUaGNPQWlNdnpzOEs1MWs3aFhMYTU0MEQxWnBIRjNHYXBTMGN2ZGda?=
 =?utf-8?B?T2ltNDhtZXhzMXVSN21JNTJuaWFZUzJCVUh0RC9iQ0c2SDZkc25jNlJkZ1J0?=
 =?utf-8?B?RDg2a29mTllERUVXMFBjQ2pSVE1aWC83RUdhOWVzOXg5cFRTMlNSOGJNeTVN?=
 =?utf-8?B?Z2EzTk9mZjZ0YTZWMGxkdGU3Ulh3TVNWSnh0ZDF6ejNEdkRnSUlUOHFVS2h6?=
 =?utf-8?B?WllYOElnWWkzQjRsdXlQTlpCZ29TQmtKU0FUTjZSbjMvY0FHWDdXQU5FRVI4?=
 =?utf-8?B?UFZFMjluR3BYeXBlU3k0Z2VRdmpTdWF1Q1hIaG93TUVSZFhDcmdONUllT2NB?=
 =?utf-8?B?RkxaWnEzcHlFK1AyOURCL0dQOVQwOTJuOTdXYitWNk9vRUZ4TXNJWEE3TkVl?=
 =?utf-8?B?c0h1RHl4MDl6V1JrNHJNZ05ReWNXRXlVRHo4WEdiTDhXeThxK1Y1OEdCOE05?=
 =?utf-8?B?cHdZNmk3UDAwQWY2WlJZM2tvK3FneVMxQUExMExCQWc2TEp5UkU5VVF6bDVB?=
 =?utf-8?B?VkVvT0VFY2xtY2lDZkpWd3FEMHdQUXIxZEVmeUZJdm9xTDVxMmdFb1RWNWR6?=
 =?utf-8?B?SzhPbTRiWURnN2RONFp0ZnZ1QUQxVFdpWjhPcXV3RlF6TU83eFcyUzJFdFQ4?=
 =?utf-8?B?TG5MMVFlN1Q0Smh6Z1NDbG9uYXFHS1NQRUtia29pUEFtUG14ZXJKbnZNck15?=
 =?utf-8?B?ZzhNK2VZVExkWkh3azh3cGtFOWdhNzVEVUNIelo5MVpPdEVOZndjdTRCem9i?=
 =?utf-8?B?UmlmSElWWGRYTGJxVVkvdkJTOVpEa0hJN3V6YWM2Q3NkVFVLM090dDB5bXh4?=
 =?utf-8?B?Yy9xQlV1U1g1UTBTelM4bkRvUUM4OG15Z1FRTTdxbGI2eSs1SG9IMzA1c0RH?=
 =?utf-8?B?M1EvZXl0VkZDd2xySlhXbk1jSE9QTTNiMnI3UWd5VHFsRVVYTmpvejRsTWM1?=
 =?utf-8?B?MUY4ZVpBZHJXQlA5UWJXKzhabUdjc3VJTlFkM1dzNElod2tSRExwdWd2eXpT?=
 =?utf-8?B?dTRhckZHVjVON2RHSFBkdWFSZDJNVVYxcjBacSs2d1RIUGVWejFmSGNTeEli?=
 =?utf-8?B?Nk5lZWNGQkNwNWJVUGV2WTBDQmMwOWFnaTBDOXJXdEM5RXdNK2dIekFVQWRO?=
 =?utf-8?B?WlptRThRVEgxTnBZc2lZMFVTZ2tlN3Y3bXAweitTQzNOaWM5QzR4WmRKVEhs?=
 =?utf-8?B?eE9LQlN0Ujh4YjlKT2VUNi9xM1NsVDhmeWwwYkM0cEErRVpmRGFScFZKVklD?=
 =?utf-8?B?S1RnQmNVTXBTL2doSFgyOEJUS2RtZHZlUXZNVVJXOHJoM3pRYzhUWG9kQXBY?=
 =?utf-8?B?TjIyTXRncUxzMVFqQUZ6RGVmS3ZudVh1aExPSXEwZ1dlVjVyeSsxOGVzMkpH?=
 =?utf-8?B?bHREUEhXL1p1Y2RxTEtVRVdXRDJnWWc4QVpEcUxvMGRLak5YbHNmRnY1ZnF5?=
 =?utf-8?B?QlprYjlRcGZFVEtwVVRwQWhDb3lpb204U1l1ZEJwV0UyeGxmWkhNak9DNlpj?=
 =?utf-8?B?Uk9uaGtOVFVHMU1zUmttNjREOVpKdUdoeitNRTVjNXFkU2hRUC94aEVJcWp4?=
 =?utf-8?B?Z0RWNVg0em9Pb25UQzQ5U2tqa2w1R2I1bWF3STJ4UU1sMGloM0lEUzYzQUF5?=
 =?utf-8?B?UEp2NHBkanRKRlFldWNDR0NMM2RrVnZBVjU4NkI5VzN4Y0xBb2trYnI5RVM5?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aecdf8e6-0748-4150-c786-08dc64a2a7d6
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 21:08:14.4823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpVX3zPm87wbipmCmtOdI3uFpjHfxNcIcaIDhymOZm3jLxfrLT6HU73klXos5ZrhN2s9LVjtZaQ/5kFwYkhF9phv+Gzut4cbuuSCC6iGwmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6562
X-OriginatorOrg: intel.com



On 4/19/2024 10:13 AM, Michal Swiatkowski wrote:

> +/**
> + * ice_eswitch_cfg_vsi - configure VSI to work in slow-path
> + * @vsi: VSI structure of representee
> + * @mac: representee MAC

Can you fix the kdoc for this?

 > drivers/net/ethernet/intel/ice/ice_eswitch.c:140: warning: No 
description found for return value of 'ice_eswitch_cfg_vsi'

Thanks,
Tony

> + */
> +int ice_eswitch_cfg_vsi(struct ice_vsi *vsi, const u8 *mac)
> +{
> +	int err;
> +


