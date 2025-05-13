Return-Path: <netdev+bounces-190231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7649AAB5CD3
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 20:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015494C0235
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 18:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E19C2BF975;
	Tue, 13 May 2025 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="EcdUq5LA";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="EcdUq5LA"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022128.outbound.protection.outlook.com [52.101.66.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88C748F;
	Tue, 13 May 2025 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.128
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162266; cv=fail; b=t8F9oqjjKX591A6km4z6BS9gZSbyULisxo6lcO7+xGnWQ0NS2tdaVgWfj1vHbb22lLnn8DyivmFuRHwf4OPpgZUn87ehfuxlgR43+iEF6en2Uk8vG+gHcmNIFAxdiwg6uzwL9gkTllUBPRWoeTYEc/w2lpsV613tacBM7+fG5uA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162266; c=relaxed/simple;
	bh=CtTGTOnrT6KAwOBbJJc76l6ZWHb+25y+IcnPe76wRJE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lbe7n6UrOU3qlPb1KvsAKxwoSw2fOuAVFMLKfj06NUaV5GXOt7eVtjsMOIHPMNaW9PlzPYzHpP3BmfUlwDMUOPiJx8hdV6zNS7I3/pC2/9NOZ5Lr2o78LH/4Z1xerGu4wffsTCNOyjecbqFLcZQX2dME4xjoMq9HTHWvw/AAg60=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=EcdUq5LA; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=EcdUq5LA; arc=fail smtp.client-ip=52.101.66.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xZJJlvCk/KIK8WBbhlNl2qdtJgupnmypj0G2srF5mM88XW1X8VX5gQd8b/guWhg5k82CFpHpw4+68yc4PPRjM0exEFesc9uCLqn9w7BGmWeKsSiI/ve2r7jch1sc36gdnrDSCfOaAfW0+uV06TA9UMhhNflYZjAcQkubMuIVKezMp4FF3xeJprliZwIpzXRaa4R5D4LwqoaGkgjKeNR7GtT0JfT73hJ4OkFyobzzFWRXGzDIAHKl9DIpFNvmaY1GjgSj/aBok5D3pal5P/wcBCWYfksaxjtCnPCUKpICjA7ms08cIMZ9jnNhoW1Xky+c99OjJqOOj1WY2k1ccFNKCQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS5lmZxJfD8FvyZkXA8alDuOO2UQskfM3Cq21GLWInI=;
 b=MW1y3CqYLGTUwuc1wqA24gTlSl5plbXbxZEY7y6nR9LFKk6PiTayNAKIzD10w1hkpfrs3/4IKsOezL64od/HhGVa43d/YIYw/0ZVEultMviY1l98351REMkarlkI05MQDdvcc9P+o3u/C2K8OewSWwwtoJmZq8ulkj+Ao94CMNOjs7dN6mdIKQhRB0vxGupsgezM5dpFpLxK9wWUdgyXPR4nmHkbatdFPz3G/CZsxKlKKtWIgCyoL9lXxElPLI2CLHn0LQmNJxyHGeEVMQe5Ul+PDiaIjIBzIkPMGrSl8t3nfzqMNtp7L7TxC/w/BCqOge67Jks07D8LUwhipqySOw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.81) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS5lmZxJfD8FvyZkXA8alDuOO2UQskfM3Cq21GLWInI=;
 b=EcdUq5LAFlKmUDh2bQfPEVve47v8XTAX98DlXpUb5cWqc9t6+rkBCpAfey9UPJF0eqWRTrE0oH92JTkvFXcLXS9atw5/4V829IqNoMvRhfhtvaJQpXXrhXIVsp6DGQ1NVYxsDEYhfDLDrsWOylJ+1hBxbZS1LV9w1GbUkkJv1Z49qhWUNCeVPEMqKEbgLOztDmIXzMGm7TbSxuW/dmj+X42Ojyo6MExvLElH6Q9dQnuwhukbBNfR63GUiya3QDUgBD5qeMla6ukLsFF2hTSvDNOBUd6a15e2lGf7/JVG7yt9ceFI9fn4OXtsayH/NnexK2yj9XEvMLOL3BPYugb1Yw==
Received: from DB7PR03CA0099.eurprd03.prod.outlook.com (2603:10a6:10:72::40)
 by AM7PR03MB6580.eurprd03.prod.outlook.com (2603:10a6:20b:1b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 18:50:59 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:72:cafe::b9) by DB7PR03CA0099.outlook.office365.com
 (2603:10a6:10:72::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Tue,
 13 May 2025 18:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.81)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.81 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.81; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.81) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Tue, 13 May 2025 18:50:58 +0000
Received: from outmta (unknown [192.168.82.140])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 4C5BF20080268;
	Tue, 13 May 2025 18:50:58 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (unknown [104.47.11.238])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 2F0832008006F;
	Tue, 13 May 2025 18:50:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDcdpZzdhQPZG/RC4dsT25QLRI4YthT+qNv1+OszMdcj4fPDgNSrdbUn0VR1B7fTpLtOH+wkGprutm39D2sNJw35eAs2kidh8nMCmy8MZlwlCx9ZnpU05Si9iE+qgyaBv4NpbbgWi+GBW4bQJEcxC6EJzgooVPlh+o9+z7yiIRrbfgZkDMqwAStPHz9BNassrXPXbcbKt2Hn4BUp/MgTOeVPDzWvtNSoZb+D6UFUEgIBOXpIx+Iy/QGin88IExbsPGReZMzDxUbZS4EWu0jlEMSe1k4VkypiYb5BDlTCcdvtwDwTKFh0VwwvTrK9QtPpAfYKvCV6QNW4ORh4gcUxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS5lmZxJfD8FvyZkXA8alDuOO2UQskfM3Cq21GLWInI=;
 b=leYf6GVm0kp+T/ItcstKbneOg1ksg7Os3SEqYAHQ6FIph8Wel4Hkw/9+Jm800BA3A3MBCUGMMt5xvS1KFyCQLJuZVxxQM34Luay3ZKZPwBoqyTzSxsDtRxFlUiqSP6+XaPNgv9078G3Fs1jvoZrb4xZuB+JLpYIyEt9LyEAiTpWEUAUyKbAollFeBMfea7BlQY2G8DqpS17W1x9Z2oRdvmCh6XE0dMwx1uDtAfumXmsx75D0oT9kOZgta7OC6U9uXG5Xn1PID5hCzSbZwFklfcFJ/VllUbyG/FY606XWquZbr5CL4gtZW8A5aG3t++fmidD6zvamYJPapXmeCoidng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS5lmZxJfD8FvyZkXA8alDuOO2UQskfM3Cq21GLWInI=;
 b=EcdUq5LAFlKmUDh2bQfPEVve47v8XTAX98DlXpUb5cWqc9t6+rkBCpAfey9UPJF0eqWRTrE0oH92JTkvFXcLXS9atw5/4V829IqNoMvRhfhtvaJQpXXrhXIVsp6DGQ1NVYxsDEYhfDLDrsWOylJ+1hBxbZS1LV9w1GbUkkJv1Z49qhWUNCeVPEMqKEbgLOztDmIXzMGm7TbSxuW/dmj+X42Ojyo6MExvLElH6Q9dQnuwhukbBNfR63GUiya3QDUgBD5qeMla6ukLsFF2hTSvDNOBUd6a15e2lGf7/JVG7yt9ceFI9fn4OXtsayH/NnexK2yj9XEvMLOL3BPYugb1Yw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by DU6PR03MB10944.eurprd03.prod.outlook.com (2603:10a6:10:5c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Tue, 13 May
 2025 18:50:54 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 18:50:54 +0000
Message-ID: <19547e54-1253-409d-8e89-a395fed478a0@seco.com>
Date: Tue, 13 May 2025 14:50:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 11/11] net: airoha: add phylink support for
 GDM2/3/4
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 llvm@lists.linux.dev
References: <20250511201250.3789083-1-ansuelsmth@gmail.com>
 <20250511201250.3789083-12-ansuelsmth@gmail.com>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20250511201250.3789083-12-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL6PEPF0001641C.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:11) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR03MB9020:EE_|DU6PR03MB10944:EE_|DB3PEPF0000885A:EE_|AM7PR03MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d6ea6b0-e36d-48eb-6860-08dd924f19ad
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?V3J4L2MvcExmQmtKcmhwbEVvcVhaVE1kZWVWNlB3aWYvOVpacVcyRGc5Ky9i?=
 =?utf-8?B?QkFvNEJscXFJUU43a1hHd0tpV3BzWERFenRUWEJQR1JDN3hpSnBJa3RLdU1x?=
 =?utf-8?B?eGFCTWRlTVlicitXdW1aZnpmL1lBZ3IwRitWei95Y2tuV0M1OHIrKzdmTExy?=
 =?utf-8?B?bmg2OWlqOGorVUwrdjJiMmNoMVBTL3I2V2F3SXlyaWhISVNuVnN2WWxQcTBi?=
 =?utf-8?B?NXJ4TTI4dU0zU01qYTNmenlBeXNNdkoxZGF4N3VYTmE5bXhuQ2krT243ZXhq?=
 =?utf-8?B?Rk5ITE1GVk1ERXU4ZW04d1E1T3JLVTBJeSszUmlkV0RkcTNjOTBjMjdqOU5k?=
 =?utf-8?B?Sms1ZlQ0UDFRUlR1cE9YUGc1V3cxdHp3dk5RL0N2QkhyYVVtVUVVRHcwOWQ4?=
 =?utf-8?B?VDNXOWs5OEx2a2hQZFRzZmNZZndsVGVMc2JFRzNCY1VUY0VTdEZqSWlTNi9s?=
 =?utf-8?B?aFFoV0NhMlNiMWtOTnJmSXZmWkNjbll0VHRuRHU3bnBmdyttQms3SE5STkov?=
 =?utf-8?B?VWFUSmZCRmxxV24vaGd4Y2w1Q1RyYXE2N3lJaHNxS0tRTXlLaTNMSUZsQ0lu?=
 =?utf-8?B?MU1aa3FoNDlBL1p5YWxmYW95ZEVGRjF1elVjYXEyL3RaWFdvdlhOZkFVK3Iw?=
 =?utf-8?B?TWo5ZERlNTdqQisxYlhEb1k0UjAwUlFWQklkYnJBZWd0cE1EeXpyY1ZWbTBO?=
 =?utf-8?B?cGwyUWVyakZRR1VEZWlUL2hZZWZnMHRyV2c4SmpCVENUazdWOTE0eC9KY1FK?=
 =?utf-8?B?b0tpQWpselBtL1JXY3FuajlIMnhXcU5nMFhvcHlrLzdQN1dZbjQ5cW91RWRE?=
 =?utf-8?B?VlhjNDZJc0hpbzJmUG40QTFHL0phbkR0TXZ6NGJhR1BCYmcvNnBNUXN0Ly9u?=
 =?utf-8?B?Nzk2TytiWCthZG9pRUc4a1VGRGVHdHNDbnRxSUpBTDJZR2RvWi9CdUJ4dHRX?=
 =?utf-8?B?WFUzNUxnK1lweW90dGllajFEUU4vaGNpVEJkNE8xSEVZeUwrUHppYjRicVZO?=
 =?utf-8?B?ZG5oZjhFaXpWTTVkZ1ZmUHVHRk1XQWZobEw0OElmNDNRL08vS29TaHJFYm13?=
 =?utf-8?B?eDZwRkMxTUFacElHczdRYldVQ0dGd08vNkw5eXYwc05rbjRQcFVTZUZlQ3BX?=
 =?utf-8?B?M1kyUCt4WjJ6S2tha3NWOGM2TDlYd3Y5RSs1Rm5BU2hLQ2lETWNmUFJvSlEv?=
 =?utf-8?B?bnRTcDE3T0EzeGk5MDN3WWdQWG96cFFIZ3NSYmJPcXhpd1JXK3FlMWlxOXVv?=
 =?utf-8?B?MHFEbEx4WVBuQVdMVnliOERYdDY0WHgyOEN1RmVlNGVma3NqWHRXWFFTK0VM?=
 =?utf-8?B?SlNKYUo3WnQ3elJ5NXJmU1JnanhVRmlJWmpXMDBVSHBROWpBTzF5R2NYaUVn?=
 =?utf-8?B?eit4RUxYbWpIMjhQTFpKWTArKzRXblozUHBub1BweHl3RXFpWVE5Y2tkRHpt?=
 =?utf-8?B?U2JTdGRSQndVUjhKK1g5MWwyOE5XTFUweFZuR245Ynd0Z1NKMDVuTFpUYUEz?=
 =?utf-8?B?OTFvTW5tTmg2c2ZHbkJLZE0rSEU2Q0xjbnhNb3h0ZDVIc01uUUtlUnpyUUNu?=
 =?utf-8?B?ZVFrM1dsQ3RlczUvREQ4ZXNWRmZaNU1BRlordGp3L1Z1V3NjLzAxaVRjcGdN?=
 =?utf-8?B?bUIwK1V0N2tBMUtGMlptM3orbWxoYVZwaW1hcTZjYXVkZnlQS3F1azl6NThk?=
 =?utf-8?B?a2RlSVNKdDNncndVY2NPS1UrTHRGMXIyU2tNMXlZT3Z5WlJiVXEweE5LRHRP?=
 =?utf-8?B?cExZV2V4QkRMc3MxZFRvRVU1U2NrTEo3MDM4Y3pjMUQydlNlUEVQaG1OSUFJ?=
 =?utf-8?B?Rmh2aHFGd0tWVDl0cXkyWDhLY1hSTTg3TWNTQ093U3c5TEYrUWdVY2ZxZDNQ?=
 =?utf-8?B?SHdpUnVxTWlndXNNRVlUTXlNZVNabXF5NUhjY0lWR0tJZFc3N0h5cFdjTVYz?=
 =?utf-8?B?WFhqdTlzVEVOSmw0bmtqNGJtV0lNZFpZWndzS1FtZXV3aXppWHJlVGJzTnht?=
 =?utf-8?B?NlFGNmdrYmlnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB9020.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR03MB10944
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	95985f8a-dfaf-49c7-d01e-08dd924f1703
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|14060799003|376014|82310400026|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anlOSTdpYXU5bk5XNHZaVEF3RHREWHIxZTN0RDgwQ3JWZmo1ck9WaGxzckRz?=
 =?utf-8?B?SjJGdkl3SDBwVEZhbXpCTFBZOVhZM2crSnR4dFg0bzUrRmR1Q1VvQWxiMXVj?=
 =?utf-8?B?WFdWU0dwLzJKVnBGQmVpRW92WjZqcEgwVGV5em8yRzRhYWZKVG5mS0RJQ0JO?=
 =?utf-8?B?cVBpTVV4RkhVQ0dSdG1NNHBqYjhFb2ZUcDQ5VzdKNDFZTUFvTEtSeTNyTTFn?=
 =?utf-8?B?ZzdHdWZ0azF1NlhFcFlQbWlXQTlYTTBTeitZL3A5TVVaS2Q0TEhIcEFBQUc3?=
 =?utf-8?B?c2ZkNVNRalJqaVExQ05lRDBjVktXTUFvUWFQSk00L2N2Vi94eWlET09STUpl?=
 =?utf-8?B?L1NjWjBDaytTUUNveEFUNFNvYTY1a25WR0ZVZUNvSW5JcERNaVh1eDlTVXJj?=
 =?utf-8?B?Rk9ZRENRRlVMNnRObEVBV24yQjgrWHFjdE8yUE9ic0V6VVNvUHJTNlE4UFJR?=
 =?utf-8?B?ekxZc0hDZHd1c25FaHJnMVQ2TmRRbHhrY1YyOWtacG00aHNUNDZ5VXZxMSs0?=
 =?utf-8?B?c0F1bHBvdnZqQ0t4WEk1cWhySlI4YnY0VzlWVjVZQWJrS2pMTTQzT1VseUhR?=
 =?utf-8?B?cE5KRUVWaHVZbTJSa1VvREQyVlJ3S0dZbmF6NVp1dGFYeWUrNDFVa0k1Qy9O?=
 =?utf-8?B?Wkl5QnAzdTBXd3ZMZWJRNmtWbFljSEtLU3kyYVJRSnY0aDhWTVgvN1l1SHBX?=
 =?utf-8?B?d290K3BuRUcxcEtaZWJRNkl4WUlYNDA5NTlZK1RPMmZBUVIzUkFYc0FURTBO?=
 =?utf-8?B?ZlFpMWRlSStmenN3QjFvenhWajV1RXpuSHRIVTlsYkg0REhVM3BnRDY4OENz?=
 =?utf-8?B?TFBtTVNvNEpwdzVmZTJRYnBWUytkczhacklKNVNKQTBveDZDcVRpRVhEY0wv?=
 =?utf-8?B?TnErbGRnRnFLY2tvdnNCSlBRa24ySk5weVY1NEE3L0NEc1pxbkpBUitqN0VG?=
 =?utf-8?B?QzA4a1hybnZJbWlrYWUzc3B1NEZIVUttRXBsQWxQSkxMcU1Jcmk3V0kvRTNv?=
 =?utf-8?B?bzQ3VzJIU0htSit3NGp3TnhRc2JNS0hGY1VYOGduVEc0REp2MGRleitIRWps?=
 =?utf-8?B?RGxrSVV0RHcvU3kvT1BuaXVZTU1Yd0hYVFF5ZDBiZHFSc1kxT0JYdTdsbFE4?=
 =?utf-8?B?NzhHSFRYZnllZGFxTThqTk9ZbGxxakxaQWpIMEV2eUUxNGg0cVA5UU9Mbnk2?=
 =?utf-8?B?VVorNnVUU2o1V0Vrc0ZVWFAvcW5odU91eUh3NVhqb21aRklMakIxNS9Ccm54?=
 =?utf-8?B?dUY2QmxVaStlQTBtbzR0bG9DbGdMYUFXR0NSOFZyZm9hQStKZWpnM0g5VDFQ?=
 =?utf-8?B?eFQ5K2FabDZmVitJK0w0bG93Z2JHWFNyY2tDU3lhbTJqUEtRYVlnbFUvZFVL?=
 =?utf-8?B?QUZmSm51QW1FOWxmbVRmWStzVWNSOUJsb1kvNVF1ZTlaUVlXdmxxTW9BU08v?=
 =?utf-8?B?Uk1TRjhPM2o4cDg3RXd6a3dGNDdJKzB4eW81Z1FLelp1TDYrUytpcEJQVFov?=
 =?utf-8?B?TWlOUkpnK29wck0yR2U0UFNHM2s2eEptbjFTWHY0ZThPYUxYK05pakl4ZzZE?=
 =?utf-8?B?NHpTbjZQcFJialZvZ3Z0b1ozWEgzRzBPd2JmdWU3ZHNUTTNBb3hOK2QzN05a?=
 =?utf-8?B?WDZ1OVpIeW1IKzBrWnp5cHRnc0d1YWhPNkZKcHd1M1VBRHBrSGxEaDdqR0hT?=
 =?utf-8?B?amI1QkNEWXVXTFNpV2xWOHVuQnN1MFI3SG5EVDBvR1p2WmJlZm9NWFJOQlBF?=
 =?utf-8?B?c1RSTUc2bXRXWkg2OTNWd1BNQ1ZqV09uSjJrM2xTRGdUNlpsZkN2K3YveC9Y?=
 =?utf-8?B?MnhYRW1ZQWZCOEZwU3VHMjAyOHJTQWx0YzB6N3VEZ2p1K1pVdm9yR05wR1RH?=
 =?utf-8?B?YXcrbVQ3Nm5oZzJ2MVFQdEhTbjY0dWZDVkJLL0pEamhDdWZnVmlCNW9JRmw3?=
 =?utf-8?B?MkFCTlBkYldWV2RkSnRGeWw0V0JOdEdnTktpMTBTeXhPVEE4VTJSOFZNWjVt?=
 =?utf-8?B?Q3VvbGxQT3QrVHIwaUJBYVVUb2wzWWRVVUR6L2xiWWx2dkQrNmZIQy9IOFhn?=
 =?utf-8?B?M0NuYWNmSktjai9RRXpuMnRWRnBCcmdzbXo4Zz09?=
X-Forefront-Antispam-Report:
	CIP:20.160.56.81;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(14060799003)(376014)(82310400026)(7416014)(36860700013)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 18:50:58.6452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6ea6b0-e36d-48eb-6860-08dd924f19ad
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.81];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6580

On 5/11/25 16:12, Christian Marangi wrote:
> Add phylink support for GDM2/3/4 port that require configuration of the
> PCS to make the external PHY or attached SFP cage work.
> 
> These needs to be defined in the GDM port node using the pcs-handle
> property.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c  | 155 +++++++++++++++++++++-
>  drivers/net/ethernet/airoha/airoha_eth.h  |   3 +
>  drivers/net/ethernet/airoha/airoha_regs.h |  12 ++
>  3 files changed, 169 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 16c7896f931f..3be1ae077a76 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -7,6 +7,7 @@
>  #include <linux/of_net.h>
>  #include <linux/platform_device.h>
>  #include <linux/tcp.h>
> +#include <linux/pcs/pcs.h>
>  #include <linux/u64_stats_sync.h>
>  #include <net/dst_metadata.h>
>  #include <net/page_pool/helpers.h>
> @@ -79,6 +80,11 @@ static bool airhoa_is_lan_gdm_port(struct airoha_gdm_port *port)
>  	return port->id == 1;
>  }
>  
> +static bool airhoa_is_phy_external(struct airoha_gdm_port *port)
> +{
> +	return port->id != 1;
> +}
> +
>  static void airoha_set_macaddr(struct airoha_gdm_port *port, const u8 *addr)
>  {
>  	struct airoha_eth *eth = port->qdma->eth;
> @@ -1613,6 +1619,17 @@ static int airoha_dev_open(struct net_device *dev)
>  	struct airoha_gdm_port *port = netdev_priv(dev);
>  	struct airoha_qdma *qdma = port->qdma;
>  
> +	if (airhoa_is_phy_external(port)) {
> +		err = phylink_of_phy_connect(port->phylink, dev->dev.of_node, 0);
> +		if (err) {
> +			netdev_err(dev, "%s: could not attach PHY: %d\n", __func__,
> +				   err);
> +			return err;
> +		}
> +
> +		phylink_start(port->phylink);
> +	}
> +
>  	netif_tx_start_all_queues(dev);
>  	err = airoha_set_vip_for_gdm_port(port, true);
>  	if (err)
> @@ -1665,6 +1682,11 @@ static int airoha_dev_stop(struct net_device *dev)
>  		}
>  	}
>  
> +	if (airhoa_is_phy_external(port)) {
> +		phylink_stop(port->phylink);
> +		phylink_disconnect_phy(port->phylink);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -2795,6 +2817,115 @@ bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
>  	return false;
>  }
>  
> +static void airoha_mac_link_up(struct phylink_config *config, struct phy_device *phy,
> +			       unsigned int mode, phy_interface_t interface,
> +			       int speed, int duplex, bool tx_pause, bool rx_pause)
> +{
> +	struct airoha_gdm_port *port = container_of(config, struct airoha_gdm_port,
> +						    phylink_config);
> +	struct airoha_qdma *qdma = port->qdma;
> +	struct airoha_eth *eth = qdma->eth;
> +	u32 frag_size_tx, frag_size_rx;
> +
> +	if (port->id != 4)
> +		return;
> +
> +	switch (speed) {
> +	case SPEED_10000:
> +	case SPEED_5000:
> +		frag_size_tx = 8;
> +		frag_size_rx = 8;
> +		break;
> +	case SPEED_2500:
> +		frag_size_tx = 2;
> +		frag_size_rx = 1;
> +		break;
> +	default:
> +		frag_size_tx = 1;
> +		frag_size_rx = 0;
> +	}
> +
> +	/* Configure TX/RX frag based on speed */
> +	airoha_fe_rmw(eth, REG_GDMA4_TMBI_FRAG,
> +		      GDMA4_SGMII0_TX_FRAG_SIZE_MASK,
> +		      FIELD_PREP(GDMA4_SGMII0_TX_FRAG_SIZE_MASK,
> +				 frag_size_tx));
> +
> +	airoha_fe_rmw(eth, REG_GDMA4_RMBI_FRAG,
> +		      GDMA4_SGMII0_RX_FRAG_SIZE_MASK,
> +		      FIELD_PREP(GDMA4_SGMII0_RX_FRAG_SIZE_MASK,
> +				 frag_size_rx));
> +}
> +
> +static const struct phylink_mac_ops airoha_phylink_ops = {
> +	.mac_link_up = airoha_mac_link_up,
> +};
> +
> +static int airoha_setup_phylink(struct net_device *dev)
> +{
> +	struct airoha_gdm_port *port = netdev_priv(dev);
> +	struct device_node *np = dev->dev.of_node;
> +	struct phylink_pcs **available_pcs;
> +	phy_interface_t phy_mode;
> +	struct phylink *phylink;
> +	unsigned int num_pcs;
> +	int err;
> +
> +	err = of_get_phy_mode(np, &phy_mode);
> +	if (err) {
> +		dev_err(&dev->dev, "incorrect phy-mode\n");
> +		return err;
> +	}
> +
> +	port->phylink_config.dev = &dev->dev;
> +	port->phylink_config.type = PHYLINK_NETDEV;
> +	port->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +						MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD |
> +						MAC_5000FD | MAC_10000FD;
> +
> +	err = fwnode_phylink_pcs_parse(dev_fwnode(&dev->dev), NULL, &num_pcs);
> +	if (err)
> +		return err;
> +
> +	available_pcs = kcalloc(num_pcs, sizeof(*available_pcs), GFP_KERNEL);
> +	if (!available_pcs)
> +		return -ENOMEM;
> +
> +	err = fwnode_phylink_pcs_parse(dev_fwnode(&dev->dev), available_pcs,
> +				       &num_pcs);
> +	if (err)
> +		goto out;

OK, so say you have PCSs A, B, and C. phylink determines that you are
going to use B. But where do you select the PCS? Don't you have to
configure a mux or something?

--Sean

> +	port->phylink_config.available_pcs = available_pcs;
> +	port->phylink_config.num_available_pcs = num_pcs;
> +
> +	__set_bit(PHY_INTERFACE_MODE_SGMII,
> +		  port->phylink_config.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +		  port->phylink_config.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +		  port->phylink_config.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_USXGMII,
> +		  port->phylink_config.supported_interfaces);
> +
> +	phy_interface_copy(port->phylink_config.pcs_interfaces,
> +			   port->phylink_config.supported_interfaces);
> +
> +	phylink = phylink_create(&port->phylink_config,
> +				 of_fwnode_handle(np),
> +				 phy_mode, &airoha_phylink_ops);
> +	if (IS_ERR(phylink)) {
> +		err = PTR_ERR(phylink);
> +		goto out;
> +	}
> +
> +	port->phylink = phylink;
> +out:
> +	kfree(available_pcs);
> +
> +	return err;
> +}
> +
>  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
>  				 struct device_node *np, int index)
>  {
> @@ -2873,7 +3004,23 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
>  	if (err)
>  		return err;
>  
> -	return register_netdev(dev);
> +	if (airhoa_is_phy_external(port)) {
> +		err = airoha_setup_phylink(dev);
> +		if (err)
> +			return err;
> +	}
> +
> +	err = register_netdev(dev);
> +	if (err)
> +		goto free_phylink;
> +
> +	return 0;
> +
> +free_phylink:
> +	if (airhoa_is_phy_external(port))
> +		phylink_destroy(port->phylink);
> +
> +	return err;
>  }
>  
>  static int airoha_probe(struct platform_device *pdev)
> @@ -2967,6 +3114,9 @@ static int airoha_probe(struct platform_device *pdev)
>  		struct airoha_gdm_port *port = eth->ports[i];
>  
>  		if (port && port->dev->reg_state == NETREG_REGISTERED) {
> +			if (airhoa_is_phy_external(port))
> +				phylink_destroy(port->phylink);
> +
>  			unregister_netdev(port->dev);
>  			airoha_metadata_dst_free(port);
>  		}
> @@ -2994,6 +3144,9 @@ static void airoha_remove(struct platform_device *pdev)
>  			continue;
>  
>  		airoha_dev_stop(port->dev);
> +		if (airhoa_is_phy_external(port))
> +			phylink_destroy(port->phylink);
> +
>  		unregister_netdev(port->dev);
>  		airoha_metadata_dst_free(port);
>  	}
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
> index 53f39083a8b0..73a500474076 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -498,6 +498,9 @@ struct airoha_gdm_port {
>  	struct net_device *dev;
>  	int id;
>  
> +	struct phylink *phylink;
> +	struct phylink_config phylink_config;
> +
>  	struct airoha_hw_stats stats;
>  
>  	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
> diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
> index d931530fc96f..54f7079b28b0 100644
> --- a/drivers/net/ethernet/airoha/airoha_regs.h
> +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> @@ -357,6 +357,18 @@
>  #define IP_FRAGMENT_PORT_MASK		GENMASK(8, 5)
>  #define IP_FRAGMENT_NBQ_MASK		GENMASK(4, 0)
>  
> +#define REG_GDMA4_TMBI_FRAG		0x2028
> +#define GDMA4_SGMII1_TX_WEIGHT_MASK	GENMASK(31, 26)
> +#define GDMA4_SGMII1_TX_FRAG_SIZE_MASK	GENMASK(25, 16)
> +#define GDMA4_SGMII0_TX_WEIGHT_MASK	GENMASK(15, 10)
> +#define GDMA4_SGMII0_TX_FRAG_SIZE_MASK	GENMASK(9, 0)
> +
> +#define REG_GDMA4_RMBI_FRAG		0x202c
> +#define GDMA4_SGMII1_RX_WEIGHT_MASK	GENMASK(31, 26)
> +#define GDMA4_SGMII1_RX_FRAG_SIZE_MASK	GENMASK(25, 16)
> +#define GDMA4_SGMII0_RX_WEIGHT_MASK	GENMASK(15, 10)
> +#define GDMA4_SGMII0_RX_FRAG_SIZE_MASK	GENMASK(9, 0)
> +
>  #define REG_MC_VLAN_EN			0x2100
>  #define MC_VLAN_EN_MASK			BIT(0)
>  

