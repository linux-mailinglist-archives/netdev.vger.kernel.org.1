Return-Path: <netdev+bounces-188542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CA9AAD44C
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 05:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF239807A2
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 03:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB061CAA7B;
	Wed,  7 May 2025 03:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Pir+BSAE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E521A0BF1;
	Wed,  7 May 2025 03:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746590393; cv=fail; b=U3mPzXnmFCyWfrimf5kSRfJ8zIuxI1iySDQXuTIvmAN7GmsqRRSzQ/q2Mz0JKEheY6cwWPac3IzdC0uufuYmSATxzHQ7WkuJu5gCAW0zA8pGD3IM99CVjuZOfPGLtosp9UHVwVqT8Yh6Amwqj0TbbNi1Fgjth17piag8K6R1+Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746590393; c=relaxed/simple;
	bh=+yJbuMtfK/VKHgNiYtrSrttdiJjD691WRwqHMF9t+M4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EhDtkW3Msxuvt2soGl2HqPgNN8K+9iOl0z6JKpmYbCybvBRLX3lb2pGxEoFF1Ycj7ATrYqAmef6FnmvZ7GeWdnL9O1TGvlITgJZ3VZL15NNFAf0b2Jf7VOLBQp1nAevM8lvUEQXiOLrktyCnDBUhFS3QQ2KYlHROGOMhENv2p2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Pir+BSAE; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnAfzH8ym8XUOsUZjn+6+kpnMZuJHw7GSlKj1MtWvQGQofP1zCdsDlh5Q5/Gtm9BLTxGncbJ3Qry1vdzOPNBbEmB7gE2uRgyDvLn3lbw9bCem+UCKK5/UeXRpJSMQajY3nWu5tFhxT9crSQWM+G3GtJg8gFpi2HOR54RyujKVcmuZi/YiA8sAXpMLy7usw6z7UE5vO7KwMuff3E3v+1uaAAGANq0DrYWSr2iVtkO8q3jg2288QhMs2h62ZtS1nhTsKDCxcuT5wmqbDMI8AN9cuKpD3dKml2dMH0KUrIPNuUw532zh9pUXyO15Gr88TNzuof6HKlOU/xaYauwvHN1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yJbuMtfK/VKHgNiYtrSrttdiJjD691WRwqHMF9t+M4=;
 b=wBaDSEIgpEAGysEneTb8Rlgwnyfncq1byMesJrVPXPbxFpQM0ogi5Y96xWtoF5D8Da6RbpIjgHD15eaUBGurBBQFbk3OR181+80l2dpP9BocC3ht1FrWyjgHSlvtqMzDbc8l6DhJZwZy49DqdfFTr5qPZdHswzAimCURzLCX1KOCFiZqPL+UJKhwY08mv0L3XCO5/OHUsOeDyOYtn42817x4GmAchuLox6aDuj99X5YYN2x+rvM3nzifTWTdl5bpyoFg9TFWhZ7eQUCKKLN0fkPwyiMHjdAh3YlOHwZx3NAAyoq81SINBKgKxySOW/D2G0bEDzQDMVxlY9MYsxrBKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yJbuMtfK/VKHgNiYtrSrttdiJjD691WRwqHMF9t+M4=;
 b=Pir+BSAENNlOoG4BDC8OyMUocojgOXLPs28PehJVSQRTA9LwevxnlKpNfWCvG6MLQF2yhbVE7V6IkPLhGvCR+qJDmkR7VeASDpK6A5Brl97eBNjGAwQzsBOJmweoB+jMErbrgV9rWWKANSvipT5NPBZKcn9exi2k6Wfroe6gavKsgkVrp2/WJKM238gbMT1jDwcaBuSySlFTL/nJYRFp8gvU4zPjBmPWO2xid9wdRwivn4QfU47ZSN3HQGjWtBkt5WW8eAAsfhEU3eY35tPvEqBd1B9+gKVrA3AsVhb6jZvpTXp7PgHr09OPckd/K9Qoz9tbFin4UTCEDBd2xZhE8A==
Received: from DM6PR11MB3209.namprd11.prod.outlook.com (2603:10b6:5:55::29) by
 DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 03:59:44 +0000
Received: from DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924]) by DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924%3]) with mapi id 15.20.8699.012; Wed, 7 May 2025
 03:59:44 +0000
From: <Thangaraj.S@microchip.com>
To: <andrew+netdev@lunn.ch>, <rmk+kernel@armlinux.org.uk>,
	<davem@davemloft.net>, <Rengarajan.S@microchip.com>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <kuba@kernel.org>
CC: <phil@raspberrypi.org>, <kernel@pengutronix.de>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v8 5/7] net: usb: lan78xx: Extract PHY interrupt
 acknowledgment to helper
Thread-Topic: [PATCH net-next v8 5/7] net: usb: lan78xx: Extract PHY interrupt
 acknowledgment to helper
Thread-Index: AQHbvZnZlRVpVHTkO0GGUydRZS8ViLPGjKyA
Date: Wed, 7 May 2025 03:59:44 +0000
Message-ID: <a00f3b209852878d37d2a42ca4cfac42701b6e6f.camel@microchip.com>
References: <20250505084341.824165-1-o.rempel@pengutronix.de>
	 <20250505084341.824165-6-o.rempel@pengutronix.de>
In-Reply-To: <20250505084341.824165-6-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3209:EE_|DS4PPF0BAC23327:EE_
x-ms-office365-filtering-correlation-id: bdf03e18-6771-4d3c-80d0-08dd8d1b9a41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rk9zS3QvSks2OS9iMDQwWURLbjI1UHVUSGM2UERYQnUzRGhaUVliQ2hya01V?=
 =?utf-8?B?RmRoRkkvU0ZLZW10cXNvaVZWZ3Z3R1I3U2VqK2lJMkpoVHhqNm9ucmg4Q3Ev?=
 =?utf-8?B?R2sySFJUVWpSd3pMT3MzQjRKN1Y3Slh2WHdtbEcyRVNqcTBMdloxQXgvR2Jp?=
 =?utf-8?B?akk1NUxML3Y2bm9ENXpuRFZSbHdsbTd6WjIzakhuZHZvVkpGaTNmUklKa1Br?=
 =?utf-8?B?MkZ0Q205ZU5hOGMvZ1hBTVdOOXlHdTlNa2xkVkJBL3VGNFg5cHM2eFhqcDJ5?=
 =?utf-8?B?N1lLaXFIclAwd3VPZ3JSRlVOeC92TWpFMHZGTlNrV201T2JWRHRjYTBpeUdO?=
 =?utf-8?B?dXFlU1M0aHJWWmVMUGZ4RDZ4bVJnU0kzV1lQanZiWkplc01mMGlUeDhiZllp?=
 =?utf-8?B?bzkzSURuTEhRamlITDNUTXBLK0kxdFdXL1kyU2J2a1RodW1kNkQ2T0pocXc0?=
 =?utf-8?B?UExDa1dlV1NpS2Rvb25ad2ZzV0MrbGRuL1A0NWtEdWtrbFEyODR2UVdpYzVw?=
 =?utf-8?B?eHpvaW1rQWZBaCtVZ0lnRDE3QWt6ajErWlRtV0dRY0ZQR2lYY0JLK2wrK0xa?=
 =?utf-8?B?WEIvNm9NR1piK01SRnZPcGdJQ1M0eStvUlZQTytuN0FkcHZVcmh6enovd3pT?=
 =?utf-8?B?TG1ta25ZaGpYM3BqRXNGaFJqanY3bll3NGdjanJOZjZudHVjTmRTZ0l3TzNs?=
 =?utf-8?B?RTVKVGxLUHNxUnVlUXRLamI2azRkbVVveGdpQ3J5V0F6YTdUcW81MnhsNXM1?=
 =?utf-8?B?SXVmNmdOUHUzdGppclZrTUI2bnRZVTJrNUFZdGFrV3hvbWIxVk5kZFJUZFp5?=
 =?utf-8?B?aGZMMW9mT3ZXdm8xbVluZ212YUpjc2lPVWdmRi9qRDhSZGJ1VjZJcE0yWG5a?=
 =?utf-8?B?QmtqVEEyako1aFFIOTd6eVFLeGtldXBNTC93TGNlN2V1bHlXdXJ3SGZnQ2Rs?=
 =?utf-8?B?ZUpKckVXaVViUnVrSmprMFVIYmdwMHo5eER2cTFxU2NCempxZmgrbEh4SHRQ?=
 =?utf-8?B?L2wvT0FWYmg3MzZvWHZTVEtBbkJ2Tm9PSWpqY1dubzhseFQ4UWFBWHpZR3p6?=
 =?utf-8?B?ZGdMVHZIWFhXY2NGNVF6TTVYc2U1aHR6TkZPR2Fjd3RBQzkzVHdsREUrOWhK?=
 =?utf-8?B?Q21jOUc3YXJkdDNLb0JCQTE0WUNtVnlSTUIvQmQ0Vk9BcFRLeXIwRWpxc2lH?=
 =?utf-8?B?YjIxdXllNDZ5eTB1dkMrNUhBTVpKampSVHdyclhXblBPVXJ2blNUdmtsOXUv?=
 =?utf-8?B?Z3JCYVI3dWFPYThNQVU1MjczNSs1b3JwMFpHNmp3UDF3c052N1huTzFQK0pl?=
 =?utf-8?B?ZzhoWDQvS3FuZUtDa1JmU3RMM1VoWWJHZzcwbHQwYjUvM2xNRUhKOGlrWm5Y?=
 =?utf-8?B?c0IwaWVyWHNlZ0xZWEF4aUcwSm5ZSnZHMzJGME5WSkF1VmlQUGYzN21OMmt3?=
 =?utf-8?B?Ym02ZFRQRVgyUERmakJSVTA1NUtSR0VMVUY0MWZhTUFidlQ5YUtIdEJTaVZs?=
 =?utf-8?B?bkh4SWN3R2VwRk1uSEpranNpZ2FMbThpV0ErSm0xd0Q1MCtqZW9Gdkg2a09G?=
 =?utf-8?B?d2xuMmF4aG1qaUpGMWVkeDBnbmF1dDFDR0svL1piZ1pNNllzWllRWXBoUDV2?=
 =?utf-8?B?WUg1QzNWOFdiM0swTWMwWWhYeGNFaWp3S0dMem5iYTRKU296QXI0WlRpczVW?=
 =?utf-8?B?UXhQcjRxSWJCSTlPaTFVVmczYVNERXoxYU10SWJHQWcrMXhVN1RJRUdqWVA2?=
 =?utf-8?B?c3VLSEMraVdUTVUvTWxxaTZCR0xNZGxVL1l1SGZZcUQ5WEpYcEo3ejc1MzJ0?=
 =?utf-8?B?MURJSjVRTFpwbFFCUTV2c3MrUmo1ckhnaEVuaHpYUGYxUjV2NU9WcVFIaU5i?=
 =?utf-8?B?eXRhLzNCamVMZ055cldpYXpxODBZZjBPeUw4dnhQSkpnZ092cXdtTWlJOW5k?=
 =?utf-8?B?NXFuZ1ByazN0akcvdFhvY0lrQlNFN0luUG51UXhURjZmN01OVktzV0xlTVll?=
 =?utf-8?Q?mLy31vGvzo2pMAXYBV+ftZ5nRQwj8o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3209.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cVVvWW5yR1dQaEFYMFd6K0xJOXdlTmUra1VRWUs5SU0yb3FZOFV5cExpYkhK?=
 =?utf-8?B?dDR2Skl2TXppYUlwQmhuSk1VR3llclk1VG53VDRWbUVLcmRwb2NUMS9zU2Zn?=
 =?utf-8?B?TEw5QXhGVTBNbEFuUkxVbEhxdDBIU3RWVVpKeGdrc2pEUTdabUFPbEFQQk9j?=
 =?utf-8?B?VEl1dElrV3ZZVHhvWllPMWc3OFI5Ny8zNDNtOEFoMEROaGJERDAybzhpaUlX?=
 =?utf-8?B?VGdEUk1kRzJ2M3VYbmpEZXlpWkJaNitLSERVbUlpemwxMkdySWtmcjBxV1hU?=
 =?utf-8?B?aUl0WXBDZEcvaVlMWVd4R0FITWtpcS9BV1VQU2xtS2hzVVJJL21JOGVTMDJv?=
 =?utf-8?B?RWdVa2krRExjWVliMFNUOFI3L0FodC9raWx4SmRxdEcxS250Q1ZzU3RIMFB2?=
 =?utf-8?B?eDZISWdqOEt0dVV6NVpuenVzMUttRDZXSmRRNWZQUnZLUHJlQnhYcENSNXY5?=
 =?utf-8?B?Z1FKb3NrOHN6eEFpdml1VHRJbjM4QVlKUEpNUlZmZDZOdkJPNVZOMy9tSm1N?=
 =?utf-8?B?VlM4bERLYjhmMXozbFljd2RqS3k3c1VCcjdXL0pDZWdvcW45dXo1L0RSb25K?=
 =?utf-8?B?WGdIZ0hLcVRCNHpQQTAvRG9Mb0xkVDZoTTRNYmJzVWRmRFdmNWx5YVJ3WG1T?=
 =?utf-8?B?WDhBZENvU2d2anRqR3pJZ1Q3Qlp3S01Fc3lqeXdHeXMvODl0MnNLUnp5Uzkv?=
 =?utf-8?B?Q3VLQTkwTmdsaHdaMjVnOHJFV2E4VkV1SlNZOC9YQ21PMTVtYXBNZUNWVlFY?=
 =?utf-8?B?Mlpob1puSmpTaEhBaFJhSjRFZm9OUVYyR3ZzcGFhbE13a0dGZTBnVzhlYlRE?=
 =?utf-8?B?WGVTNktEN2FnelBhdzlXMVBPOHNSbG4rSHk5dCtCc2M2MlYwRGhnZUdsL0Jn?=
 =?utf-8?B?NHpTdU01N0dERjZ6a1FsUW9hZXVVQlhvczRaQ3FCQURwc3dJMmprUWRDck0z?=
 =?utf-8?B?QTc3TEh3V2I0OTd4UjFONldhWkozcjRXM0dZUU9aWlJEZEZLcGhWRGlYbWRQ?=
 =?utf-8?B?WTF5Q1NncFlrRlVza2xZQ1JMS3gxUGJrTytaNE50K3c0S2dnK2hnOXZNTlZq?=
 =?utf-8?B?aW5KcHBweE1DOGhDL0NuNVdZZjNZNWFDdnJYdWlXeEk4YVhpTFRXVWduZXpn?=
 =?utf-8?B?V0E3bUJnbXhaVXZNY0pSMHByMHMwMklrUFFJbHlXUTFZc3BobE9TU3ZZRFU2?=
 =?utf-8?B?a0xOUWk1N2JKOHBOWmw2andRL0pJbE9nK2xGTERzM1VzUHpHbXAxdDY2OUVW?=
 =?utf-8?B?cXlzVjNBSlpUTlQrelhNenU1UE50c2hHdHVFeUNHMlN4RjJTKzl5NTBNYmdx?=
 =?utf-8?B?cUtGWmF4Q3MvUDd3VzF6ZnFIWjRleDdOUzZNYjVnWTdqVVVvTC9BNlJHcmpZ?=
 =?utf-8?B?V0lDMVdNYXZNNm04aHpkVy9mQmVBcVZPNm5MU09RV1grdGtvbXI3alJIZFZE?=
 =?utf-8?B?OVllMkdNTmlWSjkrYWdUT3VwZUlvT1NYL1B1QUVuRWhtMHU2NklUdFc0eVUv?=
 =?utf-8?B?NU14L2hQMFNPKzcvQm9ta0lHTmtNeC93M3VLUWRlNDF1N3V6T20xa21kdjZ0?=
 =?utf-8?B?aE81YW5Gb29NUnNKdTVkMlVEaWFVaEQrclpEckIreWNaamZQVjBOSnhaQVZH?=
 =?utf-8?B?UW5pT3A3MW9yd0MrK0ZKQ0JRbFIvUnlFeGI5SUViaFlYemVDRXQ1U1VEWWJ3?=
 =?utf-8?B?YmE3YSt5dEdscHNRdVI4SGdMbTA4cUU5ZUdycm5oSHJFRU9xcWpzMGh1WURB?=
 =?utf-8?B?Ym9IL0FCRXhiZkliSXZZeThtcGZ4MHNmcFR6U0Y4bzlFWjJ3Z0xCNzJibHpr?=
 =?utf-8?B?K3VCRzNYSXFYYjdsSDgzcjgrMjJ3bEtGTFc0eS9jUzYyQzNlVTllSjJodEFZ?=
 =?utf-8?B?SEQza1JINEVQTG9OSTl5SGpxSExubURldnlYWUsrdFVNbG9RZkxxa1FUYUNI?=
 =?utf-8?B?QTFjS3hkUkdFaDZaa0NsV2wrZ3Fib0FwTldNK21OUHBwS1ZQamx6VVFUWjVF?=
 =?utf-8?B?T2xEalgyYUpyYmlGWWYvMFZHb0F4UUNxK2JMeC9RbWJncnRvb2ZkWjVMZkx4?=
 =?utf-8?B?TnZDTUErQkFtblQrcUFIYjhvNWRzR3dYTGkzdWR4THJOSXNoMDdiQU1ZWGhV?=
 =?utf-8?B?bjkweHNnZXpSd2JCbWIwcmFGWFZqeDgvOXhlNnpUMk93eXg3ekpYWU85eGxR?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D03EFB46788CBD4F9F66C5DB42288751@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3209.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf03e18-6771-4d3c-80d0-08dd8d1b9a41
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 03:59:44.7651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WF94HKEMyIQxaAr60vBYG1Iz8lKdY2uk0xe42+zeWVq8svjCnIoQBMI6CB1eLCVmrSJ2TMk9WvZ+UWqKligDFh0uNleYODEn4M+BWjc9lBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0BAC23327

T24gTW9uLCAyMDI1LTA1LTA1IGF0IDEwOjQzICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBNb3ZlIHRoZSBQ
SFkgaW50ZXJydXB0IGFja25vd2xlZGdtZW50IGxvZ2ljIGZyb20gbGFuNzh4eF9saW5rX3Jlc2V0
KCkNCj4gdG8gYSBuZXcgaGVscGVyIGZ1bmN0aW9uIGxhbjc4eHhfcGh5X2ludF9hY2soKS4gVGhp
cyBzaW1wbGlmaWVzIHRoZQ0KPiBjb2RlIGFuZCBwcmVwYXJlcyBmb3IgcmV1c2luZyB0aGUgYWNr
bm93bGVkZ21lbnQgbG9naWMgaW5kZXBlbmRlbnRseQ0KPiBmcm9tIHRoZSBmdWxsIGxpbmsgcmVz
ZXQgcHJvY2Vzcywgc3VjaCBhcyB3aGVuIHVzaW5nIHBoeWxpbmsuDQo+IA0KPiBObyBmdW5jdGlv
bmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9sZWtzaWogUmVtcGVs
IDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT4NCj4gDQpSZXZpZXdlZC1ieTogVGhhbmdhcmFqIFNh
bXluYXRoYW4gPHRoYW5nYXJhai5zQG1pY3JvY2hpcC5jb20+DQo=

