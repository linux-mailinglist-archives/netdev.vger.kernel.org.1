Return-Path: <netdev+bounces-150150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F35D9E92D5
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 12:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F218316352D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 11:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C6D221D87;
	Mon,  9 Dec 2024 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eUGpUPXf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3407F221D86
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745164; cv=fail; b=GkxImJsp9zBK8xXUfnIQMv5vAbQWlYG14xnw6TlfuvAD/go7ttRU9SO1VEHImq4HMfQtrN6ZszSx7i38hZVW06z9lS4p4VDMdXByWpqLVEnPPBpleJ5iE773+7zmKTBwfocYlpSvrnLGCUZMD/zi7d+MKMz3ULgWQWZH2EiPkJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745164; c=relaxed/simple;
	bh=eVx2mZaX2Xy9rhIAgFb5gwJN+tMJJSfNxtWSnohNwyc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NrvEdEvXrwoqTqfOp0DJ+VRXCBmeqackirjGsc9wQo+ZMbkGsqzqMbZXB254I2TOa2pTROdVRe0YI1w+Tjh++J1J6HBLkMEOu3hf6ePxiOeWXFIYzlb3+uKW1YZkIB5WNwdgbkKn14O9niW49LzPX8n6loxFO6vtx/2RqQLQgF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eUGpUPXf; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733745161; x=1765281161;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eVx2mZaX2Xy9rhIAgFb5gwJN+tMJJSfNxtWSnohNwyc=;
  b=eUGpUPXfjmjlEz6Me8oVrYsisWcIzqrNWfFss3AqSR3vTiUhPL1SF5tZ
   fLAB6cW/xDLbbtEkumAk8YmYjGCSlYKSeNQZld3//kE9FG7YJBa/gdw22
   uVFPcHQI9tfqXp5mwAa7VUyOaKJq/B65OimqUYQhth0WIx3BiqnF6jy4U
   EjAjOoLoPhTzEnrw/6Izcx83W4oa9PVm4Z1MkAp53JYl76CX3c1ffd1hc
   LQJeei7IILw9mtmd5hjloTdyLgFDpRX3T/TDaBpCvOJ9/lzDn3rALwCnx
   EIIdXnFzXiAVp+EMhbxkXBZnLgUtdnk6OZy3dyiMsdHYoY+VYuxEQ0oyD
   A==;
X-CSE-ConnectionGUID: /dICbyuWRtCHsnpD85YECg==
X-CSE-MsgGUID: qKyiFk16RKmWyKsYdQo30w==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34172144"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="34172144"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 03:52:41 -0800
X-CSE-ConnectionGUID: mo8i7AJoRRGMMW95Y1uLGA==
X-CSE-MsgGUID: 8qoXwQ7eTq2TN4BqZT/qiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="95514500"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 03:52:40 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 03:52:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 03:52:40 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 03:52:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ftk0zIsFRvcFOlbnPJUyzVXIqJ3NdRPf9yd8NKD2RYH/v1jBh5t7gDw6lvoiWM5HRVfa9RQAwnfGBidqd+7T4uiZb7SDFocCovIompOwEHm+UBWMCu681k20NI+PtuJCWrSOpnjZ3LhaytfG1LRMrsGFptXNVzvY3B/jYJ9MEsnTnEL8E437RROh9KenxGK04iHfxOuDjpNYdj0u7xqfiSwt6EztbDT1iK3o0252Ztgkvyxti+YPUFfjfc/V1SmynD+3staSAg4FoV+MfFyJr24toJFpsF4aawyvDl4IKL+UIWbMoTfS9moc5Xqv6QgKmDeSUPj5el0emrU78ZjFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3A754zCbonF/kdXO5qqWE5ULWJL6bPCwPXzPZBITos=;
 b=LFl1tqJMzd2tdgbIF/3WgiEP2UuuR5kNBCl0XgEVrQyv9oNnwxs/xKXyyM5D2QJ1SaLh2jWHNVDJXR/DVgPEBqk7BHt+6753l81qqkC/iS035UFr2dYfS4po4qPSP57b2lMpa8PFmJ1LtUE8mDbBT5KDHj/3ItxN35HBsc1ZwzzgcMNijycTXUt7jMHf2JlYOjiGQ440Z7XchuGz9HtkVLwNNbVuYI7TjR8mZUi2kL44YSe6FPGLK5/45G6EryzFiZ1s/IbnbRVij7ZObf+i7BZP++hlv/ws2eo3mxr49UzjXyogluDfK3uQ1ymehUtBs25lCw2G4BA+qf1clsfBpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA3PR11MB7416.namprd11.prod.outlook.com (2603:10b6:806:316::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Mon, 9 Dec
 2024 11:52:37 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 11:52:37 +0000
Message-ID: <d5dc5d23-879b-4f80-a8dc-f4d8051d110b@intel.com>
Date: Mon, 9 Dec 2024 12:52:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] net-next/yunsilicon: Add yunsilicon xsc driver
 basic framework
To: Tian Xin <tianx@yunsilicon.com>
CC: <weihg@yunsilicon.com>, <netdev@vger.kernel.org>, <davem@davemloft.net>
References: <20241209071101.3392590-2-tianx@yunsilicon.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241209071101.3392590-2-tianx@yunsilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0108.eurprd04.prod.outlook.com
 (2603:10a6:803:64::43) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA3PR11MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: 605c2309-a8fc-465c-bbdb-08dd1847f9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkVLSi84TEpQdytBc0xGcGZ1aXU3NE1zYUh2Y0JRd0FmaUpNWXRjK29LNlBr?=
 =?utf-8?B?ajFUTjNocnZSUFFVVDBqMmcvOUR6NC85Zjd0R3lqYzNlWC8xaVNqbnBPSG9P?=
 =?utf-8?B?RlI2ODZyeEpBU3ErY0pPT1BqYnVpKzdHNjQyREx6Zks1NHZiTzloWEhsWktt?=
 =?utf-8?B?TnhuT0xkczdOcENZQ1Mwb1VOVFBTK2E3T0ZrL1dUSytWNFNmdkx5Z1FvVmYx?=
 =?utf-8?B?eUdrckZIbnNDRG5hWERPMWZzTElIbFBMZXJVTURzdXN4Skl3VTRzUlNFSGZx?=
 =?utf-8?B?UURIdHNkeFltV0trZXcwb3VRb2FYbEh5cHJYdlNtTC9YY0d6OWNXVXB4MVpR?=
 =?utf-8?B?VmYrV29IcEdTQWI1dnAxZ1Z6UDRIN0s0Sm9HRFpLeFFrYVo2YXZRcHoxS3Y1?=
 =?utf-8?B?VkQ1c0gyMUcrWG05dm5nazFsY05JeStGNGplQUN6SkIvZVVObXk4Mm1DMjZa?=
 =?utf-8?B?b0J4RWZOb2k1RWV2eWdjMENYemVjWUNacE13bWdpTzVhQzZsaGk1NktIZG1l?=
 =?utf-8?B?cWYxSXZjQzJYZHYwZEhmczRJd1ltSEFjemUxZTdzZm5QNnM1VE1IOVRkRlJ2?=
 =?utf-8?B?b2hHRGhaMGp6UWJ6WEl2clhKVDQyQk1DaEtPUVZ6NHNDdjh0SnVUYSs2enFX?=
 =?utf-8?B?eldaZk4rdnM5VW1VQmM1c2pCV05jRS9PNzFvLzduMXNuQTlSUjEybEtrdmZ4?=
 =?utf-8?B?OUZyOTlWMEtsOGs5STlpalFhR1E4U1BHc2NvK0dvNlNWMm5VZnNQbzhtQ3o3?=
 =?utf-8?B?c1dzek9jVXBQNmpaMUhxUWZ1a1MrL0FZeVdmckVRbUo3Wm5qNTJLVFA0RkR2?=
 =?utf-8?B?cXFmUDlNcjh0eTRJR2g1Q0g2cS9rWWlvQnQ5N3pHaFlYUDE3c3Vwa1F1ekJV?=
 =?utf-8?B?bkJjUjROZGhpaHo3cmQvcDdKa3Z1SHZicnN0cWVWYVZ1ZTc3MGsvOTRGMzQy?=
 =?utf-8?B?Q1pBdXd6WGltRmdidmJHeXMzeStCSWZBVGV6SkgxaDRNcDVYc1RhUklTR1Fi?=
 =?utf-8?B?elQyMnBqTWRvNXZSN2pZcW1SdWV1RGphaHJodXI1NjArbHR0cFM3cU1pck00?=
 =?utf-8?B?eWQ0Q2VpaDBzVEdBQ3NlQWZ0MXRxL2Fla2JwdFR1Z3orK2ZpQmI5cnhnRVdP?=
 =?utf-8?B?MkdJRWs4TnA1Z1oxdkg4VjNSTkRVazVzbDlrYU9aR2JzZUF3aEMwVHVTMm43?=
 =?utf-8?B?Y2U3V2NZRU85cWNZWHlsbndrZWhma0xpcHZQME1WYUl5VmhHZGRHc01jbGo5?=
 =?utf-8?B?VUFNNWtTcWc5K1Nhb0ZvZ0V2Z25YWWRDSzNkTkIrMndVOFBmcXM4TGpsYlAx?=
 =?utf-8?B?RmZpdkFKVXI2bWJVWGdmMCtDaGVITG5oN2ZERmZXSW9GWDNudFZZditsVHlQ?=
 =?utf-8?B?emgvVXZpYlhNc01uL21hU1BBZUN3VVl2VStsV3k5WTFxSXpmUHZKWVA2aDdk?=
 =?utf-8?B?Sjdac25ZY1RSSm9EUVNmVFVnblJFZm1zNzFRUjRzRnA5bWFaRmIyY2NrTjhF?=
 =?utf-8?B?Q2ZRU3JvMVRDV2R2bDBCUGd1R3d4QXpYTnpmUnl6TFl6dGxRNVRLUGJSaVAz?=
 =?utf-8?B?cUNRdFVmVU1FT1ZuQ0txVm1oK1dWMHVXdGc1N24vd0FOTEladmtTTnJCMHlp?=
 =?utf-8?B?ZC9LTHlOT0J0VXJXWnc1a05PMzNmeGdCMUtlUnZlUkIyaW9ad2k4L1phMWow?=
 =?utf-8?B?cHJlZnpQQkNCOGgxNHdQL0Q3Y3dLUkZyTlhnSmR4d1BPckRBa0xoQlRqWlhw?=
 =?utf-8?B?ZS9CMXdqcUlUK3gxTktRUjhhdUszMXlTcm0yRmlmT0EyUzB3b1FKN3Rwbkxv?=
 =?utf-8?B?SHVBQXhvRDJtcUV4UlJrQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RENqckNWL0U1ajZwRDV2TEltUmFqSmlrcVdoS3M5cUg4T09FSGtVQURRczY1?=
 =?utf-8?B?NUhiN0tGaXJKSW9ZL1h2RnZ2VkRYcjcvS3dSOFZGbkFJaS8zRDB3TVUyLzBi?=
 =?utf-8?B?blJBTU1TMGpSTEdtV1RQcjdoTE5KRTg5YjJaUENkbGNlK3RVZXJTaVRubk42?=
 =?utf-8?B?Si9xUHNxVmIrMiswcnpkUmtqaVlpTDdTcWFmQm5KM0orbUNuNThkMXQzZDEy?=
 =?utf-8?B?L09YODdJeFR4N1RNeUg0SGNzbzlVeUxNUFA2enJDT2NrL0pVcFh0WXBxNXNm?=
 =?utf-8?B?ZTNsWnUySk1KOW1RVjZUV0FkQTdmVUtnL0tLTVFNYXNGemNvRXdZVUZGSGhR?=
 =?utf-8?B?b0FRbWdEUC9lZVhoREpucytkOWptaUJSTmdMQ2RGMmlnd1ZMR2IzeWZVanZ2?=
 =?utf-8?B?ZHJscDlCZVZSaU9waElZd0c4WUlBcGxNWStXL01QblFoRGI0MkFiVzhGNHdZ?=
 =?utf-8?B?QWJJMUdCclMyUEJaQzJLcVBzb0dzWUpvZGZiT0pUZFYydDI2cWtxdWx1dzBv?=
 =?utf-8?B?Z0N5OGRlcmlRQUJER3BydTJsWE9nMTY3NGpldWh6NUYwRi8rVkkzalo3OWw3?=
 =?utf-8?B?a0ZxQ2NwdkY1S1J6VVF5U0pHOTEzZXFERncxaXBjT2F5SXI3MWNtYmluSkwr?=
 =?utf-8?B?VUd2WnF6SFphV3l2c2M4ODM4YnFOSFYwY2x1WVRNaWFJN1RmZHM5a2ZpYTh1?=
 =?utf-8?B?T0NOckZLOXh5TTJtbDFGY2E5RWZrNk5ncTlrNzBNNlU2bFd3em1haUpBODY3?=
 =?utf-8?B?cHc5K2RVbmhjTyt1SVllL2dNWlFRMDZRcWI0RFBNdExxd1hsczA4c1dLd0ps?=
 =?utf-8?B?YnRnNUNaMFVVV1JaRGpjQU9GcEdzOGFYYzhBNWF5VmtuR2pxb3VrUDJTdTcy?=
 =?utf-8?B?WExMdSt3bVFSMmptblVYZVFRNzFFL3RHbmNneFlyY2MzTlR5c0VjR1pxZUpv?=
 =?utf-8?B?R0tyVDJFOFdudVdZUFN1TE1hWTBvMnl4WGlia0syM2txWmhMaDNacnNrLzFv?=
 =?utf-8?B?TWV3QnplYlY4ZmRoODVhaWpOaE5OQTZQbjVmZzFSRGttUjVMS0RGUms0UElL?=
 =?utf-8?B?MFNpOFA2QXhITUp4YlhtYUI1QU9OeXNMQlJTV1pCUm0xSHM2bVVCUXhucW9t?=
 =?utf-8?B?ckxKRTgyM0RwdHhZRlhubGozaDc5U0RPNjkvcEQ2WE1kWjcveW9hMkpEMVRm?=
 =?utf-8?B?WHV6dTJ3Y2hPSnFCYVdWTmNtMk5LQ0xzcDhyK1BIb21lMkNHaXNPc3pEQ01l?=
 =?utf-8?B?bDhMQUFsUHdNQ3c5YVg4L1lydjU5QlNXejhNTnlkVktNTjRxVFZrbU51d2NY?=
 =?utf-8?B?bDdYWk02akhERW1IOHhrSlZPTTdoM1ZPK3ZOQkFuaWpEVzZVZEJaUVlxbjlo?=
 =?utf-8?B?UngvN3NSK0MxWmEwUGRWR3N6NFJsUmJ2ZGlUcDh2amF1WkdYZ1pya0F4Z2xp?=
 =?utf-8?B?ekdyc3BMNXFKU0lLZ3BtbUs2WjlzNUJuKzdFdFJSd1loNFpHdXlyU3NxUWMw?=
 =?utf-8?B?Sk02MllQUXErWloyQjYzT2JSWTZrc3VyQWlhMCtTRW4zaDlOUzhraTJ3ZWkz?=
 =?utf-8?B?QXREWUhrVzhwbHlwZ3FCelQ4cjRMK0JieUU2ekIrWk1kWUJEdEVySldYazRi?=
 =?utf-8?B?bVFwa0oxeGtPckEwRTk2Kzh5TnM3eWlRdldlbTN0L0I4YnhZOUUrblBLTnFC?=
 =?utf-8?B?WXFyU01KajlTdGtPZVZnQWhWNUozYnQzTGVlQjFpbUZCLzFSQWtobEkwSlVx?=
 =?utf-8?B?RlVMdjNEZjJYUEZTUUtvTDNXVjFaWTZRQkVmOG9xeTVuMm81MjlRV25paGRw?=
 =?utf-8?B?ZCtNWWJTT0RZZ2lpZWd0TmpNb2o1anZnTnpndFJ6L1FkNi9zN2xnV1h3L25j?=
 =?utf-8?B?WE5YOUxPUkFGZVBvY1J3SDhVT3FxUUY1YndFR01pU044N0h1TmI5OCtOWjJn?=
 =?utf-8?B?N2RMYUNIWUdkblR6UUtGT3VUTTBDTytlSi9jeHYyU25abmV0UTJGOWRML1VR?=
 =?utf-8?B?akdUUXU3MVFRVkd0SmN4d1VNeCtOK0xEZWlRM1l4VmNpQ25VV1Q5NVJUeU1Q?=
 =?utf-8?B?R2xaTVZja3RBTWRmUytiWmZOTFBUM3lMT1l5dDl6OGVPMEJrVENVUnJQU1Qw?=
 =?utf-8?B?Y2szZkdEdWtQSENoQUpBQ2JXeldVK2lZbUNzcE51RDBWNTRYUENRTHpveGpz?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 605c2309-a8fc-465c-bbdb-08dd1847f9e1
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 11:52:37.2505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jB1RAgaSfDRHG4DRBRB2UakV7/RX2Gl7HTMhZm1XpEOrMkuH4MPyV1Cku8lavhW/B2veXk/D0sQhVK8wnZMxi0N9MfnSMUUs78eNT/BXOqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7416
X-OriginatorOrg: intel.com

On 12/9/24 8:10 AM, Tian Xin wrote:
> From: Xin Tian <tianx@yunsilicon.com>
> 
> Add yunsilicon xsc driver basic framework, including xsc_pci driver
> and xsc_eth driver
> 
> Signed-off-by: Xin Tian <tianx@yunsilicon.com>

Submitter/sender Sign-off should be always the last tag.
What the two others mentioned did for this patch/series?
If they have provided a substantial (in relation to the given patch)
contribution, then Co-developed-by should be added for them.

> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
> ---

please ensure that your next revision will have all patches (and cover
letter) linked. Right now it looks like if you have submitted sixteen
separate email thread (but don't resubmit right now, please wait for the
first round of the feedback).

>   drivers/net/ethernet/Kconfig                  |   1 +
>   drivers/net/ethernet/Makefile                 |   1 +
>   drivers/net/ethernet/yunsilicon/Kconfig       |  26 ++
>   drivers/net/ethernet/yunsilicon/Makefile      |   8 +
>   .../ethernet/yunsilicon/xsc/common/xsc_core.h | 134 +++++++++
>   .../net/ethernet/yunsilicon/xsc/net/Kconfig   |  16 +
>   .../net/ethernet/yunsilicon/xsc/net/Makefile  |   9 +
>   .../net/ethernet/yunsilicon/xsc/pci/Kconfig   |  17 ++
>   .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   9 +
>   .../net/ethernet/yunsilicon/xsc/pci/main.c    | 278 ++++++++++++++++++
>   10 files changed, 499 insertions(+)
>   create mode 100644 drivers/net/ethernet/yunsilicon/Kconfig
>   create mode 100644 drivers/net/ethernet/yunsilicon/Makefile
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Makefile
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/main.c
> 
> diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
> index 0baac25db..aa6016597 100644
> --- a/drivers/net/ethernet/Kconfig
> +++ b/drivers/net/ethernet/Kconfig
> @@ -82,6 +82,7 @@ source "drivers/net/ethernet/i825xx/Kconfig"
>   source "drivers/net/ethernet/ibm/Kconfig"
>   source "drivers/net/ethernet/intel/Kconfig"
>   source "drivers/net/ethernet/xscale/Kconfig"
> +source "drivers/net/ethernet/yunsilicon/Kconfig"
>   
>   config JME
>   	tristate "JMicron(R) PCI-Express Gigabit Ethernet support"
> diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
> index c03203439..c16c34d4b 100644
> --- a/drivers/net/ethernet/Makefile
> +++ b/drivers/net/ethernet/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_NET_VENDOR_INTEL) += intel/
>   obj-$(CONFIG_NET_VENDOR_I825XX) += i825xx/
>   obj-$(CONFIG_NET_VENDOR_MICROSOFT) += microsoft/
>   obj-$(CONFIG_NET_VENDOR_XSCALE) += xscale/
> +obj-$(CONFIG_NET_VENDOR_YUNSILICON) += yunsilicon/
>   obj-$(CONFIG_JME) += jme.o
>   obj-$(CONFIG_KORINA) += korina.o
>   obj-$(CONFIG_LANTIQ_ETOP) += lantiq_etop.o
> diff --git a/drivers/net/ethernet/yunsilicon/Kconfig b/drivers/net/ethernet/yunsilicon/Kconfig
> new file mode 100644
> index 000000000..a387a8dde
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/Kconfig
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.

you should put 2024 here, or, to minimize effort, put 2025 given it is
likely that for new driver the review phase takes over a month ;)

> +# All rights reserved.
> +# Yunsilicon driver configuration
> +#
> +
> +config NET_VENDOR_YUNSILICON
> +	bool "Yunsilicon devices"
> +	default y
> +	depends on PCI || NET

your PCI driver does SELECT NET_DEVLINK and your ETH driver depends on
your PCI one, is it really possible to have only one of PCI / NET on and
have something useful in terms of Yunsilicon eth/rdma?

> +	depends on ARM64 || X86_64
> +	help
> +	  If you have a network (Ethernet or RDMA) device belonging to this
> +	  class, say Y.
> +
> +	  Note that the answer to this question doesn't directly affect the
> +	  kernel: saying N will just cause the configurator to skip all
> +	  the questions about Yunsilicon devices. If you say Y, you will be
> +	  asked for your specific card in the following questions.

the Note section is rather a obvious expanding of the prev paragraph,
not needed. (If you insinst, fix the typo).

> +
> +if NET_VENDOR_YUNSILICON
> +
> +source "drivers/net/ethernet/yunsilicon/xsc/net/Kconfig"
> +source "drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig"
> +
> +endif # NET_VENDOR_YUNSILICON
> diff --git a/drivers/net/ethernet/yunsilicon/Makefile b/drivers/net/ethernet/yunsilicon/Makefile
> new file mode 100644
> index 000000000..950fd2663
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +# Makefile for the Yunsilicon device drivers.
> +#
> +
> +# obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc/net/
> +obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc/pci/
> \ No newline at end of file
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> new file mode 100644
> index 000000000..6049c2c65
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> @@ -0,0 +1,134 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
> + * All rights reserved.
> + */
> +
> +#ifndef XSC_CORE_H
> +#define XSC_CORE_H
> +
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +
> +extern unsigned int xsc_log_level;
> +
> +#define XSC_PCI_VENDOR_ID		0x1f67
> +
> +#define XSC_MC_PF_DEV_ID		0x1011
> +#define XSC_MC_VF_DEV_ID		0x1012
> +#define XSC_MC_PF_DEV_ID_DIAMOND	0x1021
> +
> +#define XSC_MF_HOST_PF_DEV_ID		0x1051
> +#define XSC_MF_HOST_VF_DEV_ID		0x1052
> +#define XSC_MF_SOC_PF_DEV_ID		0x1053
> +
> +#define XSC_MS_PF_DEV_ID		0x1111
> +#define XSC_MS_VF_DEV_ID		0x1112
> +
> +#define XSC_MV_HOST_PF_DEV_ID		0x1151
> +#define XSC_MV_HOST_VF_DEV_ID		0x1152
> +#define XSC_MV_SOC_PF_DEV_ID		0x1153
> +
> +enum {
> +	XSC_LOG_LEVEL_DBG	= 0,
> +	XSC_LOG_LEVEL_INFO	= 1,
> +	XSC_LOG_LEVEL_WARN	= 2,
> +	XSC_LOG_LEVEL_ERR	= 3,
> +};
> +
> +#define xsc_dev_log(condition, level, dev, fmt, ...)			\
> +do {									\
> +	if (condition)							\
> +		dev_printk(level, dev, dev_fmt(fmt), ##__VA_ARGS__);	\
> +} while (0)
> +
> +#define xsc_core_dbg(__dev, format, ...)				\
> +	xsc_dev_log(xsc_log_level <= XSC_LOG_LEVEL_DBG, KERN_DEBUG,	\
> +		&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
> +		__func__, __LINE__, current->pid, ##__VA_ARGS__)
> +
> +#define xsc_core_dbg_once(__dev, format, ...)				\
> +	dev_dbg_once(&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,	\
> +		     __func__, __LINE__, current->pid,			\
> +		     ##__VA_ARGS__)
> +
> +#define xsc_core_dbg_mask(__dev, mask, format, ...)			\
> +do {									\
> +	if ((mask) & xsc_debug_mask)					\
> +		xsc_core_dbg(__dev, format, ##__VA_ARGS__);		\
> +} while (0)
> +
> +#define xsc_core_err(__dev, format, ...)				\
> +	xsc_dev_log(xsc_log_level <= XSC_LOG_LEVEL_ERR, KERN_ERR,	\
> +		&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
> +		__func__, __LINE__, current->pid, ##__VA_ARGS__)
> +
> +#define xsc_core_err_rl(__dev, format, ...)				\
> +	dev_err_ratelimited(&(__dev)->pdev->dev,			\
> +			   "%s:%d:(pid %d): " format,			\
> +			   __func__, __LINE__, current->pid,		\
> +			   ##__VA_ARGS__)
> +
> +#define xsc_core_warn(__dev, format, ...)				\
> +	xsc_dev_log(xsc_log_level <= XSC_LOG_LEVEL_WARN, KERN_WARNING,	\
> +		&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
> +		__func__, __LINE__, current->pid, ##__VA_ARGS__)
> +
> +#define xsc_core_info(__dev, format, ...)				\
> +	xsc_dev_log(xsc_log_level <= XSC_LOG_LEVEL_INFO, KERN_INFO,	\
> +		&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
> +		__func__, __LINE__, current->pid, ##__VA_ARGS__)
> +
> +#define xsc_pr_debug(format, ...)					\
> +do {									\
> +	if (xsc_log_level <= XSC_LOG_LEVEL_DBG)				\
> +		pr_debug(format, ##__VA_ARGS__);		\
> +} while (0)
> +
> +#define assert(__dev, expr)						\
> +do {									\
> +	if (!(expr)) {							\
> +		dev_err(&(__dev)->pdev->dev,				\
> +		"Assertion failed! %s, %s, %s, line %d\n",		\
> +		#expr, __FILE__, __func__, __LINE__);			\
> +	}								\
> +} while (0)
> +


oh wow, please stop reinventing the kernel functionality
log levels, log macros, asserting functionality, etc
I see that you want to have possibility to enable more verbose logging
per module though, but this is not something that should be done
within the module (try to do it in a way that other drivers could
benefit, and double check if there is already something like that)

> +enum {
> +	XSC_MAX_NAME_LEN = 32,
> +};

I find it weird that there is no easy to use #define for 32
that will make sense here (you are free to add one)


> +
> +struct xsc_dev_resource {
> +	struct mutex alloc_mutex;	/* protect buffer alocation according to numa node */
> +	int numa_node;
> +};
> +
> +enum xsc_pci_status {
> +	XSC_PCI_STATUS_DISABLED,
> +	XSC_PCI_STATUS_ENABLED,
> +};
> +
> +struct xsc_priv {
> +	char			name[XSC_MAX_NAME_LEN];
> +	struct list_head	dev_list;
> +	struct list_head	ctx_list;
> +	spinlock_t		ctx_lock;	/* protect ctx_list */
> +	int			numa_node;
> +};
> +
> +/* our core device */

please no obvious comments

> +struct xsc_core_device {
> +	struct pci_dev		*pdev;
> +	struct device		*device;
> +	struct xsc_priv		priv;
> +	struct xsc_dev_resource	*dev_res;
> +
> +	void __iomem		*bar;
> +	int			bar_num;
> +
> +	struct mutex		pci_status_mutex;	/* protect pci_status */
> +	enum xsc_pci_status	pci_status;
> +	struct mutex		intf_state_mutex;	/* protect intf_state */
> +	unsigned long		intf_state;
> +};
> +
> +#endif
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig b/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
> new file mode 100644
> index 000000000..30889caa9
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +# Yunsilicon driver configuration
> +#
> +
> +config YUNSILICON_XSC_ETH
> +	tristate "Yunsilicon XSC ethernet driver"
> +	default n
> +	depends on YUNSILICON_XSC_PCI
> +	help
> +	  This driver provides ethernet support for
> +	  Yunsilicon XSC devices.
> +
> +	  To compile this driver as a module, choose M here. The module
> +	  will be called xsc_eth.
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
> new file mode 100644
> index 000000000..6ac74b27a
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +
> +ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
> +
> +obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc_eth.o
> +
> +xsc_eth-y := main.o
> \ No newline at end of file
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig b/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
> new file mode 100644
> index 000000000..fafa69b8a
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +# Yunsilicon PCI configuration
> +#
> +
> +config YUNSILICON_XSC_PCI
> +	tristate "Yunsilicon XSC PCI driver"
> +	default n
> +	select NET_DEVLINK
> +	select PAGE_POOL
> +	help
> +	  This driver is common for Yunsilicon XSC
> +	  ethernet and RDMA drivers.
> +
> +	  To compile this driver as a module, choose M here. The module
> +	  will be called xsc_pci.
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
> new file mode 100644
> index 000000000..b2ae73fb9
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +
> +ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
> +
> +obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
> +
> +xsc_pci-y := main.o
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
> new file mode 100644
> index 000000000..1d26ffa8d
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
> + * All rights reserved.
> + */
> +
> +#include "common/xsc_core.h"
> +
> +unsigned int xsc_log_level = XSC_LOG_LEVEL_WARN;
> +module_param_named(log_level, xsc_log_level, uint, 0644);

module parameters are not liked in general

> +MODULE_PARM_DESC(log_level,
> +		 "lowest log level to print: 0=debug, 1=info, 2=warning, 3=error. Default=1");
> +EXPORT_SYMBOL(xsc_log_level);
> +
> +static const struct pci_device_id xsc_pci_id_table[] = {
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID) },
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID_DIAMOND) },
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MF_HOST_PF_DEV_ID) },
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MF_SOC_PF_DEV_ID) },
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MS_PF_DEV_ID) },
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MV_HOST_PF_DEV_ID) },
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MV_SOC_PF_DEV_ID) },
> +	{ 0 }
> +};
> +
> +static int set_dma_caps(struct pci_dev *pdev)
> +{
> +	int err = 0;

don't (zero-)init variables that are going to be initialized by other
means without reading this value

> +
> +	err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
> +	if (err)
> +		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	else
> +		err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
> +
> +	if (!err)
> +		dma_set_max_seg_size(&pdev->dev, 2u * 1024 * 1024 * 1024);

see SZ_2G and other stuff from linux/sizes.h

> +
> +	return err;
> +}
> +
> +static int xsc_pci_enable_device(struct xsc_core_device *dev)
> +{
> +	struct pci_dev *pdev = dev->pdev;
> +	int err = 0;

ditto zero-init
(general rule: if there is some complain, fix whole series)

> +
> +	mutex_lock(&dev->pci_status_mutex);
> +	if (dev->pci_status == XSC_PCI_STATUS_DISABLED) {
> +		err = pci_enable_device(pdev);
> +		if (!err)
> +			dev->pci_status = XSC_PCI_STATUS_ENABLED;
> +	}
> +	mutex_unlock(&dev->pci_status_mutex);
> +
> +	return err;
> +}
> +
> +static void xsc_pci_disable_device(struct xsc_core_device *dev)

as there is rather much interaction with struct device, I would
avoid using the name dev for other things, especially that your
driver has a nice three-letter name, you could name your
param xsc, or xsc_core (depending what else you name xsc "later")

> +{
> +	struct pci_dev *pdev = dev->pdev;
> +
> +	mutex_lock(&dev->pci_status_mutex);
> +	if (dev->pci_status == XSC_PCI_STATUS_ENABLED) {

instead of status, this field should be rather name state,
as you encode a state machine, and in general, hand written
state machine code scattered through the driver is hard to maintain
(my drivers have that exact problem)

anyway, this whole function is just a wrapper, that you need
to don't call pci_disable_device() on already disabled one

> +		pci_disable_device(pdev);
> +		dev->pci_status = XSC_PCI_STATUS_DISABLED;
> +	}
> +	mutex_unlock(&dev->pci_status_mutex);
> +}
> +
> +static int xsc_pci_init(struct xsc_core_device *dev, const struct pci_device_id *id)
> +{
> +	struct pci_dev *pdev = dev->pdev;
> +	int err = 0;
> +	int bar_num = 0;
> +	void __iomem *bar_base = NULL;

there is RCT rule (reverse x-mass three formatting rule) for networking,
it mandates to sort variable declarations lines from the longest to the
shortest

> +
> +	mutex_init(&dev->pci_status_mutex);
> +	dev->priv.numa_node = dev_to_node(&pdev->dev);
> +	if (dev->priv.numa_node == -1)
> +		dev->priv.numa_node = 0;

that way you are going to pin to node 0 when there was no prior choice,
wouldn't it be better to use random spread instead?

> +
> +	/* enable the device */

ditto obvious comments

> +	err = xsc_pci_enable_device(dev);
> +	if (err) {
> +		xsc_core_err(dev, "failed to enable PCI device: err=%d\n", err);
> +		goto err_ret;
> +	}
> +
> +	err = pci_request_region(pdev, bar_num, KBUILD_MODNAME);
> +	if (err) {
> +		xsc_core_err(dev, "failed to request %s pci_region=%d: err=%d\n",
> +			     KBUILD_MODNAME, bar_num, err);
> +		goto err_disable;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	err = set_dma_caps(pdev);
> +	if (err) {
> +		xsc_core_err(dev, "failed to set DMA capabilities mask: err=%d\n", err);
> +		goto err_clr_master;
> +	}
> +
> +	bar_base = pci_ioremap_bar(pdev, bar_num);
> +	if (!bar_base) {
> +		xsc_core_err(dev, "failed to ioremap %s bar%d\n", KBUILD_MODNAME, bar_num);

massing your module name to your logging macro seems silly

> +		goto err_clr_master;
> +	}
> +
> +	err = pci_save_state(pdev);
> +	if (err) {
> +		xsc_core_err(dev, "pci_save_state failed: err=%d\n", err);
> +		goto err_io_unmap;
> +	}
> +
> +	dev->bar_num = bar_num;
> +	dev->bar = bar_base;
> +
> +	return 0;
> +
> +err_io_unmap:
> +	pci_iounmap(pdev, bar_base);
> +err_clr_master:
> +	pci_clear_master(pdev);
> +	pci_release_region(pdev, bar_num);
> +err_disable:
> +	xsc_pci_disable_device(dev);
> +err_ret:
> +	return err;

very good goto-label naming, a way to go!

> +}
> +
> +static void xsc_pci_fini(struct xsc_core_device *dev)
> +{
> +	struct pci_dev *pdev = dev->pdev;
> +
> +	if (dev->bar)
> +		pci_iounmap(pdev, dev->bar);
> +	pci_clear_master(pdev);
> +	pci_release_region(pdev, dev->bar_num);
> +	xsc_pci_disable_device(dev);
> +}
> +
> +static int xsc_priv_init(struct xsc_core_device *dev)
> +{
> +	struct xsc_priv *priv = &dev->priv;
> +
> +	strscpy(priv->name, dev_name(&dev->pdev->dev), XSC_MAX_NAME_LEN);
> +	priv->name[XSC_MAX_NAME_LEN - 1] = 0;

strscpy doc:
The destination @dst buffer is always NUL terminated,
unless it's zero-sized.


> +
> +	INIT_LIST_HEAD(&priv->ctx_list);
> +	spin_lock_init(&priv->ctx_lock);
> +	mutex_init(&dev->intf_state_mutex);
> +
> +	return 0;
> +}
> +
> +static int xsc_dev_res_init(struct xsc_core_device *dev)
> +{
> +	struct xsc_dev_resource *dev_res = NULL;

same no unneded zero-init rule for =NULL

> +
> +	dev_res = kvzalloc(sizeof(*dev_res), GFP_KERNEL);
> +	if (!dev_res)
> +		return -ENOMEM;
> +
> +	dev->dev_res = dev_res;
> +	mutex_init(&dev_res->alloc_mutex);
> +
> +	return 0;
> +}
> +
> +static void xsc_dev_res_cleanup(struct xsc_core_device *dev)
> +{
> +	kfree(dev->dev_res);
> +	dev->dev_res = NULL;

most pointers should not be overwritten by NULL after freeing,
do you support reinit of some sort?

> +}
> +
> +static int xsc_core_dev_init(struct xsc_core_device *dev)
> +{
> +	int err = 0;
> +
> +	xsc_priv_init(dev);
> +
> +	err = xsc_dev_res_init(dev);
> +	if (err) {
> +		xsc_core_err(dev, "xsc dev res init failed %d\n", err);
> +		goto err_res_init;
> +	}
> +
> +	return 0;
> +err_res_init:

and here is badly named label, don't name after "came from", name after
"what to do", here it will be simpy exit/fail/out

in this particular case, as you do nothing here, this whole function
should be just:
	xsc_priv_init(dev);
	return xsc_dev_res_init(dev);

+error message printing if you really must (and if there is no same
error in the xsc_dev_res_init())

> +	return err;
> +}
> +
> +static void xsc_core_dev_cleanup(struct xsc_core_device *dev)
> +{
> +	xsc_dev_res_cleanup(dev);
> +}
> +
> +static int xsc_pci_probe(struct pci_dev *pci_dev,
> +			 const struct pci_device_id *id)
> +{
> +	struct xsc_core_device *xdev;

xdev sounds nice

> +	int err;
> +
> +	/* allocate core structure and fill it out */

really?

> +	xdev = kzalloc(sizeof(*xdev), GFP_KERNEL);
> +	if (!xdev)
> +		return -ENOMEM;
> +
> +	xdev->pdev = pci_dev;
> +	xdev->device = &pci_dev->dev;
> +
> +	/* init pcie device */
> +	pci_set_drvdata(pci_dev, xdev);
> +	err = xsc_pci_init(xdev, id);
> +	if (err) {
> +		xsc_core_err(xdev, "xsc_pci_init failed %d\n", err);
> +		goto err_pci_init;
> +	}
> +
> +	err = xsc_core_dev_init(xdev);
> +	if (err) {
> +		xsc_core_err(xdev, "xsc_core_dev_init failed %d\n", err);
> +		goto err_dev_init;
> +	}
> +
> +	return 0;
> +err_dev_init:
> +	xsc_pci_fini(xdev);
> +err_pci_init:
> +	pci_set_drvdata(pci_dev, NULL);
> +	kfree(xdev);
> +
> +	return err;
> +}
> +
> +static void xsc_pci_remove(struct pci_dev *pci_dev)
> +{
> +	struct xsc_core_device *xdev = pci_get_drvdata(pci_dev);
> +
> +	xsc_core_dev_cleanup(xdev);
> +	xsc_pci_fini(xdev);
> +	pci_set_drvdata(pci_dev, NULL);
> +	kfree(xdev);
> +}
> +
> +static struct pci_driver xsc_pci_driver = {
> +	.name		= "xsc-pci",
> +	.id_table	= xsc_pci_id_table,
> +	.probe		= xsc_pci_probe,
> +	.remove		= xsc_pci_remove,
> +};
> +
> +static int __init xsc_init(void)
> +{
> +	int err;
> +
> +	err = pci_register_driver(&xsc_pci_driver);
> +	if (err) {
> +		pr_err("failed to register pci driver\n");
> +		goto err_register;
> +	}
> +
> +	return 0;
> +
> +err_register:
> +	return err;
> +}
> +
> +static void __exit xsc_fini(void)
> +{
> +	pci_unregister_driver(&xsc_pci_driver);
> +}
> +
> +module_init(xsc_init);
> +module_exit(xsc_fini);
> +
> +MODULE_LICENSE("GPL");
> +


