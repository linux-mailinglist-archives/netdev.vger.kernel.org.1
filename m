Return-Path: <netdev+bounces-65465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE6183AAE3
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 14:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EC32B287AC
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 13:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA66877622;
	Wed, 24 Jan 2024 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NkVYUxyq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56EB8BE1
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102806; cv=fail; b=f6MS4ZKVd/hz5BEhAOK7igK29ooI6p95UI5xjF5ECK5waOvHaIyma1OfraFyP47x+vdtMPOu2L62jy/VvjTDGHy7P3HiuUUHjDepyWlE/kSeCHr11a3URPo2PKSj5iMCqdJS8cU17EN9sxaPDBs0luO+lLc7ogTQhZFeHlJqQ78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102806; c=relaxed/simple;
	bh=FoSK/yYiokAMtusi1FHDivTZlANhDT7y9w9RbcKnE6Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bDPd7aLH+VE/4SKUPXMRqoXf2Ny5lRgCVj3QGWHU+xvq4sgyp5V04+k20XT/SdDUBrwEQHV2IlWZ2q4TpJa31vmyadUqdP6OOZFh3pwAzL5q9KSsuwzrQwMnV/DdAlaRLz9OohCmo1VXhKdOIvg7CE6WTjnSG4SL+gtbN91FoOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NkVYUxyq; arc=fail smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706102804; x=1737638804;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FoSK/yYiokAMtusi1FHDivTZlANhDT7y9w9RbcKnE6Q=;
  b=NkVYUxyqV+s7B9iQ4MFnKuuyU3Ki3AtSa9qjp0YAI/+ibFpsMOQRb2z4
   qDpjMX2O2gS7zj2GlunPVzMrazXdpL2iwBoUy/f/Syx5S9IIm/KZif98B
   ifytDJ7eWz+gS2HgATgd3BwYqLbloaIrKmx+jcSmtk2vOTk+Hy5btLkZ1
   5tTQUyGH2Dibk7DpIUZCFz3XLBoxa7XtwEVIza9Qyk/uyy6ZG0s4EjG08
   6R+NeqyunjY4PQQnfAQwcns8yU+JM3+A1hi+2H6+z/dALs/DNpk8t8YXi
   tWq6RGzdjrVFLBNqIL8qE59kqO6XHxZT7UwLWobfZi/ugM7KWU/hH9okS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400696418"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="400696418"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 05:26:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2021706"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 05:26:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 05:26:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 05:26:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 05:26:42 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 05:26:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYdDJ+7GHu6/96GBm8GGgp8b072J79gVnlF6xjFCrco7hoWjrFbz3Q3GbXa956KC3MQq9q+KZReO4eNJuQXJS5X6nmChwbsYR199bq26WeM0Uyq3BaXtlHnDObWua8ew8xpzrd67owYbfFkOvWk9Io7buSTmSFupmLAezQMBape96mtk03ncuPkLw84um8npvyklEX7zosDii59bShXvpq2mQsroOuMYdfkEESWKnlydS/1rsLIIfDmXtUplaC0YRYc+OeHzVsoQJcGfawrPs6GHbltTLGTOwmc9dwiVkflbmLY7pvz64qcXEHrJbREcf3XBspW6eX7++JbVGYhU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmquZwxt59Gi+px7DG3lZ8uIk4lA3S0xDTKiR95ReKY=;
 b=YBCo/5F2uMeGln/1MTkDINeK1rUQLTjZr7R0nz+RuiF4TCv/SiQes2KBPMY74CDIS/zadn1ycz2FQMq+iNRMsPiML2ZDINbV/H8I6OLb8uBpDUYRNn2AyKZIPKw/8BkhkmFoHImSKsZZpp/iH7+On4HJfp8xBCAF0gx45S/leAiu+9XMU4pd/w78SQQJ+lKt0tV6TyTieb8PMtWUMAXJQgd/GwdMY+z4e4FMAoig1oL7sJpprEbYpgoSGwPxzFQ3YX7un9tAPqDJu74mVcHMhYwT8UYRlrX0NCzatppx51Trstdv8yxQT1DgqeTD1VXtORmY6GuqtjlDtaYVnBVb0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB5406.namprd11.prod.outlook.com (2603:10b6:5:395::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 13:26:38 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::b1b8:dbaa:aa04:a6bf]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::b1b8:dbaa:aa04:a6bf%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 13:26:38 +0000
Message-ID: <dc16f6c2-9fef-4a85-96b3-cc17b5a8b636@intel.com>
Date: Wed, 24 Jan 2024 14:26:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] selftests: bonding: use busy/slowwait when
 waiting
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, <netdev@vger.kernel.org>
CC: Jay Vosburgh <j.vosburgh@gmail.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Liang Li
	<liali@redhat.com>
References: <20240124095814.1882509-1-liuhangbin@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240124095814.1882509-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::19) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB5406:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0135ab-a213-492d-88af-08dc1ce01861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHfYmJ0kIWTl7ido2gDY3qrrvJj93q7KI5VFilCMzEAj9hNY+wETNcE8hen7cQqd0njDPt6fXSCiErzks1B8+yE5NdlyvuSjVk9UG4HkfjqcvgOr8k738rzrdknqbBwN+ycwpKI9/RK3a9j87KXYYhOZ8LoM0KpX8rcAuS6vwe8NNJehAxPuJj/IO4m5dIXV57r6kyWPfYH/f5kccllhpAxH3KgieluO3PaHLgr7FkOyFxWdCs3zRcOyTZXywelRzS1gBTfBd3FJxL4HH2HCMNaisC1+nSjheagRT+AXlwWvrpZSfLBGVgKbJFxGkEAA5Rya9Q7QVc7VYY1g656FP2PvZdQShsU/leD2Iekgy9zEruF/vMAYxB7nisRDV3jkjxZOGMe+udDtA9mYft9wUt780+iUgsDRUzHlDkOeqEbz1GFUJpY6vm9e6KU556es2TObHvoC+U5aytjI4xWmquM2Sgetz93fVc9uU8sjtR5fRqXlS6wZ+t3BfVHaBOriMA7FbAElmObEupJiB+XPPRDhwyvjmC9NPyvSRYKq3Zt1VkO9ulrZP5aDAwAdBwvPUxFiER7jRBDaBiehRMKo6uy+02x/dwD/aZRYBSeLaRbfWGaYu4oAXpAwDAgu5+JT8iDFowRv7OGr/ZlWvUK/bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(66476007)(54906003)(66556008)(66946007)(316002)(5660300002)(2906002)(83380400001)(8676002)(26005)(2616005)(4326008)(8936002)(6512007)(478600001)(53546011)(6486002)(41300700001)(36756003)(6506007)(86362001)(31696002)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1dMOHorT295Tm5tVWM4QWw2U3ZMQ1dqaUs2WVZrcHE1YXR3ZisxTXE5UnRs?=
 =?utf-8?B?bktNaE1GVHhJNjdPM2hmSTI1U2tjMUJxamszYnM0blQyaGdLSE9ueG56SFNP?=
 =?utf-8?B?WmczNjVmNFBVaWVnL2hwdFRWWGREYUdueHBqNVU2RS9VaWNNaWFrNWhuaGp0?=
 =?utf-8?B?V3RuTFA0VUttQTh1YmhObEg1M2x3S1c1RFV0SW56WTB3QmU2UEhlMGtBT3BH?=
 =?utf-8?B?RzZxSWNlWGM1ZXFRV0E3Y3hLdDl5YzRLd0hRMFZEdEl3OTFvb2RqL1B4ZWl0?=
 =?utf-8?B?ei9Cd0JRem5IVk5VSWp5ZkhOYjdBZGYrOUVSOGxiNUpFYUhiNjZZcTF0Y25x?=
 =?utf-8?B?SFFsU3MwSnlnOGMwSkxiMGZJaDZRT1lTT3ZQUG9YcVdPUkNKVUU1U0ppV0pq?=
 =?utf-8?B?UWhpUWdjWTR5OHBxOFdBMzNLY0RKcGRrUXlnTmdaNnZ5ejVjYTJDZDVJS0tS?=
 =?utf-8?B?SGdZQVJXZ0podFRhY0pIYWRmenpoYjQyekZHVVdsV2R3blB5QU01cSt6eXlB?=
 =?utf-8?B?cndDaGMzZDAyMU9XREZHZ0NGbXpiSDlEcS9PSDAyeHJYUGZnWmJCd2tiQ2dr?=
 =?utf-8?B?SitjRTZBUWdrNnhRejFoOTlHQTBMS3htRVNxOE8rY2dJMTVhM0VCeEVMYm5T?=
 =?utf-8?B?Uy9RYWgwY3F5M3UvMGsxY3dhdmsrcjMvNUtQb3RZc2VXcDcyUkZXWFVlVjFk?=
 =?utf-8?B?a3NReGNQdVUzY3ZFaWt2SWhIYkFsdUxCcWJZY2Y1WWJvUTR0ZmZqeVE1Zlkr?=
 =?utf-8?B?WitzOWJZdEQrSnBCL0JuK21vT2p3MXl3SmRVM2FvS21FWXZOVGdraW9CRTFD?=
 =?utf-8?B?U04wUG1JYStXU2xqdEdUc2tBZ1ZXN1BJSG84bWJGUkhYY3FBQnJMSlpaK1Fi?=
 =?utf-8?B?NGNmbXFwamE5RmdGdCsyWlliSDJiZytOY2Y1MUI3bmpTSW4rbTM5NEtqMlBS?=
 =?utf-8?B?YlBwVTF1Ukl5SlkzMmd6cy9ZV1V1ZHFtTHF0U2Ewd3FZeTFFOEl4cDhjTTho?=
 =?utf-8?B?RGFMYk1Ha2ZaODhYSzlrODVreDlTUWMzaVBZVjdwOUpqQzZDNWxDTlljN2Fj?=
 =?utf-8?B?RmExUTBRbnQxUmlBNGFVdTUvalFVcUthQ3FHalRyRFV6RGFJY0lEbW0yaVVU?=
 =?utf-8?B?bnNxd2VjTGNIaDZEQWc4cjljbFVpZnlnWnFHa3kxT3pkdjFGMVo0R1NKOUVz?=
 =?utf-8?B?MStERjhaWWYxVEx4K3BOM2ZtMUYzbzg2Z1FIdkN1Q0s5anUrTFVPckM2Sm11?=
 =?utf-8?B?RGpPRFlLM1lsVm5FdW9rd0I2YW40bGtCcElSQWpGZ2JIaGNHbFpjVXhDRDRt?=
 =?utf-8?B?ay93ZUwzWVM5dHZhMXVuSmljWkJtend4MGViVFAxZmhDZHkwUDRwVHAxM0FE?=
 =?utf-8?B?NFpQeW44RGhXSTYyd3doZ2N1cG4wK1U2OG5HTlZPdUZEdnFZQkNEckpIQmk3?=
 =?utf-8?B?REN0bEhwNS8xWkdpdHBhNndPL2oxcVdSUkJnaUJLNTdSaDdsUVhWS2FwamJ6?=
 =?utf-8?B?a1hVK3poeWZRNnhNdGUralE2eTMzZFNsdzVUUjhNaW12a2tlUFljNXJLeERx?=
 =?utf-8?B?b2xINURuWmF0RVUzcTBCa3kvVzJIbVBmTWg0MXRyb203dlg1WUFzSTZvTkN4?=
 =?utf-8?B?RlU4TmcySUFpdWRYSG5KSTlYWlJvWXpzY3E2UHJFak9aZWh2cGExRnQ5djBv?=
 =?utf-8?B?RXBiNTNhTXBWMWo2cThQdG5HNXBmaE1GL0d5ak0wZUFtczJ1bFdrbkhnK3Mz?=
 =?utf-8?B?Z1NHY2ZnQzNlTEJLbmJKMkw4bTdUanloTWlNMU5wZDFxcFZlUkZ0ZVBKY3FP?=
 =?utf-8?B?d1V1MVptZ1gzSVpaVVJiSU52Vmk3b0pjYjhkQ0hQRmRTaHIxNGpBNDIwZ1gr?=
 =?utf-8?B?NzdXZkdoeUZZT0ludkJaaFJsTUdUaFo3S0RLRkhCcTZKUGQ2K2cwLzMrZkoz?=
 =?utf-8?B?Vnd0aWlzRExQZmZtaEVDeXhoVDZ2ZDg0T1FpcVd0Y1VDNGY2THVncCt2Mlpj?=
 =?utf-8?B?SzVmNW1lcVEzeUlPWGhjd2c5SFRuNUlSZG84NklmOWw1TENNaWZhbDJPaWdG?=
 =?utf-8?B?WXp2TStUQXdmVUlhTzY4Si9MZnZYY0JlYXd5ZmFMV2JDOFlMUmI5Njk4bWlH?=
 =?utf-8?B?dGl4UllPQ0ROZm5KNEQrb3NHWS8zQTJrRG1zZE1zQ0F5aDZyaHBSaVlrUGpz?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0135ab-a213-492d-88af-08dc1ce01861
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 13:26:38.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yp4vmfu7eF25rzBGEZeDrg36pZNCMSoJk4ua5q2pW0c3sPIuYmviFxqtZSqAiiiVEGjFuy/vS+pF2IQA0qrn0rFvBWPNOPJPnyXLkO3Zsms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5406
X-OriginatorOrg: intel.com

On 1/24/24 10:58, Hangbin Liu wrote:
> There are a lot waitings in bonding tests use sleep. Let's replace them with
> busywait or slowwait(added in the first patch). This could save much test
> time. e.g.
> 
> bond-break-lacpdu-tx.sh
>    before: 0m16.346s
>    after: 0m2.424s
> 
> bond_options.sh
>    before: 9m25.299s
>    after: 5m27.439s
> 
> bond-lladdr-target.sh
>    before: 0m7.090s
>    after: 0m6.148s
> 
> bond_macvlan.sh
>    before: 0m44.999s
>    after: 0m23.468s
> 
> In total, we could save about 270 seconds.
> 
> Hangbin Liu (4):
>    selftests/net/forwarding: add slowwait functions
>    selftests: bonding: use tc filter to check if LACP was sent
>    selftests: bonding: reduce garp_test/arp_validate test time
>    selftests: bonding: use busy/slowwait instead of hard code sleep
> 
>   .../net/bonding/bond-break-lacpdu-tx.sh       | 18 +++++-----
>   .../drivers/net/bonding/bond-lladdr-target.sh | 21 +++++++++--
>   .../drivers/net/bonding/bond_macvlan.sh       |  5 ++-
>   .../drivers/net/bonding/bond_options.sh       | 22 +++++++++---
>   .../drivers/net/bonding/bond_topo_2d1c.sh     |  6 ++--
>   tools/testing/selftests/net/forwarding/lib.sh | 36 +++++++++++++++++++
>   6 files changed, 85 insertions(+), 23 deletions(-)
> 

for the series:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

