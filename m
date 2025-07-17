Return-Path: <netdev+bounces-207732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 658AAB0865A
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22DC188F6DD
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 07:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E68D20A5DD;
	Thu, 17 Jul 2025 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Mi1xpFdA"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022134.outbound.protection.outlook.com [40.107.75.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707DA21C16B;
	Thu, 17 Jul 2025 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752736672; cv=fail; b=lyN9Rv5YC7sj6UohO46E3Sw+CeNCLlZZCgMvhhU9QI0ZfWhQkP0lj0Q9qSTrs92TGcUjbF8zp+teOg5oe5ANXEzLahcxK1VJudo6DD9NF3mtS7HgaXfZ+iXjjSj0aydiFcIwAfrgWKtgaYZJA3zjQ36SXdL1ccl4b3tG+xWP5Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752736672; c=relaxed/simple;
	bh=U4sxxtc7nM3K0rvNjfACPc+fu2aUiy6OHnFvH2+vhQo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uh+GGt8El0N1sKauY9HLawfLVk+UdLlgU2a0xGfqXZftitNCAnsPw34bclhJCqqBta15iNf27Cfu4syKc2WJI6sfyWOdaroKn/h328jMP7VFCl1+FD+LUYk2nDLrZzejy3aEWJVj14OHCEgNCrCCN2JAETdMBHO0uXqlKtaxo8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Mi1xpFdA; arc=fail smtp.client-ip=40.107.75.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMuh0KENl0mhSjVjeA4awfsDCZUz46LFFsyILbxfvg5TcI8Gh53TF5cHIRwtgqHWmKPZ0Szc6RfZwAA4C0i+GVQbdvUPZJG4Sr6mglFOOJdCzaA8fnQReF5gGiLZLwATdmxf0xOCbFJFyiTcO+Wc8yk2l+q7Y2ovBTlGg+Tc3T2Ekm63G8Tc7ausf2FBvfdKW76DBUG18qxnrU+RTiQVPGI4rJ3Un+6oY2K3slzUnZJCX8+rBoZ2+GNlBebPjscA4bD4vivjQ5xQgbQtXvkKntRiOAHrISPSjqYgkCfcbQ3GXlA4NlyrqRGJJMI2s4pqp7uQ+MVZo1GPUZ5rcLD2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4sxxtc7nM3K0rvNjfACPc+fu2aUiy6OHnFvH2+vhQo=;
 b=gGiAMUCRtuUFn88v1CLVcF4i9pO/B3g4BNwsH6zgHT+KLTWc2MSpeNNjQ7la2eZg7v5YXrApfBjEObyvbM9TM/ZfV05oo+ztJkO50EZpJWgq7WdWrfeYohHxbCHZvte7YU1XmHGFZYEF3ABzFULNSQKYwvyp5lVqG4v7/3aUXcwmYqXMzrYrfkXQHpFnCxopCWghs35aFakLeabktZTJv11rYozcV3AskxNMSJwmWY1XPcI4OowUpiEfOcYlXPvfajmAC2jtwKmr4rNDnjOjPwZB57mSSaRGlKh491rvqxwn/Q0iY/Qc+QICYJcxATj94XKVJJmIADQEz41E1Q/vVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4sxxtc7nM3K0rvNjfACPc+fu2aUiy6OHnFvH2+vhQo=;
 b=Mi1xpFdASQaqy9kbzSw5K94gkIHOETX70jUvMFEfsK+0c93ptQEHV/CflgCprD8Fil9WwiKFElrhONLbQRLxsoVW6Ik544PUPFLsPUBylW/eMhqSjZTcZxPIXRuLt8nsF8i6Lit+EBEbLt6i+y1WlWkT5h08jeXzfl4KNTG+1JRkqAs21Vk77By7gYPC4Tv4k8n8kGPF2DNhghhrvRlvO1V6BTrnEJKDui3IK8s/xW6XhYxrY1e3pQ4WRkhwRCtfPjgG4YXdvIYxfJITQ84NzD9BRUXeILrRqe+CpCjN+XO+4oTACiPJANAiLkur3z196DDARYo7F4eN0yMyK1VLdA==
Received: from SEZPR06MB5763.apcprd06.prod.outlook.com (2603:1096:101:ab::9)
 by TYSPR06MB6970.apcprd06.prod.outlook.com (2603:1096:405:30::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Thu, 17 Jul
 2025 07:17:44 +0000
Received: from SEZPR06MB5763.apcprd06.prod.outlook.com
 ([fe80::ba6c:3fc5:c2b5:ee71]) by SEZPR06MB5763.apcprd06.prod.outlook.com
 ([fe80::ba6c:3fc5:c2b5:ee71%4]) with mapi id 15.20.8901.033; Thu, 17 Jul 2025
 07:17:44 +0000
From: YH Chung <yh_chung@aspeedtech.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, "matt@codeconstruct.com.au"
	<matt@codeconstruct.com.au>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>
CC: Khang D Nguyen <khangng@amperemail.onmicrosoft.com>
Subject: RE: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
Thread-Topic: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
Thread-Index:
 AQHb9Igk7vn3xpIukEauwkU1/K0+nrQxUL6AgAACe7CAAQ2aAIAAWoUggAMVaICAAAU3gA==
Date: Thu, 17 Jul 2025 07:17:43 +0000
Message-ID:
 <SEZPR06MB5763125EBCAAA4F0C14C939E9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
References: <20250714062544.2612693-1-yh_chung@aspeedtech.com>
	 <a01f2ed55c69fc22dac9c8e5c2e84b557346aa4d.camel@codeconstruct.com.au>
	 <SEZPR06MB57635C8B59C4B0C6053BC1C99054A@SEZPR06MB5763.apcprd06.prod.outlook.com>
	 <27c18b26e7de5e184245e610b456a497e717365d.camel@codeconstruct.com.au>
	 <SEZPR06MB5763AD0FC90DD6AF334555DA9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
 <7e8f741b24b1426ae71171dff253921315668bf1.camel@codeconstruct.com.au>
In-Reply-To:
 <7e8f741b24b1426ae71171dff253921315668bf1.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5763:EE_|TYSPR06MB6970:EE_
x-ms-office365-filtering-correlation-id: 4bb03440-4bbd-4e5b-a839-08ddc5020626
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|42112799006|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cEw0SDFjS0tvUXRuZm1sMnovbXo4eWZTT0dLNGExc2c3VjNocGJOajJ4d3Qr?=
 =?utf-8?B?azNPUTRlNHcrY2FhSHJtdGJsZ0dtNEJpNVJ5OHFETG1sb3hDeWQrYTlLa3pw?=
 =?utf-8?B?R2dYNlR0M2c5SDBBSHVOTEE1YS9GblVhdXZLMzliVktnZXRMd1JYMVdyWjhF?=
 =?utf-8?B?Qy84SnErSkFVYTI0b2lZM29td2ZZbTFwQWQ2bkpTSVNUQXBFU0hLSk9LaElt?=
 =?utf-8?B?akRxS3JpY01ObzFsL0wrUGRYcmw1N2s2NWVkdytabWNjSnpsQytuQjlOMjcz?=
 =?utf-8?B?cGEwZ0ZiTDlqSE9HMEUzMGNHbDh0YTRLOU8yTzdIZDNFV2d6QjUxQWlVdGtZ?=
 =?utf-8?B?cnVjSjcvWDkwalpZb1FSeGg0dnY2ejl1Znp5TWcwdkNsZW5UdVVPMGRoVTJI?=
 =?utf-8?B?MlJuRStadHlYS202SC9aVEhJT1NnV1ZpUEFKUUVYZFRSaGhJcXVtMjJaUHZy?=
 =?utf-8?B?UUFqOUlmR3YyWm9oZ2RvRW5HS2U4eWkxMnFxNzQweVJ4WlFKb09lQ0ZMVWJY?=
 =?utf-8?B?eWZhNy9oWEpTQytiamJwVW9KVngyWXlmV2NpTFJwZ2RhMUh5ZXJWYUMzdEFT?=
 =?utf-8?B?QWgyTUdlRWk2eU5Ga3U2SStqS2I4Mys3WkpVVDR3SVY1czNWbDQ5NzFUbEZB?=
 =?utf-8?B?Ty9uU1htRkp1V0ZFdnN1cjFrRmVjNDZvWHRJNjVucFNXVDJER1c4MHNJTHFD?=
 =?utf-8?B?bWk5bGxJMG9zdnp0NzZkYk8yelZET1FaTytEZmoya0d6ZCt3VEU0V2puSGhS?=
 =?utf-8?B?OVlnYjZOODhVbytKQU1zYmZwc2ZmZnI5bkhVbzVhR1hhYyt2dDZURVZuU3VZ?=
 =?utf-8?B?WG1jeGRSd2xXajA5T250cS9YYnlzVHlCYnozdFc3czJkZFFxV1RpUEpGeXNW?=
 =?utf-8?B?STlBN0hsbHh1NXNFQzZ1T0JPZmxpdGUzTHprTVRDVzZtSjJjNEhLd2NQN3B3?=
 =?utf-8?B?M2ZydnFRY3NVaGlNNmpISVNqcXIxYkpxSGR6YVhJa0dZVUgwRUhIdGg3VSth?=
 =?utf-8?B?TldhS0d1WStvNXpGOXVFWU81RmhXTEhpY3BVVytwUStuWnpOTXlhem55dXVl?=
 =?utf-8?B?Q0RGaGtpeGJKa3hpazV3Zk5zSW0wUkJCUmtpSzFPUDFjQVpONXZ3cUkvWGda?=
 =?utf-8?B?cnl3OUNCcXFHTVZYUXhYL1lTbmNWVU56SmlaM05yQmJRTHRHbXAzUGF6aVQy?=
 =?utf-8?B?SXJhcW4yQ0tudk85eHlCWmhpWTUwdWxOV2FyRmtyTExRRHdINDhBUERRQzRU?=
 =?utf-8?B?ZHlaNFAvaG9WRlJ5cGxVb3NrQ3BEV0FYMjhIVmJtWkpHL3U5TDJzUFErTmx6?=
 =?utf-8?B?S2hJdjRkOUFTLzZ4ZUFTUHJJY1NadWhaUDZnTkZQdWZuNXlJREhsZGZTVk1M?=
 =?utf-8?B?aFdndjg2d2Z5OVZUenVzRDFwWHpEaXoyd2JoNjFjeE9yOWlwQUNNalhtcENj?=
 =?utf-8?B?OTRpaHd3NDJhNUF6Uk1oZXFEcDJnVkJ6WDFYanZwTjAvSnJ6TXhSUzhwdGE0?=
 =?utf-8?B?WG9scFMwb01CVnJJZjdZZXRWWEFyM2o5aFNmQThaQlpMVmozK2Y0eTlINmkv?=
 =?utf-8?B?SnhtNml0ckNkbHdFOVE4QmY2WU9DK0N1Um01NnNkZnRLYXJaaHV3RHNoKzFZ?=
 =?utf-8?B?NmpsR041ak02UkV3UUczSEpMWVloRW80R3JDV1J0OGUvU1pTcHMvUmI4ZURX?=
 =?utf-8?B?NGI0a3lTVVVpejRSZGZWT1pXSFZnaWN2VDZIN0ZVMkRwc3RuTHBnc0NzeXFu?=
 =?utf-8?B?MklBNGVxNnpRZTdVWDdkcXN5YjBEUUZCRXdZMHNESHgyRWQySXBBOUc4WWpZ?=
 =?utf-8?B?dTN4b0pabHRZSFFTcEpxamJlZVgzbWRtTkFQRFVNQTJrL2MxZEVXVGgvK0cx?=
 =?utf-8?B?WXNLMTV5NlIyejM2LzN0TjRWYnliQitqbWZLdFFUM1NkK2tWSE1SV0dwQU1D?=
 =?utf-8?B?aEZ2dkFoNUp1VVBOMi82WlgwSFZFOHhpcjA2eDVOSGJRT3dGWit5QVBUY0pU?=
 =?utf-8?Q?TLLEt7ExRWU0vS1vJi8b9I+V8B1sWw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5763.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vmxsbkx3SnVXRml6MFFXWU5TWlA0UXFJYjNWdXNQV1ZPZHFqMktKNFN1dXAy?=
 =?utf-8?B?dStWNkticUF5cWJtSzlvbjV4VkdXOHA0SVdjbk9QejFLMzVnTnVNSnJtaEp6?=
 =?utf-8?B?R0VoeUZqNURiMXhzYW9naVkvQnJySVF5Sko5cHAwOHhKOVRXTFdhQkNhcDFy?=
 =?utf-8?B?dCtYdC8zczJGczZ3SEpJU1RnOTI3UnlpanE1dnN4OTh5elhjMG5uV2Zhd2tB?=
 =?utf-8?B?KytiMzhmVU01T2c3VExmaFk0dHUxR2NnbUNnalJVaVg0TkRGa1prSERGelJ6?=
 =?utf-8?B?amVuY3ZYRVltUkRXUEI1Y3ltblEreWoyK29UcDdpcWtYUWQ1U3NxMmtvU3o0?=
 =?utf-8?B?YVRLVzd4QnNNTm9SUE9zcTdmVUl3SmdwSnExdGUvcjVhQ1RFV0U0VDdvcFNS?=
 =?utf-8?B?Wm9sUk9GRkZuSUF1TWkvMHYycUQvMkkvSUk1Y0EwcUY4SFVSQ3NzU2xQWmxV?=
 =?utf-8?B?UWQrelVjZTZVRFN6TE1sL09TeVMxdGtGaW5VUTl4S1FGc0doL3FlaUsvUGMx?=
 =?utf-8?B?dCtwL0x4SG1RYkdYVDdUeThFelZxR0hxbHI2RlVqQjdnTHl1YTlKaXV4cmlK?=
 =?utf-8?B?TldKNlB4U09TUFZoMlNsUk83b1JiUDlIK3ZlblRHSENEdDVTd0tQcm8wWUpP?=
 =?utf-8?B?YzBGWmVsb1hpWG5nb3J1bnp1WVp5YXBTKzZnNFZuZXE4ZzBOOVNsRFhzbXY0?=
 =?utf-8?B?QzhSZ0ZKLzBPSWoyc29OVElCeVdPdTBZTGdnM1dtZ3YyaWJGazZ0S0tGTWxO?=
 =?utf-8?B?bHdQL2NxaWs3UmxscHZuQVFYM1lZeUpJL01HOWdiTUQ3QU9lRWNjbnlFTVR3?=
 =?utf-8?B?emFTVFFwTElxSW5PSFhBaW1HSGc0R2xjd1E2THJ6aDVRQ3hXVWhuODB0dW5V?=
 =?utf-8?B?ZzJ0OHgvbzV1aytUcmtHdG90UGlhZUVLZEFwQnRUYWxqWnZGc2dXY0U0Zk9D?=
 =?utf-8?B?L0djMVA4QjhxNEhrVERPcy9Wd1BaQlAxNlpRMkdEdFhnMCt4OXU3bG5uclpZ?=
 =?utf-8?B?Z3A5VG03SlRjV21xSERaODl0T2Z2UE9LeU9wR2lYclZPZCt4QmVUcFdsb1ps?=
 =?utf-8?B?WXBtblZYZ0grRUtxczdla25qRkt3QU1Wa2RGUHhTdzdjNk9WSmhtQ1Yvempt?=
 =?utf-8?B?UGZTeTdXUFVTYjJvYndRZGw2eUZadE1VNHhBQzJLQ2gwaGdXOU5ObkZYNWN0?=
 =?utf-8?B?SUNtVTNVRGtXWTN1Q0hjWU1NVStrdGIvZ3pEbU16dVArdmUvSFZ3cWNWTTJN?=
 =?utf-8?B?a0FJUyt2cWZuMlF3VHlVMzJmRE4zd0lXNUtqdkM3eU1mZy8rc3A3YmRLT1Mz?=
 =?utf-8?B?TnBrL1RCd1lkQ1p5NkNFNVNzbVlUemtGeEIwWHQ1bjJncGVlVnlnd0YraFBY?=
 =?utf-8?B?aWRYOGQwOWN5YXFtUlZpcUVCdGNGcW9rMFFhYWR0RFU0WHJPMmEybUoxaU9s?=
 =?utf-8?B?NjVuZ2VuSDhLdDJGekJQRUp2Yk8vT00zdVhhc21xUzVMWEtCUHB2M1NlODVm?=
 =?utf-8?B?TGk5WmZucEQzci9hSmVuRTRtdWEzc3Q0ZzVFZWpCMmdUdzBtVlVPaUhnOHBx?=
 =?utf-8?B?elNWYWZVN1k4cEJvM3N0Q0RxOFJjNzY0Y25JdmtQNUxqWm10MUEzaXg0NDVi?=
 =?utf-8?B?ZTdFVkNKSUNLQWNNTFQyYVNMaEZXM29zbWZyREJ6R0xOYW4vVS9BSW1LSE5R?=
 =?utf-8?B?YnQxdE1CU1ZTVElHZ0JvbSt1d2FnTGhvU3ZLZEU2eWhKdDVqaTIvMTgzMlMy?=
 =?utf-8?B?YkZZOHAxbEtYaHdrS1VVNlhDai9yekp2MXJBSmNXUUdGVjRiODJ0ZUZRVjM5?=
 =?utf-8?B?Rnh5Sm90YXZsa0F4TlpCNHFRaTl5eVBWb3BMUUxUdXJtUUdIVWRNeFpPMGx0?=
 =?utf-8?B?eWxKcmk5S2VYTGkzS1R2ZkZhbW5vbDVsM1RBYis1QTNiWGE3MU5oUnQ1MWQ0?=
 =?utf-8?B?MU56T0h2VnhSVFVKOElkNDc2NlBmaG1CNXFQVzdQRTduWWxDWW1CWU5OYlg4?=
 =?utf-8?B?SVVhUVdJY0dwZEFIK21hcmkrb3Y2aXBtYUYreXlxU2NnelB1eFJCT1I2K01l?=
 =?utf-8?B?U1RsMXdOWkRWRkdHdXlXQlVQdHJpOG1VSzJzRmpEM2RaTkt0NFMrNXQ0YVU0?=
 =?utf-8?Q?XC//pzWZLYeT5rRr/Zl2mU2gh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5763.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb03440-4bbd-4e5b-a839-08ddc5020626
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 07:17:44.0194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h1aCElSmsLUX8/oK6glLZzseH2SEvm8KyXTzEkyOTT6GvXQsyaA8PGSPoE7xHs2VF4VyVV+0EK/OeyZD7O0XAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6970

SGkgSmVyZW15LA0KDQo+PiA+IElzIHRoYXQgb25lIGRyaXZlciAoZm9yIGJvdGggMjYwMCBhbmQg
MjcwMCkgb3IgdHdvPw0KPj4gPg0KPj4gSXQncyB3cml0dGVuIGluIG9uZSBmaWxlIHRvIHJldXNl
IGNvbW1vbiBmdW5jdGlvbnMsIGJ1dCB0aGUgYmVoYXZpb3INCj4+IGlzIHNsaWdodGx5IGRpZmZl
cmVudCBkZXBlbmRpbmcgb24gdGhlIGhhcmR3YXJlLg0KPg0KPk9LLCBidXQgaXQncyBzdGlsbCB0
aGUgb25lIGRyaXZlciAob25lIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgaGFuZGxpbmcgbXVsdGlw
bGUNCj5vZl9kZXZpY2VfaWQgbWF0Y2hlcyksIGFuZCB0aGVyZSdzIG9ubHkgb25lIGluc3RhbmNl
IHdoZXJlIHlvdSdyZSBpbnRlcmFjdGluZw0KPndpdGggdGhlIG1jdHBfcGNpZV92ZG0gQVBJLiBT
byB0aGF0IHdvdWxkIGJlIGEgc2luZ2xlIHVzZXIgb2YgdGhlIHByb3Bvc2VkDQo+YWJzdHJhY3Rp
b24uDQo+PiA+IEknbSBzdGlsbCBub3QgY29udmluY2VkIHlvdSBuZWVkIGFuIGFic3RyYWN0aW9u
IGxheWVyIHNwZWNpZmljYWxseQ0KPj4gPiBmb3IgVkRNIHRyYW5zcG9ydHMsIGVzcGVjaWFsbHkg
YXMgeW91J3JlIGZvcmNpbmcgYSBzcGVjaWZpYyBkcml2ZXINCj4+ID4gbW9kZWwgd2l0aCB0aGUg
ZGVmZXJyYWwgb2YgVFggdG8gYSBzZXBhcmF0ZSB0aHJlYWQuDQo+PiA+DQo+PiBXZSBmb2xsb3dl
ZCB0aGUgc2FtZSBpbXBsZW1lbnRhdGlvbiBwYXR0ZXJuIGFzIG1jdHAtaTJjIGFuZCBtY3RwLWkz
YywNCj4+IGJvdGggb2Ygd2hpY2ggYWxzbyBhYnN0cmFjdCB0aGUgaGFyZHdhcmUgbGF5ZXIgdmlh
IHRoZSBleGlzdGluZw0KPj4gaTJjL2kzYyBkZXZpY2UgaW50ZXJmYWNlIGFuZCB1c2UgYSBrZXJu
ZWwgdGhyZWFkIGZvciBUWCBkYXRhLg0KPg0KPllvdSdyZSBjb21iaW5nIHR3byBjb25jZXB0cyB0
aGVyZTogdGhlIHVzZSBvZiBhIHdvcmtxdWV1ZSBmb3IgdHJhbnNtaXQsIGFuZA0KPnRoZSB1c2Ug
b2YgYSBkcml2ZXIgYWJzdHJhY3Rpb24gbGF5ZXIgYmV0d2VlbiB0aGUgaGFyZHdhcmUgYW5kIHRo
ZSBNQ1RQDQo+bmV0ZGV2Lg0KPg0KPlNvbWUgZXhpc3RpbmcgTUNUUCB0cmFuc3BvcnQgZHJpdmVy
cyBoYXZlIHRoZSBkZWZlcnJlZCBUWCB2aWEgd29ya3F1ZXVlLCBidXQNCj5ub25lIGhhdmUgYW4g
YWJzdHJhY3Rpb24gbGF5ZXIgbGlrZSB5b3UgYXJlIHByb3Bvc2luZyBoZXJlLg0KPg0KRnJvbSBt
eSBwZXJzcGVjdGl2ZSwgdGhlIG90aGVyIE1DVFAgdHJhbnNwb3J0IGRyaXZlcnMgZG8gbWFrZSB1
c2Ugb2YgYWJzdHJhY3Rpb24gbGF5ZXJzIHRoYXQgYWxyZWFkeSBleGlzdCBpbiB0aGUga2VybmVs
IHRyZWUuIEZvciBleGFtcGxlLCBtY3RwLWkzYyB1c2VzIGkzY19kZXZpY2VfZG9fcHJpdl94ZmVy
cygpLCB3aGljaCB1bHRpbWF0ZWx5IGludm9rZXMgb3BlcmF0aW9ucyByZWdpc3RlcmVkIGJ5IHRo
ZSB1bmRlcmx5aW5nIEkzQyBkcml2ZXIuIFRoaXMgaXMgZWZmZWN0aXZlbHkgYW4gYWJzdHJhY3Rp
b24gbGF5ZXIgaGFuZGxpbmcgdGhlIGhhcmR3YXJlLXNwZWNpZmljIGRldGFpbHMgb2YgVFggcGFj
a2V0IHRyYW5zbWlzc2lvbi4NCg0KSW4gb3VyIGNhc2UsIHRoZXJlIGlzIG5vIHN0YW5kYXJkIGlu
dGVyZmFjZeKAlGxpa2UgdGhvc2UgZm9yIEkyQy9JM0PigJR0aGF0IHNlcnZlcyBQQ0llIFZETS4g
U28sIHRoZSBwcm9wb3NlZCBkcml2ZXIgdHJpZXMgdG8gaW50cm9kdWNlIGEgdW5pZmllZCBpbnRl
cmZhY2UsIGRlZmluZWQgaW4gbWN0cC1wY2llLXZkbS5oLCB0byBwcm92aWRlIGEgcmV1c2FibGUg
aW50ZXJmYWNlIHRoYXQgYWxsb3dzIGRldmVsb3BlcnMgdG8gZm9jdXMgb24gaGFyZHdhcmUtc3Bl
Y2lmaWMgaW1wbGVtZW50YXRpb24gd2l0aG91dCBuZWVkaW5nIHRvIGR1cGxpY2F0ZSBvciByZXdv
cmsgdGhlIHRyYW5zcG9ydCBiaW5kaW5nIGxvZ2ljIGVhY2ggdGltZS4NCg0KQ291bGQgeW91IGtp
bmRseSBzaGFyZSB5b3VyIHRob3VnaHRzIG9yIGd1aWRhbmNlIG9uIGhvdyB0aGUgYWJzdHJhY3Rp
b24gbW9kZWwgdXNlZCBpbiBvdXIgUENJZSBWRE0gZHJpdmVyIGNvbXBhcmVzIHRvIHRoZSBleGlz
dGluZyBhYnN0cmFjdGlvbnMgdXNlZCBpbiBJMkMvSTNDIHRyYW5zcG9ydCBpbXBsZW1lbnRhdGlv
bnM/DQoNCj5JbiB0aGUgY2FzZSBvZiBJMkMgYW5kIEkzQywgd2UgY2Fubm90IHRyYW5zbWl0IGRp
cmVjdGx5IGZyb20gdGhlDQo+LT5uZG9fc3RhcnRfeG1pdCgpIG9wLCBiZWNhdXNlIGkyYy9pM2Mg
b3BlcmF0aW9ucyBhcmUgZG9uZSBpbiBhDQo+c2xlZXBhYmxlIGNvbnRleHQuIEhlbmNlIHRoZSBy
ZXF1aXJlbWVudCBmb3IgdGhlIGRlZmVyIGZvciB0aG9zZS4NCj4NClVuZGVyc3Rvb2QsIHRoYW5r
cyBmb3IgdGhlIGNsYXJpZmljYXRpb24hDQoNCj5Ib3dldmVyLCBJIHdvdWxkIGJlIHN1cnByaXNl
ZCBpZiB0cmFuc21pdHRpbmcgdmlhIHlvdXIgcGxhdGZvcm0gUENJZSBWRE0NCj5pbnRlcmZhY2Ug
d291bGQgcmVxdWlyZSBibG9ja2luZyBvcGVyYXRpb25zLiBGcm9tIHdoYXQgSSBjYW4gc2VlLCBp
dCBjYW4gYWxsIGJlDQo+YXRvbWljIGZvciB5b3VyIGRyaXZlci4gQXMgeW91IHNheToNCj4NCj4+
IFRoYXQgc2FpZCwgSSBiZWxpZXZlIGl0J3MgcmVhc29uYWJsZSB0byByZW1vdmUgdGhlIGtlcm5l
bCB0aHJlYWQgYW5kDQo+PiBpbnN0ZWFkIHNlbmQgdGhlIHBhY2tldCBkaXJlY3RseSBkb3dud2Fy
ZCBhZnRlciB3ZSByZW1vdmUgdGhlIHJvdXRlDQo+PiB0YWJsZSBwYXJ0Lg0KPj4NCj4+IENvdWxk
IHlvdSBraW5kbHkgaGVscCB0byBzaGFyZSB5b3VyIHRob3VnaHRzIG9uIHdoaWNoIGFwcHJvYWNo
IG1pZ2h0DQo+PiBiZSBwcmVmZXJhYmxlPw0KPg0KPlRoZSBkaXJlY3QgYXBwcm9hY2ggd291bGQg
ZGVmaW5pdGVseSBiZSBwcmVmZXJhYmxlLCBpZiBwb3NzaWJsZS4NCj4NCkdvdCBpdC4gVGhlbiB3
ZSdsbCByZW1vdmUgdGhlIGtlcm5lbCB0aHJlYWQgYW5kIGRvIFRYIGRpcmVjdGx5Lg0KDQo+Tm93
LCBnaXZlbjoNCj4NCj4gMSkgeW91IGRvbid0IG5lZWQgdGhlIHJvdXRpbmcgdGFibGUNCj4gMikg
eW91IHByb2JhYmx5IGRvbid0IG5lZWQgYSB3b3JrcXVldWUNCj4gMykgdGhlcmUgaXMgb25seSBv
bmUgZHJpdmVyIHVzaW5nIHRoZSBwcm9wb3NlZCBhYnN0cmFjdGlvbg0KPg0KPi0gdGhlbiBpdCBz
b3VuZHMgbGlrZSB5b3UgZG9uJ3QgbmVlZCBhbiBhYnN0cmFjdGlvbiBsYXllciBhdCBhbGwuIEp1
c3QgaW1wbGVtZW50DQo+eW91ciBoYXJkd2FyZSBkcml2ZXIgdG8gdXNlIHRoZSBuZXRkZXYgb3Bl
cmF0aW9ucyBkaXJlY3RseSwgYXMgYSBzZWxmLWNvbnRhaW5lZA0KPmRyaXZlcnMvbmV0L21jdHAv
bWN0cC1wY2llLWFzcGVlZC5jLg0KPg0KPj4gV291bGQgeW91IHJlY29tbWVuZCBzdWJtaXR0aW5n
IGJvdGggZHJpdmVycyB0b2dldGhlciBpbiB0aGUgc2FtZSBwYXRjaA0KPj4gc2VyaWVzIGZvciBy
ZXZpZXcsIG9yIGlzIGl0IHByZWZlcmFibGUgdG8ga2VlcCB0aGVtIHNlcGFyYXRlPw0KPg0KPkkg
d291bGQgcmVjb21tZW5kIHJlbW92aW5nIHRoZSBhYnN0cmFjdGlvbiBhbHRvZ2V0aGVyLg0KPg0K
PklmLCBmb3Igc29tZSByZWFzb24sIHdlIGRvIGVuZCB1cCBuZWVkaW5nIGl0LCBJIHdvdWxkIHBy
ZWZlciB0aGV5IHRoZXkgYmUNCj5zdWJtaXR0ZWQgdG9nZXRoZXIuIFRoaXMgYWxsb3dzIHVzIHRv
IHJldmlldyBhZ2FpbnN0IGFuIGFjdHVhbCB1c2UtY2FzZS4NCj4NCk9rYXksIHdl4oCZbGwgaW5j
bHVkZSBpdCBpbiB0aGUgbmV4dCBwYXRjaCBzZXJpZXMgb25jZSB3ZeKAmXZlIHJlYWNoZWQgYSBj
b25jbHVzaW9uIG9uIHRoZSBhYnN0cmFjdGlvbi4NCg0KPj4gPiBPSywgc28gd2UnZCBpbmNsdWRl
IHRoZSByb3V0aW5nIHR5cGUgaW4gdGhlIGxsYWRkciBkYXRhIHRoZW4uDQo+PiA+DQo+PiBDb3Vs
ZCB5b3Ugc2hhcmUgaWYgdGhlcmUncyBhbnkgcHJlbGltaW5hcnkgcHJvdG90eXBlIG9yIGlkZWEg
Zm9yIHRoZQ0KPj4gZm9ybWF0IG9mIHRoZSBsbGFkZHIgdGhhdCBjb3JlIHBsYW5zIHRvIGltcGxl
bWVudCwgcGFydGljdWxhcmx5DQo+PiByZWdhcmRpbmcgaG93IHRoZSByb3V0ZSB0eXBlIHNob3Vs
ZCBiZSBlbmNvZGVkIG9yIHBhcnNlZD8NCj4NCj5FeGNlbGxlbnQgcXVlc3Rpb24hIEkgc3VzcGVj
dCB3ZSB3b3VsZCB3YW50IGEgZm91ci1ieXRlIHJlcHJlc2VudGF0aW9uLA0KPmJlaW5nOg0KPg0K
PiBbMF06IHJvdXRpbmcgdHlwZSAoYml0cyAwOjIsIG90aGVycyByZXNlcnZlZCkNCj4gWzFdOiBz
ZWdtZW50IChvciAwIGZvciBub24tZmxpdCBtb2RlKQ0KPiBbMl06IGJ1cw0KPiBbM106IGRldmlj
ZSAvIGZ1bmN0aW9uDQo+DQo+d2hpY2ggYXNzdW1lcyB0aGVyZSBpcyBzb21lIHZhbHVlIGluIGNv
bWJpbmluZyBmb3JtYXRzIGJldHdlZW4gZmxpdC0gYW5kDQo+bm9uLWZsaXQgbW9kZXMuIEkgYW0g
aGFwcHkgdG8gYWRqdXN0IGlmIHRoZXJlIGFyZSBiZXR0ZXIgaWRlYXMuDQo+DQpUaGlzIGxvb2tz
IGdvb2QgdG8gbWXigJR0aGFua3MgZm9yIHNoYXJpbmchDQo+S2hhbmc6IGFueSBpbnB1dHMgZnJv
bSB5b3VyIHNpZGUgdGhlcmU/DQo+DQo+Q2hlZXJzLA0KPg0KPg0KPkplcmVteQ0K

