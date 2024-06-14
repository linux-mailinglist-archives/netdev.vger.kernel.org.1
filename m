Return-Path: <netdev+bounces-103556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5432D908A26
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35381F22868
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C83A19414A;
	Fri, 14 Jun 2024 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="le2oewSD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38528146D6A
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361436; cv=fail; b=FD2MSiMQlz/HtptbKiRxXYA5VM4JTd2ptk8me7RAxUHU3h9UL5YLIbbuX6C2Kk/NliHSKQdfwntsFe2Me0i0RkN++6SLihS79YRs7wE2saJOOHCExLRB6H/II3RDiCQ8CtmJf5fBN3gu+Pd2nfNO9k0A5XNu4x4s+Hd8ajG281s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361436; c=relaxed/simple;
	bh=UqRWZL7B/xfj2xKmjxhDEcHA0yY6o64ghrJazpgbYxI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eL72vW1Nam2V00jFtCGD66sxRTAVzhL+o1ZLImTXslTRpmz95TqoTQiLGh8lLgbp2q1MTzCLLl4jA4HBQaPRuqggQrC/25NAT/jGfjV5yrQbX9lpVLk65EWD5RVTrbLF8txT1bBKhGnymPy30z0l+Qij+OSiDt4brVWkWlIdMeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=le2oewSD; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718361435; x=1749897435;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UqRWZL7B/xfj2xKmjxhDEcHA0yY6o64ghrJazpgbYxI=;
  b=le2oewSDVIZ4pgO5FfAVWx0Y9XKTBTsyC3qmmDbNq8aXIomgNxLsFAe8
   LwwiMyf7oW3hujaCUo7puDwYyWyVzNflPwLIwScWSk7iyaU99ePz+d7M4
   4CH202zsOv7E73XTds8goJ5Hxp2Y9vH5UTV9aLbyTBiyaod1ee0Pb1gcj
   fIPnIc9Vy8/wIlzOznEe3kC99rmCYAZdnd45BLjIUgRCTcbZjTXmAyuZi
   o9gw4trKPs1rOr4c6kurV20i6PEkHcApjdzk4VOn/iOUtrDJ3dVc1sTyK
   CPM7vUQz6TnUZuFbIeLXJ81A5afaaELpB1YyqRDwbbHXbEUTftqU6ALTv
   Q==;
X-CSE-ConnectionGUID: hu4JCiCqQEuusJTkuZOKqw==
X-CSE-MsgGUID: dvuhnV62QFiQpIN5bA78lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="32782852"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="32782852"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 03:37:07 -0700
X-CSE-ConnectionGUID: ZjvNYpg3RXGJJ3u3RD0Zvg==
X-CSE-MsgGUID: cqggAUbzR+6MCkqp8bGbAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="45008649"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jun 2024 03:37:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 03:37:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 03:37:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 03:37:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHJLi+Gc7QsMQl5joBJrao4F6OQxMtd4tpfHQTat5Z/V0QB8aHOBEGebSHZuHFYOzWc7emMb3eeVUgJ6ZqBSW+UC+Ycrs4y8vjxc5IrAx5HLOApz9OUd+0MMor/dHQdewCdSnbBFw/rDHcGMJXWTJtGyh041OeLrzWfrVJxM5Yk7TLbd59voguUU71qAthq6P+yewiw7+Q1CaDq0wn7MNHOJMRcEpFi4kSJCOdsap2FZEKY+nYZ7rMbiFQlNXByGF/77tLBqI50cTzhNlQ8l1+CNw2NiyoTPm2THkqelEgCr3/lDBom2geSSTo5BO+iEJuJvk8kzhxEiay1wK/Q5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APCzzlw5QHYYFWwNMW7LD9k1zcP3mp7MAopYL5wrpmM=;
 b=MlNivoAYQlR+nX26GFlgJ0aYLxMYacdZVxBpc0iLlftANs6eWJTX9KLZ3uoHfJYhh5Jkl0lGbyLNgwZnXr2IXIp3+H54gP+3k1qHfClw19EYMR2bMIPGh/r9vRBKJYl0RIsXNmkfDEK2NL6ecmnlpPYQt/CgcH8iiDAKHAnGBpwz4zEU/tWTMXGJNayl8KuiasgMsNMM4ZOrcuUbsTIJ5MBH9asz31+cRn9SapNzXGVKYrEqZUfPzt6pKeStqZhdlfX9mI5O4/PZGj5dmiMGzVKKSTYhTkvtDpdHShfL04TlcasVcGggAnpQxWIiaKrevHlH0h0uZJWfHnIFfapQ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA2PR11MB4907.namprd11.prod.outlook.com (2603:10b6:806:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26; Fri, 14 Jun
 2024 10:36:59 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 10:36:59 +0000
Message-ID: <5324a503-3a9f-4bb0-ae73-df23dac5e258@intel.com>
Date: Fri, 14 Jun 2024 12:36:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: make for_each_netdev_dump() a little more
 bug-proof
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>
References: <20240613213316.3677129-1-kuba@kernel.org>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240613213316.3677129-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0019.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::16) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA2PR11MB4907:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a33e30-5214-4ce7-bd3b-08dc8c5debd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUZNRlE1QVBIS0RUckRGWTBNWnozSk5GOEd4dFVCRlIyQTNRZ25LbVdSS2tq?=
 =?utf-8?B?YnZmV0Uxd0p6T2F1MGJIOXdTdUpsSm83L28yQ0RlWktqM3FOdjlGN1lUSjhm?=
 =?utf-8?B?cFZ5ckVleUVPZFg1Zlg3UENzQ0dWS21zNkpZRTlqWk1Ubk4xOTl6NUR1V2xp?=
 =?utf-8?B?Q1N1OG9sZ003Y1NtZXF2OU5JZnZtZXVDYTVrN25QWmdoK3RIZkdSUHBZTnVm?=
 =?utf-8?B?YWJ4N1g4QjdTc3BySEJCTDN1dmVseXJuR2UwMEpPS1NoZnI5QjRqNUV5Q01P?=
 =?utf-8?B?ZXVqWVB2R1hzTG5JVDBYOTFrckwwS3BvOEhjWEZqOEJSNENvQTVVQUVoS0du?=
 =?utf-8?B?N3pGL3RQNi92TWd0eDZHNU1GQ1NaOFcyTmRpTEcwRmtYK0p5NGlqQjBjcm5n?=
 =?utf-8?B?eDVvRWEyN1VmNjgrL2pXOHJISDZCT2xyazdhOU5rWXBGT3YxM0JJSk03Q3c3?=
 =?utf-8?B?bU9kKzcwMHl2R0M5WG80SnpPVlk3MVNYMXUvSk5sMGtpVGxvUnBwczJFYVpE?=
 =?utf-8?B?Smh1ZlhkeTNUOTl0ckNrZGF5OUF3VmVyRGdMUjFPR0lSNEE1bkxpaTdYMmwy?=
 =?utf-8?B?ZDYrRU5Xc3E4aFpaOGRkd1JtTVBKdVMrK0hoMjV0VHR1UzQycWtlMjNxa0Rj?=
 =?utf-8?B?QTJJVkJiVWp3UUcxdUxDMTUzOTVCdngwM0YrNVQ3NStPZDRSL2FEWnJHMTdT?=
 =?utf-8?B?eGs1UUEyckNMY09jVEUyQ0k4K0N2T2VINEplSDdxdUkvazc5MDErR2RNeGZ1?=
 =?utf-8?B?MWR0Mzk3TW9rUS93aW91V0JDVkRMTlFNeFFlcEFSMWV3aGJRa0svY2hQa3FF?=
 =?utf-8?B?c2JlbXpKV3p6UDYyaG5CTUxkNWFsYmxodWFkb0tOamllU3h3THFxdVVTUHVI?=
 =?utf-8?B?allRd04zMHZySW9wSkQ0QjYvZGNsS3JYVkdZdzI2czlBcGU3djNpV1V6YVIy?=
 =?utf-8?B?K08rRWtVMkdvQmNrZHdnS3k4d09xY3hkbDhYV0s2cU5JbWJzNDRnQ2dEMkR2?=
 =?utf-8?B?dlRHYmp3clJnaHBoVEoxS0tiZTFtMStDL2JtOGMzTVg5Z0dLVUJNMVZlYkw0?=
 =?utf-8?B?NVR5WGNRQUVkcUZxWWNFejdTbFkwUy9rNnhXN0djZEhEUVIveDh0enRkQ2U5?=
 =?utf-8?B?TzU2N0FLT3d5RkpFZHNHeVc0M0ZUWEVCKzRyRXlPUklwVm5RQy9EL2t3d293?=
 =?utf-8?B?YTE2bEIvUENSTEdPblRyRlVEVnA2Z1ZFNlpNSGI0Q0hTRU9SaENUbUNkVzM1?=
 =?utf-8?B?YzQyYjNOOFBlUWRkRnROMU1CRTBvYzJoL0xoWGdmSlhLa21HeXo1eGVtUGJl?=
 =?utf-8?B?SkpwWHZTUERnNlhFcndoZkVwc3RQTWp3bGM2NVN1aDhITTVZL3ZzS1R0YWdq?=
 =?utf-8?B?U0p4WTFPZXRyRGY1cG1RN3k3QzBLaGVjQnpVT2F6SmNkSFIyNmJrc1ZIajNs?=
 =?utf-8?B?aVRPQmF5N2JEcGRYTDRPcGswdFUrOEZJQWc0OStlYkNCMmxTVTVoZ2tuaUM4?=
 =?utf-8?B?TmtzbEVZS0lnRXFFZXFRalFKdnBTVU9QKzJhN3djK0hMYVh0REpldUNyMGtD?=
 =?utf-8?B?UkZjc28veFJBeCtkTWd1ODI0SjUxTXJBdmpXYWIrVTdnSUo4SEtzU0IxZ2ZO?=
 =?utf-8?B?dDloaUNROFRLMkZOelhXalNXcG8waXozdmo4QkV0Y3llZU1ZRnd0YjVtb013?=
 =?utf-8?B?djI4OE1NR09sQSsyY1pFR2JLbFZwQjVaTFVtQWNHYmp0aHN0RnJtbXdpK2dX?=
 =?utf-8?Q?zln1tw1mD0w9QHc0ycP5ftnK8Et6qUA7C9eJx9B?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkpaSlVETko5RHpaODNYOGRTbW5YUzRpczZHNjZLTngxdzcxaUtxSXY5M1FX?=
 =?utf-8?B?RSsraVc4UGpZN3BLbUYwbDVrUytSM0Y1QmZXbEZsQnJSVzEyUXQ0WVB0TG1x?=
 =?utf-8?B?ckhOOSs0K1VYbHNxK2VDWElxS0F6dkRMMlkyU1Z5TlpRQTA3RkJJT3NxYW1k?=
 =?utf-8?B?SGFMS1JRLzZOczJxYzhxTEp4WWRaQjBVT2RyRnhkdmhWWTVYVCtSMElaSVBR?=
 =?utf-8?B?WVhWbWZrb21maFlLZmJxb2JXbEl2dXpZV1ZZMjB0UnhRQzYzN05JU2NBd1VN?=
 =?utf-8?B?dXNnWW1kb2RMMUJSS3BkcmlvdkNTREFPdGFwM1dMVVBPRzJldGxzSUluT3dF?=
 =?utf-8?B?ODZJMDhnOGRRd09taCtiQnBmQnVoMWhhQWN6dkl1SnJDZjc5MDF2NnVsWkY0?=
 =?utf-8?B?M2hNYlE4WHV5S2JhcnMvVTh1YlJtZ0FMd3lxdGpSODExbnF1cUwzYkxrTFcv?=
 =?utf-8?B?YmNZN1ltREhGVlZJb0pvUTRwYm94UVZ3RHZ6T0NmcS9iK3p2cVAxMHRjbjNR?=
 =?utf-8?B?RmpKUTFybk1jSGRYUFh6Q3VTUHExd0lTTkJkMXlUUzRURWNTQlVPWVNhbmdO?=
 =?utf-8?B?ZWF6dzZqRFNYV2NTRmpzakpqYmRxY0hCOTdNZzVGOG1QR0pGVlRFcDd5QWJa?=
 =?utf-8?B?UXNlOWV4a3ZmRHZKOWVoUGp4aGJpd3R6R2hFeThmUU02a1lkdys0eDRwdlBB?=
 =?utf-8?B?QnR3SUhRSUZwMEVkZXF2M3ZNV24zQXlYM21NNjFZRThqRWJIUVFmY3djeDNu?=
 =?utf-8?B?TnR2TEg1U2ozTlRtRVFBTWZ3cnQ3Sm1GUjl4ci9QbjVaTnAyZndsd0IrMEs0?=
 =?utf-8?B?S1VnQ1RWdUxoTFd0c2FjV0VQT0pFMytFWlRTMitPNXE5cWFnWUdBak5relhy?=
 =?utf-8?B?UDljVWNLeHNteHVvUFB2cDd2Y1lFcXM5UGxjS3NyK0VXSmpXb3RHSWpSRGhW?=
 =?utf-8?B?UlRzalRpbHJ4dnY1WE1VL1lYVnVjWTdBSjhYbmdRdXpGbW9obVZ5WU4yTFd2?=
 =?utf-8?B?NEs2cjNaQmxQcTdyYWIrT1JYbUpTQkFFL0NZWUQwbVZaWTRURFZOZm50MFJu?=
 =?utf-8?B?VmtJRGRRU3MxT0R6VWlVdXIrRENON3ovUC9MMksyTlF6UWdaS05pdG1HNTM1?=
 =?utf-8?B?L25kUnh0RDhDSTBpb0NzMXNtdEJxQjJ3UlpodEprNGtaUXR2Zldyd0l0L1Jq?=
 =?utf-8?B?UUFmZk9yS1ZEZm9VNUVJWUVpbW9UNmdyL1N5eEhKbCtXbEJBYXdVZDl6cm0x?=
 =?utf-8?B?M21XbW9NTXRmZnFGZ1VoQzhMWXM5YzlEcFJocCtrNXNVOCtoYzJGS3dZNlZE?=
 =?utf-8?B?b2lROXRrcitSbGMvREcwOERkd24wNkw0eGNpL2prODNVL3RQR0I1cit2Rmxh?=
 =?utf-8?B?RDFReXFtTzlKN2JFcEJEaTJPK0JVNG5IS3dkS2IyMFlVWWpHQklON2xPMGxU?=
 =?utf-8?B?ZVpqZnRVVGhQUU5WNlg1UHU2d2diZUIrYXZ5N1J3Y29BeFlOQU1TNTFUMFhM?=
 =?utf-8?B?V1hXbzZSc1FnTGloaEE3WjlVZk1jREFxNWc0N1hTeFpJbldBa3VjNm9oZ0RQ?=
 =?utf-8?B?MWdhc2FISmZ3WlZ6aSt5aFdiTnMxTzJRbC9udDNvUldUY1dycWE1WmhNLzdR?=
 =?utf-8?B?SVJZMFlUUkxNRVV5c1lQdEtEeFNxdFJPWnFmMEVVMkZqd0k0VVdad2M5NG5R?=
 =?utf-8?B?UGZOTXZvZzBEQWhqVnNRVnRaV0pxSlcrUlBFSisyaFJLbmtEV1RwYnV0R2dM?=
 =?utf-8?B?WURNdkxmWUNlTDFxMGNJNDF0WVNtbmZpVkZXc2VZWGRCMGNCczN3bzdGekdR?=
 =?utf-8?B?bjY3K1FQZmwxVEs5VVM4SktCSTVtTUV2eUdDbGRXZTJMZWNhRHlOaGJ4Z0pN?=
 =?utf-8?B?MFk2MGYyTzVRNkdSUVplOU9rR0dtMUw3STZ6bUJySU1xTi9CRjBxcE0vMmpC?=
 =?utf-8?B?alBtZ0JJelFGNmVnbVR4Zi9CMTRmdE5YaHQvNWU4T0tzdjFGSW82Q1huVnJO?=
 =?utf-8?B?bkVIWVQ4c2JhWDBMUmIrTVk5TEsxRGZQQ3hoQmtmbkc4TllQOEVyOWYyeUN0?=
 =?utf-8?B?d216UytwM0ZpWEhRQUhYNlRtQTJJdnNUZUFMUGd4aUtqdHh4VGRKU3M3YjJK?=
 =?utf-8?B?ellMOFJpM2g2Z25wZHQvTmVHbE1HRFB4dGs4RDhsOVhMWW01aHFzbTNlU2Rn?=
 =?utf-8?Q?sdWDgF6GR20Wf9GgoUMeI1Y=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a33e30-5214-4ce7-bd3b-08dc8c5debd0
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 10:36:59.7463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6PG74blUmhlyQMKuYJ+7lzQELe469hPl3G/LjyYsv1aLUWQB+vhGMZSa4DQfdTgzpDoeS3osMt2SZNDbDBD8Qr/ILyKZ6SiVKsHDBliCRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4907
X-OriginatorOrg: intel.com

On 6/13/24 23:33, Jakub Kicinski wrote:
> I find the behavior of xa_for_each_start() slightly counter-intuitive.
> It doesn't end the iteration by making the index point after the last
> element. IOW calling xa_for_each_start() again after it "finished"
> will run the body of the loop for the last valid element, instead
> of doing nothing.
> 
> This works fine for netlink dumps if they terminate correctly
> (i.e. coalesce or carefully handle NLM_DONE), but as we keep getting
> reminded legacy dumps are unlikely to go away.
> 
> Fixing this generically at the xa_for_each_start() level seems hard -
> there is no index reserved for "end of iteration".
> ifindexes are 31b wide, tho, and iterator is ulong so for
> for_each_netdev_dump() it's safe to go to the next element.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   include/linux/netdevice.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index f148a01dd1d1..85111502cf8f 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3021,7 +3021,8 @@ int call_netdevice_notifiers_info(unsigned long val,
>   #define net_device_entry(lh)	list_entry(lh, struct net_device, dev_list)
>   
>   #define for_each_netdev_dump(net, d, ifindex)				\
> -	xa_for_each_start(&(net)->dev_by_index, (ifindex), (d), (ifindex))
> +	for (; (d = xa_find(&(net)->dev_by_index, &ifindex,		\
> +			    ULONG_MAX, XA_PRESENT)); ifindex++)
>   
>   static inline struct net_device *next_net_device(struct net_device *dev)
>   {

Makes sense,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

