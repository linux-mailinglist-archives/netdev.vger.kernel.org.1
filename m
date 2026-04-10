Return-Path: <netdev+bounces-277298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBj0Nw+x2GljgwgAu9opvQ
	(envelope-from <netdev+bounces-277298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:13:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7103D3D5D
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7ADB300D170
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E8F3AA1B0;
	Fri, 10 Apr 2026 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drY7Y8se"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BD03AA516;
	Fri, 10 Apr 2026 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808781; cv=fail; b=K4HRUDXBOqnYFYkkyZRMUoFMmpQdC2gnG5ubcapHyS+07lcS5u5pJ80XhCoxs8F1Ht10Syij0InpbOmLWcij07/Wb+LlYzd8zu4cNQsDzWIOVAfSlnZAKFJOsjHHpiTVTdqQDhIEqmhdCVaus2M16bc+i514Vu/azvJKzQ7L/Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808781; c=relaxed/simple;
	bh=SJV0mL7kdr8Wq2gS/8k/BUHQGP6tNTG4wz4CjBzMQ1g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uJySjpXXq80YmVyeWCdHsA/dwd5yh/Rm0Pc8DXYYrOmixqaH5jjw9Dgn78FsT52V+j6s0UORquxxW0CovLZ5hFpHwanSmhA79+YahK7sUOqy+xb+ab0sIp1IO5HVUEmJbky3vjs6m1/b7kmZQbB3yyEkZ6hUCGTfeBZWmfWUenw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drY7Y8se; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775808780; x=1807344780;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SJV0mL7kdr8Wq2gS/8k/BUHQGP6tNTG4wz4CjBzMQ1g=;
  b=drY7Y8se96jLp6nexA3uBAyVkUgZfJSlaEr8fW2NI0hbnBSALRI38NIq
   qnDyYFo+IbJcXACRBUuK+yFa1/Hn+Fy8tliLWAno2Vm10KnM7/27MtzQQ
   57BucyeWjJVQO5NF8hyb3dVbHOjfCT/kTPSLDKoW74Ze5qFQM/YCswHAH
   Tmzi7gTSugCEdoIHJnZHmDogTwdchV1toB1oDEXoETthCs6gpfZI8hzEV
   +pUMPZOJoHvt5qbSAzQdYZatHIa9Zt/ra/DRaoQPMOP0Z8m5mWA+p3cX1
   fd9QdBGIhtkHhe46QiNCVtQOMzbxcg+jdBgMca5QBMjBJbBHpCf0jzNEK
   A==;
X-CSE-ConnectionGUID: mM6I60rwTT+j7dt6v2dcKQ==
X-CSE-MsgGUID: 8fKIf5G8ScyADSxNlLYitw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="77010419"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="77010419"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 01:12:59 -0700
X-CSE-ConnectionGUID: wx2VQJuzSey6kK9s5lMPsQ==
X-CSE-MsgGUID: BYFC4UysTR+xZjbNBc87bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="259487853"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 01:12:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 01:12:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 01:12:57 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.53) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 01:12:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2JGj8vm5kRJFUiQy9X1Kb50g9NF6Sk/UTb55JHXfj2U0X7NhUAp7F18Mu5H35bUlgMjjs0gMDB5pmEqmkRwxkH9AZAYJLl49t3N/A4jA2BdhRin2CLhYxRn3nGSUI7CQ3Uue3KHDRmzG3Ew0CQYDaG/fp+cQdp3p9HQmy8e2nXii4JrylNfusAnsRlwcoqsIUtHGY0Fu+WgBAF0BQTpD33/nEFco63sDfd6pkdWEXrXE0xcHhYFwsnDtPjKF9AKUx2kDgolj3cwQhgwgcQy/XY1DswiEjd5rRtg0664oj08ZEHVXiqhL4qMn8hpvcO32N/nm7T6WCUN8xJ7L21RPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFHP/gwbWRsqkxNOLSWxFxCUrI3yeOpogzki9gUdfkA=;
 b=cLPOCFq6STIOfJUMsFH2pw1zBBjWgM1Wx/0sddQmpRoXRAPRf52RqWOMJ0NntTyGm6ySC8wT/GXlex3gmVxBtbpqFBa+pHXPCCSkLfxMgt9tW5YOqeR0ETbQCrCUr+hNAqOu6+uDxAZlV6TTO/ZFLXWmvodqXVGgIX0/HUKsFHFZjS+m+iT2/PI+5a2KpHJepGzWO4VJX6MikPE896xwtHTlKTxno5KjSqPir6/tjK6uJQbyuo0O+kcPG1/E9sfVrC9X+NygqkIvw02x1HwdL/6lxTAmSAvxNQgIXRC+MnJu1e/Seo/XWe6JByG5gkua/ruDnhpkVCKmf3+X+jBnAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 10 Apr
 2026 08:12:48 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Fri, 10 Apr 2026
 08:12:48 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Piotr Raczynski
	<piotr.raczynski@intel.com>, Jiri Pirko <jiri@resnulli.us>, Simon Horman
	<horms@kernel.org>, Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	stable <stable@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net] ice: fix double free in
 ice_sf_eth_activate() error path
Thread-Topic: [Intel-wired-lan] [PATCH net] ice: fix double free in
 ice_sf_eth_activate() error path
Thread-Index: AQHcyDM4TEtzVbvVME+lHtoegk6+m7XX8yXA
Date: Fri, 10 Apr 2026 08:12:48 +0000
Message-ID: <IA3PR11MB8986987C46119C4E11DB604DE5592@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <2026040919-junior-glue-10d0@gregkh>
In-Reply-To: <2026040919-junior-glue-10d0@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CO1PR11MB4961:EE_
x-ms-office365-filtering-correlation-id: 763987e2-5bcf-4f0a-4480-08de96d8f3fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: EZM7k2lZkKjk2F7GHu+pKisL196Ul8rfQLTLtYSyJR/88T4AsuBQHVh8Xs5THMJosGS+ys8jkg24QFpzvpQckUFyAfvSOW6qp8kmPv2T2m7CgmXCOJCyaVIFaOnhA/8eM/vQFbJUi5pLvuL8R/SSI0VjWFvelkVLaDsyRMBeKA4l0OyAXI/QSxTL5EVPud5GYDdu6o58Rm88y+rGzk8wssptweV4dp38zx+oI/VmHcW4ivCFHK5P9967GaLjeCv6dDtPaPHq/BW34QlQZn3ahmXaV0haOmFk24WVMQDOLeIHDyeQuBMTvFr5vzxueV+OZnCSLSiQbFufLU5rBEPp+rQs1kkDH4Jk98pfQaoQ+jEoGVl7RYqRxX4ZgsH192gdo5z6Z9JzC69NCGaEpetYDTiGry4fm3aAakZu5URvJoXxpACi8syx8H5Cl1/zWUwy6Ivl04DrPO2TORJFDC9aYDF7bVI0QKVb4bG+lCw2b4d5zwE3vwFZYPQg2SFiYRGOxr4QFP2LnK2HYDdEJt5FjmnzH13XrYFz3jLRQGtLVe0jA/4+uCdRNX1lIfc0myspD6k6ziFlLR0ZA1qm54ctK8gndQBo9thoDjwNXqc3PWQw0et3cajGQhbJk93BTXmIODcwi4OGkuXwfD3CHqKWF4gF9hcR1C8LuSGUR2uUoBSzpj6D/HgkHkHmIGXbyQZ7L4jTQjfAh6u16iaIYDcXfSyCatvom5FvtqKeDyQK7xISqKLYrGRxVRvbcKgKpfLam/rJzPbB3Mk9TAaSVKfh9ujFm5YrLYjJAJdr/UZbfVU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9YRL78/A3Bodab6OM+aeqm/pT7EXWECddLoETp/mbHbmVmVCBH4veWoz7xgW?=
 =?us-ascii?Q?SXJwaTsDEwjBnn4owAh9kmx5Y4kh14Jrfa5kxe3lVxpp1DTvvXWCp+w9noOc?=
 =?us-ascii?Q?oHTwsletbblHcoqbJFAkGj3Y7rcVb220iD58w+D0ryHH/bOMJ3kHd1TZFARj?=
 =?us-ascii?Q?LBx0tnp/sZDw/Jd6ZbOczspby2KFAiy9U65LeTlj+2N29h3h7/GGMqgjFD08?=
 =?us-ascii?Q?VzZ/4bzDXGG2momKpK9gnNyY61K0H4jJOXNvn93zyoOcjonmgDE48/wKP9fO?=
 =?us-ascii?Q?g3TxJbSlE2aVIqa+KokRYZUOtKglEPNSgmlPIURuXJvjNa5tk1WYuYrzY1QG?=
 =?us-ascii?Q?V85R2tdRuzTyYVqJGbymMuIZRwMSjhS3+WkoD8VkzlDXSzMdQ2nF+2F2aZvj?=
 =?us-ascii?Q?F6IRDwkJkZk9BcWmYyobZLkWx0Ue4D1jQBPsvIhdd6B0rEvlLO2Lw3wLhBbu?=
 =?us-ascii?Q?VC4MjYT4T70t/22nkjFaVpm6komkWUheVpUzftT8+9e0HQL5e8486O+O4Cv5?=
 =?us-ascii?Q?FUom9Qj/HB5B/PLMSNgS4rfcOZmrqSMkV+/9FIXJvDlAvWtcAVy4bO6u7NJm?=
 =?us-ascii?Q?SDgTZa88rCKQH9zlYzSPONNERxS4BmE3uC9AOSm967LuZ/UuGq7kHpP4Xcex?=
 =?us-ascii?Q?HvgmzAQfq8Jqwl3L6JmqVUpGu+UcT04vw3GKgpAV+qUS2/8fA6pCNmwXaT2Q?=
 =?us-ascii?Q?0lf0uq5AELV5Orpzd/lUcpYl82dkQfWIs5tVCsD/CGdWsGuRjZ49PzSKZIf0?=
 =?us-ascii?Q?lkJk40+UFJZiLODWAp/ieQJ+CponuOzZAA5XXw5dRvOnv45f53o7tRsElCR8?=
 =?us-ascii?Q?fSl7p5nmVgZlWTgd+fqS79UIwtA4+93ittVcoHhvRnNZJJdq4G57IK5hDTh4?=
 =?us-ascii?Q?/wYmrmStjSPv6f3vtAG5ul8zSgtQhlGld8gf4pDRso4oyc+SKDZTyXhc15gT?=
 =?us-ascii?Q?dKe915esq8seuDkvE1o7Hl7gncjGLAVgSqIoIuCBUEkE0aqRdQFPQdemqjr+?=
 =?us-ascii?Q?uNXC8A55eTDFmQAneKF9nkxdDiAla4Rjh1afTIwWWmF+nJR+zCQSB8q4BbxM?=
 =?us-ascii?Q?ivcEr6J/7XiGdo3LtT5b3XSfkIJk0hMWL3XG1REy44nmAYUmk1hy7wh+XPUC?=
 =?us-ascii?Q?eXeRwInfVUi85yliuSRW/74FvNMDWIIYxh4kV4EJbwGNLyEQT36amu5bkFtY?=
 =?us-ascii?Q?vkirAuoUsIwtkL3imczYfN1BJdhvz8l0AHm3O/eNEkZrV8PB7QBphgrGds61?=
 =?us-ascii?Q?nYNyLATtbwSfwVrM6jQuqslVio2fF0GT40Y9T7hDb0CCpdWocsXr9+zHOhSj?=
 =?us-ascii?Q?/6igY3ew0ue3UqggH08vctEHGyx2eBGYv4GIMr5NjlW6grgtic6IToAGL8a9?=
 =?us-ascii?Q?TjdFnNCo35jDxQ61c0ksFq6ccbJLiFPumXD2kx9TgbsYVou2Mkj6ALC4yPNz?=
 =?us-ascii?Q?M0yo5rXDgX76NIpLfLO7CrPu+9xsEZQgh/dUw+jzuCpKmUL0coAyeOM4TwJN?=
 =?us-ascii?Q?PQmuX6LYp024LGMXzw4rkCoBKigpMKYwb0QorBrhVSxhsKYoCKNqmNjv8fN/?=
 =?us-ascii?Q?TTqjBRhIEFRerAWt2fkWo6vIiJRyczkAKLVfOPdrlB5PARk/poDT7Ob9sIQv?=
 =?us-ascii?Q?0hK0V8VMWlpktFHWcHYYqlWaezVl257Zeq1o1snM/1uQYKWMrXA9uEW/6b+b?=
 =?us-ascii?Q?ZR5+ou6FLuxx2G3haHDXmuXj3xEiDkIBSrebFrgs2qXYIEtU+lPYHBt02xCT?=
 =?us-ascii?Q?OppvKEWGWiA88HzwteVWx/CUCZ+eGTQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: B+SmnTmrIuCYor6j4mM99fOuF2Yr0xlnH34iOC/aLJHdd93AFB+XHvReY6/eiDRuURaCCdRUE6usq1XHHsS1i+K5kwhOzcm1vLpafnPUZ/znNrtYeKqvn0ulzn7I4OdU/HF04K38Uacmpt0TCW0RiLKOUoKtwLn92/cQX7o8ObN15uBFZVr+jWXcLPtyrDgxo+bpWrYwcK6kRZJUCEBb2bKp3SNhrZf/yj6dIPlMPQOQge+XI0rTgx/rXJcD5S4w2qENrLwD6KT5vQHDDUB1xNjOdYdLJz2JjMkAZjLY4sPR87Eu5QkqFtv7InqACgURM0fESRdT7zkjNnq8bz5feA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763987e2-5bcf-4f0a-4480-08de96d8f3fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 08:12:48.3447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IyXuBjtmnN9IKfegBmBGv8gUxG7zJHPrWdfbikEUjLysTnX2lE0ABQh8oaS11nCffXcty1Nu+rLtdHeh/MtwzoIaDBPxt8Fg7zsoiKVisDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277298-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CF7103D3D5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Greg Kroah-Hartman
> Sent: Thursday, April 9, 2026 5:11 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Piotr Raczynski <piotr.raczynski@intel.com>; Jiri
> Pirko <jiri@resnulli.us>; Simon Horman <horms@kernel.org>; Michal
> Swiatkowski <michal.swiatkowski@linux.intel.com>; stable
> <stable@kernel.org>
> Subject: [Intel-wired-lan] [PATCH net] ice: fix double free in
> ice_sf_eth_activate() error path
>=20
> When auxiliary_device_add() fails, the aux_dev_uninit label calls
> auxiliary_device_uninit() and falls through to sf_dev_free and
> xa_erase.
> The uninit invokes ice_sf_dev_release(), which already frees sf_dev
> via
> kfree() and erases the entry from ice_sf_aux_id.  The fall-through
> then double-frees sf_dev and double-erases the id.
>=20
> This is reachable from userspace via the devlink port function state-
> set netlink command.
>=20
> Fix this by returning right after uninit because the release callback
> handles all cleanup correctly.
>=20
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Piotr Raczynski <piotr.raczynski@intel.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Fixes: 177ef7f1e2a0 ("ice: base subfunction aux driver")
> Cc: stable <stable@kernel.org>
> Assisted-by: gregkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/ethernet/intel/ice/ice_sf_eth.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> index 2cf04bc6edce..6bc8aa896762 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> @@ -304,7 +304,9 @@ ice_sf_eth_activate(struct ice_dynamic_port
> *dyn_port,
>  	return 0;
>=20
>  aux_dev_uninit:
> +	/* ice_sf_dev_release() frees sf_dev and erases the xa entry */
>  	auxiliary_device_uninit(&sf_dev->adev);
> +	return err;
>  sf_dev_free:
>  	kfree(sf_dev);
>  xa_erase:
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


