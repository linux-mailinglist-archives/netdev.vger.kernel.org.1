Return-Path: <netdev+bounces-116092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 490179490F3
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9BB1C20E6E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEFC1C9EA5;
	Tue,  6 Aug 2024 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeKahrNi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88931C4606
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950434; cv=fail; b=HmVEQVARqnvrhjho3rr5kKtOX5JymtPg+bVQDpJJALam/VKqkges9/HWOdYpHgRblzR6zwUU3dyeqD+VnfXfIxKQwYTQG+KSg9GFXd4WnLV7+g/rQ4oaunn313vNO9Tw3XEmI6vXMFN0GS8USMPtN8r5DAR8ppjOE8eoN9QZCTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950434; c=relaxed/simple;
	bh=X/QaP+7pM/tzl97tGqp5Sw96Ab9WIDjfXmja3NGXQPE=;
	h=Message-ID:Date:Subject:To:References:From:CC:In-Reply-To:
	 Content-Type:MIME-Version; b=dsJR4wFankCiiBuYYfG3C0iKK3/fKDvA9csgsjQaomsmC4wg5nJy6OOa2bYzSSm3PKGucNV38hz32gp8pS6B6AVjKCUrnjK+1ele/f4SrgitxgshpfAicQ6oYk0yczukBGSB6Q2M/0G1t8jGqs+iAbKx38468SyARJDB6QgCMRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eeKahrNi; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722950433; x=1754486433;
  h=message-id:date:subject:to:references:from:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X/QaP+7pM/tzl97tGqp5Sw96Ab9WIDjfXmja3NGXQPE=;
  b=eeKahrNiU0OXdno61GkHU6Q3K6iORavwtxU65shqMmgM3Y2bjw9WNFfC
   QiMnCbj+E11tJ4/PGx42fDmIOMHZoORQUZwVPOIwRxTZ7X+BoyRsSRw7c
   ZCKYQ7llMVPgusUYs7SLpNpyelqMGdoEDW4XzQyolVn9wFXr3kcUnVXil
   eXSEuV8YXMvQe2NceVny7RY315i8kfn1israykyCQlTQlvN0TlLXgdlSp
   9gYqwOIs/ofEpQvfRy5lvHxuNvNdYdHBsQ5I7refCrAxWAcoX6Toe6u12
   CvJBPZQTFT+OM3Ugb6RfF+6h3zaBhmB5dyx8Q6AYXkYgF5leSgLoBnhOL
   A==;
X-CSE-ConnectionGUID: D4Xy4ww/TbuupJfiHgm7Kg==
X-CSE-MsgGUID: QAdZreYiTceoqa9Wp3+NNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="24730888"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="24730888"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 06:20:31 -0700
X-CSE-ConnectionGUID: 75Cv3RCuRqeWlblsDApHHA==
X-CSE-MsgGUID: NTCOASf8ROmzbdXCbCQGMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56732764"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 06:20:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 06:20:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 06:20:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 06:20:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 06:20:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9jAM06wI0voTjWx1GfpLKkUX7qyooTi5AIEqnYkJesVsmczRjQxTNSo5Jymdxlhx/fHXeKB7JeKFwoUOgZFcMfxIosaOR6/ySIV+7kgIgwWWU1aaNOTgLU3WmCwpDVbanqxKvXkbDF8ibGxAqa7Y+e6ZaJRwis/XAzO7Kd/Nub3y1+l6rxj4X8jzt2YOl7GnECF95b1RKVMN4UmRIzvTHpVm/XiFVw94a7qc7lD/ViRUu4b0/p5RrmMlrKmkce1jpz9DJsoZG4uZ+GQMUNhbqB3kcQCc5IdB7GqUJjMhoit+LPhKdFJEJCPG3JFKJ/Je7aiNScaA+FmHriF6Vod+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gTWapKq9FerdAEAueCBBbuJLdxw19PMlXawFjeIBog=;
 b=ZYkm6AHXZz+aypJViG09tAAZFHyh5EaXdRUfWqIl7eljpAUGtGiF9uGk45MsFopJssPjkj9Wmq3INiyUJsnzdZuBEuqNm2Uq5VsJMRI9TxskMGCU6EWiWbKRfHu2vHo5ZL5gSZZVYUmMqfCHUHQgN1HwlBeFotOTcwIP/Qsw9IlF6ciSDgp7CiDLmrW5VQ1NlfHKZoZBv8kQg12CmfkER76wtvFQTn9U4hrhPezx+lXGIJkSFsYhzndkyx/YCOwVqvorHFLvg4AWrTbGxLWxIaIp/ryDRXV4/ASHRWDHGTfvUdT3x6gTN4iOOgiS+e/mC70RrUjI/RoR8hBy3rLcPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MN2PR11MB4661.namprd11.prod.outlook.com (2603:10b6:208:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 13:20:25 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 13:20:25 +0000
Message-ID: <75510d23-2ac9-4d83-b254-96712c6a8154@intel.com>
Date: Tue, 6 Aug 2024 15:20:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 01/10] net: libwx: Add malibox api for wangxun
 pf drivers
To: Mengyuan Lou <mengyuanlou@net-swift.com>
References: <20240804124841.71177-1-mengyuanlou@net-swift.com>
 <78F07A41FB029765+20240804124841.71177-2-mengyuanlou@net-swift.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
CC: <netdev@vger.kernel.org>
In-Reply-To: <78F07A41FB029765+20240804124841.71177-2-mengyuanlou@net-swift.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::15) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MN2PR11MB4661:EE_
X-MS-Office365-Filtering-Correlation-Id: 54643281-0832-46bb-74cc-08dcb61a88a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkdMRnc0MDVWSjFDWXZXVURYOE0zQmxCdUxOcFBxNGVSZHdCQXpOVEU4V3pp?=
 =?utf-8?B?ZnJtcVVOemxqYzVKcXMyUzdWMVdDVFY4NDlKWTg4VTRlK2IvRjltT2ExL3VW?=
 =?utf-8?B?TUNIckJhbDdnN1pQSHhaWnh3UEN1akVoSlZySXp4NkY4SUI2Z2x2ZCtjc1Fo?=
 =?utf-8?B?V01lWkRTS1JhTElOTFpIUC80NnR3M2VWSnRFTEZNREQ3ZzVtemRuRXh3Vmc4?=
 =?utf-8?B?V3lsQTRkek1CVWk5aFhEdCtrNXdMeitVODg2L0Y0MXpHTG0rUS8zeG1VbEpP?=
 =?utf-8?B?TXZJeTNCaXRUdHR6OUxuaURmZVQ3UkFXeUo1T1ZzSXExN3ZZK3VmanorU2Nj?=
 =?utf-8?B?Z0lLcnB2UHJ3eVRwZVgxRm9oOEY4MVpEaDJLMkh6RlIyenVXSzdkRmJ6QWFK?=
 =?utf-8?B?dzhNZ1JCdkcyYnd6MkdKZlB0dmkrUTRTV0FqWDh2T2lMZFRReXFXMmoxVFg3?=
 =?utf-8?B?eURoUktqTFRodUhxcFZRQndjNkR4YUlIWXFTUmVONlVEWjBPMXZvVklxcTh5?=
 =?utf-8?B?SjRveEd1dHZlU1U5YzVWS0xXU2lTcWwwNzdtVTE4ejN1UFRJNFMxaHdoWDhT?=
 =?utf-8?B?VDc0MGNXNktEbEJCaEJsVXpVc2c2NnNDSTNXZDdySm5BSWVtQVQzdHFUL2JD?=
 =?utf-8?B?VFVSN042NWRVbWlDY1k4NkpYMTd2RHhCOSswQ1hNN0lOcXMwMmhubHl0QlZL?=
 =?utf-8?B?aHhxYTNSNTdEMW1BZWt3U3E4d25MUlV6ZVgra2wxMWg3Y3k4MFFnODhxblNm?=
 =?utf-8?B?OGt3cGFtcEFaT3JtSE04Ujg0U0NDY0JhN01ZWExFN1RpclpqNDFxSWMvZzJw?=
 =?utf-8?B?RFcrK1U5K0tHTXJrdjBUMlg1L1hGTVprMEZiUkJ2bnpUd3UzL2RhZk9FRE1q?=
 =?utf-8?B?d3BqNXVXS1JOU202QkRZVVFud0toaGNqZVFVLzVtcUJ4aC9hRit6MnFvd0Ni?=
 =?utf-8?B?RDJaZmplU3did1VHakd0bytWRThyOFZTMnlvdThkaDU0akxNSWJUbVhOSTVQ?=
 =?utf-8?B?dWtSNkg5MklwRXpmZ3RjeDhxQ0VTM3pqVFZuS0gvZXRzWUwxeHlqcG1vN09S?=
 =?utf-8?B?TmNwS1BnMnBKRHU4NXRNb3BHaVl0UWxseTRGRFRxa3RQOFJYOXlYWFJlanl6?=
 =?utf-8?B?VW5QUDdQQkU3SUN2NjVadFNlQkJOKzdWV3RXK0JCdWNzZTFwTkczUzYvOGtT?=
 =?utf-8?B?VC9TYk1rRFNXQ29COGVWSGpnUlRNTGdNZ2tiTU5zYVZHVTZ1cTVVcUw0bmxC?=
 =?utf-8?B?WWRyaVkxbUFDVDZmTTl2cTZBNkk0ZkRPODllSVJYcVE0djVsY1FUU1oyK3FP?=
 =?utf-8?B?ZDlUR25JQlM0eXVTYzMzb3F4RXZNNE1LZVNxZHZkV2lMMDJoSGk5emNraW9M?=
 =?utf-8?B?aFBIakZXMWcrR3l0bGNRK0lrNDNsRkduczZyTjFJNldNYitXV3NIdFppZ0FQ?=
 =?utf-8?B?blhzUW5HL2xvSGVjYjNrTDVWU0UzWFYxNXRJa1FzekVBb1FzOVFvUlU4R3Zz?=
 =?utf-8?B?Z0hvVDNjYnlOTFM1Qk90MGJEMnFpV25pRFRvTFBiY2dlVjhUQ0hZWkg3cDAr?=
 =?utf-8?B?b0RIbCt6MzhtY2RXTkQ3TzJNUTBsazVZNUpZM2Y5ZnFPVHdwUko4SEs4MHVC?=
 =?utf-8?B?K2pUd0RwNnFFZDBSc2kyUWpOL0g0akNPOEVWeW5kZ3RPNEYrSG1uS3Y2bXd6?=
 =?utf-8?B?cnRqVXZNNS9JMjBubk5ZNGg2WHJBKy9uM0J3Y0NmM0t0eWZ5WFZ6YVA3MjN2?=
 =?utf-8?B?dEJtYlVJNGRFR3ZSRGJWY3NFVVVuNXZ2dm9NUjJrK1lncjdLdmlBd0JmWlVj?=
 =?utf-8?B?WGc2UEQycGxGSjhVam51dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2FuNzVhKytJR3BNVTV3bWdsYVJ6VzIrYlk1NitkR2JTeWtRSDUrbW4xZ3Vr?=
 =?utf-8?B?aXB2bG0wdU5KYmk4TjFhVkprOGlyR2lJS2Z1YUY1cVZyM3J6R2ZqRjRxY1NE?=
 =?utf-8?B?cERJelErai9CQUpkUkhCcXBlcjZDTUlJMjI4UFZRekpDc1h0bElFMUFvZDJl?=
 =?utf-8?B?Nk1ucUtGaDhJclAzcGZJWGxqRVhpUkRXNnY3N2FSaXhLdWpDQTFjUU44OFZX?=
 =?utf-8?B?OFdhMXpCLzZjeTdqNEhDTmQvVnhEV3JQK1FYTytiNit4Zlp1cHpqSHJLQitU?=
 =?utf-8?B?UWVsd0NWRHpWS2c2cmNhUGYvVDhZYkE3cUdFRmpJZXlXNDRITmlOTTNKNlE2?=
 =?utf-8?B?S0x6eWJYMFIzMEl6M3hyTk9xaFZGM292NityOUIrb1RJMVFjb1pzZTdBL283?=
 =?utf-8?B?RzdyOEhFZGE3NFkzVGNNWlZ1blkxbk5jcjdNakxCRzNoeEJHS0ZObE1KQjgy?=
 =?utf-8?B?S0VBTjhmcDFkby9IWk1uTXA4dDhBelk4TTNhWkxQQnJ5NnNkKytucmxjOFI2?=
 =?utf-8?B?eG56WTVPTVhTb3pYK2FSY3AzcUVZNGt1bnREb1FWa3VEeUhsUFdHbURDVUVk?=
 =?utf-8?B?LzZpNTliRXpNM2kvcWhaRE1RMVBXeTN0WmxJNVRKeGp0OEVTWHFXRlkvaWx3?=
 =?utf-8?B?WWE3Y3NidlpLV0NNelVyTUJHNWlOeG5hZHNnV2FMTzFmTzI2T2ZudkdidDd1?=
 =?utf-8?B?ZDdjNmpJZnVBRHZaSWVaTDN0S2pDRzc5UEY4RG9hNGFvRnF0RHZPdlhUZTFu?=
 =?utf-8?B?L1VvUmRzaS9JUThwVkYrVnYvK0hUcXZqU2xBTlFoMkozZEp6WS9vVjYwR3FT?=
 =?utf-8?B?aFBVRTA3L0JTbHE0QTk1WVlWSHJ2K09kaXNybGQvMXY2Y3lVQW16MGE5aFli?=
 =?utf-8?B?aWNjc3dwbFpmNGcyVG01UnZ0SkNSTHR0UFo2QVp4ckVDNkorV2VWWnkvVGlB?=
 =?utf-8?B?YUZpd2lIdkNaZkdIT094M01oMjhWZGZNUDU3T0Jab2pZczB2NllESURxMlNI?=
 =?utf-8?B?N3VwamJtUWN6QUFzSSt0dEZnTzFPdFNFenRvQm1PUkk0Z1o1Q3FDYVJDWUN1?=
 =?utf-8?B?YkE0YmVmcDFjR0RsRjR4bEl5dHIrMXQ3VTRoaDRNWEd6UnRKdThsVHJqM1gy?=
 =?utf-8?B?dFAyRWozd1o3aVFRaG4wbVFzVjg0ZmFXazVTc2QxUXluNG5vZU5WaVM3M0Ey?=
 =?utf-8?B?V3lIMUdWYk51RmJVY2xhRXRYbnk0elNYT1BaaGQvNTl1S1o2c2hMQ0grN0dt?=
 =?utf-8?B?ZWcrbHRUbjBQVzVYVGttMFQrVTYzMk8ralFuUGdYeGgvSUdweEQwaG10YWR0?=
 =?utf-8?B?M1Q0R0QweHpCcG52MUczRlI4TEFtMnB5MnlYWXA0OWFjYWpORG1jSElQQ3cw?=
 =?utf-8?B?VzVkaVhPUko0TEh4MU94eU00bWIwRGVlZEx5Nmk4QnRmdXBVRXB4SkdSMHBC?=
 =?utf-8?B?Q0xEa0hTZWYxL3FnWWNpRU9tNkNCTXhONU84WncwRC92eVJKQWNmd2V1bkl3?=
 =?utf-8?B?enFaQ1dqcHZYbVVkeDhqS0U2d2J3VVVvLzFWQjZwaEw4SnNjenZzSUZzM0hY?=
 =?utf-8?B?MmdUcVh3UkZSRks1bE14UnptczMzSHJGMElvUzdlQWVlQXRDME83MmdYWDg2?=
 =?utf-8?B?VExQdjZvN0Y5TFhPTHBvTnZxODlMSGw1d3pRSm02Uit1TDFSakdidlRicTlD?=
 =?utf-8?B?NVhlY3pOejVGM0kxNzdWRFVHeS8wZnAvQllQWW9QdDVnRjhxWUl0NDFvaFN2?=
 =?utf-8?B?QmhzV1pSbWZjZ0FkT0hNSThsSThVZnB1MTExOGlkYjJNd0pGbGwvUC83ZDYw?=
 =?utf-8?B?b0lKTDVYYWJUQkVTaE5UVnlSMHpGaGxMQi8vZzIzRnVEbjlERm1uMnFZVXlO?=
 =?utf-8?B?UFEvdWRVNnQ1ci93V0dNYXV0SlFvcWxFTVZFcXZsVTI3dHVEelpML3NpbHd0?=
 =?utf-8?B?NHBRWm5EYW9zSHVwdXpWcTNFYkJqNm96K0UzL1dLZFFMQkNhenRnOHk1d1VR?=
 =?utf-8?B?bG9BTEJCZXRqTUd2ek43R3YwRFZySVVocTQ3WFlFanZIMzkyVkkwUjhoRTEr?=
 =?utf-8?B?Sm53L2VxY0lUYWRoNnVSVXFoNGdFNDUwMWNUdnNweTVmRW1lR0YrcmNPVVVN?=
 =?utf-8?B?ZkVNRHV0eEpDSnpna3dRYjJyMkhtbkFTUEZsYUVFejM0bXpBZnpaZWk4MGxx?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54643281-0832-46bb-74cc-08dcb61a88a6
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:20:25.8788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRBEVsPKhryIj9tgE4rus5yCqYFjGLo3HWIVytmjj/MnwsOrfvPQzxeefbzscw4yl917KNYKET6X1CQVJDimlQZVJrxK1s9QxwdIbxscUEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4661
X-OriginatorOrg: intel.com

On 8/4/24 14:48, Mengyuan Lou wrote:
> Implements the mailbox interfaces for wangxun pf drivers
> ngbe and txgbe.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

it would be great to have a cover letter over the series

> ---
>   drivers/net/ethernet/wangxun/libwx/Makefile  |   2 +-
>   drivers/net/ethernet/wangxun/libwx/wx_mbx.c  | 175 +++++++++++++++++++
>   drivers/net/ethernet/wangxun/libwx/wx_mbx.h  |  32 ++++
>   drivers/net/ethernet/wangxun/libwx/wx_type.h |   8 +
>   4 files changed, 216 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.c
>   create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.h
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
> index 42ccd6e4052e..913a978c9032 100644
> --- a/drivers/net/ethernet/wangxun/libwx/Makefile
> +++ b/drivers/net/ethernet/wangxun/libwx/Makefile
> @@ -4,4 +4,4 @@
>   
>   obj-$(CONFIG_LIBWX) += libwx.o
>   
> -libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o
> +libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_mbx.o
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.c b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
> new file mode 100644
> index 000000000000..5062ddb2ce39
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
> +#include <linux/pci.h>

typically you put a newline between different subsystems and another one
prior to your own headers (this case)

> +#include "wx_type.h"
> +#include "wx_mbx.h"
and it's good to start with include list sorted

> +
> +/**
> + *  wx_obtain_mbx_lock_pf - obtain mailbox lock
> + *  @wx: pointer to the HW structure
> + *  @vf: the VF index
> + *
> + *  return: return 0 on success and -EBUSY on failure

capitalize the first return word

> + **/
> +static int wx_obtain_mbx_lock_pf(struct wx *wx, u16 vf)
> +{
> +	int count = 5;
> +	u32 mailbox;
> +
> +	while (count--) {
> +		/* Take ownership of the buffer */
> +		wr32(wx, WX_PXMAILBOX(vf), WX_PXMAILBOX_PFU);
> +
> +		/* reserve mailbox for vf use */
> +		mailbox = rd32(wx, WX_PXMAILBOX(vf));
> +		if (mailbox & WX_PXMAILBOX_PFU)
> +			return 0;
> +		else if (count != 1)

you should exclude count == 0, not == 1

> +			udelay(10);
> +	}
> +	wx_err(wx, "Failed to obtain mailbox lock for PF%d", vf);

would be good to ratelimit that

> +
> +	return -EBUSY;
> +}
> +
> +static int wx_check_for_bit_pf(struct wx *wx, u32 mask, int index)
> +{
> +	u32 mbvficr = rd32(wx, WX_MBVFICR(index));
> +
> +	if ((mbvficr & mask) == 0)

the preferred style is to simply write !cond instead of cond == 0

> +		return -EBUSY;
> +	wr32(wx, WX_MBVFICR(index), mask);
> +
> +	return 0;
> +}
> +
> +/**
> + *  wx_check_for_ack_pf - checks to see if the VF has acked

I would rephrase to: check if PF was acked by VF

> + *  @wx: pointer to the HW structure
> + *  @vf: the VF index
> + *
> + *  return: return 0 if the VF has set the status bit or else -EBUSY
> + **/
> +int wx_check_for_ack_pf(struct wx *wx, u16 vf)
> +{
> +	u32 index = vf / 16, vf_bit = vf % 16;
> +
> +	return wx_check_for_bit_pf(wx,
> +				   FIELD_PREP(WX_MBVFICR_VFACK_MASK,
> +					      BIT(vf_bit)),

double check: do you want to set just one bit, in the upper half
of the u32 word, that will be passed as @mask to wx_check_for_bit_pf()?

> +				   index);
> +}
> +
> +/**
> + *  wx_check_for_msg_pf - checks to see if the VF has sent mail
> + *  @wx: pointer to the HW structure
> + *  @vf: the VF index
> + *
> + *  return: return 0 if the VF has got req bit or else -EBUSY
> + **/
> +int wx_check_for_msg_pf(struct wx *wx, u16 vf)
> +{
> +	u32 index = vf / 16, vf_bit = vf % 16;
> +
> +	return wx_check_for_bit_pf(wx,
> +				   FIELD_PREP(WX_MBVFICR_VFREQ_MASK,
> +					      BIT(vf_bit)),
> +				   index);
> +}
> +
> +/**
> + *  wx_write_mbx_pf - Places a message in the mailbox
> + *  @wx: pointer to the HW structure
> + *  @msg: The message buffer
> + *  @size: Length of buffer
> + *  @vf: the VF index
> + *
> + *  return: return 0 on success and -EINVAL/-EBUSY on failure
> + **/
> +int wx_write_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf)

typically function parameters should not be limited to smaller sizes
than 4B

> +{
> +	struct wx_mbx_info *mbx = &wx->mbx;
> +	int ret, i;

best place to declare variable @i is inside the for statement

> +
> +	/* mbx->size is up to 15 */
> +	if (size > mbx->size) {
> +		wx_err(wx, "Invalid mailbox message size %d", size);
> +		return -EINVAL;
> +	}
> +
> +	/* lock the mailbox to prevent pf/vf race condition */
> +	ret = wx_obtain_mbx_lock_pf(wx, vf);
> +	if (ret)
> +		return ret;
> +
> +	/* flush msg and acks as we are overwriting the message buffer */

should the buffer be already empty? that's a bad smell

> +	wx_check_for_msg_pf(wx, vf);
> +	wx_check_for_ack_pf(wx, vf);
> +
> +	/* copy the caller specified message to the mailbox memory buffer */
> +	for (i = 0; i < size; i++)
> +		wr32a(wx, WX_PXMBMEM(vf), i, msg[i]);
> +
> +	/* Interrupt VF to tell it a message has been sent and release buffer*/

missing space before "*/", and your are releasing the lock, not
a buffer

> +	/* set mirrored mailbox flags */
> +	wr32a(wx, WX_PXMBMEM(vf), WX_VXMAILBOX_SIZE, WX_PXMAILBOX_STS);
> +	wr32(wx, WX_PXMAILBOX(vf), WX_PXMAILBOX_STS);
> +
> +	return 0;
> +}
> +
> +/**
> + *  wx_read_mbx_pf - Read a message from the mailbox
> + *  @wx: pointer to the HW structure
> + *  @msg: The message buffer
> + *  @size: Length of buffer
> + *  @vf: the VF index
> + *
> + *  return: return 0 on success and -EBUSY on failure
> + **/
> +int wx_read_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf)
> +{
> +	struct wx_mbx_info *mbx = &wx->mbx;
> +	int ret;
> +	u16 i;
> +
> +	/* limit read to size of mailbox and mbx->size is up to 15 */
> +	if (size > mbx->size)
> +		size = mbx->size;
> +
> +	/* lock the mailbox to prevent pf/vf race condition */
> +	ret = wx_obtain_mbx_lock_pf(wx, vf);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < size; i++)
> +		msg[i] = rd32a(wx, WX_PXMBMEM(vf), i);
> +
> +	/* Acknowledge the message and release buffer */
> +	/* set mirrored mailbox flags */
> +	wr32a(wx, WX_PXMBMEM(vf), WX_VXMAILBOX_SIZE, WX_PXMAILBOX_ACK);
> +	wr32(wx, WX_PXMAILBOX(vf), WX_PXMAILBOX_ACK);
> +
> +	return 0;
> +}
> +
> +/**
> + *  wx_check_for_rst_pf - checks to see if the VF has reset
> + *  @wx: pointer to the HW structure
> + *  @vf: the VF index
> + *
> + *  return: return 0 on success and -EBUSY on failure
> + **/
> +int wx_check_for_rst_pf(struct wx *wx, u16 vf)

I would spell "reset" fully

> +{
> +	u32 reg_offset = WX_VF_REG_OFFSET(vf);
> +	u32 vf_shift = WX_VF_IND_SHIFT(vf);
> +	u32 vflre = 0;
> +
> +	vflre = rd32(wx, WX_VFLRE(reg_offset));
> +	if (!(vflre & BIT(vf_shift)))
> +		return -EBUSY;
> +	wr32(wx, WX_VFLREC(reg_offset), BIT(vf_shift));
> +
> +	return 0;
> +}
please apply all my feedback in analogous places through whole series

