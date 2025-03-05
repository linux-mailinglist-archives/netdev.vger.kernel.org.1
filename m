Return-Path: <netdev+bounces-172084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0FBA50278
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 15:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78DC818919C0
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A99B24CEED;
	Wed,  5 Mar 2025 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="se24ZEZr"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2046.outbound.protection.outlook.com [40.92.107.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C389124113C;
	Wed,  5 Mar 2025 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185676; cv=fail; b=IN9TaEzkAc+9QGGz39OP0BNwpQ3lJmHQzhCNteN1uwp00RSiELV0fEQWya4UZDbP8fcdEBLUa2O3irFRieCmgc1kF9AifhyDMmmLQ6/Z4k/MwSSMZGi8te52jBkDI3hUOUTycEICx1g2bniGlpU8WLBXPziidfPQnAOSajPn2GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185676; c=relaxed/simple;
	bh=0mmiaeepogOCssgfcF4/Iblqgr3xmjLIA1iRjbC4MrE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QPqMxNXk5XGzpJ7G9/CPEzZYO/FQj6tQFN0781hapkA6lXZd4+nAm353vhWqQS+/IOTUNgfIFwfkRn257jMfFHI55UEBrSLFVt5xm9aRRjzoZv8l+H0NxClGjoH61m8JMKYPnaVikubeyZ09J2BqLpMEhKcOLHWYiAStDQYKlwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=se24ZEZr; arc=fail smtp.client-ip=40.92.107.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cn6F6XglrgDmN1DkAsH2o1SnM4an5rikiYQgq0KP3XyiOA5EPMexxilsBMBkzlQjNky8o10AUJRsllExI8OGLHWB8HebL3SoIC0QCo7MllF5ieAfaqj9AHgMbKFIbmCu+X3uKvMFxSqHW8hcz2r1KHIJ5Q4o2jErgVsHVo5VG/PrkNNOoHGoBZTBaCCYJc+0wcbq3moIAGd0yXiyD/sl3zIhJQaU4UaMGpsiF8vNLVAOlD+SZmhyAG7nE4aK6LCtQ6lU6y8eQXcDxEL3A2df2a+JQfw5iNLa+OR1hMCLdcH+q7CQbcDnGK77boCuXS2wrzNZcfIWzxisqkv+V8skYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MtEgRtV+K+fvxLInrRkANPOBFJhE3mizTO3erIZG74=;
 b=eE856ppfU/79xJJlUJsJ3XM3c/ss+0Mu5ogPAcwJ2ux5HPIASyvQyRsxAf3eLY8o/kf1C/wGDCTVYZDsAvYkEyS1zCjG09nP4zv8+CfCBDh6YqBGbFUBWzdgW+daGaNM1410TsOd9qwhA6Rog0GeUQVh0Ub5VTJ/jS5N8I74m5q3mYqR/2gEaGkK0+urRehC7k0lw/9O2pbp6g/XX6mAHHkMwzk9ZIrYKg93r2CjYBIkSwA7dTTm9jECWtG3QUt1wjC1V8gQZJLDjNTV19I0OUWS5O3LDSukM/nv+Nus0ILTFYhxUytaXCituy2ACdwsw1FC/g0b4nTrjpdmW7BD7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MtEgRtV+K+fvxLInrRkANPOBFJhE3mizTO3erIZG74=;
 b=se24ZEZrp9wADtcvKQiV2x+uepXSe4VhriPiu0H0iN+UKOZIKutB53Rs1xbDEDloUG46m9vQ5TB3UraVLOUhvh7mzrZWnAF1LS8nymsO0t1A85y1HFyQ3s2sP6zsY5f1FS+XZ4AOA5ufDpwijT61fQ0k+W1MzcpayeqdQtvQPW2+Ek+qgtlkQjdiJ4+d6oWHd0awbFZ+xESYL6PRZ2WlbFFbQNRr6ypsxN9Pf2XFLlAw+VgeV7Nx9/JTsVu17h1jeh9tyQdkxvlkJRjtPt2G2jXgKZ2CDb2Lz1p3eXNpOzZqAAafUANA1d5pf938l452RlMLSNmEMdyovx4bhPGTBw==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by SEZPR01MB6077.apcprd01.prod.exchangelabs.com
 (2603:1096:101:21e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 14:41:07 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3641:305b:41e2:6094]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3641:305b:41e2:6094%5]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 14:41:07 +0000
Message-ID:
 <TYZPR01MB5556CB47BC21C5015F698CA4C9CB2@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date: Wed, 5 Mar 2025 22:41:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: net: dsa: qca8k: add internal-PHY-to-PHY
 CPU link example
To: Andrew Lunn <andrew@lunn.ch>
Cc: "olteanv@gmail.com" <olteanv@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
 "javier.carrasco.cruz@gmail.com" <javier.carrasco.cruz@gmail.com>,
 "john@phrozen.org" <john@phrozen.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <TYZPR01MB555632DC209AA69996309B58C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556D90A3778BDF7AB9A7030C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <ae329902-c940-4fd3-a857-c6689fa35680@lunn.ch>
 <TYZPR01MB5556C13F2BE2042DDE466C95C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <55a2e7d3-f201-48d7-be4e-5d1307e52f56@lunn.ch>
 <dbd0e376-d7c3-4ba9-886b-ba9529a2ec4e@outlook.com>
 <f7ac97f4-7677-402d-99f1-ae82709a3549@lunn.ch>
From: Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <f7ac97f4-7677-402d-99f1-ae82709a3549@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID:
 <2235ab04-79fd-4e27-a4f1-5d70e9ae2361@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|SEZPR01MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c4d4ae-caf7-441b-6913-08dd5bf3c366
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|8060799006|6090799003|19110799003|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dy9McFZBN0crTDFTTEVvdy9yamJrWDJxK3RNUm1RaTZCRjVFeUVwZlhzODBl?=
 =?utf-8?B?QmtmK3lPNWd3bVBvOHBuQURrb0dBaGhYcS9wVEgybXgrOVRpRHhLMS9la3pC?=
 =?utf-8?B?cFhJSWM4blBnQzBCclRvcUJ4bHMyazBqbTRBWkl5ZHBFbVhOS2h2R3R2UWJr?=
 =?utf-8?B?N0pldE1vQ1BHZlorMWxvNGc0ZTVyOXFBK0VLUEMwRHpjYk1RZEdyZFZMUlhZ?=
 =?utf-8?B?RjdtSXpLTWFmL0ViOVptUHhzVkt6dFQrNlpOZVdVeTlQTU9udFpiTiszSjYw?=
 =?utf-8?B?d3lKLytzajdhdjhWWldsOUhudnE5djdsSDNXWjA3eTRIVVNIZ0xZZHJNZWUy?=
 =?utf-8?B?Unh0OE9HMmFKUzZjNXF6ajBEUkltYmpuSlY3eC9SNE1QMEpXQ1lLQVlNZkF2?=
 =?utf-8?B?Wk8rN1YvZDh2Y0lPNklpdm83Rkt3SkRYMEhXVndWajBNc2NZdGkyVGY0TkVh?=
 =?utf-8?B?aUJ5VnFVSStkaW1QeXZSUEtmbklHQkcrTHZXV0ZybGI0VzZ0NmJhSzFKTGdl?=
 =?utf-8?B?RFpkWTc2S0JJbEpQR0ZDK0hPM3htTFdPcE5YODY2RDc3SmkvZVZZazRqT1U1?=
 =?utf-8?B?cWVVaXNaaGJzWkhCd2FDdHpwUnBqV1cwd1RucUVYL1ZGSHhpeWkzQUo2UGQ5?=
 =?utf-8?B?aDY0ME15VVN1NmVwMGlwL045aW9FL21Xb0NsYThQaGNoY2k0bWgxMFpKYlBK?=
 =?utf-8?B?ekFmMEFXSWJBTjJpSlArUVcxUTluTytLczZFUlBmbTJKbS9odzQrSGtPOFpM?=
 =?utf-8?B?emg2K1g3VEZWQzRRQkw0N1ZrY2Y3c3cyclc2QlBNNjdQZ2UybVVOTjRNeGNq?=
 =?utf-8?B?VE5QRzN3Y2U3RkVtaTVtSytNUUZDcDRhZ2tuTWltV0JsbC9laVVacmliSkdr?=
 =?utf-8?B?dGVma0JqVWt2UStUcDJqY3lOd3ZRd0FsREVvNmkybFJQa3hZajZYQW12RThO?=
 =?utf-8?B?Qmlicmo1eEhpeFpxWVoxaUNPMEx6SUFvS0F0MWFMTm9FN05Ob3B3RGtjSnE1?=
 =?utf-8?B?MGlSWlRWaVNPRWRJZC9OdGJENUJhVHBzSkdLVnlUd2l4YjJyWGVsRTNUN2wr?=
 =?utf-8?B?My9TZVE4N0lqeTZrbWZVUzZxZ3V0UDhlVDhmRHFhOGpTNGJYMUJ5blV2Ympm?=
 =?utf-8?B?eWhiZnZqR2xya3BoUGtTSEl2MWhONUFzL3hOd25oUVUxR3h3Y3VrK0cyRUxi?=
 =?utf-8?B?aklTK1RKYUJpZGNVZkQweUZiMGxuZEtEckhnaFRCTGZlenZiWGY3Q01qRWpr?=
 =?utf-8?B?M3dId2Q2Y1FRWG82QTVVeEhScWlCNHpFYjYrYlZJcVNoYWVZTS8zbFlKQ1Rt?=
 =?utf-8?B?VVg5M1M1QTlBeGNpeSthZ3h5V2hFTmQzaEtNYWFnc1FLbE9PL0ZRWjVyZGFI?=
 =?utf-8?B?UHplNDlmWWNWajc5M0FGNjJ6NDFOMCt0dHZDNGxqVVN4bjFYNmh0NnNCVkE5?=
 =?utf-8?B?SWFpTEZVaHlFaGllTzhMa0p4TVVYWjM4V3NKSHRRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c04wTEU4ZTljNENYdlBKaXJWOWU3VkJibE0wK1RnT3Bwa1hKNkZJUHkvWURH?=
 =?utf-8?B?eUtVQ1NpN3BUUW5mTzFqOURFV0dQeUg5U200UlhJMDcwcVI1L1MrWHZKOUVa?=
 =?utf-8?B?Mnk1WEpKc1F5SE1pQ0V2MXN2ci91by9BL0JZM3RwaEdvV1ZZOHZXM1BFNW9k?=
 =?utf-8?B?VGYrNThpZEpMQURVb2I5bE5lWHlsT0p0UjBBMks4QXU3eU1RVTVCeVVoZVA5?=
 =?utf-8?B?ZmhNZGVLZDZTWlkyOWpQYThZUzJtd213OGRZT1o4Z1NiQXllU0p0Y3lVa2dm?=
 =?utf-8?B?MWdFclNyQ0tRak5lNnprQ1kxSm9id1dqRmd2N1JmVGt2OCtpOE56RTQ2WmJV?=
 =?utf-8?B?ajJOeUhQZWp1YnlGbytHSGpsVEFBcXFNOUFXTVV6L2pZUjhWZFJrWDdJcXA5?=
 =?utf-8?B?Vy9CekFBV05GeFpsb2V2OXpWbHVVZXY5RVYzOHoyWm8zVkp6cU01NlVMNWtQ?=
 =?utf-8?B?TDNrY29SWEMyTS9mL0ZiSzA0TlFpOC8rNjhxQnNRbXhQNlQ0cnNaY3VUNnFq?=
 =?utf-8?B?R2h6cnhnRWZzRnZWSnp6R3RXM3BId1Zzb01oTUozRDlJM2hZTjFUQnhGZFhN?=
 =?utf-8?B?NUVEWm9QUno1NXdneSt4WkNZOFZReXViV3FqSVZCUXRTU3AyNmNFblZKZ1kz?=
 =?utf-8?B?eFd3cHhDYTFtL2hYVS8va1hxb1orRGpnMzg5OWxRMnAwSjYwNWRqM0gzRy9h?=
 =?utf-8?B?OVMrWXpwc1l0T1UraTJrZ0lHN3ltajFGNFZQLzEwQUxnU1NGVmRMUndJeSt0?=
 =?utf-8?B?YzZnaVRqRTUzcDduOUxicC95V2FFdThyUDFjeUdSQW9ucSt0MDF6OUhlSllS?=
 =?utf-8?B?T3pGQm8wL1VMdWtyMUhySzhCTk1TV296Ym9UT3BmNjBKY0pCMzJnTEdGbk00?=
 =?utf-8?B?T2NOcytPTnZBM3N3KzRTV2lHekZHMjBiYTRKNG5odlQ0TzhFRDN6YXh2MHdD?=
 =?utf-8?B?QTgrL1JwL2NucXRsR0p3amFZb2dWVzJyL2xoRHREVldZS1dydGJVSGltK3hZ?=
 =?utf-8?B?ZWJrc0o0QnFTNjhoMlUzSHpycVNOY0d5MVVIYnpvdHRTUkM2Y01MMEluMmJI?=
 =?utf-8?B?b0dpOTZoMVhYL1d2aEJtdjZxUDZ5OTlaOXVQRHAzVXlBUHNlYVRCQjRDUTlI?=
 =?utf-8?B?NUFveWw3Q2dmSnVsUUEvQmxoSTF6bm56VE5MeGNKSzVDY1VpL1NNbFBXRElt?=
 =?utf-8?B?VUt6RkEyTC9FbWoxYkxHY2dnbHA4YllFWFRQUFhzTGU3eGdsSVdiNHlOc3lO?=
 =?utf-8?B?djFicVRDOTF6MzVMSFphbnRZaTFQT3UvMGNnaG5lS0RqK1dLRTNwM25pWFBy?=
 =?utf-8?B?bm5TWmVvUFIvblQ0RW9aYlhERFN0SS9nQUcvY3R2VWJybWorTUIzbER6M3hH?=
 =?utf-8?B?TWhJNERwTUNuY2RtM1pYbXJuaXF5Y3pqMDc2bkRhdjdkU1RsWXNScXRYbytS?=
 =?utf-8?B?R0oyQ2x2QllJQUJ1OU9TR01wSG5kamI4NTRBU1BJVEtCOXRyYUdYV3Q1dkZ0?=
 =?utf-8?B?eEttTStqVnZGMVJFeEZwRTZ5dVkwdXVrUGNVNnVaWGxiN2lHZDFiT05vNC9D?=
 =?utf-8?B?aEE0aU9jdHk1YTIvaloySTQzQ2xJTUhadytkc21wWVhvRzRSRjNQcUZuV0Vr?=
 =?utf-8?Q?BgjMOH5+Oz+OLLyn1ErJn4lLhtvGI+KJ6DKoD+RyzwPg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c4d4ae-caf7-441b-6913-08dd5bf3c366
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 14:41:07.3082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6077

在 2025/3/4 22:11, Andrew Lunn 写道:
>> (Port0 and Port6). Could I just keep this or should I need to add a new
>> case ?
> 
> The existing examples are probably sufficient. Just check the text to
> make sure it does not limit it to ports 0 and 6.
> 
>>> So is this actually internally? Or do you have a IPQ50xx SoC connected
>>> to a qca8337 switch, with copper traces on a PCB? If so, it is not
>>> internal.
>>
>> The "internal" is used to describe the localcation of PHY not the link.
>> In current code, qca8k has supported to use a external PHY to do a
>> PHY-to-PHY link (Port0 and Port6). This patch make the internal PHYs
>> support it too (Port1-5).
>>
>> The followiing topology is existed in most IPQ50xx-based router:
>>      _______________________         _______________________
>>     |        IPQ5018        |       |        QCA8337        |
>>     | +------+   +--------+ |       | +--------+   +------+ |
>>     | | MAC0 |---| GE Phy |-+--MDI--+-|  Phy4  |---| MAC5 | |
>>     | +------+   +--------+ |       | +--------+   +------+ |
>>     | +------+   +--------+ |       | +--------+   +------+ |
>>     | | MAC1 |---| Uniphy |-+-SGMII-+-| SerDes |---| MAC0 | |
>>     | +------+   +--------+ |       | +--------+   +------+ |
>>     |_______________________|       |_______________________|
> 
> So logically, it does not matter if the PHY is internal or
> external. The patch would be the same. I've even see setups where the
> SGMII link would have a PHY, then a connection to a daughter board,
> and then a PHY back to SGMII before connecting to the switch. Running
> Ethernet over the connector is easier than SERDES lines.
> 
> So i would probably drop the word internal from this discussion,
> unless it is really relevant.
> 
> 	Andrew

Ok, will remove the word in next patch

