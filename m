Return-Path: <netdev+bounces-144918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4209C8C6F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E07F1F21829
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B4C208AD;
	Thu, 14 Nov 2024 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJV586Q2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64401804A
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593182; cv=fail; b=D9+WGmqNfmu9YeVx9OBuJAkiCjy70YLolhlvR6NLM3KtfY/1Rsi6QiUhVPiFcVfhwpDtwPuMhvR53pkNajWCAQQW+7fgCkajOGnwDLrYAzsa8TP7ogTovK+IEmdyav+G/oizuphWiKRTbbkdX5i60U8RBctzfG8TpO4Qg+Qfq3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593182; c=relaxed/simple;
	bh=FuW9vXKus8CSWkflNaS/MPntCU8PAlKDcInSwOzb970=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tu+cQgvbx1PdJzpnCBIFJBwift6+L7CGdtsgJ8tQNKPKCdxqeXlu6HFcAgS/hLNAV/8/UadveeQrzvU6/U9NeO8iZ5Vu0CtW4ye78YWmtetiwXnwcWcoQG/AsprLF+wXaOEyKP3ILFxxsarqaqLSBSCR+xkX3EGv7hbnX5PGB80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJV586Q2; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731593181; x=1763129181;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FuW9vXKus8CSWkflNaS/MPntCU8PAlKDcInSwOzb970=;
  b=UJV586Q2RvJCwpg4dttRH6cK7jqDYV2f5tIu+jG3TQW8hF4AufMhU9Qo
   XuiGoEXE75+Nfm6MAzZKTQnb+tlMGVmhw53HDRlzXIM/B1c0jaIgv4nmD
   oAXYrPZLme+WZZzPZ+L/STlThLE6VF9ZLFWxRYS4DVBpn1FWkrKx4dN+M
   QJAw6Re1tnxA1t+iBBRnuzkWAZ2lm1wJGKE/XoQHCNNlD5XOVTuMSjF+V
   YyaSeQDYSAw2tjgiHdkMFmWr1mUYnI9qZN9LjH8Ham2f7Y9HE8VKNybGG
   meGf2F7/lCm1OpApNUlXAfVLae5xc6ZC78NXIZsMdlH0iE7HkzvvUmRTE
   Q==;
X-CSE-ConnectionGUID: +ZBgtqXbR2a6cwnFc8PbZQ==
X-CSE-MsgGUID: AqHxwbN4Ti+WdIX3fG3MjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31318312"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31318312"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 06:06:20 -0800
X-CSE-ConnectionGUID: LhktBDoFSDGTCfLYbwYQMg==
X-CSE-MsgGUID: 00FX8TuGR+qTb3M8iR3Jmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="119150266"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2024 06:06:19 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 14 Nov 2024 06:06:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 14 Nov 2024 06:06:19 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 06:06:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a63q0w3mNWPowIdUeEtWsNaFaIoZRcQI/mhzJ69VDS5D49cHjKfalOjAT7cyXIidxER/RDhCeboYL7HLNHRZs8/qj3G5glZhLHwl9keR2DoZCi/5UBN5zdVMVMycI/cXtn5IEhj1H1JUeJD/xqSOuqjK04jyOs6EIiHilhbbwNY6V/yRhe5H09dvtP5XckvUseznyUDU0Y/C63X9BIse/JlOjOWF9rxvHfW3wXYBqFqtdzbj9KA7oDfrbb2w45iOHTg3hC0CwO/jbeAcPpwOORCubdo+i8f8blw64ZQRu3/ZCQlkoLFEkaO3VS679fbiBfthnF92sUUdZzU2WAemDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZCT2EG77yw2UIBOAOuYzO4nRGnfX+vkMKPeFN2rcKM=;
 b=aDJz6kM7Ehq1kDjvPSE2r124W7TUEWIV5DW/exJyNLByWl/wpB/UsDdUe+LCI5XcLMOdPRUeBtaqSgocK4pd3Kt2xZUnMnsKR0abiTyKWf8Dx9raqD+gRIUXJfAW8tB0yWhZDx0tkSIpN+NuwERhnqvw5okdeF0MaeeP6mqKpkOVnEE37gzxD73/C/i8JaOCEMC3z1TXjTLlot61TmJC8aQj6t5kA27QgDmRy8LO7sxDoqbvs7ojqVSUYR+OPyKc2K6ooGcbxPfKVQvVbxzgEjpajrYWRb6jCwZ4p6P06Iqf+BJPySQc5MPKlsHi5UY0z1H1+lyFOyAK3J/cxHXj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 14:06:15 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%6]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 14:06:15 +0000
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
Subject: RE: [Intel-wired-lan] [iwl-next v7 3/9] ice: remove splitting MSI-X
 between features
Thread-Topic: [Intel-wired-lan] [iwl-next v7 3/9] ice: remove splitting MSI-X
 between features
Thread-Index: AQHbLrMWSY+AUgq0FE67z8o5Al+WSLK23wdw
Date: Thu, 14 Nov 2024 14:06:15 +0000
Message-ID: <CYYPR11MB84292BD495127EEC449289BEBD5B2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20241104121337.129287-1-michal.swiatkowski@linux.intel.com>
 <20241104121337.129287-4-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20241104121337.129287-4-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|CO1PR11MB4993:EE_
x-ms-office365-filtering-correlation-id: f295827b-b09d-4483-986b-08dd04b5811b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lHTOmpKieW8kBhlJ3CKRrpkm/FzEvSBVp7Y/KmWXlCkwHZXOUbIO0vVs7GvY?=
 =?us-ascii?Q?P0WZTZoZFJ2mgxIfPOKJVKoSLUnKuB0z5nblRfFJrFbfGUTrIF19Fk8nV2XC?=
 =?us-ascii?Q?Rd7qHlomB0tu2Ds4WHOi4x9lJhJwpJrpZYybDD287CtFyHMeQ6IwmDJfBQ5Z?=
 =?us-ascii?Q?et0TAmyCh9NmaHZz1MGUna6FWDbUPdGxYxz+tOM+I0AZtSlc0v99VhHmGXHb?=
 =?us-ascii?Q?UoWLzUpD+IC9m82dhJv0K3fy0aX30vb6+fhO7Wz4pMsUBzaIOxn9rCgploXl?=
 =?us-ascii?Q?gPMcCFXpOjRyHkpUwXeFFrCVT6Q2gPJevakSvZ72Dbfk82Jh1xBUWtuAXhV0?=
 =?us-ascii?Q?WXhOFL4gRdSM+Q1dTmdcgEVCCFaCNRsJrf4WvqjTBmfbmQCq8lXjbY46K+6S?=
 =?us-ascii?Q?8SafAjaVbRb2lUh94BJnI3IXrTuIUUm8ob/ftbGxM6tGZXCQv80BsxRys/AF?=
 =?us-ascii?Q?NLPHrFhgaA5SbKuHpvZbNWfD03Z7fftpoQfcHEIZkI3bWjtdb9y4h2MmyrJO?=
 =?us-ascii?Q?DGeSUPf+HlVWSOWuwqzILkgnl2Fv0roNVv95/XDgtV15U835LhnK/Gbea4AG?=
 =?us-ascii?Q?gawXk2/gmkCJKlqCMs1iF3Ja1JLBwvzMAd5/DMmzXVmEdjFRUioaZKrx3RCa?=
 =?us-ascii?Q?o0XyTz7y1uXDwg/3/wFKmVC/F+TXOGT1h5VaN0tZpF4Fr7nV8Yws2mkEqoSs?=
 =?us-ascii?Q?viZTmnZUrJAQz7iAtRft95Aux9jublhTbNgYRJADN5DZGE4ifywyebzSQZ+d?=
 =?us-ascii?Q?CKBRiKfUAt0IFuvyqZVMwVzBY6J6h81o3az2Lwvpe/3AhQn7c6QGl5LdUwhq?=
 =?us-ascii?Q?phCYOmsj9AuEOEZkry+Opl4oyxT8S3Bj/4xZO4VT/KF/PJFpr6j2+i9i3yHC?=
 =?us-ascii?Q?MCvE8vB1t3gR4jMum3rnxOau444IRoHyM51pZ8GRUmp+4t3BArY0GAQnnGz2?=
 =?us-ascii?Q?rV2ex3HflV1e8On24eu/NyIyaFhAnyvT66oxo0lVr2kdQ0yxxGzCxzMQSRTA?=
 =?us-ascii?Q?A8uODFLu0csALnf1671KrrZHiHGzjk/YHkR7lyUvhytz2+looX1UyObYqB6b?=
 =?us-ascii?Q?MLttvQSVI+eL8bUXsSmVp4v4pYIEaMll/lx1sBDOVWW35vnS6mDrYHkkVn1Y?=
 =?us-ascii?Q?JQSheujSg8CYIuBvVlPf45836UOlEbtXf4Wm/7ycIDGvUuk6PvwRhP9XqlRH?=
 =?us-ascii?Q?mm3uIbCZa2oFePDpF7/YTLl2qWIvp5CIU0gxrGZLRT8fyLIB5SIWAhUsm8Vp?=
 =?us-ascii?Q?OnBtP2ORYy80k95F0f7nT3J5VeAzhl7yNPIofsU9H8/fM0Cgp1aMEIg8jz1E?=
 =?us-ascii?Q?ZdK4F6BYdjiISK4ul6PKG/48jqyFWtLaiD7qU9+JPrdT+5EAVGxIeGZBt/qg?=
 =?us-ascii?Q?rgaHnXQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AvV7SB0J6TLpGiVUuDRxL3Bc7ydvdlcHfPmz/jCltvWW3/uR+31IKf6KZcgu?=
 =?us-ascii?Q?ppysYcOmG1OpdqR0WqHU1KsFsR/JpN1PJQWtdz4nnkFvy3cktmWw/c0cl5Y8?=
 =?us-ascii?Q?1EZk1QQGqw+S+96ZCdU9y20RSKN3R0LvkVBnGYA5ZQw+9sx9A/sF3/Vbvn0f?=
 =?us-ascii?Q?CWgIVdcTvknW/hvj4tC4Fen9/gpwUUejXbYajW8uek3RUNkL5rfBe2nuWTXo?=
 =?us-ascii?Q?AqXXT//tsAjNpO2uq4UYNtVcbbQQ6mSwAvrZEhDpKQfN4xwI0Z/Mk6PQu8qQ?=
 =?us-ascii?Q?0BDcXo02Nz2gMXajrf4dzGiqZ1Vo1gMv6SeMhGlGpr9ZPiNq6HSWdctAaOKy?=
 =?us-ascii?Q?jkDHbML0FIJLqTw6c1RMhcWz/JWsCOYMLMJ0PpnpzxX1Js1e28zVcn1b0pJn?=
 =?us-ascii?Q?i03ucSmopF0k2NivOH3G6xfeobIMQylP8YlBGAVW2Pkzvl2yh1h5Tf6FWuZA?=
 =?us-ascii?Q?Up5nXUwEYXrkLkF4qZxCaU9eoUH4zLGM99AbsyU1uV36rfJh9cr5YjNLuQHT?=
 =?us-ascii?Q?N8o6v4+oOJfhK40p1nlh5aojn7hm8RwTa24Q8gWmst8mfNhn/2uJzY5Ecx+6?=
 =?us-ascii?Q?7iW1Rrx3Qt75A8OvY+DFKxwLyu7v1ih0xSmNUN8etoF4DRKHezC9uDRbyPfw?=
 =?us-ascii?Q?7h/1QFsYUd2Ur9Lr6pL2Q3WGiFmYIUxUen3LOaGPU+MBA26vG0m6MyWlxBmM?=
 =?us-ascii?Q?zjC90Xm4JBkx2a7EeDkFFFIZ1s24e6GoUfHpQ3ojWcKdDqBBrX8Xh2Ysytij?=
 =?us-ascii?Q?+lKCP0ja5ZzpTBvMh/SvX05hJmT/zpbyx/D0Gze5MV0XpdqseePxHs726gg2?=
 =?us-ascii?Q?LLYR++Hp1mLDS+t4gzEb+x1+0kebuqdUBRyqjdCezCXzmqou3kvw+5ur/0Kq?=
 =?us-ascii?Q?4MkfmTQHjqTzhbJztsHJenHENVbi+5yBzjeS41cpr0EJaIAJ+aoQKWAzA67W?=
 =?us-ascii?Q?NcreXwycYvc6uy5tioPDysCHAOd3DVCnZa5r5VvbHkEusx9PFrvd0RIYR3rC?=
 =?us-ascii?Q?8zcWOVinLVPJMRH3Xo4hN2XNeodttaH893mD6z9y/BUxCXQnMbE4NOVA5kp1?=
 =?us-ascii?Q?Dgf19npBKJ8gvdw4dVE9ql2u976RRZ3+dvRgRx/seGaUbFWoVcakj9nHLehn?=
 =?us-ascii?Q?Odcjr0fILIgZp/+qt1Jpo/gSyH8qDhNhE7HBbv3yPbuMw3avnEYrvelW+rCq?=
 =?us-ascii?Q?EPrDXTb/n15mb06cOg3sQu5T7iWi4nsDhtZSkzy/0wvX+C0foKJha5tOBL9i?=
 =?us-ascii?Q?v7TQ9gav5gXt3vAylTeZHj3E7/xJ2TmMu4i1xGWKFvAuMSKC5WRPnlzjxdpV?=
 =?us-ascii?Q?57WzWUz7vrVbZOp5xBAS3nvXnlGlyOZ5hQtNgKBFTmxVYdUQZe6osqjOFD+F?=
 =?us-ascii?Q?EG/ncCA4lh9r70D2ghvQXSb3LPSRlmIPv3hWVB9+Dyuq5tcxWuh0SLiIY4m2?=
 =?us-ascii?Q?OJXFVtNrveQ0fneesG1clrfT2EIrTXg4DmqtqoEAYE3Zq7o185PXY8Xga6mP?=
 =?us-ascii?Q?H8hWhTONPjPctc/uQ41ddMXmlmHBl+pnjCF54RyVtmzIFr8VO8gzK2F0xoR2?=
 =?us-ascii?Q?hJ1VFGWyycFvgkrrWS0Jun1Ohz33cclT9kOPlYB5H/SJlyDWie77rLgC1hC8?=
 =?us-ascii?Q?4w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f295827b-b09d-4483-986b-08dd04b5811b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 14:06:15.7754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TkG50X7Kw17BbRFQ+NV+BUy/zPyPPJVd6Y6VtKcf89ysExQA9Geh6XtbJSze78YYJf91WM5l5vGr87IxiqntZFcir0ufjT/ksgK1IPulXT/fOG/3LlJ0RB9vq8lplCy9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4993
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
> Subject: [Intel-wired-lan] [iwl-next v7 3/9] ice: remove splitting MSI-X =
between features
>
> With dynamic approach to alloc MSI-X there is no sense to statically spli=
t MSI-X between PF features.
>
> Splitting was also calculating needed MSI-X. Move this part to separate f=
unction and use as max value.
>
> Remove ICE_ESWITCH_MSIX, as there is no need for additional MSI-X for swi=
tchdev.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h     |   2 -
>  drivers/net/ethernet/intel/ice/ice_irq.c | 172 +++--------------------
>  2 files changed, 16 insertions(+), 158 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


