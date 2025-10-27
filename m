Return-Path: <netdev+bounces-233154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38C0C0D347
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 12:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5687940548C
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 11:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8282FCC01;
	Mon, 27 Oct 2025 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nC+hxZQa"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D101F2FB98B;
	Mon, 27 Oct 2025 11:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565172; cv=fail; b=ON/R5DHa32gubBQ9o5A3/ZNnlx7tM1FkTw28nps/oOPsB6blXCkT9TVkVVHODFdHAWH/gHKsmARalMh+JFqpBv2BVjQtYV9wYY720MzQTp1NrEJPtHwDeCwegryvCI/smN+/f3niNlbP+OaajRvChuXrO5W9XsSgswgwzvRjnro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565172; c=relaxed/simple;
	bh=LeWTdBL0kIwP9PRyIFBMpd7cyOkkzLUk8cWEAc5V6jI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jiwMV5202yaozj46OpUtSxnvjLpgNVgtkKyuYxIE5PrFKayTPthjuS0nhcbQejFLSAk/GD1nM9spZqtqbtm/QZ8taBNRpPkEnsPG7075yWNAiYtTswJCplbRwSVt+JozivVBQgELiXTgF6cdXLGVquvf+PfZn+vQSqqWqu4L9vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nC+hxZQa; arc=fail smtp.client-ip=52.101.70.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOlx3QwoHAyDJJBS8Z+SIcgxUcBVyc4i2b5ycqWhVnUNGSqXpAJfCiLIdWnLRrlWkvPGLcISoZZJeJw5g4GBtZO7J6G47OL6cD7flncwJhqzo31e2zLbhgxCJ6iowUDTnwls+c5LnC4ucm97O9Htbqo3xdeZg3oI858HffsXoV2Drp/e8f4dCnMilaaw+C9GHxbKpaptgq19uJh3OckUD/0F6zKOFH54Pcnl1Kckyn9S5YfY45xmhzu4xjPXaDYphJOgfVz4J/cfPjgCJeL6eyr14rZjCogK3sN+FuHV8zeirleiqV0NK0ePZ2p81FaXgwe7tofLS0TSqhjR5LaVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeWTdBL0kIwP9PRyIFBMpd7cyOkkzLUk8cWEAc5V6jI=;
 b=w/jLIlf44ICJzIVFVS2lKILEFdKH0FLgDFYaWTwBRfXRHEOHoMvm2jopXg+xw4oDk+AmQdb4lV+fX1YtHmqnkU2GxuiEQY7t+QaoF99hXuE046GBppFAP3DcCVg/l9kzGRXOiyJ2OPgI7jvwvHN+AAj+9u2B/+kCJtfKw26IVsGHKoPQbiHGu2cRQzB1RhmDl3QPs2i/aiRXaWUyT+ZQYhIljcLJZiOr9WFr7m2iybvug3AG2zGvd+8whPjfVVlsAYneheFzNAaRyoO9Xg5qwsmhgDAWsfvRXbP0PHIAUB3DuLFQBed2pC91lz70HHm3C+QDOABbiOxRg9yVbKkjcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeWTdBL0kIwP9PRyIFBMpd7cyOkkzLUk8cWEAc5V6jI=;
 b=nC+hxZQa+1RGk7QhykSSzl4Sy+HO0usm+xdUBKFKFaNsu1H5WPHIhE2f0rASBMAh1enH5E29pKYxI/ax5/vQWa8/YGgvB5Cc0fJBZOLGWuz2m/qQTXEaqgSn+BhCPdZUx0lLcMS5BdFWFMl2JJ/zULtggUEJwV46hOqp9yH53JgxeJBXrnzg/WFn71h5R8E9qQE12bPodzQTEOMDPUSRtnqE3RKPBms9J27ndoJoYltqiOaRoSeAVhjKseYzDKvkV83TUm2JIzie4HbOwfUsTCfCvbu6dhTb/HjWJHtDkq6RDyNkoDYomz6qgOPFBMriTMPP0/ga57UC4LHQWDvbKQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS8PR10MB6248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:561::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 11:39:27 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 11:39:26 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "robh@kernel.org" <robh@kernel.org>, "lxu@maxlinear.com"
	<lxu@maxlinear.com>, "john@phrozen.org" <john@phrozen.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "yweng@maxlinear.com"
	<yweng@maxlinear.com>, "bxu@maxlinear.com" <bxu@maxlinear.com>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>, "ajayaraman@maxlinear.com"
	<ajayaraman@maxlinear.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>, "horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "jpovazanec@maxlinear.com"
	<jpovazanec@maxlinear.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v3 09/12] net: dsa: lantiq_gswip: add vendor
 property to setup MII refclk output
Thread-Topic: [PATCH net-next v3 09/12] net: dsa: lantiq_gswip: add vendor
 property to setup MII refclk output
Thread-Index: AQHcRtLkAkqQxuLTp02K3P7FyKbbgLTV3wqA
Date: Mon, 27 Oct 2025 11:39:26 +0000
Message-ID: <faa691db9e8452834f476aac9405cb8d4a70cbcc.camel@siemens.com>
References: <cover.1761521845.git.daniel@makrotopia.org>
	 <869f4ea37de1c54b35eb92f1b8c55a022d125bd3.1761521845.git.daniel@makrotopia.org>
In-Reply-To:
 <869f4ea37de1c54b35eb92f1b8c55a022d125bd3.1761521845.git.daniel@makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS8PR10MB6248:EE_
x-ms-office365-filtering-correlation-id: e6078616-3eb8-4b1b-298b-08de154d7bc0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?N0NzTG5iMVBxMG4ySzhVZWszOUkvMlU3YUNWeEkrNkkvNEdxZ0dtSDY0NlBU?=
 =?utf-8?B?eFJrYk5zakQ1aGgxT3RTU1ZXakU2b1d2SXF3bFRiamlSZmNuK0lPUmdhVWJP?=
 =?utf-8?B?c2cvYWhjZVo2cWRzZVFtVzJTNmZQYWdzUExPT0lieitpYW9VNGZOSXlUYkpp?=
 =?utf-8?B?WndmTDJNL0pSYmJBMHFnMVJoeGszSWZrOEtyZUhlU1pKT2NId0VQYmpQQ1V4?=
 =?utf-8?B?YXZCdmV0N0RWQlhadkhFZXdmc2Ewb2ROUVFMcmcrQVdqNHFLNkVKZTFucHlZ?=
 =?utf-8?B?NzVWMkVVbU5VNklFVTRTYk1oQVZ4ZzNJWU1Hdk9UTUwrWElPRFhuYTAwakdN?=
 =?utf-8?B?ZTVKQTFGYVhzaG9ZdHV0QnBjK1FEdXh6MmFLZFM1S2J2WHRCelpJaUtyR1A4?=
 =?utf-8?B?L2RrR2JQK0lCekN6OWZLWEw4ZGQyeVpEaWtGVUtwY1VTaXVIT1lyMGx0Q2hu?=
 =?utf-8?B?Z0UzYW12b2phNmxOcFk5YVF0MnN6dGp2bXdpd0ZaYmxpUFI4ejd3c3diRk03?=
 =?utf-8?B?WEtSWE9yQnB1eGNWcEY2a2JsT2R4QnY3NXdLOWhySm1QdGJDVUpCMFBaSUVX?=
 =?utf-8?B?bDlwWlBXdWFMRFZ3djZtSWF4VkhQSzZ5MWdRMjltem50R3RWQ1hWa2E2SElp?=
 =?utf-8?B?bC92YytDaklaOHNBT0szTFI1MlI2OXAwNXRVWHFwRnRvNVFYWFBwRG5qMUtB?=
 =?utf-8?B?TUc5eGRUam5WbCtKV1poSmFOUWY0Z2ZsdUxKbFh1RTZPQzNoUlkwbXdJUTh3?=
 =?utf-8?B?emV0UW9SMGI2YmpDRmpuMWFqMFVHOVkyYzZhWDdMUHIza0FNR043Y1VmcHVX?=
 =?utf-8?B?ODF3Tk1vemRQQnJremtYUU9pVjk1SlRUK05sV1ExRVhaSGR4VUl5cm9RaVVI?=
 =?utf-8?B?TEtubTNhM3R3Sk1aL0tqQWozSjdXYTNJSjRCY0szS1lvaWVlVGxtWXpXT3Jr?=
 =?utf-8?B?T04xSWYxSC9hVUhYbnZvK2J4QkFGVzc2ajN2U1g5TVc2QUZSUUJvQk9zaWE4?=
 =?utf-8?B?ajc0Wjh3aUIyZXBWcytqTW9XdFlkYXRGMldVVW9UT2dTWVNWZU5QSmlMQ3VB?=
 =?utf-8?B?MTdaSE53M0Q1OE4zdEhvRDZjK3lJck1aNWhFcE5WakpOQVdQTzNXUFIyazda?=
 =?utf-8?B?YnRjUWR3c1FzMGxuQXZ3YTlpYlE0Y053Zk5tMk9zNDFJRFpVZDNTY1JKaisz?=
 =?utf-8?B?ejZPNXZSSE1NcW0zRVpXUXJBV2E2UDNMYTF0U1RTQ2RPWEFiMUVxcFpmMVpu?=
 =?utf-8?B?UklZeENUOGJUYzRTRGJBUDNPdnVtOWF4dHZDMlBIdERXL0UydmtHT2dIaEhR?=
 =?utf-8?B?cGx4QmwrUitReUhiay9OZlE3V3BCQzJXSlAyNlV6VFdqVlA1TmlUcmZYNzIz?=
 =?utf-8?B?eVFJalFaM0JRUVlRU3FyWXlxVGJERS9oMGhiWGtmcXVlK05nOWE1OWNjVURq?=
 =?utf-8?B?WXVVd2ZpUWt1VklTY0N2clVhY3QvL3A5QzB3UllMRUNNSWhMcHZIWmFPM0NV?=
 =?utf-8?B?YzdXODRTL2FjNVJ0b0MxNXJwWDVmTGhRRVY2TFc0cUh3ZmV2WlUzR3J2TURM?=
 =?utf-8?B?QTd0YjNWdk5uUTF5cmpBS0duMUNpWGtQSTdKa0gvSWI3a1lZVlBHUmRTanRI?=
 =?utf-8?B?TFFqU3kzWmExZTNLTkhjVUxZYk1RL0dwbXlxcGxDL3g2MVMxWDVqTi9vZC9W?=
 =?utf-8?B?eXpBLzBFeFpidHZjRWFKUHREb0tGV0RNTHgxSTdwTkJuRDBJUDhlZGVwYnZu?=
 =?utf-8?B?NDF5RU9vbUJiUE55WDZjV1ZycW5IT216YW5YS3cwUGM0bitvaHZCaVBBZ2ZX?=
 =?utf-8?B?VTRESDdRcUpFZ0hkdHJlcm1kdkxJaHRMZnh5SlBnY3pWK2NpWUtONENEUHla?=
 =?utf-8?B?d0Y2MURrUWNVZFBaaDloOVlkeHEyMFRoaFhOR2tCcEdYMk1qMG0yaS9yZG02?=
 =?utf-8?B?RjZEVmhaaTFTSExqUDk2ZVMyQ3hHQ2VXZVVXTDRlUStmdmViVFVtdUhvOTVi?=
 =?utf-8?B?K3dYTjJhSXFFek1UVTdmVHVzU1RmZ2tmQUd5cXM1MW15TVdnSktMaWxiUHhj?=
 =?utf-8?Q?mM09Wh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?LzdGbHdOaFhhSElQRXo1aWdmNE9Db2p1M04ya1lVRlpCWXVFK0pjUmorbFlE?=
 =?utf-8?B?RG1RSEV2bmk4NHc5RTk1diswcWxtdGpadjZrM3RhMlNISVVFQ2h5WkZ1OVdV?=
 =?utf-8?B?WkY4djZWNFhqYUVnWFlkRlp1ZU5mNnZZNERQYmVvUmVrWkRkNlBGVGQ5SzZr?=
 =?utf-8?B?cnFVSm9rS0ljbGx6ZzZDdGVzYlVqVis4NnRMRnkrSGN5eWN0UWhkMHhSS0lJ?=
 =?utf-8?B?QlZIRHB1TmcybFZnZnY0NmlpcVNiR0RMMGd4MDRKRFYvTXRwbnI1S2czY3Y4?=
 =?utf-8?B?QTByUGRxa1hFZmlHYUQ2L2tjUXRraEJkcThVb3BDMkNYdHkyMXBXOGNQN2RM?=
 =?utf-8?B?SWVjVG1MTGVhVWdFaDFpQVBUL0QzZG9sRUJvOWI2eS9XYTVIT3c2KzRjNGdU?=
 =?utf-8?B?ZW5lbWFjZG9JMVVXNFptY0Fnb2xKVlB2S2JRWWhkdStMMFo3WGVQYWVGM0h3?=
 =?utf-8?B?K09STFpHdGVKZ3FPNkZXaUE2N1ZNQlNDZ21KTEU0aXlGTStwQzAyWnNyQmd1?=
 =?utf-8?B?MmFaTHlOL1E5Z2lUNXBTWlhsczYzU2JwelhHN09IeGxVWnRVTGNZa3ZQTU9H?=
 =?utf-8?B?a1YrSEFaazI3NUNkT2w4S0xoQWc1andTRmx3dnIra0ptK3JwOFBRbHEvZzNG?=
 =?utf-8?B?Z1JrQmdhdmgxNHA2VmVsSUszK3dsejNyU20xTVFIRERUNWZZRkZ1TlJ4bHJ4?=
 =?utf-8?B?aHNUeGg5S3BqajN1R05tWm5CaHY2eXdxQnFOZXkvRi9GWENhRjRNR3BqdDZV?=
 =?utf-8?B?aU1Ob1lmVFNxY01pY2Y1MGNqSFVlcVVaWWkzZjB2THJGY1NaSms2OS9wblY0?=
 =?utf-8?B?bkd6ZGt1cWJjSGJYVjd1U0UxZ1lFTmZkQXhKWjJ1U0RCUTk3YStjOUlLOHFQ?=
 =?utf-8?B?OWNHby96ajQvUjZMb0s4ZlBaM1o5R3lxRzA4ZzRnNlUvSHpzZ3c5NThySFpU?=
 =?utf-8?B?U3VYbmNjQXJBRWJwSDFqMEUvQXpGN255S1NqUkloSjMwKzduK0NocGFXOTY3?=
 =?utf-8?B?NmRwY1RVY0E1SjFGZlNZNW9UVFhMdE1ocFQ0S1dLMHZ3NkhFYjVVZzZLbCtp?=
 =?utf-8?B?V0oxQjBnUGkyMWFncEl2Rno1QTM5N2l5Unl5MFdEK0dva0EySWxaM0xmUkhl?=
 =?utf-8?B?ZVVzR012bklFOU5ZNmNld3g3Q3BFZEo5dDJoVmJVN0NYR3IxcTZZcERSRWMy?=
 =?utf-8?B?TUlJemI2RmFlS09YdjBnRElzSXZ3azUzdHBzSFRaM3ZXQkU0bytQUFVuSDlB?=
 =?utf-8?B?SEg2bzFOaHYyZTBxa0c1b2F0TFh2L1hRN3VNMnZPYS9RTTV1RStUdjdnQWxL?=
 =?utf-8?B?QUVwZVYyVHpjK0U0eDkxZytaQncrL3dFRXV0VmlZdUlyaFRPS0VmTi9NR085?=
 =?utf-8?B?WGhDclJYaExZR1BNOVpEYlYyWjZrb3htMXoyb2M2UWxoa3pZK0xtdzVyalp6?=
 =?utf-8?B?djBJckpCWCtPSTBNR2tNWmRYUUhRTUJMdXRaWUpyQ1VkUmdrSUJaRWh2S0R0?=
 =?utf-8?B?RFpmVUlFN0QvakYvcFBUcEwwYjBqa1RRMFBuQkxhOFcySXR6dW9Wcm9DeHY2?=
 =?utf-8?B?UFQ4Sjd2Z3NES1pjSGZvdy92WEd2Ty9kOXJCMzFHb2RldHhJTUhvK0pLODRX?=
 =?utf-8?B?YWFMelRWZ3dsVTRvU2xxV1pkU0tqK0ljakl4MURBZEV3YW1FMFFHMEduL3Y5?=
 =?utf-8?B?TU9zdUtCdXpGRUlrZFFUWVZwdkpPUG4vdWZ1ZWhrd2lWM01Yd0tNakJDTDIv?=
 =?utf-8?B?Y29RczBtdGJHT3BtdzlkRnVlNXpzd0RPeHdwLys2L1VoRktLbnlnWkJyZXM5?=
 =?utf-8?B?b0M5OXFwYks2THg4ekdUdjV2QnpUTVhDYS94WjlJdFpDREdlWjY3ZS9veGVo?=
 =?utf-8?B?dWxFNXdja2pPWDVIUlpaR2dpbjYyald2VFJVdU9ocVBVdDJ0c2FybUdRdUhM?=
 =?utf-8?B?TWsyTXZpT2NGSGpabE81VlpoQ2M0MXJMN2xJQnZ6QitTenJtRy90ZUFPdWtQ?=
 =?utf-8?B?M1RBeFMxaWdzcXppZFJsS3NBYkJwSms5S0VjZEROZldaMkpBdnl0c3VENGI2?=
 =?utf-8?B?NmU3cWY4WEN6b2hjTjBuenBYVDlqTlBQbnZpQzA1VzUxZzA0aEhDZzBvYUdL?=
 =?utf-8?B?dDBoeVpiNFFhdGcyb045VE9CdXE3QVVUTGdid3kxNy9KeUlmSGJNTmM0UGds?=
 =?utf-8?Q?iYxUwo8NoCvwjGsFJOoFCBQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49C30AD1728CC5478219D2E364C0B904@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e6078616-3eb8-4b1b-298b-08de154d7bc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 11:39:26.5813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: viO6NpdxVhj5GrdqXA7XCndLshLvprZLASSYG6FtPD5gLnHu8YR5CkwMQEKMjP1yz2OS3kk0kTPXEael7s34bKAfiZ7lY8bRbIckEteAsaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6248

SGkgRGFuaWVsLA0KDQpPbiBTdW4sIDIwMjUtMTAtMjYgYXQgMjM6NDcgKzAwMDAsIERhbmllbCBH
b2xsZSB3cm90ZToNCj4gUmVhZCBib29sZWFuIERldmljZSBUcmVlIHByb3BlcnR5ICJtYXhsaW5l
YXIscm1paS1yZWZjbGstb3V0IiBhbmQgc3dpdGNoDQo+IHRoZSBSTUlJIHJlZmVyZW5jZSBjbG9j
ayB0byBiZSBhIGNsb2NrIG91dHB1dCByYXRoZXIgdGhhbiBhbiBpbnB1dCBpZiBpdA0KPiBpcyBz
ZXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgR29sbGUgPGRhbmllbEBtYWtyb3RvcGlh
Lm9yZz4NCg0KdGhhbmtzIGZvciB0aGUgcGF0Y2ghDQoNClJldmlld2VkLWJ5OiBBbGV4YW5kZXIg
U3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NClRlc3RlZC1ieTogQWxl
eGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCih3aXRo
IEdTVzE0NSkNCg0KPiAtLS0NCj4gwqBkcml2ZXJzL25ldC9kc2EvbGFudGlxL2xhbnRpcV9nc3dp
cF9jb21tb24uYyB8IDQgKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9kc2EvbGFudGlxL2xhbnRpcV9nc3dpcF9j
b21tb24uYyBiL2RyaXZlcnMvbmV0L2RzYS9sYW50aXEvbGFudGlxX2dzd2lwX2NvbW1vbi5jDQo+
IGluZGV4IDYwYTgzMDkzY2QxMC4uYmYzOGVjYzEzZjc2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L25ldC9kc2EvbGFudGlxL2xhbnRpcV9nc3dpcF9jb21tb24uYw0KPiArKysgYi9kcml2ZXJzL25l
dC9kc2EvbGFudGlxL2xhbnRpcV9nc3dpcF9jb21tb24uYw0KPiBAQCAtMTQ0Miw2ICsxNDQyLDEw
IEBAIHN0YXRpYyB2b2lkIGdzd2lwX3BoeWxpbmtfbWFjX2NvbmZpZyhzdHJ1Y3QgcGh5bGlua19j
b25maWcgKmNvbmZpZywNCj4gwqAJCXJldHVybjsNCj4gwqAJfQ0KPiDCoA0KPiArCWlmIChvZl9w
cm9wZXJ0eV9yZWFkX2Jvb2woZHAtPmRuLCAibWF4bGluZWFyLHJtaWktcmVmY2xrLW91dCIpICYm
DQo+ICsJwqDCoMKgICEobWlpY2ZnICYgR1NXSVBfTUlJX0NGR19NT0RFX1JHTUlJKSkNCj4gKwkJ
bWlpY2ZnIHw9IEdTV0lQX01JSV9DRkdfUk1JSV9DTEs7DQo+ICsNCg0KLS0gDQpBbGV4YW5kZXIg
U3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

