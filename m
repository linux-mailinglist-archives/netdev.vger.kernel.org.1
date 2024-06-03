Return-Path: <netdev+bounces-100221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D7C8D8311
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2232B1C24186
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 12:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC64112C52E;
	Mon,  3 Jun 2024 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CrJo0TvW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE612C550
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419521; cv=fail; b=Z0HaieVCWDTxtcxhTjCqoEq+dbX2Igtqff/t5StY/jQuAGaP/ODaDLgprnUQHwGIO5Awp9kHvFPqbAK0Pc0ysMAbdlFDjse3hn4SV6H/5HZU+HdeV/iER35D8LRcEKWJYEB3ChPSc67AsP2L2PFSkCXc5FT/ipsKDiMvQ54Vcc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419521; c=relaxed/simple;
	bh=jqRHcdny3yiovJIebuggZ521baqr70vZDOknsXjb06s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GPAoZFy55ZtgoQfp4+xqRh7p4BIkgwBYm4uJ2IkCnfv/0ox/j/eRQqBKlJMmYRc2k0s+ANfruZkR7Md5BTiT8R2SwHULOTCH49hi4anZ1P0KsULWZUw7YU5zdMqTMgcRRj/fEBG+WjFcEuECabKtTsXUQ8vCr1a48y9NWZqAguY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CrJo0TvW; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717419520; x=1748955520;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jqRHcdny3yiovJIebuggZ521baqr70vZDOknsXjb06s=;
  b=CrJo0TvWsd13c+yiiMhSGDDY5ilNybtBNijwSnePV43XCf5GZHVFGeDy
   0fEG3U7NwXO2wZu1FNTEfXEhFZ0coaVh3yyjeEOxaMHE8HebmG8Z8nGP7
   7jyr3fHND4wrxXUesDeT8u6v+zX2D/4cbA1L4jXxGEHgLNUgVHHsFyQvi
   VMQPbKVPHUvQyFF9EkJnnJXRcRopMdQcf0XUwXjeuUDNpgcln3x7FqQhx
   H6gnQEzg1C4pABejtDch0t2NMr3Z29G3wgomQeaTHksf9ixgQE5TK3bqs
   aZm34utXaMHlDU8+RD/jh23g1nEr1iQUvCb2d8PWxDX1JrPTe5C/kAA3h
   Q==;
X-CSE-ConnectionGUID: auInuoASTqy8jSg9gvUxjg==
X-CSE-MsgGUID: 7kEXAhQJSQKIC53HNRPuog==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13774251"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="13774251"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 05:58:39 -0700
X-CSE-ConnectionGUID: 5z9jnZJjSIKGhWSHG2964A==
X-CSE-MsgGUID: G2cqGKwITwS4JJKl6Zwi9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="41290375"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 05:58:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 05:58:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 05:58:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 05:58:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 05:58:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABm8aqNNjDgBlf3YOIOqwvw0eJnVfQUSC3JucJpsc23QR1Gwx5RE0dSkq4Rsv4Ix5+BmUkLxprCd4/xKpN9ll4wheor4GxERRkNFp7HcJvln6bfX3MEWIaCKf2Qu0l5BLHPlTN4ENo9+w5nsJm+4H7D09NBQQ5//ICXVAtd0lAqr1/yO7KKi+yxKqKhKl9m7opFSOMbK2jKhqX5B30aCVIXwiQO68a6XpxF8LndYtUB8zAeHXZsT5EZNdFmQdxulSzq9KbaSrcMrzzNXFVNCVUIfJSpPYlyyvspETwzk/lM/AmVVjjmdcrwrQcKdCzOanbEG5GDgtq/fCKDIIO/+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BY1bI7p/eLR/wslCFNDGyTM1G7K88RspvX7faBPuvmw=;
 b=PfhIIoMu9XiSfhmh2kJ9oFq5hGDcybrKzA+SuKx/6YrdjfvEv08gjugm0CIV5yyF8l23aO4Qs5L/FUoKWjc8LSWH4wKx1xsaeV+6AVyXC/EfDZjn0NlVwbLrl1cjbF5N3mDMKMYJGy+9qi6UPdUU0rkz2aHOJOLt7kyEA2cNgTwuuNXzy7DId5cDckzWYlFMajjw+reau/GeWa0HDAVGt7n/+OEwwDd2+mGVgzUoCkS/Kccs97fQwhxjbeIRfvNBpxUbjsCfWr4zL8AunZuAtnqridZdp8Vo7aIz+ktHEjQMiRI9dKbT57Co6JAD3o3qWhAs1Hh469udRjfAcaZCfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4610.namprd11.prod.outlook.com (2603:10b6:5:2ab::19)
 by SN7PR11MB8043.namprd11.prod.outlook.com (2603:10b6:806:2ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 12:58:36 +0000
Received: from DM6PR11MB4610.namprd11.prod.outlook.com
 ([fe80::c24a:5ab8:133d:cb04]) by DM6PR11MB4610.namprd11.prod.outlook.com
 ([fe80::c24a:5ab8:133d:cb04%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 12:58:36 +0000
From: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Wegrzyn, Stefan" <stefan.wegrzyn@intel.com>,
	"Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>, "Sokolowski, Jan"
	<jan.sokolowski@intel.com>
Subject: RE: [PATCH iwl-next v7 2/7] ixgbe: Add support for E610 device
 capabilities detection
Thread-Topic: [PATCH iwl-next v7 2/7] ixgbe: Add support for E610 device
 capabilities detection
Thread-Index: AQHasEWmkaaiF3iKZkCU62fuw65uobGxczAAgASWN7A=
Date: Mon, 3 Jun 2024 12:58:36 +0000
Message-ID: <DM6PR11MB46106D8FD747CC3D975524C1F3FF2@DM6PR11MB4610.namprd11.prod.outlook.com>
References: <20240527151023.3634-1-piotr.kwapulinski@intel.com>
 <20240527151023.3634-3-piotr.kwapulinski@intel.com>
 <20240531145024.GI123401@kernel.org>
In-Reply-To: <20240531145024.GI123401@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4610:EE_|SN7PR11MB8043:EE_
x-ms-office365-filtering-correlation-id: 3e247eb8-911a-41d6-03af-08dc83cce19d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?R4kf6/dJ+EeXlrQhJYk7gnN5bJmJE8OKv/KjFm2MzndGUPnhiJm8Up0dsyW+?=
 =?us-ascii?Q?fum7SlJT0Q/dqbQhjTJ3Q1EFPtvq0gQ+iBFlm+qSPbS4AytjBVsRFopHZvDa?=
 =?us-ascii?Q?Nn7a2mXprodYOy/1GAzt2wUVfHWWqbosxTpJ6IDVQlXa+apDBiFW2lZiXs7e?=
 =?us-ascii?Q?2YW0DiFWQuAQ2cXAO/QIUPf4e48h5dXK/LW18LTa/de+2aNctEvdF7LaEV0M?=
 =?us-ascii?Q?MTwsoB4ndRqL5Etg6JUa3QpoPGFP7cN2KCWPKy8p0rLKeu/smUukVqoJgbOO?=
 =?us-ascii?Q?bNL2Rc3yGXtupf8C3dvW2IkovexmoBIteXrO0uEpVSCvmAlyVuac2cg1ex2+?=
 =?us-ascii?Q?OHrJDZcdb8He6JS7S758y7FrhGmS05qZATVYRXUBO8DouMNYeIKfhddWrWFw?=
 =?us-ascii?Q?3UJFv4aW+jlZcIL09TDxKX77JfDBsjo1IoVyGQCmP1BmINoIn94QOMEkAFLu?=
 =?us-ascii?Q?43ebe8Prnzf4YnGZ1Y4HYcXFgLrnhSge1j4hnogma2C7TohS0z2jHNUAUkxF?=
 =?us-ascii?Q?jYBTZzFlNZd1yQ4DvGtP/r0DjmZAMndXpAs2vS3cC7oStFN+KE0hsd6LsrPr?=
 =?us-ascii?Q?ialTj6kgvabe2Gz1IlVOGQXDzI0pi+EwshxyFpphHynLB5cyOXJoA1ebamOg?=
 =?us-ascii?Q?OC9zeOv5qFh304G4RfpjEXznSDlmbmEGZ5VaahJnTi4hs5u8iWryoFAoTEii?=
 =?us-ascii?Q?TahxqxXFIMARoalgboSg+vDYHMt1G6obY0EV8n76vsxpGipFRBryISeO4AFk?=
 =?us-ascii?Q?4Ti9uoXvkFDGjOWRI5arSOgflbqwQnup7u/RgQcI1e8AmqwI757cHGp8wDDw?=
 =?us-ascii?Q?QpRGU66kB61JWBcba7WAD7eEOnWxVj2+DxC/ADcoFgMOjTq54TwNSsjSO7dr?=
 =?us-ascii?Q?m5Wajq1XvhQcpbaCsZ6ATNqUvyBdMJRKTYGjyldFXi/n1AoPqWvmJ8E60101?=
 =?us-ascii?Q?g1ExVD6sP8hhmrg9NMvgT3T35H79bavijvCQlyB/vwq8CGGigilBXw1IcapT?=
 =?us-ascii?Q?EKofwIKzZL+PyHQULMzR4smpru+wwcF3RGJr70Xu0GeOzuUOrIetBB22aROJ?=
 =?us-ascii?Q?Uf7sSq/5WLEXt+9MddcY5zMyJdP74mzXh27VT8khfnS7hBrUPqGstJhy6fY/?=
 =?us-ascii?Q?ZUHhBoER4ilDS4fpnNKLG6QBq8qZhpp9DUVNRChT0shIqpjz4wvgitHHKtvD?=
 =?us-ascii?Q?E3/gqE/WpCpnvcw8T/UbpNKwCSB8RntKTOAELnMWgGKtoclzFf0THSQzk1St?=
 =?us-ascii?Q?dUM9lrV1Wsuw5N1gSflKbYctlt82ztjT/idO7jEfTiuX1/nuQ8Wy//C1yiLe?=
 =?us-ascii?Q?Nid9vArP1UUOwGcsxiFCzOen4qxRXD8Fx6umyvqX6OOEMg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4610.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SL9QOW35zQL9XWUfISPl0xQYbbLFmd939jLtxKKASbOrxlsRsVTA5n1apNRf?=
 =?us-ascii?Q?nEXWcZPUZPqHmYWC0Skxmce3PmjjUg0EX5uud2v98t0YH59vqve82uBTKbrY?=
 =?us-ascii?Q?S+RccAEJKjxHOZdekZcjjj/gFfmGr6m0+0BH/En7o9Kx8uucVMuw6EH20LQ4?=
 =?us-ascii?Q?Aejpz8yxj1iwM2mcxdXLZak4ORqM3UJJ/tR4Xj3SSrNn8SNL6HhxBiqc35ys?=
 =?us-ascii?Q?S/7+giDsuA5hZcjliBRhNiiKxTIGfb59bhiytqouNgQN0gQSFF/j/ILoERpc?=
 =?us-ascii?Q?UT4phDamA4NT1SRjcGJHCUZJD7naa8LJzYD5/OuD0VQWSX2VZ56J9Cgz204M?=
 =?us-ascii?Q?uSHk5xPY4f4ZrqvCr/9Efsj9rKtmOLCybaFSYNtxtMhEkcCDgMKWmWXbXt/l?=
 =?us-ascii?Q?nBLE9pHPHWqBsVLSxQCORuJ/C3OV3LTqC7wz6GQ2jaB1VDw5KVMrigIOPBZ5?=
 =?us-ascii?Q?MLfFYtd/sMFW2hbmewVQ76TMhR+kexxlF+JVk0zb7zrTuVgMAB87HK1tXjq8?=
 =?us-ascii?Q?74qe4hkg5t3RODJaV5S3bs18pFhVLl6TDK+Dpwm2aB1HhT7LADOMoJU+Tg7C?=
 =?us-ascii?Q?1jHBHoz8q3de+3bHLReG2IShPDeShf7LtIaD1jcUNOOKFbDRzfhJ2q/HF3to?=
 =?us-ascii?Q?GweikkKuR7/A2Ktdd6u/80ZhbSRSJOpz2vx1Aw0/9U7r9tdIkiUOB83cODcU?=
 =?us-ascii?Q?eWL/EnrIqZwn6rdeRxp/SKAcuZyz9AGLQ1p0Rvk5ecmF0dPGUuji+EMp3yEe?=
 =?us-ascii?Q?eTyUwrJCHurQGKdV4LvTdw/ybMQUWx9AyoeONEn9PSTiS8OCmTxW6l1BMFXX?=
 =?us-ascii?Q?Sgq16Yr4TCxg7uigyRDZl6a5fsqxiXPiXuIq3RemgLly6VGxNhbLU2L/J8Ez?=
 =?us-ascii?Q?7/7ZG6wToCnKRk4+2qUgUA8ON/ds7mxpJ0PSSYyxfLSC9BSAyXFYQXnEEIaz?=
 =?us-ascii?Q?U3sp7xHkG8OSlp/+FMbP5TnXgW49OutjoT9W6SpmFkWOkQxz4nSCDya3uIRS?=
 =?us-ascii?Q?wBQzgrfoVIPuKa7/qbItDtBU1Wf32MSxFN7XtpBPetYpnOkaJoPe3MBKWw0y?=
 =?us-ascii?Q?+OrdHD8/tnrf7O2f9V3klVfmJSP9MmAlyExLcvytGGVjT7vCjIRGcG99O7GX?=
 =?us-ascii?Q?JXR0UR63SpCoCilnCWjQ0D0xBHBjT6nRLGcthRoBji78bFfs2t+LhA4h0XjG?=
 =?us-ascii?Q?QyfUP19ThLX9f7qk4THVwgGyf43NP59VuP1CefzxuIsKQmCMii7fJcsiqgLU?=
 =?us-ascii?Q?UE0zGrcMwenk17CUGDZ4DM0we+36zPHIs9X7GBd0Bd8Do6rUJM4l8BPxsHY3?=
 =?us-ascii?Q?SWsOJR4hezXejIDCtgl6dL9wAwLFZ5SJDtq/xFUakuCLYVVr5qy7LQOgRC4J?=
 =?us-ascii?Q?yPL43IB8n5gEPNt6NOBFB6iQ8aOZO/Cdd8WSH3eGlXDdj3q299jqh/vVYmi2?=
 =?us-ascii?Q?L7tjNPYPFREea6yNt7lyl+NVc2f9JvcZ6OLloXEJgVcv7gBsahUauWwvhX1c?=
 =?us-ascii?Q?FXnVDgiaif5ecvnhpo1+ySEl4aIyUUnFRSdFyerIl1cURxop6l4vNgLOvmC+?=
 =?us-ascii?Q?9TQPN/pDtUagDeesnLT6+9a0QLsgXVKPyHIsSETB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4610.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e247eb8-911a-41d6-03af-08dc83cce19d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 12:58:36.1304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcKy7MJJHPHJ7qlBETbtROi557hcldXN6G+O8jumobJyEA9/suCmnboUM8Wih+J3km48hL7BcUTmiynsX287F4A1lgbMYW2VeGa9xYZ8KyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8043
X-OriginatorOrg: intel.com

>-----Original Message-----
>From: Simon Horman <horms@kernel.org>=20
>Sent: Friday, May 31, 2024 4:50 PM
>To: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
>Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Keller, Jaco=
b E <jacob.e.keller@intel.com>; Wegrzyn, Stefan <stefan.wegrzyn@intel.com>;=
 Jagielski, Jedrzej <jedrzej.jagielski@intel.com>; Sokolowski, Jan <jan.sok=
olowski@intel.com>
>Subject: Re: [PATCH iwl-next v7 2/7] ixgbe: Add support for E610 device ca=
pabilities detection
>
>On Mon, May 27, 2024 at 05:10:18PM +0200, Piotr Kwapulinski wrote:
>> Add low level support for E610 device capabilities detection. The=20
>> capabilities are discovered via the Admin Command Interface. Discover=20
>> the following capabilities:
>> - function caps: vmdq, dcb, rss, rx/tx qs, msix, nvm, orom, reset
>> - device caps: vsi, fdir, 1588
>> - phy caps
>>=20
>> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
>> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
>> Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>> Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
>> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
>> ---
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 517=20
>> ++++++++++++++++++  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h | =20
>> 11 +
>>  2 files changed, 528 insertions(+)
>>=20
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c=20
>> b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
>
>...
>
>> +/**
>> + * ixgbe_discover_dev_caps - Read and extract device capabilities
>> + * @hw: pointer to the hardware structure
>> + * @dev_caps: pointer to device capabilities structure
>> + *
>> + * Read the device capabilities and extract them into the dev_caps=20
>> +structure
>> + * for later use.
>> + *
>> + * Return: the exit code of the operation.
>> + */
>> +int ixgbe_discover_dev_caps(struct ixgbe_hw *hw,
>> +			    struct ixgbe_hw_dev_caps *dev_caps) {
>> +	u8 *cbuf __free(kfree);
>> +	u32 cap_count;
>> +	int err;
>> +
>> +	cbuf =3D kzalloc(IXGBE_ACI_MAX_BUFFER_SIZE, GFP_KERNEL);
>> +	if (!cbuf)
>> +		return -ENOMEM;
>> +	/* Although the driver doesn't know the number of capabilities the
>> +	 * device will return, we can simply send a 4KB buffer, the maximum
>> +	 * possible size that firmware can return.
>> +	 */
>> +	cap_count =3D IXGBE_ACI_MAX_BUFFER_SIZE /
>> +		    sizeof(struct ixgbe_aci_cmd_list_caps_elem);
>> +
>> +	err =3D ixgbe_aci_list_caps(hw, cbuf, IXGBE_ACI_MAX_BUFFER_SIZE,
>> +				  &cap_count,
>> +				  ixgbe_aci_opc_list_dev_caps);
>> +	if (!err)
>> +		ixgbe_parse_dev_caps(hw, dev_caps, cbuf, cap_count);
>> +
>> +	return err;
>
>Hi Piotr, all,
>
>A minor nit from my side.
>
>It would be more idiomatic to write this such that the main flow of execut=
ion is the non-error path, while errors are handled by conditions. In this =
case, something like this (completely untested!):
>
>	err =3D ixgbe_aci_list_caps(hw, cbuf, IXGBE_ACI_MAX_BUFFER_SIZE,
>				  &cap_count,
>				  ixgbe_aci_opc_list_dev_caps);
>	if (err)
>		return err;
>
>	ixgbe_parse_dev_caps(hw, dev_caps, cbuf, cap_count);
>
>	return 0;
>
>Likewise in ixgbe_discover_func_caps()
Hello Simon
Will do
Thank you for feedback

>
>> +}
>> +
>> +/**
>> + * ixgbe_discover_func_caps - Read and extract function capabilities
>> + * @hw: pointer to the hardware structure
>> + * @func_caps: pointer to function capabilities structure
>> + *
>> + * Read the function capabilities and extract them into the func_caps=20
>> +structure
>> + * for later use.
>> + *
>> + * Return: the exit code of the operation.
>> + */
>> +int ixgbe_discover_func_caps(struct ixgbe_hw *hw,
>> +			     struct ixgbe_hw_func_caps *func_caps) {
>> +	u8 *cbuf __free(kfree);
>> +	u32 cap_count;
>> +	int err;
>> +
>> +	cbuf =3D kzalloc(IXGBE_ACI_MAX_BUFFER_SIZE, GFP_KERNEL);
>> +	if (!cbuf)
>> +		return -ENOMEM;
>> +
>> +	/* Although the driver doesn't know the number of capabilities the
>> +	 * device will return, we can simply send a 4KB buffer, the maximum
>> +	 * possible size that firmware can return.
>> +	 */
>> +	cap_count =3D IXGBE_ACI_MAX_BUFFER_SIZE /
>> +		    sizeof(struct ixgbe_aci_cmd_list_caps_elem);
>> +
>> +	err =3D ixgbe_aci_list_caps(hw, cbuf, IXGBE_ACI_MAX_BUFFER_SIZE,
>> +				  &cap_count,
>> +				  ixgbe_aci_opc_list_func_caps);
>> +	if (!err)
>> +		ixgbe_parse_func_caps(hw, func_caps, cbuf, cap_count);
>> +
>> +	return err;
>> +}
>

