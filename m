Return-Path: <netdev+bounces-156083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FE3A04E2C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 01:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA81165422
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 00:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9625228;
	Wed,  8 Jan 2025 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nU/O25GM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2022C80
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 00:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736296496; cv=fail; b=KZw3l10wjgLby9K1f4M0FaRmNoNC8QKuFffsQBnVuGJ9X4yZA/ZTnPzEXujeRWqc+R+unG+dsfkZQi4rFTIZ66Hd9g5ITKQ90RcZR/ltXhL1Ndq5QqGt4m3CdPFGh8IH5XeryYqqaGoUsCfvvrz7P05WFNnzdClilU5aUYN9UwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736296496; c=relaxed/simple;
	bh=xH4lM6CevhjtoUPlo33f6p4+DI9KWE7GzrVFchZtnak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qxsSkOWXGCE79USycYFo63nSX6YnBMZ41qkG7JnhTlIB6zz1+hYy5M1IAtXeb4oh/lnPt66q8yC6w1BpKw9s+hF4GanbvLRBnVz6westmhLtznr80R0DGrgr7kJS4e2cZAW2lYu+SxURYuFmkmvoksGOdfd1s/NCZZuMMDCy6bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nU/O25GM; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736296495; x=1767832495;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xH4lM6CevhjtoUPlo33f6p4+DI9KWE7GzrVFchZtnak=;
  b=nU/O25GMe9RZq9klnSSqkHGMfx+t/fp5Qfhy8dfMuGerknNDrvpL0DTo
   gTzm8nufQuNVrBSGIwEemMLqcJsvL3DHIHUEdg+J4utqVVNbWWi1roFNg
   Y735tk2EFgYDd6vEtbVNcNjbOEy6+A4uAMtADOL0wW1m2JUllpc1RLoBO
   2mTJtuFWjOBLwJxyE3VlBqwtSrCN5U6lvCxDzbwmQTZDX4P3GDrHp8Ik2
   yubuFg2AjlmUhONdJshiaNPEef2FW3l95nw8TspDzsbPGsKRXv1MuuRam
   pG9Uh93fLR3+iI1iChR5meHytpurHaC2j7s6ixTS6+q9fvBHhifVX4O/8
   Q==;
X-CSE-ConnectionGUID: By4w6x+1QxOWQjWotQh3Hg==
X-CSE-MsgGUID: JFltU/W1TP2AuODwqaEeuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="47861275"
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="47861275"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 16:34:55 -0800
X-CSE-ConnectionGUID: XA2BgORqQga6hkIbmXMi8g==
X-CSE-MsgGUID: 5atzak+vRnWANDUjh7Fd7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107556400"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 16:34:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 16:34:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 16:34:53 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 16:34:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADNAwE7zsoSzb/b7Jjp9qqJhIwWDVK4wApSioAGJKyAJ1HQHD3lDYKaZ1Xv9nlU/qR4mY2SV2ZWaF3QMYBQsAH7tPtyOUHeXJw0Ci1PkvgP0za/RwI6P01oB3yM+Z3cHg3geAR1iQHn9l6Imo/OCkcr97Vq+TMPG3guKrnICUldZdb3GhUZU14BFzd0aGXOVgCFowquOJxijKS6Nkfh8V9VmuJIYtOdkoCZc1CaPHx4CO5H+iT2oyPc39QtfMET/MqGbEogwdHSidtRalro20J8f8EMlFAXuELZqafSF4I3E6Lz9qm8r1pwjLqSx2jO495EeU/bJNxsYnieC2zVrbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaighqnfuGL8Wer+3QmJ4ITGe8ZbRPjAh+IHLUOZZS4=;
 b=cstenn3f5gOwRCvrQpKlVmzZ1mvMvzjoMf/66O/MLE1egR3OopmvNdZGaO+FK8amvk7Q1YzKk1mlqZA8v3e1KV5izvRwEHE/Wm1PfyPiBPJ77z4+B/ox1Eqypkjz1umcy9OxdksmE3zt1GmdmJ6Lmo8v6OMe8r3Kklki6oK79wfbrsCqnapD9KdmCScWLAEnj1Tj+TyABTReI80noOG3Yhs1fnWgdrH1giokh7WoaDYNu2KxEHUI720dmYUpEB3GnWXPB1ax9jmh6J9ZJeYlfxM8KiBqEFK+3Pwc6JuYPcatPRxzrjEOo7dufi0Nwg7KSnoP+SuUwDOcfxPa7gRajQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5021.namprd11.prod.outlook.com (2603:10b6:a03:2dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 00:34:51 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8314.018; Wed, 8 Jan 2025
 00:34:51 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Andrew Lunn <andrew@lunn.ch>, Jiawen Wu <jiawenwu@trustnetic.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Subject: RE: [PATCH net-next 1/4] net: wangxun: Add support for PTP clock
Thread-Topic: [PATCH net-next 1/4] net: wangxun: Add support for PTP clock
Thread-Index: AQHbXP592WvooA1AlUit7fQ7JWjNQbMDhuSAgAXcOYCAAHD4gIAAyHsAgAC61QCAALiL4A==
Date: Wed, 8 Jan 2025 00:34:51 +0000
Message-ID: <CO1PR11MB50894A28220E758BACAADDFBD6122@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250102103026.1982137-1-jiawenwu@trustnetic.com>
 <20250102103026.1982137-2-jiawenwu@trustnetic.com>
 <ab140807-2e49-4782-a58c-2b8d60da5556@lunn.ch>
 <032b01db600e$8d845430$a88cfc90$@trustnetic.com>
 <a4576efa-2d20-47e9-b785-66dbfda78633@lunn.ch>
 <035001db60ab$4707cfd0$d5176f70$@trustnetic.com>
 <2212dd13-1a02-4f67-a211-adde1ce58dc7@lunn.ch>
In-Reply-To: <2212dd13-1a02-4f67-a211-adde1ce58dc7@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5021:EE_
x-ms-office365-filtering-correlation-id: 56d875ff-0076-4dbf-d78a-08dd2f7c43a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?NLj+Z7pZMkzdYvGcugauJTKhGnPaLcZbOwHJJu/6d6vz7O1yD+Zzk2ICsNAs?=
 =?us-ascii?Q?D1hWfdbhoqV1ex6Ofi0v+46q05IqUOsekE1QSnzVBDIDtyXRICGkxcHMZhIu?=
 =?us-ascii?Q?L31u3ktm4NKSaRpVI+f0Mkif+7Hjh2aWXYAjdPwgUDwqsM8o8+YH8ik9edE0?=
 =?us-ascii?Q?gKC0JAhXwqZ/5RXLkwa7OlBcL8nbCTtqCTo03LXy63q8iJ0yBSCyk9pDyc+t?=
 =?us-ascii?Q?q77/meqRYX4/m39zdbdHU9nnRElEA3gBLAMnaWiLXONSh+C6BIBAdrqUUKX3?=
 =?us-ascii?Q?AO001Li1HdNEZ5Tsg/jUh9i7jjBz4HcgzYsye3YNLHCnrV7oxYkf4qV7KBJa?=
 =?us-ascii?Q?FWqwL02F68vRhrWvi9NY/o3nNYHsr3ORgTHNkrvdVBBsgy23PbX9lH+uuY3p?=
 =?us-ascii?Q?JzGyhAjFLtoqtLq8KUDQ25iBas7NUaWFbMrDy9hbKhiZ9JxtJR2YG6S88cvZ?=
 =?us-ascii?Q?9y3xzl9ENPsuZjGb+u2TBDknh1vauXYI4TrZNQ6ItYMYA0zDvjfJ8M0vsZfA?=
 =?us-ascii?Q?wbXHgaIsaUnuP2gs4/0WsDRueH4hiYYezFh1V7/QN3icOrMTBQrRupGLbyrs?=
 =?us-ascii?Q?JC8XR33XyoPjaDHLukJiueB4qoHmucWjLgCCqTuThRN10JL0kmx9lDUwQ2Tf?=
 =?us-ascii?Q?JKd4PmBFOl6qjglkiVEOO+x7sc+BPC8/BUWpTr+H1H2hf5+99yXfxNbSuM0b?=
 =?us-ascii?Q?e0xzrs1C7CA6wu2jP8M7dbSlgZQrIj7+iI7H1iezaXb5Zp470SFjegbOaQRR?=
 =?us-ascii?Q?mCmXh0Zvpynl0i8AKgPpKwPSi0VF7My+mrbYp5l1hVC4YL7EzLk9wQaWH6du?=
 =?us-ascii?Q?/rQ1QDPEQp0KUg89mp6SH/a43sedLnhVxyJlQHhvkqgfeZHa8qY/yfwmwGm1?=
 =?us-ascii?Q?GGBJR6sGAgZk2xQC9a4bWH1az76HI5K6sVLqJfXlXSV/Rhr0m+JaoU6vslXB?=
 =?us-ascii?Q?NShbHdzF/U2koVy/wrnOFAKKVVKq/XQpVz+O1VUH/A/to5zVzzBkYGL8RuL9?=
 =?us-ascii?Q?RDGUKkVcTFzJ+lT5do3+Tqcz60GMc2J+sPG9AyOqTFY5YhHokRzf5g3CxN6y?=
 =?us-ascii?Q?Sw2D2gX/WX9RKrNefq3WKdjR94h+jeeP+LFY1hVvOeA240JLxb1gTP7yrr0D?=
 =?us-ascii?Q?iG+fb99hydNpGtgWXXgsItFXZ0lG8gld/T5wYA7ekZobNrODYsSfqXoFkSCY?=
 =?us-ascii?Q?x/iqkBr4XqMGxwBH/PXt8ih8Gn69L12W1Nm/1vhm7GJN59hC1XLqRsSDt4Y/?=
 =?us-ascii?Q?jximtM0xv/sDnNzmrY0qedR3lT81jvehmoaTR83QEzJ/SifsQTRs5MzxPqbV?=
 =?us-ascii?Q?s3VFlAffqRLslsgm1nfMPYyNK0J0GfsO4QH8DJLJZnEoiesDlTa2yD+MeMVu?=
 =?us-ascii?Q?vGrBwhUiiNiL6/seCK3QollbsECOZaurMfxAGttBAuVtRBtDzdoJ1jScZX4f?=
 =?us-ascii?Q?bNnQYJv66Fp24i/042/x6Za339Jq1V3P?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+11fLX0cbD0RM7cTC4/1YypPeH4eA/Qj871tXu5daq9NS+Ihh2kFlnq+fnfl?=
 =?us-ascii?Q?rl3DNCOi6ZmMagUPKRA6zg0I0vVCHssW1jiqnJTQiDY/wRy8KarFphPBixe3?=
 =?us-ascii?Q?3bSbJ3WoJ1HJqiAPzIeq3HDHTXxn+82Sat92gspRaSoMXnR5CYRVjhJXuL9X?=
 =?us-ascii?Q?ZkVTJN5eSBtU4GPwzEeRYdCMFK83rfIMd4+ctqqNmdsVLWPQSHf4htNyoMrP?=
 =?us-ascii?Q?C43192Z99aoKhabE+DfYahKd1xRh1w8L1UzHga+QD5t2s0yzIrdF4bHYILlh?=
 =?us-ascii?Q?P0ScYMqPAUBrHGKqayzl/GDMXxs/C4XktKUMz0TB/OytTbM53EWV/b05exh5?=
 =?us-ascii?Q?KvyZtRAbYftCas6Pw9VVrepH3W5KcexUQGkEFRXfglPHU+Vo5Kkv3RFF5UIx?=
 =?us-ascii?Q?ze2goVi2Zlm7AWANmttLUqwz32ydaINgWd5GZNwnELChZT4bBXIrT7qeXchN?=
 =?us-ascii?Q?1uv4CcZNlZ+BA7zVpYPMnPlAkXoeUg7Q1PHFjBwNsWdZ0S1/+2Xhdt0pzSr5?=
 =?us-ascii?Q?j/J4MSjYp6xNV8WbF64vHfzSzzii6hoWVbWD6WYUifB/+2qA+/jDFfU1gtuO?=
 =?us-ascii?Q?JYQCugNSvL4fakbkME6qe1mzEYBqBsOhN0lObdPXujxCxsko3si0+jXvBehU?=
 =?us-ascii?Q?/bl1hwsG8HPEM2htWqDcPc4OlsfLdvvcBb0R9y3gXurDl7MtQBNqSd2VzOiQ?=
 =?us-ascii?Q?zFiyq9rTmsqR+gKtCSow2YWGbFikmxf4OVGWHQux0JFE4IqhIYfKc0z0rbLd?=
 =?us-ascii?Q?JdAWps+srbXZZmqoKs6XOUlGfmtIT0+VjeveVZVBlhoU8azW/NY3rBpsJQ2J?=
 =?us-ascii?Q?jax43wzCEsckfhgLY9bglWcav1C9dok1ipLNa+MZD2tK2qJMn/D8mzYSq3dg?=
 =?us-ascii?Q?8vIdVHNOJULzvqrBG8KA23acOu5ify60mi7fHQ5appFQMwAn94PciZ+TBrUG?=
 =?us-ascii?Q?JAGKlkwgeCiB1tLOlXSIxLeD+i908MmJNrpeTn3WgAYw407Z4sXrxskpOh5y?=
 =?us-ascii?Q?iwRMDnru1tZ5qAjCd7VbNKkc74yz9tBEF5NKfjUxCygF2ZtZRpVw3hfxowr3?=
 =?us-ascii?Q?z4w2GPCMhrTeOQAoRyL/5F5tmxg4QoKPRgDiNVomKjmUisPOb2QTFnad9vXP?=
 =?us-ascii?Q?DeDdJWjNL8n7GmN4+vqn2JwXrtyrLvugEiK1Ltj5g4iN+YiIgi6YqFbWMZiq?=
 =?us-ascii?Q?9gH3vzZ8KOjvIfjxBFbaVag6+pNeydVqjEtrNCvd5I233XyQDY3pyIQrmPMx?=
 =?us-ascii?Q?T+SphwP0SH6ylsUPmqZZpjreRSF39vRtm8SyPYUsN2QnXIsAKEW9bDsqPQVL?=
 =?us-ascii?Q?PzqPKeG65GID9+F4/qFPXo8ZEcYQFMZ/3GNnewtSKR84srBHRWd6qW0edUuM?=
 =?us-ascii?Q?Q230nwzQ9VdW1ARkXN9ut5At78oOlTd7jwEmPMxCIj4kJmizb+7sq5MOOVkb?=
 =?us-ascii?Q?F7v9e5+UoI7UM4QrQ4v2cLAda1KDpyKElgZLXxA1Ba+RN7thZTbtOHWyjQ1h?=
 =?us-ascii?Q?zdp6H1h2pWU6P2r0T5GOjmceyJ2qln5rEexzeCSxA54iitf/n/ll/57jd0HA?=
 =?us-ascii?Q?g7rbq8Oxlvdw7BhR/kpeZIkUHD6BgxEp7lreauGw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d875ff-0076-4dbf-d78a-08dd2f7c43a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 00:34:51.4003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RHQr3Tja9iyMCxGqdz4GCra9K5bOBOjwXpawAJYg0ZMFqdRboCr76xYoDlM2QKBM/rgo135y7Mir5XVtMk+ixs4Rv7y/f5DEnXD0X+rakpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5021
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Tuesday, January 7, 2025 5:33 AM
> To: Jiawen Wu <jiawenwu@trustnetic.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; richardcochran@gmail.com;
> linux@armlinux.org.uk; horms@kernel.org; Keller, Jacob E
> <jacob.e.keller@intel.com>; netdev@vger.kernel.org; mengyuanlou@net-
> swift.com
> Subject: Re: [PATCH net-next 1/4] net: wangxun: Add support for PTP clock
>=20
> > > > > > +/**
> > > > > > + * wx_ptp_tx_hwtstamp_work
> > > > > > + * @work: pointer to the work struct
> > > > > > + *
> > > > > > + * This work item polls TSYNCTXCTL valid bit to determine when=
 a Tx
> hardware
> > > > > > + * timestamp has been taken for the current skb. It is necessa=
ry,
> because the
> > > > > > + * descriptor's "done" bit does not correlate with the timesta=
mp event.
> > > > > > + */
> > > > >
> > > > > Are you saying the "done" bit can be set, but the timestamp is no=
t yet
> > > > > in place? I've not read the whole patch, but do you start polling=
 once
> > > > > "done" is set, or as soon at the skbuff is queues for transmissio=
n?
> > > >
> > > > The descriptor's "done" bit cannot be used as a basis for Tx hardwa=
re
> > > > timestamp. So we should poll the valid bit in the register.
> > >
> > > You did not answer my question. When do you start polling?
> >
> > As soon at the skbuff is queues for transmission.
>=20
> I assume polling is not for free? Is it possible to start polling once
> 'done' is set? Maybe do some benchmarks and see if that saves you some
> cycles?
>=20
> 	Andrew
>=20

Agreed, I would try to benchmark that. Timestamps need to be returned relat=
ively quickly, which means the polling rate needs to be high. This costs a =
lot of CPU, and so any mechanism that lets you start later will help the CP=
U cost.

Thanks,
Jake

