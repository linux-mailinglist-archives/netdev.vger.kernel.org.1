Return-Path: <netdev+bounces-147536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C91E9DA130
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 04:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5EE116875F
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 03:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3E443ABD;
	Wed, 27 Nov 2024 03:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="E9YM4kJq"
X-Original-To: netdev@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021106.outbound.protection.outlook.com [52.101.129.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143B51114;
	Wed, 27 Nov 2024 03:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732679291; cv=fail; b=lNyJbyXz8F8XnyNfkqH4x/mmQKkO7lhOkqhp71QtZHT2324Ixebx2+4wkyfuA+19DymElvqw2U+rBEV2l4R+7ppSBPYGv9LfLL4/YrOUs50npXQa9V4gOUb17oYirb1sx2t1eh2Anho9hbkKUjA27SBFjcvYCUwbldafQWz+2oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732679291; c=relaxed/simple;
	bh=lmbmk1oOiWyVJ3mrwqiUD6rojCGMzZNvuLQxQAmG0NE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F6OMAhf/G7PJ9NhZt+76YqdLzABRZ8gulzxxTh7eLtixtlNURBnYSs/6etKhi8baun7Ls9lIqTMaA/uzum5KdhSV614OPPsyFwv1DFNfhim8K8/9fES3xvAuWv0tYtRjkEdD7ByVbTmY7OEWUkpU72EkG68cbnquvF0zMFkgrHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=E9YM4kJq; arc=fail smtp.client-ip=52.101.129.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrGcOtVCkjhusYkW0ZMeZ3n6ss58PeUHeUQxvRNcacnOWHxbJe6+TmXLbcZv4R8qyzOdsxQYmlFU3KeX4uDuLw+6ujhfiztODQmP35mdhhJ6SlXhlIcacuooZO/1nG+9Tgd5T9VqF7EzfNni0zzAlOE36nJqY1dmR2ofMjrK75W1aPJtaSoR7T+q1s+/ld22E7kgIaJqEYbQA8TgVCramG17bWUeIEZe1N9AxIf/p32qBET+hv1UhM2tiP5hfM1QhZ3pX5am0XAiuXDVgPU2vv29z3wZzHoGBY2Rg3pBNHEjpWP58NR98DrJz4WgfwujW5PGtH+zaJHKBIYHftsSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmbmk1oOiWyVJ3mrwqiUD6rojCGMzZNvuLQxQAmG0NE=;
 b=EZ3LwbP02R0ilX/DsIrpN1eKzuEi+THeXAVHw+bVNiv30LjRmEXomK/LW7XEqrf51roeHCHDcBrT03sNfjIwu5hDtg27gUn6IZiJ6xTLh4R2pL9k2WwxjEWgQyq7T91DHXivBFjVHQoK1s6QDpfRdcBl5jS7BLa/qbiQ2avd5dNVASTSeLsDYfXcuUFVBbqPnKCv8Ht1BujfXbi4X/+0wszuMzDxBK7FInUc445UnUM8+OgXQEeIIsKr2r1quYuBg6eOCcq/MAWDWHFJY+75ahLyb3GAzd8nXwkGV5rpToVDbWrH/RPzNqchkLSaMrSGQGdgKlUbgt3SSQPanhXcHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmbmk1oOiWyVJ3mrwqiUD6rojCGMzZNvuLQxQAmG0NE=;
 b=E9YM4kJqxNtqKSRMcs81Lzxz/p02Sl2hTH6qY5Clav4wIsvWskc0SEqa88XAqsP3iZ7LUBV8l1+oQxSGVR3DPMDZQUqVedFWBTuVIRarqmY4b4KVU7cmpUEWTcdPzinasp8aaNFtRBIi/HrFQuboIqgvBq2nqqGqjhIEYL40i7qTh60EYiv24/nt+1Dfn/lSukq+Q8lnySAwFsQrJpb8GxGJrvIlSXnfNltjkH54v8qt7giJHYx42jw5jJpLO3zH4VoElzZPEJLeHO6bbcUknnfeiEDaHHEkgWMDShqKjZ1LUi0lKlH/iDTM+BhHf0pmGsXvrjJxog3ORxCLba1yNw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYSPR06MB6291.apcprd06.prod.outlook.com (2603:1096:400:42f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.10; Wed, 27 Nov
 2024 03:48:03 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 03:48:03 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "ratbert@faraday-tech.com"
	<ratbert@faraday-tech.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0LW5leHQgdjMgMy83XSBuZXQ6IGZ0Z21hYzEw?=
 =?utf-8?Q?0:_Add_reset_toggling_for_Aspeed_SOCs?=
Thread-Topic: [PATCH net-next v3 3/7] net: ftgmac100: Add reset toggling for
 Aspeed SOCs
Thread-Index: AQHbOyDb8WIeGc6g8kG8NwvmN/PMtbLH0u+AgAKz07A=
Date: Wed, 27 Nov 2024 03:48:02 +0000
Message-ID:
 <SEYPR06MB51343FAEFF3B4F6B3A9DD0959D282@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241120075017.2590228-1-jacky_chou@aspeedtech.com>
	 <20241120075017.2590228-4-jacky_chou@aspeedtech.com>
 <32a2d3d7f95a4f865ce4b49b4f8246587be48128.camel@pengutronix.de>
In-Reply-To: <32a2d3d7f95a4f865ce4b49b4f8246587be48128.camel@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYSPR06MB6291:EE_
x-ms-office365-filtering-correlation-id: ca030fbb-cc60-414a-ea2d-08dd0e964b68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?dlA0S0hadlNSNmw0V0thSGxDaWFMRTdwUmZuZW1GeTAxT1lWU1hWQllOTllJ?=
 =?utf-8?B?Y2ZVeUlKT29yY3RtbUh4TWtleWRLM1hJMTE3TmtnUGpRbGIvZVVJVzdFYmhp?=
 =?utf-8?B?L0luUCtwLzdjRkp2Z1lyVDJLVW9wQTRDc1UzWENKM1ZEeVRLZWF5Z3NEZW9i?=
 =?utf-8?B?T1Vtb3RaNk5taDU0WmViUjdEeEhqbjJaSEpBSXk3eldmcktnU1djZGNvbEdT?=
 =?utf-8?B?dlVoVWRETkplV3gyVGVGanhvSUFTNGMwRlNta3hvOUdyVlVOcC9tRHZpVTE2?=
 =?utf-8?B?ajgrY01LeHZnSDNpV3BZa2ZOamZaa25ybXBMWk8ybDFaTFJrU3NEKzk1b29o?=
 =?utf-8?B?NU4xS3RSQmR0MG1sRWc2d0NLMjlNd0hxaktDUkN6bGxMekFaWHJRaGZBbGRi?=
 =?utf-8?B?N2djbURkTXVCemhlY082MWF6a25rZjlDTnc5OGF5dlBzMzBKSDl6eEt5MG4x?=
 =?utf-8?B?dWNCQ25PRk5wa2Y1MCtBdFdVOWRVWWtwL1k0bkFPSVZJSFVWMUcrUW5vek8z?=
 =?utf-8?B?aENlU3V1cmFjVkx5OXpZV0diNFRwTVVnaVpHWktyU0FhRDJTaEMybXBqL3Y4?=
 =?utf-8?B?eEJaNHd2aHJ4SERiekJiSkhxY01ublhCOGlKY2V3YzNibE9nM1kvblJyZk1V?=
 =?utf-8?B?dVlGOWFhNFQzblNQbGhNcDcwOVBDdFNQRnBqdlQ0SVVQMEF2YkNxMHhkb1R4?=
 =?utf-8?B?U3ZDcWpUL3piV0xXZ25pYXNTTTRTTjlJUjJ3eUR3dFh1VFJ0VlM0akdwZjRK?=
 =?utf-8?B?d0ZiZSs2QWJkbHc3L3pnVVcwOG9Yeml4bkZYOEZxTXcwUTZYWWNHb00zZEdm?=
 =?utf-8?B?emVnRVU4N1B1NEZvenRXUzhoUzZwV1RZNmVxTm9kREJxcU5HOTFwSEdiUEFC?=
 =?utf-8?B?ZUM1M25VRW1uNHdTOStJajNjdkRDd3JHSUdYa1BFWWtydXoyQlhrVW82VWFC?=
 =?utf-8?B?RUpXWTJlVE1MQ3FTMmkvQ0dlSjdyZXVMSVN6eVdBVmpRYWVXZi95WmdGYmdK?=
 =?utf-8?B?MkVGYTE1VEJKOXZCRTRUV1FheTRVWlpvWHlMam04M1pvdVBUbTl3aXNYVmg2?=
 =?utf-8?B?VXVWUXdtenllb1hmMjFjRE5MZ2hPVHNrVFFsVHN1eVVHL3l2ZVRZQnlRT2x3?=
 =?utf-8?B?eUhuRHZjQjZ6VnVXdWNxV2ZuVUF6WUJjbkVTUkxSQVh4dWFRWS8xOFNTcWpH?=
 =?utf-8?B?VDZpL1hMdXF5WlhMZUMwcDdEazBJS21PLzU3ZkEwSUNndDFEaTB3Vmc3cTNS?=
 =?utf-8?B?amNhalloZXNtck1nWlhqbXNOQi9iVSswTkpZZGZieER6ZDh2MlFMWGVjcGtM?=
 =?utf-8?B?OVVoUlpMV2VneGNtY3lxTHplV3pUQzM0VW92NXl0WDQ3WDdDSWMzTkQvUHFI?=
 =?utf-8?B?YUlEMHg3ckp4Y2VlOExSQXRKY0pYN2dXMHpHdUhYWEpMT0FjQjhvOFJNeEh0?=
 =?utf-8?B?WnE4Vi8vRTc4Q3ZwSVVWRXJmMTlqZkEzbWpQZ29USlFOQlM4dTZuMGxDVnNS?=
 =?utf-8?B?Tk90cm10cDdHTHlSdHRqR29FeHUwK2tqNjVnc0tBZ05MUjNpaitWZXlxemQz?=
 =?utf-8?B?Mk81cFRpNzV4clJmeWR0djk5c1BpVFhUM0ZsTlZ0Zi95THRCU0tPK0NTY1Fl?=
 =?utf-8?B?N3pPeXFRcHc5OWY5cEkxaDU3RU9nYVRlVUNENEx0Ky94YTdkdTZ3N0NTeDIw?=
 =?utf-8?B?Ykc3ZGJlWVRFZjJPdk1rL0dFbmV0dEEwQXBMa09lVXlHd3JLNGZZOUZCK3FN?=
 =?utf-8?B?cHZIcFZaU1ptR0E3NGdDU21QaU04bnphZFV1cDNVbmExLzhjN2FZTXFkYmw3?=
 =?utf-8?B?RmxRYXllTmxzKzg2blY4MDZiYVpLVWJGMkVXbHJVRUdYWHdYK2tBOStjMDBx?=
 =?utf-8?B?dE9Cd2diSFdmdGd2cnpQdHpoWmx4SmxRdXVZbVpHL2djSmdmUHQ3VmVobUZP?=
 =?utf-8?Q?w/8gCgbQpwE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TTBXMlVxTVB5VkNpOWExcjdZditKQzhCT1BDMzM0bjB2cnNkRlJETXV1a1ll?=
 =?utf-8?B?enJOTVVLdzQzemdIdEF5Yk1qZW5UaXUxTzIwSXBBS2w2dGlDU3VwSXp1KzNS?=
 =?utf-8?B?clh5dFVjcUJHelZHQ09MMDdMOTNuSUVNek1WajdSL1hISzB0TEt6WUw3V3Zn?=
 =?utf-8?B?RGpnZjN2aUJyMTV0N3NjQU81UUYvT25XSFlFdERVYkV1U1VZWVZGRXltQUVp?=
 =?utf-8?B?eldaUDBhTHZHQVU0ck9Xdk42MTJ4TklGY01iaENDNVIxVk15SURmZ1FZWE9o?=
 =?utf-8?B?bUtaMnB0SDhUeXJPeFBZejlhNWJwaTYvbFRRcUJkM0xYc1diQW9vbVA4RDJQ?=
 =?utf-8?B?bW1ZYzV5bVNTQWFTZFBDL09mR1dneHE0dlZjMVEwRTlDN0Vqdk1YanJLeGZy?=
 =?utf-8?B?cGdPaVdxQjlQNnZyQmE0YnV5Tm5tOURpT1ovZXpHOEZMS3pSSXpOSU9LdEVB?=
 =?utf-8?B?UHFEWllia1IwakIvRmI1UFB0eDdZTUc5Smt5Um9NOERVZjZBZ1Q5aGIyUXZl?=
 =?utf-8?B?NCtUZ21Pa3NoazhSR1ZNRGVFdEV5TEFxRCtnV1gxZjZDdnRnSzRONW92cG1M?=
 =?utf-8?B?YVNkYTlSak1iUmZJSTdJaE1uSUlLUmtWbDBPUWNDZFBxOEIyVHEzSjdqSnJJ?=
 =?utf-8?B?cUZTTnJROEpORHE5dXZSZEZBU3lvU1lpT0h6L0Y5aGpQdU9ieEtkZ1VsUHpE?=
 =?utf-8?B?V2RSaWVQU3ZuQ3lxMFRZRHVYNkoyeFlrVjh0cFk2TzRKNTY0c0k4aWRabEg4?=
 =?utf-8?B?U2VocHVWVnozZUwybVNkblpKZ0c4RzJqMy94ZGNCbnJnRmJZWXVDWFBicE9r?=
 =?utf-8?B?MTU4RG1NUGdLMTJmZmptTFF5TThSQnY4WmdPQ0VJMDhUMGdJUkVxU0JEV2Vq?=
 =?utf-8?B?WGVqYTd3TjJSYTN5T082dnhOWHpoRnlqMnYwUnp4dThWdmM0cEVWY3JrSjIy?=
 =?utf-8?B?NFlKWTFIdlNJeVBwQWZOMkhMOWVOc3FSTzVXM0JBUTN2amZFTnlNa0ZvQ0lY?=
 =?utf-8?B?T3psMkpKWjVGT2hPU1lxT1JEaUROZWN2Y2swTXJoaEhzNTBKU1YzR25EZGtO?=
 =?utf-8?B?TVlUQnV0UkFYWGpNOGU1M1ViS01obmFmMmVJcjRkblFZay9QL0F0K1YrU01S?=
 =?utf-8?B?UHZBVk12QU5UNVdhbTdYbjl0M1BaU0dtek9WTVNpNFB2YVBMb29DT1VubUdI?=
 =?utf-8?B?TWxBWEtRSVpzTUVUcjN4emEyaURXWkROR010V3FYU09nYS9uRDZiWFBaZjRN?=
 =?utf-8?B?ZkhPYnhpQmN6bHZYM05YYzVPVjgrTWF6cnhFd253NHV1T1ZSaFlvSDY1UThp?=
 =?utf-8?B?Tnh1NGNsMmlFcTdQazBwc2cvTWpvWk9ZUDhrdFNCR3htUVB0YnVCU3FIaVdR?=
 =?utf-8?B?bTVDRm03alAvRW9qalBDNXlXc2d2YjM0UHllQm1tT04xOHRMMm50MGxjMGth?=
 =?utf-8?B?NWlMZEg2N3JJQjl6MEVkM2VXTEpjODFucTNSSWd0b09HOFRPamphUUFPT1l3?=
 =?utf-8?B?L05KRnhWNExkWXhreWVYZktoMUhjd2NmeEJsRDU1UWpPQ2RrVzBiSHltZmNL?=
 =?utf-8?B?R3NmVi81N1ZjV0FiNnJqeUZPU3luc1VBcmMzbCtqekt2a2ZxZ01NV2diY2Vu?=
 =?utf-8?B?ZW5MQW9uTmVQZGNvWVhDaHV6QmY3bTFTZFhhNFo5Y0dWZkZTZGZldUd0U2dY?=
 =?utf-8?B?NDBra2drZDVJZm1jZTB0MXB5aGZiNGMvZ2hFbkRFeEhTZmtqNWl1VDBUdVgr?=
 =?utf-8?B?NDl2OElzUE54enBNTWFIVjlxVHhldmtBUHVnOGpYVDNDS2FQNGtYbG1MVWVs?=
 =?utf-8?B?N0RwOUJZRlFCSlVXYjJuanR3SXcyd01JdXBLSVFlYmwyUy9WUlJ3L1l6S0lH?=
 =?utf-8?B?YmxHZ3E1TEVTM3dWVHMxNGE3R1ZYZko0TmZtdUR6R2JHWmJOY1FLa0JUSFRU?=
 =?utf-8?B?ckZHS0ZSWXNONzNZb0Y3c2ZKVTdPWHd5RTJqQWU0NnZvMHArYWpJV3BaeFBO?=
 =?utf-8?B?YWFBb0hlYVJqUitpZlIvWUtxY2Y4Z2VCTW43dEk2MFJ1US9pSGFjTTBIYlFw?=
 =?utf-8?B?SEhWSGVFWGhzYm5FWEtoRHdoNHdwcDN5ejlwTkxucmcrTTZ6MlBualJBRTF4?=
 =?utf-8?Q?P99s2CV6oU10IukuAB7Pz8KHy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca030fbb-cc60-414a-ea2d-08dd0e964b68
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 03:48:02.9355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYN4LCLR2JTaBuvHfSw6cpOCVEb3GXC5WWxwR1gftpWvdFacB47TVsPEsct5N17ndY7EIY1eC0MNtyuNzSY9eTAfjrAPftMkEqw1O7swivE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6291

SGkgUGhpbGlwcCwNCg0KVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5Lg0KDQo+ID4gKwlwcml2LT5y
c3QgPSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X29wdGlvbmFsX2V4Y2x1c2l2ZShwcml2LT5kZXYs
IE5VTEwpOw0KPiA+ICsJaWYgKElTX0VSUihwcml2LT5yc3QpKQ0KPiA+ICsJCWdvdG8gZXJyX3Jl
Z2lzdGVyX25ldGRldjsNCj4gPiArCWlmICghcHJpdi0+cnN0KQ0KPiA+ICsJCWRldl9pbmZvKCZw
ZGV2LT5kZXYsICJubyByZXNldCBjb250cm9sIGZvdW5kXG4iKTsNCj4gDQo+IEFtIEkgdW5kZXJz
dGFuZGluZyBjb3JyZWN0bHkgdGhhdCB0aGUgYXNwZWVkLWc0IHRvIGc2IHBsYXRmb3JtcyBkb24n
dCBoYXZlIHRoZQ0KPiByZXNldD8gSWYgc28sIHRoaXMgbWVzc2FnZSBpcyB1bm5lY2Vzc2FyeSBu
b2lzZSBvbiB0aG9zZSBwbGF0Zm9ybXMuDQoNCkFncmVlLiBUaGVyZSBpcyBubyByZXNldCBwcm9w
ZXJ0eSBmb3IgYXNwZWVkLWc0IHRvIGc2IHBsYXRmb3Jtcy4NCkluZGVlZCwgZXZlbiBpZiB0aGUg
cmVzZXQgZG9lcyBub3QgZXhpc3QsIHRoZXJlIGlzIG5vIG5lZWQgdG8gZGlzcGxheSB0aGUgbWVz
c2FnZS4NCkkgd2lsbCByZW1vdmUgdGhlIG1lc3NhZ2UgaW4gbmV4dCB2ZXJzaW9uLg0KDQpUaGFu
a3MsDQpKYWNreQ0KDQo=

