Return-Path: <netdev+bounces-94092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 932E58BE189
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE321C20C3F
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CB0156F23;
	Tue,  7 May 2024 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="HM39CiBx"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2110.outbound.protection.outlook.com [40.107.7.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699D114E2EC;
	Tue,  7 May 2024 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715083417; cv=fail; b=kV9lQzsssB+CDXYo0ZJS4Sc6yyrOwxj9uVsXLFfXjRqnYLfJMxD9bplbEEyY0EyYDwmO1vrnxUPNqtlbhh0DcPk3LsFZiLxKg4XQPvCuGe6fbkzBIMIYXN1QOrA9Keydl61rFOPy4h0ooe/JOm22SfTXdmnUyYQ/JdfkKXC0CEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715083417; c=relaxed/simple;
	bh=ji+1kg7U/D0we0wMhkTh7xTEN7As2jK5SiQ1eze7Gok=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fxRsPnW+8P7EXMTUnPGZvrXCDB1txg4I7Hh0Xh9on9K1nygRkapjEYo2jtQFfGsRdx98iVOLTdlW1Pf7O7797KxgODkiKaMIHxQGfrj4AujPTYJ248xAu9B8lq3gcaBIsfl+EoMJRcUso6JlRqjR52vPMh9lwHBIXMIhtzGg4gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=HM39CiBx; arc=fail smtp.client-ip=40.107.7.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mnc+SSpR26dfjL/xdOU7VjmTFo/SH7LXlTZZdJqwLlcggklPPqJ1EEhT8jRWPY+Pcomyxvzj86X+KXTibprU+tnXDDOp7CdLUQKdVf/J48S/jfm0vHgykm8B+HaHHt3wWPGMhVLzs0IEoL1VgOeBpHzXt3gM2+FLmTtJ+RvpHT4pzsQwVc/hDQfC+eKpkdayJQrgYCTaIXlJ52viNN5lp7HRrBpWKHmIU71hJY+kVf+Lp5meHVBzKz0A44EzAX9mxPqg5BafzsDGm1jmi5RzDhpPB7rnBqq8u8U35QXxtjDDMqqOxiTuE7KM1vV1JSv3285v37B4FaXoHT0izPzINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ji+1kg7U/D0we0wMhkTh7xTEN7As2jK5SiQ1eze7Gok=;
 b=bt38sRzKhb9F8ThLlU4W0sz01XUaD6DXxVyzzWPJq3+WogSMSGbtN4Gdk3QinsUPkXK4Jt/czzmRUxdBcPid/tW5igAYLdCYSWr9nAe4U1g1T6LM+gM3sZ3KKlyxIufBmV6pa8/iETKSOLUom7bYES5pvpoarS17FOS6mrPElwe8L10LTFQhm3fuoY+8DUswU9GbOmIoC5qObXhSVCywb4K5eYj93oK1lKj+q6S7+j1bFWzCeTxR6tGb7dGSNMpQy8x534BJYCE99QiRTZge2UHH+TQLzfdUBVlD4fs3HjjA5sGmtsBuCV94jqh8esWk6VEBu/37wCzE+p+Wpx40Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ji+1kg7U/D0we0wMhkTh7xTEN7As2jK5SiQ1eze7Gok=;
 b=HM39CiBxLOSdnKbCPY4J5uTVTXmQvHEgXlCOXuBAefv1ybblCUODd9NcNdVwXTl/nJKzizAC7TcBYKSp/abDHuoMoHnJt2uHI5O5mcIp5GEM/l+DdJW0T28UnOBip7pl/FPJD7do5BVETBVGCDxmL6xo+DSZS8gjwQgoBfN7as4=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM7PR04MB6774.eurprd04.prod.outlook.com (2603:10a6:20b:104::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 12:03:31 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 12:03:31 +0000
From: Josua Mayer <josua@solid-run.com>
To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mor Nagli
	<mor.nagli@solid-run.com>
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: control mdio bus-id
 truncation for long paths
Thread-Topic: [PATCH net-next v3] net: dsa: mv88e6xxx: control mdio bus-id
 truncation for long paths
Thread-Index: AQHantH8wZxLbGkA70ONa4AkREvmfLGJAo6AgAKs9YA=
Date: Tue, 7 May 2024 12:03:31 +0000
Message-ID: <c30a0242-9c68-4930-a752-80fb4ad499d9@solid-run.com>
References:
 <20240505-mv88e6xxx-truncate-busid-v3-1-e70d6ec2f3db@solid-run.com>
 <A40C71BD-A733-43D2-A563-FEB1322ECB5C@gmail.com>
In-Reply-To: <A40C71BD-A733-43D2-A563-FEB1322ECB5C@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AM7PR04MB6774:EE_
x-ms-office365-filtering-correlation-id: 4f212784-6e30-4f42-20b0-08dc6e8db6d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZFF1S05RbExWYnF1RDlIMVVOVHhBeTJsUUE2cVZQaUtld0Ztd3BUcGVadDF5?=
 =?utf-8?B?L3g1RmI0UXJOaUhkUWxpNmFRVHo4aVRISzd6Ty8rOFJVdlNQTTFNYzVhNzIw?=
 =?utf-8?B?WUNCVDc4NzV6aWwrdUt1OFVnSHFjaHlGMytWa2lYU2RuUzV3enNBYjgwMHZt?=
 =?utf-8?B?VW5KMlM1ZDVwbXNtb3ZYbEk5bE9KQ3lGakFtSzhiRDNFbVBDdC9aS2haeUJE?=
 =?utf-8?B?S2ZVT0pENTJsZkxkVnNHT3JDaGxETzFCMm95a2lHWEpubmlWV1BYekVLOUFx?=
 =?utf-8?B?MU5lT25rd0lXWUpZTjc5dXpoS0srbkNFVmNlWXBUYzJxWnFmZ1gwa1RyY250?=
 =?utf-8?B?a0NqMlRGUEd1b3RKMVA3QnVOTmd0bHlIK1lFcmhLdFBrRGJZa2U5dEE0VXdC?=
 =?utf-8?B?SWFUQytFNkhsbjFuekg0T2NXcE1OV2MxY1duTGgwaXhRckpSczIrL21aZDAr?=
 =?utf-8?B?M3Q2NnFYbkc0TEplWmdmYW1DT21sbHJVYmIrcWJEM3psTkJMcEg3ZXBZZEdE?=
 =?utf-8?B?MEdVa1pYTDVtNnc2d243ZlVZRjhoUEVSRmY4Q3R1a2tvZGlZUCsxL1FFL1Rs?=
 =?utf-8?B?UGlDTVM2UURTallEaHIvMDBMSG0wcWxNazNIRktCSWJ6ak15TzQxSUdNLzFN?=
 =?utf-8?B?eU96b0R0dTRJQlFHeTRNeHZYM2JKUjJCOVdWZ291Yklqa2JnQnk4cnNpT3RY?=
 =?utf-8?B?eUVRWDk3UE5oL3huVjVTSUhOZ2hqWkxJejM3MXdvYVliOHhCZDRpY20yaWNl?=
 =?utf-8?B?cDNhZ1U5UHNndUhsMUkvUlNZMmJWNCtlaFp2MmNUOXZYWWRoWWYxQ3R6QWxk?=
 =?utf-8?B?ZVdVejhHUEVCYk5sMW5RZ29rbVIyQ01KaUlzSHBNOTZKNEFSeEc1ZWRRVHVv?=
 =?utf-8?B?ZG84Mm9DQ0VyRW5KT2FwYkc4dkovQnhVYm5LekNsd0FXMTR1eTJCQ0J5dHN2?=
 =?utf-8?B?U3ZUZ1lJemo4Q3E3N08vQjBnTGVZL3p1Vyt2UUprWkNIemR3ZFBabVFUR2NV?=
 =?utf-8?B?ZWNqQ1B0QU9sRDYrU05POVg5ejlqT01PMHZMWHhRcDcwUHRhNlNsamJGcTY5?=
 =?utf-8?B?ZjFoTnArZXl4OU5PL0FtUm9Wc2h6RnJVY1ZDdGs1TXI0NEFaYTc4Y29xbnhX?=
 =?utf-8?B?allTcUtjRTBKaWdvbnk4bWdOa01PRURJMm1XUUZTYW9wWU0xMHRNempMNk1R?=
 =?utf-8?B?U2xRQnNXWkxiVFNmZjRYUTdlZnNFSFpFZkN2VTl0azVyQnQxNmhsNUhWNDdG?=
 =?utf-8?B?OEhVTUJqZmlLencwRlh2eHArOVo1QllSOGlEVTF0WEcza3AvR3FlSm5kVHRn?=
 =?utf-8?B?enlSK2JqMkNUaGxITkJiV2dxZUZMQ3E5NDdZTVFqN1R6SUl5N0ZMT0pxTno4?=
 =?utf-8?B?V0FadVRITk55bHpQd2xjWXh2UG4xSTJva2Z1VExOSFcwQnkrQmxycWYrNW8z?=
 =?utf-8?B?ODFFOHROekpiSVoxRmtCZ05wVXV6R0U2SDBvK2lUZDEwMmVjQ3VYWTVlemNi?=
 =?utf-8?B?bGJCbWdraGcwRjBpczF4WDVFSjFuREh5VEZ3OTc1RjcxSDdSQUNlNko4Rzly?=
 =?utf-8?B?aEhabmVJVjJUTnpHQXNSUGZuUXd5ZFRJY3pUVjM1OGVrVnM2YkxLMjNZbXUx?=
 =?utf-8?B?QTZaQUdsNWlIYlZINnFydXFiajZWMm9FTkNsazdvSExEdUQ1RWRoY3VGc0VP?=
 =?utf-8?B?UFQ2SUFyNDk0LzRRUGFvKzBsdVZCeEFMVStlVXFwU2hGWmFONkVTYWFBamR6?=
 =?utf-8?B?enZTY2xoSFZTdlZkc1BSa0Z0VlVFaGFsVjYrU016V1U5eGhpcExOTkxpMFFC?=
 =?utf-8?B?OGVMcG5TTU9HZjZ5MVNTZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3pjTFE0aUlFdVAycjlpZXVFYU5LdXhYVy93Qms5VlloNmFtWWNpbjArV2g5?=
 =?utf-8?B?R3FtdW1RWnVIR2RDUlY3MzFTZEJmNTZvd3ZRSHRkYWxQYno5c0RpU2xoYi9R?=
 =?utf-8?B?V1NQbE1WQnFxaUJDSllUYUs5Skd5TG1EWXVXeUJXZktBV2JmMmRZUXBNRlVJ?=
 =?utf-8?B?bUhuZ0EwVEJZWUVBQmNDQmpqb1hyNGdjZ2VJK1FKZ3lGbjVhUkx5ZW1mWmdz?=
 =?utf-8?B?SSsxU2VkTk52aXE5TTA3MFN4Z2ZNVlNsYXdVbllxNUwwcDVWNUd1d2hjWlhh?=
 =?utf-8?B?Q2JsVFdtQUFVL0VxYWZQZEorTW1iWHlIdG9kc0EvdkdWWGgxYnVoVU5aVVZ6?=
 =?utf-8?B?ZHhqZWdHNUdoZkp4TzBhUlFTdXh3OHgzY1htL2ViWU11RG5CWTI0U0Q2eG41?=
 =?utf-8?B?TUpPR0JLMWJHeGMrZVBjUWpTOFM1Z1lhemhCNTE1NW9CUEhMQ0JPdkptS3c2?=
 =?utf-8?B?bGJINGFEeEZhd2gyZHI1eHNtUXlWRlZuUTRoMi9sdUhQKzFSY1lZOVRvRWZW?=
 =?utf-8?B?VkV0bXNvQ1F3dC9DSThXdmNVSFU2UEQ1WTVhcjUzb1ZzczRyVkVSRDFNSjFB?=
 =?utf-8?B?cFoxUFBRcjBLNVB4ZFJZeHNGdFFvbmwxYUY4c0Z3RkRJZ3o4WlBVUkY4cW9p?=
 =?utf-8?B?UFFXRytGS3h3emJPcGl3aC9SWkVMcm9RT3FkWWJOYTZnQ0YrRXpIM3BZL3V1?=
 =?utf-8?B?YVU5anNCLzhCdzFNenRPTVpjckFsRmpoNXVkWEprdmhsc1lSeUY2cmI1clMr?=
 =?utf-8?B?MkM2VXBvRE9PV2RqcEIzZDNzb0J5UEsyMldWdGF5UjEvTGZaRkNyS3VVOTZI?=
 =?utf-8?B?NlRJSnFVQUpFekhNU2tJK1BXek1LaGVCbUFma1Q4aG5HUzlXMnJic1Nlbmpy?=
 =?utf-8?B?TDFZVmFXT3pLM1pYeXBCbWxIQW8xZko0Z0wrVjErSGgwaUs4R0hLWE40bSt5?=
 =?utf-8?B?VVBlUDQzbC9jSXUwd0Z6L0dyWk82WkZ3WFNjMXk3d2pMK2Q2ME5MbCtwcUtO?=
 =?utf-8?B?YWtoaXZZRVdIdGZpSlFrQXdSdExsZTRBYjBBcGJmcXlFVWZIRUgwZFV3b2dB?=
 =?utf-8?B?NmhLQTNzSjlId0pmeUxSb1cyMUdleUFMUUVIME9KWFRHaTZHd0orMllQdHox?=
 =?utf-8?B?T3V3NW16a3o3ZjBJeHU5ZDdESGFXNlF6UDZscUN6TDNlMVNOeEppeU1VMEVi?=
 =?utf-8?B?NzI5SHJYWWlndHNxRjBSQmozVTNQNGViQzNLd1QrYUg3b0lJNlRyaTF5YlBB?=
 =?utf-8?B?ck1sMWFHdjc0aXZIRThXWkQxREdwWnNFRDd1SGkvZmpUY1AxRVpKbFB2R0pL?=
 =?utf-8?B?TEVTV2VCeVRMRkRtemVTMVpHRjlCUlZld0l2NW9LVUZOaitFQkNkWWczcXdQ?=
 =?utf-8?B?WXhwL2dEaTU1V2ZXUGRyYlMvVW82Wmk2WXV4bHI4S2VJY3kwR1ZtNXhkVGVy?=
 =?utf-8?B?TmZLczN5REdCUGRTdjAva2RwbjZKTmpOK2NodmlBdzdlTjVMU1NVaFh5eWtD?=
 =?utf-8?B?Q1phMHpPL0dWZkRuU1lFSjJIUG1yQ1FjZVhBRmdjaFVxK3p5VzVFS3pFMHE3?=
 =?utf-8?B?bmZibHEweFJrakY1N0RIUWdsWTFndlB1Y1g1K3ROVUVjcG9od1JGbjNtbjc0?=
 =?utf-8?B?cDN5RWZoaTBNeThvczUrWElsYkZ6eWgrMm5IZEpycjVuQnVyc1hpMkJFT3Rm?=
 =?utf-8?B?U2ppYysvYTU2K2RERjFjd01GbFZrVmZlOUs5RUtQdjB6QUhPbWVEMkc4Ymhm?=
 =?utf-8?B?Ylc5Y2xDanBJTzhTU3pGS3RQRDhkcXpFN2FSR01pamk3UUF5WVRlYXRBenhi?=
 =?utf-8?B?UzFPOEVaUEt3dkJXeDV1bWRBdGZtRUJYOTQxZjg3MTVMS08xWThITjgzNHpn?=
 =?utf-8?B?ajBsSWV1L2hGZ1kwdm9wYlB2N0tyNURIeFV4NmR0ZzhtdFFWZTRBOHNIS1dD?=
 =?utf-8?B?S3VjYzcxREQzQ0M5cHQzVW96TFppTktTSjN4UmVrdGlqbXhPckRDWDhjTzFz?=
 =?utf-8?B?dlkzOUxkZEcwOUNrdmxmc3JMTlFROElLdldIaWRONVorRHp4MXpScm0wM3hZ?=
 =?utf-8?B?RGRUWHFpbDIwYTF4UG0wZ2V3akFSSkRmK3VZTzVkM01CQ0Z4Z1piOWI0SGZ4?=
 =?utf-8?Q?eBk3lWbz6ugTSSAZ+4TTkbRn0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1CC0115994B08469CC872DA413A989B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f212784-6e30-4f42-20b0-08dc6e8db6d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 12:03:31.6705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cw/g0lgZxJ9X4+T+SioJt61RP0HbwYfhsiXkDuspEHKCmDRS4Gx8PrvXh6MfyMth5U8S577SJhzIQlfiS9/1og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6774

QW0gMDUuMDUuMjQgdW0gMjE6MTEgc2NocmllYiBGbG9yaWFuIEZhaW5lbGxpOg0KPiBMZSA1IG1h
aSAyMDI0IDAyOjUyOjQ1IEdNVC0wNzowMCwgSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5j
b20+IGEgw6ljcml0wqA6DQo+PiBtdjg4ZTZ4eHggc3VwcG9ydHMgbXVsdGlwbGUgbWRpbyBidXNl
cyBhcyBjaGlsZHJlbiwgZS5nLiB0byBtb2RlbCBib3RoDQo+PiBpbnRlcm5hbCBhbmQgZXh0ZXJu
YWwgcGh5cy4gSWYgdGhlIGNoaWxkIGJ1c2VzIG1kaW8gaWRzIGFyZSB0cnVuY2F0ZWQsDQo+PiB0
aGV5IG1pZ2h0IGNvbGxpZGUgd2l0aCBlYWNoIG90aGVyIGxlYWRpbmcgdG8gYW4gb2JzY3VyZSBl
cnJvciBmcm9tDQo+PiBrb2JqZWN0X2FkZC4NCj4+DQo+PiBUaGUgbWF4aW11bSBsZW5ndGggb2Yg
YnVzIGlkIGlzIGN1cnJlbnRseSBkZWZpbmVkIGFzIDYxDQo+PiAoTUlJX0JVU19JRF9TSVpFKS4g
VHJ1bmNhdGlvbiBjYW4gb2NjdXIgb24gcGxhdGZvcm1zIHdpdGggbG9uZyBub2RlDQo+PiBuYW1l
cyBhbmQgbXVsdGlwbGUgbGV2ZWxzIGJlZm9yZSB0aGUgcGFyZW50IGJ1cyBvbiB3aGljaCB0aGUg
ZHNhIHN3aXRjaA0KPj4gaXRzZWxmIHNpdHMsIGUuZy4gQ045MTMwIFsxXS4NCj4+DQo+PiBDb21w
YXJlIHRoZSByZXR1cm4gdmFsdWUgb2Ygc25wcmludGYgYWdhaW5zdCBtYXhpbXVtIGJ1cy1pZCBs
ZW5ndGggdG8NCj4+IGRldGVjdCB0cnVuY2F0aW9uLiBJbiB0aGF0IGNhc2Ugd3JpdGUgYW4gaW5j
cmVtZW50aW5nIG1hcmtlciB0byB0aGUgZW5kDQo+PiB0byBhdm9pZCBuYW1lIGNvbGxpc2lvbnMu
DQo+PiBUaGlzIGNoYW5nZXMgdGhlIHByb2JsZW1hdGljIGJ1cy1pZHMgbWRpbyBhbmQgbWRpby1l
eHRlcm5hbCBmcm9tIFsxXQ0KPj4gdG8gWzJdLg0KPj4NCj4+IFRydW5jYXRpb24gYXQgdGhlIGJl
Z2lubmluZyB3YXMgY29uc2lkZXJlZCBhcyBhIHdvcmthcm91bmQsIGhvd2V2ZXIgdGhhdA0KPj4g
aXMgc3RpbGwgc3ViamVjdCB0byBuYW1lIGNvbGxpc2lvbnMgaW4gc3lzZnMgd2hlcmUgb25seSB0
aGUgZmlyc3QNCj4+IGNoYXJhY3RlcnMgZGlmZmVyLg0KPj4NCj4+IFsxXQ0KPj4gWyAgICA4LjMy
NDYzMV0gbXY4OGU2MDg1IGYyMTJhMjAwLm1kaW8tbWlpOjA0OiBzd2l0Y2ggMHgxNzYwIGRldGVj
dGVkOiBNYXJ2ZWxsIDg4RTYxNzYsIHJldmlzaW9uIDENCj4+IFsgICAgOC4zODk1MTZdIG12ODhl
NjA4NSBmMjEyYTIwMC5tZGlvLW1paTowNDogVHJ1bmNhdGVkIGJ1cy1pZCBtYXkgY29sbGlkZS4N
Cj4+IFsgICAgOC41OTIzNjddIG12ODhlNjA4NSBmMjEyYTIwMC5tZGlvLW1paTowNDogVHJ1bmNh
dGVkIGJ1cy1pZCBtYXkgY29sbGlkZS4NCj4+IFsgICAgOC42MjM1OTNdIHN5c2ZzOiBjYW5ub3Qg
Y3JlYXRlIGR1cGxpY2F0ZSBmaWxlbmFtZSAnL2RldmljZXMvcGxhdGZvcm0vY3AwL2NwMDpjb25m
aWctc3BhY2VAZjIwMDAwMDAvZjIxMmEyMDAubWRpby9tZGlvX2J1cy9mMjEyYTIwMC5tZGlvLW1p
aS9mMjEyYTIwMC5tZGlvLW1paTowNC9tZGlvX2J1cy8hY3AwIWNvbmZpZy1zcGFjZUBmMjAwMDAw
MCFtZGlvQDEyYTIwMCFldGhlcm5ldC1zd2l0Y2hANCFtZGknDQo+PiBbICAgIDguNzg1NDgwXSBr
b2JqZWN0OiBrb2JqZWN0X2FkZF9pbnRlcm5hbCBmYWlsZWQgZm9yICFjcDAhY29uZmlnLXNwYWNl
QGYyMDAwMDAwIW1kaW9AMTJhMjAwIWV0aGVybmV0LXN3aXRjaEA0IW1kaSB3aXRoIC1FRVhJU1Qs
IGRvbid0IHRyeSB0byByZWdpc3RlciB0aGluZ3Mgd2l0aCB0aGUgc2FtZSBuYW1lIGluIHRoZSBz
YW1lIGRpcmVjdG9yeS4NCj4+IFsgICAgOC45MzY1MTRdIGxpYnBoeTogbWlpX2J1cyAvY3AwL2Nv
bmZpZy1zcGFjZUBmMjAwMDAwMC9tZGlvQDEyYTIwMC9ldGhlcm5ldC1zd2l0Y2hANC9tZGkgZmFp
bGVkIHRvIHJlZ2lzdGVyDQo+PiBbICAgIDguOTQ2MzAwXSBtZGlvX2J1cyAhY3AwIWNvbmZpZy1z
cGFjZUBmMjAwMDAwMCFtZGlvQDEyYTIwMCFldGhlcm5ldC1zd2l0Y2hANCFtZGk6IF9fbWRpb2J1
c19yZWdpc3RlcjogLTIyDQo+PiBbICAgIDguOTU2MDAzXSBtdjg4ZTYwODUgZjIxMmEyMDAubWRp
by1taWk6MDQ6IENhbm5vdCByZWdpc3RlciBNRElPIGJ1cyAoLTIyKQ0KPj4gWyAgICA4Ljk2NTMy
OV0gbXY4OGU2MDg1OiBwcm9iZSBvZiBmMjEyYTIwMC5tZGlvLW1paTowNCBmYWlsZWQgd2l0aCBl
cnJvciAtMjINCj4+DQo+PiBbMl0NCj4+IC9kZXZpY2VzL3BsYXRmb3JtL2NwMC9jcDA6Y29uZmln
LXNwYWNlQGYyMDAwMDAwL2YyMTJhMjAwLm1kaW8vbWRpb19idXMvZjIxMmEyMDAubWRpby1taWkv
ZjIxMmEyMDAubWRpby1taWk6MDQvbWRpb19idXMvIWNwMCFjb25maWctc3BhY2VAZjIwMDAwMDAh
bWRpb0AxMmEyMDAhZXRoZXJuZXQtc3dpdGNoLi4uIS0wDQo+PiAvZGV2aWNlcy9wbGF0Zm9ybS9j
cDAvY3AwOmNvbmZpZy1zcGFjZUBmMjAwMDAwMC9mMjEyYTIwMC5tZGlvL21kaW9fYnVzL2YyMTJh
MjAwLm1kaW8tbWlpL2YyMTJhMjAwLm1kaW8tbWlpOjA0L21kaW9fYnVzLyFjcDAhY29uZmlnLXNw
YWNlQGYyMDAwMDAwIW1kaW9AMTJhMjAwIWV0aGVybmV0LXN3aXRjaC4uLiEtMQ0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IEpvc3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPj4gLS0tDQo+
IFRoZSBpZGVhIGFuZCBpbXBsZW1lbnRhdGlvbiBpcyByZWFzb25hYmxlIGJ1dCB0aGlzIGNvdWxk
IGFmZmVjdCBvdGhlciBkcml2ZXJzIHRoYW4gbXY4OGU2eHh4LCB3aHkgbm90IG1vdmUgdGhhdCBs
b2dpYyB0byBtZGlvYnVzX3JlZ2lzdGVyKCkgYW5kIHRyYWNraW5nIHRoZSB0cnVuY2F0aW9uIGlu
ZGV4IGdsb2JhbGx5IHdpdGhpbiB0aGUgTURJTyBidXMgbGF5ZXI/DQpDb25jZXB0dWFsbHkgSSBh
Z3JlZSwgaXQgd291bGQgYmUgbmljZSB0byBoYXZlIGEgY2VudHJhbGl6ZWQNCnNvbHV0aW9uIHRv
IHRoaXMgcHJvYmxlbSwgaXQgcHJvYmFibHkgY2FuIG9jY3VyIGluIG11bHRpcGxlIHBsYWNlcy4N
Cg0KTXkgcmVhc29uaW5nIGlzIHRoYXQgc29sdmluZyB0aGUgcHJvYmxlbSB3aXRoaW4gYSBzaW5n
bGUgZHJpdmVyDQppcyBhIG11Y2ggc21hbGxlciB0YXNrLCBlc3BlY2lhbGx5IGZvciBzcG9yYWRp
YyBjb250cmlidXRvcnMNCndobyBsYWNrIGEgZGVlcCB1bmRlcnN0YW5kaW5nIGZvciBob3cgYWxs
IGxheWVycyBpbnRlcmFjdC4NCg0KUGVyaGFwcyBhZ3JlZWluZyBvbiBhIGdvb2Qgc29sdXRpb24g
d2l0aGluIHRoaXMgZHJpdmVyDQpjYW4gaW5mb3JtIGEgbW9yZSBnZW5lcmFsIHNvbHV0aW9uIHRv
IGJlIGFkZGVkIGxhdGVyLg0KDQo+IElmIHdlIHByZWZlciBhIGRyaXZlciBiYXNlZCBzb2x1dGlv
biwgdGhlIG1paV9idXMgb2JqZWN0IGNvdWxkIGNhcnJ5IGEgdHJ1bmNhdGlvbiBmb3JtYXQsIGF0
IHRoZSByaXNrIG9mIGNyZWF0aW5nIG1vcmUgdmFyaWF0aW9uIGJldHdlZW4gZHJpdmVycyBpbiBj
YXNlIG9mIHRydW5jYXRpb24uIFdlIGNvdWxkIGFsc28gd2FpdCB1bnRpbCB3ZSBoYXZlIGFub3Ro
ZXIgZHJpdmVyIHJlcXVpcmluZyBhIHNpbWlsYXIgc29sdXRpb24gYmVmb3JlIHByb21vdGluZyB0
aGlzIHRvIGEgd2lkZXIgcmFuZ2UuDQoNCg0KYnINCkpvc3VhIE1heWVyDQoNCg==

