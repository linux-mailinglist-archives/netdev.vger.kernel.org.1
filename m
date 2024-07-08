Return-Path: <netdev+bounces-109943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A353792A5DD
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 17:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E0F1F21C1E
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 15:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61032140363;
	Mon,  8 Jul 2024 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xk6NbS8i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D64B1E898
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453104; cv=fail; b=KgAsrRNyw7fni8DPDglUMA5FDxLMaOdzl/mtNJtNP9ANW30/3I65PYFDJK1gGNja5beWZeyBlRKn1lpue9a//IBoyt2yS+QBnmIAOhJUZqw08NvbomJZsbGt/WvwcBlDtPdW+PS4ze6KpEPg5OkCDHqtk0dNSKOlMVSCCpoEojM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453104; c=relaxed/simple;
	bh=00hAXGfA2aXkDptdAa9wZIV3or/4iLWOIE0mVXIW0Ig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PtZHSy2jsQL8nUbbCVWxlR6KjYQwLVJl7B5+eYijVDHZIViSCmfwnmT/q06X2YEjyVV4ysqOBFIs39RnScr0lPfzPmpyJYCoWzKe3YU1vknWOMAqodJrPn1AmEe0FqOzhbwA0bFhcSzgoUKEZNw8ESq+0g7RK2hNSHLthO9hD58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xk6NbS8i; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720453102; x=1751989102;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=00hAXGfA2aXkDptdAa9wZIV3or/4iLWOIE0mVXIW0Ig=;
  b=Xk6NbS8i8oqgP0b0O3ZvWd46+m5azJesIKxX7X4Ohq3ji+LghZ/0IDy1
   C1+0YaLW49G2mUQeg6KE2ZbB/eTkZFAAxrZcL47hR0/LAdoO4tqcOMFe9
   AYcH1t3SotVF3sCZDx2RgAMobPCCbM/NVYi55AqyYstW4Yp9NG3xVTX6d
   qWwamSA79PpS5X1gl6xNUSJxnVcp/GHgf3v1F8L7Ba6nyfA/jfQalYK7k
   4eTQTnFkCSpYybiPSjCl7xkG0YJmKVlw/erVgcRCzCsQgeG5hoJPE4lHc
   GTPFKLTQQUzuiS0bo41HrQ6P4MtuiA7Rex6yyufKYlGL+cQ7Fbjmtm6M4
   w==;
X-CSE-ConnectionGUID: SjYc/C5pTbe3AFC+Oo8b1A==
X-CSE-MsgGUID: pI5vLIKvQDyUqYe6qkxTqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17869842"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="17869842"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 08:38:22 -0700
X-CSE-ConnectionGUID: eAwn20nWScug/Lhiu6XqfA==
X-CSE-MsgGUID: H2BThYQqQT+s89Kp/pClQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="52142611"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 08:38:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 08:38:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 08:38:21 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 08:38:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAj/V9JszaqoJtOKTxOviargzyEUB/hzy4l4zM6jk3YztllJQzpzqVE3Jr/pO2DhGTRzRFjTRC3QRRxNtr+gRJDNa9VFEcZML7BL4JXzdd1qppNYDqxgD/bnIRU3rtrOAG24dyD5YVG34pT4YTcAxJJtdOX08JtZKgD06Cknp92ngZgziIXy1IeDCvZLmkC4JGjaE/dbr3LgiTGUoOOKYimTnkSVUyvwKG2rDQBxWc5oOCMIQq4iHpInOqrcsYj6JYX7vamMtocnE60tMxAP6X+QPyad9TdDhCZI4k0c41F3O4HVwWNpsoClbo3cQIr9KpyjwcnxBG1zKVEJNIcUiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfHbRXwq5M9+qE5EaD4HdZla6ktY/0yFNJIIx5sB0VA=;
 b=C982FsP9QO/YL031K7fRYJmgz6XVwQlo0zd1gybErvGFx3lCiL2IUTcu7VXcLBMtg13WwOzECr8aj9vgxd1XI+eEYW2AnXZL2/hDqNWm5esdoaTsyZnu5YMYAqPTLqIoplIS15F4dpQ24W3gRphkCg7GUae9ATV+F9jwvptVndnAILvReJ4Cj8fXyHcIQCm2wfBBYIY/ChLnCxFNRtesO09v+qS+tYfwS0cvI4uo3sL71qRnCI8EthQGL3uRoBMc+cWqy8Vo5KDmpr3PbEv4PFIzakKamyBpd5OBEu4OnQ9jH++nCJaM1xfl4oTQdmKV0rDOTUMtkKszKFBhFj16Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by DM4PR11MB7206.namprd11.prod.outlook.com (2603:10b6:8:112::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 15:38:12 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 15:38:11 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kang, Kelvin"
	<kelvin.kang@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v5] i40e: fix: remove needless
 retries of NVM update
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v5] i40e: fix: remove needless
 retries of NVM update
Thread-Index: AQHaxzB++vp9I5g/kEaQr+5mCzWDg7Hb4fiAgBElbbA=
Date: Mon, 8 Jul 2024 15:38:11 +0000
Message-ID: <SJ0PR11MB5866CE95533821CC0D31282CE5DA2@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20240625184953.621684-1-aleksandr.loktionov@intel.com>
 <20240627173351.GH3104@kernel.org>
In-Reply-To: <20240627173351.GH3104@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|DM4PR11MB7206:EE_
x-ms-office365-filtering-correlation-id: fe14cb22-0dce-4fc2-b5b4-08dc9f63f939
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TXMECdjc2Tx5FbXLAkKD9zNSOZNE8Yx0EaKDwhEdNPFYX04Zz1WuY14E8SlF?=
 =?us-ascii?Q?9mA09ei3Cxn9fyf56fLxBuocFyRocRkK5gA7v2/q1VUJBFBYYQE0k+YG/Wgo?=
 =?us-ascii?Q?x7XTTuuNPcS3A5ayDJzPXSU3R0+fwu1qO7EQasPqwy10bmjQHv+14yhfmVvd?=
 =?us-ascii?Q?9sW5JO1nYPdbYHMM+M3V+/TFr8xxoI19zVsMPKmR/uGtw1idU1x1FopDOf2O?=
 =?us-ascii?Q?irAJmaAt0LslQtXacOcabTq6GSi1CNIvLE/ZQLnPC5d9/cf6enzjZQqmklvq?=
 =?us-ascii?Q?OUMX3EWU40qAiUVuyiFK0foDPp5s+ojGg8tx4Z76lDxYOPr4jXubabMhhtij?=
 =?us-ascii?Q?HOdXqJLBDimDSAreSKZZ8I883eU5AEFqiBmXf+kP/08kyuBC1/FxGjDrlUIX?=
 =?us-ascii?Q?Ud17Jl6n/wiNw1CY9vi7jBVfBEt6GuH8vPTBDTpxnG0b5YS2CP3KNlvbBbRu?=
 =?us-ascii?Q?rFTOXPDA/cmjYaC8Oe2OOX3q8egp83MVhjZgBOypR+JcpyskvCTC1rhN/sxf?=
 =?us-ascii?Q?lErWcvod1WMm/Z4k9L3MeFSSwtl0OQdyOXRh3ux2UcCcesZSzk97cSua/g6O?=
 =?us-ascii?Q?t8YErDUW2fvRQ5RiKPqVzhBEHFkZVNcQ/xgxDUrlLqXpXycfMMKBU+RcVRhp?=
 =?us-ascii?Q?NB31icF6tPDhMThglLLlrSchA/At/+cklHNZEt//e8TInKa7rW+oR3Os4hRI?=
 =?us-ascii?Q?t3HhChzdUsq7WEoXVjEwQLNT5ToE/iZfQovQ/6KpxZnXvpgtrl5cuRhuFOAk?=
 =?us-ascii?Q?a2+ghCsA8ugLefpjFgOakH5rvKnGU1dwTw13bh7b7QPViXwVRdcLWg2oGm4k?=
 =?us-ascii?Q?vccGFU1owa43Wgac8CVdKp1XymEewuA9/70vwBqpt6fqC4GinqPIO9Vc8zk5?=
 =?us-ascii?Q?KNtahhVKLoPryIuZR/o5xbwOo8HOwoyQ3TJU8CJAGeJwDxutTmJro+faSxU+?=
 =?us-ascii?Q?6lzYORNpWQBJqzq59QUaXR5ggr5TbQlsTFcyr3LMoRj8rcXi2D6mVfSZ81JQ?=
 =?us-ascii?Q?JWHuwikeQBY2pdwG5AtBpvDLxIvveasCWmFGEWAJ/nKBYaR4vqVLQjGbDWZ5?=
 =?us-ascii?Q?IDwFTv5dP7v6WxFhTLp4hFPdtYWaElsyCA79kyNdwf/21uj02bqp92dTFe03?=
 =?us-ascii?Q?e3dI22RJ6iMyWOngEZaGbTXX00PVKC1V9W17DVjsLckIExfF88+fETQqIu+R?=
 =?us-ascii?Q?eJLuC0eBdNLowPJOKgpb56j3QwSXrwMtgfcrOTA0uIdcKM8+4fmKjRTG/ZHi?=
 =?us-ascii?Q?P53NOG78gCmbwqeWkH2tL+1cW9vEfhugHWGYLvnw/+2O3lK+s9k66UyJjffz?=
 =?us-ascii?Q?I0kJmPhAv0BXINomtfE+CVCKK97kWVaM6xnwlLI7ACmjupLa5AsN+04r+Bi7?=
 =?us-ascii?Q?AypUEjY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ffygVMFJcRbM4mtX1Ql73h9Gt7Bw6NDVz+myePFVUYLumx9ryt9YKjaVbT6e?=
 =?us-ascii?Q?Jja+SeoqUGAt7SYbYrnLKC9Mthk1++9DYJxkfJfpYO3s/FCxYZcGSZpQQUIp?=
 =?us-ascii?Q?tnwSZgaXq0Lat6DzPhdpGM8aIzCAiHV1C2iH23ZRgt9QmI7nLuDT1dU4FcCo?=
 =?us-ascii?Q?5Ts54M+g5hja8F0JNKQxvxXOyLW5RDi+Rjcu4ECfYp3bnUo+ufA5kjg0nHYL?=
 =?us-ascii?Q?I70GiX2dzSE/O+2uak3Dmy3hJAyOWg1UfzJhwfdbcXKg/+kLEadXp+85ZBaI?=
 =?us-ascii?Q?F2n9F3RNDQetqIq68MmCjl8lG3yltgke810MfdFg1grxKVSBWeC8AGvKYPK0?=
 =?us-ascii?Q?yFoOpdA9MB3Ew+8J4xfL6gUMpzorzmQxCc+MJcppK3ftim51thzOauyd0A83?=
 =?us-ascii?Q?rQNB1/60fHlvaPI2fL/E5hKdUst0QPqNzXPg6gvJMJxXchWfK5C7S1DJ2TRT?=
 =?us-ascii?Q?4WYajj5REnBUC8OammHKGnoXKB2q5eqCmTcHLPINNV3OGkGQvp4zJKjSdLLQ?=
 =?us-ascii?Q?teiVtA86TiUjLXbPz8gYNhej+Ss6xHEps+Ky10exVBKx9B1rb8ZrLicIdqKw?=
 =?us-ascii?Q?kYN6aW0vYQ525zxWrDoDRxLFIP6fURrrKddYsqOPxu5No0h2KR9fKz+YBx7f?=
 =?us-ascii?Q?HhG8cHfKkeduPs+QLomcvU2LYqpm9SsULtvuijwmIQdVTIOEnhneG1I89VXB?=
 =?us-ascii?Q?cQnBW0WcissLLgBoEiev5MHN6daTdN96RDsixfBraHT52TicAKLOLKHiT+78?=
 =?us-ascii?Q?M5BTgpR89rk+0HrABMTPDf7vznVArOFIi1NIdEGFpkpIOTZ2FxA6r45iPKVh?=
 =?us-ascii?Q?99O+eXLo3V5G8+NeePc/El3EMz/SPpKDBvtjB451fWVpF3HMHsSdz9cYiE2B?=
 =?us-ascii?Q?jJ0m+1nNU03MaGrxt1u9Xjahn/wiT3JaZIe9WIm8fhbmURiYOC4LdPD6e3Ud?=
 =?us-ascii?Q?1gL6ipeFPTc64vw/QeojiHEAUMFd9oaY+g7aKLulbN29kMVVeP3pTp6f/Hca?=
 =?us-ascii?Q?y6op1TSJQlKXG/G0610TS3Y+qtAbOVlBd7ThaF+zj5MSHIhNqBAbuTxo8fpm?=
 =?us-ascii?Q?BeNClbedyRKiJQy65pXBKwXM9nRMCoD0B58ZLU33xTpO76Q2s3UohA5DkRbD?=
 =?us-ascii?Q?51AjeKKRbk8JZdnslCMTmhhh+ru0bof6daSqbQVQEA6dOV7fYD/uXpfM1p81?=
 =?us-ascii?Q?rcAwrJpRLyNnK+9MusWSEAaEj0dS1AR2CZV5U7lNV9ZDf688cPHX2kboDOhf?=
 =?us-ascii?Q?uswbnJjaH3lvJUQ4IZgTO0YTYNB5rhA/0JaOethd6B5n2BXFv60uIfaI7Dn4?=
 =?us-ascii?Q?K/Un7FbOXTArTtWgVlsTdugj/Gbr5THR5h/RYNvkLRd4o1Zo+cg9IJCUSLDw?=
 =?us-ascii?Q?iF4U/UBLB06cmkeJVzPQczHG/hHQcPJa53KqdHU6c08xhz+V75wg+GBxJW6i?=
 =?us-ascii?Q?MQvSwfDGyZ/s6ir/ehWJRyjySA4ZmEne1aVIJrskCIRQOug/Pw8aCK1jfgnP?=
 =?us-ascii?Q?zHhh/fAr549nPv6Umo/CzZLHEt7g05vVcB78mspQXTE+DYtX7NJa7aXo/1Ky?=
 =?us-ascii?Q?jf7iFhCSv66zCDB+Pjs6H10Zz33PmFpjuwQA8VpR8FH2+woWqOMQ1ugdBBG5?=
 =?us-ascii?Q?Hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe14cb22-0dce-4fc2-b5b4-08dc9f63f939
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 15:38:11.1024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfCgUOjTqfe0jYYNQTzP62UaPrby91nIfgM9X+mD6reACJ0hoYSSnuuwjAuFhXe3c+2jeJJ1ZRx2CnR+we4nqCeieG0SkpbANmngL9M028c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7206
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Simon Horman
> Sent: Thursday, June 27, 2024 7:34 PM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kang, Kelvin
> <kelvin.kang@intel.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net v5] i40e: fix: remove
> needless retries of NVM update
>=20
> On Tue, Jun 25, 2024 at 08:49:53PM +0200, Aleksandr Loktionov wrote:
> > Remove wrong EIO to EGAIN conversion and pass all errors as is.
> >
> > After commit 230f3d53a547 ("i40e: remove i40e_status"), which should
> > only replace F/W specific error codes with Linux kernel generic, all
> > EIO errors suddenly started to be converted into EAGAIN which leads
> > nvmupdate to retry until it timeouts and sometimes fails after more
> > than 20 minutes in the middle of NVM update, so NVM becomes
> corrupted.
> >
> > The bug affects users only at the time when they try to update NVM,
> > and only F/W versions that generate errors while nvmupdate. For
> > example, X710DA2 with 0x8000ECB7 F/W is affected, but there are
> probably more...
> >
> > Command for reproduction is just NVM update:
> >  ./nvmupdate64
> >
> > In the log instead of:
> >  i40e_nvmupd_exec_aq err I40E_ERR_ADMIN_QUEUE_ERROR aq_err
> > I40E_AQ_RC_ENOMEM)
> > appears:
> >  i40e_nvmupd_exec_aq err -EIO aq_err I40E_AQ_RC_ENOMEM
> >  i40e: eeprom check failed (-5), Tx/Rx traffic disabled
> >
> > The problematic code did silently convert EIO into EAGAIN which
> forced
> > nvmupdate to ignore EAGAIN error and retry the same operation until
> timeout.
> > That's why NVM update takes 20+ minutes to finish with the fail in
> the end.
> >
> > Fixes: 230f3d53a547 ("i40e: remove i40e_status")
> > Co-developed-by: Kelvin Kang <kelvin.kang@intel.com>
> > Signed-off-by: Kelvin Kang <kelvin.kang@intel.com>
> > Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>=20
> Hi Aleksandr,
>=20
> Maybe I'm reading things wrong, I have concerns :(
>=20
> Amongst other things, the cited commit:
> 1. Maps a number of different I40E_ERR_* values to -EIO; and 2. Maps
> checks on different I40E_ERR_* values to -EIO
>=20
> My concern is that the code may now incorrectly match against -EIO for
> cases where it would not have previously matched when more specific
> error codes.
>=20
> In the case at hand:
> 1. -EIO is returned in place of I40E_ERR_ADMIN_QUEUE_ERROR 2.
> i40e_aq_rc_to_posix checks for -EIO in place of
> I40E_ERR_ADMIN_QUEUE_TIMEOUT
>=20
> As you point out, we are now in a bad place.
> Which your patch addresses.
>=20
> But what about a different case where:
> 1. -EIO is returned in place of I40E_ERR_ADMIN_QUEUE_TIMEOUT 2.
> i40e_aq_rc_to_posix checks for -EIO in place of
> I40E_ERR_ADMIN_QUEUE_TIMEOUT
>=20
> In this scenario the, the code without your patch is correct, and with
> your patch it seems incorrect.
>=20
> Perhaps only the scenario you are fixing occurs.
> If so, all good. But it's not obvious to me that is the case.
>=20
> I'm likewise concerned by other conditions on -EIO introduced by the
> cited commit.

This commit do not introduce -EIO errors.
Before 230f3d53a547 ("i40e: remove i40e_status") some specific F/W error co=
des were
converted into -EAGAIN by i40e_aq_rc_to_posix(), but now all error codes ar=
e already
Linux kernel codes, so there is no way to distinguish special F/W codes and=
 convert
them into -EAGAIN.

Our validation has been tested regressions of current patch and gave signed=
 off.

Do you propose change=20
	if (aq_ret =3D=3D -EIO)
		return -EAGAIN;
into

	if (aq_ret =3D=3D -EIO)
		return -EIO;
?

It will require additional testing...

> > ---
> > v4->v5 commit message update
> > https://lore.kernel.org/netdev/20240618132111.3193963-1-
> aleksandr.lokt
> > ionov@intel.com/T/#u
> > v3->v4 commit message update
> > v2->v3 commit messege typos
> > v1->v2 commit message update
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_adminq.h | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> > b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> > index ee86d2c..55b5bb8 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> > @@ -109,10 +109,6 @@ static inline int i40e_aq_rc_to_posix(int
> aq_ret, int aq_rc)
> >  		-EFBIG,      /* I40E_AQ_RC_EFBIG */
> >  	};
> >
> > -	/* aq_rc is invalid if AQ timed out */
> > -	if (aq_ret =3D=3D -EIO)
> > -		return -EAGAIN;
> > -
>=20
> Perhaps it has already been covered, but with this change the aq_ret
> argument of this function is longer used.  It could be removed as a
> follow-up for iwl-next.
>=20
> >  	if (!((u32)aq_rc < (sizeof(aq_to_posix) /
> sizeof((aq_to_posix)[0]))))
> >  		return -ERANGE;
> >
> > --
> > 2.25.1
> >
> >

