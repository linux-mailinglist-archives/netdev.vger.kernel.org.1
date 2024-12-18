Return-Path: <netdev+bounces-152838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D37069F5E6F
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 07:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C100188DD01
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 06:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F212E155336;
	Wed, 18 Dec 2024 06:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="RWQEUyDr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39392153828;
	Wed, 18 Dec 2024 06:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734501912; cv=fail; b=JHFE0WDLBcrxhKa8sD8GkkHuDgablCQ2Pf7+MwKsKe81lr9JVvIUMxK7FGMLdSowf7HHxThudWUroqsZ2l3AhPZXFjD6mS1fizfQe56ucc5rdjWOo+f976icEEZxufi1k5RMxjkFl/Q9YMxi4xjbHX4gmvSNdLbA1QvY0PVcq+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734501912; c=relaxed/simple;
	bh=VUCO+otsMJsEgmWJBWDBV68eylWUJAXcHgUjC/TCd8Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h/1265jpKMqugTAo4MQRtdxF5L3MhRbO+cju10gbZdp8xJQYY8DWseI3/6aeg3/nIjmeKPn9IfucRs/6Kk6hBgvjL/kO9H64ervHH4AvVGiikESvOAgZjS3Ph76S2gV2XaG/OPTjZ5BG3qL5D4iq+5JJku/ntEGIQsFknk6wMrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=RWQEUyDr; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI64cFQ002953;
	Tue, 17 Dec 2024 22:04:59 -0800
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43krtbg00w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 22:04:58 -0800 (PST)
Received: from m0431383.ppops.net (m0431383.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BI64wXI003037;
	Tue, 17 Dec 2024 22:04:58 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43krtbg00v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 22:04:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFKWEoG088uK/peIhQq3Hf/w1y3q09kr1sL7aFvJWNUS9p22ziZ/LhjveG6FheRYytesTSnytv2VdV3XbWVP5UtWPB0i/F/g/xlF/2oqM5Edv6Vtc9PMp+mEt3W1FHOpiz9iTZdq+nTkB2pkXaLN4DScdTp//+ykCXXOChWXZEjI+GgVKy+VXe4cfWXpMwLW+XiOsw9A56VqG5BHQPxH/S8mbhqcwa9zgZhJGi2vPLup02Ex/BO/iUuMvLa0Xp+AfCRPUFz2+QAfgIsmNTU+xnromu06XDvJIrl/VChh35VQohQD8oG/sGcBT9olF0qL3oLGfmsnffko9XMWWHPAIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUCO+otsMJsEgmWJBWDBV68eylWUJAXcHgUjC/TCd8Y=;
 b=JtxlzQOaeppCrNpKyZ6QgTVtiwoO/hfxc1gPgq+6eqgykA2WzdbXD+FkYU98B3KOfv8OZbe3AhJssKaSALPyQyRDkbrgQi6ZCuTXKgI38yqk8cnL7UI3yBlPDNaNiDRRfsmhJLvAdixZBPFEiOW4h7YIAUmTGr2HtLN1KF2AyNsJ2WUKE0Bteob0T/1SzulK81LxxPEVZ+QFqMKQV2IgOPO5OUn+1dbQKDlQJtJoU3Xr4KLfOJSONebOIPZR95C6oy19pjdlIbQwXddJX9CSvNknxraYAUDA/OIHqUmPFBEWx9Ie3SbRarDjJZD2fBSZc6JlgeOmHvdsJbFR4S8QYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUCO+otsMJsEgmWJBWDBV68eylWUJAXcHgUjC/TCd8Y=;
 b=RWQEUyDrbx3zaWy2j3niMmUwzAtZ7lETTNkSdcTOBSIbPjhwc98h3qH4zM5UfJMnCLZ/5MLW0cbD77Un33XeVgaNDrmj8zsh+WoAlfgCx4/AkMJOKaDO770hZeVUWyirIro8zjSvCxZQ2ERvIdRURMBT+tvPUdbzapyfQmCoTDw=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by PH7PR18MB5180.namprd18.prod.outlook.com (2603:10b6:510:15a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 06:04:55 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 06:04:55 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "error27@gmail.com" <error27@gmail.com>,
        Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
Subject: RE: [EXTERNAL] [PATCH net v2 2/2] octeontx2-pf: fix error handling of
 devlink port in rvu_rep_create()
Thread-Topic: [EXTERNAL] [PATCH net v2 2/2] octeontx2-pf: fix error handling
 of devlink port in rvu_rep_create()
Thread-Index: AQHbUEPfm5OESSRznk23YM3pALWCjrLrhMEw
Date: Wed, 18 Dec 2024 06:04:55 +0000
Message-ID:
 <CH0PR18MB43399E3C58EBC7B23FD52AD4CD052@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20241217052326.1086191-1-harshit.m.mogalapalli@oracle.com>
 <20241217052326.1086191-2-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20241217052326.1086191-2-harshit.m.mogalapalli@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|PH7PR18MB5180:EE_
x-ms-office365-filtering-correlation-id: 6d644f1b-cacd-4d74-2ee5-08dd1f29e515
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|7053199007|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?akVXbVQzQ2l6VFFKV0FzZDhiVHBkVUR3clh0aHhRemV0OVFDM2RBaWk4ZnB5?=
 =?utf-8?B?VUZ2T2RjaTErdndYVTVRbXh6THljWElyN1luOG1maVlCSjFBQlU2MzhCWXI2?=
 =?utf-8?B?NitSOU8rVVVnTmYwVjNHMmpldTlOOWpIdUw3UEZYUnZOOUhtY2dEMEJaQ3Y5?=
 =?utf-8?B?bkx3ZWh2TCs3M1NPV09HZjh3aXRuMFpnNy9VNHdBRnBXaUg5YzhPQUVRa3Rs?=
 =?utf-8?B?VElhNUw0ZTVJRjUwNEdWY1MrN29rb1RQQWtnaGd3WnkrWEhYbmFEN3lnTUZU?=
 =?utf-8?B?Q3dUV3RoQ3Ryb2NNM2Z4aEt3WThmODdva3ZlaVdGdzNaYjZQbXZUYTlSalpB?=
 =?utf-8?B?VFoyQ0RSNXk5dGZNRWE0OVVWeE5jd29aM0tEcE1iSVBhUHBlRVhzMldSa2w5?=
 =?utf-8?B?SHFSSk83YlhlcUZJWlNNTGhjZ1JQL3crZnRoTElNbHJING1PR3l5T0FQNllh?=
 =?utf-8?B?N2lkZDhDcGVJeFk4QnppZXVlaFhrVStNbEFYRHdFV0wxRktna3dJSFJmUzZx?=
 =?utf-8?B?VGRrblJRb3pGS3pnR3M0bHlONXIyT1B1YUQ4OWk2MWNPekZZK3NOYk5MS0JT?=
 =?utf-8?B?MlpWK3VFOUg5T2I4dHlGcVZUeEtmeGNTMUVrTThSV015UnB2b1NINWthVnFw?=
 =?utf-8?B?UC9aVjdYSjNvVGRPNEcySFRGSk51dXpjU2tyS0hOWUhZNXhvTTBpRWJtMFZW?=
 =?utf-8?B?N1NZekh6OHBEckVDSVpScjBQMUZmc2dHWHozSktPMk92R1ZqT0hIa05QRkxi?=
 =?utf-8?B?ampHV1UycHl1OGNvcDBjY05kemlpSHp2eVFFMXZBbTIvRFZtU3RLMFJyYldI?=
 =?utf-8?B?bXRRTXJUUWpzZGZ1bGpSTGtTaDBYNVZtc3dWSUhqTHRYMmFOQ1B0KzQ3U21v?=
 =?utf-8?B?WkVGejU4U2IwVEtZMDVadmxDVmVFMitCRkdYZzNrRko2RVczSFVaQUFaVGNt?=
 =?utf-8?B?SU5JU29nbG9ZQ1lNVDFJelRLbFFEL1ZXM2h1ZHRPck5RTVpsZ09lcFpHelh5?=
 =?utf-8?B?d3pGV1daSzkxUVFHaCtQTHdkQnBKNTlaZ3RkZitaekluVWhUNjZaamU5dWRj?=
 =?utf-8?B?V29RUFp2SFBoWE1qalF2Ym1YN2JDV1JscVVtWjZCUEUvZ091dXBwTG9aOEFV?=
 =?utf-8?B?ZEdZYlNEeXhwYVdHY2FocnAzSUxCandHKzVnSkU3Y3pvN3V0cVJ5TldLeFBr?=
 =?utf-8?B?OHhGeFVWR1phRVBScDlDSmg0UzVUMUFIanliNXE2V2RDcTVFU09OL05wWUw0?=
 =?utf-8?B?aWRnUDVYRUlNcnBjUFpweDVNcExDTTBPY2xpQmJHY1d1UERJSXd4ZlJ5Mlpv?=
 =?utf-8?B?RkJpNU9GRGZoSWVDU0ZMRDdKUVVFYzBTZ2R5TTE4VTNoamlVNVNnQU80MG1O?=
 =?utf-8?B?ZGkxTHQ5L1BBT1k4cjE3YXY1SzRpbzBPU1pkbXpLbUhjUUdCUXJuSnlreExK?=
 =?utf-8?B?Tkd1aTkzVmpHc28wYzMwTG5mNTBaR3NHVmFyY1J5RnJ5TURNWThZdlpBS3Np?=
 =?utf-8?B?ci9tMFkwOGxJUWdjdXdGK1kxRHptUkR5dUFOQ2hXSEZ1WVUxWGt3RndBcWU1?=
 =?utf-8?B?UnFXS0RFNXlXRE9hdXdtNUpsWFZNNGEzMWJSaGxjNFRFYkx2QUdsZVl3Z3dT?=
 =?utf-8?B?aWRmZGNac0NUSk92WkhXWWFWVlF4Umg1dHJHMExuaEhjZ2IwZVNjVUpyZXo5?=
 =?utf-8?B?UXhVQUxBMGZuOXZqeFhmbGsvTmFqeVc1TlUyYUgwSStIWWk5YktoMUlUdFFk?=
 =?utf-8?B?ZE9PNHlzbzZwdHo3eTh0TWllYVE5SUJ2c1NQNDJsMFpQOHNKMmUycEcrOGxI?=
 =?utf-8?B?MXVpK1NidVdVNmxuNWlUa2xjcGlxWW5vV1QxZ1ZZV05RUzVuT2dBQ1ZKbVBK?=
 =?utf-8?B?ZFI4a2lNQzdyVWM3VVRTSzRSeis3ZHRhNk5FREdMbWZTbmEyNTB4VmViS2Er?=
 =?utf-8?Q?D1KtXasmiHlgN47nauyvz+Eog6U0+tND?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(7053199007)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eStwaTNnaG8zR0oyWTlVMmo1aHZaTXdhM2g0czBQMkxKeWJ4OWozVnpBdERi?=
 =?utf-8?B?ZEdXUHVYbUJ4dmZKOU9zZ0theHBMbVNRa3YvVTVGMzl0WTVaQUdFelU1SGJk?=
 =?utf-8?B?Q1NxRXpEU2QzUExSNmxLSlFLak12enk1dXpnYm50QnBVTFJ4MnFGUG02UzJw?=
 =?utf-8?B?eDllelBDWExNLzdCRUJIUEoxYWVXKzIzU09tb1JodEFtUDFlMVBNR3VFcGMz?=
 =?utf-8?B?eHhPWDJnUEVOM0V0czhlZTUwRDRzSUNjeUR0QU1RZFFqTjd6VUMrSjRnakZy?=
 =?utf-8?B?UnJOOTdGNGhsWGVnR0JZK3lRZ1BsSVdiSWE1SlJiL2dwWFJUdlpzRDIxOS8y?=
 =?utf-8?B?SHFZaUgxTkZaR1ZvN0l0eExRc3RkUG93UVhaaGFOTUVvQVdORmFPNFhPSHY1?=
 =?utf-8?B?endFS2QrNWRqMythU0YzcFowRzhRM3FiMjZ1YUhRMFRDd2lrRnpQZnMrUzAv?=
 =?utf-8?B?d2dxdGtyelFISE5yTE44Wi9kZ3FpREJwdm5nbzhHYjY1Zk5BWUV2YmlJNGw4?=
 =?utf-8?B?MTYvb0Fsc1ljNmY3Y2ZWWE5LSHdkOVM0bkNaREVzU1BiK0ZWSzRaTnlSZE81?=
 =?utf-8?B?YlhsY2NrT1MyeHhha1ppVUwxUE9Ld0h1OCsxdS9ENytVaHBHVHZvY2s2Mm1a?=
 =?utf-8?B?RGt6TlpyKzJiVFJsV3djTzBZK3ZjdkcrTTZSVkU2OStaQVBRVmlDZkwzYUY0?=
 =?utf-8?B?Ti90UDZIQ1pheWYrVzdOTGIrVmgwMTdXdXBJaGoxUUcwNG83bW5INkM0eStU?=
 =?utf-8?B?V2RBdUpnZmV6UDhjYnRBUTBiNGVBTmlIaXhiZ0NrL056Y05WdHZxMENjbVNk?=
 =?utf-8?B?WmZscUtjazNvTzZVMTZzVGV1TTl0R1NMWUdES2FHR2xMWm1SbU5GRXlIWEN6?=
 =?utf-8?B?T2poMXJmVnNvNW1mM2FHd09IV3J2OEkvcHI0aGRKWkdMMm91WEdia3ROTEps?=
 =?utf-8?B?NGRHYVQ5eGN2T0x3VU1Wek5vOVpwb1dXMlAxQUZVZkJHaWZ5czNsWitIV3lk?=
 =?utf-8?B?Q1VnZzBGbXhGMDQ5NDBDQ2xZRnl0a3hKYjUyRUZQODNYMVpGaXMraDFpUmdJ?=
 =?utf-8?B?eDJxeEMxMHhEM0FYeDI3SllNYjI3WE1wVWpMSXFmaUhFR1RqaGNVRG9YS1NK?=
 =?utf-8?B?eHhhL0hYa1ZqNUUwOUZQUklNNTFCUy9raVB6NitibDhKNzYxZTdqM1NDRUV6?=
 =?utf-8?B?QnBjUkJRYTFORUVRVWVjVzR1VWN5NmRCMHdadDZZVkNwc3NseVVxaGIxaXJn?=
 =?utf-8?B?c0ZYK1YxN1JieFUwN0w2ekhPd2orN1JDTUtvZEVVb0lpajZGSzU5WFEwNEFY?=
 =?utf-8?B?dUVDcDRuZDZJbWFZYzgrV1NMcG1QVlZHV3Vuc1FxOGorVXVLbFM1bWpUcHIy?=
 =?utf-8?B?cjBaZFpYaVdyaGlVRENBZTh0b0NDdW5XRDRIdUI2cDlZSGxjNVI2REVwVWRF?=
 =?utf-8?B?azl4SkVrdVpoQ2U5cURsTFBHMTZmZ08xTWdBOVVZUnNxaWx0Zy9hdVd3bmdj?=
 =?utf-8?B?VUZ3Snc4MS8zbHpDWVZsZWF2NkdSM1duRU1ta3dtQVA2UVZHd050aTRyeWFt?=
 =?utf-8?B?ZmtPbjVQc24vajVJeHdvSms1MkpJN3NDd2Z6OENUV2ZxeVlxU2ZuczYydWc3?=
 =?utf-8?B?RTEzR3o3R2JhR3lRdnBzQkRkZU1qNnd1WDhjbE5WNTZZaEZ4d055WDY3MVNS?=
 =?utf-8?B?dXZhYnhWSm14YkdaMkpLQ0pWNmtwQjR1WUdSOXhaWkhBcGxXbzBneDFLeHJl?=
 =?utf-8?B?VTl4cHhGUGZ4MkgzelY4WW5uNDRFNURoemRFNVZscnEwOVFhTFhhbVlGY0N1?=
 =?utf-8?B?ZDZaZk5aOW1OMzZIZmhMa3p3QUwxbmF5UWhVU3hLUkIzMlBUOXYxSGFPaktr?=
 =?utf-8?B?MEpML0hpZW91YklEOWlYRkZ6RXVFSnk1UjlGVnV6U3ZLNUdaa1Q1Q0EwbnVs?=
 =?utf-8?B?MWFxTURqRytRSW95RWQrdXpZd2NERnZsVG43SFFlR1ZzNXQzNHV6R1hKcWc5?=
 =?utf-8?B?QWpWcWViZm1uRlhkUW9vQm5Qa2xndmM0NGwxZ0s1RXR2d05aZ0ZkUUkyOWpH?=
 =?utf-8?B?anNCTjRBZUdwQVlGNXo1VDRXUzY2OTI4eFlaanl0UVBzTlpHWk4zUjRCUzA3?=
 =?utf-8?B?c3I5Z1RhZ3dtR1dwWGFYTXFRYzZvVit5L0Y1VVVMWWR2eWlKc1cwOTVHTUEr?=
 =?utf-8?Q?RszJEfpaaPI4scDus1h3MqnrpNmTokTRH2PMVdX57Dsn?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d644f1b-cacd-4d74-2ee5-08dd1f29e515
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 06:04:55.3593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJGrnyDw8IJ3K+mrcA46POlbrfVfboiq2veLSfkI2it5QLB2SpCY7t8aMoGFIasndmox5kJ5ixYcK8Gsm2Mx7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5180
X-Proofpoint-ORIG-GUID: DJxDFINd5z3H9I8C_W7gV2F78vvhsTbo
X-Proofpoint-GUID: M-HTP6XUg0lnBs_0gHc1uKCV6er0rFD2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEhhcnNoaXQgTW9nYWxhcGFs
bGkgPGhhcnNoaXQubS5tb2dhbGFwYWxsaUBvcmFjbGUuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIERl
Y2VtYmVyIDE3LCAyMDI0IDEwOjUzIEFNDQo+VG86IFN1bmlsIEtvdnZ1cmkgR291dGhhbSA8c2dv
dXRoYW1AbWFydmVsbC5jb20+OyBHZWV0aGFzb3dqYW55YSBBa3VsYQ0KPjxnYWt1bGFAbWFydmVs
bC5jb20+OyBTdWJiYXJheWEgU3VuZGVlcCBCaGF0dGEgPHNiaGF0dGFAbWFydmVsbC5jb20+Ow0K
PkhhcmlwcmFzYWQgS2VsYW0gPGhrZWxhbUBtYXJ2ZWxsLmNvbT47IEJoYXJhdCBCaHVzaGFuDQo+
PGJiaHVzaGFuMkBtYXJ2ZWxsLmNvbT47IEFuZHJldyBMdW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4u
Y2g+OyBEYXZpZA0KPlMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpl
dCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47DQo+SmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9y
Zz47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IFNpbW9uDQo+SG9ybWFuIDxob3Jt
c0BrZXJuZWwub3JnPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+a2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPkNjOiBkYW4uY2FycGVudGVyQGxpbmFyby5vcmc7IGtlcm5lbC1qYW5p
dG9yc0B2Z2VyLmtlcm5lbC5vcmc7DQo+ZXJyb3IyN0BnbWFpbC5jb207IGhhcnNoaXQubS5tb2dh
bGFwYWxsaUBvcmFjbGUuY29tOyBQcnplbWVrIEtpdHN6ZWwNCj48cHJ6ZW15c2xhdy5raXRzemVs
QGludGVsLmNvbT4NCj5TdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBuZXQgdjIgMi8yXSBvY3Rl
b250eDItcGY6IGZpeCBlcnJvciBoYW5kbGluZyBvZg0KPmRldmxpbmsgcG9ydCBpbiBydnVfcmVw
X2NyZWF0ZSgpDQo+DQo+VW5yZWdpc3RlciB0aGUgZGV2bGluayBwb3J0IHdoZW4gcmVnaXN0ZXJf
bmV0ZGV2KCkgZmFpbHMuDQo+DQo+Rml4ZXM6IDllZDAzNDNmNTYxZSAoIm9jdGVvbnR4Mi1wZjog
QWRkIGRldmxpbmsgcG9ydCBzdXBwb3J0IikNCj5SZXZpZXdlZC1ieTogUHJ6ZW1layBLaXRzemVs
IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPlNpZ25lZC1vZmYtYnk6IEhhcnNoaXQg
TW9nYWxhcGFsbGkgPGhhcnNoaXQubS5tb2dhbGFwYWxsaUBvcmFjbGUuY29tPg0KPi0tLQ0KPnYx
LT52MjogIEFkZCBSLkIgZnJvbSBQcnplbWVrDQo+LS0tDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0
L21hcnZlbGwvb2N0ZW9udHgyL25pYy9yZXAuYyB8IDEgKw0KPiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykNCj4NCj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVs
bC9vY3Rlb250eDIvbmljL3JlcC5jDQo+Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29j
dGVvbnR4Mi9uaWMvcmVwLmMNCj5pbmRleCA5ZTNmY2JhZTVkZWUuLjA0ZTA4ZTA2ZjMwZiAxMDA2
NDQNCj4tLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvcmVw
LmMNCj4rKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvcmVw
LmMNCj5AQCAtNjkwLDYgKzY5MCw3IEBAIGludCBydnVfcmVwX2NyZWF0ZShzdHJ1Y3Qgb3R4Ml9u
aWMgKnByaXYsIHN0cnVjdA0KPm5ldGxpbmtfZXh0X2FjayAqZXh0YWNrKQ0KPiAJCWlmIChlcnIp
IHsNCj4gCQkJTkxfU0VUX0VSUl9NU0dfTU9EKGV4dGFjaywNCj4gCQkJCQkgICAiUEZWRiByZXBy
ZXNlbnRvciByZWdpc3RyYXRpb24NCj5mYWlsZWQiKTsNCj4rCQkJcnZ1X3JlcF9kZXZsaW5rX3Bv
cnRfdW5yZWdpc3RlcihyZXApOw0KPiAJCQlmcmVlX25ldGRldihuZGV2KTsNCj4gCQkJZ290byBl
eGl0Ow0KPiAJCX0NCj4tLQ0KPjIuNDYuMA0KQWNrLg0KVGhhbmtzLg0K

