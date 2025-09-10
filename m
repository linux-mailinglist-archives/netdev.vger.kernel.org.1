Return-Path: <netdev+bounces-221875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841FDB52413
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 00:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2A7465825
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 22:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8912230BBB7;
	Wed, 10 Sep 2025 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="62ieI3l4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FA4272807;
	Wed, 10 Sep 2025 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757542208; cv=fail; b=k6ADtL8EmfmARVEuoG1X3NT05zuGCwgdTChdlyImP6PBEfuDdKl8Byo2MJjYFqWT/U+FFhQPU0uCRic81GUkWrKdH8FHU1nJGwVAs2KUMH6ZqRxMae7LGWkhSgi7/MQtZeOqbdcm7gR283WiAJE+NkvZiy4gCdMxO0ykF7FsAKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757542208; c=relaxed/simple;
	bh=OdSyYitl7Idz5xUdzWrx1PYbsg4CpC2BBXTB13zvkSU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uOg3S9Nk+bJmLM2PZXX0P/KRXscq2Jnuj+0/ubufUhIK5ERYjdhqUIlC0xMdJLRLE+FgKE0NpVB2WSaRvwoEvk+II4rBc5C2nypb1qMaiePJpn9LZkKws7V7O7EVslV3S8WbfQgqWo7lFaj+QcPkjfT4K1jJmD2bIXbNJBJbxTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=62ieI3l4; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTVSTGi2hri41reNi5okpKivTi9DxDGN6vSwH4mgxRLvfQrGzkn+cJhUz9nxOlScJf402+NBZoINhda3dTAMwrVgUv4vjxZZYsfB5Pq7InmwcyGbeZ8mdIMcdx7pgQ1/5+wx/Rk/kFLaSkzS4UgRdgF5ZOASoTxHpJOIxfYbZVMFpxGCIXmDkL+aGDbXPy9u5fSR2ytECxdZkoD9ViZymL4YhYn2sK8W7p8jwL3ojJVvYPV3BWOByh0YDQsgsU7Ho38KBYoX9m41TV929axlo7dd8i//WnNq+VRJd+5FpxBVX73COtz3KZy/YBp/VZNpDkBZjkFZEl5vbdBofugnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdSyYitl7Idz5xUdzWrx1PYbsg4CpC2BBXTB13zvkSU=;
 b=ALRirEUci7cpERv+1ba1LA1/z53mSlWPsevBkwpd92ubaRLmXdnd8QSi2YpwtaIHDiAdCs3xJxVBP0yZgtoQ2MfqzJcQA5DR9pHdqz8aNqHugzSLyx5jcwPO8GOqOze2wqmQu6ns0gFnjoTMKSnS+hVJWJ+ejmsaM9zDsKCoxN8K3UsArWYSt3DXBEI44SB9dOUFGB1hGkDUuFsE+7d9Ts+GG40X99POQtrAC9Ephh4dMjgpoSIH18lG4a+XNxW5QznFZFGuxK/gN0waIGrkHtIBaLQaWdCbARBZFO37iVf+My2bMoScDcxeWeDHx59k8RUBqgbsQq7wAwzUKPsGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdSyYitl7Idz5xUdzWrx1PYbsg4CpC2BBXTB13zvkSU=;
 b=62ieI3l48oN9rJHXdhGszMw0YsZ5bGcQkHRgHKnh7zxsyxlxHCidQ/4npKh0ISvviACV3VpNvC1kR0mA1SJcyG81v3Cejn2ejLXghFhTW83CgmF7YL83vrjFu9xguniOvMLJhUYS8Y7U7ty2sp6p8eMaC+rNTs+TfSNmMj39zFjwFyyqIOasuexafKnfDmRM0J4pNonPZoKy3lhXz6eZwnsBsx0KPWl7mzT9TIbRr/e70tMPiET2Ih0Ufa7ymslgiU1c1zclkPC2kxL9TtP5E6wkP/6HbASpzHumh/uOLuUFqSb8jS4eCEHnWDa8s7TX0jTOMsQWAWm0Rl08g3iupA==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 DM3PPF1939049CF.namprd11.prod.outlook.com (2603:10b6:f:fc00::f0b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 22:10:02 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 22:10:02 +0000
From: <Tristram.Ha@microchip.com>
To: <bastien.curutchet@bootlin.com>
CC: <thomas.petazzoni@bootlin.com>, <miquel.raynal@bootlin.com>,
	<Woojung.Huh@microchip.com>, <pascal.eberhard@se.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>
Subject: RE: [PATCH net] net: dsa: microchip: Select SPI_MODE 0 for KSZ8463
Thread-Topic: [PATCH net] net: dsa: microchip: Select SPI_MODE 0 for KSZ8463
Thread-Index: AQHcIlPnFyyQv8DZ50KECFfamsKQ3bSM+YWg
Date: Wed, 10 Sep 2025 22:10:01 +0000
Message-ID:
 <DM3PR11MB87367B6B13B1497C5994884BEC0EA@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250910-fix-omap-spi-v1-1-fd732c42b7be@bootlin.com>
In-Reply-To: <20250910-fix-omap-spi-v1-1-fd732c42b7be@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|DM3PPF1939049CF:EE_
x-ms-office365-filtering-correlation-id: 37fc6873-27b3-41ee-4efd-08ddf0b6ca1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TUg1eGpVMXhVOEc0R1M2ZE9ralQwSmtsQTF3bUNJRUZsZ0VxWkg3aFdPSVdw?=
 =?utf-8?B?bExjS2Z1UmlHTm5odE5xRHhhcUFtQjhhMWNTclI5TEhYYk4rZHdYZ21qY1Bh?=
 =?utf-8?B?dENOMXV2RFdQeUVrckp0YnhUNjk1eENNYjc5OFd2V0JoTWpraG5KbHpsS3Nq?=
 =?utf-8?B?SWNCRlJPSVdSZTNJYXZZNFZzR0ZONVdCQldLL1NQZlUxcXVFb2xSZisxOVdp?=
 =?utf-8?B?R2VrdVhNcEN2Q0hnSVo0LzBXMGdleEVteUhTcmZNYmlJdVBJaEFiK056cTMv?=
 =?utf-8?B?TjVyUVR3WVFTNXNpM2JJOStmdCszYkdQb3lFNzdaV1NoZW1qZ3pBTFVXVURH?=
 =?utf-8?B?bkt3Q0llMmdDWkl1ZGZsblhuNlhPb3pIUTlWRGtaTzFuRTlwd1luSG5JTkxm?=
 =?utf-8?B?V1JoTzhzSmpKemhBWjdWNHRkdHNxM0NuRDFzcTFQSE1KMi9DU3Y3VndtTGdI?=
 =?utf-8?B?Q2wvUFdPQjVrOVpMZGF3bWFMekN4c0dsWVA3cERuR2l2TWpVM3hjODVPR215?=
 =?utf-8?B?MExVeE1uVDFrQm9wQUhUQ2xZSXhUemdqdWVQb0FMNDZCTkVJK1lhSVQwWjJB?=
 =?utf-8?B?d0Rnbmo1aU1TemxFbG9aU1dobENORFI3Ylppb1FxT0VZN3J6WUNMWlhoQ0FD?=
 =?utf-8?B?cHU4ZlFzcGV5ejNhbHhRaEhEWENvNG15WWUvNFlMSUZta1kralpleExXSCtQ?=
 =?utf-8?B?ekVZVGFMUkpQa3QrYjdZQ01iTVFRTjVxU2QxZDJMRVZyVndaK1NScnI4UkVs?=
 =?utf-8?B?bjJlbzJFakJrbTRycGlFdXdXMTZjYTRoNVh1U0Z3ZS9yaWcvL1RSbzYySWwz?=
 =?utf-8?B?UHJSZzFXWkVDS1BDeGFiaVZTR3dHRExhUFZWS0lFaEJwOEZPVkUvVGtUQlJx?=
 =?utf-8?B?dUlVMytEK0dyeFY0dk9saHlYWEpTaXpXNVZSaVVRK3kzVHdRVVF4L1Q0MlN0?=
 =?utf-8?B?TUVyMW1yNGphZDNPVFhHZXhwZURoTzB2YnhtR1Q1cStCdTllQWlCdVFHalA4?=
 =?utf-8?B?R29JWHY2K0cxM2NXRlAzTTYwbFg4QUdNV0FZeDFrVDd3Qm1zeDRCNEVuYkR5?=
 =?utf-8?B?ekRseHcySzNveXFWS2hRdUE1dWdJUWV4WGViVHpkZUpzN1VMa2RucExiS2lZ?=
 =?utf-8?B?VHBwaUZIdzcrdE5Kb2RTM0FhMTMxc1FyaUV1YzVvaHA3Z3h6bnVMMFlZYzFZ?=
 =?utf-8?B?dDRCZHcweVh3SFhxT2dTNU5xRU5tZEx5OGJkVkkvY081SkJlOHRpNU4zdVRl?=
 =?utf-8?B?eUN4TWxENm84OERLWFgrNm5HdlBzQnJGTGZEZ1h5NjArdzEzbTROeVlFQVFY?=
 =?utf-8?B?ZDU2OVZMUXdOUzNzL0FpVEVDeUNUSzdBcmtlemk5NmttMEhXTEo2SHpTdGpZ?=
 =?utf-8?B?eFN0Tk9nTWYrUWhTam5WYUtBUk1DRktwMGdjazNsVnpaNHloM0J5U2FuSHdH?=
 =?utf-8?B?SnhGb2dVZEY5VTEyWGFjTlArSElONTVmZjZ0SU9EaFdYZ0NGVEhBTTczanhD?=
 =?utf-8?B?dkVPUTYvUkJKTGlKYVVpRWlpQTljdE9DZThhaTVPK0M3dG5sMlJLUVNWd1pP?=
 =?utf-8?B?S1lZeHkxaDhFaGZFaFJod2ZwcW9jRmVqUmRLWDhrNVJJeStJUzRUVTRzbEJB?=
 =?utf-8?B?VEd4a2lJdWZFdlhsZU9XR1NXdE1KSFJRNEJCVEZINExrK1RheW5aSzFKUXRI?=
 =?utf-8?B?aVZvNktTbTBWdDU0WXNXNnJRWWFQd3hRSnVUNHJjdGJES1U4UlE5T2NuVFNZ?=
 =?utf-8?B?Z0JRc0k4VTBhM2huYWpnaFF5QXhSWlZzZDJ4Y0hiN2NqYW03bmtEbWZDM3BC?=
 =?utf-8?B?UjBuTFU1K2hxZGFYMzlhMGtieDFMb3Exd051bnpYSEFhY1d2U25aSldnakpS?=
 =?utf-8?B?MlQ1ZXlKcy9PRDRVMHNqb29Qc1N6NzUwRStscVBtTlQ4Uzh1NmdiU2FwT2Vh?=
 =?utf-8?B?WGJrdGcvNTd5TXRsOS9peTVTQXV5alVuM2ZrekM5bXlJUkFxdk9xeUJxVFBv?=
 =?utf-8?Q?oh8BiUXy787MKXGuXlcWS4HIwJdyGA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y0JJbWMyWlA0ZzYxNGtiWHNmVjB2aThaTXR6ckdFOTQwcDRNd2pHQXRQU2lI?=
 =?utf-8?B?aVNWUlpTUENJeS9jajhqNGs1Q0dKMi85bnE4eEdTaFByOHhxVDVib0RuQUZp?=
 =?utf-8?B?TU14R2lENnZtRmlGYWNzNkx6N29MQSs0VmZ4ckhBU2NYRjRJa0xJMGxKbUNr?=
 =?utf-8?B?M0Z5YVZSUHErOTI3WDR3SHVGS05yTHVTc1BRYlowcG1tU1NaNGRxc0VmQjFt?=
 =?utf-8?B?V3Z0SjQ3MFhqK25TQ1ZUbldwamVDRzNUcXVrRmNIQ0c5S0x6QVpWUjZudk5z?=
 =?utf-8?B?TWNyUFVadFdlRGxSUkFKVEZhWnNvWU85WlBFb0NTMHpVZzBLUnl4M0FpbHBE?=
 =?utf-8?B?aU9DZGU4V3d0eXlaZlZZbVJ0aFVyd2hoeG85L0llSDFzSFBTVGpQQ1p6ejBm?=
 =?utf-8?B?Y1ZyT2xVbldwb3dIUVBjZG1UQXFqWmRmNUJ3MnlkeGNjZ2dZL0xmalFzY3pV?=
 =?utf-8?B?eEhmVHA4TDVnR251c2JVVTB2STRJMVhkOVgvTFJQSllsSldnV2xSaGhUQTBu?=
 =?utf-8?B?anJqeTF5aWZFT3ZXOFdUYmgvRWJEZlJZQ2dPWEh3WUFkSVRUMW5QeXV1OU0v?=
 =?utf-8?B?WEJOYUc5VWdDVUNKQjZPQWprSlpkUDlBUEZQYmxjcVlaSUY3QnFhWmhBRWFh?=
 =?utf-8?B?akk2c1JIVXdpbmo5bTd1Yk16K1JFVjMyUEJYVDdGNTlkMEEyU3AycCtBMFpK?=
 =?utf-8?B?Z3lzeEd5WW5IVFZ5R2F2R3ovajlDS1lUY2UzWFV5K0NUS2wvNUJyQjRaenRV?=
 =?utf-8?B?cTlpa3pydDd2OGlCR2ZmdVk4UysvS01yWndaZ0Q3WnZNOFMvZE9SZ3YzTXE0?=
 =?utf-8?B?ekc4bStNeVFlbTBTTU95TUw3ZlNycTJaLzQrcXR1c1FEeXNuTkplWmN4R1g3?=
 =?utf-8?B?aytaWWZNanIrSWxsdW9TZmxQdVR3QnUrMmh1UEhONjZUa0JMeDhUWHE1SFN3?=
 =?utf-8?B?eks2VFEzUmk5c0dCTnBhek53VVlURnl4U0wxdTVCcnpJREhwNVVKc1oyOVpN?=
 =?utf-8?B?ZzhjWE8wTy9JMnU4WlJzekZwWlVvZVh3bDFidSt1cVY5dDhVdDNhZ1Nhakx4?=
 =?utf-8?B?a0xaQVJONHUyUEtLVk9kZzFxMVUzeXFDamRCVG9hSHFNTHNXd09COEVTVU9H?=
 =?utf-8?B?aVVLZUdEL3NXMldRUlFQczNRTFdVR0xMa2gwV202aTZxZXBlaWxRbW9KdElY?=
 =?utf-8?B?OXQvN3crUDlYVG81ZWdVaVlxQUZjNnA3UUJRYWFGemgrdno4eEN5d25VZW95?=
 =?utf-8?B?VUZSeUJ2T3ZleWpzOGNaRzhWUFpDci82NitKVkwvSDJVWW9Ua1FWSE9zQlMy?=
 =?utf-8?B?NzI4MHBtOHZISXcvSWhWL201TmhvSVpKajZ6aUpnMHYvL1RrcHNGY3R6MEI4?=
 =?utf-8?B?c05OT1lQblhmR1RScHFjcngvOWdBdmxBUkVodDdRb3Q4RkhBUzRGZmQyWmJ0?=
 =?utf-8?B?UWtma3p0bENFQm0reWVjRmpzcWVnN0dEelFtc0VnL3IrSnpqd0FaU21hUjZE?=
 =?utf-8?B?VGFsdnN6c0JpcmlYTktBODJGMFVTVzYyUTNvUk1TZDdCVzdBeVlSZjY1S3Bn?=
 =?utf-8?B?YnhBOWRVSWpiaW9VM1pSUVlhc25xWi9MZFlBZWZ0emJDMlpiUFpGYVZKRThk?=
 =?utf-8?B?QS9aS1lYdWhKRFp5MWdLOHBZdFFYS0dLSW9US0svemx3bUJmcE9NTlpVSklq?=
 =?utf-8?B?YzZqVzJzcjZNa2FCNUNzWFgycG81RjFvYUh4bjFhcUUya1ptYndtQ1BTYXla?=
 =?utf-8?B?dkxGU0Z5TnZ4OEpxUXZNQXNSZEEyd3M5a1N4WGN5WW1zUnZxK0xDeENwMDNw?=
 =?utf-8?B?WHJ3YnN0K3E3TTBVOWdFOER6TjhhUEcyQmExc2R1dmp1NTREQkZNMEFpVGZK?=
 =?utf-8?B?UmFzWjRia0FuNGgwVmtwQ1kxZzVzSUh5aSsraElCM2RoSzdxbWdjdjJTY1pa?=
 =?utf-8?B?RnNVYjFObXhqbVAxRTVjQlp4Vkx4dzBGWFBieXFsVlZjQ1hOeEZUaW5ncTA4?=
 =?utf-8?B?VWdGYzVwVEFxWE5ZdDBVb1hxa3I0alZRaVQ4M2FrdTY4NW44WXFXaTFwdFh2?=
 =?utf-8?B?TGNjQ3FXS0VSWWpETDRqUGYyTXg3ekRzVHRYOXZvdzczeE5XZjlRWlVxbjhw?=
 =?utf-8?Q?6GD3Qh7viLRTbT/M58hr+l3xJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fc6873-27b3-41ee-4efd-08ddf0b6ca1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 22:10:01.8186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cl0cyBhhNJJyd8oAnBymgXS+aPl6/KTJ6uzJ03irezvA3VA8I6yrTcy3TfspCQaE64MtkJiXFkMSykijYIQFgRTIqvEi3a0TDglo4jpofKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1939049CF

PiBLU1o4NDYzIGV4cGVjdHMgdGhlIFNQSSBjbG9jayB0byBiZSBsb3cgb24gaWRsZSBhbmQgc2Ft
cGxlcyBkYXRhIG9uDQo+IHJpc2luZyBlZGdlcy4gVGhpcyBmaXRzIFNQSSBtb2RlIDAgKENQT0wg
PSAwIC8gQ1BIQSA9IDApIGJ1dCB0aGUgU1BJDQo+IG1vZGUgaXMgc2V0IHRvIDMgZm9yIGFsbCB0
aGUgc3dpdGNoZXMgc3VwcG9ydGVkIGJ5IHRoZSBkcml2ZXIuIFRoaXMNCj4gY2FuIGxlYWQgdG8g
aW52YWxpZCByZWFkL3dyaXRlIG9uIHRoZSBTUEkgYnVzLg0KPiANCj4gU2V0IFNQSSBtb2RlIHRv
IDAgZm9yIHRoZSBLU1o4NDYzLg0KPiBMZWF2ZSBTUEkgbW9kZSAzIGFzIGRlZmF1bHQgZm9yIHRo
ZSBvdGhlciBzd2l0Y2hlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJhc3RpZW4gQ3VydXRjaGV0
IChTY2huZWlkZXIgRWxlY3RyaWMpDQo+IDxiYXN0aWVuLmN1cnV0Y2hldEBib290bGluLmNvbT4N
Cj4gRml4ZXM6IDg0YzQ3YmZjNWIzYiAoIm5ldDogZHNhOiBtaWNyb2NoaXA6IEFkZCBLU1o4NDYz
IHN3aXRjaCBzdXBwb3J0IHRvIEtTWiBEU0ENCj4gZHJpdmVyIikNCj4gLS0tDQo+ICBkcml2ZXJz
L25ldC9kc2EvbWljcm9jaGlwL2tzel9zcGkuYyB8IDcgKysrKystLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzel9zcGkuYw0KPiBiL2RyaXZlcnMvbmV0L2RzYS9t
aWNyb2NoaXAva3N6X3NwaS5jDQo+IGluZGV4DQo+IGQ4MDAxNzM0YjA1NzQxNDQ2ZmE3OGExZTg4
YzJmODJlODk0ODM1Y2UuLmRjYzBkYmRkZjdiOWQ3MGZiZmIzMWQ0YjI2MGI4MA0KPiBjYTc4YTY1
OTc1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzel9zcGkuYw0K
PiArKysgYi9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzel9zcGkuYw0KPiBAQCAtMTM5LDYg
KzEzOSw3IEBAIHN0YXRpYyBpbnQga3N6X3NwaV9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3Bp
KQ0KPiAgICAgICAgIGNvbnN0IHN0cnVjdCByZWdtYXBfY29uZmlnICpyZWdtYXBfY29uZmlnOw0K
PiAgICAgICAgIGNvbnN0IHN0cnVjdCBrc3pfY2hpcF9kYXRhICpjaGlwOw0KPiAgICAgICAgIHN0
cnVjdCBkZXZpY2UgKmRkZXYgPSAmc3BpLT5kZXY7DQo+ICsgICAgICAgdTMyIHNwaV9tb2RlID0g
U1BJX01PREVfMzsNCj4gICAgICAgICBzdHJ1Y3QgcmVnbWFwX2NvbmZpZyByYzsNCj4gICAgICAg
ICBzdHJ1Y3Qga3N6X2RldmljZSAqZGV2Ow0KPiAgICAgICAgIGludCBpLCByZXQgPSAwOw0KPiBA
QCAtMTU1LDggKzE1NiwxMCBAQCBzdGF0aWMgaW50IGtzel9zcGlfcHJvYmUoc3RydWN0IHNwaV9k
ZXZpY2UgKnNwaSkNCj4gICAgICAgICBkZXYtPmNoaXBfaWQgPSBjaGlwLT5jaGlwX2lkOw0KPiAg
ICAgICAgIGlmIChjaGlwLT5jaGlwX2lkID09IEtTWjg4WDNfQ0hJUF9JRCkNCj4gICAgICAgICAg
ICAgICAgIHJlZ21hcF9jb25maWcgPSBrc3o4ODYzX3JlZ21hcF9jb25maWc7DQo+IC0gICAgICAg
ZWxzZSBpZiAoY2hpcC0+Y2hpcF9pZCA9PSBLU1o4NDYzX0NISVBfSUQpDQo+ICsgICAgICAgZWxz
ZSBpZiAoY2hpcC0+Y2hpcF9pZCA9PSBLU1o4NDYzX0NISVBfSUQpIHsNCj4gICAgICAgICAgICAg
ICAgIHJlZ21hcF9jb25maWcgPSBrc3o4NDYzX3JlZ21hcF9jb25maWc7DQo+ICsgICAgICAgICAg
ICAgICBzcGlfbW9kZSA9IFNQSV9NT0RFXzA7DQo+ICsgICAgICAgfQ0KPiAgICAgICAgIGVsc2Ug
aWYgKGNoaXAtPmNoaXBfaWQgPT0gS1NaODc5NV9DSElQX0lEIHx8DQo+ICAgICAgICAgICAgICAg
ICAgY2hpcC0+Y2hpcF9pZCA9PSBLU1o4Nzk0X0NISVBfSUQgfHwNCj4gICAgICAgICAgICAgICAg
ICBjaGlwLT5jaGlwX2lkID09IEtTWjg3NjVfQ0hJUF9JRCkNCj4gQEAgLTE4NSw3ICsxODgsNyBA
QCBzdGF0aWMgaW50IGtzel9zcGlfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4gICAg
ICAgICAgICAgICAgIGRldi0+cGRhdGEgPSBzcGktPmRldi5wbGF0Zm9ybV9kYXRhOw0KPiANCj4g
ICAgICAgICAvKiBzZXR1cCBzcGkgKi8NCj4gLSAgICAgICBzcGktPm1vZGUgPSBTUElfTU9ERV8z
Ow0KPiArICAgICAgIHNwaS0+bW9kZSA9IHNwaV9tb2RlOw0KPiAgICAgICAgIHJldCA9IHNwaV9z
ZXR1cChzcGkpOw0KPiAgICAgICAgIGlmIChyZXQpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4g
cmV0Ow0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiBjNjVlMmFlZTg5NzFlYjlkNGJjMmI4ZWRj
M2EzYTYyZGM5OGYwNDEwDQo+IGNoYW5nZS1pZDogMjAyNTA5MTAtZml4LW9tYXAtc3BpLWQ3YzY0
ZjI0MTZkZg0KDQpBY3R1YWxseSBpdCBpcyBiZXN0IHRvIGNvbXBsZXRlbHkgcmVtb3ZlIHRoZSBj
b2RlLiAgVGhlIFNQSSBtb2RlIHNob3VsZA0KYmUgZGljdGF0ZWQgYnkgc3BpLWNwb2wgYW5kIHNw
aS1jcGhhIHNldHRpbmdzIGluIHRoZSBkZXZpY2UgdHJlZS4gIEkgZG8NCm5vdCBrbm93IHdoeSB0
aGF0IGNvZGUgd2FzIHRoZXJlIGZyb20gdGhlIGJlZ2lubmluZy4NCg0KQWxsIEtTWiBzd2l0Y2hl
cyBjYW4gdXNlIFNQSSBtb2RlIDAgYW5kIDMsIGFuZCAzIGlzIHJlY29tbWVuZGVkIGZvciBoaWdo
DQpTUEkgZnJlcXVlbmN5LiAgU29tZXRpbWVzIGEgYnVnL3F1aXJrIGluIHRoZSBTUEkgYnVzIGRy
aXZlciBwcmV2ZW50cyB0aGUNCnZlcnkgZmlyc3QgU1BJIHRyYW5zZmVyIHRvIGJlIHN1Y2Nlc3Nm
dWwgaW4gbW9kZSAzIGJlY2F1c2Ugb2YgYSBtaXNzZWQNCnJpc2luZyBlZGdlIGNsb2NrIHNpZ25h
bCwgc28gaXQgaXMgZm9yY2VkIHRvIHVzZSBtb2RlIDAuICAoVGhlIEF0bWVsIFNQSQ0KYnVzIGRy
aXZlciBoYXMgdGhpcyBpc3N1ZSBpbiBzb21lIG9sZCBrZXJuZWwgdmVyc2lvbnMuKQ0KDQpBcyBm
b3IgS1NaODQ2MyBJIGhhdmUgYWx3YXlzIHVzZWQgbW9kZSAzIGFuZCBkbyBub3Qga25vdyBvZiBh
bnkgaXNzdWUgb2YNCnVzaW5nIHRoYXQgbW9kZS4NCg0K

