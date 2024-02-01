Return-Path: <netdev+bounces-68210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3351084622C
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 21:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F1AB296D7
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 20:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F871E481;
	Thu,  1 Feb 2024 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRAVZ2xv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2953D0A3;
	Thu,  1 Feb 2024 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706820797; cv=fail; b=YEx/jLamFJuIfoVq0cjH6YwtXhriWVSByKHoBXXyAPss42S9U4jYAlc25ofpZ580Vui3p6H2SDAu3OyPVEodOaM6uBQI4vA5a8HXpIaolPVA4bPBQcBj7dWssLjt7tKRorOqblq4W1GI8Ifw4XHTWzhV/JnnwzF5pyAnCLRAZTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706820797; c=relaxed/simple;
	bh=mqmhDJPq0iRJFnxENdhfqE99Dyo9dV3HmgIM8YJDDPA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JuE6NS3v63yRvTKCYLZzK7zpwzMy+dOcTwIVOecnMIXY72HqfElX4tdcyDYvWcvFfKEITPGuphooDv4T16W3PsYSsv+j14dYF5xibyxYQimFDNEybYFNY3yYEX7SYFgrf6UDbWCo2SKnsUMcAdiYVn3G+7MEZ0cWlBarOo/PQ/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRAVZ2xv; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706820795; x=1738356795;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mqmhDJPq0iRJFnxENdhfqE99Dyo9dV3HmgIM8YJDDPA=;
  b=LRAVZ2xv4chXNKxD4RhYAM/4c2yQPxv2hNDhSzSSzVNZ1Fc9hUS/tOQw
   ElATLMgKaUJDK7DDG06sBoVN5crSKjnbu3KljaG77132wjK6bqkA3bSKa
   ssu8fv9AVQvyN2J4rtZLfLsOcQIXR/F3iJnlXKNUy6JQckhdRkx+7K/VD
   ahlFGVrYvtWDKXEo9W2WVuoaqP45uj1WcphsdCPVkrkjh73ft8LK5sdYb
   3WnqWpMIWezjL6xEkTzlMn+Xsf6Lkh24YsmcBEJwawqPNRl1dPVz0kF3N
   JHYWBaw6gyc8cezknnNws0nCrJqMV4aG/U4jkx1keNnim9o6f7zfQYGLz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="407718436"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="407718436"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 12:53:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="23198525"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 12:53:14 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 12:53:14 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 12:53:13 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 12:53:13 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 12:53:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+C6XbIy+7zXKjhfgbwBiZHIeKwVmVBa7Qhm3fTOUZyv/nezOy4RaBugnV3+lLlu+VV6H/9YLSNOG2BWY9Ub4cw+KpYhTFcsB+cTjQrfOzMhVF55tPb+kUhrCPfS5zXlLFlAAKvKznUEkjjyHDUCRfteRQU6cztor/3JrprdlgLtaRpKOQ1koshDoicCr8fqHPcozGQlhfHyaXrX0rG3qOp6rfj09Wmeinq5F8EqrQZKM5cGNXDTZXHpSyEacgg7OHOgEqkjDstaSdcPSf+2GK5hKA7MFNfEVr+EDPr/Jt0jFLtuwyI5ST14vFfjHFAH+Vsh5v0LI40pUp0wL/YgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbUIhfblf24tuQg7l7H7aOKP/SKSlwehx7jAx6ixbUg=;
 b=e+c5PbntuhoSaxGEFTKMvSCYKpNTz8if3CWtPsglVSmHLCJMO2M9ANBcZggcS70DkjIZUJO3NlE+BrLgMBeQTNpu4s9t7LsOgX5I/IimRzc1Vm1FLZ9/DgX5eVLEwvf9x4fbsjWrnFouCnKih3HfNIACGJlUPtpJ2is2z/CfzsUPojkfbXs6fFy0tWiYrhF1FRUJqhoCZLZir1qvxAg+7bELBTN9XQ9yoPKoox0hx736PQap596wMsxrglawZNdfGdT1EUClbDFPdFEc25DxQYBeExrzPQRBky3G4IE14/ShSnWMqLDqlMvPKQephwFKshGvpWqaBbRmVc7WOi6Nsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7960.namprd11.prod.outlook.com (2603:10b6:8:fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Thu, 1 Feb
 2024 20:53:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7249.027; Thu, 1 Feb 2024
 20:53:11 +0000
Message-ID: <029065d6-faaf-4e58-ac06-4e11c2ded02c@intel.com>
Date: Thu, 1 Feb 2024 12:53:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 02/12] tools/net/ynl: Support sub-messages in
 nested attribute spaces
To: Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Breno Leitao
	<leitao@debian.org>, Jiri Pirko <jiri@resnulli.us>, Alessandro Marcolini
	<alessandromarcolini99@gmail.com>, <donald.hunter@redhat.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
 <20240123160538.172-3-donald.hunter@gmail.com>
 <20240123161804.3573953d@kernel.org> <m2ede7xeas.fsf@gmail.com>
 <20240124073228.0e939e5c@kernel.org> <m2ttn0w9fa.fsf@gmail.com>
 <20240126105055.2200dc36@kernel.org> <m2jznuwv7g.fsf@gmail.com>
 <20240129174220.65ac1755@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240129174220.65ac1755@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:303:b4::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb7c9b8-37f7-419c-a373-08dc2367cd28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VBjJoNwxkGbJC05Ue50+sgF3/8XvGMHsgPpZ/BQCqY43qtoLgQqMs4VYvzQWoNf6wiPj2ygFGeqyujv6z/8XTNwvId4Tamt3TeiEkmhJM4ZFrZk32gCKZnB1fq6AMGzjQSd8pPilpXJPHeTeF2ZRIL7fCaRgId2C4EUBYz3Wo3IEhQzobvMK0mGozx3zmil/qUTVok5gTd+fr6aO8rz9bB6dPFW6gBLY81yIkoQAOF89YzkqIGq1Bzgctos+d4a5ofUOzvAcZUMsl3x77qqiy63avvS8FEfTYPYuy4X/nxrTzopCgkY9ad+UxRxS+JYJ76aGX5YZOCecHAWxSmr2Pt0e0eU7jM0bNfWh7OGNNR9iudfcWt2Xp6+i7KpGW+vvaWhRUt2ShRc/MAcuFuXqZZ0dl+UFT4v17f2IPes8pbWQIzpYzBlN1jQDpbxgWITjWA7CpZr8VKKG25/KT/6dXEFKqJC4uqESdEekuXm3jFnjaFCxb0AujegMyP8lYtGhT1L6YdErA2i4i0VoRows8tuE+BmDoTRYCIYrdt+eAnD/NbOoRnlAO6dTWJ687wU3T0eFWURDJbwT5Oisvkq2qRbCeWJHtvLehZW+J8oiI4dBfvrH52oPEvn1dD11qgApasz6dQMBFfRHdw7IVP6uWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(83380400001)(36756003)(41300700001)(86362001)(31696002)(82960400001)(110136005)(6512007)(38100700002)(2616005)(26005)(2906002)(6506007)(66946007)(478600001)(66476007)(66556008)(316002)(6666004)(6486002)(53546011)(54906003)(4326008)(7416002)(5660300002)(15650500001)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkxrYW9LY1RmY28yTmxWYTZZZmpJM2gzNE5KQnRrZHQ0N2Z3UUZrd0I0TktF?=
 =?utf-8?B?OCtROCs1QmFieDJSME8wMFNNekdRVTRLWXV6eVF3SVE0ci9UY1NBQnAvNVFj?=
 =?utf-8?B?K01FWEkrbC9CL25wQ1JGdUllRzlNOEx1a2ZxalRaZGNsRUNOTXhFU0lsSkd3?=
 =?utf-8?B?TFJVUWU3L3BocEdKckVSTFF5QVRHZXNoVkhlV1VMVEVSVnpDelUwK1REZlFZ?=
 =?utf-8?B?YS9Md2JPWUZQS3F3YVZFRFllUEJpb25VMFBNYUR0TFROeTd6UFQrNDdsU1Rl?=
 =?utf-8?B?ekhOSDc4V1NCQlpCNENIdE1QdTdmK3RuUmtUenFXejA2V3Jwb2tvSXZ0YnR4?=
 =?utf-8?B?dkdpS1MrVUoyQzVCbWdMVERtd0d4ZjdaeG1OWEpwc3ZBakpwd3N3dllhOXIx?=
 =?utf-8?B?NFdZYXBIN1RJRXlCZ1lVOVVPUlFRWnFsSG1OUkRVMHhiNzNlTDdlWk9tbVox?=
 =?utf-8?B?N3dyV1VwN3BPeG52QW84UEg3TVR6djFxZ3BuUm5uOThOVjJsYWc1RDV1TTg0?=
 =?utf-8?B?d0Uxd1lRQ2FyeGR6elhhQUdrVWl1STNxSjcrME55bkJPWFJDd1FTNkJEdU5Z?=
 =?utf-8?B?Qm5nbndMbVhZdm5icVRNWGRzamtjRjk3aW00R1V2a3NiSnZIc0k5VkRmYmdY?=
 =?utf-8?B?cXlzVmozcWxDbnlhK3VZWU1tbnlPS3QrUWw5TjA2M3RRTVAxc1JCckpuRW5R?=
 =?utf-8?B?VTR3SzA5ZlVJSTVTYmdPQklVc2xBVld4K2NQVTBXNGRNOU1BVDdEUlJ4T0Zp?=
 =?utf-8?B?WFdTeUtQZ2xaWmMyMldRb1daZkV0OERSK3lRR3pmUUQ3d1lPOXpJbjJnb29H?=
 =?utf-8?B?bVNTb2FJN3pmeGJSaUhPZ0pWSDY0R1hlMWJmTnBJTUkxbDBzTHd5T01mVlJ3?=
 =?utf-8?B?NE1Xc1RnLzNsVVBXTTM1SnRwelcxbnFpaGozY29iZzF0L0paV3BLRGZDZjQr?=
 =?utf-8?B?MUJoang0b2dWV2lITWFhbnhHL091am5SQWNsOXpSQUphZTh0b1FKZXFpS2da?=
 =?utf-8?B?dkVycjhJOVVnYnM5UWlJdFJ2WmdxcHVSY1FGK0dDekJSMzhVd25IeXNVMG10?=
 =?utf-8?B?L0hOaisweTgzSlgzR0IwWXBUQzhtampqeks2N29RS2hGTDBzR0M1K3JZSUtx?=
 =?utf-8?B?YklNK0NodjFYdkw4SDFvWml5b09zaXBCdG1MQUNLUGRHc3MveWtwUnlzbUZt?=
 =?utf-8?B?bTdyU0tmMXBmNU1mZ2hSZnJaRDlIZS9Lamo1VE0yQTdKY0FscU4zOVZGMWI5?=
 =?utf-8?B?RlpnbEduRnViaXZNVkUva1dxa1N0dUd3NTR5WHJuaXMxRTdudFBnRjl0YWpV?=
 =?utf-8?B?czJDTSs3SUU5L3BzSUpYeXVkQlFwWWc5YStVaTZ6eWRZaUFXWGM3eDZET0Zq?=
 =?utf-8?B?TWZ1VDlMUjVDS09GeUhDOTR1VUowVFVOT1BUYlZpQU1xekt5UXlLdU45T2lM?=
 =?utf-8?B?bU55RUFKRUhxMjAxVVR0aTBOTG0rZWsveFZvODQzREQwNXRzejdudldLK25r?=
 =?utf-8?B?a0pKM2ExaGdzZktaRlNnZlg4OTY0TytCSUcra0FiMkxDMVF2VjV3OGZ6Rklv?=
 =?utf-8?B?RUNSUTNLTGRid3NDYVdKOHcxM3VuOXVURFdZM1NvdEVOdWVET09kRmw5YXNG?=
 =?utf-8?B?dkVEMXVZQzliSUh3VHJUMjhuWEpzTVU5L1ZZcW9xRkdIRExCSEM3WVVtd05r?=
 =?utf-8?B?MnVMTXJvUnBuNllXSHhTQzhVMG5HNUF5anpVd2dhVDZsNVoxa3NjeVAzeklW?=
 =?utf-8?B?SHJ1MjdhQXFPVEdBbWo1TXhKcnIweVpJZlpVNkFkazBrbHA0U3VUMXN2cm0w?=
 =?utf-8?B?aXdJeUpEajloS1RWYmF5aWR0b0FKNUZ3ZXE3SUNzSUgzSEg2cEFYWmhxKy9S?=
 =?utf-8?B?SXhrRTBGVE1xUlVkYjJPdklia3hBTFdaV3puT0Z1TmY4bnhoZytTVGFOVTVr?=
 =?utf-8?B?dW9Gb1NxVTdGcHZ0bHFQSFUzYnBOS2lvMisxdTJKSEgrZkJUUGNiNGRmZ0RD?=
 =?utf-8?B?V3lQYVd0V0l0TzVBSG4rY3prVjFpRm9ScG5HMFBRcndIdnhZKzVJYWwrdUw1?=
 =?utf-8?B?cUwxZ2RoczVoNFJUNkloV3dIYlVxa2cxUi9RcU1zZzdKb05oRUpiZUM1S1pE?=
 =?utf-8?B?V2hzbHVDVWNLMmpIVXlGK2Y1dXptWmxyczRrUWNTN2hhOVhOdFB4eHlRdW1y?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb7c9b8-37f7-419c-a373-08dc2367cd28
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 20:53:11.1571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Yr2HVVtUUhUYo2BN/udoUygjZb+ASAC1UOvx9ouBPBeZqJlCV+xbbQnBPy2P4JH8hNhSVx8n7m+aeS+3mg1OfRdHZypHIiNacsjVvkd7Kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7960
X-OriginatorOrg: intel.com



On 1/29/2024 5:42 PM, Jakub Kicinski wrote:
> Whether YNL specs should replace policy dumps completely (by building
> the YAML into the kernel, and exposing via sysfs like kheaders or btf)
>  - I'm not sure. I think I used policy dumps twice in my life. They
> are not all that useful, IMVHO...

Many older genetlink/netlink families don't have a super robust or
specific policy. For example, devlink has a single enum for all
attributes, and the policy is not specified per command. The policy
simply accepts all attributes for every command. This means that you
can't rely on policy to decide whether an attribute has meaning for a
given command.

Unfortunately, we can't really change this because it ultimately counts
as uAPI and we require that existing working functionality continues
working in the future. I personally find this too stringent as sending
such junk attributes requires someone going out of their way to write
the messages and add extra attributes. In most cases I think sane
users/software would rather be informed that they are sending data which
is not relevant.

However, I can understand the point that the userspace software
"worked", and we don't want to break existing applications just because
of a kernel upgrade.

The YNL spec does this by telling you at every layer of nesting which
set of attributes are allowed and with what values. Even if we can't
enforce this for older families its still useful information to report
in some manner.

In addition, the YNL spec is more readable than the policy dumps which
essentially require a separate tool to parse out everything and convert
to something useful.

