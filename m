Return-Path: <netdev+bounces-143783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C916D9C4266
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 17:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A0DB2649B
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C353F1A0B15;
	Mon, 11 Nov 2024 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gkww5vZM"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33031A08D7;
	Mon, 11 Nov 2024 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731341448; cv=fail; b=GKJDtJVVpBDYAC1V8FN1+lLwW5CsDpKTFeIm6mKuGMVvqe27ovb9IJ18NCdDuNzq0j/jOr2ZiwaJXDtml8hBb7I70B/L2wunZgovNncVU/EV+MPhH9B874zEsQXiqkAtBXIhM1DHKbQnLuasi6w5qcPYWkmFgMj4I3LhjsC7MuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731341448; c=relaxed/simple;
	bh=vbPFkFSXxOI5bFo6nTWvy4Zl3JcWyLrGyoa235Aue3Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p80B1KUutT9htmZFgiCCXoJa1hXXCKZ68wSexIEtNredccLXT5iFCZeSkswpDrAtZ5x62Jt8SNWjVA+s87XtiA3EluisCZW3RxqKSKnaTtjs25vunyIZdUGTkmOgWFMaVBEjWXKs1kgFahD4rI1iMZm7RGKaTfcnvdnGKFc6Iso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gkww5vZM; arc=fail smtp.client-ip=40.107.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oydk912JP+ZQ5dkKwGlTeZySk0hh1jZ/B10qfGov/w7zxJhZWUjPSDeMvXJellVh08iJzUOxBEECkZZ+qXrdH/bL1kIhiN8FD3QLz45OcB+CGZrZqFjeVgluYiOpicwC0+Nes0Rh1hv66ikQQHF1AQrMNAfv2dU8MMikuecIdLcTBsZHR5yf3UFMx5CW3qRYquQhzunsJv7awK05BJPt3dBrrVyEV97VpEyEIItWWeBEXe1yB7AqmUaUiQJfrFMfVP1LBn9JiHcmzb5Z52w05veGKoTlDcotXbtHwwJg8JuiBKT73OMbaibS9DmtnX4YfZQROWKcz/48Yivhu48QbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbPFkFSXxOI5bFo6nTWvy4Zl3JcWyLrGyoa235Aue3Q=;
 b=seachzHR9iZ2KnaGW63o61xS7ENhDOXfABJ2eWoAsmNCT37x/c2zRc0mxPhfsiXElGbtu92Tdtu135R6Xc9odjq9VT0Easj1i9pz0Q0KVssJsvEBVPlS+/j0Wrewgk+Lj2vIG5eO3Tb06ir5vyEK+cRunSsLA1hAsQGyskxFD5kRVioSeOp38O/H+Z6TXLWdQoyCw1xcWygu9gaafeeoHFgjt+NNBM2jgHULPLcjOUGuETACmN+dgtDcfRPWJAm4Zi+n4jbVAkveoVCraqaww4NyhZELRaDKsF6+2Zv9OzBUw5DVAAGYCthuDWGFuXoRvJzHSPBpwk2JusZtAhjeWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbPFkFSXxOI5bFo6nTWvy4Zl3JcWyLrGyoa235Aue3Q=;
 b=Gkww5vZMSnCdvDxUS1IMxGRfnQif8ttYOMhW3TktUg9BtZJAM0m5v49mYEX/YpnKlHKf3gJRENQCnEXZ5P8olWwilZ41/Y2A8zMuuxnmFg54XHibrzNnhca/d6ma+tkldh5ysTw/F8ij0vSpM9cmQyFcW1MLC2FTWAJ/StHglCoEmXD8iqldZSTjmLuIV8Rnh2OInLhRifjkQ44/RkddIQ8AoPZotlayvUun0mLYY1nSuLe4bu63pMf+FEOXJcq17TSMQfbtG4rRN0wN4HPFXBqM+RUGMYAIfLgq6e+rK/5/c/5/P20A6w+DuyQEs/uPDVoT2ZKoxloRDKzOlLFSYA==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by DB9PR04MB8186.eurprd04.prod.outlook.com (2603:10a6:10:25f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 16:10:40 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 16:10:40 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH v2 net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Thread-Topic: [PATCH v2 net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Thread-Index: AQHbM96NucJF1ICp4UyDDMX2CMxvdrKxpl8ggAApWQCAAG6NEA==
Date: Mon, 11 Nov 2024 16:10:39 +0000
Message-ID:
 <AS8PR04MB88493050E61FC7F1EB18973596582@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20241111015216.1804534-1-wei.fang@nxp.com>
 <20241111015216.1804534-3-wei.fang@nxp.com>
 <AS8PR04MB8849F3B0EA663C281EA4EEE696582@AS8PR04MB8849.eurprd04.prod.outlook.com>
 <PAXPR04MB8510F82040BCB60A8774A6CA88582@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8510F82040BCB60A8774A6CA88582@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|DB9PR04MB8186:EE_
x-ms-office365-filtering-correlation-id: c869164e-e42f-4b4c-cf21-08dd026b62e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N0pieS9vYVVKRUFmU0RlVHBkVEE0dzVDTmJIU2F3cGZlUFZLSUlLYVBOcmk1?=
 =?utf-8?B?WVpTNFlYN2tRTGJMUHVhMW9Kdm9DT2hrWnBUQ3JHZVRTQWUxVnp3dEc5ajF0?=
 =?utf-8?B?OTdscVd3S1NBZkdKUjNsMlF4STRCSTA0RUxDT09TTUR6ZWV6ZzdWYkcxUW9S?=
 =?utf-8?B?d2NRODZXOHZ3eEZVMlhUVm14VlBWcWRFUERrRkxvL2VDeE9XeW8vMk9EWEl4?=
 =?utf-8?B?V2Rva1pZQ2NjNG93TGdyTlgyMFAva2ljNjVxTWZrS29vNnlOd0pCTk5BM3Rh?=
 =?utf-8?B?dkNoT0ZUWWh1RnB6c2o3OWxZbk1mVlJYYkJkaDZtQ3RpVFVSa1BsSGttQXlI?=
 =?utf-8?B?TzVqVG5ZbXl4dGNOaTJaUEE2dElHL1c4VmkyTHljQ0dqMFdqbUtIMjlMc1lI?=
 =?utf-8?B?cDhDT2lRWFordmo3SDM2b1MzbCs5WWZVTmdrc0hlOS9vaFBYQXBVN2czdG9j?=
 =?utf-8?B?M3hFK2RxSDhNMS9hSTRDNjA0SlhvNXZLN3FyZzdoZ0FRVzQzYk8yTys4cVRO?=
 =?utf-8?B?c2RmeTJLL2FZdmlYVzBDNHpXYm42UkIvZWpBZCtNVGRBbm04bllCS0sxMHlw?=
 =?utf-8?B?NHRwQklRQWJvZDh5TFk3QWZiZzFXVnlEODZOVldPdkhzeGNLS2VVWUxOZmpy?=
 =?utf-8?B?NW45UHIxK0MwV3hTazhjQllhK2pzbFhSRTNsY1czUXV4ZjBIdUtOK2IxeTRY?=
 =?utf-8?B?VGVwcFA2bXc0cTNYd2xGRTI4VS9tbURUSDFTWnhPdERBVlBXdnR6OTh1V1VL?=
 =?utf-8?B?QmNiU25wMXloRE5sN0JjQ0tINllYaUJXYWU4RkRuU2FGTUxwMTdIZjBYT2Uv?=
 =?utf-8?B?bXNqSWZhd2hRdkxveFBDR21jMWdvVVVNZXRDNmwyUDJuaEpDR3BZVFMvbWNv?=
 =?utf-8?B?ZVNia1VWcG9tTmlNTytJZUZaRktlbzRZUEFzbUYxdmlJN1JvOVFNbDZLNEVS?=
 =?utf-8?B?VWFpY3pKbkZzbzJzZW81a2dFMVpQc1I4QTkvVVVUVWNta21RQ3JOV2tpeEFD?=
 =?utf-8?B?SjN5TGtxd0FzRUJjT2hwK0hFZlV6bjJCVGkvTnh2MUU3Z0pucjVWbEs1TGdZ?=
 =?utf-8?B?c25LTmtEZnlVK1dKNEZhWTU0NG96TW1ieDIrZUhiTEFjMURuQ00rSDdLcFhE?=
 =?utf-8?B?c21qUlh5ZktDemVTS29WenZHRzZoRktjWVhNdldqZkZTWUZmakZMSnltVkJF?=
 =?utf-8?B?Vy9iNzFZSzVPMzlOMVV6QzFrSlJUaEJPckI1dTZLZVY3MDR0d2JBVEJselJD?=
 =?utf-8?B?eVh1cU5PZlJYbzhVNU41dC8xVmxKTC91MDVZdmY2RGZBL0ZRMndWSS9WekdH?=
 =?utf-8?B?OHlRK0RObWVEcXU1bUJVaWh6Yyt3SDdBTFgwVUtxb0YzL2ViYTlGM1FQWDVm?=
 =?utf-8?B?VUM1dDRkRWF2M3gzc2hGUWlRM2ZvdmZYdDJGeFNMSDR2U0IvYkRMZHRNVUF6?=
 =?utf-8?B?UXREY05mb2hhZEJNbVh4RlBCUFFKckpwTy8xUDJOd3J0b0dTQXE1RWxCS0J1?=
 =?utf-8?B?MUdBSWNGbG5OdGdJdzByT0d4SndXbERWZDBWcjR2SjByVnBLaDdrd0RZQmZi?=
 =?utf-8?B?VWNnS0w4cXU3RlB1S2dWWWxrSmFwUVMrTDlBak9XT3JtWFZFUmdPSzVqaXNI?=
 =?utf-8?B?UHNpTlpCOHo2RTNGblVDdU1uMytKQzU2ZEFGbGQzeFNzQitYUkhIUWkvZVlB?=
 =?utf-8?B?U0RzZ2lqSWVmU01xeWt1VXN0QXRVNXpWQUxLb3hyYjRzOFdadEROQW1VQkJz?=
 =?utf-8?B?V3FlSXRUSGdLdkJjbWQ2aSt1U3VJNE10TVFMU0Q1aEZWQXA3NXhQK0pYRlVh?=
 =?utf-8?Q?xt9HDw478OvDQqoBTJzcwyce3rS+Kjs+txUB8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eEN6aG5YT2o2cnNTanRvQ2dQYjJHVjdSL2xXYmFnM0xvTThxdzFEZXhmOVlR?=
 =?utf-8?B?WjIvaU5aVTRzd1ZSbVc2WDAwbkVWZFhGSW9rN0dRbDk4R3ZaNVMrMnplTVRP?=
 =?utf-8?B?WlNUQ1YySWR3WEVrV3YweVBHNzJjYjdac0NjWWFKQjcxcEZ3NU95djhkYVk3?=
 =?utf-8?B?aW5PZk83N0FYbWVPTHBEV0tqL0NGUGRTM28wdlpYWkRNYnJEVWxmcHBLTE5L?=
 =?utf-8?B?VU1kbVhSVjQ1Y3NENCtOYWZRYVp6cmlLb2d5cE9SUmJnbUQvS2dHOFdXTFc5?=
 =?utf-8?B?d1NEd29Zc0hCaWxjS1R5SlM3ZmtCOFBFaG5rRUdnTGxXTm9tcDRQelUycFpr?=
 =?utf-8?B?NzQ3QUF4djRCN1VMS1pDalhVQWMrSXJyWndlTU56QThqUzFtZWUyNHBhKzFF?=
 =?utf-8?B?MExFWGcxVG9aVGxQZWFsMklGaUlBbmgxV25CWGV1cCtmQnRtOGU1blB0Qnc2?=
 =?utf-8?B?RGs1UlF0QThobmxySWdsS0J0T2w0V3k0SWZxdnJsM1gvTDhHWHVSUGx3TU50?=
 =?utf-8?B?WFZISTkvM1JnYitnRlJOSi9GVGZURit3RHNwN1U3T0R1bXkwdUxsRlNOeUZJ?=
 =?utf-8?B?WWo4VFE4NUd3STd0eUxhQ2pMK1laK3Z4Z3Nna0NLM05FSWZUYXBNWmo3TXA3?=
 =?utf-8?B?OEs5UnVqeG5ydk1tbSs5SExVTElGNUFhZXhEM1QwdDZnNEU2cmxSQkV3eG84?=
 =?utf-8?B?L2RYUFhEZTlXOHFXWmkxMEloeHJueUhsS2dyRGxQVnAvV2hiYzlCdkkzTEhw?=
 =?utf-8?B?MUhRSkkvMVRLcDNpY0ZHc1R6T2NZL1J1QXV4UU4vRHMreDIrV2czUjNZS3Jj?=
 =?utf-8?B?WUkvL1h0YlFkWnVXNnVtUzZGeUtYNktSMjhDSFpwdUhzak9waExkdWEwMWEz?=
 =?utf-8?B?NUk0QXBMcmQwUXdMT0hsWmZ6alEwSlUyK1UxclhMZm51eUg5T24xL3dmd3R1?=
 =?utf-8?B?UjcycHB5WUV2ckpucGdsNGwvYVlveDFreDdhekZ3alhMNVJYUnFrOG8rdDdu?=
 =?utf-8?B?bEtrOFJ5Y1BOMDlLNTVKOE03NHpiak52WTdoTmZPbWpUWGJZR0lubDE1dnR6?=
 =?utf-8?B?Uit3VG81Z1FQeEJXVjVNME1YN2ZXM0RrZE0yQ1Erb1BIWTVuYnBQdHlidjA5?=
 =?utf-8?B?amt3M052N2ZKV2poZ3RETDlEMHFoQmo5ZXZHM2N0b2UzYTViaEZTU2dXcGk1?=
 =?utf-8?B?Y2JOL3BMa3BZeC9sUWhWcnoxU3BqMkpKWmgrVXlZLzFZVVdNbDNMRU1KV245?=
 =?utf-8?B?dlRWVjZkQitsR3cvUWw2YW1QSDdPcWtmY2N3L3dsbW55bEVLZkkzS0ZEM3dM?=
 =?utf-8?B?WHQ5b3lORnQ1UVhhUEcyNmdtYk1hMnAyT1RCR2VDeThWRmg0eTZGd2RoUDRM?=
 =?utf-8?B?MHBCeCtGOHNFZThHa3pZTW4wQjh3bXJPeGUvWTRWdWJLdHd5UkgwQmxLenRn?=
 =?utf-8?B?OFZJeG0vVEdXMVQ2SnFVZVdhOXJPdDZ1YUNUYTFESE44QXZGdjJYMGNoODZ5?=
 =?utf-8?B?aUgzTS9TbTY4UTQ4RGd5Mm1ZaXltTFFpVWVJdXhqd01jYTIxNlU4Uk5YNHM2?=
 =?utf-8?B?K3lNRDFGWFdBcGFYd1B2TEh3b1plSmszNEdwOHUxUFVUQUJtSUliNXQrdnNz?=
 =?utf-8?B?MEdYKzJZbFI5Y1V1ZytnMndXTWIxQUt3emd3NmhubFNzR2hObWw1NUkvTEp4?=
 =?utf-8?B?aVAzV3NOMExtb1dzd2RJc213QTdSeVlONmE1dzNTbWFvbEtKZGVGa25yWVZQ?=
 =?utf-8?B?dGhZRjZ2bnI1YkZOMU0rN0l5M2hFbnFmK3RSd3crc25KRDh1TzdVREhDNHht?=
 =?utf-8?B?L3ZncFZXRXRCUkpOTlh5MGtnRHpjc3VKZm9xa0RYa1QvUTFwWWIyUEdQZDMx?=
 =?utf-8?B?UGRycXpUZGZDelo1T3MyQ2cvbHB4WnJsMU9RNTN1SVg0MDJFOHQwU0dHTnI4?=
 =?utf-8?B?bFR0d21JQzZEcE4xQzdGbDljQVBBU0lucEtTb240QS8za2tCTTB4U1NEREQw?=
 =?utf-8?B?RGVsbU9MWHVXbThtWkdlVlFmUFZyOVVSc3M3Sm9oM0VEQzhJclYzY0t2VTJ0?=
 =?utf-8?B?L1g4SjRBTGRYRlJwckZlTXFHRWZ0NUJMcmczdk1UNjAwLy9WMEVhWk50TnBM?=
 =?utf-8?Q?YeJw3zFSN8tQdArPGLNDW8cT0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8849.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c869164e-e42f-4b4c-cf21-08dd026b62e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 16:10:40.0305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0FYt1y5oEi2obfXbnHcFLaH+7F9o6oruP7JW11tfE6/xdyAMLHTDW/VRhOXx5c3/F7+5v7fgOoy3HvcD8bwT0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8186

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXZWkgRmFuZyA8d2VpLmZhbmdA
bnhwLmNvbT4NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAxMSwgMjAyNCAxMToyNiBBTQ0KWy4u
Ll0NCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2MiBuZXQtbmV4dCAyLzVdIG5ldDogZW5ldGM6IGFk
ZCBUeCBjaGVja3N1bSBvZmZsb2FkIGZvcg0KPiBpLk1YOTUgRU5FVEMNCj4gDQo+ID4gPiAtLS0g
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGMuYw0KPiA+ID4gKysr
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjLmMNCj4gPiA+IEBA
IC0xNDMsNiArMTQzLDI3IEBAIHN0YXRpYyBpbnQgZW5ldGNfcHRwX3BhcnNlKHN0cnVjdCBza19i
dWZmICpza2IsDQo+ID4gPiB1OCAqdWRwLA0KPiA+ID4gIAlyZXR1cm4gMDsNCj4gPiA+ICB9DQo+
ID4gPg0KPiA+ID4gK3N0YXRpYyBib29sIGVuZXRjX3R4X2NzdW1fb2ZmbG9hZF9jaGVjayhzdHJ1
Y3Qgc2tfYnVmZiAqc2tiKSB7DQo+ID4gPiArCWlmIChpcF9oZHIoc2tiKS0+dmVyc2lvbiA9PSA0
KQ0KPiA+DQo+ID4gSSB3b3VsZCBhdm9pZCB1c2luZyBpcF9oZHIoKSwgb3IgYW55IGZvcm0gb2Yg
dG91Y2hpbmcgcGFja2VkIGRhdGEgYW5kDQo+ID4gdHJ5IGV4dHJhY3QgdGhpcyBraW5kIG9mIGlu
Zm8gZGlyZWN0bHkgZnJvbSB0aGUgc2tiIG1ldGFkYXRhIGluc3RlYWQsDQo+ID4gc2VlIGFsc28g
Y29tbWVudCBiZWxvdy4NCj4gPg0KPiA+IGkuZS4sIHdoeSBub3Q6DQo+ID4gaWYgKHNrYi0+cHJv
dG9jb2wgPT0gaHRvbnMoRVRIX1BfSVBWNikpIC4uICBldGMuID8NCj4gDQo+IHNrYi0+cHJvdG9j
b2wgbWF5IGJlIFZMQU4gcHJvdG9jb2wsIHN1Y2ggYXMgRVRIX1BfODAyMVEsIEVUSF9QXzgwMjFB
RC4NCj4gSWYgc28sIGl0IGlzIGltcG9zc2libGUgdG8gZGV0ZXJtaW5lIHdoZXRoZXIgaXQgaXMg
YW4gSVB2NCBvciBJUHY2IGZyYW1lcyB0aHJvdWdoDQo+IHByb3RvY29sLg0KPiANCg0Kdmxhbl9n
ZXRfcHJvdG9jb2woKSB0aGVuPw0KSSBzZWUgeW91J3JlIHVzaW5nIHRoaXMgaGVscGVyIGluIHRo
ZSBMU08gcGF0Y2gsIHNvIGxldCdzIGJlIGNvbnNpc3RlbnQgdGhlbi4gOikNCkkgc3RpbGwgdGhp
bmsgaXQncyBiZXR0ZXIgdGhhbiB0aGUgaXBfaGRyKHNrYikgYXBwcm9hY2guDQo=

