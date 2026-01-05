Return-Path: <netdev+bounces-247195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89695CF5963
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 22:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C41D7300A9B1
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 21:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD3B26E71F;
	Mon,  5 Jan 2026 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mC67AIUI"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013030.outbound.protection.outlook.com [40.107.162.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C4810FD;
	Mon,  5 Jan 2026 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767646833; cv=fail; b=WwLnG9J2KfbJb2s16jus8iEISapsFavqhfqTkq2AfbPKP1GGJMM9tiGRViycpkcCzJG8xj8bpHxNbmJRW94VLHa0ajN6kWw8jBZhyIfQh3G4c4Yx6B+gOoom2rQ6KlZWWRG9wgxRfS2px5Sg8iSSmRfQwxaIcugfbvLZ43a+I14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767646833; c=relaxed/simple;
	bh=DYUuB62OFetcSPr26qDCtIF18Oy7/QTkUb/B4MAVeII=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rw2uQ9lyBOsISVdp5Ilmw8dh+BHKJ5nEdTE2zAWMcnwbh2KYZAsjK3zbiXK3iJRjXxYsl8N5pVp1TjzIJV/mbI+0ykegBNXX4h522ry7RYakNkYvV7geyH4dBwUM5ckGKqbkVGDOD76MmEIDVqpzQiRHZwntqk6wA3MyGHELpw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mC67AIUI; arc=fail smtp.client-ip=40.107.162.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iibjQ7tSq2/vd74qytYuQA+42TlDeKnVMKM/FKRssevvgZJoFKaYxoE91ntof9cGKQox4JkRxdVx/yD7tpCQeeuayD7Jx8jV9ulLuZE4/mRNR58uMPGxg9NKydZtLIhNQR7s4H6Ya5XStbSERykyuaaF0g5LczzsHsFSXrxHSN1N0SQpjVD63H/aOCiWVNTGkA7ZjDI+va9J3Ix7qMbcW8os5WRenCsJkbhrL+NXwWqdc8ri1OGbv5nkkjPKcYjdcignsJt4y5vnXe2U30yarTXimw2R5/d8J4n7tOm6mfgOxsOBxHTKrpjZcmG4pAZtN/gIq7NflvweAwUA1PH6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYUuB62OFetcSPr26qDCtIF18Oy7/QTkUb/B4MAVeII=;
 b=wXpsbYuVbsMcFcnUDEWrRmaPObqb8LvvuLMzfokDF7FrzfcquRzqcC31htJ2PN4UYw47D4y5VNMGBYHLrr4bbPyfNTy+Xx0OYeEUqfydJRgIQu3KKsLEIVLR82KDhONoP1RssUBDN5FXsPZqMs12Cs66N2yVeO7pdndS+W1Or7/2WctdCttpeTpDNylY9AYlZ/PxQYrrMFQpmIYPIRDW2G1H+yHHI7ieT+UNzx02LKvdfbus5NrTpnDNffVN04rxLi8wivjNK/cZllE1XotRsNs9GYgC09GpMmrx2V+olRyuYJ7FSV+6GrNOdT5jKTUXsEcbKNW1goftAedCcACXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYUuB62OFetcSPr26qDCtIF18Oy7/QTkUb/B4MAVeII=;
 b=mC67AIUIAFKABPy4qe7n753yHryzoMJg83ar0/8ENHLPVUGs8ESLAp3acfHqWyEmn/58HGS3G7EIFHeeA5eC5e5ojioes43f//TRujPBKM2WqPnCThA08Wxvq2REgo/odhkEW2u8uemQ1tJe+igapYOaoF2ZXLrmUEbvEGY1IDHKEurbw+MptcF41P+0g9Y5CwwuqnjBKXMvwPDSGhcX+64ZJw1/jVsmJi80QJKokzyoIimwNq6JMvZyGK/zRpwxCHC6vEJWOtZlXw19p7ai7kr/s5VkTtqmqTwm/hMaKtpyLParwuC8Q3ND29/gykTHdkIgbcVqG72Qxp2Q6bKRBw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB9PR10MB8285.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 21:00:29 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 21:00:27 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "olteanv@gmail.com" <olteanv@gmail.com>
CC: "hauke@hauke-m.de" <hauke@hauke-m.de>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>
Subject: Re: [PATCH v3 2/2] net: dsa: mxl-gsw1xx: Support R(G)MII slew rate
 configuration
Thread-Topic: [PATCH v3 2/2] net: dsa: mxl-gsw1xx: Support R(G)MII slew rate
 configuration
Thread-Index: AQHcfmxQUwNwEKdFfEaLvWt7wIFuxrVD9pcAgAAZMQA=
Date: Mon, 5 Jan 2026 21:00:27 +0000
Message-ID: <ac648a7e6883e68026f67ae0544b544614006d8f.camel@siemens.com>
References: <20260105175320.2141753-1-alexander.sverdlin@siemens.com>
	 <20260105175320.2141753-3-alexander.sverdlin@siemens.com>
	 <20260105193016.jlnsvgavlilhync7@skbuf>
In-Reply-To: <20260105193016.jlnsvgavlilhync7@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB9PR10MB8285:EE_
x-ms-office365-filtering-correlation-id: b46558d2-faec-4e84-7286-08de4c9d743c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?V1doMDEvWDkzM0R5MVFPWmp4SS9GU21oZDRHVXVsN2luQnpCN1p0d2hqZGNC?=
 =?utf-8?B?QjArWlZpYTNrci9iYnZub0hQQU1MTy9qd05hVUVwbkliQ2I5bEFwVHpwZlkz?=
 =?utf-8?B?MFI2eVVvMFl1MkVPcUNSUHF4ek94d1UzZnF4NEQ5TlR0ZUZRUnI5UGZpa2pB?=
 =?utf-8?B?RHlsYnRoakpIbklIQmYzTzd4Ui8xYlc5ZXpQWG9WTXNjeEpmOFZMZTlzNWNu?=
 =?utf-8?B?eWZ5aVlqcyt2TXU3MzFzUkhEMjBwN2czdTVaZWZpbnlzN3JCQW5PKy82REky?=
 =?utf-8?B?Wlk4TFhjdzZoYUx2M1ZES1pzMnNPV0VralIzYzRLMzFIMnV3YjdzTUF0WC94?=
 =?utf-8?B?VHk4SUhUSmQyZGtxM3EvUFN6MjZRdVVYZUhrTzFPZzQ0clRXSjZqb0JUOW5G?=
 =?utf-8?B?b2JWeFJEQWJUSEk1WWloNlNPaFpLV3BjdVdFMlZUZVZSeklDdUJZWDcxWkFj?=
 =?utf-8?B?S01lTERFV3EwbllLZE1wRzlWNDNIV1RucW9qVThPNzZQbStLL0FCTE52MFps?=
 =?utf-8?B?d3p1UHRocnpaLzZTWU81ZGdUNGpvUi84T2RiNk5uVk1NbVZXdngyci8xMEJN?=
 =?utf-8?B?ME9NWU1SOG40RU03WlhxZURpdkswNVp4bkxxY0JFMnQ3b3N6S3N4Qjl6cnBu?=
 =?utf-8?B?Rm1ENTBNUVAycU1iM0ZJTHFoWVJUMjB5Kytyb2RRUEN0RTZ2TXE5dlZ5MEp3?=
 =?utf-8?B?SExtL1JVRzJtUGdNbHRPSGFyUkNzYlFSR3pMT3llelNSdng2Qmh2ZG9PRUxz?=
 =?utf-8?B?QUo2bHg1QWFTeWlJTW05dVpJOTRJRk8zdzJCdFlHRy9iQ0hrdHBCZzNhWUJD?=
 =?utf-8?B?NWdXZ1NiUjIxZy9vSUVGSkE1eU1PdTdrWlovYjgxZ213ZDR1RTVPMEJJcVU4?=
 =?utf-8?B?bDA3MXFLZWFNck5NMzk4d3NFQ1N2NTNnV0liOGRLUEhneTh6cXk3NGZnYWJE?=
 =?utf-8?B?YUxHbWEybUNTbTlqWjhyS3ozaTJhL29LQVlXcWFmRzk0cE5pRjZLcmVzZy9Y?=
 =?utf-8?B?QlNWNVJHZ0VpMWRPMVNYNHBnQVg1WHYrcktmVXZpcTQvTG5QN2lHWSs2RkFj?=
 =?utf-8?B?QklOTVl2ZHYwN0FVS1QrTEZkSFM1d1dMTGRnYllrcHhHOEZYOWdJeTBhdnlm?=
 =?utf-8?B?ZHlGYkpVM0grek1BYnAxdEk3cGdrWit2ZURsc3FCRGlOdDdzbnN5Qm4wZm9F?=
 =?utf-8?B?bFUrbUltZDgyOGJRUG1xYnNJRkpmVDZZZ3RwTDhqeGZpZ09TZU9vRGd3TVVr?=
 =?utf-8?B?ODFiNmkyU3M5MjNucG8zV1Mza2p3U291Vk9ESTN0WExRYi9CcmtCQjk4ZGVo?=
 =?utf-8?B?UC9xZU1icFp2TkhQbzMzYlFoNHdoSVlhdWlBS1RGVndTTnMzcktwRmJhNlJn?=
 =?utf-8?B?Z0dKdW1XdG0xS2pvM2lxcFpLcjJvUXMvZEVSQ3dVOEo2cTBHNTE2OHI2SGhI?=
 =?utf-8?B?NFE4dmNkZitWMW9yUWlqUUVDRDVxaTdaMkNTbS9NbTc1c004dmJTYzVnVGJp?=
 =?utf-8?B?dHdTVFdOQzJZNWRxQVcycmg1SHBwRWNZVUl5OUNDejhGdG5QUy9DYTVTZ0hj?=
 =?utf-8?B?aG80bHZ4QTl0czc4dkZJTG8xbHpTckJUK3oyV2NlSlM2ZDBZRkpPRUVwMDBw?=
 =?utf-8?B?cHlzZkwrRldVa0hvN1FLZExySHpSRjRWa2thY2RoZ3FjY3BiaS9pTTIrbGpw?=
 =?utf-8?B?aTVOY1MwYlhERXlod1FXSVphWGtOUVdmeENTQUNHVGI3YUtrS0JQRytva0l5?=
 =?utf-8?B?ak8rdFRsaU5aT0xXY1ZYRFpRZGV1NVdtcjE2UXQwUCtEckNBN0UwcksyTzJl?=
 =?utf-8?B?YkVqRVRKV3hONVNFN01BSGd6VlFyMDlqY1pkcTlkeitzRzNlaDdFZHU4YU11?=
 =?utf-8?B?N2l4cEhGQ1c0L1FGd3RvUEtEVEpKTElxNEwwZ2FDZDhpMnpZL0FmZHd6Z0w5?=
 =?utf-8?B?Uk01U1laOVhQWEZQMndQalhxZ3BFMlB3Y2NzT0ZpYzdCb09wWGR4SXlVcmdZ?=
 =?utf-8?B?MHBzSHQweEhnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qk1uN2xyYmxsKzRZMUF5bDdFakVob2FLZWtSNDc4VnVCaERwUmtoc1lRanE3?=
 =?utf-8?B?U0NaZmJKM1ZwMmx3NWhIVFFOT0doUTdIcnI1Vytqalp0SWpFV1NwQkJWaXRX?=
 =?utf-8?B?Z0IxOEZPK0d2QmxDWWxBZHBFdnlUS2ZTTHdqbEY3cThUeFNMR2kxSE9yckZT?=
 =?utf-8?B?dVNXVDZrN05XVnBnYkJuVk44TlZacktkUGZJTCs0ZkJ1SkVPaFZKVmFSTTJG?=
 =?utf-8?B?Q3hOeVlOSk9yeC9tQ29pbzJ5dHpxa3FzL1pWclRnbU1UZTcvbHpVaVlnMnVL?=
 =?utf-8?B?VlA4akFoUFpQaENzR3VQWVJlVkxmQloyYUtTakhRWWVEdHRpWUQzVTJBelA3?=
 =?utf-8?B?Mk51S3RueUtqckN1SUtrQ1pRMHNrTUFQSlNZWVlaZVRMVUlCai8xOXk3TGZ5?=
 =?utf-8?B?TmV2VlpiaEZ6N0Vxd3hnbnJrOURXcTREaGJWdkJaVFRMcDZxTDIvdURIUHRZ?=
 =?utf-8?B?MytFeGxXZkZWODdCdEgyQnNkNFVWMUpKR3A3VUVoNVlveGlRVHJIRVN4ZWVo?=
 =?utf-8?B?OUNKM1kxY0pJc1RZek1weU50ZHNSTW5hVHVQaDVUSWNhWkY3SnRlZGtuaEdE?=
 =?utf-8?B?dUVHQjVlM1l1eUFvTFBHYnl4SkcwUzhOUHJhVFBGNXJsUEtnalBpcjJBZThG?=
 =?utf-8?B?RkRweUU4eVJYM3BYOW5YWTJtVU4zeEpweW1LdmV2MVJyTEdKRUIrT25sT2d4?=
 =?utf-8?B?a1FPbDNLRjUwWHlCaWpVQnFveXYra21uQWNNM2lPSWZjWVJrRUNkOWtpWlRG?=
 =?utf-8?B?aG85bFkvemE5SDBXV1VGNnlyZkpqUmRQL2gwVEh5alU5Qkprd3hyV3paNHhP?=
 =?utf-8?B?ZFVnZFFLeDM0WGRPU3l6NTJ4dS8rM25NVUJxNXJTVUpueDgvVDlrYkVVNjlt?=
 =?utf-8?B?ZHBlTGxkR3JSaEF3V09ibFFpY2VsUU5ON0NLeHF4WjYvYkZZc1haOXhQTFFI?=
 =?utf-8?B?R2g0VGhsWlRad0x5ZjJ3MUFBbHFEck1JNlF0S1NVOEFlTVlNbWFTQzdlT2to?=
 =?utf-8?B?OFNIQUMzajlGSWZjKzk2ZWl5cDFVYkNXd1B6Z1hpR0wvdXhUZmNFaWhoZmFJ?=
 =?utf-8?B?UkFzVWFPNTFUbTEyOVZ5alRUdDhHNWVROUJLY0NGc2t0cytsQ0FRRTMwZW5R?=
 =?utf-8?B?YVFNL1duN1d1akdJSnVLU3BEWmpTUVMvWVFOOTFENG1pQlBaeXErK2tTd3RV?=
 =?utf-8?B?d1c4NGd2WEJwK2J2QXVqK0tNL0R0UVB4QUxaWFJKNDc5WnZWWGJJalpUY3Fa?=
 =?utf-8?B?SGZ5Q29weWNwVEdGY0xJVzYxbGQ3L3NmVTdOaVNYM2UwT2hhTWlEa3Q5WDBp?=
 =?utf-8?B?MVFlZVNKMnN2SkRCeTVFVVRnMzdwMGgrbXdwUlZXRUhHVlBXREZaSzNxNW5V?=
 =?utf-8?B?QWVKZ1ZDZDNBWlI3Q2UzRWtwcFJLcko5UGIxUmxKMDg4R2hiQ0FLT3dGR3F2?=
 =?utf-8?B?V1RnbkU1RUZPbTR2SVJSRWVDUlhSY0Fyay9IR3gzMmdiUVFZMFNzNnVlNHBa?=
 =?utf-8?B?WFd5Z0tQbERTdHYvZFF5OFRmTXBqU2U5MmtOTkVFV1l3L2RQZ0dlMWRuK2ti?=
 =?utf-8?B?RFVFdFhyZm5vUVZaTk8ybjBQV3FrM1RkMittVjZXNloyUmJBY09iTXUzWlVn?=
 =?utf-8?B?TVRVa1NQOGcrYWxWWUI3VVl2aXh3dmNZRjcwOGdPY0xVVVNSRXZubTk2UDJm?=
 =?utf-8?B?Zm9iV1Q0TWtqS0ZVNGhYTWlMaUNPNnAyTnB6VERJSXFhbWVmTk5pQ3FVT0Zl?=
 =?utf-8?B?UHRXNk83SDhUdkRBYVA0Vy9GT0srT2FSUGd4dkN3Y0FGVnRISXpNL0JqNUhO?=
 =?utf-8?B?dGFJdGVKQkJ6L014dU15K0dqK0FhQmFQcWEwYkV5SDJHQ1RkaGhYMFoyQWF3?=
 =?utf-8?B?QklOUHhvTEZSNU5ldWI5VUc1R0JBS1pxbFNVQktSekN3UGpwa1VMRGJhZUI1?=
 =?utf-8?B?Mk5waERXTTV6MjUzVmpQMmdDTHh2dTJnNFdLMTVaQTF3Qm1mRnAxeERwS01P?=
 =?utf-8?B?TU04cFA5U2ozcm8raC93OHVrVDVNY05vM0FWYWJTejdhZWpMVXl4UXJQZmNL?=
 =?utf-8?B?M3F0TVZjYnpLWFNjY3BmdUN1MVhNUTRpVXY2OWtzU0RscmxxR2cvVVFRcURV?=
 =?utf-8?B?dmRpTVZZZTd0VHZBaGNGZmRwam5zQ1Rqb3RSSUx1SUxMaGMrZmVoeVAwNmpC?=
 =?utf-8?B?bnJmQkRBeWFSMm9RZ2F5WnVBT2d0RDRrOFpmL2JiQ3RqNUp3VmxqaUhLaUZZ?=
 =?utf-8?B?dUtmeTJVdE5VYzNEMC9MUjIzQml4cm8wNU9GVmRvTEdiMEFwc0ZrVkxzTUFw?=
 =?utf-8?B?MDhTb2N2Yk9hL01BV2JVSnY4TVd6RXBXYkF1azQvV2JuNlM4T0NOY2hZdXhT?=
 =?utf-8?Q?ke9jQx9NxFDusMwwIDO3MsN6KsjiEeJgHAx6F?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F3079DE69120B4A9B09F273F7A5740D@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b46558d2-faec-4e84-7286-08de4c9d743c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 21:00:27.6586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7yAY9f4w+NmgVJSjU8xuW1K6D/AHQ8GdDH/gvDJkBbxVjzTZV8qgoLl9PUhBnH9tSu2TC50v0TbXLB4RPZhFjIN/EyCGxwTjri+5D3KtFN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8285

SGkgVmxhZGltaXIsDQoNCk9uIE1vbiwgMjAyNi0wMS0wNSBhdCAyMTozMCArMDIwMCwgVmxhZGlt
aXIgT2x0ZWFuIHdyb3RlOg0KPiA+ICsJcmV0dXJuIHJlZ21hcF91cGRhdGVfYml0cyhnc3cxeHhf
cHJpdi0+c2hlbGwsIEdTVzFYWF9TSEVMTF9SR01JSV9TTEVXX0NGRywNCj4gPiArCQkJCcKgIFJH
TUlJX1NMRVdfQ0ZHX0RSVl9UWEQgfCBSR01JSV9TTEVXX0NGR19EUlZfVFhDLA0KPiA+ICsJCQkJ
wqAgKFJHTUlJX1NMRVdfQ0ZHX0RSVl9UWEQgfCBSR01JSV9TTEVXX0NGR19EUlZfVFhDKSAqIHJh
dGUpOw0KPiANCj4gSSBkb24ndCBoYXZlIGEgcGFydGljdWxhcmx5IHN0cm9uZyBFRSBiYWNrZ3Jv
dW5kLCBidXQgbXkgdW5kZXJzdGFuZGluZw0KPiBpcyB0aGlzOg0KPiANCj4gUkdNSUkgTUFDcyBw
cm92aWRlIGluZGl2aWR1YWwgc2xldyByYXRlIGNvbmZpZ3VyYXRpb24gZm9yIFRYRFszOjBdIGFu
ZA0KPiBmb3IgVFhfQ0xLIGJlY2F1c2Ugbm9ybWFsbHksIHlvdSdkIHdhbnQgdG8gZm9jdXMgb24g
dGhlIFRYX0NMSyBzbGV3IHJhdGUNCj4gKGluIHRoZSBzZW5zZSBvZiByZWR1Y2luZyBFTUkpIG1v
cmUgdGhhbiBvbiB0aGUgVFhEWzM6MF0gc2xldyByYXRlLg0KPiBUaGlzIGlzIGZvciAyIHJlYXNv
bnM6DQo+ICgxKSB0aGUgRU1JIG5vaXNlIHByb2R1Y2VkIGJ5IFRYX0NMSyBpcyBpbiBhIG11Y2gg
bmFycm93ZXIgc3BlY3RydW0NCj4gwqDCoMKgIChydW5zIGF0IGZpeGVkIDEyNS8yNS8yLjUgTUh6
KSB0aGFuIFRYRFszOjBdIChwc2V1ZG8tcmFuZG9tIGRhdGEpLg0KPiAoMikgcmVkdWNpbmcgdGhl
IHNsZXcgcmF0ZSBmb3IgVFhEWzM6MF0gcmlza3MgaW50cm9kdWNpbmcgaW50ZXItc3ltYm9sDQo+
IMKgwqDCoCBpbnRlcmZlcmVuY2UsIHJpc2sgd2hpY2ggZG9lcyBub3QgZXhpc3QgZm9yIFRYX0NM
Sw0KPiANCj4gWW91ciBkdC1iaW5kaW5nIGRvZXMgbm90IHBlcm1pdCBjb25maWd1cmluZyB0aGUg
c2xldyByYXRlcyBzZXBhcmF0ZWx5LA0KPiBldmVuIHRob3VnaCB0aGUgaGFyZHdhcmUgcGVybWl0
cyB0aGF0LiBXYXMgaXQgaW50ZW50aW9uYWw/DQoNCnRoYW5rcyBmb3IgdGhlIGhpbnQhIFRoaXMg
aXMgZGVmaW5pdGVseSBzb21ldGhpbmcgSSBuZWVkIHRvIGRpc2N1c3Mgd2l0aCBIVw0KY29sbGVh
Z3VlcyBhbmQgZ2V0IGJhY2sgdG8geW91IQ0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2ll
bWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=

