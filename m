Return-Path: <netdev+bounces-292606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCrcHaEGGGqdZggAu9opvQ
	(envelope-from <netdev+bounces-292606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:10:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DFA5EF46C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D716D3147B5A
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D216B38C42D;
	Thu, 28 May 2026 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tzfyo12v"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91BD38BF9A;
	Thu, 28 May 2026 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958556; cv=fail; b=X8oBg5KX7KdMBuzDbq2Ucj6q1oZzQBC8po0i4Qyz6biq4QoSl9ZMciS/iH9bXYomuRypyJpYjNRf4QDAEYOplWKtsNoeNCWqOT2wMORMpiUk4+ElNZ12gAZ9V3nR6UR1SU3cm92mU2EXBASwskYc8vRgU86294pIAQrG9uRoauc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958556; c=relaxed/simple;
	bh=T/DY9LylGS7aBGbG1Kad6iE0O6rB6oQEr+j5GKsVcgM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Knc5Xi0W/skA0Il60TJcsE5YF3cTtVI2c8+ZlkExJfX1Y7e8lvDkta3TaJ0n3GkBdk/Zd+Ng1BfH+BR0V0BRzoljgFTovdW+xJlk67MIsLUP2PRVijv7QSON9lxD/Svm7522+N1kIiTn/2C+0HmRY/qbHdKjHg9w4TlL69g3pBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tzfyo12v; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958554; x=1811494554;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T/DY9LylGS7aBGbG1Kad6iE0O6rB6oQEr+j5GKsVcgM=;
  b=Tzfyo12v22tU9KBWkn8PIhKd6ywzx8XoxUdeeqvew+n00TpcnJG58KjC
   6xUWQTftDEcAGfRjXhAh1fBMZ2yfXdm6C47wf/ld3qrGpeCRHNIyO8/Bq
   d/Tl+JKnEK//AmSRA9P0uv9N3Dyg1+3/RmKzJRTjc4vf8t0eJYK4e0T/j
   uRfoDjGDkOAV4CyUyRTdlgb3a4VTLYY0bjwe37ta8D1B4E7QnrthvAHtd
   1FjHHcQJ441NjOgo7ZsoYQst1GfZlUTN3KwkCQTACTfhjahWhuMU6Gtyi
   KS3QZMX7stITniNwB/bTCT71p9Vnrni/f2D+4CY2+M0DyoyhxK/pcpyTN
   g==;
X-CSE-ConnectionGUID: HQUs0kRyRKu7YofsizdAkw==
X-CSE-MsgGUID: FOmnCAvMQ6SMOk6yVQ2gUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="79945942"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="79945942"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:55:53 -0700
X-CSE-ConnectionGUID: NLpMxnW8TzGifsDe2iT7VQ==
X-CSE-MsgGUID: +CQ2PdYOTo+FwwgamevU+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="272828455"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:55:53 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 01:55:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 01:55:52 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 01:55:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqrDV1kbyh+vE2gwg+eIR+RMuQF9hOSR59d54YqtG8vcdhrqsffcJ++fM5/EuKHVBIgy9CF0/imoBw6Kh/onMRhLh2kkJibRsX+X5MuH3fHZX5CYj+2iuvMXPa7+jH3k1MCVsV2cd9hCGonli0n6Rg+kYjGCGh8IJti7MaLsIj7ZRxFZ36r526DL/wVF+PjjMJ2vCF2w6mwM2uJjjqLw+eXABKH7iZrAhoaO4QNY1Lr0zr6S4AjTaUoJV5cfJ9O/9paMvC0SwyAXSyp1ErWWz6Nmp9/NXFX/ooIfwvTxdp3REMJH/Ms/x47Gb8rPLl1jII8DlfLHhgeu0CuhHiUxgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFMBREPP4eIs1sbuef4p1ivnsCU42McCtcdD9OtZobE=;
 b=rM4Lj0m9BtLIisieIAmsIuo0CFhKvvTUJQxKxMknyf69+ZfJhQFE5OWPhSnKUANpidUd4SxLtH7ZlKljSWBCq1FPGtxxWp8wv5w/S6eMFZ5ZV29xcIefBT133bvu2S1MlCmkp3Clyq4k5YCQGXipq8y+RdEW7+wt4e1KtPLanep0R25ATiV2tcgxePHbq1Kt1f8BlLcUzY1gltOZBoVKoS5hraE1B/4u6i7dgggvh4bXQzuwzznCiTR11tgHiWDY4nqNcIJV7kBaUN3vmew+07ivkHztoifaakgnZnTRDHyiDEp1hVk/U52pP1PEy4tqWxaa7tUHlXxLkLBMLErBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by BL3PR11MB6313.namprd11.prod.outlook.com (2603:10b6:208:3b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 08:55:45 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:55:45 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Vecera, Ivan" <ivecera@redhat.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "kuba@kernel.org" <kuba@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "edumazet@google.com"
	<edumazet@google.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "horms@kernel.org" <horms@kernel.org>,
	"Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH v11 net-next 6/8] ice: implement CPI
 support for E825C
Thread-Topic: [Intel-wired-lan] [PATCH v11 net-next 6/8] ice: implement CPI
 support for E825C
Thread-Index: AQHc7POk6TbJgGf/UEa9Z9x9qysYnrYjJYog
Date: Thu, 28 May 2026 08:55:44 +0000
Message-ID: <IA3PR11MB89866CFFDC062673B1517FCFE5092@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260526093419.639220-1-grzegorz.nitka@intel.com>
 <20260526093419.639220-7-grzegorz.nitka@intel.com>
In-Reply-To: <20260526093419.639220-7-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|BL3PR11MB6313:EE_
x-ms-office365-filtering-correlation-id: 7d18bd86-67f0-4ca6-73d0-08debc96e7a7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|4143699003|56012099006|11063799006|3023799007|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: CD99Gmz85V/nPjVIH8jiscP1xREfBLTIp9vioyqlg5haBcHdh/K052G4/JuLx/cF/GZB6ARtQUnsQsmhvD3ccjGxIkeXEERHN5dTPjxw1vb3ZyRM11owjqwHnCUt388ZPe8OnMx6D06OLa6nbvDZdwIMAJHK8omfmz4qYOaNs/kvRL2Zk/NPJRjEgyxOVdnZ5qnj1RbslhbnEYnL86xqyJaJPE1pS4YOsVwF93vSdMXPubMBvHR2kA/zh0YOA0s+q8rxM1j5PLkEVuPWWua796uIXiaxJ3pJ51jSnJxCvx70jTeBoJTR+FjdbX+tSTfhrIJSzzXjOPY686oND3tImBrfo3jLy9OfT6vHyF6Cgy2sS+Qw26zg1P4cWvycZC9wkuFR3mxLWjDYYT4wfMwhoiRaGiu8l5+Md7kpfSrSuv7un5x/92RUGx5UO2D8jjfU1uzS+RhqQIA/XJKyx4T9Bty5QFdZgEScck/r4y/9i57G8mZNXI9YEEComAvXHPgoxaBPXFCvIO1d1rAK0YtLrJCXrnJdCv2ffsDnpUp2MDQdAlrsOb4flYBoKcIKkte1L1Wee9/p/Lh9kcTPojsRyF2n5oble/Py/wyNKjCxTAoExkSa5w3Tw4wbKbjjhW8mDmcCsa0ipkidJFVbguc6UmLZ2n4oYV6Q/X2azJVEA1ySgtsu4ItXCV1chriV6z7+eOVjioPl5/ck/b0kOl3xLAjy1yKxqLVTqHqj7zpBMhN2mlg/uubaJ0QCD9EbDeBS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(4143699003)(56012099006)(11063799006)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0PvZCJLkCLKo6kUW6DVEq4XUIgbvzNg7BTyDR7hvGzTR2bhcKPt4DIu1c9Jf?=
 =?us-ascii?Q?BWa7hbjtEJMdvBUReTiLyxa2fe9/hFrVscaqZ6jvWT+HEYmgYY4AeHhJt9kT?=
 =?us-ascii?Q?mUNgy38Ggpe2GoAQ8ng7MLiAJwOgC4dLWOgIahvWlzbntdxnfm23GX7KtR2t?=
 =?us-ascii?Q?5t0DDtXxpRaH6f8JLIFgXGLzKjfMGjux5jhtQztlPx71W/8GVTV24dOOnBH/?=
 =?us-ascii?Q?f7UjAceV9NgZ7OLx2LjDcNKCh75m0GoLdEPx94VfqmxsyPwTMGQaB2Qz2IGh?=
 =?us-ascii?Q?kOLLZIp7PswdpPuTHI3HdA2GuUE7eF60y9a1dyi6xCKG/6ESZR9xj+WkGsmV?=
 =?us-ascii?Q?JaQW/hkEqmnV68xlMS/OANhVl0iqBC9jDlVt27bV2WOaK28+08H4yZUZYail?=
 =?us-ascii?Q?79/xh4RoQq8ckpYUdaemMHu9rM+LLAOjxifxrkj2T5vIZOi7YM1tE3qD0yag?=
 =?us-ascii?Q?ZwvRXwliv3NUw7JaO7bfgOjQJw0MD/w5Nujv3/LyznEklqdYGvBfVXlh9vSw?=
 =?us-ascii?Q?dpEzD6P6uSeW8I2z2/Imc/53v7ZCYyoR/JKZh/qHtKaf+DhBLa23cNPT/lB7?=
 =?us-ascii?Q?f0GF6z/0TCtV17g6sK9/fQim58hYiOxvKZ15/B6cGapDpvxOcwT0d7yBhUqM?=
 =?us-ascii?Q?LGgjpfEAS1lJaFP+EHZxmm53iPIXRIz7iXL5a4RJzzCgYsmMA3g2Yga2qteI?=
 =?us-ascii?Q?9N0ysQPWv+tjTC98tJGJTOH39Lo0VqjP/ZkPWnH3SrOIz8G4h6H3VtWePCbb?=
 =?us-ascii?Q?WM4XqVlc77PwP2cjrgx+epHJWWd2YPG3yaw/FRAg1NNgyRdRjjUUBW8OKqT4?=
 =?us-ascii?Q?6OXJ9EXmeA6X1Zi7WWr6NXZtrIUcVwe1NNOEJ0axa/Azbwg+LpOi4zHqRUMH?=
 =?us-ascii?Q?tUkyWyz6OALKlBMK9xxxfeXJ+mXFW6fYazKeJkLA1huEAhmkDAg/zPk1Zqyc?=
 =?us-ascii?Q?pPMz02p2pikw0WHuhByQMi5AFjI36t+GYQly+79OgTkSjWBzhLNDfuzfEJ81?=
 =?us-ascii?Q?7f5fLoYz3cI9THZ1HlNmNHwSOvK9Fd5Cr7Sr7n666hrmY7EU+CNbKuJyBvyj?=
 =?us-ascii?Q?ga/OBNvwtuRDiivhRX5eo7NIdKfuF+G2lKUZvlD+0LvbK0NUx+16aj4vSLTw?=
 =?us-ascii?Q?gG1pzRFVY0UKXfZobY4uTqCcdZnFRfTJZ4YR1TA84NzBQ5Q/XVM5mZAmbCst?=
 =?us-ascii?Q?BUlj5H5Wp+GnTI/ahRoAHDZO/LGvlU6Ny2nEPAO1HBadJ7ZauNnNBom8l9Kv?=
 =?us-ascii?Q?fTgFYJFXpQflXrDKq8/sT7imGH6dxOo4xO7S9Wk16AumYIRXGp/8V8J9upMy?=
 =?us-ascii?Q?BBX/joyEujNpYIcsxs3ksCi4TSfE4bMEOdZ8cbFLaJ06LntnNUKNYcGpKXZd?=
 =?us-ascii?Q?Wa6T7cZHsW4Fe4+vFTstZnAkV/op99YHjPMGAEQIqmKAoqpGTWTXAY8WF0bl?=
 =?us-ascii?Q?LhYJqi38KocCM3W73v/hXnqG/QlBI+vYAkcz6ouVgYtcthWUsRvX0q1AqUsh?=
 =?us-ascii?Q?taX95gfyEcCNnBdOVdOMYflTy4H2LXypwZM2t0dDZBjegz4m86JjZ0i+U0aS?=
 =?us-ascii?Q?OPIs8e33oVEuRUPnFK2tS73Dy75SUfP2vG/LEXrMRZLWfB8mnB0u9jTgXaxY?=
 =?us-ascii?Q?S1dk+KAiRq6cYQ2GrYEmOHdYhE8EcSWy4byOyKJ6y07LI2AzSs4zDyZANdnp?=
 =?us-ascii?Q?kip4Obj6o3S1SDX54Rd1PPhxZCJaF0czDDaL4YiJSHui7yCIhz13lp3j8n+h?=
 =?us-ascii?Q?1QOiBJlyuIdpy9JaScLupuk617vpVQw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ArgYphLy4jem2DMMEkfNRZrdJd9jCbTin9yMxFJTQlqW1beAoRjkbCR+fnOjknT2x7jNXL6bNvj6PB5Hf88N3nk6nArukd/qck737ArjqasgP8gCCKjvcQDnAETjcrPqTVIY84l0A/gI3YnkzZKYbkpjPsBZdf2vT+YCnphbnmY7Ieb9940+E4L+6BQhCudE9u8yDH11O9WSLXcEQf5WGREfzKaeLSxG8opgMIr+mfMz+Mkt8NKZ8s/aDBBU1uxjv0a0cWKDW3P6CFxPEcmGqRvu4Cj0JvEQ9sEr5tOy5xzTAOTL/EKln9U6G28YNgZuVN5AQtuwrOdGwiH3grXcuw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d18bd86-67f0-4ca6-73d0-08debc96e7a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 08:55:45.0219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vpdv8m+bsZfGleuMnQ3EV3A5uJ1Z9mW/enDcO8c7nRn28svF+h9MWBhqYYk1mkNGQoyBZet0RjfKBQUXNAlb7Kk1FpgfcWboPTvujVtAWSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6313
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292606-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.dev,kernel.org,resnulli.us,google.com,intel.com,gmail.com,vger.kernel.org,lunn.ch,lists.osuosl.org,microchip.com,davemloft.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D1DFA5EF46C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Grzegorz Nitka
> Sent: Tuesday, May 26, 2026 11:34 AM
> To: netdev@vger.kernel.org
> Cc: Vecera, Ivan <ivecera@redhat.com>; vadim.fedorenko@linux.dev;
> kuba@kernel.org; jiri@resnulli.us; edumazet@google.com; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; richardcochran@gmail.com;
> donald.hunter@gmail.com; linux-kernel@vger.kernel.org; Kubalewski,
> Arkadiusz <arkadiusz.kubalewski@intel.com>; andrew+netdev@lunn.ch;
> intel-wired-lan@lists.osuosl.org; horms@kernel.org;
> Prathosh.Satish@microchip.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; pabeni@redhat.com; davem@davemloft.net
> Subject: [Intel-wired-lan] [PATCH v11 net-next 6/8] ice: implement CPI
> support for E825C
>=20
> Add full CPI (Converged PHY Interface) command handling required for
> E825C devices. The CPI interface allows the driver to interact with
> PHY-side control logic through the LM/PHY command registers, including
> enabling/disabling/selection of PHY reference clock.
>=20
> This patch introduces:
>  - a new CPI subsystem (ice_cpi.c / ice_cpi.h) implementing the CPI
>    request/acknowledge state machine, including REQ/ACK protocol,
>    command execution, and response handling
>  - helper functions for reading/writing PHY registers over Sideband
>    Queue
>  - CPI command execution API (ice_cpi_exec) and a helper for enabling
> or
>    disabling Tx reference clocks (CPI 0xF1 opcode 'Config PHY
> clocking')
>  - assurance of CPI transaction serialization into the CPI core.
>    CPI REQ/ACK is a multi-step handshake    and must be executed
>    atomically per PHY. Centralize the lock in ice_cpi_exec() and
>    use adapter-scoped per-PHY mutexes, which match the hardware
> sharing
>    model across PFs.
>  - addition of the non-posted write opcode (wr_np) to SBQ
>  - Makefile integration to build CPI support together with the PTP
> stack
>=20
> This provides the infrastructure necessary to support PHY-side
> configuration flows on E825C and is required for advanced link control
> and Tx reference clock management.
>=20
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile      |   2 +-
>  drivers/net/ethernet/intel/ice/ice_adapter.c |   4 +
>  drivers/net/ethernet/intel/ice/ice_adapter.h |   7 +
>  drivers/net/ethernet/intel/ice/ice_cpi.c     | 362
> +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_cpi.h     |  58 +++
>  drivers/net/ethernet/intel/ice/ice_sbq_cmd.h |   5 +-
>  drivers/net/ethernet/intel/ice/ice_type.h    |   2 +
>  7 files changed, 437 insertions(+), 3 deletions(-)  create mode
> 100644 drivers/net/ethernet/intel/ice/ice_cpi.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.h
>=20
> diff --git a/drivers/net/ethernet/intel/ice/Makefile
> b/drivers/net/ethernet/intel/ice/Makefile
> index 5b2c666496e7..38db476ab2ec 100644
> --- a/drivers/net/ethernet/intel/ice/Makefile
> +++ b/drivers/net/ethernet/intel/ice/Makefile
> @@ -54,7 +54,7 @@ ice-$(CONFIG_PCI_IOV) +=3D	\
>  	ice_vf_mbx.o		\
>  	ice_vf_vsi_vlan_ops.o	\
>  	ice_vf_lib.o

...

>  /* Port hardware description */
>  struct ice_hw {
>  	u8 __iomem *hw_addr;
> --
> 2.39.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

