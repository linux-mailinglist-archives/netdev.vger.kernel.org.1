Return-Path: <netdev+bounces-229577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06112BDE78E
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E08384F5E32
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303051DFDE;
	Wed, 15 Oct 2025 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BRo04WV6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C04E40855
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531427; cv=fail; b=XQy5L6ixQWvlZBuAxlF/Xf6CX8CMFzk0DAYyLUEx5MCU4q6wgxdpLZK1gLmuXPp/Di5XWXBVpcQ4/bSbS2PBgpNvXwxKYqrhH5zh4ljnibf6qK4TlX8syRUS0GCZkweQBz0mn2MfNIIzAuojnIJg/tLtqy/PZCZutYgAwlUQQYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531427; c=relaxed/simple;
	bh=Byv8LBekIGU6ZW2xlx/mM3vBtk0VnwRBFV9mM7oBs2U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JPDu+7EJ4sMB/Vn7NWSUuJFaAWFRbr6ZTF4DLGkKvWGuGy7TUlYRX/HIf6h6JQ4s02q0s8OAqbkMCNgMvbNCKJiHb/6Aug0Kz+RdVNF4tv55ebpS6WkzrYlfZoJXI/VH3gsSEeKtLB7aqeQZdpJ/V2W3Lxrt7DgnflWLbqcm9Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BRo04WV6; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760531425; x=1792067425;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Byv8LBekIGU6ZW2xlx/mM3vBtk0VnwRBFV9mM7oBs2U=;
  b=BRo04WV6jFH2ZbUK80wBd+9NIzdEhTEKiEtZnPTgP6dbUz1pqYRJV10U
   KnU5gNrHhUpOaRRNO2XEzbpom63vzHDfM8o35uAszfW867iKwqNCoays6
   b3sXsLp6/8a1hWxn8+WNUX8f0WSIRzou1JU3rhx2W+VlEJwoSvMkxNNi1
   03bIW5bvG4tOrXLaQmp46A2RIr5XHXrq4zGUCnjtT3Xb9bUMmEPnDOO0U
   15V3vG192J8QPfNaBy310SzB5mJO4viW4l7ediaDwLMHiTgTjKrtubqz8
   fQyosk5UvB2J3KOwD7qfTj9zMldUvHLZngyn89ieRDuI9wLkYRe5wbwRw
   g==;
X-CSE-ConnectionGUID: Yx5pUX9YSYK4AHpgtIB5EA==
X-CSE-MsgGUID: uUDj5XnwQR2RK0/yndKTig==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="65326718"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="65326718"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 05:30:24 -0700
X-CSE-ConnectionGUID: mcn9GBZqTQ+FqYdihWdIqg==
X-CSE-MsgGUID: 7kx1w6xmT/qZdUtotRsVlw==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 05:30:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 05:30:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 05:30:23 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 05:30:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhf+KLuCOMi7WnXJS1sVQE3Di6TNSQUqR6DP6m5rhCzAROZRSpGycV9haevU2xXV7F+DfG4MGvNjpaVm1xiJmhWCrAbLMZeQZMc7Fet+auijkiZog9OeIYLQGr7AnjPkmLba8eTBWjsyEW+aUkm9lXi661Ryh7iHZGHAdrc8xsU29PKC6N96C+bA5AACR/jtPn9tcSixuc+gN9lV8oUi6PZOWhqAipZOjSQZ1QTTAjZaHn390T2Guy6sirCb4wDaHvlnuRLJIGrDtkZ2zSf1OJ4KyR8Q8qRwNqE8gJzHrUsXKqJrjkwdt5zz8qxep697e1j9I9HfFjavFoYi+ZDlsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZ79SB02dH+mw6dVzDdx/3mMU9m5C8b07pVjzMEKZQ8=;
 b=Q5kFZ1jeNOYNFieRz2ecYeicia0zP47/FwinFlLZ6Z2yuONqyx4S0NtTOtbXfHXziVzLZp4YbSg3Gyy+apd8/AGhlbzQtM2rsTODimiynHHYYGiA8UHl3/SF6CQTVHnnzGtFQ8EO0v6aHuVGIhcIhEirioRpXP8sgD844thWJghZurc8PFz1kbWCQIWIPQny5FAF0wY8rChS2mDaf+Yihz3VBGnA6dt9HmEWVjOWb5/6Daa2Z3F31UfnEtjacpNxBLc5jWJ43cK2U9jYomqZ5S0x/IamgijHbyhkA/+IsBryPCyzu6WEtsDrdDToElp8vrj0NONQjc3lmlcg0J58aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB7538.namprd11.prod.outlook.com (2603:10b6:806:32b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 12:30:19 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9228.012; Wed, 15 Oct 2025
 12:30:19 +0000
Message-ID: <f51acd3e-dc76-450d-a036-01852fab6aaf@intel.com>
Date: Wed, 15 Oct 2025 14:30:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/6] net: add add indirect call wrapper in
 skb_release_head_state()
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
	<xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima
	<kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
References: <20251014171907.3554413-1-edumazet@google.com>
 <20251014171907.3554413-3-edumazet@google.com>
 <a87bc4d0-9c9c-4437-a1ba-acd9fe5968b2@intel.com>
 <CANn89i+PnwtgiM4G9Kbrj7kjjpJ5rU07rCyRTpPJpdYHUGhBvg@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CANn89i+PnwtgiM4G9Kbrj7kjjpJ5rU07rCyRTpPJpdYHUGhBvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZP191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: e553c48e-c59e-449a-ba72-08de0be69a0c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXRiU2EzN1BZL1Nxa3UzdEtJamNRVGU0elN2STc3WVJKWnNaT20wcGhSVFVG?=
 =?utf-8?B?VVMvMXoyMmVobmtkR3hKVmdyMUJQT0l4K3J2U3k1eHo4S2t2K2hRMWdLbEt6?=
 =?utf-8?B?QStteVpOUUVST3JVc3BpbkpWNnBKMDRtc0xFYnV0S2g2Q0l1ZEt2VlFGUFlV?=
 =?utf-8?B?Yjc0Mkp5ZDg5Vk55Q1l4RU1yS1lFak5uWDBSNnNlaXM2bmtxWEdOSGxpclU0?=
 =?utf-8?B?OFpuOXdkQlZBOWZQSVVrUXUzT3VocmlUcmhmSDFVMVBiMW42YXhBWGJPdDJL?=
 =?utf-8?B?SnRoZnRNdGgxQ1plelAwUHV6djRzRFBHRS9GeXBFZjJKVk1KNjA4WkdQNkZF?=
 =?utf-8?B?eTRUNnZ0cmo3UUNsMzhDOURWNFc3Y0FHclQvVUZySGI4aVhGQ29Ea0hSKzk1?=
 =?utf-8?B?WXpENE0xWUwvUG1LYWY4dTBxeUFKN0RxaGQzOUhMMGgvTVBna0YvZDJ3NjlL?=
 =?utf-8?B?R3hrbkRVR0MxalFVM2poZ25EVzQ4TWVZM1lsWmdoWE1oSDlwcTRYWTRJcmxE?=
 =?utf-8?B?UkdFejVNOCsrenNXL21zNDhlY08wYW5wVmxHRC83azZ3MGZpWHdnQThSbm9H?=
 =?utf-8?B?ekNDRXdjTm95VlVWb1ZGbWdmaEtjR0tsMGRZYnJCNlNaUWQ3MW14NzhYOEYy?=
 =?utf-8?B?bThlWmF4V0d5dkZ0YWlZUG5odzBZdlNDa05MRXNvakwrelJuODAwOVptT3Fu?=
 =?utf-8?B?Ti96Zm9tMkxKNytTVU9CSTNLQTJJRU8rSVFFZzk2bGwxM1llYlNoSGd0R3hj?=
 =?utf-8?B?MkgxbktZU1hQN0lDSE1paHY0YStwNnFJRFVZZ0FXK3FnV3FkK2R5VWcrOVJL?=
 =?utf-8?B?Q0d1Q1dYemNHNEwrdVprbExwTzBybU9iYjEvK3p3dnpXOXNqcFhueGJXZWl1?=
 =?utf-8?B?Z3E1LzZFNlp1RGFtY2hIV2NYYmEwb1lCNXhnZmExenNXMUVKaU1ERkgzMngw?=
 =?utf-8?B?N0hXcms4WUFzdE9vWHpOSUdmaGhRK2g0ak4xRVg4Zm9oVGRJV0krWm51djJG?=
 =?utf-8?B?OSsrc0lkRTJpWnpIVUd2dnd4SU9QM3pXZ2FVaHkvVytKbXAzTnFKK0ViZHk1?=
 =?utf-8?B?QVRGSkN1N3BHSW9TaGhMZWcrZHQzcDQ5QVB0czBkUjNaSEdrOVplbzVJOEo5?=
 =?utf-8?B?RUdiYmhkNlVnNzcvSkJucTYwQW5ORkRVOTZ1RWdvamF1L0NoZzlxckFVZ2du?=
 =?utf-8?B?ZXVvTUlhYzFQUUdwMWVKS2QrOFNnZWZoWWwrZVd6Rkg3RXJqUUQvdkVwTldW?=
 =?utf-8?B?a0RFZFVNc2M0Z3p2OFBIZVBNYWZEU1pHU3RzT0ZXK0UrTjEwV0tVdWNsSlRq?=
 =?utf-8?B?ajNEb1gxZndsVFVadnRta0xxNkhpS0hhUE0wR0pHbzZoZjl0Z0s3c2NFZGdQ?=
 =?utf-8?B?Y3V3dVd6eGEydW1vSFBnM2Q2cDUzM0hlamFLR1Z5S2JPdGNvRC9JdUJxZnFv?=
 =?utf-8?B?dytyWW5mTTVMSXlybE9teXV6bUlsWWVqTlYvTWwveHhjMUozTjA0RjYrSWRx?=
 =?utf-8?B?TEI1L1hFNENROWxlWFYxcGx2am5rbzZOZzhEbzhibnNsNTFsL1NjSU1nYU1Y?=
 =?utf-8?B?YmZ5OFhEdnJobE5iaGh1eTE5aDIybmtIUDVpdHZaODBFRFJGVHVrclkyMTMv?=
 =?utf-8?B?Rmo4bk9vRkFEcFlxcFBUVkJJdDRtTVJET2gxL0xTbjFIVGxUTGN0Z0tWRHBE?=
 =?utf-8?B?Q3NiQVlNY0t5QXNRSXRqcDc2ZFF2WUIvdEROMk9ucGR6cUlkV1NsTkZvWWdW?=
 =?utf-8?B?Ymx5QWJrc3dHZGxuN0NzaUJXMmhvY05PYmt6cVFRMFVmSUFTN2p0S05TVUVk?=
 =?utf-8?B?L1RGVkF0azd4UkcrQTJMczBJVFJIZDRjNGpsQlEyaGM0Q1I4RkNTRWFiMW5i?=
 =?utf-8?B?R3dYNEFCVHMxOG1OMkZVekdkK2RFZ1BlNlkyS2lmZDh4OXRHeTIzT1grd1ht?=
 =?utf-8?Q?LRhAzUgb2+7swy1BZI3REk+qr5UKzSth?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEpMM3pkR3BJNTFLVitQT0NpU0o0RHRJQ2xLVWg0N3dsM2JMbWxpalVyNG5s?=
 =?utf-8?B?RU5HdjUvMW5VSkdaTUxpV05lL2pKYm1TL2xIV2ZBSUk2b2tiTHRsUnNvdngz?=
 =?utf-8?B?Q1g2cml2SUIzdG0wRklVY3U0d1hiWHI1czlzQStQVWxJY3VQdUxyNjI1NERu?=
 =?utf-8?B?UlRvQ2k0SXRQZmhaUHlIMG1MQWErOXNXZ01JaFEvZkRFb3UwZ2tUendyT0xz?=
 =?utf-8?B?SVc3OWc0eGp6VmplN1NPZUoxdHZrQ1dKbGRDUDIyTElKd01Fc0RnZHUzRFBs?=
 =?utf-8?B?bTZsbnFUU1M2Q3dlNE5GM1NZTmt5MGMrUm9RZjl0ZzRqbFdJSXhoMUo4SW01?=
 =?utf-8?B?Q0ZBUjE2Ylg0MEZxclBaeEZ3SXJVUStHOCtOOGFmOFk0OFFVVnV3ZC9vNHdm?=
 =?utf-8?B?WEdReG5adHdLem54TGRtSS9jRTJWM2xyTFIyREVRZSt6SnR1UERrWGhCMFlQ?=
 =?utf-8?B?N1c5blVCQkZPSTZ2cEExNkYxbTMyVW5YcEY5c05tMXRkV1BxMkxrd3J4eHJC?=
 =?utf-8?B?M1pDV1Uyc0g0SlgvRmRWRVk2RmR2ZzV4Vlc0MXBWWVliRXh3bWZaMmg0TXRp?=
 =?utf-8?B?QUE2WDVYZllRZVpFUXcxdjkwSlFZZjIvSTY5VU1GRWVlNVdVT0pLbWs4bjRY?=
 =?utf-8?B?QjdzTXRKOGFOQnFvS1BkQmduOFZhZkVvUHVzOEtFSU12ZkRsRzJEVjNuWU9S?=
 =?utf-8?B?WVhGWHN2Mkg3TjkvYXIyNFlha0ZpZ0MzcXpkc2MyZGltT2l1emxhRmNjZmRZ?=
 =?utf-8?B?R2g5UjQycU5lWXFMUzRuOXpCTkNRVDZ6UmJ6UmRXcE82NHJMSUxqNjhvOEx3?=
 =?utf-8?B?bXYvS0tBOW42VHNVZ2ppWU5mSHNOUElmZUN6SCtDNGc3MFlFNFJHUWdLa2pY?=
 =?utf-8?B?NkVsRFFqa1M4L1lSL0I4VEh1dDRaeFBQNXV3d0pjWmlGcCs0emNYdExaN2FT?=
 =?utf-8?B?dXVpRG1weTZ2cE1WWHdGaGNWYkdoU0VEUVZjOEtkWDlkYmNiTE5hVyszeDZD?=
 =?utf-8?B?SG15RjQxRjRVcE9aSUd5MG8xdWRBQXhtRVA5TVRCM0hvcEdocjhNdnh4aTFh?=
 =?utf-8?B?NjVFbkZGVmE4WTRsSW9sM0NFSjBMQS9hOVFjbEdWRmtXYWFJYkNtTVV1UUox?=
 =?utf-8?B?VUMrZjJXcXR3RmRXa1cvSEhkajBPVmptZmpVTzNTd25DNVJYSTRiZ0lyQ3Mz?=
 =?utf-8?B?TUlTcms2RnBXUS9hcEpYUlFRSmFqa3Q3a3dZMEE2MHVtWUt0dTduMmh5UlhT?=
 =?utf-8?B?K3B1dzJ4OVliUUt0YzZtYkNSaU1QYkVWNFpweGljVXhZWXZmT0NFb0xSS0pa?=
 =?utf-8?B?aUE0eGVuWnY1a0daWlBSNzIxYkF5bGhvSUZGbWVvUDJhK1IzalIweFNNNGpX?=
 =?utf-8?B?cTh4eVZVNnRDcm12QU94Mi9tVjUvNDBBdy9DdDNwNzhlTTBERk8yVmZsV2t0?=
 =?utf-8?B?NVZvcXdpdmc1OXFmaEwvbjN3ZER1OGdLT1hETUQwUnN0QWZSWXd2R3BYZWt0?=
 =?utf-8?B?WDBZbW9oV0lySDBBQS85R2pWR2RUajcvTWJEUkl2S282M3A1MEZzaHNvcWZE?=
 =?utf-8?B?T0Zob3ZrbXlyUHg4RFQ2ZlFIWExCTnk0WEJ2YXdSNVVxTG5acjVIbk1OenYx?=
 =?utf-8?B?Wlc4Z2ZBQ3NsWkUvMDhnM0RyNEl0SHBvNVhmODIxNlduWUQrSmZJUEplVm92?=
 =?utf-8?B?dUdmQU8xNjdWcDFnQ1lDOVh5VHlZczdjUkFETlVXV2ptczVpbStReTZzbGp5?=
 =?utf-8?B?a3ZNeFp2WXRkOGlBNnVZZytXaXNUL09pZjNKVExRU0NFT25zR1I2UXVLM0NG?=
 =?utf-8?B?cWFFaU5INlluSGk2aHpiTTlNUmlhM3c0RDJqTnJBdDRRWmNEQ1dLNHBPbExp?=
 =?utf-8?B?RGJrM0dBMWhRSy9veUdaSCtIeUcreGh4VExxZUdjZ2dyWHdsdThvZm5VWjR6?=
 =?utf-8?B?SjRQL0dwQUdOa3FsdEdGcUswMHF4V0g4bndIanBRNXM4WXFrYUxWTUtDOHJp?=
 =?utf-8?B?YTE5OENQTWJESHIvR3ZtSEx1UGZBZTAwek90WHk4ckFRck5QRCtLNisxSVc1?=
 =?utf-8?B?U3pCTGYzL3VTRkRidHhmTkNjU0M1S2N3eXV3RUVPc1JoVnA4cWFFdzlmTnVC?=
 =?utf-8?B?cHh6eCs4Q0RYQ3gyR3JkMXNJSE9VTWRlWDYyRnBPT2dtL0hWdTZDTlU3QTNI?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e553c48e-c59e-449a-ba72-08de0be69a0c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 12:30:19.0178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVKtfUIH/Zo2qKB+iknl7wKUvPrimsWo19OHqn8AVL7/1XYrv9Fp3tIWZvS0sFgnYBFaWEGp/EsS8Yl24B9y1AUeKlKZb0guE/pkaJTduZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7538
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Oct 2025 05:16:05 -0700

> On Wed, Oct 15, 2025 at 5:02 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Eric Dumazet <edumazet@google.com>
>> Date: Tue, 14 Oct 2025 17:19:03 +0000
>>
>>> While stress testing UDP senders on a host with expensive indirect
>>> calls, I found cpus processing TX completions where showing
>>> a very high cost (20%) in sock_wfree() due to
>>> CONFIG_MITIGATION_RETPOLINE=y.
>>>
>>> Take care of TCP and UDP TX destructors and use INDIRECT_CALL_3() macro.
>>>
>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>> ---
>>>  net/core/skbuff.c | 11 ++++++++++-
>>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>>> index bc12790017b0..692e3a70e75e 100644
>>> --- a/net/core/skbuff.c
>>> +++ b/net/core/skbuff.c
>>> @@ -1136,7 +1136,16 @@ void skb_release_head_state(struct sk_buff *skb)
>>>       skb_dst_drop(skb);
>>>       if (skb->destructor) {
>>>               DEBUG_NET_WARN_ON_ONCE(in_hardirq());
>>> -             skb->destructor(skb);
>>> +#ifdef CONFIG_INET
>>> +             INDIRECT_CALL_3(skb->destructor,
>>> +                             tcp_wfree, __sock_wfree, sock_wfree,
>>> +                             skb);
>>> +#else
>>> +             INDIRECT_CALL_1(skb->destructor,
>>> +                             sock_wfree,
>>> +                             skb);
>>> +
>>> +#endif
>>
>> Is it just me or seems like you ignored the suggestion/discussion under
>> v1 of this patch...
>>
> 
> I did not. Please send a patch when you can demonstrate the difference.

You "did not", but you didn't reply there, only sent v2 w/o any mention.

> 
> We are not going to add all the possible destructors unless there is evidence.

There are numbers in the original discussion, you'd have noticed if you
did read.

We only ask to add one more destructor which will help certain
perf-critical workloads. Add it to the end of the list, so that it won't
hurt your optimization.

"Send a patch" means you're now changing these lines now and then they
would be changed once again, why...

Thanks,
Olek

