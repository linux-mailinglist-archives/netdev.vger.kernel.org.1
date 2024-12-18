Return-Path: <netdev+bounces-152975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 813FE9F67CC
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E91A37A025D
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334E51B042E;
	Wed, 18 Dec 2024 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="iK7MgKeN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475B5158853;
	Wed, 18 Dec 2024 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530320; cv=fail; b=RapL/pK9r8O4426XoHpuEZ8vax3JfeoI9Wo9BdNy6rUjztIv8hl4xa2dgHoNIT6NxTl6XiZeMtxH+jvvM7c32PHgIx693x/k2SIrGo5ltlB1fg0ujz3EeKGm0m2CXDavYurfCWpy+PgLoClkctqCa+fJzg7KUAa4zsYL7K/MsEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530320; c=relaxed/simple;
	bh=MQnaM2N7kzJ1P2YH3cFbzQeGOUNx1A8XkxnqKc3LmAU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HNxCytZXGRywzaob4bxICNXJCrvNRoTfDsTxx06ZqEgevt7Q6uGw4lIgSHhTNDKO3wsYt9n7CZZA/oKawRBdCYQqg0TLdHuLp8qXVHVpHaO3YTHeR2KWIPugskJJxJ0UHNcjIhQFAQ7WejFr4I2tn1gSnxYoOA+fETHEsst4e4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=iK7MgKeN; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BID2T16016916;
	Wed, 18 Dec 2024 05:58:18 -0800
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43kxx8g2vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 05:58:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwIptq7ci/584LzSVne8OgbmhCXhflNC6Eet4kD2DgLOCMB5/LsIYOKeEgmCs38gfw9n3rrp9jyTAY8BRmUtarmvit0f7fz+O0kd/3F+pLoY20/lbjnV+JrCrJyso6phCqsQWHxtu2HZedGbcpKAEeb66hXCKImFOGxrHlDOB/q6SIotDMj4ZT2b0W4Ge1oZE0VKd3yqSK0I6KC3mcsfShoNR8V3m1ua4LV8WyZ/3mJ3jZv1ChEXgjyQertv4fb10IEPtsPOjyQmQIg4O/fUlYhfsGMx5dW5C8vPCuelz6XCWofG5oW2M3ydTnZ4kyBnTZ1ohH83luWqBvhsNbrH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQnaM2N7kzJ1P2YH3cFbzQeGOUNx1A8XkxnqKc3LmAU=;
 b=smUmsuJ8MX3nGFXMx0V1XDRbYjpjWUqxEobcJIZjs/rS9lPujNqi9jVE1UuPwn1paNvYxAYTG1lcqHuL1M0GU7bLXgfs3yG9r5uG3OVFxNS5LPFnmBlhXSymxSji9sEv7uY7rUvk5tLvtvF7WQKuRLMKn00RbuzuXSi9fkTg3Q0jByl0xU/WafFcgjpB8bUUvN/MUqQMAIMu1whDTzlHuUcWtc6205Bj8tYZ2QIM2FtlDZ9xENj66AAFknkBT5yKA2rCFkG8wGLfb302BTya4MJqdNxx8Ic7v+6SnWgiLWXuKfjkcPxm3Srry05Io2mnOsNa7rJRjJh6vm11HWjDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQnaM2N7kzJ1P2YH3cFbzQeGOUNx1A8XkxnqKc3LmAU=;
 b=iK7MgKeNWXCPv+X9xg/erOi54nJ89PfNVmu/wcqQijzrJeRAMVqeo1BifGIE2RmMyftY8p/7QoGgaH2NnhVfOKLq1LCOcc7y8FdNG4eno4xy2vqS7MvX2UVc+IrwCWVxjcPHLuMCldK8FTpO0Nd7rvM0zg3HLZ8PzWxYDg9M830=
Received: from BY3PR18MB4721.namprd18.prod.outlook.com (2603:10b6:a03:3c8::14)
 by SA0PR18MB3549.namprd18.prod.outlook.com (2603:10b6:806:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Wed, 18 Dec
 2024 13:58:14 +0000
Received: from BY3PR18MB4721.namprd18.prod.outlook.com
 ([fe80::dfc:5b62:8f30:84db]) by BY3PR18MB4721.namprd18.prod.outlook.com
 ([fe80::dfc:5b62:8f30:84db%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 13:58:14 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani
	<hgani@marvell.com>, Sathesh B Edara <sedara@marvell.com>,
        Vimlesh Kumar
	<vimleshk@marvell.com>,
        "thaller@redhat.com" <thaller@redhat.com>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "kheib@redhat.com"
	<kheib@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "einstein.xue@synaxg.com"
	<einstein.xue@synaxg.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew
 Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        Satananda
 Burla <sburla@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH net v2 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
Thread-Topic: [EXTERNAL] Re: [PATCH net v2 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
Thread-Index:
 AQHbT5BaYIqjRH+Vi0yNdgQ+YpYURrLo7ucAgAAEnACAAD0IMIABfHCAgAAKTTCAAUofAIAABj7Q
Date: Wed, 18 Dec 2024 13:58:14 +0000
Message-ID:
 <BY3PR18MB4721AF7DFD7F5F0384C37B84C7052@BY3PR18MB4721.namprd18.prod.outlook.com>
References: <20241216075842.2394606-1-srasheed@marvell.com>
 <20241216075842.2394606-2-srasheed@marvell.com>
 <Z2A5dHOGhwCQ1KBI@lzaremba-mobl.ger.corp.intel.com>
 <Z2A9UmjW7rnCGiEu@lzaremba-mobl.ger.corp.intel.com>
 <BY3PR18MB4721712299EAB0ED37CCEEEFC73B2@BY3PR18MB4721.namprd18.prod.outlook.com>
 <Z2GvpzRDSTjkzFxO@lzaremba-mobl.ger.corp.intel.com>
 <CO1PR18MB472973A60723E9417FE1BB87C7042@CO1PR18MB4729.namprd18.prod.outlook.com>
 <Z2LNOLxy0H1JoTnd@lzaremba-mobl.ger.corp.intel.com>
In-Reply-To: <Z2LNOLxy0H1JoTnd@lzaremba-mobl.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4721:EE_|SA0PR18MB3549:EE_
x-ms-office365-filtering-correlation-id: df017559-8333-484c-1f2a-08dd1f6c0428
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RkhtSnh6V0FEdGZ3dUVBckUrMVl6bkp4dWxlMm13Z2xrYkx4VVdPKzR3MFRt?=
 =?utf-8?B?cFBtbkpENUhrUHZrTHI4c08xUUtCdTJvR1poVDNzS0VnOGpXeXR4QVNtVUNZ?=
 =?utf-8?B?Y2ZMd1pXOUxiSDhCTUtvbnpQRzRPbzE3VTB1cnhmcnd4QVRTUnp1ZlJaY08z?=
 =?utf-8?B?alhCWUg0ditlRHV1VFg5L3F0TUR1VlJaN0hUOWdPQzhUUk9ROTJRRXhpUU1s?=
 =?utf-8?B?Tks4b3pDY2xHMzloVWQ3RE40c3E2THQ2aThpU0NSYkgzS3dMN290S2dWQnlG?=
 =?utf-8?B?Z2ZxN1pRY3I2UWtsUjFJM3JscnpBVDBMV210ZHVDaGdQc3hySDVlVndoUjBm?=
 =?utf-8?B?MHhhSVRKcWdoNGtBdmQzWmRpaTVBZEdlSzkxUHZJQlAxM3VKT0ZzVVQwTlUv?=
 =?utf-8?B?czRCMzJWeW1vcUNRd0Zpck1xVy9KT3hFRS8yV2MyRjd3SjlSMDBONEhJZGNC?=
 =?utf-8?B?aUJndlZhQzNiQ2xXNXk3WHcwR1FBd0VTUDAxdkJ1US8wVkptU2tyaDJFOTBv?=
 =?utf-8?B?MG5jWEt1RENNK1FKWG0xTDdtZXA0MUJScTlQNHFoM3YvWC9HL3AreVVqWmor?=
 =?utf-8?B?QnVsemZSUjBES2FGaWM3U2ZTWGo2eWNXbnZSTThPR0FUMmVXclErdWRBTnNY?=
 =?utf-8?B?dEN6RVFIZlhnZlRET2JkUjBoZnhZeTZ1cGkxTkdBbFFIWlVOTEJBOXptMldw?=
 =?utf-8?B?MGFNMlp4bk9IZXI3enFPV3lwdWw3MUZ4YzErMkxwbDdTa2M2aGpIbmRRRUZo?=
 =?utf-8?B?S1NFM1ZmU3VkMDYvSEdKS0dIQkhtYU9aTDRvd0sxNjh3alQxOVluekt3V3NV?=
 =?utf-8?B?YkZuYi9WT21tRkdPTTFoeW45b3hYeUQwSUlPWG9lUEcvVzhuc083a0dNS0Ja?=
 =?utf-8?B?UWJjZlRGazFFREhRMFhMV1hmekFVZVVFUU00bkw0dDRjcFpRWEZEbkQ2aE5C?=
 =?utf-8?B?cEVEYit5N1FSaDNiUGJ6QnBnQW1FWklkWHdpNFBQaEE5ZmNpNk54MTBWUnJG?=
 =?utf-8?B?NEpXVWsweFhNM1dDS1B6eDEzV2N5UWVHYWdvNW80OFRzOUNxQlE4enQ3Vjdl?=
 =?utf-8?B?ejJ0cHZtVXU4ZUZkRWlhUUk3M2FJTEczekxUZnNQbWNSUHJNeGNMbk12L3ov?=
 =?utf-8?B?OXNHaHd2Z2lBaEpMekdHS2RsVmkyVTVGZ3FjTzF3NG9RTnpFT3dZWUxUWEpL?=
 =?utf-8?B?eStYNGpjdUxiSHg4TW0xQjM0b25sT05jQmxKRTRhSHFHeVZGYVZhd3lEQjAv?=
 =?utf-8?B?K2ljOFBTa2xCYzg4ejBBMUdLSWgzWlp4YkowSWVDc1pLTy9TSStIWnJEcC9l?=
 =?utf-8?B?bnRaMGowWHk5dGhSRWhTYlFQZFVxckhzL1BuV01QNStJTWpmVVNLb2RYT1RE?=
 =?utf-8?B?SEVsWG8vYktnVGRoM1BGVWM0Tm8rS3B3eUVaV3pBcUF0RTRZZzNzb3poMFVP?=
 =?utf-8?B?eEwwbG5Hd2hpL0JZRG1EVjNEQnBBZU0yN3ZzaHVlUTRaNnRVRHFHcmFlcThh?=
 =?utf-8?B?SkVWQ0lsQUNrd200TkV2WmgzenFub0g4QmMzcytSNUVIaFU0ZmFjSjE5ZnB6?=
 =?utf-8?B?ajdGYkFBWHMydVU0VFI1VkZWSWlYT0l5VnFKaGx6ckFyUkFVS2tpVU5YTWVG?=
 =?utf-8?B?QnNaUFYvRUxFaGF3UkQ2UXUyQ0VyOXdMbDhqdnFrNHVQbzhpeitJS1JsOThN?=
 =?utf-8?B?SGVHTEl2VDVNZ1Z2MWVxRzZWeGk0MW5RajhmM1dDS2lsSzRJdjlHMU1XUDZI?=
 =?utf-8?B?WjcreC9sM25Rak9rcFhzMlM2MVZpWjV3OVBUMlFEcjg5cmVMNktBZU1QeGY5?=
 =?utf-8?B?UFFEL1dPQ0VQS0FVYk9kcmJEbk1Ia1BhcDI3RG5udm0rOEhRNkxVanRSUWFj?=
 =?utf-8?B?YTh0SDhGZU1GZUc0YkZ3R3paVWd6ZGtpc3Mwb2V0Nm5ka0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4721.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmVzRE83TU1weGN1ZHMzT3d6aTVzeHA0TCtEeng4Nk5tQlVDK2JIbTEvTFU1?=
 =?utf-8?B?dWowWHRrVW4ra1lXd21sVlc4ckt0RE1iRmhJY2hQWlRSQWJWc090SjJIN3JL?=
 =?utf-8?B?cFBHei84Y0JGSUpKNVhDWk1pd0J4K2N6ci9tc3Z3S3dYckpsSDk0bnZvcXI5?=
 =?utf-8?B?SHFPUkVVVjRmMXZaZ3JJV3M1bUJ6dHBHY1owaGdSdVRXUmxYOE52WWR4ZnNW?=
 =?utf-8?B?WkMzSkJEV0RDQnJBbjJvc0lveHp1Mkk4REkrMFkvVDhRL01uUmFwdWVrVHZs?=
 =?utf-8?B?SE51bE5CckxqQzJoRkZDR214ZlZoZWMvL3JZZnRWWlN1VzZVMjV3QXFTcktw?=
 =?utf-8?B?Yy9HNTNoWWZBdUx6SVd5UjljMGlvMnRZZ3VQRXliVEYvOWdNUVoyNU9oV3cy?=
 =?utf-8?B?MGs5L1J0c3ZkOXdoSlJLR0dyZXNITUxqVVRFZjljdVBHbmZZbTZJY3RxRkdM?=
 =?utf-8?B?eHhsTUJjSXQ0SkpoTVZsL2tGNmtPMW05SUZ1UUNQdTNHazd5SVFNZ3JqNUt6?=
 =?utf-8?B?WEJVeDVvQWF3UjVKajJMUjVkcy91TUtpdXJlcmx1SXI5OG0vZFlNbUxyd1Fr?=
 =?utf-8?B?NlhNdTBxQmRxU1MzOVJ3M2djSFFjcHNMU2dnTTBNcG1xZ0NBSzN4U2hZcE5z?=
 =?utf-8?B?cjhVTnBReXpnVHJWWkd5M2hBRGc5eHh2c1puMTcxTWVCbS9ON0FMWnBsVC9o?=
 =?utf-8?B?cnhTYURPdVNab0tUTHFydXlhU3ZFTVhDdUxtSUhheC9pcWF3SUk5a3BBR0cr?=
 =?utf-8?B?aFAyRnJGY011RFpCcVNXcytVdGJoN0M0WTZMaDdVTncyQ2pFNHNSV29XN2c4?=
 =?utf-8?B?bi80dkd4NlZ5MjFZVG5YdlJIVFpKRDBjVXJmaFBZVU9VUWJWNEx5R1RXWEtL?=
 =?utf-8?B?cS9qNk5penJ4b2h5SHRpT1QxZTArc0FUWTZLaVE3aHVKRXRHOU1NNlJVOGRz?=
 =?utf-8?B?cEVyU3I5U3hYWUZzdnJleCsvQ2FMWG1vWFNMb0lEUzNKM2lMTm1OZ01lVXFh?=
 =?utf-8?B?ZWFEY3BYT1JKb0lxbUIvY2hmK1VJNllpRS8ycmd4N2lMTXk5RUxPOUNVcWR6?=
 =?utf-8?B?OWNnZGgyaUJZbE1uYWlXbUNvMVBWNjlZMXd5ZXNzN2ZuRXhsZnhJZWYrKzNK?=
 =?utf-8?B?d3EwMTcwNm1UM1ByaitaZnU5aGovVkxhQkFabDkvNHU1VmxTVzhwU2x2WXFL?=
 =?utf-8?B?eTRCNm5kY0psa2d0bWQ3SGxDcWFBQkU5TjNoOWJ2MDVSU2ZoTlY5eTNKbHZB?=
 =?utf-8?B?UCszZXp1RVU4NnZORjI0WnFOSVF6OUN6TzhodGVxWkVhQnFGKy9uRm84MzVG?=
 =?utf-8?B?MHdERVh3M2U2ekt6dU1jbTJzaEtkQjJqQnRZUENyajNzMTlqek96Ly82VGlM?=
 =?utf-8?B?dlQ5UGEwNWV2eUI4UGF4WWtpa3czaDJKdUJUK24xejFEdmR5M3JLRk1YTmpP?=
 =?utf-8?B?ZzkrdFV2R0tqUnBLWmI0UG5tMmJvRWdkOGhEdEZTT0FEeGRTeWZ2TDI0OUZm?=
 =?utf-8?B?Q2llREY4cE4rNXcxb2k2OFlDSHg2L2hoRkpNQzhYL1A3SEpTNzNhNlRYOUpH?=
 =?utf-8?B?NEJWTmZ0VGM4QXRrcU8veG1vSkFwTXZpUFgzMnhLbkxlaFZycjltNU4yL0Jm?=
 =?utf-8?B?dXk0N1NSc2k0OVNabmliRnBTd3AxZ3JUSzJmZ2hSVm96WDcyeGRWOHdTaDdp?=
 =?utf-8?B?K1B1L0s0NWVHOEU1Uis0c2ptcDRlRERKbmZpREc5N2N3cEFON2RFME1ZaDU3?=
 =?utf-8?B?L1pyb25tSnpGaFRranduSGt2dnZmbURNb3lodFRxS0dpYWVXaXFBMXlSazFY?=
 =?utf-8?B?NHZVVk94eGppVGVkNk9GR2tTTkJZYVZiSy8zeWZNZGJ0ZUMyeEdjdDF2K2RU?=
 =?utf-8?B?RkFTdGIzZ1pYVlNTUFhhWkJCOERPa1VxWGppRDdYVUxKT3RBYk54aUVUUmhx?=
 =?utf-8?B?UjZESWxhQmNudXJZMnc4REJBTUpnT0NFWDZwSmZuMW10OG5VT1dwZUJhbmIv?=
 =?utf-8?B?Rzd1MFhtaEFwWHRTYU90a25XcmJWQkxPd2ZFZ0lDLzliTEpWL2hCVUZFQzND?=
 =?utf-8?B?Rm16ZS9sZ2pKQW0vRS9YTDloNituOXdVYkptcE1MVXk1MWFTbkRnYzBibWh3?=
 =?utf-8?Q?sTkU171OoE5Azgg7cwW/Joir1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4721.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df017559-8333-484c-1f2a-08dd1f6c0428
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 13:58:14.2937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EdnedOYrRcIplCYfFEf49wwFWzD/uhHez3VlkYHD3nT4poU33JvE/otSnqAj1sTtbmw6b5doiCp5RZcQuCqYuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3549
X-Proofpoint-GUID: 7SoaVvUSJ1Ymz1v2V8_1PvbG6Wfs1Bol
X-Proofpoint-ORIG-GUID: 7SoaVvUSJ1Ymz1v2V8_1PvbG6Wfs1Bol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

SGkgTGFyeXNhLA0KDQo+ID4gPiA+ID4gT24gTW9uLCBEZWMgMTYsIDIwMjQgYXQgMDM6MzA6MTJQ
TSArMDEwMCwgTGFyeXNhIFphcmVtYmEgd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBTdW4sIERlYyAx
NSwgMjAyNCBhdCAxMTo1ODozOVBNIC0wODAwLCBTaGluYXMgUmFzaGVlZCB3cm90ZToNCj4gPiA+
ID4gPiA+ID4gbmRvX2dldF9zdGF0czY0KCkgY2FuIHJhY2Ugd2l0aCBuZG9fc3RvcCgpLCB3aGlj
aCBmcmVlcyBpbnB1dCBhbmQNCj4gPiA+ID4gPiA+ID4gb3V0cHV0IHF1ZXVlIHJlc291cmNlcy4g
Q2FsbCBzeW5jaHJvbml6ZV9uZXQoKSB0byBhdm9pZCBzdWNoDQo+IHJhY2VzLg0KPiA+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gPiBGaXhlczogNmE2MTBhNDZiYWQxICgib2N0ZW9uX2VwOiBhZGQg
c3VwcG9ydCBmb3IgbmRvIG9wcyIpDQo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFNoaW5h
cyBSYXNoZWVkIDxzcmFzaGVlZEBtYXJ2ZWxsLmNvbT4NCj4gPiA+ID4gPiA+ID4gLS0tDQo+ID4g
PiA+ID4gPiA+IFYyOg0KPiA+ID4gPiA+ID4gPiAgIC0gQ2hhbmdlZCBzeW5jIG1lY2hhbmlzbSB0
byBmaXggcmFjZSBjb25kaXRpb25zIGZyb20gdXNpbmcgYW4NCj4gPiA+IGF0b21pYw0KPiA+ID4g
PiA+ID4gPiAgICAgc2V0X2JpdCBvcHMgdG8gYSBtdWNoIHNpbXBsZXIgc3luY2hyb25pemVfbmV0
KCkNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L21h
cnZlbGwvb2N0ZW9uX2VwL29jdGVwX21haW4uYyB8IDEgKw0KPiA+ID4gPiA+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbl9lcC9vY3RlcF9t
YWluLmMNCj4gPiA+ID4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9uX2Vw
L29jdGVwX21haW4uYw0KPiA+ID4gPiA+ID4gPiBpbmRleCA1NDk0MzZlZmMyMDQuLjk0MWJiYWFh
NjdiNSAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFy
dmVsbC9vY3Rlb25fZXAvb2N0ZXBfbWFpbi5jDQo+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9uX2VwL29jdGVwX21haW4uYw0KPiA+ID4gPiA+ID4g
PiBAQCAtNzU3LDYgKzc1Nyw3IEBAIHN0YXRpYyBpbnQgb2N0ZXBfc3RvcChzdHJ1Y3QgbmV0X2Rl
dmljZQ0KPiA+ID4gKm5ldGRldikNCj4gPiA+ID4gPiA+ID4gIHsNCj4gPiA+ID4gPiA+ID4gIAlz
dHJ1Y3Qgb2N0ZXBfZGV2aWNlICpvY3QgPSBuZXRkZXZfcHJpdihuZXRkZXYpOw0KPiA+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gPiArCXN5bmNocm9uaXplX25ldCgpOw0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+IFlvdSBzaG91bGQgaGF2ZSBlbGFib3JhdGVkIG9uIHRoZSBmYWN0IHRoYXQgdGhp
cyBzeW5jaHJvbml6ZV9uZXQoKSBpcw0KPiBmb3INCj4gPiA+ID4gPiA+IF9fTElOS19TVEFURV9T
VEFSVCBmbGFnIGluIHRoZSBjb21taXQgbWVzc2FnZSwgdGhpcyBpcyBub3Qgb2J2aW91cy4NCj4g
PiA+IEFsc28sDQo+ID4gPiA+ID4gaXMNCj4gPiA+ID4gPiA+IG9jdGVwX2dldF9zdGF0czY0KCkg
Y2FsbGVkIGZyb20gUkNVLXNhZmUgY29udGV4dD8NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiBOb3cgSSBzZWUgdGhhdCBpbiBjYXNlICFuZXRpZl9ydW5uaW5nKCksIHlvdSBkbyBu
b3QgYmFpbCBvdXQgb2YNCj4gPiA+ID4gPiBvY3RlcF9nZXRfc3RhdHM2NCgpIGZ1bGx5IChvciBh
dCBhbGwgYWZ0ZXIgdGhlIHNlY29uZCBwYXRjaCkuIFNvLCBjb3VsZA0KPiB5b3UNCj4gPiA+ID4g
PiBleHBsYWluLCBob3cgYXJlIHlvdSB1dGlsaXppbmcgUkNVIGhlcmU/DQo+ID4gPiA+ID4NCj4g
PiA+ID4NCj4gPiA+ID4gVGhlIHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBvY3RlcF9nZXRfc3RhdHM2
NCgpICgubmRvX2dldF9zdGF0czY0KCkgaW4NCj4gdHVybikgaXMNCj4gPiA+IGNhbGxlZCBmcm9t
IFJDVSBzYWZlIGNvbnRleHRzLCBhbmQNCj4gPiA+ID4gdGhhdCB0aGUgbmV0ZGV2IG9wIGlzIG5l
dmVyIGNhbGxlZCBhZnRlciB0aGUgbmRvX3N0b3AoKS4NCj4gPiA+DQo+ID4gPiBBcyBJIG5vdyBz
ZWUsIGluIG5ldC9jb3JlL25ldC1zeXNmcy5jLCB5ZXMgdGhlcmUgaXMgYW4gcmN1IHJlYWQgbG9j
ayBhcm91bmQNCj4gdGhlDQo+ID4gPiB0aGluZywgYnV0IHRoZXJlIGFyZSBhIGxvdCBtb3JlIGNh
bGxlcnMgYW5kIGZvciBleGFtcGxlIHZldGhfZ2V0X3N0YXRzNjQoKQ0KPiA+ID4gZXhwbGljaXRs
eSBjYWxscyByY3VfcmVhZF9sb2NrKCkuDQo+ID4gPg0KPiA+ID4gQWxzbywgZXZlbiB3aXRoIFJD
VS1wcm90ZWN0ZWQgc2VjdGlvbiwgSSBhbSBub3Qgc3VyZSBwcmV2ZW50cyB0aGUNCj4gPiA+IG9j
dGVwX2dldF9zdGF0czY0KCkgdG8gYmUgY2FsbGVkIGFmdGVyIHN5bmNocm9uaXplX25ldCgpIGZp
bmlzaGVzLiBBZ2FpbiwNCj4gdGhlDQo+ID4gPiBjYWxsZXJzIHNlZW0gdG9vIGRpdmVyc2UgdG8g
ZGVmaW5pdGVseSBzYXkgdGhhdCB3ZSBjYW4gcmVseSBvbiBidWlsdC1pbiBmbGFncw0KPiA+ID4g
Zm9yIHRoaXMgdG8gbm90IGhhcHBlbiA6Lw0KPiA+DQo+ID4gVXN1YWxseSwgdGhlIHVuZGVyc3Rh
bmRpbmcgaXMgdGhhdCBuZG9fZ2V0X3N0YXRzIHdvbid0IGJlIGNhbGxlZCBieSB0aGUNCj4gbmV0
d29yayBzdGFjayBhZnRlciB0aGUgaW50ZXJmYWNlIGlzIHB1dCBkb3duLiBBcyBsb25nIGFzIHRo
YXQgaXMgdGhlIGNhc2UsIEkNCj4gZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIGtlZXAgYWRkaW5nIGNo
ZWNrcyB1bnRpbCB0aGVyZSBpcyBhIHN0cm9uZyByZWFzb24gdG8gZG8NCj4gc28uIFdoYXQgZG8g
eW91IHRoaW5rPw0KPiA+DQo+IA0KPiBJdCBpcyBoYXJkIHRvIGtub3cgd2l0aG91dCB0ZXN0aW5n
IChidXQgdGVzdGluZyBzaG91bGQgbm90IGJlIGhhcmQpLiBJIHRoaW5rIHRoZQ0KPiBwaHJhc2Ug
IlN0YXRpc3RpY3MgbXVzdCBwZXJzaXN0IGFjcm9zcyByb3V0aW5lIG9wZXJhdGlvbnMgbGlrZSBi
cmluZ2luZyB0aGUNCj4gaW50ZXJmYWNlIGRvd24gYW5kIHVwLiIgWzBdIGltcGxpZXMgdGhhdCBi
cmluZ2luZyB0aGUgaW50ZXJmYWNlIGRvd24gbWF5IG5vdA0KPiBuZWNlc3NhcmlseSBwcmV2ZW50
IHN0YXRzIGNhbGxzLg0KPiANCj4gWzBdIGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNv
bS92Mi91cmw/dT1odHRwcy0NCj4gM0FfX2RvY3Mua2VybmVsLm9yZ19uZXR3b3JraW5nX3N0YXRp
c3RpY3MuaHRtbCZkPUR3SUJBZyZjPW5LaldlYzJiNlIwDQo+IG1PeVBhejd4dGZRJnI9MU94TEQ0
eS1veHJsZ1ExcmpYZ1d0bUx6MXBuYURqRDk2c0RxLQ0KPiBjS1V3SzQmbT1ESnpKTm85V1QxMHBT
SGlrSmhDQmJONy1DZkItDQo+IE8ya3o5T1ZHc21pSVJRWHZjSUlXREs2MDM0dE1telpHdmxGcyZz
PWVzc0UwMXN1TFdGNDJ0YU5pMHlKM0gzWUMNCj4gMEV0OEdvZk1qNXd4b3I5eUQ0JmU9DQo+DQoN
ClNvcnJ5LCBJIG1pc3dvcmRlZCBteSBwcmV2aW91cyBzdGF0ZW1lbnQuIE9mIGNvdXJzZSBuZG9f
Z2V0X3N0YXRzIGNhbiBnZXQgY2FsbGVkIHdoaWxlIHRoZSBuZXRkZXYgaXMgZG93bi4gVGhpcyBp
cyB0ZXN0ZWQgY29kZSwgYW5kIHRoZSByZWFzb24gd2h5IHRoZXJlIGlzIG5vIGlzc3VlIGluIHRo
aXMgc2NlbmFyaW8gaXMgYmVjYXVzZSBmb3IgYSBuZG9fZ2V0X3N0YXRzIGNhbGwgdGhhdCBoYXBw
ZW5zIGFmdGVyIG5kb19zdG9wKCkgaGFwcGVucywgdGhlIG9jdC0+bnVtX29xcyB3aWxsIGJlIHNl
ZW4gYXMgMCwgYW5kIGhlbmNlIG9jdGVwX2lxIG5vciBvY3RlcF9vcSBpcyBub3QgYWNjZXNzZWQg
aW4gdGhlIGZvciBsb29wIHRoYXQgZm9sbG93cy4gT2N0ZXBfaXEgYW5kIG9jdGVwX29xIGFyZSB0
aGUgcmVzb3VyY2VzIHRoYXQgd2UncmUgdHJ5aW5nIHRvIHByb3RlY3QgZnJvbSByYWNlIGNvbmRp
dGlvbnMuIEhvcGUgdGhhdCBjbGFyaWZpZXMgdGhpbmdzLg0KDQoNCj4gPiA+ID4gVGhhbmtzIGZv
ciB0aGUgY29tbWVudHMNCg==

