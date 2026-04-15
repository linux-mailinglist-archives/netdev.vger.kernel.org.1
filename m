Return-Path: <netdev+bounces-278697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AdYG2FJ32mFRQAAu9opvQ
	(envelope-from <netdev+bounces-278697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:16:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6E8401CF7
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33A7530125FD
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC24D3A5435;
	Wed, 15 Apr 2026 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3o+gqqd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B580391E41;
	Wed, 15 Apr 2026 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776240909; cv=fail; b=ngFEnVONrN7KVkVrR6ajPMUZZu6/nx2ACPgnNl7UWAZOWbP+UEQlQlPsP7TimOvw0YhZqWzDmNfwkaT3SEuREuSGtwq1MjpuZV+16W9rvqZWEyNxClDGS34e72HH5UYQ2nqsZZh3JHZvf/2EXGggPlw1VIg0WZmNlXJ3ds+z3ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776240909; c=relaxed/simple;
	bh=mHfRt0OUa0FSw2gOWAv8/Pw9edW5sx9ZZK53uuGhcCU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jcF7rqY4jkmE5NB4hFV26Zq6twdqI9J63bR3/Uj5otZXKto7eU+8+4/IOcHfNLX1vvDbmr0yetYzlvvr5QCIbH0/QRYctiJoWI0Xd6YFDIgCZ527IiXNM9ssK2HPkDnQwdRqi4yPXcgIh/+xth6J/xlGcvs3HFwR+Pj/6t9+Ogk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3o+gqqd; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776240907; x=1807776907;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mHfRt0OUa0FSw2gOWAv8/Pw9edW5sx9ZZK53uuGhcCU=;
  b=Z3o+gqqdMm7gvzv6QRI7yjh9GCFVOkpOJ80mGhDlxA8j/PcM6C/3cmxM
   t81fDDj/OOBz+5Q6Utj4wEwKEy8ZkM3cvQl8ZekaLINcsBcrTCQrmetv2
   BxDjFKsqQrdGUInkjmQsMbGE3J4DiS7s2RFvkMEJSmq/trAmW0fA919Xy
   b6HncYVSMATCTNJegAwRzUMMtVdosW6ofU3mWXOf31bBfXcs0T7oPSngZ
   1bQJ2tMQ8yzO6ONR0aGJ5R854k20sfvbqox7MSkRdRINxrVEqwfZ26nye
   jzu7PvkEgNW9UQukgOBjiTRzHYf7LOMQtXl7lfjI8A2393KC3Hgv/npO7
   g==;
X-CSE-ConnectionGUID: OFBsOQNZTLKgjs/Afk9mRA==
X-CSE-MsgGUID: ral0XFxtShOKG0mHU9Iwdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="64754423"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="64754423"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 01:15:06 -0700
X-CSE-ConnectionGUID: UoBwjWrWTUGWpmxfQYVXWg==
X-CSE-MsgGUID: MD6a+qgsTpOGqaD77i9nmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="235300208"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 01:15:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 01:15:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 01:15:06 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.25) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 01:15:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdrRULCojzITccO/epWxlS/qjXrPBLcOQ8Ka9QUDNj8vBQmIp0sJrVlSRdN4IeEGOUwgrhBumuPEYLeXWGZxCeiKwNdYn5UujkRFP8PuS+xx3MKDu0ev6Os+6+2JfUgzw510FpK10PGJnGCbGKoNyXQaze1TLJXydjjKhfo2B/anoTt8KQCQRtFKBolGHbiJ2t9VniJawYm6jJcjO0G/qVEh+GMLi5+c5IDv7Mep0pXIQuptJUY1ARH2F7dV7A3Z1qG4kED/gFuZfdbHzkS4m7UkwA0PuiEjIl1y5QHb2Wz+McVsj0w0wf8eafFPDXCCl2OCD68ouagZzINlor75GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBmGQxCVHfeTofnY0txuoniQezl7eOywQYKy2tLldRA=;
 b=QI7vdJ7sjqcZJo+eLWFC+YreqLDQrs2VBB3f7a8eJDOPKzlr7Mlw2R+BYtveCUg18/VOSh/JrTL7gR2Xov7Oy3Lm3vxgdDkZe1H48qb4wWmaN0RCewlT4Up21LH/9tKC2DHYCZkOflYo0DgaNx9fKVexMmpOtsZnKoXS4nbIMKWq685Ml6MjnCCnLN+/sANMNAFyxYp0zq5x4Qq91SN1UeznHxHXY/vA6bUNbx06T29LqghnAAcz0qPMFknIGwlgACg37UOHUri074SYd5XRpwrSQWJxOjWybkbLPM2DJ+vl4EamtpDutQ+ncmRtXunDZzVV6VkFeVlVD2zxAj2/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8)
 by SA1PR11MB6943.namprd11.prod.outlook.com (2603:10b6:806:2bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 08:14:57 +0000
Received: from PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572]) by PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572%6]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 08:14:56 +0000
Message-ID: <dcdef685-6a8c-4365-868b-d448e05e4780@intel.com>
Date: Wed, 15 Apr 2026 11:14:45 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 2/2] e1000e: limit
 endianness conversion to boundary words
To: Agalakov Daniil <ade@amicon.ru>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Daniil Iskhakov <dish@amicon.ru>, Roman Razov
	<rrv@amicon.ru>
References: <20260325151615.1407182-1-ade@amicon.ru>
 <20260401120919.282668-1-ade@amicon.ru>
 <20260401120919.282668-3-ade@amicon.ru>
Content-Language: en-US
From: "Dahan, AvigailX" <avigailx.dahan@intel.com>
In-Reply-To: <20260401120919.282668-3-ade@amicon.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To PH8PR11MB8013.namprd11.prod.outlook.com
 (2603:10b6:510:239::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8013:EE_|SA1PR11MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ad858c-a2cc-48a2-077c-08de9ac7147d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AfNoe2stHpscCpIINUqb4kzO6P2fr0PihBJEWmZCzy3zOH1lINAC1sI7Q2l2EOQqbhytHCvD57AVkyr9FkHEDTNk1o6rXonScyK4znNWm8juIOTFShTkvVibXyGUzIeSCOIDNE3xnOXUUw06qNya33KyJOyVmRCTzFC9QYmwnXOfN4uiUUDV8OVwZK0zZ3xXRh2e65SYFB53gBObYGlI+AHXEsmM1I7TCqqE7M0zEGfp831U1wDjIWWMbM1lsYe/LPgF/FrbxTTNwm6LJUt1RZ2V/+WXSCvei45Ex+YoG5xsAPVrRTnt/4b5iAzf7C/Eij6QyqAywTlDBQyX0EfNvTKJLeEgIss6670sOxzyYyypMKhtJ3gzjER2yNzQ+NyRtNV0J33+kk0e2l7x3lYWrWgW5KgdOu+/vvdSnLpkEec4Pt1arwW114+lid05MNQ3JTQtJz/0Jjbb9NnDwg83wHLSw2kU+mev8KOfHPoOLODYSJGM3eSkFCpVTnvzO+wS0eqmqADTHFGxOFW9Tu3zIkbF0S9twC/RL+bmR+UrCtJ56OQIhRaYjf+LWJwF9CqLd4nCBwWmqLFsqH6crnqyDGMFOTAJeyWWTS+d/6RP8YbxADoXxgWQwg3k5U6QfHazPOegEIJfQ1hw6qrP0zu2N+nnIxmqaTFG5nbd737ylktTF0Ff2yjX7gFlWN6dCURpp0VvV+00pzByB8Tro+aJe/upoL1neLHHSDwSfc4BtOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzhrU1h0TWNEb0VQZkJFd2MrUnVFOGtzc1ZJSzVuRHhQMS85MjBtcVM0Z0Fn?=
 =?utf-8?B?VFJhbmZyT3c0M2lnaDZaMTArRTVpOUpKMkhudWRJUW50NFI5bW1nRU9jbFlU?=
 =?utf-8?B?VFh4dFpBWkdVbkZDMUdSbkRHcWZMbk9iQXkzU0x4VXNSQ2ZHUkJhN2FaSytk?=
 =?utf-8?B?N0xGWEFBUFFWOWdTZVcvODhtay9zTmV5WEV5Qk9BeFdzUC9lMnQxbXdIOENI?=
 =?utf-8?B?R2lKd0FvbU15TGo3QnBIakhVd1Vid3U4UWFWMWtINWUwTHY3dGdCY29vME5t?=
 =?utf-8?B?cnV5L1lqNnZ0SWp3WS85L3ZEQ1RCS1E2MGdITmdhRW54b3ZhVGlOOVpYTENB?=
 =?utf-8?B?SHdIbGJwSElHcFJ2NFJURUlwdjZvV2EwNzlvRW9GdmVGeHo5N0hXcFB5dnBu?=
 =?utf-8?B?cmJTeXpNb0lKdlNhMy9PSWVUdGwwNWxIV1hINVYvRWU3dDh0S3V1M0xwZXls?=
 =?utf-8?B?cjJlTDkrUHd2SU93WHh1eUQ3QU9jYkY5QkFuRlZNWGhFcXdJVFdjbnB2eTQw?=
 =?utf-8?B?LzdUcHQvSWhpVER2dzRYekljd2hTTkdnYTRHZHliOG9LQ0ZpYW5DR0VCa0ll?=
 =?utf-8?B?RUlzOXRpL0UzeDJQcGI1V3R2TmpmMis5dmFoZmlVNkk0RUhrR25IV2RUMVha?=
 =?utf-8?B?dUhMN1pSY0dOSXdFdlVQZ09vKytyQ2tiOVl2V0VVSlczVkpIVE1OMGNXTWFl?=
 =?utf-8?B?NVpVUmN2THRGY0JSVWFuMGNNeERLdVZucENZU3RVUDNjSFU3Zi9vb040bHZi?=
 =?utf-8?B?dDhCR2lDUHo3N3hySjRiUUpIaUttdlF3U1NWNW04d21mTkpiUXNkdTUrUDdI?=
 =?utf-8?B?cUlzV3RBajI0UkZ4U01PbDdpTDlHT1lEQjNvWUp2Q212SHdYYmlOTDN6RzY5?=
 =?utf-8?B?bzAxSWVWUjBtTE1MbFpkQnl5K3ZYL3h5ajlRQ2ZwOGI0NHFZSHZ3Q3BucTgw?=
 =?utf-8?B?SXA1ZlNVbEdEb3pZY1JYeW9Fc3BodDM3M1o0UHplSnJlTFY2UmJ4SFo5U2JW?=
 =?utf-8?B?MDBqdGYvZytheGIvcC9scEJvNlJ3ZG5UQW50YmpNN3IxYXlQU2hTWU56a1lx?=
 =?utf-8?B?ak5qV3c4Q1NYV0tuSzdLc0pXMDhhREhwbHZBRUpLOG83b3RzdHBzWkF4VjRJ?=
 =?utf-8?B?N3d5eit1Q01iRzU4TXp0dkptMlVaNFNzcDFEL3B5RFg1d1RsM1hJMVAySFBM?=
 =?utf-8?B?SHBnVVFRT2tqSkVWTUlMZ1crN00vRDNJbU1qTndwYUJ6VloyMzFETXJoZ3Nx?=
 =?utf-8?B?TFgvTHlHUURkZ0N6V2JTUDhpWkdnQUo1N2w3b2poYnUzeGV5N09WdWpRNSta?=
 =?utf-8?B?WXNRa1hESEJxZHhMNDgzR0tEdWd0NWh3bXVBVTdFMTlpOElwM25haWtUWGt2?=
 =?utf-8?B?U2ZlZm9sTERscWhuNUVnRmRPd3RPVXN5QytnUVBjUWplWHRkU3NTcHJ3U1BM?=
 =?utf-8?B?SXEwU2FYVFF0dkQrMGlRWU1vVjVtTUpVazlBMVh3WWxxR0JnTFRjUDBsS2p6?=
 =?utf-8?B?ak9LZDVIcm9GWmFvdUhXNVg0OGl3ZXFjdUltaEFQRG5QdTY0RUdlemYxZkVR?=
 =?utf-8?B?S0pYTTBxNkp6b0dDVHh4dzVtRTFxRFRhZW8wRGxPMnB4Y1lrWGQvYnBIS2Jz?=
 =?utf-8?B?SUFPN0htZnVWMkpOYnR5MzFWZmE5eU1KNGdxTThJaWUxMEZ1K09WbzJLZ1pK?=
 =?utf-8?B?UVJTamFReW5GSlp4SUphcTlEaS9ybUNZNHUyK2pJemovWDdhem03Ty91dDgz?=
 =?utf-8?B?SGFmR0ViY0l5ZjJZaWM3ZlAvbkRFVjdZcEQvUXNuQlVmMlQydmFzOERKdldL?=
 =?utf-8?B?aGJhVGVleGlrM1FIZk9jYjVpaXdsU0lGRGZmcDBOZEtvelJibVVwcWRhT1BI?=
 =?utf-8?B?ckVBMXRRQlZKQThUdkpKMkE2eFVuQWd5MUFoWXhUcGNKOEM0TVl6aG5pS3FL?=
 =?utf-8?B?QkVYSTN6SHBLemhzVEF2Z1J0bkVHQ2hKZ0NPKzVZaUVSNFRNdkdvcnZhRDc2?=
 =?utf-8?B?eGJzcWlORkJtZFdralc1Sk1ZZDV2aEZ2aXdrNGwxNkFtNEE1YWk0Vm05VkZv?=
 =?utf-8?B?L0ZqSWl5MFkrQ05UdVZnY2lXMmFLaXdwWFRudFFVVnB1eDRoTDIzYlVyaWVS?=
 =?utf-8?B?Rk95bVBGTVpOS2wvcDAyeUxnRkFuVTNGY3o0RDRQckh0M0lEcm5sRmN3cEEr?=
 =?utf-8?B?QmNwekIvNUdVc3lIOUxjbmVoNG5EaFl1bHdKSUxoMWhkTm1wOHJOODV1b2lS?=
 =?utf-8?B?TlZHc2hoVkt0dU8xei9DOE1tTHhhei9ZMTJZMkZzc1dBMG85V3ZtSGVvUEFy?=
 =?utf-8?B?NWg0V0NwbjUyNExlRnlPeEprTlpKaTZxb0tCYk81YkF0M2tjUnRvMTVGODNC?=
 =?utf-8?Q?2XNciBlG8xv5/Nbo=3D?=
X-Exchange-RoutingPolicyChecked: tGaTCauuJe6d2YuSomjzap6Y1A48JA95RBA3w3cjQz5yZYE2EkLJT/COygXOZyiTYAM4IRLWya/toB5BRpSn6OFN5R79FfB3+ggP46XXqdOTB5TQKmNUM8D79Kk1Fuwt8UCeIAc4S/2F1HbDPtM+AAF1H+2QDoMBncSW20O1TcTj5nQdUl+bgfW9ki/PoZAGhT9C4Mw3MkdVSzCDsCFC1sba8F1Sx9clT3RP6smb8n3VXSlgRr/WKf0JD/gSQgvMnD4s5DHCgZCWBIeNfWTqrdmAZ9V3hxkmQdLtrz1TCWEHKcqn6gKOF8o+0hko2oxxO6dRrFX6T3qgRHBY1KxcDw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ad858c-a2cc-48a2-077c-08de9ac7147d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 08:14:56.8907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E10sCNCdbRihz3qo/jrKGiWmxtwzBFZCppaq+CCe5FfXKO7Vwz4goYLGpCh62AliIfed1yBzon5tP84IRIISwsGydCDLVqF/ZmB1Waa0B+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6943
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-278697-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,linuxtesting.org:url,amicon.ru:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avigailx.dahan@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BC6E8401CF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 01/04/2026 15:08, Agalakov Daniil wrote:
> [Why]
> In e1000_set_eeprom(), the eeprom_buff is allocated to hold a range of
> words. However, only the boundary words (the first and the last) are
> populated from the EEPROM if the write request is not word-aligned.
> The words in the middle of the buffer remain uninitialized because they
> are intended to be completely overwritten by the new data via memcpy().
> 
> The previous implementation had a loop that performed le16_to_cpus()
> on the entire buffer. This resulted in endianness conversion being
> performed on uninitialized memory for all interior words.
> 
> Fix this by converting the endianness only for the boundary words
> immediately after they are successfully read from the EEPROM.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Co-developed-by: Iskhakov Daniil <dish@amicon.ru>
> Signed-off-by: Iskhakov Daniil <dish@amicon.ru>
> Signed-off-by: Agalakov Daniil <ade@amicon.ru>
> ---
> v3:
>   - Reverted to v1's "check-then-convert" logic: the return value of
>     e1000_read_nvm() is now checked before performing le16_to_cpus().
>   - Removed the redundant full-buffer loops that caused double endianness
>     conversion in v2.
> 
> v2:
>   - Split from the original bugfix series and targeted at 'net-next'.
>   - Removed the Fixes: tag; limiting the conversion scope is an
>     improvement to avoid unnecessary processing of uninitialized memory.
>   - Improved commit description for clarity.
>   - Note on e1000e: this driver already contains the necessary return
>     value checks for EEPROM reads, so only the endianness conversion
>     cleanup is included for e1000e.
> 
>   drivers/net/ethernet/intel/e1000e/ethtool.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 

Tested-by: Avigail Dahan <avigailx.dahan@intel.com>

