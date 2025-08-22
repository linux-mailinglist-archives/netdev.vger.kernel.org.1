Return-Path: <netdev+bounces-216036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE633B31A2B
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0544B1893B5E
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 13:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDBC305E01;
	Fri, 22 Aug 2025 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QKrog6DR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1933054D6;
	Fri, 22 Aug 2025 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870348; cv=fail; b=poz3NvZ80e9F5AR8KZ0Hh22QluDU76KNQKP9O/GNH+DyVoMbl2c7pgzGLtock/xdcxvPH5/b8k1jIDrxsw8WQmBmjtKtxzKPliR5bDDEvXiTDOl1qPUxGGyHHpsXBWGCYfl8E8TsmzEicSE7nNzcWt1WOCMRM17Gqr98dSLBkTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870348; c=relaxed/simple;
	bh=81RlcHsGMPYcTZTbJ3Pynxay2d+RVHmpVOdR2CI/svs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=te0To4yppfraURfgMyhXmWgUlVaAk4KIzE1CSMH3KJxLLKjLyThKIb+pgn9jW/57FrftBoBEYHVN7cFAbBgT7fOY90tpQkDPqSn3Qq6ZOZiu2Yxs0LveV2G6ksyVWmZGBtMoHLIIpYRfzfL+omKsEDLCJRu/C80dCd3zdhcpU3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QKrog6DR; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byQhckxyJSwQdhWe5NaWScbpENqceDhYuq2hUA6m3JClH2Ar/FlWDq2hnbd5vt2tofB8CVg1f9XsRm4VHWIM5a1s411JhsCz28QlWcYgt1sVmFdMS+1vuyUiqehktQ76aI7GNGAxUxFQM1AiyoPAAXg2Y1FJAq3YOLzYEctsMThfyfKB8u4gZckp/amUIgUujFw9dZy9YIebwAdaCF6uFTjodXoML/q9PO/ZB/mRey+fQLAu0K3LMPzh1eeB6eXuT8+5TJ4pyygfyQmvuhSrPZKksTie72woC10V9jqJxFeDGJBAyQOkHP0YB7tLXixuGmpb1VTeM3YsfkMYQwjbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81RlcHsGMPYcTZTbJ3Pynxay2d+RVHmpVOdR2CI/svs=;
 b=IuvAlrBkggDGjtQz0dJRhNzqdBcim8DrlQUE/tQ6zicAuAAGQ9bHj8+kEZoEqrnHX8V/nov1s3f6pSwnrc60hzm+hfvzdk7nIbZ/rsSmIz8ZKEg1OrP3GUpy0RAFuerORTiXp1pzth0ImbgmzZD/1I+RoZBKK4GutwY+2IkkTVgZC5ozn7Fya8vwSeZaAOa9qwCHogRRiUyRT/kTH9ek1dpVPBLzEpLoVc4pBDOBiMenjdd1dNcJqs1grEv5D030BPrSaC0QCXDXw7W9EvUFllOnqQfYqXOXb8kylFshkESj8EFInNwoCw+43K+HNbiIT14hBGcR/PPKaCyrWoP6rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81RlcHsGMPYcTZTbJ3Pynxay2d+RVHmpVOdR2CI/svs=;
 b=QKrog6DR1qdH+1Pi2miu0VZs4i1vZgNqeGnzK51Bkn+EeWBckj/mCSlvORs2JKaQwB2ahSz6FtbiCnZjLDFaKoTkHQOXi2ow1V+14sD26dgvLGcgKWN9Oa4m3zrRKzozwOhAa80Iov48uVD2SscCKj9mvweqUtk904Q3gwAKnKBqFQ6t3YjjULTT/1lKcs4y1he20+ibaxYJZVmcaUu5x09yy9Q9Mw88wm8RjOgrco5FBct/8kZ3I+z/KeT8Npuam6WWXrEo/9AiVhjfZz+sxzID8QD0wZ4lJ/SuveQtc5KofYaxQT+ax9jvHCPi2nBWm0a0K2YS4rOnyMYG5i+lVw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by IA1PR11MB7891.namprd11.prod.outlook.com (2603:10b6:208:3fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 13:45:43 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%7]) with mapi id 15.20.8989.011; Fri, 22 Aug 2025
 13:45:43 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] microchip: lan865x: fix missing ndo_eth_ioctl handler
 to support PHY ioctl
Thread-Topic: [PATCH net] microchip: lan865x: fix missing ndo_eth_ioctl
 handler to support PHY ioctl
Thread-Index: AQHcEnWbR+tCBESmtUqmTIms15S55LRtz2IAgABFB4CAAI/4AIAADM4A
Date: Fri, 22 Aug 2025 13:45:43 +0000
Message-ID: <6137118a-bcb6-4c4d-98bd-10e065145a60@microchip.com>
References: <20250821082832.62943-1-parthiban.veerasooran@microchip.com>
 <204b8b3d-e981-41fa-b65c-46b012742bfe@lunn.ch>
 <4a2e6ca1-7ae9-4959-a394-c84aab4b4c02@microchip.com>
 <5ac05a1f-0cd2-421c-8747-9159a62dce2b@lunn.ch>
In-Reply-To: <5ac05a1f-0cd2-421c-8747-9159a62dce2b@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|IA1PR11MB7891:EE_
x-ms-office365-filtering-correlation-id: 1a1db9c7-a446-40ec-ece2-08dde1823074
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UnlFV2JYSDRVRjNYYlZRaExQajNGVTQzMnFnVFdzMU54cmZlcFdSREU3N0h2?=
 =?utf-8?B?emQyWXpuaFlrclJzbkFOUXd3K0huMUdMTlhZTzdiMHpPSFlBa3IwWWoxdWpl?=
 =?utf-8?B?cTJ6MjdzUTI0UFl4bWdEbG5HcDNnamQ1S2VQWTlMYS91SVV2ZnNTTGNhVFVs?=
 =?utf-8?B?Zm9VSnphQ2FuMGNkRGl0OTRFRHlQb3JQQUJiQzRtRUtCOVhsa2lPRDhNZFBx?=
 =?utf-8?B?RlIyMFIrYkovY0JQb1BCVUU3cGNvMi9wM3NBSlAxQmNnSkN5MXFkbXJNMklM?=
 =?utf-8?B?eXZoblBuRzhWNmdmYmIrTXF6M2htc0JmS1BVSGxtTGVUMGY4am85QTVLN2Y5?=
 =?utf-8?B?Z1czMHl2RjNqMyt3MGNRdEswcFpvZFZub1l4cXBIRmlyZEhFWUsxSDJZeUpq?=
 =?utf-8?B?K00wZEVtNkY1QjlrS0cyZzdaSzJqZEY2M0hpeGVyV3QrUmRPL1E2cmpSVFA1?=
 =?utf-8?B?dlFFM0d3YXFGc1daSHQ4ZW1SVUxhY0E3NTk3NWduV0VhNGRSSjhpUjF3a24v?=
 =?utf-8?B?YWp1bzhwOXRKbDVOdlBNNDFFVjdHcjVrd2pUYy95Tm5kdFJBK1FNWm9pUFpk?=
 =?utf-8?B?dEppWi80Y0hVSVZYOEw3a2xuR2d4Y1c0WFJjTGpoRjUrbDM3a050VnJyVVl4?=
 =?utf-8?B?dUdyVlRNTk9QWnlQdVdGbC9SSHEvMEcvVW5oT0dJUXpHSFJNTU1MSTFyS0dk?=
 =?utf-8?B?ZW5qNGFYdVRLOS9NWkk1OVVqQTVLSlFIWFk0eTMrVVVvRE5NbjhEamRuQTUw?=
 =?utf-8?B?Vjk3K2Z3QmR3QVFvVDR3d0dDa0R6RTRjc0Y2Z1lVVkFMOEREbXlBRGZiSzVi?=
 =?utf-8?B?aFlCem1mbU9QbFZsdDkzNU90UzhGR2ppelJ4ZFNzRFNaemNPbDNJdU1kSm5N?=
 =?utf-8?B?TDgySkduQzZiVlltU1BCMUxyQTFtbmVEY3kzcEZDTCtrMVdiYllLN0JxaEZB?=
 =?utf-8?B?V0puc1Z2Q1R6SFZhWU55TVZvNERTTXJCbzBUdlFvVHp3UjdacGh0TXI3QlhV?=
 =?utf-8?B?THpuTnhWdEtaRllCSXh2ZjdEdXVjMXJzRWs4ai9wa3I2OTRZdXV4SlBsS1pu?=
 =?utf-8?B?YWhpS2d2ZnZVRDY0Vncydi9nNkY0WVFzL1RuT25VSU4zMDZSK2N4bm5oait2?=
 =?utf-8?B?cTZVT2VkQVFBdlVLQW9oMjJ1dGtuSVBJSW1QQVpnamdkWmFIbVgvVGFTa3Vw?=
 =?utf-8?B?TWZsZHhNWnBXK1hJeTZTN0pOTHcxaGlLVUlkaVpKbkVFQnkzZU9xWVZRUVFV?=
 =?utf-8?B?VGNDQkV5Z0JtYm1hdVp3RlBYNWRJTGhpMENWbXRSY3NUbFdsd3Erb1FWRUM5?=
 =?utf-8?B?VWJNR0g5amVEeGU2VHkwWUZEVCthZi84WE5NenBwTDd5RG90K1QvenRVWjkw?=
 =?utf-8?B?MlFxN1hXcW9rQlBKbnBwcFZwbnpOVmtEaWJHTUxKWVF6YnpYOGNqMDVKandX?=
 =?utf-8?B?eXlDZ3FlYTZrTkt2SFVwN0VqZFRQRk5yd3Y2R2pYUFFqRUJzcGlPTkk1YkxK?=
 =?utf-8?B?WUNWb0RGZUZ5ZkFjNjlOYVdySExMRWhleGFjb0F4ak81dUFKaWQwTVRhYjF2?=
 =?utf-8?B?NkhXTlFrMnpmd2dsL1dWV0dKQ0xvaW9NMlV6bGE5Q0EzMjJ4cWduNXp5cFk1?=
 =?utf-8?B?TVV1TFdDeE52YUN6UVFpYy9EellJck45eE9FS3QrbU1XWkN2dXFDU0ZXbVB3?=
 =?utf-8?B?SzUxcTZrNHcrMVJDcTM0ME9ETTRYclBJajJiVDVON0tvaEVPY2dhNjU3TUQ4?=
 =?utf-8?B?UmNSeDQ4UnRETERFeDJUVzlpeUVZSXhRSmFma0p1dmtGOUNFVUNOM1hPVmdi?=
 =?utf-8?B?dGwzWXFjcm5SaGJjaHVCalNveXE3Tm5uOEFnUHZPdTdFRllBQ3pRS2daVXpN?=
 =?utf-8?B?cFBjWkU0YVRjZkowdXQvKzJ2OGNtbkRhMDN3cU55bmpKVlhXZkJJUVpRblRO?=
 =?utf-8?B?SmRVT09hRjlBaWJROGtXYVV0TW5KeWhvczJMM1RqSG9TTGZKUURvb2pkaWZq?=
 =?utf-8?Q?gNf8z4kgF4HErpBqzwyU9gNubV/4Q4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHk5cTdJNTF4U0loTkdseTBoUVVLNk9CYTlmNjBpMzNFRmorVUhnUG5SdFpX?=
 =?utf-8?B?WHd0NW82MlFraXRCdkV1Zm05cGtGT0hEOVZQZU4xRnRwdzBOWldNSDJ4RTI0?=
 =?utf-8?B?M2NIRjluMHlxemE4cmphUXMrRkRtS0J4MGE1WkRoaTA1bkFhK0FRQk84Z2tu?=
 =?utf-8?B?cU9oZm0zT1Jnc0t0RmNjc3BPQ0xxalM1ZFNKRWtEODNBTUxkUUR3Q3p6dFpJ?=
 =?utf-8?B?OGtwbHQ0eUNOd3cxTlZkUDBCdWRveEhGTVZOenlXVVEvYVdnUytzTlEvVU9S?=
 =?utf-8?B?M3NEZFV2VC8vaGZaTG15bE1EVndMbXRTcDVrMVU4V1NTM1dCMXd5bHdnR1p1?=
 =?utf-8?B?VmRpa0R1dkFsRE0rMU9rTEladUJnWW9vNWVpamZmZW1CU1JjM1dTUkpKenA4?=
 =?utf-8?B?ODlyOHQ2RnVRV1htZE1wc1NldUlFbGZKZVhqamI2UFE1K0g3MW5lWm5VbTRJ?=
 =?utf-8?B?K1cxZ1IyVUFvOVJwVFY4alE0dHpTYm1YVHlxczA4ZnhKYmNEOTdOOGZDQkxp?=
 =?utf-8?B?NE1DOFFJbTI0dkFKeUZWSkVtSXBDeUpNdFd2RWZjbXEwM2MwU0ZCblN0Q0lx?=
 =?utf-8?B?UmdpTlJlNnBPZjBzTldqMmJBM1lRaWZ6SmtpajNDcHIxbkJjaGh1bzVobWNw?=
 =?utf-8?B?UXZaWjZVVVc0eGViMldqLzZyZW1DVXhIT01wZVFWMXBNaDhCY0NVTFNVelMw?=
 =?utf-8?B?NnlBMkRpbDhkbnJDdEhlMDIvbEI2QTY0WGo1ZjRDL0pyTzBtaTdFMnlUbnZy?=
 =?utf-8?B?MWNPaGd4T0FjTDJHZGpzK1R1OGJRd1hKQXdXb085Y1VCc0dXYmh5KytPSk9o?=
 =?utf-8?B?SitaRE1nMkFDUFRkaXhXNVlBUTVtc0RYVThhQ1AremF3L1FKUTlKV2hjSUNn?=
 =?utf-8?B?K2VGNU9jNGhxSU1BMzAvOGVoL1VyaXc5OHJLTXdMSXNHaHMwa0x4dnIvWGxD?=
 =?utf-8?B?WjVuUzd0K3Nrb0JFS1R1ZVI1bUlqMzZtb3lBSTVla1U2UTFhLzYzTmNML2dp?=
 =?utf-8?B?MU9BeTlVTkRxaEpOVHMwRC9YS24yU3ZodE9qVTdQaEVrYng2bWlJN3BVa1Z1?=
 =?utf-8?B?OEJqaW9uTisxZkNHMnNJR29XaSswbXlmOEJsY3hwcWxOSnpKTTJoVWVBZHNP?=
 =?utf-8?B?TEZHdkVZajJuWFJ2eUV3T1JsbllhalNEdnB1Ukhqak1CVE9aaGxOM29kaWQ5?=
 =?utf-8?B?L25VRWsydWdVNDFBbVpNNlpiNnNPUkZubzdJZ1Z4YTZJcUp0V3VidGJCMCtO?=
 =?utf-8?B?NTRHdFdWUTFLRkNiajFYREpYUVhZelVpaDVmcTZoQ2JZeGNKUVM1MFh3R1dx?=
 =?utf-8?B?QzNIUEhQSTE5cTNZeGlRL3BRWjhBSW5WdFdMRmd3cWJna3F0YXllSURaMmZm?=
 =?utf-8?B?bEttUE1hM3lKWVN3dEkrM0ljWG5IWmRDcU5TNFFLSlhaL2xHMWlyeUtNT3li?=
 =?utf-8?B?c0ZPbDdDa3RFT2JGSzRMOTBwTjJEN1liMWVFbmtxQnJyNm40K2IrQUdOMmtX?=
 =?utf-8?B?SGxZUVNpdjlHSnMyVVJCeTBkOEFvRFI0bWR0MnIvZFVwcjNJUStXdERUZ3R3?=
 =?utf-8?B?MU1iNCs4MFZ6RDMwUndEc2pKSzd1Z0N0KzlJUWVxTFB0cWFCamJqYXBsajlv?=
 =?utf-8?B?NXBLMlVPUWNxOGxGSUN2UTFjSDAwWGhsVDVBc1pQbDlEd2ZMLzE4Zy9EbjRR?=
 =?utf-8?B?bjJud2RwZmEwZW1aaUp6T1pydktUTTZ2TVZ6MFdMaUJEb0ZrQ2lTb04vaUFY?=
 =?utf-8?B?RG9tNVN2eU1iS1ZrWUhZcHlRUEhmUkxXUzNSK2Q2cEY5R3dGd1pWZXVYQnRu?=
 =?utf-8?B?VGxDa1hjOG80bjBIMkFWOWxIVFhqcVJoWjZLMVJxbCtrV1V5L2FXUTJ5V3Uw?=
 =?utf-8?B?SWJPRHBKNkhaUUtVU1dMZ3hHemNNUDFmS05pKzNrbUdRRFNwTkRRVnBUSFky?=
 =?utf-8?B?UXk2bkVSZU5zQWczcTk0OVVhNG5WYkNlYzZub1ZqQTBmcmhiWVNMMVVtWWJa?=
 =?utf-8?B?OU40RDk4Q2E3YlRhZER6ckV4TjhnNGZwRjFvWEhMMlFCQisvQlA1T2w4ZWVR?=
 =?utf-8?B?a2YzclpEdFBVc3R4ektWK0cxRW1YNU91M0U4cC9wTVNyNCt3bWRoV2V1VXA1?=
 =?utf-8?B?YU9oSnNiaVZ0MHNBNWo4T2dpcFY4NmlrNFpiSkRHak1MZGFUTVFsMlVnR3Bq?=
 =?utf-8?Q?6tBbvf20zjmvUeLoHlYexRg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EB97996F5EA7B40BEC5185BD1097D90@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1db9c7-a446-40ec-ece2-08dde1823074
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 13:45:43.0876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BAdpj9YVSBtWOfHSQcUYL1yPkeRWbcde2JBcR4c3+cgVE1HtpNdFEuQqRZ3GuTIMouj7RDtOfzO18nDwz+z6ZNNe/Q0intk8ahKsWuNXaualu5KtsR/D8YVmYWq7juv5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7891

T24gMjIvMDgvMjUgNjoyOSBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4+IEJ5IHRoZSB3YXksIGlzIHRoZXJlIGEgcG9zc2li
aWxpdHkgdG8gc3VibWl0IG9yIGFwcGx5IHRoaXMgcGF0Y2ggdG8gdGhlDQo+PiBvbGRlciBzdGFi
bGUga2VybmVscyBhcyB3ZWxsLCBzbyB0aGF0IHVzZXJzIG9uIHRob3NlIHZlcnNpb25zIGNhbiBh
bHNvDQo+PiBiZW5lZml0IGZyb20gdGhpcyBmZWF0dXJlPw0KPiANCj4gVGhpcyBpcyB0aGUgc29y
dCBvZiBwYXRjaCB0aGUgbWFjaGluZSBsZWFybmluZyBib3QgcGlja3MgdXAgZm9yIGJhY2sNCj4g
cG9ydGluZyB0byBzdGFibGUuIFRoZSBGaXhlczogdGFnIGlzIG9ubHkgb25lIGluZGljYXRvciBp
dCBsb29rcyBmb3IsDQo+IGl0IGJlaW5nIGEgb25lIGxpbmVyIGFuZCB0aGUgd29yZHMgaW4gdGhl
IGNvbW1pdCBtZXNzYWdlIG1pZ2h0IHRyaWdnZXINCj4gaXQgYXMgd2VsbC4NClRoYW5rIHlvdSBm
b3IgdGhlIGV4cGxhbmF0aW9uLiBBcyBwZXIgeW91ciBzdWdnZXN0aW9uLCBJ4oCZdmUgbW92ZWQg
dGhpcyANCmZlYXR1cmUgcGF0Y2ggdG8gbmV0LW5leHQsIHNvIEkgYXNzdW1lIHRoZXJl4oCZcyBu
byBwb3NzaWJpbGl0eSBvZiBnZXR0aW5nIA0KaXQgaW50byB0aGUgb2xkZXIgc3RhYmxlIGtlcm5l
bHMsIGFzIGl0IGlzIG5vdCBhIGZpeOKAlGlzIHRoYXQgY29ycmVjdD8NCg0KQmVzdCByZWdhcmRz
LA0KUGFydGhpYmFuIFYNCj4gDQo+ICAgICAgICAgIEFuZHJldw0KDQo=

