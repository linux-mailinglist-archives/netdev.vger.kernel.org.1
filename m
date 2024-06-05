Return-Path: <netdev+bounces-100953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C2A8FCA4A
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D9128180A
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9477A192B6E;
	Wed,  5 Jun 2024 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PtUtISvn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA130190481;
	Wed,  5 Jun 2024 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586456; cv=fail; b=NTEwUp5uJi6VIhVU/2yVaylK/QqxIpwAGnRsY8RyvO8/ksDo4KEksHcb/CqqvgkAQo/QaGPyIn9OmADkU4e8SVA/Ym4Cc7CQO55+RRGKBuJ5dGAGUB8DeoIc1zJSRkItVT9FVmHF1ToJ0hQZbK1nTgi22w9Pk6ytWfWDvujHc2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586456; c=relaxed/simple;
	bh=DmPn3ofFOZWKpopiq798KUNMjAfaOqV2/8rCDE8SfpI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uXbYKs1RduHkG71nqZNkDzFypMwMPF1veZbvMP+QVwkNek3TaEykMQC9QA2otM4EjIRLAqOLYLxVd8///z85dZbZrrotlyl50SVyB67JbmfFZOptAdMHeFfda30kV2jh04KqvKu9akHZO4N8rSjQqCge2cI1miyMN6pjaJxQVC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PtUtISvn; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717586455; x=1749122455;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DmPn3ofFOZWKpopiq798KUNMjAfaOqV2/8rCDE8SfpI=;
  b=PtUtISvnhFlyx+hioX5TQx4os5hiHsOX80QbulLDU7CzelF+7hK/hHQd
   bmU+lP+wtvz6YEkUNcobYEWq/eEBT1drWsY203CTwouvbls2JQA7Ns+Dc
   nfUiU8B1XbAdDpLmBZmtEBDZ01kyfmzgkvi/VcZVfs0ZIxCdQQOLgwEj5
   rAeq42K+vY+6eV83uOSbQcvoZdu2IIkAeUwHxCqasB0DG03HNisNnXckk
   kXxOp2sy8n2paU/xYsvGnR01FQ67JG85ZWrAiyfQ3NhtAS3GnsRSHRmuY
   cL6Uwlt1iVBDJE8Z6i0sBILCI/Yj5/eJcCmNHTbdtQOqdac1Se7bYlHyt
   Q==;
X-CSE-ConnectionGUID: yGrhP8nIRzGm2IZRynQ6AA==
X-CSE-MsgGUID: xQcAO/Y+Tr6cALQkIiPnqg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25298669"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="25298669"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:20:54 -0700
X-CSE-ConnectionGUID: yUYT5oBKR5yAo1Db/3x/xQ==
X-CSE-MsgGUID: ydkbN3Y2RuGaS+87vATaGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37665379"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 04:20:53 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 04:20:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 04:20:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 04:20:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J48YM7vQBkj2nWRXDuaLC2RRXNsexFtWm0WcLr0YHBY0ufAzlTRmlgPQ1T6KPyQNLTrWigU9+zvmp38zMjSpQzmsjUlmS/ifaPaPp1DsKry3et/wjV+sD/h3v029cJtZacfs4smfG4m3DPVN2ewH06e42labaDzwWdLJYPEm+Q04dhvuYYbLW+wZmE/szq9S38IL0YTh355jWWMLB4z8+IaovFTUtSUPauj17lr3g2+i9uqEETlaBQxcw38K9qP+PoWJP3byMSPflUqONsq/+zBfzJ/szNpkNwQQev+zpOhpwUEomOQsziHp1fCNua7HPyiP9YVrsOjYZK7Tz25IwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqUCeorEUYxTfgTYYQsiT0l2Usm1DI5TF6PLnBRvhJM=;
 b=e0Rs3KIO1d9frGpS4aU2qGFWFTou+j2qCBxh8dd5+Eej9dcw6xXjUJEjs+tu4rzWOTFmAqKZgHlCwD7eiXnNYbhlNnLtHUnVm7rJuk2hLQDksyRcPbetT5dMLovAc0zAyyYFJpSEJrUI/DsgaPtYVyItml9rJLv1+Lldha4D94+FRf2VX/m4BqUnwMDZwqMK8XRIt47L4BhQ9HhIvWR1fWXfTofJrWqUXxb2FADh5nTqsEwUiPc937G1diy5Y4keCd7vCPY518TPhLCj+SfXz6nDn9rF2k+OsUabbQm3Gah8L5C/x3GsJhyTA3fQH13aWt2e7c1A7TiNIXBiycq/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH0PR11MB7523.namprd11.prod.outlook.com (2603:10b6:510:280::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 5 Jun
 2024 11:20:50 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 11:20:50 +0000
Message-ID: <e9985211-81a5-469f-a4bd-97385c02638b@intel.com>
Date: Wed, 5 Jun 2024 13:20:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V3 2/3] net: lan743x: Support WOL at both the PHY and
 MAC appropriately
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<sbauer@blackbox.su>, <hmehrtens@maxlinear.com>, <lxu@maxlinear.com>,
	<hkallweit1@gmail.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>
References: <20240605101611.18791-1-Raju.Lakkaraju@microchip.com>
 <20240605101611.18791-3-Raju.Lakkaraju@microchip.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240605101611.18791-3-Raju.Lakkaraju@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0072.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::12) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH0PR11MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 7466ab43-6eba-44b3-bb75-08dc85518e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHo5QVNJeWN2a2RrSjJXYmpDTzNMTHFkcnJFZGJDbmtIMEptRlVudUpJU1FN?=
 =?utf-8?B?a2RGeXcxSWk1UlQySVV0aEFHQXViRmF2N20zQXdST1hWTmorempET3JIdDB1?=
 =?utf-8?B?cFRLaS9vTE5ycTlnWjdZVjVkQXJlVWNUc2JOSTFYVG0ydmFzWUFBRFBzNWJa?=
 =?utf-8?B?d2RHTS9MbEZWWS9KVzNNNEpJQmMrZ0Z0dkh4V0d1TWQ3WTV2M0JRRWJ6dTdH?=
 =?utf-8?B?bGMrYk1VTW1SbU05ZXk1cThURVJOcmdQVnM1VkNBQVB3NnF2cHc3RmlLNVBh?=
 =?utf-8?B?UVlvR1owWHFPTWJpQTFvQkRTa2xmU2EzQVU1T1d6ZkY5c1REYTRpZU9Ec3Bh?=
 =?utf-8?B?MTNOK2tDNC9mRGx5aEJyOHBkUTk4ck1wNHg3cXNnZllDWHhWZ3ViU2h2eWxQ?=
 =?utf-8?B?RDk5ejB6aDFyVWFWbCtjQXdaMkltbkRaYXlTckNQKzRYeVlDTEpZVkQ2aTh2?=
 =?utf-8?B?cUliVmdvWThkeWcxUFZLTERsR1o2VTZzL09IVUQydDU1NWYxOGpUZmxjdW1W?=
 =?utf-8?B?MjVJeXhjWTZsY0pzYnF4MHZCZmVzd3VVRW5DTk5xSGJBL0hocDNmT09PSk5i?=
 =?utf-8?B?R0FvNlRFb3JhcVJsYU1id1J2bWVtMjEwNnd1OWdsQzNRM3dwT1VyeG81a3RN?=
 =?utf-8?B?WHhicERvWDc1Tk1BVnZyRGZiMGlRejc0TTljclA1d256WGNCRE1ianZRTHlp?=
 =?utf-8?B?SVZMd25ST3RDWDVFbVlsQXAzOGQrSVZTMTRkMVlUVTRpeWVpNnhwdS9NamFi?=
 =?utf-8?B?ZW5oUTR2b0tFTmF1OFNTTXlNSm1iUmQwWUk2aUlmK1J2UzNFRUs0QnF2UnpQ?=
 =?utf-8?B?V29ld0Z3bXhkZ2hUZnMxVGZvNnFHU2haZUhKZTR5NWl2RnVhYitGYUJPNjEz?=
 =?utf-8?B?SU56cXlRYzRmUWtacTdRdm02Qnlad2k2VEdDK29HdTNLQUlhajJ1SkhWZlcx?=
 =?utf-8?B?WmVKUlNNQ1YrSVVCbE11bzJ6VW5XUktvMnNTR0hwbkl5cEprZ0NwcGZSblpS?=
 =?utf-8?B?OC9HTlQ2Uk1uak5kcGxkVmlZM1QvT1NDNTQwZTh3aWVzUGFHR2NxOHYyMFcx?=
 =?utf-8?B?YkZ0eTFIc3JwdW1pNUNxSnpORGF4MVFtM0NPRmduYW9YbnpxNjdncFUxLzBp?=
 =?utf-8?B?Vk5tQjBJSGlDTWVMQndRazFHV2tVWjB3b2hTd2J0TndCVEpRQkRTRjlPa1Az?=
 =?utf-8?B?TkdBbDFCbjdDZU5zSG9ZTnlHcDEwWjJHVDRPTVpCaE1kNVk3QzJ6WFJvUkZD?=
 =?utf-8?B?QzROQUQxbDNqd3FzVDY5RU4xN3B5L25JV2RDbUVCQjVmWGNacmx3R21LWDJy?=
 =?utf-8?B?MlV1NFJSayt2R1ZaN0ZBSzNxQXZodEYvTEtDcTNFMnZ6Z2d1M3NvQ2FEcmFH?=
 =?utf-8?B?MldyeDJicnFkUWY1Zi9CRGVta1pOMTRUSmc5bE1sdEQwbVpCUHNPWnNGSitr?=
 =?utf-8?B?c2taYzA2OTBVNHRVcWVGaGIyTkV6M3dCS2J0Sy9SdXJoVXhBeFovU1NnVjhl?=
 =?utf-8?B?UjJpRG9YUC9QYXBJU05lV2luRHJMdm5qOUt0bEFueXRUK3lOeGR5c0hUN1dP?=
 =?utf-8?B?MDJVRkhYODM2YTJrMlExV21iRG1BVmhXK09waHVKakZKNkp4TEZYTGFQcC9D?=
 =?utf-8?B?bkRJVSsvL0tFajhNRlpPaTJyTXN6UWk2QldUVVdhaHVnMjV1aE1DeU1RbUJE?=
 =?utf-8?B?U3RvbDBRcTc4ZEZTc2Y1RmRPOWVySjhtV2xJaENXcHRsSUlvVWRBYzNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0tnVWNBZjVneWx5MTJHOEVLeVZxdktNaWVKbTZRZDl0VTZJaXF1OFllN0JG?=
 =?utf-8?B?VndzR0RFVytqTXdKRTJqbWZIWWI4a1B0UjRZcTZPS2VHYjVnMXdVMW1KU2Iw?=
 =?utf-8?B?cVZWcEpkZThaMGRvckVTMW9FS2I5RHhma050aE44ZnRNNzBwVFRubVViWFNY?=
 =?utf-8?B?aG81VG4xcHpsR0NCdm9ZV0MxZWlXdkJERTlxd2VJVVJjM1l0Tk1BWHBMS2xF?=
 =?utf-8?B?V3lhajZxSUpvcVRIWFpvL1hibVR5UG11VXJoeU4zaHJmcEJSeUlXMVVncXlW?=
 =?utf-8?B?T3YrMnJuUWtLUVNUTzZCNlZFUlBxZmllbWY1VndwRjZySHdZenN3SmdrL2Ru?=
 =?utf-8?B?c2xMbXJuY1ljWlE3bm90K3FIa25qa1J0YUVUWFF1UjVOSDB3YzJNWGxRNERW?=
 =?utf-8?B?WVk1STVaWHQxK1VuTDUraTFXUGNpUXJmVkw3OXhPck8rY2ZXRzFJbk56UHhq?=
 =?utf-8?B?YkQwYUpiR2JKaXRWcHJtSzlSRUtXcXB5Z3Q1T0piZFlJNXk2UGNxK1lqdGFY?=
 =?utf-8?B?ajQ3NDg3MFJocXFpSGpxamlPbTcrSnI0aElpY3gwdHB4U3hrWlR2UjNnMFJU?=
 =?utf-8?B?bHl3NW40b0dwbmJqU2R6QkpZRHFyTnVxT2FxclBlRFdHRGdiNnY1NzJsdGI5?=
 =?utf-8?B?TWFTSkdCdnpUVGhkRU1NMmw0THRvRWhzZFlQQjVCYno1ajJvZHZVd1cxKzBY?=
 =?utf-8?B?MFFtUUk2U3AzODVkSmpEZTVFcituL2JHaUg4TEFycGk2NmxNb1VHeXhmODhY?=
 =?utf-8?B?MVRwdDZWZUJROTc2RTZDUFkrZzkyOGEydllUa0RNT0lNT3lTMTNVK1U1Qkkx?=
 =?utf-8?B?a3liREpHTXdQV25wYVBHTk4wNURjc3VmWnhHUkxRZGF1TFFaRnU2VFdhZDln?=
 =?utf-8?B?ZFpEM2lseTIvdlpYM2daTkFKelNTL21YN1V4aVFtQTRHQlB1bnJ0YlZvM3hQ?=
 =?utf-8?B?ZlBFaFJLOW1QTVlIL2pFcW9sbGIvcDB4eno0b0ZCWWc2dWFjRis3WWNVc3NY?=
 =?utf-8?B?TDBzRnFuOFBUZHpndndFSVB3OHZNWXJqckpCS2F0d2RqQ2orUWR1NlB4bFhI?=
 =?utf-8?B?R0xlVmZpVHVGZVdjQU5PTCtEdjRzUS92UFExaWh0T0ZOZTNSTTNuOUVUTys3?=
 =?utf-8?B?L2V6eHV3VzhzcVNtRmVPcE16cmRONStOWDBHSXFxTlFRVXJ5YjJjV3FGSE0r?=
 =?utf-8?B?VlZrSUZVMUZaQ2tNZk1aWjYvb21jL1hBN0hUNUwxSWhkY1VyUVY1TjZkbHZ4?=
 =?utf-8?B?cW1lN0VhZ3RnaDJJT1V0WWU2SHlhYjRzZkhhUHFPRE1qcmJuRE1BUGt1MlZY?=
 =?utf-8?B?VHlmYXpHOTNQT1ZMYm1sNmhWdnVITGZFdzJQQ2tNOFJCa3lUWUluM0NTMUFP?=
 =?utf-8?B?QXhSTmJoZnhVd1FZTEFpeHJ0N0ZhSnJwd09Rd3lWUWVvc3E3YWtZL2doZkJo?=
 =?utf-8?B?TWFwSVQ1dFpLeW1yYk51cldwQVVsOEYxbzJEcTRabGgzNFlFRDM3eFgrN0JU?=
 =?utf-8?B?RVN4cnFWakVBNkZ1NDlXNjlHRDVESC81U2tlYUFXbDJZU0xITEFGaWY1NmVv?=
 =?utf-8?B?bGNIVTFsYXRHOUlGRVBtQmREOWZVZmpwWUcxRUJRQ0Jtd000R0xiMUpPSnhN?=
 =?utf-8?B?Q25MZjdIWGEvK2E0WjlqUngrSUJXcHNhUnB0NTkyaWJBTHp0cFVPai9Ma3g1?=
 =?utf-8?B?Q2p5TGRYSEZKaS9ST0pLc0RYdWZWZnhVaE5sbTBRZ2NLVW1nZ2hsS09xS2ha?=
 =?utf-8?B?dWNxNk1xeXFpcmRnbXllNDVZeG1WYUN5bS9wUlVJZjM1R1hJcUlFeHZ5ckFX?=
 =?utf-8?B?cmsyVGVZWm1LRWk5UEE5SUJVVmR2M2xKRTF1Z3hLLzhZcmZadjliMjVCMGxl?=
 =?utf-8?B?aEYvSndkUXVjRkx5VEpFeHA2TzRMbGNqRXZkNzhER2lqYTlZWDFEdENEcGx0?=
 =?utf-8?B?WldMZWlaZ0E1MTNTaVZzcDZwbXZLcStyQXZKM1pmZGt6djVZS3N6TkhJWFMz?=
 =?utf-8?B?TVQzd1NQZDUyK2VnamJDMVY0Zms0ZlkvRkxxbGtNK1RmWXJiSGxDK3RkazA2?=
 =?utf-8?B?Mys4Wi9MdGJmYkVoMzZMNXVxblZrQS9zdTBRUFZDQlZqa3JMWmlsaVArdk1Q?=
 =?utf-8?B?MUpuNFZtSXFYSktNaEFtL2hZMDdWMVdIM0lPQ0x0MFNIUmdaTHFTZk10blo4?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7466ab43-6eba-44b3-bb75-08dc85518e0a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 11:20:50.3798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZtcePIcBMyi8lbylXqbxSdIIsaNh7gsGqy4XUrY/Bs24TZWPkatx8F1vjGa4GtcD3nwSqENB5DxFflRK9MMT1TDnYwcvO758vmH1KJtCWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7523
X-OriginatorOrg: intel.com



On 05.06.2024 12:16, Raju Lakkaraju wrote:
> Prevent options not supported by the PHY from being requested to it by the MAC
> Whenever a WOL option is supported by both, the PHY is given priority
> since that usually leads to better power savings
> 
> Fixes: e9e13b6adc338 ("lan743x: fix for potential NULL pointer dereference with bare card")
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> Change List:
> ------------
> V2 -> V3:
>   - Remove the "phy does not support WOL" debug message which is not required
>   - Remove WAKE_PHY support option from Ethernet MAC (LAN743x/PCI11x1x) driver
>   - Add "phy_wol_supported" and "phy_wolopts" variables to hold PHY's WOL config
> V1 -> V2:
>   - Repost - No change
> V0 -> V1:
>   - Change the "phy does not support WOL" print from netif_info() to
>     netif_dbg()
> 
>  .../net/ethernet/microchip/lan743x_ethtool.c  | 44 +++++++++++++++++--
>  drivers/net/ethernet/microchip/lan743x_main.c | 16 +++++--
>  drivers/net/ethernet/microchip/lan743x_main.h |  4 ++
>  3 files changed, 56 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
> index d0f4ff4ee075..0d1740d64676 100644
> --- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
> +++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
> @@ -1127,8 +1127,12 @@ static void lan743x_ethtool_get_wol(struct net_device *netdev,
>  	if (netdev->phydev)
>  		phy_ethtool_get_wol(netdev->phydev, wol);
>  
> -	wol->supported |= WAKE_BCAST | WAKE_UCAST | WAKE_MCAST |
> -		WAKE_MAGIC | WAKE_PHY | WAKE_ARP;
> +	if (wol->supported != adapter->phy_wol_supported)
> +		netif_warn(adapter, drv, adapter->netdev,
> +			   "PHY changed its supported WOL! old=%x, new=%x\n",
> +			   adapter->phy_wol_supported, wol->supported);
> +
> +	wol->supported |= MAC_SUPPORTED_WAKES;
>  
>  	if (adapter->is_pci11x1x)
>  		wol->supported |= WAKE_MAGICSECURE;
> @@ -1143,7 +1147,39 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
>  {
>  	struct lan743x_adapter *adapter = netdev_priv(netdev);
>  
> +	/* WAKE_MAGICSEGURE is a modifier of and only valid together with
> +	 * WAKE_MAGIC
> +	 */
> +	if ((wol->wolopts & WAKE_MAGICSECURE) && !(wol->wolopts & WAKE_MAGIC))
> +		return -EINVAL;
> +
> +	if (netdev->phydev) {
> +		struct ethtool_wolinfo phy_wol;
> +		int ret;
> +
> +		phy_wol.wolopts = wol->wolopts & adapter->phy_wol_supported;
> +
> +		/* If WAKE_MAGICSECURE was requested, filter out WAKE_MAGIC
> +		 * for PHYs that do not support WAKE_MAGICSECURE
> +		 */
> +		if (wol->wolopts & WAKE_MAGICSECURE &&
> +		    !(adapter->phy_wol_supported & WAKE_MAGICSECURE))
> +			phy_wol.wolopts &= ~WAKE_MAGIC;
> +
> +		ret = phy_ethtool_set_wol(netdev->phydev, &phy_wol);
> +		if (ret && (ret != -EOPNOTSUPP))
> +			return ret;
> +
> +		if (ret == -EOPNOTSUPP)
> +			adapter->phy_wolopts = 0;
> +		else
> +			adapter->phy_wolopts = phy_wol.wolopts;
> +	} else {
> +		adapter->phy_wolopts = 0;
> +	}
> +
>  	adapter->wolopts = 0;
> +	wol->wolopts &= ~adapter->phy_wolopts;
>  	if (wol->wolopts & WAKE_UCAST)
>  		adapter->wolopts |= WAKE_UCAST;
>  	if (wol->wolopts & WAKE_MCAST)
> @@ -1164,10 +1200,10 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
>  		memset(adapter->sopass, 0, sizeof(u8) * SOPASS_MAX);
>  	}
>  
> +	wol->wolopts = adapter->wolopts | adapter->phy_wolopts;
>  	device_set_wakeup_enable(&adapter->pdev->dev, (bool)wol->wolopts);
>  
> -	return netdev->phydev ? phy_ethtool_set_wol(netdev->phydev, wol)
> -			: -ENETDOWN;
> +	return 0;
>  }
>  #endif /* CONFIG_PM */
>  
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index 6a40b961fafb..b6810840bc61 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -3118,6 +3118,15 @@ static int lan743x_netdev_open(struct net_device *netdev)
>  		if (ret)
>  			goto close_tx;
>  	}
> +
> +	if (adapter->netdev->phydev) {
> +		struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
> +
> +		phy_ethtool_get_wol(netdev->phydev, &wol);
> +		adapter->phy_wol_supported = wol.supported;
> +		adapter->phy_wolopts = wol.wolopts;
> +	}
> +
>  	return 0;
>  
>  close_tx:
> @@ -3587,10 +3596,9 @@ static void lan743x_pm_set_wol(struct lan743x_adapter *adapter)
>  
>  	pmtctl |= PMT_CTL_ETH_PHY_D3_COLD_OVR_ | PMT_CTL_ETH_PHY_D3_OVR_;
>  
> -	if (adapter->wolopts & WAKE_PHY) {
> -		pmtctl |= PMT_CTL_ETH_PHY_EDPD_PLL_CTL_;
> +	if (adapter->phy_wolopts)
>  		pmtctl |= PMT_CTL_ETH_PHY_WAKE_EN_;
> -	}
> +
>  	if (adapter->wolopts & WAKE_MAGIC) {
>  		wucsr |= MAC_WUCSR_MPEN_;
>  		macrx |= MAC_RX_RXEN_;
> @@ -3686,7 +3694,7 @@ static int lan743x_pm_suspend(struct device *dev)
>  	lan743x_csr_write(adapter, MAC_WUCSR2, 0);
>  	lan743x_csr_write(adapter, MAC_WK_SRC, 0xFFFFFFFF);
>  
> -	if (adapter->wolopts)
> +	if (adapter->wolopts || adapter->phy_wolopts)
>  		lan743x_pm_set_wol(adapter);
>  
>  	if (adapter->is_pci11x1x) {
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
> index fac0f33d10b2..3b2585a384e2 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.h
> +++ b/drivers/net/ethernet/microchip/lan743x_main.h
> @@ -1042,6 +1042,8 @@ enum lan743x_sgmii_lsd {
>  	LINK_2500_SLAVE
>  };
>  
> +#define MAC_SUPPORTED_WAKES  (WAKE_BCAST | WAKE_UCAST | WAKE_MCAST | \
> +			      WAKE_MAGIC | WAKE_ARP)
>  struct lan743x_adapter {
>  	struct net_device       *netdev;
>  	struct mii_bus		*mdiobus;
> @@ -1049,6 +1051,8 @@ struct lan743x_adapter {
>  #ifdef CONFIG_PM
>  	u32			wolopts;
>  	u8			sopass[SOPASS_MAX];
> +	u32			phy_wolopts;
> +	u32			phy_wol_supported;
>  #endif
>  	struct pci_dev		*pdev;
>  	struct lan743x_csr      csr;

