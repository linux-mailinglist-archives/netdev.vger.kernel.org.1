Return-Path: <netdev+bounces-262637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4J1yHk18pWm6CAYAu9opvQ
	(envelope-from <netdev+bounces-262637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 13:02:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE38A1D8039
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 13:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A879300E489
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 12:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FCC36492C;
	Mon,  2 Mar 2026 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UMo3qg7n"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04A8363C5A
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452925; cv=fail; b=ZNMnPOcPWg+crKZ8TKJc7ThbJQ0v29vpjDdrs4+HAyXOGfln6uYJZFFGn+SnynnBbxvqbA3st/iX11NnHrHF+WuY24KRLevKXIYpsXRuc1MITayltpAFKxYWRQ8xnDgjVaX2KqlfuoS5DPEspPkRNxTbmom6cmXPMDiYmTgOZQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452925; c=relaxed/simple;
	bh=vFZkijgak5kdmv26DvRUsOKUbMst2srfGXai3WxfW50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KyrV/nS9oHcGru662qvvMAIL5RNdXqq47nFT+Wtr/AbHRCz5Bk3PGGhgqqKDF0utRA/QYcsZ3mCpMZpfVbReoSZR+6rDEJE7mGiC4PB8UnQL2KTkT6PeQsYFvcxsFFqXzeMovgko0Ru7EvY9XorKI5Msb5txaaTAPbK4OcLk8ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UMo3qg7n; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772452924; x=1803988924;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vFZkijgak5kdmv26DvRUsOKUbMst2srfGXai3WxfW50=;
  b=UMo3qg7n1KyU1Q/99/2crOo9NsdmtLNM3/1E3+nPs2abdqlUsndlfbsk
   Yda4NdKwjTfS5h8lQvAs0J4OqlSFBhCxOkZjtmBLHydqqs15ymZXWBk9Q
   8c5hyGfFnJvNanAP/Po/ZJ+f2LO2uBPViOZtC0bn6NOVkbRKCtR4MRosa
   vcGG4ZJXuHUIQEHPV6B3nGKA9YPuSsbhP3Yyzc8gtcQuhjIMg/0k2R+kS
   NQUu9RY67n98yyVtoLAxPi7L0E+u18FMMdxx26aG1wVX+I+Ssnpdfv0rR
   GoCgm1kYBtUAKcK0a/0f20QAiwpnfF+PmcvOWXj9XVzjhAmeWuyFA5Qer
   A==;
X-CSE-ConnectionGUID: Pr63hu7BRQORhyCVXZJYHQ==
X-CSE-MsgGUID: rUl9lrZ5S4KKnnZRqkqzkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="84550948"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="84550948"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 04:02:04 -0800
X-CSE-ConnectionGUID: 78iDaIVZQmK7wMEhv+uA5Q==
X-CSE-MsgGUID: C5JiDkA6Qz+tEmlXJyu6yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="222135829"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 04:02:03 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 04:02:01 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 04:02:01 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.24) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 04:02:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0B9brVap5rN/inQN2leaxHaEYpP2sBbKXxDljDAc+bctZSuzZ3Cjn2l8ZOTUCpJQ2Wg0ikhHyNLrhoRfSY3+6rjlA5W7y8sLWZzSHZ2mtdU30vyA0KED10tJO0yLqOYiwKmJHWssBtGI9A5AhMeiqM5RgYZjTrw9o2ZTyUdulz/jBXEbL9e+qaXU6umjjVcMRyyyIY61NR4MYcXpZ3wEc8XDQIKWiCsBnQ0u5gnUEDRhWHSxGGQ08Z8umY9Mmt5FlBYPsg90ib7NmrFOXOGpIqzJpmNEWOX2a//GlzJUWMDwVLwMb4+BFAmipusxtdSYMLcY1ZnZMtrWQV9Iq04zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFZkijgak5kdmv26DvRUsOKUbMst2srfGXai3WxfW50=;
 b=yc/eeJZ1iFOSAopObkwN516Px1AUlLzV06YnXYG3XX4OEDhPzRfPLXujSJNyN3RwP1lCEMRaxteFuapZY5dnURe48GXtM5WsgX95/XhsWtno95XlbOzgbdMGSeV6qvsDAUG19XD0gWRDLfvSWnxqnSLN0TZhwYiDE6n3XpUn9QY7BrDv0tilN4RZqnB/car3QUjUeXUfxqcu2ZFydY8TebB6V5ugNiDnV02EPmWy0FZOo0ObDMUDKdnnCbWFt3c9K/SeCD1Qj+azdEVt2HiXJlIi3DaVD9w2VTroCQeMEI4u5IunhcD7NWPH7u1315DjsaBTPHgy/cxOHjYki3Fmvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by PH3PPF7A88A980A.namprd11.prod.outlook.com (2603:10b6:518:1::d32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 2 Mar
 2026 12:01:58 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305%5]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 12:01:58 +0000
From: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] ice: dpll: Fix compilation
 warning
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] ice: dpll: Fix compilation
 warning
Thread-Index: AQHcpNETliauqVK5pUasiQUqHVW/U7WRjXcAgAmhkRA=
Date: Mon, 2 Mar 2026 12:01:58 +0000
Message-ID: <PH0PR11MB490409B75FE15DA1C2FD6F45947EA@PH0PR11MB4904.namprd11.prod.outlook.com>
References: <20260223143214.241797-1-przemyslaw.korba@intel.com>
 <9e9c69b6-643b-40c4-afe5-fdbcb185755d@intel.com>
In-Reply-To: <9e9c69b6-643b-40c4-afe5-fdbcb185755d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4904:EE_|PH3PPF7A88A980A:EE_
x-ms-office365-filtering-correlation-id: 396a48ae-badb-41bb-b480-08de785381d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|7053199007;
x-microsoft-antispam-message-info: atnzqXjF4J9XkwpGAdj1XbJx2hhP8R1r4PNbhyq2fPl7Y2L3uPvEDgGV8Mf9g7m3OhDXi0h9d3HP6xbn2f268N5ihjZg0YFxvTL1Jx/47oudgSWBUatmwZNyN7zSio4MBAnOqQPSJIIiTiNcxA2LtQgLR0AdLVv5hWf5/WC1I2g9nmHlk2aS+hJERdbuPau4DxKc6rX+xmozgpoX0NjkEAOvl3jpqY/KfPdzD0GhCRI698nmLdVeJiEgGVegk6u9CdU0VybH4zlQtUShx+/7efVHnuZ7TnhGbzpNTuwqEPrPsXldKyILkFWUYrRgAC1HLVtYw1Bh6dkWEVdHTe5wEO0Jm1A2LIj0awll1gi5FRuvKId8EU6e7SML7hUNO+vgtKDf6YF96mkmNAPaYjAQ7TPoiP7JW6fimYI7KvgQXhlgZqAiux+eP5NpXBBlOu1GUl05dE1CTUUgOWXA5OkIXQ+yTx+gE8ieNsOoXtyotUN7vXQcu/oZe0s/LuIsgsUftKLLvcbv1R/HYGBgFGzdJKwurixCa8msVmq/NCr/VBTjOpfMaSglX8W9rPgBerlNFQBcqusYIdGaCQ/z/+dzz+TYGwlG503SlqJU0baiIeJgDkKenvT844ytEUP77XNe+zgUjg8PAx1KTblx68FcDOkteyD1ablFpXdaxNYiD2KBg9EuV9ggG/ZAEw4pUYoR6J6GaDnOxK907GROhFo1RXLKlp8gUeIBCD7k8MGLPCSEcfPU9aZQWvc+/P/uXkX0VagiM9HecKwrBRI14JFU5SY4TDKOqJutOxA6nr7qzWY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4904.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWkyOEx4MjBrSUIvTEIrMGxiVCtTT2M1WEJKNVdkNzBhMHYrMXhKZWpEVytx?=
 =?utf-8?B?NVAwU3E0S01EbDVBLy9nUkZ1YXd3anhHVHFwajkvTGVYdXdKUklxbHk4Wmh1?=
 =?utf-8?B?UFlqeFZzcmpJdkw1T3l1MWR3Wng1ejZkbklEMW43S2Vzbko3UURZQzlwOHBh?=
 =?utf-8?B?RHhIM0NoWFdUeDRBSWZYZ0lIVzRNd0lya3dOQnA1b3Bvd1dQellpSyt1bnZq?=
 =?utf-8?B?RGVzOWplQ1Zralh1VU1JZ1p4eE8yU1Z2STRpN2dJK1d0cnJQWWtxTUMxL2Jw?=
 =?utf-8?B?NU9WcGQ1STNYWnRxWVBmVTJBSE15cjZWYmZUd2llQjVVbzVoZGR2T2V1OFB2?=
 =?utf-8?B?Y1JoZU9POFBkaXBySVMvakJBZDFQVTRtd1IrTzBqZWt6SkRZaHBHdW5uai9a?=
 =?utf-8?B?MzJweWJTdEhEYWtPOXpxdURvbjFMbXRweHM2aithWlpVUEh4UkNraWZ5Z3lT?=
 =?utf-8?B?N3hPblV5VU9oa1dvUFBhMmxFbkQzYWtxSDV5WHhhOVBaTEx6M0QvVVcvYTcv?=
 =?utf-8?B?VXZhT1RKRU42dFRKZnJ5R1Q3V0pnclllaGtvNFB3UjE2THpWb1dsVkpBY3JG?=
 =?utf-8?B?bXdXTm1mbWpMMGhiSFZYQlp1aitxRFFTUFJ5NldUK1JhSDUvSHZSVlQrT1Az?=
 =?utf-8?B?QjRXMEpIQlFDbXc1OVZsZG9nL0dCWklDbjFrS2o0RjRxbElSdHM3ZmtUdkhM?=
 =?utf-8?B?RFc5MXNybG1pVzI1OE1rdGNQZEhQWUlad1ozZEpYaDVGY3o5TWcyNWJURDl0?=
 =?utf-8?B?KzIxc1p1YzY1L2E1dmJpME9FYnpEUlhmZTBNUU84K2RHM3hQejJMcVErcjZC?=
 =?utf-8?B?OXFIS01tMWZiYXZkQnNCSUpFWmJKUG5lQ1dnRjdhYVNVbENjNjVKV0t4M21k?=
 =?utf-8?B?MG1MdWRrUEd5ZFovNkZ1eFN2VlVTSUNGNkwrRkZEWjBYUFZiVXFHUW5YYlgv?=
 =?utf-8?B?bjIvZlUzalZUelYzalVMZ0czeDdyQUxNT2x1Z01jRnF1dGNFOUVZT3YvZFJr?=
 =?utf-8?B?cE5VUHJzeWxXYUdjMjJQaExLbjBCNk8wdTNPdlNlekpsSG5NanlCUnIwQVpX?=
 =?utf-8?B?MXJtcStpLyt1VklqeER4VWZxTTZSbGtqKzd4VnpPSFErUXBIVlFvVFYvWGxO?=
 =?utf-8?B?NFFLUERnQ1E2TUNnaEpra3RiMmh5L0hBSXhnWmNjbmVmTnJLb3Z1VGk2Vm1P?=
 =?utf-8?B?TjhOY0lzdnNuMWx5SW0zTndLS3BrR3RpYWdwSHBaVHJGRk82SUZBU093d21K?=
 =?utf-8?B?M0paTG0wMjJna0x1dFhwbEUxL3BOL2RzeHZvak9PWCtRelIzL2twcEY4Q3Ju?=
 =?utf-8?B?MVhqTXJUbVpTTnRIb2Zlc0psNUVDSUZVSnNsS3RDelpmREc4RkZQK3hVeFla?=
 =?utf-8?B?VFBpeFlMMkZtY0wwTlRWVWJkWlNMZUZrdUUrcit4WHlySXNQV0NadFhBTmRo?=
 =?utf-8?B?dFh2S0UzV0loYzNFbWx3ZkxvZng1WXhZaTZtK3BJczFmZVV4NUxIWENXRCtZ?=
 =?utf-8?B?VjUzM1dkVTk2VStGWS9CZGEzRjJnbkhmZlNlcDZEWTFlejF4aWZ0bFcvQmp5?=
 =?utf-8?B?OUxseWhncis2QkVPZ0NmcEF5ZUJjMGFsd2Uvd3ZxUlNOSHI4ZFY4eDdYLzN3?=
 =?utf-8?B?aWY0RXFCdThVdHdRNUtmT3BpaE9EN3VjV0dnYS82N0F2Mnp1ZmROaHl6U3NY?=
 =?utf-8?B?SUlsMlRJTWdOVFZ5T2gyK0xGY0ZNOGRHWEo5Mk5pTklVOXJHU1BOY2JUR1dt?=
 =?utf-8?B?bFUyQXB2YWgzK0RESW1kQnNwSnlVN29MZyt4YUZTRnEzZW9URDU5MnZ0c0ZC?=
 =?utf-8?B?aDgvaHdMQUxPV2lkall0aWJGakJSKy9qN2lUQnNGc2FZNU10WnppOVBWUVZ4?=
 =?utf-8?B?TEdDa3pzZThnbitsWXVIVTVpa2NneWxFelN1RDFlVzJIbXJqazF5cnRQMGp2?=
 =?utf-8?B?Y2psNU4wL1hEb09rMHVPaFRld3V6WUNHNmcrNjh2SDRFRDhiUzNjWHpKb2Vw?=
 =?utf-8?B?N3dVdXIyQ1lhRXNKdXJ0WVBSMjlxYWsxYkRPZGtJZGNGZEZiVjgzNmYwSVFz?=
 =?utf-8?B?MkFMVnVadVFhZGthYmdMb01kSUNQVkc3V2R0RmgrdjNhQXk3UFlYZXREQWNn?=
 =?utf-8?B?TDBBamtybE5FYldzSStqeXNKZ0hHSSt1RU5ERzFEQ1JqYXlMWERTVHZLejM0?=
 =?utf-8?B?QUFLUXJUQ1FyeXJwSVVGa1BlWFlEZFRMQUlzaCtQbXVnN0l6YzE4MEZnR0xo?=
 =?utf-8?B?T3N6bmpUUjdpUmtBdTdQd2M4UVdxVzVpMiszYm4xUWwxRHVpa3VWUTJPZVkr?=
 =?utf-8?B?cDFGOWpVMHlMa0dPL2ZhOEJTN1VNTnB5aEttYnZsVkwvdDZreXJHQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396a48ae-badb-41bb-b480-08de785381d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 12:01:58.8767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HQYn0TXf+yqLjaiM1P6xzgefkIoLBfIjXEhn+p+0gooT8DA56ELGXoAHV37RFyM3RLoctPsKJWkxgu42AiWVf39d2PKUFXZZg1N2qZvQw68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF7A88A980A
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262637-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[PH0PR11MB4904.namprd11.prod.outlook.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,osuosl.org:email,intel.com:email,intel.com:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BE38A1D8039
X-Rspamd-Action: no action

PiBGcm9tOiBLaXRzemVsLCBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29t
Pg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAyNCwgMjAyNiA5OjU3IEFNDQo+IFRvOiBLb3Ji
YSwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5rb3JiYUBpbnRlbC5jb20+DQo+IENjOiBuZXRkZXZA
dmdlci5rZXJuZWwub3JnOyBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXllbkBpbnRl
bC5jb20+OyBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIGl3bC1uZXQgdjJdIGljZTogZHBsbDogRml4IGNvbXBp
bGF0aW9uIHdhcm5pbmcNCj4gDQo+IE9uIDIvMjMvMjYgMTU6MzEsIFByemVteXNsYXcgS29yYmEg
d3JvdGU6DQo+ID4gaWNlX2RwbGwuYzogSW4gZnVuY3Rpb24g4oCYaWNlX2RwbGxfaW5pdOKAmToN
Cj4gPiBpY2VfZHBsbC5jOjM1ODg6NTk6IGVycm9yOiDigJgldeKAmSBkaXJlY3RpdmUgb3V0cHV0
IG1heSBiZSB0cnVuY2F0ZWQNCj4gPiB3cml0aW5nIGJldHdlZW4gMSBhbmQgMTAgYnl0ZXMgaW50
byBhIHJlZ2lvbiBvZiBzaXplIDQNCj4gPiBbLVdlcnJvcj1mb3JtYXQtdHJ1bmNhdGlvbj1dIHNu
cHJpbnRmKHBpbl9uYW1lLCBzaXplb2YocGluX25hbWUpLA0KPiA+ICJyY2xrJXUiLCBpKTsNCj4g
Pg0KPiA+IEZpeGVzOiBhZDFkZjRmMmQ1OTEgKCJpY2U6IGRwbGw6IFN1cHBvcnQgRTgyNS1DIFN5
bmNFIGFuZCBkeW5hbWljIHBpbiBkaXNjb3ZlcnkiKQ0KPiANCj4gdGhhbmsgeW91IGZvciB0aGUg
Zml4DQo+IHRoaXMgaXMgYSBjb3JyZWN0IHRhZywgYW5kIGEgY29ycmVjdCB0YXJnZXQNCj4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogUHJ6ZW15c2xhdyBLb3JiYSA8cHJ6ZW15c2xhdy5rb3JiYUBpbnRl
bC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNl
X2RwbGwuYyB8IDIgKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2ljZS9pY2VfZHBsbC5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9k
cGxsLmMNCj4gPiBpbmRleCA3M2E0ZTI4ZWQ3NWYuLmYxMDFmZGIzZTljZiAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2RwbGwuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZHBsbC5jDQo+ID4gQEAgLTM1MzIs
NyArMzUzMiw3IEBAIHN0YXRpYyBpbnQNCj4gPiAgIGljZV9kcGxsX2luaXRfZndub2RlX3BpbnMo
c3RydWN0IGljZV9wZiAqcGYsIHN0cnVjdCBpY2VfZHBsbF9waW4gKnBpbnMsDQo+ID4gICAJCQkg
IGludCBzdGFydF9pZHgpDQo+ID4gICB7DQo+ID4gLQljaGFyIHBpbl9uYW1lWzhdOw0KPiA+ICsJ
Y2hhciBwaW5fbmFtZVsxNl07DQo+ID4gICAJaW50IGksIHJldDsNCj4gPg0KPiA+ICAgCXBmLT5k
cGxscy53cSA9IGNyZWF0ZV9zaW5nbGV0aHJlYWRfd29ya3F1ZXVlKCJpY2VfZHBsbF93cSIpOw0K
PiANCj4gMzUzN+KUgiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBwZi0+ZHBsbHMucmNsay5udW1f
cGFyZW50czsgaSsrKSB7DQo+IA0KPiB1cHBlciBib3VuZCBvZiB0aGUgbG9vcCBpcyB1OCAob2sp
LCBidXQgd2UgYXNzaWduIGl0IGFzIGFuIGludCAoZ29vZCkNCj4gDQo+IDM1MzjilIIgICAgICAg
ICAgICAgICAgIHBpbnNbc3RhcnRfaWR4ICsgaV0ucGYgPSBwZjsNCj4gMzUzOeKUgiAgICAgICAg
ICAgICAgICAgc25wcmludGYocGluX25hbWUsIHNpemVvZihwaW5fbmFtZSksICJyY2xrJXUiLCBp
KTsNCj4gDQo+IGNvbXBpbGVyIHRyaWVzIHRvIGJlIHRvbyBzbWFydCBoZXJlDQo+IA0KPiANCj4g
YW55d2F5LCBpdCdzIGJldHRlciB0byBoYXZlIHRoYXQgd2FybmluZyBnb25lIGluc3RlYWQgb2Yg
d2FpdGluZyBmb3INCj4gYSBmaXggaW4gdGhlIGNvbXBpbGVyDQo+IA0KPiBSZXZpZXdlZC1ieTog
UHJ6ZW1layBLaXRzemVsIDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KDQpUaGFuayB5
b3UgdmVyeSBtdWNoIGZvciB0aGUgcmV2aWV3IPCfmIoNCg==

