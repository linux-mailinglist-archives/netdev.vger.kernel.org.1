Return-Path: <netdev+bounces-117912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B73A94FC65
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 05:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3FD1F22BC8
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 03:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F2E1F94A;
	Tue, 13 Aug 2024 03:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ps/KKbHQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90BE179AE
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 03:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723520766; cv=fail; b=u9+hipFKVQ+KJ3Ob5hqG6ynNO0pCIRyRosBnfz1Vig5TMDyPf57G3dXyMmHeinxTKMe6G11MbQOc/lY2XFEAconM4wp/IsBPguLokn+x3JcuQC7fI7PwHSZR3Yhibvg6OIPTYatyiIuniEdyvxhYoKgwy2JlO/7Fw5V2eCov+rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723520766; c=relaxed/simple;
	bh=yVlrGYi3m7OcM/XlzNa4esOdY8C9wm4mCCnKEsum34Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l7wlmZDXugchsDC1V/UXnjEBa9pOsO0Z3yboGRpH+pgTCUpIOEvtBoa38jMgRiqefA0TeVLPMOTvR2AthEEYjD1dauJaVkVyaJFhIQOrCyejgzHghr07woeZdwojVJK+XCLh4q6piAmmgZrR+PK1ci5NudsjBbfR7xfpJMhngQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ps/KKbHQ; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723520762; x=1755056762;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yVlrGYi3m7OcM/XlzNa4esOdY8C9wm4mCCnKEsum34Y=;
  b=Ps/KKbHQDs6ozyoKQKDcIkssfiz5jhfDWWLnIrVQ5WxH+q0nbPa0F3u0
   86jpilvXzSbrPhFEhXfJBgejrx8eUrfY6UEtk6nrvHY3soD1cTCw3PQsR
   H1G7b8Vn8i4Q57cd83wkPzfpDTHbWhZpUy4uxM2Pe+76PsTDzDZ8+eg+n
   923M58PRyuT2TWzXXwxX8d+FdZshMrMn7F2jsPfhq7ib80MBgVALPRqxs
   /BeOi2bRNUQ2qeLlnWRkEdv08uRpDhoRg+YY/3YzzTDjMfUfwkx7E2oIR
   NV6MDoYHLB+u2YBv4ftc8kIaqdKQx5I6J6zPASMXT16WIRGyS0DUq85wl
   g==;
X-CSE-ConnectionGUID: zTEECzoQRPWkXBjG8qdDDA==
X-CSE-MsgGUID: RY3xnYdpRRqoD0n83lRX5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21803323"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21803323"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 20:46:01 -0700
X-CSE-ConnectionGUID: xt8hescITuafoh+9Vsxb8A==
X-CSE-MsgGUID: qErND5t9Ra+pmGh7BY12fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58810022"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 20:46:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 20:46:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 20:45:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 20:45:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 20:45:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RweEViazjNM/EjppFzHrvf9M1OSWMBDXMgi3s2ekXsmoZ50YaPbqgyuQK+dhBmpuyV7juYNUR8zn+24H/C8kM6cOPX3cMkE2bqRh71qp/bTChxrjEyxTl6peiHF67fTCR+z8Lp9FxSpGdj0mVzzZZ14NDVXWwJUN12MheaZ4HuDDCCnI6U3+9RCBr7WwJ8gOZbP7qw8VMgObdEObfjCSp6hYwZBWAV4vZ6CCNz/8imVWrgLcfgTL/hdbTvGQMDrpJ/yCOLujADJA2mQmtFuLTD6whR8XDBwxsMfzyIOIHXR82NqGKJxqRfp82k+xyohcKpCzAypwEMJrUJ+bRIQJ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wI4Vjn0wDJ4XfSS/lJf/hvNstLSl5fHjz7I0rAS1Ow=;
 b=C1sZAPfz41al0hXiCSABgvavQhSL5Dz35XFPHZhlDOjABW631If/Bln08zNfArXr1cyob3XGHOUgoOt7IWLa6sheslRwgxGOZx4rt/YKqeZhN52B/MnSxn7DETwjE4zuyVP+Wu6e34Om2wdHOvVAjAwVXV+XskW2epTNZ6eZ33+6E6FU65gdIag1Mbsdqiq/Wy1UauTrLXoU2oksr4WD84bNf0YyoBtqHUIfcOCIeF5AgK1iXMSz1WAAvKXL++Qrefvh+O49n7rQloMq/6Y28FCUn0LQfOBtRUsxulnlbO7L9LSrG1fX+L8o9KnfKegw4/JzkKyuPD5+iFEoA5g/sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CO1PR11MB4915.namprd11.prod.outlook.com (2603:10b6:303:93::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Tue, 13 Aug
 2024 03:45:56 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7828.023; Tue, 13 Aug 2024
 03:45:54 +0000
Message-ID: <2c38d704-f018-4bc6-b688-a7a7ce4adc0a@intel.com>
Date: Tue, 13 Aug 2024 05:45:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] devlink: embed driver's priv data callback
 param into devlink_resource
To: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
References: <20240806143307.14839-1-przemyslaw.kitszel@intel.com>
 <20240806143307.14839-5-przemyslaw.kitszel@intel.com>
 <ZrMZFWvo20hn49He@nanopsycho.orion> <20240808194150.1ac32478@kernel.org>
 <ZrX3KB10sAoqAoKa@nanopsycho.orion>
 <589aed8d-500c-4e92-91ca-492302bb2542@intel.com>
 <Zrojg-svvDA7_OUV@nanopsycho.orion>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <Zrojg-svvDA7_OUV@nanopsycho.orion>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::15) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CO1PR11MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: d6071ead-0359-4ce1-b0ea-08dcbb4a6f2f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2VTRWdFYUQzay9oRVNNYzJiRk1HLzFPRkZBSjFUZ2ZSaGZjT2hBRzE4MS84?=
 =?utf-8?B?ZSt6cmY1N0JJZjFQZEZFcWZPY1lOdCtKNDc0KzZlaWNNaHhPakhHREs4a0o2?=
 =?utf-8?B?Q1diVGxqZU5EaVZIQkRNRGNZWnM1ektKRG9obmhPSFZJdXlRd0thWXBtSUdS?=
 =?utf-8?B?TGx4azZKL3NzVU11SHRybHdOeDVna05JdElBZzBmb2hIMlRHMWlmalg2WXNp?=
 =?utf-8?B?TXhFd1pjVWdLK1ZPWUlBcHR2VWRkQVplckxDajdHd3VpN2t3TlV0YUFCT3Nl?=
 =?utf-8?B?UXlaZFVBdG1kYmhrYmlEVTB6cC9ITUhMU0wwa1duemU2Qk8rNGg1UWdRR2lF?=
 =?utf-8?B?eDZQMXAxcWU1SWRyNlRmbzRNL3JDekJGME9PS2dwdlgyVHJPdEdXVHoyaUcx?=
 =?utf-8?B?VTRnY2c0K210ZDVXaEVVem14ZGs0b3lsSlQ3SXFWOEVDNEhTNG1HTVVSZjh3?=
 =?utf-8?B?UkFUNnNrc3VzMUYzVHlkZnBXVE9PQVp1YURTUU1zOE5RUURmTjQra1dRNkFx?=
 =?utf-8?B?eVNxeGl0cW9tTko0UElMUmd4ZXlpUlY0VGNWM2VIMkhobDloWjM4ZEt0Nm5S?=
 =?utf-8?B?QXF3ZmJqVGdrOEt6eko0NjZoc2xRRG94MWl3Q1F5T3lrOUtqZW9VdUhQeklW?=
 =?utf-8?B?ZU9vQWxuMVJ0a3lRWUt6L2hRTlJQeUFjcWRLWkVCVklRaHgxK0xVbGFEWnI0?=
 =?utf-8?B?bUVqV29mTkFMVUY0RlA4aEJjZ2V0V2FBZXMybTZZMnNnby9iL0dVSzJ0UU1p?=
 =?utf-8?B?dXhFWFNESG1SMkJaUXMzdUYyYk1lUDdqOWFGZ054RFNSNjRudDJJUzhBNGZp?=
 =?utf-8?B?a0lPYXI4djQrS1gvUTVMeEkxZVRMZFYrai9uUXhneFRXcUJueUdVOEVyOEFk?=
 =?utf-8?B?WVN6RXI3cVVDOU9GVmh0YUFRRVcxZmFTQ1J1akdpdXQxaXVWS3ZydnJPYXh5?=
 =?utf-8?B?UDFCNXAyZXQ4Rk5sN0w1eFp4Tzk0eGtPaFRkWEs4Y3lESm5FempmM2hkVGxP?=
 =?utf-8?B?Z25Bem5LUHl2VVA5S3BRVDJOd2tpZXBDUGVnUENMUUhONlpqeGdoY1JzTGJF?=
 =?utf-8?B?bGhGdkd3TmxDLzBQc0VhaVluVFVJSkZzNEtTb2pieXNwbjg0Q3RjbXcxU2kv?=
 =?utf-8?B?WXI3UWJoMHZkZ041OEdrVHFzTVQxcWVSL00vTHY2VkRiRzEwMUQ2aE82UkVU?=
 =?utf-8?B?bnhENE9EdEV0VzhwSnVyTlRaZkkzbWZPRDRuUDhVMGt5c09sOFhBWkhTR1JP?=
 =?utf-8?B?SzZGbk16ZzB5dmlnQjh2N1NlT2JFQTdBOVRuVkpyalBLMzRSM0lES3FlZWxo?=
 =?utf-8?B?S3cya1hJeWU1aVRkMWpCSk5ROG5xMVVyUDE4RHk1WFRBc0U4RGo2VDVVUmNF?=
 =?utf-8?B?OVgxTUdzNFpDNVRscEZqRHQ0U3o1OVFzOFNwN3hsRXk0emNJQWtJbldUV3Bk?=
 =?utf-8?B?Y1FXYlJWME1zQ3N2eXQ3NDZLMHdpUDMvVnAwanI5SGZ4WE9ObG5Qb3Qza2xq?=
 =?utf-8?B?R2hFV1BzMDAxWjYvU0VGendBNFBXQTh5alBwdnBLaGJ2VDJGd3BzOWF5NnNP?=
 =?utf-8?B?RWl0U1JENStsVUl1bEludmJhOEcyNkZBN3BYTzRWenBWY3B2blRuYzQ4bmpO?=
 =?utf-8?B?bEdUL0k2MEJDMFErWnU0MVgzOVdlTjkxZlhkVEZxTG9wNVVxdUNKZlVuNGp4?=
 =?utf-8?B?WVJ1R1BuY2N4dDRQdnB6RFU2TWRyMldmaFp3UUxmaDgxeXk1cXVoR1BVYzJU?=
 =?utf-8?B?eCtSN3FRZ2pYNTVyK3FLbHRmMGVxM2xnb1RGbS9VbFVSRzg4U0hqaW1nalZw?=
 =?utf-8?B?RDBoalB1OHNPak9SU2hlUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2ZnKzBKSmM4d29FS2dEbjdjT1ZSRE5lZVljYS9EaFpzSzJSbDVwdUgzeGdO?=
 =?utf-8?B?aHdDUkRoek5HOXhROU52TFYzSXc3M0xtYXYxL3pIVk5sUnhtOXN5Y2pKNmdN?=
 =?utf-8?B?STlkRS9wbFJDcUVVbTV2cHBnbWxKZHBNSDBqUTVLbzVZNDRXaDhwMVlXeVB0?=
 =?utf-8?B?c2NRbHNtYi85b1FTamw5VmVzV2VHL1YrKzNUbGRhSHdjUjdQRFNRc3hNd0VZ?=
 =?utf-8?B?dFNqTkhoNXcvVWdLWiswZ3h0Vjdjd3U5dEtCVU5BRUhhdlFCQnpXVUFNa0lM?=
 =?utf-8?B?UEl6dXJlZFY2QS81aFI5Z2xETk1TQVVVandCd2JRcW5YNEZiRytnQU9ZSmFp?=
 =?utf-8?B?OStrNmM0akxSVmpNUUREOHN1Z3IvRTdHQXN1Mk53Vm5XdVdHbzB3WUhsUUoz?=
 =?utf-8?B?M1M2Q3JRTXZTTlo0VmRiSkFndHY4OWQxdXhiMXlSL095TDNXdHFnOFJ0TENs?=
 =?utf-8?B?MGVsOEU1bHJ3dStWaHVQZ2JjWmtDblBEM0NKUnlXamJ4WmVLeEVaVm1qMzJ3?=
 =?utf-8?B?THBBSFNWVkFVTm0vM0U2dG12b1NuQkVhVGZoTnZuWFBydC83aEd0OHlBMHBB?=
 =?utf-8?B?U0JZT3hCVjFpMHdvbWZHUGRBWEZnMVlhK2hKVkpTYTJjZFJ6aCtwK1FTOE4z?=
 =?utf-8?B?VHpQSjRySWNEeTA5c3BmODR1VmVSelBZT25yeXlQQUhRdHBYMkNGbHd4alpa?=
 =?utf-8?B?bVBTOTdMYjJQTjE0V3hxaDl0cHVtWmI0K3lGNlFIN2RpeWJmczJzNVpzMGp4?=
 =?utf-8?B?WnE3S0JVZ3JnZWFvcnVGZit0Wk9kZG9IK2N2bG92em54dkFjdW5SaFVIQmFm?=
 =?utf-8?B?cmd1ZTdja2NCVWJmRU01cjJKWGFOcjlackE5c0x2c2ZWVjZhc2ZCSUNzWlRo?=
 =?utf-8?B?TXpGa1RrNWsvU3NuMDIzMkVFQWlMeWY1NEcxOU9KSlZrUjk3d0VyNGllRWRl?=
 =?utf-8?B?WEFQc3Q2SVJsVjR5T2pJVVE0QjRVd0Q3bjZDTi9oVXhleHZsaVpkRXg3ODJs?=
 =?utf-8?B?bEZpazlQYUVyRHl4bVZZVlFJcmc5bEZadnZCM2VZWkdIV25wZEd1VWhXRE5I?=
 =?utf-8?B?V05UWWp1OWFqMDFvLzNHWGlrWnZJQlo3cHpNOXg3UDlraU5uck1SbjUyZGMw?=
 =?utf-8?B?clo3M3U2OWNEOGpWelBrOWxYVVJhdGZoSXFOb09YbEwzbW1BZTRsQk1XU0Js?=
 =?utf-8?B?djlIa0FLRzEvelBpbjBkaVo3enlIU1VndkhMY0d5bktoelJOc25PaTRmTStN?=
 =?utf-8?B?ZG0xMm5OLzl2TGpGMTU0MjN3ci94b3BUQ0VpQktHRzM0Nlo3QXRsYmlrN3NO?=
 =?utf-8?B?S3dDUENkY1pYRFoxSXJUYUN1bUxrYUJES0ZpQ1MrbGE4eVpSanovUVRMbTNL?=
 =?utf-8?B?b3VJa3Q4a1NMbTFUNkJtRzUvajcwbzNiRmNsZVNQMDR3N3NDRXFsRjYzRUVs?=
 =?utf-8?B?TWVjckVKL0R2L25wbk03ZFBuZ2NiME1zVUR1M1dDdVAvWjJkb0plOXFmS1Ni?=
 =?utf-8?B?eDlvNGNUT1Btc3NBaGtIaGs1YmpPcU9IbDhVVnBUQTNHUkViQ3lmNUtvekJD?=
 =?utf-8?B?elZ4dVZrQ2FacjFDbm50U3JyNDl0QXkwNkpuSFYwT25MdVZrQ3FQWEEzZEQ4?=
 =?utf-8?B?a3FmdlZzcG1HakVXWXMwcmZmMmNnZmZkVk45cmU4aVR4REFMeDBzd3JUYlpH?=
 =?utf-8?B?Nkx0MnJWREYyS0phMTByamhCbWFyZC82OW5ldmRUb3ZoWkRBL1pQSkE5dmx6?=
 =?utf-8?B?NTNlQ0NncUFWcWpYcDRmYUJQN1FuR1d5d1g0a3NPQWxFb1lnTWxqV1hDNjF1?=
 =?utf-8?B?akw0eWFVSkNCaThiVUJ1a2ZMYXRtaXpZbnp0V0w3a0w4NHZsWkQwUG5kU2lt?=
 =?utf-8?B?SDBjVXg2eWdoaERSa0FxTTdrVUlSenRxcGVWd1lRTXJyTkM0cDAzNVJxWTYz?=
 =?utf-8?B?ZzBvOGVmSy96SmJKdFUyRnRlWlplYjY5d0lhQXlTak01bnJtNytHUnc4Z2J0?=
 =?utf-8?B?YmpWVWhnak1RRjBNbkhmUlRvSUliL0M0b2NNWUllM29LK2xuR2NDcUEycVVt?=
 =?utf-8?B?bk82Tk1vMEN5eThJTU50YXFxUVpEOVlnWkZtdXlMcGVVTW1yNzJKMXFmL0ZT?=
 =?utf-8?B?eGJsUGdZSFdkYUYrVWNqamUyWXMrcEJEUnNRRkFBaEg5U1hWOGtrZCtLNitT?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6071ead-0359-4ce1-b0ea-08dcbb4a6f2f
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 03:45:54.8627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFlUmxYRLE/QMVCNxGB9yBpZmNQpBGOjgE4Rxc7z4Zw+25BGSSJ205oHmxW5gfdiQGn255exBL8j2k0lGfUCd5xuQR2IlZkDFT25ZluKAVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4915
X-OriginatorOrg: intel.com

On 8/12/24 17:00, Jiri Pirko wrote:
> Mon, Aug 12, 2024 at 01:50:06PM CEST, przemyslaw.kitszel@intel.com wrote:
>> On 8/9/24 13:02, Jiri Pirko wrote:
>>> Fri, Aug 09, 2024 at 04:41:50AM CEST, kuba@kernel.org wrote:
>>>> On Wed, 7 Aug 2024 08:49:57 +0200 Jiri Pirko wrote:
>>>>>> 	lockdep_assert_held(&devlink->lock);
>>>>>>
>>>>>> 	resource = devlink_resource_find(devlink, NULL, resource_id);
>>>>>> -	if (WARN_ON(!resource))
>>>>>> +	if (WARN_ON(!resource || occ_priv_size > resource->priv_size))
>>>>>
>>>>> Very odd. You allocate a mem in devl_resource_register() and here you
>>>>> copy data to it. Why the void pointer is not enough for you? You can
>>>>> easily alloc struct in the driver and pass a pointer to it.
>>>>>
>>>>> This is quite weird. Please don't.
>>>>
>>>> The patch is a bit of a half measure, true.
>>
>> Another option to suit my wants would be to just pass resource_id to the
>> callbacks, would you accept that?
> 
> Why, the callback is registered for particular resource. Passing ID is
> just redundant.

Yet enables one to nicely combine all occ getters/setters for given
resource group. It is also straightforward (compared to this series).
You are right it is not absolutely necessary, but does not hurt and
improves thing (this time I will don't update mlxsw just to have
consumer though, will just post later - as this is not so controversial,
I hope).

> 
> 
>>
>>>>
>>>> Could you shed more light on the design choices for the resource API,
>>>> tho? Why the tying of objects by driver-defined IDs? It looks like
>>>
>>> The ids are exposed all the way down to the user. They are the same
>>> across the reboots and allow user to use the same scripts. Similar to
>>> port index for example.
>>>
>>>
>>>> the callback for getting resources occupancy is "added" later once
>>>> the resource is registered? Is this some legacy of the old locking
>>>> scheme? It's quite unusual.
>>
>> I did such review last month, many decisions really bother me :F, esp:
>> - whole thing is about limiting resources, driver asks HW for occupancy.
> 
> Can you elaborate what's exactly wrong with that?

Typical way to think about resources is "there are X foos" (resource
register time), "give me one foo" (later, on user request). Users could
be heterogeneous, such as VFs and PFs, and resource pool shared over.
This is what I have for (different sizes of) RSS contexes.
(Limit is constant, need to "get*" resources by one at a time, so driver
knows occupancy and arbitrages usage requests).

"get*" == set usage to be increased by one

> 
> 
>>
>> Some minor things:
>> - resizing request validation: parent asks children for permission;
>> - the function to commit the size after the reload is named
>>   devl_resource_size_get().
>>
>>From the user perspective, I'm going to add a setter, that will be
>> another mode of operation (if compared to the first thing on my complain
>> list):
>> + there is a limit that is constant, and driver/user allocates resource
>>   from such pool.
>>
>>>
>>> It's been some while since I reviewed this, but afaik the reason is that
>>> the occupancy was not possible to obtain during reload, yet the resource
>>> itself stayed during reload. This is now not a problem, since
>>> devlink->lock protects it. I don't see why occupancy getter cannot be
>>> put during resource register, you are correct.
>>>
>> I could add that to my todo list
> 
> Cool.

I guess no one cared about it yet, as resource register and occ getter
register is much separated in code space (to the point of being in
different file).

