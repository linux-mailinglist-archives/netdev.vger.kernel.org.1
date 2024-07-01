Return-Path: <netdev+bounces-108279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C2A91E9C8
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 22:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A1AAB20543
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D85D8248C;
	Mon,  1 Jul 2024 20:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cHeMggS7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC58F1366
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 20:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866775; cv=fail; b=QXIGgJmC8CuR4qw/jJSMDryBJNGoIsrlS9kj+lsFEEHlQsfrgNtl5oFR9L5XQC37BoplACMnHg/aGs86EFF391vnN6qvD9yC/PWFDyimyiRwFrQRDGyl1W1v5fuj2sLNZF87CshTwv/VGkgtmjakwinKC548a8UdCe5ziHQEneU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866775; c=relaxed/simple;
	bh=46ErzS2rks+pwC+VS0n2nMhGtlkUe9kj4tdMINjx4dg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rrt6m6iZ7z4HKveqC4Gxfk2XvmnkhzrLVRdfSUIcxECiCZs2Ynn41tShJ8FANP1uyXFgq5XK+imK+8HzJ89bF3U+sHo9ECHgYcfo5wRcLZJBvVgcWgO1IKQNt5Q1jnLbEzQlmLZoXuHsCleK1PkAmm0I2U30DpbZ62OxkG0p9+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cHeMggS7; arc=fail smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461JA6ux003350;
	Mon, 1 Jul 2024 20:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4TBDJ6C1Y2rHY6hoBxso75A/TRSrI/T1RlrCFSLKUK8=; b=cHeMggS7m8JIpUx6
	PbypFRgQO2oLPRnQbqwkER14I8EsS0JIT/lCPo1aV9JZ3bkAQOkXikG2wja1C8gx
	20Azvj8nSElWovB/07Ed20rQni7UNux3YOcZR/Sr+oQJZdogRvLCs51y8vVh1NKp
	b8DikGac4MiIbOMUe5m1F3502WiMCYxPmL/40Zp0kullSeOZUMrDcj1BBTNyHuKL
	Aw5J28Ltd7ymSjsFj61YYeqcpoHyQYxsO6+ou4hCo4YgAzVxp1Ni7r8icp8Uqzua
	zZATPGDBKcSnBfs7JI5llzkB/UGZnu3vR5+xrW4Vxhs3XJE9pzoXvyglDfqD9qC+
	rU1Wcg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4029uxd9pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 20:46:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKlJiOvoR/qz4Vf4ptHT1MdiFRwbWywOzumnzAJXLMvmVf7ILF7rHYf0htVFIQLWpkSgE7N7NlzYNDUE+6McjqrWNrPMpH4IeA+krn3+FFbev49KgTYhvmyYeaHgnxmnYGf2jD0h/fKZUyfibb1VjowHVm7tux4fhqLswhRBVNbxz23YQ34VwgEhoik52Ncv8YNaFQUN6+9+8X7P5m7SgJFz4wFlIXwrhZF3KnG03seRQm31VO92kfbmOuc+mMNhQr3JtohGXa5d3qLbzWnJ2XzTVdBQyQ8qErbW2AR0cMYyBdI8PGZfZsJSk+oFvVYXldGNHbWnZphTsMNCas3Hzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TBDJ6C1Y2rHY6hoBxso75A/TRSrI/T1RlrCFSLKUK8=;
 b=CWPt18xyno4kyEe3rdincZWJVVENEn4ZvgCBTm6VGyd8LI/7B89Txj35gsSxGexs/HrbohrIj5i01zQj8Xuop2Hx4/RncqTaxP5HhMx0DnjhqwnV7QrhhsW4GrHqI9eMp+jeJzRLMyxiCFEkCn51ZVqPPuIydaU2JNRP/BBoNsqy9y3t8+IK2ACDVP4Viu3tCirAyKnqArXNpZktNszePnbpbO2qzGeZITiLh1+LqvJ0AoDClK0euQHg4bbkuHjmd3+2Q6jmD3q0a6UMsI3XcxMsMZXvpJvkpVtnMTo7BMYoxSoC6XNpEgGKnFCxqQ9UdH5K/qqhZaTJadG/Lx+zlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from PH7PR02MB10039.namprd02.prod.outlook.com
 (2603:10b6:510:2ea::17) by SJ0PR02MB8626.namprd02.prod.outlook.com
 (2603:10b6:a03:3fb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 20:45:50 +0000
Received: from PH7PR02MB10039.namprd02.prod.outlook.com
 ([fe80::3b00:7b27:db10:2197]) by PH7PR02MB10039.namprd02.prod.outlook.com
 ([fe80::3b00:7b27:db10:2197%4]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 20:45:50 +0000
From: "Sean Tranchetti (QUIC)" <quic_stranche@quicinc.com>
To: "jmaloy@redhat.com" <jmaloy@redhat.com>,
        "ying.xue@windriver.com"
	<ying.xue@windriver.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Subash Abhinov Kasiviswanathan (QUIC)" <quic_subashab@quicinc.com>
Subject: RE: Permanent TIPC Broadcast Failure When a Member Joins
Thread-Topic: Permanent TIPC Broadcast Failure When a Member Joins
Thread-Index: AdqRG1Rv02uijSi9SqeRw2mbZG7gMQ6wMuGQ
Date: Mon, 1 Jul 2024 20:45:50 +0000
Message-ID: 
 <PH7PR02MB10039A099EB6D53B3DD2EB9ABCBD32@PH7PR02MB10039.namprd02.prod.outlook.com>
References: 
 <PH7PR02MB1003916E9855CB7A11E1B1D6BCB0F2@PH7PR02MB10039.namprd02.prod.outlook.com>
In-Reply-To: 
 <PH7PR02MB1003916E9855CB7A11E1B1D6BCB0F2@PH7PR02MB10039.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR02MB10039:EE_|SJ0PR02MB8626:EE_
x-ms-office365-filtering-correlation-id: 953007ce-ea05-426c-989e-08dc9a0ecaf6
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?nk58/RiQq9xEAiSQmfnmO0L7JnLx1XxQE8Z+tsFx6hpLHBAm1ZNu4Q8GLDBl?=
 =?us-ascii?Q?3RRHFeTh3oPnjB2Xx0s/4mAcT4XuUavlrINQfPtAgG9Ym1P48v8v8gPtRQ0N?=
 =?us-ascii?Q?v7MWGT/RPdKryNgMiy1BRFrBOxnlfsx8wQbrI2mMLAbxGxNFikBZhgoJhPsv?=
 =?us-ascii?Q?nDEFDPr9xZWEiszsikvzDEIaGW4kNR3JlmL75iF3yYgth8tHB5mp4yvJqHIr?=
 =?us-ascii?Q?/FpgLSKpl6+Ttll+OXtdkV0EaJtbTAyl8Q2s0ZlndkUIE5HbXM3l1k+/NXYb?=
 =?us-ascii?Q?peyLuZTawT7DWfIsh1Ykcar0aGS5AyYuA/7V8K50bu/IKmcSs/VEDIPUEriC?=
 =?us-ascii?Q?raGFnLfDmm+t/viQ89sDEEQG0QiZ0c2O1WkZLRyk9SDX7I5tCaUqkG203Unf?=
 =?us-ascii?Q?j4O7GYN0SsS6pCYMhM2QCAsSVm/GA1MrbwCn7JaU+cYo7jBT5De2586ZcKpC?=
 =?us-ascii?Q?gDVs7lZKLyb/RGYYSlpmWnbNvQmh4DGtElEkrg54wueltlakNOW8sHm+vSKq?=
 =?us-ascii?Q?yZ+k/R3jBopdFDQ7eKqS+9zGIQfItVJyZ+tFzztOiJ6r8sUbx7YlC9EDij8P?=
 =?us-ascii?Q?rmM0CNhjLLZHF9Kiv+8G/dlM+RuuO6LAkmCQmSRl+6kjn4OaH/T14qXoPyIb?=
 =?us-ascii?Q?lJpiyl2wxqROZV9v1eBIDVNvBRF6PNCteLqyr8cHiYTIQaeSKogWR1pfOK0T?=
 =?us-ascii?Q?DhZSJmj6OfLRKulihquxe06fsaighzIwpPQgP3M21FPi8+ez4USW9litl+9I?=
 =?us-ascii?Q?5xq95kmbIJf3eACxpmUYIgnSdAHllHY34Qbg73xfEFABVT7giTjqbX6woXBf?=
 =?us-ascii?Q?9rIUczRJ0HqsBZcKoAnl25MxnNq99bujwqTNDwZxC5BNXuzsLJMyPHBonjVT?=
 =?us-ascii?Q?Lr0yBSttGV58ecZhfqe1x8W0OD4LMsbeMVOzoFqKOIWlbMq6FykS99VTlgOu?=
 =?us-ascii?Q?mbJfdziBkOw5WxcGUoJ/1RpLAE+X8dzTXRAzMv+HxszJhzIASbcvZSTgZ6bv?=
 =?us-ascii?Q?Ntx8+Yu5ftIWd1WDRGF5JnqjXRr4Vg1+z31nt5xI/HVmb4ZvkVbMedZkTKqd?=
 =?us-ascii?Q?kce+yPhN2XNYzpBua96IvQILKhlAfj2b5JZ0gKdO0i7l0aFCiKqzr9RGQqsh?=
 =?us-ascii?Q?O+RRKNsjJjrO/wnYLvlYAy4FTSpGipgqbyj26+fvTCV5eqNoKtZgBoCrBMQS?=
 =?us-ascii?Q?8pTm7/Hxfk/Hdmy69B//KzxnPpoTrFuJqnlgoDcN5MmmFPHrPvu0CXwIT1SL?=
 =?us-ascii?Q?P2wapgVkN6wLKW66wOlIw759KHWCSjFggO3rRZ0K8InWA0Do/FHTRolWAZ6d?=
 =?us-ascii?Q?BmRGeS7/i+nqi7TbjD5OxjO5fKCHxnAGhb4GdUt5iqhFc2jNpFq9KvrD7rU1?=
 =?us-ascii?Q?oPHl38Pq+jrZyTX0Y2AYsci8A2zQGDa461IIbMoGk0cTtKtuYQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR02MB10039.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?S0LLwfTVRFnt3kldqwz1FFIGoWxJqHNf8B+5T6HCSeW2iAzTmh0T0XRX26k6?=
 =?us-ascii?Q?MK9fsZpvV8p7idUYTfk2DcSI4A8dt4iX+6pYE/jZSB1OOcQLE3it7l6SNY33?=
 =?us-ascii?Q?gHl8NW0NCw2PgxMGG6ylwn2MorepAu8w5Q+LO6ylouaFCeuAl1i3F7KbIkLq?=
 =?us-ascii?Q?OJPxY420mHn6GyGJ7Lj6WvUJmLLRme0qvzR7kPNBg4/UW0q4Wfv7g7QznoE3?=
 =?us-ascii?Q?+SA4IrGMCCpajbtQ6E9oJR55dgpEc1qEX+lKyAIaB8aGLOGoth/qE5vitNcM?=
 =?us-ascii?Q?OSP/eiG+sLedmW5+LtyYVIGqhYCX46kd3jxviqwEnbkfn+uhu4zoePjUQYPF?=
 =?us-ascii?Q?I4M2Bjeh24ZNUI/+/qt2qgSoLO+urHsYIOVe6CMHLV0uzzJDdNxWhu5f1IfS?=
 =?us-ascii?Q?dLbm8quS/aUrEOMxQueNCNJNtLLQaeJVnAiKxSFPgCY0GGg29baLYuDeIIph?=
 =?us-ascii?Q?w4qqoeppnDRbIkt8AZcJvcuceOvEEtDtbKkFa5adG6A1YYrlryIBgYWB9jK8?=
 =?us-ascii?Q?nNjLiVWNrmQDcrguonMUIFTrH3zyDBypIuGKuXnFvACiqjpWSjxqWEGaI01B?=
 =?us-ascii?Q?wTVOnQKUVuxmkjQbPxvJQ3Fof/Uww7va6cEcW9tJtgdB7vJZzC8sAG/j3NRW?=
 =?us-ascii?Q?NVWLu1osfbLzRsYn5LoppmdXOQO6hb6c9usFVxdvVOmZqluWkdA9n3L5Xcmh?=
 =?us-ascii?Q?8yxIFRdw5qxM+kYHeQFJ6Hkn6zgKKrKugWOdG4N8LxIuWLuovi2qkSQRSBFU?=
 =?us-ascii?Q?IE6RVakHLyJWVrQ3blBPPNAXHtmJpTqA0XqOn+Qawll8JQl8F7+Wtt02MC21?=
 =?us-ascii?Q?HcoQTNPrwzjQG8WTvNcH8F1uaJZFdNly3dTha1UrvTZSxOj3W9kPuLh6PK08?=
 =?us-ascii?Q?emuy0Wsuk/HJKu9FNp1Ufe69Sz8/2zm8z8X478n4Dj9J72V47fGCuqboqVGa?=
 =?us-ascii?Q?opR6EbvnkgD+Uz6dVqxB0aCkP+OKDNxntrlfh3ahKbbyX0X221AAQkY0u00+?=
 =?us-ascii?Q?fSk6v1o1tpox5eI6pL2ngJ2/Xc10+u6a5ZDp3HhXQGxphGC505XfpAS66uHe?=
 =?us-ascii?Q?bSjGntJQOCVVHuBohjJuDTyzrCdLs/OIU0GceQmNMHwFQM/i1rdg3CkRCKvo?=
 =?us-ascii?Q?ffOVM6Esq36ts9fNKva5ePTamta0AoDMohOOtI7Lmxzx6xP3idlaABxm+6eR?=
 =?us-ascii?Q?BnEgNbCv4Vyghzxkjbg6kPzj4w0jgtIJpjYxcmSeXGVYDjaUa/QW82DE8OSS?=
 =?us-ascii?Q?QUmnnfSaszIZ7ZWTqfJxMpkHaOWSUDJwOLCmG5qesd/Hc0tF2/fERG4RNHHl?=
 =?us-ascii?Q?YQbFi1Xq++I6GJSRWnaZGSuWJpsx94DchcEx+iqm1zhI4/h7rXUezw+5nvfI?=
 =?us-ascii?Q?/Nvln1+3aitAQQST6kDGDos10erWH06oT2SMt+IWYl3UITWqyj+jV6W5CE3L?=
 =?us-ascii?Q?EosaCUhLm8ltk5sc0uarG50dlQ+t+6EHD/R/KIDQyQGTTRodCPtyHpa4r0yS?=
 =?us-ascii?Q?MNO14jb+ZIC+duwjJsnHMu++8WWrcGqpRsTqA2mSmQSfznxwFFQw+SgqaX0o?=
 =?us-ascii?Q?oe1cnrVVcQqNPa0fggw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	t0d+USKHrBIuLdozJ3dH1i+8tTszmYVuH5tya+krQDvQ2yfNOw8kFq95vquHk80Bmo4u2mR3x1BNX332nVJePQBpCtT7ZDLc1dlYrv/3piHHF/GGPTfLCSs6M/naln+9qJZXkaX0Xa5EY01KLVHqhf4ap96HlDPjcJ9mAmAfWWBavdLAdAGf24Uqr8EqyK3Y1VkNHmMvR1k+VzV1icrsz5EQ/opgwd5zgNG8cxbabVwbB+o2Nk3jMreR22xcrRBvVPjGMdYWDc72jBm0hfY+oy2BVm7DSl+aQbG5dQzToWgh3DalW0dtmyagLwUZISP2jYezSnhD3QMLLaUq5VjAflkRyvBiXZVXef7enroAd9cBNGi1scjS+xrrhP5bfWhbv1msrfoxZEcO2x5+OoWyVh4HsHIPn8J3Ph9P6mZFt7PaW9DQlk3QoCh6IQCXrlpUoNjK6PJN+lwQsxQVEbo6xRNVzOMgW/o+zmj6CsWkJOFNd0xZZnNmwTVUpdsPQ1xyaZTvwLN0sh+yE2/1VStAmdN6E1I2KxjOWVk5IdfYmKCe48YMT5hXez9YNYF65Ixpt6Y9bcjzxrkTEsUziMeNQm/JGkBlT4jMZTV+tBru4BHC2Ne8uQDyOUYz2C6LexCI
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR02MB10039.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953007ce-ea05-426c-989e-08dc9a0ecaf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 20:45:50.4943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aj3Jr30oM/8uY9/Q9+cvXaXEJkZxviOqt07+N/99luzE3ZLCCdZI1gUji/iqFo+LPi2/rkt+WuZQfbS1Ss7kpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8626
X-Proofpoint-GUID: hd4QHGXcX35X6Pm5XLoK2hYHxg4_APi4
X-Proofpoint-ORIG-GUID: hd4QHGXcX35X6Pm5XLoK2hYHxg4_APi4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_21,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1011 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010154

> Hi everyone,
>
> We've been trying to track down the cause of a strange TIPC failure over =
the last few weeks and have gotten stuck. Hoping that opening this up to a =
wider audience might help a bit.
>
> The scenario is as follows. We have two programs, a sever and a client, t=
hat use TIPC group communication to exchange messages.
>	- Server opens a TIPC socket and creates the group via setsockopt()
>	- Once every second, the server performs a group broadcast via send()
>	- Client opens a TIPC socket and joins the group via setsockopt()
>	- Client then waits for messages to arrive via recv()
>
> What we see happening is that as soon as the client joins the TIPC group,=
 the server's broadcast will fail from then on (either blocking on the send=
() or returning EAGAIN/EWOULDBLOCK if set to non-blocking).
>
> After adding several debug messages into the kernel code, we can see that=
 the server-side send is failing because tipc_group_bc_cong() is always ret=
urning true, instructing the broadcast code to wait as the group is congest=
ed.
> If we compare logs taken on the same machine where these programs work (m=
ore on that later, though), we see that tipc_group_bc_cong() always returns=
 false because of the following condition:
>	if (list_empty(&grp->small_win))
>		return false;

I was able to track down the actual race condition that is causing this beh=
avior. In short, there is a race between TIPC socket binding and the socket=
 joining a group as a member. Slightly updated scenario with better termino=
logy and the complete flow which turned out to be VERY important.
	1) Sender TIPC socket opens with socket(), binds it to a service with bind=
(), and creates the group via setsockopt()
	2) Once a second, this sending socket performs a groupcast send() to all m=
embers
	3) Receiver TIPC socket opens with socket(), binds it to the service via b=
ind(), and joins the group via setsockopt()
	4) Receiver socket then waits for messages to arrive via recv()

From the kernel side, the race shows up between the bind() call and the set=
sockopt() call for the receiving socket.

As part of the bind() processing, the socket/port combo is added to the TIP=
C nametable. This addition results in an event being sent out via the TIPC =
topology server in the kernel. This event message arrives at the sender-sid=
e socket as a group member event and is processed. The sender-side socket w=
ill transmit a GRP_JOIN message to the receiver-side socket as a response.
[ T1382] tipc: tipc_nametbl_publish(): publishing sk [0x46228388 : 0x566000=
4]
[ T1382] tipc: tipc_nametbl_insert_publ(): inserting sk [0x46228388 : 0x566=
0004] into service 0x46228388
[ T1382] tipc: tipc_service_insert_publ(): publishing report for service ty=
pe 0x46228388, sub lower 0x0
[ T1382] tipc: tipc_sub_send_event(): pushing event 0x6286e55c for lower 0x=
5660004, node 0x0
[ T1382] tipc: tipc_topsrv_queue_evt(): queuing work for conn 0x6286e3c0, e=
vt 0x62af5504/0x6286e55c
[   T21] tipc: tipc_conn_send_work(): handling conn 0x6286e3c0
[   T21] tipc: tipc_conn_send_to_sock(): passing TOP_SRV event 0x62af5504 f=
rom conn 0x6286e3c0
[   T21] tipc: tipc_topsrv_kern_evt(): pushing TOP_SRV message 0x62af94b0 o=
n skb 0x6305fa00 for port 0x757d95d5 from event 0x62af5504
[   T21] tipc: tipc_sk_filter_rcv(): processing RCV skb 0x6305fa00
[   T21] tipc: tipc_sk_filter_rcv(): handling tipc protocol message. sk 0x6=
23b7680, skb 0x6305fa00
[   T21] tipc: tipc_sk_proto_rcv(): passing TOP_SRV tipc message 0x62af94b0=
 from skb 0x6305fa00 for group 0x6286e9c0
[   T21] tipc: tipc_group_member_evt(): handling group member event 0x62af9=
4b0 for group type 0x46228388 ptr 0x6286e9c0, port 0xf826a8ad, and instance=
 0x5660004
[   T21] tipc: tipc_group_member_evt(): no member with port 0xf826a8ad, ins=
tance 0x5660004 yet for group 0x6286e9c0. creating 0x63112680 and posting G=
RP_JOIN
[   T21] tipc: tipc_group_update_member(): adding member instance 0x5660004=
 ptr 0x63112680  to group type 0x46228388 ptr 0x6286e9c0 small_win
[   T21] tipc: tipc_group_proto_xmit(): handling protocol tx for group type=
 0x46228388 ptr 0x6286e9c0, port 0x757d95d5
[   T21] tipc: tipc_group_proto_xmit(): member instance 0x5660004 adv adjus=
tment for GRP_JOIN. ADV_IDLE: false, ADV_ACTIVE: false
[   T21] tipc: tipc_group_proto_xmit(): queuing msg 0x622048b0 on XMIT skb =
0x6305fe00


Now the race can occur. In the good scenario, the receiver-side socket join=
s the TIPC group in the kernel via setsockopt()/tipc_sk_join(), creates its=
 local group structure, processes the notification from the send-side socke=
t and all is good. However, if the GRP_JOIN message from the sender-side so=
cket arrives before this happens, we have a problem.

Because the tsk->group element is in the receive-side socket is still NULL =
in tipc_sk_proto_rcv(), tipc_group_proto_rcv() will drop this incoming mess=
age from the send-side socket as the receive-side socket does not yet belon=
g to any group.
[   T21] tipc: tipc_sk_filter_rcv(): handling tipc group processing. sk 0x6=
23b7680, skb 0x6305fa00
[   T21] tipc: tipc_sk_filter_rcv(): processing RCV skb 0x6305fe00
[   T21] tipc: tipc_sk_filter_rcv(): handling tipc protocol message. sk 0x6=
23b6140, skb 0x6305fe00
[   T21] tipc: tipc_sk_proto_rcv(): passing GROUP_PROTOCOL tipc msg 0x62204=
8b0 from skb 0x6305fe00
[   T21] tipc: tipc_group_proto_rcv(): no group for msg 0x622048b0

static void tipc_sk_proto_rcv(struct sock *sk,
			      struct sk_buff_head *inputq,
			      struct sk_buff_head *xmitq)
{
	struct sk_buff *skb =3D __skb_dequeue(inputq);
	struct tipc_sock *tsk =3D tipc_sk(sk);
	struct tipc_msg *hdr =3D buf_msg(skb);
	struct tipc_group *grp =3D tsk->group;
	bool wakeup =3D false;

...

	case GROUP_PROTOCOL:
		tipc_group_proto_rcv(grp, &wakeup, hdr, inputq, xmitq);


void tipc_group_proto_rcv(struct tipc_group *grp, bool *usr_wakeup,
			  struct tipc_msg *hdr, struct sk_buff_head *inputq,
			  struct sk_buff_head *xmitq)
{
	u32 node =3D msg_orignode(hdr);
	u32 port =3D msg_origport(hdr);
	struct tipc_member *m, *pm;
	u16 remitted, in_flight;

	if (!grp)
		return;


The receive-side socket will then join the group via setsockopt()/tipc_sk_j=
oin(). It will broadcast the GRP_JOIN message to the send-side socket which=
 is processed normally and receive the GRP_ADV response from it. As such, f=
rom the receive-side socket, everything looks fine.
[ T1382] tipc: tipc_sk_join(): group 0x6286e000 type 0x46228388 created for=
 sk 0x623b6140 instance 0x5660004
[ T1382] tipc: tipc_sk_join(): publishing socket 0x623b6140 instance 0x5660=
004
[ T1382] tipc: tipc_sk_join(): joining group 0x6286e000 type 0x46228388 sk =
0x623b6140 instance 0x5660004
[ T1382] tipc: tipc_group_proto_xmit(): handling protocol tx for group type=
 0x46228388 ptr 0x6286e000, port 0xf826a8ad
[ T1382] tipc: tipc_group_proto_xmit(): member instance 0x5660004 adv adjus=
tment for GRP_JOIN. ADV_IDLE: false, ADV_ACTIVE: false
[ T1382] tipc: tipc_group_proto_xmit(): queuing msg 0x622048b0 on XMIT skb =
0x6305fe00
[ T1382] tipc: tipc_group_update_member(): adding member instance 0x5660004=
 ptr 0x63112f00  to group type 0x46228388 ptr 0x6286e000 small_win
[ T1382] tipc: tipc_group_proto_xmit(): handling protocol tx for group type=
 0x46228388 ptr 0x6286e000, port 0xf826a8ad
[ T1382] tipc: tipc_group_proto_xmit(): member instance 0x5610004 adv adjus=
tment for GRP_JOIN. ADV_IDLE: false, ADV_ACTIVE: false
[ T1382] tipc: tipc_group_proto_xmit(): queuing msg 0x62af94b0 on XMIT skb =
0x6305fa00
[ T1382] tipc: tipc_group_update_member(): adding member instance 0x5610004=
 ptr 0x63112700  to group type 0x46228388 ptr 0x6286e000 small_win
...
[ T1382] tipc: tipc_sk_filter_rcv(): handling tipc protocol message. sk 0x6=
23b7680, skb 0x6305fa00
[ T1382] tipc: tipc_sk_proto_rcv(): passing GROUP_PROTOCOL tipc msg 0x62af9=
4b0 from skb 0x6305fa00
[ T1382] tipc: tipc_group_proto_rcv(): handling group message 0x62af94b0 fo=
r group type 0x46228388 ptr 0x6286e9c0 and port 0xf826a8ad
[ T1382] tipc: tipc_group_proto_rcv(): GRP_JOIN event for group type 0x4622=
8388, port 0xf826a8ad, instance 0x5660004, ptr 0x63112680
[ T1382] tipc: tipc_group_proto_rcv(): setting member instance 0x5660004 to=
 state MBR_JOINED
[ T1382] tipc: tipc_group_open(): removing member instance 0x5660004 ptr 0x=
63112680 from grp->small_win
[ T1382] tipc: tipc_group_update_member(): adding member instance 0x5660004=
 ptr 0x63112680  to group type 0x46228388 ptr 0x6286e9c0 small_win
[ T1382] tipc: tipc_group_proto_xmit(): handling protocol tx for group type=
 0x46228388 ptr 0x6286e9c0, port 0x757d95d5
[ T1382] tipc: tipc_group_proto_xmit(): member instance 0x5660004 in MBR_JO=
INED/PENDING state for adv adjustment
[ T1382] tipc: tipc_group_proto_xmit(): member instance 0x5660004 adv adjus=
tment for GRP_ADV. ADV_IDLE: true, ADV_ACTIVE: false
[ T1382] tipc: tipc_group_proto_xmit(): queuing msg 0x628770b0 on XMIT skb =
0x6305fc00
...
[ T1382] tipc: tipc_sk_filter_rcv(): handling tipc protocol message. sk 0x6=
23b6140, skb 0x6305fc00
[ T1382] tipc: tipc_sk_proto_rcv(): passing GROUP_PROTOCOL tipc msg 0x62877=
0b0 from skb 0x6305fc00
[ T1382] tipc: tipc_group_proto_rcv(): handling group message 0x628770b0 fo=
r group type 0x46228388 ptr 0x6286e000 and port 0x757d95d5
[ T1382] tipc: tipc_group_proto_rcv(): GRP_ADV for member instance 0x561000=
4
[ T1382] tipc: tipc_group_open(): removing member instance 0x5610004 ptr 0x=
63112700 from grp->small_win


However, the send-side socket is stuck in a bad state. Because it never rec=
eived a GRP_ADV message from the receive-side socket as its GRP_JOIN messag=
e was dropped, the sender-side socket still sees the receiver-side socket a=
s having a small window, and thus is it is still present on the grp->small_=
win list it maintains. As such, any groupcast messages made by the send soc=
ket will always fail, despite the receiver-side socket having joined the gr=
oup properly.
[ T1380] tipc: tipc_group_bc_cong(): member instance 0x5660004 ptr 0x631126=
80 is marked as having a small window
...
[ T1380] tipc: tipc_group_bc_cong(): member instance 0x5660004 ptr 0x631126=
80 is marked as having a small window

Thanks,
Sean

