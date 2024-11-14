Return-Path: <netdev+bounces-144923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BC29C8C81
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2942877F1
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E071DFE8;
	Thu, 14 Nov 2024 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GhIOX0zo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AC71804A
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593400; cv=fail; b=jlQFe0dsEs96l1kCCJieSb3Tm9yKpQkIgHHDfnQdpDF/9jlDFjEUFZiGKhSy8aGLkfxI0M8qTMf3X7JNOPK1t2hh/YNZZz4J9GobU5vRA20mcqjKqHTk2FGpgQObu8xLu+zZ5rrbDfuuoaIA1+LqguJuF5cL6gocivUsmNtIHk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593400; c=relaxed/simple;
	bh=BzsCfdwtNpcaBwvUXyZrzmiNll7/bvPLILkyusSg4SQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ktIYWoj0M6dKjzpE1cORpnixij9zOnRh/74ZVmKETl5UpYElPT5kCCgc/2kPPPFzjYOcMT+HqgIFF0b1br4F8bCt5h5cBLYkqvVxOfZzk2hCgFiTV3thPgrCzYZrNr1e3fL11Pz95tG1R9nBDPMnKAHmCTKZab6TAByjWDJzekU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GhIOX0zo; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731593399; x=1763129399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BzsCfdwtNpcaBwvUXyZrzmiNll7/bvPLILkyusSg4SQ=;
  b=GhIOX0zoaXNGsEYFEyXgZu1ntoVTdCXTu/6z4enVYftLkowp55X/2dQ5
   KJHI2GPALswiMMSOD7ZPurGQdSVAB5Nem5um3Te5TaAwM2ceIo9YQuEqV
   DHiBwaUgpSjckeDT6yxWgbVm9fVeGU415S1Kz8/ctuG3aJVuiGC0iypO4
   vWycVTiCAKd8CbEejrw91hHpOmmeiypK+N3KEWa9DuFcD9ZlkeMhq9UV4
   g+wNUEwtWIFfkoxsZ8bhtdqXetm1hQrXx2rQz/yD+ZSA0xbg2W7YhwSYC
   FnkYIdGc8S4sviYJrGs/D6RpkU2NOGAYkbdwlskdftD642+xm5DDOH3nX
   Q==;
X-CSE-ConnectionGUID: muYg8h+nSqy4Alkq860C8g==
X-CSE-MsgGUID: AqvnjWjaTkWOF7uXtbKVOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="31641839"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="31641839"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 06:09:58 -0800
X-CSE-ConnectionGUID: j7ucA+ZHSpGSCflGPGb2Gg==
X-CSE-MsgGUID: jGbRBDiRS0qOY6VuIXrAow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="119150826"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2024 06:09:58 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 14 Nov 2024 06:09:57 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 14 Nov 2024 06:09:57 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 06:09:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEMk2U+jsCzUfVWBTcWG/U+jw3HrDsAbVUzIz3KFF5FpqblIi8rGZem/EIsAK7y6xfC13aI6ndPs+wCFtNfnrhRcue8J2wftThonnpSilPuiN9FIbosTKyiJw3i4oS7Fopab+Rh8IdTQyrAzH39KtZuHtVM56jNehaQWlmw9+6T+14mu5ttZyNufr+uV4W33u3Pvex2tSlsQOF3KnkGE6hyMSeFs1XaDO4QoRgbpEltiutZ0pmaHUxKJf/R3sV/5jFSVkgIq60N9uuCiNeitmF1j1sjIuzguZkTAuOgDsxF/EJWNqyb/Xl1AnE3HtS3QUb3VxgCJhGQn79V5tEU95Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shqgH1v5AVc1o4rp8V5AxzXYA0qnGAj9XbbXHszutLo=;
 b=rXcNPmW/0+yOVWsUfVU1OzROw6ks3AB7zh5hhcR6xVlim9OO0yh/KZOOROck/Ni3UxBJGPApCJ73PmFafo14pFITYB8e4+6hdFgLQEH76RQbd3542yE+aAL/ybN/95lC3Er8RXSq55XmOes0y6XOxiwQ6JdPAsOUEzR0mVOHxwtbn0Md207U/wvOiflvMiAHe9cJcGqqTs92dv2DFTJ7czSwMNeufR8hg6nDTBEAnWD3zOvtPZ+6P9Jxi8nG8ir17zq7DBcrBALYZadARyVnDWvT8Pq4VxM+y7BvgwIJuBSMEfGCJvHJG/uKokVZ7m8EXom0O5YBFYWvB793ktK3uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by DM4PR11MB6120.namprd11.prod.outlook.com (2603:10b6:8:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 14:09:54 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%6]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 14:09:54 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "Drewek, Wojciech"
	<wojciech.drewek@intel.com>, "Szycik, Marcin" <marcin.szycik@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Knitter, Konrad"
	<konrad.knitter@intel.com>, "Chmielewski, Pawel"
	<pawel.chmielewski@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>, NEX SW NCIS NAT HPM DEV
	<nex.sw.ncis.nat.hpm.dev@intel.com>, "pio.raczynski@gmail.com"
	<pio.raczynski@gmail.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-next v7 6/9] ice: treat dyn_allowed only
 as suggestion
Thread-Topic: [Intel-wired-lan] [iwl-next v7 6/9] ice: treat dyn_allowed only
 as suggestion
Thread-Index: AQHbLrMb7/zINDM8cEmCYdDnuD+WfLK24AgA
Date: Thu, 14 Nov 2024 14:09:54 +0000
Message-ID: <CYYPR11MB842967FDC9362FF15886916DBD5B2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20241104121337.129287-1-michal.swiatkowski@linux.intel.com>
 <20241104121337.129287-7-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20241104121337.129287-7-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|DM4PR11MB6120:EE_
x-ms-office365-filtering-correlation-id: 1dc87863-5551-4aaa-8267-08dd04b60341
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?8tZ1V9hBVhge1z7oFuP7W6S9Xkm3ga0/z6kJ+VEesoW0ml5aF/hqirFKJ3wq?=
 =?us-ascii?Q?E8k7pRS0IyHdGp9rk2fq3pFdHhIxxz4EwRj3UgQyVE9L5p55di4ihjTAoERi?=
 =?us-ascii?Q?O938BzoaSeR8r7fr89hFI/KY8nH8pvYzkLG5EAanfchNC4ffJihbnyNIHD2s?=
 =?us-ascii?Q?DZCJEXntZn1G1f08BqiR8KqGgg4q3DQHpLxUEWAtWP/QHlbEztmFGsm+NJRN?=
 =?us-ascii?Q?IFakB78sUUOcS/KoxivQdwyygQHt9vNuorNwBjuwzuhXq7iAyMl0NpFlyFwr?=
 =?us-ascii?Q?js7iM4WYK6c7a18F+sFQuJsssrYkLptsMx6kO29I83+W1nW5VzTvLH5x6Tmg?=
 =?us-ascii?Q?wNZ32K1+unrf7rXB5bnEgErks2Er0NLjcqfbgRNfEkfiKosil41qx2nuhXaM?=
 =?us-ascii?Q?2QpvNHdf2iTXGZ1rmpNoD4YoUpwXZIBIplHZWifMp++McceuK3GXePrB4Btk?=
 =?us-ascii?Q?VP6L0F6YN1Tdh9yZp+x6nXeDLyFktHOaYhyFc0llNLlDrOV2fx4iaLz1R4GL?=
 =?us-ascii?Q?/TlPSiTla9VadF/vy1dZmeMP7qQf2IloMSLMsUEO9gNiiSVl2vFarluHSp7F?=
 =?us-ascii?Q?mJKQ4TO6rh2Vv4ChkMzfvn5KOE8O/0jGyY7W2Xbx6oOUAeRINVQFJCY2ujRm?=
 =?us-ascii?Q?1gSXjZHlboTtiTVCX4LpxEJ2OhEwJ9fqM80ri+fUQPmemqpG6PPIUCgdvZ/w?=
 =?us-ascii?Q?GBIc930BgBzvlKJ1AmdxIJ22MhX3d4Nx8/sfQINO6wH36c5Nrt4KmxTzXErN?=
 =?us-ascii?Q?8nm6SSCUH5s5Q8dpe/IDt3R0nEsKpyhaQYSsGnAMt1CID6NcZ5vTjvJgMhaR?=
 =?us-ascii?Q?G1d1TV5t3681QTY8mCf0uEqkxwgMWIQ7vRuyEjkE29htLCYi382Z/FthYR0n?=
 =?us-ascii?Q?/F/RUDhE9AE8RqCW92wygb1Duk10e9Gj4MaDBMGGbjnDVRBuHZjloEPMdlOn?=
 =?us-ascii?Q?Dz0qlT9+WmenJAXGISbazbTQfvtPrUaeYcKgr+8kSEEl3zjN1x/J13Knwxae?=
 =?us-ascii?Q?WniB7ATDy2SExHCRm5uVmtPyfXU6U9VoDSFxbNlYlN2MOYruPqn2vVJpfkp6?=
 =?us-ascii?Q?cvS7buxD8Ih6+tyJRRvwO8ZT7w6C3qv/uOFypakQpKNtITMpO5xCdPPlVA9i?=
 =?us-ascii?Q?+FjQIQS30Ciok6RlrfvKygfPQkLGkyQZmX2aLbjUD1PWhse7UgoL3Bfs70fu?=
 =?us-ascii?Q?AzmfFGdLGOW57RKTOR2at3nUXNWegI+FtT8B38lzqOuDsFIXG636dsh1hdPI?=
 =?us-ascii?Q?OWct8zuiGz09LLS03fhfCzwk/M0naSv3ZWBAaRBAJ+hUizCmaMZ5IEecZhRh?=
 =?us-ascii?Q?u8eBHtaotZAXppjqQBLAsssmYDVq+zawPD0LF3iTN9GEsogScTSARvpVL87J?=
 =?us-ascii?Q?6LIkIKg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AWspI9kiaZ0pfFzmPhxaXwpCVT76lNU8XrfuxQaTxHzctqmd7DERreIIR+5I?=
 =?us-ascii?Q?rzsTbXiTdaUaUVMSHX07HilU/0coKpYx4K2edtzVR/KQoUmCfkkJkGhHbPug?=
 =?us-ascii?Q?E70nG4OC6I45SE/easgfcXkEBURY232KpldYZvM+i+rafRCCq3e2ln21R/vp?=
 =?us-ascii?Q?ThLERzL8lRam6V65kFmcSVfInnQZ8/EiGTMdR851hXf3q1iIzPmp9klE/3OY?=
 =?us-ascii?Q?sGPGl9hGos0HJEU7PTx6ntWx2uuyMOxHk/HbyGFDmxA5UitbgLnaiAkQddyx?=
 =?us-ascii?Q?jT/vECdyHxne4Cyqk7taxebLGwE/TB763fMYB1Gw25csSbYWv4nO5qcIw7QR?=
 =?us-ascii?Q?49jwH5JZLj3r+GpCWqpfq+E0LsYp9nD1Ys6SKWyU0BsqHDheE6GSDyDYo0ua?=
 =?us-ascii?Q?Hv25/XFqeHhXCSG7Wl05D16+ZREc+xLlrPdFZKBx0xDWoy8eaycJn6jXfcN5?=
 =?us-ascii?Q?c5r0vYakp0CLh1SCG8xtz/PknB4s7+HS7o1CmISljTgrkScSTcUd/yxnyP60?=
 =?us-ascii?Q?VzcfshWrRxeXdgFchUUjsFudplHSQYO/pjz5sCehl7VGWYtZI/hO8BWbBcWR?=
 =?us-ascii?Q?YQ4fEVPwRjW1yclLY2tRjuS0KDCk176KycawgwIz6auv564agAnt9Uq5K2Tj?=
 =?us-ascii?Q?kNlcBECYosZgh1YBeA+fE9D88+o5PwmBrA8+3wrvuOcXb0uqGi82QzjRTH0t?=
 =?us-ascii?Q?4oxY+kNlXaE+qtGCbzJispKEHN0LvBNyY1wCCokl5mxTtS3FjfsIZPqDgY+t?=
 =?us-ascii?Q?kAcrDDmxSk71O3sIGzKmsJtS8NLkWasbtSQChPfFKZx8wGUj74ZTsLVuN9uN?=
 =?us-ascii?Q?f+eN9QwBHqmmHMfRA362XoXhg7RKIGPoQdhA3ETAKBaNckySCYBDQkCmu4Nl?=
 =?us-ascii?Q?uxTtLzwXpKZQc151hoybM7/usj5OnRiNHWp518purc1xa2qN4G2QCWH/s9vm?=
 =?us-ascii?Q?tTjqwolmBsuFYUkn1kXKGUbDy4pgB9Y6zbGSAKzyTCsIRONPKoh5OZ+lusYT?=
 =?us-ascii?Q?vHmcakvLSiFFDJsQaOhgDDSjO5mkZgTNXysTh2uc1x86Smj3BeBRUyX0PQlm?=
 =?us-ascii?Q?z9m6+U6qCZx6C1/kpo03wGZkSed/RCeAFpPJdu1ezXBxd3diDKSvqpVTUflv?=
 =?us-ascii?Q?FYXX+0sQqnKzth+1lAXUY3A/M/OVOZYXEpni98xQXYxaKqLyQxfHBUCbCFDE?=
 =?us-ascii?Q?UtMCG89KRsNKD1GzDPTIS74H906YpH2u7LTtVCQeYFlvSQWiszf7sHQxGXBW?=
 =?us-ascii?Q?MM/ZVRHVcrhbl0np0Kv7lP9ZI6akOanfzY+7Nw+WU70DLXcFT5+4U06EiXxN?=
 =?us-ascii?Q?rckR0nrDSGVGWhIqnRWLPoBFpPjZn/fhuiwzuT50+7bclA7uJ4y/aSN3m1+Q?=
 =?us-ascii?Q?9KTURUZfuFrOmQ65cqaou7verR0qDdcTxMg3TLjjK/H3aSBwgLmE9EMS8erM?=
 =?us-ascii?Q?ripa7VL6btvwig6WzZE8Rctw7I0pxrYd6vKVddS1BdlKxktr5+NmX7579YaV?=
 =?us-ascii?Q?2XmwZvL5TcXjyvTu1hNiklUd3bXB052sk+IvlgJgAZldemtFo1+fGJt84Ww+?=
 =?us-ascii?Q?8tT66RZn8v+KMjd4jb+gCI/SBI+de+TmREuBPSQon0Q7AFocxCmXZs7m0uvS?=
 =?us-ascii?Q?SA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc87863-5551-4aaa-8267-08dd04b60341
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 14:09:54.1606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4N/T87OChz87DJA98cS2Amdpks4K9TyaNBS086vsg1bZRGba93AdeF6bEbiG1kcd5z16teIH0bneeegIIRwLYT/sI4ly5IlQ7VMuBgA9ogk6yNejvCxSP79Tvcoj8ce+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6120
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal Swiatkowski
> Sent: 04 November 2024 17:44
> To: intel-wired-lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; Drewek, Wojciech <wojciech.drewek@intel.com>; =
Szycik, Marcin <marcin.szycik@intel.com>; netdev@vger.kernel.org; Knitter, =
Konrad <konrad.knitter@intel.com>; Chmielewski, Pawel <pawel.chmielewski@in=
tel.com>; horms@kernel.org; David.Laight@ACULAB.COM; NEX SW NCIS NAT HPM DE=
V <nex.sw.ncis.nat.hpm.dev@intel.com>; pio.raczynski@gmail.com; Samudrala, =
Sridhar <sridhar.samudrala@intel.com>; Keller, Jacob E <jacob.e.keller@inte=
l.com>; jiri@resnulli.us; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com=
>
> Subject: [Intel-wired-lan] [iwl-next v7 6/9] ice: treat dyn_allowed only =
as suggestion
>
> It can be needed to have some MSI-X allocated as static and rest as dynam=
ic. For example on PF VSI. We want to always have minimum one MSI-X on it, =
because of that it is allocated as a static one, rest can be dynamic if it =
is supported.
>
> Change the ice_get_irq_res() to allow using static entries if they are fr=
ee even if caller wants dynamic one.
>
> Adjust limit values to the new approach. Min and max in limit means the v=
alues that are valid, so decrease max and num_static by one.
>
> Set vsi::irq_dyn_alloc if dynamic allocation is supported.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_irq.c | 25 ++++++++++++------------  =
drivers/net/ethernet/intel/ice/ice_lib.c |  2 ++
>  2 files changed, 15 insertions(+), 12 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


