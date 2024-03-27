Return-Path: <netdev+bounces-82437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3547E88DC4B
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 12:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9742A4FCA
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 11:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9BD56B83;
	Wed, 27 Mar 2024 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="biD9yDiQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8058255E60
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538137; cv=fail; b=RSlmqUSw77N3dCrR+jWekvDJte1uNIUnyy8f2DxBlmrsZdf5ZNFMHJAUmxyQEJdSd3hq8nMSCU2PEYNPC+vzgjbvVIg0KoHvfKDjqDtcSbpN/quFxIS/OEYslJC4mz9PirqmF5+DYfNGeS5PibIJF8jMmJDkNgD1EJpBOH7X7Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538137; c=relaxed/simple;
	bh=vZQ1fy+CHx7xFEd2wfMxGthyMJq32NIMqujjAPpzoxc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TZM+TMtE7tOuOzs2SPTGIeYDNd9EmZwBDNTMm/ue9vhGtri4mkcb+r1HsU1tKlBoESVCgb6Wru4TCGeyEcAvPaHVPJuRZiGKJF1jCsejDMBJQZQ3vr0zIVxqxu16lg9E/VoipVD7/CIovEp2DXVRiwh8rnl4ei2w/feNCSPGvNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=biD9yDiQ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711538136; x=1743074136;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vZQ1fy+CHx7xFEd2wfMxGthyMJq32NIMqujjAPpzoxc=;
  b=biD9yDiQQUTlaGUdDjvQ+L4m+Jx/x9WCRO14sx0zAwyWNC7LWgaNJCuA
   itDZ1fFMlno02VuBX+R+EdLjkVhN9CwWsJUKDdwZ3jUv/PvaDpxy6/dLy
   wf3Ak1eA5CynxOTv6a5PTrEt6AXVK/jyJ/ccj4gPZ+hkM+JuEDHnK0B2a
   4d6qo5K0AJHc2chBy/vngq5iJTplQKEkrUcL1kzGGzzheioDehOb7dxG3
   7UZ7i0/gyOWI+V6fAhvNa9wEFtYM2krVwbwZDeUdgaIfrTkA8Iw2RFiM7
   VYJnNJO/S3nYK3rm/x7NYKjrDE/sYZ9hgWu2ZCgye5S9Dm+ZWcDexDo9V
   Q==;
X-CSE-ConnectionGUID: P6FXBkDiTROztXOiTPolnQ==
X-CSE-MsgGUID: k0u9A2fwRJO5YT6cOS++OA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6568215"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="6568215"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 04:15:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="47280885"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 04:15:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 04:15:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 04:15:34 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 04:15:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFLr/VNy3oRHvhVQj8tNmh4ocRuNmbDOhx60Sg5YjCGSvNOxngJQ8S6+bgAWNP5Xbwz0kTX5Lnkua5tD02NBL1tnHcTCe0Hc2ufBhgIgbn0VyNYIERQhQ7VaKJaCeiL10dJao/viBzI+3VJR0iC1VvP7bhz0y5+62n+3gvyleXFsrAzy5V/nffb6Dl3kv4E7s6UAwzthXu8X4VwqXY50UVLXwe4r2PF+O/QFxaR8LoxmUTm8JTtTTjlhZFl24CH4aZpFnGdTq6e3JiRXj2rqvkH8JJu+v3fgqkx7Iam4mw9IlGpupkgwe00gU+roqw2D/ZXKip3NgBSFqem9nLLK6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bZierRMc7DU5jd4gcoSn61/wYfbGnsC6zVAZxhdYxw=;
 b=V91cplak6fRf1bBaVdCs1EVyvfqk37zIN5O5JhDJJnCQ4HhqUadaCbMYuUYZ1G0fVP/ruf0dmGzLJxQ7apdfVGVEMyAmObeLbr5R9YbIGWEUpvxPuLy5SbYD3OMToYoucGdG9uWcqmMZklgwlzRczgzJUwhbKBogqeQ4JKe+hVsV4EcmNkiWDqPQUH2ipYFS3sAtjQeoZISG1/Yjr0jQOfKILbdzWjQ3alvQ4wdpaldxtn9Dpw3c2eZweE6/ga77olfY8KkSAVJ9QYTyQlHAHHjOQ9hMKM0xv7355hquen4sQO53Ts6tMGszWz2bxbH406Tt3m++GAylfStCslCNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS7PR11MB7783.namprd11.prod.outlook.com (2603:10b6:8:e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 11:15:32 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 11:15:32 +0000
Message-ID: <b8874290-905c-45ef-92c5-897b66c1f8d0@intel.com>
Date: Wed, 27 Mar 2024 12:15:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] using guard/__free in networking
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: <netdev@vger.kernel.org>
References: <20240325223905.100979-5-johannes@sipsolutions.net>
 <20240325190957.02d74258@kernel.org>
 <8eeae19a0535bfe72f87ee8c74a15dd2e753c765.camel@sipsolutions.net>
 <20240326073722.637e8504@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240326073722.637e8504@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::18) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS7PR11MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c31c07b-3b42-491a-e3ad-08dc4e4f379f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPMJ697CWIrGQLNSw4r2nbnYVD05i5Q4ch31p6+ne0+ufgyfQMJLXKE/WXRnuXgoqa2PRTT1vQcETHZ8AdPRF+W/lcBXiSTbzaXHAEcOauImwjLXhXyW2LGX7BBdZK4jZLvWqmSq26v3DnRYhwi825brKOS7YLQI8RXli6POdKr5As/7MxYifoxTjmeaX+npy9VJqaCR3vx77gIr+L4CxhNwH2Sgx6B1cb6re2SHszCG1AIDvrSkTFkqgeJ2o50clDCXN49JaMBENPZagDSgo2sXJsdwaxyNXwtGaT0KnD/RzbqKAevd6vPAukM8T35Bd0XtqzlsGlqk1Otic73+ss1MJhQHLN0wDK8W30Jv1O6+LBENCzlCTV0BfduT13f27P2qJGRnJujSs6DDMZt4BQP/NI858sXX31BJYJl19gzyifvdnrVHuVuOPKGA7KJNOz4Iezcw7zFgvVR3g5BRtipOkTKj4pmNMOLAR9PAbnY69xMm5zF6s9Z+NKjzBB28KEGwFx0EL6jAhosaTErZ0B7tOdcTs8DnU9E/LFUAgQxQqJjdKLTBJ5YzXrECK6QMN7Hb1L0stkEWoiOfHqOLM6mbY6UtsgjhQU5TDrIjNJY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEJHcjk4L3BvU25kSXFpLzlPS1BHZGtyYzF2Y09ab1h6bTRLVFZEU3RBbE4v?=
 =?utf-8?B?OWxlc05CVzRpWTI5ZFd5dGlXQmJKWFZTVjdrRlNsWHpUR1NadDBWZ2JDZUlu?=
 =?utf-8?B?Y2lYU0Noc1JLZTkrZjU0VGhrbTBjUEd1K1Y2VStWUi9lcnpzblZ5clkxbTF4?=
 =?utf-8?B?a2xjQmJIckVMbEZ0MTQ1NnBWTWZjZnB5WWZMblRVZS9Ca2RUZUNOalI0SFBT?=
 =?utf-8?B?dGFRazNwa1RDMUlXZVdYL3lLbGNDc3NoRDlDOE9JSWVNZ3Y0WG5abTQzV2Y5?=
 =?utf-8?B?eVgrdEZ3bmJIY1gwNEVUMFhTUlVUcUpyd0dzV1o2dkx0V1gwRWZRbUZYK0FN?=
 =?utf-8?B?VURud0pKK1pTZk5QQW1YZjJ5a1pPWS9COHF3L2YxUmd3VzBhMUI0SkhuNUFq?=
 =?utf-8?B?VHhFejEyRjZZTDNRK0tmNTVVS211RDgydDFNajdPQlFZOXhqUUJ5d1FGY25O?=
 =?utf-8?B?cGdmREpRMlNPVDRPRVVFWEt1OEdBYVlzQ0hNS3lmN2pMbWRQbUpmMnN6SkFR?=
 =?utf-8?B?d1hYdmdlam05M05ScmlaYkxIWFNTMHVCd1Y1Q3loYXFWczYwOTB3NW9wczJQ?=
 =?utf-8?B?ZzBEMlQ3cE9zR2tDU2drRkZ0dzJ0dkFHa1FLUkt0Mzd2SVlnTFVvOU1JLzcy?=
 =?utf-8?B?WlJnYWNOeDF4Vk4vclBJWDNpeG93UUJxSlRIVTFvWnhRSXFuS1hDZ01iaXNy?=
 =?utf-8?B?RzlqSHRsZllCZnc4SVRuckxkYjJGbFVmRlg3akxOQ2x2a2pDWnFtM0lOVldL?=
 =?utf-8?B?MzJaT2RwV3FaOWx0bGFwTlk3SmpNVStQYUl3bHl5bE1OMlM1Z0FUZmE3aHRQ?=
 =?utf-8?B?NEpGT3BsMzBvc1pIQ0tZNjh3QTVoODhwNFY2SlRMQnJvTlhKemZweEgzdkpZ?=
 =?utf-8?B?eWVMTStDc2hzVTNyVFRFNmEzelk3S0htWlNhb1QzLy85dWRTT3A5ME8xdGtq?=
 =?utf-8?B?Ni85NFVhL2oveVJqVGpUZkhLdGNtbWd4U0Z0RjRWcFZYZ3lGQ0xrY1RmUDY1?=
 =?utf-8?B?NnJLWHZIMHoxSnpaRXBuaVk4NndpODNCY204VU5Ud2llTnVia0VpTTh4S2dE?=
 =?utf-8?B?cml2ejZGN0JWOWtnclRSM0E0ZU03RUltczhueGZmZXhOSHBpTldLQ2orNlVq?=
 =?utf-8?B?d2Y2Mms1QTJtVFoxVm5xazdzR2RBb3FvSjA0SWhxeWFyUGlXbnpIRURReGRq?=
 =?utf-8?B?ZzR5cWNpM3VCZC9Eb2Z4czZaU0FQWE1iWnBUY081ZHVRcERMZ0h3QUlRb2Jm?=
 =?utf-8?B?R01XQ29QRjVJblpPNXB4U05qdmcrTTFVVTN6ZFBtUFZZdC9WYTFHWitBdWt6?=
 =?utf-8?B?VkRvV3ZWYUs4WEZUSjFvdWk2SFU4UngrNExicXFjNUN2ckdIYjI5b2JlNEtV?=
 =?utf-8?B?WHZTd0w2SE1lbVZMc0FvSkFkS3MvSytlNSsvY0Z0SklKaHNZYlZEZkZTRWMy?=
 =?utf-8?B?K1RNZVJSeWZaUnliUWJvWEI0SUh2eTR3TWtHeTAvUDJpTmlnOWJOVUhEMmxO?=
 =?utf-8?B?MHg2ZTVzYm9GTzZHVlFTN2ZBZEtQY1BGOEQ0SGYvNTNUVFVRSnpWK1FlNjRB?=
 =?utf-8?B?VnpjTlFnMlhYUEhsamFyWDRxM095b2FZbW9pdkt5emVHeVZIY0JnamV3TGJq?=
 =?utf-8?B?NXpyOGtySmdvQVUzR0dtNFB4V3lCZW5JTmtGMzBpbFVJV2ZwVk9vK0w5Yy9i?=
 =?utf-8?B?TWhxc0ZqMmUwNDdXZ1A3cWtwbDJBMUU2MEJnWVFlYU05VVU0bWFqLzgyaDFS?=
 =?utf-8?B?WisyRW1xV2tuckhwY3NtcEpGeFkrMHVBaFZzTGQ4blQwZlNQc3RNeDROc3c4?=
 =?utf-8?B?dU9SQkhzTTNUenQ4UzkyZzlYZ0FvZ2JHU0p2OFduR2ZyalZ4eUhxQTV4b21P?=
 =?utf-8?B?V0s3SUdZZmhCRFp1WjB4S0JjeU5abUJaOGQwMlpSQ1lzWmJjTjhaZG16dkxp?=
 =?utf-8?B?WFR3TE9pTVJzYlZ4Rk5IOU5KZm5aYUlrOW83RGNVSGQ2NjlYSlpkWERFaFFH?=
 =?utf-8?B?UENCT1V4SjcxSDZibGVBUFNUWnFybUJiUStCMk5CWXczMFVVZmVpWklORU5Q?=
 =?utf-8?B?RUVJRnVTWjdxMDdzbjVlMnZ4MTdYK3doMnJxUUNDbm11WGNoc01RSm40YnNa?=
 =?utf-8?B?QUpYVWRZVldhYklJYTQzMUdUZUpGTXYvd2dMMkJLb2NzVk1GeFlJVi9SdFBa?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c31c07b-3b42-491a-e3ad-08dc4e4f379f
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 11:15:32.3246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxR0VTcALWffSHNMxhdL3vElyYX8VVSzfdKOYZwThy6o1cMoGIXBb7qdJqGTGgPTmprPOkUFTQi0gSDJbtSgn3zFIn5bTTI1KCLevwDzifI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7783
X-OriginatorOrg: intel.com

On 3/26/24 15:37, Jakub Kicinski wrote:
> On Tue, 26 Mar 2024 09:42:43 +0100 Johannes Berg wrote:
>> On Mon, 2024-03-25 at 19:09 -0700, Jakub Kicinski wrote:
>>> On Mon, 25 Mar 2024 23:31:25 +0100 Johannes Berg wrote:
>>>> Hi,
>>>>
>>>> So I started playing with this for wifi, and overall that
>>>> does look pretty nice, but it's a bit weird if we can do
>>>>
>>>>    guard(wiphy)(&rdev->wiphy);
>>>>
>>>> or so, but still have to manually handle the RTNL in the
>>>> same code.
>>>
>>> Dunno, it locks code instead of data accesses.
>>
>> Well, I'm not sure that's a fair complaint. After all, without any more
>> compiler help, even rtnl_lock()/rtnl_unlock() _necessarily_ locks code.
>> Clearly
>>
>> 	rtnl_lock();
>> 	// something
>> 	rtnl_unlock();
>>
>> also locks the "// something" code, after all., and yeah that might be
>> doing data accesses, but it might also be a function call or a whole
>> bunch of other things?
>>
>> Or if you look at something like bpf_xdp_link_attach(), I don't think
>> you can really say that it locks only data. That doesn't even do the
>> allocation outside the lock (though I did convert that one to
>> scoped_guard because of that.)
>>
>> Or even something simple like unregister_netdev(), it just requires the
>> RTNL for some data accesses and consistency deep inside
>> unregister_netdevice(), not for any specific data accessed there.
>>
>> So yeah, this is always going to be a trade-off, but all the locking is.
>> We even make similar trade-offs manually, e.g. look at
>> bpf_xdp_link_update(), it will do the bpf_prog_put() under the RTNL
>> still, for no good reason other than simplifying the cleanup path there.
> 
> At least to me the mental model is different. 99% of the time the guard
> is covering the entire body. So now we're moving from "I'm touching X
> so I need to lock" to "This _function_ is safe to touch X".
> 
>> Anyway, I can live with it either way (unless you tell me you won't pull
>> wireless code using guard), just thought doing the wireless locking with
>> guard and the RTNL around it without it (only in a few places do we
>> still use RTNL though) looked odd.
>>
>>
>>> Forgive the comparison but it feels too much like Java to me :)
>>
>> Heh. Haven't used Java in 20 years or so...
> 
> I only did at uni, but I think they had a decorator for a method, where
> you can basically say "this method should be under lock X" and runtime
> will take that lock before entering and drop it after exit,
> appropriately. I wonder why the sudden love for this concept :S
> Is it also present in Rust or some such?

:D
There is indeed a lot of proposals around the topic lately :)

I believe that "The first half of the 6.8 merge window" [lwn] article
has brought attention to the in-kernel "scope-based resource management"
availability.

[lwn] https://lwn.net/Articles/957188/

More abstraction/sugar over __free() is cleanly needed to have code both
easier to follow and less buggy.

You made a good point to encourage scoping the locks to small blocks
instead of whole functions. And "less typing" to instantiate the lock
guard variable is one way to do that.

> 
>>> scoped_guard is fine, the guard() not so much.
>>
>> I think you can't get scoped_guard() without guard(), so does that mean
>> you'd accept the first patch in the series?
> 
> How can we get one without the other.. do you reckon Joe P would let us
> add a checkpatch check to warn people against pure guard() under net/ ?
> 
>>> Do you have a piece of code in wireless where the conversion
>>> made you go "wow, this is so much cleaner"?
>>
>> Mostly long and complex error paths. Found a double-unlock bug (in
>> iwlwifi) too, when converting some locking there.
>>
>> Doing a more broader conversion on cfg80211/mac80211 removes around 200
>> lines of unlocking, mostly error handling, code.
>>
>> Doing __free() too will probably clean up even more.
> 
> Not super convinced by that one either:
> https://lore.kernel.org/all/20240321185640.6f7f4d6b@kernel.org/
> maybe I'm too conservative..
> 


