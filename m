Return-Path: <netdev+bounces-303575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L0ZWGk/rRGqU3AoAu9opvQ
	(envelope-from <netdev+bounces-303575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:26:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 547896EC20B
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:26:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=nnqjXG9r;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303575-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303575-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 379933089A82
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB25406825;
	Wed,  1 Jul 2026 10:13:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1623A3C4B72
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:12:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900781; cv=fail; b=d4yPZ4NzFEr3Na3GvP9ALGcOVxl1C4O8l+OCFI/ZYcvSJVYUXpTgqFDGExZ0fZP+WGIs5QKmoP+C+14tsX8WQwsBkOrqQHKrCxwwioqlqXPh2fsEMLu4yGvZGnEtCOoplXJS0+NT6Q6rZx46p9YBF40EP51Ip7I+id7R/56ypPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900781; c=relaxed/simple;
	bh=Y0h1d123tRMBpxZGegzOl/P+yTqJfbCcMUN+WqMbwig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L3WRy3TUYKw88iG6q9EKYoSH/ZQtDeZJt9g7MtVQolHiX6QfFPdiv1TMaxi8jcAGoRdxon/DbEs7UxEFVjQbFIeMSTYro8AHW/7F/ObwlVdysH/16Ub7Q8cNwp+XhFrxr7RwR4l/1mKgxX7pdWFqmD+ItjMYmU0Xl64k8Nxw28Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nnqjXG9r; arc=fail smtp.client-ip=52.101.72.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbWjJnVCFGcAB102qvikRU1idFV6G9k5QVmC6k65wO0HKVQnbxRUQxNEhdT2VPM4+H0ZfVbAbkFg1vzM5VMv5KTKgqFKcZTiojkKw4JpdlnbVeZpuXQj4lduFTSp3WPerfCBiUEyZIbYtN7L/+wRlaWvu1pB3gx2nmnhE672HYh0vUAT+wPXp8tmn3VBx4kmsx6YK3rtVS96LiDHq09u2fMlUT8veFK854a8XsJ2yIXqWBNGN8aYlyflGuQujUY0nAsnkv+rZlL25mvZzBfADmWTvohjPzZ55hwS7oZK0mdAhulbOhD+IM3lo1xmrN+8IBCARBUzxLi7sF/cnE3oOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0h1d123tRMBpxZGegzOl/P+yTqJfbCcMUN+WqMbwig=;
 b=tuF5Zktvc5ti8iAk53V/xzudmgYdbAwpp1UQZ1y+pYLltz8aRzLLKDHsn69FxIdNNlTRmi8EEqzUEqP/LXW+x1gFm6EziqFUxtx10bLcOAUW24Z/+Eilwe6BpEdC+t5TNtlUlQ+X/xySDT6p7l6ZsfEvvbIy2VldZcE/zze9Ocuz09Eo6d0NI5SbckcK/lUCJcxR9zVIFcgpLyj9MXd8E3evW6jFuj2XvV1hpma2usops5g4XX21gyE8Z1Ed54HJJIRW/ZoEiG7z0cI06+lurzNKBgSFRxoolJskUvQaIq1hnkL0qVadB56gV6ddMp52zWsTzysX+R8ElVdbJMbcZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0h1d123tRMBpxZGegzOl/P+yTqJfbCcMUN+WqMbwig=;
 b=nnqjXG9rpB2aCW5SHACM9eiGUoBCgoycCdUJA6tZlc31pM8pTDRcv0rs20K3IKFO4b5E4vBDRgM7+eDolCs43E90dHCMNApbbIM3kCZzXQLFtfE1eFu50ULAsmQr1RpQ61eebYTj3JxeZNiXsfTGq4MH4lzVLapDEC0SbIru9gFr+9bWKPayU0yuUFOm3sUF6p3b2fVaSO/Y9pjaSdDfCytxGTD6JEoxb8pZ/sgGloEhhHJOZJ6oZUDWl5vGAue7YSiYQP1itxcI0JY9P6CwsWcFXuyVvjKx/idKCOXqu/n1ZSa1srsA02s8a2aJX61hwRfFan2yJXccHcvVUYsWNw==
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6)
 by VE1PR04MB7247.eurprd04.prod.outlook.com (2603:10a6:800:1a2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:12:54 +0000
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47]) by DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47%6]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 10:12:54 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next 07/14] net: enetc: differentiate phylink
 capabilities for pseudo-MAC and standalone MAC
Thread-Topic: [PATCH net-next 07/14] net: enetc: differentiate phylink
 capabilities for pseudo-MAC and standalone MAC
Thread-Index: AQHdCGT09JFS8OPv8U+rOC+NGehpl7ZYTAAAgAAnj6A=
Date: Wed, 1 Jul 2026 10:12:54 +0000
Message-ID:
 <DU2PR04MB8629588C93ABE0E27C482D3688F62@DU2PR04MB8629.eurprd04.prod.outlook.com>
References: <20260630072036.382761-1-wei.fang@oss.nxp.com>
 <20260630072036.382761-8-wei.fang@oss.nxp.com>
 <20260701075116.900D81F00A3A@smtp.kernel.org>
In-Reply-To: <20260701075116.900D81F00A3A@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8629:EE_|VE1PR04MB7247:EE_
x-ms-office365-filtering-correlation-id: f2d2cb5a-196c-4c28-2e4c-08ded75950f5
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|1800799024|38070700021|6133799003|11063799006|18002099003|22082099003|5023799004|56012099006|4143699003;
x-microsoft-antispam-message-info:
 +VdikgsAPvddv1DNIltwHnsY8KU8ODDWF9pzOL6zG1w3gN9AFpJObiO/I2knljOdNU7CkgqQvTGkbS8UliwZp1r1RcxpD//DScdWfMDb5/VMvvwarPbs8TZgaLBKESaIabtqmf6rspfLjtIifu4w2CCvOkvIvezfh8M49eIwu4gRxAQbcGNkyOrElxem24pV4JY8JywwQTQF0aFj4imDVc5jxRRYtoX4C5MhptM26AO+aIU/QwiyfYBVxK5yYPVNCIXbUmqt/vEIEMEQt/TBcWky+sW1lX5KRIu0QzgEYAd2zl0iwTO9N6pl9hzivjIdjUDH5xZ78xmsWu6VdgLYexAXbCZlXmYbbju8d2NeHBmKe85v0129h3986iVZ7e0eTYzrXvG+8opBlce6Hq2ELoYZzIngRQ6FnTYWJTJgu+GGA0gAEnBKLnhgZnl2UwawP1gW+bOF5rA582ch6NTNvTqyuIuvgreogVFuYY8wm3OCySDFzXFswSZL9duKty/6/14re4qVjoWChVBhXdYrgAYLKjEePFx51Zqq5pO7qzq6ebhd9meBTCKJAFxsbNQ96x0dXladCZozMYu3eSKXv9LPNG8Z8DwYWLnbZbSl3bBmmRIYEclB9yAwCmsz6gfsRhC3fS/EOFI6RZC9OBcMozlz5+6HnyHdkS56mGWl9QWPYzuZ7DE8nNyVEz4ME9bYsOS4Ju742FgldOLFw9pn8BckvHMhHklWIOa1RtbPVto=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8629.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(1800799024)(38070700021)(6133799003)(11063799006)(18002099003)(22082099003)(5023799004)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RXlOSTYxckwvN25HeHdpYWlqQUZvQUlPdEpsVEZNTWp5eCtDZ3RYTUNQbkxH?=
 =?utf-8?B?dkNBbXJXY000Q1g3cm91c2pWMHd4WmViTHAwSnhGTExWSkpQRm9lM0JOMEZq?=
 =?utf-8?B?UnI0alRkUUNlRUtFSkRDWng1eGJ4UGg0K203TkJVb25TMzFHa0tzbE5RTGox?=
 =?utf-8?B?Y0hqVWFFa0xsamozRGQyWndCMm1vWk5VL2EyYS93VHpMY2JhYzFURUJmbDB2?=
 =?utf-8?B?VzhSZ2dJTnNlTXVIVlJxTEEzS2hWcis3YkJtbkVCVldDZmViNXlMVEU0Nnd2?=
 =?utf-8?B?bEdhTTgrdHBJSlY2ZkMxVGc3a1g4VkxXNDBlZVFEckN1MGhpaUVJRkNkV1ZO?=
 =?utf-8?B?ZUtXbmVGakZXaEJPUnZsbUJRbFVTVkM2SGdvRGw0ZGw0YUFjRFZPMzhFK2F1?=
 =?utf-8?B?d3puQWY2cVdmYndlc2RrWjVMR0J4cjgycWJqQzdlM3k3MzY0ZVNkemFqblBi?=
 =?utf-8?B?dWRrb3E3M1drUEkyNjUrdzBIYlRpTmpUVXJYbVdIekdHdHg1cHFBektod0wx?=
 =?utf-8?B?QkthVEM2MTROZTF2OUwrVFp6TDI4czBYQTJTR2dmRitPaVFET0hmSlg0V21P?=
 =?utf-8?B?KzAvaXZ4VnJvNXQ5NUEvYVlnQ29JT1hkZm1jQ2hReHZEUzhWdVVxdzVQcVhu?=
 =?utf-8?B?VGI0eGttSDlJSSszYVFkZ0lONndybms2RFB6WjZGM3JkaWRKWW43OFgzTXJT?=
 =?utf-8?B?TTRzTEpnb0x3NnUzenpoUS93NkNxcVltQ0NLKzBZSUdzTVRrQUdqRE95Wm1w?=
 =?utf-8?B?L1liQWlPUnZVU2NzNk1PZVZ0dysyc0d3a1Z5d0x2UDVaWWZFMU9TQW1KZ3Aw?=
 =?utf-8?B?RTZYZ2JoYXZHeFp3RlI1bXBpc3hrZlNrcjdIQm9VM0ZKOC9vdWJ2ZXA2cFhl?=
 =?utf-8?B?R0pOSGtGOVIzeGFraFFzSHh0WWRtdlljWTFHR3V5SzZrZDBYdy81ekljNkpU?=
 =?utf-8?B?aFh6V1MyWXc2VVJUeWxoVGV3U1FXeDdoY3RoQ3ZGSjIzZ0RqeUZvbUk0czNX?=
 =?utf-8?B?N1AxbEFqU3YxL3hQUmNjYlNxK3QxNTB4R2RxNmFyVVdHZ0FjUnVPN1I1S3Rp?=
 =?utf-8?B?RGhPQ0ZwUGpJUXI2NkFWN3dtUHRJRVJJY3E5ZjQrUjdIcUpuaEZ1a3NubnFL?=
 =?utf-8?B?R2EvTU9PQk1IdnlQTGppNHdINWRGOGdlYmNlZWc5VmNRVnA1c001aXhvMmtu?=
 =?utf-8?B?WTdEOXIxZTZjdE5ITWMvVERGM3FwWnBYaEtLQU5haVhDL1dtSVdPQW5sTnlh?=
 =?utf-8?B?TUhrZjBPaCtCZkxUUzMxcjQ5M29LMkNYbWtJaXNwZjVXRWFWQWx5eUpWYnV4?=
 =?utf-8?B?QU1VT2w0ZUZ0VkhpSng3QVdyYXRQeGU3a0pjM1h1RWNBaTdkeFp2QzY2ZGVk?=
 =?utf-8?B?TUszd2Q3bEUyLzd2aFVCNG9QRE9jRmpUa0xRZUxmQ1lmdFk4ZHNmT0FqOFIz?=
 =?utf-8?B?dllHUjU3NEFZVVlrcFNINlV5dVFmWFc3ZGdCalpuOTV4Q2F1YW9EVk9QUzF5?=
 =?utf-8?B?aThNZlhCYjBnWkZvK1FhMFo5K1YxUElHWVMxNnJyZytJQW5vU3M5K0F4cUw4?=
 =?utf-8?B?QVgrY0FYUEQybVZIYzlocEJBMnRkZlAzSjZ4eERMeGZ5RUZVTnkxeTFKRkgy?=
 =?utf-8?B?NEF4eHNVbWdaaHN3TGVmalphSzFSOCtSOHpYR0JhWUFvb0ZiK09VWHFqUlNo?=
 =?utf-8?B?c3BIVm05TXZsZXdCMzdlbG05cTU3UzBvczlqKzJiZjljTlRJR2ZYSDdFc1Yr?=
 =?utf-8?B?c1lvWkJpaTkyYWY4ZVZ5WmttWWVYUTF2VTlya1gxbFE1UVdFYmhpV3dZbWZJ?=
 =?utf-8?B?K3kyOU1EYjFpRFRET0UwOGJXSFFKL0VZWHkxcEdhbDJ5aHN3NEc1RU1qMHUr?=
 =?utf-8?B?c2hqd0ZtMS9mQlhNRmxGZW5CSGVENjY1dkhvRS9qVWt2QnJ5OG9yZVcrTHp0?=
 =?utf-8?B?b0NsN0paWFZQTzd5T3ExSzF2U3hOVmtwR0RaeFkySGF0YTlvcDl4dDZtOGFS?=
 =?utf-8?B?RWF5a1k4ZzM1Nzloc2VWNkVHMkZieE5PUXJmV2NvNkk1b3ZLZ3haSzNPOFMz?=
 =?utf-8?B?VUdkS3M2ZWpPSFl5dU9wbXZERThzRW5BR29NZSsydzc0c1B1MGNoMVhyTkND?=
 =?utf-8?B?RnA3bjZXeWVkOGUzeFpBWUdaUUllM3VzMzBFanFTYktnSm1iemdMYVpnMlJF?=
 =?utf-8?B?R004UjNXRWcwVEJ6QmpuSExlS29YM3JCZHFsa2hncWRZMlcvTWZsZmxCeDlr?=
 =?utf-8?B?WWV2aG41L0xDdmxCK0U4WkRsK3NjRSs5b2NMMVE4VEEvYSs2T1dBYXBDM3Y1?=
 =?utf-8?Q?szd8StdiefvslP0CxO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8629.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d2cb5a-196c-4c28-2e4c-08ded75950f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 10:12:54.3070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mU/3ynm3K5YPgL/omxrB+pkjUFsbEaCmmuzDa81H4mQV6SKB8dggkaZdKe10XWY99Z5p41/g3Kn9xRx/TgcmsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7247
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303575-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,nxp.com:email,linux.dev:email,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 547896EC20B

DQoNCkJlc3QgUmVnYXJkcywNCldlaSBGYW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogc2FzaGlrby1ib3RAa2VybmVsLm9yZyA8c2FzaGlrby1ib3RAa2VybmVsLm9y
Zz4NCj4gU2VudDogMjAyNuW5tDfmnIgx5pelIDE1OjUxDQo+IFRvOiBXZWkgRmFuZyAoT1NTKSA8
d2VpLmZhbmdAb3NzLm54cC5jb20+DQo+IENjOiBpbXhAbGlzdHMubGludXguZGV2OyBGcmFuay5M
aUBrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgMDcvMTRdIG5ldDog
ZW5ldGM6IGRpZmZlcmVudGlhdGUgcGh5bGluayBjYXBhYmlsaXRpZXMNCj4gZm9yIHBzZXVkby1N
QUMgYW5kIHN0YW5kYWxvbmUgTUFDDQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0
aW9uISBTYXNoaWtvIEFJIHJldmlldyBmb3VuZCAxIHBvdGVudGlhbCBpc3N1ZShzKSB0bw0KPiBj
b25zaWRlcjoNCj4gLSBbSGlnaF0gSW5jb3JyZWN0IHVuY29uZGl0aW9uYWwgYWR2ZXJ0aXNlbWVu
dCBvZiA1Ry8xMEcgTUFDIGNhcGFiaWxpdGllcyBhbmQNCj4gMTBHQkFTRVIvWEdNSUkgaW50ZXJm
YWNlIG1vZGVzIGZvciBvbGRlciBFTkVUQyB2MSBoYXJkd2FyZS4NCj4gLS0NCj4gDQo+IGNvbW1p
dCBhZmI5ZjFiNjA3YzcwZDNhNmE4NTRlMTVhYWEwMzRmOTlmYjQ5ZjVjDQo+IEF1dGhvcjogQ2xh
dWRpdSBNYW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+DQo+IA0KPiBuZXQ6IGVuZXRjOiBk
aWZmZXJlbnRpYXRlIHBoeWxpbmsgY2FwYWJpbGl0aWVzIGZvciBwc2V1ZG8tTUFDIGFuZCBzdGFu
ZGFsb25lDQo+IE1BQw0KPiANCj4gVGhlIEVORVRDIHBzZXVkby1NQUNzIGFyZSBwcm9wcmlldGFy
eSBpbnRlcm5hbCBsaW5rcyB0aGF0IGRvIG5vdCBpbXBsZW1lbnQNCj4gYW55IHN0YW5kYXJkIE1J
SSBpbnRlcmZhY2UsIHNvIHJlc3RyaWN0IHRoZWlyIHN1cHBvcnRlZCBQSFkgaW50ZXJmYWNlIG1v
ZGVzDQo+IHRvIFBIWV9JTlRFUkZBQ0VfTU9ERV9JTlRFUk5BTCBvbmx5LiBUaGlzIGFsc28gZXhw
YW5kcyB0aGUgc3VwcG9ydGVkDQo+IGludGVyZmFjZSBtb2RlcyBhbmQgTUFDIGNhcGFiaWxpdGll
cyBmb3Igc3RhbmRhbG9uZSBFTkVUQy4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Y19wZl9jb21tb24uYw0KPiBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Y19wZl9jb21tb24uYw0KPiA+IGluZGV4
IDM1OTdjYjgxYTdjY2IuLmFkZjc5YTk5YThjODEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjX3BmX2NvbW1vbi5jDQo+ID4gKysrIGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjX3BmX2NvbW1vbi5jDQo+
IA0KPiBbIC4uLiBdDQo+IA0KPiA+IEBAIC00MDAsMjUgKzQwMCw0MCBAQCBpbnQgZW5ldGNfcGh5
bGlua19jcmVhdGUoc3RydWN0IGVuZXRjX25kZXZfcHJpdg0KPiAqcHJpdiwgc3RydWN0IGRldmlj
ZV9ub2RlICpub2RlLA0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgZW5ldGNfcGYgKnBmID0gZW5ldGNf
c2lfcHJpdihwcml2LT5zaSk7DQo+ID4gIAlzdHJ1Y3QgcGh5bGluayAqcGh5bGluazsNCj4gPiAr
CXVuc2lnbmVkIGxvbmcgbWFjX2NhcHM7DQo+ID4gIAlpbnQgZXJyOw0KPiA+DQo+ID4gIAlwZi0+
cGh5bGlua19jb25maWcuZGV2ID0gJnByaXYtPm5kZXYtPmRldjsNCj4gPiAgCXBmLT5waHlsaW5r
X2NvbmZpZy50eXBlID0gUEhZTElOS19ORVRERVY7DQo+ID4gLQlwZi0+cGh5bGlua19jb25maWcu
bWFjX2NhcGFiaWxpdGllcyA9IE1BQ19BU1lNX1BBVVNFIHwNCj4gTUFDX1NZTV9QQVVTRSB8DQo+
ID4gLQkJTUFDXzEwIHwgTUFDXzEwMCB8IE1BQ18xMDAwIHwgTUFDXzI1MDBGRDsNCj4gPg0KPiA+
ICAJX19zZXRfYml0KFBIWV9JTlRFUkZBQ0VfTU9ERV9JTlRFUk5BTCwNCj4gPiAgCQkgIHBmLT5w
aHlsaW5rX2NvbmZpZy5zdXBwb3J0ZWRfaW50ZXJmYWNlcyk7DQo+ID4gLQlfX3NldF9iaXQoUEhZ
X0lOVEVSRkFDRV9NT0RFX1NHTUlJLA0KPiA+IC0JCSAgcGYtPnBoeWxpbmtfY29uZmlnLnN1cHBv
cnRlZF9pbnRlcmZhY2VzKTsNCj4gPiAtCV9fc2V0X2JpdChQSFlfSU5URVJGQUNFX01PREVfMTAw
MEJBU0VYLA0KPiA+IC0JCSAgcGYtPnBoeWxpbmtfY29uZmlnLnN1cHBvcnRlZF9pbnRlcmZhY2Vz
KTsNCj4gPiAtCV9fc2V0X2JpdChQSFlfSU5URVJGQUNFX01PREVfMjUwMEJBU0VYLA0KPiA+IC0J
CSAgcGYtPnBoeWxpbmtfY29uZmlnLnN1cHBvcnRlZF9pbnRlcmZhY2VzKTsNCj4gPiAtCV9fc2V0
X2JpdChQSFlfSU5URVJGQUNFX01PREVfVVNYR01JSSwNCj4gPiAtCQkgIHBmLT5waHlsaW5rX2Nv
bmZpZy5zdXBwb3J0ZWRfaW50ZXJmYWNlcyk7DQo+ID4gLQlwaHlfaW50ZXJmYWNlX3NldF9yZ21p
aShwZi0+cGh5bGlua19jb25maWcuc3VwcG9ydGVkX2ludGVyZmFjZXMpOw0KPiA+DQo+ID4gKwlt
YWNfY2FwcyA9IE1BQ19BU1lNX1BBVVNFIHwgTUFDX1NZTV9QQVVTRTsNCj4gPiArCWlmICghZW5l
dGNfaXNfcHNldWRvX21hYyhwcml2LT5zaSkpIHsNCj4gPiArCQltYWNfY2FwcyB8PSBNQUNfMTAg
fCBNQUNfMTAwIHwgTUFDXzEwMDBGRCB8IE1BQ18yNTAwRkQgfA0KPiA+ICsJCQkgICAgTUFDXzUw
MDBGRCB8IE1BQ18xMDAwMEZEOw0KPiA+ICsNCj4gPiArCQlfX3NldF9iaXQoUEhZX0lOVEVSRkFD
RV9NT0RFX1NHTUlJLA0KPiA+ICsJCQkgIHBmLT5waHlsaW5rX2NvbmZpZy5zdXBwb3J0ZWRfaW50
ZXJmYWNlcyk7DQo+ID4gKwkJX19zZXRfYml0KFBIWV9JTlRFUkZBQ0VfTU9ERV8xMDAwQkFTRVgs
DQo+ID4gKwkJCSAgcGYtPnBoeWxpbmtfY29uZmlnLnN1cHBvcnRlZF9pbnRlcmZhY2VzKTsNCj4g
PiArCQlfX3NldF9iaXQoUEhZX0lOVEVSRkFDRV9NT0RFXzI1MDBCQVNFWCwNCj4gPiArCQkJICBw
Zi0+cGh5bGlua19jb25maWcuc3VwcG9ydGVkX2ludGVyZmFjZXMpOw0KPiA+ICsJCV9fc2V0X2Jp
dChQSFlfSU5URVJGQUNFX01PREVfVVNYR01JSSwNCj4gPiArCQkJICBwZi0+cGh5bGlua19jb25m
aWcuc3VwcG9ydGVkX2ludGVyZmFjZXMpOw0KPiA+ICsJCV9fc2V0X2JpdChQSFlfSU5URVJGQUNF
X01PREVfMTBHQkFTRVIsDQo+ID4gKwkJCSAgcGYtPnBoeWxpbmtfY29uZmlnLnN1cHBvcnRlZF9p
bnRlcmZhY2VzKTsNCj4gPiArCQlfX3NldF9iaXQoUEhZX0lOVEVSRkFDRV9NT0RFX1hHTUlJLA0K
PiA+ICsJCQkgIHBmLT5waHlsaW5rX2NvbmZpZy5zdXBwb3J0ZWRfaW50ZXJmYWNlcyk7DQo+IA0K
PiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IFdpbGwgdGhpcyB1bmNvbmRpdGlvbmFsbHkgZW5hYmxlIDVH
IGFuZCAxMEcgc3BlZWRzIGZvciBvbGRlciBFTkVUQyB2MQ0KPiBoYXJkd2FyZT8NCj4gDQo+IElm
IGEgMTBHIGNhcGFibGUgUEhZIGlzIGF0dGFjaGVkIHZpYSBVU1hHTUlJIHRvIGFuIEVORVRDIHYx
IHBvcnQsIGl0IGFwcGVhcnMNCj4gdGhlIGxpbmsgd2lsbCBuZWdvdGlhdGUgYXQgMTBHYnBzIGlu
c3RlYWQgb2YgYmVpbmcgY2FwcGVkIGF0IDIuNUdicHMuDQo+IA0KPiBJZiB0aGF0IGhhcHBlbnMs
IGVuZXRjX3NjaGVkX3NwZWVkX3NldCgpIGRvZXNuJ3Qgc2VlbSB0byBoYW5kbGUgU1BFRURfNTAw
MA0KPiBvcg0KPiBTUEVFRF8xMDAwMDoNCj4gDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVz
Y2FsZS9lbmV0Yy9lbmV0Y19xb3MuYzplbmV0Y19zY2hlZF9zcGVlZF9zZXQoKSB7DQo+IAkuLi4N
Cj4gCXN3aXRjaCAoc3BlZWQpIHsNCj4gCWNhc2UgU1BFRURfMTAwMDoNCj4gCQlwc3BlZWQgPSBF
TkVUQ19QTVJfUFNQRUVEXzEwMDBNOw0KPiAJCWJyZWFrOw0KPiAJY2FzZSBTUEVFRF8yNTAwOg0K
PiAJCXBzcGVlZCA9IEVORVRDX1BNUl9QU1BFRURfMjUwME07DQo+IAkJYnJlYWs7DQo+IAljYXNl
IFNQRUVEXzEwMDoNCj4gCQlwc3BlZWQgPSBFTkVUQ19QTVJfUFNQRUVEXzEwME07DQo+IAkJYnJl
YWs7DQo+IAljYXNlIFNQRUVEXzEwOg0KPiAJZGVmYXVsdDoNCj4gCQlwc3BlZWQgPSBFTkVUQ19Q
TVJfUFNQRUVEXzEwTTsNCj4gCX0NCj4gCS4uLg0KPiB9DQo+IA0KPiBUaGlzIHdvdWxkIGNhdXNl
IGl0IHRvIGZhbGwgdGhyb3VnaCB0byAxMCBNYnBzIGFuZCBicmVhayBRb1Mgc2NoZWR1bGluZy4N
Cj4gDQo+IEFkZGl0aW9uYWxseSwgZW5ldGNfbWFjX2NvbmZpZygpIGRvZXNuJ3QgYXBwZWFyIHRv
IGhhdmUgc3VwcG9ydCBmb3INCj4gY29uZmlndXJpbmcgdGhlIGhhcmR3YXJlIGZvciBQSFlfSU5U
RVJGQUNFX01PREVfMTBHQkFTRVIgb3INCj4gUEhZX0lOVEVSRkFDRV9NT0RFX1hHTUlJIHdoaWNo
IGFyZSBub3cgYmVpbmcgYWR2ZXJ0aXNlZC4NCj4gDQo+IFNob3VsZCB0aGVzZSBuZXcgY2FwYWJp
bGl0aWVzIGJlIHJlc3RyaWN0ZWQgdG8gbmV3ZXIgaGFyZHdhcmUgcmV2aXNpb25zPw0KPiANCg0K
SSB3aWxsIHJlbW92ZSBYR01JSSBhbmQgMTBHQkFTRVIgbW9kZXMgaW5jbHVkaW5nIHRoZSAxMEcg
YW5kIDVHIHNwZWVkcw0KYXMgdGhleSBhcmUgbm90IHN1cHBvcnRlZCB5ZXQgaW4gdXBzdHJlYW0u
DQoNCg==

