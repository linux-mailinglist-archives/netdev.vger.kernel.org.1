Return-Path: <netdev+bounces-208667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2E3B0CA21
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 19:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2D318943C1
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 17:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BA12E264B;
	Mon, 21 Jul 2025 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rFuUQhTT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8417A2C08D0
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753120077; cv=fail; b=dMiOE5xfr+u+DmX+pbDIyx+6yjODB1gim6m5r1E28gduUzdoJC0cvx/QWJ64+EKVASCYv3IsWRgDeunNwHbcjYeD5pIBcWjGpN340Dpo0knO8CiN6jO6xdZqomykOSB5SRnN4omkbCm2H6sx+D7tVY8wZOW+/xzuTyCk9I04fTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753120077; c=relaxed/simple;
	bh=hAWvN2DJCqG6nGZY8spI11nhU423Fbx4P3wKcBkgT2E=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=B8qTou6QkoQ7GW7px0o2/Xao5C0HJ+byrYNOZ6o8MN0WQq4QEBFk1VHTBmwub8dLCmUoajfSDdubicOV7G5Z/ZPv/voVx6WMR2QJ+1m1G1uhVaYLDMrF/CCUCwdevsXE/KRBQpyodb+JJTBXF0cPn3G8I67SMnZIh6S1fgPacO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rFuUQhTT; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LCBigK008818
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 17:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OzH3H6
	e8IBUIXPL5GfQpO0Up3XuIu8xRQWLHOUnuiuo=; b=rFuUQhTT9a7LP7FfNOuevX
	8GkVLvA2XHkJDiP03Vlg8AdhO5ZpclHqspzFlAqGWIMrSm0WT4UhLWxvmaxgZEm8
	Lj+SdE9zaKwbopdzZRiKBsq7IYzqdXK3IFePhc5L43RS84+NzZLs1i1dq/6gch7e
	L+6HJtWSpWHqKAiM4gYNN4pfc7m8pPFRJv/27F7K91A+KwHDUSbti/znBOaK3zqd
	qtwDvsFsMg8bDogZZiq2MbjEjmMe6f2aKDpJDw35vPEQ3h+jDbN6m3YJm83l2R8+
	CPCGPxjRj63QP4aNZQOIKBIpwu2VqnFx3+yeVjEFIoolJwLQQpI8dQZh6/ZoyJ4w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805ut21td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 17:47:54 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56LHasCY010047
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 17:47:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805ut21t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 17:47:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgsPtIOTqEy5YWSbIUimR6rvIIClDDhRCHkfgzRL5UIfJr2QXJKg0lANhdELvg6u3so8GYhAyTt7rzccS8qtNuED42/GnlUIoITrsxW/YYPZEtY4j9Bez5X6UcEO9XN6Vo6RcDe0rNoaqb7A65mfzymDfx4cvLM/e0s4QwHNfJGh+FHb91AGoziTi+FliJEGuZ2QvMQczcCtH4kiPOAisntH3Tb7It7kNu4xzYc+MdKxNTiBWtr+ZLLl+1mmgf0CvTSyKYWbuQ+DK75d71qiBnP4s405VFxY9VQhQyy9h5WC0SgNzzoA3Rp/75trv+udh6zp8FS2kP0kObvwDXrTZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Me1mPWQn5mWDuW3oR5DUSNg8ZF5ZHBQ+oz8ojpc1OMI=;
 b=X0Bsi/0Ay3TfAy/I39eeqtiW2rvGaSYre4Ssbkrv6W7vtB9AoMTULy2DZUSawM/OrcFUPE9YFnvjvCeYJyeE1TvWnQqPQVCOgeNGS3mKnPW//9tDAVGEatCX6Ra/+Zno9FcB+VeIfc6R5bkwxMc3P+mTD8Oo4WkqwMiHvE8G9401Ki3shFwLwbVGAOw5abypobiJbU228uoFbQGeog7J6IK6jr3c5xqiMqz9ysadeyMJnJnncEu7p6cIo74rIXZDxNo7mEHbwcfxzX0X63gn/qy+4UPxPLFsxYDu9vOufCeHdXetz0YFP67iWXXNECeEMfz4zcVT7VJ01GbpIDsTmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by DS1PR15MB6732.namprd15.prod.outlook.com (2603:10b6:8:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 17:47:50 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 17:47:50 +0000
From: David Wilder <wilder@us.ibm.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jv@jvosburgh.net"
	<jv@jvosburgh.net>,
        "pradeeps@linux.vnet.ibm.com"
	<pradeeps@linux.vnet.ibm.com>,
        Pradeep Satyanarayana <pradeep@us.ibm.com>,
        "i.maximets@ovn.org" <i.maximets@ovn.org>,
        Adrian Moreno Zapata
	<amorenoz@redhat.com>,
        Hangbin Liu <haliu@redhat.com>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v6 7/7] bonding: Selftest and
 documentation for the arp_ip_target parameter.
Thread-Index: AQHb+CplwNRQMj38hkSi0WfLDuwVmrQ61FsAgAIGEgY=
Date: Mon, 21 Jul 2025 17:47:50 +0000
Message-ID:
 <MW3PR15MB391369040A414B4AED6F5301FA5DA@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250718212430.1968853-1-wilder@us.ibm.com>
 <20250718212430.1968853-8-wilder@us.ibm.com>
 <20250720103752.GT2459@horms.kernel.org>
In-Reply-To: <20250720103752.GT2459@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|DS1PR15MB6732:EE_
x-ms-office365-filtering-correlation-id: beafb815-b067-453f-beda-08ddc87eb656
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?A7x/ScYlqSWgfj8SGOFC8TypiTdC9Ua3PH93TsWIDWj+myyQHvhvS5PXQu?=
 =?iso-8859-1?Q?QUYdQFPOJUQizj17Qt2TA2CDQi1kJgIdmRYxRgwo5cTo8Q1AyqLKXlBZDM?=
 =?iso-8859-1?Q?Lyg8t3FL4r0ehbYaTiWEmve6Rfzn4veGSEK6PHRXnyMjXitxcQdIm5clwe?=
 =?iso-8859-1?Q?9lVM1cOlZeax/TYVVHWQ8BHP8Zy7FlOZ6h4QkEDWZkIMAmw05nECyUxjQs?=
 =?iso-8859-1?Q?vs3hXgiz0ZgJCkUKdYwZvWmJX8HtC0ydnOs6FE7jBSlmcT/PJJ8TyMQS9q?=
 =?iso-8859-1?Q?zRcdN7x8f2bVcmJHXPqgFfSvFjy0O9ydgtOaSkSyu1ZSzPDduNdYq1Ct7+?=
 =?iso-8859-1?Q?ErVAF/GMd66OJ+cxaAV72/PU2WAvnhsh//5KNpTUX1y3OCza3Bj8UCI8Jw?=
 =?iso-8859-1?Q?Jhp15RlLEVUv5HlBPcqYwXajP9hYAltcqfisXwd+TxPm+odY5AouZT4nk/?=
 =?iso-8859-1?Q?2NL0fxPtjyVfizU5tAjUvmRw/trnvilXnELNtEVLT4phOouoqkzRzEwm5f?=
 =?iso-8859-1?Q?+5mitAB0kQNs/iXCEuo4TYlbbJcG6fqfi+Fp7lIvTvrDfqRE8rNF/PDLbI?=
 =?iso-8859-1?Q?cPPhLgN7ft+fdwFogV7KygZ/ZRBVno2rgO2NgEktnpHII8vVG+/W44Eyjt?=
 =?iso-8859-1?Q?uh6EQf+SWvZ4av9XexMi7tDDVirqNMh+EYD2xYwJO/xNslOmS3AfjyESip?=
 =?iso-8859-1?Q?sNJwmO7eSYh0w1nNmMSq7cYO0fZBUlY+I2zB/qdFe1meJbqpo9811/nVHS?=
 =?iso-8859-1?Q?gkdMhg4fa3ihptNb31ugPzQvj6oVG0N/ONYZ+H55mBGd6jz4tFofN0Lcxy?=
 =?iso-8859-1?Q?wEmn2QZzov7tlYYPnp3gsd3CpRpXz6/4Ea5Q4EEfWpD4Gapbj77OcwXTZZ?=
 =?iso-8859-1?Q?BcAFIBWNnKh94BHmxQJ+G+HF/JT4NUFcy1/5Egb9APugnjFtSWrhUhpLMA?=
 =?iso-8859-1?Q?D2G6Lx/FGJm5MSBoPNxOtFfc1LAtPcK8yPXk6FhXgxGpA8tG35BRb5xXM1?=
 =?iso-8859-1?Q?Ql03YkM6VmKDzlR+sYkJp4rEQjAakSGXrOjkPzzM+XCZoVA173bG3VRdBL?=
 =?iso-8859-1?Q?xctuP5WrA82ewF8+pTqEfiXCPmazg4g78wq5GUOLnxvgOolfw7vkdvw6zz?=
 =?iso-8859-1?Q?+iVGpx7JyxQj463GWfenY9XhQlYcI5OeCvZu1HjEq3Ialbum/clG+9OM55?=
 =?iso-8859-1?Q?w/OhoB3OIO+jpgkbBak8XQH/Wd/k1QyB2k1/o/ec7KzLiKqbwKjsRdxTke?=
 =?iso-8859-1?Q?v7JEEqpd/QRBt1VrwNVn6pIVSozSsURYnJNvz0bebxyEAqMsfP7hqwRkwZ?=
 =?iso-8859-1?Q?QjVQljQeZyagFBtkqKpVClcdqHu9RnkBVZCEB0iWKn96jZ1vsZBDdlWRmR?=
 =?iso-8859-1?Q?wg0Bwk2KbZeODc/OlwEXPDPkhHaMHuj8HmjJipHOEnEZsR3MqFx6yS/sO/?=
 =?iso-8859-1?Q?KUOuOzHFrkaUN4z/KoC8ZaXWujHS0VEqQCb8XRbiT/7xDf/NZ+r9nKmSJj?=
 =?iso-8859-1?Q?o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fHCYipI5NTKTJ+bRPEWkycDFEPFnPAGkU/Kz8OmI+mGFjnT9D+834CaRff?=
 =?iso-8859-1?Q?xplMcBqdTms1ZH05zFmDpijyhQ1AU7CaAR21jLzzvNv2DqE5NTUJKSKGbl?=
 =?iso-8859-1?Q?On9hL3S4gFXxhspIEK9Z5ZCJ2NhyuZUcW1pvtIf8FfaH0N/BB3twQ5xg9G?=
 =?iso-8859-1?Q?D/hPOAlFNWode6j3EJ+QE9yqBs3eG7qE8sFY8LmRaroGie32VkX0f6O41l?=
 =?iso-8859-1?Q?OeLm5HjGMrGTqt4JJ6p992TtoGawJvwqoOdUUhReV2n1qfRZHcySt9SBNi?=
 =?iso-8859-1?Q?yUEYMMCfBZXUo+p6TvcuDbi3fp5pX1Lw/R3Tt+ndPjAXmuV+ZIXp4Eu0z+?=
 =?iso-8859-1?Q?+oWJMlc5eW+27OE6Sg9glr1LdggrySAIR3h3hlwLk3RHpE1lYm757HPFCp?=
 =?iso-8859-1?Q?Uvdg2i/cntPXyPU+iYv4jB2034ZIZZsh0MR2glZLa016vTii9kmHCjShfy?=
 =?iso-8859-1?Q?38NjXkMwWk9zeM2vzEQpR14VwdxYqcQJzZUqs3e7S882i5c5BRT+x6jaDz?=
 =?iso-8859-1?Q?Co8Ea6Vpr1GzdtKUy0CmZ+X3TYBkTxCLP6Ds+624+am5FkRE+LR2gm6vUr?=
 =?iso-8859-1?Q?Y4r0w7R/suodkP+SWEQ4v3tFgC4UXt5VK5B6CTr2DHnAb8RrRfBSYuMQCX?=
 =?iso-8859-1?Q?Npnk2bb7mLwha53No+FTtPi7y++aB96Gd4v76JnLeLCb7VvhG2cH4i0XLg?=
 =?iso-8859-1?Q?qK3K05saO8W2I6n5sLoVLE6gmvn0toIH82xwgxHNtn314+u7SNbXup5CFJ?=
 =?iso-8859-1?Q?h4qfdB8qKwe1D3Iivo/0DVgVzRo472wwPrTL5fDQUpEgvOUuwTdq61ttuH?=
 =?iso-8859-1?Q?32l9c+sOJg5OrSNbj2OtlUPZDyCeEtYadBLLVwfNYOGxAzY7UwuxDamtG6?=
 =?iso-8859-1?Q?0kkCU1AFXD5rxBVCPMOpu6na0i91OhRj37xEiYCSgYfwo2cjXGnB016t53?=
 =?iso-8859-1?Q?Gc91zS9MD31PtFNGNx8xcvBRJH6BuZJ3ADUO08QGvas8oWtYeO4ku2/vBv?=
 =?iso-8859-1?Q?CPD8H4MClcUqRiu1ktN/PZZMfqDAYfsCTzQranVKrQptuWdIS2w9bBGDBA?=
 =?iso-8859-1?Q?fTkYtibqoUjcV5zxC+1T6i3UEChiu20FYAYfjgvOQlO3o8paxEAqnFsLmr?=
 =?iso-8859-1?Q?2RLO7murep2Y08qbt61Jkep8jIRwrIiZQG1sTirqcglx08xNI8X/rtku/W?=
 =?iso-8859-1?Q?/EHPWjyiieAFQ3px2uxcZf6ShqM5SP7OIm8lAX3iLIDKb/ibMhpHr5lbID?=
 =?iso-8859-1?Q?48smULdHvukVSKFZigE4rvsjn31fKsJawp472buSncOukpiVA1FsjrtVgO?=
 =?iso-8859-1?Q?1NZVjV5sERVTZbM+5RVk+GopGXC0zp59j+nTSQfCvAOvnxz7q+dda+gI6X?=
 =?iso-8859-1?Q?WEQlohzRSFyY9zqjZrAzNp1f9QvUdvwgDs3hO9WTYt2+yt7uiyyi6GHVfB?=
 =?iso-8859-1?Q?mqmFqHna3huuPgF2Wcqd0Kj9FfV0lJxxt1+yZGJ8MFFVLVxt/GXd3HfEeh?=
 =?iso-8859-1?Q?SrPBtMXpXv0YdXPbzASyvstBeDk7z6xMGyNB9yDmAGy61gUcb9z2adw2Fm?=
 =?iso-8859-1?Q?lMUajKhaiMEuRz7qhZ5DFXobm8osLosSMwCF/Xa/eU61zq5q/CSYMuPBJk?=
 =?iso-8859-1?Q?3x91oBJx89Fs8=3D?=
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3913.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beafb815-b067-453f-beda-08ddc87eb656
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 17:47:50.6600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SRiLn8CRAOf2d2PWljFjohxf/jhL7gN/wLfZ1Mpx195sVitpTtrWG7w8K5QLkHnbFJsAz/e7dGQla9M/tqKLSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR15MB6732
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE1NyBTYWx0ZWRfX/FPsBzonqG2A
 aoRik60SE9VV3JCC7YimefRUUHAD0vrbVmbzqimJLGUh1DP6D4+ZQ8PcfmzhVSldxlq0LY0+CK8
 uxYwSQS6KMZYF4gA1vJ779igQWFg8Mn+jIkMoNuPqVYJxOXYOlFYl+ZAucDwsZYZNeN5pGCT04H
 0Ql2KiWZjyUScYd91fh4CZqLRdXD1VrMfM0ygIKBX9toQpIe4R7s8oD48jxZUyQZLh60yFmiqkQ
 CmEgFQlKtR+UyxWht8lPntK66Mi/lX4aB/u/cqF4HXMYmByFA5oHzikXnypbdclaoU83pFTOdUr
 vZbPT4h8WgHqnZpy/iU5BFioWft/xRoGfJOy7Tr1tcjPuTLEO5QtawU27K9IgU6/oQsnZMDuZTW
 DJN2ldTaTPgObxOUnqKIivKD32FRxVprjZpV6kY7YSt7MQX2YjFDlPVBsz/206fW7LR9BUZs
X-Proofpoint-ORIG-GUID: LKDGUqboEHe5MV_eCK35nduckFmODDr9
X-Authority-Analysis: v=2.4 cv=cIDgskeN c=1 sm=1 tr=0 ts=687e7d49 cx=c_pps
 a=MPfW0GtrrVyaQwIB9FVG4Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=QtvRY4xpf1MSlWN2:21 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Wb1JkmetP80A:10
 a=H9VqmB7XAAAA:8 a=VwQbUJbxAAAA:8 a=2OjVGFKQAAAA:8 a=VnNF1IyMAAAA:8
 a=P8mRVJMrAAAA:8 a=jZVsG21pAAAA:8 a=ZIorKJXxz9Hzxp-OjtwA:9 a=wPNLvfGTeEIA:10
 a=v3k57InNul7ldpsxCyLV:22 a=IYbNqeBGBecwsX3Swn6O:22 a=Vc1QvrjMcIoGonisw6Ob:22
 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-GUID: LKDGUqboEHe5MV_eCK35nduckFmODDr9
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH net-next v6 7/7] bonding: Selftest and documentation for
 the arp_ip_target parameter.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=2
 engine=8.19.0-2505280000 definitions=main-2507210157




________________________________________
From: Simon Horman <horms@kernel.org>
Sent: Sunday, July 20, 2025 3:37 AM
To: David Wilder
Cc: netdev@vger.kernel.org; jv@jvosburgh.net; pradeeps@linux.vnet.ibm.com; =
Pradeep Satyanarayana; i.maximets@ovn.org; Adrian Moreno Zapata; Hangbin Li=
u; stephen@networkplumber.org
Subject: [EXTERNAL] Re: [PATCH net-next v6 7/7] bonding: Selftest and docum=
entation for the arp_ip_target parameter.

>On Fri, Jul 18, 2025 at 02:23:43PM -0700, David Wilder wrote:
>> This selftest provided a functional test for the arp_ip_target parameter
>> both with and without user supplied vlan tags.
>>
>> and
>>
>> Updates to the bonding documentation.
>>
>> Signed-off-by: David Wilder <wilder@us.ibm.com>
>> ---
>>  Documentation/networking/bonding.rst          |  11 ++
>>  .../selftests/drivers/net/bonding/Makefile    |   3 +-
>>  .../drivers/net/bonding/bond-arp-ip-target.sh | 178 ++++++++++++++++++
>
>Hi David,
>
>Recently we have started running shellcheck as part of our CI for Networki=
ng.
>
>Excluding SC2317, which flagges code as unreachable due to
>the structure of many sleftests, including this one, I think it is trivial
>to make bond-arp-ip-target.sh selftest-clean.
>
>As I see there will be a v7 anyway, could you take a look at doing so?
>
>  $ shellcheck -e SC2317 ./tools/testing/selftests/drivers/net/bonding/bon=
d-arp-ip-target.sh
>
>  In ./tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh l=
ine 133:
>                  if [ $RET -ne 0 ]; then
>                       ^--^ SC2086 (info): Double quote to prevent globbin=
g and word splitting.
>
>  Did you mean:
>                  if [ "$RET" -ne 0 ]; then
>
>
>  In ./tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh l=
ine 160:
>                  if [ $RET -ne 0 ]; then
>                       ^--^ SC2086 (info): Double quote to prevent globbin=
g and word splitting.
>
>  Did you mean:
>                  if [ "$RET" -ne 0 ]; then
>
>  For more information:
>    https://www.shellcheck.net/wiki/SC2086   -- Double quote to prevent gl=
obbing ...
>
>
>And sorry for not flagging this earlier.
>For some reason it seemed less clear to me the last time I checked.

Hi Simon
Thanks for flagging the shellcheck errors.  I apparently had
installed old version of shellcheck that was not flagging SC2317
or the un-quoted $RET.  After upgrading to V0.10.0. I see them now.
I fixed the $RET issue and added # shellcheck disable=3DSC2317.
Runs clean now.  I will update the test script for V7.

