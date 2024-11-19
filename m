Return-Path: <netdev+bounces-146115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7D19D1FB4
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 06:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81BC9B21D56
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 05:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A981014D2AC;
	Tue, 19 Nov 2024 05:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="QPaYMwtj"
X-Original-To: netdev@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021075.outbound.protection.outlook.com [52.101.129.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9279811CA0;
	Tue, 19 Nov 2024 05:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731995201; cv=fail; b=kJxpyJIUhMPLQRSEXfxndFvqsTaoI2Vcvat0XkBnpzZffwNfB7OeQz3D93drJ8hYxT+rF5j/50Z60HXLs6n9M4XxAOvlX2oE7dFcg2kajqrXQC8q/JEzpGNnE5f5UVWdrpBV7nHMLPCQEPkQksxsm4fEsHDASe235tRT8sAC1mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731995201; c=relaxed/simple;
	bh=qIlSQEK4hOFOOB0AQmg6U47EF6zwT+h1lHTmFWnsmWk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UNJlkO1997ijYznVS41J0/gV5MmPzo5OGskcuh5qUSQFv8XTuI21RTbZOBFkHqGM1RdgEZFF86cR9r1arnr9WxDOEDXiqlYUMom9jNIODdSf0DgQU8B8j2Ujh78VwkJP4xUhcBbU2n20qtJ8/3n9lQkXPFVtDlUeFY6XkK21E/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=QPaYMwtj; arc=fail smtp.client-ip=52.101.129.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8lZjiX1kBH7wheUrluz6cMuTAjM96FgX9wuubT/hMG8BGbiWKQ8PRZ89K6UEgt8WYfvFmkvr5eb+cAoULU4cLRNgE9OWn8B39o1Lm1+VelcJ0aVg+LDDwc1K4M0WksLf5/8R4c4Kkhy5GEa05cVlDjOWncwX5Ixwc5RfF5ONOc7ySh2YkZwqMxseo2HHRznjb5NC8dFAUVv/LLQdVoCPhnmAIbfPxUrmKJv5V0zaqZmhwo/CAgqXna5+uoCcFEbNwMVw2zpmCrVYRq12ry34wnBm3wu5uVhIm2tVAX50QAvj1prU339RSCtrujBMsIYWRVQqd5amvWlCi3URCw+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIlSQEK4hOFOOB0AQmg6U47EF6zwT+h1lHTmFWnsmWk=;
 b=tclk6B+bYnmD/jEsCQmJoFlfOK3bkTgOVDQLuVD6h95mW1UjucyQhhumOrgqZTsWT6hFkgciQoK5w7b3x1Oipf6UogDdZTJldMWu/G7R/MnsbvIYB/zTuf1oTFUOIITxPYesTUoptiJ/6BalTRdDavlr7hYcyxu8e267wDJhuEcwUt7BELSQ7OPE9/YxBa2iYGBxUDV3J7XRT8IAUc/4RZrXkZL/PL8nzRr0EC5EV4bExw0EkG6K9fm/QUAnPzVbMQvWVj6iupNIJtZkzHQRDbWUvB6NLTSF5gwmXHY8lQNz4KfbLnOloJac0MkGlTdKLM1+3fVxBHy34nQjfRE6/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIlSQEK4hOFOOB0AQmg6U47EF6zwT+h1lHTmFWnsmWk=;
 b=QPaYMwtjDdroJZFHptClRyqtA54FmqUH9ImTTa4xG0suKmrS8wN/AOR9tAn5K82iZpg2qhOlG5vPea3mNUmAvUHMP5PqwH/ewMf+G4zks+tZj3r0DtadwQp0LhoNyr+GiCshZ5RVxZDEOLMGXnPQJ3/dM0Ea4SVdFvUq7dxCjOCjahxTPl++dT/dZiNpeifKbZrzdWd9XVv8qqCCo1DXVTHcSP80SlOMYScPeDQWZcoIqFQOcyPQhWQRMlLgAx/jHZXIUTUv6InFUmMQk7L2eyJVOTO6J0Ft+Mb5DC44HbrBuuI0hT4dbchCC3ZjrjG1oNHmLM0MLxEFHT4JsicV1Q==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by PUZPR06MB6005.apcprd06.prod.outlook.com (2603:1096:301:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17; Tue, 19 Nov
 2024 05:46:34 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8182.011; Tue, 19 Nov 2024
 05:46:34 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue6KaGOiBbbmV0LW5leHQgMy8zXSBuZXQ6IG1kaW86IGFzcGVlZDogQWRk?=
 =?utf-8?Q?_dummy_read_for_fire_control?=
Thread-Topic: [net-next 3/3] net: mdio: aspeed: Add dummy read for fire
 control
Thread-Index: AQHbOadMh8/4lWo6CUizIJ5277jZvbK9qXWAgABtC6A=
Date: Tue, 19 Nov 2024 05:46:34 +0000
Message-ID:
 <SEYPR06MB513478D976FFC735134F3C209D202@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
	 <20241118104735.3741749-4-jacky_chou@aspeedtech.com>
 <0d53f5fbb6b3f1eb01e601255f7e5ee3d1c45f93.camel@codeconstruct.com.au>
In-Reply-To:
 <0d53f5fbb6b3f1eb01e601255f7e5ee3d1c45f93.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|PUZPR06MB6005:EE_
x-ms-office365-filtering-correlation-id: dd050ea7-84e6-45a4-7f36-08dd085d86f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vnc1Q0RzdUZHY1BHeVQvQ0w3eGdJY0c1WGduNjJzTWFwNHcxcGV6ejJCanBS?=
 =?utf-8?B?bURQcXNYZzNmVzUvYlVRTWRWRDdYWkJuNUZ6MHlGZVo0Z0ZmdlU5YlNLUUxG?=
 =?utf-8?B?RnRPaDRrWVZwOUFCVmF5RUZjMUJGeEpsay80Mm9NTEh6dkRENVRjOWFPMWVM?=
 =?utf-8?B?N2s5eE1ZaTliYnprQ29ZdmhzcFFkUGkyOUdTNHpGQ1YvQXNOV0o1b0lQc0Zl?=
 =?utf-8?B?cFl4TW5YQ0h4MUxqOHViTHpvZWxMZUJ6MjIyTjAwQjNqUGVueXE0Vk1TUFlh?=
 =?utf-8?B?RXFqRklOZEhrM1JkUWhEMFJUamp2WEZGUGhMMXVvazc2T2pJYU03dXk2L1hj?=
 =?utf-8?B?dys1enZRQnNIYWpwM3VMdHBQY2F0NURnQmMvOThmaUJIS1RLa01PYy9xUHNh?=
 =?utf-8?B?VmpkSm85SU5EdnRyc2NGNktKNDZhQkllMVZQUCthbGJlMlJDZWs4cGVHNk9o?=
 =?utf-8?B?ZU1qT2dleEhjZTAyTFFXZEE1RGNCV2RZdGN6TWJtZi9oV0VvSTRncmtEb0px?=
 =?utf-8?B?OGpCaUs5SUNCdFZnYmd1ZnFWWnV5Z2tGaWs1OFhiL0c4bHNuTjRlb2dHWUVw?=
 =?utf-8?B?RG85Vkxhd0FhMlVBcVlhMkNETklOYjFzT3BIUVN5UWRNODZQRGxUZUNLTzRJ?=
 =?utf-8?B?WmozNDNzNEhWZWhNQ044YnJwTFBsWnJHZllSVEdHUXpOSFBUMjVmNFdNTXFI?=
 =?utf-8?B?ZE1KejRFaloram00WGppRSttWi9vQld4Sm9KZkZMQ1hLbVl4Mm8vNUt4RWgz?=
 =?utf-8?B?dElBNDF4Ykl1cnFIN1BKTXlJT0N1c0xyMm8rWmFvVVlQY1c3YU9kdFVveko5?=
 =?utf-8?B?Y1VJNHBRUzRrQTJkbkFweEhKRTVvcDlwZnIzZVcrZW00WThPZFluVlU3SzhR?=
 =?utf-8?B?TSsyQW9DT1pwNE9xUXIxN28wT1g1M3F1bHFEVkxTSDE3ZWM2SmhlZTZuT29v?=
 =?utf-8?B?SnZ0aC9TY1VldUV6dTRMMVBYeEVsL1B2RlBCaHJKN0Flemw4a2pOYkJPakxm?=
 =?utf-8?B?MVI0UE9zcDJ2ZmVtcUZvUnZnbThMcGJiNy9jWXh2cnFhU0phc21CbXp3WCtF?=
 =?utf-8?B?MkJaamJaM1lKRlF5cVVQbllYM2ZqSW5NZHVUazZYVlhJNytrMmFscGlJZVh2?=
 =?utf-8?B?eDg1Q255eEtoRHdPV1hvUEpqbEVqSjZ3RUxtall6MWxRNUwvcDZOV2N3QjQw?=
 =?utf-8?B?V252TzBtUHZlZzJ4bmc5SzdSTUxpTmwxSmxMc1VKVjQwTHZuOStPMmdlbms1?=
 =?utf-8?B?WjgrUzhlZEhyZlpxUWlucEx5cXZ0S0U2ZTRzNmJ3OElqT2RITDRvalhuNlFJ?=
 =?utf-8?B?MDJFU1NtWTR3VnJacm5uSDhQV0JWNFl5cFBWMWRHdStrTUhrbWZ1bHRib2Rk?=
 =?utf-8?B?UjVsK3lvak11Tzdzb045L28zUSs2SzNNYzhpeVJiWVdoYVY0d0FvY2xrUmdt?=
 =?utf-8?B?ZlVQSmRxdjBKSXRqdTFINldaT1I2VTc5RnRuNEJUN1hJUDJmK29xcEtQWmQr?=
 =?utf-8?B?VktOVXhZZ1ZGcEVnWjZXK1ArUGpEaWd1QW1jRmllb3FIaWdVMnpKeFNnaW04?=
 =?utf-8?B?RTV0RGluRjlHcTYxQktFa2d3ZU9iaEd0NU1OV3FOU2ZaVkFUTC9mOXA1VzVS?=
 =?utf-8?B?WGJKWGVuVHd6WFo4Zzc2Rm9ZN3hydytnbzNFdUhrdkxvdFkwUlhiT2I1Z04x?=
 =?utf-8?B?L1FsVFVaRVIrbGFGNkNtTXJvOEY2RzVRVzFrTkZRRGwrUVVTY1IvQmhNSUFp?=
 =?utf-8?B?c0JCRHBTZjBENHZIMFFHUXA0R0QwRE42c09RbkpNUWprVU4zclQ4SjdGV084?=
 =?utf-8?B?ZUtjTTloNGdDTlFPcEZsQUJCK1MxOU43RkRZZTZxaHZUb0NQZEtlbVA5bDVa?=
 =?utf-8?Q?p7TjDLRHi/39w?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEJLY0xTODlDcFlKalVPaDErcHU1dFJqdWYxWGFJK0xKMm5VMEU4Y1B5eTZD?=
 =?utf-8?B?dmdiMHdDTUdVOWlYN1hPSU5kcnNrbDlBRUVnNEhBZGNaZVM0T1ViQmFSR2M4?=
 =?utf-8?B?ekZzZE1DeGcyaXJFYzlFRmZoQ2hmU3V5eVhIelN3eGU5ZjVvbXJmcjZpdGlJ?=
 =?utf-8?B?U00zT2tGa3pCWEY0aEE2cG54WkJBRERvKytRQjV4cDVoSXZ6NTM1SVFxNWV4?=
 =?utf-8?B?anNGYnNWMU9ucjlscnNNc1c4QjdjcWlaMDJmVWNPODFZNW9EVENiUWJMSmd1?=
 =?utf-8?B?UWswLzJGMnY0Sy9DSW5oSmhYS1lGUkZsL2tmbFFHNjJNV3lqcWs5b2hJT2dm?=
 =?utf-8?B?SzJqZUlxTXVEa0RIWm5XZkR2ZWtEdWVwRFpGZXB3Wkk1T2lMbjVmMmkzaXcz?=
 =?utf-8?B?dzVIRDE3L0NJemkrVXkrL1VPVGQwZzhhYzZ2R2xpZGo1RGd0T2xmTkliUnR5?=
 =?utf-8?B?ajZWbHppTVdmdXhvQnlBbmVBVlc5WExNWG5waFJOOGFDYSs3RE51THpVcGtQ?=
 =?utf-8?B?b2Vhdi9ONmJReHY1SDdkeXRCMzIzZEtUK1MyWXU5N1RieUhHSHljbmFwVUNC?=
 =?utf-8?B?Y0ZCQVdMRkN0ZFJBNTh5N1luUFpQVms3ekpGMVpQQ25sald5RmZIZmFTbzJV?=
 =?utf-8?B?aUw0Zmhpbjl3YnRHa2xuMEJuMGlOY0JQN0p5NytrQTdkN2htRlNOUW5CaHlF?=
 =?utf-8?B?cDJ1N3VDcU5rZVcyM1pOek92WU5QRnlCM0NReElPMUpLVDc4YVRJK1VsN2Z5?=
 =?utf-8?B?VXV2ZGxOSFNvK3hYUHRvbmh3T1g1OW9VNWt2VG5NcGw5RDE5cTFXOENVVnNx?=
 =?utf-8?B?N05XZWpkcWlETEhQd2t0YzRtZkYxZWh0Ukc4U09ieUVGVDBZamtyZEFXejVj?=
 =?utf-8?B?L1VLQ2J6SkFMdXVkZmhHYTdmRTQ0VkhCVW5vRFFkd3pmd0ZQNHdXL01RcFA0?=
 =?utf-8?B?UzlyYzlHVVNIS0pLb21mYzdwMGpVc1Q0VlRMSDlpTU5COVdxL2ViT0diYlJm?=
 =?utf-8?B?UkcwZTNKbTh3azlXSXo0MTBvWXZlbWZuQzdPcGRoUVVXNVA5L2V1SlpObVY3?=
 =?utf-8?B?Zitld003NXl1Z0licUJYVFJJcWhYNUM2ancrMzcyYTRvWnJPUUtzUnA1MXdG?=
 =?utf-8?B?bFEzL3ZueGgyLzJTUm1ZSWV6bHBVNjR5NE0vRDFkVG1FaGxiYmtWbGV3Vytz?=
 =?utf-8?B?bDJ0SGhhSnN0aExxR0VxVFpDQndYbXVFN1FkNUtaRlVMMzVyc2x3Yk50NkZD?=
 =?utf-8?B?azZLdU5KMGp3aVpFcURMTHZjcFNyb3NKd3h0azRkd0JML1lqSTQ0UWNGWmMv?=
 =?utf-8?B?cWZKVzdrbFRFUkxPRzd6VTNYeEl5UElRcThCQkVJN0FXUzBHRmNIa3ZaM21T?=
 =?utf-8?B?aVBrVGFOQUFzb050MWdOVmR6RXZjZXpNOFhiWER6MUdjRGZwSlNYQUZBZzVP?=
 =?utf-8?B?WFpELzZTOHp5NUFhVTd6c0J4NklZMEh1SXl3cUdiWkU3MjM1dWpXYjJLc0Z5?=
 =?utf-8?B?V25OOW5lU012UUFkNnFaL2lrd1FnanlaTWtzY2hycWE4c0ZqK2M4OXFydkhz?=
 =?utf-8?B?cG9oU1luSDF6UFR3SE5DN0R5QmFkUUV5Z3d6bHgwUmdPenZMTUZxVnQ5TG84?=
 =?utf-8?B?QTBjQ3dVRnFLeWRZcloyMVE4UUplWnBtYzRTdXIvMmNkZVBtTE5NOEttbzUx?=
 =?utf-8?B?czBaWk9yVTdXWEpyWVNic1pyK2MyYm4zVElXeWhBM2prTlc0OUJkZGVRTmdK?=
 =?utf-8?B?eExpS1pOYnlGdmZ2d0k2YjQ4N1BqdStpSEFPdVUyWEZwK1NLUEVLRlk3cmZ4?=
 =?utf-8?B?OW4razl2anBTYVBhWmR3c1A3RG9ERk5xbGF4Mys0NFFjWmJ4c1BvTEoyN0NW?=
 =?utf-8?B?OWRISWZDVjV4UG1VaHpOb2s2ZCtpLzU2blM0bmZDVWt6UkNmaVVvVnhJK2xm?=
 =?utf-8?B?cW5uSDQ3Smd5S1VKeHZpYjBWOVl3QVFpTzJVYm1RRWJQZm0rZTAzRHJaWXl2?=
 =?utf-8?B?Q2hpY2FYZUxtTFNkMEVrZGozKzBYbzR6TndJWkIrOS9rUjlaNmJOL2tHRFZp?=
 =?utf-8?B?d1lJMzFCTjIvQi9JOVdmak43Qm9PbXhVQ3JPUit5dVVmd1VXNWJtNWpmWEVK?=
 =?utf-8?B?NnZ6NTNGZ3pQb2lMN3ltMWttaVlvUlpVWU04UHZleUtyVXdSMndha2x6Qkp5?=
 =?utf-8?B?SFE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dd050ea7-84e6-45a4-7f36-08dd085d86f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 05:46:34.5336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iLDdnjtRfFcn5DvZZE0Y2NPzqUKNWVZapk+0bVl1LIHitiq0Ny1X6VNc5Ndxc07r65xGXSY0q8je5B1vwXLTKd9VioPph5wnPJd0R1Z/waE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6005

SGkgQW5kcmV3IEplZmZlcnksDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4NCg0KPiA+IMKg
wqDCoMKgwqDCoMKgwqBpb3dyaXRlMzIoY3RybCwgY3R4LT5iYXNlICsgQVNQRUVEX01ESU9fQ1RS
TCk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgLyogQWRkIGR1bW15IHJlYWQgdG8gZW5zdXJlIHRyaWdn
ZXJpbmcgbWRpbyBjb250cm9sbGVyICovDQo+ID4gK8KgwqDCoMKgwqDCoMKgKHZvaWQpaW9yZWFk
MzIoY3R4LT5iYXNlICsgQVNQRUVEX01ESU9fQ1RSTCk7DQo+IA0KPiBXaHkgZG8gdGhpcyB3aGVu
IHRoZSBzYW1lIHJlZ2lzdGVyIGlzIGltbWVkaWF0ZWx5IHJlYWQgYnkNCj4gcmVhZGxfcG9sbF90
aW1lb3V0KCkgYmVsb3c/DQo+IA0KPiBJZiB0aGVyZSBpcyBhIHJlYXNvbiwgSSdkIGxpa2Ugc29t
ZSBtb3JlIGV4cGxhbmF0aW9uIGluIHRoZSBjb21tZW50IHlvdSd2ZQ0KPiBhZGRlZCwgZGlzY3Vz
c2luZyB0aGUgZGV0YWlscyBvZiB0aGUgcHJvYmxlbSBpdCdzIHNvbHZpbmcgd2hlbiB0YWtpbmcg
aW50bw0KPiBhY2NvdW50IHRoZSByZWFkbF9wb2xsX3RpbWVvdXQoKSBjYWxsLg0KPiANCg0KQWdy
ZWUuDQpXaGVuIHRoZSBidXMgaXMgc29tZXRpbWVzIGJ1c3ksIGl0IG1heSBjYXVzZSB0aGUgZHJp
dmVyIGlzIHVuYWJsZSB0byANCndyaXRlIHRoZSByZWdpc3RlciB0byB0aGUgTURJTyBjb250cm9s
bGVyIGltbWVkaWF0ZWx5Lg0KVGhlcmVmb3JlLCBhZGQgYSBkdW1teSByZWFkIHRvIGVuc3VyZSB0
aGUgcHJldmlvdXMgd3JpdGUgY29tbWFuZCANCmhhcyBhcnJpdmVkIHRvIHRoZSBNRElPIGNvbnRy
b2xsZXIgYmVmb3JlIHBvbGxpbmcgTURJTyBjb250cm9sbGVyIHN0YXR1cy4NCkkgd2lsbCBhZGQg
bW9yZSBkZXRhaWxzIGluIG5leHQgdmVyc2lvbiBvZiB0aGUgY29tbWl0Lg0KDQpUaGFua3MsDQpK
YWNreQ0K

