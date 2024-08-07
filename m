Return-Path: <netdev+bounces-116308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFEB949E7B
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 05:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35DD1C22BC1
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 03:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8D51991B6;
	Wed,  7 Aug 2024 03:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0cI2Ws1u"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26B419007F;
	Wed,  7 Aug 2024 03:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723002090; cv=fail; b=Gbj/SbPOkRdb3yZseqAZOlZ3kdfFOdKj//bAtBhyfODwkHUTQL6gNnAz1QIBG5rkOTOnaC7IgSBdZ7PDLohVjBfGhhg33vwywERCIppjj+Ijk9b6qOwwHsKs9yitjJ0risRctlor5sxpR1x4Gwco+lR5GHJZClK5bGnX8s8utws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723002090; c=relaxed/simple;
	bh=igx0DvlPqotvjp4kfQfez3n+hFXNeGFlWk8cOxXnPj0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n0KYgy4/mK1bVFz9koBLYYUwAeTBZGql93We4l0xTu7PuBg1Gf5RTB6BGxkPHwK114NiJbxkl2s+InJ0TtLtS1bLyGa3xPQ2NPSBKWIlI9EDObCJ3caLhXWCIQofJLPBqnQgP/C7uxzS+CWi/jpiU5JNuNSJ1C5pOyt6OwadIPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0cI2Ws1u; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5L9MqjxM6chm9GfultvnnSCykqa1J1MR2930gzrr/yE77CNBnMuJf5Ow9/ycTRGWbkcftYjKkQ8ns6wKMaSbSu2U0rbrjLU95tXAacVgzd5lUw7RldQMur9jjyUgrAelByj7HDZ1JORLkUqfeMpQG4QIeQrOlj6c9r3iitgpOhTptH9xfNMAMQIQWu6UmR+GluHQt9Jx5WG77DRvC71NTxsbZR59uRT87rrC07e2PQsBDyQaCo889s9NXDKGITaF32Yw+YufHeXYHzmpfWjo8MxUzXB+P1K7QsGQvpOa0jRy8gDMxniILJ9fO5gMAt+16elXiRQcoiIhK0uJ9yo9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igx0DvlPqotvjp4kfQfez3n+hFXNeGFlWk8cOxXnPj0=;
 b=EMri9o5JxKefnEjS1f2NRy5EwhVobHlhr5cWYs25mI4SJBSMHrXSo/gzGPbeHp3uZ3Bhpv5FpHQ2PGJrRb+GugGwyCgh/rXn8IafZPFgq9Ld52K0wHj9y3R5eXu+NbkOp6QURtwqOuQO5QDFwqqZCi78QS4g9BzyNNF/tYTl8EjWMF6J/39tEdj2OkrdRmM8An4b+Lg/KLuzCaHpA7J/abX0k82p1klOlNqBIOq5O1b3AyLBaUzP6b9UTZy2LBn+WOFoimXhoJyiP0Ex+ZoNSdSdCwKLKrj03ELQcjko7HQDPVcPUzqUNLF5n6Q2E/EJ8Uwz5N0Azfq6losDxUwiSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igx0DvlPqotvjp4kfQfez3n+hFXNeGFlWk8cOxXnPj0=;
 b=0cI2Ws1uX0M5Wp9iO3tKyPb9VEX9QxGstSVh5rcP2ZNMJq1t+ca3y8cUyUiWQt0wygS5SHKpQ9874KXC2cbFRP5N5qUOpe7HC2wC95J0z4jxJR1QbiEGwvxwu9CccxuBlAGyVLcfCIFwzeEzWdpIxdtsvpiImhmKoVNDememCdbto/2qUPtDc+YHuPe+fIqicnoZaD5IDD4UIKRvporBw9z2Zsw3Y94uBI4UI/PbdLJUsV0WWtcMhTNbvccj+ZB6OZOsAJmF8oElly2O+2Fa2IpAnIg8WzQDZRZUpYIil/+nD2a5TWnXaCU1rhZivLZ3xhhZRG6zyUYxmP/HNCYBsg==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by IA0PR11MB7329.namprd11.prod.outlook.com (2603:10b6:208:437::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 03:41:21 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%6]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 03:41:21 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<linux@armlinux.org.uk>, <conor+dt@kernel.org>, <Woojung.Huh@microchip.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <f.fainelli@gmail.com>,
	<kuba@kernel.org>, <vtpieter@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<marex@denx.de>, <edumazet@google.com>, <pabeni@redhat.com>
CC: <pieter.van.trappen@cern.ch>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 5/5] net: dsa: microchip: apply KSZ87xx family
 fixes wrt datasheet
Thread-Topic: [PATCH net-next v3 5/5] net: dsa: microchip: apply KSZ87xx
 family fixes wrt datasheet
Thread-Index: AQHa6ASck13yR/To50SJYqVM3E2BjrIbJ/4A
Date: Wed, 7 Aug 2024 03:41:21 +0000
Message-ID: <0ebe8136f9d088fc9968e5438af5640382c024ac.camel@microchip.com>
References: <20240806132606.1438953-1-vtpieter@gmail.com>
	 <20240806132606.1438953-6-vtpieter@gmail.com>
In-Reply-To: <20240806132606.1438953-6-vtpieter@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|IA0PR11MB7329:EE_
x-ms-office365-filtering-correlation-id: dbec9b61-bb1c-4a09-8500-08dcb692cde1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?QmVJeE1lY0tqZnNsZ1pGdFFVUWVUWk5jV0w5bE5rWGMzUjQxYkxoWWl6dzBu?=
 =?utf-8?B?WFRXdG9UanFzTXozVFdLUUtxK3FmTWxDc2VVazVZckxERklETzYzZkNteVNz?=
 =?utf-8?B?ZU14dVlsRWwxdW96MThTNnJhYk1jR3NBZTlodFo5ZksrWWxyWFJnQnRCdExj?=
 =?utf-8?B?UWxPR2MrWDFBSmpvVmROaHoxVkhzNTMrWkg4cS9HbkhsS2VnRzV6OElEb3RQ?=
 =?utf-8?B?ZU9od1p4SHdJQXdEcUduYXg2d2kwalI3OG1SRE5QUkdoU242cG9HMnRLbHlL?=
 =?utf-8?B?Y2R0Z09GVjY5NmlMdjdxZGNMZmhld2xQay9heDZVeTRYemlhcUp1T2MzVmxi?=
 =?utf-8?B?bW5henJqb01TdTFNU2J4b25VaFRVeXBoSnF0ODNtODEvcEFHOFJjd2tJRnhr?=
 =?utf-8?B?cncza2dXRzBwTWpTL1pYY1EyWDJHMW1CRGI3dFVqcy96UUozR2hkWGZiRkE4?=
 =?utf-8?B?K0JtV2NOSGNuUURSWkVKeUZzREpyd1Q4TGJHc2IvR2NKQ1BJZU5IUnVIUFZo?=
 =?utf-8?B?UW1tRnNwQllLcnJkL2hPRGNSc3VodW5FS0plb00zaitnY0UzMkNqOUoySStV?=
 =?utf-8?B?SUtrQVh2cXFib2JkaitjN1RTME83dHhmVVA5WFg3Njd4KzRmZzZjcFFUVGw4?=
 =?utf-8?B?Njh6TFROdUttWXByVGZLVmxmTm5MdHdCaDkwd2pIcXZteUxhdzEwRC9JQUNU?=
 =?utf-8?B?VjlEb2FReC9Vb2p4YVFFc2xTQjlTZUVZTFR0dWJxZXRQK0hGNHdqZmtTVnVu?=
 =?utf-8?B?T2RKSTRickhYd0hvLzEzVUtQOW1ZbmVMcFZRVjRwaW1WSThyLy9keGcxSGJH?=
 =?utf-8?B?U2w1aVV0ank4c3dDazdtL2FaYXYrbEZReHNQVjl3U1VtTlU1L1NqTTkrUEJK?=
 =?utf-8?B?UmdaL3UwWTYvcTNnYXlrbzFDbVdYT3JOZnl5a0ZZSmlOM245OWFPanNEdVJB?=
 =?utf-8?B?UGZ3cVpxa2RvTlpua2E0aG1aNTVlbllmRFFuK1NuSW1kc3VkTmMwSkVMKzdz?=
 =?utf-8?B?NUg1RUoySFNFYjVZTFJJeUZTNjNMUkxwNFFPUW5ONFNtQWxaa1JqNnlpZmto?=
 =?utf-8?B?N1p0TUJwK2lqRWpVRk5vUFUraWVwWUVVQVhLN2FqV3dORWQ5Q3JwRWZUbkFZ?=
 =?utf-8?B?dytzWnJ6eVV5UGJPVjNTbGJkUlU0TFVVekpJbVBvc1BSd3RPZ244cDNqYnc4?=
 =?utf-8?B?VC9zZkdwTjlMRWZ1OXNMSXhETjM0K1VKUzBXT1AvZVhZQkd0RGlJaldrak1r?=
 =?utf-8?B?S0FxVjZEOFB3M0EzWGVrVHJsd0d4MDhVS1hkTmJrbk90WjZ4WnBwQlNtWGVL?=
 =?utf-8?B?M0s5aHN2STRGM2ROWWJwT0xyQ2J3STUyTURvelpLNFhWdXRzeDJPcGY1bEg0?=
 =?utf-8?B?UExIWmZzTnRORWRkUXhEaW1SaFR1NWExUVE5TGc3NVRMREtyNzVHUS8wWUc4?=
 =?utf-8?B?NXI5Vnp3Nkh3Q2JwMi82SS9NaGJ0SW4weTRUSEJHL3BlT2xZVVZCeHBueW1p?=
 =?utf-8?B?RFM5QU5rUnloT3J0WDN1SWJIb2NXaFE2MzUwallRY05qQ0RLcTFQMzJONGRG?=
 =?utf-8?B?OEpjUHZ0UHZJU3RQcHRGK0w5SzQwWlFGaXRhd3BZVy9iZE9kcFRrZnAxK1pi?=
 =?utf-8?B?Z0IxdFl1cTIvMWVsd1dLc3ZzWHRQeFc0OXRRNzVKaXZGOUsyaXNOT2JLQjEr?=
 =?utf-8?B?WlFpM0JtN2prSGVocTV3ZGlYRWFtekNUa2RubVNMK3FSSGtTMU5Ma2piWXZG?=
 =?utf-8?B?a1dydWNBYy9uNzhFK3BJeDdpVFRiNWpibjNheXR6UVJ2Y2xJRTREaCtjdDBu?=
 =?utf-8?B?L1JnSkZKTzVITlVmZ2FWVm41TW56dHNQelhjcGJPNTRicnkzcW16SjlVS1cz?=
 =?utf-8?B?TDJYLzIvNVJUZ0FZUWlGbUp2eGVjaFdIOTFBQWZDMUZkdlJvSmpzcjdFTzVT?=
 =?utf-8?Q?jgYKomZPTgM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WU5GQnRQaEM5SUsyTHFVZUJJTlowL0cwcEVTa0c2QzVGVXRYTk5hc295YnBR?=
 =?utf-8?B?ODI5TFRQSlJBNmFyVndpVkYzajhMK0lCOWsrUDJsSHVJOEZGQ1hXendyYjBL?=
 =?utf-8?B?cWduL2lEckwzb1ZWNmM1WmxSTzNmWkYyT3o4RXA5dmRuYUFlUzZBNVRteXNB?=
 =?utf-8?B?SXF3N3o3YThFRG9hamZ6Um1aRzd2WHhCbGNta1VkN1IvSnNmOG9rNmhrSjdw?=
 =?utf-8?B?T1ppMXRZdW5QTDM3cktBZ0ZBQm5rZ01TL2JVb0VuVUJHclVnTjVQam41bVdn?=
 =?utf-8?B?R2dmdUlYdFY3QS9PMkt0N05TTEVTUzZFNWh3MEsrQXl0dVZVV2dUcTRPS04r?=
 =?utf-8?B?N0Z3ZjVVSGtOM2lYUjgyaVZxNW04Y2J3dWpBa0VOK2N3RCtoOGk2NkdTWVdw?=
 =?utf-8?B?Q1hremVQQTJWbm5lUkxnQXJSd2d5c2xOZ1dRL2JWcVVkSjBWTzIzYVpjbk5J?=
 =?utf-8?B?Z05UdDZ0YkRramkydnV4andZalYxMDdHT3lSZHYzMWxPWWJYZFRlL05HQmdO?=
 =?utf-8?B?U1hxOEQzeFBHa3pnZDhrK0djQ3Fpa2lURUkvNjdtOEluRTdDVmxEdjV0QlZO?=
 =?utf-8?B?ZTRseG5GWnRSYzdya0RRZkFBazRvY2RLNlEwaWhWUkE2bjZyVEh3cUsvMTYv?=
 =?utf-8?B?Rng1QWlDTGlvWTFYSENtbnk5S0RVL0VWZHh6ZHNybmY2cDlOaTZlU0VHdjFw?=
 =?utf-8?B?elVaNFlJcmtRSjBGUy9JSUJyUHhXbkJRaEtMRGxjbjNmUk1Bem9KREpKRXBu?=
 =?utf-8?B?ZWtoOHpnNm04a0ltZ0FBWUIzMDAvRDlqdHVqK2pEWEFTTm84cVlMYnRraGEr?=
 =?utf-8?B?a0tKSXpnUXFNZ0FGSHVHblRuSUxPSEliNzNjRTBudEVJM2xud0lFTnhKZ3Mw?=
 =?utf-8?B?aUNMTkdMak1yRXRqZW5zSUxlTEpmVWZZKzArMDFqbTluNGdkeklSY084dFla?=
 =?utf-8?B?OWlzSy9GSFhYVXMrQXVPcUdvc1FLakQ0cFFueU9kYVBLYlpWTUFpWEVwQ3h5?=
 =?utf-8?B?Sk4vMkRoNTN2U1BFUmpTVlJNWnBuNE4zdTkzNHZlcFFFTlUwN2U4WDlXRXFy?=
 =?utf-8?B?bnZIYVd0NjZzVEplZE56ODhKWVpCa2Z0MHp0NGM0ampWMUNjUGVlbFJtMVF2?=
 =?utf-8?B?VXdWcHFIamUwcUk5bWhmbjcxMGtKT2FjL0hZLzZPOHdQMGFaSjB6MjB0RjM1?=
 =?utf-8?B?ZkVHYU5RRGpzZzQrTWNxVStjSkZnZDJXYTMvcUlDNW01aE81N3BjQXplMTBr?=
 =?utf-8?B?VWdWakhZRFJpM3E5S05WbmVPeE56T0d2NUE5UlpTR09NS0NIZ0dDekxBczRs?=
 =?utf-8?B?UHhFQmZETDZIVUtKaGo3M2U5RklBQUEzOVZZRTlDK1djajVnbGdUOTJHSitD?=
 =?utf-8?B?dFovbkh5Ym8zN2VBZ2R0bndpNGFTU2R5QUY0UnUyRDh6WERDUU41MkRTTU1t?=
 =?utf-8?B?bThEMXFza1g2TmtkQk0rQmdoWTZLa3FMc09HcmdYWGdoVEZtNjMvN1JIY0JU?=
 =?utf-8?B?UjJnMHRvcm5GRmxRNzhIcGsyN2F1Y0tXNWVyOHVKRm9vYUxoYVNydWVnVXkz?=
 =?utf-8?B?dzBaSk9Wb0xLdkVpbmx3MGQzWE80em1haU5rSjhKZ1E1YXhybWhlR0ZGVVFT?=
 =?utf-8?B?Tnh6SjJaY0dQT3pMNmhiYnJ5K3o2dzVCREtqaHoyRCtnUjJmSGM3YnBBMDlj?=
 =?utf-8?B?dDNUVVBSZU1hM09uaU1DU2ZiUk80UW5RUm9RUnN5RHFybFd3bXlmMGVBaGZi?=
 =?utf-8?B?TFBGVzgvdjl5TnU5aDA1TkVXN0dFcjZzSHo1UFVNMnRhZzhZbFQ2OW1IVXE3?=
 =?utf-8?B?UXdxS0RFcU5NU045cUFNVVB6K1h6OTlBODN6eFV1SnA2cU1OcUZxajBKa1Vi?=
 =?utf-8?B?ZmJjcWF0S3h1WkErd203U0hyU3Aydi9vOFd1Z2tMaDhBbDdKeGI2SGg2VFBQ?=
 =?utf-8?B?akJLc2JDZSs0NTBiZVBOYnJjMk5PTzVpSkVuMURUUHQzR0JPanJHd0JZY0xo?=
 =?utf-8?B?YVdUUjRkOWU0VGNNNDVkNUFSMmF5VTQvK0luMGtFTkVxN0UvRFJMOE9ka0dv?=
 =?utf-8?B?TURiUzUzbkx3d2dxeXhrOWlKcmZKaThScWtOUjJJc0JITjRMZFZjb1FraVov?=
 =?utf-8?B?cFF3TlRtVEFJOGY3cTR6d3N2L3A1aEJKZVh2RVY4YnFOOCtnQVZoV3VwWThz?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F73D80FC54B30F4FB419A5EDE379219C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbec9b61-bb1c-4a09-8500-08dcb692cde1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 03:41:21.4826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VP6h1dLlywwzOmkzUm58BIDS/mB+PwMyvas3QvQwJhSzSNtlpbgGmPsk5a5rUy9eIMJovynHuSSukUhQ5qS3Skp2fnCa7Im5Dzy93SA1vVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7329

SGkgUGlldGVyLA0KDQpPbiBUdWUsIDIwMjQtMDgtMDYgYXQgMTU6MjUgKzAyMDAsIHZ0cGlldGVy
QGdtYWlsLmNvbSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZl
DQo+IA0KPiBGcm9tOiBQaWV0ZXIgVmFuIFRyYXBwZW4gPHBpZXRlci52YW4udHJhcHBlbkBjZXJu
LmNoPg0KPiANCj4gVGhlIEtTWjg3eHggc3dpdGNoZXMgaGF2ZSAzMiBlbnRyaWVzIGFuZCBub3Qg
OC4gVGhpcyBmaXhlcyAtRU5PU1BDDQo+IGVycm9ycyBmcm9tIGtzejhfYWRkX3N0YV9tYWMgd2hl
biBjb25maWd1cmVkIGFzIGEgYnJpZGdlLg0KPiANCj4gQWRkIGEgbmV3IGtzejg3eHhfZGV2X29w
cyBzdHJ1Y3R1cmUgdG8gYmUgYWJsZSB0byB1c2UgdGhlDQo+IGtzel9yX21pYl9zdGF0NjQgcG9p
bnRlciBmb3IgdGhpcyBmYW1pbHk7IHRoaXMgY29ycmVjdHMgYSB3cm9uZw0KPiBtaWItPmNvdW50
ZXJzIGNhc3QgdG8ga3N6ODh4eF9zdGF0c19yYXcuIFRoaXMgZml4ZXMgaXByb3V0ZTINCj4gc3Rh
dGlzdGljcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBpZXRlciBWYW4gVHJhcHBlbiA8cGlldGVy
LnZhbi50cmFwcGVuQGNlcm4uY2g+DQo+IC0tLQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBrc3o5NDc3
X3BoeWxpbmtfbWFjX2xpbmtfdXAoc3RydWN0IHBoeWxpbmtfY29uZmlnDQo+ICpjb25maWcsDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgcGh5X2Rldmlj
ZSAqcGh5ZGV2LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5z
aWduZWQgaW50IG1vZGUsDQo+IEBAIC0xMjYyLDEyICsxMjk3LDEyIEBAIGNvbnN0IHN0cnVjdCBr
c3pfY2hpcF9kYXRhIGtzel9zd2l0Y2hfY2hpcHNbXQ0KPiA9IHsNCj4gICAgICAgICAgICAgICAg
IC5kZXZfbmFtZSA9ICJLU1o4Nzk1IiwNCj4gICAgICAgICAgICAgICAgIC5udW1fdmxhbnMgPSA0
MDk2LA0KPiAgICAgICAgICAgICAgICAgLm51bV9hbHVzID0gMCwNCj4gLSAgICAgICAgICAgICAg
IC5udW1fc3RhdGljcyA9IDgsDQo+ICsgICAgICAgICAgICAgICAubnVtX3N0YXRpY3MgPSAzMiwN
Cj4gICAgICAgICAgICAgICAgIC5jcHVfcG9ydHMgPSAweDEwLCAgICAgIC8qIGNhbiBiZSBjb25m
aWd1cmVkIGFzIGNwdQ0KPiBwb3J0ICovDQo+ICAgICAgICAgICAgICAgICAucG9ydF9jbnQgPSA1
LCAgICAgICAgICAvKiB0b3RhbCBjcHUgYW5kIHVzZXIgcG9ydHMNCj4gKi8NCj4gICAgICAgICAg
ICAgICAgIC5udW1fdHhfcXVldWVzID0gNCwNCj4gICAgICAgICAgICAgICAgIC5udW1faXBtcyA9
IDQsDQo+IC0gICAgICAgICAgICAgICAub3BzID0gJmtzejhfZGV2X29wcywNCg0KV2h5IGRvbid0
IHdlIHJlbmFtZSBrc3o4X2Rldl9vcHMgYWxzbyBsaWtlIEtTWjg4eDNfZGV2X29wcyBvcg0KS1Na
ODh4eF9kZXZfb3BzLCBzaW5jZSBpdCBpcyBub3cgdXNlZCBvbmx5IGJ5IEtTWjg4NjMgYW5kIEtT
Wjg4NzMNCnN3aXRjaGVzLiANCg0KDQo=

