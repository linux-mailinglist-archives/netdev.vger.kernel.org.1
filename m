Return-Path: <netdev+bounces-126462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76B69713BA
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3013A1F25824
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5A21B3F0B;
	Mon,  9 Sep 2024 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Tal0CdO8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5D71B5831;
	Mon,  9 Sep 2024 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874221; cv=fail; b=I/CiXMGJiLs064Ubouu38bAZXic88LUlT1Io9LzKDi9+4UBTW7ySmqWO+8ArYU3YdFJVMa1X8wwjAkxDyUx6SKfroYy5xtZ9PsYwASggvj3YvC6nbxSdNnKVs0z8dLV5gL7yIma/axx8ibWv3clrl/rcwmOimhvLOM8ubz2ECmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874221; c=relaxed/simple;
	bh=SZKRAmFiEGSPH1EdxgMYK9yvng+0Ytxmrf2MmsOWMgA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n8a6I7lpBJlm99FgIzLFfHcbJ6Sw5SqJVWekewAF3DBd+C7PI0eL4f8Q41ysyvRTR2/CZ8IAsWrr/4QM6Cwy5aOwDGNNFuDvsQbugzkZi8jHrMFCqWc3ctnUqh4Y48UDcnp2fPhXGJXd1WpMhZHqV91T0Gy6bi71bJ7MmsDbj9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Tal0CdO8; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwMnQfacjY9k3NMaq7n7fPRDS5V5Y48UBb32hTbi7ao2tCcR4yxJg/eA7xUDjZVsjvwFTyR8sF0N5G0bbdc22ajXOTnOZpQ3Wfhdv3wis0uA0G5oMztRfM/9UvRYTgFR+/Gs51Nq9ZnpClMblYfijcszTkbv3LMHLcbnm/h6z5dShj+y/84kI6m0MYt5icPUGy31vnW8f8xhDyZ/6M9d212dthrIRu0d3G6gcnTYr9SSM9uU83k3YjJ/2i4suTaQ12yreUgGQKiCLkauuxUBofO9Nd2kLqmuri8HKUg7rHY4bKhNCoq9h3HJe+rmOIVBq1m2/+dbcNyw9HmlQGnCHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZKRAmFiEGSPH1EdxgMYK9yvng+0Ytxmrf2MmsOWMgA=;
 b=RCWzDJAe+KGitRim+HF3dGwzOitnpDCsI4cRp29ruvDC5SIlIkK/xitzgebyGgL7o5VT6r4SdtEkPbexkOiJt2PB30O+YoEHXppevSPaoVmOMpqymgYcEs7bylJqH0zhXk3s/ZBIaa+rtuKMrQlbaPYlMob33WN2PVQl9k+ut3J8oF0eUsuyJnuXMh8bYCN8ekyy5VQcGghzjvdUS2a8v4co3b4DHL/Vd6qN7l6TUZD4n6Qnjz5Wc4OQoBZdFStsuPo2T+/rBYKHXekb7NdM4LMv7/YPT9/jsOejE8KqA/RY8v2BeEJfxxK5SM1vLeg1wiXV8xn1ZEPZJ61/+87IUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZKRAmFiEGSPH1EdxgMYK9yvng+0Ytxmrf2MmsOWMgA=;
 b=Tal0CdO8NUl1dZkjFp3xu481IR9ICBZOMBpkc/YqmUcX7BxNEarnsydknpF2Z0KbqSdQVOndfQ1Vfgc7RTXBxKinieD2B+ya45GgMX31EsaK4e6ztGLJ/5XI0R+d42ukx4TubEFlVI9z7LzlRRVuuDGEsQbicPhTkPIGAde8UGOJOANWEt9Y9RtUIzCbH2YNatq3Kp4qWee0v3LWw2DkY0c1nUMXC6y7AcaS+cRNtbVIoCLPT/G92tEY15vGw2cNUqW2Lxv5camsouxiin83rf9AjwZHpprjH8va9nnoqxn75ZPLXf7lI2ED/ImSwKbyWXeUFion56Ef4iPonNvlcg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by IA0PR11MB7257.namprd11.prod.outlook.com (2603:10b6:208:43e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 09:30:15 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 09:30:15 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Horatiu.Vultur@microchip.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [PATCH net-next v2 7/7] net: phy: microchip_t1s: configure
 collision detection based on PLCA mode
Thread-Topic: [PATCH net-next v2 7/7] net: phy: microchip_t1s: configure
 collision detection based on PLCA mode
Thread-Index: AQHa/UVnEGwEICz1Fk+B+6aZAYJrcbJFnowAgAHnJgCAAtAPAIAE5XMA
Date: Mon, 9 Sep 2024 09:30:15 +0000
Message-ID: <d28c72b8-5760-4c14-8a87-f508e8e70466@microchip.com>
References: <20240902143458.601578-1-Parthiban.Veerasooran@microchip.com>
 <20240902143458.601578-8-Parthiban.Veerasooran@microchip.com>
 <20240903064312.2vsoqkoiiuaywg3w@DEN-DL-M31836.microchip.com>
 <d8b880ad-28c2-4fea-9dc6-3adde9dfe8c0@microchip.com>
 <20240906064358.xmqbs7fzf6kd7ydp@DEN-DL-M31836.microchip.com>
In-Reply-To: <20240906064358.xmqbs7fzf6kd7ydp@DEN-DL-M31836.microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|IA0PR11MB7257:EE_
x-ms-office365-filtering-correlation-id: a36bdd31-1ace-4064-fe31-08dcd0b20308
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cjJ2bEUxRDhZV0RMTGJaTmpIOUN4YmYzaWFGcFFMTHNkM0xyWTU3OGFwalZ2?=
 =?utf-8?B?UXYrSVdIN2I3SFpYRGFZWHNQY2l6Q3NOTXIvU2xoVGlRVHRwNUg4QlR0UGFO?=
 =?utf-8?B?OXc3Nm9qdXJSZ2ZRaHY1WmVxNktPNktoZ1haNUFaRWFOS2VLYUthZ3Q0ZkNl?=
 =?utf-8?B?NzJDTURPQ3BPSzhKbzVXOVRVK1h3UU1xckk4ODFmQjRpYm1laS9VenlnNDU4?=
 =?utf-8?B?YU1MWWR5VmFtWVpFMlBqUzE3SnpoZjJJbHZMRkw1bWs0OU5mVDhlTFB5V2M1?=
 =?utf-8?B?K243d3FvdDF3dFI1ZGhub2x4UmVWVnpRZkU3Um1vZXpHQjBjVnR1a0o3RmJY?=
 =?utf-8?B?V0FyVW9QWXdRRkhiRTBWWkQ4bVdOOFpkVWN4bTFYYW9TTlF3R3VkbVM1VWRu?=
 =?utf-8?B?SkdXZUdCeGJudzV6NmJacDdIRFQwczdpSTNsVW1lczU0QjJTZzh0RXpVYjVD?=
 =?utf-8?B?SHZGSVdicWdWNXpzNitGSi93dHhiSXFtbFFuangrNmczblJrM09wZGhqakNs?=
 =?utf-8?B?ZlJSVDJLSEhoMDFtY004SHE5Z3h3NW9LZFRtdzdMdDNhbHFYa09IcWd3b0x6?=
 =?utf-8?B?Z1I3VDR2RUEydjBHSGc1SkpkVmJoZUFkRTZhbTlNMlZTcHJWc2RIb1k4azBV?=
 =?utf-8?B?bk5sM1pnNi9PWjlDelorUG05OFVHa2VhV0YzZ1NTSklIOFdlMlV2OW1PT0lD?=
 =?utf-8?B?V3YvUFZaQ2MxVmdPSEc4TGlaOXgxSy8vVUEwUjM3Vm12dmh5aFJWeXVWbFFs?=
 =?utf-8?B?NUp6ZkgxMTJZWmUzUEovME01SFJUc1l0bHdjNW5CNktWSHdYV0x5R3FPU1Zq?=
 =?utf-8?B?VWdMcFdtMVVvQVpnK3kyb3o1VDhyajE3L3Z2d0Nndmg5aUxoY0tFSUlTbjBs?=
 =?utf-8?B?SlYwZTZLZFRCUmpiM2cyeExFRFRJVGpQUE93dXlCODA5ckF6TFhxekVGQnA5?=
 =?utf-8?B?ZnpPTUszcTVxV08vSEVTUkEreHVNelBFVnBaTG14WVc5Q0FGSFc4TFlSVmlv?=
 =?utf-8?B?U09QTjQrMzRQejBsR3orRmZVRGFWWWM3REdJc0NVc3Y2a0xvdWFaS2dDQ1c2?=
 =?utf-8?B?d3pneEY3dVNtTGlybnpPU0RqMlNpQk1DQ0RHcWlPcEJ4N1p3amgva1Y5Nnpu?=
 =?utf-8?B?RnkyNjFESDVqN3R1VzR6WFIwd3E2NlNBTHJtdEtUbVNsQVE0bHhHVk5RRkZu?=
 =?utf-8?B?bjZKWDJzWHZuTU9WSVVTU2pUMDlJUGN5L1IrR0NKTHIyaU5CaERyUER6QzRL?=
 =?utf-8?B?YXpUYlc5ckVndVBCU0RLdTZDOVlaRkJrQUR0RjZleXJEZjRJYWJOUDdnT3p4?=
 =?utf-8?B?cnliazVwejJuME40bGsrMU4wZ0tnb2RpZUExKzFoWWhNTnNwMm1pTHpibUdM?=
 =?utf-8?B?aEZpRDQvbVNCOUtTK3hRRkZ2MzIwVTFXdmFOZ3B1ako0RlFEd3ZHbFJaVVd3?=
 =?utf-8?B?RFpFclYzc1htL0RrTDBsSkpXbnArTm4vRmdsWlRRdy9NV1NJTXNMK2tPZy82?=
 =?utf-8?B?NGFWQ2lpWExsR3FWbWxFOG5QQ2JHdkk5azJMSTArVjc4bnBkTHpiMUdTNXNy?=
 =?utf-8?B?RHM1YnVJak1VZEFmU295N2xtL0M0WE9ZY1NQSjdZb2ZJUGZZcHk1Wm5wSkJH?=
 =?utf-8?B?enl6bWcwbDl0UXB3bTd2L3ppQ29maHlTbW9OcERzcmt0ejJId2ZBeU9wZ3k1?=
 =?utf-8?B?KzUxUDZraHFnOGxteEFVaER5bTg1UTd6cXA4MEpOa0ZkRDBOSlNWMGthREJj?=
 =?utf-8?B?UkJsYzRBaTh2Q0h2WDNaTTdYTGZnMURBaS9WN3N3ZEVrUzdycTNXTzMxd0s2?=
 =?utf-8?B?QSsvVVVzeVV5K3RJNkJYbXNuanBnQmVIbEdLUDBJeXhxSFFMcGlPbnBZNlQ2?=
 =?utf-8?B?TUFXb0xaVDlUWkNwSDFDanhic1RRNVZHLzhsTlQ3WjF2bWwzbVZFUXdHemtJ?=
 =?utf-8?Q?Wa2b+6/dFJg=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXRtSjVIdFVmUXpQYzlIWkpRRzBSNHJYb3lYRW9xRldVdnFqOUJhdTFYWUsz?=
 =?utf-8?B?bVI1NTlPQkNITm10ZnBWdUJ4NUZYYnpSdkxDNzhkd1BKa3Baa2hIdjA0VFNs?=
 =?utf-8?B?cnFIUCtaSlBrQlRMTE9wNFBCOWpDdC9lbG5BSnJJRmVna25qR0hkWHpKV3ly?=
 =?utf-8?B?MUVqaEFyMStQeVRsUjFYbHNnckxaaCsvbXVDUTdKYWtaUnJSL0VYRTlNN1RJ?=
 =?utf-8?B?b2IrVENBSzBBa0FMdkNjRU82WDlocG5USnZKTGd0eXZacS9ubENydGJpdWQ2?=
 =?utf-8?B?ZHFnNDFNZ2dsaCt1azlERWhya2xnN0QxcjlUWDh1L2RoWTNDOHpHWGkwQnFz?=
 =?utf-8?B?anBnalVmVEFlWXIzRlR5OHRTWFdlY0xUK1d3OFNYWWVTeDZyUzJiVi9RTkhQ?=
 =?utf-8?B?WmhXdXBLY05OZWFwam9FaTBhNzNLOVNCTXZUV0F4cTg2WVZDWUNFMFJIL3Ja?=
 =?utf-8?B?WWtPVlc3WlF4NWluc3BnTU52WFRERm5hNTd5UnRIQzZzWTQ3S25jZVdDcUEv?=
 =?utf-8?B?TmpkN1hjd0l5NmJHZC9VVE5IMmJLSVg3NDQ2RitHc0dwNlpLZlIxdkJIelB5?=
 =?utf-8?B?S1VMUEpIWFA5bVRiZmJQSllENTRDekxHZGdBejJPN3ZSakVJbmNONW51THdC?=
 =?utf-8?B?aDIvL3FTaFVPV2hxdDNRd1ZTd0hWUFBJc2p1S1lXRHZxT0VZYm85eFZFcWRN?=
 =?utf-8?B?Qjl0WkVVWGNUb2FDbmoyaWtjdXFvTWxjTXFzblNkdGNWVm81b1V6dnNSVzJG?=
 =?utf-8?B?N2FuMlFPQVhpL3BkMHl2MmYzNExrUi9WNnVWNXlrVDNVa2EraTdGY04zbU9q?=
 =?utf-8?B?THk0eGZpdW5aZGxiYWF4eFpEN0l6djk1dkNuandPOTAwbDRJN2dFYTI3dkx5?=
 =?utf-8?B?TWYzcFd6T1pNRDRQU1NRTFNJSTREYkZvdlJ5NTBWNzZvQlE0NDBlRStEOHNw?=
 =?utf-8?B?dlFmNmtmemx0c1BPUUkrMDV5dWw2SmdveStvb2E2Q05vTUZzbFdGTnV4d1c0?=
 =?utf-8?B?bkVpZHA1TzhLSkZrY3NIYVdGMlRSUmFySzM2VHRBYnBnYjZWS1M1RU0vV3Zk?=
 =?utf-8?B?VXNtYW5QUCtub0ZHRjBJa0pmcFRVN0R6WStpem51WXUrak5EWHEzY0xEN0pX?=
 =?utf-8?B?cVFiTWEwemZQL2RETmRvd0pxMUFKaDVrUDR5WVh5Q1RCVE5Gclp3dzB0amds?=
 =?utf-8?B?N2piK2dYWFVnVU5mTmVYRlU1L0h6UnkrVDB1a3ZyT0hNWjZIL01hU3BZQTdn?=
 =?utf-8?B?Q3BOOFhHTUtYRnd6UU81MUY4eFJpODR2cE5iSXpqMnkzNG03eE5BSmhLNkVp?=
 =?utf-8?B?aFRNVldna0NNRXdyMjBQbXN2cDhQZzV5TWRlUE9aZW9rS3FzbHk5Tm5MQU9N?=
 =?utf-8?B?L3p2bGtpQjJCRTk1OS9oczNoMUhMT1oyTU1IUkR4L3M0aW9VT1RGVDVydzRq?=
 =?utf-8?B?elh2Vk9XNTM0NUdVQzA1dHI0RE5BWkJZbi9oV1hTbUVyL3ZUbWN3K1BrL2J3?=
 =?utf-8?B?RTl2eTY2c29NTGNKdkxjUVREWU1sa2orSzNMbFl6SDV6dlFSU25CWjdSTFhp?=
 =?utf-8?B?UUpMbFhoU09CRFhHUVhRZ0plclhyQ1RydDlYSGxIY0JSNHZGTkRiV0FFV0dm?=
 =?utf-8?B?ZFJoRnkwMDVWU2x0dG9yUXM0amZIVURveDlHaUMxc3JGZUJnazVFYlNjSmlv?=
 =?utf-8?B?V3BNdDJ1Q0l3aXl3Y2F6SUZ0cy91dmk4UWhNem92clIybTc1cjBTM2RZN2lp?=
 =?utf-8?B?b1d0TWErcUFsSGFPb0RqbFU2NkNZTVRSeXZocUhSOU5DQlE0Qi9wdy9DVHR3?=
 =?utf-8?B?bEtFOGF3a3dvaEk5MnJOd0hORHE5akJJaG80cndDVUEzNG8wa1E3N0FYMXA2?=
 =?utf-8?B?aXhhcm5LK3pxMGZyS2JmdFhNRThzUzF2dTYrTVFQVXlpbXlTYkU3MTNEWkpz?=
 =?utf-8?B?WnBHU1FGL2ZJRTZ0dktYeEVvQVBhSm5KdVArdGhVczBEakhtM0x0UjRzV2g2?=
 =?utf-8?B?WDNPRTBCQzdZZGJIVjFpTUtGQzJLUHN2RHBvOXZoVjQxNGprUzJYdmg4d1Bu?=
 =?utf-8?B?MUZsSmxuYkFwZFBpbHVKMEwwWVQ1ZzN0L3RSOE44S2lYQWMvVFh2Wi8zZ0Nr?=
 =?utf-8?B?RFVydGE5clp4WEsvcWhlQmt3aisxbEJ4RzArbFZRcXlacVRnekpyNFgyN1Zh?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB3EDE1BCF38D24DA92C506143CBAD4B@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a36bdd31-1ace-4064-fe31-08dcd0b20308
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 09:30:15.3322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cd3uYRMEUs2I2VbIozsm8MX+XnfgRXwcAXTEJg/NZpgZEQ/ye/8hgz/ZqyikrQ3lJtLxAQ8AmHwQra0G3DM0eEScYjU9BHyqMXToFR148wyC1G7a2jk1T2r3zaiWWuEx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7257

SGkgSG9yYXRpdSwNCg0KT24gMDYvMDkvMjQgMTI6MTMgcG0sIEhvcmF0aXUgVnVsdHVyIC0gTTMx
ODM2IHdyb3RlOg0KPiBUaGUgMDkvMDQvMjAyNCAxMTo0NiwgUGFydGhpYmFuIFZlZXJhc29vcmFu
IC0gSTE3MTY0IHdyb3RlOg0KPj4gSGkgSG9yYXRpdSwNCj4+DQo+PiBPbiAwMy8wOS8yNCAxMjox
MyBwbSwgSG9yYXRpdSBWdWx0dXIgd3JvdGU6DQo+Pj4gVGhlIDA5LzAyLzIwMjQgMjA6MDQsIFBh
cnRoaWJhbiBWZWVyYXNvb3JhbiB3cm90ZToNCj4+Pg0KPj4+IEhpIFBhcnRoaWJhbiwNCj4+Pg0K
Pj4+PiBBcyBwZXIgTEFOODY1MC8xIFJldi5CMC9CMSBBTjE3NjAgKFJldmlzaW9uIEYgKERTNjAw
MDE3NjBHIC0gSnVuZSAyMDI0KSkNCj4+Pj4gYW5kIExBTjg2NzAvMS8yIFJldi5DMS9DMiBBTjE2
OTkgKFJldmlzaW9uIEUgKERTNjAwMDE2OTlGIC0gSnVuZSAyMDI0KSksDQo+Pj4+IHVuZGVyIG5v
cm1hbCBvcGVyYXRpb24sIHRoZSBkZXZpY2Ugc2hvdWxkIGJlIG9wZXJhdGVkIGluIFBMQ0EgbW9k
ZS4NCj4+Pj4gRGlzYWJsaW5nIGNvbGxpc2lvbiBkZXRlY3Rpb24gaXMgcmVjb21tZW5kZWQgdG8g
YWxsb3cgdGhlIGRldmljZSB0bw0KPj4+PiBvcGVyYXRlIGluIG5vaXN5IGVudmlyb25tZW50cyBv
ciB3aGVuIHJlZmxlY3Rpb25zIGFuZCBvdGhlciBpbmhlcmVudA0KPj4+PiB0cmFuc21pc3Npb24g
bGluZSBkaXN0b3J0aW9uIGNhdXNlIHBvb3Igc2lnbmFsIHF1YWxpdHkuIENvbGxpc2lvbg0KPj4+
PiBkZXRlY3Rpb24gbXVzdCBiZSByZS1lbmFibGVkIGlmIHRoZSBkZXZpY2UgaXMgY29uZmlndXJl
ZCB0byBvcGVyYXRlIGluDQo+Pj4+IENTTUEvQ0QgbW9kZS4NCj4+Pg0KPj4+IElzIHRoaXMgc29t
ZXRoaW5nIHRoYXQgYXBwbGllcyBvbmx5IHRvIE1pY3JvY2hpcCBQSFlzIG9yIGlzIHNvbWV0aGlu
Zw0KPj4+IGdlbmVyaWMgdGhhdCBhcHBsaWVzIHRvIGFsbCB0aGUgUEhZcy4NCj4+IFllcywgdGhl
IGJlaGF2aW9yIGlzIGNvbW1vbiBmb3IgYWxsIHRoZSBQSFlzIGJ1dCBpdCBpcyBwdXJlbHkgdXAg
dG8gdGhlDQo+PiBQSFkgY2hpcCBkZXNpZ24gc3BlY2lmaWMuDQo+Pg0KPj4gMS4gU29tZSB2ZW5k
b3JzIHdpbGwgZW5hYmxlIHRoaXMgZmVhdHVyZSBpbiB0aGUgY2hpcCBsZXZlbCBieSBsYXRjaGlu
Zw0KPj4gdGhlIHJlZ2lzdGVyIGJpdHMuIFRoZXJlIHdlIGRvbid0IG5lZWQgc29mdHdhcmUgaW50
ZXJmYWNlLg0KPj4gMi4gU29tZSB2ZW5kb3JzIG5lZWQgc29mdHdhcmUgaW50ZXJmYWNlIHRvIGVu
YWJsZSB0aGlzIGZlYXR1cmUgbGlrZSBvdXINCj4+IE1pY3JvY2hpcCBQSFkgZG9lcy4NCj4gDQo+
IERvbid0IHlvdSB0aGluayB0aGVuIGlzIGJldHRlciB0byBjcmVhdGUgc29tZXRoaW5nIG1vcmUg
Z2VuZXJpYyBzbyBvdGhlcg0KPiBQSFlzIHRvIGFibGUgdG8gZG8gdGhpcz8NCllhLCBpdCBpcyBh
IGdvb2QgaWRlYSBidXQgdGhlIG9mZnNldCBmb3IgdGhlIENvbGxpc2lvbiBEZXRlY3RvciBjb250
cm9sIA0KcmVnaXN0ZXIgaXMgdmVuZG9yIHNwZWNpZmljIHJlc3VsdGluZyBlYWNoIHZlbmRvciB3
aWxsIGhhdmUgZGlmZmVyZW50IA0Kb2Zmc2V0cy4gU28gd2UgY2FuJ3QgbWFrZSBpdCBhcyBhIGdl
bmVyaWMgaGVscGVyIGZ1bmN0aW9uLg0KDQpBbHRlcm5hdGl2ZWx5LCB3ZSBjYW4gcHJvdmlkZSBh
IGZ1bmN0aW9uIHBvaW50ZXIgaW50ZXJmYWNlIGluIHRoZSANCiJzdHJ1Y3QgcGh5X2RyaXZlciIg
d2hpY2ggY2FuIGltcGxlbWVudCB0aGUgY29sbGlzaW9uIGRldGVjdGlvbiANCmRpc2FibGUvZW5h
YmxlIGZ1bmN0aW9uYWxpdHkgbG9naWMgaW4gdGhlIFBIWSBkcml2ZXIuIA0KZ2VucGh5X2M0NV9w
bGNhX3NldF9jZmcoKSBmdW5jdGlvbiBpbiB0aGUgcGh5LWM0NS5jIGNhbiBjYWxsIHRoaXMgDQpm
dW5jdGlvbiBpZiBpdCBpcyBpbXBsZW1lbnRlZC92YWxpZCBpbiB0aGUgUEhZIGRyaXZlci4gRG8g
eW91IG1lYW4gDQpzb21ldGhpbmcgbGlrZSB0aGlzPw0KDQpJbiB0aGUgYWJvdmUgY2FzZSBhbHNv
IHRoZSBQSFkgZHJpdmVyIG5lZWRzIHRvIGltcGxlbWVudCB0aGUgbG9naWMgYXMgDQp0aGUgcmVn
aXN0ZXIgb2Zmc2V0IHdpbGwgYmUgZGlmZmVyZW50IGZvciBkaWZmZXJlbnQgdmVuZG9ycy4gIElz
IHRoaXMgbXkgDQp1bmRlcnN0YW5kaW5nIGNvcnJlY3Qgb3IgZG8geW91IGhhdmUgYW55IG90aGVy
IHByb3Bvc2FsPw0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4+DQo+PiBCZXN0
IHJlZ2FyZHMsDQo+PiBQYXJ0aGliYW4gVg0KPj4+DQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6
IFBhcnRoaWJhbiBWZWVyYXNvb3JhbiA8UGFydGhpYmFuLlZlZXJhc29vcmFuQG1pY3JvY2hpcC5j
b20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBkcml2ZXJzL25ldC9waHkvbWljcm9jaGlwX3Qxcy5jIHwg
NDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+Pj4+ICAgIDEgZmlsZSBjaGFu
Z2VkLCAzOSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvcGh5L21pY3JvY2hpcF90MXMuYyBiL2RyaXZlcnMvbmV0L3BoeS9t
aWNyb2NoaXBfdDFzLmMNCj4+Pj4gaW5kZXggYmQwYzc2OGRmMGFmLi5hMDU2NTUwOGQ3ZDIgMTAw
NjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvbmV0L3BoeS9taWNyb2NoaXBfdDFzLmMNCj4+Pj4gKysr
IGIvZHJpdmVycy9uZXQvcGh5L21pY3JvY2hpcF90MXMuYw0KPj4+PiBAQCAtMjYsNiArMjYsMTIg
QEANCj4+Pj4gICAgI2RlZmluZSBMQU44NjVYX1JFR19DRkdQQVJBTV9DVFJMIDB4MDBEQQ0KPj4+
PiAgICAjZGVmaW5lIExBTjg2NVhfUkVHX1NUUzIgMHgwMDE5DQo+Pj4+ICAgIA0KPj4+PiArLyog
Q29sbGlzaW9uIERldGVjdG9yIENvbnRyb2wgMCBSZWdpc3RlciAqLw0KPj4+PiArI2RlZmluZSBM
QU44NlhYX1JFR19DT0xfREVUX0NUUkwwCTB4MDA4Nw0KPj4+PiArI2RlZmluZSBDT0xfREVUX0NU
UkwwX0VOQUJMRV9CSVRfTUFTSwlCSVQoMTUpDQo+Pj4+ICsjZGVmaW5lIENPTF9ERVRfRU5BQkxF
CQkJQklUKDE1KQ0KPj4+PiArI2RlZmluZSBDT0xfREVUX0RJU0FCTEUJCQkweDAwMDANCj4+Pj4g
Kw0KPj4+PiAgICAjZGVmaW5lIExBTjg2NVhfQ0ZHUEFSQU1fUkVBRF9FTkFCTEUgQklUKDEpDQo+
Pj4+ICAgIA0KPj4+PiAgICAvKiBUaGUgYXJyYXlzIGJlbG93IGFyZSBwdWxsZWQgZnJvbSB0aGUg
Zm9sbG93aW5nIHRhYmxlIGZyb20gQU4xNjk5DQo+Pj4+IEBAIC0zNzAsNiArMzc2LDM2IEBAIHN0
YXRpYyBpbnQgbGFuODY3eF9yZXZiMV9jb25maWdfaW5pdChzdHJ1Y3QgcGh5X2RldmljZSAqcGh5
ZGV2KQ0KPj4+PiAgICAJcmV0dXJuIDA7DQo+Pj4+ICAgIH0NCj4+Pj4gICAgDQo+Pj4+ICsvKiBB
cyBwZXIgTEFOODY1MC8xIFJldi5CMC9CMSBBTjE3NjAgKFJldmlzaW9uIEYgKERTNjAwMDE3NjBH
IC0gSnVuZSAyMDI0KSkgYW5kDQo+Pj4+ICsgKiBMQU44NjcwLzEvMiBSZXYuQzEvQzIgQU4xNjk5
IChSZXZpc2lvbiBFIChEUzYwMDAxNjk5RiAtIEp1bmUgMjAyNCkpLCB1bmRlcg0KPj4+PiArICog
bm9ybWFsIG9wZXJhdGlvbiwgdGhlIGRldmljZSBzaG91bGQgYmUgb3BlcmF0ZWQgaW4gUExDQSBt
b2RlLiBEaXNhYmxpbmcNCj4+Pj4gKyAqIGNvbGxpc2lvbiBkZXRlY3Rpb24gaXMgcmVjb21tZW5k
ZWQgdG8gYWxsb3cgdGhlIGRldmljZSB0byBvcGVyYXRlIGluIG5vaXN5DQo+Pj4+ICsgKiBlbnZp
cm9ubWVudHMgb3Igd2hlbiByZWZsZWN0aW9ucyBhbmQgb3RoZXIgaW5oZXJlbnQgdHJhbnNtaXNz
aW9uIGxpbmUNCj4+Pj4gKyAqIGRpc3RvcnRpb24gY2F1c2UgcG9vciBzaWduYWwgcXVhbGl0eS4g
Q29sbGlzaW9uIGRldGVjdGlvbiBtdXN0IGJlIHJlLWVuYWJsZWQNCj4+Pj4gKyAqIGlmIHRoZSBk
ZXZpY2UgaXMgY29uZmlndXJlZCB0byBvcGVyYXRlIGluIENTTUEvQ0QgbW9kZS4NCj4+Pj4gKyAq
DQo+Pj4+ICsgKiBBTjE3NjA6IGh0dHBzOi8vd3d3Lm1pY3JvY2hpcC5jb20vZW4tdXMvYXBwbGlj
YXRpb24tbm90ZXMvYW4xNzYwDQo+Pj4+ICsgKiBBTjE2OTk6IGh0dHBzOi8vd3d3Lm1pY3JvY2hp
cC5jb20vZW4tdXMvYXBwbGljYXRpb24tbm90ZXMvYW4xNjk5DQo+Pj4+ICsgKi8NCj4+Pj4gK3N0
YXRpYyBpbnQgbGFuODZ4eF9wbGNhX3NldF9jZmcoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldiwN
Cj4+Pj4gKwkJCQljb25zdCBzdHJ1Y3QgcGh5X3BsY2FfY2ZnICpwbGNhX2NmZykNCj4+Pj4gK3sN
Cj4+Pj4gKwlpbnQgcmV0Ow0KPj4+PiArDQo+Pj4+ICsJcmV0ID0gZ2VucGh5X2M0NV9wbGNhX3Nl
dF9jZmcocGh5ZGV2LCBwbGNhX2NmZyk7DQo+Pj4+ICsJaWYgKHJldCkNCj4+Pj4gKwkJcmV0dXJu
IHJldDsNCj4+Pj4gKw0KPj4+PiArCWlmIChwbGNhX2NmZy0+ZW5hYmxlZCkNCj4+Pj4gKwkJcmV0
dXJuIHBoeV9tb2RpZnlfbW1kKHBoeWRldiwgTURJT19NTURfVkVORDIsDQo+Pj4+ICsJCQkJICAg
ICAgTEFOODZYWF9SRUdfQ09MX0RFVF9DVFJMMCwNCj4+Pj4gKwkJCQkgICAgICBDT0xfREVUX0NU
UkwwX0VOQUJMRV9CSVRfTUFTSywNCj4+Pj4gKwkJCQkgICAgICBDT0xfREVUX0RJU0FCTEUpOw0K
Pj4+PiArDQo+Pj4+ICsJcmV0dXJuIHBoeV9tb2RpZnlfbW1kKHBoeWRldiwgTURJT19NTURfVkVO
RDIsIExBTjg2WFhfUkVHX0NPTF9ERVRfQ1RSTDAsDQo+Pj4+ICsJCQkgICAgICBDT0xfREVUX0NU
UkwwX0VOQUJMRV9CSVRfTUFTSywgQ09MX0RFVF9FTkFCTEUpOw0KPj4+PiArfQ0KPj4+PiArDQo+
Pj4+ICAgIHN0YXRpYyBpbnQgbGFuODZ4eF9yZWFkX3N0YXR1cyhzdHJ1Y3QgcGh5X2RldmljZSAq
cGh5ZGV2KQ0KPj4+PiAgICB7DQo+Pj4+ICAgIAkvKiBUaGUgcGh5IGhhcyBzb21lIGxpbWl0YXRp
b25zLCBuYW1lbHk6DQo+Pj4+IEBAIC00MDMsNyArNDM5LDcgQEAgc3RhdGljIHN0cnVjdCBwaHlf
ZHJpdmVyIG1pY3JvY2hpcF90MXNfZHJpdmVyW10gPSB7DQo+Pj4+ICAgIAkJLmNvbmZpZ19pbml0
ICAgICAgICA9IGxhbjg2N3hfcmV2Y19jb25maWdfaW5pdCwNCj4+Pj4gICAgCQkucmVhZF9zdGF0
dXMgICAgICAgID0gbGFuODZ4eF9yZWFkX3N0YXR1cywNCj4+Pj4gICAgCQkuZ2V0X3BsY2FfY2Zn
CSAgICA9IGdlbnBoeV9jNDVfcGxjYV9nZXRfY2ZnLA0KPj4+PiAtCQkuc2V0X3BsY2FfY2ZnCSAg
ICA9IGdlbnBoeV9jNDVfcGxjYV9zZXRfY2ZnLA0KPj4+PiArCQkuc2V0X3BsY2FfY2ZnCSAgICA9
IGxhbjg2eHhfcGxjYV9zZXRfY2ZnLA0KPj4+PiAgICAJCS5nZXRfcGxjYV9zdGF0dXMgICAgPSBn
ZW5waHlfYzQ1X3BsY2FfZ2V0X3N0YXR1cywNCj4+Pj4gICAgCX0sDQo+Pj4+ICAgIAl7DQo+Pj4+
IEBAIC00MTMsNyArNDQ5LDcgQEAgc3RhdGljIHN0cnVjdCBwaHlfZHJpdmVyIG1pY3JvY2hpcF90
MXNfZHJpdmVyW10gPSB7DQo+Pj4+ICAgIAkJLmNvbmZpZ19pbml0ICAgICAgICA9IGxhbjg2N3hf
cmV2Y19jb25maWdfaW5pdCwNCj4+Pj4gICAgCQkucmVhZF9zdGF0dXMgICAgICAgID0gbGFuODZ4
eF9yZWFkX3N0YXR1cywNCj4+Pj4gICAgCQkuZ2V0X3BsY2FfY2ZnCSAgICA9IGdlbnBoeV9jNDVf
cGxjYV9nZXRfY2ZnLA0KPj4+PiAtCQkuc2V0X3BsY2FfY2ZnCSAgICA9IGdlbnBoeV9jNDVfcGxj
YV9zZXRfY2ZnLA0KPj4+PiArCQkuc2V0X3BsY2FfY2ZnCSAgICA9IGxhbjg2eHhfcGxjYV9zZXRf
Y2ZnLA0KPj4+PiAgICAJCS5nZXRfcGxjYV9zdGF0dXMgICAgPSBnZW5waHlfYzQ1X3BsY2FfZ2V0
X3N0YXR1cywNCj4+Pj4gICAgCX0sDQo+Pj4+ICAgIAl7DQo+Pj4+IEBAIC00MjMsNyArNDU5LDcg
QEAgc3RhdGljIHN0cnVjdCBwaHlfZHJpdmVyIG1pY3JvY2hpcF90MXNfZHJpdmVyW10gPSB7DQo+
Pj4+ICAgIAkJLmNvbmZpZ19pbml0ICAgICAgICA9IGxhbjg2NXhfcmV2Yl9jb25maWdfaW5pdCwN
Cj4+Pj4gICAgCQkucmVhZF9zdGF0dXMgICAgICAgID0gbGFuODZ4eF9yZWFkX3N0YXR1cywNCj4+
Pj4gICAgCQkuZ2V0X3BsY2FfY2ZnCSAgICA9IGdlbnBoeV9jNDVfcGxjYV9nZXRfY2ZnLA0KPj4+
PiAtCQkuc2V0X3BsY2FfY2ZnCSAgICA9IGdlbnBoeV9jNDVfcGxjYV9zZXRfY2ZnLA0KPj4+PiAr
CQkuc2V0X3BsY2FfY2ZnCSAgICA9IGxhbjg2eHhfcGxjYV9zZXRfY2ZnLA0KPj4+PiAgICAJCS5n
ZXRfcGxjYV9zdGF0dXMgICAgPSBnZW5waHlfYzQ1X3BsY2FfZ2V0X3N0YXR1cywNCj4+Pj4gICAg
CX0sDQo+Pj4+ICAgIH07DQo+Pj4+IC0tIA0KPj4+PiAyLjM0LjENCj4+Pj4NCj4+Pg0KPj4NCj4g
DQoNCg==

