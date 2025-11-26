Return-Path: <netdev+bounces-241810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9113CC888CB
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA0F9355CCB
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 08:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1617E2E7198;
	Wed, 26 Nov 2025 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQ5sQVd+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F9E30BB81;
	Wed, 26 Nov 2025 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764144396; cv=fail; b=X5zULMFtwAIIAf8mMLFSyfNuhZGNbcV8tQlD6sYpyLMnSiFwAIOL0Yc0qzzWEnUQVRExytqmbsIrnNOei+PmkKNu6ODaMOtfZFlp7/V1ubasBjxY5qoZtW38orJISHfE8bfgHJwUxVgItEuitO6DOI2ITPv0KIQkNnHEhFOKHMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764144396; c=relaxed/simple;
	bh=mJgGnYs+FPvZAeB/vX0hBViJ0AaCX7YOiG7KULX1ZeY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bVwoN02Rgl+Cg3s/Ew0YrMY4bS/aOAKIakqC5/P8GdkEN3TNgzqRSTQ8Qb25P989nMispaCWPjtIxD+PBfqQ4XtRmWe4gqsZAl1a93n3v8LeFxdfwTAfmYgYv8n43UBRckzJOW2VBq/J42gQFFYhbFekJ48ScFtHjFlMOlZgl/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQ5sQVd+; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764144395; x=1795680395;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mJgGnYs+FPvZAeB/vX0hBViJ0AaCX7YOiG7KULX1ZeY=;
  b=eQ5sQVd+ypf4f235tVLidVKVHKLm21lm7ZFs6yBuDYTdS6wmDx+oPQWp
   XDnLWTJ5vh7y8eaBDJbkjny8+TbCRuT/n+i725MxmMuuNsv3h4nmzXQsP
   ucImJSItwro3PmbQGcx5PNs0YphMqCETaDV2lR5PVHQoFbrfFi0G5JAx8
   WMpGPXN4UdIJ6aJEQWUvvNYlsYX2S/juJzoAa/jiGQ6L/aEE03IdjHUnK
   R24+te3/7xWGd1hSnkZSHwUCzoSOwedQprQKvioGWbTP5h+GifQjdxTmZ
   1cGIjOrGmsJ1HIeQuslA+pwpbzEH3iRk482sEVdkf70nSHsaVX+exnWn+
   g==;
X-CSE-ConnectionGUID: dnyBwATJT6a5RgfQAbYdQQ==
X-CSE-MsgGUID: /Z8LF4BWS8GpCTFne84NAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="83566102"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="83566102"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 00:06:35 -0800
X-CSE-ConnectionGUID: yFAVuO++T4i+qXJjdeRArA==
X-CSE-MsgGUID: PJu6xl3uTWylLPMoIKH4YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="192127548"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 00:06:32 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 00:06:32 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 26 Nov 2025 00:06:32 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.30) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 00:06:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFz4EPIoBtHxosFy1IDbNWWUXJP6SiMrmrckUR9obMqOtbsRxjppx5lCyoKnssS/l/uaztqtxl4ms9EwJj+5o2YynOaMTnorPGb1V1F6SEGEwsAR7O9b2+BxHc1ct2s5qGgmbV2vdxNMKImXvWUpM0KJ8eC1Xkx5L+hCUBHX8y32V8Ej5NKekMW5YoNCzTaEnyoIWut0KqFfHktiv71eaMnSjvfaxT4y4vyCHFwal5n5qsgwRx6P8qBihiLTcXEI5n64PtwQtjCTgOqqo874x3X8WsO4YBriFHzu455drUvsMjS5O8CfK8Zcarf6Hif8rmSPU+jU2i82bGr+asd7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFZs8zjxvCE3s64SFpJWQmJ3FRMAWCDXcXUaBfMXA+E=;
 b=Zjptr/V6QfQtHgGz68NOFOn8snFv6UU8u0aAahUMdJPPpI4ayjEp1qhJD1wYYcHGIDnovictIMEtIMpIsqQ8CvptFsEU1onNmCnXF6Kewfb28nRBPbb5HETcn7KLnSsyKidWJ6O0JpDqFs4EIip6x/uismxoWzs2KfoEBPPjSANQjHdF5HhuJVfw2GWEj+6VtK1hf1nr0Joixt10uPlWFLncdb6Ym0LoaAFT+nLk3lDc+cWT8eVFGa7UKsDEKejqmrf039Drtg8OGXh4ZtR0HOPEuYbhNKYyMXZItmLsE6LhlwtMdpk2xoxhBuJXWsi//Iw7XFrQKFwwLjbmpncd1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CH2PR11MB8780.namprd11.prod.outlook.com (2603:10b6:610:284::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 08:06:30 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 08:06:30 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH net v1 1/1] idpf: Fix kernel-doc descriptions to avoid
 warnings
Thread-Topic: [PATCH net v1 1/1] idpf: Fix kernel-doc descriptions to avoid
 warnings
Thread-Index: AQHcXp4lCuKnKhB+dUKOi/arzrfXIrUEi8pwgAAKlACAAAINMA==
Date: Wed, 26 Nov 2025 08:06:30 +0000
Message-ID: <IA3PR11MB8986CF43DFB0EFBFDABA34EFE5DEA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251124174239.941037-1-andriy.shevchenko@linux.intel.com>
 <abf25d3d-30af-479f-9342-9955ec23d92f@intel.com>
 <IA3PR11MB8986A3FDF77D49598C5F4C89E5DEA@IA3PR11MB8986.namprd11.prod.outlook.com>
 <aSayDu8yVe7prrsx@smile.fi.intel.com>
In-Reply-To: <aSayDu8yVe7prrsx@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CH2PR11MB8780:EE_
x-ms-office365-filtering-correlation-id: 8f187af6-700f-40c2-4fcb-08de2cc2b4bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Achar5uGcbgr1YGKxaT+e7DjTA+x/TAsmdvxyAwxQQn614xTXwpIHTsakZqU?=
 =?us-ascii?Q?zl2q9r5GietL2rOCF3L4j0VmJuzofizB9IIn+8c6TXhzdp/mg7qs6xyToM7P?=
 =?us-ascii?Q?U3jsFPujMRdavLhY6CSCrvn8yxKPJB4BikcNT8dD7qpGrC40caHOk986yr20?=
 =?us-ascii?Q?xPRmkQWA9lstxo+Qkf7U9WA6rVuLrou/qc/EeBbILPrmgDGAPkC02dfB1uNI?=
 =?us-ascii?Q?Kc+g6ljvY/tOV+oRuPNNK4zyZpRO/3BvjX5U94MFnYPB8hKRkw4fAID2SSRC?=
 =?us-ascii?Q?4wuPOrF/CuPk0QaopaLfrN7aqZPdKXu2JMeWnFiOFfIgSEN1Zo+ucNypRYM4?=
 =?us-ascii?Q?Ueq1gXFcH53yRvoE2iN04n+zN5uq5PO1IeujoRt4YXkzLQAAJteRTRfDOybP?=
 =?us-ascii?Q?eQQD8hjdHJ6wjUPHL1bnSqCukjeXduwbISgPgYW41C/Vf29SsDTcKwgMkIuy?=
 =?us-ascii?Q?Zso69WTq0Dh6SifXnxvy0WN5WOj01zHjDL+lIIFhIJ4BcIbwXENkSUjyVYam?=
 =?us-ascii?Q?T5Qj4eITYeS6oGTrvZFld1qJAs3GcZsLLrWuyJQ9jYx/XpDYTVkKUF5ODN61?=
 =?us-ascii?Q?GRgU3bXre5gynO6JuuHbhdBK9YBe03uwz7egpgcVnPBsHgbTOnt7QclCnnxr?=
 =?us-ascii?Q?eWIE310EtcguNMrDbTkl8sq7KMBZ0hfIAPhvrbtLE7ErK7G710ukcvNI8Qpa?=
 =?us-ascii?Q?Ie6TvYSJULouPOx8LMXHZ/sD/VQ7qAcyrCV929aZI31ruZ+RCUx860UlB0gR?=
 =?us-ascii?Q?CG7OrF+eA52l9LtrKkedMyYAPp9CJ7rZwHTdXC8B8jJRTTaCbgjIuRl2G2Nl?=
 =?us-ascii?Q?ANm1Gu615U0sKT7QUNHuYSJAdvg0MnB557e/AzQNV/8geZ0Bgtfy8CzXZ71m?=
 =?us-ascii?Q?Pgd67+yzq8nS68TAI4vflEVrN+3tofa6wRD/u9YugWfXyD8uU/CJfKaFrjD9?=
 =?us-ascii?Q?L7rqc4IcSbxyG9USi9FYeLmYfGlWx6eRnd2tSF2cMo8/wHKdrTj47RG/AWOY?=
 =?us-ascii?Q?M0IWRZ/xfiWeN+17kZkgTak/RY3TDyg2RiVHGkA72Xz3Jt2mBmwMtT7fmdqy?=
 =?us-ascii?Q?6NMFIVpjYGz19EJQ2B4mDeakH4iQG/dKy6FVCChEwaRo92rEApUkApDAfIxz?=
 =?us-ascii?Q?takNSI0ZDVdMNLmNg3mIswYk1Bebkaly7YXD+6go5IdeeJeRpqbHdVMHFMBk?=
 =?us-ascii?Q?6wNWGUtJ8lkBy9m7maGQHueAjYu+sLdFsjkE1PtN2t0nBArYi34NSAbrHuu+?=
 =?us-ascii?Q?zMrFM3ciPtyQ4JbpUjq56DVfqjBS8E16B8EmmXCGju4KHjTCj9rRmPVpoBR4?=
 =?us-ascii?Q?xImlLlCDuxvs8ZEQfbWSCbMLG7Y5vzy5d97tKbg+3blj+X2npXF4APANc5jr?=
 =?us-ascii?Q?N7Iqw5C7tx9oatjiRkbN6zfMkkCjiYWk3ZCPla9uPD1ESyBXHoZTvXn0nC3O?=
 =?us-ascii?Q?/3izWXyiLpshKfObQ3TvhcFxSx/wYWpUXOLxzOk50kzkNdp/rypgeBkIRsx/?=
 =?us-ascii?Q?jvFV2US3Z4EARPclv8AWPi8XevTxzBaQCYyO?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uLTd5D3TToQo0uTGkNOJ49bSpDZneD0TMDAIqExLC3uZ1/rnrTWk1DE2wCjw?=
 =?us-ascii?Q?QsIktkWMjQEulOeTt41teLNUeLPgvwBZ5JOvc0XFARlvd/jCs9jvwrpgA0jh?=
 =?us-ascii?Q?PGjdRW2aY0px2sgv4kZvsTfSERZgi51BT86IBSsz9NhIRPokpRFgRa4TmZ4Z?=
 =?us-ascii?Q?JIk1Cx/zEIIig6Qwd54K/V/QN/jqxv/dQwsLDLhbkxdqHlhIqWNmON26VTmY?=
 =?us-ascii?Q?WExHT0J/Hs9NNSjowcxhwmstM2LkXv71H15kXUBK5We5z9C3v46Xf52OqVIi?=
 =?us-ascii?Q?nmmVrSONvaaMlCB5pfO4uVHSEin9nH4N3btgmZPAvaaLgzdHvBBNBPtrRgRl?=
 =?us-ascii?Q?vYqHsUNZByRK+TdXrcJScLxedNIL+gTHs6bmjPyFXCvWYyYEUb3VcoRBGOyI?=
 =?us-ascii?Q?WqrYJtd80/ff88WtURvf7PsZ/v4JMHYRFxkI/Y0XZ7jzFnBQbd5rgZ0M+DOq?=
 =?us-ascii?Q?2/nsgRjUuPFUHD3GLUq9Dj38kkdtevfqIjML+VOtCDwnHirXLeWSCYU9DOz2?=
 =?us-ascii?Q?vcFcCXhmdvUTlIqbpn36EhBGhr1hBTlikCwDdf8WivEKCPRlyRubvpYg7h5l?=
 =?us-ascii?Q?LSdbw0k5cvSIL1W2JU7WROL8jTbFtq6r7PCk5ruiviKqSuv+SjQeUy5x1SX0?=
 =?us-ascii?Q?E9SZPaSOTbMQa3hfrzuinVWlVREaj2iZgRK86m1PwbKxHn984yS5FMPpYYK9?=
 =?us-ascii?Q?YxjniP3/W27rg5fnupVXALqSxPIFxqFYHkXO/5OcHrLu+ep6e+mGI6WWfFHh?=
 =?us-ascii?Q?d/53yfZm5bH+2XC20jCO5Wct9y14DlG+YGEXsuxyZqFtL2LVV+Gtb0l7DlWv?=
 =?us-ascii?Q?rXNuBeFPq0czzhzUdMbuNJXsNF+E49jfdpAgi6xTfXTk62QakVDZJfWFQJgW?=
 =?us-ascii?Q?IteqRnEb3twiA1zn9xiNRAJ/57X1j24jdaY3iwpMEKQHvnN6+cRad820BC6b?=
 =?us-ascii?Q?ldZrB8r7LSKcavh4NvfAai3utj+BT7lx4zeXK5Dkg8w5PtSVeJ+I0gcNVPAi?=
 =?us-ascii?Q?Fs1Svn4jwJALobLsgd8zhtkHkGL8Q/wmuMWdhNvDOjtRG0Ek9LuEad7R5KQW?=
 =?us-ascii?Q?zIrPOzwbqJyd5IyulLoSKlXvPwpc3IRa90Ue9n7VXBrIygrfmpQFP4mT+mwC?=
 =?us-ascii?Q?LyGcouBImDXlsyXuQsIVt+aO07KcbHNrGHLPXHr8+kDc9GrtILfhAIWlWiFM?=
 =?us-ascii?Q?ed2iNZ2qzNA5pgpXkVfABwEbjKk8DYoLF56NerChtNUtKXOJBdVuK87nm8PZ?=
 =?us-ascii?Q?uiRybad1X0EA1PQfhGaU0YkUj/l7OiQyU38R5Lfc+QaepLAqkstogdl6sjNh?=
 =?us-ascii?Q?8XN4G5CflwRBvM3xRKhIyOjet46JbLwf3C4liHTw9VXHltr4OOzHCW6yp7+9?=
 =?us-ascii?Q?bZUxaN1EwIravbVkuyTFqkaJ1iT12VeeM3ihKqdPH6Qnj2abw3y1HCdAptjq?=
 =?us-ascii?Q?eWcIIk2m/XUbpIeZ4P69QR39fPlxR0IZeCDjSDbm0kl59jSA1MazwWFz9M2H?=
 =?us-ascii?Q?7TGxdF/ZsLGUbdr6H+Lrfr4cjfuB7Jy/WyloNVjXwqT/uO84aZIToLGEymn5?=
 =?us-ascii?Q?C9GGVU6B0zWTnfDZE6fgUTuaXOvUBMerOo9M2gjU/Fko3aAHWUK3n04MZsA/?=
 =?us-ascii?Q?iQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f187af6-700f-40c2-4fcb-08de2cc2b4bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 08:06:30.0585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEAmGwg2tkdtAuPlfuPH/EO9sQWHi2Wev5EBseCBUloAXqaUnFiC2DJfT0070Yc63caWfacM818jiWQjGH/1cyv5X5lMGV4OcCkOmopPNGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8780
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Wednesday, November 26, 2025 8:54 AM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; Andrew Lunn <andrew+netdev@lunn.ch>; linux-
> kernel@vger.kernel.org; David S. Miller <davem@davemloft.net>; Eric Dumaz=
et
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>
> Subject: Re: [PATCH net v1 1/1] idpf: Fix kernel-doc descriptions to avoi=
d
> warnings
>=20
> On Wed, Nov 26, 2025 at 07:24:40AM +0000, Loktionov, Aleksandr wrote:
> > > -----Original Message-----
> > > From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> > > Sent: Wednesday, November 26, 2025 7:30 AM On 11/24/25 18:42, Andy
> > > Shevchenko wrote:
>=20
> ...
>=20
> > > >   /**
> > > > - * idpf_tx_splitq_has_room - check if enough Tx splitq resources
> > > > are available
> > > > + * idpf_txq_has_room - check if enough Tx splitq resources are
> > > > + available
> > > >    * @tx_q: the queue to be checked
> > > >    * @descs_needed: number of descriptors required for this packet
> > > >    * @bufs_needed: number of Tx buffers required for this packet
> > > > @@
>=20
> > > > unsigned int idpf_tx_res_count_required(struct idpf_tx_queue *txq,
>=20
> > > >    * idpf_tx_splitq_bump_ntu - adjust NTU and generation
> > > >    * @txq: the tx ring to wrap
> > > >    * @ntu: ring index to bump
> > > > + *
> > > > + * Return: the next ring index hopping to 0 when wraps around
> > > >    */
> > > >   static unsigned int idpf_tx_splitq_bump_ntu(struct idpf_tx_queue
> > > > *txq, u16 ntu)
> > Strange idpf_tx_splitq_bump_ntu() is not idpf_txq_has_room Can you
> > doublecheck?
>=20
> I didn't get. What do you mean? Please elaborate.
>=20

In the kdoc I see function was renamed: idpf_tx_splitq_has_room -> idpf_txq=
_has_room
But I don't see idpf_txq_has_room() function name in the patch.
Only idpf_tx_splitq_build_flow_desc() before and idpf_tx_res_count_required=
() after.
Could it be a mistake?

Everything else looks good for me.
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> > @@ -2396,7 +2399,7 @@ void idpf_tx_splitq_build_flow_desc(union
> idpf_tx_flex_desc *desc,
> >   }
> >
> >   /**
> > - * idpf_tx_splitq_has_room - check if enough Tx splitq resources are
> > available
> > + * idpf_txq_has_room - check if enough Tx splitq resources are
> > + available
> >    * @tx_q: the queue to be checked
> >    * @descs_needed: number of descriptors required for this packet
> >    * @bufs_needed: number of Tx buffers required for this packet @@
> > -2527,6 +2530,8 @@ unsigned int idpf_tx_res_count_required(struct
> idpf_tx_queue *txq,
> >    * idpf_tx_splitq_bump_ntu - adjust NTU and generation
> >    * @txq: the tx ring to wrap
> >    * @ntu: ring index to bump
> > + *
> > + * Return: the next ring index hopping to 0 when wraps around
> >    */
> >   static unsigned int idpf_tx_splitq_bump_ntu(struct idpf_tx_queue *txq=
,
> u16 ntu)
> >   {


> --
> With Best Regards,
> Andy Shevchenko
>=20


