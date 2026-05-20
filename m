Return-Path: <netdev+bounces-289931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFWpGvCoDWpr1AUAu9opvQ
	(envelope-from <netdev+bounces-289931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:28:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C842D58DA53
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 835E63018765
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2A73DBD64;
	Wed, 20 May 2026 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iK2x6ahi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2542E34DB7B;
	Wed, 20 May 2026 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279931; cv=fail; b=sESggWhxbC2SHGg0ETG+n+/yZUyKgSkLYyJ8T8gl3HVuH3+opy9BYfVYHFmGW37i8zvTOx0uicoWpGHO+PFeqxK7y/33mJul4J5qoqratVSMHC9PoEzssUn2sUmwTHOcUQDOtyCc4P6Zp0pMr9mYJeFZWrwQ9pQGX8Qg25TFV/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279931; c=relaxed/simple;
	bh=R0LCFVf2Grdwu3FgBq7NNBSR/wL5MjG1w/1dSWBfmj4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QCTZTB+pqKxs1HkKlwvTh0OoG1mW4IX7dwZbNQPRPISj/rzNCiZ46OyYK8/3FqH99W0zPTICW4fm0FWbsrBuKx07TRQrBLOm7N/lC65C+8ZDYY1eJhDF+Ig9itYfgS63+swu3cxYmlXqv9MxhPj2SnhVlWaRPy+uDKQ8/90nfXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iK2x6ahi; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779279929; x=1810815929;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R0LCFVf2Grdwu3FgBq7NNBSR/wL5MjG1w/1dSWBfmj4=;
  b=iK2x6ahiqYsaqIHRwKjOxanpZbkrkQSwgfiCTL9k+E63gvqamZaza5zI
   z1A0ppsdw06XGkPlxFzZCQgGBxO+DNL6L8gegXNpSFnAmFhlyUHhjtsVr
   LI0z88OqMnQTwx6diDji7gURDJMowjj5YVXSEGy7jixdN85NZ8vjI4yuv
   6Py5UyCGX5On0Ir+SKiAcsuttl+rxqPN321qgcmZhi8zqFP8vhHWS7VPl
   Myoujor/xL4jeHN20V+vs+edSfM54T4xtVTu8Nl8IITNJN1MPL6/RTn51
   tVZOQutILkA8btIvnNHZgFlDIWBEmuX5So1M96k2b3e195sPJ+i+Rwijj
   A==;
X-CSE-ConnectionGUID: 0R1DtGJMSH+/OG45B97uNg==
X-CSE-MsgGUID: EaNdjsaYS5iu+ZNerIQd1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="83791956"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="83791956"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 05:25:28 -0700
X-CSE-ConnectionGUID: guKDK7/3QmO1EqizWwIuxA==
X-CSE-MsgGUID: hCbdhmxsRlqtDKI5ng65gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="263958798"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 05:25:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 05:25:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 05:25:27 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.19) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 05:25:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkJPaKFg9GreV379Ndk4VdiRxkvX47BBVUCN7OtvtdrM2ZmLd1PVdjg1oNcCqV2yTA7mcWk+AFL1PW4C5ZJFJki/xK0BXweKlx24PuNjmYKOHv7o316JQpcgCvrS8Qt8uORozFKtXLTup3RqGd/8JADZeU32Ll2Tq1UunCYqwdktsBCWeINHyGEAm4F2ASKjAJTrcxT71IJ1m77d/m2fp7MllZ3a/jYDmWGvQLJWwD71M9v2nDDYiMGLc+Nj+JrShhsiIT8jEOoozKXfVR5DfrwaiHI3W2pkA+8jaYR8L4ouwPRGD7V2Jl3YGE3JYxEkuOaZhep+QBClByf+4+8GCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkJesEG0J13k8iYlC8s89aDcuR3GOU8DtOSloZYc/ww=;
 b=V7l1/OdLWh39nhcE6eosA6yeR79OpSwWYuMK18fDiqQJJ5f5NgBx4OzjHkj9/1gTmOEQjNd3l7HAQhsM9seQX7rGsIZAEMeGiXye0hVmGocdGKufXAmSdkhGtQeuLzqvLeRBjBAk/qDgs9gUu5ruqS0OqwLPYXeuWYyLf7tnt9pTxsWjPZQfDSl7LSOz+ZswwU/8zB6P9nuARsnitIe4+fUalfOyIArOrmMgb+p4BOB4sWI1dk2oAd6MPoSr2BRKH3bd00l3dqbnne+4kIbkWfHcsuwM2Pga2252gUeAM5FAv6wHBj/GSeVuOJX0yKKUhusGuEpHeOl52FeFrc1jDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CO1PR11MB5138.namprd11.prod.outlook.com (2603:10b6:303:94::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 12:25:18 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 12:25:18 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Vecera, Ivan" <ivecera@redhat.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "kuba@kernel.org" <kuba@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "edumazet@google.com"
	<edumazet@google.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "horms@kernel.org" <horms@kernel.org>,
	"Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH v10 net-next 8/8] ice: implement E825 TX
 ref clock control and TXC hardware sync status
Thread-Topic: [Intel-wired-lan] [PATCH v10 net-next 8/8] ice: implement E825
 TX ref clock control and TXC hardware sync status
Thread-Index: AQHc6D43oDbRyoTzxECU8pzV+VRhFLYW1pEQ
Date: Wed, 20 May 2026 12:25:17 +0000
Message-ID: <IA3PR11MB8986654A0580BB728596FDCDE5012@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260520094618.3934384-1-grzegorz.nitka@intel.com>
In-Reply-To: <20260520094618.3934384-1-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CO1PR11MB5138:EE_
x-ms-office365-filtering-correlation-id: b896e14f-4cb1-4320-5856-08deb66ada62
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|11063799006|22082099003|56012099003|18002099003|3023799007|38070700021;
x-microsoft-antispam-message-info: 0JsVEp3TRup4ho6rGSWB7RZvia5/6b8ErtNQS1XHzUQveYPj3G7OS403JTWtUY8nlQey1BoU4Wa4HhR5WpGkPu44pOa73T5UWbmSp3pGBwwOxMrcqY2FQpLEiCS3lBrxzrzLeJZofMP90v2AVjTHxOzPlvVvqaF22ajoe2JpylDEo1S3XkfWnjQFKA9+0RPs92IM9Qk+kSMvbrawID3ExPnXHappjq2kOG0fEjiaGcH963Y0u3cnMH+AM5fWkR86S2yEM8DdXuE+35S4DUiUHpYyDY8LCQH9zEK1W+QcTCARZL/tte7M6cqMuL5UFavdgoMbk/bvbLxi7a6nIKo9uKTjSSEKdqkWBSgY+TLXXIL9nN3UoXqMJmEwG5xxMoc5Z1xle+ZYaYL5ffucut/DSnHBtcgfzv/G44QwyqTMB4fLBCmO9EnGTAkEiOG1ed4UiUBi0g/stvPSBZaXJjYlagHQ7tnd/hAPIR+3BKwcfl1paM9l0d3CBcb2zjwsnqulTPGp7JeiTXMHWF72cVWhRQIrdE2EQlIqyNBK0Afujb+ZBAPrbQYcij1PBSsDWkbtltsnJPtZqkZ66sAIIMrGj7Xye4W96w2AhK/pm6TQ5OInKLWeQolSmQJ6wkwsWbiP5gT7Gn7OebciTIlfgBxgrcKZxUN2N75ihFIOWa8tA9DW6m5v9H5a1gFjBKwvR/kw8x/S+ZDovIVANip2SX4kVydB/Nh+hpT3PTkg746vfS3Uzi5aeMIHP3DozHL1yrYI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(11063799006)(22082099003)(56012099003)(18002099003)(3023799007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fjmDR83aI1OOvsDXJITkaWs4BwbdMyzeuNeY6oRl4r9vyW0N4Po+YwaGKLhy?=
 =?us-ascii?Q?pPhYlyrsvtztTob403p27g3Jklxf9fVrCQyxcVyH2Nl6DjP1+urjVw05vZpX?=
 =?us-ascii?Q?NLeHT8pqxaKtcDrYPwBb7kAJoZG/YD6zTX5oCv6UljSN4m6X0NxL3UGd5G1Z?=
 =?us-ascii?Q?c4qmyZmZOnGjJFUji+f1Qiu7T2ihLouMHp2sYMkPaiEFZvWoWJXJ/dda/6qQ?=
 =?us-ascii?Q?G4+8KkaA5nXtls5upG3959lEi3zwSY2W5sHEz/6a5gLnpnkNRnpZwRCRez8M?=
 =?us-ascii?Q?OGliInnAJZ5BfPUU7vqEmyW9xk7XKE78QA9R6QWMPF457ArokYntyI6WEUP+?=
 =?us-ascii?Q?FkFuF+tIqHBFlZ3Oaj/ElZuxrgsLtH7EPQoQRMVpjdGv5urEn8CRFJG89X9P?=
 =?us-ascii?Q?jAGJLgxQDJuhC+80xKuEmfBSduGRKxw02Gi4fB94CS6JyVaO0MGnyl7G3b0k?=
 =?us-ascii?Q?1nQKSQw3ETzaMGYd1/5eyejID38u6bPvCtwFAGNC4PYtIZM9Bme2NAqyp0kh?=
 =?us-ascii?Q?59p0GX469HpaptdlKcLNpnUlqgIP48vNenr3OuGdo4oZJ8UdVC5x/UsMZIup?=
 =?us-ascii?Q?onHs8TPkYgPYaSSalYmEEvHKvidjJWlZEfeI9oefvFIkSkpKPPWgq+cjvxwG?=
 =?us-ascii?Q?plOVaTAyThtxlK6xjUkVAzTzS4Mnel0A+qvwY+f7FI3ZmrkDttOT4vQ3pR1M?=
 =?us-ascii?Q?+uqrM5lzioCBH3vpUvXGDn+rdsgc7p8jz9sPINi9QqMMVejsXv7cFMeDMYwU?=
 =?us-ascii?Q?zrmjls9/Ea9B916oC79oyvh/XEcf+RpCcNtbLt3lVz6BdutpbJ46SGJL0Aa8?=
 =?us-ascii?Q?1GsPdr9hbdafV/L98eWsoUlrjIy3ommRlGRnRoAJ46PBsrXLFRMDklBn5P8V?=
 =?us-ascii?Q?TjoEyG+CZAbENKi5eCeNO0qGrewN5cSQzHS+Ge/MnQc4kbsGYxYtdmd+C1Gn?=
 =?us-ascii?Q?j7sk7mv9Sl5B8PbRmUx2Cu+aaGD7idHc3TTvOugaae5dZ0GTmw5GAlhd5+9M?=
 =?us-ascii?Q?1H5bbujVHOqRhXm79Rphls4cQ6zO48G0CZmdNdHD6KOfr8Q7N5jh6Buj+a8I?=
 =?us-ascii?Q?kYm+rlHzaRzX1RjJ0MFyno3vPdV7P1VO15bSRAlZ4Fm5HF3fD3lYEfiYHz+K?=
 =?us-ascii?Q?Vs0nVHfH5VTLR4VXrHr2i5pdcHuFrDcEPbEeZ7PzsNHOLCaYQAN7oIuCrMWp?=
 =?us-ascii?Q?07LraSn7+IRgkmu3mde/tAbq6Sa4MtfBz+dKANGD+pDsKsFwoc7vsD4BzgWS?=
 =?us-ascii?Q?At8Fxu2p32rJx2eiXqypxHLm1aJ1aG71+JTWHKqFIfL/NPwZppndi5RUBW8g?=
 =?us-ascii?Q?FYwGuuiI6LNaK5CSLYAGCZ7D3qQi4HPMopiGHpq7vjeD4ybP8T/448acznB1?=
 =?us-ascii?Q?Le50NSAL9gUk7GGJ+vBVp6tgIPDmDMyfbBqbchsy2pcL3QnlbMMncsgwRvO6?=
 =?us-ascii?Q?JO4VFsgHeG/004D5Jdt1z/qCOBf1ixVOmog545ab/qMajYb6ZGrTGUFmJKjy?=
 =?us-ascii?Q?wOxtDk3oooNynR8eSZrqApf6ovt5LwOJ8ElkAdi1QJtm6AULobacZan92dup?=
 =?us-ascii?Q?9KHV8oppqzwQH+qYPH+cgvQD+v86rV3pcThhj87fgIbZwSo2ziemCRE+xmxB?=
 =?us-ascii?Q?aChFa9gdEBg5R3shpAvdMTgh/wcnFR4+FbiKRfolVfQEgly5oeNZIiEebmXk?=
 =?us-ascii?Q?276V4hX/7EtgjrAOjXJR4Fg9JegljvaoWqRRQW+SMOkVOndxQircAvll2w8C?=
 =?us-ascii?Q?aLLyhKey5s5gWbs+DNcbVS+wMcpAX8Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: axzBCnxZ/toiNeWu9Y16XpY8p5fEXThRU1haNGJIu6PvP+0pQoiYWjBkeZ6tbnvk9xN8net9QgpJhlGuTWAw1VmRt8KEJLUBfMNuGQSxFE/rsBPMmgKNlsnVfwP9XNi2aw6LeM+otzKpt8/qGh2eF7fQR/l7UCHJ9K9FR63u/slbpef/6lwC8m5NsT1gjAJnooRG9D7nRY2kWkEeI2uHKavpLTcshzK3T1+IOaiK1N/PrJftqs7QtmjKjh/PZ6vtOPkHbJkzIOa8qmlBaV0cM1nnQRAz7IVzdMFbfjExU2xn8CtidzMLgmAqTFzfzLDrQLz2DBjdEusneFAy8ZMQfw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b896e14f-4cb1-4320-5856-08deb66ada62
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 12:25:17.9284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h0gXlEtctnjVd80bFAwDKo+/7YJBqwTMm0RlLSY6Wy7rbFlHS++2KtcYtxZ41ROlTyOGEoEwDYZpL1VDMfhoDzh5foVtk8Mir5lEO4Somfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5138
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289931-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.dev,kernel.org,resnulli.us,google.com,intel.com,gmail.com,vger.kernel.org,lunn.ch,lists.osuosl.org,microchip.com,davemloft.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C842D58DA53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Grzegorz Nitka
> Sent: Wednesday, May 20, 2026 11:46 AM
> To: netdev@vger.kernel.org
> Cc: Vecera, Ivan <ivecera@redhat.com>; vadim.fedorenko@linux.dev;
> kuba@kernel.org; jiri@resnulli.us; edumazet@google.com; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; richardcochran@gmail.com;
> donald.hunter@gmail.com; linux-kernel@vger.kernel.org; Kubalewski,
> Arkadiusz <arkadiusz.kubalewski@intel.com>; andrew+netdev@lunn.ch;
> intel-wired-lan@lists.osuosl.org; horms@kernel.org;
> Prathosh.Satish@microchip.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; pabeni@redhat.com; davem@davemloft.net
> Subject: [Intel-wired-lan] [PATCH v10 net-next 8/8] ice: implement
> E825 TX ref clock control and TXC hardware sync status
>=20
> Build on the previously introduced TXC DPLL framework and implement
> full TX reference clock control and hardware-backed synchronization
> status reporting for E825 devices.
>=20
> E825 firmware may accept or override TX reference clock requests based
> on device-wide routing constraints and link conditions. Because the
> final selection becomes visible only after a link-up event, the driver
> splits the observation into two complementary signals:
>=20
>   - TXCLK pin state reflects the requested TX reference clock
>     (pf->ptp.port.tx_clk_req). After a link-up, the value is
> reconciled
>     against the SERDES reference selector by
>     ice_txclk_update_and_notify(); if firmware or auto-negotiation
>     selected a different clock, tx_clk_req is overwritten so that pin
>     state converges to the actual hardware selection.
>=20
>   - TXC DPLL lock status reflects hardware synchronization:
>       * LOCKED   when an external TX reference is in use
>       * UNLOCKED when falling back to ENET/TXCO, or when a requested
>         external reference has not (yet) been accepted by hardware.
>=20
> Userspace observing only pin state therefore sees user intent, while
> lock status is the authoritative indicator of whether the requested
> clock is actually selected and synchronizing. This matches the DPLL
> subsystem model where pin state describes topology and device lock
> status describes signal quality.
>=20
> TX reference selection topology:
>   - External references (SYNCE, EREF0) are represented as TXCLK pins
>   - The internal ENET/TXCO clock has no pin representation; when
>     selected, all TXCLK pins are reported DISCONNECTED
>=20
> With this change, TX reference clocks on E825 devices can be reliably
> selected, observed via standard DPLL interfaces, and monitored for
> effective synchronization through TXC DPLL lock status.
>=20
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile     |   2 +-
>  drivers/net/ethernet/intel/ice/ice.h        |  12 +
>  drivers/net/ethernet/intel/ice/ice_dpll.c   | 172 ++++++++++-
>  drivers/net/ethernet/intel/ice/ice_dpll.h   |  30 +-
>  drivers/net/ethernet/intel/ice/ice_ptp.c    |  37 ++-
>  drivers/net/ethernet/intel/ice/ice_ptp.h    |   7 +
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c |  37 +++
> drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  10 +
> drivers/net/ethernet/intel/ice/ice_txclk.c  | 320 ++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_txclk.h  |  40 +++
>  10 files changed, 647 insertions(+), 20 deletions(-)  create mode
> 100644 drivers/net/ethernet/intel/ice/ice_txclk.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.h
>=20
> diff --git a/drivers/net/ethernet/intel/ice/Makefile
> b/drivers/net/ethernet/intel/ice/Makefile
> index 38db476ab2ec..95fd0c49800f 100644
> --- a/drivers/net/ethernet/intel/ice/Makefile
> +++ b/drivers/net/ethernet/intel/ice/Makefile
> @@ -54,7 +54,7 @@ ice-$(CONFIG_PCI_IOV) +=3D	\
>  	ice_vf_mbx.o		\
>  	ice_vf_vsi_vlan_ops.o	\
>  	ice_vf_lib.o
> -ice-$(CONFIG_PTP_1588_CLOCK) +=3D ice_ptp.o ice_ptp_hw.o ice_dpll.o
> ice_tspll.o ice_cpi.o
> +ice-$(CONFIG_PTP_1588_CLOCK) +=3D ice_ptp.o ice_ptp_hw.o ice_dpll.o
> +ice_tspll.o ice_cpi.o ice_txclk.o
>  ice-$(CONFIG_DCB) +=3D ice_dcb.o ice_dcb_nl.o ice_dcb_lib.o
>  ice-$(CONFIG_RFS_ACCEL) +=3D ice_arfs.o
>  ice-$(CONFIG_XDP_SOCKETS) +=3D ice_xsk.o
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index 725b130dd3a2..f72bb1aa4067 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -1155,4 +1155,16 @@ static inline struct ice_hw
> *ice_get_primary_hw(struct ice_pf *pf)
>  	else
>  		return &pf->adapter->ctrl_pf->hw;
>  }

...

>=20
>  enum ice_ptp_tx_interrupt {
> @@ -236,6 +240,7 @@ struct ice_ptp_pin_desc {
>   * @info: structure defining PTP hardware capabilities
>   * @clock: pointer to registered PTP clock device
>   * @tstamp_config: hardware timestamping configuration
> + * @tx_refclks: bitmaps table to store the information about TX
> + reference clocks
>   * @reset_time: kernel time after clock stop on reset
>   * @tx_hwtstamp_good: number of completed Tx timestamp requests
>   * @tx_hwtstamp_skipped: number of Tx time stamp requests skipped @@
> -261,6 +266,8 @@ struct ice_ptp {
>  	struct ptp_clock_info info;
>  	struct ptp_clock *clock;
>  	struct kernel_hwtstamp_config tstamp_config;
> +#define ICE_E825_MAX_PHYS 2
Duplicate #define ICE_E825_MAX_PHYS, previous one in patch 6/8 ice_type.h:

> +	unsigned long tx_refclks[ICE_E825_MAX_PHYS][ICE_REF_CLK_MAX];
>  	u64 reset_time;
>  	u64 tx_hwtstamp_good;
>  	u32 tx_hwtstamp_skipped;
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 24fb7a3e14d6..f7f82aef9f40 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -486,6 +486,43 @@ static int ice_read_phy_eth56g(struct ice_hw *hw,
> u8 port, u32 addr, u32 *val)
>  	return err;
>  }
>=20

...

> /* _ICE_TXCLK_H_ */
> --
> 2.39.3


