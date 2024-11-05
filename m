Return-Path: <netdev+bounces-141983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3039BCD2D
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F7F1F2230B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8F51D5AB2;
	Tue,  5 Nov 2024 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XdufCCO3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD261D5AB6;
	Tue,  5 Nov 2024 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730811473; cv=fail; b=gS4XGQ5vL6ZLQY55xqWMlGRGPkA9kcdaqv1E4+mTJdGyMe1z9jtYoa2I0lWNhMzF4LcjS7qVGluF4X5P8EDKRrNSoCvXY20LJyYjy6gKzqwVWCctncAOwyErVW+aFXrOuyeyN+78C1otMZ4mVAauvvHofWYGbLGm6lLX6t5K9I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730811473; c=relaxed/simple;
	bh=91mRhjIftVte1cWV473TIIge8GEKRmRL+BbZlqjDq9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h9XUtdBripT/+DNkMG9FOB6uQSQbt/HcfXbTGcwAp6UW7GPQslcMvil47lk1qdl2aY4BXDRDcZLM6spOZAaJS4J4N5pJjuwahMqgw/ZZk/W3mUq9BtD9EoKvJZI1D2GWNi6ZTAB3o4iycAxzzzLNfJ+DHlqeYbirWXr2ZVMRT4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XdufCCO3; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730811471; x=1762347471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=91mRhjIftVte1cWV473TIIge8GEKRmRL+BbZlqjDq9w=;
  b=XdufCCO36kivrm6f/1J/9pan0JYJRbgu3dJbqY85fx7gfaeTE9j0DiXa
   PaKYyUd3w394Sq1LDdWhFG4ZPh9KSyvlQJzxILNDVt0Xc6gWCUHKuW3Qv
   sjzEObZEDoYrEqPOjHpXWeqcCauOiGNwIQbfddzdbj6XO8FtA6imzFjbK
   h4jy4f2HLgFepSdGFMwpYQKpX4rjOtUIheKt3G1xiEEGTAY1IvvE9j0Qf
   MqdeORfMqXRroCtfXDXOSTcXwRbPjoPYeAoK3symUTequpHGw1QszN278
   s5EB+RiXGV0iXwPXxLvJsMEwmNf3/rLaLpRXYw6g2H100v5gw4Fs7N0Zf
   g==;
X-CSE-ConnectionGUID: hheTBaPLTWGEL6v+OtS/VA==
X-CSE-MsgGUID: oCV9XGiwQC6K+2cT43k4Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="41927511"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="41927511"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 04:57:51 -0800
X-CSE-ConnectionGUID: rZ2GpmSNQVGxVUKWeVKPMg==
X-CSE-MsgGUID: mEzn+AJOQcqE5xdD728xpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="83950979"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2024 04:57:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 04:57:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 5 Nov 2024 04:57:50 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 5 Nov 2024 04:57:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pq8dYsvMFz6/2W7sbzkBYV3Uwcwgqx3FdOceuaEwmSO6KPX6hCuTcoN2G4WZFwBRXOtGCf4tWusZA0asTn5SaSyDTxpzgIlTduCiCTGVvoPv3OJsOZgvr58d1iLiFOVlECzVKurbvKDxnt3kKAC3tmVLNvesAFStzwmPxP+49KRk+Cfam4piMibTBIoN5sYtlkjhBF17jfQYmkPQiRzj/10etsa3o4HoeeEyEndU7cXkImmla0JARDWpuFnrTIM1UTIwNKtopg8rll3nRbd/uifOBDU8tmwHZXFovR3HR9/E2edgqYFsmkgToC5p4QSUp9tOQdPTP4bFwTFgfdoUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rxe2rzl6fkhjaiKsY/DdYStc58TaCrIU1ooYttZXME=;
 b=BrMWlh7pOVSYpjB0r7gLtikjC/Zm+UIo0CkFhJXC80kFqIArdic7jEocbRp94qg5IZNSiv0GxYGeco9aS9K1OGf9OJBp4awPcy7NKifsaGTtPQZXTOUQfMPabXpCLriiReVHdr8269kgrtscoAeeuXYHi6ScThIwdpsPXREafjsG6MZ58JaUhN7W93zb4Fy04X7829M3YuR5Gh9E+wRKKnxzOIn5p3GYU4RBJOnvQBww2osFPtMQ7JkyVLUewpM5PY8YLp82CG6rQV1z5oMRBUXM7ITUjvGKfWkNs8Fec5bBtSFqOKm/hvN0cdeYRoicJEMvBWTxNEUwlyj6Ga1QGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH7PR11MB6979.namprd11.prod.outlook.com (2603:10b6:510:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 12:57:47 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 12:57:47 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Knitter, Konrad" <konrad.knitter@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Knitter, Konrad" <konrad.knitter@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1 2/3] devlink: add devl guard
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 2/3] devlink: add devl
 guard
Thread-Index: AQHbJTGsEuOtLlnL9k2+zX/gBgoDFbKouW2Q
Date: Tue, 5 Nov 2024 12:57:47 +0000
Message-ID: <CYYPR11MB842936AE2E3ADEBFF6F7CC35BD522@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20241023100702.12606-1-konrad.knitter@intel.com>
 <20241023100702.12606-3-konrad.knitter@intel.com>
In-Reply-To: <20241023100702.12606-3-konrad.knitter@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH7PR11MB6979:EE_
x-ms-office365-filtering-correlation-id: c1b5ef9a-5083-463d-78ba-08dcfd9972bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?HevcSm8wf7grKo+SMiaClzMs/GSivzCOptdXBnkpLG9FwOMFXdR88RmvwKWB?=
 =?us-ascii?Q?L1GQrp0wLdA+hJI8lUYLl7yIsszjId805R94Oxo/tZ7VH2Wyw0O3NQG92IB3?=
 =?us-ascii?Q?1Z7o1Dv4fHYV8mZa6DPXuHAPkCFitAojZ2O2S7pPf2EQB2ZtplZNhZo/UFXS?=
 =?us-ascii?Q?7FxlDjx95Ar9gXDO/1yZjT3KvWSTZIhmzO/5gkvghSu714Jl4hwlY4TCGMEQ?=
 =?us-ascii?Q?h6E5JxLyJaKWimM05mdNRyUJK7mJieguwZKRirzPMoBnDjKyBSZv4+I4w0QB?=
 =?us-ascii?Q?Dpa7pxNOyRjLmSBUcbJwjPIYo5u295F81OovZiAG5IVIoDVCD+cT6SzOmgM7?=
 =?us-ascii?Q?EsoCMviPKFKEkmhKZZk3X7tDN5MVeoD666QigDb2ndOIIL5VHgWweSkta/28?=
 =?us-ascii?Q?5E14WdyujfjDEMkBJ79BySpFpnri4AN3ota/WQOOS+PmfcKh6GaCQOBGxUI8?=
 =?us-ascii?Q?Db6P6ZGkTXEsG0Cuog2GymoHiRZ1d67juVi9noSI4nrG4Q6QQCt1fe91v85Y?=
 =?us-ascii?Q?UJ2ANuPF0Is1qM/VOTcfOjK3QN1qrwzxUjXIJgBn6mJe3W4VB7iyWfeHWosz?=
 =?us-ascii?Q?aqwZzQqwGoOUlt/3fHfjpgoQc4ftrBYcwelDklE0Y0O9SPr9lI12sqtgChOy?=
 =?us-ascii?Q?X2HMrwbzffusAu19ajiCow8xhzR2kikFaH5M55PT7ZMGW4GSS/ZmcGpYHmWC?=
 =?us-ascii?Q?u2RBh8mRDREV0JxJ3W4l0gvFVI+yOiFnbtnO+76oCYJ6TekIu3qhvrB2j3X+?=
 =?us-ascii?Q?452beu7FOJvy0rpUQ+b5n758nTjFtbVQ+sPuH70KSWoYI+tGJnQQvCMOMqrk?=
 =?us-ascii?Q?nn3PussThx1kA5mJUwFaT9Fq4nPLgpvdhmn2Y9E46ePD/oaXVazcZdSQ3qoe?=
 =?us-ascii?Q?s2qrRn2gqT2L5t7h6u97n+9lta0vcRH2BK6ga9elfK6MwoOufAG50Xj93E86?=
 =?us-ascii?Q?yf4oAIDu3mTeG5hNJSJxIwCbzcPoZ5XoVJPgbRmLc+5r6JT+Alja4ohnUc0k?=
 =?us-ascii?Q?A2Yd4rAYKvvJ1eeKBUrgWg02uUZwJqKkYScL82ZMdYWJega4w1DYIehl/iCL?=
 =?us-ascii?Q?HLxCS1eiJ0wo2SXFGhz5Bzp7w6DFVsSkEdZjaWxUEdNvureFEba84c4nCs+g?=
 =?us-ascii?Q?fr+INxrVKzC0XS854fgrUfM+/lzepvheJrwIGGX6bjYcYjFVH1iC3WDf25co?=
 =?us-ascii?Q?+hXl3ni3dB1/fOQdcEEO7BSkwwgxNbjsv+2v6HN9u/7a++HBhwzo7bZs+z4c?=
 =?us-ascii?Q?S4R1kAfs9C5iYj90LKeD4I78GgsWxUlFEgdCQOq9QKxcea0qXMW2aEdVp8MV?=
 =?us-ascii?Q?ivaYBfka177uGmLEJOS3oKUIMg0r+MOjm2mJ9a/CLYCHDGQ+CWlsTkB5YwDp?=
 =?us-ascii?Q?KWCvokk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Eg5GncLGJxEoQDZ+fz96uvOYi5dOPZX3Uag1DFlqf0q13MLxljOtxoxkuTX?=
 =?us-ascii?Q?ewfx1SYAjji0bbDI4yeio/AtyZYAKxO/bJUviTHNO4/SsZEWQ1zvt7xnerxC?=
 =?us-ascii?Q?aMG55mZvG6s7ugnuI2IINAbdybQ0oMhmFvj5jgcsgkSMiFY8Odtjf+jWjO8z?=
 =?us-ascii?Q?+hpmfq550eKilpnZ8u3/NCn/Jwjp0hCpYX9yKRJJ+rtBM+hT6dqgik7yuphL?=
 =?us-ascii?Q?u7fM8PFyloqfFVJt3sddQQVrBEmt1SV1HOcTNEDmU5Tdw2qC3ZTgbelu3mwY?=
 =?us-ascii?Q?7zv+RP4mOfD6HuZMF6J6af2TB/WZWCXi1wMkWwjkaE0VJztQklvDu/3LkDMW?=
 =?us-ascii?Q?vDZwU06zxnUqbYtaHE/9dkpq+xRNr4FsddD1gVG4YcrUtRwrfULWzNDJ7d/c?=
 =?us-ascii?Q?+UMEt3AJbSOUFIPJ5vVkOSI/c9AFUbkR46Q0ZZSG+eLecj2N3/PMb/7EkjOQ?=
 =?us-ascii?Q?aMuPiCV5uyxnkcQ2A4NEkqu+bRbKsbrn/cNBgNS+HxAJxrlQb5xa3jC/ZKLX?=
 =?us-ascii?Q?bXE6IK/OMswq3i/qsG5rTzAwH/DL69DFiQaNCIzg40QKauCmVXX9Ko9+ErkI?=
 =?us-ascii?Q?mdZJ90Qnwg+wJOjd788si8NYOTcLhwFFCdywr3qyhvqSuWTglgpzVw1c/0bX?=
 =?us-ascii?Q?IgrDUHyoF0yQKI+h4g9I6M+FbFOEsBEGCe90rYpFS3mp6Pbny6/8YWeJgxkf?=
 =?us-ascii?Q?ig/ZgQdTd8E0Rpt1sz1mrDl89ES17Lzr8TL1Jzg1sBhitJ1YlAHI/upNQI3s?=
 =?us-ascii?Q?ixHvfH3BnwkZ+OyqNefPK0IZns3uhf+vaBkjcJOwCSps8TlMUMErAsceil07?=
 =?us-ascii?Q?UvfuyL1wEu39iAG/8Mb+hRlYXvgDVm/yqXfnDm9USB5agLXA6zG+HUVfypmc?=
 =?us-ascii?Q?QxxQ+pEpcSS4DmYyKuGCBewKkJo+Ei8TDe2rDqK2C0EL7TQ25hlSoei/B4Nd?=
 =?us-ascii?Q?QZ28ZH6hC5iVzuMwo2wuOBUGbS3pFDNv1dCg19D1kIxNXo+Z2KmGtEk06UvQ?=
 =?us-ascii?Q?zBIxBoZFkx17rDmP/Qf3aFwsW1rXudIg/gDKtw5gCI06Ru6gtGBvyr8CZKIa?=
 =?us-ascii?Q?UBbyPWjCrU4Ybluw6An+Z6bkB6z5oGm+QR4KcLDPt2HFnhsq3C7BO3gju4Xl?=
 =?us-ascii?Q?PbYTc1Cnp3ZjD8lIY3rVSAUZENePFve/luZPpnf1lgdlrnvHSFfn0wI1A6m0?=
 =?us-ascii?Q?26lXfmbSzUTN13RXR5GjOKaJmStSc8PClsi/kdLkqWEs/eBmZRMZGLI0eeFM?=
 =?us-ascii?Q?LJl2fO4z81A2yqNHkHiZSKXPpqBtMWpj5pIBTcnBFX2bblzBDFAIxnwNGFe8?=
 =?us-ascii?Q?7Ul2ocdnJWhwiP6d6st6VTc8xQ9W67kvfY1801t5vQSiRlaAX7BWWxuyg2fA?=
 =?us-ascii?Q?1zd7tKp4iETV+BneeaQrrHYduALQT3YCoiOp/ot18zOOQhXfDf0/d0BLWvr+?=
 =?us-ascii?Q?3N/O1X9zip4jM7W2l18j2S9OiI0V5fCYU87a6RcAC5npXZiYqJbyf1TACNOJ?=
 =?us-ascii?Q?ZJFK3++id0Sb3+OBiyDVIdE2AN6Kb+PwLtqCmds2NmzCrdrZZYgoziAYknc7?=
 =?us-ascii?Q?Hx6qjapazrixFLJ6YpQI9PPcbzM0PSBQeHl6SIekQw++kgwQdFaE6kURHdNq?=
 =?us-ascii?Q?wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b5ef9a-5083-463d-78ba-08dcfd9972bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 12:57:47.6248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ze6yTEi2eA7ozfVjd6sonfYHTSKFClCWUS45b+5Ho8/KzwFx1nDecZqnNG7+6LUMyLrDbpkjeEemIo5XZn+Z0PGzEL106okzNHAX/SEwlScbIOiwt2QJPXaW2MoetKrA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6979
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
onrad Knitter
> Sent: 23 October 2024 15:37
> To: intel-wired-lan@lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; netdev@vger.kernel.org; j=
iri@resnulli.us; davem@davemloft.net; edumazet@google.com; kuba@kernel.org;=
 pabeni@redhat.com; linux-kernel@vger.kernel.org; Nguyen, Anthony L <anthon=
y.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; =
Knitter, Konrad <konrad.knitter@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 2/3] devlink: add devl guar=
d
>
> Add devl guard for scoped_guard().
>
> Example usage:
>
> scoped_guard(devl, priv_to_devlink(pf)) {
> err =3D init_devlink(pf);
> 	if (err)
> 		return err;
> }
>
> Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
> ---
>  include/net/devlink.h | 1 +
>  1 file changed, 1 insertion(+)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


