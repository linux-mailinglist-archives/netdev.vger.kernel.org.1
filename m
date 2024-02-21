Return-Path: <netdev+bounces-73544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B50FB85CF74
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 06:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE521F21A10
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 05:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF4839AC9;
	Wed, 21 Feb 2024 05:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="g7RYOFQg";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0WW8EOJe"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1CB38F94
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 05:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708492529; cv=fail; b=hd/sf8XC+dn0Q/o8h62zLuaNtDuYjTqowTJJ3YwsaZPQgYlXke/rOjYmteJxoBiggIujhWD8sIRaU1wPMvXUSF094Uv8qoR8MyTsmynYHIwSswlvZAnbVIlorqvdzjOCU/vPcAYvnyxH9oaMiAzEvBU0CGZmehggUYZNSTgALJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708492529; c=relaxed/simple;
	bh=JnJJ8d55RjGzBfyJJ2+VIoAHUAJ3Qs+bM3bhQs2NK9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E/vYLmJhc5uFPPl1+Tp5sihFhxBQvBOsHHZD9EXxSxkU4LoJQa3f4uwoml0kIPzs2MWqHyypQbpL0/hA3STvrsspiPQRqE5Vdw5CM7aaTWjvnsFfQiHAgBI1He1ChaRMPgFElu98e4rabos3844/wbYmymre9R7bxxmGaG3sB7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=g7RYOFQg; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0WW8EOJe; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708492527; x=1740028527;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JnJJ8d55RjGzBfyJJ2+VIoAHUAJ3Qs+bM3bhQs2NK9w=;
  b=g7RYOFQg7S788JF1fax3z6CajToYjVE8yG2gSFUrs3VZsDFBXIot2Cj2
   TBeSmQcAIUVRNLXQ8QwfaRu9bvIrcPKGaw87wF55k8zU4H8msTdArk5v3
   5V6TrAbXOJLAXs/1W/YJ1rqGAENV9C360PFfhPCQjH+Fn6+Wlzzkn9zex
   9BPlHlPFi+xBKvJMo3uKkzmB/PaL+AfVH86a1EfN4SPn7qmksPWC715Xa
   zK8aSHJmcoHDxDpbGahS6cfGiBr9FD0IDjrs5vPnLafH+RalN0VhQPd+P
   9GPaCRN/tl1h/FHB22rbNa7AoC0AiaZ/r+ZXinmHFX3SWu19JVa5h5sKf
   A==;
X-CSE-ConnectionGUID: IYInKOs7T8aoVIjZgNbAyg==
X-CSE-MsgGUID: 8sYNfOS4RkWPkGylR+AuJA==
X-IronPort-AV: E=Sophos;i="6.06,174,1705388400"; 
   d="scan'208";a="183843915"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Feb 2024 22:15:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 22:15:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 22:15:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCzowrW9MaVVd6UgscvWjtYya1yqISH776YMLjJY2bb46VnzIKOwp5vxtOWKgxA6+f7trq4fmOEvU8tJi0hhFuDe2Hj3AZAqUEXyFsm7aouri4SMdapdyQ5Ml3EYZOQntur7E+GwuSGNZ2bpuEa6B4Ev/UDmdtcAtcNrxnMJbLLLE9sHuEfaCQsvq5PX1C0kIPplQ5FObTwsaSkEfegIA/fma0ek8tVblnh0EQ9IKV18MfNuKgoAUbFNlhfuDIS4KqYJB3QRWOFsUNF3yFh14Sawwxa27ToVacqBnZrfNFlbDsMg5CmfNeyyaM0mW2ParqPB32FEVfHorOhra6rCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnJJ8d55RjGzBfyJJ2+VIoAHUAJ3Qs+bM3bhQs2NK9w=;
 b=npSaseQv3CUavcWQV4JVe/I5Fwcrgagx51754P721s5z8xR1mt0+4HTEPk8Rx7mCak4+/EFhgovoE9h/l2NSjiALMs+FCqTfsghmoThO45HRLDWZje8Zk3eaH9vl4gGSqul7u8X8pc9RwJR3lyq5YV7jYidAQf0UbSde6lGH+VK77lXwnZtS1eAfI1X3DMhW2td08UwVmzUTF3JYK+VC3K76n+nkeFMcJYac+9Y2xbNgcH2L0cypsHp0U7/RsW8w6FMlK2NRWJEvwdoHFxlwkTlQB8RgzfQK23bzfbJRCAJ+XIknJQ6wlcg3zmjTwxZt4zpjKlwzrJl8rWxFMk9i1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnJJ8d55RjGzBfyJJ2+VIoAHUAJ3Qs+bM3bhQs2NK9w=;
 b=0WW8EOJenysiWd7sBO3z7rG02Jzc3jkxk51sy48AG1lrKqwO9tKTu2BsSzWJLYF3a8pKFt62OAfejANrf8QrljWtaXq9t56E0iWFr6vtoW0qF+1VCW/sWEnae55Vgagh9GUWnhZ+iBCtHq8RQqipvqUoTXklxRXtO3UijdqkbK+xEYFHqZobxGbrmke4L2nkW+n8KHgSdWeMuLGc18Qkqe32h6QvrCGQymiJODRtyUuw/yn0W635u8EElLfb622flylKclw1Ak8aIqqAr3GD4CQQIvMp71SSzuoK73H10IdYo8ps8ELNYtcBtE/p0KSToGo2GF+7Q/1zpEyKS80Big==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DS0PR11MB6447.namprd11.prod.outlook.com (2603:10b6:8:c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 21 Feb
 2024 05:15:04 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::51c7:3b29:947a:9e39]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::51c7:3b29:947a:9e39%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 05:15:04 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Steen.Hegelund@microchip.com>,
	<netdev@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>
Subject: Re: [PATCH net-next v2 0/9] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Thread-Topic: [PATCH net-next v2 0/9] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Thread-Index: AQHaBcg0J9X87rlKy0y2G/CzXLB1SbEOPx6AgAPmdICAAE9bgIACiV0A
Date: Wed, 21 Feb 2024 05:15:04 +0000
Message-ID: <cbfbf3f6-45b7-4f40-bc05-d3e964e55cc7@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <1e6c9bf1-2c36-4574-bd52-5b88c48eb959@lunn.ch>
 <5e85c427-2f36-44cc-b022-a55ec8c2d1bd@microchip.com>
 <e819bb00-f046-4f19-af83-2529f2141fa6@lunn.ch>
In-Reply-To: <e819bb00-f046-4f19-af83-2529f2141fa6@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DS0PR11MB6447:EE_
x-ms-office365-filtering-correlation-id: 3d05bf19-5130-48a5-1979-08dc329c1026
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WD78iTPUysZcvsNSddWbciD6/8lz8YXphINkjrzrVwg3ayG0geaPdQYjIW8+ucqcwpyPUMrI0g/US+m/XbtlEcr5Qm8OJTsvVGX5FSf+R7/pCK2sA0tNIhoX+TtzA5nYG3FgVWERAUfy7j3XhYdFBEUNyyoZ0JIGYKTyqGx/MSiBaF/USA7RAWHTrR/k335VrqzCP7F72RRFOQxc9orenYNH4DvyPlM6bjxohniTqriZ4NnHgrxm89H9J4dgt6OzYZFxU6fu8h/I3uS+uqM55VgjybvYMCAJw/2SJyz8cqxZg3TuQBq0aZJrUuOqR1rK34mL1UE7hfMF4llk3id3K8xQu1N9bLSOGDm5OG05I+nTAPo/ZuC+Y8YK7RHcs0bRRGep6UVLmUlAM1883bMXXls2s3oIvBQuvHsjQTjPiuuAyX5eG/p1js7nDYxW0S9PBtFozyD9KzxfTfCvUG8dP9launqSWAp69luq3xM1ygPO2teZJzJeOV45/Fbq5EcDejvh5VSydDU7mylOtMOSI6mIGoQ8QxiGxe3KIHsc9H2tF9e6BT4dKI5KjsfDUkSUye68ZDxXEjZwRyjeN0usUXmSFxBejmIbrjAQa4BwoFSth9xSbx4YruGqpNWdhbRr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE5vTFh0aXlWSHpweXJLQ2FiWVFVSm9IYnFVMkdsd1J4UlU5UmZ4Mmp2Zzgz?=
 =?utf-8?B?WExoN3VMTDcyc3MvUEo5UEU5Y3h6THliZkxsNWtMMTduZlJIRkhZVGJiZkJw?=
 =?utf-8?B?TmkvTjk3N0EzQm9FWGJFMWFCQ2hJNCtnRmFNZWZQVmZpLy9lc1V2cUNaMURX?=
 =?utf-8?B?QmluWFZSUVNxNjVYNlVCK3BZRThsVXR3cllpeVFoNXlJbTA1M1lUcnVuL1hx?=
 =?utf-8?B?VXcyNG1nVFpJeHEwcDNYYWY0NDVIcERneGI3WUE4MVZLb1dabzNud2xLSkVh?=
 =?utf-8?B?N285VzkxTzRyZW9xRDBrR3dINHhNKzRtbitneGlVYm8zR1UyY2kxSHUwYjhn?=
 =?utf-8?B?eWNGSm40Tzl0S0hLcmVkb3Zpa1BjM2JKMjYwWGs2NER2VGhrRlJaTnRJclps?=
 =?utf-8?B?TEh6bC8zeTBsYURiODhkREtKRUkrOFV0R21vZVN3ZnFpS29CYVEwenpFc0lx?=
 =?utf-8?B?R0ZUMDBrcm5haUlPbnl5aUlmREV1R21LV1hkdWhPNEZlWktvcnhDbStvenlQ?=
 =?utf-8?B?eldzVkRiWXhoT1ZIcDVSUVNrSzk1NjFOVjR6MCt1Z0lFVlJRN2hXdStPd2V3?=
 =?utf-8?B?YVduZWJ3RjZwSEZIR01mYktUSkcxSmF3S2NPNGp4b093WGdIdTlhSm9HLy83?=
 =?utf-8?B?MHRNZ3BnelpIc3lMdlN4NXRaQ1UvbkhCRThseWdaNEJYY09PQkFuYzJMTW9X?=
 =?utf-8?B?VmNtNkF0UWlzUEh6cHJjcThDcVltT0l6V1YzdGJ0dWhVSTVQNkZ6ZFNWbVYr?=
 =?utf-8?B?RWxkZWRsTnMxYlJ0S0l3Qks3bHVYdS9VTDRxMFQ1QWtad3BLaGlpN1dhUVpx?=
 =?utf-8?B?MVQvYkduNkp3Z3Y1TU1wZjV1Z0duT2NSZmpDYjhzdmlZMEk1aXBSNUZ6UXJx?=
 =?utf-8?B?UDJiaFRzQ2dzSVlydk9UZkJWdDY4V2QzVWZFRTdKME9PQzBzVmYwRDBqcVdE?=
 =?utf-8?B?eDcrQjd6N1RhTnRSYTRHUk1lUlBRRlJyYjE4ek94cHhPdkQwcjVSR0lqbHhw?=
 =?utf-8?B?cmNPVVhBc0lZYURwSk90aU1OVjJqZGM0Z3k3YzNzemN5RmJWSkZjaUZ1eW9H?=
 =?utf-8?B?b3dUbUZmaC9NRkI3d0J3cDZpWk40NXpjZW03d2lPRTJyWVhZNHkrRkN2bzBS?=
 =?utf-8?B?R3daQ2MwUVBzdGhBb0QreHErVXZGaGlJclBNZ2ZONnYraG95aXh5bmtrN2FE?=
 =?utf-8?B?N1AyTXltYnFCblZPN0FteHNwSm5JZ25uNE1jcE9pOTJMK2NTZVBrSTBhZjlr?=
 =?utf-8?B?MFYwSnpqUlMwWmtuVzFvNXVoL1dCTkJOR0dSK1llV3crakpKLy80UHRFZ25Z?=
 =?utf-8?B?SDFHZTduVHpPS2d5Z0NpUSt0VjMvQmJpVGlBMVdQSU0yTUJWOXVrYmYxUU9x?=
 =?utf-8?B?SHVVMWE3bmxrSklMMVZBQjBvbjRKMG5PTzNrY1FLQng5U1pLWDVCY04yeTVP?=
 =?utf-8?B?SnJZd3ZQV0p3ZmRwV3pJRFFKSWZERWdLa1VONnNFNTc1dDhQc0ZmUlI5dGV2?=
 =?utf-8?B?MndKYkl1dFJPc3VKOUZyTHE5REpIeTNURjdLQ1psOGc4TVIzcnpXdCtDVTY4?=
 =?utf-8?B?R1VkQ2JGTHl6RGZadngwTUhLOEplNk4zRkNZZjVSckNGWkpxelNIOEVIRkFK?=
 =?utf-8?B?S0JUNVFHTytIc1JOODFxQnVTT1NnQkhTc2lBTWQzdHNZUXlXVzBYcHFuZHE3?=
 =?utf-8?B?dE4vYUx4ZGpkWDNLbHhTSitDRlFTUlo5ZUQ3MHpHSzZzQmRjWlZlTE5nemdw?=
 =?utf-8?B?dHpCc3M0V1lOQ2hsSFhKMFgycUlRS05SUHNZNTVRK083Y0Jqay82ODVXaHZa?=
 =?utf-8?B?K1l1WnhHOTdiWW9VeGJzdVZWT1B3K0pObVprV05ra3pjdWxSN3FMTVFGSUMr?=
 =?utf-8?B?ZENMUCtuMUVrRXVzNmVoVVJzMlJSVU14OVhwdUJScjdnNTVuVXB6cXJhc2dX?=
 =?utf-8?B?aE5NUURkMXAzYXRleHhzQ0JaK2dZc2ZQQ2tmcVVnYVNxMkFJSkdBdFZCMW56?=
 =?utf-8?B?L1pOWFE0VE5UaldRY3kvWjYvbTk0SUEwcklqZVdha0pqS1JqTmE2TkxselZ0?=
 =?utf-8?B?MFFUdlhuSHRZdTdJcnBRWUh2aG9BQitiY3h1aGQ1dFphTlFXRFdWTHRSNklq?=
 =?utf-8?B?SFZYbE4zUVhRRFdvdHN6elZjU3p0ZjczMnZNenJWR1ZrbzNtWFRMNmpIS01X?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2579A14309BC744CBF3B18E0B2D5FB52@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d05bf19-5130-48a5-1979-08dc329c1026
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 05:15:04.6749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xDWvgTGTYaHEPvXRUe64ruMgbbiD9PrtM/0eBYqFJA93zo6iDny4MdmcrAe7I03NQQynVD8bLJLpi8WzLaRjtK80+5C4SmVjm5uzlgofojMcYHRNkTj1OH+ZIuKn761I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6447

T24gMTkvMDIvMjQgODowMCBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4+IEhpIEFuZHJldywNCj4+DQo+PiAgIEZyb20gTWlj
cm9jaGlwIHNpZGUsIHdlIGhhdmVuJ3Qgc3RvcHBlZC9wb3N0cG9uZWQgdGhpcyBmcmFtZXdvcmsN
Cj4+IGRldmVsb3BtZW50LiBXZSBhcmUgYWxyZWFkeSB3b3JraW5nIG9uIGl0LiBJdCBpcyBpbiB0
aGUgZmluYWwgc3RhZ2Ugbm93Lg0KPj4gV2UgYXJlIGRvaW5nIGludGVybmFsIHJldmlld3Mgcmln
aHQgbm93IGFuZCB3ZSBleHBlY3QgdGhhdCBpbiAzIHdlZWtzDQo+PiB0aW1lIGZyYW1lIGluIHRo
ZSBtYWlubGluZSBhZ2Fpbi4gV2Ugd2lsbCBzZW5kIGEgbmV3IHZlcnNpb24gKHYzKSBvZg0KPj4g
dGhpcyBwYXRjaCBzZXJpZXMgc29vbi4NCj4gDQo+IEhpIFBhcnRoaWJhbg0KPiANCj4gSXQgaXMg
Z29vZCB0byBoZXJlIHlvdSBhcmUgc3RpbGwgd29ya2luZyBvbiBpdC4NCj4gDQo+IEEgaGF2ZSBh
IGZldyBjb21tZW50cyBhYm91dCBob3cgTGludXggbWFpbmxpbmUgd29ya3MuIEl0IHRlbmRzIHRv
IGJlDQo+IHZlcnkgaXRlcmF0aXZlLiBDeWNsZXMgdGVuZCB0byBiZSBmYXN0LiBZb3Ugd2lsbCBw
cm9iYWJseSBnZXQgcmV2aWV3DQo+IGNvbW1lbnRzIHdpdGhpbiBhIGNvdXBsZSBvZiBkYXlzIG9m
IHBvc3RpbmcgY29kZS4gWW91IG9mdGVuIHNlZQ0KPiBkZXZlbG9wZXJzIHBvc3RpbmcgYSBuZXcg
dmVyc2lvbiB3aXRoaW4gYSBmZXcgZGF5cywgbWF5YmUgYSB3ZWVrLiBJZg0KPiByZXZpZXdlcnMg
aGF2ZSBhc2tlZCBmb3IgbGFyZ2UgY2hhbmdlcywgaXQgY2FuIHRha2UgbG9uZ2VyLCBidXQNCj4g
Z2VuZXJhbCwgdGhlIGN5Y2xlcyBhcmUgc2hvcnQuDQo+IA0KPiBXaGVuIHlvdSBzYXkgeW91IG5l
ZWQgdGhyZWUgd2Vla3MgZm9yIGludGVybmFsIHJldmlldywgdGhhdCB0byBtZQ0KPiBzZWVtcyB2
ZXJ5IHNsb3cuIElzIGl0IHNvIGhhcmQgdG8gZ2V0IGFjY2VzcyB0byBpbnRlcm5hbCByZXZpZXdl
cnM/IERvDQo+IHlvdSBoYXZlIGEgdmVyeSBmb3JtYWwgcmV2aWV3IHByb2Nlc3M/IE1vcmUgd2F0
ZXJmYWxsIHRoYW4gaXRlcmF0aXZlDQo+IGRldmVsb3BtZW50PyBJIHdvdWxkIHN1Z2dlc3QgeW91
IHRyeSB0byBrZWVwIHlvdXIgaW50ZXJuYWwgcmV2aWV3cw0KPiBmYXN0IGFuZCBsb3cgb3Zlcmhl
YWQsIGJlY2F1c2UgeW91IHdpbGwgYmUgZG9pbmcgaXQgbG90cyBvZiB0aW1lcyBhcw0KPiB3ZSBp
dGVyYXRlIHRoZSBmcmFtZXdvcmsuDQoNCkhpIEFuZHJldywNCg0KV2UgdW5kZXJzdGFuZCB5b3Vy
IGNvbmNlcm4uIFdlIGFyZSB3b3JraW5nIG9uIHRoaXMgdGFzayB3aXRoIGZ1bGwgZm9jdXMuIA0K
SW5pdGlhbGx5IHRoZXJlIHdlcmUgc29tZSBpbXBsZW1lbnRhdGlvbiBjaGFuZ2UgcHJvcG9zYWwg
ZnJvbSBvdXIgDQppbnRlcm5hbCByZXZpZXdlcnMgdG8gaW1wcm92ZSB0aGUgcGVyZm9ybWFuY2Ug
YW5kIGNvZGUgcXVhbGl0eS4gDQpDb25zZXF1ZW50bHkgdGhlIHRlc3Rpbmcgb2YgdGhlIG5ldyBp
bXBsZW1lbnRhdGlvbiB0b29rIHNvbWUgd2hpbGUgdG8gDQpicmluZyBpdCB0byBhIGdvb2Qgc2hh
cGUuDQoNCk91ciBpbnRlcm5hbCByZXZpZXdlcnMgU3RlZW4gSGVnZWx1bmQgYW5kIEhvcmF0aXUg
VnVsdHVyIGFyZSBhY3RpdmVseSANCnBhcnRpY2lwYXRpbmcgaW4gcmV2aWV3aW5nIG15IHBhdGNo
ZXMuIEkgYWxyZWFkeSBoYXZlIHRhbGtlZCB0byB0aGVtIGFuZCANCndlIGFyZSBpbiBwcm9ncmVz
cyB0b2dldGhlciB0byBnZXQgdGhlIG5leHQgdmVyc2lvbiByZWFkeSBmb3IgdGhlIA0Kc3VibWlz
c2lvbi4gV2UgYXJlIHRyeWluZyBvdXIgbGV2ZWwgYmVzdCBhbmQgd29ya2luZyBoYXJkIHRvIHB1
c2ggdGhlIA0KbmV4dCBzZXQgb2YgcGF0Y2hlcyB0byB0aGUgbWFpbmxpbmUgYXMgc29vbiBhcyBw
b3NzaWJsZS4NCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+ICAgICAgICAgIEFu
ZHJldw0KPiANCg0K

