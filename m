Return-Path: <netdev+bounces-95168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310E58C19AC
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 01:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE932817D9
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 23:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8628A129A8D;
	Thu,  9 May 2024 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LIh951Tb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9182A86245;
	Thu,  9 May 2024 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715295740; cv=fail; b=RiHTvW46Wh8heLkxi86hX47ReAqwGSRnJRO02jEGCzIuR6pYDznVFmda8er8nBs4KGQ95qSUS4CtjKqNr0amsGG1ow8h0VRanGloscEFanH1vB5sAQtxTv25Oqivtm2dAeMTiy+GZTKhJuyoWibNc9QpzVYdgA87ACq5MWqpcWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715295740; c=relaxed/simple;
	bh=ZvdkV6ATFrGzasxGwpHnxr6aWrKpe76F1FJt9gZg9pE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O7NKF8cLGUJcMbBcIhMhcA64B+fiAqOHcUE4wminOZmh9QYoBjUe3H48fL7OgEKGu1u2t6eatCnvcJEnlKhrZNqyvpk2Z6BaoghWOWNNlhPHqkFhXWgrgTIRw1GefSazBT4Y4Wa1/lRJJMLKeSYJ6PDZkXFiC6cQF4456tvMewQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LIh951Tb; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715295739; x=1746831739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZvdkV6ATFrGzasxGwpHnxr6aWrKpe76F1FJt9gZg9pE=;
  b=LIh951Tb8x1SnLxuVTb8q1/xq64v1dIKNA5EfGGIzAWFHYPlP2Kfq7lp
   5XUaOVqNmUiQuRXqJW2CctTt8c/2zeaFSg0zrtN+bRQlCcDM/3hMuLeoe
   9KJAf2a6WpCmOADpB0sEBJNpPkN4vJVIkH0kYBmI8xk7jyNLSzwQfK+Lm
   1Q/t85rEF1zyuWxDAgah5WMFH+70+RhIN0C46qZTP/faCYvALIDknhsV0
   AZasw91pf06W+KPgxLLyMesaSifjOn6KsJs3yhmu2xy9Gde/AwSahrqn3
   1fPfmJHBDxcG0Wgr5zYvoO2xkZj6SmI50LHJwkxv6N3Du94SKOdFfo0Z1
   g==;
X-CSE-ConnectionGUID: 1/MGw441RaiHDth+M12+dA==
X-CSE-MsgGUID: XSBCB+AsRamZ8fTIJeDH5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11381040"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="11381040"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 16:02:09 -0700
X-CSE-ConnectionGUID: eo+smvnZQ6OU+59w8KioFg==
X-CSE-MsgGUID: Gz63K/L4RPqW2S/4DZKYVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="34260333"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 16:02:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 16:02:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 16:02:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 16:02:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pu0HqrxIBh3HQJndFVq4czp5PgGLnVbspljws9HVTNvsHT+H7PxSMhd+xNaObhYiHYCaiJYQNMxTgG/YMdWDlWptX6Er0CQgM650MTe2Kbu62rbg0+SDFAnaPK1zV96kVYP26RupPtwVTJ7UW1Kn1lwD6pau+7KrMaoEJ5+TLHLmiXn6UOBs7kW+Ld86INxatUJ8ZtkmUOoIXipLYGPm8uMyDYgWhoKIcZqrtXJj0q81xa1KQVRGrv8+wy0Yx9DPgfQrdhq415qBW5uEsTnRDMcNfPMdW522oAaGUuuiIYIDEOV07T4Fbk6yPR8dJO8BfGfuWTYLObSP2JY2wuqXqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNdafmmyU+iuYj97gM9FzWyW0H+HM7ysegZyL7twP3Y=;
 b=ZF9B59VkH8VCu1tQeYtPP+L/hJ1dGYWSViB4lqXP1IQTgw6kDJ7DQGAjAPqYXBWy+ZZu4BeuelW/fq5V/475cKfhlmVA0JYAzkpAEMITkMmY4IwKpQCoUnu7LyR+QKd0PkSdn3P+4S+o/5/M50Ar/gH61lvKQ5IUYb8U4Kh/y3EHpsU96EKzSEf268nBreTV/v04f0juedex9kCOn80BdMBrpPkW5mvj+QSNJeQGcgrwOE4aZL5wFEHcK1plt9kIb9hHs3tGHFGVgV+AZrfD7iBaPb/j8GwXtsMo2zQzD5faD+U/3Ob4FRPUegvHU0/ztUGe2OWTsolxoXPnKtmzLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 by DM6PR11MB4706.namprd11.prod.outlook.com (2603:10b6:5:2a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 23:01:58 +0000
Received: from MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::6446:3cb8:5fd5:c636]) by MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::6446:3cb8:5fd5:c636%7]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 23:01:58 +0000
From: "Singh, Krishneil K" <krishneil.k.singh@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Zaremba, Larysa" <larysa.zaremba@intel.com>, "Brady, Alan"
	<alan.brady@intel.com>, "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Linga, Pavan Kumar"
	<pavan.kumar.linga@intel.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Bagnucki, Igor"
	<igor.bagnucki@intel.com>
Subject: RE: [PATCH iwl-net] idpf: Interpret .set_channels() input differently
Thread-Topic: [PATCH iwl-net] idpf: Interpret .set_channels() input
 differently
Thread-Index: AQHal/EVpUvpxq7QukW7Rz83X0cLl7GPmKKA
Date: Thu, 9 May 2024 23:01:58 +0000
Message-ID: <MW4PR11MB591177888AFF2E9EFF199E8ABAE62@MW4PR11MB5911.namprd11.prod.outlook.com>
References: <20240426154125.235977-1-larysa.zaremba@intel.com>
In-Reply-To: <20240426154125.235977-1-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5911:EE_|DM6PR11MB4706:EE_
x-ms-office365-filtering-correlation-id: f9f4cc34-249d-44dd-419a-08dc707c079f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?mLxFk+PU4hV0HCfVk7RF74RqDKXcgJWEGbwwksWm/jew2+w2pjlLXz2TFd4U?=
 =?us-ascii?Q?vfsnHNR+S89q8SHhlWnROxHqNuCUQrC1wJK+jNIMgOiU5H1QaTzMcJwvSyfC?=
 =?us-ascii?Q?aXE7ijH120tFLsGEWL2Wu8/H3Q96ydAsJVOnMa1qxvI7qlZdyV4FW67PQJcE?=
 =?us-ascii?Q?0yw37dOQ7GQRW176y7OwXiZYuKw5B+phYAr/fIZdU/01F7B15S+R18a3Dq33?=
 =?us-ascii?Q?9R/4l20RbqkXlWWtqeXVU8dMQ3CG/dUuKD6kpRwE8EmpKLfyC0ASpTJ2+1GP?=
 =?us-ascii?Q?SQE+myRS/nGnhsXnY7x2mWevL64KSr2tdAOj24dey8uPSbpo3OjaYfb1ZNWI?=
 =?us-ascii?Q?cnqUFjy7GE7qExa8Nx+16oVWrABvCzxBVroIgS0Tdtnim5W8ibNUMhaLhydb?=
 =?us-ascii?Q?wYggu5HzAq9WjXj1f6SKe/X+wwuXZ6ulmgaxS0gt5NFtmakMnGx89vcTS4Bc?=
 =?us-ascii?Q?h5hXJzp1ZZv2cxl+uZ/wHMmZzEsTYzQkxOTS9ItCKER+pUuWnGpYk3fLZeVP?=
 =?us-ascii?Q?o9m/GEK5AFuEe23CfM//T3AIUBd8nGQSwxdrXVM3RCZP177qjFWtzj7eCkO0?=
 =?us-ascii?Q?BZgllYvtxyWbR08VADCjZhDpcM9aD/DeMrd3FQkRYj/HxcFBbs/TFQKKlJRa?=
 =?us-ascii?Q?udH3jZBHNiUShOq0/8pkx9Ow7ppJPO4Er8trIHnW3rFj3xa9FjuoFKmt5t77?=
 =?us-ascii?Q?dL0zpJEQYS0zHbEA65vmcsiESxK5ganxF3ZuoPx+pXUdLtRpSFMJ6jU9PoNB?=
 =?us-ascii?Q?XHvrAGUJu3mpzQ2XUdeOMneeChbAB88/zH46bcpellSa0W7Jjdz4gXpxtYh+?=
 =?us-ascii?Q?eS7CKr5PtrgzXtcJFuslWN6MDTNIBkTZs22Zleznn77K54Cs/dvEfjS+nIXU?=
 =?us-ascii?Q?Qls1RF1p5UeU5jHc/K8F2xgBM2xdtx3BJDhUrYqtl4UndHCBFRZvwczXolB8?=
 =?us-ascii?Q?+RPxjkdQFZGygz8yjTHX0RXgX8sQObcK4/zjymI+XHhTw79kFQykt3WJ48js?=
 =?us-ascii?Q?UPhQyrrXTvaKDReicGPd5/3ZsR6OsBGnN3Y9dPTr12qnCVTKdLEMroTyF1Dj?=
 =?us-ascii?Q?rI9sBu7jS0rWxtnUOZU8JoXNqleTaandG7OgYlPS2dMMayYAXHNLUWZt+coX?=
 =?us-ascii?Q?ArlOcTeSNeBzQ7p5VDtlFy4sgFOlT6VsTrKAHFzEqAISzdfe95xoNotnmEqk?=
 =?us-ascii?Q?MBr+QlOYsGTMGLIewf+Q9l9kGqaV8x7oseiA2UX2xzGGTzC2KYVR/AMROSoh?=
 =?us-ascii?Q?eqjAr0zHKiAp9SFV1FlpG2MAKa8dSfr2i1dgxnma4JvP8ggDWabgbvhG5fe2?=
 =?us-ascii?Q?smU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5911.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wqCt8myj7s194RrHTGvRsvzIOGXxvgcmizQyYu0ipNb5l6ILdQ8iqFew9/kJ?=
 =?us-ascii?Q?4lYMyWXp0b18yeDs/g2e2WGn9mm3MhqntRLewj1mFJg3hDMTOeUsoX+woTvc?=
 =?us-ascii?Q?q23cWTJDhdHK58HftdBuGIUNJHr44psNV3Tsj4ixxWrCBRLHLAYcSSxGGTBx?=
 =?us-ascii?Q?Yk9wrDF2wphBeQw3V3TF2enh5RzFy4s36LHNar/XFCANjo+RnuPpuR2Jz+u5?=
 =?us-ascii?Q?VdKX6pf0uVoeW2PadrCwqjxDeXHNsw2ddw/SCRuXKl8w2KMO9/tniEETo3xS?=
 =?us-ascii?Q?Jj33RUnZRCdP4fXeePO2lCOQUcTfhkRaMZ25yndrf6JxlcfTmPSX8uIuXlq+?=
 =?us-ascii?Q?fZ7R9t2drD1TyAlHkw2gTxFP6pBRjimwkquFj+8EOJBKnptaFB591bydfQFF?=
 =?us-ascii?Q?4MKQgiuTvkuvfU6EqKC3OaZulrRSbO/cAB+wBTUQyr+8TxgThUxQOhk/Ar+G?=
 =?us-ascii?Q?K/HcS3ue8jCpxavc4uwZGJHroi0KdtPANHIYa/5dQUUpaYog87IquT2zKCsk?=
 =?us-ascii?Q?aywbVXT8zzCRPtpbzqbe5k3dB8x0qdBSnp1IRivfR2OSjpP3rZMBdm4aM5AO?=
 =?us-ascii?Q?EBaEIXyET/0UfFDT8BNegjfoUg1zDvUFUzBLCN3LlNu7iuNXaMOvQ7/jmWvc?=
 =?us-ascii?Q?eNPwSUId4cGdnvGqPRhbpGEhMeEUQ0vGhRZ5ulG23hAMBV9oaCev47bnnJDn?=
 =?us-ascii?Q?tUHEjOct8dFiAVkbcKAkRJ17ZyYUnFMEBTWctvslnJZMN/YBdFaN83KSJWGn?=
 =?us-ascii?Q?8XvNUIvL3iU0/2UbiFuOz4oBGeXdYHN3OXw/S7bAd0Sx5f9xExdX1PclZXD8?=
 =?us-ascii?Q?UmoYon2qkUJMo0vfuN0R3jS8r0IsPAuHPT2SQHpJDPOe0Qe0LYANW4IaKWhh?=
 =?us-ascii?Q?jeRoAhUznn2kErog1cdsP674FtWslx5mHm8UVgPTJ3YNKjaJfWizf0fNQx9l?=
 =?us-ascii?Q?dMmBkEh4i3Ppp43Tds2yX/PUL2yqtNoYmeX3YuyQIAKwtAe8Zp9cwaBNLmkR?=
 =?us-ascii?Q?hv4NxUo1iWJEb/G9ABcDxhBQCNKeCnbsSkWH6ZGNHqJU465fGDja+I01eKVn?=
 =?us-ascii?Q?MYsP5N6NU3B1DePZ85U67C3ogXjkCoIHT+iJoLbHYPht0iYeDHYHd1DZaILL?=
 =?us-ascii?Q?XWxzK1T9lcTcqe3MzNrZrcHFhmG011Q0tkdLC8PDsQ0cTjZb282s8s0VQLzN?=
 =?us-ascii?Q?eJXEhPg554d192of2GgRZey3I22R5yNdzKfirn0B2n+0Noe7cIy6Ip9uFdvm?=
 =?us-ascii?Q?NZ3AAulVz3gBEm8e8iTZdbbXbynSNchOzDAfFnmwc7J98tFTabETN0R81RBR?=
 =?us-ascii?Q?FzcdznrGgpgqhhn5x1tvdeBBWZsxiJTSK/qlQrlN76jx3LVLgp2Dui1NFrub?=
 =?us-ascii?Q?I4TE0rjxk3cjaYBT7MuKElKCZNE9smakelkjSSh23PiHZ1rZCsmS4If0Tecb?=
 =?us-ascii?Q?bPJ9aO45PmXxgZLnSIjA4kBcW1usaupFUwg+evVUPgstk5Ck5rimLR+e5H+B?=
 =?us-ascii?Q?r5M/SZ9Ni0RZTHj7n6keT37abTqPPwy4xpvohhBeNBbl6EfmJzv+AchOogUY?=
 =?us-ascii?Q?LPzyvkBB5RtVSElDJ80Yv5sgFUxhdgJHSLPGkeDtx+wCEBQhattN+jsoj4So?=
 =?us-ascii?Q?yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5911.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f4cc34-249d-44dd-419a-08dc707c079f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 23:01:58.5665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: md8VV/lr/f3ht5vQuD4efqxxMmknan5rFw1/6eSGXbJFGxILeoT/a4JP2zo/oWUvK1x4JNQOSCEteQKIR0n+f7mPz3gTexHe09FMAndF6g4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4706
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Larysa Zaremba <larysa.zaremba@intel.com>
> Sent: Friday, April 26, 2024 8:41 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; intel-wired-
> lan@lists.osuosl.org; linux-kernel@vger.kernel.org; netdev@vger.kernel.or=
g
> Cc: Zaremba, Larysa <larysa.zaremba@intel.com>; Brady, Alan
> <alan.brady@intel.com>; Fijalkowski, Maciej <maciej.fijalkowski@intel.com=
>;
> Brandeburg, Jesse <jesse.brandeburg@intel.com>; Tantilov, Emil S
> <emil.s.tantilov@intel.com>; Linga, Pavan Kumar
> <pavan.kumar.linga@intel.com>; Hay, Joshua A <joshua.a.hay@intel.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Bagnucki, Igor
> <igor.bagnucki@intel.com>
> Subject: [PATCH iwl-net] idpf: Interpret .set_channels() input differentl=
y
>=20
> Unlike ice, idpf does not check, if user has requested at least 1 combine=
d
> channel. Instead, it relies on a check in the core code. Unfortunately, t=
he
> check does not trigger for us because of the hacky .set_channels()
> interpretation logic that is not consistent with the core code.
>=20
> This naturally leads to user being able to trigger a crash with an invali=
d
> input. This is how:
>=20
> 1. ethtool -l <IFNAME> -> combined: 40
> 2. ethtool -L <IFNAME> rx 0 tx 0
>    combined number is not specified, so command becomes {rx_count =3D 0,
>    tx_count =3D 0, combined_count =3D 40}.
> 3. ethnl_set_channels checks, if there is at least 1 RX and 1 TX channel,
>    comparing (combined_count + rx_count) and (combined_count + tx_count)
>    to zero. Obviously, (40 + 0) is greater than zero, so the core code
>    deems the input OK.
> 4. idpf interprets `rx 0 tx 0` as 0 channels and tries to proceed with su=
ch
>    configuration.
>=20
> The issue has to be solved fundamentally, as current logic is also known =
to
> cause AF_XDP problems in ice [0].
>=20
> Interpret the command in a way that is more consistent with ethtool
> manual [1] (--show-channels and --set-channels) and new ice logic.
>=20
> Considering that in the idpf driver only the difference between RX and TX
> queues forms dedicated channels, change the correct way to set number of
> channels to:
>=20
> ethtool -L <IFNAME> combined 10 /* For symmetric queues */
> ethtool -L <IFNAME> combined 8 tx 2 rx 0 /* For asymmetric queues */
>=20
> [0] https://lore.kernel.org/netdev/20240418095857.2827-1-
> larysa.zaremba@intel.com/
> [1] https://man7.org/linux/man-pages/man8/ethtool.8.html
>=20
> Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  .../net/ethernet/intel/idpf/idpf_ethtool.c    | 21 ++++++-------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> index 986d429d1175..1cf3067a9c31 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

