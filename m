Return-Path: <netdev+bounces-117698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155AF94ED6D
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 430BCB21971
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C037A17B50B;
	Mon, 12 Aug 2024 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fg8IZBPZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249BC53370;
	Mon, 12 Aug 2024 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467303; cv=fail; b=lqfVEwSDZNMZtcgSCFji0KRY3R510MkkzhadT3QSyAVZcDYznfVNMAxrapxcrn8w8vzt24+rE43e2OXWcETPvMWXGLLzZ3fZVYSSXJOaSex+K8VCi8NGiHEVCqgnGzoBpa6+J4yYyWH+xmJyfXZmZMwmJhnCjfddbUJI3r2VX/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467303; c=relaxed/simple;
	bh=AsUVXDqetKPOnouRkhgOBXjYWiQWWWqkyvQ1GDnAJMQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p71Bm5YFa+m2TWDj3JXb9JnDMwgL0YtVVJibhqf8pb5vywRvNY78EfRBykI9W89fR5DjvXigOoeVc3hqqQCN6jfd3GSYOePqWRJK5JVEFi3KFH8SmF/ZUPhmfFMfW3H12Zn9q4xdrnTJithQPPSUAIUIWcdTpPOCprhIHzP0lzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fg8IZBPZ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723467302; x=1755003302;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AsUVXDqetKPOnouRkhgOBXjYWiQWWWqkyvQ1GDnAJMQ=;
  b=Fg8IZBPZBhECurcdFCZPjoNPYnBGWB0bDObWalBRKhi/aHVDO2xyv+6u
   aVXpwdTcdqUw9vChX7BvxfnRoby2bEgkA5yUcAOzLn2gizjhb7ZuWzLWn
   QQvhkZn+xSsoz+fVGITx+YmQLZKudax2ova6KZGDIJu4V/rM+ASFdo6s+
   cpT3Auh5CNUBxC5SLgaaoxASsJof/vKZMtb+SmE8W45hyorkM9jTaRlDU
   b1NtemYFHT7Zylie0ZirQ7P2z+PvPl1tcqBgwymMvxm2nTNoeLY07MOJy
   6swJzejUDZQOWaBdo7GDztty1Ic25WvuQwEJwTrwB3aEW2fNH1HeIxyQL
   A==;
X-CSE-ConnectionGUID: yxUohtLZSHivXK4wOA2buA==
X-CSE-MsgGUID: faKZDfqORO+WdTICziYnpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21138615"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="21138615"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 05:55:01 -0700
X-CSE-ConnectionGUID: TEudxyW2RNaiQXfmQHuNTg==
X-CSE-MsgGUID: o9ZQtk+wQsidEO3enkP8OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="58960645"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 05:55:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 05:55:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 05:55:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 05:55:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 05:55:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0Je9KCc2G6aT1AFTpCxXpd1xxvys9lSp21Kuy+a4h0H2OkRNx9+C4IvYvBM/rIIBWK9QoLpZSXNCDaDZNkH9KdrpADzZY3cSElsNdJ5Gs0DLdfOq8yK5Tt4SQtSRNBFNv3b9xTwFDEkLrx7lTSe6YAUXQVJT4ZlBJhXwLDIY4/H2iohgam26ICRVO9b9sZUyeBB8kEqfvEWauuycmLxD5v/TMsuts0VhZRIsfI6Lv9OZxIqa6/0nZ+PUvWQDCqWgirIfgKENPpOsDdo+snyLG+Vre/Q0yvV1NyUla/ynE8jHjO7eCcP4VaaN9q5hKeW6zDkSYxl+8UtjZH6oJWa0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYGFMGUorWlZ7huQ80jX6L1kfEY3vhxOl2TEkk/wD4k=;
 b=HWseNH0oty8KlclehD2mhlr8Zc00mdpRpY1UPWWbyWq8yuq2O/WTiknP9nvk9WIfYyvAucR58OTHmHwTiwT4TNxQS5PoIvRlKz8/+ZERYLTDFoevgAKxXZbTchHOuaqhClp2D9+UjpH8Td42TbMqlCXFJalsNEJeZeBF7E163bMOBFML3JsPXqKHVyc0iKIu8O5s+G/1NkWt14B+zBG7EbOAsbHQsVQJHDekTyn4wtM34d5oBdmikFwWj0srCYn1X/GwimJWDRYNz+2JmGXW+J9wbmumYx+0JekY8U2THXlwZBjq2HdULDno4dHVO+kDzAvskMt0IbKIsIwj56nC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30; Mon, 12 Aug
 2024 12:54:57 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7828.023; Mon, 12 Aug 2024
 12:54:57 +0000
Message-ID: <f057f74b-07fa-433d-b906-011186eb86a7@intel.com>
Date: Mon, 12 Aug 2024 14:54:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] cxl/region: Prevent device_find_child() from
 modifying caller's match data
To: Zijun Hu <zijun_hu@icloud.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux1394-devel@lists.sourceforge.net>, <netdev@vger.kernel.org>, Zijun Hu
	<quic_zijuhu@quicinc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Takashi
 Sakamoto <o-takashi@sakamocchi.jp>, Timur Tabi <timur@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240811-const_dfc_prepare-v1-0-d67cc416b3d3@quicinc.com>
 <20240811-const_dfc_prepare-v1-3-d67cc416b3d3@quicinc.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240811-const_dfc_prepare-v1-3-d67cc416b3d3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::10) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA0PR11MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: e0877e59-b019-4a83-8d06-08dcbacdf7d3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ck5JVkJQd2NSL0FwbDlraER3WUFtZ2JDbTJOMFFDUDhVQ0ZYN3gzT2owWGdJ?=
 =?utf-8?B?Y01LWU9ucHY2UmJlNXhnMTNmWStTZVpEeWRhUXhhdUlFOWtTUjhPOUx4Vzlk?=
 =?utf-8?B?Ris2a0hvbFdHV2lmaWp3ekdqdW9MWVFXSDVHTTdLK1NlaGQveU1xVFRzd1F3?=
 =?utf-8?B?cUtVNEJpTXN1U3gxWU9mVTlDWUJSOTdabVRuTnB3ZU9DUlphMTZUYjE4R21L?=
 =?utf-8?B?MnlLKzNXVGtwKzBIcHVweE0rcXlTZloySWJmYVZMc3lUMWl5VzVDSStPZnMz?=
 =?utf-8?B?OGdYVXdMTWhFNGNqUncybFpMaE5kUlhQNXNBb2RyY0VocFRaakFpVndhbWx0?=
 =?utf-8?B?NUdNV0hOTUdDcEx2a2xPREFJU245OUtrZTRuL3JFWEZscjNvaUhabTl6QnYz?=
 =?utf-8?B?eU9MNCtnWkRJdVFlQUxEK1ZiQVFkMGdMMC93UnlBWmlVQzVZcnhKcHJWQ0JL?=
 =?utf-8?B?QVJMSVdhSlgxdDFXdHBWZEw5TkY1bnFGWmNqR2hRdm8xVjRKOU9LT0lHdHhj?=
 =?utf-8?B?OEJPbDEvQ2hXdFdvZVdkTmRyOVQyeXJtVFB2blg4Umo3eExHNUJyemVyM2Nz?=
 =?utf-8?B?MGZmOG1yNzhhdWpXdkNMOERMQ2tPckVEbmFkcGp5a28xTmNrRmlRTVRjZUZT?=
 =?utf-8?B?TEZGUG9NanIyU2g4VXgydmluaXYwWXVxbm03TGFKbStiMTJwQ0dxek5LN3JP?=
 =?utf-8?B?UGYySUZ2ZVdHNDU2MVBVWHhaaUQrN3JLVmRTTkR4NDRVZjdzT0YrdE8wdk5s?=
 =?utf-8?B?NThJUjB6SkdONy9oZDROQW92T2I5aUM0YlcyTFI3dHBiYUUwMGFSazhEK2Iw?=
 =?utf-8?B?UU5CT0NOSldKWDF0aXI4WU9wTjlST3ZTZXVRaTNsVjQ2d2Vncm4zekw4bFY5?=
 =?utf-8?B?MG04U1RwYjFxNE9UOEErSU5NMTMxQk00ZVdmaFhncHNNT1k0elluejNUNm9G?=
 =?utf-8?B?Y2JoWXJ3SXFXOWV0R3l5R3k0V0VFMlY0d2cvb0hHVmpEZGRVR1NHTzFxQVRW?=
 =?utf-8?B?Ynk2azRzOTQvOXp2YmtMeTlOckRQUHFmZkhKTWJmTy84U3IvczVxL1d4enlr?=
 =?utf-8?B?VzVvK2ZtOGFvMUs3RndiVi83Wk9YOG5yYjNMQzZQZktDU1BpT1ZRQXVsM3JF?=
 =?utf-8?B?N0cxcnlFRVowdHU0UW01MkNONXl0ejBpbXVmSUMyUEJsVk94dWI5MEg2T2M1?=
 =?utf-8?B?UjdTb0JySytkeTNSSjRKV2hzUDh1dVRHMDRHYmxGUWZ1Mjk4ZDh5aXRkenV2?=
 =?utf-8?B?ckRCendEL2FqdEsvUW1vV2M1SVBwdWE0WGwzNEFjaVphMVR6eUN4U0VPWlQ0?=
 =?utf-8?B?VEJWVWRQMVQzQ3NNTVRJaEt5WGhkTGgxeGtHUmxCS2h5dzBCTU5jYytPaHZB?=
 =?utf-8?B?VHNSeFpVT3ZYeDlHbkxJdjNyVXpldnpBeHRiUXV2WU1KZExZNytleHExVXhV?=
 =?utf-8?B?RTR3c3FrNmdnSWRqNmxUVkVJMFN6MW5Td1RtSWh0U3IvYjlNOTZKeTVnR3JT?=
 =?utf-8?B?cG9pZ0NNU21XRmdUZFFEaGdoUTMzN2NXbjhCMHhCeldwMzEwV1NUS1VDMytO?=
 =?utf-8?B?THpBTExiTnBzNjd2NStiQ0RjN0Z5STZDK1lEdlVuWm1vS2VFN2oyNkN2eFc4?=
 =?utf-8?B?alFybnQ1Q1ltd0hVL2g5S0xoTmg5RDN6clNwL1MvT2Z2VzJNWXVveHUzcHVh?=
 =?utf-8?B?a0Q4YjJON3hMLy9ML2QwQ0VrRXVleFJZQmFTRjhsVlV1UmFTbVcwYTdaYno4?=
 =?utf-8?B?TGE0cExvbnBicEpDSWdYUXR5Zyt4bllEay9pZEhSTXBNWVd5MWNxZlA4bnU0?=
 =?utf-8?B?OEhpenV4RnQrbWEyVm8rUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjdBeFFreU5KTDZkc1hnb05qQnEzZUVoNmR0eEV6LzBhY0NEVE9QeU9uVnYy?=
 =?utf-8?B?ajNrUkdEYlFyZ0NoYk50YzhpTlVQc3l5Q0h1UzdsdGphTU1DaU0zejFvNGJJ?=
 =?utf-8?B?ZW93WFV0bkFnSVdldWhKbE1JeVkrZ1NKblFhN2lxU2g4NCtuNUVkOVhxSXlC?=
 =?utf-8?B?bXMxbWtlYUt5bmNST2NPUXFVdjVxY01zVTZhczJXZDF0ZXc1OVFYb0ZPTEdW?=
 =?utf-8?B?RkJScE9jSSswK214dHJyODQ2L2k0TFRYMGh3bFNhSkNUWGl3MDg2WDZvTG51?=
 =?utf-8?B?MWVJWkR4c2ZnUStCbjVYWURrcEZVRTFJWVJsL2d4K0lUYzZJZXBIZGdTQVg3?=
 =?utf-8?B?M2JaZ2wyb2phcGRKQWx6NXAzdjR2ZE9PM3Q1YlQ2MEZWSEgwcHdXb25rZXd6?=
 =?utf-8?B?KzZFbURnbEJwZ1VxK1M0aDVreVRBR2p0NU5sQ1FsNTNtYVpsZ0xJeW0zT09o?=
 =?utf-8?B?R1dDVHJkVERuVm1HRDcyYnRHTzNoajZST2ZqOVE4NjdIOUY4cWwvdjRBSTMy?=
 =?utf-8?B?ckR0QzBxNkFLRVJ1VE4zOFRJM0c1MUNMckRJOENxbkl2OVJEdEtUbGNMMFEw?=
 =?utf-8?B?dHl5TEJEOS84NDF2eVBkTW9sL2NyaWNockhBaGdwMkdldGw3cnRzNnNmZlNF?=
 =?utf-8?B?QmpXSTBoT09XUW5wTk5Ub3J5RnVVeXVyaFAxOTB2RGgwVlNjak1TQXRTSEti?=
 =?utf-8?B?bWlWL0xtVTRjSkhTTzJaZ0VYRWJ3M0padEJOd0pFUnBmZ0xJdHlhVmRnYjRK?=
 =?utf-8?B?UUdCY21VS2ZKSlBLSGUydm1OaE44aVFOMGRkWTNCdWFhbTkvUm1aRTUveExV?=
 =?utf-8?B?S3N4M2xnT2gxTEF6cHhxaWwxVTBkSXkyVXRQeEZkY2NzY2hCQTF2dEs1dDBD?=
 =?utf-8?B?eGViSEhrMEFNMHZWM1NHVzgwNjUrSTRERVJKb1NsTzRGaTVVZC9GQjN0RDh6?=
 =?utf-8?B?R3ByT0llaVVWZDQ1MkpqaDUvU2c4akRJQVFiSmdvSEFXV2s1dzRKRWYyRnh3?=
 =?utf-8?B?c1Frdm9vOE5IQjdsUE1tZ3pKbjgvSVJZUWpmbmNLN1FNZlhvOTVUU3lKazN6?=
 =?utf-8?B?QUNncjlCZlFNQkdwcmZDQnozWVNKSTZZWTk0ZzQzdU9NNGNZZ2YrQjFNOFY1?=
 =?utf-8?B?NFpuQXIvYTlEK3h4T2xLRFlDMWN3UWMxUEJDcEJBWTJMbk8vckxEV2JoczY2?=
 =?utf-8?B?bnlHekRlYmR4TUg1Z2dZSVFLdnNVdDcyWmdGSG0vclV5RVc3WURiWE9LMmRt?=
 =?utf-8?B?QkxMc0pUSUw5bkRTMXdzYnJEbnN0dXJXZnR6K1ZFQ2huOHV1RTc4c2hHR2ll?=
 =?utf-8?B?M0NhUCtTSzNVY3VvbThQdFdVOGsrZVZDYWZuVTJ5WERKRDdLYXZidUw5b2hP?=
 =?utf-8?B?ZXZub2I1MmJ0L0dJRjJPdGxuVkpPb2laU20wWm1neGlLWC9CSUZNeWttWXEw?=
 =?utf-8?B?QzFoNHV1ZlhuTWdlUkxILzc2SE9mK0t4ekJZVWhEUE1KaXZsSG4rMi81dnc5?=
 =?utf-8?B?eElqQkIvbXNiUVhjSllVVFBvOWhjeGN5V2phYmZBOU9rQkRQL0hNSkxXNjNH?=
 =?utf-8?B?RG9Kclo4aU1NRTZkdlFVUnNsNFJEMFJMMzVPdm5OYWNKa2NyZ1NHakpTaEla?=
 =?utf-8?B?SzQydUdZWVQxSGxPY3RMZ0tHWlpjRjNNQW5waVRPdC9zSldjZ1Y2ZXUvK3Bh?=
 =?utf-8?B?UUowcDV3RFJ5c09uSlV2b3pPai8xeDVnc1QwY3NqVDU3NWxrUlc0QkNQU1VX?=
 =?utf-8?B?SVB6T2pVOEhuditld1lNUEUzandSQ0JNNXlCM1dzTGsvZFZNMjhyTFdhWjlp?=
 =?utf-8?B?cHg3djQycmZSYmZFRlVDQlFpUWp4ZmJveTJ1ZUdtR245TDl5WDY4UHFCOUR5?=
 =?utf-8?B?SWM4cUdUQlNpY0FxSnZrbWM1aklQaTV5dURnMTZaK0V4T1dRMTVsWUdoK2Zy?=
 =?utf-8?B?R1M0eVhwRms2SXZxaDRWNlgxYW5UWGphTWlOYy9Bdkt5TmxQTStJcnpTVHpD?=
 =?utf-8?B?bEZqMUlocUc1Z1MyeHFnT09oNHA1VkNEeFpLbUUzKzhzcEJ6MDhCdzZVTVk3?=
 =?utf-8?B?R1RDcDRYN3EwUEFJUm1nYnlmRjZuRERhQ3lVZlFQMkcydk9uN2txdHliSHov?=
 =?utf-8?B?a0xNQWNucnF2dW45K054MU5vUjhyazV6b3JRbEJITHBOVEdmSEVaRGFWelNX?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0877e59-b019-4a83-8d06-08dcbacdf7d3
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 12:54:57.0560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMawLN6EyTgx56melGgU1SrCdZ6C2YUVIE0tHBzs6BMz9dDCKCdv4f6a4YyfWGjFer4+XEDa0hL2TZ/GGnxaVnikT46qdkhJZx2fG9ptKmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4527
X-OriginatorOrg: intel.com

On 8/11/24 02:18, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> It does not make sense for match_free_decoder() as device_find_child()'s
> match function to modify caller's match data, 

match_free_decoder() is just doing that, treating caller's match data as
a piece of memory to store their int.
(So it is hard to tell it does not make sense "for [it] ... to").

> fixed by using
> constify_device_find_child_helper() instead of device_find_child().

I don't like the constify... name, I would go with something like
device_find_child_mut() or similar.

> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>   drivers/cxl/core/region.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 21ad5f242875..266231d69dff 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -849,7 +849,8 @@ cxl_region_find_decoder(struct cxl_port *port,
>   		dev = device_find_child(&port->dev, &cxlr->params,
>   					match_auto_decoder);
>   	else
> -		dev = device_find_child(&port->dev, &id, match_free_decoder);
> +		dev = constify_device_find_child_helper(&port->dev, &id,
> +							match_free_decoder);
>   	if (!dev)
>   		return NULL;
>   	/*
> 


