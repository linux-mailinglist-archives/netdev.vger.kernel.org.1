Return-Path: <netdev+bounces-74280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FDC860B77
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 08:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B571286B36
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 07:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5331429C;
	Fri, 23 Feb 2024 07:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VESVbgVv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402B0134BF
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708674333; cv=fail; b=bg9Zh0zz1JsJOhJ+gM6r60pqN7LaWWrwHUzLlI6jUTwvoTl+/O5ibqbHoxsCqoogigeJXpBCtR4ggjolpnhtiHpoKQKYQGE1Qs4lGRiaJYqUEyjMJkHsMabXqarldO1yJa4pJG0fPvEFsYJB6x5PiRMpmLrdUVlZsH2DPvSNTEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708674333; c=relaxed/simple;
	bh=kb0oqpbRAErQkiNp4aYtmNpaRwQLZUqsZPX9kHXak3I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o8m7CeoWoZ9TbnLkqy6YdNHXtAxoyd6GJ/idNUFcPLn+0gpzNf4l+yojBpJZWW50DwBNktCVCBKV0G0yMvAkokupzZdtlzGymSYBdsPbokJJ+yPCDL046u3hPDQiK3X2/AO2S/ejKsa7PsnVwH1+xHDZ+BEWHa3V/6w/6stmp2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VESVbgVv; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708674331; x=1740210331;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kb0oqpbRAErQkiNp4aYtmNpaRwQLZUqsZPX9kHXak3I=;
  b=VESVbgVvw+QISqWcGbL5/r+kN9CiapEmtmpxzhEdnNo1z0M4bIkvKtBa
   fIfFUk85QGwYKIoHc18qHBnr6V2AYwyEPf4t82/9U3AmSKvhj1qY8VqLw
   fMS17LfwlJR+2AXmWMFl5U5hUnW+bprSnE+/MJ+MMBk/0fUInW17LeOKL
   MzO2ORGIffVAbVmq4Z690L86pw7bcL7ma31omZMJnxgSg8Y8il5DTOKIV
   y2SylvG6hPTno1QF/OAPBoGf5iZz5NPudRFOxyimuJ8um9ohqQBGvVq6/
   tX4Nvwd9RGlrxgzboTk0fy4LV7mnAnAwANBwgy44XEX+V7y99dncMA9cT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13538861"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13538861"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 23:45:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10522597"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 23:45:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 23:45:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 23:45:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 23:45:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBw0sBX8AFwPem/mbpcLRRnB0Ho+xdie/XWVKvLZHGf5JFivmJR8ft+NANhWN5so/q/RlIYeJSEl2JdXuuwu/GRwtVnWIAW6ErIiLbcvsCmMqbTcir/E+q16tasqg37fXC2Gu+HGnftwxtX8VgQuDHxECVQea3qMHliC+gkNW4+PYk4IJUsvkw1AyltbpNmC3REPjZC5XOawO7LA3kiNyAfYzK09BDhP+G/gNivQpMooRb+FSYufJL+JPmsCC0p7xxBYa6oYorUuy5zwcEYTsKRXcYbxNlW3hYL8q8X4uPOuPK+I58E623QLUMb4xjbpv5+2P92cSV6/0undrm3dgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eadIsvEDSTDcgsGFD9JrkdpNVR06P59yo/hBHH02+Ks=;
 b=hPy/kPkCDHWOwmqlVi5Ei4xm4YtihqMCxsIkCY8yPuZRFYVDu/2S7ggHYf6YVgHTUSOteksuPHH1kbwuOrIPMbRjgD5hOSWF01pbeim9VK3nNsYIlVgQWSVb/u5Gx+xdSyivgNG06SSajJDwLu8doBNgGS0PtUALSDaSdKXmfinvMZcs02r/PJzcknceYVT9pYsi3GH0cXL1eIVKI3tyI4i5HmcLp5uNnGf7nWQ5flwpRCyv5mU6B0j8M4gwkvxModFo/YIKRCIWaA37x1tYsUiVq0Z32MvcCYIX+19Twir3yAn2lIFhk/lPDGgWAeBz7zQzAoc9aVrBn8naycPeiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB8478.namprd11.prod.outlook.com (2603:10b6:510:308::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Fri, 23 Feb
 2024 07:45:27 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::b1b8:dbaa:aa04:a6bf]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::b1b8:dbaa:aa04:a6bf%7]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 07:45:27 +0000
Message-ID: <b50229cb-e3b0-44f8-9725-6592b74dfebf@intel.com>
Date: Fri, 23 Feb 2024 08:45:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 2/3] ice: avoid unnecessary devm_ usage
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
	<magnus.karlsson@intel.com>
References: <20240222145025.722515-1-maciej.fijalkowski@intel.com>
 <20240222145025.722515-3-maciej.fijalkowski@intel.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240222145025.722515-3-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::16) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: 0182e34f-b02a-4bb5-e95e-08dc344366d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: giaWn4Mt+jGWyu94dBfsuKagSSMp1YlxSwkXl3JEyeO6wGd1cA6G6BPp6chapuwA13W7kZUzVXFittIT7Iro20P8w8lxmSf8Z7fP342kSWqYcXmfVDH12U+0fF1TPFnMSnvNQ3AGzxz3ouSHLreU8Yc91RJlocqA3lqCre66p7M/yWO9hyaXKlz9W2p2zqOoY7eOZebekCRa6Cfb2darfxaABtIsV1rsr/m9xJARJVhrawuOQ+Bx59wrkT+UnxoqYJZKqz/e1cFFCUDwvwGw2170UT5rC49aPtdfb5z6OkfVihUD+sw/Y8pZC4hfRJfRLohq3F/A0HSuRONsrQCKOSUdaLgEGv5XXsKB0o01Ebl/D3XunbN1sDJqYAV4CSBJhB8N6OyxQ5YgAJLjNz4abkEQsDUKGU5ztVy3aA2uYDrVwgyN7xpuVsPwQkChvdUAwjIu5M8PJSfkY2Vu7mbxaFOR4pAwMGyRH0b0xr3HknkGKwAn+57OeCg6/GjYg1esXV1EdoZM/XUR5P65bzprmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVhqUjEyNzk0eklVRndHekk3eFlienRIQ1dtU09uVWRiK0RYeUpwQytNTEp1?=
 =?utf-8?B?ZTdkWGgrRFZ6UzRYaE41ek5DaS93K3c2RlhwNGNIYW5qQWliRFFsaDljd1ZJ?=
 =?utf-8?B?RmJMKzJCQTdwejN0bGxKRXFQUWpnMHcxWUZ4dkQ5R2FvRDRiU09MNmM0WnA1?=
 =?utf-8?B?MDRTQWlOVk9SYnhzSVRGU3B1Nm1QNjArNzZvNG9UMndOWjQ4VVNOY0dweUEv?=
 =?utf-8?B?bkYzTFRwYlMyMFAzS3FhRG15MGZqYlovdHpEbk9xUGIzZE10S1RhNjFHZXBm?=
 =?utf-8?B?VDgyV2R5NE52YzNIZStmOFVYejlZMWdYeFcwRFZVYlhRVy85T2k5aUF5WStK?=
 =?utf-8?B?RjBJT0xZZ3lubDlDWUNxM2ZCUkpkOUlOQ0FxZVVmRGlwamkzaXBMQ0NucXA5?=
 =?utf-8?B?Q0xRWk9jaHRKSzVwZjNuMDdEUjBaVGxVeEJtN1RxWWx4Z1JCbUh2RlJqaUtu?=
 =?utf-8?B?cEpnaC94V2tVaERKdXRTUzVyY05GM0tzREl4U0huY0xkQXJ3Z3ZKL1JoVVZo?=
 =?utf-8?B?cWQ4ZndWSHpZM2JTclFQeFpQaGZISGt1RnRkMTNwakdKR0RpSjZjRFpaRWt3?=
 =?utf-8?B?NXBodGRhcnkvclNvUGdxaGJweEUxcy9CelZNQzVWbzNRYkF2L0Jzc0dpemFl?=
 =?utf-8?B?Y2piS3JDemVoS2tXSkFmTDdYRCtGQjlyVUFibkc1cm40c3ZCaUhXczVWVm5y?=
 =?utf-8?B?dVlFYkJGbkc5a0praDdqVlEyZzB6QnZXSEEwUkZEUDBDc2w2ZC9obTdwam1r?=
 =?utf-8?B?emNZVDlvUWJybTJ1MkRjWUpaZCsxR0t1TkVuaWdCMmhiNUpUZTMyV2ZKNHNX?=
 =?utf-8?B?cC9YMWFzM2tJY2JXeS9lWmdTcTh3enhGYVRQRk94ZGMrdiswa2Ywd3V5YU9i?=
 =?utf-8?B?MWEzY1JGVURHaXY1cTQvclIvRmZBZ0szbDdtNUhGdThoUUN0UWt2ZHVDMWZQ?=
 =?utf-8?B?L0VLNWM0VTdISVVrdFJGbGY4c1h6WFEzT3kvM3ZoNURibnNhcUFGcitnVms3?=
 =?utf-8?B?YnpuVXdqMjh4Qjl1R0tPalFjUkFUN3pua0RLNXIyWis2OVlzWDBmd2ZQNS9V?=
 =?utf-8?B?TU9GaklTejg0U0lsUi9EbTBWeDZaaFdmUnRsREJyeDFLV1pYbjhZd0NSL2p3?=
 =?utf-8?B?c2dyRm5NNjV3T3NWZ0hjdWN3TWZ2WjdCZkZPam8wUEQrTHFaWXpkTk96cWFu?=
 =?utf-8?B?UDZiNGREb0dKOFJUbm52b1JxTEUrZTVGTFVaWkJJYVdFWFk3WVAyUGhFcUc3?=
 =?utf-8?B?M05NWVorZnQwLzZsaW1MaUZ0cFV0VU9McUFNdnNKSWhIc0x3RjVxUG5rd0lj?=
 =?utf-8?B?M2dRSGFoWGh0Z29pSHEwbmZudEpIaDNrNFRJN0xaWGpGY3oyWkt1dDlFa3BJ?=
 =?utf-8?B?S2FFSEEwTTJTWkJjRHhpT2xVWThXUE1rU0hSNU1COVdBODl3TjhCVVVyNG1R?=
 =?utf-8?B?YWptbGc2bVV2dGpZMU9ZdTUvTHMyQXpxd1dKcnNMZVFDdWM4blQ4TG1yelpK?=
 =?utf-8?B?U2xsTXlyZkNyL0l3cTFDWnorL0FzRDFtUHB3bmdVNmc4NkxCYmJGeVNmR1ZV?=
 =?utf-8?B?ZGpBbGtkQ1Ura05zcHFMbGx5dmpvL1p2R2RHb3FFOGFCRkVSS1pFRnk0ejZD?=
 =?utf-8?B?WUhoSE1MVmZvSVlEczhmY2JEODRqWndpbzNDelhEQzZVQkZRVU1helZXZFRy?=
 =?utf-8?B?V0JwdjdpR1J2MXc3d0JlWWFjSHlrZU95bzhmRjhSOXdkckF0R0NFeGdhekJx?=
 =?utf-8?B?bzVuT3dmbSsrcGlCVFRkbnJMbG1JVXFBRzE0RDNvWXBiY01PUnNMcGZhY3F0?=
 =?utf-8?B?Z3d4cmdpaTNGR2R4UHJHanJweWVRZG1wNDRUV2JRaW5NTVV4V2FiTnZNTGFm?=
 =?utf-8?B?N0czekErQUswbnJmYzhINWdRK0RoNDdrOGREZWQ3dkFlQjdlODBUbHI1Q1FW?=
 =?utf-8?B?NlM2NlQxdzFCNFQ2OWpIUmdlZjdBWE44OGpwWU50djc4c3ZQaXB0WDBPSTI4?=
 =?utf-8?B?QVNqd3V2SGlhKzFaTk9xSXRrUlA0WVc5bitTa0phRGl3MFRyaWNsLzFob1l2?=
 =?utf-8?B?S2RnOUhGZ1FxWnF1WEVrbFFBS2tVVWR5ZWkrS0N5SjFMR0RPdDM0c1ZFWEVB?=
 =?utf-8?B?andyY1F2aHFtWUF0Z0MxcUFqeGg1d1ZoNFo5dkVieUdsdUhlZUdJaG9INTQx?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0182e34f-b02a-4bb5-e95e-08dc344366d6
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 07:45:27.4418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3tF0kdWApqusN7Zw8bOALx90MSsJTbD6nzkmPW/+CPrnfKg9W92C6gHu8KOQqupICjl/A6MBvlx+GY8zKRoQCa5/W4ugmkAdibfoEN4gPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8478
X-OriginatorOrg: intel.com

On 2/22/24 15:50, Maciej Fijalkowski wrote:
> 1. pcaps are free'd right after AQ routines are done, no need for
>     devm_'s
> 2. a test frame for loopback test in ethtool -t is destroyed at the end
>     of the test so we don't need devm_ here either.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_common.c  | 23 +++++++++-----------
>   drivers/net/ethernet/intel/ice/ice_ethtool.c |  4 ++--
>   2 files changed, 12 insertions(+), 15 deletions(-)
> 

nice, thank you!

BTW, we are committed to using Scope Based Resource Management [1] even
in the OOT driver, so you could consider that for future IWL submissions
:)

[1] https://lwn.net/Articles/934679/


I'm also happy with this as-is too, so:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

