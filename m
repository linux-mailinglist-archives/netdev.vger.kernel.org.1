Return-Path: <netdev+bounces-107193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB1F91A42E
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59BB284A40
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 10:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9841F13D281;
	Thu, 27 Jun 2024 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TURJr15G"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B942513C80E
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484968; cv=fail; b=rdule4npRCse7jDte4erRHJn0UqX2yZuUbQ1d3JOkpSbnRriZv8doARRy1hu981f444N0q4GDb9VMm1KgeNDaQOOIQKj/BRBqNzmOm21F8YMbXnnPtzW39Uqghn6auje01zT3bmjqOER3xVYwsQkLdNfWm+KHBVhI4xjv2nJEcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484968; c=relaxed/simple;
	bh=gNL0oWC9Td3VbxAW9TkVpzYnFiFxuFEa0GuAVpmjtRA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gp7mgfwBqq0vesmxlxhh7le3Hxkrv9Nx+7Moje6vF5dIgnqGofApig01Am0jd8WYug4xFX5fBiH+u2u46CQFr27RB0zHKWDWL3C53HFqX1ItaCd2KKg1uyXMH9huP+I062JTN7YwOmhnCPyZe0JOfewqg2qYCC8oP1/o/E7FzFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TURJr15G; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719484967; x=1751020967;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gNL0oWC9Td3VbxAW9TkVpzYnFiFxuFEa0GuAVpmjtRA=;
  b=TURJr15GBwxpmhsXGyujA1YAmluiA66C5im2p1pGRAcgsbWvxhGNJwCD
   qTY7eaDbvV7QtX4td+F42UPyuE5KCtUpqxpfoe09Wde2cATs4+G8F+ZdU
   ZT56KqDX24xWhSS9PYj/xM984fJtC8A2q3005dmHHayLx55WXolxJ+/35
   C4Yw3MgW6szUwn/5AfIXdVkRSA38L6uleEUJUw3xfkdEhwcyvBjZs7wA0
   mA4Y6q4I3YhQzybQmeJMo4HHETLN2/DxgNZlBc/naYye55noU6awsXFFQ
   lKIAdiZMeVep5SQmpANOA/S9ckj97HxQ5V0A9USsOq1b+hrp58EKGD9Ej
   A==;
X-CSE-ConnectionGUID: wMADm+VdS7+RURLjXXPnFQ==
X-CSE-MsgGUID: wlxWayoCTmWcEQAirdstCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="19490426"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="19490426"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 03:42:46 -0700
X-CSE-ConnectionGUID: zU0qIjYmQkSFdfo2/tAiXw==
X-CSE-MsgGUID: eatSRaogQkyfw3KQgrKe6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="75089858"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 03:42:46 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 03:42:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 03:42:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 03:42:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Df3pJTNxt4e9stf7/ALXnX40B7QcXTAyaQlYLkmfB5isMmBJNmbObWXum6VX8XaJMfYZgM00/XMOMKxdlzkLPgL1q7yN0G5cH3EeOd4bfE7gt2ONLZ3k/n0tum/A4b8rvcztsdjaujS0Y7TI350fwoLeEgZipPZhilVbAm0pz2y7SPw1eYq841g3NiJau7F5iHCusEMLKdp7rfRE4SxC6C16ztUtIWhBtIEFz75/PDcWlFzFdd1s11nnlRWhPJWZ00Z85dn1N1Ak/gxEp2lYiR0yFyVEh1H6AVlLAWo1Qiwo4Ai/Q9TK1KxByNHSWslOqmonB2w06rN6siAVipcphA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNL0oWC9Td3VbxAW9TkVpzYnFiFxuFEa0GuAVpmjtRA=;
 b=LdV8U75eBBVR8xQTfRYA5T45/t4QZ/eT4LFq9uuGxUCrDutrKQyTyJFA7PLvJdc0sJ9B6sLC54BoDqTtNTo+tGhTAD6qKeabrpA5OLzl5e5rQDmq63ddAuDHMYQu56qWBvAkSbnHEslOrFfI/5Tp9mW8EhSaXasaFZ6HwttfOstDVD5iv2HJ6eefCVljp+Qm1TPX4+SXj5taMkRb4HJEPk4Bq/YYi74Nm+8Yl+AoTHpNzIxqSOMMVGgmsll/lkUeO8V3m44Vc0HyVng1Km4vROs6zNz8kUZFmMvAOYJ3YmVqcv+am9Up53R/sooSkKp4IoEG9qohEW/TbSLp0aMXMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5800.namprd11.prod.outlook.com (2603:10b6:303:186::21)
 by PH7PR11MB6007.namprd11.prod.outlook.com (2603:10b6:510:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 10:42:42 +0000
Received: from MW4PR11MB5800.namprd11.prod.outlook.com
 ([fe80::740d:92a5:790b:442a]) by MW4PR11MB5800.namprd11.prod.outlook.com
 ([fe80::740d:92a5:790b:442a%7]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 10:42:42 +0000
From: "Kolacinski, Karol" <karol.kolacinski@intel.com>
To: "Nelson, Shannon" <shannon.nelson@amd.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Simon Horman <horms@kernel.org>, "Pucha,
 HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net 2/4] ice: Don't process extts if PTP is disabled
Thread-Topic: [PATCH net 2/4] ice: Don't process extts if PTP is disabled
Thread-Index: AQHaxyGQlTFU0nfPp0uToF2zwa6qfbHYxBEAgAKnq20=
Date: Thu, 27 Jun 2024 10:42:42 +0000
Message-ID: <MW4PR11MB58008AC6DBE08115F01DB9A886D72@MW4PR11MB5800.namprd11.prod.outlook.com>
References: <20240625170248.199162-1-anthony.l.nguyen@intel.com>
 <20240625170248.199162-3-anthony.l.nguyen@intel.com>
 <b120a258-87b8-42c3-9b5e-ef604f707d0c@amd.com>
In-Reply-To: <b120a258-87b8-42c3-9b5e-ef604f707d0c@amd.com>
Accept-Language: en-GB, pl-PL, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5800:EE_|PH7PR11MB6007:EE_
x-ms-office365-filtering-correlation-id: 1445a712-febb-4480-8ae3-08dc9695df70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?VzGuUOImr+GD9EIKJGKQDPa/QeqZT8BI5G3SMqZK+kHDBW9Y38Df83JbWN?=
 =?iso-8859-1?Q?K8dkx5UR+FRHt3PZvSbhf/OKW9OIXn0HZYjbj1ETPTVk2nOuKx6EDGAvpf?=
 =?iso-8859-1?Q?QxzGIWurcIyalNl8S1tMc5YX6dVoGVYEuezCVFm2b0hpw/ThfPss9hQlqR?=
 =?iso-8859-1?Q?K2IaGvAFCfjNl4EudUn1RcXbRxgD7jb4D3sntkJiraHTVgWL+XvdunfIUz?=
 =?iso-8859-1?Q?7aEFOYfjPvIKpiT87uvErYqbLbiVVj0kk3OnWvSjIsdXpEnZZ9TgHDD8Kh?=
 =?iso-8859-1?Q?0Zpg42MxlmhNSXOjYsQ+cj7cbw2T+sbY8M++CDnx4lC5hXeV6XSsX7P6Ot?=
 =?iso-8859-1?Q?++E1qkRJXZdKY2Yo9SBPrN0E8djjeQL59GoIZqHix9CiTprAAzTpUPzMZD?=
 =?iso-8859-1?Q?nBw8nbvwrK4LPqnH1U55XCFYbcFHqmBzq7N7m8scdI2Qx9TJ0bHEeWI7TD?=
 =?iso-8859-1?Q?g3Zyc0dn0Z4Jp5c1ZFHRLsqGht0992LGRHMF8CLND5mEvF5LWn6DFUkN8S?=
 =?iso-8859-1?Q?pdCb2CjJII33HixNbyCR4JWVyZnsugGTCq+R6vzg/nn2DNPZXs9b4LoU7P?=
 =?iso-8859-1?Q?PUZdHeL68N64npOOohIOVN4reYHKK/QuRUmGSm2w+gjqlcuxz7yLmZBqj9?=
 =?iso-8859-1?Q?cjybDEIkQxPIx7cvK0mO4FU0qvHeyGHvI9psRfVaeMxfCMSZOxXvYgwPD7?=
 =?iso-8859-1?Q?/6uQYicdlbPZR3B1jV6bvzl19XtSthBJTRU75fSPvFUBcwz0TBtOK/XXji?=
 =?iso-8859-1?Q?U53JfnbtPyw0HKgL6Kmn/vws3F2TcXa3Xeihig3VWvRB2rWUUn0KvOQKrq?=
 =?iso-8859-1?Q?UhARekKQooUzT4Jc+v1T6CTgykYl6+JvMxnRqdqsqjlgiAheb7ezgWDEAJ?=
 =?iso-8859-1?Q?B3iPE1OxG2uvo7qNzIpt3jlNrnVlEkNSSWsJ8GNWBsM0bDpOrpvaOGmTUq?=
 =?iso-8859-1?Q?Xcnivo31lVb+SdT+xQ07LfINfnsPhpnFHUmYEgYekyRc+mqEDAIoktugkl?=
 =?iso-8859-1?Q?AGEgxmTSrHw1brDzHsE83Nx1nrklBRxRLBbmYIc3O0+V3UCGLThoGekfAF?=
 =?iso-8859-1?Q?9L+IZ0ktWxiosl9qi/j+xhe/4wfu7I36ZUt+BRhrvcVXcBEoiE8qf7OV+/?=
 =?iso-8859-1?Q?B5xTArXBOHx9+8BJYZY4bHw3kw9kIZ+OEPLMQCVmgBZiyoayX2yKp6xRNH?=
 =?iso-8859-1?Q?1X2xMT1L9DTvULrMYoXQHp+hpaf8ELPPd58coA6qOxMhjy8gk1CelqAVVN?=
 =?iso-8859-1?Q?bw4aBgCr1rjFus55VpWb/1guOB/oG1Tj2RB9fl6o5ExK7MHefdxTdq6iVw?=
 =?iso-8859-1?Q?qu99TXrgT+ILMa687+GCgrjLC3StwglqvJQxe4wzdloF46jmr0EKETpkqp?=
 =?iso-8859-1?Q?bKuX1TxJkLF8fEYxSpNs+EjNBNX4I4LpgioXcmE85od2CFd1Jpr8vDMUrk?=
 =?iso-8859-1?Q?RzBHKtF0iX3XlWprKH9GB3I4ASvpicKzX5d71w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5800.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iycT6KaV0spWq8cxq5VXC9IbVA7kQbN9fe8GHcurSAaG2ncGr6IcJrZyKn?=
 =?iso-8859-1?Q?t4vqKAXsofCuKUQEz7mE8aFHRz/M7vKYBvqRm7iBhFrZ+hR/M/dPnx93rP?=
 =?iso-8859-1?Q?XSqJ049a5L6xAQu6oAlEZBKmnsr7Yg81afTneCZbZadUKhCyE0AOKM6ehJ?=
 =?iso-8859-1?Q?F/OVXD2yiPip6oqwzEmhOSqZuM3vzNypm/y0UcQYA/2uRu7/tjy02sTP2m?=
 =?iso-8859-1?Q?kH7kYc9rixui+0/RPGonct/jhrQywPSomoy8+g8llDyueatKMgLcxHXrU0?=
 =?iso-8859-1?Q?BDgCqi/pKtiZ37x6Ka1lZpliCyKgiXW8jMT8G+f+UP/YL+k9IGxKQHSodV?=
 =?iso-8859-1?Q?OUDnzJGVDbBY0Rk+B8DSInBMy52WaIcXgVn1eJrSWrT5+rc3p9hUHNEI74?=
 =?iso-8859-1?Q?Y1WUQ+lgBY+zk1b708NnYAwsPu6KVkG4O7x+/y6agAIJbidogESU4KVeB/?=
 =?iso-8859-1?Q?93vdLHGEeYA5+FkHqLp4hW2qQwv/RbPUzDu2LaaEz3iu/YdTeNzzBkluu3?=
 =?iso-8859-1?Q?sWcrV4p33rrbYwEywJBF0EYx6T6MutzgTljLeR6ocsCirOYdjDRS5geLeA?=
 =?iso-8859-1?Q?xx9ntBvRmxBdNFxxuWvhwNFzJIqepsf8tIqtKYyVWMBUZeOvJfKHhy91Ak?=
 =?iso-8859-1?Q?mi76Ya8lrO3IdqGJElFOR6OKi7Tx6LBCnzKpPuTT8raQ0eODeq6c7TZxE6?=
 =?iso-8859-1?Q?Iv+dFUFvRp3Y9SBWBxgqKYvq+vZlFHwVWo1Ct402FvPKpZDL31A3UkuNK5?=
 =?iso-8859-1?Q?dRx+sxZuTggdkUF3o6m/npnsf620L+U5VOg3YVSERtIlpvONF/YiNvKoSm?=
 =?iso-8859-1?Q?SOyR/bVhU0IeQLSlXj7QuSENK89yFc2fluGzXEwClF0bw3vdEBtMpcOV0k?=
 =?iso-8859-1?Q?KIHSdb8Mi+hdUISKru0tlPwIB+dX5qZuzfN7Ewu7UEKh+PRzyKWXPS66xt?=
 =?iso-8859-1?Q?J3CT9g+gCjr8SAb1K2hu7C1VYX1zoth2SexIyKOaTnooV+Fo6ZM3J8PPFc?=
 =?iso-8859-1?Q?aOHcbeQVU4SeVBYcGP/C9A9tn64RKrKGrt4zVfqTfxTXZjDE+YisQ6XED3?=
 =?iso-8859-1?Q?Bj8F4TNu6H2VFfF+isekD61eZSCAH/1sErkZc6PSlQcNucoYK+WYAc3nU1?=
 =?iso-8859-1?Q?+YXVAl0rwjAGkW8DtOU0cF2qmXS2ro9kxPnyHvnkFlhdW2VzOsuHTY/riH?=
 =?iso-8859-1?Q?h3zjINjnp1QS86omagYFeE3IgB8lprg0skjqzfqMOpC6x2EgXAFNIDr09L?=
 =?iso-8859-1?Q?CUHG4pifRmQrb2OASBCWNhdihSbyZGqRBcAJ/Y0io23wppN4NAi+Pu52QO?=
 =?iso-8859-1?Q?qApaCS8XBqhuQuAoe82TtIs9AZmRnH+yKytrBgWNeCALXw9TyR+UO5bnet?=
 =?iso-8859-1?Q?Y4E2O0avIf38ipTmrYl2Vvc2V3pRs5J6raEHiuZ/igP6de5X/G+JIlogmr?=
 =?iso-8859-1?Q?z7KhNEvu1rWqENkWuKv3PgczJ09E5TH6IOsaudLqtaamqezp4R/KNzKl2Q?=
 =?iso-8859-1?Q?n4/yOFxzHagClANStYKDn+2fZkYHyRXzQMqvHTuypuWmWn9vBwgWrUrxRp?=
 =?iso-8859-1?Q?C8PQM9cRLV2ICJCiPOSMe4hmkvheeNQd/kuM2Iyo7KLCMmdKuv6XjjzLoM?=
 =?iso-8859-1?Q?yiFhpsTMlOEoi6cGxQ3PPtAft6lUmAyAybjW3bGpRAzzli++b7t9qVsQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5800.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1445a712-febb-4480-8ae3-08dc9695df70
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 10:42:42.2318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QRO+sOFOziy5Xk6ldz5evX/G/bMr7AL/J0to6C60dx81DZwzYVSYpV66Ugf5YkNlVUQ/elN6U44pIr/7bJhJosxl3T818BxOjQIKQt9NxyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6007
X-OriginatorOrg: intel.com

 On 6/25/2024 7:57 PM, Nelson Shannon wrote:=0A=
> > From: Jacob Keller <jacob.e.keller@intel.com>=0A=
> >=0A=
> > The ice_ptp_extts_event() function can race with ice_ptp_release() and=
=0A=
> > result in a NULL pointer dereference which leads to a kernel panic.=0A=
> >=0A=
> > Panic occurs because the ice_ptp_extts_event() function calls=0A=
> > ptp_clock_event() with a NULL pointer. The ice driver has already=0A=
> > released the PTP clock by the time the interrupt for the next external=
=0A=
> > timestamp event occurs.=0A=
> >=0A=
> > To fix this, modify the ice_ptp_extts_event() function to check the=0A=
> > PTP state and bail early if PTP is not ready.=0A=
> >=0A=
> > Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins"=
)=0A=
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>=0A=
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>=0A=
> > Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>=0A=
> > Reviewed-by: Simon Horman <horms@kernel.org>=0A=
> > Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (=
A Contingent worker at Intel)=0A=
> > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>=0A=
> > ---=0A=
> >=A0=A0 drivers/net/ethernet/intel/ice/ice_ptp.c | 4 ++++=0A=
> >=A0=A0 1 file changed, 4 insertions(+)=0A=
> >=0A=
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/eth=
ernet/intel/ice/ice_ptp.c=0A=
> > index d8ff9f26010c..0500ced1adf8 100644=0A=
> > --- a/drivers/net/ethernet/intel/ice/ice_ptp.c=0A=
> > +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c=0A=
> > @@ -1559,6 +1559,10 @@ void ice_ptp_extts_event(struct ice_pf *pf)=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0 u8 chan, tmr_idx;=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 hi, lo;=0A=
> >=0A=
> > +=A0=A0=A0=A0=A0=A0 /* Don't process timestamp events if PTP is not rea=
dy */=0A=
> > +=A0=A0=A0=A0=A0=A0 if (pf->ptp.state !=3D ICE_PTP_READY)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;=0A=
> > +=0A=
> =0A=
> If this is a potential race problem, is there some sort of locking that=
=0A=
> assures this stays true while running through your for-loop below here?=
=0A=
> =0A=
> sln=0A=
=0A=
Currently, we have no locking around PTP state.=0A=
The code above happens only in the top half of the interrupt and race=0A=
can happen when ice_ptp_release() is called and the driver starts to=0A=
release PTP structures, but hasn't stopped EXTTS yet.=0A=
=0A=
Thanks,=0A=
Karol=

