Return-Path: <netdev+bounces-101790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23224900170
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C336F288108
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46D8186281;
	Fri,  7 Jun 2024 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtRriDNA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF64915DBA5;
	Fri,  7 Jun 2024 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758182; cv=fail; b=Mt2NqjegMIqPdwZunQ6+5TGyZBiLsSx3WtVMBM3AYtb90f2uoVgq5u/U/C9yNinzonVtvJR4Z/fG2+rExdwJEi6dCb+ouycl6c/jbcTLBtbki4R09Ip25Awx7E47+IHuztgRYf3RFHDbjW1z/seAcoaZnT/Kmo7mKEhsZEki+wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758182; c=relaxed/simple;
	bh=7eeZ4rMfpy0mG+q1TVzTfi/XrVKnH5BVCP8ci6/5AZs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o9/x/pMBP3F9YNvrG1xMOaCeHbovUVMPHeg0lCrWM+A/a0iKao6vs4qAFP5mObaHJLJHW19+Fjm1e2OGkLyXr45xrXKrEL5pAZPQ03SaFZoddIVqwlFGgXBTEV7IUdHmTCgQ9bLc6+IvuDkbw3ZuqcDn07efiy9W4gKHi30yfag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XtRriDNA; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717758181; x=1749294181;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7eeZ4rMfpy0mG+q1TVzTfi/XrVKnH5BVCP8ci6/5AZs=;
  b=XtRriDNA9+HiiNR/cHkT0KxLXUZWWtblmEJZA/+auA/WqTOH9q2/nFhD
   v7n+WCe+tX6uECYzI5jA2kGtP009EFgTcHfWqaQpl5i1crV96LXlBiGOi
   a/OppRLi3XDm7peYqakfd8ISmgbGvKRjYn4UEWwlRPfvEg30PcvpXpOIC
   mGkOXmMywo6ObAvEY+n1HnZZhPVv0p+KhN5noii4HE77Iq1Dw7Irmqf9c
   iAKs0EmZJ6wlfV1IyjJftOrVDyGIDPTUaXLlek1SL++0sSSVIc2KLyCQi
   nxMSHsC7UnQKbGVOxdUdcLWgwyetbVKqGN2WZ/rFWRnKRpmDg1PIbmvvc
   g==;
X-CSE-ConnectionGUID: N7M2jDaRQhWPy5+Zwh06eA==
X-CSE-MsgGUID: opgMc95kQFC6OEfDo5WN/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14654380"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="14654380"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 04:02:53 -0700
X-CSE-ConnectionGUID: edcJDsQ6SiCmElH+1gNtQg==
X-CSE-MsgGUID: 62Av78wXRqmwS9gJ8HqmaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="38212132"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jun 2024 04:02:53 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 04:02:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 7 Jun 2024 04:02:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 04:02:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJbDwgQCnJs20JrcLjSrpT/vtLPjaNMj0GTDAnlS9X9l3OWZc7ETLtfRc+63bEGyrqUpqeWBI4OEPZ9wigRjpKwOtHhnOG/TNsWkpfzzDJVHij6YUo7RQ+mMFI+ux2xBJ7w/r5GvKrx23so6XOrbAn9IP89nKpOZEy0zUcKdYcbNOjDhn0IJSy0cnHi9mMINhpUvKT4pUJT0cITiQmyhNUjr57xjT8peVe0XnAySkFjVLN5Ulf0A9tx8V5yLzEobX0mWB8pYHfvj3kq3kc29axHshuuxz41Wqi3FFEUjjHsu4vN5ZHwQGdoa/C7fWPbYB741a0EywQIBf8MO+KbOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+8xTnUCe7xrCCSmtzZOUi/61rgdnFNDFvXFRCVNQ/E=;
 b=KMXrqRl1Q4fw75hj/QUM/tDQRuqLJpXELm2vk9YqWUsOzI2eLjFyY3XBTVjS/kd1XaxEiAs116SJm4XoEYvd0iNdJV1cPiEFmRKnjD/FI1N1shdidBRzIvTq1qBfQxuqgW4VMkEPddYRIDWXM+7r8vpvl47b1QC1n/gs778oYzlixG4/Yh3b/4S8sgRWopzbHfDmyOApWPlXj37zIw8nZneAZvveymIOMUeSEorUrqy2NcxNoW2mCvtOlJxkUukxEtGHzlFu9xZg+HzWoVIO922ARQSiEf/IGb9Lg006ZlFoddzktXo6pnP0yc8+cSUiHaVmj6ydeYnKh/ruwddi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH7PR11MB6745.namprd11.prod.outlook.com (2603:10b6:510:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 11:02:45 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 11:02:45 +0000
Message-ID: <7a8d76c0-e1ee-4ded-af41-3f1e3aa85530@intel.com>
Date: Fri, 7 Jun 2024 13:02:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bnxt_en: Adjust logging of firmware messages in case
 of released token in __hwrm_send()
To: Aleksandr Mishin <amishin@t-argos.ru>, Edwin Peer
	<edwin.peer@broadcom.com>
CC: Michael Chan <michael.chan@broadcom.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
References: <20240607070613.12156-1-amishin@t-argos.ru>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240607070613.12156-1-amishin@t-argos.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::33) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH7PR11MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 4373c66b-1306-4c92-09ba-08dc86e15c35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXc3M2pONGJ0OWk3bXhaakw5M09CRnpQRVJ2MjQyNFpLeTJ6Ukx3SDVPeUVu?=
 =?utf-8?B?WXlDemRyb1MvMkh3QUxSbFFkM2M4V045cngrbXRSYXdCS2ZrTUNOcTg4WmlS?=
 =?utf-8?B?bmpMbzdFMzArUitkR2JqdFlyQXNjaXlicDVlcmFhZTZRZlBKWjVCTEpLYXZV?=
 =?utf-8?B?SGFaM0M2MTlPZFJOdWh0Q1NTZzY3VEJWc0VGdFJ1Vm9xYWRnQ2JKU28xNjJt?=
 =?utf-8?B?WE5vc1VxY296TXFmU0FBRUxTYUZkT2lEY056QUg1VUxkQjMrYkFZeHBYdWlI?=
 =?utf-8?B?U2NlYk8zVCsveTFSTi8zUUd1Y2thaHRrVDhFdGg2SUZkbTV3cW1KVmNpYmJw?=
 =?utf-8?B?NWFvUndqVGc2VEZCSEYzOHBsOUUrcUVnQkxmaWF6Ny84TTlFL1lkYTU3cGpu?=
 =?utf-8?B?UWJGZS96VFIxbjVIZ1FzOTNYNnJzcmpTNDhKZUNzNVpDYkk1RWEvUkdSUjBP?=
 =?utf-8?B?QjFQbEVaU3N3azB5bGlPNmM0eldFWTR2MlczSHZmcnJxUGZheUYxcDAvWUF0?=
 =?utf-8?B?TVlrbnFBcTFWRS9uTG56OTg0YitwTzF1VGpVMDJydkoxTzF5eDZORGcrK0E1?=
 =?utf-8?B?WXZWTVFTdDAzOGN0bDAzc0F4czYrTlU3dDcvZWNLanZIS3BCYWNOZUpDSjE3?=
 =?utf-8?B?SHlSWlRrNmtLdEhGVDdVVHdwZmdFK05GamdaeU5WWEVuTGtCTmwyT1AwWG83?=
 =?utf-8?B?MUx4VTJ6Snk4Yk9qZjBDQ1RzV3h6WFdub2dmN0Y0T2k2bW16U3VvL3RVUTUv?=
 =?utf-8?B?bWcvYXhaWU1HYVBHRWFGVzdYNGMwbVg2cmRmaXJzTTVqaW03bE1DK0NpMkxC?=
 =?utf-8?B?Y20rMmlSR2Q3TlEvNXZTaUhPWGp6OEdJR0JaeXlFeUVqSEdINUxGa1RpdDVW?=
 =?utf-8?B?UDk1WTZXajVPcjZTMXB2ek1sNS81MEFwTVljRDdSeGJtL3VPSERjdHdKMHZ5?=
 =?utf-8?B?aTJDN09xKzhXS0poSjlOYkNFaExaSDAyb3lRL1J0VXBNTDF3dlNYcVJSaEx0?=
 =?utf-8?B?SDdCeEJvM2M5SkxSRFpvOGVEOVI3SlJFeExvSjJQM0M0cVkrTVJLajFYRGhm?=
 =?utf-8?B?TTM0Ti9xWW5mN1JKblcyVHk4WEN2aDNPL0h1RnZMVll4OGFsYlE0OHc1NGUw?=
 =?utf-8?B?cjk5MUwyTStlc0p6K1BVN3VmejZCS3pTdDlQSHdLbGxNdVIwcGgrOXJrM0hR?=
 =?utf-8?B?RURFZE5VYWRIRFFPVzV0ZDRMbGFoUTNUVmFIaGR0NXY4VTFuOXJ3bkJST1o1?=
 =?utf-8?B?MGJ0ZERmeE4ydlhwUkZTYXFzL0lvM1dYRDFBVjBDS3RERWdxUWNiSTdyOTlx?=
 =?utf-8?B?ZllKTGljdEkzSXFCNlhZNTBJdHQxc1RwaUxOeHNrYW4rVHNvWkVhWkVTRTgv?=
 =?utf-8?B?Ylc4bWZMb25iZnoxNHlmUWhYeHJob1VleVZGeUN1WU9KOHUvS25IOHJvUU1y?=
 =?utf-8?B?WnRGUTRpbFNTRzJjRjl0YTFlTjNkRFU1cWI5TWExTVhmMnQ2SXI1ajRoeXor?=
 =?utf-8?B?Q2J4OVZ4U25mY3NiTjB4WXQ5VmZDL3VjRDViY09LV0xlQVVqSmk2V2ZWdXB0?=
 =?utf-8?B?SUZnWkNVVzc2Zi9pUVFsVnN2QUEzVmV5YVhlTXM0ZDJWLzFYSXZVZDliRWVp?=
 =?utf-8?B?R0VKR0RXT2FTZHpFQUZiODVHcmVmeVFrUUFWRWJ1NG8wRy9GZjh3Zkdaamxy?=
 =?utf-8?B?S0kxKzJOWGczNm1VMTlocnQxc0tlN3RhWDg2c0Jmem5UQnFwU3cveGl2c3BE?=
 =?utf-8?Q?LVNQjoAVvHaCERw3CFfKh6bRnqHtJaw6ZthOYcT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE5RMDVmcElGQXJJVDUxOTJpUG9XNTNCYzRIc0JvQU5Bdy9jb2hQUzcwdTN0?=
 =?utf-8?B?TkhZdXRSdk96c0dtbzF4MThEQmxRUGYvQnA4emNzZ0RoVXpzcDVYY2h6bGZI?=
 =?utf-8?B?cUk1OVk3clBGZm5VVERoOVJ5MGkwRGEwK2NYSXd2aVNwS0JnRTBmVXJNb2kz?=
 =?utf-8?B?Yk96Y3pJOUNrM3kxdVYrZm5rM3pWSStiZmRwZ1JZNVJUQWFZelB5ZHFQTTZv?=
 =?utf-8?B?aENQSGFCRzd0aDdycGg2Q2pCYlZ4SW4xWm1CVjN5MWl6K3FvRU1mbE1XeEZL?=
 =?utf-8?B?My9qNFplcExrQkx6ZUxTcjBlQjZjR3AyaFNXZm8yUWljdnV5QW5KamxzaTVy?=
 =?utf-8?B?STdzMk9pZzBnNWJ4WWRSNXZkd2I3MEcxK29Bdjc1Vm5VdFh6cFFBbWloTnVC?=
 =?utf-8?B?UXZra1FIa2VMbWdhQk02ODh4SFhsV0pNckVLUzk3YWlveTMreSt2RHJpZkdx?=
 =?utf-8?B?bG9CUnNNYUxUcGdHR2I5cFk3SElIQU5jVklNdFJqRDFvZ1Rhc1I4MUNSenls?=
 =?utf-8?B?eHlZNXd3MFZZSU9rMksxdTJYUml4d0l2R3R3OWt2c21jTDdDaWIvUmxyejhW?=
 =?utf-8?B?ejN3MTRQVHg2TkVnTlBRLy83NGRQczBLTUF0dHJwSGlXNTJ4bm1sYVN3RHFR?=
 =?utf-8?B?U1VrdmcxZFkwVHc0Uy96SFBpVnZTQXdNaGdIalVvRW5YUWorWWV6Q2dOUzZC?=
 =?utf-8?B?VDAvbVBnNC90aE1za2UrSUludmRlaDZYckZqT2t1TXpvc1VyeThoNDUveWpX?=
 =?utf-8?B?R3l6UFdFa2FlWldiR3JaMkIxQ2w4M2FLMURiK3ZacFJ6NTUvVEMxS3FTVmp5?=
 =?utf-8?B?d2ptVnZFa2dYQk1iSmlyc0pyOFB4TDczRTh5RUMvRktadnV2aTMxS0NITmJT?=
 =?utf-8?B?LytqMFZ0S2xsL0lFQngrWE5Db2ZGckNkOWVoeGpGakRYaEliYzNWU1Njem9q?=
 =?utf-8?B?OFE1SzJjS2RlMnFXeW5CY1h3YXJzYlNOOU5EaUFsNzVPcW1qZFZwVkFiMEh0?=
 =?utf-8?B?NWYzSnFiK3RPUW9zeDBCaW9sUXhxbDBIeTBjRyszV3Z3TlA5aVNBS3dyNU5R?=
 =?utf-8?B?eVhxM2RJQmxVZUcvV2k1Skx0MDRjemo3QzlGZXhGMFVWeHRERGt5Mlo3MlRU?=
 =?utf-8?B?Z2Z4UEZXazNzc1BTVzZXV3p2eHhaZS9Sc3NXTFczVVVjZUQ4cThETTZiYWZ3?=
 =?utf-8?B?RlhzWStsNGhYR3o1UXpHakU2SXc0TGcrS21LWUp0WXVXeGtyMGNaK0NiOXB3?=
 =?utf-8?B?b0NidVZZeWRPQkJremhJT2xkL2xURTF5Z2drUzQ0ZkNTcS9Gd1NUN3pGY1pH?=
 =?utf-8?B?SUtXR1Ewb0VRcDdVRU9ZVDNIZlIyQ2hWOG1keGMvMHd4bWJjOU9LMTAxTEZN?=
 =?utf-8?B?NXM2RndpclF1bVBTcTZFK1NBcHNyM2o3ZnpBdklIRE9VRkdUOTdCL1JCdUhU?=
 =?utf-8?B?dy9oWUhEcWJLb2dhMlV0djhmclIzVUtaMnFrcXdBb2dtZENTc00rbDVESXZT?=
 =?utf-8?B?YjEzamJQUDVMU1NYQlgxVklMQ2lVSW9UU3VjL1N3Q3BGYkl2aCt0Rzd4Y1Zu?=
 =?utf-8?B?czFINFdsY25mdERDZEtjZjdXTlJqOTJMcHNYdEwvRzJ2d01QdmF0eVdIRG9W?=
 =?utf-8?B?WmRYNW16K1FFTnV3Y21sUXFYYmIrNXc4bjZSS3FLVWtJV3k2d2c5dDdhUHFQ?=
 =?utf-8?B?bGd6dGliMStTeGZicmFhVENONlJFTXcvNkxYUUk3QjA1VVVFU0Q5bUVCQ3Y0?=
 =?utf-8?B?S2pyWnk5WUJLYTRsWWhUcmtBR3FWdXlhWTM4dWl4RWwrMHdCYlpaVEhaNTd6?=
 =?utf-8?B?Qm9BNmQvL2o5cXNMYWppVlpTdlVIdG9iL3ZSZXJIWVBwVi9nUThNQitzVlJn?=
 =?utf-8?B?T3V3MU9uY3ZLVlJRMHhCOXI2aUg0VDVYRTZCY0RMZ3NIRUZLY3NwUnA2dmww?=
 =?utf-8?B?b0diQ0RaaGNMNlpQcC9ZREtQNTFQWDJ0VTUrU2xOaVdSRjJEYk4wVVNWNEZP?=
 =?utf-8?B?aHhtWlgvQlJ3eSt1a0grV2t0OU1NRXIvaDJYN0dhRllpM1U3Y3BvZEZCQkds?=
 =?utf-8?B?RXRnOUhqRi93RjlrNnVGOEVMZkZVclh5amdBalpqTDJnUG41T0R3cHYyL2No?=
 =?utf-8?Q?S6K7cria8o4he3c7Kvk0ABNR2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4373c66b-1306-4c92-09ba-08dc86e15c35
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 11:02:45.4647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7WE3vyah6+axqGH0m9aGQ/bwlFj6aXmSz2cORhFFYiRukuvVbkfbvFgh7myKlyt47vV3ZYwpWr4ceHjtbaGL2Tzd1vFTW2t862PXXP06A4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6745
X-OriginatorOrg: intel.com



On 07.06.2024 09:06, Aleksandr Mishin wrote:
> In case of token is released due to token->state == BNXT_HWRM_DEFERRED,
> released token (set to NULL) is used in log messages. This issue is
> expected to be prevented by HWRM_ERR_CODE_PF_UNAVAILABLE error code. But
> this error code is returned by recent firmware. So some firmware may not
> return it. This may lead to NULL pointer dereference.
> Adjust this issue by adding token pointer check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 8fa4219dba8e ("bnxt_en: add dynamic debug support for HWRM messages")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---

Thanks!
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
> index 1df3d56cc4b5..14585ac476c8 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
> @@ -678,7 +678,7 @@ static int __hwrm_send(struct bnxt *bp, struct bnxt_hwrm_ctx *ctx)
>  	if (rc == HWRM_ERR_CODE_BUSY && !(ctx->flags & BNXT_HWRM_CTX_SILENT))
>  		netdev_warn(bp->dev, "FW returned busy, hwrm req_type 0x%x\n",
>  			    req_type);
> -	else if (rc && rc != HWRM_ERR_CODE_PF_UNAVAILABLE)
> +	else if (rc && token && rc != HWRM_ERR_CODE_PF_UNAVAILABLE)
>  		hwrm_err(bp, ctx, "hwrm req_type 0x%x seq id 0x%x error 0x%x\n",
>  			 req_type, token->seq_id, rc);
>  	rc = __hwrm_to_stderr(rc);

