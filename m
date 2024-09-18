Return-Path: <netdev+bounces-128817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBF697BCC1
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 15:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C691C22792
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 13:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1905618A6CA;
	Wed, 18 Sep 2024 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qsc.com header.i=@qsc.com header.b="fmTj5tn3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-160.mimecast.com (us-smtp-delivery-160.mimecast.com [170.10.129.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D09918A6AB
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726664807; cv=none; b=u8G8+v2MuLqZpYoandD78+uWSMksztgDW1475+Zzgrq343eeLJ32pO0XFo5EYLaKDHYUUtIQ8xLmuRRlJ+LKjADCM3YdTtgNrJT4w+1E8jMChCdy6CM+qdtUhqOkLL3Nw2vu10xCTFdZS0TLveIVTAOtS6FuaRnWZhFtk69ftxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726664807; c=relaxed/simple;
	bh=SDhmHDgWHgi8NlIt/LOJZ+iaNYg3Kko9VsJbF9AtmfQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=r3j4WcQh7fYVDnaP8hqFaS6NpGM84LhsTbWNFIjVJn6KBVgJZiaWBlmB0pZ4TBShv6ZeCwlszBORhURN4mQHmrJ2R0QJeEgPO6koXih2O4Dm10mvrzkpc5xh8OZ1jq4peGBqUZMoVpZrug6Tnj0CPV/dpuBkQht8ytpm4eWjL4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qsc.com; spf=pass smtp.mailfrom=qsc.com; dkim=pass (1024-bit key) header.d=qsc.com header.i=@qsc.com header.b=fmTj5tn3; arc=none smtp.client-ip=170.10.129.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qsc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qsc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qsc.com; s=mimecast20190503;
	t=1726664803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SDhmHDgWHgi8NlIt/LOJZ+iaNYg3Kko9VsJbF9AtmfQ=;
	b=fmTj5tn3qvxIU4gqu7ycqyEknBj/+AXf0Ck6hdyIHfwVzR2Ufo3gV1j3pkajOApmq4qO5v
	swWpX5NkiWlSSIG/jMFWaObNEdiU1NiCbSYeusq4xv2iFDWzIdj2HHmlDZ/ciGjpcN7oSp
	HEkaE9xjeXvXTbKijq0crxxXVeqJ4+M=
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-nkHageznMiqfD0qDEeNkDw-1; Wed, 18 Sep 2024 09:06:38 -0400
X-MC-Unique: nkHageznMiqfD0qDEeNkDw-1
Received: from BLAPR16MB3924.namprd16.prod.outlook.com (2603:10b6:208:274::20)
 by IA1PR16MB5382.namprd16.prod.outlook.com (2603:10b6:208:452::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 13:06:32 +0000
Received: from BLAPR16MB3924.namprd16.prod.outlook.com
 ([fe80::b2a:30e5:5aa4:9a24]) by BLAPR16MB3924.namprd16.prod.outlook.com
 ([fe80::b2a:30e5:5aa4:9a24%7]) with mapi id 15.20.7982.016; Wed, 18 Sep 2024
 13:06:31 +0000
From: "Oleksandr Makarov [GL]" <Oleksandr.Makarov@qsc.com>
To: Eric Dumazet <edumazet@google.com>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: BUG: UDP Packet Corruption Issue with stmmac Driver on Linux
 5.15.21-rt30
Thread-Topic: BUG: UDP Packet Corruption Issue with stmmac Driver on Linux
 5.15.21-rt30
Thread-Index: AQHa5yw/Yex3DnaEcEmG8NwWlW8TpbIYsdYAgAADkNyARRMEpw==
Date: Wed, 18 Sep 2024 13:06:31 +0000
Message-ID: <BLAPR16MB3924BB32CE2982432BAE103FF0622@BLAPR16MB3924.namprd16.prod.outlook.com>
References: <BLAPR16MB392407EDC7DFA3089CC42E3CF0BE2@BLAPR16MB3924.namprd16.prod.outlook.com>
 <CANn89iL_p_pQaS=yjA2yZd2_o4Xp0U=J-ww4Ztp0V3DY=AufcA@mail.gmail.com>
 <BLAPR16MB392430582E67F952C115314CF0BE2@BLAPR16MB3924.namprd16.prod.outlook.com>
In-Reply-To: <BLAPR16MB392430582E67F952C115314CF0BE2@BLAPR16MB3924.namprd16.prod.outlook.com>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR16MB3924:EE_|IA1PR16MB5382:EE_
x-ms-office365-filtering-correlation-id: e321853d-7099-49a6-7ac9-08dcd7e2b751
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018
x-microsoft-antispam-message-info: =?utf-8?B?S2JheHM5SDFhK0x3KzdtV25GaFB2aW4wVVd5eFZiQ2k2N1lGNFhDSWd6cnBh?=
 =?utf-8?B?MFpBQ053OWlteEtOUFZoTVJCeXNITEdFQ0k3dnRBQk9qUnRub3pYYzdOUzVR?=
 =?utf-8?B?QVVaRXRTNWZKM0h4Wk1UZVJ5OWdSRjhJdmx1RDAxMDZPMnQ3MG9FaFdMZUcw?=
 =?utf-8?B?aVhmeHNEQS9hM0lNanhxUVBHYXJsZGIwdGlWWE1GbkI2TTRPMHdkU1prMXJz?=
 =?utf-8?B?eVdhc0g1VWpqcytDYnJ6OVpKTGpmSjdtZzZtT3NYaHpHN3ZpVVlncURmeERW?=
 =?utf-8?B?dXJVZjFtemZCVSthM3ErL2NBa29kemN6TzdXY1ZRN0x4cDk2azczR1gySkhm?=
 =?utf-8?B?VElvdGFYMGwxVXNRZmtlWmRhM1plL2Q1aUYxaC9vYTl1Z0Yvb3VVKzBiWEpO?=
 =?utf-8?B?UnNIRUo5UjNiM3lDT3FUa0JVaE1ZdzZYMGhQdVM5YW1VUXdsZ2JVMDNlS083?=
 =?utf-8?B?YllSbmJYcVYwU3I2cWlOWjN6WnpocExoVVRDbi9zMlVvb0pTYSszV3hYSHl4?=
 =?utf-8?B?YXR2Vy9QanlodXpKTUt6L3NzckQ5a2FCamhrUmNrNDJIZzdLUGI4QTI1eDFZ?=
 =?utf-8?B?d1lFeitGZDdTSGw0c0x5b0MwVHRwSDlCeFBWUGR6VnY5WHRsOVFlVWFnaURp?=
 =?utf-8?B?T0hLU3VrMWs4UHZ5K0I4NWtsWlEwNVFaS3BScUNxTzZmMUk3QU5CYkdsMjFW?=
 =?utf-8?B?M3h5Z1VXWElEaGFSNDd2aEpKL0J2S1pMZ0lhSXlwYXlSN1ZCNjJzdi9oeXV5?=
 =?utf-8?B?eFRTWTdpU0N1bDYxVDRkU0c5b2sxQ3Fya2xSNzVHKzNROUUvd2dZWXNLeThj?=
 =?utf-8?B?cHNBT1ZackdSWEN5OUxrSE1USTZEWGp2Mk56K1Z4SzJBY254amp2WXBnZU9h?=
 =?utf-8?B?UTNCcDk2SjJFVDc2eXY1TW1HMDZxUUswelVmdXVCZUNuQzQ5Tlk1bElTRVg2?=
 =?utf-8?B?SmdmTEl0ODlaUlpPeHcwV1ZIZjcvRWltRDAxNGs5L1ZSR2lQeFFTZzdzbGVR?=
 =?utf-8?B?THA2Y3EzaGxRdjY1S0VYcGxISjcrSGNVaDFYdXZTbmd5elZ0cHd1MGYvZGpB?=
 =?utf-8?B?aHZ2b1dtWSs0NEFnWm9sc0owcDRvdEwvT2Q3TGNVSlU2Y2RxN3ZVWnByV2RE?=
 =?utf-8?B?L3ZvQjFlclZmTE1zYWtvaDlic0l2TGNNWVYrcFJYUzh4bk05c3M4WmM2NkF0?=
 =?utf-8?B?amxUY1RBZTgwN3JMTHd1VUhrWFNiTmcvZC9XMk9sQ1RuU1NLY2hHMFpqL2RQ?=
 =?utf-8?B?NG1Gd2U0Ti81OHFnaC9rV3ViTFVrRDhFMUUrWkdKTHd6V0kxdU9jd2poNEEy?=
 =?utf-8?B?ZnYxMlhsaTFVU3dWZmR4eXVKem5QaFU0NGlZTkZWemFiaUpJYVNMSkNhTEFJ?=
 =?utf-8?B?YmdqNUpKOUF6RURUUXpFY0lMdVErNGVCZVpOZTlDOWlSWnpkcytaNzROQ0p5?=
 =?utf-8?B?VU9LZURheXZ2MGt6VDczcW8xOTNLUmFnemlZd2cyL3dSMFRObkw5SUlEM0VU?=
 =?utf-8?B?UmlQZHlIOGNzSXNrZmZHSHVidkVzUENoWVRsc0tUUmVtb0xERUowTFVKQVFV?=
 =?utf-8?B?YUUxcU03eTgvakJMTnIrUnFIL2dPc1MxdTF2OEhobERnYnY3V3IvVVBrb3JO?=
 =?utf-8?B?OFo5ZUorQ3ZCSG1IZVVUY04yQmV3eGo3Z0tjQ2xMbU5QcUZ0ODBTeEJPdlBn?=
 =?utf-8?B?dFhlNzdDOTlNS2xxOFVteHUwQm5OSTdjUHVyQ2JXeWR2Qm1NWFRCbWk3RzFj?=
 =?utf-8?B?SUJPV0FSOHBhOVEwSFFGZGMrQlhXRFMzNVJNQTBpcExONzBYc0xHMXVmNWQw?=
 =?utf-8?B?OFlNV2VDTjB5TzEwakFSRWtOQmZhN05nUFZuU1pNRHRSMVFDVkRQZFB3dk1v?=
 =?utf-8?B?LzlONWJkTE4vQ1djV3k5aVkyQkVxbU1LL2xWVjFyVThOd2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR16MB3924.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0NRQnpLeWRzYlQ5L1VsOFpSMklVTGo4VUxieXR5U1JMZUhFdVNscGFVYjVY?=
 =?utf-8?B?ZVZYYjZmRCs0ekhGalovOEVmSVprQ1JpNmRub1huTzZIV0diUkVzK044UEtN?=
 =?utf-8?B?Z2JqVVhHWnJkYkZCMFBOVXpBbjBreDJQNFdndXowQjRNNXRFK0M3UmtoZndG?=
 =?utf-8?B?dTEyOGhDTC8weHhGTTlZWitwcjQ2NWJ2WTN4Y0JzVmJ0RS9EczU2Q3dQaWZk?=
 =?utf-8?B?U3h4Y0IzQlA4cy9yU2tBSFI5M0R2YytEZDg5ZWtJdStZYlJENWluYlFYZDBv?=
 =?utf-8?B?cmUzV1pWNEE3dzBnZzlJVmRzdUdNVjBmTFIveU1UZzBiV3h4aDYxQmNmbUlJ?=
 =?utf-8?B?WGcxSWd5Q3hSWWw3Ky90ZjY4M0VtcXZVazhONi9VNjZiK1VRUnlSMG0wVVpY?=
 =?utf-8?B?SnlmRGZ3ZnRLM3FPdXJQK0tLZjJadUZRalJkVjMvemVSeWpicGx3UXNLbTh0?=
 =?utf-8?B?MlllS2pXNDc2MUx2dlBsOG5CSFNCZWRGaVZsaURQVTkvR2ZhWVNETzJ4cGEx?=
 =?utf-8?B?UXZpUWs4QVJDd1VaQ2hMeS9sQXlmcGJRMngrK0ZKS0pzKzhFeTY1YmpIemtl?=
 =?utf-8?B?cWVEbGRDU1dJcHhidk4yZ2E2bVgwaHdMM0xSR3E4eXpqVHBvRmtrNDgyVUNm?=
 =?utf-8?B?TXlEb2NvcGpRMms2YUlWQndrUE8zYS9wT3RlY1JXT2ZKMXNPcythTTNlV0xE?=
 =?utf-8?B?SWZIbmRHcC9PUElpSjMrMzI3U25ldTFDYXEzcW5kWFJKcjZkMmRDL1d3d3I2?=
 =?utf-8?B?Q0duUi9kWTBDNCtaZnBqVHpFNk8zejgrUU1HQlUyTHByR3FxKzl6RWtaaENJ?=
 =?utf-8?B?ellMWCtvNnFzN2JKS0F6emVYRExLalMyMWV0czVlclJLc1IwWTgxTDhTRUdE?=
 =?utf-8?B?ck1TRkltb3h1THhwQ3JmWTE0NElxTDBQQkNINllUeDArakZES3NvUjB0U3Vh?=
 =?utf-8?B?VEYxbGJnSkVyanRsemdaSUV1anFZQ2tqcnRKU05Gdmd6RjRVMitIVjdiQTN3?=
 =?utf-8?B?MWRmOFl4TE12NUJ0SFIySml4MjViYnNwcjBsaFI2dG1zSGNjSkFoZGFqYVFl?=
 =?utf-8?B?NVRqNFZ0ZG1ZcWZwdkJsME9MRmM3UHpsWk90OWh5a3BnRXFEZ0d6aVR5eUZD?=
 =?utf-8?B?aGV4ZnVqYitJYWc5cm1iQjI0NzUxaHFUUVVnc3I3NzdveFZTMHVNeU9RSURm?=
 =?utf-8?B?bExwRko0ZnkxWTVmNkk0cjFtQU9RWkMvdW12T2pEOFlBbzNhQlhBOHNMdVRr?=
 =?utf-8?B?aXhEa0w0RjNscDMvMm4yTHpCbFR2Y0pPQmx5TFVsalNLbzE0OGtpOTVOaUNS?=
 =?utf-8?B?c1NUMklRdGplaFdjMTkvem5aUWN1S0JIa01YblZXbUNxdTkxTnNvanM3dmFw?=
 =?utf-8?B?VlpsalVpdjdrZEhGamtzZWdmcW1TYmpMQmZyVUR6VmpVZEdjR0IxV3hUOG1k?=
 =?utf-8?B?YUNFVmRSZFRLOWxkYzEvQlZmNTVSZU5GU2RLdG01dCtFQUcySXV5ejR0bm9s?=
 =?utf-8?B?Mmk3MjcxckZVMHVRRVUzekFSSzQzZ2lrTkNFWDBqSU8zRTBobTNGL0lpMnFB?=
 =?utf-8?B?V1RBSUQvWk5aRTU2OWIvQU1IVHFyb3JXd2MzbFliL3BsekNpSWlIUTFnUEZM?=
 =?utf-8?B?c0QyYWdycWpQWmVUVkMvdEYzRDhqb3lWVHl1aDdaOHhFSXpOUHh5bUlkUjlQ?=
 =?utf-8?B?NlUrVXhVbzN0QjhmcmdiZG9EcEpDL3ZSQXpXL25QaGFneDFvQUlib1BxZzRl?=
 =?utf-8?B?MTd1eXUzTVZ1bndJS2ZaVlNnZDgreWsyUVpDM3hEY3Zhai9SOG5yWVdZYm53?=
 =?utf-8?B?dm9ORzBHQTlid2JES1R1akQ4S2RoTGlhRysxcUxzRHdPZ1JmKzlQamRPQVZt?=
 =?utf-8?B?cXlkRXhLM09mY1hMeUlva1NuV3hGR3U0K2xMRTg5ZnVzcUxMT0lyajdhRlBC?=
 =?utf-8?B?UkhMOGF2WWc4Q200RWtpejhBSm5JalU1NWtaaHpaSmVnYnhUNU9sVElMMXVH?=
 =?utf-8?B?U2ZtYTRPci9yM3pCREw0SGJMbUhDRnh3c2xhNDM0SFNvZDkySFNZSS9HWk9l?=
 =?utf-8?B?cHczakczZ1hHQmFiS0ZkVGRsQTBqZisrZ2hwMEJoTTlEY3k2cThBZkxDK1BM?=
 =?utf-8?Q?qN2tFkHNhGFR04UcHojcQBx4C?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: qsc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR16MB3924.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e321853d-7099-49a6-7ac9-08dcd7e2b751
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 13:06:31.7363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23298f55-90ba-49c3-9286-576ec76d1e38
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3LXdJUAzPViXIPAPLgSM9HmRaVsTBxk7LoLva1MmWWoUPMKwEQYQb8u50hA2xJiAcxMVw8DV3gH784SwH4BYu3IeFcpnZvrtEyKI3SJvTUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR16MB5382
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: qsc.com
Content-Language: ru-RU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQppcyB0aGVyZSBhbnl0aGluZyBJIGNvdWxkIHRyeSB0byBhZGRyZXNzIHRoaXMg
aXNzdWU/IEkgY29udGludWUgdG8gc2VlIHRoaXMgb24gIE1TQyBTTTJTLUVMIGJvYXJkIHVzaW5n
IExpbnV4IDUuMTUuMjENCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0K0J7RgjogT2xla3NhbmRyIE1ha2Fyb3YgW0dMXSA8T2xla3NhbmRyLk1ha2Fyb3ZAcXNjLmNv
bT4NCtCe0YLQv9GA0LDQstC70LXQvdC+OiA1INCw0LLQs9GD0YHRgtCwIDIwMjQg0LMuIDE3OjE2
DQrQmtC+0LzRgzogRXJpYyBEdW1hemV0DQrQmtC+0L/QuNGPOiBBbGV4YW5kcmUgVG9yZ3VlOyBK
b3NlIEFicmV1OyBEYXZpZCBTLiBNaWxsZXI7IEpha3ViIEtpY2luc2tpOyBQYW9sbyBBYmVuaTsg
TWF4aW1lIENvcXVlbGluOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1zdG0zMkBzdC1t
ZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29tOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCtCi0LXQvNCwOiBSRTogQlVHOiBV
RFAgUGFja2V0IENvcnJ1cHRpb24gSXNzdWUgd2l0aCBzdG1tYWMgRHJpdmVyIG9uIExpbnV4IDUu
MTUuMjEtcnQzMA0KDQpIaSBFcmljDQoNClRoZSBJUCB0b29sIHJlcG9ydHMgbm8geGRwIHByb2dy
YW1zIG9uIHJlY2VpdmluZyBpbnRlcmZhY2U6DQoNCiQgaXAgbGluayBzaG93IGV0aDANCjI6IGV0
aDA6IDxCUk9BRENBU1QsTVVMVElDQVNULFVQLExPV0VSX1VQPiBtdHUgMTUwMCBxZGlzYyBtcSBx
bGVuIDEwMDANCiAgICBsaW5rL2V0aGVyIDAwOjMwOmQ2OjI5OjhkOmM0IGJyZCBmZjpmZjpmZjpm
ZjpmZjpmZg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQrQntGC
OiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+DQrQntGC0L/RgNCw0LLQu9C10L3Q
vjogNSDQsNCy0LPRg9GB0YLQsCAyMDI0INCzLiAxNzowMg0K0JrQvtC80YM6IE9sZWtzYW5kciBN
YWthcm92IFtHTF0NCtCa0L7Qv9C40Y86IEFsZXhhbmRyZSBUb3JndWU7IEpvc2UgQWJyZXU7IERh
dmlkIFMuIE1pbGxlcjsgSmFrdWIgS2ljaW5za2k7IFBhb2xvIEFiZW5pOyBNYXhpbWUgQ29xdWVs
aW47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXN0bTMyQHN0LW1kLW1haWxtYW4uc3Rv
cm1yZXBseS5jb207IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZw0K0KLQtdC80LA6IFJlOiBCVUc6IFVEUCBQYWNrZXQgQ29y
cnVwdGlvbiBJc3N1ZSB3aXRoIHN0bW1hYyBEcml2ZXIgb24gTGludXggNS4xNS4yMS1ydDMwDQoN
Ci1FeHRlcm5hbC0NCg0KT24gTW9uLCBBdWcgNSwgMjAyNCBhdCAxOjQw4oCvUE0gT2xla3NhbmRy
IE1ha2Fyb3YgW0dMXQ0KPE9sZWtzYW5kci5NYWthcm92QHFzYy5jb20+IHdyb3RlOg0KPg0KPiBI
ZWxsbyBhbGwsDQo+DQo+IE9uIG15IE1TQyBTTTJTLUVMIFsxXSB0aGVyZSBpcyBhbiBFdGhlcm5l
dCBkZXZpY2UgZHJpdmVuIGJ5IHRoZSBzdG1tYWMgZHJpdmVyLCBydW5uaW5nIG9uIExpbnV4IHZl
cnNpb24gNS4xNS4yMS1ydDMwLiBJJ3ZlIGVuY291bnRlcmVkIGFuIGlzc3VlIHdoZXJlIFVEUCBw
YWNrZXRzIHdpdGggbXVsdGlwbGUgZnJhZ21lbnRzIGFyZSBiZWluZyBjb3JydXB0ZWQuDQo+DQo+
IFRoZSBwcm9ibGVtIGFwcGVhcnMgdG8gYmUgdGhhdCB0aGUgc3RtbWFjIGRyaXZlciBpcyB0cnVu
Y2F0aW5nIFVEUCBwYWNrZXRzIHdpdGggcGF5bG9hZHMgbGFyZ2VyIHRoYW4gMTQ3MCBieXRlcyBk
b3duIHRvIDI1NiBieXRlcy4gVURQIHBheWxvYWRzIG9mIDE0NzAgYnl0ZXMgb3IgbGVzcywgd2hp
Y2ggZG8gbm90IHNldCB0aGUgIk1vcmUgZnJhZ21lbnRzIiBJUCBmaWVsZCwgYXJlIHRyYW5zbWl0
dGVkIGNvcnJlY3RseS4NCj4NCj4gVGhpcyBpc3N1ZSBjYW4gYmUgcmVwcm9kdWNlZCBieSBzZW5k
aW5nIGxhcmdlIHRlc3QgZGF0YSBvdmVyIFVEUCB0byBteSBFbGtoYXJ0IExha2UgbWFjaGluZSBh
bmQgb2JzZXJ2aW5nIHRoZSBkYXRhIGNvcnJ1cHRpb24uIEF0dGFjaGVkIGFyZSB0d28gcGFja2V0
IGNhcHR1cmVzOiBzZW5kZXIucGNhcCwgc2hvd2luZyB0aGUgcmVzdWx0IG9mIGBuYyAtdSBbRUhM
IG1hY2hpbmUgSVBdIDIzMjMgPCBwYXR0ZXJuLnR4dGAgZnJvbSBteSB3b3Jrc3RhdGlvbiwgd2hl
cmUgdGhlIG91dGdvaW5nIFVEUCBmcmFnbWVudHMgaGF2ZSB0aGUgY29ycmVjdCBjb250ZW50LCBh
bmQgcmVjZWl2ZXIucGNhcCwgc2hvd2luZyBwYWNrZXRzIGNhcHR1cmVkIG9uIHRoZSBFSEwgbWFj
aGluZSB3aXRoIGNvcnJ1cHRlZCBVRFAgZnJhZ21lbnRzLiBUaGUgY29udGVudHMgYXJlIHRyaW1t
ZWQgYXQgMjU2IGJ5dGVzLg0KPg0KPiBJIHRyYWNrZWQgdGhlIGlzc3VlIGRvd24gdG8gZHJpdmVy
cy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjX21haW4uYzo1NTUzLCB3aGVyZSB0
aGUgZGF0YSBjb3JydXB0aW9uIG9jY3VyczoNCj4NCj4gYGBgDQo+IGlmICghc2tiKSB7DQo+IHVu
c2lnbmVkIGludCBwcmVfbGVuLCBzeW5jX2xlbjsNCj4NCj4gZG1hX3N5bmNfc2luZ2xlX2Zvcl9j
cHUocHJpdi0+ZGV2aWNlLCBidWYtPmFkZHIsDQo+IGJ1ZjFfbGVuLCBkbWFfZGlyKTsNCj4NCj4g
eGRwX2luaXRfYnVmZigmY3R4LnhkcCwgYnVmX3N6LCAmcnhfcS0+eGRwX3J4cSk7DQo+DQo+IGBg
YA0KDQpIaSBPbGVrDQoNCkRvIHlvdSBoYXZlIGFuIGFjdGl2ZSBYRFAgcHJvZ3JhbSA/DQoNCklm
IHllcywgd2hhdCBoYXBwZW5zIGlmIHlvdSBkbyBub3QgZW5hYmxlIFhEUCA/DQoNCg0KPg0KPiBB
ZnRlciB0aGUgZHJpdmVyIGZpbmlzaGVzIHN5bmNocm9uaXppbmcgdGhlIERNQS1tYXBwZWQgbWVt
b3J5IGZvciBjb25zdW1wdGlvbiBieSBjYWxsaW5nIGRtYV9zeW5jX3NpbmdsZV9mb3JfY3B1LCB0
aGUgY29udGVudCBvZiBidWYtPnBhZ2UgaXMgaW5jb21wbGV0ZS4gQSBkaWFnbm9zdGljIG1lc3Nh
Z2UgdXNpbmcgcHJpbnRfaGV4X2J5dGVzIHNob3dzIHRoYXQgYnVmLT5wYWdlIGNvbnRhaW5zIG5v
dGhpbmcgKG9yIHNvbWV0aW1lcyBnYXJiYWdlIGJ5dGVzKSBwYXN0IHRoZSAweGZmIG1hcms6DQo+
DQo+IGBgYA0KPiBbIDYwNi4wOTA1MzldIGRtYTogMDAwMDAwMDA6IDMwMDAgMjlkNiBjNDhkIGJm
MDggMzBiOCA2MjgwIDAwMDggMDA0NSAuMC4pLi4uLi4wLmIuLkUuDQo+IFsgNjA2LjA5MDU0NV0g
ZG1hOiAwMDAwMDAxMDogZGMwNSBiMzczIDAwMjAgMTE0MCAyNWFmIGE4YzAgNmQ1OCBhOGMwIC4u
cy4gLkAuLiUuLlhtLi4NCj4gWyA2MDYuMDkwNTQ3XSBkbWE6IDAwMDAwMDIwOiA3YTU4IDEzYzIg
MTMwOSBjYTA1IDRlNmMgMzAzMCAzMTMwIDIwM2EgWHouLi4uLi5sTjAwMDE6DQo+IFsgNjA2LjA5
MDU0OV0gZG1hOiAwMDAwMDAzMDogNmY1OSA3Mjc1IDczMjAgNzI3NCA2ZTY5IDIwNjcgNjU2OCA2
NTcyIFlvdXIgc3RyaW5nIGhlcmUNCj4gWyA2MDYuMDkwNTUxXSBkbWE6IDAwMDAwMDQwOiAzMDBh
IDMwMzAgM2EzMiA1OTIwIDc1NmYgMjA3MiA3NDczIDY5NzIgLjAwMDI6IFlvdXIgc3RyaQ0KPiBb
IDYwNi4wOTA1NTNdIGRtYTogMDAwMDAwNTA6IDY3NmUgNjgyMCA3MjY1IDBhNjUgMzAzMCAzMzMw
IDIwM2EgNmY1OSBuZyBoZXJlLjAwMDM6IFlvDQo+IFsgNjA2LjA5MDU1NV0gZG1hOiAwMDAwMDA2
MDogNzI3NSA3MzIwIDcyNzQgNmU2OSAyMDY3IDY1NjggNjU3MiAzMDBhIHVyIHN0cmluZyBoZXJl
LjANCj4gWyA2MDYuMDkwNTU2XSBkbWE6IDAwMDAwMDcwOiAzMDMwIDNhMzQgNTkyMCA3NTZmIDIw
NzIgNzQ3MyA2OTcyIDY3NmUgMDA0OiBZb3VyIHN0cmluZw0KPiBbIDYwNi4wOTA1NThdIGRtYTog
MDAwMDAwODA6IDY4MjAgNzI2NSAwYTY1IDMwMzAgMzUzMCAyMDNhIDZmNTkgNzI3NSBoZXJlLjAw
MDU6IFlvdXINCj4gWyA2MDYuMDkwNTYwXSBkbWE6IDAwMDAwMDkwOiA3MzIwIDcyNzQgNmU2OSAy
MDY3IDY1NjggNjU3MiAzMDBhIDMwMzAgc3RyaW5nIGhlcmUuMDAwDQo+IFsgNjA2LjA5MDU2Ml0g
ZG1hOiAwMDAwMDBhMDogM2EzNiA1OTIwIDc1NmYgMjA3MiA3NDczIDY5NzIgNjc2ZSA2ODIwIDY6
IFlvdXIgc3RyaW5nIGgNCj4gWyA2MDYuMDkwNTY0XSBkbWE6IDAwMDAwMGIwOiA3MjY1IDBhNjUg
MzAzMCAzNzMwIDIwM2EgNmY1OSA3Mjc1IDczMjAgZXJlLjAwMDc6IFlvdXIgcw0KPiBbIDYwNi4w
OTA1NjZdIGRtYTogMDAwMDAwYzA6IDcyNzQgNmU2OSAyMDY3IDY1NjggNjU3MiAzMDBhIDMwMzAg
M2EzOCB0cmluZyBoZXJlLjAwMDg6DQo+IFsgNjA2LjA5MDU2N10gZG1hOiAwMDAwMDBkMDogNTky
MCA3NTZmIDIwNzIgNzQ3MyA2OTcyIDY3NmUgNjgyMCA3MjY1IFlvdXIgc3RyaW5nIGhlcg0KPiBb
IDYwNi4wOTA1NjldIGRtYTogMDAwMDAwZTA6IDBhNjUgMzAzMCAzOTMwIDIwM2EgNmY1OSA3Mjc1
IDczMjAgNzI3NCBlLjAwMDk6IFlvdXIgc3RyDQo+IFsgNjA2LjA5MDU3MV0gZG1hOiAwMDAwMDBm
MDogNmU2OSAyMDY3IDY1NjggNjU3MiAzMDBhIDMxMzAgM2EzMCA1OTIwIGluZyBoZXJlLjAwMTA6
IFkNCj4gWyA2MDYuMDkwNTczXSBkbWE6IDAwMDAwMTAwOiAwMDAwIDAwMDAgMDAwMCAwMDAwIDAw
MDAgMDAwMCAwMDAwIDAwMDAgLi4uLi4uLi4uLi4uLi4uLg0KPiBbIDYwNi4wOTA1NzVdIGRtYTog
MDAwMDAxMTA6IDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAuLi4uLi4u
Li4uLi4uLi4uDQo+IFsgNjA2LjA5MDU3N10gZG1hOiAwMDAwMDEyMDogMDAwMCAwMDAwIDAwMDAg
MDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIC4uLi4uLi4uLi4uLi4uLi4NCj4gWyA2MDYuMDkwNTc4
XSBkbWE6IDAwMDAwMTMwOiAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAg
Li4uLi4uLi4uLi4uLi4uLg0KPiBgYGANCj4NCj4gSSB3b3VsZCBhcHByZWNpYXRlIGFueSBpbnNp
Z2h0cyBvciBzdWdnZXN0aW9ucyBvbiBob3cgdG8gcmVzb2x2ZSB0aGlzIGlzc3VlLg0KPg0KPiBC
ZXN0IHJlZ2FyZHMsDQo+DQo+IEFsZWtzYW5kcg0KPg0KPiAxIC0gaHR0cHM6Ly9lbWJlZGRlZC5h
dm5ldC5jb20vcHJvZHVjdC9tc2Mtc20ycy1lbC88aHR0cHM6Ly9lbWJlZGRlZC5hdm5ldC5jb20v
cHJvZHVjdC9tc2Mtc20ycy1lbD4NCg==


