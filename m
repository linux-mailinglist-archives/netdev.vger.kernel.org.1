Return-Path: <netdev+bounces-124229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E3F968A3C
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54AADB20C78
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14BA13E8A5;
	Mon,  2 Sep 2024 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ID0rRrhQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8901C14F6C;
	Mon,  2 Sep 2024 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288524; cv=fail; b=XV8j+H7zCHNzkV6lX0HwRTyHIPWgdyN18KyvUBGndlBnX2FC+T0NH36+DqOPflko6WzpZ2XeTMy8McIsRb6nvoNCr/AOvIU7ciDrNy+R6pn0dY8oKxx4x0tBUjYHSgI4AS9gz/ZWv0dbY/xUnuBdtdlW0wnG9NzGU8voo3KJHsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288524; c=relaxed/simple;
	bh=ChpraKziv2DOXfNzYO+5yi09MObBpwNhtkcCwv8Y/Vs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AalePudyyzuicLo5ngTLxuHULLezzXY9jqBPQ+EAE3K5Yg2+4QmK2X5cg7UrSV7jQ7+n3tEmds0pySJcBcjUvEMcq/F7kFxBamToIqi4y29mZseXQStZjww35qivhy7qo87g7e1iwiUURL2c5ceGbJF2SUYQX8r45hK1iBq/738=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ID0rRrhQ; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNEQysb29O784m84XeUp0utM7MEcxTyGpWBDeD72wVPI8DEGQXnLhaN47fo4qZ+hoDS7bxMKjjAOoWVbgBea5IbVaVQLzVEO0H+Nc7FAygwv1SY5+n2lgmY2tbnG+ew1guFxa5uTjH8LEu93oldmei+6MUhckrKbIQpspMh8Vm54nDOA6OzRsRMFiRA0J0P4IYr4erTeO8IGjdtvP/qMqfLSplcnUJoGqyjdrBDalWWfnhYnueKJukd5L8zsrjGHK0JRaCGnmLAd8dnvrLdvQ6jylcRrt7U09WqOiW50K5xYWjxkJGNcmjhoWtlQbYWHPFBqRrig9aL1f+lKl8lOdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChpraKziv2DOXfNzYO+5yi09MObBpwNhtkcCwv8Y/Vs=;
 b=fLcrJa6sq15U7hamQYuJrF2gAqwtWgSpfidCYoKwhFPotIK2PkJd5ealILUDrYuuZrcq452pqrxOs5qtnmTmrtrb5cindLsnVC9uGn6ugIgN1oPObwEOmqTgw3cwVSRd0waaLLaSfzbVDLQja2S8P7EQ22wzBwbp+910l4dvYIdtYfzKAbimX+aHz2ehxDWQaDmHeZ3MvXK7Vat1YOoXOBe8Gk9onHKM4pJbo2F0pBpC5Nknr6kd6Jq+sYDa9ADl3IxoNaGoqR4C3caPg+u8T/6K7eth2RhC4lgtoV7sgjABg8jIROShgGbTKb7aCs0SMiYOrDgRkftRUsxo1XbJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChpraKziv2DOXfNzYO+5yi09MObBpwNhtkcCwv8Y/Vs=;
 b=ID0rRrhQuWxSAJ2i2/mjNoBXvPFFKK09f04FzeZD1hjCQu9I5HqsYSQfx+eQBfjjemn3yZgb2PTfYCt9DKQGVL3XC+cxkprhnCkrnqfiLIh9RtFq7Q3+scPHRmOK+tV1n1kDgqA4d+0i20YBHAyrvjozTzun/8h4R44e1XPi+KJ9jRpnh17lwTXq40KMqO9CmVRThIZMX1sLCz1lcwO9tXW7xbRXtQXqc/WszIZ1twr8IYE9bt5sgwmFFTE0UKsDOX+bIG9h1OzwD3q6HaJcTQ6s+TFQH9IEgVA1ISkptdxYUFy9YAhfOYdJSZ1BXwZ0y3K+2Bl8n0Vj0utfMVBfHQ==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by MW4PR11MB7055.namprd11.prod.outlook.com (2603:10b6:303:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 14:48:39 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%6]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 14:48:39 +0000
From: <Arun.Ramadoss@microchip.com>
To: <vtpieter@gmail.com>
CC: <Tristram.Ha@microchip.com>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <Woojung.Huh@microchip.com>,
	<linux-kernel@vger.kernel.org>, <pieter.van.trappen@cern.ch>,
	<f.fainelli@gmail.com>, <kuba@kernel.org>, <UNGLinuxDriver@microchip.com>,
	<edumazet@google.com>, <o.rempel@pengutronix.de>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 3/3] net: dsa: microchip: replace unclear
 KSZ8830 strings
Thread-Topic: [PATCH net-next v2 3/3] net: dsa: microchip: replace unclear
 KSZ8830 strings
Thread-Index: AQHa+ubDwewIOEWJBUyTMdMV3/rdT7JD3EgAgABvtgCAAE1EgA==
Date: Mon, 2 Sep 2024 14:48:39 +0000
Message-ID: <cf9cb15d13e114cd8c361e4d411efe392b74711a.camel@microchip.com>
References: <20240830141250.30425-1-vtpieter@gmail.com>
	 <20240830141250.30425-4-vtpieter@gmail.com>
	 <efce22790603dff9cff21eaf39f74b6a4b5d4a97.camel@microchip.com>
	 <CAHvy4ApNq69g9edtmgUne4k+_P5T0xYOS-WaL5QWZin50+MMrg@mail.gmail.com>
In-Reply-To:
 <CAHvy4ApNq69g9edtmgUne4k+_P5T0xYOS-WaL5QWZin50+MMrg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|MW4PR11MB7055:EE_
x-ms-office365-filtering-correlation-id: a7c1deba-53f8-4dd2-d375-08dccb5e54e6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dnZrSStHeDl0MUZwUi9Bb1N2b2dzK2ZDYkZMWEM5VWhUTVZnN3RnR3VmV0RL?=
 =?utf-8?B?TFg3R0t0NnJsMkQ2RjBQNTBSS1p3T1VTMmpQaXBhbmNJdXhwL3ZwMml1c2lj?=
 =?utf-8?B?VjFhM2VGSm51VlhUL2NzbVJMaFJMYXprUWZqRDI5RTlYd2UzaEV3SWtNSTQv?=
 =?utf-8?B?SEloa243S0paNkVyMk80WmYzZU1sV1hJMDFuNmNHeUJxRFczV0NDQ09nOFVL?=
 =?utf-8?B?ZG1EdGFKTGNwZFhiZzhEb3ZGMVJCdkM0R1dkQnZoL2prV3c0czNSRmlMSVZz?=
 =?utf-8?B?WjB5MnpYTitrOUpiWUZYQVo5Vy9lSkZTV0ozYzFTRXZQZ09ZNUEzSzZ5bnZV?=
 =?utf-8?B?cjhMbWRvMkVaQkh2THo4NVJ0SmM3K0RJNDJ5NTFtcjJrZEkwQnRVZ3RlWWVG?=
 =?utf-8?B?TkM5KzdvODBaK0dtbU9LR0t2eDVGc1h4RDdtR3hsZjFoZ0ZtV2lVSlovQ0lm?=
 =?utf-8?B?anIwU2luUHplMEx0a0hFVk5MSHlvLzlLVmhDN2RiSERqWmtMZGgvVVkwb3hs?=
 =?utf-8?B?cHJ4WTJ5VC85SmZ5ZDE5U2xxZUltSE9ZTS9CTlovaW5qNytKSTVTTUxmOXBM?=
 =?utf-8?B?aFVxYzB0NCtrcCt4V3U5dUJqRkpBRUJnSFNxMzlkOWFIaCtyWDlDUDNkdEp4?=
 =?utf-8?B?WE91RlJsVUlHbDNVWm5aNnFjMFFpYnUvM3d5bDgrbGt4Rm9RR2I0b0k2clF2?=
 =?utf-8?B?b1U4TGVHd0VZQUJhdGEwYUpzQjRMa3VVcWRpZEltSkdBRmxnTEphRVFwTS82?=
 =?utf-8?B?cUdwYW9vOXFRL0FPdENwQ2NMWkdPWEdneDNSK3YwSU10eE9icDRvQXNjbjVa?=
 =?utf-8?B?aFZkaUZ3V3lYeXRlYXF3Ny94OVgyYklZaEo2L3l4S2lKazRidDJobXBhVnox?=
 =?utf-8?B?THp1RkZvLzRiTnkwOHJjZ2xkaE1hWmJzeGxlbkZNMHJzL2NmSTZOUGlldFlq?=
 =?utf-8?B?SlYrQUh1SXNZMzFiYTB2WVVjZVhkTHh0b044dHJWTEpLcWF6TytJaUhtci96?=
 =?utf-8?B?Q082Q09GWm5JVWhzaVBLd01yaUU0MzFLZzJRUm5aUllkU0liZms2MjQxaU1u?=
 =?utf-8?B?VnNKNzlnaU9tMmYvZWJ3QTJ0cmNYSkNmS240VkIwbWRzNGJOa2VEeGFyZHFz?=
 =?utf-8?B?TElUbHpRL3JTYmF1U2Y2UzRwUWhFK3pnMHFJVVpvVmlOeWhwTURiRTFVZ0o2?=
 =?utf-8?B?cW41NzVnd1BkNlFkT0RwWC9IZVdrQmZZb3JjaE5XRVZBK0pYYnpxTFRrQ0Zp?=
 =?utf-8?B?UUxtUWJXNVJNVlozYTBHdGNmWDE0MTFwV2ZRY2R0dHFmMlErZkhRYngrVzhN?=
 =?utf-8?B?YWhsZ3grMUF3TzVQQTFRd3RjYTFUaWhxMWZZOXdBd1BuRldnZVBwQ0k5UkVr?=
 =?utf-8?B?K01jRUFSNWpNMTNOcnpQWjdhbDltaUF6M3NCZFlVTTdCM3JKcUJEUGRvV0pD?=
 =?utf-8?B?R0dwb3RPZnZuUi84NkVtYkFLNnNIVHVsTkNVWExxTmM2V0puN1Z6UVhEL2xB?=
 =?utf-8?B?clQyQklZYVFOYmlWNWltRjVoZmwvWWxvSnlwT3ZLZHRsWlUxNTZWRHB4RlB0?=
 =?utf-8?B?enhJckJ3a09McGgvWUhWRDFCZHhpbXJFSXhPTjhhRGoxYWN0eXlITTdRL1Vj?=
 =?utf-8?B?WGRFTW05WThrejVWcEk2RTk2SzZqZURPY3ExYXlkMEtrQWV2R1JGRmN6cW93?=
 =?utf-8?B?UWZ0NldSM2tCeDdOZ3ZXeCtjVHdFNHFBUERMRmtiejRFdkRQTU5lTmJXR2hx?=
 =?utf-8?B?ZDlLVXgrZXptS3NkSS9yN3UxVmE4TTFGekYvYlFUYlZyQmsxV1JpT3Rza1Qr?=
 =?utf-8?B?Q1BxZGtWU3dGQTd2eTV2aWVUMkRpL2NnaGNySlkwZzZOWXVZODI5UjlRbEJD?=
 =?utf-8?B?ZFpXbmEwNVNLNnpLOXVlNDdHYlRkZDdScm1LSHMydk41QWc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Uk1hYVZRZzM1TkFvMDdQSXBaSWp2eHlvK1hHbVBsYkZ2ZHlVaVRjc1dITElD?=
 =?utf-8?B?emk3eHEvU2lLNGEyaVduYUdwenZLQzRsSHVmYzVJcDdPdVRMTE95cDNjMW5Q?=
 =?utf-8?B?ZTFMYnJheE9raVhyMWhaeTVPRXdwc0E5YlZVSmVKRC9ZRzJCNVZLK2k1TTRm?=
 =?utf-8?B?Q2ZRQmpHTkRRN1ZTUFNMb3ZJa2l0MzRBdElqZWpORlRYVGwwYlV1TW9ud0Y2?=
 =?utf-8?B?K0NSVU52RFVXbk83R084YWRudGZDVlJFakI5K2VORWNBZFFBUGsyZmNYMnNC?=
 =?utf-8?B?MExPQkhNaXNURERWcmx5dkptVWt0RjkxbmNESmMzUmNFaW5qZ3RBRXl2bndp?=
 =?utf-8?B?Vm0rRXFHaGd1Tzl5UWJ4OWtNcXJiZEk3TkQzaE1mTUZPOVhHTlRxbWxLcU4x?=
 =?utf-8?B?M1R4ejBXdHpkelVSK0xQTERneFkxbDd1VTI4QmxoZy9WT3NqOFY2NzVBdVpO?=
 =?utf-8?B?amxVYThCSmtmUzJBRnVzVWN0Zzl5YnJHZTVJbkY3TlBpT01LVGJRUmgwYkFW?=
 =?utf-8?B?N0VHUDcwMWxwcHAyMUZUSmJ0L2V4TWJtRjdKRjVSTkY2Zk9nUlo1R05nZ0Rl?=
 =?utf-8?B?RHAxeUJUWGpsNFd3cWQ0c25nUVkwbkgwbVJ6ZFd4OVk2SnBheTN3eHg0WnRI?=
 =?utf-8?B?WjJWenRPNWhtUFIvbVZvTDNmUWt6Qm45RmdZNlBBMVZSNC9NczhXSEkrVlM0?=
 =?utf-8?B?UmF0WFBpVXlOV3NVNk0yTnBsclpBMnZXOWtGU0I1TlFlWVlnNlFRMXM3VzVi?=
 =?utf-8?B?NEZhVlhCVkdvdWpIYlRzTFIyektWMkZBcnBEN1lOTEd4S3JHc1p4MDFrK21K?=
 =?utf-8?B?QndrTmtmSzBaRHY4WlJ2NElGbXBSdE1WZHRPbVNITjhRWFZmdjVDR3FkNlFU?=
 =?utf-8?B?REVlNHlaQXdERkVGVld6VGVyKzgvdklFTGR0dTNIQmR3SkpQc0hxY3AwS2tY?=
 =?utf-8?B?azlON3N0R1JSV043SDdqRWh0VXRhQlhLR2U4V01UWTk1dXFLbG5GZFBoS1li?=
 =?utf-8?B?QmJoQjV3V2NPYk5zQmZ4QjY5WmpDY29FSGh5QTJKOUJ4K3kvN1loaVFhR2lp?=
 =?utf-8?B?L0FqZTRmQUhhdjZDUE94VWdob0cxdW1uVEVuQkloeHhEUHZnWHprM0NLWDBr?=
 =?utf-8?B?VFJpVWRqR2VhNUVCTUJiVjFWQVJqblhNNTdGWGtETWtiZFo2MUtMaWFuUkxm?=
 =?utf-8?B?Vzk1TzFta1JnUVQzdlNoOFk3aTdIc0ltN1psbzRESmFHTlNTM3JlK0FFZ2tS?=
 =?utf-8?B?cWpyYjdacnc5SGdoMUhwQytjb3BqV0w4U0NXKzl4NS9zdENXL3ZaOWhiTXZX?=
 =?utf-8?B?cWExa2YzMWJrV1VuZE5EQUh2UmhUK1lZN1VqbXlaOUFMTG1KaE9DLzlKdVJx?=
 =?utf-8?B?VjkyZWV1SnBHZU9adUg5S0J6Wm5YWFoyMkZ6QlpESklYNmkxK0lSU3ZVeTI1?=
 =?utf-8?B?YmVjRVh2Y2xEa2wzSnlYMUsrb01zRGZFK1R0L2xHeDBLLzJxRDFKSXVJNkdD?=
 =?utf-8?B?dTJJd1ZSZkFjcmNZK1dsdTgxK1FPMzl3SDU4ZUVmallBeEhEQmZrNXkzY25H?=
 =?utf-8?B?eFRXZ1lMUWgrbEd1V0Q5d2ZXdFVzWDIvZ1k4SjEyYTU4dGw4NzVMdWh5Vm9R?=
 =?utf-8?B?R0ErMmZTeTNBWU9tSXB0NW4wRTZhbG9DWldETFMybkU5bFJHSW1hZjlDZU9V?=
 =?utf-8?B?bDc0c2VuNUxhekMzOGp6bW1TenpvUjAxWkludSs2d2RZcUlpeXljUU9tcXRG?=
 =?utf-8?B?VXAxdHdiVVVSdVNyMjJiZlVLdnJvNTF5dEtpTlRlRE9xU0prVDlFMWoyd2pV?=
 =?utf-8?B?bnUwdEYyaGRxRTI1Sm5aVEY4TmdVNC9EdnY0cFVrVk91d2JnMGFuSUprNGEz?=
 =?utf-8?B?WFZmTU5HTUlEa0JqM1pJNW5wQlZIVUI3TnRQOFFXTlNvV2tsNnAzOWRKUU5Y?=
 =?utf-8?B?cDJsRzZOMVpmQ1FFREtlemZydlhLOWxSYTBNYUl6cnlIajBXbEVDdE9VRFNy?=
 =?utf-8?B?bVdaVlIralRiVnQ4NXRrbFliU04vWFludDJjNkVkMVlMVDRnSWl4RkhRV0Nr?=
 =?utf-8?B?Si9BdHV6SWxyY0NjTjJUOEVRK1kvbVVDK0QrTklsUVhqcC9RVXlDYTQ3ZGg1?=
 =?utf-8?B?R2tTeTdVYXZ2WnpEa3Y3MVdDN3g4Y0hUYjBJeXJxL1dQZDlNN3ZoQk4xRDYy?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A93F23130C4C74898A7997FC05EFFF0@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c1deba-53f8-4dd2-d375-08dccb5e54e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 14:48:39.1228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: borexdjJi/quBLrejpl6BjC3RtVE05RQ/DtzLQ6O2lz5GjP/2BEO34eetM3kW8aucGzqXLZHO4VPiiAhtcAAOCmdaFJi94Rs5HZVbUR2puk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7055

SGkgUGlldGVyLCANCg0KT24gTW9uLCAyMDI0LTA5LTAyIGF0IDEyOjE0ICswMjAwLCBQaWV0ZXIg
d3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkg
QXJ1biwNCj4gDQo+ID4gPiBGcm9tOiBQaWV0ZXIgVmFuIFRyYXBwZW4gPHBpZXRlci52YW4udHJh
cHBlbkBjZXJuLmNoPg0KPiA+ID4gDQo+ID4gPiBSZXBsYWNlIHVwcGVyY2FzZSBLU1o4ODMwIHdp
dGggS1NaODg2Mw0KPiA+IA0KPiA+IFNpbmNlIEtTWjg4NjMvNzMgc2hhcmluZyBzYW1lIGNoaXAg
aWQsIHJlcGxhY2luZyBLU1o4ODMwIHdpdGgNCj4gPiBLU1o4ODYzDQo+ID4gaXMgc29tZXdoYXQg
Y29uZnVzaW5nLiBDYW4geW91IGVsYWJvcmF0ZSBoZXJlLiBJIGJlbGlldmUsIGl0IHNob3VsZA0K
PiA+IEtTWjg4WDNfQ0hJUF9JRC4NCj4gDQo+IEknbSBhZnJhaWQgdGhlcmUncyBubyBwZXJmZWN0
IHNvbHV0aW9uIGhlcmUsIGl0J3MgdGhlIG9ubHkgY2hpcCBoZXJlDQo+IHRoYXQgY2FuJ3QgYmUg
ZGlmZmVyZW50aWF0ZWQgYnkgaXRzIGNoaXAgaWQgSSBiZWxpZXZlLg0KPiANCj4gVGhlIHJlYXNv
biBJIGRpZG4ndCBnbyBmb3IgS1NaODhYM19DSElQX0lEIGlzIHRoYXQgdGhlIGVudW0gcmVxdWly
ZXMNCj4gYQ0KPiBjb25zdGFudCBhcyB3ZWxsIHNvIGAweDg4eDNgIHdvbid0IHdvcmsgYW5kIEkg
d2FudGVkIHRvIGF2b2lkIHRoZQ0KPiBmb2xsb3dpbmcgYmVjYXVzZSBpdCB3b3VsZCBiZSB0aGUg
b25seSBkZWZpbml0aW9uIHdoZXJlIHRoZSBuYW1lIGFuZA0KPiBjb25zdGFudCB3b3VsZCBub3Qg
bWF0Y2g6DQoNCklNTzogSXQgaXMgdW5kZXJzdG9vZCB0aGF0IEtTWjg4eDMgaGFzIGNoaXAgaWQg
MHg4ODMwLCBTbyB0aGUgbmFtZSBhbmQNCmNvbnN0YW50IGRvZXMgbm90IG1hdGNoIGVhY2ggb3Ro
ZXIuIA0KDQo+IA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvbWljcm9jaGlw
LWtzei5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9taWNyb2NoaXAta3N6
LmgNCj4gQEAgLTI3LDcgKzI3LDcgQEAgZW51bSBrc3pfY2hpcF9pZCB7DQo+ICAgICAgICAgS1Na
ODc5NV9DSElQX0lEID0gMHg4Nzk1LA0KPiAgICAgICAgIEtTWjg3OTRfQ0hJUF9JRCA9IDB4ODc5
NCwNCj4gICAgICAgICBLU1o4NzY1X0NISVBfSUQgPSAweDg3NjUsDQo+IC0gICAgICAgS1NaODgz
MF9DSElQX0lEID0gMHg4ODMwLA0KPiArICAgICAgIEtTWjg4WDNfQ0hJUF9JRCA9IDB4ODg2MywN
Cj4gICAgICAgICBLU1o4ODY0X0NISVBfSUQgPSAweDg4NjQsDQo+ICAgICAgICAgS1NaODg5NV9D
SElQX0lEID0gMHg4ODk1DQo+IA0KPiBUZWNobmljYWxseSBpdCdzIHBvc3NpYmxlIG9mIGNvdXJz
ZSwgd2hpY2ggb25lIGhhcyB5b3VyIHByZWZlcmVuY2U/DQoNCkl0IGlzIGNvbmZ1c2luZyBsaWtl
IGZvciB1cHBlciBjYXNlIHJlcGxhY2luZyB3aXRoIEtTWjg4NjMgYW5kDQpsb3dlcmNhc2Ugd2l0
aCBLU1o4OHgzLiBJTU8gaXQgc2hvdWxkIGJlIHNhbWUgZm9yIGJvdGguIEhhdmUgdGhpbmdzDQpj
b25zaXN0ZW50LiANCg0KPiANCj4gQ2hlZXJzLCBQaWV0ZXINCg==

