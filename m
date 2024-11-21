Return-Path: <netdev+bounces-146575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0137A9D46FE
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 05:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B74BA2831B5
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 04:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E840313BACC;
	Thu, 21 Nov 2024 04:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WlkSBOZi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCCE849C;
	Thu, 21 Nov 2024 04:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732164891; cv=fail; b=nGDCAmCb29KKQc6+jcpF68IPvgqh1Kw2KlbH+QFGkN3t8fiQ7lG1OEju0c2zyW6Ogg/v8Qdf21Zzw7rnQtk2zxZUPaZu1GhtDtpCwgYMVbwTy8x44lBmvXNMtKF617RjWRQQL6rsZsa/j65wWad3v4S8jsS/ywxmeiwpTbEk/DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732164891; c=relaxed/simple;
	bh=TTTb2jGkplIzORojR6UQjnqP9ukXJOA7iAfsnjdkkRQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y6sSxUAiZGgB5ROdS9p38fdMjGHW0ydpYcaBtsmB77SiUsLXof1NwzNs1tOWSGAnhbkMSaZBhLg/wdcRRwM5ehqvCmHSySrYHBWb+YLlomcL+OkUBLuO7/Pgi1CmHNFOsr1Rnc0XTPHrP8SnTrFd7KkuQbSkDVpNXScbU+xvLQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WlkSBOZi; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyF9wBcj2QlNq9jtfh236CJC8gW6rSG7nsJJpfdRMzG5vHYoYibWoUoVZqWFym03Go1aAmKetC+b7erSEZPffSHTHB/B9hzTtbGtfN2eok0/qkk31rU7Do0CcfMVvwe9lQk5M5sL53mXbP067Mc+HCK2t0rW8o6bQ7DNiQ+aSjqZZ603Wlu6zxWJ+oe4nb+zUZR/IOfddQyV/MA2M/ibVOF4TOXkWGEAwaM6EIxpT3eEE9Xr9GGJSA+SHMAdo6v5tbn0lGCgp/dfJYmEhfCnJBkLUHuuvEJ3wTlsfCcJqjqtpHFKqT18KroDgoesjGVvows03NlvQfeZE+r+fujnRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTTb2jGkplIzORojR6UQjnqP9ukXJOA7iAfsnjdkkRQ=;
 b=gXd1ZEous9x18hG4FhGtKtCdsRtFDM0wt5hMRzEx4haREpGBfNaKjXeAANjOiZBuMkmpLEs1uZ4RAihUcwJ9hYtzvqq9iDYDxXI76UcXP2WkU1y/HDkqe+AVIMgQdeM6kIjuFfc+rDWZOk5G/EFUaNRrPZoEPOP4B26AW7i6iJETZpc2I6usmmTYM/KUL2lAkEZJZEhyga7e85UE/ppp7/asyPMoSMLyLMCfw3gw0cGIG1rERzm0/TAKXLpoFwYGCKqAwOtjszPcJPhd/TGDlLLACtgIwQZTJ8yC27x7yknz6JLRMAt1sR+0MXSkNgZpZ0t2KZdThk//zbH+FffJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTTb2jGkplIzORojR6UQjnqP9ukXJOA7iAfsnjdkkRQ=;
 b=WlkSBOZiG9BRVtgPHGu1431O22n+2m6n7TWuu6fkgSusXZ6Ouzlx97mu0oO8MLgPW4sfEZD+oU1IGR5F47MaVzbkRVvSytQNzR13A5stWRK9SfKumOjRMfJ8ep5gW9JDK8Xtle9XZKdiMbunmc/3uLnNOKrAU1LW7IkFqBfY5w5aqYU+NhWj7tT30rmcDmghepq73yOfVK4l9/vKDdSXRMEdeVN6LaynCaYes92EQkCJd+LhUrDvXN0DIk9iEJL50oq+XwMxx9XeiQ7OqF8CHMmPDeDZqi5o4SplszcAMKSD78H5VbvBX5kVX8VUNkMmwp5yPlz3+KEDxMTVx9vXFA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SA0PR11MB4639.namprd11.prod.outlook.com (2603:10b6:806:70::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Thu, 21 Nov
 2024 04:54:46 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%3]) with mapi id 15.20.8158.019; Thu, 21 Nov 2024
 04:54:46 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <jacob.e.keller@intel.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>,
	<Parthiban.Veerasooran@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net 2/2] net: ethernet: oa_tc6: fix tx skb race condition
 between reference pointers
Thread-Topic: [PATCH net 2/2] net: ethernet: oa_tc6: fix tx skb race condition
 between reference pointers
Thread-Index: AQHbO1OA/l43s9v8V0C+tdSqrrqEy7LAljMAgACWHYA=
Date: Thu, 21 Nov 2024 04:54:46 +0000
Message-ID: <2a812a1b-97d9-4661-bbe7-ac2c53256f0c@microchip.com>
References: <20241120135142.586845-1-parthiban.veerasooran@microchip.com>
 <20241120135142.586845-3-parthiban.veerasooran@microchip.com>
 <c8498820-e794-49a2-9724-f4d2e1ca8082@intel.com>
In-Reply-To: <c8498820-e794-49a2-9724-f4d2e1ca8082@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SA0PR11MB4639:EE_
x-ms-office365-filtering-correlation-id: 9acec446-3dae-4fbd-603e-08dd09e89ef7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RlhRNjkzSjJLRUdzQWoxOWQ3NkJNYkVyanVSNC96U0VkSDB0ZWlWaTZWQjBG?=
 =?utf-8?B?cnpNYVV1TjdqcTRDc0ZqVXlSVktLZ0RqMW1XT3U5ZU1uSEh6eFJLbnZESkdF?=
 =?utf-8?B?UTBoTHRUQ0hMNFd4UWgzcGkwelBIdHY2TVFteHRLT0VRR3VUQ1owMlphNE4z?=
 =?utf-8?B?VDk3Y1M5c0RrdUhaa0pxSHpZbzhncUdkTlQrcVRvOGd4dUhnZDBJTVg3NitY?=
 =?utf-8?B?RkJRVkU2cHhYRktiMVNuQWFFVVFEd1c2bkk5YkhMUUhaVmcvUVR0TnE3Uzlk?=
 =?utf-8?B?VXFMbVB0S1N3d0Ztc3hMSS9CeXh4Uk5DVkhVTitYaDZ1Q0QwVjduWDJlSGNn?=
 =?utf-8?B?aHhqRzJybU40RERraHdFRzFRUndRa2hwUTNzSm12VHk0VW0waXNya1lvRlcz?=
 =?utf-8?B?VnkxSEhhQjRaOW1uSWlNQ1ZpNVJUSWM5ZW5Dcmp3dkZPZjR4SktmclJ0OThF?=
 =?utf-8?B?QmhoNHVjTWlxd1lHeDBnUWFkQk5Tc09kekEzUW5QSWlaNHZSaEFkbThDWWU1?=
 =?utf-8?B?RURPSjBXdGI1NllGMHdDTTloWVlhZHVDOStzdlpKY0FQQ3g3YjRUWDBEeXF0?=
 =?utf-8?B?Z25DSW9DVXFIMXFTbkEwQW02L0Q3dGFycTd4REQwbkp5MmZzRmZMTE8rRUhx?=
 =?utf-8?B?ZFNLQTBXZWRSTm9ubXMrOFN4SFFpYUw5S1poenhNT2hsaXJMYmY5S0xqRlJJ?=
 =?utf-8?B?T1RkMmxWRCthUTBiZThnMG1EclEwZ0plZFhMVjE5b3FNa2xKS3JqTkFoZXdX?=
 =?utf-8?B?d2dYWDc3MklQSWFEZ1NvRHZtWUg0b1hOMWFkcE5pbGtxM3RsZXdVUTAxYStH?=
 =?utf-8?B?ZHVzTW5IZElDLzFxa3drTU5mZjc2QnVFbGxvTnBvOGFJZHFsZURmUnJHMFhH?=
 =?utf-8?B?b3QrMC80QjJzczJkdXp4MjdCZllUeUZ3cmdJNzZTWjUwOEJNWDdUNVAzTG0y?=
 =?utf-8?B?dXhwRHJPWmluSlhQVURFVnozdFdCYjRaZkIyQUtENGRuVFp3QXNJWjJlSnZt?=
 =?utf-8?B?eXJDb0F5bUpQeXlFS0RYaVZKSUFmbmNTS1BnMDFHTlB2YlF4WEI1ajd2T0Zx?=
 =?utf-8?B?ZVFKS3pON1F1VTB1OWk1dWlyYyszVm9qMHRHSWo5U0M3TmZsbjB5dEU3ZTBj?=
 =?utf-8?B?T0NJTnpWcWdBUmM2WkJ4K3k1cTNOdzVxMWlDRDlEb0g2R3lnazdZellJcnhj?=
 =?utf-8?B?RW5HZjdtZW1WVjJobVpjSU5qY280WHdRRmRYaUxXUkM0VlBDMlBZMERxaElP?=
 =?utf-8?B?a0hkY2I5ZFBSczBIR0tER2M3VHdKd1c2dUlFRVB0Y2Mza0tLT0U1bnd5TUxN?=
 =?utf-8?B?SHpLdTNEKzFJeEVjSzgvQUY5RnB1dTFWYkhFZmE4eDdqdGgwQklMdjFwb2NI?=
 =?utf-8?B?UTFVa3VsTnZQNXlGODFKUEJ0Vmx3K2dtUytLZ0U2WnJsR0xqMmZEWWQwdURR?=
 =?utf-8?B?K1NHckJaQWRKSG9lM3VzMEVlWlZSbXNLSHl5L09Ic3B6RUxBTk00TjFXdGFx?=
 =?utf-8?B?ei9NMUJ0MEJmcGhaVXAycGhWV0ZTR0NIVHB6SXdlYmpZcDBReFlmMGZTTy83?=
 =?utf-8?B?ODBEZ0QzWWJqNUQ0WVdScDlocmlsOEdhMWptRXBqNmZGMUpCZk54M0RCZW9i?=
 =?utf-8?B?aEtjQi81N2xvcmJvS1F5QnRieTFXakpXNGRITWVYRkJVbHZCMXRmRXpFZmJH?=
 =?utf-8?B?S0xnbVlyUGJ1M0w2UXVIcEZlT01zZ0JUZ2xpMzFQOHBIMEVOWnVyMzVpQTVM?=
 =?utf-8?B?ZWtkc05sV0UvM1pKempkTDRTVEp4YThJdStOTjRXQldxODVmdkVxQTd6RXRE?=
 =?utf-8?Q?vsrDb6a/OEfQKFLxtICIIc98zPQg86igV8MQ8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aTVRNkhFcVJkV1hFaTc5dXJzOCttOE5DVTlBQlRteldXMGxQSGFqeThLMmFD?=
 =?utf-8?B?b3d3eEx2YzVIN3U4a0wrU0laTmdwMm9wMWRhaEtaNlIva1ZBNitycE9TdG5u?=
 =?utf-8?B?SnJGY0YxV3hnS1A5YjRKaXJucXg0Y1ExbDlIR1JEYUhsUG5TSVhCUUVZc0E4?=
 =?utf-8?B?aVQ0Tm45QTNyWEZKRXRrUjVKZVA0Q2toVG5kQ3c5SzhTODNqSzlUeTB3Vlhx?=
 =?utf-8?B?aFpCZmJZbXZPd3JIdXoyd3ZiMlErZVRVY2FpRUdjbTdEc2lDaEZlNjEveTFy?=
 =?utf-8?B?Zmk4YXY4UzVGaytuTTVDNVd0T0VlbXYyOCtZVmwzYmFVOTJVV2lzanZ3bmRH?=
 =?utf-8?B?U2dTQXJueTh0SVNNZUZqRGoxTE45K01yendnS0prVUlhWmRTTlpZZ0FzbXZY?=
 =?utf-8?B?N05zWkdCR20wN2xLNVZ5TG9Mem9CWXhvY0t5aG5HUEVvQVJZOFk4am1lQzh0?=
 =?utf-8?B?dndKS05OWjd4M3dsT1dSUkpvbHVXbzhPOUU3QkpBeHRBQnRGVW9wemFqMngx?=
 =?utf-8?B?M2xJMWkzdFNzeTE5WHBTRDRHSk1WV2ZCNmlvZUcwVHN5ZlQ0TVJEQkZCT0ZX?=
 =?utf-8?B?OFpSNVpNZmNjQ1hDTkFIWDJ1bHpjQTFWUDVpQTdjTzB3QWxEYTNkV0k3Q3l6?=
 =?utf-8?B?RjdGdlNxeEhhWlAzQ0Vmb2Nlck9ZTnJOS0JJQThlVEZlMktXUjEvbldvRkN1?=
 =?utf-8?B?VS84WWVsUUxZdWMrYW9rVTZMS2tuQit4SVo1UnhaSWdhenBnNWM1TXM3S2ZN?=
 =?utf-8?B?UWszcGxoSE04ZWI5alhLODJLV3FNekswd252aDNBdjgwU3Y1R0tvSzY2UllO?=
 =?utf-8?B?Wmg3aUxLL0NReS9zdFUzcUhLZ3pFS1BuU1hLWE5penVaYk1ZMEdLSE1IRnNa?=
 =?utf-8?B?cEU4NlUrbzFGK2JVWjYwWUxza0dQRmg5MFMxR0ovVmZ1MjJ5SXdEbHhMUFE2?=
 =?utf-8?B?ZlFnVzFsTGFPblZRYWRrbjFITHlhVHg3S0RTcy9kbWxRRDV0MWNsdFl3Z2lO?=
 =?utf-8?B?TEJjeCt6L09CT0lGUVVtbFBCT05WQ2ErblNBYVg4VE5PeENGZEJTZU51cVhG?=
 =?utf-8?B?ZTlTTzBBSGtzakpWY1IrMCtrVGUwMlNXOCtGREJWR0RLNzdpUFZ3SmZvaGxI?=
 =?utf-8?B?WkxWMlBkTWdWbEtGZnhaTnFDTWpFWHNYdU8wamNuOTFlYWYrSy9ISU1HMk9r?=
 =?utf-8?B?dVl6UkNJenpFbEJBNVFvWlVmYzY4STlBdWJmRUp5ZkFuQkF3QkhVc0VJNlRQ?=
 =?utf-8?B?S0xMdXNIY0prbThLWUcvQ045Qnl2eENJQmRBc2lJRVZENCtoUlV4SVNyelBU?=
 =?utf-8?B?S1dPQnJ0M0o0b2s5VFB0NVJ4bVNTOTIxNytqWkJGZTVBc1JPczZSeFhZaVEr?=
 =?utf-8?B?Z2N0NElOTkNQR0Q1dlNVdXRBVTk5T2daSzJkMjgzWGwzdlEwWXRFd1dEOHMv?=
 =?utf-8?B?cEhyMXp6c2xDdCtNRU91UmtpRWIwcmN0WlpWSWNDazN1WEV4ZTBxcTdUVzhZ?=
 =?utf-8?B?Z3ZkMkxweGpoN3BXWDMrN0YrbVF1cjRpMExOLzJraGQwOGFIUW5XalRseXNB?=
 =?utf-8?B?dWFQNm5NY1AyUVYzd3hHU2VpcjhtUHpMSmhseEtNa0swSVBIcDVZWG1GOFV4?=
 =?utf-8?B?NFFmS1dQdERMY1BUOFVka1hWUHBESnNzbDBCQlV5R0UyT2dXTXBhdHIxajVy?=
 =?utf-8?B?dHU5RFdLeHl5RTA3V2xORlhBcHcvMVN2NG1odTVhUy9qYnJOZ2tIYll4Q1Zr?=
 =?utf-8?B?UTl4TXBoMXczNlFKcW9TTlRuT2o0cmNGTWlUb2YwYng5MzJ3TEVhNytJUVNy?=
 =?utf-8?B?VXJ0VFJjV1dPTHdiSSszb1JXNGZUNzA5SzgwRFdRdGtsZVNzUzlORkhkWlph?=
 =?utf-8?B?VW5VRzlveXFhcGFtbWRoM0Z6dGRVUnRGb1N1clJyWTRuZC9sWmpBeUppSG5C?=
 =?utf-8?B?cjFaN3dKdlZ2MnkrUW1pN3FRaEN1WnRMVVRyVFdnVjhDcG4rZVJtTWcwak5m?=
 =?utf-8?B?cTNBazA3RVpRclI4R1Z3cGdSUzV1UUtFaE1QZ2lNS3VwYnRZOWtFbnBUczBD?=
 =?utf-8?B?dk5obXY4UjZhYncrNmplZDdpWVBWYjlKcUZPY01GSUNMQlNkelV6czZOZTVS?=
 =?utf-8?B?cHBVek42dTFUVTJjR2xjZVZabGN6TkJCZmsyOTFSckF4UDJIQ2lxNDRHcnd1?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D10B3F80DA0B264F80633A515936A664@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acec446-3dae-4fbd-603e-08dd09e89ef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 04:54:46.0128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s8ffc2yTjQDWHGqMEeKvGpGWy7JISsDOroFCJ4xK+95UXZIKN09BaIqSW3xh3or9ArDeqk0CfGTB2vD/0EZfVOfNWdHspx5XeXh8B+3BqGxgk82VHgleY8e7ozdoS+L8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4639

SGkgSmFjb2IgS2VsbGVyLA0KDQpPbiAyMS8xMS8yNCAxOjI3IGFtLCBKYWNvYiBLZWxsZXIgd3Jv
dGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMTEvMjAv
MjAyNCA1OjUxIEFNLCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+PiBUaGVyZSBhcmUg
dHdvIHNrYiBwb2ludGVycyB0byBtYW5hZ2UgdHggc2tiJ3MgZW5xdWV1ZWQgZnJvbSBuL3cgc3Rh
Y2suDQo+PiB3YWl0aW5nX3R4X3NrYiBwb2ludGVyIHBvaW50cyB0byB0aGUgdHggc2tiIHdoaWNo
IG5lZWRzIHRvIGJlIHByb2Nlc3NlZA0KPj4gYW5kIG9uZ29pbmdfdHhfc2tiIHBvaW50ZXIgcG9p
bnRzIHRvIHRoZSB0eCBza2Igd2hpY2ggaXMgYmVpbmcgcHJvY2Vzc2VkLg0KPj4NCj4+IFNQSSB0
aHJlYWQgcHJlcGFyZXMgdGhlIHR4IGRhdGEgY2h1bmtzIGZyb20gdGhlIHR4IHNrYiBwb2ludGVk
IGJ5IHRoZQ0KPj4gb25nb2luZ190eF9za2IgcG9pbnRlci4gV2hlbiB0aGUgdHggc2tiIHBvaW50
ZWQgYnkgdGhlIG9uZ29pbmdfdHhfc2tiIGlzDQo+PiBwcm9jZXNzZWQsIHRoZSB0eCBza2IgcG9p
bnRlZCBieSB0aGUgd2FpdGluZ190eF9za2IgaXMgYXNzaWduZWQgdG8NCj4+IG9uZ29pbmdfdHhf
c2tiIGFuZCB0aGUgd2FpdGluZ190eF9za2IgcG9pbnRlciBpcyBhc3NpZ25lZCB3aXRoIE5VTEwu
DQo+PiBXaGVuZXZlciB0aGVyZSBpcyBhIG5ldyB0eCBza2IgZnJvbSBuL3cgc3RhY2ssIGl0IHdp
bGwgYmUgYXNzaWduZWQgdG8NCj4+IHdhaXRpbmdfdHhfc2tiIHBvaW50ZXIgaWYgaXQgaXMgTlVM
TC4gRW5xdWV1aW5nIGFuZCBwcm9jZXNzaW5nIG9mIGEgdHggc2tiDQo+PiBoYW5kbGVkIGluIHR3
byBkaWZmZXJlbnQgdGhyZWFkcy4NCj4+DQo+PiBDb25zaWRlciBhIHNjZW5hcmlvIHdoZXJlIHRo
ZSBTUEkgdGhyZWFkIHByb2Nlc3NlZCBhbiBvbmdvaW5nX3R4X3NrYiBhbmQNCj4+IGl0IGFzc2ln
bnMgbmV4dCB0eCBza2IgZnJvbSB3YWl0aW5nX3R4X3NrYiBwb2ludGVyIHRvIG9uZ29pbmdfdHhf
c2tiDQo+PiBwb2ludGVyIHdpdGhvdXQgZG9pbmcgYW55IE5VTEwgY2hlY2suIEF0IHRoaXMgdGlt
ZSwgaWYgdGhlIHdhaXRpbmdfdHhfc2tiDQo+PiBwb2ludGVyIGlzIE5VTEwgdGhlbiBvbmdvaW5n
X3R4X3NrYiBwb2ludGVyIGlzIGFsc28gYXNzaWduZWQgd2l0aCBOVUxMLg0KPj4gQWZ0ZXIgdGhh
dCwgaWYgYSBuZXcgdHggc2tiIGlzIGFzc2lnbmVkIHRvIHdhaXRpbmdfdHhfc2tiIHBvaW50ZXIg
YnkgdGhlDQo+PiBuL3cgc3RhY2sgYW5kIHRoZXJlIGlzIGEgY2hhbmNlIHRvIG92ZXJ3cml0ZSB0
aGUgdHggc2tiIHBvaW50ZXIgd2l0aCBOVUxMDQo+PiBpbiB0aGUgU1BJIHRocmVhZC4gRmluYWxs
eSBvbmUgb2YgdGhlIHR4IHNrYiB3aWxsIGJlIGxlZnQgYXMgdW5oYW5kbGVkLA0KPj4gcmVzdWx0
aW5nIHBhY2tldCBtaXNzaW5nIGFuZCBtZW1vcnkgbGVhay4NCj4+DQo+PiBUbyBvdmVyY29tZSB0
aGUgYWJvdmUgaXNzdWUsIGNoZWNrIHdhaXRpbmdfdHhfc2tiIHBvaW50ZXIgaXMgbm90IE5VTEwN
Cj4+IGFsb25nIHdpdGggb25nb2luZ190eF9za2IgcG9pbnRlcidzIE5VTEwgY2hlY2sgYmVmb3Jl
IHByb2NlZWRpbmcgdG8gYXNzaWduDQo+PiB0aGUgdHggc2tiIGZyb20gd2FpdGluZ190eF9za2Ig
cG9pbnRlciB0byBvbmdvaW5nX3R4X3NrYiBwb2ludGVyLg0KPj4NCj4+IEZpeGVzOiA1M2ZiZGU4
YWIyMWUgKCJuZXQ6IGV0aGVybmV0OiBvYV90YzY6IGltcGxlbWVudCB0cmFuc21pdCBwYXRoIHRv
IHRyYW5zZmVyIHR4IGV0aGVybmV0IGZyYW1lcyIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBQYXJ0aGli
YW4gVmVlcmFzb29yYW4gPHBhcnRoaWJhbi52ZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tPg0KPj4g
LS0tDQo+PiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L29hX3RjNi5jIHwgMiArLQ0KPj4gICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvb2FfdGM2LmMgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9vYV90YzYuYw0KPj4gaW5kZXggNGM4YjBjYTkyMmI3Li5lMWU3YzZlMDc5NjYgMTAwNjQ0DQo+
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9vYV90YzYuYw0KPj4gKysrIGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvb2FfdGM2LmMNCj4+IEBAIC0xMDAzLDcgKzEwMDMsNyBAQCBzdGF0aWMgdTE2
IG9hX3RjNl9wcmVwYXJlX3NwaV90eF9idWZfZm9yX3R4X3NrYnMoc3RydWN0IG9hX3RjNiAqdGM2
KQ0KPj4gICAgICAgICAqLw0KPj4gICAgICAgIGZvciAodXNlZF90eF9jcmVkaXRzID0gMDsgdXNl
ZF90eF9jcmVkaXRzIDwgdGM2LT50eF9jcmVkaXRzOw0KPj4gICAgICAgICAgICAgdXNlZF90eF9j
cmVkaXRzKyspIHsNCj4+IC0gICAgICAgICAgICAgaWYgKCF0YzYtPm9uZ29pbmdfdHhfc2tiKSB7
DQo+PiArICAgICAgICAgICAgIGlmICghdGM2LT5vbmdvaW5nX3R4X3NrYiAmJiB0YzYtPndhaXRp
bmdfdHhfc2tiKSB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgIHRjNi0+b25nb2luZ190eF9z
a2IgPSB0YzYtPndhaXRpbmdfdHhfc2tiOw0KPj4gICAgICAgICAgICAgICAgICAgICAgICB0YzYt
PndhaXRpbmdfdHhfc2tiID0gTlVMTDsNCj4gDQo+IEl0IGlzIHVuY2xlYXIgdG8gbWUgaG93IHRo
aXMgYWRkaXRpb25hbCBjaGVjayBjb21wbGV0ZWx5IHJlc29sdmVzIHJhY2UNCj4gY29uZGl0aW9u
cz8gSXMgdGhlcmUgc29tZSBvdGhlciBsb2NraW5nIG9yIHN5bmNocm9uaXphdGlvbiBzdWNoIHRo
ZQ0KPiBzZWNvbmQgdGhyZWFkIGNhbm5vdCBoYXZlIHVwZGF0ZWQgd2FpdGluZ190eF9za2IgZWl0
aGVyIHByaW9yIG9yIGFmdGVyDQo+IHRoaXMgY2hlY2s/DQo+IA0KPiBUaGlzIGZlZWxzIGxpa2Ug
eW91IHdhbnQgc29tZSBzb3J0IG9mIGF0b21pYyBleGNoYW5nZSBvcGVyYXRpb24uLi4NCk9rLCB0
aGFua3MgZm9yIHlvdXIgaW5wdXQuIEkgdGhpbmsgcHJvdGVjdGluZyB0aGlzIGNvZGUgc2VjdGlv
biB3aXRoIGEgDQptdXRleCBsb2NrIHdpbGwgcHJldmVudCB0aGlzIHJhY2UgY29uZGl0aW9uLiBT
byB0aGUgY29kZSB3aWxsIGJlY29tZSANCmxpa2UgYmVsb3csDQoNCmlmICghdGM2LT5vbmdvaW5n
X3R4X3NrYikgew0KCW11dGV4X2xvY2soJnR4X3NrYl9sb2NrKTsNCgl0YzYtPm9uZ29pbmdfdHhf
c2tiID0gdGM2LT53YWl0aW5nX3R4X3NrYjsNCgl0YzYtPndhaXRpbmdfdHhfc2tiID0gTlVMTDsN
CgltdXRleF91bmxvY2soJnR4X3NrYl9sb2NrKTsNCn0NCg0KSG9wZSB0aGlzIGlzIHdoYXQgeW91
IGV4cGVjdGVkIHJpZ2h0Pw0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4+ICAg
ICAgICAgICAgICAgIH0NCj4gDQoNCg==

