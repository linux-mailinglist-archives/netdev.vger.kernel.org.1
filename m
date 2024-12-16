Return-Path: <netdev+bounces-152199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEF99F3146
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3F8163AAB
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB06205E2B;
	Mon, 16 Dec 2024 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1QNQ9jF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0952046BA;
	Mon, 16 Dec 2024 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734354578; cv=fail; b=eDem4paoR3v6PzVig8bGAX4bJtLgvK0DukEtBqbRAlPvmUbp7oerl5FUJWUrhQEbSUxkQRksdOHTV7ETJwUymIwu0HVd21HMvH6kXgLdCqNNXeo9UVPRQwnawiNrNyCEYyaybCUrLSQFb40Yu9qEHjBhxB58EIKS9X2Bp3Bu8zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734354578; c=relaxed/simple;
	bh=RnPRQBsqkOay0YtiGRFrZDRUUq9id/rQXSEKFVue1pU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nmYvNMuf4U4DlGvzUap+BIjKWsg+j8tWPw6Z3xy71LaPAzzWtR84LWDj5XrMsM+pu8S0e25JdM9qJKcCdYuNCZ1SZzGphp62g+L7JCjess90fUifVqsH4a1RHznRUyhjzKCrHuFScuj/8qFmievILs/0CU45NlsXup0ng0r0Kvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1QNQ9jF; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734354576; x=1765890576;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RnPRQBsqkOay0YtiGRFrZDRUUq9id/rQXSEKFVue1pU=;
  b=e1QNQ9jF35qZXPXhQoPyuYi8CnmhVu8a0XFc9hBOtzjuQhfRSxjv0hl+
   EGvYAF6PiPkZzsmmQB/m80Q1EX/zwpj7vkrwMRR9uynH/KfC6vz1J3vWG
   FCG+J0thLBLJRzFsJZmWEu6F4T9cqJJ4WGtbhODmNvHVvUjTKmd5d5oTA
   BMlhfsTj7k0Sd76XePqr/gaCTFKmO2QsERrMpOGPsvzC8yRmYJZj79TIG
   OMsd13sOx3Cyy4kLt2ltlHAPVDRDTpfpjv3DL2lg5mJAnTHBJPsMSB+VE
   V0iXfR6kXB37iXnyebdNq8lBNzrSL0b9X+KGHqyvtnbCudttzNHGPmUls
   A==;
X-CSE-ConnectionGUID: OWOjYnrFTEWf1GZ5NOz4rg==
X-CSE-MsgGUID: tvrkwHWWSqe0MCZLZXePNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="22321615"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="22321615"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 05:09:36 -0800
X-CSE-ConnectionGUID: upVDySTeQxS7P4MD37W46A==
X-CSE-MsgGUID: EF1OXVf7RPGM04pdCD4o4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="97101261"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 05:09:35 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 05:09:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 05:09:35 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 05:09:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8R3fJFdb8gnN5l4N0XjphLjQ4Oe/Q/IE3F0i6FkHTiYOBOpnQD8zOCfwLpikDx0mbLp/cKZ0wwvuQUSyGW7JIabgR3ZD0RYbecYLqK+D0fZP5tU9gLVnPZSKc5HvVxya4Jqq7Jv6nm9mIhj/mV9FYVWieM8f+AGwrS57/R8w5Fg7wZw3Dytfkvgs1RusTK+x1McaIt/+jHFKXCVRAKQVwFGoLOrq9z4Fl67PLZNrb+kvUEsfNCohduCJ4g4hzpGYsb+nejRRjuWEQZ1UaBe7KtL0fK6em2QkQshLh50PB95rhfrcOJChjrbSOk8AfpEqwDQUWVV+MdlsRhyrNUyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fG0fBC7xzKUsN7BhulU6vhgDjJq/TLyOu6vvKkwdaMs=;
 b=woxRjOLsxjeDM4fQ9IgKKiBKc4eMl7JeH0UepsDWxfhSwSKpDkbvc2K7iz/ngIKhh6RKvdbP6YPhhZVEsIl0pIij12PH3i+/FnOweuerv04UHQCS0WCFEHrtqkPyoIsN6r916jHSJ+2px81fiNnVsl/kzlupk/mwWvaw68grNqE4quMiuDY3mwN5YPnPdOAXdHB8sNe6c0Tr/PoKRAyeN6e6a3Ff5Wk6yZm+VgRsJEZixGCmOwbXlKTS4H3sagfTKw2/OHBy8xnBFxWeBdD7py+sEBqb1XDuptx0XClQFc7up98rpNtUTduCnmIHZC9depzeqKVsVIaablbmxP5CyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by SA2PR11MB4796.namprd11.prod.outlook.com (2603:10b6:806:117::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 13:08:48 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 13:08:47 +0000
Message-ID: <029000b1-ad0b-4632-9700-85d55b80053a@intel.com>
Date: Mon, 16 Dec 2024 14:08:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/6] net: usb: lan78xx: Use ETIMEDOUT instead
 of ETIME in lan78xx_stop_hw
To: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Woojung Huh
	<woojung.huh@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>, Phil Elwell
	<phil@raspberrypi.org>
References: <20241216120941.1690908-1-o.rempel@pengutronix.de>
 <20241216120941.1690908-3-o.rempel@pengutronix.de>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20241216120941.1690908-3-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0050.eurprd03.prod.outlook.com
 (2603:10a6:803:50::21) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|SA2PR11MB4796:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa38cc1-bb9a-44ab-e64f-08dd1dd2c6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aklMSzhZVklEMDFTVTJIRDFMRVgxUFBvVU0yYUt6eXE1RU8rWGFkM1FRSjZO?=
 =?utf-8?B?Q3JpRXVKTE5sK3hLYXhyODZ1NEswTVF1RkRCZTNRZHhTVXluY2s4RVdGRXI3?=
 =?utf-8?B?SFNWMlBYVTRnZVpRdjFEQzgxS1M3UHcyYjJFdnpHZFF0aE5JRE53b3B4ZXlZ?=
 =?utf-8?B?d05JR3BhMzJvWDJLNVN6ejVZbXk3Y0lieGNQenh0cHlhZEZyM3hGTUMzTEI3?=
 =?utf-8?B?dldZUUpwdUhFeGdHRVJQcHhCUGlCazQ3RUdLWGN1WTBBOEp2YUR3R2hKN0ZN?=
 =?utf-8?B?TGFpZ0tSckVpZFB5SUdnc2h0VHMvNVZOTThFbk05bXc2QmdaZHkzWlRFbThG?=
 =?utf-8?B?M0VqSFN2QTNnV2lzZ3A3ZTdGVDRRS3ROenQyb09RZmYzeFZSTkVVaXljWVBO?=
 =?utf-8?B?bmhRMnMwZEhNTk1lUUJweHJpMjVDcGhQa3IvZ1JQRFF6WjFBSkM3TytIYlB4?=
 =?utf-8?B?cHl1aHdYdlM2RnVkT0hqVnkvYlE1M2w1enMvV3p3ck91bHB1cmw1anhoayta?=
 =?utf-8?B?VVA5dUtqNEJ5aXNLWWZ4c0N1OUJyYkJndVNIU0Q2VHVrWklDdVFwVDcrajFK?=
 =?utf-8?B?T2NVZXBuV3F5SDJxTmNxYTZjcWZBT3JoUUs4bEJDWVZwb3FNUkVCWVhKbG5G?=
 =?utf-8?B?Y0hSRzIwK3NSTzA4OHN5bFBJL2hwUXgyNFJSOEhEWlRrNktnWFpHWnpJL1ly?=
 =?utf-8?B?djdjUmNoaTFMUHhUdy9hY0hWTnhpQ01TMlMxNHdMQktKZjhOVnJHMUpMV0g2?=
 =?utf-8?B?RUcxZ3pHR25NbGl5eS9KVVRKbkh1RWZxd21STU4zbGp6OGJVaVpac0ZJRVdJ?=
 =?utf-8?B?Yjdjd3ZJaFJWK3BuYUZpMUkzbXBsSFRFMk5aRmN1WWViYTZpNG9QTDZCbTdS?=
 =?utf-8?B?Y3dIUlVlaFRDZE9KSWg1NWd5MWk4NFFaSTFoMzhWNDhwUmtTTHc0aXVYN3J5?=
 =?utf-8?B?TUNzU3RMTVloVlhYMUlURSs3ZmFqQXhEK0ZOcjJ0Q0hrTG9yT3hTM2lyc01K?=
 =?utf-8?B?UzYzVHE0dEs3T1pNdjg4OTRnNzhYU3BjZFhUelIrUXNZYmp3c1NRZUpGekE4?=
 =?utf-8?B?enJLNnlLNURLdU1LU29RdkQ5cEFlVUhTRlNkRkU1V1lROFRjRitmbUs5YklZ?=
 =?utf-8?B?QUtRazh5dmZ5bUYwdUZ2RjI0amY4UWpoVytTOGNtT0hBKzFrRTNsQ3FGV0RX?=
 =?utf-8?B?WG9IcHAwWCtBTys4c0xOYWllWitxR0orZzR6YkhaMU9tYTA4MzNxUEl6a3F2?=
 =?utf-8?B?KzdYa2p4ckluMEN6TmdZNzIyMmJZSllWMWJWaVdCN3luY0hyRDIxM3BKN1pr?=
 =?utf-8?B?NEwzREZoNmRBdWRna1c4THRsZXJ3QWhLVU1odThXbjRPUVYvTExSLzZLV2tB?=
 =?utf-8?B?ZzdSTld4c3hIa3pwTHZIYnowbEYwd0YzZ1d3NkhTTVh6czZHVHREZmdRUHFv?=
 =?utf-8?B?RGkySFE5by9yZDlOZVB5MWwxYzhIZnpYb1l2ZnZGVW9UaUlPbjNCV2wwNFNo?=
 =?utf-8?B?VHRHd3BROVhYNWlVaSsxUkhXZFJtL1h6UzkrR2djZTZ6cXprQXVOQ0hPTXBh?=
 =?utf-8?B?alNaZXh5ajA0TStzbmcrNTBJQmdxTDZhYjZZSlZIVFlHUnRWaGxyZCtEelMy?=
 =?utf-8?B?bWNFQnc1M3VzdWFrZU4vK2V2N1UxOGk2NGErVVN5YzI5SWJvNEY1akdiNnNV?=
 =?utf-8?B?NXJGQng2QnFUV2RhcXphQmk2NGE0SDNONG1lWDR3eTFEajNVd0tyTVZ6WVZL?=
 =?utf-8?B?SHQzQm1TVzhHb3F3eHZmWmxVYURGVEVqUkduRlBvdWdMamlVQU9RZHpLZmV1?=
 =?utf-8?B?eFYxQmhkOG9TUTgra2ZxZTRaY1FUUXpMYXl3Nko0Nko5b2V0amN6bkxRMGJS?=
 =?utf-8?Q?C62vzuwL5taqI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXNIU1ErWWNQcEwvQjFSSjBFNStuYjdvRHJwSVVxb25xbmxjakNwdVl1UTI2?=
 =?utf-8?B?RHErRXpVRkxYU0d2dDF5bExMeWs1OTErd1ppbFJNN2JxcFA3d3JEVGdJUzc3?=
 =?utf-8?B?b21lUUcrNW5aQTVNNURUeFF6WENZcW0rVnFxTXd2a0hwYWVZWFB2cEpKWFVG?=
 =?utf-8?B?RnJvdnMzeUVuS0pxZzdLWC9pbkIxZzZwanJCc0RFQkgyL1VBTXJWb3F0Tlcy?=
 =?utf-8?B?dURWR1k0blRUZGliVU5EL0NZVUR1WjlCaldnQ1ZiWGNiemEydDlvVDdSQjBx?=
 =?utf-8?B?L3YxK3dpWlphdzZvWEdONExmTlo1TEhjck02TWJZVVZhTkE3ejV1SHZOSUpj?=
 =?utf-8?B?OGVwSXJWMXF5RExDcmlxSExzRlVFSzNBT1ZVU0F1Z0taQVlGSFZEdXU5N2JK?=
 =?utf-8?B?Q0JMblJQU0xnSGNmVEpMb2prd0JSSG1LMHFISlB0M0dYR1NKeENkcGdIVk9X?=
 =?utf-8?B?OGpDTmRVSldWRzFGTWxxNmpIb1Z5K3dOV2JqZXprSkRNSTRISmg4WFcrZWxY?=
 =?utf-8?B?NHVkLzNkbWZubXRsNFF5NWErYlN5b2NFZXRJOXhzTFluM0UvU2JWR3RnclZt?=
 =?utf-8?B?S20xR05PalNTNUZUQTBKbmhybWRQM0V1MzQ2YUhuSHdpcENDZk9rMXFRdG1H?=
 =?utf-8?B?dHRESnVrOUt5a3JhK1VETDd3UkFkc0FYUGlPU2cwK1VkbGZPclFXbzlaWmI0?=
 =?utf-8?B?cTY1Y1E4bEMwaWFTaURXWjQwMFBZM0hwZXhJaTJ3eHVWcDdCRmFvcW1JeGsy?=
 =?utf-8?B?clcwTE5pM2xtamd0ZDBUOHRKVE1jQ3JvWDVYT3JlZVgyUGJZTnVjMzNKRHNX?=
 =?utf-8?B?anZPRFBmeTN5Y0ZqUlNybTAvckJrSGNNOU5wNEtSS1cvRCtNYU5DazRsMHVW?=
 =?utf-8?B?cjZsTHc5NVU5S1hTUmhZWkNFd1V4WmpJQTVqV2dnSHgxRXZvTUdXZ2NTbVVT?=
 =?utf-8?B?dGd1UkJGbFFCczZSMitla014V3RQTk1Pd3Y2dFlSeExXNGwvZG5SRVh5YXZs?=
 =?utf-8?B?VXZPM3ZoVXQrdjBhaHNtc2djZmdzUzFtZ1BzTTRQamhIajNSOTRtcXB3V05q?=
 =?utf-8?B?ekRtTncya2dSZmNBQ2dhZjA3bWVDSTU4d3FVOEprOEo4RzkzS2dQdDZteFl3?=
 =?utf-8?B?cUxReHVSUG4wcUZtcU4wRC9WdDVPRTU3Y0dCMlBQRVhRTHpSOFp6Z3VoWlVV?=
 =?utf-8?B?dzBxMUtGOXppL0NMZDgzYU9taldLa2JUSmpDdGh0bVZyWGJKbU12Uk42OFdt?=
 =?utf-8?B?STR6TkZoZ1JXVWdUQ0tNZnpad2dTZjNkWE1kUDZFcUVvaDFudk81ZmZEMVhX?=
 =?utf-8?B?eldqNVR1VEZuckp0cDlxRlB6KzlETTJmNzFwRndQZXBCaFo3aVl1N0MzbTBP?=
 =?utf-8?B?OFFNaFpWSnVHZGNPems5bEV5bnl5U21ycVNjVFhFWVdHakxSeWpLSUxZVito?=
 =?utf-8?B?ekl3UkYwNVhXNnJMY1VFRitUU0YyZW5nNzJtWHhTUXNyTWlqWkorOGFwaTNN?=
 =?utf-8?B?R3czYS9OTzlhd1lDeUhtT1FuNmpDWDhGaHRQNVFnL3JoNzFZVVJkR1BwYXJa?=
 =?utf-8?B?RzFIVElTWlhPbHlCSVN1U3RwV01IMWlFbjhQUmh0Y2lURWpFeVZvOHF6dzgy?=
 =?utf-8?B?M1VVMGtTQlNENit5VEdkK2dhV0RtQk5wRDZlOTBvR0c1YUVCT2JIL0JOT3ph?=
 =?utf-8?B?VVM2a2t4UTl1V0xsTnBHd1hCT3lBTlc0UWxCeW1HSmNWckNyVThxWGVPcEVq?=
 =?utf-8?B?bG11aXRsdzVZTW10OGtuRjMrV2hhWjdpaTBPRitlQytYaWY1Z0QxSHVORDN0?=
 =?utf-8?B?bDluempzbkxPVTl2SitkSjc3VEhoRmxwVS9vOEFVeDlBYWFUK2Urb0xtUHE0?=
 =?utf-8?B?ZVhxT0kzR1lPVGpWSkNSOVdkMjB3RzNFUWpRZHVWb09Mek5qM0dYMnFwZDRz?=
 =?utf-8?B?VUQ5WStSWXliNDZiUTZNdDRVNTlSeXVyNG1JRTVRL05ybWNneVJGamhSWkpQ?=
 =?utf-8?B?VWlGa1B1R0VXNFFibFNGK0ZPVHdoOGV5bW1OZ2Zxei9sTHYxQzRMUXhkalU5?=
 =?utf-8?B?K01ucUVjcnBHTmZCWnVFdmw1Nkd0OVhHVTVBanZlRm80RUFXbXZTaG1kbGUr?=
 =?utf-8?B?UVJwa0k4dzBlQmdNNVZHRGxETkVxT2I3eVF1TnJ1QmgxL3Z4dXgyWFEveHpN?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa38cc1-bb9a-44ab-e64f-08dd1dd2c6f8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 13:08:47.7019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7gEe37/UpRBCYzh2gAH8N03RGGZ0CiUqGMJXLe5Fo1mn43Nq7Pe5J9t5BIhtZkXMBItiv3Ql1gWzZk5FYmTNJmJizdzchGS9uGNldIWIEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4796
X-OriginatorOrg: intel.com



On 12/16/2024 1:09 PM, Oleksij Rempel wrote:
> Update lan78xx_stop_hw to return -ETIMEDOUT instead of -ETIME when
> a timeout occurs. While -ETIME indicates a general timer expiration,
> -ETIMEDOUT is more commonly used for signaling operation timeouts and
> provides better consistency with standard error handling in the driver.
> 
> The -ETIME checks in tx_complete() and rx_complete() are unrelated to
> this error handling change. In these functions, the error values are derived
> from urb->status, which reflects USB transfer errors. The error value from
> lan78xx_stop_hw will be exposed in the following cases:
> - usb_driver::suspend
> - net_device_ops::ndo_stop (potentially, though currently the return value
>    is not used).
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>   drivers/net/usb/lan78xx.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 270345fcad65..4674051f5c9c 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -844,9 +844,7 @@ static int lan78xx_stop_hw(struct lan78xx_net *dev, u32 reg, u32 hw_enabled,
>   		} while (!stopped && !time_after(jiffies, timeout));
>   	}
>   
> -	ret = stopped ? 0 : -ETIME;
> -
> -	return ret;
> +	return stopped ? 0 : -ETIMEDOUT;
>   }
>   
>   static int lan78xx_flush_fifo(struct lan78xx_net *dev, u32 reg, u32 fifo_flush)

This looks good, nice cleanup.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

