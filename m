Return-Path: <netdev+bounces-300318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E6/XKIiAM2oCDAYAu9opvQ
	(envelope-from <netdev+bounces-300318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 07:22:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B2A69DAEB
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 07:22:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=XzDf9AJG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300318-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300318-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8FB53015147
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 05:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BDC37EFE4;
	Thu, 18 Jun 2026 05:22:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C10175A75;
	Thu, 18 Jun 2026 05:22:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781760131; cv=fail; b=Z2yb/PuN6P3T3YE07nr9Z1q7H8WcGx7JdjxGoJ/0Ix6nuQDSgzu3dv1VL6tfaALnv/J/CVLjhWMngl15nlGs/jAZO8NCjeBWzDyrbCeyHu6LFCHDi5vjKx+fd3dz+2eanranH56S+QetYNXvS8iVDbRlsva3Z2VMK4X3fPkrceI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781760131; c=relaxed/simple;
	bh=E7RKPitapSOc4IBjT1fK1EPGNF+I1EcvZGYbYb5WGw4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n3m+HcYVSaf8DITKa0wG/cxzhBLNeSYA+h+sEVYyNI38UjfGLOOGj75y8/kkredS0mn8X9Csrj+9pNTqmaoAcJ0vu+b2NltT7cXYC7zTDHVsxWq1RmglFYtjeW1LJ8qVQnyGHwtob+k70XFegOKXi3o4glnP/ziWw8To5Edc7qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XzDf9AJG; arc=fail smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781760129; x=1813296129;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E7RKPitapSOc4IBjT1fK1EPGNF+I1EcvZGYbYb5WGw4=;
  b=XzDf9AJGEq7MWFFYXSOMKUKctJwkzfpaGUf/axxgrjMmLLXjwRyt6vAK
   uepQsA3OQJaaXiZNaFhMpodecDMeKiGYbFRQnaI3DK71vAXnXqrFF6gDU
   pQgayiyunxPhEVlilRyoOHcf2qJvPFOJqTvmSv1+U4LxDc/Xryzu9gYDe
   kVrzN7SvUYT0b9FnAN6BHcTf5OlQaUV7XpDKZBlDrnIIohxb3djTUYo5r
   FBXWRluFt5tqmujWjJrp78x92pkvemW8k+JcJRYbwPB0U7wI9vJYmt5YO
   srflhxOqAj+okxlRC7x94yPWwjplSi8RyGklFmLxYHsBCSUCGn45yQIOc
   w==;
X-CSE-ConnectionGUID: 3L2MZhg+Qr2KCp8oBd2Fsg==
X-CSE-MsgGUID: dzdZWQaITDmnY+nZcSGbKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82694981"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="82694981"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 22:22:09 -0700
X-CSE-ConnectionGUID: 0yG/9lxfT3+QHx3pZB7x7A==
X-CSE-MsgGUID: PSfTwzL5RcOpSGxakQa05w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="286382111"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 22:22:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 22:22:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 22:22:08 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 22:22:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPsiSq0U0spd5VKIMp/pb8RVmT3qHrmkACf3pVlnEwNbl1OhJII3INryvDN53Pk0LlEkJYhM4MjHtoxBJ+dRmdOrPGTmkZ1Sz42Xnds1jPbxjlXfPb8c/elivIJ6e4Im7d3EKJ9HPtrjuDY0AKHmG2rrDwpgQJaf84frJq8hi1taFCYb1zXQD5btGYivAXfbl2ET+ItULFuqo6CzWDn9IwmI1cpm1+aQXtLOPauR/1fyUD/ZD/PRwMne1wmO2v4tUpWZTFqQe/JSOv91qJiGNOZVB+VszlNIM5qXabeNnVDw+t25uH9qjdMnb7fdNvm+vK6A8uTPDBzM6z8B0sa1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCy75NFUvTSxxnKJhf+XbfgJpgkm2KCi+agOZukHDPc=;
 b=L3RywN4/uQPAf6rn61beAMx/bhLhcGSsysuEel18MgUqQTqQXalj3hl2GDvL4vP+nxrGrZIHddLB5CLaBLdeqZJFJM634XBOhxXdCQT12fkKFt/RxxaTWWvhlP+9d18kpD+wZuNSJCq+anKG64o1FgaXBjksXmfDlcrtXj43iHTn7FXOQ6+VDR76UV5LUCp+/9DvaXKAf/+m/pQ8PbunLyI1YyDSqrWonq076xD2j3YtPlGKpvF+kv093Zuzq/DUFai/yAXvZv+ARSNx7czt7KSJUTVHBidUO/6wMc+q5hejdeBMzlR5Y9sVl+S4mbhwDGcXYnRAmlNlMS0h/K4IVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB5791.namprd11.prod.outlook.com (2603:10b6:a03:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 05:22:06 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 05:22:06 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Michael Bommarito <michael.bommarito@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH] idpf: bound interrupt-vector register
 fill to the allocated array
Thread-Topic: [Intel-wired-lan] [PATCH] idpf: bound interrupt-vector register
 fill to the allocated array
Thread-Index: AQHc/qSahAo590zlnEa0FUOahhGS1bZDx3GQ
Date: Thu, 18 Jun 2026 05:22:06 +0000
Message-ID: <IA3PR11MB898651F1629492D018DD17ECE5E32@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260617215754.1117178-1-michael.bommarito@gmail.com>
In-Reply-To: <20260617215754.1117178-1-michael.bommarito@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB5791:EE_
x-ms-office365-filtering-correlation-id: 82c01f1b-95c9-4dc5-b0c0-08deccf989ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|921020|6133799003|56012099006|11063799006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: QdH8q9aT5eYhc0pjMIufrTNY0c+YmJJiUXcU9qg7IRYXXY4aSkabIe7k9tOzoi3fVgZOiWtstE+A9aZj/SQ6cIIN73PNe9GI8UO//H6y+dS3AbealBxfg9D1bnQHbsDRbqzT+ChKKtoC6+zTwBn16GHbZELDY87ayYoCf4z2dCnFT7ME6sBVhdCpIecYs3nlojUYyCOLHohylVCCuefz4qZNKvWZ6WrPDb8ivONib7dsZP6SjBctyqxgFaQFbe2Cd8n3zgBloS3FbcCAe1+opMJfjpVrZyAV6wI5aFwlFVz6jjF5AhCOqPUD+Rjn51vhfcFTnTVhKmb3N//bLMf5OeMn9TNEIfPXpVu2v33AXpwEwPXKL0u0/JkDV+OrxM+VYwq1n32qOOex4VmXr13IQK5W1jqSfaRIiOVZiXjDCOBosZMqfRf90lfQ92DfpQ1FpjPxnTg+hSl4sgPxL2ysiYR1iIngkWNu/4jCSo0wbaJZ9WWbtg+IWMNR7B//l5UlQ+Eqam/M4X+/E9gI+lahsOpD8b6zevjQVnAxe0/+AZ/Lt+1nnJPHGAiv7YgcIpjfM7WgAg2L7qPoK9RGDTRtvCtbIWQEz4QlL+CPL4I3T/+q1cpCq9Ja6QbF1NvJ5SVXLvTMYvuJ5lZ0DElAylYC6yMg4h6UFG5ldg8YW8fqf3QToDG0VsrJmCwuryZtxkhG1lFZ4VzfbUJtiSxvcqc+eTO2tJs2fHf5jM0VOsn8WfZlR1DujcvlVNh0LQJrSR7HmYwmDvr2ZQZmAagbYifIlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(921020)(6133799003)(56012099006)(11063799006)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GREBx7rbfwBddJhIEiPt4erV+pDKRPY+27F1cMQb4BJ+Zzdq7PLrV2JM3ooz?=
 =?us-ascii?Q?lpwqunCWJaARon6G+qAP5YH4yO14klBCX1Y2Az47le9PwtzYn9gu+v/JPF1Z?=
 =?us-ascii?Q?NhGiFE6i5C2KQOYFKsWj2Mt7ctCNyv59bu/Yc12Gg1BSVVXFfm8A3aA8K+ey?=
 =?us-ascii?Q?nEwm+KrMqLaTgruytuObx56SxcEdl1u6D8h4cjpVdDy+IEpIAvYEQfiRAuoQ?=
 =?us-ascii?Q?aRylK6P5jlbHnl3+nc4Jn/cqe8sSs2mEizOkJgxDt+fTMsMr0EKzVaZ3qKJk?=
 =?us-ascii?Q?AVHces8fCLqCBeusmMXC6EmU0MWTsrbhnD+Y+O6xwjGWQurBSBQw+GCLhXcA?=
 =?us-ascii?Q?OybOQJEgy7fQ/7+m0VJmXRETjOEYQAzQz2i8YHgeF9Un0HL0AWA0oJEfIUBh?=
 =?us-ascii?Q?YzzqRzh8rsgBw/Bm//HX5gK7fhO75gKDMqZ41IgGZiF6MpK8K24eqt4WZjL4?=
 =?us-ascii?Q?B0EA1Z7vtdgLpO5ZR9GXfJ4RHuZzALmCJWI40cZiICDrbTjFv0+UMSgKqW77?=
 =?us-ascii?Q?yViXyOAxHMPIAsBD4s/tYdNDXIip87WJdm7nWJ2WuTZjI683P9yxtVz2Kq1Q?=
 =?us-ascii?Q?CGB6R3Ui9yqtKiCsXzSCIS7yJJtFF5kYzfVhdRKmphEx9X9mSiwdACuHfl5g?=
 =?us-ascii?Q?INgv9Vs3+0NIHDf8asig343eoXPtQHtDmfkA0LvEMDxrkR9t63/y3S6belI0?=
 =?us-ascii?Q?4977XCJLttZRpbp3Hmh9uDRmR7EY7UvGqX4waZjnjkBWa/AAFV/SWcQFFfZy?=
 =?us-ascii?Q?nfk0V8rLjN6uHnES8jtxFe36k9K14/1iPMwB5sYPHzhWKIWCU6OevXqEhFdy?=
 =?us-ascii?Q?DSaGOV0wIemskoNqV9Vh99+bXkfW6UVIXLwxVtTkELCJHxWPAKbry4cMWyQ4?=
 =?us-ascii?Q?Z7dJIcTptl0k0FjLnyS/7ovVb6Uf04RVLudiOSpwl6Y8eDeh+TU2NHTj/81q?=
 =?us-ascii?Q?DpEECNfkxn4fZ077hmTEOlxMMjnS79PGP3quNEcjvd9K6AKg/7pVkiHxr76j?=
 =?us-ascii?Q?7MYn3j+2JADQm7z3joIfIsSZMCVsl7ai1YWo80GPjusOIRLP5CDbHIu6Qea2?=
 =?us-ascii?Q?E/zdyXfu0wdFXz4MJJ7OtLbtl5NBTyZHYqZlizNRjycEcTFCDQMRYlJ/GTjZ?=
 =?us-ascii?Q?K5qs9OvQrMUStw/MoRfzAHEs7HVCYqzx8OA4HVIrtnqd7wmlnIdNvHymv+DC?=
 =?us-ascii?Q?ldt/zJFz7i9w++LCazZqvwiE69thm7y0JmbWheDSN52YRfaBcanjA49qr0s2?=
 =?us-ascii?Q?iAsDWYs4hpwCP0wm91Hxx4zTzNL6gLv1AeA8PT0sUQCi29FLRA3T1D2llEB0?=
 =?us-ascii?Q?ST1UMVondE7mNhdOV/MrOKjHYmOVYn5T0znUfcnODdkfIWQc8g6mQnj0VrKx?=
 =?us-ascii?Q?MCj1MUBCKK96UfOmqhHHb9UaXTXbxY//SU0bhrS4SB5X3/up+X6Mc1cxplYq?=
 =?us-ascii?Q?wpxrr97uhOywt0uOPcVlY+1h+03uvouUpDtR4NTyOR+cyZUdJNuP+Do6Z2/Z?=
 =?us-ascii?Q?HcWrjKaN545Aze5xgp/3vfDQMY32wth/Q3QaXdYO9r0wboAtYTpehqdFLZKr?=
 =?us-ascii?Q?dK+a/fj5f7Pt4TsdI3we7VSy1Borvere6JMMCIUTr5wvFmtiPvoLX32e+WsP?=
 =?us-ascii?Q?Hr1UQOlIUeIk0iGBsq0fi535vcbjGrmWIpnjkOLtP6uaUTvgeAEsH1f/A2w9?=
 =?us-ascii?Q?R2i8WuZz4q2W0gRaUPvTp/AqSJ/6YXL0EGHa0GIQXieW71Bzp7UMzB683/XJ?=
 =?us-ascii?Q?M2uwD5+T1FyFOhO4zmmPbGztVSrZ/Fo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IBH17azCHHi96PGLm7FYDftQ8CcUbrOc3wTKZFE7As6En2vhpilI9tuVkgaIG7m9TR3YszC32rVi+Z2uEBP2tGxAvaInN/K7m5k2Ol9r7Rjmh7pQR0UJOuucaAhZwnR5Jj3GPw1ggQiEK3itI+oLHU/EIHA/z+mKRS5dXIUi90rQKdlySuJmfdbZFnHogOjmfOjR0DpQ9ZsK2xo0n3Bl+mtLjqL5KO50Tx/DWX4HYx++0r4IEjFoDGKynTZrrafmb8Kucr2R0+gKARLa5mknwgcg66luevUvQ2kuNDugmrgZC7Ecwj0BreFezUnzb+V6lH/1aoi/Cd130tdCu05EfA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c01f1b-95c9-4dc5-b0c0-08deccf989ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 05:22:06.1599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6NGpl4dzeDRfTeXbPxHbfq5siN4t9nvAeJmTaYRqjJm7wBAXMpOk78SRIxqbZU734kqODcJP9GG4LWW7jMvEjFnKBR6AeNXpsv4TrDORn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5791
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300318-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:joshua.a.hay@intel.com,m:pavan.kumar.linga@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,IA3PR11MB8986.namprd11.prod.outlook.com:mid,osuosl.org:email,intel.com:dkim,intel.com:email,intel.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0B2A69DAEB



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Michael Bommarito
> Sent: Wednesday, June 17, 2026 11:58 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Hay, Joshua A
> <joshua.a.hay@intel.com>; Pavan Kumar Linga
> <pavan.kumar.linga@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S . Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] idpf: bound interrupt-vector
> register fill to the allocated array
>=20
> idpf_get_reg_intr_vecs() fills the caller-allocated reg_vals[] array
> from the VIRTCHNL2_OP_ALLOC_VECTORS reply in adapter->req_vec_chunks,
> bounding its inner loop only by the per-chunk num_vectors. The array
> is sized
> separately: idpf_intr_reg_init() allocates kzalloc_objs(struct
> idpf_vec_regs, total_vecs) from caps.num_allocated_vectors and only
> checks the returned count after the fill. The sum of per-chunk
> num_vectors is never reconciled against total_vecs, so a reply with a
> small num_allocated_vectors but chunks summing higher writes past the
> end of reg_vals[].
>=20
> Impact: a control plane (a PF or hypervisor device model) that returns
> a VIRTCHNL2_OP_ALLOC_VECTORS reply whose per-chunk num_vectors sum
> exceeds num_allocated_vectors writes struct idpf_vec_regs entries past
> the end of the reg_vals kmalloc allocation (KASAN slab-out-of-bounds
> write).
>=20
> Bound the fill loop to the array capacity passed in by the callers,
> mirroring the sibling idpf_vport_get_q_reg(). The existing num_regs <
> num_vecs check then rejects an undersized reply without the out-of-
> bounds write happening first.
>=20
> Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> The reply originates from the control plane (a PF or hypervisor device
> model), which is trusted in a standard deployment, so this is a
> defense-in-depth / robustness fix: it bounds a malformed or internally
> inconsistent ALLOC_VECTORS reply. It is a genuine trust-boundary
> crossing only where the guest distrusts the control plane (a
> confidential VM or an Intel IPU posture) or the control plane is
> simply buggy. It is not remotely or unprivileged-reachable.
>=20
> Reproduced with a KUnit harness that calls the unmodified
> idpf_get_reg_intr_vecs() against a crafted req_vec_chunks reply
> (num_allocated_vectors =3D 1, four chunks of sixteen vectors) under
> KASAN:
> stock reports a slab-out-of-bounds write 0 bytes past a 12-byte
> kmalloc-16 object and the test fails; the patched build is KASAN-
> clean; a well-formed 64-vector reply still fills 64 entries on both.
> The KUnit wiring is repro-only scaffolding, not part of this patch;
> harness on request.
>=20
>  drivers/net/ethernet/intel/idpf/idpf_dev.c      | 2 +-
>  drivers/net/ethernet/intel/idpf/idpf_vf_dev.c   | 2 +-
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 5 +++--
> drivers/net/ethernet/intel/idpf/idpf_virtchnl.h | 2 +-
>  4 files changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c
> b/drivers/net/ethernet/intel/idpf/idpf_dev.c
> index 1a0c71c95ef12..4079a787657f1 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
> @@ -87,7 +87,7 @@ static int idpf_intr_reg_init(struct idpf_vport
> *vport,
>  	if (!reg_vals)
>  		return -ENOMEM;
>=20
> -	num_regs =3D idpf_get_reg_intr_vecs(adapter, reg_vals);
> +	num_regs =3D idpf_get_reg_intr_vecs(adapter, reg_vals,
> total_vecs);
>  	if (num_regs < num_vecs) {
>  		err =3D -EINVAL;
>  		goto free_reg_vals;
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
> b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
> index a07d7e808ca9b..6726084f6cfa0 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
> @@ -86,7 +86,7 @@ static int idpf_vf_intr_reg_init(struct idpf_vport
> *vport,
>  	if (!reg_vals)
>  		return -ENOMEM;
>=20
> -	num_regs =3D idpf_get_reg_intr_vecs(adapter, reg_vals);
> +	num_regs =3D idpf_get_reg_intr_vecs(adapter, reg_vals,
> total_vecs);
>  	if (num_regs < num_vecs) {
>  		err =3D -EINVAL;
>  		goto free_reg_vals;
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index be66f9b2e101c..ec7330603ff84 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -1318,11 +1318,12 @@ idpf_vport_init_queue_reg_chunks(struct
> idpf_vport_config *vport_config,
>   * idpf_get_reg_intr_vecs - Get vector queue register offset
>   * @adapter: adapter structure to get the vector chunks
>   * @reg_vals: Register offsets to store in
> + * @num_vecs: number of entries the @reg_vals array can hold
>   *
>   * Return: number of registers that got populated
>   */
>  int idpf_get_reg_intr_vecs(struct idpf_adapter *adapter,
> -			   struct idpf_vec_regs *reg_vals)
> +			   struct idpf_vec_regs *reg_vals, int num_vecs)
>  {
>  	struct virtchnl2_vector_chunks *chunks;
>  	struct idpf_vec_regs reg_val;
> @@ -1346,7 +1347,7 @@ int idpf_get_reg_intr_vecs(struct idpf_adapter
> *adapter,
>  		dynctl_reg_spacing =3D le32_to_cpu(chunk-
> >dynctl_reg_spacing);
>  		itrn_reg_spacing =3D le32_to_cpu(chunk->itrn_reg_spacing);
>=20
> -		for (i =3D 0; i < num_vec; i++) {
> +		for (i =3D 0; i < num_vec && num_regs < num_vecs; i++) {
>  			reg_vals[num_regs].dyn_ctl_reg =3D
> reg_val.dyn_ctl_reg;
>  			reg_vals[num_regs].itrn_reg =3D reg_val.itrn_reg;
>  			reg_vals[num_regs].itrn_index_spacing =3D diff --
> git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> index 6876e3ed9d1be..9b1c9c86f6eac 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> @@ -104,7 +104,7 @@ int idpf_vc_core_init(struct idpf_adapter
> *adapter);  void idpf_vc_core_deinit(struct idpf_adapter *adapter);
>=20
>  int idpf_get_reg_intr_vecs(struct idpf_adapter *adapter,
> -			   struct idpf_vec_regs *reg_vals);
> +			   struct idpf_vec_regs *reg_vals, int num_vecs);
>  int idpf_queue_reg_init(struct idpf_vport *vport,
>  			struct idpf_q_vec_rsrc *rsrc,
>  			struct idpf_queue_id_reg_info *chunks);
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


