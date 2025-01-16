Return-Path: <netdev+bounces-158817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CBFA13626
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB100167006
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AAA1D88AC;
	Thu, 16 Jan 2025 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="21uXjAGM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B85F1A08BC;
	Thu, 16 Jan 2025 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737018374; cv=fail; b=OwmqE3AS7g4y/LaOQyQKVvDFZBSixe/KCh7hyQo0qDpRmkuGlqXcYFuymmhSEV/aDSCPgDsM3B0ZqGlKisQrZp69d9pOlEDDv/44WivGO/aLL4IMXQ9zETvW+P6znX7Y8YpGKeb9eutS6XKs1xoR7kBv1F3E+z/NA4BhGCyqKgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737018374; c=relaxed/simple;
	bh=R7J78bKfk7MGpr0Xc6eUWCyeXLOVDrTc7nB/93mWMUc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sYhBV3/9A0Fq4b2k6oJErWPt/vXn5FvH4pptUnifGcfTyqvK3L9IQ2ZvTEQB1IlUwXikDoKlFeSe9Lp2mKsgfO2NplgYd9XcBnx5UC62vOyY/1Mxtr9ETShOcan62ooeG0xrJm3nBAzzc3+MH7+C6JFyIPGZ7UD9kfgIu01MNMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=21uXjAGM; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOv4YKnUy4H3inah8kQOZLiVUDBeOdsmHPSv5pXVtN8i0CR1zhn5OyeeeaB7bOuShJG51xAQk821/YXhzRYdLq5Thu6eenY80utCOM+FRNAiv4WTpoGz6N44UghoeeLB2ZWZJwlfC5jxDDQ9+J2VgVqT/6FHoaHVn6BRAiAfh4TRHtl86Ks1NomodZ2RfJEmfr4N5OUYaRH1iQHPdOBR/AprbzO/eiy/T/O1WytujuoNHks5NNW1qqNqXCk7ZC+JZD/tdCHmpAJdN2SHG6//IxQ/sCqLlsTNxkWNKxwOmv2nRgngIUUH9fgYr6FrkD7jw8U/IJW7dObhe4UD0YfkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7J78bKfk7MGpr0Xc6eUWCyeXLOVDrTc7nB/93mWMUc=;
 b=hiANxs1fo3xlo9iQjHRfnfYXiTI/4+m/bdJehdsk5xNEY5oP+nN5G+nhxiyK/uxzw+PaS5UW3UhCjADdupnn+RCxCSCSA4haROPQOKbQiY5i3JRsJmLX29weQhoaBYsP3OrzUavRBpCVNwsAUwBi67ue8IwddHWP6+vpsqHuuasPEj6jmQLm3zptt5XihqdQYJGBI7dyr3GKxqleBj2WtD61EaMFN64Qlc2kdh8oRnRZUXKgyLh2gyaJhwslnIXwPQjb5LhYNgJFWQGkYdaFuBx0m7JROUbF+azUWHFqneGk1WqsyYKCbEsHRoEWcpmM4BGgjepINvrSKfIbajBw3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7J78bKfk7MGpr0Xc6eUWCyeXLOVDrTc7nB/93mWMUc=;
 b=21uXjAGMvMzfPIqVBlgoI7mEDndmc53cpPVBrp5RHfHOQklXuRJbyxojgjrSgQ/fP7rLj1YN2CsqZBxMweHZzdBgGgaQM2iastWoIC7OVJ9TER0mFrwf70eoLUaGImHuChDoy4pQu6msaGzfiviP6ALSwD7UH5dJWEk17noAaetw6xmsG1Uq3hzWz5aPRZwV2quCT5Y1pY+TfonCzlXXd5MRh1yl5e/oTbFbL6oLnVFSg6vu0+B0KfAURDwLuNzk+4fEXCWnguJbS4sE+mWN6W+r/k9dYzpIArwzCyCnpMrvdLv+MG5BOdP9xZtGOzy4OiBD4emxUMihDogxGQeMSg==
Received: from SA3PR11MB8047.namprd11.prod.outlook.com (2603:10b6:806:2fc::22)
 by SA1PR11MB8840.namprd11.prod.outlook.com (2603:10b6:806:469::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 09:06:09 +0000
Received: from SA3PR11MB8047.namprd11.prod.outlook.com
 ([fe80::a585:a441:db24:b547]) by SA3PR11MB8047.namprd11.prod.outlook.com
 ([fe80::a585:a441:db24:b547%6]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 09:06:09 +0000
From: <Arun.Ramadoss@microchip.com>
To: <tharvey@gateworks.com>
CC: <andrew@lunn.ch>, <davem@davemloft.net>, <olteanv@gmail.com>,
	<Woojung.Huh@microchip.com>, <linux-kernel@vger.kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<UNGLinuxDriver@microchip.com>, <kuba@kernel.org>
Subject: Re: [PATCH net] net: dsa: microchip: ksz9477: fix multicast filtering
Thread-Topic: [PATCH net] net: dsa: microchip: ksz9477: fix multicast
 filtering
Thread-Index:
 AQHbTPIJzdKXH8nrm0ChagGLPbp9HLLjUxUAgAALoYCAFyxhAIAJ+K+wgBJGLgCAAojZgA==
Date: Thu, 16 Jan 2025 09:06:09 +0000
Message-ID: <55858a5677f187e5847e7941d62f6f186f5d121c.camel@microchip.com>
References: <20241212215132.3111392-1-tharvey@gateworks.com>
	 <20241213000023.jkrxbogcws4azh4w@skbuf>
	 <CAJ+vNU2WQ2n588vOcofJ5Ga76hsyff51EW-e6T8PbYFY_4xu0A@mail.gmail.com>
	 <20241213011405.ogogu5rvbjimuqji@skbuf>
	 <CAJ+vNU3pWA9jV=qAGxFbE4JY+TLMSzUS4R0vJcoAJjwUA7Z+LA@mail.gmail.com>
	 <PH7PR11MB8033DF1E5C218BB1888EDE18EF152@PH7PR11MB8033.namprd11.prod.outlook.com>
	 <CAJ+vNU3sAhtSkTjuj2ZMfa02Qk1rh1-z=1unEabrB8UOdx8nFA@mail.gmail.com>
In-Reply-To:
 <CAJ+vNU3sAhtSkTjuj2ZMfa02Qk1rh1-z=1unEabrB8UOdx8nFA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB8047:EE_|SA1PR11MB8840:EE_
x-ms-office365-filtering-correlation-id: e4e41855-3517-439e-647d-08dd360d0476
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8047.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bzJ0VlpFODVwNGlucVBMYXovNGtlb3NHSTlyY3F5NWsxQzcxOVdTNHBPZm5a?=
 =?utf-8?B?RWVZL2c5bkIrZjdjY25vQ3JEeGpwS29CWmZGSlYzR0ppd21zb3lhdTdqSnNT?=
 =?utf-8?B?ZzJrb0V4bzF6VzUyTlFIUmJnVUxCbHRsVjFqWTFuc3haUXpXdTZvdEF5T045?=
 =?utf-8?B?cEx4VUZOc2hnRS9DN2dzcUVRN1llYkRDY2lZWUQ5aHlHZGQ0cFlLNmlCTXdR?=
 =?utf-8?B?K0tlUEZ5b2pCRVh0YjBlRDhtVlpnczBWT25kaCtxV1BncnBrQ0JEb2l3dzQw?=
 =?utf-8?B?dHZ6TDJGODViYWordGp1cWx1RDdCT1NSZmV5c05neVdKcENJVDRvUHV5ZDJU?=
 =?utf-8?B?OXh5SHJqeDZMcjlEMkJxb21BQ3BFb2QweUNZbHQrNDRVdjBrSmFFNGVJbGxE?=
 =?utf-8?B?QkM1bjhIUkRxakFZY1Frd3A2dWVOUURuK1lWUkJ6M3RxamVyd1JTTEorb2Uz?=
 =?utf-8?B?eVp0L3VwVElYQ1RaUzU2YlpPU0dxUEpuZGZqNTAxeTNYVWU2UUtpa3hxTnF3?=
 =?utf-8?B?OWIzTlBEQmlzcktLQVU3d2l2dVlSMlMxanorb2tjQXhaUkE1QTAzZG9vTmhN?=
 =?utf-8?B?Z0ZkY1MwWFRLYXc0aVlwRURWbTNuRW1Yc0J6Q3hkc0E5VFZqaHpZR2NpN0ZI?=
 =?utf-8?B?bVBDYmNTZVIxaFVzN0RiN0Z1VU9xNGtGcWhpS1drN1JHYnUxTEVmNHZIS3NW?=
 =?utf-8?B?Q2RFOHFNc0JIakJwVnNWWnJMOHNCVW9kT3VSTUlaNkdPdW55dWxCcU1TMkZ5?=
 =?utf-8?B?V2txRk54SkVmcWRKeHcxSWhZRWJMQjdiMjREU1hRbkVyR1pjTlM2aU5Xak5U?=
 =?utf-8?B?SlM5bXBmcytFRHF0eFlGWFhoSzJESWFWMG1IcEh2bWN4YUF4SFU5YzZNd0ht?=
 =?utf-8?B?SHlqZDM1dnEwOVM2VXFYR1Y2cGpiM2V6UWVDWm1venBHenJrYlRFTUlnU2dv?=
 =?utf-8?B?TEhpcXFaM0ZLbStUMW9UNHFsbHVhMEpmd3Q1bzVuNWpjYjhXT2VGZGwyS1F0?=
 =?utf-8?B?QXBnM1JLbVRYaDRLNnlkUHhWWlpMQ2NCbHZDWHFVTWRuVUtldjJtT21PeVVt?=
 =?utf-8?B?QkllNm1qaWtRYjZZNzBsSDlLUWQ3SytOcWp1M3BOVkQvQlNPVS9CSGRLNDNT?=
 =?utf-8?B?OW1UekEvNUIxSWlkVmE2cEdGanpqTVpwYjdsOEZYd1RxV2VBNUJGbHVMd3Iy?=
 =?utf-8?B?d3hRMmwyS3dOaFo2Q0Q5REhvY0YzSnVJTkhBc2l4akt5M0dhZlVSNUpPQjZC?=
 =?utf-8?B?QzdoK0o0TVZCSDFuSXBYN3ZBYXlsS0l0OXcvTWZ6UHg4Y1pKekZPUThnTFNZ?=
 =?utf-8?B?VGh1RTdjUkR5dHlZN2VmY0ZjV3N4aUZ5ZG8xcGNnZkJiV1lwK0VSM2VtdUJL?=
 =?utf-8?B?ZkVRVkcxbDVmbFArT1AwS0hzNUMwSjJLaDdxb1FLN201WTdEZ1VHQ0xQN3pH?=
 =?utf-8?B?d0hiWVJnZU81NTNMc05KWWZ4WHBJaUJSSnRhVU9QWHY5VHh2OXBtWGszWFVW?=
 =?utf-8?B?TjVsMWRjVW5Da0Fvd283ek1YU3VUQUwyLzI1QklCb1hNa09zVzJieHFZbzZF?=
 =?utf-8?B?TTNtK21yc2g4cWRoMXBNR3BmUEZSQmhUQnAxMmpZT0xRZUNqTFNGOWpLZWN5?=
 =?utf-8?B?aGMzSXlWb2IrMDEwWkFvejl2Y0ZDUXlKbjMyRTNKK0c1UVF0Y28ydzcvSWpM?=
 =?utf-8?B?SUl3SmV5WU80VWNuZjNNWlEvZWtWV0pCelhpOUVJS1R3blcwdHRZK3JYcEpR?=
 =?utf-8?B?Y0ZpNGZEOS9hYlhNUDlMUHRHK0lvYmxiMkVnSFJreUNYWWZlbzRTbmxrNklK?=
 =?utf-8?B?SzJubXozREZWL254a05wb2Y4LzhZaHhtWko5RkxNdVMvV2Zxak8wZVEwVURm?=
 =?utf-8?B?MklNdGdNSWNzSkQ5UHgxRSsvald0VEFxNlZrV3ZPbkloRVdtUGtDbkxKYWM2?=
 =?utf-8?Q?KmrfLaE7i1Pppj5WDEWq2QXGgdY19gTl?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlM2SjVpanVHbWZ2K3ByTUp5T0U3SGh2N21IQXd0eFJqQktZYTVKZG9PMmhp?=
 =?utf-8?B?YzN6R3JlQ2JLNmZTY2pRNXFrZmkrM09qVERrRWM2SE1pcUNpZld4dWZmUlZy?=
 =?utf-8?B?NUtjaGQrWkE5RXY0a3NTckhKOEVjVE1lY2NkY0xObDJPZEFzV1pFOXFNdHZr?=
 =?utf-8?B?OTFmL3FuWWxVeXVJakdwaEo4K05pTXdlN2hrbk54MVkvd0x2S0FrYlFZS05q?=
 =?utf-8?B?c1M3NkRuT1o4aUtTRmVqZ1BwR1lxcDlKbzhLSERQcUY4WjJ3c2F4L2hJOHIy?=
 =?utf-8?B?UXgyOXNxNXlEMGZKUFptcXBZR3ViaXdQWWtEaFRjZ1dqS0l0RXE1TVVkeUtC?=
 =?utf-8?B?eE5hS2N5d0srMVQ0RGl2Ykx5VXVxZnBaQlpkMkFsR1NBSDhYbjVVZWhvNFZN?=
 =?utf-8?B?K2d4bmEzcnBKUDJmb25uS0NSczdBUzF4SWNYUjMyZHR3ZUJrWUZmQWs0SGow?=
 =?utf-8?B?QWpWcDZUazBUZEVYSElDOTNNZ01IVURjbExPdDVHWVJqMmd5WVpEczlvREJy?=
 =?utf-8?B?ME9jU3lQY2h2YkltM285Rnh3elFybC96K09yV0lBdHlqL1UxVEIvSlpvYkZX?=
 =?utf-8?B?T3paQUorWkRjeW9TK2thTVg4VDM4dEtwM2FPT3hGNCtzRktnZ0F5Mi8rUUVR?=
 =?utf-8?B?NTM0QWFzVmFBMDRFY2FDOERHTCszbk5ZQzZOUzJ4RDFoWlpDaVZOaTR2V0hC?=
 =?utf-8?B?WmtXcUZteXZKRWVld2N3d2RRcHZvcUd6MVhwUEtIS05lcU51b0cweFNYc0pi?=
 =?utf-8?B?QmYxTnREaDhwYy9vQWlNNlNMLzR6bTdVSDFGejdjS0lQbElYdStZc2tmR3BM?=
 =?utf-8?B?S1FaRUVDeHRYRC9TamZIMWhZOVFGSlcycVp1SEJkTlJmOU5UUmdTRDk2SDNF?=
 =?utf-8?B?dDJWcnYvK3BzRVEyT1JRbC94OXVPdkxObitvdVAyRFBNTTZ6K2ovRTAxdjlU?=
 =?utf-8?B?VEppcDUvTXFOV2xnVk5wd3RlVFdxN3l3TzJ3bGY0UFlqOHpjeE1ueG5tZjR6?=
 =?utf-8?B?ZE10SjdlYytwY3E3NUJaOHBqRTFIZGRPdGR0NGdFUjllcnM0OGQwZkROM2dM?=
 =?utf-8?B?ejhaRzZUMVdYQjI5VDlYOUtPOVNFcmdFZ3JvN3Zlbkw0YnFPMWF1SEMxTHFX?=
 =?utf-8?B?T05McFpsMi9vZ1I2b2lLd3ZFT1dRM1dvNVhLTFFPZlk5RG03OWZMUEVqYnRo?=
 =?utf-8?B?dkdNTDNKNnN1MjdDZWVtb1FwZ0FlT2I1dC9tNGFzQWVGSG1ObC9ISzIxYlhG?=
 =?utf-8?B?eWZGWk9QUWliTGRtdnRTRGVVSkpZdVdzaG52TkZlWXAzWlRWczNqVFJab3R3?=
 =?utf-8?B?ekdrcFFBSlF0Q01ZRGJOTDBCRGMrVDZQVDBQTE9idFFWeFpnL09kLzBYS3Rm?=
 =?utf-8?B?VGtVdGFnWlpSZmxtNjB1YXcyZEZqTVB4U0g3ZVR2U0RSR0FFUHVJTWhWYlYr?=
 =?utf-8?B?Y3krNlJqR1FnZjB1Zk14bEY1ZGc2V1VOL0pyMUlEV0ZUekJZSUtxK3lXZkNV?=
 =?utf-8?B?bkZEYXA0WERSZG1GekNwc2RCRHN0QU9TajZTcXBqM04zVlNEMVZpR3dyMkRH?=
 =?utf-8?B?Z01md2p6Q3pIZnkrdStMbUVRWDlqUm00WGJRWXlDRXdJYWpHTFh6ZlJ4ZTlv?=
 =?utf-8?B?RUZIbUlHalh5aC9kRW5mUVhZb09Idm54Y2t1cTlYMGRvRUdFVG9aSmcyK2tD?=
 =?utf-8?B?bStNb09rbFlKRVlubkxDQzhHRm1nd2NNUXFrYUZVeXhBK1h0bWFkRGJRRFF6?=
 =?utf-8?B?V3JCYkRoaUNKdSs4ak80NEhKK09TWlRabGYyZm91R3JxRUxhNUpiWFNOb3lE?=
 =?utf-8?B?cnlUL0pRUmNWSEIrbTdUSkNONVZrV2ZMMEo1T2M1NkxYVFp5YWprVDVDSDNa?=
 =?utf-8?B?cTVzR1c2ZFROSzVRWTBCQURPOEpZbGczQWY5cS9jeFM0blhoazBIYXhlZDNu?=
 =?utf-8?B?Y2srRkhCN2dkMnRpTmhDVmNzT0VyODNtSlRBUWpwQmE4aXdSQ0J6TFdDOWR4?=
 =?utf-8?B?WEdHdTFtVTEzY1IwNldMQ2gxSzdRQTRuc3NqYlNrQnNQQTFyeFhjbE1FSXpU?=
 =?utf-8?B?Vm1JQ2pVWVZ3eStWQnpjZlBTSDdraTdWbzFVbjAxOXBIdmdJWnd4dk9rYnRr?=
 =?utf-8?B?MFVGZmJ3RjVJRXM1VTZLUEEwaDQ1cW8xVmdWcFJINUF0WkwrNDhJdTZYbk5R?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F03FE7D34DABB3478771E88CD9FA5E29@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8047.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e41855-3517-439e-647d-08dd360d0476
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 09:06:09.3246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bWFWUvd0KH9f0gRQQAfS6bAXUazPeKlQQVUUGd30XrnPpbwJqyp/H26zFtdD7kAYT08hnHKzwiDUobDxjCopQ3z9wQT1Hc20c/fvf6cXAUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8840

SGkgVGltLCANCg0KPiBIaSBBcnVuLA0KPiANCj4gT2ssIHRoYXQgbWFrZXMgc2Vuc2UgdG8gbWUg
YW5kIGZhbGxzIGluIGxpbmUgd2l0aCB3aGF0IG15IHBhdGNoIGhlcmUNCj4gd2FzIHRyeWluZyB0
byBkby4gV2hlbiB5b3UgZW5hYmxlIHRoZSByZXNlcnZlZCBtdWx0aWNhc3QgdGFibGUgaXQNCj4g
bWFrZXMgc2Vuc2UgdG8gdXBkYXRlIHRoZSBlbnRpcmUgdGFibGUgcmlnaHQ/IFlvdSBhcmUgb25s
eSB1cGRhdGluZw0KPiBvbmUgYWRkcmVzcy9ncm91cC4gQ2FuIHlvdSBwbGVhc2UgcmV2aWV3IGFu
ZCBjb21tZW50IG9uIG15IHBhdGNoDQo+IGhlcmU/DQoNCg0KRHVyaW5nIG15IHRlc3Rpbmcgb2Yg
U1RQIHByb3RvY29sLCBJIGZvdW5kIHRoYXQgR3JvdXAgMCBvZiByZXNlcnZlZA0KbXVsdGljYXN0
IHRhYmxlIG5lZWRzIHRvIGJlIHVwZGF0ZWQuIFNpbmNlIEkgaGF2ZSBub3Qgd29ya2VkIG9uIG90
aGVyDQpncm91cHMgaW4gdGhlIG11bHRpY2FzdCB0YWJsZSwgSSBkaWRuJ3QgdXBkYXRlIGl0Lg0K
DQpJIGNvdWxkIG5vdCBmaW5kIHRoZSBvcmlnaW5hbCBwYXRjaCB0byByZXZpZXcsIGl0IHNob3dz
ICJub3QgZm91bmQiIGluDQpsb3JlLmtlcm5lbC5vcmcuDQoNCkJlbG93IGFyZSBteSBjb21tZW50
cywNCg0KLSBXaHkgb3ZlcnJpZGUgYml0IGlzIG5vdCBzZXQgaW4gUkVHX1NXX0FMVV9WQUxfQiBy
ZWdpc3Rlci4NCi0ga3N6OTQ3N19lbmFibGVfc3RwX2FkZHIoKSBjYW4gYmUgcmVuYW1lZCBzaW5j
ZSBpdCB1cGRhdGVzIGFsbCB0aGUNCnRhYmxlIGVudHJpZXMuDQoNCg0KDQoNCj4gQmVzdCBSZWdh
cmRzLA0KPiANCj4gVGltDQo=

