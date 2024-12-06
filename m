Return-Path: <netdev+bounces-149561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DEE9E639A
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 02:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832C9284B25
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 01:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C491E871;
	Fri,  6 Dec 2024 01:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="jEULjxUu"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023089.outbound.protection.outlook.com [40.107.44.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49086256E;
	Fri,  6 Dec 2024 01:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733449985; cv=fail; b=XttrOCXro/5FMf2aleldVG3MwfRtZjl0FVrnlA+k8hJQ3PfpB6gESD8vT2M7zoqDhZ38lDfye4065EVPPFzykoSw++2rfER4l3ofVQT1IFi7snQR7wDLBjUywmsxaGjba3m1eIu6G1XPwKa/3loUp/g9VL9K5bGsNBOzuvbDnL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733449985; c=relaxed/simple;
	bh=FWsM1d/buy7Uhjn2nWT9spbLPz1n+e2lfkJzDK5rp6w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NC06y2IyYoxEB8h9uPTRg8n4qcXYIV12PUSVJ6pEBCgh7rO7MboUgi/khetv6ePyl4Ae3/BDAY8kdWlFHQ10lJdjnyPOspArxCu5mnjypVqSCMkQhPyCnqhYVuVK3GMt7WtukjKxWyNBzVYCxshROOusxBA+z/aF/ss5QkxmLBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=jEULjxUu; arc=fail smtp.client-ip=40.107.44.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJLiwqz0e/jir/JqkQLdePUBnU0dpR4WwqIL3ELVaBASUIL/LLkH9mMK03pIpYxiVOVTdHQYjHKPUM+7gmcofMdJLXGLUdUhD1lMpKzZ5NJMyPg7iRfQZGN7vab39ArySSpG/ncGKx1DKCgBmb2wWK+i9BdQc72JJTPmceX382YevGoY3p7Gl3I1qm+LGDiSeyUtHpfWh91E1eQXSIbylf7f8BFPkupDRCgZ6ZycHJiykKtC7eTWtdMlSqYKF61OzZe031xhTFIs1bV2sBb9cxtGyY4JUPBvJbSwC1/k0D0WrTN07PuhJ24FnWgT77Qn8rIVjTu4UVNPhG1CCKpC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWsM1d/buy7Uhjn2nWT9spbLPz1n+e2lfkJzDK5rp6w=;
 b=QDUgL3FtE1UzMv61THyvfmVqYfpE1YUsVrWhrtBT7e28PgMK35BeoMbFLHQBDSTNN0ARtHKRzbCqcF6u1DFx4OhJ85WBK9FcS1qI2h2VnnbgUSHWdOVK+KCkHxS+umXGPA+QRsUplyo64JXf7k3KrHT9ERvj+7yhwSdCyaXix0fsyPfsvj6ojSY/smBBxGPIFlNkN9yJememRzXV6HPaMIiUA4NJQiADEkdqRZ7DQKrwrQTi1NHQJEIj5SjUOWQouGhnHPxNmJk1G4F85U2JExp+o1JzA3sXW4WIQnv769goa4m5ySY9jgVajwMX/Ks8o8ob/R1ilSd4TTcppufx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWsM1d/buy7Uhjn2nWT9spbLPz1n+e2lfkJzDK5rp6w=;
 b=jEULjxUu3GegHaqcVP8/k5pSFBDlFzdYu+GoQxPblRJY68+9qjmmns+p4r96pebZ2jNHJo2b/LQR4zhpOD3lI11ue3sYNEkACESvsljJsT0cETanjUMGEm/yMDCTIHTMgfQVFeRDT1T6ZRW27Cgl8RGS4q2ddCQNCpRSimBPp8fCP4LIfLy2aX0cIBXan8hV9aAoQmpPuQd2Oq/Lh7lZKnU6ZOb3uGYuD9y5lvKdIvHmObRSmW9kJvv+Ewi5ZiVtqYa4RPX7X4Qn1lN72DnvHMQPytsMWuyHWz3avp4SIlP86ulQp+kHLxa6GvgrZpSu52atmjI1xlqxXxF/qNvXHA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SI6PR06MB7195.apcprd06.prod.outlook.com (2603:1096:4:24b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Fri, 6 Dec
 2024 01:52:56 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%5]) with mapi id 15.20.8230.000; Fri, 6 Dec 2024
 01:52:54 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Conor Dooley <conor.dooley@microchip.com>
Subject:
 =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0LW5leHQgdjQgMS83XSBkdC1iaW5kaW5nczog?=
 =?utf-8?Q?net:_ftgmac100:_support_for_AST2700?=
Thread-Topic: [PATCH net-next v4 1/7] dt-bindings: net: ftgmac100: support for
 AST2700
Thread-Index: AQHbRuY5FffynarTF0OvfHW16Ng5+rLXTm0AgAElxfA=
Date: Fri, 6 Dec 2024 01:52:54 +0000
Message-ID:
 <SEYPR06MB51343FA82DBC5F1DC4603C199D312@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241205072048.1397570-1-jacky_chou@aspeedtech.com>
 <20241205072048.1397570-2-jacky_chou@aspeedtech.com>
 <173338664470.2288815.2371095841901159008.robh@kernel.org>
In-Reply-To: <173338664470.2288815.2371095841901159008.robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SI6PR06MB7195:EE_
x-ms-office365-filtering-correlation-id: 5edaf002-846c-4d71-3568-08dd1598b394
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MDFmQ20vR29zd3N6d3JnazcyS2dtNHpuSWF2THZoMVllUTF2WmNCZEcwRWg2?=
 =?utf-8?B?U0FYVm5VU2ZLTllDcFd0NXZFTkF1TWJaMEk3NGdNZnBIbW5DdXV1Q3hORmFi?=
 =?utf-8?B?cmt4UldoYWtCbWdaVDR6WnAxNG5WaENSb0RuQTBVY1BZL0xkbXM3b0cyM0dw?=
 =?utf-8?B?Q0tyTStCNENnRmtraStwRkh0N0FtL2JuWlp1dmlmaWxHRG0wWHJNK0gvdzUr?=
 =?utf-8?B?bkx3bzJiMEt5ZFgzZGc3NS9ERk92ZHVqS3BkRllsb3JpRnk0d0NkSjR2TjJO?=
 =?utf-8?B?amdYQk93UVY5YmNTaGhBTUtJcFp2TlN4WXVPOGNRS3RvQUdkdUorMjJtUjFy?=
 =?utf-8?B?Z080T0dGZkV0VDllUllyNjQvSUo2dmE1L0NKVHVKMUdRdDUvNFFTeEgrZ2g4?=
 =?utf-8?B?SXdIeVIzWmpsY01hcG00dTUzYmRqdHQzUmdPZHhScytRMXRPdlY4emJqMzVr?=
 =?utf-8?B?OXpSY3FjZlNDQzlYbXpIdEhUbzhhVWtsOFlMOG41b0tOQWliSFpVK2pERlFL?=
 =?utf-8?B?VHE0d3pnaEhWR2NtbTZnSzlKKzVGNzdhOFRFM3BYbHRIK2hsYzlIQUxiQlhO?=
 =?utf-8?B?L1ZvZHJyeWJHa1F1ak1Fc2tzSnlQZ2h4MjROMFVYZXZ0YldlN3lYODAwSUxy?=
 =?utf-8?B?STFvQkRFUC9aUVdBUHN2M0lRTkFmVHlpQzNnZkcyNGlDeXhTWksrY2kwQnV1?=
 =?utf-8?B?Y3ZKU3lONUlGckRENlZOVWF4VnByeFFlS0l3aTNiQzlVWmxVL21lbFhaTmda?=
 =?utf-8?B?d2prWmJDQXRkazlFY0dzSU5TZ2tIM3pKSk5yOE5UOTlrSXAxaDhwU3BkbHdn?=
 =?utf-8?B?YVllK093eUVnbGd6YVJldEdlUkU1VGRUaUZVQjVrMDMxcUgrSkZMZDUrWnR0?=
 =?utf-8?B?TUx2dTcvVktVUitWbFh6SXZRY3plb2pYYnE1VkpBeTJYYWwwSTdCZXJnWnl2?=
 =?utf-8?B?eGdHQWVSMXE4cmhYdWtzdkJ2V2h2MUJmS3lWcUc4NHppRFNERUw5WWhESldO?=
 =?utf-8?B?ZFlSMGR3Z2RBSitWbFNlY3dRa2xnNmR4RllFc0l5RDVJbHU0SWhjNWM5dS9K?=
 =?utf-8?B?bkltbS83VHNkdlAxeHhmZTFiMmFnaGxmT25CZXVHcUUwczdUTUZYaC96b01w?=
 =?utf-8?B?Qy90eGRwMXNZaWpDUzN0K2lTMXRnNEtzb2dWZGtweGtSWUVJbFhpaGNuZ2Iy?=
 =?utf-8?B?SlYvbS9qbTlneHVsUjZ1cFJubTlSVkx4b01TNkMzZG5hWHZEbVNYaDJqS2xn?=
 =?utf-8?B?OGg0YTAyYXcrMGszL0Y2aDJicVlGL1pnMkdpQ3BoRXhub2ZxUnFkWHN5RDlB?=
 =?utf-8?B?TmNMYkVaWXNUQmhEaGxyUnh5WFhGeXU5Qmc0cGtoaDhrUWtaWmd3NmVoRXk1?=
 =?utf-8?B?N00vS3FEY0VncjZlYUNHY2VTc3lFc2RKYmdQbjl3b0RpZjh6RlFXb3BGMTBP?=
 =?utf-8?B?aG12bktUY3FBY3RCdGR2UjdXZThLdVRqVTB6NFBDRHlSMFJqUk82a2pkYWZj?=
 =?utf-8?B?cmlVYUhhS2V3UjgvNTBOYW5SbU15VXExVTZreGc0R056SzdoUGpRTTljRnNy?=
 =?utf-8?B?TDRUUVlSUWluWjhneDFQWVp1dERhY1BrNXJFMzZSSDNLem05YzUyT3VXV0tO?=
 =?utf-8?B?aHJYcXk0YnJBb1hkQ1p6M2dxQXdzOFdqOEdWWmJGR2puVXlxSXkrYTRlVHBs?=
 =?utf-8?B?MzhmMDFJc2tmTGxtTUFLMlRhdDVWck93eXVya0dyRDEvZHQ5clk2ZExHWXB4?=
 =?utf-8?B?R05ucHFLV2JSMEpuNy9lbVdxVm5WRGpjRVlzSzhlU0VVbG1teWhkRnhlcjRm?=
 =?utf-8?Q?tCZCKBIF5GOQZ/pIljNZJF+QLFXbNHyNlmm7w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UW1Ucm91cFRxM3Q1bDFyWjhxK2k5WFBFTDhMRUdxS2JPeXRvTXU3c1E2RU5s?=
 =?utf-8?B?RUxTQTFuTTFSczdGRUJ6eStOaUZqb04za2Fhc05sa3A2U0VuVUtyb21zSVcx?=
 =?utf-8?B?MGZ4RTZWbU8yVnJRQm5GQ0xKKzc3a0wwOFZnOUVBUEpYRE9OU002empNQUFQ?=
 =?utf-8?B?UkgvNUVXREUzajRMNFZZTVY0Nm1JUXNIbk44UlFSZWJKeVoySERsZk9IekNn?=
 =?utf-8?B?aVZ3TFNKQ0ZEOGpiNjdjd2NYYmpOYXNuUzd3M0FhQVhVRnRhMHQ0VkM3dVFH?=
 =?utf-8?B?UCtXT2ViTGN1djdPN1JXVzhGelY5RVdXMTE4MmVIeDZtNHFWMHJVVkNRbDU2?=
 =?utf-8?B?b01yOW03ci9NOUNOM3JFK0ZDRmU5cm1kUUtEMFVZemxmK2VLeFZ6aWd0SE50?=
 =?utf-8?B?bW54dlo2SSsxcklIVGVBMVNyQWphSWo1bFNkUVp1bzNCMDVFYThtcFpvSXc3?=
 =?utf-8?B?QUhDakp6OFlNKzloSm9mTzNyY2V5UE5ZWWg0VlF3blZvbTFkSjQxVFoxR0Rm?=
 =?utf-8?B?QTY0clVVcFNlWmNJdkV6RFZlcWVSb25aQUk5Ny9FaXhML1l2MFNFZFozSDBr?=
 =?utf-8?B?L0dYVGVkVlpyYlBSMHFTcWk4TVVJQWs5b0JxWXVna3hld3N4dExuOE9HV0Qx?=
 =?utf-8?B?R0ZodVZwZmVldHRkUGtsR3Vud2JOckNLU2R0K1BuWkVSbVpyY29ZYnZ5NDVk?=
 =?utf-8?B?T1VRYjJjME84end2bmUvTGNtdU83aTRHS1VpSkhHU1hJa0lvZkRWY3ZmaUtE?=
 =?utf-8?B?Lzhrb3d4M3lEMVFyaVAzRDVUT2tkZmQvZUYra2tadzZhSmwzYmR0RlVlbVhm?=
 =?utf-8?B?ZUpkaWRvTkZwbWJsUE5paGpPWUFGSGZ6WDhuMG9EdzZXZllOSEc4cTFjY0x2?=
 =?utf-8?B?N3dKSmt1Y1RDcm8rWWJyTnRNWjRGY1JTR1BaL2twTi95NS9Wd3R0K1RsY000?=
 =?utf-8?B?MG1hKy9FS25mL2lETFJvUDU1OE15QzNvZ0g4KzRzWUpxR0NGSUhBRXFxb05a?=
 =?utf-8?B?UHNyaHZOZEtSZUtsZ0R2UlIzMHpydnNRVUwvVDVZUFYyT09MMGFPM1ZFTUdC?=
 =?utf-8?B?SHdENG1sMDBPRk55SEJCZDRUbEZ0ZkZZeXVpNFFTL0NLWDBTY3ZaSlZMVVZh?=
 =?utf-8?B?MFJIYUQwRTZHeSszMGozMWNMaEVySjZrWUx5SzVaNWtQZlJaQjRIZDNteTRX?=
 =?utf-8?B?eGIwWHIyclhLaXJad2pLbHhNSmxkNWM0c3FrRWhCY1FlMSt1YjdXQ1c0SG0v?=
 =?utf-8?B?TjluRm9LbS9od3BoV3NoVkN6d2ZlKyt6ZGhWQTlqWGkvdEZteG5tcEZwdEJI?=
 =?utf-8?B?OTdqMkFZMTc2TFhjMkZjSzM5OGd6MEU2UVRtQktDUjhWZXEvR0ZlSWdFQnRz?=
 =?utf-8?B?cXozbTVlczhGTVo2WWFMM25tNk12QTY4c3U0cFd4V1FjRjhjRVNNTkU3WEdO?=
 =?utf-8?B?WVpTdWtEV2Q0T0NIWjZkQUVZdk12USttaG5QcVlJZnp3bWJaa1NwTWFQMTVu?=
 =?utf-8?B?dXFjUFdHbWlXUUxoNTdRMnVrQ3A5QUowUUVhbXVGakdMcUpxV2l4NVVqTkRu?=
 =?utf-8?B?MWlwNHVTaDE4Wm1SWDVoZnNrNUpqUjNZWTdVTjFydkNncW9XSjhqU2dQNVhJ?=
 =?utf-8?B?WEIvRTVLSXpMK05OU2RrZFhwSmdzejU3WkNmUkNnMzVxb2hzRlBJbnA5cTBj?=
 =?utf-8?B?ZTJqcWdMbUZPRDVpbERrUDZRdWVXNU52TURTTnlVUU0ycytHbEltTTlOMGM2?=
 =?utf-8?B?bDJNOWZyQ3FBUUpJTWdYaEF5TkpIbXBBcEthZG8rVVdiNEJMUU1LUDZ0empQ?=
 =?utf-8?B?R1FBSDFDU043aUcwNVBkcVpwbi8yYmZUc05EMkN5bStTZUNaRHFDdkZLNlJ3?=
 =?utf-8?B?MndQREU3ZG1Hc3hkNEFZeVlxQjVXUEZFc280Nk95dWVFNXV2Zm9URXNzbmFS?=
 =?utf-8?B?VEU5MWRGcnVMYUpqVGxOY3F6V0EzOTRYanFzNTB3ZlVnenF3a3pnbm9mcUIw?=
 =?utf-8?B?eDRFYVd4RDZMWHc2NnlFMHNxQzR5amQ0SFJ5QUNEWFlGcjZtRjl6ejJ6bmVX?=
 =?utf-8?B?WkxiSjBDOHRyUVM5VWFnTXZiMEl0MjRjZDh6QXcyTDQ1SHVzQnRLdVc0VlJ4?=
 =?utf-8?Q?ROEw0SWJoFvfYbYpzisbv5vBP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edaf002-846c-4d71-3568-08dd1598b394
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 01:52:54.8457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5fsQviGv3qbXeK53o8c9rGbkHnfJxGFdCuxFa/WBJ9i5+TcCYh0RXTjtcNVML9vvTNpdjUkdNCvsGrP/EdFdZW/LEP4RLvf3dlGCqvdKPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7195

SGkgUm9iDQoNClRoYW5rIHlvdSBmb3IgeW91IHJlcGx5Lg0KDQo+ID4gVGhlIEFTVDI3MDAgaXMg
dGhlIDd0aCBnZW5lcmF0aW9uIFNvQyBmcm9tIEFzcGVlZC4NCj4gPiBBZGQgY29tcGF0aWJsZSBz
dXBwb3J0IGFuZCByZXNldHMgcHJvcGVydHkgZm9yIEFTVDI3MDAgaW4geWFtbC4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEphY2t5IENob3UgPGphY2t5X2Nob3VAYXNwZWVkdGVjaC5jb20+DQo+
ID4gQWNrZWQtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+
ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9uZXQvZmFyYWRheSxmdGdtYWMxMDAueWFtbCAgICAg
ICAgIHwgMTcNCj4gKysrKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiANCj4gTXkgYm90IGZvdW5kIGVycm9y
cyBydW5uaW5nICdtYWtlIGR0X2JpbmRpbmdfY2hlY2snIG9uIHlvdXIgcGF0Y2g6DQo+IA0KPiB5
YW1sbGludCB3YXJuaW5ncy9lcnJvcnM6DQo+IA0KPiBkdHNjaGVtYS9kdGMgd2FybmluZ3MvZXJy
b3JzOg0KPiAvYnVpbGRzL3JvYmhlcnJpbmcvZHQtcmV2aWV3LWNpL2xpbnV4L0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvDQo+IGZhcmFkYXksZnRnbWFjMTAwLnlhbWw6IHRo
ZW46cHJvcGVydGllczpyZXNldHM6IHsnbWF4SXRlbXMnOiAxLCAnaXRlbXMnOg0KPiBbeydkZXNj
cmlwdGlvbic6ICdNQUMgSVAgcmVzZXQgZm9yIEFTVDI3MDAnfV19IHNob3VsZCBub3QgYmUgdmFs
aWQgdW5kZXINCj4geydyZXF1aXJlZCc6IFsnbWF4SXRlbXMnXX0NCj4gCWhpbnQ6ICJtYXhJdGVt
cyIgaXMgbm90IG5lZWRlZCB3aXRoIGFuICJpdGVtcyIgbGlzdA0KPiAJZnJvbSBzY2hlbWEgJGlk
OiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2l0ZW1zLnlhbWwjDQo+IA0KPiBk
b2MgcmVmZXJlbmNlIGVycm9ycyAobWFrZSByZWZjaGVja2RvY3MpOg0KPiANCj4gU2VlDQo+IGh0
dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9kZXZpY2V0cmVlLWJpbmRpbmdzL3Bh
dGNoLzIwMjQxMjA1MDcyMA0KPiA0OC4xMzk3NTcwLTItamFja3lfY2hvdUBhc3BlZWR0ZWNoLmNv
bQ0KPiANCj4gVGhlIGJhc2UgZm9yIHRoZSBzZXJpZXMgaXMgZ2VuZXJhbGx5IHRoZSBsYXRlc3Qg
cmMxLiBBIGRpZmZlcmVudCBkZXBlbmRlbmN5DQo+IHNob3VsZCBiZSBub3RlZCBpbiAqdGhpcyog
cGF0Y2guDQo+IA0KPiBJZiB5b3UgYWxyZWFkeSByYW4gJ21ha2UgZHRfYmluZGluZ19jaGVjaycg
YW5kIGRpZG4ndCBzZWUgdGhlIGFib3ZlIGVycm9yKHMpLA0KPiB0aGVuIG1ha2Ugc3VyZSAneWFt
bGxpbnQnIGlzIGluc3RhbGxlZCBhbmQgZHQtc2NoZW1hIGlzIHVwIHRvDQo+IGRhdGU6DQo+IA0K
PiBwaXAzIGluc3RhbGwgZHRzY2hlbWEgLS11cGdyYWRlDQo+IA0KPiBQbGVhc2UgY2hlY2sgYW5k
IHJlLXN1Ym1pdCBhZnRlciBydW5uaW5nIHRoZSBhYm92ZSBjb21tYW5kIHlvdXJzZWxmLiBOb3Rl
DQo+IHRoYXQgRFRfU0NIRU1BX0ZJTEVTIGNhbiBiZSBzZXQgdG8geW91ciBzY2hlbWEgZmlsZSB0
byBzcGVlZCB1cCBjaGVja2luZw0KPiB5b3VyIHNjaGVtYS4gSG93ZXZlciwgaXQgbXVzdCBiZSB1
bnNldCB0byB0ZXN0IGFsbCBleGFtcGxlcyB3aXRoIHlvdXIgc2NoZW1hLg0KDQpUaGFuayB5b3Ug
Zm9yIHlvdXIga2luZCByZW1pbmRlci4NCkkgd2lsbCBydW4gJ21ha2UgZHRfYmluZGluZ19jaGVj
aycgYW5kIGNvbmZpcm0gdGhlcmUgaXMgbm8gZXJyb3Igb3Igd2FybmluZy4NCg0KVGhhbmtzLA0K
SmFja3kNCg==

