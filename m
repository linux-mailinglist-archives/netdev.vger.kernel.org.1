Return-Path: <netdev+bounces-126548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE69971C6A
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 16:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC2D1F24E76
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 14:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FD41BA26B;
	Mon,  9 Sep 2024 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="u2g4p69d"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618011BA286
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891839; cv=fail; b=SmnpR79ggwSEjp8NLXkqv+tquJceO9XwcGy0z0I4MX64e1cGf9iEbPEuwghNS5JW2b9Pv6I4OP2Bxc/iXb8pfydP5oglNedUET5P3MA2ZYEMBASDvBHZruVQ5yUk0FlcwDqYXMzHcfWNfaogqmZp3arYGj8kxHnJa3giM3Twcvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891839; c=relaxed/simple;
	bh=fnzaJJxp8mpUR5BcixHgJItSK0iCJsdVjqtAVNT25o8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DIsFQjik/kGh2mO3HVV9hlhQs9SvPXfzgpNJuabMmj9jSIfa3hhzhJLinn+VtV9onYm/Fmlk9O0WmeC3gWPx9Vl8UYT8o1k20hZa2S/eQLmI09Plln1zAvgKE9JdRuNrlqrLgBkip9nXZmO7ldBoxiO/sZrH8BJCfAfSN1BgSNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=u2g4p69d; arc=fail smtp.client-ip=40.107.21.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2+CiGMu3lfppgfo73C8zaHNCo7qSV03+2vLDz2qk9oI2a/SZl/hP/HSHC21QR4zuQYx2hP0WcWDFXelHs2hUnsw11Ot6lqjabLLdY2RSFPCvBt5TX9nNmZ7KiIgkLOookwkKGz7NKJx6GEdGUKHpRcizt9O0zHM1ZLfT0+QP94e3OkjQhJl2f/HlBucYTCoeqh0gHNb+oGQ9V4r2/wSMGfkT/9ENxbF32XA0XDZWkPxqa/0DWA+qFIX84wv0xWxiAdSvSTMl/IU09fS8jui/oK4NnlJD+xKYUoxup64qLYGl2TVb4ph+NuqHaJcy1d5nt3pvnY9DZQkBKZRmknvQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnzaJJxp8mpUR5BcixHgJItSK0iCJsdVjqtAVNT25o8=;
 b=wkJE/qlPdgdXr1BgkM8+POT7/cIrRACVlicseUytV99mvRwgsjpLrMq7L2zNBq0aU5SxbjXAFRjsiIasSWRhD2Tp7M/zd5dmpnJVbZMwklN2ZyWIo8OII/npGK3R5utmwIRCSK0EGQMZIuqfQ2HrO9N9dRbPqpeK6vRLQup7OoiEERUdfQYmWx0371IX/D55h11QEwSfcU0VKzFnord9gVPoxGRW6tK7PgcTZgHpfh26u7sEN//ZcfmBrTKsqTJlFVLhqqD4eoYMJrEgIYfFQqfu/4eEQrGtdsNo9066xPnonbn+eJT1b6Xhh93YokkITOcCPJXovyYxvtRbYuAEnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnzaJJxp8mpUR5BcixHgJItSK0iCJsdVjqtAVNT25o8=;
 b=u2g4p69d4vqid0VU4ia1h0JUQY5eCmVlSgiJMJBQwfFWTVq6BPZZTpPxp98yi7sg5EXnZIyVRpovWVtymKOBLFqpKJlSFzCW2k9P8Jq3FQ3zYBzcG7w1VnjDUHHBUqygFymL0L12AnpoxY8pxs+qdQpNKAiisD9gW9rkdhkeb2Z7MnA3YshyEEveCpqKPxhPUbjKdu2tMUbUNmyb/JfWPL4kCywAKleklu8UytKPiiIaCi9wLLdHhVDAWjPWGECUbfcLCM+a/GeBlJXbv/V2cfF6apVnoftTG17bJmHLdEporQ8RAclzfN2n2MAlRQrENGVXF+cspbpwpNqufcpa6A==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAVPR10MB7537.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 14:23:53 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 14:23:53 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "LinoSanfilippo@gmx.de" <LinoSanfilippo@gmx.de>,
	"daniel.klauer@gin.de" <daniel.klauer@gin.de>, "davem@davemloft.net"
	<davem@davemloft.net>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"rafael.richter@gin.de" <rafael.richter@gin.de>
Subject: Re: [PATCH net] net: dsa: fix panic when DSA master device unbinds on
 shutdown
Thread-Topic: [PATCH net] net: dsa: fix panic when DSA master device unbinds
 on shutdown
Thread-Index: AQHa/qDhxv3gRVoD0kGEjqt23TbnvrJIyHgAgAa/+4CAAAIWgA==
Date: Mon, 9 Sep 2024 14:23:53 +0000
Message-ID: <7413d3aa76b4a9a98000903bc057993ea473a7c2.camel@siemens.com>
References: <20220209120433.1942242-1-vladimir.oltean@nxp.com>
	 <c1bf4de54e829111e0e4a70e7bd1cf523c9550ff.camel@siemens.com>
	 <7db5996ef488f8ca1b9fdc0d39b9e4dd1189b34b.camel@siemens.com>
	 <20240909120507.vuavas2oqr2237rp@skbuf>
In-Reply-To: <20240909120507.vuavas2oqr2237rp@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAVPR10MB7537:EE_
x-ms-office365-filtering-correlation-id: c3dbcdba-a3c3-4539-d30e-08dcd0db0851
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?anFVZk5CNGR3SmszKyt0dGhvd0p5SEdPdmhsZDliU3hwdVF3ck41M3Eyd0cr?=
 =?utf-8?B?Rm9XMm5ES0hIWUFmRjg3bUhFdFBkL0I5QU9VUUNpQldPc0xuNlhnYUo3bTBC?=
 =?utf-8?B?VkxUUUxtYUl1VjlVd0hPOU5YMmtUaUV2OXQwajZUQWZCWjMrWTF5U1k1c1lv?=
 =?utf-8?B?MUpiVW5ML1NpbFp1TU5nbDhsa0swUEkzcVNrTktCM3NZcGdCQkk4cXVQWHQy?=
 =?utf-8?B?cnJQQmwrVkRHd0tId0NCOWloQkxtRGRBZFFSQVQ3amVZd2Zya3NyUFpCVHFP?=
 =?utf-8?B?bCtyYW5ESnZHd1dlMTE4d0hrOTcxS0EvQytQN1prUmt0QXFhTlIwcUpPeENZ?=
 =?utf-8?B?YlArRFYrYTdRSGtRTkFyTW11L2kzUXVhYnhoVUp2TG95ZHR0SWhEV1h5bkFj?=
 =?utf-8?B?TXFEcXpjZERBQytaZ0x1MjBWaDEvTzV2MWxvdTgwbFdqQ0NRY2VUOG5KTXZi?=
 =?utf-8?B?ZnFpN3VzeXZpeUVpSk02d0JyN1dpeVJuazBxWEJYbzJjNm03a3pLVHVDZTlv?=
 =?utf-8?B?dEEwZms5aWVFbmljc0VMNW5RS1JGWUJGOVU5S25KU29COEJVeUlpSWVZQ2pE?=
 =?utf-8?B?WUVDeXBRQVNVNmU0dGRteWFzaEovUUt0NzFCekhUUXZrR0htaDRDcTN3aGJH?=
 =?utf-8?B?OUx6NEtoSDg2T3pNRENJejRxS2JzZFVpU2twYmp2KzFIenloUE9LVVY4NSth?=
 =?utf-8?B?OU1KNjZNUnVYaTRvMXZrMEtBQVlWYnFkQ0hGRDY5TlpHK1k3N0VRZHZSeWdF?=
 =?utf-8?B?eWplWGNNRnp1cVFycmZJKzhlQU14YjhvdzFnYStsTzh0Z0ZmNWtpZFBNZVFB?=
 =?utf-8?B?cG9Sa0JiWUN6Uk40RC9Ja2xQV0l0Vk9uQkVlbVJPNHBVWmVpdjBIbUNSK3hn?=
 =?utf-8?B?Uk4rdjlETkFUZVArRk5tRGZZVGZOS2plWm9PT2NPbDlRRVU0d1dhTGxGUHdY?=
 =?utf-8?B?eHI1RWh3TE1DWkkwcHFmd1hRMXF4aXpuYnQ3MllPTlMvQThYKzRXMTFhc3pF?=
 =?utf-8?B?ekhXdDllL2QvMUhMcHhjVmM0SE5QaXQ4MTlVS0o1TnhUVWNrL05ZZ29pbXB5?=
 =?utf-8?B?MmxVWWhXdFdZdngxeWh0VWkyYUNXN2lkcERQYWpnVnpoYytKblUyUk41NTJI?=
 =?utf-8?B?UjBzOWQ3aFJVK0ZIeThIclhwcGpBOFc5aGNZazF5V05Ud2ttR3U4TE1mcDIx?=
 =?utf-8?B?NzFnOVdiK25OK0F4bzY1WFRhSng2cDczdWVvVkdhc0hUc2dvU2k2QThPT29K?=
 =?utf-8?B?dHpYcndDZTAxM2MvNCs2eGlTOFlpQmdMaWRKRHpEd2F3KzlFNWRrRTdzaGsr?=
 =?utf-8?B?TmhvVXE4ZVNVTzMxLzJXdENJU3hoNEJ3WExQb091dVBpQmZLLzRZQXJiVXcy?=
 =?utf-8?B?VDZjNjllM0lZdVNCT0dkY20rL2FDdWROU3ZuMmN6Z3JDUk5LanRWOXJrTXZr?=
 =?utf-8?B?M25JZmZHNS96c3l5ZDUwSU9QQmkyckFmVHBXQjBmQXFsallSRTVNalBwQXZr?=
 =?utf-8?B?ZDFCQnNmTzMvbS9vV2t3cStKaGZ0ZXhTdzF3UWVhM0toanN5L1paR0VYODdH?=
 =?utf-8?B?NUI1TjhBUU45bWZ1Q3NRdlRydE5FV20vMlBWM3oyR3E0Vk5mRUFWNFhVMEpR?=
 =?utf-8?B?cS9wVExzT3FGYWRycC9xb3JvT2N5ZjQvK25VMFFLRnArK2pxeEFxNzIyWXZr?=
 =?utf-8?B?ekZxRVM5RnplM0N2dlB1QjVHb2lreU9BUFd1dURONVNHd0FiR1BmSitCYkFi?=
 =?utf-8?B?QitjTzRIVU5BNmdtVGtKNlFkQkRxSDJlZ2VGUmFLRDlZOU1rWG1ZQzZad0Rr?=
 =?utf-8?B?YlM3dWZOK0pYTi9UK2ZKdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUU2TWVYYkFxTFI3T01MZUQwQS9IRGNpS3d5alYzSTVFbFJTaUxrc29zS3RX?=
 =?utf-8?B?UXZqc1V0SUpueWZHZktBamZKaEVlT3VKdmhXZ1JIcWprZ3BKV2dnNDVIU0or?=
 =?utf-8?B?RDVhekVCdWhSZmh2d1llUm8zM2RJMEVPWUdHb1dRSUlQTnkwcS8vRWZvUjdk?=
 =?utf-8?B?L2dGYW1SS0ZwclZLYmx2MGhrNXJjLzV4aGJMSFBpUG82Vm5nTjlRR2Fmc2wv?=
 =?utf-8?B?TU5xdWh4dkJpdlFxa240RlRWaG1Rc3NPdTV3ZDN6Z0VPYnNGRzUwWGk4WE9S?=
 =?utf-8?B?cFhrTW93MWlZaXJUNitpNVlEc2lpYVc2Rml6aC9DdW5pcU5NaWRlcGFtdXA3?=
 =?utf-8?B?Q3FENE8xTjNxREl1eFFSSTRSUE5LZmx4ZmZjNmNkOWJoMkdLaWZVZjNMU282?=
 =?utf-8?B?dXA1QXIrYm1IazVOaUtqd1FINEVCeHh6UXBqMGw1b01rZktDZkhmNFhsZXhO?=
 =?utf-8?B?eVgzdUtJNWxYaEk5NTdZL0tVOGp0TWRwVnMwM0kwYTBhTC9FQVVRbEFpQ3BP?=
 =?utf-8?B?cDIyV3hReTNDN0RpUTBwcHBOaG14WVA4ajZYWjB1c0Fab2YweHpxUngxbHE4?=
 =?utf-8?B?Rnl3SU8zNmJvZkZ2S0RJd2paYWdSS2tvL2wyMmxkVkRjTDBhMy90UzkyYU43?=
 =?utf-8?B?ekpxNEc1dTFJb0Fnc0xHWStKcjVWU0liNis1NzJHelV5OTRKdFJWOHRuY0Ns?=
 =?utf-8?B?SHR1NGFnS3RWQUZhblVOdUVzWEVrVk5WRmZoVldmWTFFaTdMSXk5QVNPM1h5?=
 =?utf-8?B?a1E5NjhuR0Q1NmxwY2hRNnpvSlFYVEUrR2N1MTRUTW05bllwZlNyWGdJQUpl?=
 =?utf-8?B?c0hkVFhWY2JFdXlWUmk4OE9pOUhMV3N1MG5WdjdKd0lMWEc2b2wwTG5oSTBW?=
 =?utf-8?B?SitTQ1d3dEl2VWwwZFAySHRBVWJycElKQWNRcjVjV0FpVnZvYzhCMXB5aHNL?=
 =?utf-8?B?aFp1RmN0MGxjclorWUt0akdZLzBLRFo1b0RGN0pxZkQ2WmlJUzZ0b1R1Z1E5?=
 =?utf-8?B?K2J1ektpRm9XcHAvVGJReTdlMUU4dmVzcjVhSlBRYnBkVmRsY3JzeWZleXgy?=
 =?utf-8?B?SU56MnFrNnY5TkEzcVZLb1Y4dmxWSHQxbU0xL2daYm5rSnUzcVFRSUJrM2JE?=
 =?utf-8?B?M0dHRC9wRGQ5UmFCMmoxRHNkZVBHTkZDRGo3Uk9BZDFEczVodUpVR21OSEpw?=
 =?utf-8?B?cE9Gb0drQjRndVhkNm9VUE00NXVIYTMzQm9RWHJtb0wxVVpTaHBVaDNEdldX?=
 =?utf-8?B?dy9mREM2Zi9FZHNPM2lEL1loMFRIVlN3YXZXRkROeXVGT05VcXJLL01RdUd6?=
 =?utf-8?B?NnpjSmJGRmJEWDBjeHVMSEJ0c1hmSzYwd21EZ0pmWWFLNTBjMGZXL3ZFNTZi?=
 =?utf-8?B?SlR2Q3FYMkpjYzFubDBld0VpVlpEZ3Mrc2pHWkdmS1VSNTMwWmlrMFhxaUVO?=
 =?utf-8?B?TlJmS3h1eGJIRnh5QlJXanZOeUxHc1g4eCtnWFllUmV1TUtLS2VKRHhwTVdt?=
 =?utf-8?B?Q2g2OVFRdkN0QS9xbEljQW9CRGViYW8yNHNIN2JwTlZVQjBjemN5VjlDMFdz?=
 =?utf-8?B?ZE9BMDl4Qk4zTXJReWx0c1hHSkI2eFpzR2g2cXZBcG12aVlRQk5xc25RVGlW?=
 =?utf-8?B?NnUrUnhFMnA3Z1ozMVFmaW1UbVFFYVJ5bkE5eU1jRG5JYWZIQnVYa1JEdTRE?=
 =?utf-8?B?SU9oUmFDdjJBQ1FaUUtRbXJ4SWNkSEZoTlJ4TEVWNDg1ZS9URWVzWnhwdWZL?=
 =?utf-8?B?bVdmK0Yza0dEd3UxR0xzS29kZk44bTB5Unk3cVVHNjlpcGZ2WEZqS1hQTlRM?=
 =?utf-8?B?NCtZZlpOQndSVkhoVURrTlBwR0dvTTFBVzAzOWlpOXY2ZU1pRkVMeTU4R2M4?=
 =?utf-8?B?RlJaSDNSUDdFNWR2TXRmZndIVDdyOXpQbHY5NC9Xa3BZUDFWUHlXcWpTK2JD?=
 =?utf-8?B?RUZFYnltV1ArSjFEYmViWlp5RlZLdXMvR25PNDdWM2FSWkVvSGRMaEhrNmZz?=
 =?utf-8?B?TC9lSmpVL0FqRmtYdHVnaWF0NERuajFIQmJYQWRuZHY1eWhGaG9xbTRLNyts?=
 =?utf-8?B?dmpVeGNHOXNrMGlpZU5hL2U4REcyQkNQVnI2MWp6TWhJSjVXc2NLNGl5V2tt?=
 =?utf-8?B?ODcwdEdqZzBqQVphLzNpNWZ3VFlFNDg1dFZlRTNzaUx2cXAyM3pOT2tCUld0?=
 =?utf-8?Q?19k5wgJHJ/NFJuyKFebknHs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BAF65478C8E0D45BAC87CCA7E52BFDE@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c3dbcdba-a3c3-4539-d30e-08dcd0db0851
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 14:23:53.5499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqM+GaEIEyjvAIDMABETjSOvIY3SEl5japnZiVRICe80MlQ476vyaV1CW/Jz9woh4FGpra8p/NLrtZI0MwIqs+bd7ZYut8sXVdTPcxrcdDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7537

SGkgVmxhZGltaXIhDQoNClRoYW5rcyBmb3IgbG9va2luZyBpbnRvIHRoaXMhDQoNCk9uIE1vbiwg
MjAyNC0wOS0wOSBhdCAxNzoxNiArMDMwMCwgVmxhZGltaXIgT2x0ZWFuIHdyb3RlOg0KPiA+IGFm
dGVyIG15IGZpcnN0IGF0dGVtcHRzIHRvIHB1dCBhIGJhbmQgYWlkIG9uIHRoaXMgZmFpbGVkLCBJ
IGNvbmNsdWRlZA0KPiA+IHRoYXQgYm90aCBhc3NpZ25tZW50cyAiZHNhX3B0ciA9IE5VTEw7IiBp
biBrZXJuZWwgYXJlIGJyb2tlbi4gT3IsIGJlaW5nIG1vcmUNCj4gPiBwcmVjaXNlLCB0aGV5IGJy
ZWFrIHdpZGVseSBzcHJlYWQgcGF0dGVybg0KPiA+IA0KPiA+IENQVTAJCQkJCUNQVTENCj4gPiBp
ZiAobmV0ZGV2X3VzZXNfZHNhKCkpDQo+ID4gwqAJCQkJCWRldi0+ZHNhX3B0ciA9IE5VTEw7DQo+
ID4gwqDCoMKgwqDCoMKgwqDCoCBkZXYtPmRzYV9wdHItPi4uLg0KPiA+IA0KPiA+IGJlY2F1c2Ug
dGhlcmUgaXMgbm8gc3luY2hyb25pemF0aW9uIHdoYXRzb2V2ZXIsIHNvIHRlYXJpbmcgZG93biBE
U0EgaXMgYWN0dWFsbHkNCj4gPiBicm9rZW4gaW4gbWFueSBwbGFjZXMuLi4NCj4gPiANCj4gPiBT
ZWVtcyB0aGF0IHNvbWV0aGluZyBsb2NrLWZyZWUgaXMgcmVxdWlyZWQgZm9yIGRzYV9wdHIsIG1h
eWJlIFJDVSBvciByZWZjb3VudGluZywNCj4gPiBJJ2xsIHRyeSB0byBjb21lIHVwIHdpdGggc29t
ZSByZXdvcmssIGJ1dCBhbnkgaGludHMgYXJlIHdlbGNvbWUhDQo+IA0KPiBJJ20gdHJ5aW5nIHRv
IHVuZGVyc3RhbmQgaWYgdGhpcyByZXdvcmsgc3RpbGwgbGVhZHMgdG8gTlVMTCBkZXJlZmVyZW5j
ZXMNCj4gb2YgY29uZHVpdC0+ZHNhX3B0ciBpbiB0aGUgcmVjZWl2ZSBwYXRoPyBDb3VsZCB5b3Ug
cGxlYXNlIHRlc3Q/DQoNCkkgZGlkbid0IHRlc3QgeWV0IChJIGNhbiBkbyBpdCB0aG91Z2gpLCBi
dXQgSSBiZWxpdmUgZHNhX2NvbmR1aXRfdGVhcmRvd24oKQ0Kd2lsbCB0cmlnZ2VyIHRoZSBzYW1l
IGNyYXNoIGV2ZW50dWFsbHkuDQoNCldlIGNhbiBwcm9iYWJseSB0cmlnZ2VyIGEgTlVMTCBwb2lu
dGVyIGRlcmVmZXJlbmNlIGluIHRhZ2dpbmdfc2hvdygpIHZzIHNodXRkb3duLA0KZXRjLi4uDQoN
CkknbSBhY3R1YWxseSBjbG9zZSB0byBwdWJsaXNoaW5nIG15IFJDVSByZXdvcmsgb2YgZHNhX3B0
ciwgYnV0IEkgd291bGQgbmVlZCB0bw0KdGVzdCBpdCBhcyB3ZWxsLi4uDQoNCkknbGwga2VlcCB5
b3UgdXBkYXRlZCENCg0KPiBkaWZmIC0tZ2l0IGEvbmV0L2RzYS9kc2EuYyBiL25ldC9kc2EvZHNh
LmMNCj4gaW5kZXggNjY4YzcyOTk0NmVhLi5mMWNlNmQ4ZGM0OTkgMTAwNjQ0DQo+IC0tLSBhL25l
dC9kc2EvZHNhLmMNCj4gKysrIGIvbmV0L2RzYS9kc2EuYw0KPiBAQCAtMTU3NiwzMiArMTU3Niw3
IEBAIEVYUE9SVF9TWU1CT0xfR1BMKGRzYV91bnJlZ2lzdGVyX3N3aXRjaCk7DQo+IMKgICovDQo+
IMKgdm9pZCBkc2Ffc3dpdGNoX3NodXRkb3duKHN0cnVjdCBkc2Ffc3dpdGNoICpkcykNCj4gwqB7
DQo+IC0Jc3RydWN0IG5ldF9kZXZpY2UgKmNvbmR1aXQsICp1c2VyX2RldjsNCj4gLQlzdHJ1Y3Qg
ZHNhX3BvcnQgKmRwOw0KPiAtDQo+IC0JbXV0ZXhfbG9jaygmZHNhMl9tdXRleCk7DQo+IC0NCj4g
LQlpZiAoIWRzLT5zZXR1cCkNCj4gLQkJZ290byBvdXQ7DQo+IC0NCj4gLQlydG5sX2xvY2soKTsN
Cj4gLQ0KPiAtCWRzYV9zd2l0Y2hfZm9yX2VhY2hfdXNlcl9wb3J0KGRwLCBkcykgew0KPiAtCQlj
b25kdWl0ID0gZHNhX3BvcnRfdG9fY29uZHVpdChkcCk7DQo+IC0JCXVzZXJfZGV2ID0gZHAtPnVz
ZXI7DQo+IC0NCj4gLQkJbmV0ZGV2X3VwcGVyX2Rldl91bmxpbmsoY29uZHVpdCwgdXNlcl9kZXYp
Ow0KPiAtCX0NCj4gLQ0KPiAtCS8qIERpc2Nvbm5lY3QgZnJvbSBmdXJ0aGVyIG5ldGRldmljZSBu
b3RpZmllcnMgb24gdGhlIGNvbmR1aXQsDQo+IC0JICogc2luY2UgbmV0ZGV2X3VzZXNfZHNhKCkg
d2lsbCBub3cgcmV0dXJuIGZhbHNlLg0KPiAtCSAqLw0KPiAtCWRzYV9zd2l0Y2hfZm9yX2VhY2hf
Y3B1X3BvcnQoZHAsIGRzKQ0KPiAtCQlkcC0+Y29uZHVpdC0+ZHNhX3B0ciA9IE5VTEw7DQo+IC0N
Cj4gLQlydG5sX3VubG9jaygpOw0KPiAtb3V0Og0KPiAtCW11dGV4X3VubG9jaygmZHNhMl9tdXRl
eCk7DQo+ICsJZHNhX3VucmVnaXN0ZXJfc3dpdGNoKGRzKTsNCj4gwqB9DQo+IMKgRVhQT1JUX1NZ
TUJPTF9HUEwoZHNhX3N3aXRjaF9zaHV0ZG93bik7DQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGlu
DQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

