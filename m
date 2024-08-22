Return-Path: <netdev+bounces-120865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF2E95B1CC
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D911C21815
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 09:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483CC1741FA;
	Thu, 22 Aug 2024 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nQ5D2zUB"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ADA15572C;
	Thu, 22 Aug 2024 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319436; cv=fail; b=L0mFkGS9N4i1QjzGwrl4nWIPjMDnnXtkrnjCz1k33ZZOoGsQu6qEx1JQqUtW31AdoyPumAvJCO1ySduxp3MAGhPt1tO0kR7j3gTERxzd53D9Yi39Ze/fSVEeFdTZxiRSBKGtzfJtuOVg+lMYWRPx1FmByHqpQME9efPBVfuMblU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319436; c=relaxed/simple;
	bh=pf9+vC1ows4q1/tF/v39dmUzKbkofOAkLW5t/CEPnBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XAKeS0HcRp07ucheSQs2vsiGfc8eQ7fFQWucx4LLoFb94/akg5GElmLr34maiioz07DLW4STIs+MTVDYNJdxMmeJfpBmFLsCMfgaAivpPYUJDO68covJqnsT1LMB2EIJUuuq4MYltMIY2Zweo88M0MQNl9G0spTDeO3OSwiVErw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nQ5D2zUB; arc=fail smtp.client-ip=40.107.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBOEUXZas0OT+XUjQKc7r5S5PIKC8XkUzI31yILQVQ7GkuBqiROhmC4MEdVSjy2lscjokTmhm3iQnZFXZ1WTOHLpctstzU3SMoRp35qT3K9Srpi5PmH/SWTSNw/syYoQX1RXiLfL4Hy7m97qqy8eRIg9paulN+uSi2x/+SvYiXoYrvmkisCnyhQjZcgX4wKPrnyMR80LWqDPdv0GdM0ncjEVTXGqJcRKwtyFWgqypEvzSeNu4eZv3zDhnp5lrseyZ4OpuV/GiKA7bbcQrccUtuDFT8tl4en0now6KUcFdBFAVI1IGzT9kO2OurZyE6Uu1KZ/F2CX78BHtuOI0ELg4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pf9+vC1ows4q1/tF/v39dmUzKbkofOAkLW5t/CEPnBw=;
 b=mBwbm7G006wPEiBbpfg1l1N7NHsmPdrLudvRt7/xMWC9S3YTWycmVOfW62OpFyBnlDk43Qw6N9ChZrCgot0DJ707wduB8hpzirBj/8e7X9YAWPYnsDVDrSE8U3irKfsDlgQcLT/i09XHmAjjSfJOmvfN5mdKi8yh+CUaucRXfvKWblBSb41OqkmdLxBkZKtAloObVLDJcA1CElsPkOo7Ws3cX4NeQXBdTZ+gCfl+hBvdrPMWdZib18zrkJlprl4+ReC7b0q7LNB2CcAZegcu4jFiHFaM6nx60S3nak5Khk64DFcmJrLTnv+uk89LF/cP0csb8f+jKR0jHt26m9Frvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pf9+vC1ows4q1/tF/v39dmUzKbkofOAkLW5t/CEPnBw=;
 b=nQ5D2zUBJpO6ZeVZHRU9C40kTmd798tMd+xTCnPesOr9O//X5TExx8GJojj3ekxzpYiHI/MY+cr/0H6wxi2QB/+CPlP+W465fDeYhgEfVOodFxiQWLNMEc0cu1Ion+mQrnmnNTSxH7tZXct9n917Mu/LQkctWGhjXRg8Ybzy42MsW3Y/WoH9JYXmgKjc3HlVJ4To5vEI4tyDwvoEKi41zQr8dGSLGMc9NMtSQYgUMRofu7fHu2fY0Ezq+yInd9pnSVakHum8r5spCQ4NUn4A4IJDn4S/fqSBZFerytU99goG+qGXwqyMWDMY3pa8dcxXm8SvH4/b6z6bGswKPxrMjw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8696.eurprd04.prod.outlook.com (2603:10a6:10:2df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 09:37:11 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 09:37:11 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Conor Dooley <conor@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"Andrei Botila (OSS)" <andrei.botila@oss.nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 2/3] net: phy: tja11xx: replace
 "nxp,rmii-refclk-in" with "nxp,phy-output-refclk"
Thread-Topic: [PATCH v2 net-next 2/3] net: phy: tja11xx: replace
 "nxp,rmii-refclk-in" with "nxp,phy-output-refclk"
Thread-Index: AQHa9DXVYWkEv9kTy0yrZnxZHkT8jLIy90mAgAAJVVA=
Date: Thu, 22 Aug 2024 09:37:11 +0000
Message-ID:
 <PAXPR04MB85107F19C846ABDB74849086888F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240822013721.203161-1-wei.fang@nxp.com>
 <20240822013721.203161-3-wei.fang@nxp.com>
 <20240822-headed-sworn-877211c3931f@spud>
In-Reply-To: <20240822-headed-sworn-877211c3931f@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU2PR04MB8696:EE_
x-ms-office365-filtering-correlation-id: 8c6391c8-6d8c-4ba4-896b-08dcc28dffb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?cWNGWTV2MjlwdjFpcGpicnQvYlZoMTlzUFBEMlVubmdKd3BzMlJLa1pTWkNx?=
 =?gb2312?B?TXVCaXZUTzRTWE5UUVdUc3pnQ2xRNXd4UzNYMXJhQjZoZzFvZUg1RjBScE0y?=
 =?gb2312?B?aVlNRDlwd2VON1pHZlAxWWpseklWckM2cGZabTcxYnNka2Nwc2FBZ2cwdFZR?=
 =?gb2312?B?U25jRHAwZjZSZzlqTVo1c08yaDZOeTZUVlZ4d1Q0VUREcjdWV3lQbkM3WVhC?=
 =?gb2312?B?em1Lckl3QlpVTzRyVUxRdGNnRGlhL3JDb0xwWDJDRHlKTTJyemJuZ2FFK3ov?=
 =?gb2312?B?akFxczN6UlhSamhZOE1XRmI1cjJwYnJIbnhLRFFXbW9KS051b1dWWXRwTUhm?=
 =?gb2312?B?eDRSYTl2QlAwY0M4L3ErOXJjd0s5Zy9sSi9NYy9wbFQvY3FCK3JRdURLcjZk?=
 =?gb2312?B?SUF0Y1I2Rk9WUFZpUUJRN0ZZSSs2YlVMc05yS0d1WmZYNHVvVHIweXg1emNv?=
 =?gb2312?B?SXFmMStIM3pFT3hISVhKeGNNWm9ESWR0V2pZYjd0T0ZYVkM0cG5Cd1VSaGlX?=
 =?gb2312?B?K1FCNzFsSmJNblBnUitQSGJ1VTdwbG05b24renRycEoyZXpCbDhFUWNGTk40?=
 =?gb2312?B?V3IwaVZudXhxOWZYL1d1RWhKdTJHLytZYjl2TUdrYTBzdkdQbEs1ajZHblhN?=
 =?gb2312?B?blVieGs5cHVJd1MydjYrQ2pQT09UNTVNZDRUalBuaDJGSEJIRUZyRkM1Q1JS?=
 =?gb2312?B?R3E4Z0Z6S040a0gyczBzclN5WTd6RlM3ZjlpWHRYRTlaYmZrWDl4OXNZSFNa?=
 =?gb2312?B?TUJEOUlxYUg2dDk0b1ZLMVp6NGFTc1FsWDhpZmZLT0JlMlYrZTlSRGttRUVI?=
 =?gb2312?B?V0F2WkhPeW56OFM4RG1ROWJTQkhDdCt0VnFXaG5MQWFUQnpGaDR6Vk56anh5?=
 =?gb2312?B?eklMSFNRS1pVNERNTm4yVVVqWW5VeXQwalN2TVdlVnZlN1VrVnpiZGhianpC?=
 =?gb2312?B?LzF2MWNWcFNYaFJUZnNSd1dFaEp6QXpIcTRVaTlnY0p4K1ZhVUtQL0hoa3hI?=
 =?gb2312?B?NmNnalVhczV2TG1jRmhpUXRFKzhJRnU1TzZNc1BLRVQwWGFUMjA4NGN5aGs3?=
 =?gb2312?B?cmhzTWk1b0dZbkhWc2JKNVQvSmJ1WUVVcGdvcEs1VW1uc3ZkeEM2WEVRaHRJ?=
 =?gb2312?B?Q0lORTBKNng5ZkxSVitJekJ2VzU4bTBqR3g5L0l5UDNsOVZmWjVFaWU2SDRs?=
 =?gb2312?B?d2lJYmZCNjRvT0V5UDRMNzVMVi94VHp5VlNBVnF6NkROc1F6SHgvUEQ3cDBj?=
 =?gb2312?B?VWxtOHREZjJSa2h6VWFQUjFKdjUrdjIxd0lGTCtQZStpeU1DS1lHVlRoR2NO?=
 =?gb2312?B?MUkwUTIwKzFRUllRVyt6TGNpZ1FzUm5SUW5jUkdkUDRVNU1JbmF1aU9UQUEz?=
 =?gb2312?B?cXYyYjlVYmpQSVo5VU5icnFaRjdINnVlUzdtRG5JRkJXWlg2ano4U1ljMUZE?=
 =?gb2312?B?aldEbjl3NWF4aUFlNjRXbWtkcXNzRnkybzZtSkRwUjgwQkc1V2xJbnVod0xU?=
 =?gb2312?B?bDhPZUFvTUxLYkFpV1NpTldGZW5qOEtscVM4bm1kcU5Fbko5UkJaS1c4dHk3?=
 =?gb2312?B?MUdkN2thWVRMbWZrbmgwdVVHN2E4N0lQOE5lRGdueUp0Y1RWUkFJOFBDMzdN?=
 =?gb2312?B?L1BYTDZPTjdSUzNVVDJMZkMvZWl2RG9YYUFlekt2ZkRIUERoZ1l2eUhmWVQx?=
 =?gb2312?B?YWFySHF3S0l0bkZZRmg3VHZRTkZGVUlzcUdSZTZuZmwwQW15U1ZrMWdvUWZ3?=
 =?gb2312?B?eGJVMFM3K2RLL3BEVGtYMEhVWUtwT2pFWEhkdVRPbEpOVUlMcnNNMDNBallM?=
 =?gb2312?B?YTdXeEt1NGFXc3Zyd0tCSXllK0Q2VzFFMzlRUmxEL3hXS0s1SzQ3V210R09u?=
 =?gb2312?B?UVMwblBBTW9VUi9EMVcrTjhSeG44bkhyV0lNOTNJblIvNXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?SGEydU1YTXNDRFBIQktIT21KSi9iaFdWOWxHWENwOHpBd0txeDlOeEtUclRr?=
 =?gb2312?B?UHlkRzZ6SElESXJ1blptUndQRkRmNjJlcXdHenFDWitoK1prTS9CbGdHdDFm?=
 =?gb2312?B?Y0Z6Y0l3SlNtaTdEMWYwQ3JzRmNxM3pvRC83bmFXajJZMmJwMUI4RG5pNnR2?=
 =?gb2312?B?QWJCN1FOL2VsbnozcVhXVllFU1I4Q1M2TzhHLzNBak9wejhwd3NEZHlFZDJH?=
 =?gb2312?B?NE5hdVFFQ284ODB6S1h4cUowK2o1SnVnSGJqUjFiMWFjZjN1bHd4WG54Mkxa?=
 =?gb2312?B?anhxU3A1enRRSHFOcGJKVkpqUFkwZWdWWVlVS0ZvdDRyRkhBSzZUNzZrU2ly?=
 =?gb2312?B?Z2tYOUFvVDhUWmR3UFRsT3RlSEx6b2hORmdJb0NtdmptOHdkaWxMdzRlTUxq?=
 =?gb2312?B?VXh5Wm1qTEtWbHFpUGpiZUdpWXZMZ3NmRlliM2hWL0tmZ00rTmkyRFd5d2x4?=
 =?gb2312?B?YjBoUGxJL1pOQjJ4c3pSYnlSak5CR1gyR3N2eUFqZWZYVUdGTk5BejhxdU03?=
 =?gb2312?B?YnRjSVU2QmRzLzdnbzRIUHhUeTB6ZmVhSW5SVmxxTFNEclhoZSs0MlhlaS8x?=
 =?gb2312?B?TVBGRVkrOHFuZ3ZwenBPZnhaT08wcWxhdE91OEJ6ZmVXOW9VSDBXNXpqUHpz?=
 =?gb2312?B?ZVFGaG9LOTFjcTlaSlhqRXhqaFRtMUNTb0xuR1BocWZpQnpCSnJPb21iT2ti?=
 =?gb2312?B?ZnJLUXQ4QU02NTJ2MXpMOERxRHVmUFVkVnI3OE9NajVpZENoeUk1ZHd6VWRl?=
 =?gb2312?B?R3ZDcjFHdzVRbHliWS9WZHZaNnJaSyt4MC9YbXVIK2prY1ZDS3Y0QUhGTWI1?=
 =?gb2312?B?aUNBVFY4MG1oNWdWb1VZWVEwcXBOUUUzYjhoMXpXZFo5NDZWMUppMnk4OUpJ?=
 =?gb2312?B?WjM5cWRtV2t6aHR2Qy8xZG81N25kM09Gbjg3em9QWlFxNlNVdFd2ekJpUzFU?=
 =?gb2312?B?dGVCSVg4TjVRcVVuQ0NwZ2NseUdQeWtVc1ZCL2l0Rkh0OWhEWTdpSVdGV2dP?=
 =?gb2312?B?akRSckxBcUtTTmt5Ri9mTFdnd0JtY1ZzaGFtMFdjNzJGMDR3alNKTmQ1WnZC?=
 =?gb2312?B?eTFrKzJuTVBtZTQwL05hT2lGYi9nOFc5c1BxNGFjcmoxRnNQNnlRV0NTK3NL?=
 =?gb2312?B?RU96VmZiWitLOCtBTCtVcXRwY3gzdnZ6Um1rZ09DRnQvT21LUGJRak9YeDlW?=
 =?gb2312?B?UEhTR0xTVDllU0oyOWJyNTNZbmg2emUrZmJVTFVibkswTFdvYnlkZTRuODRJ?=
 =?gb2312?B?UVpHSkF3Q04yR3NWdUNCY25oUXplcXliZ1IvL05yL1c0RENnRndmbGNiVkZI?=
 =?gb2312?B?U05wRHRERDR5RGgzWDVuY1NWdnlyNmpGcWFRNHk4MjZTZnFvNmtIVTVQSlBr?=
 =?gb2312?B?eUpJd2ZEL1lTNTlNT0wzSVZ2T1JrNFdGZlhvZjVHano2SFprUXRwZnFTMmNW?=
 =?gb2312?B?OWxmQkJBVGhWNXBDTEpEMzdHSis2MFlmRWxLeGVkZHFMQ2RXYmUrSDVKTVV0?=
 =?gb2312?B?dTZxZFc1U3gwSGtEOXdnTHBmVXZIV0FYZWhTbUxLK21lRW5wNnRRZmsrbnh1?=
 =?gb2312?B?Z1Nzeit4OXI1cmtCUTNJU1FyTWgvRVgrRWtFTm1MTjZXUzRSb3RHaWhLZTl6?=
 =?gb2312?B?dVZ0Q21tb3B6YmlyZlBreHlpZFBRdXV0TTUzNi8zNUt4cHQ2R2R0VjRuQkVz?=
 =?gb2312?B?S3N1bjhMWnhoZUc1TnhHWkZhSm5MZXZ5Smt2ZWVvQzAyUHZMUXFsVzdyREI0?=
 =?gb2312?B?a2pQUTA2Y2JZUWdSMUpaSXhNTTQzQ0JmL296NkUyalgxV1hLemV2Z3BLeEQr?=
 =?gb2312?B?Z1ZNU3BBRzk3YTg2Y0dFYkFYcFFZS0hxRFdtT3JVamVaL2tyUjlmZ1dXUEU2?=
 =?gb2312?B?WjdBYW1GdmFOMlkrbndBdUVtMUVKKzlDbi9HR3g1QkhWNlpWZitib2dtVWhk?=
 =?gb2312?B?T2k1bzNvMk1GSXB2RHlWYkx2ZjQrTkVuenRqZjhkeU1tcTJCcEV2ejk3b1gy?=
 =?gb2312?B?T2RteEZZd1QxQ0p4bE9WREloRnV4aUNOUXYxR3hXN2U5L0Q2NWN4TkgzSE9H?=
 =?gb2312?B?ZnJidFk2VURDMHFRRFFUVHNkYTdhMVB5VHRzR09FNHJZMWtpNHYydEJEMjlq?=
 =?gb2312?Q?vD+0=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6391c8-6d8c-4ba4-896b-08dcc28dffb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 09:37:11.5944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AuJr9RwXTKkEosY4L/L48o6e7GDT8Tj3KTXDlGnDki7fe4lkv1N257yo3rJIAYjClqhtFaUQJsvY7/w1oFrGFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8696

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9y
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTE6jjUwjIyyNUgMTY6NDcNCj4gVG86IFdlaSBGYW5n
IDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRA
Z29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgcm9iaEBr
ZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGFu
ZHJld0BsdW5uLmNoOyBmLmZhaW5lbGxpQGdtYWlsLmNvbTsNCj4gaGthbGx3ZWl0MUBnbWFpbC5j
b207IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgQW5kcmVpIEJvdGlsYSAoT1NTKQ0KPiA8YW5kcmVp
LmJvdGlsYUBvc3MubnhwLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjIgbmV0LW5leHQgMi8zXSBuZXQ6IHBoeTogdGphMTF4eDogcmVwbGFj
ZQ0KPiAibnhwLHJtaWktcmVmY2xrLWluIiB3aXRoICJueHAscGh5LW91dHB1dC1yZWZjbGsiDQo+
IA0KPiBPbiBUaHUsIEF1ZyAyMiwgMjAyNCBhdCAwOTozNzoyMEFNICswODAwLCBXZWkgRmFuZyB3
cm90ZToNCj4gPiBBcyB0aGUgbmV3IHByb3BlcnR5ICJueHAscGh5LW91dHB1dC1yZWZjbGsiIGlz
IGFkZGVkIHRvIGluc3RlYWQgb2YgdGhlDQo+ID4gIm54cCxybWlpLXJlZmNsay1pbiIgcHJvcGVy
dHksIHNvIHJlcGxhY2UgdGhlICJueHAscm1paS1yZWZjbGstaW4iDQo+ID4gcHJvcGVydHkgdXNl
ZCBpbiB0aGUgZHJpdmVyIHdpdGggdGhlICJueHAscmV2ZXJzZS1tb2RlIiBwcm9wZXJ0eSBhbmQN
Cj4gPiBtYWtlIHNsaWdodCBtb2RpZmljYXRpb25zLg0KPiANCj4gQ2FuIHlvdSBleHBsYWluIHdo
YXQgbWFrZXMgdGhpcyBiYWNrd2FyZHMgY29tcGF0aWJsZSBwbGVhc2U/DQo+IA0KSXQgZG9lcyBu
b3QgYmFja3dhcmQgY29tcGF0aWJsZSwgdGhlIHJlbGF0ZWQgUEhZIG5vZGVzIGluIERUUyBhbHNv
DQpuZWVkIHRvIGJlIHVwZGF0ZWQuIEkgaGF2ZSBub3Qgc2VlbiAibnhwLHJtaWktcmVmY2xrLWlu
IiB1c2VkIGluIHRoZQ0KdXBzdHJlYW0uIEZvciBub2RlcyB0aGF0IGRvIG5vdCB1c2UgIiBueHAs
cm1paS1yZWZjbGstaW4iLCB0aGV5IG5lZWQNCnRvIGJlIHVwZGF0ZWQsIGJ1dCB1bmZvcnR1bmF0
ZWx5IEkgY2Fubm90IGNvbmZpcm0gd2hpY2ggRFRTIHVzZQ0KVEpBMTFYWCBQSFksIGFuZCB0aGVy
ZSBtYXkgYmUgbm8gcmVsZXZhbnQgbm9kZXMgaW4gdXBzdHJlYW0gRFRTLg0KDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBW
MiBjaGFuZ2VzOg0KPiA+IDEuIENoYW5nZWQgdGhlIHByb3BlcnR5IG5hbWUuDQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvbmV0L3BoeS9ueHAtdGphMTF4eC5jIHwgMTMgKysrKysrLS0tLS0tLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3BoeS9ueHAtdGphMTF4eC5jDQo+ID4gYi9kcml2
ZXJzL25ldC9waHkvbnhwLXRqYTExeHguYyBpbmRleCAyYzI2M2FlNDRiNGYuLjdhYTA1OTljMzhj
Mw0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3BoeS9ueHAtdGphMTF4eC5jDQo+
ID4gKysrIGIvZHJpdmVycy9uZXQvcGh5L254cC10amExMXh4LmMNCj4gPiBAQCAtNzgsOCArNzgs
NyBAQA0KPiA+ICAjZGVmaW5lIE1JSV9DT01NQ0ZHCQkJMjcNCj4gPiAgI2RlZmluZSBNSUlfQ09N
TUNGR19BVVRPX09QCQlCSVQoMTUpDQo+ID4NCj4gPiAtLyogQ29uZmlndXJlIFJFRl9DTEsgYXMg
aW5wdXQgaW4gUk1JSSBtb2RlICovDQo+ID4gLSNkZWZpbmUgVEpBMTEwWF9STUlJX01PREVfUkVG
Q0xLX0lOICAgICAgIEJJVCgwKQ0KPiA+ICsjZGVmaW5lIFRKQTExWFhfUkVWRVJTRV9NT0RFCQlC
SVQoMCkNCj4gPg0KPiA+ICBzdHJ1Y3QgdGphMTF4eF9wcml2IHsNCj4gPiAgCWNoYXIJCSpod21v
bl9uYW1lOw0KPiA+IEBAIC0yNzQsMTAgKzI3MywxMCBAQCBzdGF0aWMgaW50IHRqYTExeHhfZ2V0
X2ludGVyZmFjZV9tb2RlKHN0cnVjdA0KPiBwaHlfZGV2aWNlICpwaHlkZXYpDQo+ID4gIAkJbWlp
X21vZGUgPSBNSUlfQ0ZHMV9SRVZNSUlfTU9ERTsNCj4gPiAgCQlicmVhazsNCj4gPiAgCWNhc2Ug
UEhZX0lOVEVSRkFDRV9NT0RFX1JNSUk6DQo+ID4gLQkJaWYgKHByaXYtPmZsYWdzICYgVEpBMTEw
WF9STUlJX01PREVfUkVGQ0xLX0lOKQ0KPiA+IC0JCQltaWlfbW9kZSA9IE1JSV9DRkcxX1JNSUlf
TU9ERV9SRUZDTEtfSU47DQo+ID4gLQkJZWxzZQ0KPiA+ICsJCWlmIChwcml2LT5mbGFncyAmIFRK
QTExWFhfUkVWRVJTRV9NT0RFKQ0KPiA+ICAJCQltaWlfbW9kZSA9IE1JSV9DRkcxX1JNSUlfTU9E
RV9SRUZDTEtfT1VUOw0KPiA+ICsJCWVsc2UNCj4gPiArCQkJbWlpX21vZGUgPSBNSUlfQ0ZHMV9S
TUlJX01PREVfUkVGQ0xLX0lOOw0KPiA+ICAJCWJyZWFrOw0KPiA+ICAJZGVmYXVsdDoNCj4gPiAg
CQlyZXR1cm4gLUVJTlZBTDsNCj4gPiBAQCAtNTE3LDggKzUxNiw4IEBAIHN0YXRpYyBpbnQgdGph
MTF4eF9wYXJzZV9kdChzdHJ1Y3QgcGh5X2RldmljZQ0KPiAqcGh5ZGV2KQ0KPiA+ICAJaWYgKCFJ
U19FTkFCTEVEKENPTkZJR19PRl9NRElPKSkNCj4gPiAgCQlyZXR1cm4gMDsNCj4gPg0KPiA+IC0J
aWYgKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChub2RlLCAibnhwLHJtaWktcmVmY2xrLWluIikpDQo+
ID4gLQkJcHJpdi0+ZmxhZ3MgfD0gVEpBMTEwWF9STUlJX01PREVfUkVGQ0xLX0lOOw0KPiA+ICsJ
aWYgKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChub2RlLCAibnhwLHBoeS1vdXRwdXQtcmVmY2xrIikp
DQo+ID4gKwkJcHJpdi0+ZmxhZ3MgfD0gVEpBMTFYWF9SRVZFUlNFX01PREU7DQo+ID4NCj4gPiAg
CXJldHVybiAwOw0KPiA+ICB9DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0K

