Return-Path: <netdev+bounces-106445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF5691665D
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823C1283E7F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 11:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA8D14B964;
	Tue, 25 Jun 2024 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpuOr+mX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B342214B078
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315671; cv=fail; b=cbLLD8oroyXfLTub2/i5BUgFWQwOb1rBZOcnB7EmaX2QKLXaToVlb9BULuEBNO605VSM3TPAU7VQweX4OM19PdTQZXjQ9PDY3fCTdE8Vt7wjHyvkmsPN0VMPr7SwKRA/Dq6ReUnSzaQu2E5WlEv2cCgBMpDmAz+UqzOp0fufc+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315671; c=relaxed/simple;
	bh=am46jpSRQ+gsyJb9tz7WdJg+lRyj6BQjtXHA+FM0Uak=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oR2zYzkJjjnddyuqQcReGieMLiU8SV9eZ+6PvPk5hw6RD+jJtzWC/Lf6l6UYt+kGZw1DEMf/ezfhD1UoSQh3CPJu10qyV7beS+rjNIB7eHHxj1hhHWdyaUK+kOXbLcmz4xg/YR49UCGMrDEz6K96P6NEWgg7wGBJqcpEoeWskwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpuOr+mX; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719315668; x=1750851668;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=am46jpSRQ+gsyJb9tz7WdJg+lRyj6BQjtXHA+FM0Uak=;
  b=GpuOr+mXdWJvnCUycVHT2HQsqvbxqJ5Xdr031t+mGcD6hxXLReMHbACb
   RJknvClqVoKoqZgDoll0jD0SpwsqT5hIV5Q4Vkf7GKP4W/JBd6MK3BtOO
   aSCWavYcv80h4jV8fYXiYmz7bbQpbIbDAC1+O9iJmQ82H5ISmbrq0fm8F
   1UzJIfMtnlMFhDGtLzFpxXxhjNPOaYshHAND5WCmkXM+HjvUgBwg1dxfn
   neLcipNqA/mvdgrYVrvShTdtWcA8qXMCyeGYMLOvSE1hQ387t/wSSpIPQ
   WXMG4zYlu+W/ndEmIGbxOiHCt7qHAUHEOmWp0ySLL6qbzs/31Uh6iMhoC
   A==;
X-CSE-ConnectionGUID: SYNIQFBITHiF89JZ9i3uww==
X-CSE-MsgGUID: 44/jfJa6QqiTPbwVoBLflA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="26916664"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="26916664"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 04:41:07 -0700
X-CSE-ConnectionGUID: zLkc2X2dQACHRrSsG69x/g==
X-CSE-MsgGUID: IuE70y+7SpmnOP7o3uUqbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="74822942"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 04:41:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 04:41:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 04:41:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 04:41:05 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 04:41:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqGDLElxYulrWMNchSf0ndl10tWUy55BVVMtCfJoqMhLoZQNUUUTA35Y3tRyMHpvojhRrgspDNprnVSoqoG67i6cef6CG+lEK7DUtJH/2px6KbKEHuzL3SKRJezxgIVjhTVLBAlu+NO//TMCdWHqbDyMdExumSy0BCflcy5ez5RUorm7NbZp+4troeRgfddLCVsc7kEaU5u8pY7tCWbMQRjtWyR8/vtUhVoTS8SRuVBPzXLIPwwEqsOj2Va1hmvQkXZIG1OvgcUPtwqNLi0XUST/6TMn6o0GOQFToYUnrfUEeWZpZ/aXp1qCQCkQAB6q3/epmDBIyzTJ/T8/Pusl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ki1mA3QenyFMzcrk+kbscueiFfkS4PTr/R1WkYpQeHE=;
 b=PBoZR0/eum7Tnitwz/mpk0u1vqqmovxJeB4YvnF/7jg4xiDqj14VB+bY8Ksp7vxNT5A1ZZ8dd11qkQw9pwXNwAAyoTxnG0Dtfo+nKuw0OkFLAnFNKgjmHdx5oOSKWKZU7xZjrWyARYLdcc7T4jVG0ULAdZsnZvIQXg/Ii7Z4aG1eE8+dosJDoRlm+uCfs+tWZ2NyAv0GOVFXahyx2QpbaU6xUkXRGGfrvzlH5lVpRCtCq/b5oLxcVdzCITKyOq+Fvj/Wx9I/5Lt9Z9pb3xeINrdOUXoz2DVieJ5oXsjT4ehownMBMd4ICoN631szQEC+usAbhDQaOL2EskbqAvwSFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB7303.namprd11.prod.outlook.com (2603:10b6:8:108::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 11:41:03 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 11:41:03 +0000
Message-ID: <08f3db6b-6781-435c-bddb-04a594a2e617@intel.com>
Date: Tue, 25 Jun 2024 13:40:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: txgbe: fix MSI and INTx interrupts
To: Jiawen Wu <jiawenwu@trustnetic.com>
CC: <mengyuanlou@net-swift.com>, <duanqiangwen@net-swift.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <andrew@lunn.ch>,
	<netdev@vger.kernel.org>
References: <20240621080951.14368-1-jiawenwu@trustnetic.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240621080951.14368-1-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0061.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::38) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: a2656e70-5d2d-43ad-a992-08dc950bb18c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eENEZWJSeFlhTkgwUWxROUd5UzZrZFcrS3k2RnpxUFhBTm9jWmdaSVJQUDFZ?=
 =?utf-8?B?bk1nbkZMRUREUmpnbGN5RmljWXRLbHUwRE5SVUZUN1dIM2RrSURHMzNMTVB5?=
 =?utf-8?B?VVM1L01TdnY3dEFqc0hvT3BFOGt5elV4OEtiM0g4UVQyc0lXT25GaHJoZVEv?=
 =?utf-8?B?MFRFY0kzOTdLRVFwRXNZb016akdKUjFQOWRZZlBhWmg5RUFoRmFIcnFGdWVp?=
 =?utf-8?B?OHk0UVhmVEJSVzk4REVFNWpsNE5qSlhXTTdMeUE1bnZoQW5mR3Nsd3ZkUmd5?=
 =?utf-8?B?TTYrZFFLZjJrb25FYXZGRFducHA3NDFrY1NsTVpkZ3B3WFZwNFpMZ3h3dkZS?=
 =?utf-8?B?eFFyMEMzK3g5SDFuS2hRNUQ5VWduOWUxOW82c3RJczVqQ0pHb0t1dXU5Y3JS?=
 =?utf-8?B?aE54a1RFengvbms4SVI0QVN2VU1jNXd3K2ZHVTg3YkZZczZuZUZ0QzhzZld6?=
 =?utf-8?B?VmxlanhmUjZTRVBsbC82TGZlWGw1cVRVWUdrOE1FNm40R0FGR3NpNUpNY2s3?=
 =?utf-8?B?NU9wWUhqTUxzb0ZoTHFMa1M0R1gzSTN2Nmt1VjJXQncvTHZLWWdSM05xd2dG?=
 =?utf-8?B?QUVLM1NabTFXVklBcC9QUHdMaysrdUczRGQxMjF3blNkK3BqZ0VjVUdaSTNx?=
 =?utf-8?B?Mnd3Zit6MmJZM2h6aUIyMGg1L3ZCUVVLYUhPN0NiZkMrV0pwNmJzaU1HK2tr?=
 =?utf-8?B?bjk1dDNjTFh0WkFiTUFIM1BGUlZqUXQyeGI2eDJFbzFKVUsySzc5Qkp3MTFF?=
 =?utf-8?B?N3lFWCtIa1pmU1BLTUZKQ3V6QW9YckJ5WFpmUndZcU1UanNsS3FibnhlRDF3?=
 =?utf-8?B?YTZab0xmNy9mdkxQWEQ3bFpWV3EvVFBtQWdXUGVSdUJpYzhoUWIzMjc0WXU5?=
 =?utf-8?B?bjJnOStLT2FCd0dwL2dKMmE0OFNkS3ZudTh2T1J5SGxOekEvMlcyWiszbDA0?=
 =?utf-8?B?YmpFd1ZaTFV6K3VyaEYxQWhMOWZtaC9wWWZSRnVsYXBhR1hYUHdYVzNFTDZz?=
 =?utf-8?B?VUI1WFA1TDduZ3dtK1JWVGJZcVdpd2NiSVgyOWQxUldEYXJZWGZwbitRR0NB?=
 =?utf-8?B?TVRTbEJOR3N1VUZneCs1VTZ6MUJYVTA1dDBCN2xNWk42Y3QxZ2g1OXNXQ2cy?=
 =?utf-8?B?cUFmYnRGWC9zR0VkQXdsckZiYVZJcVpzSFRpa290emJaZDEvSW1seFZrRURq?=
 =?utf-8?B?SHJLVm0zY05yNVBxWEJJbGZ2NllpS3dORllGTGR0WXM5NmVTZUEyYTJCWjds?=
 =?utf-8?B?WEhhNE9qd0ZDTVpsRG02MGhFait5NGhQQjlpZGF4RnpFOW9SdENyaW9mWC85?=
 =?utf-8?B?U0tjZkgrL05HWU0xbFFJUG9wUWI4aXpHSGdXZjZHNXZXQkxJYVpUVTAwMzJr?=
 =?utf-8?B?MkljUDBlT1VVT3hzclBSMTBmVmRNVW5mMHd5VzRLRDhJcGsyQ1R3L05xYkxT?=
 =?utf-8?B?d0huMnVIcGtXbWs4ZTZWMzRMZkw0a29tYzY5OHFhZUxoRnoxc2JMWjhncmN6?=
 =?utf-8?B?cVpscGl5QTdJYjErUnowY2NKNGJWK0ZIYkEwSXFGdVhMNTJPOGhDYXdhVWxy?=
 =?utf-8?B?RXpDMHg2cFYwaWRoRkJrVXNybm54b3h0QytDUzgzTTEzcndoeGpBR2pDYi90?=
 =?utf-8?B?S3puZkl2SkRsVFVUMEkzZG0zMGRsbDB6NTdFNTluMEM3QUs5SmdBbW5XNXU3?=
 =?utf-8?B?N2NlQVJPeE80Ymd1THNOVmtJbkI1MklwSGV4dGJwZEEwZWJ4VFJCNzVOK2tQ?=
 =?utf-8?Q?E8W+VJ9aKfGDoDTakYZz382VCYdi9t/sh7RYXqU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmlnT2ZjN3Z1SXBxT2pMR3NoVDlVNE5nMW1MZmx4bkYrZ0FKN3huRnVOaW81?=
 =?utf-8?B?WGFrZkZ2UnpZR1RrTTg0bzlzL1ptb1l4bWNpYlZqUmxxOHVqUGtZVngrWDNa?=
 =?utf-8?B?VzY5SW5ibWgxWk1hS1hjL3NiQzR6UWQ1RVRDcHJoU0ZsckFMenAyQmhQVFVN?=
 =?utf-8?B?dGpKN3Y0QU43K01OcXZHU3hERUdTOEtWMnJxQ1hORjJOUkhIR0N4WmRGcXlR?=
 =?utf-8?B?a21FalgxRmFySzE2RmN6R1lROTRDcWh3SVVueDIyYWFua0xLZWx4VTRsUmwv?=
 =?utf-8?B?dEJBUnB2MFNQMDYvcVFVUXM0cHo4VDl5THk3bkwvRDZ2d2hjYmpnZVducERM?=
 =?utf-8?B?QzhhdGk5ZnlvdnhHK2Jjc1pYQVQ2ZXZ1dUR0bFkzMHNDRU9xajZ6cU1TYjdM?=
 =?utf-8?B?WHZuaWUzb0s2OU9HS2VEL2pDU1R2cTZ0dUVSUkF4NGRWdFJad3ZKVzlvdTdY?=
 =?utf-8?B?V00rVkFYTDNSbFl6V3AwQ2VSVUJLaytoYUpuTVl3M1ZGN29JK2gwTHEycGI5?=
 =?utf-8?B?SjlGKy81MlYvVkx2MTlUN0dTOHc0QTZxcGJEN1dwWjJoVG53Mkc2ek1FYVNN?=
 =?utf-8?B?RGMxRXdpSjhHRW83d3ZTblN6TnRoQUtuVUlyRldkdEtaU0thNHJPS1AvL0E0?=
 =?utf-8?B?MVQ5dllEU1ROQWJENmZhb0c0WVYzNkpnT1dnTjZHdkVkWXRBcVMwZG1TbjNy?=
 =?utf-8?B?Nkg2MXZGVzBxNVR3VDVjVTRYNzVjcmVuZjczYk1tQ2JDUU1JRmZkUGxWRmdY?=
 =?utf-8?B?UFFJUCtKdkVaTVRySWZUTnQ3WmJ3WmJXS251dWt1cXJGbmVaY3VVUDlIQ3Iv?=
 =?utf-8?B?Mkg0aUl4alZSZk9VSmhub0ViYWdlbVJGSlNrUkRFaDJiYTRpSjNqQzlXNDNZ?=
 =?utf-8?B?WXJVaEYxYk5LVThqNkxadThTZGZLTFYyZW9LYnIwdkEwb040c1g1SzNsNFBP?=
 =?utf-8?B?ak9nNmJramVXMkZiUHVZNHRSMHVRQVRoV3phandORk51Tk1qV0wvYTBEUlk4?=
 =?utf-8?B?SGxMUlN6U3RtNGFWOW4xTWp4UlBLS24yUldua3hYcWZMYjZqd1g3MmgyK3RP?=
 =?utf-8?B?ZWdVK3BNVXJwZnJKUXZENmttUTFpSXNxc0tRMGN4bGNia2MrNVFpZzR0ZzVT?=
 =?utf-8?B?U1hHd25iY1B6K1Aya0pabUQxQ1dZS2E3bGY1MjB0U05RM0Z2U0dUaTNBSW1t?=
 =?utf-8?B?bFlQWXcxbC95Z3ZZby9rSURidHQyUkswcDZ0T1JJTkxZeGNLZnRCdngxKzk3?=
 =?utf-8?B?ZjNWUDEydGR6UksxRWc3bXJmckdrTlJ4N216VmNDc3lKRWdrcVNUWjRiWmdi?=
 =?utf-8?B?Wk9nL0Q3MEg1ejVzaXJPVUN0K2tRemZITkxSZWVuZ05ZdjhFWTdNWnQ4N1or?=
 =?utf-8?B?VVp1aU9weEdUVDNLVHZCQTF0dThrcTZXRzF1b0EyZWxIdU13d054bUtKSERo?=
 =?utf-8?B?U1VRV2MvRlZGS3V6OC9ZcklYbjJITE9tczNma0Rva0JTNGFIcXhOU2lZdThF?=
 =?utf-8?B?Smt5MWsxZ3Z0T3hOcnJXV0FpbjRPSVdBRHN4b0JOSWorVFlJUW9XcnBnRVdE?=
 =?utf-8?B?Y3oxK2tpN3J2THFLUjJrblFmeWZvWWVMRTdZZThoNmw1c1IxYnRCb3VtYlkw?=
 =?utf-8?B?VzhnOXJ6QW9abUIxYzRlb3RLV29zZTdMY3dDQjZWSzc3RUduUWd0dVA5ZkdR?=
 =?utf-8?B?Q0d0TmM1RStrMEZFQjV4TDJmWm44Q3d0ZFNMeUtFMGN2QXJxYkFWVDJxYWpE?=
 =?utf-8?B?UEZ4akVkVk1iaVdDWTlMU0pFK3Ztdy9NM2VUWm5DV1dtQlBpTkRpVHdtQXhE?=
 =?utf-8?B?Q1Qya3FOdkx3NHZ2K2NrVVg2RkF5NDhWRTVuLzZxakYwT2dOb1V1MS8wOG9h?=
 =?utf-8?B?dXZ5UklWb0JnZXRJTThTbDY4N3ZXYWVFSXJZYzhiWWNnZVBzZFd0RkRmTkwr?=
 =?utf-8?B?NCtsNkxYYUsxSzlqQ3owUDhFUlJNTmZPVXdxbWZsVWxsMFYvbitLUytwV1Fy?=
 =?utf-8?B?bU1WellkYjZpd0QrUXNNdUNWZUs1RS91eDM4aklCMVpZUkIrWnNBVGpvNUla?=
 =?utf-8?B?YmxoaGZ1dzYxbHN3U1NOajhyQkVWR2dXVW5BNkZlN2JLRW1UQUE0bkVuRnND?=
 =?utf-8?B?cXdUd1FLR3VHWml2ZWhRTE9BSUpKZUVEUUtRQnRpdG91OE9keWpnczdTSlhL?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2656e70-5d2d-43ad-a992-08dc950bb18c
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 11:41:03.7779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aiK+89LROjcKEFWpa7GFVhbTx+ZY7k+4A2zXbLd4WP6YYQzCas3lTcvWIfw+BnTKHS1YZPNPXuAJqm2VGwQ2+hzMeuq/rK6LPWH+3bABnXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7303
X-OriginatorOrg: intel.com

On 6/21/24 10:09, Jiawen Wu wrote:
> When using MSI or INTx interrupts, request_irq() for pdev->irq will
> conflict with request_threaded_irq() for txgbe->misc.irq, to cause
> system crash.
> 
> Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>   drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  13 +-
>   .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 122 +++++++-----------
>   .../net/ethernet/wangxun/txgbe/txgbe_irq.h    |   2 +-
>   .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   3 +-
>   4 files changed, 59 insertions(+), 81 deletions(-)
> 

Please split into two commits (by prepending one commit that will just
move/rename function/s) to avoid inflating the diff of the actual fix.
This will ease the review process.

[...]

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> index b3e3605d1edb..15e0fef02aac 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
> @@ -27,57 +27,19 @@ void txgbe_irq_enable(struct wx *wx, bool queues)
>   }
>   
>   /**
> - * txgbe_intr - msi/legacy mode Interrupt Handler
> - * @irq: interrupt number
> - * @data: pointer to a network interface device structure
> - **/
> -static irqreturn_t txgbe_intr(int __always_unused irq, void *data)
> -{
> -	struct wx_q_vector *q_vector;
> -	struct wx *wx  = data;
> -	struct pci_dev *pdev;
> -	u32 eicr;
> -
> -	q_vector = wx->q_vector[0];
> -	pdev = wx->pdev;
> -
> -	eicr = wx_misc_isb(wx, WX_ISB_VEC0);
> -	if (!eicr) {
> -		/* shared interrupt alert!
> -		 * the interrupt that we masked before the ICR read.
> -		 */
> -		if (netif_running(wx->netdev))
> -			txgbe_irq_enable(wx, true);
> -		return IRQ_NONE;        /* Not our interrupt */
> -	}
> -	wx->isb_mem[WX_ISB_VEC0] = 0;
> -	if (!(pdev->msi_enabled))
> -		wr32(wx, WX_PX_INTA, 1);
> -
> -	wx->isb_mem[WX_ISB_MISC] = 0;
> -	/* would disable interrupts here but it is auto disabled */
> -	napi_schedule_irqoff(&q_vector->napi);
> -
> -	/* re-enable link(maybe) and non-queue interrupts, no flush.
> -	 * txgbe_poll will re-enable the queue interrupts
> -	 */
> -	if (netif_running(wx->netdev))
> -		txgbe_irq_enable(wx, false);
> -
> -	return IRQ_HANDLED;
> -}
> -

[...]

> -
>   static int txgbe_request_gpio_irq(struct txgbe *txgbe)
>   {
>   	txgbe->gpio_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_GPIO);
> @@ -177,6 +111,36 @@ static const struct irq_domain_ops txgbe_misc_irq_domain_ops = {
>   };
>   
>   static irqreturn_t txgbe_misc_irq_handle(int irq, void *data)
> +{
> +	struct wx_q_vector *q_vector;
> +	struct txgbe *txgbe = data;
> +	struct wx *wx = txgbe->wx;
> +	u32 eicr;
> +
> +	if (wx->pdev->msix_enabled)
> +		return IRQ_WAKE_THREAD;
> +
> +	eicr = wx_misc_isb(wx, WX_ISB_VEC0);
> +	if (!eicr) {
> +		/* shared interrupt alert!
> +		 * the interrupt that we masked before the ICR read.
> +		 */
> +		if (netif_running(wx->netdev))
> +			txgbe_irq_enable(wx, true);
> +		return IRQ_NONE;        /* Not our interrupt */
> +	}
> +	wx->isb_mem[WX_ISB_VEC0] = 0;
> +	if (!(wx->pdev->msi_enabled))
> +		wr32(wx, WX_PX_INTA, 1);
> +
> +	/* would disable interrupts here but it is auto disabled */
> +	q_vector = wx->q_vector[0];
> +	napi_schedule_irqoff(&q_vector->napi);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +

[...]

