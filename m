Return-Path: <netdev+bounces-116657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB90694B51F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 04:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB5EB22D89
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 02:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638A9BA50;
	Thu,  8 Aug 2024 02:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="q/qbMYXP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E111A269
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 02:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723085105; cv=fail; b=beaJU3AR6wRWRmA4xvy0zJ5t5EnPq36Ed+myky0yt4jtLcSa7BoPr8qHn+48omZeMfZBq1s1hKQ/GjuxZ7Rw1iVlhkRaJ0/nmkh+niaGWkiG9IIT0oDlNNvqwV/CKGPudmwxtWf2565J881RfS3pLU96ZAwJSB9zhL8jlZIKOKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723085105; c=relaxed/simple;
	bh=KH37ZL7/kWN7hsGBQ+x6h2JqBwi4uTWawVi6M/2Nfz0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZDdVwKbnC/OWETcvusZZ+uBwHBWVLeFYn9DH+ywT8dBBLrWLTnYyAy4moAgLRD1aU6H0q7yrI8oM6bYwgzr46WJtrNDlZft+y18RrAvQ0U/fSLGKNCn6K/1IX0u2qoUeVrhS4Z0910ZjObh06XUSb0cndqeUrJL7Jik845nMIro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=q/qbMYXP; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i57aVS2LC5Z81kxT1+rY0dLtwLLSy3ZpwocnepWQ69dzr6zz70t6O/H+xzzC1U0smwvBjea7GxvyLd4mjFx+ImZKMPV6Run3Mi5jl4ayUmPduCHMrjhm7oUR7L6sQ3Y+JHCdsTafqZQx31PcZK7G9izJK492C3JommkQkELuicEbIbftJfcfaDJnto7M+GqWKAnXdF3IfSnN2/XDAviouL8tZTblfWSFpHMcX0le9qL4SgJAZPP4Ccq5BwAsgOEib1Qqu3bW+sdUTYxTi/LrHccbgTd6oREjJuQvae+cf/1TWgidzkqU76KeldMNX8BKfrHlnl9TNUfqUepceAAttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KH37ZL7/kWN7hsGBQ+x6h2JqBwi4uTWawVi6M/2Nfz0=;
 b=CjvH8cJvMEtyUSWIVpA+2+BK/4aRaBUqNgP3ptKhOkOCjWpoHh8amhYzjWsuJr0wnGBYvnJrksg10XxvLWjCsdV7FuCGl3DUJBt8y32r1Qp27F6dr65zfNFADjFvdiWljAQOsjifN1ztjrrNO1U2UN5sSVQddDDOIMYxmtmGYx6XkOquiKARUmZ1C3G8zgNsB4X9FzqeuAChaF9TbGFx/voDsqF1A2SN+ihdO1IlNvh2lEguB+FH6K5NbjPr8U2SazBQIxFm94G+Utoz+O49PkeyH6zCjvhwxDkUjm31LNx8j76hcdHTcEFienn/Cg3B+Y+x38XWIepCEZCNcy19Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KH37ZL7/kWN7hsGBQ+x6h2JqBwi4uTWawVi6M/2Nfz0=;
 b=q/qbMYXPNC0e5mljzSpPgsDjGtIYuEgwOLmZIvvhE9XPXHLHNIFcUl/chB6oegvYnrbJyFZVBYA47ubCcN/h53EHOrQQFuzRt6EW+wr8HZnoAliMQBa2iJ2j6P7zuYKBblcPJpcfoKam1JAYi6vKFeErVXHDf3DmZoaJQ6diN1Zf37dZGnigbxhQ3tjJKp91pvRHnb0xrjiK59XDxacLF5GID+ApC0a01PyWgtIrBszzDlVaF+Kt9hWGpQeyO7jgrT2iRWqMrzG8BssatrJcAe1s9ntaD8hU3pXiffHi+DNGExKINL+zH4KNTRgL3HxaPAKQaU8NxhLLIm4vO7pbgA==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by PH8PR11MB7990.namprd11.prod.outlook.com (2603:10b6:510:259::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Thu, 8 Aug
 2024 02:44:57 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%6]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 02:44:57 +0000
From: <Arun.Ramadoss@microchip.com>
To: <netdev@vger.kernel.org>, <foss@martin-whitaker.me.uk>
CC: <o.rempel@pengutronix.de>, <Woojung.Huh@microchip.com>, <kuba@kernel.org>,
	<UNGLinuxDriver@microchip.com>, <lukma@denx.de>
Subject: Re: [PATCH net] net: dsa: microchip: disable EEE for
 KSZ8567/KSZ9567/KSZ9896/KSZ9897.
Thread-Topic: [PATCH net] net: dsa: microchip: disable EEE for
 KSZ8567/KSZ9567/KSZ9896/KSZ9897.
Thread-Index: AQHa6Qt7jUcF1L1F+kGOyQ6//SEaF7IcqIMA
Date: Thu, 8 Aug 2024 02:44:57 +0000
Message-ID: <d00c52e1eff78e5c0c84ed40dced8660408c1fa3.camel@microchip.com>
References: <20240807205209.21464-1-foss@martin-whitaker.me.uk>
In-Reply-To: <20240807205209.21464-1-foss@martin-whitaker.me.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|PH8PR11MB7990:EE_
x-ms-office365-filtering-correlation-id: d6241f67-03e0-4ca0-cccd-08dcb754173a
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VVNoWWFOMnhWSUpnWS80UWxEcTA1YlBnajFoNUR4WUlZeUtjREZyV3pCWjZ5?=
 =?utf-8?B?THRUVzNGRWtQZ2gzNW9qbWlPaXJCeEswYzd0S1N5L1ZkaEsxaUtjYnQyUHhM?=
 =?utf-8?B?dVVjN2IxQ0ZjcjJoZTVKQTl1cW83d3JVMmxISVdnRW5lcWY2MzJOZ2pHbVlx?=
 =?utf-8?B?c0tLN2h5ZlJySHFhSUp2RGFYK0gvamtiZmFSWExOcXV1SXd2c2FDRWlnWDFs?=
 =?utf-8?B?WGl5MHIyWEx4bThjT3RiZGVDQjIwT3pPeFJDM1plMnFZeStaVWV1OEhLOUVV?=
 =?utf-8?B?NllvT013UWdVL2p2aEtSaTRTMERZUU82cmNxMFhjNnI2Y1lVNjVuV1NjUGU1?=
 =?utf-8?B?T3NsRGRFcE9BN2t4VmI5MEFoWldISkgybCtUS2gvYy8zNHpYOE9CTlB2SVNm?=
 =?utf-8?B?c3BRblhYQ080TGd5SGZick42Q2doOGs0clpHNXF0SHpHWldEQWlvTytBamQv?=
 =?utf-8?B?NzhYRGxzdFJjSHMyUXBJUVlpNVpkelUzTDZtNCtwYithK1RJMVd6OUljQUVj?=
 =?utf-8?B?WS9qR1dZOE5LY0s4bS9mblVHRm02L2hJMDZCaTc2bTlaV1NYTlYvUGNuMEdI?=
 =?utf-8?B?c2Nrc1NDN2ZRdWFEMVRBcis3YlN4UHNlYnM4ODFValFxUGhlTTZqQkNwaUEz?=
 =?utf-8?B?aWNieXRJaXlGSW5QSzJYazlOejVpNzQ5NVR3N3FQWTVlZDhmcklCaUpNeVFR?=
 =?utf-8?B?ZUdjVjVFVmFOZDN3UTN6dnI1VnFURkNnMnVJczg1c2pHNUxRQTJNQUNmVDdQ?=
 =?utf-8?B?Tlh0ZTZFKzNidFNwTUZtc2xHbGlEa05PaHBiTW50bGMxYmZTYmlmK2h0YjVT?=
 =?utf-8?B?SWFDOEdaUHpxekZOd1VjT1VUOWpNK2p2QWF0dDM4N21zNjA5dFZiUU5kS1I5?=
 =?utf-8?B?MVQraUpyWUgrM0gwMXVlOXBsZDZpR3RGUjNOYUNKMGsrMDVzRURBUENRdjZX?=
 =?utf-8?B?eElSc2g5Q1YwalpnaTZaUUhkNHdxNENhQXhXMU5nNndKeEFCU2d4QTY1WnE2?=
 =?utf-8?B?WS9nK3JocVNMRFJkS1Yyenljdi81R2UvWGtBZWw3UktuSm9PdFlBWjFlMWRD?=
 =?utf-8?B?OC9WTGkxSlRzNVNYRFIxbDJDL0RhM0J1UGErSDFuaGF4SWhPYlNlQnVYSCtB?=
 =?utf-8?B?VUV6NmNvK2sxU0d1d2l4ZEN5REhzVVZUdXNESTZJSmF4QmZJZ2VEM1RNN3ps?=
 =?utf-8?B?RXNSQnlRMEMwOHlLZ1JOZW5FY0RRLzNtQzQyMlVyaVI3Q1Uzc3NEZzlnWXo0?=
 =?utf-8?B?NkhDMEgxRTBSTTVyVjQzM1BhOXRRVmRQcG0xelVNQ1ZNUTZ6VnZwdE9oM3RM?=
 =?utf-8?B?djZaaklIVEljcjYxYnVzL3o1UXB1Q1pRemlZdlBEMTJhYXJPOFdhUFZLSjJ5?=
 =?utf-8?B?TkhsUDhSa1JmRGpEcXVhS3VHL2hvcVhpSnlIN29WSVdReEN6cmxpTTRZcDd2?=
 =?utf-8?B?YUkzUkdwWTU5MHJGQjU5cDBWcUswU1VSNmZ6OGNFUUg1QllQVGNJdWZIUC90?=
 =?utf-8?B?dm9DTGpLVHhQWUxXVDMzMFg2TTg3WXJ0TkIzNHdMQWRTWlNCZmZ0UmR5VytE?=
 =?utf-8?B?R2MzV1JvZUcyMXhKbWJaa0ZrKzBsOENDV2pGcTdVaFc0YlVOUmtMVmVaYVQ1?=
 =?utf-8?B?RTBpMEJXbFMyN08rRFJHdzVQeFFXSWpzTCt3NlJmL0lZMmVzZGd5WmJXR0Qz?=
 =?utf-8?B?ZytQc2FqTVczWXArbmNNTWdzVlcwU1pIWGtFYzRsODBnY1phR1BHNVRPZ2o3?=
 =?utf-8?B?cTVNZDhUVitWZE9QSGhuWEc0VS9oUmNpWHN4ak1FZk1nbjJMM3c1b3UzVytR?=
 =?utf-8?Q?6ak+Am+b+2CxmVcEvLSx13Ez9PfBYUAhbLKDU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zm5mdG5NNkdMV0ttbzVDT2pRUk4wRGU3VHN4NFpiNms3VWM1Nmgwc2tXeTky?=
 =?utf-8?B?c2ZWWUdweHBBQ0MvRVQxU3dyeEpzY3ZDTmI3cGFuR2Z1N05zS1pFSW0wbExi?=
 =?utf-8?B?bDFFYWZldFVmRDFZeTBLcHRiOCtIU0NrOEc4MnNKQ1pCM1F6TVVoazVPdEZV?=
 =?utf-8?B?a1dsRkdJeTgyOG0xRnNIRzVtdHU1amxhb2hpcFBsSEJ5YS93SnNxRE8vMk9J?=
 =?utf-8?B?OUx1WGkwMmtGclpmNDhwaGFYRjF4bzJqODNYbnZvOHdUR2lKa3AxTGpTSGVj?=
 =?utf-8?B?VEVzNjhleDkwQWFNZjVVeS8xc2t6TW1iejRvSHVUaDdUZXhsVk1CNDQ3akx2?=
 =?utf-8?B?dS8wbE9LeVQ5cEdZYjlrdm8rODkzZWUrZTZPaUdobHN1R2c1ZDFmZEcvdGM3?=
 =?utf-8?B?Q2lJUlU5VGd1eEwrMHEwMTNnRU9EV1BaMWlDaXZpb1A3ZE9nZWpGcnlDWkw0?=
 =?utf-8?B?c2pXM1RsdDg0NWlQUWgyUC85UXdZZVRPMUxTSHk0U0Q2eWU3SXZudEo1N0NE?=
 =?utf-8?B?MitraFUzc3dKMFRucjR0OVJLeUQ5MUxQclppSnNrTlN4NjBSWTZ0TWQ5YkFs?=
 =?utf-8?B?Z2RmQkkwa2tkVmJjSllUTGVlQXkxZFBrN2R0by9pZktuQzk1ZUY2cjZNeEtq?=
 =?utf-8?B?NGJvMnIxT2FBeUJBUmhEcUNuaklYMlZOaUNqR3NTVElnY1VjZ2ozU2NtTjY4?=
 =?utf-8?B?QXAxSktVZkRUUWJYYUFZUkZzK0poMk41bHNnTnNZRjMzTXRvTGI5aE15UDhD?=
 =?utf-8?B?R09YNzRTeXlUSk0yTTVkTUx0c1VTbzUzaFlvSmN5TlBGeHZNZHpBSEhwdndp?=
 =?utf-8?B?cUFFRTJtb1hyTUY5dXhrK1F3WnB3ZTJWQkYvbHdEaU5CSWE4OVh2YXpKOUlK?=
 =?utf-8?B?alBKekp4azNPTmt0bS9XOEtjRE5EQXdaZVcxOVRnZTFwQzhKZ0tqMTd2aTNY?=
 =?utf-8?B?bWtRVHNJN0tWbGs2MFdOYXh0amFPcSt3enY0SmladGI5L1NwU1lWdTlhajZi?=
 =?utf-8?B?Z21TSENjeFIwVzcxV2VTMmVlUDQwQ0RjbjhJNWpXR0FjWXFEVEljemhDT2xO?=
 =?utf-8?B?WXZPRm5aZnBFUUNnRlREUTA5c2tVcXpLTUVoWnBScTZPNmFVV0dSNmJlQkRy?=
 =?utf-8?B?cHFnYlhneGw0eCtaOFpiSHVnZmhOaDM2cmRIVkZSU2IzNTVRSnZJUHg2QTZ3?=
 =?utf-8?B?Z2dYMHNZZGY3WVlGbzV2UHFDNnpIWjQzSXAyL2tLbmFxVGRXSU9OWDdvb0lE?=
 =?utf-8?B?OS84czB2QmhNS3QyK1pKUkpaaDltdjNQdEpLRm00Y2pRRzVCbEFXSkxZQzBm?=
 =?utf-8?B?MXFrNENaMnVOdzRTN05kSDNuMjd5M2FoS3NZNnRPS1pkb3M4MGpUWmRIVExX?=
 =?utf-8?B?WkV1dmRNRjdiZDg3dFB2cGppU2VWdXNMZmRNUGhCS0ZDZzVKTGQvUzJZYnpu?=
 =?utf-8?B?T0UzalN6anJzeVNwQzZaYmFYRmJWaWk2VTVTVk4xd2xMeGoxTGJBdm5pN29L?=
 =?utf-8?B?eGZaUzBRaHpyMlIva2Q2c0t4VWEyNmVsUG5FRWhsbWNnVEZRb1h4d2FRbW84?=
 =?utf-8?B?NVpOQ0l5dE0wUVc1VnlGaWlqVWFsaG94S21EbVR6WXpOdWg0UmNiM1NCSzVR?=
 =?utf-8?B?OGkwZWVCUVAwSVRqQ3lWaWQ4ZHlqZTVSNC9tSThFUThEQnBxVk8xOFFUZ2xi?=
 =?utf-8?B?TVN2TWFnN2ZrNkNOK3lHd0RKVjNzRUF5R0RGSVZmYkNueG9JZWJmREh1bFEr?=
 =?utf-8?B?QWFwU1FySldDU21CT1psTDZLYjVDV1BMY1FWdUtIRDh6blNGN3A2blNucEw5?=
 =?utf-8?B?OFZPTzY1OE9FQ3NZVjhLOWJJQ2Z0Um94VnltTmhDQlNrbTBwYktzNjUrTUVF?=
 =?utf-8?B?VzhyS29YSzZYdjM2TTBaSHlFajdLcWZPQ082S29kbWZ4YUI5S1VFczZ2VkRO?=
 =?utf-8?B?Y29jSmVqR0ZES1RibHRLSytiTTI1eDMrZE1ELzNsRVQ1S0VKWko1cEoyY3hs?=
 =?utf-8?B?S3JDYnQ1R3JjY2NhdXZ0K0RQT1FEb2Z3MEMranFXckJQejF2K245VXIwd3Ri?=
 =?utf-8?B?Q0F3VkNYZ0R1NC9JMGlCblYwYktuS1ZaYWRXb2NTVzYycHJSaU8rT3FPZm9Q?=
 =?utf-8?B?SXRQUm41aUxWZExsNUMwcEg4U3hOV2xIRm05UTNxaFN5QjdFZzF3Vk5FNEU4?=
 =?utf-8?Q?Cm9orNk/BfPXmShnQhwPMiE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53D0FDFECD1B054BAA71CB27758015AA@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d6241f67-03e0-4ca0-cccd-08dcb754173a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 02:44:57.4073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUPBH8DLKFWePckW7b5Ja9kLBND0qUSt14rcqO4fHXxzK4bpYKlUMIzX2cWRer4srawykTKEAr2UFH4V/5d+RSmIty5f3TCT/rbz8Otv7jE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7990

SGkgTWFydGluLCANCg0KT24gV2VkLCAyMDI0LTA4LTA3IGF0IDIxOjUyICswMTAwLCBNYXJ0aW4g
V2hpdGFrZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0K
PiANCj4gQXMgbm90ZWQgaW4gdGhlIGRldmljZSBlcnJhdGEgWzEtOF0sIEVFRSBzdXBwb3J0IGlz
IG5vdCBmdWxseQ0KPiBvcGVyYXRpb25hbA0KPiBpbiB0aGUgS1NaODU2NywgS1NaOTQ3NywgS1Na
OTU2NywgS1NaOTg5NiwgYW5kIEtTWjk4OTcgZGV2aWNlcywNCj4gY2F1c2luZw0KPiBsaW5rIGRy
b3BzIHdoZW4gY29ubmVjdGVkIHRvIGFub3RoZXIgZGV2aWNlIHRoYXQgc3VwcG9ydHMgRUVFLiBU
aGUNCj4gcGF0Y2gNCj4gc2VyaWVzICJuZXQ6IGFkZCBFRUUgc3VwcG9ydCBmb3IgS1NaOTQ3NyBz
d2l0Y2ggZmFtaWx5IiBtZXJnZWQgaW4NCj4gY29tbWl0DQo+IDliMGJmNGY3NzE2MiBjYXVzZWQg
RUVFIHN1cHBvcnQgdG8gYmUgZW5hYmxlZCBpbiB0aGVzZSBkZXZpY2VzLiBBIGZpeA0KPiBmb3IN
Cj4gdGhpcyByZWdyZXNzaW9uIGZvciB0aGUgS1NaOTQ3NyBhbG9uZSB3YXMgbWVyZ2VkIGluIGNv
bW1pdA0KPiAwOGM2ZDhiYWU0OGMyLg0KPiBUaGlzIHBhdGNoIGV4dGVuZHMgdGhpcyBmaXggdG8g
dGhlIG90aGVyIGFmZmVjdGVkIGRldmljZXMuDQo+IA0KPiBbMV0gDQo+IGh0dHBzOi8vd3cxLm1p
Y3JvY2hpcC5jb20vZG93bmxvYWRzL2FlbURvY3VtZW50cy9kb2N1bWVudHMvVU5HL1Byb2R1Y3RE
b2N1bWVudHMvRXJyYXRhL0tTWjg1NjdSLUVycmF0YS1EUzgwMDAwNzUyLnBkZg0KPiBbMl0gDQo+
IGh0dHBzOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2FlbURvY3VtZW50cy9kb2N1bWVu
dHMvVU5HL1Byb2R1Y3REb2N1bWVudHMvRXJyYXRhL0tTWjg1NjdTLUVycmF0YS1EUzgwMDAwNzUz
LnBkZg0KPiBbM10gDQo+IGh0dHBzOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2FlbURv
Y3VtZW50cy9kb2N1bWVudHMvVU5HL1Byb2R1Y3REb2N1bWVudHMvRXJyYXRhL0tTWjk0NzdTLUVy
cmF0YS1EUzgwMDAwNzU0LnBkZg0KPiBbNF0gDQo+IGh0dHBzOi8vd3cxLm1pY3JvY2hpcC5jb20v
ZG93bmxvYWRzL2FlbURvY3VtZW50cy9kb2N1bWVudHMvVU5HL1Byb2R1Y3REb2N1bWVudHMvRXJy
YXRhL0tTWjk1NjdSLUVycmF0YS1EUzgwMDAwNzU1LnBkZg0KPiBbNV0gDQo+IGh0dHBzOi8vd3cx
Lm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2FlbURvY3VtZW50cy9kb2N1bWVudHMvVU5HL1Byb2R1
Y3REb2N1bWVudHMvRXJyYXRhL0tTWjk1NjdTLUVycmF0YS1EUzgwMDAwNzU2LnBkZg0KPiBbNl0g
DQo+IGh0dHBzOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2FlbURvY3VtZW50cy9kb2N1
bWVudHMvVU5HL1Byb2R1Y3REb2N1bWVudHMvRXJyYXRhL0tTWjk4OTZDLUVycmF0YS1EUzgwMDAw
NzU3LnBkZg0KPiBbN10gDQo+IGh0dHBzOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2Fl
bURvY3VtZW50cy9kb2N1bWVudHMvVU5HL1Byb2R1Y3REb2N1bWVudHMvRXJyYXRhL0tTWjk4OTdS
LUVycmF0YS1EUzgwMDAwNzU4LnBkZg0KPiBbOF0gDQo+IGh0dHBzOi8vd3cxLm1pY3JvY2hpcC5j
b20vZG93bmxvYWRzL2FlbURvY3VtZW50cy9kb2N1bWVudHMvVU5HL1Byb2R1Y3REb2N1bWVudHMv
RXJyYXRhL0tTWjk4OTdTLUVycmF0YS1EUzgwMDAwNzU5LnBkZg0KPiANCj4gRml4ZXM6IDY5ZDNi
MzZjYTA0NSAoIm5ldDogZHNhOiBtaWNyb2NoaXA6IGVuYWJsZSBFRUUgc3VwcG9ydCIpICMgZm9y
DQo+IEtTWjg1NjcvS1NaOTU2Ny9LU1o5ODk2L0tTWjk4OTcNCj4gTGluazogDQo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL25ldGRldi8xMzdjZTFlZS0wYjY4LTRjOTYtYTcxNy1jODE2NGI1MTRl
ZWNAbWFydGluLXdoaXRha2VyLm1lLnVrLw0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gV2hpdGFr
ZXIgPGZvc3NAbWFydGluLXdoaXRha2VyLm1lLnVrPg0KDQpBY2tlZC1ieTogQXJ1biBSYW1hZG9z
cyA8YXJ1bi5yYW1hZG9zc0BtaWNyb2NoaXAuY29tPg0KDQo=

