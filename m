Return-Path: <netdev+bounces-194344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F029DAC8C97
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 13:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2FD1BC1786
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 11:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C0421D5BD;
	Fri, 30 May 2025 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJreu3Vw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E1D21E082;
	Fri, 30 May 2025 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603135; cv=fail; b=bH9ETIkCIcBn8cfCrRlPGmOwxbzQfu8w8IieGXq348oO5WMyuoBUorlYZkrB+CQK6vnHvVlWj+TZG+GAilswrwJ8WzEiDAscxhVxhec9vn+6sVPZh8w6It+AXz9itXK29Vb2n1IpCobCu1MZcB++U+Wz9hte2HCo+YxKC7QZV4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603135; c=relaxed/simple;
	bh=1u2o8PUaY9+UEIu6EBOs008YkYYsI3Q+pc2bvLZA648=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WRD9dP2zP38CbkWYrbMylloIFYdAoH5hw0ybr1LoxyW8rHGNObjUkh7DFi67gq5TC9mEUH4Zo/xYB+6omaxnzWsVHHEX3RCGUy5YYk1hpFPqbNrtcZCvXGl1lN4xhtxSCwsMyL0wHJ+jwafV7b3aqenD67Z79EW7QjWPVqoG0+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJreu3Vw; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748603134; x=1780139134;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1u2o8PUaY9+UEIu6EBOs008YkYYsI3Q+pc2bvLZA648=;
  b=EJreu3Vw/bB2ahXpE17DLgXmhacjVGsIkN1fIuxMne7X3YNCgFLpinFQ
   hu6v04ay6/T94Wmdoqd06OK/Dvx97nIUfZibY/ioCrbuWdxbNDtdFWc9a
   jtmKc4w+7B5dq7UDV3psivS19/H1y9oOPKsi3Of/ehqMFI2W3cONu4l1j
   +zIXXJdYUKLcYXZBN4PjYaF0ujCLzR6ajKcp8mNNxKB0dPVUireg2Vfu4
   xQNOD1l3QP8UCVQW+V15jZXBnu07Inozp+I8EDz4dHTfs1GxH0mUKWLQc
   onYojGMboNmCvwUTCywDSqRbeCm9gpg3zy2bYOr1H/S9SWPp36kbw+lIk
   w==;
X-CSE-ConnectionGUID: 1nWjDpqpQjSFRYDLnU8VgA==
X-CSE-MsgGUID: KS2cy+DvQzKK74NLNSL1JA==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50572512"
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="50572512"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 04:05:33 -0700
X-CSE-ConnectionGUID: EnEX7uu5QtahgBBcgZMaCw==
X-CSE-MsgGUID: VBMFF+HxR+OPxkCKSEx+Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="143808800"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 04:05:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 30 May 2025 04:05:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 30 May 2025 04:05:32 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.68) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 30 May 2025 04:05:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBk54f1DEzQ0hsmLRaANdtn0LcxKCUjp5x4vwVf8m8EeAbGZ5/jsUGAOFFLROvNU2m0KQhE7RnOCKj/Ps7odnBSqx1H6ZQ7sS1wgl5QBpb+PgatAZ2cxh3lZEuY5xQ6xVAqCSZMMRp+lv9iIoQ6xBpH+eOBycoilx24/RJoeVUA4R3qkNsS5R1eqZUq0gihS37sxuAe+LQvjtQOTqVcMcApp0jQ+eQbdjrbsD11JYtTL9md6njdODs2MdKZPVyYuOA6mdost9wkmN0XPxs4ysNsaSZyO/qjOlIx6V1/L7TcUsChIH4EbV7CTx24cTqdyf8+SLiYNabOgdQfHDens2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmL2tSkRaIvNq4oDc+dZWayoHeJMb9rXj3USgchwz90=;
 b=Nd3kDukHpgWg9jry8qpXKKUIDVyhsFumciHkNaOZ5TC7IKRSxmEwJu36BJC2y7FixOO/pUC4oneyd0btuLT9O6jTJpv/3M/xVTHFZUtfAVURMBwFJ37mQXYzDorref2Srppj/EB/CSkjdlevnue3e7fzolxMdSSl1QN/86rlEKJHNcw6BpCkUB0FUw/vz6IrtkH/9iUbxyvEECiuWtMWQ2LPwtg8HO0vDpjWAlrH8G4GHdSiQrZtxyRQlG/HUtx9IbIonNrwwSX4iKVzaw0DNnWyJzIhzuB4PwA5s1hgEAJXL8Ar78RKpRBHMBkIt0mpiaEZBJISoxENoVLUS+NCYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5057.namprd11.prod.outlook.com (2603:10b6:303:6c::15)
 by IA1PR11MB6073.namprd11.prod.outlook.com (2603:10b6:208:3d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 11:05:30 +0000
Received: from CO1PR11MB5057.namprd11.prod.outlook.com
 ([fe80::4610:6d6c:9af6:2548]) by CO1PR11MB5057.namprd11.prod.outlook.com
 ([fe80::4610:6d6c:9af6:2548%5]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 11:05:30 +0000
Date: Fri, 30 May 2025 11:05:20 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Jani
 Nikula" <jani.nikula@linux.intel.com>, Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Qasim Ijaz <qasdev00@gmail.com>, Nathan Chancellor <nathan@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<intel-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v12 03/10] ref_tracker: add a top level debugfs directory
 for ref_tracker
Message-ID: <yw6q2dmbryfmjjvocgb5m3tow3udyy7br3dapfpbnchzlipmu7@xn4fvhsdgjw7>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20250529-reftrack-dbgfs-v12-0-11b93c0c0b6e@kernel.org>
 <20250529-reftrack-dbgfs-v12-3-11b93c0c0b6e@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250529-reftrack-dbgfs-v12-3-11b93c0c0b6e@kernel.org>
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To CO1PR11MB5057.namprd11.prod.outlook.com
 (2603:10b6:303:6c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5057:EE_|IA1PR11MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 0603f765-95c2-46ae-d28c-08dd9f69e3ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHZKSDM0QWFhZWVrTkFFbTJEbUpMdUpLUk5CVWV2S2RMbHIyTXRzeTZJRkxi?=
 =?utf-8?B?Mkk1Wm5Xdk5qQkIvYnpoWloxdmVkQS80enVlWWh6dmRCSGQwWVhIOHg1SUh5?=
 =?utf-8?B?M1FCWkdsU0N2WXBOMGQyQjdIc0g3dnVyS3VYUko2bVN1NzJ2anNPV0FoVjk0?=
 =?utf-8?B?Q2dLVnlNZUZXdC9uWmEzUDdVZ2RWZ2FCWjJmcFhUNEVvOU1pNFY4NFN0K0hE?=
 =?utf-8?B?QVNkeDhWenBtMTlHd0lGTnFaTUt0bENPa2dSQ3p5VTM3WlQyWUJ0bUErdVVO?=
 =?utf-8?B?Zzg4VWtyUGllWkpZVXc3RHFWcVpmOXI1RGpReEl0WENXbHlkV2QySk9DWkxM?=
 =?utf-8?B?RWMyS21uRXdFNVdmSmJjazdpMDhza0JselMzVDFmUm5ud1J6Q0RHbFhBWlpM?=
 =?utf-8?B?MmlaaTZZNmVDVFRVRW40cjdrQUxkRDJ5dll4TC9GT2dERUlpcytKMlY3Q0tu?=
 =?utf-8?B?WWF3VHRleUx6b1oxM3hDVnlkZ1o4eEJHS0F0UGtXUFlyS2RtQ3dRY29qTlh6?=
 =?utf-8?B?ai9najExaWhaL1FuaXJhTm5LbFdtelU2TjFWSVJjRnU0MldERmRZeVozcSs5?=
 =?utf-8?B?TXdHRC9zUGx6RXpOZ1VXYUtmYXcwNngzYzhlY3owMkxMcnRNdzVjWnUyS2Fm?=
 =?utf-8?B?dlRKaWVJbGtyOWxJZERrWDJzZFF1T3M2MzdjdEhJakNDSEs5M3pNOWNSMm5t?=
 =?utf-8?B?cmJaZS9pS3h2MnhKQWNLbFREM2ZCbG5oRThndHZrNDF2NmZ1NHZyOUt1bXNC?=
 =?utf-8?B?M0QwT1dPZG94RXJtcWlqVGEwWDkvRFVtaHZWSWM2OXIvb0JTT0doVVRzSW1t?=
 =?utf-8?B?c3hGakVzSDBIOSt2Si91d2F6V1JtUzkxMThjMExHMHQzdU9aWlZTTWx0eWRN?=
 =?utf-8?B?eEc2QXlzNnBSdHA5UU15eUptZ2RUa1ZLTjVMdWE1Z1RIWWNEMHZTTVhJL1V3?=
 =?utf-8?B?U24yK1luaWRYSmpmYmdKWXRVNzJrUkpyeElrTGcvdXZHbnlkYkltSmxPRGtG?=
 =?utf-8?B?ZFhlSmgwOHlnY3VYMHlWTUtMMXgvYWpQQ3k2UzFVenFTeHJrMC9La3RORHFZ?=
 =?utf-8?B?V1NXRjRPZUNnYXM0bERBUUtpZWlKRUVhWStHWWI3b1JGNjFwQldjb1hSazA0?=
 =?utf-8?B?WnJnaU4rVWFUbDl6NVJWQ2QvemgvSVA3ZWJQMG40b24xRGJjdFArN1pvTGFU?=
 =?utf-8?B?bG9DUDE0cTZPeEpiZ0I4YUxqTnZQNThhWFVZb2gxSitaNlkweXZQZGtBWWl1?=
 =?utf-8?B?ejJ3N0xkYkE3VFBNU1NTSnZqT3JEdGgvdzVFQXZvYTlwNmVhL1hZalpxaVRB?=
 =?utf-8?B?ZnJ3WHlBZUo4d28wUG16dlhHNjZIYzIzZDZWbUgram4vNVBJdHowK3NEZmdw?=
 =?utf-8?B?QlVpbEdqQWhnaWtFUlBtbGZWdkJCK3BIanNDVVNreEtLSytWSDZPQWVzNlp5?=
 =?utf-8?B?WDExOWZnbk1YUjZiWXpNMk9PdTRwenllR1U3SjB0bndVY0lJTnMvcmw1SzBW?=
 =?utf-8?B?bjYyVm9UbElnWlpmQWl4ak5JMnd5OWdWT0tOSHZBQlFjcXZaeEdjcm56N1NJ?=
 =?utf-8?B?T0IxaVg3TWFxTU1WU1Q0aFQ3R3dYNmxSNEhMMkR5T2tKWmY3SU80eWZvbHpp?=
 =?utf-8?B?ajQ3c3E5TzNzUy9Pc2lKbEZwMU0xeGI2bmF2VnJKdFBidUdNTmErWEJDNmdS?=
 =?utf-8?B?R21WZ2t2eURTZlRaOTdBbStFdUErbGVZMVovVzg5VWlqclkweHNnL3ozWDJo?=
 =?utf-8?B?RjRPOXRQMWZzWVZUWEIrYnljT0N6V2VWV3p0ek1OaWJrUExSbHF0VVA3dkIw?=
 =?utf-8?B?NUpRVVZqQksyOUlQZGdwbWNkSHhUdWk3d3JuaWw3bTk0K3NFVU04Y0p5eEda?=
 =?utf-8?B?UnN1MVN2TytnMStadVBYdE1BMkpHM0FGekIyZ1J5RWtuTVhyZ0g2SXNnWlNB?=
 =?utf-8?Q?b2URJAufPqA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5057.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWk2b1Vmc1V5V1BLNkZlL2xjb2xUa3dFMCs3c0tmeXB5dktYa2gwMWRqa3FK?=
 =?utf-8?B?ekhmNWRpWmQ2bTdSaSsyclFubjZXaXplOGZNSnBBU1EyMTJTN01DUGVOSXNN?=
 =?utf-8?B?anF2cnBETXQyRW1XaVNKdldWTVUweGMzcHVGSHN6cjNEWUs4SC8rVzBmVzQ2?=
 =?utf-8?B?TXMxZ1JFUGJMYlRlSkJnblFzMWdmbmk2aDh6b1UvUmxxSFlUY215NExVMHFU?=
 =?utf-8?B?UjlqVDYra0JhUlpZS0FrU2p4cllhbGluaURyWFRBVHMwNXoxRnFRZkN5Vlh0?=
 =?utf-8?B?MmdGY1FXODNFV1h2eFA3ZGwxTzFzd0lXdWVxNUdxNm1SZzNTNHluUnhJSTZ6?=
 =?utf-8?B?ZDZXS0E4WXZFZW5JbHh1NnZYRzRpYk0xY3ZpeVlna0JYa25VWEpINTZlbTVR?=
 =?utf-8?B?YnFQbjI4MDBjS1BXeUZQV2JGNUZvdDZZWnovbElCaDB0MUpGb0VhRTd4eHNP?=
 =?utf-8?B?dmF6VTVwZlFBWlFXMm9UL0JOQjVUK2IxaS8vVzRFVjhaeEl4OFpLYi9pS3Mx?=
 =?utf-8?B?V3Nnd25zeGIyL09wclVUYlNsWDdsWGhZZUV3SVpESEh5YkZqZ1c4Y2pNelZT?=
 =?utf-8?B?UU5kM1hyTUM0RHlKUlJSeGJNWG0yZnVoZGhLa0RXc1NZVC9nZ21LVUIzVlUz?=
 =?utf-8?B?NXBXMU1iVFZPcCs5a21kRFZxS08rQ0oyOTZtdFZ4TzdOK0dheFZzNzEwTjFD?=
 =?utf-8?B?Z2h0K25ob3A1cFdLQkZYdmYrYnlEd05YUG1GeDJxMGxlei9jbFdsWW05dC9J?=
 =?utf-8?B?bWk4ajhvYkMxT0g2L3I1R2ZJQXJVZjFXd0FhSy9YMmNkT1J1aHczRUF2dmYz?=
 =?utf-8?B?ZHNJdWZMTXpaS2lROEVmLzBwZlFicEFQVFQvY3F6c0hBRmNoN3JrTVZWRlg0?=
 =?utf-8?B?MEE2dllhNHNiVFo1akpHYlh2MWFOTU0wai9mNUFVYjdRQ0Nmckl1cEgraVNt?=
 =?utf-8?B?SHBxRHE5aGxZSG1oc3RCQjdyZDYrZ2JKeHZBVm52N2tpVzdmb3oyMWxuaUVY?=
 =?utf-8?B?d05ZdVNQb003RGR6ZVBvcVRLMWpDbFFoV2RDcUQ0RHJNMW9DMFFqZjhXSHlJ?=
 =?utf-8?B?RjZpSHJobzNlTWtVK2tmNXlVZGI0dVRLU2FNemtOWkNManFVdU04RndJY3hN?=
 =?utf-8?B?b1BCRG1hQng0VUEyRVNNUWg4bk5kOE5CZU9IOVNua20va0R5NXZCd0JqWHVT?=
 =?utf-8?B?ZTNMTXVZYy8zQnZQZnNqVGpDNnUzTnRLUnV6RnprWEhlb2tmNzZTdFZaSkRW?=
 =?utf-8?B?bTl0dmVuamY4ZFRyZ2w2SmgxTGZVaDhrWHJXdyt1dXdNcjc1WDBRdEtxSk9l?=
 =?utf-8?B?QitCSFFHUHVwOWpGRnJVQ2hhRXdKa1JUa1hkUXI2WDBKakc5bmQxcWZoTEZM?=
 =?utf-8?B?aDFRaHB2WENHUjFod1hFNFRmeWZKaWVqN3duMTJKSVEzMFBMWmNueElxa0xv?=
 =?utf-8?B?SlhYczBhbzVYZ0V6dmVWaVR6U0tsQjYwS1hTZTdWVDhvc2VMYnZROTF3SGtH?=
 =?utf-8?B?WnhUTVl6REtGTWszUDBWMERpajNNdVpDOFhDZFZiVkRkV0ZSSzYxQjM0Wmhj?=
 =?utf-8?B?REhlbkxlVUdBeWZmd1N6RURIUzIxVm04dnh6WExESjNXQlprOWkwLzJJQ0VO?=
 =?utf-8?B?RG9YUUcvMWpwRXdpWkRad25pT0V2OFpkb2pzTXpsYWhpS05ZTWhYTUErYkU4?=
 =?utf-8?B?REpZWnh3VW0zanBOb0ZXeUovUlBhQVdoeDhtbTM2bmJrc0FqRi9GNm1ZbW4z?=
 =?utf-8?B?cHhMbit0MWZKTW9oRThoMDZlNkN2c1VTdTJnYmc5dWRncS9wNzBZczNVWm9D?=
 =?utf-8?B?L2FDYS81VERqWDMrRnZKOUVrNzlQRlduVXZ3VCswZVovRVhSck9UM0xsRWxC?=
 =?utf-8?B?VUMzWkdGd2w3V2JuY0g3K09UbmF0aDE0R3Z0Sk91QUViTGxlMTdOSjZSSkxl?=
 =?utf-8?B?eGZiNzBROWdtNFNESnVoa1ZObkRicGNTUy9MaURMY2wvaVl0cWg4TGgxZCtJ?=
 =?utf-8?B?RVNLNFNtb3pEVDFLOHZzMVErQ3dHZjdXb0JNQVZiSjdTTWdOS211aG8yNEc3?=
 =?utf-8?B?K1FLb3dCQjRINDJaN3ZZY2lmZDRld1RGUkJ4dmlFa09GU3NqSHh0aEhkRFJQ?=
 =?utf-8?B?N0MwQ0tXRmVwVmxGTEJPNmhOdlJSRGVUYlNKcFlGQjNXdnZtYlR0WXNJSmlT?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0603f765-95c2-46ae-d28c-08dd9f69e3ec
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5057.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 11:05:30.1897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cnb3hftbQknUbI/gJ8hinSZBYCOCwIYsiAVdzZ+vT6KglYpltUnEzdGQFRsoe2tLqWpW13c/qLVq0kR2ejki0+S9mC1cacIAZG6i7ZSBw9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6073
X-OriginatorOrg: intel.com

Hi Jeff,

> Add a new "ref_tracker" directory in debugfs. Each individual refcount
> tracker can register files under there to display info about
> currently-held references.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>

Best Regards,
Krzysztof

