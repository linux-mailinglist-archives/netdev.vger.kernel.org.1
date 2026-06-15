Return-Path: <netdev+bounces-299445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HJMTA8LzL2oSJwUAu9opvQ
	(envelope-from <netdev+bounces-299445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:44:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DA96865C4
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:44:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="kc1e4/KF";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299445-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299445-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 971D83009CEB
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1543E63A1;
	Mon, 15 Jun 2026 12:44:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1D13E4C98
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:44:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527458; cv=fail; b=sU7fu8xPqVPm4nbGGL8v3BlcPlL414f6A60ISxeg8BdS0sBGeO0QwzTjDExx9GmXd3w8cPIbjEkpxhEsvaKPBA+98Okr8Esd/58HhZ7xRamrKXzbn2S8xf577XeDcwelaBYMHcXq/Fy4YOoR3oOYQMPlf33HaXzk4VcfNlLvkMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527458; c=relaxed/simple;
	bh=/EcTsluhdxUnSrXDbcVUTYSIbNG0QvULIa+bZHSLqnQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rLb2M0XkNeIKtmN3skE38bKVJdzd/tkq9zaW0Ap1GobMbD6K2qtXg0pmo1vrhORUHhGVQ8IsZAwx4xqWJ+6i+3kMMucJb6xeyWeiDirmZRS5bNv12EfPe9KtZzf81/T95QbIt+NuuNJFlQY6Yl2lSPqRHcc5mnWeQ/UahgpLq/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kc1e4/KF; arc=fail smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781527456; x=1813063456;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/EcTsluhdxUnSrXDbcVUTYSIbNG0QvULIa+bZHSLqnQ=;
  b=kc1e4/KF8Q/wb1JwBfagVhJuQ9rIDRz/3P763+3XPdLcpEnWidBNmomq
   Qu4cdJh9EoBfU1wsRWfZR1LhNlew2j/mUqpTFrZKnr8peVYL1HbToKcq4
   9WFKzCpzpXpUYPabLREG4U1a+01PQFuXbBgy9lL4V2WudARyeD0p+OGJI
   vrn5xWtVZYAgTcVGs5Dtp60HrIC8+ra8PniwsqN9IFf0e+TJNKFicLTNj
   Vkq4SlF9k7L9vEis6Pp8zWRzxHg9EGX4iJmXUdQS14KpxahhO8fo/fVqy
   d4GBBWlCO+D6yz7DX/0Zgx/Zmo/vEFOUcEnGlyrbXkJvfBAdNb/2ssehw
   A==;
X-CSE-ConnectionGUID: Fn1o7arLQKeoVw1bj9f1mg==
X-CSE-MsgGUID: zODRSPH0R4GMGFfVHyIH0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="69809128"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="69809128"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 05:44:16 -0700
X-CSE-ConnectionGUID: dy91CPCvQUWKVczrRCdCSw==
X-CSE-MsgGUID: t2/IyDUjTVm/H1lYuiET+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="252554163"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 05:44:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 05:44:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 05:44:15 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.35) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 05:44:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSseT65CIS1QpjlbV4PHvW9wOWEGzxlz9WgU+QJSfulH2QvfBIdCy3UqpLOF+NMK7SkK5R2NdQvw/XPuGF4+WwHJoEGHSmS1haB4Jd4+Im9Aah2FTst5/J6C3lJ6B9FJ4TXyBL7MGA63mBBJgsxzaKlm6GrorKxzaUOm1FZTZLKCwKwSsmg5W/CVzZ2OKfSm7DRuFqOdWsDMM8FvMTuesEcdXAXc75x/M85qqlHDv+4ByA2unrq7tmCdbwclPMcG86a4zTNpzpkgBuV4wAK94CGVgeUesOx48c/gI+VuVEts+DywjQpsljGwMI67GyuXMysDBafOz0jx0LDeO3ELWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncOql7FK79QYg1Q9k4vifZR+8V6pS3topHUk3Kq0ieE=;
 b=MBHs6die6KAfNnnE/RoxmswcPjzrED6meCAw4a0zEPg4MTqTOYQpmVTo0jT5NwkqMfYQ5aUKI8chc5hgfZO7NFduayVWFy0ag7detUD222i7HkrIZWkozr+bvkg09E42StS+jKiclu5BBPPWv/+v4sq2WTayiXsbsc2RWi3casn2FBnoiCSgPWm/yjuCeQ5/TVcN4Jn2YtmAYMwKD8W7pAXdrWd1CEaT7aKBH9dDOI1PU6dOha7F/o8K++RZaoB0lKDbV4ijalh7dnZonAEcOy8S2lxbdQPsFj6/kyQlg4xEUno8SgRWE+Of3krHi1HCBYBy3HpV3LXAenHR0wCkpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB8550.namprd11.prod.outlook.com (2603:10b6:510:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Mon, 15 Jun
 2026 12:44:12 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 12:44:12 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "mheib@redhat.com" <mheib@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>
Subject: RE: [Intel-wired-lan] [PATCH net-next] i40e: add devlink parameter
 for Flow Director ATR sample rate
Thread-Topic: [Intel-wired-lan] [PATCH net-next] i40e: add devlink parameter
 for Flow Director ATR sample rate
Thread-Index: AQHc/BiKt3OILqle7kyX0ePQEoZAbLY/kFrw
Date: Mon, 15 Jun 2026 12:44:12 +0000
Message-ID: <IA3PR11MB898693DDFB95EADF66C3813AE5E62@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260614161131.192068-1-mheib@redhat.com>
In-Reply-To: <20260614161131.192068-1-mheib@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB8550:EE_
x-ms-office365-filtering-correlation-id: a7df0348-d2f4-4447-eb2a-08decadbcd3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|38070700021|18002099003|22082099003|6133799003|56012099006|11063799006|3023799007;
x-microsoft-antispam-message-info: N7Wd0+LrjsYrQcxFaSt9Ax2NB3rlBaAWZUIbqdMVArwgxqbxI2Trcl4hAM8ZiBZHDP4kRgnRSMly9bQOKtqUBsjTAm8TXXQHlyFemMpUIPlO4/44WngcBBMM+EhQoD+gy85rhJO5EBqsCpK9MYs9DzKlcH6OirP0Iet5ufWBA05CtrHyzzce2RqOoiDXQXeGmNWPR12lLOvy3gELc5ba3s1jdn4xvgcXJwXwJa9rZJbYkpMekb8biB88uXrg0NRWIw+FeYAXU8ypPAmPOc/EbuPIBYvSiaDVh04zUw4wxDgRNRfjfrsJOntLCK/ZNFcZ7HfA1XzfkyWC8Xc9AJeLRLVmfwH69paTqt36L1rMO/GXqSJBwFBesMeFRsHqdkyfWQ1ByVILZQj2JrUgQ3N/4Si6/0jnAnHMQi+MLRqY0TqQVwoSNoi+F/7vYrPFiywTTNJKWGiZvmi02H3nPGwez7rWPYPdxHs+oB587lZ5rG9ifkKkUYKST+3tEI1Ftu/Hgi39ptE/iqMYaB7n0UIdoUPRmMI9J94m0l4Z4UVDSJCA3+Q0R1AhV94AUcY4jwESzdFf5dOpBE96isTIXCMsnl4kXKclumEY5k4NXU17uZ4k11c9GPkEKeELVeLwDkH4fudpwmhFAu9OBW6QicLsZtCiGLVK1jX7lPBUYiRABYjWWk3OVQ0ifOmQTNsS/+FwiV6OeWN8Rt5JtXw/BLAnfvPQUvldEmyDrFupgA3L+KwcRXg4YkNEkk+Sc6K0Whgr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bhMMQ6zR6Go/L3GbV/cYqoZyqa0miMLeMlGIuMPF2ctJAvSiPk0LpIv1vovd?=
 =?us-ascii?Q?VgXkLFItvSJ+82EHDKvbSnhF8pOhCNmG58dxwFMqdfdRjxzX08eoOBfraS7q?=
 =?us-ascii?Q?mzOo2ztTj01ZyrES2+6c5cV5QHt4Q/BtHjKnlXJbKmDTK61YyyQNvxcU+7Id?=
 =?us-ascii?Q?b8ff/OJv/NObeXisKU8+CrwjwtnDuYBbDO8zn930ALEEFLhdpNjeV0/JItJZ?=
 =?us-ascii?Q?Gzwwnj6hzrVkySebFI4GIRNWiE9XaDICr4cdGtG10OKtGNBzDcWwG3+GhM0u?=
 =?us-ascii?Q?ZfVWf8xEy8fpGl5AFZ5Kozooid1KGU5ZCezXOr+IW59Teo90XD8JvfJ3cq2E?=
 =?us-ascii?Q?nF23RiJiNccPSdCfp8cLgotNeH2BWqQNcLRb9tebMFk1Jv7yZHyOHH81kzGx?=
 =?us-ascii?Q?GEriD4D4qC2Dus85qibOZxyZM52aPk4A6wVY5ZVSQaBCcw63ONr3xUUKT01b?=
 =?us-ascii?Q?+YylhmMMwb4rjwoTfCHIKVvk6KVqf6146DcpfklRK1DdmWdKGQW8zAYxq54J?=
 =?us-ascii?Q?sqXnB4o08An/RboZsFzow+ddUnolVwZ9GND9v2n7m0kQgtxrRxjYWRS+TCQE?=
 =?us-ascii?Q?/+NkSF/LvC0FLbAULMsE0cYSdH7bbVfIPmxbpgZbbUdvTN4hGuCv4Lko2Sb7?=
 =?us-ascii?Q?Rxk7SLzb5VmEccJKejMF6Yre358CBkFNk4aGHd6767RSlJNi2pLiL6SncWTI?=
 =?us-ascii?Q?NAtJe5ogGRS0+OZ9M2C25LRokkOsDJP2c18+2eQxnGi543gCdVxFLZzWB/LM?=
 =?us-ascii?Q?/AtSf8RlJQ+1OfAf8knq4yeuHEV3dsFx0u9gq2oJf9XipTYxJVUF4o0DouQt?=
 =?us-ascii?Q?ZGQTJbzmnqQrnQVnai3x0mG5dp/QuaKcUT7bNOyNMsxGJIZrsHXC6tA+s5uI?=
 =?us-ascii?Q?GboJvlzjzBLRSo1ERWi6WEzXXalk9k6bACj/uOu/p4cUrXMAyGEqoWvvqYLM?=
 =?us-ascii?Q?IzJWOe2KuQ9wPoD8GJC+ULRuucVDM+X52ye9L3BhfHjLX+824AVfFpnS1340?=
 =?us-ascii?Q?ORV5uzidebPQbEIVs6bb/cGaLg9LNMZgckYXvMKPtlFugzspW3hKgc/G62sH?=
 =?us-ascii?Q?mMS1K3lzDSZFVMFhl4CFvcxlKCSmCwM+A1dkdlR9FmrW0P5CVhNjUqwRrBjQ?=
 =?us-ascii?Q?nkxfC7Ixf3b1dlCjNXwU2F8ZSRN4CsSmQdIM8lcXc8jRXl2fH4c0IAgk3PRa?=
 =?us-ascii?Q?XYzDyM7T78t8HGouHqhBWF+KVEgufS9X6eRwQy+veC4cliRn/mNDB0Bcbo6R?=
 =?us-ascii?Q?qQybAFaAdcu3rYqPbMnTeygksHdzbVQH2OPwlx+yz+A8P6KVfWHKOfxiotxb?=
 =?us-ascii?Q?kuu+wgeMMrQeEPRbILdNcJRfP98O9O2PxYYTXsDEXOF6w3WKzz4Vu6jWhE6H?=
 =?us-ascii?Q?NKej9cINMrTW1ENdTMSXurBAJT/FqNGdKRPZDKcsNWDi805d4XXQ7igsbYcS?=
 =?us-ascii?Q?ESECnbr4cSxWZVubQYAg0l8VOqeVmGOJe0bKDhJutGJuWoJ99Fduw2U12K8/?=
 =?us-ascii?Q?wVRcReeQ5WPMXqZcQtZG7hFqCzSARQhzeAEWbQ5Pr0XbKSy14nhyBf2SKY/G?=
 =?us-ascii?Q?pS/JtsNXlXPnk+EvVz5bOBglCQZpEZwuOdq5fCM7EcMhh61O6zN45Q9VY04g?=
 =?us-ascii?Q?5ZBimmw+VqawgxD1BbWaB6Gxod7i3aXSRKxQIV/J+5lG8KePI2v/u6CukHTs?=
 =?us-ascii?Q?RjoSGyBGhA6hLzzmHY+WCvgdQ9xU2kSPrx57NyISCWJrFCF8Tc3o3GvALVFx?=
 =?us-ascii?Q?/EBISjGzSsWa9sf6ob4EKLv82Lufmn0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Mo2SjV7kUGhAZAEcxpZrf3Tq5OYwhQCq/OU6kl26NbfuQAHcTXPGPXPuyurCnFPVgqsaPsaYBbF0nLDpM4fF6s0taJazcxIR0ou5+EPUpgs9uQkSEYa0BLduFRR12kdpWfzKmmEiWdejcj7LMIsiYsatMMkRbA07tcBRZomd3EvFleQYXfP62KjB60BKXg0vvXLhBYroLZ95J6v8WhdpoaxPTrEceYiCwxGZQKU2TPEaVz00ACRpgydbZB8dJcJvZGpwChk6v5PMfE30+DAbV3HLH3HCF1E1Dco4q2CXd5+atBHM+pgqWSBVTsBj1NJptT9Gv5/0TZtjCuKF8IDrJA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7df0348-d2f4-4447-eb2a-08decadbcd3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 12:44:12.2873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6X73cN/h+hju0+4LtIx+YZemirW74S/oEutLIwVUFoePzrfAl2WTJh/fptujz3oL4zuwmLlyDjFw5CKklGKJltD0UPj7Ii8uCJjdhV+0Oqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8550
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299445-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:mheib@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,osuosl.org:email,intel.com:dkim,intel.com:email,intel.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0DA96865C4



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of mheib@redhat.com
> Sent: Sunday, June 14, 2026 6:12 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; jiri@resnulli.us; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> horms@kernel.org; corbet@lwn.net; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch; Mohammad Heib
> <mheib@redhat.com>
> Subject: [Intel-wired-lan] [PATCH net-next] i40e: add devlink
> parameter for Flow Director ATR sample rate
>=20
> From: Mohammad Heib <mheib@redhat.com>
>=20
> The i40e driver uses Flow Director ATR to periodically update flow
> steering information for active TCP flows. The update frequency is
> currently controlled by I40E_DEFAULT_ATR_SAMPLE_RATE and is fixed at
> driver build time.
>=20
> On systems with a large number of queues and high-rate TCP workloads,
> the default sampling interval can result in frequent Flow Director
> reprogramming for long-lived flows.
>=20
> The amount of TCP packet reordering observed on some systems is
> sensitive to the ATR sampling interval. Increasing the interval
> reduces Flow Director programming activity and can significantly
> reduce the associated reordering.
>=20
> Since the optimal sampling interval depends on the workload and system
> configuration, a single fixed value is not suitable for all
> deployments.
>=20
> Add a devlink parameter to allow administrators to tune the ATR sample
> rate at runtime without rebuilding the driver or disabling ATR
> functionality entirely.
>=20
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> ---
>  Documentation/networking/devlink/i40e.rst     | 19 ++++++
>  drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
>  .../net/ethernet/intel/i40e/i40e_devlink.c    | 65
> +++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  4 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  4 +-
>  5 files changed, 90 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/networking/devlink/i40e.rst
> b/Documentation/networking/devlink/i40e.rst
> index 51c887f0dc83..704469aa9acf 100644
> --- a/Documentation/networking/devlink/i40e.rst
> +++ b/Documentation/networking/devlink/i40e.rst
> @@ -40,6 +40,25 @@ Parameters
>=20
>          The default value is ``0`` (internal calculation is used).
>=20

...

> +static int i40e_atr_sample_rate_set(struct devlink *devlink,
> +				    u32 id,
> +				    struct devlink_param_gset_ctx *ctx,
> +				    struct netlink_ext_ack *extack) {
> +	struct i40e_pf *pf =3D devlink_priv(devlink);
> +	struct i40e_vsi *vsi;
> +	u32 sample_rate =3D ctx->val.vu32;
> +	int i;
> +
> +	pf->atr_sample_rate =3D sample_rate;
> +
> +	if (!test_bit(I40E_FLAG_FD_ATR_ENA, pf->flags))
> +		return 0;
> +
> +	vsi =3D i40e_pf_get_main_vsi(pf);
> +	if (!vsi)
> +		return 0;
> +
> +	for (i =3D 0; i < vsi->num_queue_pairs; i++) {
> +		if (!vsi->tx_rings[i])
> +			continue;
I'm afraid devlink runtime callback holds NO rtnl_lock.
So if (!vsi->tx_rings[i]) can see not NULL while i40e_down() is running for=
 example.

> +		vsi->tx_rings[i]->atr_sample_rate =3D sample_rate;
> +		vsi->tx_rings[i]->atr_count =3D 0;
So UB is possible NULL dereference or UAF.


> +	}
> +
> +	return 0;
> +}
> +

...

>=20
>  	bool ring_active;		/* is ring online or not */
>  	bool arm_wb;		/* do something to arm write back */
> --
> 2.53.0


