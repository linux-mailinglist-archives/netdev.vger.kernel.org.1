Return-Path: <netdev+bounces-303430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P6NNCENuRGoauwoAu9opvQ
	(envelope-from <netdev+bounces-303430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 03:32:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0C96E9126
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 03:32:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=LLO7umcy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303430-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303430-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3825630131AC
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 01:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB8F352019;
	Wed,  1 Jul 2026 01:32:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9C53546C8;
	Wed,  1 Jul 2026 01:32:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782869562; cv=fail; b=fdIuqJKeiXOD1GeLz0nZcEoTFmbeT+I0mSehWzE90jQBkrLjxw9KdMHOVkpIfpXRidKBtrQ+9/E4T01RhvDGIQgmRqMSvYi+c0Zm/txUyEKvyDY4l9fAy3Nq2sAv5KzVSloZkFVJ/k4OwqyLQKPedBrNSxEXjYyYR0QqW9IlJXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782869562; c=relaxed/simple;
	bh=jahK2e6zZvJb8qUIQfzxSMzUqzbzU1ggul0i+6D6+bQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hlpiamlQtLoqJAQS7VkuFdqrO3BLdD1D1DH9K0E6V7SVr1Sv+UwgtrvmT20yCf5AdRclTU9z7EAAM1PZVwMxK9SsRicBdkwn74Ge/duCLmPnGJCAd1A+1ydxuyrRQ6Bo6EGJcbF68s+rupBJmvmyzW2PH5DHDpJLDrL+Q2UAHyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=LLO7umcy; arc=fail smtp.client-ip=52.101.61.42
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5hUdAo3fklFXGvZlD29jutrRyy8gPiQtrHxouEkVAzfk9Txivd99tc+xN6kUigVBxHjiW4iHnRNH7UlYAGpXVxIuGPXJkQTrCotAOZTC7kKPtc4eDrhR44Eguv67wlMjE6ewPhyq8jmEI1hWyS7byuBFAxcjUJxeHaHs+Y7JoJZH9fym+ciIYcM5AL1yvLUWI1Hac7Nd69mvnR/lUr/tsxJJKLuph175x4+DWMdhd8K/t86ogdLT5/qol/bMnn1V8v7dQc0yypI35xzF17DwiILKzqKr1GZZ/BARDj+cR8LRXw44cj6iPJb+daxa0ao6he5yteAydijyszHrrDaJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jahK2e6zZvJb8qUIQfzxSMzUqzbzU1ggul0i+6D6+bQ=;
 b=jqKbwOK5Wd+3/FRQ5CS+5y6kQiwJneOcNbNejLIuR96yo6r8GDHXn1HiFEnzNP5OV1+h5kPTS4EKA0wXHv7Zsw1t22Nk/j8kVaFkl8syahQ4F5/KDGGfqB9wvxpDQsUmJdZFqA/J0uLA7HDEG20iUI/YAbfsq/Q6WN0ibMI3HM3Y/oyOQVn5G0ZD9a04sJ8GbRafd8xscLWmWB4Sb4GTNn9BSM4rOARlTBU0owFF/2TJ+ZqWThKwRGVTvqeYHNBLpBzYT1w6oT+AwMIx8sOU/D4AksRGQd6+xheXwozc4c8doV5DCsqxsh2QXRvQIYkRJfkyhBjw9W5Sxa7NP0Zafg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jahK2e6zZvJb8qUIQfzxSMzUqzbzU1ggul0i+6D6+bQ=;
 b=LLO7umcywljEHzs7BV9BbghDa1IeQM/7CsWfyQB8K6XrERtyZdGfJZuBAgPeJs2jZGzEQLJeP49pPNcmiD4fQ7NPl1qkTqmXt7aJ2U+uEuzTU+63ziuub1TDHodTDHUSE/LGvuhWuWR/vN3J/VlH9zT9Xx/m/kW9oFenfMH9SZqb2FAmxOQHJPNxk5NBfqH5gAa/cBn6Hn2sL20kW0+unkVilWyLua3gO8AiLAVqF2QMVrKf+6ey8uTfvk9IOJjYQJ3MxGCeGupVsbdQG95UVziqgGcc5CMuVeQ1Bhq9PDTD0848Vel1qwRKw2oxL1yAPh/lDDLS4hZTxKRGUTZ2cg==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by MN2PR03MB5053.namprd03.prod.outlook.com (2603:10b6:208:1a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 01:32:35 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 01:32:35 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew@lunn.ch>
CC: "dinguyen@kernel.org" <dinguyen@kernel.org>, "rmk+kernel@armlinux.org.uk"
	<rmk+kernel@armlinux.org.uk>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] net: stmmac: dwmac-socfpga: Add mac-mode DT property
 support
Thread-Topic: [PATCH 3/3] net: stmmac: dwmac-socfpga: Add mac-mode DT property
 support
Thread-Index: AQHdCJS3s6rWWjcH10Ox3xzcAVXL37ZXISCAgAAAjQCAABNGgIAACCEAgACkuwA=
Date: Wed, 1 Jul 2026 01:32:34 +0000
Message-ID: <99923ec2-a973-491a-9a7b-12a54b7d216a@altera.com>
References:
 <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260630133108.27244-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <4c285993-978c-4d9e-a8c5-c3b36baa6840@lunn.ch>
 <7c57bb08-b72d-44bf-be44-f1bcb2aa9a84@bootlin.com>
 <b6c52ac8-32dc-4a58-83ec-ef600b306448@altera.com>
 <e691298f-b3e5-4c1a-8270-a821c1f46a2b@bootlin.com>
In-Reply-To: <e691298f-b3e5-4c1a-8270-a821c1f46a2b@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|MN2PR03MB5053:EE_
x-ms-office365-filtering-correlation-id: 5c47a533-fb41-4d4a-4a9c-08ded710a0b8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|5023799004|11063799006|56012099006|4143699003|38070700021|6133799003|3023799007|18002099003|22082099003|55112099003;
x-microsoft-antispam-message-info:
 C3EuMNYEez0Uip0cwyvUY54EHLdyFNpqG7XVv2uCGjUqESnoSn7SSoq0SM+FyzX4s5ZFMur4rYh9RCHCru+UkQ9ZAEzgDyOrls+w4u/yvCCrW5dXIj5efD5eYlaqa+HQrUG/rp54pFlVJjTdlKLcHvPfb+K0CAUat1EPovl5Vh5oryRU0nGHVZTnT+EqEeraJOg5xa7DxiRTqC0T4f+U/O9NVi7Wkt5rk4hPVtbXJA6X0mYtGo7ZCX+c21TzC7flMwFM13hCmvfqAcF+JM+4+QFI89pL3lwFZi1ywmzqjOkL3ZnnFh18oeV6lJiNNFch+isopkSSZxwOCyQfffV3uiEh2t+wLRQbt9bUcfshVAzFZAEbwRORXdH6gqNDeD785B46q20nnDfs52A3F1Xs8rurNkLg8R0XBKWe/pUQuLkz+KrKCL5blUxU9JicCqPFGvAU5sjVXUjGQx1FSLKsO42vFT5t9SSx6Z7Le1zdR9BvpOwnEQXuBegNlkZJVrWBjq+HvUDmCfFi/L6kxSGwz4S0BIvcBgJE1BdjgJKJlWyJg5EGjmX6RYAZjHMP8nFvj6Z7nsi5FQ4hlYOdv6jk3QYmjOSegmLMHKEvM66AzwHhs55dsQ3X5XLQfFlR/T4DskH/Xpaahc7+ofYl7BrIaYRWAHYa/PV5WMcScTiyqfQ7RHwLP9IGWxggdhq9rpE31H0+S9CSKaEew+Un71+mMUtigfN9NyaYylYH1trejFY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(5023799004)(11063799006)(56012099006)(4143699003)(38070700021)(6133799003)(3023799007)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHdxaVZJZ0FYL1N0S0NmNXFtN2t5K0hvNFJyRDdMQkJ5TzdiYVgzRTBvZEho?=
 =?utf-8?B?aEp6bGR2UTZFbEttc0lFSTFPa3hyeHJjclgrRExoYzFHUnlaN1YySm1xejU1?=
 =?utf-8?B?dVdscE1EUWExT1MzNVBhMjRkdmxUWmlDN2o5ZkJvZGttOHgyWGY1ZFY5RFVB?=
 =?utf-8?B?SVZhVHlYVk02RHlZVzd5a1orNm1SKzhNaVVnR0UrUlVKUmw1VThkbm1zL0th?=
 =?utf-8?B?OFdNUFh3WDMvTlZXWjlmTDVvWEJnUWVWeWxESmRYVEpvZnFwYlJxcnYwUnZy?=
 =?utf-8?B?MVpNS2JxY1hnUG43RXYxRUNuQ2xtQWVOZWc1MEc2YlMvV2Z0VEI0cHZyS1pr?=
 =?utf-8?B?eEJzM295WjVqMHdEelFjZnhoakhmSHdrdGZrc25BR1BWa2pLQ0NXd002QVdO?=
 =?utf-8?B?WXlZVkVCbnd0dkpVY25BQ0VQVis0eWt6M3NiRFh3UENDdnA3YnlPbzE3R3l3?=
 =?utf-8?B?ejJ4WktYK0FxVnh1ejZUYm9NRFNWMUZvM3BWWWgyc1ROcXhjc2xOQ2FSOEZX?=
 =?utf-8?B?WGU0V01QSXlCTDRSUUE4VXF0eG15SmFIb2t1SWFMMkNFUzlXK3B6RGlLUW5U?=
 =?utf-8?B?OFRPQkhpRFVacDBPUG4rWmozVlB3MlludHlPbjlmT05XZ2dkQlJGeW0xVXpm?=
 =?utf-8?B?dFlYTncrdGxicXZiOUJTa0ZaMGJXaEsyUDhpYXl6UTZob0owdVRlUUU5YVdj?=
 =?utf-8?B?V0lYeTI1em9NWUwxeGdKR1JPeGZqNjBJTWtmZmtBZFZoYXB2YWF0b3kzbm1n?=
 =?utf-8?B?RzBxTXZLakJyUnorSzFoRVUxeWc4THZOaDBqTWhPSFMwaVF3Rnl0YnB3WkFS?=
 =?utf-8?B?NjVSVURTQ2R1ajN1UVhQbS9ZUGk4OCtZTVljSGlFZjV4YmJTQ3Jwc1RYUnN5?=
 =?utf-8?B?NWxlemJtd1BBdldxQ045bnVRQlF6RWluYlBRNjg4ZnBlcGtKUnFXdGlJbHJJ?=
 =?utf-8?B?RHgza2NadTUwbkRPNG85SG9IdlFVTis4MlgvdFBBUVF4bDh2YzFMMTVZRUxx?=
 =?utf-8?B?Q0J3Y3hZeUFNeHZ5NW1HOGhCT1NRdldiZGpzSFVNWFZMU05ReU0xMTFaVzBZ?=
 =?utf-8?B?T2o0UlAyV1loRXFTU3FmWitMbHhyWU9NNGIrUkJCRkoydmpLNHExZjVFU3NE?=
 =?utf-8?B?aUlVSm56TVFVMnl4TnU1d2Znd3Fjdi9ZRjAydXdycWdDUlN0anY4aEptSG5l?=
 =?utf-8?B?cnZSdjFWSGxmUEhDOHNZdE5IKzdyTjZsdVhTYzIxNjdJbCtLWmNyaXd1SnRY?=
 =?utf-8?B?aEVIbERteXNYdGFWa3RDb0pmT0x3UzNXS3JyZVQ1c2NkYW45R1JsNnNuekdh?=
 =?utf-8?B?dXExYVRzbk4vZXZnOTljazd0QmFxYnZsZHV6ZVROb0lJZlVOSnlIRHJhM0VM?=
 =?utf-8?B?SDhPNC9UdGxGTllPZ1BnSlh0VDBBK0FHQ1EvUWxPcHNPTkY1UkxKR1Bjc0dw?=
 =?utf-8?B?QU9scHBsYUNBeUZ5dDMwTklSWW0vNXlkeXdZQVQvQm5KQWdrQ29FMUZ3SnJF?=
 =?utf-8?B?d2JFNGRxZnY2V0hjUDl5eitBMzN2Y3JYbm8wa09mMkRNWm52NkdyajFZaTBi?=
 =?utf-8?B?aTI3U2NxSjgya1dGcm9YR1Rtc2RmQS96clZNVmNKZ1pQN2NmMGdJZlYxOVFv?=
 =?utf-8?B?eVQyWFN1TGlTK0FsY2xweTlSaWhJY3pmVjBpYnRoUzVrN0VldTUwdjJRTFNH?=
 =?utf-8?B?R0tRWHVWQmZsMEN2bW9jOFU2VHdYNDZHaldnTXFSNzE4eXBiSFRjczN5d0tv?=
 =?utf-8?B?MzYveEZxSUExbGtncHRvclZNYkUyOEZVclpXUm9SUEUycEVKQTdGMjJ1RUUy?=
 =?utf-8?B?dTczT0RvbTZRSVFIZ2JaM3Jrc0YwRC82emM5Mnkyc2VSVnpRK1FJcGVCdDhx?=
 =?utf-8?B?RTNuS1NMUkVMTHd2VG5jeGJxQ2hFNytIODNZMUlCL053cnFheHh6cGJKT24r?=
 =?utf-8?B?TkxDUnZVeVhYcGVvMHQyaVVGY1dod09lUUFkOGFlUlpYTGRNc2t1UFc5QnJX?=
 =?utf-8?B?THVpaThiRmp5UWZlN3QrUlppeEdNRnYvWDFZM056cmpZSjFMcHZnQml1bllt?=
 =?utf-8?B?azdsYU96TmJZbncyL1c1akhLdGRnNHVFRDlvaC9HL0gzZUx3T21NOEZDbklx?=
 =?utf-8?B?bzZsUXEzVWI3V3QzYWdubndYZTRpYlZHYnFTenc3NXJwR2M4VDArRWgxa0dx?=
 =?utf-8?B?cmU1TE1jVDNoRm0vNHJCb3NFVCsrS3F2VEpnc08reW1MM0E1eStxRUNybFcz?=
 =?utf-8?B?RlZiTHlpU2VLbVpzeUhTZkIvNUEyOVYrcVZPVmN2dThrNU9yZ0JLa1B3bU5o?=
 =?utf-8?B?VnVlTjhjNHoxSHJEQ3g3emZkY0tWUGF1Vjk5bE1sSHd6YlNJYkZrZUZZMDY1?=
 =?utf-8?Q?VZ0d8FJ9Jh7KwdOLxaku/Q32SINR81t8XJgatshvbTcqN?=
x-ms-exchange-antispam-messagedata-1: /0AFIgqunNuZT1vsT4WfJE5uZ5VS/Y4Df7w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F574663896D614CA653B0839857488A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c47a533-fb41-4d4a-4a9c-08ded710a0b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 01:32:34.8676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZNFJP4iSUmBBlRSGiSjeDWUpXJEinPmCQbx5m6GX5h41VrKLv/IlFTltt6MaWWW2ju6xUNrzBCbvE6DjQtOXcCYEDbEO0hiCTg+NMkhnibodYqNUlQ7NtupLn31W/8iQ83aLxPzuHBIxcpCnW+U3lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5053
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303430-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:dinguyen@kernel.org,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,altera.com:dkim,altera.com:mid,altera.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A0C96E9126

T24gMzAvNi8yMDI2IDExOjQyIHBtLCBNYXhpbWUgQ2hldmFsbGllciB3cm90ZToNCj4gDQo+IA0K
PiBPbiA2LzMwLzI2IDE3OjEzLCBOYXpsZSBBc21hZGUsIE11aGFtbWFkIE5hemltIEFtaXJ1bCB3
cm90ZToNCj4gDQo+PiBZZXMsIEFnaWxleDUgaGFzIHRoZSBzYW1lIGNvbmNlcHQuIFRoZSBHTUlJ
LXRvLVJHTUlJIGNvbnZlcnRlciBpcyBhDQo+PiBRdWFydHVzIHNvZnQgSVAgaW5zdGFudGlhdGVk
IGluIHRoZSBGUEdBIGZhYnJpYyDigJQgZXF1aXZhbGVudCB0byB0aGUNCj4+IEN5Y2xvbmVWIEVN
QUMgc3BsaXR0ZXIuIFRoZSBYR01BQyBvdXRwdXRzIEdNSUkgc2lnbmFscyB0byB0aGUgRlBHQQ0K
Pj4gZmFicmljLCB0aGUgc29mdCBJUCBjb252ZXJ0cyB0aGVtIHRvIFJHTUlJLCBhbmQgdGhlIFJH
TUlJIHNpZ25hbHMgdGhlbg0KPj4gZ28gdGhyb3VnaCB0aGUgRlBHQSBIVklPIHBpbnMgdG8gdGhl
IGV4dGVybmFsIE1hcnZlbGwgODhFMTUxMiBQSFkuDQo+IA0KPiBEb2VzIHRoaXMgY29udmVydGVy
IG5lZWQgYW55IHNwZWNpYWwgY29uZmlnLCBhbmQgZG9lcyBpdCBleHBvc2UgYW55DQo+IGNvbnRy
b2wgcmVnaXN0ZXJzID8gb3IgaXMgaXQgZnVsbHkgYXV0b25vbW91cyA/DQo+IA0KPiBJZiBpdCdz
IGZ1bGx5IGF1dG9ub21vdXMsIGNhbiB5b3UgZGV0ZWN0IGl0cyBwcmVzZW5jZSB0aHJvdWdoIHNv
bWUNCj4gY2FwYWJpbGl0eSByZWdpc3RlcnMgb3Igc29tZXRoaW5nIGxpa2UgdGhhdCA/DQo+IA0K
PiANCj4gTWF4aW1lDQo+IA0KSGkgTWF4aW1lLA0KDQpQZXIgbXkga25vd2xlZGdlLCB0aGUgY29u
dmVydGVyIGlzIGZ1bGx5IGF1dG9ub21vdXMgd2l0aCBubyBjb250cm9sIA0KcmVnaXN0ZXJzIGFu
ZCBubyBzb2Z0d2FyZSBjb25maWd1cmF0aW9uIHJlcXVpcmVkLg0KDQpTcGVlZCBzd2l0Y2hpbmcg
aXMgaGFuZGxlZCBlbnRpcmVseSBpbiBoYXJkd2FyZSDigJQgdGhlIFhHTUFDJ3MgbWFjX3NwZWVk
IA0Kb3V0cHV0IHNpZ25hbHMgYXJlIHdpcmVkIGRpcmVjdGx5IGluIHRoZSBGUEdBIGZhYnJpYyB0
byB0aGUgY29udmVydGVyJ3MgDQpzcGVlZCBpbnB1dC4gTm8gZHJpdmVyIGludGVydmVudGlvbiBp
cyBuZWVkZWQgb24gc3BlZWQgY2hhbmdlcy4NCg0KVGhlcmUgYXJlIG5vIGNhcGFiaWxpdHkgcmVn
aXN0ZXJzIGFuZCBubyB3YXkgdG8gZGV0ZWN0IGl0cyBwcmVzZW5jZSBpbiANCmhhcmR3YXJlLiBJ
dCBpcyBhIHByb3BlcnR5IG9mIHRoZSBGUEdBIGRlc2lnbiwgbm90IHRoZSBIUFMgc2lsaWNvbi4N
Cg0KQlIsDQpOYXppbSBBbWlydWwNCg==

