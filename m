Return-Path: <netdev+bounces-209130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE49B0E6DB
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 01:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED567188ABF4
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 23:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BDA2192E1;
	Tue, 22 Jul 2025 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="k3q6i+KZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8C219DF62
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 23:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753225386; cv=fail; b=h8undp8reFCsT2raXOvWSq4vRRSYU5jkJSKvniqQdRHrUR/22GtcLqXFAlVpIVLg0ARLjdvUSArR1IRlJDTZJ+N+vvUTQDB0nGh0vFeCB8lAtfd3qvTzxSO9wa43SoXx+y5hNLAzQZm4gAmkthtSkPzryW30O7kMIynbZifZ8aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753225386; c=relaxed/simple;
	bh=mgZC6D7/YKdrPRjclAo5/6uiGZhZXdvC6IUeiyPXwOU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TCiM9dNC5V1PsIn63psTWckUtR9HM1hfQsBw3w0J6jZ0h5B4JqN1I/BVTQSuasr2UGoWddjsa7GM3tl1aDITkhJyw8yN244yeLuHhijTViGxhPe270PtNbg0uFWQZMGqK5+WAxa3DDDOFX9gRFeDJieDIYAxtaU9505a4GhxFu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=k3q6i+KZ; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 56MMcFnS003777
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 16:03:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=UpKONXQ80IFse679mgNEhFanItGPGyykPhzZ4oWe7zs=; b=k3q6i+KZmfwP
	UBjxC/Ykoq/GQlCYy7uaEmZKC3IVpFzLMMqvhcVOIv7vqzisGK5f3CiaoNX6e0fz
	tM17FGaiFrD6Qc0vZurLy5kcgY25pk24AyBOILXE4H3CGjHBXGs6673tHipYLo02
	EHDW3cj/kYOyc/PNfkNa8Sf48aGlO/O2sGZ3K3FWUZI6VfciUejcUATrp2MKndBu
	LtQ8UeCo23wBIlANsRRbKHMYLaQCAgQt+uxW3IJa9HiEuDSx4ONXHgtsUxZ1GOny
	tJRI8ehLNQBJ26ci6fP0jcXBGsJyzNFcl3f60Lif5VEXEinYsGpJk3KfkBoOpnL7
	/YrXD+EFbg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	by m0089730.ppops.net (PPS) with ESMTPS id 482ka808ew-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 16:03:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXMhOVakOphL/tyib807yPrEG/KF73gHi+YKqGZkIs8ClycXcy9eN9kN2g/PHcfOrLdtnfgDAy9D2UCd9doHxeP65qWCZqCzLVIeEH2/DCyazBoCK2SWwPt196XVfiosPqjd1F8j2CAhQYU2grfDp9wyq4az0YAa0a3iEej+zdDL3kk+FaieGSQuACu478WRP62/UR5OeD38LjvS/Dg4naXgFaqDMLN87pDgk//qOQHbTngqfWwigDldcBdAPye3JduHxhtrY7gLUxtJ3Ej5mMYZfqv8fNzz1o3/h07HtL+9hq1imUSIeHjsEsmb5tIYFvzBWBTVPwveC0JRjvBMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpKONXQ80IFse679mgNEhFanItGPGyykPhzZ4oWe7zs=;
 b=E3Ab0rr0n58MHMp5S5Q+2sc3zmfHU8l/MZxTnIZcBgqq5BUdImpbHK/7cyaKP53wYZyLystoETpflVUOxTXo6VlAqsapyuKX+eLQN8poxZfB+NfDahUcgGyMJotEFxybde/G1+52UfE37zxAOdnJFS6RvBjlio96824hmKvRwWuwrhJAa/3PzVGePkGe39AN4kEjb2iz5W9HxB9Lz9biSGe6JlKshVfsn0Lko690or065T37tTfMSN5Wf77ePZPbbVtiKOGUqsTNJoG552L9HcdG5JGxMNEnW1oTwoBuNUl0cd/ywyIa3Kn7cAiHPBCJYIpCAgKBJM+IQVP+HSvM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5639.namprd15.prod.outlook.com (2603:10b6:510:26d::13)
 by SA6PR15MB6690.namprd15.prod.outlook.com (2603:10b6:806:419::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 23:02:59 +0000
Received: from PH0PR15MB5639.namprd15.prod.outlook.com
 ([fe80::5816:7166:3cf1:9bef]) by PH0PR15MB5639.namprd15.prod.outlook.com
 ([fe80::5816:7166:3cf1:9bef%4]) with mapi id 15.20.8922.037; Tue, 22 Jul 2025
 23:02:58 +0000
From: Yonghong Song <yhs@meta.com>
To: Mahe Tardy <mahe.tardy@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>
Subject: Re: bpf: LLVM BTF inner map struct type def missing
Thread-Topic: bpf: LLVM BTF inner map struct type def missing
Thread-Index: AQHb+zi0uive0mZUK0ySNhzkudCt5LQ+wSEQ
Date: Tue, 22 Jul 2025 23:02:58 +0000
Message-ID:
 <PH0PR15MB5639C7853B00C613ACF18A74CA5CA@PH0PR15MB5639.namprd15.prod.outlook.com>
References: <aH_cGvgC20iD8qs9@gmail.com>
In-Reply-To: <aH_cGvgC20iD8qs9@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5639:EE_|SA6PR15MB6690:EE_
x-ms-office365-filtering-correlation-id: 29737f98-4b92-4042-471f-08ddc973e6ca
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?UBFQsdYURzObIoFdGxdO1EFWZCrjrj0P9CE8edbHQPWHyxXekFLQ5xOqUV?=
 =?iso-8859-1?Q?rAe46ma4ymqktR5Jtp73v9WoOpFqhf1NJppGO8tLeuKZXOM/oG5sl36SLz?=
 =?iso-8859-1?Q?g+t3EePzd80Gt0hkXv8sBCEhbLh3vw9EX6V6eDCLorTnOzD0efS5FV1ASN?=
 =?iso-8859-1?Q?fp/ONWSUGfR3J5ywK2vS71LYuRPUwUrJp+hUbqJYCH5VMCEg3f7ltdlTxx?=
 =?iso-8859-1?Q?IQqM8KIfA1bf3JDPB4ji3q9mQXlCOVBJng/baZwYZ5p7x0UsosAZaoqNvk?=
 =?iso-8859-1?Q?fvs7nyQaC0r3H2aiCb7n8jyZm3D7BRa0nyu/RXWtBgZwlLGYf9skYdw7gf?=
 =?iso-8859-1?Q?G3FmJm64rFtB43e0wtolfuZV3BIXSasDL+NYRQQSvRC4to4zHlqhqrtsmU?=
 =?iso-8859-1?Q?K2mdHtSpXKj3ilfX6t/Y6rqLnqd8f/qcyhoIY/GtPYfgiQ1RXflIMtSOBY?=
 =?iso-8859-1?Q?GpZdBOgITKgxe96LV5Z7A/n1kaG/qOAJfkFrIVu0n3YyT7LdPwntoGOvHq?=
 =?iso-8859-1?Q?nQ7i8QzqXnBCnQtBsLp2CFTi47/DE+NXebgKZN05EuMUxtm3hCWNGQU1L6?=
 =?iso-8859-1?Q?L0sufuJKyH6EqEEV87MZK+ZAqfzTWvl5cP3DGqK470ptr510clBfZT89gY?=
 =?iso-8859-1?Q?KmvFcC84HbCBOdzSylhLZJ1htd6lRk1vV/Edj3FKaxjsfoFC95kBtHiWOy?=
 =?iso-8859-1?Q?tPUcfm/wctK/yBH7GOGTt8hA8uI3WNGF3Dhp945fmGimAGVS2j4SGNo4sD?=
 =?iso-8859-1?Q?N2IH7ob0qDMfEpkVBtXeZ/hJplwts0gTrgywCQMTsQ3+944Z4qlrproOb1?=
 =?iso-8859-1?Q?vvGB3R3R/ZPI90AEEKYB4iEPHc+LCeIOPq9NrCKvD3KtJrC9iTtg5dASdI?=
 =?iso-8859-1?Q?DPwbQCrancd4g6enAn/v0OwORmZvpkZPLnAr3qeS91/yEpAmdVuv+3NgQX?=
 =?iso-8859-1?Q?7T16Uj6uwaslWq640u20u898V88k2hIDO0W25DGC7bGW+x3LjFOhdqUQ/H?=
 =?iso-8859-1?Q?/jspDY/YT+deh1mT8KTW1eBHkdsU6VfncBVUkBo3RX51k1mnATKQuf2e1s?=
 =?iso-8859-1?Q?H6BijN84B/sWIAV9ps/+rTk7HTh8m3ES3MJW+WouFWR93Kisv11XM8pvgX?=
 =?iso-8859-1?Q?ZCLkqmUPyxucbIXmxTbqhL/GnTY8jksluSw8itTZgrPjqY1b3frH2k42nz?=
 =?iso-8859-1?Q?zYBjmpqghDHrjIOCnZdVuLNxHK/0zGVDrnMSXAzQR40jcThY8FCwbZHyNC?=
 =?iso-8859-1?Q?FXibHNLcYpXtnfbZqAf0+DiUxlR9Vh7We16D8gdo0NyIHmBXdTGp6cBhKC?=
 =?iso-8859-1?Q?LGTQBJcAaXefjRXMgoecyu5cJm4wfXRiWiLHEUC5rNKc6JNNFM2EQAq3Gx?=
 =?iso-8859-1?Q?YkxJl33VAec1Ie4Eb8XnCUHFTg2B0jxQLcc0mEwjQxX7dQhxZ47X2jShM+?=
 =?iso-8859-1?Q?fkebSdgHEAtFqZ/Ps/19uXjNAQszi+mV1bAgJkJZ6OOdxc7RjXd1p3ch2+?=
 =?iso-8859-1?Q?SR4inUsOvwFZy5r9QCs8CGHxEPN74QvJqg3aNECPJhXPyGbL8ZonJQpuZ2?=
 =?iso-8859-1?Q?dA4+0Z0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5639.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?s+bO7P9Ap3yXzX1Ifc6wjPGK2Kj5WAtwKFXvYABCqCr2lqAQ6Giu0ZOfKD?=
 =?iso-8859-1?Q?4H3jVign1LDslAP2A8IMDaGqF1EvPVNrDGVlOL6X7GOvK5LxKpAlcr9RHK?=
 =?iso-8859-1?Q?aOqjsiheUne/ZzJRHMf7AVb/e5MzLrnJOthCETAiWKpv0cCihf9YfvVKaq?=
 =?iso-8859-1?Q?1yMhMnqOUj4G511LT0fKQ4cRolcyZf6hd06Hi4CEtIzIH4cOCBTmBB1bCo?=
 =?iso-8859-1?Q?4HHittCHKrD8njIX4Q8sYzIthDrcLhK9KRf5ClTMXU6HJBxWrVCKUY+fmG?=
 =?iso-8859-1?Q?fp/M5+nlaumAglTdNd7Q2htarG9xoqvv+D5cIpv7Z0TIHHgGukzIy1CsQ5?=
 =?iso-8859-1?Q?rl9b+GZtC8t5yshe5JCxVyFSxWTe9UZ4jLhJOPUzR/7hKKcX4cxPiaw9vm?=
 =?iso-8859-1?Q?jzKQjYkl7sqXa3G+EeXTXXzTU9zkQICr+f5oaZlvDLp5tUum03iO+4dJ/R?=
 =?iso-8859-1?Q?Uc2Zrnyq+IzGLE7IgH/FjucZby/k1mfwpwsHAarl+LfWU+f0xHPgAwgij8?=
 =?iso-8859-1?Q?QHr5W2P+J7n/tGg0GR8JHIyfBc3VViCF3/8ms3wVD0Zi7mOTYClCkcKvvb?=
 =?iso-8859-1?Q?sJ7Rf4U6Ju1tpCIoX5eGT5G1zlx0ME8VRMvw5KMD5OD8SY+yL/IG7UF3K8?=
 =?iso-8859-1?Q?jDA3LlYS8ceIyXLCsuBl1XG/QJRRwjVD0CJnDJGkXyJb2HDl0OKOSWYzTr?=
 =?iso-8859-1?Q?pZo1/lTvS1Nah/rjrfbh38BO7Pi47rY+gWvjHsKpv7VjvTGuhxH21Avxei?=
 =?iso-8859-1?Q?J0n07FID7P4ORn15/OczuoPJaMKkVaqqV/PtMReCLycYRF27jL9qdPSOm0?=
 =?iso-8859-1?Q?lDD8uqWnKn54Rp8D9C+BcsCO3P7LdgRqtvrpzJd08EvIsVXRbgh1s7Eb/d?=
 =?iso-8859-1?Q?Knh/YZ7PxseU9N1dFpD8zSAFBJxvv3blNLeFkCu6YSoFCuYoBiuBKAzBqr?=
 =?iso-8859-1?Q?YFNLq/k9EK8fw7l0h3v+hTBE+r9rlUrXGdm8aV83LT8PnSIYylbhX59J6o?=
 =?iso-8859-1?Q?NRpkf0Vpkf5ShHCAWaFyhIfmv+xg+qQwY1ulBdwzPoQTigksajuqOzj3CX?=
 =?iso-8859-1?Q?NtbOmPtggecH9xUFFYe8mb9hDeHLSGj7HPL7ykos9UVutxyPm5NDGc6C14?=
 =?iso-8859-1?Q?5LbcH/hlt9cDWGHF0d29hOIQDf2gC3tCpzZ45A9uIoOz+AP0lph/4zNfGl?=
 =?iso-8859-1?Q?4iKN4QlkHBcLqeDztQWFuv0lEHyAcda2iksZ2QgtLbmGrd363W9ccShZFH?=
 =?iso-8859-1?Q?LxX4FiSpcC7dg3pz15dAl6Lq66+O2hS0OgyJXnZmSGy3CBYSThTqmEVfDW?=
 =?iso-8859-1?Q?j3C51FpWLFVs3oz4F4Cexfb1l86tdqofaFWM8kGeXH2DUtBtdS1QxGemfL?=
 =?iso-8859-1?Q?LpP2LDWi2ppo0TPy71jQ9Ke8f9/byHVlO8o6miEP+/v8uTWP9qTDmuK5o3?=
 =?iso-8859-1?Q?ptTWCp1zEuZnEnDLwvqzCkULppjsuFJEFGUsw36o+TdVgMoIge5MX2d+HG?=
 =?iso-8859-1?Q?fC6u2XeNJt/nTw3baRSdpdfcToF4vBNBBVvbFrKxlD9tqAIfn/nF7RK8DY?=
 =?iso-8859-1?Q?OZsyx1xUIEDwzsSXeI6s99fpz8I7/wbSlovVF5D32oN5pAj4UuUjwEoHhG?=
 =?iso-8859-1?Q?+Qwh3V/QtENAw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 29737f98-4b92-4042-471f-08ddc973e6ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 23:02:58.6670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UAGDUG4OkEBw0IPNyVdSYzweUpsaxJ1ziVvI5AIPXRuHKawaCXjJeP59TmrKVISw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR15MB6690
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDIwMCBTYWx0ZWRfX2y9tnl6Yk1f6 0ewk2S1LgCtQmAdTHaZxVxvvhY7rreRVXLYI5cPkHwXK3JLNyPVSsfL5uNV2oq3BY6R/QBsQFuw G3kKV+xDVMnHxu5LL5rVxeIH+uc5E0MQhJVlhLro+1o3clVLzGW1UuFpDrD7jY9Gz492JqUUb/3
 1x8zeaGie/EuAQAD5yqRBO5HeU66e5zXoEeXFFGaTnl4bEK9MdD14ZHq1KGJ1IARPYacaUA296i hq16Y4QlJphaAHPEK7RoWLMfwbrunljsg79IeCI5IW2JTBl8GmdMin8kn7WbaFVxb2tFO7hkOt5 dGUbRx5ynOqiJDah78Bwk7JMQ9d4hQN3CrcgzDzdN3itf8qtY1kBcN+p5Xiq29X5fv3xYfHSKs6
 31tUpWy+DREFRLQ6XkZAQbuXvXfB6U++QFTPCUB9ia0uGsmcgXsJnMu+p4yaxGs7PEWdaRZv
X-Authority-Analysis: v=2.4 cv=Jdy8rVKV c=1 sm=1 tr=0 ts=688018a6 cx=c_pps a=BWGT1lWOJhsFjw9GfE3HWQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=Nsy__Q7LYHL7_XlC8WEA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: zshQfawJ2YcDlOosCl6oxncob68UAXrh
X-Proofpoint-GUID: zshQfawJ2YcDlOosCl6oxncob68UAXrh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_03,2025-07-22_01,2025-03-28_01

> Hello,=0A=
> =0A=
> While writing a BPF prog using map of maps I bumped into this compiler=0A=
> bug that GitHub user thediveo and Isovalent colleague Timo Beckers=0A=
> already discussed in the cilium/ebpf discussions [^1].=0A=
> =0A=
> The issue is that a struct only used in a inner map is not included in=0A=
> the program BTF, so it needs a dummy declaration elsewhere to work.=0A=
> =0A=
> For example such program:=0A=
> =0A=
>         #include "vmlinux.h"=0A=
>         #include <bpf/bpf_helpers.h>=0A=
> =0A=
>         struct missing_type {=0A=
>                 uint64_t foo;=0A=
>         };=0A=
> =0A=
>         // struct missing_type bar; // commented on purpose=0A=
> =0A=
>         struct {=0A=
>                 __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);=0A=
>                 __type(key, uint32_t);=0A=
>                 __type(value, uint32_t);=0A=
>                 __uint(max_entries, 16);=0A=
>                 __array(=0A=
>                         values, struct {=0A=
>                                 __uint(type, BPF_MAP_TYPE_HASH);=0A=
>                                 __type(key, uint64_t);=0A=
>                                 __type(value, struct missing_type);=0A=
>                                 __uint(max_entries, 32);=0A=
>                         });=0A=
>         } outer_map SEC(".maps");=0A=
> =0A=
> Then do:=0A=
> =0A=
>         bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.=
h=0A=
>         clang -target bpf -g -O2 -c prog.c -o prog.o=0A=
>         bpftool btf dump file prog.o=0A=
> =0A=
> Will result in:=0A=
> =0A=
>         [1] PTR '(anon)' type_id=3D3=0A=
>         [2] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSI=
GNED=0A=
>         [3] ARRAY '(anon)' type_id=3D2 index_type_id=3D4 nr_elems=3D12=0A=
>         [4] INT '__ARRAY_SIZE_TYPE__' size=3D4 bits_offset=3D0 nr_bits=3D=
32 encoding=3D(none)=0A=
>         [5] PTR '(anon)' type_id=3D6=0A=
>         [6] TYPEDEF 'uint32_t' type_id=3D7=0A=
>         [7] TYPEDEF 'u32' type_id=3D8=0A=
>         [8] TYPEDEF '__u32' type_id=3D9=0A=
>         [9] INT 'unsigned int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3D(none)=0A=
>         [10] PTR '(anon)' type_id=3D11=0A=
>         [11] ARRAY '(anon)' type_id=3D2 index_type_id=3D4 nr_elems=3D16=
=0A=
>         [12] PTR '(anon)' type_id=3D13=0A=
>         [13] STRUCT '(anon)' size=3D32 vlen=3D4=0A=
>                 'type' type_id=3D14 bits_offset=3D0=0A=
>                 'key' type_id=3D16 bits_offset=3D64=0A=
>                 'value' type_id=3D21 bits_offset=3D128=0A=
>                 'max_entries' type_id=3D22 bits_offset=3D192=0A=
>         [14] PTR '(anon)' type_id=3D15=0A=
>         [15] ARRAY '(anon)' type_id=3D2 index_type_id=3D4 nr_elems=3D1=0A=
>         [16] PTR '(anon)' type_id=3D17=0A=
>         [17] TYPEDEF 'uint64_t' type_id=3D18=0A=
>         [18] TYPEDEF 'u64' type_id=3D19=0A=
>         [19] TYPEDEF '__u64' type_id=3D20=0A=
>         [20] INT 'unsigned long long' size=3D8 bits_offset=3D0 nr_bits=3D=
64 encoding=3D(none)=0A=
>         [21] PTR '(anon)' type_id=3D28=0A=
>         [22] PTR '(anon)' type_id=3D23=0A=
>         [23] ARRAY '(anon)' type_id=3D2 index_type_id=3D4 nr_elems=3D32=
=0A=
>         [24] ARRAY '(anon)' type_id=3D12 index_type_id=3D4 nr_elems=3D0=
=0A=
>         [25] STRUCT '(anon)' size=3D32 vlen=3D5=0A=
>                 'type' type_id=3D1 bits_offset=3D0=0A=
>                 'key' type_id=3D5 bits_offset=3D64=0A=
>                 'value' type_id=3D5 bits_offset=3D128=0A=
>                 'max_entries' type_id=3D10 bits_offset=3D192=0A=
>                 'values' type_id=3D24 bits_offset=3D256=0A=
>         [26] VAR 'outer_map' type_id=3D25, linkage=3Dglobal=0A=
>         [27] DATASEC '.maps' size=3D0 vlen=3D1=0A=
>                 type_id=3D26 offset=3D0 size=3D32 (VAR 'outer_map')=0A=
>         [28] FWD 'missing_type' fwd_kind=3Dstruct=0A=
> =0A=
> You can see that the outer map is [25], with values [24] with type to=0A=
> [12] thus [13] and then the value of [13] is [21] which points to type=0A=
> [28]. And [28] is a forward declaration. Thus if we try to load this=0A=
> program (there's no program but the libbpf error msg is explicit):=0A=
> =0A=
>         bpftool prog load prog.o /sys/fs/bpf/prog=0A=
> =0A=
> Output is=0A=
> =0A=
>         libbpf: map 'outer_map.inner': can't determine value size for typ=
e [28]: -22.=0A=
> =0A=
> Now if you uncomment the commented line in the example (or use this type=
=0A=
> in a function as suggested by Timo), the BTF looks like this:=0A=
> =0A=
>         [1] PTR '(anon)' type_id=3D3=0A=
>         [2] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSI=
GNED=0A=
>         [3] ARRAY '(anon)' type_id=3D2 index_type_id=3D4 nr_elems=3D12=0A=
>         [4] INT '__ARRAY_SIZE_TYPE__' size=3D4 bits_offset=3D0 nr_bits=3D=
32 encoding=3D(none)=0A=
>         [5] PTR '(anon)' type_id=3D6=0A=
>         [6] TYPEDEF 'uint32_t' type_id=3D7=0A=
>         [7] TYPEDEF 'u32' type_id=3D8=0A=
>         [8] TYPEDEF '__u32' type_id=3D9=0A=
>         [9] INT 'unsigned int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3D(none)=0A=
>         [10] PTR '(anon)' type_id=3D11=0A=
>         [11] ARRAY '(anon)' type_id=3D2 index_type_id=3D4 nr_elems=3D16=
=0A=
>         [12] PTR '(anon)' type_id=3D13=0A=
>         [13] STRUCT '(anon)' size=3D32 vlen=3D4=0A=
>                 'type' type_id=3D14 bits_offset=3D0=0A=
>                 'key' type_id=3D16 bits_offset=3D64=0A=
>                 'value' type_id=3D21 bits_offset=3D128=0A=
>                 'max_entries' type_id=3D22 bits_offset=3D192=0A=
>         [14] PTR '(anon)' type_id=3D15=0A=
>         [15] ARRAY '(anon)' type_id=3D2 index_type_id=3D4 nr_elems=3D1=0A=
>         [16] PTR '(anon)' type_id=3D17=0A=
>         [17] TYPEDEF 'uint64_t' type_id=3D18=0A=
>         [18] TYPEDEF 'u64' type_id=3D19=0A=
>         [19] TYPEDEF '__u64' type_id=3D20=0A=
>         [20] INT 'unsigned long long' size=3D8 bits_offset=3D0 nr_bits=3D=
64 encoding=3D(none)=0A=
>         [21] PTR '(anon)' type_id=3D27=0A=
>         [22] PTR '(anon)' type_id=3D23=0A=
>         [23] ARRAY '(anon)' type_id=3D2 index_type_id=3D4 nr_elems=3D32=
=0A=
>         [24] ARRAY '(anon)' type_id=3D12 index_type_id=3D4 nr_elems=3D0=
=0A=
>         [25] STRUCT '(anon)' size=3D32 vlen=3D5=0A=
>                 'type' type_id=3D1 bits_offset=3D0=0A=
>                 'key' type_id=3D5 bits_offset=3D64=0A=
>                 'value' type_id=3D5 bits_offset=3D128=0A=
>                 'max_entries' type_id=3D10 bits_offset=3D192=0A=
>                 'values' type_id=3D24 bits_offset=3D256=0A=
>         [26] VAR 'outer_map' type_id=3D25, linkage=3Dglobal=0A=
>         [27] STRUCT 'missing_type' size=3D8 vlen=3D1=0A=
>                 'foo' type_id=3D17 bits_offset=3D0=0A=
>         [28] VAR 'bar' type_id=3D27, linkage=3Dglobal=0A=
>         [29] DATASEC '.bss' size=3D0 vlen=3D1=0A=
>                 type_id=3D28 offset=3D0 size=3D8 (VAR 'bar')=0A=
>         [30] DATASEC '.maps' size=3D0 vlen=3D1=0A=
>                 type_id=3D26 offset=3D0 size=3D32 (VAR 'outer_map')=0A=
> =0A=
> And then the type [27] exists, loading can now proceed.=0A=
> =0A=
> I tested it with latest LLVM-project head when writing this e789f8bdf369=
=0A=
> ("[libc][math] Add Generic Comparison Operations for floating point=0A=
> types (#144983)").=0A=
> =0A=
> If you think it's reasonable to fix, I would be interested looking into=
=0A=
> this.=0A=
=0A=
Looks like this may be something we want to fix as people starts or already=
 uses=0A=
nested maps. So yes, please go ahead to look into this.=0A=
=0A=
FYI, the llvm patch https://github.com/llvm/llvm-project/pull/141719/ tried=
 to solve=0A=
nested struct definition issue (similar to here). In that case, a type_tag =
is the=0A=
indicator which allows further type generation. The patch listed llvm sourc=
e=0A=
locations you likely need to touch.=0A=
=0A=
> =0A=
> [^1]: https://github.com/cilium/ebpf/discussions/1658#discussioncomment-1=
2491339=

