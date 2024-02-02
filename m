Return-Path: <netdev+bounces-68602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9148475DE
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7480F1C249CD
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0311914A4F2;
	Fri,  2 Feb 2024 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJj3/Nvt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E03D1487F0;
	Fri,  2 Feb 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893940; cv=fail; b=NrB9y23j/PtHhKmki+uqLz/pIM9I8clW5rJe9TEaNJfOZWDXyusb4CfVSK3rM0+zpEULrNlSfEue3LHam6afZT8A3hvRgQFN1FQKy4sHDGconY5WUl4CB85E1PrsQJuPep0N9xkQSHD9Kb/QxmeZyUdpdzODyLWm1tqFZDuiAy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893940; c=relaxed/simple;
	bh=PZ57ET5DFwSqaMHCE9T8uM6lH3ntejk3y6hfUBau3ew=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s6xYbcnmCRoMlKEOKVfPAgkcT4NWmzp8xtSuOnTTCpwwcd4kFLrlIY1JtZaYYT6TEj2mJVPka5ZVH6VKWDPlQyz8HCzIqdNpGgNT0T2GXuBH6ertROXhAlwBEfTBNtnMHpSNhWYWgOS8/A9vyUMd12sZmlfPdvb/JJUnfIDWpOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJj3/Nvt; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706893939; x=1738429939;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PZ57ET5DFwSqaMHCE9T8uM6lH3ntejk3y6hfUBau3ew=;
  b=YJj3/Nvt2lhsrSCu2pX7cIwgp8OG7kI5D5SEcvHVyfnyGG+aADY90ihu
   z1i2PUURct3hDAQ1kRT0/tWseHfpofrTm5djF9fG74SUR2p5FSQM/HQt4
   pAYwWdm89Yb8n0okkZy2n2EAeHIlNJOCnu+fIQUevY8NIccRPvZv0rJSV
   6PaIjL+ZEcdZudM4FSFB22CWB/ZboTM6MFmgxKJMieY9f+ako0swvL3ny
   +h/G/RACT8iVpwYdf2Nrrr4DvGLTe59+iAIOrFAnlx7fVEt5Xotwv4vPd
   kFznIm0yrd2URhpqCb55FFJ4nrJ7Xxvrtk9q2NRVAjPzonSKS0509ec3h
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="373780"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="373780"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 09:12:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="402793"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 09:12:18 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 09:12:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 09:12:17 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 09:12:17 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 09:12:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+NQyEAElSKSO0FOmub1TfDzA37+UuTKOmpGLuzHtr8ofVeGebOKoE84pe59CWDh+XlcDTPKDMjwyquN81MUzme0HrKLczh+g/3Cb2p9XzD7ZfAzoAJmuIV/nr4Zn1uohXA9mU5DkexJTS8tyl7/VVNnCvV7Meg7JmVB6k+J7UOd+zNZBmg6aM+QigMlNgA3mNs/eiaL1kfqC/SGG1g1mTWLN6M3amngNVhv1TsoT59tIbfSg/eTMZ0yMIzwkLP/nfqD7lBheHbkRXVR7gl06zLjhOZu3/Kr0TLap6duKfFBt4Z2gsI2hr7XpFj47hV2sEqiknJZUO76NyBE7YgpmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KGUC9/LZKsUlG7V4NrA1YJxDvd5uP4B+5WY8/RITJU=;
 b=bWH/4ZgP5dfkVq9XPEGQor9P+qENvA7XOq1nzHTT6Q/md7yHqm3eJUCb/QuC1ieJHIU/AXW1ZbiJS7KbHJfqXFfg/WDNjl6eyhL9AknHfvBZi/Sl2TUjSso33jRzuEsqoT00K1ddChwb30Am/iNXVFbgsyOfn2iylySwU4j/myNqoGdfNsCJB0UjMwLzu7yXX1NFc66ELtBdyqygOJmRxtYyrmEtej2LEVEMhoSsY+oI2vpl8TmBSf/OVRE/0+c9fNtX1+vjfMvkcq0a4HOjZoIherToXLBmaSrE+XrpeUE1prxQJdt0zj5zfyiMjRrh1tDDeVFZZT4gj3N1fPbcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB5211.namprd11.prod.outlook.com (2603:10b6:806:fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 2 Feb
 2024 17:12:14 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 17:12:14 +0000
Message-ID: <dbfb8730-a286-4e11-9e76-0b7821622f48@intel.com>
Date: Fri, 2 Feb 2024 09:12:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 02/12] tools/net/ynl: Support sub-messages in
 nested attribute spaces
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: Donald Hunter <donald.hunter@gmail.com>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, Breno Leitao <leitao@debian.org>, Jiri Pirko
	<jiri@resnulli.us>, Alessandro Marcolini <alessandromarcolini99@gmail.com>,
	<donald.hunter@redhat.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
 <20240123160538.172-3-donald.hunter@gmail.com>
 <20240123161804.3573953d@kernel.org> <m2ede7xeas.fsf@gmail.com>
 <20240124073228.0e939e5c@kernel.org> <m2ttn0w9fa.fsf@gmail.com>
 <20240126105055.2200dc36@kernel.org> <m2jznuwv7g.fsf@gmail.com>
 <20240129174220.65ac1755@kernel.org>
 <029065d6-faaf-4e58-ac06-4e11c2ded02c@intel.com>
 <20240201160416.0da06952@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240201160416.0da06952@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:303:b9::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b21a49-c0f4-4507-abd8-08dc24121a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pNxZSvh6sd7jFiAbAuyn7uVVSyD9DXStAVA9eToIecGboRFu0afOgk/IlQGpRl0lerp0fLkUrFzbrAMhX8DBcTO1BLzE9OjPhw0UuHqP5BvXo/P2qlUWxyB5/y+BwN2iwlHcBUZnRNcKuq25BgQHbLQnsSrIKmFIqdIsYPXR5aMlqYs+KTmp4Jtk4rGZksE4CQKn0KzMNvTpzjNKSjRCmSmA8eHAcVS62oknRVCNwQyGiL/bBfdLdxtBZfiW6G8/ELDQzaD6VJVw9qDDEDmRK8adxrM6tawkhuh1iLOoWJ3UAxuweOzQyj+3rYb4U4ZilmIrHR7/opG5VYp1atMMHgmKXl/v5yyHUbJwmLtaFFd9noFseHmTr4lrWB+IEvZDPkV8Oy4AFrwlDWD6s+RGSUVlUguK9MbJxWGf5ZuMnIY2ZedRqK1/Vg0CNECRLdP5Zeel8BYYhJBURXwOl8BIPSa6NurEBgdnTQFGFnHQsPUQHGbx37P2OZ7ViKRGnCX+8Ei6QlquHDVZ/gELTGFhJZHt9TiUqsMOymXtDQASF7oAXzyz4cS/M7vI+A7l6Rs6Jvwty+0s8lUdQ4u11oPm2QRgO7BjYSalbQNfAkbcn2Y80z5jbflWr7BrY5AXqTji589UHczFa/HLIWepgn84EQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(41300700001)(86362001)(31696002)(82960400001)(36756003)(38100700002)(53546011)(26005)(2616005)(6512007)(4744005)(6506007)(66946007)(8676002)(2906002)(66556008)(6666004)(66476007)(6486002)(316002)(478600001)(5660300002)(54906003)(4326008)(7416002)(8936002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm5vZEE0amwxeDZBcjRwNkVZMGZhdG1zZ3BRalR6YzU4TXV4WTZITVllSy9P?=
 =?utf-8?B?ckE2eEt5TWFhcmdVUFViVXB4dk9NTmdOeFVqMkFjeGFQSncwRHc4RFNlM3Bs?=
 =?utf-8?B?a2pjcVBWNWt3R2FsK041dDNmL2dHQUl2bm9rbnFLQ2xOL2VDL2RESTdFd05P?=
 =?utf-8?B?ME1BVWZkbjBVc1Fvay82ckNxSGI4SDc1WnNuSzlPRDV1MjhRZVVhUkRwc2cy?=
 =?utf-8?B?c2RJTE5FS04xUFNMN2RIWTEvT3AweHg3MTB6UHJPc3Q3WHVPa0h4NDBmR2xz?=
 =?utf-8?B?SDUrNENtQTNXYXdMZ0FGaGJHcllsWnNGbUU1UmQycENXQnVFcHpKbXhNWkRE?=
 =?utf-8?B?dVBzakNqWVBJa091STVvVHQyVUFyS0I1c3gxdGxYbThibWpzSUpvVzBLSzd2?=
 =?utf-8?B?U1JxaU9mS1UyN0Z0ZFlLU1dDUWZzOXQ3ckxLNXBFVFpmWFJ0ZFhQMXpLcWND?=
 =?utf-8?B?RXArRi91MGJQVHhsSnZsbXBnWnBURmxnNG13cElyQlpTNjVNM0JvWmlwYkcw?=
 =?utf-8?B?d3Q5VzZic2FBcUJqWUZTYVlUQ1lyT1RwOW9SWmdDdTVVSTIyVU5sM25KVDlq?=
 =?utf-8?B?aEp3alE1d0JCbjVPNk9WalgveXdFRVRISWJKYmRkanpQbExHVDNySlZrcWRB?=
 =?utf-8?B?NjczSk8zejNFSFo5NU0ySXpHSGo3bmZ5b0VnU0hHTmEyTVUxWmhSTzBINGFD?=
 =?utf-8?B?ejRkdUJJOGprMzlnWXovNHhjRUV1Y2xBQ29peWtpOWNUV2dMaFozOXV4b21P?=
 =?utf-8?B?WXhZRDFLMTlGeDdCN0tNTEd4MlJaeUx2aFhwbG1UUFZaV3JDcHNXbFhKN0hD?=
 =?utf-8?B?UndLamlYbXN3NFhKRG5hZThFVXBOMEZZU0JWSXNZNHFaUzFxSllCQkU5aFFT?=
 =?utf-8?B?cHJHQ3J5UWFaUDJUNDBKdG5QVDFKNG9qUHF3TlMrbmM0dXVGTDJhRHdpMldW?=
 =?utf-8?B?K0g5cjZWV3h1TWwyRUpqQ3BJTWpoZVlBMmhmYkZlSXUxT1NWRnJEL0hJZ1Yw?=
 =?utf-8?B?eGhKMGtHOXFoVGlta1VQOFlTc1B6YTlPYmJ4alN4US9ROStySC8yWVdMQ2JG?=
 =?utf-8?B?VFJZcFN1cEFtUXVncnMvdGEyaUQyWVNXeDZVcWpBcUZvNXB4RXV4WHJIN1dl?=
 =?utf-8?B?UzFKeDFFd3F6ZWNWN2JGWGxyUEg4cVJwYW5mWGt2YTV1ZmI4RzJKZ1JTQmpP?=
 =?utf-8?B?TTdnODlFTWthMXFYME9zSloyejlkbDJ1YUpoR0FzM0V0SFlxa1ZEV3pBMGgz?=
 =?utf-8?B?UCswWU5zSVpkTzM1a29JZG1HRDd0c1B2R2VldDFLTS9CblpjM3ora3k2TjBV?=
 =?utf-8?B?MDNSY2tCUk9sK3R0S3I1dENwRDJyQ0pMS1IvRURMcFRtYTFnQTZKTVEyckZk?=
 =?utf-8?B?UFJYMEErSEFaK3EzYzB0RVV1bXh3RnRndTZuUDFQMm9uWjNrSjRDeVdkdUV1?=
 =?utf-8?B?aWhOVzFCZ0JHZ3RHdjdDNWNzdXBwN29BZUVRNEdnc0FvK1RiTk9hbjA2QjEz?=
 =?utf-8?B?S1IyaFZ2SFZDS25Pa0tjR2wvbXl4NFk5dUFtRlNkSnFYVkpoVzZoSkdCYWI5?=
 =?utf-8?B?OTBHR2tBQjNWbVp4S3hCcDZjeEhkclZIY3JGalV2MTBOc2ZGMTRlS3gwSVlG?=
 =?utf-8?B?czhQUFRSTzA2b3d4MlRRQnN0cGJOa1VhTk5SSUpjNk4xZmRNOXZGZmF1Z1h3?=
 =?utf-8?B?bkpwQVVacGtGbytaN0cydG5aWHB2d2ZhK2tWSUlMOWs0Z0JSNmtEUXloWTRr?=
 =?utf-8?B?SW9GUHBCbHczdkcyUVIxOE5KenNvUVlTM3Q2VUN2dE52Lzc2NUE4QWF6ZzYw?=
 =?utf-8?B?elNxQmRpK1B6K2RYUEhtZ2VIQlVkYy91V3NUTTZNV20rays0N3ZTbWRpdnJy?=
 =?utf-8?B?VXgwQnhZaVg0cHl3UVlTMkUzbTRIREh2RjBQSXRyQzVTWlprVVBORys3citP?=
 =?utf-8?B?UFFLaW1JL2pUVUJ1VEZnWkJ2Y2FWdXYwWUNsQUFNemhaS0pudWhkTERnUVNL?=
 =?utf-8?B?aUpVSWVweGNsK29ISHhsdWNXeHBXaW5JV2ZKR0RnZy9IaVRwL0phUkE5VUlk?=
 =?utf-8?B?UU9PYXJjbEFHc045SUt6Ty9NOFFyMG55cXc4SStDM0JnNXdRak15WlBjUk8y?=
 =?utf-8?B?eGFaZjFOWktoQ1VYSU5QbSsvWXZmelowd2ZIUlluQkpIWXJueTk2bWtsUGIw?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b21a49-c0f4-4507-abd8-08dc24121a20
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 17:12:14.7184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSiFVIz0y56uAr582dky69uSHGbdQ3ozKT+MXNdHJ4dcQMTnJeAT5wffTfRjsJ71/X3N8KCbdtUb3sENlfNIMMAPvvIfJ3sOWQU7evU/ys8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5211
X-OriginatorOrg: intel.com



On 2/1/2024 4:04 PM, Jakub Kicinski wrote:
> On Thu, 1 Feb 2024 12:53:08 -0800 Jacob Keller wrote:
>> On 1/29/2024 5:42 PM, Jakub Kicinski wrote:
>>> Whether YNL specs should replace policy dumps completely (by building
>>> the YAML into the kernel, and exposing via sysfs like kheaders or btf)
>>>  - I'm not sure. I think I used policy dumps twice in my life. They
>>> are not all that useful, IMVHO...  
>>
>> Many older genetlink/netlink families don't have a super robust or
>> specific policy. For example, devlink has a single enum for all
>> attributes, and the policy is not specified per command. The policy
>> simply accepts all attributes for every command. This means that you
>> can't rely on policy to decide whether an attribute has meaning for a
>> given command.
> 
> FWIW Jiri converted devlink to use ynl policy generation. AFAIU it now
> only accepts what's used and nobody complained, yet, knock wood.
> 

Oh, I guess I missed that. That's awesome.

> Agreed on other points :)
> 

