Return-Path: <netdev+bounces-171624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD97A4DE19
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 13:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 386597A5DE9
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB84220298A;
	Tue,  4 Mar 2025 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lCh55QL5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92A91FDE05;
	Tue,  4 Mar 2025 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741091746; cv=fail; b=Fu+kOhnxtRJ8jpib/yEqdnO1/3ioYK92L9GS4iDAc5VqPF+IUiOfdcML7wAUwoz1a8jhUv1ltcH4cfSgqw1wB3KFFnyQB33oByxUT3WzIT/XjsFvsWNOYCJ9QZejtLTchJsF6ia2KZLbTxz7ghs10LJL/PG8+7FyfEYR/P5i2lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741091746; c=relaxed/simple;
	bh=akJvNmryyJJ/C6Z4HU10G1VMOhiCRzp4ez44SwDLwYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sPHqw+CBhFTyvG62b6xXVe2wsTrsOtDJ8qFdZvfZ4Utk3S3MZQI1+7FyswKXmbuGSpf6X05Qvctp1aiAzXIqhRy0KXPaV9g+1qP4wD1bQb6eQ34BN3gxUixVXU7LYefgA1ebrINHjNkPi7eDjEnm3f+5IFj0FZLZSClLQM3C0mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lCh55QL5; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvKaPpQ71tyZwpJ98xSxKhiL17umklxfOqOaKM0jEJD7FnUAvts6ZH5lBQOg9+9uODlUnik5iXqteJNNcte+SondFMVjgyCBGBfoo1ml2L7Tm8W4mFpRNKkkGzG/4GLUCoB96apV+ZlfjeBFt5jjq0+z0loPf8nqIS4XhPY4owzo/P93yErUR/lVs67Ldgz5Yf8vuEyaEpuBYymJLBHEsy5nY4BSZWnMJTF0Y+n1X6ms75pk9JwfAtmIHClR11U7dzd2rZi6ERFARQShoE3xc9vYtIGcWmH4lsFT0Am3nyPufwBr5370lhAnBMSmnKr1bouQMFG1tx/pK2g8OZ+RAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akJvNmryyJJ/C6Z4HU10G1VMOhiCRzp4ez44SwDLwYE=;
 b=RlcM6X7ZW1Kl1FgZfbTTCiPCW9I8AEQfnfhujzVYcPzsv9ghypV/3yr8VGxBRfA7XyfNd0sO8BPDVaCtlpBfOU5pXYf2rwe4rlbwlRUva9tKnqD/Aa1qSLFhREYW8+7dh2ZKVkh9uBALLLm9Gzo0s5w7aLrNULDIlMPetYKGastAFo/mjr0CHwnKyAFWmuqLcpvUTxBMRGAEseBEp+y95fowyvHhPI3PcF79RbieHunWBwUDuj+4rZK7oHCNTcOjeqHTToR9yVtoQPHsFGvCryANV/Hg773OzmJJwPho50XhYLHt57DUrHSP4W88YWjDkY+VUvFYBNwBNcV+f1WXnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akJvNmryyJJ/C6Z4HU10G1VMOhiCRzp4ez44SwDLwYE=;
 b=lCh55QL5QJtfOCH4PeGSUBFLzIW29cRgk0W2+s5+H4s2T3JKmDmO66R91wo5Lh/3RLZDKf8/QYZAAblYYp0jrWr0cWuxtMGEkhXjgL7P3xR0CITIELYkQD5cqmQ2EcwPzmAFWfQ03u2yzyZLjBfT1BFUog+54QReByrcSWs7iV7ZM3T0tFxyamVSQdwZgRCDJ+BNWhbn+wCFLFkxiQA/Dbpi9oM+zsWaQ8uOa8meVbOmTHJWuGyne4NmaalKARpGAidFe1BJcMbfJRtQi3xZFTH+69z2/68lhrwyiMoZkU/AFw/uEkEinL7wYiL0TIgZiIF5Ui1tFTP/5RdPiRr3aQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DS0PR11MB8184.namprd11.prod.outlook.com (2603:10b6:8:160::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Tue, 4 Mar
 2025 12:35:42 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%6]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 12:35:42 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <maxime.chevallier@bootlin.com>, <kuba@kernel.org>
CC: <davem@davemloft.net>, <andrew@lunn.ch>, <edumazet@google.com>,
	<pabeni@redhat.com>, <hkallweit1@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <thomas.petazzoni@bootlin.com>,
	<linux-arm-kernel@lists.infradead.org>, <christophe.leroy@csgroup.eu>,
	<herve.codina@bootlin.com>, <f.fainelli@gmail.com>,
	<vladimir.oltean@nxp.com>, <kory.maincent@bootlin.com>,
	<o.rempel@pengutronix.de>, <horms@kernel.org>, <romain.gantois@bootlin.com>,
	<piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net v2] net: ethtool: netlink: Allow NULL nlattrs when
 getting a phy_device
Thread-Topic: [PATCH net v2] net: ethtool: netlink: Allow NULL nlattrs when
 getting a phy_device
Thread-Index: AQHbirPR4bGD1e12EEeZH5/S0BwRh7NiHj4AgACiroCAAC2NgA==
Date: Tue, 4 Mar 2025 12:35:42 +0000
Message-ID: <fc925b52-edcd-425a-aee4-da5df007892c@microchip.com>
References: <20250301141114.97204-1-maxime.chevallier@bootlin.com>
 <20250303161024.43969294@kernel.org> <20250304105239.747500be@fedora.home>
In-Reply-To: <20250304105239.747500be@fedora.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DS0PR11MB8184:EE_
x-ms-office365-filtering-correlation-id: f190bc74-555f-4859-2417-08dd5b1913df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2JPVDNsaWpxUWEzTVorYm5JK3VvWVpkcUVENVRvZUc2aFdSSHdRZ3pqRXZB?=
 =?utf-8?B?a0RFWlN1K3Eva1VUeThDQWZsVm1XclYxdjBhRG1YSmxIa2tsc2FObHlibGlU?=
 =?utf-8?B?a09QOGlWWTgzeWJxRmNJUEJyWXNSdjdkdmFmK0VVZjB6emJYNmd0T1B2aDJu?=
 =?utf-8?B?Q2JwYXEyS2lHSnN1UWs4VEk1bi9LRWMyc2VvV1loNlFoV1AxZjM1S0xmMG5G?=
 =?utf-8?B?WFF5QjJiRENsdGM0U0hibUdpeWRiN05sK1RkOVBGVHlPaUhEcGdrakxoTjI5?=
 =?utf-8?B?aGJTWC9tNWo4Z1l5WXZyd2lPMkVHRFRlTHhLOVhmcmlQbXJkWFZ1VCtLUXJ6?=
 =?utf-8?B?enlralp4OTE2ZlNRRGJ5NFVNZXJuK2RPMEw5TWV4ZWUrUDFxTlBVZXNzUFNm?=
 =?utf-8?B?Rlp5ZXNFN2ZpVkk3SHJkNzkrU2xZZ1crK0g3MCtoa0doVVF3eldCeklaMVRa?=
 =?utf-8?B?anBFNGZmc1JWSnRBSXloZEJrc2d3QXllbUFiUzdtWVh5aXI3UnBIOXl3aDha?=
 =?utf-8?B?N1dVTkpDKzkrQzNvNzdBenhxWlVmMkZpK240RENuendvOHk2WnNFZkE2bXYw?=
 =?utf-8?B?L2tBcVR5TUJoMHQ2WndKWFZDUUVsdjFUemhtckNXNnI0c1RFVXdlN053Zjdt?=
 =?utf-8?B?aEhnMVVxWHE5MThCMmcySmoxUmtBRWRtbC9sQzIrZlJOaFJVMkVScFNLKytB?=
 =?utf-8?B?amdBY2pGVnN5UEd0Q3FCcUhGZkdZMjUyNjFwL28zNElzVjBTQ1hFWC9rQ1BG?=
 =?utf-8?B?cDlKZjZnbzNiVllyd3FGaDYySGlsYTRBb1hERGJmcDRwQjdYeUk0MnZuZVVp?=
 =?utf-8?B?ZFZqRFVDSE5XYzM5ZjF4UUlCcWljOHM1dkJXV1F0QWpqbWhheGRTVFBHQ2NF?=
 =?utf-8?B?U1pLMUwzQWt1aEM1eUpMdXdJNDJjakRDMHZZU3hBS04yU1owR2lhMWFyTlMw?=
 =?utf-8?B?a0Fwc2tFaDU4eWNTNUlxRFd3Sm1jZ2pvakRqQ081Q3JwSlZ3aFp4Q0ZOT042?=
 =?utf-8?B?SzNVaHU0cFI3SldIVm1ZM0VsajFxZkc2ZWt4VlB1QUxlWGJ2REhuZk43YXRv?=
 =?utf-8?B?TUtxTUFLUjNkdW03SjNJUWZ0TThCaU15QmlpNWV5YkJjYWd2UUhNblU1T2NX?=
 =?utf-8?B?ditMR1pOY1ZleDV0VW53OGlaUGt3T0FSaCtZdTB6Si9SN0cxRXpxSVJUY2s3?=
 =?utf-8?B?aWlzUy9aTEVsUlJVYkVYcmM2OVg1NEtmenhKWFhLMEYwTzFoc0pwampVOTNv?=
 =?utf-8?B?WlpoVnozd2xJWkVRR3d4a3IvN0VrY2h6WXpKSzNXd3ljK1NMY1JJTjMrSkE1?=
 =?utf-8?B?UzUwM0Roc09mR3RQRkltV1ZXK0V3RFNUaGd4d2psa0xCZHlXeCtMV25hNk16?=
 =?utf-8?B?ck1pTlZDNDhENDNTbmJHMTZscU9RUkUrdVA3OS9VbmNGWEtBNExJTUhURVhi?=
 =?utf-8?B?ckFPYUJETXpTYjMzdWU4R0I0RVk1dUMzM3hiellUQWZ1Q243dHVNT21VR2pU?=
 =?utf-8?B?L3dXK2VLZFZ6eHYxWTZ0UVJlUFl6aTNEOHV6djVYOGhDZlRKZUxJcHY3ait5?=
 =?utf-8?B?dXB4UHUzRWNLNGNEdUtIYjE5bG5XV0Z1NDVkKzVpNldYOUN2TXJ4emJqN283?=
 =?utf-8?B?alREOUJYYm04NjZvUnRycHpTOHhaOFJVb3Z0a2NPMzBmU0tzbGdOc3JncGxw?=
 =?utf-8?B?Y1lxYW1HZitQVFZiejFHazJQejNia2lqOWhqMFJMaTZQazc0TWxLa1VHMDJC?=
 =?utf-8?B?VGZWU0JtOVlBTXpyRjZNRmc4N3FXeEs2M0toaFkxbHl5RTE2WVNwSWF6Mm9w?=
 =?utf-8?B?eDVzYk9LQVMyMHloTER0YWJkSGNDUmxEVHBkWDJMcHd1bXo5ZEJDRllZMXk3?=
 =?utf-8?B?SFFMQkJ3MTVCckphZDV2WGJaeXFvTmdhMFNsNmJoQnJ3MUIzRHl2bWpxUUZq?=
 =?utf-8?Q?IzcI23OtBOziMVsZzAyMxD4AuyLcJz6Z?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2dLVDM3SGlTaStMOWc5SWpyOU1IN05vMWNmajBIUnh3NW54ZTFzT2xEQk0v?=
 =?utf-8?B?OVFwZXFxSWtzU0twRmlaenN6VkQwMXUzNkE0QUtiV0R2SGkzbEMwVy9lMGF2?=
 =?utf-8?B?ekNaQTNUUC9KTzVIbTdBU1Awb0JtKzJPdHQ3S2gvanZUMkpvRnRPV3hyTTZS?=
 =?utf-8?B?L0dYODR5eXdBZXdLeENoMFgwK3YxRHZoSm9zZFgwRkx3Y1NSZktOUWFNb2dY?=
 =?utf-8?B?TWU0UXhhaGhPdEs4OE1OdVZzSHBwWFVFWWxBM1lOdnAreVEzOW9oS0xJZ0JL?=
 =?utf-8?B?QTdQSlZOSFdvTHFmM0hkRW93aDlDcm5LZ1pjUG43UlJxOGZndXFDYWxTWjUv?=
 =?utf-8?B?L25yTURTcmVXcnRtRkZwbk9lK2g3S3hVcDhpTnBBMVF2cEdaUjVMMXlpeDli?=
 =?utf-8?B?ZmNFTHJKVnRYTEsvS1E1UUpyV3BmTklUOXlHREVEVmdWSE5pbEtmblVJVklv?=
 =?utf-8?B?bXNvZ3NoWDBQdTlnc01oaHlRVWs5WWNic3o4RURsT2N0QWwrQWN4QjJ2Z2VK?=
 =?utf-8?B?OEhoRHVoNjJqV0RoU2FwSGlxbEhqOUhOQ2k5TktwZ0pYR2lTdGgzWmFLQUdH?=
 =?utf-8?B?Q09DT2lsZzVVYkZyTWtIYm15amZzakpMV2pjTW9QSFdIbUYrNlVtZXRGSGhT?=
 =?utf-8?B?Smh6SFFBTlUvTlY0ZUsvVFAyMVJZaHhGb1lTWFlFdURXbHFrRHdUMFlqTnpF?=
 =?utf-8?B?SE1rTDRpMWVWaEdIR3QzWnZramVLdnBRa05zbXRBNWxUcmtjQXVzUmNOa1Z5?=
 =?utf-8?B?NlFoUjNFbmhDSW0xMUY2a04rMVRQUFB1TTJ3eC9DWGZ5TUx3Yit0WHNDOHpo?=
 =?utf-8?B?a3lDSm8vVXFONk5kSmFuOW8rQXlLZFEwZXdhUjBEYlF6QVJLRW8vbm5oMTR4?=
 =?utf-8?B?cDk5Mi9nRG9pckxDNFo3Z0Fkd2t5b1d3eVI2a3NPUXdRL3RCeG40REZscEhr?=
 =?utf-8?B?MVo4cDNqdGhNR3FNN1kyRHVqV3Q4U0ZjT08zdjkzV3BzOEtYeThNaDJEY0Mr?=
 =?utf-8?B?cmpET0tqSjdmM25mSzRsOElEVzMyWFdtLzI1YWlDK3YxZHZzaThQOWx2aXZp?=
 =?utf-8?B?R2NKS0VYMjlxVGVqYzA1UzZyWDNZSWhPNjU4bHVoQnhCZWRuem5Demp2RWF5?=
 =?utf-8?B?VVRPOXptWEkxQm9wUVVNOEttMkd5ZW1DczFXYlR6STN2ZFBmQ3BuT1hPVldy?=
 =?utf-8?B?VWxtTXcvcW5NbzhBYUY2dzAwZ2Ywb3pSOFdBN1plbEhmL3B5RXgwbUZjczcw?=
 =?utf-8?B?MXU1RWRnWVNlbEJyRVhrWUJXTGdUeUtvdVlnNGdjMDhHYzI2bnhPVTdhMU4x?=
 =?utf-8?B?SksvWnZrVy8wN2pVTU5aSzVIYXFyT1RwZ3prTmx4bC94NzByMVU2N2d5NWt3?=
 =?utf-8?B?aHRiZFhWUGwrT2R0cVB6Yk5PbHBSN0YwYnhSRUNCZmR0dEhlWnZ4WnBORjND?=
 =?utf-8?B?T1lSY3Nna0Rva2Q5SUNiRXo1S2s5cHRUL1JnYTZaVEgvRk01bEhWeEp4TStG?=
 =?utf-8?B?TzZvdmtsVCtmbEI1L01oY3pVNWJrTjNDT3hiMnBEb2N3R1FNbTFBdVljYWNs?=
 =?utf-8?B?aXdBZGdpS0VFQk04TUFJUkZ3d3Qxb0dWaEVIUFl4YyswaDJPeTZZODRzSXNZ?=
 =?utf-8?B?bkF3OEtvU0hQdUllL2hOTTdtb0dsTU1Hak9lYUZxa1dWRGhhcFFwTXI4K3Yx?=
 =?utf-8?B?RGFYNGVwOWg4M1dxYTE3Q2FoeHFDV3IvTTNhenNja1lkVDRNRGhxMkhmV2pM?=
 =?utf-8?B?UFIxS2w1eC9GMVBtUGgwOGt4Zmh2THhwOUlxSnR1ZEtpbUg4bDI3dzRvM2hE?=
 =?utf-8?B?cHU2a1NYNHVyMFM3QXFEWHJoeGwvUWtQbEdCMERuSVh1a3pZcThIdFRmdkpT?=
 =?utf-8?B?MDRUaWdMZVA0RWFCdmlKc1o5cm9NeG96WU8rNU1obk1MWS9EV29LTHoyRGRH?=
 =?utf-8?B?bTl1dlczYTlDdFN6OGN4VVozajFwV3RCMjlCQWYyTk53RjNUUzJTbXB4bHVx?=
 =?utf-8?B?d0ZlT3owZ3ZlRU1DeTg2SzhyelBvMWZabC9tTzBCbE44V1JMQ0JSVXJnRVNZ?=
 =?utf-8?B?dDlkNE1ERkpkRXNOanNYUUx1ZEt2aEtIR055RGRkYkFMT285NXAwekZTOGpU?=
 =?utf-8?B?VjR3Z2U2Z3IrT0FCdVZ1aytsMVZFRk1SRDkrOC9pelNvMjV4UEtvMDg1dVVj?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E38D2337C1BB042B519936BB750EFAC@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f190bc74-555f-4859-2417-08dd5b1913df
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 12:35:42.1622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DfrLeckq+lQgUIpi5wvIGb2rd01FKaKT1+No4GW6+3r5iaTGUVUDj7t/+r8BO8dw9JQ5L7dbC/DZ3hQRmTi5peIQvyKiiO09xZqnoBACaVglbK/bWnlv5aV7g5RfMTrI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8184

SGkgQWxsLA0KDQpPbiAwNC8wMy8yNSAzOjIyIHBtLCBNYXhpbWUgQ2hldmFsbGllciB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBNb24sIDMgTWFy
IDIwMjUgMTY6MTA6MjQgLTA4MDANCj4gSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4g
d3JvdGU6DQo+IA0KPj4gT24gU2F0LCAgMSBNYXIgMjAyNSAxNToxMToxMyArMDEwMCBNYXhpbWUg
Q2hldmFsbGllciB3cm90ZToNCj4+PiBldGhubF9yZXFfZ2V0X3BoeWRldigpIGlzIHVzZWQgdG8g
bG9va3VwIGEgcGh5X2RldmljZSwgaW4gdGhlIGNhc2UgYW4NCj4+PiBldGh0b29sIG5ldGxpbmsg
Y29tbWFuZCB0YXJnZXRzIGEgc3BlY2lmaWMgcGh5ZGV2IHdpdGhpbiBhIG5ldGRldidzDQo+Pj4g
dG9wb2xvZ3kuDQo+Pj4NCj4+PiBJdCB0YWtlcyBhcyBhIHBhcmFtZXRlciBhIGNvbnN0IHN0cnVj
dCBubGF0dHIgKmhlYWRlciB0aGF0J3MgdXNlZCBmb3INCj4+PiBlcnJvciBoYW5kbGluZyA6DQo+
Pj4NCj4+PiAgICAgICAgIGlmICghcGh5ZGV2KSB7DQo+Pj4gICAgICAgICAgICAgICAgIE5MX1NF
VF9FUlJfTVNHX0FUVFIoZXh0YWNrLCBoZWFkZXIsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIm5vIHBoeSBtYXRjaGluZyBwaHlpbmRleCIpOw0KPj4+ICAgICAgICAg
ICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PREVWKTsNCj4+PiAgICAgICAgIH0NCj4+Pg0KPj4+
IEluIHRoZSBub3RpZnkgcGF0aCBhZnRlciBhIC0+c2V0IG9wZXJhdGlvbiBob3dldmVyLCB0aGVy
ZSdzIG5vIHJlcXVlc3QNCj4+PiBhdHRyaWJ1dGVzIGF2YWlsYWJsZS4NCj4+Pg0KPj4+IFRoZSB0
eXBpY2FsIGNhbGxzaXRlIGZvciB0aGUgYWJvdmUgZnVuY3Rpb24gbG9va3MgbGlrZToNCj4+Pg0K
Pj4+ICAgICAgcGh5ZGV2ID0gZXRobmxfcmVxX2dldF9waHlkZXYocmVxX2Jhc2UsIHRiW0VUSFRP
T0xfQV9YWFhfSEVBREVSXSwNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGluZm8tPmV4dGFjayk7DQo+Pj4NCj4+PiBTbywgd2hlbiB0YiBpcyBOVUxMIChzdWNoIGFzIGlu
IHRoZSBldGhubCBub3RpZnkgcGF0aCksIHdlIGhhdmUgYSBuaWNlDQo+Pj4gY3Jhc2guDQo+Pj4N
Cj4+PiBJdCB0dXJucyBvdXQgdGhhdCB0aGVyZSdzIG9ubHkgdGhlIFBMQ0EgY29tbWFuZCB0aGF0
IGlzIGluIHRoYXQgY2FzZSwgYXMNCj4+PiB0aGUgb3RoZXIgcGh5ZGV2LXNwZWNpZmljIGNvbW1h
bmRzIGRvbid0IGhhdmUgYSBub3RpZmljYXRpb24uDQo+Pj4NCj4+PiBUaGlzIGNvbW1pdCBmaXhl
cyB0aGUgY3Jhc2ggYnkgcGFzc2luZyB0aGUgY21kIGluZGV4IGFuZCB0aGUgbmxhdHRyDQo+Pj4g
YXJyYXkgc2VwYXJhdGVseSwgYWxsb3dpbmcgTlVMTC1jaGVja2luZyBpdCBkaXJlY3RseSBpbnNp
ZGUgdGhlIGhlbHBlci4NCj4+Pg0KPj4+IEZpeGVzOiBjMTVlMDY1YjQ2ZGMgKCJuZXQ6IGV0aHRv
b2w6IEFsbG93IHBhc3NpbmcgYSBwaHkgaW5kZXggZm9yIHNvbWUgY29tbWFuZHMiKQ0KPj4+IFNp
Z25lZC1vZmYtYnk6IE1heGltZSBDaGV2YWxsaWVyIDxtYXhpbWUuY2hldmFsbGllckBib290bGlu
LmNvbT4NCj4+DQo+PiBXZWxsLCB0aGlzIGFsb25lIGRvZXNuJ3QgbG9vayB0b28gYmFkLi4gOikg
SG9wZWZ1bGx5IHdlIGNhbiBhZGRyZXNzDQo+PiBhZGRpbmcgbW9yZSBzdWl0YWJsZSBoYW5kbGVy
cyBmb3IgcGh5IG9wcyBpbiBuZXQtbmV4dC4NCj4gDQo+IFllYWggSSdtIGNvb2tpbmcgc29tZXRo
aW5nIHRvIGltcHJvdmUgb24gdGhhdCwgYW5kIEkgaGF2ZSBhbHNvIGR1c3RlZA0KPiBvZmYgYSBu
ZXRkZXZzaW0gcGF0Y2ggSSBoYWQgd3JpdHRlbiBiYWNrIHdoZW4gd29ya2luZyBvbiB0aGUNCj4g
cGh5X2xpbmtfdG9wb2xvZ3kgdGhhdCBhZGRzIHZlcnkgdmVyeSBiYXNpYyBQSFkgc3VwcG9ydCBz
byB0aGF0IHdlIGNhbg0KPiBzdGFydCBjb3ZlcmluZyBhbGwgdGhlc2UgY29tbWFuZHMgd2l0aCBw
cm9wZXIgdGVzdHMuIEknbGwgaG9wZWZ1bGx5IHNlbmQNCj4gc29tZXRoaW5nIGluIHRoZSBjb21p
bmcgd2VlayBvciBzby4NCj4gDQo+PiBEaWRuJ3Qgc29tZW9uZSByZXBvcnQgdGhpcywgdGhvPyBJ
IHZhZ3VlbHkgcmVtZW1iZXIgc2VlaW5nIGFuIGVtYWlsLA0KPj4gdW5sZXNzIHRoZXkgc2FpZCB0
aGV5IGRvbid0IHdhbnQgdG8gYmUgY3JlZGl0ZWQgbWF5YmUgd2Ugc2hvdWxkIGFkZA0KPj4gYSBS
ZXBvcnRlZC1ieSB0YWc/IFlvdSBjYW4gcG9zdCBpdCBpbiByZXBseSwgbm8gbmVlZCB0byByZXBv
c3QNCj4+IHRoZSBwYXRjaC4NCj4gDQo+IFBhcnRoaWJhbiByZXBvcnRlZCB0aGlzIHdpdGhvdXQg
Q0M6IG5ldGRldiwgYnV0IEkgdGhpbmsgaXQncyBmYWlyIHRvDQo+IGFkZCA6DQo+IA0KPiBSZXBv
cnRlZC1ieTogUGFydGhpYmFuIFZlZXJhc29vcmFuIDxwYXJ0aGliYW4udmVlcmFzb29yYW5AbWlj
cm9jaGlwLmNvbT4NClRoYW5rIHlvdSBmb3IgZml4aW5nIHRoZSBpc3N1ZS4NCg0KQmVzdCByZWdh
cmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+IEkgZGlkbid0IGluY2x1ZGUgaXQgaW4gdGhlIGZpcnN0
IHBsYWNlIGJlY2F1c2UgY2hlY2twYXRjaCBjb21wbGFpbmVkDQo+IGFib3V0IGEgcmVwb3J0ZWQt
YnkgdGFnIHdpdGhvdXQgYSAiQ2xvc2VzOiIsIHdoaWNoIHdlIGRvbid0IGhhdmUNCj4gYmVjYXVz
ZSBvZiB0aGUgcHJpdmF0ZSByZXBvcnRpbmcgOikNCj4gDQo+IFRoYW5rcyBKYWt1YiwNCj4gDQo+
IE1heGltZQ0KDQo=

