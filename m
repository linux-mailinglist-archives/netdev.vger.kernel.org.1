Return-Path: <netdev+bounces-216439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE54B33A18
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 11:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083F31B22E44
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 09:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B8B2C08BF;
	Mon, 25 Aug 2025 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ka29yRI3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDA62417E6;
	Mon, 25 Aug 2025 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756112621; cv=fail; b=uuiWkvVcwH56xc7giHm/LvciHP/ZWkyMW2QRpP8hJpwC25rEM5sBg5Q8YR3JwRas97Smc/0ekREVkBBPemrbw/sA/lAQ29c+F71pWBIA50ZLvjrba8yfjypi+Yi8YWBzGpicBFUgT4qb5RYQgzU8aWcgZZakfFwDUiBqlL4v7zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756112621; c=relaxed/simple;
	bh=VJN3T1ADBWx8KL7xwWdvFpNCvJsBbKlw31MwUAbWC1Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GqpSN+yOsSOnQQlcZ1Y+GqRVooRMTfwtieaLXUv6jS8CHA7T0UXjr3hxfRiEpmYQsdF59L74pIkWoMzhXYpz+iGNUZ88QRQJmDcMGrL86/6isxGJ4yrzx+vOwpu10RIJbnlOWdeK3JVwG8IFM1xs/dbqBI12xt6Q/+GTrk4xqZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ka29yRI3; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcWk7XNrMnK0QfomkhCGtnyqZ9eznx0USfxxbymuEKepDi3JlHyY50/F12SGMCbYy3w4Bidhu5+85SvhRlGhRseaKY9+Rk9JEC0iM4prt20tyT6oWEGHA8nMQuh+5skmJd0/fCnnic01Wz8Un1fP0ASmTDG67F+RKsWmljC9ttKG2xFMfX916rC2kF49po3y9MFTGzMMdEZW6EfhYzV22zj6EhYYNT9e+uH3Wvh7MMsB9jrnocTVBiwZAuebKl5BlRac3keMD13AYxEGj4M23iDsmdn3+Zz834Zb3VLs8JnC5WG8dVI0wcO753ojqKBTwoB4Y3U19Gjxso9kw5wRRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJN3T1ADBWx8KL7xwWdvFpNCvJsBbKlw31MwUAbWC1Q=;
 b=W/Mm+ORS0hlOW/bUQa7ijXjRSRq/r6J9RQTFGpGexv9xRlcWUG0AY1PPaobhk06Hy7CndEqxxMKbwmytjeKcCRvId8ENyEXEYApkSXrbNMi9CTEIu+4swPrXNXMRSuMBbvSc/g5vNVh09Z6dDjuxOeE15tX2eIFOGCDYp8xkyNqcDslbYWtZCw9/i7qpECMU23i5f7TRIyshPAHYwGb41JHKuy1RBm/ZAZ3NmS/spx8ow6ua2Rv6hGWghVC5Vpi6zW//MN40IDLXvdMceAv8q0pIGypXpk0AzTVxkD1eiLJs6nByyg4qHUZVYobu3RBv8+gPT7IyYzE917mU0J/Dkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJN3T1ADBWx8KL7xwWdvFpNCvJsBbKlw31MwUAbWC1Q=;
 b=ka29yRI3QCUc9QLlCCZNwLAGX5BLpBYUVd2jVnyV7c2aERSSe0+kIUa6HV068XN1TwvFooJicpSjncK2X3abWxYZsHWJu63gOktbTlet9hoOoCE7FrHzqcryDdNRKbC8Jnbfqkg7hoqtCjjSehN9QQ1A3YyrNRUWpOdT4tYJO/QDAQpQmXOgiZ0z0CVbac6SLOzKbsIij8W6+zoF9d++PNUk0yHcNJbVceeJ6jEsiXF5VVVQLA5l47vgqrSOd3xqupA5xMGxgJx33j2dgGn2e18oMK6rrO3wpqRxb7fSV+h3Epq3EfhHZ1PMTwGAWbLC0QXbD9AMzEyR3E0ZcRqpUQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by MW4PR11MB6667.namprd11.prod.outlook.com (2603:10b6:303:1ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Mon, 25 Aug
 2025 09:03:36 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 09:03:35 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Horatiu.Vultur@microchip.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] net: phy: micrel: Add PTP support for
 lan8842
Thread-Topic: [PATCH net-next v2 2/2] net: phy: micrel: Add PTP support for
 lan8842
Thread-Index: AQHcFYruU0Sy0aWoaES5SIN6ZdSO8LRzEzCA
Date: Mon, 25 Aug 2025 09:03:35 +0000
Message-ID: <0b754e84-45d0-4d3e-aa14-564ab5528b98@microchip.com>
References: <20250825063136.2884640-1-horatiu.vultur@microchip.com>
 <20250825063136.2884640-3-horatiu.vultur@microchip.com>
In-Reply-To: <20250825063136.2884640-3-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|MW4PR11MB6667:EE_
x-ms-office365-filtering-correlation-id: 4a2b86bc-696d-431e-71e4-08dde3b64626
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?emNpSzlCeGlYczJIUmgzOEJpNGNoSlhyOUpmdG5zTWx6dDRRd0haN3Z3RHdP?=
 =?utf-8?B?MSt6RVJLYmMrTUREZE52TVdITDNyTmQ5R3FaQzVpV2FDYVczS1NKQ0RXdnlM?=
 =?utf-8?B?UkhEMUg4WTZIcEgzSFpweXdIY2hqNUtTKzQvNU91K3pZbndscis5QmFISXlh?=
 =?utf-8?B?Y0lsbGtUc1VFWmxCUU5PeEloSXY5cmpXVmNEcXBYUUF5Q1pCMHFwN2ZTQWZ2?=
 =?utf-8?B?b3Q5S3l0SktybmYwZ0xJTEJjSkZTN3pyNVN4bEpBTHJncFc3TmFYSE9NYmV6?=
 =?utf-8?B?NkltS1dOY1k3QUpya0I1SWJ3aWE4c25DMXhobmNoeG5XYThGL1FudFJJeXha?=
 =?utf-8?B?VXpEYWRsb3FtSWI3dXJtRjIvdjdZd21RRG9BOHkxcjdaQTJuanhmUW8rRGNI?=
 =?utf-8?B?K3JuUkNSdXZYcUpRQWx0S0dZbDdKK3VndENOWGF5RFhSQjdaR1lBeDhNeTJV?=
 =?utf-8?B?M2VBNVU3cjFHWERJT3RaTmx4aE9UUDl3SHV1UmtFS1grdWlYMFhSYUlEekdI?=
 =?utf-8?B?TnBhWGMzNHY4bW9JQzErL096dzg3VDlURUZEN3JWNGs2SWo5R1NVWTJpRG1q?=
 =?utf-8?B?ZmtTdXAwenZWWFEwSit0WG53STdIcSt4bEVYZzlNaEEzMnB6L1pQcTVXQzFJ?=
 =?utf-8?B?ZkxsVHc2c00vTEFxQXQ2dlo3SFZrajVXOTEzZ0IxRE9aQzlEUkRBMHoxcUFY?=
 =?utf-8?B?V2VpWGRVeG92S3B6VnhzQ2N2L0lMOVdRd0U1MnkrQWp1NDEwNzMyOGkzMGlq?=
 =?utf-8?B?UER0bHk5UktNYjljalU5c0Y1RDBBQVBHd2lJZ1g3WDhYa3NsY3BDYklzMWVO?=
 =?utf-8?B?S3JDVzVmZ0QzWm9UdnFpemY1YnVpM3ZQN2pkOERXTWdIYkdrbVdGS3pNWEZn?=
 =?utf-8?B?MmpYUnY4eFhLalNjWVV2STE4aVNFUXpYVEh4Uk1ack5SVWZMa3F3RWxEdTBy?=
 =?utf-8?B?aSs5RSsxY0ZpbExyWENMbXlsS0c1ZmZPeDF3VHVaenp0Zk1QNHF1NWI2Zzhz?=
 =?utf-8?B?YUtNMFR3VlZsbzVac0dHOUFJZ2YybTVBbVdMODh0OTlDL3JxU1Q4OVdmdWZ0?=
 =?utf-8?B?cUVsME5iQUV2bndHYk9LV2FtWVR3MTg0QkNUTnFkZVo5bll5L3RPaWxXeUdX?=
 =?utf-8?B?Mjc5bE1LVFVMNmZrRk5WYlVIT0J6aStzWEI3clZKWDM5VklDY3lnakJxZVNa?=
 =?utf-8?B?enR0bktBekovUzJnZS9XREMzaDREa1lOWk1CaGROVjUvUkhHVThoc0lTMllv?=
 =?utf-8?B?NS9NdFRlQnozaU11MSszSzEwR2NiWVZ6UWd4UTlwQWx6aW1Zc1IxYkhoUzNJ?=
 =?utf-8?B?bU9GWTBUWDdSRmdzTkVCL2pacGltWTZBVlA1UDZZQjRSN0VWU2RUcXZpdUVT?=
 =?utf-8?B?WEhuekV5Q2NVd09kbGVVMlFFVWUrUG5UdjNTdFZGZDNaY1RXTVQwTGRVRm5N?=
 =?utf-8?B?dXZVNmNoVVgyZzdIWDUxUjE3bXFoa0U1WVRSZ1dQbXdnSlNaTUxXa1NOMnRs?=
 =?utf-8?B?NnpkanBQZENBV0ZjQ3M4QlV2U1Nqc3VFS0ZQZWZRYWRwbXFhV2dpckRCcDR1?=
 =?utf-8?B?Ni9KRUJzOXpRWDVsVFRmb2hCUDh2a2RnQUNVd28wTEZ1bWptVVByU3dYdEl1?=
 =?utf-8?B?RG1mR29IYjI0aXNaTWdhdWljUi9sNE92aG5lMU85MHNDN1VQM1hPRnlkQUZC?=
 =?utf-8?B?MU1QQlV2akhVeVhaUm1TU084djZHRG5VcTExS3BEeWpKMmt4ZXhTdEtjbndP?=
 =?utf-8?B?TnE5c3BNVzAzOWhKaXIveDFac1VsYlowRWhzV01LUXVqdklRTE03Sm9UTWNv?=
 =?utf-8?B?QkE3TjcwU2JUY3BKbUlVcmxMTlRsQkNUOEtUL1R0ZUNaUHZUM08xRk8rQ3FV?=
 =?utf-8?B?UEF5TVZDcnMxamM4Y0NyNDFya2s5T3Y5Ti90Sm1HdVVvaUViM2FqMitvSk1m?=
 =?utf-8?B?c1pOU3NrTGwxMXA4cjhtSGdQSWFnTzFvMTRDK3g2eUV1MURtWWNNYlluY2Nh?=
 =?utf-8?B?TE8rcmg4SjV3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2JYWWh0cGxGRFlCS0Jpb29zV25QNXF1YTEzcVl6eHNWalVWY25lbEo4SEpH?=
 =?utf-8?B?Ym9ha2oyM2ZPUmJYekNLR2tqR3Q1MnI1ODBzQlVLV01uU0xpWFJEVSs3R05V?=
 =?utf-8?B?ZU56NFZEeHBBYmpmaFdGR3ZVbkZjZGtmME1uTVBXMDJhZEdnaERDbVFwVkFj?=
 =?utf-8?B?ekZhMUtIa2xQcVR3Tm1HUmFmZnFxbWkwbEJiaXBUNHM4SlpvZFltak9EcVhh?=
 =?utf-8?B?RW83SHRjOTFaUi9JblRCNXBHcmVIblFMRXRMVkJEZWRDZ0I3MXFteWk0SGJT?=
 =?utf-8?B?eUVkSGdEYlhuZXArMy9nYy9QYm1qWUVTVzA3cVl5Rk9QWGQzU3VEaU5SaGZh?=
 =?utf-8?B?dnlQa2M5dFRMakgxaTduZ01qcmwvYjliOWh1U1JJMnA0ajdQckgxa0FiVmZ6?=
 =?utf-8?B?aG5Hc1lrRmpvNjcrQUp3MXhVQ0c0Z2ZaZ245VHNmRDdLaTZtOXFyd3M3RGQx?=
 =?utf-8?B?YmRiWkF0bkNEeUZvNWEzZFpBWmRLYXI1dmNhMW1GTkk1Sk1yT203M0J6ZEpM?=
 =?utf-8?B?emdob3JtZ0FZT0ZEMzE1d1JZMm5XMDlQbHU3L2ZqMDdMOUt6WHRkN29GUHh3?=
 =?utf-8?B?SU9EaUg2aHNCTlFRYUlOUnd1Qk8xMm94NVZSZGZHc1ErVTJqeTlqOFhPYTJ2?=
 =?utf-8?B?Zm50UEdWR2JMd043V3hFY0NhdmpRUDhOUjVycmRYMzY0V0hHbkhUWW9uc0Vv?=
 =?utf-8?B?K3RiR1ZGbHRUZDJReWdlalladU9VOE9qajFnU0VmekRJcmVOcWVoUGU4WEN2?=
 =?utf-8?B?aUk4RVZjTVBERFE1dmNnSlhaMnBML1dCUjZra3ZYR3VBd21kZ1N0ZEFwUEVX?=
 =?utf-8?B?MkdkS1ZYTmh6SVVXZXVseUNreEJyeDViU2NYTXVDNU5zdmF4dEE2bmx5UEJH?=
 =?utf-8?B?OHRuL3pkSGxvN2NuTXFSc3BDVlBXUU9QZ3grbzNHY3NpeDhnS25XNDMvQ0Ny?=
 =?utf-8?B?ZVFuMy9tZTF0b2MrQmxxYldGL29FbkJzM0txQnZVTXhvQkx4TFI2cG1KMGZW?=
 =?utf-8?B?QUFvUnhrbk9oSm9tbTBINXFxK0lkZ25XRWlhZjNmVG1RZURHTFMwNElOYVpy?=
 =?utf-8?B?MG9ub2VscFB1Y3BaMWJpOUNteDhvWk40NjdnM2g2NmtvVEtCQjFGeVd1dS9O?=
 =?utf-8?B?RWNTMVc2b3dZSkxwUVNSUHdLc1JmaXRIZ29zS2RFMDNQdDV5ZTM4bFlTbUov?=
 =?utf-8?B?dWk5R3JlT0tWVkkxS1M3OHB5NjkvUkgvTE5oYllNNStRTEc2TTliMzRtZjRO?=
 =?utf-8?B?S1I1RTl4N1I0bSsxUmxqb0NoWEljTGVMalVnWHk3WTFUTmRsbENDZWh5Q1pN?=
 =?utf-8?B?MDZUbWM4YzhMSWhPb1p1Q0h5Y25xSFJKR29JNEdpYnVyd0w2RHptUDNYVHJv?=
 =?utf-8?B?NlFUQ0Fzbyt6cEtmVDQwdERKM3FuZVlxb3lBV0VhWGdOaGc5amZjOFR4WFRW?=
 =?utf-8?B?eXh0ZzZEUnV1UUhraVM5andRbXh1VnphZXFVMk0rNGpwQ0k5MXNOL1pMbktQ?=
 =?utf-8?B?RU1qQTI2d1RIRWR5NzJGK2VKZFlOOWlwYnk4V0VEak9NUWlPWmRLUDd1b2U1?=
 =?utf-8?B?c09KeVZiZFlwMDBEc08vVkloQ25ka0dvM3BGUWNTQ2FYM29vanpYanN5ZmR5?=
 =?utf-8?B?eW9MbzlqUHQ3eGZGUEJ0WkRxRVVLdEVFbUFIVXM0OU5nY0Y4SWlOQlRGSUpV?=
 =?utf-8?B?U1YzVHl4SHdGcVdvOUJZY1JWeURFYmRTSkd5VHNBOTJoTm9Pa2g2UEZ2T1Iy?=
 =?utf-8?B?aEx0Z1greU9jZ0lBN2pJWCs5RWw3aDRIdkVyWFBQZ3RkMUt1RzdUQ0UzbHFo?=
 =?utf-8?B?WEJWbUFBT2YvT0tTLyt3K1I0djM2SHM1S3dldWNFcUxpSEk3MFM4ejMrckRP?=
 =?utf-8?B?c3ZYNVJzNlArMWFreUhuMHkyUlVyTGlvTS9ROUhpN0ZaYngzOStRdlcvekxR?=
 =?utf-8?B?UEtIMC91TlkzT29MSXIxWUZEWEFQVXMzdXN3QUVGRjBBN0IwRWZRblNDSk03?=
 =?utf-8?B?R1d6TEs0OWdibHFYcTBJOWQzWFI5b0QrWUJwZVJENTBlN0FRUlhlWXphWDNO?=
 =?utf-8?B?WVM4anpKbGZxVWtuREsxYWl0VEdicitzWVJSb1hLSHliSGJvRkJISkR6OHZF?=
 =?utf-8?B?R1B2alM5VzE0VElUZEtIUWtoaTMrb3d5KzczcWpzRnJYSkZBQkREMFhNMGI1?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <241D2FCF6EA0EE449D2384C34F41202A@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2b86bc-696d-431e-71e4-08dde3b64626
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 09:03:35.6369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R44h39R+2toXNKyVKgOrdDawHbXOVkMw8sHKR+K6k4ku1xh7nUEiYaJ6sadS51iHdi/BLC5wiZqFlC0f16r8BNCgLsgv8Bs/8unsloPaCilaay6zEb+in8mq45ggsNtw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6667

SGkgSG9yYXRpdSwNCg0KT24gMjUvMDgvMjUgMTI6MDEgcG0sIEhvcmF0aXUgVnVsdHVyIHdyb3Rl
Og0KPiArCS8qIEFzIHRoZSBsYW44ODE0IGFuZCBsYW44ODQyIGhhcyB0aGUgc2FtZSBJUCBmb3Ig
dGhlIFBUUCBibG9jaywgdGhlDQo+ICsJICogb25seSBkaWZmZXJlbmNlIGlzIHRoZSBudW1iZXIg
b2YgdGhlIEdQSU9zLCB0aGVuIG1ha2Ugc3VyZSB0aGF0IHRoZQ0KPiArCSAqIGxhbjg4NDIgaW5p
dGlhbGl6ZWQgYWxzbyB0aGUgc2hhcmVkIGRhdGEgcG9pbnRlciBhcyB0aGlzIGlzIHVzZWQgaW4N
Cj4gKwkgKiBhbGwgdGhlIFBUUCBmdW5jdGlvbnMgZm9yIGxhbjg4MTQuIFRoZSBsYW44ODQyIGRv
ZXNuJ3QgaGF2ZSBtdWx0aXBsZQ0KPiArCSAqIFBIWXMgaW4gdGhlIHNhbWUgcGFja2FnZS4NCj4g
KwkgKi8NCj4gKwlhZGRyID0gbGFucGh5X3JlYWRfcGFnZV9yZWcocGh5ZGV2LCBMQU44ODE0X1BB
R0VfQ09NTU9OX1JFR1MsDQo+ICsJCQkJICAgIExBTjg4NDJfU1RSQVBfUkVHKTsNCj4gKwlhZGRy
ICY9IExBTjg4NDJfU1RSQVBfUkVHX1BIWUFERFJfTUFTSzsNCj4gKwlpZiAoYWRkciA8IDApDQo+
ICsJCXJldHVybiBhZGRyOw0KPiArDQo+ICsJZGV2bV9waHlfcGFja2FnZV9qb2luKCZwaHlkZXYt
Pm1kaW8uZGV2LCBwaHlkZXYsIGFkZHIsDQo+ICsJCQkgICAgICBzaXplb2Yoc3RydWN0IGxhbjg4
MTRfc2hhcmVkX3ByaXYpKTsNClNob3VsZG4ndCB5b3UgY2hlY2sgdGhlIHJldHVybiB2YWx1ZSBv
ZiBkZXZtX3BoeV9wYWNrYWdlX2pvaW4oKT8NCkFwb2xvZ2llcyDigJQgSSBtaXNzZWQgdG8gY29t
bWVudCBpbiBteSBwcmV2aW91cyByZXZpZXcuDQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBW
DQo+ICsJaWYgKHBoeV9wYWNrYWdlX2luaXRfb25jZShwaHlkZXYpKSB7DQo+ICsJCXJldCA9IGxh
bjg4NDJfcHRwX3Byb2JlX29uY2UocGh5ZGV2KTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCXJldHVy
biByZXQ7DQo+ICsJfQ0KPiArDQo+ICsJbGFuODgxNF9wdHBfaW5pdChwaHlkZXYpOw0KPiArDQo+
ICAgCXJldHVybiAwOw0KPiAgIH0NCg==

