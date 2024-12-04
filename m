Return-Path: <netdev+bounces-149135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4719F9E46FF
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 22:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A9C1880248
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 21:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FD01F5422;
	Wed,  4 Dec 2024 21:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZk++iT9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC591192B99
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733348314; cv=fail; b=O/A4es7ltvZB7pFVMt8OvjwpojAQVsI6hRkvPhbiU4mGcVXmBnl1K2/7kgqAAWj3oD51iODUKkqGe7+HXVnYw0wRnMCVcqq9g1sMeD+E+GmuXMZbBKvJy/8SvtQhs+7tZonv7ob14i8IA6gmKT58YiKFNgyKZ3oLbtkBTx2WlY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733348314; c=relaxed/simple;
	bh=nVXE/9nJehrcwIkKX0I4FbUpnlpuxoFxqhYthIJGKUs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B0TCyP5WYxkQLRKACKbR8C+yHt+mGofJ90cTNhjpwEZcLPzmYYKsfNQVbdSViI+4Y30/doMAcxIr2zztIIVT838y5zWww5FIBIDoJWIVAEuLiXeGTOvQkaMVVb8ppu5SeTLotdy6jiFdORFCrIjrwznSEsIIx4jyyE+WRQdU9Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZk++iT9; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733348312; x=1764884312;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nVXE/9nJehrcwIkKX0I4FbUpnlpuxoFxqhYthIJGKUs=;
  b=MZk++iT9Ztb13LyFxuoLjhgfBa+TXyGshcZB1gP9S+nGj4GL1cRnL8Z6
   IXRrzTmlC/R1CtXb5M8xtW+z4mP8F9fs1IQKjlyObczXwxkrp7bLfRIrR
   yUIfZiG1Mom2L4aBEhC+VpLzAp7PIB0qoTr50h8/vt8R+F7VTwwGs7Wk+
   /67fvouad72EPnPUzxQ4ZLv1lXFU/rV+MYwrPt/HWRDSDZnOvsFqLU0nD
   unYIM0wO3w732pAAv8Glr4TqSUISEWOW0Hx4X2h+g1ciJ+liSvSVBU8Fg
   fJ46rY0RXBiI9FuCgXDoGc45HErqSkeJkb+m9wOp1+nCcxvJZazixGASZ
   g==;
X-CSE-ConnectionGUID: P3qxv+quQaOsaFjCoJqJLw==
X-CSE-MsgGUID: K/BXlIvYSSKdTuHrNt9sIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33556308"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="33556308"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 13:38:32 -0800
X-CSE-ConnectionGUID: 4a7u0cEeQqyKsOwmCJ3/eQ==
X-CSE-MsgGUID: oIjQf6+GTc64PfEzZL3NLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="93566317"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 13:38:32 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 13:38:31 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 13:38:31 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 13:38:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTaObYGLdtTfkpBOo6daepI/Do7Kms74vbmAEgOjhs3kA32SzhaIKBJAkPuHmnsmdv3Ge0e62CoObt45WW3dmVzMq3GLO1D4lpC8QPRzPbH4+b/aOIKg+0N2tA+uHlhyDEkM4abHmlRYGF6mdjtVkpX1gTclypmVRTYZekv+rz8MjiaT95FCtHnBUrs/x9z3+D9kzUXnIM2xo5tgkxU/+3vrLQUESaIB2RurJUvDKkhAcIlePGddgqderlOw8ysFz9zcTmFCzrHS2CXuXtThbPT3GtctJFODp3jnTr3155ef3uQl1FUpNuivtYot7SACzYdvC2hQsI094iZoewxI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVW1rJFjFQW6mIWXgjdc30fMFWVSdcQiuOl+A2tj9d0=;
 b=yOUB7p03RE5ZAGz571wJmrry69l0HO3hafGvWkg23i+uKyDWTgyGdnF/T8JPAAUFnp3f3/eoqvcCXBPwrkffohe4eQUllDIjKn/kCeImL7TLuUlyYWhA/KjlcsbC1CZ+0ZdUcS7phn6UVJm5FCOh+H81PfZbVyXP+N88et9d6zsdaS45R2DeCXO+cEgppmmp0ewSa/J83grY3Gv9Vw/pP/o3GkI1Tc1yV+L7qWJYq+uuIXoNmwTeIb8pcWbnffRp8XFtu98pNBR53jaj0LT7mNshX2dPnlwfe7jt8X5g5dAxIdXYOvW0StsiAQwFjTt/BZxoQySYCEmG8KCAHAYFgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SN7PR11MB7509.namprd11.prod.outlook.com (2603:10b6:806:346::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 4 Dec
 2024 21:38:23 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 21:38:23 +0000
Message-ID: <41bd4ca9-2882-4203-8c68-71f5a0d7e20b@intel.com>
Date: Wed, 4 Dec 2024 22:38:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v11 5/8] ixgbe: Add support for EEPROM dump in
 E610 device
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
CC: <netdev@vger.kernel.org>, Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, Jedrzej Jagielski
	<jedrzej.jagielski@intel.com>
References: <20241204143112.29411-1-piotr.kwapulinski@intel.com>
 <20241204143112.29411-6-piotr.kwapulinski@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241204143112.29411-6-piotr.kwapulinski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::11) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SN7PR11MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 28224f04-2663-4e58-ffcc-08dd14abfa9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THpYenRTQ0N5NmJxaVM1dWxVV3RyUGx5dHFWL1hSQWhvSk1GMDV3Y2tFUnNP?=
 =?utf-8?B?UnRlMUVWRnl3eHA3TUhFODFRT2Y0Q0Z3djZTUGxCS1FFUU5vMUM3U20xUEVR?=
 =?utf-8?B?WVl5NW5BblRnTlhkSXdDb3A0VlBLV2YrdGtmb3VIK01yTHg0ZmRGaENKMWZn?=
 =?utf-8?B?cVZiaDZlNjlXNmlRK0puc1BpUUZkUWRYU2VNSW9MTytrSW9ta1Q3TUwvbFd5?=
 =?utf-8?B?V0k1RVd0OHdmV1BCa2d6eStFQ1NBcEV3djlONVJXUnZicCttOXRUakRkR01L?=
 =?utf-8?B?cG52SnJlWXIwRUFUMFJ6Vk9POXk4WlQ0MzBDTlJEbGcrN1BFVWVvcGppREVF?=
 =?utf-8?B?T1FndVhMeWZZWVNMeDQraVJTMlhKbXhXUkRHL3N0OXVsc3N1Z0lFMWV3d0Jv?=
 =?utf-8?B?cUgvWlRaYmMzVisyR0JDeUFFNXlTVlBHUHNIc0dreUd2WGNrU055S21ZMkNZ?=
 =?utf-8?B?QTVhb0JPeHBwKzdEaTIrSW9BaitvcVF5dEFVVTFERXZqYnE1V0ZjTVpCZmlC?=
 =?utf-8?B?bGVzTlZIRkVsamMxcHdTRFRXNXhxNHdsSkRVRjBodnpiSWxaT3piejZJTDB1?=
 =?utf-8?B?ZjdMRktOYnc2aU5kQytNOFlZTGg2a3ZQSWZnSlhmdWE5a2JOU2FkaXRlU2pQ?=
 =?utf-8?B?K1ljM05ha001U2taWEhEWE5ONURCc2hkWFh4NnlDOWNUK3l6Y3ZCdDlpSDVJ?=
 =?utf-8?B?WTZGTVpjQlp2MXRXbE81bElPb3hyMjVNTmNTT1ZKUWk5MEFrbnNFNVl6SWpU?=
 =?utf-8?B?T2ZHWWJxdkR6eXVTa0pTUHQ4bDhPVHFFeU9POURUd0lPdy9CM0hMK1NWN2pS?=
 =?utf-8?B?Wkp0V0NneTU1U1lYQWhFVG4rK0V4RUthcCt4MUhDTU01ZUtxQ2IwN1BSVStI?=
 =?utf-8?B?c1dwaW1ZVXZKOC9aUXZHRnNVbTBoUlVOZi9BTTNQZStzN3dJaTFLVXIxTmpq?=
 =?utf-8?B?T1NDZGVEMDhja3UrSXFTNklxT0Jmek5aLzh2eXBXV1NvUHJZVG5pZGlGckk5?=
 =?utf-8?B?UFJ3V2oyMFR0RlgyMDhFY2MwREQ3dXlpRkpNZlhDMVlrQU5vdzBPakEyeHYy?=
 =?utf-8?B?TE5vSFhRV3Q0dGhJSGlBVldZSEtJNHFOUmhHL0J1Mmp3T1Z4aVpHSUM0NGpy?=
 =?utf-8?B?VUVrVHhkcWhoRmNHcUFSTWYxaWROM0g2QVRKZVU4RGR0NXNHbnZjK04xYzl1?=
 =?utf-8?B?TkswYUpYSUt3NTR1S3MxVlBGcFc5YXNlTjd1aDVzRW90TG1na0FUWE9lOUJU?=
 =?utf-8?B?eUo5a0x2Y0hZOXVFWU9jZ2dlbmVvRFFBd2dydVN1NGpBQVNKWmFXSkRtZWpG?=
 =?utf-8?B?WHhDQmRrZE51cEdlS2JnNzBxeDFsRUpkWllzcUMwMmJ0cGJKalVOZTFYRmI2?=
 =?utf-8?B?M1RIcFpHTFVxWW5SR3pFSFI4THllSnZhL0xJT1BSMm0vaURqMGw1dGJXSGZw?=
 =?utf-8?B?Z1BtOXkveDFTeUduQ04rRDFMVWFVQkQxaGNDbUVTSlR0bGRnQWIzOXVueEZK?=
 =?utf-8?B?OWtsdzg3RHVzb0IybWJhV21HT2RlQXUyWndCdkU4RVpJWFRsMWxzYmJXaG9X?=
 =?utf-8?B?K2M1SUJYSTdmTlgvVnNmSlN1bkNydEF3OUhoYVhOVUpPOUpqUW1QczF4ZC9N?=
 =?utf-8?B?VVRuZlRyNVdKTzFCTy9TcDFyUlZlbXBGUm1EdkNRZXFNeDZPVUN5WUx4b1h2?=
 =?utf-8?B?MXIxeGQzaFJPT21OUS9DQ0pyVHJUSWVZemRrK1k5NzIzZUNHUVU3MGZzbUNv?=
 =?utf-8?B?YU1telEyWFJLZVdkR2lwWEg4dDBhZFlGcmZqZzhQUWhIS3VuR1oyRWYyamNr?=
 =?utf-8?B?ZlZLZ3U0UlllY3hoR1RFZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFAyaXBIVHJXY1RNWm5BZmQzZUlabVFQcGRIT0VRdUI0NUlseFhScEVWbHBJ?=
 =?utf-8?B?UnFJRVVadGw0ZGR2aVU2cEpHbnE4RHNPWXFlSHUwWUR1MGxiK3lpRjdMVmZQ?=
 =?utf-8?B?dENsbjFKbElhMDl6cVhORmNoak1RMytJQVVDZ1BwWFFHdG5Mem9oclFFY2x2?=
 =?utf-8?B?b08xOWtnZ3VkcHBaMFhOQ0E1amZRaCtsZ3hVQzc0QjAvNGZmeXdhODZRSjVT?=
 =?utf-8?B?VmhQdWdJZVVjUEZYZVRuVzNKWGV4RGlaME5tRFNXTVdyd0ltZWd1RDhKVS9Y?=
 =?utf-8?B?czBkYmw2ZjJLSXY5RWNVa3hIRHBMUFN1a2ttSDhlOVBVcXdDREFjOTFGRFgv?=
 =?utf-8?B?UlVuNUViTWRsYStvekxTQWcyRjFUSnVDQjJ1MDBTYmY3bTlsUjRDM2o3OXgy?=
 =?utf-8?B?NUlBV3lYekpOUDhkSU11WmxQdHFFbmRaaWkrVG5kem5qRGxackEzYnRwQm4r?=
 =?utf-8?B?UFVySGtDeUIxTEw3ZERTSG41NStLK1lta1p2aGRnbFpVOTNkMnUxaS90MlVi?=
 =?utf-8?B?SHRnVW9rOUY2a01GOWN6VnRnb0hWeXVUSE5MTVJST1oyaWVsV2dnVUE3aDJq?=
 =?utf-8?B?YjdhVjREblZYMEpQMXF6STdYZmJJWFNZSTRhc0g2SVRmOHJxMXI5YU5hOEh5?=
 =?utf-8?B?ZjZocjVvOHlBRUhqRE9rdGdwb0NmK05VdmxwcE5BbTRkMXZYZzVja29sUW0r?=
 =?utf-8?B?bWZtNDh3VFZUcG9QTVpSQ3NvZS9BSk84Sk92dlZVNFJiSlNMcG10aWRqV05l?=
 =?utf-8?B?T2tlb3Y4TGVPbkFqWGxMWVBML3gxbnlJVVpucUUwTVVHVjUwRCtMZ3JoSzBv?=
 =?utf-8?B?NkFwZVUwempuMDAxVSs5NzFuQTU4b1Qyc1lvaEFiUlBOY2dHaERJVnZkZkxP?=
 =?utf-8?B?Q2hiZzNyQm1VUWtZYnVqdWlaeHJaZElpWWUyS2xEVXBHUlF0WlY2dkpqTS9k?=
 =?utf-8?B?Wk16SENHNUtaelpSYmVRRXRKdjhBQUpWQTlDV3BoY3pOb01nQTZyUVR6bThE?=
 =?utf-8?B?ZGwyNmllR3dpNUMvMzNsV0JZbkprQTlPTkRzak1uTXhiazB4MmF0eFBDMkk2?=
 =?utf-8?B?NWJ4dFdpM3V2VUtYeXNEaGRYcmZXSTI5dlpBZGxqUlNwUGI5N1BNdm9FNTNO?=
 =?utf-8?B?N3lZM016L3dFTUFNWUJKR2FMMzJkMDZ1NzR6OW5nU1BGdHFUZ0t0ZDhLbU9m?=
 =?utf-8?B?ZDlmYm9vMTliSjNjR2lHTFhVdXg3M3JlUFJJckl0c21mU3p3dmM1QWxNSXhy?=
 =?utf-8?B?b2dLeDFtN29hcEx4T2NEby9FZzduKzZ4ZCtZd3VtZldmcFVHOUVmbFhjaFBr?=
 =?utf-8?B?bXNSS2g0bkRaNzNDK0FrMkl3azdScitFNDQyMFV0TERrNi9iNGlxMkppbDk2?=
 =?utf-8?B?ZFlEZjZ4RFJkVnU3YjZzNkZ4WExkdXJpQS9DZW0yM2o2bXRtYnlxMVRWMWo4?=
 =?utf-8?B?blVzM2xTeVgrajFGUElVcUFKZkF4MlRwRW5JOEpWTU5xYlNwcVpxOG5FZUFS?=
 =?utf-8?B?UVEvSlV1dVpPcWhRbUJWbUZlVlR1NEc1b1hZTEhlcVV5RW9FTWNvZkEvcDZw?=
 =?utf-8?B?TEh3aFNXNE9WQk12RVkxc0RlR1g3bEZsRHdRUWxhNE9TWGFyMFM5UzAwZCty?=
 =?utf-8?B?ZU9Oa2Y3YWY2TDlvR1BKZWRvSW90Sk5VdnlZa1JhYk9UOEE4QXF0bC9maDls?=
 =?utf-8?B?aGdESW1GeTBZZzlYclJ1QkMraVZkaVVIRkhNR1NpZGFTTC9zR21sRm05UWtt?=
 =?utf-8?B?OVB0UFQ5K2srUVRCS2lZU2RCNzMzM3dCZkZZZ2l1RXNRU1hyVDROeFVVRzRm?=
 =?utf-8?B?S08yRTJpdHhhNEwxY1JaRk5uV2dTK2FTTmk5eS9DVVRHOUlXckpDMGEzMEFw?=
 =?utf-8?B?MG10VlE3TEJyc3hFQ3FveHpPUlQyYnNmSGNqbVlwRzRDYjg5b0s0M0haWElU?=
 =?utf-8?B?WlVvQUxvaGRxeDR5UGlZaVd3alBhaG40aER4YXRreUhnTHNrVm9IL1F6NS9B?=
 =?utf-8?B?YkVyeGozOXkrQmpPSlkwTmRUMlNPdmZodVdrSFVmNnA1NksvZDRjOGxNbnJj?=
 =?utf-8?B?ajdUZ2V4eHVjd0xlU1ZpcDdIeGVJbDF4MCtVS3lncFBBalZwSlY3bkxMY3JN?=
 =?utf-8?B?clpyaTZnWGxnMXNENzBPUEZ1RDJwUzJKaG5kRCtXNk14UmFzclYzamNYaXVH?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28224f04-2663-4e58-ffcc-08dd14abfa9f
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 21:38:23.5532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CslIJ5VhXfRuAC3fXkQSq73LFDEMg9cDHBbNFM10MqIgLZcHGhNIbUPlt9ehYulR+MacqJ60NlHgkbnYYCzW6xVDwI5rWd/lNIjHUIDiv9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7509
X-OriginatorOrg: intel.com

On 12/4/24 15:31, Piotr Kwapulinski wrote:
> Add low level support for EEPROM dump for the specified network device.
> 
> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 93 +++++++++++++++++++
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  5 +
>   .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  8 ++
>   3 files changed, 106 insertions(+)

just nitpicks, so:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index 0542b4b..503a047 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -2070,6 +2070,38 @@ int ixgbe_enter_lplu_e610(struct ixgbe_hw *hw)
>   	return ixgbe_aci_set_phy_cfg(hw, &phy_cfg);
>   }
>   
> +/**
> + * ixgbe_init_eeprom_params_E610 - Initialize EEPROM params

as bot set (also for our internal version of the patch), this should be
"e610"

> + * @hw: pointer to hardware structure
> + *
> + * Initialize the EEPROM parameters ixgbe_eeprom_info within the ixgbe_hw
> + * struct in order to set up EEPROM access.
> + *
> + * Return: the operation exit code

missing dot (.) at the end

> + */
> +int ixgbe_init_eeprom_params_e610(struct ixgbe_hw *hw)
> +{
> +	struct ixgbe_eeprom_info *eeprom = &hw->eeprom;
> +	u32 gens_stat;
> +	u8 sr_size;
> +
> +	if (eeprom->type != ixgbe_eeprom_uninitialized)
> +		return 0;
> +
> +	eeprom->type = ixgbe_flash;
> +
> +	gens_stat = IXGBE_READ_REG(hw, GLNVM_GENS);
> +	sr_size = FIELD_GET(GLNVM_GENS_SR_SIZE_M, gens_stat);
> +
> +	/* Switching to words (sr_size contains power of 2). */
> +	eeprom->word_size = BIT(sr_size) * IXGBE_SR_WORDS_IN_1KB;
> +
> +	hw_dbg(hw, "Eeprom params: type = %d, size = %d\n", eeprom->type,
> +	       eeprom->word_size);
> +
> +	return 0;
> +}
> +
>   /**
>    * ixgbe_aci_get_netlist_node - get a node handle
>    * @hw: pointer to the hw struct
> @@ -2316,6 +2348,34 @@ int ixgbe_read_flat_nvm(struct ixgbe_hw  *hw, u32 offset, u32 *length,
>   	return err;
>   }
>   
> +/**
> + * ixgbe_read_sr_buf_aci - Read Shadow RAM buffer via ACI
> + * @hw: pointer to the HW structure
> + * @offset: offset of the Shadow RAM words to read (0x000000 - 0x001FFF)
> + * @words: (in) number of words to read; (out) number of words actually read
> + * @data: words read from the Shadow RAM
> + *
> + * Read 16 bit words (data buf) from the Shadow RAM. Acquire/release the NVM
> + * ownership.
> + *
> + * Return: the operation exit code

ditto dot

> + */
> +int ixgbe_read_sr_buf_aci(struct ixgbe_hw *hw, u16 offset, u16 *words,
> +			  u16 *data)
> +{
> +	u32 bytes = *words * 2, i;

I would declare @i in the for loop below

> +	int err;
> +
> +	err = ixgbe_read_flat_nvm(hw, offset * 2, &bytes, (u8 *)data, true);

shouldn't we exit early here?

> +
> +	*words = bytes / 2;
> +
> +	for (i = 0; i < *words; i++)
> +		data[i] = le16_to_cpu(((__le16 *)data)[i]);
> +
> +	return err;
> +}
> +
>   /**
>    * ixgbe_read_ee_aci_e610 - Read EEPROM word using the admin command.
>    * @hw: pointer to hardware structure
> @@ -2349,6 +2409,39 @@ int ixgbe_read_ee_aci_e610(struct ixgbe_hw *hw, u16 offset, u16 *data)
>   	return err;
>   }
>   
> +/**
> + * ixgbe_read_ee_aci_buffer_e610 - Read EEPROM words via ACI
> + * @hw: pointer to hardware structure
> + * @offset: offset of words in the EEPROM to read
> + * @words: number of words to read
> + * @data: words to read from the EEPROM
> + *
> + * Read 16 bit words from the EEPROM via the ACI. Initialize the EEPROM params
> + * prior to the read. Acquire/release the NVM ownership.
> + *
> + * Return: the operation exit code

ditto dot

> + */
> +int ixgbe_read_ee_aci_buffer_e610(struct ixgbe_hw *hw, u16 offset,
> +				  u16 words, u16 *data)
> +{
> +	int err;
> +
> +	if (hw->eeprom.type == ixgbe_eeprom_uninitialized) {
> +		err = hw->eeprom.ops.init_params(hw);
> +		if (err)
> +			return err;
> +	}
> +
> +	err = ixgbe_acquire_nvm(hw, IXGBE_RES_READ);
> +	if (err)
> +		return err;
> +
> +	err = ixgbe_read_sr_buf_aci(hw, offset, &words, data);
> +	ixgbe_release_nvm(hw);
> +
> +	return err;
> +}
> +
>   /**
>    * ixgbe_validate_eeprom_checksum_e610 - Validate EEPROM checksum
>    * @hw: pointer to hardware structure
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
> index 412ddd1..9cfcfee 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
> @@ -56,6 +56,7 @@ int ixgbe_identify_module_e610(struct ixgbe_hw *hw);
>   int ixgbe_setup_phy_link_e610(struct ixgbe_hw *hw);
>   int ixgbe_set_phy_power_e610(struct ixgbe_hw *hw, bool on);
>   int ixgbe_enter_lplu_e610(struct ixgbe_hw *hw);
> +int ixgbe_init_eeprom_params_e610(struct ixgbe_hw *hw);
>   int ixgbe_aci_get_netlist_node(struct ixgbe_hw *hw,
>   			       struct ixgbe_aci_cmd_get_link_topo *cmd,
>   			       u8 *node_part_number, u16 *node_handle);
> @@ -69,7 +70,11 @@ int ixgbe_nvm_validate_checksum(struct ixgbe_hw *hw);
>   int ixgbe_read_sr_word_aci(struct ixgbe_hw  *hw, u16 offset, u16 *data);
>   int ixgbe_read_flat_nvm(struct ixgbe_hw  *hw, u32 offset, u32 *length,
>   			u8 *data, bool read_shadow_ram);
> +int ixgbe_read_sr_buf_aci(struct ixgbe_hw *hw, u16 offset, u16 *words,
> +			  u16 *data);
>   int ixgbe_read_ee_aci_e610(struct ixgbe_hw *hw, u16 offset, u16 *data);
> +int ixgbe_read_ee_aci_buffer_e610(struct ixgbe_hw *hw, u16 offset,
> +				  u16 words, u16 *data);
>   int ixgbe_validate_eeprom_checksum_e610(struct ixgbe_hw *hw, u16 *checksum_val);
>   
>   #endif /* _IXGBE_E610_H_ */
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
> index ecc3fc8..9dba8b5 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
> @@ -12,11 +12,19 @@
>   /* Checksum and Shadow RAM pointers */
>   #define E610_SR_SW_CHECKSUM_WORD		0x3F
>   
> +/* Shadow RAM related */
> +#define IXGBE_SR_WORDS_IN_1KB	512
> +
>   /* Firmware Status Register (GL_FWSTS) */
>   #define GL_FWSTS		0x00083048 /* Reset Source: POR */
>   #define GL_FWSTS_EP_PF0		BIT(24)
>   #define GL_FWSTS_EP_PF1		BIT(25)
>   
> +/* Global NVM General Status Register */
> +#define GLNVM_GENS		0x000B6100 /* Reset Source: POR */
> +#define GLNVM_GENS_SR_SIZE_S	5

unused define, please remove

> +#define GLNVM_GENS_SR_SIZE_M	GENMASK(7, 5)
> +
>   /* Flash Access Register */
>   #define IXGBE_GLNVM_FLA			0x000B6108 /* Reset Source: POR */
>   #define IXGBE_GLNVM_FLA_LOCKED_S	6


