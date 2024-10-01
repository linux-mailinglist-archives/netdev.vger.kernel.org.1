Return-Path: <netdev+bounces-130869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B05B98BCC9
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86A46B24FB5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7862C1C2458;
	Tue,  1 Oct 2024 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="oepKfImV"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCCA1C460E
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787074; cv=fail; b=GCQ3cjyuBSpxdC4irblQiKEltIW1FpnU2RuK93u9hE5WORG3imuZYRRvSmCxUYE2aqBAVHVL9xoyuuHwsz2qaY9HaZHi2VQUjpPyvtyfzoYrbf8y57853ABbra3ZfsTUumao4sv4JjW3kYrMNqdcO51oDbJ8LmQVH8TqB00usBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787074; c=relaxed/simple;
	bh=azQEo9gWOAZQLYfb5Ix3DfMT9qALUERI0y8T3R1e5yg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZzTwmMM10MyX9ZV6ewUDa0BOgtpJudJiHHbaxGIqbvSUqyfVPrgdbBGVvw984/rpauuIGw1uB/8sVj7GyANL+PfW80nhuRORhHNqDSMf6SB2XGmvOtIKmxy8IOr/AHsOj1ouZ8KsUlxe6lSlj4sxKhV2OHF3UlKjZkCBFcl1zV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=oepKfImV; arc=fail smtp.client-ip=40.107.22.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NG7DKOKDJ8Bq1a8htm0inOn+2Vro90eFXE841smD6PeakmtndpGSoAE7n0/AWGNilo7xW4h1h8Q+/FahjlsslNywY4uE2hyhPoqEJxf5eQVZUBfAlJcs1GPPr+NO8kuFruWnzseV2662MkUv8H3oZwhTmCM4+E59g5h5iK/zfXAPlUlYBObKXvC1CytQTgcK9ZUxcZJTIACbTDwIEU4mvs6mklDQS0kIO27rY6o1miBRrczRsHwvRQttwA1TMfpoel8y6A3BCbwJGGViJSI0V4XaBYDG0KF4UC7lJ3JXiV9VajSEK01pumJJT2EB4vKCb7i/WGZ9TDhpYqX0Hv/Tiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azQEo9gWOAZQLYfb5Ix3DfMT9qALUERI0y8T3R1e5yg=;
 b=pA+vlui3YEQ7NvPpfLPAGVmIpA+ech6txKphFG5OvtiNLH79vOY+NloUMUGshIjAl6XxYPfEzRWqUFWbw3st+uwrWUj9QtP0LiulyRktt1Svw8h+O7ivA4jO8GT0RjdVE7Ml6iadt/Xx9bTsyiTtqhZzSb2RzIVcOYnYzOpXF3G90IZQftVveQQRtD9/ZeV6l+Av7PB+do9uh2os7o+qAgxVxT+X/COrVXaJPFxy7p+GH1+FWJZqVt3N4iLwv7EZ4MEN3lLlhJGH8ZydkMFb8owHmJMhera6f3g9Ak1te+gM3mJyLb7k30elQs3qB4ws+ti7T1o15R9j0RCR1YyJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azQEo9gWOAZQLYfb5Ix3DfMT9qALUERI0y8T3R1e5yg=;
 b=oepKfImVDm5p6ew6q+4royr7iU72xunxA5H8aJ8Ek9iO8DjQ6KATxKEwPPpBJizWsOUWF4YOEeWcTWU0kp3mMf+6td9677mKKjFeZDpyQLruXrSgZmYm8wlbro7Ft4o8rVwjTwnXLu044zwiVIcHp/XZixeX9hmY0xtVzHyzotGcC3A8j+bW9ovb/ECZaUXtsgf9QIcQ7P7vCm1yQsS83iFypD2f/FKHzsSWz3ama430NNoqwElc16PgCC6WsstuNBpjx0sqXVXDCfQWafwwIVS+1xPiMiLLwqzAwuvFxac6LzOS4MHReNMZo8n5Od7RzkuUyRRhrNeY8UTTmMD1rw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU4PR10MB8829.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:569::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 12:51:09 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 12:51:09 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "olteanv@gmail.com" <olteanv@gmail.com>, "andrew@lunn.ch" <andrew@lunn.ch>
CC: "agust@denx.de" <agust@denx.de>, "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next] net: dsa: lan9303: ensure chip reset and wait
 for READY status
Thread-Topic: [PATCH net-next] net: dsa: lan9303: ensure chip reset and wait
 for READY status
Thread-Index: AQHbE+CTRy+Tklzr+UaZ7E82hLhQvbJxwtsAgAAHfwCAAAImgIAABFWAgAAIlQA=
Date: Tue, 1 Oct 2024 12:51:09 +0000
Message-ID: <df6715cba7b1d4c0729f9b5da44e7d34fa925d1b.camel@siemens.com>
References: <20241001090151.876200-1-alexander.sverdlin@siemens.com>
	 <aafbddb5-c9d4-46b4-a5f2-0f56c58fc5df@microchip.com>
	 <60008606d5b1f0d772aca19883c237a0c090e7d3.camel@siemens.com>
	 <20241001120455.omvagohd25a5w6x4@skbuf>
	 <4aa51df4-ba32-486a-86a5-75ea3b19867b@lunn.ch>
In-Reply-To: <4aa51df4-ba32-486a-86a5-75ea3b19867b@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU4PR10MB8829:EE_
x-ms-office365-filtering-correlation-id: eebc55f5-d829-42bb-c270-08dce217b8c2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cEo2WnRQR3JiUjQrZFdkd3BDcFZwLy9GdXFZdnRqRFErc2FQS1puV1Z0K3pq?=
 =?utf-8?B?OUVqcDU2UjFydStYMVRxbTFMNWg4MWZzUFVYU29HREF4aHpLK2RrU2lqd3hQ?=
 =?utf-8?B?QnNRWDYwYmxkUWdUVVA5VVA1WEszY1JIQlZyZ3JEalhCelplaHgvaUJmTGxI?=
 =?utf-8?B?UWJ3aW9YcnB3cU9ycUp2UjVlVVdzdVd1ZDZ4Z1k2dFRSOFpSeVdjYlhiaEtB?=
 =?utf-8?B?NkxMQzNvb2dzdUJQZTdPeG1UQWxJYlhLWkQrR1hzVWo0STVKUzVleDl1TXcv?=
 =?utf-8?B?c3pyOVJsNWhuN0ZGT1RycFd3QVYvMlJybjZsdEhSaTZLcmg1V0RsSTdsSjVG?=
 =?utf-8?B?T2duMDJMVjNXK1MxMnUxOUFYaENLQzhwV1dpZlFJdjZrZUU2L0o1emdSMXV4?=
 =?utf-8?B?eTY0UW1NS2loaWJabktiTnJPaWhpUHJid3RFN0RvbnFRMktNMWQ2KzlIOVM3?=
 =?utf-8?B?SkZ1RWo5S3I1UnlMa3IvakNjYTA3WEdadVRWMmZtbHY3VjNubU9PMHhQZFFJ?=
 =?utf-8?B?UjIwV0VVK1NjOUY5NlU1OWliZVpTV2tLdnBxVm5lcXFTcFpDbG00VE0yU2lL?=
 =?utf-8?B?TmRmeDdJMnJRVEtvRFMzU20wYzhubXRPdS9RMkkrdXJ6UysvTXVyUktPTkt1?=
 =?utf-8?B?UlpxRzQ5TngyYkVVc00yekJoRW1wL1AwaXo0R0hSMWw3Q2dlR2xjYjBtUGxk?=
 =?utf-8?B?YjYwWUtlU3huZklJZVd0QVhCemUxVGJuNkRtZGtjeHI0d1ZJcWRQWU9UYTNZ?=
 =?utf-8?B?MDNpaU9JVVBmV1UxVXlLYmgxZ1FNSDBSRmt3N3l0NENrQWFmdWRORnZ0MEtL?=
 =?utf-8?B?ci9pSFFrRzd6U2xtVktudmNOMFgxdThmbTVpOEFNOUtMWFY2TndZR240Qkh5?=
 =?utf-8?B?NFJHUW5nL0V3SmhaclQ2OExCUWtJYXovdkxET0pqbnhVVHduUjJpMUtxUUdk?=
 =?utf-8?B?NzVGaTN6ZVp1T1A5MU9qUVZRalhQeG9uM045Sit2MEZTM3NIaFBUZk5MdE40?=
 =?utf-8?B?eUluZ0Zadkc2V2lBSmM3QzJ0cWI1ZWVQeFFOam4wZTNRdUEzTW9CVTNYMzJk?=
 =?utf-8?B?ZzVmN3IxVWZweTJ6QjE3UjZpT0FKWTRhV3Z4YUxjWlNIaUFVUmJ5ZGlIaFgw?=
 =?utf-8?B?SlJ5N1dXaS9ocENUS2lZQUlkd2JkS3IrTWcycFV5WnUzcFV5RlNvTjZsYkpC?=
 =?utf-8?B?TjlYOE51U3JjK0RwUkxJdDFWSFNIdW1qMldTZ2w5dFZ3emFRa1Npc09YY3Zr?=
 =?utf-8?B?QnFta0J0NlVjNW0wUlhtTE53aG1tL0txS3lVbHpRUVVMZWJKZmZnTHZTSmxF?=
 =?utf-8?B?T25kRHhabEZlOTZ1cnBvNWFtVXIyeHpIWHNKVGV4YTVkamJUd2VpdnR3WHNO?=
 =?utf-8?B?ZzR4dy9ocGI0elc5akxSMHNkLzlqV292dk5ybWhKR0pvam4xTnBmcVl6TnBQ?=
 =?utf-8?B?T21XTXJuU3diSGlmYjhaajM5UW40U2VKc3N1ZnU0UWhVUVFRZDNxcXJBRWNF?=
 =?utf-8?B?RVArQWhvQWIzUXBLcTRNS2U4WU45R1BqUkx1NUNxZVJqdUNyWXcvVmFjSzha?=
 =?utf-8?B?aDVSTFVnRVNyek5OVWxXRktUSCs2dGNrK2lwdmt5ZGpsRWdQTEFlR3JYcTBu?=
 =?utf-8?B?UEVFTFBmWXVCdTVBY0xodlRrWEZDbk9tMVpNbmpTTzloQ2p2QmU4WGowQVFq?=
 =?utf-8?B?aVl4aE1DSEJCWU1vZzFMYmV1ek1PbTd4TGtoQ2xnZXFtYXd1V1llUll0RWFo?=
 =?utf-8?B?TEV6ZUlON1FrT0VGbFp4QldDdTFNNWkrZ1VXMEpGYkllQ1VNM0RsNW9scTRX?=
 =?utf-8?Q?QUUf9Wcr50bJsUODiQFxg2xGehYc2r5oJUZKA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c0hoWE1pMFpNS0wrU3NMR1Q0R2wrTWJ6T1JaTndDeG50N0Q2Q3gvZ1c0T05l?=
 =?utf-8?B?U1lBMHhNOGtJcnUzUmZxOU9iN2pMMVcxQzNMaElWVjRoczNxWDVLc05pMTVv?=
 =?utf-8?B?cm5nWUxjM01VK0tIRzBxdHc5TTNNVGlCUUE5T1dXRXdoNy9nVk5OMnQwOW5N?=
 =?utf-8?B?SXN0TW1ub3BKMmJ2aXdQdW85TXluYnEvQnBaSWZjZHBBZTE3RnY0K2RuZEV3?=
 =?utf-8?B?ZTFyRDVqY0Z3WlJnc1c2NW9xNi9KZFJnZjBaamZvOTJQZXNQVyt1ZnVYeE5m?=
 =?utf-8?B?WnBqU0xYYXZxZkVJNkEvWnc5TlZ1dE1JVS9OWWwxcGxHaExoQlFyU2ZwYSsy?=
 =?utf-8?B?Q1BiaDhIaEhXVnpIOXZvQ1BIK1JzRXFRcWdxeG9XQjNETFRyOUJaUDdpWmg4?=
 =?utf-8?B?cnA4eGRxZ1hVYWNMNkkra0hmbCt6WWRlOW4yZDVoRHk0dmEyVGVEUm5XNWVK?=
 =?utf-8?B?cEFURGJZOE9IOGJkVkZVMVRlcHRycHM5MmI0cmxNVkdaTDlzZWg3bTJPeGZV?=
 =?utf-8?B?OWJSM3JIN1JkeWZFaGZZam1ucCtHU2wrK0pFYmNnVDFVZUJ3RG1jSGRhbzNj?=
 =?utf-8?B?WU4zbXJ2MkVuYzNpazlibmxSeVI1b0RnYzVtbFl0UTI1Z2xHUHVpVlRuN05Y?=
 =?utf-8?B?d1h3SjhPUU9WVG9pU1lxVzh1R3UrRllyUmpuNHpuYVkwWkpYQk9acnI3SGRn?=
 =?utf-8?B?cU0xMU5nY2w4b0F5eElLYmUzTHAvS25UUVhlVlhLbkFlRmdyaFVLYUVtR2xp?=
 =?utf-8?B?d2RZR3hiRzhVNTlrd0l3OUkyd3lnTWJWTWNPbzl5SFloYXBkcTZxYzVyU3Bk?=
 =?utf-8?B?czVsSVpnYy9FaENuRXQ2c0NKVFVSNXRGeGtneFNpUnJoMzBpZUtvYUdwMjhV?=
 =?utf-8?B?aVI4VkNrd1VDVEY4YnBhRWE5LzhxY2FJSVNpY2h2OVZOZ2poeitwb1RXT2VQ?=
 =?utf-8?B?WlZ6WGx6RTFwdnE2R1BhaHlNQ2dMczlnMy9BZklzSW16R3JQOUlDV0ZKeWpz?=
 =?utf-8?B?ZTNRU1h3dXE0cVR5K2F5SG1zZ2NqU2tmYlVmdFUwSkNuYzB4b3VNVDd3RGtr?=
 =?utf-8?B?clQzbVBHUzhRb082Qnk2VUJnQm10SStvNVBIelNtL2VLSGpwdCtITFY1Zzd6?=
 =?utf-8?B?QlhmaHg3L2NoaTVEV0xuZTEwaURjeDRqRXFNT08vRDlPVDg2TjFHOEVBNGF4?=
 =?utf-8?B?UktTN1ErVVA4WkNROWJtVVlGU1VWYXo2UmRzdHNaK0VodUZJOGwwdFBZOUZS?=
 =?utf-8?B?QlpBWWNQMGhpSlVMMkZ3V1JVTDRTVm5Lb2U0WlM5ZXh4QTZRMnFGOVYxU1V1?=
 =?utf-8?B?NDFNN3VrZ29aR3R1YmlUbjJFSjRQaG54NzJ2S2V6bFA4dXVxZ1JwMFk5RGNP?=
 =?utf-8?B?REdPOWRscGlTOENJR0crRjdEOHFrRFRjZWxHM21nYWljS1htd1NVbGNjSEdN?=
 =?utf-8?B?TzBwbGtmcGFhQlYvYzFUa3VuSDlDSGpQYU8yNlgxaWJ4K0tZTWF2akNRcFNm?=
 =?utf-8?B?cWNkc1g4MURrWWZ2V1UvMW1BR2pHb1RGZTVxbksxZ3hqOUFpL1gzaVFFOGRr?=
 =?utf-8?B?dDlPbkVZZlU1ME9qZTl4Q1pjOVNJVWtGVXp4KzVhVERibjJhaHN4dkFVMUdK?=
 =?utf-8?B?ZC9VL1hpeDlxblp2Zk9pRHZTTGtvRm90NTNnSkkwUzQvc3FtMHpQeU52WkRO?=
 =?utf-8?B?anRkOGZxYW9hdHJselNpZWJXak5ucHJNYlRjYUZ4Wm82SlpiYkdwNVpNU01q?=
 =?utf-8?B?UnFtREVWKzJWT0NJc3Q1bnBjcENzUFdia2FPK2VkL3FUUC90YkJWZ0V4cE5R?=
 =?utf-8?B?Y3NmN0NDSmlKeHd0VzRPSS91K3FKRjZ3c0hKSGw0bXJOZnNBaEtYWGE4MjNW?=
 =?utf-8?B?R3NFVkRoN3FaS29sU0hSa2xUMEZWNzkyM0NpS2FjaXNrSDkyMSt3c2hIQ3VN?=
 =?utf-8?B?bWtYM0RndDBHZWF6aFNSbDd1VE1SeVd0TC9Cc0QxT2pzU1N1NVo2QW1ZcVBs?=
 =?utf-8?B?SmRmaWFGSXhYTFNxZHFKb0FNRUlLV2J4K2NWOGViSjdTeEFqTTZFS0hrMGNN?=
 =?utf-8?B?NGgzWktqWTM2VkFXWFR1U29VYUg1VVVhQWliVGVMSldLZjBzMG0yMTFIQUhw?=
 =?utf-8?B?WGlCYkdsdTJwNVBQYzkxRGlVbTZyNzlVcDEremNFWEcvOXhnQ1laV2NXdFFn?=
 =?utf-8?Q?imxzcsjw3ebUTfASpFceQP0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79C39CC7397C7A46B8FDAAAC48D45A08@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eebc55f5-d829-42bb-c270-08dce217b8c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 12:51:09.1295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ba/x7MLPH6E9w3ZML5gPWs0zaEov2jHZSUgIw1uWb3duwM+9e09xLPmHmZw/oETIadwrQZ+HiUEiw/fcQV+YSnd6OCpHLYbfqjvhIq9uJJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8829

SGkgQW5kcmV3IQ0KDQpPbiBUdWUsIDIwMjQtMTAtMDEgYXQgMTQ6MjAgKzAyMDAsIEFuZHJldyBM
dW5uIHdyb3RlOg0KPiA+ID4gPiBJIHRoaW5rIHRoZSBzdWJqZWN0IGxpbmUgc2hvdWxkIGhhdmUg
Im5ldCIgdGFnIGluc3RlYWQgb2YgIm5ldC1uZXh0IiBhcyANCj4gPiA+ID4gaXQgaXMgYW4gdXBk
YXRlIG9uIHRoZSBleGlzdGluZyBkcml2ZXIgaW4gdGhlIG5ldGRldiBzb3VyY2UgdHJlZS4NCj4g
PiA+ID4gDQo+ID4gPiA+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL0RvY3VtZW50YXRpb24v
bmV0d29ya2luZy9uZXRkZXYtRkFRLnR4dA0KPiA+ID4gDQo+ID4gPiBJIGV4cGxpY2l0bHkgZGlk
bid0IHRhcmdldCBpdCBmb3IgLXN0YWJsZSBiZWNhdXNlIHNlZW1zIHRoYXQgbm9ib2R5DQo+ID4g
PiBlbHNlIGlzIGFmZmVjdGVkIGJ5IHRoaXMgaXNzdWUgKG9yIGhhdmUgdGhlaXIgZG93bnN0cmVh
bSB3b3JrYXJvdW5kcykuDQo+ID4gDQo+ID4gRXhwbGFpbiBhIGJpdCBtb3JlIHdoeSBub2JvZHkg
J2Vsc2UnIGlzIGFmZmVjdGVkIGJ5IHRoZSBpc3N1ZSwgYW5kIHdoeQ0KPiA+IHlvdSdyZSBub3Qg
cGFydCBvZiB0aGUgJ2Vsc2UnIHBlb3BsZSB0aGF0IHdvdWxkIGp1c3RpZnkgYmFja3BvcnRpbmcg
dG8NCj4gPiBzdGFibGU/DQo+IA0KPiBBdCBhIGd1ZXNzLCB0aGV5IGhhdmUgYSBsb3Qgb2Ygc3R1
ZmYgaW4gdGhlIEVFUFJPTSwgd2hpY2ggb3RoZXINCj4gZG9uJ3QuIEkndmUgc2VlbiB0aGlzIGJl
Zm9yZSB3aXRoIE1hcnZlbGwgc3dpdGNoZXMuIEJ1dCBpIGFsd2F5cyB3b3JyeQ0KPiB0aGF0IHRo
ZSBFRVBST00gY29udGVudHMgYXJlIGdvaW5nIHRvIGJlIGJyZWFrIGFuIGFzc3VtcHRpb24gb2Yg
dGhlDQo+IGRyaXZlci4NCg0KVGhlIGlzc3VlIGlzIHJlYWwsIGJ1dCBJIHN1cHBvc2UgbW9zdCBv
ZiB0aGUgZGVzaWducyB1c2UgTURJTyB3aXRoIHRoaXMgc3dpdGNoLg0KQW5kIGl0IGFsc28gZGVw
ZW5kcywgaWYgcGVvcGxlIGltcGxlbWVudCByZXNldCBHUElPIG9yIG5vdCAtLSB0aGUgc3dpdGNo
DQpzdGFydHMgRUVQUk9NIHJlYWQgcmlnaHQgYWZ0ZXIgcmVzZXQgLS0gd2hpY2ggd2lsbCBjb25m
bGljdCB3aXRoIGRyaXZlcg0KcHJvYmUuIEJ1dCB0aGlzIHdpbGwgbm90IGJlIHZpc2libGUgb24g
c2ltcGxpZmllZCBzY2hlbWF0aWNzLg0KDQpOZXZlcnRoZWxlc3MsIElNTyB0aGlzIGlzIGluZGVl
ZCBhIGZpeCwgbGV0J3MgdGFyZ2V0IGl0IGZvciAtc3RhYmxlLA0KSSdsbCBwcmVwYXJlIHYyIHRo
aW5raW5nIGFib3V0IHJlYWRfcG9sbF90aW1lb3V0KCkuDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJk
bGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

