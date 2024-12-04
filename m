Return-Path: <netdev+bounces-148889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9949E35A2
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B06E7B2DEB0
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B503192D6B;
	Wed,  4 Dec 2024 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="paHXjRto"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F76194089;
	Wed,  4 Dec 2024 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733300890; cv=fail; b=pqU9HiHEBWFujKEXVF6uNNeqn9m0c5fqaSbAyQUt1tku0qGJv65ocjt4Uu9vfdRRN4EQwIrlRZeJM/Ov4chbGn27an6XI8wqWCWa/Qav4uEnakFOND5P2dEpxoI9sOILcUdP4He2Z/ydt1eeupPAbgSMLmPnhm1dZJpm+3uvK9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733300890; c=relaxed/simple;
	bh=CVS+k8GSQCLgscjFM2lVBetYenxcZh39jdPDzy9a1wU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eI0m7l8lHjsupu4ZLr+GDlvosUBaTx9CYQ7sPbQBCmCkT+Jz7qXk9KBFIBehFXduy4aH3Jg4tpP3BLguNe8f7GmgtT/R1AlcfLdS+GAxCFq6Xc3ECvvXBuQnBQ741O7ygWYQCFKHCpIzbeEAr7knK371CfmyJn3eZtI/gR8GG2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=paHXjRto; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beBADDqrlz2lVoBZsBSZdo2p8h/6bpOfR5JzoNSlEcOL/AtVza2yJiaDn4Kkrc5ckoFH/QIvyv50n+EdanCLANsZ96L89l4IssmOzYgkQcFyBNVdCDZ4g9k+eEPV8grFHIM+pClw8MnCu3vjdACIBRIdXWW1AY9dR276yPcufhyc9XcHOGKOA/LQOyveVwsj+ni556HaIS2/tkia7VuJWR23+HEuM3t6rZMRRXBVQSqrzesgMvqaJVbDyWauE7GUAaSGmSrElR6HWI+m45Au+4vgMOmaj2R3DzQxTxCVWXFFltDrpqAeVYQH3qP2X3F3CpjzHM91Z2Ds0aSkVLrqzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVS+k8GSQCLgscjFM2lVBetYenxcZh39jdPDzy9a1wU=;
 b=Pl2loEWEXFSf5SgJ2yuw5JZ4LRXY/prx2wDW6E8po2BRP3xSkL5LfcB4zeP6FzfsCmEXxbER8J7/p+NgqHfVLDuHT8iQzgiKAm40C9qqJBEvRmU8TrrwtLpHR+du6Z1CzkWBsI658TYax7IczZu76I2aG+Dl9S3bLWo/cyReNQZpoUtwtU71wVeDdOgb38mNXfPrWa2ec+xYDe4yPSuBd3Es8h5RgrnzipRzKUFJoonxx2pw1HzMXvYQj6dmcVU58tXu1NDYGZpQ9cMsqNzSQx1q/T6Eqv6ndohJvKgzjQH+Bqn7n31zaPfK+LhHbSALJr1sXZ8e2p6jFd9R2s9OGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVS+k8GSQCLgscjFM2lVBetYenxcZh39jdPDzy9a1wU=;
 b=paHXjRtoIsjxZKO5DAJ30Bopjo2k0KsCKlB9quBxLVfxf7+4lt/WWHNZSAgZy8xC1colrTuwe+hGlWy/Hc1UZdBVzXND6RIYdghGfDUvbtaRiNIJNnpbu6KfHquqx3bNSLMqC0JTCGXb1KOxnYcJH+KA1M+y+CmeYpaeesB6UUH8ROQpZKOSoJgv6BpifBzqE0UebOauEu7IQhKeGhs1RyU4O7dSoqwNHrxd5+6pConGllPXAdQq/AeWY67wfP8dQIKoQ8qGw6DgLn2Ng4nhsClQF7U/tHsAqNmyzDTuZw0oMDxk4JbvGC5ZeBvqgXhY68vfyU/uDiocORQDaHmLhA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by IA0PR11MB7861.namprd11.prod.outlook.com (2603:10b6:208:3de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 08:28:04 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%3]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 08:28:04 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <kuba@kernel.org>
CC: <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<jacob.e.keller@intel.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>
Subject: Re: [PATCH net v2 2/2] net: ethernet: oa_tc6: fix tx skb race
 condition between reference pointers
Thread-Topic: [PATCH net v2 2/2] net: ethernet: oa_tc6: fix tx skb race
 condition between reference pointers
Thread-Index:
 AQHbPMhxyo9k5olCKE6AJRp1Vi8GwrLJZfuAgAGUbYCAABbkgIABJgCAgAYmCICAAxhLgIAAXbAA
Date: Wed, 4 Dec 2024 08:28:04 +0000
Message-ID: <0a1b25c9-70bd-4dd3-9505-0e5c8cbd9b0b@microchip.com>
References: <20241122102135.428272-1-parthiban.veerasooran@microchip.com>
 <20241122102135.428272-3-parthiban.veerasooran@microchip.com>
 <1d7f6fbc-bc3c-4a21-b55e-80fcd575e618@redhat.com>
 <8f06872b-1c6f-47fb-a82f-7d66a6b1c49b@microchip.com>
 <7f5fd10d-aaf9-4259-9505-3fbabc3ba102@redhat.com>
 <b3e23d57-3b3b-474c-ae45-cbbf4eaaef3a@microchip.com>
 <ba984578-318c-4bf3-8ffb-875ab851ee0e@microchip.com>
 <20241203185245.7b1fb10b@kernel.org>
In-Reply-To: <20241203185245.7b1fb10b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|IA0PR11MB7861:EE_
x-ms-office365-filtering-correlation-id: 516e5005-3cf3-4143-7d18-08dd143d92fa
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b29PTmRxejE5L00vTXVBc012Sm5SQS96eVVSU29KM3BLMTBFWmx0azM5LzM1?=
 =?utf-8?B?RGVmNS83MGFKRldtMEJ1MTlJdG5tVWRsWEJZdDZ6Zm1wZG5SQ3Nic0VNenpq?=
 =?utf-8?B?S2NsbHo5bGxhdEhub1V5TldzOVR1N1ZnVVFuUFlsTGxZQ1ROcTVtWUxiQjFV?=
 =?utf-8?B?bWdnQUZpZS9YZmVuVWFaSllyUjlwTXROZ25FdkowWU5PTWV3RndlQnlPcFo2?=
 =?utf-8?B?dUgvb3ZSajk5S1FITWtjUW5rc2hhSWE2OWdsQ2JkZUlHYnAyWEVySHlxakUr?=
 =?utf-8?B?V01xYkZoYW9vbXlhd2QyaTZyY2ZOeHVIbWF4UE1ZcDBqMDBGMy9hNGNRaTJJ?=
 =?utf-8?B?UjNTelU0Um9aT1pJQUJHYk8rUVJCRW1PY0lyUEFMUGkyc1crT251TE1TbEh3?=
 =?utf-8?B?UzdqTU1PaGt2TGxoY2h2a0krS3dzV0N0NGZQQTVxVTluUVRlM2xSRXJacEtF?=
 =?utf-8?B?OGl0UllGL0haUTN3Y01IU3g0Y1JRQlFTd2FqM1RHNXJBTnZGYVFBK2VTYjgz?=
 =?utf-8?B?Yi8wSkVCV2pNNGlhVkw5Q0pMMzMzemJ4VTMrWnZ3NlZpWlRCdUZLY2FzMFFZ?=
 =?utf-8?B?SVNMMUsrY0hOcmFyRW43RU5hVEZZRlhwSE1mRnMzZFh2ZFBQZUVvVnpPdmwy?=
 =?utf-8?B?eEJYUW1VSVczR1lqdUhQZmRxbkhucDRpUUx0M0RRa0QwSVJwRFpmc2J4U2k0?=
 =?utf-8?B?Sys3Z1dQYnNqajEraHAwSDJoWUN4NndiNEZUYVYvRS9zSU54c0NKNWtsQUM3?=
 =?utf-8?B?bDVDVVJJaEZjT0xSU2owdGt3WmsrUzRYUThTdGNmQmJUbnNsNjgzV2VMemY5?=
 =?utf-8?B?Nkt4c0dLTE5OdDNnVGNCOEdOTVdoNEliMWNuSGNMRlFXVFhvZzlPajdOUW1q?=
 =?utf-8?B?aHZmaC94b0E5ZnF0UmQ0TlhRclpEbGszS2hpRlg2c2FuKzViaFlScC9YNnZq?=
 =?utf-8?B?RytRazRYNGVUNEdDQml3OHN3V1FhWmFqMmJZY29QYjVFQWhiYUxsWmpqRGtq?=
 =?utf-8?B?bWF4UllDM0NWdnRPNHZvUmFvUldmTnJ0TSt4K0Rna1l4QnYySjhqT0xQdEE5?=
 =?utf-8?B?TU4raVY4dmszd3FHZUZnZFk3WHJQVTVKdWRzOVhRa2EwNkRFWEhGSVlKeFFQ?=
 =?utf-8?B?Q1RPSXBLbE8yV2RwNXdWRHRxd2k1ZitHRUUxbnVHaGJubnBXSHd6Z3h5dEt3?=
 =?utf-8?B?WXNkd2MvZGM2c01HNS8vTmk2Tlg5UEtEOUZhcGNsSDhJeldCZldETW91ZjlW?=
 =?utf-8?B?NkdaMFd4NGZzZGZocTBWc05qUmNWZDlxMkRXV292SFU3ZVR2dXozdWNJRG82?=
 =?utf-8?B?K1lOanlwQ1lBeXM0VWlUZ2o0UURkeVpLL0ZVYTl1Z3hNRU9QWmxoa0dlUHly?=
 =?utf-8?B?eWhCUGpENTJvSk9tdS9HdkNvME5lU0Rnc2wzRXl5YlQ0U3FFNnk3WklGSG01?=
 =?utf-8?B?UGxkUUtwM3g4QjJxdmMxRkIrVHQ5RE52aFBRUFI0N0JscTArSG9ITmhzSS95?=
 =?utf-8?B?cEpDS2ZDdDNrd1BaYzh0NVhKVFdFcmZxMFdCTGx2WkZWd1h3THEzNTBWUEtU?=
 =?utf-8?B?enZISGZ2Nkd5M25odk5RR1Z5eUEvMTEyVFZMMndqcXRMUE9idTcwUTNOL1Rm?=
 =?utf-8?B?WlZnQmV1U0RQdVc0Vmw0NnoxUU5rOEw1L01NYzFZeHZkTnJPV2xDREpqUHhs?=
 =?utf-8?B?c0RobU15SklRUW5wbTB4dUJ6UzFVUUU3Znlyc1V4dm1GRDl0YzVkMkZIKzBr?=
 =?utf-8?B?bFpTdmMrYzlaeThmOVQyZ1pWY28rZDFScUJtU3dwbEdtR1ZNb0l1QU9rKysz?=
 =?utf-8?B?NmxaQU96eUpoazV5WlNPZ0xDV3BNQzZKRUVJMERqM2p3Nzh2NzdoWkl3REhJ?=
 =?utf-8?B?NUFrTDFicmorclRBTnhCTGhoQ1kxQUJtRVBsR29meWFIVnc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VjBjWnRMMDFWcVV2ekZxaS9DdHR6Zll2WUE1ZDdWTFZOb01vWnZ2NTJkN3JZ?=
 =?utf-8?B?cnpsZC9KRThKK1VRMXlpei9rU1d4R1c3V2s1YSsxd1Z6czQyVFd5dFZRV0g5?=
 =?utf-8?B?SDFXQTBrelUwQTgzbkRBZ1hHYk41UEY2RWVRT21nb1g4RHpqZmpmWURzbnJ0?=
 =?utf-8?B?TjlnOFhmMVVCcjFkUTRIZ1IwdE9CeG9EWEtuZXBXOG1aVnA0K2cwL3AxSFc1?=
 =?utf-8?B?UmlqeGtvbjkzTFM3U2MrQVR6YnZReEFTaTljR09Zbnp0TjkyQUhPV1JBdmh5?=
 =?utf-8?B?M2UrczM1eTRoMmsxZVZyUmFmWjd1WXBNdVIrcXRicVhDNXk1eE9zLzh0bytJ?=
 =?utf-8?B?TGc2U1g1c0ZPV2NEVjJWcDRZNDdvRGJKSFVFTFhkWlB0UG10Mk1MK3RHUS9a?=
 =?utf-8?B?d0JVNWZRRG4yTWQ5bTh5MWUvazNsMlBXUnYwei9oaU9PWWJWUCtyQXRFK3BH?=
 =?utf-8?B?OXQreVJJL1RhY1htWENMUkc1aUpjc2tuYlViMFZHcVlNSlB6b25MNEJlQTEr?=
 =?utf-8?B?bXgvQUxMMVdzb04veTZnZ3hGd1NpdWxsb25ZY2dkdjlCSnlUVzdrcDhIV2wx?=
 =?utf-8?B?SmJoc2RGMFYwYXZtVXlWb29lS1NZaU1wRzlRdkF2WDcvb3ErZXgyUGtEZGMz?=
 =?utf-8?B?NENxcFVwc00vRitSbjlmU2pXRlltVy8yRUljWUxQR002QnQ3OGErNzQzWFdr?=
 =?utf-8?B?ZzJDWW9VUzd2THoxVFNyeVZaTW10eDlWYU9TR1RYMTRQSW12NDVmVFN1RWRH?=
 =?utf-8?B?T2pYN3grTHVaZzN1aUk0Sng2YWVXL1o2VThnSTduOE91MXltTzBaTUpiU2hN?=
 =?utf-8?B?c3V6YmlJZWNkMGhHNUFsNkJoYzc5T1lWT0IxejQ1RDNLY2VYUzVDTm1hWWor?=
 =?utf-8?B?U0ZNRnNhWWR4TEdMUjJpK25CeW1SVG9qTlVDczJNT3NCZm50NWdheTh4ZDNP?=
 =?utf-8?B?ck9VSmpzU2wzQXdzOTNXeERvY1ZqeVBNVENVSHpraGM2NXF5UUtCb2RnWXBl?=
 =?utf-8?B?amkxMEVxOUpYK3ZIVkg3TmVRZ1k1TmJDU3FOSFU2S0FRenZDU3puSXhIbita?=
 =?utf-8?B?enExb2daKzFPQ05zNVJ3dDd1elVLUHV0cDVyQzI1MUNqN05uckQyS1kxaWty?=
 =?utf-8?B?TERDTmo3cFE4eHI1b1FzK1hNZE9lRUNiaGJyMnM1b0JtL2oyZnc2V0JuYXp4?=
 =?utf-8?B?UVprTlQwZ21NZUpYQklHS0c5bDU4c3BuR1Rzb0RtRjY0d0I4bEhqaVNaWTZP?=
 =?utf-8?B?M0VxeGJZWVhaY1FNaE90bVhITEFFeE8vRWNTMENRS2pjWExZRVM0SSsrek9I?=
 =?utf-8?B?SzkvS08ydnZ3MXVucUNtV1YrQnpQdi9WbENuZHlPUWdjMVV1K1NUUTdUMGU3?=
 =?utf-8?B?eTJxTytTb0VsNHk3VnpwczVUcWF6ejNmYUxCMUlTYkVTVHJvMHdtV2hHMTR0?=
 =?utf-8?B?T0toeGlFOGsvYUhVcHJYWXR5TXJzNDhLSDVWbExaaDhzcjRob2Z0b3VOODlv?=
 =?utf-8?B?T2g5cGdlell1MkQxWjNDeXBVVWxVWGZJK0RmbjA1ZmI0SGQxeTcyWDJKS015?=
 =?utf-8?B?cVBHMmVWK1RiM3dEU1Q5cVhkTmxzWWRwUFNLaC9RYllwc1BOOVhKdEpyMGFx?=
 =?utf-8?B?ckxLRFV5Y3RwVVVEbHc1YjlMU1VySXZPaHdRRUVJOTBWZU1ESkl1TVdhRHJ3?=
 =?utf-8?B?Rnptd1dWL0FabUNEOXhScmZTWFJRWG1VRHpITzVOSVduK3V6dXNtTUIrUU5t?=
 =?utf-8?B?RkFydVQ1OW14c0F0Y0MyQUhmQkQ3dmRRR1hmcHEwem00cmFGcUtpVWI2SGtC?=
 =?utf-8?B?eE1yUGFxZklxTXlzOVh0M3IyTGpmaDZzN3lHNFJzQTJLQ3dLU0lyWlFSNTJ2?=
 =?utf-8?B?UFllRW9yV0ZSSG1GUWZLSjB6K2dTK1VpWnJXTko1UEYzN3AwYmo1WVBjR3Vs?=
 =?utf-8?B?MXhmRVpsdlpIL3hjeS84eUUzTkpWbHVLNmlxenpvVU5HenBENmNTNy9mdWND?=
 =?utf-8?B?aDh6bHJNVUoxRVNVc0dYeTR4NGhodC9iTkhOay9kR3pMSmZVM3BjVm1oUFJN?=
 =?utf-8?B?ekVma1VlWDZ4Vnhialg2Q092cFBnUHh0WHlGWlh3TmlncG0xLy9jUnhYWjNY?=
 =?utf-8?B?NEJxd3ZzZkZNNmQ4Ym5ZS2NFdllxQ0h0SDlObVpERVNxc2Y0ZVNMMEFqNzZi?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A0DE2B51200F64A953FBAD9C6D5B89F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516e5005-3cf3-4143-7d18-08dd143d92fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 08:28:04.7578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9e6XxHfhGVXfgmMsd3gDrcVM628E1awlC0fBG/pqglMPHz4SN9F/vcSWdhzuENlfKgJZuHOKANPsAzMMC37M7+lPt4Z4xByfNSBN5I+PGIWmXn6EiDmT5Rf/kq6kFAIY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7861

SGkgSmFrdWIsDQoNCk9uIDA0LzEyLzI0IDg6MjIgYW0sIEpha3ViIEtpY2luc2tpIHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIE1vbiwgMiBEZWMg
MjAyNCAwMzozNzowMSArMDAwMCBQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlwLmNvbQ0K
PiB3cm90ZToNCj4+IERvZXMgdGhlIGJlbG93IHJlcGx5IGNsYXJpZmllcyB5b3VyIHF1ZXN0aW9u
IGFuZCBzaGFsbCBJIHByb2NlZWQgdG8NCj4+IHByZXBhcmUgdGhlIG5leHQgdmVyc2lvbj8gT1Ig
c3RpbGwgZG8geW91IGhhdmUgYW55IGNvbW1lbnRzIG9uIHRoYXQ/DQo+IA0KPiBJbiBjYXNlIHlv
dSdyZSBzdGlsbCB3YWl0aW5nIGZvciBhIHJlc3BvbnNlIC0geWVzLCBwbGVhc2UgcHJvY2VlZCB3
aXRoDQo+IHYyLCBhZGQgdGhlIGRpYWdyYW0gcmVxdWVzdGVkIGJ5IFBhb2xvIHRvIHRoZSBjb21t
aXQgbWVzc2FnZS4uIGFuZCB3ZQ0KPiB3aWxsIHNlZSBpZiB0aGVyZSBhcmUgbW9yZSBxdWVzdGlv
bnMgdGhlbiA6KQ0KU3VyZSB3aWxsIGRvIHRoZW4uIFRoYW5rcyBmb3IgdGhlIGluZm8uDQoNCkJl
c3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQoNCg==

