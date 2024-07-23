Return-Path: <netdev+bounces-112572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBFC939FBD
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54EF2836B4
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 11:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB1114F9F7;
	Tue, 23 Jul 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPo3IZeR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF8414F9E1
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721733862; cv=fail; b=NnR9nUTD1D9qLEY+dceRwCfNQNUUSo8PyQBZtdPX/d+OiaqQ6dhq8lWyMX+g8bitEQKTWH1YjbfMTuVHdUe5Jdt/Ypz9MJgenjvYhVG8b98ofCWFa8MMDNEop8FlVQJtI9/Rkx6iVs/d7U7aK+bYUBzwmeBuqw4DwDTrkkzjdts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721733862; c=relaxed/simple;
	bh=qJ/GJr/caUiFaXB8LhoGh2YchMHZSWvH5+ljAV67K9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hr5uHKXudCXcHBh7TUCdUGBLYjlG27nqlQS5WrJypui03dhbjB90nv/s6znaqE36TK0uiV4Lxz66TQ4QQUl9H1kZmbcalePt4L+38pe10Bd1p6xBjvaxZVOC+Ly0LtF2YnauHc6Rh6o8X1p6Xle9hsTvHaITXcZz7iSkCPqauQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPo3IZeR; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721733861; x=1753269861;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qJ/GJr/caUiFaXB8LhoGh2YchMHZSWvH5+ljAV67K9w=;
  b=RPo3IZeRez0TfhgIdoaUZwI42OCXD59W17RSSSm7fCOn70E8YsY5x+oY
   BiIn3VUAcQLKi8s9KmCgGIrhTxF7LlFu6tEZiOaQwKrnVxjAgFfQJHZi+
   dlwE33AAYrj3RNpDxve7Nvfal7/XeMNGHf0WYPqMDDqMAonhCXKuaTnTK
   e1vfR+0+nGUaFAPZP6ta3WZ8Ro3WtEyjQakDlG1Ht5YJ7r31i1svqZAHG
   CG13Df8OUs1aB0mMzu5+U4WwwotmeQggV1WX3bvpCE29zj8PhViVg3405
   y6hiq9tokbqliLhvu83BmtMndJMHZ+ScVpDtC9Zk409Kng+KX1DwlPh0X
   w==;
X-CSE-ConnectionGUID: LnfYIZEoQJuAjpazAqjhUw==
X-CSE-MsgGUID: ez7vIz6iReOYhPlki+xAfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="36792734"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="36792734"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 04:24:21 -0700
X-CSE-ConnectionGUID: /8+vEvmcR9ePpeK0E0jMUg==
X-CSE-MsgGUID: y4ghkNHmRJWMRp/uQMbgLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="56506488"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 04:24:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 04:24:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 04:24:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 04:24:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 04:24:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPgrlOgyKPPQqZeNAGVpe8STx1hRT7R0vKiArk2YqLwe0MmuDi/nCfZPMw3XDJTodC2wIdJTqPRV+CKLuuxErUKbnJsj0hmMz859SQDhm2SZWy6FNQYZ2f1uDRh/h9Rz7+45zKH3VmZRrcbsrRTRf9kjRm0lShoUxnHCK6JlcW1FGFDaGgy1BT22kOXG+d/Dgq3bNfK7pqWSH0jtiEijdBaB33yQoXAUUdS0U0dNNpy60/6dYHQMCCzRE+bW7pm6YMuaG2d683fb/wcFJedhXXzcDtqKFvmJNFTcy/CsAmmNoH0jszVdquRHplk3ax91kYo/XJNmHfj36e/Z2CaM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEg9xKjQDmLks+69RBwlNEWe6LWns6blWxX7cPw5I+4=;
 b=kBMa2hPD9sOCn7G9AY5ZlNmL8mkttwqFdUEyfgDonWljkAPwlwMXSp7Qja0ua5+DmJdMaXwWKUMqbV+5wK8s4Vg9/goWzQq0JgD8DYZAJuXifr/EFLnXSa0sv/BecrbeuYIwTbYupY4/lkBoI1l+zS7c80dQ03CSr0RpvBz4NLw8iWQcwpAruP4CGXXaLKbZGTl7aVQ4eBRNzBElI+suVpejsrsVoFk+pxVeVQlp+amu30tAbAlc2pdcz/3yUxtJRUQwc1ZH1P3m8BLtAfgsVXemCU76yCGp3GovEUY0nsg/HpycZiKpc74nTCqRSalGzJaHdwvXik3JOsfYzUv9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 23 Jul
 2024 11:24:09 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%5]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 11:24:09 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "shayd@nvidia.com" <shayd@nvidia.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "jiri@nvidia.com" <jiri@nvidia.com>,
	"kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>,
	"Kubiak, Michal" <michal.kubiak@intel.com>, "pio.raczynski@gmail.com"
	<pio.raczynski@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Drewek, Wojciech" <wojciech.drewek@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-next v5 11/15] ice: check if SF is ready
 in ethtool ops
Thread-Topic: [Intel-wired-lan] [iwl-next v5 11/15] ice: check if SF is ready
 in ethtool ops
Thread-Index: AQHauAO8dB0lxYRjP0OiKIfpX2Jd0rIEdZKA
Date: Tue, 23 Jul 2024 11:24:09 +0000
Message-ID: <SJ0PR11MB5865D90FD8F5787FD825BB028FA92@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20240606112503.1939759-1-michal.swiatkowski@linux.intel.com>
 <20240606112503.1939759-12-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240606112503.1939759-12-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|DS0PR11MB7802:EE_
x-ms-office365-filtering-correlation-id: 42f6470c-2e0b-4861-cf57-08dcab09f8df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?PVaQ54GpPnd9hniMvhwYNpB5AXUbC6fvZk8vrSjZoQ29NFqcIytUVEHXJSLB?=
 =?us-ascii?Q?JFrQJDfKhYbN4xuJtUkS5UYx3ZUTw/+MAUs5c16luZlno5OQ1xAOk0DzlVda?=
 =?us-ascii?Q?zyXzvjWoqF9g2t5TnZKhhXk2SK3YqEzyzCaFQy4Kcl2Rlaec4rdR4o0phAYU?=
 =?us-ascii?Q?TTjM24/Y+IGh6E9anpN+LCcl32G19SwlrDXwyi8nTCYiF6LhnvkLzPnp12Er?=
 =?us-ascii?Q?7CopE+wM0P15OHo4q5FYHNTQk4k2h2RBa5k7Qz5afNjkjdxcz468osi6s+Vy?=
 =?us-ascii?Q?T/msvgwah6P5kmKBAKLNPG7OFUtwUv1J8svGafDPOANjC3ne+hFVmxR48Y2K?=
 =?us-ascii?Q?NErLPh+FKNbFfW5GifcG/WB+DmJtuCh9dMHjdSYDa8MvEtQ8QJrp70VRcKiv?=
 =?us-ascii?Q?2cbYwMzvF/LiJneWSLldSCQ8rxPTGqXUYdMXicsU0UVtXRNmQbPQsAlHFY3v?=
 =?us-ascii?Q?yx/PvBVWWFjubW5kxDbNnKO87qa1CsFhMcsPmecmWrum54p3jqjSM2ECTnFB?=
 =?us-ascii?Q?W9GVgVG4VafTfq23to+z70Ec+Pyd1FeHrI/tqN8J34lA+btlRoBEwLArNasd?=
 =?us-ascii?Q?CAp0xhqh0AAefdhX2kAgwQNr9LSxN7kXSwm5oRM5R+zY765aQnql2a4hvPGz?=
 =?us-ascii?Q?cY5K1rzWbWrvSgXdK1/ZWiAIcLR7sLLDiKM8xRvMFEPDsO97e/N0JHyWc4/c?=
 =?us-ascii?Q?GnbjPImn5Yj0cgyWpsySMKujrQtrzM0TYUftjUlQXgnr6dcu/y/zLHJO14hY?=
 =?us-ascii?Q?1LZFpTGpmagkIuzgFyzcChcaZ1ZDt0/8T313HullzbDZAxZGjtun+dq5z0Sx?=
 =?us-ascii?Q?qptSYBKiN6hiRqvErs3HsjJ8YIqHfJbmdfu4JPX47AdaIFGfaP8NA5vZ3/pl?=
 =?us-ascii?Q?n4/fasZshyMVUnNLOWHC6V9YcLrY4pfGau/1TDBIOgxDt9eLuLv4rl+Jdm+G?=
 =?us-ascii?Q?YWAkWjcZg3nXLVjcAyjHntt+3j9h+6A3yz0r5VOtgt58+fp4JMjRwHi1vftU?=
 =?us-ascii?Q?T66tuaDEYNEu0JTNwF1cm9BIpCpTyOrX+dGO0+/V2IoQA9NkBGwW/A4vKoX+?=
 =?us-ascii?Q?sfKDGxkiiWP2ORUi59+xFMaQvdLRiGhyTcmyYbl6wLqWbFc1/0WjnPbaylBL?=
 =?us-ascii?Q?+Hx2gZjrib6obCMwpLvA+2wER/FdO8xAo2n6vvrDnwTfsDlXYxW24mgqOyGm?=
 =?us-ascii?Q?hR3HsH+NkuZFj9L/TpwGnqsxItBiU5/kKejICqlQ6UHXzAz/ccb4IbfE5OoG?=
 =?us-ascii?Q?0eC5+OsP/yWoHb+cCqyhswNRY/nfsiyd4wW9UXxT5rDsQ0AnUgZSTqpSiZKd?=
 =?us-ascii?Q?EgOXDcKYySjQTsu3D5pgJ1jkaL9qsses77KY8lIvw4EXsmX13AORN3A6Q3h3?=
 =?us-ascii?Q?GCRmvDSnltCSvoNMnTY73dHZxdppwesSjZK+VU90eXRiX84B1A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/7snGH0JTjisViLFR47P5jmsbhLrdayXx4KcSTHUja7LKPtEG1k35KWDeLTG?=
 =?us-ascii?Q?AaPJK9A+woVagWubgyC6l3SBiSBdXHg2c3mO+wFc0rvEu6hqk2OCyhpclAu+?=
 =?us-ascii?Q?exHQZ4Hzd6B6BUK4aoETW+mttCcH5mnea+hwHSpvOQ3nx+Od/X5cqL2c0mb9?=
 =?us-ascii?Q?Uc2UVN8cYR+UB2MT6IJ8UNTO3BITDAZrp60IubDLOqsWsPKMoAu2zRLwMnG/?=
 =?us-ascii?Q?Dz5ZCbjFw7EEEXEDBhvqI3gopbzkzj8mDr7rWAymSPqi9KxD0L8LDdFcEwGE?=
 =?us-ascii?Q?z3IXC9YmTazMkaSc52E5PlVUVkPIf0FsCoGQHjTN3YblF6UXotcpaQHsxujx?=
 =?us-ascii?Q?mZiloUfx4GWUg47X8tEq+W0WByuMw6HY0vGAJ7G0in5FtX6sgxunWJgY7KSK?=
 =?us-ascii?Q?ccKWth05YEDimNV8zzNtivRe0lJu4sAdQvJrsaYtRq/mUmIOVAYxE+kad8b6?=
 =?us-ascii?Q?ZL7bsDYJknHDMkcp7Yr9VDe9FAH6bU0K6GBtmEr4PWNucHT43XXrUQK/RjUq?=
 =?us-ascii?Q?d0ZWfqoLqPOQjEdF5W/M6kopj/pfr7KX8ulGfy/ThxOuwBWdV13fgYthpFzl?=
 =?us-ascii?Q?WT2IKPfWqNj7vh+xOTcVZUkLFBso0avdUNZ3Wg+xn7hMZflGnKz3LJeOzhe8?=
 =?us-ascii?Q?FHg6EZamVVk/Y/Rnx5VW04aahrltzIPpopaAqkAiTuqHqDutNnpUr7+V6IOS?=
 =?us-ascii?Q?tGh2coiuR/TQcFhgULQUvMCUe7y9Iz+YxesfLniFVnLcyGhsQgLEaTvAUaZq?=
 =?us-ascii?Q?8LCaa4dQrIcWidDz+Mvtw/eB2+G73qylmiSctPgtQSjf6w5VwAAEE6BFyCmD?=
 =?us-ascii?Q?cblie1tLnjoJfau62amYqJRi8sy7Su9Xr9W/gyTTWHpfTZAd//eZAF+06Syb?=
 =?us-ascii?Q?FruL7Lm2GSPzbnAi3pTebf15upEkbgvBSAVHu/lmXH2wEtRB7z5Idlh3sg1b?=
 =?us-ascii?Q?gwqvI974BMdQjebQM8mLduNcNJOSaPR9+Orcc/kW+WbFZpCrwCgb5zaFQSeB?=
 =?us-ascii?Q?bcKoQ/WCVcAWDZVMlQfWCPaMIzh7hogWdCFImKglx9BLezMHh7sNtRCnOcIk?=
 =?us-ascii?Q?sK2RaDyxl+Z2akM00yxQ7W85zGBtSWbr9D1G8GkF+bdvpWDGmYTVv5KJYgU4?=
 =?us-ascii?Q?ZQNTc95QvqPIZhfmjTjQ32HTqUrrWujrY/Ki3KXBxPsMpYUulGijunERNlfx?=
 =?us-ascii?Q?tFsU+/gOABBWX+jtOqaqMWAmf7bLkpbbHN+Tj4WubldIUz0ok7elF8jxVOyb?=
 =?us-ascii?Q?fuh3LrhQQjYmG3Ct1971NE45zGtRWBK1NiOC8LIbb66pgqJMvIDH7TM9Nx3W?=
 =?us-ascii?Q?A6/GaazX29PA+9dsdr/7GQYSD7/yMoZ2rHHmpitOH8yciJeTv7Dt/FMnK2+Q?=
 =?us-ascii?Q?X9nJa84GmiT0t7WMncnopK67d1+ljdi96RBFTUTNiKr/bBC9mTFxWmZNEt6t?=
 =?us-ascii?Q?UClhcB23uQ4A4KeFUSdjysyL99vJCr3394tO5In/GM/kMAQbFwjtBMkm0bCN?=
 =?us-ascii?Q?yx9b9IiP64qqGiouN8EOkTrZvn/lnNkYvF4qW+Wf8jak4jAWMBJrLiF6ZBHH?=
 =?us-ascii?Q?ZqNhgbXt84fs2jOxBZIMlkTvRirD6Ae33BkuFMWh2I4nJfWCHfIL6yhAoYx9?=
 =?us-ascii?Q?DQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f6470c-2e0b-4861-cf57-08dcab09f8df
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 11:24:09.7743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LUmZ6DrHFH4y97qwwI/G5V+2Ooi9XiypHfjpuBTBnLb7s70kyedLX0WHabJILa0PNYnuOPHr2+5YYUulxM10GVd+ONuyj27Lrg52i5sJMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal
> Swiatkowski
> Sent: Thursday, June 6, 2024 1:25 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: shayd@nvidia.com; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>;
> horms@kernel.org; Samudrala, Sridhar <sridhar.samudrala@intel.com>;
> Polchlopek, Mateusz <mateusz.polchlopek@intel.com>; netdev@vger.kernel.or=
g;
> jiri@nvidia.com; kalesh-anakkur.purayil@broadcom.com; Kubiak, Michal
> <michal.kubiak@intel.com>; pio.raczynski@gmail.com; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com=
>;
> Drewek, Wojciech <wojciech.drewek@intel.com>
> Subject: [Intel-wired-lan] [iwl-next v5 11/15] ice: check if SF is ready =
in ethtool
> ops
>=20
> Now there is another type of port representor. Correct checking if parent=
 device
> is ready to reflect also new PR type.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c |  7 +++----
>  drivers/net/ethernet/intel/ice/ice_repr.c    | 12 ++++++++++++
>  drivers/net/ethernet/intel/ice/ice_repr.h    |  1 +
>  3 files changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 2d307e7d9863..ec93807dc327 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -4053,7 +4053,7 @@ ice_repr_get_drvinfo(struct net_device *netdev,  {


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



