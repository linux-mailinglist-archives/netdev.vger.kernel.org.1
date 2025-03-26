Return-Path: <netdev+bounces-177681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0116A71294
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 09:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445361896162
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 08:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E2019F462;
	Wed, 26 Mar 2025 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZuGgW+6C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B534A29
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742977485; cv=fail; b=rEJP/qsp17764Z+mYOCaBiGSk4GB+SdbWJL2GoPjjE9pc6xRCcGmIKxZ3AJOmQMHmCIAYdYabS2aL/mHxGXpiPRZnWzkhdWssPVPvUpZL147zBeqBWszp9R8fQyNL6hEzdaPyg2tiIX2hwkL7sKKQmICCCxwtVcSNRNEzyFHkUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742977485; c=relaxed/simple;
	bh=zW6hiNgjJFhsOdSpHTBXTC7eyW7ajti2eMj6g0SnFLo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D9W9DhfMdZZWja9k94Jugomiq2vywj6q+22Z5V818mFISMkKl+RreDsrWinAVVaXYEjW2+UT8cmwRZUo7NcTY5VVwucqYE6epPcpu4iZhgqgcWu3+7CEe3Bw52dP5jSDfIS1Ik1zgfm7ARWkx4X+JKJsDElQgGY43b8Db/m0BuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZuGgW+6C; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742977483; x=1774513483;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zW6hiNgjJFhsOdSpHTBXTC7eyW7ajti2eMj6g0SnFLo=;
  b=ZuGgW+6CQwsFhU8oUyhMAXCCkvbuNVNF5oVxHu24/xRa7XgH9PVH4blw
   7fJBpYY/47TZJcu3mnEzK/9tUHp/nPeQMQdywBxOxJnzCs/yfQ0xV3FRY
   VnMTPNwE2Uw213dLsomnIKse9V+eFHbQgcJJhnWNpefl0D/F4+0SIeFI8
   O0QHjCaz3K0+KVe1OL5XLQDrtLd0AcD6btcA+vtbRnK8hVJ1bRpLtHGIv
   DdaijKnk5ZizL/IKWDaWfLJVB+geTbBmOFb8iKlYetI+EdHTVAJCClcTn
   sxa/FWEIZA01Mo0s2JY4O8ezT4b1/USxmWmg7mCWFHUVI9oQmAjVNWMrj
   A==;
X-CSE-ConnectionGUID: NlEsyw9vSSugk3B4vZ52mg==
X-CSE-MsgGUID: /1tzvIAVQSaDFGqA8kheuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="44354479"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="44354479"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 01:24:22 -0700
X-CSE-ConnectionGUID: loEUaoHyRIW5rsSJ2gTS2w==
X-CSE-MsgGUID: 7FYMcUTyRJOnfb6okKmnSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="129536784"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2025 01:24:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 01:24:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 01:24:21 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 01:24:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBLBgR48xhaxAd4TcqGG0c2iM61ktiFl2olEQqKi3t588+1EDw0cU7JBTnz9CZ5qJz7h/FEbkmbOTw7Ppp4yNIfuVR1Btpsd4R6VlwRXFFjCdXkeqexE78TlLXo9BkbSHVYY9+iO12jIO//3wAxvff2f0T0cEeIvCZqngMOhT246kepfaOeHHMFCrefPzeIsWqB9EeLh8Hb3Zbal5Zan+pGcjcJEtS0quKKzoKOWguhWmLDiHi23Xv23Lmt96Bt9MnW9eZSrSxR7QOffFb8hx26ptXrETNF8BGQf5M12RBb96052eiHh6NT3ucL8yF1Gr3sV++ZOgAzwWwzyP5LynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq4DfbL2pghX5i/7MupR1azC5htBbEaSFb/bXUMkjEQ=;
 b=bRplF4iaEV7tihpppyOCqNykbJ8GVTafVcXbkVAG/QQsAlJf0uk0Kf92zXg1CAe/mNKgNsi7LIJxEKX2AulZf/dwGoWxfSgii4wQPFaX60iRmrNOktmLv6qED6Zn5WCLx+Cy/rC8i9jH4qB8SJrWouB6PGu3nUZSNGd7s29FCuDqPyeyeRWgEFKkJkrdvVMScoROk+Io90R0adA6tULxz77ZNafdH1Tw+NUd3QXjyzJoQXTxDBSunlXxlC5b78AK89hRuHf6MXWaMBdDJh9URqulr/0UR0i/7S/p6Rc6TAUe+F8aJ1Guwa5VZJZ+1fo38Yi8Ad0RjsUM5ZpkvL5nVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ2PR11MB7646.namprd11.prod.outlook.com (2603:10b6:a03:4c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 08:24:19 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8534.042; Wed, 26 Mar 2025
 08:24:19 +0000
Message-ID: <0aabd732-3ccd-4834-beb9-5a828c226b72@intel.com>
Date: Wed, 26 Mar 2025 09:24:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/10] idpf: negotiate PTP capabilities and get
 PTP clock
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Milena Olech
	<milena.olech@intel.com>, <karol.kolacinski@intel.com>,
	<richardcochran@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Willem de Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>,
	Samuel Salin <Samuel.salin@intel.com>, Johannes Berg
	<johannes.berg@intel.com>
References: <20250318161327.2532891-1-anthony.l.nguyen@intel.com>
 <20250318161327.2532891-5-anthony.l.nguyen@intel.com>
 <20250325054956.3f62eef8@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250325054956.3f62eef8@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0003.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::6)
 To MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ2PR11MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a321fcd-e4c7-4450-18cc-08dd6c3f9a8a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjJWMTBnRnpoTjYrNzRCVGJYK3k5OUU5N28wbDJKUk8zY1RjdnZoT2RvM2c1?=
 =?utf-8?B?U0NFZGJnUjhJU2hNdjNrN2RRa2VpNWdjbGl5NEt5eHhlNU9OOFUvM1pNc01I?=
 =?utf-8?B?MWVzN011ZUk4RGpTUnI2S1hMdCtTcVdsZG9ycjZZRXJvbGpIanVsNWNnTjlF?=
 =?utf-8?B?R3NwdFBSSGozUEd4NW4zbXl2UE0rdW50KysxY05NaTBXb1RtZWhYTnpwZ2pp?=
 =?utf-8?B?a0E1WUZnUnVUenBFRE90bklhQ3VCTXBMcTZORFR1WXY5cXlGVmlIcXVLOFBC?=
 =?utf-8?B?V2NneXZWZk5lYmdLQmdPWE96cE1XdXFENk1LTHFtUlFaT3BLQjNoQlJuK3ZS?=
 =?utf-8?B?NGxQekpzdEN6dkd2azVOU0p4YmdkNSttd0k3WmZYZW1MV2JqZmdZVWFNWWh2?=
 =?utf-8?B?TjVmWTNOUzZQTU5OaHp6SWtYNFlOTEdLOUVvSks4b3BEWmIwckJBZ25wM2dS?=
 =?utf-8?B?d1JFdFB1MWlPSEVJbTlmbUZoT2xFOFl5SXpkTUtKSytWQmMzTmhnQVQyVE9r?=
 =?utf-8?B?OGEveXdmSVdJWVY0UDFIay9oaXRZZFB1cG1meFd5b3NVcVk0My9tL1NqVDkx?=
 =?utf-8?B?QWxQbWFvdlozUi9zWnFrcG5Icm9yZ1hFd2s4NmVpTTk2cU1tSXBXQXRqL2kz?=
 =?utf-8?B?cWd0aXBFQk96YmorUjU2eVNVamYvZHRNTUc5ODgxT0VXWHlUVmdyYm02L09h?=
 =?utf-8?B?Wnl2Q0tZSEovOHE1MmJDQnFsTGdmYlBxVFdGSTRkcnhLRFBIU0ExRkhOQVEv?=
 =?utf-8?B?Nzhzbk1HWW5ZWXlaRWt2WHlOUHdTdXNkTlduN3JOTjNsL21WUUxaWTFMVlJH?=
 =?utf-8?B?VUc5TUdIRGh6MG5VbTFmTXRsNVN6QjZlOUt1KzJCQkQ3eXlYWWs1bUF1Sjls?=
 =?utf-8?B?cGJCeHJwZHdMZDlmaVhEVFV6bWFFeHQrSWRtM3RCczdGOTZra1UyTk1sSERI?=
 =?utf-8?B?alpVU01lc1g0SUVzaUpjQ05ycHNNWWtQV25sUDFRbDdIK054VFRUOE4xaDR1?=
 =?utf-8?B?eWxaNlZIWmZzbkhiYUtIUW11eUVFQjFiWjh4N3VOdG9UbjZvRVJadnFUWU5p?=
 =?utf-8?B?aTBseHdaTEpySUFXNkRPY3VDUFRQZGNEZlRnNG1lSXo4dXlQSHpIazhONVFQ?=
 =?utf-8?B?VVZUendIcjRRMUcxUGg0QXVlS2RVK0lGOGtWMzg1dTJyWUs1djFOSGhoUnQw?=
 =?utf-8?B?OFNDb0FRdjgrYWIwQUUvOUhWbk9PcERvaEVyUWxqRFF6aG95QnhPN3ZhUzM4?=
 =?utf-8?B?a0hhZW5oQ0xUWFdqVkIyNWpnZW5VQjY3RzM3aUZnSHFZWEtvb2taM25HYVJQ?=
 =?utf-8?B?dDNHd0dVWWxJVUtzOFhJZWxQRnl3Y1M3Y2dVZ2p1QXJuejM0OTNhZlExNFF6?=
 =?utf-8?B?UFVYUkZ3YklkN1U4T1E3R3FJTDIxOEVQK2FOU2xkZTNkWVh2Wk1XemFXNTMr?=
 =?utf-8?B?cjNCMXlHdXdDVG1BQTFsQURKRGd6T3F3cmJBZkFyZ1JoUUZaWStoYzNURzRp?=
 =?utf-8?B?QnlObGxTNDJkd09PSDc3aSs1K256VWFiZC9MT3o4S05WNEI4K3ZVL2lPU3lV?=
 =?utf-8?B?OTArUU1nb0pZWWs1cnBibS9WdG9qU3lPM1VKMHI4WktPYnF6a0xVcGFzSWxJ?=
 =?utf-8?B?eElSR0lBM29zRWs1YkF0VkJ2a2tqNnozSnZKRDRBeklFTlZlUjNQczVkaVdO?=
 =?utf-8?B?WFdEMWJVWmUrLzFDQ2pMOHRpU1NWcUZhVUZyNmVNMmw4YzZwTHVDMlJJa2h5?=
 =?utf-8?B?amY5T0c1MDg0UU9kejc0YWZRRWF4R3ZuRTY2M2ZSejBDS2hwTzV1aHhmTWtC?=
 =?utf-8?B?K203c1djRmt5Nmt3UjNtaGIrRjFIYmc3WWZTaVI3Um9MRnZXS0djZjdIODFU?=
 =?utf-8?Q?UlTPJ8VJ7mm3y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L28zZSsvbGp0Vmd4RlFXQm45UXRuTHBRYktIRDhMVCszSFQvaHhhUE00UGpC?=
 =?utf-8?B?VjZna21maC9BRzVmZFg1R000OGFZbjBTSlBwOVJZR29WVHRqWlVDUGRWY0ww?=
 =?utf-8?B?NHYrVlhFN0hCcHZSa1NDZWlybkJnYmozSnZZWEtGbGpwbk9NL2FMU0pQbHRr?=
 =?utf-8?B?K0dLanl4VFg1Q25reG5aVDBWWDFpQ284bmsxSlIyT2RQUkpJRmFoS3VZcE1N?=
 =?utf-8?B?bHovOU5PcnNEdnU2UTJkVW1WMXhpTlM2dkhITkUraTA1bjVwSlZWUU5JYzRi?=
 =?utf-8?B?TTk4N2pheUFWemlVRVhqK1NWT2luQWpvdWtjOTVieGJTZHBmTU4vSjhqRHZ1?=
 =?utf-8?B?RTZEWU44SUY1RGlrdWxkdEZzSzh5czdUV2pHWXNEQ2FiVnlBWVA0OUNIUHJK?=
 =?utf-8?B?ZFpYODhITXZySnFPY283ZzJqeHZTZHNrVlBoUXJJdnExZTZiRUtMa2FVWGVy?=
 =?utf-8?B?K3dKNWFJM01WNFF1c3JnekxDbjV4VUIxaFJ0ZUtVcmNVZi8xaHBGemJGVCt0?=
 =?utf-8?B?WlZtOEdkWldSRDc0ZDFYeThFaytMZHM0TDRyRmJHVnA2WDZGdTZQSnpuZXdr?=
 =?utf-8?B?dTFMSUQxaHZscjFHdGxaOTNzK1RvVkQ2Y2hmend3dDRsbldKZzY3NjFXd1Vj?=
 =?utf-8?B?UUVqYW9waDhsZ1d4U1ZQWVZVNVp3WSt6ZmFUNXRHMnRwNmcrNWVDdnluYjM1?=
 =?utf-8?B?WVZWaDF2TEZkcC9MUlozNHkzajJLb0l3ZDc2L1I0ZUxXRUdtTUQ5R2dHRjc5?=
 =?utf-8?B?c2dOa2R2MVlacS9weFFPUkU1YUJhTUVlZE1yUEJtZTJ1aEFwM0NkV3J2Z1VX?=
 =?utf-8?B?NHJSRkkzeXVjRHBGcDB4cFQyMllOZndxWkxQSUR5NFdDcVliSEM1K3o1dERF?=
 =?utf-8?B?TTFWRnQwNlMydjBPN0NYUEJZQmRYRExwUTJDYmVGTHZYUkw0N0Zhc1Y0ZUdy?=
 =?utf-8?B?MnRjZjVOaFBEK0FlRXpEMXB3VHZnN2pRNnlqZnc5VytBNDNQYmloSWhXWHBK?=
 =?utf-8?B?ZU0rdmN6bSt0S055aUFxN1hOWXlPeGhxc2RQZjVQNk5vS2xua1pncmk3SVZB?=
 =?utf-8?B?RmNYTDVRSlZwTTdiMlY3b2JyTUZjVU5SbG96emkzOXAxc2N4OTZtYkVGQVN1?=
 =?utf-8?B?N0I4NzhDRFNUcWExaC9adzFYOXBaTEQweGdDRDJXZmlhamYrbyt0QUNNd1Bu?=
 =?utf-8?B?OHBBbVhmUUNvZXg1ZDU3ZGs0R3JUQWF6QlBqd0FnVExjclZ6YUVyTVdwOURl?=
 =?utf-8?B?ejNTQVFVWUN4a1pXOUlBSFU2a1BOSmZkVkt0MCtpeGhoSDlidzdZWEdpckdB?=
 =?utf-8?B?RURRaGZjY2U5bkhVdWx1Undlc2w2UmlWd0ZXaEJVc0ZUOStybHoxNmsvRUNk?=
 =?utf-8?B?ZVpVZTh0anh2N0NuWXYrNGRZSUhCaG1Mc0Fjb3UyczYreURYN1YwS2RTUkVE?=
 =?utf-8?B?anpER0Y4c2Q2UHhucytNZkEzVkNpaGJ0MzQ2MzVNVVIyWDJLa0R4WDlSQjNr?=
 =?utf-8?B?c2Q4VWxvRVhDcXpHRDgzbWhJOGpiSFk4TjJkSTVMcm44cEVvYTRNbnEvMXFF?=
 =?utf-8?B?QVh1MjVDOVRDRXVtc0ZLcnBReGdaMTB1MGJSKzdVdWgybW9LM0RGOGN1NGoy?=
 =?utf-8?B?SGt4Uit0aXFNMnozT2lCampXRDdkSHRxWDIvWnE0aUg2bTdGMEQ1QUtXYVcy?=
 =?utf-8?B?UXZOd3RJTmlDOXhVc3krMUtScG1uTk90VFdCRTF5ampWdjRnUXZsQVJlYTFm?=
 =?utf-8?B?cFNWOWIvVGNoL0duM3ZOMlNIV3VUYTRMRTZCODZiZmMrVFJONWEwKzF5R0NW?=
 =?utf-8?B?YU4vbTVkMTM2d2w0a1M5VENZL29aOWt0ZkNvRHVUVzFOazVqQkRlSFgrdjRC?=
 =?utf-8?B?M1FicFpxSXVkbHdwYWRFNU8yUkwwbVNaQXRBOTNNWG1JekNtUUN2dnFpdTRR?=
 =?utf-8?B?cDFaRWNvL2RCNHpKcTBKUlk0ZG0rcjlrdE1RVnF3ZWwzRVBwUmRrdFZEU3FJ?=
 =?utf-8?B?Q3RjU2I2R09wYkN3c2pxN0hlbVVGSUxwQUhDZEsyc0lBSGpJeDhRQWplVEZh?=
 =?utf-8?B?b0I3YXVTSlpoU0tUclZlY2RMbWRsSzdQc3I2YnArYXBFZDFPODRDQVJpZU8v?=
 =?utf-8?B?Q3FpVmc5RWFkK1FGclVWRVJSajF6MXZTSjJEVlZwV1Fob0FNemd6cmVmQ0xh?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a321fcd-e4c7-4450-18cc-08dd6c3f9a8a
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 08:24:19.0124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILfd5gPSmFoR2lNU88+fn6ATDcSjuwbfQaIDk3iXg5+9kXYQtY1G6nBqZ8D/ZrapdAsXPWmzsO/CeRx6Camt61qtVaoLPkxHEdq9md8WPRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7646
X-OriginatorOrg: intel.com

On 3/25/25 13:49, Jakub Kicinski wrote:
> On Tue, 18 Mar 2025 09:13:19 -0700 Tony Nguyen wrote:
>> +/**
>> + * idpf_ptp_read_src_clk_reg_direct - Read directly the main timer value
>> + * @adapter: Driver specific private structure
>> + * @sts: Optional parameter for holding a pair of system timestamps from
>> + *	 the system clock. Will be ignored when NULL is given.
>> + *
>> + * Return: the device clock time on success, -errno otherwise.
> 
> I don't see no -errno in this function.
> The whole kdoc looks like complete boilerplate, but I guess
> it's required of your internal coding style :(
we have mostly followed what was mandated, which is much more since
commit dd203fefd9c9 ("kbuild: enable kernel-doc -Wall for W=2")

Even if sometime our kdoc comments provide value, I do agree that it
is rather a boilerplate. We have noticed your comments that kdoc is not
really required, but this series started before that, and we are
somewhat skewed to play it safe and keep the comments :(

Perhaps for libie and libidpf (sorry, it was libeth...) kdoc would make
sense, but for regular drivers, "@adapter: the board priv structure"
gets boring really fast. Keeping kdocs also discourages splitting
functions and other refactors

