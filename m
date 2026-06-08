Return-Path: <netdev+bounces-296397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4u25KAtyJmp/WgIAu9opvQ
	(envelope-from <netdev+bounces-296397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:40:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC1D653A1E
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:40:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=djT1YZVe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296397-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296397-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A811C3002325
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 07:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E12838F945;
	Mon,  8 Jun 2026 07:40:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D2C36DA18;
	Mon,  8 Jun 2026 07:40:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904457; cv=fail; b=PpxrNJt/7QmVzlk0Xk0/T8Rc7nYOQlb6PHxE2r7Fji8x9BqsbESC4tIC95oDvC5dxE4hCv66vnB5i/YElXeBMPWmNzTTEbfdfWwKgIzAkmJu42mImYedzPO51WPWgwxKHOl+fHozGLsp8EKQsOUOAYpwY4WmkCLwoolCNhk4Yek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904457; c=relaxed/simple;
	bh=x4lg3Y2+drsf2E3307P/64q6xqYBm38nPLaZj9U7DOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NQG1j8aQMPT3JSeEwckvj+M/YHOe+8Ih1zl3WJVpUC3YyXyrhLZA5jyf2hhVOq17qx184Ch83R8Kv+OCkNVShgywVRly7I+IGJhkQpht9j53CDWEkTZtpGtkP7UBdB9WfLpYPXUDthRTV1eabcW5bvO+A78n+YNrGVVlJOa1ULg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djT1YZVe; arc=fail smtp.client-ip=192.198.163.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780904455; x=1812440455;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x4lg3Y2+drsf2E3307P/64q6xqYBm38nPLaZj9U7DOc=;
  b=djT1YZVekEgMXUJl0btwcPu5tO9FbtkDLXWb2xh3jIoof4a6FlnuarrI
   lstJ6y0jn1GIEYcxcrn2VMIhP//ApN/mImkO1Wm3mrSM+ocayuSQtdqID
   0g+y+PmFsCKLm0mXXffcAt58xkoapjpxYhaeiNHYmeWQdEOU18SC7TDjQ
   k5j0fjv7I3XuzMU+mJ1RT+iTlJ3zwNscoFA6ffRC1nblKjxSluZIK9/+z
   Cg0MBf+x98Cro43gTHOjKqYtzuzrHZ9Mxz6KRidHN4wF4oCBADrtbdzwR
   H/j7WmcwZJWu7hJzjQUXWYY8xruGmsdcLwYicOvKexl8cUIZ+L1y+JF0d
   w==;
X-CSE-ConnectionGUID: C0Ab2O5KQweplmn8T1vRvQ==
X-CSE-MsgGUID: VGcDTQXMTaSs9Xe4LBtQ9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="80662152"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="80662152"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 00:40:54 -0700
X-CSE-ConnectionGUID: /Shw36ljT9SrWC8yZPplBQ==
X-CSE-MsgGUID: 8sTCRFM/TmCsGG3svFu6Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="250575720"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 00:40:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 00:40:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 00:40:53 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 00:40:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ym6twSZZWJtUQAtvI6tWtKxe7fs2LYo6vxVJ+tLlvocFIFj+G39y/lslXYE/8VYM8jTw/bM+NB8k1o/Ks9K9sQucx9Mw8fArqYl96WeoC8D6VM01+G4FqQwI/22Y+DeKv0Wt+Xqwhyp7dqGYEMjYxO8HUFFqGdEZtZQefrQjWEIB2CJYmltUTdLaqra1QZtU0hLr1NiTOT8e8y2Q+w3FroElobuwgx7RQpaYMT6GWPBgbn1YZg9z2YNYUga3VPQmf6c4UtIj9S/bj6rJNTSoT/XO91tEoYb3iW59ohwJx1GDew+xDP1qC5BhtMfhzwxCgO5AxCA9NEyp4z7zqVKEsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lYMRunnbpNj9fEgtJbcb1CF/RtGCyl44Ec4Jk3FKns=;
 b=GyMsKl5kaLIb3ThH+e3TgoxZAsMI4bmSPas0VMtNP0FMReMQFj7o79Ix1VajjP1Byt3qzs87OA76IRWwEaYOntw9c4MKp2MPyhNiP2itKChsWMUFPDyNqCYf3BxeMgK15wQpgJzgaXpQRIm78ux45NFcAO0IjKXfX6UcCUE4039aIoRt46zR2/kwelFZlHSRuI3Du86Sx/nSEeVY6wAV11VpY09AA5gGwh1yw1eFfZaETfnCw0qZ7idy/33cPBqC5+5wJAstlBaKVilMvlszCJEX9USG+81SK+8EQz7sq8AhTy0xV98AGHWCz6sja95XVquBRn4anzGi73DaW+xNag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by SA1PR11MB8476.namprd11.prod.outlook.com (2603:10b6:806:3af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 07:40:51 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 07:40:51 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: "Wu. JackBB (GSM)" <JackBB_Wu@compal.com>, Loic Poulain
	<loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>, Shi-Wei Yeh
	<shi-wei.yeh@mediatek.com>, Minano Tseng <Minano.tseng@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [PATCH 01/11] net: wwan: t9xx: Add PCIe core
Thread-Topic: [PATCH 01/11] net: wwan: t9xx: Add PCIe core
Thread-Index: AQHc71hIxbHjRBN+Dkur3cByhE7587YpkTuwgARquYCABlkS4A==
Date: Mon, 8 Jun 2026 07:40:51 +0000
Message-ID: <PH0PR11MB5902CCC89F0B7C8EB3DE84E4F01C2@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>
 <20260529-t9xx_driver_v1-v1-1-bdbfe2c01e57@compal.com>,<PH0PR11MB5902127C590230B9FE50F78AF0152@PH0PR11MB5902.namprd11.prod.outlook.com>
 <c9e80369a7ec449a814cd85269f1135e@compal.com>
In-Reply-To: <c9e80369a7ec449a814cd85269f1135e@compal.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|SA1PR11MB8476:EE_
x-ms-office365-filtering-correlation-id: 06a86bb1-fd99-455d-b945-08dec531439e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: jO+YFxECg/ueQyp4sEHQi/a01cf4TfdLvHQVrWtlukqC2opw+S0Te0WetPR7yQuKps+e0BIQcGK5yn4gyQoYlX0AmvjWuBlU/qF2w6DcmULPu5CV4d8hfVgdZNk7hXK9H+H2IAWvf3uq8ZGecnd4WXDBusUz5n93ZSNLOtx743o1tV+5AxuAUwgRsSXyyQThnvuCRKmMt1CFKsftUAiePMEbUqds84MQrEEV+Z4zCONL/AwVmKFkcISzn/PZMk+ojRjX4+Eyzkh2ZBxTc6yRryxLx/BTbtFDK1EjVHQG1SSqqvZ1P+IR9p9zD00+6xgREiseIbWa5g3mprKcXL+bDKYiAKi9bk3+fpHSJnKiz0LdXnDwEKaOmf7OIVDC6flz3teOOuvm7szj/klGSlnEIkkkXEe2ik0+hI3ceKxztRA0gX2Pa1sRGWxlkVbNnbTNi4It+d/b9xdGe8QJ1YFUrJBQOZI9HiWbJegQuMxpQnuSFu5eNcvCW+T0LlsmBIolFbqI1qRJeta3p1WwI5jtK4PirQhX4Cs22oF+OwbyBnM6exehLnexp6ylcAjlugg0AhyIXSGQEZhVIL9Hji8kgKADgHAyd64KtVQnlYB3tNUtq7pVvtSLBzqoULJZE4bZu+43VyPP9ipxjlEGrtbzvsHyJRcp/PGztNaV0WVBNJYpe8CEA9kg7Wc8oowvp7t5+yKTN4ZI01hsyEImTYOh8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b4qCdam7NrxxoElGg1cYdLcOL4yjePunzt7RmuwLxy7oukZBwg85Bfmu8Pil?=
 =?us-ascii?Q?2FjMBpTaX7usuQL0I3kZ1PjL4OgnGm8Ecgsm/BL9fuz1fXTR58l59JFObnSW?=
 =?us-ascii?Q?B9iV/ulPSG89hMnEleYk9gDWhpnJKi3Vmvmpa9Xpqf12nUTLxts8DlsZtYc4?=
 =?us-ascii?Q?0FVfmdw/HEatDXJI2xUTxmDf2tMZ7Nq0PssFP4xLeK7xfdMjdOAUmTOCYflM?=
 =?us-ascii?Q?BrmXN80oUUHQvJrejl+yxdm6XjZn0yiVAsYKbfq4TWSdgJ3VpnfIviUajWye?=
 =?us-ascii?Q?lCvhdBumL1QJ6OxOZMX0+UfeJKMT7N4h0xesieJ1RrOrr5Ot30hHJu5Hm07j?=
 =?us-ascii?Q?kDFqWDFIQB3NH5pdNNfxEKmKz3FuAnSiz+IbACX6kXshJJ0E1bDEUi7g3J4F?=
 =?us-ascii?Q?7kB5erJgY/x+LiF+5JiMUjXz8rlx4luE/UmOil+zaBbvunVdpyOs2Cb/3R/j?=
 =?us-ascii?Q?K6tJv4+Mk4Z9P/4ahUWE8jdPMjs15ul0lY1XMLVNnOYIHwSn3gGP2L9bbFzS?=
 =?us-ascii?Q?EueYerdkeboZN1S4sjrTKo33DApKTPBAP0k6rxfpp5DBMneM4KV7FBq+v4n8?=
 =?us-ascii?Q?WP3W5S41q5xMTIhf942rsC4BQuaA1nfL2zngYe2Fpz+qeqvfv6L1Dbg/2nvS?=
 =?us-ascii?Q?ZMOgIPxqvf6jlpWSxtzhQWNlBjS/mKlgl1XpVjqmW+xSFUUir8luJahS0/ms?=
 =?us-ascii?Q?9B152dxaZ0kmCe1SC1Ow1u1OOSfjVyShJTJyVl28Tpw+uH+j5mQgsiu1lQRQ?=
 =?us-ascii?Q?Q8j8FHrfNhoR35PqEmMaFULqSQZEYfgI38jIoHt2PRF+3XcoGVAh1gD/GApc?=
 =?us-ascii?Q?wfnepZWGqD4ttFbgsWgzOq/dtiom6uY6vm6glF5M50Zhp5WR76a/eNoop9aX?=
 =?us-ascii?Q?xHVe0BMUccR0sK3xKiY/bCjR3nFjidYfRyraxw4nwdsb4mBjiYWI3RwKYZKP?=
 =?us-ascii?Q?IvnaBXZz3d4sGQk/jrfAzx0lZipMZyMRADI65b86KbwDhBY1FvaDoqMpsAZI?=
 =?us-ascii?Q?jVPFxzatomGxVK5WAmCB29odiO7B/UJSb9wooCN8Ml5tcYDE426Zw5k2aM/E?=
 =?us-ascii?Q?3wTIVPH7OsVsaAfb+RWbqIF3qrY3vhdZqjIg/PP1gMmbecj7YTWi+2ikAc8S?=
 =?us-ascii?Q?mCYKm20nY7h2IIijubUQJKaRMHnfVooAT8COmgMuKbk+Bmo3jFQNFKYvywCf?=
 =?us-ascii?Q?lGC72YpuSxBLpxWnXblXVZtgqMFFkbNYIDyqBPTCcN/7UKAG0nYWsd6BLk8n?=
 =?us-ascii?Q?oYOJjQbIMtHc6VLJWEyJMvunNh4Cr3hWw8PbaRLvzsALkBx97XJkuxtCpqFA?=
 =?us-ascii?Q?KcnxNe9zMvXoDlXAU5rttBKzE9KvTtdUvU0DZ/Mrb1DFe7FX4H+lpfvnInQO?=
 =?us-ascii?Q?ngodF37LBY0KXQ9inkRwDEQAMuoeq0ahXB2ewHy7mtC7aX0AJz9dV+O9uDMb?=
 =?us-ascii?Q?QBifnlRqYt+Am9LPVUs0+Q9RCoQkckJQW8SPSdVmdElbRqyf43Ro6ELLFXkB?=
 =?us-ascii?Q?NqJwb/WCCIyLFb0+NFmgNSsRyLEGpsAShu5uMcPDeKjl+tEtRIMrOukGDdeS?=
 =?us-ascii?Q?DtH1IBhWN1zyjzegAB7W8YYOIF1eIizHBhGJ6X/whCWOALNj6aJ7LxoaZBVj?=
 =?us-ascii?Q?78wfKt9/fkjCbR+1Ly1vr4l2g/VZAoGL61L3SNUOrj6HPHUK9ZeXIE2TYIM/?=
 =?us-ascii?Q?++dMn53DOsa605lcVLmEBAjP/PBy7RyHwFrfrL2ijZcXx1yp+FdMLMF8j4Oz?=
 =?us-ascii?Q?PfwUVkfA3w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Y+TXNv45ZyLFvq443+p7ti3xD2c27mbEZpFjCKAkgGyr/m/ONvhLc/Vzd76G0GqJJVpH7dGcckUd8zJX2800bmFOHFhIyeTpn4/iUM48GhRCxmK3y4BEUzsjk9UqRttixU8mxhuAbjn+uQ0a6is25EnQL/Dd3sMMxTyHUBNOfOC1C8sjQdGfwtmv/H5cXLpmzDwF10nWLu3qoH/QPfvr6F90SE2Wa/Jw+zdKluqYtgDlLAxr8h3R2ZrNznQJO+eGzIQyN+Lhfo0/l1SPvNxoE4J34ig9PmdyEiSuuBN5iDfda4yM/ScdKeLudY3/XBIEVfI3YnGVEd6dFGyWfFl8Hg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a86bb1-fd99-455d-b945-08dec531439e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 07:40:51.1650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lgAUnuswaDMhEPWFAnxfyTlFEoyT7yfLuIPq8MkBgYaz1A2Qrn6eMh/G8SyHO0ScYqrjYz5KZKk7oo1ZqV5zMs7197g8JJs6mcX6CP5lM20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8476
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296397-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[compal.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org];
	FORGED_RECIPIENTS(0.00)[m:JackBB_Wu@compal.com,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FC1D653A1E

From: Wu. JackBB (GSM) <JackBB_Wu@compal.com>=20
Sent: Thursday, June 4, 2026 8:43 AM

>> Sent: Friday, May 29, 2026 12:32 PM
>>
>> > +
>>
>> please also take a look on sashiko notes, there is some number of them
>
>Hi Jagielski,
>
>  Thank you for your review. We have fixed some issues and are still discu=
ssing others with MediaTek. All of them will be addressed in V2.
>
>  Regarding sashiko notes, how should I handle them if discussion is neede=
d? I cannot find sashiko's email address, and its website does not have a r=
eply option.
>

I guess discussion is needed when any of the reviewers directly refers
to any of the notes posted by sashiko.

If any of the notes was not directly pointed out by anybody please just
check which of sashiko notes are valid and fix them respectively
if needed.


>For example:
>  https://sashiko.dev/#/patchset/20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57=
%40compal.com?part=3D2
>
>  Q1:
>  The commit message mentions implementing TX and RX services, but the pat=
ch primarily adds empty structures and boilerplate code. Is the patch missi=
ng the actual TX/RX implementation described here?
>
>  Reply:
>  We plan to update the commit message. Would the following be acceptable?

I believe if you want to check if sashiko has no any longer problems with i=
t you
need to send v2 and check that way, unless im not aware of something

>
>    Add the control plane transaction layer framework for the t9xx
>    WWAN driver, including configuration options, device structure
>    definitions, and initialization/cleanup functions.
>
>    The actual TX/RX service implementations that use this framework
>    are introduced in subsequent patches.
>
>
>Thanks.

