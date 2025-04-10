Return-Path: <netdev+bounces-181273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C2AA843B9
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C3C446919
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7EE202976;
	Thu, 10 Apr 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RyUL3BVe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EFC227E9F
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744289453; cv=fail; b=YnU4HN7GP4b87qBLL0riD2lCtizv3nuduPLyw1hUC4T6wSJj3JC8FVVrXgW1qh0ca16zmhY5+LGIJ64I+WSygI8cMzR8opFj0G3vzErwmpk0tQkTs+LBp5HbO05U5E+joh5s/9shppUdTqLZkEkT1knOqLK4SHNMahXtzt1viCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744289453; c=relaxed/simple;
	bh=yyeJKym10rsmdHPz6SYyRcldnYLoHeO4jVQkRzUVOfo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PQpGJBUPcsLLGnprgmKSP3mqiWM7ZMPVF+d5ztACLBVuEYbp2Ggn0RxQiZrfT9gLPWfiAK4QH9OyBS9HfmqhRgvU2u53T6u67fdrJfahWgVKGAq0iNA924485PdUhXswFLHCjKQ6pcZKrGmVGYOGe9aRx1CtW0qrd4FzdJohy3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RyUL3BVe; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744289451; x=1775825451;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yyeJKym10rsmdHPz6SYyRcldnYLoHeO4jVQkRzUVOfo=;
  b=RyUL3BVeoZsJmhk/yR8ltWrEBX7hXVPStpCID0fSTx94jL+qzCbwvr2U
   Ce5NfWLXNx7bKfTwcqZLZ+FoWe5XW4HeBynLEoo+H2Z4KVc2zhislr0h3
   Qr7mYmJg1rdphTJDu3wOqCNU2EZotRj6DFFOqWlAA9NYh/7pdQQxsnhfo
   EkgaA52fiNB40g9QsktLRbz+2NnM84x3L9UURSC5G8AWX+uoUYH6LnGBf
   +NO0sijwbVmw7RVhu3hvDqGhaW985yY7IRwhw2/DYmgOX14fJd6mO/JzI
   lVDhPKIsGoc5y+2RqBPhc03OLo+3iDFth/PaqBKyOzLQ7GQRZGn4iMAMw
   Q==;
X-CSE-ConnectionGUID: vyJhhHkCT2iYr+WK8LAUpw==
X-CSE-MsgGUID: SDfI+pVzS5KcJO+iJkyGog==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="63350325"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="63350325"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 05:50:48 -0700
X-CSE-ConnectionGUID: 0y5ulpHzShqr7acwdoAvCQ==
X-CSE-MsgGUID: g4HbbbneQhqJyUGsLrXh4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="134073332"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 05:50:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 05:50:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 05:50:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 05:50:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ls8Y97QVUDDNqKQi+wS3hc1YhOyGqYubTG2Wx8Otw87yYMirzl84Yalku5kol24WOMtnoXDXyFfdXbSsAcXfJcbKJph42daZ8Nd+TrhGwDnkAMVLXlEBnDReAgDpOnEKP+rk45e2QMdE+oGb1rRD8oiw82Vkclfuq1cdsyrxiZACtiwdCdtyaO7NwklI/YxJy7IMCREjEiPqel/svbXNLV7qPXVpucHvobhUkK6QOPmKU0t54Fp8Y+yXVumE+O3Vccu7v295ToHHz9kcX9iZ9hKOJbdw5dDSgzrcPRTVQBYzt08t4ad1F1TNyCVYBj0SUDzhAlLReHR9RfCiMpVqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TxNBKlkBYqMdFn44xe9tD0DwA3NE1WhsVGtk8+dNpk=;
 b=SNJfzTd4XYvVkEx8Jq6Lb07ADz7zMit8NDTWoTM8waEEA6VfmOdn7b+qAXoye+zifFtGpYlPglwveXjE+5uG7hR1w6xCMCNLMpcpQ+GT8TioDKGbwYDgDuHbrOq9SEqTLO5hEnjRzgj6rIBzSjJkrdpjC+i9imK3X3mnMe2Fa5574PlxJblN81jFd/NXwDA+MC7dBmzp6Yd9yLfr6NfoM/pZCdVfXsPrdewy/XysHaidsoW3s5UPYFjrW97gpy4cYe7z63zsCymcIOLXrGTOWfis1elQofEYJHEQwHVhLliWbVhY2YJFmkH/nzorzxqKytcgs03r0s5ViwTa65EviQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by SN7PR11MB6994.namprd11.prod.outlook.com (2603:10b6:806:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.46; Thu, 10 Apr
 2025 12:50:17 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%6]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 12:50:17 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Subject: RE: [iwl-next v2 7/8] iavf: use libie_aq_str
Thread-Topic: [iwl-next v2 7/8] iavf: use libie_aq_str
Thread-Index: AQHbqf+WycGqzkoZj0mjT4go+SaJ7rOc2iBA
Date: Thu, 10 Apr 2025 12:50:17 +0000
Message-ID: <SJ0PR11MB58666A05919616B56CDAF5FDE5B72@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20250410100121.2353754-1-michal.swiatkowski@linux.intel.com>
 <20250410100121.2353754-8-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20250410100121.2353754-8-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|SN7PR11MB6994:EE_
x-ms-office365-filtering-correlation-id: 005233c0-fa06-48e1-134f-08dd782e3ecd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Nb8gFboSITkNB5vmXNsJmuG47MjNXyp9JxbsesDVdkiPAdQx8jgmnHDpgCWB?=
 =?us-ascii?Q?6jgIfvRhze37mfk3QSvclqad7fHsFbUDGKvNrVtk6cAB0mwS1HQDWhwcyibK?=
 =?us-ascii?Q?zu0rVBo5hojsB6Lx1qz65Nhp3Zfg4kHjx4ivNJe2qM/2VUuTvGHiXV701Zll?=
 =?us-ascii?Q?6ERGpN8JHgYdTFLhlqQviPOuSXhA60rTsSOFsT+ohlJcDw+ojwPtWuFt8mmD?=
 =?us-ascii?Q?p0yxwEKRl/kNKCAQpaRZDf41Nr1747tAo4nhze0IMU7WX4Kl1IlLRvlgOK8M?=
 =?us-ascii?Q?9b7lYzfUfthGcFyDvdGn5+Oh9VbcOwutsfLzl7CIOOrJwJWSme+yv5cYp1Vq?=
 =?us-ascii?Q?BAkRBW6f66IRQs/Wcd25iLCkIPgsbH849ami97KFOdJQiRHCm7HD5QUzLhzS?=
 =?us-ascii?Q?1bAOJgu+mTJNeuLS+sKiLORCQRYcviGI6lHCXSnqHBzBPwEYYZJbF0kmYGyQ?=
 =?us-ascii?Q?SqamiCRUsBgLEeJ6RvEJAo4xTcJ1V5T0qLhCAwm5BMnPjbjS9doZ7fCFLjYs?=
 =?us-ascii?Q?TNJG2ZZ6LR3WwaT/fVRIN7Yq+0/N066GJbRklWZTWgPy4imGI746OyOOnrcn?=
 =?us-ascii?Q?/8JQsV/dRONMSw+y59E6BM65LpeuhadouCN4HG8BBqly5tqY3y6yKa626698?=
 =?us-ascii?Q?6kO6c0g2ZLzzENbOXnHB9/ia+G6GH05xHyZVtxYba5mHsikwSVBxTWPY70zl?=
 =?us-ascii?Q?S6GHw52rw5lt6urTMr7N/+H6AYpB9YQQ38d5ftqO0N9VjhMA/9ahTB5QzXgn?=
 =?us-ascii?Q?qBapoTc11oxViosd31AlnLSIK4muKxMNUUGArg3qHPIZngrUAWap7Oc3aE/4?=
 =?us-ascii?Q?L3SmQ0QVI2BM6TKKDbJCm5hKDm6widvIKg/o/qekPHEWi0IBF8WlU/C2yYWT?=
 =?us-ascii?Q?7j2UEPiImicjStFFXhtnQbVloSrUhu1PPZrvSeilA8CRqMNM10VSUzi/FZN5?=
 =?us-ascii?Q?wxdcvUgyoOtBHh9KB86RdU1mP1zn9hwyNwRoVQ9JA2izM2HhpXmw66G00fX4?=
 =?us-ascii?Q?yeOaWBaGUakZ3okkR/qBNGTcSBPL/A04EwztoFTtq4qXgOxyVQc+6VRt8zpd?=
 =?us-ascii?Q?vFpEvW9SciFuhgrp+d2xXPQI3hxRFcigERv23Hh1v68zPVZUi9V0zQ2vdhjJ?=
 =?us-ascii?Q?Oh1z5N79+NQOsSnqYI2xpJQSVqwFZ+NvvwkPjZgMcOkJpx2Iwzyrm64LhJs4?=
 =?us-ascii?Q?FcNB8KHVIUoMuWuX1hPUlWtRX83LQjuJaFuOk2Kny0cfad56fSi8xwV22GzA?=
 =?us-ascii?Q?PpriR55N159atbxljDuc7Is1kGBWvypEkpryHxeAEUS1XR+kufh2rs0aKiT4?=
 =?us-ascii?Q?ZqgYyyz2feJd10nHiVViDVHR9KUGdTqf51Nx5lMKYzt3bybMQV3+HSpRbsLx?=
 =?us-ascii?Q?mgwVTt/PNySMIjep8u3AYPFhHv1i5Tg6x9+HjRrIFAileXfcnef5E3Te3OFs?=
 =?us-ascii?Q?qreAzQbx8AjMcOzgmA15ERvIfru3WoyiNlM7ORem6BCkSjbO4Ui1sw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dV2zPiP6eHmHDe1E4QF938eq5O5Ch1OREAMUhZ4nj6t23nRZoi9yhUsXuqSl?=
 =?us-ascii?Q?nVjcsKC9afEq+h8gDVCzI4qjXPfEmLRnY8RO6aS+Z9uK9afgcG4Oy76PD/jn?=
 =?us-ascii?Q?pko7RarRk3JYaZVcTU6OtV8QLdwz3wHqIBQ/ql/punO+8Dsg1/LJ7NKHShcA?=
 =?us-ascii?Q?Aw2CvDO0pNy/1d7/svJiPmK40dpW/MdSJsNiL4fEX5n97o3BwzE3bPVcpJBg?=
 =?us-ascii?Q?LY8+zfONPw+GTjQkmjFnYhtKA/Hq6QrsLMNmmm/2fMWy37k9yZlVGvgR13B5?=
 =?us-ascii?Q?8ucSvnZ81UE1t5SuUvy+qKxO9ABSO7tcXP/HwKBK/q9GNAFQRg0c1SOKkXJh?=
 =?us-ascii?Q?BZO8J6Fzi/6DAnGfoBmEZRQXFpwbvbsekOLj/5LFyKjA0vlv8usfY/a1TQjG?=
 =?us-ascii?Q?cLgVM1dFhiHbdk3a2XpulJq58lzJiLsVRoAGpU46fszV81Ce6bIKFQmAbaDv?=
 =?us-ascii?Q?1NU7FwgyBdaV8XVQG7zNQnAAJaauu/rsGGKakhtHCaN7iZn1epZ78pn/XYBy?=
 =?us-ascii?Q?DOEMh0ssAWEZZJbnHsRaBl9FX/SJTaLSFeJbucTDCjphjkoV6i1PIdZnug2t?=
 =?us-ascii?Q?l95QaBQvppyqjehL0hoJLlC5mdeZ9Q+V/vcvA0ywNir2TMr2/xyTVlamrbX/?=
 =?us-ascii?Q?szpjAPJpA/llkhXh4cFfVk+dWQBav2eeURHYjy9JoswfSxSHUsu1KBaJCJl1?=
 =?us-ascii?Q?BVLWgiZcN4y5aBnoujnsw79Il0CE07RAwAHAacLYM48QWfIiOaiaC+zeJo08?=
 =?us-ascii?Q?3wLoNhSrZL/MrxGI3wND8TSftaU07R8lHq1GmahCXqz5yhKoORP+w21/NXfi?=
 =?us-ascii?Q?lHtjaEhWojaDr9oTZmh9e94VJ1UVUmVCVwq0o6+ctAj/zLecS68pQ5pSSfA/?=
 =?us-ascii?Q?UNiXjKWEhThPmfOpUmv3jpjcIEjQfnldLaAqOM1pWBYfV2fSTlMKJJXJZOFV?=
 =?us-ascii?Q?cweHNuN20j9VBUNFIE9t2v9AAbtxshL14yOJNr5ZqedptOgT/RRHC8pTyxjQ?=
 =?us-ascii?Q?Duh+N+ahhXKA3Ny4xN2u8o3BIvf6NODwj20VnatLwjhR6E8Vi5jpE0cOQ4FT?=
 =?us-ascii?Q?dpCKCAulKFROSqGK/b7lYdnBwYu5i2YpQombn8YbMwXmQj5NJGEkrcxwrbFD?=
 =?us-ascii?Q?svCp/jDqR+5CgbbAA2D9pYUIe1OPpWbIxISp009mYd0nPn5NgVfqGKSoK1Tm?=
 =?us-ascii?Q?ChqL33M6Ad7hC45Hkcpd8Png4cVWV+QqTD+mlswSAWpAVGkUVYg0pyZk391k?=
 =?us-ascii?Q?HoGPK9rU4vWWIRJ6k2aEe+jga4d66RE2SzQNAoz/OrNprAHPsVcMUprgcRy8?=
 =?us-ascii?Q?MUNQrVaPdvGkgXxvcWcc1tqPANGw4Ot4uIQIReil+eirp59VxpIXYnCPcwsa?=
 =?us-ascii?Q?lJvnsl+bsjEWOw/BQI1VKJOWY8uXzQy/JE2MIftrIseI9K9e71wIOVHdzGuL?=
 =?us-ascii?Q?PKnD7C0Kq1MmI531svm6kYOHJw/PZVaHKto7Rd8waDJa9k4cYi1FVr5ejYde?=
 =?us-ascii?Q?57+76DgTpCseTW28M6tFS4oAR+fmJpLOKbTqyxMTErj1srbjvuu+Pwy0fb1S?=
 =?us-ascii?Q?2dAGt/BcD7qQe7nEP/It7btk1e7EbkwwW4O/r+APeVXeA3q+/qf64bSvSW5n?=
 =?us-ascii?Q?DA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005233c0-fa06-48e1-134f-08dd782e3ecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 12:50:17.3623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FCnLPC6liQ9uMjE6R7+85HGsUYTxVYaPSCgYbEuDaL2PMNf7Erb9aGqEt5q6IrF7v8ULwNZn/8q/LeImqRjHwTDypZZnG82O1imJUTx3V+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6994
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Sent: Thursday, April 10, 2025 12:01 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Kwapulinski, Piotr
> <piotr.kwapulinski@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>; Zaremba, Larysa <larysa.zaremba@intel.com>=
;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Subject: [iwl-next v2 7/8] iavf: use libie_aq_str
>=20
> There is no need to store the err string in hw->err_str. Simplify it and =
use
> common helper. hw->err_str is still used for other purpouse.
>=20
> It should be marked that previously for unknown error the numeric value w=
as
> passed as a string. Now the "LIBIE_AQ_RC_UNKNOWN" is used for such cases.
>=20
> Add libie_aminq module in iavf Kconfig.
>=20
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> ---
>  drivers/net/ethernet/intel/Kconfig            |  1 +
>  .../net/ethernet/intel/iavf/iavf_prototype.h  |  1 -
> drivers/net/ethernet/intel/iavf/iavf_common.c | 52 -------------------
>  drivers/net/ethernet/intel/iavf/iavf_main.c   |  5 +-
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  2 +-
>  5 files changed, 5 insertions(+), 56 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/Kconfig
> b/drivers/net/ethernet/intel/Kconfig
> index d5de9bc8b1b6..29c03a9ce145 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -260,6 +260,7 @@ config I40E_DCB
>  config IAVF
>  	tristate
>  	select LIBIE
> +	select LIBIE_ADMINQ
>  	select NET_SHAPER
>=20
>  config I40EVF
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_prototype.h
> b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
> index 34b5ed87a9aa..7f9f9dbf959a 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_prototype.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
> @@ -34,7 +34,6 @@ void iavf_debug_aq(struct iavf_hw *hw, enum
> iavf_debug_mask mask,
>=20
>  bool iavf_check_asq_alive(struct iavf_hw *hw);  enum iavf_status
> iavf_aq_queue_shutdown(struct iavf_hw *hw, bool unloading); -const char
> *iavf_aq_str(struct iavf_hw *hw, enum libie_aq_err aq_err);  const char
> *iavf_stat_str(struct iavf_hw *hw, enum iavf_status stat_err);
>=20
>  enum iavf_status iavf_aq_set_rss_lut(struct iavf_hw *hw, u16 seid, diff =
--git
> a/drivers/net/ethernet/intel/iavf/iavf_common.c
> b/drivers/net/ethernet/intel/iavf/iavf_common.c
> index cc71e48b5689..614a886bca99 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_common.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_common.c
> @@ -7,58 +7,6 @@
>  #include "iavf_adminq.h"
>  #include "iavf_prototype.h"
>=20
> -/**
> - * iavf_aq_str - convert AQ err code to a string
> - * @hw: pointer to the HW structure
> - * @aq_err: the AQ error code to convert
> - **/
> -const char *iavf_aq_str(struct iavf_hw *hw, enum libie_aq_err aq_err) -{
> -	switch (aq_err) {
> -	case LIBIE_AQ_RC_OK:
> -		return "OK";
> -	case LIBIE_AQ_RC_EPERM:
> -		return "LIBIE_AQ_RC_EPERM";
> -	case LIBIE_AQ_RC_ENOENT:
> -		return "LIBIE_AQ_RC_ENOENT";
> -	case LIBIE_AQ_RC_ESRCH:
> -		return "LIBIE_AQ_RC_ESRCH";
> -	case LIBIE_AQ_RC_EIO:
> -		return "LIBIE_AQ_RC_EIO";
> -	case LIBIE_AQ_RC_EAGAIN:
> -		return "LIBIE_AQ_RC_EAGAIN";
> -	case LIBIE_AQ_RC_ENOMEM:
> -		return "LIBIE_AQ_RC_ENOMEM";
> -	case LIBIE_AQ_RC_EACCES:
> -		return "LIBIE_AQ_RC_EACCES";
> -	case LIBIE_AQ_RC_EBUSY:
> -		return "LIBIE_AQ_RC_EBUSY";
> -	case LIBIE_AQ_RC_EEXIST:
> -		return "LIBIE_AQ_RC_EEXIST";
> -	case LIBIE_AQ_RC_EINVAL:
> -		return "LIBIE_AQ_RC_EINVAL";
> -	case LIBIE_AQ_RC_ENOSPC:
> -		return "LIBIE_AQ_RC_ENOSPC";
> -	case LIBIE_AQ_RC_ENOSYS:
> -		return "LIBIE_AQ_RC_ENOSYS";
> -	case LIBIE_AQ_RC_EMODE:
> -		return "LIBIE_AQ_RC_EMODE";
> -	case LIBIE_AQ_RC_ENOSEC:
> -		return "LIBIE_AQ_RC_ENOSEC";
> -	case LIBIE_AQ_RC_EBADSIG:
> -		return "LIBIE_AQ_RC_EBADSIG";
> -	case LIBIE_AQ_RC_ESVN:
> -		return "LIBIE_AQ_RC_ESVN";
> -	case LIBIE_AQ_RC_EBADMAN:
> -		return "LIBIE_AQ_RC_EBADMAN";
> -	case LIBIE_AQ_RC_EBADBUF:
> -		return "LIBIE_AQ_RC_EBADBUF";
> -	}
> -
> -	snprintf(hw->err_str, sizeof(hw->err_str), "%d", aq_err);
> -	return hw->err_str;
> -}
> -
>  /**
>   * iavf_stat_str - convert status err code to a string
>   * @hw: pointer to the HW structure
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 2c0bb41809a4..1b4a9a921d6c 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -50,6 +50,7 @@ MODULE_ALIAS("i40evf");
>  MODULE_DESCRIPTION("Intel(R) Ethernet Adaptive Virtual Function Network
> Driver");  MODULE_IMPORT_NS("LIBETH");  MODULE_IMPORT_NS("LIBIE");
> +MODULE_IMPORT_NS("LIBIE_ADMINQ");
>  MODULE_LICENSE("GPL v2");
>=20
>  static const struct net_device_ops iavf_netdev_ops; @@ -1734,7 +1735,7
> @@ static int iavf_config_rss_aq(struct iavf_adapter *adapter)
>  	if (status) {
>  		dev_err(&adapter->pdev->dev, "Cannot set RSS key, err %s
> aq_err %s\n",
>  			iavf_stat_str(hw, status),
> -			iavf_aq_str(hw, hw->aq.asq_last_status));
> +			libie_aq_str(hw->aq.asq_last_status));
>  		return iavf_status_to_errno(status);
>=20
>  	}
> @@ -1744,7 +1745,7 @@ static int iavf_config_rss_aq(struct iavf_adapter
> *adapter)
>  	if (status) {
>  		dev_err(&adapter->pdev->dev, "Cannot set RSS lut, err %s
> aq_err %s\n",
>  			iavf_stat_str(hw, status),
> -			iavf_aq_str(hw, hw->aq.asq_last_status));
> +			libie_aq_str(hw->aq.asq_last_status));
>  		return iavf_status_to_errno(status);
>  	}
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index a6f0e5990be2..65340ba0b152 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -29,7 +29,7 @@ static int iavf_send_pf_msg(struct iavf_adapter
> *adapter,
>  	if (status)
>  		dev_dbg(&adapter->pdev->dev, "Unable to send opcode %d
> to PF, status %s, aq_err %s\n",
>  			op, iavf_stat_str(hw, status),
> -			iavf_aq_str(hw, hw->aq.asq_last_status));
> +			libie_aq_str(hw->aq.asq_last_status));
>  	return iavf_status_to_errno(status);
>  }
>=20
> --
> 2.42.0


