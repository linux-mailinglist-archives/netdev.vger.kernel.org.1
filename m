Return-Path: <netdev+bounces-115989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0466F948AF8
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 10:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85DB41F24DE7
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 08:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1D31BC9E8;
	Tue,  6 Aug 2024 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lArS5O59"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E947F1BA895
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931984; cv=fail; b=BuWe/S7R2EIenpt+NZSIuv+vRDdq8Gw45WpiBJ2U/S9Z65H9CGOVwRJWYv8P4c+O4F3kjLupo2Juw7QfLb67OacRemdzcyIu20cC2XeCWyueOhXe+knNH/5Wr4jgievGWqah7gTCKfb2PN60CGbMeIzTBRB23240UlzAc4gqYGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931984; c=relaxed/simple;
	bh=RuL1G7ibQ6t1b4IxL6KMccYijf2adtIsYdD2nBQh0G0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RDxtYy2V8XQcjOY5o8BVHaF6gosQGF+xQ3VoIC/ZuI62J9XNxUNq2p5nDznozokSvtVreF8NGFWRKgQTaj3jiunr0olrInT0vbQn+YvBl0ORnW8XwQGhtw4lR/RZw+jNjgoJUGAiR01rkELGLUN1VUiyfMcbNnZX5SNlW1hcIrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lArS5O59; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qtq9o/bBU8hFgEl6oSVF6IC+n5ISjw8DY5Nv/IH3eP4qJ/L8WeQMaewpd/QdA5E+5HXJanoeA/PRfbXpk0WCoy8k7sWj3X1eWpvDVOU4K3G+SVBzDva9icBbhQXc/oilCF4D1HK0yFkSSzJ9htg+8NUs/MiUBNTwSU7vDBmDPRkw8l4+lOFxQ0H8b8oerV7aG+rObVs+KlzL0vIDAxvKHIzJoTEf8+MUZ/iLU2PZgL84ukVzz5c7P58knXAdySneyuBbkaOEs+K48HDfNE9lMkAGI0xZxy+ouCBWA2nTKeJmJNYh/9hs6St9tQw8X+qMdnu7qo3qXRZhxVpTzl7Lrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuL1G7ibQ6t1b4IxL6KMccYijf2adtIsYdD2nBQh0G0=;
 b=pbjNrAGXyhk8ZxHYu5ND/bJCNkbJpzAgeyOS3RlbYcoFOfWycwbZpMk245OLAGjBWLKzGxiB1AjM4fWCJr59uLylank97BfdMjdlexNf28zKLGS1MvsbwV1MkQh71aIg9fbTyLuRqTIE8snQG/1rDkfHuElDDgJIE9G/6CQKh/iMHyqD96t4BWrNnsRlUghHAGdQWSkp9yKImhGe+5DJd1FXWH9gDdEqo4UbZ/a1KenmlCZJPcAPgaJ4HnezNBufn410KkI5eHcD0RxhSg9HFKPsKPjBwZiRSdm1w/UTuqX9IoV16YgXwCS8Ra8BtfRrogUnGsL1vVhfDOJ4oSMo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuL1G7ibQ6t1b4IxL6KMccYijf2adtIsYdD2nBQh0G0=;
 b=lArS5O59ia2/rh8JElJyFYbHHQ+Zc8Fb8+gJjTim59og2TyhvsokQlkwWSNdzSQ0C2ACMnbcdzW75fSTvRdIRtPHleh7mK73AKASDCAZvjFzK/yXi0nQNB7nR85EdNJhP7IMje2iVIMo8Mlmk+MJJlQkbAikH84ipyusrl9NJSXWl8hVUOIA7/DwO3tQkLV9/FGSSTF7hBhlhdyacOm1KNbtykwx2WfaEoXt7mx/IPvRIjAk/jL/qk/vQoESi0VPQczJTE5e+eLuzgAECxIPmyHUvFuvlp9oolyS9g/+R7sE8duBt5iInst0L9QK6sQm2aMhk+AUDWkfUQT4Jfo5BQ==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by DM4PR11MB7760.namprd11.prod.outlook.com (2603:10b6:8:100::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 08:12:18 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%6]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 08:12:18 +0000
From: <Arun.Ramadoss@microchip.com>
To: <o.rempel@pengutronix.de>, <kuba@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <Woojung.Huh@microchip.com>,
	<netdev@vger.kernel.org>, <lukma@denx.de>, <foss@martin-whitaker.me.uk>
Subject: Re: Regression in KSZ9477 dsa driver - KSZ9567 et al. do not support
 EEE
Thread-Topic: Regression in KSZ9477 dsa driver - KSZ9567 et al. do not support
 EEE
Thread-Index: AQHa5zDtWo4DGMy6PEO2pGLnLwS8rrIZJRGAgACJ+ACAADP7gA==
Date: Tue, 6 Aug 2024 08:12:18 +0000
Message-ID: <45135ac1096670794da5b5365f8b22e8f52f47e7.camel@microchip.com>
References: <137ce1ee-0b68-4c96-a717-c8164b514eec@martin-whitaker.me.uk>
	 <20240805135455.389c906b@kernel.org> <ZrGv3BEWnfaro39W@pengutronix.de>
In-Reply-To: <ZrGv3BEWnfaro39W@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|DM4PR11MB7760:EE_
x-ms-office365-filtering-correlation-id: 9425fc48-1aac-47c3-0cba-08dcb5ef7d5c
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TmttS0paTWdBZGJXcm1KalVxdzEzSWZ1SG1HZWR0QVpTMmFGS1ljM3ZQSmhn?=
 =?utf-8?B?cWVIaHdFZzArcHFmRVVQQVhkbDVYMWZKb0g2MGt0TDFUODROWGFPd1haUkJF?=
 =?utf-8?B?VCszVnd3Sk9aZFBKUVBVK2JLclBiSERvVDd4TmU3c3NWN0crN056Sk9wMkhI?=
 =?utf-8?B?bnRwMXBkdXNoTUVTKzJtWUxqQ3NQRU1Jd2RPS2cyYUJKejB0ZkxNNGxGUzFD?=
 =?utf-8?B?SHlNZ2s3RElFYTZ6dzNCVFRMbVVFc0lpVDFJL2xYc2JUN0pJazNnUXdhNU9s?=
 =?utf-8?B?TEJmWU51S1ZmWlA0dEI0bG1mN3JoRlJsWW5oMy9TT2xta1dTV05OejVjWkNY?=
 =?utf-8?B?WndoSVVyeTlpSC81NEtLdHh5NEQxT3NVK3NwOTl6QVZUbHdOWlg5T0h5QkZI?=
 =?utf-8?B?SUFVNmt1dzdRSVRIN1pNSVN0akhEanpRa1dFOXBHVTJaakNqSUxhYUxrU2Yr?=
 =?utf-8?B?U3BFU3RwV0FkYWg4Q1FnZGJ5elFrUGhmZjF2NVQ3SUJjT0Fyb1ZhOGd3Umtr?=
 =?utf-8?B?cXpYSmVvQkRmOWl3eWpXdENwOXdKUndDb2FrdGNWV1BNL0pTOG15Kzd5WEVr?=
 =?utf-8?B?by9sUTJkSDZ4MmJqOG0xV05TSU5pR1R2OW9UbVVjZUFpcGRZUDhYQXlIL3JX?=
 =?utf-8?B?cm1iQ1lOdDRtRjE5ZUEvdzdTWG1TR2Zwc1VWQ3pBdGtQYWF5Zyt1NTVqcVZs?=
 =?utf-8?B?ZzRhMmlodEJwQ2laSGZlbDlqOVhxdzlXM0grQmgzS2JmMll2WHpjemhRV256?=
 =?utf-8?B?UXZXaGFwNTkzK1NwRDZlcVhsaTlVbVFDdUJOUjc2cDVyOU1BdXhMMUxmYjBo?=
 =?utf-8?B?eFlWNVQyOWF4SHJMdGZTMTdMSk1vN3hZczhsWjZia0lQU0lvUU15SFIzOVFD?=
 =?utf-8?B?SnovdlQ0S3VicUFxekgzOTJXZDRneDBCa0l5UFhqMzJJMG1yTUpjdTBnTGk1?=
 =?utf-8?B?ZjJ2TU51eTE3TllnblNxM3NyblcvZ1llU0RXRnBwZi9VSnErZnZuMzJoR2Y0?=
 =?utf-8?B?Rm85WEJwZFJ5N2lUK0YwWW81VFpuY1BQRmlxcTZ4d1VPYzQvdGZ6MzRrMytR?=
 =?utf-8?B?YkovblMvODV3d0lsalVwS01qUVU5bFJxTjZnY3VvUGVabTFFcEpVMnRrV0pF?=
 =?utf-8?B?V0IrYlpmSytDM09FT3d6ZFRmWU9UMVpRajR1ZTE5WGZQaS9tRnB4M2VrZ0Iz?=
 =?utf-8?B?eWJzb2pNUStDcTEzYUNoaUhjL25rZkQ1MHBHaXNlWWZoQXVMTHVmVVRyKzMw?=
 =?utf-8?B?Z3RtOVBQZitZVFlpY2Z6Vm0zT2ZaNTdxNkVqYzFvdG5MQjJJbFBKK2Y1a2NU?=
 =?utf-8?B?YlFNUTNoaGYrR2NQY21IdkUwbEVzSUJzREMvV2UraEZSNG5rTTdoS3dWSkZN?=
 =?utf-8?B?NjFlYXJteThKU1dFeDJJQ0lvL0w0bGVjaExvSXhEeE1LNTdGSEorNE5nWDZj?=
 =?utf-8?B?WWhkZldzN2xGck5zNDZOcVBhSXJ0OC9EallWNGhCUDgvREZRS1kxTHVFdENj?=
 =?utf-8?B?QzNOWm5Ga1BGR2ZjQk1ETjBEN2YrVG1oejBqaEFnekFLWFV3enNVdC9Fb3hl?=
 =?utf-8?B?aWRQbGMvTmRnSy92dFgxbENxU21nS2JLNUdsYVVZemhoZ0FiWFkwNHYzbDZJ?=
 =?utf-8?B?MWpFWm5kYVBFMDd5L3RXMTNxb21YWmF0SFNudTlGWnRxNHFwUHJ1RW92TFBQ?=
 =?utf-8?B?ekF3UEZBMTNiOWtUcENqbmU4ZWI3YUF0YURiaGpraTZWeFlacTJqZ0NkZGJl?=
 =?utf-8?B?SVo1cTdTSWZHRlhIOUFEOU5ZTGt5bE85QjNBdXRoRnF4NVFpbStRbEN1YWJT?=
 =?utf-8?B?c2FkL1NlWEEvQXRrTWJtMC9XMnpIS0pzL0tYMnBsQWthcHArUDhYcHIrQzky?=
 =?utf-8?B?ZURkVGlwUnhxczdyUjNSMmdka2VteDlHV2RQWC8xWXF6R0E9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWk2MUVxNVJTMkxDYU5hSy83UFEvZHMrSCtkbkh1R0cyZ3piUHlJdlZWdzJC?=
 =?utf-8?B?dXdDcDhLOUJkSjVwMThvb2xPZ0JjbXdJUVFPQUE2bUdDd1VuS2ZHSEhJck0v?=
 =?utf-8?B?eFoyRGtCOG5wRTVvcGluOURPNVp3VVVlV2laTUw1emM3eUVuUEV6bkVzbExv?=
 =?utf-8?B?TEUzZjdjS0FicHFXU09pU1JLRklNeW0yNkhwdTJYQmd6MU1mMCt1KzhlZUkv?=
 =?utf-8?B?V0twZXc0dW5nbG1UVCt3eWpVUmp2dXAzbTVRWDRaTjFkQnVqaFRDem9vQnlD?=
 =?utf-8?B?MW9TSkQ3bC83OWhIZFJKelh3VE5QLzY5VEk5Y1ovZUdWWXJacmZFYkhSRERD?=
 =?utf-8?B?RlJoODdMejVpRnQ5WFJZRnh2dGFTL1lvd1M3NUt0ZWZFSkUzeDB1dGZ5UjNy?=
 =?utf-8?B?Q3NZRTlIWGh0VzFKY0dGR3dnMGQ5V0VaWmhDNWNmaVFycmNZQjdLb3BRV0pC?=
 =?utf-8?B?YjNlemVJM3V4YnlNbmgyTTF0UnZMeWdncE9kZ3hrNE1nanJueGsveU1oUmU2?=
 =?utf-8?B?ZXJ0RWp1TVl5YzhPTTRKWlNuMEtLMkIzTHlEcDlOdTNQRnJ6QkltN1hjcXdk?=
 =?utf-8?B?akgwUlZwWCt2bXFuV3Fja0NINkxuRnBJUlRCMUNMMDRBNU1ScjZxM2ZhNng1?=
 =?utf-8?B?RzNjU2dCeEFyN0J6eXU2Q2hyR1dUWTZ1OWpSY2R1Y1I1ZmJjMW8yWlQzMktE?=
 =?utf-8?B?Wkg1M252UU9JTEZuN1pBcTBWU1JxdlBRU3MyNCsraXNRMVR4V0kyWFNlQUVk?=
 =?utf-8?B?N25LSHNYMVdSekhSNkRidXBLVi9rK2RQNHgvUTJocFBTc1hlRzNoWUwzR05Q?=
 =?utf-8?B?bktnd1pPaGlMeWZKTmFoeXBDOGd0VmNCbFp4ZmpYNjJYVXNqMHYrbDhJbDdr?=
 =?utf-8?B?UnNNVXUvN3EvbGZ2VUlwQm5GSjdnamRGS0RYbGU3VVdIUmIxT01RVFNqZ1BQ?=
 =?utf-8?B?ZGZIWHhnUytWK2xSQUFrOW9KRUpHQ21nbmM3RzVwOS9CVlRiVmNlWGE0cDA5?=
 =?utf-8?B?QW9tODVvdGVic01EdnJMeUdNcytFSlJ6a3dlcE81cjczSUxMRm1Vdy8xTnhs?=
 =?utf-8?B?L2tnVFRrSkg1VVlzN1AwSXNPc05QZHFYcFpXSXVpVGFTV2RmcUpRY2EwU1pN?=
 =?utf-8?B?amplMFhRbjBPc21VUU1YV2EvdGZKYVpIQ3h1eUVQTS9lT0Z6ZGNVenpTZ0xV?=
 =?utf-8?B?d0Q5ZGYvMXo1eG55Y3NnekdNNDdRdWhZOENmaG5RcUtoUVFvdXk5cGNrTG91?=
 =?utf-8?B?M25SWmJrbU9WTTNjQTdvTGpiQzA2L3pKeE5kSTI0MGhrZkpWVW5wQkhYV0px?=
 =?utf-8?B?QURBUlJvVmlCaFJqSldudkU4K2pxQzhnR0JYY3RNMVNSWHZEYjJ1dlNYb05l?=
 =?utf-8?B?SnVOWXRkMGUzcEl3Sk9IUC8ydDdBeTZtVER3VDVkb2lTTzNacnFFbWVJL1l2?=
 =?utf-8?B?WWY2eXNvZnFmQkpKUlRNK1JoSHAvN1dnVnMxU29QNkZKQ1kzT3FvdE9PaFIy?=
 =?utf-8?B?UEFkYnpVeFJLQzVmS2lOY0R2dkVJZUZLSjQySlhyeUxidjM5WWZLQU5wUHU3?=
 =?utf-8?B?TzcrU2lGQ2VlVVRjRjVxWVk1U3lpK2xaTmdEZFVsRkY5UjllZlVITmJBYUpX?=
 =?utf-8?B?dkZYVURKRWdRZlB4YkFqQkxWVjh3b3VvaG1OWXpOZ1JlcXBVK3FhWVVmKzNU?=
 =?utf-8?B?MWtyQm1vQXlIeTljZVRzZ1dHTUxjOXF2ay9zNlp4QzhNSG9ZaWE3MGJ0VkpO?=
 =?utf-8?B?bHRsbVFGUzVpdXpwbWp0bFh5NGpQclFvUUNic0w3ekRtZ0lPQTloNGVsYVYr?=
 =?utf-8?B?SURvK2xiWlFDMkJDdVVDU2d3d2c3NHVvV3F5a1p3VUI1dVBtNWZFdmpycVBQ?=
 =?utf-8?B?bEpKQU0yV05VUEVtY1RBZ2FLNUsxanRpQ2tpVGE3QjAyVUp0UUppN2pDeCsw?=
 =?utf-8?B?MHh1bVFnWHVLYzJRbE5lQ2VWVG5zVFdEZ0lEZjNtU0VtMWRzQ3BUWVZDTGpn?=
 =?utf-8?B?RUc2TkJvZWdNemtVcmVRQ2VDQnVVbjYxOVFwRmRPTXJYQk85c3VXcElGazJC?=
 =?utf-8?B?WEo0ckFWSjJSWTB1NDFkVHJxTnF2b0tOaTRhU1h3ck80R2dYNjM3YVhFdktj?=
 =?utf-8?B?TWZtOEsvN2xoUm5TQlVIaDNhNWlRc1FBQlc1VFZwTytWRFdaY1d0TzZFbFpV?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E721874C2EEA4F4893CD9776CDCEB1B3@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9425fc48-1aac-47c3-0cba-08dcb5ef7d5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 08:12:18.4621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O/Phd/aLpz/mwbuCD2MeZmp7Dn2gHnXoiMFz/n+uiuuCtFF6URKpmDL3JEhOfUPxnjyXCMiioOzobBI+1wKaXF79imBQSipX4eMsyK3lDS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7760

SGkgT2xla3Npai9NYXJ0aW4sDQoNCk9uIFR1ZSwgMjAyNC0wOC0wNiBhdCAwNzowOCArMDIwMCwg
T2xla3NpaiBSZW1wZWwgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMg
c2FmZQ0KPiANCj4gSGkgTWFydGluLA0KPiANCj4gDQo+IA0KPiBJIGNhbiBjb25maXJtIGl0LCBN
aWNyb2NoaXAgb2ZmaWNpYWxseSByZW1vdmVkIEVFRSBzdXBwb3J0IGZyb20gdGhlDQo+IGRhdGFz
aGVldHMgZm9yIHRoaXMgY2hpcHMgYW5kIGV4dGVuZGVkIGVycmF0YSBkb2N1bWVudGF0aW9ucy4N
Cj4gDQo+IEtTWjk1NjdTLUVycmF0YS1EUzgwMDAwNzU2LnBkZg0KPiBNb2R1bGUgNDogRW5lcmd5
IEVmZmljaWVudCBFdGhlcm5ldCAoRUVFKSBmZWF0dXJlIHNlbGVjdCBtdXN0IGJlDQo+IG1hbnVh
bGx5IGRpc2FibGVkDQo+IA0KPiBLU1o5ODk2Qy1FcnJhdGEtRFM4MDAwMDc1Ny5wZGYNCj4gTW9k
dWxlIDM6IEVuZXJneSBFZmZpY2llbnQgRXRoZXJuZXQgKEVFRSkgZmVhdHVyZSBzZWxlY3QgbXVz
dCBiZQ0KPiBtYW51YWxseSBkaXNhYmxlZA0KPiANCj4gS1NaOTg5N1MtRXJyYXRhLURTODAwMDA3
NTkucGRmDQo+IE1vZHVsZSA0OiBFbmVyZ3kgRWZmaWNpZW50IEV0aGVybmV0IChFRUUpIGZlYXR1
cmUgc2VsZWN0IG11c3QgYmUNCj4gbWFudWFsbHkgZGlzYWJsZWQNCg0KS1NaODU2NyBFcnJhdGEg
LSBEUzgwMDAwNzUzLnBkZg0KTW9kdWxlIDQ6IDEwMEJBU0UtVFggRW5lcmd5IEVmZmljaWVudCBF
dGhlcm5ldCAoRUVFKSBpcyBzdWJqZWN0IHRvIGxpbmsNCmRyb3ANCg0KS1NaODU2NyB3aGljaCBp
cyBkZXJpdmF0aXZlIHByb2R1Y3Qgb2YgS1NaOTQ3NywgYWxzbyBoYXMgZXJyYXRhLiBCdXQNCnVu
bGlrZWx5IHRvIG90aGVycywgZXJyYXRhIHN0YXRlcyB0d28gb3B0aW9ucywNCjEuIEhhdmUgYSB3
b3JrYXJvdW5kIHRocm91Z2ggcmVnaXN0ZXJzLg0KMi4gRGlzYWJsZSBFRUUuDQoNCkF0bGVhc3Qs
IGZvciBub3cgd2l0aCB0aGlzIHBhdGNoIHNldCBjYW4gaW5jbHVkZSBLU1o4NTY3IGFzIHdlbGwg
Zm9yDQpkaXNhYmxpbmcgRUVFLiBNYXkgYmUgaW4gZnV0dXJlIHdvcmthcm91bmQgY2FuIGJlIGlt
cGxlbWVudGVkLiANCg0K

