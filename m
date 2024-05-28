Return-Path: <netdev+bounces-98410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5880A8D1535
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 09:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDEB284A8A
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 07:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860414F201;
	Tue, 28 May 2024 07:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="uscm/UWL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C097673518;
	Tue, 28 May 2024 07:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880724; cv=fail; b=CY81sFR1nlhZX9asD/6sDob6FgSUyvjpAXuvQINt/KXrpJpQilNUlPI3KgQRwno2TxomNwFi7YRkqQyzqbudMu8+8urTOdq2PDlCiVfvVah/CZ5mqmqCcaTVCZHDMO0DUHMcXCxM0hBu+LkjaWYP22tHnk2FPMpcIoL2LggWH4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880724; c=relaxed/simple;
	bh=5wUgL6cFlz98sZuKQdvaiO5+iQ7JC2X21Fqct7b4sqY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OH0hMWeHpiXaKh3TI2M+LxAOrz3S581plo6IET9Bh51hbzyEkKbWfrp/cN93SavcJiXooEThu9vqSjTSk4cjAshhCUjRZrfoURuh5TQT8ulN4Cpr6DwGfaDqa4dMVge4fzSEuC9oFRycrTnhxdt0tdAFby/rCO0UcoqU+Bji35U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=uscm/UWL; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RMp075020110;
	Tue, 28 May 2024 00:18:11 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ycqpyksps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 00:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgXCqMhKKzpJ6iV6CgiQudS67NajeTFam5xslMUEpadyTJ1+7k66LCIhdA05dbVpEZvrFOO8anPnrbU9JL0nDyvQjPPVUjEI6rZ4/jtKepuxU4evEkRLB3yEQaGaUjQV+MnPUG8so7bMz7Z9T7kHiyS63/baxNp46hcJrlH3NQVKYrsKFV1QeFG2fdT5o5TwiPZH35r63yPomRjKSOAQPaDZSqnKqSY0znHr5XD+T3it1bow1CNHxiiFQy9P/7fM3Jo3AsityctDiy5UweuTpQVv7PPy325rOS/Fu7Q8YS+37DzS+F4aHVXQ23MPuTTlOO92oHsuw7hiqndvG0j5tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IFIe1WujGY+saCq1uU6K/kgmR8oT7Xeqxwbi+ToAu4=;
 b=jMAvwsnDWoEmpf9IvVqliXxVGy0LJzTdCXzFNCsszxdBqHNAVPzJVjv7f7u66cJ04ITFw6iUsr+YByAfXcCVOmERnNL+m//ZgGGofGfrXxdrYHHEY1UD597+xBa8fXtiJibHuLTGDDjjAWl86ya0NzeEOYeIDuFOFRGxS9YQGKL7LGrv7+A1IjqN8vM5XldA1qOE/PjfkPwYMyTN+jBBgfaDgeNesiwREubNWDPXhLA5CXuHyG04ZstYi+K4F7im3GI7n7IEjz+KPiBTdgygPKo7yjw0K98sJ6NA+FXJoCip8NCQ3rlDs0CU5UbvS5V7N9avR5/8glOSZF65WRNI2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IFIe1WujGY+saCq1uU6K/kgmR8oT7Xeqxwbi+ToAu4=;
 b=uscm/UWLxj0EQtVwPfflBDQ4yvQsjQtnjBmfmHdXaqK6dIQ4JlMfwPLUul1SgNwBkuIjua3h5MBrkDkYQYtsfWySLMLabqT+EfDQeMdeVgpfgXPXsSlnQXw1rj+0RzpXe1lgE9nkYjj+HSfldiUth+UUzg4/V6IHMg7ezE1gFes=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by PH0PR18MB4638.namprd18.prod.outlook.com (2603:10b6:510:c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 07:18:06 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e%5]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 07:18:05 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: "Ng, Boon Khai" <boon.khai.ng@intel.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S .
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Ang, Tien Sung" <tien.sung.ang@intel.com>,
        "G Thomas, Rohan" <rohan.g.thomas@intel.com>,
        "Looi, Hong Aun"
	<hong.aun.looi@intel.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>
Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Topic: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Index: AQHasM8vgdcpkr+/v02rKvlCUvXI1A==
Date: Tue, 28 May 2024 07:18:05 +0000
Message-ID: 
 <BY3PR18MB4737D071F3F747B6ECB15BF2C6F12@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240527093339.30883-1-boon.khai.ng@intel.com>
 <20240527093339.30883-2-boon.khai.ng@intel.com>
 <BY3PR18MB47372537A64134BCE2A4F589C6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
 <DM8PR11MB5751CE01703FFF7CB62DAF9BC1F02@DM8PR11MB5751.namprd11.prod.outlook.com>
 <BY3PR18MB4737DAE0AD482B9660676F6BC6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
 <DM8PR11MB5751118297FB966DA95F55DFC1F12@DM8PR11MB5751.namprd11.prod.outlook.com>
In-Reply-To: 
 <DM8PR11MB5751118297FB966DA95F55DFC1F12@DM8PR11MB5751.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|PH0PR18MB4638:EE_
x-ms-office365-filtering-correlation-id: 51dc25cf-8629-4d1f-5893-08dc7ee651c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009|921011;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?NFfFkYt/BRBVQAZ1D0Rh5Rvq2+3CHcaMwU9rTDJofW9UML8psEgXcR5MnpFl?=
 =?us-ascii?Q?cpwopEqGogqCtKMH7gJaTJJNmvcNC/cgs5sokV+f9ff05t0sZIc/TznR9yzz?=
 =?us-ascii?Q?kGluK5iVPLenhVyghWjqaYzd9is1Rl6oMqmw0hj3aswJfpf2XIm5cARosf4m?=
 =?us-ascii?Q?OnOC08uhb4pPbQE/dpm06JuO0KIcmKqG5VIkXbEZe3/4fizb0gB43Av+zE8w?=
 =?us-ascii?Q?vStbj45wyCOBNs46DczDr9O8iQxFZpmDuCGZ7xlTD7ATdYg8PxcQFWSsQ3+j?=
 =?us-ascii?Q?/LscVoitrtnuD/ToQtjiC618+KDbyx2jbyoLF+yImXWg1FEVqNmy+eadW+JF?=
 =?us-ascii?Q?osOlT56KO1zZvGRXbmR6U8PAimMk3BGawOcMpiwO59truR01zfluxm4DPP2R?=
 =?us-ascii?Q?Uy9yBf5fjD/lKblfWrCQF9d7iwaFwfcGmss7ssSGk5AZktLyg4TiW7/TlhRv?=
 =?us-ascii?Q?sbEDY2IGWNhR4Grvl8fsEn+KgWF2qTGS2hQmoiuA1M1x1QnpdX8EmT8Zo1DT?=
 =?us-ascii?Q?ZozyLE2qGtIZhgsmTLUE/RNSKdXLqHlAMDPS5in0R/2wKkewRafMGWGyH1l6?=
 =?us-ascii?Q?/DjyjJqYDm35nMEbGU7vXjCcCAl617tqAl5NH8MR0JL1vsM5l9SPXXKGN/uF?=
 =?us-ascii?Q?D1q2YexJyG42ostIxlrHDDb+HrCle0VjABaMN9t2jQFWStKbYR/YgMul+Zwt?=
 =?us-ascii?Q?lmOg7vE7bhTRKr3u51efXj2v+f5A7MsaAUYE+Nn7qNmjJXwqWfIf5sV94gBK?=
 =?us-ascii?Q?y5T4WkYMwZLs2aT/3h/x/IpPErjHTYy2hrWFseaGl2yErvN1APDqP9K1gBHA?=
 =?us-ascii?Q?NNPZAWhtrvecqZqhwIcQVpDcXWtmSuQznB/23AGg602wEkOApZY4rvFQ+3oF?=
 =?us-ascii?Q?CbH4ESy5SZRHoofURPqPKLNPd/NDbsY6Enos3FRqJH7I5PxAkgJf9DDc/p2m?=
 =?us-ascii?Q?fdumx68/OSIQS3jFrrdORrP0CMvrtUHh70FGDjt/ixcwEsj2+45cpPSQ3W17?=
 =?us-ascii?Q?OyZPHakz8/cd+oKmsMnp6ngRntb0eCwfulZ9H89NDJ1flTaJhhCqFnQJdI7P?=
 =?us-ascii?Q?MW5r1FHWKygoO/VNwEc5F1aY1jZ5LCTIGQkJaa2xrVkOVIGZzbBn7mGALEzW?=
 =?us-ascii?Q?99AFxcIKX7n60ctMY83ZsD/vm8FI3jZzOM6pbiQ6nTCvAlHhq4ee9ijvZ7Om?=
 =?us-ascii?Q?BV/BI4VasGEywVVzL+CbXc+qC6TTeIg6Ye+ebzW2DDEhYCKU5qWBZyxVzIVR?=
 =?us-ascii?Q?1B34J5M9uJW+t4uW6gWwn2nv39fgmUcwOf3zs8XfG7qVCSgdq2zs7LfBn3nf?=
 =?us-ascii?Q?jg8=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?x21deoLTpr6Jn3SIAEQ0CEME9nYGdU+O0AiUu+p1bI1eFYnJ5cZUheEBM0RD?=
 =?us-ascii?Q?ZDwQSGcwT0YfjP7K5/lc+hoFEXye+CRhNzgNoi+aSePQSD9i2INMPDh+Q1Sw?=
 =?us-ascii?Q?dP1byKiMAhV21VdmUHIgcSPWdx7BCKb6SPC7ZMTEf0nSSFHrb60AEksHmv0/?=
 =?us-ascii?Q?FHUNS5WqGLmwJnCO2nKCJBJ+euEMAKGliB3dYhLMU5exj+DsgdzzazOssn8E?=
 =?us-ascii?Q?UB8u3/RP4r3FNGTP7quDFip6v99DoFPW7Xprgd8O+J73iwd9OxaiMKcsQCKf?=
 =?us-ascii?Q?iRUEpa4hRbuZoU8yF2uRaKAhwTtozMlqB5A9OuRp1ZxjLrET7W6RSDu3vTEu?=
 =?us-ascii?Q?VeURH+kDzhw4Q1XN+ckPfnILb0WEI6ndCVoaVyVGE9AeIJm57oaBmdd1t7xC?=
 =?us-ascii?Q?bbjcMCtolibF0g5ImEheuG9oKcarj0d4ShCsaKxjItBUL9nTFmXVu3Jgdqks?=
 =?us-ascii?Q?v7enoUWUoH6wKsZ66kl0MucYbDDAm7unf543CmITd5Xup4K+H/OLVSve0z4t?=
 =?us-ascii?Q?H9jhdZaQ6Lav+Ib3LD40XHC6bgntOt6bU4ZlDB4J8OVH3HdoXIIvvSFoPQeo?=
 =?us-ascii?Q?EQylvN8K9qEIJncKH+iJa3IatzdORsf8678CYNGAOMyFBBeqIh1e/dPyeVgB?=
 =?us-ascii?Q?uOPnWVTbGm6tBiqPxkS9JqJdyAhE+JBkA5koV3VyyLLOfX87NkP0iPlsFJrq?=
 =?us-ascii?Q?7mY4A6rRv+CMNCLImhTnTdP/BiB0GMl/nUXcWBAQ0Qmb9KJHOzoKMKz1WktG?=
 =?us-ascii?Q?bt0tqbTTL96H4+KoHdCShCWWfzK0KyBplES4Ws/TlgRVBdYnvlJeM5yMjq+s?=
 =?us-ascii?Q?F+3ikeSdtk/AvTXkcf+QKZP1C+xj5nAbZvYwLacNgPJfLQKKFcB0QBgp/HzR?=
 =?us-ascii?Q?itCv/EfLukSemhGs1O1b4hS8lmly0OI934xtlH0u0jIqrSess3lhmkCI9TAB?=
 =?us-ascii?Q?EcawceNfCEZzZN3YaZbqVGRmrNMXy5ZEFLOQxcQjzLg1mWxz870Z1cZPPJhI?=
 =?us-ascii?Q?+7hKGX90Hc7e3jnLSuR8Jr86yjozk4sEPtJhOxu6q+GlJiz/XpLbySTK9EGp?=
 =?us-ascii?Q?kIvyshXBQ78ClAmyw6qclylpRTF2IAyV6eRcfmmu2uTmEgAHpxrOXQ3vgs7a?=
 =?us-ascii?Q?O2NlGfatEspEGEyxdZAj9VreWq6KMjCWl5BdVY0pKziU9whih+bkKt66G+D2?=
 =?us-ascii?Q?FO6EVv8dYEFGOcLNhrftL266dVSJeC4GPtiQEuqQB4aECIccZvw5X0mN7xBo?=
 =?us-ascii?Q?7Csc2ah6BJzNed7UZsogFdXVFOgqjmsT2Cv9CHF4Cn+/H3ubvs7X1bHQTmHT?=
 =?us-ascii?Q?InQuvqfbKWRFkbfs3OpqV7imAxgPKd9R8s51c6J4njsQN8gsmDJvUp/6nWxE?=
 =?us-ascii?Q?ClX1R0/lJz9myC+75MVDrC4qnYSthsizSz5umL0N0poIjcC2T5dsD7pLmd8/?=
 =?us-ascii?Q?PvEJVg44C+74iwjGl2pk7M1HelY5E6eaMYJ5jshNWu0uOBOTnq6Qp3V3HzMY?=
 =?us-ascii?Q?UMchrkw5GdW0JhNNCPYTHHCNg6Usb5/NZt1hFDDztsxDAKAPUHwz9vImETjn?=
 =?us-ascii?Q?qAoMb18v4oGH8oyPp/enKtumfhlSO46vTg5IJaRC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51dc25cf-8629-4d1f-5893-08dc7ee651c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 07:18:05.9029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YAbOKcF87R4pf4v/oGqtLobrYpWdSAHxHsEsM2CO/rVZHfXEu3fItx+XapxR8fmeQ1+L6gtO0YddCkYA+tPP5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4638
X-Proofpoint-GUID: nF7hrMSDal1DSzjz4C5eImc4EcARlHzV
X-Proofpoint-ORIG-GUID: nF7hrMSDal1DSzjz4C5eImc4EcARlHzV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_04,2024-05-27_01,2024-05-17_01



> -----Original Message-----
> From: Ng, Boon Khai <boon.khai.ng@intel.com>
> Sent: Tuesday, May 28, 2024 7:37 AM
> To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
> David S . Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
> netdev@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com; linux-
> arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Ang, Tien S=
ung
> <tien.sung.ang@intel.com>; G Thomas, Rohan <rohan.g.thomas@intel.com>;
> Looi, Hong Aun <hong.aun.looi@intel.com>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Ilpo Jarvinen
> <ilpo.jarvinen@linux.intel.com>
> Subject: RE:  [Enable Designware XGMAC VLAN Stripping Feature
> v2 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN
> Stripping
>=20
> > -----Original Message-----
> > From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> > Sent: Monday, May 27, 2024 11:36 PM
> > To: Ng, Boon Khai <boon.khai.ng@intel.com>; Alexandre Torgue
> > <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
> > David S . Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
> > netdev@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > Ang, Tien Sung <tien.sung.ang@intel.com>; G Thomas, Rohan
> > <rohan.g.thomas@intel.com>; Looi, Hong Aun <hong.aun.looi@intel.com>;
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Ilpo Jarvinen
> > <ilpo.jarvinen@linux.intel.com>
> > Subject: RE: [EXTERNAL] [Enable Designware XGMAC VLAN Stripping
> > Feature
> > v2 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN
> > Stripping
> >
> >
> >
> > > -----Original Message-----
> > > From: Ng, Boon Khai <boon.khai.ng@intel.com>
> > > Sent: Monday, May 27, 2024 6:58 PM
> > > To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Alexandre Torgue
> > > <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
> > > David S . Miller <davem@davemloft.net>; Eric Dumazet
> > > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > > <pabeni@redhat.com>; Maxime Coquelin
> > <mcoquelin.stm32@gmail.com>;
> > > netdev@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
> > > linux- arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > Ang, Tien Sung <tien.sung.ang@intel.com>; G Thomas, Rohan
> > > <rohan.g.thomas@intel.com>; Looi, Hong Aun
> > > <hong.aun.looi@intel.com>; Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com>; Ilpo Jarvinen
> > > <ilpo.jarvinen@linux.intel.com>
> > > Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature
> > > v2 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN
> > > Stripping
> > >
> > ..........
> >
> > > > > 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN
> > > > > Stripping
> > > > >
> > > >
> > > > New features should be submitted against 'net-next' instead of 'net=
'.
> > >
> > > Hi Sunil, I was cloning the repo from net-next, but how to choose
> > > the destination as 'net-next'?
> >
> > While creating patch you can add appropriate prefix .. like below git
> > format- patch --subject-prefix=3D"net-next PATCH"
> > git format-patch --subject-prefix=3D"net PATCH"
> >
>=20
> Okay will update that in the next version.
>=20
> > >
> > > > Also 'net-next' is currently closed.
> > >
> > > I see, may I know when the next opening period is? Thanks
> >
> > Please track
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__patchwork.hopto.o
> > rg_net-
> 2Dnext.html&d=3DDwIFAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3Dq3VKxXQKiboRw_
> F
> >
> 01ggTzHuhwawxR1P9_tMCN2FODU4&m=3Da48jwcbUStFRUDMUfXcfGEXhkW
> 3Pe9T0oNLv7B3
> > myIrV1geS5aBPZyougPLQZ3vy&s=3DoO5Em8PF8w6U6a1xROdgg-
> C0TRXsRmdFWku-FZQpH1
> > E&e=3D
>=20
> Checked the link it is just a photo saying "come in we're open" is that m=
ean the
> net-next is currently open now?
>=20
>=20
>=20
Yes, it's open now.





