Return-Path: <netdev+bounces-98140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4118CFAA7
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 09:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50BDAB203AF
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 07:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0062E62C;
	Mon, 27 May 2024 07:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqSxgjAe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1328BC152
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796559; cv=fail; b=KC0XLouRPLd3V1MOtdiQvin7asJYt85akwpdXvbNmFMayO4kXnpwEgdNPMU/oOwLIR0i0ypCYhEOa8CxkoowzIpVL4JizjjpYPyihZVrK/WuP4KFHzs7Oy6OAiN5hDursM4Q98UL+HCSB6UTsHFQIoPTrsDgH9Vr3KhEh06/I3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796559; c=relaxed/simple;
	bh=CsGJhKyos0nNl10diZ756TYgQdYOBVLk/uQ0NFqepts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R7Q62TYU0gbVMbrCE00e+MfiO8p0CUlh6iaG6vP987KYoS3fuO9uiG2chEXOFWlfyh9v5g3M/UXKoZE1mfFzCdrlMqTGKUa3CoeiMnq2NyPuuPQMfuwjvGrQn5IG5uwWnhe6DH8KUNtiUGRQyXAQA9rld+4pVPvZuk/4GccgtDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqSxgjAe; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716796558; x=1748332558;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CsGJhKyos0nNl10diZ756TYgQdYOBVLk/uQ0NFqepts=;
  b=fqSxgjAeSpuKfDibdtNfge0HuwJbdYkRIcrCUOHoUM+z+yfBZk+ROZiQ
   3cCbinj27qaUjEaYVI2uPYEZecwHnoJMohygmhuWLgxvseuw2u3PLnIYU
   RxBruOIsZ/a6g8qi/58U5+kc4JY5Eef+t/JaMYyUq9oUtvowRSdzcBkJg
   pz5+jm++nZ+4lnC9HEO5fggsMv4G5+Pg62DewxVfNubtmE7goFGoU34F2
   saHfbvC6fflMlqp6kHMJQZyx95lzfXV02Bf6ARCB8FPtwZwQFkKy2We1y
   nY0IJGslCx+fa4Z3dLUe7Yap5uQprwffDxOWTkYPtoHr6EJJ/XD4bcy1B
   w==;
X-CSE-ConnectionGUID: j1CysHT0Rp6mP6G4bZb39w==
X-CSE-MsgGUID: G1l0t9w4S3agkvF4zFVORw==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="12882158"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="12882158"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 00:55:57 -0700
X-CSE-ConnectionGUID: KxN30h++TOOq87tB8ST6Pg==
X-CSE-MsgGUID: l5lRC5KaTZ6zRJxKzind0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="39235662"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 May 2024 00:55:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 00:55:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 00:55:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 00:55:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hr+PAOLdNxunybla74Tqlrdix4GgM9ARTQRsb8p4KDO/nkC1/MWWrwAiaKeylxPnQ8tSs7KnPvslsfudZtLgl3LM412h5ef35PCJEWbxReqQHOcCeTLU+PALK+e/g6Cl025AJCxkl2WfhfJzI6Iy4HOQ2Jg9NC3bbvFsymIXP3kadsJz9MJN3Yp2ccUBxrrw4jb+NoD25BCxWJAf8MXG6Ysm2AU+tfZzATN48l4P0CW0irK0Y/LeZrghRCNghQgzCUStRk0G90UPdG5YwWUso4VRKBnEFhU6MGSqlsBkxseYhcAHTBiINk93dGKFelkgeiNQaARkyVi2IwPKEdmy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ML2Vg6yBlpJAgdBR/kdp79XFtMB6qc2/2OW04Q3RhyY=;
 b=AXtG1LgrsfmUJUJ/Ap9NtNr18stpdtQ43372/82OptGWADZLpReCtA8gDHb0/5OpT5RhgFJd5Lr4FasMkq0RWbWGb9r18XY+85o6z4AbqyHIN6+Qkn0lsVpBXkML7gJ6Bb82l04lfr8okMwhjcLKbxgPihjIJjAbjwc4AAMoWs+70xclY+v/9Q471A2d+lW9By2mwwsr6K9gJzs7PFms7omCMrF6tL43IZBabPZKvamh+W9LsvU21p+c/sLU/KkVF6yYQ7JDDW2neclQAokMZz8FQJhgARvJz2gmU4IGp3hUOapmwE2gBx8bpVOV788yiCIhbmm1jQS5c/GeTscwcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH8PR11MB6976.namprd11.prod.outlook.com (2603:10b6:510:223::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 07:55:55 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%6]) with mapi id 15.20.7611.016; Mon, 27 May 2024
 07:55:55 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v10 iwl-next 05/12] ice: Move CGU block
Thread-Topic: [Intel-wired-lan] [PATCH v10 iwl-next 05/12] ice: Move CGU block
Thread-Index: AQHalkyuVnFhazzeHkWJc1+jKP9OSLGq6Zqg
Date: Mon, 27 May 2024 07:55:55 +0000
Message-ID: <CYYPR11MB84297D8DB841B3C24B77AD19BDF02@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240424133542.113933-16-karol.kolacinski@intel.com>
 <20240424133542.113933-20-karol.kolacinski@intel.com>
In-Reply-To: <20240424133542.113933-20-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH8PR11MB6976:EE_
x-ms-office365-filtering-correlation-id: 70bfe922-00a7-44ed-34ce-08dc7e227000
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?/ldywYuJmPExD4KaSLEzhn8XcmUNPnbcR79eptZGOJ5sHqUTnyWzqzjSBSDT?=
 =?us-ascii?Q?jvu0DTBw/iT/k6uSXtO6JqA5C4KNerawtwLD0IyxPOhJ3xSCn9PdxxbDd6PA?=
 =?us-ascii?Q?jeFClhOwez5iP0HnpE0RzW71gs6M8KHPinq0F+oyEW/m+6RA9W10ls/Nm7KL?=
 =?us-ascii?Q?Jxtow4gAVa/Ax+jPwV3h39WTjUbp/7PC9RrsqWq+gtUKOkl64hdV3qI4zUsU?=
 =?us-ascii?Q?q3JQ3ODIqZI+i5Gk9RrCJIezUPukLQsJq3Ka3mleyp0qeBQO+a96kCd9W/zC?=
 =?us-ascii?Q?UBEJcJpaOYYsGW1oqoRBNQvbS8nkzGML3pIVZGjynlg8vvs73HYHsBfGMdKV?=
 =?us-ascii?Q?9cOrRas/ZnHRCyfbhJcwBw7/OURo6AvqZdbqIjqbAHnUAb/W40tOrPpZMcKr?=
 =?us-ascii?Q?1h4XVehXAxZeO9pzs5tsyvbp1B5sjlsBUgrR+oJu8cxIYyuvsbGykEZ6O0zo?=
 =?us-ascii?Q?pXP11OGACk+GNGJOLAAJUBmTCItWsaUuc8UkdD6+gRauBIcrxzOCV01zrkTN?=
 =?us-ascii?Q?x343JYJ+8Nw2lfL3yJORCN6NfZmfFcf9AFNwy+GfEwAX+HyJYkXVZosfxFgH?=
 =?us-ascii?Q?vcKRmvjZ/hM5SRxGQQQfxWoJnixhsznqCbrdDWCp2LJ574wm9KxQ5QncZYR3?=
 =?us-ascii?Q?4eWCq8J+gU7F/354XmFYZS9+nG28n8gSfBzcpXxZw805O0EeLDs1zHon7HMu?=
 =?us-ascii?Q?3pBjEwIWZkDhZ8MTeICzQfeQegQ7o1QN4c7xmHjZxCiv/E8L8SLPqYpJKEha?=
 =?us-ascii?Q?7ueQjGsgIppozYBLH/du7Y9axd1tBjQV66nQ4KPotjbh3zq3rDOhCk6P2BAi?=
 =?us-ascii?Q?Y1odpcErxRqDeRcBM4/0dQXhvorVVpcAFub/jiI01pAOVMJ0vxRoldzqEsuH?=
 =?us-ascii?Q?Yz+rz3EWUbaQGZ6i5OCxFkpvAhwLFkNpaQEY+VHmld+my1GhmlWjDH64LBGE?=
 =?us-ascii?Q?ZnBNAUKgQcyoP6dHNvwyE5CPgkYB+qMCdQyMxHVuoC0PsbZJijkFS/MjAnPB?=
 =?us-ascii?Q?DSugzaOEDd27vCcE4bbW+2pIp/ZJdtNbLNeFQ36Ykd6Edn737FcWUGAe4ndw?=
 =?us-ascii?Q?vayXP5MtOG8xdnhTgaN4rF/HCXvEVfu40oa3Q/DbERUIdRuxhPWcxm8ntGb8?=
 =?us-ascii?Q?19lgKsm5HFhM9gZ1K7DU6tvnGo/8A1Xge1KCuaNBZAgBDDbklBZU9QMzFC/4?=
 =?us-ascii?Q?8FJ77T9CYXj93HwyuMJftQXHJfSkKWW9YQSjaclvjZ/ggugNbCxn0QEk/j6i?=
 =?us-ascii?Q?34h3a9faM21ZnHybfERQGNi5ZL1Zp7zPJQSRXl4l43mc7tMcj4+RVESewSZJ?=
 =?us-ascii?Q?68+M05rpCq+RqCF2ejHrm+U5kbZDkXKBvzVf+jmOZnSDDg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VrnfY6WU+LInsZOc5BkPZKxBmjBeyiGVOBro+TbieguGUOuqAnDSv9HYJ//2?=
 =?us-ascii?Q?4REhR+ujno5NzzEwhbBSBTuUtwvpYG+wOJKQmL0tb9kCiGucqC4DMfRB+ndZ?=
 =?us-ascii?Q?AIKl+/VPl0CHdn/XZB+xSe0vf3RXgX06eH5KnSRvcR0URdvX8BC/y6hjX8LV?=
 =?us-ascii?Q?cXZSWaklTdH9yUt5+cuvyoD4FL0jeI7YrIG3rHLLJtivZNiEuL9uJJ30w341?=
 =?us-ascii?Q?lgNTLltAnurITg5liy2OPmlaFTvtq4TUYq9k9YDtCKXyUh37uX8MFYStUNze?=
 =?us-ascii?Q?pMrdFoUAn2VMgI6xjNFhaRUNsxcxUEqGoMR1fJY6nzf8b0JsaOqIVlEvY5Fw?=
 =?us-ascii?Q?6laJ8gS4544bBXIH5zNXM8Ax1O4OvYiZTYicFWsRJjV1CzNyQD/zisxQpjiO?=
 =?us-ascii?Q?vL0llNrjnFovGzw7QJsgEoWs1phw5Xi8ZsWUeYdv7nh/ee6Nvh4bW1GkbBw3?=
 =?us-ascii?Q?3MtQV95ho7kTp3VLZSENrbwO/2Dr/TY2wyHpyJDIQQD+IVXwsij+POzGQ48b?=
 =?us-ascii?Q?+nsw2MDeTF6G9gPKWIddo5NEDJGDEek+4BQ2R+RtKjwvhclMNJKvMehqNTRL?=
 =?us-ascii?Q?I1Ry5a2IYWkIlzNik5tbVWekN/eYz23Z4brxCN7+2a2UvpgdjagYo09OX1li?=
 =?us-ascii?Q?TqEl8ibpvRvPqibWea32/g/t8eBQuinUmHf5peeUxuKv2Clk9yhk9MDRidmK?=
 =?us-ascii?Q?7QdxMDZvo+3DESRA3xWXNq789mMwtKu+Om5S0cRCRAPtLfPsJmGC+eACog7J?=
 =?us-ascii?Q?0aWPTuTPHwhdK4R3dLMo3jts5bE/RVQAPhArdkFTFU5mYLxbO63w0UnrdTKA?=
 =?us-ascii?Q?iJXCahNQ2dAhAqrAZ6Hg6e4oME//YRbGebByl9TP32gHd8f8R6xnq51eqKp/?=
 =?us-ascii?Q?+CIuo0jtgDch5lpLA4hqxZtZ2tzgm+8SXpaToq6BPvsH8YkuwTCva9uolN9M?=
 =?us-ascii?Q?2dtwO9Y4xYigacWX2dcMAiNysqka/8kE8CF5kdihMIldCiu2dpPdeqgSRsje?=
 =?us-ascii?Q?BmwiPjMtyPb3f9cNmuL5jaK8MZaPIO1HrIehfjG6m4kxRgVIpPKBkX/1jgq9?=
 =?us-ascii?Q?uS5oECVUkBh3gZiF5QP6ieJagP3mTf7993iY81yDbpD6qqxDsQnp3sZIrb3z?=
 =?us-ascii?Q?EN4RXxQyizmVvgSlWlbOKql2bCQKHynhrh0bEBs5TOYN7DMSCmE17WJxln94?=
 =?us-ascii?Q?SSZyq6dO33be0PS1dmdEZYzZvLfrCheinjqjrNMR9BD7ee0VTEizJp6Td18r?=
 =?us-ascii?Q?2OHeWSsf5Vco3lqMo+ioqOgusvxenSzbyL7der7Ye6z9aesMHE8+xKigMV8V?=
 =?us-ascii?Q?S7CbuhaQF8vH60xvhtKWsccDSVzNPjxhgSWb6Bq8kvwkfKTLElX1B4Lb20yT?=
 =?us-ascii?Q?A+xhz2aoS4yUxVNbtu0LjEtUL1+cZ8uPkGMBRRPiz4pxAMx8Lj8JcsQpuGcX?=
 =?us-ascii?Q?EK5g84MXOXDxS9GxsYSns019KvmVGCiNzRPDtUs+sCEPsFR/KtnlT8yRs3hJ?=
 =?us-ascii?Q?e1n5j8oRwy+TZQyP0YoMvUIjVB4nyPgQSMnl0Y8pC8gZJUHJdh6813v2u4UM?=
 =?us-ascii?Q?OvUEHsUJTSJXY28nRK9mRhTM3ICAsdFbJwV1mNsF1UweqMuxB4MCdmsF3LW9?=
 =?us-ascii?Q?vw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bfe922-00a7-44ed-34ce-08dc7e227000
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 07:55:55.2194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zTj9UpwtxuDb1EvoqverlJ+Zrk5c80voGzTmGgfkn7JrTT0ySmH3IipMWqndpvDJ8+bISupsXGZx4N1pJKA9m6CGhL/LsxQhpDuqcwzNOpVuJ1g7EjC+0tTnVTGhmwEr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6976
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Wednesday, April 24, 2024 7:00 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Temerkhanov, Sergey <sergey.temerkhanov@intel.com>; netdev@vger.kerne=
l.org; Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Kolacinski, =
Karol <karol.kolacinski@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@int=
el.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH v10 iwl-next 05/12] ice: Move CGU block
>
> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
>
> Move CGU block to the beginning of ice_ptp_hw.c
>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V7 -> V8: brought back P_REG_40B_HIGH_S due to 32 bit compatibility issue
> V6 -> V7: - removed leftover code in ice_read_cgu_reg_e82x()
>           - changed .data assignment in ice_write_cgu_reg_e82x()
>           - restored u32 cast in ice_ptp_reset_ts_memory_quad_e82x() to a=
void
>             false positive warning
> V5 -> V6: - adjusted returns in ice_read/write_cgu_reg_e82x()
>           - added cgu_msg init when declaring in ice_read/write_cgu_reg_e=
82x()
>           - changed TS_PHY_LOW_S to TS_PHY_LOW_M and adjusted with FIELD_=
PREP()
>           - removed unncecessary casts
>
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 1409 ++++++++++---------
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h |    2 +-
>  2 files changed, 707 insertions(+), 704 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


