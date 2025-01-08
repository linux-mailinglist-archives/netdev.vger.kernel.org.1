Return-Path: <netdev+bounces-156151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 364CEA051B1
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 04:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE261188A272
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5252198E92;
	Wed,  8 Jan 2025 03:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="5CdjzaiH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3492B9B9
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 03:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736307754; cv=fail; b=so2jAErolpfQi06JKk2AwDZa88cpHlaewliO56l5P/oA7kFqAB8BbHEYJP4fk+jfK/+E7nzupByDVysBL7b1/Qf0P7DD9VwM3AgAGQ0SN4DT/N+4RNDvcdj4nZ9U0mjHIgVddcm50CZBLyT2eFD0tHYwzVUpXChpCQ7BvKlAU2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736307754; c=relaxed/simple;
	bh=3Cz/vzhOAt9LhD1G0dvuDHK2KWeNNlYnmgSBkCVuIRY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OkUTr/sfRJ49krBXy2anYZCjeqCb/MLKJJylKKdsp0EmwuxThL0aZIVZ65G64h+2y2v6l0p5RF3OkkcVajZwHXw5H/ywOdYCcqFNM4TP1tB9pOwdD1oUV1lKFYCQN9tsDKdktXunLGwMf/lfAYC5qF7O/eJ7ZXzyC3Cp1lZivOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=5CdjzaiH; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1Pv3ndMCV/FJCuTyoOSFStQynLkWoRHGFgXr809DV7Gkv8tzDsMNqkqdZ1sr/H08sqfmzMkvfjzJffgSTpQMtNQjhUZkmVaVyuhDregJ7gAZvTk0amsIgwvkFnEBrDCz0exSckTPq4zPlcgHCSNlALBkRlUDGD19CTxytjiNQICRT+o2iL98Ksnkq1LS0gjvqddby2HHlt/OMothXhQJ8OmnvH9xG27Kf6jhMHKWTDEz+9KiHNmOVJuTlmHE9DE+RbMWUw0qONkwH1OD7IrPY/d+jMtQspXQY1Oe9CE7X7UAuxNre9J+PbHDJbJGopMq4SzIYZV+lFugnZyMsCfwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Cz/vzhOAt9LhD1G0dvuDHK2KWeNNlYnmgSBkCVuIRY=;
 b=vNfgrZnFo+KCM//EQrQI3saKH7dpKgH9fx3UdyfYBS9utaRSo5Xmmw0SvqW1Z1JSSxkQQTs1Z/8wI/dltJNVuKR43U4AImnc2TgiFXetzlUPEwSNe0t/ScxbY46H8NPhcp3dmc9tWqh6MKVqDL6+E+gbaeVasdVRpJ7Owi0uK26aexTua8Tv7Lai79AMv1T/pDZZ4+4dzrhPg9cfcU5YPnXgb7gjbat0p+1KHcYFzX1/kG5WspuDmrtumqIj23kY03NnHEFXYCUk48lKEjp4UpNdSbo/pohj3Ea2Fu3kaPz4x5cHwAXJnNDXyIhQFJ2tY8ook49N2TlRk9Kxs4g3TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Cz/vzhOAt9LhD1G0dvuDHK2KWeNNlYnmgSBkCVuIRY=;
 b=5CdjzaiH/6nLzb76+7DWA1M4b1xfqUW+PY4hsy6Ub5V81gDXsdVwlsumQXz1Sui0ax7OuHwHIb2WJi0AtNkpB7dvj78BFIgyGj7Zn8tFQ3h5Zmf9I6MsY2CY3IhYOmTgncDfv7WXzZH+QCSRlQt1DlFc2rikrVtQAWtoHgWamqmkGBavwZqO4/G4rJuU1OOXf6z+qGyNhBLHSKwdSX36wRAL3bCvY4wCJ4QHw+rlz7BAY9s9AU75eUH4TqCqTKdyPej2audg3WNBj0KPZFrK9iwFBOf3zcjB1zFNZ5X7q9ikeajTIcGGZcfPIDu6WHH16sw2UUqFRwGEaMz9M4PZUA==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by PH7PR11MB5944.namprd11.prod.outlook.com (2603:10b6:510:124::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 03:42:30 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f%6]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 03:42:30 +0000
From: <Rengarajan.S@microchip.com>
To: <Woojung.Huh@microchip.com>, <kuba@kernel.org>
CC: <Thangaraj.S@microchip.com>, <edumazet@google.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net 2/8] MAINTAINERS: mark Microchip LAN78xx as Orphan
Thread-Topic: [PATCH net 2/8] MAINTAINERS: mark Microchip LAN78xx as Orphan
Thread-Index:
 AQHbYFuyrVcAlX+vYkCLN6Uqrkp8arMLWwrwgAAQIgCAAABOIIAAEcCAgAADWjCAALyjAA==
Date: Wed, 8 Jan 2025 03:42:30 +0000
Message-ID: <9328391fd5466aa406873dc2d1167be100ad340c.camel@microchip.com>
References: <20250106165404.1832481-1-kuba@kernel.org>
	 <20250106165404.1832481-3-kuba@kernel.org>
	 <BL0PR11MB29136D1F91BBC69E985BFBD6E7112@BL0PR11MB2913.namprd11.prod.outlook.com>
	 <20250107070802.1326e74a@kernel.org>
	 <SN6PR11MB29266D59098EEEB22ED3BE86E7112@SN6PR11MB2926.namprd11.prod.outlook.com>
	 <20250107081239.32c91792@kernel.org>
	 <SN6PR11MB29264E3220B873B6CCC4C318E7112@SN6PR11MB2926.namprd11.prod.outlook.com>
In-Reply-To:
 <SN6PR11MB29264E3220B873B6CCC4C318E7112@SN6PR11MB2926.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|PH7PR11MB5944:EE_
x-ms-office365-filtering-correlation-id: 34756b42-73b4-4795-8741-08dd2f967a83
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UGxZSndranM0cU5MV3FtZzRUQWcwK0xRTEFZaDlmYkpuQklrcXEzU2JZcGhF?=
 =?utf-8?B?S2x3VTFuVlN2TEVoWWFQZjNZbldITmdxSmVjMFc1VkJUQ1l4L3VrdExGRSt1?=
 =?utf-8?B?N3JHQWIySHJvVFd1M0ZwblhGaUh0eGFkYUJQR1ZKenlRUTJTU1JPc004clZW?=
 =?utf-8?B?K0cwYmYwNURKaGdNaFI1aHp0WHFydkVTcjNZQ2wyQTR0dW83Rko4ejdyK1lH?=
 =?utf-8?B?NnM4ZnJJbjFkMzJmbTIwNW1VaEZtZHY5aGdTQTZsaFpIZUU5SU9jVXdWV0pu?=
 =?utf-8?B?N2FDdVBwN1BDZ3htUHpWZDhFWFNra2h0Y0JYUTRZd2phQnBBR3J4bHc2WlA2?=
 =?utf-8?B?ajVoM2kwNjNjODc2WE02WHduU2gxZUMwWDNnb0FMb3JmZVBOMVpOcnRYSS9Y?=
 =?utf-8?B?VmZSaHpRSWd3dStjbU8ySEF6aTBiK3JCdnB4YVh6R1FSMTJBVzBqa3NXaWtr?=
 =?utf-8?B?YW1KUDR2MFR2cmhKYUtqdFc4ZGJpSzdPWTc3eGRtUmtHbVJVYXdQZUFsbnFt?=
 =?utf-8?B?RCtJdE9GS0paM1Z4c1JVYUVmdGlSOXduaHhWamFiREJmOU1NV2NERElYdUtV?=
 =?utf-8?B?U2xTc2hXZU8rNEp3ay8rNnpsTGRTN0pqaWJmdGlVbTV2MFhVU1ZxTGlFOHNQ?=
 =?utf-8?B?VHRWdkY3UkY3RWJDZkQ4QkxkaWNnRTJXTzk4TUVFOWluK09zMHFrMHZ5cjQ0?=
 =?utf-8?B?UDY5WENhVVRCOHRraExMUnNMV1Z3Q0U0dmVTVGtMbzh0ZkhURm42WXFQSkR5?=
 =?utf-8?B?cm0zdXQxSFc3OFQ5MXcrMnhZelJLZVM0OEJtMVozZjdrTk5xVzhOMTRiV2lx?=
 =?utf-8?B?LzFjUW1hVWxlc0NPbjBCL05lUVROYU5YdStlSndmMDI1b3RieEQ0c2QyUXZi?=
 =?utf-8?B?TG45M29UVkpUNHpHRC82L29XNDdvQkJWR1BNbWFqckZIUm1QdUdTNVJLSWZC?=
 =?utf-8?B?NEZmREpJczVBWVFMY3FobVJKRnhNQlRrNlVzbnRaQWNSVU5obWtSM3BOckY4?=
 =?utf-8?B?SVNzcDd3ZnE2bE9WSlA5TzFEc1hreTFkbjhIS2ZLVk9jL0tyVXRsK0Z2YnRh?=
 =?utf-8?B?SmFjbXE1KzU5d3pEVjROaEpOVE42YU5td3RaSEpjdzhXaGtWZHBiY2pFRnRp?=
 =?utf-8?B?ZHU3TVJobGNlU29yVGFONkFCRUJOQXV4VkhSSWdaNTNLY2tudnpyN2dYeENv?=
 =?utf-8?B?eldLMGxDekxFeUdZY0ZHbllTR2ZsdFBsN290VXlRS280TzNkVm5HZFYwd1pH?=
 =?utf-8?B?Wnh5MlQ4aGdnVzhIclRVenFiRHhUU2VqWk1abEo2c1lIRXZuRyt1VXdEbXNG?=
 =?utf-8?B?eDNWVlB5TWdISG1rU3RLZEwxbjdIREFJbW5UNEt0S0w0cXdvRGRXOXk4cDc0?=
 =?utf-8?B?bGtCcG1YTGdIN0RsSkh5TzFqYmlCc21OUTBuVWIvN012M3pmSllQQm84VHZJ?=
 =?utf-8?B?NlZRSFp1VUlKNVdvUjNUK2RJMEx4U0pKUXJOOFFiTzBFVnFvUXloWjRwajZ3?=
 =?utf-8?B?dkVmbHNsMmVNT2o3N1pLZnE4UHduU2c1dkJtSWFhSFZENHBnNWpsZkVMenVJ?=
 =?utf-8?B?MStQUWFBbEh6UThJUHIrdHhna013dmUzUXhSdkc3bDErcktzcmJpTkVmeUNw?=
 =?utf-8?B?WHBzaTZqYURIZ1ZheXZxVTJBV2d4NzBnMFpBZDhqUGFKR0RnZGNFRy9Ubnli?=
 =?utf-8?B?YlRucDQyZXdRTGt6QXE0TzlMczNRVUZpbTdNd0ZidTFzUm1zUm9IcTBPb2w2?=
 =?utf-8?B?SGwzTkdrQjdrVUpPbFM1a0dPM3h4c2lIR1pUdW8zS2d0amErRGtvVmFKUitu?=
 =?utf-8?B?eEFSSGQ4cHhlOUZLcURNbkxUV2NYWFdXSXM1YjI0Y09JRzVwREFFRG9NS2hz?=
 =?utf-8?B?MWdwaHQwc0Z5dWhUV2ZqMndWeWZVTjdiellZWWZkbnZBVTcwdTYzTE1ZVzJE?=
 =?utf-8?Q?FAKAB8dLYbeIVX0ZwND5+mdyBOIuAHWJ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGpoaERXU091TU4zY2FCM2NiZHlzZUd2dlhqeTNha0xWNmZrYnM5aVkwUDJr?=
 =?utf-8?B?OTBzZDJZbUdIYm92bld5R2czYVVwaTFGMG9VOFRWbi81RXZ6UVJmTTFGZktM?=
 =?utf-8?B?RDFvOGZyMTRjemVDOERSM0FDV3A2Qm5Fc3pRM2VFQVNjRWg1TE91dGduSUVJ?=
 =?utf-8?B?QjhZOUlMRDl2dkZ4KzFleVV3emNOTlk0RWx6NmhsV1NoU3FyVmhicVZQU2pH?=
 =?utf-8?B?RW54Uno2OUFmLzliYkpLYWpHZjJPd1ZLU2I0TVlaZ2YrQ3AwbHdXNCtZVHFn?=
 =?utf-8?B?bytrMCtKbnA0RG5FVVFCaFdFaGh4ZG41OEtRVjByYUpJU29ENzBRR2FZc0xD?=
 =?utf-8?B?N1ZVZ0pUeEdZU3hWQWZyRHd2ZlFKZkUzUy80cHcvTmF3d2lPVUFraENhdEt5?=
 =?utf-8?B?VFFRVFoxQk5SSmRYbktkRU84dnpSb1libHV3elJzWXJhWlNsZE04YllwMDFE?=
 =?utf-8?B?Uk9kTEt3UHVjNmZ0b0RBaTlybWh4SGNQbElyVFBPc0FSZFJKZGZJSUhPNkJI?=
 =?utf-8?B?bkszL2pHUTNOam5GQmlucnhnc1BCOTVvTzVrL21nZE1GeXNBSStlRHhFVGNZ?=
 =?utf-8?B?cUdTRlhHTEdaYldNQ0ZtN2pCK1VsaFp2NUNlUkZLWUJXL2h2YkVkenB0bFZX?=
 =?utf-8?B?dXB4ZkJDODY2eWI0Y1NjbFZrVXVPbWUxb3ZPcXg3czhNblZlckphdDdXWVRK?=
 =?utf-8?B?cFRoSmdQOFZyVjZ1YXIyTktiSnYyRDNjQ1JPUVVHaUNxcEhkQ2hwTEtTUWdY?=
 =?utf-8?B?K2J5anN3K2JHWHRwTFByMDVhL05zZnBmODAyZTh6Vys4UVZKSTY5UC9QTU10?=
 =?utf-8?B?L2RiZU50bGhsdmxCQkJldzNjVEpxTk52dHljaUVrTU5rcHRQdzVUOU01T0Y4?=
 =?utf-8?B?aWc0YkFHSVhndVpySjdjb3k4WVBtVnRPUUZjTk9jSkNESVJBaC9HbW5BQkJk?=
 =?utf-8?B?ck5oL1J0SXVRMnlwaGduamNRbTdPSURJNkpWUlJRb2FzWmNqZDVML3VtbHZ0?=
 =?utf-8?B?MTlnbmJZNmxkV05iUWZwSm9scHlmWXFzUWNYWmlQZ3FGd2hyN3FXRm9jempE?=
 =?utf-8?B?NS9vNXZnbG5LbVZ1eldCeGd4dGhiZC93TmdYVmFDaWExdDk0MWNrb3luN0lq?=
 =?utf-8?B?R1dyYkpIalJCaHFnbVpkUXFDYmVTWGRkaGx6dEovQ2wreTEvM3QyTUEydXY3?=
 =?utf-8?B?QXlLZUxmcklRZmovMUlyYkloZi9vM2RYdnh3bjFLTmRGZEZnVFFEWUNMMGpx?=
 =?utf-8?B?Rk42RWZCWFZJeGxGZDZ2OUh5emVWbWR6cFFzZzVIeVQycGpCaWQwUEFLVjlW?=
 =?utf-8?B?cGtDWURlbGNVbEdpbVFiRzlxcDN6bWk1OUljMk9SR2hpWTJpUEErbXdvTVJ1?=
 =?utf-8?B?MXAyWjYvRlMwZTgyMnRURVZuTWRaR0JXeko2TXRNZWlkaDJtL2FmYlVzNGtX?=
 =?utf-8?B?MnhpZS9SdVA4TjJDZXRFMzBOa0xZV3F0bkNwS05sNUVTZ28ydDVOcFZkeGRp?=
 =?utf-8?B?RUdMQzVtNE5BK2taUTRPRW5MekExemZjdVZ1bUVGRm5ydXczWmlPbUlrQ1I3?=
 =?utf-8?B?Q1Awazd1Wmp1Qm1keFJvRGp3OHZCdUZqdm5jNXNlaXRnaEh4WVJmcEVyay8y?=
 =?utf-8?B?d0FEdmg0Tzc4eXcxcmRseC9jVkh4bXBhSXZNZEQ5clIrR2N5ODN4SE9QemNv?=
 =?utf-8?B?eDk3Y2VtbXExcTQ0Wlp4RlBxZGl0b3VtUXFMbTFIUUJRQ1JBWGVqcU53V2NR?=
 =?utf-8?B?bW1vd21QRFNSa1JqbFlydHJpZVd3YXFuSXg4ZWdOSW5QMG1GY2xSVUFJY29T?=
 =?utf-8?B?dy85UGJaQ2xzT2Y4cHkxVTFCKy8ycXZtMG1neUtXMVMvd3ozV2tyYm1DK29k?=
 =?utf-8?B?RVNJVi9OZzNNQ1VYdGo4N1RQUGFPR2dVR3NRMlp4NEtWMlBsK3lVQ3R0ZlAx?=
 =?utf-8?B?a0FvakJLNGRhVUVWVEFhakhEcG1OOENHNlJJRVY0Zy9WeWVOdm80U2ZTVFA3?=
 =?utf-8?B?ckJNR1ZGdm1ScVA3TWpqd1dxSFd5WmNGcmdZQlJHRzUzdHJQNWhYNHBGdVVr?=
 =?utf-8?B?NVVvRkM1REJWRm5ESDF4cTYrTHE2UzV6MGgrSzl6OFZaME1wR3lyaXVZTHdI?=
 =?utf-8?B?Y1Frd1ptRlM1ek1KZmV4NXl3Uy9LV3lXaFVtbnUxVHZMZU5kWi9PQmVIWkc1?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E9EE319F8117C46A613A9CF4DE4E79A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34756b42-73b4-4795-8741-08dd2f967a83
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 03:42:30.3101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g7bgu+5rHNXZr6DO6JBGbAupmofp38/sKBkpWi5xsjfDxJvwvShGJfGVv7uSYzvsHE4z1Ifi+CbK/squOW/zmOdwT2epXdQphafrQGn/rNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5944

SGkgV29vanVuZyAmIEpha3ViLA0KDQpPbiBUdWUsIDIwMjUtMDEtMDcgYXQgMTY6MjkgKzAwMDAs
IFdvb2p1bmcgSHVoIC0gQzIxNjk5IHdyb3RlOg0KPiBIaSBSZW5nYXJhamFuLA0KPiANCj4gPiBP
biBUdWUsIDcgSmFuIDIwMjUgMTU6MTA6MjEgKzAwMDAgV29vanVuZy5IdWhAbWljcm9jaGlwLmNv
bSB3cm90ZToNCj4gPiA+IEhpIEpha3ViLA0KPiA+ID4gDQo+ID4gPiA+IE9uIFR1ZSwgNyBKYW4g
MjAyNSAxNDoxNDo1NiArMDAwMCBXb29qdW5nLkh1aEBtaWNyb2NoaXAuY29tDQo+ID4gPiA+IHdy
b3RlOg0KPiA+ID4gPiA+IFN1cmVseSwgdGhleSBzaG91bGQgaW52b2x2ZSBtb3JlIG9uIHBhdGNo
ZXMgYW5kIGVhcm4gY3JlZGl0cywNCj4gPiA+ID4gPiBidXQNCj4gPiA+ID4gPiBUaGFuZ2FyYWog
U2FteW5hdGhhbiA8VGhhbmdhcmFqLlNAbWljcm9jaGlwLmNvbT4gYW5kDQo+ID4gPiA+ID4gUmVu
Z2FyYWphbiBTIDxSZW5nYXJhamFuLlNAbWljcm9jaGlwLmNvbT4gYXJlIGdvaW5nIHRvIHRha2UN
Cj4gPiA+ID4gPiBjYXJlDQo+ID4gTEFONzh4eA0KPiA+ID4gPiA+IGZyb20gTWljcm9jaGlwLg0K
PiA+ID4gPiANCj4gPiA+ID4gSSBjYW4gYWRkIHRoZW0sIEkgbmVlZCB0byByZXNwaW4gdGhlIHNl
cmllcywgYW55d2F5Lg0KPiA+ID4gDQo+ID4gPiBUaGF0J3MgZ3JlYXQhIFRoYW5rcyENCj4gPiAN
Cj4gPiBDb3VsZCB5b3Ugc2hhcmUgdGhlIGZ1bGwgbmFtZSBvZiBSZW5nYXJhamFuIFMgPw0KPiAN
Cj4gV291bGQgeW91IHNoYXJlIGl0Pw0KDQpNeSBmdWxsIG5hbWUgaXMgUmVuZ2FyYWphbiBTdW5k
YXJhcmFqYW4uDQoNCj4gDQo+IFRoYW5rcw0KPiBXb29qdW5nDQo=

