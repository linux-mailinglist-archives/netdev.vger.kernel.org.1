Return-Path: <netdev+bounces-115394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A819462A8
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 19:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF381F2687B
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 17:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA80A1AE03D;
	Fri,  2 Aug 2024 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A41n0Kt/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCE61AE03E
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722620332; cv=fail; b=dGIJBhTsGWJImQFQy0o6tqlEsc2MiTZdHgep8YZnspCt3avDFy8JVHN+ubkTh7gjEQBxBaKy6M90Hn70iTywo/AsZb2aFxYKJ0OXI+R7wmrtUE2XPWfbgARcOY94PBatirBPlQjKF1fb2um7Ow5ioTkmt51yKZRd7H6ixfd3nsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722620332; c=relaxed/simple;
	bh=dhUbiVQs/quGxe7YTl292eMvFB+ZIDN433TGKxKkNbY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tNTQSjJLaYQ0lCkMnHqWqpYQ5e1aXlMbin8kBeQOTtNsRnehYwZD+jRLwUPOUOGmL4ekhaUyph1Wjyture01rPeFSoAVXm0SSw0lYl7DuyADyLJg046YXG2CvQILS9Dzcnot6Ch/YuM8N3TCHaV6ln+ec1+k3XHSjqy8V+Zoj2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A41n0Kt/; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722620330; x=1754156330;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dhUbiVQs/quGxe7YTl292eMvFB+ZIDN433TGKxKkNbY=;
  b=A41n0Kt/duvAKYxMdCwDgKlKsS4BZyK6lvtH9LHA9k8NGcH3uGWRyCf/
   IqgA2/kabnWZGMJbzlUbCpjj+vxDSZ8w/0bdZyG8uc9NaJuf+SiVHR2mI
   UgVWidzIagNcR5H2iZFf4sf0VueIQ8gdnmAcriOoUJWihNxurdFDMT54E
   6gkRE9rbHy5J5VLXNuu4xA5ALV2GBHaEXFdkqMiP6+2lUVPFojGIjBhGB
   I4hGkxCHH+7HhjXlJX/SblazkhFf2vU0s/9Nmaf1xFCuhEP1h/ygKoQJn
   K3j4QPFK1Qq5xTaoxKu7LLe/wZ0SdiAX5L4qPb7XBRETPdcXWSP8yFZ5M
   A==;
X-CSE-ConnectionGUID: xtLKalohQQuhH8sUwJZnGw==
X-CSE-MsgGUID: QwnCV0h5SomaCDKUf1mDJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20822897"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="20822897"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 10:38:50 -0700
X-CSE-ConnectionGUID: fRVOwzyRQPOX5EqzKNopTw==
X-CSE-MsgGUID: ig8k23nwTq2vsU75xy1CnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="60095459"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Aug 2024 10:38:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 10:38:48 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 10:38:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 2 Aug 2024 10:38:48 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 Aug 2024 10:38:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjDWfwCcNQBDFvX0ZDUDs5cBoVFHgllYQYRL8zIQaD6g4Fz7JDjo5TJzshvV9wxy8yCa4ZGihzl4op/4DrQDmV2Xkp+OFiwPs4udY0Nteg3DDREMd/y4BElI3g5XNMU/b/IYy5BxY8UW/2LSpMrMDFWqKbpyiGVRTwCGPRm9WhiFaQ0dimsHhrOfYXe7T2KVnND+TFP4HzHUOWwIo0+Jzeh9u2KFWW9JIwoNr3XXPGK3H4765Gmlezhbj69XZjx4Ok5QCNO+iWuzmndD8phuyD6RRHYz2MI3N/yOgKAGSgkvQmxFisiMa2O8SaPOFCzio7stp/2OBnu4zfulgcnEuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFtL/Nwio7hneus+ZTJtBvMd6GA5HOTak0miVgRV7LY=;
 b=y9ep/+M7XQx03IjfkpD3xzLVcZqIuMrpaGF43VV6GWR2ClOpELmZ29e5+lzEUi7F03edljm9Qh0cOXRU1CcW4vmUlPFzkoLyLBJWM9umhw7EM6qpJvR4QAjEhUlvlFcY19AbQnq3GMMg+m6431VWXYR1JY+68u/mGCKCgMklRutJRO7cF2qLtFt8/cNEzA8tgomd6HkVMUbMePDWwKr2y9ka2HD5quToOpN6DrGRA5ioAy9bzT73TRMw9Mmh3V4xdt9V0Gmgtk7RlPM8j1+JEOrJ/GaIZM0JP2q3Evm+lk4pS2l9daUIKU0NuJbsr1DJZ9UuN9pPiE6dZgIbDOeK/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SA2PR11MB4970.namprd11.prod.outlook.com (2603:10b6:806:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 17:38:40 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%2]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 17:38:39 +0000
Message-ID: <6e5c9fd5-7d03-f56b-a3b9-3896fbb898ba@intel.com>
Date: Fri, 2 Aug 2024 10:38:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next v2 00/15][pull request] ice: support devlink
 subfunction
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Jiri Pirko
	<jiri@resnulli.us>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, <jiri@nvidia.com>,
	<shayd@nvidia.com>, <wojciech.drewek@intel.com>, <horms@kernel.org>,
	<sridhar.samudrala@intel.com>, <mateusz.polchlopek@intel.com>,
	<kalesh-anakkur.purayil@broadcom.com>, <michal.kubiak@intel.com>,
	<pio.raczynski@gmail.com>, <przemyslaw.kitszel@intel.com>,
	<jacob.e.keller@intel.com>, <maciej.fijalkowski@intel.com>
References: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
 <ZqucmBWrGM1KWUbX@nanopsycho.orion> <ZqxqlP2EQiTY+JFc@mev-dev.igk.intel.com>
 <ZqyDNU3H4LSgkrqR@nanopsycho.orion> <ZqyMQPNZQYXPgiQL@mev-dev.igk.intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <ZqyMQPNZQYXPgiQL@mev-dev.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::47) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SA2PR11MB4970:EE_
X-MS-Office365-Filtering-Correlation-Id: a888e886-1e13-44a7-4852-08dcb319f184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEcxKzMrWnBGaUFCQ1djeGN1eXg2Sk43VnBGdlJmMWorMWpEdWdKOHU1OU5y?=
 =?utf-8?B?TFdKWkFkWUhTcHI3ZEdvYVNxTiszT0dzY0NoaEFmczdla2JBTk4wMjBYRENZ?=
 =?utf-8?B?V3cwT2xvUkYvN05Yblk1U2hOc0FHN2picityOE9qc1RvZXRscm5nTjB4aitO?=
 =?utf-8?B?MCtDOFV0WCt3MTluQ0ovdThWbTBmS0VJbnVPRXNCNnlVRWRnV0ZKc0ZvWDF2?=
 =?utf-8?B?ejRUT2U1czBBTHBBMzZOUE1aVjlFRFh3NnRrZDhYajVMNEFDTS84OHJHN2VV?=
 =?utf-8?B?TmVNNHhJdXBkWE5HcGRKbERiamZEVXNPNWxpODE4ZCt6RzJQak1TVjZ0ekxp?=
 =?utf-8?B?YUpQZmhONHNYVzZQUDl6R3ZYU3R5RWZGdkJtaE01d1ZIcnQ3cEtwTXFoNm5U?=
 =?utf-8?B?TityY0FmTytBYUZ6c1I3RnY4T2RCQ0tzNGFRcDVMcE1ad1JSRjFyTnIxMEpZ?=
 =?utf-8?B?KzFNM0d2QTZtMGx5K2ZURnJmc1VWQWRONmpiam13VGRRVS9SZnNobmNXbWp4?=
 =?utf-8?B?RFptUklLM1dYVXl6N290OGozZlc0SFd1NE1OYVBtSVJ0NjhVb2dvRkhFaUx2?=
 =?utf-8?B?cE4wWkZLZFMvcFpRTzByL3VEblNQSjlxa2lReDhMOFVVNWZvZlQ3aEtuVlFE?=
 =?utf-8?B?ZDlWZ1U0SjhWQW4xMWxyNzFENnd5MjdUb09GanhCNHN4d2NKZnYxMmhBNnNV?=
 =?utf-8?B?SklDUW9OYi9SNGhPV1RIMWltM0ViWk9uU2R5VXdxdC9mNlpTN3cxVld3VXB6?=
 =?utf-8?B?eElFVHhsbW0vQnBRejB0N1NHbVR0VVpka1Yyc3NDYk1XcW94RldpN2kvZ0ha?=
 =?utf-8?B?ZE5pbFgzTi9XMlcxWGlVYVVab3RjcDZZZHhsZFU1eEE3VTBWRjkyaVF6M0ts?=
 =?utf-8?B?ckVVK1NlNUgraXNnVnZJTzJqNDFGdU9CQkVqT1A1cWpWMmtGM3p5RGlGais0?=
 =?utf-8?B?N2N0bWVOU1M4Sk5pcDNBRDhIUHA3OXdzMTkrczZkMjdIMDJNdmEzWTUwVHNR?=
 =?utf-8?B?S3lXd0hZUkdzeWtHSXNTY1BNb0ZISzBob2p0MnBEYkZsKzdySEhlOGs1ZG52?=
 =?utf-8?B?ZzdFRW95bVFkWW5ERERrOWZmTlYyWDdUQ0pEcjBBdnI2anVmOUJMeXMrd3Zs?=
 =?utf-8?B?dC9wV2Z3aUVrM1dFeFpITFNhU0hycTBNMlQxZmg3R2Q4RWI1Rkl5VkpNb3BG?=
 =?utf-8?B?cHhHQnl4TG13Y2xVdXAzUGczWDBLQWwwRDU2NkwrZWlKMUZtczMyL1hucnFR?=
 =?utf-8?B?a011NEJZQVlaL2pBTmhPc2wvNXlUYXE2c0llbEdwQ3NEMTRuVGs0OTIrcWw5?=
 =?utf-8?B?RnhuaXlJUVlJOGJDbDdTeGltenB1MFl3M3pSaDY3clhEOUpvQ09tbWVwdkJ4?=
 =?utf-8?B?cWUrTVc5NnBCMW16NjN6ZWQybjBzUW5tL2Y0bjBML0JsMjB1V2cyMnVCQjZH?=
 =?utf-8?B?SGp4cW9seGxxWmxzMVc3Z3BwT2ZLZFI5ZVcva2tZTmExbFppTGRvck1Qem5w?=
 =?utf-8?B?MEJxcDIwaFluWmlzT1dHR0gvOFFHTFpRNzhhZEV6VWNGaXcyQnJEQjZBSjFm?=
 =?utf-8?B?UkFrVHMzbUhXWWppK3MzZlN4MTVWUUtCL2NJcmtodUZNcEcvYVVCaE5kSE5n?=
 =?utf-8?B?ZzFoTWRrZG5ad01NYnhhMkV1bzJUWFhvTzI5OWxIZzM4RGxTTzIycm4xOFk4?=
 =?utf-8?B?T0pSOXRCS3VrYmdnTU0raGt5eDIxTHhvdUZ3VzlNNkFEMjhhdDYwSXFtTzRh?=
 =?utf-8?Q?l7g2qRkv/MqIk2Tyd7JHDmHfgqfXcnIIAxFYQB4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWpyclFrYXNzL0w1czcxU0JqRWU0cXBUaFpWRUd3bVB3ZTlxZHpleEZOaWZR?=
 =?utf-8?B?ZUhDWXRvMFNYNjYvbkszUk5KdUp3dS85UUZZUjgxSHRmYTQxcFVTaUNxYjVX?=
 =?utf-8?B?Z2h2bFVUU2Fkd3ZpUkV1UTM3a3Bad3dPTXY3UVNVc3U2dkpWMkl6T1VzWVhW?=
 =?utf-8?B?WVZ4dGdaNmEzcFNyZDJncjhaM3VaOFZwVDV1S2lPWkQ1dnFTQk11Y3pjRS9U?=
 =?utf-8?B?WU9QbEZkYnhyOFBvRnZDS0U1ZVNLTmh0dGNBMWt1bnpCMFMzbVZrVFliMm51?=
 =?utf-8?B?dVdKS3VCaG1LME5OWDkvZDNYSHRsUEtrSTdjWlNaK1pYYTdkLzlkUlZoRTAz?=
 =?utf-8?B?RlVpditzcE56ZWV4Sms2eFlwbkFqTnU0aGNxTmZ0VzFMOUFzZGF3WFFXRVJa?=
 =?utf-8?B?VjdaSUJZY3ZGMTFQYTk1WCtMdjU4QSszTFRyT2xrYU1LVnJNRXExTGphK3Fv?=
 =?utf-8?B?bWZmZTVLdlhSWldtQUhJOVY3UHZBTmFmQ0ZJcmVZUmZpYm9oaFdUWWxFM0h4?=
 =?utf-8?B?ODlBbXlMM2tYMFRZZE1KZ3FiREw1MmMzQmd3cHFyUDhYYmF2b1FncmNESDFY?=
 =?utf-8?B?bldIVm5YQ1RuWFVlS0hsK29oSWh4eUlqSm1KQ2Urc0xCWlpVY3Juazh1K3RM?=
 =?utf-8?B?Mjk2SklGelpRUW5PRm1aazRhcTRVMzZJbmdyQ2JxSEhEM09SeElVMW1RS0ty?=
 =?utf-8?B?L3dzNXM3WHQ1LzlWZnozUnpIVUMrcmQ5cGhjbWpmV0xGZ2Y1V1ozR052VTNL?=
 =?utf-8?B?VE5NM3QrNmVlaWtZMWxEZDl0UTZsVitBUDNRRVhHMnRCTG56OHliL3RYTlF0?=
 =?utf-8?B?VXl5ekZqbXNBTkUwQ2JzWFdEWWUzZVFuM2FrTXBOeXQ5SFFXbnBiRGFob1BQ?=
 =?utf-8?B?alZEdXYwNFZDd0xBWlY4OTd2VGc5bnVpdVRTWW1zeTcyUVIvV3RqWU4xdkhF?=
 =?utf-8?B?TlhBWGZTaUE1YXdXaUc2Z2x4ZGVodnQ5NWxYVGtTZ05LY0czU3JOR01PSXg4?=
 =?utf-8?B?YStBejNxY2V0WEgyOTZiVUdqV2daV2xBNUFyK2R1and5WThmajVHYUFqclVK?=
 =?utf-8?B?STZUSWlPK2JwS1RyMzlzZjNDbkt0Zk9DR28yOTlEZTJJN2d3ZWJERTM5OVpS?=
 =?utf-8?B?bDlNdUhObmVjZ3pxTlpQWU8xNlNmNkswV3o0YVdnS0EyUE9kRFM2NkhVNHRN?=
 =?utf-8?B?RnRxQUZJZEN4aVBxc3p2L0Q5bzVwWUt4djR3SUZMVVk2VFp0cU5mQzNTM0Ux?=
 =?utf-8?B?RWJ2aWVXMTBkZ0l3TTZIVlZ0bXJ1a1dWSDhLL3dTQlcwL1NBRVNmYlVxS2xw?=
 =?utf-8?B?K1VSUHQybzdhOXBZK3N2ZTAwbllzVVE3NmNDU3lKWCtqcWxmNHdSUXY5bTYv?=
 =?utf-8?B?b3VoTEIvVXFYaWlhbVpkZWJGa1o4ZHEvbFZseXBOWHpLRzJ2ZzJKdElSdDlJ?=
 =?utf-8?B?ZStrLzJjTWdIbkllcXE5ME5EcU1yZW1BN1dvSVRlNFQwM05CN3JTY3FUbEdR?=
 =?utf-8?B?Mmd6cGI4Qm5zUVNtRXpBSTlnSWRtSzRCaW5aK1ZFNC9ibkNFblk0QzY5aHhG?=
 =?utf-8?B?MHRndDdoNzExNS9zM052R2xuVG1Ec1E4T0xWdktFKzNIYU51NWZvUk1OL3Bu?=
 =?utf-8?B?bERvZWpPTFNwSGVVZU9EMUNERzQ1Ym5IaDNHYmREMGFoMEpTZ1QrcnliODZ3?=
 =?utf-8?B?b2pvdGo3WFo0YU1lcERreks2SUFYYklvL05ReVNqY2YzRzdTcjlmTURtMC82?=
 =?utf-8?B?OXZkK2E0UDRvVkxDaGpVaGg0UHdqaEFvbDVucXZoMERHOUZma3VHR0VTa21L?=
 =?utf-8?B?WThHV3k1K2dZOEJCenFEc3g3cllUcEJVb0o3L00wMVhGeXBBb3dtMHJlWkpP?=
 =?utf-8?B?TkJ1Zklmc1RjdTh2WTJqdWY3RXlGWGx6b3h4Z0QxeUtjVmFhRmw4dDgvWlhw?=
 =?utf-8?B?bDAyK3poNUpEYWRDVFoyNVkzNkl3ZUpkWGVDRUtEZlYyelpuendCQklsdUpx?=
 =?utf-8?B?TGxLdlJvbDNXMTY5TEZqbTVLV1lDeWhvRGgvSUtKNHJtM2o2cDFqZG9zcVlF?=
 =?utf-8?B?QkhCb3o3SDVJeWh2UHZIRXpkY01NS2k1dkw5cEJaSHNYRVpQSE0vNGlXQUky?=
 =?utf-8?B?eTdMTzdoQStmYng3REdZbkdMNkJ1QTZRK2ZsSndodS9rdlR5UTNyVEZsaWhS?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a888e886-1e13-44a7-4852-08dcb319f184
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 17:38:38.9086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sb/DusfS6PIdtm303SXdVRJwdTdrlj2wXVR35C90oJVnpqf7zxdggppwlkRSD80osqfw9gClpysMyVCJu5f4nNHt8evYtzJiuRULpPo5CsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4970
X-OriginatorOrg: intel.com



On 8/2/2024 12:35 AM, Michal Swiatkowski wrote:
> On Fri, Aug 02, 2024 at 08:56:53AM +0200, Jiri Pirko wrote:
>> Fri, Aug 02, 2024 at 07:11:48AM CEST, michal.swiatkowski@linux.intel.com wrote:
>>> On Thu, Aug 01, 2024 at 04:32:56PM +0200, Jiri Pirko wrote:
>>>> Thu, Aug 01, 2024 at 12:10:11AM CEST, anthony.l.nguyen@intel.com wrote:
>>>>> Michal Swiatkowski says:
>>>>>
>>>>> Currently ice driver does not allow creating more than one networking
>>>>> device per physical function. The only way to have more hardware backed
>>>>> netdev is to use SR-IOV.
>>>>>
>>>>> Following patchset adds support for devlink port API. For each new
>>>>> pcisf type port, driver allocates new VSI, configures all resources
>>>>> needed, including dynamically MSIX vectors, program rules and registers
>>>>> new netdev.
>>>>>
>>>>> This series supports only one Tx/Rx queue pair per subfunction.
>>>>>
>>>>> Example commands:
>>>>> devlink port add pci/0000:31:00.1 flavour pcisf pfnum 1 sfnum 1000
>>>>> devlink port function set pci/0000:31:00.1/1 hw_addr 00:00:00:00:03:14
>>>>> devlink port function set pci/0000:31:00.1/1 state active
>>>>> devlink port function del pci/0000:31:00.1/1
>>>>>
>>>>> Make the port representor and eswitch code generic to support
>>>>> subfunction representor type.
>>>>>
>>>>> VSI configuration is slightly different between VF and SF. It needs to
>>>>> be reflected in the code.
>>>>> ---
>>>>> v2:
>>>>> - Add more recipients
>>>>>
>>>>> v1: https://lore.kernel.org/netdev/20240729223431.681842-1-anthony.l.nguyen@intel.com/
>>>>
>>>> I'm confused a bit. This is certainly not v2. I replied to couple
>>>> versions before. There is no changelog. Hard to track changes :/
>>>
>>> You can see all changes here:
>>> https://lore.kernel.org/netdev/20240606112503.1939759-1-michal.swiatkowski@linux.intel.com/
>>>
>>> This is pull request from Tony, no changes between it and version from
>>> iwl.
>>
>> Why the changelog can't be here too? It's still the same patchset, isn't
>> it?
>>
> 
> Correct it is the same patchset. I don't know, I though it is normal
> that PR is starting from v1, feels like it was always like that.
> Probably Tony is better person to ask about the process here.

The previous patches were 'iwl-next', when we send to 'net-next' we 
reset the versions since it's going to a new list.

Thanks,
Tony

