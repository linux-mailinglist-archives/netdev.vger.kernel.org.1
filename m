Return-Path: <netdev+bounces-194745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC12ACC3C7
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7519188D920
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 09:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F368283127;
	Tue,  3 Jun 2025 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BdlNk2c/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA9B2820CC
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748944656; cv=fail; b=MniQ5WLAMPsg6uF8ca53oPL5D7KcWLuRCQLRYq0iNy70XEd5IKp5SLrICm9eCJdkCQp3jCePlk90CQpGuXI+rZG9tgrRoKrUAcFxvKLOgPk77ez++uA5krElbZ4ZPUMo67iy8zlN0P0oVy7MyOdTrjZNMc9TShZYK+oGDQCwL7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748944656; c=relaxed/simple;
	bh=Z5+gj8Q46LL/7oZq1WgHeLgRl7W4Mkaq666vxztoqCk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MI0nygkCvRbrcvxaPByLp3CwhNgflKkpeMa7UjCL3bSdUcD87cM597CGEotoiyg2RFwl2vsvibmNt162I9mQ06RHnmW/fVIVN6cSP9TEshh4GjO95CwpSqpSIDtv1cry+hnIjYIahmhvF5i7Y+FiPTtQcir4Wf+pbHFOWsCd/jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BdlNk2c/; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748944651; x=1780480651;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z5+gj8Q46LL/7oZq1WgHeLgRl7W4Mkaq666vxztoqCk=;
  b=BdlNk2c/oNOys/KA6i7lGKc5BkrAwcvdRkUxef5QBWjBFo8vkL8heC9o
   Gvw0M8JBcHtwbTRLncQlRMkAFog2kVxSFpujVb6pOiSKo2nTTmOowsMqm
   uBTRl8BozmXJOqJqJiokkD6SnJFYCrv9SFVPOqhgS/VmGc6H6pKpWAy1a
   BECDVdE20WSG1kidT65QCygkhc0PZritmxc5X9/Ooo9MYGJclWd4NNLPn
   hR8Kkm2OeK1S204i+mMSJzKe3ClYImW85blA7Elw1Dw6GXDKWF3bLMlnO
   quNW65wuWJ/9AobK+bCjE5NDD6TZgnKlhwbTr0MhCOlm4b0NQzTX5LcMM
   A==;
X-CSE-ConnectionGUID: 4p29zJq2RLKpULhHt6YHqQ==
X-CSE-MsgGUID: zACXOhXnS6yLCfS2mQMA+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="50981669"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="50981669"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:57:31 -0700
X-CSE-ConnectionGUID: s6rtZF8RT7G2EXDe2VNtgQ==
X-CSE-MsgGUID: EMiQrujnQdmiy/jC6Mx1eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="167993906"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:57:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 02:57:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 02:57:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.86)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 02:57:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMypExpLl+2ICxJxt+VEacRwmLzwG/MW1wa9sAophztVboEKVC3Ogt/R/+W5poLoBOmnBGvs1yiYEDGGKlXJ4NSmMZzIWdKNB5VRBWFjQuWWGrjv4l/0Eqfyd4J2j4mKrDoAOBGvcz6aFm9Jly5b7WXZUcDKnrEg2/fQmLJmMXfYy1BfdEp/2zZJjYyvlf+kdf3yr94fpZt6e/h9Q9IFbPSppyvIRDykcwSxnjIZH6DY9wJWgS4efTpbZ6ecWWSwizpuLfuJKPTh6nHWzBlZHbnbWJDrpaPdV1ALKShTRKL3Fb//nahglSKeexnXDLSxJHRYZ7P9QxwrIL5PU6IssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgG6x+5brUq48JabuOZ71pwUB2tR3b7w9jApaXrP81I=;
 b=mF10NNg9AIS4vKLT3nt0Z75Qhdm0rFfdZBbtgHqTUowIayM9C49+iEfz4P+YkrhplLk9nbNcqv4lSTNLYSnBS1BfMvGHpYjuqfK6IgxXyLXaqUX5WDivAtHEVVfpc/DKTkHcm8qLv8LMUzJinloleLJiTIMG9b9tAymMe/hJyDoJNMCXPib7Q4jEkqwLRCuAAZrIVMOaO/9Y0MkGz72xqKBSnRi4JFVQjwJctCNL+YWtulB94JRb/DkS1GvYiRNC94LdG9xrADPiLtpoPO3tK0XxgZnW0THkg+CP0WzXlYisBlfynSwREde/HhIe5jSekzfbZxESEa7PwCfx/Ldv9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by IA3PR11MB9254.namprd11.prod.outlook.com (2603:10b6:208:573::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Tue, 3 Jun
 2025 09:57:00 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6%6]) with mapi id 15.20.8769.022; Tue, 3 Jun 2025
 09:57:00 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 5/6] iavf: sprinkle
 netdev_assert_locked() annotations
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 5/6] iavf: sprinkle
 netdev_assert_locked() annotations
Thread-Index: AQHbpUyHcMW3GNGPoEGoF+8UcOVUirPxkQiw
Date: Tue, 3 Jun 2025 09:57:00 +0000
Message-ID: <IA3PR11MB8985B27F67F7EB0BC307B7368F6DA@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20250404102321.25846-1-przemyslaw.kitszel@intel.com>
 <20250404102321.25846-6-przemyslaw.kitszel@intel.com>
In-Reply-To: <20250404102321.25846-6-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|IA3PR11MB9254:EE_
x-ms-office365-filtering-correlation-id: 28484e79-473f-4c85-bd2e-08dda284fbdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?dovL+t+brU/J/JwXsglCLAt4vuOdI/t3ETUxX0p+4Q6D1A2fRjLrzwMn5uDB?=
 =?us-ascii?Q?B3PLJPyx7ir5OFvkoJEAwUKn3YshUv1U5xbyNHHzVsvKESYdUBtRFu3brkrN?=
 =?us-ascii?Q?n0BYGunZ8pzdnL8IVnnv4FJP5h+JhqyTH1BdtxBzNES3vHusGWXXYUDeWK5K?=
 =?us-ascii?Q?eH9orETHGD+AGRK1FN7mFLMnanPVDc4zeFGxselOdJazo2LiHRkYxwtMPqgg?=
 =?us-ascii?Q?LCkXb+hJ7Epl+tJ4SIkds3FsPGc14hRJNxhqoEmsV2+nhJTQ4wwSmLfigIs5?=
 =?us-ascii?Q?3Hx2HuO5Tc3AqLmESOHgxmlUm14Kq9IbtYJFbaxoH54lHSVGbnrw8A6aYnZP?=
 =?us-ascii?Q?/Njif9Xmc7KurMfk4BI4u9Bu450dmLcqnUmK0VNkSa2M/s5ANH1otbJpKrJv?=
 =?us-ascii?Q?HyQqM2SDlEHB2Yusl1zYHlfng6GCS5Zq4NkQIXhq53YDRGgERstPgMKfaCyz?=
 =?us-ascii?Q?5BrzZAUgJM7h3j7qjp/XZUEqN7BanFLY2ZTMbNsRxzDHnqBy7cxojtmRcWfo?=
 =?us-ascii?Q?kuPMyyhGQuKjm1eQCg5PDLg795zSNKKiFG59Q68BTT466pCxoODQRrAabsQU?=
 =?us-ascii?Q?UO2Ud0vX/U7bhD8QtTzJuTK4Iix7bwK8qwQOsvKd66P1YRYboLGtKSfjF4A5?=
 =?us-ascii?Q?Wpz51BtBMVnRe50L3/0rAX9LfZiXrl/9bPX/bMdM+pV7ntb2XIox2mPMR8br?=
 =?us-ascii?Q?gyi4fmTiBcoHRz0jD4l9DcZs31Vvr78y1zofO7uhxxQEXlWzRVtXGT6Ws2Sw?=
 =?us-ascii?Q?M0xoqTNBIodP/6ULEt8d3pIWiyF0ANXi5SR2W6iSUKMGwpTmtCfl1bME4M5f?=
 =?us-ascii?Q?yIw0bMBSWzo2OWJ82NRYsZZtpAL/KwBDy/iG1WaGQqFuT1Yrt8fFIbSl/roI?=
 =?us-ascii?Q?LhdyLMje+Y9hnfGpywEHwZFkz5EzAUiahNg3vbog+ZMEGX2hyTiup+hAm8dI?=
 =?us-ascii?Q?TwzJg/Q8SW39ktXX9p20QL9oo1VuVY/HRCjDQCL/AXLwkkII4P/us5r+BO9h?=
 =?us-ascii?Q?3sK9rX9teHSdBDFw24pvWvTGPPp/BqJJEMeW15WTRBEDGcIiLFlUJoNW7QGV?=
 =?us-ascii?Q?aeGIdIS0znRLktUe5QJ/7NsFniAUXbJHcIXe/8fDUSZQ1gOrxnknke4UF3qI?=
 =?us-ascii?Q?F90FOun8rcJFn0dHyIOl0F+HZml2KKK1iuDl9WkXFQri2Ym4F97gVxWvP4HK?=
 =?us-ascii?Q?HnBmiXuSRIOQSrfZS14J3EFfovNtX7an9M2uqKU6tECwLXTzhOcNckFj+3sA?=
 =?us-ascii?Q?LY01xDRcu1XnzFiT02EuFZpbXNl8fpkiQ/J1TeeITjPDrwz0FuHRbWXb/BxW?=
 =?us-ascii?Q?hugRAZ4KRQlpk6+tYDj0mUqECKWGb5n8TSYCyO7EGsQPr4EOKVaNejtLL/5I?=
 =?us-ascii?Q?khH849EwmQzMyCkGHiQy5h9OyCph95Xpb6SiVo7YwgvvQDW3fL909r/B1IJM?=
 =?us-ascii?Q?PJnf8x/BblA7UwuNZ2zU9s/GYAr9p4/Zf5giJFTnXhKsog6I/4jkOw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k44O0eRLFp+VSRdjrVJQzA1p7ivH5/DactkjnZpkoi1mitxk7IoVbG5Iyws5?=
 =?us-ascii?Q?bOg1nnbGtp4/jQaNzhdFBJHj2nqTMbG/nu/59vVqyYvYXfV8x/nUn/BglY2T?=
 =?us-ascii?Q?kySJndbsn7vs3beEGyT6kOVE4eEzI+xYDXzAuROAcUaq0GL3WaPmwzQ/WDzg?=
 =?us-ascii?Q?aZGxK9qBjCY+Kgb0nV4behm11rh+U57DzYz7s8901SB7MvWvwW7jBM6Y8WKn?=
 =?us-ascii?Q?SejO5F9ZM4zXQlS5nKZuCtqZI9YYfPlkaMmu3wUTziRSYgsrYn0Jxsraiccv?=
 =?us-ascii?Q?Oe6jg0Bm0Q5WTDUcp9dHFVhMn5F7vQGhV+Hv4txB0fNGSzenAO2e8rNqY22J?=
 =?us-ascii?Q?z8agm3AJsTbb1RfRUUVJ0bkZUhObhz6KYhcQHoq5h2guBkQZznCDjy86ktnU?=
 =?us-ascii?Q?3/wB13/edzgSi02vFjctAd0x44/nTfOWIdwgrKl1T/dtczR5E9gHML/uc1CS?=
 =?us-ascii?Q?7LZZVjUrK2NfMyLfMZ6/mNp0XU+KbOlMu5C82snZHt9EThvpnY37uBtnIhjI?=
 =?us-ascii?Q?pPLXYuCXui900+IPh5lVc3tUM5xf5OS+BAr8aILBztCCH90cmM8B+jNJv4Ej?=
 =?us-ascii?Q?zbus/dh4bEJOeSt4XehlttPtdQe0L62Qy7VFlnIU47Iw3fWSe4RR7UrRQlzY?=
 =?us-ascii?Q?3BCbJssp4oh3Rfu0MuszGTiZ3ZnLyUqL818VreJgCLaqqaWXsKdep8Lp6MId?=
 =?us-ascii?Q?KfjVwmWPWfMAzL7QXFNFHUfX2N2TfEElWf680ZZy0wSt+8MkSonnDPOGHJT9?=
 =?us-ascii?Q?MuysfolTp4Hc2iTwgz8DzHw1I+g4wHHj7WfoGOJ8tJ/PnSU1UDa9leutpXPm?=
 =?us-ascii?Q?MlWWoAV1C4NomIndUE3LUhBttaDl8DvPx0pYVPkOM3gEwEIo7x7Eno/vNzyZ?=
 =?us-ascii?Q?/H+bf1fJHJwQyFfBsOAISU7q2zNF0vMrx3omZ4JiFVbSX7794nQc2b1JGMJc?=
 =?us-ascii?Q?9/pbUa6JafzzSe+xW3QqViRjZA3KfveUVNseZNlm2E3vCBq7vKlVMvi5TjEu?=
 =?us-ascii?Q?M55v50t2ItJ/TlbWBSF/G9fD9yN//4vw9ru18K5Y/i1G71Cx6/luQQI28UpP?=
 =?us-ascii?Q?CF8ieQaEXjtJkMHoVdgCw2AbccOQlD4Bk80lKASjfG0fKgq706s01le2mLM1?=
 =?us-ascii?Q?NLGDPlcmn6+XmSS0ouHlHS5KUEgIfS31fyfP/ANH6TijN5SxAF3LPlWqH8+i?=
 =?us-ascii?Q?G50QPOWZyRPkIBz2hmisVN1KMYztV4CUDu1eJTeo5/VRnIu3v9ORhLfqY+fe?=
 =?us-ascii?Q?9hC/r4u9Ng1IHeQNTgDaq5M9hVKcmsrCYW6oiYfvslKU45WFEwA7G8497/dA?=
 =?us-ascii?Q?K5z1yrBGODmtecxcCMBIktMsA3app3RJcbl3hvSE72lTE90e0RWzIsGO1ukJ?=
 =?us-ascii?Q?GKzO8nkUobfsdFWwEXGlQ9az3fxngZqO8f/6es0iMiLRtqQJ0HHXQ4UydMbB?=
 =?us-ascii?Q?m0+O5QkmjN7WMLjMSr6X9h7JBry1ClaRGGO8qBVLHTtVZAN+QsWVv4N8lvMA?=
 =?us-ascii?Q?ezgBfStgSk15V7Z7LttbkJ41GkdSZV00+VGo8yZhKZGO3KEtabXd76QoLAwB?=
 =?us-ascii?Q?DNR4HKGEB7CA/hmI82njkkSTSCA7bzsas4saeBv6vOKpTMVONPaJ3oPzyM6M?=
 =?us-ascii?Q?oA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28484e79-473f-4c85-bd2e-08dda284fbdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 09:57:00.1138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z3GStWcr/ZUKSj8rbIxp01jv5p5uGq9WCVhEqR0uKp7HemCXKcWyZes3dcXt4xqk8cqH+AtN4gMjUOpxu6SYsNut78DfQQsARiw+Cg9NH5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9254
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Przemek Kitszel
> Sent: Friday, April 4, 2025 12:23 PM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: netdev@vger.kernel.org; Stanislav Fomichev <sdf@fomichev.me>; Kitszel=
,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net 5/6] iavf: sprinkle
> netdev_assert_locked() annotations
>=20
> Lockdep annotations help in general, but here it is extra good, as next c=
ommit
> will remove crit lock.
>=20
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  6 ++++++
>  drivers/net/ethernet/intel/iavf/iavf_main.c    | 10 ++++++++++
>  2 files changed, 16 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> index 288bb5b2e72e..03d86fe80ad9 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> @@ -4,6 +4,8 @@


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



