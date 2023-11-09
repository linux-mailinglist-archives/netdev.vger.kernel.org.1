Return-Path: <netdev+bounces-46952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50D17E7532
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 00:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A542810F9
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 23:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7820E38FAE;
	Thu,  9 Nov 2023 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dit8gW0V"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E5838F96
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 23:35:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8994482
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 15:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699572952; x=1731108952;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hn+9kAmwcPK/onvNOcbqK81eJhpyBBUxuoszSzvq+Xg=;
  b=dit8gW0VQZF1/wnKomZ/ngTkOhRZ4wU0AU3mnggJkch3QwtS80uNuGDB
   Skq6aRodWKAIZl+RXnGUUvE8ILMPejz6GbtsNOKdAFC19VYoO97+nHU7d
   mat3YHNWaKUTuXRzEsDOLrCFylGLVMkmPIDdL5SS6Hh5PkzIhyEVjsO2m
   MndvY4B9+Ffryjx0DXzGGAqeCPypkxBxOlNAu/YhKTHKB/7T1BwBL8V5A
   tMTwkK2KsFcpqUOXxpqCRiCLhCMlq2sr/ke5MmlbIANgzogRjiQgrv7AK
   fJq5V2Ysz6Vn5ukmb+S8w8CBXi/xmRLn9CM3QHKPpJvgXvgk44XWOkGW0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="370303381"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="370303381"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 15:35:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="907290828"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="907290828"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 15:35:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 15:35:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 15:35:51 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 15:35:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDIV3GjRuG9FuhkXqmRWFzfB6zIKzLu4X5mgPref23MlL3zexRVUwOOJ4kw9Bsk3pPg6UIEdOKeQjtXni28PEgdizA5EzmU3RpwV021xsyucZuQ83J1bz9Q78EyQ1TPW9BWbi3kF4EDtmn9RxceSFchXayPXDq1FjZTXyR0zX/JpJQzLDXp8xUHGkOW04oNWkOTcNfUCY19U60aXf0TpTYhicNygF+osUMsMG5kUHJKdsfneqaEwbWsFTAPYeGMEbXpfl4qs86Gl5LamV6YwEKbmcx3y9l2XUeiv8RMk9RuQvTllkCjVb4yTnBzKfi5/YB36dSMbaob8HP1MkYrvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uROm6TpRi4YJCQvzViTyFNhANQUUzhKywUuunfQePc=;
 b=ahpy1e7qfmDIbhowepOgt2/sQpUrqA8kEt4W3Dwwl/B/t47vdpOugcXuhIpa/U4c+EZHhTcA0KhzOM3Jg6fOITR3A1Gt2H76S+BcqvHY4m6HkEh9QjEWNd04xX5wSyxTSovrdNqpiCfvAP/dNtwM1Fyxr2wQTc60b2gsEb2hE/3W6mW0Ovrv2pIjH7/7R+HCC0/lO+VtUjSFdE6MI1/mLR5hryKaHwm4KeIYZtBd0KTPMiWy9O8P3a04TAPfO2+5dlN6nbUSZ6NANcFLV0RQIKkxO3TzidKhXi6eWvDm53re/aGhk7QOyRla8ojR5qVTQC82MWpWfneJnVa1oMwbVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 BL3PR11MB6339.namprd11.prod.outlook.com (2603:10b6:208:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 23:35:43 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab%4]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 23:35:43 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Michalik, Michal" <michal.michalik@intel.com>,
	"Olech, Milena" <milena.olech@intel.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net 0/3] dpll: fix unordered unbind/bind registerer issues
Thread-Topic: [PATCH net 0/3] dpll: fix unordered unbind/bind registerer
 issues
Thread-Index: AQHaEi9OB4zvczpCGUaIr1usLpOLxrBx0M4AgABky0CAABUngIAAWuQQ
Date: Thu, 9 Nov 2023 23:35:43 +0000
Message-ID: <DM6PR11MB4657209FFC300E207E600F3F9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <4c251905-308b-4709-8e08-39cda85678f9@linux.dev>
 <DM6PR11MB465721130A49C22D77E42A799BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU0fzzmmxjnsNW0n@nanopsycho>
In-Reply-To: <ZU0fzzmmxjnsNW0n@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|BL3PR11MB6339:EE_
x-ms-office365-filtering-correlation-id: 49fe6d20-c22e-40e0-f4c7-08dbe17c9731
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /eBvqh8csKl6185D1FuAZdJzJJQdix5wuw9pI+U/rCRAPZnUjMlKnpjNY4xPS+s7Y3ooWz/UnocNpyQ5K8Id3DJyJSCi0g5DNLdYH+9vrUWbDICq+6ldIdn7TEsEg0kzubvenIDXHcnn2UpO32DELegQJx+VXy4jklFjytIC5yiypkqY0Y1DGvC2qUIZWTOLAhy5yWMh3W8IAohdDl3ZvUxsnp8QoqAJ+mdbVmbEnIm/hHEjt3RTYfiRkSwT5deqBnnuL2IiNhKLBryKEfHTcv5WRkgUQZBWR9mqcowkvju6fEn0l5gULoprfQXen4Oz09vTOZisrllo6M12qToPxIC910hMnZ4P0e58jDYhVv1/hs5nfrIH1VRyHTkm3vEq4l50t8XwQfCO0FZUgirunjdfWMzrYnk1BwNQ1dxOkhKBREMrf4v7VI4bDC7cnuunojP24jRPcB8/Rml2tkaua5krVe9gcEKYypwdltDgeOX89vqKUaGNcnLvZzwzf2nynSp7ndf0EQGL9ryckCLE92xG65I+ktWvGLNj+aZuydA7EKLqTevAjiXd5Uxvjt2faBUx/RBrec4IKbiSiLkXj0ie0wfNIPRyZDya2/5OKaGC1TmPx6kpo6ZU1FTtrAme
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(71200400001)(55016003)(83380400001)(122000001)(7696005)(6506007)(9686003)(26005)(82960400001)(45080400002)(478600001)(38100700002)(8936002)(66556008)(66476007)(66946007)(66446008)(6916009)(64756008)(76116006)(316002)(54906003)(4326008)(2906002)(86362001)(5660300002)(41300700001)(8676002)(52536014)(38070700009)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KeDzFSVMB+9fx45yeEl8P7flJFJYwzylLAiKFIFwKjYm0V1HMQ80F7eKvDB7?=
 =?us-ascii?Q?qw1UXmqIwn4RsU490P/uG5nZ3gJTTQh/+wC8eODHCOW72VtKTy0osoAaSTfr?=
 =?us-ascii?Q?Z110hP38VPe87y+RNTwH8OHU0l5aVp0Qryv1TxfkrGX4LqSoOhbc0dqoy9A9?=
 =?us-ascii?Q?gWltC6EXTLXo3hvGCUU3dngakDwRozZCWhOmYxM+4vUhB6rxiP7Da0VyNyW+?=
 =?us-ascii?Q?WJrw+sY4inW+GbUaYF82o7+gzCPS/CpAg+CK7vOOtOeWQ732A8oxGbind5+c?=
 =?us-ascii?Q?sUFPGSvUuageMfMj2TEzRAK+0tAT/0u285FQn/tTmY2p973Xv6EBFzIqTgyl?=
 =?us-ascii?Q?xyCkIWle42/TiqcWkTx5I3AfnOiFIHJBzG5T1wdJARnxZh2MfyMT6XPasp4I?=
 =?us-ascii?Q?POmdi8U3C9l24ZjhJCpNG5fzhiJJraJGy60U6cos5aUSk4kSZBG3yI+6higR?=
 =?us-ascii?Q?11BH5VIMjep0WtzFOiUPEzbM8b0AHEg6jTPro3A7ybj1Hdy2PH6CtsyoTNSJ?=
 =?us-ascii?Q?6uBDDL3xPKd3FNKmCoYghskNhLjilgaIjej64vdc3P0WXvJ12Uhm1a229oQC?=
 =?us-ascii?Q?Lt39+p4SFhw8nbKeUwQptQHlqip7taKKsJ4A6Aeuk0PAhNWzr/WqTqbFh8kp?=
 =?us-ascii?Q?vI3ThfmGUaq8hYBftlvlaL8y3CHLCBRt9YlZQXnh3lNDAv8dGoK6qs6iZosC?=
 =?us-ascii?Q?I6eV2dzpcft3s+j8pCkRwNJUbadNfYcyC3j8btjrlOlndy9xVnuDfJyEatIv?=
 =?us-ascii?Q?rCbksFpVHuSKxYmdVtTcayux6K6YagoxTAq065l/a38urAT8AUJlZ2DZVREm?=
 =?us-ascii?Q?Dd761FRU37QhFDCC72Kj2lOblZciQqBOdiFTrzO+cg4OzBw4l8u2Fj7wvnNJ?=
 =?us-ascii?Q?T5ftglT/jN/SDhVvz+nWVJFdZUmKhJ/3aZlNjMRlatAKcRNrbrWfIPKt0k43?=
 =?us-ascii?Q?UC0mn2tAql68lXJUW8YMRqLUzaTuF/pslGTMNqoPhi4y8x63MINFZUOAVB8P?=
 =?us-ascii?Q?v20ssNOh8B/KNe4pCc6Pjrzsy/wZ1xmLqcmIp0/tqlxPhk0WJC0Isr3aK6do?=
 =?us-ascii?Q?pVekmyxvRWRdaZvtz9SGmQCAjsGMYRJehtaxYCClznYAKng13b4CHETKh2M3?=
 =?us-ascii?Q?VAUfKAZnOX3lwh/c25laJ7vXJE7T6Q3yNOowWo7oiUeHib1V3+2hFMsEt7u4?=
 =?us-ascii?Q?jXQIeKHjZoHd9EksgHay+RVFOuCIzRSKFFpxF8H+rpfmmUpE2E8yhArh7j5n?=
 =?us-ascii?Q?eJfndZHEVUp+ZgTWDG+epFHb/9JmGGpCwTDLB96uymmD0Z1DLxh3JYAeRv/a?=
 =?us-ascii?Q?JQ+tG89UXPbXSUxPC2DDHFzVLRv0v/k3PeDGlDhP/n8ezB0Ik5Un3Qr9s/Rk?=
 =?us-ascii?Q?VfDYf3YJDSRXxATu8PksId9velcgd6cDfk91R7//7InEHcPSqhne+8wxn5Sc?=
 =?us-ascii?Q?CJOMdF9FTP5toVNOxZiA30bIzGiLCUwk/XEShTtnDAR1Yc35OOtHTlJjkmoD?=
 =?us-ascii?Q?h0MuRErWSpsF/m11iEqpFvOmt2ZrV2owK3uSiLjYHbHRaJGSQ9zjb4ThTgGn?=
 =?us-ascii?Q?1yc8xk/8or001e2jz45soKO1cqow2bsdL5qHINOFgq1IUlnf9FWfUzddgmV7?=
 =?us-ascii?Q?RA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fe6d20-c22e-40e0-f4c7-08dbe17c9731
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 23:35:43.1272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HC6R3QioF+y8b6VGLzK1azHSI9RBVY4wEpUExzgfc+28piBtj5NABeDUgDXJUz39oJ4o6T2KTUkKas3m6/DrbyZo8CSl/fBOHeKXPCV79jE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6339
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, November 9, 2023 7:07 PM
>
>Thu, Nov 09, 2023 at 06:20:14PM CET, arkadiusz.kubalewski@intel.com wrote:
>>>From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>Sent: Thursday, November 9, 2023 11:51 AM
>>>
>>>On 08/11/2023 10:32, Arkadiusz Kubalewski wrote:
>>>> Fix issues when performing unordered unbind/bind of a kernel modules
>>>> which are using a dpll device with DPLL_PIN_TYPE_MUX pins.
>>>> Currently only serialized bind/unbind of such use case works, fix
>>>> the issues and allow for unserialized kernel module bind order.
>>>>
>>>> The issues are observed on the ice driver, i.e.,
>>>>
>>>> $ echo 0000:af:00.0 > /sys/bus/pci/drivers/ice/unbind
>>>> $ echo 0000:af:00.1 > /sys/bus/pci/drivers/ice/unbind
>>>>
>>>> results in:
>>>>
>>>> ice 0000:af:00.0: Removed PTP clock
>>>> BUG: kernel NULL pointer dereference, address: 0000000000000010
>>>> PF: supervisor read access in kernel mode
>>>> PF: error_code(0x0000) - not-present page
>>>> PGD 0 P4D 0
>>>> Oops: 0000 [#1] PREEMPT SMP PTI
>>>> CPU: 7 PID: 71848 Comm: bash Kdump: loaded Not tainted 6.6.0-rc5_next-
>>>>queue_19th-Oct-2023-01625-g039e5d15e451 #1
>>>> Hardware name: Intel Corporation S2600STB/S2600STB, BIOS
>>>>SE5C620.86B.02.01.0008.031920191559 03/19/2019
>>>> RIP: 0010:ice_dpll_rclk_state_on_pin_get+0x2f/0x90 [ice]
>>>> Code: 41 57 4d 89 cf 41 56 41 55 4d 89 c5 41 54 55 48 89 f5 53 4c 8b 6=
6
>>>>08 48 89 cb 4d 8d b4 24 f0 49 00 00 4c 89 f7 e8 71 ec 1f c5 <0f> b6 5b
>>>>10
>>>>41 0f b6 84 24 30 4b 00 00 29 c3 41 0f b6 84 24 28 4b
>>>> RSP: 0018:ffffc902b179fb60 EFLAGS: 00010246
>>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>>>> RDX: ffff8882c1398000 RSI: ffff888c7435cc60 RDI: ffff888c7435cb90
>>>> RBP: ffff888c7435cc60 R08: ffffc902b179fbb0 R09: 0000000000000000
>>>> R10: ffff888ef1fc8050 R11: fffffffffff82700 R12: ffff888c743581a0
>>>> R13: ffffc902b179fbb0 R14: ffff888c7435cb90 R15: 0000000000000000
>>>> FS:  00007fdc7dae0740(0000) GS:ffff888c105c0000(0000)
>>>>knlGS:0000000000000000
>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> CR2: 0000000000000010 CR3: 0000000132c24002 CR4: 00000000007706e0
>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> PKRU: 55555554
>>>> Call Trace:
>>>>   <TASK>
>>>>   ? __die+0x20/0x70
>>>>   ? page_fault_oops+0x76/0x170
>>>>   ? exc_page_fault+0x65/0x150
>>>>   ? asm_exc_page_fault+0x22/0x30
>>>>   ? ice_dpll_rclk_state_on_pin_get+0x2f/0x90 [ice]
>>>>   ? __pfx_ice_dpll_rclk_state_on_pin_get+0x10/0x10 [ice]
>>>>   dpll_msg_add_pin_parents+0x142/0x1d0
>>>>   dpll_pin_event_send+0x7d/0x150
>>>>   dpll_pin_on_pin_unregister+0x3f/0x100
>>>>   ice_dpll_deinit_pins+0xa1/0x230 [ice]
>>>>   ice_dpll_deinit+0x29/0xe0 [ice]
>>>>   ice_remove+0xcd/0x200 [ice]
>>>>   pci_device_remove+0x33/0xa0
>>>>   device_release_driver_internal+0x193/0x200
>>>>   unbind_store+0x9d/0xb0
>>>>   kernfs_fop_write_iter+0x128/0x1c0
>>>>   vfs_write+0x2bb/0x3e0
>>>>   ksys_write+0x5f/0xe0
>>>>   do_syscall_64+0x59/0x90
>>>>   ? filp_close+0x1b/0x30
>>>>   ? do_dup2+0x7d/0xd0
>>>>   ? syscall_exit_work+0x103/0x130
>>>>   ? syscall_exit_to_user_mode+0x22/0x40
>>>>   ? do_syscall_64+0x69/0x90
>>>>   ? syscall_exit_work+0x103/0x130
>>>>   ? syscall_exit_to_user_mode+0x22/0x40
>>>>   ? do_syscall_64+0x69/0x90
>>>>   entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>>>> RIP: 0033:0x7fdc7d93eb97
>>>> Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1=
e
>>>>fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 =
f0
>>>>ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
>>>> RSP: 002b:00007fff2aa91028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>>>> RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007fdc7d93eb97
>>>> RDX: 000000000000000d RSI: 00005644814ec9b0 RDI: 0000000000000001
>>>> RBP: 00005644814ec9b0 R08: 0000000000000000 R09: 00007fdc7d9b14e0
>>>> R10: 00007fdc7d9b13e0 R11: 0000000000000246 R12: 000000000000000d
>>>> R13: 00007fdc7d9fb780 R14: 000000000000000d R15: 00007fdc7d9f69e0
>>>>   </TASK>
>>>> Modules linked in: uinput vfio_pci vfio_pci_core vfio_iommu_type1 vfio
>>>>irqbypass ixgbevf snd_seq_dummy snd_hrtimer snd_seq snd_timer
>>>>snd_seq_device snd soundcore overlay qrtr rfkill vfat fat xfs libcrc32c
>>>>rpcrdma sunrpc rdma_ucm ib_srpt ib_isert iscsi_target_mod
>>>>target_core_mod
>>>>ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm intel_rapl_ms=
r
>>>>intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common
>>>>isst_if_common skx_edac nfit libnvdimm ipmi_ssif x86_pkg_temp_thermal
>>>>intel_powerclamp coretemp irdma rapl intel_cstate ib_uverbs iTCO_wdt
>>>>iTCO_vendor_support acpi_ipmi intel_uncore mei_me ipmi_si pcspkr
>>>>i2c_i801
>>>>ib_core mei ipmi_devintf intel_pch_thermal ioatdma i2c_smbus
>>>>ipmi_msghandler lpc_ich joydev acpi_power_meter acpi_pad ext4 mbcache
>>>>jbd2
>>>>sd_mod t10_pi sg ast i2c_algo_bit drm_shmem_helper drm_kms_helper ice
>>>>crct10dif_pclmul ixgbe crc32_pclmul drm crc32c_intel ahci i40e libahci
>>>>ghash_clmulni_intel libata mdio dca gnss wmi fuse [last unloaded: iavf]
>>>> CR2: 0000000000000010
>>>>
>>>> Arkadiusz Kubalewski (3):
>>>>    dpll: fix pin dump crash after module unbind
>>>>    dpll: fix pin dump crash for rebound module
>>>>    dpll: fix register pin with unregistered parent pin
>>>>
>>>>   drivers/dpll/dpll_core.c    |  8 ++------
>>>>   drivers/dpll/dpll_core.h    |  4 ++--
>>>>   drivers/dpll/dpll_netlink.c | 37 ++++++++++++++++++++++-------------=
-
>>>>-
>>>>   3 files changed, 26 insertions(+), 23 deletions(-)
>>>>
>>>
>>>
>>>I still don't get how can we end up with unregistered pin. And shouldn't
>>>drivers do unregister of dpll/pin during release procedure? I thought it
>>>was kind of agreement we reached while developing the subsystem.
>>>
>>
>>It's definitely not about ending up with unregistered pins.
>>
>>Usually the driver is loaded for PF0, PF1, PF2, PF3 and unloaded in
>>opposite
>>order: PF3, PF2, PF1, PF0. And this is working without any issues.
>
>Please fix this in the driver.
>

Thanks for your feedback, but this is already wrong advice.

Our HW/FW is designed in different way than yours, it doesn't mean it is wr=
ong.
As you might recall from our sync meetings, the dpll subsystem is to unify
approaches and reduce the code in the drivers, where your advice is exactly
opposite, suggested fix would require to implement extra synchronization of=
 the
dpll and pin registration state between driver instances, most probably wit=
h
use of additional modules like aux-bus or something similar, which was from=
 the
very beginning something we tried to avoid.
Only ice uses the infrastructure of muxed pins, and this is broken as it
doesn't allow unbind the driver which have registered dpll and pins without
crashing the kernel, so a fix is required in dpll subsystem, not in the dri=
ver.

Thank you!
Arkadiusz

>
>>
>>Above crash is caused because of unordered driver unload, where dpll
>>subsystem
>>tries to notify muxed pin was deleted, but at that time the parent is
>>already
>>gone, thus data points to memory which is no longer available, thus crash
>>happens when trying to dump pin parents.
>>
>>This series fixes all issues I could find connected to the situation wher=
e
>>muxed-pins are trying to access their parents, when parent registerer was
>>removed
>>in the meantime.
>>
>>Thank you!
>>Arkadiusz

