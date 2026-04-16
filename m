Return-Path: <netdev+bounces-278980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEudNaam4GlZkgAAu9opvQ
	(envelope-from <netdev+bounces-278980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:06:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5596540C00A
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AF783038A54
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 09:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB9E39656F;
	Thu, 16 Apr 2026 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+kntHiX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3725D396587;
	Thu, 16 Apr 2026 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776330308; cv=fail; b=e+1Ffbt6hWRP50LNWNccTO4sh5cCu9nKMf5gOh5KqRwWAPjsGQM6GR7UHBoJYXc2sxHvdIxNTX3xWNiXET/sk38dSCGIcuNITL/NwFstI2NUm4BieGAMmZ+LvGtAB2XbVhkN4OJvhZddYPDZBCIylOkJ2MXUy0vNgfSsSg0kVQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776330308; c=relaxed/simple;
	bh=9QxXlLBMextXSIgFJdpffG4dsUYMNrKnF13avs2g+Og=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MEweafgvmIGfgnXcFe/m+7Hs1YMEqL/ewufpu/OpQqRGfhnSeLpLNWiIm+0UR15B9f3Vd4obAvbG0CyBavG0ji7dmrw0yaulgwEkAKHAv3unKn+Pt7epflwv2YIKI9dIHfm7n+zj4EzJp9s0apeJ/2zljrqw71a1EPtiatktXPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+kntHiX; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776330305; x=1807866305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9QxXlLBMextXSIgFJdpffG4dsUYMNrKnF13avs2g+Og=;
  b=T+kntHiX5/kD8aldhST72GZS26eEG7JjguO4Y1ebrmZEKOXR2UW7CQ1P
   YXYDTTdu+GCyrsDLERjObCRiaLo2BNvfyCANhtHEPsYbq8+0X1+cwYWQ9
   vFnpo3qLTDCUnpf5+59BoEatYgrIWLYoZY+EMPfCLdGdp9wczpFsRltX1
   D2lYIvysz/K12YUmqj1lRGbH0yelZ83il1mMt+j//ookMYecBSR/mJQN0
   s3xqXLOfMFgYgKpQIxsTaWqRJkTvSX84DMt/DtpTd97Pjv6XiAqt/NdgP
   fRzZA2sE8uwajsxqKVS/x7v28PqZfEdZIZvqdJx7+y3LrJP8mRccJnv2t
   w==;
X-CSE-ConnectionGUID: ydzRHqeVRLykHFdEEOtwxQ==
X-CSE-MsgGUID: giTtWLOfTyq0FZ3foe/+Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="76492342"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="76492342"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 02:05:04 -0700
X-CSE-ConnectionGUID: eY+mhVq7Qlm1p84yq9/9sg==
X-CSE-MsgGUID: MTcbP2DPSkWgh/0mafGgWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="261100650"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 02:05:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 02:05:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 02:05:03 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 02:05:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUTLF9WcF6frGn851nfkLzyPlMddqH/6+O4Adc680tquDtEi0p3MeNgp3x09xTEkGs9BUk3vQnQIwTIrRAxHbVxcsA4ltfTRsa+VkHjijGUxjE6DqppgQUNXKbE5Cnzy/T+MHJ0ZxiAgic5ebK+6oB73bPDEqtbvgzGuOuNKqFMiSBoIX6iAYsd57Yea1Qci2Rp1F5zwz2YXs4K4UhQ/ORORONFTp0Ai/bNmMGAvY12y48ROeYOBjwGokH5sZ2ONsVdDDWsCTsugwAmMNXrw35c5euaznidz9KReiy8D4dyvHUBktQ5khKrofDVt20UwnCrooed1th60BU0eRNoS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyhcoZ8QJY8VIcjL+Z2GHgCCIut5tN/b2TI88ZZSXNg=;
 b=EBMtyXHgzJlHCi3wFfTwIkeM8E3Uu4vUqCMvhsDHJYAJzg501AE8FoYmV+XuvxPczBEMIMtdVA+7aMlYUE40C1Cv9ZnD5TVtv7C8pKivRnl09DI6+L+J773px/tom7Za5p1dLGpaVqv1vP6AxMOQkfDSHGCN5OcWGOnCagagTd+84oz6G7fxGxyUiQvBFAIrQNP8rO6yrrxGMSTdLJY7hbx7d5zwdH+CKm7ORc25yn9926qoFPNxEhfIvSnFExvnar7McSenNf/Mr60NAvQhr1PSDIj4DK8oo7/9TBd6ETdUHd/EiCZDdHfMPbZpKHbRMYS0Cd5fWZ/+EfZaB/iWYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH0PR11MB4998.namprd11.prod.outlook.com (2603:10b6:510:32::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 09:05:00 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 09:04:59 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: KhaiWenTan <khai.wen.tan@linux.intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Abdul Rahim,
 Faizal" <faizal.abdul.rahim@intel.com>, "Looi, Hong Aun"
	<hong.aun.looi@intel.com>, "Tan, Khai Wen" <khai.wen.tan@intel.com>, "Faizal
 Rahim" <faizal.abdul.rahim@linux.intel.com>, "Looi, Alan Chia Wei"
	<alan.chia.wei.looi@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 1/3] igc: remove unused
 autoneg_failed field
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 1/3] igc: remove unused
 autoneg_failed field
Thread-Index: AQHczUdk7jvNzt90+0mWQQY7fQNs2bXhZX0Q
Date: Thu, 16 Apr 2026 09:04:59 +0000
Message-ID: <IA3PR11MB8986FBD15356E53E84F526B7E5232@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260416015520.6090-1-khai.wen.tan@linux.intel.com>
 <20260416015520.6090-2-khai.wen.tan@linux.intel.com>
In-Reply-To: <20260416015520.6090-2-khai.wen.tan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH0PR11MB4998:EE_
x-ms-office365-filtering-correlation-id: a37d3ab6-d560-4c30-13d2-08de9b973cfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: eZVKU4leskHX8gdJMQN5Hlll/jrf2cTFNTvvFPvPhHGO8GeCnyTQW6v/Z8I65Lz/or7QbGeZYwHgQnuHFxru2Dh94hTM1AMBB3eO4qdK1XIi2W8nyhWJ+T5oE22IEp+LaYw7YTeiMgAPkpYqoRmq9mO9vXqv0Nc+nKpu9t8IVZyx1Hfjn1JzJVr9N2dE5g1kdDsT1qVA8QMcD64ssuxLyiP0LZSXHYnKPB8ocnGda5WnDHW8pemVnQaHcRMlLBmh5kEBdivT9kASbr3OcCXQr5YD2mN00D4nREe5KhZPq8aDUx/cqSdyfhr+dbrhfZ/nAPK2h7tPJLlgcJV83kYF36oPEP9igx/plNIHuElEuD5bJeR2EyRLTdC81NvU11nWFlW5+ZP48khfr4fnpVU/l8BzQn/JLRXm0JQSR1aGZ7myhhti2RjquAkZBUyxzy072ltpxeEU0qXCJjYxFwo2c5sKP8HFCDrKv2mZanGGiCAN74yxv2T/qHq62b3Lwwpxn28IZH/sGJ85Er4PGAvV0xPK+FWJ5NdZEaa8CHybX40/lDhCY5dKFvLVgJ2KG/wiZ1nfNJB7vO1gTioX9xAID3Rve0LHB4/OJ4+YI8dFLyS1+8EdRP6gJN0xCm/RjjZHpplPSFW1Ix5aajPn6tplJiS7jP3p4BRnL7hI9vCq9bvIXTeuX3lf2516+kcSrvlB6jHWis39EDd1q/k9YqPgLcblIyU+M142g13X0onRW+meqHC2e4MadwIjVWKsxmMz0PaVrrUI7DeCgo9F0yft6BHWK6HJNz91u5Pffb2T6YolnCphI3PPZfdTf8uZSxWr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4ioaICBOMlniC0uU0xCb9M1ZYMGF2MDyVxauxS9CjsmCR0EAuw0NusvXDTXj?=
 =?us-ascii?Q?c2XcMV0AZeMm3DvZ6VPvZB3AbNn92zBelmAg2q/PHh3PJhdVqkE7uLFbwScx?=
 =?us-ascii?Q?lYTdts40CXfgKU8B1nYR7LSZNYkuCB4kZtZqsbhD/UUNRWe+a16zToyN+hc2?=
 =?us-ascii?Q?FqaEstShXtSHwn4O2Px+QkHXlshhzaRicUfzRqr06xXLf2uTO1IysiOjwr5N?=
 =?us-ascii?Q?OWhGD/SgM66X8PeILs/h9ufzVnowuTKuJ04gY+reJ1YD/J9Y6f/1VK3FzsNb?=
 =?us-ascii?Q?69bvywE4eU16j2BZ1cey2LHZmzniNPt4/HBh2T1wCMeJzC9zE1Q0WXe35zBE?=
 =?us-ascii?Q?nzjToEvkZrdUyfHFmwAvf3HfyEcn8DWUVLnzzntWkrpfvZO8KkHugWAZLuxH?=
 =?us-ascii?Q?BTDg6EFNez9f7lCAWY31gJ7l/CfDC/3oQderKnZjD/GidQD8qDzzSkOCSwzR?=
 =?us-ascii?Q?YTJ38LsNDYY1SRAx5c2kJSnOMLtCJVjHcjd1wWqB8gBHnsxInxMLcfeAuZCk?=
 =?us-ascii?Q?FVeAi88V96NHKm/kikrQXEOk4x9+jwwklUHG+GJ2pxL2vvDcdbcASiaQ+gAr?=
 =?us-ascii?Q?Mbangh0JzaRnqBc/fZZWjpDLUUn/iYe0PY9l5I+7hR9GUvamhI1qIyc/HHyU?=
 =?us-ascii?Q?H1ZS/fdW78DqgJke55cSej4LCDkXIp3hQRpgnoO0w6OXZ7H/V+/6ZZ5+HQXU?=
 =?us-ascii?Q?j2zsrcFPvSFKxTUAQ3GTXrWBcUkAQZvbhpYbT1MGBe7wH5DU9pT2NmvfLRAY?=
 =?us-ascii?Q?wApefMBAmlcY0YO2RRxJOOQkxmRv26lN9j2fImQbuEUdCREW0nzYMeve+5Az?=
 =?us-ascii?Q?PmODcPmYlDA7x0WC/VTixXL1e1Gy026PTBGg7Awx9KFJEFZFzFN5UYWeJ2Mo?=
 =?us-ascii?Q?kNCeEDGw5NwzCxkAt0+EWzaITmCaDxGitLzogyAcVOCHoNu01OwtBdi6h8t1?=
 =?us-ascii?Q?MelBN68BiaQF3OuaGkvl/a6AlDbLfAEgGFQepuOOFmvkY9XWQK7tMSnYRis+?=
 =?us-ascii?Q?TQhKKfWf9tV6wfN/zxo3hmvb7WXzszsKzM8JK6TFSh0b3HSltcWC0KOaYqMI?=
 =?us-ascii?Q?oabSarLr1yqmFmz04lQlPax8IkmDpJDgPFVCLA41lNBEZcOlinAHzUE38a8q?=
 =?us-ascii?Q?ymO/tKHW/WOyh+IotqGRID77nKMNqNo8z8GPUoUPjkJapaTwTnaxHuon0vkw?=
 =?us-ascii?Q?2lG6C2QycztsePSo1ttJq9Yv+cKmT8hXQE1kXB+h3sTeYqx4WcZlcQz5cbrE?=
 =?us-ascii?Q?dfsXJUlYFIQgumJR1upGz5gRhX/vS7kYc4ku+Qlpeq63kPMQ3KOft8BU7GvQ?=
 =?us-ascii?Q?RgX9L5quY23HqP0ey6zRKmYDMWQh2iaa5raKrHR4iSFMt1vYRgruoua4YEPr?=
 =?us-ascii?Q?5OBpfMYY0W7g+ZrMLxawU2ol9F5y4hU7wP6LIdDxVO8LXnjaptepEz5ALYv+?=
 =?us-ascii?Q?LaZSOhtq66mtx+OALfYF1nG2Q36a68p6KY7/Yhcowj7kiGLz5AMgXYJ6wgUN?=
 =?us-ascii?Q?FP/jYyyEngweiatJZLHEN9AlVRxdi075rGw8pSuCc9FCy2KRdFmJ9zMKzCUF?=
 =?us-ascii?Q?BRBHYxa3TdvpmOeQVSwz+FaETT7VAEf5A9JRco69eZt3U2r4ox68Kgpak0ap?=
 =?us-ascii?Q?GtKAfQC1frxn+fyatk7E0385ftT+LAt94eE8nH3qNrUNC5emCm6aKsO0jF1L?=
 =?us-ascii?Q?1Kt9jQ6dVsKMPOhNX5/KsbOV+zMPDCIEkbKJNuyYlv+rbr73XJ3QeJyzUmzJ?=
 =?us-ascii?Q?yWHcKEgpfh7Mae93p259I5GMXei/FFI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: c4txrZJEwtbjRq4hS2nkNc/172NsrB9dB5Ngc8ZVUtpp7CS5H9cBqwCzz0mf5ZN+oZQf+bR+oyPhF3cXvoyj2U4OcGETRDBHnTdaNbwafER4VRxbCNQKMAhOcYRoKf7U7Y1Egqj9V1aaGBR6hZb+sGMXZKsizdJF0n845rrGqxRTDDSLVOjD+e+/WEbeMpr1k31Z9sWXYO4NRu+7vq7xolsNshS2Jgda0+OfQ+Qcid2FfvUNRU74qHgSkUixX0Y+fs6qDnm3JzMOK5rVODsVjLrKML/ogBrSW1vWulCxkOIhCijzvbfz+70izys5c3bTQiISYSl9pK3iFPI63IsjzQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37d3ab6-d560-4c30-13d2-08de9b973cfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 09:04:59.8297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LezLDwGmiMZafJW5p0mJQKUfggXBPdIHE5lPFCGm4Y8mCdEPgjLqHZk8vXlowhR7MEtE5ta6q5XCeDhT1Sa9uASXO+BwzhGoMV9qq+L+9h0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4998
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278980-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,osuosl.org:email,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 5596540C00A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of KhaiWenTan
> Sent: Thursday, April 16, 2026 3:55 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Abdul Rahim, Faizal
> <faizal.abdul.rahim@intel.com>; Looi, Hong Aun
> <hong.aun.looi@intel.com>; Tan, Khai Wen <khai.wen.tan@intel.com>;
> Faizal Rahim <faizal.abdul.rahim@linux.intel.com>; Looi; KhaiWenTan
> <khai.wen.tan@linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 1/3] igc: remove unused
> autoneg_failed field
>=20
> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>=20
> autoneg_failed in struct igc_mac_info is never set in the igc driver.
> Remove the field and the dead code checking it in
> igc_config_fc_after_link_up().
>=20
> Reviewed-by: Looi, Hong Aun <hong.aun.looi@intel.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_hw.h  |  1 -
> drivers/net/ethernet/intel/igc/igc_mac.c | 16 +---------------
>  2 files changed, 1 insertion(+), 16 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h
> b/drivers/net/ethernet/intel/igc/igc_hw.h
> index be8a49a86d09..86ab8f566f44 100644
> --- a/drivers/net/ethernet/intel/igc/igc_hw.h
> +++ b/drivers/net/ethernet/intel/igc/igc_hw.h
> @@ -92,7 +92,6 @@ struct igc_mac_info {
>  	bool asf_firmware_present;
>  	bool arc_subsystem_valid;
>=20
> -	bool autoneg_failed;
>  	bool get_link_status;
>  };
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c
> b/drivers/net/ethernet/intel/igc/igc_mac.c
> index 7ac6637f8db7..142beb9ae557 100644
> --- a/drivers/net/ethernet/intel/igc/igc_mac.c
> +++ b/drivers/net/ethernet/intel/igc/igc_mac.c
> @@ -438,28 +438,14 @@ void igc_config_collision_dist(struct igc_hw
> *hw)
>   * Checks the status of auto-negotiation after link up to ensure that
> the
>   * speed and duplex were not forced.  If the link needed to be
> forced, then
>   * flow control needs to be forced also.  If auto-negotiation is
> enabled
> - * and did not fail, then we configure flow control based on our link
> - * partner.
> + * then we configure flow control based on our link partner.
>   */
>  s32 igc_config_fc_after_link_up(struct igc_hw *hw)  {
>  	u16 mii_status_reg, mii_nway_adv_reg, mii_nway_lp_ability_reg;
> -	struct igc_mac_info *mac =3D &hw->mac;
>  	u16 speed, duplex;
>  	s32 ret_val =3D 0;
>=20
> -	/* Check for the case where we have fiber media and auto-neg
> failed
> -	 * so we had to force link.  In this case, we need to force the
> -	 * configuration of the MAC to match the "fc" parameter.
> -	 */
> -	if (mac->autoneg_failed)
> -		ret_val =3D igc_force_mac_fc(hw);
> -
> -	if (ret_val) {
> -		hw_dbg("Error forcing flow control settings\n");
> -		goto out;
> -	}
> -
>  	/* In auto-neg, we need to check and see if Auto-Neg has
> completed,
>  	 * and if so, how the PHY and link partner has flow control
>  	 * configured.
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

