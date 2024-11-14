Return-Path: <netdev+bounces-144922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D999C8C7D
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8521F2313F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E6A3BBEB;
	Thu, 14 Nov 2024 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2ACz1SP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E23725776
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593319; cv=fail; b=G3S9N3uKRYePBa7UrcbwjNKQBKcYC5PVLcz7eWEJEUjZJYDbZG3FRzOyAKmURbb/pCk77jf5H0Uz1l4Kjo73AHwF2bwpRbFz5s/lYbV13ogX58SsbVd53H5VOKNkxz0dWze3uzvPEqtTzx9u6tNzep0Y+LTKpK5RGHCQ3ag8PQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593319; c=relaxed/simple;
	bh=Q3nJn7iHndM9YcC972ma8+XfkuBNfIDaLbTDV5Htb+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OUF93AT1gPBSKQNeZj86fCq5R98yqVRAo0UfCLzAi0KWOyU5SA28Uaee/h6ax9FjaIpDDbv/ppV4U+bZYK/31Juzv/NxgJm02DDhuFTZxun8rb+Dk7uSAuRAD5C8bZ1CPhm9Q129SNU/fwAHyUIGW09UvnBjQ5gE/EjSvXSPT6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2ACz1SP; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731593317; x=1763129317;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q3nJn7iHndM9YcC972ma8+XfkuBNfIDaLbTDV5Htb+w=;
  b=N2ACz1SPX6n/zg3fTwOtR4PIg25UP21LG9NDAfzud5zhu9zGCC6upmk5
   QiDCrNDrwrhiPX0OiMTV/nmSMIBn/WAnRlwhqvyWuWtXBJPcOM2/E1eba
   bdyZQR0zw05phgDdgJGNnez8DPf719Te/Do3Tszh6+/JL7NNGtCKSPN/6
   fWO0iPADrQbgfyXADWo1fSIfEWkngZLsa3hb/hLoyElsOtjWov/YWF1vY
   AQ4OuQp447rwpLgy0su1iJyzwhCiEHTmP0XKywK3RMjOUBQ2eh4exyjZy
   VFFGIrrW2zf3lkQCpIrZXy2e63XmTBxfXX0NtE0n4gKs48dqa2yHK46r5
   A==;
X-CSE-ConnectionGUID: lj9vKcsTSHmnXmseSFoMMg==
X-CSE-MsgGUID: mmVhLti1RsCk6C5qNvWT1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="49058340"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="49058340"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 06:08:36 -0800
X-CSE-ConnectionGUID: vSwrCIqCTOWpka+5CVMN5g==
X-CSE-MsgGUID: oYXKJYimQdSgXy7ox877Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="111515335"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2024 06:08:36 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 14 Nov 2024 06:08:35 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 14 Nov 2024 06:08:35 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 06:08:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHUXKIQxqJm8MmiuuvRSkYpxlKYEPlC6EsKrROZOHfLxoKEyb5WtbSim6xHsW86SvHzLqnd6WMM/erY96EBMWDfvk/wO2uRgvzqvw6MQF6PP9k2gGlA07M2JKV69Z36q6VKe03hU5FYhcDNSX+AQQXu6u94QY8qxMwtkrw/I44/i/Mg+NR9+lUy1V2bPdd90WenPNaC9nTThlF3Sq72udYB7qJdmuNSqv1P5aER29edC30uhH7T9hNmALogZf+B5tUB8/yT9a+2FVRoyO7yjKKzynDZrRzWzy9C14JcUs8zifO05TtHrykTDQS6L9hIZrQGLnFKcFhcszqborQDiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4XtCAtH05C2G9iDATCxia9clHwYCCmtP7B6ZQ81yT4=;
 b=wqfBN+qsxK9Nkw4UoS61ct9uNfSXHo5HSqTRoH1RYgCHJDBIO7zo0Mwf3KjBGY6px1LoP46NwsmZR8p6DiZ8Adbmew0HTZ+ZFub/R38dBDNY8eSj9d/XGisTHiRteq6pDuMmfWV+L8VbRy647KcI2hOqFdaY8h5z9tJfLAlerDOm/gMWyYrDJOT6tswUff5lRJ+EaIk5KJ4Oe/TcR5j1AEye/OdWeibJ1TiQy2OkKyKbXzvnxoTxO/9PGXKm8DotPWRD/6vVIV/BtU+R96qcvQ+PMU2O6XeyHARt/MFBpUzlJMmyACQNjbAfVcoGbHxFrygHJtVcYntdI1Bv1danuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by DM4PR11MB6120.namprd11.prod.outlook.com (2603:10b6:8:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 14:08:27 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%6]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 14:08:27 +0000
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
Subject: RE: [Intel-wired-lan] [iwl-next v7 4/9] ice: get rid of num_lan_msix
 field
Thread-Topic: [Intel-wired-lan] [iwl-next v7 4/9] ice: get rid of num_lan_msix
 field
Thread-Index: AQHbLrMYVaBLaK3vrEakRGvP/mBNE7K2367Q
Date: Thu, 14 Nov 2024 14:08:27 +0000
Message-ID: <CYYPR11MB8429C80E8983D6234734466BBD5B2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20241104121337.129287-1-michal.swiatkowski@linux.intel.com>
 <20241104121337.129287-5-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20241104121337.129287-5-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|DM4PR11MB6120:EE_
x-ms-office365-filtering-correlation-id: a89d4d3b-ee5f-4d2a-2be2-08dd04b5cf68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5l0X95Uw8nZ1TELPq5ahMGq1ml2V21CbzHHXUUNsc+QZ/y4AZyzTemXDl1UX?=
 =?us-ascii?Q?pTxmPXNpvOrUDk57/+Oc6oJXuyEUgkQR7EpQVbtxyyCoDVQ63fHdTEvktl54?=
 =?us-ascii?Q?gwelvtiuLPUulw+FdbN5qTdWFKnazYfj6ZVNB2Fi/3uicDviODynaCSPtjGo?=
 =?us-ascii?Q?c+WU0atyoRzMMYTnNfhC8b6MbjewSB7M5dQLuTvQsQC99suhlFnW98FmVU+S?=
 =?us-ascii?Q?pfv7N9qWktyNSwzsjEYLgOwWEj/awwyOkPRPUI4vH3m9D5MZc2khN6oFFl4S?=
 =?us-ascii?Q?4PYEn5Ef4AaLSE4JqNQIpqCHhUn1rkwlP+x1buRwICkkiDIwntb+6JZbvnlE?=
 =?us-ascii?Q?IW0s4CbXHiYka2XqW1iW7oAOo301ZdcOLEgJErf51fTf2CIHj87GjBlY32pH?=
 =?us-ascii?Q?wWLlX2/nO22x0Jfzcxs00Qz9kLmB6OO10DWqewltGDntgBvsSvzUWqAG8ECZ?=
 =?us-ascii?Q?abcMrWnE5f9pGv5G1EFODgADk+oKwRSOg/EPDjTx44ODETwQzkWGT9MYjaar?=
 =?us-ascii?Q?GA00MGOWNZ51HspETy/KvHoOv9UFJbrHSDfHGoCzwa7wtXpbNLCZMA5mHwNm?=
 =?us-ascii?Q?SDxsme59cTY6I4CJxaZADYYi9hkP0EJO0uI0/UWOACt1PYA4g/VGcNQ0VUTe?=
 =?us-ascii?Q?sOSihsNlT7WqraoN3VUsGpQk72swTB5uPMgSjVdoOEv2XpYVoAlA+K4+M4yw?=
 =?us-ascii?Q?C3cSjOLBuvepwnw9pM/+fbOUDzlMGhW3os+OpooxPLe0/mcOdT7MJZSyT9dm?=
 =?us-ascii?Q?nX9LZKe8mx1+Of4tPvhKnPEIIrC4taZVI8RhGTnM6BcPFr9MuqdrGqTaFkEo?=
 =?us-ascii?Q?meqE2SpVYT58CpnAeRa3VnhpjqzPeq6N06ygdINPAqfRVbKPrx0rdxVjnRua?=
 =?us-ascii?Q?oF4axoub8tp1GDX3cjZSFfO5ZLXTP+WiGrHAk1qJEB8odezP9gm3b31t+xvO?=
 =?us-ascii?Q?4m9IHAXil4qXWJHCtGXX8kN/4BDParyHybRW6KjxlhWJyGIbvg7MfUyl9Anb?=
 =?us-ascii?Q?2x/WqQ/M8X41a2RhxvxM5EAkYkpxTp688wJTvJB4EIFTxoJvALPRfNCMRn4F?=
 =?us-ascii?Q?34+6C/yWytwMd0yZI7LCI28Bmswr4GhqRszH5VHgjyDQGvfyr/aJKzvekPzA?=
 =?us-ascii?Q?TEJgsAYeuuoZsjQywvK5tiUNENDx5N4t2QHEssWWhjIIrbMmzS8xOTKV/DLt?=
 =?us-ascii?Q?94kB2pm9eO4IctBuAAzm8NZNjUcXaHoZWS1N9Vjj3Fl8QCdTrSoHPnAybxsP?=
 =?us-ascii?Q?sA9a7zsYlygKhxx0ZToAfcGEnhWg6tY9tC1DXSUzFEAaZ8a7O/1sn35JbcUE?=
 =?us-ascii?Q?TvSxAXOKUhyiCuKchTUnebeTlb0BolKzaX2pydY904XeWYvVOkXk/u+7bzFF?=
 =?us-ascii?Q?nFxRH0U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TPrNSN4a2FSus+CxX/G04T2qqa0jnM4t5wquM7b0Ah2hOUwJ7+paTeBXkNNR?=
 =?us-ascii?Q?fpb2Cz98F45DRQ+rI6KxKLhlMmD7GFTr/9PxKViyDEhsvxq869bjMoA8ZBOX?=
 =?us-ascii?Q?0YiwIImlmgTEL7nhpFlFNItoaXi8Px79N/1J5QzGFhnxo4yreZG0nvQl8ZHs?=
 =?us-ascii?Q?IqPkNVzmeRlRbXGm5wF8UCrypkube46R25SUJ0e9hf+o0MBzcwLe8oG9erx+?=
 =?us-ascii?Q?46NP6pJ+Aogo7MB2TY2umSbcfE8FapHSys8O/4UxVHUYLsD/jqCy/86FhP5w?=
 =?us-ascii?Q?C4iQJSScbt9BBsm4QSkhGdPeCo/bK7v8oOrEl5cjeViip2lZ6rFEuo/BkEbX?=
 =?us-ascii?Q?eOVsrC53OheeESfLg6GbKR09S9ZLQQg6ooYEZKUY/zRYJGCvPO5X4gzdlCVS?=
 =?us-ascii?Q?cqYOcfN/8nnuAbgGz+MY+/prCeFhlLFB/2a9J2DtuBAbYVDQknEbLvjXQ6qx?=
 =?us-ascii?Q?8v26emJCL+81/ljf83wDqv8scblvLKoWx7e79hrUDOtUCNEfOjj+uUuTZ/AO?=
 =?us-ascii?Q?34H1QdXAzx5AWbYAbij9RsjsYrkuZT4XDtiz85FEXVPb2ssAGiF9T1bHfweb?=
 =?us-ascii?Q?vjpw8bFuQa2b448vxwXnH6UCjslsl2eNeVXZVNLJuqX7P3ZM5X0MWDasZ72S?=
 =?us-ascii?Q?nU907MfImFgDkyaazTXMIzLpwYnToQ2216fcAZuB2+YSREfit6uvbv+lq4wf?=
 =?us-ascii?Q?2D5lKGFHMLldC9f+yBMAqNTT+Ajg9rtnD+syCJgsaI9ioIA6AFIrYaeu8Lzx?=
 =?us-ascii?Q?YzIzlxqLqqgfSKUd3MutxubD5kAUTaF28Wz99qQ/+yVMCvxn2+rHvTFz279F?=
 =?us-ascii?Q?Zn9p02t8/CMjMdyVeGoOtYxqXCbgvSlme50BUAnc4wbX2dYjMyBvW/eJ7jsB?=
 =?us-ascii?Q?oR0nnq4skFXtSn4q77t2jhTmGsZGTYpV6g+RN1oBGHIbxcFVENobBf0xmBr2?=
 =?us-ascii?Q?BnNGqPbm1/7r4Og8o6Hh88IRnKP68NezDg9swyjMVmygn1Vw4I8lGMj3YXXe?=
 =?us-ascii?Q?OQEOIgnFo30oHE7JHYwVET0A7f01iIx8pVnFdruEmXNjezTKkdTYgRhEdegL?=
 =?us-ascii?Q?omednmkpzIKiJj5qEOaXeDvKo5zdNn15YkjQMQupVbjeXwMe+YjrMq2YC3Gj?=
 =?us-ascii?Q?EQmqpx67fc7UHNTnUGr2G32nb4+X957RmUJj8W6Cx1kmPHukIZwULUbuDS9p?=
 =?us-ascii?Q?m7Lra7ycLDvu3pLxVvfgz2DU/9Hv9H2gSXcx26+cLAZnwUTWmAfMKtj7jwb/?=
 =?us-ascii?Q?575qAA+F9ae8bVwed3/5zaK5tGb3DKtYWRQTiVv0EBIWTIMGcUhexGDi210g?=
 =?us-ascii?Q?svvWCM9X91p65tuzQXsiryco9Om3H9O2pV+yLwILWMXcw6qLUfTC7TkZyHDT?=
 =?us-ascii?Q?VoEY6F1zyChNJ7PX14LugBkz7lmX5K0ux9hGR6LJpSNFlH4Br6S7iWVx+6+K?=
 =?us-ascii?Q?u7tfrIpbGJa0MveOU3e+dvDvs3FZE8iaBNEBd/V8MrqaabLpQtnCb/dBPYZ9?=
 =?us-ascii?Q?7BzI/GMwjKyl5wwyxRJoJbttZHGPIgITXY8GojWNBb8i+O9sPbif+Wx7hsyD?=
 =?us-ascii?Q?yU2LmXzWIF18TCZ5G7ADNAHX2+zYP3Nsdlqxak+Ta6hOBiKK4qK0uMdztIPv?=
 =?us-ascii?Q?HA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a89d4d3b-ee5f-4d2a-2be2-08dd04b5cf68
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 14:08:27.1421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6z6MA39/Djh0WzI6mxSMg0gtausokX1m8iQF9gxT/MzuS4sIQkjV/RMHxJS8DwQPmUhuNtCGAYE9K0GWun1HXfx3i2vVdtEwgykJPnvjoYC11aNjrbmpMI2QihaXYx1
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
> Subject: [Intel-wired-lan] [iwl-next v7 4/9] ice: get rid of num_lan_msix=
 field
>
> Remove the field to allow having more queues than MSI-X on VSI. As defaul=
t the number will be the same, but if there won't be more MSI-X available V=
SI can run with at least one MSI-X.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  1 -
>  drivers/net/ethernet/intel/ice/ice_base.c    | 10 ++++----
>  drivers/net/ethernet/intel/ice/ice_ethtool.c |  6 ++---
>  drivers/net/ethernet/intel/ice/ice_irq.c     | 11 ++++-----
>  drivers/net/ethernet/intel/ice/ice_lib.c     | 25 +++++++++++---------
>  5 files changed, 24 insertions(+), 29 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


