Return-Path: <netdev+bounces-215722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA42B30059
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9432F3BBE6F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405D82E1C6F;
	Thu, 21 Aug 2025 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FafS9SLK"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012046.outbound.protection.outlook.com [52.101.66.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBCD2E11C5;
	Thu, 21 Aug 2025 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794444; cv=fail; b=bsc7cXsJMPB2yiwLcRzD5333719pTjJAn7s4uNnnRkFpMs+93Bc5GcDIOIBuWrAmyXk6mrwQ+7exegv5CgxPMZZKBHQpnZqXO1OJBWWQZ/kF5stueTZz3umyN02u7q0d+UU5PEzY12lKxpyykEjGHaGVcQ+ZFNcPF2R1tLGO7Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794444; c=relaxed/simple;
	bh=qnCCNBVE0allchzUOsm5Cvsuj81E2TeoAjXUV02PQkQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WgoGoloJmBanyalXprZiVmC+qh8gF5IVHph9xVsxAraIKR7lrm/FnmffRtdIp92rqIlf4w9ccc9Yewupbv4z/+M3B/kDUUFe9ILuD22JwIRmbCo9yOwHmThv5TFITulNi3KAjWodonUhLxcbcQ85g+h6IrofzIEQwywGuSjVf+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FafS9SLK; arc=fail smtp.client-ip=52.101.66.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QaQ1Vo1PxQyDb+WXIz2pgMTuKybMjb4dQFFBV9/DehCnnG1DlZaQeKrKQMxxBrqZVUPpRchOd4FzUQjiacy3j7pWWkZOMmDQzI/oQRXDS+/bIfSzZ4zPCaPTe3cqBu4O+yNn3/ZQamSIQmdKJDfVV5wRbEeX6fVyM13eQdjg3MFLwC9r3d2UGRgHu37/a30MyK2BCvvCowGClY46RsrRfqgE4iRY/uLYrvi1Ox9OnShMXp//wK6A9IzsWS5zUR32JE9ptP1KVdJhtpkEJUjPS9RvjdW1UgLI3LUsKLQ3DyYxdtJhZCvQdM+Opy0wZxhlGyYlhmwzYcg7wK+mBsTZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnCCNBVE0allchzUOsm5Cvsuj81E2TeoAjXUV02PQkQ=;
 b=i0BFTeW1iNptBUENUqdFOQHDkQ+HdNnBTDwKNYF3jTXQvVM7Lk9DnsJE9uET0TIhewCalYD+yDRYVMYEARYpBRY5VezaaJcL5uwsXFoRUGVm69P7Wqt4v2Wm+pZp+LyI4mV+9D6GdnK3WeFNrd5JzIe/Ow4CdL1c8gMuud7g44DW7u2xrI18ULQdsyVsMLrSj/Tm1c0q2CFAlUiCmhEfdUJu3ZUwfoqplOKAfFpNi2kViMk5xp/SgqzGZTgMcu95ayHS9OKT1yk/mf1ONEM+JHLEA89V8fsMidcSq59A6cTeYATm0CokEdv52YMkNr58KTeWq98Yw3iyfN3zYlCBiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnCCNBVE0allchzUOsm5Cvsuj81E2TeoAjXUV02PQkQ=;
 b=FafS9SLKCp/kKQ/UQSYeszZp5DeY5W767yGgFog3X5S2stEySzrCsDGPDHPrNfikcTzoDKaXsyAJL3DbIHhKQ2A5+jxvKblgLpkwMGFia813NDsx9ry78mhFK9FDD3b/g0IOswfaHtCuijp59C//diumdiLGMNXhczfx3uIiGFXnYV5pyCOkh5Jc1Fs+JfDLeeQx+JjABjvwFP1Fi6ZzicaKiy+EdFtA5Ul1f6Nkcl6eH5e5Jsmt9u4LLkS82zrMnW53ZR1qn69OYmNH1OpKSzG0KhkWGXt9KET9Thu6ulUFORReXwed+t8TZUFTlfk80ekn68BxAiIn4r1Sk8JzBA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB6130.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 16:40:38 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 16:40:38 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "hauke@hauke-m.de" <hauke@hauke-m.de>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arkadis@mellanox.com"
	<arkadis@mellanox.com>, "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "john@phrozen.org" <john@phrozen.org>, "Stockmann, Lukas"
	<lukas.stockmann@siemens.com>, "yweng@maxlinear.com" <yweng@maxlinear.com>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>, "lxu@maxlinear.com"
	<lxu@maxlinear.com>, "jpovazanec@maxlinear.com" <jpovazanec@maxlinear.com>,
	"Schirm, Andreas" <andreas.schirm@siemens.com>, "Christen, Peter"
	<peter.christen@siemens.com>, "ajayaraman@maxlinear.com"
	<ajayaraman@maxlinear.com>, "bxu@maxlinear.com" <bxu@maxlinear.com>,
	"lrosu@maxlinear.com" <lrosu@maxlinear.com>
Subject: Re: [PATCH RFC net-next 12/23] net: dsa: lantiq_gswip: support 4k
 VLANs on API 2.2 or later
Thread-Topic: [PATCH RFC net-next 12/23] net: dsa: lantiq_gswip: support 4k
 VLANs on API 2.2 or later
Thread-Index: AQHcDud7ImOMxs+gpkCYHt9gbS7LjbRtVtQA
Date: Thu, 21 Aug 2025 16:40:37 +0000
Message-ID: <88bdaad0bb744dc401e94d97aba002431ac0b03b.camel@siemens.com>
References: <aKDhwYPptuC94u-f@pidgin.makrotopia.org>
In-Reply-To: <aKDhwYPptuC94u-f@pidgin.makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB6130:EE_
x-ms-office365-filtering-correlation-id: a0bceca2-7d3a-4767-b53d-08dde0d1757e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ckM5Z3hkcXNnUTYxcnk0ZVdtRTk3L2h5dlEra1Zja3k4b2UrYzJDZ2VJOTgz?=
 =?utf-8?B?dmJ3d2o5aENTMUUvYkhsMEN2Z2VPdHZVQ0dDRXZ0MmlQUDZ2S0d4ak4wdDA2?=
 =?utf-8?B?ODdBQXE3NGN6QzJvVEdoQWo1ZUtlVW42bEltZTAzbGNuRTFyT2hTRDdsUVR1?=
 =?utf-8?B?Yms2LzFLSlRNVWduNG5JUHZRejd6ZlZuQWczek5LcmdLOEF5NktMc1NXblh2?=
 =?utf-8?B?VTRzRVg5bmNYc1A2Uk1wTWU4M1V2NW9uL3V5ZE4xMVRQSldGNUFGbEJjN2VW?=
 =?utf-8?B?ckw0K1VTemlQRWd4YjRwdEpyeDhXRkZTQkwvSXR5Q1VJSHlOQnN3QnlCMWhY?=
 =?utf-8?B?K1VBVW80Qm8zcnoxU05BbzVwQUlsS1JSOXdwUE5UUFVnMCtrTlBQV3U1dGh4?=
 =?utf-8?B?MXlzMjFRZElwYUt0VGZFNWdUTWh0cUMyamh4WUg1Yis1MGpZSXpWRk1ZS2cw?=
 =?utf-8?B?dXdxTFRDUytzbjFPUkJNUHFqbkh2bStrWFhSUWVsYVB3MFVBSDFzWHZJaEl4?=
 =?utf-8?B?azJnWDVRa2lwZlBCSXBuQ2FPbjRzYVljTU1odFgwR0VHMUo5QzkrYVZTcDNH?=
 =?utf-8?B?YVVXZjFxMTlkbXg3eWxneC9VT3dicm1aa3RuZ3FDbHBaSXVDcHNSTGd4em1t?=
 =?utf-8?B?V2hQL0p3OVBacCtYeVpUcHdFc2lBUUd5dzRsVy8vR2U4WGRqYjM0cHd0ZUdp?=
 =?utf-8?B?WllHaEVhZWJybGtaMjZaVmNkS252OHVpUTJrSXl5bnB3cGJuM2pEVEYzQXVj?=
 =?utf-8?B?UUlYWGYwS1VPdElGV2VHQXZ4MUhrdTh1dUw0Wmp6eVZMVTQ5TWhibFN0ZEt4?=
 =?utf-8?B?OGdrNWVCVEJTbHFNazZUTGxuVmt2MzJsMG5jRDNjL3B2SUNOUnNJWWV3c3NU?=
 =?utf-8?B?Ly93Z3MvNmtHTUVHZldTVmY4TmVQb3h5a2VQdE1sNktPNyt6V2NIdlRrT096?=
 =?utf-8?B?aWtNajZUckpKNDljaG8wRkZGSGNkcUhLZVdhWktHOFJJeTFYSkJacnRsaGFS?=
 =?utf-8?B?d3hqMzlJRmlMQ0hsaklBR0xuYUR6Q0FHTUNmWm1OOURFc2lQTXltMklWMjV4?=
 =?utf-8?B?OEhscTRQQXZJcDhucys2dVZCLzFyRGZMVGprMkRod1AvQnRXLzN6eTF6cWZT?=
 =?utf-8?B?V1c1Ylh1QXR5OHhsYUErNEU3M0xUZGdFNGFEc0U2eXFuMzNnN1ZHU0Nac0hy?=
 =?utf-8?B?ZXNwZGs4REVLb3JmVzk1VTJFV05SSzhqbnZrZ3AxazZ3V0U3Y1JBa3J1WWNR?=
 =?utf-8?B?S1dWa25pQ0oxN2Ztanc5aEQzQSs5MVBMV3pNUlhlVmZTaWh1WUVROWh1Zldr?=
 =?utf-8?B?Wkp2UEQvU1FWLzJROEVUNDQxQm9idzZGdVMrKzBZNjNZYm9CcWhSM0g4eWZy?=
 =?utf-8?B?b0w4cTM5cHYwbldIN1U4cG1pNnRsMU9mV3NBM1pXQzVvOEtkVFBkSkR0UnRx?=
 =?utf-8?B?cmtRUW5LeitMRXVkR1MzbzBmdUdjRVdDbDRzNlNlV0YrTVVVOXYyQkVPQ3VZ?=
 =?utf-8?B?V1IxeUw1YU5PeDlZSmpPNUtzVklYVmg5OGVFOTVRdXFxL2FiSWlydTZENDJq?=
 =?utf-8?B?QjVSZ1Y5b0k1YUNQOUd4NWRJbDdqMzJWcW5WOGdDQzdzbEFrRXloUVM4YUd5?=
 =?utf-8?B?VGxiUW1aY0J1VmVuOVZhaW80elNpeXo2bTExR1dzNGorWUlGbGRuWHdFb25F?=
 =?utf-8?B?MnByN3JzTmRrbE0xOCt6dEdqbUtKcThreldZMU83OVp2MlBDS29zOGE4QmFq?=
 =?utf-8?B?VXNUR2tETm50NDJlSlR6Tjg0UG5OQkR5R0xseEJrNm44SXArWHQvNEFMS3c5?=
 =?utf-8?B?YXJIWWF4ck9UUHJndHpUcWMyV0VUblhCUnIrdFpkaUhQaXNhcEhvZ3JkSEZK?=
 =?utf-8?B?ekFKQ3IvM2hBUS9jeUlZRWdKU0JqTFRlRWw1eVZLME1nWDhKNnBKMy9aT05E?=
 =?utf-8?Q?ZQCrPy7bvOVZlWQ9V4At7pCcDazHtweT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dk5sWWFTdE5pTVZYSzVtWTRYZ3RIdk1UQkZ4ZlEzdHhsd1BaM0lid0F3NDFt?=
 =?utf-8?B?bE9QS1g2VC94ZFhOaTNoNDAzWS9tUXR3a0dKMmQxSlhMMnVWVHE1OGNZcmZT?=
 =?utf-8?B?RFZWdk9TdHdOZ0pTVHVram8yRmdpZE5TU1ZKUTA0NU41OFZWTnEzdW9mQzZv?=
 =?utf-8?B?V1kyektDblp1dm9HVGNCUUdEZGVPY1JVb2JBNE82L0VFNXBPdTI1WWl0M1ds?=
 =?utf-8?B?Si92NURFQ2lKNEV6OU04eUFxVkJaQjd2M0dUWTBGR2JWRXB4cFpiaWozc0cr?=
 =?utf-8?B?ZlZ4dGJnSm9tMys0MVZFSkJiaW9ud3VqblFKSmJuLzhOeFBZSXd2Snl1bkJX?=
 =?utf-8?B?b1hjUkdsVytLM05mbnNhRjRDbEFVaUQ5azVZOEp4ZzZBREh3NlBMQ29iMGtu?=
 =?utf-8?B?R2w0dmFaL1JnaGFBeDJYZzVvcW1QMjgvanIvM01RLy9qTnlFbFh6MmNCc0Ex?=
 =?utf-8?B?QlQyeFNPNmRGbC9yTzlXQzdKQUJTaTE5eTJ2UjAxbTJza0tSMTFWMFdHd2Z6?=
 =?utf-8?B?QWpnRk9EU0V2Z25DdXVZLzlUQ1lJbXk2emdJZmo0dmhYK1piczNPVmhCOWdj?=
 =?utf-8?B?SWl2VElvRUlYa3FCTnhmSmErVC9MYzMzT3ZPdEFndHorSmllb1V4cUtJVmY5?=
 =?utf-8?B?Q3d4c3hYVW1xQWgwT2lZa2VoT205RGdQWFA0dDdLblF6LzhVTStiUm9ldkRW?=
 =?utf-8?B?TlEzQ0JSTlZ6aGNSOUh1YlUwaWN6NjBPOTFxaFJkT0xIN3Fha3VUVEl2ZnA4?=
 =?utf-8?B?VFZad2JjNWwyN1JTblVjVGpYd0dDTTZaeEszT1pZTElnUGhPSFRCU2xFdGo3?=
 =?utf-8?B?QWdOQ1FxVk1UcngvcHVGUlJWQkhqR3hqbmxqY0xTZnBJZUg3Q0NWRWpLUUVq?=
 =?utf-8?B?aUM4NTQzTXA0bC92MDlkMnpTS1puYWI3RFVjR1NOd2M5ZVFGK2JieFppVWEy?=
 =?utf-8?B?WDRhRGZNaDBqaUtYcHRHcVNvQ3g0Mjgza3M2ZzVXdVVjQ05GK280K1h5Slht?=
 =?utf-8?B?NzNoYysxa1gzSGxOcTJBenNCK3ROcmV0cS9WYWZPUTZ5bkFva0dOWnV0aG4x?=
 =?utf-8?B?WXNWOE5CRXVSb0t3aVlFVVRrdnhmQVFYVmNPZTlZbGhid1ovL3FJSCs4aUd2?=
 =?utf-8?B?bTBoZndsTGpMU1RUQVNLZEkzZnBWdmQrb1g4OVVnOEEzUG9iaG01MG9MRWRX?=
 =?utf-8?B?azVzT1VvU1krcjdGS0h4NzdDTXNYMThSaWtzTjNwL3NoNUg0VmxqNGJTKzQ4?=
 =?utf-8?B?TVQ3aGJzVkZSSURjeHFKSkJQeXRFWklmb21sL2dhMnRiMzhzbnpxVlhpU09R?=
 =?utf-8?B?RG9rb3hmNVNWYklYQnNlaWwwSlBwREx6UWVvUHpscTVVR0wvNkZnTldMNFFI?=
 =?utf-8?B?MFIwY3J2aHA5TDhtZWhBREwwTWtMTjFCTGtTRUp1eHQ2V05qU1RTUjkrY3ZJ?=
 =?utf-8?B?aVdCN2hIemV1YnVqZy9FZ3hUR1RqMUc5WXl2bkFpTE15V3dGV01PQmFFV0lr?=
 =?utf-8?B?cEp5YXBNT09zYlJudnl1VUJNT1I1aVMvVWVoTXZ3ODlVVjZCRVpMK1ZGN2pF?=
 =?utf-8?B?aGRWYlovTEhKSUVwQWUrUmZxdjBKMXJGaENGeks1WC9EL05aNGFJUFRSbDl6?=
 =?utf-8?B?ZUpQR2huYmRjL1lxRVY2aVNHWTN3TFdKUDRpZFhwS2doMnJjSFppdmQ2SGhU?=
 =?utf-8?B?RGdNVnJyVGVTTmNoczU5bFBMbWZRZ08xMi9LMkx4NTFqNHFKczM0UVVxOC80?=
 =?utf-8?B?NCs2b093cGUyVkgyWVFDSXBxOTdmSGxqNUhhd0N0MVA1ZVVWVWNrYmttbDlS?=
 =?utf-8?B?VGh3WU5NZXF2cFo5Z1psWnc3VGN4cnIrMmt1TDFCeW11TFQ3QnBGSG1sWnUy?=
 =?utf-8?B?OUJwcUprMnJ4azdMdFB2S0FYWFdIeWJlRlpNeVUvNms3b0ZxZTBTeFAwcWZZ?=
 =?utf-8?B?M2s0YlplQ1ZEanVRb1RWYW9UOXkxYW1GS3IrVmo3eUJRcVRLalRJMk11ZTFW?=
 =?utf-8?B?UjA2Z1Z1b0FRT1hBSXVlWWE2UE1NelI2Ylh3ZlYzbTJ6b0RtUWR4amk0TlFx?=
 =?utf-8?B?ckc1eHJHeG1vajE3bE9RYzVoaU5VaG11S1RrYWJuL2xkYm5jT1RHNmpqNUZt?=
 =?utf-8?B?dUtGSUJWRFRQeE81TllKVWEvWE1UUG5KbDZXYzd1bi9HV3d4allzcEd6UU5j?=
 =?utf-8?Q?niBY7pD9ZHA8Fhv1KEl5XAI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2ED12ADEE676AA47ACBA1F86B28CFBAB@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bceca2-7d3a-4767-b53d-08dde0d1757e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 16:40:37.9981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uyQq+afb/8Fx+RmMbVGtSrKAvUZDhg2wGVe9lbX0lCE9w2UijjUpwFqlDUOI6oeycM+f3r3XXhbM8j6uXKEIkhDfeWHSBNiD0ubIW3dEnAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6130

SGkgRGFuaWVsLA0KDQpPbiBTYXQsIDIwMjUtMDgtMTYgYXQgMjA6NTMgKzAxMDAsIERhbmllbCBH
b2xsZSB3cm90ZToNCj4gRHluYW1pY2FsbHkgYWxsb2NhdGUgdmxhbnMgYXJyYXkgZGVwZW5kaW5n
IG9uIHRoZSBzd2l0Y2ggQVBJIHZlcnNpb24uDQo+IFZlcnNpb25zIGxlc3MgdGhhbiAyLjIgc3Vw
cG9ydCA2NCBWTEFOcywgdmVyc2lvbnMgMi4yIG9yIGxhdGVyIHN1cHBvcnQNCj4gNDA5NiBWTEFO
cy4NCg0KLi4uDQoNCj4gQEAgLTcyNSw5ICs3MzAsOSBAQCBzdGF0aWMgaW50IGdzd2lwX3ZsYW5f
YWN0aXZlX2NyZWF0ZShzdHJ1Y3QgZ3N3aXBfcHJpdiAqcHJpdiwNCj4gwqAJCXJldHVybiBlcnI7
DQo+IMKgCX0NCj4gwqANCj4gLQlwcml2LT52bGFuc1tpZHhdLmJyaWRnZSA9IGJyaWRnZTsNCj4g
LQlwcml2LT52bGFuc1tpZHhdLnZpZCA9IHZpZDsNCj4gLQlwcml2LT52bGFuc1tpZHhdLmZpZCA9
IGZpZDsNCj4gKwkoKnByaXYtPnZsYW5zKVtpZHhdLmJyaWRnZSA9IGJyaWRnZTsNCj4gKwkoKnBy
aXYtPnZsYW5zKVtpZHhdLnZpZCA9IHZpZDsNCj4gKwkoKnByaXYtPnZsYW5zKVtpZHhdLmZpZCA9
IGZpZDsNCg0KV291bGQgaXQgYmUgcG9zc2libGUgdG8gbGVhdmUgdGhpcyBjaHVuayB1bmNoYW5n
ZWQgKGFuZCBhbGwgYXJyYXkNCmRlcmVmZXJlbmNpbmcgaW4gdGhlIGRyaXZlciBhcyB3ZWxsKT8N
Cg0KDQo+IEBAIC0xOTQ4LDYgKzE5NTMsMjIgQEAgc3RhdGljIGludCBnc3dpcF92YWxpZGF0ZV9j
cHVfcG9ydChzdHJ1Y3QgZHNhX3N3aXRjaCAqZHMpDQo+IMKgCXJldHVybiAwOw0KPiDCoH0NCj4g
wqANCj4gK3N0YXRpYyBpbnQgZ3N3aXBfYWxsb2NhdGVfdmxhbnMoc3RydWN0IGdzd2lwX3ByaXYg
KnByaXYpDQo+ICt7DQo+ICsJaWYgKEdTV0lQX1ZFUlNJT05fR0UocHJpdiwgR1NXSVBfVkVSU0lP
Tl8yXzIpKQ0KPiArCQlwcml2LT5udW1fdmxhbnMgPSA0MDk2Ow0KPiArCWVsc2UNCj4gKwkJcHJp
di0+bnVtX3ZsYW5zID0gNjQ7DQo+ICsNCj4gKwlwcml2LT52bGFucyA9IGRldm1fa2NhbGxvYyhw
cml2LT5kZXYsIHByaXYtPm51bV92bGFucywNCj4gKwkJCQnCoMKgIHNpemVvZigoKnByaXYtPnZs
YW5zKVswXSksIEdGUF9LRVJORUwpOw0KDQptYXliZSBzaXplb2YoKnByaXYtPnZsYW5zKSBvciBz
aXplb2YocHJpdi0+dmxhbnNbMF0pPw0KDQo+IC0tLSBhL2RyaXZlcnMvbmV0L2RzYS9sYW50aXFf
Z3N3aXAuaA0KPiArKysgYi9kcml2ZXJzL25ldC9kc2EvbGFudGlxX2dzd2lwLmgNCj4gQEAgLTI2
OSw3ICsyNzAsOCBAQCBzdHJ1Y3QgZ3N3aXBfcHJpdiB7DQo+IMKgCXN0cnVjdCBkc2Ffc3dpdGNo
ICpkczsNCj4gwqAJc3RydWN0IGRldmljZSAqZGV2Ow0KPiDCoAlzdHJ1Y3QgcmVnbWFwICpyY3Vf
cmVnbWFwOw0KPiAtCXN0cnVjdCBnc3dpcF92bGFuIHZsYW5zWzY0XTsNCj4gKwlzdHJ1Y3QgZ3N3
aXBfdmxhbiAoKnZsYW5zKVtdOw0KDQouLi4gaWYgdGhpcyB3b3VsZCBiZSBqdXN0ICJzdHJ1Y3Qg
Z3N3aXBfdmxhbiAqdmxhbnM7Ij8NCg0KPiArCXVuc2lnbmVkIGludCBudW1fdmxhbnM7DQo+IMKg
CWludCBudW1fZ3BoeV9mdzsNCj4gwqAJc3RydWN0IGdzd2lwX2dwaHlfZncgKmdwaHlfZnc7DQo+
IMKgCXUzMiBwb3J0X3ZsYW5fZmlsdGVyOw0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2ll
bWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=

