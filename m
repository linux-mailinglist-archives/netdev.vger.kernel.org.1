Return-Path: <netdev+bounces-269800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM7dCKrvvGme4gIAu9opvQ
	(envelope-from <netdev+bounces-269800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:56:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1452D6604
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 562213024461
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5203563F6;
	Fri, 20 Mar 2026 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RSn9s5SX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B890F322B74
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773989797; cv=fail; b=QtGQ+bQf35WaohKq9+Da4rSx8aCQaaUv3J1MEazaioYC4DOQf7u4Jqxla9ckVc44IFR4PPI25wjEwoGDe9PY0csMfs/DWA35o2dld3oFyNS/abQyRTfNMuJR2cnURxRgmREqtRFiXaSt04+tUKZrGVv4P+ZXQqk6xedbgKFfYsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773989797; c=relaxed/simple;
	bh=ROKrcowA3mdiJ3HYsh5FnKGRsgae9SiNb0K00Sgbrp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z268OyiPygT9Vh7E0R4XMyyq/Evvnk7R1LnME0jhzPZ59uEHbZ1CzKyOd1fHSOsTeWKTvDU1xsBf9dbZ/k3lBMs/CatQKo06I7UP7HEvZO2jla63fy0qi1//s2QXvYcVQuHBB3W69/2FrycwkpSHQ/793p1u1N+VCQazNLuLhJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RSn9s5SX; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773989796; x=1805525796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ROKrcowA3mdiJ3HYsh5FnKGRsgae9SiNb0K00Sgbrp8=;
  b=RSn9s5SXUu3J5e1lNBlwRLdPxGTXg93/YygdbdSOKCDR2mbVxKOQYX40
   RtQvlrjsWsVrWEhpxmVvKyXKulI8JzC/myc3hnuwkGS5m5Qaj7q+LjIOE
   z+8fQeUSAJYGvLE7oc3bfbJPWXkaQlT5JTdD/dQ7Gp6uOgBRALn0WMIcv
   PIUx2DWqYVU/+aUxy3f45Ig8XbJBkROIwhGAVzcODp3LWtHscahkY77Ar
   2/KzBoySz4o2LP2grsGjVTSpJsSwiI/jUxaI+u0SnXHuiLP6PfnajMQ/D
   lyKwmsPsxxfvjLXM9JRgyAKKBCvDw8j0A84LZdttm0UMcCQzDcFYpae2S
   w==;
X-CSE-ConnectionGUID: TP4FYgcERh+se1MknKpvxQ==
X-CSE-MsgGUID: KZ9LNM72SB66oUHjNfNgyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="75103741"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75103741"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 23:56:35 -0700
X-CSE-ConnectionGUID: Zw7W8BrSRKOwwYNqzXI/OQ==
X-CSE-MsgGUID: 5l8/R96hTmmel/VO1aWqPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="246232494"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 23:56:35 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 23:56:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 23:56:34 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.68) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 23:56:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBz3GS6IqIuTl7DNKnUMl/cWiUqIQPYxjol4nv/JBrlAIBlcFLt7R/g1s6FYXJH6dDRxkF+/g+6X/pkR76cn7wFsoCzZzKNxo8/oJR985gxc0sRdKT4cWUYripAuvPIxG+trKEHAVApWEzJbHOVv7btj43t/ss6fPdUS0SRDx7/ni/6vtB+gp+q8vQ93Sw2FlLP87ReZaoa3YDBdjf7XbIZBBcqpaeSKvcPveU/SYnvrmZYP2tuHay4xNZ6lTT29fBECkVeThCkJNC+C1vLZO2NNsCaQyQDOupjdzhScd18IXP7eBqFFz+wvcJ7admV+oojE/jfmRPCnLGrLGkfgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DX4a2x9RU63k4ncEM4ASmLn6NVF8AysM5HiML7O/DLw=;
 b=V8Q3W+EJE8b4CpTnr2Fvzce6uQVml8aP207t8aCllibqB7T7VQPGRVJvljtAnDC12HUiL3tj7FRBve965vLJvApN72Qk3t0zMuI/l93bGDHfHDca26KiFd07b4VAuqW+3NSdtB4kWbBq/E8YEZKk7Uv1sQdo2TVd6IVD5J7BQJ9UbIW6hy433i3lpfrkfytpl+3VS1sTNYTjkTOTUj2VLEVLQ1+h/Hp166uCYN2iN5J/w0Hqf2h3zCE310Cr9GpUGytGblcMQZ5a7TVbZJNy0slCWwTFfoimf8fvJIYwYNJZirwarRuSrYDXlgoAkj1mVBokoKD19Wi/mcQs1DaKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS0PR11MB7409.namprd11.prod.outlook.com (2603:10b6:8:153::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 06:56:30 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Fri, 20 Mar 2026
 06:56:30 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Kohei Enju <kohei@enjuk.jp>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"kohei.enju@gmail.com" <kohei.enju@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1 1/3] i40e: prepare for XDP
 metadata ops support
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 1/3] i40e: prepare for XDP
 metadata ops support
Thread-Index: AQHct8RNOTnS4rHV0k+Vemji8g9Gn7W2/boQ
Date: Fri, 20 Mar 2026 06:56:30 +0000
Message-ID: <IA3PR11MB89861AD556C1C4D863DD4F3EE54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260319171650.5815-1-kohei@enjuk.jp>
 <20260319171650.5815-2-kohei@enjuk.jp>
In-Reply-To: <20260319171650.5815-2-kohei@enjuk.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS0PR11MB7409:EE_
x-ms-office365-filtering-correlation-id: 2b9d89b1-59b2-405d-3c73-08de864dd0b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: K7Tx/rBn2RD/tBkmGsPXdn2Nwb71LLmlV2Iu8eOxPVIHP2TkPtcASTHDTo+EQz3xYiFABYdPN8fexFfFlvmM9RgCdGySNr7ZZBFIelZELCT+6UbuZlSs94DwFJWrcEPCiwLU3YahVa/F2jXuiP0Io+41v/XNkgUZqYcNOa2IrKzCgQZhlNC354HImuP7oLwTvDQLUwad9dsOgceihEoqAl1nLtfeWwsgiQ/Fb7P20XsHpXPLiPqI9iWV/tEhsBcQ/0I+dXcukl81IImPvXiuIVD0gKD14HQ5ef+BqtlnaCpXd7BdIhjSCzP//K79HhtKAP0iHNwbXJakJrU29rXJcYku6jqGolkYxQQLmSuuNr4RQV98KUTt0tF6tED/SwiT0dAEbKVOA3030RHDeJtqoBWD5D0lv0J3IAnRE5uJY3J1oV6wFYLTFdpT1kKczVm02jTmS1yYtDx5yCOeEk/baNky8kLgklZmRPw5lsh/Exz85TCJRldkCGrwEYVkd96oAxxndops6nTSpJfeM2cbxFaWDE5Q3Dz94hWpUDh1fxQ6VbWRAh6VjHz8StrVsrhTgOQ5aFY+1wP4EUlxSNIjTBMnSDN8+gMKt3g2J8BF9STj0C7Q4Tc7wCGNxJ07xEzeY+zPiPWuUdwuBAdj1hymhLcZls8Q/S/ahjhHv6faisekSDdEYrJX71ZbF9JDVTBNYNh3/7VBX6cE5S2IGvqKoEJ7QfJd5X0P9R10bkT07ilpyIGZR23Yvd1+Wvsh0ZhWbfJJ9x3H+W8y9oZKK51SefTX9hYVwrePf2139fMfPhI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ISUovOlDhw5SAszCBKZ4J8o6zS+hIfOVvy2+A+/JSgSN1zasVsWa5WBQiU+m?=
 =?us-ascii?Q?e4DlowwN9Mp3V9pi/CUv3bLBmJwYYiJH69emXrJPGFh5SpqOL0VegZgYPg7O?=
 =?us-ascii?Q?Z05h+WkT8JBstOfu3WGcnHpSxqJdw57fWG0KAKEBCH9i/mmtMIUy4GyXsPP8?=
 =?us-ascii?Q?SPqVoNNf1pR2hEwrEdPkk/44YhNOXYIkUHNH7vjODuOINadQ466YU4FbOVUy?=
 =?us-ascii?Q?EioCzbAvvEZWjBdSIOp9UPLUg5jTC2XeLNqpiXnrO0QWmWVwJ1DhGbrubAT0?=
 =?us-ascii?Q?9ypuCAxNclhQxhGjr0yHmWU9nSEhUjoORNlYQ8XlV0oAkm5GDbp/GNdD8yiV?=
 =?us-ascii?Q?XK2x3CZ8hdFpN7gPmqLCuS525KkRXsZ8X5mXu7d5t/GN0os1htzfphhYAJtY?=
 =?us-ascii?Q?A0CX3mdSDytSMYPhXJQRSX91TrOJIpPQLoSQWIzR1ephSfIsLnEDXPblHCm8?=
 =?us-ascii?Q?lX4yHMm4SIMeteaJkBBNKRdWNIc5XPPP+D6CJV1mJRSUzbJZ2ZnfOi22YSim?=
 =?us-ascii?Q?y1LTZBBF3u56XULBxePViwiLCSV1fFwU1KdjO6SxK5YEHJLDhRkFL7FLT2Ov?=
 =?us-ascii?Q?QNXDeKPJfBjzCwTDUjz3tHL+7eh0Bl+J4Rplpg6ppXiWz43+YKr6VSL3Cjfd?=
 =?us-ascii?Q?WfH97m/OX+x71PNjGlaXdCo/NUkyIkknZP+lD8b0NIwl38aK/TPPtGs37R9Y?=
 =?us-ascii?Q?qZOIB5tTbK762TauaZlDYIHsNYVOvY5cqM2VF7E89KlhlcEhaKS4kvkTIsYP?=
 =?us-ascii?Q?CygI9ReXrgVduZj3AsjlVgXI8Ydj4xsAzIea9LpHX/VV/YW9QivFtWncDVmn?=
 =?us-ascii?Q?YfC9DqLfNPxys7EVWWPMoqBnu8XnLi+fjz33+5t4ALObJEfwoDrRtL2L0o49?=
 =?us-ascii?Q?l4bZqqp0FC8cPh8Elgna3DA9bc7W6N2fp+R1W+EO/cbEaAuZ+o59Ee54niv7?=
 =?us-ascii?Q?6Hw3yuBgLQkTSTWAu7cLEq106S2NUNCRiXr2l9qCo1xYyNItZj0ZNxXzix4D?=
 =?us-ascii?Q?I/gJfcrzOkjflSuo4T5wXHWO8Co5n+VhvFi6h9eZb34BaVCfsFF5Yj6hiSUW?=
 =?us-ascii?Q?mMHRinjvBQ1JVjF10QUtlzoxY2NZZYrJJw22CufMqGQCeiETKHDdd3qh4RMj?=
 =?us-ascii?Q?TpmxYyEV/nbxRClyp2B7w+oq/awMn/YttdgeVh2KEIWVOu/AWUi719DRHq+U?=
 =?us-ascii?Q?w8Py0Y+5sZ2RVooHiQj+GHr5KKAT+wGpXuG/YxS75g9nn1QZQ5qVefD33hKv?=
 =?us-ascii?Q?oTQz9G2WCgPziCJD+aylFcmdPQCzfGDRtGNqCSQwUaWG2Q8ZLr/4i+R1x2Tm?=
 =?us-ascii?Q?NPZILFDHxSD4ALY05MAQUK0o2Fy5Q3gyo1z9fVN+0rDcs/muiFF5zpS/lxM5?=
 =?us-ascii?Q?6f59KLA1gOa7+WP35e9bhiC+c9l4xvbVOXil584NI4QtyWlY3Wr1LhRe3iSo?=
 =?us-ascii?Q?dcLS5T+f3bk2p28OyAAFAjH4b6X+pfyQjAoxIg8hbuTjvaPImjjSYgC+wS0X?=
 =?us-ascii?Q?fFvGKR7OgQ61m/a+kdcGusIYsdCL73ePqaS25QRwhJvrRST6PkVnWFBTD8sA?=
 =?us-ascii?Q?KqDLlpyaE11Bdc4bjncuNQAEe39ujnd1o5yLipQR40cEkGAkLcVs6FiF2Oo4?=
 =?us-ascii?Q?drmnpIAznW8qGpeewfnYrsK98rVHjuZxnqTJAQfYfmDgX4ZJ+kMBN03vNCwv?=
 =?us-ascii?Q?OAl0uiqDBZGWiZQ4dvgqacrjCzcHxZQmNPZggVKwO1vpQO1CbFaS3eydWhYI?=
 =?us-ascii?Q?rqGcOlkm0nTi9TvgseZP6wOyTVokp08=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Z/d6KqZyzBEwCIYWqxnRuBcDUPh3qcxZelQA3o21rm+rLt3rKHDScyltWkuE8+ADAOMJrZQR99h6cZRld9w65qqH8yxFHeEgVwssd9mmLB7R+naHsxjb5dYyiSv4Jj6zQEIlI9e+ogDvJBlIfcEa7aEaX+3YtlK7A35JvfpB4CSe3COfCBRo8eax+XAbO1xXqnZhr9dVYxgJtgsBwMXWb9Bf0HRaPNC2tdgIOaKKgBBDDVvQNzek4i900JXLOY5TtmPToYEVWw+RDEdFILE+F2YBJW61X35iN3FGcWPvIN2zDWmFYCm+pQ3v4beoxXb4MXdAYnx/7AC353runC5BEw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9d89b1-59b2-405d-3c73-08de864dd0b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 06:56:30.5334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D6Rz+3l+hBOMrk1E+tLNFN7Ln7jSymhNQBzupynuj88uszAhg/3tQhxmpt40cq9qTZEenZuFwB9t5J765di/UVPwUzrCdksn1WbJUx6ZIq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7409
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
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-269800-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IA3PR11MB8986.namprd11.prod.outlook.com:mid,davemloft.net:email,enjuk.jp:email,lunn.ch:email,osuosl.org:email,intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.941];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8D1452D6604
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Kohei Enju
> Sent: Thursday, March 19, 2026 6:17 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; kohei.enju@gmail.com; Kohei Enju
> <kohei@enjuk.jp>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 1/3] i40e: prepare for
> XDP metadata ops support
>=20
> Prepare 'struct i40e_xdp_buff' that contains an xdp_buff and a pointer
> to i40e_rx_desc in order to pass the RX descriptor to the XDP kfuncs.
> Also in ZC path, use XSK_CHECK_PRIV_TYPE() to ensure i40e_xdp_buff
> doesn't exceed the offset of cb in xdp_buff_xsk.
>=20
> No functional changes.
>=20
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |  2 +-
> drivers/net/ethernet/intel/i40e/i40e_txrx.c |  5 ++++-
> drivers/net/ethernet/intel/i40e/i40e_txrx.h |  7 ++++++-
> drivers/net/ethernet/intel/i40e/i40e_xsk.c  | 12 ++++++++++++
>  4 files changed, 23 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 31a42ee18aa0..7966d9cb8009 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -3619,7 +3619,7 @@ static int i40e_configure_rx_ring(struct
> i40e_ring *ring)
>  	}
>=20
>  skip:
> -	xdp_init_buff(&ring->xdp, xdp_frame_sz, &ring->xdp_rxq);
> +	xdp_init_buff(&ring->xdp_ctx.xdp, xdp_frame_sz, &ring-
> >xdp_rxq);
>=20
>  	rx_ctx.dbuff =3D DIV_ROUND_UP(ring->rx_buf_len,
>  				    BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT));
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 4ffdb007c41a..cfaf724ee7ff 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2438,10 +2438,11 @@ static int i40e_clean_rx_irq(struct i40e_ring
> *rx_ring, int budget,
>  			     unsigned int *rx_cleaned)
>  {
>  	unsigned int total_rx_bytes =3D 0, total_rx_packets =3D 0;

...

>  		xdp_res =3D i40e_run_xdp_zc(rx_ring, first, xdp_prog);
>  		i40e_handle_xdp_result_zc(rx_ring, first, rx_desc,
> &rx_packets,
>  					  &rx_bytes, xdp_res, &failure);
> --
> 2.51.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


