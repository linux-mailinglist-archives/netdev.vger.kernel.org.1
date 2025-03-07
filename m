Return-Path: <netdev+bounces-172944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A372A5692A
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4704F189332B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49BC219EB8;
	Fri,  7 Mar 2025 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkYn0y7/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C2BEBE
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355003; cv=fail; b=qXGaj53LX5lxpOzmhjxTxJH9bLCkqT++/LMpyQwT6NRZlfVKIaNn0/9M5lW3L52PJG8HbINtE4OP2wpruat0y/fhue4wb+kTp+I8mEzTBV7fOCTnDtAkW9noUPasG1Ffmt5OK3ypic/uB7g1XDsCHNpO21pp+OBEwXyAbpWjQzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355003; c=relaxed/simple;
	bh=0CazqDsOJ/glYypH+WMF5bOAngA1hZVyCeNxDnclaBE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O+4dXNZMBu1HJYImtL/FgKBNr5te8ibcOLC9z099ZK4dM186iFmpW1RzKgAjeTiS0wpD4w34LDzqGvEC3ty8mPy4UZVWHO88uL02VMSpyri9/WDDjGLN85I59cjM5HsKlrlGqKjMvgTNJOMPVnsUtIl3/J9YIFKGHcZ1H53GZTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkYn0y7/; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741355003; x=1772891003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0CazqDsOJ/glYypH+WMF5bOAngA1hZVyCeNxDnclaBE=;
  b=IkYn0y7/dmp2JICXjTm4ojNgggGDxYS+tqulK/JD4ukEygRKJ7X3+rb2
   rSOh/p55hL04a3i6pEXbbN1Im9wgIXbSyzTrNZvQrQIhYLaAmzdFBfD4O
   WCRnzw72U6ErHZEc6qjjHWPoZ7Ude418kp9jagaQ4f4wPnDrUkTnX0o1a
   YIrxPfVwS+0LeTliFsU9TRdt/CLdwi48MiqNSUUS8wulj7JllIn2yALH9
   SYtGgTQVwN8XJqcM6bG5I2jOQaV+6QPhWoFcPstivLqANFBFXaocEyAvs
   RnQEjEAGl7gz2EWnIuC1akpg/6i4E0CJYGBPjs7qUNWTiTN0UyT96mSKg
   Q==;
X-CSE-ConnectionGUID: wBOSOToESQyGmccgdrgwJg==
X-CSE-MsgGUID: T9D0a5laQJSSaKSXa5D6fQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42437743"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42437743"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 05:43:21 -0800
X-CSE-ConnectionGUID: fQlxr4YBQJeU6TnZnTanWg==
X-CSE-MsgGUID: rWiUHdOQS+yIeDUJcXja1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="120018116"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2025 05:43:21 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Mar 2025 05:43:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 05:43:20 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 05:43:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6ulNXPZT+Fwb/2eSpifiPDKIYBgVQ2ezbY/Hezg+r/NDCCzq54NMwpOlpkE+NBeK7Ng2XsizjzAPPJ1y2nhwlpr2h3nRyAnztr6MeWojDOR+a1/20msfG9ka97PkCmTCsc4O5GPKiDSxypnF2oZfnBqnxaXCGkzZiuBxwVJUK/3DaNr22cCjL9dZJQuwmO8lYFPerB4MAU9fdt0h6dVW4fiX9r0RvejGfDEPILECz5PEGyp1iihAR7nmyh/pAEsgopKNmte+ce26U8h5TAYyRr7dSoBWvd5suc6DEge3n6o3svj9JeEgvXLgEC30Bazh8tp473E26ladVW4Q2OkoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7t1tDu0mD9FMYQ5Aud3IOs/e+OZc7U3R8eqzapwJf0=;
 b=xw+ordSGHftvY9ATR22dhxGQC1dCAj6J/lLtTwSArSDaeSarKJJEb1KpyNi4IHTkb9CI6CfVOKix+By0kUB9KBT+9o21P4PY3R8rsS9mMQuC86033DDMsBSeqlSZzi04r/WHRc4FI7EfI3IdeLGRoG/Smg2xaROAQ/CiEE1T2neupIwbAe5tKAKCcBGaEZ1GMzeFf23yYvZTXnHcpBeVGPDvIIT2wqM+1v3iek+EaiONrCagIuSx340LshYwxJkPPg6q1TQJxrN2lI7fFfcmk4pjsz5HuSWDUSOoLpirv6NwwvhKLcSUvq2i0UtOXhdo5cNDuEzp0yPQErkYpPr82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14)
 by DS0PR11MB6496.namprd11.prod.outlook.com (2603:10b6:8:c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.28; Fri, 7 Mar
 2025 13:42:58 +0000
Received: from MW3PR11MB4681.namprd11.prod.outlook.com
 ([fe80::6561:fd02:e89d:5b06]) by MW3PR11MB4681.namprd11.prod.outlook.com
 ([fe80::6561:fd02:e89d:5b06%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 13:42:58 +0000
From: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Keller, Jacob E" <jacob.e.keller@intel.com>, Jakub
 Kicinski <kuba@kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"Schmidt, Michal" <mschmidt@redhat.com>
Subject: RE: [PATCH iwl-next] ice: use DSN instead of PCI BDF for ice_adapter
 index
Thread-Topic: [PATCH iwl-next] ice: use DSN instead of PCI BDF for ice_adapter
 index
Thread-Index: AQHbjtx1432CfXVtpEiz0d1uffDV47NnniAAgAAG/GA=
Date: Fri, 7 Mar 2025 13:42:58 +0000
Message-ID: <MW3PR11MB4681A62C71659C430281A15680D52@MW3PR11MB4681.namprd11.prod.outlook.com>
References: <20250306211159.3697-2-przemyslaw.kitszel@intel.com>
 <pcmfqg3b5wg4cyzzjrpw23c6dwan62567vakbgnmto3khbwysk@dloxz3hqifdf>
In-Reply-To: <pcmfqg3b5wg4cyzzjrpw23c6dwan62567vakbgnmto3khbwysk@dloxz3hqifdf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4681:EE_|DS0PR11MB6496:EE_
x-ms-office365-filtering-correlation-id: e7572e4e-042b-46b9-75d9-08dd5d7df8dd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mwpZQlufpZ3FmlYUPgZ7UNz6ATneLMGeGfn3jjXWQmz8BxtS/CJNbDRhBR9d?=
 =?us-ascii?Q?uZOgw6ZvBz3gvIRvLF56bOIRySxvlasSFZtd/fgJrwuh4ucdZkkO2utMFWbr?=
 =?us-ascii?Q?FAzKQK1k+Bi+3ciLmUBIXHC8i8dve3/yIsWiRcG7aKdXKBNGo26I1YKe+J4U?=
 =?us-ascii?Q?Tuj6jAb9rv5kTp0G0OGxWWJ/ve/dtPZ4ZWSCd/+aj+SZmM7P5P7TCvVpHkrX?=
 =?us-ascii?Q?L2Mo2T0KBVLbX/mmEYx0BzwBmPE3Yhqv1HVRBYpOeYUkwTlPDjAP4A7e2X5z?=
 =?us-ascii?Q?izVy8wC4ZAulBTHHFZqpxTFKPmjrqt8qtu1pF7ZYbQGzLoP7Fj64SQK1XyUB?=
 =?us-ascii?Q?JiqjMNXFKIYnLStZEGgDYftIj8dzNCXP/QiKm94xtKOH0gbfXYjwbsHN7NyJ?=
 =?us-ascii?Q?kmQED2oFvCdFf8VEI8rMpzMdSsTYz77G/3BqPtTUvW6pNzGfXbyBw3Vx8ohF?=
 =?us-ascii?Q?NPnfNwqY7R+NfPDyAMjxDU9Lw+vpePtUE1DoAuGq9MTTfpJ0Zr8befktQlDj?=
 =?us-ascii?Q?P8BZlOg+6ZUbmCa35OTSatELkb9qMJv/Dhk7gCaWUuVD7poTtt2j9GVpJZk2?=
 =?us-ascii?Q?uEpXlKyxuwo9XlssWtxvQkVVf/L1GcVB2jcXqLPKfx+uAXDXctGLJocDbhyC?=
 =?us-ascii?Q?fF/XVQmnxV15TqJal+ofxPklPzOAc+mzYHT/AlIwGMXcQQsUlV3CeSJb7BD5?=
 =?us-ascii?Q?7cENG/RlyUzqt5I0mg/ArGLzUAHJ46OX7N/jqRRhwmZmsV7j9W0NioOCKhPa?=
 =?us-ascii?Q?RyK40vsgsJdTwhNTa8Nxou7vjFbvhxVnM6A79E4QyCF21qhBU/fFGgDXqMxz?=
 =?us-ascii?Q?O1xaZqXfaDby7p4JajaXGl+fJHDabYkcdyco+9shfpaVY+YrViN63yCtB18e?=
 =?us-ascii?Q?AkKnFGU6ZWRoIq+bzIIZjAA7NAmGXJWTet/OCID9uC17CrZu2K403xRWHS3d?=
 =?us-ascii?Q?/kYQ7h0gvZ3R4Iw+yd3vevHFXe+GaAQQeBmJ+c96Lwj38wB+nG5Tvx9A2FCH?=
 =?us-ascii?Q?h0+ygwmfFoT2XJ2lqqtCV+wBam6SKl6/qFLPaxEgFKt7Qd1NkSJgHZtCR5GI?=
 =?us-ascii?Q?sWHaqKo5neZm1/H12ULj1hqQQKE2RdR6GPdziKdQu/hAYPBoy94E+Q2fKAvb?=
 =?us-ascii?Q?MIplkEZTQgxrW8cpQ8+d2oUqrQn+5S7f++ulAdDqAGTmXMmNXt0enia+H1lH?=
 =?us-ascii?Q?aZTHBy9aYvQDPx1vuVro+xXTvHzAHLYHmoX06hTLCKU6vrjuVt+8cHGY1f/5?=
 =?us-ascii?Q?sjPLkgrNx8wg5/H+KJfj4Mace0WSvWjJyspSpRnqTmnHu6e5ArIg67MBSBVP?=
 =?us-ascii?Q?oUt2RUhvWnqzij831GBjNT+WrfYo6pxf47VxBJB6S58JlwkAaLOqShrv/F3H?=
 =?us-ascii?Q?eXP62wDVhFtsMC50b8QVqtXL/cj53tBR3u22pyE+TxNI/iswkHUAcgutBFJx?=
 =?us-ascii?Q?pWGCyP4DSmhTkFOlDk7DQLA7giEqgBBS?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4681.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ud+vLGXES7MNJa5UzF4UeRjQcxsrXGnpHEpCOyqLYKdCkLTVnK6E36ZuYQKR?=
 =?us-ascii?Q?E6xZG5Y43hTgSVEENCQznzTApGTyImto2SAXlIiHgU/m1blV8INvY6gnix9P?=
 =?us-ascii?Q?deZbjOEMyCIpQ/Az+FTs4lRubf1UFm6XyHae8gyxrcPK+1+5kv9hY03obzQW?=
 =?us-ascii?Q?3QBceJceaX6vY2k7Pj8oCdr2GS2uo9AHb4DIa+CObA7eiOvOwoRINSG8p1QQ?=
 =?us-ascii?Q?CVSv83tpbq7U0KHZ/AlEqCwMVEnaVgdAv/6/jM7JlusmY1UP8CzTN861zEP7?=
 =?us-ascii?Q?VTehYDzePkRYIhAOg3fL7JvEbskE64/4pK4e6dCQTc//AIOHwHk1tpljniIW?=
 =?us-ascii?Q?48aVo7xkIAtntV5rK5+Wqfdlvp2eqlrYMNLc/uBecZqEYYOFzJNqSL3hS+9o?=
 =?us-ascii?Q?TheSLufPvzMW25jFrZ3lGGFowvlr1ItVUBXM2QWfyGsFliXwAA6VLaj5hcj8?=
 =?us-ascii?Q?ttMsCIiZYD/O4f0i/3b48k7m2YMPHE/eZoRhl1QIfQ7H+GPMUA/MJTQiEoeN?=
 =?us-ascii?Q?IjCg9djgbSLI8/u0bh1IMy1nboY+Vdi5gP6LR+UYb+oV2WW4koEZS3aFnbsv?=
 =?us-ascii?Q?EKUF2O3h7X2q/ZCPPPakAIY90agTSSoHaMN946QKCIaOuC7Muxi5qO2QJlFL?=
 =?us-ascii?Q?sF0NYlrebjwB1sjNGQ0xczS60xyhmt42AQKL7kyj5au4EpBHa/hHiwlHfYSB?=
 =?us-ascii?Q?7A/lwKL4Jd11ynWR5yuwBJ/qE3T2KkrxF6/5CHFRa81DdlKfxfNd9awF7oXx?=
 =?us-ascii?Q?hfi86IxlWYybRtsg9BEkKVqsI7bTkCIUfcuouZ+Um+tLB/HuVrEouvWezbhe?=
 =?us-ascii?Q?8XzMqJKkIU/TPHCCzAeIT7VgCH1rFKoVfzv4bP4EWc6lrZKDn1fXqDC1x+bv?=
 =?us-ascii?Q?KGrYV8Y18s5uPl2hSGgoHbEvwe56fjQae4loeXWuzw9GZtGlnGoMVFZV0+5x?=
 =?us-ascii?Q?vCZR5BR3VD1VdU+M84aZexPf8IPF7w6Gz4VEQ33rQMqbTWm26nnWftLz9Njh?=
 =?us-ascii?Q?NpglgZJAAEVsLAFYadzfjWQ9db4By3aO24Irz3HGvhaxevk7bcShqFatYT9F?=
 =?us-ascii?Q?NX4rHsFYJLXmDSeI383To1AHJELxh+OBIas3hM95MUKWVsnayX3kCbVns+Tf?=
 =?us-ascii?Q?ITse0aEvW6fNG7SlAwas1eoYT5E4v/uIgfekTog++C2BTkv1UFhCKHSYXASH?=
 =?us-ascii?Q?GJB22ZezynL+A5gKnqfBOc8br4OT3WEMKRZvVPWgN30C/yay7RkY+G2ekGNc?=
 =?us-ascii?Q?anBpTAUIDdq9Aimz+LKt14B1/fGz0GK0LR6caXCmzULbX8cor3K/v3e/+ien?=
 =?us-ascii?Q?6YquPstO6+O/itLO0lNZ6RRhjjx5nnnsYAR23Zg6U4g7mPTOo6aKwZDUMfK4?=
 =?us-ascii?Q?IebvJyvrfFPq+jcN+Bhl3aI8KUKjV2eGKwObA04L3k2WBaEdx+o7CQxCOK6j?=
 =?us-ascii?Q?WljHnMDxBEkTwyGmm4ZDveYzVra1QdJVunYHJR3RckrgBMzPzCwkXxanZhxU?=
 =?us-ascii?Q?4zrIq1hAx49zh9n/dYo7Ro2Wo8l0rCIdPbdXd2AUckpOoJgbClzLv1bb1XBb?=
 =?us-ascii?Q?nSf2d3d/GM/FPqvcM+mFi57HUk898nk+StaY4gZQ1eeXaApNhqFjRphQUUcs?=
 =?us-ascii?Q?3w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4681.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7572e4e-042b-46b9-75d9-08dd5d7df8dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 13:42:58.3498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZszJwizhwnSmmU25ACSiw8OnHjq3986gwZhjeZhdOQoMkxJwYyM+R/deABjfB4XHTq50qlQn23yQMKTLWME1g3cgPZUy0ACqKctA2P6FCw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6496
X-OriginatorOrg: intel.com

Comments inline

-----Original Message-----
From: Jiri Pirko <jiri@resnulli.us>=20
Sent: Friday, March 7, 2025 1:39 PM
To: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen@i=
ntel.com>; netdev@vger.kernel.org; Keller, Jacob E <jacob.e.keller@intel.co=
m>; Jakub Kicinski <kuba@kernel.org>; Loktionov, Aleksandr <aleksandr.lokti=
onov@intel.com>; Kolacinski, Karol <karol.kolacinski@intel.com>; Nitka, Grz=
egorz <grzegorz.nitka@intel.com>; Schmidt, Michal <mschmidt@redhat.com>; Te=
merkhanov, Sergey <sergey.temerkhanov@intel.com>
Subject: Re: [PATCH iwl-next] ice: use DSN instead of PCI BDF for ice_adapt=
er index

Thu, Mar 06, 2025 at 10:11:46PM +0100, przemyslaw.kitszel@intel.com wrote:
>Use Device Serial Number instead of PCI bus/device/function for index=20
>of struct ice_adapter.
>Functions on the same physical device should point to the very same=20
>ice_adapter instance.
>
>This is not only simplification, but also fixes things up when PF is=20
>passed to VM (and thus has a random BDF).

It might be worth checking behavior of different hypervisors/VMMs with mult=
ifunction PCI devices passthrough.
QEMU, for example, has options to set the BDFs explicitly.

>
>Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
>Suggested-by: Jakub Kicinski <kuba@kernel.org>
>Suggested-by: Jiri Pirko <jiri@resnulli.us>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

>-struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev); -void=20
>ice_adapter_put(const struct pci_dev *pdev);
>+struct ice_adapter *ice_adapter_get(struct pci_dev *pdev); void=20
>+ice_adapter_put(struct pci_dev *pdev);
>=20
> #endif /* _ICE_ADAPTER_H */
>diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c=20
>b/drivers/net/ethernet/intel/ice/ice_adapter.c
>index 01a08cfd0090..b668339ed0ef 100644
>--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
>+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
>@@ -1,7 +1,6 @@
> // SPDX-License-Identifier: GPL-2.0-only  // SPDX-FileCopyrightText:=20
>Copyright Red Hat
>=20
>-#include <linux/bitfield.h>
> #include <linux/cleanup.h>
> #include <linux/mutex.h>
> #include <linux/pci.h>
>@@ -14,29 +13,9 @@
> static DEFINE_XARRAY(ice_adapters);
> static DEFINE_MUTEX(ice_adapters_mutex);
>=20
>-/* PCI bus number is 8 bits. Slot is 5 bits. Domain can have the rest.=20
>*/ -#define INDEX_FIELD_DOMAIN GENMASK(BITS_PER_LONG - 1, 13)
>-#define INDEX_FIELD_DEV    GENMASK(31, 16)
>-#define INDEX_FIELD_BUS    GENMASK(12, 5)
>-#define INDEX_FIELD_SLOT   GENMASK(4, 0)
>-
>-static unsigned long ice_adapter_index(const struct pci_dev *pdev)
>+static unsigned long ice_adapter_index(struct pci_dev *pdev)
> {
>-	unsigned int domain =3D pci_domain_nr(pdev->bus);
>-
>-	WARN_ON(domain > FIELD_MAX(INDEX_FIELD_DOMAIN));
>-
>-	switch (pdev->device) {
>-	case ICE_DEV_ID_E825C_BACKPLANE:
>-	case ICE_DEV_ID_E825C_QSFP:
>-	case ICE_DEV_ID_E825C_SFP:
>-	case ICE_DEV_ID_E825C_SGMII:
>-		return FIELD_PREP(INDEX_FIELD_DEV, pdev->device);
>-	default:
>-		return FIELD_PREP(INDEX_FIELD_DOMAIN, domain) |
>-		       FIELD_PREP(INDEX_FIELD_BUS,    pdev->bus->number) |
>-		       FIELD_PREP(INDEX_FIELD_SLOT,   PCI_SLOT(pdev->devfn));
>-	}
>+	return (unsigned long)pci_get_dsn(pdev);

>How do you ensure there is no xarray index collision then you cut the numb=
er like this?

It is also probably necessary to check if all devices supported by the driv=
er have DSN capability enabled.

Regards,
Sergey

