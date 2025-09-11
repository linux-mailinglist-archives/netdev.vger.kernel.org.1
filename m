Return-Path: <netdev+bounces-222060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5D0B52EFD
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7084883C4
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BBE2D7DD4;
	Thu, 11 Sep 2025 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TIUk3XSD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9FC1A9FA0;
	Thu, 11 Sep 2025 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588027; cv=fail; b=RBhkjBW/r1qqdLyL2AYH6E+3A65797/geNkfS444q/hJHb1UFHYWbsOUNJJsDoRlaHOJDxvTXOb1BvcklmpdU+Sy+g1B4skoSCz4Fbfsvt0lWr94cPlwhTGzF+skOPwh3PVJ2ioghRms27whTBRvEzQQOP+5weWNeLv6+p7mGTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588027; c=relaxed/simple;
	bh=vi8ln8rS9/04Uv7lQN26wnkZ332v9CjshN2FOa9S6bw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=idGzlc+wwQJaRl7huuJXeabh2e92ZhsUqHiuYlhFQFs0ONWzSPlljsgSWMCJSa2pFCzOzRR8uHkXXutriI+OOCDcvXTXAjZVD6jxJUUlRD8FcxysFhLm9ErzLM5hWWSH0OxC7VlooI+6JCfTYu1UIbXNrNfGCiI1vcGWAS1ArJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TIUk3XSD; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clRoZYXDKjqxhOwx5AN6jlQ8epeCOyobhMQlvuIr9LK4uT+9iXGqZDese5RyShLNG5AXKCTRAbz5QUwN+V0m7HfWDOEEXqYMSUbO42JblZ9X6eOM3u9ha5H2di25L61QiWtDl+4iwuDQoY3aVVgh9tIZyOXNrcG7q4yCXKx/xyDK4IaF/hswIVK2lVzsoCThkk0oeA0wdlhY9zv+IzrcExz8jZIvIOsqB4IBE1Bs7Ok+vgSkNxD6h6JSwEmT/8Mjc8DSILA2FQb1sqlwiXrcuGnVPtDBRbCjiBSqTlu/V+rJmBsUI5ZzmjuQj2owfHzj+tKN7pz7N3EHsGbM5X9yYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vi8ln8rS9/04Uv7lQN26wnkZ332v9CjshN2FOa9S6bw=;
 b=B6Ci0RFGp12iv+RsaHlvtiCV4ItV4xTSXpo5QVN3KsX8Y0V2DA1boVJGYNupcugibvBwPQoypPcToVHtlkIQgAQ1tJRCYSZnQRQ3cVaY4pA2gYmEzjkbtV1Uetg1PrBzJIy8F9DbjJs9VT803gvpoex9JrS8/ppmijiCLzT0xtFaur71rY6bmgk3Xu9lJhMUbh7pzMkcqunb4BWljAXM+VJ6ivYr/aZmyPlFA+n270umPWDbHwUXMhZXtdSyJE9PPuvoVtMvDkWQc3/qYNCErv4GN94fro9KLdDZlLNqvZKQ9R5BNFaez7H/R0LuEjOcRYAnGxeBPlbVqVVXScuQrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vi8ln8rS9/04Uv7lQN26wnkZ332v9CjshN2FOa9S6bw=;
 b=TIUk3XSDSnqNk1Z/BnglxgIWFAfiWkkOpOLuFTO9y3KZ9mXpoY39grkeyfiTulAVW/WXoaOxrn494G+xmUox30JJU3ZkNfEiMATbrKBs6T8jC+EpuWKioofoTmPgHcyLkhrbWOZyEigj5IHxFav0WuvV10Xm1VHqQ13skpyc5uoxd+KfPa9X9d1xYerAcuV6ZmamobphWn7g6QFMyFuCQhgrsWNY9E+HVCjyLqAZl+gVmViKuD6qG1mu2PX+CKjWnB6/Ua2X+cF4Q9DP6UwjHx9ZATkDgfQ3B+LmneOe3Iv55iwYoLfvDyFbc2Sra8DS01S3/VSpZj8VmCi97rHIFw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DM3PPFCA3BFC2BF.namprd11.prod.outlook.com (2603:10b6:f:fc00::f4c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 10:53:41 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 10:53:41 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <bastien.curutchet@bootlin.com>, <Woojung.Huh@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <marex@denx.de>
CC: <thomas.petazzoni@bootlin.com>, <miquel.raynal@bootlin.com>,
	<pascal.eberhard@se.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: configure strap pins
 during reset
Thread-Topic: [PATCH net-next 2/2] net: dsa: microchip: configure strap pins
 during reset
Thread-Index: AQHcImSfxkeqKajulkWkTfxGEb781rSNz+EA
Date: Thu, 11 Sep 2025 10:53:41 +0000
Message-ID: <7361bf07-892b-406f-aca5-c53a7d876ac4@microchip.com>
References: <20250910-ksz-strap-pins-v1-0-6308bb2e139e@bootlin.com>
 <20250910-ksz-strap-pins-v1-2-6308bb2e139e@bootlin.com>
In-Reply-To: <20250910-ksz-strap-pins-v1-2-6308bb2e139e@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DM3PPFCA3BFC2BF:EE_
x-ms-office365-filtering-correlation-id: 0e7ffddd-fe26-43c7-c512-08ddf121785d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NXdlVmRqajJmODRPSDlGalRFQ0NxZ1V6blpOSzJjTXdWdDFtTGR5ZEc1S0RI?=
 =?utf-8?B?Q1hBNE12OVRkcEgyZm9KTEY5TVB0SnAwd0xVYkdpZllaUkorbmNnNjFZbjJ6?=
 =?utf-8?B?a28rYjVIU0hMZVBJMUVLWnd4dzErc2lJVVNxd084ZFpSaHUwMzB2YWN2MFdB?=
 =?utf-8?B?eUcweGNQRXhFc1FpVW1PQlRHWjRyakxEaUd6a2VzdkdVOFlZVmZWSDVCOFhD?=
 =?utf-8?B?NHZManFMWUExT1E5WlpobWFkTUlOVTI1WjFoeTdkTWhSSnNKY0dEaFVzclJz?=
 =?utf-8?B?Z1V0a0U1MFc4bDNHZXhLdGJUWWdxTkFQNlN0andBbnFERW9sUFJJL05LVDlC?=
 =?utf-8?B?MW1rSlhsZFZNZ2RXSFpsV0lsaTBwOEF5RURCS1dPajl2empBNTkwb2xuVlU2?=
 =?utf-8?B?SUpvczhDdlBwdVh2OVh4WWtFSFY1VExpbEthek5hTFhXWlgwNnVuL2RkL3pE?=
 =?utf-8?B?aUFBZVEzbzZXWjlkTCtXN1R0cXl0aDdabzVjUERqVDRPRmVCbUJSNDIyeEty?=
 =?utf-8?B?MmgweXk3a1NoTDhtZnlyRWtxL3dHcnVPQXNTV2VMaWNqZHNTdzN2N0d3Sk1D?=
 =?utf-8?B?R3JKNHIzM2t5S1Viajdtd245aVZjZ1k2UnlsUlpwVHhBR2ZPbEdaZmxvM0Ny?=
 =?utf-8?B?Wkp0SVlZY2hVdXdRWWd0NmpZMlE3eVBoa2dCQWhURHhvb3lJbkhsUThwQWN2?=
 =?utf-8?B?ZFBtOHBlaVJnWldRK3ZBL2N4YkZwcGtQbnRXc1BaNkYvT2xRQmgzWGZLQ2JS?=
 =?utf-8?B?S0NuclVIaGdRRmpkanZzeFZUakNMRFRReGV1V3VNQ2o0N2lxSUNZaHZFSnBH?=
 =?utf-8?B?UXEwd0o2dTVLT2xvOHpkZVNBOGQzUFc3VUJEMmpjMjczMUlndzZnWnJjMTQ2?=
 =?utf-8?B?dzlDSUJ5cmZaaVlaNmprQk9TMzBSTjBic1dBazJQKzlGdVpzb0FqTzBBY1hh?=
 =?utf-8?B?ZDdwVEE0cVMyRWNhaUcybzdNOXBMcVZoY25KRittU0plUlM4T1hjZVZOa1ZE?=
 =?utf-8?B?MlV5RVZXRnd2UlV5M1JZUm40cWc1eXM0RCtIdE05QTMyOWNBNXg4TGRSd25h?=
 =?utf-8?B?Si9VTFRuSEpEelhpNjVPbi9CcFlrL2dzRnE2eGlDNDIvbnJHcys4cUtyRXdN?=
 =?utf-8?B?QldvVkx5RTVGd3VwTldxQ1dJWFBGMXVVb0lCaG9yRVVIMG0wTEtkMG1KUlpU?=
 =?utf-8?B?eUpMUUk4aVg5a0F5L2NlcDhXMUNEL2VlVllDQktGRXRlWXlKaXozMFBYMGdE?=
 =?utf-8?B?b0dMVFcxMGhDZlFsZEpLa1FZbzR2UzEvMjZUVStza0luZGpkb3VCQ3FXR214?=
 =?utf-8?B?QTd5RlowSm8vUU0zWEdBZGVBR1B4NjZ1Yjg1MmpKdDBJSVFXUU05MGo4bjBJ?=
 =?utf-8?B?cTE0dDNaVjVZejl5ZW5CS1VhTG1OVWN0eWxJTWplZjRXdE1oRkVPajFqQzF2?=
 =?utf-8?B?Yld1V0lydFlXRy9pUDJPTTRtVzBNZjNGMXRyd1A0d0lnNHhVdndqeWk5QkFQ?=
 =?utf-8?B?MnZkUG40TW5TWFY3bGJWM2tiYmpsc0dJZk1ONXJXTzg3N1cyN3MwOTVFN25Q?=
 =?utf-8?B?UGh4SlQxS1NNcmhhcGt3QUYxTXQvYkcwdENYaWxlQ2Q2TUsvL0VFNkh5dkRG?=
 =?utf-8?B?Rm54QkZuL1ROOEtZbEhRS252bmk0RGxvVXY5ZWJDNGFZeUlCa2JqdGQrUlNF?=
 =?utf-8?B?VTQ5T3JyS0d6Q0Y4U1RkcmNoQ2plRk01QktWUTNFV2loRFdmaEtoc3pFOEE4?=
 =?utf-8?B?VFdzN0xNQXN5SjhGZmZNc0c2eVhlS2xFYU1BNWYyTDdQaVdWQmppL0s0UU85?=
 =?utf-8?B?dlA2eFdXZkdTd0NORGNUNkIwOGlmd0JEVWI0blpHSXpSWWJReGRUS0ZoNHAr?=
 =?utf-8?B?ck5OMERVTWZHMmU4eUMrc0xrVjFtQjhxZW5YTlZselI0VDczRm0rSnFMbmJo?=
 =?utf-8?B?SWJkTXNVcnR4YnJKRUZaWFBjUy84WUNiUmdjSWJadDFQQXlIYzZiYStGaDM2?=
 =?utf-8?Q?JBQXpnVpfBHE75ke5+LREWr34w9uLU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXlQSTJPeHhCazRBU0ZVRklZbW16OEYwS0tWcjJOTmJyQmZXbTNCR0pyMGJk?=
 =?utf-8?B?QW80UG9nM3FhbmZZV2F4RitXY0Z1NFN4REovc0tkbkUxaTg1a1pCdTUrSjV2?=
 =?utf-8?B?UGQyc09CbGZtcXVBcGF4dXAxaDJ4bHlzTzF3U1NNb29mR1gzT21tcjl6Tm5C?=
 =?utf-8?B?K1NTS0I4RmNmbU5UWUJRdlNGTHVUZkd3V21kOHZhdk9DNVVqK2duak5RQ2pi?=
 =?utf-8?B?YXRORzRGdUljMVJxckZTVG5DdWxIM0NOMFluTXlFbkRmN0d5UE11WFU2NEtN?=
 =?utf-8?B?K1FmM3I4OG81K2o3MW5wWmYrMzRXajNDT0QzcGJNbjgzM0wxU0o5Mm8zMVRi?=
 =?utf-8?B?QnpuckpFeCt2Z3l3Y3JRSEdla25GUG5BdUFaOVVST1RHbDY5cHZRVTRQVDVM?=
 =?utf-8?B?aWdGNHVyaFlBejZsVU9CQ3lTT0hOU1FLaVZCY1hYbHJ5WW5Rd2gvWVBEUHEr?=
 =?utf-8?B?dUcxRWRFTGlkdFovUzNpZ2hobnNsaEtqTXlDU3VHeE1abGQvM245ZW5tR1Aw?=
 =?utf-8?B?b1FBaTd5aCtWR3lPRUcwc3JieWNEVUs2bkdjdm9wZ0JPODBKVEc0c3BBUUN0?=
 =?utf-8?B?eGx0WUxKS2xBcExCTTkyUkpGOHRHVjN1czJCSHY4L3cxd2p2OGRJendVSHlH?=
 =?utf-8?B?dHpLN2Zab2dYRW1rNnFUa3FWS2Z3UkFrTnFNNmQ2K3hTTkFvbUhEejQ1NXA4?=
 =?utf-8?B?cFliUzIxdTVnQ2xsVWhFTGRyOHJDK3h6cGNMdjFtWmxQZ1A1RUxZbi9aMWRZ?=
 =?utf-8?B?N0pJTkhmRkpmak1xOWwyNmE4UmNTUzdqMUdtR2xQY25FTDFoYWw0ZC9kaCt4?=
 =?utf-8?B?UHE1RGYzMnpNRnVndmV5SEg3Q0FsVEx0R1VFY3VLUGhsTDVoeWF1ZzNYakxL?=
 =?utf-8?B?aHZKZlpOUDNYMlNtNVdDRlVGUVkvQnMyVitLTmxPYmJib1d0VjZwQ3B4amFl?=
 =?utf-8?B?eHAxYitRQ1VqYTB3M3ViclBHV3ZnaUZ4a0w5QnBGbzVCU0pSU1dlSTNvWm5o?=
 =?utf-8?B?UWVwYzhjKzdQWFlKMkxzV2lkVzNEM21QemcrQzhIWHBjWmMzZWFMRVR6ODMw?=
 =?utf-8?B?eTNXMmZVTnRPbXEzRmpNS3RZTHJyL2hvVHpCN3pVVGJPMUI2TzVYMjBaV2Mx?=
 =?utf-8?B?ckNobWcxZG9LV3RzL1pvbGh1U1V2Y1MySHNJc0cxYTJlOURuZ3hHR3BSZnBa?=
 =?utf-8?B?cUkxKzRhZWFGUExIano4clRlUUdXUFRlTkRXTzNtYlphaExTSGhFVC9SSkRT?=
 =?utf-8?B?MzVUeGdCTEdaMVJyeWoza3BnMWFyZHNxSkVIVE1HdWp0ekJLS2pzWUxiRURQ?=
 =?utf-8?B?MWVZbGdid1pKaUpsVHRaalY2TzIxTkxJT2xyV2p4aU5wK1ZaUWVKYzNTY0Qz?=
 =?utf-8?B?TnBDR1RRbG5GQXNBQkN5emM1U2crZlRiNjIzdEE2NFc4K0VSN2ZkMTNuOXFi?=
 =?utf-8?B?aGlBNU5qVHFJT05Mc2k0M29VRmRYNE1CUzhvbWZUYXRXWmh6YmxOUjI2eVhy?=
 =?utf-8?B?MXV5VXhrVVRmT0N1eTNBK1plOTFoSGdibjlQbjNXaWllTHNkZGVLS0VweU5L?=
 =?utf-8?B?dG5sUEttbHgvWjFJV05OaEtsa1JEZkw3dy90MWR3ZHhhVUR1SWxHQ1JmUVJG?=
 =?utf-8?B?R3pMVkNxbnpXaUZ0a2c5a1J3c1NLcnJyTk9LaDZxSzRVY2ViNlVxYm9lS21H?=
 =?utf-8?B?eUQzVGdNdm5HK2p3VjhSY2hqUzE2cnRleFE5aHpacnBiWE5CSDZOVG5Yem5L?=
 =?utf-8?B?SWVMSm14dHZlanRrSGdKVDBDcnhFcDVYWEFtaTNiallmT2FjVHEwV0F2Zi95?=
 =?utf-8?B?YTlTdTVNcVZ3cXl0Y3piZkQ5S3NWeGRFbmZXUW5uT0Q1cGhMdnpYWU9Lemdv?=
 =?utf-8?B?b1pmbnpwZDdTK2ZqU0d4RnZGOFBEVk9xdXJDa280YWt6Rmp3ODE1ZHladU9I?=
 =?utf-8?B?UTJUOCtFa09qMnIvWjNkanV5dDFxTlVZOHMwYlRZUmp2Y3dnckFyOFg2ajNP?=
 =?utf-8?B?K0h4MVlRNUQ5bWQvbjlUMUZQa05zdmhrMVFReXdLcHNDVytzM3dmdmhkMVlT?=
 =?utf-8?B?UWFoUUc2cXI3enc0RGF5OHlFM0xnNEY1UUhRRjVxZ3kvYllMTEFhTVJEWlhx?=
 =?utf-8?B?NlZ5OTN4elB4UFBFdVpqai9BVDdQWCtrM0VUM0hDeXpxeUxMemR6S0hnSm9E?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E96766CA0A18D84EA63D9DE44D9F0167@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7ffddd-fe26-43c7-c512-08ddf121785d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 10:53:41.1582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPa/l78NLH8A4FkIKieZ+zVp+DZBLTCn+4w1k2DfgO9DJYyab+i+CxGUxZzjV2HrIGcRIik6zXEPd2zeFCcY7sDyQ0dJZF7J/I4fstbvN3XWuJ0NoKFTTPakg01zVTyJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFCA3BFC2BF

SGksDQoNCk9uIDEwLzA5LzI1IDg6MjUgcG0sIEJhc3RpZW4gQ3VydXRjaGV0IHdyb3RlOg0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3pfY29tbW9uLmMgYi9kcml2
ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzel9jb21tb24uYw0KPiBpbmRleCA3MjkyYmZlMmY3Y2Fj
M2EwZDg4YmI1MTMzOWNjMjg3ZjU2Y2ExZDFmLi4wYWIyMDFhM2MzMzZiOTliYTkyZDg3YzAwM2Jh
NDhmN2Y4MmEwOThhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tz
el9jb21tb24uYw0KPiArKysgYi9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzel9jb21tb24u
Yw0KPiBAQCAtMjMsNiArMjMsNyBAQA0KPiAgICNpbmNsdWRlIDxsaW51eC9vZl9tZGlvLmg+DQo+
ICAgI2luY2x1ZGUgPGxpbnV4L29mX25ldC5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9taWNyZWxf
cGh5Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcGluY3RybC9jb25zdW1lci5oPg0KPiAgICNpbmNs
dWRlIDxuZXQvZHNhLmg+DQo+ICAgI2luY2x1ZGUgPG5ldC9pZWVlODAyMXEuaD4NCj4gICAjaW5j
bHVkZSA8bmV0L3BrdF9jbHMuaD4NCj4gQEAgLTUzMzgsNiArNTMzOSw0NCBAQCBzdGF0aWMgaW50
IGtzel9wYXJzZV9kcml2ZV9zdHJlbmd0aChzdHJ1Y3Qga3N6X2RldmljZSAqZGV2KQ0KPiAgICAg
ICAgICByZXR1cm4gMDsNCj4gICB9DQo+IA0KPiArc3RhdGljIGludCBrc3pfY29uZmlndXJlX3N0
cmFwKHN0cnVjdCBrc3pfZGV2aWNlICpkZXYpDQo+ICt7DQo+ICsgICAgICAgc3RydWN0IHBpbmN0
cmxfc3RhdGUgKnN0YXRlID0gTlVMTDsNCkkgZG9uJ3QgdGhpbmsgeW91IG5lZWQgdG8gaW5pdGlh
bGl6ZSBoZXJlLg0KPiArICAgICAgIHN0cnVjdCBwaW5jdHJsICpwaW5jdHJsOw0KPiArICAgICAg
IGludCByZXQ7DQo+ICsNCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCg==

