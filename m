Return-Path: <netdev+bounces-129023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6873A97CF55
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 01:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99ADA284C46
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 23:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D4D1509AE;
	Thu, 19 Sep 2024 23:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ddDo8XUv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446861422CA;
	Thu, 19 Sep 2024 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726787284; cv=fail; b=RTormy+bebTO7mbuawzn9TS+I2zTeBbeF1fKyHH31o71U4dvDsfpIXRqxBVXQDA1kj6s8FyEY0LsUWD+towo++oNBaqr4QYWwqQFIRroizW9SYJXn7hvq/Hg86cgeVFEQKalYFdEqvNJPI3zy37szI4HYb4IFiPjqpXJJVOXYUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726787284; c=relaxed/simple;
	bh=fVUpNRxatVb+RVprRaGyciCl7PObj1Ua2MgYmXLYkww=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZLopNaF2AthNhWZnh3FVvTUsNeWUqEgdjJFNOzKENfaCGSTuQtK448nvvh3Z0p8YoCxyrbNoQNmjR0ddl0iu3FvHu6y70ACzF3TzR59lwiLEtgK+2AwebtRDFXJWrAdsKlmE16ZI0D9G98HFXE8/m/iqKlhLnKyMVDzSkZwHiyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ddDo8XUv; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726787283; x=1758323283;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fVUpNRxatVb+RVprRaGyciCl7PObj1Ua2MgYmXLYkww=;
  b=ddDo8XUvyrSXBxQPEmO8DaAIh3BUhs8+EAcMD7/RxD6FydfZ8JNw7OPt
   UE01qtgNMFRjHU1UkyYmGEH43woVark3J/HiJwG0pLphTnymrbNHir05s
   NGmjbz70OxWhLGyMK2sf6zsqtFiUMTzlRu0IYBmPqcoUtUEQzyLBHLeXk
   SSWEfBmJK65HOg/zERxptwIBHSfR5W1irLKxGgbhcmWlUuzXAg7WLdgHi
   KMyrRXviQdQCnP00LbZnca43H+6BX5aR/qmRsQMD/e3y4d7ZaGwjw4raj
   sLvBg37zONU3bIqQ9hsBMAV3OCU1z900o1C5648CGuBYJ+x5JmuEcCpTa
   A==;
X-CSE-ConnectionGUID: 5Rr9kQj0RbGcCvX2qkEYvQ==
X-CSE-MsgGUID: /yq5YYGVS3q7o1JR4rgJQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="36446048"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="36446048"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 16:07:58 -0700
X-CSE-ConnectionGUID: BAGhBMV7R3ii2VUJBXH/rA==
X-CSE-MsgGUID: nDgdsaeYQwKnJYw9O6QzIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="69963546"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 16:07:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 16:07:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 16:07:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 16:07:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbvjZb33AjEvHLicrqnm379/7sBsjh+b7K/37qN/0a/0rzvjzsrpLT4rzweMTGxF0c0Z8glyBg6A4x9Wk3CpK9iA8Y16oUK3nVccl1hUwD0HF9YQQksWg/421PTb1pDnQMd2uqnADo20+K5dlW9WP6X4+IidZH51FW+0edW4xgPi5+KAI5YOYtTo+w+iZu3iWYnZLDFFpeA8xEChfRL4GkeyU0iF74rK+ZIXRMpgyok3lmH73/EoR77KWQNRqn/B8F6HcGDC1DTiVu/nikPmv76oV/q0QwkxwemJ73xVBZIXveGBBQdVvcBsYxDWebvnFPuhZeO1sqAySGgsEdMPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eVter21LQZJvJKVL3pr6hwRSw46TggHiW/20ASatnk=;
 b=v2NK9KUH9ZEI9v9RTrcLrAzpsOVYBmH3AtSwwmkPOC1DGiUI9vwdlKkq8Sf7pbTIu+PYYxYYY6ROCyysv4heYM49Zpx/VvcUSZtkTqBxKTo0Y/5Gd5dCT6vm8AjjHcnZSo6GXaVnAl1sfcKufNhtYMsh2TzeNvLRg8A1U3YdS7nfRbao6GZI+N2sR4yAJUHE2M9yXP5jAjMgUZG1zucSuu4euye7hDaUYmKOhVjfYcnTaXZTu3HMfPyGpKn9iesnMm9vi05ie00vPHF1XGjBWH8IbMkMoqopU+A5DuLsSv0ou/4lavJmHjPqC6MCtBjbPRjm1OGIRkugKipjRXAq9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7091.namprd11.prod.outlook.com (2603:10b6:806:29a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 23:07:52 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 23:07:52 +0000
Message-ID: <cf1c5cc5-58b9-4b89-b0d0-97bf7438a2ca@intel.com>
Date: Thu, 19 Sep 2024 16:07:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fman: Use of_node_put(muram_node) call only once in
 read_dts_node()
To: Markus Elfring <Markus.Elfring@web.de>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Igal
 Liberman" <igal.liberman@freescale.com>, Jakub Kicinski <kuba@kernel.org>,
	Madalin Bucur <madalin.bucur@nxp.com>, Paolo Abeni <pabeni@redhat.com>, "Sean
 Anderson" <sean.anderson@seco.com>
CC: LKML <linux-kernel@vger.kernel.org>
References: <e7caae09-70fd-431a-9df2-4c3068851a35@web.de>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <e7caae09-70fd-431a-9df2-4c3068851a35@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc56d74-ae5a-437d-7d6b-08dcd8ffe354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3BQYnRTR2hBeGJFckNoUFZhZWpYZzJ3SWNKcjBYd3IvcEIrM3A0ampHZlhm?=
 =?utf-8?B?L3JFWXNjalNBTjFuZFJxM214WjNKR3RQWmczaTE3OUVJdDlNRUtnQjFqdTNY?=
 =?utf-8?B?bDliK2M3NWhnV2VIcUpJUlNpQTVlbTZkbEk0M29wMm9pNm0vMmxoSUZkQXJT?=
 =?utf-8?B?V0p1TTNsY0lkVnNyYzY4TXBNT2c0QS9FRDBxN2c2ZWpJcWVpSnNiWUltUXV5?=
 =?utf-8?B?dUw4TVhVTzA0Nnh4eG1HUVZEOEhpSndKcXdSdmIvQ3Z0dlFHNHVhS2RDYlNT?=
 =?utf-8?B?aEpWOERrM200dDFnODBmSXZDemVFblpCS1BucFYzd0YvbFJIN0lHUkhzbDJJ?=
 =?utf-8?B?MmlRNW0ySmJsZTNzUHQ3MllGL3UzRThUUnBVQVkrU1NIbGhtdUZwdVBqNDFB?=
 =?utf-8?B?TzFDNW51WE53Rzg2bGJsNmQ4aFdaSUJ2cHUrU213U1VEZWZydWdhVG9VS2ZR?=
 =?utf-8?B?MjAydUJ2ZXY0a2R2Wm05TFRDc3l3czMya0g4N3dxQ2R2YVVEQVpScmRNbU5o?=
 =?utf-8?B?aWxtYUNDOCtsYjZnTHdCUmJ2dS9TckxsYTNqUXN0YnlUZ0FQK3ZORlRvRVZH?=
 =?utf-8?B?UmhyWE5JREpPVm8rL3h1TGJwSFFzVTQ5RGJxMHliU3dRcXdTWnZPMUN6d1Mv?=
 =?utf-8?B?VjRDUUQxb1F3dEwvUGpsQnI5NVErRnZHWVdZcnFEdndnMFhxeHVudmpHd0ox?=
 =?utf-8?B?Y0VkOVh0L0pHUlBQbW1uYnI4T29JT1FaWVNmeDh5WFdaTitoeEkvL3dMYkFF?=
 =?utf-8?B?TjZNTjNlYjdIV21OS2ZyZmRFT2NOb1NkbTIxNWkxSHVacnZOYjdVcnF6WEpt?=
 =?utf-8?B?KzZoR3IzMUdiNHVUVU1uQWN0a1RUTHp1d014U09LaE44MXZKZTcvR3NQRi9Z?=
 =?utf-8?B?SVRTYVZEUThzM2lYVnFaYjhDR0M0YWQ0L1Zad01rMjU4MnlmT3hFOC9XOS9t?=
 =?utf-8?B?dXM1Vi9HVTc3bnhCOUJpZGZpaFlDdHRVYjZieUEzWEE3NDlRRU0yNk80ZnM5?=
 =?utf-8?B?OXJZRDJFNHRQYzdsSHRTdGVKZytIOWt1VnlaVkRyQm5NQ3luRlNpckJJUjlD?=
 =?utf-8?B?QzFJTlNWSnRWQ3lCVU9qUDRYNjYvNDVTSkZpdGg0SDJuWCthQzhzRmphc1lQ?=
 =?utf-8?B?VXdMbWpjOUw1Zmp6d3dDdlg3cU9yK2RkY0x6TUphWEprMFBWaXRHT2x4Uko1?=
 =?utf-8?B?cVhhTzltc1ZraEJPd1laWjV3RXJNVWdIbmxEZW0yMU8wcm1XdklMWFhZM0t5?=
 =?utf-8?B?VGEwTDl6TklJTHhjUHpvc1hsVXduU3VVajhWTU9SV2xLRTc1bW1wby9LTG1O?=
 =?utf-8?B?eWRSOEJCT2xGbUM5YzNBVUlTUkU1SHIrcTYzeDlxUElyQ2UrRGNmNzdRVk1h?=
 =?utf-8?B?cTM5N3ZXeExqVHBTaU1ZazBGV1QvL05ZTnVGdkJyQVpJUGk4QWxMbFBzRGp2?=
 =?utf-8?B?dGFLaTU5aXR5WWhSbG90M3loNnFiKzFJVWkvWEZCNkNTeGVkWVFLdXdId2ht?=
 =?utf-8?B?aEZWVnpSaWlqWFhNT09yTnZNeUE2ZUl5TDdRbFFxaStBZ1Y4T2tLTDJOeVZE?=
 =?utf-8?B?aXlnYXZpS2xCcXFPSWhSZnkwSzEyVHY2QnVZcno0UTVBUFlWaVljdUFFemQw?=
 =?utf-8?B?ZXJ5OW5ZYmNEWnFseE1qbXpmVnNyY2prUzRFcFlCNXN1TnlmRGF3ekMyZlFy?=
 =?utf-8?B?ZlF4b0pHaHdUNlk0VjdVdTdKSUVsNXBmdmUwUWlOOVRBK2VReWUzc1F1SC9h?=
 =?utf-8?B?ZktiWmQyMytUdlplTnVkRXRWN3ZPek9GSm1nTU0zcUFQNmlwaExmVzN3U0gv?=
 =?utf-8?B?YkVYQmtubG1Zd2FKVWl3QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEVxMXBIc0ZjdXIydk02cDlZbjdZV3RBWEJCeTU1QU5LOG02azh2anhzeVpl?=
 =?utf-8?B?UGM3YUpsVjNNQWcvOWRubjFGQ1hrQ2JFTE15c3V2eEJIQ3BaeFpPTjVwOGZD?=
 =?utf-8?B?dzZ6aVZTYjBON2NPZTB0TXdyYTkvTGoyeGFRRE5TYzhWU1owUUd4d3pHbTNY?=
 =?utf-8?B?OTFVY2hpUURtWjR5YjFnZ1N1VEh6dXpLQ2w2VEg3d1ZwN25Wd2x3a0ZnL0cv?=
 =?utf-8?B?OFJ2TGdoa0k0L2hhTkt2ZVNKQXhVcVpnNlJ5eUw0Mi9YWEdDaWh6OFlDNnF0?=
 =?utf-8?B?N0FSSVZCNDNHTVZtVEVmcC9JekhJdng3WkZpWm9OSTVmUkxndTVIODQ2NVlI?=
 =?utf-8?B?eGtHaHZWSVN1dUxTdGZQUVlib0F5aVFpNm5JdWxuQjc4cVBuZ2xMM2IrNVR2?=
 =?utf-8?B?TEt2eWszUEh2WnFoTzM3anhteS9GYVhTR3FnTnR5dnJ6eC9NN1NweEpYM09G?=
 =?utf-8?B?MklHZFNmL3J2cThNaTNscCs4ZUhGNmhROXdNaytJU2V5c3lCeFgxeVFvU0V2?=
 =?utf-8?B?QXFCZjhLZmgrMWRaMzVaSHM1L3J6UDdmalFDZTZVUHZjNWJKTHY1Lys4UFFT?=
 =?utf-8?B?Zmdrd2k2WjNYQVRkVDdJWDlxNE96aXo4aVFkcEs1YUVvcGRyVGIwTnhtbDM4?=
 =?utf-8?B?eW10YXAvTDhRdlMvK1lIYmIxRlBFWENVdGtDREIrZVRpNzVHY0NCQWZUZHhU?=
 =?utf-8?B?Q3NLaDl0TDN1Y29XVWF5b0huOEtyaDVMV3BWcVFBMGxLVkJnUXlSUlhrdEZo?=
 =?utf-8?B?ckdMenlscE55QmFwV3BxQjhpbGVSblVlYStGY1JWUHorWXZMWnhrbklrRkFT?=
 =?utf-8?B?TkFYd0FzRnRRN3hVaUg3MUxuM3dDT3BJbFRDZllvb3JpNnE4NTNZdEV6M0Nm?=
 =?utf-8?B?M1lQRytVSUgreGIyK0FmRUxzeFR5Ukkrd2JrbWtwaUNkdys0Mk9sc3RyWnNL?=
 =?utf-8?B?OHZVK3BaKzB6UFRqc1J4dzdGMGJsWC9LemsyWDlkNzY4NXB1NzJpMHNvbFhq?=
 =?utf-8?B?dmlEcHlYNnVYTGorUUs1L0lLMTd2ZjdraEVwcGhSQ2RkTko0Mjd6VmxsUS9L?=
 =?utf-8?B?dkNXR2hhbkdRMVNhWW14TFZDbGdnK0FjVktDcFVuMjhQQ2N3UTBzd0xXNTlL?=
 =?utf-8?B?aFFISjdjVGtWR0xJT2hvWk10akdmUUVxRlZBN3hhaHJ0TWZpUGtTUFQ5OFg0?=
 =?utf-8?B?djdHZTRjaU1YMU8zd0luQ0Vwa0RPQWVQVWEyY09NTGxtMlNzQnVxTWthUVJO?=
 =?utf-8?B?SFZsdmlzcmFWTXByQVlyejg4eXlkRXo5MjUzNFNsU1FWY1JESnFRVG9CYkov?=
 =?utf-8?B?dDlkVDJtd0NmNHQ1ZDJNWGd3ekNwekh2YlJ4aUVVSGV6c0V0MElmRFphK1pu?=
 =?utf-8?B?aHBjeEF0WXVUeTRhQWkxM3g3OHVVSkJQMW9NdXg4RTUxQjFzRy9zUm1qRzRN?=
 =?utf-8?B?TmJNcVFRNUROUEMrMnZrMjB6UGUyZG9TVWFHQ1ExUjFKYXF5OEJYY1R3a29Q?=
 =?utf-8?B?OHhDNnFmRHBDVGtoN3NtSktFVlJFcjBMV2hZOTJBVjVabVZnZk55OXBMUmhZ?=
 =?utf-8?B?OWFVUW5MMzQyd3pNV2x2QzRvUSs3UFpyYW9NNEc1Y0liSHE0RlBIRkcxUC83?=
 =?utf-8?B?NTFzOU1KWG5TemkrWm5mb0c5Ry9hOEFwMmNKYWtKRDBWdzR3WW5qcUdLbkNk?=
 =?utf-8?B?NkxLNHZmQmxSNEx4dXRoZjlUTjcrVHgzWWtjbng4ajM0Q0U3K3hLNGpmeDZL?=
 =?utf-8?B?SHIwY2R6bTBhbXRQZzU2TzgzVnZqZERSRE9oOW0rcmZLZmVSR2twMGJqb294?=
 =?utf-8?B?RVlkUSs3NnJvSUsxNmJSZnFJUmRjVXkwZ3dPczgyc0lPd3pHbHdrK1RWd29z?=
 =?utf-8?B?eTZsTUp0ZnliNDYwZVpmN2Z4M0pWMEt5Z3pFbDc4VjRuWVNMcUZFSUx3d2Z4?=
 =?utf-8?B?RlhicjV4SHRKV2lHY0Nrb3dITWx5UXFGd0tSQnlzTlozZjZiaVl0UW1vMEwr?=
 =?utf-8?B?U2wxdU5JeTJlZkV1WFFEeVM1MEl0eHNtM0U0TGJGeVN4SmlMZGNVbVpiV3FR?=
 =?utf-8?B?dXhJQWhVaTRhV2pTT2l4ak43N0dmTmNKbm1CVEtwVzRrYUdhdndxZTg1aGFP?=
 =?utf-8?B?dXdPR3NjdmpyK0dnbjRkTVp3cjUxTE5jWE9xbXIxYlpHTUNVZlZoSDlRSkdX?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc56d74-ae5a-437d-7d6b-08dcd8ffe354
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 23:07:52.5399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBUTxAXE8fUWhuKCuV/k3h6KJ5+omT1QKlE92Z5CxdASP+G0I8l9j6MSGr112m3cq7vf00cF3zBB9sgYWb0RMWH+TAzRtFKEmnE2YcX+YQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7091
X-OriginatorOrg: intel.com



On 9/19/2024 9:15 AM, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 19 Sep 2024 18:05:28 +0200
> 
> A of_node_put(muram_node) call was immediately used after a return code
> check for a of_address_to_resource() call in this function implementation.
> Thus use such a function call only once instead directly before the check.
> 
> This issue was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/net/ethernet/freescale/fman/fman.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
> index d96028f01770..8c29ac9dd850 100644
> --- a/drivers/net/ethernet/freescale/fman/fman.c
> +++ b/drivers/net/ethernet/freescale/fman/fman.c
> @@ -2776,15 +2776,13 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
> 
>  	err = of_address_to_resource(muram_node, 0,
>  				     &fman->dts_params.muram_res);
> +	of_node_put(muram_node);
>  	if (err) {
> -		of_node_put(muram_node);
>  		dev_err(&of_dev->dev, "%s: of_address_to_resource() = %d\n",
>  			__func__, err);
>  		goto fman_free;
>  	}
> 
> -	of_node_put(muram_node);
> -

Seems reasonable.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

