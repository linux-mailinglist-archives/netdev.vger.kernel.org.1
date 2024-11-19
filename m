Return-Path: <netdev+bounces-146212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 257E49D24A2
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 12:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A372C1F22F41
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53071C3302;
	Tue, 19 Nov 2024 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="HGqma3PV"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2090.outbound.protection.outlook.com [40.107.117.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E9C14AD1A;
	Tue, 19 Nov 2024 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014783; cv=fail; b=rIqiU0eDlqJLXpCBNMpUnGHpsfm3ePDl9e1t7T4ygM/EN1SyF91pKJLK5aRoJxMsn9MPF9STV44T/N05aMDWD9POOCPALXFiugiUiW7wkUOBXCKSoWDZDZsS64a4ATJa6BLFhLZyaoJdz5Nb6F0RDtYIXfKgJYckx8DmN+PoGik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014783; c=relaxed/simple;
	bh=ZuExnE7dIFVM0ooWwDq576xqdl4nXyPr/mp2m3nTduI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jGHO9PHH6YYCppXxO2juscV3dxuzluz8p3ZyASjg5neS58IrMtdbPh/KL5cSL12GKA3HjmxLRQCl9TGIdWz8j5UcrkfKygZXztT/adgdjvCC+LzrKHnT2CmdcmcNGU+p9sa1tQJBGhob96hdxCfvB6VVy2V2K/LsjIafHdY55TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=HGqma3PV; arc=fail smtp.client-ip=40.107.117.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qU/FwNMdrXEsRXoApVAJSZ60mncBZEuiZJxQXAEWBWCS1CHzUAaIGl3MAsY6MVKQmTykbeXc/0gXLfzly9ZM+1B007/kncVbsql/mzAIvgHalQ6q3XyIlJgWHWU8IHi+9zfhLE4ZLv0kMN9Fznae4XAfADdBihMBF3bpuSEQAedNKIcZ6xT8nQKVrd8Zom324qtWFQuldPi7zoBeFWGFk2ckS4+NqiDXxiftCNvQuu3uT5FR+e50q8Ubp5KhyJXdA6P0R1kVG9y9+W4ZqwfqEDTf2UEP0n0UM07ZHK/SDAKUuBVpa8oiPsEYDnpAc6E64xBYbzWU7xV7vHBaDo1jPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuExnE7dIFVM0ooWwDq576xqdl4nXyPr/mp2m3nTduI=;
 b=lswt0/PY1DflY3zsJTHzP7p3MFzrIYSBUL9op8YNPNIDW8MJWBJYJtfWfMCLf0v7o71CYasHU4w/8O96eP3hkPzhvvocZIeF3qFnScoCF4deX1d0jrMTkd4qGgRmDR4deeDtReW6kIkuczEHIayrIFzd+gIlcRQCeCJCRfvYQZODwvy4VqmAcjZrf32DYx1v9LgkIcjUkErS1fkGrgDGuUcwFEoiTvgEcoCy8hCYLB9fTHd5qHX3TNsvPMw2xLVlqd4ue2hU7jxhLbrnIpYSwhemrz1K9Zc9SKDUqqHw7CrlOR8SWl+Ox76/ZNt5cvtgFLYKJr/E8PBLGbp+dFFk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuExnE7dIFVM0ooWwDq576xqdl4nXyPr/mp2m3nTduI=;
 b=HGqma3PVIMTo6wy0Hirp4pfgkdOUlOXL9RlOsZXg6QwqmCl65AeG8u13at8t+C1e0b6mFCWYRGib379AKO2rJgY3tP0DPfCRekZVOO9XaE8g+18XBPagrPgrVaZmzjhZuHq0F0H72Jk83003VdV0323A6YxiSYGLmhCmeCio4FxPBmedeT3BxktZxOqHlKiB8bKaQO5lTvUPRad+L0t+qoMMpadsF3VvdjAAYotYLifxjKPzcG8X5Kn2MFsaw+RMZzo9mKGyn8k4Sn7Q0QXuFLRDjySVnNca3PBE72IAbLJvxLvRkOD+WO+IHfXZg5oUA2/7rK1HuUTBHHYOrmTVQg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB5393.apcprd06.prod.outlook.com (2603:1096:400:203::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.12; Tue, 19 Nov
 2024 11:12:55 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8182.011; Tue, 19 Nov 2024
 11:12:55 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue6KaGOiBbbmV0LW5leHQgdjIgMS83XSBkdC1iaW5kaW5nczogbmV0OiBm?=
 =?utf-8?Q?tgmac100:_support_for_AST2700?=
Thread-Topic: [net-next v2 1/7] dt-bindings: net: ftgmac100: support for
 AST2700
Thread-Index: AQHbOX9ppy0cUo2wMEKC4Ka9LFL3lbK+Oa8AgAA3U0A=
Date: Tue, 19 Nov 2024 11:12:55 +0000
Message-ID:
 <SEYPR06MB5134F0A24936226D5CD791BB9D202@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241118060207.141048-1-jacky_chou@aspeedtech.com>
 <20241118060207.141048-2-jacky_chou@aspeedtech.com>
 <10d4050b-47c8-4ba1-9c47-7fd12187186f@kernel.org>
In-Reply-To: <10d4050b-47c8-4ba1-9c47-7fd12187186f@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB5393:EE_
x-ms-office365-filtering-correlation-id: 4e2ad169-113e-4860-0db0-08dd088b1e11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?U1BlVG15cDF4THdmOG4wNi9CamxTQ2pCWVNzVXcrRllRbVdPa1Ewc0ZISjFy?=
 =?utf-8?B?bER6RVFyZTNwQXIrVGlneXpNSkVoZndCS1BvSHlzL295OTR2N0UvN0JTN1lT?=
 =?utf-8?B?R1RIUThmbDkrVE5wNXgvczQzNG01MHFJVERMODFWL2xLVDNtTWxUbXlENlNR?=
 =?utf-8?B?VjZhSHlzam1qamQzeEF0OFBmL2lpV0dtUS9UTjc2MGdHWGxkdXdVbWl2RHd1?=
 =?utf-8?B?OGtYcnU4c1dpanlYTGxZZDhxQnpxTHFja2hQazVvd283Ui94V2JEa3R3c3FC?=
 =?utf-8?B?c2JZeGV3Nk5UZC91bi9kbDNLaHZ0eE1PQ2REYWlVUHZmYVpBc0ZheXRORlpS?=
 =?utf-8?B?aHh1SVhjaUJneWxvb2xXMHUrblNtSFNCV1hSYkI1RXFkT25uUktVZDZaSjBY?=
 =?utf-8?B?SE9uYWw1R0xCbjVpbXcyTktWTWliRnU1dndOTXRmc0hLZ2poMmQzanBBVVdi?=
 =?utf-8?B?NHo5QmE1bUZqdS9DZ3RaMHNLcXhwNG1TY3IraTdTSTZBa2l5Q1NNY1hwZmgv?=
 =?utf-8?B?d3QxeGdxS3l5OERSZUJMRldaL0ovOWJ4QkJkWEp6OEY2a1VDakdHZ0dVK3R4?=
 =?utf-8?B?VkIzNkp5azUwTksxckl2b1h0WUxJWXBBUEdxUEIvOGpSK2dXVUIxTlFWK3Fj?=
 =?utf-8?B?VXNkdWRyWklSU2hxanVjdThGMXFLRU1kNWF3RG5hZHVrY1llTWVMZGQvZGgr?=
 =?utf-8?B?OFMybmpOQjNFenhrdlBmc3psWm52TitYNlVXNklLT1lMdzRlM05saEZ2QVRs?=
 =?utf-8?B?cXlKVGZNcWthbTZwa2gzMEVueEtTT3pCbVJpSmNYRUt5TlpXMjBqMmtNK3kx?=
 =?utf-8?B?NHdYU1pXY2RJazkrVS9mdEx2V1lUdzRUSGJZaG9WeHdCcFMxV1B0MGlsbFBN?=
 =?utf-8?B?ZkwyRGFQS25NbUlocURvdGEwYmNpVFZ0eEFFSTIrN3IrSGZyZXhhRUdOV3gw?=
 =?utf-8?B?NXNJT0RtYllkN1ZwbFdLK2xOcXo3Tm9ES2tjVkJNMTd4Y0Y1NTNnYmo2QWRk?=
 =?utf-8?B?eDFTeFRpaWxodGRTYjBlc1B4QTZrR2FqSitHSFJqN3dpQnVmQ0ZIYklnaUlP?=
 =?utf-8?B?eVhzbkJmZUpjQW5lVGFQZ2pzU3IrL0cxcUZEemtrTnpLbzNYNTNSZ1ZjdDRu?=
 =?utf-8?B?cm9sQ2c2WGlBYlB1L2czOGdkZmpaVVIram5MQ2VIUHRqSXl2L0pJODVvTjJQ?=
 =?utf-8?B?QjBrU1UyYVRNejdnakthUjdocG1rbzA4SGtlRUVjS3ZYQk9mWmthcm4zOHhj?=
 =?utf-8?B?QlVlbjkvNXVpNjdWVlJzSGhGYWZsWXE1NjEwR2ZsTG1GYy9ZTmh4VHpnbFBu?=
 =?utf-8?B?a054ZXZqM2xaTmp2aEV4Vk1QS2srQUVWMkUvR2tBUUlTYzgxTDZFQVZMbmg1?=
 =?utf-8?B?Ri9mWVBNK1ZkWDgwbWpmRENhcVR1anUvSEFYVUV3eWVnNW9HaUFWdmpsb2Iv?=
 =?utf-8?B?OTJkdDk4cFdmTjdFZnJlM0g3dVJOdGtqTWpJeVNrU1NVTnU5UTNrZFl2U1Ft?=
 =?utf-8?B?WVEwTTRjdktWL1RVQlZGN1ZBbEVpYnBadGZaTXRFditWUG1NYUFDVkpjZ210?=
 =?utf-8?B?ZXFycWRTQjljakNXVkI0QXY2RlZvdURVU3kzVFRaYnFoaTlnOVlZZ1ArWmtK?=
 =?utf-8?B?b1gvSWh3R1B5QjBoUGM4NzlmNHRmb1VrNnJ0aVYxOGt3SUhzQWpBYU0zY01i?=
 =?utf-8?B?ZXFENmhaTHNCcnJtTlZ5dnhHc2NBRlFJMUIyWi9SNUdzN3c1RHA5VHFBemJU?=
 =?utf-8?B?SGQzMmNQengrYTJUY0Q0ZUFFSDM1bXp4MUV3NTYrSnd6eENiNGhnSWQ5dFAv?=
 =?utf-8?B?TTNWV0FNK2xpa0lBdXZZQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZW1IejBBTjBSSVFPRWd6bWtsazlqb2VOQWZGL2ZyaFhGYzdRMzRxNnY5dklu?=
 =?utf-8?B?MjNSWnpZWllXRnp4Zlp6RzFPd0Z2Rm5vOWxkUGNwWUs4UmV6RDFpZGt4d3NZ?=
 =?utf-8?B?TEZYR1JtUWhRZDJmQS9obWhubVVlbmx2VUNVSDVJWlZ3V0J3UXBTZ0pWZm9H?=
 =?utf-8?B?TTluQzhsT0E5VElYb3gzWWVmSzdXN0g4ZHNhYUlpaHZNemN6NDdLK1pERVds?=
 =?utf-8?B?amE4UmRXTG5rcmpITEFSV2VkVkNFblVLUkp4NWxLN0VyKzROTUdZL2hIS3cy?=
 =?utf-8?B?L0dYR0pKdjlrb1FSRnRENzFROWxLMHBubTlIZU1iU00rWmJsb0RJWmpGSmhF?=
 =?utf-8?B?VWVLTWpWejViUUhnWE9FUC9jNkxnWFdHT0Zlbjd4RXRZU3l2azh0UTBCOFhi?=
 =?utf-8?B?bFdyejVGcjAvYmJxSzN6TnN1ak94Q2lhdVpXZjdTY1pNSVNjQ0hwS2xLYnBr?=
 =?utf-8?B?clNQdDFEelpOVTR6eXFmQWk3a1BJM2pnY1huVUd5NW5idm1IN2k0Z0pyaUdR?=
 =?utf-8?B?c2VzZnVjSXY4K01ScXRHbEg3R1ppY3IwQTZBOHM4QmhNbTVDMmphT1FEOE9u?=
 =?utf-8?B?ek1MYk5RUlF0aElqYVd3YVZxeVl2TGN3VjhLSVQwZ0FrOHZjYURyL3BkZUpz?=
 =?utf-8?B?dURJQU95Slp6Z1hDdG02WkEreW04Qks0S2RodUFNdnRLcmpqRGpPZzdtTkl6?=
 =?utf-8?B?S0tmenRZK1krb29ycGg5bFY1U3RYRGQ3TjJrdUVYRmNROGl3SVh1bldNY0NR?=
 =?utf-8?B?cjA3bkRiNUt5VXNRWklHTkdXYnpoa28yUmVoY3paWEpaY1BCdXA2aGJJaHdJ?=
 =?utf-8?B?L1RaNFFjMHVzUVZEbXBVcnVxaFBtUEdwSFlHT1phTnhFRDVpU3I1SlZEOXJo?=
 =?utf-8?B?R21PREltb2JRbVNmTmY3ditnY3NtNXlMVUJxMFlOcnR1clZoY21sZHVoRG1J?=
 =?utf-8?B?aGZrNkl3OGJ1SkpBNkhLUUdEZ2ZtTitYdHBSdnNkdStLUkwva0pIQnVsTXdU?=
 =?utf-8?B?amVPUHkvOWRTNzNxelI4U21wUHFqUnBmaDg2OTBwd0xXZE1uS3Q1ZGtnUjdi?=
 =?utf-8?B?VmgwcHBKalBPejFQenZjNHNPb1VuRlRSRTQ2OWFwNldWUE5WOFFGOGNWT1ht?=
 =?utf-8?B?cEhyb2FLKys1eitNU0N0SUVZMEFvTnNNeUtXSXp3RlR0NHZXTDlmUmdsVWI3?=
 =?utf-8?B?WEZMT2wvNzBWUWs0V0F3Mm9YcjV5eWlSYnd4MkJxVnJWdTlNYjBXK2JWT1RJ?=
 =?utf-8?B?ZXV2NDVaaHRONXZ1bFhkQUVsVndyMXVZQld4anJ4V2lTNHFFU3N1bmxCRkpM?=
 =?utf-8?B?b1dDS0s4NytCSVlqTXdEUDNXY3YzOWhKMm5jS1AyQW5wY3UxN29SRUUzR3o3?=
 =?utf-8?B?VjhOZ2JMSVIvbndnZkdvZnFLVFA5TmVlL0h6aW5OSlB4djM0VUVpZmxUTVlO?=
 =?utf-8?B?MjNJSWU0YmRYeDVhaFRsOFk3MlJhQ3VWUms1ZExVUEhUd1kwS05sL3dBOGhm?=
 =?utf-8?B?alRSZnIrUWdPc05qb3Q3aG5VUE1SS1NaeVdtTEdlTFd4bU8vOHNLWmJqdjlm?=
 =?utf-8?B?Q1RsTFdsRGJnV0dyQTk2Vy9nd2F4WUZMME9Kdy9RQllpSkRqbnBKNHc3SUlW?=
 =?utf-8?B?Z0NIYXl0VEQwNjNRWmlTN0lFRUVFQ2pWTFFnZDlVOHdVbjArZUFhS1p5UG5I?=
 =?utf-8?B?VnFKOFFtRkdlcWIxKytTVGl0WUtZRHU5ekhNSytLMlJrem9SME5nRFRwalg3?=
 =?utf-8?B?WE9tSlpuQnMwOWRsYWtDUmlISTVSQmw5bVRlWHNsdVBnTzVnaHBNVnIxc3Rn?=
 =?utf-8?B?VjQ5aG1WVVNWYTEzb21RUXZZc3BTUWEvdUN4SllXUXhHYnJueXdNell4VE04?=
 =?utf-8?B?aUY5a2swd3hQaGkwdzEvb2dHT2kzVHZBQnJLdGsyQXRHTWc4UXI5QW1QZnhy?=
 =?utf-8?B?VVR6V1NmaE50VG1xWU1oUi9FcmFiODRBc1h4eklIVHUzNW1aZmJmdVJRamk2?=
 =?utf-8?B?UUR4anBxbWsrYU5HdXoya3FrbWMxWVg2MlBwN0tRQ0ZYMHpFQXFEaEVqeGZS?=
 =?utf-8?B?QW1TQnY5azN0ZkdSQUJ5VGw1RGdRZXh0WXc2NDk4azd3SmZ3NW9EcWtuMGlR?=
 =?utf-8?B?YSt5TElRalBvMHZjWXQ4NW8rYmVTenBCQXdQWGxDWXR1ci9qWU90bmhnSFBi?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2ad169-113e-4860-0db0-08dd088b1e11
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 11:12:55.3760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JvHFpisEUr7VpUK2Xb+fmRBhYZi/GaocxUUygbW4qnHrtOhPLYO7EJkyTqlbmMaFYT2DlkNc9fdiIJv7Pp67Ajna3JOBIrxjTuaSUeC+v2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5393

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkgYW5kIGtpbmQgcmVtaW5k
ZXIuDQoNCj4gPiBUaGUgQVNUMjcwMCBpcyB0aGUgN3RoIGdlbmVyYXRpb24gU29DIGZyb20gQXNw
ZWVkLg0KPiA+IEFkZCBjb21wYXRpYmxlIHN1cHBvcnQgZm9yIEFTVDI3MDAgaW4geWFtbC4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphY2t5IENob3UgPGphY2t5X2Nob3VAYXNwZWVkdGVjaC5j
b20+DQo+IA0KPiBQbGVhc2UgdXNlIHN0YW5kYXJkIGVtYWlsIHN1YmplY3RzLCBzbyB3aXRoIHRo
ZSBQQVRDSCBrZXl3b3JkIGluIHRoZSB0aXRsZS4gYGdpdA0KPiBmb3JtYXQtcGF0Y2ggLXZYYCBo
ZWxwcyBoZXJlIHRvIGNyZWF0ZSBwcm9wZXIgdmVyc2lvbmVkIHBhdGNoZXMuIEFub3RoZXINCj4g
dXNlZnVsIHRvb2wgaXMgYjQuIFNraXBwaW5nIHRoZSBQQVRDSCBrZXl3b3JkIG1ha2VzIGZpbHRl
cmluZyBvZiBlbWFpbHMgbW9yZQ0KPiBkaWZmaWN1bHQgdGh1cyBtYWtpbmcgdGhlIHJldmlldyBw
cm9jZXNzIGxlc3MgY29udmVuaWVudC4NCj4gDQo+IEZvciBuZXQgbmV4dCBpdCBpcyBQQVRDSCBu
ZXQtbmV4dA0KPiANCj4gPGZvcm0gbGV0dGVyPg0KPiBUaGlzIGlzIGEgZnJpZW5kbHkgcmVtaW5k
ZXIgZHVyaW5nIHRoZSByZXZpZXcgcHJvY2Vzcy4NCj4gDQo+IEl0IGxvb2tzIGxpa2UgeW91IHJl
Y2VpdmVkIGEgdGFnIGFuZCBmb3Jnb3QgdG8gYWRkIGl0Lg0KPiANCj4gSWYgeW91IGRvIG5vdCBr
bm93IHRoZSBwcm9jZXNzLCBoZXJlIGlzIGEgc2hvcnQgZXhwbGFuYXRpb246DQo+IFBsZWFzZSBh
ZGQgQWNrZWQtYnkvUmV2aWV3ZWQtYnkvVGVzdGVkLWJ5IHRhZ3Mgd2hlbiBwb3N0aW5nIG5ldyB2
ZXJzaW9ucywNCj4gdW5kZXIgb3IgYWJvdmUgeW91ciBTaWduZWQtb2ZmLWJ5IHRhZy4gVGFnIGlz
ICJyZWNlaXZlZCIsIHdoZW4gcHJvdmlkZWQgaW4gYQ0KPiBtZXNzYWdlIHJlcGxpZWQgdG8geW91
IG9uIHRoZSBtYWlsaW5nIGxpc3QuIFRvb2xzIGxpa2UgYjQgY2FuIGhlbHAgaGVyZS4gSG93ZXZl
ciwNCj4gdGhlcmUncyBubyBuZWVkIHRvIHJlcG9zdCBwYXRjaGVzICpvbmx5KiB0byBhZGQgdGhl
IHRhZ3MuIFRoZSB1cHN0cmVhbQ0KPiBtYWludGFpbmVyIHdpbGwgZG8gdGhhdCBmb3IgdGFncyBy
ZWNlaXZlZCBvbiB0aGUgdmVyc2lvbiB0aGV5IGFwcGx5Lg0KPiANCj4gaHR0cHM6Ly9lbGl4aXIu
Ym9vdGxpbi5jb20vbGludXgvdjYuNS1yYzMvc291cmNlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9z
dWJtaQ0KPiB0dGluZy1wYXRjaGVzLnJzdCNMNTc3DQo+IA0KPiBJZiBhIHRhZyB3YXMgbm90IGFk
ZGVkIG9uIHB1cnBvc2UsIHBsZWFzZSBzdGF0ZSB3aHkgYW5kIHdoYXQgY2hhbmdlZC4NCj4gPC9m
b3JtIGxldHRlcj4NCj4gDQo+IEkgYW0gbm90IGdvaW5nIHRvIGRvIHRoZSB3b3JrIHR3aWNlLg0K
DQpJIHdpbGwgbm90aWNlIHRoZXNlIGFuZCBhZGp1c3QgaW4gbmV4dCB2ZXJzaW9uLg0KDQpUaGFu
a3MsDQpKYWNreQ0KDQo=

