Return-Path: <netdev+bounces-210156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E44CEB12316
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 19:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD83C18955B4
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 17:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3825D2EF9CB;
	Fri, 25 Jul 2025 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="PT0kj3WN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491222EF9BE
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753465241; cv=fail; b=AfAS1DtL/yIxA3GVdvrNKgzP5KZ+houOoGw4au0ESOQG/E/DjIViSgkUxVOG7YxPPm0ZERy8oRQj7zyO+2VVGrGRGp4kVR+yeMk8KfK17fzjxK+eNbzy7fYxU59s3WcAs462gMa9H8tsTcXjClS7junN4LPtm76k4qtrATDvwGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753465241; c=relaxed/simple;
	bh=FhR3qVrVQASWrdl8OgiTYX20900jKWMJW8Y3xbNWCs4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aWWDCBhBQUU0y2y3ZC0pzIHCiss7JvKRHSzcsd/JAWtlQHU5okFKkEUQAH/UNh2zxQJmMNNIhlSK478F8YRKVZUwgUvONp6lM2i7291Tymh0az7JL/ArKTZHK2Sxw9wd9okPu0roI+dQi0invsqBy7Mld/WhEL1lVGd1EBGT0Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=PT0kj3WN; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 56PHY881009624
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 10:40:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=FhR3qVrVQASWrdl8OgiTYX20900jKWMJW8Y3xbNWCs4=; b=PT0kj3WNRqiF
	pt1AA1EIpFk39ziPn2UNm7onvKBop5//gkLMiOjowjiegGh+GOlymcHwHmXdNL3f
	pdsBfwn1bswYQTkchG6LWDahrMZ7DLzWdZt9OSxBK1poUiPdCT0uwgHZYKX/Aouu
	fdGnGotWV3Z0/5+OZ/soF0SbZ/1sU3mqBVw4A7QN9KXxs8nV2wqPFujNelpqIrLX
	t0xAUkkDECF64XyeGT1NXTxCKmxwu/9gautmAwPKGNj5INGur3yRaQGddFCI3CRV
	DTBH6AtFBG9QqflsZVneAWfW2uekb+yIEGSDd94ujFQBhUDB+/vEiGZXndCEv+qE
	HqzatkLTOw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	by m0001303.ppops.net (PPS) with ESMTPS id 483w38ebph-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 10:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bULzHdATqG0Lgt9JjfhlEpnFGMoR/vcrKcebNzOMUa5NAoiHdUt9dbs8hautOcEZJ9Dg++JmGMxNpUd0tKNML2O6CnS74Ra2sUsmg/LHm9313BG0jweBHD5X3QISod1Jidug4hp46klEaef1lt/+wn7wWPjhqsGOalwMAOe4ugnbG0rp1etqRQJEF2bOQfM+ACZgBnqovCjGkhQpnAykblSy/Z9s7bX1TZxCgvFnO1sjZRoUWOqTZJ2JC/8jjqVDnrGKPp1AqIFs6AclM0a0vniFxQ12lADB42ZjpsVa9KIyNgyGbDdiOKozQV4PuoykSwKnrNRBESu6bdZPStdbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhR3qVrVQASWrdl8OgiTYX20900jKWMJW8Y3xbNWCs4=;
 b=PHXkq3X3aXhPp/HQUCQzjFIBHMLiarb+lBb7B5J4qj0uJ2+3j1q6WUkF2mPnk5EHcRSe2WnvPuEijivcPSW1h+9OSkwQOxA/aj65NXEA3BLw9tM3VmA90V7m0baB0annO0UrgncH9VYzwgs+ouJNhvU8plk5u7va/24dOim94709l5c62DbheSHKwvENcY0pQskjktuzzn7frEfeKMOnvDV0Nv+x1OhFJ94F3byCwoxRooeA6cvM0euzRXDj7V7RcedKt9JquZupiQFZhdOTVs717jlCPEmyvgpINV7nSeoAsSuYfiThSvWIj9UrwRhl1AvySGYqOXX5vvB/gvBNZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5639.namprd15.prod.outlook.com (2603:10b6:510:26d::13)
 by DS0PR15MB5721.namprd15.prod.outlook.com (2603:10b6:8:143::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 17:40:34 +0000
Received: from PH0PR15MB5639.namprd15.prod.outlook.com
 ([fe80::5816:7166:3cf1:9bef]) by PH0PR15MB5639.namprd15.prod.outlook.com
 ([fe80::5816:7166:3cf1:9bef%4]) with mapi id 15.20.8922.037; Fri, 25 Jul 2025
 17:40:34 +0000
From: Yonghong Song <yhs@meta.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: bpf: LLVM BTF inner map struct type def missing
Thread-Topic: bpf: LLVM BTF inner map struct type def missing
Thread-Index: AQHb+zi0uive0mZUK0ySNhzkudCt5LQ+wSEQgAP9PYCAAGCBdg==
Date: Fri, 25 Jul 2025 17:40:34 +0000
Message-ID:
 <PH0PR15MB56391FD0639B8A5AF5FE2443CA59A@PH0PR15MB5639.namprd15.prod.outlook.com>
References: <aH_cGvgC20iD8qs9@gmail.com>
 <PH0PR15MB5639C7853B00C613ACF18A74CA5CA@PH0PR15MB5639.namprd15.prod.outlook.com>
 <aINvq2iqUJkNBvZT@gmail.com>
In-Reply-To: <aINvq2iqUJkNBvZT@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5639:EE_|DS0PR15MB5721:EE_
x-ms-office365-filtering-correlation-id: 3d3a4e12-6de7-4d34-a3a0-08ddcba25c0b
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?stEQtBXGOuS/QQHciXdGs9L7mo1RhSswxmDcPQy3gqATGZQpwm2918fzGn?=
 =?iso-8859-1?Q?aA+uslVJNuF9FcNiW/B7biEU++ghf9XI4P60vxSuBE7pVVAf/V43ZPH+3X?=
 =?iso-8859-1?Q?UfH9cuyGbnmHnmc2VSqtfCgTjI+RAMMFHO2SfSInjgYLmmn8a2OgK6tXxH?=
 =?iso-8859-1?Q?5gADiWfMv+9Od277h7xibKeOnE4pJis/7pOYmnZ+OmDONu5AKmNaS6iTex?=
 =?iso-8859-1?Q?l+JsZpGmRRaZ6NRahT9/PMse8pYvl1ynsOGBYUVyWVPDG0vizbWCUsnTMk?=
 =?iso-8859-1?Q?SbxLDkS5K1K6eFfgbcoGEbrkIlNNZcRzYTSLgvsYkFC7nNbyl4/SXq/hp3?=
 =?iso-8859-1?Q?OOL/2K7DGVBlT9JrDfzAIYIJbqmSQmBGqLe6Hiq5fXbyqHM7PlxWtVeKgH?=
 =?iso-8859-1?Q?HOwOz/64swMexaOw6ix+CjDmXFrOu2EpCw4gjzbQ6hRJyzA52Zq2/03/IM?=
 =?iso-8859-1?Q?QksyAhUEi1J7jq8hsGXBLCmrMMExdZdX7qptTrKxqFxGSCxsSjZDwwbfse?=
 =?iso-8859-1?Q?FEALYUbt8sny2v8cNFpkSpiAjSAWnPrTvLB9KTcBCfoJV1u91OuNiVJaot?=
 =?iso-8859-1?Q?wHXD2qeybZ23Gmh3/OoIewBh0VczUJSRB/fGdCLkgTmDUQaHNSo3M/w+fL?=
 =?iso-8859-1?Q?+ccxjnpdF2ylN/LQhFDrTCmt/6e+gWGHdTmdcM3o6kEdfnAGPoHpeZWNF9?=
 =?iso-8859-1?Q?xbV+QXmGle7I3UDLA5TVlLwU19g4M9b/hR53o0g9f0KQOTIC6bIzI2071S?=
 =?iso-8859-1?Q?OQzrv0a45BqnT9AzttE01O1LGFqMObK/4AvAMYKYslT7gZIrXhPgFLb7Is?=
 =?iso-8859-1?Q?rmRSWH9gA54Qeyy1ExNLm6MLO0cJn0dfeC7rQ7bZoRmZHzjlSus6Zh8qUC?=
 =?iso-8859-1?Q?DGD1TXeZt+A95dtMaDTk0Jwc02KVcjGeFaOCRXCsU+juDFkWcFVQo7LkPY?=
 =?iso-8859-1?Q?kaaCjBwccWbukXy1rL+0O2LBIVXmn+kXEGH7pHoxz/ZqTKs0pz0CHRWsk5?=
 =?iso-8859-1?Q?SdOumpLmnfGMMdQk6v0mcx2h1oQbX3zKn76gS3WpoHufynz+jcAWLw70Ge?=
 =?iso-8859-1?Q?HUcykmc64hIMkn4FgDcuy5W2qfem+2fDCvibQznucdiAVA4+LEXpyFuxGf?=
 =?iso-8859-1?Q?5+bqManJypddZpqO9+88fh5EKh0YTpCQVzvebJWzKYnEIy/YmNDIzZsWcI?=
 =?iso-8859-1?Q?egkwATIvV4MQQ48ucne3+mD3MxpZXUJ74qRJYelN7sJv3ZHqy3qkjct03w?=
 =?iso-8859-1?Q?q7UO4IGxChx8MH6e6q5UIVPvJgHBQoR3frT1c81CdGEZfUCJtj+rp8mhIx?=
 =?iso-8859-1?Q?EQHfCa1O+8IqfOzEdjchU/TGK7I5ZzG4TwmjIFJ1+dQB+XFkaheWF8KUCB?=
 =?iso-8859-1?Q?KcLvNbifa5Zk7tJrCuNPZoEVg404R9YcCnezlgHSpcV44jcy9HY/HNnGYI?=
 =?iso-8859-1?Q?U2ELnmBi11v8GSDTQDbl6ekGC92WLDT227RC3TieGVElBkBvG6pLOZS1rM?=
 =?iso-8859-1?Q?x4iyR2D2X1F8NMeBOL1CeonbeekLJYx51GEvCs6UvFXxdXYjRtGJonNKv7?=
 =?iso-8859-1?Q?o25RVZQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5639.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1F9vIdh0gvOQFu3X5S/dmzM7zQByRSurEbccbMe2IwwWz4zj0DsfqcLATX?=
 =?iso-8859-1?Q?71CM5zfujTwPLjMNUZlSoq9nudKI4toPrPpMypGNuSA/0pqfoPAI49SLzy?=
 =?iso-8859-1?Q?qLeVjhby0zOvjfWOrHC2sZENjwhmC7RkB8MsxmTqqdzMqjgka+WtUhSCHN?=
 =?iso-8859-1?Q?tbd1nj2ZglkqCUuDvBEsQgazglPSll/0fn1CtJvT/WebQDUWybiVzfSp2M?=
 =?iso-8859-1?Q?TdqO1iJlqk6SBlYh1ap0A/3X6RjIeATlhT4injN3SlRAikC0bP4LbHv9vG?=
 =?iso-8859-1?Q?KTIYWHivEKaJwDD7YqwJ0KJYtkOzagmvTlBOfs8t4Py8pTgF8hw+KsuVs9?=
 =?iso-8859-1?Q?jAYmAx9Iad+8zu0pHiua5FYrBIFNeJwlOuw7NlXWwdeUbOlLigNXZg1bq8?=
 =?iso-8859-1?Q?ASSf2tzGr+vVSeBawF1qCwWxOfaXvDe944Um/PWF4b7/ubPu/Yn2NH2lZV?=
 =?iso-8859-1?Q?3TpDLl8l4ky281CXufVIpJmz4Sf9sY/qZJTLtNQ2XxO75Qpu9Bg0Wa7rSI?=
 =?iso-8859-1?Q?19X3Fsf4jQcHq+NS59jg/juzqpVyIqEydOJ+tlZAE192xyQfV7XZvFY1u9?=
 =?iso-8859-1?Q?BRpxZpab922ThGHrFXHm0grM5+7lo9FIWFMqApeisKCZ5nfzZ0F2qwKoiP?=
 =?iso-8859-1?Q?kxYnrsMRST1wTryTqkNyYxST9syJ6Y7L8gPiIeZZ0qJmWKz3KJTu3zPYux?=
 =?iso-8859-1?Q?hW41YWuoNQKTuuIM6qQPigShwHzI5u0JJbAsKWdcmSO7wGT/lo9a9u+t13?=
 =?iso-8859-1?Q?E9kwD8slA4KtFJtXkut1Y0TfxNPuIkBdY7SVMBMGRr+OzUmuyBhDbCSYUu?=
 =?iso-8859-1?Q?zjYwP+HPuThGoEY6MloPMXZikrmHspWTZgb81GcUaI5HOayw6GhwRDzdCT?=
 =?iso-8859-1?Q?4MAlFrvYPL/eBzpdIlrNtes9lAuXtBCkbv9qLMw8lbNQrfbNp2ihqi1TiC?=
 =?iso-8859-1?Q?eUCkPWaLhH7yRHgZZYkZLFzGyone+lYzXaskB6pziQoO+SAvBoNEGI70Dc?=
 =?iso-8859-1?Q?IN4cm2mXaSbdAFoeBJXwYZSt5DGWZ7IbNdcg7ZvqCeuEwABnZSw7MuNd0h?=
 =?iso-8859-1?Q?2h/GqTitS1qrqR/wgj92reuI/UUTHy86YxaVhBhoAmXU/AgGkKdJZ3EQQl?=
 =?iso-8859-1?Q?LLRGFT0vskIh9NWDVNgJLWStxgvL4jWYh4/IS/N6JTB7LNejd5dBTFaS4m?=
 =?iso-8859-1?Q?AkTYNhfkXJ9WyZBWLKmZ+gyZOH8F7LlAI/ulvonkaQ0t0ZBY0rxTXGyJjc?=
 =?iso-8859-1?Q?pyZOaa6yrN3kDAhbaJqZlVDD8NovdQExjeJ36njiZFbtFng+n4R42qR61c?=
 =?iso-8859-1?Q?Ex04S11TdnG/uAdggaVsU6BSATELzWQjuug+RPQBHWSRvVrRlqLICyDPur?=
 =?iso-8859-1?Q?MQ1yKZ8eKGvEzYkk0M+JklVN+dEI79M/0gL8mErYyIol+wl1HibGlj0FYr?=
 =?iso-8859-1?Q?AcEcaeeNcgqEJGLS3t+YIco5iN/vcqqYL01VzhhBsjQc+XJOpF+34l3N/8?=
 =?iso-8859-1?Q?+HqcnbdfxFyZIprLBogZFUlHLafRBxHbQqSG4DbqR14whkfoeVnqunbrsT?=
 =?iso-8859-1?Q?0J8l4NWRlcsdH7hhz/w4UQvDdeHh8fFqeP9Ky2agPX5yBTTq/mRwqpwqbm?=
 =?iso-8859-1?Q?uxFhX3ToSuD3s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5639.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3a4e12-6de7-4d34-a3a0-08ddcba25c0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 17:40:34.5508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LhxK8j+Irtl/Hxbz/2oGA3fSTMSAzsD6AsO5XaC4uv+3orj8LHXUI01qgUYF9u71
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5721
X-Authority-Analysis: v=2.4 cv=cuSbk04i c=1 sm=1 tr=0 ts=6883c195 cx=c_pps a=r8UwVJtIK7zdXlSThGy1hg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=MC50xvvA-HtHebqCwnQA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: h-nT4iiI_8otAeq53XfHeWfNuUTEQGQE
X-Proofpoint-GUID: h-nT4iiI_8otAeq53XfHeWfNuUTEQGQE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE1MSBTYWx0ZWRfX4yN7f+VsmmkQ AoKfi9NqOJOmSUSNf7aBT64tquPmlrNKqfp+WDYzZsrIrH+0AJMWhVhUJ9cs3er5kBwFxJP38O9 BcHsqsXNYPBp5Gr9BeN+Lhf9OFkC0Qu/uqxwGUpvQb310oHssmdB8BN0QZXHkXLPkBsyTpg8yoW
 h7wQOg4RnWBGj3xWqboZsAVmooeWSw2NF94yPIyC11B7DufaTrcKUFKyVaXEVe25Law9g7Zpph9 qtiSWAszjsjxBmfe5gyUS/LrkTicuRa8Yyy8ylmrv8vfimU1QlbWAgr9J6jCF4IdpEhhYM3RpsV lKJLBDaAO8VjeqdKFmV/VsUuaCZ5PyXEbeQQ7goikjLZ4V4/1uLYSYEvJXbl4EXf8h2JtUTkiyz
 q34y18abCZHZX2Kw6dPS9TtBudY9XrD4tYCb6abrN3M9L/mFrP6F0kjrkNOs4WdLympnFr8V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_05,2025-07-24_01,2025-03-28_01

>> ________________________________________=0A=
>> From: Mahe Tardy <mahe.tardy@gmail.com>=0A=
>> Sent: Friday, July 25, 2025 4:51 AM=0A=
>> To: Yonghong Song=0A=
>> Cc: netdev@vger.kernel.org; Alexei Starovoitov; Daniel Borkmann=0A=
>> Subject: Re: bpf: LLVM BTF inner map struct type def missing=0A=
>> =0A=
>> On Tue, Jul 22, 2025 at 11:02:58PM +0000, Yonghong Song wrote:=0A=
>> > > If you think it's reasonable to fix, I would be interested looking i=
nto=0A=
>> > > this.=0A=
>> >=0A=
>> > Looks like this may be something we want to fix as people starts or al=
ready uses=0A=
>> > nested maps. So yes, please go ahead to look into this.=0A=
>> =0A=
>> Here is my proposal patch https://github.com/llvm/llvm-project/pull/1506=
08 .=0A=
>> The idea is to visit inner maps as we visit the global maps during BTF=
=0A=
>> generation. Unfortunately, for that, I had to add a boolean arg to some=
=0A=
>> functions, I hope it's okay.=0A=
=0A=
Sure. Will take a look. Thanks!=0A=
=0A=
>> =0A=
>> >=0A=
>> > FYI, the llvm patch https://github.com/llvm/llvm-project/pull/141719/ =
 tried to solve=0A=
>> > nested struct definition issue (similar to here). In that case, a type=
_tag is the=0A=
>> > indicator which allows further type generation. The patch listed llvm =
source=0A=
>> > locations you likely need to touch.=0A=
>> =0A=
>> Thank you, it was very useful to have this pointer!=0A=
>> =0A=
>> >=0A=
>> > >=0A=
>> > > [^1]: https://github.com/cilium/ebpf/discussions/1658#discussioncomm=
ent-12491339=

