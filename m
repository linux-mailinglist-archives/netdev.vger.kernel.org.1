Return-Path: <netdev+bounces-215806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF12B3059D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 22:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3C317300D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4C72E972E;
	Thu, 21 Aug 2025 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UhMiP9ua"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A682C0285;
	Thu, 21 Aug 2025 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807210; cv=fail; b=SVVUEqa4bTlzs1sNSmljYxSka7tQQ06+XbSSiZ267km0MdZN/wD2rurf8V8dxyaHN/VFR8Mpgz4X17GgzAaFqca374a3viNEE3ci/+GfEenkYEGlNDWPRfS49jbLbG+kEhHyo2T2N5HyE/rIp8JhhToi0sfB6dUl/MgZx24XLfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807210; c=relaxed/simple;
	bh=33Ssn1Zhn5Nc6+covCwp23kBOZrjb8+niQAT3YUUetk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tIPR8ePQ2aFC/fynDsqHtd5II1nMIWpsVVfvqTyQj50Ri2YpTwtpGq82et2d0+U5dZyU4wlQ6nq67LSsXuTM62K4LsBVpZQV7Ngu1bYEV0xfru5grmFm9Xr/yxfNW7k7Gs2DVDOtbm7L6QNMxaqg6NoBRGasgzKK0PPoKb+IimA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UhMiP9ua; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEH5opuHqRuRiEiOjTpfYxCJSzh0rW2vohqPpbcwX0ow0+/UYL91csKLwLp/ZVydyD4L5GeetTBvywjqDo+Bm4eR3henoHG2V2OwSWJnCY91ueZGqc//m1hvt23LhZwZSbGy2B6hq6shlbLmxhPlGaPZ1Be0oDYu+JnLe1Zd/ZltGJdgKy25zD7zep5SpRH4LlPs2o7y7rzMZItSuOP8HDuY8qHA7GVIAxFtAjzc+46a5XXENRfimSUcHuAZf0hPX4dgZ+OCvZ9XcOa0GgugpfOtEtQH4tYqtaIANHl0GFVi02+k61kzn8TRK/03Wk5tFwuaPJXd90xU/TDK/s1ZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33Ssn1Zhn5Nc6+covCwp23kBOZrjb8+niQAT3YUUetk=;
 b=uv5PLZmW2wAcbRJ8QZ9E5seE6or0CYRIbyvPdBU7fsHu+puSxaVTunpDjMqtXBfq2FV4RA2IDpNCk03z2WDmm05gwAxl29QJ/475c4sBnO5gvWJeKOvbVLU/z+jyJFtZ6mYVNnCPh8zlkdt4AoayYrZsxSIlXzQOPims0Pd4ov4SD0PfS9Mws+zEXyDuYx+1jQSMSNXQ5BkBa4M/19+rtHpJ5WTt3/0cEnACbRFZd4qJyvouoO7PWVd5Ulug3zs+U+jkpR/3tBPGUAJUZbX7TXcIiJbfv4ehXxoijjH+Gv66O4hKGIvD1luW53RMkc0G/ZEUfmNyzR9PAXOr3Zcmaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33Ssn1Zhn5Nc6+covCwp23kBOZrjb8+niQAT3YUUetk=;
 b=UhMiP9uaxtIgVgIAHM3X25+/pd9Nn14CzBHX89zzJxIN74ZtVi+K2NG6r7lExY7IClc967W906/v/Vw/HeVViXIJAUkqENPbTkWLXLT9FuiwaMjb/6WZePNX+/ZacsxGDDpvnOQFZSb9bE18yIunm4QfiJpQR8lLucdwGzj41FxPiTwwwDp5Vy1RS4gfypnI0uZmuB1jYtJjIIP20RTbA1UO0bURewp9dFjWjXzwcAYL5AKMYGDcj/VMeo+9jeMPYd1atp8u0zoLCTsiuTPAlNnD2XSFCC+eViuKmZ54wD2WTCn/JfQhqnezoU5BKxi0mhetJIpMB/82s2ssfzO4nw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB7406.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:445::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 20:13:24 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 20:13:24 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>
CC: "olteanv@gmail.com" <olteanv@gmail.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "Christen, Peter" <peter.christen@siemens.com>,
	"lxu@maxlinear.com" <lxu@maxlinear.com>, "john@phrozen.org"
	<john@phrozen.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"yweng@maxlinear.com" <yweng@maxlinear.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "bxu@maxlinear.com"
	<bxu@maxlinear.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>, "ajayaraman@maxlinear.com"
	<ajayaraman@maxlinear.com>, "hauke@hauke-m.de" <hauke@hauke-m.de>,
	"arkadis@mellanox.com" <arkadis@mellanox.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"jpovazanec@maxlinear.com" <jpovazanec@maxlinear.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Stockmann, Lukas"
	<lukas.stockmann@siemens.com>, "lrosu@maxlinear.com" <lrosu@maxlinear.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "Schirm, Andreas"
	<andreas.schirm@siemens.com>
Subject: Re: [PATCH RFC net-next 22/23] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Thread-Topic: [PATCH RFC net-next 22/23] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Thread-Index: AQHcDuf7846RS4sgEkqqTJthT32tBrRte+qAgAAHDACAAA9PAA==
Date: Thu, 21 Aug 2025 20:13:24 +0000
Message-ID: <a4048989adc1724a8aff80f954b9dfeac2bfa9b4.camel@siemens.com>
References: <aKDikYiU-88zC6RF@pidgin.makrotopia.org>
	 <59f32c924cd8ebd02483dfd19c2788cf09d9ab75.camel@siemens.com>
	 <aKdxCpOEsX--ESpB@pidgin.makrotopia.org>
In-Reply-To: <aKdxCpOEsX--ESpB@pidgin.makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB7406:EE_
x-ms-office365-filtering-correlation-id: 77fb0461-f014-4d85-342a-08dde0ef2ed0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SkpVaDFTa1lPZTg2TUNYMUliVnptbCsxMGFiQTVSbXJIdjlpWjRGMFZFb3V3?=
 =?utf-8?B?ZGJJUzVrWm5GQ0Z0RWJLTEFvUUY3bzhkUjN1cEpLYzBtc1NSWHM1Um5sOEhi?=
 =?utf-8?B?M1Z2ME5HWWJFZHhrbmU4VHFORFI3YzdVMUVsN1V1dHdmbCt6K2M5OFlvaHJS?=
 =?utf-8?B?RGNsUklsUmY4TjBxYWpqYnpJMWdwT01XSWw4aEpZK2JVRVFLVVg1ZzZkUGJP?=
 =?utf-8?B?SnMvajJPWGpPekJGbzBTOFk5ODJjMUVPb2NOZlRLSENJaURjNmpyMmNQbUR3?=
 =?utf-8?B?WGxqcXhINXRKR0d3eTZheEJZM214OHhtWmpVemdoeHp1T3hId0xDeExWVlZV?=
 =?utf-8?B?ZHpqZVFTSmZueCt6ZGVncGpXREM4Y2xYb2ZLTlBkekZySFlPVjZaTTZwSytq?=
 =?utf-8?B?T1MwaDZJdFE4eW15SFFubGFhZUJ6WWdDSE9SczZEL1pVam11MUpBMTE2WTdS?=
 =?utf-8?B?RW5pVnNCYlRIT3l0NXJCOEIzQ3l2QlcyeU5vSW4zTW13SVFIclgwQ3BNcTRa?=
 =?utf-8?B?cEpwTjFwNEVHbDVLdUtPekVCd2VnOGc5VVJBckVPRTdXa3FPdEVKT2RWUkQ0?=
 =?utf-8?B?TXJkWDY1K0gwRi9SUS9DOHZJTmZacld4N2VuVnVaOUpBbi9GdUZhZUNRa2Z3?=
 =?utf-8?B?NGQ5QkFlM0xTTXlXZ0FlNVRzVFh2dC9oNWp2dDFiSEF5ZVVwWGEvRUZoUzA1?=
 =?utf-8?B?UnpnZmdVM2t0ckhvMUtkbXQwT2JEOWYzZW5ja0tEZEhlWVBERmcrZkptODlN?=
 =?utf-8?B?WnMxa25HUjJPVVFvbkdKa2FOMEhEbmhKTGdoRysxNWU4NlJhWWV3Rit0ZXcx?=
 =?utf-8?B?OG4ycks1ekluZHZaNG5PMWlkOHhTd2V5eHVKSTBPY1g4TzAwbVJJeEpsbUxl?=
 =?utf-8?B?c3A1UTBUK2FpRmNRUHBZTGV3K0R1RkFTaVpFM2JGT3RqWFZSNTI0MHVpV0ZG?=
 =?utf-8?B?NjZIaTVLL3NLUjJNSm55UTZqTXhFYlhYMFVjdk5RVWJQM05LZUo0ZGRTbDQv?=
 =?utf-8?B?UC9qdE85UWxvb1gxNExVaitxZkszZVNRZExodmJrUTUxNUxwdFdhWkwvYmVs?=
 =?utf-8?B?dFFQckhTL2dlNDlyQXFvSUNoMW5zNWYrOWk4Viszc25LUFB4bDhIK2FENFlZ?=
 =?utf-8?B?eG1GS0IwOHhPbi9STi9UK2pLdzBwY1ZMZ1FJQlhtbThNN2JEaXFUNG9wbk1B?=
 =?utf-8?B?L253Wks4OVN3aWpjQW9VOEVJbjVFdTgzNFJRcHR6Qkl2RXgxbVc0TzQ0Rktx?=
 =?utf-8?B?Nm1PQ1RvUm0yOUNuWFJ3ZEdzVE9lOEpYbGIzTDJHQmtuM1Q1UlcweUVMREZ3?=
 =?utf-8?B?OWhFMlVIWE5CWG5FZ1N5V2ZSS1JrcE9peThidHZ5d3JOOUJHVW1OZzB6YklN?=
 =?utf-8?B?enNBOUk2dmEwKzZYY2tBSXl4b1FsVURYRkJRYU1qY0ZjWVhNY1hmVHZyYzZQ?=
 =?utf-8?B?algzSExkQ3h3YWhrTzNYc3lhdnVkTk03Y0hPaHdMTXBFVkttTWZmclVJVlhV?=
 =?utf-8?B?Y21STjlybEZ5YjZDODhCWFpnZVZ0b3luY0NRSlI3S01HZ2hlbUlORFVUNDUy?=
 =?utf-8?B?NHZRRklqTXYyYk5CT0JJQSsxSWJPcU43RDdocTlHcEQxWEk1akFJTkhLWUpD?=
 =?utf-8?B?bFpGbHQ3S1h6NnlBZllnMkVXSWdhV1hEbW9JQllMN2lVNTNGWng2eWVvKzNk?=
 =?utf-8?B?clR1bmw0c2Z2QndZZ2ZWSVBwRFMxcG9SVjRsWktRdnlvSjNONDc1aEtWaldQ?=
 =?utf-8?B?aUVWZnY3aUJyRmxnVi9IUWwwVFhTZmFiNHhCdG9KNXFhQ3ZadFdGTnpLeUs0?=
 =?utf-8?B?RVByL3BnNFBBemRVeWNUdnY0UkEvS01OSXBITzlYaEFsYjNkS2hhRDZXbjVL?=
 =?utf-8?B?Mkp0STd6VkszdUdlQlp6T2VSLzcrYmtDSjRjeVViMEdFY1ozN0pLN2xRdlFU?=
 =?utf-8?Q?mSSWTJ79Mng=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXQ0RjBOMkhqMnd5L3NrN1RjalduNWUrVEE3QjRnbG9BUU9aWHlZaWxLRDdw?=
 =?utf-8?B?V2FlcXpGeGVxOGJaVTRWcVlLdU4xZmV1bVFKSUZmbHh0dFhLMnVScTRxRzd2?=
 =?utf-8?B?QitQNElUeEljRU1qSDFxekpxU3hSTlJ5OFNoQlhsTkRTMi8xeThiZzJ6NHZk?=
 =?utf-8?B?YzB0bFNjMzVOcTdEU240dks3N3BxOHcrVDFvMGFHMGpBQ1B5VFk5WlVSTit4?=
 =?utf-8?B?Q2hIUFIxN3duZW1uVzdGYkpNNVdtVHl3SGo4Z29GNmdoTUIyQWJnaGV4d05l?=
 =?utf-8?B?ejMyMmlnczd2OXFYeHJGOEpJb2ZSV2dDeHNDa3d0eWUxWWlmUTJjRzVtS2Fi?=
 =?utf-8?B?UFBGbXNpWWhKQlczSkJUakQ5a3kxV29oS3U5bE1HRVpNRkp0Um9ya2JOK3JD?=
 =?utf-8?B?QXJ0RGdEZk9Kd3l0Y0MrN2lHUm1XUnFQcU4zWmZzT3BxYmRCN1NHQXpyZnJX?=
 =?utf-8?B?S2o3T1BKUHU4Q3FrMzl1V0xBWGI4alY2VjBOMVZ1cHp5TStvMGdOVnlyL2FK?=
 =?utf-8?B?RGQzNGt3RmN3TWtSWjM5Y1AySDJmVk1nalVOWWcyZVJldk9aVGFQZWRKaFpG?=
 =?utf-8?B?TUhoYjlRb29GaEVHVzEvaFhFZ0tEazFrTlhHNGMwUEV5VmFIZlRhY3BwQTF1?=
 =?utf-8?B?Q09aa0ZRSW8zVEJ4cGtSb1ZQYUZHOTRWWFl4Unh6RTNSbTlURmFTeTFMb2JN?=
 =?utf-8?B?ZnI1Y2VueDRQY2ZZeXRmOTByOHNDcjdXZnFXVVp2RWlqdlF3dG9ZdGROTDNJ?=
 =?utf-8?B?bEoxN3d1QnNlR2FSUytEYnRnWWJYSEtldTA3bHRmdEN3LzBBV25rZEsvY3pG?=
 =?utf-8?B?Q0Y2dWw1NXh5TENQT25XVFZGMUNoZ3RVOWpUdWR5bzJKMmhZc2dIanNHeUkv?=
 =?utf-8?B?SnB0RmZjbEVVVjEyaGM3d3M3ZGRvSk93ck9OVlF2MDVqcW5LamlWZTE2eGc3?=
 =?utf-8?B?ZSt0d2FuUzFqK25Lbi85WjlJcmJpMyswWE8rdzdjNVQ4MndqNzYzNXp2dWVK?=
 =?utf-8?B?NWlMeVpuZEovUDRGcEd1VWRrcXdUb2dSbnJ3S3MzdG45VmtzYlNTNGJDaUlq?=
 =?utf-8?B?VTVEcGNYU0I0NUxyblFTVHhSakhZWjk0N013ZmtEdE1wa3RadW85dGg4SERT?=
 =?utf-8?B?Q1VueFNpYW13bm5jdkU0cU5LajVybmZsSW0xN1ZFU2FOaXQxU0JNQlJXQVhh?=
 =?utf-8?B?OXJjR2Nna2N0aUFjTFdVOEtQcGpxZDZoSGtINjczNWlIL0JjQkd1N0k1bG5G?=
 =?utf-8?B?TWZ3Q2J4TUZkNnFsTENzQUJaSWhwOUVYK2V3Y1BCNjN2NFV3Szg5Kys3R3Qr?=
 =?utf-8?B?YmFvUVNxY2h2VG9Ta0ZWSVA5NU1Yem5UelpHMWc3YU5HRU56Q2Jzbm5MZ0tY?=
 =?utf-8?B?blVTRFdaR0NCQUVlTEliVUhYelJzdlNxZzVZNDJUZDBxcTg2eG9oMVc1Ni9p?=
 =?utf-8?B?S3RjNTloRlF5R0tHK3lqMUFyQ0ZBdHIrcGhjWXBjR0twVDk1UU9uT2VmZXQ3?=
 =?utf-8?B?b2RkNk16TU5aRDhmcUsyMDVmQUF3ZW5QdjJ0K2VzeGoyYkVrT0RYalRGMGhl?=
 =?utf-8?B?UkhVUXVLUUE0NXdjaVNvcWwwelZFODZNUkdDR250eVh4amhQeGtWZ0owc0Iz?=
 =?utf-8?B?Z2dqSWcvOG5scldNY1hlN3B5SlNJZldiYzFwTUxCRVlJOFVuWGFMYWdJYzBD?=
 =?utf-8?B?R1NlTHcvSytPT0ovV3ZkQ3BnTXRzOXlhaW1rY2ZwTFMySWlrUjRyYnJwWkpT?=
 =?utf-8?B?RDdTMVI3NC9DYW43M0l5eWpiOGIrODFDdnM0eDkwWlE2b2tsU1pIMDFnMWJl?=
 =?utf-8?B?bHJZNmFRUldCdjF6U1lkZW5KQTlTbjYzaU9NL3pYWDg2Qy80bi9tbmE4ZXVG?=
 =?utf-8?B?WHZaVkNQUlNtczB3WnRVTnNqbm9lU3NxMWRZcFVpYnNDQkY4aWxEZjhKSkI5?=
 =?utf-8?B?aENPZUxhdE9yZkNMWERLZk1PQlFDNG12ZUppK0svMjRYSzRWVkJLbWZvVFBL?=
 =?utf-8?B?SU0xZlF0MFlJQjIvV2drNlVocVk2YUl0V3VEcVRGM2RKMGkvU1ZDL2FsaHFW?=
 =?utf-8?B?SUZ3dnZKY0Vmei9zdm11Mk5uSVIvNlFiME0yMU9wbWs1dE9UczRENnY5bzRx?=
 =?utf-8?B?ZlNoVVYraURBY1Y4TWpXWU9GQXZnYkRwUjVjajZGRjFjL2lUaktnSTZjNXJW?=
 =?utf-8?Q?BN3qI0TGzcEkV8p7ZZ7Ehac=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EB34BDAE51B974CB939AC963DC4D7BB@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fb0461-f014-4d85-342a-08dde0ef2ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 20:13:24.3114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y+JgSVshnB721f4loOo0YcrLYOX2SkHm9Mc/qA/R4svVYdsEloKcbHSKiGkfR3Mit17fsWeCzCaHRIFOcbcxCCt5BX0gApFGISld+FlPa/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7406

SGVsbG8gRGFuaWVsLA0KDQpPbiBUaHUsIDIwMjUtMDgtMjEgYXQgMjA6MTggKzAxMDAsIERhbmll
bCBHb2xsZSB3cm90ZToNCj4gPiA+IEFkZCBkcml2ZXIgZm9yIHRoZSBNYXhMaW5lYXIgR1NXMXh4
IGZhbWlseSBvZiBFdGhlcm5ldCBzd2l0Y2ggSUNzIHdoaWNoDQo+ID4gPiBhcmUgYmFzZWQgb24g
dGhlIHNhbWUgSVAgYXMgdGhlIExhbnRpcS9JbnRlbCBHU1dJUCBmb3VuZCBpbiB0aGUgTGFudGlx
IFZSOQ0KPiA+ID4gYW5kIEludGVsIEdSWCBNSVBTIHJvdXRlciBTb0NzLiBUaGUgbWFpbiBkaWZm
ZXJlbmNlIGlzIHRoYXQgaW5zdGVhZCBvZg0KPiA+ID4gdXNpbmcgbWVtb3J5LW1hcHBlZCBJL08g
dG8gY29tbXVuaWNhdGUgd2l0aCB0aGUgaG9zdCBDUFUgdGhlc2UgSUNzIGFyZQ0KPiA+ID4gY29u
bmVjdGVkIHZpYSBNRElPIChvciBTUEksIHdoaWNoIGlzbid0IHN1cHBvcnRlZCBieSB0aGlzIGRy
aXZlcikuDQo+ID4gPiBJbXBsZW1lbnQgdGhlIHJlZ21hcCBBUEkgdG8gYWNjZXNzIHRoZSBzd2l0
Y2ggcmVnaXN0ZXJzIG92ZXIgTURJTyB0byBhbGxvdw0KPiA+ID4gcmV1c2luZyBsYW50aXFfZ3N3
aXBfY29tbW9uIGZvciBhbGwgY29yZSBmdW5jdGlvbmFsaXR5Lg0KPiA+ID4gDQo+ID4gPiBUaGUg
R1NXMXh4IGFsc28gY29tZXMgd2l0aCBhIFNlckRlcyBwb3J0IGNhcGFibGUgb2YgMTAwMEJhc2Ut
WCwgU0dNSUkgYW5kDQo+ID4gPiAyNTAwQmFzZS1YLCB3aGljaCBjYW4gZWl0aGVyIGJlIHVzZWQg
dG8gY29ubmVjdCBhbiBleHRlcm5hbCBQSFkgb3IgU0ZQDQo+ID4gPiBjYWdlLCBvciBhcyB0aGUg
Q1BVIHBvcnQuIFN1cHBvcnQgZm9yIHRoZSBTZXJEZXMgaW50ZXJmYWNlIGlzIGltcGxlbWVudGVk
DQo+ID4gPiBpbiB0aGlzIGRyaXZlciB1c2luZyB0aGUgcGh5bGlua19wY3MgaW50ZXJmYWNlLg0K
PiA+IA0KPiA+IC4uLg0KPiA+IA0KPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gKysrIGIvZHJp
dmVycy9uZXQvZHNhL214bC1nc3cxeHguYw0KPiA+IA0KPiA+IC4uLg0KPiA+IA0KPiA+ID4gc3Rh
dGljIGludCBnc3cxeHhfc2dtaWlfcGNzX2NvbmZpZyhzdHJ1Y3QgcGh5bGlua19wY3MgKnBjcywN
Cj4gPiA+ICsJCQkJwqDCoCB1bnNpZ25lZCBpbnQgbmVnX21vZGUsDQo+ID4gPiArCQkJCcKgwqAg
cGh5X2ludGVyZmFjZV90IGludGVyZmFjZSwNCj4gPiA+ICsJCQkJwqDCoCBjb25zdCB1bnNpZ25l
ZCBsb25nICphZHZlcnRpc2luZywNCj4gPiA+ICsJCQkJwqDCoCBib29sIHBlcm1pdF9wYXVzZV90
b19tYWMpDQo+ID4gPiArew0KPiA+ID4gKwlzdHJ1Y3QgZ3N3MXh4X3ByaXYgKnByaXYgPSBzZ21p
aV9wY3NfdG9fZ3N3MXh4KHBjcyk7DQo+ID4gPiArCWJvb2wgc2dtaWlfbWFjX21vZGUgPSBkc2Ff
aXNfdXNlcl9wb3J0KHByaXYtPmdzd2lwLmRzLCBHU1cxWFhfU0dNSUlfUE9SVCk7DQo+ID4gPiAr
CXUxNiB0eGFuZWcsIGFuZWdjdGwsIHZhbCwgbmNvX2N0cmw7DQo+ID4gPiArCWludCByZXQ7DQo+
ID4gPiArDQo+ID4gPiArCS8qIEFzc2VydCBhbmQgZGVhc3NlcnQgU0dNSUkgc2hlbGwgcmVzZXQg
Ki8NCj4gPiA+ICsJcmV0ID0gcmVnbWFwX3NldF9iaXRzKHByaXYtPnNoZWxsLCBHU1cxWFhfU0hF
TExfUlNUX1JFUSwNCj4gPiA+ICsJCQnCoMKgwqDCoMKgIEdTVzFYWF9SU1RfUkVRX1NHTUlJX1NI
RUxMKTsNCj4gPiANCj4gPiBDYW4gdGhpcyBiZSBtb3ZlZCBpbnRvIGdzdzF4eF9wcm9iZSgpIG1h
eWJlPw0KPiA+IA0KPiA+IFRoZSB0aGluZyBpcywgaWYgdGhlIHN3aXRjaCBpcyBib290c3RyYXBw
ZWQgaW4NCj4gPiAiU2VsZi1zdGFydCBNb2RlOiBNYW5hZ2VkIFN3aXRjaCBTdWItTW9kZSIsIFNH
TUlJIHdpbGwgYmUgYWxyZWFkeQ0KPiA+IGJyb3VnaHQgb3V0IG9mIHJlc2V0IChieSBib290bG9h
ZGVyPykgKEdTV0lQX0NGRyByZWdpc3RlciksIHJlZmVyDQo+ID4gdG8gIlRhYmxlIDEyIFJlZ2lz
dGVycyBDb25maWd1cmF0aW9uIGZvciBTZWxmLXN0YXJ0IE1vZGU6IE1hbmFnZWQgU3dpdGNoIFN1
Yi1Nb2RlIg0KPiA+IGluIGRhdGFzaGVldC4gQW5kIG5vYm9keSB3b3VsZCBkaXNhYmxlIFNHTUlJ
IGlmIGl0J3MgdW51c2VkIG90aGVyd2lzZS4NCj4gDQo+IFdoYXQgeW91IHNheSBpcyB0cnVlIGlm
IHRoZSBTR01JSSBpbnRlcmZhY2UgaXMgdXNlZCBhcyB0aGUgQ1BVIHBvcnQgb3INCj4gdG8gY29u
bmVjdCBhICgxMDAwTS8xMDBNLzEwTSkgUEhZLiBIb3dldmVyLCBpdCBjYW4gYWxzbyBiZSB1c2Vk
IHRvIGNvbm5lY3QNCj4gU0ZQIG1vZHVsZXMsIHdoaWNoIGNhbiBiZSBob3QtcGx1Z2dlZC4gT3Ig
YSAyNTAwTS8xMDAwTS8xMDBNLzEwTSBQSFkgd2hpY2gNCj4gcmVxdWlyZXMgc3dpdGNoaW5nIHRv
IDI1MDBCYXNlLVggbW9kZSBpbiBjYXNlIG9mIGEgMjUwME0gbGluayBvbiB0aGUgVVRQDQo+IGlu
dGVyZmFjZSBjb21lcyB1cCwgYnV0IHVzZXMgU0dNSUkgZm9yIGFsbCBsb3dlciBzcGVlZHMuDQoN
CkknbSBhY3R1YWxseSBjb25jZXJuZWQgYWJvdXQgdXNlLWNhc2VzIHdoZXJlIFNHTUlJIGlzIHVu
dXNlZC4NCkluICJTZWxmLXN0YXJ0IE1vZGUiIFNHTUlJIGJsb2NrIGlzIGJlaW5nIGJyb3VnaHQg
dXAgYW5kIGRyaXZlciB3aWxsIG5ldmVyIGRpc2FibGUgaXQuDQpJJ20gbm90IHByb3Bvc2luZyB0
byBtb3ZlIHRoZSBkZS1hc3NlcnRpb24gb2YgdGhlIHJlc2V0LCBidXQgZWl0aGVyDQp0aGUgYXNz
ZXJ0aW9uIGNhbiBiZSBkb25lIHVuY29uZGl0aW9uYWxseSBzb21ld2hlcmUgYXJvdW5kIHByb2Jl
DQpvciBzdHJ1Y3QgZHNhX3N3aXRjaF9vcHM6OnNldHVwIGNhbGxiYWNrIG9yIHRoZSBhc3NlcnRp
b24gY2FuIHJlbWFpbg0KaGVyZSBhbmQgYmUgZHVwbGljYXRlZCBzb21ld2hlcmUgYXJvdW5kIGlu
aXQuDQoNCj4gV2UgY2FuIHByb2JhYmx5IGRvIHRoaXMgc2ltaWxhciB0byBkcml2ZXJzL25ldC9w
Y3MvcGNzLW10ay1seW54aS5jIGFuZA0KPiBvbmx5IGRvIGEgZnVsbCByZWNvbmYgaW5jbHVkaW5n
IHJlc2V0IGlmIHRoZXJlIGFyZSBtYWpvciBjaGFuZ2VzIHdoaWNoDQo+IGFjdHVhbGx5IHJlcXVp
cmUgdGhhdCwgYnV0IGFzIHRoZSBpbXBhY3QgaXMgbWluaW1hbCBhbmQgdGhlIHZlbmRvcg0KPiBp
bXBsZW1lbnRhdGlvbiBhbHNvIGNhcnJpZXMgb3V0IGEgcmVzZXQgYXMgdGhlIGZpcnN0IHRoaW5n
IHdoZW4NCj4gY29uZmlndXJpbmcgdGhlIFNHTUlJIGludGVyZmFjZSwgSSdkIGp1c3Qga2VlcCBp
dCBsaWtlIHRoYXQgZm9yIG5vdy4NCj4gT3B0aW1pemF0aW9uIGNhbiBjb21lIGxhdGVyIGlmIGFj
dHVhbGx5IHJlcXVpcmVkLg0KDQpTdXJlLCBpdCBnb2VzIGEgYml0IGJleW9uZCBiYXNpYyBzdXBw
b3J0IGFzIGl0J3MgYSBwb3dlciBjb25zdW1wdGlvbg0Kb3B0aW1pemF0aW9uLCBidXQgSSB0aG91
Z2h0IEknbGwgYnJpbmcgdGhpcyB1cCBub3cgYXMgdGhlIHJlLXNwaW4gd2lsbCBoYXBwZW4NCmFu
eXdheSBhbmQgaWYgeW91IGFncmVlIG9uIG1vdmluZyB0aGUgcmVzZXQgYXNzZXJ0aW9uLCB0aGVu
IGxhdGVyIHBhdGNoaW5nDQp3aWxsIG5vdCBiZSByZXF1aXJlZC4NCg0KLS0gDQpBbGV4YW5kZXIg
U3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

