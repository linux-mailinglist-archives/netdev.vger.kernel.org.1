Return-Path: <netdev+bounces-164151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C2FA2CBED
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 19:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09DC61889E28
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083941AE875;
	Fri,  7 Feb 2025 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="L5NGT2KK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477991BBBD3
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738954030; cv=fail; b=tcdjklDaJTnG4yj/NPDAOq/lJcN8G0gJImAKKgNL57IMW04ycmkAVEE4azEtvdEmYPWRjrlxXBudMXTXFqPz+Qlk+HcsyASUENaugUDWWtj/JoLs3TSTezkwBjlS/sL+LSbkpkHVDvAoKNShFrWovzHUZwI5vJC7br1T2z+pTyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738954030; c=relaxed/simple;
	bh=bLS3biJ8NRQhtngkrtZLf9y+lGMDG6gkewxgfhbtktE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qUZep6IjalCme/7+bKKED/ztCBULOTcT+H32RJQa2KstkNp5n+JJ9QyIQIackPNyKHk4votz053gNGPzszaLcXV38Wworq7NZH6By210TqqpqOAozxhkaOLBPxA8ZR3NXo0HYG1i0Jm75X1jyQaw6Ba3v4GmZbwPTKRz+BRuj7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=L5NGT2KK; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXL58nGP8V/VgTW0gaV/xG8ErtJ9s+6OE5wQMT3l0a9UKTZZOHT4nYu/gFSHExpnq0/DVK79pAXs/lAe4hOC3383uj+18viYzFFCtEDKzIEkJP2oDGuVJHt6mjwpEFdkn9tcGl6jV9X1Ebebm4TeCHvcHwM+p7I3F2ZWMR/b0vkraRCj3ifUaHznrv8sMwA6dp/mj0Nb+/ouidQUvjQN23V4YK8v7RrbHWj9MwyFYM9hRvOzPTmmcwVHSLB/azVhC3TXlXJlPN2zNjerg8uyZY/cY/SVWaGI52nHmyDujXkgHOPZdD5kcqakfBDyCmcBBlqZJsfoaVOw+Wcb3jQ6YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLS3biJ8NRQhtngkrtZLf9y+lGMDG6gkewxgfhbtktE=;
 b=Pv3jwWEA+qIuWwwYzHRdo7F7a/BH4Dd+rBNf4mAJPmnIQFeuHqYeF08irX9T4jmoQ/g/S8E1aYGHmS82HnHF9xnPm709r6zHFV3h6I6vVkNA266JcBMpieIsKHJb19ui9xDcFZGUFlCYIUzIGP+2sPMe7ViaHBGd12KNJ4BOpfx4/lxMRPu95QTntOY/crCOh7VPrlXD89eS8wEEv/JWkKU0r4dovO7X4oT/0qGktJOkBgMJ8TOvA85g+/k9cLXr5hlfPcTbdU0dZvGmYQNWAMZwuTaQl6zcZIdcsChBFtBQis/1zvv10hfmvPDPy6fgPhnH+wRaUPLq5FXCphjIaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLS3biJ8NRQhtngkrtZLf9y+lGMDG6gkewxgfhbtktE=;
 b=L5NGT2KK/Wi3EAxtnuw4nMBaoR88iVWlHx/C9uNuNxAe7Ollv1hOfFBfOI3aFFtkAojzVupa9mUlBFvayJz7PMKlJUqk9dCrm3nnYl6cyaJpsKOtAE1uh7vY9U/LbYlotDUuUFPLRW5AbRwVGyKrKsxfA4lZSxq2tDRXCTej6/8qsMAtYOrGvExf7rPp2TTpRnMwYM7NGzkV7l5LrQyq1Etcj1jyKeFCR3DO9lRCUVhZB7usGt4CHDRBzBNKH3p7Hx08K8sT2ff4EUgzoLjuSUwrcU3K6IQHTi0dMgiGnCD46u5Ha5DZtE9Bf5AMWXXdtzuA8570s+ei7e2wpxEXsw==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 CY8PR11MB7339.namprd11.prod.outlook.com (2603:10b6:930:9f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.11; Fri, 7 Feb 2025 18:47:05 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8422.009; Fri, 7 Feb 2025
 18:47:05 +0000
From: <Tristram.Ha@microchip.com>
To: <rmk+kernel@armlinux.org.uk>
CC: <olteanv@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: RE: [PATCH RFC net-next 4/4] net: xpcs: allow 1000BASE-X to work with
 older XPCS IP
Thread-Topic: [PATCH RFC net-next 4/4] net: xpcs: allow 1000BASE-X to work
 with older XPCS IP
Thread-Index: AQHbd9HW3XU0a1PNO0S3mDAG7GyfjrM8MadQ
Date: Fri, 7 Feb 2025 18:47:05 +0000
Message-ID:
 <DM3PR11MB87366E2B612488F8AB6C61EAECF12@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
 <E1tffRT-003Z5u-CY@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tffRT-003Z5u-CY@rmk-PC.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|CY8PR11MB7339:EE_
x-ms-office365-filtering-correlation-id: d59cbd01-4c5e-45bd-4925-08dd47a7d16b
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a29VcmlyQjZUWnlEUmhYcEJWeUZ4QXZBc2k3ZkpqZVBLaVR6dHBXdjd4clF2?=
 =?utf-8?B?Z3BYS2puVW11NGRDbmM1dUpXU0FpTXQwVXBuL09XbWhwYThQRE1jUnZDdm5D?=
 =?utf-8?B?SzVMTlUzekI1bkQwN0cvZ3E3a0R6SmpKMlVzaEFkQTFvRERHZnA0Tmo0eHZM?=
 =?utf-8?B?eVJ3UkRIdnJzTWUzS3BKZ0s4SGdqL0NMbjFhKzI5b3AvNW8rTlhvTklMSEhP?=
 =?utf-8?B?a3pEMzVnbG5kcGhDaWptRGc4RDNycXdtNVovVUtaREdRamdwb1F6OVl3R3Zk?=
 =?utf-8?B?cHZPYTRYUXQ5ZFo2eGZ2TGx2akFwdnRLYjFUQnpvcXpGSnJ5Wm55YjB4MXF5?=
 =?utf-8?B?ZFdxVFQzd0R1d1drcU5jbmd1bGNqTnhIczBHZGI3VUFLSnZTZUwyNHZUNktk?=
 =?utf-8?B?eUZua054N2VPdHNubnJPSEdwanlMeStSQkdYRVBRd0NIVUY2OG9rZzBaYTN6?=
 =?utf-8?B?QVptWk9JTXMwYmdyRStITTlpT0hhYU9tUm5oNGVXLzJMb3JiTlo0cDh3YUph?=
 =?utf-8?B?NngyZEllbE5OcnNRQW5jbmNBN3U4M2Z4STZpNFV2UWpMYUdrU2Z6MVYxYmpD?=
 =?utf-8?B?dHpCSjNOd0V0SHZwRWFSQUtHVG8wamEwdUZxOTZIa0hVb0c3dEROT1JHRTVM?=
 =?utf-8?B?RGo3VEpPak5PMU1VRVpZZnVzLzlpNi9yOFJIMytOQ00yK1hXenBHK3MzSkQz?=
 =?utf-8?B?Q25TNzFjNWhtQVduV2YzdzhMbGZrMTV0NDBkaXVpeFR0NmRBNitZNG1ZNGxi?=
 =?utf-8?B?c1NyQkNKVldRQ0xZZTJzbHEwT0tJdnJlaHdRa2pSV01OUWdFc0dHRC9uN1A0?=
 =?utf-8?B?OUg5OFkvdmZoRWtHMlpYQytSQ3Viamo1OVpqZTMwTnV0RmNWVTZVYkhUY3Zx?=
 =?utf-8?B?K1h5RzJyaGF2aTBrVkVFcU5RcUlEc0FxaHpyYUVuWGpkTHlnVllkVWVkOWUx?=
 =?utf-8?B?VmlvOVBzN3lHNmdqYkZ2K09KN0FNbDA4cWVFUWQ4b2JRWkZwcHdyRGJkY00r?=
 =?utf-8?B?Rzl6NU90RXVWbFFUU3dLYTJqQm12THpzdGdMaWp0T3VjZCtCcWdlL2JrWXYz?=
 =?utf-8?B?aXVJWDJXMS8xalMyQXRiOVV0SU5RNFZYbUVDNi9NOEdYdkFlMTFLMU9vOXpo?=
 =?utf-8?B?NUQ5SFlkYTBXVXV2Z0dOMWpySlR0SWNVWWIvYkZxRzdNVjNwNnF6RU1Nd0ll?=
 =?utf-8?B?bDNrWmdDZjU3anF0amxpK0VZaytHOHVwbDJRNlR2MENyS0FnTVR2M0F0VGxn?=
 =?utf-8?B?VG1iTjVQaSswVVh3MmRaSlpXdDNqOE1uMFRFMFlwRE90K0VLaHkwSDdqOXpU?=
 =?utf-8?B?MTFrQk5BVGVrMlk5YXdaa3pqa1ordkRtWUM1SmlYcHl3UWM2ODBDRkpxNnFY?=
 =?utf-8?B?Z3ZtWVZ2WWRaNXcrc081SU5aMmdkTHlKMnRJOHlQV1dIdU9ZY2VsTzE1cjYy?=
 =?utf-8?B?VTBhcjdxNC8zdUU2MWpQMG8venIyRGtDYzRGajMxbEV2TS9ndDFMVXBXK3BR?=
 =?utf-8?B?MjR6dmFKQXFIcFdpbGdQWm1lU1d5OUkwY2NwL1h3ZDhDdVZqdHFrSHhMRWIw?=
 =?utf-8?B?NDByOGlQVmhLRlJmdnZoMGw0YXp5VzdsNUhMSnB6bXR2STVCMTJvM0FmQUxI?=
 =?utf-8?B?ejUxemZIWGYyNERsRThmclZORFdQdzlPc3FBeXdUSGRuRnA4TEtOalNKbXVJ?=
 =?utf-8?B?RUZjbU9sekQ1TmEwS0J1emxBY0hBaDkxTVlCREEvQ3dMRXd2MmExM1YxWDkx?=
 =?utf-8?B?RjJCSW9EUHZDQlJ6NHpadWE2ZFM0cUgrTzZhUkVZREQ4ckZxalRzOVhkQ0ZB?=
 =?utf-8?B?Q3ZDU1ArVzVna2xuNVluQmk2UlIxWVBhcDlHNnN4TXFwbUJHbThWZk9FeGs0?=
 =?utf-8?B?U1pDV1NGa2ZJTjc3U1Q2aGpzeDExVXRiOUVyblFyQXhWV3c9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VW1vVEpCSTE1aU9UeVJxdktNdG1BRWRlaXNVbXpxQUR4dTV5UmpaY3FDU05m?=
 =?utf-8?B?TU1EK0k2am1jdE5QZytVbDdwTEUwUmRyOUpGRk5OTzc3WnZRaWNpQVBZQlk2?=
 =?utf-8?B?NnlETjlZNS9YWDJBOFMzT2lhN1JHSkRjbmtKWjZCM0RTTnNQYlRaT1dlVmtk?=
 =?utf-8?B?U1MzNlNSVWgxWTFkMXN6bE5BNmd4Zm9XQm5OU3FENHpmODk5K0piN1FFVjhF?=
 =?utf-8?B?L1ZTL21abnVMTkdOREpOTkUrQkhKZ25sWkFrdFZob1g5U1VNOGhJb0xXNG1k?=
 =?utf-8?B?dTVEZFBZcjh4ZDBJWWE3TGUzYmJYZXU1cG81bzlGR1VqTE1JNXV0QU8vTmhB?=
 =?utf-8?B?ZXRnc3kranNDRm84TXBxbzFIUHRrL3dObUNyODRJZUdTRnkxTUxVZjJBQlhh?=
 =?utf-8?B?UXNaZ1p2bzl1aWsvOFg2M25PMFpyeTdMRmRCTzhGMG9SOWE3TVhZNWNGVHE4?=
 =?utf-8?B?ak1lS0pSeUZIOWxsbGhBMEliSEUvQ0x4QmtpaFJwVC8xNDU5dEVRODVTYTll?=
 =?utf-8?B?dVhJYzlCSllQSkRrMXRRcTNQV3lzbW5ub1dlY2taWGM5a2xUWDViSVNLVTNI?=
 =?utf-8?B?UXh3dWt3VlhyS3BMMHJTL1gybGlmTkxLWXFrTUw1aFZNRXJIQnY5M0Zwbmt1?=
 =?utf-8?B?WWlDanpUL1RHb3pZN0trYWZHamVLeHdGbGNjbkIxaXdLRnIzdXpoY1YxOXFy?=
 =?utf-8?B?YmRYM0JiSXhYWWwvaElZY29rOU12WXc1N0NuSjZZaXMwR2dZMmpUakhYcUgy?=
 =?utf-8?B?N3NGdEhZNTNQdS9zWkZ5dzgzakxxSnpOM3UyWjN2SXNQb3FON3pVV3dqT3U3?=
 =?utf-8?B?dk4zenU1eGpzaWJBb2JZYUJoKzdzTjNYUkNZeTFuS2RZMzdpaHc3MFRVc0JE?=
 =?utf-8?B?amJLeXNJODNLa3BKR09SSVVyZ25WTDZDQUN5Um5IUHpuNWVNbjUrcjJqZUNi?=
 =?utf-8?B?VWtlY1dmV1VmTlJEVjNMYTdBRGtQSXpLSmpWamtQQUNjZ1RPSDdoUnFkemt6?=
 =?utf-8?B?ay9wdGJMMDJNdmNwdHhpUTMrVjd0MTZmNCtLRWZBaXlQMGdVcm92d25BaDRw?=
 =?utf-8?B?WkUyRzhuY0NITUdQOWVKY1k2S3BCd2JkL2pmMGJDTVZYQ1IrT2F1dlN2d01D?=
 =?utf-8?B?ZGFLcm4xOUVLTDdrZ1ZFWVg3ZEYvRm5lcU96MUw0ZXNicUt4d0pLRXlZUk1p?=
 =?utf-8?B?U2pxVWdrM1lQTUxrMFVERnpiRjVPM2FFMEJWc2d5Zk9WMmtJY0I3NWlOQ1pB?=
 =?utf-8?B?Tkt5a3ZyTnhXL2RxNld2aTM2dWhsQWJjYzRPZWZFNFFMQVIwTWRUOGZCaWhs?=
 =?utf-8?B?cUlHMU5GZEdHYndyRm9Yc3VaZW52QkVYaTBKR2lhZ3gzdHdYR2Voek8zZG9R?=
 =?utf-8?B?Tzg2RG84MmZOemxWbmdFOUg2bmhEZU9HSXhYTVllZlZndVNXSmpYK2piaEpL?=
 =?utf-8?B?cjl0dHhmeTR3T1JoOUhNS0hKV2ZhdWVDbHE2QjFGQWxXY3kwdDNBQlBYRzNB?=
 =?utf-8?B?M0N1a0wyRnNHTDBWcURsM1lFUlZkSjNYamtJeUZnUWtVSHZ2RVNHRmhDWHZN?=
 =?utf-8?B?VzJZdnN5TThKV3ZPZkU2WnRRczVXV2NmbDlnNGM4VzdSbGFDOE9wb3FCSURh?=
 =?utf-8?B?ZHBOMGhybzAwVFdOOFVrNEV4UXM4VXVFbk9QT25KM0JxT3BPTXp2SU53dStE?=
 =?utf-8?B?L1pjS283dm5vZmZ2clZhZzVhVE8ydEVEZkRkdFdqT09WcFJGbVBPVHpDMkQ2?=
 =?utf-8?B?eldKOTdVeDMvT05YSDNnWThGM0RvQmZLRTNvbEhGdUxvdXV1eW1SUkJheDIx?=
 =?utf-8?B?czcvWTRseHlFYmtSZmxoalV0bU1EMEJCQ2xrWmF3bUlobTAvcWM4TU00Nk1I?=
 =?utf-8?B?dWpnU3ZmRTRJaGVKMjl4aEZpY2ljVVhGMituMy81SVdaNWlWSHN0b3lDSks5?=
 =?utf-8?B?bXl2cDR6SlpndmdaclNTdG5jWDRYQWlnVjNxVzNsSGpqS29DNGI0cy9zQkw1?=
 =?utf-8?B?TFlkTUpmc0ZLOXA5NGpiN3F4bXYvWnFDcHNZenlOVU9YSlFCN0hhZ3Z6bzB4?=
 =?utf-8?B?K2VLQlA5czZZN2pJdlRVaVV5dFlSOFh4WUk2WEtOSEljQ3FrdWg5UElFUnlS?=
 =?utf-8?Q?nkifuC8Z2a52zBvQtHptK7Y5O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59cbd01-4c5e-45bd-4925-08dd47a7d16b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 18:47:05.4497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IgtdiuKBA6SbFfWdqa2YCdGd3biZz+mswxKgCYwmDjNDxgIvuz32MBMc9AgQ7K5eQ0yaOnM5qwIt8RXFZEbhKG8dQIRZmykc1r5HqGtgwyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7339

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSdXNzZWxsIEtpbmcgPHJta0Bh
cm1saW51eC5vcmcudWs+IE9uIEJlaGFsZiBPZiBSdXNzZWxsIEtpbmcgKE9yYWNsZSkNCj4gU2Vu
dDogV2VkbmVzZGF5LCBGZWJydWFyeSA1LCAyMDI1IDU6MjggQU0NCj4gVG86IFRyaXN0cmFtIEhh
IC0gQzI0MjY4IDxUcmlzdHJhbS5IYUBtaWNyb2NoaXAuY29tPg0KPiBDYzogVmxhZGltaXIgT2x0
ZWFuIDxvbHRlYW52QGdtYWlsLmNvbT47IFVOR0xpbnV4RHJpdmVyDQo+IDxVTkdMaW51eERyaXZl
ckBtaWNyb2NoaXAuY29tPjsgV29vanVuZyBIdWggLSBDMjE2OTkNCj4gPFdvb2p1bmcuSHVoQG1p
Y3JvY2hpcC5jb20+OyBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+OyBIZWluZXIgS2FsbHdl
aXQNCj4gPGhrYWxsd2VpdDFAZ21haWwuY29tPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZl
bWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIg
S2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVkaGF0
LmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIFJGQyBuZXQt
bmV4dCA0LzRdIG5ldDogeHBjczogYWxsb3cgMTAwMEJBU0UtWCB0byB3b3JrIHdpdGggb2xkZXIN
Cj4gWFBDUyBJUA0KPiANCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudA0KPiBpcyBzYWZlDQo+
IA0KPiBPbGRlciBYUENTIElQIHJlcXVpcmVzIFNHTUlJX0xJTksgYW5kIFBIWV9TSURFX1NHTUlJ
IHRvIGJlIHNldCB3aGVuDQo+IG9wZXJhdGluZyBpbiAxMDAwQkFTRS1YIG1vZGUgZXZlbiB0aG91
Z2ggdGhlIFhQQ1MgaXMgbm90IGNvbmZpZ3VyZWQgZm9yDQo+IFNHTUlJLiBBbiBleGFtcGxlIG9m
IGEgZGV2aWNlIHdpdGggb2xkZXIgWFBDUyBJUCBpcyBLU1o5NDc3Lg0KPiANCj4gV2UgYWxyZWFk
eSBkb24ndCBjbGVhciB0aGVzZSBiaXRzIGlmIHdlIHN3aXRjaCBmcm9tIFNHTUlJIHRvIDEwMDBC
QVNFLVgNCj4gb24gVFhHQkUgLSB3aGljaCB3b3VsZCByZXN1bHQgaW4gMTAwMEJBU0UtWCB3aXRo
IHRoZSBQSFlfU0lERV9TR01JSSBiaXQNCj4gbGVmdCBzZXQuDQo+IA0KPiBJdCBpcyBjdXJyZW50
bHkgYmVsaWV2ZWQgdG8gYmUgc2FmZSB0byBzZXQgYm90aCBiaXRzIG9uIG5ld2VyIElQDQo+IHdp
dGhvdXQgc2lkZS1lZmZlY3RzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUnVzc2VsbCBLaW5nIChP
cmFjbGUpIDxybWsra2VybmVsQGFybWxpbnV4Lm9yZy51az4NCj4gLS0tDQo+ICBkcml2ZXJzL25l
dC9wY3MvcGNzLXhwY3MuYyB8IDEzICsrKysrKysrKysrLS0NCj4gIGRyaXZlcnMvbmV0L3Bjcy9w
Y3MteHBjcy5oIHwgIDEgKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3Bjcy9wY3MteHBj
cy5jIGIvZHJpdmVycy9uZXQvcGNzL3Bjcy14cGNzLmMNCj4gaW5kZXggMWViYTBjNTgzZjE2Li5k
NTIyZTRhNWExMzggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3Bjcy9wY3MteHBjcy5jDQo+
ICsrKyBiL2RyaXZlcnMvbmV0L3Bjcy9wY3MteHBjcy5jDQo+IEBAIC03NzQsOSArNzc0LDE4IEBA
IHN0YXRpYyBpbnQgeHBjc19jb25maWdfYW5lZ19jMzdfMTAwMGJhc2V4KHN0cnVjdCBkd194cGNz
DQo+ICp4cGNzLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiAgICAg
ICAgIH0NCj4gDQo+IC0gICAgICAgbWFzayA9IERXX1ZSX01JSV9QQ1NfTU9ERV9NQVNLOw0KPiAr
ICAgICAgIC8qIE9sZGVyIFhQQ1MgSVAgcmVxdWlyZXMgUEhZX01PREUgKGJpdCAzKSBhbmQgU0dN
SUlfTElOSyAoYnV0IDQpIHRvDQo+ICsgICAgICAgICogYmUgc2V0IHdoZW4gb3BlcmF0aW5nIGlu
IDEwMDBCQVNFLVggbW9kZS4gU2VlIHBhZ2UgMjMzDQo+ICsgICAgICAgICoNCj4gaHR0cHM6Ly93
dzEubWljcm9jaGlwLmNvbS9kb3dubG9hZHMvYWVtRG9jdW1lbnRzL2RvY3VtZW50cy9PVEgvUHJv
ZHVjdERvDQo+IGN1bWVudHMvRGF0YVNoZWV0cy9LU1o5NDc3Uy1EYXRhLVNoZWV0LURTMDAwMDIz
OTJDLnBkZg0KPiArICAgICAgICAqICI1LjUuOSBTR01JSSBBVVRPLU5FR09USUFUSU9OIENPTlRS
T0wgUkVHSVNURVIiDQo+ICsgICAgICAgICovDQo+ICsgICAgICAgbWFzayA9IERXX1ZSX01JSV9Q
Q1NfTU9ERV9NQVNLIHwgRFdfVlJfTUlJX0FOX0NUUkxfU0dNSUlfTElOSyB8DQo+ICsgICAgICAg
ICAgICAgIERXX1ZSX01JSV9UWF9DT05GSUdfTUFTSzsNCj4gICAgICAgICB2YWwgPSBGSUVMRF9Q
UkVQKERXX1ZSX01JSV9QQ1NfTU9ERV9NQVNLLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAg
RFdfVlJfTUlJX1BDU19NT0RFX0MzN18xMDAwQkFTRVgpOw0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgRFdfVlJfTUlJX1BDU19NT0RFX0MzN18xMDAwQkFTRVgpIHwNCj4gKyAgICAgICAgICAg
ICBGSUVMRF9QUkVQKERXX1ZSX01JSV9UWF9DT05GSUdfTUFTSywNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgIERXX1ZSX01JSV9UWF9DT05GSUdfUEhZX1NJREVfU0dNSUkpIHwNCj4gKyAgICAg
ICAgICAgICBEV19WUl9NSUlfQU5fQ1RSTF9TR01JSV9MSU5LOw0KPiANCj4gICAgICAgICBpZiAo
IXhwY3MtPnBjcy5wb2xsKSB7DQo+ICAgICAgICAgICAgICAgICBtYXNrIHw9IERXX1ZSX01JSV9B
Tl9JTlRSX0VOOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvcGNzL3Bjcy14cGNzLmggYi9k
cml2ZXJzL25ldC9wY3MvcGNzLXhwY3MuaA0KPiBpbmRleCA5NjExN2JkOWUyYjYuLmYwZGRkOTNj
N2EyMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvcGNzL3Bjcy14cGNzLmgNCj4gKysrIGIv
ZHJpdmVycy9uZXQvcGNzL3Bjcy14cGNzLmgNCj4gQEAgLTczLDYgKzczLDcgQEANCj4gDQo+ICAv
KiBWUl9NSUlfQU5fQ1RSTCAqLw0KPiAgI2RlZmluZSBEV19WUl9NSUlfQU5fQ1RSTF84QklUICAg
ICAgICAgICAgICAgICBCSVQoOCkNCj4gKyNkZWZpbmUgRFdfVlJfTUlJX0FOX0NUUkxfU0dNSUlf
TElOSyAgICAgICAgICAgQklUKDQpDQo+ICAjZGVmaW5lIERXX1ZSX01JSV9UWF9DT05GSUdfTUFT
SyAgICAgICAgICAgICAgIEJJVCgzKQ0KPiAgI2RlZmluZSBEV19WUl9NSUlfVFhfQ09ORklHX1BI
WV9TSURFX1NHTUlJICAgICAweDENCj4gICNkZWZpbmUgRFdfVlJfTUlJX1RYX0NPTkZJR19NQUNf
U0lERV9TR01JSSAgICAgMHgwDQo+IC0tDQoNClRlc3RlZC1ieTogVHJpc3RyYW0gSGEgPHRyaXN0
cmFtLmhhQG1pY3JvY2hpcC5jb20+DQoNCg==

