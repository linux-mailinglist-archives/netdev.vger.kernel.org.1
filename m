Return-Path: <netdev+bounces-303610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cXxVI0H3RGqw4AoAu9opvQ
	(envelope-from <netdev+bounces-303610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 13:17:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BFD6ECAC0
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 13:17:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=N8dl8lUk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303610-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303610-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB060307C70F
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 11:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88CF42E013;
	Wed,  1 Jul 2026 11:08:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE379426D16
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 11:08:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904125; cv=fail; b=XSE7jErG54Yuk3RhJd+1X0YOiXczQoE1pftB/+R/34QBaR+7ieT7SmbLckjLlRk8lMFG12+PrHOZFn26aEwIOTdjtezyWj+qyIc/ok3m5y419Hp/mtF1ByqL8C+X29E/hKwD63a0sHOF95lk231vNg6PSKubjf/aPOYhmTAgKNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904125; c=relaxed/simple;
	bh=fKaLCVe6Y1pcUH3AMcop5M/5kk1t2iAy61HUPvsZ8TI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YMfzFwu1B+WKizckONXKuzwMv/WZCEDb5CrrYiFYbqa2CtTX9tLO3TCRKnyfLstc9qrPM6MDoFZWhRi3Pb3T9+ep4xNZ71SrXXWvhuR5bp4bFVsCAmJH50wDOSXj80HgoBxNJS7X2JDvZXNp5I6nEkIlWeEs/FS/o42J++kswPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8dl8lUk; arc=fail smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782904124; x=1814440124;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fKaLCVe6Y1pcUH3AMcop5M/5kk1t2iAy61HUPvsZ8TI=;
  b=N8dl8lUkY3Vux3L0Rsc0osDOvCICyr/9NaR/W0MJqJ/AhULpbiCbJ/UR
   7ZSRZKJXwQ+V3RfFMkAOjO4fnk4HB4k1Tio+/+qhfKopL3dDJ1eM7gnPF
   QZH0PsYTIn+2m6vEopFSJL9XGFAG8jltnozw9YL3B2GW3zqP/a5m+DLyd
   nB+taRCSgZsJvx0H3YrJbGuoAYkprPPxePJiqD7Djdc33CK1kD6Ghxvjt
   7B/4Y94DLGdIY/wlXxTJFFckxWsKGnNpxkjvM1m65B9SKETLucpF6HQoO
   r2I2iXyafT7X5uOTuBxG+cD3Ai+LruoyN0tvrbFBD3DPS1edfm6XMo8dt
   Q==;
X-CSE-ConnectionGUID: s3G3YmrXQ/m2meQtRSHEwg==
X-CSE-MsgGUID: eXyUED4JRBqoaWFWI/GHFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="87546287"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="87546287"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 04:08:44 -0700
X-CSE-ConnectionGUID: GSuqByzIR0Ww7joUgbtBhA==
X-CSE-MsgGUID: z6So+sPFSwq7cNe5vtX43g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="248563632"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 04:08:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 04:08:43 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 04:08:43 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 04:08:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrSLE1mj66rqVw2dffMpzyFLthfmdRjpuf2O29tUhZYuh8E0vX4j6pe2dH5yn3uhE/KaSjLib1yH1EnpzbC8aC3pmcwI07LAL7lZCQ35ZrzCi9eNDmKrYcJDNpdKH/ukvLaV0f1PCOLzxOCjwl6MqZyTYcR3jGXShEFbh4EWXDDsUsUvi6V6NuDELbnU+BRktpM9v3VaPzdpJPpyE4mf8T463XfhI7SruujpzrD8jFMws5Qaq5BVbmM8Uf20ljmx7onsgEd4eJkHGTHyo+Yq/GlHYVetk/Sq53sRutfSL/8LEf4BMuCYhPRIe2cZ8L66vyVpsGk0Utz31EA/4SBKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JZ6V67V0I0kaUxJAh5bOvUUvGJA3EDHBUFAawb0ksM=;
 b=H5otueC9Jmj0opdQtn90k2FeyLrSCNepmSWhKI5y3P6g5MptNeG0U+Ibclk07Tt8VruycS8rQtTwRSlkc6yO/ov+O53BdrRdVkI3QhO0F+ddQ2ezA2t66SbjD8f+XKCs/se+uDv2QPNO2DFwAzGPIVGBLMmICQgmrZYfSEN5kr6cAII2RA03Ud4hmyVshE23ogALIPiYqBbW5lUC6MHKaXEPP4ApqDLfoRv25IED11GQw7m5txRYGPwwDYQlBLSM7G7tzbpdpPXdYCGCJEy297WyEEyz8/nRmJkzgAcUoZgLFDwVKOqoaPpe6BCmhjtAqsp72bbr9G5oakbI3yfUMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7323.namprd11.prod.outlook.com (2603:10b6:610:152::6)
 by DS0PR11MB7903.namprd11.prod.outlook.com (2603:10b6:8:f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 11:08:41 +0000
Received: from CH3PR11MB7323.namprd11.prod.outlook.com
 ([fe80::abb8:c470:36ca:e556]) by CH3PR11MB7323.namprd11.prod.outlook.com
 ([fe80::abb8:c470:36ca:e556%6]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 11:08:41 +0000
Message-ID: <dd1a53fe-4713-4e21-b854-cf6314915519@intel.com>
Date: Wed, 1 Jul 2026 13:08:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [TEST] intel: low timeout
To: Jakub Kicinski <kuba@kernel.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <leszek.pepiak@intel.com>
References: <20260627095400.3c3d9f80@kernel.org>
 <35ccefb4-a588-4556-87c0-ade880eaa8d6@intel.com>
 <20260630155022.27c9a271@kernel.org>
Content-Language: pl
From: "Pielech, Adrian" <adrian.pielech@intel.com>
In-Reply-To: <20260630155022.27c9a271@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2PEPF000008A8.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::648) To CH3PR11MB7323.namprd11.prod.outlook.com
 (2603:10b6:610:152::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7323:EE_|DS0PR11MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: bc51e24b-d62c-4ba0-8321-08ded7611bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: idoMCGz5VLdSIIGtaxl/cjhQ/r4ibklWibcvokFlEUJatv+MD+YmZlHvQsLTsGvJLjZ1I/0Pt1jQvLEMrFoo2Oo37ly5eztGnE/J0GxARNkqkPbWMc3SiZ8vc/Yfxs7FJVdK+B/6MLhqOFK6cdg0oCF74mEjWFkv/7ROYxvrf5DbolFE8Krx27KnfdKR9grf2zhrwVwjHBwfivzFWBizE7mGynCGsmKeHDHlxxUGHixmtAVtNcKAYDQnuUFFibN4tdEwbvtyLQHFus4fjgA+1PquBwQncrPN6nFWSyZYL0r3cbnqo6wHQ2bjqX6U9/ve7D/rmruHUGJRFyE+2DJFjUdq8FefX0RJJgjT+LT/3Y1b1KK8C2C6o2HgcD4F7SP8oP5PAoFJ7OvZFkegIWEUL8FHO9X46ksj7I7tP162AF2s5NtA7Er5Ht8OQZLH6DHBRYnaaRr8PzGKpUkfy+Yl0XlUfNnDk5A7TbwKIkNHj2TI3GQBtrMpGi1mF/vn3A4w72B+saE07TtdZP5PWXnn7O2EfS61UHcxqnFdCsBTnYxjnUObAGv0T8z0oOBIQJbgpB+vMji/gaEb4tq7ud8ju6H8Ouc0YmJA+qsgDnzWSLMlgqAoXIq0Laz0Yz4ChFmaebd3sZyrP0RWZY3MRUlEgi8N0UJPqXmIiUQBjXcTE+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7323.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFRTdEZBaklwODNVWFg4WHFZeTFpWDFFSElSN2VscElVTnArRzZQYmtna0d4?=
 =?utf-8?B?R3lkMng2ZXBrbmpLMU45NFU5L0FGclhNNk85R2QvMTNyUlJha3g0RkZ2MnZ4?=
 =?utf-8?B?OEFJVGwzTENFQmRsd2QxVGtRckdkbU13VFVmYnZWR1h4alNySDRReG13cURZ?=
 =?utf-8?B?S3NjR2ZIZGVoU09wZGtiS3dzcXJvTVhwM3k2cHNjSkRtYzI4UGdPNlUyTnpq?=
 =?utf-8?B?VUtWQkZCNUJFV2Q4cmNHYzIzNVBnbjhXUUpzT2tlamRCLzFDMHprYXhyc0lm?=
 =?utf-8?B?YzlKVTFzNEFaaVBFM1VsNVMrcGpNYnZ3ZGxEMEtYUjRKRWFFUkJCNXZTZUtr?=
 =?utf-8?B?WFNQOUFkRGdpc0pNRE5LY0pySVZaOUxmOUpTWE1CeVVNU3NhSEVmZVl0b1FE?=
 =?utf-8?B?Ty8yU09mLzdFbmR5WEszUmtQb3paK2dFZi9lNEgzaHFpK0NZZjFTc2hsNHIy?=
 =?utf-8?B?REw0c3FDY1NmMGRLNHdmWXZUL3ZFN1M3V0tTYTRkWHVTem90RURQSWVITVhr?=
 =?utf-8?B?RkQ3SFhYajVscmhkVHhXQVpqZk1IeHloeUYrbk05R3Y4Nlp3c0VyaVh1SER0?=
 =?utf-8?B?QnVHY1UwVmpxeG9SM2Zzem5WY2dIakphaUdKUStuMENSSmFWdWlqM3QrMGpq?=
 =?utf-8?B?d0owTW9jaHU0U29MOFlBbmppZGUwL0o3ZFVnMHZXR0NKTmdOaHRlcm1vdnBo?=
 =?utf-8?B?TElwMGFFU2k1ZWtxRjRPV3hsMzlSZU9ub2tldklxTnFPdWwzTHoyc0h6SFJx?=
 =?utf-8?B?MG0vYXRlWWJONVNqalE0b25YR1Rrdi9aOGRZSFNOT2dSaWdORFpxVTNtNVpK?=
 =?utf-8?B?S1VTVzFnU2pQT1BRS1EzWWlTRVVpV2xLRjlXZXBJRitnUnJ3cHgvMUUxZnJY?=
 =?utf-8?B?aWNYSVUyUDVpaHBBajMvbk93QVJqMSt1S3lFRHVoSEwveUtIK3FlbllYZ2N2?=
 =?utf-8?B?ZGdFQXR1VHpCUExHTWZndTU2ZXdsSGR4ODVFeG8yWElIcmZxVzJUWE5nNXZV?=
 =?utf-8?B?UW1qTzJmWm9YemphbHVlNXlQeHp2UUx3QkdoTjRQZ2RoTFcwUDA3NlZ2WTE1?=
 =?utf-8?B?eG8yMTFWRFZZRGpGNURjNTlEOWZGOUdNMHhRL0ppWVRUaGNsVEZaanF2QVBm?=
 =?utf-8?B?VzBVdm56eFdSME5VT253VlpVN0M3eHYrK3RIVldwL1pBYTM4c09CQmNsQUpw?=
 =?utf-8?B?d1pYeHlZZ1NNc3luSDJZcUVSR1M2V3R4bEplUWJFeE1wdklLMDVMUmlGY2My?=
 =?utf-8?B?STlueWkvZzdyUE8yeExDKytQT1NxbHlTb0hzUkpQN2dFWEhzZE4zb2hodHBN?=
 =?utf-8?B?a1hBSU5oQjVwSlRoSFhUOHRjK1UzOGxMTnVpUUdZU0EyNHkzVE5qWm1kNTRE?=
 =?utf-8?B?ZXlLVVo2SFpSRkd0cGFiUkJFNnhkUTB5VjFic2lXZFNwZ2U5K1FXaExGNUth?=
 =?utf-8?B?MUQzVVhRanJpbjFiYWFFK3M5SlNIeVRqN3lUV2JYMU9jdjBnUTZyc0hZSDBP?=
 =?utf-8?B?R2Q3Z01YOXZxSTYyanlSQmRQVFlWemlISmh6aU1Ib2JQVElwNGd0bWVpbml2?=
 =?utf-8?B?eXFUOWRBamwxb1MwbXBhbWNncnB1NnVzSmU0TkVtVGJ4TkY0UjBqdXdGZGI3?=
 =?utf-8?B?eE82eTJrUE51RTZNU3J2Q3JqK2dHcnNzVVlvM3M2SWV3c0dzeVdiSHR0RGFx?=
 =?utf-8?B?cTdnckFyQkFSZmlGWFAzM29JVWNaaFYrc0c3K1U0Q01DbmIwNWZ1S2xNam1I?=
 =?utf-8?B?U2NsNFd2a3J1dS8rNExwRWhjRldISVc3RHVpZlBjRlVZb3JkQ2V6T0MyRnls?=
 =?utf-8?B?clg3VFR4SWpMR1ZOeHE3YmNLbG5MVjdqUWhKRHlITmI2VGxoQ3RIOUtPR3Nj?=
 =?utf-8?B?dUdEUkV3Q3hzTmpWc01nNlBRU3VKYUxjMm5vMlhCSklOUHNNOG85OHZ4c1hC?=
 =?utf-8?B?YjQrSU9HQjkveERhWWJXM2RUK2pXYjFwZUhVSm9UL205Z29zRGQzT1dYWmVs?=
 =?utf-8?B?SzVoT0hXQzltNkVYRllOS1hBZU45NHAvMTBDREpkU1lSMDhBZ0VvcEI3eDUw?=
 =?utf-8?B?SzJhc2wwTHJBazhCb010QlY4NWI5VEQrZUd6NVYrd3NidTRiUjhiSHZuOVdU?=
 =?utf-8?B?VGtpVXd2T0ZUaDZIWERvcFc1aWo5bWp2aWN2K1VUV2Z0YjI0cUdveXhFbXdw?=
 =?utf-8?B?eWxDaUtOZ3JYdnlGVGcxd093TXV4UW9MemR1QVRjdE5oMElrZHRDbFlyMkZu?=
 =?utf-8?B?UjJBaEdQL2V0K2QrM0tSV1dnNjdNU1U0RTB1SmhCRDZjZmNkb0hCbEQ1RWwz?=
 =?utf-8?B?a2JjSklnTExFODRFK0t0dHFtMzBSNTBFM2JFK1BrdnJiUXMwOUpxZz09?=
X-Exchange-RoutingPolicyChecked: Z/zCO4FdFaVz8fQstSSj85QCmoVVUqm25+hGqVxebtfxfABU8vAdKO5kAG08h5Lj2UOfqrK0XVMWeC8tCS3DoazTwqp8QS7EGiPxmns7s4dQek6hB+RcElDq9KeFRUKClyfK8kJdsa3Tedz7s2DlFbuEDerPHfsIOQ9f9I4mI8sakDLE+BV4VBPuZQ9EBn3grAG4pPbLvO9M6uKKIgDdx23k4SKxe/XFEd7igYNe5NyFfg1DbSth/4hHuKQ410dNQ625/4NQHr07jgNDPR2sZ9vcvNXch7IWSOyiDtD+kVaGXVuUcc31DF/BHtXWLOp3TqOesI8li+R/1eFlEpX/JA==
X-MS-Exchange-CrossTenant-Network-Message-Id: bc51e24b-d62c-4ba0-8321-08ded7611bb6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7323.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 11:08:41.3045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2p4bu32YGdlWWunl98LqLgynSQL8nEcqMOxcdYF2R0VW14FiSX94RBHp9Sj8XaFKWV2/pfmJAOqn+HDQrov2JCAIz6gwCK2tt/MiEWR+Z8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7903
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-303610-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:przemyslaw.kitszel@intel.com,m:netdev@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:leszek.pepiak@intel.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[adrian.pielech@intel.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:mid,intel.com:url,intel.com:from_mime];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.pielech@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28BFD6ECAC0

On 7/1/2026 12:50 AM, Jakub Kicinski wrote:
> On Tue, 30 Jun 2026 14:56:02 +0200 Pielech, Adrian wrote:
>> On 6/27/2026 6:54 PM, Jakub Kicinski wrote:
>>> Hi!
>>>
>>> Some of the tests need more than 5min, could you increase the timeout
>>> in the runner to 10 or 15min? Looks like it's hard-killing tests right
>>> now after 2min:
>>>
>>> https://netdev-ci-results.intel.com/ice-results/net-next-hw-2026-06-27--16-00/ice-E810-XXV4/xdp.py/stdout
>>>
>>> which leaks config across tests:
>>>
>>> https://netdev-ci-results.intel.com/ice-results/net-next-hw-2026-06-27--16-00/ice-E810-XXV4/irq.py/stdout
>>>
>>> BTW the JSON reports the timed out tests as pass.
>>
>> Hi Jakub,
>>
>> I've increased timeout to 10 minutes per test run. It seems to help with
>> XDP tests score.
> 
> Great, thank you!
> 
>> I'll later take a look on default behavior of runner in case of timeouts.
> 
> default behavior == pass/fail status for the test?

Yes, pass/fail status selection. I've found the culprit and since next 
run timeouts should be reported as fail.

