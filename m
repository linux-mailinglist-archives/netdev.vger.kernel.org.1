Return-Path: <netdev+bounces-258037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFIyDtPbimngOQAAu9opvQ
	(envelope-from <netdev+bounces-258037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 08:18:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F330117D13
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 08:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B67213038144
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 07:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB24332EAD;
	Tue, 10 Feb 2026 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aX1MVdOT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076E8332EB2
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770707833; cv=fail; b=tOtOZGkqibPqbFTglcHzSoIFBx0KPxeCG2aOqjXp4O/xsJxcFV9tVShVfTZ+LU58deNN5z2Q89e1ZLCmfUCaSz0VXy2uC4WjNqfpIE/vr9rYdFIxqmu6V7bJrKcggtdXbNmy7Vw2Mve+pT/xLGP8JLm+gy90skTWQTVMTFRlbU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770707833; c=relaxed/simple;
	bh=bdbsDb3f3f8ToNNsm2g6k/N6nBgmQl+4wnOitMd2Q8w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K07X1SMLMAKFBl97FeVNmOpsUzXdWsGRUwndqu1Pbx8SFK6lYznPudiFotIuxXtb/lSWbEZoVW3W/ECWA5o6sghs+jgmlTXXhSqr2puEjIErRCa0TxsCTVHx5aHmHz4BvJNoOMhQj7OMYaJpXPO9HfrlZomM+sIFaN4iSAG/uJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aX1MVdOT; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770707832; x=1802243832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bdbsDb3f3f8ToNNsm2g6k/N6nBgmQl+4wnOitMd2Q8w=;
  b=aX1MVdOTTiTlb/HL3j7LMILQmWblraP1MS1RbVQgkYcsG2dzygCOt9w5
   anc8aTChPD18rPB2/gGUTxxm2PcCt32XLI1lO91Qz55/wboCwcSvYIcmi
   N6bNVlEUBzHfp/d1Pk4VYEMOnSMDmiOHXBsRVWlM4/Fot8+x2oGcD9teh
   ozzI3ryywCecpy/tgL4p23UH36TIS8rpImWCMVgw+NWm45wv2woRgerOC
   rDEmg9Ns3InPgjhBTjDkVZ4Sjr4HJZ0pe1cvmTlLZRBC9BMgCl4fH+bjV
   oIMB1BixbJMFB3XrSU3jqC1CGQT/3OEgLzaRkoa6lZMWbqSYU1CTC7kXD
   w==;
X-CSE-ConnectionGUID: gRRXDpVcTsSufHH7u+jiLw==
X-CSE-MsgGUID: SR9XoThIQjuhHFRirYegag==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="82467305"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="82467305"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 23:17:11 -0800
X-CSE-ConnectionGUID: pM2FavePRfqbgDv1LnFfyQ==
X-CSE-MsgGUID: mckI7905TUyaN+A/A+fQ3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="216342173"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 23:17:10 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 23:17:10 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 23:17:10 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.19)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 23:17:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrCZlCu2IJKBgCw/5r9l2pxbhcnH6lpc3qfltgCfM943iPceW8apqCi2pnZSv6Du77V7i0ICILGwsluom+iKDOJUtmXuLh49mOb+FFM2R4zo7ZBePYkR6AsmvsLpPqIcMwfZ/i80O8emnLyGSzmMmG+Fa8SKe7UrrUtcUCqXygbVQ8+L67geg20Ae0CHaiLJppaIf5+6Y48/qYL2o2jC64lOlli6Q0o/VoGJDFC9n5bPYjPA/NXHDAqkTyEpl9VI/ymi3iu/bhQSGPt8/bn6t+aWDV+jk2F/zZ4c0qFI8t2YS1poUhOLSMO/Mkzcv0f2E2H5V+BdfPYxquWImFyAiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNSbQkP77Lriq9zGy1KH2IrwwPKQh/iTfx2QO3+2BMg=;
 b=Ds1RIiFvSnmzWrcI2v+DxyzGfMua8ge3RTS+xlZEp3vyC95dmKj96n3T6BeMAN0OGfm8x3zNB9tzc7Oh+b2mul/G3dGcqRrsHeAiXALOVr4Bj3fTgfESQDsFWbSzZdA+YeCEpJTY6QSO7UpcmfgD8y7wkXikwNh4ry5H39+deKqTL/eh7l8gJGRgizt8c1KJmWFeBoc9Ynrl7W1oiKOfqahU43Q7VL2WBUbyREa2qb/04/oGw4pfOFsSV24IIHjnT5zPc0IdMhmOZz1piS1JXWTkC5sDjqWcMsGcq1kghpStD/Z34f9d2NbIMONccpWqPz6Hbj8RE7zOF+0a9zhyQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA2PR11MB4953.namprd11.prod.outlook.com (2603:10b6:806:117::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Tue, 10 Feb
 2026 07:17:06 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 07:17:06 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Thomas Gleixner <tglx@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] i40e: Fix preempt count leak in napi poll
 tracepoint
Thread-Topic: [Intel-wired-lan] i40e: Fix preempt count leak in napi poll
 tracepoint
Thread-Index: AQHcmfPFI7D/Hch/ck+jV6IjHUccULV7hoeA
Date: Tue, 10 Feb 2026 07:17:06 +0000
Message-ID: <IA3PR11MB8986620478DE754429CA15FDE562A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <87v7g8zv2o.ffs@tglx>
In-Reply-To: <87v7g8zv2o.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA2PR11MB4953:EE_
x-ms-office365-filtering-correlation-id: 9a74fbfe-ce64-4295-4fba-08de687465ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?7q/wj+RWFSgrD//+lzWUbctwe8oT58laXktSVBhbDjmxMEpKJ3uQ7abrIlkZ?=
 =?us-ascii?Q?tfH2/FgIYZuB0rBo73urAFQYEKQuS3DliJHkxbL0/OFJycCJIYveCqT/O0B7?=
 =?us-ascii?Q?pZfo7WaVTGaksLRcZ64Z8Tp+lERwlWFuzXty84wwMU6ehsatOIJakclUl4EP?=
 =?us-ascii?Q?xmTNqGthk7EG8k9FcQxFjomBYWtoaQ9w8EoMIw7ZW56GfOvalrpr3HYCuWfO?=
 =?us-ascii?Q?oaUq1Q09rvA9XxOe1jaqHPMM1yyil5qsGMNJDoQUjZ7DQIO0LFq3Qhw4GkzG?=
 =?us-ascii?Q?Rhgq26Tg3Dxk6seDUaYN1dIivnmIgCMDqwxIwnd2bvKYfpL4/zpl+jFEZIOv?=
 =?us-ascii?Q?u0WCSOPEvBEvr6tj8KP92FY/TefS/0n/go+2RwTs9Le60nwgTlwCirB76iFa?=
 =?us-ascii?Q?F0IgWO7Ul7AK+xRfqJLFzlmVwn2aMnaCiweAVHL4kDKmHiywWoIRUJK0CZfz?=
 =?us-ascii?Q?gWNjFwlY2omZ7fK2oukKv+zoydavjfIy0it0jNktwV0fTzJaAY+A1v4eJZpb?=
 =?us-ascii?Q?7GC4Mtqdf2NMJDnS2U+WVWzCniDB7dh0H31XE85lCMJ3cee3bwwwjwwaGjfY?=
 =?us-ascii?Q?oHn/P83M32f5opIKx90k+d9prZ+Vhv7KX2TkuSjQbbdMT+T4HRiDQ1QkJgpH?=
 =?us-ascii?Q?hWh85WqjPXDPBT3vI2W2QRifeRUTbRHleZiG0HiQgkLWMUTz9joTjMNLth1s?=
 =?us-ascii?Q?QZLB6yMmtTW7YGKc8TTkSzGuXgQ3JM8KpnrusqOaMV17iSmhg26OCMm9eoPY?=
 =?us-ascii?Q?YUIGpxPHLq/63BejvFK3ljIpIjOSAJDZPK0jTEBI5X8BSJpBLHSYLovBqxZj?=
 =?us-ascii?Q?beNCOWOQ015d8lK4aL/oLS2V/kBZFglmCh1ctOmwDLgQjOCldyJheadqUiOW?=
 =?us-ascii?Q?lvJKO9e8ytXTyAdAiEROiG0e2DmmwSK33cqWkgiYU+6A4ZhZQ2mEKAg7QfC4?=
 =?us-ascii?Q?hGufCDSuLQGRo6A0MafJM/xxbQkMCy1ghzNvA9LBfGNQmqQWrsm8C4mXnWta?=
 =?us-ascii?Q?uMcxABLmmud1ZlAqtfgNB3O6AtTbgAGeeAWxW0fo886/aWPWzVH92u6BWHIN?=
 =?us-ascii?Q?Y9s9yomimX2bPj7hlfK3uqiOekNLsv4MZ7tjql/h/jIzTgNuxwGtThG/QN0U?=
 =?us-ascii?Q?NOrc9a1aoHmWIf5DDTSCaTVFjEjF0jsCUxmHFPNEgZwp9y8mU8QHm3b7wYAj?=
 =?us-ascii?Q?qgfhoY0F/dZL5z3VtW4lm5St+h5wee45aHuC3dtEcUYxkiNbTJ+nBL4/4tvs?=
 =?us-ascii?Q?JttsIcnIv5JmYiNe5j2OJtKQmr69H4GW7NZ6afYq79CG/XcEHTQr+JGtPbWV?=
 =?us-ascii?Q?wXz77+PeNbfXCL+HKqwE0YVoiFWS/eqK/dx+Zw2//7+R/cxAlJDyyFBpCxh6?=
 =?us-ascii?Q?/0yhTam7t2aFSjMQ/7j8hs8dQ/9jnIrL8YW4zbW1w/UHRMFX5Zs6vFqlBxZ0?=
 =?us-ascii?Q?gKQzIogdYCD19nEYmznZPCWQPm/JSrbxSfIQsXNitFEFx8v7ZUSND5EPzCaB?=
 =?us-ascii?Q?5wkrvy3jAwalf9yzDilMIZKTcYCn1H9/Bzvu28RWkjGTrlcBNZBGOLIot8LR?=
 =?us-ascii?Q?NyxLBs7rfEN82WunQuI898VVNxvvi3OBbNiHVuNPgf0qrN+y+I29dZeSNtJ7?=
 =?us-ascii?Q?yZww5DpP/hDivn4IqePlUKQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QKRpNHn7oFIPv964LJvI0+my91nCfvs9RtQ8gAy6bpKYVaDa7T9hZs99im7Z?=
 =?us-ascii?Q?AQgfjgO55nGg/WoAkJ3GmyRvU2qbGL4GsN+uKkriA/Rk1ILK85BoJdzowqZH?=
 =?us-ascii?Q?ErI/Qzr/DdJCUFxPiUEoKPBgbnEvbqbyQ8M6UfaRKaUlOtgwGHgBT+gSuYWW?=
 =?us-ascii?Q?ZJ08t9c4GS1Xyxo7WpI5hrgFB109QcGxzd+or97CodHNEwm2AxbkED3tBeAU?=
 =?us-ascii?Q?oLlUAPMQPOEw70WynucumSnVxkX24KD14+m64Hh2NJxH8QMf/WhmS54uY2Ae?=
 =?us-ascii?Q?+AeeGEBvz7XCTBfVWtD4H9rFIfOE3Q0Q9fTlPk+CwWgYlL5Z8AKl3f9fANWP?=
 =?us-ascii?Q?5QSV1ABrWyn/sNrnp07OCdN8Rg7u5KgZp/2v5CoJLsIdrC/c15FvBmc3s06P?=
 =?us-ascii?Q?qjX87PiAlPGFK0KG7zXzxfoMw9EgslPRwbb89YEdaLBhc8EZQzZBk15HmmJm?=
 =?us-ascii?Q?cxKebnX1bj+diFffHO5xH8glHVsd5qLXujSPwWY/KtbGrmY75vluavuDgYK5?=
 =?us-ascii?Q?Uab4TXSf9ut8VTDV/i7oE2Dt+rG3xZjzhogtN9ca73pz0deJgRFwAs63pJFk?=
 =?us-ascii?Q?SqsCuMgSMLKhbTAd93FNCtqpNmrB3zYowosiV4ji85jF4XovTzKyP3hgGQHS?=
 =?us-ascii?Q?jU2aK7IPk4wCLuEtRJnR6GcVTocH6RT6SjF4JJ4m032IDP7N6vxpAe2Uo1rq?=
 =?us-ascii?Q?0Im5udKYe1z8JVFIiNw8qPqsMmH2cQbZPgqqJiOI2HeO33p/XTksqwTLkE7R?=
 =?us-ascii?Q?bTwOe2hwEWGc5cxktY/lTLkvQJ2J8ruFtLuHWVSXlM8z6134PvcF0JXz/qOU?=
 =?us-ascii?Q?8TvYARm339eoA3YxnPc+5j3jQkVLwP8caccKIm/1om9HdqpN1LIhvmbX+UL2?=
 =?us-ascii?Q?aX8SgT14Sh1rHl6izJsGJ99KQgPSgTMXqbJ98Sh9Pc1Zai3DuoPOfHRcDujz?=
 =?us-ascii?Q?4sDc3Jc975nt2W+MdtK7YzgQgeWG9iAqtgdMcqzHQXB/hkqydfzYtcnSbIhi?=
 =?us-ascii?Q?s8oWCrKR1+lDkgdnuUhm5KaL/ULkA0IK8EQEO8JYIon9DTd1NXQFfea5dOSw?=
 =?us-ascii?Q?nyE+o676sWaRSSsrVnEf1rwr4sp8AI890koaX3TfO+WBmJqSqsZsntjrnizn?=
 =?us-ascii?Q?YiL/wSUkKBNa16fPCnbEDVZX/vk3mnVcVumi2/shJafpjFzxLaFULX1cVNHp?=
 =?us-ascii?Q?ZiyvQL4JbQZABb5TcQnCpsMrw3AMoA6z6B1Mwbd9QREJMfegYtWPx4MAuE4b?=
 =?us-ascii?Q?wz8OxjvvsaESZT81XjY2LgXkW0YOcq23MKExvULvDPpJPNJ4NY//em29XHjI?=
 =?us-ascii?Q?tr8weZJ+je+OpskL4DMe4LdCFHL1sSQLP8Hg9LI517Xf3B6IDnheIDz+iLwh?=
 =?us-ascii?Q?4R60E69vyoEGZ9C39hUNnNTIK3vQtHsPomkr5jgeKM7sZFgQP/oVnNTfRaH/?=
 =?us-ascii?Q?+Ud0SDpUNq7yeUcigsRcay6hYe56lHmi0Y+LrCS234RG+yaJQKidGBd0a6Vi?=
 =?us-ascii?Q?pDwbi5pvQctY2rndsw/BHxbJHtXI17s4XOwY5JxzK8b5ONZGvMdxj65/xWJN?=
 =?us-ascii?Q?+LbHXe+DwUO2dGiA62BsGZb5WSevZsfAGZ0Hv+Zhe6TCiaWzUCtzfAidyZRO?=
 =?us-ascii?Q?5VDUD9MCglr1m2W30kOsomkgXge75QoKMH1YV8Z+y32ACQwtL48te/wJJsrk?=
 =?us-ascii?Q?B3xaeqjhPjKaLnCm/TBbu6GHAmkkwj9jxqYoieVBV8vQyzO8gxnNJ2bREtvI?=
 =?us-ascii?Q?iJ8Ku/2le3rQkSUmFbw8bs7S1i7kTSI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a74fbfe-ce64-4295-4fba-08de687465ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 07:17:06.3718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZN7AoHa3SrQp4+3R3AobLSAAC5q5/yhyByXZUALZNIoa+7wUldrHGNA4U3pm13fT2RTHLUlQPg38vNlEvHBHwg2vL1aNyPd0HG+tW91Fgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4953
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258037-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IA3PR11MB8986.namprd11.prod.outlook.com:mid,intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,osuosl.org:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7F330117D13
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Thomas Gleixner
> Sent: Saturday, February 7, 2026 11:50 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; netdev@vger.kernel.org
> Subject: [Intel-wired-lan] i40e: Fix preempt count leak in napi poll
> tracepoint
>=20
> Using get_cpu() in the tracepoint assignment causes an obvious preempt
> count leak because nothing invokes put_cpu() to undo it:
>=20
>   softirq: huh, entered softirq 3 NET_RX with preempt_count 00000100,
> exited with 00000101?
>=20
> This clearly has seen a lot of testing in the last 3+ years...
>=20
> Use smp_processor_id() instead.
>=20
> Fixes: 6d4d584a7ea8 ("i40e: Add i40e_napi_poll tracepoint")
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> ---
>  drivers/net/ethernet/intel/i40e/i40e_trace.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- a/drivers/net/ethernet/intel/i40e/i40e_trace.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_trace.h
> @@ -88,7 +88,7 @@ TRACE_EVENT(i40e_napi_poll,
>  		__entry->rx_clean_complete =3D rx_clean_complete;
>  		__entry->tx_clean_complete =3D tx_clean_complete;
>  		__entry->irq_num =3D q->irq_num;
> -		__entry->curr_cpu =3D get_cpu();
> +		__entry->curr_cpu =3D smp_processor_id();
>  		__assign_str(qname);
>  		__assign_str(dev_name);
>  		__assign_bitmask(irq_affinity, cpumask_bits(&q-
> >affinity_mask),

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

