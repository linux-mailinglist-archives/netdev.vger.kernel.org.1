Return-Path: <netdev+bounces-192481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29684AC0060
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 01:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886F19E4C4F
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEC723AE87;
	Wed, 21 May 2025 23:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tsy8b/1t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D85C23A9AC
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747868852; cv=fail; b=JMkykYTL4awLz8Ri1G6l7lGw7my+Iga81y3rNtKAYrRE0q8MoqaXWx3YQTTxxXEZnhNRm8gT7kLSyLJdxCmRscaSPCrOmgv+Kns4V2QwySm6sIVceTtEJtViEx0SyCmNDV3DPTSYT8AYNfTFaGePJIcMaVF7CrITr8pICeaj3SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747868852; c=relaxed/simple;
	bh=RDRM4Co8BttxkZdinxezBVk6rYjL2KfTaUR1ujmn81I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SjHzFteV+Ocik6Lp+k6v+Zd833NAil1blPxNiTR6K7DHbNGtEdAu22k0BmPlXIVE7YGqlFDLc32+3MLWUoaAQXvIOXRsYPhMuYidjZlnG6/7TmH8P1tn7mJyBMow/woDW5IiNz6yO+ihvOX9JwlhLKFUh1zCMzOrHWeBaBVce7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tsy8b/1t; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747868851; x=1779404851;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RDRM4Co8BttxkZdinxezBVk6rYjL2KfTaUR1ujmn81I=;
  b=Tsy8b/1tuqs8XrkpiGYs9z40Hg2bvOl62pmjqaMuJWUNWKYeMO7vsNgj
   ZBp5oFWleGkvAQC8xP3MYufGbzdIwrSV3+w0Sox7upcoHXlPVHgttwdgq
   va3XS2hXSYlUHvEiJG0vl2blY8nYOh0gS4Ed/0vqllPKr+OHIWLLu7tqY
   2IuIKHPZrJGv9JO+krWsgZ0oR2CeIysBXkQANMbUuw4wNTKryuC3Zmzt7
   LapDvv/drwzgRv3Udxa4uAvOCDDyuyKcw8hiE6iEiv9r1HT7DjImQpjNn
   Q0qAhdFfVKZbZekzdFMUA+7r3xncUTmTAnlhLmcaU5lQOBNhulXXe0yfC
   A==;
X-CSE-ConnectionGUID: FuOaexWgSguWGdFxKXi0hA==
X-CSE-MsgGUID: qxuedRs2RCezGUeqO5m1Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="60509565"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="60509565"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:07:30 -0700
X-CSE-ConnectionGUID: mYrh/2DdQpeli37kdXYgBA==
X-CSE-MsgGUID: MQvmtP/SRJWsusEBqMVCmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140142364"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:07:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 16:07:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 16:07:29 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 16:07:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/08pgTit1Nh3/q5djhu9T+SJDBzc6/B6Xt7BVm4E3SEYM8/hD6X1qCMdS3++gSOvboU2knRKUlShLcjoPPQq8uJI0P1SQU1jy+weMv/UPmOW5R4KwkheDGnWTxBBrI7/Y0zCRVLQegpLp7Q9R2vvJreyVaTZEtQBipu/75m8IOtF0wCmfNnoLB/6sSqUjgrMBHWol76b1qU97IxcejOtdzpyhcHjswcVbCtPChysB6rKxon0xyDHe2SE9xGQ5RPOmb0XSHTbufjzjEhG8zJA9La9n5LgeEu0KnQwlOiqmhZFWQs0eV3E6tLG+nMapCLO+FDkJxvMkUROnRCV9OFUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDRM4Co8BttxkZdinxezBVk6rYjL2KfTaUR1ujmn81I=;
 b=LIFmaAoGxj1hUU6jrbVcwt+piOMGxDEPPXTtcu/ABS0GjSAuBDTDaGJqbpPnPuB8N0BkZzlv9Lmz3njbfsl7Jaf0zPM1T2LWiAcNTJh8vLUYnm/a8tNVU8pbm4QLBCEvP22RxWZsZL+PyBKLRwygpW2NwLhb8gUWmXkx0RPB3rBPo6TvsMskwDgz0OxrOxbBHVe6l8rOKzJsFHhY3CRpSprdrP70DquqyX6O9KdiSWRWn2mJ+CtSupLjm8bcoueKbxmm0O7KZ32UWt30sEXbL/uyIxne7TC5pRfA+JQ5TsuIShPEWEuptRClksOuuscj25qVBoP0Syk6kndxzFqhLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by DM4PR11MB6478.namprd11.prod.outlook.com (2603:10b6:8:89::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 21 May
 2025 23:07:26 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%6]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 23:07:26 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Olech, Milena"
	<milena.olech@intel.com>, "Nadezhdin, Anton" <anton.nadezhdin@intel.com>,
	"Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>, "Chittim, Madhu"
	<madhu.chittim@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 7/9] idpf: generalize send
 virtchnl message API
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 7/9] idpf: generalize send
 virtchnl message API
Thread-Index: AQHbwGNXJyQgD99KSEaSo7AYmCDJn7Pdxbfg
Date: Wed, 21 May 2025 23:07:26 +0000
Message-ID: <SJ1PR11MB6297A4FD8C815F6D024520849B9EA@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20250508215013.32668-1-pavan.kumar.linga@intel.com>
 <20250508215013.32668-8-pavan.kumar.linga@intel.com>
In-Reply-To: <20250508215013.32668-8-pavan.kumar.linga@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|DM4PR11MB6478:EE_
x-ms-office365-filtering-correlation-id: 6700f66b-85af-47bd-8b4c-08dd98bc40d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?wcv+fdNtayVU4w3/q6mRaz95i50zv8Kb3ZNt0D07h8hzUYFx7zcoqU1QzfUW?=
 =?us-ascii?Q?nvixUkDyT92R73ZPF+f/ZZkT55k7evczYAfwcshuSXSle1nmPxe830ZGtYI7?=
 =?us-ascii?Q?/vnErer/29HelVMsBW1kr0foReT3qDiPhxHvnjliOQEdIPT0+7t9nBn7FZde?=
 =?us-ascii?Q?a+gys74lz7f1e05nVQYwt2Uw2LSkRwAqSTzzeWOQFnQxsnjxdPdIjJ+PuRB2?=
 =?us-ascii?Q?vA51rUQviC1Aps+Ch2O1/LW0WVKoAXXkX7fu6/ee3zPL9pgp0rhKNjowHwji?=
 =?us-ascii?Q?ynWg6wg0248tdNiCQG02uBiNmdH3YcxUTggCtipa9A3VasLXpIPH055K+qrW?=
 =?us-ascii?Q?dGjok11qGd4Bp+FPtZVS8qP6biuhzpP1lw81j0A2V3gW+p+hfHRPGq6awQ/K?=
 =?us-ascii?Q?VpTb6Tmq8rrymPR+UtTkL2Iqf08LUZXj58+D2HOI8feQLb+Ka0GQviXSVWr/?=
 =?us-ascii?Q?60SrPKDSBhiyWiHmbeNljHk+SmdNiZ+Z6rxiLK4/NeymJCp3XQjDC+aeUdU4?=
 =?us-ascii?Q?ighNuy2FGLvBMXEQPpLazf2n/4lVeEzDuEK+im79rZBkFBSIj9OhvvycRtKO?=
 =?us-ascii?Q?SPh3KJqHo+OV0wEnqGtUPKc90Hx+J8hkAajv3vhdj8OcH3/bIaLjkEK+JjXd?=
 =?us-ascii?Q?R7DEGJU7Zkh5eOnJF56nH4C+JeQKfE93Gup4yjUpB7oRCSIAlZKyaG2gjoxE?=
 =?us-ascii?Q?3ctVA52nKAVscNUn9x1jUHhDzxqF3Pgb7PwUC0c8M45e30Q7SM73ej3MuYpU?=
 =?us-ascii?Q?Jq6q6PbEv+Bt3rrf+rBaPFNBCztZDkVznu8rggtBghrfw2GsBLZj7R6IHm1h?=
 =?us-ascii?Q?oojB6aP0pCGBHI0kXB10eA7rO5U0miRQv4dKPw2chLFraMErk58fSwBCjbe2?=
 =?us-ascii?Q?bj+hwiLlTWFyuaUfNYViKg/rqHJz9N81FmgjtEV5sUqubkJao/LAzBz6J4X0?=
 =?us-ascii?Q?CtHODat3LQrbrZ8pLAItLh1ZrsjOj+6qL7esi9z4W6lNJ47OBB094TxTMrMR?=
 =?us-ascii?Q?WalEQzj/x/dc7x9YjSFnPuxzIlp6eBZnM4UWfZLdmq6uemwXS/6Dp+nJEz9G?=
 =?us-ascii?Q?Fw4nhy8lSX24598JrIVkmH/CDt9gYUZJ5hwk5Q+EDniXe+jU1/c+vQlXx+/D?=
 =?us-ascii?Q?4HzjbB4wrdpfvSxkPeCtNvdvBNnANGMk4CHUQ+VLhCSYP+5qGxAXSld2uP0I?=
 =?us-ascii?Q?1jUgxKaptIJP3VDehM+502z+PzzkgzqKCW7vewku4Hr/ntIt0lcVjKpBnQTO?=
 =?us-ascii?Q?WFQqx5VCI28M2Zd7qzQI2M1+aluzD1VAi7BfvHMpImltcb6bUuDWTJaWBoji?=
 =?us-ascii?Q?BrgJEKc1068YwV8DfuffIWOQTK8xip397QcoPe2KK+HKw48zjF6nAJrPYf0k?=
 =?us-ascii?Q?SEVyPYb9SG44kJ6TjOkyn19023bc8Nn8bJs8nacVwOCI6UCNwmeiuZnNrNlx?=
 =?us-ascii?Q?BROQTFsuU1F97KXP49+muECJqGcl3L5TkT9LXRvYldGMz1NeMomLMMqq82Hq?=
 =?us-ascii?Q?acntB9WNj9iBgiA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k928vsZI6LyzZjzOMuAYBZ0lUW7+xJXkVE1HtoHAzeSEsYM7qOQ7Kc1JM7sv?=
 =?us-ascii?Q?upTcif4i7hhghYRuqS0NMV00TbfMod1N1KWYkaeQWoBks5xLcVZqF6yCOpeI?=
 =?us-ascii?Q?/yLnOVkHqs0k6PI2MZbJR0jFDMnqFECqN847sNvyEkroOgsvB89rMpIHTJ7S?=
 =?us-ascii?Q?vrdTwSVyM27siz5VxLaUSPGEqhN5HtcT1pTc6NxY9LuDxDQqN5/aKXv+U1Sx?=
 =?us-ascii?Q?yzfeimtrIRH1GU7wVOOiOR608amx1Iycq1uA0nqi+ngm/EUZzkxBL7oYhrw+?=
 =?us-ascii?Q?j9ZelPaoDw9SpBy6B5V46BkoO7EVbeheCubOLoPC0VO7HCvUfAH4JtO4wRGL?=
 =?us-ascii?Q?fPaZY3vr0LjXDmS1v63s+AIGGo7tOiEvZ16jBT1Cd5h7yaphn/5+Xmh49J/A?=
 =?us-ascii?Q?nVTBm5GUmZyx/ww61/uwF+xbA4TAc1jnT92yOOq96zltATeyx3zI2FPUQNmA?=
 =?us-ascii?Q?CxKqcLGHHrNooBuS4hbt2XdVhcsxSgXjSoyic/+TdTzbOv9R0mOwLXRORcC7?=
 =?us-ascii?Q?tJA/8x42E5mp2fHzsLUIvXojedKsiRsDr0Emo7ix4TguaWHS4+X8MRSJgrGA?=
 =?us-ascii?Q?xBAvrF29BiF/joISOgeWnfKZjLN1wR2ItJz86q482cCN0ugXgDf3iqy3OJUe?=
 =?us-ascii?Q?viqE2bLviLpfzPqejCqDligwnEelljGuXpcd+u29TiWSCEriAY5Jqq83PEQc?=
 =?us-ascii?Q?DO8WSDF6C9Y67R6Vg0X3Ioc68Y2UjnnFkCXRYwgbjEv8TcKGaC8Vd1O4MddL?=
 =?us-ascii?Q?C2psct/5bd4yoKwGx6oMjhEvWQFMN9yb58XmO9VwFCb4e52clR4bJ8suDzBI?=
 =?us-ascii?Q?xgl0ELA6XYN+cKFFBAntKj8M7zD0OYcsHZ71pCrU3d8ItUOySEb+O5BR2OJT?=
 =?us-ascii?Q?HYAWidPIpGjvVXW+ZeADRDtCzasB8YvmtbXqgcoBgv0yIFVL/2pMPzbr15EU?=
 =?us-ascii?Q?We+qitXtfvxNkNNfM2+w11t/pJuiJbBSIrX+W4fE9KvlJmzbCn3VLEJpR9pj?=
 =?us-ascii?Q?s4/4fpyS+UvYe3u6OBPyriF0aL/RatSNMDYhDQcUa2mMkq3aGohx5LzNwXnN?=
 =?us-ascii?Q?1KxfyAgaquT0SXW34iwiXRS8vEIZYTzbPDcQPKur7HhIfq1P7AbZYU+j86IX?=
 =?us-ascii?Q?nsXI/Wm2EW/AhaT8uGBeF0kTTnj0jsv7qlzQvZOSoIGExrQqWYl5PKgBcxAC?=
 =?us-ascii?Q?/KrrhRuF1hyzVuGeebzOJ8iZX88tP7/rWLGaFbQ2gKQBE9IiBOdMShOHMJPF?=
 =?us-ascii?Q?63d1E3YVk38++4WhpjpGyA7HkaITncywEBBeoRXQ04Z26jlBx3YdLKpb0wRo?=
 =?us-ascii?Q?EQCAVW8+mDpaYReQ+Rfb2NdHN4+9HOOxOopighyerdflHPtLk/fLs/h8Pv2Y?=
 =?us-ascii?Q?9MgN7jIktwxoNKjLrVKEdLEqXx7vUjH1p+e17xANDSHNygV3coZf86fXdGUZ?=
 =?us-ascii?Q?V2GGfN8XpavWBU8dLCeMMeXhrjCW3c4E4wFje5KS5XLEw2j9GDk+g32ooICg?=
 =?us-ascii?Q?6blw9T8Mrmt0+cXKbBe3qYBf6ZiJ6KKgGzYuhNTwQKyte8jHEyYBmeCU0wBf?=
 =?us-ascii?Q?8R5k6riwvc8VeKVCBp1VA8sC1cUYLxMKBVoWyVB5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6700f66b-85af-47bd-8b4c-08dd98bc40d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 23:07:26.5613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOoiseAz437tlxCHQHwFAMSmFZ4ivDqLOzeGMUVFJ118uIFKpA8Fqx95FFxybVTMOW+HN6fUULaX990MH0sHAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6478
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Pavan Kumar Linga
> Sent: Thursday, May 8, 2025 2:50 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Olech, Milena <milena.olech@intel.com>;
> Nadezhdin, Anton <anton.nadezhdin@intel.com>; Linga, Pavan Kumar
> <pavan.kumar.linga@intel.com>; Chittim, Madhu
> <madhu.chittim@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v4 7/9] idpf: generalize send
> virtchnl message API
>=20
> With the previous refactor of passing idpf resource pointer, all of the v=
irtchnl
> send message functions do not require full vport structure.
> Those functions can be generalized to be able to use for configuring vpor=
t
> independent queues.
>=20
> Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> ---
> 2.43.0

Tested-by: Samuel Salin <Samuel.salin@intel.com>

