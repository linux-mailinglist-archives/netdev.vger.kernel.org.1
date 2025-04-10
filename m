Return-Path: <netdev+bounces-181363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A45A84AB3
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DB94C2538
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4301EFF8B;
	Thu, 10 Apr 2025 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="j1Thvna9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DB81D5CE8;
	Thu, 10 Apr 2025 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304852; cv=fail; b=Oc5Sep/exoQp1+mxsj6URJlBXIAIfPKDdDj/4UzRNWsrA7ldK9k3BAad18TSpxkkjcB7g5rqw9S93wFPB6KdaZzyyEwaQDcRnxBqvqBr6vn8OabSWLaHWA/XbkQtB3l/dKAVpZMcBjy3aJIKah3Y2LLebFnGJvNFz9HM/EuLnb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304852; c=relaxed/simple;
	bh=ygkwJhIj2RfmVv80ljx/3k3lxmZJZyLvFItZ3H013gE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WnfCSfEY9qOWVHfBSUwFFRhFwYOBVgF2oo25bLJlvWlInzMiQSRrb+UfAR9QctA5e7Egw+RqNMQlZ6PKUCnZwrhOSCIUBtzBHtjVVhiDvc0zapxaFiQ1IqMT79XX46T7DQVPayQBeo+npbFF6NP4JhsYxX2HLHh0KauUYTgDeE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=j1Thvna9; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONjQEWqiuUwCmCkqPiRund0GJ16FO6HCO4RkJliz44dAj/l/wzpZgDLmqxMI0YtYdUvyhrY/cxHvZyjWn2DwgtcAqvq20grkiXB+KwPgc9zd84LyMy6YEtBRaGazqQqkpCwDlhJ5fEfZczW0/pKbDK8cTXXMtlfCdhIetZDCUkiNyC4Cbp48Wxm9PdbUtNwjMOXkBTU7tqbeuvppQnkXqaQmW1dfmHPCl53er1HHrVTDsCUZrfmAbMS0lAWkhb1nCaToWRL5IjNVBps5oN30J7rVs2NdZcS5tFLy18fy6DQg/8GBkzDcnFS/8UtUFKlhXt6HSgpLVribLkm8IcviCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygkwJhIj2RfmVv80ljx/3k3lxmZJZyLvFItZ3H013gE=;
 b=VdxxfWXTvP1Dmr9N+IrzYI3yrXnnpkhi/32YYrRCdmk0kBv37HFACDNUax+FJSKVpvCq4is3tQMtBkfIOCC1McqZ+AVNcyiTO+6RyWyjQA0xWGj3mDy6gkKb/gJ7CDoPCL5oU3xJt4CDkH4nP0vmXqzSqeBjzmK5LOg2I7ADBGJj6L9o8dN7Ek0UhfCFFFS+Dyc6YlOolN65PYd/nLfcegxwAlLuDZsg/RK4oytxXsxMwsC5+EaittGKzuqSVmF376ds9Vu7qAsM/ULcBLk3h2h6A30oUcbjyXbGKO1WBCx5VShKi+1N9qqgp8Mniwj+1/EuuDj+5k0Up24yh1T3uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygkwJhIj2RfmVv80ljx/3k3lxmZJZyLvFItZ3H013gE=;
 b=j1Thvna9hmXiFkLPGv9fBBQOR9pypohtUp9JFSY1q/jCtwl7ifvIVYDavvBkddeKPB3gwZWQTjZcbVXxTiDkggbmiKefrXYjskt11Oi3KBMZbavwFiFc/aOwpCI75zpAbOvTRtm0s+6biMx0Bj6sTGP3VXKVwCwymOFCW9SJu9jvi+bgEW/aCedbwpjTzmOunJ2xPeVKfu8RhzLhAGFfyZJBlzlLMPdbXt4D00eCjmjkv0jPyO/RGQfoclOpYKNY3ybV9qVDV1MfWKj0RjPKqJLMQoa/ZbGzPZILxF1ilWJ0uAeEDB/BCBYG9xAesUEiFlgJHKH5GOmvWUoT6Kfs7A==
Received: from CY5PR11MB6462.namprd11.prod.outlook.com (2603:10b6:930:32::10)
 by IA0PR11MB7305.namprd11.prod.outlook.com (2603:10b6:208:439::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.25; Thu, 10 Apr
 2025 17:07:27 +0000
Received: from CY5PR11MB6462.namprd11.prod.outlook.com
 ([fe80::640:1ea2:fff1:a643]) by CY5PR11MB6462.namprd11.prod.outlook.com
 ([fe80::640:1ea2:fff1:a643%3]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 17:07:26 +0000
From: <Prathosh.Satish@microchip.com>
To: <ivecera@redhat.com>, <conor@kernel.org>
CC: <krzk@kernel.org>, <netdev@vger.kernel.org>, <vadim.fedorenko@linux.dev>,
	<arkadiusz.kubalewski@intel.com>, <jiri@resnulli.us>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <lee@kernel.org>,
	<kees@kernel.org>, <andy@kernel.org>, <akpm@linux-foundation.org>,
	<mschmidt@redhat.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH v2 02/14] dt-bindings: dpll: Add support for Microchip
 Azurite chip family
Thread-Topic: [PATCH v2 02/14] dt-bindings: dpll: Add support for Microchip
 Azurite chip family
Thread-Index: AQHbqV2+K5ewoIcBuU2czqcsXcly9bOce1aAgAALE4CAAFzYgIAABPuAgAA3ALA=
Date: Thu, 10 Apr 2025 17:07:26 +0000
Message-ID:
 <CY5PR11MB6462412A953AF5D93D97DCE5ECB72@CY5PR11MB6462.namprd11.prod.outlook.com>
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-3-ivecera@redhat.com>
 <20250410-skylark-of-silent-symmetry-afdec9@shite>
 <1a78fc71-fcf6-446e-9ada-c14420f9c5fe@redhat.com>
 <20250410-puritan-flatbed-00bf339297c0@spud>
 <6dc1fdac-81cc-4f2c-8d07-8f39b9605e04@redhat.com>
In-Reply-To: <6dc1fdac-81cc-4f2c-8d07-8f39b9605e04@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6462:EE_|IA0PR11MB7305:EE_
x-ms-office365-filtering-correlation-id: 6d182731-1917-4158-07bd-08dd78522b88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dllrNzlBd0NNb3J3b3J0aTErRnRtWSs2WDBMdlBVbCtFSVgwZWF6MFJSMDZ3?=
 =?utf-8?B?RFA4OXBjclRBTXhVcjdNSW94MCtLdjNLblp5cXpNaU5Jc0RMYmQyZzBKQW52?=
 =?utf-8?B?em03M0o4Nlp1ZTNsa2RPL2pBMHZBV1RWdlFLQlRDNi9aVFN6aFRHK3BUSThO?=
 =?utf-8?B?MEx1NG1nKzhySk5RZTgvallROUt1MXNPSjFqTzE5b1kvVmtDTWh3VFdnUkhr?=
 =?utf-8?B?K3JraHhaY2VzZHN4dkhtT1dvNi9STU4xOHBYZEtsMElwKzVHQkpzZjM2dExl?=
 =?utf-8?B?U1NaWm13cXdlNkthWHQrL1pRamlSSnQwTG5oenlyZWUrYmNOS29XTVo4b2pL?=
 =?utf-8?B?L0ZvTHN5dDhUTUViSTlhQS91V3pobTlVZjB1WTQyYkJuUHpZZTdLalh6RGpC?=
 =?utf-8?B?dnBZa1ZIMkFJQVVPRnBDMWJkWkkzTlpKMW5xY2RzSFBjOUFuVXpjc3pVelVH?=
 =?utf-8?B?bWNxUFFaU1hlb25sQSt3NEhaSzJyYkNnam02d0dOYU9PVWFvdFdoU3ltOUZz?=
 =?utf-8?B?NWhTdGxNTnhFQ0UxUDRBREhmNHdodS83K1BZTit5bS9xTThLZ0M1dlV3b1ha?=
 =?utf-8?B?aHZ2aGcrNnpKY2NIZlJoaFJKUjhRVGp6WFpaeGZFbk12SFdXWk1TKy9iTjZB?=
 =?utf-8?B?NzVicUZrNVozYmlVMjNBdkFBQ1lqMnFZR3pObmJMRnd2OXRHcFFJcDRCcFJR?=
 =?utf-8?B?emF2S1BvY2ZiL2t1VTQvME9KR2pPeVA5M1lWYm5hY3R2SUJXNGM4SDg0Zms2?=
 =?utf-8?B?bHkvZlZvRHhCNGJFRXJnVVFVQlN5MGVya1BtdUppQnVON3B6bThTSVVmd0Zp?=
 =?utf-8?B?Yk1FSWw5d1IzMk9mUG5KYW9oRThSSVdGa09VK3hlRVV1ZTIyWFN3bjJoWnlZ?=
 =?utf-8?B?N2lES3c1azRoVGFFWXUrUFIrNHQzRHFXSlZYTHIwS2dkN3ZrKzhmSEMzSHlJ?=
 =?utf-8?B?RDVIUm0vSGJyd1dBWjJFbUcwb3dxTmJGeHJwaWJ4RW1kV0trcTZ0ZGNYMHh5?=
 =?utf-8?B?QkRjOHFITjJrZHVBcnBpWGNEaDJHWUQ0eTd5S0hGTDJLK1B4elZyTXF1RXNC?=
 =?utf-8?B?UmhENG9lc1ZIdno5MU9Zc3V1c3lSZTJIS3ltR3d2YndSZjdDMkdsOVdLTHJY?=
 =?utf-8?B?bCtST3JiNndXcVRuNi8yUTgwUjFoakNLSnVoVGVPYUQ1aVhPTTQyWWFRRUtP?=
 =?utf-8?B?Q1lhMFZHeDd3VHE2Rk9ZMDYwYUxJbEltZ3ZBUm1YVGNOMlkwMWcyang3R21j?=
 =?utf-8?B?Qm50czg5M3RGbWZveWV0M2thU2w1V1kyRlhDUEdBSXZJQlozM1RtSitIUUlx?=
 =?utf-8?B?elQrdC9UNDlVbkR5SXpxbEMxSHJBeHhlbDdZTXREVTFFZHhtcDIzUVhJU20w?=
 =?utf-8?B?bC94dTlXMlhQajlUVmx0NkRFdHhLeXp5aDRteTA0dk4vaE1GK2xxb1MrSWtm?=
 =?utf-8?B?VkM5WWhXVUFGdFNlVXdtanpLMG54cHRibzJSOGh4cGFBeDZ5S2dFakJTV0lM?=
 =?utf-8?B?NmR6RTcwU0hnVG52NUE5YzkrOE9GZHcxNWhQYWVlc21aOG43aWoyZ3M1Z0x3?=
 =?utf-8?B?YXpIbjE0cEQxVWxRbmd2VWZoSWtRYTBoUEk5aHMzOWJsQVZ2S0t1dnJ5aEtx?=
 =?utf-8?B?NUJPbE5xTEV3TVcwZGxHYzF2Zm1tVHQyYTExZzQwNWRlMnFaZVRuSjNDQVcx?=
 =?utf-8?B?Ynl4VlVOek5vQVJDcW1KU3ZzNU02R3UyWitJRHY3UTNoVjkzZXBBc1dMTVJp?=
 =?utf-8?B?dU01Z05oWHR2RCs1QnlFZG5SVzVvOUY4U3NzV2dYSWFURDd1N2k2L2hTMk0z?=
 =?utf-8?B?cTNoQmtGank2cm1YYzdZSVFnOHdoVjlYTkZRYXBEZ1B1bWE0S2pTWEhmRHBC?=
 =?utf-8?B?WTZDR2o4MUp1aSszL1pDOG9LSXNMR0loM1lzNHprbXVWdHlrNm9vM0tPNnV4?=
 =?utf-8?Q?gx9T5DSKXKhkH5hnmViZf6o42eAJRkvh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6462.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUFGQVZZM201ZkZoRHFucW82Uk5GM0k3cGFZZlV5OFJ1NmMyLzlQMjJjNERj?=
 =?utf-8?B?aDdYU1BPYUJvWTg3Vk13K3JlZ2RwMnNUL09vbWxlbnM1N2didlRYQUswOVJB?=
 =?utf-8?B?Q0ZpK3lUdThxQTJUY0RrNWw5Nmtic0Y2emFuSEVtYXg3WmNuR3pIVmQ1NFRq?=
 =?utf-8?B?aDloRis4N2hvUTVRUVNIaGR6VWxwTkdxSy9KcUxNMlFOU3BCVklNMXFOV0Mx?=
 =?utf-8?B?OVBWRkJYNm96Vk51eE4wdVJnWVJKL3dGdyttaXpwbGZaMnkvRHM0UEpldU1G?=
 =?utf-8?B?clUwSG4ySkpXV2R3WEJxQlZuREpGMnR1bWJYMkJSdFEzNHdYajVUVGZpVWJK?=
 =?utf-8?B?WkQ2a21tNWkxSVpaMG5PUG1Nai9SbEloSWNWVmlhbFIzbHV1NFpaaUtRVnRR?=
 =?utf-8?B?ODlWM0tIbmxiSU1BblQ0b2h5ZFREZFBmL05YZm5aR2NXTFBzNExCNjdsa0I4?=
 =?utf-8?B?UmNNRU1sSkhJMTJRQ25xRzM2VHJGMHk0VTJPVU1Kb0ZnZmgyN3Z0SzNicUxv?=
 =?utf-8?B?ZEp6eHNsUkFaVTVxckJKS2FaNEpsakNHZnhwLzZFRkIydE5BWTJrRlg4Wll4?=
 =?utf-8?B?b1o2emNSdjRXUHptZFRhbCtRbnNIblNMZTI0a09SQVlNUUxTQ2t0T0dLRkNZ?=
 =?utf-8?B?cXprM0VuQkxCWVFUZTE1eGdzWm5RM2dIUGhUQ1VqaCtkc2JjMVdicjJvWjZq?=
 =?utf-8?B?aE1UUGkzRmJ3dXlwM3FKMFNjWWtyYStZWEhORkxkZ003c3ZCV0tjTThnb3ZG?=
 =?utf-8?B?dkJ4RHRoQ2xSSWlrTCtMbXRaMjQvRC9laXhqekdjTzBFZjQ1UEtteTBjaFpS?=
 =?utf-8?B?TkQrM0ZsdjE5cGZHS0MwVlRKdElnalFSWklGblJhN1JiVUVNaFlFdFhQVG1k?=
 =?utf-8?B?VjN5a2lSR2lrR1lLNHM1ZnQzQVk3QXkrZDNuVGNQRHljMmk2VTNBVC9ZMnRK?=
 =?utf-8?B?YjB1bldMazZvNVAxTTNncTdDMm5abUF4RkpLYkg1VUZrMTlLVkwxZVJEeGZM?=
 =?utf-8?B?N3Q4Ti9WeFR0K29CMDJ5M3NDUHhQVkhzLytMellOdTBhZFkzN1JzaEsxbjB2?=
 =?utf-8?B?MmFlRVpXVlNLcXI1cUd3alBDWnlOSTlWbWQ4eW82eDE1K2tZbEkyUC9kMjc5?=
 =?utf-8?B?QVErSXNQV2tKT1AzMHRVWWhaK0JFTUxkQnl6Nnd5bXhPNXlxTnpHc3VVMTVS?=
 =?utf-8?B?QUh1N2xPMVlYb1NHMlROaEpFRTFmZHBJNG5WMmZhRGc1UVN3Y1l4N1hiRi9T?=
 =?utf-8?B?c0oxTmxFV1dweDVpK29YYVhWckNmVEtmYzZHVFNicGprQ1VkMjgrdThlU3Zy?=
 =?utf-8?B?cVRkT0pja0JObDFRbWoxaXhyL1VIeUg5aERPcmNDem5JcEZZZHNEb3BwS0Zl?=
 =?utf-8?B?OEFiVGY1aDduLy85aG10a1dXK1JTWGo1bDJMNjUyOGlGWG9iUnF1L2UxZVFZ?=
 =?utf-8?B?V3Frck53bG1RazJHSU5BZ21JWmUvSVYzWVl0VWVEbDVyVXg4dHIzYzdYcHBE?=
 =?utf-8?B?bnc1QkcyWlJuUmR1cFRRNUZ0WVY1OUNmK3ZzQ3hLQXBVMDNSWDZVRUpva21x?=
 =?utf-8?B?VGtCRVNHanYwczNJMU05eEtpN2lFUGxBSVZLMWhRYktxU01VQ2wzcGtpcVUx?=
 =?utf-8?B?NHMyL3pUMnlFb2J1V1FnYjdmY28xaDdsVTJxNmF4MnFsYmNrSWVUMCt4a2Iz?=
 =?utf-8?B?SUxZOGdLaGxMWDF0SlJKZ3crRFJFREJyRXNIWFlMeEFobmtnclRQcjlua0Jy?=
 =?utf-8?B?SXdadFZRRDhZaUQxVTZrYi81RDBINTJOekRYdmppL0VQMmtxUThxSVVIWEd3?=
 =?utf-8?B?SkN0ZFlEOUVPMDBEOHBFR082ei8wb3VnUFZPSU51M1dpQXgzTHZnR3U2a1RT?=
 =?utf-8?B?Vk9xa2VJekhJYVJuMkVxNjgvMWVZUzB4aXRBS1BFTjVqd0czdjJncnBBM290?=
 =?utf-8?B?K0VnZExHdWF2T21KTElkVVNJeTUxS05McUJHa0NWRW9FLzJ2cTE4YXBtWHB4?=
 =?utf-8?B?RXJUc1h1YWxVV1NOclpYZytPYUpjUW1tbTJuSWdDU2JiL1hCRzhxTGI0MUFF?=
 =?utf-8?B?cEdJMWZoVTkySStpNW1nS3pYZGI0aWJMK1cxN3pJZUY3cHZBUmFtdEJYUHV0?=
 =?utf-8?B?OHI4WGx0TkI2dEtaUnV3aW0zNGJtQ0ZwSk1MNVpHVDk0RFF2YWhMdmdVQXBP?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6462.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d182731-1917-4158-07bd-08dd78522b88
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 17:07:26.8957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERfWFTC1RyL95A1dii7qIZhB+h0Thubm+kWyizBQTmoyiv/rxDi5B3opEJMtjieC/NFfNV4kZcwKntU+75Lzgi+3pw82/kyJRMIZJ+wOCL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7305

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEl2YW4gVmVjZXJhIDxpdmVjZXJhQHJl
ZGhhdC5jb20+IA0KU2VudDogVGh1cnNkYXkgMTAgQXByaWwgMjAyNSAxNDozNg0KVG86IENvbm9y
IERvb2xleSA8Y29ub3JAa2VybmVsLm9yZz47IFByYXRob3NoIFNhdGlzaCAtIE02NjA2NiA8UHJh
dGhvc2guU2F0aXNoQG1pY3JvY2hpcC5jb20+DQpDYzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6
a0BrZXJuZWwub3JnPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgVmFkaW0gRmVkb3JlbmtvIDx2
YWRpbS5mZWRvcmVua29AbGludXguZGV2PjsgQXJrYWRpdXN6IEt1YmFsZXdza2kgPGFya2FkaXVz
ei5rdWJhbGV3c2tpQGludGVsLmNvbT47IEppcmkgUGlya28gPGppcmlAcmVzbnVsbGkudXM+OyBS
b2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytk
dEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgUHJhdGhv
c2ggU2F0aXNoIC0gTTY2MDY2IDxQcmF0aG9zaC5TYXRpc2hAbWljcm9jaGlwLmNvbT47IExlZSBK
b25lcyA8bGVlQGtlcm5lbC5vcmc+OyBLZWVzIENvb2sgPGtlZXNAa2VybmVsLm9yZz47IEFuZHkg
U2hldmNoZW5rbyA8YW5keUBrZXJuZWwub3JnPjsgQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1m
b3VuZGF0aW9uLm9yZz47IE1pY2hhbCBTY2htaWR0IDxtc2NobWlkdEByZWRoYXQuY29tPjsgZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWhhcmRlbmluZ0B2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDIv
MTRdIGR0LWJpbmRpbmdzOiBkcGxsOiBBZGQgc3VwcG9ydCBmb3IgTWljcm9jaGlwIEF6dXJpdGUg
Y2hpcCBmYW1pbHkNCg0KRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQoNCk9uIDEw
LiAwNC4gMjUgMzoxOCBvZHAuLCBDb25vciBEb29sZXkgd3JvdGU6DQo+IE9uIFRodSwgQXByIDEw
LCAyMDI1IGF0IDA5OjQ1OjQ3QU0gKzAyMDAsIEl2YW4gVmVjZXJhIHdyb3RlOg0KPj4NCj4+DQo+
PiBPbiAxMC4gMDQuIDI1IDk6MDYgZG9wLiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+
PiBPbiBXZWQsIEFwciAwOSwgMjAyNSBhdCAwNDo0MjozOFBNIEdNVCwgSXZhbiBWZWNlcmEgd3Jv
dGU6DQo+Pj4+IEFkZCBEVCBiaW5kaW5ncyBmb3IgTWljcm9jaGlwIEF6dXJpdGUgRFBMTCBjaGlw
IGZhbWlseS4gVGhlc2UgY2hpcHMgDQo+Pj4+IHByb3ZpZGVzIDIgaW5kZXBlbmRlbnQgRFBMTCBj
aGFubmVscywgdXAgdG8gMTAgZGlmZmVyZW50aWFsIG9yIA0KPj4+PiBzaW5nbGUtZW5kZWQgaW5w
dXRzIGFuZCB1cCB0byAyMCBkaWZmZXJlbnRpYWwgb3IgMjAgc2luZ2xlLWVuZGVkIG91dHB1dHMu
DQo+Pj4+IEl0IGNhbiBiZSBjb25uZWN0ZWQgdmlhIEkyQyBvciBTUEkgYnVzc2VzLg0KPj4+Pg0K
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBJdmFuIFZlY2VyYSA8aXZlY2VyYUByZWRoYXQuY29tPg0KPj4+
PiAtLS0NCj4+Pj4gICAgLi4uL2JpbmRpbmdzL2RwbGwvbWljcm9jaGlwLHpsMzA3M3gtaTJjLnlh
bWwgIHwgNzQgKysrKysrKysrKysrKysrKysrDQo+Pj4+ICAgIC4uLi9iaW5kaW5ncy9kcGxsL21p
Y3JvY2hpcCx6bDMwNzN4LXNwaS55YW1sICB8IDc3IA0KPj4+PiArKysrKysrKysrKysrKysrKysr
DQo+Pj4NCj4+PiBObywgeW91IGRvIG5vdCBnZXQgdHdvIGZpbGVzLiBObyBzdWNoIGJpbmRpbmdz
IHdlcmUgYWNjZXB0ZWQgc2luY2UgDQo+Pj4gc29tZSB5ZWFycy4NCj4+Pg0KPj4+PiAgICAyIGZp
bGVzIGNoYW5nZWQsIDE1MSBpbnNlcnRpb25zKCspDQo+Pj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZHBsbC9taWNyb2NoaXAsemwzMDcz
eC1pMmMueWFtbA0KPj4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgDQo+Pj4+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9kcGxsL21pY3JvY2hpcCx6bDMwNzN4LXNwaS55YW1sDQo+
Pj4+DQo+Pj4+IGRpZmYgLS1naXQgDQo+Pj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2RwbGwvbWljcm9jaGlwLHpsMzA3M3gtaTJjLnlhbWwgDQo+Pj4+IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RwbGwvbWljcm9jaGlwLHpsMzA3M3gtaTJjLnlhbWwN
Cj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+Pj4gaW5kZXggMDAwMDAwMDAwMDAwMC4uZDky
ODA5ODhmOWViNw0KPj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kcGxsL21pY3JvY2hpcCx6bDMwNzN4LWkyYy4NCj4+Pj4gKysr
IHlhbWwNCj4+Pj4gQEAgLTAsMCArMSw3NCBAQA0KPj4+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4+Pj4gKy0tLQ0KPj4+
PiArJGlkOiANCj4+Pj4gK2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2RwbGwvbWljcm9j
aGlwLHpsMzA3M3gtaTJjLnlhbWwjDQo+Pj4+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5v
cmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4+Pj4gKw0KPj4+PiArdGl0bGU6IEkyQy1hdHRh
Y2hlZCBNaWNyb2NoaXAgQXp1cml0ZSBEUExMIGRldmljZQ0KPj4+PiArDQo+Pj4+ICttYWludGFp
bmVyczoNCj4+Pj4gKyAgLSBJdmFuIFZlY2VyYSA8aXZlY2VyYUByZWRoYXQuY29tPg0KPj4+PiAr
DQo+Pj4+ICtkZXNjcmlwdGlvbjoNCj4+Pj4gKyAgTWljcm9jaGlwIEF6dXJpdGUgRFBMTCAoWkwz
MDczeCkgaXMgYSBmYW1pbHkgb2YgRFBMTCBkZXZpY2VzIA0KPj4+PiArdGhhdA0KPj4+PiArICBw
cm92aWRlcyAyIGluZGVwZW5kZW50IERQTEwgY2hhbm5lbHMsIHVwIHRvIDEwIGRpZmZlcmVudGlh
bCBvcg0KPj4+PiArICBzaW5nbGUtZW5kZWQgaW5wdXRzIGFuZCB1cCB0byAyMCBkaWZmZXJlbnRp
YWwgb3IgMjAgc2luZ2xlLWVuZGVkIG91dHB1dHMuDQo+Pj4+ICsgIEl0IGNhbiBiZSBjb25uZWN0
ZWQgdmlhIG11bHRpcGxlIGJ1c3Nlcywgb25lIG9mIHRoZW0gYmVpbmcgSTJDLg0KPj4+PiArDQo+
Pj4+ICtwcm9wZXJ0aWVzOg0KPj4+PiArICBjb21wYXRpYmxlOg0KPj4+PiArICAgIGVudW06DQo+
Pj4+ICsgICAgICAtIG1pY3JvY2hpcCx6bDMwNzN4LWkyYw0KPj4+DQo+Pj4gSSBhbHJlYWR5IHNh
aWQ6IHlvdSBoYXZlIG9uZSBjb21wYXRpYmxlLCBub3QgdHdvLiBPbmUuDQo+Pg0KPj4gQWgsIHlv
dSBtZWFuIHNvbWV0aGluZyBsaWtlOg0KPj4gaWlvL2FjY2VsL2FkaSxhZHhsMzEzLnlhbWwNCj4+
DQo+PiBEbyB5b3U/DQo+Pg0KPj4+IEFsc28sIHN0aWxsIHdpbGRjYXJkLCBzbyBzdGlsbCBhIG5v
Lg0KPj4NCj4+IFRoaXMgaXMgbm90IHdpbGRjYXJkLCBNaWNyb2NoaXAgdXNlcyB0aGlzIHRvIGRl
c2lnbmF0ZSBEUExMIGRldmljZXMgDQo+PiB3aXRoIHRoZSBzYW1lIGNoYXJhY3RlcmlzdGljcy4N
Cj4NCj4gVGhhdCdzIHRoZSB2ZXJ5IGRlZmluaXRpb24gb2YgYSB3aWxkY2FyZCwgbm8/IFRoZSB4
IGlzIG1hdGNoaW5nIA0KPiBhZ2FpbnN0IHNldmVyYWwgZGlmZmVyZW50IGRldmljZXMuIFRoZXJl
J3MgbGlrZSAxNCBkaWZmZXJlbnQgcGFydHMgDQo+IG1hdGNoaW5nIHpsMzA3M3gsIHdpdGggdmFy
eWluZyBudW1iZXJzIG9mIG91dHB1dHMgYW5kIGNoYW5uZWxzLiBPbmUgDQo+IGNvbXBhdGlibGUg
Zm9yIGFsbCBvZiB0aGF0IGhhcmRseSBzZWVtcyBzdWl0YWJsZS4NCg0KUHJhdGhvc2gsIGNvdWxk
IHlvdSBwbGVhc2UgYnJpbmcgbW9yZSBsaWdodCBvbiB0aGlzPw0KDQo+IEp1c3QgdG8gY2xhcmlm
eSwgdGhlIG9yaWdpbmFsIGRyaXZlciB3YXMgd3JpdHRlbiBzcGVjaWZpY2FsbHkgd2l0aCAyLWNo
YW5uZWwgDQo+IGNoaXBzIGluIG1pbmQgKFpMMzA3MzIpIHdpdGggMTAgaW5wdXQgYW5kIDIwIG91
dHB1dHMsIHdoaWNoIGxlZCB0byBzb21lIGNvbmZ1c2lvbiBvZiB1c2luZyB6bDMwNzN4IGFzIGNv
bXBhdGlibGUuDQo+IEhvd2V2ZXIsIHRoZSBmaW5hbCB2ZXJzaW9uIG9mIHRoZSBkcml2ZXIgd2ls
bCBzdXBwb3J0IHRoZSBlbnRpcmUgWkwzMDczeCBmYW1pbHkgDQo+IFpMMzA3MzEgdG8gWkwzMDcz
NSBhbmQgc29tZSBzdWJzZXQgb2YgWkwzMDczMiBsaWtlIFpMODA3MzIgZXRjIA0KPiBlbnN1cmlu
ZyBjb21wYXRpYmlsaXR5IGFjcm9zcyBhbGwgdmFyaWFudHMuDQoNCg0KVGhhbmtzLg0KPg0KPj4N
Cj4+IEJ1dCBJIGNhbiB1c2UgbWljcm9jaGlwLGF6dXJpdGUsIGlzIGl0IG1vcmUgYXBwcm9wcmlh
dGU/DQo+DQo+IE5vLCBJIHRoaW5rIHRoYXQgaXMgd29yc2UgYWN0dWFsbHkuDQoNCg==

