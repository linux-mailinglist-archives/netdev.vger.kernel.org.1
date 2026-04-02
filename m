Return-Path: <netdev+bounces-274507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJSIDu1azmmgnAYAu9opvQ
	(envelope-from <netdev+bounces-274507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:02:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7755B388BBA
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ADDC23058BE5
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395983DE42F;
	Thu,  2 Apr 2026 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e+4QM8iY"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013013.outbound.protection.outlook.com [40.93.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DFE3C5DC1;
	Thu,  2 Apr 2026 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775130704; cv=fail; b=q/Hb6VUy9I0D4KecYXrEO7Sd3CIGniVRxtTkOZvx7cPQgzE148+UTcebonUHBOjjoP7yKdNZJ9ac8I2yTj7xRKQHu66P8iUGk9xPNLomGQoKmiD4bzPhEOuHjVecBXcftDvxT+KpyB/haFGjEQram7ULVRlIqgGvym7BdbaGSAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775130704; c=relaxed/simple;
	bh=kHS+Einh9nfA6XLzxsNqumCEZxWewvIXThOcH3O3+tY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kkxzrxeMdA1XRK3ZWWRNWG2Kv+C4t58Mva+GixQ1eQ9sNQELR+m6FiM9Fw7u82g4GuIqOWCFijshcR4hhIqu7JOvsoa+r7UKTbSw4fU9vHSHMU18nKoP38O6hKuDdZ91YddQmReta6J1z0ESIuEXKg6MeOTGvEW57aLulAwBBF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e+4QM8iY; arc=fail smtp.client-ip=40.93.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/Jb+yf6iHpRQIyev8H/NHASBgozl0BW21wYZbCfqHZ+8hBPmeTDWjF62IdjgXPf4KCtGva0LBDT6NeLQXRatrvS129eqiW72mM00ZsvbNtYOyvfcTQ6zgJR3nbflFY73R7QCG8c7jFrEYkaS8GsWzYCxeiItgj7CDZmye1CaHqWRS3bPFDUHH7jTvQwmW350eh/+aYEYCgRv6X2O9vmRXPzkUjmFZbIS+wiV+AY8svyw2dnGwQe46eCIEwxlzoTSfbFfJRB4GrLAuHqb2jbwMWoGwq0SvnzMs1oUiOxEodGfXDuLyRzeYEybh6+5gfHLp1nVrMmnaq528avEB32UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHS+Einh9nfA6XLzxsNqumCEZxWewvIXThOcH3O3+tY=;
 b=RNA5fjdAmREdbcplZj5aHhvGnrq7NRY+nKfujBw4jR2ktej8DIiRI8qzbklPaSFfzd7UuK04bYYVKCIbIGvqh2e6ZAL/Pa2D1Amv1Bj3og7+XHm4iAEwNgZxJjY8hKvaNqZntTcDGGDb5w8uZStamctSavYSWWSytFImAF+ZGi7YjU1jwstwpmiahzowgmkbsuom/I5Ytfqyx1t4d+3iu6+Mq1tTfpNd8gBmtBzhxvq/qBMDxFMxnFzBLL1i3We6mxfSR3FKU+0Oy7qFgs/QCkERsKqbYM/MZNNHA5wH0njdIbwafrEeTDlKzHStPsZDXb5jiqga2D9KTdq8eKSR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHS+Einh9nfA6XLzxsNqumCEZxWewvIXThOcH3O3+tY=;
 b=e+4QM8iYVzO+WzGBTHqg60wbdtFw+7nHvjl5NeLEP8qezM6dZ4Ne1EF0VAGDjnKkRXwSg4bGl+gkxu2Fukt1JhDgpqEbn2f/0OhcCod/zDQT2TvHN1HUKcrNDLkMZMncVZ1ZRBhselgrtiJ6RRTuNviiD00HeAk5QRrBGj3AMmP2jZjow1J0tv3qFjSApy0nAafT9XIvlPts2jqeJJI6PdRWfmz+XB2rFNHxTYthQYLEQm2DRd9DrgNhg0l48ppEkH2ngGKxZOWjXhXt3zZGite04Any0n3AxrUehQQg1MO05seqMuO0gE4a86XP1AMfz9OWbe1wUO7ygbLhVY6H5g==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by PH0PR12MB7839.namprd12.prod.outlook.com
 (2603:10b6:510:286::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 11:51:25 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d8b5:cf72:3e36:3701]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d8b5:cf72:3e36:3701%7]) with mapi id 15.20.9769.006; Thu, 2 Apr 2026
 11:51:25 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "sd@queasysnail.net" <sd@queasysnail.net>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "shuah@kernel.org" <shuah@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net v6 1/4] selftests: Migrate nsim-only MACsec tests to
 Python
Thread-Topic: [PATCH net v6 1/4] selftests: Migrate nsim-only MACsec tests to
 Python
Thread-Index: AQHcwEV2vJfmhgI0L0CjBSQg9dkb/rXLj2yAgAAeGAA=
Date: Thu, 2 Apr 2026 11:51:25 +0000
Message-ID: <74bb0511be30cbc552b1addd0c65cf1f699b26ea.camel@nvidia.com>
References: <20260330130130.989236-1-cratiu@nvidia.com>
	 <20260330130130.989236-2-cratiu@nvidia.com> <ac4-_ZPJSlXV4Vmd@krikkit>
In-Reply-To: <ac4-_ZPJSlXV4Vmd@krikkit>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|PH0PR12MB7839:EE_
x-ms-office365-filtering-correlation-id: 4e99755a-c160-441a-6f99-08de90ae2aee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 HABb/QVGSbuWlN72KJ1Mzk/jQIDUEoI0Kdk0BROoNvCzNi2p/kx+vFeaRCHIfM02cskJdX2cb5yw1Yr3ebshncLy0liJG1EKjXNKMTYR2F2jYza011xTUdkCfPe7T3KarT/jcy/O2lg/sYnCJRA5gP0KV5JkU0QV6npVaQb30seh0Xxp4/OL92OIWDIqd7z2IpoeIo+Nxa/Z785UF4rsixmi764kaSjNL3LeGqvGMKb07wIM0CEcbWLqxCGWTTthqKO7pF8EPE4hlu5USaytPtngzXhYxoVp5CbawW4cyYPM9MpHs3c2bn//oDWpR8f0BVWBkJ2XuAmgO7XjnYmzhsw0aj3I52jpZdy53ZIi0oLHV6YS5uQGR5ELVCLoeywAD5nBUY9A1f3RAQ6aB9NjwUQ4oan2ISY8HZcbMICWcN/xGWKzE60p7Bm3CGUz+qRa2//uPL6NchFx0Pd91iSEtWiCpru0UdGgB3kvb4K6AxgHgByzEncxxYxkYmRL4rlTiJFJGR04i7iElD7576JWDO4POYFf5ehZRlCDPRBrkj9sZCkOjXIYQmH2PVu8tRfvGsW0OYhY2BzGLWE4iAtfcc3FwYKm0miCS2x03A4mzLxOjIHuO18cRLEqjFt0YKrZcaayDEi/fDFRA4waIJPDxr2tiDbk6Nxvg9A4vOKu9OkN1N7A3WBMh/+jG5GhppXz/V7D8kJXHJRnv4My6Tzpwe3QM+2SH7Fnp2z+yMVEGQtHsxylQ+naVS/bctYcl2ip3DX6n0EYBBMtFGL/0IyuQd+a8FalEKYFjAyknL4a/tQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHJ5MzBUZjlHdmdkYUpnUG03dWtvVzlXb21yOWNZTkx5UiszYTdGbjg5dUlq?=
 =?utf-8?B?cDJGbWhVQTN1OVI4N0c2M21zVlp5b3ROZy9KK3Z1QkpaaklGRTFScVdGVFp2?=
 =?utf-8?B?c0JSK3FPdnNEZzNqTnM2WC9Rc0dkNHBYWnhUNHdtRE4vbmhndWlKQk93VE0r?=
 =?utf-8?B?dWVzOE5RdlZzYXVwcGZoRkU0YmU1aGpEYStmQXU5NkphRW1HWlZzZW9GdjBu?=
 =?utf-8?B?ZFdFSjZZU0JkTEhyVnMwM0wrWDltR3VlTjJ2bm82MTJtdW00aks4aGt5R0w4?=
 =?utf-8?B?dmcvVFpJSzE5YUsvUHU3d1BUOU9SVENtRzQyVGVWK3ZYRTViMjc0MDZPRDh5?=
 =?utf-8?B?V2dhYzZVSkY1NFFVMHJyZHZTcmhMeUp6Y3pmcS80bkxpaWNZUFVCSW93bHd0?=
 =?utf-8?B?VkZQT254cTVSZkZvMTN2cjN5cjhoOEVTckZKTlpMSHFGelBrNzh1eE5tVkhB?=
 =?utf-8?B?cCtUK3N0Q0pQZGZ6Y0xabzFic3dzUEQrQmoyVGt4WGZBcDJNVmJ1czlIWHVH?=
 =?utf-8?B?bFRhbVc5SXdrYVcrZzhpSXBlaWhhZzRRWHBtQlJwcWc3TFhWdEV4ZzdXTlFJ?=
 =?utf-8?B?aXZRYjlYVUcwQlV3UnQxbnUyakFRM01qY2xMdGFPYnlPeWVJZ2xWMXEzcnk3?=
 =?utf-8?B?cGF0SDgvaytZeFI2QjBla251QnVNbjMzY0NHM1VyR1RZVFVwL3lmZlpSVFVZ?=
 =?utf-8?B?RjNkdTA2TFd1bzZyVGNOcG5ra2w5SlpQR0Y2OUtYZ1loVVdETGNLOGFYREVC?=
 =?utf-8?B?Rk4waTEvYlN2ZmkwYnRmLzBkSVdLWEZycGsvRTN0cVhmVVhnWUJpOUVwY2dk?=
 =?utf-8?B?OVhQNE5EUTVCUGJNaTZMTXpkZ2ZMWS80ZTdmN21LWWpoMkh3MS9pNXIrR1Fy?=
 =?utf-8?B?QlEvWGZ4VVBtd2R1cFBabWdWeXVBa2RlaGFuL0lzazlwOHI4bVZMRU4zd3gv?=
 =?utf-8?B?VTVKUlhrbW03M09uMC8vYUNQbENWRVJVSUFUSExTb2J1NFA5ZmllNTJMS2pG?=
 =?utf-8?B?ejU5RXNwZERqT0VrVTlLcWI5VjBpdUlIT3Z0bzVXK00zUEVqVWNraVJwQllp?=
 =?utf-8?B?SkxoVk45aE5HNk9GTFlGMGx0N3Y4cmNCY3ZDZmZaNU5tdEtNMERpTS9RRVRM?=
 =?utf-8?B?MGhXeEhDUmFHT0dNUmF5bTNMM1ZxYWJLZGFqRGxGWUJLbHg0WEJyZUNLV21y?=
 =?utf-8?B?Vk5jZ3pCRDc5UjU4cVJENDRMOEhjOTZVTno2L0ZOVEJtYWJLVDVjRXFWeXhY?=
 =?utf-8?B?c0gyYTI3Z2JTSGRVYkhWWFZPa0t4ZU1rV2U5NmlzZ3VxUzg0eExDMHh3L29L?=
 =?utf-8?B?WFU0ZUFvek9BUHhEbU9RVUFwWExISVdnaWxkcHNoTHMwcDJpTk5RQlBNNXNu?=
 =?utf-8?B?aHpRWVRZRXhQMUdPbE9HN0xkWEdmZWVHY0srZmNZSE5YLzF0Ukh1VkNoWWZy?=
 =?utf-8?B?MWNWdGhKMjRZTGNwaWpHYzR3ai9NR0UvWGJVNjNUZzZWbFFXcGFnSkF1SlJj?=
 =?utf-8?B?TzdibEJkejlTOFcrMldKOW5FR1JrS3NvTGdlSWxBY21oQnFPVzZiMWNvQTd1?=
 =?utf-8?B?clNIZDNIWFpNUm9BaHcwVVYvUWxrVzE4VmlBVTFORFRzeHg5MCtXZ1BPRzNu?=
 =?utf-8?B?WnF4cUt5ZEFqM1hFZTc4TnNmNnM2MXhUOHZyc3E4dUpoVUVxYTZZeHNYekN6?=
 =?utf-8?B?NXJuMHYyR3hrVVFvbk9VdndUaU1OdGM4NG9GOEZacEpOWlVlRGVOdzhjQlFw?=
 =?utf-8?B?cDZkUHVzNmREMWxVT1Q5SEZxNnM3eTBKOTJXYUtxQ0MxaFB0N1BCNlp1VzJU?=
 =?utf-8?B?a3lKUlZMOGpXLzVyL2RzeWJMYW9VZnpvdVNsak9vM3N1MXR4OFhBTm5mNlFo?=
 =?utf-8?B?aWlWQ1JBNWFlSDQrb2xuVTRNcTFOM20rb2JrSHdJdVZiSkdaMUpwMnJhZDRQ?=
 =?utf-8?B?UHNFR21aZTYzZzdRRnZ4TTVwQTdDMG9oaWpSMDNuS3IyT3lpRjEydnFYMnps?=
 =?utf-8?B?ay8yMzJDMERpQ044SmxoRExTNFhTWGNCT3k1RDRWZHNaU01JS3JsZmJ5MUxM?=
 =?utf-8?B?QnIyT0xpWktoRFlXU2lWaythUjVuSFlEYTJxZ2NiaFlmZVdqMFJkN1ZSYW1N?=
 =?utf-8?B?MXEzR0x2NWJYVE9nWURkV1JPYWhEeVdMYlg2VW4zQmVHYjNSamlZa0xST21K?=
 =?utf-8?B?QmpJWEovN1MvY3R0TFhkSkFNNmZtaTZnWHdSN3ZpRFZNYnlzRzJrZFhuMmNG?=
 =?utf-8?B?UUNVTU1qN0l4NmE0bkgxdHBNR2JCQ3B2R1p0RzhveXIyZXVlK0RDTDE3OURZ?=
 =?utf-8?B?NmxTTVpsblduSksvYlFzM3hzMFZYN0MvRVpVaFdKbEgyd3Y2RzdZdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1468D33F80E90F499AF15C03FBDBB16C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e99755a-c160-441a-6f99-08de90ae2aee
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 11:51:25.1543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mW5Uw9wPWqOLlsZFMcAufrHp/eGEIvnzodwPAzMSULF3T24Pa5YAnAPbvD1mseOcIr14HLQzGt6aCpvaoZ+fzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274507-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[Nvidia.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 7755B388BBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVGh1LCAyMDI2LTA0LTAyIGF0IDEyOjAzICswMjAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IDIwMjYtMDMtMzAsIDE2OjAxOjI3ICswMzAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+ID4g
LSMNCj4gPiAtIyB0ZXN0IGV0aHRvb2wgZmVhdHVyZXMgd2hlbiB0b2dnbGluZyBvZmZsb2FkDQo+
ID4gLSMNCj4gPiAtDQo+ID4gLWlwIGxpbmsgYWRkIGxpbmsgJE5TSU1fTkVUREVWICRNQUNTRUNf
TkVUREVWIHR5cGUgbWFjc2VjIG9mZmxvYWQNCj4gPiBtYWMNCj4gPiAtVE1QX0ZFQVRTX09OXzE9
IiQoZXRodG9vbCAtayAkTUFDU0VDX05FVERFVikiDQo+ID4gLQ0KPiA+IC1pcCBsaW5rIHNldCAk
TUFDU0VDX05FVERFViB0eXBlIG1hY3NlYyBvZmZsb2FkIG9mZg0KPiA+IC1UTVBfRkVBVFNfT0ZG
XzE9IiQoZXRodG9vbCAtayAkTUFDU0VDX05FVERFVikiDQo+ID4gLQ0KPiA+IC1pcCBsaW5rIHNl
dCAkTUFDU0VDX05FVERFViB0eXBlIG1hY3NlYyBvZmZsb2FkIG1hYw0KPiA+IC1UTVBfRkVBVFNf
T05fMj0iJChldGh0b29sIC1rICRNQUNTRUNfTkVUREVWKSINCj4gPiAtDQo+ID4gLVsgIiRUTVBf
RkVBVFNfT05fMSIgPSAiJFRNUF9GRUFUU19PTl8yIiBdDQo+ID4gLWNoZWNrICQ/DQo+IFsuLi5d
DQo+ID4gLVRNUF9GRUFUU19PRkZfMj0iJChldGh0b29sIC1rICRNQUNTRUNfTkVUREVWKSINCj4g
PiAtWyAiJFRNUF9GRUFUU19PRkZfMSIgPSAiJFRNUF9GRUFUU19PRkZfMiIgXQ0KPiA+IC1jaGVj
ayAkPw0KPiBbLi4uXQ0KPiA+IC1UTVBfRkVBVFNfT05fMz0iJChldGh0b29sIC1rICRNQUNTRUNf
TkVUREVWKSINCj4gPiAtWyAiJFRNUF9GRUFUU19PTl8xIiA9ICIkVE1QX0ZFQVRTX09OXzMiIF0N
Cj4gPiAtY2hlY2sgJD8NCj4gDQo+IFRob3NlIGZlYXR1cmUgY29tcGFyaXNvbnMgYXJlIG1pc3Np
bmcgaW4gdGhlIG5ldyBweXRob24gdGVzdC4gVGhlDQo+IHJlc3QNCj4gb2YgdGhlIHBhdGNoIGxv
b2tzIGdvb2QuDQo+IA0KDQpUaGFua3MsDQpJIGFtIG5vdCBzdXJlIHdoeSB0aG9zZSBhcmUgbWlz
c2luZy4gSSB2YWd1ZWx5IHJlbWVtYmVyIGhhdmluZyB0aGVtIGF0DQpzb21lIHBvaW50LCB0aGVy
ZSB3ZXJlIGlzc3VlcywgSSB0aHJldyB0aGVtIG91dCB0aGlua2luZyB0aGVyZSdzIG5vdA0KbXVj
aCB2YWx1ZSBpbiBjaGVja2luZyB0aGF0IGFsbCBuZXRkZXYgZmVhdHVyZXMgZG9uJ3QgY2hhbmdl
ICh0aGUgdGVzdHMNCmJhc2ljYWxseSBkb24ndCBkZWFsIHdpdGggb25seSBtYWNzZWMpLg0KDQpJ
IGFkZGVkIHRoZW0gYmFjayBpbiB2Ny4NCg0KQ29zbWluLg0K

